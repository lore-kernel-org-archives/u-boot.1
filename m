Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A9CE7718B
	for <u-boot@archiver.kernel.org>; Wed,  1 Jan 2025 22:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7233F80433;
	Wed,  1 Jan 2025 23:13:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EOJLavA5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EC8998060F; Wed,  1 Jan 2025 23:13:20 +0100 (CET)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com
 [IPv6:2607:f8b0:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7F5F9803F6
 for <u-boot@lists.denx.de>; Wed,  1 Jan 2025 23:13:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2166360285dso147188495ad.1
 for <u-boot@lists.denx.de>; Wed, 01 Jan 2025 14:13:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1735769596; x=1736374396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JHiZj4uk86EKgs20eD6f8TaJysBYpYW/2PUnI5oBjL0=;
 b=EOJLavA5ZfZVU/HTwDX8dSS8Pb4G/mlkNH2JcNeYgCJtuxkj5zqtQMa8kgOVSOFgDo
 WIA565dnhBXUH0TSwjdfuHzLc4PsVDBFLKdCH4nVDYoEb9n5aNVSwkQJhleWttWTGl1Z
 ds/Si0PtvUJpDDVpJRIzBxBwqqLf/QK8ehbnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735769596; x=1736374396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JHiZj4uk86EKgs20eD6f8TaJysBYpYW/2PUnI5oBjL0=;
 b=YruhxgMDbVmGCF7B0EhIIWBST176cZ8kxyaqqZfSgnE26ZEveKjuCUI7InBgXeER3e
 wVz6KMHVhhISRU1UpTqtUxV7F1yPm/BjQfS3hrBwFg/xhUgcwTDhAaSRI18Z01x/XFUr
 CK13iNV/3GXcsM3Ro6CzG80AWsgyzxVs2pi6m7WBdVUkCB9eOjcBAeLmLrsHS55K9/9A
 evb6u0eH9ofPWRQ0T537odMhwyWM+95/nrdiW8p+aSreec3ZEn6nkgVMLiFJlh6fyrLW
 4z6b9pQO1w6gvL+sxzFSwGfLi+OQfvUQ0hZ1KO4LK6/DmjlW05gkKEiklJGY5rb5locx
 8gWg==
X-Gm-Message-State: AOJu0YzsMe2qxdsbxdkKSXZQrl76uWh9HDsNj/ZQ9nyJl/A/YhRuceXA
 azoDegcRYjvUV78ociA1/z86Izy31AYQpDzwsD7jPNhOtk5/udKQ6Hhyw8F6znxEKNDSvIIsJ0I
 =
X-Gm-Gg: ASbGncsNvnvm465Eii9T/hSl5C+P0zhv6CLsPHklvMoRZvN5h0UI8kHmNHeaC3hIfXY
 tI9Tbr+QMIahgf3HZjhcvvV1GyPuJhwUzyDGCl+xzHkpCALBFHDBGMZMKXEpBZNM8OKvuiIoonn
 55BPKQEGQdJvIRflcqAQ85eJ95/P1k5OdrQYpenJMRs3oVtaEdMolyQLVtepTSwf4qEWlhLPqkB
 Xq13DU4gm9vVAlnIiisQSrS3fyVouEjjtUGDtTLkKet0YSXXJJBoTc=
X-Google-Smtp-Source: AGHT+IHTP7N3VFm3xaGICQF5ds9A0qYUYJez+4WbRMyDpqJ2O3w2fJRnitOEIub8mrOb5UuqSgZ3EQ==
X-Received: by 2002:aa7:888c:0:b0:725:f212:12e5 with SMTP id
 d2e1a72fcca58-72abded14e5mr68258980b3a.24.1735769596454; 
 Wed, 01 Jan 2025 14:13:16 -0800 (PST)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72ad3393d5fsm18873947b3a.154.2025.01.01.14.13.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jan 2025 14:13:15 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 28/67] upl: Move serial and graphics addition-code to
 upl_common
Date: Thu,  2 Jan 2025 11:09:14 +1300
Message-ID: <20250101221003.1944600-29-sjg@chromium.org>
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

This will be useful in U-Boot proper, so move the code from spl_upl to
the generic spl_common file.

Tweak the compatible string for serial and make sure to use the UPL
values for I/O / memory, even though they currently happen to be the
same as is used by U-Boot.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/upl_common.c    | 78 ++++++++++++++++++++++++++++++++++++++++++
 common/spl/spl_upl.c | 80 ++------------------------------------------
 include/upl.h        | 18 ++++++++++
 3 files changed, 98 insertions(+), 78 deletions(-)

diff --git a/boot/upl_common.c b/boot/upl_common.c
index 69a6673a9bf..a0ed5568854 100644
--- a/boot/upl_common.c
+++ b/boot/upl_common.c
@@ -8,8 +8,15 @@
 
 #define LOG_CATEGORY UCLASS_BOOTSTD
 
+#include <dm.h>
+#include <serial.h>
 #include <string.h>
 #include <upl.h>
+#include <video.h>
+#include <asm/global_data.h>
+#include <dm/uclass-internal.h>
+
+DECLARE_GLOBAL_DATA_PTR;
 
 /* Names of bootmodes */
 const char *const bootmode_names[UPLBM_COUNT] = {
@@ -50,6 +57,77 @@ const char *const graphics_formats[UPLUS_COUNT] = {
 	[UPLGF_ABGR64]	= "a16b16g16r16",
 };
 
+int upl_add_serial(struct upl_serial *ser)
+{
+	struct udevice *dev = gd->cur_serial_dev;
+	struct serial_device_info info;
+	struct memregion region;
+	int ret;
+
+	if (!dev)
+		return log_msg_ret("ser", -ENOENT);
+	ret = serial_getinfo(dev, &info);
+	if (ret)
+		return log_msg_ret("inf", ret);
+
+	ser->compatible = ofnode_read_string(dev_ofnode(dev), "compatible");
+	ser->clock_frequency = info.clock;
+	ser->current_speed = info.baudrate;
+	region.base = info.addr;
+	region.size = info.size;
+	if (!alist_add(&ser->reg, region))
+		return -ENOMEM;
+	ser->reg_io_shift = info.reg_shift;
+	ser->reg_offset = info.reg_offset;
+	ser->reg_io_width = info.reg_width;
+	ser->virtual_reg = 0;
+	ser->access_type = info.addr_space == SERIAL_ADDRESS_SPACE_IO ?
+		UPLAT_IO : UPLAT_MMIO;
+
+	return 0;
+}
+
+int upl_add_graphics(struct upl_graphics *gra)
+{
+	struct video_uc_plat *plat;
+	struct video_priv *priv;
+	struct memregion region;
+	struct udevice *dev;
+
+	uclass_find_first_device(UCLASS_VIDEO, &dev);
+	if (!dev || !device_active(dev))
+		return log_msg_ret("vid", -ENOENT);
+
+	plat = dev_get_uclass_plat(dev);
+	region.base = plat->base;
+	region.size = plat->size;
+	if (!alist_add(&gra->reg, region))
+		return log_msg_ret("reg", -ENOMEM);
+
+	priv = dev_get_uclass_priv(dev);
+	gra->width = priv->xsize;
+	gra->height = priv->ysize;
+	gra->stride = priv->line_length;	/* private field */
+	switch (priv->format) {
+	case VIDEO_RGBA8888:
+	case VIDEO_X8R8G8B8:
+		gra->format = UPLGF_ARGB32;
+		break;
+	case VIDEO_X8B8G8R8:
+		gra->format = UPLGF_ABGR32;
+		break;
+	case VIDEO_X2R10G10B10:
+		log_debug("device '%s': VIDEO_X2R10G10B10 not supported\n",
+			  dev->name);
+		return log_msg_ret("for", -EPROTO);
+	case VIDEO_UNKNOWN:
+		log_debug("device '%s': Unknown video format\n", dev->name);
+		return log_msg_ret("for", -EPROTO);
+	}
+
+	return 0;
+}
+
 void upl_init(struct upl *upl)
 {
 	memset(upl, '\0', sizeof(struct upl));
diff --git a/common/spl/spl_upl.c b/common/spl/spl_upl.c
index 81a106570b8..5c68e4ab283 100644
--- a/common/spl/spl_upl.c
+++ b/common/spl/spl_upl.c
@@ -12,14 +12,8 @@
 #include <bloblist.h>
 #include <dm.h>
 #include <image.h>
-#include <mapmem.h>
-#include <serial.h>
 #include <spl.h>
 #include <upl.h>
-#include <video.h>
-#include <asm/global_data.h>
-#include <dm/read.h>
-#include <dm/uclass-internal.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -57,76 +51,6 @@ int _upl_add_image(int node, ulong load_addr, ulong size, const char *desc)
 	return 0;
 }
 
-static int write_serial(struct upl_serial *ser)
-{
-	struct udevice *dev = gd->cur_serial_dev;
-	struct serial_device_info info;
-	struct memregion region;
-	int ret;
-
-	if (!dev)
-		return log_msg_ret("ser", -ENOENT);
-	ret = serial_getinfo(dev, &info);
-	if (ret)
-		return log_msg_ret("inf", ret);
-
-	ser->compatible = ofnode_read_string(dev_ofnode(dev), "compatible");
-	ser->clock_frequency = info.clock;
-	ser->current_speed = gd->baudrate;
-	region.base = info.addr;
-	region.size = info.size;
-	if (!alist_add(&ser->reg, region))
-		return -ENOMEM;
-	ser->reg_io_shift = info.reg_shift;
-	ser->reg_offset = info.reg_offset;
-	ser->reg_io_width = info.reg_width;
-	ser->virtual_reg = 0;
-	ser->access_type = info.addr_space;
-
-	return 0;
-}
-
-static int write_graphics(struct upl_graphics *gra)
-{
-	struct video_uc_plat *plat;
-	struct video_priv *priv;
-	struct memregion region;
-	struct udevice *dev;
-
-	uclass_find_first_device(UCLASS_VIDEO, &dev);
-	if (!dev || !device_active(dev))
-		return log_msg_ret("vid", -ENOENT);
-
-	plat = dev_get_uclass_plat(dev);
-	region.base = plat->base;
-	region.size = plat->size;
-	if (!alist_add(&gra->reg, region))
-		return log_msg_ret("reg", -ENOMEM);
-
-	priv = dev_get_uclass_priv(dev);
-	gra->width = priv->xsize;
-	gra->height = priv->ysize;
-	gra->stride = priv->line_length;	/* private field */
-	switch (priv->format) {
-	case VIDEO_RGBA8888:
-	case VIDEO_X8R8G8B8:
-		gra->format = UPLGF_ARGB32;
-		break;
-	case VIDEO_X8B8G8R8:
-		gra->format = UPLGF_ABGR32;
-		break;
-	case VIDEO_X2R10G10B10:
-		log_debug("device '%s': VIDEO_X2R10G10B10 not supported\n",
-			  dev->name);
-		return log_msg_ret("for", -EPROTO);
-	case VIDEO_UNKNOWN:
-		log_debug("device '%s': Unknown video format\n", dev->name);
-		return log_msg_ret("for", -EPROTO);
-	}
-
-	return 0;
-}
-
 int spl_write_upl_handoff(struct spl_image_info *spl_image)
 {
 	struct upl *upl = &s_upl;
@@ -139,10 +63,10 @@ int spl_write_upl_handoff(struct spl_image_info *spl_image)
 	upl->addr_cells = IS_ENABLED(CONFIG_PHYS_64BIT) ? 2 : 1;
 	upl->size_cells = IS_ENABLED(CONFIG_PHYS_64BIT) ? 2 : 1;
 	upl->bootmode = UPLBM_DEFAULT;
-	ret = write_serial(&upl->serial);
+	ret = upl_add_serial(&upl->serial);
 	if (ret)
 		return log_msg_ret("ser", ret);
-	ret = write_graphics(&upl->graphics);
+	ret = upl_add_graphics(&upl->graphics);
 	if (ret && ret != -ENOENT)
 		return log_msg_ret("gra", ret);
 
diff --git a/include/upl.h b/include/upl.h
index 9f2a6e7842d..e415130d44f 100644
--- a/include/upl.h
+++ b/include/upl.h
@@ -371,6 +371,24 @@ static inline int upl_add_image(const void *fit, int node, ulong load_addr,
 	return 0;
 }
 
+/**
+ * upl_add_serial() - Add serial information to the UPL struct
+ *
+ * Writes details about the current serial port to the UPL struct
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int upl_add_serial(struct upl_serial *ser);
+
+/**
+ * upl_add_graphics() - Add video information to the UPL struct
+ *
+ * Writes details about the current video device to the UPL struct
+ *
+ * Return: 0 if OK, -ve on error
+ */
+int upl_add_graphics(struct upl_graphics *gra);
+
 /** upl_init() - Set up a UPL struct */
 void upl_init(struct upl *upl);
 
-- 
2.43.0

