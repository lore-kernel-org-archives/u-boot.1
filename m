Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AF8C25B78
	for <u-boot@archiver.kernel.org>; Wed, 22 May 2024 16:16:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE7958887A;
	Wed, 22 May 2024 18:16:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BQ2lnpA4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9E0E8884F; Wed, 22 May 2024 18:01:16 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 03DB48886B
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 18:01:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-572b37afd73so11718375a12.2
 for <u-boot@lists.denx.de>; Wed, 22 May 2024 09:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716393671; x=1716998471; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aOi9r/kdgGdi/iapCvYoYClaEPhpDIWstqzLzlxG6Mk=;
 b=BQ2lnpA4c/Krsh9A16L7fcmCKezLGCCNUBFLr+Jj3m4UMw9rVj0iEv9JFhAZXAL347
 ScuH3kpwfHPx7ipSjxkKSr83hPsgworuR5QefbtLKcM0VCGZTXgLAfraDQJTM8hbauFZ
 kHpp1XfFAz/7NCwNVP42LA64HSmYx/3feftuj+YPoO4r6WkhR0yVmJ7UV0ntZnFv7oHP
 cf8DnsWJ5/aIvdS7w5KtLnPJz+HaqaGB7iPhNN79w3eOk0mLaCrSQP5R5Yj4JlXmChn2
 CM1RrVT6zUwpdUKHp5/EaTYvHssqAIcjddlJM8xEvPji+J5PIqFGkdgY9inQiR2GMrB3
 YP1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716393671; x=1716998471;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aOi9r/kdgGdi/iapCvYoYClaEPhpDIWstqzLzlxG6Mk=;
 b=Yx0QL1G0AmmGUy2Fvbf+4lHVr/h1S8quKwZ067d5aFRcZprBZHdC6GeaWUpp7nTR17
 EM4l0u7n3Pjn86A2E9U+DWnZlk3o0aRLOHD0B+QWYuN9soqZx5dBfqX+Jpro97QE+voT
 UtnasfEMqoPNp1xBsArhowPGf/cyMZcvFZvr41A+85iPMRWDcDnndR9VpPTyKbSjpVQO
 mcfm+2+EUuow6ALMc0/pxGJlZgdL+gDFDKB6vOf1aJed0hYaf2MYNNmyZXMZVQs3M0qm
 mYBoU3v3puQ7TNjCtVIwYg0oswGo17xGdFmLQM7sVaq829vur5Gyz4NfqK67df0M7VQA
 2/SQ==
X-Gm-Message-State: AOJu0YxT4PPLA+7r3Kd8VjehbniPkky4dfSOeuECLjdtNcIr6QWcZ6oT
 fB/O5qc9KtfpRyrr+XJW1g2WLYTstrpczqgRp3DrYqu5rcX1l5Al1ARg8g7aUiGB9zDOnfUkoKr
 OUzA197IJ
X-Google-Smtp-Source: AGHT+IHHU4/lznXA0/baLdlfUj3BSHcugH2KyKbnF3NSSwz8iNRXzdmHQ5UEEO8/RPNEJWvLK00ziA==
X-Received: by 2002:a17:906:d11a:b0:a59:a8a4:a59f with SMTP id
 a640c23a62f3a-a6228097062mr158617566b.45.1716393671082; 
 Wed, 22 May 2024 09:01:11 -0700 (PDT)
Received: from jerome-XPS-13-9310.. ([2a01:e0a:3cb:7bb0:d6a3:fbd6:c45b:172c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a6209f64ba8sm367670266b.210.2024.05.22.09.01.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 May 2024 09:01:10 -0700 (PDT)
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
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Bo Gan <ganboing@gmail.com>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 Andrew Davis <afd@ti.com>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Nikhil M Jain <n-jain1@ti.com>, Joshua Watt <jpewhacker@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Leo Yu-Chi Liang <ycliang@andestech.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Samuel Holland <samuel@sholland.org>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Ion Agorria <ion@agorria.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Jonas Karlman <jonas@kwiboo.se>,
 Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 01/15] net: introduce alternative implementation as net-lwip/
Date: Wed, 22 May 2024 18:00:01 +0200
Message-Id: <ff19fb0c9671b4455f65e97a5b0f41c1d9e9ec1b.1716393035.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1716393035.git.jerome.forissier@linaro.org>
References: <cover.1716393035.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 22 May 2024 18:16:41 +0200
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
adding a new net-lwip/ directory and the CONFIG_NET_LWIP symbol. At this
point, enabling CONFIG_NET_LWIP simply disables CONFIG_NET. Subsequent
commits will introduce the lwIP code, re-work the NETDEVICE integration
and port some of the NET commands and features to lwIP.

CONFIG_SPL_NET cannot be enabled when CONFIG_NET_LWIP=y. SPL_NET pulls
some symbols that are part of NET (such as arp_init(),
arp_timeout_check(), arp_receive(), net_arp_wait_packet_ip()).
lwIP support in SPL may be added later.

Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
---
 Kconfig                    |  2 ++
 Makefile                   |  2 +-
 common/Kconfig             |  2 +-
 common/spl/Kconfig         |  1 +
 drivers/dfu/Kconfig        |  2 +-
 drivers/fastboot/Kconfig   |  4 ++--
 drivers/net/phy/Kconfig    |  2 +-
 drivers/usb/gadget/Kconfig |  2 +-
 net-lwip/Kconfig           | 15 +++++++++++++++
 net/Kconfig                |  1 +
 10 files changed, 26 insertions(+), 7 deletions(-)
 create mode 100644 net-lwip/Kconfig

diff --git a/Kconfig b/Kconfig
index 82df59f176..758256ab12 100644
--- a/Kconfig
+++ b/Kconfig
@@ -747,6 +747,8 @@ source "env/Kconfig"
 
 source "net/Kconfig"
 
+source "net-lwip/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/Makefile b/Makefile
index 44deb339af..6296ad6f78 100644
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
index 5e3070e925..807b726384 100644
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
index 6405374bcc..f67f0a859d 100644
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
index 0360d9da14..d331b05993 100644
--- a/drivers/dfu/Kconfig
+++ b/drivers/dfu/Kconfig
@@ -11,7 +11,7 @@ config DFU_OVER_USB
 
 config DFU_OVER_TFTP
 	bool
-	depends on NET
+	depends on NET || NET_LWIP
 
 if DFU
 config DFU_WRITE_ALT
diff --git a/drivers/fastboot/Kconfig b/drivers/fastboot/Kconfig
index 70207573de..05e988166f 100644
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
index 3d96938eab..738752d29c 100644
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
index 4621a6fd5e..03fe3bca19 100644
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
index 0000000000..f8e0481964
--- /dev/null
+++ b/net-lwip/Kconfig
@@ -0,0 +1,15 @@
+#
+# Network configuration (with lwIP stack)
+#
+
+menuconfig NET_LWIP
+	bool "Networking support (lwIP stack) -- EXPERIMENTAL"
+	help
+	  Include networking support based on the lwIP (lightweight IP)
+	  TCP/IP stack (https://nongnu.org/lwip). This is a replacement for
+	  the default U-Boot network stack and applications located in net/
+	  and enabled via CONFIG_NET as well as other pieces of code that
+	  depend on CONFIG_NET (such as cmd/net.c enabled via CONFIG_CMD_NET).
+	  Therefore the two symbols CONFIG_NET and CONFIG_NET_LWIP are mutually
+	  exclusive.
+	  NOTE: This is currently a placeholder.
diff --git a/net/Kconfig b/net/Kconfig
index 5dff633629..04b81dd497 100644
--- a/net/Kconfig
+++ b/net/Kconfig
@@ -6,6 +6,7 @@ menuconfig NET
 	bool "Networking support"
 	default y
 	imply NETDEVICES
+	depends on !NET_LWIP
 
 if NET
 
-- 
2.40.1

