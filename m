Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37975CE7A86
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 21:39:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0CFA986B34;
	Fri, 22 Sep 2023 23:38:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="hV0lS9e/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E2B486501; Fri, 22 Sep 2023 23:38:31 +0200 (CEST)
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com
 [IPv6:2607:f8b0:4864:20::132])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6CBCB8689A
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 23:38:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x132.google.com with SMTP id
 e9e14a558f8ab-34fdfa6af55so8714895ab.3
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 14:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1695418706; x=1696023506; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CThfgHMSx4R38bDnjiNY9XyjvZDk55cKc6tmt6Cmx2U=;
 b=hV0lS9e/2GudhTONesfmUOqUj1OVb9En1yaGCnypCpfhSzp3R177P6T9Rq6p89gpK9
 EQCcWo7HAJvnAeypC7I8JgE0VmBezHtKnviIIYdPUYHDQbHnjvQWHdoRs5S9/c4bmq3U
 ZtIx0eqXErVnWwgSVZsieKorBw6Oocf7Xf3cY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695418706; x=1696023506;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CThfgHMSx4R38bDnjiNY9XyjvZDk55cKc6tmt6Cmx2U=;
 b=svFArcb1+kdIjBwOLLSaGiwFov0/8SGtIonrNHpmdP+cmnq+jdV+CmcrqobGW9ImrO
 woDOtBU+aax+rQFYTK6ELtyj5ArHtD0UThTIj73ZXi4ZociR2zqxRDc0xQNs/ZNlW7iH
 q9HBW3fkV9572JmlTLF8SQmX8pkWpOWjFXwCTp7QuefOkaYuWLldapkMplvXM47zNwmk
 ozef6/Ba+hTO+NqYR+f6L+VLc3oDB3uHV88cwlJU1wlUmXvyWv9MBQT/nihYGFLTGjzF
 25YKpzbz2fSkVwtEWZgkeL7re0ciwAGL/4lSYN0SAQP+leeWrgiezhIXL7ncQkVGFbwh
 L+og==
X-Gm-Message-State: AOJu0YxQf1go3tb7UNwDXH6CqS05buKk8K47MvK/Q5iys1OtReGqjQXk
 ysjk50FpYC92x9P5U2LinA+rze8YLn+lsnuYF88=
X-Google-Smtp-Source: AGHT+IG+dveNMFPhoiu0YdgQIHZc6/gIQneQR20v/BZSCRTWA1KIp0ZzbH8tez+VsEhiEbLzRPsVGA==
X-Received: by 2002:a05:6e02:14d:b0:34f:666e:e116 with SMTP id
 j13-20020a056e02014d00b0034f666ee116mr854904ilr.19.1695418705999; 
 Fri, 22 Sep 2023 14:38:25 -0700 (PDT)
Received: from kea.bld.corp.google.com ([2620:15c:183:200:9fd8:298f:4748:f9a])
 by smtp.gmail.com with ESMTPSA id
 y24-20020a02bb18000000b0042b09bde126sm1221477jan.165.2023.09.22.14.38.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 14:38:25 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: [PATCH v2 1/4] efi: Correct handling of frame buffer
Date: Fri, 22 Sep 2023 15:38:13 -0600
Message-ID: <20230922153814.v2.1.I9f7f373d00947c704aeae0088dfedd8df07fab60@changeid>
X-Mailer: git-send-email 2.42.0.515.g380fc7ccd1-goog
In-Reply-To: <20230922213819.1886094-1-sjg@chromium.org>
References: <20230922213819.1886094-1-sjg@chromium.org>
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
---

Changes in v2:
- Rebase to -next
- Add some more comments to the header file
- Add fixes tag

 include/video.h          |  9 ++++++---
 lib/efi_loader/efi_gop.c | 12 +++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/include/video.h b/include/video.h
index 5048116a3d5..4d8df9baaad 100644
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
2.42.0.515.g380fc7ccd1-goog

