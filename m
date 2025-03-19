Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B529FC35FFC
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 25E4281E60;
	Wed, 19 Mar 2025 15:55:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LdEoc1Vb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6EE348206E; Wed, 19 Mar 2025 15:55:52 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5952381E60
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cfe574976so29948045e9.1
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396149; x=1743000949; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqVrKTSkqc2xZjMoN9d9B1IccAt67cCOem4D0J0V0+8=;
 b=LdEoc1VbiMPxiQSQBhlOyWCv4vGQN/Zltry2aemckrdWbn+q8i34Yt56Ct0iHUlz56
 QDTy8UpsjRBmAyEp7Jk05md9f58X2+WBhd1hJiQsGyCAmxtZ3m71j4JYJXXa1esp6ojA
 HZMZFeDCQ9wa7zvXEIm2/afNWu8VYfQ8s4TJE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396149; x=1743000949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqVrKTSkqc2xZjMoN9d9B1IccAt67cCOem4D0J0V0+8=;
 b=LMKW8dhfgwD5nioK0DplR0XuqFPXK3HTJji6mxtqOC/imKm/rWMHbL0gDbO8i+kX8X
 hfQ1kVUlET10sdxuGnMfkLMsSYpR0HQRU6VneDlF9wigpizlye3i08n9TppBSi4OsjJO
 AD39WixTuerU0hBsSpNpcyvELSgI1wCLZIVWwL86DLOc1/8YHiEuKcnxOLVKXrm4wxqA
 t8RDlNzU1fnZ6V2WFfxdH4ro3tgwGx9Dybij/rKRKBbZRtgltEXE7kC0i3sLSA1isnHt
 qEBUDs1nO8furfX5SzglC2EMx5aR6Ybk0BNOVHVzDpk8w0RNFyGiQha/utBCqNeyGKA3
 ldTQ==
X-Gm-Message-State: AOJu0YwjGDx7ORt64PfpYP7kW3hZ99FTgfci3+wO+cmxjiv11ZSXqcNy
 hsp2n1kqICkbjeY6dwXsPx6YrlYFmR99D8oFbbsjYbLVbbD8Bv+5ouYazdovXL57e6iSBnSLRMg
 =
X-Gm-Gg: ASbGnctBZmVQ3Yj+6JstK1JTqcJ/AtEYUXkXy5v2897tcYoabJfl/VWNvlIQP9w+5xa
 fI9BAQWnnJIT/mIstilVOXUU0EHS5w25ZVCKadWBoKE+tLOhbl+0oDulc1Ea8l2OuZljJlM3bFn
 hoygHdtj1fREXogRciNM+4vZPZt5p4oWJ+d27meg0aNCBcDfrK+p0FkyBSTfiFjiwoA/GDy2HjE
 /pKp3miuebiT9p0UnKhEM8fyH/bSjKIf6SuadspIykMHo1QlcHB1LN/B4gqCo9TNH3rNNLNfyRF
 f9LJ8vawvr6O1wewAe5ExYlj1rZlBaANWgraHs/z9w==
X-Google-Smtp-Source: AGHT+IFuDP6pTAZv0XdclACBaWCgaqjLn0C7Dc4+ZGkM7d5JsLiQGI4a7J8M3odhFMIQvWolJx2HGw==
X-Received: by 2002:a05:600c:34cc:b0:43b:c95f:fd9 with SMTP id
 5b1f17b1804b1-43d43780293mr26698315e9.5.1742396149145; 
 Wed, 19 Mar 2025 07:55:49 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:48 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Janne Grunau <j@jannau.net>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 11/52] video: Allow console output to be silenced
Date: Wed, 19 Mar 2025 15:54:16 +0100
Message-ID: <20250319145512.2391122-12-sjg@chromium.org>
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

