Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D537FC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:13:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 10B4E82115;
	Fri, 28 Mar 2025 14:08:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="oMxCYNoy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8C0D18212B; Fri, 28 Mar 2025 14:08:23 +0100 (CET)
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com
 [IPv6:2607:f8b0:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C5D48210A
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:20 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x130.google.com with SMTP id
 e9e14a558f8ab-3cfc8772469so7348815ab.3
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167298; x=1743772098; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wZY670AVb44QhjFm3xErYxYouAlWfvVBeDwopmFZqwQ=;
 b=oMxCYNoyYmFiAICNVfwngc/+1SbsOnSodIPsPp+AfLkoacGAXN6U2Ddb5NM4k+Z9Cq
 ryCzjgtLiF/Rhu9JUpwP9u4CKBUssm/h00dnb7QDrbfkAnmUk2o2tYiLgFpkGNjNSuC/
 3KE4jE2wl2X0ZzY1XPFoTebQpPJG2MHXVR4Z4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167298; x=1743772098;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wZY670AVb44QhjFm3xErYxYouAlWfvVBeDwopmFZqwQ=;
 b=roCH/t5J/rulNdXuhSvkDoe5pofy9jdjcDbfbZNjB3DZbSPrrPgjtmMwmIRfaUjAi/
 ZvOH0rvvgILnh0eEvWxKhDYY45cSJyItMJrp0UwKlkR+YjjoPxrKHD8bwg3hWDlB2CqH
 XhAbicbcthWqVU1hNL77T2N2q3VxYKNy5dZJXQ0RqZOKbpts64Fmx17cv2q7BhAmHQLZ
 CXe90LU01LZqPE35TC+1g+j0NLB7+qPNUSOLZjIVHHgvTV7Wsiwa2se9MSszHLkAtSTd
 c9ncsUWyyjcVlOw73HvAZhK7BJ+anF4l9l9MemScXxtWm2ZHjukcAdJqR/ai0+LpD3kq
 dAdw==
X-Gm-Message-State: AOJu0YwGy34cNPOO67xYxX4UHZ3XRmgtqFT4X5XalkjSNDVqQFIQPorl
 IPoj73HxdhabdI0btssOKci2yvTyLhJpWgLn6zXCGR+yrOyp4G/MVpnx8mC4VhiJXs1xA4RVj1Y
 =
X-Gm-Gg: ASbGnctXVLWsX+ebNDOY2GNLsO2cUlf89IayWXBZJuerRo1TnOwRCDMX/p+h6WCgAaE
 3lFiQbafDE/Nel5Rp6leuBse5uyWkZPq21jFcfWixfaODCmg/xbE55EPEBT2yAIpxNB5gAlynk5
 Asj0Ifh3IYCaDGnyQpwQjYYFTBvNODrQIMxPJYzVMfZNnWDZs7uk106Z1QH34vn97BOYW4P3xcd
 H0PJxJNLQJZ9P+mpu2nwWkdlmpU0NdnhtiEmSYM9ODUIu11dcvDQKnsM01q0Q87zzVj1crD2V2V
 DD2RRtDXYb4HwTr4keeZXETNWrGMV4uzRud9B/CE+KAzC9qO14BNKSSY0xDcqxZoP83SvD1yBnc
 PkVl3EA==
X-Google-Smtp-Source: AGHT+IEy5ArIOXkEdr+3Wsc0OAnxYA7lN3lLu9wUkKu8D3DFyBqxSdGqx9DCNa/Iy+X77DqKmxg2pQ==
X-Received: by 2002:a05:6e02:2585:b0:3d2:6768:c4fa with SMTP id
 e9e14a558f8ab-3d5cce244afmr90308375ab.21.1743167297493; 
 Fri, 28 Mar 2025 06:08:17 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 32/56] expo: Make bounding-box calculation more flexible
Date: Fri, 28 Mar 2025 07:06:19 -0600
Message-ID: <20250328130713.2612648-33-sjg@chromium.org>
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

In some cases it is useful to obtain more than just two bounding boxes
from a menu, e.g. to line up all descriptions vertically.

Use an array to obtain bounding-box information and calculate it
separately for each item.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c          | 61 ++++++++++++++++++++++++--------------
 boot/scene_internal.h | 46 ++++++++++++++++++++++++-----
 boot/scene_menu.c     | 69 +++++++++++++++++++++++++++----------------
 3 files changed, 121 insertions(+), 55 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index ff6712a0db6..6142d2b736d 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -326,9 +326,9 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
  */
 static void scene_render_background(struct scene_obj *obj, bool box_only)
 {
+	struct vidconsole_bbox bbox[SCENEBB_count], *sel;
 	struct expo *exp = obj->scene->expo;
 	const struct expo_theme *theme = &exp->theme;
-	struct vidconsole_bbox bbox, label_bbox;
 	struct udevice *dev = exp->display;
 	struct video_priv *vid_priv;
 	struct udevice *cons = exp->cons;
@@ -347,17 +347,20 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 	}
 
 	/* see if this object wants to render a background */
-	if (scene_obj_calc_bbox(obj, &bbox, &label_bbox))
+	if (scene_obj_calc_bbox(obj, bbox))
+		return;
+
+	sel = &bbox[SCENEBB_label];
+	if (!sel->valid)
 		return;
 
 	vidconsole_push_colour(cons, fore, back, &old);
-	video_fill_part(dev, label_bbox.x0 - inset, label_bbox.y0 - inset,
-			label_bbox.x1 + inset, label_bbox.y1 + inset,
+	video_fill_part(dev, sel->x0 - inset, sel->y0 - inset,
+			sel->x1 + inset, sel->y1 + inset,
 			vid_priv->colour_fg);
 	vidconsole_pop_colour(cons, &old);
 	if (box_only) {
-		video_fill_part(dev, label_bbox.x0, label_bbox.y0,
-				label_bbox.x1, label_bbox.y1,
+		video_fill_part(dev, sel->x0, sel->y0, sel->x1, sel->y1,
 				vid_priv->colour_bg);
 	}
 }
@@ -730,8 +733,7 @@ int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 	return 0;
 }
 
-int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox,
-			struct vidconsole_bbox *label_bbox)
+int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox bbox[])
 {
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
@@ -741,14 +743,15 @@ int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox,
 	case SCENEOBJT_MENU: {
 		struct scene_obj_menu *menu = (struct scene_obj_menu *)obj;
 
-		scene_menu_calc_bbox(menu, bbox, label_bbox);
+		scene_menu_calc_bbox(menu, bbox);
 		break;
 	}
 	case SCENEOBJT_TEXTLINE: {
 		struct scene_obj_textline *tline;
 
 		tline = (struct scene_obj_textline *)obj;
-		scene_textline_calc_bbox(tline, bbox, label_bbox);
+		scene_textline_calc_bbox(tline, &bbox[SCENEBB_all],
+					 &bbox[SCENEBB_label]);
 		break;
 	}
 	}
@@ -916,28 +919,42 @@ int scene_iter_objs(struct scene *scn, expo_scene_obj_iterator iter,
 	return 0;
 }
 
+int scene_bbox_join(const struct vidconsole_bbox *src, int inset,
+		    struct vidconsole_bbox *dst)
+{
+	if (dst->valid) {
+		dst->x0 = min(dst->x0, src->x0 - inset);
+		dst->y0 = min(dst->y0, src->y0);
+		dst->x1 = max(dst->x1, src->x1 + inset);
+		dst->y1 = max(dst->y1, src->y1);
+	} else {
+		dst->x0 = src->x0 - inset;
+		dst->y0 = src->y0;
+		dst->x1 = src->x1 + inset;
+		dst->y1 = src->y1;
+		dst->valid = true;
+	}
+
+	return 0;
+}
+
 int scene_bbox_union(struct scene *scn, uint id, int inset,
 		     struct vidconsole_bbox *bbox)
 {
 	struct scene_obj *obj;
+	struct vidconsole_bbox local;
 
 	if (!id)
 		return 0;
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("obj", -ENOENT);
-	if (bbox->valid) {
-		bbox->x0 = min(bbox->x0, obj->bbox.x0 - inset);
-		bbox->y0 = min(bbox->y0, obj->bbox.y0);
-		bbox->x1 = max(bbox->x1, obj->bbox.x1 + inset);
-		bbox->y1 = max(bbox->y1, obj->bbox.y1);
-	} else {
-		bbox->x0 = obj->bbox.x0 - inset;
-		bbox->y0 = obj->bbox.y0;
-		bbox->x1 = obj->bbox.x1 + inset;
-		bbox->y1 = obj->bbox.y1;
-		bbox->valid = true;
-	}
+	local.x0 = obj->bbox.x0;
+	local.y0 = obj->bbox.y0;
+	local.x1 = obj->bbox.x1;
+	local.y1 = obj->bbox.y1;
+	local.valid = true;
+	scene_bbox_join(&local, inset, bbox);
 
 	return 0;
 }
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index ec9008ea593..ac2a36d6e4d 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -13,6 +13,27 @@ struct vidconsole_bbox;
 
 typedef int (*expo_scene_obj_iterator)(struct scene_obj *obj, void *priv);
 
+/**
+ * enum scene_bbox_t - Parts of an object which can have a bounding box
+ *
+ * Objects can provide any or all of these bounding boxes
+ *
+ * @SCENEBB_label: Menu-item label
+ * @SCENEBB_key: Menu-item key label
+ * @SCENEBB_desc: Menu-item Description
+ * @SCENEBB_curitem: Current item (pointed to)
+ * @SCENEBB_all: All the above objects combined
+ */
+enum scene_bbox_t {
+	SCENEBB_label,
+	SCENEBB_key,
+	SCENEBB_desc,
+	SCENEBB_curitem,
+	SCENEBB_all,
+
+	SCENEBB_count,
+};
+
 /**
  * expo_lookup_scene_id() - Look up a scene ID
  *
@@ -291,6 +312,19 @@ struct scene_menitem *scene_menuitem_find_seq(const struct scene_obj_menu *menu,
 struct scene_menitem *scene_menuitem_find_val(const struct scene_obj_menu *menu,
 					      int val);
 
+/**
+ * scene_bbox_join() - update bouding box with a given src box
+ *
+ * Updates @dst so that it encompasses the bounding box @src
+ *
+ * @src: Input bounding box
+ * @inset: Amount of inset to use for width
+ * @dst: Bounding box to update
+ * Return: 0 if OK, -ve on error
+ */
+int scene_bbox_join(const struct vidconsole_bbox *src, int inset,
+		    struct vidconsole_bbox *dst);
+
 /**
  * scene_bbox_union() - update bouding box with the demensions of an object
  *
@@ -319,13 +353,11 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline);
  * scene_menu_calc_bbox() - Calculate bounding boxes for the menu
  *
  * @menu: Menu to process
- * @bbox: Returns bounding box of menu including prompts
- * @label_bbox: Returns bounding box of labels
+ * @bbox: List of bounding box to fill in
  * Return: 0 if OK, -ve on error
  */
 void scene_menu_calc_bbox(struct scene_obj_menu *menu,
-			  struct vidconsole_bbox *bbox,
-			  struct vidconsole_bbox *label_bbox);
+			  struct vidconsole_bbox *bbox);
 
 /**
  * scene_textline_calc_bbox() - Calculate bounding box for the textline
@@ -343,12 +375,10 @@ void scene_textline_calc_bbox(struct scene_obj_textline *menu,
  * scene_obj_calc_bbox() - Calculate bounding boxes for an object
  *
  * @obj: Object to process
- * @bbox: Returns bounding box of object including prompts
- * @label_bbox: Returns bounding box of labels (active area)
+ * @bbox: Returns bounding boxes for object
  * Return: 0 if OK, -ve on error
  */
-int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox,
-			struct vidconsole_bbox *label_bbox);
+int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox *bbox);
 
 /**
  * scene_textline_open() - Open a textline object
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 490fb42995c..3df3c6ed1d8 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -132,55 +132,74 @@ static int menu_point_to_item(struct scene_obj_menu *menu, uint item_id)
 }
 
 void scene_menu_calc_bbox(struct scene_obj_menu *menu,
-			  struct vidconsole_bbox *bbox,
-			  struct vidconsole_bbox *label_bbox)
+			  struct vidconsole_bbox *bbox)
 {
 	const struct expo_theme *theme = &menu->obj.scene->expo->theme;
 	const struct scene_menitem *item;
+	int inset = theme->menu_inset;
+	int i;
 
-	bbox->valid = false;
-	scene_bbox_union(menu->obj.scene, menu->title_id, 0, bbox);
+	for (i = 0; i < SCENEBB_count; i++)
+		bbox[i].valid = false;
 
-	label_bbox->valid = false;
+	scene_bbox_union(menu->obj.scene, menu->title_id, 0,
+			 &bbox[SCENEBB_all]);
 
 	list_for_each_entry(item, &menu->item_head, sibling) {
-		scene_bbox_union(menu->obj.scene, item->label_id,
-				 theme->menu_inset, bbox);
-		scene_bbox_union(menu->obj.scene, item->key_id, 0, bbox);
-		scene_bbox_union(menu->obj.scene, item->desc_id, 0, bbox);
-		scene_bbox_union(menu->obj.scene, item->preview_id, 0, bbox);
-
-		/* Get the bounding box of all labels */
-		scene_bbox_union(menu->obj.scene, item->label_id,
-				 theme->menu_inset, label_bbox);
+		struct vidconsole_bbox local;
+
+		local.valid = false;
+		scene_bbox_union(menu->obj.scene, item->label_id, inset,
+				 &local);
+		scene_bbox_union(menu->obj.scene, item->key_id, 0, &local);
+		scene_bbox_union(menu->obj.scene, item->desc_id, 0, &local);
+		scene_bbox_union(menu->obj.scene, item->preview_id, 0, &local);
+
+		scene_bbox_join(&local, 0, &bbox[SCENEBB_all]);
+
+		/* Get the bounding box of all individual fields */
+		scene_bbox_union(menu->obj.scene, item->label_id, inset,
+				 &bbox[SCENEBB_label]);
+		scene_bbox_union(menu->obj.scene, item->key_id, inset,
+				 &bbox[SCENEBB_key]);
+		scene_bbox_union(menu->obj.scene, item->desc_id, inset,
+				 &bbox[SCENEBB_desc]);
+
+		if (menu->cur_item_id == item->id)
+			scene_bbox_join(&local, 0, &bbox[SCENEBB_curitem]);
 	}
 
 	/*
-	 * subtract the final menuitem's gap to keep the insert the same top
-	 * and bottom
+	 * subtract the final menuitem's gap to keep the inset the same top and
+	 * bottom
 	 */
-	label_bbox->y1 -= theme->menuitem_gap_y;
+	bbox[SCENEBB_label].y1 -= theme->menuitem_gap_y;
 }
 
 int scene_menu_calc_dims(struct scene_obj_menu *menu)
 {
-	struct vidconsole_bbox bbox, label_bbox;
+	struct vidconsole_bbox bbox[SCENEBB_count], *cur;
 	const struct scene_menitem *item;
 
-	scene_menu_calc_bbox(menu, &bbox, &label_bbox);
+	scene_menu_calc_bbox(menu, bbox);
 
 	/* Make all labels the same size */
-	if (label_bbox.valid) {
+	cur = &bbox[SCENEBB_label];
+	if (cur->valid) {
 		list_for_each_entry(item, &menu->item_head, sibling) {
 			scene_obj_set_size(menu->obj.scene, item->label_id,
-					   label_bbox.x1 - label_bbox.x0,
-					   label_bbox.y1 - label_bbox.y0);
+					   cur->x1 - cur->x0,
+					   cur->y1 - cur->y0);
 		}
 	}
 
-	if (bbox.valid) {
-		menu->obj.dims.x = bbox.x1 - bbox.x0;
-		menu->obj.dims.y = bbox.y1 - bbox.y0;
+	cur = &bbox[SCENEBB_all];
+	if (cur->valid) {
+		menu->obj.dims.x = cur->x1 - cur->x0;
+		menu->obj.dims.y = cur->y1 - cur->y0;
+
+		menu->obj.bbox.x1 = cur->x1;
+		menu->obj.bbox.y1 = cur->y1;
 	}
 
 	return 0;
-- 
2.43.0

