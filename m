Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0839C54E76
	for <u-boot@archiver.kernel.org>; Sat, 18 Nov 2023 21:06:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 094B6874E0;
	Sat, 18 Nov 2023 22:06:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="HJf9xPOF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C281A874CC; Sat, 18 Nov 2023 22:06:12 +0100 (CET)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D54387134
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 22:06:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7afff3ea94dso114788139f.3
 for <u-boot@lists.denx.de>; Sat, 18 Nov 2023 13:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700341563; x=1700946363; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kw7FXqaYS00gu5TVd4WkkQnlwcEAwmfImtMThl6TzNI=;
 b=HJf9xPOF+racSpaj9r8yzS5OXoHDNvUJqiOEFAueF4s3KwQIjqmHR9c32Gc3o9OZJ/
 FNOmdzMWU5+1L7z/7aQ8HejG8NQgtppbQKtxicn320Zwsr1BIeHmsmY9c84fu3xPsgPQ
 qI5Dco3DoEJ3K683h1gSK0XWzZxpTgRsbUTMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700341563; x=1700946363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kw7FXqaYS00gu5TVd4WkkQnlwcEAwmfImtMThl6TzNI=;
 b=afHqFffx/nJK/17KBkqCffubxucWabnQXtERv9xEODvE3TWesfiqsofRqNi6WBPVZw
 u6gvd627EmMHVCgV4OjNez9zgFRIyKV7uQtAxQArTh0+/shC3bldZ9Qo1zTlLQ4NzaAE
 HzAL6WkyqF8qFS8f/Ql4LyTaR+eqgKsR5xVc0CcaP1dURPwrb6cl2ezXOaoh4wPvc8d0
 BO7kwnVlMN83bdYP7ilUEy4zFxQBzwiyhGzjpTOdUbrJAYcccIYan3sPSHGyNZUQ8hBN
 kUrAN2PWViVnvyALjePm8JWrvRYEnZ2oDvnkWruLFJIyl/2SPFVsRQy1qwReSy2qG1y3
 XzfQ==
X-Gm-Message-State: AOJu0YxvGEbHqggEvKAAJBFrmVJFsF7v878ff0f09jbs939UYQKPJVnm
 ogpTkgApTVc7RPZfNJ2QhzA6i4MAOHhHt7RDdY8e+g==
X-Google-Smtp-Source: AGHT+IFdFmJxgXpSc6wMyY2xjuGwem+kxZ2ddC6vvuZs+Ejcl9vwL6Zd+rrPwDisXUyzGRZ/zk76RA==
X-Received: by 2002:a5d:8d86:0:b0:794:da97:d194 with SMTP id
 b6-20020a5d8d86000000b00794da97d194mr3871994ioj.19.1700341562713; 
 Sat, 18 Nov 2023 13:06:02 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 eq11-20020a0566384e2b00b00464001012c7sm1126731jab.129.2023.11.18.13.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Nov 2023 13:06:02 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Eddie James <eajames@linux.ibm.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Safae Ouajih <souajih@baylibre.com>
Subject: [PATCH v3 08/32] bootm: Move boot_get_kernel() higher in the file
Date: Sat, 18 Nov 2023 14:04:56 -0700
Message-ID: <20231118210547.577026-9-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231118210547.577026-1-sjg@chromium.org>
References: <20231118210547.577026-1-sjg@chromium.org>
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

Move this code and image_get_kernel() higher in the file to avoid the
need for a forward declaration.

No attempt is made to remove #ifdefs or adjust the code in any other
way.

Signed-off-by: Simon Glass <sjg@chromium.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---

(no changes since v1)

 boot/bootm.c | 376 +++++++++++++++++++++++++--------------------------
 1 file changed, 186 insertions(+), 190 deletions(-)

diff --git a/boot/bootm.c b/boot/bootm.c
index 1482a2cc783f..598f880d86dd 100644
--- a/boot/bootm.c
+++ b/boot/bootm.c
@@ -44,12 +44,195 @@ DECLARE_GLOBAL_DATA_PTR;
 
 struct bootm_headers images;		/* pointers to os/initrd/fdt images */
 
+__weak void board_quiesce_devices(void)
+{
+}
+
+#if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
+/**
+ * image_get_kernel - verify legacy format kernel image
+ * @img_addr: in RAM address of the legacy format image to be verified
+ * @verify: data CRC verification flag
+ *
+ * image_get_kernel() verifies legacy image integrity and returns pointer to
+ * legacy image header if image verification was completed successfully.
+ *
+ * returns:
+ *     pointer to a legacy image header if valid image was found
+ *     otherwise return NULL
+ */
+static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
+{
+	struct legacy_img_hdr *hdr = (struct legacy_img_hdr *)img_addr;
+
+	if (!image_check_magic(hdr)) {
+		puts("Bad Magic Number\n");
+		bootstage_error(BOOTSTAGE_ID_CHECK_MAGIC);
+		return NULL;
+	}
+	bootstage_mark(BOOTSTAGE_ID_CHECK_HEADER);
+
+	if (!image_check_hcrc(hdr)) {
+		puts("Bad Header Checksum\n");
+		bootstage_error(BOOTSTAGE_ID_CHECK_HEADER);
+		return NULL;
+	}
+
+	bootstage_mark(BOOTSTAGE_ID_CHECK_CHECKSUM);
+	image_print_contents(hdr);
+
+	if (verify) {
+		puts("   Verifying Checksum ... ");
+		if (!image_check_dcrc(hdr)) {
+			printf("Bad Data CRC\n");
+			bootstage_error(BOOTSTAGE_ID_CHECK_CHECKSUM);
+			return NULL;
+		}
+		puts("OK\n");
+	}
+	bootstage_mark(BOOTSTAGE_ID_CHECK_ARCH);
+
+	if (!image_check_target_arch(hdr)) {
+		printf("Unsupported Architecture 0x%x\n", image_get_arch(hdr));
+		bootstage_error(BOOTSTAGE_ID_CHECK_ARCH);
+		return NULL;
+	}
+	return hdr;
+}
+#endif
+
+/**
+ * boot_get_kernel - find kernel image
+ * @os_data: pointer to a ulong variable, will hold os data start address
+ * @os_len: pointer to a ulong variable, will hold os data length
+ *
+ * boot_get_kernel() tries to find a kernel image, verifies its integrity
+ * and locates kernel data.
+ *
+ * returns:
+ *     pointer to image header if valid image was found, plus kernel start
+ *     address and length, otherwise NULL
+ */
 static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
 				   char *const argv[], struct bootm_headers *images,
-				   ulong *os_data, ulong *os_len);
-
-__weak void board_quiesce_devices(void)
+				   ulong *os_data, ulong *os_len)
 {
+#if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
+	struct legacy_img_hdr	*hdr;
+#endif
+	ulong		img_addr;
+	const void *buf;
+	const char	*fit_uname_config = NULL;
+	const char	*fit_uname_kernel = NULL;
+#if CONFIG_IS_ENABLED(FIT)
+	int		os_noffset;
+#endif
+
+#ifdef CONFIG_ANDROID_BOOT_IMAGE
+	const void *boot_img;
+	const void *vendor_boot_img;
+#endif
+	img_addr = genimg_get_kernel_addr_fit(argc < 1 ? NULL : argv[0],
+					      &fit_uname_config,
+					      &fit_uname_kernel);
+
+	if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
+		img_addr += image_load_offset;
+
+	bootstage_mark(BOOTSTAGE_ID_CHECK_MAGIC);
+
+	/* check image type, for FIT images get FIT kernel node */
+	*os_data = *os_len = 0;
+	buf = map_sysmem(img_addr, 0);
+	switch (genimg_get_format(buf)) {
+#if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
+	case IMAGE_FORMAT_LEGACY:
+		printf("## Booting kernel from Legacy Image at %08lx ...\n",
+		       img_addr);
+		hdr = image_get_kernel(img_addr, images->verify);
+		if (!hdr)
+			return NULL;
+		bootstage_mark(BOOTSTAGE_ID_CHECK_IMAGETYPE);
+
+		/* get os_data and os_len */
+		switch (image_get_type(hdr)) {
+		case IH_TYPE_KERNEL:
+		case IH_TYPE_KERNEL_NOLOAD:
+			*os_data = image_get_data(hdr);
+			*os_len = image_get_data_size(hdr);
+			break;
+		case IH_TYPE_MULTI:
+			image_multi_getimg(hdr, 0, os_data, os_len);
+			break;
+		case IH_TYPE_STANDALONE:
+			*os_data = image_get_data(hdr);
+			*os_len = image_get_data_size(hdr);
+			break;
+		default:
+			printf("Wrong Image Type for %s command\n",
+			       cmdtp->name);
+			bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
+			return NULL;
+		}
+
+		/*
+		 * copy image header to allow for image overwrites during
+		 * kernel decompression.
+		 */
+		memmove(&images->legacy_hdr_os_copy, hdr,
+			sizeof(struct legacy_img_hdr));
+
+		/* save pointer to image header */
+		images->legacy_hdr_os = hdr;
+
+		images->legacy_hdr_valid = 1;
+		bootstage_mark(BOOTSTAGE_ID_DECOMP_IMAGE);
+		break;
+#endif
+#if CONFIG_IS_ENABLED(FIT)
+	case IMAGE_FORMAT_FIT:
+		os_noffset = fit_image_load(images, img_addr,
+				&fit_uname_kernel, &fit_uname_config,
+				IH_ARCH_DEFAULT, IH_TYPE_KERNEL,
+				BOOTSTAGE_ID_FIT_KERNEL_START,
+				FIT_LOAD_IGNORED, os_data, os_len);
+		if (os_noffset < 0)
+			return NULL;
+
+		images->fit_hdr_os = map_sysmem(img_addr, 0);
+		images->fit_uname_os = fit_uname_kernel;
+		images->fit_uname_cfg = fit_uname_config;
+		images->fit_noffset_os = os_noffset;
+		break;
+#endif
+#ifdef CONFIG_ANDROID_BOOT_IMAGE
+	case IMAGE_FORMAT_ANDROID:
+		boot_img = buf;
+		vendor_boot_img = NULL;
+		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
+			boot_img = map_sysmem(get_abootimg_addr(), 0);
+			vendor_boot_img = map_sysmem(get_avendor_bootimg_addr(), 0);
+		}
+		printf("## Booting Android Image at 0x%08lx ...\n", img_addr);
+		if (android_image_get_kernel(boot_img, vendor_boot_img, images->verify,
+					     os_data, os_len))
+			return NULL;
+		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
+			unmap_sysmem(vendor_boot_img);
+			unmap_sysmem(boot_img);
+		}
+		break;
+#endif
+	default:
+		printf("Wrong Image Format for %s command\n", cmdtp->name);
+		bootstage_error(BOOTSTAGE_ID_FIT_KERNEL_INFO);
+		return NULL;
+	}
+
+	debug("   kernel data at 0x%08lx, len = 0x%08lx (%ld)\n",
+	      *os_data, *os_len, *os_len);
+
+	return buf;
 }
 
 #ifdef CONFIG_LMB
@@ -942,193 +1125,6 @@ int bootm_boot_start(ulong addr, const char *cmdline)
 	return ret;
 }
 
-#if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
-/**
- * image_get_kernel - verify legacy format kernel image
- * @img_addr: in RAM address of the legacy format image to be verified
- * @verify: data CRC verification flag
- *
- * image_get_kernel() verifies legacy image integrity and returns pointer to
- * legacy image header if image verification was completed successfully.
- *
- * returns:
- *     pointer to a legacy image header if valid image was found
- *     otherwise return NULL
- */
-static struct legacy_img_hdr *image_get_kernel(ulong img_addr, int verify)
-{
-	struct legacy_img_hdr *hdr = (struct legacy_img_hdr *)img_addr;
-
-	if (!image_check_magic(hdr)) {
-		puts("Bad Magic Number\n");
-		bootstage_error(BOOTSTAGE_ID_CHECK_MAGIC);
-		return NULL;
-	}
-	bootstage_mark(BOOTSTAGE_ID_CHECK_HEADER);
-
-	if (!image_check_hcrc(hdr)) {
-		puts("Bad Header Checksum\n");
-		bootstage_error(BOOTSTAGE_ID_CHECK_HEADER);
-		return NULL;
-	}
-
-	bootstage_mark(BOOTSTAGE_ID_CHECK_CHECKSUM);
-	image_print_contents(hdr);
-
-	if (verify) {
-		puts("   Verifying Checksum ... ");
-		if (!image_check_dcrc(hdr)) {
-			printf("Bad Data CRC\n");
-			bootstage_error(BOOTSTAGE_ID_CHECK_CHECKSUM);
-			return NULL;
-		}
-		puts("OK\n");
-	}
-	bootstage_mark(BOOTSTAGE_ID_CHECK_ARCH);
-
-	if (!image_check_target_arch(hdr)) {
-		printf("Unsupported Architecture 0x%x\n", image_get_arch(hdr));
-		bootstage_error(BOOTSTAGE_ID_CHECK_ARCH);
-		return NULL;
-	}
-	return hdr;
-}
-#endif
-
-/**
- * boot_get_kernel - find kernel image
- * @os_data: pointer to a ulong variable, will hold os data start address
- * @os_len: pointer to a ulong variable, will hold os data length
- *
- * boot_get_kernel() tries to find a kernel image, verifies its integrity
- * and locates kernel data.
- *
- * returns:
- *     pointer to image header if valid image was found, plus kernel start
- *     address and length, otherwise NULL
- */
-static const void *boot_get_kernel(struct cmd_tbl *cmdtp, int flag, int argc,
-				   char *const argv[], struct bootm_headers *images,
-				   ulong *os_data, ulong *os_len)
-{
-#if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
-	struct legacy_img_hdr	*hdr;
-#endif
-	ulong		img_addr;
-	const void *buf;
-	const char	*fit_uname_config = NULL;
-	const char	*fit_uname_kernel = NULL;
-#if CONFIG_IS_ENABLED(FIT)
-	int		os_noffset;
-#endif
-
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
-	const void *boot_img;
-	const void *vendor_boot_img;
-#endif
-	img_addr = genimg_get_kernel_addr_fit(argc < 1 ? NULL : argv[0],
-					      &fit_uname_config,
-					      &fit_uname_kernel);
-
-	if (IS_ENABLED(CONFIG_CMD_BOOTM_PRE_LOAD))
-		img_addr += image_load_offset;
-
-	bootstage_mark(BOOTSTAGE_ID_CHECK_MAGIC);
-
-	/* check image type, for FIT images get FIT kernel node */
-	*os_data = *os_len = 0;
-	buf = map_sysmem(img_addr, 0);
-	switch (genimg_get_format(buf)) {
-#if CONFIG_IS_ENABLED(LEGACY_IMAGE_FORMAT)
-	case IMAGE_FORMAT_LEGACY:
-		printf("## Booting kernel from Legacy Image at %08lx ...\n",
-		       img_addr);
-		hdr = image_get_kernel(img_addr, images->verify);
-		if (!hdr)
-			return NULL;
-		bootstage_mark(BOOTSTAGE_ID_CHECK_IMAGETYPE);
-
-		/* get os_data and os_len */
-		switch (image_get_type(hdr)) {
-		case IH_TYPE_KERNEL:
-		case IH_TYPE_KERNEL_NOLOAD:
-			*os_data = image_get_data(hdr);
-			*os_len = image_get_data_size(hdr);
-			break;
-		case IH_TYPE_MULTI:
-			image_multi_getimg(hdr, 0, os_data, os_len);
-			break;
-		case IH_TYPE_STANDALONE:
-			*os_data = image_get_data(hdr);
-			*os_len = image_get_data_size(hdr);
-			break;
-		default:
-			printf("Wrong Image Type for %s command\n",
-			       cmdtp->name);
-			bootstage_error(BOOTSTAGE_ID_CHECK_IMAGETYPE);
-			return NULL;
-		}
-
-		/*
-		 * copy image header to allow for image overwrites during
-		 * kernel decompression.
-		 */
-		memmove(&images->legacy_hdr_os_copy, hdr,
-			sizeof(struct legacy_img_hdr));
-
-		/* save pointer to image header */
-		images->legacy_hdr_os = hdr;
-
-		images->legacy_hdr_valid = 1;
-		bootstage_mark(BOOTSTAGE_ID_DECOMP_IMAGE);
-		break;
-#endif
-#if CONFIG_IS_ENABLED(FIT)
-	case IMAGE_FORMAT_FIT:
-		os_noffset = fit_image_load(images, img_addr,
-				&fit_uname_kernel, &fit_uname_config,
-				IH_ARCH_DEFAULT, IH_TYPE_KERNEL,
-				BOOTSTAGE_ID_FIT_KERNEL_START,
-				FIT_LOAD_IGNORED, os_data, os_len);
-		if (os_noffset < 0)
-			return NULL;
-
-		images->fit_hdr_os = map_sysmem(img_addr, 0);
-		images->fit_uname_os = fit_uname_kernel;
-		images->fit_uname_cfg = fit_uname_config;
-		images->fit_noffset_os = os_noffset;
-		break;
-#endif
-#ifdef CONFIG_ANDROID_BOOT_IMAGE
-	case IMAGE_FORMAT_ANDROID:
-		boot_img = buf;
-		vendor_boot_img = NULL;
-		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
-			boot_img = map_sysmem(get_abootimg_addr(), 0);
-			vendor_boot_img = map_sysmem(get_avendor_bootimg_addr(), 0);
-		}
-		printf("## Booting Android Image at 0x%08lx ...\n", img_addr);
-		if (android_image_get_kernel(boot_img, vendor_boot_img, images->verify,
-					     os_data, os_len))
-			return NULL;
-		if (IS_ENABLED(CONFIG_CMD_ABOOTIMG)) {
-			unmap_sysmem(vendor_boot_img);
-			unmap_sysmem(boot_img);
-		}
-		break;
-#endif
-	default:
-		printf("Wrong Image Format for %s command\n", cmdtp->name);
-		bootstage_error(BOOTSTAGE_ID_FIT_KERNEL_INFO);
-		return NULL;
-	}
-
-	debug("   kernel data at 0x%08lx, len = 0x%08lx (%ld)\n",
-	      *os_data, *os_len, *os_len);
-
-	return buf;
-}
-
 /**
  * switch_to_non_secure_mode() - switch to non-secure mode
  *
-- 
2.43.0.rc0.421.g78406f8d94-goog

