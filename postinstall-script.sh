#!/bin/bash

## Instalar actualizaciones
dnf update -y

## Instala Epel
dnf install epel-release -y

## Instala utileris de DNF
dnf install dnf-utils -y

## Instalar Firewall
dnf install firewall-cmd -y

## Agregar reglas de firewall
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent

## Agrega repositorio de Docker
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo

## Instalar Docker 
dnf install docker-ce docker-ce-cli containerd.io -y

## Habilitar Docker y agregar auto inicio de daemon.
systemctl enable --now docker
systemctl start docker

## Instalar y configurar docker-compose

# Instalar v1.12.2
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Instalar v2.2.3
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/v2.2.3/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose
