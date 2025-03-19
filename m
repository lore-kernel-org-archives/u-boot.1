Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D9D1C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:55:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39F0A81DCC;
	Wed, 19 Mar 2025 15:55:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="mtEpfPbo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7D98181E76; Wed, 19 Mar 2025 15:55:31 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5F6D881A0E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf0d787eeso48193255e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396128; x=1743000928; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6YbyRgRGIZbHYqo7kqTfLFuOlGgo+1+OfkPr1SpfUPI=;
 b=mtEpfPboU4EBvIqe08IuVI2liWZDiLeIhPGDhc5xqduhCp2CnYtVdXM2o4eJ9CduV2
 WukjJYzs/eCYur1582pzA++VR/dr4sQ9l9F0VzXSxR1CrEm0N68YABENbY8J8VpxMAGt
 28RR7M5iAjVVwjPJqYHkdYasOlpCFu0twnPQk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396128; x=1743000928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6YbyRgRGIZbHYqo7kqTfLFuOlGgo+1+OfkPr1SpfUPI=;
 b=QxFpZJbPBs6gwXTd10eqEzms0vL8zYvjOgvu9OqCYFGLZ3tGlqtdfwX6iD6zZQNDMz
 eaXgQakyNYm7LC4mzaNu44Aqhiryff+lOtxL3JPUkDuO+8Y8BRMdqRYrAeGMSPxSnb/G
 P86z16qkBlutFvrXnN2jHm3o3oIs51F78QKnjy1mTdb+DvLnLksA1MNfae2cBsOUAJqi
 hM4RwpRwHus5WaWZM70xMlprSediiR/K/2vt+BNRgBBT6dOvI91BwZD9U2CvWFcImEFv
 niJk6V7P8x/GKz02Yj5a9IFXiPTT50s4maGVuBRn5H8BwbvxzjN+/p8qTZzRCvKe57Fc
 bEFw==
X-Gm-Message-State: AOJu0YwV9k4vrWk5P1R7dW3xNATCARa+1PTADdJWuySXoYZiprTiqvtf
 TAiIwExGE6ByPP4akNO9wvLYOkBQLJOslmkDkMYztaW9Z24kIbSO4PqU/cBOqysJaOLn3UVU5LY
 =
X-Gm-Gg: ASbGncsB2z/Bo8cQ2JUV85EUHaYAarOBJDLk0bSyVlDx8JfCHY18KrOWGwwfb1r6JLl
 cHIgfmZTx5kADCn8N697IpfUF19cggltkwvo+ht5R5rwUJ/mr5WEYAkx4lvogMoc0wvt3PD+cZ0
 n631iiBtnGncr+gYDRG81NjtgW9MZ1e3MFxmhdYUrJZvOPtkmVJ+Wskf8hPT4CCV4z+jzdBMNo7
 9758rzCoId88m7Xo/oJsXVtgm4jlBErchf8WFYlA2Q4gpjT38n47K6afQ+AthIs0PoeOmo6pNGR
 dmOuqW3AiKiaXPDkEt2HjWhqdISIX5iW+bk+eduK7A==
X-Google-Smtp-Source: AGHT+IGUIVhiTcvOORZubTMv4C5y5XgTThCJDNdZFJSrSkYlIb76WzpDDTJKHNztWIFBZ3SVsGy05A==
X-Received: by 2002:a05:600c:4f86:b0:43c:f81d:f with SMTP id
 5b1f17b1804b1-43d4378b705mr25457545e9.8.1742396128146; 
 Wed, 19 Mar 2025 07:55:28 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:27 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Devarsh Thakkar <devarsht@ti.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 01/52] video: Make white-on-black a video-device property
Date: Wed, 19 Mar 2025 15:54:06 +0100
Message-ID: <20250319145512.2391122-2-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

