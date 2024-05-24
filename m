Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BB6C25B7C
	for <u-boot@archiver.kernel.org>; Fri, 24 May 2024 17:01:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE4CE888FF;
	Fri, 24 May 2024 19:00:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="nSfbigZa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 38C0888647; Fri, 24 May 2024 18:21:08 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DCDD8884D
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 18:21:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-420180b5838so47040035e9.2
 for <u-boot@lists.denx.de>; Fri, 24 May 2024 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716567663; x=1717172463; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mVSTvCb9mHLT4m5gAOBEeMp0FwU4GhFgqC+puOBNS/M=;
 b=nSfbigZaRiEXgEtfMbAiFPWWk3UvGjPow832M+JfoysMCtLt4NVXOD4/cdVjAf7piF
 +IH3T1Xn8/YJ0w4H0lQRzGtk/TNFVHrk4IKTN+TBygjElFunoMu3S4oGgTa18+XvB5Ta
 5jbYcKuWXSV3dsgRtfOgOXLNOt5/jS7sIoBC5WqOf80q01QIPVyeF/UY/d2ErfsWNDlO
 DG9lGuETh+U8QQ7G96PJCJJbcX07ubWqEHcx09koCBZ0EskRPyvPTNUtL8DmnDA0cryV
 EmyDtDvuvQKHvVitJE4h6e+/JYkr4AtQl+/FyEpLobIp9Hjahtsqa43xY+LA0eIUft/b
 WCwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716567663; x=1717172463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mVSTvCb9mHLT4m5gAOBEeMp0FwU4GhFgqC+puOBNS/M=;
 b=IAjSHfR/BfaBtx9Nkd8SO70OGX1W8O/2V9Qj3TZszzwNAwY7TbHZGMNfDv6zeA4qMG
 pXQC15nYAOELkXdybrBsirVWg3MVDsU3uxKicadadaz35hs3AyyL1STaa9z9J9f1v01o
 V/Yh5w4Fh0efFHf+9cKjfjmBNgYpP5/DQpa16Fy/1hY0ipK+s/VfUHEKn3PHk8YHHTBy
 faJqkGHc4Eaz30oUI/i4QNjcB/hEncuMJy5VbZ1t9BhwSdixQgwWj9fzSGJsHTH86+aX
 oPlB1P1RIuVpft1F2U1xglqJr0ew6X0MhKrTJW+IKWEAHTn2lG7KVXz6c93VW615Mc6+
 74bQ==
X-Gm-Message-State: AOJu0YyI041mM6/0vOMCQlIt5fdOsctpcf/85/G3FtCdy/MOJM74rohR
 AqUxNgzzPgYB1A09n6Zv+Wp+THwIQfi8wPTpt97xkLhrtISb4OvWmP4u5bEL/a0qFsYR8zfeHG9
 Czt+nHsqd
X-Google-Smtp-Source: AGHT+IEBXSNBJDpoZUCY0Gev7o/BrckZ355sB8nBDam3a0rFvm1DWaaF9n+q5QhHm+Jyr1ViwC8spw==
X-Received: by 2002:a05:600c:54ca:b0:41c:12c:aaa2 with SMTP id
 5b1f17b1804b1-42108a17bcfmr21478195e9.33.1716567663543; 
 Fri, 24 May 2024 09:21:03 -0700 (PDT)
Received: from builder.. ([2a01:e0a:3cb:7bb0:80fe:af01:c137:b43b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3557a1c918csm1928465f8f.77.2024.05.24.09.21.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 May 2024 09:21:03 -0700 (PDT)
From: Jerome Forissier <jerome.forissier@linaro.org>
To: u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Javier Tia <javier.tia@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>, Greg Malysa <greg.malysa@timesys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Jonas Karlman <jonas@kwiboo.se>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Shengyu Qu <wiagn233@outlook.com>,
 John Keeping <jkeeping@inmusicbrands.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Sumit Garg <sumit.garg@linaro.org>,
 Bryan Brattlof <bb@ti.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Samuel Dionne-Riel <samuel@dionne-riel.com>,
 Joshua Watt <jpewhacker@gmail.com>, Sean Anderson <sean.anderson@seco.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Samuel Holland <samuel@sholland.org>,
 Jaehoon Chung <jh80.chung@samsung.com>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Quentin Schulz <quentin.schulz@theobroma-systems.com>,
 Ion Agorria <ion@agorria.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH v2 01/14] net: introduce alternative implementation as
 net-lwip/
Date: Fri, 24 May 2024 18:19:55 +0200
Message-Id: <923f66b4a74d9c91c6d661e96dced8e1cbcdc7e0.1716566960.git.jerome.forissier@linaro.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716566960.git.jerome.forissier@linaro.org>
References: <cover.1716566960.git.jerome.forissier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 May 2024 19:00:29 +0200
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
adding a new net-lwip/ directory and the NET_LWIP symbol. At this
point, enabling NET_LWIP simply disables NET. Subsequent commits will
introduce the lwIP code, re-work the NETDEVICE integration and port
some of the NET commands and features to lwIP.

SPL_NET cannot be enabled when NET_LWIP=y. SPL_NET pulls some symbols
that are part of NET (such as arp_init(), arp_timeout_check(),
arp_receive(), net_arp_wait_packet_ip()). lwIP support in SPL may be
added later.

Similarly, DFU_TFTP is not compatible with NET_LWIP because it depends
on net_loop(), tftp_timeout_ms, tftp_timeout_count_max. Let's add a
dependency on !NET_LWIP for now.

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
index 82df59f176e..758256ab121 100644
--- a/Kconfig
+++ b/Kconfig
@@ -747,6 +747,8 @@ source "env/Kconfig"
 
 source "net/Kconfig"
 
+source "net-lwip/Kconfig"
+
 source "drivers/Kconfig"
 
 source "fs/Kconfig"
diff --git a/Makefile b/Makefile
index 79b28c2d81f..3df9c45a17c 100644
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
index 00000000000..f8e0481964f
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
index 5dff6336293..04b81dd4976 100644
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

