Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFE69CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:28:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23671881DA;
	Thu, 11 Apr 2024 06:28:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="mwEOQmP0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2270C88203; Thu, 11 Apr 2024 06:28:14 +0200 (CEST)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [91.218.175.180])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D77B8820E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:28:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lzs7HYKNmS8KRA+RhF5cYoNWJ1CvTbrvpODy7HDViKE=;
 b=mwEOQmP0Yf5aapZVeaT4nkpZq40fonBI/wJBZlC13uLXJfNJm86ezv/lf7AT7tf7mGQSPP
 /x876VlNM2NtNUPFsJEhqHAuwPel6pDwvIXtFhWXYC+SFKrGxJ3ai2t0buDrgDwPnRE50g
 NWsshndBV6YjXnmb99wXEBpj+j64trqfyet4Wic/5EO3ltiYQJyCgslwOULwTm2k/aey6o
 wiyW6aKxslyZbDnAFoSFKF3FUkgZWNrVIY0DALMT8e827MAenVv8RGCOTRJL5pRWIsyO11
 hQmp+p7IHhLXpuULCvChufTT6Ef36dzNaZJECU2mi2laquWHURslXgCNdoRrHA==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:26 +1000
Subject: [PATCH RFC 09/15] sunxi: Implement BOOT_DEVICE_SPINAND in SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-9-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809569; l=3428;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=cTqOnM6hyf6ac+zBdGu6hwVzSP3wio7VTt6aVDxcf6g=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAfS6yjjVEv8eDGSESIhK8f5G
 9XPmZs+BWvmdhX+ov6KXpGYqDO4oMOSSYnNTBBSzHASGShLs9KID4TBj/jbLLCQUAAOlR
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

Instead of trying to boot from SPI NAND then SPI NOR in series, select
one based on the current boot device.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/include/asm/arch-sunxi/spl.h |  1 +
 arch/arm/mach-sunxi/board.c           |  5 ++++-
 arch/arm/mach-sunxi/spl_spi_sunxi.c   | 28 ++++++++++++++++++----------
 3 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/arch/arm/include/asm/arch-sunxi/spl.h b/arch/arm/include/asm/arch-sunxi/spl.h
index 92be936d56..a9b7c0daca 100644
--- a/arch/arm/include/asm/arch-sunxi/spl.h
+++ b/arch/arm/include/asm/arch-sunxi/spl.h
@@ -16,6 +16,7 @@
 #define SUNXI_BOOTED_FROM_NAND	1
 #define SUNXI_BOOTED_FROM_MMC2	2
 #define SUNXI_BOOTED_FROM_SPI	3
+#define SUNXI_BOOTED_FROM_SPINAND	4
 
 /*
  * Values taken from the F1C200s BootROM stack
diff --git a/arch/arm/mach-sunxi/board.c b/arch/arm/mach-sunxi/board.c
index 7f4ee92991..e374b75ac2 100644
--- a/arch/arm/mach-sunxi/board.c
+++ b/arch/arm/mach-sunxi/board.c
@@ -222,11 +222,12 @@ static int suniv_get_boot_source(void)
 	switch (brom_call) {
 	case SUNIV_BOOTED_FROM_MMC0:
 		return SUNXI_BOOTED_FROM_MMC0;
-	case SUNIV_BOOTED_FROM_SPI:
 	case SUNIV_BOOTED_FROM_NAND:
 		return SUNXI_BOOTED_FROM_SPI;
 	case SUNIV_BOOTED_FROM_MMC1:
 		return SUNXI_BOOTED_FROM_MMC2;
+	case SUNIV_BOOTED_FROM_SPI:
+		return SUNXI_BOOTED_FROM_SPINAND;
 	}
 	/* If we get here something went wrong try to boot from FEL.*/
 	printf("Unknown boot source from BROM: 0x%x\n", brom_call);
@@ -306,6 +307,8 @@ uint32_t sunxi_get_boot_device(void)
 		return BOOT_DEVICE_MMC2;
 	case SUNXI_BOOTED_FROM_SPI:
 		return BOOT_DEVICE_SPI;
+	case SUNXI_BOOTED_FROM_SPINAND:
+		return BOOT_DEVICE_SPINAND;
 	}
 
 	panic("Unknown boot source %d\n", boot_source);
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 7ecde2b753..46db2900ca 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -494,28 +494,36 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 	int ret = 0;
 	uint32_t load_offset = sunxi_get_spl_size();
 	struct spl_load_info load;
+	bool allow_raw = false;
 
 	load_offset = max_t(uint32_t, load_offset, CONFIG_SYS_SPI_U_BOOT_OFFS);
 
 	spi0_init();
 
+	switch (bootdev->boot_device) {
 #if defined(CONFIG_SPL_SPI_SUNXI_NAND)
-	spi0_nand_reset();
-	load.read = spi_load_read_nand;
-	spl_set_bl_len(&load, 1);
-	ret = spl_spi_try_load(spl_image, bootdev, &load, load_offset, false);
-	if (!ret)
-		goto out;
+	case BOOT_DEVICE_SPINAND:
+		spi0_nand_reset();
+		load.read = spi_load_read_nand;
+		spl_set_bl_len(&load, 1);
+		break;
 #endif
+	case BOOT_DEVICE_SPI:
+		load.read = spi_load_read_nor;
+		spl_set_bl_len(&load, 1);
+		allow_raw = true;
+		break;
+	}
 
-	spl_set_bl_len(&load, 1);
-	load.read = spi_load_read_nor;
-	ret = spl_spi_try_load(spl_image, bootdev, &load, load_offset, true);
+	ret = spl_spi_try_load(spl_image, bootdev, &load, load_offset, allow_raw);
 
-out:
 	spi0_deinit();
 
 	return ret;
 }
 /* Use priorty 0 to override the default if it happens to be linked in */
 SPL_LOAD_IMAGE_METHOD("sunxi SPI", 0, BOOT_DEVICE_SPI, spl_spi_load_image);
+
+#if IS_ENABLED(CONFIG_SPL_SPI_SUNXI_NAND)
+SPL_LOAD_IMAGE_METHOD("sunxi SPI NAND", 0, BOOT_DEVICE_SPINAND, spl_spi_load_image);
+#endif

-- 
2.44.0

