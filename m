Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE2E5C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:41:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 649D488A54;
	Tue, 30 Apr 2024 15:36:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ToedY7M3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B60D988A8F; Tue, 30 Apr 2024 15:36:40 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 039A888A70
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-6eb55942409so2715990a34.1
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484196; x=1715088996; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7N4k3+AxzUb4mciXrtT8mYeg8qdgMnDhvPM+PRnzHKU=;
 b=ToedY7M3ckOMDF4+RBJmfbiRash2LvdFIzPkTrjwrGIVk8lJsdYTRi0J1mN8Z30PHU
 q8360wxzurvjccpHhydDgXAhVUjCqcUmx1NCQh4rSehrGU4IeVR/NXr44ioq6uKUubyM
 WuK4mANkwaGGW/suhyHZewDlNLAAGmKhi/7dg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484196; x=1715088996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7N4k3+AxzUb4mciXrtT8mYeg8qdgMnDhvPM+PRnzHKU=;
 b=SvnRugjUa8FuzEwteQ121YspORa1IvtgbpA2eO1Gr/eQeri3fL4O3Lj8H0B5+TvkKe
 cnAU8Mzg6OFD1eU3nAh+xYBSuf+vSRmf1XwaGpA4qC7t6OXKezu4HMPR66Dpj5vVuMjD
 r6hnMjnwmxvtLi8x6rPIwH1gozlemCLxlsYoysPKzHIDQhLB6+/FOjlGVfb4/Ayplgxv
 6HYJTqOsaEmzxohWrlRKmVczVuM2TcrqbYHkH/UGBI1xIr+Y+dNzKZD//e+QLh839cpT
 WbCjWL0THEidhPly5ctIng6B1WdHaZZPG2/MdetFVrtcLLrqBmHMr8t7MNOU+dx/E8o8
 0mNQ==
X-Gm-Message-State: AOJu0Yz2J+pb2evEzub1Y/hECnv6vdGn5lFL/0PGm4aiV1w/GC4K+YaH
 psIGHQJrknTWPTiikbqH6cCcAxFYvj+rWK4rDTE9gC5HRMPNb6WhbXf+mFiAJjdeuYQ7czs9pl8
 QZstzBA==
X-Google-Smtp-Source: AGHT+IEZbQAUKzM418X6JL8m7jLB7uT/EpBzvBQjBgQYu/PtiTrCVTK2r837nxTBQw9hng3Rn+6PRQ==
X-Received: by 2002:a05:6830:60c:b0:6ee:6a15:82ff with SMTP id
 w12-20020a056830060c00b006ee6a1582ffmr1790263oti.24.1714484196302; 
 Tue, 30 Apr 2024 06:36:36 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:36 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 32/33] arm: fsl-layerscape: Remove <common.h> and add needed
 includes
Date: Tue, 30 Apr 2024 07:35:58 -0600
Message-Id: <20240430133559.1836389-32-trini@konsulko.com>
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

Remove <common.h> from all fsl-layerscape related files and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/cpu/armv7/ls102xa/clock.c                     | 2 +-
 arch/arm/cpu/armv7/ls102xa/cpu.c                       | 1 -
 arch/arm/cpu/armv7/ls102xa/fdt.c                       | 2 +-
 arch/arm/cpu/armv7/ls102xa/fsl_epu.c                   | 1 -
 arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c            | 2 +-
 arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c            | 2 +-
 arch/arm/cpu/armv7/ls102xa/soc.c                       | 2 +-
 arch/arm/cpu/armv7/ls102xa/spl.c                       | 1 -
 arch/arm/cpu/armv7/ls102xa/timer.c                     | 1 -
 arch/arm/cpu/armv8/fsl-layerscape/cpu.c                | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/fdt.c                | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c   | 3 ++-
 arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c    | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c   | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c    | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/icid.c               | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c     | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c         | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c     | 3 ++-
 arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c         | 3 ++-
 arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c     | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c         | 3 ++-
 arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c     | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c         | 3 ++-
 arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c     | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c     | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c         | 3 ++-
 arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c         | 3 ++-
 arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c     | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/mp.c                 | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/soc.c                | 2 +-
 arch/arm/cpu/armv8/fsl-layerscape/spl.c                | 2 +-
 arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h  | 2 ++
 arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h | 1 +
 arch/arm/include/asm/arch-ls102xa/fsl_serdes.h         | 2 ++
 35 files changed, 40 insertions(+), 32 deletions(-)

diff --git a/arch/arm/cpu/armv7/ls102xa/clock.c b/arch/arm/cpu/armv7/ls102xa/clock.c
index 4e1fe281201f..e885a85ce65c 100644
--- a/arch/arm/cpu/armv7/ls102xa/clock.c
+++ b/arch/arm/cpu/armv7/ls102xa/clock.c
@@ -3,7 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/arm/cpu/armv7/ls102xa/cpu.c b/arch/arm/cpu/armv7/ls102xa/cpu.c
index c455969609f6..74a2dcbc116a 100644
--- a/arch/arm/cpu/armv7/ls102xa/cpu.c
+++ b/arch/arm/cpu/armv7/ls102xa/cpu.c
@@ -4,7 +4,6 @@
  * Copyright 2021 NXP
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <net.h>
diff --git a/arch/arm/cpu/armv7/ls102xa/fdt.c b/arch/arm/cpu/armv7/ls102xa/fdt.c
index 1c3d24bcad94..34eea22eb923 100644
--- a/arch/arm/cpu/armv7/ls102xa/fdt.c
+++ b/arch/arm/cpu/armv7/ls102xa/fdt.c
@@ -3,7 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <net.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/cpu/armv7/ls102xa/fsl_epu.c b/arch/arm/cpu/armv7/ls102xa/fsl_epu.c
index e31a4fb6c31b..664eae532d5f 100644
--- a/arch/arm/cpu/armv7/ls102xa/fsl_epu.c
+++ b/arch/arm/cpu/armv7/ls102xa/fsl_epu.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <asm/io.h>
 
 #include "fsl_epu.h"
diff --git a/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c b/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c
index f74d819ea1ea..c1eadb34523f 100644
--- a/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c
+++ b/arch/arm/cpu/armv7/ls102xa/fsl_ls1_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_ls102xa.h>
 #include <linux/errno.h>
diff --git a/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c b/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c
index 8c030be8b36f..3032e266c5d4 100644
--- a/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c
+++ b/arch/arm/cpu/armv7/ls102xa/ls102xa_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <linux/kernel.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_ls102xa.h>
 
diff --git a/arch/arm/cpu/armv7/ls102xa/soc.c b/arch/arm/cpu/armv7/ls102xa/soc.c
index 84d4ea3a8f4a..7ff59edd452e 100644
--- a/arch/arm/cpu/armv7/ls102xa/soc.c
+++ b/arch/arm/cpu/armv7/ls102xa/soc.c
@@ -3,7 +3,7 @@
  * Copyright 2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/arch/clock.h>
 #include <asm/io.h>
diff --git a/arch/arm/cpu/armv7/ls102xa/spl.c b/arch/arm/cpu/armv7/ls102xa/spl.c
index a19496862359..374de92d026c 100644
--- a/arch/arm/cpu/armv7/ls102xa/spl.c
+++ b/arch/arm/cpu/armv7/ls102xa/spl.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <spl.h>
 
 u32 spl_boot_device(void)
diff --git a/arch/arm/cpu/armv7/ls102xa/timer.c b/arch/arm/cpu/armv7/ls102xa/timer.c
index c6126b10c355..6f32ced5aec3 100644
--- a/arch/arm/cpu/armv7/ls102xa/timer.c
+++ b/arch/arm/cpu/armv7/ls102xa/timer.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
index 12d31184ad91..d2dbfdd08a02 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/cpu.c
@@ -4,7 +4,7 @@
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
index 22ce6992165b..ca6be3626fbe 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fdt.c
@@ -4,7 +4,7 @@
  * Copyright 2020-2021 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <efi_loader.h>
 #include <log.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
index b1bb29bcaf55..78961d8089e4 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_serdes.c
@@ -3,11 +3,12 @@
  * Copyright 2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/io.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
+#include <linux/string.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
index 4455eb1726dc..9a24d4b30313 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch2_speed.c
@@ -4,7 +4,7 @@
  * Copyright 2019 NXP.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
index fbd5fd7d433b..b768790437fd 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_serdes.c
@@ -4,7 +4,7 @@
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <env.h>
 #include <log.h>
 #include <asm/io.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c
index 137778dc136b..452246e0e67f 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/fsl_lsch3_speed.c
@@ -6,7 +6,7 @@
  * Derived from arch/power/cpu/mpc85xx/speed.c
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/icid.c b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
index c22e73253c3c..04ffefafbf73 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/icid.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/icid.c
@@ -3,7 +3,7 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c
index 8d7beca7db38..c0e5455507a4 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1012a_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2016 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_lsch2.h>
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
index 86a49b152e44..d48baa63816f 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1028_ids.c
@@ -3,9 +3,9 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
 #include <fdt_support.h>
 #include <log.h>
+#include <asm/arch/stream_id_lsch3.h>
 #include <asm/arch-fsl-layerscape/immap_lsch3.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c
index 80d2910f679f..1b4eab3613e5 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1028a_serdes.c
@@ -3,7 +3,8 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
+#include <config.h>
+#include <linux/kernel.h>
 #include <asm/arch/fsl_serdes.h>
 
 struct serdes_config {
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
index e3c3fc6bfb55..ec80e42055d9 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1043_ids.c
@@ -3,11 +3,12 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch-fsl-layerscape/immap_lsch2.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
 #include <fsl_sec.h>
+#include <asm/arch/stream_id_lsch3.h>
 
 #ifdef CONFIG_SYS_DPAA_QBMAN
 struct qportal_info qp_info[CFG_SYS_QMAN_NUM_PORTALS] = {
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c
index 6c5e52ebaa69..1911ca1a175b 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1043a_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_lsch2.h>
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
index 333d7e2fa21a..a73dd316f8d0 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1046_ids.c
@@ -3,10 +3,11 @@
  * Copyright 2018 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch-fsl-layerscape/immap_lsch2.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
+#include <asm/arch/stream_id_lsch3.h>
 
 #ifdef CONFIG_SYS_DPAA_QBMAN
 struct qportal_info qp_info[CFG_SYS_QMAN_NUM_PORTALS] = {
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c
index 9347e516bf69..26ca4ca10f3d 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1046a_serdes.c
@@ -4,7 +4,7 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/immap_lsch2.h>
 
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c
index 23743ae10cff..3a076ca04f6e 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1088_ids.c
@@ -3,10 +3,11 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch-fsl-layerscape/immap_lsch3.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
+#include <asm/arch/stream_id_lsch3.h>
 
 struct icid_id_table icid_tbl[] = {
 	SET_SDHC_ICID(1, FSL_SDMMC_STREAM_ID),
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c
index fe667f06c395..154b727392e1 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls1088a_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2017-2019 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 #include <asm/arch/soc.h>
 #include <asm/io.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c
index 7997422840f2..5088c8ebb7ff 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls2080a_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 
 struct serdes_config {
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c
index e6403b795263..c320e835c996 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/ls2088_ids.c
@@ -3,10 +3,11 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch-fsl-layerscape/immap_lsch3.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
+#include <asm/arch/stream_id_lsch3.h>
 
 struct icid_id_table icid_tbl[] = {
 	SET_SDHC_ICID(1, FSL_SDMMC_STREAM_ID),
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c b/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c
index 3a0ed1fa550c..df9329df77e1 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/lx2160_ids.c
@@ -3,10 +3,11 @@
  * Copyright 2019 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch-fsl-layerscape/immap_lsch3.h>
 #include <asm/arch-fsl-layerscape/fsl_icid.h>
 #include <asm/arch-fsl-layerscape/fsl_portals.h>
+#include <asm/arch/stream_id_lsch3.h>
 
 struct icid_id_table icid_tbl[] = {
 	SET_SDHC_ICID(1, FSL_SDMMC_STREAM_ID),
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c b/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c
index 5941d90e036f..43f0e8c87ba9 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/lx2160a_serdes.c
@@ -3,7 +3,7 @@
  * Copyright 2018, 2020 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/fsl_serdes.h>
 
 struct serdes_config {
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/mp.c b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
index ce0c46ad0d4e..db913208b9e9 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/mp.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/mp.c
@@ -3,7 +3,7 @@
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <image.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/soc.c b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
index 4c61d28c20f0..d85a630f8a3c 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/soc.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/soc.c
@@ -4,7 +4,7 @@
  * Copyright 2019-2021 NXP
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <env.h>
diff --git a/arch/arm/cpu/armv8/fsl-layerscape/spl.c b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
index 232adfa843a2..a739ff2da581 100644
--- a/arch/arm/cpu/armv8/fsl-layerscape/spl.c
+++ b/arch/arm/cpu/armv8/fsl-layerscape/spl.c
@@ -3,7 +3,7 @@
  * Copyright 2014-2015 Freescale Semiconductor, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <clock_legacy.h>
 #include <cpu_func.h>
 #include <debug_uart.h>
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h b/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
index 9e29350ca4ba..a02bec9371c0 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
@@ -7,6 +7,8 @@
 #ifndef __FSL_SERDES_H__
 #define __FSL_SERDES_H__
 
+#include <linux/types.h>
+
 #ifdef CONFIG_FSL_LSCH3
 enum srds_prtcl {
 	/*
diff --git a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
index 9794db044996..147ca2f99de6 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/immap_lsch2.h
@@ -6,6 +6,7 @@
 #ifndef __ARCH_FSL_LSCH2_IMMAP_H__
 #define __ARCH_FSL_LSCH2_IMMAP_H__
 
+#include <config.h>
 #include <fsl_immap.h>
 #ifndef __ASSEMBLY__
 #include <linux/bitops.h>
diff --git a/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h b/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
index 9244e0a78fd3..35e3ec7a9878 100644
--- a/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
+++ b/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
@@ -6,6 +6,8 @@
 #ifndef __FSL_SERDES_H
 #define __FSL_SERDES_H
 
+#include <linux/types.h>
+
 enum srds_prtcl {
 	/*
 	 * Nobody will check whether the device 'NONE' has been configured,
-- 
2.34.1

