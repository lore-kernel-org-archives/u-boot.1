Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE635C3ABAA
	for <u-boot@archiver.kernel.org>; Fri,  2 May 2025 14:49:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 18F8782A0D;
	Fri,  2 May 2025 16:47:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="DV52vJZY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DCB282A0A; Fri,  2 May 2025 16:47:50 +0200 (CEST)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com
 [IPv6:2607:f8b0:4864:20::d2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1938F828BC
 for <u-boot@lists.denx.de>; Fri,  2 May 2025 16:47:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-864a071b44bso67746039f.3
 for <u-boot@lists.denx.de>; Fri, 02 May 2025 07:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1746197266; x=1746802066; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QweEFCMvQfoZIlVc/gIOcy2vWf8TCzvfYVApWVYcDjE=;
 b=DV52vJZY2OiCuUAetrFYgRybYprlL6ce4fzr1VXhtMih49LgT2T+gas4zpJ5jUhsuS
 +hGsrzdhw+EVvb3CDyeeeGgkQmU3oqn1hU159tVTjav6MdTBrawa0lM4za9jG7krQC0R
 XjNy3kmMSFYpWLcNXUetsQiGkhuzGLykKgOlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746197266; x=1746802066;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QweEFCMvQfoZIlVc/gIOcy2vWf8TCzvfYVApWVYcDjE=;
 b=iJzKAysrfHKc+vnPVvFOY/9h39rLO7CJEaiRAl3+VQJk54yhmKZW8JyuVO3Lcv694V
 s03XRCScqa/8Rl5c9xM1KGk2AixZ9xLrP05fS7Var39ZFef/mRIIPUeplVRhxsS6HWPB
 Y0jRiSqLjiSRrU9PAXGydjOYKBOLmfF0VjSqm4bObTwhxFJoxsHrTDiUOAsgjbt1o0l3
 5nAPP1I0vCwo4uw05lrXVYeDNCMUA/d+rOA/ft1Wnow5zdxcR/19Cl5/XHXw5SyJuOB1
 HnHCfxOyx6HaeBkNHcmaexDs3im4Grp5GM5we5LodhNizJO1VjILoWHb3DOYZL3yhRQf
 Shug==
X-Gm-Message-State: AOJu0YxT3zm1CAI/p2RZ3op0FpA3ghO22w0aSIyz7Oubx+4cQPAS3XQY
 11jLd4tmB6uyIZqmYB0IUOwhAX3Hm0RBZPrfM3+5nuMNRMttVPGyxJmbPRpLgFibUVIOSKCQT3A
 =
X-Gm-Gg: ASbGncsFmurmo7i29mI0pHEjIDKGyMnVPE9atkds6oW3SpdJbtxUm9f0ENg9Bkqz4kO
 fU4yBHscpo64Stm0r7Qp3MG3DGHcIBoJ7Zc3AYOdto9hZeAaGaGNChKEFTa2HPs/4v/n0Wo3hdL
 hjVAf5GYCIF5frErRDKV/nLwR5001lesqUA3gOiUu9azLivpvjRp1m+qIYimIRwThEttFTKOWzo
 CKjAzIcjX3AyVvKJzoqSddl3mQbdDKC08nzhmApqHu9KS1juD4AQfz2Sy8g/ulxZE9zw53b3j6e
 +KKYOpQnlAzfDP0u4OjGEQ1VrBW3D+GMS127UlMCWzwuPzUZsCjek+1LeBj8M0nNnXPydUzPsP1
 MQPwI+qnSqOjL
X-Google-Smtp-Source: AGHT+IErDRHycGm2MfgTwRHbysW+AnztWSRHF0g9BLu2eUs1YelLsPulMh4Xiy1T869o2NrdGAlsew==
X-Received: by 2002:a05:6602:398b:b0:85b:59f3:2ed3 with SMTP id
 ca18e2360f4ac-8669fad545emr442788139f.8.1746197266251; 
 Fri, 02 May 2025 07:47:46 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-864aa2bb423sm57011739f.4.2025.05.02.07.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 May 2025 07:47:45 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 12/60] video: Add a way to write a partial string to the
 console
Date: Fri,  2 May 2025 08:46:10 -0600
Message-ID: <20250502144718.313633-13-sjg@chromium.org>
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

When writing multiple lines of text we need to be able to control which
text goes on each line. Add a new vidconsole_put_stringn() function to
help with this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v1)

 drivers/video/vidconsole-uclass.c | 13 ++++++++++---
 include/video_console.h           | 17 +++++++++++++++++
 test/dm/video.c                   |  3 ++-
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/video/vidconsole-uclass.c b/drivers/video/vidconsole-uclass.c
index 3259bd2ef7d..fa329bd1b37 100644
--- a/drivers/video/vidconsole-uclass.c
+++ b/drivers/video/vidconsole-uclass.c
@@ -508,12 +508,14 @@ int vidconsole_put_char(struct udevice *dev, char ch)
 	return 0;
 }
 
-int vidconsole_put_string(struct udevice *dev, const char *str)
+int vidconsole_put_stringn(struct udevice *dev, const char *str, int maxlen)
 {
-	const char *s;
+	const char *s, *end = NULL;
 	int ret;
 
-	for (s = str; *s; s++) {
+	if (maxlen != -1)
+		end = str + maxlen;
+	for (s = str; *s && (maxlen == -1 || s < end); s++) {
 		ret = vidconsole_put_char(dev, *s);
 		if (ret)
 			return ret;
@@ -522,6 +524,11 @@ int vidconsole_put_string(struct udevice *dev, const char *str)
 	return 0;
 }
 
+int vidconsole_put_string(struct udevice *dev, const char *str)
+{
+	return vidconsole_put_stringn(dev, str, -1);
+}
+
 static void vidconsole_putc(struct stdio_dev *sdev, const char ch)
 {
 	struct udevice *dev = sdev->priv;
diff --git a/include/video_console.h b/include/video_console.h
index 1bb265dc9da..e4fc776e2d3 100644
--- a/include/video_console.h
+++ b/include/video_console.h
@@ -499,6 +499,23 @@ int vidconsole_entry_start(struct udevice *dev);
  */
 int vidconsole_put_char(struct udevice *dev, char ch);
 
+/**
+ * vidconsole_put_stringn() - Output part of a string to the current console pos
+ *
+ * Outputs part of a string to the console and advances the cursor. This
+ * function handles wrapping to new lines and scrolling the console. Special
+ * characters are handled also: \n, \r, \b and \t.
+ *
+ * The device always starts with the cursor at position 0,0 (top left). It
+ * can be adjusted manually using vidconsole_position_cursor().
+ *
+ * @dev:	Device to adjust
+ * @str:	String to write
+ * @maxlen:	Maximum chars to output, or -1 for all
+ * Return: 0 if OK, -ve on error
+ */
+int vidconsole_put_stringn(struct udevice *dev, const char *str, int maxlen);
+
 /**
  * vidconsole_put_string() - Output a string to the current console position
  *
diff --git a/test/dm/video.c b/test/dm/video.c
index c1b2a502b47..a9b2482631f 100644
--- a/test/dm/video.c
+++ b/test/dm/video.c
@@ -607,7 +607,8 @@ static int dm_test_video_truetype(struct unit_test_state *uts)
 	ut_assertok(video_get_nologo(uts, &dev));
 	ut_assertok(uclass_get_device(UCLASS_VIDEO_CONSOLE, 0, &con));
 	vidconsole_put_string(con, test_string);
-	ut_asserteq(12174, compress_frame_buffer(uts, dev, false));
+	vidconsole_put_stringn(con, test_string, 30);
+	ut_asserteq(13184, compress_frame_buffer(uts, dev, false));
 	ut_assertok(check_copy_frame_buffer(uts, dev));
 
 	return 0;
-- 
2.43.0

