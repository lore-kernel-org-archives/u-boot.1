Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 756B0C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:59:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C9CF82125;
	Wed, 19 Mar 2025 15:56:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FDfHZyqP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3EC9481F54; Wed, 19 Mar 2025 15:56:21 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0882E820F5
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfb6e9031so41218655e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396178; x=1743000978; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F714368BMgS8JUci0P+1FTfFsoZQtJWGh+7tNdmLRR0=;
 b=FDfHZyqPyPXpq2aJ7qMn0bc/wovGzQqt69Dg7roZ9qIO+mIe7mHcDChpbXJZXpH4r4
 BWCmkvY3MLh19oHCgHDDAiSDn4r7agNpnt9Cr3l5f/nPvuS+3TlFYOCZMDsR/zN56e8x
 TKQxz+xTlR7ybXzXDYt3ciq64BMDwsBReAOKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396178; x=1743000978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=F714368BMgS8JUci0P+1FTfFsoZQtJWGh+7tNdmLRR0=;
 b=YGXMDq+KoaFDbxqVkhjbpViMJdcPNoxmqNElbz/AIhIiOSQlsmUdFvdfzlliaSbnXE
 mOFjwOOrbgZ0Z5FidDz2OHBeBReBrNS8CKzcDWN/A1R8fDPQbdO//J87Cup3EGz0+bf9
 AuthcbxcDvvcTBE0ufUmEYmWg7a7MbrIUKfG18D/MyW/LpKxLgqL+mFjwnsUpD6Drv3d
 eXgUm0mzP/tY+/IbKFmGzVOphJJ8yxPFA1Iur+3qsnZfPOndRu5DUBgSQ5Reto4HAGYV
 zJIiRBLnbg040t7oCL14dS0J7n0tu9wYRIRo/JN20u98SAqiyQAIdadge7QwqQ9+Rd7A
 BVQQ==
X-Gm-Message-State: AOJu0Yyt43ZGImkvy3LzCmaPYcfxufSYtzrWKQ1rb059bHuEJG3pMKvZ
 ZvjyAZ0e2iC7WYaD2hksV/SvdjZu2WvW8wnELY8tkUKwVyagKADwE2PIEhez8vpHt9FvFGidN70
 =
X-Gm-Gg: ASbGnctVKqTgdoDFuu1R+Ebw2SRs1TWKZxiALDy1AvZoAOUkBuSqdtFgLIpTh2lcRQ1
 8uhxwJ5JjQv85/fcgywxfvTdvk7uI6EPewENtYSp5y1x6qRwmt5logQWUrM9Y99RwSjD+WVrNXU
 Hm1xbMuHZsKvHGXqFrVxJR0ro4Ixkwf9ig7gxP+l8H9X3U4Mntxy4EvpD7Wnw2q9OrjtHr+FDuG
 Mff9b+raVM8tCLmPesx5Ic9kj6xQcYPe3ygOEkmEjH0+tO0NVIhSjeunNFWsWwXeaVDZ18KP0tG
 VW+8sWk5R8NmtARzJlhXzU+ykellxJeMM+BLIquzSQ==
X-Google-Smtp-Source: AGHT+IFgeEQIO4fN+YSMi/Bxs7H0HB0cVuQX1MePrXnV0hA5y5mZiEv7NRBihYUImU137MRAZKGphg==
X-Received: by 2002:a05:6000:1889:b0:391:a43:8bbd with SMTP id
 ffacd0b85a97d-399739c2929mr3831528f8f.21.1742396177831; 
 Wed, 19 Mar 2025 07:56:17 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 27/52] expo: Separate dimensions from the bounding box
Date: Wed, 19 Mar 2025 15:54:32 +0100
Message-ID: <20250319145512.2391122-28-sjg@chromium.org>
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

At present each object has a width and height and the bounding box is
implicit in that.

This is not flexible enough to handle objects which are larger than
their contents might need. For example, when centring a text object we
might want to have it stretch across the whole width of the display even
if the text itself does not need that much space.

Create a new 'dimensions' field and convert the existing width/height
into x1/y1 coordinates.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 31 +++++++++++++++++++++----------
 boot/scene_menu.c     |  7 +++++--
 boot/scene_textline.c | 18 ++++++++++++------
 include/expo.h        | 31 ++++++++++++++++++++++++++-----
 test/boot/expo.c      | 20 ++++++++++----------
 5 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 75b1e4faba5..ff6712a0db6 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -207,12 +207,17 @@ int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 {
 	struct scene_obj *obj;
+	int w, h;
 
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
+	w = obj->bbox.x1 - obj->bbox.x0;
+	h = obj->bbox.y1 - obj->bbox.y0;
 	obj->bbox.x0 = x;
 	obj->bbox.y0 = y;
+	obj->bbox.x1 = obj->bbox.x0 + w;
+	obj->bbox.y1 = obj->bbox.y0 + h;
 
 	return 0;
 }
@@ -224,8 +229,9 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->bbox.w = w;
-	obj->bbox.h = h;
+	obj->bbox.x1 = obj->bbox.x0 + w;
+	obj->bbox.y1 = obj->bbox.y0 + h;
+	obj->flags |= SCENEOF_SIZE_VALID;
 
 	return 0;
 }
@@ -420,8 +426,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 			if (obj->flags & SCENEOF_POINT) {
 				vidconsole_push_colour(cons, fore, back, &old);
 				video_fill_part(dev, x - theme->menu_inset, y,
-						x + obj->bbox.w,
-						y + obj->bbox.h,
+						obj->bbox.x1,
+						obj->bbox.y1,
 						vid_priv->colour_bg);
 			}
 			vidconsole_set_cursor_pos(cons, x, y);
@@ -766,8 +772,13 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 				ret = scene_obj_get_hw(scn, obj->id, &width);
 				if (ret < 0)
 					return log_msg_ret("get", ret);
-				obj->bbox.w = width;
-				obj->bbox.h = ret;
+				obj->dims.x = width;
+				obj->dims.y = ret;
+				if (!(obj->flags & SCENEOF_SIZE_VALID)) {
+					obj->bbox.x1 = obj->bbox.x0 + width;
+					obj->bbox.y1 = obj->bbox.y0 + ret;
+					obj->flags |= SCENEOF_SIZE_VALID;
+				}
 			}
 			break;
 		}
@@ -918,13 +929,13 @@ int scene_bbox_union(struct scene *scn, uint id, int inset,
 	if (bbox->valid) {
 		bbox->x0 = min(bbox->x0, obj->bbox.x0 - inset);
 		bbox->y0 = min(bbox->y0, obj->bbox.y0);
-		bbox->x1 = max(bbox->x1, obj->bbox.x0 + obj->bbox.w + inset);
-		bbox->y1 = max(bbox->y1, obj->bbox.y0 + obj->bbox.h);
+		bbox->x1 = max(bbox->x1, obj->bbox.x1 + inset);
+		bbox->y1 = max(bbox->y1, obj->bbox.y1);
 	} else {
 		bbox->x0 = obj->bbox.x0 - inset;
 		bbox->y0 = obj->bbox.y0;
-		bbox->x1 = obj->bbox.x0 + obj->bbox.w + inset;
-		bbox->y1 = obj->bbox.y0 + obj->bbox.h;
+		bbox->x1 = obj->bbox.x1 + inset;
+		bbox->y1 = obj->bbox.y1;
 		bbox->valid = true;
 	}
 
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 00bbf9a3849..490fb42995c 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -179,8 +179,8 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 	}
 
 	if (bbox.valid) {
-		menu->obj.bbox.w = bbox.x1 - bbox.x0;
-		menu->obj.bbox.h = bbox.y1 - bbox.y0;
+		menu->obj.dims.x = bbox.x1 - bbox.x0;
+		menu->obj.dims.y = bbox.y1 - bbox.y0;
 	}
 
 	return 0;
@@ -288,6 +288,9 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 
 	if (sel_id)
 		menu_point_to_item(menu, sel_id);
+	menu->obj.bbox.x1 = menu->obj.bbox.x0 + menu->obj.dims.x;
+	menu->obj.bbox.y1 = menu->obj.bbox.y0 + menu->obj.dims.y;
+	menu->obj.flags |= SCENEOF_SIZE_VALID;
 
 	return 0;
 }
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 2ffeffeb5f5..b5cb26e3fc6 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -62,7 +62,8 @@ void scene_textline_calc_bbox(struct scene_obj_textline *tline,
 
 int scene_textline_calc_dims(struct scene_obj_textline *tline)
 {
-	struct scene *scn = tline->obj.scene;
+	struct scene_obj *obj = &tline->obj;
+	struct scene *scn = obj->scene;
 	struct vidconsole_bbox bbox;
 	struct scene_obj_txt *txt;
 	int ret;
@@ -77,11 +78,16 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
 		return log_msg_ret("nom", ret);
 
 	if (bbox.valid) {
-		tline->obj.bbox.w = bbox.x1 - bbox.x0;
-		tline->obj.bbox.h = bbox.y1 - bbox.y0;
-
-		scene_obj_set_size(scn, tline->edit_id, tline->obj.bbox.w,
-				   tline->obj.bbox.h);
+		obj->dims.x = bbox.x1 - bbox.x0;
+		obj->dims.y = bbox.y1 - bbox.y0;
+		if (!(obj->flags & SCENEOF_SIZE_VALID)) {
+			obj->bbox.x1 = obj->bbox.x0 + obj->dims.x;
+			obj->bbox.y1 = obj->bbox.y0 + obj->dims.x;
+			obj->flags |= SCENEOF_SIZE_VALID;
+		}
+		scene_obj_set_size(scn, tline->edit_id,
+				   obj->bbox.x1 - obj->bbox.x0,
+				   obj->bbox.y1 - obj->bbox.y0);
 	}
 
 	return 0;
diff --git a/include/expo.h b/include/expo.h
index b6de0310071..6f0547a4b38 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -9,6 +9,7 @@
 
 #include <abuf.h>
 #include <dm/ofnode_decl.h>
+#include <linux/bitops.h>
 #include <linux/list.h>
 
 struct udevice;
@@ -196,14 +197,29 @@ enum scene_obj_t {
  *
  * @x0: x position, in pixels from left side
  * @y0: y position, in pixels from top
- * @w: width, in pixels
- * @h: height, in pixels
+ * @x1: x position of right size
+ * @y1: y position of bottom
  */
 struct scene_obj_bbox {
 	int x0;
 	int y0;
-	int w;
-	int h;
+	int x1;
+	int y1;
+};
+
+/**
+ * struct scene_obj_dims - Dimensions of the object being drawn
+ *
+ * Image and text objects have a dimension which can change depending on what
+ * they contain. For images this stores the size. For text it stores the size as
+ * rendered on the display
+ *
+ * @x: x dimension
+ * @y: y dimension
+ */
+struct scene_obj_dims {
+	int x;
+	int y;
 };
 
 /**
@@ -213,11 +229,14 @@ struct scene_obj_bbox {
  * @SCENEOF_POINT: object should be highlighted
  * @SCENEOF_OPEN: object should be opened (e.g. menu is opened so that an option
  * can be selected)
+ * @SCENEOF_SIZE_VALID: object's size (width/height) is valid, so any adjustment
+ * to x0/y0 should maintain the width/height of the object
  */
 enum scene_obj_flags_t {
 	SCENEOF_HIDE	= 1 << 0,
 	SCENEOF_POINT	= 1 << 1,
 	SCENEOF_OPEN	= 1 << 2,
+	SCENEOF_SIZE_VALID	= BIT(3),
 };
 
 enum {
@@ -232,7 +251,8 @@ enum {
  * @name: Name of the object (allocated)
  * @id: ID number of the object
  * @type: Type of this object
- * @bbox: Dimensions for this object
+ * @bbox: Bounding box for this object
+ * @dims: Dimensions of the text/image (may be smaller than bbox)
  * @flags: Flags for this object
  * @bit_length: Number of bits used for this object in CMOS RAM
  * @start_bit: Start bit to use for this object in CMOS RAM
@@ -244,6 +264,7 @@ struct scene_obj {
 	uint id;
 	enum scene_obj_t type;
 	struct scene_obj_bbox bbox;
+	struct scene_obj_dims dims;
 	u8 flags;
 	u8 bit_length;
 	u16 start_bit;
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 9c940825278..94c13e9b71f 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -550,39 +550,39 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertnonnull(obj);
 	ut_asserteq(400, obj->bbox.x0);
 	ut_asserteq(100, obj->bbox.y0);
-	ut_asserteq(126, obj->bbox.w);
-	ut_asserteq(40, obj->bbox.h);
+	ut_asserteq(400 + 126, obj->bbox.x1);
+	ut_asserteq(100 + 40, obj->bbox.y1);
 
 	/* check dimensions of image */
 	obj = scene_obj_find(scn, OBJ_LOGO, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(20, obj->bbox.y0);
-	ut_asserteq(160, obj->bbox.w);
-	ut_asserteq(160, obj->bbox.h);
+	ut_asserteq(50 + 160, obj->bbox.x1);
+	ut_asserteq(20 + 160, obj->bbox.y1);
 
 	/* check dimensions of menu labels - both should be the same width */
 	obj = scene_obj_find(scn, ITEM1_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(436, obj->bbox.y0);
-	ut_asserteq(29, obj->bbox.w);
-	ut_asserteq(18, obj->bbox.h);
+	ut_asserteq(50 + 29, obj->bbox.x1);
+	ut_asserteq(436 + 18, obj->bbox.y1);
 
 	obj = scene_obj_find(scn, ITEM2_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(454, obj->bbox.y0);
-	ut_asserteq(29, obj->bbox.w);
-	ut_asserteq(18, obj->bbox.h);
+	ut_asserteq(50 + 29, obj->bbox.x1);
+	ut_asserteq(454 + 18, obj->bbox.y1);
 
 	/* check dimensions of menu */
 	obj = scene_obj_find(scn, OBJ_MENU, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(400, obj->bbox.y0);
-	ut_asserteq(160, obj->bbox.w);
-	ut_asserteq(160, obj->bbox.h);
+	ut_asserteq(50 + 160, obj->bbox.x1);
+	ut_asserteq(400 + 160, obj->bbox.y1);
 
 	/* render it */
 	expo_set_scene_id(exp, SCENE1);
-- 
2.43.0

