Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26452C4167B
	for <u-boot@archiver.kernel.org>; Sat,  2 Dec 2023 15:34:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D510987692;
	Sat,  2 Dec 2023 16:34:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="P1w7poih";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9934887631; Sat,  2 Dec 2023 16:34:24 +0100 (CET)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com
 [IPv6:2607:f8b0:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 746DE8763D
 for <u-boot@lists.denx.de>; Sat,  2 Dec 2023 16:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1ce3084c2d1so14010475ad.3
 for <u-boot@lists.denx.de>; Sat, 02 Dec 2023 07:34:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1701531260; x=1702136060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WMf8r2xycgHdZPldfmKY7o+vyVDRZ2X6IbkU2pNRX6E=;
 b=P1w7poih2ET2GRkDG4rV8FIkAY28/s5gPy36U/CpOfl3TJNm+gWkcVVSPPNbrxxigi
 urrGzZ8f1HVJBczAnHdF6X7mPco7HP70b9s6OXccU9NCkgQNgcTaj2JbXJImjIx8zl6q
 AZCSvDXo0+M6f6CmPP0nL6OxwJg7zqB/r1Q1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701531260; x=1702136060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WMf8r2xycgHdZPldfmKY7o+vyVDRZ2X6IbkU2pNRX6E=;
 b=AzNH5txMIs/uyxLiqFGIg9UWZKj5NBxVyVZPubDCx8qWptcbCY3oW3NzmmkX9gML6M
 6VY+5944DjGu+n1CBAl1p5AsZn9BaYGpy8wx6iAby43fYFRABJYhp32GoPGpIAhcW8ef
 7LB6yyGzH7s236zilZINcrVWlJVdsiKN9aU5uur2kehvhxNJzC8i3itLRu9taoBKhVPb
 mVNfB6J07ZkP79rDj6zJjvErdzHUxRIMi9iymKnZMD/vWBo9DiwIszdOVNd0BCb0o+HV
 ZdGfhswO019P/sORLxY7qsaI81JOtEyRBMSGlU+gvPLrfV2n00Bk1OnKXaccM7d/d/CZ
 eQtA==
X-Gm-Message-State: AOJu0Yz5PE4sLBrBjABCEFSNZELvvKCLGMOtDFSIiejiBY7AdoyCx2uR
 ILsa6t39jmrukXsWmBVjdOOTxBnF+hC4DbFPJxmfGw==
X-Google-Smtp-Source: AGHT+IFdGujR/tLJRTh3Vhnyma1fx73hm4XuRPQvyb2O/vcDkzeieCaV+b94OwNkq2ZOjEHVsCokCQ==
X-Received: by 2002:a17:902:aa08:b0:1d0:6ffe:a17 with SMTP id
 be8-20020a170902aa0800b001d06ffe0a17mr1292753plb.117.1701531260699; 
 Sat, 02 Dec 2023 07:34:20 -0800 (PST)
Received: from sjg1.roam.corp.google.com ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 b5-20020a170902d30500b001cf8546335fsm2869217plc.5.2023.12.02.07.34.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Dec 2023 07:34:20 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
Subject: [PATCH v2 2/5] video: Move last_sync to private data
Date: Sat,  2 Dec 2023 08:33:49 -0700
Message-ID: <20231202153400.537050-3-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231202153400.537050-1-sjg@chromium.org>
References: <20231202153400.537050-1-sjg@chromium.org>
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
index 4d8df9baaada..4013a949983f 100644
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
2.43.0.rc2.451.g8631bc7472-goog

