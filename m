Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE99C02198
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 02:02:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 20954807FE;
	Sun,  9 Feb 2025 03:02:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mRMoPwAV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 46E888083F; Sun,  9 Feb 2025 03:01:56 +0100 (CET)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A361480050
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 03:01:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-84cdacbc373so103296739f.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 18:01:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739066509; x=1739671309; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dA0rNl2qCnfv5qTZ+YMGz0CSNUXkOSBUxxv5WVyvkfg=;
 b=mRMoPwAVRvcKJr8QVtclf9+bLnRoxWVuYIlX4YdEyzjNZ4NZ7gO0fHCE7L9hMZ9YKp
 jdnWFmo0d0cR8kPP5PPInxTMmmbppddxKyatdIQAJ2WQkxLxV0c5JG8akn1n5cGEIhDD
 OvMeeOV/Q32uI01NF5ge0yIXPLs8S3eFbwtjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739066509; x=1739671309;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dA0rNl2qCnfv5qTZ+YMGz0CSNUXkOSBUxxv5WVyvkfg=;
 b=ZRhe9bxOltbup42Q4p28D45gxaqyjLc5tgw8MYiWCDKOxFZnwRNWgbgr0vgJpdNdP2
 7Tw/TduE1YNJ5NZnavTIW/0eQPnzSyHWSrWPfji30W0EoKAz+4x+DmUEELO3AYQI1eKw
 8dQe4ApL3omEqNHa6fmwMHqabgdjvXNZLlzFkD18UP/Tu0VZtymYhv+rmnfGuvV2N21m
 CTGAKjp2Wx6Su/FwLXo35mvmIvxyG/+cZn5DNlPMVieLJse8v/zeY0I4xKQCeVItO8vG
 DXPjA3Q6Ed2+u+xeighlTEnEHr+lZfyF1Ma9IJ9OTZbH8Hmk9tPiQf6TtKPMCYYMb9ay
 vfuA==
X-Gm-Message-State: AOJu0Ywp6wHdQd1HqhMOrTeOieEMwTZh2pkVkd79x5HOnTHU1WBmlP9Y
 lMdnh+RHSOO7wA9CvvHxYtCijaHadiNdLICB7L3akLRCq6YFFGweCy791ninvKRj+hSW1d6KSGY
 =
X-Gm-Gg: ASbGncsIDwoXz8/J6RaLYjBl+VdLi6Vm058F7MbalUUqYePsUJiKFuIN+1DIig4xN/1
 jkX/R745M9XYPu0FW4ce5spfIqlzwH0JaLQtupAsa3si84EGfdn1JNIVk9x3X92aLRsIzehQqnk
 9hf5JZcKSq4puzNqCVKvsJLzDdm38vjD4WQyP8+g+1+YaOQOd8cC9dWymsdmjZUe8ti8FBWR+IY
 eMVAvSESS3/ZHVZ0wayPQZz5umE1Bwh0hVE681UDl+5wvjWZEavaChSGpP3tg8oLxQ2fXYdzwqQ
 28Yiv/9o6gqsR0WxUxV7Wa9law6077I6ZxuyaYSO5DP63ecM0bjf
X-Google-Smtp-Source: AGHT+IG3Xsd5EUTl+/th9Bo2nRlM8nS5xPYj2SAZlT/oTEDdxclASLMAn+o4N8j4z+HkZ0i1KqCgsA==
X-Received: by 2002:a05:6e02:1949:b0:3ce:8b1b:2f with SMTP id
 e9e14a558f8ab-3d13dee4459mr60993425ab.17.1739066509464; 
 Sat, 08 Feb 2025 18:01:49 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4eccfad03d4sm1506705173.75.2025.02.08.18.01.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 18:01:45 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>, Heiko Schocher <hs@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v3 02/29] video: Move vesa_setup_video_priv() into its own file
Date: Sat,  8 Feb 2025 19:01:01 -0700
Message-ID: <20250209020136.4108987-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250209020136.4108987-1-sjg@chromium.org>
References: <20250209020136.4108987-1-sjg@chromium.org>
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

This helper is used by the EFI driver and we would like to use that on
ARM. Move the helper function into its own file, separate from PCI ROMs,
which are an x86 thing.

Add a forward declaration for struct udevice so that the header can be
included directly.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v3:
- Use the same copyright message as the original pci_rom.c file

 drivers/pci/pci_rom.c       | 32 -----------------------------
 drivers/video/Makefile      |  2 ++
 drivers/video/vesa_helper.c | 41 +++++++++++++++++++++++++++++++++++++
 include/vesa.h              |  2 ++
 4 files changed, 45 insertions(+), 32 deletions(-)
 create mode 100644 drivers/video/vesa_helper.c

diff --git a/drivers/pci/pci_rom.c b/drivers/pci/pci_rom.c
index 2753df275ca..35654ca89ac 100644
--- a/drivers/pci/pci_rom.c
+++ b/drivers/pci/pci_rom.c
@@ -334,38 +334,6 @@ err:
 	return ret;
 }
 
-int vesa_setup_video_priv(struct vesa_mode_info *vesa, u64 fb,
-			  struct video_priv *uc_priv,
-			  struct video_uc_plat *plat)
-{
-	if (!vesa->x_resolution)
-		return log_msg_ret("No x resolution", -ENXIO);
-	uc_priv->xsize = vesa->x_resolution;
-	uc_priv->ysize = vesa->y_resolution;
-	uc_priv->line_length = vesa->bytes_per_scanline;
-	switch (vesa->bits_per_pixel) {
-	case 32:
-	case 24:
-		uc_priv->bpix = VIDEO_BPP32;
-		break;
-	case 16:
-		uc_priv->bpix = VIDEO_BPP16;
-		break;
-	default:
-		return -EPROTONOSUPPORT;
-	}
-
-	/* Use double buffering if enabled */
-	if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->base)
-		plat->copy_base = fb;
-	else
-		plat->base = fb;
-	log_debug("base = %lx, copy_base = %lx\n", plat->base, plat->copy_base);
-	plat->size = vesa->bytes_per_scanline * vesa->y_resolution;
-
-	return 0;
-}
-
 int vesa_setup_video(struct udevice *dev, int (*int15_handler)(void))
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
diff --git a/drivers/video/Makefile b/drivers/video/Makefile
index 5a00438ce06..416a929d36b 100644
--- a/drivers/video/Makefile
+++ b/drivers/video/Makefile
@@ -27,6 +27,8 @@ obj-$(CONFIG_$(PHASE_)SIMPLE_PANEL) += simple_panel.o
 obj-$(CONFIG_VIDEO_LOGO) += u_boot_logo.o
 obj-$(CONFIG_$(PHASE_)BMP) += bmp.o
 
+obj-y += vesa_helper.o
+
 endif
 
 obj-$(CONFIG_BACKLIGHT_LM3533) += lm3533_backlight.o
diff --git a/drivers/video/vesa_helper.c b/drivers/video/vesa_helper.c
new file mode 100644
index 00000000000..d430d3c9989
--- /dev/null
+++ b/drivers/video/vesa_helper.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2014 Google, Inc
+ */
+
+#include <errno.h>
+#include <log.h>
+#include <vesa.h>
+#include <video.h>
+
+int vesa_setup_video_priv(struct vesa_mode_info *vesa, u64 fb,
+			  struct video_priv *uc_priv,
+			  struct video_uc_plat *plat)
+{
+	if (!vesa->x_resolution)
+		return log_msg_ret("No x resolution", -ENXIO);
+	uc_priv->xsize = vesa->x_resolution;
+	uc_priv->ysize = vesa->y_resolution;
+	uc_priv->line_length = vesa->bytes_per_scanline;
+	switch (vesa->bits_per_pixel) {
+	case 32:
+	case 24:
+		uc_priv->bpix = VIDEO_BPP32;
+		break;
+	case 16:
+		uc_priv->bpix = VIDEO_BPP16;
+		break;
+	default:
+		return -EPROTONOSUPPORT;
+	}
+
+	/* Use double buffering if enabled */
+	if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->base)
+		plat->copy_base = fb;
+	else
+		plat->base = fb;
+	log_debug("base = %lx, copy_base = %lx\n", plat->base, plat->copy_base);
+	plat->size = vesa->bytes_per_scanline * vesa->y_resolution;
+
+	return 0;
+}
diff --git a/include/vesa.h b/include/vesa.h
index 9285bfa921a..abfc624e7cc 100644
--- a/include/vesa.h
+++ b/include/vesa.h
@@ -10,6 +10,8 @@
 #ifndef _VESA_H
 #define _VESA_H
 
+struct udevice;
+
 /* these structs are for input from and output to OF */
 struct __packed vesa_screen_info {
 	u8 display_type;	/* 0=NONE, 1= analog, 2=digital */
-- 
2.43.0

