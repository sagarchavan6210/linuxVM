resource "azurerm_network_interface" "nic" {
  name 						= "${var.computer_name}-nic"
  location 					= "${var.location}"
  resource_group_name 		= "${var.resource_group_name}"

  ip_configuration {
        name                 		  = "${var.computer_name}-ipconfig"
        subnet_id 					  = "${var.subnet_id}"
        private_ip_address_allocation = "Dynamic"
    }

}
# create virtual machine
resource "azurerm_virtual_machine" "vm" {
    name = "${var.computer_name}"
    location = "${var.location}"
    resource_group_name = "${var.resource_group_name}"
    network_interface_ids = ["${azurerm_network_interface.nic.id}"]
    vm_size = "${var.vm_size}"
    availability_set_id = "${var.availability_set_id}"

    storage_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "16.04-LTS"
        version   = "latest"
    }

    storage_os_disk {
        name              = "${var.disk_name}"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Premium_LRS"
    }
    os_profile {
        computer_name  = "${var.computer_name}"
        admin_username = "${var.vm_username}"
        admin_password = "${var.vm_password}"
    }

    os_profile_linux_config {
        disable_password_authentication = false

    }
}
resource "azurerm_virtual_machine_extension" "install_script" {
  name                 = "jenkins-installation"
  location             = "${var.location}"
  resource_group_name  = "${var.resource_group_name}"
  virtual_machine_name = "${azurerm_virtual_machine.vm.name}"
  publisher            = "Microsoft.OSTCExtensions"
  type                 = "CustomScriptForLinux"
  type_handler_version = "1.5"

  settings = <<SETTINGS
  {
  "fileUris": ["${var.shell_settings["fileUris"]}"],
    "commandToExecute": "${var.shell_settings["commandToExecute"]}",
    "timestamp": "${var.deploy_timestamp}"
  }
SETTINGS

  protected_settings = <<SETTINGS
  {
  "storageAccountName": "${var.protected_settings["storageAccountName"]}",
  "storageAccountKey": "${var.protected_settings["storageAccountKey"]}"
  }
SETTINGS

  depends_on = ["azurerm_virtual_machine.vm"]
}
