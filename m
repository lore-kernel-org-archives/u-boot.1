Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38E85C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:49:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B4D498892A;
	Thu,  4 Jul 2024 09:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ls0LwLVA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7A628888AF; Thu,  4 Jul 2024 09:49:12 +0200 (CEST)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 093A0888E6
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-52db11b1d31so478707e87.0
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 00:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720079349; x=1720684149; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9tesYWNmYUG+aP4B6V54afsBLWjcXmsVzQ5MZVgG/0=;
 b=Ls0LwLVAiljlBIhCoaP1fOU0S0zDv5+SXSZPEWp/VaAM/XTvT5Hs46eYJjakTQOgwE
 Rx3SOL98lc1KG7R8YWzojkisVllCxDj9zUkHsGZP+DfY12+pVFxBMUJ6bVbujb7AIaht
 irr2DZpvg8QjtfcasajDQEHpeG7CKYp6nnrCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079349; x=1720684149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h9tesYWNmYUG+aP4B6V54afsBLWjcXmsVzQ5MZVgG/0=;
 b=t9fzHQp3i1RS6DIyC4eGFaAezShdq2XDYTEVP5XAHMnDAygmnCpPl4FX110Jo/GrJH
 LcWC/a+wGhbG4+YiwUiejx6YHiVV/I2AMT5/PDAz9YbTRvoPlWSfqkpRN55dztHvS5S8
 1ZhDBPJayt/xhrfNaFXcFXSH8sCwEc52me8klDa4ujGfVvYV4aWphCod8ahYOUu8F9iK
 duQB8blcjOIyw0okCbgAzAeU3b+x1GE6rShqx3mRTkR6CJxG6Hn5ZQWM0d7SBhCOdInR
 V/zTELG/xC+2Qkk13vgVGt9Q/fAQLJ7NEOCAgAi/rph34cqOPCMUId81J0jyVDcbODOa
 ExYw==
X-Gm-Message-State: AOJu0YyYxy9464zpWcToo/mEpHuZq7NnZTF/VmDKP1aOMMOoQqDo5A7Z
 pD/nqd6ksnRyrGVwmvU2viZz2RClh54yg+fqCyKlP8JsWB0JUjgeAEdrlGE0Y7bYiYVxcHee+70
 =
X-Google-Smtp-Source: AGHT+IFSyPqEUzKVWebizFTkPYNXeR1HqqmXC872TJ1FlowvND0iPTA2HbHqMLoaic09be14rrRowg==
X-Received: by 2002:ac2:4469:0:b0:52e:9bcc:22c8 with SMTP id
 2adb3069b0e04-52ea06288ddmr497124e87.16.1720079348991; 
 Thu, 04 Jul 2024 00:49:08 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm12885515e9.32.2024.07.04.00.49.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:49:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Anton Bambura <jenneron@protonmail.com>, Bin Meng <bmeng@tinylab.org>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Ondrej Jirman <megi@xff.cz>, Peter Robinson <pbrobinson@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH v3 3/5] video: Use cyclic to handle video sync
Date: Thu,  4 Jul 2024 08:48:57 +0100
Message-Id: <20240704074859.2956745-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704074859.2956745-1-sjg@chromium.org>
References: <20240704074859.2956745-1-sjg@chromium.org>
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

Changes in v3:
- Adapt to new cyclic API

Changes in v2:
- Expand help for CONFIG_VIDEO

 drivers/video/Kconfig        | 35 +++++++++++++++++++++++++++
 drivers/video/video-uclass.c | 46 ++++++++++++++++++++++++++++++++----
 2 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 7808ae7919e..6e79694fd19 100644
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
@@ -232,6 +238,35 @@ config NO_FB_CLEAR
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
index a95b5f199dc..a5aa8dd5295 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -8,6 +8,7 @@
 #include <bloblist.h>
 #include <console.h>
 #include <cpu_func.h>
+#include <cyclic.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
@@ -52,6 +53,8 @@
  */
 DECLARE_GLOBAL_DATA_PTR;
 
+struct cyclic_info;
+
 /**
  * struct video_uc_priv - Information for the video uclass
  *
@@ -60,9 +63,12 @@ DECLARE_GLOBAL_DATA_PTR;
  *	available address to use for a device's framebuffer. It starts at
  *	gd->video_top and works downwards, running out of space when it hits
  *	gd->video_bottom.
+ * @cyc: handle for cyclic-execution function, or NULL if none
  */
 struct video_uc_priv {
 	ulong video_ptr;
+	bool cyc_active;
+	struct cyclic_info cyc;
 };
 
 /** struct vid_rgb - Describes a video colour */
@@ -359,6 +365,10 @@ int video_sync(struct udevice *vid, bool force)
 			return ret;
 	}
 
+	if (CONFIG_IS_ENABLED(CYCLIC) && !force &&
+	    get_timer(priv->last_sync) < CONFIG_VIDEO_SYNC_MS)
+		return 0;
+
 	/*
 	 * flush_dcache_range() is declared in common.h but it seems that some
 	 * architectures do not actually implement it. Is there a way to find
@@ -371,11 +381,10 @@ int video_sync(struct udevice *vid, bool force)
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
 
@@ -524,10 +533,16 @@ int video_default_font_height(struct udevice *dev)
 	return vc_priv->y_charsize;
 }
 
+static void video_idle(struct cyclic_info *cyc)
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
@@ -618,6 +633,16 @@ static int video_post_probe(struct udevice *dev)
 		}
 	}
 
+	/* register cyclic as soon as the first video device is probed */
+	if (CONFIG_IS_ENABLED(CYCLIC) && (gd->flags && GD_FLG_RELOC) &&
+	    !uc_priv->cyc_active) {
+		uint ms = CONFIG_IF_ENABLED_INT(CYCLIC, VIDEO_SYNC_CYCLIC_MS);
+
+		cyclic_register(&uc_priv->cyc, video_idle, ms * 1000,
+				"video_init");
+		uc_priv->cyc_active = true;
+	}
+
 	return 0;
 };
 
@@ -657,6 +682,18 @@ static int video_post_bind(struct udevice *dev)
 	return 0;
 }
 
+__maybe_unused static int video_destroy(struct uclass *uc)
+{
+	struct video_uc_priv *uc_priv = uclass_get_priv(uc);
+
+	if (uc_priv->cyc_active) {
+		cyclic_unregister(&uc_priv->cyc);
+		uc_priv->cyc_active = false;
+	}
+
+	return 0;
+}
+
 UCLASS_DRIVER(video) = {
 	.id		= UCLASS_VIDEO,
 	.name		= "video",
@@ -666,4 +703,5 @@ UCLASS_DRIVER(video) = {
 	.priv_auto	= sizeof(struct video_uc_priv),
 	.per_device_auto	= sizeof(struct video_priv),
 	.per_device_plat_auto	= sizeof(struct video_uc_plat),
+	CONFIG_IS_ENABLED(CYCLIC, (.destroy = video_destroy, ))
 };
-- 
2.34.1

