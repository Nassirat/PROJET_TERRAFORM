terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {}

# Pull l'image Docker
resource "docker_image" "ubuntu_ssh" {
  name = "fredericeducentre/ubuntu-ssh"
}

# Crée le conteneur Docker pour Jenkins basé sur l'image Ubuntu SSH
resource "docker_container" "jenkins" {
  name  = "jenkins"
  image = docker_image.ubuntu_ssh.image_id

  # Expose le port SSH du conteneur et le port pour Jenkins
  ports {
    internal = 22
    external = 2222  # Port externe pour la connexion SSH
  }
  ports {
    internal = 8080
    external = 8084  # Port externe pour Jenkins UI
  }
  memory = 2048
}

# Crée le conteneur Docker pour SonarQube basé sur l'image Ubuntu SSH
resource "docker_container" "sonarqube" {
  name  = "sonarqube"
  image = docker_image.ubuntu_ssh.image_id

  # Expose le port SSH du conteneur et le port pour SonarQube
  ports {
    internal = 22
    external = 2223  # Port externe pour la connexion SSH
  }
  ports {
    internal = 9000
    external = 9000  # Port externe pour SonarQube UI
  }
  memory = 4096
}  


