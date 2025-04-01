Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FE75C36010
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:31:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85DC3820F6;
	Tue,  1 Apr 2025 19:30:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="aviEfjO2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 56B6181F4D; Tue,  1 Apr 2025 19:30:58 +0200 (CEST)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3AB5817C4
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-3035858c687so8063123a91.2
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528654; x=1744133454; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqVrKTSkqc2xZjMoN9d9B1IccAt67cCOem4D0J0V0+8=;
 b=aviEfjO2j/3dAgPLRYdG2p3XiQg4glQrCxwgBNLszUosNVi14p4lOOYDz5sghbKF7r
 02ulz0CKY+qXxlfIzsrJgg6SH+r/duzydJsyG7piAgzx511fpp9yPTlWlb6JItgKVBEX
 u+/Bf/ivnGstm+466aPI0HS0v+N1YkzYYNU8g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528654; x=1744133454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqVrKTSkqc2xZjMoN9d9B1IccAt67cCOem4D0J0V0+8=;
 b=rb9M38k6UgeI2SpcgcWM8047W5mVpD54fi6W6IGA2PUNDbn5Elga+jia0+hR4c6R+9
 znB3sHigApLH4cKbryVnUBt8ow81/RTCzW3aU08N3xlcz8IQr8EoCJlFZqrGfpUmYGN1
 drAXLH7tU4TvmumKsyArfj+xlsAOlKdQAmh3CruPsKSCVLPG5gpVwepw+EYeOZ7jRWRO
 bKp8k06OzJYrV+KZX1+wQ6NHNCW1MZyujG+sPvcsl8zkuuIwKc/WVDTvflulJ6i1vVqy
 RyrDtsgC0NSt1JgzV9R+gzECjLOIIFYptTnAvX0TnXmgktYa9v/O1JvvRhe919xBHZMW
 NRgA==
X-Gm-Message-State: AOJu0YxbfxP+XybFd+9K0JojO3q+WOCvi/hIyrLFYh4pS95n1cvpfDYH
 QkRbJsEY7bVjoCKyxX4n5z8Ts0Vcdfroi2JNJGx5nGvzdsTAQ3DIF/GyptrR85F1uTiroyrVq/H
 8ag==
X-Gm-Gg: ASbGncsPmH8oRZOEFcGTCStI93upD5KgJYFwmJeqcqWutqcxKAvnXPDZo9JixHlvvWe
 BAKmyhcXANuD09WDimP5U2VJbAL5RKKRTbOfhrN/gKTVkUOZsxFo5E0qonb5N+oNN3DUZQuvYsD
 a7KaQD14THT/W0aoVDQnGG4EUdCdhWWU02xwUK4MAGQtAgh1Ug0HpX5L1eTgpkfeMWhrXOV605f
 4h/l5Mwib77/f3WOjmAOe1MwM9Eja1HSjGC7C8Ul7FHYAyq+MzH6wLHtAusZm+COMA6t1pBWmRW
 yRZZhjmb1yuog0IZQLFu+w/0JfrXjSs961+qnNKeN3GE8dKm157Uzg==
X-Google-Smtp-Source: AGHT+IFpIEj7pIY7tuBx+Rqqtpxy+TIiTov/70HSyJv5bmqGUeuiNLFMYFxubBgbQxuqr1NaoxVlVg==
X-Received: by 2002:a17:90b:4fcd:b0:2ee:dd9b:e402 with SMTP id
 98e67ed59e1d1-30531fa16b0mr23463258a91.12.1743528653872; 
 Tue, 01 Apr 2025 10:30:53 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:53 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/13] video: Allow console output to be silenced
Date: Wed,  2 Apr 2025 06:29:42 +1300
Message-ID: <20250401172948.1236000-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401172948.1236000-1-sjg@chromium.org>
References: <20250401172948.1236000-1-sjg@chromium.org>
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

When using expo we want to be able to control the information on the
display and avoid other messages (such as USB scanning) appearing.

Add a 'quiet' flag for the console, to help with this.

The test is a little messy since stdio is still using the original
vidconsole create on start-up. So take care to use the same.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/vidconsole-uclass.c | 13 +++++++++++
 include/video_console.h           | 10 +++++++++
 test/dm/video.c                   | 37 +++++++++++++++++++++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index fa329bd1b37..6ba62ec348e 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -532,8 +532,11 @@ int vidconsole_put_string(struct udevice *dev, const char *str)
 static void vidconsole_putc(struct stdio_dev *sdev, const char ch)
 {
 	struct udevice *dev = sdev->priv;
+	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
 	int ret;
 
+	if (priv->quiet)
+		return;
 	ret = vidconsole_put_char(dev, ch);
 	if (ret) {
 #ifdef DEBUG
@@ -551,8 +554,11 @@ static void vidconsole_putc(struct stdio_dev *sdev, const char ch)
 static void vidconsole_puts(struct stdio_dev *sdev, const char *s)
 {
 	struct udevice *dev = sdev->priv;
+	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
 	int ret;
 
+	if (priv->quiet)
+		return;
 	ret = vidconsole_put_string(dev, s);
 	if (ret) {
 #ifdef DEBUG
@@ -794,3 +800,10 @@ void vidconsole_position_cursor(struct udevice *dev, unsigned col, unsigned row)
 	y = min_t(short, row * priv->y_charsize, vid_priv->ysize - 1);
 	vidconsole_set_cursor_pos(dev, x, y);
 }
+
+void vidconsole_set_quiet(struct udevice *dev, bool quiet)
+{
+	struct vidconsole_priv *priv = dev_get_uclass_priv(dev);
+
+	priv->quiet = quiet;
+}
diff --git a/include/video_console.h b/include/video_console.h
index e4fc776e2d3..8f3f58f3aa9 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -53,6 +53,7 @@ enum {
  * @row_saved:		Saved Y position in pixels (0=top)
  * @escape_buf:		Buffer to accumulate escape sequence
  * @utf8_buf:		Buffer to accumulate UTF-8 byte sequence
+ * @quiet:		Suppress all output from stdio
  */
 struct vidconsole_priv {
 	struct stdio_dev sdev;
@@ -77,6 +78,7 @@ struct vidconsole_priv {
 	int col_saved;
 	char escape_buf[32];
 	char utf8_buf[5];
+	bool quiet;
 };
 
 /**
@@ -584,4 +586,12 @@ void vidconsole_list_fonts(struct udevice *dev);
  */
 int vidconsole_get_font_size(struct udevice *dev, const char **name, uint *sizep);
 
+/**
+ * vidconsole_set_quiet() - Select whether the console should output stdio
+ *
+ * @dev: vidconsole device
+ * @quiet: true to suppress stdout/stderr output, false to enable it
+ */
+void vidconsole_set_quiet(struct udevice *dev, bool quiet);
+
 #endif
diff --git a/test/dm/video.c b/test/dm/video.c
index 737ab915f41..dd06b2f58e8 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -17,6 +17,7 @@
 #include <asm/sdl.h>
 #include <dm/test.h>
 #include <dm/uclass-internal.h>
+#include <test/lib.h>
 #include <test/test.h>
 #include <test/ut.h>
 #include <test/video.h>
@@ -865,3 +866,39 @@ static int dm_test_font_measure(struct unit_test_state *uts)
 	return 0;
 }
 DM_TEST(dm_test_font_measure, UTF_SCAN_FDT);
+
+/* Test silencing the video console */
+static int dm_test_video_silence(struct unit_test_state *uts)
+{
+	struct udevice *dev, *con;
+	struct stdio_dev *sdev;
+
+	ut_assertok(uclass_first_device_err(UCLASS_VIDEO, &dev));
+
+	/*
+	 * use the old console device from before when dm_test_pre_run() was
+	 * called, since that is what is in stdio / console
+	 */
+	sdev = stdio_get_by_name("vidconsole");
+	ut_assertnonnull(sdev);
+	con = sdev->priv;
+	ut_assertok(vidconsole_clear_and_reset(con));
+	ut_unsilence_console(uts);
+
+	printf("message 1: console\n");
+	vidconsole_put_string(con, "message 1: video\n");
+
+	vidconsole_set_quiet(con, true);
+	printf("second message: console\n");
+	vidconsole_put_string(con, "second message: video\n");
+
+	vidconsole_set_quiet(con, false);
+	printf("final message: console\n");
+	vidconsole_put_string(con, "final message: video\n");
+
+	ut_asserteq(3892, video_compress_fb(uts, dev, false));
+	ut_assertok(video_check_copy_fb(uts, dev));
+
+	return 0;
+}
+DM_TEST(dm_test_video_silence, UTF_SCAN_FDT);
-- 
2.43.0

