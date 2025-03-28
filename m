Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CD34C28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B530A81F4D;
	Fri, 28 Mar 2025 14:07:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="BRV/wHmr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CEAB81F86; Fri, 28 Mar 2025 14:07:44 +0100 (CET)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com
 [IPv6:2607:f8b0:4864:20::d29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AA1BA81FDE
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-85db3475637so99994539f.1
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167260; x=1743772060; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBjXqrY0Vuu/TwRnqGON0HAmuk8fc5ZuIjjCbdlLEbQ=;
 b=BRV/wHmrMz68sLTGu8eTRyUTIVTQyTKpV5nKJT99yVxM96pnNRRo1rJJglCQPT7P3W
 rM5z1EPzTEyxCC00ueKDmdVIaX0c+tgckfdS4UdvPMoUvd5SfoR3GPU/Fr7XHbBhFya8
 iZ4XnJhlJI+mbn4S5hpTvML/wJoXgVHOzB4RY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167260; x=1743772060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBjXqrY0Vuu/TwRnqGON0HAmuk8fc5ZuIjjCbdlLEbQ=;
 b=vUj0CkVthW4bDQK/mXj/8RD8khMrMJ9GNym3ufqAjpJmB7BYE8XrojtcFjFXXujA4O
 AU9gnXGPc8X6/Cd90gv5oNv5b3aqyEjNv3NYmLiF2pJXMLpaHh9W+5CLTgQrzek5SUYN
 LtT1pqZknKBYUBFGp7sFk4oN+Ff6F8J3F26bXxZ0sOW5q9E0Q8xTVymG7hQj9EgACB7W
 uyAqt1UmQF3oKR4699xB67GtJuJCa2lzj5Xc6gqPTq2SpZ4Y8A6WurKt1PIEeL754+is
 i/DS8iJAGg21ZlYHKZwp6NZKMG0/I0RGdsI8U0DydoaH6bqkkxEYHwx6kBrdXDdCd0Tl
 NfxQ==
X-Gm-Message-State: AOJu0Yxi6lAlYLwyKyjajYy/fcndkHMo+MlMtSjCP2RyVjGjuQnpI/l2
 btENg3iNbh7Lm6RNZy29vS3gmydGQPckLfyuwFZa8NZT6fRxjaRnw0px3nTDVgcI8GtzdaawiYE
 =
X-Gm-Gg: ASbGncsvJeVzJYjXX+TGfM3Ka1nxrzW3bXphExgnkilThOUSZX0Vf8qyx0LaODB//IC
 48woDtrtLyuJBnI5eK9Hh6gCThNl80lYiXUG/PVwfvtS3+bp0lY+vDXFesm4k70KCId/e1jt2DK
 N0mbj+dad+1/nbaJVTWPmo3nfQYtyT2IAWQrFl1AxB+l+Ics5dytKwuQIejgKD3oadj7+5siwbs
 S+oJkMtmE9Co0NO1u//hLlL7YX4TGTxVDcXcMp64IB3W1zVy4O9LmRmBKYal9nz7W2reVR9ypA3
 rfcu85h6uf/fK++B6vu+Sh1S4b3NLa30Io9TmveFOL/Ni9p/pu6yah6EgUMR6hZUt3kkNnS8Rml
 OR201mg==
X-Google-Smtp-Source: AGHT+IHkh0CIQq2sG+TZaPEfkgxqDyCFYiCWfueVUE5jOf+jJJ3ojyXaseC/8m2vR2xa1QyrsYZDZg==
X-Received: by 2002:a05:6602:4f4f:b0:85b:468a:2d0d with SMTP id
 ca18e2360f4ac-85e91d3cc56mr229981039f.2.1743167259675; 
 Fri, 28 Mar 2025 06:07:39 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:38 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 11/56] video: Allow console output to be silenced
Date: Fri, 28 Mar 2025 07:05:58 -0600
Message-ID: <20250328130713.2612648-12-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250328130713.2612648-1-sjg@chromium.org>
References: <20250328130713.2612648-1-sjg@chromium.org>
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

(no changes since v1)

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

