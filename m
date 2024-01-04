Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 441B6C47073
	for <u-boot@archiver.kernel.org>; Thu,  4 Jan 2024 15:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A3F587A1A;
	Thu,  4 Jan 2024 16:12:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QCBK8vKT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EA8F7879D2; Thu,  4 Jan 2024 16:12:18 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DC5B879E2
 for <u-boot@lists.denx.de>; Thu,  4 Jan 2024 16:12:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3606aa2c7a4so979475ab.0
 for <u-boot@lists.denx.de>; Thu, 04 Jan 2024 07:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1704381119; x=1704985919; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BhdroLYbcuqBNiUtfldnvUzTcstwUhxxDpTLs62CM78=;
 b=QCBK8vKTOQ0sjW5LD6e7e0Im8SnvxfTHHHkg0B479EGTayIl43OYxzCQjwGSQX/cW6
 boSTexRXR8wOJ8AJyOTlpMoENTTY0WkLOgGjGmBxguH/Nl2GFby8Vy+ZH0+b/6LPLAYQ
 j6WesFF+IKUjA3AxlUSATeT3y/ID3QClQ9iYQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704381119; x=1704985919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BhdroLYbcuqBNiUtfldnvUzTcstwUhxxDpTLs62CM78=;
 b=TY7E1WZV0YCq7Ox88Sx6fUAAYBok0CahYHvAth7WWJIMRFRhA1y3te5kU7m5z6R5Hi
 tQms8em37xmO0HGFP8p0PIsxcWDQXH5EPvVIbwNLrjwLuSJnmaMdTU7j9iY+nkYPr+LP
 QLVzOCvzvvNxQ++w2rVq/HTE0iSHfox2a55YSH6Pn/fAQhzuMwnX8hXZ+TsOjUV+64Pt
 tdn0nSO5eZBQYrBAsSeultwt4+1IHekcqktk9rIy1CVk+xVZ+mkenhtbJfk3YJ7Fkgzm
 GFkEXV0Ich3KEUyBqYgyjCHslUkFmfnvs4VS9x1IL+4mVOl3EShL0vbFCZsJkM0q1CYR
 MA+g==
X-Gm-Message-State: AOJu0YyJMQfL0vjw4/HXPIJvsmK5dsGfoFhuKR4JMurDkOA7m3wZYq5Q
 IWbbczDn3Krk1+8PlriWB4z49o1ndBMbOjkEvzcgfp5QAxNa
X-Google-Smtp-Source: AGHT+IGkd0xvBZhKhR+5Zxu3VVLm/0cCaAX4cu3i0LtYEvU80suYMw9ewIvMrGiNYhoVponGP3JKWA==
X-Received: by 2002:a05:6e02:330e:b0:35f:eb65:166 with SMTP id
 bm14-20020a056e02330e00b0035feb650166mr715851ilb.47.1704381119618; 
 Thu, 04 Jan 2024 07:11:59 -0800 (PST)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 cv4-20020a056e023b8400b0035fb79100cesm9260742ilb.59.2024.01.04.07.11.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 07:11:59 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng.cn@gmail.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH v2 02/19] video: Avoid starting a new line to close to the
 bottom
Date: Thu,  4 Jan 2024 08:11:35 -0700
Message-Id: <20240104151152.697855-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104151152.697855-1-sjg@chromium.org>
References: <20240104151152.697855-1-sjg@chromium.org>
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

When starting a new text line, an assumption is made that the current
vertical position is a multiple of the character height. When this is
not true, characters can be written after the end of the framebuffer.

This can causes crashes and strange errors from QEMU.

Adjust the scrolling check when processing a newline character, to
avoid any problems.

Add some comments to make things a little clearer.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/vidconsole-uclass.c | 4 +++-
 include/video.h                   | 3 ++-
 include/video_console.h           | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index a312a198524..a8d2199147d 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -94,7 +94,9 @@ static void vidconsole_newline(struct udevice *dev)
 	priv->ycur += priv->y_charsize;
 
 	/* Check if we need to scroll the terminal */
-	if ((priv->ycur + priv->y_charsize) / priv->y_charsize > priv->rows) {
+	if (vid_priv->rot % 2 ?
+	    priv->ycur + priv->x_charsize > vid_priv->xsize :
+	    priv->ycur + priv->y_charsize > vid_priv->ysize) {
 		vidconsole_move_rows(dev, 0, rows, priv->rows - rows);
 		for (i = 0; i < rows; i++)
 			vidconsole_set_row(dev, priv->rows - i - 1,
diff --git a/include/video.h b/include/video.h
index ae9ce03f5bf..e20f1173762 100644
--- a/include/video.h
+++ b/include/video.h
@@ -78,7 +78,8 @@ enum video_format {
  *
  * @xsize:	Number of pixel columns (e.g. 1366)
  * @ysize:	Number of pixels rows (e.g.. 768)
- * @rot:	Display rotation (0=none, 1=90 degrees clockwise, etc.)
+ * @rot:	Display rotation (0=none, 1=90 degrees clockwise, etc.). THis
+ *		does not affect @xsize and @ysize
  * @bpix:	Encoded bits per pixel (enum video_log2_bpp)
  * @format:	Pixel format (enum video_format)
  * @vidconsole_drv_name:	Driver to use for the text console, NULL to
diff --git a/include/video_console.h b/include/video_console.h
index bde67fa9a5a..ecbf183b3d0 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -27,6 +27,14 @@ enum {
  * Drivers must set up @rows, @cols, @x_charsize, @y_charsize in their probe()
  * method. Drivers may set up @xstart_frac if desired.
  *
+ * Note that these values relate to the rotated console, so that an 80x25
+ * console which is rotated 90 degrees will have rows=80 and cols=25
+ *
+ * The xcur_frac and ycur values refer to the unrotated coordinates, that is
+ * xcur_frac always advances with each character, even if its limit might be
+ * vid_priv->ysize instead of vid_priv->xsize if the console is rotated 90 or
+ * 270 degrees.
+ *
  * @sdev:		stdio device, acting as an output sink
  * @xcur_frac:		Current X position, in fractional units (VID_TO_POS(x))
  * @ycur:		Current Y position in pixels (0=top)
-- 
2.34.1

