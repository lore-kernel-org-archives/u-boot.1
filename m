Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131A0E784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:33:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E905787257;
	Mon,  2 Oct 2023 03:18:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="etZ4u59r";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 691DD87252; Mon,  2 Oct 2023 03:17:57 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A4987235
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3526c9c401aso3803175ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209382; x=1696814182; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g4ZAtvULpjRGWlNvdw15pitwhS7O+DxpeQt9tVtQFu0=;
 b=etZ4u59rfhPzR/B548xtb3dxTUr9wUZFtNx2soYCvpgdN4IXFheUk+tnVkbHdYwt8W
 jrzUcfgmHc2utG6my/SsLsvhmRpAeaZO9lK/koSRuyoLchFqGLO85e7dh1mG6s4aY5nI
 /FLgXR0c1gweuICUNvImz/J9pKk52g0Jq74Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209382; x=1696814182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g4ZAtvULpjRGWlNvdw15pitwhS7O+DxpeQt9tVtQFu0=;
 b=BFJmMHXkH2LF1QIOywtpMiFdkxTS+PDUJS8azT3asiSexP7jERviNUnUdl6ktXZrFC
 ROhBz8+vSIYnz4+ULk4h6RKS5o4UuvogCcSvl2zBXdRG1lbBv18snUhZ67qJq2myiXge
 yNzfYEPRPCeqOJt7FDvNZkTqt7IgeS/xomz5eygb9y1uKZQlSREaIJFnqmjmmdlH9JHw
 3nflrwdEAGAOPm6mvu2zEV0ls+amfHYzuZZ92/xtXhZXbOHh6a2FdrP4VAY1vEqye/O4
 p32nv+3qrduw24835PDQin5XVnETL0E/TdYk7T383zc17rpt5fnYlZCz1kmt+fpCzLIr
 jKeQ==
X-Gm-Message-State: AOJu0Yx6yPpb5hLH9U1lhdjR4D49XjhChFUwBUN3XYw4cA0y8PwkhmES
 qzwyMbCp79Oc9x+v6KyTfHyFblR/vlnpgN3E1Bw=
X-Google-Smtp-Source: AGHT+IGxPaVfb6QBA0Nox7v3nGWEVOGYsO68Rl0ko4GjdfjBWZGmge4Q7CyPNsriAstlSeVynKOVEg==
X-Received: by 2002:a05:6e02:1d12:b0:34f:30f0:d4e6 with SMTP id
 i18-20020a056e021d1200b0034f30f0d4e6mr8328754ila.1.1696209382329; 
 Sun, 01 Oct 2023 18:16:22 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 18/34] expo: Place menu items to the right of all labels
Date: Sun,  1 Oct 2023 19:15:28 -0600
Message-ID: <20231002011553.463514-19-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

At present a fixed position is used for menu items, 200 pixels to the
right of the left side of the labels. This means that a menu item with
a very long label may overlap the items.

It seems better to calculate the maximum label width and then place the
items to the right of all of them.

To implement this, add a new struct to containing arrangement
information. Calculate it before doing the actual arrangement. Add a
new style item which sets the amount of space from the right side of
the labels to left side of the items.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c          | 13 ++++++++---
 boot/expo.c           |  2 ++
 boot/scene.c          | 52 +++++++++++++++++++++++++++++++++++++++++--
 boot/scene_internal.h | 20 +++++++++++++++--
 boot/scene_menu.c     |  9 +++++---
 boot/scene_textline.c |  3 ++-
 doc/develop/expo.rst  |  4 ++++
 include/expo.h        | 12 ++++++++++
 8 files changed, 104 insertions(+), 11 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 8c654dba6dc3..b5f89e945bce 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -52,10 +52,11 @@ struct cedit_iter_priv {
 
 int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 {
+	struct expo_arrange_info arr;
 	struct scene_obj_txt *txt;
 	struct scene_obj *obj;
 	struct scene *scn;
-	int y;
+	int y, ret;
 
 	scn = expo_lookup_scene_id(exp, scene_id);
 	if (!scn)
@@ -69,6 +70,11 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 	if (txt)
 		scene_obj_set_pos(scn, txt->obj.id, 200, 10);
 
+	memset(&arr, '\0', sizeof(arr));
+	ret = scene_calc_arrange(scn, &arr);
+	if (ret < 0)
+		return log_msg_ret("arr", ret);
+
 	y = 100;
 	list_for_each_entry(obj, &scn->obj_head, sibling) {
 		switch (obj->type) {
@@ -78,12 +84,13 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 			break;
 		case SCENEOBJT_MENU:
 			scene_obj_set_pos(scn, obj->id, 50, y);
-			scene_menu_arrange(scn, (struct scene_obj_menu *)obj);
+			scene_menu_arrange(scn, &arr,
+					   (struct scene_obj_menu *)obj);
 			y += 50;
 			break;
 		case SCENEOBJT_TEXTLINE:
 			scene_obj_set_pos(scn, obj->id, 50, y);
-			scene_textline_arrange(scn,
+			scene_textline_arrange(scn, &arr,
 					(struct scene_obj_textline *)obj);
 			y += 50;
 			break;
diff --git a/boot/expo.c b/boot/expo.c
index cadb6a0ad6e3..d030820e77ca 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -259,6 +259,8 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 	ofnode_read_u32(node, "font-size", &theme->font_size);
 	ofnode_read_u32(node, "menu-inset", &theme->menu_inset);
 	ofnode_read_u32(node, "menuitem-gap-y", &theme->menuitem_gap_y);
+	ofnode_read_u32(node, "menu-title-margin-x",
+			&theme->menu_title_margin_x);
 
 	list_for_each_entry(scn, &exp->scene_head, sibling) {
 		ret = scene_apply_theme(scn, theme);
diff --git a/boot/scene.c b/boot/scene.c
index 0b37971b1ff4..56569e76e9f2 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -478,11 +478,59 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	return 0;
 }
 
+int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr)
+{
+	struct scene_obj *obj;
+
+	arr->label_width = 0;
+	list_for_each_entry(obj, &scn->obj_head, sibling) {
+		uint label_id = 0;
+		int width;
+
+		switch (obj->type) {
+		case SCENEOBJT_NONE:
+		case SCENEOBJT_IMAGE:
+		case SCENEOBJT_TEXT:
+			break;
+		case SCENEOBJT_MENU: {
+			struct scene_obj_menu *menu;
+
+			menu = (struct scene_obj_menu *)obj,
+			label_id = menu->title_id;
+			break;
+		}
+		case SCENEOBJT_TEXTLINE: {
+			struct scene_obj_textline *tline;
+
+			tline = (struct scene_obj_textline *)obj,
+			label_id = tline->label_id;
+			break;
+		}
+		}
+
+		if (label_id) {
+			int ret;
+
+			ret = scene_obj_get_hw(scn, label_id, &width);
+			if (ret < 0)
+				return log_msg_ret("hei", ret);
+			arr->label_width = max(arr->label_width, width);
+		}
+	}
+
+	return 0;
+}
+
 int scene_arrange(struct scene *scn)
 {
+	struct expo_arrange_info arr;
 	struct scene_obj *obj;
 	int ret;
 
+	ret = scene_calc_arrange(scn, &arr);
+	if (ret < 0)
+		return log_msg_ret("arr", ret);
+
 	list_for_each_entry(obj, &scn->obj_head, sibling) {
 		switch (obj->type) {
 		case SCENEOBJT_NONE:
@@ -493,7 +541,7 @@ int scene_arrange(struct scene *scn)
 			struct scene_obj_menu *menu;
 
 			menu = (struct scene_obj_menu *)obj,
-			ret = scene_menu_arrange(scn, menu);
+			ret = scene_menu_arrange(scn, &arr, menu);
 			if (ret)
 				return log_msg_ret("arr", ret);
 			break;
@@ -502,7 +550,7 @@ int scene_arrange(struct scene *scn)
 			struct scene_obj_textline *tline;
 
 			tline = (struct scene_obj_textline *)obj,
-			ret = scene_textline_arrange(scn, tline);
+			ret = scene_textline_arrange(scn, &arr, tline);
 			if (ret)
 				return log_msg_ret("arr", ret);
 			break;
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index e72202c98213..be25f6a8b967 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -96,10 +96,12 @@ int scene_calc_dims(struct scene *scn, bool do_menus);
  * if not already done
  *
  * @scn: Scene to update
+ * @arr: Arrangement information
  * @menu: Menu to process
  * Returns: 0 if OK, -ve on error
  */
-int scene_menu_arrange(struct scene *scn, struct scene_obj_menu *menu);
+int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
+		       struct scene_obj_menu *menu);
 
 /**
  * scene_textline_arrange() - Set the position of things in a textline
@@ -108,10 +110,12 @@ int scene_menu_arrange(struct scene *scn, struct scene_obj_menu *menu);
  * positioned correctly relative to the textline.
  *
  * @scn: Scene to update
+ * @arr: Arrangement information
  * @tline: textline to process
  * Returns: 0 if OK, -ve on error
  */
-int scene_textline_arrange(struct scene *scn, struct scene_obj_textline *tline);
+int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
+			   struct scene_obj_textline *tline);
 
 /**
  * scene_apply_theme() - Apply a theme to a scene
@@ -358,4 +362,16 @@ int scene_textline_open(struct scene *scn, struct scene_obj_textline *tline);
  */
 int scene_textline_close(struct scene *scn, struct scene_obj_textline *tline);
 
+/**
+ * scene_calc_arrange() - Calculate sizes needed to arrange a scene
+ *
+ * Checks the size of some objects and stores this info to help with a later
+ * scene arrangement
+ *
+ * @scn: Scene to check
+ * @arr: Place to put scene-arrangement info
+ * Returns: 0 if OK, -ve on error
+ */
+int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr);
+
 #endif /* __SCENE_INTERNAL_H */
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 63994165efba..dbf6eacb2983 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -169,7 +169,8 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 	return 0;
 }
 
-int scene_menu_arrange(struct scene *scn, struct scene_obj_menu *menu)
+int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
+		       struct scene_obj_menu *menu)
 {
 	const bool open = menu->obj.flags & SCENEOF_OPEN;
 	struct expo *exp = scn->expo;
@@ -183,16 +184,18 @@ int scene_menu_arrange(struct scene *scn, struct scene_obj_menu *menu)
 	x = menu->obj.dim.x;
 	y = menu->obj.dim.y;
 	if (menu->title_id) {
+		int width;
+
 		ret = scene_obj_set_pos(scn, menu->title_id, menu->obj.dim.x, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
-		ret = scene_obj_get_hw(scn, menu->title_id, NULL);
+		ret = scene_obj_get_hw(scn, menu->title_id, &width);
 		if (ret < 0)
 			return log_msg_ret("hei", ret);
 
 		if (stack)
-			x += 200;
+			x += arr->label_width + theme->menu_title_margin_x;
 		else
 			y += ret * 2;
 	}
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 6ea072a1c268..576a402a688d 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -85,7 +85,8 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
 	return 0;
 }
 
-int scene_textline_arrange(struct scene *scn, struct scene_obj_textline *tline)
+int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
+			   struct scene_obj_textline *tline)
 {
 	const bool open = tline->obj.flags & SCENEOF_OPEN;
 	bool point;
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index c87b6ec81285..f7b636e5fc62 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -176,6 +176,10 @@ menu-inset
 menuitem-gap-y
     Number of pixels between menu items
 
+menu-title-margin-x
+    Number of pixels between right side of menu title to the left size of the
+    menu labels
+
 Pop-up mode
 -----------
 
diff --git a/include/expo.h b/include/expo.h
index 3260703a7a01..4f62ee077e1f 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -59,11 +59,14 @@ struct expo_action {
  * @font_size: Default font size for all text
  * @menu_inset: Inset width (on each side and top/bottom) for menu items
  * @menuitem_gap_y: Gap between menu items in pixels
+ * @menu_title_margin_x: Gap between right side of menu title and left size of
+ *	menu label
  */
 struct expo_theme {
 	u32 font_size;
 	u32 menu_inset;
 	u32 menuitem_gap_y;
+	u32 menu_title_margin_x;
 };
 
 /**
@@ -341,6 +344,15 @@ struct scene_obj_textline {
 	uint pos;
 };
 
+/**
+ * struct expo_arrange_info - Information used when arranging a scene
+ *
+ * @label_width: Maximum width of labels in scene
+ */
+struct expo_arrange_info {
+	int label_width;
+};
+
 /**
  * expo_new() - create a new expo
  *
-- 
2.42.0.582.g8ccd20d70d-goog

