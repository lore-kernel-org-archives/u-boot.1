Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F67C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:47:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73C7B88AEE;
	Wed,  1 May 2024 04:43:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iwof9iJC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8340F88AEE; Wed,  1 May 2024 04:43:51 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C21888ACE
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:49 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3c70a55988dso3608355b6e.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531428; x=1715136228; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/s4khvPkkg6QgTUhUUvQC4NrDY9Nr/NXZEhMR6oT278=;
 b=Iwof9iJCmHSTf092fImO+9PhoH7wJRslQggPXp1vtTHWyVx5q/sKPwHIkTmXUd/7LY
 tudpTWZt3vCrlEqCQV1TrmNPc5azBQyu4xXD1TMjgu1yGCv0X1yekke+RvBDmmFxOEI0
 tTBvHei68yHYhRxiTRIR7mbKcShjc15IOw9Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531428; x=1715136228;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/s4khvPkkg6QgTUhUUvQC4NrDY9Nr/NXZEhMR6oT278=;
 b=g7VGcokdWLD+XmeS57OGlwXSoglQRj36TW0WoZH9oGq6c/9/mEbUwuE7hkpRDqzD2K
 fI/V85OrOc2wvEHq8cxj1UBv8rAJ1OfoARW5oSOb70OQih23BqkmB2mMbJjAw1TldwhT
 pNxTCTRGYZqnKOex+jVmwtD8dz1PeVM0FsCvhEEwrAegrvSrvDQsOPFZQYFtQEhRg6Dj
 kj9n6F5IQqBNgxIdlEF4aSV9Ydl68b8J8ir1uth0c+b7Grei5r12ZwNdu+0KiS7flGOz
 Ai3dTkwfrDiur/1bqYgCOTAehsf8y/3gE6j0jD20C23O2A79fXUnhduBW2EPJ/JlRMOe
 Wogw==
X-Gm-Message-State: AOJu0YyZhLjrhh7Ndw2rGMmizBTAKl8bYXPHGkISG/IizaAXz88Wr0at
 /lcZFqjYIFB07eyiJQFPa75ju6tRPJWvRdVQLpWlz933ML+9u+dpcmyb/p/dk5R6GMwFawwy6xL
 aswiL2A==
X-Google-Smtp-Source: AGHT+IF6S24FfGqz3Qslsrb9NXLUb1E877tburtkWZY4PXquOViVh0H3cmASGfUS6SuX6D2nN04FlQ==
X-Received: by 2002:a05:6808:6198:b0:3c8:6543:584b with SMTP id
 dn24-20020a056808619800b003c86543584bmr1549673oib.54.1714531427761; 
 Tue, 30 Apr 2024 19:43:47 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:47 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Patrick Bruenn <p.bruenn@beckhoff.com>
Subject: [PATCH 025/149] board: beckhoff: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:41:12 -0600
Message-Id: <20240501024316.1767971-25-trini@konsulko.com>
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
Cc: Patrick Bruenn <p.bruenn@beckhoff.com>
---
 board/beckhoff/mx53cx9020/mx53cx9020.c       | 1 -
 board/beckhoff/mx53cx9020/mx53cx9020_video.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/board/beckhoff/mx53cx9020/mx53cx9020.c b/board/beckhoff/mx53cx9020/mx53cx9020.c
index e7b131836b61..3a766728a6f7 100644
--- a/board/beckhoff/mx53cx9020/mx53cx9020.c
+++ b/board/beckhoff/mx53cx9020/mx53cx9020.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/arch/sys_proto.h>
diff --git a/board/beckhoff/mx53cx9020/mx53cx9020_video.c b/board/beckhoff/mx53cx9020/mx53cx9020_video.c
index bf4729025622..fd28a70f4d72 100644
--- a/board/beckhoff/mx53cx9020/mx53cx9020_video.c
+++ b/board/beckhoff/mx53cx9020/mx53cx9020_video.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/arch/iomux-mx53.h>
 #include <asm/gpio.h>
 #include <asm/mach-imx/video.h>
-- 
2.34.1

