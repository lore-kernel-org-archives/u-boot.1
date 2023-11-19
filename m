Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EEDCC072A2
	for <u-boot@archiver.kernel.org>; Sun, 19 Nov 2023 14:49:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7787E87135;
	Sun, 19 Nov 2023 15:47:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="PPAApbAL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A86587005; Sun, 19 Nov 2023 15:47:28 +0100 (CET)
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com
 [IPv6:2607:f8b0:4864:20::d32])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 097EA87186
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 15:47:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd32.google.com with SMTP id
 ca18e2360f4ac-7a94c5538aeso114852339f.3
 for <u-boot@lists.denx.de>; Sun, 19 Nov 2023 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1700405230; x=1701010030; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1zxTdWrCMUEsyEdmlBqfPioITLYUvTt8UJ2EZDi++E=;
 b=PPAApbAL5bijYlemyA/Vlrg73XlviBn4ghwLhXQmP5Q4D4vtB9cWUDwFkmZuH8YUGx
 ZOKu3rPhdqw6U8BorQZynLxrqWxbqHaGS0RyK+XMLj/y5rRsKELKFPGUUtLV1bkgYp6K
 5fuwir0uDtwCc7ojcD7W1l5kXDCsSvvX4XFho=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700405230; x=1701010030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G1zxTdWrCMUEsyEdmlBqfPioITLYUvTt8UJ2EZDi++E=;
 b=HPwyOyKNVcUx69aw+fwABA01D5NtumfhayOQLvEYn7gvI1BJkpZ2sjSyA4LIcYLTRm
 JFT/GiVbZOUqCe3e6g5RLggY6MC7Pwr2PBGXBoS0X9xp5794VgQF8IVkw2iBCvsxU+xg
 +Y80QJEpp4BmB48yY8aetM/wx4mRudjLzSUdOqA/byCPWSc/Y+8I9RMfjks5vS9RM1j1
 a92Xv4LeFZSc2wV35NrPkNrejhcdRrKAx/EIafXCdJkOpaDlexsFxrDVjFwXb5px8MAl
 GMzApHwwQtmoNIWt0G34zCvxxLTIBDXE9ZcmXGFgxk/f5UD1XcrM2U9eZfQwwokwngrA
 HUVQ==
X-Gm-Message-State: AOJu0YzJVJJt/QD2MxZ8G0E7ct3OyaqCyc3kERUeWuskD105UByANoYJ
 UnDYgoRbxzET/ZH0sVoqz+DSXLPVB6vWpFbteaD+TQ==
X-Google-Smtp-Source: AGHT+IE9VrnyuS/FnsTxHPGJp0LdC7nSC+uHoIcTp5Q+KtH4oYBEjN/5shL7rt8EYDP3H/xyfYkpyg==
X-Received: by 2002:a5d:9ad4:0:b0:7a6:7e93:6f86 with SMTP id
 x20-20020a5d9ad4000000b007a67e936f86mr6183853ion.10.1700405230681; 
 Sun, 19 Nov 2023 06:47:10 -0800 (PST)
Received: from sjg1.lan (c-73-14-173-85.hsd1.co.comcast.net. [73.14.173.85])
 by smtp.gmail.com with ESMTPSA id
 w6-20020a023946000000b0043194542229sm1450695jae.52.2023.11.19.06.47.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Nov 2023 06:47:10 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH 5/5] sandbox: Drop video-sync in serial driver
Date: Sun, 19 Nov 2023 07:46:43 -0700
Message-ID: <20231119144700.631322-6-sjg@chromium.org>
X-Mailer: git-send-email 2.43.0.rc0.421.g78406f8d94-goog
In-Reply-To: <20231119144700.631322-1-sjg@chromium.org>
References: <20231119144700.631322-1-sjg@chromium.org>
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

With sandbox, when U-Boot is waiting for input it syncs the video
display, since presumably the user has finished typing.

Now that cyclic is used for video syncing, we can drop this. Cyclic
will automatically call the video_idle() function when idle.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/serial/sandbox.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index f6ac3d228526..be72fd2c65f7 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -139,8 +139,6 @@ static int sandbox_serial_pending(struct udevice *dev, bool input)
 		return 0;
 
 	os_usleep(100);
-	if (IS_ENABLED(CONFIG_VIDEO) && !IS_ENABLED(CONFIG_SPL_BUILD))
-		video_sync_all();
 	avail = membuff_putraw(&priv->buf, 100, false, &data);
 	if (!avail)
 		return 1;	/* buffer full */
-- 
2.43.0.rc0.421.g78406f8d94-goog

