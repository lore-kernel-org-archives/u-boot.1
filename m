Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA0BBC4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5D74F88A53;
	Tue, 30 Apr 2024 15:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="evcQIF/v";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF25888A5E; Tue, 30 Apr 2024 15:36:33 +0200 (CEST)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6D5CD88A47
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6969388c36fso23446756d6.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484190; x=1715088990; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pLA9MwhLPee5Elt4Grm5CObP0hj+PdQS+V2HWtgEyLI=;
 b=evcQIF/vmKexKDsLbBi1hGf8aEWRWI9fxTLm4u9yHL72KRk220TOMf39wxDrZHdxgJ
 LhluDxO0yAVm4/E+rZfh7wZXuobB8jz+1ZX8SnCR0Cn2b8lu4TuXNiSrlMBm2gUTQvAM
 pdS0fgZQj6UilhysZajc0GXY5fpwPTVXXXmgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484190; x=1715088990;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pLA9MwhLPee5Elt4Grm5CObP0hj+PdQS+V2HWtgEyLI=;
 b=Oq712vKyM6Irhu92OhVswthQZaAOPlKaQOCIa1snwge2mi7D6IGfbBszDxMr8De2SS
 itEOICEGTyJ5mEULEmscIvoE5Je1QndB0jzfTHI/q1RcqyNpLHxNvLMGKy21tJGAQFdu
 6GwWFPufOwDIFZ95Ay3PHtEVys8Dj9F7ksFoW68a4xHe0IHdoqcScFDmXoLQTfUBV3ph
 kF5+VdNp0sgfnxwEhXpbdhVAn8z+ZPH1W1UH+4yEUPvgEQVAFhHci9FJSWO9JPHrtb7R
 aOj7ZNJt0f+nj+QjmRQYMQ7g55kUjvBNH2KJREhmDKhyV37M4h2KafSPoYCY7aO9Eb8f
 G5Ew==
X-Gm-Message-State: AOJu0YxrjA5duVGnCP0fsvNn3dWrV1LQJk7tqjQ1MPlrmzs3dDdEqA58
 NE9FlBXk+DtnntahIjaXOggXGy/TuMCdYg/pmh92MBoZ+0kaVHZSFvQj+Em1EdaGY+vWkcV+Lk5
 mn/ZTNA==
X-Google-Smtp-Source: AGHT+IGdDKGOf62dFR40GRd1yQDUZI8DhLqjnq8gjXFrqtyRO9DLdjhYUgSC6ZckfyRdSCOF4sMB2w==
X-Received: by 2002:a05:6214:1c08:b0:6a0:a9dc:b117 with SMTP id
 u8-20020a0562141c0800b006a0a9dcb117mr2705640qvc.0.1714484190160; 
 Tue, 30 Apr 2024 06:36:30 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:29 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>
Subject: [PATCH 26/33] arm: exynos: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:52 -0600
Message-Id: <20240430133559.1836389-26-trini@konsulko.com>
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

Remove <common.h> from all mach-exynos files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Minkyu Kang <mk7.kang@samsung.com>
---
 arch/arm/mach-exynos/clock.c              | 3 ++-
 arch/arm/mach-exynos/clock_init_exynos4.c | 1 -
 arch/arm/mach-exynos/clock_init_exynos5.c | 1 -
 arch/arm/mach-exynos/common_setup.h       | 2 ++
 arch/arm/mach-exynos/dmc_common.c         | 2 +-
 arch/arm/mach-exynos/dmc_init_ddr3.c      | 1 -
 arch/arm/mach-exynos/exynos5_setup.h      | 1 +
 arch/arm/mach-exynos/include/mach/power.h | 2 ++
 arch/arm/mach-exynos/lowlevel_init.c      | 1 -
 arch/arm/mach-exynos/mmu-arm64.c          | 1 -
 arch/arm/mach-exynos/pinmux.c             | 1 -
 arch/arm/mach-exynos/power.c              | 2 +-
 arch/arm/mach-exynos/soc.c                | 1 -
 arch/arm/mach-exynos/spl_boot.c           | 1 -
 arch/arm/mach-exynos/system.c             | 2 +-
 arch/arm/mach-exynos/tzpc.c               | 2 +-
 16 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-exynos/clock.c b/arch/arm/mach-exynos/clock.c
index f91f2ee862de..ee71b95237df 100644
--- a/arch/arm/mach-exynos/clock.c
+++ b/arch/arm/mach-exynos/clock.c
@@ -4,9 +4,10 @@
  * Minkyu Kang <mk7.kang@samsung.com>
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <log.h>
+#include <time.h>
+#include <mach/cpu.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-exynos/clock_init_exynos4.c b/arch/arm/mach-exynos/clock_init_exynos4.c
index 584e4bac09fc..95ed1956a077 100644
--- a/arch/arm/mach-exynos/clock_init_exynos4.c
+++ b/arch/arm/mach-exynos/clock_init_exynos4.c
@@ -23,7 +23,6 @@
  * MA 02111-1307 USA
  */
 
-#include <common.h>
 #include <config.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-exynos/clock_init_exynos5.c b/arch/arm/mach-exynos/clock_init_exynos5.c
index 1cb8d391e7c9..232a2482dc65 100644
--- a/arch/arm/mach-exynos/clock_init_exynos5.c
+++ b/arch/arm/mach-exynos/clock_init_exynos5.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2012 Samsung Electronics
  */
 
-#include <common.h>
 #include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-exynos/common_setup.h b/arch/arm/mach-exynos/common_setup.h
index d7f02231fdfa..4f56160ee50a 100644
--- a/arch/arm/mach-exynos/common_setup.h
+++ b/arch/arm/mach-exynos/common_setup.h
@@ -23,6 +23,8 @@
  * MA 02111-1307 USA
  */
 
+#include <linux/types.h>
+#include <mach/cpu.h>
 #include <asm/arch/system.h>
 
 #define DMC_OFFSET	0x10000
diff --git a/arch/arm/mach-exynos/dmc_common.c b/arch/arm/mach-exynos/dmc_common.c
index 44923dd5520f..a96ded443b9a 100644
--- a/arch/arm/mach-exynos/dmc_common.c
+++ b/arch/arm/mach-exynos/dmc_common.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2012 Samsung Electronics
  */
 
-#include <common.h>
+#include <linux/types.h>
 #include <asm/arch/spl.h>
 
 #include "clock_init.h"
diff --git a/arch/arm/mach-exynos/dmc_init_ddr3.c b/arch/arm/mach-exynos/dmc_init_ddr3.c
index cad8ccc5315f..193de4c3a595 100644
--- a/arch/arm/mach-exynos/dmc_init_ddr3.c
+++ b/arch/arm/mach-exynos/dmc_init_ddr3.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2012 Samsung Electronics
  */
 
-#include <common.h>
 #include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-exynos/exynos5_setup.h b/arch/arm/mach-exynos/exynos5_setup.h
index e9874a8c1b24..4e508edba0c6 100644
--- a/arch/arm/mach-exynos/exynos5_setup.h
+++ b/arch/arm/mach-exynos/exynos5_setup.h
@@ -8,6 +8,7 @@
 #ifndef _SMDK5250_SETUP_H
 #define _SMDK5250_SETUP_H
 
+#include <linux/types.h>
 #include <asm/arch/dmc.h>
 
 #define NOT_AVAILABLE		0
diff --git a/arch/arm/mach-exynos/include/mach/power.h b/arch/arm/mach-exynos/include/mach/power.h
index a3d8974dcb5b..757e1586bde4 100644
--- a/arch/arm/mach-exynos/include/mach/power.h
+++ b/arch/arm/mach-exynos/include/mach/power.h
@@ -8,6 +8,8 @@
 #define __ASM_ARM_ARCH_POWER_H_
 
 #ifndef __ASSEMBLY__
+#include <linux/types.h>
+
 struct exynos4_power {
 	unsigned int	om_stat;
 	unsigned char	res1[0x8];
diff --git a/arch/arm/mach-exynos/lowlevel_init.c b/arch/arm/mach-exynos/lowlevel_init.c
index c57b8aee7989..0967ab995a93 100644
--- a/arch/arm/mach-exynos/lowlevel_init.c
+++ b/arch/arm/mach-exynos/lowlevel_init.c
@@ -23,7 +23,6 @@
  * MA 02111-1307 USA
  */
 
-#include <common.h>
 #include <config.h>
 #include <debug_uart.h>
 #include <asm/system.h>
diff --git a/arch/arm/mach-exynos/mmu-arm64.c b/arch/arm/mach-exynos/mmu-arm64.c
index 30e522804fbf..e2f32547adfc 100644
--- a/arch/arm/mach-exynos/mmu-arm64.c
+++ b/arch/arm/mach-exynos/mmu-arm64.c
@@ -4,7 +4,6 @@
  * Thomas Abraham <thomas.ab@samsung.com>
  */
 
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <linux/sizes.h>
 
diff --git a/arch/arm/mach-exynos/pinmux.c b/arch/arm/mach-exynos/pinmux.c
index ad3fbf2da7a8..4061dd4aafae 100644
--- a/arch/arm/mach-exynos/pinmux.c
+++ b/arch/arm/mach-exynos/pinmux.c
@@ -4,7 +4,6 @@
  * Abhilash Kesavan <a.kesavan@samsung.com>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/gpio.h>
diff --git a/arch/arm/mach-exynos/power.c b/arch/arm/mach-exynos/power.c
index f2a6c00dd629..599d3ccff603 100644
--- a/arch/arm/mach-exynos/power.c
+++ b/arch/arm/mach-exynos/power.c
@@ -4,7 +4,7 @@
  * Donghwa Lee <dh09.lee@samsung.com>
  */
 
-#include <common.h>
+#include <mach/cpu.h>
 #include <asm/io.h>
 #include <asm/arch/power.h>
 
diff --git a/arch/arm/mach-exynos/soc.c b/arch/arm/mach-exynos/soc.c
index aff2b5e1b6e8..be18f181a7aa 100644
--- a/arch/arm/mach-exynos/soc.c
+++ b/arch/arm/mach-exynos/soc.c
@@ -4,7 +4,6 @@
  * Minkyu Kang <mk7.kang@samsung.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-exynos/spl_boot.c b/arch/arm/mach-exynos/spl_boot.c
index 553dac75b61d..bd5a06447b9c 100644
--- a/arch/arm/mach-exynos/spl_boot.c
+++ b/arch/arm/mach-exynos/spl_boot.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2012 Samsung Electronics
  */
 
-#include <common.h>
 #include <config.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-exynos/system.c b/arch/arm/mach-exynos/system.c
index 12d0d8fd34a6..f5090613c0d8 100644
--- a/arch/arm/mach-exynos/system.c
+++ b/arch/arm/mach-exynos/system.c
@@ -4,7 +4,7 @@
  * Donghwa Lee <dh09.lee@samsung.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/system.h>
 
diff --git a/arch/arm/mach-exynos/tzpc.c b/arch/arm/mach-exynos/tzpc.c
index abe8e7f45898..320a0cf35136 100644
--- a/arch/arm/mach-exynos/tzpc.c
+++ b/arch/arm/mach-exynos/tzpc.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2012 Samsung Electronics
  */
 
-#include <common.h>
+#include <mach/cpu.h>
 #include <asm/arch/tzpc.h>
 #include <asm/io.h>
 
-- 
2.34.1

