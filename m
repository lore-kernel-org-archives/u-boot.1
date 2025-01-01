Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 133BCE7718F
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BCC0180352;
	Wed,  1 Jan 2025 23:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="IKJj8gyw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D394580352; Wed,  1 Jan 2025 23:12:28 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 67BE580317
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:12:26 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-21634338cfdso211809485ad.2
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:12:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769544; x=1736374344; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2DYbDoba76GmSbYb3WYZ6VXFRLz4K2VPHpokVG96SA=;
 b=IKJj8gywMiuP1HRrhZ7cSJWxYfqYKcXwNWPSLff0wvn7h4nqqJOaVqIom1dMyvcrte
 3FMrVw6X/inOUaFNj8BMIGw6EmiFSlcAnFJsgzcAr3fE55bUcG2sN/95haKzHzEPh46h
 xi0+lvtRw4nhufq/Qd31Yr09k5wG+nKTgYlng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769544; x=1736374344;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2DYbDoba76GmSbYb3WYZ6VXFRLz4K2VPHpokVG96SA=;
 b=K1o4HCmjhAHWPY84jLabFJ3iuBpYfiutrf+Af3Snyj7nl04542cQY1DpPmwP1NpR9t
 8ryBFcOxTPehDiEyeTwZOt3+wNDrIqVwUN9EdWzezwaQSsqfFlMCgXylGHaAfmsvAp4f
 LumIlLEGTrxdw1SbjoyCZiNgqlyFzBTWSCuNNuC1F7HD2rEMzgk6UI8WYlE7qXvXwDhO
 uazn7A8B0Axi+g1QuZd5TituZ7Dn5eRs8oxiCjZYf/RmHUdIJMZpOMg+IKeri2y9ExrS
 Uk6Tou/QgJ2B4TN8SwSYOrs962mhcwzOw5Gnbq23XC9wg+eyoqHWinFNYQ9YoJ8dmi++
 qq0A==
X-Gm-Message-State: AOJu0Yx0fO39cFdjDwx3r1NcJV0lLNrC/9t2TtwLVJNI9IAnvT3npFIb
 /HbcoHaW6DjiNXn9sJFs/Rgw0AXmCl0Naf6kmJ9xLcYnn2U+mzoEqMy7k5fbq6B9AqmmSuDGG08
 =
X-Gm-Gg: ASbGnctIcc/SkTI3Ro5+3PXoM5ZxtxfELQHcDiRGtLBulArKr/FvRjpmnQ/xOYnRDF/
 KkOx6nAX2lFTU3fgcdAGW0IGmp+cvFzCF/3+5BIZPlDquPfDiIfwuLBafxwLIH08nnp3c7J9Ckh
 re8tKfqqrQ0o63eISOkOpYws55gJ81nC8aD639NyZ+ZUh2+/JF4Vdu+0A3G2eYvtTpwu2FEARpY
 9wjLzUKL9ddx+0GLWQi1PAGzIwik40aWr/VRl5a9QqyO2ADKrmaEqw=
X-Google-Smtp-Source: AGHT+IEdBfSiPq2ZrSlOrva+IW84b4yhI1vPowaeeWhg/YWUknMcqAxvvt3lQk7nqwzKPXgV6TuYnw==
X-Received: by 2002:a05:6a21:3a8e:b0:1e2:5c9:65e0 with SMTP id
 adf61e73a8af0-1e5e07f0218mr75842987637.32.1735769544340; 
 Wed, 01 Jan 2025 14:12:24 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:12:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 16/67] boot: Use fit_image_get_data() to get data
Date: Thu,  2 Jan 2025 11:09:02 +1300
Message-ID: <20250101221003.1944600-17-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250101221003.1944600-1-sjg@chromium.org>
References: <20250101221003.1944600-1-sjg@chromium.org>
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

Use this function instead of fit_image_get_emb_data() data, since it
works will FITs that use external data.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/arm/cpu/armv8/sec_firmware.c  | 12 ++++++------
 arch/arm/mach-k3/r5/sysfw-loader.c |  9 +--------
 arch/x86/lib/bootm.c               |  9 +++------
 common/splash_source.c             | 22 +++++++---------------
 common/update.c                    |  2 +-
 5 files changed, 18 insertions(+), 36 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index e768859acfb..e3f8a6dcd60 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -83,6 +83,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 {
 	phys_addr_t sec_firmware_loadable_addr = 0;
 	int conf_node_off, ld_node_off, images;
+	const void *data;
+	size_t size;
 	const char *name, *str, *type;
 	ulong load;
 	int len;
@@ -112,8 +114,6 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 
 	for (str = name; str && ((str - name) < len);
 	     str = strchr(str, '\0') + 1) {
-		struct abuf buf;
-
 		printf("%s: '%s'\n", type, str);
 		ld_node_off = fdt_subnode_offset(sec_firmware_img, images, str);
 		if (ld_node_off < 0) {
@@ -128,8 +128,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 			return -EINVAL;
 		}
 
-		if (fit_image_get_emb_data(sec_firmware_img, ld_node_off,
-					   &buf)) {
+		if (fit_image_get_data(sec_firmware_img, ld_node_off,
+				       &data, &size)) {
 			printf("SEC Loadable: Can't get subimage data/size");
 			return -ENOENT;
 		}
@@ -147,9 +147,9 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 		/* Copy loadable to secure memory and flush dcache */
 		debug("%s copied to address 0x%p\n",
 		      FIT_LOADABLE_PROP, (void *)sec_firmware_loadable_addr);
-		memcpy((void *)sec_firmware_loadable_addr, buf.data, buf.size);
+		memcpy((void *)sec_firmware_loadable_addr, data, size);
 		flush_dcache_range(sec_firmware_loadable_addr,
-				   sec_firmware_loadable_addr + buf.size);
+				   sec_firmware_loadable_addr + size);
 
 		/* Populate loadable address only for Trusted OS */
 		if (!strcmp(str, "trustedOS@1")) {
diff --git a/arch/arm/mach-k3/r5/sysfw-loader.c b/arch/arm/mach-k3/r5/sysfw-loader.c
index 1895fb385a5..f0ad7559b97 100644
--- a/arch/arm/mach-k3/r5/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -117,14 +117,7 @@ static int fit_get_data_by_name(const void *fit, int images, const char *name,
 	if (node_offset < 0)
 		return -ENOENT;
 
-	ret = fit_image_get_emb_data(fit, node_offset, &buf);
-	if (ret)
-		return ret;
-
-	*addr = buf.data;
-	*size = buf.size;
-
-	return 0;
+	return fit_image_get_data(fit, node_offset, addr, size);
 }
 
 static void k3_start_system_controller(int rproc_id, bool rproc_loaded,
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 16980c15081..2a7933cdaf8 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -106,16 +106,13 @@ static int boot_prep_linux(struct bootm_headers *images)
 		is_zimage = 1;
 #if defined(CONFIG_FIT)
 	} else if (images->fit_uname_os && is_zimage) {
-		struct abuf buf;
-
-		ret = fit_image_get_emb_data(images->fit_hdr_os,
-					     images->fit_noffset_os, &buf);
+		ret = fit_image_get_data(images->fit_hdr_os,
+					 images->fit_noffset_os,
+					 (const void **)&data, &len);
 		if (ret) {
 			puts("Can't get image data/size!\n");
 			goto error;
 		}
-		data = buf.data;
-		len = buf.size;
 		is_zimage = 1;
 #endif
 	}
diff --git a/common/splash_source.c b/common/splash_source.c
index 37648b8b9f3..9972a1b2a08 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -347,6 +347,8 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	int res;
 	int node_offset;
 	const char *splash_file;
+	const void *internal_splash_data;
+	size_t internal_splash_size;
 	int external_splash_addr;
 	int external_splash_size;
 	bool is_splash_external = false;
@@ -354,7 +356,6 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	const u32 *fit_header;
 	u32 fit_size;
 	const size_t header_size = sizeof(struct legacy_img_hdr);
-	struct abuf buf;
 
 	/* Read in image header */
 	res = splash_storage_read_raw(location, bmp_load_addr, header_size);
@@ -394,20 +395,11 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	}
 
 	/* Extract the splash data from FIT */
-	/* 1. Test if splash is in FIT internal data. */
-	if (!fit_image_get_emb_data(fit_header, node_offset, &buf)) {
-		memmove((void *)(uintptr_t)bmp_load_addr, buf.data, buf.size);
-	/* 2. Test if splash is in FIT external data with fixed position. */
-	} else if (!fit_image_get_data_position(fit_header, node_offset, &external_splash_addr))
-		is_splash_external = true;
-	/* 3. Test if splash is in FIT external data with offset. */
-	else if (!fit_image_get_data_offset(fit_header, node_offset, &external_splash_addr)) {
-		/* Align data offset to 4-byte boundary */
-		fit_size = ALIGN(fdt_totalsize(fit_header), 4);
-		/* External splash offset means the offset by end of FIT header */
-		external_splash_addr += location->offset + fit_size;
-		is_splash_external = true;
-	} else {
+	if (!fit_image_get_data(fit_header, node_offset, &internal_splash_data,
+				&internal_splash_size))
+		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data,
+			internal_splash_size);
+	else {
 		printf("Failed to get splash image from FIT\n");
 		return -ENODATA;
 	}
diff --git a/common/update.c b/common/update.c
index d149ca18e78..6801b49479d 100644
--- a/common/update.c
+++ b/common/update.c
@@ -200,7 +200,7 @@ static int update_fit_getparams(const void *fit, int noffset, ulong *addr,
 {
 	const void *data;
 
-	if (fit_image_get_emb_data(fit, noffset, &data, (size_t *)size))
+	if (fit_image_get_data(fit, noffset, &data, (size_t *)size))
 		return 1;
 
 	if (fit_image_get_load(fit, noffset, (ulong *)fladdr))
-- 
2.43.0

