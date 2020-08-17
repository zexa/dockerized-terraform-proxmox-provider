FROM hashicorp/terraform:0.12.29

RUN apk add git make musl-dev go

RUN mkdir terraform-provider-proxmox \
  && cd terraform-provider-proxmox \
  && git init \ 
  && git remote add origin https://github.com/Telmate/terraform-provider-proxmox.git \
  && git fetch origin f29545047c7e6e271ccf0addf1cce972ce9a3d87 \
  && git reset --hard FETCH_HEAD \
  && go install github.com/Telmate/terraform-provider-proxmox/cmd/terraform-provider-proxmox \
  && go install github.com/Telmate/terraform-provider-proxmox/cmd/terraform-provisioner-proxmox \
  && make \
  && mkdir -p ~/.terraform.d/plugins \
  && cp bin/terraform-provider-proxmox ~/.terraform.d/plugins \
  && cp bin/terraform-provisioner-proxmox ~/.terraform.d/plugins

