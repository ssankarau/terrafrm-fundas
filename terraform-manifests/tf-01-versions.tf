# Terraform Settings Block
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.36.0"
     }
  }
}

# Terraform Provider Block
provider "aws" {
  region = "us-east-1"
}