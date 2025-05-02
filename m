Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E91C3ABAC
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:54:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2ED082B16;
	Fri,  2 May 2025 16:49:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="g7v3Q+Il";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 523A982C10; Fri,  2 May 2025 16:49:01 +0200 (CEST)
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com
 [IPv6:2607:f8b0:4864:20::d34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B41082BA7
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:48:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd34.google.com with SMTP id
 ca18e2360f4ac-86192b64d0bso208115539f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197337; x=1746802137; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b+a5GXutQjwd5xQCpHp3Oa1Lcro6iLmQsY3tL4xEUec=;
 b=g7v3Q+IlkWbUF5lkyigOAAXRlNhfdqoFicAOjEx7fPqG2LCGgxg0DQ/Kxizq/xKxqP
 tcXqDbmPISYKeU0VnwNEkuqGVvQkOKh35c/jrH/4WlAdDee9je7T/SZoyqjOGvcKa+UM
 GP4FZUeRtRgkJ6Tt5W6UOxzFXpBXsDyl405nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197337; x=1746802137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b+a5GXutQjwd5xQCpHp3Oa1Lcro6iLmQsY3tL4xEUec=;
 b=TVedudK9vBp1K2t++zJSsTCPW4rDtkmMscT8kXaYK6BglJYMR+K7ZVbhvPo3qRqgex
 bpz7NZu7ZmSXN5ikmloYlZlwg+RJEaf8QXYTntmZmsonvg8MzQAv7I4V7E22fpiypUda
 h0TruvM0VVJ7RLzOP4Std6HCQ5UqrKMKJEOvg43/u+omccOcW6rFkzokw04TSCTC3egL
 1U34WQs6TGXS50rCi7MGF7fZrJMd076r0lCOfXamtr+1aacc6FQl8X2KX298wNE9OMjE
 rwoFKWT4qF7DW7zUFROwboxfuMZiPj85RhlkNjUecwqHIjtOl5OQxod3vPGbJP0LkVAv
 izZA==
X-Gm-Message-State: AOJu0YxVBIHZcuR1o2P1pb2YOlYGiwFLA7RpXmXDE0pC6d876NJONdFs
 lZfcoMz4VE2oGx0l5c4Sk27G2e7g9MOcj7ie1d6dt1SRWZnD5eKocnmGsDF0kAQPs+Ff48FQW1c
 =
X-Gm-Gg: ASbGncvVsoXblQS5DQDWDDnQzAjun8r/wps63xs+/UstvzLMFxd/iP76qTinrWWpLUL
 oH0zaYFmYp+JE39py9R2ePBtoK/AE1MVhdiSXIizfFoWcu4oUF739skBN1GWixBYIWL+XKxUiLp
 Vt1pPWt5b5+OXbL+cz5f6J860umozZVQQhpAm5bvOutsf47mOOKWaE+UIkwm3s4s0IHfsY7B8ON
 mFnDA2ErPUHUOw+hLCZfmAIdE4654lcTcW3wfenHa/EcNhqFJ91Pt8Uzm/4E7BOiRWico6WDmtt
 xuWfuVVb/eiv5EK4b59ugNKgBHl2lPSw2Gn3fSsC31JTVz5dDeFUKEHClkomCehOgZuEsHywWRg
 I2A==
X-Google-Smtp-Source: AGHT+IEa1ZQp+071sFjyFW7aKteLKLGPNPzXfp4H+fSKW5Bt98EOboz7dkC/qN/C+415/IorXoYxLw==
X-Received: by 2002:a05:6602:2748:b0:862:6667:5dc1 with SMTP id
 ca18e2360f4ac-866b3344a58mr453263339f.5.1746197336628; 
 Fri, 02 May 2025 07:48:56 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:48:55 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 47/60] expo: Support object alignment
Date: Fri,  2 May 2025 08:46:45 -0600
Message-ID: <20250502144718.313633-48-sjg@chromium.org>
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

Add support for left, right and centred alignment for text, in the
horizontal dimension.

Also support top, bottom and centred in the vertical dimension, for the
text object as a whole.

Alignment is not yet implemented for images. It has no meaning for
menus. A textline object uses a text object internally, so alignment
is supported there.

Provide some documentation to explain how objects are positioned.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 boot/scene.c         | 107 +++++++++++++++++++++++++++++++++++++++++--
 doc/develop/expo.rst |  31 +++++++++++++
 include/expo.h       |  63 +++++++++++++++++++++++++
 test/boot/expo.c     |  23 ++++++++--
 4 files changed, 216 insertions(+), 8 deletions(-)

diff --git a/boot/scene.c b/boot/scene.c
index f971db9aab4..3091a9e0ab1 100644
--- a/boot/scene.c
+++ b/boot/scene.c
@@ -306,6 +306,30 @@ int scene_obj_set_bbox(struct scene *scn, uint id, int x0, int y0, int x1,
 	return 0;
 }
 
+int scene_obj_set_halign(struct scene *scn, uint id, enum scene_obj_align aln)
+{
+	struct scene_obj *obj;
+
+	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
+	if (!obj)
+		return log_msg_ret("osh", -ENOENT);
+	obj->horiz = aln;
+
+	return 0;
+}
+
+int scene_obj_set_valign(struct scene *scn, uint id, enum scene_obj_align aln)
+{
+	struct scene_obj *obj;
+
+	obj = scene_obj_find(scn, id, SCENEOBJT_NONE);
+	if (!obj)
+		return log_msg_ret("osv", -ENOENT);
+	obj->vert = aln;
+
+	return 0;
+}
+
 int scene_obj_set_hide(struct scene *scn, uint id, bool hide)
 {
 	int ret;
@@ -331,6 +355,44 @@ int scene_obj_flag_clrset(struct scene *scn, uint id, uint clr, uint set)
 	return 0;
 }
 
+static void handle_alignment(enum scene_obj_align horiz,
+			     enum scene_obj_align vert,
+			     struct scene_obj_bbox *bbox,
+			     struct scene_obj_dims *dims,
+			     int xsize, int ysize,
+			     struct scene_obj_offset *offset)
+{
+	int width, height;
+
+	width = bbox->x1 - bbox->x0;
+	height = bbox->y1 - bbox->y0;
+
+	switch (horiz) {
+	case SCENEOA_CENTRE:
+		offset->xofs = (width - dims->x) / 2;
+		break;
+	case SCENEOA_RIGHT:
+		offset->xofs = width - dims->x;
+		break;
+	case SCENEOA_LEFT:
+		offset->xofs = 0;
+		break;
+	}
+
+	switch (vert) {
+	case SCENEOA_CENTRE:
+		offset->yofs = (height - dims->y) / 2;
+		break;
+	case SCENEOA_BOTTOM:
+		offset->yofs = height - dims->y;
+		break;
+	case SCENEOA_TOP:
+	default:
+		offset->yofs = 0;
+		break;
+	}
+}
+
 int scene_obj_get_hw(struct scene *scn, uint id, int *widthp)
 {
 	struct scene_obj *obj;
@@ -445,10 +507,12 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 			    struct scene_txt_generic *gen, int x, int y,
 			    int menu_inset)
 {
-	const struct vidconsole_mline *mline;
+	const struct vidconsole_mline *mline, *last;
 	struct video_priv *vid_priv;
 	struct vidconsole_colour old;
 	enum colour_idx fore, back;
+	struct scene_obj_dims dims;
+	struct scene_obj_bbox bbox;
 	const char *str;
 	int ret;
 
@@ -482,13 +546,33 @@ static int scene_txt_render(struct expo *exp, struct udevice *dev,
 				obj->bbox.y1, vid_priv->colour_bg);
 	}
 
-	if (!gen->lines.count) {
+	mline = alist_get(&gen->lines, 0, typeof(*mline));
+	last = alist_get(&gen->lines, gen->lines.count - 1, typeof(*mline));
+	if (mline)
+		dims.y = last->bbox.y1 - mline->bbox.y0;
+	bbox.y0 = obj->bbox.y0;
+	bbox.y1 = obj->bbox.y1;
+
+	if (!mline) {
 		vidconsole_set_cursor_pos(cons, x, y);
 		vidconsole_put_string(cons, str);
 	}
+
 	alist_for_each(mline, &gen->lines) {
-		vidconsole_set_cursor_pos(cons, x + mline->bbox.x0,
-					  y + mline->bbox.y0);
+		struct scene_obj_offset offset;
+
+		bbox.x0 = obj->bbox.x0;
+		bbox.x1 = obj->bbox.x1;
+		dims.x = mline->bbox.x1 - mline->bbox.x0;
+		handle_alignment(obj->horiz, obj->vert, &bbox, &dims,
+				 obj->bbox.x1 - obj->bbox.x0,
+				 obj->bbox.y1 - obj->bbox.y0, &offset);
+
+		x = obj->bbox.x0 + offset.xofs;
+		y = obj->bbox.y0 + offset.yofs + mline->bbox.y0;
+		if (y > bbox.y1)
+			break;	/* clip this line and any following */
+		vidconsole_set_cursor_pos(cons, x, y);
 		vidconsole_put_stringn(cons, str + mline->start, mline->len);
 	}
 	if (obj->flags & SCENEOF_POINT)
@@ -515,7 +599,7 @@ static int scene_obj_render(struct scene_obj *obj, bool text_mode)
 	int x, y, ret;
 
 	y = obj->bbox.y0;
-	x = obj->bbox.x0;
+	x = obj->bbox.x0 + obj->ofs.xofs;
 	vid_priv = dev_get_uclass_priv(dev);
 
 	switch (obj->type) {
@@ -626,14 +710,27 @@ int scene_calc_arrange(struct scene *scn, struct expo_arrange_info *arr)
 int scene_arrange(struct scene *scn)
 {
 	struct expo_arrange_info arr;
+	int xsize = 0, ysize = 0;
 	struct scene_obj *obj;
+	struct udevice *dev;
 	int ret;
 
+	dev = scn->expo->display;
+	if (dev) {
+		struct video_priv *priv = dev_get_uclass_priv(dev);
+
+		xsize = priv->xsize;
+		ysize = priv->ysize;
+	}
+
 	ret = scene_calc_arrange(scn, &arr);
 	if (ret < 0)
 		return log_msg_ret("arr", ret);
 
 	list_for_each_entry(obj, &scn->obj_head, sibling) {
+		handle_alignment(obj->horiz, obj->vert, &obj->bbox, &obj->dims,
+				 xsize, ysize, &obj->ofs);
+
 		switch (obj->type) {
 		case SCENEOBJT_NONE:
 		case SCENEOBJT_IMAGE:
diff --git a/doc/develop/expo.rst b/doc/develop/expo.rst
index 8f63ccbe3ef..d6fc487e030 100644
--- a/doc/develop/expo.rst
+++ b/doc/develop/expo.rst
@@ -107,6 +107,37 @@ refer to objects which have been created. So a menu item is just a collection
 of IDs of text and image objects. When adding a menu item you must create these
 objects first, then create the menu item, passing in the relevant IDs.
 
+Position and alignment
+~~~~~~~~~~~~~~~~~~~~~~
+
+Objects are typically positioned automatically, when scene_arrange() is called.
+However it is possible to position objects manually. The scene_obj_set_pos()
+sets the coordinates of the top left of the object.
+
+All objects have a bounding box. Typically this is calculated by looking at the
+object contents, in `scene_calc_arrange()`. The calculated dimensions of each
+object are stored in the object's `dims` field.
+
+It is possible to adjust the size of an object with `scene_obj_set_size()` or
+even set the bounding box, with `scene_obj_set_bbox()`. The `SCENEOF_SIZE_VALID`
+flag tracks whether the width/height should be maintained when the position
+changes.
+
+If the bounding box is larger than the object needs, the object can be aligned
+to different edges within the box. Objects can be left- or right-aligned,
+or centred. For text objects this applies to each line of text. Normally objects
+are drawn starting at the top of their bounding box, but they can be aligned
+vertically to the bottom, or centred vertically within the box.
+
+Where the width of a text object's bounding box is smaller than the space needed
+to show the next, the text is word-wrapped onto multiple lines, assuming there
+is enough vertical space. Newline characters in the next cause a new line to be
+started. The measurement information is created by the Truetype console driver
+and stored in an alist in `struct scene_txt_generic`.
+
+When the object is drawn the `ofs` field indicates the x and y offset to use,
+from the top left of the bounding box. These values are affected by alignment.
+
 Creating an expo
 ----------------
 
diff --git a/include/expo.h b/include/expo.h
index 8833dcceb7e..001f7db2553 100644
--- a/include/expo.h
+++ b/include/expo.h
@@ -210,6 +210,19 @@ struct scene_obj_bbox {
 	int y1;
 };
 
+/**
+ * struct scene_obj_offset - Offsets for drawing the object
+ *
+ * Stores the offset from x0, x1 at which objects are drawn
+ *
+ * @xofs: x offset
+ * @yofs: y offset
+ */
+struct scene_obj_offset {
+	int xofs;
+	int yofs;
+};
+
 /**
  * struct scene_obj_dims - Dimensions of the object being drawn
  *
@@ -225,6 +238,30 @@ struct scene_obj_dims {
 	int y;
 };
 
+/**
+ * enum scene_obj_halign - Horizontal alignment of objects
+ *
+ * Objects are normally drawn on the left size of their bounding box. This
+ * properly allows aligning on the right or having the object centred.
+ *
+ * @SCENEOA_LEFT: Left of object is aligned with its x coordinate
+ * @SCENEOA_RIGHT: Right of object is aligned with x + w
+ * @SCENEOA_CENTRE: Centre of object is aligned with centre of bounding box
+ * @SCENEOA_TOP: Left of object is aligned with its x coordinate
+ * @SCENEOA_BOTTOM: Right of object is aligned with x + w
+ *
+ * Note: It would be nice to make this a char type but Sphinx riddles:
+ * ./include/expo.h:258: error: Cannot parse enum!
+ * enum scene_obj_align : char {
+ */
+enum scene_obj_align {
+	SCENEOA_LEFT,
+	SCENEOA_RIGHT,
+	SCENEOA_CENTRE,
+	SCENEOA_TOP = SCENEOA_LEFT,
+	SCENEOA_BOTTOM = SCENEOA_RIGHT,
+};
+
 /**
  * enum scene_obj_flags_t - flags for objects
  *
@@ -255,7 +292,10 @@ enum {
  * @id: ID number of the object
  * @type: Type of this object
  * @bbox: Bounding box for this object
+ * @ofs: Offset from x0, y0 where the object is drawn
  * @dims: Dimensions of the text/image (may be smaller than bbox)
+ * @horiz: Horizonal alignment
+ * @vert: Vertical alignment
  * @flags: Flags for this object
  * @bit_length: Number of bits used for this object in CMOS RAM
  * @start_bit: Start bit to use for this object in CMOS RAM
@@ -267,7 +307,10 @@ struct scene_obj {
 	uint id;
 	enum scene_obj_t type;
 	struct scene_obj_bbox bbox;
+	struct scene_obj_offset ofs;
 	struct scene_obj_dims dims;
+	enum scene_obj_align horiz;
+	enum scene_obj_align vert;
 	u8 flags;
 	u8 bit_length;
 	u16 start_bit;
@@ -755,6 +798,26 @@ int scene_obj_set_width(struct scene *scn, uint id, int w);
 int scene_obj_set_bbox(struct scene *scn, uint id, int x0, int y0, int x1,
 		       int y1);
 
+/**
+ * scene_obj_set_halign() - Set the horizontal alignment of an object
+ *
+ * @scn: Scene to update
+ * @id: ID of object to update
+ * @aln: Horizontal alignment to use
+ * Returns: 0 if OK, -ENOENT if @id is invalid
+ */
+int scene_obj_set_halign(struct scene *scn, uint id, enum scene_obj_align aln);
+
+/**
+ * scene_obj_set_valign() - Set the vertical alignment of an object
+ *
+ * @scn: Scene to update
+ * @id: ID of object to update
+ * @aln: Vertical alignment to use
+ * Returns: 0 if OK, -ENOENT if @id is invalid
+ */
+int scene_obj_set_valign(struct scene *scn, uint id, enum scene_obj_align aln);
+
 /**
  * scene_obj_set_hide() - Set whether an object is hidden
  *
diff --git a/test/boot/expo.c b/test/boot/expo.c
index e4f3ffc01fb..b9093b5780b 100644
--- a/test/boot/expo.c
+++ b/test/boot/expo.c
@@ -492,13 +492,14 @@ static int expo_render_image(struct unit_test_state *uts)
 				       60));
 	ut_assertok(scene_obj_set_pos(scn, OBJ_TEXT2, 200, 600));
 
+	/* this string is clipped as it extends beyond its bottom bound */
 	id = scene_txt_str(scn, "text", OBJ_TEXT3, STR_TEXT3,
-			   "this is yet\nanother string, with word-wrap",
+			   "this is yet\nanother string, with word-wrap and it goes on for quite a while",
 			   NULL);
 	ut_assert(id > 0);
 	ut_assertok(scene_txt_set_font(scn, OBJ_TEXT3, "nimbus_sans_l_regular",
 				       60));
-	ut_assertok(scene_obj_set_bbox(scn, OBJ_TEXT3, 500, 200, 1000, 700));
+	ut_assertok(scene_obj_set_bbox(scn, OBJ_TEXT3, 500, 200, 1000, 350));
 
 	id = scene_menu(scn, "main", OBJ_MENU, &menu);
 	ut_assert(id > 0);
@@ -665,9 +666,25 @@ static int expo_render_image(struct unit_test_state *uts)
 	ut_asserteq(ITEM2, scene_menu_get_cur_item(scn, OBJ_MENU));
 	ut_assertok(scene_arrange(scn));
 	ut_assertok(expo_render(exp));
-	ut_asserteq(14883, video_compress_fb(uts, dev, false));
+	ut_asserteq(16304, video_compress_fb(uts, dev, false));
 	ut_assertok(video_check_copy_fb(uts, dev));
 
+	/* do some alignment checks */
+	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_CENTRE));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(16368, video_compress_fb(uts, dev, false));
+	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_RIGHT));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(16321, video_compress_fb(uts, dev, false));
+
+	ut_assertok(scene_obj_set_halign(scn, OBJ_TEXT3, SCENEOA_LEFT));
+	ut_assertok(scene_obj_set_valign(scn, OBJ_TEXT3, SCENEOA_CENTRE));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(18763, video_compress_fb(uts, dev, false));
+	ut_assertok(scene_obj_set_valign(scn, OBJ_TEXT3, SCENEOA_BOTTOM));
+	ut_assertok(expo_render(exp));
+	ut_asserteq(18714, video_compress_fb(uts, dev, false));
+
 	/* make sure only the preview for the second item is shown */
 	obj = scene_obj_find(scn, ITEM1_PREVIEW, SCENEOBJT_NONE);
 	ut_asserteq(true, obj->flags & SCENEOF_HIDE);
-- 
2.43.0

