# tf-gke

inexpensive personal dev k8s cluster on gke

## reference

https://learn.hashicorp.com/tutorials/terraform/gke

## pre-reqs: 
- gcloud account
- gcloud cli 
- terraform


## setup 
```sh
terraform init
terrafom plan       # validate plan 
terraform apply
```

## get kubectl config
```sh
gcloud container clusters list
gcloud container clusters get-credentials <cludter name> --zone <zone name>
```
