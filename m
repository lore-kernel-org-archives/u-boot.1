Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6B53C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 05:41:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0A9AF88312;
	Sat, 27 Apr 2024 07:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="LNRMfmBN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C0108830D; Sat, 27 Apr 2024 07:41:23 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [91.218.175.188])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35E5388312
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1714196479;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5hwuNcCQ8CWblj5WjyJ5xWYra3wLEG0wfAKsXytKJIM=;
 b=LNRMfmBN1FOEpI89eKOP0GsxMCBF+0cN+tvPbjmX7E64fXqT98M9EwyOzm7ZRp4LZSI/bB
 P2l28vaY7TmrQSHU44HrX9WpIH7PFlL7kPt8npNOd+XHjJsedLR4DwY+qAtSbkb1etwMtV
 hAr43b0kJ7c+Ng50265QwSTzIDDXmmlDf0uu/IJ19kg5TG2oXe4BWY5oKhLMdAy25zLzJB
 GacgoDGQ52tskXwDSzE1IBNBCrXhIYA7RBeJRVAAVEYNfpLcpPqkACL/ZDKoLQmqZPwSzj
 c/bwrRIknQ6P8cpl4M0MzEr+dgF63S1pjufxfkElX/4Y8yqI2PVoYANK+gLWww==
From: John Watts <contact@jookia.org>
Date: Sat, 27 Apr 2024 15:40:40 +1000
Subject: [PATCH 1/4] spi: Kconfig: Add some required arch depends for drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240427-spikconfig-v1-1-8a54772522f4@jookia.org>
References: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
In-Reply-To: <20240427-spikconfig-v1-0-8a54772522f4@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, Tom Rini <trini@konsulko.com>, 
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>, 
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>, 
 Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1714196444; l=4412;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=kywAPdeNPCSae6cqkUuaN1aiU8I4stOoBtSSL++2ZjM=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABACPDajBCPQThGoSA0Rxbuh6c
 d4AMQ8F4MenKnWU90gIfxw+qfWyk1A0RNOm2x/vMNWRe/LKcHV931/FBHGu1iBgUAAOsH
X-Developer-Key: i=contact@jookia.org; a=openssh;
 fpr=SHA256:6LBQmZH5u7i/edmEZXzCTwCrpSevs/ZshZxNmlD1thY
X-Migadu-Flow: FLOW_OUT
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

These dependencies are required for building the drivers and create
compile errors if not enabled.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/spi/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 612434633b..025c81adc9 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -93,6 +93,7 @@ config ATMEL_QSPI
 
 config ATMEL_SPI
 	bool "Atmel SPI driver"
+	depends on ARCH_AT91
 	default y if ARCH_AT91
 	help
 	  This enables driver for the Atmel SPI Controller, present on
@@ -126,6 +127,7 @@ config BCM63XX_SPI
 
 config BCMSTB_SPI
 	bool "BCMSTB SPI driver"
+	depends on ARCH_BCMSTB
 	help
 	  Enable the Broadcom set-top box SPI driver. This driver can
 	  be used to access the SPI flash on platforms embedding this
@@ -164,6 +166,7 @@ config CADENCE_OSPI_VERSAL
 
 config CF_SPI
         bool "ColdFire SPI driver"
+        depends on M68K
         help
           Enable the ColdFire SPI driver. This driver can be used on
           some m68k SoCs.
@@ -183,6 +186,7 @@ config DESIGNWARE_SPI
 
 config EXYNOS_SPI
 	bool "Samsung Exynos SPI driver"
+	depends on ARCH_EXYNOS
 	help
 	  Enable the Samsung Exynos SPI driver. This driver can be used to
 	  access the SPI NOR flash on platforms embedding this Samsung
@@ -190,6 +194,7 @@ config EXYNOS_SPI
 
 config FSL_DSPI
 	bool "Freescale DSPI driver"
+	depends on FSL_LAYERSCAPE || ARCH_VF610 || ARCH_LS1021A || ARCH_LS1028A
 	help
 	  Enable the Freescale DSPI driver. This driver can be used to
 	  access the SPI NOR flash and SPI Data flash on platforms embedding
@@ -220,6 +225,7 @@ config GXP_SPI
 
 config ICH_SPI
 	bool "Intel ICH SPI driver"
+	depends on X86
 	help
 	  Enable the Intel ICH SPI driver. This driver can be used to
 	  access the SPI NOR flash on platforms embedding this Intel
@@ -233,6 +239,7 @@ config IPROC_QSPI
 
 config KIRKWOOD_SPI
 	bool "Marvell Kirkwood SPI Driver"
+	depends on ARCH_KIRKWOOD
 	help
 	  Enable support for SPI on various Marvell SoCs, such as
 	  Kirkwood and Armada 375.
@@ -268,6 +275,7 @@ config MPC8XX_SPI
 
 config MPC8XXX_SPI
 	bool "MPC8XXX SPI Driver"
+	depends on MPC83xx || MPC85xx
 	help
 	  Enable support for SPI on the MPC8XXX PowerPC SoCs.
 
@@ -327,6 +335,7 @@ config MVEBU_A3700_SPI
 
 config MXS_SPI
 	bool "MXS SPI Driver"
+	depends on MACH_IMX
 	help
 	  Enable the MXS SPI controller driver. This driver can be used
 	  on the i.MX23 and i.MX28 SoCs.
@@ -512,6 +521,7 @@ config STM32_SPI
 
 config TEGRA114_SPI
 	bool "nVidia Tegra114 SPI driver"
+	depends on ARCH_TEGRA
 	help
 	  Enable the nVidia Tegra114 SPI driver. This driver can be used to
 	  access the SPI NOR flash on platforms embedding this nVidia Tegra114
@@ -522,6 +532,7 @@ config TEGRA114_SPI
 
 config TEGRA20_SFLASH
 	bool "nVidia Tegra20 Serial Flash controller driver"
+	depends on ARCH_TEGRA
 	help
 	  Enable the nVidia Tegra20 Serial Flash controller driver. This driver
 	  can be used to access the SPI NOR flash on platforms embedding this
@@ -529,6 +540,7 @@ config TEGRA20_SFLASH
 
 config TEGRA20_SLINK
 	bool "nVidia Tegra20/Tegra30 SLINK driver"
+	depends on ARCH_TEGRA
 	help
 	  Enable the nVidia Tegra20/Tegra30 SLINK driver. This driver can
 	  be used to access the SPI NOR flash on platforms embedding this
@@ -536,6 +548,7 @@ config TEGRA20_SLINK
 
 config TEGRA210_QSPI
 	bool "nVidia Tegra210 QSPI driver"
+	depends on ARCH_TEGRA
 	help
 	  Enable the Tegra Quad-SPI (QSPI) driver for T210. This driver
 	  be used to access SPI chips on platforms embedding this
@@ -544,6 +557,7 @@ config TEGRA210_QSPI
 config TI_QSPI
 	bool "TI QSPI driver"
 	imply TI_EDMA3
+	depends on ARCH_OMAP2PLUS
 	help
 	  Enable the TI Quad-SPI (QSPI) driver for DRA7xx and AM43xx evms.
 	  This driver support spi flash single, quad and memory reads.
@@ -599,12 +613,14 @@ config FSL_ESPI
 
 config SH_QSPI
 	bool "Renesas Quad SPI driver"
+	depends on ARCH_RENESAS
 	help
 	  Enable the Renesas Quad SPI controller driver. This driver can be
 	  used on Renesas SoCs.
 
 config MXC_SPI
 	bool "MXC SPI Driver"
+	depends on MACH_IMX
 	help
 	  Enable the MXC SPI controller driver. This driver can be used
 	  on various i.MX SoCs such as i.MX31/35/51/6/7.

-- 
2.44.0

