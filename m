Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5004DE77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CE9BF8060C;
	Mon,  6 Jan 2025 15:33:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="iCWtciU6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22516805E9; Mon,  6 Jan 2025 15:33:34 +0100 (CET)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66380805FB
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-844e7409f8aso612008839f.1
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174008; x=1736778808; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CGDQWOLEtzPA2dhv/BrpHgIMEa5Sf8hjTM1nBC1h7Ao=;
 b=iCWtciU6ff/IKI1wdy9irX+oNyUBrzMhjr98/btJ+O3n7sekdx5vWSU0ppzsa+TRXT
 LpypqnW4n0T6r10G3NosTTARUgQV4oBiPsNtqrmHsQEoLG14SZCMGLzXBeJnhRGqaJZg
 2QsgPh4aLjMKB5l601+Z817ufvQenm7m6s1AY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174008; x=1736778808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CGDQWOLEtzPA2dhv/BrpHgIMEa5Sf8hjTM1nBC1h7Ao=;
 b=PGKj8NH9rAmkwCcUZqANFQq2YpKBy0ozGnx4Qr8YpOG8lDxDOv+dnYeDemdIV93CI+
 8TBhhZ15rVM32A5tVpb9aCq/7USCT2a1YQs6BvqEUfdSb2aavzcHXc85wMxXqs6Sw7j4
 02woht1q1nyy4TlrynHF6/3Z6xue390n+WBPsTs9WbLQvnhqbUAI5IoDGnqwu9o8Gd82
 bY9oqcBi8PqHyGowgqljvMmLS8VXWM4/dztxovgPAkq1OUjwLDKpQ9AfWWenNRaEAtDL
 nifRo66U3IuOQBFgWMgCUaxVIoUJ5B7cNwpESqOEXpVszwd/WJ3IN3C8ZN06EuhINYI+
 ffnQ==
X-Gm-Message-State: AOJu0YxeL0/9prY/YbDhFr49iivRe/uroRDWPqqSk5tFeXrRUQ7ra9Et
 VNY+IJhZOq26DMIo4X+09XtMmYJdgHaUCQW5EGecua19sOiotdRFYbLTbOc5NHFpjs6pTryC3Yk
 =
X-Gm-Gg: ASbGncvUYtSgw4YKccEODuN1UXviYN3aimEZ1Hr5Vfoqh329TrGZdi1Q/i09i/F09+w
 ZcVnQGyN4tQScpEWLzcQRiCDTwzAxKUzHBBRFAXyAzU2tBvYYmoiAQHDUJPQStlKGk/yaZbkU1+
 UYM4RPczr29+FvOkK95nfXVh4WFqIbcxBUnSuUnaVmwfjed+8grF74ZcdQV8IhcIbrmdqYT88nz
 wxhPtsyCQ5bydi5m9vSdY37xzSLTDVB0WXd+P/LW/GrSg47mSB0/bG1FzMEz9DsyIwn6Cdawl1b
 IF6qVfg6aT2+R5AQNg==
X-Google-Smtp-Source: AGHT+IH4lRhrJFTwLpCQpeN9XPEFdeLcjU7MAKSpx4LRk1G8Gy9dA29uhbKry8uvW98SLXvojm8FQw==
X-Received: by 2002:a05:6e02:156d:b0:3ab:1b7a:593e with SMTP id
 e9e14a558f8ab-3c2d514f9ebmr531670355ab.19.1736174008597; 
 Mon, 06 Jan 2025 06:33:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 18/33] boot: Use fit_image_get_data() to get data
Date: Mon,  6 Jan 2025 07:32:14 -0700
Message-Id: <20250106143229.3023771-19-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250106143229.3023771-1-sjg@chromium.org>
References: <20250106143229.3023771-1-sjg@chromium.org>
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

Changes in v2:
- Fix unbalanced {}

 arch/arm/cpu/armv8/sec_firmware.c  | 12 ++++++------
 arch/arm/mach-k3/r5/sysfw-loader.c |  9 +--------
 arch/x86/lib/bootm.c               |  9 +++------
 common/splash_source.c             | 20 ++++++--------------
 common/update.c                    |  2 +-
 5 files changed, 17 insertions(+), 35 deletions(-)

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
index 37648b8b9f3..2df78a4f2d7 100644
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
@@ -394,19 +395,10 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
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
+	if (!fit_image_get_data(fit_header, node_offset, &internal_splash_data,
+				&internal_splash_size)) {
+		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data,
+			internal_splash_size);
 	} else {
 		printf("Failed to get splash image from FIT\n");
 		return -ENODATA;
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
2.34.1

