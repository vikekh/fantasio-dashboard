#!/bin/bash

# https://docs.docker.com/storage/volumes/#backup-restore-or-migrate-data-volumes

if [ -z "$1" ]; then
    echo "No argument"
    exit 1
fi

# DATE=$(date '+%Y-%m-%d')
# BACKUP_DIR="${1}/${DATE}"
BACKUP_DIR=$1
mkdir $BACKUP_DIR
# rm -r "${BACKUP_DIR}"/*

docker stop homer
docker stop organizr

docker run --rm -v homer-assets:/data -v $BACKUP_DIR:/backup ubuntu tar cvf /backup/homer-assets.tar /data
docker run --rm -v organizr-config:/data -v $BACKUP_DIR:/backup ubuntu tar cvf /backup/organizr-config.tar /data

docker start homer
docker start organizr