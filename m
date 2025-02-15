Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6121C021A4
	for <u-boot@archiver.kernel.org>; Sat, 15 Feb 2025 03:23:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 42C8080CB0;
	Sat, 15 Feb 2025 04:23:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hYsYy0+V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6768C80756; Sat, 15 Feb 2025 04:23:13 +0100 (CET)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2243680017
 for <u-boot@lists.denx.de>; Sat, 15 Feb 2025 04:23:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-3ce85545983so7059705ab.0
 for <u-boot@lists.denx.de>; Fri, 14 Feb 2025 19:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1739589788; x=1740194588; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pXjjBBvNUrCE2G1NFTkAKTlpaUFlf53116v1pXayk2c=;
 b=hYsYy0+VCQYGXW6litcx0X9W+gN1YcD/SjxJJTtXqujifdB37KkH1qW+TRzBMq9PSo
 cbslV+llHvhI6gPlQ/HkBC/gChUGllhk6s3k0CTeOhB0tPDIsL2ocYkWH4o3uaJrfmz/
 1ihVRARup6Fk6zWdkNF8sjqOk6Tf7o8LneXYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739589788; x=1740194588;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pXjjBBvNUrCE2G1NFTkAKTlpaUFlf53116v1pXayk2c=;
 b=QWjGIBK3co6ZMguB9msYvxAoH/5SA4hOQYnh8W4Baj9kBKR5CnGN+eYpxa8USa11y7
 ghEFGKbzEPNute/EDcO+UnhCOxUTdx0ScLpzyNww25f0X4VpL4U8I68SjITwTqvP2PEv
 D7d+AGQwNulo9TSsp1y7m33U16LRLRRcHpaMnEuT9dFQOWfwt07742UOPNxKTKy+KH0Q
 3I3t2A9fSSqw/AbtVsgSxcvNMgyzTvXMvbxtOsOoA8c1hJG2IHWciAJBTW60WL01pkHc
 jPotoG4GSTd2Ph/jYMPOuLJgp7/+vzxhr+F7e9xwVXd8hc+FdAq0N8xRiggS1kW7Mk64
 Hlvg==
X-Gm-Message-State: AOJu0YyyLTH+2JWuPpoC8gE6/O/G4yWU5bjR97WOsk4D3CCg7iFZYAiY
 71Qdag1kHTTiVyjVQkDSKa8db1U0cyUho0kks2QgztvbH+dwowyA8smsnE22acHZkI5vnLMJNik
 =
X-Gm-Gg: ASbGncu2nIRIGWEf7BHGPE8jnARK5aRpI1sNttMCM/1m99Tbl1E1BZP/S8KjFdL0DDT
 3QMAhJQ1wq7U9krOe37h/IP0S8SIlXhBzESQinyGIiH9IoS+1jBj3pXX0lBpFxWrrgPXSEfT0JP
 JM9G0cc04tQVxuD2SBhm4AuJDSnXDKsrdV07nPK2DeDj2Mq6+Wq9ZZBqN68Hbd+c6WPyFvSH9Zc
 gUCu02vuEztfj339owyQ9wvZ+eiFNLW3RNTHz8oi8yMWiY508ynJPwlD3yNvBXTXy2bKfffU0oX
 h0vCjXs1IfKepOaR7mkjZzk6NXZIvC8bEBNnIITlqvdCv/QT8gcZ
X-Google-Smtp-Source: AGHT+IH0qV5PIE7IQgSr9ncZ+irSYxB0iPWF1/4tA5Aw+dQgxNs3xRtqut1t/cxTOkSwhNoh1F6OjQ==
X-Received: by 2002:a05:6e02:1205:b0:3d1:84ad:165e with SMTP id
 e9e14a558f8ab-3d18cd0864emr60357865ab.7.1739589788608; 
 Fri, 14 Feb 2025 19:23:08 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4ed2819d0f5sm1087697173.67.2025.02.14.19.23.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Feb 2025 19:23:05 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>, Heiko Schocher <hs@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 02/29] video: Move vesa_setup_video_priv() into its own file
Date: Fri, 14 Feb 2025 20:22:23 -0700
Message-ID: <20250215032254.4121030-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250215032254.4121030-1-sjg@chromium.org>
References: <20250215032254.4121030-1-sjg@chromium.org>
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

(no changes since v3)

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

