Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E349C3ABB0
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 15:46:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3EF782928;
	Mon,  5 May 2025 17:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CbOKtF92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BD5282A8B; Mon,  5 May 2025 17:44:25 +0200 (CEST)
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com
 [IPv6:2a00:1450:4864:20::52e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A47882AC4
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 17:44:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5f861d16622so7873795a12.2
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 08:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746459861; x=1747064661; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Q+TLRY7lFVUR042qAFI5yL7rSNt//Fr+4wP9Jx1riU=;
 b=CbOKtF92hAYCA3RFCZv8jbXYmZTGzKLRYgNosIPxy2jfrylasEmQ+S984ZI5hDdrjL
 FQBS5ZqX6f2eVY/D7dc84sj3YHRyucVBBkT4NcxSZpQSfr1jyTJC9OXTSUC1dE7QprD1
 uWKXhX8DThy7hpnhPiJLfIWQeodxRlzO8WLxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746459861; x=1747064661;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+Q+TLRY7lFVUR042qAFI5yL7rSNt//Fr+4wP9Jx1riU=;
 b=MNAE1xOEw3PO+oPKc3CtswKtaRwlgdNsGNM1S+kBYY/EOgc37iiBo7Chxky9Bpy6fy
 6WUc31HMwsw7qxe5j7msuG8iv0tG+p5Pm4s8GXxXx7KeHWR7jeHPQsnvO0Uz7ijMvAr/
 IU/7iOTcR9HW/kK/immB1560Ol5IdD8cm8lz9FZN8jncPao/BTsVvVmg6TRp+acEo62c
 BcaYfHu/yE8kRc6nzpiIdkbZ//k+VwHkMwqMk21olQauz3LO0z5kCGLQTrR00pHraUkv
 X7m2/NnrNJm20Q+rll7wgHVXa+5YVHKvjqKXPGiJJ4igWxWs9av9hfsZmAhp5/CWy2hg
 MreA==
X-Gm-Message-State: AOJu0Yx+fxTngUuWHmlS4AlTR0WwZVDXC/zi+UhjcuItT3KV/lggOY8n
 SdmLjehDBOO39M/aYf4hC7Ua6gusubaZcPUjGyWzYuNcBwewq8SdjZEf6dc6VZlqLnFTuSg6tXi
 c/UfrsPk=
X-Gm-Gg: ASbGncse0qBjPSs22uMAvMFIH7rADF31D0fk+j7ImwcIVyZFi6fS6IVJevClMq6h+et
 Ba+raL8RvVSBSyIIaCIWMIKBQF6+bvdMA62WV3JxaJnq3oT/e5DaXrL3Gh7OglhzRXDjzdk4Vov
 ZZCVs81yYKdFP/P6HXh+ffDjoL8hKQNg3KgdhVALGWYWWYglLIh4DWcvjJfp73m0lqpHPy23lwn
 qzTFh8B/NHOGNU2kBvRODY3uRgwuK2WNoNCWbCz15fMvYDqm34pNsLtG74UpAht02/VclMszwv/
 0h6MS+4S9+IUvngG0dD2MHmi5cbcVunw1J/X
X-Google-Smtp-Source: AGHT+IGJGt4PhGRSAARTyJi8nz45NDuOkCTGIhp5ygg/PejHA4dT8RPK9LwrZDazC92o+SRu8T3h4w==
X-Received: by 2002:a05:6402:354e:b0:5f6:26d3:c6c3 with SMTP id
 4fb4d7f45d1cf-5fab05e09d5mr6302388a12.32.1746459861268; 
 Mon, 05 May 2025 08:44:21 -0700 (PDT)
Received: from chromium.org ([213.157.19.135])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5fa778188acsm5561762a12.35.2025.05.05.08.44.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 08:44:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Moritz Fischer <moritzf@google.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Sean Anderson <seanga2@gmail.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 19/19] expo: Tidy up insets and improve tests
Date: Mon,  5 May 2025 17:42:57 +0200
Message-ID: <20250505154308.2911248-20-sjg@chromium.org>
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

Insets are handled inconsistently at present, since menus use them to
offset the label text, whereas textlines don't. This is done because
menus need the margin to be visible when opened. However this causes an
alignment issue when menus and textlines appear in the same cedit.

Remove the offsets from menus and compensate by adjusting the bounding
boxes used for highlighting and the opened menu.

Line up menu items and textlines vertically and add a style option for
textlines to control how much padding is added.

Add a test to check the positions of objects in a cedit, since this is
more direct than the rendering tests. Add style information so that the
impact can be seen.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 arch/sandbox/dts/sandbox.dtsi |   4 +-
 arch/sandbox/dts/test.dts     |   1 +
 boot/cedit.c                  |  10 ++-
 boot/expo.c                   |   2 +
 boot/scene.c                  |   2 +-
 boot/scene_menu.c             |   9 +-
 boot/scene_textline.c         |  30 ++++---
 doc/develop/expo.rst          |   4 +
 include/expo.h                |   3 +
 test/boot/cedit.c             | 152 ++++++++++++++++++++++++++++++----
 10 files changed, 181 insertions(+), 36 deletions(-)

diff --git a/arch/sandbox/dts/sandbox.dtsi b/arch/sandbox/dts/sandbox.dtsi
index 8a115c503dc..dd18bd26352 100644
--- a/arch/sandbox/dts/sandbox.dtsi
+++ b/arch/sandbox/dts/sandbox.dtsi
@@ -46,7 +46,9 @@
 		cedit-theme {
 			font-size = <30>;
 			menu-inset = <3>;
-			menuitem-gap-y = <1>;
+			menuitem-gap-y = <0>;
+			menu-title-margin-x = <10>;
+			textline-label-margin-x = <10>;
 		};
 	};
 
diff --git a/arch/sandbox/dts/test.dts b/arch/sandbox/dts/test.dts
index 2087c91285c..3e8db5c09c6 100644
--- a/arch/sandbox/dts/test.dts
+++ b/arch/sandbox/dts/test.dts
@@ -137,6 +137,7 @@
 			font-size = <30>;
 			menu-inset = <3>;
 			menuitem-gap-y = <1>;
+			textline-label-margin-x = <10>;
 		};
 
 		/*
diff --git a/boot/cedit.c b/boot/cedit.c
index c560be4d9c4..cc60e757649 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -52,6 +52,7 @@ struct cedit_iter_priv {
 
 int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 {
+	struct expo_theme *theme = &exp->theme;
 	struct expo_arrange_info arr;
 	struct scene_obj_txt *txt;
 	struct scene_obj *obj;
@@ -77,26 +78,31 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 
 	y = 100;
 	list_for_each_entry(obj, &scn->obj_head, sibling) {
+		bool add_gap = true;
+
 		switch (obj->type) {
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
 		case SCENEOBJT_BOX:
 		case SCENEOBJT_TEXTEDIT:
+			add_gap = false;
 			break;
 		case SCENEOBJT_MENU:
 			scene_obj_set_pos(scn, obj->id, 50, y);
 			scene_menu_arrange(scn, &arr,
 					   (struct scene_obj_menu *)obj);
-			y += 50;
+			y += obj->dims.y;
 			break;
 		case SCENEOBJT_TEXTLINE:
 			scene_obj_set_pos(scn, obj->id, 50, y);
 			scene_textline_arrange(scn, &arr,
 					(struct scene_obj_textline *)obj);
-			y += 50;
+			y += obj->dims.y;
 			break;
 		}
+		if (add_gap)
+			y += theme->menuitem_gap_y;
 	}
 	ret = scene_arrange(scn);
 	if (ret)
diff --git a/boot/expo.c b/boot/expo.c
index a218ea0e4e9..035c3de5a0a 100644
--- a/boot/expo.c
+++ b/boot/expo.c
@@ -313,6 +313,8 @@ int expo_setup_theme(struct expo *exp, ofnode node)
 	ofnode_read_u32(node, "menuitem-gap-y", &theme->menuitem_gap_y);
 	ofnode_read_u32(node, "menu-title-margin-x",
 			&theme->menu_title_margin_x);
+	ofnode_read_u32(node, "textline-label-margin-x",
+			&theme->textline_label_margin_x);
 	theme->white_on_black = ofnode_read_bool(node, "white-on-black");
 
 	ret = expo_apply_theme(exp);
diff --git a/boot/scene.c b/boot/scene.c
index 40ef3e0138c..61b943e2b52 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -563,7 +563,7 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 		inset = exp->popup ? menu_inset : 0;
 		vidconsole_push_colour(cons, fore, back, &old);
 		video_fill_part(dev, x - inset, y,
-				obj->bbox.x1, obj->bbox.y1,
+				obj->bbox.x1 + inset, obj->bbox.y1,
 				vid_priv->colour_bg);
 	}
 
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index 54c20d3e137..fd16cad6521 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -297,8 +297,7 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 		 * Put the label on the left, then leave a space for the
 		 * pointer, then the key and the description
 		 */
-		ret = scene_obj_set_pos(scn, item->label_id,
-					x + theme->menu_inset, y);
+		ret = scene_obj_set_pos(scn, item->label_id, x, y);
 		if (ret < 0)
 			return log_msg_ret("nam", ret);
 		scene_obj_set_hide(scn, item->label_id,
@@ -348,11 +347,11 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 
 	list_for_each_entry(item, &menu->item_head, sibling) {
 		scene_obj_set_width(menu->obj.scene, item->label_id,
-				    dims[SCENEBB_label].x + theme->menu_inset);
+				    dims[SCENEBB_label].x);
 		scene_obj_set_width(menu->obj.scene, item->key_id,
-				    dims[SCENEBB_key].x + theme->menu_inset);
+				    dims[SCENEBB_key].x);
 		scene_obj_set_width(menu->obj.scene, item->desc_id,
-				    dims[SCENEBB_desc].x + theme->menu_inset);
+				    dims[SCENEBB_desc].x);
 	}
 
 	if (sel_id)
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index e55db98ec30..acaf3d91bbc 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -49,13 +49,14 @@ void scene_textline_calc_bbox(struct scene_obj_textline *tline,
 			      struct vidconsole_bbox *edit_bbox)
 {
 	const struct expo_theme *theme = &tline->obj.scene->expo->theme;
+	int inset = theme->menu_inset;
 
 	bbox->valid = false;
-	scene_bbox_union(tline->obj.scene, tline->label_id, 0, bbox);
-	scene_bbox_union(tline->obj.scene, tline->edit_id, 0, bbox);
+	scene_bbox_union(tline->obj.scene, tline->label_id, inset, bbox);
+	scene_bbox_union(tline->obj.scene, tline->edit_id, inset, bbox);
 
 	edit_bbox->valid = false;
-	scene_bbox_union(tline->obj.scene, tline->edit_id, theme->menu_inset,
+	scene_bbox_union(tline->obj.scene, tline->edit_id, inset,
 			 edit_bbox);
 }
 
@@ -89,6 +90,7 @@ int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
 			   struct scene_obj_textline *tline)
 {
 	const bool open = tline->obj.flags & SCENEOF_OPEN;
+	const struct expo_theme *theme = &scn->expo->theme;
 	bool point;
 	int x, y;
 	int ret;
@@ -96,19 +98,22 @@ int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	x = tline->obj.req_bbox.x0;
 	y = tline->obj.req_bbox.y0;
 	if (tline->label_id) {
-		ret = scene_obj_set_pos(scn, tline->label_id, x, y);
-		if (ret < 0)
-			return log_msg_ret("tit", ret);
+		struct scene_obj *edit;
 
-		ret = scene_obj_set_pos(scn, tline->edit_id, x + 200, y);
+		ret = scene_obj_set_pos(scn, tline->label_id, x, y);
 		if (ret < 0)
 			return log_msg_ret("tit", ret);
 
-		ret = scene_obj_get_hw(scn, tline->label_id, NULL);
+		x += arr->label_width + theme->textline_label_margin_x;
+		ret = scene_obj_set_pos(scn, tline->edit_id, x, y);
 		if (ret < 0)
-			return log_msg_ret("hei", ret);
+			return log_msg_ret("til", ret);
 
-		y += ret * 2;
+		edit = scene_obj_find(scn, tline->edit_id, SCENEOBJT_NONE);
+		if (!edit)
+			return log_msg_ret("tie", -ENOENT);
+		x += edit->dims.x;
+		y += edit->dims.y;
 	}
 
 	point = scn->highlight_id == tline->obj.id;
@@ -116,6 +121,11 @@ int scene_textline_arrange(struct scene *scn, struct expo_arrange_info *arr,
 	scene_obj_flag_clrset(scn, tline->edit_id, SCENEOF_POINT,
 			      point ? SCENEOF_POINT : 0);
 
+	tline->obj.dims.x = x - tline->obj.req_bbox.x0;
+	tline->obj.dims.y = y - tline->obj.req_bbox.y0;
+	scene_obj_set_size(scn, tline->obj.id, tline->obj.dims.x,
+			   tline->obj.dims.y);
+
 	return 0;
 }
 
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index b94340e9a8d..5bdaffb14bb 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -218,6 +218,10 @@ menu-title-margin-x
     Number of pixels between right side of menu title to the left size of the
     menu labels
 
+textline-label-margin-x
+    Number of pixels between right side of textline label to the left size of
+    the editor
+
 Pop-up mode
 -----------
 
diff --git a/include/expo.h b/include/expo.h
index b67eb53b0c9..e383872b307 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -83,6 +83,8 @@ struct expo_action {
  * @menuitem_gap_y: Gap between menu items in pixels
  * @menu_title_margin_x: Gap between right side of menu title and left size of
  *	menu label
+ * @textline_label_margin_x: Gap between right side of textline prompt and left
+ *	side of editable text
  * @white_on_black: True to use white-on-black for the expo, false for
  *	black-on-white
  */
@@ -91,6 +93,7 @@ struct expo_theme {
 	u32 menu_inset;
 	u32 menuitem_gap_y;
 	u32 menu_title_margin_x;
+	u32 textline_label_margin_x;
 	bool white_on_black;
 };
 
diff --git a/test/boot/cedit.c b/test/boot/cedit.c
index dbf781902fb..9d49fbdc306 100644
--- a/test/boot/cedit.c
+++ b/test/boot/cedit.c
@@ -243,6 +243,7 @@ static int cedit_render(struct unit_test_state *uts)
 	struct expo_action evt;
 	struct expo_action act;
 	struct udevice *dev, *con;
+	struct expo_theme *theme;
 	struct stdio_dev *sdev;
 	struct scene *scn;
 	struct expo *exp;
@@ -255,6 +256,12 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_assertnonnull(sdev);
 	con = sdev->priv;
 
+	theme = &exp->theme;
+	theme->menuitem_gap_y = 2;
+	theme->menu_inset = 2;
+	/* theme->menu_title_margin_x is 0 so menu labels shouldn't line up */
+	theme->textline_label_margin_x = 10;
+
 	dev = dev_get_parent(con);
 	vid_priv = dev_get_uclass_priv(dev);
 	ut_asserteq(ID_SCENE1, cedit_prepare(exp, dev, &scn));
@@ -264,7 +271,7 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_asserteq(ID_AC_OFF, menu->cur_item_id);
 
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4929, video_compress_fb(uts, dev, false));
+	ut_asserteq(4888, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* move to the second menu */
@@ -272,54 +279,54 @@ static int cedit_render(struct unit_test_state *uts)
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4986, video_compress_fb(uts, dev, false));
+	ut_asserteq(4967, video_compress_fb(uts, dev, false));
 
 	/* open the menu */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5393, video_compress_fb(uts, dev, false));
+	ut_asserteq(5397, video_compress_fb(uts, dev, false));
 
 	/* close the menu */
 	act.type = EXPOACT_CLOSE;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4986, video_compress_fb(uts, dev, false));
+	ut_asserteq(4967, video_compress_fb(uts, dev, false));
 
 	/* open the menu again to check it looks the same */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5393, video_compress_fb(uts, dev, false));
+	ut_asserteq(5397, video_compress_fb(uts, dev, false));
 
 	/* close the menu */
 	act.type = EXPOACT_CLOSE;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4986, video_compress_fb(uts, dev, false));
+	ut_asserteq(4967, video_compress_fb(uts, dev, false));
 
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_POWER_LOSS;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5393, video_compress_fb(uts, dev, false));
+	ut_asserteq(5397, video_compress_fb(uts, dev, false));
 
 	act.type = EXPOACT_POINT_ITEM;
 	act.select.id = ID_AC_ON;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5365, video_compress_fb(uts, dev, false));
+	ut_asserteq(5341, video_compress_fb(uts, dev, false));
 
 	/* select it */
 	act.type = EXPOACT_SELECT;
 	act.select.id = ID_AC_ON;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4980, video_compress_fb(uts, dev, false));
+	ut_asserteq(4939, video_compress_fb(uts, dev, false));
 
 	ut_asserteq(ID_AC_ON, menu->cur_item_id);
 
@@ -328,14 +335,14 @@ static int cedit_render(struct unit_test_state *uts)
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4862, video_compress_fb(uts, dev, false));
+	ut_asserteq(4850, video_compress_fb(uts, dev, false));
 
 	/* open it */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4851, video_compress_fb(uts, dev, false));
+	ut_asserteq(4883, video_compress_fb(uts, dev, false));
 
 	/*
 	 * Send some keypresses. Note that the console must be enabled so that
@@ -351,7 +358,7 @@ static int cedit_render(struct unit_test_state *uts)
 	ut_silence_console(uts);
 	ut_assertok(cedit_arange(exp, vid_priv, scn->id));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(4996, video_compress_fb(uts, dev, false));
+	ut_asserteq(5033, video_compress_fb(uts, dev, false));
 
 	expo_destroy(exp);
 	cur_exp = NULL;
@@ -394,7 +401,7 @@ static int cedit_render_lineedit(struct unit_test_state *uts)
 	ut_asserteq(20, tline->pos);
 
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5336, video_compress_fb(uts, dev, false));
+	ut_asserteq(5315, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* move to the line-edit field */
@@ -402,15 +409,14 @@ static int cedit_render_lineedit(struct unit_test_state *uts)
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5363, video_compress_fb(uts, dev, false));
+	ut_asserteq(5372, video_compress_fb(uts, dev, false));
 
 	/* open it */
 	act.type = EXPOACT_OPEN;
 	act.select.id = ID_MACHINE_NAME;
 	ut_assertok(cedit_do_action(exp, scn, vid_priv, &act));
-	// ut_asserteq(0, tline->pos);
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5283, video_compress_fb(uts, dev, false));
+	ut_asserteq(5259, video_compress_fb(uts, dev, false));
 
 	/* delete some characters */
 	ut_unsilence_console(uts);
@@ -421,7 +427,7 @@ static int cedit_render_lineedit(struct unit_test_state *uts)
 
 	ut_assertok(cedit_arange(exp, vid_priv, scn->id));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(5170, video_compress_fb(uts, dev, false));
+	ut_asserteq(5126, video_compress_fb(uts, dev, false));
 
 	expo_destroy(exp);
 	cur_exp = NULL;
@@ -429,3 +435,115 @@ static int cedit_render_lineedit(struct unit_test_state *uts)
 	return 0;
 }
 BOOTSTD_TEST(cedit_render_lineedit, UTF_DM | UTF_SCAN_FDT);
+
+/* Check the cedit is arranged correctly */
+static int cedit_position(struct unit_test_state *uts)
+{
+	struct scene_obj_textline *tline;
+	struct scene_obj_menu *menu;
+	struct video_priv *vid_priv;
+	extern struct expo *cur_exp;
+	const uint label_width = 96;
+	struct scene_menitem *item;
+	struct udevice *dev, *con;
+	struct expo_theme *theme;
+	struct scene_obj *obj;
+	struct stdio_dev *sdev;
+	struct scene *scn;
+	struct expo *exp;
+	uint x_offset;
+
+	ut_assertok(run_command("cedit load hostfs - cedit.dtb", 0));
+	exp = cur_exp;
+
+	sdev = stdio_get_by_name("vidconsole");
+	ut_assertnonnull(sdev);
+	con = sdev->priv;
+
+	theme = &exp->theme;
+	theme->menuitem_gap_y = 2;
+	theme->menu_inset = 2;
+	theme->textline_label_margin_x = 10;
+	theme->menu_title_margin_x = 10;
+
+	dev = dev_get_parent(con);
+	vid_priv = dev_get_uclass_priv(dev);
+	ut_asserteq(ID_SCENE1, cedit_prepare(exp, dev, &scn));
+
+	// expo_dump(exp);
+	menu = scene_obj_find(scn, ID_CPU_SPEED, SCENEOBJT_MENU);
+	ut_assertnonnull(menu);
+	obj = &menu->obj;
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(100, obj->bbox.y0);
+	ut_asserteq(50 + 160, obj->bbox.x1);
+	ut_asserteq(18 + 100, obj->bbox.y1);
+
+	obj = scene_obj_find(scn, menu->title_id, SCENEOBJT_TEXT);
+	ut_assertnonnull(obj);
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(100, obj->bbox.y0);
+	ut_asserteq(50 + 75, obj->bbox.x1);
+	ut_asserteq(18 + 100, obj->bbox.y1);
+
+	item = scene_menuitem_find_seq(menu, 0);
+	ut_assertnonnull(item);
+
+	x_offset = label_width + theme->textline_label_margin_x;
+	obj = scene_obj_find(scn, item->label_id, SCENEOBJT_TEXT);
+	ut_assertnonnull(obj);
+	ut_asserteq(42, obj->dims.x);
+	ut_asserteq(18, obj->dims.y);
+
+	ut_asserteq(0, obj->ofs.xofs);
+	ut_asserteq(0, obj->ofs.yofs);
+
+	ut_asserteq(50 + x_offset, obj->bbox.x0);
+	ut_asserteq(100, obj->bbox.y0);
+	ut_asserteq(50 + x_offset + 54, obj->bbox.x1);
+	ut_asserteq(18 + 100, obj->bbox.y1);
+
+	/* all items should have the same, so check them */
+	item = scene_menuitem_find_seq(menu, 1);
+	ut_assertnonnull(item);
+	ut_asserteq(50 + x_offset + 54, obj->bbox.x1);
+
+	item = scene_menuitem_find_seq(menu, 2);
+	ut_assertnonnull(item);
+	ut_asserteq(50 + x_offset + 54, obj->bbox.x1);
+
+	menu = scene_obj_find(scn, ID_POWER_LOSS, SCENEOBJT_MENU);
+	ut_assertnonnull(menu);
+	ut_asserteq(ID_AC_OFF, menu->cur_item_id);
+
+	obj = &menu->obj;
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(120, obj->bbox.y0);
+	ut_asserteq(50 + 160, obj->bbox.x1);
+	ut_asserteq(18 + 120, obj->bbox.y1);
+
+	tline = scene_obj_find(scn, ID_MACHINE_NAME, SCENEOBJT_TEXTLINE);
+	ut_assertnonnull(menu);
+
+	obj = &tline->obj;
+	ut_asserteq(381, obj->dims.x);
+	ut_asserteq(18, obj->dims.y);
+
+	ut_asserteq(50, obj->bbox.x0);
+	ut_asserteq(140, obj->bbox.y0);
+	ut_asserteq(50 + 381, obj->bbox.x1);
+	ut_asserteq(140 + 18, obj->bbox.y1);
+
+	obj = scene_obj_find(scn, ID_MACHINE_NAME_EDIT, SCENEOBJT_TEXT);
+	ut_assertnonnull(obj);
+	ut_asserteq(275, obj->dims.x);
+	ut_asserteq(18, obj->dims.y);
+
+	ut_asserteq(50 + x_offset, obj->bbox.x0);
+	ut_asserteq(140, obj->bbox.y0);
+	ut_asserteq(50 + x_offset + obj->dims.x, obj->bbox.x1);
+	ut_asserteq(140 + 18, obj->bbox.y1);
+
+	return 0;
+}
+BOOTSTD_TEST(cedit_position, UTF_DM | UTF_SCAN_FDT);
-- 
2.43.0

