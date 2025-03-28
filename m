Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58EAEC28B20
	for <u-boot@archiver.kernel.org>; Fri, 28 Mar 2025 13:08:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C22E381F95;
	Fri, 28 Mar 2025 14:07:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="V29MD145";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0BF481F59; Fri, 28 Mar 2025 14:07:38 +0100 (CET)
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com
 [IPv6:2607:f8b0:4864:20::d35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D987581273
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 14:07:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd35.google.com with SMTP id
 ca18e2360f4ac-85dac9728cdso40341839f.0
 for <u-boot@lists.denx.de>; Fri, 28 Mar 2025 06:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743167254; x=1743772054; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QweEFCMvQfoZIlVc/gIOcy2vWf8TCzvfYVApWVYcDjE=;
 b=V29MD145mnVr7uhiPpCOWu2ZAnj7brJwsnVWp9Prg3oq/qNrqQjCaP0Fl/sG9IuKCa
 IfYUMEFZ5ZLHlSMimzJ9HlY+xalrrp72U3djVPOaSqHTlk9n2BFnTXBRlcs/DpW0O38S
 tZnX5xta0fKajVLLqoiROqBBwskmCccqjbkgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743167254; x=1743772054;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QweEFCMvQfoZIlVc/gIOcy2vWf8TCzvfYVApWVYcDjE=;
 b=iplnulO2RNhh8bH+IEP7MzTnjFwx0ZZ7wX8hrJiOpF2bYFz4RseopmpCTyaWJdCWzW
 sa9chZ8w+Qbc8CFrffmnWtzdudhmv6aP5NUdzN358NOW2gkzUXfxGDuVoTxiA0H0Ggp3
 ItXkUKyWasDppqXq4nonEnJSj21anYZYjkKA6u/kOwQDJBqEdlxxFPV4l5/dBJy9Bqrc
 J5926ka/P7A3ZQT7KOhN/h/RlpV6mgHCtByjuI8RKsL0JrDfwKlQlY+Fgd7QW7QHRXos
 5kxPTOMlXtKQi7ZIwKb/XdgSsA4/7OIT9RNuMD3g/yH+c5Y33PcVxXwlc3G3ibuncwWR
 2N3w==
X-Gm-Message-State: AOJu0YxmioX/dJDce62p4MzN7tp3noohKS+ROnfUlwb4r5QG4HHxnglw
 CUoUjS84uloLKocM5ft/LifgXLu5Rbq77/JQN3iEqc5ay5pfwl6KyU2TdVdRe7RuHqwrzEFSsMk
 =
X-Gm-Gg: ASbGncuOewwuIC81ccDktn5B/4fDpqmoIavGSaHC6WmkpaWF8nPHQmeYRQ4lhdPPdgU
 coGYRjgjfef459KMU90n7hY7x6+fLUZES1R+tNR8lRf6UQspdUJk96cagfjytUUD+SR4GTx+TI8
 KRJvtWW2+9xfApTCleLttSua0BCIrNsBlh9N89fJ7yRZ63r5/Moq2SgbKQJoq900dTx17cc7Kdp
 1B8ROYSxCEpRqVmgNQxpJ5DLZd3uHLl2dsPeJhk6y5YMOSJATKeBLlqsYIhqz7SFNf/0/qLjLio
 h+fAcwa67t2gV6z56twbW/oj6L9SwFu9wCo8rAoeNMLKpwGj3I85bzxIrVSbNuincvxNkIHGCDz
 yOqlCfg==
X-Google-Smtp-Source: AGHT+IHEbgTCoeZVf5wIMbW7l/ZZnwDVMJPETK8bYZMXdqyRpAQeD/FYZZIwXkXdJXeUtuKdkHobsA==
X-Received: by 2002:a05:6e02:1f01:b0:3d5:7f32:8d24 with SMTP id
 e9e14a558f8ab-3d5cce07d76mr90575275ab.15.1743167253916; 
 Fri, 28 Mar 2025 06:07:33 -0700 (PDT)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4f46477dd4dsm430526173.69.2025.03.28.06.07.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Mar 2025 06:07:32 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH v2 08/56] video: Add a way to write a partial string to the
 console
Date: Fri, 28 Mar 2025 07:05:55 -0600
Message-ID: <20250328130713.2612648-9-sjg@chromium.org>
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

