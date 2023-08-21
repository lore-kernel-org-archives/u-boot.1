Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16300EE4993
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 18:14:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BA7758705D;
	Mon, 21 Aug 2023 20:14:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CiDre5Uz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6C76386F7A; Mon, 21 Aug 2023 20:14:00 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31E3E8705F
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 20:13:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-3fe8242fc4dso36292225e9.1
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 11:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692641636; x=1693246436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g41reL+MuagRh2sR3CbYPQP43TJsuuxN6qaXC7xWmPY=;
 b=CiDre5UzPPG53zK3pgGTi+YIaRhpfFi2e85WfeCVEdKv+KF7vW26jIZJFZ+DOKKlTw
 mhSN5O9nQp3BpbinAToBDFYAYLpmQ16JWEdP3EcfVR1UiiD8hEMkLy22vW8Rz/9PwCl5
 8mVJGDLmyOcTKtV+xENoGNCU5nZth9uVPIxBK8FU7hXMk8rhp1Zye21IZIe6FYi31Twb
 R0iz9IuR7PgpVPLVYDBBFiUFCpvA9ubVrIrtf0JTTiFEOttkW9qcfa2YEOYGMsfaYbiY
 sSSDYdolrQL28C5TTbeOQcBZvukXfpYJkFj7pYt63XmfvYIjmQqkCKxlAeGAcnqMdJ+w
 VQiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692641636; x=1693246436;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g41reL+MuagRh2sR3CbYPQP43TJsuuxN6qaXC7xWmPY=;
 b=iySanZ0rviX55Ph23GT45IQ/FLi1kgtlv7GLTMr5xgqtcZAw0sGofCs+gFIOxHeBac
 sB8HTgYpOcGsJ/XDGJVHZIsJHT17NRrhy2pTCODdlm5UnVCNw4qbPxRVGKCu+woz9L8R
 Dkfbh/U0wJaYaHI/JVuaNUG0p6PqARRdDsbM6A3ikB837RlTHNAwnmkX4Q07yOcwXvM7
 94OdI8GEID/dKNznKJ4P93Pk6wIe0W+nha3COTm9CXETOzYVxxhZRWzs3XTxGCeUPMck
 tNpaHxw9PGHMaOHzCYG5vW5QmqIVOfN9083P7OMCBY6q7DY6W63YeqeMQCRqHOL0VuLE
 7V8g==
X-Gm-Message-State: AOJu0Yw/zaX/gpuKSRWSLK7SV+4+pEG5LqEa4OI/kN+oOabZ+DcQxV57
 ufAJhtcViq5/aw5vKYgQfMHjsOv1U9g=
X-Google-Smtp-Source: AGHT+IEdn39UUI7afYXzpw+9rktaGHYD87BuYpECpzL2n2qYJhjn7DuPLB9V8sqRQJoPKNbUZF/2Rw==
X-Received: by 2002:adf:e608:0:b0:316:f3cf:6f12 with SMTP id
 p8-20020adfe608000000b00316f3cf6f12mr5298976wrm.48.1692641636585; 
 Mon, 21 Aug 2023 11:13:56 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 z1-20020adfd0c1000000b003143c9beeaesm13192025wrh.44.2023.08.21.11.13.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 11:13:56 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [RFC PATCH 5/5] sandbox: video: Use partial updates for SDL display
Date: Mon, 21 Aug 2023 21:13:39 +0300
Message-Id: <20230821181339.4135800-6-alpernebiyasak@gmail.com>
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

Now that we have video damage tracking, try to reduce the SDL display
work by copying only the updated regions onto the SDL texture instead of
the entire framebuffer. We still have to do RenderClear and RenderCopy
the whole texture onto the renderer, but that allegedly happens in the
GPU.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---
The second half of copy_to_texture is untested.

 arch/sandbox/cpu/sdl.c         | 25 +++++++++++++++++--------
 arch/sandbox/include/asm/sdl.h |  9 +++++++--
 drivers/video/sandbox_sdl.c    | 16 +++++++++++++++-
 3 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
index 48fae20b4c2d..3a3221d89066 100644
--- a/arch/sandbox/cpu/sdl.c
+++ b/arch/sandbox/cpu/sdl.c
@@ -192,8 +192,10 @@ int sandbox_sdl_init_display(int width, int height, int log2_bpp,
 	return 0;
 }
 
-static int copy_to_texture(void *lcd_base)
+static int copy_to_texture(void *lcd_base, int xstart, int ystart,
+			   int xend, int yend)
 {
+	struct SDL_Rect rect;
 	char *dest;
 	int pitch, x, y;
 	int src_pitch;
@@ -201,8 +203,15 @@ static int copy_to_texture(void *lcd_base)
 	char *src;
 	int ret;
 
+	rect.x = xstart;
+	rect.y = ystart;
+	rect.w = xend - xstart + 1;
+	rect.h = yend - ystart + 1;
+
 	if (sdl.src_depth == sdl.depth) {
-		SDL_UpdateTexture(sdl.texture, NULL, lcd_base, sdl.pitch);
+		src_pitch = sdl.width * sdl.src_depth / 8;
+		src = lcd_base + src_pitch * rect.y + rect.x * sdl.src_depth / 8;
+		SDL_UpdateTexture(sdl.texture, &rect, src, src_pitch);
 		return 0;
 	}
 
@@ -215,7 +224,7 @@ static int copy_to_texture(void *lcd_base)
 		return -EINVAL;
 	}
 
-	ret = SDL_LockTexture(sdl.texture, NULL, &pixels, &pitch);
+	ret = SDL_LockTexture(sdl.texture, &rect, &pixels, &pitch);
 	if (ret) {
 		printf("SDL lock %d: %s\n", ret, SDL_GetError());
 		return ret;
@@ -223,12 +232,12 @@ static int copy_to_texture(void *lcd_base)
 
 	/* Copy the pixels one by one */
 	src_pitch = sdl.width * sdl.src_depth / 8;
-	for (y = 0; y < sdl.height; y++) {
+	for (y = 0; y < rect.h; y++) {
 		char val;
 
 		dest = pixels + y * pitch;
-		src = lcd_base + src_pitch * y;
-		for (x = 0; x < sdl.width; x++, dest += 4) {
+		src = lcd_base + src_pitch * (ystart + y) + xstart;
+		for (x = 0; x < rect.w; x++, dest += 4) {
 			val = *src++;
 			dest[0] = val;
 			dest[1] = val;
@@ -241,7 +250,7 @@ static int copy_to_texture(void *lcd_base)
 	return 0;
 }
 
-int sandbox_sdl_sync(void *lcd_base)
+int sandbox_sdl_sync(void *lcd_base, int xstart, int ystart, int xend, int yend)
 {
 	struct SDL_Rect rect;
 	int ret;
@@ -253,7 +262,7 @@ int sandbox_sdl_sync(void *lcd_base)
 		return -EAGAIN;
 
 	SDL_RenderClear(sdl.renderer);
-	ret = copy_to_texture(lcd_base);
+	ret = copy_to_texture(lcd_base, xstart, ystart, xend, yend);
 	if (ret) {
 		printf("copy_to_texture: %d: %s\n", ret, SDL_GetError());
 		return -EIO;
diff --git a/arch/sandbox/include/asm/sdl.h b/arch/sandbox/include/asm/sdl.h
index 1ace7d1a1217..c7c73ef3a3e6 100644
--- a/arch/sandbox/include/asm/sdl.h
+++ b/arch/sandbox/include/asm/sdl.h
@@ -41,10 +41,14 @@ int sandbox_sdl_remove_display(void);
  * system resources too much.
  *
  * @lcd_base: Base of frame buffer
+ * @xstart:   X start position of updated region in pixels from the left
+ * @ystart:   Y start position of updated region in pixels from the top
+ * @xend:     X end position of updated region in pixels from the left
+ * @yend:     Y end position of updated region in pixels from the top
  * Return: 0 if screen was updated, -ENODEV is there is no screen.
  *	   -EAGAIN if screen was not updated due to sync rate limit.
  */
-int sandbox_sdl_sync(void *lcd_base);
+int sandbox_sdl_sync(void *lcd_base, int xstart, int ystart, int xend, int yend);
 
 /**
  * sandbox_sdl_scan_keys() - scan for pressed keys
@@ -118,7 +122,8 @@ static inline int sandbox_sdl_remove_display(void)
 	return -ENODEV;
 }
 
-static inline int sandbox_sdl_sync(void *lcd_base)
+static inline int sandbox_sdl_sync(void *lcd_base, int xstart, int ystart,
+				   int xend, int yend)
 {
 	return -ENODEV;
 }
diff --git a/drivers/video/sandbox_sdl.c b/drivers/video/sandbox_sdl.c
index 7dc2787a5d25..eb424072b6fe 100644
--- a/drivers/video/sandbox_sdl.c
+++ b/drivers/video/sandbox_sdl.c
@@ -103,11 +103,25 @@ static int sandbox_sdl_video_sync(struct udevice *dev)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	void *fb = priv->fb;
+	int xstart = 0;
+	int ystart = 0;
+	int xend = priv->xsize;
+	int yend = priv->ysize;
 
 	if (IS_ENABLED(CONFIG_VIDEO_COPY))
 		fb = priv->copy_fb;
 
-	return sandbox_sdl_sync(fb);
+	if (IS_ENABLED(CONFIG_VIDEO_DAMAGE)) {
+		if (!priv->damage.xend && !priv->damage.yend)
+			return 0;
+
+		xstart = priv->damage.xstart;
+		ystart = priv->damage.ystart;
+		xend = priv->damage.xend;
+		yend = priv->damage.yend;
+	}
+
+	return sandbox_sdl_sync(fb, xstart, ystart, xend, yend);
 }
 
 static int sandbox_sdl_remove(struct udevice *dev)
-- 
2.40.1

