#!/bin/bash

#  Starts local mongdb installation.
#  Starts application main.js
#
#  MONGO_URL env variable will prevent local db start
#
set -e

# set default meteor values if they arent set
: ${PORT:="80"}
: ${ROOT_URL:="http://localhost"}
: ${MONGO_URL:="mongodb://127.0.0.1:27017/meteor"}

#start mongodb (optional)
if [[ "${MONGO_URL}" == *"127.0.0.1"* ]]; then
  if [ "${INSTALL_MONGO}" = "false" ]; then
    echo "ERROR: Mongo not installed inside container. Rebuild with INSTALL_MONGO=true"
    exit 1
  fi
  # start mongodb
  printf "\n[-] Starting local MongoDB...\n\n"
  mongod --smallfiles --fork --logpath /var/log/mongodb.log
fi

if [[ "${REACTION_ENVIRONMENT}" == "dev" ]]; then
  # DEV
  # run reaction from source
  /var/www/src/reaction reset
  /var/www/src/reaction
else
  # PROD
  # Run meteor
  exec node ./main.js
fi

