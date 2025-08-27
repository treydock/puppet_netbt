# A puppet class to modify netbt settings in the registry on windows systems
class netbt (
  $netbt_setting = 'dhcp'
){
  case $netbt_setting {
    'enabled':  {
      $netbiosoptions = 1
    }
    'disabled':  {
      $netbiosoptions = 2
    }
    'dhcp': {
      $netbiosoptions = 0
    }
    default: {
      notify {'Invalid option for netbt_setting: Defaulting to DHCP selection':}
      $netbiosoptions = 0
    }
  }
  $facts['interface_guids'].each | $key, $value| {
    registry_value { "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NetBT\\Parameters\\Interfaces\\Tcpip_{${value}}\\NetbiosOptions":
      ensure => present,
      type   => dword,
      data   => $netbiosoptions,
    }
  }
}
