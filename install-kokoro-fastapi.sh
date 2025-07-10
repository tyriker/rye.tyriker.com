#!/bin/bash

current_dir=$(pwd)

echo "install system deps"
[ ! -e /usr/bin/aarch64-linux-gnu-g++ ] && ln -s /usr/bin/aarch64-amazon-linux-g++ /usr/bin/aarch64-linux-gnu-g++

if ! command -v espeak-ng > /dev/null 2>&1; then
    echo "espeak-ng not found, installing..."
    curl -L -O "https://github.com/espeak-ng/espeak-ng/archive/refs/tags/1.52.0.tar.gz"
    tar -xvf 1.52.0.tar.gz
    rm -f 1.52.0.tar.gz
    cd espeak-ng-1.52.0
    ./autogen.sh && ./configure && make && make install
    cd "$current_dir"
    [ ! -e /usr/bin/espeak ] && ln -s /usr/local/bin/espeak /usr/bin/espeak
    [ ! -e /usr/bin/espeak-ng ] && ln -s /usr/local/bin/espeak-ng /usr/bin/espeak-ng
    [ ! -e /usr/bin/speak ] && ln -s /usr/local/bin/speak /usr/bin/speak
    [ ! -e /usr/bin/speak-ng ] && ln -s /usr/local/bin/speak-ng /usr/bin/speak-ng
else
    echo "espeak-ng is already installed."
fi

echo "Install Kokoro FastAPI"
git clone https://github.com/remsky/Kokoro-FastAPI.git

cp kokoro-fastapi.service /usr/lib/systemd/system/kokoro-fastapi.service
systemctl daemon-reload
systemctl enable kokoro-fastapi.service
systemctl start kokoro-fastapi.service

exit 0
