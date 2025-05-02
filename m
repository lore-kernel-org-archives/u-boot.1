Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55904C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:54:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 217CF82C67;
	Fri,  2 May 2025 16:49:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="CDdbNIy1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A16382C4D; Fri,  2 May 2025 16:49:09 +0200 (CEST)
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com
 [IPv6:2607:f8b0:4864:20::d2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33A4582BCD
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:49:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2b.google.com with SMTP id
 ca18e2360f4ac-85e15dc801aso199900239f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197345; x=1746802145; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9doKd79AG54jes+FsmlG/ASSseZ6s5b8HOENiCTtCrU=;
 b=CDdbNIy1ldM0ajSiXxhlUX5PoafeAU9qlz5EQPjEhW9ybdxBWmESLQH6k/VC+snfRA
 dGI+VWHdVuc0crV35z3JHHseB+CsH51sLWKE+pIMoGljMA6FJs/tVKfqnh7QvwGLjvir
 /dL7pQllXs/NhT1aqh/NTq8kFWy4CkrmrL3Lg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197345; x=1746802145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9doKd79AG54jes+FsmlG/ASSseZ6s5b8HOENiCTtCrU=;
 b=IiTpeHdG4okp669PIraaEy84wbs3ALU041FHs8xDno9WwxA1QpSU4Cu70KZrPy5W+B
 //lj1Hpyeyz/VYjVc7/aLZAvO54feCSr9zOypkSn2OMXogI8zdP99QuFvqYtS2mg4gWs
 XrKF2mUzX8W6P+oFIghwgx6NHByqz8WFUvjHNZOUXIZnS2waYpUmwlnJam9XckXOO9nt
 TRLYzZZYHQewpm5Afhy+HBU1CPds0eJe8d2gphti07cq1hQx6qtBTPBzCNkU+SlcXN+K
 JQOc6FcJ3Yw5a7umv6B1cVrQF4s1msXY5W+PirH7sX+Xgu1d5qZvWlm8nqDq1vfyULoY
 130Q==
X-Gm-Message-State: AOJu0YzJN4WH4m0JCE9vBTBxsOnB7XbJlxiDEB4k59a+rQslznFqrOrH
 GRftNxV2OhmkAjPX+1yxXnGcMo4VozXNETdatcI64dU2IMwonsddQw1tnflU1p2JP7BTClFIvBE
 =
X-Gm-Gg: ASbGnctktlWBcnDdBhe7gPYc0xsl9kOqCYA952tlRbVF7CyFGXNWDDcAbpJRDnDEeZA
 sxBot9RSm8+KLrbd3hmnjoi9laqdE2xuX/Aw4eRheenSYinxKLEkwoKjH8iy2/tIiqxFyBU4PTf
 1gY9IIXWGPxDipHKWHW84fPT/oirYByMHIkMX00qQavY9waqsiGlFeQbYhEctSaQ+tVKgTiSHyQ
 pdakn3ENMB4OaKsvYEMy49v6cXHQ1//Z98MrUH+7jENGPg7A6kq2KQsZnm6Ck7FGYcE/6esEgmx
 SBgnBzL5jTgQBPJm3Uo9KcmAQHIuyELY5movOFflsPCW9/Hn6yIDG5EiHjhEJQTcZj2LbWRsWWs
 HIw==
X-Google-Smtp-Source: AGHT+IEeCQMf6f3tN+ylnwH4PrhaasIdYJq7VzucCiC/URUjso+ArWIHqtl1jmaQG/1jrA6YDdwQPA==
X-Received: by 2002:a05:6602:3718:b0:864:677e:ddae with SMTP id
 ca18e2360f4ac-8669f9ac967mr492016739f.6.1746197345466; 
 Fri, 02 May 2025 07:49:05 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:49:04 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 52/60] expo: Support highlighting menu items
Date: Fri,  2 May 2025 08:46:50 -0600
Message-ID: <20250502144718.313633-53-sjg@chromium.org>
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

Expo normally uses a pointer to show the current item. Add support for
highlighting as well, since this makes it easier for the user to see the
current item.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/cedit.c      |  1 +
 boot/scene.c      | 31 +++++++++++++++++++++----------
 boot/scene_menu.c | 14 +++++++++++---
 include/expo.h    |  2 ++
 test/boot/expo.c  | 13 +++++++++++++
 5 files changed, 48 insertions(+), 13 deletions(-)

diff --git a/boot/cedit.c b/boot/cedit.c
index 54810257fb9..8faf230a9e2 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -126,6 +126,7 @@ int cedit_prepare(struct expo *exp, struct udevice *vid_dev,
 		return log_msg_ret("sid", ret);
 
 	exp->popup = true;
+	exp->show_highlight = true;
 
 	/* This is not supported for now */
 	if (0)
diff --git a/boot/scene.c b/boot/scene.c
index c8dc1716f1d..237f2bccc00 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -466,8 +466,10 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
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
@@ -493,7 +495,7 @@ static void scene_render_background(struct scene_obj *obj, bool box_only)
 	if (scene_obj_calc_bbox(obj, bbox))
 		return;
 
-	sel = &bbox[SCENEBB_label];
+	sel = cur_item ? &bbox[SCENEBB_curitem] : &bbox[SCENEBB_label];
 	if (!sel->valid)
 		return;
 
@@ -547,9 +549,13 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
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
@@ -632,13 +638,18 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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
@@ -655,7 +666,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	}
 	case SCENEOBJT_TEXTLINE:
 		if (obj->flags & SCENEOF_OPEN)
-			scene_render_background(obj, true);
+			scene_render_background(obj, true, false);
 		break;
 	case SCENEOBJT_BOX: {
 		struct scene_obj_box *box = (struct scene_obj_box *)obj;
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index de433ece6ee..8db6a2b2f4d 100644
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
index e624a00c2c0..ddfb739f9cf 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -666,6 +666,13 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertok(scene_arrange(scn));
 	ut_asserteq(0, scn->highlight_id);
 
+	scene_set_highlight_id(scn, OBJ_MENU);
+	ut_assertok(scene_arrange(scn));
+	ut_asserteq(OBJ_MENU, scn->highlight_id);
+	ut_assertok(expo_render(exp));
+
+	ut_asserteq(19704, video_compress_fb(uts, dev, false));
+
 	/* move down */
 	ut_assertok(expo_send_key(exp, BKEY_DOWN));
 
@@ -719,6 +726,12 @@ static int expo_render_image(struct unit_test_state *uts)
 	/* make sure there was no console output */
 	ut_assert_console_end();
 
+	/* now try with the highlight */
+	exp->show_highlight = true;
+	ut_assertok(scene_arrange(scn));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(18844, video_compress_fb(uts, dev, false));
+
 	/* now try in text mode */
 	expo_set_text_mode(exp, true);
 	ut_assertok(expo_render(exp));
-- 
2.43.0

