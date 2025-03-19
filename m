Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E61C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 14:56:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4512981F64;
	Wed, 19 Mar 2025 15:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="KcPBpPaX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7292E81F7B; Wed, 19 Mar 2025 15:55:46 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B804E8203F
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 15:55:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so32998445e9.0
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1742396143; x=1743000943; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VDMi+f+mT6C3SMXCYdNAAZmPvCE2W4aK2vyZziXAYc=;
 b=KcPBpPaXy+JGVoFDv934W8B8xycH075UdgIh0YcfHJNcktrz1C+xIdWF7OPwOf5V8b
 MZoJVmJSdND77krflgaSWfF2x2jgFUcLYvypr3bZUN35bnxUD/f8DLHR2UcLdq3NbDqq
 XZOvTtTA0eKh5LqfPWEZnNa3/rC9AenZXH6V0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742396143; x=1743000943;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VDMi+f+mT6C3SMXCYdNAAZmPvCE2W4aK2vyZziXAYc=;
 b=NzwoP43wTbqpHOpWXFpjPT3UOZ5VRD+9goVFhqhch7ANBwgt+bd5kFDXbUkiqw+s3U
 HS4Ajl4eV7Z+3xEAurWNVkdLEHmZpHIN/K3dgPK3NihghnhomvVBYG7ByWpVDzzIq7ZU
 4Rg0gD+Z+E4lbWgRL+VYijbyLItHH2cBF05dbpLRH1mrejPauKcWDj12nIg2ylifVCV9
 Xf1RLDY9L54qqD7w7c4qMMrQU3iobHzQyFIMwbta7gl5Su/OQW57iIHHW3kL+v6XseEP
 NUtQTISJFuC9ftdonb4GPqVqWpS0jIJGxHYI5CNGsdwnilu7EPa/TB66p6B701ChTraU
 5bwA==
X-Gm-Message-State: AOJu0Yzwspf5GPxRShqf0aQWl7kcfQA88u/xLUQx4CgxJmQCCJcPDfSJ
 2VxqyGRRLuO/ZzNgYwjApZQ34vE1Z8EP4LdkO7MGiez37AqFmZ53GYBgB5hGdcfK4LKhotyM2gI
 =
X-Gm-Gg: ASbGncs3IX69ChAbSyWkAwinKbhVTs6mQqK/sVTfjYp18ta3vns7jxUGd0DQ0PhXdGp
 cbf4O/MnLheCvBPe9+E5E/XuhGmVEpq6qUZVmc/3OD8WWvPKaNaoiHaYxCJcAomkF4E+ugju03C
 0+fvJ/quqD8MCQhEfcncr2y1wMMj/Jb4CGQrR/f7N2JnHua6hyiec+Slrnbu+vxiTPvpu5lX2iB
 6D+RPhzayarhLPi4Vl3DHnrlDHW8Qe5W3N6oVob4J5ybI0zSxsAQBKNGYJoSC8AxUB0fMQGrgtp
 i7NEpzIeXhU381aQvwREDtGil4lZ+0pT5Xzj2x/tDQ==
X-Google-Smtp-Source: AGHT+IHCFY1TqMDchhRchxAuynssHduxgkSCtXDUMSnhtNJYRHHiv/lqgfpmEv9zBV8cBKH+/SzsSQ==
X-Received: by 2002:a05:600c:348e:b0:43c:f16a:641e with SMTP id
 5b1f17b1804b1-43d43781690mr26770035e9.6.1742396142645; 
 Wed, 19 Mar 2025 07:55:42 -0700 (PDT)
Received: from chromium.org ([169.155.233.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed786sm20891315e9.38.2025.03.19.07.55.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 07:55:41 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Janne Grunau <j@jannau.net>,
 Peter Robinson <pbrobinson@gmail.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 08/52] video: Add a way to write a partial string to the
 console
Date: Wed, 19 Mar 2025 15:54:13 +0100
Message-ID: <20250319145512.2391122-9-sjg@chromium.org>
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

When writing multiple lines of text we need to be able to control which
text goes on each line. Add a new vidconsole_put_stringn() function to
help with this.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

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

