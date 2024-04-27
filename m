Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E064C4345F
	for <u-boot@archiver.kernel.org>; Sat, 27 Apr 2024 14:12:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8CC34883FE;
	Sat, 27 Apr 2024 16:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rQH5uCVr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1EAAD88480; Sat, 27 Apr 2024 16:11:28 +0200 (CEST)
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com
 [IPv6:2607:f8b0:4864:20::735])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7E8588438
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 16:11:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x735.google.com with SMTP id
 af79cd13be357-790e7c02430so8704785a.0
 for <u-boot@lists.denx.de>; Sat, 27 Apr 2024 07:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714227082; x=1714831882; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SkoWyCju3OyWgkt65qDWATiZcCgo3DD1aFO4E1reCMw=;
 b=rQH5uCVrDdgHAolf02V9p1DYi0hbjQ6T5hXxH0u4NA3bAmMp3XIHcTb9dPJMFdPjDK
 MPxbj+G0igX6rM1Y8y6z9nlemXM0TSyDro1+cPRtitm/QP2ZsCZJQILgykeHRM5WYNpB
 bTFrdn5o3WEpQ1Wj6MAfKTOG4JUQ3VsPgarWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714227082; x=1714831882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SkoWyCju3OyWgkt65qDWATiZcCgo3DD1aFO4E1reCMw=;
 b=N3tM3ZOOkbz4pk603sjOGXF+NcHXxTHqR1nbv9MrnlUVYCi/xOnI3Dk/whOQgIZVLZ
 xx0uh3wMttv4NnPBVPK86JenfSaByINzV0cObeZbzRuBKOecQiSkb3nzGLb+WTfdi1sK
 GLQj60ZcoSNmWgIjpga1zTw+ayRm9/cb4OInjEUAAVviXb98ZQqluJMt/Yn1mQSAB1bO
 sfPIggF6CrIs5wsQmTU3zh7IYSlBhTCINTo0XZtlEY1t0AZooK41OlRu7zeTr2qRQNrU
 W4SwAxzPJ3a8ddwXcfSfIt4ep71CDtDQN/oYAJ/lIUm7e2H49pzZ7sLCiRNlDfDIsSNE
 poLQ==
X-Gm-Message-State: AOJu0Yycc5M/v4Owebh6JMAnZKrYBmRUd1y5zyDL2+NAhcpplq7kbRxR
 R1G7X3LPPDuxnfKJSskcazI/GDq2nSWl9Wi426IVt0pd9XsxSZkZtwXBDEsNlAPRtclaWcVwVSS
 +M9vwxg==
X-Google-Smtp-Source: AGHT+IHKRKeGL8VmHGXTYH/FNIoJmC3c6GUKIcpjRSFEMlBYJD5JEiYurhqeTANVcrC6JpSODeB7+w==
X-Received: by 2002:a05:620a:3622:b0:78c:c56b:f63a with SMTP id
 da34-20020a05620a362200b0078cc56bf63amr6005790qkb.13.1714227081683; 
 Sat, 27 Apr 2024 07:11:21 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a05620a112300b0078ed3667cb8sm8829760qkk.124.2024.04.27.07.11.20
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Apr 2024 07:11:21 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 09/18] powerpc: Remove <common.h> and add needed includes
Date: Sat, 27 Apr 2024 08:10:57 -0600
Message-Id: <20240427141106.3406000-10-trini@konsulko.com>
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

Remove <common.h> from all powerpc architecture files and when needed add
missing include files directly. This typically involves using
<asm/u-boot.h> instead due to the difficult nested structure of the
PowerPC includes themselves.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/powerpc/cpu/mpc83xx/cpu.c                 | 1 -
 arch/powerpc/cpu/mpc83xx/ecc.c                 | 1 -
 arch/powerpc/cpu/mpc83xx/fdt.c                 | 1 -
 arch/powerpc/cpu/mpc83xx/interrupts.c          | 2 +-
 arch/powerpc/cpu/mpc83xx/law.c                 | 1 -
 arch/powerpc/cpu/mpc83xx/pci.c                 | 1 -
 arch/powerpc/cpu/mpc83xx/pcie.c                | 2 +-
 arch/powerpc/cpu/mpc83xx/qe_io.c               | 1 -
 arch/powerpc/cpu/mpc83xx/serdes.c              | 1 -
 arch/powerpc/cpu/mpc83xx/spd_sdram.c           | 2 +-
 arch/powerpc/cpu/mpc83xx/speed.c               | 2 +-
 arch/powerpc/cpu/mpc83xx/spl_minimal.c         | 2 +-
 arch/powerpc/cpu/mpc83xx/traps.c               | 1 -
 arch/powerpc/cpu/mpc85xx/b4860_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/b4860_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c      | 1 -
 arch/powerpc/cpu/mpc85xx/c29x_serdes.c         | 1 -
 arch/powerpc/cpu/mpc85xx/cmd_errata.c          | 2 +-
 arch/powerpc/cpu/mpc85xx/cpu.c                 | 1 -
 arch/powerpc/cpu/mpc85xx/cpu_init_early.c      | 3 ++-
 arch/powerpc/cpu/mpc85xx/fdt.c                 | 2 +-
 arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c | 2 +-
 arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c  | 2 +-
 arch/powerpc/cpu/mpc85xx/interrupts.c          | 2 +-
 arch/powerpc/cpu/mpc85xx/liodn.c               | 2 +-
 arch/powerpc/cpu/mpc85xx/mp.c                  | 2 +-
 arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c      | 1 -
 arch/powerpc/cpu/mpc85xx/mpc8544_serdes.c      | 1 -
 arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c      | 1 -
 arch/powerpc/cpu/mpc85xx/p1010_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/p1021_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/p1023_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/p2020_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/p2041_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/p2041_serdes.c        | 2 +-
 arch/powerpc/cpu/mpc85xx/p3041_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/p3041_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/p4080_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/p4080_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/p5040_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/p5040_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/portals.c             | 1 -
 arch/powerpc/cpu/mpc85xx/qe_io.c               | 2 +-
 arch/powerpc/cpu/mpc85xx/speed.c               | 2 +-
 arch/powerpc/cpu/mpc85xx/spl_minimal.c         | 2 +-
 arch/powerpc/cpu/mpc85xx/t1024_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/t1024_serdes.c        | 2 +-
 arch/powerpc/cpu/mpc85xx/t1040_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/t1040_serdes.c        | 2 +-
 arch/powerpc/cpu/mpc85xx/t2080_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/t2080_serdes.c        | 2 +-
 arch/powerpc/cpu/mpc85xx/t4240_ids.c           | 2 +-
 arch/powerpc/cpu/mpc85xx/t4240_serdes.c        | 2 +-
 arch/powerpc/cpu/mpc85xx/tlb.c                 | 2 +-
 arch/powerpc/cpu/mpc85xx/traps.c               | 2 +-
 arch/powerpc/cpu/mpc8xxx/cpu.c                 | 1 -
 arch/powerpc/cpu/mpc8xxx/fdt.c                 | 1 -
 arch/powerpc/cpu/mpc8xxx/fsl_lbc.c             | 2 +-
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c            | 2 +-
 arch/powerpc/cpu/mpc8xxx/law.c                 | 2 +-
 arch/powerpc/cpu/mpc8xxx/pamu_table.c          | 2 +-
 arch/powerpc/cpu/mpc8xxx/srio.c                | 3 +--
 arch/powerpc/include/asm/cache.h               | 2 ++
 arch/powerpc/include/asm/fsl_dma.h             | 2 +-
 arch/powerpc/include/asm/fsl_serdes.h          | 1 +
 arch/powerpc/include/asm/immap_8xx.h           | 2 ++
 arch/powerpc/lib/bdinfo.c                      | 2 +-
 arch/powerpc/lib/bootm.c                       | 2 +-
 arch/powerpc/lib/cache.c                       | 1 -
 arch/powerpc/lib/extable.c                     | 1 -
 arch/powerpc/lib/interrupts.c                  | 2 +-
 arch/powerpc/lib/kgdb.c                        | 1 -
 arch/powerpc/lib/spl.c                         | 1 -
 arch/powerpc/lib/stack.c                       | 1 -
 arch/powerpc/lib/time.c                        | 1 -
 include/fsl_immap.h                            | 3 +++
 76 files changed, 50 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/cpu/mpc83xx/cpu.c b/arch/powerpc/cpu/mpc83xx/cpu.c
index f6ffe295b8ed..e0be938ea982 100644
--- a/arch/powerpc/cpu/mpc83xx/cpu.c
+++ b/arch/powerpc/cpu/mpc83xx/cpu.c
@@ -9,7 +9,6 @@
  * Derived from the MPC8260 and MPC85xx.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <irq_func.h>
 #include <net.h>
diff --git a/arch/powerpc/cpu/mpc83xx/ecc.c b/arch/powerpc/cpu/mpc83xx/ecc.c
index 3e24752e2f6c..9ab5ea313d3a 100644
--- a/arch/powerpc/cpu/mpc83xx/ecc.c
+++ b/arch/powerpc/cpu/mpc83xx/ecc.c
@@ -6,7 +6,6 @@
  * based on the contribution of Marian Balakowicz <m8@semihalf.com>
  */
 
-#include <common.h>
 #include <irq_func.h>
 #include <mpc83xx.h>
 #include <command.h>
diff --git a/arch/powerpc/cpu/mpc83xx/fdt.c b/arch/powerpc/cpu/mpc83xx/fdt.c
index 33b2151f878c..1bd4f2b3449d 100644
--- a/arch/powerpc/cpu/mpc83xx/fdt.c
+++ b/arch/powerpc/cpu/mpc83xx/fdt.c
@@ -6,7 +6,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <linux/libfdt.h>
diff --git a/arch/powerpc/cpu/mpc83xx/interrupts.c b/arch/powerpc/cpu/mpc83xx/interrupts.c
index f9486678af33..6238eec605f2 100644
--- a/arch/powerpc/cpu/mpc83xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc83xx/interrupts.c
@@ -6,7 +6,7 @@
  * Copyright 2004 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <command.h>
 #include <irq_func.h>
 #include <mpc83xx.h>
diff --git a/arch/powerpc/cpu/mpc83xx/law.c b/arch/powerpc/cpu/mpc83xx/law.c
index 5e02f4094bb1..ae60be9e8774 100644
--- a/arch/powerpc/cpu/mpc83xx/law.c
+++ b/arch/powerpc/cpu/mpc83xx/law.c
@@ -3,7 +3,6 @@
  * Copyright 2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/fsl_law.h>
 #include <asm/mmu.h>
diff --git a/arch/powerpc/cpu/mpc83xx/pci.c b/arch/powerpc/cpu/mpc83xx/pci.c
index 65ef0497c2a1..6f378c4e221f 100644
--- a/arch/powerpc/cpu/mpc83xx/pci.c
+++ b/arch/powerpc/cpu/mpc83xx/pci.c
@@ -6,7 +6,6 @@
  * with some bits from older board-specific PCI initialization.
  */
 
-#include <common.h>
 #include <init.h>
 #include <pci.h>
 #include <asm/bitops.h>
diff --git a/arch/powerpc/cpu/mpc83xx/pcie.c b/arch/powerpc/cpu/mpc83xx/pcie.c
index 47ca74c5c356..feecf8a8193c 100644
--- a/arch/powerpc/cpu/mpc83xx/pcie.c
+++ b/arch/powerpc/cpu/mpc83xx/pcie.c
@@ -7,7 +7,7 @@
  *          Anton Vorontsov <avorontsov@ru.mvista.com>
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <clock_legacy.h>
 #include <pci.h>
 #include <mpc83xx.h>
diff --git a/arch/powerpc/cpu/mpc83xx/qe_io.c b/arch/powerpc/cpu/mpc83xx/qe_io.c
index 52360703a7da..256dbfe8a4bb 100644
--- a/arch/powerpc/cpu/mpc83xx/qe_io.c
+++ b/arch/powerpc/cpu/mpc83xx/qe_io.c
@@ -6,7 +6,6 @@
  * based on source code of Shlomi Gridish
  */
 
-#include <common.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/immap_83xx.h>
diff --git a/arch/powerpc/cpu/mpc83xx/serdes.c b/arch/powerpc/cpu/mpc83xx/serdes.c
index d4848b2ec4d5..d3ca24422a59 100644
--- a/arch/powerpc/cpu/mpc83xx/serdes.c
+++ b/arch/powerpc/cpu/mpc83xx/serdes.c
@@ -9,7 +9,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <asm/io.h>
 #include <asm/fsl_mpc83xx_serdes.h>
 #include <linux/delay.h>
diff --git a/arch/powerpc/cpu/mpc83xx/spd_sdram.c b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
index 6da8fc4381d1..37234e00abd0 100644
--- a/arch/powerpc/cpu/mpc83xx/spd_sdram.c
+++ b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
@@ -12,7 +12,7 @@
 
 #ifndef CONFIG_MPC83XX_SDRAM
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <time.h>
diff --git a/arch/powerpc/cpu/mpc83xx/speed.c b/arch/powerpc/cpu/mpc83xx/speed.c
index b7a87fec2f5b..bfc624232179 100644
--- a/arch/powerpc/cpu/mpc83xx/speed.c
+++ b/arch/powerpc/cpu/mpc83xx/speed.c
@@ -8,7 +8,7 @@
 
 #ifndef CONFIG_CLK_MPC83XX
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <clock_legacy.h>
 #include <mpc83xx.h>
 #include <command.h>
diff --git a/arch/powerpc/cpu/mpc83xx/spl_minimal.c b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
index b55bfaffcaed..7036e3fae0c8 100644
--- a/arch/powerpc/cpu/mpc83xx/spl_minimal.c
+++ b/arch/powerpc/cpu/mpc83xx/spl_minimal.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2004-2008 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm-offsets.h>
 #include <clock_legacy.h>
 #include <mpc83xx.h>
diff --git a/arch/powerpc/cpu/mpc83xx/traps.c b/arch/powerpc/cpu/mpc83xx/traps.c
index 94e6323d7365..79ea1a9bb3c9 100644
--- a/arch/powerpc/cpu/mpc83xx/traps.c
+++ b/arch/powerpc/cpu/mpc83xx/traps.c
@@ -11,7 +11,6 @@
  * exceptions
  */
 
-#include <common.h>
 #include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <command.h>
diff --git a/arch/powerpc/cpu/mpc85xx/b4860_ids.c b/arch/powerpc/cpu/mpc85xx/b4860_ids.c
index 013a171ed87b..39cfd20129ff 100644
--- a/arch/powerpc/cpu/mpc85xx/b4860_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/b4860_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/b4860_serdes.c b/arch/powerpc/cpu/mpc85xx/b4860_serdes.c
index 8e18e12f6341..25fdb4b04211 100644
--- a/arch/powerpc/cpu/mpc85xx/b4860_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/b4860_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c b/arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
index 792133482740..9ebb3d838fa4 100644
--- a/arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/bsc9132_serdes.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/c29x_serdes.c b/arch/powerpc/cpu/mpc85xx/c29x_serdes.c
index e53dd43f31fe..bbe4a0dd62b0 100644
--- a/arch/powerpc/cpu/mpc85xx/c29x_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/c29x_serdes.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/cmd_errata.c b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
index c7d473d4a1b4..01763b54e8af 100644
--- a/arch/powerpc/cpu/mpc85xx/cmd_errata.c
+++ b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
@@ -3,7 +3,7 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <command.h>
 #include <init.h>
 #include <linux/compiler.h>
diff --git a/arch/powerpc/cpu/mpc85xx/cpu.c b/arch/powerpc/cpu/mpc85xx/cpu.c
index e8a3e82765fc..6356b0216380 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu.c
@@ -9,7 +9,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <cpu_func.h>
 #include <clock_legacy.h>
 #include <display_options.h>
diff --git a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
index a67f37e3af96..574510fa0883 100644
--- a/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
+++ b/arch/powerpc/cpu/mpc85xx/cpu_init_early.c
@@ -3,8 +3,9 @@
  * Copyright 2009-2012 Freescale Semiconductor, Inc
  */
 
-#include <common.h>
+#include <asm/ppc.h>
 #include <system-constants.h>
+#include <linux/types.h>
 #include <asm-offsets.h>
 #include <asm/global_data.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/cpu/mpc85xx/fdt.c b/arch/powerpc/cpu/mpc85xx/fdt.c
index e26436bf5701..c56e98d4b49e 100644
--- a/arch/powerpc/cpu/mpc85xx/fdt.c
+++ b/arch/powerpc/cpu/mpc85xx/fdt.c
@@ -6,7 +6,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <env.h>
 #include <log.h>
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c b/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
index 9b6577e547e5..3383bb5c9b02 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <log.h>
 #include <asm/fsl_serdes.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
index 7c2de02c4c56..78316ea5ffe2 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2009-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <log.h>
 #include <time.h>
diff --git a/arch/powerpc/cpu/mpc85xx/interrupts.c b/arch/powerpc/cpu/mpc85xx/interrupts.c
index bcbdfac02792..3c98768f22ea 100644
--- a/arch/powerpc/cpu/mpc85xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc85xx/interrupts.c
@@ -10,7 +10,7 @@
  * Xianghua Xiao (X.Xiao@motorola.com)
  */
 
-#include <common.h>
+#include <asm/ppc.h>
 #include <irq_func.h>
 #include <log.h>
 #include <time.h>
diff --git a/arch/powerpc/cpu/mpc85xx/liodn.c b/arch/powerpc/cpu/mpc85xx/liodn.c
index 4b8844a4d960..af6731cbb3a4 100644
--- a/arch/powerpc/cpu/mpc85xx/liodn.c
+++ b/arch/powerpc/cpu/mpc85xx/liodn.c
@@ -3,7 +3,7 @@
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
diff --git a/arch/powerpc/cpu/mpc85xx/mp.c b/arch/powerpc/cpu/mpc85xx/mp.c
index 7c47e415f05d..b638f24ed14c 100644
--- a/arch/powerpc/cpu/mpc85xx/mp.c
+++ b/arch/powerpc/cpu/mpc85xx/mp.c
@@ -3,7 +3,7 @@
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <env.h>
 #include <log.h>
diff --git a/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c b/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
index cbcb57fe3a54..bafff2083b35 100644
--- a/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/mpc8536_serdes.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/mpc8544_serdes.c b/arch/powerpc/cpu/mpc85xx/mpc8544_serdes.c
index a48f3c151285..ad979caf6a7d 100644
--- a/arch/powerpc/cpu/mpc85xx/mpc8544_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/mpc8544_serdes.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c b/arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
index 479ee085d3ab..924afa096d18 100644
--- a/arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/mpc8548_serdes.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p1010_serdes.c b/arch/powerpc/cpu/mpc85xx/p1010_serdes.c
index 56e5ef6468c1..d38041ef5c2b 100644
--- a/arch/powerpc/cpu/mpc85xx/p1010_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p1010_serdes.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p1021_serdes.c b/arch/powerpc/cpu/mpc85xx/p1021_serdes.c
index 47f13e3c1cd7..ec0f14ae6a74 100644
--- a/arch/powerpc/cpu/mpc85xx/p1021_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p1021_serdes.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p1023_serdes.c b/arch/powerpc/cpu/mpc85xx/p1023_serdes.c
index 7a8f653727ef..6d306d99c32d 100644
--- a/arch/powerpc/cpu/mpc85xx/p1023_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p1023_serdes.c
@@ -5,7 +5,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p2020_serdes.c b/arch/powerpc/cpu/mpc85xx/p2020_serdes.c
index 8c5d82ae8ade..49626fc1d1b6 100644
--- a/arch/powerpc/cpu/mpc85xx/p2020_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p2020_serdes.c
@@ -4,7 +4,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <log.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p2041_ids.c b/arch/powerpc/cpu/mpc85xx/p2041_ids.c
index 540a6e6e191f..67a21e15a64d 100644
--- a/arch/powerpc/cpu/mpc85xx/p2041_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p2041_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/p2041_serdes.c b/arch/powerpc/cpu/mpc85xx/p2041_serdes.c
index 3eca3a69326f..d915665df8f5 100644
--- a/arch/powerpc/cpu/mpc85xx/p2041_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p2041_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p3041_ids.c b/arch/powerpc/cpu/mpc85xx/p3041_ids.c
index 8f645258a5fc..e5d600fa2a4d 100644
--- a/arch/powerpc/cpu/mpc85xx/p3041_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p3041_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/p3041_serdes.c b/arch/powerpc/cpu/mpc85xx/p3041_serdes.c
index ec8234c1c1e5..b1586f110e86 100644
--- a/arch/powerpc/cpu/mpc85xx/p3041_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p3041_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2009-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p4080_ids.c b/arch/powerpc/cpu/mpc85xx/p4080_ids.c
index db411162022b..250504128374 100644
--- a/arch/powerpc/cpu/mpc85xx/p4080_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p4080_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/p4080_serdes.c b/arch/powerpc/cpu/mpc85xx/p4080_serdes.c
index 463fa119c9b8..438fd446be36 100644
--- a/arch/powerpc/cpu/mpc85xx/p4080_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p4080_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2009-2010 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p5040_ids.c b/arch/powerpc/cpu/mpc85xx/p5040_ids.c
index bd05eae2551d..de1d372631bb 100644
--- a/arch/powerpc/cpu/mpc85xx/p5040_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p5040_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/p5040_serdes.c b/arch/powerpc/cpu/mpc85xx/p5040_serdes.c
index 2327b2c2a414..409f2ac938d1 100644
--- a/arch/powerpc/cpu/mpc85xx/p5040_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p5040_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2009-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/portals.c b/arch/powerpc/cpu/mpc85xx/portals.c
index 6b4cbddcdfe1..782874d79d7c 100644
--- a/arch/powerpc/cpu/mpc85xx/portals.c
+++ b/arch/powerpc/cpu/mpc85xx/portals.c
@@ -3,7 +3,6 @@
  * Copyright 2008-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/qe_io.c b/arch/powerpc/cpu/mpc85xx/qe_io.c
index 3cf41ca76d5b..c3f7493efc7e 100644
--- a/arch/powerpc/cpu/mpc85xx/qe_io.c
+++ b/arch/powerpc/cpu/mpc85xx/qe_io.c
@@ -6,7 +6,7 @@
  * based on source code of Shlomi Gridish
  */
 
-#include <common.h>
+#include <config.h>
 #include <linux/errno.h>
 #include <asm/io.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/speed.c b/arch/powerpc/cpu/mpc85xx/speed.c
index 9af40310b46f..1a4ee87cb348 100644
--- a/arch/powerpc/cpu/mpc85xx/speed.c
+++ b/arch/powerpc/cpu/mpc85xx/speed.c
@@ -9,7 +9,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <cpu_func.h>
 #include <clock_legacy.h>
 #include <ppc_asm.tmpl>
diff --git a/arch/powerpc/cpu/mpc85xx/spl_minimal.c b/arch/powerpc/cpu/mpc85xx/spl_minimal.c
index ce2b9c216677..e7031c1338b7 100644
--- a/arch/powerpc/cpu/mpc85xx/spl_minimal.c
+++ b/arch/powerpc/cpu/mpc85xx/spl_minimal.c
@@ -3,7 +3,7 @@
  * Copyright 2009 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/processor.h>
 #include <asm/global_data.h>
 #include <fsl_ifc.h>
diff --git a/arch/powerpc/cpu/mpc85xx/t1024_ids.c b/arch/powerpc/cpu/mpc85xx/t1024_ids.c
index bab076b2b180..01a62b86926a 100644
--- a/arch/powerpc/cpu/mpc85xx/t1024_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t1024_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t1024_serdes.c b/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
index 16458e73be13..3ab743c3d628 100644
--- a/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/t1040_ids.c b/arch/powerpc/cpu/mpc85xx/t1040_ids.c
index 59f4f9c6692c..d0f9b0ca758a 100644
--- a/arch/powerpc/cpu/mpc85xx/t1040_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t1040_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t1040_serdes.c b/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
index 3a7fdef79c2e..1f1b23a3aaaf 100644
--- a/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/t2080_ids.c b/arch/powerpc/cpu/mpc85xx/t2080_ids.c
index 390bb1153758..51ac367dd809 100644
--- a/arch/powerpc/cpu/mpc85xx/t2080_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t2080_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t2080_serdes.c b/arch/powerpc/cpu/mpc85xx/t2080_serdes.c
index 5f34aab4531e..16fa16b08081 100644
--- a/arch/powerpc/cpu/mpc85xx/t2080_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t2080_serdes.c
@@ -5,7 +5,7 @@
  * Shengzhou Liu <Shengzhou.Liu@freescale.com>
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include "fsl_corenet2_serdes.h"
diff --git a/arch/powerpc/cpu/mpc85xx/t4240_ids.c b/arch/powerpc/cpu/mpc85xx/t4240_ids.c
index 37ea7788ccfc..94b4409cecad 100644
--- a/arch/powerpc/cpu/mpc85xx/t4240_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t4240_ids.c
@@ -3,7 +3,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t4240_serdes.c b/arch/powerpc/cpu/mpc85xx/t4240_serdes.c
index 61402e84ef62..956b5ea37aa5 100644
--- a/arch/powerpc/cpu/mpc85xx/t4240_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t4240_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/tlb.c b/arch/powerpc/cpu/mpc85xx/tlb.c
index 2a78f0fe502c..e0b36f869a9c 100644
--- a/arch/powerpc/cpu/mpc85xx/tlb.c
+++ b/arch/powerpc/cpu/mpc85xx/tlb.c
@@ -6,7 +6,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <config.h>
 #include <display_options.h>
 #include <init.h>
 #include <asm/bitops.h>
diff --git a/arch/powerpc/cpu/mpc85xx/traps.c b/arch/powerpc/cpu/mpc85xx/traps.c
index 8f451b486248..db70f07500c5 100644
--- a/arch/powerpc/cpu/mpc85xx/traps.c
+++ b/arch/powerpc/cpu/mpc85xx/traps.c
@@ -19,7 +19,7 @@
  * This file handles the architecture-dependent parts of hardware exceptions
  */
 
-#include <common.h>
+#include <asm/ppc.h>
 #include <asm/global_data.h>
 #include <asm/ptrace.h>
 #include <command.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/cpu.c b/arch/powerpc/cpu/mpc8xxx/cpu.c
index 73d28f2a4e28..82f28749eb17 100644
--- a/arch/powerpc/cpu/mpc8xxx/cpu.c
+++ b/arch/powerpc/cpu/mpc8xxx/cpu.c
@@ -8,7 +8,6 @@
  */
 
 #include <config.h>
-#include <common.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <init.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/fdt.c b/arch/powerpc/cpu/mpc8xxx/fdt.c
index 300429024878..f1c1cbc1c3c6 100644
--- a/arch/powerpc/cpu/mpc8xxx/fdt.c
+++ b/arch/powerpc/cpu/mpc8xxx/fdt.c
@@ -8,7 +8,6 @@
  * cpu specific common code for 85xx/86xx processors.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c b/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
index 29489b46e6cd..c7bae5a88151 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
@@ -3,7 +3,7 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <hang.h>
 #include <init.h>
 #include <asm/fsl_lbc.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
index 8e1f6c964d3f..523367ddf1c1 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
@@ -5,7 +5,7 @@
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <log.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/law.c b/arch/powerpc/cpu/mpc8xxx/law.c
index 35409dc8824c..5c6e26b9aa15 100644
--- a/arch/powerpc/cpu/mpc8xxx/law.c
+++ b/arch/powerpc/cpu/mpc8xxx/law.c
@@ -6,7 +6,7 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <display_options.h>
 #include <asm/bitops.h>
 #include <asm/global_data.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/pamu_table.c b/arch/powerpc/cpu/mpc8xxx/pamu_table.c
index b906279226a5..e55173a890b7 100644
--- a/arch/powerpc/cpu/mpc8xxx/pamu_table.c
+++ b/arch/powerpc/cpu/mpc8xxx/pamu_table.c
@@ -3,7 +3,7 @@
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <asm/u-boot.h>
 #include <log.h>
 #include <asm/fsl_pamu.h>
 #include <asm/global_data.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/srio.c b/arch/powerpc/cpu/mpc8xxx/srio.c
index c0b4a1217d33..185cbabbcd85 100644
--- a/arch/powerpc/cpu/mpc8xxx/srio.c
+++ b/arch/powerpc/cpu/mpc8xxx/srio.c
@@ -3,8 +3,7 @@
  * Copyright 2011 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
-#include <config.h>
+#include <asm/u-boot.h>
 #include <log.h>
 #include <time.h>
 #include <asm/fsl_law.h>
diff --git a/arch/powerpc/include/asm/cache.h b/arch/powerpc/include/asm/cache.h
index b94faa5408e1..21dfce4c8c73 100644
--- a/arch/powerpc/include/asm/cache.h
+++ b/arch/powerpc/include/asm/cache.h
@@ -39,6 +39,8 @@
 #endif
 
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__)
+#include <linux/types.h>
+
 extern void flush_dcache_range(unsigned long start, unsigned long stop);
 extern void clean_dcache_range(unsigned long start, unsigned long stop);
 extern void invalidate_dcache_range(unsigned long start, unsigned long stop);
diff --git a/arch/powerpc/include/asm/fsl_dma.h b/arch/powerpc/include/asm/fsl_dma.h
index 1459db74beea..e69e7dbefe88 100644
--- a/arch/powerpc/include/asm/fsl_dma.h
+++ b/arch/powerpc/include/asm/fsl_dma.h
@@ -8,7 +8,7 @@
 #ifndef _ASM_FSL_DMA_H_
 #define _ASM_FSL_DMA_H_
 
-#include <asm/types.h>
+#include <linux/types.h>
 
 #ifdef CONFIG_MPC83xx
 typedef struct fsl_dma {
diff --git a/arch/powerpc/include/asm/fsl_serdes.h b/arch/powerpc/include/asm/fsl_serdes.h
index ddde4f80c632..fdf761152333 100644
--- a/arch/powerpc/include/asm/fsl_serdes.h
+++ b/arch/powerpc/include/asm/fsl_serdes.h
@@ -7,6 +7,7 @@
 #define __FSL_SERDES_H
 
 #include <config.h>
+#include <linux/types.h>
 
 enum srds_prtcl {
 	/*
diff --git a/arch/powerpc/include/asm/immap_8xx.h b/arch/powerpc/include/asm/immap_8xx.h
index cf1300f6e297..e11300cab20d 100644
--- a/arch/powerpc/include/asm/immap_8xx.h
+++ b/arch/powerpc/include/asm/immap_8xx.h
@@ -12,6 +12,8 @@
 #ifndef __IMMAP_8XX__
 #define __IMMAP_8XX__
 
+#include <linux/types.h>
+
 /* System configuration registers.
 */
 typedef	struct sys_conf {
diff --git a/arch/powerpc/lib/bdinfo.c b/arch/powerpc/lib/bdinfo.c
index 55dcad5df8e9..c12e4c6371fe 100644
--- a/arch/powerpc/lib/bdinfo.c
+++ b/arch/powerpc/lib/bdinfo.c
@@ -6,9 +6,9 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/powerpc/lib/bootm.c b/arch/powerpc/lib/bootm.c
index 75c6bfd2bf81..f55b5ff8320e 100644
--- a/arch/powerpc/lib/bootm.c
+++ b/arch/powerpc/lib/bootm.c
@@ -7,7 +7,7 @@
  */
 
 
-#include <common.h>
+#include <config.h>
 #include <bootm.h>
 #include <bootstage.h>
 #include <cpu_func.h>
diff --git a/arch/powerpc/lib/cache.c b/arch/powerpc/lib/cache.c
index c4c5c2d45138..e480b2696494 100644
--- a/arch/powerpc/lib/cache.c
+++ b/arch/powerpc/lib/cache.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <asm/cache.h>
 #include <watchdog.h>
diff --git a/arch/powerpc/lib/extable.c b/arch/powerpc/lib/extable.c
index 7e9d4f22f390..fd45e8a790d9 100644
--- a/arch/powerpc/lib/extable.c
+++ b/arch/powerpc/lib/extable.c
@@ -5,7 +5,6 @@
  * (C) Copyright 2000
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
-#include <common.h>
 #include <log.h>
 
 /*
diff --git a/arch/powerpc/lib/interrupts.c b/arch/powerpc/lib/interrupts.c
index df312dfa28ef..92b8a0bceacf 100644
--- a/arch/powerpc/lib/interrupts.c
+++ b/arch/powerpc/lib/interrupts.c
@@ -7,7 +7,7 @@
  * Gleb Natapov <gnatapov@mrv.com>
  */
 
-#include <common.h>
+#include <asm/ppc.h>
 #include <irq_func.h>
 #include <asm/processor.h>
 #include <watchdog.h>
diff --git a/arch/powerpc/lib/kgdb.c b/arch/powerpc/lib/kgdb.c
index 8727d18884c4..20fcb7eef0ec 100644
--- a/arch/powerpc/lib/kgdb.c
+++ b/arch/powerpc/lib/kgdb.c
@@ -1,4 +1,3 @@
-#include <common.h>
 #include <command.h>
 #include <kgdb.h>
 #include <asm/ptrace.h>
diff --git a/arch/powerpc/lib/spl.c b/arch/powerpc/lib/spl.c
index b638ea7be611..3a24cbfff3bc 100644
--- a/arch/powerpc/lib/spl.c
+++ b/arch/powerpc/lib/spl.c
@@ -2,7 +2,6 @@
 /*
  * Copyright 2012 Stefan Roese <sr@denx.de>
  */
-#include <common.h>
 #include <config.h>
 #include <log.h>
 #include <spl.h>
diff --git a/arch/powerpc/lib/stack.c b/arch/powerpc/lib/stack.c
index 2e731aa8701d..afd869e4ac30 100644
--- a/arch/powerpc/lib/stack.c
+++ b/arch/powerpc/lib/stack.c
@@ -10,7 +10,6 @@
  * Sysgo Real-Time Solutions, GmbH <www.elinos.com>
  * Marius Groeger <mgroeger@sysgo.de>
  */
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
 #include <asm/mp.h>
diff --git a/arch/powerpc/lib/time.c b/arch/powerpc/lib/time.c
index 8d6babfb83d6..0a0e75e726b0 100644
--- a/arch/powerpc/lib/time.c
+++ b/arch/powerpc/lib/time.c
@@ -4,7 +4,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/io.h>
diff --git a/include/fsl_immap.h b/include/fsl_immap.h
index 5297c0b3f9b6..54d6e0ab3772 100644
--- a/include/fsl_immap.h
+++ b/include/fsl_immap.h
@@ -7,6 +7,9 @@
 
 #ifndef __FSL_IMMAP_H
 #define __FSL_IMMAP_H
+
+#include <linux/types.h>
+
 /*
  * DDR memory controller registers
  * This structure works for mpc83xx (DDR2 and DDR3), mpc85xx, mpc86xx.
-- 
2.34.1

