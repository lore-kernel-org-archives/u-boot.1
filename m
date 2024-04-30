Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 230A8C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:36:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 949A188A1B;
	Tue, 30 Apr 2024 15:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kDdU2W9f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A47C58858A; Tue, 30 Apr 2024 15:36:09 +0200 (CEST)
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E9008824A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6ee2a193a45so1117925a34.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484166; x=1715088966; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RW9APIWwFztBI5qJEn9+3lT2wCdr8KIU0doD+VMShp8=;
 b=kDdU2W9fFTBU9+060HkyiErWNVBwAagNuhgH3gF0+ktV3RR40bcHNKiEC8KAtjId0D
 DSQQhVM8yJXsrFTbLthqb4iOgHO1x88LJhytux/caGuc6PQgdEZ867vcrTdJ2EvK7h54
 MbXz20BnxnZybK9cwxHx5y/mdJA0YCmGRjcV4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484166; x=1715088966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RW9APIWwFztBI5qJEn9+3lT2wCdr8KIU0doD+VMShp8=;
 b=xPrfVb48BIj9n+xbWk0mPWbKt9vk7Sa1LxebuKzKTFdFyoVKRaUyFtswsh/5FVzp9Q
 sZH5PLEqr0g+q98w0RJYk6iAN//tHMzK7LteVtV4GMH5Te/Jc96JABv5d5NJXPiU6+7O
 p4NoPn/Owq3v0COnPsYKePO7Ws0txrhOMS9c0uuMZge4KbLZ5D87rfaJvcK9285iJDnC
 FSPftZiWSZFUdfXeYlJE1epJD1xSpyMo+0kdIjzp/jODiRYn1bOLrwAz373jhlHKveZi
 9925ZOcXkX1K2T2Vx3qPoPX33hneqe/F5Le2BIUROU/pICk/UaQUNvm4sP4RcyUOpnXI
 qaCQ==
X-Gm-Message-State: AOJu0YxSW3ghpTgTPEC8HSJQ2FCJRbB0URbyNOK1nQif1mQvAFO8lrKQ
 O3thwFu74wYjjhMe1gJ1fH2wrBJfaTlz5nzwWSSOeTwm/AosOJeTx/KBEtmcXPzuBM69s2KeJdI
 oMpG4lQ==
X-Google-Smtp-Source: AGHT+IH86OCEbADRVUKbKgpwhF0vdMBDWmwXHp9/Pg9gGVHmNrpjKCi0bNmVTtkN5Vge3ru1TdmJeQ==
X-Received: by 2002:a05:6830:4786:b0:6eb:8434:9a89 with SMTP id
 df6-20020a056830478600b006eb84349a89mr13924100otb.1.1714484166114; 
 Tue, 30 Apr 2024 06:36:06 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:05 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Stephan Gerhold <stephan@gerhold.net>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 04/33] arm: u8500: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:30 -0600
Message-Id: <20240430133559.1836389-4-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240430133559.1836389-1-trini@konsulko.com>
References: <20240430133559.1836389-1-trini@konsulko.com>
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

Remove <common.h> from all mach-u8500 files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-u8500/cache.c   | 2 +-
 arch/arm/mach-u8500/cpuinfo.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/mach-u8500/cache.c b/arch/arm/mach-u8500/cache.c
index 05a91346a897..7541b567d0fd 100644
--- a/arch/arm/mach-u8500/cache.c
+++ b/arch/arm/mach-u8500/cache.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2019 Stephan Gerhold <stephan@gerhold.net>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <asm/armv7.h>
 #include <asm/cache.h>
diff --git a/arch/arm/mach-u8500/cpuinfo.c b/arch/arm/mach-u8500/cpuinfo.c
index ab05b8a51b23..6d4c6196c3df 100644
--- a/arch/arm/mach-u8500/cpuinfo.c
+++ b/arch/arm/mach-u8500/cpuinfo.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2019 Stephan Gerhold <stephan@gerhold.net>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 
-- 
2.34.1

