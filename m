Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4ABC282EC
	for <u-boot@archiver.kernel.org>; Sat, 15 Mar 2025 01:27:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5027A8209C;
	Sat, 15 Mar 2025 02:27:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L7jk0eub";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 84CF8820DE; Sat, 15 Mar 2025 02:27:45 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4297D82047
 for <u-boot@lists.denx.de>; Sat, 15 Mar 2025 02:27:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-476964b2c1dso13731061cf.3
 for <u-boot@lists.denx.de>; Fri, 14 Mar 2025 18:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742002062; x=1742606862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aACZAY8pH++CzRwe2n6ayF1kGlksnCUjOKhC0aT3Lfc=;
 b=L7jk0eub0DmHPYUvADOCt+D32/hzPZza4hQxKlljQZ952ZlE7+TYZJlYjJ1gPppeTv
 iXF+567LiGHqgh4J9Rj01+E49AFKw3822V18sWTlAHw/R/ALgFQGLh3AmaF9vpIfnfnM
 DetrsUNraASuDnoeX1cBtV96DbfLULtMEp7VQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742002062; x=1742606862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aACZAY8pH++CzRwe2n6ayF1kGlksnCUjOKhC0aT3Lfc=;
 b=k0a+h/hkBfgMf0PpQTqfJWpvrMrt6OK+FOHYhQh1ULGRz//RM1jKcWxn0FvuA2OxCt
 CVfsvCWlRYMLzeUsn3i7oyoCkrq2upR6xhhO7Oz5vU+LAK5riW7DztQcLV3i3sfJxRLl
 yd3pDs3x+v7S7W73AKewbJzLIxOj1EaOaxoBp4cmqf7Yx2qpxGjLQObT+WzgFusHWcVC
 2O4JaCC3NpOtAKwUPNFgTvQuyu1w94qiMtyrMWwLZzoLZtBCh10BR4W774kiXapjVsLa
 19/N5/O2VILXtWbQh8VVRsa4svDcWaXaSZB8TfBofkB7UIFSdScwdLdAH02ShTwzBqk2
 282A==
X-Gm-Message-State: AOJu0YxBEP1SFdtQCWcHwZXG1FZzKiytn/DeLQjiqM8zy1ALhakIPu3c
 JvZvy7fJD2/zfAxvZLOYWoEfMvthmsBL8BjUxLhBnZzAWdygYhigAwqKLULUnzKuMMA/rUZhgMi
 n
X-Gm-Gg: ASbGncuoFQK6WP93m+s99qTMVrV1U4Dac3g+MzH2WSb5V1bBdpynGDrE5eEZ+Fec+Tv
 3HmE6gH/b1p6RHQprYbdgSiLLdAdgZY9OCgSn3p/KWgKBS7yp2HP4yLcUCSc4MOyE37zlV8oM7e
 F13DOSsotAon3tlLlLBo3wD1HdQZkD5wpKTkVI9Md/R/CDuNRpl5LhZpwVrdAItiR930enu0HIP
 m2eVdPDaOktQ1auA65kW7G36p6ZJH/nwGg3xUP6r9VBpuRRyUssyZzFyF8ukdvb3DVFXBSQvtQR
 gxDs3qi6dYOcfOpbANIyWZHBITk8esZe8cpc6YKSEsfTQjno
X-Google-Smtp-Source: AGHT+IGEEo1f59b3UVazUNwLyVDB/jFGUitiGtz//Og9peBAAxv6/sF2SqjmVXSpeANFg2cK+zHaag==
X-Received: by 2002:a05:622a:134a:b0:476:b461:249b with SMTP id
 d75a77b69052e-476c813ae4amr66602851cf.12.1742002062158; 
 Fri, 14 Mar 2025 18:27:42 -0700 (PDT)
Received: from bill-the-cat.. ([187.192.142.234])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb82c1b7sm29263711cf.74.2025.03.14.18.27.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Mar 2025 18:27:41 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>
Subject: [PATCH 2/2] usb: ulpi: Clean up how we enable support
Date: Fri, 14 Mar 2025 19:27:36 -0600
Message-ID: <20250315012736.399197-2-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250315012736.399197-1-trini@konsulko.com>
References: <20250315012736.399197-1-trini@konsulko.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The way we enable ULPI support today isn't something that should work.
The "optional" keyword in a choice statement is not a documented
feature. To make this work in a supported way, make USB_ULPI something
we ask about if USB_HOST is set. Next, we move the choice of what
viewer to use to be after the framework portion and to depend on that.
We then borrow a few words from the top-level README to make the help
text here clearer. Finally we make the Qualcomm driver select ULPI as
it's required and we make the tegra driver not duplicate a check that
Kconfig now handles for us.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
---
 README                        | 12 ------------
 drivers/usb/host/Kconfig      |  7 +++++--
 drivers/usb/host/ehci-tegra.c |  7 -------
 drivers/usb/ulpi/Kconfig      | 23 ++++++++++++-----------
 4 files changed, 17 insertions(+), 32 deletions(-)

diff --git a/README b/README
index 067c1ee2b646..1c44e65b29a5 100644
--- a/README
+++ b/README
@@ -482,18 +482,6 @@ The following options need to be configured:
 			for your device
 			- CONFIG_USBD_PRODUCTID 0xFFFF
 
-- ULPI Layer Support:
-		The ULPI (UTMI Low Pin (count) Interface) PHYs are supported via
-		the generic ULPI layer. The generic layer accesses the ULPI PHY
-		via the platform viewport, so you need both the genric layer and
-		the viewport enabled. Currently only Chipidea/ARC based
-		viewport is supported.
-		To enable the ULPI layer support, define CONFIG_USB_ULPI and
-		CONFIG_USB_ULPI_VIEWPORT in your board configuration file.
-		If your ULPI phy needs a different reference clock than the
-		standard 24 MHz then you have to define CFG_ULPI_REF_CLK to
-		the appropriate value in Hz.
-
 - MMC Support:
 		CONFIG_SH_MMCIF
 		Support for Renesas on-chip MMCIF controller
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 3dc79770eeb1..5c9e8fc9d15e 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -262,7 +262,7 @@ endif
 config USB_EHCI_MSM
 	bool "Support for Qualcomm on-chip EHCI USB controller"
 	depends on DM_USB
-	select USB_ULPI_VIEWPORT
+	select USB_ULPI
 	select MSM8916_USB_PHY
 	---help---
 	  Enables support for the on-chip EHCI controller on Qualcomm
@@ -279,7 +279,10 @@ config USB_EHCI_TEGRA
 	depends on ARCH_TEGRA
 	select USB_EHCI_IS_TDI
 	---help---
-	  Enable support for Tegra on-chip EHCI USB controller
+	  Enable support for Tegra on-chip EHCI USB controller. If you enable
+	  ULPI and your PHY needs a different reference clock than the standard
+	  24 MHz then you have to define CFG_ULPI_REF_CLK to the appropriate
+	  value in Hz.
 
 config USB_EHCI_ZYNQ
 	bool "Support for Xilinx Zynq on-chip EHCI USB controller"
diff --git a/drivers/usb/host/ehci-tegra.c b/drivers/usb/host/ehci-tegra.c
index 7c73eb66b605..89b87886da18 100644
--- a/drivers/usb/host/ehci-tegra.c
+++ b/drivers/usb/host/ehci-tegra.c
@@ -25,13 +25,6 @@
 #define HOSTPC1_DEVLC	0x84
 #define HOSTPC1_PSPD(x)		(((x) >> 25) & 0x3)
 
-#ifdef CONFIG_USB_ULPI
-	#ifndef CONFIG_USB_ULPI_VIEWPORT
-	#error	"To use CONFIG_USB_ULPI on Tegra Boards you have to also \
-		define CONFIG_USB_ULPI_VIEWPORT"
-	#endif
-#endif
-
 /* Parameters we need for USB */
 enum {
 	PARAM_DIVN,                     /* PLL FEEDBACK DIVIDer */
diff --git a/drivers/usb/ulpi/Kconfig b/drivers/usb/ulpi/Kconfig
index 482114d6c11d..d969360f7eb4 100644
--- a/drivers/usb/ulpi/Kconfig
+++ b/drivers/usb/ulpi/Kconfig
@@ -1,8 +1,18 @@
 comment "ULPI drivers"
 
+config USB_ULPI
+	bool "ULPI support"
+	depends on USB_HOST
+	help
+	  Select to commnicate with USB PHY via ULPI interface.
+	  The ULPI (UTMI Low Pin (count) Interface) is a wrapper on UTMI+ core
+	  that is used as PHY Transreceiver for USB controllers.
+
+	  This driver uses ULPI viewports that are specific for each SoC.
+
 choice
 	prompt "ULPI Viewport type"
-	optional
+	depends on USB_ULPI
 	help
 	  Select ULPI viewport (SoC-side interface to ULPI) implementation
 	  appropriate for the device if you want to communicate with
@@ -10,18 +20,9 @@ choice
 
 config USB_ULPI_VIEWPORT
 	bool "Generic ULPI Viewport"
+	depends on USB_ULPI
 	help
 	  Support generic ULPI Viewport implementation that is used on
 	  some Tegra and Snapdragon devices.
 
 endchoice
-
-config USB_ULPI
-	bool "ULPI support"
-	depends on (USB_ULPI_VIEWPORT || USB_ULPI_VIEWPORT_OMAP)
-	help
-	  Select to commnicate with USB PHY via ULPI interface.
-	  ULPI is wrapper on UTMI+ core that is used as
-	  PHY Transreceiver for USB controllers.
-
-	  This driver uses ULPI viewports that are specific for each SoC.
-- 
2.43.0

