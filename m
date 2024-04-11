Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2AECD1297
	for <u-boot@archiver.kernel.org>; Thu, 11 Apr 2024 04:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BE36F881DC;
	Thu, 11 Apr 2024 06:28:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=jookia.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=jookia.org header.i=@jookia.org header.b="sBy+n0ZQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E7A988208; Thu, 11 Apr 2024 06:28:47 +0200 (CEST)
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 407C087FA0
 for <u-boot@lists.denx.de>; Thu, 11 Apr 2024 06:28:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=jookia.org
Authentication-Results: phobos.denx.de;
 spf=none smtp.mailfrom=contact@jookia.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
 t=1712809724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jta+1G9h9yrhT+4h91Zur55fW10VPHtPNFhY2tuVxzI=;
 b=sBy+n0ZQnfbaRHb9RJH+JHYw+AP38Lg30254AU5MhwYr0Gs2CsxMoNGzrPDMIRfbGi2f3n
 TprsrcP86unYMLam6n7ivfQb6SK3gTNF6hznh/CspQ3lwyVAHc71N2cjw8nbkUPhV/uaaj
 E3jstDKyk2KfNGgb8oCPndWAeFJXDUczN7KqgOZJkZNJRZee3+XIExNCKVRSgg7W/OhW+j
 WYkadKE59bsrMJPemqgOFSE+vicM07BxfxWhdSGTvoPryDiqnXVLTwXRE/qi9IJ8YVajUd
 B7HfndcelBbhD2s+vq/51okMVkbY5YavWw+VnQ9JtJ0oLSom3UzQYNMnh+zqJw==
From: John Watts <contact@jookia.org>
Date: Thu, 11 Apr 2024 14:25:30 +1000
Subject: [PATCH RFC 13/15] sunxi: Implement spinand_ helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-spinand-v1-13-62d31bb188e8@jookia.org>
References: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
In-Reply-To: <20240411-spinand-v1-0-62d31bb188e8@jookia.org>
To: Jagan Teki <jagan@amarulasolutions.com>, 
 Andre Przywara <andre.przywara@arm.com>, Tom Rini <trini@konsulko.com>, 
 Daniel Schwierzeck <daniel.schwierzeck@gmail.com>, 
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>, 
 Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, John Watts <contact@jookia.org>
X-Developer-Signature: v=1; a=openssh-sha256; t=1712809587; l=1012;
 i=contact@jookia.org; h=from:subject:message-id;
 bh=6Hq9+6Ld/70aWhqldFEqi9H8jBk1kPy1W9J0YwTUcus=;
 b=U1NIU0lHAAAAAQAAAEoAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAAAgpGuA3uho2
 8zVxm554DVLHyl4gq5/nBHglU5WIWN8/zYAAAAEc3NoOgAAAAZwYXRhdHQAAAAAAAAABnNoYTUx
 MgAAAGcAAAAac2stc3NoLWVkMjU1MTlAb3BlbnNzaC5jb20AAABAqnOHdaFCol2nC0zIsu2TKD/
 HB6DOWXoIVPglwgWw6/BZi39CUZi1XxQLLurlUYqGoqXnSyMdQB5wsohcO2EFCwUAAOly
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

These are used by NAND-aware loaders such as UBI.

Signed-off-by: John Watts <contact@jookia.org>
---
 arch/arm/mach-sunxi/spl_spi_sunxi.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/mach-sunxi/spl_spi_sunxi.c b/arch/arm/mach-sunxi/spl_spi_sunxi.c
index 602ebfe8c5..d6b03678d0 100644
--- a/arch/arm/mach-sunxi/spl_spi_sunxi.c
+++ b/arch/arm/mach-sunxi/spl_spi_sunxi.c
@@ -450,6 +450,27 @@ static ulong spi_load_read_nand(struct spl_load_info *load, ulong sector,
 
 	return count;
 }
+
+void spinand_init(void)
+{
+	spi0_init();
+	spi0_nand_reset();
+}
+
+void spinand_deselect(void)
+{
+	spi0_deinit();
+}
+
+int spinand_spl_read_block(int block, int offset, int len, void *dst)
+{
+	ulong byte_offset = (block * CONFIG_SPL_SPINAND_BLOCK_SIZE) + offset;
+
+	spi_load_read_nand(NULL, byte_offset, len, dst);
+
+	return 0;
+}
+
 #endif
 
 /*****************************************************************************/

-- 
2.44.0

