Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F58C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:52:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B2BCF82B26;
	Fri,  2 May 2025 16:48:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X1BImo2t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DBB8482B12; Fri,  2 May 2025 16:48:37 +0200 (CEST)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7519F82AFC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-864687c830aso195238639f.0
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197313; x=1746802113; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8wdLBlVoFvd0RmR2lrTQCjM7bFEKUHIKEs+1+pamBlQ=;
 b=X1BImo2tp2kQBuTmzv31HwynH7eHFsfK15RzKAgNOH+kTmLAB7J+bggvZlPN9mC4uu
 Vr5NbURoxWLLXryC5HuHKb9r6VM5X77t/I7ZlbMPRdmiGDqnHzBrW4x5BZGoKqS0p2RJ
 dgaoUzShoqpKwqSwt3fDLjxHtxcZzqMx1aHHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197313; x=1746802113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8wdLBlVoFvd0RmR2lrTQCjM7bFEKUHIKEs+1+pamBlQ=;
 b=qPz6mKDCDhLUOiDb+NIw3TADlAkPThJduCZrKe0Fyqx9FcMbObiMDc29T7or2QZyD7
 ncCpS5jmQ8193JmwXMRYeEYoCszWid0mHta8TSc0BdvWDW/R1p7fKUxBJbdCHq+/sJSf
 8vAO9bmesZvgvL2YN7sZUzCC+cDBi0gcfHyK3mw4fJ5JT85lFUqzv6xZyw1efKfr+lDN
 g3lDDeHMQ0g0kq3XA/qIvrRSY1PittQtm0/eSHY7Tv9TrjK5bTO2m1F/jYG8CTXVR4Vc
 8dZ8j6SDTMWLGUimFRr78HXYIN2cpNGQrKsdbiStk1qAAvZs8bOGIQhzWxoXDyH3MeGo
 0/Fg==
X-Gm-Message-State: AOJu0YyFzdlNv26wuB9Q1Ie9EHPdGS/t1jaHHvffSX0PAINIzzNzuSbi
 LxlZ9aBBNy4BPtu3Yr2xw/T7G3ZC6DNGcAZOj6Bgig2kV5Pqkf55Odi2ki8QmeFszj4cTKag5qI
 =
X-Gm-Gg: ASbGncsNh6CXS0zW+5el2OQed9zpTi4Ani2cB/84WuG3Rf73sTbcXmIbkh3TGf9j6wD
 JeaFQVewopJ3wVmOMCu/egKKxZFkK1dOwJQx56alucjI/xYlrb6hJ3xlnNN2DRlm7ztzaswgXdL
 soExlbkPLMD1Jnazby6tjAsTnsvzYnVFpjfxQwjI1PsbK3UuzM1HJlzqnKxvn119UHmyVADWpwF
 JHABqronwasS4tYVgaVURrzGY4rnx3i5v31FiO9qB9el7P0RyMPVeo7t+mJUXDOQpea+LMukhwi
 wQHaDbsobYdC+T+zwZQr3nympXrDsXKxpEtka8TJeHOnH/4pGcpLNdf0dnnALfVNRLbNtrJ3Pci
 wpQ==
X-Google-Smtp-Source: AGHT+IEurRtpCOUy/3VG4evOMAynWHmNz5GIG3qZehSXh3gjQGmONEQ5Rb0zO8m2OhKohGmeYftpOg==
X-Received: by 2002:a05:6602:29c2:b0:867:97b:2268 with SMTP id
 ca18e2360f4ac-867097b2319mr4108039f.1.1746197312585; 
 Fri, 02 May 2025 07:48:32 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:31 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 35/60] expo: Separate dimensions from the bounding box
Date: Fri,  2 May 2025 08:46:33 -0600
Message-ID: <20250502144718.313633-36-sjg@chromium.org>
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

At present each object has a width and height and the bounding box is
implicit in that.

This is not flexible enough to handle objects which are larger than
their contents might need. For example, when centring a text object we
might want to have it stretch across the whole width of the display even
if the text itself does not need that much space.

Create a new 'dimensions' field and convert the existing width/height
into x1/y1 coordinates.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c          | 31 +++++++++++++++++++++----------
 boot/scene_menu.c     |  7 +++++--
 boot/scene_textline.c | 18 ++++++++++++------
 include/expo.h        | 31 ++++++++++++++++++++++++++-----
 test/boot/expo.c      | 20 ++++++++++----------
 5 files changed, 74 insertions(+), 33 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index 49dac90ceed..325dd23641f 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -206,12 +206,17 @@ int scene_txt_set_font(struct scene *scn, uint id, const char *font_name,
 int scene_obj_set_pos(struct scene *scn, uint id, int x, int y)
 {
 	struct scene_obj *obj;
+	int w, h;
 
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
+	w = obj->bbox.x1 - obj->bbox.x0;
+	h = obj->bbox.y1 - obj->bbox.y0;
 	obj->bbox.x0 = x;
 	obj->bbox.y0 = y;
+	obj->bbox.x1 = obj->bbox.x0 + w;
+	obj->bbox.y1 = obj->bbox.y0 + h;
 
 	return 0;
 }
@@ -223,8 +228,9 @@ int scene_obj_set_size(struct scene *scn, uint id, int w, int h)
 	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
 	if (!obj)
 		return log_msg_ret("find", -ENOENT);
-	obj->bbox.w = w;
-	obj->bbox.h = h;
+	obj->bbox.x1 = obj->bbox.x0 + w;
+	obj->bbox.y1 = obj->bbox.y0 + h;
+	obj->flags |= SCENEOF_SIZE_VALID;
 
 	return 0;
 }
@@ -419,8 +425,8 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 			if (obj->flags & SCENEOF_POINT) {
 				vidconsole_push_colour(cons, fore, back, &old);
 				video_fill_part(dev, x - theme->menu_inset, y,
-						x + obj->bbox.w,
-						y + obj->bbox.h,
+						obj->bbox.x1,
+						obj->bbox.y1,
 						vid_priv->colour_bg);
 			}
 			vidconsole_set_cursor_pos(cons, x, y);
@@ -765,8 +771,13 @@ int scene_calc_dims(struct scene *scn, bool do_menus)
 				ret = scene_obj_get_hw(scn, obj->id, &width);
 				if (ret < 0)
 					return log_msg_ret("get", ret);
-				obj->bbox.w = width;
-				obj->bbox.h = ret;
+				obj->dims.x = width;
+				obj->dims.y = ret;
+				if (!(obj->flags & SCENEOF_SIZE_VALID)) {
+					obj->bbox.x1 = obj->bbox.x0 + width;
+					obj->bbox.y1 = obj->bbox.y0 + ret;
+					obj->flags |= SCENEOF_SIZE_VALID;
+				}
 			}
 			break;
 		}
@@ -917,13 +928,13 @@ int scene_bbox_union(struct scene *scn, uint id, int inset,
 	if (bbox->valid) {
 		bbox->x0 = min(bbox->x0, obj->bbox.x0 - inset);
 		bbox->y0 = min(bbox->y0, obj->bbox.y0);
-		bbox->x1 = max(bbox->x1, obj->bbox.x0 + obj->bbox.w + inset);
-		bbox->y1 = max(bbox->y1, obj->bbox.y0 + obj->bbox.h);
+		bbox->x1 = max(bbox->x1, obj->bbox.x1 + inset);
+		bbox->y1 = max(bbox->y1, obj->bbox.y1);
 	} else {
 		bbox->x0 = obj->bbox.x0 - inset;
 		bbox->y0 = obj->bbox.y0;
-		bbox->x1 = obj->bbox.x0 + obj->bbox.w + inset;
-		bbox->y1 = obj->bbox.y0 + obj->bbox.h;
+		bbox->x1 = obj->bbox.x1 + inset;
+		bbox->y1 = obj->bbox.y1;
 		bbox->valid = true;
 	}
 
diff --git a/boot/scene_menu.c b/boot/scene_menu.c
index c47c2030527..dbc6793e302 100644
--- a/boot/scene_menu.c
+++ b/boot/scene_menu.c
@@ -186,8 +186,8 @@ int scene_menu_calc_dims(struct scene_obj_menu *menu)
 	}
 
 	if (bbox.valid) {
-		menu->obj.bbox.w = bbox.x1 - bbox.x0;
-		menu->obj.bbox.h = bbox.y1 - bbox.y0;
+		menu->obj.dims.x = bbox.x1 - bbox.x0;
+		menu->obj.dims.y = bbox.y1 - bbox.y0;
 	}
 
 	return 0;
@@ -295,6 +295,9 @@ int scene_menu_arrange(struct scene *scn, struct expo_arrange_info *arr,
 
 	if (sel_id)
 		menu_point_to_item(menu, sel_id);
+	menu->obj.bbox.x1 = menu->obj.bbox.x0 + menu->obj.dims.x;
+	menu->obj.bbox.y1 = menu->obj.bbox.y0 + menu->obj.dims.y;
+	menu->obj.flags |= SCENEOF_SIZE_VALID;
 
 	return 0;
 }
diff --git a/boot/scene_textline.c b/boot/scene_textline.c
index a513d555ded..f1d6ff7607c 100644
--- a/boot/scene_textline.c
+++ b/boot/scene_textline.c
@@ -61,7 +61,8 @@ void scene_textline_calc_bbox(struct scene_obj_textline *tline,
 
 int scene_textline_calc_dims(struct scene_obj_textline *tline)
 {
-	struct scene *scn = tline->obj.scene;
+	struct scene_obj *obj = &tline->obj;
+	struct scene *scn = obj->scene;
 	struct vidconsole_bbox bbox;
 	struct scene_obj_txt *txt;
 	int ret;
@@ -76,11 +77,16 @@ int scene_textline_calc_dims(struct scene_obj_textline *tline)
 		return log_msg_ret("nom", ret);
 
 	if (bbox.valid) {
-		tline->obj.bbox.w = bbox.x1 - bbox.x0;
-		tline->obj.bbox.h = bbox.y1 - bbox.y0;
-
-		scene_obj_set_size(scn, tline->edit_id, tline->obj.bbox.w,
-				   tline->obj.bbox.h);
+		obj->dims.x = bbox.x1 - bbox.x0;
+		obj->dims.y = bbox.y1 - bbox.y0;
+		if (!(obj->flags & SCENEOF_SIZE_VALID)) {
+			obj->bbox.x1 = obj->bbox.x0 + obj->dims.x;
+			obj->bbox.y1 = obj->bbox.y0 + obj->dims.y;
+			obj->flags |= SCENEOF_SIZE_VALID;
+		}
+		scene_obj_set_size(scn, tline->edit_id,
+				   obj->bbox.x1 - obj->bbox.x0,
+				   obj->bbox.y1 - obj->bbox.y0);
 	}
 
 	return 0;
diff --git a/include/expo.h b/include/expo.h
index b6de0310071..6f0547a4b38 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -9,6 +9,7 @@
 
 #include <abuf.h>
 #include <dm/ofnode_decl.h>
+#include <linux/bitops.h>
 #include <linux/list.h>
 
 struct udevice;
@@ -196,14 +197,29 @@ enum scene_obj_t {
  *
  * @x0: x position, in pixels from left side
  * @y0: y position, in pixels from top
- * @w: width, in pixels
- * @h: height, in pixels
+ * @x1: x position of right size
+ * @y1: y position of bottom
  */
 struct scene_obj_bbox {
 	int x0;
 	int y0;
-	int w;
-	int h;
+	int x1;
+	int y1;
+};
+
+/**
+ * struct scene_obj_dims - Dimensions of the object being drawn
+ *
+ * Image and text objects have a dimension which can change depending on what
+ * they contain. For images this stores the size. For text it stores the size as
+ * rendered on the display
+ *
+ * @x: x dimension
+ * @y: y dimension
+ */
+struct scene_obj_dims {
+	int x;
+	int y;
 };
 
 /**
@@ -213,11 +229,14 @@ struct scene_obj_bbox {
  * @SCENEOF_POINT: object should be highlighted
  * @SCENEOF_OPEN: object should be opened (e.g. menu is opened so that an option
  * can be selected)
+ * @SCENEOF_SIZE_VALID: object's size (width/height) is valid, so any adjustment
+ * to x0/y0 should maintain the width/height of the object
  */
 enum scene_obj_flags_t {
 	SCENEOF_HIDE	= 1 << 0,
 	SCENEOF_POINT	= 1 << 1,
 	SCENEOF_OPEN	= 1 << 2,
+	SCENEOF_SIZE_VALID	= BIT(3),
 };
 
 enum {
@@ -232,7 +251,8 @@ enum {
  * @name: Name of the object (allocated)
  * @id: ID number of the object
  * @type: Type of this object
- * @bbox: Dimensions for this object
+ * @bbox: Bounding box for this object
+ * @dims: Dimensions of the text/image (may be smaller than bbox)
  * @flags: Flags for this object
  * @bit_length: Number of bits used for this object in CMOS RAM
  * @start_bit: Start bit to use for this object in CMOS RAM
@@ -244,6 +264,7 @@ struct scene_obj {
 	uint id;
 	enum scene_obj_t type;
 	struct scene_obj_bbox bbox;
+	struct scene_obj_dims dims;
 	u8 flags;
 	u8 bit_length;
 	u16 start_bit;
diff --git a/test/boot/expo.c b/test/boot/expo.c
index 9c940825278..94c13e9b71f 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -550,39 +550,39 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_assertnonnull(obj);
 	ut_asserteq(400, obj->bbox.x0);
 	ut_asserteq(100, obj->bbox.y0);
-	ut_asserteq(126, obj->bbox.w);
-	ut_asserteq(40, obj->bbox.h);
+	ut_asserteq(400 + 126, obj->bbox.x1);
+	ut_asserteq(100 + 40, obj->bbox.y1);
 
 	/* check dimensions of image */
 	obj = scene_obj_find(scn, OBJ_LOGO, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(20, obj->bbox.y0);
-	ut_asserteq(160, obj->bbox.w);
-	ut_asserteq(160, obj->bbox.h);
+	ut_asserteq(50 + 160, obj->bbox.x1);
+	ut_asserteq(20 + 160, obj->bbox.y1);
 
 	/* check dimensions of menu labels - both should be the same width */
 	obj = scene_obj_find(scn, ITEM1_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(436, obj->bbox.y0);
-	ut_asserteq(29, obj->bbox.w);
-	ut_asserteq(18, obj->bbox.h);
+	ut_asserteq(50 + 29, obj->bbox.x1);
+	ut_asserteq(436 + 18, obj->bbox.y1);
 
 	obj = scene_obj_find(scn, ITEM2_LABEL, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(454, obj->bbox.y0);
-	ut_asserteq(29, obj->bbox.w);
-	ut_asserteq(18, obj->bbox.h);
+	ut_asserteq(50 + 29, obj->bbox.x1);
+	ut_asserteq(454 + 18, obj->bbox.y1);
 
 	/* check dimensions of menu */
 	obj = scene_obj_find(scn, OBJ_MENU, SCENEOBJT_NONE);
 	ut_assertnonnull(obj);
 	ut_asserteq(50, obj->bbox.x0);
 	ut_asserteq(400, obj->bbox.y0);
-	ut_asserteq(160, obj->bbox.w);
-	ut_asserteq(160, obj->bbox.h);
+	ut_asserteq(50 + 160, obj->bbox.x1);
+	ut_asserteq(400 + 160, obj->bbox.y1);
 
 	/* render it */
 	expo_set_scene_id(exp, SCENE1);
-- 
2.43.0

