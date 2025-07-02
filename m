Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D415C7EE30
	for <u-boot@archiver.kernel.org>; Wed,  2 Jul 2025 01:04:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C47A82F03;
	Wed,  2 Jul 2025 03:04:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="SPDLNC8G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A9B6081E13; Wed,  2 Jul 2025 03:04:07 +0200 (CEST)
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com
 [IPv6:2001:4860:4864:20::35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B10782EB8
 for <u-boot@lists.denx.de>; Wed,  2 Jul 2025 03:04:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-2ef8dfb3742so982201fac.3
 for <u-boot@lists.denx.de>; Tue, 01 Jul 2025 18:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1751418244; x=1752023044; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YLnO17SYFoYu2gyY5TCuMxBPBbJpTyvwqLAiV1wmJ+o=;
 b=SPDLNC8G1x/Onik1+GFgcjtC2W44wMDiHI/Xe96eBduD4PGdaszXopDg3dVreaL49C
 PoL+WLteL52U6b/7O5INZhsfaO7TPyJoMI5B3waK8ZdEfscp/U6fT7v/9IG8G0LqyA7u
 UPgDEfJQSyOb6jXNP/SnZ+A92lZCNs/NIBVlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751418244; x=1752023044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YLnO17SYFoYu2gyY5TCuMxBPBbJpTyvwqLAiV1wmJ+o=;
 b=p6Su5o1tZd1hNs5kpFYwXfJOB5hhXjoH5b8gsR+YNEgJKMliKO4og6Er/ZY8cs9BcT
 buOsjRO1OfZkKzCfP6mmy5MjYTmtSFb0S1PaZ6qdpWFu7xgiWFi5/1/RpcVRhQxDAlv0
 yffqD2V+gGfn2vBpy9c1utkwA0ioqUhwqsBon6Y/99opmXMQcotT/Jfa3WTKZOXsto1s
 5kwqM45yN2hCpp+1rEz281nbnyynX/H1wZMgGFz5r0uQXGhOcBXL+Mw/L/98ERo03C9r
 wHRlvMVaKHrKpo22lZpTBIvgoFkLImrdkV2SiJGP49aFUUUPTItdeVvi5Woz6kutBXE2
 zjVA==
X-Gm-Message-State: AOJu0Yy35priqRdszfUmg0yD+VYsh3T2n9ZC4HhI6aUWt7ufgxiRR9Su
 bdDhNEqPqPxwKMyN5WOykXi3QLMaZn3LmD8n1XC1D0RYOYyTB0ooZkQEYSJYLatmhWv52FLN/n/
 Zl9YIR1c=
X-Gm-Gg: ASbGnctThnwPIVNRmKxRDTFHjo+nVwgk70tKIJf5TireuCK+CqhWuGbmE7N2hG/8n+Y
 jREgEVI8eqo58TFKs/ZSa+cHJWWIAXYqznGGP6ty6HDIpe60BbE3Kym1SpKcOO7z6wF9c93dfA8
 GSVtJChI2BwS4ZhXz4mt28sfeOGZKgEAkcAjUzPPk8ZogdVexh6eGDmg9mlGeOddpt3otn+l0bj
 QkKXuMUVvBavnPT9MdBjZcIQkMa8syVAW/7Rcv0UI1qoW2tkqrj5JcVSkbCkM0w2rmCt/Tt23Fj
 fEU0/YmGrSunVJXlHg4rsTNRaEVhM/em9iTAuNItmmfSfLCTR8hVSwVVwuu5J9a13vlxPjf/A4/
 /gfAKjluzBBMuw4KZ2UCXM8Y=
X-Google-Smtp-Source: AGHT+IE5eFfcY0umc5n5SE2CPud9nNGQpskXThCFafHDcnfFj8orN0cksmUxmKLmObH4Jn8DAoheCw==
X-Received: by 2002:a05:6870:507:b0:2e9:6a0:80d1 with SMTP id
 586e51a60fabf-2f5a8c8e37dmr698717fac.19.1751418244030; 
 Tue, 01 Jul 2025 18:04:04 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4eb261fsm3613483fac.8.2025.07.01.18.04.03
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:04:03 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] gpio: Tighten some gpio driver dependencies
Date: Tue,  1 Jul 2025 19:04:02 -0600
Message-ID: <20250702010402.18769-1-trini@konsulko.com>
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

A large number of gpio drivers cannot build without access to some platform
specific header files. Express those requirements in Kconfig as well.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/gpio/Kconfig | 40 ++++++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 5dee00f832e8..fd227d46f5ae 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -115,7 +115,7 @@ config ALTERA_PIO
 
 config BCM2835_GPIO
 	bool "BCM2835 GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_BCM283X
 
 config BCM6345_GPIO
 	bool "BCM6345 GPIO driver"
@@ -140,6 +140,7 @@ config DWAPB_GPIO
 
 config AT91_GPIO
 	bool "AT91 PIO GPIO driver"
+	depends on ARCH_AT91
 	help
 	  Say yes here to select AT91 PIO GPIO driver. AT91 PIO
 	  controller manages up to 32 fully programmable input/output
@@ -151,7 +152,7 @@ config AT91_GPIO
 
 config ATMEL_PIO4
 	bool "ATMEL PIO4 driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_AT91
 	help
 	  Say yes here to support the Atmel PIO4 driver.
 	  The PIO4 is new version of Atmel PIO controller, which manages
@@ -194,11 +195,11 @@ config FXL6408_GPIO
 
 config HIKEY_GPIO
 	bool "HI6220 GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && TARGET_HIKEY
 
 config INTEL_BROADWELL_GPIO
 	bool "Intel Broadwell GPIO driver"
-	depends on DM
+	depends on DM_GPIO && X86
 	help
 	  This driver supports Broadwell U devices which have an expanded
 	  GPIO feature set. The difference is large enough to merit a separate
@@ -207,7 +208,7 @@ config INTEL_BROADWELL_GPIO
 
 config INTEL_GPIO
 	bool "Intel generic GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && X86
 	help
 	  Say yes here to select Intel generic GPIO driver. This controller
 	  supports recent chips (e.g. Apollo Lake). It permits basic GPIO
@@ -216,13 +217,13 @@ config INTEL_GPIO
 
 config INTEL_ICH6_GPIO
 	bool "Intel ICH6 compatible legacy GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && X86
 	help
 	  Say yes here to select Intel ICH6 compatible legacy GPIO driver.
 
 config IMX_RGPIO2P
 	bool "i.MX7ULP RGPIO2P driver"
-	depends on DM
+	depends on DM && (ARCH_MX7ULP || ARCH_IMX8ULP || ARCH_IMX9)
 	help
 	  This driver supports i.MX7ULP Rapid GPIO2P controller.
 
@@ -244,12 +245,13 @@ config HSDK_CREG_GPIO
 
 config KIRKWOOD_GPIO
 	bool "Kirkwood GPIO driver"
+	depends on ARCH_KIRKWOOD
 	help
 	  This drdiver supports GPIOs on Kirkwood platforms
 
 config LPC32XX_GPIO
 	bool "LPC32XX GPIO driver"
-	depends on DM
+	depends on DM && ARCH_LPC32XX
 	help
 	  Support for the LPC32XX GPIO driver.
 
@@ -296,7 +298,7 @@ config MSCC_SGPIO
 
 config MSM_GPIO
 	bool "Qualcomm GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_SNAPDRAGON
 	help
 	  Support GPIO controllers on Qualcomm Snapdragon family of SoCs.
 	  This controller have single bank (default name "soc"), every
@@ -309,24 +311,26 @@ config MSM_GPIO
 
 config MXC_GPIO
 	bool "Freescale/NXP MXC GPIO driver"
+	depends on MACH_IMX
 	help
 	  Support GPIO controllers on various i.MX platforms
 
 config MXS_GPIO
 	bool "Freescale/NXP MXS GPIO driver"
+	depends on ARCH_MX23 || ARCH_MX28
 	help
 	  Support GPIO controllers on i.MX23 and i.MX28 platforms
 
 config NPCM_GPIO
 	bool "Nuvoton NPCM GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_NPCM
 	help
 	  Support GPIO controllers on Nuvovon NPCM SoCs.
 	  NPCM7xx/NPCM8xx contain 8 GPIO banks, each bank contains 32 pins.
 
 config NPCM_SGPIO
 	bool "Nuvoton NPCM SGPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_NPCM
 	help
 	  Support Nuvoton BMC NPCM7xx/NPCM8xx sgpio driver support.
 	  Nuvoton NPCM SGPIO module is combine serial to parallel IC (HC595)
@@ -380,7 +384,7 @@ config RZA1_GPIO
 
 config ROCKCHIP_GPIO
 	bool "Rockchip GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_ROCKCHIP
 	help
 	  Support GPIO access on Rockchip SoCs. The GPIOs are arranged into
 	  a number of banks (different for each SoC type) each with 32 GPIOs.
@@ -430,7 +434,7 @@ config XILINX_GPIO
 
 config TEGRA_GPIO
 	bool "Tegra20..210 GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_TEGRA
 	help
 	  Support for the GPIO controller contained in NVIDIA Tegra20 through
 	  Tegra210.
@@ -451,7 +455,7 @@ config GPIO_UNIPHIER
 
 config VYBRID_GPIO
 	bool "Vybrid GPIO driver"
-	depends on DM
+	depends on DM && MACH_IMX
 	help
 	  Say yes here to support Vybrid vf610 GPIOs.
 
@@ -490,7 +494,7 @@ config STM32_GPIO
 
 config SIFIVE_GPIO
 	bool "SiFive GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && RISCV
 	help
 	  Device model driver for GPIO controller present in SiFive FU540 SoC. This
 	  driver enables GPIO interface on HiFive Unleashed A00 board.
@@ -577,7 +581,7 @@ config PCA953X
 
 config MPC8XXX_GPIO
 	bool "Freescale MPC8XXX GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && (PPC || ARCH_LS1021A || FSL_LSCH2 || FSL_LSCH3)
 	help
 	  This driver supports the built-in GPIO controller of MPC8XXX CPUs.
 	  Each GPIO bank is identified by its own entry in the device tree,
@@ -618,7 +622,7 @@ config QE_GPIO
 
 config MPC8XX_GPIO
 	bool "Freescale MPC8XX GPIO driver"
-	depends on DM_GPIO
+	depends on DM_GPIO && PPC
 	help
 	  This driver supports parallel IO ports from MPC8XX CPUs.
 	  Each GPIO bank is identified by its own entry in the device tree.
@@ -685,7 +689,7 @@ config SL28CPLD_GPIO
 
 config SLG7XL45106_I2C_GPO
 	bool "slg7xl45106 i2c gpo expander"
-	depends on DM_GPIO
+	depends on DM_GPIO && ARCH_ZYNQMP
 	help
 	   Support for slg7xl45106 i2c gpo expander. It is an i2c based
 	   8-bit gpo expander, all gpo lines are controlled by writing
-- 
2.43.0

