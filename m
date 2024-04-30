Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B9BC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:41:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7985B88A8B;
	Tue, 30 Apr 2024 15:36:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZUM6WcNC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 11BA388A81; Tue, 30 Apr 2024 15:36:39 +0200 (CEST)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDE0A88A68
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-6a0406438b5so23181616d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484194; x=1715088994; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VBYrDcXI9IUVXr2Oiw/l6BxvMPlkhYo7iO3ESKRSzEk=;
 b=ZUM6WcNCXN9aA/1sHHToEeGBfOFuD3Ca7A4FDN4CgCDjGC0bzuYzfZnK268C6MrjA/
 935yRa2QtcGadtlXLY3+GJdnnAO8YV9i0qk/QfBJKCTZj8qOIwIxQwo8nQy5hnUbVWhR
 q3/wlw/jjieeEd86XxnmMlk+rgXMG1MV65wcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484194; x=1715088994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VBYrDcXI9IUVXr2Oiw/l6BxvMPlkhYo7iO3ESKRSzEk=;
 b=juxbeXaE/bZDNnw8kwxaERkIStjL5tyXehBQLGjRnoPRzSygY77y1CRH78Qgw9g2LU
 73e9OD5omqfqil2dXk4roa7cMJa1OtsqYoBKHwl5VktaP+CoGKJy7+7JxPM9S5jJB1XS
 qpAJV+lchK/1FlD9pfSTOLyB98F14Zf8DELpbde30Y/e6RORZNFzkWiBvNmJD250btkB
 MRFWp2yYbFAFE6hFbm0mlBqd14mMw8ZuFF0ixjy3k+3kOC6bGeR1Ll02F++AEaFN1wjk
 K1njASrLZtzExWAlNWuttU+BPV++UxfCtVz8IBXOAp/xfka8lqVIhyP8oTgHsAZHwI0i
 VQJA==
X-Gm-Message-State: AOJu0YzMbNtHnUf4UTgOxOCQlELHORDiZc6c2uZXgvrvA6ythY+bU7VD
 5eL0y9DUF6RcqrC/CriblV3LV39NGFA6zqAboCbSSQXBgWfNk1hbYvE0BdM1XALws8ZYvbQUAAs
 o8GfAZQ==
X-Google-Smtp-Source: AGHT+IFG73Na/krrKPuWqNqM3Luk+m1LCXOEb6YEZdwSCeXl1D6AFPhJ+KmYsTxYv+NV+iGPUanT6A==
X-Received: by 2002:a05:6214:5289:b0:6a0:9fd9:faac with SMTP id
 kj9-20020a056214528900b006a09fd9faacmr12218230qvb.9.1714484194476; 
 Tue, 30 Apr 2024 06:36:34 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:34 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Ryan Chen <ryan_chen@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>, Joel Stanley <joel@jms.id.au>
Subject: [PATCH 30/33] arm: aspeed: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:56 -0600
Message-Id: <20240430133559.1836389-30-trini@konsulko.com>
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

Remove <common.h> from all mach-aspeed files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Ryan Chen <ryan_chen@aspeedtech.com>
Cc: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
Cc: Aspeed BMC SW team <BMC-SW@aspeedtech.com>
Cc: Joel Stanley <joel@jms.id.au>
---
 arch/arm/mach-aspeed/ast2500/board_common.c | 2 +-
 arch/arm/mach-aspeed/ast2500/clk_ast2500.c  | 1 -
 arch/arm/mach-aspeed/ast2600/board_common.c | 2 +-
 arch/arm/mach-aspeed/ast2600/spl.c          | 1 -
 arch/arm/mach-aspeed/ast_wdt.c              | 1 -
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-aspeed/ast2500/board_common.c b/arch/arm/mach-aspeed/ast2500/board_common.c
index bae10271844a..531c2ad1562c 100644
--- a/arch/arm/mach-aspeed/ast2500/board_common.c
+++ b/arch/arm/mach-aspeed/ast2500/board_common.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) 2016 Google, Inc
  */
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-aspeed/ast2500/clk_ast2500.c b/arch/arm/mach-aspeed/ast2500/clk_ast2500.c
index 02bd3f67c96a..50d7f99b2643 100644
--- a/arch/arm/mach-aspeed/ast2500/clk_ast2500.c
+++ b/arch/arm/mach-aspeed/ast2500/clk_ast2500.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/io.h>
 #include <asm/arch/scu_ast2500.h>
diff --git a/arch/arm/mach-aspeed/ast2600/board_common.c b/arch/arm/mach-aspeed/ast2600/board_common.c
index dc6cdc35d15c..4c0b705ea88d 100644
--- a/arch/arm/mach-aspeed/ast2600/board_common.c
+++ b/arch/arm/mach-aspeed/ast2600/board_common.c
@@ -2,7 +2,7 @@
 /*
  * Copyright (c) Aspeed Technology Inc.
  */
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <ram.h>
 #include <timer.h>
diff --git a/arch/arm/mach-aspeed/ast2600/spl.c b/arch/arm/mach-aspeed/ast2600/spl.c
index 0952e73a4572..05390c16f3af 100644
--- a/arch/arm/mach-aspeed/ast2600/spl.c
+++ b/arch/arm/mach-aspeed/ast2600/spl.c
@@ -2,7 +2,6 @@
 /*
  * Copyright (c) Aspeed Technology Inc.
  */
-#include <common.h>
 #include <debug_uart.h>
 #include <dm.h>
 #include <spl.h>
diff --git a/arch/arm/mach-aspeed/ast_wdt.c b/arch/arm/mach-aspeed/ast_wdt.c
index 5bc442ef33ce..c420940d1cb9 100644
--- a/arch/arm/mach-aspeed/ast_wdt.c
+++ b/arch/arm/mach-aspeed/ast_wdt.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2016 Google, Inc
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/wdt.h>
 #include <linux/err.h>
-- 
2.34.1

