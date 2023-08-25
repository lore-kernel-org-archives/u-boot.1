Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AE2C3DA66
	for <u-boot@archiver.kernel.org>; Fri, 25 Aug 2023 19:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E0BFB86ADF;
	Fri, 25 Aug 2023 21:29:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="kkn4oi8n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 322B186AE0; Fri, 25 Aug 2023 21:29:19 +0200 (CEST)
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com
 [IPv6:2607:f8b0:4864:20::136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1158686AB5
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 21:29:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-34bb72ffb1fso4346945ab.3
 for <u-boot@lists.denx.de>; Fri, 25 Aug 2023 12:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1692991754; x=1693596554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=L7UJFEKDE61sofQr3+8LszhbWc2sK6qzYWOjOjNabPI=;
 b=kkn4oi8nZJbZJNQuS4HDCHKAaLj3JxEJOqL0e7WKyztUG1KRCFNdihkF9hI11wq6+r
 lRcogN2lFnUl/mS+P8Dc+ijztFa5wJDYy4B8L3QxvBYFpwfZ4YQeUQ42pxe3kM2aKMl5
 SxO6BMF30XCod3035v5s4zFlYL3KxbBa/sa2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692991754; x=1693596554;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=L7UJFEKDE61sofQr3+8LszhbWc2sK6qzYWOjOjNabPI=;
 b=DsI0X50LkjFjGfMljJXzy2265MzKZiWAvM6rZYFMzmbNE7mcrSCqyLnsNzv3zwCHWC
 G8su/FD9ZQUkvUEGxUph8xdCEsbhtNcsJvbtgd5lo6Zz69WJ1MBTHq9cq5j/S0GnK9+c
 6AofaRcoikCkc0SFSaXGL8TFiKS1pxE14EfRj2YLQDz6HNlF0mxoDM/dyciA0CDsAzJ3
 EuXBEUA6QWpohQEJq0gSx4Cje1yJ6QY03IbHY0HBg10s92Uvk+CISUY0p4tNbjJgjm1P
 zjobxb+UDys0ZbLSVnBP0HJB7yDmceUP8+iiFAopmdrVuAEjiLRfkBgeK9NKDSRvLYFx
 2BVg==
X-Gm-Message-State: AOJu0YwBjJ0jXbBGAejRbGpicGZTiQYWpeuDHrekhBydOJCIV98R5bYZ
 DP6HBggzXMFphkB9G07o6zaQ56wp9g9LEhFwd6Y=
X-Google-Smtp-Source: AGHT+IEt1zYAbz38ZlYAvOMWaxze/RxCVUpYoDbM1JxR9zhG7vVLGqXd4ZX1osPtKaL2mSOvT4RtiA==
X-Received: by 2002:a05:6e02:eee:b0:349:8dfa:ad64 with SMTP id
 j14-20020a056e020eee00b003498dfaad64mr9232208ilk.15.1692991754544; 
 Fri, 25 Aug 2023 12:29:14 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:c714:5300:ea2e:17d4])
 by smtp.gmail.com with ESMTPSA id
 t9-20020a92c0c9000000b0034cc253a78esm710154ilf.51.2023.08.25.12.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 12:29:14 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH] efi: Correct handling of frame buffer
Date: Fri, 25 Aug 2023 13:28:39 -0600
Message-ID: <20230825192842.1957055-1-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
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

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 lib/efi_loader/efi_gop.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/efi_loader/efi_gop.c b/lib/efi_loader/efi_gop.c
index 778b693f983..a09db31eb46 100644
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
2.42.0.rc1.204.g551eb34607-goog

