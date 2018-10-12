variable "resource_group_name" {
  description = "Logical containers for a collection of resources that can be treated as one logical instance"
}

variable "location" {
  description = "The region where to deploy the resource/infrastructure (e.g. East US)."
  default     = "West Europe"
}


variable "subnet_id" {
    description = "describe your variable"
}

variable "diskvhdname" {
	default = "jenkins-master-vhd.vhd"
}

variable "vm_username" {
  description = "describe your variable"
}

variable "vm_password"{
  description = "describe your variable"
}

variable "disk_name" {
    description = "describe your variable"
}

variable "computer_name" {
  type        = "string"
  description = "describe your variable"
  default = "jenkinsMasterVM"

}
// VM
variable "vm_size" {
  type        = "string"
  description = "VM size"
  default     = "Standard_D2s_v3"
}


variable "deploy_timestamp" {
  type        = "string"
  description = "deploy timestamp  in milliseconds"
}

variable "shell_settings" {
  type        = "map"
  description = "shell settings "
}

variable "protected_settings" {
  type        = "map"
  description = "shell settings "
}

variable "availability_set_id" {
	description = "id of availability set"
}