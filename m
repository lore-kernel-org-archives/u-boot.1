Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F4FAC3DA64
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:42:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5255F88A10;
	Wed, 31 Jul 2024 16:41:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="LYgmp0lT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B96B088A47; Wed, 31 Jul 2024 16:41:26 +0200 (CEST)
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com
 [IPv6:2607:f8b0:4864:20::d2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6FB5E88958
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:41:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-io1-xd2e.google.com with SMTP id
 ca18e2360f4ac-81f9339e534so201326639f.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722436881; x=1723041681; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLAe3+PdXcNntF6HHKEzTzB26YxxirSGeryH0nQjYqo=;
 b=LYgmp0lTPg9nVhGOQ39JxkVXY9+dDtevvg2Hb5XLBLRSb4s/fUkbRx1lt1sIwp8ciy
 H1K19FGoWqlhANu6Xh41Lt+Jy9qMAdgjvBWBG0IiJ8yWQ2T4UnEpnOd7LIYAC52vD0/N
 UFWuvJKU3NrYlGM+QjLR5fYnVTN3zbiqEJQdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722436881; x=1723041681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLAe3+PdXcNntF6HHKEzTzB26YxxirSGeryH0nQjYqo=;
 b=cyfUOg4pbi1q9VFakINojBkTidHq+RhqXpUhytrlTd+1Sa+OVyeVwKRij1/FpKIwPL
 MLGhBMEjKsg1mUFdit7ehXg0btXnFa6Uj/jle3XJVJ5Uu5Em1aQ6REmTIcjxmqDNt82N
 WTBnF5AKDth4IGYAxRHeuwkVIe7hW+4I7aykXqJVMkFW2FSwB9XJJcw8df7whXBWN7Yv
 ms2lUJHYw4Ir/e4JSlcuq83BcmIAL+jAzGLZoQj0Tkk/DRFkp32j/UOPoSJqcKKeLZzN
 IfN9bCz9C/HrMa6ziStv8Vfd6dwbhmFdV8LLNwL0b5HbGWBWQnS1Tjo3Dwmz4IiVjQcN
 Wk3A==
X-Gm-Message-State: AOJu0YxjGRBUjE0lfp71HJ1Qc+INR37sQNLZOd5zoFL0a84I1CxhxXn+
 jIs9wGBWKgTA5AKritv7ZQi+Dc4sg5nfUZQJUuQ+uqkhCJ9DCcZnnXgF2C2Zjt7qnB8VcyUQJKA
 =
X-Google-Smtp-Source: AGHT+IFf73/X8zLm7TewI96A8vf8py54I7ct6+u19ILNy1cDOH/4LyXtVOlTzuQZESuSLqsqefiGxQ==
X-Received: by 2002:a05:6602:6c05:b0:803:c955:eda8 with SMTP id
 ca18e2360f4ac-81f95a4f738mr1871127339f.6.1722436881128; 
 Wed, 31 Jul 2024 07:41:21 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c29fc0a569sm3209770173.126.2024.07.31.07.41.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:41:20 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Anatolij Gustschin <agust@denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v3 5/5] sandbox: Drop video-sync in serial driver
Date: Wed, 31 Jul 2024 08:41:12 -0600
Message-Id: <20240731144112.787509-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144112.787509-1-sjg@chromium.org>
References: <20240731144112.787509-1-sjg@chromium.org>
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

(no changes since v2)

Changes in v2:
- Fix 'groth' and 'work-around' typos in cover letter

 drivers/serial/sandbox.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/serial/sandbox.c b/drivers/serial/sandbox.c
index ec0068e33d3..77a1558db68 100644
--- a/drivers/serial/sandbox.c
+++ b/drivers/serial/sandbox.c
@@ -138,8 +138,6 @@ static int sandbox_serial_pending(struct udevice *dev, bool input)
 		return 0;
 
 	os_usleep(100);
-	if (IS_ENABLED(CONFIG_VIDEO) && !IS_ENABLED(CONFIG_SPL_BUILD))
-		video_sync_all();
 	avail = membuff_putraw(&priv->buf, 100, false, &data);
 	if (!avail)
 		return 1;	/* buffer full */
-- 
2.34.1

