#!/bin/bash

# These mirrors must be added to /etc/apt/sources.list

#deb http://deb.debian.org/debian buster main contrib non-free
#deb-src http://deb.debian.org/debian buster main contrib non-free

#deb http://deb.debian.org/debian-security/ buster/updates main contrib non-free
#deb-src http://deb.debian.org/debian-security/ buster/updates main contrib non-free

#deb http://deb.debian.org/debian buster-updates main contrib non-free
#deb-src http://deb.debian.org/debian buster-updates main contrib non-free

set -o errexit

#installing steamcmd for a 64bit Debian system
apt update
dpkg --add-architecture i386
apt update
apt install lib32gcc1 steamcmd libsdl2-2.0-0:i386 git wget


#link the steamcmd executable
ln -s /usr/games/steamcmd steamcmd

#create a steam user
echo 'creating new user called steam. Please enter password: '
useradd -m -s /bin/bash -G sudo steam
passwd steam
su steam

#clone repo into home for steam user
cd
git clone https://github.com/ludicrulous/arma3.git

#ask for steam username
echo 'Please enter steam username: '
read varname

#login to steam, set the install directory and download the game files & download workshop items
#Important note: the steamcmd scripts gets broken by Windows. Only edit in Linux otherwise it will not work!
/usr/games/steamcmd +login $varname +force_install_dir ./arma3/ +app_update 233780 validate +runscript ~/arma3/antistasi_mods +quit

#TODO: steamapps folders have to be renamed into @name and copied into the arma3 installation directory

cp ~/arma3/start_server ~/.steam/steamcmd/arma3/
cp ~/arma3/server.cfg ~/.steam/steamcmd/arma3/

#copy the antistasi pbo file into the arma/mpmissions directory
wget https://github.com/official-antistasi-community/A3-Antistasi/releases/download/2.3.2/Antistasi-Altis-2-3-2.Altis.pbo
cp Antistasi-Altis-2-3-2.Altis.pbo .steam/steamcmd/arma3/mpmissions/