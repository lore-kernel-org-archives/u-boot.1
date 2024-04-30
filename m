Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C456C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:37:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E73B88A26;
	Tue, 30 Apr 2024 15:36:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="orrRfPXS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AB9AC88A21; Tue, 30 Apr 2024 15:36:12 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D446D8824A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6ea2375d8d0so4593036a34.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484168; x=1715088968; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SxA0ufmC6/+GhB8OOlRoLFVUV1MQwMjw2XWr4vHcm28=;
 b=orrRfPXSdHvireW04UmTVoDI8xIzq7hRWERiqVuYTE6VINJE+GmtYH9xxei13cl/TT
 4JvwWPxUmL/vJ+s0M+si13IICnQAmGBVrPTsHv6DYD594xkalZ+nTf1SSwvzAX18NUsI
 Dj8UtzO5/S7+JLR28kO3+lWISnJiS/PM3KAS4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484168; x=1715088968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SxA0ufmC6/+GhB8OOlRoLFVUV1MQwMjw2XWr4vHcm28=;
 b=BIEGGspHkBmSJtHedf4Jrg3JpL1nZdTWRHUbXrzuiyEfZCfWaYCQazGR185G7SfA5y
 8VpaXj7JWN9iGKsLlRRxEixANtb4rqorIvnvRzdb1aKgsfaAsZXOuwgk1fl/DYaoZuVX
 8YdcPnLvnwsx9MhRpLLufvHFHdxSGE57e2JR+9JbLW7zoWoD2yFX6eJjnhSeg5YV9osu
 jNJEi84zTjsvg8cflqCbcEPWNUnvJLyrWV2acY2vdetLC/EPTgYkkvdQGYLscfZCGO4t
 l8xn5vBzm3jbTu6chkL+DHzZ0wY1r6Trhn+8CVQfi5zlFaYFXSlrON0ouDT0lkKZ7o+o
 8Kew==
X-Gm-Message-State: AOJu0YyqdiURQ2AeXLl2mb1ukOXd7tpD+n5vP9j+AhdV+3OclcejMkoY
 MBWyVdh/zf77tKNcpje/wEYt1bbtVxIikU5Gj7Dd43LoeZ3jqkx+REDflbJvCA2Fe/pW33JI+VR
 9emHNMQ==
X-Google-Smtp-Source: AGHT+IEbmgOTTHDMER/yz07gKOQDeIzrSsBtsx3i/VR+3tNnajYZ4bo9VCVbmU10Kb7BPvm+MjHnpA==
X-Received: by 2002:a05:6808:1241:b0:3c5:e901:e3ec with SMTP id
 o1-20020a056808124100b003c5e901e3ecmr17000973oiv.16.1714484168071; 
 Tue, 30 Apr 2024 06:36:08 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:06 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Thierry Reding <treding@nvidia.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: [PATCH 05/33] arm: tegra: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:31 -0600
Message-Id: <20240430133559.1836389-5-trini@konsulko.com>
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

Remove <common.h> from all mach-tegra and include/asm/arch-tegra files
and when needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Thierry Reding <treding@nvidia.com>
Cc: Svyatoslav Ryhel <clamor95@gmail.com>
---
 arch/arm/include/asm/arch-tegra/ap.h       | 1 +
 arch/arm/include/asm/arch-tegra/cboot.h    | 2 ++
 arch/arm/mach-tegra/ap.c                   | 2 +-
 arch/arm/mach-tegra/arm64-mmu.c            | 1 -
 arch/arm/mach-tegra/board.c                | 2 +-
 arch/arm/mach-tegra/board2.c               | 2 +-
 arch/arm/mach-tegra/cache.c                | 1 -
 arch/arm/mach-tegra/cboot.c                | 1 -
 arch/arm/mach-tegra/clock.c                | 1 -
 arch/arm/mach-tegra/cmd_enterrcm.c         | 1 -
 arch/arm/mach-tegra/cpu.c                  | 1 -
 arch/arm/mach-tegra/crypto.c               | 1 -
 arch/arm/mach-tegra/dt-setup.c             | 1 -
 arch/arm/mach-tegra/emc.c                  | 1 -
 arch/arm/mach-tegra/fuse.c                 | 1 -
 arch/arm/mach-tegra/gpu.c                  | 1 -
 arch/arm/mach-tegra/ivc.c                  | 2 +-
 arch/arm/mach-tegra/pmc.c                  | 1 -
 arch/arm/mach-tegra/powergate.c            | 2 +-
 arch/arm/mach-tegra/spl.c                  | 1 -
 arch/arm/mach-tegra/sys_info.c             | 1 -
 arch/arm/mach-tegra/tegra114/clock.c       | 1 -
 arch/arm/mach-tegra/tegra114/cpu.c         | 1 -
 arch/arm/mach-tegra/tegra124/clock.c       | 2 +-
 arch/arm/mach-tegra/tegra124/cpu.c         | 1 -
 arch/arm/mach-tegra/tegra124/pmc.c         | 1 -
 arch/arm/mach-tegra/tegra124/psci.c        | 1 -
 arch/arm/mach-tegra/tegra124/xusb-padctl.c | 2 +-
 arch/arm/mach-tegra/tegra20/bct.c          | 1 -
 arch/arm/mach-tegra/tegra20/clock.c        | 1 -
 arch/arm/mach-tegra/tegra20/cpu.c          | 1 -
 arch/arm/mach-tegra/tegra20/display.c      | 1 -
 arch/arm/mach-tegra/tegra20/emc.c          | 2 +-
 arch/arm/mach-tegra/tegra20/pmu.c          | 1 -
 arch/arm/mach-tegra/tegra20/warmboot.c     | 1 -
 arch/arm/mach-tegra/tegra20/warmboot_avp.c | 2 +-
 arch/arm/mach-tegra/tegra210/clock.c       | 2 +-
 arch/arm/mach-tegra/tegra210/xusb-padctl.c | 2 +-
 arch/arm/mach-tegra/tegra30/bct.c          | 2 +-
 arch/arm/mach-tegra/tegra30/clock.c        | 1 -
 arch/arm/mach-tegra/tegra30/cpu.c          | 1 -
 arch/arm/mach-tegra/xusb-padctl-common.c   | 1 -
 arch/arm/mach-tegra/xusb-padctl-dummy.c    | 2 +-
 43 files changed, 16 insertions(+), 41 deletions(-)

diff --git a/arch/arm/include/asm/arch-tegra/ap.h b/arch/arm/include/asm/arch-tegra/ap.h
index 78aeb25ac78e..b922b2d30ea0 100644
--- a/arch/arm/include/asm/arch-tegra/ap.h
+++ b/arch/arm/include/asm/arch-tegra/ap.h
@@ -4,6 +4,7 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 #include <asm/types.h>
+#include <asm/arch-tegra/tegra.h>
 
 /* Stabilization delays, in usec */
 #define PLL_STABILIZATION_DELAY	(300)
diff --git a/arch/arm/include/asm/arch-tegra/cboot.h b/arch/arm/include/asm/arch-tegra/cboot.h
index 4e1da98d1f21..d0ba83ae8bc8 100644
--- a/arch/arm/include/asm/arch-tegra/cboot.h
+++ b/arch/arm/include/asm/arch-tegra/cboot.h
@@ -6,6 +6,8 @@
 #ifndef _TEGRA_CBOOT_H_
 #define _TEGRA_CBOOT_H_
 
+#include <linux/errno.h>
+#include <linux/types.h>
 #include <net.h>
 
 #ifdef CONFIG_ARM64
diff --git a/arch/arm/mach-tegra/ap.c b/arch/arm/mach-tegra/ap.c
index 532730fe7270..1ea620e4ab59 100644
--- a/arch/arm/mach-tegra/ap.c
+++ b/arch/arm/mach-tegra/ap.c
@@ -6,7 +6,7 @@
 
 /* Tegra AP (Application Processor) code */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <linux/bug.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-tegra/arm64-mmu.c b/arch/arm/mach-tegra/arm64-mmu.c
index ea4eac392d96..4fbe47a91e1e 100644
--- a/arch/arm/mach-tegra/arm64-mmu.c
+++ b/arch/arm/mach-tegra/arm64-mmu.c
@@ -7,7 +7,6 @@
  * Copyright (c) 2015, NVIDIA CORPORATION. All rights reserved.
  */
 
-#include <common.h>
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
 
diff --git a/arch/arm/mach-tegra/board.c b/arch/arm/mach-tegra/board.c
index 327d70bd4cc0..c382e0428603 100644
--- a/arch/arm/mach-tegra/board.c
+++ b/arch/arm/mach-tegra/board.c
@@ -4,7 +4,7 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <init.h>
diff --git a/arch/arm/mach-tegra/board2.c b/arch/arm/mach-tegra/board2.c
index adea12c9b7f9..479137e457cb 100644
--- a/arch/arm/mach-tegra/board2.c
+++ b/arch/arm/mach-tegra/board2.c
@@ -4,7 +4,7 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <env.h>
 #include <errno.h>
diff --git a/arch/arm/mach-tegra/cache.c b/arch/arm/mach-tegra/cache.c
index d7063490e222..462364abf038 100644
--- a/arch/arm/mach-tegra/cache.c
+++ b/arch/arm/mach-tegra/cache.c
@@ -5,7 +5,6 @@
 
 /* Tegra cache routines */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/ap.h>
 #if IS_ENABLED(CONFIG_TEGRA_GP_PADCTRL)
diff --git a/arch/arm/mach-tegra/cboot.c b/arch/arm/mach-tegra/cboot.c
index 8f5bb2f261a9..c12543d71ac0 100644
--- a/arch/arm/mach-tegra/cboot.c
+++ b/arch/arm/mach-tegra/cboot.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2016-2018, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <env.h>
 #include <fdt_support.h>
 #include <fdtdec.h>
diff --git a/arch/arm/mach-tegra/clock.c b/arch/arm/mach-tegra/clock.c
index 575da2bdb5a2..157e6c4911a4 100644
--- a/arch/arm/mach-tegra/clock.c
+++ b/arch/arm/mach-tegra/clock.c
@@ -5,7 +5,6 @@
 
 /* Tegra SoC common clock control functions */
 
-#include <common.h>
 #include <div64.h>
 #include <dm.h>
 #include <errno.h>
diff --git a/arch/arm/mach-tegra/cmd_enterrcm.c b/arch/arm/mach-tegra/cmd_enterrcm.c
index 92ff6cb1bf86..8fa1207e97a8 100644
--- a/arch/arm/mach-tegra/cmd_enterrcm.c
+++ b/arch/arm/mach-tegra/cmd_enterrcm.c
@@ -24,7 +24,6 @@
  * (C) Copyright 2004 Texas Insturments
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/mach-tegra/cpu.c b/arch/arm/mach-tegra/cpu.c
index 59ca8aeabac7..5f2a59171024 100644
--- a/arch/arm/mach-tegra/cpu.c
+++ b/arch/arm/mach-tegra/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010-2019, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-tegra/crypto.c b/arch/arm/mach-tegra/crypto.c
index 893da35e0b9d..49e6a45243ad 100644
--- a/arch/arm/mach-tegra/crypto.c
+++ b/arch/arm/mach-tegra/crypto.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2010 - 2011 NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/errno.h>
 #include <asm/arch-tegra/crypto.h>
diff --git a/arch/arm/mach-tegra/dt-setup.c b/arch/arm/mach-tegra/dt-setup.c
index c11494722bc7..f4ae602d5239 100644
--- a/arch/arm/mach-tegra/dt-setup.c
+++ b/arch/arm/mach-tegra/dt-setup.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010-2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <stdlib.h>
 #include <asm/arch-tegra/cboot.h>
diff --git a/arch/arm/mach-tegra/emc.c b/arch/arm/mach-tegra/emc.c
index 2eea14b5a744..83fad35d4dcc 100644
--- a/arch/arm/mach-tegra/emc.c
+++ b/arch/arm/mach-tegra/emc.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include "emc.h"
 #include <asm/io.h>
diff --git a/arch/arm/mach-tegra/fuse.c b/arch/arm/mach-tegra/fuse.c
index 83bd50553841..e9b5259ac701 100644
--- a/arch/arm/mach-tegra/fuse.c
+++ b/arch/arm/mach-tegra/fuse.c
@@ -7,7 +7,6 @@
  *  Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <linux/delay.h>
 #include <asm/io.h>
 
diff --git a/arch/arm/mach-tegra/gpu.c b/arch/arm/mach-tegra/gpu.c
index 36538e7f96ad..23381759b797 100644
--- a/arch/arm/mach-tegra/gpu.c
+++ b/arch/arm/mach-tegra/gpu.c
@@ -5,7 +5,6 @@
 
 /* Tegra vpr routines */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch/tegra.h>
diff --git a/arch/arm/mach-tegra/ivc.c b/arch/arm/mach-tegra/ivc.c
index 66c1276f4b87..0445d5d48e5c 100644
--- a/arch/arm/mach-tegra/ivc.c
+++ b/arch/arm/mach-tegra/ivc.c
@@ -3,11 +3,11 @@
  * Copyright (c) 2016, NVIDIA CORPORATION.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/io.h>
 #include <asm/arch-tegra/ivc.h>
 #include <linux/bug.h>
+#include <linux/errno.h>
 #include <linux/printk.h>
 
 #define TEGRA_IVC_ALIGN 64
diff --git a/arch/arm/mach-tegra/pmc.c b/arch/arm/mach-tegra/pmc.c
index c4f5106750b8..3f968d4aeae8 100644
--- a/arch/arm/mach-tegra/pmc.c
+++ b/arch/arm/mach-tegra/pmc.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2018-2019, NVIDIA CORPORATION. All rights reserved.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-tegra/powergate.c b/arch/arm/mach-tegra/powergate.c
index 631bc04e9506..2a2f8467216e 100644
--- a/arch/arm/mach-tegra/powergate.c
+++ b/arch/arm/mach-tegra/powergate.c
@@ -3,8 +3,8 @@
  * Copyright (c) 2014-2019, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <errno.h>
+#include <time.h>
 #include <linux/delay.h>
 
 #include <asm/io.h>
diff --git a/arch/arm/mach-tegra/spl.c b/arch/arm/mach-tegra/spl.c
index ed897efc5f07..5df0eb28c96f 100644
--- a/arch/arm/mach-tegra/spl.c
+++ b/arch/arm/mach-tegra/spl.c
@@ -5,7 +5,6 @@
  *
  * Allen Martin <amartin@nvidia.com>
  */
-#include <common.h>
 #include <debug_uart.h>
 #include <log.h>
 #include <spl.h>
diff --git a/arch/arm/mach-tegra/sys_info.c b/arch/arm/mach-tegra/sys_info.c
index 5ad586ac17fb..11b404802466 100644
--- a/arch/arm/mach-tegra/sys_info.c
+++ b/arch/arm/mach-tegra/sys_info.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <linux/ctype.h>
 #if defined(CONFIG_TEGRA124) || defined(CONFIG_TEGRA30)
diff --git a/arch/arm/mach-tegra/tegra114/clock.c b/arch/arm/mach-tegra/tegra114/clock.c
index 2ee755bc649c..d5cc8ac44dde 100644
--- a/arch/arm/mach-tegra/tegra114/clock.c
+++ b/arch/arm/mach-tegra/tegra114/clock.c
@@ -6,7 +6,6 @@
 
 /* Tegra114 Clock control functions */
 
-#include <common.h>
 #include <init.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-tegra/tegra114/cpu.c b/arch/arm/mach-tegra/tegra114/cpu.c
index 7d8f080c310c..3fe2d2d73246 100644
--- a/arch/arm/mach-tegra/tegra114/cpu.c
+++ b/arch/arm/mach-tegra/tegra114/cpu.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-tegra/tegra124/clock.c b/arch/arm/mach-tegra/tegra124/clock.c
index ed8b6d963816..4ac0c10c597d 100644
--- a/arch/arm/mach-tegra/tegra124/clock.c
+++ b/arch/arm/mach-tegra/tegra124/clock.c
@@ -6,7 +6,7 @@
 
 /* Tegra124 Clock control functions */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-tegra/tegra124/cpu.c b/arch/arm/mach-tegra/tegra124/cpu.c
index b1bfe8fb5e13..07892aedd3cb 100644
--- a/arch/arm/mach-tegra/tegra124/cpu.c
+++ b/arch/arm/mach-tegra/tegra124/cpu.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch/ahb.h>
diff --git a/arch/arm/mach-tegra/tegra124/pmc.c b/arch/arm/mach-tegra/tegra124/pmc.c
index 3921ffb52af4..2294911501e7 100644
--- a/arch/arm/mach-tegra/tegra124/pmc.c
+++ b/arch/arm/mach-tegra/tegra124/pmc.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2017 Google, Inc
  */
 
-#include <common.h>
 #include <dm.h>
 #include <syscon.h>
 
diff --git a/arch/arm/mach-tegra/tegra124/psci.c b/arch/arm/mach-tegra/tegra124/psci.c
index ab102a622611..a50b681935aa 100644
--- a/arch/arm/mach-tegra/tegra124/psci.c
+++ b/arch/arm/mach-tegra/tegra124/psci.c
@@ -4,7 +4,6 @@
  * Author: Jan Kiszka <jan.kiszka@siemens.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/psci.h>
 #include <asm/arch/flow.h>
diff --git a/arch/arm/mach-tegra/tegra124/xusb-padctl.c b/arch/arm/mach-tegra/tegra124/xusb-padctl.c
index 69736aa39255..1153444267d3 100644
--- a/arch/arm/mach-tegra/tegra124/xusb-padctl.c
+++ b/arch/arm/mach-tegra/tegra124/xusb-padctl.c
@@ -5,9 +5,9 @@
 
 #define pr_fmt(fmt) "tegra-xusb-padctl: " fmt
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <dm/of_access.h>
 #include <dm/ofnode.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-tegra/tegra20/bct.c b/arch/arm/mach-tegra/tegra20/bct.c
index b2c44f3d237c..e155b98cf655 100644
--- a/arch/arm/mach-tegra/tegra20/bct.c
+++ b/arch/arm/mach-tegra/tegra20/bct.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2022, Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
 #include <asm/arch-tegra/crypto.h>
diff --git a/arch/arm/mach-tegra/tegra20/clock.c b/arch/arm/mach-tegra/tegra20/clock.c
index 109b73bfbe7f..6af20e9c782b 100644
--- a/arch/arm/mach-tegra/tegra20/clock.c
+++ b/arch/arm/mach-tegra/tegra20/clock.c
@@ -7,7 +7,6 @@
 
 /* Tegra20 Clock control functions */
 
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-tegra/tegra20/cpu.c b/arch/arm/mach-tegra/tegra20/cpu.c
index e5b60598f7f7..1ba3930b5e6e 100644
--- a/arch/arm/mach-tegra/tegra20/cpu.c
+++ b/arch/arm/mach-tegra/tegra20/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010-2012, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/tegra.h>
 #include <asm/arch-tegra/pmc.h>
diff --git a/arch/arm/mach-tegra/tegra20/display.c b/arch/arm/mach-tegra/tegra20/display.c
index 4ba3fb23fd63..207e50aac905 100644
--- a/arch/arm/mach-tegra/tegra20/display.c
+++ b/arch/arm/mach-tegra/tegra20/display.c
@@ -4,7 +4,6 @@
  *  NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/tegra.h>
diff --git a/arch/arm/mach-tegra/tegra20/emc.c b/arch/arm/mach-tegra/tegra20/emc.c
index fb5e699c940d..e2ee8f124ac7 100644
--- a/arch/arm/mach-tegra/tegra20/emc.c
+++ b/arch/arm/mach-tegra/tegra20/emc.c
@@ -3,7 +3,7 @@
  * Copyright (c) 2011 The Chromium OS Authors.
  */
 
-#include <common.h>
+#include <config.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-tegra/tegra20/pmu.c b/arch/arm/mach-tegra/tegra20/pmu.c
index 05d0668cdbaa..f2fe5d0fa9dc 100644
--- a/arch/arm/mach-tegra/tegra20/pmu.c
+++ b/arch/arm/mach-tegra/tegra20/pmu.c
@@ -4,7 +4,6 @@
  * (C) Copyright 2010,2011 NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <i2c.h>
 #include <log.h>
 #include <tps6586x.h>
diff --git a/arch/arm/mach-tegra/tegra20/warmboot.c b/arch/arm/mach-tegra/tegra20/warmboot.c
index 5e3a9ebaceb3..18034c83a1c2 100644
--- a/arch/arm/mach-tegra/tegra20/warmboot.c
+++ b/arch/arm/mach-tegra/tegra20/warmboot.c
@@ -4,7 +4,6 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/errno.h>
diff --git a/arch/arm/mach-tegra/tegra20/warmboot_avp.c b/arch/arm/mach-tegra/tegra20/warmboot_avp.c
index 94ce762e01f5..65bbe1825356 100644
--- a/arch/arm/mach-tegra/tegra20/warmboot_avp.c
+++ b/arch/arm/mach-tegra/tegra20/warmboot_avp.c
@@ -4,7 +4,7 @@
  * NVIDIA Corporation <www.nvidia.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/flow.h>
diff --git a/arch/arm/mach-tegra/tegra210/clock.c b/arch/arm/mach-tegra/tegra210/clock.c
index 74817e0440b8..57ff0b2a19af 100644
--- a/arch/arm/mach-tegra/tegra210/clock.c
+++ b/arch/arm/mach-tegra/tegra210/clock.c
@@ -6,10 +6,10 @@
 
 /* Tegra210 Clock control functions */
 
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <log.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-tegra/tegra210/xusb-padctl.c b/arch/arm/mach-tegra/tegra210/xusb-padctl.c
index 30d0395bb0e5..e409c2842e24 100644
--- a/arch/arm/mach-tegra/tegra210/xusb-padctl.c
+++ b/arch/arm/mach-tegra/tegra210/xusb-padctl.c
@@ -5,9 +5,9 @@
 
 #define pr_fmt(fmt) "tegra-xusb-padctl: " fmt
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
+#include <time.h>
 #include <asm/global_data.h>
 #include <dm/of_access.h>
 #include <dm/ofnode.h>
diff --git a/arch/arm/mach-tegra/tegra30/bct.c b/arch/arm/mach-tegra/tegra30/bct.c
index cff1a3e98d27..250009ea8d8e 100644
--- a/arch/arm/mach-tegra/tegra30/bct.c
+++ b/arch/arm/mach-tegra/tegra30/bct.c
@@ -4,9 +4,9 @@
  * Copyright (c) 2022, Svyatoslav Ryhel <clamor95@gmail.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <log.h>
+#include <vsprintf.h>
 #include <asm/arch-tegra/crypto.h>
 #include "bct.h"
 #include "uboot_aes.h"
diff --git a/arch/arm/mach-tegra/tegra30/clock.c b/arch/arm/mach-tegra/tegra30/clock.c
index 0af8cde8c64d..7d61127920be 100644
--- a/arch/arm/mach-tegra/tegra30/clock.c
+++ b/arch/arm/mach-tegra/tegra30/clock.c
@@ -6,7 +6,6 @@
 
 /* Tegra30 Clock control functions */
 
-#include <common.h>
 #include <errno.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-tegra/tegra30/cpu.c b/arch/arm/mach-tegra/tegra30/cpu.c
index 60bbf13ea525..51a9deab1fda 100644
--- a/arch/arm/mach-tegra/tegra30/cpu.c
+++ b/arch/arm/mach-tegra/tegra30/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2010-2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-tegra/xusb-padctl-common.c b/arch/arm/mach-tegra/xusb-padctl-common.c
index 28fdebe50a33..a3515d903a69 100644
--- a/arch/arm/mach-tegra/xusb-padctl-common.c
+++ b/arch/arm/mach-tegra/xusb-padctl-common.c
@@ -5,7 +5,6 @@
 
 #define pr_fmt(fmt) "tegra-xusb-padctl: " fmt
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <linux/printk.h>
diff --git a/arch/arm/mach-tegra/xusb-padctl-dummy.c b/arch/arm/mach-tegra/xusb-padctl-dummy.c
index f2d90302f6d2..1345b80747e8 100644
--- a/arch/arm/mach-tegra/xusb-padctl-dummy.c
+++ b/arch/arm/mach-tegra/xusb-padctl-dummy.c
@@ -3,9 +3,9 @@
  * Copyright (c) 2014, NVIDIA CORPORATION.  All rights reserved.
  */
 
-#include <common.h>
 #include <errno.h>
 
+#include <linux/compiler.h>
 #include <asm/arch-tegra/xusb-padctl.h>
 
 struct tegra_xusb_phy * __weak tegra_xusb_phy_get(unsigned int type)
-- 
2.34.1

