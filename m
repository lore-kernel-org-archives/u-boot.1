Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFE31C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 20:12:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D7E71820E1;
	Fri,  2 May 2025 22:12:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P453FQMY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9A148214F; Fri,  2 May 2025 22:12:36 +0200 (CEST)
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com
 [IPv6:2607:f8b0:4864:20::c34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 10D0082114
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 22:12:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc34.google.com with SMTP id
 006d021491bc7-6062e41916dso1191485eaf.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746216753; x=1746821553; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=vi7daEm6znZGHbkrS0CMchato7stzLsbgOAXhuqamhQ=;
 b=P453FQMYWcpJ+wj98kKU43FCXgASMTzhYbFPQcLIcSz6SNQwUpBHOcwUpELfRC6XVB
 SZU3Zhc40LufIx5fz+KlMZ7FSLg8GmCp8KENCCpN/r6PH8dm524mQ6N0R/Wy+SceS9D3
 JPFLkqSM0wFeOElIRbphsOX1fdHeKauVXzays=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746216753; x=1746821553;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vi7daEm6znZGHbkrS0CMchato7stzLsbgOAXhuqamhQ=;
 b=XTKAGyKMUJk1NjKlahiUqCsSYOZJL70+o0C1nlcTu/BeIx+ItyJQMCzH3OZjK59xn8
 O7dZWL7ORQTElieZ/JjSzJYhfGUV9zv6sFfU/i9Rlm34SPwEChR/yDPKX5UWVqVL4M8o
 arFN1P51RRHBJfpL6w97ojMrMvQ4grRlSKhSKFlysu9tv7u4wct5qvFlha72nCQjQ/Of
 GBgySy3xMO44FnRPstjw8Fa7n2J2ttEYDH1ykzl14zhmmqTTjw3EcaaSJPWtWkqmcCHP
 Peu6vV+zMvWAuT+CTdOWh0xe+hgedt2TISE1Kca8P/r6wJjUbWPkGAy+ZZA55HJbKM4q
 f8Kw==
X-Gm-Message-State: AOJu0YwXrB8uqNKPe4NvKj/DTPwBO1bb86RW/IS4ZfG9XGHiWTNZ4ef6
 1SmBpaB3gO142b5YHfKnL8dQF9vWNsoiuLCVgMZ/whgQdoN920LFBNfD/PX9nYC0+1q+qNGo1c5
 4
X-Gm-Gg: ASbGnctM+oLkmKtUqemv8s3rfzoVQ//ZxnsXNpIpUDfqhqzgxN9rXc0Tpp0b9Di5+Xk
 9Sf4xgrIEoeLIJLI2tHc+4d7D1+/p6riHPXimrhZr/r9o2M9skMABl3vU+r/mcSIkydFkan2Qz5
 60cfC+3bT2YeAktZPrxQHE+A6umQlzxpBQ52/q57rgHhyHXgkwvJ7dtcXwcDUuIdDq1WxQceDJv
 lD67cmkxPG905cLoe41iuZsU5rGgVeoXsWkRzz1v9hfPz4iqXcSii0Fy03wuAS+msaGd0Y9mANc
 vZLvYp4dsbEz08ZOJW8mkOtkY6WGJxA1Kw6+1w8IVaLRwlecFd0jlTp5vqyFIhSitZuP/xw3a7t
 rYs1I
X-Google-Smtp-Source: AGHT+IEbexOJeGDMkDXp1wCB9D9WvjF5/b9xpfUJE5yTS3I//PO+Ao+/01ulozRbmOVqaSKaCGFGLg==
X-Received: by 2002:a05:6820:1e10:b0:606:26bd:409f with SMTP id
 006d021491bc7-607ee83671emr2586765eaf.6.1746216752706; 
 Fri, 02 May 2025 13:12:32 -0700 (PDT)
Received: from bill-the-cat.. (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-607fb1117e4sm27786eaf.3.2025.05.02.13.12.31
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 13:12:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 2/2] global: Convert almost all remaining non-DM_SERIAL users
Date: Fri,  2 May 2025 14:07:40 -0600
Message-ID: <20250502201226.1369013-3-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502201226.1369013-1-trini@konsulko.com>
References: <20250502201226.1369013-1-trini@konsulko.com>
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

This converts almost all of the remaining non-DM_SERIAL users to enable
DM_SERIAL. These are platforms where there have long been other SoC
boards that have switched and so it's been a matter of inertia keeping
these from being converted. Do so now.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 configs/SBx81LIFKW_defconfig          | 3 +--
 configs/SBx81LIFXCAT_defconfig        | 3 +--
 configs/am43xx_evm_qspiboot_defconfig | 2 +-
 configs/am43xx_hs_evm_qspi_defconfig  | 2 +-
 configs/cl-som-imx7_defconfig         | 1 +
 configs/d2net_v2_defconfig            | 3 +--
 configs/dns325_defconfig              | 3 +--
 configs/guruplug_defconfig            | 3 +--
 configs/ib62x0_defconfig              | 3 +--
 configs/imx6dl_mamoj_defconfig        | 1 +
 configs/imx6ul_geam_mmc_defconfig     | 1 +
 configs/imx6ul_geam_nand_defconfig    | 1 +
 configs/imx6ul_isiot_emmc_defconfig   | 1 +
 configs/imx6ul_isiot_nand_defconfig   | 1 +
 configs/imx7_cm_defconfig             | 1 +
 configs/inetspace_v2_defconfig        | 3 +--
 configs/librem5_defconfig             | 1 +
 configs/liteboard_defconfig           | 1 +
 configs/mx6memcal_defconfig           | 1 +
 configs/nas220_defconfig              | 3 +--
 configs/net2big_v2_defconfig          | 3 +--
 configs/netspace_lite_v2_defconfig    | 3 +--
 configs/netspace_max_v2_defconfig     | 3 +--
 configs/netspace_mini_v2_defconfig    | 3 +--
 configs/netspace_v2_defconfig         | 3 +--
 configs/novena_defconfig              | 1 +
 configs/vinco_defconfig               | 1 +
 27 files changed, 27 insertions(+), 28 deletions(-)

diff --git a/configs/SBx81LIFKW_defconfig b/configs/SBx81LIFKW_defconfig
index 35f5b5bf0d43..0a22a41d8843 100644
--- a/configs/SBx81LIFKW_defconfig
+++ b/configs/SBx81LIFKW_defconfig
@@ -63,8 +63,7 @@ CONFIG_MVGBE=y
 CONFIG_MII=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_MV=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/SBx81LIFXCAT_defconfig b/configs/SBx81LIFXCAT_defconfig
index ed3bc5b2dc5e..523993a456f4 100644
--- a/configs/SBx81LIFXCAT_defconfig
+++ b/configs/SBx81LIFXCAT_defconfig
@@ -61,8 +61,7 @@ CONFIG_MV88E61XX_FIXED_PORTS=0x300
 CONFIG_PHY_FIXED=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/am43xx_evm_qspiboot_defconfig b/configs/am43xx_evm_qspiboot_defconfig
index c538c1ae352f..d6c218693725 100644
--- a/configs/am43xx_evm_qspiboot_defconfig
+++ b/configs/am43xx_evm_qspiboot_defconfig
@@ -53,7 +53,7 @@ CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
 CONFIG_USB=y
diff --git a/configs/am43xx_hs_evm_qspi_defconfig b/configs/am43xx_hs_evm_qspi_defconfig
index 75725e179d79..f7ae7f510770 100644
--- a/configs/am43xx_hs_evm_qspi_defconfig
+++ b/configs/am43xx_hs_evm_qspi_defconfig
@@ -54,7 +54,7 @@ CONFIG_MII=y
 CONFIG_DRIVER_TI_CPSW=y
 CONFIG_POWER_TPS65218=y
 CONFIG_POWER_TPS62362=y
-CONFIG_SYS_NS16550_SERIAL=y
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_TI_QSPI=y
 CONFIG_USB=y
diff --git a/configs/cl-som-imx7_defconfig b/configs/cl-som-imx7_defconfig
index b0231068daa0..21db8c4d045d 100644
--- a/configs/cl-som-imx7_defconfig
+++ b/configs/cl-som-imx7_defconfig
@@ -99,6 +99,7 @@ CONFIG_POWER_LEGACY=y
 CONFIG_POWER_PFUZE3000=y
 CONFIG_DM_REGULATOR=y
 CONFIG_POWER_I2C=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/d2net_v2_defconfig b/configs/d2net_v2_defconfig
index c5e4bb0f409f..a9165530b3de 100644
--- a/configs/d2net_v2_defconfig
+++ b/configs/d2net_v2_defconfig
@@ -66,8 +66,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/dns325_defconfig b/configs/dns325_defconfig
index 1ba02e0595f6..1c8aa96b576f 100644
--- a/configs/dns325_defconfig
+++ b/configs/dns325_defconfig
@@ -56,8 +56,7 @@ CONFIG_MVGBE=y
 CONFIG_MII=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_MV=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
diff --git a/configs/guruplug_defconfig b/configs/guruplug_defconfig
index 540b9184b38d..ec0db1f8626e 100644
--- a/configs/guruplug_defconfig
+++ b/configs/guruplug_defconfig
@@ -58,8 +58,7 @@ CONFIG_MVGBE=y
 CONFIG_MII=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_MV=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
diff --git a/configs/ib62x0_defconfig b/configs/ib62x0_defconfig
index dcfbcc83eb3a..567c7eb3a039 100644
--- a/configs/ib62x0_defconfig
+++ b/configs/ib62x0_defconfig
@@ -57,8 +57,7 @@ CONFIG_MTD=y
 CONFIG_MTD_RAW_NAND=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
diff --git a/configs/imx6dl_mamoj_defconfig b/configs/imx6dl_mamoj_defconfig
index 95797ff0f123..174f768a1ebb 100644
--- a/configs/imx6dl_mamoj_defconfig
+++ b/configs/imx6dl_mamoj_defconfig
@@ -57,6 +57,7 @@ CONFIG_PHY_MICREL_KSZ8XXX=y
 CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
diff --git a/configs/imx6ul_geam_mmc_defconfig b/configs/imx6ul_geam_mmc_defconfig
index a5c3b486987f..73a26250b2c0 100644
--- a/configs/imx6ul_geam_mmc_defconfig
+++ b/configs/imx6ul_geam_mmc_defconfig
@@ -60,5 +60,6 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
diff --git a/configs/imx6ul_geam_nand_defconfig b/configs/imx6ul_geam_nand_defconfig
index 187fae80ff93..c8d95f38a61c 100644
--- a/configs/imx6ul_geam_nand_defconfig
+++ b/configs/imx6ul_geam_nand_defconfig
@@ -66,5 +66,6 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
diff --git a/configs/imx6ul_isiot_emmc_defconfig b/configs/imx6ul_isiot_emmc_defconfig
index f285b82e6dc0..f7ea75597d11 100644
--- a/configs/imx6ul_isiot_emmc_defconfig
+++ b/configs/imx6ul_isiot_emmc_defconfig
@@ -60,5 +60,6 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
diff --git a/configs/imx6ul_isiot_nand_defconfig b/configs/imx6ul_isiot_nand_defconfig
index fe70c1992882..b657e829a6a8 100644
--- a/configs/imx6ul_isiot_nand_defconfig
+++ b/configs/imx6ul_isiot_nand_defconfig
@@ -66,5 +66,6 @@ CONFIG_FEC_MXC=y
 CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
diff --git a/configs/imx7_cm_defconfig b/configs/imx7_cm_defconfig
index a04008c57d87..090bf1d095c9 100644
--- a/configs/imx7_cm_defconfig
+++ b/configs/imx7_cm_defconfig
@@ -92,6 +92,7 @@ CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX7=y
 CONFIG_DM_PMIC=y
 CONFIG_DM_PMIC_PFUZE100=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/inetspace_v2_defconfig b/configs/inetspace_v2_defconfig
index cb097397e22c..34402dd8fe72 100644
--- a/configs/inetspace_v2_defconfig
+++ b/configs/inetspace_v2_defconfig
@@ -66,8 +66,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/librem5_defconfig b/configs/librem5_defconfig
index 05bd08047ee0..5b83f5507b3a 100644
--- a/configs/librem5_defconfig
+++ b/configs/librem5_defconfig
@@ -130,6 +130,7 @@ CONFIG_DM_REGULATOR=y
 CONFIG_DM_REGULATOR_FIXED=y
 CONFIG_DM_REGULATOR_GPIO=y
 CONFIG_POWER_I2C=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
diff --git a/configs/liteboard_defconfig b/configs/liteboard_defconfig
index 9a81e973e3cc..c0fba8194ee9 100644
--- a/configs/liteboard_defconfig
+++ b/configs/liteboard_defconfig
@@ -61,6 +61,7 @@ CONFIG_MII=y
 CONFIG_PINCTRL=y
 CONFIG_PINCTRL_IMX6=y
 CONFIG_DM_REGULATOR=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_IMX_THERMAL=y
 CONFIG_USB=y
diff --git a/configs/mx6memcal_defconfig b/configs/mx6memcal_defconfig
index 800cb7df9121..cde7086064e3 100644
--- a/configs/mx6memcal_defconfig
+++ b/configs/mx6memcal_defconfig
@@ -40,5 +40,6 @@ CONFIG_NO_NET=y
 CONFIG_BOUNCE_BUFFER=y
 # CONFIG_MMC is not set
 CONFIG_FSL_USDHC=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_OF_LIBFDT=y
diff --git a/configs/nas220_defconfig b/configs/nas220_defconfig
index ca70ee963799..faa8faf32f86 100644
--- a/configs/nas220_defconfig
+++ b/configs/nas220_defconfig
@@ -60,8 +60,7 @@ CONFIG_MVGBE=y
 CONFIG_MII=y
 CONFIG_DM_RTC=y
 CONFIG_RTC_MV=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_STORAGE=y
diff --git a/configs/net2big_v2_defconfig b/configs/net2big_v2_defconfig
index 67b883dd699f..a426930ac677 100644
--- a/configs/net2big_v2_defconfig
+++ b/configs/net2big_v2_defconfig
@@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/netspace_lite_v2_defconfig b/configs/netspace_lite_v2_defconfig
index 7c0e42cdde9c..09e49fd0d225 100644
--- a/configs/netspace_lite_v2_defconfig
+++ b/configs/netspace_lite_v2_defconfig
@@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/netspace_max_v2_defconfig b/configs/netspace_max_v2_defconfig
index 65cd79fe2747..53247c60474c 100644
--- a/configs/netspace_max_v2_defconfig
+++ b/configs/netspace_max_v2_defconfig
@@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/netspace_mini_v2_defconfig b/configs/netspace_mini_v2_defconfig
index 1f82c2c22bd2..8f07f6f32f7a 100644
--- a/configs/netspace_mini_v2_defconfig
+++ b/configs/netspace_mini_v2_defconfig
@@ -65,8 +65,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/netspace_v2_defconfig b/configs/netspace_v2_defconfig
index f900d0cb01e6..b2d35696ee09 100644
--- a/configs/netspace_v2_defconfig
+++ b/configs/netspace_v2_defconfig
@@ -67,8 +67,7 @@ CONFIG_DM_SPI_FLASH=y
 CONFIG_SPI_FLASH_MACRONIX=y
 CONFIG_MVGBE=y
 CONFIG_MII=y
-CONFIG_SYS_NS16550_SERIAL=y
-CONFIG_SYS_NS16550_REG_SIZE=-4
+CONFIG_DM_SERIAL=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_KIRKWOOD_SPI=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index bcd40b3f5e5f..bf8fec5566fc 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -82,6 +82,7 @@ CONFIG_PINCTRL_IMX6=y
 CONFIG_POWER_LEGACY=y
 CONFIG_POWER_PFUZE100=y
 CONFIG_POWER_I2C=y
+CONFIG_DM_SERIAL=y
 CONFIG_MXC_UART=y
 CONFIG_DM_THERMAL=y
 CONFIG_IMX_THERMAL=y
diff --git a/configs/vinco_defconfig b/configs/vinco_defconfig
index 86087d4539ee..d17f808f86f5 100644
--- a/configs/vinco_defconfig
+++ b/configs/vinco_defconfig
@@ -51,6 +51,7 @@ CONFIG_PHY_SMSC=y
 CONFIG_ETH_DESIGNWARE=y
 CONFIG_MACB=y
 CONFIG_RMII=y
+CONFIG_DM_SERIAL=y
 CONFIG_ATMEL_USART=y
 CONFIG_SYSRESET=y
 CONFIG_SYSRESET_AT91=y
-- 
2.43.0

