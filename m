Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67F9C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:52:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7172E88B36;
	Wed,  1 May 2024 04:44:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="acA7EI/d";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7EA2A88B37; Wed,  1 May 2024 04:44:14 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72F5788AB6
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-69b4454e2f1so28516066d6.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531451; x=1715136251; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tRqd1I6QOVvE+CMxD8gQcOzIkvSigv3ysLauqJ1MH0c=;
 b=acA7EI/dhu8iWG+p/Bi52yDPiw/IPB0mY2i5nsJIwrIhCsrqHYFu3ULIN4tPL23J6P
 BIcdBj/74rVYDgJPlGfV0ght+xdzHRrAWWGLpB377kMqR4E5kKsGk5fEv7L4eMjUvcdq
 ceOPLJLWthR3vyvAoYCi31kVLvqw4Vlma405w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531451; x=1715136251;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tRqd1I6QOVvE+CMxD8gQcOzIkvSigv3ysLauqJ1MH0c=;
 b=kbbkmWQF1/JSqvmFnTJ9ux7PMB8ihR1C1jETzEIIpg/7LcSNmD9FVhGjlIkpaKkLYR
 CMh8lPPUG0kICei3XpjvJKaSASHXTbWNmmrIWYbn0T3raL5G24R/CJ4FU5hMBNBENTQc
 0oHJsY0WiMXf98Ih056yjsgFFFIXnaWMvJhqDNh8NosEOSeWntadOscTVcOQKr3kl3jE
 aqQK/sVIzUmAe5DRPG5BXLxSXAFpBETKXyKUGAEtwLG+IZ4GO7LGa0ppV8euFnjWq5pg
 F/6vF8UueaNvnpkJW3rFvBxQ9fQ3tbNqI5L5Ltw1ohyJH2XQijSeMSu/EtMLHP3IIeGh
 1eqA==
X-Gm-Message-State: AOJu0YyPm2rmKXiuJvjrJRzP4Th4XO6+ZgAQEGyjik6I6jtROfAUpD3o
 hLnwxnYZVMeGtpFLAvwVcVxkrsjiO23Tcem+PS0FlDj976nExjJCzaFnxPIinvRkEYtfaK2eJUy
 blTJQQw==
X-Google-Smtp-Source: AGHT+IFJ2ZMjU0n+L9RtLSnmobzJglwB/SKynvDFR7PR1QVQqFgcz2lwnDWSuZe4+OdJqdLsCL6zQQ==
X-Received: by 2002:a05:6214:400a:b0:6a0:ca95:2eff with SMTP id
 kd10-20020a056214400a00b006a0ca952effmr1160281qvb.31.1714531451031; 
 Tue, 30 Apr 2024 19:44:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:44:10 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
Subject: [PATCH 045/149] board: cortina: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:32 -0600
Message-Id: <20240501024316.1767971-45-trini@konsulko.com>
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
Cc: Alex Nemirovsky <alex.nemirovsky@cortina-access.com>
---
 board/cortina/presidio-asic/presidio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/board/cortina/presidio-asic/presidio.c b/board/cortina/presidio-asic/presidio.c
index fdfa3affc3b1..c07e0eae4e9d 100644
--- a/board/cortina/presidio-asic/presidio.c
+++ b/board/cortina/presidio-asic/presidio.c
@@ -3,7 +3,7 @@
  * (C) Copyright 2020 - Cortina Access Inc.
  *
  */
-#include <common.h>
+#include <config.h>
 #include <event.h>
 #include <init.h>
 #include <malloc.h>
-- 
2.34.1

