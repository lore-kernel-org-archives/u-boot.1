Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51AECC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:02:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7E17D82145;
	Wed, 19 Mar 2025 15:56:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jk2Z4kxj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF9E982145; Wed, 19 Mar 2025 15:56:41 +0100 (CET)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C14181E06
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-390e3b3d3f4so4289123f8f.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396198; x=1743000998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SpU6BMDfq9jqKOD556cMiT8/gG8k1PtbCv9uy06LJ7U=;
 b=jk2Z4kxjoHG7zahZbca20Xa3FBXZsmrlcWsBw9GLZbd/Yz+dHSTB/+pba3P6IzkL9C
 qICk5Zr2Xdsa7XMiNM2OP+fvgQwsGhW4tFxBQHmJXc4SOrG+kHm5Rw6bzHkDQ6QV54vs
 jr9wENw32Gkf15QhLAH3AjWWlpsXOxea9DoeE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396198; x=1743000998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SpU6BMDfq9jqKOD556cMiT8/gG8k1PtbCv9uy06LJ7U=;
 b=HQEJrOVMnCtV2Bvh7oVunaiBu5Y5v0YH3gGPP+YhGVZkIy9UZTeFni/6hbYqPaURjZ
 sqYeIx64c3nAAv25h7h1OutzmOK51AKZtCIKCa6gjvLE3PDsUxfLftU4tFWRq9B8Qm2/
 vE5z//EYpvkj0SIeZl+A/fOGTJrJTjIAWrOFWHYLTURXEn4F1QnM6pTeeGnQvdUo+mHJ
 VUIzTk0XNgTTP8fZBY0R/8TPQZBrHz64/mRYHOlS8CQDz77PL5oGSSPXzctp08rY2RBy
 qVf1LV/w0jX7Sdi3P0SBnV/siUV/lj1fbL2RrRjMJ/QGtQOHrsMFiDZQuhU1kYI5tiaf
 LuQw==
X-Gm-Message-State: AOJu0Ywx+uW9gFBKVmRyztgXIBri3r4KQNSCagM+AbW0tadv7DuEjmvn
 zWUtxqCKOsisGCLFhBMwxz3z2PNMAWWQw2590J9G61SJHaLjlEDIl8vvKGJfFBi4ie1cnpeMCHI
 =
X-Gm-Gg: ASbGncscmBLgmbhTavBjzQ+7VQGBcRZweCUZpXkFokFS7PIlaOUdWopDvcoDh4W9AOb
 CQSDwzIGMV1ETc9D8IMZ+hCnsE438IWJKGoFqEgwbDiMvo2FK/IcxRzEon07WRHz4XDRhM1KREY
 4lPvJeeUOv+t/hGUO03iCVa+8HyLQcFrfmMkGWa2zpExz/Bcpzfw9s5ePWOX5S278a1tHA5foEm
 GxI8z4hWxh96LCKAy4mmyg2BZOqXrTLkFtu3JFj0vVQieqOO4+wcdoONGmHvushLvbTZfqzk4l+
 yftGAz46bj21yJHNlUqBKU6CLfOhi/YkW/wW7JLAZ0aG0H+M8v7F
X-Google-Smtp-Source: AGHT+IHXAoyxs9OOdQjTp2haZzdNB/hsAvH4wcg4u18JWnmsKqEt44xymJv5AjM2V0Ljo3zOoeEM3A==
X-Received: by 2002:a5d:598e:0:b0:38f:2ffc:1e99 with SMTP id
 ffacd0b85a97d-39973b437a3mr2649548f8f.49.1742396198256; 
 Wed, 19 Mar 2025 07:56:38 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:37 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 38/52] expo: Implement a box
Date: Wed, 19 Mar 2025 15:54:43 +0100
Message-ID: <20250319145512.2391122-39-sjg@chromium.org>
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

It is useful to be able to draw a box around elements in the menu. Add
support for an unfilled box with a selectable thickness.

Note that there is no support for selecting the colour for any expo
objects yet.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c         |  5 +++++
 boot/scene.c         | 40 +++++++++++++++++++++++++++++++++++++++-
 doc/develop/expo.rst |  2 ++
 include/expo.h       | 28 ++++++++++++++++++++++++++++
 test/boot/expo.c     | 12 +++++++++++-
 5 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 67f8e2cfbd9..bdf51b50cd4 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -81,6 +81,7 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU:
 			scene_obj_set_pos(scn, obj->id, 50, y);
@@ -376,6 +377,7 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_TEXTLINE: {
 		const struct scene_obj_textline *tline;
@@ -476,6 +478,7 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_TEXTLINE: {
 		const struct scene_obj_textline *tline;
@@ -547,6 +550,7 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_MENU:
 		menu = (struct scene_obj_menu *)obj;
@@ -630,6 +634,7 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_MENU:
 		menu = (struct scene_obj_menu *)obj;
diff --git a/boot/scene.c b/boot/scene.c
index 96e8304d8d2..640d972ce8f 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -210,6 +210,26 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
 	return txt->obj.id;
 }
 
+int scene_box(struct scene *scn, const char *name, uint id, uint width,
+	      struct scene_obj_box **boxp)
+{
+	struct scene_obj_box *box;
+	int ret;
+
+	ret = scene_obj_add(scn, name, id, SCENEOBJT_BOX,
+			    sizeof(struct scene_obj_box),
+			    (struct scene_obj **)&box);
+	if (ret < 0)
+		return log_msg_ret("obj", ret);
+
+	box->width = width;
+
+	if (boxp)
+		*boxp = box;
+
+	return box->obj.id;
+}
+
 int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 		       uint font_size)
 {
@@ -322,6 +342,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_MENU:
 	case SCENEOBJT_TEXTLINE:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_IMAGE: {
 		struct scene_obj_img *img = (struct scene_obj_img *)obj;
@@ -485,10 +506,12 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	const struct expo_theme *theme = &exp->theme;
 	struct udevice *dev = exp->display;
 	struct udevice *cons = text_mode ? NULL : exp->cons;
+	struct video_priv *vid_priv;
 	int x, y, ret;
 
-	x = obj->bbox.x0;
 	y = obj->bbox.y0;
+	x = obj->bbox.x0;
+	vid_priv = dev_get_uclass_priv(dev);
 
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
@@ -539,6 +562,13 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 		if (obj->flags & SCENEOF_OPEN)
 			scene_render_background(obj, true);
 		break;
+	case SCENEOBJT_BOX: {
+		struct scene_obj_box *box = (struct scene_obj_box *)obj;
+
+		video_draw_box(dev, obj->bbox.x0, obj->bbox.y0, obj->bbox.x1,
+			       obj->bbox.y1, box->width, vid_priv->colour_fg);
+		break;
+	}
 	}
 
 	return 0;
@@ -557,6 +587,7 @@ int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -602,6 +633,7 @@ int scene_arrange(struct scene *scn)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -647,6 +679,7 @@ int scene_render_deps(struct scene *scn, uint id)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU:
 			scene_menu_render_deps(scn,
@@ -766,6 +799,7 @@ int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -810,6 +844,7 @@ int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox bbox[])
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		return -ENOSYS;
 	case SCENEOBJT_MENU: {
 		struct scene_obj_menu *menu = (struct scene_obj_menu *)obj;
@@ -839,6 +874,7 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 		switch (obj->type) {
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 		case SCENEOBJT_IMAGE: {
 			int width;
 
@@ -897,6 +933,7 @@ int scene_apply_theme(struct scene *scn, struct expo_theme *theme)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_MENU:
+		case SCENEOBJT_BOX:
 		case SCENEOBJT_TEXTLINE:
 			break;
 		case SCENEOBJT_TEXT:
@@ -939,6 +976,7 @@ static int scene_obj_open(struct scene *scn, struct scene_obj *obj)
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_MENU:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_TEXTLINE:
 		ret = scene_textline_open(scn,
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index cc7c36173db..8f63ccbe3ef 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -65,6 +65,8 @@ item is highlighted.
 
 A `textline object` contains a label and an editable string.
 
+A `box object` is a rectangle with a given line width. It is not filled.
+
 All components have a name. This is mostly for debugging, so it is easy to see
 what object is referred to, although the name is also used for saving values.
 Of course the ID numbers can help as well, but they are less easy to
diff --git a/include/expo.h b/include/expo.h
index a79aa1da74f..8833dcceb7e 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -179,6 +179,7 @@ struct scene {
  *
  * @SCENEOBJT_NONE: Used to indicate that the type does not matter
  * @SCENEOBJT_IMAGE: Image data to render
+ * @SCENEOBJT_BOX: Rectangular box
  * @SCENEOBJT_TEXT: Text line to render
  * @SCENEOBJT_MENU: Menu containing items the user can select
  * @SCENEOBJT_TEXTLINE: Line of text the user can edit
@@ -187,6 +188,7 @@ enum scene_obj_t {
 	SCENEOBJT_NONE		= 0,
 	SCENEOBJT_IMAGE,
 	SCENEOBJT_TEXT,
+	SCENEOBJT_BOX,
 
 	/* types from here on can be highlighted */
 	SCENEOBJT_MENU,
@@ -406,6 +408,19 @@ struct scene_obj_textline {
 	uint pos;
 };
 
+/**
+ * struct scene_obj_box - information about a box in a scene
+ *
+ * A box surrounds a part of the screen with a border
+ *
+ * @obj: Basic object information
+ * @width: Line-width in pixels
+ */
+struct scene_obj_box {
+	struct scene_obj obj;
+	uint width;
+};
+
 /**
  * struct expo_arrange_info - Information used when arranging a scene
  *
@@ -670,6 +685,19 @@ int scene_menu(struct scene *scn, const char *name, uint id,
 int scene_textline(struct scene *scn, const char *name, uint id, uint max_chars,
 		   struct scene_obj_textline **tlinep);
 
+/**
+ *  scene_box() - create a box
+ *
+ * @scn: Scene to update
+ * @name: Name to use (this is allocated by this call)
+ * @id: ID to use for the new object (0 to allocate one)
+ * @width: Line-width in pixels
+ * @boxp: If non-NULL, returns the new object
+ * Returns: ID number for the object (typically @id), or -ve on error
+ */
+int scene_box(struct scene *scn, const char *name, uint id, uint width,
+	      struct scene_obj_box **boxp);
+
 /**
  * scene_txt_set_font() - Set the font for an object
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 9e0e3f207e0..c76051e1c7d 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -28,6 +28,8 @@ enum {
 	OBJ_TEXT3,
 	OBJ_MENU,
 	OBJ_MENU_TITLE,
+	OBJ_BOX,
+	OBJ_BOX2,
 
 	/* strings */
 	STR_SCENE_TITLE,
@@ -545,6 +547,14 @@ static int expo_render_image(struct unit_test_state *uts)
 
 	ut_assertok(scene_obj_set_pos(scn, OBJ_MENU, 50, 400));
 
+	id = scene_box(scn, "box", OBJ_BOX, 3, NULL);
+	ut_assert(id > 0);
+	ut_assertok(scene_obj_set_bbox(scn, OBJ_BOX, 40, 390, 1000, 510));
+
+	id = scene_box(scn, "box2", OBJ_BOX2, 1, NULL);
+	ut_assert(id > 0);
+	ut_assertok(scene_obj_set_bbox(scn, OBJ_BOX, 500, 200, 1000, 350));
+
 	scn2 = expo_lookup_scene_id(exp, SCENE1);
 	ut_asserteq_ptr(scn, scn2);
 	scn2 = expo_lookup_scene_id(exp, SCENE2);
@@ -656,7 +666,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
 
-	ut_asserteq(14951, video_compress_fb(uts, dev, false));
+	ut_asserteq(15016, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* make sure only the preview for the second item is shown */
-- 
2.43.0

