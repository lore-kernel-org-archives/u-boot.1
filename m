Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2A9C25B78
	for <u-boot@archiver.kernel.org>; Thu, 16 May 2024 22:17:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B92F188494;
	Fri, 17 May 2024 00:16:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="MdmkaJ6x";
	dkim=pass (2048-bit key; unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.b="gED7wXYY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E2848847B; Fri, 17 May 2024 00:16:54 +0200 (CEST)
Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com
 [103.168.172.148])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDF0C88491
 for <u-boot@lists.denx.de>; Fri, 17 May 2024 00:16:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=flygoat.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jiaxun.yang@flygoat.com
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailfout.nyi.internal (Postfix) with ESMTP id A71D31380184;
 Thu, 16 May 2024 18:16:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Thu, 16 May 2024 18:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1715897810;
 x=1715984210; bh=/B7QpgLfj2l1sn9wJiqnDVdHhhA13qlL8R0kHEjbYXY=; b=
 MdmkaJ6xNT/1cKhexD4/wPF1Z01laBASm13E1HQjJC0o+zjb88hxXDQCIGaqWvw5
 z/Zr9FeAXHfY1aF5fCdxoiQ6+DPJi6qdJ84NQAZtc9nD3fOUIGbUvLg1ijdewMm0
 FlC8XHR/xoDKapYfVi7pjyP7Db1ZIeNGhRBIQSqGwsL44b4kuB4cm/mlsiNeH07n
 MWsmXN3FrZU215Ok1xksQYPgdJtR2V8VYWEwye2JqH+PeSFUMRIaLHAzQ7diFQrx
 CHJ7oj32JK5d18fdAcbXKu2z1RkVZzKv1EYz+O9jTK126qrHgrY5aYiNrA06RX1v
 bB+xBRGoBLvE41ZxpWhLCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1715897810; x=
 1715984210; bh=/B7QpgLfj2l1sn9wJiqnDVdHhhA13qlL8R0kHEjbYXY=; b=g
 ED7wXYYXEt9SfpyaVnyDBk6OSas4HGb3c8EszM/ERC8yAPErHaA65SqyaS7WHri9
 jMxYAvVAEZpO+xQu85BJVhN7319AyLk6QPiz2amL5eFgVkq1KBKThhNXIhROg9sf
 DNGsV/H1V0p5k6Rm2r2xda1xw1Vubq0TmWBzQMWkAvHMdSVOjwg0XwO4/68VcO2v
 0Wg3aFAzAbyv3dmT9/urXtsj/EYUkOPdAGduruSFHyk/GwOPEphrpbM9Cdb4/sIQ
 b9F/NkxB/9oYMrnebP6vgn5XU7/t9FLOjuYYv1tAOfKXkemBXlAOKS8jtLWl4oL6
 D3Dy7uCDN69L5Up25sl3g==
X-ME-Sender: <xms:0oVGZlR43_Zl8BwSGmJCmQgxJdFWirwYqHXzPfHpgx2eYG4tGca4VA>
 <xme:0oVGZuzPp_BvpqlwMsHCpdCNBYWEEcWux84HhySpG9aJ_RUzeDEZKon_S3RWNTBN6
 r-i4Ug-Xd3WJsBS1xA>
X-ME-Received: <xmr:0oVGZq3nMYkEOuE4raGw0emkjCf591Vln7Qj-sS7UP0R-eIB_eyJ494>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehvddgtdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
 cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
 gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
 cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
 veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
 hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:0oVGZtB-xB41e-07jt1AP_jEUZ_UZNwuXZTZTLKAe173lDTc9QOCOA>
 <xmx:0oVGZuiinCebBWoH1ifJk0MCU9R7er6H9U2bp3X0Nm1tH6oGhj720Q>
 <xmx:0oVGZhpp1HYse4Ism6LpTmh6uQCqRhjzXd8ixhyq2IAnTHSpdsgRVQ>
 <xmx:0oVGZpitc1HYG5tD2x8sFIkxKDUJsMNoMqLo0G89dAtabNRl5zkH2Q>
 <xmx:0oVGZpPzNuyyZKZyZBeylDMC7i9r3UgOLhOS6ahSyZlIxQ12bcyni1GP>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 18:16:49 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Date: Thu, 16 May 2024 23:16:45 +0100
Subject: [PATCH 5/6] video: sandbox_sdl: Implement more pixel formats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240516-rework-video-format-v1-5-f69822b742a3@flygoat.com>
References: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
In-Reply-To: <20240516-rework-video-format-v1-0-f69822b742a3@flygoat.com>
To: u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Heiko Schocher <hs@denx.de>, 
 Marcel Ziswiler <marcel.ziswiler@toradex.com>, 
 Anatolij Gustschin <agust@denx.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=12049;
 i=jiaxun.yang@flygoat.com; h=from:subject:message-id;
 bh=l39ZOItc7oFrTAeegqkKKERMnmrQXcphoW8P6qKV080=;
 b=owGbwMvMwCHmXMhTe71c8zDjabUkhjS31tNvfWpM9x3eVSp87fj+AGWhVd/sT5rb3jS6av4ks
 NlOtz+to5SFQYyDQVZMkSVEQKlvQ+PFBdcfZP2BmcPKBDKEgYtTACby5w0jw9tnrP909ipMiP1Z
 nDxZVUKgNVJu8scc7rlfV7b++LT/rTDDf0/fcK7ptjPqqs7KbbZbbxXkxLz9c/GOnNDNuhrm17W
 iuQA=
X-Developer-Key: i=jiaxun.yang@flygoat.com; a=openpgp;
 fpr=980379BEFEBFBF477EA04EF9C111949073FC0F67
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

Support most of possible pixel formats so we can test them
in sandbox.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/sandbox/cpu/sdl.c         | 58 +++++++++++++++++++++++++++++++++++++-----
 arch/sandbox/include/asm/sdl.h | 17 ++++++++-----
 drivers/video/sandbox_sdl.c    | 16 +++++++-----
 include/dm/test.h              |  2 ++
 test/dm/video.c                | 14 +++++-----
 5 files changed, 81 insertions(+), 26 deletions(-)

diff --git a/arch/sandbox/cpu/sdl.c b/arch/sandbox/cpu/sdl.c
index ed84646bdab7..436c0448de1f 100644
--- a/arch/sandbox/cpu/sdl.c
+++ b/arch/sandbox/cpu/sdl.c
@@ -5,8 +5,10 @@
 
 #include <errno.h>
 #include <unistd.h>
+#include <stdint.h>
 #include <stdbool.h>
 #include <sysreset.h>
+#include <video_format.h>
 #include <linux/input.h>
 #include <SDL2/SDL.h>
 #include <asm/state.h>
@@ -69,6 +71,47 @@ static struct sdl_info {
 	int src_depth;
 } sdl;
 
+static inline SDL_PixelFormatEnum sandbox_video_format(int l2bbp, int format)
+{
+	switch (l2bbp) {
+	case VIDEO_BPP8:
+		switch (format) {
+		case VIDEO_DEFAULT:
+		case VIDEO_RGB332:
+			return SDL_PIXELFORMAT_RGB332;
+		}
+	case VIDEO_BPP16:
+		switch (format) {
+		case VIDEO_DEFAULT:
+		case VIDEO_RGB565:
+			return SDL_PIXELFORMAT_RGB565;
+		default:
+			break;
+		}
+		break;
+	case VIDEO_BPP32:
+		switch (format) {
+		case VIDEO_DEFAULT:
+		case VIDEO_XRGB8888:
+			return SDL_PIXELFORMAT_RGB888;
+		case VIDEO_BGRX8888:
+			return SDL_PIXELFORMAT_BGRX8888;
+		case VIDEO_XBGR8888:
+			return SDL_PIXELFORMAT_BGR888;
+		case VIDEO_RGBA8888:
+			return SDL_PIXELFORMAT_RGBA8888;
+		case VIDEO_XRGB2101010:
+			return SDL_PIXELFORMAT_ARGB2101010;
+		default:
+			break;
+		}
+	default:
+		break;
+	}
+
+	return SDL_PIXELFORMAT_UNKNOWN;
+}
+
 static void sandbox_sdl_poll_events(void)
 {
 	/*
@@ -122,9 +165,10 @@ int sandbox_sdl_remove_display(void)
 }
 
 int sandbox_sdl_init_display(int width, int height, int log2_bpp,
-			     bool double_size)
+			     int format, bool double_size)
 {
 	struct sandbox_state *state = state_get_current();
+	SDL_PixelFormatEnum sdl_format;
 	int err;
 
 	if (!width || !state->show_lcd)
@@ -135,6 +179,12 @@ int sandbox_sdl_init_display(int width, int height, int log2_bpp,
 	if (sdl.renderer)
 		sandbox_sdl_remove_display();
 
+	sdl_format = sandbox_video_format(log2_bpp, format);
+	if (sdl_format == SDL_PIXELFORMAT_UNKNOWN) {
+		printf("Unsupported video format\n");
+		return -EINVAL;
+	}
+
 	if (SDL_InitSubSystem(SDL_INIT_VIDEO) < 0) {
 		printf("Unable to initialise SDL LCD: %s\n", SDL_GetError());
 		return -EPERM;
@@ -153,8 +203,6 @@ int sandbox_sdl_init_display(int width, int height, int log2_bpp,
 		printf("Unable to init hinting: %s", SDL_GetError());
 
 	sdl.src_depth = 1 << log2_bpp;
-	if (log2_bpp != 4 && log2_bpp != 5)
-		log2_bpp = 5;
 	sdl.depth = 1 << log2_bpp;
 	sdl.pitch = sdl.width * sdl.depth / 8;
 	sdl.screen = SDL_CreateWindow("U-Boot", SDL_WINDOWPOS_UNDEFINED,
@@ -174,9 +222,7 @@ int sandbox_sdl_init_display(int width, int height, int log2_bpp,
 		return -EIO;
 	}
 
-	sdl.texture = SDL_CreateTexture(sdl.renderer, log2_bpp == 4 ?
-					SDL_PIXELFORMAT_RGB565 :
-					SDL_PIXELFORMAT_RGB888,
+	sdl.texture = SDL_CreateTexture(sdl.renderer, sdl_format,
 					SDL_TEXTUREACCESS_STREAMING,
 					width, height);
 	if (!sdl.texture) {
diff --git a/arch/sandbox/include/asm/sdl.h b/arch/sandbox/include/asm/sdl.h
index ee4991f7c24a..7b4f26f994da 100644
--- a/arch/sandbox/include/asm/sdl.h
+++ b/arch/sandbox/include/asm/sdl.h
@@ -24,7 +24,7 @@
  *		and -EPERM if the video failed to come up.
  */
 int sandbox_sdl_init_display(int width, int height, int log2_bpp,
-			     bool double_size);
+			     int format, bool double_size);
 
 /**
  * sandbox_sdl_remove_display() - Remove the SDL screen
@@ -89,12 +89,13 @@ int sandbox_sdl_sound_stop(void);
 int sandbox_sdl_sound_init(int rate, int channels);
 
 /**
- * sandbox_sdl_set_bpp() - Set the depth of the sandbox display
+ * sandbox_sdl_set_pixel() - Set depth and format of the sandbox display
  *
  * The device must not be active when this function is called. It activiates it
  * before returning.
  *
- * This updates the depth value and adjusts a few other settings accordingly.
+ * This updates the depth value and pixel format for the sandbox display, then
+ * it adjusts a few other settings accordingly.
  * It must be called before the display is probed.
  *
  * @dev: Device to adjust
@@ -102,11 +103,12 @@ int sandbox_sdl_sound_init(int rate, int channels);
  * Return: 0 if the device was already active, other error if it fails to probe
  * after the change
  */
-int sandbox_sdl_set_bpp(struct udevice *dev, enum video_log2_bpp l2bpp);
+int sandbox_sdl_set_pixel(struct udevice *dev, enum video_log2_bpp l2bpp,
+			  enum video_format format);
 
 #else
 static inline int sandbox_sdl_init_display(int width, int height, int log2_bpp,
-					   bool double_size)
+					   int format, bool double_size)
 {
 	return -ENODEV;
 }
@@ -151,8 +153,9 @@ static inline int sandbox_sdl_sound_init(int rate, int channels)
 	return -ENODEV;
 }
 
-static inline int sandbox_sdl_set_bpp(struct udevice *dev,
-				      enum video_log2_bpp l2bpp)
+static inline int sandbox_sdl_set_pixel(struct udevice *dev,
+					enum video_log2_bpp l2bpp,
+					enum video_format format)
 {
 	return -ENOSYS;
 }
diff --git a/drivers/video/sandbox_sdl.c b/drivers/video/sandbox_sdl.c
index 69dfa9302735..ddd72a14de83 100644
--- a/drivers/video/sandbox_sdl.c
+++ b/drivers/video/sandbox_sdl.c
@@ -31,7 +31,7 @@ static int sandbox_sdl_probe(struct udevice *dev)
 	int ret;
 
 	ret = sandbox_sdl_init_display(plat->xres, plat->yres, plat->bpix,
-				       state->double_lcd);
+				       plat->format, state->double_lcd);
 	if (ret) {
 		puts("LCD init failed\n");
 		return ret;
@@ -39,6 +39,7 @@ static int sandbox_sdl_probe(struct udevice *dev)
 	uc_priv->xsize = plat->xres;
 	uc_priv->ysize = plat->yres;
 	uc_priv->bpix = plat->bpix;
+	uc_priv->format = plat->format;
 	uc_priv->rot = plat->rot;
 	uc_priv->vidconsole_drv_name = plat->vidconsole_drv_name;
 	uc_priv->font_size = plat->font_size;
@@ -48,12 +49,14 @@ static int sandbox_sdl_probe(struct udevice *dev)
 	return 0;
 }
 
-static void set_bpp(struct udevice *dev, enum video_log2_bpp l2bpp)
+static void set_pixel(struct udevice *dev, enum video_log2_bpp l2bpp,
+		      enum video_format format)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	struct sandbox_sdl_plat *plat = dev_get_plat(dev);
 
 	plat->bpix = l2bpp;
+	plat->format = format;
 
 	uc_plat->size = plat->xres * plat->yres * VNBYTES(plat->bpix);
 
@@ -61,7 +64,7 @@ static void set_bpp(struct udevice *dev, enum video_log2_bpp l2bpp)
 	 * Set up to the maximum size we'll ever need. This is a strange case.
 	 * The video memory is allocated by video_post_bind() called from
 	 * board_init_r(). If a test changes the reoslution so it needs more
-	 * memory later (with sandbox_sdl_set_bpp()), it is too late to make
+	 * memory later (with sandbox_sdl_set_pixel()), it is too late to make
 	 * the frame buffer larger.
 	 *
 	 * So use a maximum size here.
@@ -79,7 +82,8 @@ static void set_bpp(struct udevice *dev, enum video_log2_bpp l2bpp)
 		uc_plat->size *= 2;
 }
 
-int sandbox_sdl_set_bpp(struct udevice *dev, enum video_log2_bpp l2bpp)
+int sandbox_sdl_set_pixel(struct udevice *dev, enum video_log2_bpp l2bpp,
+			  enum video_format format)
 {
 	struct video_uc_plat *uc_plat = dev_get_uclass_plat(dev);
 	int ret;
@@ -89,7 +93,7 @@ int sandbox_sdl_set_bpp(struct udevice *dev, enum video_log2_bpp l2bpp)
 	sandbox_sdl_remove_display();
 
 	uc_plat->hide_logo = true;
-	set_bpp(dev, l2bpp);
+	set_pixel(dev, l2bpp, format);
 
 	ret = device_probe(dev);
 	if (ret)
@@ -122,7 +126,7 @@ static int sandbox_sdl_bind(struct udevice *dev)
 	l2bpp = dev_read_u32_default(dev, "log2-depth", VIDEO_BPP16);
 	plat->rot = dev_read_u32_default(dev, "rotate", 0);
 
-	set_bpp(dev, l2bpp);
+	set_pixel(dev, l2bpp, VIDEO_DEFAULT);
 
 	return ret;
 }
diff --git a/include/dm/test.h b/include/dm/test.h
index 02737411a164..87568d741d49 100644
--- a/include/dm/test.h
+++ b/include/dm/test.h
@@ -153,6 +153,7 @@ extern struct unit_test_state global_dm_test_state;
  * @xres: Width of display in pixels
  * @yres: Height of display in pixels
  * @bpix: Log2 of bits per pixel (enum video_log2_bpp)
+ * @format: Pixel format (enum video_format)
  * @rot: Console rotation (0=normal orientation, 1=90 degrees clockwise,
  *	2=upside down, 3=90 degree counterclockwise)
  * @vidconsole_drv_name: Name of video console driver (set by tests)
@@ -162,6 +163,7 @@ struct sandbox_sdl_plat {
 	int xres;
 	int yres;
 	int bpix;
+	int format;
 	int rot;
 	const char *vidconsole_drv_name;
 	int font_size;
diff --git a/test/dm/video.c b/test/dm/video.c
index 0da96aec5efd..47a8df511e8b 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -395,7 +395,7 @@ static int dm_test_video_bmp8(struct unit_test_state *uts)
 
 	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
 	ut_assertnonnull(dev);
-	ut_assertok(sandbox_sdl_set_bpp(dev, VIDEO_BPP8));
+	ut_assertok(sandbox_sdl_set_pixel(dev, VIDEO_BPP8, VIDEO_DEFAULT));
 
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
@@ -416,7 +416,7 @@ static int dm_test_video_bmp16(struct unit_test_state *uts)
 
 	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
 	ut_assertnonnull(dev);
-	ut_assertok(sandbox_sdl_set_bpp(dev, VIDEO_BPP16));
+	ut_assertok(sandbox_sdl_set_pixel(dev, VIDEO_BPP16, VIDEO_DEFAULT));
 
 	ut_assertok(read_file(uts, "tools/logos/denx-16bpp.bmp.gz", &src));
 	ut_assertok(gunzip(map_sysmem(dst, 0), dst_len, map_sysmem(src, 0),
@@ -439,7 +439,7 @@ static int dm_test_video_bmp24(struct unit_test_state *uts)
 
 	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
 	ut_assertnonnull(dev);
-	ut_assertok(sandbox_sdl_set_bpp(dev, VIDEO_BPP16));
+	ut_assertok(sandbox_sdl_set_pixel(dev, VIDEO_BPP16, VIDEO_DEFAULT));
 
 	ut_assertok(read_file(uts, "tools/logos/denx-24bpp.bmp.gz", &src));
 	ut_assertok(gunzip(map_sysmem(dst, 0), dst_len, map_sysmem(src, 0),
@@ -462,7 +462,7 @@ static int dm_test_video_bmp24_32(struct unit_test_state *uts)
 
 	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
 	ut_assertnonnull(dev);
-	ut_assertok(sandbox_sdl_set_bpp(dev, VIDEO_BPP32));
+	ut_assertok(sandbox_sdl_set_pixel(dev, VIDEO_BPP32, VIDEO_DEFAULT));
 
 	ut_assertok(read_file(uts, "tools/logos/denx-24bpp.bmp.gz", &src));
 	ut_assertok(gunzip(map_sysmem(dst, 0), dst_len, map_sysmem(src, 0),
@@ -483,7 +483,7 @@ static int dm_test_video_bmp32(struct unit_test_state *uts)
 
 	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
 	ut_assertnonnull(dev);
-	ut_assertok(sandbox_sdl_set_bpp(dev, VIDEO_BPP32));
+	ut_assertok(sandbox_sdl_set_pixel(dev, VIDEO_BPP32, VIDEO_DEFAULT));
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
@@ -517,7 +517,7 @@ static int dm_test_video_comp_bmp32(struct unit_test_state *uts)
 
 	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
 	ut_assertnonnull(dev);
-	ut_assertok(sandbox_sdl_set_bpp(dev, VIDEO_BPP32));
+	ut_assertok(sandbox_sdl_set_pixel(dev, VIDEO_BPP32, VIDEO_DEFAULT));
 
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
@@ -536,7 +536,7 @@ static int dm_test_video_comp_bmp8(struct unit_test_state *uts)
 
 	ut_assertok(uclass_find_first_device(UCLASS_VIDEO, &dev));
 	ut_assertnonnull(dev);
-	ut_assertok(sandbox_sdl_set_bpp(dev, VIDEO_BPP8));
+	ut_assertok(sandbox_sdl_set_pixel(dev, VIDEO_BPP8, VIDEO_DEFAULT));
 
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 

-- 
2.34.1

