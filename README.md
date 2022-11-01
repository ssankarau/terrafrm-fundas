# Concepts Applied Here
## Terraform and Provider info
> `terraform.lock.hcl` file generated during `terraform init`. 
> It holds the provider metadata(hash)
> It generates .terraform folder contains the provider which will be the bridge between terraform and the provider environment.

## Variables and Locals
> values assignment can be defined in multiple places.
> example variables.tf files 
```
variable "vpc_name" {
  description = "VPC Name"
  type = string 
  default = "myvpc"
}
```
> the above value can be overridden by `<x>.auto.tfvars` file values.
> `terraform.tfvars` usually used to declare generic/common variables. whereas the auto.tf vars will be specific to modules.
> Locals usually used to declare the computed values and most frequently used values. locals will override all the variables defined.
```
locals {
  name = "${var.business_divsion}-${var.environment}"
}
```

## Data Source
> data source helps move from statically defined to dynamic. 
> Below example shows the az list.
```
# DS to get all the az available in the region
data "aws_availability_zones" "available" {  
  #state = "available"
}
# Usage : lists all the avaialble azs
azs = data.aws_availability_zones.available.names
```
> similarly we can get the lastet ami id from aws instead of hardcoded one.
[Terraform-DataSource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-source)

## Modules
> It is a reusable component with multiple resources to describe our infra better.
> A .tf file contains a resource defined is the root module.
> root module can call the other modules called child modules. 
> modules can be local or published in registry. terraform contains more modules supported by terraform, providers, community.
```
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.11.0"
  ...
}
```
> when we create a module 3 major files are required.
> `main.tf` - contains all the resource defns.
> `variables.tf` - contains the variables required for the resources.
> `output.tf` - contains the variable we want to output from the resources. this will be used as input to other moduels. 


## Meta Arguments
> they helps us in achieving certain requirements within the resource block
> some are `depends_on`, `count`, `for_each`
> `depends_on` meta-argument to explicitly define the dependency
> `count` will create a resource number of times
> `for_each` meta argument accepts a map or set of strings. Terraform will create one instance of that resource for each member of that map or set
#### Example
`depends_on = [module.ec2_public, module.vpc ]`

## Null provider, Null Resource, Null Data Source
>null provider intentionaly does nothing(means doesn't interact with any provider) but useful for some work-around solutions. same applies for null resource(means doesn't create any resource) and null data source(means doesn't interact with any external API).


## Provisioners
> to execute specific actions on the local machine or on a remote machine in order to prepare servers
> `connection` block used to connect to servers by provisioners
> some of provisioners are : 
> `file` - copies file from local machine to remote.
> `local-exec` - execute commands on a local machine.
> `remote-exec` - execute commands on remote machine.

## Terraform State
> When you execute `terraform apply` command, the `terraform.tfstate` file will be created. 
> it contains the state of the resources created on the provider env.
> It is considered as the desired state. any changes to the provider env externally will be replaced on the apply the terraform apply again.

