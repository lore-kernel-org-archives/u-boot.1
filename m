Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88E93C3065C
	for <u-boot@archiver.kernel.org>; Thu,  4 Jul 2024 07:49:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4D7B1888B7;
	Thu,  4 Jul 2024 09:49:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V12tmvDV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0AB23888AF; Thu,  4 Jul 2024 09:49:12 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C3CEB888B0
 for <u-boot@lists.denx.de>; Thu,  4 Jul 2024 09:49:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-424ad289949so2064475e9.2
 for <u-boot@lists.denx.de>; Thu, 04 Jul 2024 00:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1720079348; x=1720684148; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B0j1bes5YLXzY5J61Qbe3iY9Var4uucdcZdNTux/Zng=;
 b=V12tmvDV3WU09tsV9zf7RoS5LYGHDfXeKYcL4oHcvShB+ImqApRCgFE26ghIPu5rVS
 wrOCW/ZuMuWFfm6ykZyrq9oI0cb9+RnP+uKc7IT7yRBTeKTbjljUicRPrNvQ01Ef2yVT
 UiWz+W1xHzv34AjKPFiB9/BWU33Vs17aiW+V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720079348; x=1720684148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B0j1bes5YLXzY5J61Qbe3iY9Var4uucdcZdNTux/Zng=;
 b=C344X90Rh8qQlv7fF3Pzs4It6Jl48Demfnl/bjb8IaS9QuM4+dKqniIGS+ZhEKP/yy
 7eNk64YwTKjSrKNPAULSnH+fm8DjPfY/w/niDq0VEeTKrRydwBIUwimv3/ZTpWDgLXRP
 9tB8bykBaoS4wzKDckSIyfHG0S0ac1cTbrmvIotnNie0UIOnxfYxJ1GR2vQogkTagHZ4
 kHArh7r9BCZUv6waSZ/MW53vpjBfa4wfHjKwa1+MjK+MhkjsqJmDYoCLcztl/BG9E7u5
 Rzf0Jv09Cnv9RDKUA0KaqcqBes/ooLupfKMiMnXhYBhkkLnnKz7+Tc+Mi+6NURmMSOMf
 TW0A==
X-Gm-Message-State: AOJu0Yz2TJz61X4rjfbV9onMcdq3JYIZ4sO8CBiIqls02IoIV+OJInq8
 UxVLXCSgDpqc+AVV1okt9A1RXraa/L/+sgDS1t8jT3/97ZKKfWcX50eMd/rIlZuaq0qSpWdlz50
 =
X-Google-Smtp-Source: AGHT+IGQWcGSPg3HriypnaGUIkg7K+wPLwbpaxhie4EojBnp+VFMeytpV9EEtFTwXTe1Kvj0xFZeNA==
X-Received: by 2002:a05:600c:12d6:b0:425:6275:f7a with SMTP id
 5b1f17b1804b1-4264a3d7653mr7138155e9.15.1720079347856; 
 Thu, 04 Jul 2024 00:49:07 -0700 (PDT)
Received: from tasman.. (host-92-15-194-143.as13285.net. [92.15.194.143])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4264a2ca5casm12885515e9.32.2024.07.04.00.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jul 2024 00:49:07 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>,
 Bin Meng <bmeng@tinylab.org>, Dan Carpenter <dan.carpenter@linaro.org>,
 Devarsh Thakkar <devarsht@ti.com>, Nikhil M Jain <n-jain1@ti.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: [PATCH v3 2/5] video: Move last_sync to private data
Date: Thu,  4 Jul 2024 08:48:56 +0100
Message-Id: <20240704074859.2956745-3-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240704074859.2956745-1-sjg@chromium.org>
References: <20240704074859.2956745-1-sjg@chromium.org>
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

