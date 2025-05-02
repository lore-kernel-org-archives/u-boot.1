Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A6FBC3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:49:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 05E1682A3B;
	Fri,  2 May 2025 16:47:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Jw++7wGH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1906E82153; Fri,  2 May 2025 16:47:56 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1AB82999
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-85b4170f1f5so72761039f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197272; x=1746802072; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NBjXqrY0Vuu/TwRnqGON0HAmuk8fc5ZuIjjCbdlLEbQ=;
 b=Jw++7wGHMoRl8cA+kNfErLzfQ7hwK/oQyCTGZ5YUoIiOJKNPoWS58KMdzRHZBMVQf6
 AVSZJaFZXgSavFCHWSWIATCzgyM5JebVxdnA5Ve16+xU+sM2Yt5BnH+1V8uUsfkGO9S7
 AAvhm9AgdtmFtXqbi68qFohvxqX58VNLemeys=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197272; x=1746802072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NBjXqrY0Vuu/TwRnqGON0HAmuk8fc5ZuIjjCbdlLEbQ=;
 b=Q2pTumryhxGuyCIZy4SB+EHEvNW1lCjDQ8civm78zpXITHQ7hbAVV5KrTG9sJLjodN
 bM/Ved34a62zvY8ucILR7RWcppI6fITvJe0UR8slNPFlLubrvI0NeoEYrgHbvIChfRXZ
 Yqdw2+fOxnZ/s4zYl9WUSF2rgyCuRmjBW+bJ2AqHO2dZmiCirXdHEmegDixFeOwSP6Lv
 xyiTJLTjHRI+9NOd4VnQPVpK1vU+d4jAr8vuHPBmioS6nv2+RwOTw2BbVnP4wh/CKncU
 yq0Ep3dPRu38Jfr2xoayqeh83CDECTnTjkfi8mSrv64K2pSwgs+IHjNk0p/+4BPBsaCm
 L8xw==
X-Gm-Message-State: AOJu0YxobqGIZECh7sqgzlzBF4LfSE+JZjYeyTkHpcXE8oCV1r7FkTdK
 3PGBF0na6m7pDnTWSSuc/ZpDArKUyCQ4zv5/hRi/lQ3iw9p1YygEsghd46qmLpzrGRIC3n09XdM
 =
X-Gm-Gg: ASbGncuawe2icI8nj8i9+y1q1rKpUHBtgE4VSyuAokkPgKgJtgDQmahgCkpY22Mt9Sl
 WplS0b4Rjgf91U8CMJIHiYFLmRg9LVbKKbezqg+yuXT4G8ybFTOwbSpVksD2C8gLCgE2Jf2EKE7
 l32VLYLskSRq2ayqhvIWFaEw+VbYBDJrTNd6T/+3pOZvjLX/HmXKYTaJe7wn4rsVcIT3iw4ZoLF
 /f7/7idFVXOxMq0TpNYpRrhtqLdLU3NeyIXGiWbLOl/3P3haR2Be6VxzZqkepgr9ufCYLwVmeZ1
 1hDBwtiLVFhZrWP1+dEb3UnE4vTPBVCWBkOTR5FUtmHxt+kQBx/5x/gGHgr+G6htyRTBzNS8/Pg
 2EGxcPEgh2av4
X-Google-Smtp-Source: AGHT+IGaVe2UAsoPS4lvuFGQ4MR/oKH8++DQYMa5RjEc2rRa5j0WswMF5Be4CF/b35WrxS0AhAynvg==
X-Received: by 2002:a05:6602:3787:b0:85d:b054:6eb9 with SMTP id
 ca18e2360f4ac-866b428f116mr374122039f.14.1746197271893; 
 Fri, 02 May 2025 07:47:51 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:50 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 15/60] video: Allow console output to be silenced
Date: Fri,  2 May 2025 08:46:13 -0600
Message-ID: <20250502144718.313633-16-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250502144718.313633-1-sjg@chromium.org>
References: <20250502144718.313633-1-sjg@chromium.org>
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

