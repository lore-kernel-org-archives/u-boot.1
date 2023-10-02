Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB61E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:27:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A3B5F871B1;
	Mon,  2 Oct 2023 03:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Ftk2JqSz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 43B7B8710C; Mon,  2 Oct 2023 03:14:48 +0200 (CEST)
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com
 [IPv6:2607:f8b0:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476E4870DC
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x12c.google.com with SMTP id
 e9e14a558f8ab-35273f62ca3so2591245ab.1
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209257; x=1696814057; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qz9D6EOP0yM840Y955UcgC9XCl13yIsAQh5U9SVRnpM=;
 b=Ftk2JqSzdEwZIJB2tZAHTVqUM6npzIzMfIyXT2w5CHY2uIA5GO6aOPo1vfbLqIpP3n
 ZowNH/XWPSZPZJMl4mhdSp1sYy3GeUsWPkSTwRjQrfiajvxFZNGsjuxiEE1ADaBDd7yh
 JHZGlvlXfoT+ng0CImOqn5p+RT/NC0BnGjK04=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209257; x=1696814057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qz9D6EOP0yM840Y955UcgC9XCl13yIsAQh5U9SVRnpM=;
 b=YuttpJ85vZy36/SEuaQNyA5vkMUp+jYaJLWC1HeUeO+B1Kh5V6ySLje7mBzebpdF2z
 LQb59VHJ0P1vFEOFvVq2hPtDr7kIXg49OrsPyzsuzaUGZe8qehtHYgqh7zOv/LHqEWQu
 JVuKWba8fC6ul3uq/OGHXk4Vah9wPDq/uolfBJDgKa258Aik1H/2E9zSnNeYGx/gjlwm
 CYU8bTQQ4F4RXe3BiNA3pXlg7j9AN8Fdd5uf/EO9PMprq95TKGc304YwqEGi77zLNl4Z
 58pP+QWwerv8o7pA9140zzZvMCKg+eSX5ZA62MkMyKIWBDcGF+NLYIVH4/prXkZ8dVPX
 GhZQ==
X-Gm-Message-State: AOJu0YwV++OJcPCh8odiYDI+2S4uSXImMa1Ip+5Ijnq7R/GxZlSX+P67
 xlwvSivUH75940FkbCw62HGX4utNzFSSrlXH9GI=
X-Google-Smtp-Source: AGHT+IGhGaPN4WTVzOqDo3WNYmp0rwyX/Zn7kiB/VunEQtIz3G7G2inP1hXYjL3kOQ0X+KyQGgPlsw==
X-Received: by 2002:a05:6e02:1c02:b0:34f:7b1e:c568 with SMTP id
 l2-20020a056e021c0200b0034f7b1ec568mr9567720ilh.3.1696209256766; 
 Sun, 01 Oct 2023 18:14:16 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:16 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 28/36] expo: Add basic support for textline objects
Date: Sun,  1 Oct 2023 19:13:32 -0600
Message-ID: <20231002011349.461284-29-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011349.461284-1-sjg@chromium.org>
References: <20231002011349.461284-1-sjg@chromium.org>
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

A textline is a line of text which can be edited by the user. It has a
maximum length (in chracters) but otherwise there are no restrictions.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/Makefile         |   3 +-
 boot/scene_textline.c | 234 ++++++++++++++++++++++++++++++++++++++++++
 include/expo.h        |  36 +++++++
 3 files changed, 272 insertions(+), 1 deletion(-)
 create mode 100644 boot/scene_textline.c

diff --git a/boot/Makefile b/boot/Makefile
index 6ce983b83fa4..ad608598d298 100644
--- a/boot/Makefile
+++ b/boot/Makefile
@@ -56,7 +56,8 @@ ifdef CONFIG_SPL_BUILD
 obj-$(CONFIG_SPL_LOAD_FIT) += common_fit.o
 endif
 
-obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o scene_menu.o expo_build.o
+obj-$(CONFIG_$(SPL_TPL_)EXPO) += expo.o scene.o expo_build.o
+obj-$(CONFIG_$(SPL_TPL_)EXPO) += scene_menu.o scene_textline.o
 
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE) += vbe.o
 obj-$(CONFIG_$(SPL_TPL_)BOOTMETH_VBE_REQUEST) += vbe_request.o
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
new file mode 100644
index 000000000000..2caa81ee1582
--- /dev/null
+++ b/boot/scene_textline.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Implementation of a menu in a scene
+ *
+ * Copyright 2023 Google LLC
+ * Written by Simon Glass <sjg@chromium.org>
+ */
+
+#define LOG_CATEGORY	LOGC_EXPO
+
+#include <common.h>
+#include <expo.h>
+#include <menu.h>
+#include <video_console.h>
+#include "scene_internal.h"
+
+int scene_textline(struct scene *scn, const char *name, uint id, uint max_chars,
+		   struct scene_obj_textline **tlinep)
+{
+	struct scene_obj_textline *tline;
+	char *buf;
+	int ret;
+
+	if (max_chars >= EXPO_MAX_CHARS)
+		return log_msg_ret("chr", -E2BIG);
+
+	ret = scene_obj_add(scn, name, id, SCENEOBJT_TEXTLINE,
+			    sizeof(struct scene_obj_textline),
+			    (struct scene_obj **)&tline);
+	if (ret < 0)
+		return log_msg_ret("obj", -ENOMEM);
+	abuf_init(&tline->buf);
+	if (!abuf_realloc(&tline->buf, max_chars + 1))
+		return log_msg_ret("buf", -ENOMEM);
+	buf = abuf_data(&tline->buf);
+	*buf = '\0';
+	tline->pos = max_chars;
+	tline->max_chars = max_chars;
+
+	if (tlinep)
+		*tlinep = tline;
+
+	return tline->obj.id;
+}
+
+void scene_textline_calc_bbox(struct scene_obj_textline *tline,
+			      struct vidconsole_bbox *bbox,
+			      struct vidconsole_bbox *edit_bbox)
+{
+	const struct expo_theme *theme = &tline->obj.scene->expo->theme;
+
+	bbox->valid = false;
+	scene_bbox_union(tline->obj.scene, tline->label_id, 0, bbox);
+	scene_bbox_union(tline->obj.scene, tline->edit_id, 0, bbox);
+
+	edit_bbox->valid = false;
+	scene_bbox_union(tline->obj.scene, tline->edit_id, theme->menu_inset,
+			 edit_bbox);
+}
+
+int scene_textline_calc_dims(struct scene_obj_textline *tline)
+{
+	struct scene *scn = tline->obj.scene;
+	struct vidconsole_bbox bbox;
+	struct scene_obj_txt *txt;
+	int ret;
+
+	txt = scene_obj_find(scn, tline->edit_id, SCENEOBJT_NONE);
+	if (!txt)
+		return log_msg_ret("dim", -ENOENT);
+
+	ret = vidconsole_nominal(scn->expo->cons, txt->font_name,
+				 txt->font_size, tline->max_chars, &bbox);
+	if (ret)
+		return log_msg_ret("nom", ret);
+
+	if (bbox.valid) {
+		tline->obj.dim.w = bbox.x1 - bbox.x0;
+		tline->obj.dim.h = bbox.y1 - bbox.y0;
+
+		scene_obj_set_size(scn, tline->edit_id, tline->obj.dim.w,
+				   tline->obj.dim.h);
+	}
+
+	return 0;
+}
+
+int scene_textline_arrange(struct scene *scn, struct scene_obj_textline *tline)
+{
+	const bool open = tline->obj.flags & SCENEOF_OPEN;
+	bool point;
+	int x, y;
+	int ret;
+
+	x = tline->obj.dim.x;
+	y = tline->obj.dim.y;
+	if (tline->label_id) {
+		ret = scene_obj_set_pos(scn, tline->label_id, tline->obj.dim.x,
+					y);
+		if (ret < 0)
+			return log_msg_ret("tit", ret);
+
+		ret = scene_obj_set_pos(scn, tline->edit_id,
+					tline->obj.dim.x + 200, y);
+		if (ret < 0)
+			return log_msg_ret("tit", ret);
+
+		ret = scene_obj_get_hw(scn, tline->label_id, NULL);
+		if (ret < 0)
+			return log_msg_ret("hei", ret);
+
+		y += ret * 2;
+	}
+
+	point = scn->highlight_id == tline->obj.id;
+	point &= !open;
+	scene_obj_flag_clrset(scn, tline->edit_id, SCENEOF_POINT,
+			      point ? SCENEOF_POINT : 0);
+
+	return 0;
+}
+
+int scene_textline_send_key(struct scene *scn, struct scene_obj_textline *tline,
+			    int key, struct expo_action *event)
+{
+	const bool open = tline->obj.flags & SCENEOF_OPEN;
+
+	log_debug("key=%d\n", key);
+	switch (key) {
+	case BKEY_QUIT:
+		if (open) {
+			event->type = EXPOACT_CLOSE;
+			event->select.id = tline->obj.id;
+
+			/* Copy the backup text from the scene buffer */
+			memcpy(abuf_data(&tline->buf), abuf_data(&scn->buf),
+			       abuf_size(&scn->buf));
+		} else {
+			event->type = EXPOACT_QUIT;
+			log_debug("menu quit\n");
+		}
+		break;
+	case BKEY_SELECT:
+		if (!open)
+			break;
+		event->type = EXPOACT_CLOSE;
+		event->select.id = tline->obj.id;
+		key = '\n';
+		fallthrough;
+	default: {
+		struct udevice *cons = scn->expo->cons;
+		int ret;
+
+		ret = vidconsole_entry_restore(cons, &scn->entry_save);
+		if (ret)
+			return log_msg_ret("sav", ret);
+		ret = cread_line_process_ch(&scn->cls, key);
+		ret = vidconsole_entry_save(cons, &scn->entry_save);
+		if (ret)
+			return log_msg_ret("sav", ret);
+		break;
+	}
+	}
+
+	return 0;
+}
+
+int scene_textline_render_deps(struct scene *scn,
+			       struct scene_obj_textline *tline)
+{
+	const bool open = tline->obj.flags & SCENEOF_OPEN;
+	struct udevice *cons = scn->expo->cons;
+	struct scene_obj_txt *txt;
+	int ret;
+
+	scene_render_deps(scn, tline->label_id);
+	scene_render_deps(scn, tline->edit_id);
+
+	/* show the vidconsole cursor if open */
+	if (open) {
+		/* get the position within the field */
+		txt = scene_obj_find(scn, tline->edit_id, SCENEOBJT_NONE);
+		if (!txt)
+			return log_msg_ret("cur", -ENOENT);
+
+		if (txt->font_name || txt->font_size) {
+			ret = vidconsole_select_font(cons,
+						     txt->font_name,
+						     txt->font_size);
+		} else {
+			ret = vidconsole_select_font(cons, NULL, 0);
+		}
+
+		ret = vidconsole_entry_restore(cons, &scn->entry_save);
+		if (ret)
+			return log_msg_ret("sav", ret);
+
+		vidconsole_set_cursor_visible(cons, true, txt->obj.dim.x,
+					      txt->obj.dim.y, scn->cls.num);
+	}
+
+	return 0;
+}
+
+int scene_textline_open(struct scene *scn, struct scene_obj_textline *tline)
+{
+	struct udevice *cons = scn->expo->cons;
+	struct scene_obj_txt *txt;
+	int ret;
+
+	/* Copy the text into the scene buffer in case the edit is cancelled */
+	memcpy(abuf_data(&scn->buf), abuf_data(&tline->buf),
+	       abuf_size(&scn->buf));
+
+	/* get the position of the editable */
+	txt = scene_obj_find(scn, tline->edit_id, SCENEOBJT_NONE);
+	if (!txt)
+		return log_msg_ret("cur", -ENOENT);
+
+	vidconsole_set_cursor_pos(cons, txt->obj.dim.x, txt->obj.dim.y);
+	vidconsole_entry_start(cons);
+	cli_cread_init(&scn->cls, abuf_data(&tline->buf), tline->max_chars);
+	scn->cls.insert = true;
+	ret = vidconsole_entry_save(cons, &scn->entry_save);
+	if (ret)
+		return log_msg_ret("sav", ret);
+
+	return 0;
+}
+
+int scene_textline_close(struct scene *scn, struct scene_obj_textline *tline)
+{
+	return 0;
+}
diff --git a/include/expo.h b/include/expo.h
index c470f5be34d3..3260703a7a01 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -150,6 +150,7 @@ struct scene {
  * @SCENEOBJT_IMAGE: Image data to render
  * @SCENEOBJT_TEXT: Text line to render
  * @SCENEOBJT_MENU: Menu containing items the user can select
+ * @SCENEOBJT_TEXTLINE: Line of text the user can edit
  */
 enum scene_obj_t {
 	SCENEOBJT_NONE		= 0,
@@ -158,6 +159,7 @@ enum scene_obj_t {
 
 	/* types from here on can be highlighted */
 	SCENEOBJT_MENU,
+	SCENEOBJT_TEXTLINE,
 };
 
 /**
@@ -318,6 +320,27 @@ struct scene_menitem {
 	struct list_head sibling;
 };
 
+/**
+ * struct scene_obj_textline - information about a textline in a scene
+ *
+ * A textline has a prompt and a line of editable text
+ *
+ * @obj: Basic object information
+ * @label_id: ID of the label text, or 0 if none
+ * @edit_id: ID of the editable text
+ * @max_chars: Maximum number of characters allowed
+ * @buf: Text buffer containing current text
+ * @pos: Cursor position
+ */
+struct scene_obj_textline {
+	struct scene_obj obj;
+	uint label_id;
+	uint edit_id;
+	uint max_chars;
+	struct abuf buf;
+	uint pos;
+};
+
 /**
  * expo_new() - create a new expo
  *
@@ -552,6 +575,19 @@ int scene_txt_str(struct scene *scn, const char *name, uint id, uint str_id,
 int scene_menu(struct scene *scn, const char *name, uint id,
 	       struct scene_obj_menu **menup);
 
+/**
+ *  scene_textline() - create a textline
+ *
+ * @scn: Scene to update
+ * @name: Name to use (this is allocated by this call)
+ * @id: ID to use for the new object (0 to allocate one)
+ * @max_chars: Maximum length of the textline in characters
+ * @tlinep: If non-NULL, returns the new object
+ * Returns: ID number for the object (typically @id), or -ve on error
+ */
+int scene_textline(struct scene *scn, const char *name, uint id, uint max_chars,
+		   struct scene_obj_textline **tlinep);
+
 /**
  * scene_txt_set_font() - Set the font for an object
  *
-- 
2.42.0.582.g8ccd20d70d-goog

