Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23502C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 12:08:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D20E087714;
	Mon,  4 Dec 2023 13:07:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="kc3eT2OW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C23987716; Mon,  4 Dec 2023 13:07:36 +0100 (CET)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com
 [IPv6:2a00:1450:4864:20::12c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D01486D37
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 13:07:34 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maxim.uvarov@linaro.org
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-50be58a751cso2277688e87.2
 for <u-boot@lists.denx.de>; Mon, 04 Dec 2023 04:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701691653; x=1702296453; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oENsUKBTA2cWXv9ImzF/gS8Oz06lReZEVUapldDZpOg=;
 b=kc3eT2OWbZ7H0Xop8/B1AH+PB5lGek+C920ZK/Frv6i44efuRosuqT+UckrHemUaFk
 YcvqDzkgwHfEmZqtwdQEissIyJB8ftpuVqY0zGPnEeaA/PvM3c1SeJ0SVIr/Bw3QzmvQ
 +AtQJylAlYYPrP9LFfmQKfBIM9+SBDwzSKJAf/xM2sXWhaKdnLw2S7IT6NBxsqru9ZD1
 Nvf7uaKCykxbm+5NZZNaaHZlcjwnle3cB/U8oX4AbnZg9AaM/eSGFGCV7J9pkuXfeavz
 0BrA0hWMlTHZQe0MewRk8shcdg2U1P651AnhMYIUgN+TwInZ53Ppb58QVIsrFUCgIYZL
 icdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701691653; x=1702296453;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oENsUKBTA2cWXv9ImzF/gS8Oz06lReZEVUapldDZpOg=;
 b=tdKWoKJIVofhXKMQJlo2jRTy8ebuz5CCq6roukmEydTepm44m8pNUjp107wGkwRB9S
 i47E/jRuyRjS66aR3wc9G1949EBsHLnlJlX6TIxxPGbtHHvVqcq/loZsmFl/ctDyvxK3
 4VBn36h7aVqWXtBw0CaD17PLmL5GRkDC5hSfotBB5keVVlmKL4SBqpxh+8ZqSmziohJK
 f/xc7xeCYbjhqDvT4LThZ/xl5alUbPSO6nBnInMSpVNWeoFoOusE2pMvOdqLuuybOUoL
 zn7aV97yOixv3vSKwMgtLtUuJ0uFfB4mlu2KmYnBeEBakLxO1IzWTDwAv0pk8xPER5c0
 5cbA==
X-Gm-Message-State: AOJu0Yy3l5Y3dr6O1JzRbJClifiBoXqPkraSg1aEz13lVLSn5iLucXIF
 FiZ1QdVXIXDza+FPEZDdpijCMQWROr2hkeWPKh2vNQ==
X-Google-Smtp-Source: AGHT+IFUZrdE7eJEq+zgapOrnN0PziwyAvtpkya3fEp8D/7+Vw6AvmHZPO3F+8H7NYizO5eGj0FtoQ==
X-Received: by 2002:a19:7015:0:b0:50b:e750:dd94 with SMTP id
 h21-20020a197015000000b0050be750dd94mr1297050lfc.1.1701691652814; 
 Mon, 04 Dec 2023 04:07:32 -0800 (PST)
Received: from localhost.localdomain ([45.82.14.220])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a0565123ba100b0050befebf0ccsm541675lfv.292.2023.12.04.04.07.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Dec 2023 04:07:32 -0800 (PST)
From: Maxim Uvarov <maxim.uvarov@linaro.org>
To: u-boot@lists.denx.de
Cc: simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 sjg@chromium.org, joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com,
 trini@konsulko.com, Maxim Uvarov <maxim.uvarov@linaro.org>
Subject: [PATHv1 8/9] omap3: rename mem_init
Date: Mon,  4 Dec 2023 18:04:45 +0600
Message-Id: <20231204120446.3277-9-maxim.uvarov@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231204120446.3277-1-maxim.uvarov@linaro.org>
References: <20231204120446.3277-1-maxim.uvarov@linaro.org>
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

Rename mem_init to solve following compilation error with lwip
integrated code:
+arm-linux-gnueabi-ld.bfd: net/lwip/lwip-external/src/core/mem.o: in
  function `mem_init':
+net/lwip/lwip-external/src/core/mem.c:162: multiple definition
  of `mem_init';
  arch/arm/mach-omap2/omap3/sdrc.o:arch/arm/mach-omap2/omap3/
  sdrc.c:240: first defined here
+make[1]: *** [Makefile:1764: u-boot] Error 1
+/opt/gcc-13.1.0-nolibc/arm-linux-gnueabi/bin/../lib/gcc/arm-linux-
  gnueabi/13.1.0/../../
../../arm-linux-gnueabi/bin/ld: net/lwip/lwip-external/src/core/
  mem.o (symbol from
  plugin): in function `mem_init':
+(.text+0x0): multiple definition of `mem_init'; arch/arm/mach-omap2/
  omap3/emif4.o
  (symbol from plugin):(.text+0x0): first defined here
+collect2: error: ld returned 1 exit status
+(.text+0x0): multiple definition of `mem_init'; arch/arm/mach-omap2/
  omap3/sdrc.o
  (symbol from plugin):(.text+0x0): first defined here
+Image 'simple-bin' is missing external blobs and is non-functional:
   tee-os
+/binman/simple-bin/fit/images/op-tee/tee-os (tee-os):

Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
Reviewed-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/arch-omap3/mem.h | 2 +-
 arch/arm/mach-omap2/omap3/board.c     | 2 +-
 arch/arm/mach-omap2/omap3/emif4.c     | 4 ++--
 arch/arm/mach-omap2/omap3/sdrc.c      | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/arch-omap3/mem.h b/arch/arm/include/asm/arch-omap3/mem.h
index 569779c55e..fce3568eca 100644
--- a/arch/arm/include/asm/arch-omap3/mem.h
+++ b/arch/arm/include/asm/arch-omap3/mem.h
@@ -475,7 +475,7 @@ enum {
 #ifndef __ASSEMBLY__
 
 /* Function prototypes */
-void mem_init(void);
+void omap3_mem_init(void);
 
 u32 is_mem_sdr(void);
 u32 mem_ok(u32 cs);
diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
index 8b70251457..c76a95dd5d 100644
--- a/arch/arm/mach-omap2/omap3/board.c
+++ b/arch/arm/mach-omap2/omap3/board.c
@@ -216,7 +216,7 @@ void s_init(void)
 void board_init_f(ulong dummy)
 {
 	early_system_init();
-	mem_init();
+	omap3_mem_init();
 	/*
 	* Save the boot parameters passed from romcode.
 	* We cannot delay the saving further than this,
diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
index 7e5a281922..4fbfb387ab 100644
--- a/arch/arm/mach-omap2/omap3/emif4.c
+++ b/arch/arm/mach-omap2/omap3/emif4.c
@@ -159,10 +159,10 @@ int dram_init_banksize(void)
 }
 
 /*
- * mem_init() -
+ * omap3_mem_init() -
  *  - Initialize memory subsystem
  */
-void mem_init(void)
+void omap3_mem_init(void)
 {
 	do_emif4_init();
 }
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index 5d43e7c9cf..f2a0769b9d 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -4,7 +4,7 @@
  *
  * This file has been created after exctracting and consolidating
  * the SDRC related content from mem.c and board.c, also created
- * generic init function (mem_init).
+ * generic init function (omap3_mem_init).
  *
  * Copyright (C) 2004-2010
  * Texas Instruments Incorporated - https://www.ti.com/
@@ -232,11 +232,11 @@ int dram_init_banksize(void)
 }
 
 /*
- * mem_init -
+ * map3_mem_init -
  *  - Init the sdrc chip,
  *  - Selects CS0 and CS1,
  */
-void mem_init(void)
+void omap3_mem_init(void)
 {
 	/* only init up first bank here */
 	do_sdrc_init(CS0, EARLY_INIT);
-- 
2.30.2

