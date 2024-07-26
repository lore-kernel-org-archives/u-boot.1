Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91FEEC3DA7F
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 12:44:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9D428858C;
	Fri, 26 Jul 2024 14:43:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="o6mHMoAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DC11884C5; Fri, 26 Jul 2024 10:44:44 +0200 (CEST)
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com
 [IPv6:2607:f8b0:4864:20::b33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA30D884A9
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:44:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: phobos.denx.de; spf=none smtp.mailfrom=monstr@monstr.eu
Received: by mail-yb1-xb33.google.com with SMTP id
 3f1490d57ef6-e087264e297so1704337276.3
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1721983479; x=1722588279;
 darn=lists.denx.de; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fJGaWfOL0s7TixI7IjAB2mfxUl1qBTVTQs4Ks2FuCn4=;
 b=o6mHMoAh4WeqbadmmSwHSeSNgjoRg6yRSQ4MkU1Nbkcyq0HzXmFWYweU+xPNQwTHCI
 ci0MY7PhXgkULvBJ5V6vNgK6c2FWLGcWA40YdJDV7sNUzZr6+6+YvnP7M8u3uV9aMW8c
 95cIH9DsHzirIxFjG7zCjlAHQcudOLPtLWHNrMX5FS6ra680I0dpy3P6qyT3BkwItrpO
 PyYdsCtrTWnGJ42RTgZXGqtsbZqDGdCxm3cA/mQ5eQxWhJyVX0k5t1sfEj0K/nItGgeM
 5Ug1JAQYLxilLZhTQshVIFbqPO3GXE/sBfoPwRc1hFad9rvTg37rdUQ+JSvoUe5Ux2S9
 5cAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721983479; x=1722588279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fJGaWfOL0s7TixI7IjAB2mfxUl1qBTVTQs4Ks2FuCn4=;
 b=ohoOEgVO5/3ptUlTP3nBoRLhObet7Xjh2bOvwzqsHhhvP1y7xpkWkwZQxEj0W5J25W
 ZviZ4tWOiYH0/ZaFXsC7xEIO+im4WdYWsEIZsoDTzevHTZRsSTu7NgFP7vXCtm0aC4Pn
 IBkEpCQ5NrPxSBT6Q6rXVeelCzCGx1ALUX/VdXFmwkaVl0H/Bu8ZPN5Em0VaEfS8GdpD
 3jjZuLN8IO/Kp8VT/hY/ifsimq+Is9JVZuTN1oNgoMYwSEy2Gf0i/BrPAmMXxtrIr1lQ
 Fq3vh+nL0FGNEbwmjWO8mufMaT9dAH8Tv4B+Bp90B4G5nVfhW6cbRc3vM9R+PvAmQgue
 ZY/w==
X-Gm-Message-State: AOJu0YxcGgEy36FP8V1z3u7NOaVqHT2kCYt811ou2FdjFk9idUSDB3eO
 70P6lgZVvypQDMB+iwi/bfNIuENWM+zAQz6sLjuy6gKLo5WrHnhhE8WZsGK3EwzAurZtDUklkZ4
 ouZJ/cZKPdMVJMiRyvyz2bufBFixd2qkq5diP
X-Google-Smtp-Source: AGHT+IGpLcRtOW+jTmFpHBVLwcT1l0dDCYfnaRUI5XH0ic+Ml81tsmZQ9Fb94PW/Q4ArzQTn/1CEe3f/L7D2tZX65SE=
X-Received: by 2002:a05:6902:2845:b0:e06:c34c:b0b4 with SMTP id
 3f1490d57ef6-e0b2cdbf1cemr4408539276.53.1721983479451; Fri, 26 Jul 2024
 01:44:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
In-Reply-To: <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
From: Michal Simek <monstr@monstr.eu>
Date: Fri, 26 Jul 2024 10:44:28 +0200
Message-ID: <CAHTX3dJAWUQXngpVfyQETnxT32cpq8JnscUcnnZAN-Ji_amkEw@mail.gmail.com>
Subject: Re: [PATCH v5 02/20] net: introduce alternative implementation as
 net-lwip/
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Maxim Uvarov <muvarov@gmail.com>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, 
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>, 
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, 
 Bo Gan <ganboing@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Greg Malysa <greg.malysa@timesys.com>,
 John Keeping <jkeeping@inmusicbrands.com>, 
 Shengyu Qu <wiagn233@outlook.com>, Stefan Roese <sr@denx.de>, 
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng@tinylab.org>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, 
 Sean Anderson <sean.anderson@seco.com>, Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>, 
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Alexey Romanov <avromanov@salutedevices.com>, Ion Agorria <ion@agorria.com>, 
 Yang Xiwen <forbidden405@outlook.com>, Boon Khai Ng <boon.khai.ng@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Baruch Siach <baruch@tkos.co.il>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

=C4=8Dt 25. 7. 2024 v 15:28 odes=C3=ADlatel Jerome Forissier
<jerome.forissier@linaro.org> napsal:
>
> Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
> adding a new net/lwip/ directory and the NET_LWIP symbol. Network
> support is either NO_NET, NET (legacy stack) or NET_LWIP. Subsequent
> commits will introduce the lwIP code, re-work the NETDEVICE integration
> and port some of the NET commands and features to lwIP.
>
> SPL_NET cannot be enabled when NET_LWIP=3Dy. SPL_NET pulls some symbols
> that are part of NET (such as arp_init(), arp_timeout_check(),
> arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
> added later.
>
> Similarly, DFU_TFTP and FASTBOOT are not compatible with NET_LWIP
> because of dependencies on net_loop(), tftp_timeout_ms,
> tftp_timeout_count_max and other NET things. Let's add a dependency on
> !NET_LWIP for now.
>
> As for SANDBOX, NET_LWIP cannot be used either because of strong
> assumptions on the network stack. Make NET_LWIP depend on !SANDBOX so
> that the NET_LWIP alternative is not visible in make menuconfig when
> sandbox_defconfig is used.
>
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
>  Kconfig                    | 26 ++++++++++++++++++++++++++
>  common/Kconfig             |  2 +-
>  common/spl/Kconfig         |  1 +
>  drivers/dfu/Kconfig        |  1 +
>  drivers/fastboot/Kconfig   |  1 +
>  drivers/net/Kconfig        |  1 +
>  drivers/net/phy/Kconfig    |  2 +-
>  drivers/usb/gadget/Kconfig |  2 +-
>  net/Kconfig                | 29 +++++++++++++++--------------
>  net/Makefile               |  4 ++++
>  net/lwip/Kconfig           | 36 ++++++++++++++++++++++++++++++++++++
>  11 files changed, 88 insertions(+), 17 deletions(-)
>  create mode 100644 net/lwip/Kconfig
>
> diff --git a/Kconfig b/Kconfig
> index 82df59f176e..61bc6529617 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -745,6 +745,32 @@ source "dts/Kconfig"
>
>  source "env/Kconfig"
>
> +choice
> +       prompt "Networking stack"
> +       default NET
> +
> +config NO_NET
> +       bool "No networking support"
> +
> +config NET
> +       bool "Legacy U-Boot networking stack"
> +       imply NETDEVICES
> +
> +config NET_LWIP
> +       bool "Use lwIP for networking stack"
> +       imply NETDEVICES
> +       depends on !SANDBOX
> +       help
> +         Include networking support based on the lwIP (lightweight IP)
> +         TCP/IP stack (https://nongnu.org/lwip). This is a replacement f=
or
> +         the default U-Boot network stack and applications located in ne=
t/
> +         and enabled via CONFIG_NET as well as other pieces of code that
> +         depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_=
NET).
> +         Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mu=
tually
> +         exclusive.
> +
> +endchoice
> +
>  source "net/Kconfig"
>
>  source "drivers/Kconfig"
> diff --git a/common/Kconfig b/common/Kconfig
> index 4bb9f08977a..1daa495080a 100644
> --- a/common/Kconfig
> +++ b/common/Kconfig
> @@ -424,7 +424,7 @@ config LOGF_FUNC_PAD
>
>  config LOG_SYSLOG
>         bool "Log output to syslog server"
> -       depends on NET
> +       depends on NET || NET_LWIP
>         help
>           Enables a log driver which broadcasts log records via UDP port =
514
>           to syslog servers.
> diff --git a/common/spl/Kconfig b/common/spl/Kconfig
> index af43b5f5d3c..2731849841a 100644
> --- a/common/spl/Kconfig
> +++ b/common/spl/Kconfig
> @@ -1063,6 +1063,7 @@ config SPL_DM_SPI_FLASH
>
>  config SPL_NET
>         bool "Support networking"
> +       depends on !NET_LWIP
>         help
>           Enable support for network devices (such as Ethernet) in SPL.
>           This permits SPL to load U-Boot over a network link rather than
> diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
> index 971204758aa..d034b501360 100644
> --- a/drivers/dfu/Kconfig
> +++ b/drivers/dfu/Kconfig
> @@ -20,6 +20,7 @@ config DFU_WRITE_ALT
>  config DFU_TFTP
>         bool "DFU via TFTP"
>         depends on NETDEVICES
> +       depends on !NET_LWIP
>         select UPDATE_COMMON
>         select DFU_OVER_TFTP
>         help
> diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
> index 70207573de2..1eb460f5a02 100644
> --- a/drivers/fastboot/Kconfig
> +++ b/drivers/fastboot/Kconfig
> @@ -1,5 +1,6 @@
>  menu "Fastboot support"
>         depends on CMDLINE
> +       depends on !NET_LWIP
>
>  config FASTBOOT
>         bool
> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
> index b4ff033afa9..d332f712a7c 100644
> --- a/drivers/net/Kconfig
> +++ b/drivers/net/Kconfig
> @@ -48,6 +48,7 @@ config DM_DSA
>         bool "Enable Driver Model for DSA switches"
>         depends on DM_MDIO
>         depends on PHY_FIXED
> +       depends on !NET_LWIP
>         help
>           Enable driver model for DSA switches
>
> diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
> index 73064b2af68..75986162914 100644
> --- a/drivers/net/phy/Kconfig
> +++ b/drivers/net/phy/Kconfig
> @@ -11,7 +11,7 @@ config MV88E6352_SWITCH
>
>  menuconfig PHYLIB
>         bool "Ethernet PHY (physical media interface) support"
> -       depends on NET
> +       depends on NET || NET_LWIP
>         help
>           Enable Ethernet PHY (physical media interface) support.
>
> diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
> index 4621a6fd5e6..03fe3bca197 100644
> --- a/drivers/usb/gadget/Kconfig
> +++ b/drivers/usb/gadget/Kconfig
> @@ -224,7 +224,7 @@ endif # USB_GADGET_DOWNLOAD
>
>  config USB_ETHER
>         bool "USB Ethernet Gadget"
> -       depends on NET
> +       depends on NET || NET_LWIP
>         default y if ARCH_SUNXI && USB_MUSB_GADGET
>         help
>           Creates an Ethernet network device through a USB peripheral
> diff --git a/net/Kconfig b/net/Kconfig
> index 5dff6336293..952690d677d 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -2,11 +2,6 @@
>  # Network configuration
>  #
>
> -menuconfig NET
> -       bool "Networking support"
> -       default y
> -       imply NETDEVICES
> -

I looked at menuconfig and saw that so many network options are on the
first screen.
TBH It doesn't look nice and I think it should be hidden in any menu.

  =E2=94=82 =E2=94=82        Environment  --->
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82        Networking stack (Legacy U-Boot networking sta=
ck)  --->
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    (5000) Milliseconds before trying ARP again
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    (5) Number of timeouts before giving up
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Enable generic udp framework
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Send hostname to DNS server
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [*] Random ethaddr if unset
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [*] NetConsole support
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Support IP datagram reassembly
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [*] Echo the inverted Ethernet link state to the f=
ault LED
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Set TFTP UDP source/destination ports via the =
environment
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    (1) TFTP window size
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Track TFTP transfers based on file size option
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Get serverip value from Proxy DHCP response
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    (100) # of additional milliseconds to wait for Pro=
xyDHCP
response  =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Write the server's MAC address to 'serveraddr'
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Check the UDP checksum
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Use the 'serverip' env var for tftp, not bootp
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    (64) Option 17 root path length
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Set a default 'gateway' value in the environme=
nt
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Set a default 'ipaddr' value in the environmen=
t
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Set a default 'netmask' value in the environme=
nt
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Set a default 'rootpath' value in the environm=
ent
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Set a default 'serverip' value in the environm=
ent
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    -*- TCP stack
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ]   TCP SACK support
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] IPv6 support
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Enable debug traces in the lwIP library
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [ ] Enable assertions in the lwIP library
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    [*] Enable bootdev for ethernet
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    (4) Number of receive packet buffers
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82    (1468) TFTP block size
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82        Device Drivers  --->
     =E2=94=82 =E2=94=82
  =E2=94=82 =E2=94=82        File systems  --->

M
