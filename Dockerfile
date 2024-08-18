FROM ubuntu:22.04

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y wget unzip lib32gcc-s1 libncurses5 libncurses5:i386 libsdl2-2.0-0:i386 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    useradd -ms /bin/bash steam

USER steam
WORKDIR /home/steam

RUN wget -O ./steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz && \
    tar -xvzf ./steamcmd_linux.tar.gz && \
    rm ./steamcmd_linux.tar.gz && \
    ./steamcmd.sh +login anonymous +force_install_dir ./css +app_update 232330 validate +quit && \
    mkdir -p /home/steam/.steam && \
    ln -s /home/steam/linux32/ /home/steam/.steam/sdk32

COPY --chmod=664 --chown=steam:steam server.cfg /home/steam/css/cstrike/cfg/server.cfg
COPY --chmod=775 --chown=steam:steam start_server.sh /home/steam/css/start_server.sh

ENV SERVER_NAME="n-css"
ENV SERVER_PASSWORD=""
ENV RCON_PASSWORD=""

ENTRYPOINT /home/steam/css/start_server.sh