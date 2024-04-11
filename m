Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E7FCD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:28:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EC4DD8821E;
	Thu, 11 Apr 2024 06:28:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="Su4fGpER";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E35C88820C; Thu, 11 Apr 2024 06:28:30 +0200 (CEST)
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com
 [91.218.175.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 05447881ED
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:28:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mELDRdXM40P64I8yegugHiGp89pHIVp3uHsVBflnay4=;
 b=Su4fGpERJ2Po3hLDhilrVE47WWtquBS8mwUSV+26l/lOFLaG6BVJdCyZiepgH+TuisMDjb
 zf3q5+aor3BkL6I2AMCJvgy32LVX4hwhlC9wTqnGGWts6K3p4jY5N/X8g23kimAbmhvRlC
 dyJYghTwVIUqKWFUBv/ok55sIAI86+Rp5jDVQjPUZLssxkVAIKQ9IKvePyDaeG+h2Wh1Kx
 qyJPzpxQDY96sg/53YP+QaXtIfnS2N4dyPeIS5pODl10u+odVo1xokzEMU6lA0RSdbVMVB
 n/ojfXq+T1YGKOHytn5NsAqc1Uk7fHfQBPyLB/59YdWtu90h1cIptOT3dFGbZg==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:28 +1000
Subject: [PATCH RFC 11/15] sunxi: Use SPL_SPINAND for configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-11-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809579; l=3181;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=TixUq2T46BYSLZEPb0152Ety23Tp+UCqgNsjeCEEJAM=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAFiZwh6TDd+UrBEaRQmnQSs3
 8APUmoWNXwzwTEU2S/N07qLG7c7kaD8uhP+S2mhSaslJAbeWACoMLqaxrNj3CCwUAAOlW
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

Use the newly created SPL_SPINAND configuration options instead of
sunxi-only options.

No backwards compatibility is needed as the SPI NAND patches are not
mainline yet.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/mach-sunxi/Kconfig         | 16 ----------------
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 10 +++++-----
 2 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index cc576fc84d..ddf9414b08 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1084,22 +1084,6 @@ config SPL_SPI_SUNXI
 	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
 	  not need any extra configuration.
 
-config SPL_SPI_SUNXI_NAND
-	bool "Support for SPI NAND Flash on Allwinner SoCs in SPL"
-	depends on SPL_SPI_SUNXI
-	help
-	  Enable support for SPI NAND Flash. This option allows SPL to mimic
-	  Allwinner boot ROM's behavior to gain support for SPI NAND Flash;
-	  a fixed page size needs to be assumed when building the SPL image.
-
-config SPL_SPI_SUNXI_NAND_ASSUMED_PAGESIZE
-	hex "Assumed pagesize for SPI NAND Flash in SPL"
-	depends on SPL_SPI_SUNXI_NAND
-	default 0x400 if MACH_SUNIV
-	help
-	  Set the page size assumed by the SPL SPI NAND code, the default
-	  value is the same with the boot ROM.
-
 config PINE64_DT_SELECTION
 	bool "Enable Pine64 device tree selection code"
 	depends on MACH_SUN50I
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 46db2900ca..602ebfe8c5 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -344,7 +344,7 @@ static void spi0_xfer(const u8 *txbuf, u32 txlen, u8 *rxbuf, u32 rxlen)
 	}
 }
 
-#if defined(CONFIG_SPL_SPI_SUNXI_NAND)
+#if defined(CONFIG_SPL_SPINAND_SUPPORT)
 static int spi0_nand_switch_page(u32 page)
 {
 	unsigned count;
@@ -430,11 +430,11 @@ static ulong spi_load_read_nor(struct spl_load_info *load, ulong sector,
 	return count;
 }
 
-#if defined(CONFIG_SPL_SPI_SUNXI_NAND)
+#if defined(CONFIG_SPL_SPINAND_SUPPORT)
 static ulong spi_load_read_nand(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
 {
-	const ulong pagesize = CONFIG_SPL_SPI_SUNXI_NAND_ASSUMED_PAGESIZE;
+	const ulong pagesize = CONFIG_SPL_SPINAND_PAGE_SIZE;
 	ulong remain = count;
 
 	while (remain) {
@@ -501,7 +501,7 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 	spi0_init();
 
 	switch (bootdev->boot_device) {
-#if defined(CONFIG_SPL_SPI_SUNXI_NAND)
+#if defined(CONFIG_SPL_SPINAND_SUPPORT)
 	case BOOT_DEVICE_SPINAND:
 		spi0_nand_reset();
 		load.read = spi_load_read_nand;
@@ -524,6 +524,6 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 /* Use priorty 0 to override the default if it happens to be linked in */
 SPL_LOAD_IMAGE_METHOD("sunxi SPI", 0, BOOT_DEVICE_SPI, spl_spi_load_image);
 
-#if IS_ENABLED(CONFIG_SPL_SPI_SUNXI_NAND)
+#if IS_ENABLED(CONFIG_SPL_SPINAND_SUPPORT)
 SPL_LOAD_IMAGE_METHOD("sunxi SPI NAND", 0, BOOT_DEVICE_SPINAND, spl_spi_load_image);
 #endif

-- 
2.44.0

