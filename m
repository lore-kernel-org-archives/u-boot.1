Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61696C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:42:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32E1E88A64;
	Wed, 31 Jul 2024 16:41:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JvOBkz8B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 57A1288958; Wed, 31 Jul 2024 16:41:22 +0200 (CEST)
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com
 [IPv6:2607:f8b0:4864:20::d36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2854088958
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:41:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd36.google.com with SMTP id
 ca18e2360f4ac-81f96eaa02aso215269639f.2
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436879; x=1723041679; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0j1bes5YLXzY5J61Qbe3iY9Var4uucdcZdNTux/Zng=;
 b=JvOBkz8BjwEoK0jkDD3/HL0L9YZCoiYiiKzC51drz8Nxq6Gj/IX5mRVeQ/aGN+TFsh
 1KXzsmIEhJxIEQWSOP4cfDAk53OdQju1tVTjow6V+oEOqFJFeod7l84f3cBZCzbTeXXn
 jZr3sOKKb5uDAGfnVEb2uyGaKkl77dcL4GMA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436879; x=1723041679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0j1bes5YLXzY5J61Qbe3iY9Var4uucdcZdNTux/Zng=;
 b=e5jD1AoaVdwMf8tt42iY32UWG+6Cv3EEEhJXV90p/FkZgjw/4EsewGq1uBjo2LCb+9
 I7nbhPrkUaYMn8dl3B3adi0k/Ko8Khse04dNCzKAVmytTzxOPMlGPLCIf6YNVP5TqsAQ
 30SxbkJmoNRoGZjCO91mauaH+N0J9nuYuDM9JSI/kdAZ3Jnw0bGwp3kXvsY8Nsav5LuL
 DjLH8XgF9h0UvsCFwuNhB6ebOwhx7IG6ah6ofr+YBHWzjCa8pMwxaU9PbtfzaBzADlB6
 GmVhkSqnYFePAjFiRoQjAxAYIbsQOjWr77Adj06IspIebRXpTlBnBvPWiVI2zUY2sMeT
 ZmmA==
X-Gm-Message-State: AOJu0YwfCVrgXwY1TqcuCFvLD2133S5Bbe2WREM9JP87GS9+B+RmVjZe
 hh74yRBboVbXBrhqrqSvGSoF/EogjNSANklMeNhzWkc1KzpamM8lhc45WsLxX/1+fNWNKtxn8HM
 =
X-Google-Smtp-Source: AGHT+IHDkrmrvIZr5h2IkRtXNuPyo8VXucD05dqUOVSMoWkKpvEhgjiekzBxTkmjERlZWdtT5b1uVQ==
X-Received: by 2002:a05:6602:2dd2:b0:803:5e55:ecb2 with SMTP id
 ca18e2360f4ac-81f959d2b12mr1566813339f.0.1722436878661; 
 Wed, 31 Jul 2024 07:41:18 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fc0a569sm3209770173.126.2024.07.31.07.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:41:18 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 2/5] video: Move last_sync to private data
Date: Wed, 31 Jul 2024 08:41:09 -0600
Message-Id: <20240731144112.787509-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144112.787509-1-sjg@chromium.org>
References: <20240731144112.787509-1-sjg@chromium.org>
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

(no changes since v1)

 drivers/video/video-uclass.c | 10 +++-------
 include/video.h              |  2 ++
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index ff1382f4a43..a95b5f199dc 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -349,6 +349,7 @@ void video_set_default_colors(struct udevice *dev, bool invert)
 /* Flush video activity to the caches */
 int video_sync(struct udevice *vid, bool force)
 {
+	struct video_priv *priv = dev_get_uclass_priv(vid);
 	struct video_ops *ops = video_get_ops(vid);
 	int ret;
 
@@ -364,20 +365,15 @@ int video_sync(struct udevice *vid, bool force)
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
index 4d8df9baaad..4013a949983 100644
--- a/include/video.h
+++ b/include/video.h
@@ -97,6 +97,7 @@ enum video_format {
  *		the LCD is updated
  * @fg_col_idx:	Foreground color code (bit 3 = bold, bit 0-2 = color)
  * @bg_col_idx:	Background color code (bit 3 = bold, bit 0-2 = color)
+ * @last_sync:	Monotonic time of last video sync
  */
 struct video_priv {
 	/* Things set up by the driver: */
@@ -121,6 +122,7 @@ struct video_priv {
 	bool flush_dcache;
 	u8 fg_col_idx;
 	u8 bg_col_idx;
+	ulong last_sync;
 };
 
 /**
-- 
2.34.1

