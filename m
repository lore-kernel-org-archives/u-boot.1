Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D69FE7718A
	for <u-boot@archiver.kernel.org>; Thu, 19 Dec 2024 18:30:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95098802EF;
	Thu, 19 Dec 2024 19:29:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="FFl2OtOs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BF2880326; Thu, 19 Dec 2024 19:29:31 +0100 (CET)
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com
 [IPv6:2607:f8b0:4864:20::133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3792280381
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 19:29:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-il1-x133.google.com with SMTP id
 e9e14a558f8ab-3a7deec316aso3582875ab.1
 for <u-boot@lists.denx.de>; Thu, 19 Dec 2024 10:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1734632967; x=1735237767; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eeeo3LTMEVCfjxPdDZS28oi5ekOzg9BHJWxs4WVPUYg=;
 b=FFl2OtOsjd4fGvYR5ox+04uvudMwyRfnSnMQhCIQ2sOCzeeBa/ga26k+rFt6K0NvC/
 qGGUTR2ZDuHcqpTUmLKFCBK062AAljEQzVdWgH6EqRqa8NmeFJzTeGMp6klKxIhMbSJ9
 DyCdZCfx6tQnxtUKUSTrqqbEtB1FVsMRl2RSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734632967; x=1735237767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eeeo3LTMEVCfjxPdDZS28oi5ekOzg9BHJWxs4WVPUYg=;
 b=sJZXGusS+h/NCCTAx8F3HxJkLtbY8vSBlv8btV7ju/3jXX9liV+ii6Hc8Uwsj20SQJ
 e3J1Lbp4CVET1l4WLFwFlXy/vmDuw2px9CbdTMuTwXjSo/qXdthRJVHrzkf03vKfjE9g
 bfSXlIE/GtQdPCdwHnUD060XJCuJ/HOzyI4sY9zRrSfL6RCeKGOT6fwl6zWiLXT79Lto
 bEG6bX/UtiHqkrMokih3nv9UjfKzzRv1gl4gQaJ1UmYuNO3Z/u7ktTe480N3JQIdJsig
 277uAgl9YvnXyaUhmPY5NIR88NynK4eoncvvYoR4DMauv4gCNI7Bftrppz571vpBvBNm
 8p+Q==
X-Gm-Message-State: AOJu0Yw6QuldakGUSqyaQtfDPHB6BJh1nxp1pSTmCQDI0D6yT8uh6RAN
 y6U34X6jlEidTUrvlDknQBg4EWHupW1kN4JaGooKLDH1Eww7XDTVOWWBckKplm3lo8odgPnypIw
 =
X-Gm-Gg: ASbGnctzAF81B/GrR3n9BcH4mDv2uQlUNnkIL8NilVlgl3UnAcMvwfGZclxyGG0XQbP
 qUMWHR4OnAqn/7lwJtyRE66QoM2q41VOqqFTGW7cICRTbS5/Nenbafpby7FtgteyA3UnmSeE/4A
 a669dNfDU50tv2QbesAgicUQ0255IHxYB9Oh9Nr7RkLb1XgUWafrmazK6XM0RqmqSzep1bILWY3
 LsxJPh42xuT/ViPAUx7TWZX1um6L5k1JLzHNllyJZ0F3HFEqt6X++Q21Wm6aGusAC4eUcP0EoV4
 BbcNQM8CbIUh5FRphw==
X-Google-Smtp-Source: AGHT+IGBCKvn6JLzY5adgBIt6n0UqYk8Rhm71cy54zPwbp4l5ABkBl3j7EaUpSAbg6amEYtupPPfag==
X-Received: by 2002:a05:6e02:1fc7:b0:3a7:e4c7:ad18 with SMTP id
 e9e14a558f8ab-3c2d4e6bce9mr984845ab.18.1734632967443; 
 Thu, 19 Dec 2024 10:29:27 -0800 (PST)
Received: from chromium.org (c-73-203-119-151.hsd1.co.comcast.net.
 [73.203.119.151]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e68bf676c6sm393655173.50.2024.12.19.10.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2024 10:29:26 -0800 (PST)
From: Simon Glass <sjg@chromium.org>
To: U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Simon Glass <sjg@chromium.org>,
	Tom Rini <trini@konsulko.com>
Subject: [PATCH v4 06/19] malloc: Show amount of used space when memory runs
 out
Date: Thu, 19 Dec 2024 11:28:54 -0700
Message-Id: <20241219182907.2609704-7-sjg@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241219182907.2609704-1-sjg@chromium.org>
References: <20241219182907.2609704-1-sjg@chromium.org>
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

Show a bit more information when malloc() space is exhausted and
debugging is enabled.

Signed-off-by: Simon Glass <sjg@chromium.org>
---

(no changes since v2)

Changes in v2:
- Add field names into the message

 common/malloc_simple.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/malloc_simple.c b/common/malloc_simple.c
index 5a8ec538f8f..f0f90a095bd 100644
--- a/common/malloc_simple.c
+++ b/common/malloc_simple.c
@@ -26,7 +26,8 @@ static void *alloc_simple(size_t bytes, int align)
 	log_debug("size=%lx, ptr=%lx, limit=%x: ", (ulong)bytes, new_ptr,
 		  gd->malloc_limit);
 	if (new_ptr > gd->malloc_limit) {
-		log_err("alloc space exhausted\n");
+		log_err("alloc space exhausted ptr %lx limit %x\n", new_ptr,
+			gd->malloc_limit);
 		return NULL;
 	}
 
-- 
2.34.1

