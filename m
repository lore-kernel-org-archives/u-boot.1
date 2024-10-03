Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055A4CF34A9
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 15:25:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8DFE588DFA;
	Thu,  3 Oct 2024 17:25:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="NJKH63Rg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F3088E3F; Thu,  3 Oct 2024 17:23:53 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7815588EFA
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 17:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42cbbb1727eso11096015e9.2
 for <u-boot@lists.denx.de>; Thu, 03 Oct 2024 08:23:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727969028; x=1728573828; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vh2vaLsiYaGYXwGCPW80jK2jyrroW3+gmHVk0ybo56E=;
 b=NJKH63RgwIRNvqbKTzlB+W2wtXJ8k6AueEKBQ+pioRSSIZLj26spJxCgj+usVvc8kK
 YFxZzivPiPQAFR6bAtp4w9LnAx1Vb6+kvGkDYQtp3yOVpV6e8FbeyTM4iPBMG8wbN8Yr
 H4AcNaybjj2HtHYPPQAn72Ia6zKZzkBtE3FQ6DrG/1hTjGKYT/lse1ZbI78OkFWCACau
 HPAFrGLa7PR2JL2IVW+dL+UUlZADIwyYTLxBn1uYGRAf8u5HTjEj8ZS1ZCNoBJ9Lzjgv
 yGdLXmTEpef7NadgS7MjM8un77EXxp7EkCwwnrKmQ3uJarBMsCdQa9sQs0OMZfXQUuDx
 z4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727969028; x=1728573828;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vh2vaLsiYaGYXwGCPW80jK2jyrroW3+gmHVk0ybo56E=;
 b=ERlqQpE5sXW6aShBDfAPiLxqaE9MwZi4m5c/A9cjU+O2Dr6clR/1iDTvP77eUcA8tt
 mKUQfhnhFsg9zLMhvDvrl2yoyCGBLkMFCanhz4x7i2XxWdqnm+0BQJkEGvyiq0SQUiXv
 cAA3XnOFW7N9ledOj84nnhFPm0vSF0PBAeyPDuYYSdU9/enuhEzg8dwp3yeoZpBSmD05
 i+FNKRjbM/zJGbA2YzlkNHZwDPFf2qn/NrK4n8w7cixdsq6dJ19yuq6PM9dH8BAA7g04
 eqQZ0PsFwoMSnB5KIpIjsU6Z7J50KGmsEUZRg3/Wo/VcSHzT8zZRa6Xe8Y2/I62LDetU
 uw7g==
X-Gm-Message-State: AOJu0YyrhWhBp+PN5i6ORimNrGNJQ/7Ca+V3W7JEAqCx6Sezf+pIUrZf
 bBqMTUSMABDM/6YdHPFTJk16s0eY13qc0UvZ/TMexC9XK7bzq7FZxwq41+jW7B2i4KVbf/IOYSt
 GQDB+5iWO
X-Google-Smtp-Source: AGHT+IGcK4kq4TeoyDbnwxsTWQOio6HnJxGORh+yNSeVmHb2P0R6lcy3gqaVVSXPYLmWWHwboBlHNw==
X-Received: by 2002:a05:600c:3108:b0:42c:ae30:fc4d with SMTP id
 5b1f17b1804b1-42f777b64c9mr55711985e9.7.1727969027538; 
 Thu, 03 Oct 2024 08:23:47 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:d888:7a58:deed:47d6])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37d081f7482sm1506220f8f.8.2024.10.03.08.23.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 08:23:47 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Raymond Mao <raymond.mao@linaro.org>,
 Maxim Uvarov <muvarov@gmail.com>, Tim Harvey <tharvey@gateworks.com>,
 Anton Antonov <Anton.Antonov@arm.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Paul Kocialkowski <contact@paulk.fr>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Sean Anderson <sean.anderson@seco.com>, Jonas Karlman <jonas@kwiboo.se>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sumit Garg <sumit.garg@linaro.org>, Andrew Davis <afd@ti.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Bryan Brattlof <bb@ti.com>,
 "Leon M. Busch-George" <leon@georgemail.eu>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Eddie James <eajames@linux.ibm.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Stefan Roese <sr@denx.de>,
 Joshua Watt <jpewhacker@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ion Agorria <ion@agorria.com>, Svyatoslav Ryhel <clamor95@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Peter Robinson <pbrobinson@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Baruch Siach <baruch@tkos.co.il>, Anand Moon <linux.amoon@gmail.com>,
 Alexander Gendin <agendin@matrox.com>, Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v11 07/29] net: introduce alternative implementation as
 net-lwip/
Date: Thu,  3 Oct 2024 17:22:53 +0200
Message-Id: <c1757e06b57cc56f7935b280451fb331535aa7a4.1727968902.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1727968902.git.jerome.forissier@linaro.org>
References: <cover.1727968902.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 03 Oct 2024 17:25:39 +0200
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

SANDBOX can select NET_LWIP but doing so will currently disable the eth
dm tests as well as the wget tests which have strong dependencies on the
NET code.

Other adjustments to Kconfig files are made to fix "unmet direct
dependencies detected" for USB_FUNCTION_SDP and CMD_FASTBOOT when
the default networking stack is set to NET_LWIP ("default NET_LWIP"
instead of "default NET" in Kconfig).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig                    | 29 ++++++++++++++++++
 Makefile                   |  2 +-
 boot/Kconfig               |  4 ++-
 cmd/Kconfig                |  1 +
 common/Kconfig             |  2 +-
 common/spl/Kconfig         |  1 +
 drivers/dfu/Kconfig        |  1 +
 drivers/fastboot/Kconfig   |  1 +
 drivers/net/Kconfig        |  3 ++
 drivers/net/phy/Kconfig    |  2 +-
 drivers/usb/gadget/Kconfig |  2 +-
 net/Kconfig                | 61 +++++++++++++++++++-------------------
 net/Makefile               |  4 +++
 net/lwip/Kconfig           | 49 ++++++++++++++++++++++++++++++
 test/cmd/Makefile          |  2 ++
 test/dm/Makefile           |  2 ++
 16 files changed, 131 insertions(+), 35 deletions(-)
 create mode 100644 net/lwip/Kconfig

diff --git a/Kconfig b/Kconfig
index ab46b27999c..9e3a55798f9 100644
--- a/Kconfig
+++ b/Kconfig
@@ -752,8 +752,37 @@ source "dts/Kconfig"
 
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
diff --git a/Makefile b/Makefile
index 8711831767d..96211738b2f 100644
--- a/Makefile
+++ b/Makefile
@@ -859,7 +859,7 @@ libs-$(CONFIG_OF_EMBED) += dts/
 libs-y += env/
 libs-y += lib/
 libs-y += fs/
-libs-y += net/
+libs-$(filter y,$(CONFIG_NET) $(CONFIG_NET_LWIP)) += net/
 libs-y += disk/
 libs-y += drivers/
 libs-$(CONFIG_SYS_FSL_DDR) += drivers/ddr/fsl/
diff --git a/boot/Kconfig b/boot/Kconfig
index 925afe06a19..1d50a83a2d2 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -503,7 +503,8 @@ config BOOTMETH_ANDROID
 	select ANDROID_AB
 	select ANDROID_BOOT_IMAGE
 	select CMD_BCB
-	select CMD_FASTBOOT
+	imply CMD_FASTBOOT
+	imply FASTBOOT if !NET_LWIP
 	select PARTITION_TYPE_GUID
 	select PARTITION_UUIDS
 	help
@@ -559,6 +560,7 @@ config BOOTMETH_EXTLINUX_PXE
 config BOOTMETH_EFILOADER
 	bool "Bootdev support for EFI boot"
 	depends on EFI_BINARY_EXEC
+	imply CMD_TFTPBOOT if CMD_NET
 	default y
 	help
 	  Enables support for EFI boot using bootdevs. This makes the
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 5ef3c8a8748..3beddd72583 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1661,6 +1661,7 @@ config CMD_USB
 
 config CMD_USB_SDP
 	bool "sdp"
+	depends on USB_GADGET_DOWNLOAD
 	select USB_FUNCTION_SDP
 	help
 	  Enables the command "sdp" which is used to have U-Boot emulating the
diff --git a/common/Kconfig b/common/Kconfig
index c011ab6e820..90cee19d413 100644
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
index 137f94a1681..97bafa50c9e 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -1073,6 +1073,7 @@ config SPL_DM_SPI_FLASH
 
 config SPL_NET
 	bool "Support networking"
+	depends on !NET_LWIP
 	help
 	  Enable support for network devices (such as Ethernet) in SPL.
 	  This permits SPL to load U-Boot over a network link rather than
diff --git a/drivers/dfu/Kconfig b/drivers/dfu/Kconfig
index aadd7e8cf7f..604386bb734 100644
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
index 2f39ec05ac7..9c042808b44 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -48,6 +48,7 @@ config DM_DSA
 	bool "Enable Driver Model for DSA switches"
 	depends on DM_MDIO
 	depends on PHY_FIXED
+	depends on !NET_LWIP
 	help
 	  Enable driver model for DSA switches
 
@@ -342,6 +343,7 @@ config ESSEDMA
 
 config ETH_SANDBOX
 	depends on SANDBOX
+	depends on NET
 	default y
 	bool "Sandbox: Mocked Ethernet driver"
 	help
@@ -363,6 +365,7 @@ config ETH_SANDBOX_LWIP
 
 config ETH_SANDBOX_RAW
 	depends on SANDBOX
+	depends on NET
 	default y
 	bool "Sandbox: Bridge to Linux Raw Sockets"
 	help
diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index a9efc509814..13e73810ad6 100644
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
index f20a16e3e7d..96ed3a2def0 100644
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
index 00000000000..8a67de4cf33
--- /dev/null
+++ b/net/lwip/Kconfig
@@ -0,0 +1,49 @@
+#
+# Network configuration (with lwIP stack)
+#
+
+if NET_LWIP
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
+
+config LWIP_TCP_WND
+	int "Value of TCP_WND"
+	default 8000 if ARCH_QEMU
+	default 3000000
+	help
+	  Default value for TCP_WND in the lwIP configuration
+	  Lower values result in slower wget transfer speeds in
+	  general, especially when the latency on the network is high,
+	  but QEMU with "-net user" needs no more than a few KB or the
+	  transfer will stall and eventually time out.
+
+endif # NET_LWIP
diff --git a/test/cmd/Makefile b/test/cmd/Makefile
index 8f2134998ad..dbee9b26405 100644
--- a/test/cmd/Makefile
+++ b/test/cmd/Makefile
@@ -30,7 +30,9 @@ ifdef CONFIG_SANDBOX
 obj-$(CONFIG_CMD_MBR) += mbr.o
 obj-$(CONFIG_CMD_READ) += rw.o
 obj-$(CONFIG_CMD_SETEXPR) += setexpr.o
+ifdef CONFIG_NET
 obj-$(CONFIG_CMD_WGET) += wget.o
+endif
 obj-$(CONFIG_ARM_FFA_TRANSPORT) += armffa.o
 endif
 obj-$(CONFIG_CMD_TEMPERATURE) += temperature.o
diff --git a/test/dm/Makefile b/test/dm/Makefile
index c12589d487c..03952441278 100644
--- a/test/dm/Makefile
+++ b/test/dm/Makefile
@@ -48,7 +48,9 @@ obj-$(CONFIG_VIDEO_MIPI_DSI) += dsi_host.o
 obj-$(CONFIG_DM_DSA) += dsa.o
 obj-$(CONFIG_ECDSA_VERIFY) += ecdsa.o
 obj-$(CONFIG_EFI_MEDIA_SANDBOX) += efi_media.o
+ifdef CONFIG_NET
 obj-$(CONFIG_DM_ETH) += eth.o
+endif
 obj-$(CONFIG_EXTCON) += extcon.o
 ifneq ($(CONFIG_EFI_PARTITION),)
 obj-$(CONFIG_FASTBOOT_FLASH_MMC) += fastboot.o
-- 
2.40.1

