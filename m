Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EB5FC83F15
	for <u-boot@archiver.kernel.org>; Wed, 30 Aug 2023 18:07:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 331C086625;
	Wed, 30 Aug 2023 20:06:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jMj4/L0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B3B7865AD; Wed, 30 Aug 2023 20:06:01 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA9E486567
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 20:05:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7927f24140eso2085339f.2
 for <u-boot@lists.denx.de>; Wed, 30 Aug 2023 11:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1693418748; x=1694023548; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FhBUL2dpULDBIDpjL4HABwkGZBeNCrXsyVb3Ie/4uPA=;
 b=jMj4/L0HTSu9fxurOZU0WHQvRxcq3KLiQZB/Dw0pY+/TBmskEdpaw2g6RS4asY3TSr
 0hMYAxDwkbY9HVnDxtmwEnRxyUOlmX+A4bObFm5wHQ+KD6pnHuuKJOM41EWpgBbgu5dg
 x0EzwbMACFdve7v4j+60UxhlJf5ABHBfxH81g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693418748; x=1694023548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FhBUL2dpULDBIDpjL4HABwkGZBeNCrXsyVb3Ie/4uPA=;
 b=fe2IO7XhkkrPLQrtHwsH3E4+2DI+UhRsPn9dBIAD1uA0B6NI+5AkO6vZP2h10RpZ9T
 s0atUd8Rs2qkAfzoMSZSxQ9ksitI+ja5tO43U5vhESN3BgZjHBzEJqc9kFs8p7hAiaid
 VSOwbiG+ZNx4TI6GkgUdyWWBppPJcLzJXjtn0UFSRLcQqI3jKQPMwe0PUtjF0axp4xK/
 OmhnD0ScAnFy+L+ZI3PtdNOcaGQ87DRnpwkmqSWH/GpLuVVQ/IHrvDAMW+rIxLSfAh/b
 g+7A5gpVkHgqp7CghlsMF9kCrMFzZ372FFr7fYdwpEPd/baCA6ASiRJHLsEKO/9rWawP
 8s7Q==
X-Gm-Message-State: AOJu0Yya7DYEHURVhLmBlIfQ+Tq+bwGCz9b/nWKuY/c8Y+FpPxlmcGt5
 Q8F4zQcwNMDU8BZqp9NpcW9LDu4p84zjheEbbDo=
X-Google-Smtp-Source: AGHT+IEILddkdg3168Qb06UB9OyjJANYrHKOJyjMIFFe5+89lxVabM1UhpeaoPDSeFP6JdGk7b7ZVA==
X-Received: by 2002:a05:6602:474a:b0:795:2274:1f3f with SMTP id
 dy10-20020a056602474a00b0079522741f3fmr2848426iob.3.1693418748335; 
 Wed, 30 Aug 2023 11:05:48 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:b147:266a:7359:2232])
 by smtp.gmail.com with ESMTPSA id
 dk54-20020a0566384bf600b0042bbd3e49b9sm4002224jab.24.2023.08.30.11.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Aug 2023 11:05:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Roger Quadros <rogerq@kernel.org>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [PATCH 12/32] spl: Move the full FIT code to spl_fit.c
Date: Wed, 30 Aug 2023 12:04:43 -0600
Message-ID: <20230830180524.315916-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc2.253.gd59a3bf2b4-goog
In-Reply-To: <20230830180524.315916-1-sjg@chromium.org>
References: <20230830180524.315916-1-sjg@chromium.org>
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

For some reason this code was put in the main spl.c file. Move it out
to the FIT implementation where it belongs.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 common/spl/spl.c     | 108 +++----------------------------------------
 common/spl/spl_fit.c |  93 +++++++++++++++++++++++++++++++++++++
 include/spl.h        |  11 +++++
 3 files changed, 111 insertions(+), 101 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 3e3e13057f1..8f87a27e61f 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -260,102 +260,6 @@ void spl_set_header_raw_uboot(struct spl_image_info *spl_image)
 }
 #endif
 
-#if CONFIG_IS_ENABLED(LOAD_FIT_FULL)
-/* Parse and load full fitImage in SPL */
-static int spl_load_fit_image(struct spl_image_info *spl_image,
-			      const struct legacy_img_hdr *header)
-{
-	struct bootm_headers images;
-	const char *fit_uname_config = NULL;
-	uintptr_t fdt_hack;
-	const char *uname;
-	ulong fw_data = 0, dt_data = 0, img_data = 0;
-	ulong fw_len = 0, dt_len = 0, img_len = 0;
-	int idx, conf_noffset;
-	int ret;
-
-#ifdef CONFIG_SPL_FIT_SIGNATURE
-	images.verify = 1;
-#endif
-	ret = fit_image_load(&images, (ulong)header,
-			     NULL, &fit_uname_config,
-			     IH_ARCH_DEFAULT, IH_TYPE_STANDALONE, -1,
-			     FIT_LOAD_OPTIONAL, &fw_data, &fw_len);
-	if (ret >= 0) {
-		printf("DEPRECATED: 'standalone = ' property.");
-		printf("Please use either 'firmware =' or 'kernel ='\n");
-	} else {
-		ret = fit_image_load(&images, (ulong)header, NULL,
-				     &fit_uname_config, IH_ARCH_DEFAULT,
-				     IH_TYPE_FIRMWARE, -1, FIT_LOAD_OPTIONAL,
-				     &fw_data, &fw_len);
-	}
-
-	if (ret < 0) {
-		ret = fit_image_load(&images, (ulong)header, NULL,
-				     &fit_uname_config, IH_ARCH_DEFAULT,
-				     IH_TYPE_KERNEL, -1, FIT_LOAD_OPTIONAL,
-				     &fw_data, &fw_len);
-	}
-
-	if (ret < 0)
-		return ret;
-
-	spl_image->size = fw_len;
-	spl_image->entry_point = fw_data;
-	spl_image->load_addr = fw_data;
-	if (fit_image_get_os(header, ret, &spl_image->os))
-		spl_image->os = IH_OS_INVALID;
-	spl_image->name = genimg_get_os_name(spl_image->os);
-
-	debug(SPL_TPL_PROMPT "payload image: %32s load addr: 0x%lx size: %d\n",
-	      spl_image->name, spl_image->load_addr, spl_image->size);
-
-#ifdef CONFIG_SPL_FIT_SIGNATURE
-	images.verify = 1;
-#endif
-	ret = fit_image_load(&images, (ulong)header, NULL, &fit_uname_config,
-		       IH_ARCH_DEFAULT, IH_TYPE_FLATDT, -1,
-		       FIT_LOAD_OPTIONAL, &dt_data, &dt_len);
-	if (ret >= 0) {
-		spl_image->fdt_addr = (void *)dt_data;
-
-		if (spl_image->os == IH_OS_U_BOOT) {
-			/* HACK: U-Boot expects FDT at a specific address */
-			fdt_hack = spl_image->load_addr + spl_image->size;
-			fdt_hack = (fdt_hack + 3) & ~3;
-			debug("Relocating FDT to %p\n", spl_image->fdt_addr);
-			memcpy((void *)fdt_hack, spl_image->fdt_addr, dt_len);
-		}
-	}
-
-	conf_noffset = fit_conf_get_node((const void *)header,
-					 fit_uname_config);
-	if (conf_noffset < 0)
-		return 0;
-
-	for (idx = 0;
-	     uname = fdt_stringlist_get((const void *)header, conf_noffset,
-					FIT_LOADABLE_PROP, idx,
-				NULL), uname;
-	     idx++)
-	{
-#ifdef CONFIG_SPL_FIT_SIGNATURE
-		images.verify = 1;
-#endif
-		ret = fit_image_load(&images, (ulong)header,
-				     &uname, &fit_uname_config,
-				     IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,
-				     FIT_LOAD_OPTIONAL_NON_ZERO,
-				     &img_data, &img_len);
-		if (ret < 0)
-			return ret;
-	}
-
-	return 0;
-}
-#endif
-
 __weak int spl_parse_board_header(struct spl_image_info *spl_image,
 				  const struct spl_boot_device *bootdev,
 				  const void *image_header, size_t size)
@@ -375,12 +279,14 @@ int spl_parse_image_header(struct spl_image_info *spl_image,
 			   const struct spl_boot_device *bootdev,
 			   const struct legacy_img_hdr *header)
 {
-#if CONFIG_IS_ENABLED(LOAD_FIT_FULL)
-	int ret = spl_load_fit_image(spl_image, header);
+	int ret;
 
-	if (!ret)
-		return ret;
-#endif
+	if (CONFIG_IS_ENABLED(LOAD_FIT_FULL)) {
+		ret = spl_load_fit_image(spl_image, header);
+
+		if (!ret)
+			return ret;
+	}
 	if (image_get_magic(header) == IH_MAGIC) {
 		int ret;
 
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 8e7d033dd1a..5b5f6c62045 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -826,3 +826,96 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 
 	return 0;
 }
+
+/* Parse and load full fitImage in SPL */
+int spl_load_fit_image(struct spl_image_info *spl_image,
+		       const struct legacy_img_hdr *header)
+{
+	struct bootm_headers images;
+	const char *fit_uname_config = NULL;
+	uintptr_t fdt_hack;
+	const char *uname;
+	ulong fw_data = 0, dt_data = 0, img_data = 0;
+	ulong fw_len = 0, dt_len = 0, img_len = 0;
+	int idx, conf_noffset;
+	int ret;
+
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+	images.verify = 1;
+#endif
+	ret = fit_image_load(&images, (ulong)header,
+			     NULL, &fit_uname_config,
+			     IH_ARCH_DEFAULT, IH_TYPE_STANDALONE, -1,
+			     FIT_LOAD_OPTIONAL, &fw_data, &fw_len);
+	if (ret >= 0) {
+		printf("DEPRECATED: 'standalone = ' property.");
+		printf("Please use either 'firmware =' or 'kernel ='\n");
+	} else {
+		ret = fit_image_load(&images, (ulong)header, NULL,
+				     &fit_uname_config, IH_ARCH_DEFAULT,
+				     IH_TYPE_FIRMWARE, -1, FIT_LOAD_OPTIONAL,
+				     &fw_data, &fw_len);
+	}
+
+	if (ret < 0) {
+		ret = fit_image_load(&images, (ulong)header, NULL,
+				     &fit_uname_config, IH_ARCH_DEFAULT,
+				     IH_TYPE_KERNEL, -1, FIT_LOAD_OPTIONAL,
+				     &fw_data, &fw_len);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	spl_image->size = fw_len;
+	spl_image->entry_point = fw_data;
+	spl_image->load_addr = fw_data;
+	if (fit_image_get_os(header, ret, &spl_image->os))
+		spl_image->os = IH_OS_INVALID;
+	spl_image->name = genimg_get_os_name(spl_image->os);
+
+	debug(SPL_TPL_PROMPT "payload image: %32s load addr: 0x%lx size: %d\n",
+	      spl_image->name, spl_image->load_addr, spl_image->size);
+
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+	images.verify = 1;
+#endif
+	ret = fit_image_load(&images, (ulong)header, NULL, &fit_uname_config,
+			     IH_ARCH_DEFAULT, IH_TYPE_FLATDT, -1,
+			     FIT_LOAD_OPTIONAL, &dt_data, &dt_len);
+	if (ret >= 0) {
+		spl_image->fdt_addr = (void *)dt_data;
+
+		if (spl_image->os == IH_OS_U_BOOT) {
+			/* HACK: U-Boot expects FDT at a specific address */
+			fdt_hack = spl_image->load_addr + spl_image->size;
+			fdt_hack = (fdt_hack + 3) & ~3;
+			debug("Relocating FDT to %p\n", spl_image->fdt_addr);
+			memcpy((void *)fdt_hack, spl_image->fdt_addr, dt_len);
+		}
+	}
+
+	conf_noffset = fit_conf_get_node((const void *)header,
+					 fit_uname_config);
+	if (conf_noffset < 0)
+		return 0;
+
+	for (idx = 0;
+	     uname = fdt_stringlist_get((const void *)header, conf_noffset,
+					FIT_LOADABLE_PROP, idx,
+				NULL), uname;
+	     idx++) {
+#ifdef CONFIG_SPL_FIT_SIGNATURE
+		images.verify = 1;
+#endif
+		ret = fit_image_load(&images, (ulong)header,
+				     &uname, &fit_uname_config,
+				     IH_ARCH_DEFAULT, IH_TYPE_LOADABLE, -1,
+				     FIT_LOAD_OPTIONAL_NON_ZERO,
+				     &img_data, &img_len);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
diff --git a/include/spl.h b/include/spl.h
index 60b55b75195..e958ace2cc6 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -910,4 +910,15 @@ struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size);
 
 void board_boot_order(u32 *spl_boot_list);
 void spl_save_restore_data(void);
+
+/**
+ * spl_load_fit_image() - Fully parse and a FIT image in SPL
+ *
+ * @spl_image: SPL Image data to fill in
+ * @header: Pointer to FIT image
+ * Return 0 if OK, -ve on error
+ */
+int spl_load_fit_image(struct spl_image_info *spl_image,
+		       const struct legacy_img_hdr *header);
+
 #endif
-- 
2.42.0.rc2.253.gd59a3bf2b4-goog

