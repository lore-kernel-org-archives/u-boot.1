Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E81B2C35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:59:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 020F782075;
	Wed, 19 Mar 2025 15:56:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="A1l5xJEM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E4F84820F6; Wed, 19 Mar 2025 15:56:17 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9A63820F5
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43cfba466b2so46862145e9.3
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396175; x=1743000975; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nO2shK3McbXuO5iQFZMXMiUqTgkelxr4CWJmT6J99Nw=;
 b=A1l5xJEMeBr9IaZdum0N2kwn5RTantF+aMw3dzT3vLk/hp0bNnjStorHz510T+1tN9
 DK2+z+J8uHqaG332hUgcviPLGijKcSKvzkSsbTksoCWrG4qh2bHwTa8HjAdA6/TczzJt
 zHsLpGxcwpjo2CxGtbBlKIybBskyt95Vx5bnk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396175; x=1743000975;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nO2shK3McbXuO5iQFZMXMiUqTgkelxr4CWJmT6J99Nw=;
 b=Njwciy6kFcwr9POevnrbBa+etkwzsryNjHlHPsVH7mM1uVbA6ELt2P1yUcfnUk3wTf
 E5G7bf0VIlOy0gKX6+VhiW+4dMTiTaF7UtfALklYxfGlzXhSFHC8TQAjUzoAME+yb70Z
 dyxDv3WmR+tvMk4ct3QgHmfIPuDD9p0mUyei0bJJ0Qkz3eEbSQb9ulH3o9JeWvqliuUy
 2kqRjwFqqzUJUyIL4NFwjmbr0PUDKnzsCLMzYBJAMTfOH71cNvqv3uyS4d732cGqGU5P
 tvgOo7uXcPB+ETay+b83C4KimnQO5gqD25WqiDrGiBitlV4hitNvRUlcwsbltor9Hfe9
 su0A==
X-Gm-Message-State: AOJu0YzD+JwnOK/aVNvNHSFuxKt3M0+PA1TxmxSV3MgRQYL2g+77BLJi
 O7zi1952JmiR1mZ7n3oPfUsAFUmkRK/wX2/2MvIrJtbph+Ql8XR9+4RB1SLd5LcCoaOLxfDXOBs
 =
X-Gm-Gg: ASbGncuq1qEognpfBTNQL4LdmIgXpPREFV9z3YF2F0pZXnAg6YFzo5MtD9wTg/EJObp
 i56hUruP0YSq4Ene4RLI0coLeT5CPkTf/1NRp8SZN1nglHEZYWMBEPJGgVnnoiWKDsqqAjawjS0
 aJqV11HywvCsFmQR+4g3Av1i/mzPYjHxHid/epCo61Frg8L5O3cbPehkJnAm9zFV5/6VHJswElE
 0ViLEDzicRtoHM2pQjOk/0RpC6ATwcAYIJ32N1UhKQXHdO489BbZv/GzMLJe1zvbjdIBHsh4WH1
 EWtZlEpza+MHeXPkclZ1cYqdBYhtg40NuUVwA94K3A==
X-Google-Smtp-Source: AGHT+IGQcuwuVEQ6M4vxyGf9aKm1zuOdc6OdCVFmQ4Ajq9wKiM3wBoo/Vqul8yoUPcfmjRsaMtkcxQ==
X-Received: by 2002:a05:600c:3b92:b0:439:9a40:aa0b with SMTP id
 5b1f17b1804b1-43d43882ebcmr25524435e9.25.1742396174481; 
 Wed, 19 Mar 2025 07:56:14 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:13 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH 25/52] expo: Rename x and y in struct scene_obj_bbox
Date: Wed, 19 Mar 2025 15:54:30 +0100
Message-ID: <20250319145512.2391122-26-sjg@chromium.org>
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

These coordinates are the top left values, so rename them to x0 and y0
in preparation for changing the width and height to x1 and y1

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/scene.c          | 24 ++++++++++----------
 boot/scene_menu.c     |  8 +++----
 boot/scene_textline.c | 16 ++++++-------
 include/expo.h        |  8 +++----
 test/boot/expo.c      | 52 +++++++++++++++++++++----------------------
 5 files changed, 54 insertions(+), 54 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index fbc6f783257..75b1e4faba5 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -211,8 +211,8 @@ int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->bbox.x = x;
-	obj->bbox.y = y;
+	obj->bbox.x0 = x;
+	obj->bbox.y0 = y;
 
 	return 0;
 }
@@ -369,8 +369,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	struct udevice *cons = text_mode ? NULL : exp->cons;
 	int x, y, ret;
 
-	x = obj->bbox.x;
-	y = obj->bbox.y;
+	x = obj->bbox.x0;
+	y = obj->bbox.y0;
 
 	switch (obj->type) {
 	case SCENEOBJT_NONE:
@@ -916,15 +916,15 @@ int scene_bbox_union(struct scene *scn, uint id, int inset,
 	if (!obj)
 		return log_msg_ret("obj", -ENOENT);
 	if (bbox->valid) {
-		bbox->x0 = min(bbox->x0, obj->bbox.x - inset);
-		bbox->y0 = min(bbox->y0, obj->bbox.y);
-		bbox->x1 = max(bbox->x1, obj->bbox.x + obj->bbox.w + inset);
-		bbox->y1 = max(bbox->y1, obj->bbox.y + obj->bbox.h);
+		bbox->x0 = min(bbox->x0, obj->bbox.x0 - inset);
+		bbox->y0 = min(bbox->y0, obj->bbox.y0);
+		bbox->x1 = max(bbox->x1, obj->bbox.x0 + obj->bbox.w + inset);
+		bbox->y1 = max(bbox->y1, obj->bbox.y0 + obj->bbox.h);
 	} else {
-		bbox->x0 = obj->bbox.x - inset;
-		bbox->y0 = obj->bbox.y;
-		bbox->x1 = obj->bbox.x + obj->bbox.w + inset;
-		bbox->y1 = obj->bbox.y + obj->bbox.h;
+		bbox->x0 = obj->bbox.x0 - inset;
+		bbox->y0 = obj->bbox.y0;
+		bbox->x1 = obj->bbox.x0 + obj->bbox.w + inset;
+		bbox->y1 = obj->bbox.y0 + obj->bbox.h;
 		bbox->valid = true;
 	}
 
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index f0a060a6356..00bbf9a3849 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -102,7 +102,7 @@ static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
 		label = scene_obj_find(scn, item->label_id, SCENEOBJT_NONE);
 
 		ret = scene_obj_set_pos(scn, menu->pointer_id,
-					menu->obj.bbox.x + 200, label->bbox.y);
+					menu->obj.bbox.x0 + 200, label->bbox.y0);
 		if (ret < 0)
 			return log_msg_ret("ptr", ret);
 	}
@@ -198,12 +198,12 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	int x, y;
 	int ret;
 
-	x = menu->obj.bbox.x;
-	y = menu->obj.bbox.y;
+	x = menu->obj.bbox.x0;
+	y = menu->obj.bbox.y0;
 	if (menu->title_id) {
 		int width;
 
-		ret = scene_obj_set_pos(scn, menu->title_id, menu->obj.bbox.x, y);
+		ret = scene_obj_set_pos(scn, menu->title_id, menu->obj.bbox.x0, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index 4467bc4abcf..2ffeffeb5f5 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -95,16 +95,16 @@ int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	int x, y;
 	int ret;
 
-	x = tline->obj.bbox.x;
-	y = tline->obj.bbox.y;
+	x = tline->obj.bbox.x0;
+	y = tline->obj.bbox.y0;
 	if (tline->label_id) {
-		ret = scene_obj_set_pos(scn, tline->label_id, tline->obj.bbox.x,
-					y);
+		ret = scene_obj_set_pos(scn, tline->label_id,
+					tline->obj.bbox.x0, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
 		ret = scene_obj_set_pos(scn, tline->edit_id,
-					tline->obj.bbox.x + 200, y);
+					tline->obj.bbox.x0 + 200, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
@@ -198,8 +198,8 @@ int scene_textline_render_deps(struct scene *scn,
 		if (ret)
 			return log_msg_ret("sav", ret);
 
-		vidconsole_set_cursor_visible(cons, true, txt->obj.bbox.x,
-					      txt->obj.bbox.y, scn->cls.num);
+		vidconsole_set_cursor_visible(cons, true, txt->obj.bbox.x0,
+					      txt->obj.bbox.y0, scn->cls.num);
 	}
 
 	return 0;
@@ -220,7 +220,7 @@ int scene_textline_open(struct scene *scn, struct scene_obj_textline *tline)
 	if (!txt)
 		return log_msg_ret("cur", -ENOENT);
 
-	vidconsole_set_cursor_pos(cons, txt->obj.bbox.x, txt->obj.bbox.y);
+	vidconsole_set_cursor_pos(cons, txt->obj.bbox.x0, txt->obj.bbox.y0);
 	vidconsole_entry_start(cons);
 	cli_cread_init(&scn->cls, abuf_data(&tline->buf), tline->max_chars);
 	scn->cls.insert = true;
diff --git a/include/expo.h b/include/expo.h
index 42e934e3ff2..84dc77f771e 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -194,14 +194,14 @@ enum scene_obj_t {
 /**
  * struct scene_obj_bbox - Dimensions of an object
  *
- * @x: x position, in pixels from left side
- * @y: y position, in pixels from top
+ * @x0: x position, in pixels from left side
+ * @y0: y position, in pixels from top
  * @w: width, in pixels
  * @h: height, in pixels
  */
 struct scene_obj_bbox {
-	int x;
-	int y;
+	int x0;
+	int y0;
 	int w;
 	int h;
 };
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 77b956bdf06..9c940825278 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -270,8 +270,8 @@ static int expo_object_attr(struct unit_test_state *uts)
 	ut_assert(id > 0);
 
 	ut_assertok(scene_obj_set_pos(scn, OBJ_LOGO, 123, 456));
-	ut_asserteq(123, img->obj.bbox.x);
-	ut_asserteq(456, img->obj.bbox.y);
+	ut_asserteq(123, img->obj.bbox.x0);
+	ut_asserteq(456, img->obj.bbox.y0);
 
 	ut_asserteq(-ENOENT, scene_obj_set_pos(scn, OBJ_TEXT2, 0, 0));
 
@@ -360,8 +360,8 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(0, menu->pointer_id);
 
 	ut_assertok(scene_obj_set_pos(scn, OBJ_MENU, 50, 400));
-	ut_asserteq(50, menu->obj.bbox.x);
-	ut_asserteq(400, menu->obj.bbox.y);
+	ut_asserteq(50, menu->obj.bbox.x0);
+	ut_asserteq(400, menu->obj.bbox.y0);
 
 	id = scene_txt_str(scn, "title", OBJ_MENU_TITLE, STR_MENU_TITLE,
 			   "Main Menu", &tit);
@@ -407,24 +407,24 @@ static int expo_object_menu(struct unit_test_state *uts)
 	ut_asserteq(id, menu->cur_item_id);
 
 	/* the title should be at the top */
-	ut_asserteq(menu->obj.bbox.x, tit->obj.bbox.x);
-	ut_asserteq(menu->obj.bbox.y, tit->obj.bbox.y);
+	ut_asserteq(menu->obj.bbox.x0, tit->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.y0, tit->obj.bbox.y0);
 
 	/* the first item should be next */
-	ut_asserteq(menu->obj.bbox.x, name1->obj.bbox.x);
-	ut_asserteq(menu->obj.bbox.y + 32, name1->obj.bbox.y);
+	ut_asserteq(menu->obj.bbox.x0, name1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.y0 + 32, name1->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x + 230, key1->obj.bbox.x);
-	ut_asserteq(menu->obj.bbox.y + 32, key1->obj.bbox.y);
+	ut_asserteq(menu->obj.bbox.x0 + 230, key1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.y0 + 32, key1->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x + 200, ptr->obj.bbox.x);
-	ut_asserteq(menu->obj.bbox.y + 32, ptr->obj.bbox.y);
+	ut_asserteq(menu->obj.bbox.x0 + 200, ptr->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.y0 + 32, ptr->obj.bbox.y0);
 
-	ut_asserteq(menu->obj.bbox.x + 280, desc1->obj.bbox.x);
-	ut_asserteq(menu->obj.bbox.y + 32, desc1->obj.bbox.y);
+	ut_asserteq(menu->obj.bbox.x0 + 280, desc1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.y0 + 32, desc1->obj.bbox.y0);
 
-	ut_asserteq(-4, prev1->obj.bbox.x);
-	ut_asserteq(menu->obj.bbox.y + 32, prev1->obj.bbox.y);
+	ut_asserteq(-4, prev1->obj.bbox.x0);
+	ut_asserteq(menu->obj.bbox.y0 + 32, prev1->obj.bbox.y0);
 	ut_asserteq(true, prev1->obj.flags & SCENEOF_HIDE);
 
 	/* check iterating through scene items */
@@ -548,39 +548,39 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* check dimensions of text */
 	obj = scene_obj_find(scn, OBJ_TEXT, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(400, obj->bbox.x);
-	ut_asserteq(100, obj->bbox.y);
+	ut_asserteq(400, obj->bbox.x0);
+	ut_asserteq(100, obj->bbox.y0);
 	ut_asserteq(126, obj->bbox.w);
 	ut_asserteq(40, obj->bbox.h);
 
 	/* check dimensions of image */
 	obj = scene_obj_find(scn, OBJ_LOGO, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->bbox.x);
-	ut_asserteq(20, obj->bbox.y);
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(20, obj->bbox.y0);
 	ut_asserteq(160, obj->bbox.w);
 	ut_asserteq(160, obj->bbox.h);
 
 	/* check dimensions of menu labels - both should be the same width */
 	obj = scene_obj_find(scn, ITEM1_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->bbox.x);
-	ut_asserteq(436, obj->bbox.y);
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(436, obj->bbox.y0);
 	ut_asserteq(29, obj->bbox.w);
 	ut_asserteq(18, obj->bbox.h);
 
 	obj = scene_obj_find(scn, ITEM2_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->bbox.x);
-	ut_asserteq(454, obj->bbox.y);
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(454, obj->bbox.y0);
 	ut_asserteq(29, obj->bbox.w);
 	ut_asserteq(18, obj->bbox.h);
 
 	/* check dimensions of menu */
 	obj = scene_obj_find(scn, OBJ_MENU, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
-	ut_asserteq(50, obj->bbox.x);
-	ut_asserteq(400, obj->bbox.y);
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(400, obj->bbox.y0);
 	ut_asserteq(160, obj->bbox.w);
 	ut_asserteq(160, obj->bbox.h);
 
-- 
2.43.0

