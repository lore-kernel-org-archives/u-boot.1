Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49895C4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 03:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 740E688C0B;
	Wed,  1 May 2024 04:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="L6p9cgjd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A21D488C0B; Wed,  1 May 2024 04:45:41 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12EC88C89
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:45:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6a04bae512aso32496586d6.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531537; x=1715136337; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tsfq/2MhzS2JOO3VzB6ON/+Mpf7WUfAhLYNiZmjg7e4=;
 b=L6p9cgjd0QKm8MCdeE8qkyeEepU6HMJnNgTXOBnLg2iW1eOyQDIlyXU0f2Ap6GVsJh
 uke2vu8MurLq+TZTDz/byOoCo4iolhXXWF2mdE//LIoIHxE2z42Vljw99rHVcgVuxVeF
 JZe/Zfs2j7gdoiWSIYdv7VlGJB/GA6YqF+Am0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531537; x=1715136337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tsfq/2MhzS2JOO3VzB6ON/+Mpf7WUfAhLYNiZmjg7e4=;
 b=RPulwUpdieV61OArc8D+YtOKRBG3h3lOYVMMJDSDWyvQp3HTlBGh/EYD4a7j+UWLsF
 8lFcocY6ikQBO9gyoOhb/3vMy4+RVbmE9+KAGvHRnwwrumZBa9mSHaqF/eUSDdDreFXt
 34IavJDD6t+aC/VOsDAey92h6LyoBVNK3ZSzdpGoEGCNm2TmohcLzzaeFmrdNVnwwulm
 setl+Edq+Gj8mg9jRSCf2bd+fyAJr4EhErPUE7/Y2943IPYfyulPxgH/sZFog5HVse3R
 i01Hzag3OLagmrM2jeC4um+T5895BQGLTneCNueegfJiNlvAp+aGPlGcbmripeE5n+fP
 f/Qg==
X-Gm-Message-State: AOJu0YwcgpVyVatRooADF0T5FWYKYDEBCn175FkHOIAznZtzEwf78Yju
 aOJJ84kiB7CYsrg2BTpz9pgDzv62BVT+DvjyP3w0F3k4ZV5fSb+Hkl+fj101HEA5D+7gkOOiETA
 r1MvlJZNJ
X-Google-Smtp-Source: AGHT+IFu6NobEsDuyCEsNHUvJ2hLsE4qxIMcEZ8JPxGhM0bWlyFCNc52XqX6gZy1ohh6f7o04G5seg==
X-Received: by 2002:ad4:5d66:0:b0:6a0:d32d:79d with SMTP id
 fn6-20020ad45d66000000b006a0d32d079dmr1033896qvb.56.1714531537399; 
 Tue, 30 Apr 2024 19:45:37 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.45.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:45:37 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Heiko Schocher <hs@denx.de>
Subject: [PATCH 121/149] board: socrates: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 20:42:48 -0600
Message-Id: <20240501024316.1767971-121-trini@konsulko.com>
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
Cc: Heiko Schocher <hs@denx.de>
---
 board/socrates/ddr.c      | 1 -
 board/socrates/law.c      | 2 +-
 board/socrates/nand.c     | 2 +-
 board/socrates/sdram.c    | 2 +-
 board/socrates/socrates.c | 2 +-
 board/socrates/tlb.c      | 3 ++-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/board/socrates/ddr.c b/board/socrates/ddr.c
index 3a94f7beccd3..bf4894eff671 100644
--- a/board/socrates/ddr.c
+++ b/board/socrates/ddr.c
@@ -3,7 +3,6 @@
  * Copyright 2008 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 
 #include <fsl_ddr_sdram.h>
 #include <fsl_ddr_dimm_params.h>
diff --git a/board/socrates/law.c b/board/socrates/law.c
index e4427ecff1bc..446fdbcaba31 100644
--- a/board/socrates/law.c
+++ b/board/socrates/law.c
@@ -9,7 +9,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/fsl_law.h>
 #include <asm/mmu.h>
 
diff --git a/board/socrates/nand.c b/board/socrates/nand.c
index b1e38c511e5f..517a4a0af6ab 100644
--- a/board/socrates/nand.c
+++ b/board/socrates/nand.c
@@ -4,7 +4,7 @@
  * Sergei Poselenov, Emcraft Systems, sposelenov@emcraft.com.
  */
 
-#include <common.h>
+#include <config.h>
 
 #if defined(CFG_SYS_NAND_BASE)
 #include <nand.h>
diff --git a/board/socrates/sdram.c b/board/socrates/sdram.c
index 61402a554b78..d0415d26ce72 100644
--- a/board/socrates/sdram.c
+++ b/board/socrates/sdram.c
@@ -4,7 +4,7 @@
  * Sergei Poselenov, Emcraft Systems, sposelenov@emcraft.com.
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/processor.h>
 #include <asm/immap_85xx.h>
diff --git a/board/socrates/socrates.c b/board/socrates/socrates.c
index 1d63c81a9c81..6e6e276cc741 100644
--- a/board/socrates/socrates.c
+++ b/board/socrates/socrates.c
@@ -10,7 +10,7 @@
  * (C) Copyright 2002 Scott McNutt <smcnutt@artesyncp.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <env.h>
 #include <init.h>
diff --git a/board/socrates/tlb.c b/board/socrates/tlb.c
index 631f6c340755..0cc675781d16 100644
--- a/board/socrates/tlb.c
+++ b/board/socrates/tlb.c
@@ -9,8 +9,9 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/mmu.h>
+#include <asm/ppc.h>
 
 struct fsl_e_tlb_entry tlb_table[] = {
 	/* TLB 0 - for temp stack in cache */
-- 
2.34.1

