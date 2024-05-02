Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FD5AC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:38:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 46FC088C8B;
	Thu,  2 May 2024 03:33:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="P0nhzqei";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BEF788BEF; Thu,  2 May 2024 03:33:08 +0200 (CEST)
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com
 [IPv6:2607:f8b0:4864:20::b29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CAE9488C8D
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:33:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-dc6dcd9124bso7443474276.1
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613584; x=1715218384; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yGytr+Qks/+nskVxySdnsb/VNo2eKrUVjw5NkvMxnR0=;
 b=P0nhzqeiyx0HX3yyQhfmD/f/i1a+JFaaQ8qbcK5AikANaGDx7zW1OBX2sV8QB4N+s7
 6QwvzehxY5ygR6DFWIsSlzFrUubctsEEGb5YC6ywgTnXeFZAkVHkCJOouRmPUJYTVlhU
 tTMd/wWwmJgHSYZqPGFJ6AVJFb+kI4RKi4BJY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613584; x=1715218384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yGytr+Qks/+nskVxySdnsb/VNo2eKrUVjw5NkvMxnR0=;
 b=aOkuzN4jaweuxQ44BORXYyvTUJmV9pagqZJry7ij4BI0FKdvech+bMXhnvpUy6u0Tu
 knVHkLcYGiheXEriELOYuPwznFxJfjNIek0t8fbOsqvhCzv+GUmbav3yxSki76JMH9mK
 MZuYHfacehjeU1xirARgJYpLJ1oTSDwsBZnjqB2PsbLbmwiwofoWW6wtoLD+/IBdmae2
 nTvZylm5ncEgXDndXbQGNB6Wv7ZhJtAUAA3HgB7SoVKLBCtDtlmFbAQAP5bC4bfP5edn
 fGgdVCnRJwyHhGny/+rjQV9y4k0ZO4t5/3ixIbbkouUlzEVcX04ZmyiQrn4Ff2BnTsRl
 TJsA==
X-Gm-Message-State: AOJu0YwQGhgxuTvw62C3y2lJu4tr15FCMCsY4PB02RIWyBOTj+3dmv8G
 dC02UDwWskkdVzeta3syRdsZM4cYUYhKbWJ99I3FgM4MpwkCjZaO3NmfQsokZrQyyVbY5ogOAmH
 pu9D9GGzL
X-Google-Smtp-Source: AGHT+IHyKljwtZ1e9SqTQ/pJCriECKxS7WyYUkBvKTwCQNT1zn4QEIw1rRyrbHebeIibuFKwo/Zlzw==
X-Received: by 2002:a25:d084:0:b0:dcb:ad22:1b1 with SMTP id
 h126-20020a25d084000000b00dcbad2201b1mr4335367ybg.3.1714613584510; 
 Wed, 01 May 2024 18:33:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.33.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:33:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
	Bin Meng <bmeng.cn@gmail.com>
Subject: [PATCH 47/81] pch: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:31:04 -0600
Message-Id: <20240502013138.2383421-47-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Bin Meng <bmeng.cn@gmail.com>
---
 drivers/pch/pch-uclass.c  | 1 -
 drivers/pch/pch7.c        | 1 -
 drivers/pch/pch9.c        | 1 -
 drivers/pch/sandbox_pch.c | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/pch/pch-uclass.c b/drivers/pch/pch-uclass.c
index af028f9cecad..9af247580042 100644
--- a/drivers/pch/pch-uclass.c
+++ b/drivers/pch/pch-uclass.c
@@ -6,7 +6,6 @@
 
 #define LOG_CATEGORY UCLASS_PCH
 
-#include <common.h>
 #include <dm.h>
 #include <pch.h>
 
diff --git a/drivers/pch/pch7.c b/drivers/pch/pch7.c
index 5fb35a19effe..4ef82a77e270 100644
--- a/drivers/pch/pch7.c
+++ b/drivers/pch/pch7.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2014 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pch.h>
diff --git a/drivers/pch/pch9.c b/drivers/pch/pch9.c
index 3137eb2c28f5..24b0465efde4 100644
--- a/drivers/pch/pch9.c
+++ b/drivers/pch/pch9.c
@@ -5,7 +5,6 @@
 
 #define LOG_CATEGORY	UCLASS_PCH
 
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <pch.h>
diff --git a/drivers/pch/sandbox_pch.c b/drivers/pch/sandbox_pch.c
index 37c368954b45..aa82dca560f1 100644
--- a/drivers/pch/sandbox_pch.c
+++ b/drivers/pch/sandbox_pch.c
@@ -3,7 +3,6 @@
  * Copyright 2018 Google LLC
  */
 
-#include <common.h>
 #include <dm.h>
 #include <pch.h>
 
-- 
2.34.1

