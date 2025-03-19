Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D32AC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:01:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9BBC8212A;
	Wed, 19 Mar 2025 15:56:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="W/hbCxBK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34CCB82160; Wed, 19 Mar 2025 15:56:38 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0BBF582163
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:56:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso42244215e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396195; x=1743000995; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EBR0DRZEPBmI8Dm7whz9wzOYQXlgGeDhnSkUWzWEENo=;
 b=W/hbCxBKFUtL8mcWzt886ENaqtUOR+IQE8fi0GZaQOXZ8MnMxeBFh0qgpkWMVPA3bZ
 4sQJHDhtXroWKppMnOgwSiN7wTFN3xwluv02XsQDyEACg/zCeibqSdV6OOYfUJC/6rES
 YsPRCtla8dpI1dFAUqRZzQx+N5u50rREC1+rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396195; x=1743000995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EBR0DRZEPBmI8Dm7whz9wzOYQXlgGeDhnSkUWzWEENo=;
 b=WUNZMkvm0UKQeec4NTblCA3WWNM9sezhTqmTahTmeArqmPvR+8ByPgoqoH6wI58m21
 nTr1LcUzfqM/ROV/62QxkfU9YGhxq3Wyd1/0mjTtILS8vnIoXf4J6RgPPDCADIn0EQDE
 CSU7Wg0nBEOEYaC7tHvY9WELEqRZRbUZWe54Zp48VeyYoxcgfU4/dCZeO/hTviDoXbUk
 TLJ7P5r2mUw854hu4W6GyrW/V/xVbAnQHfLZrwMiLTMbj6sZCEDn2NJJ+XUqgO+mgdAD
 tpjGFK1NuQdm/PkDWpGm0lavN4hrAZMyB7s4A+e+kIe7EOWoftwVxBFSfLyeCIjq/Rr7
 J/rA==
X-Gm-Message-State: AOJu0YzRg++3IV+erxMk79kScAOavLOtyHrtReljM7UKpf/m2Fv0jCgd
 7XrUIPPr+WN8H6oUyMnvZKVi6UD5u3wWgpsmmbN3N16Wht8yNvtSqpEhXz0WqvJk2Ec7RkHqLrc
 =
X-Gm-Gg: ASbGncsa6x+5IrtdkCj7mbCCqQjP0NiHhxc1bqohZBW6DrXdye366GcoxZZFUO1Y2X4
 i2t6UZAIPdz/pLzE9QGwhnwKgdAEA+iArGH1g1Y7w33imPc6Ln/otFuZ5ideoKHFW8YHu2IOc6M
 bswvJ5WK6MHwbwI17hh8UvSfNGSmRb05gjVfp+B09UZlzjtOPMWe8Ja5Laxf7M90D2/qI+8QFxV
 OvcEmQwe5QF6TUFFOk7sAepF0sG2cOYgjqfgpN7lFb65rP2TpCwR6muu7OBRHOV6fJ4Hf1PO4+Z
 k8RLE5gSDbnOACcks1VWmfrOyx37VG6JuCINNCqdrw==
X-Google-Smtp-Source: AGHT+IHQJHXfRgh/zIUggyKmUEP+U7MEwpv0EoQkcv0arUG3GeuKStxfH2E6hfABp/p98WC/nurOPw==
X-Received: by 2002:a05:6000:401f:b0:390:e7c1:59c4 with SMTP id
 ffacd0b85a97d-399739c1f63mr4049571f8f.13.1742396194648; 
 Wed, 19 Mar 2025 07:56:34 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.56.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:56:34 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Quentin Schulz <quentin.schulz@cherry.de>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 36/52] expo: Support rendering multiple lines of text
Date: Wed, 19 Mar 2025 15:54:41 +0100
Message-ID: <20250319145512.2391122-37-sjg@chromium.org>
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

Use the measurement info to write each line of text separately, thus
respecting word-wrapping and newlines.

Fix up the comment for scene_obj_render() while we are here.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 boot/bootflow_menu.c |  2 ++
 boot/scene.c         | 22 ++++++++++++++++++----
 include/expo.h       |  4 ++++
 test/boot/expo.c     | 12 +++++++++++-
 4 files changed, 35 insertions(+), 5 deletions(-)

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
index 8ecfa4f33bb..96e8304d8d2 100644
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
@@ -452,8 +459,12 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 		video_fill_part(dev, x - menu_inset, y, obj->bbox.x1,
 				obj->bbox.y1, vid_priv->colour_bg);
 	}
-	vidconsole_set_cursor_pos(cons, x, y);
-	vidconsole_put_string(cons, str);
+
+	alist_for_each(mline, &gen->lines) {
+		vidconsole_set_cursor_pos(cons, x + mline->bbox.x0,
+					  y + mline->bbox.y0);
+		vidconsole_put_stringn(cons, str + mline->start, mline->len);
+	}
 	if (obj->flags & SCENEOF_POINT)
 		vidconsole_pop_colour(cons, &old);
 
@@ -463,6 +474,9 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
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
index ba60267f00c..9e0e3f207e0 100644
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
 
-	ut_asserteq(10345, video_compress_fb(uts, dev, false));
+	ut_asserteq(14951, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* make sure only the preview for the second item is shown */
-- 
2.43.0

