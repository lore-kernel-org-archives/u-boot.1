Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98DB41099B37
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:56:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3FAD84159;
	Fri, 20 Mar 2026 21:54:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RWxpp6EC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2270A83D71; Fri, 20 Mar 2026 21:53:57 +0100 (CET)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B9F884113
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-46704fbf62dso1594076b6e.1
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040033; x=1774644833; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=8BMvZv71eTceTapz53MgZwBqTUZCOdFJ7b8XTU6vSHM=;
 b=RWxpp6ECJ62YPMxRftpsGZtE3Ket/mSTafB9W3E3KSw8DMAopGGcvqJyGICaBaSuEL
 fu5qxJK4BFDoBsOEIhX4+POo16wM+UKdt6KVn8ziIVI8+AmEc2wC6JKE03yINzskprZZ
 HcSH27IzAmHboorHkmjvjoHkPkd2I9GTMjHQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040033; x=1774644833;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8BMvZv71eTceTapz53MgZwBqTUZCOdFJ7b8XTU6vSHM=;
 b=is+rKZ7eEi1xnp7NQA1YoKo5L3MAOOzMvrHz9I2NaQJKeyZmRk/ysFCF/dz4eM7IFy
 xYkEo+MEQ1iEXxLrpY2P2j+98FgZinyd4G3W7RSB1DJMojH1qnhc0iErvnUmDAfiMJYd
 eMw1PtVR3f6cJKtGwVYB/mL+P2UgljSWHW0742cLtNUic8Te32muNhLRH7WBzdg+l/rg
 4YsI53zLjIiBA89mdjHbXqYTQnRH6Cp8QvHrNjHCLzNcyxsrLT5ubo/6TyjCHGzm28rQ
 oHhCb6Sx1eRkdhYCh5NZ/9t0ayuQ2JWN994Sb+4R8et9MixPQ8fHlqXg3iOb47vPuWEN
 JVqg==
X-Gm-Message-State: AOJu0YxtcY4OKW4IP1Wy7et/wdaENcEdxMkB8VhtmNvfS3pteViTJcxS
 XSypaHLv+kbmvQCZENmULQ0wjG6DqTdr+vegfAdHhbOZsm7rNSAkOFg6NZ1/Yh8o8dtuxBlDb5x
 8ywV2GLI=
X-Gm-Gg: ATEYQzxBwse3aJ4hKRLp9gCkoFgAlZglheoSTuBsJCmcmnG+FLMPOOzdTsnwXAegoRE
 V0oGYy2CPD3d1oFfZLNXqOZ3Kn48GFW5WQWsI0ktkOVOXpyNoRwu6Q2487bLNRpT6BAn5pO6vHX
 Pu+dJBfCm2t52qTcy9x3kOJ8BYkQclTwiv7AFZNYH1ZQycUQiTXmIuDVrI5khy7s3Y3zt9JSORD
 l7Ch5ZOaR/ZEp2fABa4Ofo2/RvDQLL5mrEkVuZ0w93qdefFb3yl71nS8QDfU7uqq/QnThBzKo1H
 M7uFsNsJJaUq+2XU7BMUVm1fYTOiet3QlBYsnvFlsTPZeTU20SqCqQ0ytPoe/XIE+eW9dduxwbp
 UIPExjG6+uuAOILESCEt9Bl8kIZO5iHWo2tHpI0JKsruuJrZ4SmomvlPRJjSBGUjCv/aTmeHoF4
 hwAX5T8u21EX5K3ZrSBgLI7AtpEWejZo9K6SIPPXdqBFFYWYBMM5zpRS2wNuncMr7ryYuLB0CMQ
 7ui01/1dHxlT44dFmShx6VZ8kryqVGmw4xrcKP8zA4zhDcMPuk=
X-Received: by 2002:a05:6808:3442:b0:464:82c5:567c with SMTP id
 5614622812f47-467e5f2521bmr2334827b6e.41.1774040032806; 
 Fri, 20 Mar 2026 13:53:52 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-467e7d4c447sm2047934b6e.6.2026.03.20.13.53.52
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:52 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] spi: Correct dependency on SPI_MEM for many drivers
Date: Fri, 20 Mar 2026 14:53:51 -0600
Message-ID: <20260320205351.3789113-1-trini@konsulko.com>
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

A large number of drivers "depends on" SPI_MEM but this is library type
functionality and so must be select'd instead in order to ensure that
drivers will build. Correct this usage and hide the symbol normally.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 drivers/spi/Kconfig | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index fb88175750fd..4ff17617d990 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -34,7 +34,7 @@ config DM_SPI
 	  spi_slave structure.
 
 config SPI_MEM
-	bool "SPI memory extension"
+	bool
 	select DEVRES
 	help
 	  Enable this option if you want to enable the SPI memory extension.
@@ -43,7 +43,7 @@ config SPI_MEM
 
 config SPI_DIRMAP
 	bool "SPI direct mapping"
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  Enable the SPI direct mapping API. Most modern SPI controllers can
 	  directly map a SPI memory (or a portion of the SPI memory) in the CPU
@@ -62,7 +62,8 @@ config ADI_SPI3
 
 config AIROHA_SNFI_SPI
 	bool "Airoha SPI memory controller driver"
-	depends on SPI_MEM && ARCH_AIROHA
+	depends on ARCH_AIROHA
+	select SPI_MEM
 	help
 	  Enable the Airoha SPI memory controller driver. This driver is
 	  originally based on the Airoha SNFI IP core. It can only be
@@ -102,7 +103,8 @@ config ATH79_SPI
 
 config ATMEL_QSPI
 	bool "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 && SPI_MEM
+	depends on ARCH_AT91
+	select SPI_MEM
 	help
 	  Enable the Atmel Quad SPI controller in master mode. This driver
 	  does not support generic SPI. The implementation supports only the
@@ -152,7 +154,7 @@ config BCMSTB_SPI
 
 config CORTINA_SFLASH
 	bool "Cortina-Access Serial Flash controller driver"
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  Enable the Cortina-Access Serial Flash controller driver. This driver
 	  can be used to access the SPI NOR/NAND flash on platforms embedding this
@@ -160,6 +162,7 @@ config CORTINA_SFLASH
 
 config CADENCE_QSPI
 	bool "Cadence QSPI driver"
+	select SPI_MEM
 	help
 	  Enable the Cadence Quad-SPI (QSPI) driver. This driver can be
 	  used to access the SPI NOR flash on platforms embedding this
@@ -205,7 +208,7 @@ config CF_SPI
 
 config CV1800B_SPIF
 	bool "Sophgo cv1800b SPI Flash Controller driver"
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  Enable the Sophgo cv1800b SPI Flash Controller driver. This driver
 	  can be used to access the SPI NOR flash on platforms embedding this
@@ -243,6 +246,7 @@ config FSL_DSPI
 
 config FSL_QSPI
 	bool "Freescale QSPI driver"
+	select SPI_MEM
 	imply SPI_FLASH_BAR
 	help
 	  Enable the Freescale Quad-SPI (QSPI) driver. This driver can be
@@ -294,6 +298,7 @@ config MESON_SPIFC
 
 config MICROCHIP_COREQSPI
 	bool "Microchip FPGA QSPI Controller driver"
+	select SPI_MEM
 	help
 	  Enable the QSPI driver for Microchip FPGA QSPI controllers.
 	  This driver can be used on Polarfire SoC.
@@ -343,7 +348,7 @@ config MT7621_SPI
 
 config MTK_SNOR
 	bool "Mediatek SPI-NOR controller driver"
-	depends on SPI_MEM
+	select SPI_MEM
 	select DEVRES
 	help
 	  Enable the Mediatek SPINOR controller driver. This driver has
@@ -351,7 +356,7 @@ config MTK_SNOR
 
 config MTK_SNFI_SPI
 	bool "Mediatek SPI memory controller driver"
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  Enable the Mediatek SPI memory controller driver. This driver is
 	  originally based on the MediaTek SNFI IP core. It can only be
@@ -360,7 +365,7 @@ config MTK_SNFI_SPI
 
 config MTK_SPIM
 	bool "Mediatek SPI-MEM master controller driver"
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  Enable MediaTek SPI-MEM master controller driver. This driver mainly
 	  supports SPI flashes. You can use single, dual or quad mode
@@ -385,6 +390,7 @@ config MXS_SPI
 
 config SPI_MXIC
 	bool "Macronix MX25F0A SPI controller"
+	select SPI_MEM
 	help
 	  Enable the Macronix MX25F0A SPI controller driver. This driver
 	  can be used to access the SPI flash on platforms embedding
@@ -403,7 +409,7 @@ config NPCM_PSPI
 
 config NXP_FSPI
 	bool "NXP FlexSPI driver"
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  Enable the NXP FlexSPI (FSPI) driver. This driver can be used to
 	  access the SPI NOR flash on platforms embedding this NXP IP core.
@@ -411,7 +417,7 @@ config NXP_FSPI
 config NXP_XSPI
 	bool "NXP XSPI driver"
 	depends on ARCH_IMX9
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  Enable the NXP External SPI (XSPI) driver. This driver can be used to
 	  access the SPI NOR/NAND flash on platforms embedding this NXP IP core.
@@ -521,7 +527,8 @@ config SANDBOX_SPI_MAX_CS
 
 config SPI_ASPEED_SMC
 	bool "ASPEED SPI flash controller driver"
-	depends on DM_SPI && SPI_MEM && ARCH_ASPEED
+	depends on DM_SPI && ARCH_ASPEED
+	select SPI_MEM
 	help
 	  Enable ASPEED SPI flash controller driver for AST2500
 	  and AST2600 SoCs.
@@ -542,7 +549,7 @@ config SOFT_SPI
 
 config SPI_SN_F_OSPI
 	tristate "Socionext F_OSPI SPI flash controller"
-	depends on SPI_MEM
+	select SPI_MEM
 	help
 	  This enables support for the Socionext F_OSPI controller
 	  for connecting an SPI flash memory over up to 8-bit wide bus.
-- 
2.43.0

