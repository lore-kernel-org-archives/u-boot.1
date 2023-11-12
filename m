Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31436C4332F
	for <u-boot@archiver.kernel.org>; Sun, 12 Nov 2023 20:04:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78B0C87465;
	Sun, 12 Nov 2023 21:03:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="dO6eYd7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A369F870EE; Sun, 12 Nov 2023 21:03:12 +0100 (CET)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC7C186D62
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 21:03:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3574297c79eso15398565ab.1
 for <u-boot@lists.denx.de>; Sun, 12 Nov 2023 12:03:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1699819380; x=1700424180; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Vv+oHXhVqrnffyxE7LqM15H6Rx8JP62jtp9TEOnXqk=;
 b=dO6eYd7NgOYI/kIHcBvO6W/BqYTt85fJeJWrb127nKKdw2p8tt0avABQ7pUoRm5pPv
 87M7fbDTIgSCUXKWONeki31EHlF2Y+rOf8SwP4R7X8Ba0hLhMHJCmcHL4RuESuclInAM
 +3AlQafe/IWu2rMZs2k1ifAX6iJbQUUG7UVFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699819380; x=1700424180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Vv+oHXhVqrnffyxE7LqM15H6Rx8JP62jtp9TEOnXqk=;
 b=xDxSYSQLOxIYwne6TglNwDC1hpdSiucS4GzzvWTaIpHrk5xdkOdqt4X2GYM8MXlug+
 tlWm03ffLysCuD9okRoQqOKpZc0xE19G/u7uo1fCdVjvABaPhG5wCJJNZYjFM4pR+v8g
 2vCvmGuU3e0/1k0g20p0Ajmdx4Ggl4fdxvuUxLDIlfx2QPAqsyQ50MyzIfjSNC68O/eQ
 nijH2w0IBiTpC1jmybrJtQPaQNgc5wD2+3CqlIHthUmxfeOIAmm44oca/4u8axmGYQIM
 KCE5FmYibzvS/kACXW6GP0Ht1L2g9i9nybCSoBgB1K/CtgRehdTJaZ3k3cF8jh1OrYVQ
 coZg==
X-Gm-Message-State: AOJu0YwsF3eUEuMPAzSR+l4XCLLj8xqjJEQwqKQDoCS1OR6o4TWtkXYX
 etM9BsiG/pKl0cr4F6nZu4bKKD/xjrwPc68v9XKVFQ==
X-Google-Smtp-Source: AGHT+IGT5sJY5kYo3r9gxCEnc4Ukan0dwTZVlF59DHrSbVgRIk2p3PGzttsIU9ypmmZ5KHmdxeRAwQ==
X-Received: by 2002:a05:6e02:1d1e:b0:351:5acb:281 with SMTP id
 i30-20020a056e021d1e00b003515acb0281mr6941514ila.31.1699819380418; 
 Sun, 12 Nov 2023 12:03:00 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 z4-20020a923204000000b0035761b749casm1208256ile.46.2023.11.12.12.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 12:03:00 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Alexander Graf <agraf@csgraf.de>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v4 01/12] efi: Correct handling of frame buffer
Date: Sun, 12 Nov 2023 13:02:38 -0700
Message-ID: <20231112130245.v4.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231112200255.172351-1-sjg@chromium.org>
References: <20231112200255.172351-1-sjg@chromium.org>
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
2.42.0.869.gea05f2083d-goog

