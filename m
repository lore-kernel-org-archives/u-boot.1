Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13BFBEE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 265DC87060;
	Mon, 21 Aug 2023 20:14:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q/7CWjBO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 79DAF87061; Mon, 21 Aug 2023 20:13:57 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 083B987072
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:13:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3159d5e409dso2987161f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692641633; x=1693246433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SkTXwqxYdD+/DRD6BfjtRhFPLw2dDR7Jl/iLhlBHKn4=;
 b=q/7CWjBOCJDvAA4PnfircCAH0sg0zW1agzeJ6jZYJoYGZcBOQzsCzAq5ra9SuNKYUT
 ZwMA6GYatNayob6Uu+aC8YZOL6OHrpGhD0y9TmlwQiA4WCepJF8XdQKQeNu+fgNX7iqR
 6Z2KsTpN4j9Hczdmv6Phi5tA/ia2mbtf2V8nD+RdzpefSHg9OBQzg0LMSjKCcHKbeEgj
 02Aly/ZC6LUywpkRAH6Eq+gXyr1B/zG9Ug+zFy3Nda9MIGIT1FKoh2a4uKsF934U/PtE
 qcdCV4MqNH8/yLzo17sRiJ1mFbcENmiaR5oYyAy1iFG68RVvPhFt4rPWWT7v375Rg6MN
 E53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692641633; x=1693246433;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkTXwqxYdD+/DRD6BfjtRhFPLw2dDR7Jl/iLhlBHKn4=;
 b=axvzQ1gXiSr27ei4W1x5zcTe7MjoVnrluFz49pxym98sPkPLhuuCtRr55lUzRvzjNu
 ZQ6MEnx8FZ2Af8D2jVtr7QkAuqO9b7+GGSdtyGtenYs7r5UnaTvIg4tI16svrsUQnZyU
 S2DP6wqz8L9jlKc0ICouQeWjfcEcDlQieU2/5lDqNzYhYIMRIuR9xQbebCjsFlU2zEPj
 uuSzrXEgbDq/oWZnp5RbGkAsGo5ojdtHB1lf2lOFmUwwSo6DaajYodjd3iegxKKswFnN
 qrTD2Zt0WKQbZtwosEj84yanHfwaEuy3jAEZR9umJUR+j+Jp3R4Rzb0kWB/mqDz5vgmd
 F0lw==
X-Gm-Message-State: AOJu0Yx5NfVNSO244bfwM4D4TwSiEJBoJypUthurFuUfK9rmO4ZT0mEG
 o/JdkDq6G92n6ECEL2Lv5jJnDm1Zk7A=
X-Google-Smtp-Source: AGHT+IER78GBY/qoofaegk1Vrfr4Nx2s+c8tshL5UJHbj4pDcToPEN5s5wVmlwJ4zw49bY9tvcP+lw==
X-Received: by 2002:adf:e5c1:0:b0:314:3e96:bd7e with SMTP id
 a1-20020adfe5c1000000b003143e96bd7emr5323968wrn.4.1692641633450; 
 Mon, 21 Aug 2023 11:13:53 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm13192025wrh.44.2023.08.21.11.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:13:53 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH 3/5] sandbox: video: Move sync rate limit into SDL code
Date: Mon, 21 Aug 2023 21:13:37 +0300
Message-Id: <20230821181339.4135800-4-alpernebiyasak@gmail.com>
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

As a first step of removing sandbox-specific code from the video uclass,
move the sync rate limiter into the SDL code. We lose the ability to
immediately force a screen refresh, but can retry until it does.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

 arch/sandbox/cpu/sdl.c         | 9 +++++++++
 arch/sandbox/include/asm/sdl.h | 4 +++-
 drivers/video/video-uclass.c   | 8 +++-----
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
index 590e406517bf..48fae20b4c2d 100644
--- a/arch/sandbox/cpu/sdl.c
+++ b/arch/sandbox/cpu/sdl.c
@@ -48,6 +48,7 @@ struct buf_info {
  * @screen: SDL window to use
  * @src_depth: Number of bits per pixel in the source frame buffer (that we read
  * from and render to SDL)
+ * @last_sync: Timestamp of last display update in milliseconds
  */
 static struct sdl_info {
 	int width;
@@ -67,6 +68,7 @@ static struct sdl_info {
 	SDL_Renderer *renderer;
 	SDL_Window *screen;
 	int src_depth;
+	int last_sync;
 } sdl;
 
 static void sandbox_sdl_poll_events(void)
@@ -148,6 +150,7 @@ int sandbox_sdl_init_display(int width, int height, int log2_bpp,
 		sdl.vis_width = sdl.width;
 		sdl.vis_height = sdl.height;
 	}
+	sdl.last_sync = 0;
 
 	if (!SDL_SetHint(SDL_HINT_RENDER_SCALE_QUALITY, "1"))
 		printf("Unable to init hinting: %s", SDL_GetError());
@@ -245,6 +248,10 @@ int sandbox_sdl_sync(void *lcd_base)
 
 	if (!sdl.texture)
 		return 0;
+
+	if (SDL_GetTicks() - sdl.last_sync < 100)
+		return -EAGAIN;
+
 	SDL_RenderClear(sdl.renderer);
 	ret = copy_to_texture(lcd_base);
 	if (ret) {
@@ -268,6 +275,8 @@ int sandbox_sdl_sync(void *lcd_base)
 	SDL_RenderDrawRect(sdl.renderer, &rect);
 
 	SDL_RenderPresent(sdl.renderer);
+	sdl.last_sync = SDL_GetTicks();
+
 	sandbox_sdl_poll_events();
 
 	return 0;
diff --git a/arch/sandbox/include/asm/sdl.h b/arch/sandbox/include/asm/sdl.h
index ee4991f7c24a..1ace7d1a1217 100644
--- a/arch/sandbox/include/asm/sdl.h
+++ b/arch/sandbox/include/asm/sdl.h
@@ -37,10 +37,12 @@ int sandbox_sdl_remove_display(void);
  * sandbox_sdl_sync() - Sync current U-Boot LCD frame buffer to SDL
  *
  * This must be called periodically to update the screen for SDL so that the
- * user can see it.
+ * user can see it. It is internally rate limited to 10 Hz to avoid using
+ * system resources too much.
  *
  * @lcd_base: Base of frame buffer
  * Return: 0 if screen was updated, -ENODEV is there is no screen.
+ *	   -EAGAIN if screen was not updated due to sync rate limit.
  */
 int sandbox_sdl_sync(void *lcd_base);
 
diff --git a/drivers/video/video-uclass.c b/drivers/video/video-uclass.c
index accf486509cb..d867185da539 100644
--- a/drivers/video/video-uclass.c
+++ b/drivers/video/video-uclass.c
@@ -455,16 +455,14 @@ int video_sync(struct udevice *vid, bool force)
 	video_flush_dcache(vid);
 
 #if defined(CONFIG_VIDEO_SANDBOX_SDL)
-	static ulong last_sync;
 	void *fb = priv->fb;
 
 	if (IS_ENABLED(CONFIG_VIDEO_COPY))
 		fb = priv->copy_fb;
 
-	if (force || get_timer(last_sync) > 100) {
-		sandbox_sdl_sync(fb);
-		last_sync = get_timer(0);
-	}
+	ret = sandbox_sdl_sync(fb);
+	while (force && ret == -EAGAIN)
+		ret = sandbox_sdl_sync(fb);
 #endif
 
 	if (IS_ENABLED(CONFIG_VIDEO_DAMAGE)) {
-- 
2.40.1

