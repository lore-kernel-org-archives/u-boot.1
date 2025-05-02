Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C918C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:53:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C43B882BAA;
	Fri,  2 May 2025 16:48:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="I/bP4s5I";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4172382ACB; Fri,  2 May 2025 16:48:54 +0200 (CEST)
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com
 [IPv6:2607:f8b0:4864:20::d31])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E296A82B97
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-85b3f92c8dfso71347439f.2
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197330; x=1746802130; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3nPsx3N9jHjmBMMNZvrowOJg6h1btdVQO7sacthgsXA=;
 b=I/bP4s5ITf8Euw00HieIS9troGUQvhu9HTD8T57YE0e7+Cd3Bh7YaGctHYy2nKQM++
 Tmzvj3vF/Cs36uQ/cmkUZlvJTqbU5R2r5m/a2dqP+ylBaiOjHO8lwnCYPOVKY2b4FV/I
 1XYig9irX51f9RfCOAawpjliCFOwKaK3KKcE4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197330; x=1746802130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3nPsx3N9jHjmBMMNZvrowOJg6h1btdVQO7sacthgsXA=;
 b=APTkB9U5P88zj1ZR15z0rJc2nTCToZFHuTq/+OhNJmWfyAtnT5rHy95Rde5Gp7s+Dn
 IAp46jMbZnurcdmzHwE/3c5pR5x7M4y1SsC0QdIw280FpGRcV4Jcolal+ki81+USJHgj
 hye20K3lECP0iay0F3P8cmQKggDR7uRZ1y7bJxdn7wMEjDyBXL/jWh3cQZZLa27SaMFb
 vp4kbtzVBbxHXtM/kMsnxLeKYb4ZVgXB+eY+U9WvldtKjZMN4bHLaKapmBLMTjExlqha
 q9P4S/5SuUj6YH8MVNERiTVQrIGsmqme4lR7Za9X4Si/WGAiUTlqiMsEXvUosSCJLalh
 ihag==
X-Gm-Message-State: AOJu0YzatsfLFUz0LjJH8jhi83Se0L83WNVKJPC3Lhtz0lfPu1RrR1Hd
 axB0pObJvZhrTDjvZJ+G/NxiNjLdDOEnVDcFo9lzqr/3qr163a1SOpg04+5em054cZsFj1nPyog
 =
X-Gm-Gg: ASbGnct/0sQaWnTbpKqdomc898X5n7OqckT//KUiyrDO04ZtUGRg9sUhGlVvyn1M+0n
 ThlKWQHS10J7YzWlFUCmxDrEsuhfl074iaVXhGfIds4Mo46M44EeSQeH4jZJHPZD70jZc66aILC
 4VdegXyl+XXU+BJqWOrwdsVxy+dNXVj9AmwnR6LFG1yjckszumFj7PwFlgWbwcZVGkeyHg6lt+2
 Ij/O8jGQMfSbNro67aV5OiUbP2MSW5GB+n7eQo9L8EicuukvzAEE1rREwdmpB46etq1bgrJoeQh
 fnYSF9zFFGhNTRZ5AJWrGmmNu/8jtSJmojdkgPuLwLT/pJRBcTbrcLGzlRfe+/XmOaCpWN2nEN9
 1Jg==
X-Google-Smtp-Source: AGHT+IFeh5FSs0eX7OKT1qBb8N8WozsVAxwncJEQbOnyc2Y5gTkkpDF4ONhXSJfbv3XIL9+jTApnCg==
X-Received: by 2002:a05:6602:2983:b0:864:3335:d580 with SMTP id
 ca18e2360f4ac-8668c25f974mr459100939f.0.1746197329961; 
 Fri, 02 May 2025 07:48:49 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 44/60] expo: Support rendering multiple lines of text
Date: Fri,  2 May 2025 08:46:42 -0600
Message-ID: <20250502144718.313633-45-sjg@chromium.org>
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

Use the measurement info to write each line of text separately, thus
respecting word-wrapping and newlines.

Fix up the comment for scene_obj_render() while we are here.

Since a lineedit does not support alignment, add a special case to just
display the text if there is no measurement. This happens assuming the
lineedit is initially empty.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

Changes in v2:
- Handle the case of an initially empty string

 boot/bootflow_menu.c |  4 ++++
 boot/scene.c         | 26 ++++++++++++++++++++++----
 include/expo.h       |  4 ++++
 test/boot/expo.c     | 12 +++++++++++-
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 6a37fa8fa68..ab21ed84ffd 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -241,6 +241,10 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	if (text_mode)
 		expo_set_text_mode(exp, text_mode);
 
+	ret = expo_calc_dims(exp);
+	if (ret)
+		return log_msg_ret("bmd", ret);
+
 	*expp = exp;
 
 	return 0;
diff --git a/boot/scene.c b/boot/scene.c
index aacdccdce17..72a8e27a93d 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
+#include <alist.h>
 #include <dm.h>
 #include <expo.h>
 #include <malloc.h>
@@ -163,6 +164,7 @@ int scene_txt_generic_init(struct expo *exp, struct scene_txt_generic *gen,
 	}
 
 	gen->str_id = str_id;
+	alist_init_struct(&gen->lines, struct vidconsole_mline);
 
 	return 0;
 }
@@ -336,8 +338,8 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		struct scene_txt_generic *gen = &((struct scene_obj_txt *)obj)->gen;
 		struct expo *exp = scn->expo;
 		struct vidconsole_bbox bbox;
+		int len, ret, limit;
 		const char *str;
-		int len, ret;
 
 		str = expo_get_str(exp, gen->str_id);
 		if (!str)
@@ -351,8 +353,12 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 			return 16;
 		}
 
+		limit = obj->flags & SCENEOF_SIZE_VALID ?
+			obj->bbox.x1 - obj->bbox.x0 : -1;
+
 		ret = vidconsole_measure(scn->expo->cons, gen->font_name,
-					 gen->font_size, str, -1, &bbox, NULL);
+					 gen->font_size, str, limit, &bbox,
+					 &gen->lines);
 		if (ret)
 			return log_msg_ret("mea", ret);
 		if (widthp)
@@ -418,6 +424,7 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 			    struct scene_txt_generic *gen, int x, int y,
 			    int menu_inset)
 {
+	const struct vidconsole_mline *mline;
 	struct video_priv *vid_priv;
 	struct vidconsole_colour old;
 	enum colour_idx fore, back;
@@ -453,8 +460,16 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 		video_fill_part(dev, x - menu_inset, y, obj->bbox.x1,
 				obj->bbox.y1, vid_priv->colour_bg);
 	}
-	vidconsole_set_cursor_pos(cons, x, y);
-	vidconsole_put_string(cons, str);
+
+	if (!gen->lines.count) {
+		vidconsole_set_cursor_pos(cons, x, y);
+		vidconsole_put_string(cons, str);
+	}
+	alist_for_each(mline, &gen->lines) {
+		vidconsole_set_cursor_pos(cons, x + mline->bbox.x0,
+					  y + mline->bbox.y0);
+		vidconsole_put_stringn(cons, str + mline->start, mline->len);
+	}
 	if (obj->flags & SCENEOF_POINT)
 		vidconsole_pop_colour(cons, &old);
 
@@ -464,6 +479,9 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 /**
  * scene_obj_render() - Render an object
  *
+ * @obj: Object to render
+ * @text_mode: true to use text mode
+ * Return: 0 if OK, -ve on error
  */
 static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 {
diff --git a/include/expo.h b/include/expo.h
index 7c6ab4bf630..a79aa1da74f 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -8,6 +8,7 @@
 #define __EXPO_H
 
 #include <abuf.h>
+#include <alist.h>
 #include <dm/ofnode_decl.h>
 #include <linux/bitops.h>
 #include <linux/list.h>
@@ -296,11 +297,14 @@ struct scene_obj_img {
  * @str_id: ID of the text string to display
  * @font_name: Name of font (allocated by caller)
  * @font_size: Nominal size of font in pixels
+ * @lines: alist of struct vidconsole_mline with a separate record for each
+ *	line of text
  */
 struct scene_txt_generic {
 	uint str_id;
 	const char *font_name;
 	uint font_size;
+	struct alist lines;
 };
 
 /**
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 6fb9f810885..c9ff5b8dd24 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -25,6 +25,7 @@ enum {
 	OBJ_LOGO,
 	OBJ_TEXT,
 	OBJ_TEXT2,
+	OBJ_TEXT3,
 	OBJ_MENU,
 	OBJ_MENU_TITLE,
 
@@ -33,6 +34,7 @@ enum {
 
 	STR_TEXT,
 	STR_TEXT2,
+	STR_TEXT3,
 	STR_MENU_TITLE,
 	STR_POINTER_TEXT,
 
@@ -488,6 +490,14 @@ static int expo_render_image(struct unit_test_state *uts)
 				       60));
 	ut_assertok(scene_obj_set_pos(scn, OBJ_TEXT2, 200, 600));
 
+	id = scene_txt_str(scn, "text", OBJ_TEXT3, STR_TEXT3,
+			   "this is yet\nanother string, with word-wrap",
+			   NULL);
+	ut_assert(id > 0);
+	ut_assertok(scene_txt_set_font(scn, OBJ_TEXT3, "nimbus_sans_l_regular",
+				       60));
+	ut_assertok(scene_obj_set_bbox(scn, OBJ_TEXT3, 500, 200, 1000, 700));
+
 	id = scene_menu(scn, "main", OBJ_MENU, &menu);
 	ut_assert(id > 0);
 
@@ -646,7 +656,7 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
 
-	ut_asserteq(10314, video_compress_fb(uts, dev, false));
+	ut_asserteq(14848, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* make sure only the preview for the second item is shown */
-- 
2.43.0

