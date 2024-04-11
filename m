Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D71CD1292
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:27:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 043F588003;
	Thu, 11 Apr 2024 06:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="xV2SOIp3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67203881DB; Thu, 11 Apr 2024 06:27:28 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [91.218.175.173])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6DD7387D8E
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:27:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Kg0NiIoEYk+LJyhkzy8bHZIKjziDoLjPpWZp2tBKoJw=;
 b=xV2SOIp3GqPDa40OcghMIh8ZE7iunTd/5k9+1ey71bW1DRro3ZcOE8QLiOn7HE5tjVSwuF
 h/XuQ5xCsZPqTgIrilkRiUpSaYUNCQE/QZoEzoPQEp30TOzvvSpK4ZQYE8a9of0piRmjc1
 8pYQOwToICS10gMVNHhsdVuZ3G4qgDCz9KMKYF3uII9kT8QhtJIGCmm/J6LWxZ6TYnOZkK
 N+ks9HbAxo/sbyO2aURSE9GIo8zTIQNX8Bshg31s6kdtdgn40M2oRVot1C+9jrsJlUMh3f
 mC3fHsrTsA5ebmWiuhueAHHBJ4vVATJV6z+MhoKWg/jpJyDsACUHJsdSdaZocw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:21 +1000
Subject: [PATCH RFC 04/15] sunxi: SPL SPI: allow multiple boot attempt
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-4-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>, 
 Icenowy Zheng <uwu@icenowy.me>, Samuel Holland <samuel@sholland.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809545; l=3364;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=8vLFN0ktagZJ7nXUdwkjdHJ/yQHfm2ny/j7IQYhVRN8=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABApJzOaPHuSTKsZnpylBhN5sd
 dxKoG7LWyWM7JubYAyq6tKuSchojfXXIAl+d5UO7qnHhtXiWkJuV/zOKpOxxaAQUAAOkl
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

As we're going to add support for SPI NAND to this code, add code that
allows multiple boot attempts with different load offsets and functions.

To keep compatibility with loading raw binary on SPI NOR, a bool
parameter is used to allow booting without valid magic number when
booting with SPI NOR.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org> # Orange Pi Zero Plus
---
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 51 ++++++++++++++++++++++++-------------
 1 file changed, 34 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index fe95878eae..58b1422da1 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -379,8 +379,8 @@ static void spi0_read_data(void *buf, u32 addr, u32 len, u32 addr_len)
 	}
 }
 
-static ulong spi_load_read(struct spl_load_info *load, ulong sector,
-			   ulong count, void *buf)
+static ulong spi_load_read_nor(struct spl_load_info *load, ulong sector,
+			       ulong count, void *buf)
 {
 	spi0_read_data(buf, sector, count, 3);
 
@@ -389,38 +389,55 @@ static ulong spi_load_read(struct spl_load_info *load, ulong sector,
 
 /*****************************************************************************/
 
-static int spl_spi_load_image(struct spl_image_info *spl_image,
-			      struct spl_boot_device *bootdev)
+static int spl_spi_try_load(struct spl_image_info *spl_image,
+			    struct spl_boot_device *bootdev,
+			    struct spl_load_info *load, u32 offset,
+			    bool allow_raw)
 {
 	int ret = 0;
 	struct legacy_img_hdr *header;
-	uint32_t load_offset = sunxi_get_spl_size();
-
 	header = (struct legacy_img_hdr *)CONFIG_TEXT_BASE;
-	load_offset = max_t(uint32_t, load_offset, CONFIG_SYS_SPI_U_BOOT_OFFS);
 
-	spi0_init();
-
-	spi0_read_data((void *)header, load_offset, 0x40, 3);
+	if (load->read(load, offset, 0x40, (void *)header) == 0)
+		return -EINVAL;
 
         if (IS_ENABLED(CONFIG_SPL_LOAD_FIT) &&
 		image_get_magic(header) == FDT_MAGIC) {
-		struct spl_load_info load;
 
 		debug("Found FIT image\n");
-		spl_set_bl_len(&load, 1);
-		load.read = spi_load_read;
-		ret = spl_load_simple_fit(spl_image, &load,
-					  load_offset, header);
+		ret = spl_load_simple_fit(spl_image, load,
+					  offset, header);
 	} else {
+		if (!allow_raw && image_get_magic(header) != IH_MAGIC)
+			return -EINVAL;
+
 		ret = spl_parse_image_header(spl_image, bootdev, header);
 		if (ret)
 			return ret;
 
-		spi0_read_data((void *)spl_image->load_addr,
-			       load_offset, spl_image->size, 3);
+		if (load->read(load, offset, spl_image->size,
+			       (void *)spl_image->load_addr) == 0)
+			ret = -EINVAL;
 	}
 
+	return ret;
+}
+
+static int spl_spi_load_image(struct spl_image_info *spl_image,
+			      struct spl_boot_device *bootdev)
+{
+	int ret = 0;
+	uint32_t load_offset = sunxi_get_spl_size();
+	struct spl_load_info load;
+
+	load_offset = max_t(uint32_t, load_offset, CONFIG_SYS_SPI_U_BOOT_OFFS);
+
+	spi0_init();
+
+	spl_set_bl_len(&load, 1);
+	load.read = spi_load_read_nor;
+	ret = spl_spi_try_load(spl_image, bootdev, &load, load_offset, true);
+
 	spi0_deinit();
 
 	return ret;

-- 
2.44.0

