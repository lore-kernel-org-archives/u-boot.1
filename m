Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45CAC3DA4A
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 14:22:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 524878870E;
	Fri,  2 Aug 2024 16:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="awllXH9s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3641B88967; Fri,  2 Aug 2024 15:14:33 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B418388B8E
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 15:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4280c55e488so19328175e9.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604470; x=1723209270; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x3lRhZ4W1ivr5QtoWjLq8kI+u54INtM8ftsWrmXp3YI=;
 b=awllXH9sxnMLMD8ZU/1gkYGH/q2T7szKHei+LeFfxNyAuXL52DnFK7NrdPyTt4e5yq
 pZfkjKFz6Iua+NRhenUxf/mM6cRwFS5VEupF1UWH5qcu+CQ9OVxYBG9n5DALDBqsOotZ
 wxA+yKURQ9Irtuxb/1h/kF2zCzEj4TPq1GjoEC3II2g/fpJ3exjlpW0DjvrFGQ0nT7EV
 O1YmRk+bM6GdOU/4ItIML1b2sM/0KcgbK+kVP5ifiYypBbP8bAPMoY3sW++UFDe20oLn
 Zxk6n9ZQ2UtCYxtjTRbRwkrhEPqAtrI13lPq1/sxvE4sYYukowjeBJc7nseeW7axRBjE
 bkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604470; x=1723209270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x3lRhZ4W1ivr5QtoWjLq8kI+u54INtM8ftsWrmXp3YI=;
 b=OvxQRl69XBgs6fVObCVOkYJXAcKggVKh7FpVkio4ESi6lC8QYDMCqUWsSxwn3w6EZ6
 fvE1i1tlcVMMm+NULvGd3dQZ2IeFQJQBI1KwZsIRpbH3ZmMMl69vx1vPSZdDXaPW5uUb
 IYjAk1Ilmhf7qLBCqjiHwTvULkGOt9GNWaWwwHxuboiPeK0/a/sRi9/Rpg1mSgI4aTEj
 crigw6qUXM9I7TRAV+bRlwptU5IGagFa5O2yqjMBIgiomp81qDkMj/0TwulW6PgMfvEk
 qV+pQN0CcVGPblH7DgsyWdCqsOxhLymYx8iI7u7TijeIKGzTmvLXM2h/+C5CloE6IJ8H
 nJZQ==
X-Gm-Message-State: AOJu0Yz8pwY0p3llVEwt+rf+XEDxiToukh3vGt7Y69AvC1gPdDd5irBD
 Lxo/0GDwKJ064+u+RCPAkMWfXu0b20dIU5UJMajNgYB2Qp3Z8G1GXH2PMem01XNR/UEYxcUbtQo
 EoW+Qdc0b
X-Google-Smtp-Source: AGHT+IGN+AxaQ83sz+WXhzeBFcRfEcyvi/XhNxK2tUGgxErONPrazAnQJM4Hd0DUKP2HrU4mCvd+CQ==
X-Received: by 2002:a05:600c:1d20:b0:426:706c:a55a with SMTP id
 5b1f17b1804b1-428e6f7d703mr22837225e9.2.1722604469867; 
 Fri, 02 Aug 2024 06:14:29 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbcf0cc58sm1970304f8f.2.2024.08.02.06.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 06:14:29 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Shengyu Qu <wiagn233@outlook.com>,
 Stefan Roese <sr@denx.de>, Jagan Teki <jagan@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Ion Agorria <ion@agorria.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Boon Khai Ng <boon.khai.ng@intel.com>, Jonas Karlman <jonas@kwiboo.se>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v6 02/20] net: introduce alternative implementation as
 net-lwip/
Date: Fri,  2 Aug 2024 15:13:49 +0200
Message-Id: <b74270fef441eb4ce4d32e5b6195ade3d33446a2.1722601509.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722601509.git.jerome.forissier@linaro.org>
References: <cover.1722601509.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Aug 2024 16:22:11 +0200
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
 Kconfig                    | 30 +++++++++++++++++++
 common/Kconfig             |  2 +-
 common/spl/Kconfig         |  1 +
 drivers/dfu/Kconfig        |  1 +
 drivers/fastboot/Kconfig   |  1 +
 drivers/net/Kconfig        |  1 +
 drivers/net/phy/Kconfig    |  2 +-
 drivers/usb/gadget/Kconfig |  2 +-
 net/Kconfig                | 61 +++++++++++++++++++-------------------
 net/Makefile               |  4 +++
 net/lwip/Kconfig           | 34 +++++++++++++++++++++
 11 files changed, 106 insertions(+), 33 deletions(-)
 create mode 100644 net/lwip/Kconfig

diff --git a/Kconfig b/Kconfig
index 82df59f176e..6657b9e5e30 100644
--- a/Kconfig
+++ b/Kconfig
@@ -745,8 +745,38 @@ source "dts/Kconfig"
 
 source "env/Kconfig"
 
+menu Networking
+
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
 
+endmenu
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
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
index 5dff6336293..0e9f2b4cc5b 100644
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
@@ -45,15 +31,6 @@ config BOOTP_SEND_HOSTNAME
           of the "hostname" environment variable is passed as
           option 12 to the DHCP server.
 
-config NET_RANDOM_ETHADDR
-	bool "Random ethaddr if unset"
-	help
-	  Selecting this will allow the Ethernet interface to function even
-	  when the ethaddr variable for that interface is unset.  In this case,
-	  a random MAC address in the locally administered address space is
-	  generated. It will be saved to the appropriate environment variable,
-	  too.
-
 config NETCONSOLE
 	bool "NetConsole support"
 	help
@@ -255,11 +232,35 @@ config IPV6
 
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
+config NET_RANDOM_ETHADDR
+	bool "Random ethaddr if unset"
+	help
+	  Selecting this will allow the Ethernet interface to function even
+	  when the ethaddr variable for that interface is unset.  In this case,
+	  a random MAC address in the locally administered address space is
+	  generated. It will be saved to the appropriate environment variable,
+	  too.
+
+endif   # if NET || NET_LWIP
+
 config SYS_RX_ETH_BUFFER
-	int "Number of receive packet buffers"
-	default 4
-	help
-	  Defines the number of Ethernet receive buffers. On some Ethernet
-	  controllers it is recommended to set this value to 8 or even higher,
-	  since all buffers can be full shortly after enabling the interface on
-	  high Ethernet traffic.
+        int "Number of receive packet buffers"
+        default 4
+        help
+          Defines the number of Ethernet receive buffers. On some Ethernet
+          controllers it is recommended to set this value to 8 or even higher,
+          since all buffers can be full shortly after enabling the interface on
+          high Ethernet traffic.
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
index 00000000000..eb31d044197
--- /dev/null
+++ b/net/lwip/Kconfig
@@ -0,0 +1,34 @@
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
+	bool
+	select PROT_UDP_LWIP
+
+config PROT_DNS_LWIP
+	bool
+	select PROT_UDP_LWIP
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

