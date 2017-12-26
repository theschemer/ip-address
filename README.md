# (ip-address)

The `(ip-address)` library parses and formats IPv4 and IPv6 addresses.
An IPv6 address can actually be written in a great number of ways, and
this has resulted in a recommended textual representation (RFC 5952),
which is implemented by this library.

The IPv6 code does not yet handle embedded IPv4 addresses.

## API

```Scheme
(import (ip-address))
```

### (ipv4->string bytevector)

Converts the IPv4 address *bytevector* to its dotted-decimal string
representation.

### (string->ipv4 string)

Converts the IPv4 address *string* to its bytevector representation.

If the string does not represent an IPv4 address, `#f` is returned.

Note that this only handles the normal dotted-decimal notation. Some
libraries, e.g. the standard C library, provide a function that parses
addresses in octal, hex, and even handles some octets being missing.
This library does none of that. Up to two leading zeroes may be used,
though:

```Scheme
(ipv4->string (string->ipv4 "192.000.002.000"))
;; => "192.0.2.0"
```

### (ipv6->string bytevector)

Converts the IPv6 address *bytevector* to the string representation
recommended by RFC 5952.

```Scheme
(ipv6->string (string->ipv6 "2001:db8:0:0:0:0:0:1"))
;; => "2001:db8::1"
```

### (string->ipv6 string)

Converts the IPv6 address *string* to its bytevector representation.
The input may be in any valid format.

If the string does not represent an IPv6 address, `#f` is returned.

```Scheme
(string->ipv6 "2001:db8:0:0:0:0:1")
;; => #f
```

```Scheme
(string->ipv6 "2001:db8::1")
;; => #vu8(32 1 13 184 0 0 0 0 0 0 0 0 0 0 0 1)
```
