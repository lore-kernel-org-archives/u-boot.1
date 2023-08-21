Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64BE2EE4996
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:51:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD34B8706B;
	Mon, 21 Aug 2023 15:51:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mYzIbw17";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EF078707C; Mon, 21 Aug 2023 15:51:30 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8B77787069
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-307d20548adso2907788f8f.0
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625887; x=1693230687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OB7382go0g6JBjezy6TmzGfi6gIlYCFDFe4xM7HRw8=;
 b=mYzIbw17s5ut2Lj8TmUyEmZZuMpoWf/YpZMisLloBGvTOI6o9/p8nP2M17yjk++h8P
 8+GH169jMY+6EuzecVUKktHLjLULhqcSGVgb+K8TH4Z0MkPhLZg6u+23TnjErs5v1VYS
 +euy4y8wSAudLGdJHtR26NtBqeJHDFiK6ves/aUe6PVWoPVDofUTUC53I4mvF96uWF8K
 NxLW9B5KIoY0T2WpxZUDwabQASQORqw1sA33K5oTD5OvFTS081ZnJT9otEq9+EgTySU5
 e9RQTRRZ1lstBqBTAQHRXPAniy7qhyu+ptlO9RhqLC6R08WOBN8Fwz7r4fVsnuuGMEgm
 CatQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625887; x=1693230687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2OB7382go0g6JBjezy6TmzGfi6gIlYCFDFe4xM7HRw8=;
 b=ChLsD8uyfsbRsBr3u3v4RBW8IRqsNDwAduakdrWkASxSDmmx1fr/AROSBC5feYGGDe
 hS2CHTTA7mzZBgx65Trp5EItwl/T+Vp9i6ot9yz9QlTUNNEcPawZEdr+wrwsTgDaxH2v
 snQjENvBTKP8nVEyAFqDmM2dOMLBHKEnI/a8MuKKZMuMu9dujekXUR7zTMOWyhTLK6Gc
 D8F+qwz8FIhnEGMc1i1LvXmjDCs7delvdWCetg6JqpaHZUQQc6Ru03gSKWXkedKTdHsF
 IFdkr4qm3W7Rsy2BwYQZN2XrZO5IuLkQjVOtfryPfMGux/37jUX8zNJ0y+TL8k42PlEC
 Xicw==
X-Gm-Message-State: AOJu0YwlYwARbrwNV25POhyWxcoym3cQztI8SjGOeCzdsQys/HqRUQV+
 wqnhOKThUMfcGC8MZ8gLFE2KT2+SxVA=
X-Google-Smtp-Source: AGHT+IHSYU3/G4dWV8P3egqgpph9YxOl4+mH1vDWUtosphrFiVQk7BNu/zdvNsUiJiU3qzGO9VCxdg==
X-Received: by 2002:a5d:44cf:0:b0:313:f33c:24c4 with SMTP id
 z15-20020a5d44cf000000b00313f33c24c4mr4457731wrr.39.1692625886757; 
 Mon, 21 Aug 2023 06:51:26 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:26 -0700 (PDT)
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
To: u-boot@lists.denx.de
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, Alexander Graf <agraf@csgraf.de>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Andrew Davis <afd@ti.com>,
 Da Xue <da@libre.computer>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Derald Woods <woods.technical@gmail.com>,
 Anatolij Gustschin <agust@denx.de>,
 uboot-stm32@st-md-mailman.stormreply.com, Simon Glass <sjg@chromium.org>,
 Matthias Brugger <mbrugger@suse.com>, u-boot-amlogic@groups.io,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: [PATCH v5 02/13] video: test: Support checking copy frame buffer
 contents
Date: Mon, 21 Aug 2023 16:50:59 +0300
Message-Id: <20230821135111.3558478-3-alpernebiyasak@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
References: <20230821135111.3558478-1-alpernebiyasak@gmail.com>
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

The video tests have a helper function to generate a pseudo-digest of
frame buffer contents, but it only does so for the main one. There is
another check that the copy frame buffer is the same as that. But
neither is enough to test if only the modified regions are copied to the
copy frame buffer, since we will want the two to be different in very
specific ways.

Add a boolean argument to the existing helper function to indicate which
frame buffer we want to inspect, and update the existing callers.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Add patch "video: test: Support checking copy frame buffer contents"

 test/dm/video.c | 76 ++++++++++++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 35 deletions(-)

diff --git a/test/dm/video.c b/test/dm/video.c
index 641a6250100a..b9ff3da10c18 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -57,22 +57,28 @@ DM_TEST(dm_test_video_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
  *
  * @uts:	Test state
  * @dev:	Video device
+ * @use_copy:	Use copy frame buffer if available
  * Return: compressed size of the frame buffer, or -ve on error
  */
 static int compress_frame_buffer(struct unit_test_state *uts,
-				 struct udevice *dev)
+				 struct udevice *dev,
+				 bool use_copy)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	uint destlen;
 	void *dest;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_VIDEO_COPY))
+		use_copy = false;
+
 	destlen = priv->fb_size;
 	dest = malloc(priv->fb_size);
 	if (!dest)
 		return -ENOMEM;
 	ret = BZ2_bzBuffToBuffCompress(dest, &destlen,
-				       priv->fb, priv->fb_size,
+				       use_copy ? priv->copy_fb : priv->fb,
+				       priv->fb_size,
 				       3, 0, 0);
 	free(dest);
 	if (ret)
@@ -168,30 +174,30 @@ static int dm_test_video_text(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_putc_xy(con, 0, 0, 'a');
-	ut_asserteq(79, compress_frame_buffer(uts, dev));
+	ut_asserteq(79, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_putc_xy(con, 0, 0, ' ');
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(273, compress_frame_buffer(uts, dev));
+	ut_asserteq(273, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_set_row(con, 0, WHITE);
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(273, compress_frame_buffer(uts, dev));
+	ut_asserteq(273, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -210,30 +216,30 @@ static int dm_test_video_text_12x22(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "12x22", 0));
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_putc_xy(con, 0, 0, 'a');
-	ut_asserteq(89, compress_frame_buffer(uts, dev));
+	ut_asserteq(89, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_putc_xy(con, 0, 0, ' ');
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(363, compress_frame_buffer(uts, dev));
+	ut_asserteq(363, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_set_row(con, 0, WHITE);
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(363, compress_frame_buffer(uts, dev));
+	ut_asserteq(363, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -251,7 +257,7 @@ static int dm_test_video_chars(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(466, compress_frame_buffer(uts, dev));
+	ut_asserteq(466, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -273,23 +279,23 @@ static int dm_test_video_ansi(struct unit_test_state *uts)
 	/* reference clear: */
 	video_clear(con->parent);
 	video_sync(con->parent, false);
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* test clear escape sequence: [2J */
 	vidconsole_put_string(con, "A\tB\tC"ANSI_ESC"[2J");
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* test set-cursor: [%d;%df */
 	vidconsole_put_string(con, "abc"ANSI_ESC"[2;2fab"ANSI_ESC"[4;4fcd");
-	ut_asserteq(143, compress_frame_buffer(uts, dev));
+	ut_asserteq(143, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* test colors (30-37 fg color, 40-47 bg color) */
 	vidconsole_put_string(con, ANSI_ESC"[30;41mfoo"); /* black on red */
 	vidconsole_put_string(con, ANSI_ESC"[33;44mbar"); /* yellow on blue */
-	ut_asserteq(272, compress_frame_buffer(uts, dev));
+	ut_asserteq(272, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -322,13 +328,13 @@ static int check_vidconsole_output(struct unit_test_state *uts, int rot,
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* Check display wrap */
 	for (i = 0; i < 120; i++)
 		vidconsole_put_char(con, 'A' + i % 50);
-	ut_asserteq(wrap_size, compress_frame_buffer(uts, dev));
+	ut_asserteq(wrap_size, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* Check display scrolling */
@@ -336,13 +342,13 @@ static int check_vidconsole_output(struct unit_test_state *uts, int rot,
 		vidconsole_put_char(con, 'A' + i % 50);
 		vidconsole_put_char(con, '\n');
 	}
-	ut_asserteq(scroll_size, compress_frame_buffer(uts, dev));
+	ut_asserteq(scroll_size, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* If we scroll enough, the screen becomes blank again */
 	for (i = 0; i < SCROLL_LINES; i++)
 		vidconsole_put_char(con, '\n');
-	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -417,7 +423,7 @@ static int dm_test_video_bmp(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1368, compress_frame_buffer(uts, dev));
+	ut_asserteq(1368, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -437,7 +443,7 @@ static int dm_test_video_bmp8(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1247, compress_frame_buffer(uts, dev));
+	ut_asserteq(1247, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -461,7 +467,7 @@ static int dm_test_video_bmp16(struct unit_test_state *uts)
 			   &src_len));
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
-	ut_asserteq(3700, compress_frame_buffer(uts, dev));
+	ut_asserteq(3700, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -485,7 +491,7 @@ static int dm_test_video_bmp24(struct unit_test_state *uts)
 			   &src_len));
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
-	ut_asserteq(3656, compress_frame_buffer(uts, dev));
+	ut_asserteq(3656, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -509,7 +515,7 @@ static int dm_test_video_bmp24_32(struct unit_test_state *uts)
 			   &src_len));
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
-	ut_asserteq(6827, compress_frame_buffer(uts, dev));
+	ut_asserteq(6827, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -528,7 +534,7 @@ static int dm_test_video_bmp32(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(2024, compress_frame_buffer(uts, dev));
+	ut_asserteq(2024, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -545,7 +551,7 @@ static int dm_test_video_bmp_comp(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx-comp.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1368, compress_frame_buffer(uts, dev));
+	ut_asserteq(1368, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -565,7 +571,7 @@ static int dm_test_video_comp_bmp32(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(2024, compress_frame_buffer(uts, dev));
+	ut_asserteq(2024, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -585,7 +591,7 @@ static int dm_test_video_comp_bmp8(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1247, compress_frame_buffer(uts, dev));
+	ut_asserteq(1247, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -601,7 +607,7 @@ static int dm_test_video_truetype(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(12174, compress_frame_buffer(uts, dev));
+	ut_asserteq(12174, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -623,7 +629,7 @@ static int dm_test_video_truetype_scroll(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(34287, compress_frame_buffer(uts, dev));
+	ut_asserteq(34287, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
@@ -645,7 +651,7 @@ static int dm_test_video_truetype_bs(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(29471, compress_frame_buffer(uts, dev));
+	ut_asserteq(29471, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
-- 
2.40.1

