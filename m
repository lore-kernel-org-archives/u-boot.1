Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E43C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:46:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1152282A8D;
	Mon,  5 May 2025 17:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="URxPxTaO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8F1F829CD; Mon,  5 May 2025 17:44:21 +0200 (CEST)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63353801BE
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5e6f4b3ebe5so7997317a12.0
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459858; x=1747064658; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EZsWKj8O5o/iHrSdlV/qj+TOCjLqm2rnIFUy5vLxJDs=;
 b=URxPxTaOsd1X7yMeMoL0NpPL8TXNXDka345L2p79Do1uH+ZjBEmWk7JgdHmAYGjokJ
 WrrJH9g2lvTdy/8d/I3gZYuq2NV6Jn287xX+kMCL4QxT0msxAbKYTjlhCNj6FAwcE9X4
 /SSvPLH4RSkl/CF4K7dkU3xMPQ/Kow0PL5SGk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459858; x=1747064658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZsWKj8O5o/iHrSdlV/qj+TOCjLqm2rnIFUy5vLxJDs=;
 b=tZKUJidlIas4+pUtG0rslxcJUbeP63NPC4lHYqifZEpZLYEiRcW/KCdK2fQVbzJGit
 qsXDXA4M4x73FJnP+jLyQG1D74xhubrDbLYoEIeWbKfYSfggt3HW/0v0HBFO0+mYi0HH
 QwO0BXTBj5H0myo9tUroA6b8DV2ca+I1cOBqbewoJTXmLx84PHQOKOTVAzl0XD48pafU
 Rl+rnHxABkrQpCP04ftxR6yw97hB084ye5rd7fG/nuIvb04fbAwXzDSgTfLaHjynrHJY
 JggiQNPFLqNy+QQ9nN5E/mMFP1FJr4j4FEEbbdWdLELmOEABNcPXiLv1Jara/8GfDGGK
 HLPw==
X-Gm-Message-State: AOJu0YwKun6d4WAQii1sOZvcb3z9PMNtQzZYgn6+SRBOlFeR0rmw/yDJ
 3e/vAhHkdQf8fQ5E954DFbQuRZ9GSI208PZOARELkaFOoUYkXuIziu4R0+Lgvwv56H0LF3pfHZS
 970twlL0=
X-Gm-Gg: ASbGnctuaK8ZW2ToPzjELO1htCfFWbDQaLvYUz4MvHloryecxV1UFpGLImxUbR4Q7oz
 5gu5c0ZqDfBYPs44FReCzSRy5+AVuaebJU2nbGR8I7gdwcxCyg1ugal8Nii6AlLru6VV8q4odWc
 DlR+uZeYnQSTFpoqVizVzEKluSjFeETsJ4bUVrN40J9y2K82rYWXL9xjsdPfjPryAkJEO6TssS2
 XtmRQRmAmsPZtNWXVMhkZ+4FzT1VSVGq4EBAnviW6AHjnghJ022kHhOEMhtmekoLrtzCDwSXRUQ
 PcNCvJzcGDqK81Zz3xsn4N2oW7bVZo3wLAxD
X-Google-Smtp-Source: AGHT+IHOqzf2tg/7RPtHaV+6emsXEhURnJwaplmIvP8JgyTflVu0U0LoOGHQHvSwGvxY635STeFStw==
X-Received: by 2002:a05:6402:51c8:b0:5fb:3ca1:fb60 with SMTP id
 4fb4d7f45d1cf-5fb3ca1fc53mr859078a12.9.1746459857707; 
 Mon, 05 May 2025 08:44:17 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 17/19] expo: Separate requested bbox from actual
Date: Mon,  5 May 2025 17:42:55 +0200
Message-ID: <20250505154308.2911248-18-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250505154308.2911248-1-sjg@chromium.org>
References: <20250505154308.2911248-1-sjg@chromium.org>
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

With fixed coordinates it is difficult to create scenes that can work on
any display size. Add a separate 'requested' bounding box for each
object and sync it when required.

With future work, this will allow scaling the nominal coordinates so
that an expo can be rendered correctly on a wider range of displays.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 74 +++++++++++++++++++++++++++++++++----------
 boot/scene_internal.h | 10 ++++++
 boot/scene_menu.c     | 13 ++++----
 boot/scene_textline.c | 10 +++---
 include/expo.h        | 25 ++++++++++++++-
 test/boot/expo.c      | 18 +++++------
 6 files changed, 111 insertions(+), 39 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 0d8599f955c..40ef3e0138c 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -253,12 +253,13 @@ int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	w = obj->bbox.x1 - obj->bbox.x0;
-	h = obj->bbox.y1 - obj->bbox.y0;
-	obj->bbox.x0 = x;
-	obj->bbox.y0 = y;
-	obj->bbox.x1 = obj->bbox.x0 + w;
-	obj->bbox.y1 = obj->bbox.y0 + h;
+	w = obj->req_bbox.x1 - obj->req_bbox.x0;
+	h = obj->req_bbox.y1 - obj->req_bbox.y0;
+	obj->req_bbox.x0 = x;
+	obj->req_bbox.y0 = y;
+	obj->req_bbox.x1 = obj->req_bbox.x0 + w;
+	obj->req_bbox.y1 = obj->req_bbox.y0 + h;
+	obj->flags |= SCENEOF_SYNC_POS;
 
 	return 0;
 }
@@ -270,9 +271,10 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->bbox.x1 = obj->bbox.x0 + w;
-	obj->bbox.y1 = obj->bbox.y0 + h;
-	obj->flags |= SCENEOF_SIZE_VALID;
+	log_debug("obj %s w %d h %d\n", obj->name, w, h);
+	obj->req_bbox.x1 = obj->req_bbox.x0 + w;
+	obj->req_bbox.y1 = obj->req_bbox.y0 + h;
+	obj->flags |= SCENEOF_SIZE_VALID | SCENEOF_SYNC_SIZE;
 
 	return 0;
 }
@@ -284,7 +286,8 @@ int scene_obj_set_width(struct scene *scn, uint id, int w)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->bbox.x1 = obj->bbox.x0 + w;
+	obj->req_bbox.x1 = obj->req_bbox.x0 + w;
+	obj->flags |= SCENEOF_SYNC_WIDTH;
 
 	return 0;
 }
@@ -297,11 +300,11 @@ int scene_obj_set_bbox(struct scene *scn, uint id, int x0, int y0, int x1,
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->bbox.x0 = x0;
-	obj->bbox.y0 = y0;
-	obj->bbox.x1 = x1;
-	obj->bbox.y1 = y1;
-	obj->flags |= SCENEOF_SIZE_VALID;
+	obj->req_bbox.x0 = x0;
+	obj->req_bbox.y0 = y0;
+	obj->req_bbox.x1 = x1;
+	obj->req_bbox.y1 = y1;
+	obj->flags |= SCENEOF_SIZE_VALID | SCENEOF_SYNC_BBOX;
 
 	return 0;
 }
@@ -448,7 +451,8 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		}
 
 		limit = obj->flags & SCENEOF_SIZE_VALID ?
-			obj->bbox.x1 - obj->bbox.x0 : -1;
+			obj->req_bbox.x1 - obj->req_bbox.x0 : -1;
+		log_debug("obj %s limit %d\n", obj->name, limit);
 
 		ret = vidconsole_measure(scn->expo->cons, gen->font_name,
 					 gen->font_size, str, limit, &bbox,
@@ -819,6 +823,9 @@ int scene_arrange(struct scene *scn)
 		}
 		}
 	}
+	ret = scene_sync_bbox(scn);
+	if (ret)
+		return log_msg_ret("saf", ret);
 
 	return 0;
 }
@@ -1034,6 +1041,41 @@ int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox bbox[])
 	return 0;
 }
 
+int scene_sync_bbox(struct scene *scn)
+{
+	struct scene_obj *obj;
+
+	list_for_each_entry(obj, &scn->obj_head, sibling) {
+		int req_width = obj->req_bbox.x1 - obj->req_bbox.x0;
+		int req_height = obj->req_bbox.y1 - obj->req_bbox.y0;
+
+		if (obj->flags & SCENEOF_SYNC_POS) {
+			if (obj->flags & SCENEOF_SIZE_VALID) {
+				int width = obj->bbox.x1 - obj->bbox.x0;
+				int height = obj->bbox.y1 - obj->bbox.y0;
+
+				obj->bbox.x1 = obj->req_bbox.x0 + width;
+				obj->bbox.y1 = obj->req_bbox.y0 + height;
+			}
+			obj->bbox.x0 = obj->req_bbox.x0;
+			obj->bbox.y0 = obj->req_bbox.y0;
+		}
+
+		if (obj->flags & SCENEOF_SYNC_SIZE) {
+			obj->bbox.x1 = obj->bbox.x0 + req_width;
+			obj->bbox.y1 = obj->bbox.y0 + req_height;
+		}
+		if (obj->flags & SCENEOF_SYNC_WIDTH)
+			obj->bbox.x1 = obj->bbox.x0 + req_width;
+		if (obj->flags & SCENEOF_SYNC_BBOX)
+			obj->bbox = obj->req_bbox;
+		obj->flags &= ~(SCENEOF_SYNC_POS | SCENEOF_SYNC_SIZE |
+				SCENEOF_SYNC_WIDTH | SCENEOF_SYNC_BBOX);
+	}
+
+	return 0;
+}
+
 int scene_calc_dims(struct scene *scn)
 {
 	struct scene_obj *obj;
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index cca7c18e9f5..ba05e05d99a 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -112,6 +112,16 @@ int scene_obj_add(struct scene *scn, const char *name, uint id,
  */
 int scene_obj_flag_clrset(struct scene *scn, uint id, uint clr, uint set);
 
+/**
+ * scene_sync_bbox() - Apply any requested changes to object positions
+ *
+ * Updates each object's bbox to match the req_bbox using the SCENEOF_SYNC_...
+ * flags
+ *
+ * @scn: Scene to update
+ */
+int scene_sync_bbox(struct scene *scn);
+
 /**
  * scene_calc_dims() - Calculate the dimensions of the scene objects
  *
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index b33e0a7d3b4..54c20d3e137 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -102,8 +102,8 @@ static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
 		label = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
 
 		ret = scene_obj_set_pos(scn, menu->pointer_id,
-					menu->obj.bbox.x0 + menu->pointer_xofs,
-					label->bbox.y0);
+					menu->obj.req_bbox.x0 +
+					menu->pointer_xofs, label->req_bbox.y0);
 		if (ret < 0)
 			return log_msg_ret("ptr", ret);
 	}
@@ -238,8 +238,8 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	memset(dims, '\0', sizeof(dims));
 	scene_menu_calc_dims(scn, menu, dims);
 
-	startx = menu->obj.bbox.x0;
-	y = menu->obj.bbox.y0;
+	startx = menu->obj.req_bbox.x0;
+	y = menu->obj.req_bbox.y0;
 	if (menu->title_id) {
 		int width;
 
@@ -358,9 +358,8 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	if (sel_id)
 		menu_point_to_item(menu, sel_id);
 	menu->obj.dims.y = dims[SCENEBB_all].y;
-	menu->obj.bbox.x1 = menu->obj.bbox.x0 + menu->obj.dims.x;
-	menu->obj.bbox.y1 = menu->obj.bbox.y0 + menu->obj.dims.y;
-	menu->obj.flags |= SCENEOF_SIZE_VALID;
+	scene_obj_set_size(scn, menu->obj.id, menu->obj.dims.x,
+			   menu->obj.dims.y);
 
 	return 0;
 }
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 07711d147c3..e55db98ec30 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -93,16 +93,14 @@ int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	int x, y;
 	int ret;
 
-	x = tline->obj.bbox.x0;
-	y = tline->obj.bbox.y0;
+	x = tline->obj.req_bbox.x0;
+	y = tline->obj.req_bbox.y0;
 	if (tline->label_id) {
-		ret = scene_obj_set_pos(scn, tline->label_id,
-					tline->obj.bbox.x0, y);
+		ret = scene_obj_set_pos(scn, tline->label_id, x, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
-		ret = scene_obj_set_pos(scn, tline->edit_id,
-					tline->obj.bbox.x0 + 200, y);
+		ret = scene_obj_set_pos(scn, tline->edit_id, x + 200, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
diff --git a/include/expo.h b/include/expo.h
index 4a07a72cf7e..b67eb53b0c9 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -284,12 +284,20 @@ enum scene_obj_align {
  * can be selected)
  * @SCENEOF_SIZE_VALID: object's size (width/height) is valid, so any adjustment
  * to x0/y0 should maintain the width/height of the object
+ * @SCENEOF_SYNC_POS: object's position has changed
+ * @SCENEOF_SYNC_SIZE: object's size (width/height) has changed
+ * @SCENEOF_SYNC_WIDTH: object's widget has changed
+ * @SCENEOF_SYNC_BBOX: object's bounding box has changed
  */
 enum scene_obj_flags_t {
 	SCENEOF_HIDE	= 1 << 0,
 	SCENEOF_POINT	= 1 << 1,
 	SCENEOF_OPEN	= 1 << 2,
 	SCENEOF_SIZE_VALID	= BIT(3),
+	SCENEOF_SYNC_POS		= BIT(4),
+	SCENEOF_SYNC_SIZE	= BIT(5),
+	SCENEOF_SYNC_WIDTH	= BIT(6),
+	SCENEOF_SYNC_BBOX	= BIT(7),
 };
 
 enum {
@@ -304,7 +312,9 @@ enum {
  * @name: Name of the object (allocated)
  * @id: ID number of the object
  * @type: Type of this object
- * @bbox: Bounding box for this object
+ * @req_bbox: Requested bounding box for this object, synced to @bbox when scene is
+ * arranged
+ * @bbox: Bounding box for this object (internal use only)
  * @ofs: Offset from x0, y0 where the object is drawn (internal use only)
  * @dims: Dimensions of the text/image; may be smaller than bbox
  * (internal use only)
@@ -320,6 +330,7 @@ struct scene_obj {
 	char *name;
 	uint id;
 	enum scene_obj_t type;
+	struct scene_obj_bbox req_bbox;
 	struct scene_obj_bbox bbox;
 	struct scene_obj_offset ofs;
 	struct scene_obj_dims dims;
@@ -821,6 +832,9 @@ int scene_txted_set_font(struct scene *scn, uint id, const char *font_name,
 /**
  * scene_obj_set_pos() - Set the postion of an object
  *
+ * The given position is marked as 'requested' and will be applied when the
+ * scene is next arranged
+ *
  * @scn: Scene to update
  * @id: ID of object to update
  * @x: x position, in pixels from left side
@@ -832,6 +846,9 @@ int scene_obj_set_pos(struct scene *scn, uint id, int x, int y);
 /**
  * scene_obj_set_size() - Set the size of an object
  *
+ * The given size is marked as 'requested' and will be applied when the scene
+ * is next arranged
+ *
  * @scn: Scene to update
  * @id: ID of object to update
  * @w: width in pixels
@@ -843,6 +860,9 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h);
 /**
  * scene_obj_set_width() - Set the width of an object
  *
+ * The given width is marked as 'requested' and will be applied when the scene
+ * is next arranged
+ *
  * @scn: Scene to update
  * @id: ID of object to update
  * @w: width in pixels
@@ -853,6 +873,9 @@ int scene_obj_set_width(struct scene *scn, uint id, int w);
 /**
  * scene_obj_set_bbox() - Set the bounding box of an object
  *
+ * The given bounding box is marked as 'requested' and will be applied when the
+ * scene is next arranged
+ *
  * @scn: Scene to update
  * @id: ID of object to update
  * @x0: x position, in pixels from left side
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 517fb09d767..b97a04e1102 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -277,8 +277,8 @@ static int expo_object_attr(struct unit_test_state *uts)
 	ut_assert(id > 0);
 
 	ut_assertok(scene_obj_set_pos(scn, OBJ_LOGO, 123, 456));
-	ut_asserteq(123, img->obj.bbox.x0);
-	ut_asserteq(456, img->obj.bbox.y0);
+	ut_asserteq(123, img->obj.req_bbox.x0);
+	ut_asserteq(456, img->obj.req_bbox.y0);
 
 	ut_asserteq(-ENOENT, scene_obj_set_pos(scn, OBJ_TEXT2, 0, 0));
 
@@ -367,8 +367,8 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(0, menu->pointer_id);
 
 	ut_assertok(scene_obj_set_pos(scn, OBJ_MENU, 50, 400));
-	ut_asserteq(50, menu->obj.bbox.x0);
-	ut_asserteq(400, menu->obj.bbox.y0);
+	ut_asserteq(50, menu->obj.req_bbox.x0);
+	ut_asserteq(400, menu->obj.req_bbox.y0);
 
 	id = scene_txt_str(scn, "title", OBJ_MENU_TITLE, STR_MENU_TITLE,
 			   "Main Menu", &tit);
@@ -660,12 +660,12 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(400 + 160, obj->bbox.y1);
 
 	scene_obj_set_width(scn, OBJ_MENU, 170);
-	ut_asserteq(50 + 170, obj->bbox.x1);
+	ut_asserteq(50 + 170, obj->req_bbox.x1);
 	scene_obj_set_bbox(scn, OBJ_MENU, 60, 410, 50 + 160, 400 + 160);
-	ut_asserteq(60, obj->bbox.x0);
-	ut_asserteq(410, obj->bbox.y0);
-	ut_asserteq(50 + 160, obj->bbox.x1);
-	ut_asserteq(400 + 160, obj->bbox.y1);
+	ut_asserteq(60, obj->req_bbox.x0);
+	ut_asserteq(410, obj->req_bbox.y0);
+	ut_asserteq(50 + 160, obj->req_bbox.x1);
+	ut_asserteq(400 + 160, obj->req_bbox.y1);
 
 	/* reset back to normal */
 	scene_obj_set_bbox(scn, OBJ_MENU, 50, 400, 50 + 160, 400 + 160);
-- 
2.43.0

