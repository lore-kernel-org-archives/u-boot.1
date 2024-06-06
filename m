Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9359EC27C54
	for <u-boot@archiver.kernel.org>; Thu,  6 Jun 2024 16:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 006248850D;
	Thu,  6 Jun 2024 18:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="ptrsTEmJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1BF9688395; Thu,  6 Jun 2024 15:36:59 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39CB3883AA
 for <u-boot@lists.denx.de>; Thu,  6 Jun 2024 15:36:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4215b0c4b7dso10583885e9.0
 for <u-boot@lists.denx.de>; Thu, 06 Jun 2024 06:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717681015; x=1718285815; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2aIAacY4b9gwYMIGJldrbYZiYVcQ/I1Rb7nia3l7JOE=;
 b=ptrsTEmJh7E2/aeer6tO87afDqOQaSRAZ3nKNQn84ACnNM17F5YdxFqKUPkbQMKP7F
 WLpXmogPsxIpZTYLPzn7e+q/g7VciaxmOf0i6XsJdaO85I3G7xn/7j1YTRqNEruwx9Oj
 YP2HGGfeuIT4KUz/Kp1B7NB2z58P3cPqqWVSE2Q0zskQ//Nstb4hxoVBrus+bRShC8l/
 hGXzyAVSyiClyvlumJHRVVFSxMuVDSH5LKrM/N8/5i7eUBxx8FxQljoVU8J3u77JGapi
 ob+qXnQFGaXQwMp1RJEgEY1+tXq5x3IkLDKUKy0KCZCuqVdYqLZX8kmSV9MZLJzKIkDp
 XWsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717681015; x=1718285815;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2aIAacY4b9gwYMIGJldrbYZiYVcQ/I1Rb7nia3l7JOE=;
 b=FTLNeBCIeCOI59d5uP+g8YxiPS4AnhnNf5ZUD35O+XaZ2Rw2uGiDqt+bVN0dAhmXPP
 TedU1/KMBX2dDueQFqq8WUtx4DE36VKJhRpCksNAR0VrBjBKzw8vMtMcVCXsv0Hl2XsV
 tadJrQARbxA6pRFw9UjeMrQvKnW3ncEvru4Z4TNEtJIIWrnvCTC/kC8on45gcrc/n/eJ
 l2lV+aLQ0d4/oJ/jxXTbUQnAZHjnGi43VnBTZzj1SMzSRN9CMVDwcPS8Im46B3g8n9MY
 tt0+cQCHAiDO+Z7msX6AtMF7Xdzd0jbANmLojo4ZPby0VerIt8LctnqmSiXkVXHEUOS4
 bqfA==
X-Gm-Message-State: AOJu0YxRit3B+dm9mabU8hzJjEvgIE1QWkdy7vCCGZJkqCcrlR33Mbf0
 2bOWuNo4nG1aHBzkpML+DKgzIQXX3KXdUDaTLnMiSSZiv/+Ld14X55/myNXejnjanrqBTAWj8GP
 OF/Lkwkvj
X-Google-Smtp-Source: AGHT+IG4u/G4sw5ugGapQX4buXyWbow4BmW2hTfjurHiv82lTd39Cfl10FBlqRzjfGBuHfkl6nwbvA==
X-Received: by 2002:a05:600c:41c3:b0:41f:ec3e:9797 with SMTP id
 5b1f17b1804b1-421562cf729mr42849475e9.16.1717681015379; 
 Thu, 06 Jun 2024 06:36:55 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:6417:8cf6:a7f7:ee38])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c19d52dsm23111955e9.8.2024.06.06.06.36.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jun 2024 06:36:55 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Shengyu Qu <wiagn233@outlook.com>, Jesse Taube <mr.bossman075@gmail.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Ying Sun <sunying@nj.iscas.ac.cn>, Jagan Teki <jagan@amarulasolutions.com>,
 Bin Meng <bmeng.cn@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Joshua Watt <jpewhacker@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Samuel Holland <samuel@sholland.org>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ion Agorria <ion@agorria.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>,
 Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v3 01/12] net: introduce alternative implementation as
 net-lwip/
Date: Thu,  6 Jun 2024 15:35:56 +0200
Message-Id: <46becb46b92b6ea945112785b17a59c9ce7498d3.1717680809.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1717680809.git.jerome.forissier@linaro.org>
References: <cover.1717680809.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 06 Jun 2024 18:34:03 +0200
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

Similarly, DFU_TFTP is not compatible with NET_LWIP because it depends
on net_loop(), tftp_timeout_ms, tftp_timeout_count_max. Let's add a
dependency of DFU_OVER_TFTP on !NET_LWIP for now.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig                    | 40 ++++++++++++++++++++++++++++++++++++++
 Makefile                   |  2 +-
 common/Kconfig             |  2 +-
 common/spl/Kconfig         |  1 +
 drivers/dfu/Kconfig        |  2 +-
 drivers/fastboot/Kconfig   |  4 ++--
 drivers/net/phy/Kconfig    |  2 +-
 drivers/usb/gadget/Kconfig |  2 +-
 net-lwip/Kconfig           | 37 +++++++++++++++++++++++++++++++++++
 net/Kconfig                | 14 -------------
 10 files changed, 85 insertions(+), 21 deletions(-)
 create mode 100644 net-lwip/Kconfig

diff --git a/Kconfig b/Kconfig
index 82df59f176e..b7304bd37c5 100644
--- a/Kconfig
+++ b/Kconfig
@@ -745,7 +745,47 @@ source "dts/Kconfig"
 
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
index 0360d9da142..c6bce82eb10 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -11,7 +11,7 @@ config DFU_OVER_USB
 
 config DFU_OVER_TFTP
 	bool
-	depends on NET
+	depends on NET && !NET_LWIP
 
 if DFU
 config DFU_WRITE_ALT
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 70207573de2..05e988166fb 100644
--- a/drivers/fastboot/Kconfig
+++ b/drivers/fastboot/Kconfig
@@ -27,7 +27,7 @@ config USB_FUNCTION_FASTBOOT
 	  This enables the USB part of the fastboot gadget.
 
 config UDP_FUNCTION_FASTBOOT
-	depends on NET
+	depends on NET || NET_LWIP
 	select FASTBOOT
 	bool "Enable fastboot protocol over UDP"
 	help
@@ -41,7 +41,7 @@ config UDP_FUNCTION_FASTBOOT_PORT
 	  The fastboot protocol requires a UDP port number.
 
 config TCP_FUNCTION_FASTBOOT
-	depends on NET
+	depends on NET || NET_LWIP
 	select FASTBOOT
 	bool "Enable fastboot protocol over TCP"
 	help
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

