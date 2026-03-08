FROM python:3.11

RUN apt-get update && apt-get upgrade -y

# Install requirements
RUN apt-get install -y build-essential cmake git wget

# Install GStreamer
RUN apt-get install -y gstreamer1.0* libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev

RUN python3.11 -m pip install numpy

# Clone, build and install OpenCV
RUN git clone https://github.com/opencv/opencv.git && \
    cd /opencv && mkdir build && cd build && \
    cmake -D CMAKE_BUILD_TYPE=Release \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D WITH_GSTREAMER=ON \
        -D WITH_QT=OFF \
        -D WITH_GTK=OFF \
        -D BUILD_opencv_apps=OFF \
        -D BUILD_EXAMPLES=OFF \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D BUILD_DOCS=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D BUILD_TESTS=OFF \
        -D BUILD_opencv_python2=OFF \
        -D BUILD_opencv_python3=ON \
        -D PYTHON_VERSION=311 \
        -D PYTHON_DEFAULT_EXECUTABLE=/usr/local/bin/python3.11 \
        -D PYTHON3_EXECUTABLE=/usr/local/bin/python3.11 \
        -D OPENCV_PYTHON3_INSTALL_PATH=/usr/local/lib/python3.11/site-packages \
        .. && \
    make -j"$(nproc)" && \
    make install && \
    rm -rf /opencv


RUN git clone https://github.com/ConnorFeeney/MLBuilder
RUN python3.11 -m pip install --no-cache-dir -e MLBuilder
