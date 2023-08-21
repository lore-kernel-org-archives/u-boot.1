Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096F6EE49AA
	for <u-boot@archiver.kernel.org>; Mon, 21 Aug 2023 13:51:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F2487066;
	Mon, 21 Aug 2023 15:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jAFdt8C3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71CEC8706D; Mon, 21 Aug 2023 15:51:28 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3320B87062
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 15:51:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alpernebiyasak@gmail.com
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fef56f7222so2727775e9.2
 for <u-boot@lists.denx.de>; Mon, 21 Aug 2023 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692625884; x=1693230684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0KM0F1+WkNhDdn0zbbXHFFjqAdCr64hX7QvIzy6/iyI=;
 b=jAFdt8C3owZgLvkS3GxcS5N+GiTxn30Z/xJkqzPDEYfC0PDH1kIsDI4pb6eHKAFVBt
 PLqr4R9Sdmb05o76fez0U9nTmmv97QjcaeHGc0adZliwf33YdMgotCTaUiHc/nhkpLWw
 c8rHP6jWgFPGn5Y45QEtPjQFEuV0nP0SkMONJorI+ci6NUadDN8X0tZNK5GoF1lvhF4o
 mQZs5xJfJ6evaIBX7srcue8NUq4BtyhQ18vVYm0nCIPEltA23PBpkcejhCv6g5o/4puI
 sgF/+jj8BhBQFKhPEIktVLWcqveScR/ngqiv1iDRHrCL6flPhtCsrpShY+rzilzpJdtC
 fkJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692625884; x=1693230684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0KM0F1+WkNhDdn0zbbXHFFjqAdCr64hX7QvIzy6/iyI=;
 b=gWHm6TE1o6bFZMTHoyWCi4QgdvFQkn06zRip9uOn3HqDzCG7KLnrXsFUdYdugOcadS
 yQH0TYQ9YCGnJEItFC8+BAPuij69++YczOI2dzUQz6ejqfjFnTORccJmFginC+ZQynSw
 ygcqWBt7iXKWwm2BNaTOS0ZbXxZuQrdebM6QD55CSsB+YnJ/21Q4txo4VOIzT+g2LmU4
 YhR1Ec8+2HGk3w1oWalKPpGcBc3y3y7ADgy/Kt0L4pFhAmBewW+wlGtrTxdoIbRmcMwx
 6xx1bS9ZrdHzFpTAB7myHjowwbIvRmhpNDr1e+ROx71myEhCEhnz0o6tjGmHTmebIiZB
 Axiw==
X-Gm-Message-State: AOJu0Yw7o7394U5eAr5ipSyfIWmc1YVzBHdp8jslW0qPlsoIXMjiuI6c
 SaZaVpf+ZihLZ51797OE439hQFEZL4o=
X-Google-Smtp-Source: AGHT+IGiiJu3kdw60kWynu1HizRmCX0l3/hesikD0kGHzt9jbq6D24m4A0InLSpbaBLDcUVjniBVKA==
X-Received: by 2002:a05:600c:3799:b0:3fe:2011:a7ce with SMTP id
 o25-20020a05600c379900b003fe2011a7cemr5345546wmr.6.1692625884228; 
 Mon, 21 Aug 2023 06:51:24 -0700 (PDT)
Received: from ALPER-PC.. ([178.233.24.1]) by smtp.gmail.com with ESMTPSA id
 r11-20020a5d4e4b000000b00317b063590fsm12600049wrt.55.2023.08.21.06.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Aug 2023 06:51:23 -0700 (PDT)
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
Subject: [PATCH v5 01/13] video: test: Split copy frame buffer check into a
 function
Date: Mon, 21 Aug 2023 16:50:58 +0300
Message-Id: <20230821135111.3558478-2-alpernebiyasak@gmail.com>
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

While checking frame buffer contents, the video tests also check if the
copy frame buffer contents match the main frame buffer. To test if only
the modified regions are updated after a sync, we will need to create
situations where the two are mismatched. Split this check into another
function that we can skip calling, since we won't want it to error on
those mismatched cases.

Signed-off-by: Alper Nebi Yasak <alpernebiyasak@gmail.com>
---

Changes in v5:
- Add patch "video: test: Split copy frame buffer check into a function"

 test/dm/video.c | 69 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 58 insertions(+), 11 deletions(-)

diff --git a/test/dm/video.c b/test/dm/video.c
index d907f681600b..641a6250100a 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -55,9 +55,6 @@ DM_TEST(dm_test_video_base, UT_TESTF_SCAN_PDATA | UT_TESTF_SCAN_FDT);
  * size of the compressed data. This provides a pretty good level of
  * certainty and the resulting tests need only check a single value.
  *
- * If the copy framebuffer is enabled, this compares it to the main framebuffer
- * too.
- *
  * @uts:	Test state
  * @dev:	Video device
  * Return: compressed size of the frame buffer, or -ve on error
@@ -66,7 +63,6 @@ static int compress_frame_buffer(struct unit_test_state *uts,
 				 struct udevice *dev)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
-	struct video_priv *uc_priv = dev_get_uclass_priv(dev);
 	uint destlen;
 	void *dest;
 	int ret;
@@ -82,16 +78,34 @@ static int compress_frame_buffer(struct unit_test_state *uts,
 	if (ret)
 		return ret;
 
-	/* Check here that the copy frame buffer is working correctly */
-	if (IS_ENABLED(CONFIG_VIDEO_COPY)) {
-		ut_assertf(!memcmp(uc_priv->fb, uc_priv->copy_fb,
-				   uc_priv->fb_size),
-				   "Copy framebuffer does not match fb");
-	}
-
 	return destlen;
 }
 
+/**
+ * check_copy_frame_buffer() - Compare main frame buffer to copy
+ *
+ * If the copy frame buffer is enabled, this compares it to the main
+ * frame buffer. Normally they should have the same contents after a
+ * sync.
+ *
+ * @uts:	Test state
+ * @dev:	Video device
+ * Return: 0, or -ve on error
+ */
+static int check_copy_frame_buffer(struct unit_test_state *uts,
+				   struct udevice *dev)
+{
+	struct video_priv *priv = dev_get_uclass_priv(dev);
+
+	if (!IS_ENABLED(CONFIG_VIDEO_COPY))
+		return 0;
+
+	ut_assertf(!memcmp(priv->fb, priv->copy_fb, priv->fb_size),
+		   "Copy framebuffer does not match fb");
+
+	return 0;
+}
+
 /*
  * Call this function at any point to halt and show the current display. Be
  * sure to run the test with the -l flag.
@@ -155,24 +169,30 @@ static int dm_test_video_text(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_putc_xy(con, 0, 0, 'a');
 	ut_asserteq(79, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_putc_xy(con, 0, 0, ' ');
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
 	ut_asserteq(273, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_set_row(con, 0, WHITE);
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
 	ut_asserteq(273, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -191,24 +211,30 @@ static int dm_test_video_text_12x22(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "12x22", 0));
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_putc_xy(con, 0, 0, 'a');
 	ut_asserteq(89, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_putc_xy(con, 0, 0, ' ');
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
 	ut_asserteq(363, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	vidconsole_set_row(con, 0, WHITE);
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
 	ut_asserteq(363, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -226,6 +252,7 @@ static int dm_test_video_chars(struct unit_test_state *uts)
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
 	vidconsole_put_string(con, test_string);
 	ut_asserteq(466, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -247,19 +274,23 @@ static int dm_test_video_ansi(struct unit_test_state *uts)
 	video_clear(con->parent);
 	video_sync(con->parent, false);
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* test clear escape sequence: [2J */
 	vidconsole_put_string(con, "A\tB\tC"ANSI_ESC"[2J");
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* test set-cursor: [%d;%df */
 	vidconsole_put_string(con, "abc"ANSI_ESC"[2;2fab"ANSI_ESC"[4;4fcd");
 	ut_asserteq(143, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* test colors (30-37 fg color, 40-47 bg color) */
 	vidconsole_put_string(con, ANSI_ESC"[30;41mfoo"); /* black on red */
 	vidconsole_put_string(con, ANSI_ESC"[33;44mbar"); /* yellow on blue */
 	ut_asserteq(272, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -292,11 +323,13 @@ static int check_vidconsole_output(struct unit_test_state *uts, int rot,
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* Check display wrap */
 	for (i = 0; i < 120; i++)
 		vidconsole_put_char(con, 'A' + i % 50);
 	ut_asserteq(wrap_size, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* Check display scrolling */
 	for (i = 0; i < SCROLL_LINES; i++) {
@@ -304,11 +337,13 @@ static int check_vidconsole_output(struct unit_test_state *uts, int rot,
 		vidconsole_put_char(con, '\n');
 	}
 	ut_asserteq(scroll_size, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	/* If we scroll enough, the screen becomes blank again */
 	for (i = 0; i < SCROLL_LINES; i++)
 		vidconsole_put_char(con, '\n');
 	ut_asserteq(46, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -383,6 +418,7 @@ static int dm_test_video_bmp(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
 	ut_asserteq(1368, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -402,6 +438,7 @@ static int dm_test_video_bmp8(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
 	ut_asserteq(1247, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -425,6 +462,7 @@ static int dm_test_video_bmp16(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
 	ut_asserteq(3700, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -448,6 +486,7 @@ static int dm_test_video_bmp24(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
 	ut_asserteq(3656, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -471,6 +510,7 @@ static int dm_test_video_bmp24_32(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
 	ut_asserteq(6827, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -489,6 +529,7 @@ static int dm_test_video_bmp32(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
 	ut_asserteq(2024, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -505,6 +546,7 @@ static int dm_test_video_bmp_comp(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
 	ut_asserteq(1368, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -524,6 +566,7 @@ static int dm_test_video_comp_bmp32(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
 	ut_asserteq(2024, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -543,6 +586,7 @@ static int dm_test_video_comp_bmp8(struct unit_test_state *uts)
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
 	ut_asserteq(1247, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -558,6 +602,7 @@ static int dm_test_video_truetype(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
 	ut_asserteq(12174, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -579,6 +624,7 @@ static int dm_test_video_truetype_scroll(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
 	ut_asserteq(34287, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
@@ -600,6 +646,7 @@ static int dm_test_video_truetype_bs(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
 	ut_asserteq(29471, compress_frame_buffer(uts, dev));
+	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
 }
-- 
2.40.1

