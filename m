Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BFDC61D85
	for <u-boot@archiver.kernel.org>; Tue, 21 Nov 2023 02:10:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EF0B875B6;
	Tue, 21 Nov 2023 03:09:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Th6RgXbh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 47F1787574; Tue, 21 Nov 2023 03:09:43 +0100 (CET)
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com
 [IPv6:2001:4860:4864:20::2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 01ECC875AF
 for <u-boot@lists.denx.de>; Tue, 21 Nov 2023 03:09:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-1f5d34235dbso1176441fac.0
 for <u-boot@lists.denx.de>; Mon, 20 Nov 2023 18:09:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700532577; x=1701137377; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pjQ/+NjgRXSNOGDR5CMWXGxUp5a4rdSej5cQZDLBezw=;
 b=Th6RgXbhCKnpbHQpjDQEtqv0Itq5LkPRxCsGOrodt00VhsRomAErxsUVSBuheoFuK/
 MGJdyEI+kGkBiJgXlBrYeFXT9WNi25iSNxH14jhg3T5aDSdgNxfNSXLuX36CpN5YFTnQ
 py1MePgtZxtwtn7o7chGB1vk/s5ZlDUesH3Jw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700532577; x=1701137377;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pjQ/+NjgRXSNOGDR5CMWXGxUp5a4rdSej5cQZDLBezw=;
 b=xIsOyBn342+elb4RUa3iKp7tr6FgShEfta39cDa5gANddgjZBNN4rarHAWXEk0b5Ne
 rYKes6Hky038bnMcMW0QOdKM9IL2L8khYA45MNPp+SGLHlQCHydapmxkqega6+7Vpra8
 nWKBTCMLm1uZ9OcC55I+4I8MuH+fXLrAnHtG5ZnYuueLG5k9VaZk4ZtwDuWBUflKWPCr
 UmjX+XHf6TxBQt1cOXRDaXsQEcDfbj4Fue+ZCnVAEtkNBQmHET3Qk1GRtojZpg096kXX
 s9HniCfjzUU2W74VqR+O0/hZbBU3gTzWGrzsfQsmco5vsfL92NsCv6SHRBBrX49I3u0l
 MyFg==
X-Gm-Message-State: AOJu0YxO90vfnxobOKHhicuh6NwjbNieFuEgEUkcehVGSrzlbW0g7+Q3
 05fnKo3HLqrQpLAQylSGTm0fAB+CwOyDN8q37f82kg==
X-Google-Smtp-Source: AGHT+IHKICG3QneLTNtvDEvSxhouZ+pcMRyfwWHU70qclQaJ5vDbxBfYZBmtj4VZpN72rLnjQptaPw==
X-Received: by 2002:a05:6871:750e:b0:1f9:453b:8234 with SMTP id
 ny14-20020a056871750e00b001f9453b8234mr681795oac.27.1700532577518; 
 Mon, 20 Nov 2023 18:09:37 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 du20-20020a0568716e1400b001e12f685592sm1542693oac.13.2023.11.20.18.09.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Nov 2023 18:09:37 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/5] video: Move last_sync to private data
Date: Mon, 20 Nov 2023 19:09:26 -0700
Message-ID: <20231121020932.733405-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
In-Reply-To: <20231121020932.733405-1-sjg@chromium.org>
References: <20231121020932.733405-1-sjg@chromium.org>
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
2.43.0.rc1.413.gea7ed67945-goog

