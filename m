Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9518EC3DA5D
	for <u-boot@archiver.kernel.org>; Thu, 25 Jul 2024 13:28:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E2958692C;
	Thu, 25 Jul 2024 15:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="I83M26Oe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 741BB87C86; Thu, 25 Jul 2024 14:58:31 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1388987E64
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 14:58:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-42808071810so3532615e9.1
 for <u-boot@lists.denx.de>; Thu, 25 Jul 2024 05:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721912308; x=1722517108; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lB3rahTvnV9A+Xg0qOR2oAh0gjklWazck+YMw5Z0HnE=;
 b=I83M26OeoUjros4kPfbZGUcs1SY1OeiwLQs37n0n++VEnOXPPjFYW6ylrXGGQHpB6S
 ++UBydPa1YctA6XeF6hf0egWWBjR1DKWGluK8eBtH7L8X2LbSqFB+/y0VzhW9vhpJ5jn
 csl73jqCXB5SRNfo7L34YzT/44dCG3eYjl1iyOAplzgHzybSrru5TI+yc64hTw+JrhiO
 x5H9O5s4y65zgmHboO1edgSl93mDbY/odCaEzA0cThsU+AfhFxSYidlqFcnEZCajK/dK
 vLYmYYK4AyY8937JLD2fSIWxhRXq8rAYUF9K2GAY3tvnn5wH2Mh0sz63EHRj/E7RbtVH
 XP3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721912308; x=1722517108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lB3rahTvnV9A+Xg0qOR2oAh0gjklWazck+YMw5Z0HnE=;
 b=Z3crm615mN+w3wRfJWVX/SbRaHnIL3Y/rPz3i7HP1kkI8ImFx+4IgSzIz9dD4+ov9o
 u9LYQBgR34ZA7FxVtACBhGJ47vev17n8UMYjcbDKjYYq04Nwe/scehsnIAqQmwKiMKrG
 MPLFRuf+n7QZHhOce2cq3vswbhhr8F7Ah6nJ8DGcHf321CCvS25JhTBmA0VAFBhxolWK
 1NMZz4gRAn4oGA0J+O+7TXU7WvHKshduLB7Gp03BdGG1opu2PUW4Kru4YZ4g19AK3zhd
 nak2xPal/hczk1hJXXsihtXpumNpTiVVfTtdkQsi+6zLJOMFOMudqoh375TrXOOfl2/P
 0YUQ==
X-Gm-Message-State: AOJu0YyNQnSZj+j2OpY8qZs3N2iVWBjjMFZYihmnEdnvrB3qjoE/xxk+
 T8fPSbWGFVFzmWg6SBzacwhrIk6Gb+CD7T5qUuGTWCKZV+CGnzjlswFii2LJxNIVTFdFoL5pzaC
 ObKi/dQ==
X-Google-Smtp-Source: AGHT+IEEEOJHwU/6sFMDbxZTGK9oT8M18H4sonEh9pbWthz8lUeJz6zlFE8+Zr4rk4S6dNtjQhVHZw==
X-Received: by 2002:a7b:ce89:0:b0:425:7c5f:1bac with SMTP id
 5b1f17b1804b1-42806ba5f04mr15290625e9.21.1721912307822; 
 Thu, 25 Jul 2024 05:58:27 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:a701:ef5f:d613:3e14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4280573fd83sm34765205e9.19.2024.07.25.05.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 05:58:27 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Bo Gan <ganboing@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Greg Malysa <greg.malysa@timesys.com>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Shengyu Qu <wiagn233@outlook.com>, Stefan Roese <sr@denx.de>,
 Jagan Teki <jagan@amarulasolutions.com>, Bin Meng <bmeng@tinylab.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ion Agorria <ion@agorria.com>, Yang Xiwen <forbidden405@outlook.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v5 02/20] net: introduce alternative implementation as
 net-lwip/
Date: Thu, 25 Jul 2024 14:57:23 +0200
Message-Id: <a88252b5c961ee28a98653751bae627ab3349668.1721910373.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1721910373.git.jerome.forissier@linaro.org>
References: <cover.1721910373.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 25 Jul 2024 15:28:10 +0200
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

Prepare the introduction of the lwIP (lightweight IP) TCP/IP stack by
adding a new net/lwip/ directory and the NET_LWIP symbol. Network
support is either NO_NET, NET (legacy stack) or NET_LWIP. Subsequent
commits will introduce the lwIP code, re-work the NETDEVICE integration
and port some of the NET commands and features to lwIP.

SPL_NET cannot be enabled when NET_LWIP=y. SPL_NET pulls some symbols
that are part of NET (such as arp_init(), arp_timeout_check(),
arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
added later.

Similarly, DFU_TFTP and FASTBOOT are not compatible with NET_LWIP
because of dependencies on net_loop(), tftp_timeout_ms,
tftp_timeout_count_max and other NET things. Let's add a dependency on
!NET_LWIP for now.

As for SANDBOX, NET_LWIP cannot be used either because of strong
assumptions on the network stack. Make NET_LWIP depend on !SANDBOX so
that the NET_LWIP alternative is not visible in make menuconfig when
sandbox_defconfig is used.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig                    | 26 ++++++++++++++++++++++++++
 common/Kconfig             |  2 +-
 common/spl/Kconfig         |  1 +
 drivers/dfu/Kconfig        |  1 +
 drivers/fastboot/Kconfig   |  1 +
 drivers/net/Kconfig        |  1 +
 drivers/net/phy/Kconfig    |  2 +-
 drivers/usb/gadget/Kconfig |  2 +-
 net/Kconfig                | 29 +++++++++++++++--------------
 net/Makefile               |  4 ++++
 net/lwip/Kconfig           | 36 ++++++++++++++++++++++++++++++++++++
 11 files changed, 88 insertions(+), 17 deletions(-)
 create mode 100644 net/lwip/Kconfig

diff --git a/Kconfig b/Kconfig
index 82df59f176e..61bc6529617 100644
--- a/Kconfig
+++ b/Kconfig
@@ -745,6 +745,32 @@ source "dts/Kconfig"
 
 source "env/Kconfig"
 
+choice
+	prompt "Networking stack"
+	default NET
+
+config NO_NET
+	bool "No networking support"
+
+config NET
+	bool "Legacy U-Boot networking stack"
+	imply NETDEVICES
+
+config NET_LWIP
+	bool "Use lwIP for networking stack"
+	imply NETDEVICES
+	depends on !SANDBOX
+	help
+	  Include networking support based on the lwIP (lightweight IP)
+	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
+	  the default U-Boot network stack and applications located in net/
+	  and enabled via CONFIG_NET as well as other pieces of code that
+	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
+	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
+	  exclusive.
+
+endchoice
+
 source "net/Kconfig"
 
 source "drivers/Kconfig"
diff --git a/common/Kconfig b/common/Kconfig
index 4bb9f08977a..1daa495080a 100644
--- a/common/Kconfig
+++ b/common/Kconfig
@@ -424,7 +424,7 @@ config LOGF_FUNC_PAD
 
 config LOG_SYSLOG
 	bool "Log output to syslog server"
-	depends on NET
+	depends on NET || NET_LWIP
 	help
 	  Enables a log driver which broadcasts log records via UDP port 514
 	  to syslog servers.
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index af43b5f5d3c..2731849841a 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1063,6 +1063,7 @@ config SPL_DM_SPI_FLASH
 
 config SPL_NET
 	bool "Support networking"
+	depends on !NET_LWIP
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
 	  This permits SPL to load U-Boot over a network link rather than
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 971204758aa..d034b501360 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -20,6 +20,7 @@ config DFU_WRITE_ALT
 config DFU_TFTP
 	bool "DFU via TFTP"
 	depends on NETDEVICES
+	depends on !NET_LWIP
 	select UPDATE_COMMON
 	select DFU_OVER_TFTP
 	help
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 70207573de2..1eb460f5a02 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -1,5 +1,6 @@
 menu "Fastboot support"
 	depends on CMDLINE
+	depends on !NET_LWIP
 
 config FASTBOOT
 	bool
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index b4ff033afa9..d332f712a7c 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -48,6 +48,7 @@ config DM_DSA
 	bool "Enable Driver Model for DSA switches"
 	depends on DM_MDIO
 	depends on PHY_FIXED
+	depends on !NET_LWIP
 	help
 	  Enable driver model for DSA switches
 
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index 73064b2af68..75986162914 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -11,7 +11,7 @@ config MV88E6352_SWITCH
 
 menuconfig PHYLIB
 	bool "Ethernet PHY (physical media interface) support"
-	depends on NET
+	depends on NET || NET_LWIP
 	help
 	  Enable Ethernet PHY (physical media interface) support.
 
diff --git a/drivers/usb/gadget/Kconfig b/drivers/usb/gadget/Kconfig
index 4621a6fd5e6..03fe3bca197 100644
--- a/drivers/usb/gadget/Kconfig
+++ b/drivers/usb/gadget/Kconfig
@@ -224,7 +224,7 @@ endif # USB_GADGET_DOWNLOAD
 
 config USB_ETHER
 	bool "USB Ethernet Gadget"
-	depends on NET
+	depends on NET || NET_LWIP
 	default y if ARCH_SUNXI && USB_MUSB_GADGET
 	help
 	  Creates an Ethernet network device through a USB peripheral
diff --git a/net/Kconfig b/net/Kconfig
index 5dff6336293..952690d677d 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -2,11 +2,6 @@
 # Network configuration
 #
 
-menuconfig NET
-	bool "Networking support"
-	default y
-	imply NETDEVICES
-
 if NET
 
 config ARP_TIMEOUT
@@ -26,15 +21,6 @@ config PROT_UDP
 	  Enable a generic udp framework that allows defining a custom
 	  handler for udp protocol.
 
-config BOOTDEV_ETH
-	bool "Enable bootdev for ethernet"
-	depends on BOOTSTD
-	default y
-	help
-	  Provide a bootdev for ethernet so that is it possible to boot
-	  an operationg system over the network, using the PXE (Preboot
-	  Execution Environment) protocol.
-
 config BOOTP_SEND_HOSTNAME
 	bool "Send hostname to DNS server"
 	help
@@ -255,6 +241,19 @@ config IPV6
 
 endif   # if NET
 
+source "net/lwip/Kconfig"
+
+if NET || NET_LWIP
+
+config BOOTDEV_ETH
+	bool "Enable bootdev for ethernet"
+	depends on BOOTSTD
+	default y
+	help
+	  Provide a bootdev for ethernet so that is it possible to boot
+	  an operating system over the network, using the PXE (Preboot
+	  Execution Environment) protocol.
+
 config SYS_RX_ETH_BUFFER
 	int "Number of receive packet buffers"
 	default 4
@@ -263,3 +262,5 @@ config SYS_RX_ETH_BUFFER
 	  controllers it is recommended to set this value to 8 or even higher,
 	  since all buffers can be full shortly after enabling the interface on
 	  high Ethernet traffic.
+
+endif   # if NET || NET_LWIP
diff --git a/net/Makefile b/net/Makefile
index 64ab7ec740a..70eec8caf0d 100644
--- a/net/Makefile
+++ b/net/Makefile
@@ -5,6 +5,8 @@
 
 #ccflags-y += -DDEBUG
 
+ifeq ($(CONFIG_NET),y)
+
 obj-$(CONFIG_NET)      += arp.o
 obj-$(CONFIG_CMD_BOOTP) += bootp.o
 obj-$(CONFIG_CMD_CDP)  += cdp.o
@@ -38,3 +40,5 @@ obj-$(CONFIG_CMD_WGET) += wget.o
 # sprintf(buf, index ? "foo%d" : "foo", index)
 # and this is intentional usage.
 CFLAGS_eth_common.o += -Wno-format-extra-args
+
+endif
diff --git a/net/lwip/Kconfig b/net/lwip/Kconfig
new file mode 100644
index 00000000000..0a6bcb41369
--- /dev/null
+++ b/net/lwip/Kconfig
@@ -0,0 +1,36 @@
+#
+# Network configuration (with lwIP stack)
+#
+
+config LWIP_DEBUG
+	bool "Enable debug traces in the lwIP library"
+
+config LWIP_ASSERT
+	bool "Enable assertions in the lwIP library"
+
+config PROT_DHCP_LWIP
+	bool "DHCP support in lwIP"
+	depends on PROT_UDP_LWIP
+	help
+	  Enable support for the DHCP protocol in lwIP.
+
+config PROT_DNS_LWIP
+	bool
+	depends on PROT_UDP_LWIP
+
+config PROT_RAW_LWIP
+	bool
+
+config PROT_TCP_LWIP
+	bool
+
+config PROT_TCP_SACK_LWIP
+	bool "TCP SACK support"
+	depends on PROT_TCP_LWIP
+	default y
+	help
+	  TCP protocol with selective acknowledgements. Improves
+	  file transfer speed in wget.
+
+config PROT_UDP_LWIP
+	bool
-- 
2.40.1

