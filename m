Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BD44C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 17:31:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBF1688C0C;
	Wed,  7 Aug 2024 19:31:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="aw0J+rTK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA31688A84; Wed,  7 Aug 2024 19:12:46 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DE31988C0B
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 19:12:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-3684e8220f9so36756f8f.1
 for <u-boot@lists.denx.de>; Wed, 07 Aug 2024 10:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723050763; x=1723655563; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIfMKH54PO4jrb9Rulst+B/Kp7SIABINTVH29DpRYMg=;
 b=aw0J+rTKg7vnqS4hyb0sxFCO7oe1erGx36AoF4btWT89oJagHWrNQfYZnZLIsaiJl1
 URz4kjCCK7crmN+diGKKP2DLSuPg/991QbSUp1wP3p6STM3jj1O89f4RYuaI5spR9MOH
 cMEg6yTSBvUrDYM6UcMQboiAnrvFkGw4Qc2XwjV1DHMB7mktTKx4hkBvdDKbf4Qaje6i
 d5iUWTmlB37Hqfkcdeb/9q/e3fnjjFj5XkUlKE1cSBZRNUyTmndTqaPJaJqz1csjdHWt
 C04iCiZHe2hhxLGczVCKeN8Yne/9PY6WecAkQOtL/zCvjJcjOCQyEWDQC4BLzs7DOl+o
 nTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723050763; x=1723655563;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vIfMKH54PO4jrb9Rulst+B/Kp7SIABINTVH29DpRYMg=;
 b=NuFOxwv7TgA5XMsR17YTPdWGwy7olcJvmsaeYzigoWAk7bT32DMjfQ8bbFOrrBzW0n
 3qeofvJEcirfFBFiP/r44b3coXJ2+jXj1K8hh5jnpBKFXXXmwyWYCJga5vZEdIF+O74q
 2EUFMuvy9Xu7q7oHbA6KjUCcR2u/l+RDv1wW0r+fZDWe8b3Da/14ThR9b6SOr010p9P3
 nt+IS4aGCGG6ZlYdL6CZ7KLoAuqd8jfklal9KA7SQrcfhd5tcW6Hmf7hL5NGBi3ocq1J
 iF8NuNMuZ8FmGtNT6UqpBKK2Ky8pc9144rP4YpcIerCHW8S7DThwxn0HEPMEjSGMAC7m
 QiaA==
X-Gm-Message-State: AOJu0YxJiANtpyXRYxb6FkBTO8cryJSXqgJZyr5cqvTTb+HI4wanaUxR
 wJ3xKvgofxEMvO5Eq6V4d6ND9GMthhUa3+J7wB/jKsWn1YE3g2BpbTvRfb0l3m5hMYlaLU2e+Qw
 Dze8RNCEa
X-Google-Smtp-Source: AGHT+IHmTMLLVy8790L/sCiuGROshIhaZsPbSBqfvjxZCoyzbL0o2XAkDgtNxTb2uo0n3myBVjc4kQ==
X-Received: by 2002:a05:6000:e4b:b0:367:8e57:8 with SMTP id
 ffacd0b85a97d-36bf0f55796mr2214359f8f.19.1723050762852; 
 Wed, 07 Aug 2024 10:12:42 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:bb3d:43b8:4780:757c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36bbd0597b2sm16623781f8f.81.2024.08.07.10.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Aug 2024 10:12:42 -0700 (PDT)
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
 Simon Glass <sjg@chromium.org>, John Keeping <jkeeping@inmusicbrands.com>,
 Ian Roberts <ian.roberts@timesys.com>,
 Sean Anderson <sean.anderson@seco.com>, Jonas Karlman <jonas@kwiboo.se>,
 Shengyu Qu <wiagn233@outlook.com>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Eddie James <eajames@linux.ibm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>, Stefan Roese <sr@denx.de>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Andre Przywara <andre.przywara@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Lukas Funke <lukas.funke@weidmueller.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Ion Agorria <ion@agorria.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Yang Xiwen <forbidden405@outlook.com>, Gabor Juhos <j4g8y7@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Marko <robert.marko@sartura.hr>,
 Boon Khai Ng <boon.khai.ng@intel.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Baruch Siach <baruch@tkos.co.il>, Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v8 04/23] net: introduce alternative implementation as
 net-lwip/
Date: Wed,  7 Aug 2024 19:11:48 +0200
Message-Id: <3d28b3a7f36acdf5f40492babcc12173dcfd5e95.1723050310.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1723050310.git.jerome.forissier@linaro.org>
References: <cover.1723050310.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 07 Aug 2024 19:31:26 +0200
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

Other adjustments to Kconfig files are made to fix "unmet direct
dependencies detected" for USB_FUNCTION_SDP and CMD_FASTBOOT when
the default networking stack is set to NET_LWIP ("default NET_LWIP"
instead of "default NET" in Kconfig).

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig                    | 30 +++++++++++++++++++
 boot/Kconfig               |  1 +
 cmd/Kconfig                |  1 +
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
 13 files changed, 108 insertions(+), 33 deletions(-)
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
diff --git a/boot/Kconfig b/boot/Kconfig
index 940389d4882..5762de87b21 100644
--- a/boot/Kconfig
+++ b/boot/Kconfig
@@ -502,6 +502,7 @@ config BOOTMETH_ANDROID
 	select ANDROID_BOOT_IMAGE
 	select CMD_BCB
 	select CMD_FASTBOOT
+	select FASTBOOT
 	select PARTITION_TYPE_GUID
 	select PARTITION_UUIDS
 	help
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 978f44eda42..de56c497005 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1644,6 +1644,7 @@ config CMD_USB
 
 config CMD_USB_SDP
 	bool "sdp"
+	depends on USB_GADGET_DOWNLOAD
 	select USB_FUNCTION_SDP
 	help
 	  Enables the command "sdp" which is used to have U-Boot emulating the
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

