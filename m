Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D745ED18157
	for <u-boot@archiver.kernel.org>; Mon, 14 Oct 2024 22:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5743789239;
	Tue, 15 Oct 2024 00:32:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Fli02y6P";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC36891D7; Tue, 15 Oct 2024 00:32:22 +0200 (CEST)
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com
 [IPv6:2607:f8b0:4864:20::131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45C7F87042
 for <u-boot@lists.denx.de>; Tue, 15 Oct 2024 00:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-3a3b67cd89dso9904955ab.0
 for <u-boot@lists.denx.de>; Mon, 14 Oct 2024 15:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1728945138; x=1729549938; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hde+A2aGugAGPVzN2TBL7e0E6hNE+JbQXef09t7SH9g=;
 b=Fli02y6PrjBhL2LWs//hqyREU1Vrmri1fmLvv6Bcz+XNyJvHHjkVPc1YXf+c9A0Sfh
 Ysa+di0o/JjS7YQJifX5XkQ++p4nubSCxoChr2hOrnZXhVA426LyVMTcUYYSx0Ny4s0I
 X0Q9PK0B9xdljF7lafRciEuooGmiE7QajGPQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728945138; x=1729549938;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hde+A2aGugAGPVzN2TBL7e0E6hNE+JbQXef09t7SH9g=;
 b=g9BEQ44hwwCjqfy6Fw0oBGrO+YH0FYtFGYP6Db+1uFFYCPcHoeyPEBORPGBiAhmARs
 vi2AlgZ9F9o1EXXVLUQnwoZn70C+OnhxPakSVC/KErFmcVyIZ7G9lLxpi1Pnujr90ULR
 WcG8jsGDfd7j0x/qrqht/+Uu87IyJT8lF2U+gywFJL+ht+Xa+l+653c7GcmX874EC6xu
 NuOyxcyCT46sxP5bzRGK9KSNZlUmsq6ly9dx/jXMPld7suQOeWEQ/cU9EeQ+Pnaf6PJZ
 uIWgKMI7NIMcyY0mUltPRyekZySW3gOzWKcmS4E3LTWWwohXZaHUdVmqoTiW0SqM7nUA
 viOQ==
X-Gm-Message-State: AOJu0Yz/I0axxknTA5R15DBZScON+voXFysz17U+oOxX80nFBn7Vzyo9
 ZiHk4A1hYVStpoPGDASn6Su+ebQElPKnZPj8Jk8351VL1eSJfGg4zn3cx0i2G1YCvSWj/T1wefg
 4VQ==
X-Google-Smtp-Source: AGHT+IHuLyI7y624xurKJq1twWNugBOT2pLphEfmFfoYCMKinHFBwp8yfvL9RX8cOraGxeoQq6amNQ==
X-Received: by 2002:a05:6e02:b4e:b0:3a0:ca91:2b4e with SMTP id
 e9e14a558f8ab-3a3a709ddfbmr108866625ab.3.1728945137882; 
 Mon, 14 Oct 2024 15:32:17 -0700 (PDT)
Received: from chromium.org (c-107-2-138-191.hsd1.co.comcast.net.
 [107.2.138.191]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4dbecc4924dsm14847173.153.2024.10.14.15.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2024 15:32:17 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Janne Grunau <j@jannau.net>, Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 02/20] video: Avoid starting a new line to close to the
 bottom
Date: Mon, 14 Oct 2024 16:31:54 -0600
Message-Id: <20241014223212.2212442-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241014223212.2212442-1-sjg@chromium.org>
References: <20241014223212.2212442-1-sjg@chromium.org>
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
index 80e7adf6a1a..ebe96bf0c2f 100644
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
index fd19723b1d2..c7afe22d823 100644
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
index 8b5928dc5eb..723d2315606 100644
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

