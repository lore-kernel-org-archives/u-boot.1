Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859A2E77198
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 14:35:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6463880634;
	Mon,  6 Jan 2025 15:33:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="f2c2cCDF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2D35C80634; Mon,  6 Jan 2025 15:33:25 +0100 (CET)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CCD8D80658
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 15:33:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-844dfe4b136so451836739f.3
 for <u-boot@lists.denx.de>; Mon, 06 Jan 2025 06:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736174000; x=1736778800; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jbx6VNgnHJgKl/wXlg2dBTGQ70SPbuBpicJws1hy3ro=;
 b=f2c2cCDFqyY2G2/ZKGn0P3HdivshWjbkHcNyQYsZwljnvpGBqRZVNIbALuhurcMx6K
 Yk3u65hIq6qVLWE4pt8AgW/aClkb/kVRUWQGTGvMe5+0xNNUuCJu620ETP86p9YFgkNz
 v6yGJLnJgtl1TjFozVUyGA18ZZERLCmupP2MY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736174000; x=1736778800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jbx6VNgnHJgKl/wXlg2dBTGQ70SPbuBpicJws1hy3ro=;
 b=pcX4vAP+1JzrCVs3Yht27Y2b0AEBOSw3OnhceCeuIHPqjWry6/B3pYBv1y7ZxZ3um+
 nKKnzULbfrpQAne2GZPSSW4i30+i0/LHSuR7fNAcQThkftHb6+GMikOtiv9oFtLP2ZaH
 ftMmTT6oezcI3BORVZLYQsTu8EeMfgt9qoVRyG5wPH/G39ZG0sj/DMqWiWeJ1VeB+CLi
 5WbIzvolLpFk7TOfNTEEOX26KicVs4MZI97kLCSdSSQDwIpuqb4CuJfFW0AlcWGKhijc
 x740CTzqSRn6Q+y0PyDvUnjizMX1H1TrJbkMJOWud4/DKXVPxgkr3WLXD8Uix4GtXGyo
 MirA==
X-Gm-Message-State: AOJu0YwWz2VIzb7hYZ3KMlbNn2FfxKTm72ZewFjZMDKE04lCFR84Q+si
 Xj6dvnoCgwJcGTHIZyKIifi0v3P8jYYG5EIY9dXblh2KJ4hWYFzPsj85XzGkB0s4WW4NuAGSRc0
 =
X-Gm-Gg: ASbGncsaN1gSqSr9SKO5UqliwwDrRN+nCu7IhveH/wuaBHh3LYRzux3ih8OGqTze+dl
 YLIfUwxTWpowTzC17CQXkfaU2N6ZtpRhyJW0n5/k/Q+/3dBcs4TMrhiPXdqorLNVHtg8XOyYhOt
 6J0Uw4BzlQQfvRhmPkv4X7p/sAcV5kRK2jBKxpuq+qeZ0YFJtGo+2naUvpO9A22YywUddZJeMps
 s3go3wZKwgO/NUU6RYsEyUXu3xe0NaXOlH37Wf2QrrrbA50W2tzVI3dAbec46x6yYBwRZC3c/BH
 P5UtAcJGHRocJ1PZmA==
X-Google-Smtp-Source: AGHT+IHq1VJG4cPf5PFjYOUq1GclAPVf57GHS2Qg1Y78EMQLhuAB0E2L85La3uycNQAITZIvbpwixQ==
X-Received: by 2002:a05:6e02:3042:b0:3a7:fd5a:8b8a with SMTP id
 e9e14a558f8ab-3c2d2d4f1abmr551129805ab.12.1736174000247; 
 Mon, 06 Jan 2025 06:33:20 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3c0e47d6ef2sm97200805ab.78.2025.01.06.06.33.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2025 06:33:18 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janne Grunau <j@jannau.net>, Julien Masson <jmasson@baylibre.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/33] boot: Rename fit_image_get_data()
Date: Mon,  6 Jan 2025 07:32:11 -0700
Message-Id: <20250106143229.3023771-16-sjg@chromium.org>
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

This function can only be used with FITs that use embedded data. Rename
it so this is clear.

Signed-off-by: Simon Glass <sjg@chromium.org>
Acked-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
---

(no changes since v1)

 arch/arm/cpu/armv8/sec_firmware.c  |  4 ++--
 arch/arm/mach-k3/r5/sysfw-loader.c |  2 +-
 arch/x86/lib/bootm.c               |  6 +++---
 boot/image-fit.c                   | 10 +++++-----
 common/spl/spl_fit.c               |  2 +-
 common/splash_source.c             |  4 +++-
 common/update.c                    |  2 +-
 include/image.h                    |  4 ++--
 tools/image-host.c                 |  4 ++--
 9 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index 44372cbe4a1..b7c73f288bd 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -128,8 +128,8 @@ static int sec_firmware_check_copy_loadable(const void *sec_firmware_img,
 			return -EINVAL;
 		}
 
-		if (fit_image_get_data(sec_firmware_img, ld_node_off,
-				       &data, &size)) {
+		if (fit_image_get_emb_data(sec_firmware_img, ld_node_off,
+					   &data, &size)) {
 			printf("SEC Loadable: Can't get subimage data/size");
 			return -ENOENT;
 		}
diff --git a/arch/arm/mach-k3/r5/sysfw-loader.c b/arch/arm/mach-k3/r5/sysfw-loader.c
index 188731e673d..c323d2f78f8 100644
--- a/arch/arm/mach-k3/r5/sysfw-loader.c
+++ b/arch/arm/mach-k3/r5/sysfw-loader.c
@@ -115,7 +115,7 @@ static int fit_get_data_by_name(const void *fit, int images, const char *name,
 	if (node_offset < 0)
 		return -ENOENT;
 
-	return fit_image_get_data(fit, node_offset, addr, size);
+	return fit_image_get_emb_data(fit, node_offset, addr, size);
 }
 
 static void k3_start_system_controller(int rproc_id, bool rproc_loaded,
diff --git a/arch/x86/lib/bootm.c b/arch/x86/lib/bootm.c
index 5fb46112ccb..3305560aa06 100644
--- a/arch/x86/lib/bootm.c
+++ b/arch/x86/lib/bootm.c
@@ -106,9 +106,9 @@ static int boot_prep_linux(struct bootm_headers *images)
 		is_zimage = 1;
 #if defined(CONFIG_FIT)
 	} else if (images->fit_uname_os && is_zimage) {
-		ret = fit_image_get_data(images->fit_hdr_os,
-				images->fit_noffset_os,
-				(const void **)&data, &len);
+		ret = fit_image_get_emb_data(images->fit_hdr_os,
+					     images->fit_noffset_os,
+					     (const void **)&data, &len);
 		if (ret) {
 			puts("Can't get image data/size!\n");
 			goto error;
diff --git a/boot/image-fit.c b/boot/image-fit.c
index 7d56f0b5e6e..4b116ba5891 100644
--- a/boot/image-fit.c
+++ b/boot/image-fit.c
@@ -902,13 +902,13 @@ int fit_image_get_entry(const void *fit, int noffset, ulong *entry)
 }
 
 /**
- * fit_image_get_data - get data property and its size for a given component image node
+ * fit_image_get_emb_data - get data property and its size for a given component image node
  * @fit: pointer to the FIT format image header
  * @noffset: component image node offset
  * @data: double pointer to void, will hold data property's data address
  * @size: pointer to size_t, will hold data property's data size
  *
- * fit_image_get_data() finds data property in a given component image node.
+ * fit_image_get_emb_data() finds data property in a given component image node.
  * If the property is found its data start address and size are returned to
  * the caller.
  *
@@ -916,8 +916,8 @@ int fit_image_get_entry(const void *fit, int noffset, ulong *entry)
  *     0, on success
  *     -1, on failure
  */
-int fit_image_get_data(const void *fit, int noffset,
-		const void **data, size_t *size)
+int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
+			   size_t *size)
 {
 	int len;
 
@@ -1074,7 +1074,7 @@ int fit_image_get_data_and_size(const void *fit, int noffset,
 			*size = len;
 		}
 	} else {
-		ret = fit_image_get_data(fit, noffset, data, size);
+		ret = fit_image_get_emb_data(fit, noffset, data, size);
 	}
 
 	return ret;
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 3160f573bfb..097c731d9a3 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -282,7 +282,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
 		src = src_ptr + overhead;
 	} else {
 		/* Embedded data */
-		if (fit_image_get_data(fit, node, &data, &length)) {
+		if (fit_image_get_emb_data(fit, node, &data, &length)) {
 			puts("Cannot get image data/size\n");
 			return -ENOENT;
 		}
diff --git a/common/splash_source.c b/common/splash_source.c
index f43e7cc1be7..5ac32a2f995 100644
--- a/common/splash_source.c
+++ b/common/splash_source.c
@@ -396,7 +396,9 @@ static int splash_load_fit(struct splash_location *location, u32 bmp_load_addr)
 
 	/* Extract the splash data from FIT */
 	/* 1. Test if splash is in FIT internal data. */
-	if (!fit_image_get_data(fit_header, node_offset, &internal_splash_data, &internal_splash_size))
+	if (!fit_image_get_emb_data(fit_header, node_offset,
+				    &internal_splash_data,
+				    &internal_splash_size))
 		memmove((void *)(uintptr_t)bmp_load_addr, internal_splash_data, internal_splash_size);
 	/* 2. Test if splash is in FIT external data with fixed position. */
 	else if (!fit_image_get_data_position(fit_header, node_offset, &external_splash_addr))
diff --git a/common/update.c b/common/update.c
index 6801b49479d..d149ca18e78 100644
--- a/common/update.c
+++ b/common/update.c
@@ -200,7 +200,7 @@ static int update_fit_getparams(const void *fit, int noffset, ulong *addr,
 {
 	const void *data;
 
-	if (fit_image_get_data(fit, noffset, &data, (size_t *)size))
+	if (fit_image_get_emb_data(fit, noffset, &data, (size_t *)size))
 		return 1;
 
 	if (fit_image_get_load(fit, noffset, (ulong *)fladdr))
diff --git a/include/image.h b/include/image.h
index de44dc09d07..e5241648b5e 100644
--- a/include/image.h
+++ b/include/image.h
@@ -1196,8 +1196,8 @@ int fit_image_get_type(const void *fit, int noffset, uint8_t *type);
 int fit_image_get_comp(const void *fit, int noffset, uint8_t *comp);
 int fit_image_get_load(const void *fit, int noffset, ulong *load);
 int fit_image_get_entry(const void *fit, int noffset, ulong *entry);
-int fit_image_get_data(const void *fit, int noffset,
-				const void **data, size_t *size);
+int fit_image_get_emb_data(const void *fit, int noffset, const void **data,
+			   size_t *size);
 int fit_image_get_data_offset(const void *fit, int noffset, int *data_offset);
 int fit_image_get_data_position(const void *fit, int noffset,
 				int *data_position);
diff --git a/tools/image-host.c b/tools/image-host.c
index 5e01b853c50..007a94f72d5 100644
--- a/tools/image-host.c
+++ b/tools/image-host.c
@@ -574,7 +574,7 @@ int fit_image_cipher_data(const char *keydir, void *keydest,
 	}
 
 	/* Get image data and data length */
-	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
+	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
 		fprintf(stderr, "Can't get image data/size\n");
 		return -1;
 	}
@@ -654,7 +654,7 @@ int fit_image_add_verification_data(const char *keydir, const char *keyfile,
 	int noffset;
 
 	/* Get image data and data length */
-	if (fit_image_get_data(fit, image_noffset, &data, &size)) {
+	if (fit_image_get_emb_data(fit, image_noffset, &data, &size)) {
 		fprintf(stderr, "Can't get image data/size\n");
 		return -1;
 	}
-- 
2.34.1

