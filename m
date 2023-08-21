Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D25C3EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6CE308705F;
	Mon, 21 Aug 2023 20:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hEbjbNpc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F0AC8707C; Mon, 21 Aug 2023 20:13:58 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8AC5E8700F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so3297771f8f.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692641635; x=1693246435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E9PD0IEAv+I/k7btdDOBwttUa6zTCBandZoPoxHEZgQ=;
 b=hEbjbNpckDyQ+zuLLJ7yP0llE7JpIjeAEBP1LgTetc4gOz1d5vy1rXBE0Zek5jeWQ8
 vQ82AHIikqZ6dD+RHIdFNvxZrdQHhcz1MqRNEZRyEpdXK4Dj7GALVuNQMNgnB9uyhCqM
 njuNvkbpIPIF2mzwIm/OB8QmZD/j5BQzRxvJ7FRaYib5gWKYV7vp6v/E2V2O4N6/h7q4
 6HB0Sa2+dVRPr5cwCK23w5R+7u6ozeCDiDPVOonqnskYritYVZ2NUw8tS2tamldxaiqh
 P44AOiYLqRPhHta9VmYvLzBzY28/7RPjzJa8AKHUF/7BDdxHh6B5UPzdh+Wx/biHOldW
 tJqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692641635; x=1693246435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E9PD0IEAv+I/k7btdDOBwttUa6zTCBandZoPoxHEZgQ=;
 b=JQYAyFI9oOFHGn5eZoKp7mElsYzJUyaov+DMG/symtU5wsl2cIGnR2AY++ZTsx8arj
 S5tFNv/WdTOvg8O27d1MXHgE67kOe4/8sakPz+At7ozl2wfjQ+Fhj9z1XE+JQdSUuVVF
 PSLLFT7q7387VjeanseJmIxiZwUQB6tJwf7OrGNuOnzXSNLa6LWhjny+ITwak7EAqjw6
 8jdh6RiZJFrQGi+gyU1p4ZO7LWxQDTMQbDCvDVHlAvoAFfxl/7v7lu9CgIcjcG19TLtE
 fv79vQL8JH8iCxysBpGMjfFsxgqNaoLb2LwjBGpQ36MIfva1oPK9+ZMXumBA18vgZPpT
 t20g==
X-Gm-Message-State: AOJu0YzyLU/QJuU/wYMB+tXeyn/zWd8W8p2D8CZ+JrWvNiW3HGATakxA
 zrQvJxVwdILUgNRVXgI0Fm4Mh07G+eM=
X-Google-Smtp-Source: AGHT+IGqw7QLkiKYydDmZG7mXzaV84Nue32NQqx/rhgky7LElF8NIjbj2WQCSKy5WnfZefd+dedMWA==
X-Received: by 2002:adf:f8c5:0:b0:31a:d54c:f002 with SMTP id
 f5-20020adff8c5000000b0031ad54cf002mr5182448wrq.19.1692641635004; 
 Mon, 21 Aug 2023 11:13:55 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm13192025wrh.44.2023.08.21.11.13.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:13:54 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH 4/5] sandbox: video: Move sandbox video sync to a driver
 operation
Date: Mon, 21 Aug 2023 21:13:38 +0300
Message-Id: <20230821181339.4135800-5-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
References: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
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

The sandbox SDL video sync is handled in the uclass because there has
been a sync rate limiter and a way to bypass that. Previous patches
move the rate limit code into SDL-specific files, and provide a generic
way to defer and force video syncs.

Sandbox code shouldn't be in the uclasses if possible. Move the
remaining sandbox sync call into the driver ops. Now that sandbox video
sync attempts can defer without resetting video damage, force a video
sync before checking that video syncs reset video damage.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 drivers/video/sandbox_sdl.c  | 16 ++++++++++++++++
 drivers/video/video-uclass.c | 14 --------------
 test/dm/video.c              |  2 +-
 3 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/video/sandbox_sdl.c b/drivers/video/sandbox_sdl.c
index 9081c7da62e4..7dc2787a5d25 100644
--- a/drivers/video/sandbox_sdl.c
+++ b/drivers/video/sandbox_sdl.c
@@ -99,6 +99,17 @@ int sandbox_sdl_set_bpp(struct udevice *dev, enum video_log2_bpp l2bpp)
 	return 0;
 }
 
+static int sandbox_sdl_video_sync(struct udevice *dev)
+{
+	struct video_priv *priv = dev_get_uclass_priv(dev);
+	void *fb = priv->fb;
+
+	if (IS_ENABLED(CONFIG_VIDEO_COPY))
+		fb = priv->copy_fb;
+
+	return sandbox_sdl_sync(fb);
+}
+
 static int sandbox_sdl_remove(struct udevice *dev)
 {
 	/*
@@ -133,6 +144,10 @@ static const struct udevice_id sandbox_sdl_ids[] = {
 	{ }
 };
 
+static struct video_ops sandbox_sdl_ops = {
+	.video_sync = sandbox_sdl_video_sync,
+};
+
 U_BOOT_DRIVER(sandbox_lcd_sdl) = {
 	.name	= "sandbox_lcd_sdl",
 	.id	= UCLASS_VIDEO,
@@ -141,4 +156,5 @@ U_BOOT_DRIVER(sandbox_lcd_sdl) = {
 	.probe	= sandbox_sdl_probe,
 	.remove	= sandbox_sdl_remove,
 	.plat_auto	= sizeof(struct sandbox_sdl_plat),
+	.ops	= &sandbox_sdl_ops,
 };
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index d867185da539..2632216c05ae 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -23,9 +23,6 @@
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
 #include <dm/uclass-internal.h>
-#ifdef CONFIG_SANDBOX
-#include <asm/sdl.h>
-#endif
 
 /*
  * Theory of operation:
@@ -454,17 +451,6 @@ int video_sync(struct udevice *vid, bool force)
 
 	video_flush_dcache(vid);
 
-#if defined(CONFIG_VIDEO_SANDBOX_SDL)
-	void *fb = priv->fb;
-
-	if (IS_ENABLED(CONFIG_VIDEO_COPY))
-		fb = priv->copy_fb;
-
-	ret = sandbox_sdl_sync(fb);
-	while (force && ret == -EAGAIN)
-		ret = sandbox_sdl_sync(fb);
-#endif
-
 	if (IS_ENABLED(CONFIG_VIDEO_DAMAGE)) {
 		priv->damage.xstart = priv->xsize;
 		priv->damage.ystart = priv->ysize;
diff --git a/test/dm/video.c b/test/dm/video.c
index 4c3bcd26e94f..487e4d4a73a2 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -756,7 +756,7 @@ static int dm_test_video_damage(struct unit_test_state *uts)
 	ut_asserteq(1280, priv->damage.xend);
 	ut_asserteq(510, priv->damage.yend);
 
-	video_sync(dev, false);
+	video_sync(dev, true);
 	ut_asserteq(priv->xsize, priv->damage.xstart);
 	ut_asserteq(priv->ysize, priv->damage.ystart);
 	ut_asserteq(0, priv->damage.xend);
-- 
2.40.1

