#! /bin/bash

/home/steam/css/srcds_run -game cstrike -secure -port 27015 +exec server.cfg +hostname "$SERVER_NAME" +sv_password "$SERVER_PASSWORD" +rcon_password "$RCON_PASSWORD" +maxplayers 16 +map de_dust2 +ip 0.0.0.0