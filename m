Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4079C4332F
	for <u-boot@archiver.kernel.org>; Mon,  6 Nov 2023 03:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3019A870F2;
	Mon,  6 Nov 2023 03:37:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HlmTbKQ3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 07E1786FDE; Mon,  6 Nov 2023 03:29:01 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71C248702F
 for <u-boot@lists.denx.de>; Mon,  6 Nov 2023 03:26:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-66d87554434so28947016d6.2
 for <u-boot@lists.denx.de>; Sun, 05 Nov 2023 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699237589; x=1699842389; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DrjQ5kKfGOQvaZjjQaOQJHOCTnc8v8qKtHBAfdAnCXc=;
 b=HlmTbKQ3REGRWuaaztitoP0e4PHGL0xkhNZ58H55GiXhbBDXlmwEB02bYF5u0lpoqI
 beXDlENKRNbi1xoFMwlb+kZORxQbyDtp0pldpAWpftloRZ5OVGAhcquMD8mR0TY2qmue
 FHNa5o/TGJtCeS/EhrKfKU2R9pMshVIHAEjkOX4/QrQ/FGTfDfSQdN0PqLnvgkQngE2T
 hacY0GSO8d2LG+/tjsHgKE7RY/U1ornMj7KNxi2j2tiLTmWZ1WXnF1BT6V90TRUUeUj3
 nSe98lEpbrjhkJBFcgaX2e0Lxt4PidiNZarhreFngyigfm3A8dNDryS3iYCeISbF3J97
 99yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699237589; x=1699842389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DrjQ5kKfGOQvaZjjQaOQJHOCTnc8v8qKtHBAfdAnCXc=;
 b=tiM/k6OFwEWDJXsVwnVYszGyDCsGwe4JUUzVE/qnPyr2g+xhqcsW7ty1gX1VypiEtm
 yL/RulHs7PSxUcTXpAd7CuAN3CfyNXkAAJsKK++UProbOq0ILutaNvUTVP9WKXLpO8om
 hUp5YLE7tt3z2g+fUhAI0ziyiJL9sE5m3+RgmUMTt40cCnp/j75SDAcAiwLtzHu13JWZ
 +Svx6x4e8lMFgSLfej63uS1f2MYQOzL4R/WBG/h05vmAtEbbQZJOsriOLTLmqh5Hz9Nu
 b1QK5Wim1dXHPS1jun0bMBI+RQge3WXrTXPZWmgwlJCUXxHKnYYS22Gehmovae1+Lvkd
 lD9A==
X-Gm-Message-State: AOJu0YxCyxLegOcatHX3jonbe4tCKpF291sjqrDPmnI1CoHSoNxQYQlJ
 XvCaFR1jFlANLyFMmy8WOTc=
X-Google-Smtp-Source: AGHT+IFojDF2y1HGHsk6r2JjGhWMX5xVcc1NTsMwy9YH1QepNL7V1sz59sMXba6x/VnfIE6Z2MRnZw==
X-Received: by 2002:a05:6214:5085:b0:671:d72e:e158 with SMTP id
 kk5-20020a056214508500b00671d72ee158mr24242724qvb.37.1699237589597; 
 Sun, 05 Nov 2023 18:26:29 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 c6-20020a05621401c600b0066cfb9cc087sm3048514qvt.134.2023.11.05.18.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Nov 2023 18:26:29 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Marek Vasut <marex@denx.de>, Xavier Drudis Ferran <xdrudis@tinet.cat>,
 Stefan Roese <sr@denx.de>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
 Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v6 20/25] spl: Convert nor to spl_load
Date: Sun,  5 Nov 2023 21:25:58 -0500
Message-Id: <20231106022603.3405551-21-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231106022603.3405551-1-seanga2@gmail.com>
References: <20231106022603.3405551-1-seanga2@gmail.com>
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

This converts the nor load method to use spl_load. As a result it also
adds support for LOAD_FIT_FULL. Since this is the last caller of
spl_load_legacy_img, it has been removed.

We can't load FITs with external data with SPL_LOAD_FIT_FULL, so disable the
test in that case. No boards enable SPL_NOR_SUPPORT and SPL_LOAD_FIT_FULL, so
this is not a regression.

Signed-off-by: Sean Anderson <seanga2@gmail.com>
---

Changes in v6:
- Fix LZMA support
- Fix load address
- Explicitly initialize load_info members

Changes in v5:
- Rework to load header in spl_load

 common/spl/spl_legacy.c   | 61 ---------------------------------------
 common/spl/spl_nor.c      | 40 +++++--------------------
 include/spl_load.h        |  1 +
 test/image/spl_load_nor.c |  2 ++
 4 files changed, 10 insertions(+), 94 deletions(-)

diff --git a/common/spl/spl_legacy.c b/common/spl/spl_legacy.c
index a561939b4f0..08687ca8f6c 100644
--- a/common/spl/spl_legacy.c
+++ b/common/spl/spl_legacy.c
@@ -118,64 +118,3 @@ int spl_load_legacy_lzma(struct spl_image_info *spl_image,
 	spl_image->size = lzma_len;
 	return 0;
 }
-
-/*
- * This function is added explicitly to avoid code size increase, when
- * no compression method is enabled. The compiler will optimize the
- * following switch/case statement in spl_load_legacy_img() away due to
- * Dead Code Elimination.
- */
-static inline int spl_image_get_comp(const struct legacy_img_hdr *hdr)
-{
-	if (IS_ENABLED(CONFIG_SPL_LZMA))
-		return image_get_comp(hdr);
-
-	return IH_COMP_NONE;
-}
-
-int spl_load_legacy_img(struct spl_image_info *spl_image,
-			struct spl_boot_device *bootdev,
-			struct spl_load_info *load, ulong offset,
-			struct legacy_img_hdr *hdr)
-{
-	ulong dataptr;
-	int ret;
-
-	/*
-	 * If the payload is compressed, the decompressed data should be
-	 * directly write to its load address.
-	 */
-	if (spl_image_get_comp(hdr) != IH_COMP_NONE)
-		spl_image->flags |= SPL_COPY_PAYLOAD_ONLY;
-
-	ret = spl_parse_image_header(spl_image, bootdev, hdr);
-	if (ret)
-		return ret;
-
-	/* Read image */
-	switch (spl_image_get_comp(hdr)) {
-	case IH_COMP_NONE:
-		dataptr = offset;
-
-		/*
-		 * Image header will be skipped only if SPL_COPY_PAYLOAD_ONLY
-		 * is set
-		 */
-		if (spl_image->flags & SPL_COPY_PAYLOAD_ONLY)
-			dataptr += sizeof(*hdr);
-
-		load->read(load, dataptr, spl_image->size,
-			   map_sysmem(spl_image->load_addr, spl_image->size));
-		break;
-
-	case IH_COMP_LZMA:
-		return spl_load_legacy_lzma(spl_image, load, offset);
-
-	default:
-		debug("Compression method %s is not supported\n",
-		      genimg_get_comp_short_name(image_get_comp(hdr)));
-		return -EINVAL;
-	}
-
-	return 0;
-}
diff --git a/common/spl/spl_nor.c b/common/spl/spl_nor.c
index aad230db4d3..70745114efe 100644
--- a/common/spl/spl_nor.c
+++ b/common/spl/spl_nor.c
@@ -7,8 +7,8 @@
 #include <image.h>
 #include <imx_container.h>
 #include <log.h>
-#include <mapmem.h>
 #include <spl.h>
+#include <spl_load.h>
 
 static ulong spl_nor_load_read(struct spl_load_info *load, ulong sector,
 			       ulong count, void *buf)
@@ -28,8 +28,7 @@ unsigned long __weak spl_nor_get_uboot_base(void)
 static int spl_nor_load_image(struct spl_image_info *spl_image,
 			      struct spl_boot_device *bootdev)
 {
-	struct legacy_img_hdr *header;
-	__maybe_unused struct spl_load_info load;
+	struct spl_load_info load;
 
 	/*
 	 * Loading of the payload to SDRAM is done with skipping of
@@ -43,7 +42,8 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 		 * Load Linux from its location in NOR flash to its defined
 		 * location in SDRAM
 		 */
-		header = (void *)CONFIG_SYS_OS_BASE;
+		const struct legacy_img_hdr *header =
+			(const struct legacy_img_hdr *)CONFIG_SYS_OS_BASE;
 #ifdef CONFIG_SPL_LOAD_FIT
 		if (image_get_magic(header) == FDT_MAGIC) {
 			int ret;
@@ -93,34 +93,8 @@ static int spl_nor_load_image(struct spl_image_info *spl_image,
 	 * Load real U-Boot from its location in NOR flash to its
 	 * defined location in SDRAM
 	 */
-	header = map_sysmem(spl_nor_get_uboot_base(), sizeof(*header));
-#ifdef CONFIG_SPL_LOAD_FIT
-	if (image_get_magic(header) == FDT_MAGIC) {
-		debug("Found FIT format U-Boot\n");
-		spl_set_bl_len(&load, 1);
-		load.read = spl_nor_load_read;
-		return spl_load_simple_fit(spl_image, &load,
-					   spl_nor_get_uboot_base(),
-					   (void *)header);
-	}
-#endif
-	if (IS_ENABLED(CONFIG_SPL_LOAD_IMX_CONTAINER) &&
-	    valid_container_hdr((void *)header)) {
-		spl_set_bl_len(&load, 1);
-		load.read = spl_nor_load_read;
-		return spl_load_imx_container(spl_image, &load,
-					      spl_nor_get_uboot_base());
-	}
-
-	/* Legacy image handling */
-	if (IS_ENABLED(CONFIG_SPL_LEGACY_IMAGE_FORMAT)) {
-		spl_set_bl_len(&load, 1);
-		load.read = spl_nor_load_read;
-		return spl_load_legacy_img(spl_image, bootdev, &load,
-					   spl_nor_get_uboot_base(),
-					   header);
-	}
-
-	return -EINVAL;
+	spl_set_bl_len(&load, 1);
+	load.read = spl_nor_load_read;
+	return spl_load(spl_image, bootdev, &load, 0, spl_nor_get_uboot_base());
 }
 SPL_LOAD_IMAGE_METHOD("NOR", 0, BOOT_DEVICE_NOR, spl_nor_load_image);
diff --git a/include/spl_load.h b/include/spl_load.h
index 4777f84ac6b..b48f80324bb 100644
--- a/include/spl_load.h
+++ b/include/spl_load.h
@@ -100,6 +100,7 @@ static inline int _spl_load(struct spl_image_info *spl_image,
 	IS_ENABLED(CONFIG_SPL_SYS_MMCSD_RAW_MODE) + \
 	(IS_ENABLED(CONFIG_SPL_NAND_SUPPORT) && !IS_ENABLED(CONFIG_SPL_UBI)) + \
 	IS_ENABLED(CONFIG_SPL_NET) + \
+	IS_ENABLED(CONFIG_SPL_NOR_SUPPORT) + \
 	0
 
 #if SPL_LOAD_USERS > 1
diff --git a/test/image/spl_load_nor.c b/test/image/spl_load_nor.c
index a62bb60d253..de5686343b9 100644
--- a/test/image/spl_load_nor.c
+++ b/test/image/spl_load_nor.c
@@ -36,4 +36,6 @@ SPL_IMG_TEST(spl_test_nor, LEGACY, 0);
 SPL_IMG_TEST(spl_test_nor, LEGACY_LZMA, 0);
 SPL_IMG_TEST(spl_test_nor, IMX8, 0);
 SPL_IMG_TEST(spl_test_nor, FIT_INTERNAL, 0);
+#if !IS_ENABLED(CONFIG_SPL_LOAD_FIT_FULL)
 SPL_IMG_TEST(spl_test_nor, FIT_EXTERNAL, 0);
+#endif
-- 
2.37.1

