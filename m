Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF688C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:02:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B21BC8269F;
	Wed, 19 Mar 2025 15:56:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Qq6dEKQQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB2338214F; Wed, 19 Mar 2025 15:56:47 +0100 (CET)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8449082115
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-399737f4fa4so605328f8f.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396202; x=1743001002; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PiQEqR0/KC2zeVcsLjXryoHMuHtCHemPsyq74JlAAqw=;
 b=Qq6dEKQQ3vJZVEX6nMSfG1l9yuuHrIgHG+Y6ca4/ckHw6wgSyBPcUej4FWEVKWh/uF
 V0JwWSmvOVCfbwDw3hbNCNJt3YvGyK2up1bD/gm1lfGy6gfaW9BkXpDNuyRmQS1cmvq9
 +b5OzKYX7KJ8klYC7RoqqE0ipIdj43tP7h60U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396202; x=1743001002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PiQEqR0/KC2zeVcsLjXryoHMuHtCHemPsyq74JlAAqw=;
 b=iG7VFYmSMJgpoHUNdIPRZP20uEshJLB9CDn5sGawVIOoU/dalvzcC6MdW/lNvYxuG9
 yAqeIc+uwRNjC7l3bZLF19agkOPBDxA3E5awFr+GeMsdw4p4Lcvx4YlIz3gHCEf6il56
 RMPLfat7ivYK3bIKV0WVhkmYghCfO64zCtzdnaKINypfN0LsyFzDGprYnKfH8S8lBX5x
 efjzTP/OBZr6qn5YNIPG8wyOSbRXPSmvXuhamqj6t1Rf+8i+d6JIq9EXCFr2QfQCwvfH
 Ye2NNWzkOgs2C0+sECOhTaf/0nJY3lfJmb5pZ0+2/vwhQzkbqUfNTO4GljKGNG3ZTvk9
 yLrQ==
X-Gm-Message-State: AOJu0Yzxecz7AfUEV3LK9Xm2lIBd9UPctnRxzMzXqGLLmPBmkQr8jsP9
 Uu7ulbrwo92FXlHFk4gdq976u2nYPsCZNuPwz4GUgHg5rq//Wbxxsor+xQMVHaRS7/LeQ45Kwso
 =
X-Gm-Gg: ASbGnctWMHd5rVEtemEwdckS+nMse9zBkC72M9LviZ0B9yVv1nNFakcUsr2H7r/xuZt
 ugwpb8l6W7DmHBk6pj5higJxxQOb5kVOeCvfYVD2whSDALsObkgx4zOqzRDEd11z2z6ONw/zsIF
 78Gy3Lxzqtfdg147bVg/zuYXeO5Ofxc6OeQpY0KKiYOS4nnlRkuIztq6BOvjy1/8jGpr5L0HMsa
 E47cIjJYwjX2DkGWQM8dxEhhia7SI7c5+5PkWpPUj0CRHppsIhx0p6tv87XMk9lZ0GhfXrw0wgf
 Yjg0OhT4wlqNKcl/6Ep4t2rL2EY6lVHHUHl2zT675Q==
X-Google-Smtp-Source: AGHT+IF+XHist93ZJ1OsBB+37HeFb+qfImYMT8jC0f3FIysHG4CqEi92XuKXUkbYwfvm1w2FxqhCvA==
X-Received: by 2002:adf:c04d:0:b0:390:f745:bbfb with SMTP id
 ffacd0b85a97d-399739d5c13mr1868083f8f.26.1742396202270; 
 Wed, 19 Mar 2025 07:56:42 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Rasmus Villemoes <ravi@prevas.dk>, Stefan Roese <sr@denx.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 40/52] expo: Begin implementation of a text editor
Date: Wed, 19 Mar 2025 15:54:45 +0100
Message-ID: <20250319145512.2391122-41-sjg@chromium.org>
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

It is useful to be able to edit text, e.g. to allow the user to edit the
environment or the command-line arguments for the OS.

Add the beginnings of an implementation. Future work is needed to finish
this: keypress handling and scrolling. For now it just displays the
text.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/Makefile         |  2 +-
 boot/cedit.c          |  5 ++++
 boot/scene.c          | 30 ++++++++++++++++++++--
 boot/scene_internal.h | 12 +++++++++
 boot/scene_textedit.c | 60 +++++++++++++++++++++++++++++++++++++++++++
 doc/develop/expo.rst  |  1 +
 include/expo.h        | 41 +++++++++++++++++++++++++++++
 test/boot/expo.c      | 16 +++++++++++-
 8 files changed, 163 insertions(+), 4 deletions(-)
 create mode 100644 boot/scene_textedit.c

diff --git a/boot/Makefile b/boot/Makefile
index 284ade3def0..44b962a04f7 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -59,7 +59,7 @@ obj-$(CONFIG_CMD_ADTIMG) += image-android-dt.o
 obj-$(CONFIG_$(PHASE_)LOAD_FIT) += common_fit.o
 
 obj-$(CONFIG_$(PHASE_)EXPO) += expo.o scene.o expo_build.o
-obj-$(CONFIG_$(PHASE_)EXPO) += scene_menu.o scene_textline.o
+obj-$(CONFIG_$(PHASE_)EXPO) += scene_menu.o scene_textline.o scene_textedit.o
 ifdef CONFIG_COREBOOT_SYSINFO
 obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo_build_cb.o
 endif
diff --git a/boot/cedit.c b/boot/cedit.c
index bdf51b50cd4..ead54b47b5b 100644
--- a/boot/cedit.c
+++ b/boot/cedit.c
@@ -82,6 +82,7 @@ int cedit_arange(struct expo *exp, struct video_priv *vpriv, uint scene_id)
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
 		case SCENEOBJT_BOX:
+		case SCENEOBJT_TEXTEDIT:
 			break;
 		case SCENEOBJT_MENU:
 			scene_obj_set_pos(scn, obj->id, 50, y);
@@ -378,6 +379,7 @@ static int h_write_settings(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
 	case SCENEOBJT_BOX:
+	case SCENEOBJT_TEXTEDIT:
 		break;
 	case SCENEOBJT_TEXTLINE: {
 		const struct scene_obj_textline *tline;
@@ -479,6 +481,7 @@ static int h_read_settings(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
 	case SCENEOBJT_BOX:
+	case SCENEOBJT_TEXTEDIT:
 		break;
 	case SCENEOBJT_TEXTLINE: {
 		const struct scene_obj_textline *tline;
@@ -551,6 +554,7 @@ static int h_write_settings_env(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
 	case SCENEOBJT_BOX:
+	case SCENEOBJT_TEXTEDIT:
 		break;
 	case SCENEOBJT_MENU:
 		menu = (struct scene_obj_menu *)obj;
@@ -635,6 +639,7 @@ static int h_read_settings_env(struct scene_obj *obj, void *vpriv)
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
 	case SCENEOBJT_BOX:
+	case SCENEOBJT_TEXTEDIT:
 		break;
 	case SCENEOBJT_MENU:
 		menu = (struct scene_obj_menu *)obj;
diff --git a/boot/scene.c b/boot/scene.c
index 4f9d4a44e2b..1f410ede97c 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -416,13 +416,19 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 			*widthp = width;
 		return height;
 	}
-	case SCENEOBJT_TEXT: {
-		struct scene_txt_generic *gen = &((struct scene_obj_txt *)obj)->gen;
+	case SCENEOBJT_TEXT:
+	case SCENEOBJT_TEXTEDIT: {
+		struct scene_txt_generic *gen;
 		struct expo *exp = scn->expo;
 		struct vidconsole_bbox bbox;
 		int len, ret, limit;
 		const char *str;
 
+		if (obj->type == SCENEOBJT_TEXT)
+			gen = &((struct scene_obj_txt *)obj)->gen;
+		else
+			gen = &((struct scene_obj_txtedit *)obj)->gen;
+
 		str = expo_get_str(exp, gen->str_id);
 		if (!str)
 			return log_msg_ret("str", -ENOENT);
@@ -652,6 +658,13 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 			       obj->bbox.y1, box->width, vid_priv->colour_fg);
 		break;
 	}
+	case SCENEOBJT_TEXTEDIT: {
+		struct scene_obj_txtedit *ted = (struct scene_obj_txtedit *)obj;
+
+		ret = scene_txt_render(exp, dev, cons, obj, &ted->gen, x, y,
+				       theme->menu_inset);
+		break;
+	}
 	}
 
 	return 0;
@@ -671,6 +684,7 @@ int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr)
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
 		case SCENEOBJT_BOX:
+		case SCENEOBJT_TEXTEDIT:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -730,6 +744,7 @@ int scene_arrange(struct scene *scn)
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
 		case SCENEOBJT_BOX:
+		case SCENEOBJT_TEXTEDIT:
 			break;
 		case SCENEOBJT_MENU: {
 			struct scene_obj_menu *menu;
@@ -776,6 +791,7 @@ int scene_render_deps(struct scene *scn, uint id)
 		case SCENEOBJT_IMAGE:
 		case SCENEOBJT_TEXT:
 		case SCENEOBJT_BOX:
+		case SCENEOBJT_TEXTEDIT:
 			break;
 		case SCENEOBJT_MENU:
 			scene_menu_render_deps(scn,
@@ -915,6 +931,9 @@ int scene_send_key(struct scene *scn, int key, struct expo_action *event)
 				return log_msg_ret("key", ret);
 			break;
 		}
+		case SCENEOBJT_TEXTEDIT:
+			/* TODO(sjg@chromium.org): Implement this */
+			break;
 		}
 		return 0;
 	}
@@ -941,6 +960,7 @@ int scene_obj_calc_bbox(struct scene_obj *obj, struct vidconsole_bbox bbox[])
 	case SCENEOBJT_IMAGE:
 	case SCENEOBJT_TEXT:
 	case SCENEOBJT_BOX:
+	case SCENEOBJT_TEXTEDIT:
 		return -ENOSYS;
 	case SCENEOBJT_MENU: {
 		struct scene_obj_menu *menu = (struct scene_obj_menu *)obj;
@@ -971,6 +991,7 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_TEXT:
 		case SCENEOBJT_BOX:
+		case SCENEOBJT_TEXTEDIT:
 		case SCENEOBJT_IMAGE: {
 			int width;
 
@@ -1032,6 +1053,10 @@ int scene_apply_theme(struct scene *scn, struct expo_theme *theme)
 		case SCENEOBJT_BOX:
 		case SCENEOBJT_TEXTLINE:
 			break;
+		case SCENEOBJT_TEXTEDIT:
+			scene_txted_set_font(scn, obj->id, NULL,
+					     theme->font_size);
+			break;
 		case SCENEOBJT_TEXT:
 			scene_txt_set_font(scn, obj->id, NULL,
 					   theme->font_size);
@@ -1073,6 +1098,7 @@ static int scene_obj_open(struct scene *scn, struct scene_obj *obj)
 	case SCENEOBJT_MENU:
 	case SCENEOBJT_TEXT:
 	case SCENEOBJT_BOX:
+	case SCENEOBJT_TEXTEDIT:
 		break;
 	case SCENEOBJT_TEXTLINE:
 		ret = scene_textline_open(scn,
diff --git a/boot/scene_internal.h b/boot/scene_internal.h
index ac2a36d6e4d..760cc629b86 100644
--- a/boot/scene_internal.h
+++ b/boot/scene_internal.h
@@ -414,4 +414,16 @@ int scene_textline_close(struct scene *scn, struct scene_obj_textline *tline);
  */
 int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr);
 
+/**
+ * scene_txt_generic_init() - Set up the generic part of a text object
+ *
+ * @exp: Expo containing the object
+ * @gen: Generic text info
+ * @name: Object name
+ * @str_id: String ID for the text
+ * @str: Initial text string for the object, or NULL to just use str_id
+ */
+int scene_txt_generic_init(struct expo *exp, struct scene_txt_generic *gen,
+			   const char *name, uint str_id, const char *str);
+
 #endif /* __SCENE_INTERNAL_H */
diff --git a/boot/scene_textedit.c b/boot/scene_textedit.c
new file mode 100644
index 00000000000..8f4accc4d7c
--- /dev/null
+++ b/boot/scene_textedit.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Implementation of a menu in a scene
+ *
+ * Copyright 2025 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY	LOGC_EXPO
+
+#include <expo.h>
+#include <log.h>
+#include <linux/err.h>
+#include <linux/sizes.h>
+#include "scene_internal.h"
+
+enum {
+	INITIAL_SIZE	= SZ_4K,
+};
+
+int scene_texted(struct scene *scn, const char *name, uint id, uint str_id,
+		 struct scene_obj_txtedit **teditp)
+{
+	struct scene_obj_txtedit *ted;
+	char *buf;
+	int ret;
+
+	ret = scene_obj_add(scn, name, id, SCENEOBJT_TEXTEDIT,
+			    sizeof(struct scene_obj_txtedit),
+			    (struct scene_obj **)&ted);
+	if (ret < 0)
+		return log_msg_ret("obj", ret);
+
+	abuf_init(&ted->buf);
+	if (!abuf_realloc(&ted->buf, INITIAL_SIZE))
+		return log_msg_ret("buf", -ENOMEM);
+	buf = abuf_data(&ted->buf);
+	*buf = '\0';
+
+	LOGR("teg", scene_txt_generic_init(scn->expo, &ted->gen, name, str_id,
+					   buf));
+	if (teditp)
+		*teditp = ted;
+
+	return ted->obj.id;
+}
+
+int scene_txted_set_font(struct scene *scn, uint id, const char *font_name,
+			 uint font_size)
+{
+	struct scene_obj_txtedit *ted;
+
+	ted = scene_obj_find(scn, id, SCENEOBJT_TEXTEDIT);
+	if (!ted)
+		return log_msg_ret("find", -ENOENT);
+	ted->gen.font_name = font_name;
+	ted->gen.font_size = font_size;
+
+	return 0;
+}
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index d6fc487e030..b94340e9a8d 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -560,6 +560,7 @@ Future ideas
 Some ideas for future work:
 
 - Default menu item and a timeout
+- Complete the text editor
 - Image formats other than BMP
 - Use of ANSI sequences to control a serial terminal
 - Colour selection
diff --git a/include/expo.h b/include/expo.h
index 001f7db2553..16f2f18c4fa 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -183,12 +183,14 @@ struct scene {
  * @SCENEOBJT_TEXT: Text line to render
  * @SCENEOBJT_MENU: Menu containing items the user can select
  * @SCENEOBJT_TEXTLINE: Line of text the user can edit
+ * @SCENEOBJT_TEXTEDIT: Simple text editor
  */
 enum scene_obj_t {
 	SCENEOBJT_NONE		= 0,
 	SCENEOBJT_IMAGE,
 	SCENEOBJT_TEXT,
 	SCENEOBJT_BOX,
+	SCENEOBJT_TEXTEDIT,
 
 	/* types from here on can be highlighted */
 	SCENEOBJT_MENU,
@@ -464,6 +466,21 @@ struct scene_obj_box {
 	uint width;
 };
 
+/**
+ * struct scene_obj_txtedit - information about a box in a scene
+ *
+ * A text editor which allows users to edit a small text file
+ *
+ * @obj: Basic object information
+ * @gen: Generic information common to all objects which show text
+ * @buf: Text buffer containing current text
+ */
+struct scene_obj_txtedit {
+	struct scene_obj obj;
+	struct scene_txt_generic gen;
+	struct abuf buf;
+};
+
 /**
  * struct expo_arrange_info - Information used when arranging a scene
  *
@@ -741,6 +758,19 @@ int scene_textline(struct scene *scn, const char *name, uint id, uint max_chars,
 int scene_box(struct scene *scn, const char *name, uint id, uint width,
 	      struct scene_obj_box **boxp);
 
+/**
+ *  scene_texted() - create a text editor
+ *
+ * @scn: Scene to update
+ * @name: Name to use (this is allocated by this call)
+ * @id: ID to use for the new object (0 to allocate one)
+ * @strid: ID of the string to edit
+ * @teditp: If non-NULL, returns the new object
+ * Returns: ID number for the object (typically @id), or -ve on error
+ */
+int scene_texted(struct scene *scn, const char *name, uint id, uint strid,
+		 struct scene_obj_txtedit **teditp);
+
 /**
  * scene_txt_set_font() - Set the font for an object
  *
@@ -752,6 +782,17 @@ int scene_box(struct scene *scn, const char *name, uint id, uint width,
 int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 		       uint font_size);
 
+/**
+ * scene_txted_set_font() - Set the font for an object
+ *
+ * @scn: Scene to update
+ * @id: ID of object to update
+ * @font_name: Font name to use (allocated by caller)
+ * @font_size: Font size to use (nominal height in pixels)
+ */
+int scene_txted_set_font(struct scene *scn, uint id, const char *font_name,
+			 uint font_size);
+
 /**
  * scene_obj_set_pos() - Set the postion of an object
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 7bea189da04..515a50f72ec 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -30,6 +30,7 @@ enum {
 	OBJ_MENU_TITLE,
 	OBJ_BOX,
 	OBJ_BOX2,
+	OBJ_TEXTED,
 
 	/* strings */
 	STR_SCENE_TITLE,
@@ -37,6 +38,7 @@ enum {
 	STR_TEXT,
 	STR_TEXT2,
 	STR_TEXT3,
+	STR_TEXTED,
 	STR_MENU_TITLE,
 	STR_POINTER_TEXT,
 
@@ -462,6 +464,7 @@ static int expo_render_image(struct unit_test_state *uts)
 {
 	struct scene_obj_menu *menu;
 	struct scene *scn, *scn2;
+	struct abuf orig, *text;
 	struct expo_action act;
 	struct scene_obj *obj;
 	struct udevice *dev;
@@ -556,6 +559,14 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assert(id > 0);
 	ut_assertok(scene_obj_set_bbox(scn, OBJ_BOX, 500, 200, 1000, 350));
 
+	id = scene_texted(scn, "editor", OBJ_TEXTED, STR_TEXTED, NULL);
+	ut_assert(id > 0);
+	ut_assertok(scene_obj_set_bbox(scn, OBJ_TEXTED, 100, 200, 400, 650));
+	ut_assertok(expo_edit_str(exp, STR_TEXTED, &orig, &text));
+
+	abuf_printf(text, "This\nis the initial contents of the text editor "
+		"but it is quite likely that more will be added later");
+
 	scn2 = expo_lookup_scene_id(exp, SCENE1);
 	ut_asserteq_ptr(scn, scn2);
 	scn2 = expo_lookup_scene_id(exp, SCENE2);
@@ -667,9 +678,12 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
 
-	ut_asserteq(16450, video_compress_fb(uts, dev, false));
+	ut_asserteq(19780, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
+	/* hide the text editor since the following tets don't need it */
+	scene_obj_set_hide(scn, OBJ_TEXTED, true);
+
 	/* do some alignment checks */
 	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_CENTRE));
 	ut_assertok(expo_render(exp));
-- 
2.43.0

