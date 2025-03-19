Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5088FC35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D0B6B82074;
	Wed, 19 Mar 2025 15:55:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JxChhr/F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE3B382040; Wed, 19 Mar 2025 15:55:50 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BC6A81FE8
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43cf680d351so5360065e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396147; x=1743000947; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f1EIZ7VajOX0Js6kQ9BKL9QB/abmHK+ya3DbrRbz+9I=;
 b=JxChhr/FXLeq2Wa0PKwR6c+dXnnk2116TdXy1mp0duUGCU8X8Svud47hrX5yX6DMo3
 0gwINNcLJaXVjeqTuEx2T9cGpTmS77vA6tBTQwK9MQeVIO1NzHiBRjq/R6KLZFF/8KFA
 A8VVz8CQHjJQx/0vNJtv5XTcBFiYJYQUP9DsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396147; x=1743000947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f1EIZ7VajOX0Js6kQ9BKL9QB/abmHK+ya3DbrRbz+9I=;
 b=e9sZtqGvCDdXgNaji8du1RKVRd0c4z6dJhpM5O9TUlZqhBvZugEUHMUSGArAw6RjTQ
 U1WMogeLlFvvl22W0mDOndJYJxveZgnWhwBxVnSrEl7+0txsqW6qEWbGq40TW9PvxnU4
 CutNm1fPmoQw8FnlVynw1bPsB+oD96iGDWH71Jv6BIG1EIHCAEl9TZ2mrzZ2BbA1N3Qa
 2gpZO433/LV3mZ99q2GdoL0fRUsLJsb5SlXXxiwaMeeBms5AICukE407oStviJEOagml
 60Aj1WeUXK9cuWh7Jy4rJV/kLStYu3iFxtRadp9lALxIsoVt8pQi4bVNRBzYK7c0+17H
 UnlQ==
X-Gm-Message-State: AOJu0YzEFVqFKThGfBKAA7zEZUztv374PDF/i2IiHFzNfnNmvdpxKDOS
 uWGucVsoBhUepwM+4bfZRYEAwEXAdOi1n/oIVLW1AmGGDqJDaoQuZdb6+IVSbUK4NTqjphbLdoY
 =
X-Gm-Gg: ASbGncsxVXnpD2tCIDtf8JSxBjw73//2zb0tHUZ0y5vOhTtX8vwevldHOZBzirIbSQs
 ajrKoKIdN8/J611ztsySii/zkpjRM8DkK8YKQIIYrHFc8fDs08RZaewWmLqp5Mp3nrxTQnn4EqQ
 kfEsbWebZ/1CJ8gxqyMzVRWyvm7qJ1P8pnXoHOzrHX9legUdMOI6Vcbvv1xtD12N0yGAmwTYLJX
 z1AA8pFXSlhdmMjyjXgIeCB8zk1irGVN6r7+t1508kmkP9O2jlIJvHvarq1GrF7vWIFD3J+DPn7
 17KA0KUY834RcN773YKdDFQWzbU5Ut89CriEy1IIDQ==
X-Google-Smtp-Source: AGHT+IG1S9bvOIJae6m7qQQ58ncmrAxA7qjO7gm4LsVwVteIYW2XdXghsxpLMfQ7aHoEHwb46mZgeg==
X-Received: by 2002:a05:6000:1868:b0:38d:e0a9:7e5e with SMTP id
 ffacd0b85a97d-3996ba46a9bmr6024131f8f.6.1742396147123; 
 Wed, 19 Mar 2025 07:55:47 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:46 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 10/52] test: video: Export the video-checking functions
Date: Wed, 19 Mar 2025 15:54:15 +0100
Message-ID: <20250319145512.2391122-11-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250319145512.2391122-1-sjg@chromium.org>
References: <20250319145512.2391122-1-sjg@chromium.org>
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

We want to check the display contents in expo tests, so move the two
needed functions to a new header file.

Rename them to have a video_ prefix.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 include/test/video.h |  45 +++++++++++
 test/dm/video.c      | 179 ++++++++++++++++++-------------------------
 2 files changed, 121 insertions(+), 103 deletions(-)
 create mode 100644 include/test/video.h

diff --git a/include/test/video.h b/include/test/video.h
new file mode 100644
index 00000000000..000fd708c86
--- /dev/null
+++ b/include/test/video.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2013 Google, Inc.
+ */
+
+#ifndef __TEST_VIDEO_H
+#define __TEST_VIDEO_H
+
+#include <stdbool.h>
+
+struct udevice;
+struct unit_test_state;
+
+/**
+ * video_compress_fb() - Compress the frame buffer and return its size
+ *
+ * We want to write tests which perform operations on the video console and
+ * check that the frame buffer ends up with the correct contents. But it is
+ * painful to store 'known good' images for comparison with the frame
+ * buffer. As an alternative, we can compress the frame buffer and check the
+ * size of the compressed data. This provides a pretty good level of
+ * certainty and the resulting tests need only check a single value.
+ *
+ * @uts:	Test state
+ * @dev:	Video device
+ * @use_copy:	Use copy frame buffer if available
+ * Return: compressed size of the frame buffer, or -ve on error
+ */
+int video_compress_fb(struct unit_test_state *uts, struct udevice *dev,
+		      bool use_copy);
+
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
+int video_check_copy_fb(struct unit_test_state *uts, struct udevice *dev);
+
+#endif
diff --git a/test/dm/video.c b/test/dm/video.c
index a9b2482631f..737ab915f41 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -19,6 +19,7 @@
 #include <dm/uclass-internal.h>
 #include <test/test.h>
 #include <test/ut.h>
+#include <test/video.h>
 
 /*
  * These tests use the standard sandbox frame buffer, the resolution of which
@@ -44,24 +45,8 @@ static int dm_test_video_base(struct unit_test_state *uts)
 }
 DM_TEST(dm_test_video_base, UTF_SCAN_PDATA | UTF_SCAN_FDT);
 
-/**
- * compress_frame_buffer() - Compress the frame buffer and return its size
- *
- * We want to write tests which perform operations on the video console and
- * check that the frame buffer ends up with the correct contents. But it is
- * painful to store 'known good' images for comparison with the frame
- * buffer. As an alternative, we can compress the frame buffer and check the
- * size of the compressed data. This provides a pretty good level of
- * certainty and the resulting tests need only check a single value.
- *
- * @uts:	Test state
- * @dev:	Video device
- * @use_copy:	Use copy frame buffer if available
- * Return: compressed size of the frame buffer, or -ve on error
- */
-static int compress_frame_buffer(struct unit_test_state *uts,
-				 struct udevice *dev,
-				 bool use_copy)
+int video_compress_fb(struct unit_test_state *uts, struct udevice *dev,
+		      bool use_copy)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 	uint destlen;
@@ -86,19 +71,7 @@ static int compress_frame_buffer(struct unit_test_state *uts,
 	return destlen;
 }
 
-/**
- * check_copy_frame_buffer() - Compare main frame buffer to copy
- *
- * If the copy frame buffer is enabled, this compares it to the main
- * frame buffer. Normally they should have the same contents after a
- * sync.
- *
- * @uts:	Test state
- * @dev:	Video device
- * Return: 0, or -ve on error
- */
-static int check_copy_frame_buffer(struct unit_test_state *uts,
-				   struct udevice *dev)
+int video_check_copy_fb(struct unit_test_state *uts, struct udevice *dev)
 {
 	struct video_priv *priv = dev_get_uclass_priv(dev);
 
@@ -174,31 +147,31 @@ static int dm_test_video_text(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_putc_xy(con, 0, 0, 'a');
-	ut_asserteq(79, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(79, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	vidconsole_putc_xy(con, 0, 0, ' ');
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(273, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(273, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	vidconsole_set_row(con, 0, WHITE);
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(273, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(273, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -216,31 +189,31 @@ static int dm_test_video_text_12x22(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "12x22", 0));
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_putc_xy(con, 0, 0, 'a');
-	ut_asserteq(89, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(89, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	vidconsole_putc_xy(con, 0, 0, ' ');
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(363, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(363, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	vidconsole_set_row(con, 0, WHITE);
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	for (i = 0; i < 20; i++)
 		vidconsole_putc_xy(con, VID_TO_POS(i * 8), 0, ' ' + i);
-	ut_asserteq(363, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(363, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -257,8 +230,8 @@ static int dm_test_video_chars(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(466, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(466, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -279,24 +252,24 @@ static int dm_test_video_ansi(struct unit_test_state *uts)
 	/* reference clear: */
 	video_clear(con->parent);
 	video_sync(con->parent, false);
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* test clear escape sequence: [2J */
 	vidconsole_put_string(con, "A\tB\tC"ANSI_ESC"[2J");
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* test set-cursor: [%d;%df */
 	vidconsole_put_string(con, "abc"ANSI_ESC"[2;2fab"ANSI_ESC"[4;4fcd");
-	ut_asserteq(143, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(143, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* test colors (30-37 fg color, 40-47 bg color) */
 	vidconsole_put_string(con, ANSI_ESC"[30;41mfoo"); /* black on red */
 	vidconsole_put_string(con, ANSI_ESC"[33;44mbar"); /* yellow on blue */
-	ut_asserteq(272, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(272, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -328,28 +301,28 @@ static int check_vidconsole_output(struct unit_test_state *uts, int rot,
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	ut_assertok(vidconsole_select_font(con, "8x16", 0));
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* Check display wrap */
 	for (i = 0; i < 120; i++)
 		vidconsole_put_char(con, 'A' + i % 50);
-	ut_asserteq(wrap_size, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(wrap_size, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* Check display scrolling */
 	for (i = 0; i < SCROLL_LINES; i++) {
 		vidconsole_put_char(con, 'A' + i % 50);
 		vidconsole_put_char(con, '\n');
 	}
-	ut_asserteq(scroll_size, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(scroll_size, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/* If we scroll enough, the screen becomes blank again */
 	for (i = 0; i < SCROLL_LINES; i++)
 		vidconsole_put_char(con, '\n');
-	ut_asserteq(46, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(46, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -423,8 +396,8 @@ static int dm_test_video_bmp(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1368, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(1368, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -443,8 +416,8 @@ static int dm_test_video_bmp8(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1247, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(1247, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -467,8 +440,8 @@ static int dm_test_video_bmp16(struct unit_test_state *uts)
 			   &src_len));
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
-	ut_asserteq(3700, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(3700, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -491,8 +464,8 @@ static int dm_test_video_bmp24(struct unit_test_state *uts)
 			   &src_len));
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
-	ut_asserteq(3656, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(3656, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -515,8 +488,8 @@ static int dm_test_video_bmp24_32(struct unit_test_state *uts)
 			   &src_len));
 
 	ut_assertok(video_bmp_display(dev, dst, 0, 0, false));
-	ut_asserteq(6827, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(6827, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -534,8 +507,8 @@ static int dm_test_video_bmp32(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(2024, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(2024, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -551,8 +524,8 @@ static int dm_test_video_bmp_comp(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx-comp.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1368, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(1368, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -571,8 +544,8 @@ static int dm_test_video_comp_bmp32(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(2024, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(2024, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -591,8 +564,8 @@ static int dm_test_video_comp_bmp8(struct unit_test_state *uts)
 	ut_assertok(read_file(uts, "tools/logos/denx.bmp", &addr));
 
 	ut_assertok(video_bmp_display(dev, addr, 0, 0, false));
-	ut_asserteq(1247, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(1247, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -608,8 +581,8 @@ static int dm_test_video_truetype(struct unit_test_state *uts)
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
 	vidconsole_put_stringn(con, test_string, 30);
-	ut_asserteq(13184, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(13184, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -630,8 +603,8 @@ static int dm_test_video_truetype_scroll(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(34287, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(34287, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -652,8 +625,8 @@ static int dm_test_video_truetype_bs(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(29471, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(29471, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
@@ -691,8 +664,8 @@ static int dm_test_video_copy(struct unit_test_state *uts)
 	vidconsole_put_string(con, test_string);
 	vidconsole_put_string(con, test_string);
 
-	ut_asserteq(6678, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(6678, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	/*
 	 * Secretly clear the hardware frame buffer, but in a different
@@ -716,8 +689,8 @@ static int dm_test_video_copy(struct unit_test_state *uts)
 	vidconsole_put_string(con, test_string);
 	vidconsole_put_string(con, test_string);
 	video_sync(dev, true);
-	ut_asserteq(7589, compress_frame_buffer(uts, dev, false));
-	ut_asserteq(7704, compress_frame_buffer(uts, dev, true));
+	ut_asserteq(7589, video_compress_fb(uts, dev, false));
+	ut_asserteq(7704, video_compress_fb(uts, dev, true));
 
 	return 0;
 }
@@ -772,8 +745,8 @@ static int dm_test_video_damage(struct unit_test_state *uts)
 	ut_asserteq(0, priv->damage.xend);
 	ut_asserteq(0, priv->damage.yend);
 
-	ut_asserteq(7339, compress_frame_buffer(uts, dev, false));
-	ut_assertok(check_copy_frame_buffer(uts, dev));
+	ut_asserteq(7339, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
 
 	return 0;
 }
-- 
2.43.0

