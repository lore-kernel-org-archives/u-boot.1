Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23E2C3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 17:14:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E1888789F;
	Thu, 25 Jul 2024 19:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fNVsz1tV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 183628641C; Thu, 25 Jul 2024 15:47:13 +0200 (CEST)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0945D87C38
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 15:47:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=muvarov@gmail.com
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a7aa212c1c9so65698666b.2
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 06:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721915228; x=1722520028; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yfc0IiFWEyMf8qJcYrRjbX7Q6s3zUQyJBQQ79N8AYFE=;
 b=fNVsz1tVfJXwCR229naBjbOCikJqrzQ3+0Rzq32rtjGmldcQAw7Qv1HCYPHmnu+/xY
 UPYVTMM7bPUIHllLdNrpqUjD9BDYUJAjh7ljt6vIqLytoEcZ/PF2E6F5RkEwS/NdRzt8
 GAep6otuMeqPMjhy7dBlYA6K+ntxocemUPl13FuE+9GAQjbfdbm594vC2B4Hlx/REwwc
 KiS/36+PaA7dOlRpSlb7+u5fgdJh3061Zj2HOO2hiGT3mUpsQ/vESW4G0S+Zpz/iyAGB
 h5vudykxVZoLmDVd2EGCRW0SUUixtl13uLz2gIono/3wyKaiv46lWiF/Sxo/lrG9VI0a
 nh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721915228; x=1722520028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Yfc0IiFWEyMf8qJcYrRjbX7Q6s3zUQyJBQQ79N8AYFE=;
 b=q/uhsOTWP3hAAv5R1Kimi/Y6m57NZlbHLhgMK4R6ZaKZy9rjvkaWLiCH4veHqY3oi8
 psBNe5QxX9hbp1ZLE6r83Wz/Eaq46VM+fxt8Qc8h5uerDcJK3CDOA0m4X2YBe6nyaNCK
 j+sf4TuvhAqTzSBeUeRkEPSeQamWmr1bLUrq8Veu5BAdlPhLedusKmFI5sbBumv9TU7z
 VhH4YmdQ1e+363sR7sgor+1oeVWwFTdSUY4twstt5ulEp9ahE01MQEw3NEclNuxQX4h2
 fWn5wNegT0ngqpXYRQxIxLVf2GMtKBq66K5GqpHtWkreepdwsFkT/gGQmxUAzdDlnAhp
 owhQ==
X-Gm-Message-State: AOJu0Yxu67anrzT+nrtsIDf69BV66RTaGTIE8eclXpIOwpdjE085k0BC
 H7vPh/B6rSirjxAlTQGUSbL5diao/BKcxsovKofCb79bBadmhzDJQeGmwGDfDWM2jWAq5DaYWDY
 diS5UwYSiGFwPqDMIQLMROGkdLrA=
X-Google-Smtp-Source: AGHT+IGYUTaTQ2bch47JxE5oJ/j8v/V5aOTx4EX+5lAcK87Ml9PHaK0bQd8ImEJ+SyWJbfZRzvM50Mf08iRfiXNpJ9s=
X-Received: by 2002:a17:907:7d88:b0:a72:7245:ec0a with SMTP id
 a640c23a62f3a-a7ac5087b94mr227469666b.58.1721915228150; Thu, 25 Jul 2024
 06:47:08 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721910373.git.jerome.forissier@linaro.org>
 <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
In-Reply-To: <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
From: Maxim Uvarov <muvarov@gmail.com>
Date: Thu, 25 Jul 2024 16:46:54 +0300
Message-ID: <CAJGZr0+zYWbrXTHBwnCwDXADmgx54YXmhLaO5D4QFxZEFbjtbQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/20] net: introduce alternative implementation as
 net-lwip/
To: Jerome Forissier <jerome.forissier@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>, 
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
X-Mailman-Approved-At: Thu, 25 Jul 2024 19:14:03 +0200
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

=D1=87=D1=82, 25 =D0=B8=D1=8E=D0=BB. 2024=E2=80=AF=D0=B3. =D0=B2 15:58, Jer=
ome Forissier <jerome.forissier@linaro.org>:
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
>  if NET
>
>  config ARP_TIMEOUT
> @@ -26,15 +21,6 @@ config PROT_UDP
>           Enable a generic udp framework that allows defining a custom
>           handler for udp protocol.
>
> -config BOOTDEV_ETH
> -       bool "Enable bootdev for ethernet"
> -       depends on BOOTSTD
> -       default y
> -       help
> -         Provide a bootdev for ethernet so that is it possible to boot
> -         an operationg system over the network, using the PXE (Preboot
> -         Execution Environment) protocol.
> -
>  config BOOTP_SEND_HOSTNAME
>         bool "Send hostname to DNS server"
>         help
> @@ -255,6 +241,19 @@ config IPV6
>
>  endif   # if NET
>
> +source "net/lwip/Kconfig"
> +
> +if NET || NET_LWIP
> +
> +config BOOTDEV_ETH
> +       bool "Enable bootdev for ethernet"
> +       depends on BOOTSTD
> +       default y
> +       help
> +         Provide a bootdev for ethernet so that is it possible to boot
> +         an operating system over the network, using the PXE (Preboot
> +         Execution Environment) protocol.
> +
>  config SYS_RX_ETH_BUFFER
>         int "Number of receive packet buffers"
>         default 4
> @@ -263,3 +262,5 @@ config SYS_RX_ETH_BUFFER
>           controllers it is recommended to set this value to 8 or even hi=
gher,
>           since all buffers can be full shortly after enabling the interf=
ace on
>           high Ethernet traffic.
> +
> +endif   # if NET || NET_LWIP
> diff --git a/net/Makefile b/net/Makefile
> index 64ab7ec740a..70eec8caf0d 100644
> --- a/net/Makefile
> +++ b/net/Makefile
> @@ -5,6 +5,8 @@
>
>  #ccflags-y +=3D -DDEBUG
>
> +ifeq ($(CONFIG_NET),y)
> +
>  obj-$(CONFIG_NET)      +=3D arp.o
>  obj-$(CONFIG_CMD_BOOTP) +=3D bootp.o
>  obj-$(CONFIG_CMD_CDP)  +=3D cdp.o
> @@ -38,3 +40,5 @@ obj-$(CONFIG_CMD_WGET) +=3D wget.o
>  # sprintf(buf, index ? "foo%d" : "foo", index)
>  # and this is intentional usage.
>  CFLAGS_eth_common.o +=3D -Wno-format-extra-args
> +
> +endif
> diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
> new file mode 100644
> index 00000000000..0a6bcb41369
> --- /dev/null
> +++ b/net/lwip/Kconfig
> @@ -0,0 +1,36 @@
> +#
> +# Network configuration (with lwIP stack)
> +#
> +
> +config LWIP_DEBUG
> +       bool "Enable debug traces in the lwIP library"
> +
> +config LWIP_ASSERT
> +       bool "Enable assertions in the lwIP library"
> +
> +config PROT_DHCP_LWIP
> +       bool "DHCP support in lwIP"
> +       depends on PROT_UDP_LWIP
> +       help
> +         Enable support for the DHCP protocol in lwIP.
> +
> +config PROT_DNS_LWIP
> +       bool
> +       depends on PROT_UDP_LWIP
> +
> +config PROT_RAW_LWIP
> +       bool
> +
> +config PROT_TCP_LWIP
> +       bool

Hello Jerome,

Not very critical, but it will be good to align options names.  I
think CONFIG_NET_LWIP_ is a good prefix.
It will be easier to grep configuration from .config.

BR,
Maxim.


> +
> +config PROT_TCP_SACK_LWIP
> +       bool "TCP SACK support"
> +       depends on PROT_TCP_LWIP
> +       default y
> +       help
> +         TCP protocol with selective acknowledgements. Improves
> +         file transfer speed in wget.
> +
> +config PROT_UDP_LWIP
> +       bool
> --
> 2.40.1
>


--=20
Best regards,
Maxim Uvarov
