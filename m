Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2524C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:12:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EEC018844F;
	Sat, 27 Apr 2024 16:11:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="nH5PNhBY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3D3BD8827F; Sat, 27 Apr 2024 16:11:21 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C71088407
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6eb848b5a2eso1640657a34.3
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227077; x=1714831877; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kRirUDMZ5L8RdTH2engZsd6mWSEaUScR2+CjL90/nSM=;
 b=nH5PNhBY8O3u6Ixcey5UbOFkPZd6EagSRb00x5eEA12fosr7SJ8KHJfYWb5SgXaEKR
 k81Ude6XPx4HngrwdXAy98ZIVCpbzMRWZqpB577SN6Y/T5RwNCXUBkiD2uK/YJdwxzcv
 A/DKwPf4+TB3GRHtIX1fXpQLt4f0dCqmd3rY0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227077; x=1714831877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kRirUDMZ5L8RdTH2engZsd6mWSEaUScR2+CjL90/nSM=;
 b=Fu2tQZQaI87J8Igw+rDi/y9KTy7WaRCXZUb7icZvfvSgDITKcmCEWJI1ojvO8qEIEm
 0zpAYfsLr+wtwWsx9000Y8YQ17puLhI2WZBSgpaFxKKAVlghGifiGCpSIwKGluBT8Bpn
 VrhcfLU4Kn6Ak+Fwxvy70PFp+F5YmkN73JCJH9h9tWFihilvuuGgoHwyjwkmvjreNqRl
 IK/syaz7CjRZ276TfD9SsxhK8yRR1jTzzUCyiyfpLnrxU5uHiAtvwzH8CSnw4RP3chOb
 XoNlt5IwgKonLRRiBDr0ev5rxNyw9maDBLe540Zf/bgBIMPtcnX6ZhYDiCFBsa/LV1rq
 kfkA==
X-Gm-Message-State: AOJu0YynWqi/e9y8Z3Y2Fre45Fp349EUY10LSnH4FlCVjk7ELTT/rxGu
 zflP0WT7LN8Vk+fRmNgVOLml2ujLTut3w1kEgqW9JXKdAMRXvA2MFTGzOr8cLQTOjIKu4NqTUQK
 A1v/DiQ==
X-Google-Smtp-Source: AGHT+IEV+Tj/dq8Zy7IjNXW54qfLTKzFnktdWoK8neJF2OLqpWZ5aFDKjP465CvyQDCpGs6355/0RQ==
X-Received: by 2002:a05:6830:a:b0:6eb:e1ba:6648 with SMTP id
 c10-20020a056830000a00b006ebe1ba6648mr5875330otp.1.1714227077399; 
 Sat, 27 Apr 2024 07:11:17 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 05/18] xtensa: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:10:53 -0600
Message-Id: <20240427141106.3406000-6-trini@konsulko.com>
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

Remove <common.h> from all xtensa architecture files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/xtensa/cpu/cpu.c        | 2 +-
 arch/xtensa/cpu/exceptions.c | 2 +-
 arch/xtensa/lib/bootm.c      | 1 -
 arch/xtensa/lib/cache.c      | 1 -
 arch/xtensa/lib/time.c       | 1 -
 5 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/xtensa/cpu/cpu.c b/arch/xtensa/cpu/cpu.c
index 98d9753b7e34..abcd8f7984fa 100644
--- a/arch/xtensa/cpu/cpu.c
+++ b/arch/xtensa/cpu/cpu.c
@@ -8,7 +8,7 @@
  * CPU specific code
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <init.h>
 #include <vsprintf.h>
diff --git a/arch/xtensa/cpu/exceptions.c b/arch/xtensa/cpu/exceptions.c
index cf9af4326a29..206767094e9f 100644
--- a/arch/xtensa/cpu/exceptions.c
+++ b/arch/xtensa/cpu/exceptions.c
@@ -10,12 +10,12 @@
  *  (Note that alloca is a special case and handled in start.S)
  */
 
-#include <common.h>
 #include <command.h>
 #include <irq_func.h>
 #include <asm/ptrace.h>
 #include <asm/string.h>
 #include <asm/regs.h>
+#include <vsprintf.h>
 
 typedef void (*handler_t)(struct pt_regs *);
 
diff --git a/arch/xtensa/lib/bootm.c b/arch/xtensa/lib/bootm.c
index 9780d46e9b89..1de06b7fb53d 100644
--- a/arch/xtensa/lib/bootm.c
+++ b/arch/xtensa/lib/bootm.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2014 Cadence Design Systems Inc.
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
diff --git a/arch/xtensa/lib/cache.c b/arch/xtensa/lib/cache.c
index 4e0c0acc3bbe..e6a7f6827fc2 100644
--- a/arch/xtensa/lib/cache.c
+++ b/arch/xtensa/lib/cache.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2014 - 2016 Cadence Design Systems Inc.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
 
diff --git a/arch/xtensa/lib/time.c b/arch/xtensa/lib/time.c
index 1c927d2a6a3c..c6739584bbf2 100644
--- a/arch/xtensa/lib/time.c
+++ b/arch/xtensa/lib/time.c
@@ -3,7 +3,6 @@
  * (C) Copyright 2008 - 2013 Tensilica Inc.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <time.h>
 #include <asm/global_data.h>
-- 
2.34.1

