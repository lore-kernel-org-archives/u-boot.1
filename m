Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13A72E784A7
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 01:32:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 08E828722B;
	Mon,  2 Oct 2023 03:17:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="QwlHYzNt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 828BC870F7; Mon,  2 Oct 2023 03:17:30 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 543128722B
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 03:17:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-79f915e5b47so569164439f.2
 for <u-boot@lists.denx.de>; Sun, 01 Oct 2023 18:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1696209381; x=1696814181; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDNfNlWmelUXYrbhlsuE5MbymORdCwHI6pICU8wVXLg=;
 b=QwlHYzNtccr88S2tCX8ZAMiO2cT48kq7uT6tIUHLazEadR8vMzlM7US66fnmCtcon2
 dWg9l+ppzJ7z5DBVxHIDs2vhpC5TMqdgX9wpPWkUyYmwr/xcaS+q2or0v8xP3Zsn+ZEC
 u9rE6cZKJI8gthkzSUaJNsRWHn28Z/bNT+jjs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696209381; x=1696814181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SDNfNlWmelUXYrbhlsuE5MbymORdCwHI6pICU8wVXLg=;
 b=i6U+fR8V6nxU4AklDZEGCKGnAj6rl+gaQAfeZewj0QV9PXMSDjPKXSQExZ+z2ZkdJH
 0miDhFqjiwyDyPWrau3zmoc2J0pN+KVZyK3Onjx/S9Op4ls6Yw3PkTbM2vXt1DCCvxkK
 Xf5453hJzE/wpzJmm3/jEeaY6oq7tgBzCK8b8H/eHimqMgyQVBNphnnOEgdAWmVFj68e
 ZEhFARyDFZcxJ9zRjIKcc8x9ubMIS5VSzkx6M+kdXxfVjVzdqPUO24jAzoDn1lWxjTYA
 Nfsr75nmUF6p8eS4OpKdjr1VAQtID6b+spdksv5N4FZ441f2kD3mey4lRo4s1HyjjOjr
 5dIg==
X-Gm-Message-State: AOJu0YxutW4yXoIxnDVRv51qeXivmvYU2fy8HvXUAeJBAFYUNYqWloyT
 cyf5+fiJyji9fQ3OW/wihbHI1Dq6relXs4lpBWw=
X-Google-Smtp-Source: AGHT+IElLEvB5NRwxf1Q4n0KjuJ3jaAjmYIF6tAerpi3tEx9hqzopfl+xWjK6m3XN73q8UHNWj66rw==
X-Received: by 2002:a5d:9cda:0:b0:785:ca70:46a2 with SMTP id
 w26-20020a5d9cda000000b00785ca7046a2mr12452870iow.4.1696209381199; 
 Sun, 01 Oct 2023 18:16:21 -0700 (PDT)
Received: from sjg1.roam.corp.google.com (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 l26-20020a02a89a000000b0041d859c5721sm6819619jam.64.2023.10.01.18.16.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Oct 2023 18:16:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Bin Meng <bmeng.cn@gmail.com>,
 Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 17/34] video: Avoid starting a new line to close to the bottom
Date: Sun,  1 Oct 2023 19:15:27 -0600
Message-ID: <20231002011553.463514-18-sjg@chromium.org>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
In-Reply-To: <20231002011553.463514-1-sjg@chromium.org>
References: <20231002011553.463514-1-sjg@chromium.org>
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

 drivers/video/vidconsole-uclass.c | 4 +++-
 include/video.h                   | 3 ++-
 include/video_console.h           | 8 ++++++++
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index a312a1985242..a8d2199147dd 100644
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
index ae9ce03f5bfa..e20f1173762e 100644
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
index bde67fa9a5a9..ecbf183b3d03 100644
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
2.42.0.582.g8ccd20d70d-goog

