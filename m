Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DA44C3DA7F
	for <u-boot@archiver.kernel.org>; Wed, 31 Jul 2024 14:45:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 63A4188A9F;
	Wed, 31 Jul 2024 16:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="X5TAAVFg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0C12188AA4; Wed, 31 Jul 2024 16:44:28 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C34E088A9F
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 16:44:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-39728bbf949so27742365ab.3
 for <u-boot@lists.denx.de>; Wed, 31 Jul 2024 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1722437062; x=1723041862; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dLAe3+PdXcNntF6HHKEzTzB26YxxirSGeryH0nQjYqo=;
 b=X5TAAVFgeWNWnsEAanKlObxdObi6o/nHrcHvZR646NcoIgInJWTjHLtX+532fLN130
 t4/rKdebN+DSUH3A4TTlhuagxqdTU+MJ3NvGH13gsLit/PX+5O57/6wZuaMF7OJc2k57
 WUuRpgxz6pjpO1efnIL3qM1iY4yFGt8JqLOws=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722437062; x=1723041862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dLAe3+PdXcNntF6HHKEzTzB26YxxirSGeryH0nQjYqo=;
 b=QMvMVLZPFsRd934lE2zaJte09LqOmTsKB2MOecZUTXFHXGjt1yiTtDl/Jcc+NjI74I
 fNlH4C0PtJEdaUkGRi5kHp7/uK5CpQJxt0r+gTg94sthBQ5RFDaOMb8E8d4Z4uHyrbaH
 0+uK+WzhoZYsMdlWR8AsZ0yMxMyPIMZPVGoS9d9Bif2o+eaQPJ5tBy7TBlSbmrAhQKDx
 TUhXvo8QRLp0NNqNntMK6fj763x7OLChi2v5KCBvCgz9b+bt2pkm9uyvqxE+83snRHPg
 n7Egk3TrfkJqO3c6wGiTnmVKDVq5K/1xDX9d+IOb4ew8JfgbsDxHVxDCpBjHVdqQG6TI
 9O+g==
X-Gm-Message-State: AOJu0YwmPSZxtqRkHb8LUrVDUZY1WFW07kVCkynKV55R4/k6PLIeSTUL
 UW8muC96AjPmkaZsa6fVu5c81R7Azlbk0Aef4OHL6+Ftl0daBY05n2Sq99SvYWjDE/oeK/38TGI
 =
X-Google-Smtp-Source: AGHT+IFbqFTqfKxJLptrz6TVbggUfpV0JdhkXtKeOIHlkjHvgmNKdXDSfp9IbEDuVO/zBSOcmsZ7gA==
X-Received: by 2002:a05:6e02:1a81:b0:375:a282:c96b with SMTP id
 e9e14a558f8ab-39aec2d7891mr137499375ab.27.1722437062423; 
 Wed, 31 Jul 2024 07:44:22 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a22e7e4f9sm55575845ab.2.2024.07.31.07.44.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 07:44:21 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>,
 Anatolij Gustschin <agust@denx.de>, Simon Glass <sjg@chromium.org>
Subject: [PATCH v4 5/5] sandbox: Drop video-sync in serial driver
Date: Wed, 31 Jul 2024 08:44:12 -0600
Message-Id: <20240731144412.790317-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240731144412.790317-1-sjg@chromium.org>
References: <20240731144412.790317-1-sjg@chromium.org>
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

