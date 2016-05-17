class disable_netbt {
  $interface_guids.each | $key, $value| {
    registry_value { "HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NetBT\\Parameters\\Interfaces\\Tcpip_{${value}}\\NetbiosOptions":
      ensure => present,
      type   => dword,
      data   => 2,
    }
  }
}
