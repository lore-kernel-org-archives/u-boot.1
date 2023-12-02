Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A30A1C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 15:35:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B6231876A7;
	Sat,  2 Dec 2023 16:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oUvnTFDC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8363587651; Sat,  2 Dec 2023 16:34:28 +0100 (CET)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com
 [IPv6:2607:f8b0:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9ED558767B
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 16:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-6ce3efb78e2so131705b3a.1
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 07:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701531264; x=1702136064; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t0z0yGkFG/ZGzAuEizTIBqAq9a+WLUT0E0FsJ+lzVus=;
 b=oUvnTFDCByF+l2Flq0ElOuCWYn20WFX6xcLJnvRQ3OqgeJrgLJNQ6UmyIc4nSqZpui
 cnWWumJAqRn3teCGKghHMxfY+2TCcFPWexuJ9Mmvgd+EjFAxU/00eBlZK1v86Ct9K4Ie
 q5NSyDrD5DDs0bLWgOlIGWIrFXZ45d6w/HX7w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701531264; x=1702136064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=t0z0yGkFG/ZGzAuEizTIBqAq9a+WLUT0E0FsJ+lzVus=;
 b=LNtCrvX/GpBi9dr4JU1rUMTKIZ/2LMzVVhUZDOKS6D0qAEPUS6sr2S7P0CLz/AsjmI
 gylBOCaLZLS6rk1yyOhw0UNUXlq0Z2PjuFfDR4Z+4CTwyFJuRboZYpbqFWJDHATzNZNx
 9zygbRcSguMwo/g1NRzKp1ZuYnGjH6M+pSdjbp/OsrFnAB6q1mk2jtRaEGRrHH2DwgaG
 rpnIfeFRbdSD7ujYn36HqMP800pesOqEgJe4EWHUWurjWbmRPKBwa98ElVmJF+RxiqZx
 3kPqudBNaGMRvgqZKD84JjSEXkiIFGRUxrfkKbz/mjb4SCDGkh9ij0mfiGhlm0je18A9
 fiOA==
X-Gm-Message-State: AOJu0YxuaebaFCgMHWSn6dhwPBQ05ZB3Ov8MKAy+MKoBMqnkE0n1NeLS
 WXAH0Uvu13pUcaufGoX5zvUc25J2TMlaqIumtUU8Gg==
X-Google-Smtp-Source: AGHT+IG3A3IWdK2sazAjbp9+qNqBLusZW1+//0ZMyeUNFWlAEyAPCvuQIyKvKFglEu/6k1lj8ohYUQ==
X-Received: by 2002:a17:902:8346:b0:1d0:6ffe:a15 with SMTP id
 z6-20020a170902834600b001d06ffe0a15mr1133683pln.115.1701531263717; 
 Sat, 02 Dec 2023 07:34:23 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d30500b001cf8546335fsm2869217plc.5.2023.12.02.07.34.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 07:34:23 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 3/5] video: Use cyclic to handle video sync
Date: Sat,  2 Dec 2023 08:33:50 -0700
Message-ID: <20231202153400.537050-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231202153400.537050-1-sjg@chromium.org>
References: <20231202153400.537050-1-sjg@chromium.org>
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

Changes in v2:
- Expand help for CONFIG_VIDEO

 drivers/video/Kconfig        | 35 +++++++++++++++++++++++++++
 drivers/video/video-uclass.c | 46 ++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 6f319ba0d544..ccbfcbcfd824 100644
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
@@ -14,6 +15,11 @@ config VIDEO
 	  option compiles in the video uclass and routes all LCD/video access
 	  through this.
 
+	  If CYCLIC is enabled (which it is by default), the cyclic subsystem
+	  is used to flush pending output to the display periodically, rather
+	  than this happening with every chunk of output. This allows for more
+	  efficient operation and faster display output.
+
 if VIDEO
 
 config VIDEO_FONT_4X6
@@ -231,6 +237,35 @@ config NO_FB_CLEAR
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
2.43.0.rc2.451.g8631bc7472-goog

