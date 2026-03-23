Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BED1F483EC
	for <u-boot@archiver.kernel.org>; Mon, 23 Mar 2026 19:55:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C47218426E;
	Mon, 23 Mar 2026 20:53:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="HPJuwwrG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 743A7842E6; Mon, 23 Mar 2026 20:53:19 +0100 (CET)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D018842BF
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 20:53:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-7d7653db148so2596913a34.2
 for <u-boot@lists.denx.de>; Mon, 23 Mar 2026 12:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774295595; x=1774900395; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=bMG7pdJNx6QlGL3FkGSQU5FuaKoP/QMZaexEYoF6jYg=;
 b=HPJuwwrG8SonHns5y8UziiKvM9GEADWI/G+45GDxB/F6N8rfhy1b/OpKE47a6cd/5H
 PP1msKLcmD/uG7lpL3WQ3hvC/eXN6+XJlSJU/R+3wgfFwH7RZ0uv9HMZXfnyyoZj/p1Q
 3uQZDF7akh6A1G+E2YrksqMJIXlQdhjPLbnxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774295595; x=1774900395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bMG7pdJNx6QlGL3FkGSQU5FuaKoP/QMZaexEYoF6jYg=;
 b=WbFJWxMcXXOI2R+AUOj58JWoOjnKfTyI2xMhPG0iFjaLp7ozRPvggRTYocCoI8xNiq
 FFDiN7tERIwlk1F5rTTwIoqKtu4heX0e+bGncSWAIYqbaJdl/3NqJ+vS0l3oQ505ysPk
 BJ3mJ4//LajZRkT4jOnS1IxZHa9yj733/kIu0gOpjgYGDcvN9mXJpwvmqXpXuvGaJsEn
 x+4ofIRI3kWek41YMrZjHKWK1vW28M5J7fccIK419u+qvU4oP/Rb0MU2P1nRUcQNDBhs
 ldTKs62tRRZV7FqPgEkLEvApIwGeLKTArkChSS5Wz1zyzEtZaDYSB/fGzrirYZRvQoFi
 0ojA==
X-Gm-Message-State: AOJu0Ywl4IrjkD/mgeopOUNLy1uMc00Bk3SA34zL55Efh2d/NXqMM71m
 RPoJLBMX3uiOvEwG3JtIN6fs7UcrnLVq0xrXoRy6VOrfWfX7hQmoF5yzKQS5FbAQ+OmT5y0nWnS
 g4g0KEqM=
X-Gm-Gg: ATEYQzxN+WSjiM9ui1IvScCrxwtZ7w8AnvP3tR1EDcP7EMm7MPYQtrXhI4q/Qus0XON
 WNMa1S1nxBbT23P0i9JcATK8FZFrk8ieByP45D8BBIla6f5ORnuxZKvoiVL63wvQbE4qHXNwfS7
 f/aDgnUUGaXeZnuBg0mGQXNIWsEMthBGZhH9AShHW8LYDN7JW6hMQoGDjwUT2f79auCHA1Lthqq
 tJK1ewnX5gwUbSflZYfycKsKrCXiqMgaDseAz5k1tFf64i8C23+ZCy1DbO5AzdVT6SssSuAOP42
 4djZYCCm7kSxAo+n+IugF7VH4IWILUv5kS7kjM9bHgjXLNUzigB0mmya3ugSkaFSXWrUys3Dh+i
 cDlU9oVqGnhygDnA2oLRzy9vhYbHTr+bbvLE/k8IpiTxLLl9Hog2KbWu+THyvc+v1M7JXAGG+oZ
 hxOhzuXZaRISALz9ianqkakNRxiBP9CO4KLBj8oMRYqkQ9r/EoDCL7mcVZ3bwxA2hbXw/wS8hwQ
 nWF8v7Nd1yvubUR/02plGArjCcKY9TJVSJdHCxQ9TIxShqEQIJCPbMBzqJBbw==
X-Received: by 2002:a05:6830:81c9:b0:7d7:d2e4:6373 with SMTP id
 46e09a7af769-7d7eaf4da3fmr8037079a34.20.1774295595055; 
 Mon, 23 Mar 2026 12:53:15 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d7eadce96dsm10301366a34.18.2026.03.23.12.53.14
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 12:53:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] tpl: Correct dependencies for TPL_OF_CONTROL
Date: Mon, 23 Mar 2026 13:53:13 -0600
Message-ID: <20260323195313.2363694-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

The TPL_OF_CONTROL option can only select TPL_OF_LIBFDT functionality if
we also have enabled TPL_LIBGENERIC_SUPPORT, so express this dependency
in Kconfig.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
This is a step in the right direction, I think. There is however a
larger web to untangle here.
---
 dts/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dts/Kconfig b/dts/Kconfig
index 169abe607837..6b501c2239ed 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -59,7 +59,7 @@ config SPL_OF_CONTROL
 config TPL_OF_CONTROL
 	bool "Enable run-time configuration via Device Tree in TPL"
 	depends on TPL && OF_CONTROL
-	select TPL_OF_LIBFDT if !TPL_OF_PLATDATA
+	select TPL_OF_LIBFDT if !TPL_OF_PLATDATA && TPL_LIBGENERIC_SUPPORT
 	select TPL_OF_REAL if !TPL_OF_PLATDATA
 	help
 	  Some boards use device tree in U-Boot but only have 4KB of SRAM
-- 
2.43.0

