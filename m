Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DA55C072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 19:12:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C3B56871ED;
	Sun, 19 Nov 2023 20:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JfF4vg11";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC8FB86EE2; Sun, 19 Nov 2023 20:12:15 +0100 (CET)
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com
 [IPv6:2607:f8b0:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 722D483414
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 20:12:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12b.google.com with SMTP id
 e9e14a558f8ab-3574f99d236so14023665ab.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 11:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700421132; x=1701025932; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yQks5KhT/4xqvadIm2Fk0hRL5uWtvQ5W4KSqSv7KXEs=;
 b=JfF4vg11y9DV7OQfBZdIg9XrIv3eQx8CG2fa6K1bUQ9i8ZTwY93nh6BTquEh4ivs5H
 kUW9XyBdZUrxv0Gx1ImDuiAdVg9XJycAN5OIx7E8OJZXP7c8OAhv+1ydsGTrrvoJJpvV
 9dZK8SQY6u95oQa91hYa0de3qLSDCHmO4g2EA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700421132; x=1701025932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yQks5KhT/4xqvadIm2Fk0hRL5uWtvQ5W4KSqSv7KXEs=;
 b=ws1Wpu/C7cEGGBzhvSxq5fQPjSEWyBzZWtp6gXMRF1V3D5UJvezDk7aRAAZBtJeRSw
 ifoV7g2t+E0IIz4iG5d+UD84nn9ZZfnKprGE0M14fJsuF0xF1iVgBweeYmzDRuRa92/x
 eF2yLLgi3SZO49LN1KMIi57JKJUOs4WKJvrbEY0JrhxyzszTy5doCZhwicvdWCKz8EMq
 TTMwXZDpMeaRsi7QqLsJuwbVYnh4wishdMLhUSa2qeEGL4RVjYTucD/H8G7jYms6w5SR
 8cnc93qw16nhKafjq8eAR9Mp2V2i95y0cnVxcZDb9Syk+AKHY++pj7LG4vNzGJsBjREz
 E0hQ==
X-Gm-Message-State: AOJu0YyrssHXlXOQKccWUyNZoJq5qbOaYxycKJMbuvkWnMU6zdYLd5y6
 kRDdhnSUqzId701HTzJH/x6kylDis+mnDjLBCwKoYA==
X-Google-Smtp-Source: AGHT+IHP1d/pfWmZ/olzyeOSz6pvjhX9cQ3JpKFcM/t1uE6AF+b7NKeBojQGBg0Rb6F66OhdKcGUXg==
X-Received: by 2002:a92:c26d:0:b0:35b:695:c3c8 with SMTP id
 h13-20020a92c26d000000b0035b0695c3c8mr257582ild.9.1700421132038; 
 Sun, 19 Nov 2023 11:12:12 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 q17-20020a920511000000b0035ab2c7016bsm1951032ile.50.2023.11.19.11.12.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 11:12:11 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v5 01/12] efi: Correct handling of frame buffer
Date: Sun, 19 Nov 2023 12:11:36 -0700
Message-ID: <20231119121144.v5.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119191202.667180-1-sjg@chromium.org>
References: <20231119191202.667180-1-sjg@chromium.org>
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

The efi_gop driver uses private fields from the video uclass to obtain a
pointer to the frame buffer. Use the platform data instead.

Check the VIDEO_COPY setting to determine which frame buffer to use. Once
the next stage is running (and making use of U-Boot's EFI boot services)
U-Boot does not handle copying from priv->fb to the hardware framebuffer,
so we must allow EFI to write directly to the hardware framebuffer.

We could provide a function to read this, but it seems better to just
document how it works. The original change ignored an explicit comment
in the video.h file ("Things that are private to the uclass: don't use
these in the driver") which is why this was missed when the VIDEO_COPY
feature was added.

Signed-off-by: Simon Glass <sjg@chromium.org>
Fixes: 8f661a5b662 ("efi_loader: gop: Expose fb when 32bpp")
Reviewed-by: Bin Meng <bmeng.cn@gmail.com>
---

(no changes since v2)

Changes in v2:
- Rebase to -next
- Add some more comments to the header file
- Add fixes tag

 include/video.h          |  9 ++++++---
 lib/efi_loader/efi_gop.c | 12 +++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/video.h b/include/video.h
index 5048116a3d57..4d8df9baaada 100644
--- a/include/video.h
+++ b/include/video.h
@@ -21,9 +21,12 @@ struct udevice;
  * @align: Frame-buffer alignment, indicating the memory boundary the frame
  *	buffer should start on. If 0, 1MB is assumed
  * @size: Frame-buffer size, in bytes
- * @base: Base address of frame buffer, 0 if not yet known
- * @copy_base: Base address of a hardware copy of the frame buffer. See
- *	CONFIG_VIDEO_COPY.
+ * @base: Base address of frame buffer, 0 if not yet known. If CONFIG_VIDEO_COPY
+ *	is enabled, this is the software copy, so writes to this will not be
+ *	visible until vidconsole_sync_copy() is called. If CONFIG_VIDEO_COPY is
+ *	disabled, this is the hardware framebuffer.
+ * @copy_base: Base address of a hardware copy of the frame buffer. If
+ *	CONFIG_VIDEO_COPY is disabled, this is not used.
  * @copy_size: Size of copy framebuffer, used if @size is 0
  * @hide_logo: Hide the logo (used for testing)
  */
diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 778b693f983a..a09db31eb465 100644
--- a/lib/efi_loader/efi_gop.c
+++ b/lib/efi_loader/efi_gop.c
@@ -10,6 +10,7 @@
 #include <efi_loader.h>
 #include <log.h>
 #include <malloc.h>
+#include <mapmem.h>
 #include <video.h>
 #include <asm/global_data.h>
 
@@ -467,10 +468,10 @@ efi_status_t efi_gop_register(void)
 	struct efi_gop_obj *gopobj;
 	u32 bpix, format, col, row;
 	u64 fb_base, fb_size;
-	void *fb;
 	efi_status_t ret;
 	struct udevice *vdev;
 	struct video_priv *priv;
+	struct video_uc_plat *plat;
 
 	/* We only support a single video output device for now */
 	if (uclass_first_device_err(UCLASS_VIDEO, &vdev)) {
@@ -483,9 +484,10 @@ efi_status_t efi_gop_register(void)
 	format = priv->format;
 	col = video_get_xsize(vdev);
 	row = video_get_ysize(vdev);
-	fb_base = (uintptr_t)priv->fb;
-	fb_size = priv->fb_size;
-	fb = priv->fb;
+
+	plat = dev_get_uclass_plat(vdev);
+	fb_base = IS_ENABLED(CONFIG_VIDEO_COPY) ? plat->copy_base : plat->base;
+	fb_size = plat->size;
 
 	switch (bpix) {
 	case VIDEO_BPP16:
@@ -547,7 +549,7 @@ efi_status_t efi_gop_register(void)
 	}
 	gopobj->info.pixels_per_scanline = col;
 	gopobj->bpix = bpix;
-	gopobj->fb = fb;
+	gopobj->fb = map_sysmem(fb_base, fb_size);
 
 	return EFI_SUCCESS;
 }
-- 
2.43.0.rc0.421.g78406f8d94-goog

