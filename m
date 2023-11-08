Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0B1FC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 16:53:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9DC788774F;
	Wed,  8 Nov 2023 17:49:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J5Zygc8k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 492A387741; Wed,  8 Nov 2023 17:49:44 +0100 (CET)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E38B8774F
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 17:49:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-7788ebea620so455261785a.3
 for <u-boot@lists.denx.de>; Wed, 08 Nov 2023 08:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1699462168; x=1700066968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=108RtrjqkYbK2yKirtGLw/AxsyaY4n3hdSUMdgZyd+o=;
 b=J5Zygc8kYGQK+e8UGLrg8KtDjpw1IFVDx9NfvyvNJ9vniRp4heFOK6VbLKKlVdXzoe
 eZdKBOVzpXtwB1Avavi1uM0BKmYkjTk802XP6fxKqebUJnN54C/qOaPI9grJhToyXZGF
 fWLldIEJACvYizr1QDVEg9B9J4E8nt1PSiHcwFRylCRId+nI4NkHeA3rPr98Vqw4UB1a
 0BfAz9rGHAyGU+hX2/fVjfD9Oe32R8OpWVp9m4MQDbpJHC543lgcNQYHmr2VwDmUJaeg
 LlG0h/iyR3lflNFhbCr997+ffLDj2mUILVSl45isnAnxiCzNLpJckpjosCNkYx3Xu9RT
 M5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699462168; x=1700066968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=108RtrjqkYbK2yKirtGLw/AxsyaY4n3hdSUMdgZyd+o=;
 b=f53pUYlGvOmw9w02nnE3fVyFfVbbk6KSTIoMvQSj1pXTxdacnKWSAL2SY5OaCnUlPK
 23JeYBbmX6dvnQq1ciU81Y3usAnKLz+XKoxtgNoP1mA30iSlE9ZnfAxSaxP3Q8tOo5Uy
 a0wO7iPRkcj7TOKW3om7R9MAQWm912fDNCEOonh3BBBq3QB42HrTZRXORPSZO7bIzgCM
 0hb6CEkikAQVcxfOJkkZQ5IBncW5fVLoxv/hjUMAAB8te3bZNp7EvlsiLOpU8q4giXcq
 2bVO3wjo1u4HumaNnN8ewkwJG/p09a77Eig5SlN9r3GD3cXIHoS4cxoOxWOu1vx5Yk0W
 SMiw==
X-Gm-Message-State: AOJu0YzLnzHFRF7Je1ZJTPrY3xpDSWPaLvMkaQHHYg4ALXjWA28zj39s
 kN233ojwBIYlndAJ8Hwy8Eo=
X-Google-Smtp-Source: AGHT+IEvi2KffJlB5gywJMf3SeiZB673qlL0kkn2Bx5z8Pz74gJLQzmp1jS9e6OfnqGBu93mX7WdeA==
X-Received: by 2002:a05:620a:240a:b0:76f:1eac:e726 with SMTP id
 d10-20020a05620a240a00b0076f1eace726mr2402254qkn.15.1699462167913; 
 Wed, 08 Nov 2023 08:49:27 -0800 (PST)
Received: from localhost (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with UTF8SMTPSA id
 b6-20020a05620a0f8600b007758b25ac3bsm1216774qkn.82.2023.11.08.08.49.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Nov 2023 08:49:27 -0800 (PST)
From: Sean Anderson <seanga2@gmail.com>
To: Tom Rini <trini@konsulko.com>,
	u-boot@lists.denx.de
Cc: =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
 Xavier Drudis Ferran <xdrudis@tinet.cat>, Marek Vasut <marex@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Stefan Roese <sr@denx.de>, Sean Anderson <seanga2@gmail.com>
Subject: [PATCH v7 21/26] spl: Convert nor to spl_load
Date: Wed,  8 Nov 2023 11:48:53 -0500
Message-Id: <20231108164858.3497420-22-seanga2@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20231108164858.3497420-1-seanga2@gmail.com>
References: <20231108164858.3497420-1-seanga2@gmail.com>
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
Reviewed-by: Simon Glass <sjg@chromium.org>
---

(no changes since v6)

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

