FROM alpine:3.6

RUN \
    apk add --no-cache \
    dumb-init \
    git \
    cmake \
    gcc \
    g++ \
    make \
    musl-dev \
    binutils \
    clang-dev \
    clang-static \
    llvm4-dev \
    llvm4-static \
    ncurses-dev \
    zlib-dev

WORKDIR /tmp/iwyu
RUN \
    git clone https://github.com/include-what-you-use/include-what-you-use.git . && \
    git checkout clang_4.0 && \
    mkdir build && cd build && \
    cmake -G "Unix Makefiles" -DIWYU_LLVM_ROOT_PATH=/usr/lib/llvm4 ../ && \
    make && \
    make install

WORKDIR /root
RUN \
    rm -rf /tmp/iwyu

ENTRYPOINT ["dumb-init"]
