Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C11FEE7719C
	for <u-boot@archiver.kernel.org>; Sat, 11 Jan 2025 00:02:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8371E80628;
	Sat, 11 Jan 2025 01:01:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FFuUq7ND";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4756B8036B; Sat, 11 Jan 2025 01:01:20 +0100 (CET)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E219280050
 for <u-boot@lists.denx.de>; Sat, 11 Jan 2025 01:01:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-84cdacbc373so78576239f.1
 for <u-boot@lists.denx.de>; Fri, 10 Jan 2025 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1736553676; x=1737158476; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FN7Obh2a+NlfafdQrDJKATlCjmk8SuTZikPySHXtQtg=;
 b=FFuUq7NDx6rIcaw5uHEqiVrcnST2Hqvbt+cQFrCLGA0LQXqcvWKiTOhGPhx1nd0+ay
 fRrOE4zG+0Bvo15oiIWYWAHrzq2RJ0oawDSoxQ60WfV7dW0TaR7YhAOxqIP5aB42l6FL
 ZjFhWp1aiAtYCt0ZGzTIInZv2e1IPmqqOkVYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736553676; x=1737158476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FN7Obh2a+NlfafdQrDJKATlCjmk8SuTZikPySHXtQtg=;
 b=bZjqDtaaPG4Uybdbc6Pma9AoPPGGqlDP2yGh1olhfyPC3wslC/jML1Wr8sIQwBcFbB
 nq3LZ52EqY3yTn89cVlQ1IkZuQ+bfle1e3X+kkjdatS9ABLUsCZ+aGJTvAb4UqGwOUXX
 LAFbtclsVpWbMDYPVbxighEH2Vpt14rUuVAl7/ZzrhPQ3KhW1FO2WSnTsJO1zCi1iiX6
 qy6vTSAxJ3e0t3EDvrhPg+pgqknjBcht9qgqp4XfifiuaOC0HWtDf+R0YJlLQCP7VlH7
 meaDw6+z5J1VM/7Q7CCT4MiPNpO8NcidVrHD/my3cwH8TP6YC5fkBoVKiKVNCvhh3p9V
 kMAQ==
X-Gm-Message-State: AOJu0Ywe1PEGwAnZ+NCf+Kk9UaamEUc3BDswBDh181AqtT2MYtWuwGes
 Mlsuiyh7MIj64vRqtk73RTSJ/7dUxrt2w3zZzIcP+nEOlNRe6XxfFsz00quGd6KWYjQZ5/WWA/c
 =
X-Gm-Gg: ASbGnctK8Za3uBN9TjzQgNSbH5UWfTs0H1yLUItAoF//5uFTv6UOoi9K4tghNclNsRH
 M+uoPmt8WRByiVJKmh3Ozgltk+H/lUDj+EZU+ovUTHvXvc13CvVHnP29YjeDVMHHAkXorRDx7SI
 v+FaRbCjcxOTbsKw6pdqXKVygBP1SLQV85BOzQmF/3Gb14mYH+C6mcvi7yh4EBg5l1SJoadftcj
 4yt6StMLRhrRtREZA6f5o/JwoK9+u0MCrgMWlHqj4Pb8nHj9j8kJciy9JwUQRGd5GeKRmk/+4vV
 M1XK3B/SJIMB+EEiuA==
X-Google-Smtp-Source: AGHT+IFBL5nR/o1/KHiCqBR4+PWz2Ry1rgarNLMBk+Q+aVVIpos/k7h6ctoK3UcJ4MrOSyhiFkWHtA==
X-Received: by 2002:a05:6e02:1f89:b0:3a7:8cdd:c0d2 with SMTP id
 e9e14a558f8ab-3ce3a7a9681mr94997145ab.0.1736553676108; 
 Fri, 10 Jan 2025 16:01:16 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ea1b5f93desm1171884173.14.2025.01.10.16.01.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 16:01:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alexander Dahl <ada@thorsis.com>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Bin Meng <bmeng.cn@gmail.com>, Devarsh Thakkar <devarsht@ti.com>,
 Hugo Cornelis <hugo.cornelis@essensium.com>,
 Igor Opaniuk <igor.opaniuk@gmail.com>, Janne Grunau <j@jannau.net>,
 Julien Masson <jmasson@baylibre.com>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Lukasz Majewski <lukma@denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Nikhil M Jain <n-jain1@ti.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Roman Stratiienko <r.stratiienko@gmail.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 13/30] boot: Rename fit_image_get_data()
Date: Fri, 10 Jan 2025 17:00:12 -0700
Message-Id: <20250111000029.245022-14-sjg@chromium.org>
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
index db7fb61bca9..7ad6e51d8ed 100644
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
index ac8462577ff..64c4349b138 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -289,7 +289,7 @@ static int load_simple_fit(struct spl_load_info *info, ulong fit_offset,
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
index cd29d9d469c..d09851eb9f0 100644
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

