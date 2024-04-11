Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B227CD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:27:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5FF37881E5;
	Thu, 11 Apr 2024 06:27:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="aT0/xgUu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADD5881DC; Thu, 11 Apr 2024 06:27:37 +0200 (CEST)
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::bc])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E61881DD
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:27:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V/i06valPGLsZCOJP6OFxetN72m5WzJI3n3BUE8Kh+g=;
 b=aT0/xgUuMT3svs6rC0DMmu1ZEP/5TaSmS3PGISls8FTe7iAQku6mOzEYeGeG6VLLORa9/m
 aLl2oLX07RLzitEHYLU0HAWJy+Evc8f9JS/jBBnJmKDirdwQH3E+6u0Q4gUdAEIDBWDb5n
 GsvJf+LWEGHOMMbj90H1v1mpcLXcXMuEzvaGFNeVbTbbtwStduY2DzDQfsqPXHWahdIMyc
 FZg/u2QsyEBCdnxyF8pgvksnKIgz2DJM3LYFmjRC7sFYsQL1848aCNtvGMDFBxcbdYAxxo
 wRO6cweGG9Zt9Fbc4FPh4kXZ8EKJcFVbyRGV/0s1FRz18nrDsAzG0J/mbKDeYw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:22 +1000
Subject: [PATCH RFC 05/15] sunxi: SPL SPI: add initial support for booting
 from SPI NAND
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-5-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Samuel Holland <samuel@sholland.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809549; l=4291;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=j1qu9JNduDa04VVZsN9GoKQ3gcGYMN71FxkG9Fq65OA=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABATYIZsEVyLx6gaE7+3UpzNa6
 mrXFAtzNw+QRv/2S2+IvTy5/CmYGeyg2jw+u2LGi6ndOLUmV/UqLW/rpboLkRCwUAAOkx
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

From: Icenowy Zheng <uwu@icenowy.me>

This commit adds support for booting from SPI NAND to SPL SPI code by
mimicing the behavior of boot ROM (use fixed page size and sequentially
try SPI NOR and NAND).

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Tested-by: Samuel Holland <samuel@sholland.org> # Orange Pi Zero Plus
---
 arch/arm/mach-sunxi/Kconfig         | 16 ++++++++
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 75 +++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index ddf9414b08..cc576fc84d 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -1084,6 +1084,22 @@ config SPL_SPI_SUNXI
 	  sunxi SPI Flash. It uses the same method as the boot ROM, so does
 	  not need any extra configuration.
 
+config SPL_SPI_SUNXI_NAND
+	bool "Support for SPI NAND Flash on Allwinner SoCs in SPL"
+	depends on SPL_SPI_SUNXI
+	help
+	  Enable support for SPI NAND Flash. This option allows SPL to mimic
+	  Allwinner boot ROM's behavior to gain support for SPI NAND Flash;
+	  a fixed page size needs to be assumed when building the SPL image.
+
+config SPL_SPI_SUNXI_NAND_ASSUMED_PAGESIZE
+	hex "Assumed pagesize for SPI NAND Flash in SPL"
+	depends on SPL_SPI_SUNXI_NAND
+	default 0x400 if MACH_SUNIV
+	help
+	  Set the page size assumed by the SPL SPI NAND code, the default
+	  value is the same with the boot ROM.
+
 config PINE64_DT_SELECTION
 	bool "Enable Pine64 device tree selection code"
 	depends on MACH_SUN50I
diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 58b1422da1..7ecde2b753 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -344,6 +344,49 @@ static void spi0_xfer(const u8 *txbuf, u32 txlen, u8 *rxbuf, u32 rxlen)
 	}
 }
 
+#if defined(CONFIG_SPL_SPI_SUNXI_NAND)
+static int spi0_nand_switch_page(u32 page)
+{
+	unsigned count;
+	u8 buf[4];
+
+	/* Configure the Page Data Read (13h) command header */
+	buf[0] = 0x13;
+	buf[1] = (u8)(page >> 16);
+	buf[2] = (u8)(page >> 8);
+	buf[3] = (u8)(page);
+
+	spi0_xfer(buf, 4, NULL, 0);
+
+	/* Wait for NAND chip to exit busy state */
+	buf[0] = 0x0f;
+	buf[1] = 0xc0;
+
+	/* Load a NAND page can take up to 2-decimal-digit microseconds */
+	for (count = 0; count < 100; count ++) {
+		udelay(1);
+		spi0_xfer(buf, 2, buf+2, 1);
+		if (!(buf[2] & 0x1))
+			return 0;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void spi0_nand_reset(void)
+{
+	u8 buf[1];
+
+	/* Configure the Device RESET (ffh) command */
+	buf[0] = 0xff;
+
+	spi0_xfer(buf, 1, NULL, 0);
+
+	/* Wait for the NAND to finish resetting */
+	udelay(10);
+}
+#endif
+
 static void spi0_read_data(void *buf, u32 addr, u32 len, u32 addr_len)
 {
 	u8 *buf8 = buf;
@@ -387,6 +430,28 @@ static ulong spi_load_read_nor(struct spl_load_info *load, ulong sector,
 	return count;
 }
 
+#if defined(CONFIG_SPL_SPI_SUNXI_NAND)
+static ulong spi_load_read_nand(struct spl_load_info *load, ulong sector,
+			       ulong count, void *buf)
+{
+	const ulong pagesize = CONFIG_SPL_SPI_SUNXI_NAND_ASSUMED_PAGESIZE;
+	ulong remain = count;
+
+	while (remain) {
+		ulong count_in_page = min(remain, pagesize - (sector % pagesize));
+		ulong current_page = sector / pagesize;
+		if (spi0_nand_switch_page(current_page) != 0)
+			return 0;
+		spi0_read_data(buf, sector % pagesize, count_in_page, 2);
+		remain -= count_in_page;
+		sector += count_in_page;
+		buf += count_in_page;
+	}
+
+	return count;
+}
+#endif
+
 /*****************************************************************************/
 
 static int spl_spi_try_load(struct spl_image_info *spl_image,
@@ -434,10 +499,20 @@ static int spl_spi_load_image(struct spl_image_info *spl_image,
 
 	spi0_init();
 
+#if defined(CONFIG_SPL_SPI_SUNXI_NAND)
+	spi0_nand_reset();
+	load.read = spi_load_read_nand;
+	spl_set_bl_len(&load, 1);
+	ret = spl_spi_try_load(spl_image, bootdev, &load, load_offset, false);
+	if (!ret)
+		goto out;
+#endif
+
 	spl_set_bl_len(&load, 1);
 	load.read = spi_load_read_nor;
 	ret = spl_spi_try_load(spl_image, bootdev, &load, load_offset, true);
 
+out:
 	spi0_deinit();
 
 	return ret;

-- 
2.44.0

