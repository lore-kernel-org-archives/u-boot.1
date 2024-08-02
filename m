Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A8C3C52D6F
	for <u-boot@archiver.kernel.org>; Fri,  2 Aug 2024 16:31:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD88988BDE;
	Fri,  2 Aug 2024 18:29:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NqWa5eXy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 265DF88AF4; Fri,  2 Aug 2024 18:27:55 +0200 (CEST)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A38EA88BC7
 for <u-boot@lists.denx.de>; Fri,  2 Aug 2024 18:27:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-36844375001so3802132f8f.0
 for <u-boot@lists.denx.de>; Fri, 02 Aug 2024 09:27:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616071; x=1723220871; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYdNFr1zR9Srmff2Npz7bSX2geGDM5gN/OTVW/4RLSY=;
 b=NqWa5eXyE3A1d3hRG/6swEX3yXKBcK+j3d8mAPQKZ5yD9ZWhP3YqOxkz3IocN5Hj4B
 giCzZ3X1IYGB/RoJDOJYLpXv49MXI5bqIkaqZq8JQtRj8NsVJu72LTrs72MP7u6Rm1nt
 R0+7vFReTEUxLlyk9KsfucRs5jubSXHXt3xboai8H/tIVPMsmA+UOAYjGdaHBaRW2kkd
 vgHvAe9iYaytrrqkh0hbrZlg9DMk4iU7YVZgvBQn8HIjmnWA6ptNp1LckZhBANi5Yai3
 PXOJDT2OLPMtwwzXRedXaVVLDqE4//f9RRimEnX+MMWnaOFhoS/g7W2PezAsiD5S4sTN
 J3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616071; x=1723220871;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYdNFr1zR9Srmff2Npz7bSX2geGDM5gN/OTVW/4RLSY=;
 b=vd71fDPeUthHa8XTSp10+YFVqHY79sFAZZWbGjaewCINruKtEPyAHxlAdrTs9RDsyX
 cZyO+CTzp4X862ceifZbbr5QahLK5ESZ2CQMW94/lb+2aiiwQsPMH28yhcf75hdtD2BS
 quRndJ85YuY9pT0q0z2jeRbs9kOnIxosLaT7ZznngBT1Uq9AYQ0GKYaWQ0rnkW+lvmeo
 s7ckrrqFLU/5JJMsDsAtvnMGjwOd6N5u3LVTqidLpEAg/ckGt3sqnrSDuATs+uA29RWz
 /LLg1xiw2NIiodJP7moZF8nymU/os9jQEvwHK5AjgMH4I5b0kSa4zHOWUlZFqmnXl5Bp
 rv9Q==
X-Gm-Message-State: AOJu0YzZNZbLbuZzUATe5eEQcGuZga7G9Mr6lpZQHIDIhSlIT9d23/fu
 MqVrG7xBvlaXScVe45Pccsw9/slJaQ6PYfrCsJOTr62qdwYSMOX0/s4T/HfzaYS2TEHqTTipJar
 JigzHOv8d
X-Google-Smtp-Source: AGHT+IHQcL6r26dJjpj7GYOZNBYrk4E7dTbgNFuLnsFn5G90cj8NSuvAmSlY9v4RsqJ+nv8wtgOSdw==
X-Received: by 2002:a05:6000:1e97:b0:368:74c0:6721 with SMTP id
 ffacd0b85a97d-36bbc14a6edmr2668935f8f.38.1722616071269; 
 Fri, 02 Aug 2024 09:27:51 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:4fc9:a3ab:c134:cdf4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd01b5c4sm2297783f8f.42.2024.08.02.09.27.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 09:27:51 -0700 (PDT)
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
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Martyn Welch <martyn.welch@collabora.com>, Jonas Karlman <jonas@kwiboo.se>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Shengyu Qu <wiagn233@outlook.com>,
 Stefan Roese <sr@denx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ion Agorria <ion@agorria.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Anand Moon <linux.amoon@gmail.com>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v7 02/20] net: introduce alternative implementation as
 net-lwip/
Date: Fri,  2 Aug 2024 18:26:29 +0200
Message-Id: <61ae6b4dff1bddc80bc24d5b9ae1c9b34eff5870.1722615735.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1722615735.git.jerome.forissier@linaro.org>
References: <cover.1722615735.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 02 Aug 2024 18:29:40 +0200
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
index 83c81edac20..1fbe4e0812f 100644
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
index 6f56ca911c1..6d03d7200d5 100644
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
index 69ae7c07508..6e0962de84e 100644
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
index 7cb80b880a9..16a9de47e94 100644
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

