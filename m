Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BD08E7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:03:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5DC6180719;
	Sat, 11 Jan 2025 01:01:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="T5CPF3WE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C2AA68073D; Sat, 11 Jan 2025 01:01:25 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82E3880657
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844ce213af6so80395539f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553682; x=1737158482; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REN+L1pkTtgbR33bZ4ti9akw8wmDuPRX/8FJMhZlE7Q=;
 b=T5CPF3WEAst9gmflM7XOiXFC9a1KmveWmqwaHoSggSsu1fVifzeux5djOl1T/TV7Ny
 JaOPnYTfafysTpn+Aewjx9pk+NH12psT35EP2sNkdhikJnSA3vaixrGjKn/HxtNOgFys
 UGarlK7HxyNX6EdYGaCHAAiI5SKBA03Em8s6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553682; x=1737158482;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=REN+L1pkTtgbR33bZ4ti9akw8wmDuPRX/8FJMhZlE7Q=;
 b=fmWIlOC7MeS3VEz5FSuliJBSXZ3O7spRctYWpovBX6jCVMjf8Dkzk/4AxYApZPkDIJ
 QhIV5ja1M2ngSWn5m4WoiCQEHPSIJikdujNeePmLI0r7IwUc0lk4VdvaeTyy4RlDpWdV
 2TqTTGK/gba7rh/9CdItoJYVHzyo8LXQpReCzbBRdX1d2SgAQMYU5/bnDjHRFkG02L5i
 SlU2Tw0pXJFGof0qOf3rOooL+bUulr5LUhpZ0zfup7JszXmC+YqYc56KGWhRwsox+uMP
 MwIxP5Me559E1e/OauF9rUzZIW/SlPtCup7gbjttbNqtYk5JZgIYGRJ2Fnl8WKOGfVyo
 EKWw==
X-Gm-Message-State: AOJu0YxiImk7FKKu4YQYjDEJG0NFeVMTdQ9tnhAIlmsLjwKUw8gH1TJW
 1B4dLzXxz+bKXrJ95Xii/pGYItTShQtFrqnW2fHuVlHHmOaKShsAkT7/hrd+uWHzGJNxuqmk5zc
 =
X-Gm-Gg: ASbGncucNWkvFpSUnBjCt6t/yKtvHbzFqRvmQzL1FMP/6H5rRbR4AoyVRBSRFFLYI95
 j3J7goevNIxtyB2UaBBCKyOaBiRA7odpq9UMWnTrnOnjS0m17PSAR4sj52KM6JXBP71uSPTyGTf
 AZmiGO8d53w0voKMWiTts+Z5BPp5vWN/t+YEaH+eaL2KLfA+UTtwKobxoma1CmAZqEcgBRVRgKa
 nqS2iA6IugwPK5vSVRFTWGYzQkcBKX1WlUY9WW4U8W+iZTn0TRLAK+86aWnWiQ6sSX9jgCMrk0n
 maRlrwqxPUy9bL/YeQ==
X-Google-Smtp-Source: AGHT+IGXf/LgaL33qPtldS2lPyo5HW82x5XL/ol+kDooiufw3KUs/xD77Br1f60PdevG8rW2GL+9Xw==
X-Received: by 2002:a05:6602:750d:b0:834:d7b6:4fea with SMTP id
 ca18e2360f4ac-84ce0095c70mr1264455739f.6.1736553681720; 
 Fri, 10 Jan 2025 16:01:21 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Janne Grunau <j@jannau.net>,
 Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Nikhil M Jain <n-jain1@ti.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 15/30] boot: Use fit_image_get_data() to get data
Date: Fri, 10 Jan 2025 17:00:14 -0700
Message-Id: <20250111000029.245022-16-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111000029.245022-1-sjg@chromium.org>
References: <20250111000029.245022-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Fix unbalanced {}

 arch/arm/cpu/armv8/sec_firmware.c  |  4 ++--
 arch/arm/mach-k3/r5/sysfw-loader.c |  2 +-
 arch/x86/lib/bootm.c               |  6 +++---
 common/splash_source.c             | 19 ++++---------------
 common/update.c                    |  2 +-
 5 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index b7c73f288bd..44372cbe4a1 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -128,8 +128,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 			return -EINVAL;
 		}
 
-		if (fit_image_get_emb_data(sec_firmware_img, ld_node_off,
-					   &data, &size)) {
+		if (fit_image_get_data(sec_firmware_img, ld_node_off,
+				       &data, &size)) {
 			printf("SEC Loadable: Can't get subimage data/size");
 			return -ENOENT;
 		}
diff --git a/arch/arm/mach-k3/r5/sysfw-loader.c b/arch/arm/mach-k3/r5/sysfw-loader.c
index c323d2f78f8..188731e673d 100644
--- a/arch/arm/mach-k3/r5/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -115,7 +115,7 @@ static int fit_get_data_by_name(const void *fit, int images, const char *name,
 	if (node_offset < 0)
 		return -ENOENT;
 
-	return fit_image_get_emb_data(fit, node_offset, addr, size);
+	return fit_image_get_data(fit, node_offset, addr, size);
 }
 
 static void k3_start_system_controller(int rproc_id, bool rproc_loaded,
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 3305560aa06..2a7933cdaf8 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -106,9 +106,9 @@ static int boot_prep_linux(struct bootm_headers *images)
 		is_zimage = 1;
 #if defined(CONFIG_FIT)
 	} else if (images->fit_uname_os && is_zimage) {
-		ret = fit_image_get_emb_data(images->fit_hdr_os,
-					     images->fit_noffset_os,
-					     (const void **)&data, &len);
+		ret = fit_image_get_data(images->fit_hdr_os,
+					 images->fit_noffset_os,
+					 (const void **)&data, &len);
 		if (ret) {
 			puts("Can't get image data/size!\n");
 			goto error;
diff --git a/common/splash_source.c b/common/splash_source.c
index 5ac32a2f995..2df78a4f2d7 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -395,21 +395,10 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 	}
 
 	/* Extract the splash data from FIT */
-	/* 1. Test if splash is in FIT internal data. */
-	if (!fit_image_get_emb_data(fit_header, node_offset,
-				    &internal_splash_data,
-				    &internal_splash_size))
-		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data, internal_splash_size);
-	/* 2. Test if splash is in FIT external data with fixed position. */
-	else if (!fit_image_get_data_position(fit_header, node_offset, &external_splash_addr))
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

