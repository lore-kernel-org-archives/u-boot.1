Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917F3C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 17:43:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0CCC80243;
	Mon,  3 Feb 2025 18:43:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hGS8xrcq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EECA080285; Mon,  3 Feb 2025 18:43:16 +0100 (CET)
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CA87800B3
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 18:43:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-3ebc678b5c9so2579923b6e.3
 for <u-boot@lists.denx.de>; Mon, 03 Feb 2025 09:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1738604592; x=1739209392; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DE8vwcxYzUBdEK+hMoI13Dm96MggmXJKKx3mHBkcIJw=;
 b=hGS8xrcqQeLM62R3hQ6BumIC9tOwv7DgFFzdgrmdlXy0+7zjRwuDd7TkNRSXWgtfz9
 efWJ/xkqlaRSNv6sh+WLpc1z18B7FYhf8UX38zmnasqnBr2cV3W/1RjiI7fIs5/DeGPs
 Cvb2AoYZAdxMQjTdzsgoS46s5XGvbCKTLlOgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738604592; x=1739209392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DE8vwcxYzUBdEK+hMoI13Dm96MggmXJKKx3mHBkcIJw=;
 b=RA9SVp9ThicJnKuC1ozjhFmuvS5eLG0avQO7zRrpQERS1ySi8Mp+qr9ZCbtEF4vpOI
 gaeh89/x7OzU54qtFSRaxvFwErzTZ3DDbAUNU1NcwLPVf/mIXsC788dUYD4soPlsdHpo
 ABqkTAaVnsizoQlJY+V+hbA5y5ktlLE2SeKODgh6AhCt3V8kEuuYafliCX8NTILcLVlH
 ToZJkLgBuuijYTDs/FqnBpGQUqF3aeUWgA2uwOyVtqMA4oSB05DH/u9pkSn51CowI3Lq
 KvhaSvV7eWBqd5bJr66yeUjnP96q6kY/elHCTlTsoydewx558urqAS30vGi/8veq5tHp
 2X3w==
X-Gm-Message-State: AOJu0Yyi7EFykmqDNNVb9SZzyE24dZFscpvFjLoN40TKVjxetNEmQZ91
 7vb52ijTRPIyrW+ZJ3ToGvznKbKNR1i1EuTSQ0+9yvNKEXbhOjvSkpziFTKke22auhYThMu4hIM
 =
X-Gm-Gg: ASbGncvn/5KRO8ofQh7ll96LoEg068cE9pMVbPNq7XdF8bKsVsTBphTf/lzGnNFgu+n
 M5MARLQPtb6kcxvuesJISApSj4MWzK6ZLJJ5udImuXXMWJjOkEenOyoE1s/bfrE85qyu740ZM3T
 xi+rJ4g4QmFrfO8ZDN+crZ4AOHknx7GMZpvMcgR9IGBEozJEuAuPwcQOXfJgZ9fYovgwvMznOuQ
 y/mMh51Ht5Y3Xnm6HOfjSmO9zya4TPajjJCknrc9+LCcxMB9HZfioBn+hlcdO0mdS/TNhZGLEWq
 37GxpqNZby1HFEjhqSVhyH9Pq0U/NvKY1eBD8MVHqG7ZszYn12xR
X-Google-Smtp-Source: AGHT+IGX/Fb4G+zJ4TrlGJ8ps//4oB0P707DreVogW/z+/sPich2Wu6nFpzH4XX0d85NOrct3H2MbQ==
X-Received: by 2002:a05:6808:2199:b0:3eb:5562:34ba with SMTP id
 5614622812f47-3f323b67636mr11884718b6e.25.1738604592470; 
 Mon, 03 Feb 2025 09:43:12 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3f333558c89sm2564203b6e.24.2025.02.03.09.43.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 09:43:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Anton Bambura <jenneron@protonmail.com>, Heiko Schocher <hs@denx.de>,
 =?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 03/32] video: Move vesa_setup_video_priv() into its own file
Date: Mon,  3 Feb 2025 10:41:56 -0700
Message-ID: <20250203174245.1331464-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250203174245.1331464-1-sjg@chromium.org>
References: <20250203174245.1331464-1-sjg@chromium.org>
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

