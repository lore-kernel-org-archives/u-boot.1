Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F61DC4345F
	for <u-boot@archiver.kernel.org>; Thu,  2 May 2024 01:36:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8814188C05;
	Thu,  2 May 2024 03:32:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iELZDYXo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E69A388C4F; Thu,  2 May 2024 03:32:28 +0200 (CEST)
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BA7C88BE0
 for <u-boot@lists.denx.de>; Thu,  2 May 2024 03:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82d.google.com with SMTP id
 d75a77b69052e-43b0b09d012so17697571cf.3
 for <u-boot@lists.denx.de>; Wed, 01 May 2024 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714613545; x=1715218345; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IC8/q3HnRn+zNkxLCl3Co6fEudb85BtiCTgj3bGwMmw=;
 b=iELZDYXoO8a97tTJWr1iAZJZTbGojlS/KBY5fOW9uFA3fwLKjnurc8i1es9kfMo9aZ
 EvchMdYFMXZu2KiQTSx8dcoqE35644yQymSLy3O50ssqOsnI9WxTJ9zb0T31tF4U/Adb
 qLuJE9ao1z6MGVGjGwDq053Und3UMcfWNOB5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714613545; x=1715218345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IC8/q3HnRn+zNkxLCl3Co6fEudb85BtiCTgj3bGwMmw=;
 b=b9I8Pt9Hu/OY+OE0nxEc4dGX69i843mMss1Vtax1gAj1SCLLliDwsgcRlbXzImsjdV
 y+Xbd/hhLASdAK/qS0V41UGkOmK36Kuuy/k8hqpYV8yEVTH04BMm/lNbQTPNdZvDlDUs
 FmPkPfJnW0y0KeQtrLSjhNG+RNqHHVho2y3K2PQjQAXR0kAyj/f4FiFJJrTAYUheB3It
 RpJ8zxh5FLdLov1InDfmwq65IGs5h1QWlY7PFLj6TzebCKRoNHcADIX5n/Aoc6L5oPj6
 9ckCVXLrdefIGOojN4GVL9ywI9h4S5vAZW1XpY0G7Lpwj7bwL8VnCtamLE+Z5EXpiprH
 MwRQ==
X-Gm-Message-State: AOJu0YyXJl+cXDAbJkCt6NcY6RnKvRbMLg7nqW+BOS+ujJ/M5/GdHwNd
 Fje1dAVeRTFbsmDjznvGnBfsfezBWzv+GCqVqqL4qGUz437uyl60vnRFDz/JUjL0ueRAmPNAj9X
 oFxVf2oiT
X-Google-Smtp-Source: AGHT+IFLcYWp7k9vcTg05nP2UhQ0bXQwWnm6LKutjhIs9R03hvvUBK7PCEDg73O90WzznIceUQam6w==
X-Received: by 2002:ac8:5e13:0:b0:43b:dd6:82c0 with SMTP id
 h19-20020ac85e13000000b0043b0dd682c0mr4017025qtx.33.1714613545066; 
 Wed, 01 May 2024 18:32:25 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 c6-20020ac80546000000b00436bb57faddsm12737444qth.25.2024.05.01.18.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 May 2024 18:32:24 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Michal Simek <michal.simek@amd.com>
Subject: [PATCH 30/81] fpga: Remove <common.h> and add needed includes
Date: Wed,  1 May 2024 19:30:47 -0600
Message-Id: <20240502013138.2383421-30-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240502013138.2383421-1-trini@konsulko.com>
References: <20240502013138.2383421-1-trini@konsulko.com>
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

Remove <common.h> from this driver directory and when needed
add missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Michal Simek <michal.simek@amd.com>
Cc: Tom Rini <trini@konsulko.com>
---
 drivers/fpga/ACEX1K.c          | 2 +-
 drivers/fpga/altera.c          | 1 -
 drivers/fpga/cyclon2.c         | 3 ++-
 drivers/fpga/fpga.c            | 1 -
 drivers/fpga/intel_sdm_mb.c    | 4 +++-
 drivers/fpga/ivm_core.c        | 1 -
 drivers/fpga/lattice.c         | 1 -
 drivers/fpga/socfpga.c         | 2 +-
 drivers/fpga/socfpga_arria10.c | 1 -
 drivers/fpga/socfpga_gen5.c    | 2 +-
 drivers/fpga/spartan2.c        | 2 +-
 drivers/fpga/spartan3.c        | 3 ++-
 drivers/fpga/stratixII.c       | 1 -
 drivers/fpga/stratixv.c        | 1 -
 drivers/fpga/versalpl.c        | 1 -
 drivers/fpga/virtex2.c         | 2 +-
 drivers/fpga/xilinx.c          | 2 +-
 drivers/fpga/zynqmppl.c        | 1 -
 drivers/fpga/zynqpl.c          | 3 ++-
 19 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/fpga/ACEX1K.c b/drivers/fpga/ACEX1K.c
index 4c00cdf0b57d..cb7877a8afe7 100644
--- a/drivers/fpga/ACEX1K.c
+++ b/drivers/fpga/ACEX1K.c
@@ -9,7 +9,7 @@
 
 #define LOG_CATEGORY UCLASS_FPGA
 
-#include <common.h>		/* core U-Boot definitions */
+#include <config.h>		/* core U-Boot definitions */
 #include <console.h>
 #include <log.h>
 #include <ACEX1K.h>		/* ACEX device family */
diff --git a/drivers/fpga/altera.c b/drivers/fpga/altera.c
index 6a4f0cb9bc06..ae06f0123a03 100644
--- a/drivers/fpga/altera.c
+++ b/drivers/fpga/altera.c
@@ -12,7 +12,6 @@
 /*
  *  Altera FPGA support
  */
-#include <common.h>
 #include <errno.h>
 #include <ACEX1K.h>
 #include <log.h>
diff --git a/drivers/fpga/cyclon2.c b/drivers/fpga/cyclon2.c
index 6e8a313db35b..7e78d6e2d6ce 100644
--- a/drivers/fpga/cyclon2.c
+++ b/drivers/fpga/cyclon2.c
@@ -7,8 +7,9 @@
 
 #define LOG_CATEGORY UCLASS_FPGA
 
-#include <common.h>		/* core U-Boot definitions */
+#include <config.h>		/* core U-Boot definitions */
 #include <log.h>
+#include <time.h>
 #include <altera.h>
 #include <ACEX1K.h>		/* ACEX device family */
 #include <linux/delay.h>
diff --git a/drivers/fpga/fpga.c b/drivers/fpga/fpga.c
index 81e6d8ffc0bd..38ba6c21ea2b 100644
--- a/drivers/fpga/fpga.c
+++ b/drivers/fpga/fpga.c
@@ -5,7 +5,6 @@
  */
 
 /* Generic FPGA support */
-#include <common.h>             /* core U-Boot definitions */
 #include <init.h>
 #include <log.h>
 #include <xilinx.h>             /* xilinx specific definitions */
diff --git a/drivers/fpga/intel_sdm_mb.c b/drivers/fpga/intel_sdm_mb.c
index 903d143a361c..45caef4f5c10 100644
--- a/drivers/fpga/intel_sdm_mb.c
+++ b/drivers/fpga/intel_sdm_mb.c
@@ -3,14 +3,16 @@
  * Copyright (C) 2018 Intel Corporation <www.intel.com>
  */
 
-#include <common.h>
 #include <altera.h>
 #include <log.h>
+#include <time.h>
 #include <watchdog.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/smc_api.h>
 #include <linux/delay.h>
+#include <linux/errno.h>
 #include <linux/intel-smc.h>
+#include <linux/string.h>
 
 #define RECONFIG_STATUS_POLL_RESP_TIMEOUT_MS		60000
 #define RECONFIG_STATUS_INTERVAL_DELAY_US		1000000
diff --git a/drivers/fpga/ivm_core.c b/drivers/fpga/ivm_core.c
index adc60919f3b0..b9cecdd8720a 100644
--- a/drivers/fpga/ivm_core.c
+++ b/drivers/fpga/ivm_core.c
@@ -29,7 +29,6 @@
  *        the ispVMLCOUNT function
  */
 
-#include <common.h>
 #include <log.h>
 #include <linux/string.h>
 #include <malloc.h>
diff --git a/drivers/fpga/lattice.c b/drivers/fpga/lattice.c
index e292d991cd18..036580cad70f 100644
--- a/drivers/fpga/lattice.c
+++ b/drivers/fpga/lattice.c
@@ -10,7 +10,6 @@
  * Copyright 2009 Lattice Semiconductor Corp.
  */
 
-#include <common.h>
 #include <log.h>
 #include <malloc.h>
 #include <fpga.h>
diff --git a/drivers/fpga/socfpga.c b/drivers/fpga/socfpga.c
index d73414d5ac54..bb98c0e2bcf7 100644
--- a/drivers/fpga/socfpga.c
+++ b/drivers/fpga/socfpga.c
@@ -4,7 +4,7 @@
  * All rights reserved.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/fpga_manager.h>
diff --git a/drivers/fpga/socfpga_arria10.c b/drivers/fpga/socfpga_arria10.c
index 96b195063e08..e9822b2bb0ec 100644
--- a/drivers/fpga/socfpga_arria10.c
+++ b/drivers/fpga/socfpga_arria10.c
@@ -13,7 +13,6 @@
 #include <asm/arch/misc.h>
 #include <altera.h>
 #include <asm/arch/pinmux.h>
-#include <common.h>
 #include <dm.h>
 #include <dm/ofnode.h>
 #include <errno.h>
diff --git a/drivers/fpga/socfpga_gen5.c b/drivers/fpga/socfpga_gen5.c
index d73474f29ee1..9473f0573289 100644
--- a/drivers/fpga/socfpga_gen5.c
+++ b/drivers/fpga/socfpga_gen5.c
@@ -4,7 +4,7 @@
  * All rights reserved.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/fpga_manager.h>
diff --git a/drivers/fpga/spartan2.c b/drivers/fpga/spartan2.c
index 6eef87b78e16..9cd6cb7f0fbd 100644
--- a/drivers/fpga/spartan2.c
+++ b/drivers/fpga/spartan2.c
@@ -6,7 +6,7 @@
 
 #define LOG_CATEGORY UCLASS_FPGA
 
-#include <common.h>		/* core U-Boot definitions */
+#include <config.h>		/* core U-Boot definitions */
 #include <log.h>
 #include <spartan2.h>		/* Spartan-II device family */
 
diff --git a/drivers/fpga/spartan3.c b/drivers/fpga/spartan3.c
index e892fa571f19..b4d87d47d933 100644
--- a/drivers/fpga/spartan3.c
+++ b/drivers/fpga/spartan3.c
@@ -11,8 +11,9 @@
 
 #define LOG_CATEGORY UCLASS_FPGA
 
-#include <common.h>		/* core U-Boot definitions */
+#include <config.h>		/* core U-Boot definitions */
 #include <log.h>
+#include <time.h>
 #include <spartan3.h>		/* Spartan-II device family */
 
 /* Note: The assumption is that we cannot possibly run fast enough to
diff --git a/drivers/fpga/stratixII.c b/drivers/fpga/stratixII.c
index b450a81072ed..73fecd9dca55 100644
--- a/drivers/fpga/stratixII.c
+++ b/drivers/fpga/stratixII.c
@@ -4,7 +4,6 @@
  * Eran Liberty, Extricom , eran.liberty@gmail.com
  */
 
-#include <common.h>		/* core U-Boot definitions */
 #include <altera.h>
 #include <linux/delay.h>
 
diff --git a/drivers/fpga/stratixv.c b/drivers/fpga/stratixv.c
index abae3b5b7511..372f16d92d1a 100644
--- a/drivers/fpga/stratixv.c
+++ b/drivers/fpga/stratixv.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016 Stefan Roese <sr@denx.de>
  */
 
-#include <common.h>
 #include <altera.h>
 #include <log.h>
 #include <spi.h>
diff --git a/drivers/fpga/versalpl.c b/drivers/fpga/versalpl.c
index be58db54275c..1957e8dcacac 100644
--- a/drivers/fpga/versalpl.c
+++ b/drivers/fpga/versalpl.c
@@ -4,7 +4,6 @@
  * Siva Durga Prasad Paladugu <siva.durga.prasad.paladugu@amd.com>>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/arch/sys_proto.h>
diff --git a/drivers/fpga/virtex2.c b/drivers/fpga/virtex2.c
index 3ded27f9b3ff..8e2c12bb58b1 100644
--- a/drivers/fpga/virtex2.c
+++ b/drivers/fpga/virtex2.c
@@ -14,7 +14,7 @@
 
 #define LOG_CATEGORY UCLASS_FPGA
 
-#include <common.h>
+#include <config.h>
 #include <console.h>
 #include <log.h>
 #include <virtex2.h>
diff --git a/drivers/fpga/xilinx.c b/drivers/fpga/xilinx.c
index 8170c3368ef6..c46513226d9b 100644
--- a/drivers/fpga/xilinx.c
+++ b/drivers/fpga/xilinx.c
@@ -11,13 +11,13 @@
  *  Xilinx FPGA support
  */
 
-#include <common.h>
 #include <fpga.h>
 #include <log.h>
 #include <virtex2.h>
 #include <spartan2.h>
 #include <spartan3.h>
 #include <zynqpl.h>
+#include <linux/string.h>
 
 /* Local Static Functions */
 static int xilinx_validate(xilinx_desc *desc, char *fn);
diff --git a/drivers/fpga/zynqmppl.c b/drivers/fpga/zynqmppl.c
index 2656f5fc5ecf..2b62bbbe3cf5 100644
--- a/drivers/fpga/zynqmppl.c
+++ b/drivers/fpga/zynqmppl.c
@@ -6,7 +6,6 @@
  */
 
 #include <console.h>
-#include <common.h>
 #include <compiler.h>
 #include <cpu_func.h>
 #include <fpga.h>
diff --git a/drivers/fpga/zynqpl.c b/drivers/fpga/zynqpl.c
index a2e3b305fa41..57467b4d975a 100644
--- a/drivers/fpga/zynqpl.c
+++ b/drivers/fpga/zynqpl.c
@@ -6,10 +6,11 @@
  * Joe Hershberger <joe.hershberger@ni.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <console.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <time.h>
 #include <asm/cache.h>
 #include <asm/io.h>
 #include <fs.h>
-- 
2.34.1

