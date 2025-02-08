Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30B8C0219E
	for <u-boot@archiver.kernel.org>; Sat,  8 Feb 2025 17:12:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E88F080836;
	Sat,  8 Feb 2025 18:12:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kvu3PrDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3FE580834; Sat,  8 Feb 2025 18:12:13 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1D1AD80836
 for <u-boot@lists.denx.de>; Sat,  8 Feb 2025 18:12:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-855183fdcafso2519239f.1
 for <u-boot@lists.denx.de>; Sat, 08 Feb 2025 09:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739034729; x=1739639529; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KOdjs84Zbt+5hou13J9QMXmU7BUGnaNH73KvWX00ZoE=;
 b=kvu3PrDVPhrZxgd+0LRU5HkLxLjNuKrYYHDiSgd59EstKPZP17wHFs7BuqqjhZlNc7
 KKIoSqbByJM063aEIFQ71RNZgnh12IxJLqA/uhLL1q11HlD3HSW7ePGAbKqF0BPoUVAc
 hbedk33dTYXSIesM7Cy0sqe5K42Y/Px+OQCBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739034729; x=1739639529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KOdjs84Zbt+5hou13J9QMXmU7BUGnaNH73KvWX00ZoE=;
 b=YyEP10Rap+g53k+ky63P6sZS0m63kCrdmIh55YPrg2Daed66brmibYjY067h+07vvq
 GqhdmCPZw4uHOQQejBr8nZFYvg2jqGVhfHTZGQ+tnpHu/auwgiXfus1K2lyKn9Z17umG
 mDDaEEGsZ81EcsW8Ih8q4yTygWpgOgie/6JbvXP3ac0LVBSScLKbbo/NA0+e58AzD14f
 w7tlOJO8ACtTba9wFGA5PD7v8ZZ0JaD+DfuI9EWAgBwDcA3FXzO87dEid1YrK4jRgRgU
 WXSxStLRSxP9dd0msN0utfZLM4/jobmrIuGBN/EKreBXD3gazQE3MIR2LoFV+hCKtIq0
 pwpg==
X-Gm-Message-State: AOJu0YyHfltdQudPfZB0L6dOzzR26SPVjI3OFMQULTPepvq3MN7qJbnA
 m+azn8o3yh0UuHr0TOfsQlMeFhK/yREeKmnu8tV+nKyuZ88pEMWy9jyxVnlK6nXdXQbzBIdcj68
 =
X-Gm-Gg: ASbGncvNLC49WidsHoa0VI9c8yxjiXBR4mNuLKjuWU0Uc1zXXo9ONkaJostfBo4EcqP
 xYl52HYSxIo0UO7SxqaWTO0jTMaV8ECP2Jrc28TrFOaNyxfJRU7txuEhxh/cjfMp2G+uBMpNlAp
 566LkytPxchLfDM5otYjpOaqxkGOAGDIXWnub6JCLs3JDY0KkaAlOtKr3SqOX5+1Z17eR3N2F5r
 nszdiRBLDRwSVI0HVQ2mHjHOprEo9KimEvGNW9gayU9ZW3dz+3BtxXMQTbqZeKC/Pc9N5qdJ2ew
 PMg6Fc5ATg5SHCp5PWYzNAXYGt1v+Fh+F7WIAsFroGQxmr0OzoGO
X-Google-Smtp-Source: AGHT+IFfrOzP+eetYeYy+b/ScD1N59UFuOTkHGEdpDud0h2UW3Ly+XhwVarwK0vy+6/ThVukl65V+w==
X-Received: by 2002:a5d:8347:0:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-854f3a2d2f2mr919233739f.4.1739034728877; 
 Sat, 08 Feb 2025 09:12:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ece80badb5sm371754173.68.2025.02.08.09.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2025 09:12:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>, Heiko Schocher <hs@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 02/29] video: Move vesa_setup_video_priv() into its own file
Date: Sat,  8 Feb 2025 10:11:22 -0700
Message-ID: <20250208171154.1305761-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250208171154.1305761-1-sjg@chromium.org>
References: <20250208171154.1305761-1-sjg@chromium.org>
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

(no changes since v1)

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
index 00000000000..dde8797e765
--- /dev/null
+++ b/drivers/video/vesa_helper.c
@@ -0,0 +1,41 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025, Simon Glass <simon.glass@canonical.com>
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

