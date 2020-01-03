FROM python

RUN apt-get update && apt-get install -y --no-install-recommends \
		cmake ninja-build \
	&& rm -rf /var/lib/apt/lists/*

ENV IDF_PATH /esp-idf
ENV IDF_TOOLS_PATH=/usr/espressif

COPY ./esp-idf $IDF_PATH
COPY ./version.txt $IDF_PATH/esp-idf/

RUN pip --no-cache-dir --disable-pip-version-check install -r $IDF_PATH/requirements.txt
RUN $IDF_PATH/tools/idf_tools.py install && rm -rf $IDF_TOOLS_PATH/dist
RUN mkdir $IDF_TOOLS_PATH/bin
RUN ln -s $IDF_TOOLS_PATH/tools/*/*/*/bin/* $IDF_TOOLS_PATH/bin
ENV PATH="$IDF_PATH/tools:$IDF_TOOLS_PATH/bin:${PATH}"

CMD ["bash"]
