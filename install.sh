##ssh ec2-user@3.69.50.252 -i id_student "sudo bash -s" < install.sh

#!/bin/bash

NAME="Seba"
REPOSITORY=https://github.com/jkanclerz/computer-programming-4-2024.git
TMP_DESTINATION=/tmp/ecommerce
VERSION=main

APP_USERNAME=ecommerce
APP_DEST=/opt/ecommerce


echo "Hello ${NAME}"

#  Install base OS dependencies

dnf install -y -q cowsay tree mc

## GIT && repository
dnf install -y -q git
rm -rf ${TMP_DESTINATION} || true
git clone ${REPOSITORY} -b ${VERSION} ${TMP_DESTINATION}

#Java runtime
dnf install -y -q java-17-amazon-corretto maven-local-amazon-corretto17

#Create dir & user
adduser ${APP_USERNAME}
mkdir -p ${APP_DEST}

#Compile && Package
cd ${TMP_DESTINATION} && mvn -DskipTests package
mv ${TMP_DESTINATION}/target/*.jar ${APP_DEST}/app.jar
chown -R ${APP_USERNAME}:${APP_USERNAME} ${APP_DEST}
rm -rf ${TMP_DESTINATION}
echo "java -jar -Dserver.port=8080 /opt/ecommerce/app.jar"
echo "Skrypt wykonany poprawnie"