terraform {
  required_version = ">= 0.11.1"
}

module "windowsserver" {
  source              = "Azure/compute/azurerm"
  version             = "1.1.5"
  location            = "${var.location}"
  resource_group_name = "${var.environment}-rg"
  vm_hostname         = "${var.environment}"
  admin_password      = "${var.admin_password}"
  vm_os_simple        = "WindowsServer"
  public_ip_dns       = ["${var.windows_dns_prefix}"]
  vm_size             = "${var.vm_size}"
  vnet_subnet_id      = "${module.network.vnet_subnets[0]}"
}

module "network" {
  source              = "Azure/network/azurerm"
  version             = "1.1.1"
  location            = "${var.location}"
  resource_group_name = "${var.environment}-rg"
  allow_ssh_traffic   = true
}

output "windows_vm_public_name"{
  value = "${module.windowsserver.public_ip_dns_name}"
}
