Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BFBC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:07:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28A1C81DCC;
	Fri, 28 Mar 2025 14:07:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="RvJwz/iV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4640281273; Fri, 28 Mar 2025 14:07:26 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9F9F81951
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85e15dc801aso180866839f.2
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167242; x=1743772042; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaRZLXr5R3yxQzunz3NtNlmS9BXt9mnHXCCA/E4WzbU=;
 b=RvJwz/iVhNPtOykJtPb2C+DOGzfNwjT+ZizDclB3NqhDIpXbz0w4ZiXpFUtQ75fBE+
 nvLBBm/8zNcMYIune6CgnSQoesnhRtGnKPzNUBG+JQCyUhEpzwymonFCfnmfGpnILgHE
 RjiNsCDdkaERE4CzUIRKOOibb58kyovQH7yLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167242; x=1743772042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaRZLXr5R3yxQzunz3NtNlmS9BXt9mnHXCCA/E4WzbU=;
 b=dUbeJDK5ghuOZAaymC1PX66rvxpU/I83muskbsoYUzUezLmx0ixv2lqP3H4H7bg9Bs
 Wud6o4w1lkZR7uHPG4DGyc0eBXXNdphdS7/NKUDUsA/sMIJEI47+I2/n7bQ1sCWFPN3R
 DxbNxBQ8D1vTpSu/F/biifZ69XCI3nRkYamE5ML4ROhClWuIMw4u9xZuQsp/xAMSh7dc
 Z8TejbV2IsbZgu7WGCa6vgtw450mNst1mX1Js+0pug81ESuAgsdKB6gQQ9LaebEBdtSp
 j90rnfOGC1AvL9EgYesRi6vjgeC1E9QN663bB1CWNaMiG4/0YOX0PnW41mQlj5egEVUD
 l4zA==
X-Gm-Message-State: AOJu0YwDO/kSSqJLEcOVYERIXPaZns4VbY55T7GStsMqJK1McxjbhmCV
 G4DP2XLJNTF3IG9gdoCABzd6hk85BEsRyTUWwJ/20oyOTgEiIpf2ywtcs58lYUq3zu9+Pxk32dE
 =
X-Gm-Gg: ASbGnct+ABa6H07x4bd7Itwr/y7gPoGqsWfMudH1C1cj51lSghqnMKzymLdHxuVDElh
 rYbNkmQYvyHjchyxJdRYD5v72Rl26TESrSHmiwgUEx2/bSNmRBrlEnXtaQPJaUhTB8ngFjLLrFZ
 l6+kw9D/boTWcrzECfYRjPc07KPZi1xIIxVBPVMUkACNX6I5J70GuA38REjunkolv9VVLKayfGw
 7uTQ3MR1A369zmuHd/k+KTeGk9U0t7xB+qVV/Vj9PDsr3Au/AkSmmS1h/KXhpdQUJScvOuB+qii
 KoCOFJUZKP3s1bvSgrl7SgNH2hnkwyannikYV1hh2dOD9OCFnd1cvFwunRUmvxUFiigiwBXr2Da
 h9hPSSg==
X-Google-Smtp-Source: AGHT+IFBmL/0PJCzNZske5c2XoD4tF7U73xo4MsyJ+cc+He6G+qH3PtsymawjUVLtGruMf/k8XY+1g==
X-Received: by 2002:a05:6602:2762:b0:85b:4170:e1a1 with SMTP id
 ca18e2360f4ac-85e8216b2f9mr800137639f.13.1743167241947; 
 Fri, 28 Mar 2025 06:07:21 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Nikhil M Jain <n-jain1@ti.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 01/56] video: Make white-on-black a video-device property
Date: Fri, 28 Mar 2025 07:05:48 -0600
Message-ID: <20250328130713.2612648-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

The CONFIG_WHITE_ON_BLACK setting is hard-coded at build-time. It is
useful to be able to control this when showing menus.

Create a property to hold this information, using the CONFIG as the
initial value.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/expo.c                  |  2 +-
 boot/scene.c                 |  8 ++++----
 drivers/video/video-uclass.c | 16 +++++++++++++++-
 include/video.h              | 12 ++++++++++++
 4 files changed, 32 insertions(+), 6 deletions(-)

diff --git a/boot/expo.c b/boot/expo.c
index 786f665f53c..8ce645e5a8f 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -194,7 +194,7 @@ int expo_render(struct expo *exp)
 	u32 colour;
 	int ret;
 
-	back = CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK) ? VID_BLACK : VID_WHITE;
+	back = vid_priv->white_on_black ? VID_BLACK : VID_WHITE;
 	colour = video_index_to_colour(vid_priv, back);
 	ret = video_fill(dev, colour);
 	if (ret)
diff --git a/boot/scene.c b/boot/scene.c
index 3290a40222a..15e7a8b3387 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -330,8 +330,9 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 	enum colour_idx fore, back;
 	uint inset = theme->menu_inset;
 
+	vid_priv = dev_get_uclass_priv(dev);
 	/* draw a background for the object */
-	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+	if (vid_priv->white_on_black) {
 		fore = VID_DARK_GREY;
 		back = VID_WHITE;
 	} else {
@@ -344,7 +345,6 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 		return;
 
 	vidconsole_push_colour(cons, fore, back, &old);
-	vid_priv = dev_get_uclass_priv(dev);
 	video_fill_part(dev, label_bbox.x0 - inset, label_bbox.y0 - inset,
 			label_bbox.x1 + inset, label_bbox.y1 + inset,
 			vid_priv->colour_fg);
@@ -408,7 +408,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 			struct vidconsole_colour old;
 			enum colour_idx fore, back;
 
-			if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+			vid_priv = dev_get_uclass_priv(dev);
+			if (vid_priv->white_on_black) {
 				fore = VID_BLACK;
 				back = VID_WHITE;
 			} else {
@@ -416,7 +417,6 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 				back = VID_BLACK;
 			}
 
-			vid_priv = dev_get_uclass_priv(dev);
 			if (obj->flags & SCENEOF_POINT) {
 				vidconsole_push_colour(cons, fore, back, &old);
 				video_fill_part(dev, x - theme->menu_inset, y,
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 1e385f12f8e..db40744c196 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -343,7 +343,7 @@ void video_set_default_colors(struct udevice *dev, bool invert)
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	int fore, back;
 
-	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+	if (priv->white_on_black) {
 		/* White is used when switching to bold, use light gray here */
 		fore = VID_LIGHT_GRAY;
 		back = VID_BLACK;
@@ -580,6 +580,18 @@ static void video_idle(struct cyclic_info *cyc)
 	video_sync_all();
 }
 
+void video_set_white_on_black(struct udevice *dev, bool white_on_black)
+{
+	struct video_priv *priv = dev_get_uclass_priv(dev);
+
+	if (priv->white_on_black != white_on_black) {
+		priv->white_on_black = white_on_black;
+		video_set_default_colors(dev, false);
+
+		video_clear(dev);
+	}
+}
+
 /* Set up the display ready for use */
 static int video_post_probe(struct udevice *dev)
 {
@@ -622,6 +634,8 @@ static int video_post_probe(struct udevice *dev)
 	if (IS_ENABLED(CONFIG_VIDEO_COPY) && plat->copy_base)
 		priv->copy_fb = map_sysmem(plat->copy_base, plat->size);
 
+	priv->white_on_black = CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK);
+
 	/* Set up colors  */
 	video_set_default_colors(dev, false);
 
diff --git a/include/video.h b/include/video.h
index 2fe2f73a865..0ec6b1ca289 100644
--- a/include/video.h
+++ b/include/video.h
@@ -100,6 +100,7 @@ enum video_format {
  * @fg_col_idx:	Foreground color code (bit 3 = bold, bit 0-2 = color)
  * @bg_col_idx:	Background color code (bit 3 = bold, bit 0-2 = color)
  * @last_sync:	Monotonic time of last video sync
+ * @white_on_black: Use a black background
  */
 struct video_priv {
 	/* Things set up by the driver: */
@@ -131,6 +132,7 @@ struct video_priv {
 	u8 fg_col_idx;
 	u8 bg_col_idx;
 	ulong last_sync;
+	bool white_on_black;
 };
 
 /**
@@ -346,6 +348,16 @@ void video_set_flush_dcache(struct udevice *dev, bool flush);
  */
 void video_set_default_colors(struct udevice *dev, bool invert);
 
+/**
+ * video_set_white_on_black() - Change the setting for white-on-black
+ *
+ * This does nothing if the setting is already the same.
+ *
+ * @dev: video device
+ * @white_on_black: true to use white-on-black, false for black-on-white
+ */
+void video_set_white_on_black(struct udevice *dev, bool white_on_black);
+
 /**
  * video_default_font_height() - Get the default font height
  *
-- 
2.43.0

