Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F19CC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:12:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 30BFC820E2;
	Fri, 28 Mar 2025 14:08:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ef3Kj7lw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11AF3820E2; Fri, 28 Mar 2025 14:08:15 +0100 (CET)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6426D82093
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8f8so186472639f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167290; x=1743772090; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=47ykm3aTZq5Ei0GmE37IBQeDkokqScLdzxMKv1xzdMw=;
 b=Ef3Kj7lwqmS/pc8DlA/5kLkV56ZaTfZ4tVB1ovl4BtjlL8n9Jw7k87jFvMW07nfd0Z
 PrvQGaTeORitzHubwIgq+tUjJTNveVCMRR+2HNPVtpdm/rGIEFMaP//MpAbgTI1guTu2
 A/3Yf9yVMESP9zfyabgI7RtfjJurc6+yJ7UIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167290; x=1743772090;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=47ykm3aTZq5Ei0GmE37IBQeDkokqScLdzxMKv1xzdMw=;
 b=ICwBADTkd8iKwCGbm0LdLQ01SvQ2CoYBUWc7TMSWjJ03S0bsH6umkbOF/YW4TDU7iP
 eD1d9oOL43jXv/RyA3se1DbiLXSyyd1P2AKj32JzvaDTojSJzFXFL4r1Tsi/1jEdeuNs
 dldSLh8eu3JkdhjVlg23WlNuK5VIVJCmkSY96u4VjQutiix3eLUUcOOBoKxGwbsuV1mi
 OF3FIJIFnAxCZgbOpuzoNPgnYQzUA8vez1NbBsfsZFOPgIW6VjQJ/8EV31aAQ6AZc0yV
 34MkTkX4DHj3W1QLu708SorfqQrkqNvK9MdZixmoDuHb2JtDZDWgHu1Vdr46dpw6B3ES
 zQ5g==
X-Gm-Message-State: AOJu0Yww1C/aWhdFdrcarbpet8kzenwMx0odV7l96Y9A4sFoRl9MpeY3
 le8K+XMXpR3Ey0m4d1hlP1BXQBVsggto3FlvEPu7Ob7SoAwayhZgqi6SvA9UZKRcbKmZnRaDp8M
 =
X-Gm-Gg: ASbGncudMq65vZBklxWsXpJlGm8wnUzeIqaAhjItxvIV/5Vg02Cy+31rEh5uWAVwKpq
 n7kYvd++N3GLxT2JediqnoDrrzIngrHd8LDD4pPTp7iwrRbadojpNyfpFheO+MGKUEhIxWm09er
 kCFDBMhXuzWCKrU6qoQsRw44WV0XyKo3dq4Bg4EbYvFN9p/Npts7Gm9kKcO7WU3KfnsLO+K2FW5
 9PwYGDw35uqIfqe6LMh5CQs7NAbkFpKUkU9hjMAOfKntPKv+MjJY8W74/Nfgp5ER9KK5PzClHSB
 UrwY5OAPQsQDPQfgZOtzT4h25NNU8x68fo+Ivpk0uRVe2bz3Qr5ihBCEPJCLUqr9S1pZHIUtRV7
 o/A8G0g==
X-Google-Smtp-Source: AGHT+IGnOWLtyqC8P21fdAsYc6Tqic370Pu5ikX39knXb0bzB9L2HsuSonN6hZKYSm0u6V3wLwWmog==
X-Received: by 2002:a05:6602:3805:b0:85c:5521:cbfe with SMTP id
 ca18e2360f4ac-85e820b931fmr790378839f.8.1743167289830; 
 Fri, 28 Mar 2025 06:08:09 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:08 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 28/56] expo: Rename scene_dim to scene_obj_bbox
Date: Fri, 28 Mar 2025 07:06:15 -0600
Message-ID: <20250328130713.2612648-29-sjg@chromium.org>
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

At present we assume that each object is a simple box and that it fills
the whole box.

This is quite limiting for text objects, which we may want to centre
within the box. We need a position within the box where drawing starts.

Rename the scene_dim struct to indicate that it is a bounding box.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c          | 36 +++++++++++-----------
 boot/scene_menu.c     | 12 ++++----
 boot/scene_textline.c | 22 ++++++-------
 include/expo.h        |  8 ++---
 test/boot/expo.c      | 72 +++++++++++++++++++++----------------------
 5 files changed, 75 insertions(+), 75 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index fb82ffe768c..fbc6f783257 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -211,8 +211,8 @@ int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->dim.x = x;
-	obj->dim.y = y;
+	obj->bbox.x = x;
+	obj->bbox.y = y;
 
 	return 0;
 }
@@ -224,8 +224,8 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->dim.w = w;
-	obj->dim.h = h;
+	obj->bbox.w = w;
+	obj->bbox.h = h;
 
 	return 0;
 }
@@ -369,8 +369,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	struct udevice *cons = text_mode ? NULL : exp->cons;
 	int x, y, ret;
 
-	x = obj->dim.x;
-	y = obj->dim.y;
+	x = obj->bbox.x;
+	y = obj->bbox.y;
 
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
@@ -420,8 +420,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 			if (obj->flags & SCENEOF_POINT) {
 				vidconsole_push_colour(cons, fore, back, &old);
 				video_fill_part(dev, x - theme->menu_inset, y,
-						x + obj->dim.w,
-						y + obj->dim.h,
+						x + obj->bbox.w,
+						y + obj->bbox.h,
 						vid_priv->colour_bg);
 			}
 			vidconsole_set_cursor_pos(cons, x, y);
@@ -766,8 +766,8 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 				ret = scene_obj_get_hw(scn, obj->id, &width);
 				if (ret < 0)
 					return log_msg_ret("get", ret);
-				obj->dim.w = width;
-				obj->dim.h = ret;
+				obj->bbox.w = width;
+				obj->bbox.h = ret;
 			}
 			break;
 		}
@@ -916,15 +916,15 @@ int scene_bbox_union(struct scene *scn, uint id, int inset,
 	if (!obj)
 		return log_msg_ret("obj", -ENOENT);
 	if (bbox->valid) {
-		bbox->x0 = min(bbox->x0, obj->dim.x - inset);
-		bbox->y0 = min(bbox->y0, obj->dim.y);
-		bbox->x1 = max(bbox->x1, obj->dim.x + obj->dim.w + inset);
-		bbox->y1 = max(bbox->y1, obj->dim.y + obj->dim.h);
+		bbox->x0 = min(bbox->x0, obj->bbox.x - inset);
+		bbox->y0 = min(bbox->y0, obj->bbox.y);
+		bbox->x1 = max(bbox->x1, obj->bbox.x + obj->bbox.w + inset);
+		bbox->y1 = max(bbox->y1, obj->bbox.y + obj->bbox.h);
 	} else {
-		bbox->x0 = obj->dim.x - inset;
-		bbox->y0 = obj->dim.y;
-		bbox->x1 = obj->dim.x + obj->dim.w + inset;
-		bbox->y1 = obj->dim.y + obj->dim.h;
+		bbox->x0 = obj->bbox.x - inset;
+		bbox->y0 = obj->bbox.y;
+		bbox->x1 = obj->bbox.x + obj->bbox.w + inset;
+		bbox->y1 = obj->bbox.y + obj->bbox.h;
 		bbox->valid = true;
 	}
 
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index df14a6c0409..f0a060a6356 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -102,7 +102,7 @@ static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
 		label = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
 
 		ret = scene_obj_set_pos(scn, menu->pointer_id,
-					menu->obj.dim.x + 200, label->dim.y);
+					menu->obj.bbox.x + 200, label->bbox.y);
 		if (ret < 0)
 			return log_msg_ret("ptr", ret);
 	}
@@ -179,8 +179,8 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 	}
 
 	if (bbox.valid) {
-		menu->obj.dim.w = bbox.x1 - bbox.x0;
-		menu->obj.dim.h = bbox.y1 - bbox.y0;
+		menu->obj.bbox.w = bbox.x1 - bbox.x0;
+		menu->obj.bbox.h = bbox.y1 - bbox.y0;
 	}
 
 	return 0;
@@ -198,12 +198,12 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	int x, y;
 	int ret;
 
-	x = menu->obj.dim.x;
-	y = menu->obj.dim.y;
+	x = menu->obj.bbox.x;
+	y = menu->obj.bbox.y;
 	if (menu->title_id) {
 		int width;
 
-		ret = scene_obj_set_pos(scn, menu->title_id, menu->obj.dim.x, y);
+		ret = scene_obj_set_pos(scn, menu->title_id, menu->obj.bbox.x, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 6adef7cc173..4467bc4abcf 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -77,11 +77,11 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
 		return log_msg_ret("nom", ret);
 
 	if (bbox.valid) {
-		tline->obj.dim.w = bbox.x1 - bbox.x0;
-		tline->obj.dim.h = bbox.y1 - bbox.y0;
+		tline->obj.bbox.w = bbox.x1 - bbox.x0;
+		tline->obj.bbox.h = bbox.y1 - bbox.y0;
 
-		scene_obj_set_size(scn, tline->edit_id, tline->obj.dim.w,
-				   tline->obj.dim.h);
+		scene_obj_set_size(scn, tline->edit_id, tline->obj.bbox.w,
+				   tline->obj.bbox.h);
 	}
 
 	return 0;
@@ -95,16 +95,16 @@ int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	int x, y;
 	int ret;
 
-	x = tline->obj.dim.x;
-	y = tline->obj.dim.y;
+	x = tline->obj.bbox.x;
+	y = tline->obj.bbox.y;
 	if (tline->label_id) {
-		ret = scene_obj_set_pos(scn, tline->label_id, tline->obj.dim.x,
+		ret = scene_obj_set_pos(scn, tline->label_id, tline->obj.bbox.x,
 					y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
 		ret = scene_obj_set_pos(scn, tline->edit_id,
-					tline->obj.dim.x + 200, y);
+					tline->obj.bbox.x + 200, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
@@ -198,8 +198,8 @@ int scene_textline_render_deps(struct scene *scn,
 		if (ret)
 			return log_msg_ret("sav", ret);
 
-		vidconsole_set_cursor_visible(cons, true, txt->obj.dim.x,
-					      txt->obj.dim.y, scn->cls.num);
+		vidconsole_set_cursor_visible(cons, true, txt->obj.bbox.x,
+					      txt->obj.bbox.y, scn->cls.num);
 	}
 
 	return 0;
@@ -220,7 +220,7 @@ int scene_textline_open(struct scene *scn, struct scene_obj_textline *tline)
 	if (!txt)
 		return log_msg_ret("cur", -ENOENT);
 
-	vidconsole_set_cursor_pos(cons, txt->obj.dim.x, txt->obj.dim.y);
+	vidconsole_set_cursor_pos(cons, txt->obj.bbox.x, txt->obj.bbox.y);
 	vidconsole_entry_start(cons);
 	cli_cread_init(&scn->cls, abuf_data(&tline->buf), tline->max_chars);
 	scn->cls.insert = true;
diff --git a/include/expo.h b/include/expo.h
index a2b093c521d..42e934e3ff2 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -192,14 +192,14 @@ enum scene_obj_t {
 };
 
 /**
- * struct scene_dim - Dimensions of an object
+ * struct scene_obj_bbox - Dimensions of an object
  *
  * @x: x position, in pixels from left side
  * @y: y position, in pixels from top
  * @w: width, in pixels
  * @h: height, in pixels
  */
-struct scene_dim {
+struct scene_obj_bbox {
 	int x;
 	int y;
 	int w;
@@ -232,7 +232,7 @@ enum {
  * @name: Name of the object (allocated)
  * @id: ID number of the object
  * @type: Type of this object
- * @dim: Dimensions for this object
+ * @bbox: Dimensions for this object
  * @flags: Flags for this object
  * @bit_length: Number of bits used for this object in CMOS RAM
  * @start_bit: Start bit to use for this object in CMOS RAM
@@ -243,7 +243,7 @@ struct scene_obj {
 	char *name;
 	uint id;
 	enum scene_obj_t type;
-	struct scene_dim dim;
+	struct scene_obj_bbox bbox;
 	u8 flags;
 	u8 bit_length;
 	u16 start_bit;
diff --git a/test/boot/expo.c b/test/boot/expo.c
index b32a4596e85..77b956bdf06 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -270,8 +270,8 @@ static int expo_object_attr(struct unit_test_state *uts)
 	ut_assert(id > 0);
 
 	ut_assertok(scene_obj_set_pos(scn, OBJ_LOGO, 123, 456));
-	ut_asserteq(123, img->obj.dim.x);
-	ut_asserteq(456, img->obj.dim.y);
+	ut_asserteq(123, img->obj.bbox.x);
+	ut_asserteq(456, img->obj.bbox.y);
 
 	ut_asserteq(-ENOENT, scene_obj_set_pos(scn, OBJ_TEXT2, 0, 0));
 
@@ -360,8 +360,8 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(0, menu->pointer_id);
 
 	ut_assertok(scene_obj_set_pos(scn, OBJ_MENU, 50, 400));
-	ut_asserteq(50, menu->obj.dim.x);
-	ut_asserteq(400, menu->obj.dim.y);
+	ut_asserteq(50, menu->obj.bbox.x);
+	ut_asserteq(400, menu->obj.bbox.y);
 
 	id = scene_txt_str(scn, "title", OBJ_MENU_TITLE, STR_MENU_TITLE,
 			   "Main Menu", &tit);
@@ -407,24 +407,24 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(id, menu->cur_item_id);
 
 	/* the title should be at the top */
-	ut_asserteq(menu->obj.dim.x, tit->obj.dim.x);
-	ut_asserteq(menu->obj.dim.y, tit->obj.dim.y);
+	ut_asserteq(menu->obj.bbox.x, tit->obj.bbox.x);
+	ut_asserteq(menu->obj.bbox.y, tit->obj.bbox.y);
 
 	/* the first item should be next */
-	ut_asserteq(menu->obj.dim.x, name1->obj.dim.x);
-	ut_asserteq(menu->obj.dim.y + 32, name1->obj.dim.y);
+	ut_asserteq(menu->obj.bbox.x, name1->obj.bbox.x);
+	ut_asserteq(menu->obj.bbox.y + 32, name1->obj.bbox.y);
 
-	ut_asserteq(menu->obj.dim.x + 230, key1->obj.dim.x);
-	ut_asserteq(menu->obj.dim.y + 32, key1->obj.dim.y);
+	ut_asserteq(menu->obj.bbox.x + 230, key1->obj.bbox.x);
+	ut_asserteq(menu->obj.bbox.y + 32, key1->obj.bbox.y);
 
-	ut_asserteq(menu->obj.dim.x + 200, ptr->obj.dim.x);
-	ut_asserteq(menu->obj.dim.y + 32, ptr->obj.dim.y);
+	ut_asserteq(menu->obj.bbox.x + 200, ptr->obj.bbox.x);
+	ut_asserteq(menu->obj.bbox.y + 32, ptr->obj.bbox.y);
 
-	ut_asserteq(menu->obj.dim.x + 280, desc1->obj.dim.x);
-	ut_asserteq(menu->obj.dim.y + 32, desc1->obj.dim.y);
+	ut_asserteq(menu->obj.bbox.x + 280, desc1->obj.bbox.x);
+	ut_asserteq(menu->obj.bbox.y + 32, desc1->obj.bbox.y);
 
-	ut_asserteq(-4, prev1->obj.dim.x);
-	ut_asserteq(menu->obj.dim.y + 32, prev1->obj.dim.y);
+	ut_asserteq(-4, prev1->obj.bbox.x);
+	ut_asserteq(menu->obj.bbox.y + 32, prev1->obj.bbox.y);
 	ut_asserteq(true, prev1->obj.flags & SCENEOF_HIDE);
 
 	/* check iterating through scene items */
@@ -548,41 +548,41 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* check dimensions of text */
 	obj = scene_obj_find(scn, OBJ_TEXT, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(400, obj->dim.x);
-	ut_asserteq(100, obj->dim.y);
-	ut_asserteq(126, obj->dim.w);
-	ut_asserteq(40, obj->dim.h);
+	ut_asserteq(400, obj->bbox.x);
+	ut_asserteq(100, obj->bbox.y);
+	ut_asserteq(126, obj->bbox.w);
+	ut_asserteq(40, obj->bbox.h);
 
 	/* check dimensions of image */
 	obj = scene_obj_find(scn, OBJ_LOGO, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->dim.x);
-	ut_asserteq(20, obj->dim.y);
-	ut_asserteq(160, obj->dim.w);
-	ut_asserteq(160, obj->dim.h);
+	ut_asserteq(50, obj->bbox.x);
+	ut_asserteq(20, obj->bbox.y);
+	ut_asserteq(160, obj->bbox.w);
+	ut_asserteq(160, obj->bbox.h);
 
 	/* check dimensions of menu labels - both should be the same width */
 	obj = scene_obj_find(scn, ITEM1_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->dim.x);
-	ut_asserteq(436, obj->dim.y);
-	ut_asserteq(29, obj->dim.w);
-	ut_asserteq(18, obj->dim.h);
+	ut_asserteq(50, obj->bbox.x);
+	ut_asserteq(436, obj->bbox.y);
+	ut_asserteq(29, obj->bbox.w);
+	ut_asserteq(18, obj->bbox.h);
 
 	obj = scene_obj_find(scn, ITEM2_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->dim.x);
-	ut_asserteq(454, obj->dim.y);
-	ut_asserteq(29, obj->dim.w);
-	ut_asserteq(18, obj->dim.h);
+	ut_asserteq(50, obj->bbox.x);
+	ut_asserteq(454, obj->bbox.y);
+	ut_asserteq(29, obj->bbox.w);
+	ut_asserteq(18, obj->bbox.h);
 
 	/* check dimensions of menu */
 	obj = scene_obj_find(scn, OBJ_MENU, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->dim.x);
-	ut_asserteq(400, obj->dim.y);
-	ut_asserteq(160, obj->dim.w);
-	ut_asserteq(160, obj->dim.h);
+	ut_asserteq(50, obj->bbox.x);
+	ut_asserteq(400, obj->bbox.y);
+	ut_asserteq(160, obj->bbox.w);
+	ut_asserteq(160, obj->bbox.h);
 
 	/* render it */
 	expo_set_scene_id(exp, SCENE1);
-- 
2.43.0

