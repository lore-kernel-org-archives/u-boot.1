Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A295EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 93F3887055;
	Mon, 21 Aug 2023 20:13:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O8Ysp3TH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0EA78705F; Mon, 21 Aug 2023 20:13:54 +0200 (CEST)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C6AC487063
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:13:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fee06efd6bso14409725e9.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692641630; x=1693246430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=USpTnyEhp5Tl6xPCurlpu/0fZemT5ZyzMGpO5ZhQRNI=;
 b=O8Ysp3THirvzIAuBOTZ3ZQEFRseM2+7s/ZYYojZxsbun+/a5LXe5p9AWrJsLYn7YxT
 ElIel0GjILaU1QkCLPvswAIBCgcG122/D9nHcsq9N8t9lGF+QxC5YgowP1qV/AJdJsce
 k7kFria0vgu6hTwIYPZcFulH44Q+ew+fU4G06V29B9J6pEAFVQuKp956SSmUPv7IdTaQ
 fUFODZylo1B6pZjWnVjzcXUdt9FEDcWUvvfxJJI1ACUMd4uWCUZMdxzw+Sd0jh4Tu5eF
 uozF2Hs6TCOMwAnxepqxtJCkV885YyVVQx3Xhahl1Yo2d9i0e2GFgy5Ue0FrCAif185o
 8I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692641630; x=1693246430;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=USpTnyEhp5Tl6xPCurlpu/0fZemT5ZyzMGpO5ZhQRNI=;
 b=jC/uq+qiDiJ9hqoRuC10I8pYn+Y+H/a29A1e3OR3fe9nA1YTlcAp+tqJVfEGAuJkoP
 D31DyWTqCSfrfT/eRj33XWXpVkk3eMyEwZgB+ka1x1j6/hOB0GCf5AqwV/BBlbI6FoPX
 iREHVWV+oKXDS59gMYDCwrSPYCKKi2IJM5yHtSrKo0lv94P62NFA3QsJ3IGNn6xg0HS9
 bqQP+cd7a6a8gIyRlc/sPQ5fcRUf9riTwhm7TqWKac6bATWomIzmAsRQSAM/xEn+93OF
 z36ezq00nYB4onmcB3v940DmYG8ohdQoc0R1AuKRpxttY4MIHwAOrd9Z0gMzB/F8eK4r
 Oh7w==
X-Gm-Message-State: AOJu0YzKH6Kk5TmwILcZFk1cw13+R/kt6j+ucWIE1PsUo6sV443tenaf
 5OlcFfP+zBtg7iWHD6e25NuWkX/eRa8=
X-Google-Smtp-Source: AGHT+IE+zsQ+e4srZyFS17O8x00No0362RFtgzyvwciIkKOUgJgzQW/XCGgXVNVEzdcYV25b6AnaWA==
X-Received: by 2002:adf:f752:0:b0:319:6b14:555c with SMTP id
 z18-20020adff752000000b003196b14555cmr5084023wrp.3.1692641630227; 
 Mon, 21 Aug 2023 11:13:50 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm13192025wrh.44.2023.08.21.11.13.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:13:49 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH 1/5] sandbox: video: Display copy framebuffer if enabled
Date: Mon, 21 Aug 2023 21:13:35 +0300
Message-Id: <20230821181339.4135800-2-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
References: <20230821181339.4135800-1-alpernebiyasak@gmail.com>
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

When VIDEO_COPY is enabled, the "main" framebuffer is a cached work area
in U-Boot allocated memory and the "copy" framebuffer is the hardware
frame buffer displayed on the screen. The sandbox SDL video driver sets
copy_base to indicate support for this, but it displays the work area
instead. Change it to display the copy buffer if enabled.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 drivers/video/video-uclass.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index 3f9ddaadd15d..7cec6362570f 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -454,9 +454,13 @@ int video_sync(struct udevice *vid, bool force)
 
 #if defined(CONFIG_VIDEO_SANDBOX_SDL)
 	static ulong last_sync;
+	void *fb = priv->fb;
+
+	if (IS_ENABLED(CONFIG_VIDEO_COPY))
+		fb = priv->copy_fb;
 
 	if (force || get_timer(last_sync) > 100) {
-		sandbox_sdl_sync(priv->fb);
+		sandbox_sdl_sync(fb);
 		last_sync = get_timer(0);
 	}
 #endif
-- 
2.40.1

