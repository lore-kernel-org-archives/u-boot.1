Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6433DE784A6
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:25:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9409187113;
	Mon,  2 Oct 2023 03:15:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="MJVHzeam";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D3347870F7; Mon,  2 Oct 2023 03:14:25 +0200 (CEST)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37223870FE
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:14:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3513c435465so5905015ab.0
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209248; x=1696814048; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXbc1hGCzIQxwapy3AwvXEpdbNxCbl8jGwLttgUu0Io=;
 b=MJVHzeam+q1IsdgeAA3UcUvhshHDxwdrh5jE6y+g5Rngne7H5XuLrDGKjyK6sjECZB
 zcZkx/uaERR+8GVHjTr1b9QstIGuR1r3Nq1q4uhIW3ZeAeyVUZIx7jd2lve8OFFH/7q0
 TGYvS+ZyM9DkcEGOswUoBePELi1DlqwpbTx+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209248; x=1696814048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zXbc1hGCzIQxwapy3AwvXEpdbNxCbl8jGwLttgUu0Io=;
 b=oB6vXLtyVDOeNyCWxz2Wh7xVizc+GcNAG/fFEc8IzsDpFl4rjZ9LT6jKE0kbI9HLHe
 P3+8nLM/f8Kn2uViwu3gizmcoR+rJQp7PYIiUpM63Kq6/mtdBAuobt8K3353Gf8XCqwN
 ggWpULmlQ9mLWeeUd00Ojtw346adsZtqi8Rp9HZLhnC6wXfOXAPqLSqCa7WN9PsrE79z
 iJKgrnV0TGsOiESRWIL8uO3OJGkSOgMvcHZg2n5/v83JZZHhiDfZh6yetyK2Dp/sYg9P
 TBzUbwxuHcsRU8gjI4JY3C1/5XWl+nEIrQV6AqwOXCb3gzDVmudD+PiRPuSmIyF4Pkkk
 a7bA==
X-Gm-Message-State: AOJu0YwjrkX4soQ0F6OvQigJL+0+1IqNYwGfijxXQA1p+KnrQUw3dqLg
 ng8b6tI/q5IU6XTp5SsAQY3X2lDmUD7ynbxPwEU=
X-Google-Smtp-Source: AGHT+IH8TjETHG5eTeW3AKxpvRo+WQhRqrL1KwWaRTR2ycdEPEJcCJC2nXbt0GKgNaTUYTWmL/V+hQ==
X-Received: by 2002:a05:6e02:184d:b0:348:b086:2c4b with SMTP id
 b13-20020a056e02184d00b00348b0862c4bmr9811906ilv.9.1696209247710; 
 Sun, 01 Oct 2023 18:14:07 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 bq6-20020a056638468600b0042aec33bc26sm3571046jab.18.2023.10.01.18.14.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:14:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 17/36] video: Support showing a cursor
Date: Sun,  1 Oct 2023 19:13:21 -0600
Message-ID: <20231002011349.461284-18-sjg@chromium.org>
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

Add rudimentary support for displaying a cursor on a vidconsole. This
helps the user to see where text is being entered.

The implementation so far is very simple: the cursor is just a vertical
bar of fixed width and cannot be erased. To erase the cursor, the text
must be redrawn over it.

This is good enough for expo but will need enhancement to be useful for
the command-line console. For example, it could save and restore the
area behind the cursor.

For now, enable this only for expo, to reduce code size.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/console_core.c        |  31 +++++++++
 drivers/video/console_normal.c      |  29 ++++++++
 drivers/video/console_truetype.c    | 103 ++++++++++++++++++++++++++++
 drivers/video/vidconsole-uclass.c   |  15 ++++
 drivers/video/vidconsole_internal.h |  24 +++++++
 include/video_console.h             |  35 ++++++++++
 6 files changed, 237 insertions(+)

diff --git a/drivers/video/console_core.c b/drivers/video/console_core.c
index b5d0e3dceca3..d17764d0b086 100644
--- a/drivers/video/console_core.c
+++ b/drivers/video/console_core.c
@@ -176,6 +176,37 @@ int fill_char_horizontally(uchar *pfont, void **line, struct video_priv *vid_pri
 	return ret;
 }
 
+int draw_cursor_vertically(void **line, struct video_priv *vid_priv,
+			   uint height, bool direction)
+{
+	int step, line_step, pbytes, ret;
+	uint value;
+	void *dst;
+
+	ret = check_bpix_support(vid_priv->bpix);
+	if (ret)
+		return ret;
+
+	pbytes = VNBYTES(vid_priv->bpix);
+	if (direction) {
+		step = -pbytes;
+		line_step = -vid_priv->line_length;
+	} else {
+		step = pbytes;
+		line_step = vid_priv->line_length;
+	}
+
+	value = vid_priv->colour_fg;
+
+	for (int row = 0; row < height; row++) {
+		dst = *line;
+		for (int col = 0; col < VIDCONSOLE_CURSOR_WIDTH; col++)
+			fill_pixel_and_goto_next(&dst, value, pbytes, step);
+		*line += line_step;
+	}
+	return ret;
+}
+
 int console_probe(struct udevice *dev)
 {
 	return console_set_font(dev, fonts);
diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
index 413c7abee9e1..a0231293f311 100644
--- a/drivers/video/console_normal.c
+++ b/drivers/video/console_normal.c
@@ -97,6 +97,34 @@ static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, char ch)
 	return VID_TO_POS(fontdata->width);
 }
 
+static int console_set_cursor_visible(struct udevice *dev, bool visible,
+				      uint x, uint y, uint index)
+{
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
+	struct udevice *vid = dev->parent;
+	struct video_priv *vid_priv = dev_get_uclass_priv(vid);
+	struct console_simple_priv *priv = dev_get_priv(dev);
+	struct video_fontdata *fontdata = priv->fontdata;
+	int pbytes = VNBYTES(vid_priv->bpix);
+	void *start, *line;
+
+	/* for now, this is not used outside expo */
+	if (!IS_ENABLED(CONFIG_EXPO))
+		return -ENOSYS;
+
+	x += index * fontdata->width;
+	start = vid_priv->fb + y * vid_priv->line_length + x * pbytes;
+
+	/* place the cursor 1 pixel before the start of the next char */
+	x -= 1;
+
+	line = start;
+	draw_cursor_vertically(&line, vid_priv, vc_priv->y_charsize,
+			       NORMAL_DIRECTION);
+
+	return 0;
+}
+
 struct vidconsole_ops console_ops = {
 	.putc_xy	= console_putc_xy,
 	.move_rows	= console_move_rows,
@@ -104,6 +132,7 @@ struct vidconsole_ops console_ops = {
 	.get_font_size	= console_simple_get_font_size,
 	.get_font	= console_simple_get_font,
 	.select_font	= console_simple_select_font,
+	.set_cursor_visible	= console_set_cursor_visible,
 };
 
 U_BOOT_DRIVER(vidconsole_normal) = {
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 1ce01a96bb6c..242b8b71342d 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -831,6 +831,108 @@ static int truetype_entry_restore(struct udevice *dev, struct abuf *buf)
 	return 0;
 }
 
+static int truetype_set_cursor_visible(struct udevice *dev, bool visible,
+				       uint x, uint y, uint index)
+{
+	struct vidconsole_priv *vc_priv = dev_get_uclass_priv(dev);
+	struct udevice *vid = dev->parent;
+	struct video_priv *vid_priv = dev_get_uclass_priv(vid);
+	struct console_tt_priv *priv = dev_get_priv(dev);
+	struct console_tt_metrics *met = priv->cur_met;
+	uint row, width, height, xoff;
+	void *start, *line;
+	uint out, val;
+	int ret;
+
+	if (!visible)
+		return 0;
+
+	/*
+	 * figure out where to place the cursor. This driver ignores the
+	 * passed-in values, since an entry_restore() must have been done before
+	 * calling this function.
+	 */
+	if (index < priv->pos_ptr)
+		x = VID_TO_PIXEL(priv->pos[index].xpos_frac);
+	else
+		x = VID_TO_PIXEL(vc_priv->xcur_frac);
+
+	y = vc_priv->ycur;
+	height = met->font_size;
+	xoff = 0;
+
+	val = vid_priv->colour_bg ? 0 : 255;
+	width = VIDCONSOLE_CURSOR_WIDTH;
+
+	/* Figure out where to write the cursor in the frame buffer */
+	start = vid_priv->fb + y * vid_priv->line_length +
+		x * VNBYTES(vid_priv->bpix);
+	line = start;
+
+	/* draw a vertical bar in the correct position */
+	for (row = 0; row < height; row++) {
+		switch (vid_priv->bpix) {
+		case VIDEO_BPP8:
+			if (IS_ENABLED(CONFIG_VIDEO_BPP8)) {
+				u8 *dst = line + xoff;
+				int i;
+
+				out = val;
+				for (i = 0; i < width; i++) {
+					if (vid_priv->colour_fg)
+						*dst++ |= out;
+					else
+						*dst++ &= out;
+				}
+			}
+			break;
+		case VIDEO_BPP16: {
+			u16 *dst = (u16 *)line + xoff;
+			int i;
+
+			if (IS_ENABLED(CONFIG_VIDEO_BPP16)) {
+				for (i = 0; i < width; i++) {
+					out = val >> 3 |
+						(val >> 2) << 5 |
+						(val >> 3) << 11;
+					if (vid_priv->colour_fg)
+						*dst++ |= out;
+					else
+						*dst++ &= out;
+				}
+			}
+			break;
+		}
+		case VIDEO_BPP32: {
+			u32 *dst = (u32 *)line + xoff;
+			int i;
+
+			if (IS_ENABLED(CONFIG_VIDEO_BPP32)) {
+				for (i = 0; i < width; i++) {
+					int out;
+
+					out = val | val << 8 | val << 16;
+					if (vid_priv->colour_fg)
+						*dst++ |= out;
+					else
+						*dst++ &= out;
+				}
+			}
+			break;
+		}
+		default:
+			return -ENOSYS;
+		}
+
+		line += vid_priv->line_length;
+	}
+	ret = vidconsole_sync_copy(dev, start, line);
+	if (ret)
+		return ret;
+
+	return video_sync(vid, true);
+}
+
 const char *console_truetype_get_font_size(struct udevice *dev, uint *sizep)
 {
 	struct console_tt_priv *priv = dev_get_priv(dev);
@@ -886,6 +988,7 @@ struct vidconsole_ops console_truetype_ops = {
 	.nominal	= truetype_nominal,
 	.entry_save	= truetype_entry_save,
 	.entry_restore	= truetype_entry_restore,
+	.set_cursor_visible	= truetype_set_cursor_visible
 };
 
 U_BOOT_DRIVER(vidconsole_truetype) = {
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 2f3f685a55c9..22d55df71f63 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -672,6 +672,21 @@ int vidconsole_entry_restore(struct udevice *dev, struct abuf *buf)
 	return 0;
 }
 
+int vidconsole_set_cursor_visible(struct udevice *dev, bool visible,
+				  uint x, uint y, uint index)
+{
+	struct vidconsole_ops *ops = vidconsole_get_ops(dev);
+	int ret;
+
+	if (ops->set_cursor_visible) {
+		ret = ops->set_cursor_visible(dev, visible, x, y, index);
+		if (ret != -ENOSYS)
+			return ret;
+	}
+
+	return 0;
+}
+
 void vidconsole_push_colour(struct udevice *dev, enum colour_idx fg,
 			    enum colour_idx bg, struct vidconsole_colour *old)
 {
diff --git a/drivers/video/vidconsole_internal.h b/drivers/video/vidconsole_internal.h
index c41edd45249a..0ec581b26638 100644
--- a/drivers/video/vidconsole_internal.h
+++ b/drivers/video/vidconsole_internal.h
@@ -92,6 +92,30 @@ int fill_char_vertically(uchar *pfont, void **line, struct video_priv *vid_priv,
 int fill_char_horizontally(uchar *pfont, void **line, struct video_priv *vid_priv,
 			   struct video_fontdata *fontdata, bool direction);
 
+/**
+ * draw_cursor_vertically() - Draw a simple vertical cursor
+ *
+ * @line: pointer to framebuffer buffer: upper left cursor corner
+ * @vid_priv: driver private data
+ * @height: height of the cursor in pixels
+ * @param direction	controls cursor orientation. Can be normal or flipped.
+ * When normal:               When flipped:
+ *|-----------------------------------------------|
+ *|               *        |   line stepping      |
+ *|    ^  * * * * *        |   |                  |
+ *|    |    *     *        |   v   *     *        |
+ *|    |                   |       * * * * *      |
+ *|  line stepping         |       *              |
+ *|                        |                      |
+ *|  stepping ->           |        <<- stepping  |
+ *|---!!we're starting from upper left char corner|
+ *|-----------------------------------------------|
+ *
+ * Return: 0, if success, or else error code.
+ */
+int draw_cursor_vertically(void **line, struct video_priv *vid_priv,
+			   uint height, bool direction);
+
 /**
  * console probe function.
  *
diff --git a/include/video_console.h b/include/video_console.h
index 87f9a588575d..bde67fa9a5a9 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -16,6 +16,11 @@ struct video_priv;
 #define VID_TO_PIXEL(x)	((x) / VID_FRAC_DIV)
 #define VID_TO_POS(x)	((x) * VID_FRAC_DIV)
 
+enum {
+	/* cursor width in pixels */
+	VIDCONSOLE_CURSOR_WIDTH		= 2,
+};
+
 /**
  * struct vidconsole_priv - uclass-private data about a console device
  *
@@ -264,6 +269,21 @@ struct vidconsole_ops {
 	 * Return: 0 if OK, -ve on error
 	 */
 	int (*entry_restore)(struct udevice *dev, struct abuf *buf);
+
+	/**
+	 * set_cursor_visible() - Show or hide the cursor
+	 *
+	 * Shows or hides a cursor at the current position
+	 *
+	 * @dev: Console device to use
+	 * @visible: true to show the cursor, false to hide it
+	 * @x: X position in pixels
+	 * @y: Y position in pixels
+	 * @index: Character position (0 = at start)
+	 * Return: 0 if OK, -ve on error
+	 */
+	int (*set_cursor_visible)(struct udevice *dev, bool visible,
+				  uint x, uint y, uint index);
 };
 
 /* Get a pointer to the driver operations for a video console device */
@@ -342,6 +362,21 @@ int vidconsole_entry_save(struct udevice *dev, struct abuf *buf);
  */
 int vidconsole_entry_restore(struct udevice *dev, struct abuf *buf);
 
+/**
+ * vidconsole_set_cursor_visible() - Show or hide the cursor
+ *
+ * Shows or hides a cursor at the current position
+ *
+ * @dev: Console device to use
+ * @visible: true to show the cursor, false to hide it
+ * @x: X position in pixels
+ * @y: Y position in pixels
+ * @index: Character position (0 = at start)
+ * Return: 0 if OK, -ve on error
+ */
+int vidconsole_set_cursor_visible(struct udevice *dev, bool visible,
+				  uint x, uint y, uint index);
+
 /**
  * vidconsole_push_colour() - Temporarily change the font colour
  *
-- 
2.42.0.582.g8ccd20d70d-goog

