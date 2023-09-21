Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1818CCD493C
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 01:59:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AE5F186D7A;
	Thu, 21 Sep 2023 03:58:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="SMTK/ch2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B79DB86D97; Thu, 21 Sep 2023 03:58:02 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 34BEC86D14
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 03:57:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-79545e141c7so11606939f.0
 for <u-boot@lists.denx.de>; Wed, 20 Sep 2023 18:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695261476; x=1695866276; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Lu0NsBM4gQv2IgrZJj4sYpekUKiQVzS+5dcSuJb8v+8=;
 b=SMTK/ch2Jt/bPAVoIrAutm4rhVBn2+08ffLN+16AgQIiNgxoKcZeoO+aK2KawPHxsM
 rFjpnb/ae/6zU+C3yZnMVUq1gvbeLCZ9c4Ve7zi6LDc18p065eSvg6nr3nFsjapWITAF
 RJ5R8Y2XOr5TOCYQHSKv2NPLwulJXmrso10iE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695261476; x=1695866276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Lu0NsBM4gQv2IgrZJj4sYpekUKiQVzS+5dcSuJb8v+8=;
 b=CWlGF2iSnMFys/PIDksRba5Kl5zijBSUJ9rRJkuCbCdodWBYZeVx8EilF2KPnchVB+
 8GA5cl3216rR7I0+VweDncaUkO3H91t4rsfnt2bEvVyAkcxom1Qri679erkEgq708xgn
 qd6dWYr1oEpZ54Z4kstJnqrItBP6pCkZ2sti8nRo9AdkfDz6WhF3Pe+g7DXdJx7xGywl
 WsFIq3J4+SHMBRHM/T4n/N4zaTrDz9xjk5EkoSAnmqNL5rPOUvMGXgG7Pt7BfDpyYoRZ
 q+bhouRAMXSKyIVzvTY1WrFO4IYJ6jz1+Yk9BYkaqXuVP4d0zKgNLU+/PYP6nd+NA4GG
 LmLg==
X-Gm-Message-State: AOJu0YyJOMO404Xsi1rUm/q0/umrivQbsOKXUq+WGC9vQucCiU1Xb55v
 uG4AU6/Xj9vbhKEoefzOQKrLNYXoBFL4Z23ysTc=
X-Google-Smtp-Source: AGHT+IEm4IsVAxSI0sgvw6NuESY7ux6PhnRY0A1E557uPn1Vp9/zCIt3lXKjUUOJfGc9Lbrc3pr8GQ==
X-Received: by 2002:a05:6602:3b8f:b0:792:82f8:73fe with SMTP id
 dm15-20020a0566023b8f00b0079282f873femr4309717iob.3.1695261475716; 
 Wed, 20 Sep 2023 18:57:55 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 y4-20020a02c004000000b00437c3a7b49dsm85317jai.156.2023.09.20.18.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 18:57:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v2 12/32] spl: Move the full FIT code to spl_fit.c
Date: Wed, 20 Sep 2023 19:57:01 -0600
Message-ID: <20230921015730.1511373-13-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230921015730.1511373-1-sjg@chromium.org>
References: <20230921015730.1511373-1-sjg@chromium.org>
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

(no changes since v1)

 common/spl/spl.c     | 108 +++----------------------------------------
 common/spl/spl_fit.c |  93 +++++++++++++++++++++++++++++++++++++
 include/spl.h        |  11 +++++
 3 files changed, 111 insertions(+), 101 deletions(-)

diff --git a/common/spl/spl.c b/common/spl/spl.c
index 8541bef00466..1f0412b96b32 100644
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
index 8e7d033dd1a4..5b5f6c620457 100644
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
index 60b55b75195b..e958ace2cc62 100644
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
2.42.0.515.g380fc7ccd1-goog

