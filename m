Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA0AFC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:03:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8E5D826AA;
	Wed, 19 Mar 2025 15:56:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="jmkQAS55";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 770E9827C5; Wed, 19 Mar 2025 15:56:52 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CC238213E
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so32276935e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396209; x=1743001009; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YYi1X7aanGh//PY8Crcz7EdLczUHZjtQ0g5Crp80GMc=;
 b=jmkQAS55Iqj589g5HLQxxemZXe1U6LIh4n34MKnFCMzbmtNq8GksWBlgrqZpHo8qCz
 sv0420aKxjui9QezkPKi5sLJyGoBP5xEPGw3GZTtvL8Gh1NNZWvvughfEk1fJmgUrh8a
 N4gDsVv8DjYcPnzA7d5BkklYZ+BqVPhcAXVW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396209; x=1743001009;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YYi1X7aanGh//PY8Crcz7EdLczUHZjtQ0g5Crp80GMc=;
 b=N1Ec7GEr4VOD1HTx5dYhiTZeItAln6tolOJhpHRsRx5IPrHbi4C5PggZv0HMK4bSAO
 F9M2A9EqXO5xi2dkXzsbJo/GzxCdJ6ZBh3voV3jMHU1F4iBbXkP6oAXBvQ+GnXZp1Won
 ZKFa2IkxXr5k+2SCWzYRdZYCQLvwFijSWUbwzgV1sdnmBubkTAYOoAElW/a7uFlOPRI7
 GwhoxrCs0QPampMsD/yI/T3n36VwRwxaqkfTGvU5+BY5r6Jw7MWEjHhpK5gQl9rB0O+l
 n6MrHuYUeBZz46S8Ea6PhRbRGhM7mi8KesLCmCIzL93zrdS1bmAuS4VSRU95g7dXlthf
 mwHA==
X-Gm-Message-State: AOJu0Yylx1ML0zRxWJn+u+dKsFjzcak9+CPP7/dL1QIP4Q7HPCzphU5I
 dJ2TLjkWOQCLFHNSqrARL119agcdkfO5mAgNOnBmWxIouiihYZUNAAP4AOCCzofw5AOVX3hzSRk
 =
X-Gm-Gg: ASbGncsbKibMr9bBnD0dMovzB6C93q6DTu6uemNQYnjyWDf4xjNRPxDTmuTVseWbeU7
 VJ3dgDIHvb3d4TtUEyHNvuSJGwJ/+0Qg9XzQyeg5DC5dwGYItmzG1Ve+f4nx/t7siNTFy8Zn+H9
 Jcq6XSBBxhtWs/QFS4kvpOi05NzMwQFH6b0gtITqIhrVL7x0J85nMooXjXrv1xrrX8Ubu8tt1q0
 NMIZ74hmCk7MkVFN4UQCdwrf8e6q6mAoZLBohpRAKy5wWQQS4lhie5SAwlLJeEBmqVvLTzQMiOE
 2+PisyQqtR7mzI0m7B0ADzodhZBINLNFi5abQ6KZew==
X-Google-Smtp-Source: AGHT+IGUkUBOh1nl5geX+QrN7a7w15A6w+4zVqa81TWpD2bM3f9kwQPn3MlOjl4O928wnej3cvzyiA==
X-Received: by 2002:a05:600c:1da1:b0:43d:160:cd97 with SMTP id
 5b1f17b1804b1-43d438298c6mr28770855e9.25.1742396208722; 
 Wed, 19 Mar 2025 07:56:48 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 44/52] expo: Support highlighting menu items
Date: Wed, 19 Mar 2025 15:54:49 +0100
Message-ID: <20250319145512.2391122-45-sjg@chromium.org>
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

Expo normally uses a pointer to show the current item. Add support for
highlighting as well, since this makes it easier for the user to see the
current item.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/cedit.c      |  1 +
 boot/scene.c      | 31 +++++++++++++++++++++----------
 boot/scene_menu.c | 14 +++++++++++---
 include/expo.h    |  2 ++
 test/boot/expo.c  | 12 ++++++++++++
 5 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index ead54b47b5b..46a48d69347 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -129,6 +129,7 @@ int cedit_prepare(struct expo *exp, struct video_priv **vid_privp,
 		return log_msg_ret("sid", ret);
 
 	exp->popup = true;
+	exp->show_highlight = true;
 
 	/* This is not supported for now */
 	if (0)
diff --git a/boot/scene.c b/boot/scene.c
index 1f410ede97c..02494fff603 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -465,8 +465,10 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
  * @obj: Object to render
  * @box_only: true to show a box around the object, but keep the normal
  * background colour inside
+ * @cur_item: true to render the background only for the current menu item
  */
-static void scene_render_background(struct scene_obj *obj, bool box_only)
+static void scene_render_background(struct scene_obj *obj, bool box_only,
+				    bool cur_item)
 {
 	struct vidconsole_bbox bbox[SCENEBB_count], *sel;
 	struct expo *exp = obj->scene->expo;
@@ -492,7 +494,7 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 	if (scene_obj_calc_bbox(obj, bbox))
 		return;
 
-	sel = &bbox[SCENEBB_label];
+	sel = cur_item ? &bbox[SCENEBB_curitem] : &bbox[SCENEBB_label];
 	if (!sel->valid)
 		return;
 
@@ -546,9 +548,13 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 	}
 
 	if (obj->flags & SCENEOF_POINT) {
+		int inset;
+
+		inset = exp->popup ? menu_inset : 0;
 		vidconsole_push_colour(cons, fore, back, &old);
-		video_fill_part(dev, x - menu_inset, y, obj->bbox.x1,
-				obj->bbox.y1, vid_priv->colour_bg);
+		video_fill_part(dev, x - inset, y,
+				obj->bbox.x1, obj->bbox.y1,
+				vid_priv->colour_bg);
 	}
 
 	mline = alist_get(&gen->lines, 0, typeof(*mline));
@@ -626,13 +632,18 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	case SCENEOBJT_MENU: {
 		struct scene_obj_menu *menu = (struct scene_obj_menu *)obj;
 
-		if (exp->popup && (obj->flags & SCENEOF_OPEN)) {
-			if (!cons)
-				return -ENOTSUPP;
+		if (exp->popup) {
+			if (obj->flags & SCENEOF_OPEN) {
+				if (!cons)
+					return -ENOTSUPP;
 
-			/* draw a background behind the menu items */
-			scene_render_background(obj, false);
+				/* draw a background behind the menu items */
+				scene_render_background(obj, false, false);
+			}
+		} else if (exp->show_highlight) {
+			/* do nothing */
 		}
+
 		/*
 		 * With a vidconsole, the text and item pointer are rendered as
 		 * normal objects so we don't need to do anything here. The menu
@@ -649,7 +660,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	}
 	case SCENEOBJT_TEXTLINE:
 		if (obj->flags & SCENEOF_OPEN)
-			scene_render_background(obj, true);
+			scene_render_background(obj, true, false);
 		break;
 	case SCENEOBJT_BOX: {
 		struct scene_obj_box *box = (struct scene_obj_box *)obj;
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index fafc058a959..6fa2603bc92 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -87,7 +87,7 @@ struct scene_menitem *scene_menuitem_find_val(const struct scene_obj_menu *menu,
 static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
 {
 	struct scene *scn = menu->obj.scene;
-	const bool stack = scn->expo->popup;
+	const bool stack = scn->expo->show_highlight;
 	const struct scene_menitem *item;
 	int ret;
 
@@ -108,9 +108,17 @@ static int update_pointers(struct scene_obj_menu *menu, uint id, bool point)
 	}
 
 	if (stack) {
+		uint id;
+		int val;
+
 		point &= scn->highlight_id == menu->obj.id;
-		scene_obj_flag_clrset(scn, item->label_id, SCENEOF_POINT,
-				      point ? SCENEOF_POINT : 0);
+		val = point ? SCENEOF_POINT : 0;
+		id = item->desc_id;
+		if (!id)
+			id = item->label_id;
+		if (!id)
+			id = item->key_id;
+		scene_obj_flag_clrset(scn, id, SCENEOF_POINT, val);
 	}
 
 	return 0;
diff --git a/include/expo.h b/include/expo.h
index 16f2f18c4fa..dfecd6ed239 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -106,6 +106,7 @@ struct expo_theme {
  * type set to EXPOACT_NONE if there is no action
  * @text_mode: true to use text mode for the menu (no vidconsole)
  * @popup: true to use popup menus, instead of showing all items
+ * @show_highlight: show a highlight bar on the selected menu item
  * @priv: Private data for the controller
  * @done: Indicates that a cedit session is complete and the user has quit
  * @save: Indicates that cedit data should be saved, rather than discarded
@@ -123,6 +124,7 @@ struct expo {
 	struct expo_action action;
 	bool text_mode;
 	bool popup;
+	bool show_highlight;
 	void *priv;
 	bool done;
 	bool save;
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 515a50f72ec..c574b6732ae 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -666,6 +666,12 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(0, scn->highlight_id);
 
+	scene_set_highlight_id(scn, OBJ_MENU);
+	ut_assertok(scene_arrange(scn));
+	ut_asserteq(OBJ_MENU, scn->highlight_id);
+	ut_assertok(expo_render(exp));
+	ut_asserteq(19804, video_compress_fb(uts, dev, false));
+
 	/* move down */
 	ut_assertok(expo_send_key(exp, BKEY_DOWN));
 
@@ -720,6 +726,12 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* make sure there was no console output */
 	ut_assert_console_end();
 
+	/* now try with the highlight */
+	exp->show_highlight = true;
+	ut_assertok(scene_arrange(scn));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(18943, video_compress_fb(uts, dev, false));
+
 	/* now try in text mode */
 	expo_set_text_mode(exp, true);
 	ut_assertok(expo_render(exp));
-- 
2.43.0

