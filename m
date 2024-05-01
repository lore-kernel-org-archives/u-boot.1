Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79754C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:49:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2E9688ADE;
	Wed,  1 May 2024 04:44:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Sbw8CIhx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC35188ADB; Wed,  1 May 2024 04:44:02 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FAAF88ADE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-69b5de48126so18373856d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531439; x=1715136239; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JH9yzot7UmRkw7ukDVS/b85Gx3DbHsig7Kd/ofvGq7c=;
 b=Sbw8CIhxaQFL+uDOkN1qZSjPaWo6Ncol1pX0im0IsEb7vXfgRnFgWkkQrf98pvrlmU
 s2f6TXfw3y7EpBNzglbKwijVLznpAI9RhXfztfR7BTx+bIcnFyXKkrYqvw0oiiut9UZl
 QYF0xKllHPgbYN4hU6gqvAUYQWEfow12NufDQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531439; x=1715136239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JH9yzot7UmRkw7ukDVS/b85Gx3DbHsig7Kd/ofvGq7c=;
 b=RUON0JDigBYPExYXNyTk5CLSvHn0xHsIX1ABOS4J+C6vDeMjqveFAgpiJ5wfDp7UXz
 JBLWu/Tr0gYwm2sf9mgPYLtsz86ORZ+doVvuy07Z2+0AO9E5RFKKnBER5fiXl7PKnPGX
 ooDu7QH2DIaop1PtSkGUy6jw4XyybqJ1aR4GrYa8+htIxTojs78JZUpHt7ts+WAKTfYF
 R80kLiasrcPrsWKL7GYYQ2yVAsGcicH8LuiGwwMuVjuNTki6BV6RuwsePao6QOtsbCNK
 eASiiYT3tGJe7hojUkYkwS6MSa4h4HSwgl0di1OEn2luHzrQgwRlqlWcyyDD5i/L5U9e
 THAQ==
X-Gm-Message-State: AOJu0YzPb7lHTOcl4M5XJlEcxX8ygzOAGVb+iIMq1/FUsT1LhItMaTPm
 NPX7v5oEyz6SyrNx4QndVDrnxpZ+s2ZdymOTD2PrkAYwIdupXUC/Y25RDfOb/00YuKJvU1xLgvi
 9PT7a2g==
X-Google-Smtp-Source: AGHT+IGL/EXOnQnGdo75CDSFD0g5YAm8966eBc5UaQvv313kGkjfaGgYuYmFx12ChdvrW8QG/7ThwQ==
X-Received: by 2002:ad4:5f46:0:b0:6a0:b36d:b7ab with SMTP id
 p6-20020ad45f46000000b006a0b36db7abmr1558088qvg.7.1714531439385; 
 Tue, 30 Apr 2024 19:43:59 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:59 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Sergey Temerkhanov <s.temerkhanov@gmail.com>
Subject: [PATCH 035/149] board: cavium: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:22 -0600
Message-Id: <20240501024316.1767971-35-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240501024316.1767971-1-trini@konsulko.com>
References: <20240501024316.1767971-1-trini@konsulko.com>
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

Remove <common.h> from this board vendor directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Sergey Temerkhanov <s.temerkhanov@gmail.com>
---
 board/cavium/thunderx/atf.c      | 3 ++-
 board/cavium/thunderx/thunderx.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/board/cavium/thunderx/atf.c b/board/cavium/thunderx/atf.c
index 37340fe97003..ce7afb78ed50 100644
--- a/board/cavium/thunderx/atf.c
+++ b/board/cavium/thunderx/atf.c
@@ -3,8 +3,9 @@
  * (C) Copyright 2014, Cavium Inc.
 **/
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
+#include <vsprintf.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/ptrace.h>
diff --git a/board/cavium/thunderx/thunderx.c b/board/cavium/thunderx/thunderx.c
index ab20825ed36f..b1a805c13609 100644
--- a/board/cavium/thunderx/thunderx.c
+++ b/board/cavium/thunderx/thunderx.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2014, Cavium Inc.
 **/
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <init.h>
-- 
2.34.1

