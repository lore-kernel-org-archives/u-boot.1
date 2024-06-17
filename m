Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFCCFC27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 15:43:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 203FD882E8;
	Mon, 17 Jun 2024 17:43:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aw2TTEX5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A17D787CDA; Mon, 17 Jun 2024 17:33:35 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 504E5882D0
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 17:33:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-421eab59723so32692145e9.3
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 08:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718638412; x=1719243212; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFXRBA9oZwR5Jb5AsDUu83LMTxFQCLzDf/g4Nok7iQ0=;
 b=aw2TTEX58TzAxpwQUo7XJuurKeVgra6rERXkavPJrZ1xyF8opqgtar2yDgVLwbXGpq
 4q3G4uxUdjrrEMsrWiULv/uxNdDzQ42Ta6Qne+oD9f2S7KF8drezVv46Wq32hSfw+RE2
 GkfxPTcR5w+W80+05xBcacrubqHYRvX2jr79sOjEM0evNkPxOh6Be1ODWjvoOJwF8UzO
 X89AEO5AwFDypDyDg8jDw4bq6e9rhG5KsKwIPzlpuaxbr8GOvfo/gCzPZmgQvVoLx9rz
 iJimq+l5HFV7im71cwQEl8k8ThAW1xrt+W58TsvJZkiAA+QDP2HpaEmrWT+UziJGr0lH
 K0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718638412; x=1719243212;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gFXRBA9oZwR5Jb5AsDUu83LMTxFQCLzDf/g4Nok7iQ0=;
 b=B+MvIn1PkXzARqC4TFZnORBx6M5xnQGZueVXDlUa+OGwqxM0bPt0y5dqCmgYEECyEc
 4JDsTcEGObJmMW9V9Ghp/zA0031SbcAA6CsJpl2f+arnDEEPkG4J4JLvZORPvww3FnwC
 Lsfvg/M465hUScLmfJOmvz2gN8jzS3dHglPnK1uajOtWgH8mSmxBVz/I7pamRXZQq/k7
 ykxzVM/vxmVGYcYB7Cs9ttFxj7HMoN/3O1aFMulBt2AYQ28Hjmo/syLWvhQqA51H/N0F
 5knDQ71oqBbiUoXHimAq69m72bRUmXwY5TmR6ejg+U6VUIUN6oYkGXnDRZX5VwczXNvu
 vMgg==
X-Gm-Message-State: AOJu0YwYEQUvYMfGVFCsoQcsRjw/j06Wc21hz95Oe2ROwOmmLNc9hSmC
 Rk9F/O+/EBVeRe8fhiud8tetGgu1eqzdvDS6Z96fi9VgjBnb59Iie9PEd4KKfU5PVoaFZtKnQ6N
 QQbU=
X-Google-Smtp-Source: AGHT+IGu7n29CQ/clgL1XDbPu2Qago8JpMbRi01lA60WVVyZWFoUonXHN/2bTOzOGoFzykXJvqwaWQ==
X-Received: by 2002:a05:600c:5113:b0:421:2202:1cd1 with SMTP id
 5b1f17b1804b1-4230484404dmr76149445e9.25.1718638411833; 
 Mon, 17 Jun 2024 08:33:31 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6e75:be8f:56ae:2b5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-422f602f620sm161350895e9.19.2024.06.17.08.33.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jun 2024 08:33:31 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Jonas Karlman <jonas@kwiboo.se>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Sean Anderson <sean.anderson@seco.com>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>, Shengyu Qu <wiagn233@outlook.com>,
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Ying Sun <sunying@nj.iscas.ac.cn>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Joshua Watt <jpewhacker@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Bin Meng <bmeng.cn@gmail.com>, Andre Przywara <andre.przywara@arm.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Ion Agorria <ion@agorria.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v4 02/14] net: introduce alternative implementation as
 net-lwip/
Date: Mon, 17 Jun 2024 17:32:54 +0200
Message-Id: <f382942cd9d0d62da5204b884c6fa1a59526d262.1718638104.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1718638104.git.jerome.forissier@linaro.org>
References: <cover.1718638104.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 17 Jun 2024 17:43:34 +0200
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
adding a new net-lwip/ directory and the NET_LWIP symbol. Network
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
 Kconfig                    | 41 ++++++++++++++++++++++++++++++++++++++
 Makefile                   |  2 +-
 common/Kconfig             |  2 +-
 common/spl/Kconfig         |  1 +
 drivers/dfu/Kconfig        |  1 +
 drivers/fastboot/Kconfig   |  1 +
 drivers/net/Kconfig        |  1 +
 drivers/net/phy/Kconfig    |  2 +-
 drivers/usb/gadget/Kconfig |  2 +-
 net-lwip/Kconfig           | 37 ++++++++++++++++++++++++++++++++++
 net/Kconfig                | 14 -------------
 11 files changed, 86 insertions(+), 18 deletions(-)
 create mode 100644 net-lwip/Kconfig

diff --git a/Kconfig b/Kconfig
index 82df59f176e..cfe2a6d3eac 100644
--- a/Kconfig
+++ b/Kconfig
@@ -745,7 +745,48 @@ source "dts/Kconfig"
 
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
+if NET
 source "net/Kconfig"
+endif
+
+if NET_LWIP
+source "net-lwip/Kconfig"
+endif
+
+config SYS_RX_ETH_BUFFER
+	int "Number of receive packet buffers"
+	default 4
+	help
+	  Defines the number of Ethernet receive buffers. On some Ethernet
+	  controllers it is recommended to set this value to 8 or even higher,
+	  since all buffers can be full shortly after enabling the interface on
+	  high Ethernet traffic.
 
 source "drivers/Kconfig"
 
diff --git a/Makefile b/Makefile
index f8206b2e30a..ceb99a2698e 100644
--- a/Makefile
+++ b/Makefile
@@ -859,7 +859,7 @@ libs-$(CONFIG_OF_EMBED) += dts/
 libs-y += env/
 libs-y += lib/
 libs-y += fs/
-libs-y += net/
+libs-$(CONFIG_NET) += net/
 libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
diff --git a/common/Kconfig b/common/Kconfig
index 5e3070e9253..807b726384d 100644
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
index 6405374bcc1..f67f0a859db 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1055,6 +1055,7 @@ config SPL_DM_SPI_FLASH
 
 config SPL_NET
 	bool "Support networking"
+	depends on !NET_LWIP
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
 	  This permits SPL to load U-Boot over a network link rather than
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index 0360d9da142..6405a23574e 100644
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
index b2d7b499766..efc55e45ca8 100644
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
index 3d96938eaba..738752d29c2 100644
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
diff --git a/net-lwip/Kconfig b/net-lwip/Kconfig
new file mode 100644
index 00000000000..a0938964b51
--- /dev/null
+++ b/net-lwip/Kconfig
@@ -0,0 +1,37 @@
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
+config PROT_UDP_LWIP
+	bool
+
+config BOOTDEV_ETH
+        bool "Enable bootdev for ethernet"
+        depends on BOOTSTD
+        default y
+        help
+          Provide a bootdev for ethernet so that is it possible to boot
+          an operating system over the network, using the PXE (Preboot
+          Execution Environment) protocol.
diff --git a/net/Kconfig b/net/Kconfig
index 5dff6336293..4929428d2a5 100644
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
@@ -254,12 +249,3 @@ config IPV6
 	  address and find it, it will force using IPv6 in the network stack.
 
 endif   # if NET
-
-config SYS_RX_ETH_BUFFER
-	int "Number of receive packet buffers"
-	default 4
-	help
-	  Defines the number of Ethernet receive buffers. On some Ethernet
-	  controllers it is recommended to set this value to 8 or even higher,
-	  since all buffers can be full shortly after enabling the interface on
-	  high Ethernet traffic.
-- 
2.40.1

