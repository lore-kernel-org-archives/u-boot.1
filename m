Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4330C36017
	for <u-boot@archiver.kernel.org>; Tue,  1 Apr 2025 17:31:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE345820E1;
	Tue,  1 Apr 2025 19:30:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="Dycna8n3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F06E382076; Tue,  1 Apr 2025 19:30:49 +0200 (CEST)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A55C8206E
 for <u-boot@lists.denx.de>; Tue,  1 Apr 2025 19:30:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3031354f134so7631113a91.3
 for <u-boot@lists.denx.de>; Tue, 01 Apr 2025 10:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1743528645; x=1744133445; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VDMi+f+mT6C3SMXCYdNAAZmPvCE2W4aK2vyZziXAYc=;
 b=Dycna8n3DdaqmxBmxWbnaeTylGkntyMf0HIVobPeLmyLuCpW4gjHIDP5jLNIPVq30T
 N7gQNY8hLvW1pmKSnP0MF7pVxM+mHwaAf8rqjB5Dd1u/74xDXX0nvRi2QTbsJbC+E/K+
 eiS9/i/ogHTZOE2soSMlrMYZU6yQgpIWFd/BY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743528645; x=1744133445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7VDMi+f+mT6C3SMXCYdNAAZmPvCE2W4aK2vyZziXAYc=;
 b=krxJm6bU28l9FvDYDPoYgq4/R6ahtPk3Xr1GhIweQigOwVNck2LNNNzCaQwt0kstks
 2YrbLdL9/vSsMy3kKbvZ51QLcpfjjXq8PhL/D3tzepYQrqqhodGfrfQ8DDSzkk6RKcEm
 xioRYLDU9QBdQep7la+U9lC2ACrtRSt0BBaqFLI0d4HNGy+2DQaJBGz/IiRfRiR4vuZF
 BNar883GPyTd9fRv7e+5mkGpiAP7rb1MTlKhPUaSc6GSMQCRYP9GxpVlnOdt7s5rf80q
 /f6rKvKXTjBIPF7HodH5yYXWdmS+0JY0Kp8qJ2copZUJJhmAguPJGXS0tNo5GGiP3lKu
 yGVw==
X-Gm-Message-State: AOJu0YyuhWUvq0aTH9sy5wc0rHEBOFyCbvU4vkTHPLlhqQUBgEBQv+0g
 HKRx7bu8v/wP9Agtta392lIoQQasSVlWhBUKEU1XdQiPVwrLKAsMfhUnpzZSJPeA2PgS+5hQkvu
 GNg==
X-Gm-Gg: ASbGncsasjPZnxdog8O8CqNsKIktxYcl/xuAlXaphhD74alZgmwkjZQ+YzmozIZ58Ox
 L1UptQflzHtkJimgQjs7HgbTuVnWiqy63Jd5wXEcd4zSJotpsBf0prXs19tt561hqLFyveAnRfW
 z+GWWu/C9CEPaoItJrpy8gp2hlGND4XuFt0LSnTHb4FuJbkYWH0qloHl+bO5umu0dgm0U6zfqEz
 W5OeAmF5q+fuQ6nCQc2507VTYLb632XQJZu4hyMaYncZxZg7VvKr/kPLr8Y0a8FjhJS3zxCNR3E
 4lWx830udvUnGOBZ2s6P5GCxwTKB0LrrZrek1E73ams=
X-Google-Smtp-Source: AGHT+IHOdZbgyfu8FRye4HHpO4nQqxyZzdMaJlk99F5WqfxWst2BCpfnsZe2kctZifqp2qhXyZLVDQ==
X-Received: by 2002:a17:90b:1648:b0:2ff:62b7:dcc0 with SMTP id
 98e67ed59e1d1-305320af245mr19317885a91.15.1743528645441; 
 Tue, 01 Apr 2025 10:30:45 -0700 (PDT)
Received: from chromium.org ([202.144.206.254])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3039dfd48e2sm11958976a91.9.2025.04.01.10.30.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 10:30:44 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>, Alexander Graf <agraf@csgraf.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 Tom Rini <trini@konsulko.com>
Subject: [PATCH 09/13] video: Add a way to write a partial string to the
 console
Date: Wed,  2 Apr 2025 06:29:40 +1300
Message-ID: <20250401172948.1236000-10-sjg@chromium.org>
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

