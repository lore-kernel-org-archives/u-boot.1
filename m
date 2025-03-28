Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F4AC3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:15:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BF0A8215E;
	Fri, 28 Mar 2025 14:08:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="AFU/hIiN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5D76A827A6; Fri, 28 Mar 2025 14:08:53 +0100 (CET)
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com
 [IPv6:2607:f8b0:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0530A82604
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12f.google.com with SMTP id
 e9e14a558f8ab-3d4496a34cdso7664415ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167329; x=1743772129; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sE67KMmoLMsyUFvrziY1SE9gKSOVNslXbJ7sGD07sMY=;
 b=AFU/hIiNhZ4iYBG67W27vs92C1FvDr7GCJf7uNcKCUnw/3isw2jowMUz0J9h2NkjQg
 ET1AkpvO6CFTGwxK498ZNarnKV+0sev2CfeohcVUz7zRb7t8jT55/8PBD09cAySPQ65n
 1nfvu1jFPSDnuSJbCZ4dHSFq4WMhbS/pPu/jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167329; x=1743772129;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sE67KMmoLMsyUFvrziY1SE9gKSOVNslXbJ7sGD07sMY=;
 b=EGIJob6Wr8+huirv5Jko68DZ/bP5ZAPPD17ewchc3J025N2kDqLXfiM+MuFXxkQEm0
 X7dYOWF4B2XkOZ1Dm7cQvrlODKP6hrcZ4eCCR+JaRZnGAx0xUcYErhr1oDpcuiaPbbHP
 RYHCSiQoyGdk1HEM47pwLQmMvSuK+qNavoh+E1r1Xu1F59AyGE9qAai02HMw6U73Lhw7
 9TDQ9QNvU8mB+oF3l3EG8wA17rzNDKkUhpLK9CEItE/TnRG82h2FE1oyWqMlVxiIloiB
 0F9NlKjtFhiK8H/NRaPKe7+yg/XIox3AVQaNM+ue2g4GN6ALaJ3jCucSRbaLIckW6Xz1
 Xvrw==
X-Gm-Message-State: AOJu0YxbdbJ9qgndcMwDRJ62k1Dk0TJg0xelWSvRtvCU3cJZ9cQB2tKw
 JEEtOg6bj7Z6Y59srAubS1bh2k+TiPZiIajfZ+jKOgz+t6e5ckr9yGLDlZMm9MoLkb7BJf+l9ao
 =
X-Gm-Gg: ASbGnctjwwM4RHRNsPmbeKfc8OZnGjFxAeeQV+APeLK8fDwVtujN5DQ2hRl39NY0ObU
 dKaaqepTXNv5dszvK4VxsnAp9q4uR9FS1c+N8uCPrRy4akO8QG0JcufMylOdj3QIDLa5asZrcnu
 qqq0fULGfRm3Y+wF5Mdogelf0vdvd3N3WJ+DRik2jmpQ2dwa+CqXgjr2oc2UsoTF95dBpYSBADd
 1ZA+itLGpPLMUyha+ybMOofm1XiiqbyREehJw5iON5XHTxyY281iit/XmIFaCwCeMjofW6eDSi9
 4jDLRbV8uiJCd+VTxGOKnWGZDdp3RltpBPLfKGJ8F5tWoy/QJytnBi4Gy1fJ1vmfyahoNNoL+9u
 zs+MeUA==
X-Google-Smtp-Source: AGHT+IG6ka/rXbZMmZYGzpPX1hpDQg+euDjrQnsJ8yGymX7Lq6UVsm0bBNWjXE4ubc8DFI7qwIA+Ng==
X-Received: by 2002:a05:6e02:2706:b0:3d5:8922:77a0 with SMTP id
 e9e14a558f8ab-3d5cce098d0mr74270685ab.18.1743167328864; 
 Fri, 28 Mar 2025 06:08:48 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:47 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Rasmus Villemoes <ravi@prevas.dk>,
 Stefan Roese <sr@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 48/56] expo: Support highlighting menu items
Date: Fri, 28 Mar 2025 07:06:35 -0600
Message-ID: <20250328130713.2612648-49-sjg@chromium.org>
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
index ee08daaa870..dbb2750c9f2 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -126,6 +126,7 @@ int cedit_prepare(struct expo *exp, struct udevice *vid_dev,
 		return log_msg_ret("sid", ret);
 
 	exp->popup = true;
+	exp->show_highlight = true;
 
 	/* This is not supported for now */
 	if (0)
diff --git a/boot/scene.c b/boot/scene.c
index 956c7219142..15f85c39359 100644
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
@@ -631,13 +637,18 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
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
@@ -654,7 +665,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	}
 	case SCENEOBJT_TEXTLINE:
 		if (obj->flags & SCENEOF_OPEN)
-			scene_render_background(obj, true);
+			scene_render_background(obj, true, false);
 		break;
 	case SCENEOBJT_BOX: {
 		struct scene_obj_box *box = (struct scene_obj_box *)obj;
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index b0c241a9ee9..206c058c11f 100644
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

