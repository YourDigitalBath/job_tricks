#!/bin/bash


# Start this script with root privelegies!

apt update -y && apt upgrade -y
apt install -y atop htop mc net-tools dialog


sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc


echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update -y && apt upgrade -y

# install 
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo "docker + docker-compose installed"


echo "full update and install docker + docker compose plugin complete"

apt autoclean -y && apt autoremove -y
# dnf clean all -y


docker --version
systemctl enable docker && systemctl restart docker
echo "docker started and running"


# created docker-compose.yml

# choose your comfortable path
cd /home/administrator
touch docker-compose.yml



echo "

services:

  db:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: wiki
      POSTGRES_PASSWORD: wikijsrocks
      POSTGRES_USER: wikijs
    logging:
      driver: "none"
    restart: unless-stopped
    volumes:
      - db-data:/var/lib/postgresql/data

  wiki:
    image: ghcr.io/requarks/wiki:2
    depends_on:
      - db
    environment:
      DB_TYPE: postgres
      DB_HOST: db
      DB_PORT: 5432
      DB_USER: wikijs
      DB_PASS: wikijsrocks
      DB_NAME: wiki
    restart: unless-stopped
    ports:
      - "80:3000"

volumes:
  db-data: " > docker-compose.yml



chmod +x docker-compose.yml
echo "created docker-compose.yml"

docker compose up -d

echo "container up!"



