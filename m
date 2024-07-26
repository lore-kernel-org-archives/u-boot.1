Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50187C3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:45:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ED9CF88645;
	Fri, 26 Jul 2024 14:44:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="B9m+dqHt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 784F4866EE; Fri, 26 Jul 2024 14:39:13 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F12E38853E
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 14:39:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-52f04b3cb33so2785043e87.0
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 05:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721997546; x=1722602346; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5udsCn1HFBV0RAIY43AnjGeYEyZhy2Gna7aenX6YWG8=;
 b=B9m+dqHtA9z9Zlngsg6lfr+qqHWS30J/TwECZxDbcjf6bLH++zvoanp5zUqXVVHju/
 kCNh1d5skYoAH8Z/IWsgUwHvdbvdw6t8qeeCvplsiEADncNC3f9mY0dy8UuRkA0JWCeo
 iijYz/KwC1v/x4ktDSfORLGICXA3pkMjapvdW0bbM/5G0ngxjp0Z1/w/i0Kq5UtN9AIp
 pSEOlSXKCAhxSPB81pF+tZH8Q2haPKmoE7N6A3NqZfWmfOpwV4LEKwkzDXTonPvgGbQ2
 3I10UPYr0IEwcufzamhBNyA8cH7HUERhWLF65O7nI8vqAyUo1A5LE5dZAQQtowFhCyvN
 dn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721997546; x=1722602346;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5udsCn1HFBV0RAIY43AnjGeYEyZhy2Gna7aenX6YWG8=;
 b=iBO4vWmRKWOMrQmhodbhtI9m89Y9qTj2kRavJfnW8XnTej1Elooc3V1MCcuO+pZwFS
 kmQSJSIxZqqET4ZCXDIE06iS0bP1NADTGxmBZbQTrg69VLFgv+9i9vnsLSLS8pMtThiq
 tFNNnjKu9JoM3NXBaJ50F5J9wIIxlQZTU0Ft4uzUFVRAKVSMumWKtGXlHk8WTjGtSRa6
 lOntnXo9FI+9txiEBt2tN7E9xC4wJ0qAbwNdWQRN1DnzJZvqQHQ+W5PiluOou1R88OWb
 inaEkG1tVFq04OyeDRJ4tqNNyVnSZXf0G+fW+qEGeSn++06ddYNdg6qOr4l78YWJkE1U
 VebQ==
X-Gm-Message-State: AOJu0YygoGFxE+HUNucDuoo+DZWIGttoGoxXfKm4NY4uxAaXpFHe5Qqh
 FaRd95N5VS1yunyBp7eZ82/W0zf9U577W1+w01Jvgg4bn1jBaLUe01C4SZhFG5g=
X-Google-Smtp-Source: AGHT+IHlo1jao9lXRdPaOXO6ipvfh2MiOH/a0IXIwiVPVVQk9md0ZUZ8gCKlsD+zsegp/snNU7rGUA==
X-Received: by 2002:a05:6512:1383:b0:52c:dd94:bda9 with SMTP id
 2adb3069b0e04-52fd6092967mr4817798e87.56.1721997546345; 
 Fri, 26 Jul 2024 05:39:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa?
 ([2a01:e0a:3cb:7bb0:ef99:2dfc:dad:83fa])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad92ffbsm173115566b.171.2024.07.26.05.39.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jul 2024 05:39:06 -0700 (PDT)
Message-ID: <c4550407-cba6-4fb7-a065-9a99ce882174@linaro.org>
Date: Fri, 26 Jul 2024 14:39:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/20] net: introduce alternative implementation as
 net-lwip/
To: Michal Simek <monstr@monstr.eu>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bo Gan <ganboing@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 John Keeping <jkeeping@inmusicbrands.com>, Shengyu Qu
 <wiagn233@outlook.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng@tinylab.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>, Samuel Holland
 <samuel@sholland.org>, Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>, Ion Agorria <ion@agorria.com>,
 Yang Xiwen <forbidden405@outlook.com>, Boon Khai Ng
 <boon.khai.ng@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
 <CAHTX3dJAWUQXngpVfyQETnxT32cpq8JnscUcnnZAN-Ji_amkEw@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAHTX3dJAWUQXngpVfyQETnxT32cpq8JnscUcnnZAN-Ji_amkEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jul 2024 14:43:57 +0200
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 7/26/24 10:44, Michal Simek wrote:
> čt 25. 7. 2024 v 15:28 odesílatel Jerome Forissier
> <jerome.forissier@linaro.org> napsal:
>>
>> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
>> adding a new net/lwip/ directory and the NET_LWIP symbol. Network
>> support is either NO_NET, NET (legacy stack) or NET_LWIP. Subsequent
>> commits will introduce the lwIP code, re-work the NETDEVICE integration
>> and port some of the NET commands and features to lwIP.
>>
>> SPL_NET cannot be enabled when NET_LWIP=y. SPL_NET pulls some symbols
>> that are part of NET (such as arp_init(), arp_timeout_check(),
>> arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
>> added later.
>>
>> Similarly, DFU_TFTP and FASTBOOT are not compatible with NET_LWIP
>> because of dependencies on net_loop(), tftp_timeout_ms,
>> tftp_timeout_count_max and other NET things. Let's add a dependency on
>> !NET_LWIP for now.
>>
>> As for SANDBOX, NET_LWIP cannot be used either because of strong
>> assumptions on the network stack. Make NET_LWIP depend on !SANDBOX so
>> that the NET_LWIP alternative is not visible in make menuconfig when
>> sandbox_defconfig is used.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> ---
>>  Kconfig                    | 26 ++++++++++++++++++++++++++
>>  common/Kconfig             |  2 +-
>>  common/spl/Kconfig         |  1 +
>>  drivers/dfu/Kconfig        |  1 +
>>  drivers/fastboot/Kconfig   |  1 +
>>  drivers/net/Kconfig        |  1 +
>>  drivers/net/phy/Kconfig    |  2 +-
>>  drivers/usb/gadget/Kconfig |  2 +-
>>  net/Kconfig                | 29 +++++++++++++++--------------
>>  net/Makefile               |  4 ++++
>>  net/lwip/Kconfig           | 36 ++++++++++++++++++++++++++++++++++++
>>  11 files changed, 88 insertions(+), 17 deletions(-)
>>  create mode 100644 net/lwip/Kconfig
>>
>> diff --git a/Kconfig b/Kconfig
>> index 82df59f176e..61bc6529617 100644
>> --- a/Kconfig
>> +++ b/Kconfig
>> @@ -745,6 +745,32 @@ source "dts/Kconfig"
>>
>>  source "env/Kconfig"
>>
>> +choice
>> +       prompt "Networking stack"
>> +       default NET
>> +
>> +config NO_NET
>> +       bool "No networking support"
>> +
>> +config NET
>> +       bool "Legacy U-Boot networking stack"
>> +       imply NETDEVICES
>> +
>> +config NET_LWIP
>> +       bool "Use lwIP for networking stack"
>> +       imply NETDEVICES
>> +       depends on !SANDBOX
>> +       help
>> +         Include networking support based on the lwIP (lightweight IP)
>> +         TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
>> +         the default U-Boot network stack and applications located in net/
>> +         and enabled via CONFIG_NET as well as other pieces of code that
>> +         depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
>> +         Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
>> +         exclusive.
>> +
>> +endchoice
>> +
>>  source "net/Kconfig"
>>
>>  source "drivers/Kconfig"
>> diff --git a/common/Kconfig b/common/Kconfig
>> index 4bb9f08977a..1daa495080a 100644
>> --- a/common/Kconfig
>> +++ b/common/Kconfig
>> @@ -424,7 +424,7 @@ config LOGF_FUNC_PAD
>>
>>  config LOG_SYSLOG
>>         bool "Log output to syslog server"
>> -       depends on NET
>> +       depends on NET || NET_LWIP
>>         help
>>           Enables a log driver which broadcasts log records via UDP port 514
>>           to syslog servers.
>> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
>> index af43b5f5d3c..2731849841a 100644
>> --- a/common/spl/Kconfig
>> +++ b/common/spl/Kconfig
>> @@ -1063,6 +1063,7 @@ config SPL_DM_SPI_FLASH
>>
>>  config SPL_NET
>>         bool "Support networking"
>> +       depends on !NET_LWIP
>>         help
>>           Enable support for network devices (such as Ethernet) in SPL.
>>           This permits SPL to load U-Boot over a network link rather than
>> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
>> index 971204758aa..d034b501360 100644
>> --- a/drivers/dfu/Kconfig
>> +++ b/drivers/dfu/Kconfig
>> @@ -20,6 +20,7 @@ config DFU_WRITE_ALT
>>  config DFU_TFTP
>>         bool "DFU via TFTP"
>>         depends on NETDEVICES
>> +       depends on !NET_LWIP
>>         select UPDATE_COMMON
>>         select DFU_OVER_TFTP
>>         help
>> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
>> index 70207573de2..1eb460f5a02 100644
>> --- a/drivers/fastboot/Kconfig
>> +++ b/drivers/fastboot/Kconfig
>> @@ -1,5 +1,6 @@
>>  menu "Fastboot support"
>>         depends on CMDLINE
>> +       depends on !NET_LWIP
>>
>>  config FASTBOOT
>>         bool
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index b4ff033afa9..d332f712a7c 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -48,6 +48,7 @@ config DM_DSA
>>         bool "Enable Driver Model for DSA switches"
>>         depends on DM_MDIO
>>         depends on PHY_FIXED
>> +       depends on !NET_LWIP
>>         help
>>           Enable driver model for DSA switches
>>
>> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
>> index 73064b2af68..75986162914 100644
>> --- a/drivers/net/phy/Kconfig
>> +++ b/drivers/net/phy/Kconfig
>> @@ -11,7 +11,7 @@ config MV88E6352_SWITCH
>>
>>  menuconfig PHYLIB
>>         bool "Ethernet PHY (physical media interface) support"
>> -       depends on NET
>> +       depends on NET || NET_LWIP
>>         help
>>           Enable Ethernet PHY (physical media interface) support.
>>
>> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
>> index 4621a6fd5e6..03fe3bca197 100644
>> --- a/drivers/usb/gadget/Kconfig
>> +++ b/drivers/usb/gadget/Kconfig
>> @@ -224,7 +224,7 @@ endif # USB_GADGET_DOWNLOAD
>>
>>  config USB_ETHER
>>         bool "USB Ethernet Gadget"
>> -       depends on NET
>> +       depends on NET || NET_LWIP
>>         default y if ARCH_SUNXI && USB_MUSB_GADGET
>>         help
>>           Creates an Ethernet network device through a USB peripheral
>> diff --git a/net/Kconfig b/net/Kconfig
>> index 5dff6336293..952690d677d 100644
>> --- a/net/Kconfig
>> +++ b/net/Kconfig
>> @@ -2,11 +2,6 @@
>>  # Network configuration
>>  #
>>
>> -menuconfig NET
>> -       bool "Networking support"
>> -       default y
>> -       imply NETDEVICES
>> -
> 
> I looked at menuconfig and saw that so many network options are on the
> first screen.
> TBH It doesn't look nice and I think it should be hidden in any menu.

True. I have introduced a new "Networking" top-level menu in v6.

Main page:

         Device Tree Control  --->
         Environment  --->
         Networking  --->
         Device Drivers  --->
 

In "Networking" when legacy stack is selected:

         Networking stack (Legacy U-Boot networking stack)  --->
     (5000) Milliseconds before trying ARP again
     (5) Number of timeouts before giving up
     [ ] Enable generic udp framework
     [ ] Send hostname to DNS server
     [ ] Random ethaddr if unset
     ...
 
or when lwIP is selected:

         Networking stack (Use lwIP for networking stack)  --->
     [ ] Enable debug traces in the lwIP library
     [ ] Enable assertions in the lwIP library
     -*- DHCP support in lwIP
     [*] TCP SACK support
     [*] Enable bootdev for ethernet
     (1468) TFTP block size
     (4) Number of receive packet buffers

> 
>   │ │        Environment  --->
>      │ │
>   │ │        Networking stack (Legacy U-Boot networking stack)  --->
>      │ │
>   │ │    (5000) Milliseconds before trying ARP again
>      │ │
>   │ │    (5) Number of timeouts before giving up
>      │ │
>   │ │    [ ] Enable generic udp framework
>      │ │
>   │ │    [ ] Send hostname to DNS server
>      │ │
>   │ │    [*] Random ethaddr if unset
>      │ │
>   │ │    [*] NetConsole support
>      │ │
>   │ │    [ ] Support IP datagram reassembly
>      │ │
>   │ │    [*] Echo the inverted Ethernet link state to the fault LED
>      │ │
>   │ │    [ ] Set TFTP UDP source/destination ports via the environment
>      │ │
>   │ │    (1) TFTP window size
>      │ │
>   │ │    [ ] Track TFTP transfers based on file size option
>      │ │
>   │ │    [ ] Get serverip value from Proxy DHCP response
>      │ │
>   │ │    (100) # of additional milliseconds to wait for ProxyDHCP
> response  │ │
>   │ │    [ ] Write the server's MAC address to 'serveraddr'
>      │ │
>   │ │    [ ] Check the UDP checksum
>      │ │
>   │ │    [ ] Use the 'serverip' env var for tftp, not bootp
>      │ │
>   │ │    (64) Option 17 root path length
>      │ │
>   │ │    [ ] Set a default 'gateway' value in the environment
>      │ │
>   │ │    [ ] Set a default 'ipaddr' value in the environment
>      │ │
>   │ │    [ ] Set a default 'netmask' value in the environment
>      │ │
>   │ │    [ ] Set a default 'rootpath' value in the environment
>      │ │
>   │ │    [ ] Set a default 'serverip' value in the environment
>      │ │
>   │ │    -*- TCP stack
>      │ │
>   │ │    [ ]   TCP SACK support
>      │ │
>   │ │    [ ] IPv6 support
>      │ │
>   │ │    [ ] Enable debug traces in the lwIP library
>      │ │
>   │ │    [ ] Enable assertions in the lwIP library
>      │ │
>   │ │    [*] Enable bootdev for ethernet
>      │ │
>   │ │    (4) Number of receive packet buffers
>      │ │
>   │ │    (1468) TFTP block size
>      │ │
>   │ │        Device Drivers  --->
>      │ │
>   │ │        File systems  --->
> 
> M

Thanks,
-- 
Jerome
