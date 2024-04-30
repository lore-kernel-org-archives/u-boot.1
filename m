Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B0C8C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:41:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D891D88A9C;
	Tue, 30 Apr 2024 15:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l1f1/nkP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7AC6788A7D; Tue, 30 Apr 2024 15:36:42 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F4D288A68
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-78ef9ce897bso394429185a.0
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484198; x=1715088998; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EZYDPqhYExzFhpE/LMLbBNkYNZ+DoOfJtAJltrdy5xE=;
 b=l1f1/nkPYW7CPHQJ0nChonDOvumh8nNt3jzPxAcHMPyM6/5PDLCvgOwJ5h7TyD/D8H
 pfqrX4MQsm39opv+FQSBtuZrlWaF77KY+xdGajfmYImx8S1cPI9JKc0fdQxjAP4/amXG
 Gl0y9BGrTFig6sesGqM3O1FCa/H4CB+up3yl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484198; x=1715088998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EZYDPqhYExzFhpE/LMLbBNkYNZ+DoOfJtAJltrdy5xE=;
 b=kyE8XWKiOuhRI2Z34vg03c3J/UcotHZovBv6UqFXPSUj/zRdIpzhM8bjAlVpDVhbdT
 hdD/hWRqamj86Uv4DDPyW6gOWk/tOXw6YjhsvVlFlEUTScH1mgusMc+F5qBuDpIExDMB
 hk2LlzIILQXLGHTgaUpcO87IO2WsAdmnrf6vTiTfndXiDGXnsrmu42K60DchG8uWv3xh
 cSlfqWOQXQqfRazud2PM9iuP7a/lgX3BbxfUqQBhpMz5wMsPi5v9UOALrq1zVFNbfLga
 CxY354ymhRN3o5u9zJxMnOPN2w7G1BnwN/eHgMV+lS4qUFUozEMDNOXtqkKpEY5uHer6
 MFOw==
X-Gm-Message-State: AOJu0YxVri2btJWUnnYGrsvt7CewKvYRAMk8sRi1c3Fy0cjF/sVbiEHG
 KhR+wEOTwI2oPUH3V6FN21riO7gFf4pIfiHaaafMHcZqT/sDfZ35McJsJNqM2YBO8vwNbZs8XCc
 rd3JedQ==
X-Google-Smtp-Source: AGHT+IFt/+LGW3z98J/QxjbpmeXuluizyWhqkIl/ol0caPcdgPiWakYizdLq4UzifSeC7MJCfmc27g==
X-Received: by 2002:a05:6214:2029:b0:6a0:ada7:1fee with SMTP id
 9-20020a056214202900b006a0ada71feemr3036059qvf.17.1714484197282; 
 Tue, 30 Apr 2024 06:36:37 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.36
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 33/33] arm: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:59 -0600
Message-Id: <20240430133559.1836389-33-trini@konsulko.com>
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

Remove <common.h> from the remainder of the files under arch/arm and
when needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/cpu/arm11/cpu.c                        | 1 -
 arch/arm/cpu/arm720t/interrupts.c               | 2 +-
 arch/arm/cpu/arm920t/cpu.c                      | 1 -
 arch/arm/cpu/arm920t/start.S                    | 1 -
 arch/arm/cpu/arm926ejs/cache.c                  | 1 -
 arch/arm/cpu/arm926ejs/cpu.c                    | 1 -
 arch/arm/cpu/arm926ejs/start.S                  | 1 -
 arch/arm/cpu/arm946es/cpu.c                     | 1 -
 arch/arm/cpu/armv7/arch_timer.c                 | 2 +-
 arch/arm/cpu/armv7/cache_v7.c                   | 1 -
 arch/arm/cpu/armv7/cp15.c                       | 1 -
 arch/arm/cpu/armv7/cpu.c                        | 1 -
 arch/arm/cpu/armv7/exception_level.c            | 1 -
 arch/arm/cpu/armv7/iproc-common/armpll.c        | 1 -
 arch/arm/cpu/armv7/iproc-common/hwinit-common.c | 1 -
 arch/arm/cpu/armv7/iproc-common/timer.c         | 1 -
 arch/arm/cpu/armv7/mpu_v7r.c                    | 1 -
 arch/arm/cpu/armv7/s5p4418/cpu.c                | 1 -
 arch/arm/cpu/armv7/syslib.c                     | 1 -
 arch/arm/cpu/armv7/vf610/generic.c              | 1 -
 arch/arm/cpu/armv7/vf610/timer.c                | 1 -
 arch/arm/cpu/armv7/virt-dt.c                    | 1 -
 arch/arm/cpu/armv7/virt-v7.c                    | 1 -
 arch/arm/cpu/armv7m/cache.c                     | 1 -
 arch/arm/cpu/armv7m/cpu.c                       | 1 -
 arch/arm/cpu/armv7m/systick-timer.c             | 2 +-
 arch/arm/cpu/armv8/cache_v8.c                   | 1 -
 arch/arm/cpu/armv8/cpu-dt.c                     | 1 -
 arch/arm/cpu/armv8/cpu.c                        | 1 -
 arch/arm/cpu/armv8/exception_level.c            | 1 -
 arch/arm/cpu/armv8/generic_timer.c              | 1 -
 arch/arm/cpu/armv8/hisilicon/pinmux.c           | 1 -
 arch/arm/cpu/armv8/sec_firmware.c               | 2 +-
 arch/arm/cpu/armv8/sha1_ce_glue.c               | 1 -
 arch/arm/cpu/armv8/sha256_ce_glue.c             | 1 -
 arch/arm/cpu/armv8/spin_table.c                 | 1 -
 arch/arm/cpu/armv8/spl_data.c                   | 1 -
 arch/arm/include/asm/esr.h                      | 1 +
 arch/arm/lib/asm-offsets.c                      | 1 -
 arch/arm/lib/bdinfo.c                           | 3 ++-
 arch/arm/lib/bootm-fdt.c                        | 1 -
 arch/arm/lib/bootm.c                            | 1 -
 arch/arm/lib/cache-cp15.c                       | 2 +-
 arch/arm/lib/cache-pl310.c                      | 1 -
 arch/arm/lib/cache.c                            | 2 +-
 arch/arm/lib/cmd_boot.c                         | 1 -
 arch/arm/lib/eabi_compat.c                      | 4 +++-
 arch/arm/lib/gic-v3-its.c                       | 1 -
 arch/arm/lib/image.c                            | 1 -
 arch/arm/lib/interrupts.c                       | 1 -
 arch/arm/lib/interrupts_64.c                    | 1 -
 arch/arm/lib/interrupts_m.c                     | 3 ++-
 arch/arm/lib/psci-dt.c                          | 1 -
 arch/arm/lib/reset.c                            | 1 -
 arch/arm/lib/save_prev_bl_data.c                | 1 -
 arch/arm/lib/spl.c                              | 1 -
 arch/arm/lib/stack.c                            | 1 -
 arch/arm/lib/zimage.c                           | 1 -
 58 files changed, 14 insertions(+), 57 deletions(-)

diff --git a/arch/arm/cpu/arm11/cpu.c b/arch/arm/cpu/arm11/cpu.c
index 1e16b89d0066..01d2e1a125d6 100644
--- a/arch/arm/cpu/arm11/cpu.c
+++ b/arch/arm/cpu/arm11/cpu.c
@@ -14,7 +14,6 @@
  * CPU specific code
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/cpu/arm720t/interrupts.c b/arch/arm/cpu/arm720t/interrupts.c
index f0fc58deadba..e3d0216158fe 100644
--- a/arch/arm/cpu/arm720t/interrupts.c
+++ b/arch/arm/cpu/arm720t/interrupts.c
@@ -9,7 +9,7 @@
  * Alex Zuepke <azu@sysgo.de>
  */
 
-#include <common.h>
+#include <linux/types.h>
 
 #if defined(CONFIG_ARCH_TEGRA)
 static ulong timestamp;
diff --git a/arch/arm/cpu/arm920t/cpu.c b/arch/arm/cpu/arm920t/cpu.c
index 305713e78615..61e182305738 100644
--- a/arch/arm/cpu/arm920t/cpu.c
+++ b/arch/arm/cpu/arm920t/cpu.c
@@ -12,7 +12,6 @@
  * CPU specific code
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/cpu/arm920t/start.S b/arch/arm/cpu/arm920t/start.S
index cba4a1f0358f..e792e8e795ef 100644
--- a/arch/arm/cpu/arm920t/start.S
+++ b/arch/arm/cpu/arm920t/start.S
@@ -8,7 +8,6 @@
  */
 
 #include <asm-offsets.h>
-#include <common.h>
 #include <config.h>
 
 /*
diff --git a/arch/arm/cpu/arm926ejs/cache.c b/arch/arm/cpu/arm926ejs/cache.c
index 95963d2665f4..5b87a3af91b2 100644
--- a/arch/arm/cpu/arm926ejs/cache.c
+++ b/arch/arm/cpu/arm926ejs/cache.c
@@ -6,7 +6,6 @@
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <linux/types.h>
-#include <common.h>
 
 #if !CONFIG_IS_ENABLED(SYS_DCACHE_OFF)
 void invalidate_dcache_all(void)
diff --git a/arch/arm/cpu/arm926ejs/cpu.c b/arch/arm/cpu/arm926ejs/cpu.c
index 2ce413a7f866..07ab04b7b08a 100644
--- a/arch/arm/cpu/arm926ejs/cpu.c
+++ b/arch/arm/cpu/arm926ejs/cpu.c
@@ -12,7 +12,6 @@
  * CPU specific code
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/cpu/arm926ejs/start.S b/arch/arm/cpu/arm926ejs/start.S
index c882bd39eab0..5d6c9f0861e1 100644
--- a/arch/arm/cpu/arm926ejs/start.S
+++ b/arch/arm/cpu/arm926ejs/start.S
@@ -16,7 +16,6 @@
 
 #include <asm-offsets.h>
 #include <config.h>
-#include <common.h>
 #include <linux/linkage.h>
 
 /*
diff --git a/arch/arm/cpu/arm946es/cpu.c b/arch/arm/cpu/arm946es/cpu.c
index 334bb5427432..efd232d34237 100644
--- a/arch/arm/cpu/arm946es/cpu.c
+++ b/arch/arm/cpu/arm946es/cpu.c
@@ -12,7 +12,6 @@
  * CPU specific code
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/cpu/armv7/arch_timer.c b/arch/arm/cpu/armv7/arch_timer.c
index 17bd53dae847..f25a8674dea4 100644
--- a/arch/arm/cpu/armv7/arch_timer.c
+++ b/arch/arm/cpu/armv7/arch_timer.c
@@ -4,7 +4,7 @@
  *     Texas Instruments Incorporated, <www.ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/cpu/armv7/cache_v7.c b/arch/arm/cpu/armv7/cache_v7.c
index 19ff4323528b..d11420d2fdd0 100644
--- a/arch/arm/cpu/armv7/cache_v7.c
+++ b/arch/arm/cpu/armv7/cache_v7.c
@@ -7,7 +7,6 @@
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <linux/types.h>
-#include <common.h>
 #include <asm/armv7.h>
 #include <asm/utils.h>
 
diff --git a/arch/arm/cpu/armv7/cp15.c b/arch/arm/cpu/armv7/cp15.c
index 0ac4e7ba8c80..b2c52db68dc9 100644
--- a/arch/arm/cpu/armv7/cp15.c
+++ b/arch/arm/cpu/armv7/cp15.c
@@ -7,7 +7,6 @@
  * CP15 specific code
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/system.h>
 #include <asm/cache.h>
diff --git a/arch/arm/cpu/armv7/cpu.c b/arch/arm/cpu/armv7/cpu.c
index 6259ffa51086..aa981faef001 100644
--- a/arch/arm/cpu/armv7/cpu.c
+++ b/arch/arm/cpu/armv7/cpu.c
@@ -14,7 +14,6 @@
  * CPU specific code
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/cpu/armv7/exception_level.c b/arch/arm/cpu/armv7/exception_level.c
index f6d25bb682c7..7baade61b073 100644
--- a/arch/arm/cpu/armv7/exception_level.c
+++ b/arch/arm/cpu/armv7/exception_level.c
@@ -8,7 +8,6 @@
  * secure mode before booting an operating system.
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <cpu_func.h>
 #include <log.h>
diff --git a/arch/arm/cpu/armv7/iproc-common/armpll.c b/arch/arm/cpu/armv7/iproc-common/armpll.c
index 8c3a323f0654..b345671b0a64 100644
--- a/arch/arm/cpu/armv7/iproc-common/armpll.c
+++ b/arch/arm/cpu/armv7/iproc-common/armpll.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/iproc-common/armpll.h>
 #include <asm/iproc-common/sysmap.h>
diff --git a/arch/arm/cpu/armv7/iproc-common/hwinit-common.c b/arch/arm/cpu/armv7/iproc-common/hwinit-common.c
index 896d2f956942..eca7e8b512b4 100644
--- a/arch/arm/cpu/armv7/iproc-common/hwinit-common.c
+++ b/arch/arm/cpu/armv7/iproc-common/hwinit-common.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
 
diff --git a/arch/arm/cpu/armv7/iproc-common/timer.c b/arch/arm/cpu/armv7/iproc-common/timer.c
index a4255a44c001..b60d90f7e6a3 100644
--- a/arch/arm/cpu/armv7/iproc-common/timer.c
+++ b/arch/arm/cpu/armv7/iproc-common/timer.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Broadcom Corporation.
  */
 
-#include <common.h>
 #include <div64.h>
 #include <init.h>
 #include <time.h>
diff --git a/arch/arm/cpu/armv7/mpu_v7r.c b/arch/arm/cpu/armv7/mpu_v7r.c
index 1d31c63e5fde..2d83e4c721d2 100644
--- a/arch/arm/cpu/armv7/mpu_v7r.c
+++ b/arch/arm/cpu/armv7/mpu_v7r.c
@@ -6,7 +6,6 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <asm/armv7.h>
diff --git a/arch/arm/cpu/armv7/s5p4418/cpu.c b/arch/arm/cpu/armv7/s5p4418/cpu.c
index 8febfe527669..27ffb450378f 100644
--- a/arch/arm/cpu/armv7/s5p4418/cpu.c
+++ b/arch/arm/cpu/armv7/s5p4418/cpu.c
@@ -4,7 +4,6 @@
  * Hyunseok, Jung <hsjung@nexell.co.kr>
  */
 
-#include <common.h>
 #include <command.h>
 #include <asm/system.h>
 #include <asm/cache.h>
diff --git a/arch/arm/cpu/armv7/syslib.c b/arch/arm/cpu/armv7/syslib.c
index 7e29636972d9..f0eda1ca98d0 100644
--- a/arch/arm/cpu/armv7/syslib.c
+++ b/arch/arm/cpu/armv7/syslib.c
@@ -7,7 +7,6 @@
  * Syed Mohammed Khasim <khasim@ti.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 
 /************************************************************
diff --git a/arch/arm/cpu/armv7/vf610/generic.c b/arch/arm/cpu/armv7/vf610/generic.c
index c23ddc12b456..e61ad7b96e90 100644
--- a/arch/arm/cpu/armv7/vf610/generic.c
+++ b/arch/arm/cpu/armv7/vf610/generic.c
@@ -3,7 +3,6 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <command.h>
 #include <cpu_func.h>
diff --git a/arch/arm/cpu/armv7/vf610/timer.c b/arch/arm/cpu/armv7/vf610/timer.c
index a9c1a8fcebc1..7bae0b5574af 100644
--- a/arch/arm/cpu/armv7/vf610/timer.c
+++ b/arch/arm/cpu/armv7/vf610/timer.c
@@ -3,7 +3,6 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/cpu/armv7/virt-dt.c b/arch/arm/cpu/armv7/virt-dt.c
index c0422485ba4e..5dc7ed5e2707 100644
--- a/arch/arm/cpu/armv7/virt-dt.c
+++ b/arch/arm/cpu/armv7/virt-dt.c
@@ -15,7 +15,6 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
-#include <common.h>
 #include <errno.h>
 #include <log.h>
 #include <stdio_dev.h>
diff --git a/arch/arm/cpu/armv7/virt-v7.c b/arch/arm/cpu/armv7/virt-v7.c
index 5ffeca13d913..811499367d40 100644
--- a/arch/arm/cpu/armv7/virt-v7.c
+++ b/arch/arm/cpu/armv7/virt-v7.c
@@ -8,7 +8,6 @@
  * needed to enable ARMv7 virtualization for current hypervisors
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/armv7.h>
 #include <asm/cache.h>
diff --git a/arch/arm/cpu/armv7m/cache.c b/arch/arm/cpu/armv7m/cache.c
index d1aecf6a85cf..b6d08b7aad73 100644
--- a/arch/arm/cpu/armv7m/cache.c
+++ b/arch/arm/cpu/armv7m/cache.c
@@ -4,7 +4,6 @@
  * Author(s): Vikas Manocha, <vikas.manocha@st.com> for STMicroelectronics.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <log.h>
diff --git a/arch/arm/cpu/armv7m/cpu.c b/arch/arm/cpu/armv7m/cpu.c
index 65427b5312be..b4440d3f3f84 100644
--- a/arch/arm/cpu/armv7m/cpu.c
+++ b/arch/arm/cpu/armv7m/cpu.c
@@ -7,7 +7,6 @@
  * Kamil Lulko, <kamil.lulko@gmail.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <irq_func.h>
 #include <asm/io.h>
diff --git a/arch/arm/cpu/armv7m/systick-timer.c b/arch/arm/cpu/armv7m/systick-timer.c
index c30af4ff7a28..d8fa4f0c707a 100644
--- a/arch/arm/cpu/armv7m/systick-timer.c
+++ b/arch/arm/cpu/armv7m/systick-timer.c
@@ -21,7 +21,7 @@
  * using CFG_SYS_HZ_CLOCK.
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/cpu/armv8/cache_v8.c b/arch/arm/cpu/armv8/cache_v8.c
index 57d06f0575dc..d4c64f2d60d9 100644
--- a/arch/arm/cpu/armv8/cache_v8.c
+++ b/arch/arm/cpu/armv8/cache_v8.c
@@ -7,7 +7,6 @@
  * Alexander Graf <agraf@suse.de>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <log.h>
diff --git a/arch/arm/cpu/armv8/cpu-dt.c b/arch/arm/cpu/armv8/cpu-dt.c
index 9bfe3815e51a..97667e607a83 100644
--- a/arch/arm/cpu/armv8/cpu-dt.c
+++ b/arch/arm/cpu/armv8/cpu-dt.c
@@ -3,7 +3,6 @@
  * Copyright 2016 NXP Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/cache.h>
 #include <asm/psci.h>
 #include <asm/system.h>
diff --git a/arch/arm/cpu/armv8/cpu.c b/arch/arm/cpu/armv8/cpu.c
index 3c7f36ad8d89..d568efa427ab 100644
--- a/arch/arm/cpu/armv8/cpu.c
+++ b/arch/arm/cpu/armv8/cpu.c
@@ -10,7 +10,6 @@
  * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/cpu/armv8/exception_level.c b/arch/arm/cpu/armv8/exception_level.c
index b11936548fb3..85c78f55789d 100644
--- a/arch/arm/cpu/armv8/exception_level.c
+++ b/arch/arm/cpu/armv8/exception_level.c
@@ -8,7 +8,6 @@
  * level before booting an operating system.
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <cpu_func.h>
 #include <log.h>
diff --git a/arch/arm/cpu/armv8/generic_timer.c b/arch/arm/cpu/armv8/generic_timer.c
index 8f83372cbca4..e4aa5a474553 100644
--- a/arch/arm/cpu/armv8/generic_timer.c
+++ b/arch/arm/cpu/armv8/generic_timer.c
@@ -4,7 +4,6 @@
  * David Feng <fenghua@phytium.com.cn>
  */
 
-#include <common.h>
 #include <bootstage.h>
 #include <command.h>
 #include <time.h>
diff --git a/arch/arm/cpu/armv8/hisilicon/pinmux.c b/arch/arm/cpu/armv8/hisilicon/pinmux.c
index e14057c0a47c..d7a5a7926102 100644
--- a/arch/arm/cpu/armv8/hisilicon/pinmux.c
+++ b/arch/arm/cpu/armv8/hisilicon/pinmux.c
@@ -4,7 +4,6 @@
  * Peter Griffin <peter.griffin@linaro.org>
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <log.h>
 #include <asm/gpio.h>
diff --git a/arch/arm/cpu/armv8/sec_firmware.c b/arch/arm/cpu/armv8/sec_firmware.c
index c0e8726346f5..44372cbe4a1c 100644
--- a/arch/arm/cpu/armv8/sec_firmware.c
+++ b/arch/arm/cpu/armv8/sec_firmware.c
@@ -3,7 +3,7 @@
  * Copyright 2016 NXP Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <errno.h>
 #include <fdt_support.h>
diff --git a/arch/arm/cpu/armv8/sha1_ce_glue.c b/arch/arm/cpu/armv8/sha1_ce_glue.c
index 780b119a90bf..c88b4dc66e1f 100644
--- a/arch/arm/cpu/armv8/sha1_ce_glue.c
+++ b/arch/arm/cpu/armv8/sha1_ce_glue.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Linaro Ltd <loic.poulain@linaro.org>
  */
 
-#include <common.h>
 #include <u-boot/sha1.h>
 
 extern void sha1_armv8_ce_process(uint32_t state[5], uint8_t const *src,
diff --git a/arch/arm/cpu/armv8/sha256_ce_glue.c b/arch/arm/cpu/armv8/sha256_ce_glue.c
index 67dd796c122d..d5d2b4f4ac7e 100644
--- a/arch/arm/cpu/armv8/sha256_ce_glue.c
+++ b/arch/arm/cpu/armv8/sha256_ce_glue.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2022 Linaro Ltd <loic.poulain@linaro.org>
  */
 
-#include <common.h>
 #include <u-boot/sha256.h>
 
 extern void sha256_armv8_ce_process(uint32_t state[8], uint8_t const *src,
diff --git a/arch/arm/cpu/armv8/spin_table.c b/arch/arm/cpu/armv8/spin_table.c
index 42a0962fdcda..485294b88d0a 100644
--- a/arch/arm/cpu/armv8/spin_table.c
+++ b/arch/arm/cpu/armv8/spin_table.c
@@ -4,7 +4,6 @@
  *   Author: Masahiro Yamada <yamada.masahiro@socionext.com>
  */
 
-#include <common.h>
 #include <linux/libfdt.h>
 #include <asm/spin_table.h>
 
diff --git a/arch/arm/cpu/armv8/spl_data.c b/arch/arm/cpu/armv8/spl_data.c
index 8f1231c86ebb..259b49ff3640 100644
--- a/arch/arm/cpu/armv8/spl_data.c
+++ b/arch/arm/cpu/armv8/spl_data.c
@@ -3,7 +3,6 @@
  * Copyright 2020 NXP
  */
 
-#include <common.h>
 #include <spl.h>
 
 char __data_save_start[0] __section(".__data_save_start");
diff --git a/arch/arm/include/asm/esr.h b/arch/arm/include/asm/esr.h
index f19e4e726a19..99488730998e 100644
--- a/arch/arm/include/asm/esr.h
+++ b/arch/arm/include/asm/esr.h
@@ -7,6 +7,7 @@
 #ifndef __ASM_ESR_H
 #define __ASM_ESR_H
 
+#include <stdbool.h>
 #include <asm/memory.h>
 #include <linux/const.h>
 
diff --git a/arch/arm/lib/asm-offsets.c b/arch/arm/lib/asm-offsets.c
index 181a8ac4c27f..9afd83759996 100644
--- a/arch/arm/lib/asm-offsets.c
+++ b/arch/arm/lib/asm-offsets.c
@@ -16,7 +16,6 @@
  *   Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>
  */
 
-#include <common.h>
 #include <linux/kbuild.h>
 #include <linux/arm-smccc.h>
 
diff --git a/arch/arm/lib/bdinfo.c b/arch/arm/lib/bdinfo.c
index b88b01eefdcd..40255ace4051 100644
--- a/arch/arm/lib/bdinfo.c
+++ b/arch/arm/lib/bdinfo.c
@@ -6,9 +6,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/mach-types.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/lib/bootm-fdt.c b/arch/arm/lib/bootm-fdt.c
index 29020bd1c6bc..2671f9a0ebf5 100644
--- a/arch/arm/lib/bootm-fdt.c
+++ b/arch/arm/lib/bootm-fdt.c
@@ -14,7 +14,6 @@
  * Copyright (C) 2001  Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #ifdef CONFIG_ARMV7_NONSEC
 #include <asm/armv7.h>
diff --git a/arch/arm/lib/bootm.c b/arch/arm/lib/bootm.c
index f30a483ed8b4..192c120a7d2e 100644
--- a/arch/arm/lib/bootm.c
+++ b/arch/arm/lib/bootm.c
@@ -11,7 +11,6 @@
  * Copyright (C) 2001  Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
  */
 
-#include <common.h>
 #include <bootm.h>
 #include <bootstage.h>
 #include <command.h>
diff --git a/arch/arm/lib/cache-cp15.c b/arch/arm/lib/cache-cp15.c
index 0893915b3004..0b2a0c351547 100644
--- a/arch/arm/lib/cache-cp15.c
+++ b/arch/arm/lib/cache-cp15.c
@@ -4,10 +4,10 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/system.h>
 #include <asm/cache.h>
 #include <linux/compiler.h>
diff --git a/arch/arm/lib/cache-pl310.c b/arch/arm/lib/cache-pl310.c
index d05314ee57fc..0afd3880447f 100644
--- a/arch/arm/lib/cache-pl310.c
+++ b/arch/arm/lib/cache-pl310.c
@@ -9,7 +9,6 @@
 #include <asm/armv7.h>
 #include <asm/pl310.h>
 #include <config.h>
-#include <common.h>
 
 struct pl310_regs *const pl310 = (struct pl310_regs *)CFG_SYS_PL310_BASE;
 
diff --git a/arch/arm/lib/cache.c b/arch/arm/lib/cache.c
index 7a1601586711..b2ae74a59f10 100644
--- a/arch/arm/lib/cache.c
+++ b/arch/arm/lib/cache.c
@@ -6,7 +6,7 @@
 
 /* for now: just dummy functions to satisfy the linker */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/arch/arm/lib/cmd_boot.c b/arch/arm/lib/cmd_boot.c
index c905ecc4bd94..5df5bc305a2f 100644
--- a/arch/arm/lib/cmd_boot.c
+++ b/arch/arm/lib/cmd_boot.c
@@ -17,7 +17,6 @@
  * Copyright 2015 Konsulko Group, Matt Porter <mporter@konsulko.com>
  */
 
-#include <common.h>
 #include <command.h>
 
 /*
diff --git a/arch/arm/lib/eabi_compat.c b/arch/arm/lib/eabi_compat.c
index f7029918d4fb..0a96ba1355f8 100644
--- a/arch/arm/lib/eabi_compat.c
+++ b/arch/arm/lib/eabi_compat.c
@@ -5,7 +5,9 @@
  * (C) Copyright 2009 Wolfgang Denk <wd@denx.de>
  */
 
-#include <common.h>
+#include <stdio.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
 
 int raise (int signum)
 {
diff --git a/arch/arm/lib/gic-v3-its.c b/arch/arm/lib/gic-v3-its.c
index f4bbd21da915..2cc0a32f9d47 100644
--- a/arch/arm/lib/gic-v3-its.c
+++ b/arch/arm/lib/gic-v3-its.c
@@ -2,7 +2,6 @@
 /*
  * Copyright 2019 Broadcom.
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <asm/gic.h>
diff --git a/arch/arm/lib/image.c b/arch/arm/lib/image.c
index e394c1ad9093..1f672eee2c86 100644
--- a/arch/arm/lib/image.c
+++ b/arch/arm/lib/image.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <image.h>
 #include <mapmem.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/lib/interrupts.c b/arch/arm/lib/interrupts.c
index 9961472f69f7..333a5026a469 100644
--- a/arch/arm/lib/interrupts.c
+++ b/arch/arm/lib/interrupts.c
@@ -18,7 +18,6 @@
  * Philippe Robin, ARM Ltd. <philippe.robin@arm.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <efi_loader.h>
 #include <irq_func.h>
diff --git a/arch/arm/lib/interrupts_64.c b/arch/arm/lib/interrupts_64.c
index 125dc0bb390b..b3024ba514ec 100644
--- a/arch/arm/lib/interrupts_64.c
+++ b/arch/arm/lib/interrupts_64.c
@@ -4,7 +4,6 @@
  * David Feng <fenghua@phytium.com.cn>
  */
 
-#include <common.h>
 #include <asm/esr.h>
 #include <asm/global_data.h>
 #include <asm/ptrace.h>
diff --git a/arch/arm/lib/interrupts_m.c b/arch/arm/lib/interrupts_m.c
index 277854aa878c..b977961bde8a 100644
--- a/arch/arm/lib/interrupts_m.c
+++ b/arch/arm/lib/interrupts_m.c
@@ -4,9 +4,10 @@
  * Kamil Lulko, <kamil.lulko@gmail.com>
  */
 
-#include <common.h>
+#include <stdio.h>
 #include <cpu_func.h>
 #include <irq_func.h>
+#include <vsprintf.h>
 
 /*
  * Upon exception entry ARMv7-M processors automatically save stack
diff --git a/arch/arm/lib/psci-dt.c b/arch/arm/lib/psci-dt.c
index 903b3357048a..be800a3bc9eb 100644
--- a/arch/arm/lib/psci-dt.c
+++ b/arch/arm/lib/psci-dt.c
@@ -3,7 +3,6 @@
  * Copyright 2016 NXP Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/cache.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
diff --git a/arch/arm/lib/reset.c b/arch/arm/lib/reset.c
index 3e051e36f12d..c9796a4435c6 100644
--- a/arch/arm/lib/reset.c
+++ b/arch/arm/lib/reset.c
@@ -20,7 +20,6 @@
  * (C) Copyright 2004 Texas Insturments
  */
 
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <irq_func.h>
diff --git a/arch/arm/lib/save_prev_bl_data.c b/arch/arm/lib/save_prev_bl_data.c
index b286bac9bf00..4357acaef6c4 100644
--- a/arch/arm/lib/save_prev_bl_data.c
+++ b/arch/arm/lib/save_prev_bl_data.c
@@ -10,7 +10,6 @@
 #include <fdtdec.h>
 #include <fdt_support.h>
 #include <fdt.h>
-#include <common.h>
 #include <linux/errno.h>
 #include <asm/system.h>
 #include <asm/armv8/mmu.h>
diff --git a/arch/arm/lib/spl.c b/arch/arm/lib/spl.c
index b13897495dae..c43a63f1819e 100644
--- a/arch/arm/lib/spl.c
+++ b/arch/arm/lib/spl.c
@@ -7,7 +7,6 @@
  * Tom Rini <trini@ti.com>
  */
 
-#include <common.h>
 #include <config.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/lib/stack.c b/arch/arm/lib/stack.c
index 656084c7e519..ea1b937add76 100644
--- a/arch/arm/lib/stack.c
+++ b/arch/arm/lib/stack.c
@@ -10,7 +10,6 @@
  * Sysgo Real-Time Solutions, GmbH <www.elinos.com>
  * Marius Groeger <mgroeger@sysgo.de>
  */
-#include <common.h>
 #include <init.h>
 #include <lmb.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/lib/zimage.c b/arch/arm/lib/zimage.c
index 45e9c4506a97..51287251b3f6 100644
--- a/arch/arm/lib/zimage.c
+++ b/arch/arm/lib/zimage.c
@@ -6,7 +6,6 @@
  * bootz code:
  * Copyright (C) 2012 Marek Vasut <marek.vasut@gmail.com>
  */
-#include <common.h>
 #include <image.h>
 
 #define	LINUX_ARM_ZIMAGE_MAGIC	0x016f2818
-- 
2.34.1

