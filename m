Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1525CC83F1B
	for <u-boot@archiver.kernel.org>; Fri, 11 Jul 2025 15:16:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8612C83018;
	Fri, 11 Jul 2025 17:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FpuJ+cBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC3CE82063; Fri, 11 Jul 2025 17:16:15 +0200 (CEST)
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com
 [IPv6:2607:f8b0:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD45F82FD6
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 17:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x332.google.com with SMTP id
 46e09a7af769-735ac221670so1285780a34.0
 for <u-boot@lists.denx.de>; Fri, 11 Jul 2025 08:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1752246970; x=1752851770; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=l7f/Xm1nYb7usIiIAF7NX3t7vo7liuVM9KvGR8xmv/8=;
 b=FpuJ+cBYPHIkQ0nVfD6wqqgSgEilbTfZLGtjB1/Ht+koM90muzLWRL5PjmpJ+u6IMb
 W2Z005dxZyi2P9+i4IzSvgFkUruR0TQK5zOXRFG9GM5TIUTF0Fapwh+HnRFFc0ss3gxq
 Ofe9+F5X3lIdNCTOCVVOjkYDDHfwWXGZ06IqA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752246970; x=1752851770;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=l7f/Xm1nYb7usIiIAF7NX3t7vo7liuVM9KvGR8xmv/8=;
 b=P0hUk8PfZB0KnoOPaQdrURDZnQEtpy5LW0JEvQ60djX3apmND7TjRMIrcpm8CuTSkX
 CPUlK7nKiRuJSr326DaO339vRvNn7NpAbWWcLX/CUO2j6W4JptfEemqKFzpQGxhce8P+
 k5JFua0FrTj9fkFu0KgDd/0ZsOa01BWlEt3C4gt8Hy6BGPjV/rZA1kXKVaX/cY/22noS
 PX5lVMJiLnnuxpXQ7vn4rcCcHiQMh53Jpd6v26Vr0Okf1aIlyKvmNGae3SI/yD+2CIeP
 Hpzpn1I/RO1KpbiBVS/epedatIlxZ5nm1VPJzEqIVoZsTgu6kazNhyi0V88rvGudxyyf
 LOYQ==
X-Gm-Message-State: AOJu0YzLzmO7fE06wot0iltnZnQuGHMIr9JwJVO6XEQWCZX7otbKCbEK
 eCt+FLq5wev2RTPuCQYoquowNhD9KCbbKV+V7cR4kHyYnd1ppNdfishmQ8UFgzdZCGCAwl5WFOU
 OhJgs9AE=
X-Gm-Gg: ASbGnctoJo16Tm4Qzcr+hrhIH1IdUfRCVEQRDIfFVV58UOcePZDi6a2oPi2LeM2eEn9
 bGWXTMign46WIydomXDd/pJNaIxlGue1RVeV2rwuKAV6ABUnLHlbU36ak9/c3Y64y0jdJrRxs+S
 tJTK8ktEGDFu++B6rpPgnWSdxsTpk3x4APZJ0MJZH5aeSnb3qhglxjN0872hQg/wNThZEJirJpH
 pMxfykBFvnVNR1ytkECcAclMqS4u1+tHwz8WbqJdcBZuZLHNbEFFw0n/TRGeGcaLzmmw8lQyxzy
 X41/8YyJNZnRmpdeF2SLLiECKKsO1+8ok5o9aBiwjdAB1w3nbJ40F+vYFZ2rcAdYPGIy8fEgwML
 mJoeyz2XMKcZ5LzSE/82TwG+h8EWxlRgmNdoYfrRll3NeUW8ejftqrtxi1EA=
X-Google-Smtp-Source: AGHT+IE9vUN0yg4pkFidUwzjD4fmgAqL77UA1Bg87VHaKRh93JqihJIi5v30AVl36WAj8hf7y1DS2Q==
X-Received: by 2002:a05:6830:34a1:b0:73b:30be:66fc with SMTP id
 46e09a7af769-73cfa2d9cfamr2682200a34.12.1752246968617; 
 Fri, 11 Jul 2025 08:16:08 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-73cf10648ccsm586446a34.13.2025.07.11.08.16.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Jul 2025 08:16:08 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>,
	Jaehoon Chung <jh80.chung@samsung.com>
Subject: [PATCH] mmc: Tighten some mmc driver dependencies
Date: Fri, 11 Jul 2025 09:16:07 -0600
Message-ID: <20250711151607.2224269-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

A large number of mmc drivers cannot build without access to some
platform specific header files. Express those requirements in Kconfig as
well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peng Fan <peng.fan@nxp.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>
---
 drivers/mmc/Kconfig | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index 123bd3fa3148..4c46df0ffb87 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -284,7 +284,7 @@ config MMC_DW_K3
 
 config MMC_DW_ROCKCHIP
 	bool "Rockchip SD/MMC controller support"
-	depends on OF_CONTROL
+	depends on OF_CONTROL && ARCH_ROCKCHIP
 	depends on MMC_DW
 	help
 	  This enables support for the Rockchip SD/MMM controller, which is
@@ -382,6 +382,7 @@ config MVEBU_MMC
 
 config MMC_OMAP_HS
 	bool "TI OMAP High Speed Multimedia Card Interface support"
+	depends on ARCH_KEYSTONE || ARCH_OMAP2PLUS
 	select DM_REGULATOR_PBIAS if DM_REGULATOR
 	help
 	  This selects the TI OMAP High Speed Multimedia card Interface.
@@ -588,7 +589,7 @@ config MMC_SDHCI_BCM2835
 
 config MMC_SDHCI_BCMSTB
 	tristate "SDHCI support for the BCMSTB SD/MMC Controller"
-	depends on MMC_SDHCI
+	depends on MMC_SDHCI && (ARCH_BCMSTB || ARCH_BCM283X)
 	help
 	  This selects the Broadcom set-top box SD/MMC controller.
 
@@ -653,7 +654,7 @@ config MMC_SDHCI_F_SDH30
 
 config MMC_SDHCI_MSM
 	bool "Qualcomm SDHCI controller"
-	depends on MMC_SDHCI
+	depends on MMC_SDHCI && ARCH_SNAPDRAGON
 	help
 	  Enables support for SDHCI 2.0 controller present on some Qualcomm
           Snapdragon devices. This device is compatible with eMMC v4.5 and
@@ -699,7 +700,7 @@ config MMC_SDHCI_ROCKCHIP
 
 config MMC_SDHCI_S5P
 	bool "SDHCI support on Samsung S5P SoC"
-	depends on MMC_SDHCI
+	depends on MMC_SDHCI && S5P
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  on Samsung S5P SoCs.
@@ -721,7 +722,7 @@ config MMC_SDHCI_SNPS
 
 config MMC_SDHCI_STI
 	bool "SDHCI support for STMicroelectronics SoC"
-	depends on MMC_SDHCI && OF_CONTROL
+	depends on MMC_SDHCI && OF_CONTROL && ARCH_STI
 	help
 	  This selects the Secure Digital Host Controller Interface (SDHCI)
 	  on STMicroelectronics STiH410 SoC.
@@ -775,6 +776,7 @@ config TEGRA124_MMC_DISABLE_EXT_LOOPBACK
 config MMC_SDHCI_ZYNQ
 	bool "Arasan SDHCI controller support"
 	depends on OF_CONTROL
+	depends on ARCH_VERSAL || ARCH_VERSAL_NET || ARCH_VERSAL2 || ARCH_ZYNQ || ARCH_ZYNQMP
 	depends on MMC_SDHCI
 	help
 	  Support for Arasan SDHCI host controller on Zynq/ZynqMP ARM SoCs platform
@@ -833,7 +835,7 @@ config GENERIC_ATMEL_MCI
 
 config STM32_SDMMC2
 	bool "STMicroelectronics STM32H7 SD/MMC Host Controller support"
-	depends on OF_CONTROL
+	depends on OF_CONTROL && (ARCH_STM32 || ARCH_STM32MP)
 	help
 	  This selects support for the SD/MMC controller on STM32H7 SoCs.
 	  If you have a board based on such a SoC and with a SD/MMC slot,
@@ -867,6 +869,7 @@ config FSL_SDHC_V2_3
 
 config FSL_ESDHC
 	bool "Freescale/NXP eSDHC controller support"
+	depends on ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3 || PPC
 	select FSL_SDHC_V2_3 if ARCH_P1010 || ARCH_BSC9131 || ARCH_BSC9132 \
 		|| ARCH_C29X
 	help
@@ -919,6 +922,7 @@ config ESDHCI_QUIRK_BROKEN_TIMEOUT_VALUE
 
 config FSL_ESDHC_IMX
 	bool "Freescale/NXP i.MX eSDHC controller support"
+	depends on MACH_IMX
 	help
 	  This selects support for the i.MX eSDHC (Enhanced Secure Digital Host
 	  Controller) found on numerous Freescale/NXP SoCs.
-- 
2.43.0

