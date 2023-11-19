Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D686C54E76
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:48:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2833869C4;
	Sun, 19 Nov 2023 15:47:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="C+Zl+6gk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF042871DE; Sun, 19 Nov 2023 15:47:19 +0100 (CET)
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com
 [IPv6:2607:f8b0:4864:20::d2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2ECE5870EB
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:47:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-7a68b87b265so136077839f.2
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405228; x=1701010028; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y8bUfOOS4WXBRxHb6aECT92i1dC4uCKLkKmN+hWQzhY=;
 b=C+Zl+6gkYwbr6QK6hapfv5mwdqXU3k+j9LpIb7l92jyqGLtqDYAWQaDkrbFNrcurtg
 GgkN22P+u8NoTF9hNyanKKlzkPtLrgvzmu98y7JKYSuuGrS5b6TEHb96KES6SVEL9eOB
 Fjd2sViXfq28d3fQRcQbtKbSpm95HtNMZAgN8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405228; x=1701010028;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y8bUfOOS4WXBRxHb6aECT92i1dC4uCKLkKmN+hWQzhY=;
 b=PVw8mdgz4Itlfl94pACiDK6KuT2vAjtIkX2/roSFj82E6yZOpdXmTxM2pCv5V7bqn8
 NZ8znhnL8fAWx9ymmJ1/RY53vXdX04LoI06d8ZL04zOE2xtCsViU8NbWwPNehSf4nCLG
 OyIlTZOEXFyJSSsitT398TtbvKPkZt4Xco308cLjELsKDxtEikAznJ6JrrJdvVCeiStA
 PTorHBJ/it5Vt9W/5xuHbP5TJOj0LjiGWpw2kjJp0gujwxWowyzhNTb3eGldyHfUudVc
 6LCExBUd+VRLjr34E9oBWcFpOCCdocm3X9AYKc0tIm9kmY+f611/qgRUJFAWZ2Hsb7Di
 rAeg==
X-Gm-Message-State: AOJu0YxAVGZFokB6v5YB8/UU+zpyqNP05b7ABREGrNntjLs5Dn0cXeVB
 +YIBPgfPvn/yHs4sNT1qtnryB/A2gNT46UEAVrEx3w==
X-Google-Smtp-Source: AGHT+IFtlmo0mEzM7dJZJ2/RmjP7A939XLjJR0PeuyneybEzeiOhR0yN4zYyIZye0LKvAQKJAmz0Rg==
X-Received: by 2002:a05:6602:1586:b0:7a9:a31e:c05d with SMTP id
 e6-20020a056602158600b007a9a31ec05dmr7881095iow.18.1700405227785; 
 Sun, 19 Nov 2023 06:47:07 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a023946000000b0043194542229sm1450695jae.52.2023.11.19.06.47.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:47:07 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 2/5] video: Move last_sync to private data
Date: Sun, 19 Nov 2023 07:46:40 -0700
Message-ID: <20231119144700.631322-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144700.631322-1-sjg@chromium.org>
References: <20231119144700.631322-1-sjg@chromium.org>
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

Rather than using a static variable, use the video device's private
data to remember when the last video sync was completed. This allows
each display to have its own sync and avoids using static data in SPL.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/video-uclass.c | 10 +++-------
 include/video.h              |  2 ++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index f743ed74c818..600e12b802d1 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -354,6 +354,7 @@ void video_set_default_colors(struct udevice *dev, bool invert)
 /* Flush video activity to the caches */
 int video_sync(struct udevice *vid, bool force)
 {
+	struct video_priv *priv = dev_get_uclass_priv(vid);
 	struct video_ops *ops = video_get_ops(vid);
 	int ret;
 
@@ -369,20 +370,15 @@ int video_sync(struct udevice *vid, bool force)
 	 * out whether it exists? For now, ARM is safe.
 	 */
 #if defined(CONFIG_ARM) && !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
-	struct video_priv *priv = dev_get_uclass_priv(vid);
-
 	if (priv->flush_dcache) {
 		flush_dcache_range((ulong)priv->fb,
 				   ALIGN((ulong)priv->fb + priv->fb_size,
 					 CONFIG_SYS_CACHELINE_SIZE));
 	}
 #elif defined(CONFIG_VIDEO_SANDBOX_SDL)
-	struct video_priv *priv = dev_get_uclass_priv(vid);
-	static ulong last_sync;
-
-	if (force || get_timer(last_sync) > 100) {
+	if (force || get_timer(priv->last_sync) > 100) {
 		sandbox_sdl_sync(priv->fb);
-		last_sync = get_timer(0);
+		priv->last_sync = get_timer(0);
 	}
 #endif
 	return 0;
diff --git a/include/video.h b/include/video.h
index 5048116a3d57..b9b8dc0f8f99 100644
--- a/include/video.h
+++ b/include/video.h
@@ -94,6 +94,7 @@ enum video_format {
  *		the LCD is updated
  * @fg_col_idx:	Foreground color code (bit 3 = bold, bit 0-2 = color)
  * @bg_col_idx:	Background color code (bit 3 = bold, bit 0-2 = color)
+ * @last_sync:	Monotonic time of last video sync
  */
 struct video_priv {
 	/* Things set up by the driver: */
@@ -118,6 +119,7 @@ struct video_priv {
 	bool flush_dcache;
 	u8 fg_col_idx;
 	u8 bg_col_idx;
+	ulong last_sync;
 };
 
 /**
-- 
2.43.0.rc0.421.g78406f8d94-goog

