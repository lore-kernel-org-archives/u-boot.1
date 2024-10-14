Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4FFD18158
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:32:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2CA789245;
	Tue, 15 Oct 2024 00:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DJ171IOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2147889232; Tue, 15 Oct 2024 00:32:23 +0200 (CEST)
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com
 [IPv6:2607:f8b0:4864:20::143])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E5A8921A
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x143.google.com with SMTP id
 e9e14a558f8ab-3a3b0247d67so14724275ab.3
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945139; x=1729549939; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwtJ3qCMwKhDLCmzfGqu9LCr6i8OXbEteGE6DNQQ/qI=;
 b=DJ171IOf2Vx/lkE7iJ/Ql0gi3kWKSHuCWG1YQ/9FRj0W3dZ1bEI1///3FHCJLifnPS
 uKHs/Gh3JqIya/FeqfqhPz/FECPIXiiJqNQ9teORlOU2g4jNrXD1/i6KwlMsy7k9Lugw
 6Ii1w7zvYwWAyjbWpYnsR4ann9i5gKndJmISk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945139; x=1729549939;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rwtJ3qCMwKhDLCmzfGqu9LCr6i8OXbEteGE6DNQQ/qI=;
 b=bh4Kp75Wwy9g92wKymWHtnQSlPHYA5n+Rs2l9uTj4ITGxeGg7UPp9M1+jir7muyq6d
 W9QmjZCw1mIeNm5uGNJMGL7IiX9AJsannHF0vxPpZfLyMnMHKKXYp4lfM/tMQZ1MTShc
 R7jMfX9tYQGLKKR5kkszNBUT2f/gqUsMW9ZC3CGuTQCgaWuQ5AjkTGFN+c6NP0iWDeUz
 l9mJGqAFn7bNj0ngKuE8tcu/Z1u35YvyRaxtOE+gFV4zK9I9SB8RH5/T9dQqct6+mnlD
 5s6W4sx5tUd1UPAZjbd40qGafHH3J5BmzsXpC5jAj7nA59Bov0+nWhF7i3LPAJ09N0h4
 9fXg==
X-Gm-Message-State: AOJu0YzzfYngsUUP05Je4kGzIc7v1u7nbLb/KImZGurDlAtn2NPLWNUl
 Rj8Kxng2PjDoL/BrZi2JmmYZJ4TzaR+KN6h/4+U7eO8BBUpPSyLSF2STo4Ko+XSXlzuwmpZUVyw
 mTDcf
X-Google-Smtp-Source: AGHT+IG+XeioruTkUZ7ioPadRMSJeFE3jli3QUWzo+5HW3Uy+L2Y16FYcW/zrCyXX/VERCYfwObvuw==
X-Received: by 2002:a05:6e02:17cd:b0:3a0:915d:a4a7 with SMTP id
 e9e14a558f8ab-3a3bcd962d8mr79681575ab.2.1728945138781; 
 Mon, 14 Oct 2024 15:32:18 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: [PATCH v3 03/20] expo: Place menu items to the right of all labels
Date: Mon, 14 Oct 2024 16:31:55 -0600
Message-Id: <20241014223212.2212442-4-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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

(no changes since v1)

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
index c29a2be14ce..5758cc5a0d6 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -51,10 +51,11 @@ struct cedit_iter_priv {
 
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
@@ -68,6 +69,11 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
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
@@ -77,12 +83,13 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
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
index ed01483f1d3..c7ce19e834b 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -258,6 +258,8 @@ int expo_apply_theme(struct expo *exp, ofnode node)
 	ofnode_read_u32(node, "font-size", &theme->font_size);
 	ofnode_read_u32(node, "menu-inset", &theme->menu_inset);
 	ofnode_read_u32(node, "menuitem-gap-y", &theme->menuitem_gap_y);
+	ofnode_read_u32(node, "menu-title-margin-x",
+			&theme->menu_title_margin_x);
 
 	list_for_each_entry(scn, &exp->scene_head, sibling) {
 		ret = scene_apply_theme(scn, theme);
diff --git a/boot/scene.c b/boot/scene.c
index 0135287cfcb..a4836000b28 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -471,11 +471,59 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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
@@ -486,7 +534,7 @@ int scene_arrange(struct scene *scn)
 			struct scene_obj_menu *menu;
 
 			menu = (struct scene_obj_menu *)obj,
-			ret = scene_menu_arrange(scn, menu);
+			ret = scene_menu_arrange(scn, &arr, menu);
 			if (ret)
 				return log_msg_ret("arr", ret);
 			break;
@@ -495,7 +543,7 @@ int scene_arrange(struct scene *scn)
 			struct scene_obj_textline *tline;
 
 			tline = (struct scene_obj_textline *)obj,
-			ret = scene_textline_arrange(scn, tline);
+			ret = scene_textline_arrange(scn, &arr, tline);
 			if (ret)
 				return log_msg_ret("arr", ret);
 			break;
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index e72202c9821..be25f6a8b96 100644
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
index 80bd7457cb1..c331f6670cc 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -168,7 +168,8 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 	return 0;
 }
 
-int scene_menu_arrange(struct scene *scn, struct scene_obj_menu *menu)
+int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
+		       struct scene_obj_menu *menu)
 {
 	const bool open = menu->obj.flags & SCENEOF_OPEN;
 	struct expo *exp = scn->expo;
@@ -182,16 +183,18 @@ int scene_menu_arrange(struct scene *scn, struct scene_obj_menu *menu)
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
index bba8663b98d..6adef7cc173 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -87,7 +87,8 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
 	return 0;
 }
 
-int scene_textline_arrange(struct scene *scn, struct scene_obj_textline *tline)
+int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
+			   struct scene_obj_textline *tline)
 {
 	const bool open = tline->obj.flags & SCENEOF_OPEN;
 	bool point;
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index c87b6ec8128..f7b636e5fc6 100644
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
index c235fa2709d..50e11cd118c 100644
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
2.34.1

