Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E758C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:39:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D317288A5B;
	Tue, 30 Apr 2024 15:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="apl5fDrh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EAF388A45; Tue, 30 Apr 2024 15:36:23 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60FF2889A2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ee266e2999so1354987a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484180; x=1715088980; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLOgOaoT+JgOFYh+ZFFMBiLLbGNfY7PGKxvYu/Y76G0=;
 b=apl5fDrhva9q/KRG66SdoABQkOtdHqJNq/rxqgjEuRH0hgtv0/i/7xUXhWD5l6fZ6t
 lNYjzkbmov71Pesiiuc1pVaRatZpbla9++aC9p8b9ZBrF7W39HFZMw/Hqx04qtV5qHK+
 OjUjoQWAdE5J97uM2IybypMsfT7e6DkW2pSyI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484180; x=1715088980;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLOgOaoT+JgOFYh+ZFFMBiLLbGNfY7PGKxvYu/Y76G0=;
 b=MQH0MChLYNcz9ArhboEG++6l8wqwlzdir4GatKc1zRa73jFU+DxHfSv6qKK0IertY9
 xtEsbv+Mv6dCx7wVpDD661ZYcDbWqMPt21fOvK35+cUxO18jQZr18W1bt/3vuSDgEl/q
 pUmuh3wRcRCs3S+NQY8YUD+EVeSH5V558ImJ2YBc/AbQORWjZrGwOHCL+DONq6FflZ5R
 V26mpyHH4mW+3i/vQiBElV7XKXnCpPqruZhAnX3M0ljzNJaBAVsDH9ZBPHiJWDvHrB5T
 VPf4DZ1Z3kgoM6oilpezPtMAPVnPaZm0+5KriDM4P1SVcv1K4fMLmXNbJLQFE1AIP2Cp
 yp6g==
X-Gm-Message-State: AOJu0Yyl11JPTzLqw96xhVvn6X+UB8BFQKTeHDmA27saN/ZgyKgg+ThA
 tvhBG1MOux9Z+07PEPA2GDJ0ZHRumkYSow5McS63iS+J2EHJJCw8ty35XEZ3V5p63JIAwm4Nr0w
 xOsUSnw==
X-Google-Smtp-Source: AGHT+IFdXUBV17B9dzO0Jku+DOFb09Ba5Aq4RFJXyoEh3o1WMouORYApx3nctUJMtwq1aMffSQgOjw==
X-Received: by 2002:a05:6830:1290:b0:6ee:3596:ea1a with SMTP id
 z16-20020a056830129000b006ee3596ea1amr6855350otp.31.1714484179798; 
 Tue, 30 Apr 2024 06:36:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:19 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Jim Liu <jim.t90615@gmail.com>
Subject: [PATCH 16/33] arm: npcm: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:42 -0600
Message-Id: <20240430133559.1836389-16-trini@konsulko.com>
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

Remove <common.h> from all mach-npcm files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Jim Liu <jim.t90615@gmail.com>
---
 arch/arm/mach-npcm/npcm7xx/cpu.c            | 1 -
 arch/arm/mach-npcm/npcm7xx/l2_cache_pl310.c | 2 +-
 arch/arm/mach-npcm/npcm8xx/cpu.c            | 1 -
 arch/arm/mach-npcm/npcm8xx/reset.c          | 1 -
 4 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mach-npcm/npcm7xx/cpu.c b/arch/arm/mach-npcm/npcm7xx/cpu.c
index dd74bb9e0871..47d51cab5c76 100644
--- a/arch/arm/mach-npcm/npcm7xx/cpu.c
+++ b/arch/arm/mach-npcm/npcm7xx/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2021 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/armv7.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-npcm/npcm7xx/l2_cache_pl310.c b/arch/arm/mach-npcm/npcm7xx/l2_cache_pl310.c
index ed4b1ca5c983..df80687c8571 100644
--- a/arch/arm/mach-npcm/npcm7xx/l2_cache_pl310.c
+++ b/arch/arm/mach-npcm/npcm7xx/l2_cache_pl310.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2021 Nuvoton Technology Corp.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/pl310.h>
 
diff --git a/arch/arm/mach-npcm/npcm8xx/cpu.c b/arch/arm/mach-npcm/npcm8xx/cpu.c
index af594526094c..a1fb400b2645 100644
--- a/arch/arm/mach-npcm/npcm8xx/cpu.c
+++ b/arch/arm/mach-npcm/npcm8xx/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <dm.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-npcm/npcm8xx/reset.c b/arch/arm/mach-npcm/npcm8xx/reset.c
index 6954e6c6a17f..e28b4ae7ae4b 100644
--- a/arch/arm/mach-npcm/npcm8xx/reset.c
+++ b/arch/arm/mach-npcm/npcm8xx/reset.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2022 Nuvoton Technology Corp.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/gcr.h>
 #include <asm/arch/rst.h>
-- 
2.34.1

