Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2843FC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:47:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 598F08288D;
	Fri,  2 May 2025 16:47:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="fVn5ttmY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D7AC88272A; Fri,  2 May 2025 16:47:33 +0200 (CEST)
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com
 [IPv6:2607:f8b0:4864:20::d2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8DDEE82153
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-864a071b44bso67732739f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197250; x=1746802050; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OsWB8RY0e5JeAGcCDhsJbvWTC8g5QSt+plnK7FH53Iw=;
 b=fVn5ttmYFhBmfojxNeBe79msBoDkOvgZmNRr5c5xfw1CGOi1RsRnJW/aNPHHh9AmxI
 y7ZrOwCuHJqcQr8zpImiq7ds12UNU88ED+gkPhRIAQ9Z76svnOvS98QWrbCJgHpIk+iG
 k3xV7zpoT8bxfGUQ433sPGwP9D3ICOsZHo+3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197250; x=1746802050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OsWB8RY0e5JeAGcCDhsJbvWTC8g5QSt+plnK7FH53Iw=;
 b=Q4Lc8dVebUwSXspECVSWHjMPRTSnFB39et4p0DSeyoqxa/SU4nV03I6XbydI3qdkvx
 ZqndgfvAe42zbdqYRb0+hs95C/OuO8COWh3lajiIl3UrQa8vTmWk4p3Zi9gXR3VY0Qpj
 Y8qV/elRgaf276/N1Huh/kbxyExfuEdH/sDga3ab3zz7RYfe+oBG5GMu5v2nK0VBdTUy
 PrAu/b42ycBQl97dRC7yPjrWQFyXc9RSuhxmYE4yrGeIkv5ykoa5UCDIDYSYH0+W4Utl
 hFhw2zoGRboyJwpJLjxMEng4bLR+yfqYB4+N0xsYdSpWEwabYRVRAzgW4sy66RR4ze9o
 E11Q==
X-Gm-Message-State: AOJu0YzzLGows6qrJ3xzLSZFqwE0TkxiRepn1JpgS59LkkwVT9FftbUh
 gOVfLrtDN3Qlx8RrnWCVbugdYU/Hw4zt4Kxv5vlZtdBEsPVn8wpzwHcMJdCOpuC1tfiEYOQ0Y10
 =
X-Gm-Gg: ASbGnct7/YdNvwAAMrHjjDA2hzfH3o5zLjR0wuzQHOJdjnfSHQjjxfImNEsAvnhj1XL
 aTbwIHEv7+zrujmh++IzZtALNgHa8w3RG4haqq4mHF6AJWAj7aHNKxf4k5q95JGADtlRCZNqrJf
 68FkQj6xNtUTLo9TCgSSsK8OaWZLj/kvYJ20AxdIDoCa6FcZ+0hXpOsNTH1pMQweI2Hg4ByWQRp
 JTftPIsAmx7FBN27y7Wn0y9RgCpWX4uPJ8viWydp6RgphWzWntsUUjGkJKsg0zWWbj8GfidRXle
 fZNY3CwcFK6GFZKT8dFOfu4BysTt6xLxYiJdeDgPhmw4qwPVFWSpOmKQOJOuHIuZL9nXP/3pthJ
 BSg==
X-Google-Smtp-Source: AGHT+IFeejdV4mpsg0quQjDYaRChGodavq5Rtc/jLcgvvZ4IyMTXGSH/QwxZTE5zAHvBQIGbv0+gvA==
X-Received: by 2002:a05:6602:3817:b0:85b:b82f:965b with SMTP id
 ca18e2360f4ac-866b42992damr427752239f.12.1746197249767; 
 Fri, 02 May 2025 07:47:29 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:28 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 03/60] video: Make white-on-black a video-device property
Date: Fri,  2 May 2025 08:46:01 -0600
Message-ID: <20250502144718.313633-4-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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
index 9034aeeecf2..3af34369fe8 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -329,8 +329,9 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 	enum colour_idx fore, back;
 	uint inset = theme->menu_inset;
 
+	vid_priv = dev_get_uclass_priv(dev);
 	/* draw a background for the object */
-	if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+	if (vid_priv->white_on_black) {
 		fore = VID_DARK_GREY;
 		back = VID_WHITE;
 	} else {
@@ -343,7 +344,6 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 		return;
 
 	vidconsole_push_colour(cons, fore, back, &old);
-	vid_priv = dev_get_uclass_priv(dev);
 	video_fill_part(dev, label_bbox.x0 - inset, label_bbox.y0 - inset,
 			label_bbox.x1 + inset, label_bbox.y1 + inset,
 			vid_priv->colour_fg);
@@ -407,7 +407,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 			struct vidconsole_colour old;
 			enum colour_idx fore, back;
 
-			if (CONFIG_IS_ENABLED(SYS_WHITE_ON_BLACK)) {
+			vid_priv = dev_get_uclass_priv(dev);
+			if (vid_priv->white_on_black) {
 				fore = VID_BLACK;
 				back = VID_WHITE;
 			} else {
@@ -415,7 +416,6 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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

