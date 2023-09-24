Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2647DCE7A8A
	for <u-boot@archiver.kernel.org>; Sun, 24 Sep 2023 19:28:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 449C986BDD;
	Sun, 24 Sep 2023 21:26:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LO1zJN7G";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CBDF386BA3; Sun, 24 Sep 2023 21:26:16 +0200 (CEST)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com
 [IPv6:2607:f8b0:4864:20::135])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED86B86A23
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 21:26:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x135.google.com with SMTP id
 e9e14a558f8ab-35130c8bc79so5574905ab.1
 for <u-boot@lists.denx.de>; Sun, 24 Sep 2023 12:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695583565; x=1696188365; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4MHQmy3zRi2BLkamzJqocb1W27JqVjV38LG8jfixnZ4=;
 b=LO1zJN7GmWYk23B0AC5iqv7Dt3BGU8O+TdlCJYlbOfhSjSq6YxA2ZSm99kkOS6fdbd
 qf8eaG9R99RXAiLLdYhmJa/tannzGDFxc8gCYANmuMwAODOl0AHxzL87cVpADCO6kTtz
 gb4ThWZz6ePQ2Yi/RP46uFU0iQI0TE7k8unrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695583565; x=1696188365;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4MHQmy3zRi2BLkamzJqocb1W27JqVjV38LG8jfixnZ4=;
 b=XuNeR8DxuIPPU/7+IC+a6r8T60Nhf0IV/F/YFi11E9hBr3WsKvhOnHyrX4TZPj4KT3
 K17ySowl3m48Ve0Oc2LAyMjADIS7fdkpbCZioblkpQ0yvh+BA6XaT6libUMtasXSKUW5
 n+ESdFmFGHipE8lhCWHAV0mMphrKlLKVk6KBp9eMeeTr05JqwLxCOIXRga4C0RwFWATk
 tXYmgkWPIQPG/BQ/G0rPwkCL7+qy8626GuBcrzDMJ3AwBY7JVwnEo+kh4+L9o4W+EpRB
 G8A8+I6JQ955LTHiBldcVd4SouqKgfb6lF5I5YmyWqiRE/4w6bohwjt153uW0jWxYS5I
 NRuA==
X-Gm-Message-State: AOJu0YyAh6bnhTGOKaQG7lDAcf/dSwtO1WQ8F/8zEjUGrI7Ohl8VgUHv
 kuGQnsr9cF+p74BPGAfaFf63ojeF8b1+EFYmzRQ=
X-Google-Smtp-Source: AGHT+IFx4E5Zfbs93qqxqVFMPNpEs9zsh/8QNtjLXNeOVMykrDKd0LZ5Qx/lWR0U/9k9KeKBdMcJ0A==
X-Received: by 2002:a05:6e02:190c:b0:350:f0bb:6a2c with SMTP id
 w12-20020a056e02190c00b00350f0bb6a2cmr7757227ilu.0.1695583565493; 
 Sun, 24 Sep 2023 12:26:05 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 do25-20020a0566384c9900b0043a11ec6517sm2321702jab.171.2023.09.24.12.26.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Sep 2023 12:26:05 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Glass <sjg@chromium.org>,
 Algapally Santosh Sagar <santoshsagar.algapally@amd.com>,
 Bin Meng <bmeng@tinylab.org>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mayuresh Chitale <mchitale@ventanamicro.com>,
 Michal Simek <michal.simek@amd.com>, Nikhil M Jain <n-jain1@ti.com>,
 Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
 Ovidiu Panait <ovpanait@gmail.com>, Roger Quadros <rogerq@kernel.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 18/38] spl: Move the full FIT code to spl_fit.c
Date: Sun, 24 Sep 2023 13:25:03 -0600
Message-ID: <20230924192536.1812799-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230924192536.1812799-1-sjg@chromium.org>
References: <20230924192536.1812799-1-sjg@chromium.org>
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
index e8044b821635..f3cbd6cef8a7 100644
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

