Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CFFC54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:48:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB6E387116;
	Sun, 19 Nov 2023 15:47:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="bvBstoOV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 614F487076; Sun, 19 Nov 2023 15:47:23 +0100 (CET)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4F987124
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:47:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-7a93b7fedc8so165453839f.1
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405228; x=1701010028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+nxNJwkDHfNueIUPzqC5zHnHRGn7cbjtILBbj3xLIdM=;
 b=bvBstoOVG6ivUii54181yntVMOUoasLmpR45t+Ldj9/DrwhuIrHSrVa+cmR5lnoupo
 Dspv3KgIPxR6pwI1PKEGXxkmOb3T86rM0VtGfkq5kCDq2bDYw98S03Ckglb9RRcMoP/T
 MRRnOSBHAWjaQvQjSAw028PnRzG2a8yyrUquk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405228; x=1701010028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+nxNJwkDHfNueIUPzqC5zHnHRGn7cbjtILBbj3xLIdM=;
 b=o8c3+33R76rF4Br5xYgF7JUL0xBnzCncUdTEkHNfrQncUMk6onsN2VC0aibJiUquN1
 h2H84YruA++ENOnoDDLmBxzmD4cREz1DOkmgxjg3jR8iw8PYNVcJL6qX/c8ngXNx3E0/
 uKSeZgoUN230xj1BRbDLz5fHlVy5sXd7CaDku4kGSVvJGLx2JOp6eO+hJZV8/PTaHdcl
 RrpxEQDLmsxde+ql6DwDGBNmTBnEP9mP+nNP2Hz3FwyFhAWt6LLLzEyPj7FStoY0ethj
 GbAZxuamKTizkITniRnTWNd7QtMIUHJzjxOStibuXfjQnJOhR7OkwAcPShgAVVsSMlKS
 uxAg==
X-Gm-Message-State: AOJu0Yw3NfhLfX42vleg3WgV3HtGiG3FeaZPy1o/SE5lI8KprClm9i09
 pdDoIokxqOlTqaCpx/SMFdIZkOLAueKJV8n8lF226Q==
X-Google-Smtp-Source: AGHT+IHiU/2aemqpZkIap0WTg2MdGNFqYKjBVW/Y+yNG6MMH0/q0iqc1OTKiDZQu4fUA9dQT+fNxUA==
X-Received: by 2002:a05:6602:1a86:b0:7a9:4207:289d with SMTP id
 bn6-20020a0566021a8600b007a94207289dmr7686366iob.10.1700405228724; 
 Sun, 19 Nov 2023 06:47:08 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a023946000000b0043194542229sm1450695jae.52.2023.11.19.06.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:47:08 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 3/5] video: Use cyclic to handle video sync
Date: Sun, 19 Nov 2023 07:46:41 -0700
Message-ID: <20231119144700.631322-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144700.631322-1-sjg@chromium.org>
References: <20231119144700.631322-1-sjg@chromium.org>
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

At present U-Boot flushes the cache after every character written to
ths display. This makes the command-line slower, to the point that
pasting in long strings can fail.

Add a cyclic function to sync the display every 10ms. Enable this by
default.

Allow much longer times for sandbox, since the SDL display is quite
slow.

Avoid size growth if the feature is disabled by making the new init and
destroy functions dependent on CYCLIC being enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/Kconfig        | 30 +++++++++++++++++++++++
 drivers/video/video-uclass.c | 46 ++++++++++++++++++++++++++++++++----
 2 files changed, 72 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6f319ba0d544..1742e342f466 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -7,6 +7,7 @@ menu "Graphics support"
 config VIDEO
 	bool "Enable driver model support for LCD/video"
 	depends on DM
+	imply CYCLIC
 	help
 	  This enables driver model for LCD and video devices. These support
 	  a bitmap display of various sizes and depths which can be drawn on
@@ -231,6 +232,35 @@ config NO_FB_CLEAR
 	  loads takes over the screen.  This, for example, can be used to
 	  keep splash image on screen until grub graphical boot menu starts.
 
+config VIDEO_SYNC_MS
+	int "Video-sync period in milliseconds for foreground processing"
+	default 300 if SANDBOX
+	default 100
+	help
+	  This sets the requested, maximum time before a video sync will take
+	  place, in milliseconds. Note that the time between video syncs
+	  may be longer than this, since syncs only happen when the video system
+	  is used, e.g. by outputting a character to the console.
+
+	  It may also be shorter, since the video uclass will automatically
+	  force a sync in certain situations.
+
+	  Many video-output systems require a sync operation before any output
+	  is visible. This may flush the CPU cache or perhaps copy the
+	  display contents to a hardware framebuffer. Without this, change to
+	  the video may never be displayed.
+
+config VIDEO_SYNC_CYCLIC_MS
+	int "Video-sync period in milliseconds for cyclic processing"
+	depends on CYCLIC
+	default 100 if SANDBOX
+	default 10
+	help
+	  This sets the frequency of cyclic video syncs. The cyclic system is
+	  used to ensure that when U-Boot is idle, it syncs the video. This
+	  improves the responsiveness of the command line to new characters
+	  being entered.
+
 config PANEL
 	bool "Enable panel uclass support"
 	default y
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 600e12b802d1..fbed4ce861b4 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -9,6 +9,7 @@
 #include <bloblist.h>
 #include <console.h>
 #include <cpu_func.h>
+#include <cyclic.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
@@ -53,6 +54,8 @@
  */
 DECLARE_GLOBAL_DATA_PTR;
 
+struct cyclic_info;
+
 /**
  * struct video_uc_priv - Information for the video uclass
  *
@@ -61,9 +64,11 @@ DECLARE_GLOBAL_DATA_PTR;
  *	available address to use for a device's framebuffer. It starts at
  *	gd->video_top and works downwards, running out of space when it hits
  *	gd->video_bottom.
+ * @cyc: handle for cyclic-execution function, or NULL if none
  */
 struct video_uc_priv {
 	ulong video_ptr;
+	struct cyclic_info *cyc;
 };
 
 /** struct vid_rgb - Describes a video colour */
@@ -364,6 +369,10 @@ int video_sync(struct udevice *vid, bool force)
 			return ret;
 	}
 
+	if (CONFIG_IS_ENABLED(CYCLIC) && !force &&
+	    get_timer(priv->last_sync) < CONFIG_VIDEO_SYNC_MS)
+		return 0;
+
 	/*
 	 * flush_dcache_range() is declared in common.h but it seems that some
 	 * architectures do not actually implement it. Is there a way to find
@@ -376,11 +385,10 @@ int video_sync(struct udevice *vid, bool force)
 					 CONFIG_SYS_CACHELINE_SIZE));
 	}
 #elif defined(CONFIG_VIDEO_SANDBOX_SDL)
-	if (force || get_timer(priv->last_sync) > 100) {
-		sandbox_sdl_sync(priv->fb);
-		priv->last_sync = get_timer(0);
-	}
+	sandbox_sdl_sync(priv->fb);
 #endif
+	priv->last_sync = get_timer(0);
+
 	return 0;
 }
 
@@ -525,10 +533,16 @@ int video_default_font_height(struct udevice *dev)
 	return vc_priv->y_charsize;
 }
 
+static void video_idle(void *ctx)
+{
+	video_sync_all();
+}
+
 /* Set up the display ready for use */
 static int video_post_probe(struct udevice *dev)
 {
 	struct video_uc_plat *plat = dev_get_uclass_plat(dev);
+	struct video_uc_priv *uc_priv = uclass_get_priv(dev->uclass);
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	char name[30], drv[15], *str;
 	const char *drv_name = drv;
@@ -599,6 +613,17 @@ static int video_post_probe(struct udevice *dev)
 		}
 	}
 
+	/* register cyclic as soon as the first video device is probed */
+	if (CONFIG_IS_ENABLED(CYCLIC) && (gd->flags && GD_FLG_RELOC) &&
+	    !uc_priv->cyc) {
+		uint ms = CONFIG_IF_ENABLED_INT(CYCLIC, VIDEO_SYNC_CYCLIC_MS);
+
+		uc_priv->cyc = cyclic_register(video_idle, ms * 1000,
+					       "video_init", NULL);
+		if (!uc_priv->cyc)
+			return log_msg_ret("cyc", -ENOMEM);
+	}
+
 	return 0;
 };
 
@@ -638,6 +663,18 @@ static int video_post_bind(struct udevice *dev)
 	return 0;
 }
 
+__maybe_unused static int video_destroy(struct uclass *uc)
+{
+	struct video_uc_priv *uc_priv = uclass_get_priv(uc);
+
+	if (uc_priv->cyc) {
+		cyclic_unregister(uc_priv->cyc);
+		uc_priv->cyc = NULL;
+	}
+
+	return 0;
+}
+
 UCLASS_DRIVER(video) = {
 	.id		= UCLASS_VIDEO,
 	.name		= "video",
@@ -647,4 +684,5 @@ UCLASS_DRIVER(video) = {
 	.priv_auto	= sizeof(struct video_uc_priv),
 	.per_device_auto	= sizeof(struct video_priv),
 	.per_device_plat_auto	= sizeof(struct video_uc_plat),
+	CONFIG_IS_ENABLED(CYCLIC, (.destroy = video_destroy, ))
 };
-- 
2.43.0.rc0.421.g78406f8d94-goog

