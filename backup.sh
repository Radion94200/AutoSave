#!/bin/sh

RED='\033[0;031m'
GREEN='\033[0;032m'
YELLOW='\033[0;033m'
NC='\033[0m'

filename=$(date +%d-%m-%Y);
mkdir -p "${filename}$1";
mkdir -p "${filename}/Config$1";

echo "${GREEN} --- FILE FOR BACKUP CREATE ---${NC}"

if [ $? -ne 1 ]
then
    cp -r ~/Documents/* ${filename};
    cp -r ~/*.sh ${filename}/Scripts;
    cp -r ~/.vimrc ${filename}/Config/;
    cp -r ~/.bashrc ${filename}/Config/;
    echo "${GREEN} --- COPY IS A SUCCESS ---${NC}"
else
    echo "${RED} --- ERROR DURING THE COPY ---${NC}"
fi

if [ $? -eq 0 ]
then
    tar -cvf ${filename}.tar.gz ${filename};
    echo "${GREEN} --- TAR IS A SUCCESS ---${NC}"
else
    echo "${RED} --- ERROR DURING THE TAR CREATION ---${NC}"
fi

if [ $? -eq 0 ]
then
    sshpass -p "Password" scp ${filename}.tar.gz pi@ipadress:~/Backup/test
    echo "${GREEN} --- COPY IN THE CLOUD IS DONE ---${NC}";
    rm -rf ${filename}*
else
    echo "${RED} --- ERROR DURING THE COPY IN THE CLOUD ---${NC}"
fi
