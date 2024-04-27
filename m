Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F41A1C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:12:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5665988491;
	Sat, 27 Apr 2024 16:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sUH0UCYg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B31898827F; Sat, 27 Apr 2024 16:11:21 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 993AC8841F
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-78f02298dc6so264214785a.1
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227078; x=1714831878; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=x5FlwvR8f/MvFUN/bHEQOmpXSFqybtxkKz7ITeQR40U=;
 b=sUH0UCYgwvajCCNAB2uXjcc/P+iEVip0Wm9Kjnmnz5yKC5jDIA9ZmItbLOddo5Wc0m
 0IUZcMovzfz49kBhYJVL1PunF2DwdkL2sM8RX5a7D1EhvKJRFmq6jdWNbadQlCeM/j46
 aq9Y8PNPrUXMChhMF6p90kLU/ybNTRrr2y3gU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227078; x=1714831878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x5FlwvR8f/MvFUN/bHEQOmpXSFqybtxkKz7ITeQR40U=;
 b=nXI2e+1Mf2z7nhxdj8hyB/r8ZsErMAcVOP+HAwLFYa2GfCFlKSx6gVdii7jaxblfNB
 CmD7KU7g+bdnH/v3NaKLUjPUwt09NzMCC9Ny6FatWpeU2g+9F6tlnMAqnplt3Rjvt9ZT
 SQRm7WyMvGz/Q1ANHmz6qK2/TeNC7txGDunwJHS/wHiQ7uZv4HxYf9k8TKTCXcKR4x88
 J2LDNkK9RqLTo6cZ4fVmtU1p34aJHu2NIpYHX0twHvBXkv1eb/NVdxYCIrrebYRHVBXQ
 6IWQryxDjYh+bqfMGWa8DhNekVlnPJjHEhnIuxuw7K8xwxpJ4p+oVOzWG7f+roVUjXXi
 7axw==
X-Gm-Message-State: AOJu0YzsQfW1KN9TaMnRoaU/MpRWJAyFGrAe+928bJXWVMdNKJJGI4mg
 4+F215MZ+uF8svNOoakQB9d3CFPvD3TySyJWDEzowek/wNrBHu1+4xjdFSxsv/1Y7mSmod9xoZZ
 oH+DYNg==
X-Google-Smtp-Source: AGHT+IHV3GQ16L8ZLhmRfJ17GfOHq1wNLYXXlgFZAiKidHcb2WnerrhSFaVmNUlCz3A2rcs+4+gcMA==
X-Received: by 2002:a05:620a:2808:b0:790:7f30:6c0 with SMTP id
 f8-20020a05620a280800b007907f3006c0mr5033509qkp.23.1714227078318; 
 Sat, 27 Apr 2024 07:11:18 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:17 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 06/18] nios2: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:10:54 -0600
Message-Id: <20240427141106.3406000-7-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240427141106.3406000-1-trini@konsulko.com>
References: <20240427141106.3406000-1-trini@konsulko.com>
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

Remove <common.h> from all nios2 architecture files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/nios2/cpu/cpu.c        | 2 +-
 arch/nios2/cpu/interrupts.c | 1 -
 arch/nios2/cpu/traps.c      | 2 +-
 arch/nios2/lib/bootm.c      | 1 -
 arch/nios2/lib/cache.c      | 1 -
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/nios2/cpu/cpu.c b/arch/nios2/cpu/cpu.c
index de7bfa947f11..792fa01ab9e2 100644
--- a/arch/nios2/cpu/cpu.c
+++ b/arch/nios2/cpu/cpu.c
@@ -4,7 +4,7 @@
  * Scott McNutt <smcnutt@psyent.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <cpu.h>
 #include <cpu_func.h>
diff --git a/arch/nios2/cpu/interrupts.c b/arch/nios2/cpu/interrupts.c
index 90cabb67571b..27093c4faa3d 100644
--- a/arch/nios2/cpu/interrupts.c
+++ b/arch/nios2/cpu/interrupts.c
@@ -7,7 +7,6 @@
  * Scott McNutt <smcnutt@psyent.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <irq_func.h>
 #include <asm/nios2.h>
diff --git a/arch/nios2/cpu/traps.c b/arch/nios2/cpu/traps.c
index 087a05097d9e..59690214f14e 100644
--- a/arch/nios2/cpu/traps.c
+++ b/arch/nios2/cpu/traps.c
@@ -4,8 +4,8 @@
  * Scott McNutt <smcnutt@psyent.com>
  */
 
-#include <common.h>
 #include <hang.h>
+#include <stdio.h>
 #include <asm/ptrace.h>
 
 void trap_handler (struct pt_regs *regs)
diff --git a/arch/nios2/lib/bootm.c b/arch/nios2/lib/bootm.c
index 657a17c7204f..ce939ff5e15a 100644
--- a/arch/nios2/lib/bootm.c
+++ b/arch/nios2/lib/bootm.c
@@ -4,7 +4,6 @@
  * Scott McNutt <smcnutt@psyent.com>
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/arch/nios2/lib/cache.c b/arch/nios2/lib/cache.c
index 5864d8f0f473..8f543f2a2f26 100644
--- a/arch/nios2/lib/cache.c
+++ b/arch/nios2/lib/cache.c
@@ -5,7 +5,6 @@
  * Implemented by fredrik.markstrom@gmail.com and ivarholmqvist@gmail.com
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
-- 
2.34.1

