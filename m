Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C2C5C3600C
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:14:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E8D81E1C;
	Fri, 28 Mar 2025 14:08:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="gQAPNDLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C820C82149; Fri, 28 Mar 2025 14:08:37 +0100 (CET)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6A8828215B
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3d439f01698so10833785ab.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167313; x=1743772113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AtxrDYL74YK+zocJCzzp0N1mL90/QvkRQ1sW+6QRcbs=;
 b=gQAPNDLQpl1piaUG46CeDPUYMLTpQYMsoIsx9t4gJtYu+EvR0P7uvZATRiE6Z/CjY6
 w2sufCbfMY9lZU8bjKYXv0RvABfmPDMUzCvLvmFtvqCW1Ld/QpFAKBOci1oVU29nRM1e
 /AV/SsoX7zCBdxdlsMaQx4G+eJAB/4QKcRh3M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167313; x=1743772113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=AtxrDYL74YK+zocJCzzp0N1mL90/QvkRQ1sW+6QRcbs=;
 b=TF5bD0RLMn4ybiMiWZ80wZMUI5IqQ55PbLrvj9GQktmpoT0dDKJJ8Qn3uNlmI+KMhs
 j9zYSFtW4Q/f09j1lf6EHsr2aafD8lDdnfcJsD2tH8QpBW62uWYa+BF2RdsSH6tQzSGR
 iNb20zpj75GAzho15P6EFxiV6ArJHaUv3M20QmL5qkn03olaoe5MJ2oe8qlzQBT6IfXS
 nmOVXYl0SZM0mCtx8GUE11eHsi6tFK+gkSwCjqt1rK+i7c/cmn9nbCwe1FE47/Dl+wks
 KLJ68t7LYevTpaYtBHvhK2qUzbxUqU8OvQZr+4mQRbWCAn5CozDG0jwAp3RBfPH/V7zW
 kUcw==
X-Gm-Message-State: AOJu0Yx2fapYZzEb4/qkOpsKbPjsvm45gtYapQqnjPKVMNgHaVgpdoW0
 UnJPkUcJqRA4MwY4Tcczt9giW/xuqrA9l8TOaCV31I/qjAKUr9FRzfrUaKLIrwyTS4B+x5w8IT8
 =
X-Gm-Gg: ASbGncuKfoxtbFvobP+Lzma3yZ4hHsuTp2nwF02QhaTtLjNP5MOIAcCaLjhRCJKRlwv
 vOHCOj/oAva/8D1GA8NE7/5hUrGubR2jv9LaKuunS4d+ZkWIc++7dIDALqvBATYqROaDgATuJyB
 ji5TKS4ZoAU5FMbS81WDCNgHjuNHEHvuCsfM2/J7xTqBqzwslccQdFa83Hs1bn6R5cJ9YiNbtTN
 QsQbslz0e17yZropgxstpM8CEeKap3NLJDeBUnEK9IzTU9NtFq0dTGtEXnidC5y3urUwVQp/0od
 WfLU/58rITvqUMpPIYuHP4Ru5Fr1GxvPUfDbZyvTFoWvPCUcimVvOY3psp3z06u+YxSEdmdWYNs
 YahYnpw==
X-Google-Smtp-Source: AGHT+IFYatrobIxNz4z+z3pUzvTLR+10frGpCi3NoJC7izcb13OtQ2j1DX5uISEN6aOuzmGEcYxaQA==
X-Received: by 2002:a05:6e02:4401:10b0:3a9:cde3:2ecc with SMTP id
 e9e14a558f8ab-3d5d6cfd363mr18853865ab.6.1743167313033; 
 Fri, 28 Mar 2025 06:08:33 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:08:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 40/56] expo: Support rendering multiple lines of text
Date: Fri, 28 Mar 2025 07:06:27 -0600
Message-ID: <20250328130713.2612648-41-sjg@chromium.org>
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

 boot/bootflow_menu.c |  2 ++
 boot/scene.c         | 26 ++++++++++++++++++++++----
 include/expo.h       |  4 ++++
 test/boot/expo.c     | 12 +++++++++++-
 4 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/boot/bootflow_menu.c b/boot/bootflow_menu.c
index 19cd84e6454..cadffcf259a 100644
--- a/boot/bootflow_menu.c
+++ b/boot/bootflow_menu.c
@@ -234,6 +234,8 @@ int bootflow_menu_start(struct bootstd_priv *std, bool text_mode,
 	if (text_mode)
 		expo_set_text_mode(exp, text_mode);
 
+	LOGR("bmd", expo_calc_dims(exp));
+
 	*expp = exp;
 
 	return 0;
diff --git a/boot/scene.c b/boot/scene.c
index 8ecfa4f33bb..f24465ef34f 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -8,6 +8,7 @@
 
 #define LOG_CATEGORY	LOGC_EXPO
 
+#include <alist.h>
 #include <dm.h>
 #include <expo.h>
 #include <malloc.h>
@@ -164,6 +165,7 @@ int scene_txt_generic_init(struct expo *exp, struct scene_txt_generic *gen,
 	}
 
 	gen->str_id = str_id;
+	alist_init_struct(&gen->lines, struct vidconsole_mline);
 
 	return 0;
 }
@@ -335,8 +337,8 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 		struct scene_txt_generic *gen = &((struct scene_obj_txt *)obj)->gen;
 		struct expo *exp = scn->expo;
 		struct vidconsole_bbox bbox;
+		int len, ret, limit;
 		const char *str;
-		int len, ret;
 
 		str = expo_get_str(exp, gen->str_id);
 		if (!str)
@@ -350,8 +352,12 @@ int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
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
@@ -417,6 +423,7 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 			    struct scene_txt_generic *gen, int x, int y,
 			    int menu_inset)
 {
+	const struct vidconsole_mline *mline;
 	struct video_priv *vid_priv;
 	struct vidconsole_colour old;
 	enum colour_idx fore, back;
@@ -452,8 +459,16 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
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
 
@@ -463,6 +478,9 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
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

