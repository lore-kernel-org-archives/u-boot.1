Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1F16C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:36:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 357A988518;
	Tue, 30 Apr 2024 15:36:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Nj4tKAMf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1317088A05; Tue, 30 Apr 2024 15:36:09 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 927BD8858A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6ee266e2999so1354738a34.2
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484165; x=1715088965; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfOo8yT3O7KHQlMMngvkNgOgPhiiqKrrrnXq28jOSzM=;
 b=Nj4tKAMf4iyykjNUiFXHhB+KOd7nfSlr92+nZbYqxE7bl4A+kHFZfbx+RR7olqWjAH
 wITb1KdDDY6hFXNNDOjz5LZPbjJWOGZnnX0lcw7LPtlwMUISHN7CtqCnbPxPP7BP2o4g
 D/X+fCrmx0rfV7sTa/o9WHPzE1O3EuncIFX20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484165; x=1715088965;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfOo8yT3O7KHQlMMngvkNgOgPhiiqKrrrnXq28jOSzM=;
 b=uDP1tJ9E4azhSVhFZhjkHWDHxDwGyWZ4ZGy3zK0FmrJZ61OtyaIw0/6WgcZ22VGB1P
 b/yVhyxIoEdfT21pFjE0OINzMXFcCYzgbvnZX0pBHWmQ2vtnfjrAad3cy1Dt+7tOSnjD
 Jv/x8crSJxRUvwWQg3a+gEyCK0UH25qPO+PZBVCptf4Nemevp0ECkbHcb28HSfmNq6NZ
 OpQY57uYkJ96mKRLFtpF072LVFXuMi4FQ80k8INAbsKyK1iml5K5DznQMS0cp8LBKRpZ
 Mo7PZd2PucGNL9RLT2tLqTpyfl2daVDKUS4IHdqUlvml1Au6OVSu4oTgcZoicqJru4jZ
 GrMA==
X-Gm-Message-State: AOJu0YyIjnpPA8HliYNTOiRZE6iqEKkMurWBWO8js4NOyqYQxYc2OYKu
 rM2J8muA1DpgtmNiviF4WAUhhl3oVSX0+KdlxagzMiNyM8gCI0r3txqKbSV320DTDys6t2uXjPt
 XL+aWAQ==
X-Google-Smtp-Source: AGHT+IGpV9ODinw3v5JHAdctyTXjtmnsypPBbhcjh9x8qnBl2qgh2t7PBGPhxIgL7DCnB8JHzA59Jg==
X-Received: by 2002:a05:6870:c354:b0:22d:fc00:9580 with SMTP id
 e20-20020a056870c35400b0022dfc009580mr15766608oak.16.1714484164920; 
 Tue, 30 Apr 2024 06:36:04 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:04 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH 03/33] arm: xilinx: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:29 -0600
Message-Id: <20240430133559.1836389-3-trini@konsulko.com>
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

Remove <common.h> from all mach-versal-net, mach-versal, mach-zynq and
mach-zynqmp files and when needed add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
---
 arch/arm/mach-versal-net/clk.c                 | 2 +-
 arch/arm/mach-versal-net/cpu.c                 | 2 +-
 arch/arm/mach-versal/clk.c                     | 2 +-
 arch/arm/mach-versal/cpu.c                     | 2 +-
 arch/arm/mach-versal/mp.c                      | 3 ++-
 arch/arm/mach-zynq/clk.c                       | 1 -
 arch/arm/mach-zynq/cpu.c                       | 3 ++-
 arch/arm/mach-zynq/ddrc.c                      | 2 +-
 arch/arm/mach-zynq/slcr.c                      | 1 -
 arch/arm/mach-zynq/spl.c                       | 1 -
 arch/arm/mach-zynqmp-r5/cpu.c                  | 1 -
 arch/arm/mach-zynqmp/aes.c                     | 3 +--
 arch/arm/mach-zynqmp/clk.c                     | 2 +-
 arch/arm/mach-zynqmp/cpu.c                     | 4 +++-
 arch/arm/mach-zynqmp/ecc_spl_init.c            | 1 -
 arch/arm/mach-zynqmp/handoff.c                 | 1 -
 arch/arm/mach-zynqmp/include/mach/zynqmp_aes.h | 2 ++
 arch/arm/mach-zynqmp/mp.c                      | 4 +++-
 arch/arm/mach-zynqmp/psu_spl_init.c            | 1 -
 arch/arm/mach-zynqmp/spl.c                     | 1 -
 20 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mach-versal-net/clk.c b/arch/arm/mach-versal-net/clk.c
index d097de7afa63..a88b5101eb1b 100644
--- a/arch/arm/mach-versal-net/clk.c
+++ b/arch/arm/mach-versal-net/clk.c
@@ -6,10 +6,10 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index a82741e70fc8..59b0cb2e78f3 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -6,11 +6,11 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-versal/clk.c b/arch/arm/mach-versal/clk.c
index 5e3f44c77822..0c7d468f1dd0 100644
--- a/arch/arm/mach-versal/clk.c
+++ b/arch/arm/mach-versal/clk.c
@@ -4,10 +4,10 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index e4dc305d9288..7de431e55005 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -4,11 +4,11 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-versal/mp.c b/arch/arm/mach-versal/mp.c
index 2487b482ddb1..921ca49c3596 100644
--- a/arch/arm/mach-versal/mp.c
+++ b/arch/arm/mach-versal/mp.c
@@ -4,7 +4,8 @@
  * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>
  */
 
-#include <common.h>
+#include <config.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-zynq/clk.c b/arch/arm/mach-zynq/clk.c
index 5e1ba8d43ed1..c1b018cf22e9 100644
--- a/arch/arm/mach-zynq/clk.c
+++ b/arch/arm/mach-zynq/clk.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2013 Xilinx, Inc. All rights reserved.
  */
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <init.h>
 #include <malloc.h>
diff --git a/arch/arm/mach-zynq/cpu.c b/arch/arm/mach-zynq/cpu.c
index 3b6518c71c90..c75e453d5730 100644
--- a/arch/arm/mach-zynq/cpu.c
+++ b/arch/arm/mach-zynq/cpu.c
@@ -3,10 +3,11 @@
  * Copyright (C) 2012 Michal Simek <monstr@monstr.eu>
  * Copyright (C) 2012 Xilinx, Inc. All rights reserved.
  */
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <zynqpl.h>
+#include <linux/errno.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <asm/arch/clk.h>
diff --git a/arch/arm/mach-zynq/ddrc.c b/arch/arm/mach-zynq/ddrc.c
index 28988ef95b5a..b9a2eef5a6f0 100644
--- a/arch/arm/mach-zynq/ddrc.c
+++ b/arch/arm/mach-zynq/ddrc.c
@@ -4,7 +4,7 @@
  * Copyright (C) 2012 - 2017 Xilinx, Inc. All rights reserved.
  */
 
-#include <common.h>
+#include <linux/string.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-zynq/slcr.c b/arch/arm/mach-zynq/slcr.c
index 5d9f4d23f34b..ef877df0fe85 100644
--- a/arch/arm/mach-zynq/slcr.c
+++ b/arch/arm/mach-zynq/slcr.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2013 - 2017 Xilinx Inc.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <malloc.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-zynq/spl.c b/arch/arm/mach-zynq/spl.c
index fea1c9b12ad1..8ef12ed65ceb 100644
--- a/arch/arm/mach-zynq/spl.c
+++ b/arch/arm/mach-zynq/spl.c
@@ -2,7 +2,6 @@
 /*
  * (C) Copyright 2014 - 2017 Xilinx, Inc. Michal Simek
  */
-#include <common.h>
 #include <debug_uart.h>
 #include <hang.h>
 #include <image.h>
diff --git a/arch/arm/mach-zynqmp-r5/cpu.c b/arch/arm/mach-zynqmp-r5/cpu.c
index 0d368443d824..9a912dd5bd7c 100644
--- a/arch/arm/mach-zynqmp-r5/cpu.c
+++ b/arch/arm/mach-zynqmp-r5/cpu.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2018 Xilinx, Inc. (Michal Simek)
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/armv7_mpu.h>
diff --git a/arch/arm/mach-zynqmp/aes.c b/arch/arm/mach-zynqmp/aes.c
index 8a2b7fdcbe9f..9a05fbf9c11b 100644
--- a/arch/arm/mach-zynqmp/aes.c
+++ b/arch/arm/mach-zynqmp/aes.c
@@ -7,9 +7,8 @@
  * Christian Taedcke <christian.taedcke@weidmueller.com>
  */
 
-#include <common.h>
 #include <mach/zynqmp_aes.h>
-
+#include <linux/errno.h>
 #include <asm/arch/sys_proto.h>
 #include <cpu_func.h>
 #include <memalign.h>
diff --git a/arch/arm/mach-zynqmp/clk.c b/arch/arm/mach-zynqmp/clk.c
index 3b05f8455bf5..dc8e2cbd3da4 100644
--- a/arch/arm/mach-zynqmp/clk.c
+++ b/arch/arm/mach-zynqmp/clk.c
@@ -4,13 +4,13 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/arch/clk.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index 6ae27894ecd9..d7b5e99504c4 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -4,14 +4,16 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
diff --git a/arch/arm/mach-zynqmp/ecc_spl_init.c b/arch/arm/mach-zynqmp/ecc_spl_init.c
index f547d8e3a5bf..1eef10789514 100644
--- a/arch/arm/mach-zynqmp/ecc_spl_init.c
+++ b/arch/arm/mach-zynqmp/ecc_spl_init.c
@@ -5,7 +5,6 @@
  *  Jorge Ramirez-Ortiz <jorge@foundries.io>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/ecc_spl_init.h>
diff --git a/arch/arm/mach-zynqmp/handoff.c b/arch/arm/mach-zynqmp/handoff.c
index dce92438926e..b007307e1f36 100644
--- a/arch/arm/mach-zynqmp/handoff.c
+++ b/arch/arm/mach-zynqmp/handoff.c
@@ -5,7 +5,6 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-zynqmp/include/mach/zynqmp_aes.h b/arch/arm/mach-zynqmp/include/mach/zynqmp_aes.h
index 2a9cffbd0f80..01a13d4c7c06 100644
--- a/arch/arm/mach-zynqmp/include/mach/zynqmp_aes.h
+++ b/arch/arm/mach-zynqmp/include/mach/zynqmp_aes.h
@@ -9,6 +9,8 @@
 #ifndef ZYNQMP_AES_H
 #define ZYNQMP_AES_H
 
+#include <linux/types.h>
+
 struct zynqmp_aes {
 	u64 srcaddr;
 	u64 ivaddr;
diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
index aff9054212c5..9b46a25a1cbe 100644
--- a/arch/arm/mach-zynqmp/mp.c
+++ b/arch/arm/mach-zynqmp/mp.c
@@ -4,14 +4,16 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <vsprintf.h>
 #include <zynqmp_firmware.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/io.h>
 #include <linux/delay.h>
+#include <linux/string.h>
 
 #define LOCK		0
 #define SPLIT		1
diff --git a/arch/arm/mach-zynqmp/psu_spl_init.c b/arch/arm/mach-zynqmp/psu_spl_init.c
index b4d7f44bbeee..5b4d66359bfb 100644
--- a/arch/arm/mach-zynqmp/psu_spl_init.c
+++ b/arch/arm/mach-zynqmp/psu_spl_init.c
@@ -4,7 +4,6 @@
  *
  * Michal Simek <michal.simek@amd.com>
  */
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/psu_init_gpl.h>
 #include <linux/delay.h>
diff --git a/arch/arm/mach-zynqmp/spl.c b/arch/arm/mach-zynqmp/spl.c
index 979ff3aef6c2..6b67245f348c 100644
--- a/arch/arm/mach-zynqmp/spl.c
+++ b/arch/arm/mach-zynqmp/spl.c
@@ -5,7 +5,6 @@
  * Michal Simek <michal.simek@amd.com>
  */
 
-#include <common.h>
 #include <image.h>
 #include <init.h>
 #include <log.h>
-- 
2.34.1

