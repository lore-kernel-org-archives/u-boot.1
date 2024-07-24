Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 270A1C3DA63
	for <u-boot@archiver.kernel.org>; Wed, 24 Jul 2024 15:10:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 410048899C;
	Wed, 24 Jul 2024 17:09:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="JsKKWFj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E9788967; Wed, 24 Jul 2024 17:09:44 +0200 (CEST)
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com
 [IPv6:2607:f8b0:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 522BE88965
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 17:09:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x134.google.com with SMTP id
 e9e14a558f8ab-396eb81a1cfso27995585ab.2
 for <u-boot@lists.denx.de>; Wed, 24 Jul 2024 08:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1721833781; x=1722438581; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h8oGCbcym9UJIVxLfN0RSjypMoJ7YBzWqoB9zqpnOKA=;
 b=JsKKWFj7ICffiED84PPt0DJXQKQjqJzqQX2Ovzo5D23LESxUIqYxcYSGwqrBQyWeb8
 wk4HINpqNlGXumDX/c+Rb+l4oE9oW215ese7suRu3e1qFPTOnuMgmN5+qavV+rfDtZGL
 p/DaxKyApvoKo48P2OlHM6ExrHcLgx4gRbnKY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721833781; x=1722438581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=h8oGCbcym9UJIVxLfN0RSjypMoJ7YBzWqoB9zqpnOKA=;
 b=C7Y7ZMlPOSOluEpT2ie9bUMEt8BGYQRGxvRUsjuWQdJN+pB7RMWGqI1tCW5ySyO0ut
 WY7Mal4yIU1jURkrE1wX5V0uxGzQv2gWZs0LAMfHIItgFHmkvyWRqJTXEOz9aPVWOd+N
 UqgS3HYb9nYVGFwdOMVbBh5aqCil0gxb2Fl66DHbz2nHQFL15cDxpxPhKQNKwDWkM0KX
 Q3Tre7Y1EXhqEIveAyoeWjuIwTk43JB4cpQNdy29V0obZl6ugPeJHjceBfCUbVx3nmwY
 yz3LQZTykn1iPUMSIWwf48dZRxPcWYeKKltewyF99T4W+XQJm54pmqb8yXeC+fAnmRnF
 Yi8w==
X-Gm-Message-State: AOJu0Yy5XalHmmeIioLiM8yN1OaLZ2xP1RTDiexJXOTmDTCiYjyhpgLZ
 vvPkqagVHLdRUw/kUbpnz72GsAymoomFnZPeyZi5qtvfsG4Syj3JcPd3mFefjvH/5UqKaADefx0
 =
X-Google-Smtp-Source: AGHT+IGbYCVeCa7wNVbsyITrkyNSfDw281+iDFzMoQJ1VwvG5L4tKmDUDNPDZE94Hfb/HzF2Z0je4A==
X-Received: by 2002:a05:6e02:b47:b0:398:17c8:6bdf with SMTP id
 e9e14a558f8ab-39a19262755mr27683345ab.8.1721833780865; 
 Wed, 24 Jul 2024 08:09:40 -0700 (PDT)
Received: from chromium.org (c-73-14-173-85.hsd1.co.comcast.net.
 [73.14.173.85]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-39a18596c3asm6873645ab.25.2024.07.24.08.09.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jul 2024 08:09:40 -0700 (PDT)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Anatolij Gustschin <agust@denx.de>, Peter Robinson <pbrobinson@gmail.com>,
 =?UTF-8?q?S=C3=A9bastien=20Szymanski?= <sebastien.szymanski@armadeus.com>
Subject: [PATCH 05/35] video: mxs: Avoid setting global_data fb_base
Date: Wed, 24 Jul 2024 09:08:52 -0600
Message-Id: <20240724150922.2343249-6-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240724150922.2343249-1-sjg@chromium.org>
References: <20240724150922.2343249-1-sjg@chromium.org>
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

This is not used, so don't set it.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

 drivers/video/mxsfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
index 792d6314d15..e72839cead4 100644
--- a/drivers/video/mxsfb.c
+++ b/drivers/video/mxsfb.c
@@ -335,7 +335,6 @@ static int mxs_video_probe(struct udevice *dev)
 	mmu_set_region_dcache_behaviour(fb_start, fb_end - fb_start,
 					DCACHE_WRITEBACK);
 	video_set_flush_dcache(dev, true);
-	gd->fb_base = plat->base;
 
 	return ret;
 }
-- 
2.34.1

