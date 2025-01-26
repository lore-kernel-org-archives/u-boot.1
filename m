Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C95BC02181
	for <u-boot@archiver.kernel.org>; Sun, 26 Jan 2025 18:46:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 096E481109;
	Sun, 26 Jan 2025 19:44:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="lbYADIO7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 563FA80FD4; Sun, 26 Jan 2025 19:44:33 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4A1E810E5
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 19:44:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-84a012f7232so135990339f.0
 for <u-boot@lists.denx.de>; Sun, 26 Jan 2025 10:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1737917069; x=1738521869; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=epDTEL3KoYai/fMut8CgKa631MxtOyDNllCsx5RyjEI=;
 b=lbYADIO75oyklNTxzbISWErdT6iKWbtKL95fFc2+hQIUxFUX+92yAaY5zT0gATJ1Ai
 eu9szY40/KJV6kZ2tjrCXlS/zxHK5zLUmFozSj5hD06V7eGWtpRDg9MboOygR/lcLBbT
 Vs0r/nMn5AtnHrM3YYPD7tVMbFF0wi0o3gRXs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737917069; x=1738521869;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=epDTEL3KoYai/fMut8CgKa631MxtOyDNllCsx5RyjEI=;
 b=Rwwh9SVOti4qtbCwilYQVaJIFT5nO0tHilOLeMDvtzzYZPZtsXjOihHwUwFrHA2RU+
 HhQUb3pm8/Q99LbjnpmVCjzeqiN2O1ISdKAB3JAvgF9OIGdWpozoReXouEtO9B3vHszp
 CKll0EQl+neKh3YE0mtcjVcCQgDL0X41AMR3NLW9jdGyBfqWg5/qbJNko9pi3fW9/CuA
 f7f4jJp4GUkg+ImltfSRwmakrZkNiCWOYGeoOk3o4VSNIlTcm40eJ5FXIB/+ZMdExQ9y
 rozsMyCIwjnTDU534ZeGf0WeQ7h9E0XauxyC7mwtb/JyDoZdL8sNuQNonI9p6RSpweoo
 W+iw==
X-Gm-Message-State: AOJu0YzTvbSy833J12tj9f+j/5YdobPIlXKWsD/hGNNDW8TVu84j4f0J
 j8KCv25SZqKHGFfYKQ6wZMvsyB9l7w/1cimNkcScGuEJT0XAIDEIvI4pQpezKKLgMmCwqlGFrEM
 =
X-Gm-Gg: ASbGnct6UGmBsaSdvs8vkoTb6p1zqbG0tQ7j/+4eer65uJv8dCAyL5yYGiJtO2S0Kmc
 y+eRfK97inmeDn2ZtKQdMIJxQI8xXk5oXjHk2Xk5KgV1BabhzpeY8g7df3nItU3ZXY1AiCcczC/
 OFylX6obWhxoZ7HI/pc72VEGcg1V0ezEi3OwacGleV2cnWOQxsrZUBVnwNtDw/VyzGBLvnCNAOH
 AInaYn6Y6Rr2EZMbZOdKd7UHdwKc6Xq3FAhqnVrawvg/rFfPivTkcA/eVxpa4rlA6pljcA3hDv9
 OV+cmpPehXXADZ7//4R4djO8FPTmstTNirMOwHurGQ==
X-Google-Smtp-Source: AGHT+IF+OJTCCk+Z62WwpdWTyT7e1zevan2aMJFcbgeCsJ2Wkjjkmj4IiRCoT4RdiyaXdP3n+U7R+A==
X-Received: by 2002:a5d:9649:0:b0:841:9225:1f56 with SMTP id
 ca18e2360f4ac-8521e32b3camr799179439f.3.1737917068878; 
 Sun, 26 Jan 2025 10:44:28 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ec1da317fesm2160641173.42.2025.01.26.10.44.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Jan 2025 10:44:27 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Devarsh Thakkar <devarsht@ti.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Leo Yu-Chi Liang <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 18/19] vbe: Allow VBE to disable adding loadables to the FDT
Date: Sun, 26 Jan 2025 11:43:28 -0700
Message-ID: <20250126184333.4058848-19-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250126184333.4058848-1-sjg@chromium.org>
References: <20250126184333.4058848-1-sjg@chromium.org>
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

When VBE operates within VPL it does not want the FDT to be changed.
Provide a way to disable this feature.

Move the FIT_IMAGE_TINY condition out of spl_fit_record_loadable() so
that both conditions are together. This makes the code easier to
understand.

Replace the existing fit_loaded member, which is no-longer used.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/vbe_common.c    |  1 +
 common/spl/spl_fit.c |  6 ++----
 include/spl.h        | 19 ++++++++++++++-----
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/boot/vbe_common.c b/boot/vbe_common.c
index 009bbcd3e76..801ab9da045 100644
--- a/boot/vbe_common.c
+++ b/boot/vbe_common.c
@@ -208,6 +208,7 @@ int vbe_read_fit(struct udevice *blk, ulong area_offset, ulong area_size,
 		struct spl_load_info info;
 
 		spl_load_init(&info, h_vbe_load_read, desc, desc->blksz);
+		xpl_set_fdt_update(&info, false);
 		xpl_set_phase(&info, IH_PHASE_U_BOOT);
 		log_debug("doing SPL from %s blksz %lx log2blksz %x area_offset %lx + fdt_size %lx\n",
 			  blk->name, desc->blksz, desc->log2blksz, area_offset, ALIGN(size, 4));
diff --git a/common/spl/spl_fit.c b/common/spl/spl_fit.c
index 6c068a842d9..d663737089d 100644
--- a/common/spl/spl_fit.c
+++ b/common/spl/spl_fit.c
@@ -515,9 +515,6 @@ static int spl_fit_record_loadable(const struct spl_fit_info *ctx, int index,
 	const char *name;
 	int node;
 
-	if (CONFIG_IS_ENABLED(FIT_IMAGE_TINY))
-		return 0;
-
 	ret = spl_fit_get_image_name(ctx, "loadables", index, &name);
 	if (ret < 0)
 		return ret;
@@ -863,7 +860,8 @@ int spl_load_simple_fit(struct spl_image_info *spl_image,
 			spl_image->entry_point = image_info.entry_point;
 
 		/* Record our loadables into the FDT */
-		if (spl_image->fdt_addr)
+		if (!CONFIG_IS_ENABLED(FIT_IMAGE_TINY) &&
+		    xpl_get_fdt_update(info) && spl_image->fdt_addr)
 			spl_fit_record_loadable(&ctx, index,
 						spl_image->fdt_addr,
 						&image_info);
diff --git a/include/spl.h b/include/spl.h
index 7155e9c67aa..850c64d4b19 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -345,7 +345,7 @@ typedef ulong (*spl_load_reader)(struct spl_load_info *load, ulong sector,
  * @priv: Private data for the device
  * @bl_len: Block length for reading in bytes
  * @phase: Image phase to load
- * @fit_loaded: true if the FIT has been loaded, except for external data
+ * @no_fdt_update: true to update the FDT with any loadables that are loaded
  */
 struct spl_load_info {
 	spl_load_reader read;
@@ -355,7 +355,7 @@ struct spl_load_info {
 #endif
 #if CONFIG_IS_ENABLED(BOOTMETH_VBE)
 	u8 phase;
-	u8 fit_loaded;
+	u8 fdt_update;
 #endif
 };
 
@@ -395,12 +395,20 @@ static inline enum image_phase_t xpl_get_phase(struct spl_load_info *info)
 #endif
 }
 
-static inline bool xpl_get_fit_loaded(struct spl_load_info *info)
+static inline void xpl_set_fdt_update(struct spl_load_info *info,
+				      bool fdt_update)
 {
 #if CONFIG_IS_ENABLED(BOOTMETH_VBE)
-	return info->fit_loaded;
+	info->fdt_update = fdt_update;
+#endif
+}
+
+static inline enum image_phase_t xpl_get_fdt_update(struct spl_load_info *info)
+{
+#if CONFIG_IS_ENABLED(BOOTMETH_VBE)
+	return info->fdt_update;
 #else
-	return false;
+	return true;
 #endif
 }
 
@@ -415,6 +423,7 @@ static inline void spl_load_init(struct spl_load_info *load,
 	load->priv = priv;
 	spl_set_bl_len(load, bl_len);
 	xpl_set_phase(load, IH_PHASE_NONE);
+	xpl_set_fdt_update(load, true);
 }
 
 /*
-- 
2.43.0

