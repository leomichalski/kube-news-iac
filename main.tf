terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

variable "do_token" {
  type = string
}
variable "k8s_name" {
  type = string
}
variable "region" {
  type = string
}

provider "digitalocean" {
  token = var.do_token
}

resource "digitalocean_kubernetes_cluster" "k8s_kubenews" {
  name   = var.k8s_name
  region = var.region
  # latest slug from the command 'doctl kubernetes options versions'
  version = "1.23.9-do.0"

  node_pool {
    # name       = "worker-pool"
    # size       = "s-1vcpu-2gb"
    # node_count = 2
    name       = "autoscale-worker-pool1"
    size       = "s-1vcpu-2gb"
    auto_scale = true
    min_nodes  = 1
    max_nodes  = 2

  }
}

# # mostrar endpoint apos rodar "kubectl apply"
# # obs: nao usar output para mostrar senhas nem outros dados sensiveis
# output "kube_endpoint" {
#   value = digitalocean_kubernetes_cluster.k8s_kubenews.endpoint
# }

resource "local_file" "kube_config" {
  content  = digitalocean_kubernetes_cluster.k8s_kubenews.kube_config.0.raw_config
  filename = "kube_config.yaml"
}
