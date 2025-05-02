Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1297FC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:53:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C92382B63;
	Fri,  2 May 2025 16:49:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LLRtjk8u";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34D028214F; Fri,  2 May 2025 16:48:59 +0200 (CEST)
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com
 [IPv6:2607:f8b0:4864:20::d2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C38C0828C2
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2a.google.com with SMTP id
 ca18e2360f4ac-86135af1045so233914439f.1
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197334; x=1746802134; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ftp13Bdno+TCOwbafI7aTvgNQOqtnkAiYmEujKaV+AU=;
 b=LLRtjk8u5YzXSjoJGVyy0K6dxckUwSF1jB2bdgP+KeQp4fpt5fx3kqPMgA8krGvQYG
 jBW8o7mJW67vaF6JU46SGS9ez3zD7vMIqdenqcN3xM9zo0iYLVernzeHNPpn1GjidAAa
 4MuNINfBJAMra+v31Mvnhgewp9fgnkdxO0Nbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197334; x=1746802134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ftp13Bdno+TCOwbafI7aTvgNQOqtnkAiYmEujKaV+AU=;
 b=XHfOg/T5XsU/w32EKeAwSoSyXLfjIrV1vMYNE/6O6FSom5TExrkLHkQuY5y+l9vmRa
 fCpIiZrd72LfKkeTT7B0BPioGYWtejAFXI9uhovUYkDdfriQ3ypvx3ei7H2w8nDaUIAq
 dtbFzv+/FQB6Ad8w4MldT+dWoFNk1QsNXFfP+FOtVE8xG+CmNkxCE6IQIDr+F5Q+yqp0
 ZUkPhXseS0tWCfwmCn4d14QZANLUxoTPVMMBTDf5lLQQ+CZabM+PluajAmGN7ZUFaOqG
 jGM5t9PFsdjhjGNlKWEEXekbVz01tfEzfF/LiIsVR4Iq+sD8s7R9Qnwyq2MsXJ9AjP9F
 EpHg==
X-Gm-Message-State: AOJu0Yz24+EQKb7rAYO+t7G3TPIBspdTt5WUgDqvqCeUv+zy/M+iOCmq
 qAyjyGCAlvVvy8veTRgGLNkF1KaiqZ07Kst0xCgqwKSDgr1mmao0dwF2IcZr8XBxac+fC8NDUQ8
 =
X-Gm-Gg: ASbGncukS/2v09l3z57pNRl03oflIiyMwmW4JCTyCK1VH2WBUThceGSfw+POhCC0lb7
 M3qysueQapr74LRscZotARTEz3zZQoHRBMzPyNFFWoZlRFmdnWIZyc0sAR0qcdUyF4jMKG87Kux
 TU4hm26W/qk+4lV/hhE8yviDinjsawAwUZHuVymZS0m9no2Ch6adinTzckQLCJQWtpSVwHVde0U
 OhvkrE1zzC/5cqV1U7bBkmk65+5SGnAYIlHg5rm3dP2jHH3NbSNWgWRWwNOMM3krY8AxftMHt4e
 W/5kHX5t59IDCkWpLsTKwqsOzripWyO7K+aiRyntbIk2TkZGq51sz82GTnXvxEU9oj8/bpi2Itt
 IrQ==
X-Google-Smtp-Source: AGHT+IFHCBQqG4GOlgECpKZcNAUUJXiw5JYu4m3dAMemXyOeb+Bwt2AEroNXWTGHAQa1XY95+DwXQw==
X-Received: by 2002:a05:6602:398b:b0:864:4a82:15ec with SMTP id
 ca18e2360f4ac-8669fad4facmr468675539f.6.1746197334545; 
 Fri, 02 May 2025 07:48:54 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 46/60] expo: Implement a box
Date: Fri,  2 May 2025 08:46:44 -0600
Message-ID: <20250502144718.313633-47-sjg@chromium.org>
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

It is useful to be able to draw a box around elements in the menu. Add
support for an unfilled box with a selectable thickness.

Note that there is no support for selecting the colour for any expo
objects yet.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c         |  5 +++++
 boot/scene.c         | 40 +++++++++++++++++++++++++++++++++++++++-
 doc/develop/expo.rst |  2 ++
 include/expo.h       | 28 ++++++++++++++++++++++++++++
 test/boot/expo.c     | 13 +++++++++++--
 5 files changed, 85 insertions(+), 3 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 0f7a8657c58..9153fe769c6 100644
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
@@ -381,6 +382,7 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_TEXTLINE: {
 		const struct scene_obj_textline *tline;
@@ -480,6 +482,7 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_TEXTLINE: {
 		const struct scene_obj_textline *tline;
@@ -551,6 +554,7 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_MENU:
 		menu = (struct scene_obj_menu *)obj;
@@ -634,6 +638,7 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_MENU:
 		menu = (struct scene_obj_menu *)obj;
diff --git a/boot/scene.c b/boot/scene.c
index 72a8e27a93d..f971db9aab4 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -211,6 +211,26 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
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
@@ -323,6 +343,7 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_MENU:
 	case SCENEOBJT_TEXTLINE:
+	case SCENEOBJT_BOX:
 		break;
 	case SCENEOBJT_IMAGE: {
 		struct scene_obj_img *img = (struct scene_obj_img *)obj;
@@ -490,10 +511,12 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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
@@ -544,6 +567,13 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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
@@ -562,6 +592,7 @@ int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -607,6 +638,7 @@ int scene_arrange(struct scene *scn)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -652,6 +684,7 @@ int scene_render_deps(struct scene *scn, uint id)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU:
 			scene_menu_render_deps(scn,
@@ -771,6 +804,7 @@ int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -815,6 +849,7 @@ int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox bbox[])
 	case SCENEOBJT_NONE:
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
+	case SCENEOBJT_BOX:
 		return -ENOSYS;
 	case SCENEOBJT_MENU: {
 		struct scene_obj_menu *menu = (struct scene_obj_menu *)obj;
@@ -844,6 +879,7 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 		switch (obj->type) {
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_TEXT:
+		case SCENEOBJT_BOX:
 		case SCENEOBJT_IMAGE: {
 			int width;
 
@@ -902,6 +938,7 @@ int scene_apply_theme(struct scene *scn, struct expo_theme *theme)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_MENU:
+		case SCENEOBJT_BOX:
 		case SCENEOBJT_TEXTLINE:
 			break;
 		case SCENEOBJT_TEXT:
@@ -944,6 +981,7 @@ static int scene_obj_open(struct scene *scn, struct scene_obj *obj)
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
index c9ff5b8dd24..e4f3ffc01fb 100644
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
@@ -655,8 +665,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(ITEM2, scene_menu_get_cur_item(scn, OBJ_MENU));
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-
-	ut_asserteq(14848, video_compress_fb(uts, dev, false));
+	ut_asserteq(14883, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* make sure only the preview for the second item is shown */
-- 
2.43.0

