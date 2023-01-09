FROM ubuntu:latest

RUN apt-get update && \
  apt-get install -y wget unzip curl git

# Install gruntwork-installer, which is the preferred method for installing Gruntwork binaries and modules
RUN curl -LsS https://raw.githubusercontent.com/gruntwork-io/gruntwork-installer/v0.0.38/bootstrap-gruntwork-installer.sh | bash /dev/stdin --version v0.0.38 --no-sudo true

# Terraform
ARG TERRAFORM_VERSION=1.2.4
RUN wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip && unzip terraform_${TERRAFORM_VERSION}_linux_amd64.zip && mv terraform /usr/local/bin

# Terragrunt
ARG TERRAGRUNT_VERSION=0.38.4
RUN gruntwork-install --repo "https://github.com/gruntwork-io/terragrunt" --binary-name "terragrunt" --tag v${TERRAGRUNT_VERSION} --no-sudo true

# AWS cli
RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o aws_cli.zip && unzip aws_cli.zip && ./aws/install
