Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A0EC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:51:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA68182AEF;
	Fri,  2 May 2025 16:48:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="femO92jb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B47F582AF6; Fri,  2 May 2025 16:48:29 +0200 (CEST)
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 408C882AEF
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd30.google.com with SMTP id
 ca18e2360f4ac-861b1f04b99so85492539f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197305; x=1746802105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=317hQfrRRwlb45YDsp8onDmZ6Uq3MgeNXd/SYaI6H3g=;
 b=femO92jbUjL4ze+O/4oTN7o9HBkFp896XQV2Wdjz4OQ+GqzR8loMSsmT/E3M+3z+Jk
 iA8Rsg1DAWJFc62ABHU0R5H52uvpPNv0YzbZZruGZAZ1lvKUranhdpiqRPWyCLaeGBDf
 IlaM1k0sFazKRtTCg+FIQ6Bp+EGBH7G5HT7bk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197305; x=1746802105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=317hQfrRRwlb45YDsp8onDmZ6Uq3MgeNXd/SYaI6H3g=;
 b=iPVvA256o1GDQP+Q0GelGlwacFOF39IPjAwRTJLg4prtveAWkh5b42MaY0nQeSiRm3
 /7HLmbP3Gy5u3x6VYEMl3q9XX8eosYKeWkAaQxwl4UjGTMA7cZlGXSEbLpMiSSujM0Eq
 QATEndxYluufDHlmnHgn3YRCn12TIZVVazmP1D+rSsgG6YXIqcjKxEcPsCIVVoU/IgqR
 UM9p4O1d+xwCKspsC0ACxk2qBPKzfuT1A7hpXvtYLNjmXYvremFRoRGRt2LPAlV48BIk
 cANQJJGJcrAYhtV8j9RNNYZ+z2rxPAAkYLAPdVjmE01BdNUu+BDde532lCdjToQiwDzn
 yKHg==
X-Gm-Message-State: AOJu0YxxrvPW9gNBpJI2Xb5Z8p6RE2RBorRjjkOAudnnrSRBVQAxNSD5
 2+M/UCDADvq7j0/PNKb0V0VBp+79ntUXqD16qmRdEudoEkEtdfqYxQeGQKUHUO7v/CXqpYdw8ks
 =
X-Gm-Gg: ASbGnct2YVqKhttcq4qpHUympTMjB4xGd4i8QV3KWQXA8OefFNYPPGFfSCUxC2fE29G
 fk8ib7c2VNokLmXsyIIN+mVyGchWYy/qPiqMnxwmT/mod1H31B5n4wV1o6uRjnmpUgu4VxOO0OO
 o8YTPHox0/1rvs0JSdyjqThm1xzgtHF9fZkzwQpAXGTk5nbXRkehPTn1MxANyFTA7p9hkrvmxi0
 kg8bjoWA8WFBQzzCDiUzGPdtqfyw4XlPNMQEbyW73e+vJIFBO+0wI++Rvlt7KXBb0DaQFhcYeCj
 4ji7Rh+6pFGd9uBl55gI0fohxsnhq3/QsdcDvcLCthxtrduCcd8B+M6YKaEy3lW863McH5kkR0y
 Nb1r5rW/4TkCW
X-Google-Smtp-Source: AGHT+IFS3zKw/7xrTkDgFumj/9fY3DHi+k3PCbOb7dlcQMW0GEiECVhVGwEqQTFWe0h1KlPUZ/+d+g==
X-Received: by 2002:a05:6602:36c5:b0:864:4a9b:f1f1 with SMTP id
 ca18e2360f4ac-866b441b229mr415850739f.14.1746197305359; 
 Fri, 02 May 2025 07:48:25 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:23 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 32/60] expo: Rename scene_dim to scene_obj_bbox
Date: Fri,  2 May 2025 08:46:30 -0600
Message-ID: <20250502144718.313633-33-sjg@chromium.org>
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
index 90b4ccf4766..a0060c6a97d 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -210,8 +210,8 @@ int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->dim.x = x;
-	obj->dim.y = y;
+	obj->bbox.x = x;
+	obj->bbox.y = y;
 
 	return 0;
 }
@@ -223,8 +223,8 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->dim.w = w;
-	obj->dim.h = h;
+	obj->bbox.w = w;
+	obj->bbox.h = h;
 
 	return 0;
 }
@@ -368,8 +368,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	struct udevice *cons = text_mode ? NULL : exp->cons;
 	int x, y, ret;
 
-	x = obj->dim.x;
-	y = obj->dim.y;
+	x = obj->bbox.x;
+	y = obj->bbox.y;
 
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
@@ -419,8 +419,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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
@@ -765,8 +765,8 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
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
@@ -915,15 +915,15 @@ int scene_bbox_union(struct scene *scn, uint id, int inset,
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
index 6a2f5b6b93f..20a6a6b6a01 100644
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
@@ -186,8 +186,8 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 	}
 
 	if (bbox.valid) {
-		menu->obj.dim.w = bbox.x1 - bbox.x0;
-		menu->obj.dim.h = bbox.y1 - bbox.y0;
+		menu->obj.bbox.w = bbox.x1 - bbox.x0;
+		menu->obj.bbox.h = bbox.y1 - bbox.y0;
 	}
 
 	return 0;
@@ -205,12 +205,12 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
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
index 90642a3f03d..5b4e21e6360 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -76,11 +76,11 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
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
@@ -94,16 +94,16 @@ int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
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
 
@@ -197,8 +197,8 @@ int scene_textline_render_deps(struct scene *scn,
 		if (ret)
 			return log_msg_ret("sav", ret);
 
-		vidconsole_set_cursor_visible(cons, true, txt->obj.dim.x,
-					      txt->obj.dim.y, scn->cls.num);
+		vidconsole_set_cursor_visible(cons, true, txt->obj.bbox.x,
+					      txt->obj.bbox.y, scn->cls.num);
 	}
 
 	return 0;
@@ -219,7 +219,7 @@ int scene_textline_open(struct scene *scn, struct scene_obj_textline *tline)
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

