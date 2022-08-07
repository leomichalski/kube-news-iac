## Como começar o servidor

```
git clone git@github.com:leommiranda/kube-news-iac
cd kube-news-iac
cp path/to/terraform.tfvars terraform.tfvars  # lembrar de alterar o path para o arquivo terraform.tfvars
terraform init
terraform apply
```

## Como rodar manualmente o kube-news no servidor

```
# Após rodar as instruções em "Como começar o servidor"
cd ..
git clone git@github.com:leommiranda/kube-news
kubectl apply -f kube-news/k8s/deployment.yaml --kubeconfig kube-news-iac/kube_config.yaml
kubectl get all --kubeconfig kube-news-iac/kube_config.yaml
```

## Como destruir o servidor

```
kubectl delete -f kube-news/k8s/deployment.yaml --kubeconfig kube-news-iac/kube_config.yaml
terraform destroy
```
