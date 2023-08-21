Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46F4CEE49A6
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:53:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4790487096;
	Mon, 21 Aug 2023 15:51:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JgtEabWc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 102DC87096; Mon, 21 Aug 2023 15:51:54 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4AFE187098
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-31c3726cc45so1247414f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625910; x=1693230710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdoZCMaizC3Y759MOjDBPu1VoZ+fIm/Lqzoh+gR4stQ=;
 b=JgtEabWcIca2ALjUCCqGgXmUf5MREa+Jm3Yt8fmf6mwr8MrhP5Iu7KssN+MMQbAxKO
 cl+LarTpXoK8lh4x2WmdcUKViUJdCAMCFJCk6vdMhIFAjaBH1Sqhudg315eFGharTw6G
 7FFSDdE1ZAablttQmfgcm59Ilk5+2QRAFycWcOiue5yFfF8RSAAAF8UHkl7rKxgQKHCO
 NWC3P4PdjYEtaQFoJ4R5txJ07Wdvoptc9JVL9WGf4wSL5X6fm+SbalQaW3YgFuKNy0fk
 0+lmUOMDOXmwx4iGWZd6+LRFXYEZGCZ95AvjoDF83ZlL9Nu1oUvB/qzH7PRJatx6j/mw
 J8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625910; x=1693230710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NdoZCMaizC3Y759MOjDBPu1VoZ+fIm/Lqzoh+gR4stQ=;
 b=ATA2PnRfDc2gQVzxEqGIcgBsTvJvkOPNl2NSZEoxqmZfEe/94an/QM50JhcxX0wNEA
 0HpCsEsyDLhFnjW4APp/TYwLoc0mbRD/T517DYROiuJLUSRxyO/NApA1qyRJpVQTqpRc
 dRZ5hG5VoUH3oHfwZN1abRKxbIogLNiJhSSNDvjA01RYJwTZY6Fq8xUJCYp9gI28/OI0
 oZ0SA+qdXZ4UvNR/uqun2tysI+JnatTKlbwSfCF7q/sj5AfH/VNk3EqNROuXlIBRMWI8
 pgosvMd73/GvTMQvsWPgGNNc3fhZgcnLKIoQFKdoqCeSFAufSLREsoWPLMMH1xXuh1lG
 JKFQ==
X-Gm-Message-State: AOJu0YyKi/tYIN4uVjau5AbbNkJPzybGF79aUx+ls+uiyxVTGeu0zy64
 aMCSasGPaxyg+ogYkqU0Dx/1q3mIbnM=
X-Google-Smtp-Source: AGHT+IHsb00O74X0NrGSp+Znx7MktY8oHr2PL7yyjJMmEkZVU5lzx7Wg/Yr0hFddlw1zsptntp6etA==
X-Received: by 2002:a05:6000:1cce:b0:314:ca7:f30b with SMTP id
 bf14-20020a0560001cce00b003140ca7f30bmr5251008wrb.54.1692625909678; 
 Mon, 21 Aug 2023 06:51:49 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:49 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v5 11/13] video: Use VIDEO_DAMAGE for VIDEO_COPY
Date: Mon, 21 Aug 2023 16:51:08 +0300
Message-Id: <20230821135111.3558478-12-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
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

From: Alexander Graf <agraf@csgraf.de>

CONFIG_VIDEO_COPY implemented a range-based copying mechanism: If we
print a single character, it will always copy the full range of bytes
from the top left corner of the character to the lower right onto the
uncached frame buffer. This includes pretty much the full line contents
of the printed character.

Since we now have proper damage tracking, let's make use of that to reduce
the amount of data we need to copy. With this patch applied, we will only
copy the tiny rectangle surrounding characters when we print them,
speeding up the video console.

After this, changes to the main frame buffer are not immediately copied
to the copy frame buffer, but postponed until the next video device
sync. So issue an explicit sync before inspecting the copy frame buffer
contents for the video tests.

Signed-off-by: Alexander Graf <agraf@csgraf.de>
[Alper: Rebase for fontdata->height/w, fill_part(), fix memmove(dev),
        drop from defconfig, use damage.xstart/yend, use IS_ENABLED(),
        call video_sync() before copy_fb check, update video_copy test]
Co-developed-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Remove video_sync_copy() also from video_fill(), video_fill_part()
- Fix memmove() calls by removing the extra dev argument
- Call video_sync() before checking copy_fb in video tests
- Use xstart, ystart, xend, yend as names for damage region
- Use met->baseline instead of priv->baseline
- Use fontdata->height/width instead of VIDEO_FONT_HEIGHT/WIDTH
- Use xstart, ystart, xend, yend as names for damage region
- Use IS_ENABLED() instead of CONFIG_IS_ENABLED()
- Drop VIDEO_DAMAGE from sandbox defconfig added in a new patch
- Update dm_test_video_copy test added in a new patch

Changes in v3:
- Make VIDEO_COPY always select VIDEO_DAMAGE

Changes in v2:
- Add patch "video: Use VIDEO_DAMAGE for VIDEO_COPY"

 configs/sandbox_defconfig         |  1 -
 drivers/video/Kconfig             |  5 ++
 drivers/video/console_normal.c    | 13 +----
 drivers/video/console_rotate.c    | 44 +++-----------
 drivers/video/console_truetype.c  | 16 +----
 drivers/video/vidconsole-uclass.c | 16 -----
 drivers/video/video-uclass.c      | 97 ++++++++-----------------------
 drivers/video/video_bmp.c         |  7 ---
 include/video.h                   | 37 ------------
 include/video_console.h           | 52 -----------------
 test/dm/video.c                   |  3 +-
 11 files changed, 43 insertions(+), 248 deletions(-)

diff --git a/configs/sandbox_defconfig b/configs/sandbox_defconfig
index 51b820f13121..259f31f26cee 100644
--- a/configs/sandbox_defconfig
+++ b/configs/sandbox_defconfig
@@ -307,7 +307,6 @@ CONFIG_USB_ETH_CDC=y
 CONFIG_VIDEO=y
 CONFIG_VIDEO_FONT_SUN12X22=y
 CONFIG_VIDEO_COPY=y
-CONFIG_VIDEO_DAMAGE=y
 CONFIG_CONSOLE_ROTATION=y
 CONFIG_CONSOLE_TRUETYPE=y
 CONFIG_CONSOLE_TRUETYPE_CANTORAONE=y
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 97f494a1340b..b3fbd9d7d9ca 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -83,11 +83,14 @@ config VIDEO_PCI_DEFAULT_FB_SIZE
 
 config VIDEO_COPY
 	bool "Enable copying the frame buffer to a hardware copy"
+	select VIDEO_DAMAGE
 	help
 	  On some machines (e.g. x86), reading from the frame buffer is very
 	  slow because it is uncached. To improve performance, this feature
 	  allows the frame buffer to be kept in cached memory (allocated by
 	  U-Boot) and then copied to the hardware frame-buffer as needed.
+	  It uses the VIDEO_DAMAGE feature to keep track of regions to copy
+	  and will only copy actually touched regions.
 
 	  To use this, your video driver must set @copy_base in
 	  struct video_uc_plat.
@@ -105,6 +108,8 @@ config VIDEO_DAMAGE
 	  regions of the frame buffer that were modified before, speeding up
 	  screen refreshes significantly.
 
+	  It is also used by VIDEO_COPY to identify which regions changed.
+
 config BACKLIGHT_PWM
 	bool "Generic PWM based Backlight Driver"
 	depends on BACKLIGHT && DM_PWM
diff --git a/drivers/video/console_normal.c b/drivers/video/console_normal.c
index a19ce6a2bc11..c44aa09473a3 100644
--- a/drivers/video/console_normal.c
+++ b/drivers/video/console_normal.c
@@ -35,10 +35,6 @@ static int console_set_row(struct udevice *dev, uint row, int clr)
 		fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
 	end = dst;
 
-	ret = vidconsole_sync_copy(dev, line, end);
-	if (ret)
-		return ret;
-
 	video_damage(dev->parent,
 		     0,
 		     fontdata->height * row,
@@ -57,14 +53,11 @@ static int console_move_rows(struct udevice *dev, uint rowdst,
 	void *dst;
 	void *src;
 	int size;
-	int ret;
 
 	dst = vid_priv->fb + rowdst * fontdata->height * vid_priv->line_length;
 	src = vid_priv->fb + rowsrc * fontdata->height * vid_priv->line_length;
 	size = fontdata->height * vid_priv->line_length * count;
-	ret = vidconsole_memmove(dev, dst, src, size);
-	if (ret)
-		return ret;
+	memmove(dst, src, size);
 
 	video_damage(dev->parent,
 		     0,
@@ -108,10 +101,6 @@ static int console_putc_xy(struct udevice *dev, uint x_frac, uint y, char ch)
 		     fontdata->width,
 		     fontdata->height);
 
-	ret = vidconsole_sync_copy(dev, start, line);
-	if (ret)
-		return ret;
-
 	return VID_TO_POS(fontdata->width);
 }
 
diff --git a/drivers/video/console_rotate.c b/drivers/video/console_rotate.c
index 6c3e7c1bb8dc..6e9067d1c7fb 100644
--- a/drivers/video/console_rotate.c
+++ b/drivers/video/console_rotate.c
@@ -21,7 +21,6 @@ static int console_set_row_1(struct udevice *dev, uint row, int clr)
 	int pbytes = VNBYTES(vid_priv->bpix);
 	void *start, *dst, *line;
 	int i, j;
-	int ret;
 
 	start = vid_priv->fb + vid_priv->line_length -
 		(row + 1) * fontdata->height * pbytes;
@@ -32,9 +31,6 @@ static int console_set_row_1(struct udevice *dev, uint row, int clr)
 			fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
 		line += vid_priv->line_length;
 	}
-	ret = vidconsole_sync_copy(dev, start, line);
-	if (ret)
-		return ret;
 
 	video_damage(dev->parent,
 		     vid_priv->xsize - ((row + 1) * fontdata->height),
@@ -54,7 +50,7 @@ static int console_move_rows_1(struct udevice *dev, uint rowdst, uint rowsrc,
 	int pbytes = VNBYTES(vid_priv->bpix);
 	void *dst;
 	void *src;
-	int j, ret;
+	int j;
 
 	dst = vid_priv->fb + vid_priv->line_length -
 		(rowdst + count) * fontdata->height * pbytes;
@@ -62,10 +58,7 @@ static int console_move_rows_1(struct udevice *dev, uint rowdst, uint rowsrc,
 		(rowsrc + count) * fontdata->height * pbytes;
 
 	for (j = 0; j < vid_priv->ysize; j++) {
-		ret = vidconsole_memmove(dev, dst, src,
-					fontdata->height * pbytes * count);
-		if (ret)
-			return ret;
+		memmove(dst, src, fontdata->height * pbytes * count);
 		src += vid_priv->line_length;
 		dst += vid_priv->line_length;
 	}
@@ -104,10 +97,6 @@ static int console_putc_xy_1(struct udevice *dev, uint x_frac, uint y, char ch)
 		return ret;
 
 	/* We draw backwards from 'start, so account for the first line */
-	ret = vidconsole_sync_copy(dev, start - vid_priv->line_length, line);
-	if (ret)
-		return ret;
-
 	video_damage(dev->parent,
 		     vid_priv->xsize - y - fontdata->height,
 		     linenum - 1,
@@ -125,7 +114,7 @@ static int console_set_row_2(struct udevice *dev, uint row, int clr)
 	struct video_fontdata *fontdata = priv->fontdata;
 	void *start, *line, *dst, *end;
 	int pixels = fontdata->height * vid_priv->xsize;
-	int i, ret;
+	int i;
 	int pbytes = VNBYTES(vid_priv->bpix);
 
 	start = vid_priv->fb + vid_priv->ysize * vid_priv->line_length -
@@ -135,9 +124,6 @@ static int console_set_row_2(struct udevice *dev, uint row, int clr)
 	for (i = 0; i < pixels; i++)
 		fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
 	end = dst;
-	ret = vidconsole_sync_copy(dev, start, end);
-	if (ret)
-		return ret;
 
 	video_damage(dev->parent,
 		     0,
@@ -163,8 +149,7 @@ static int console_move_rows_2(struct udevice *dev, uint rowdst, uint rowsrc,
 		vid_priv->line_length;
 	src = end - (rowsrc + count) * fontdata->height *
 		vid_priv->line_length;
-	vidconsole_memmove(dev, dst, src,
-			   fontdata->height * vid_priv->line_length * count);
+	memmove(dst, src, fontdata->height * vid_priv->line_length * count);
 
 	video_damage(dev->parent,
 		     0,
@@ -199,11 +184,6 @@ static int console_putc_xy_2(struct udevice *dev, uint x_frac, uint y, char ch)
 	if (ret)
 		return ret;
 
-	/* Add 4 bytes to allow for the first pixel writen */
-	ret = vidconsole_sync_copy(dev, start + 4, line);
-	if (ret)
-		return ret;
-
 	video_damage(dev->parent,
 		     x - fontdata->width + 1,
 		     linenum - fontdata->height + 1,
@@ -220,7 +200,7 @@ static int console_set_row_3(struct udevice *dev, uint row, int clr)
 	struct video_fontdata *fontdata = priv->fontdata;
 	int pbytes = VNBYTES(vid_priv->bpix);
 	void *start, *dst, *line;
-	int i, j, ret;
+	int i, j;
 
 	start = vid_priv->fb + row * fontdata->height * pbytes;
 	line = start;
@@ -230,9 +210,6 @@ static int console_set_row_3(struct udevice *dev, uint row, int clr)
 			fill_pixel_and_goto_next(&dst, clr, pbytes, pbytes);
 		line += vid_priv->line_length;
 	}
-	ret = vidconsole_sync_copy(dev, start, line);
-	if (ret)
-		return ret;
 
 	video_damage(dev->parent,
 		     row * fontdata->height,
@@ -252,16 +229,13 @@ static int console_move_rows_3(struct udevice *dev, uint rowdst, uint rowsrc,
 	int pbytes = VNBYTES(vid_priv->bpix);
 	void *dst;
 	void *src;
-	int j, ret;
+	int j;
 
 	dst = vid_priv->fb + rowdst * fontdata->height * pbytes;
 	src = vid_priv->fb + rowsrc * fontdata->height * pbytes;
 
 	for (j = 0; j < vid_priv->ysize; j++) {
-		ret = vidconsole_memmove(dev, dst, src,
-					fontdata->height * pbytes * count);
-		if (ret)
-			return ret;
+		memmove(dst, src, fontdata->height * pbytes * count);
 		src += vid_priv->line_length;
 		dst += vid_priv->line_length;
 	}
@@ -296,10 +270,6 @@ static int console_putc_xy_3(struct udevice *dev, uint x_frac, uint y, char ch)
 	line = start;
 
 	ret = fill_char_horizontally(pfont, &line, vid_priv, fontdata, NORMAL_DIRECTION);
-	if (ret)
-		return ret;
-	/* Add a line to allow for the first pixels writen */
-	ret = vidconsole_sync_copy(dev, start + vid_priv->line_length, line);
 	if (ret)
 		return ret;
 
diff --git a/drivers/video/console_truetype.c b/drivers/video/console_truetype.c
index 0adbf9cc3d67..07bb0af71311 100644
--- a/drivers/video/console_truetype.c
+++ b/drivers/video/console_truetype.c
@@ -182,7 +182,6 @@ static int console_truetype_set_row(struct udevice *dev, uint row, int clr)
 	struct console_tt_priv *priv = dev_get_priv(dev);
 	struct console_tt_metrics *met = priv->cur_met;
 	void *end, *line;
-	int ret;
 
 	line = vid_priv->fb + row * met->font_size * vid_priv->line_length;
 	end = line + met->font_size * vid_priv->line_length;
@@ -218,9 +217,6 @@ static int console_truetype_set_row(struct udevice *dev, uint row, int clr)
 	default:
 		return -ENOSYS;
 	}
-	ret = vidconsole_sync_copy(dev, line, end);
-	if (ret)
-		return ret;
 
 	video_damage(dev->parent,
 		     0,
@@ -240,14 +236,11 @@ static int console_truetype_move_rows(struct udevice *dev, uint rowdst,
 	struct console_tt_metrics *met = priv->cur_met;
 	void *dst;
 	void *src;
-	int i, diff, ret;
+	int i, diff;
 
 	dst = vid_priv->fb + rowdst * met->font_size * vid_priv->line_length;
 	src = vid_priv->fb + rowsrc * met->font_size * vid_priv->line_length;
-	ret = vidconsole_memmove(dev, dst, src, met->font_size *
-				 vid_priv->line_length * count);
-	if (ret)
-		return ret;
+	memmove(dst, src, met->font_size * vid_priv->line_length * count);
 
 	/* Scroll up our position history */
 	diff = (rowsrc - rowdst) * met->font_size;
@@ -280,7 +273,7 @@ static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
 	u8 *bits, *data;
 	int advance;
 	void *start, *end, *line;
-	int row, ret;
+	int row;
 
 	/* First get some basic metrics about this character */
 	stbtt_GetCodepointHMetrics(font, ch, &advance, &lsb);
@@ -424,9 +417,6 @@ static int console_truetype_putc_xy(struct udevice *dev, uint x, uint y,
 		     width,
 		     height);
 
-	ret = vidconsole_sync_copy(dev, start, line);
-	if (ret)
-		return ret;
 	free(data);
 
 	return width_frac;
diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 05f930478096..27a1e8ec3e49 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -682,22 +682,6 @@ UCLASS_DRIVER(vidconsole) = {
 	.per_device_auto	= sizeof(struct vidconsole_priv),
 };
 
-#ifdef CONFIG_VIDEO_COPY
-int vidconsole_sync_copy(struct udevice *dev, void *from, void *to)
-{
-	struct udevice *vid = dev_get_parent(dev);
-
-	return video_sync_copy(vid, from, to);
-}
-
-int vidconsole_memmove(struct udevice *dev, void *dst, const void *src,
-		       int size)
-{
-	memmove(dst, src, size);
-	return vidconsole_sync_copy(dev, dst, dst + size);
-}
-#endif
-
 int vidconsole_clear_and_reset(struct udevice *dev)
 {
 	int ret;
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index a50220bcc684..c79499252a22 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -160,7 +160,7 @@ int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	void *start, *line;
 	int pixels = xend - xstart;
-	int row, i, ret;
+	int row, i;
 
 	start = priv->fb + ystart * priv->line_length;
 	start += xstart * VNBYTES(priv->bpix);
@@ -200,10 +200,6 @@ int video_fill_part(struct udevice *dev, int xstart, int ystart, int xend,
 		line += priv->line_length;
 	}
 
-	ret = video_sync_copy(dev, start, line);
-	if (ret)
-		return ret;
-
 	video_damage(dev, xstart, ystart, xend - xstart, yend - ystart);
 
 	return 0;
@@ -223,7 +219,6 @@ int video_reserve_from_bloblist(struct video_handoff *ho)
 int video_fill(struct udevice *dev, u32 colour)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
-	int ret;
 
 	switch (priv->bpix) {
 	case VIDEO_BPP16:
@@ -248,9 +243,6 @@ int video_fill(struct udevice *dev, u32 colour)
 		memset(priv->fb, colour, priv->fb_size);
 		break;
 	}
-	ret = video_sync_copy(dev, priv->fb, priv->fb + priv->fb_size);
-	if (ret)
-		return ret;
 
 	video_damage(dev, 0, 0, priv->xsize, priv->ysize);
 
@@ -420,6 +412,27 @@ static void video_flush_dcache(struct udevice *vid)
 }
 #endif
 
+static void video_flush_copy(struct udevice *vid)
+{
+	struct video_priv *priv = dev_get_uclass_priv(vid);
+
+	if (!priv->copy_fb)
+		return;
+
+	if (priv->damage.xend && priv->damage.yend) {
+		int lstart = priv->damage.xstart * VNBYTES(priv->bpix);
+		int lend = priv->damage.xend * VNBYTES(priv->bpix);
+		int y;
+
+		for (y = priv->damage.ystart; y < priv->damage.yend; y++) {
+			ulong offset = (y * priv->line_length) + lstart;
+			ulong len = lend - lstart;
+
+			memcpy(priv->copy_fb + offset, priv->fb + offset, len);
+		}
+	}
+}
+
 /* Flush video activity to the caches */
 int video_sync(struct udevice *vid, bool force)
 {
@@ -427,6 +440,9 @@ int video_sync(struct udevice *vid, bool force)
 	struct video_ops *ops = video_get_ops(vid);
 	int ret;
 
+	if (IS_ENABLED(CONFIG_VIDEO_COPY))
+		video_flush_copy(vid);
+
 	if (ops && ops->video_sync) {
 		ret = ops->video_sync(vid);
 		if (ret)
@@ -503,69 +519,6 @@ int video_get_ysize(struct udevice *dev)
 	return priv->ysize;
 }
 
-#ifdef CONFIG_VIDEO_COPY
-int video_sync_copy(struct udevice *dev, void *from, void *to)
-{
-	struct video_priv *priv = dev_get_uclass_priv(dev);
-
-	if (priv->copy_fb) {
-		long offset, size;
-
-		/* Find the offset of the first byte to copy */
-		if ((ulong)to > (ulong)from) {
-			size = to - from;
-			offset = from - priv->fb;
-		} else {
-			size = from - to;
-			offset = to - priv->fb;
-		}
-
-		/*
-		 * Allow a bit of leeway for valid requests somewhere near the
-		 * frame buffer
-		 */
-		if (offset < -priv->fb_size || offset > 2 * priv->fb_size) {
-#ifdef DEBUG
-			char str[120];
-
-			snprintf(str, sizeof(str),
-				 "[** FAULT sync_copy fb=%p, from=%p, to=%p, offset=%lx]",
-				 priv->fb, from, to, offset);
-			console_puts_select_stderr(true, str);
-#endif
-			return -EFAULT;
-		}
-
-		/*
-		 * Silently crop the memcpy. This allows callers to avoid doing
-		 * this themselves. It is common for the end pointer to go a
-		 * few lines after the end of the frame buffer, since most of
-		 * the update algorithms terminate a line after their last write
-		 */
-		if (offset + size > priv->fb_size) {
-			size = priv->fb_size - offset;
-		} else if (offset < 0) {
-			size += offset;
-			offset = 0;
-		}
-
-		memcpy(priv->copy_fb + offset, priv->fb + offset, size);
-	}
-
-	return 0;
-}
-
-int video_sync_copy_all(struct udevice *dev)
-{
-	struct video_priv *priv = dev_get_uclass_priv(dev);
-
-	video_sync_copy(dev, priv->fb, priv->fb + priv->fb_size);
-
-	return 0;
-}
-
-#endif
-
 #define SPLASH_DECL(_name) \
 	extern u8 __splash_ ## _name ## _begin[]; \
 	extern u8 __splash_ ## _name ## _end[]
diff --git a/drivers/video/video_bmp.c b/drivers/video/video_bmp.c
index 10943b9ca19f..da2bbe864a03 100644
--- a/drivers/video/video_bmp.c
+++ b/drivers/video/video_bmp.c
@@ -268,7 +268,6 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 	enum video_format eformat;
 	struct bmp_color_table_entry *palette;
 	int hdr_size;
-	int ret;
 
 	if (!bmp || !(bmp->header.signature[0] == 'B' &&
 	    bmp->header.signature[1] == 'M')) {
@@ -462,11 +461,5 @@ int video_bmp_display(struct udevice *dev, ulong bmp_image, int x, int y,
 
 	video_damage(dev, x, y, width, height);
 
-	/* Find the position of the top left of the image in the framebuffer */
-	fb = (uchar *)(priv->fb + y * priv->line_length + x * bpix / 8);
-	ret = video_sync_copy(dev, start, fb);
-	if (ret)
-		return log_ret(ret);
-
 	return video_sync(dev, false);
 }
diff --git a/include/video.h b/include/video.h
index a522f33949e5..42e57b44188d 100644
--- a/include/video.h
+++ b/include/video.h
@@ -350,43 +350,6 @@ void video_set_default_colors(struct udevice *dev, bool invert);
  */
 int video_default_font_height(struct udevice *dev);
 
-#ifdef CONFIG_VIDEO_COPY
-/**
- * vidconsole_sync_copy() - Sync back to the copy framebuffer
- *
- * This ensures that the copy framebuffer has the same data as the framebuffer
- * for a particular region. It should be called after the framebuffer is updated
- *
- * @from and @to can be in either order. The region between them is synced.
- *
- * @dev: Vidconsole device being updated
- * @from: Start/end address within the framebuffer (->fb)
- * @to: Other address within the frame buffer
- * Return: 0 if OK, -EFAULT if the start address is before the start of the
- *	frame buffer start
- */
-int video_sync_copy(struct udevice *dev, void *from, void *to);
-
-/**
- * video_sync_copy_all() - Sync the entire framebuffer to the copy
- *
- * @dev: Vidconsole device being updated
- * Return: 0 (always)
- */
-int video_sync_copy_all(struct udevice *dev);
-#else
-static inline int video_sync_copy(struct udevice *dev, void *from, void *to)
-{
-	return 0;
-}
-
-static inline int video_sync_copy_all(struct udevice *dev)
-{
-	return 0;
-}
-
-#endif
-
 /**
  * video_damage() - Notify the video subsystem about screen updates.
  *
diff --git a/include/video_console.h b/include/video_console.h
index 2694e44f6ecf..caadeb878989 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -404,56 +404,4 @@ void vidconsole_list_fonts(struct udevice *dev);
  */
 int vidconsole_get_font_size(struct udevice *dev, const char **name, uint *sizep);
 
-#ifdef CONFIG_VIDEO_COPY
-/**
- * vidconsole_sync_copy() - Sync back to the copy framebuffer
- *
- * This ensures that the copy framebuffer has the same data as the framebuffer
- * for a particular region. It should be called after the framebuffer is updated
- *
- * @from and @to can be in either order. The region between them is synced.
- *
- * @dev: Vidconsole device being updated
- * @from: Start/end address within the framebuffer (->fb)
- * @to: Other address within the frame buffer
- * Return: 0 if OK, -EFAULT if the start address is before the start of the
- *	frame buffer start
- */
-int vidconsole_sync_copy(struct udevice *dev, void *from, void *to);
-
-/**
- * vidconsole_memmove() - Perform a memmove() within the frame buffer
- *
- * This handles a memmove(), e.g. for scrolling. It also updates the copy
- * framebuffer.
- *
- * @dev: Vidconsole device being updated
- * @dst: Destination address within the framebuffer (->fb)
- * @src: Source address within the framebuffer (->fb)
- * @size: Number of bytes to transfer
- * Return: 0 if OK, -EFAULT if the start address is before the start of the
- *	frame buffer start
- */
-int vidconsole_memmove(struct udevice *dev, void *dst, const void *src,
-		       int size);
-#else
-
-#include <string.h>
-
-static inline int vidconsole_sync_copy(struct udevice *dev, void *from,
-				       void *to)
-{
-	return 0;
-}
-
-static inline int vidconsole_memmove(struct udevice *dev, void *dst,
-				     const void *src, int size)
-{
-	memmove(dst, src, size);
-
-	return 0;
-}
-
-#endif
-
 #endif
diff --git a/test/dm/video.c b/test/dm/video.c
index 8c7d9800a42e..4c3bcd26e94f 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -106,6 +106,7 @@ static int check_copy_frame_buffer(struct unit_test_state *uts,
 	if (!IS_ENABLED(CONFIG_VIDEO_COPY))
 		return 0;
 
+	video_sync(dev, false);
 	ut_assertf(!memcmp(priv->fb, priv->copy_fb, priv->fb_size),
 		   "Copy framebuffer does not match fb");
 
@@ -706,7 +707,7 @@ static int dm_test_video_copy(struct unit_test_state *uts)
 	vidconsole_put_string(con, test_string);
 	vidconsole_put_string(con, test_string);
 	ut_asserteq(7589, compress_frame_buffer(uts, dev, false));
-	ut_asserteq(5278, compress_frame_buffer(uts, dev, true));
+	ut_asserteq(4127, compress_frame_buffer(uts, dev, true));
 
 	return 0;
 }
-- 
2.40.1

