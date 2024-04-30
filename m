Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5740C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8D90188A3D;
	Tue, 30 Apr 2024 15:36:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sLnvRvl0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A412688A37; Tue, 30 Apr 2024 15:36:15 +0200 (CEST)
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com
 [IPv6:2607:f8b0:4864:20::734])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 089ED8858A
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78f043eaee9so343348385a.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484171; x=1715088971; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ouU/7ymRge9zeSFHKSEfit+OSmZO1ly+luqxhMr58r4=;
 b=sLnvRvl0I18iWPqo2L2iF0ECl+asN4d7yXm2ghKWv/3DMGTeptmo2r64V/rbusmYO4
 Ef5QeawGSOFdj+Fk8f3rtiW5tW0ZVKLSM+kpFet1WQ/oQhhSAzfHIaPg50La+76DBl+q
 ly7QukH3QkqF5qaUGliAnX1IL1uShJXoDGaio=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484171; x=1715088971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ouU/7ymRge9zeSFHKSEfit+OSmZO1ly+luqxhMr58r4=;
 b=WdEGMOtsDA9jht+JbTvQzjTQV3kZImtbxFzrBEzqi2jrP4WFiKE5ic3Tb9/c1yZQXM
 iXCFnfFWdCwYFDAQFGPfEQ5hM9t8D29iYi9khhe19CvOlHpiNJm1C5RuP9lAQptIzVcW
 lEK181LHZGRe3SVnso6BmBw201PjugQM9VjkPlQ3tFIxTAVZn8ZwQESryKKNaXkLAhNY
 PID4UdlGKCgEwm41dmPrPHieKuhnuWYSYIvn3SMKqCdpYbkn4JGwwnzg5M/HotWdyJBV
 20Z663WBY60rVn011QGl8cz5p9CkXPihSskmyQwbCEVDySmEOHR8I/WlQq1VXCBlEXqN
 OEmw==
X-Gm-Message-State: AOJu0YzKV/P+eCMruIsK2cOBp1j4Kbfr/yvWT3oCWbgYjOsPpGgQQK+L
 rIM3/LzAaosIST+9j4aNnY3zu62j2xxiUWg9xpE55SjwkQihzEBw/EmxC2XUiatjRms13IF0xsi
 QUEOuBw==
X-Google-Smtp-Source: AGHT+IHUKDTdNZRwcXy6qcTdWZtXHLd/cpimcGFiFXOjk/OOQV8tTEhlKaLMUCrKntJJpRl/VUqhcA==
X-Received: by 2002:a05:6214:2401:b0:6a0:cad1:9ccf with SMTP id
 fv1-20020a056214240100b006a0cad19ccfmr2502500qvb.51.1714484171587; 
 Tue, 30 Apr 2024 06:36:11 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:11 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@intel.com>
Subject: [PATCH 08/33] arm: socfpga: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:34 -0600
Message-Id: <20240430133559.1836389-8-trini@konsulko.com>
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

Remove <common.h> from all mach-socfpga files and when needed add missing
include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
Cc: Marek Vasut <marex@denx.de>
Cc: Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>
Cc: Tien Fong Chee <tien.fong.chee@intel.com>
---
 arch/arm/mach-socfpga/board.c                      | 2 +-
 arch/arm/mach-socfpga/clock_manager.c              | 2 +-
 arch/arm/mach-socfpga/clock_manager_agilex.c       | 1 -
 arch/arm/mach-socfpga/clock_manager_arria10.c      | 1 -
 arch/arm/mach-socfpga/clock_manager_gen5.c         | 1 -
 arch/arm/mach-socfpga/clock_manager_n5x.c          | 1 -
 arch/arm/mach-socfpga/clock_manager_s10.c          | 2 +-
 arch/arm/mach-socfpga/firewall.c                   | 2 +-
 arch/arm/mach-socfpga/fpga_manager.c               | 2 +-
 arch/arm/mach-socfpga/freeze_controller.c          | 2 +-
 arch/arm/mach-socfpga/include/mach/clock_manager.h | 2 ++
 arch/arm/mach-socfpga/mailbox_s10.c                | 1 -
 arch/arm/mach-socfpga/misc.c                       | 2 +-
 arch/arm/mach-socfpga/misc_arria10.c               | 2 +-
 arch/arm/mach-socfpga/misc_gen5.c                  | 2 +-
 arch/arm/mach-socfpga/misc_soc64.c                 | 1 -
 arch/arm/mach-socfpga/mmu-arm64_s10.c              | 1 -
 arch/arm/mach-socfpga/pinmux_arria10.c             | 2 +-
 arch/arm/mach-socfpga/reset_manager_arria10.c      | 1 -
 arch/arm/mach-socfpga/reset_manager_gen5.c         | 2 +-
 arch/arm/mach-socfpga/reset_manager_s10.c          | 1 -
 arch/arm/mach-socfpga/scan_manager.c               | 2 +-
 arch/arm/mach-socfpga/secure_reg_helper.c          | 1 -
 arch/arm/mach-socfpga/secure_vab.c                 | 1 -
 arch/arm/mach-socfpga/smc_api.c                    | 3 ++-
 arch/arm/mach-socfpga/spl_a10.c                    | 2 +-
 arch/arm/mach-socfpga/spl_agilex.c                 | 1 -
 arch/arm/mach-socfpga/spl_gen5.c                   | 1 -
 arch/arm/mach-socfpga/spl_n5x.c                    | 1 -
 arch/arm/mach-socfpga/spl_s10.c                    | 1 -
 arch/arm/mach-socfpga/spl_soc64.c                  | 1 -
 arch/arm/mach-socfpga/system_manager_gen5.c        | 1 -
 arch/arm/mach-socfpga/system_manager_soc64.c       | 1 -
 arch/arm/mach-socfpga/timer.c                      | 2 +-
 arch/arm/mach-socfpga/timer_s10.c                  | 1 -
 arch/arm/mach-socfpga/vab.c                        | 2 +-
 arch/arm/mach-socfpga/wrap_handoff_soc64.c         | 1 -
 arch/arm/mach-socfpga/wrap_iocsr_config.c          | 2 +-
 arch/arm/mach-socfpga/wrap_pinmux_config.c         | 3 ++-
 arch/arm/mach-socfpga/wrap_pll_config.c            | 2 +-
 arch/arm/mach-socfpga/wrap_pll_config_soc64.c      | 1 -
 arch/arm/mach-socfpga/wrap_sdram_config.c          | 4 +++-
 42 files changed, 26 insertions(+), 41 deletions(-)

diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
index 616e1afe5de6..feaf5ce45964 100644
--- a/arch/arm/mach-socfpga/board.c
+++ b/arch/arm/mach-socfpga/board.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2015 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
diff --git a/arch/arm/mach-socfpga/clock_manager.c b/arch/arm/mach-socfpga/clock_manager.c
index 9e645a425317..4fcb13f17e6c 100644
--- a/arch/arm/mach-socfpga/clock_manager.c
+++ b/arch/arm/mach-socfpga/clock_manager.c
@@ -3,10 +3,10 @@
  *  Copyright (C) 2013-2017 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <command.h>
 #include <init.h>
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex.c b/arch/arm/mach-socfpga/clock_manager_agilex.c
index 28f593b60e63..9987d5bcee6f 100644
--- a/arch/arm/mach-socfpga/clock_manager_agilex.c
+++ b/arch/arm/mach-socfpga/clock_manager_agilex.c
@@ -5,7 +5,6 @@
  */
 
 #include <clk.h>
-#include <common.h>
 #include <dm.h>
 #include <log.h>
 #include <malloc.h>
diff --git a/arch/arm/mach-socfpga/clock_manager_arria10.c b/arch/arm/mach-socfpga/clock_manager_arria10.c
index 8ab18f6b7252..58b9321131a9 100644
--- a/arch/arm/mach-socfpga/clock_manager_arria10.c
+++ b/arch/arm/mach-socfpga/clock_manager_arria10.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2016-2017 Intel Corporation
  */
 
-#include <common.h>
 #include <fdtdec.h>
 #include <malloc.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-socfpga/clock_manager_gen5.c b/arch/arm/mach-socfpga/clock_manager_gen5.c
index 8fa2760798b8..154ad2154ae7 100644
--- a/arch/arm/mach-socfpga/clock_manager_gen5.c
+++ b/arch/arm/mach-socfpga/clock_manager_gen5.c
@@ -3,7 +3,6 @@
  *  Copyright (C) 2013-2017 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
 #include <time.h>
 #include <asm/io.h>
 #include <dm.h>
diff --git a/arch/arm/mach-socfpga/clock_manager_n5x.c b/arch/arm/mach-socfpga/clock_manager_n5x.c
index 0ed480de670d..c4c071330fc3 100644
--- a/arch/arm/mach-socfpga/clock_manager_n5x.c
+++ b/arch/arm/mach-socfpga/clock_manager_n5x.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-socfpga/clock_manager_s10.c b/arch/arm/mach-socfpga/clock_manager_s10.c
index 45300336d52a..1e148947a338 100644
--- a/arch/arm/mach-socfpga/clock_manager_s10.c
+++ b/arch/arm/mach-socfpga/clock_manager_s10.c
@@ -4,7 +4,7 @@
  *
  */
 
-#include <common.h>
+#include <linux/errno.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/clock_manager.h>
diff --git a/arch/arm/mach-socfpga/firewall.c b/arch/arm/mach-socfpga/firewall.c
index 69229dc651e4..4dec47b8e960 100644
--- a/arch/arm/mach-socfpga/firewall.c
+++ b/arch/arm/mach-socfpga/firewall.c
@@ -4,8 +4,8 @@
  *
  */
 
+#include <mach/base_addr_soc64.h>
 #include <asm/io.h>
-#include <common.h>
 #include <asm/arch/firewall.h>
 #include <asm/arch/system_manager.h>
 
diff --git a/arch/arm/mach-socfpga/fpga_manager.c b/arch/arm/mach-socfpga/fpga_manager.c
index 18d692c63144..c946d4c38d96 100644
--- a/arch/arm/mach-socfpga/fpga_manager.c
+++ b/arch/arm/mach-socfpga/fpga_manager.c
@@ -7,7 +7,7 @@
  * platform code, the real meat is located in drivers/fpga/socfpga.c .
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <linux/errno.h>
 #include <asm/arch/fpga_manager.h>
diff --git a/arch/arm/mach-socfpga/freeze_controller.c b/arch/arm/mach-socfpga/freeze_controller.c
index 561d3408cd8f..7c86350d5eac 100644
--- a/arch/arm/mach-socfpga/freeze_controller.c
+++ b/arch/arm/mach-socfpga/freeze_controller.c
@@ -4,7 +4,7 @@
  */
 
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/freeze_controller.h>
diff --git a/arch/arm/mach-socfpga/include/mach/clock_manager.h b/arch/arm/mach-socfpga/include/mach/clock_manager.h
index 6c9d32b9dd8a..49f3fb2e7057 100644
--- a/arch/arm/mach-socfpga/include/mach/clock_manager.h
+++ b/arch/arm/mach-socfpga/include/mach/clock_manager.h
@@ -6,6 +6,8 @@
 #ifndef _CLOCK_MANAGER_H_
 #define _CLOCK_MANAGER_H_
 
+#include <linux/types.h>
+
 phys_addr_t socfpga_get_clkmgr_addr(void);
 
 #ifndef __ASSEMBLY__
diff --git a/arch/arm/mach-socfpga/mailbox_s10.c b/arch/arm/mach-socfpga/mailbox_s10.c
index 101af2385529..4c86f1e99170 100644
--- a/arch/arm/mach-socfpga/mailbox_s10.c
+++ b/arch/arm/mach-socfpga/mailbox_s10.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/system_manager.h>
diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
index 80ad0870341b..495ba2a0d418 100644
--- a/arch/arm/mach-socfpga/misc.c
+++ b/arch/arm/mach-socfpga/misc.c
@@ -3,7 +3,7 @@
  *  Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <hang.h>
diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
index 93c9e8b0fb40..34c21317894d 100644
--- a/arch/arm/mach-socfpga/misc_arria10.c
+++ b/arch/arm/mach-socfpga/misc_arria10.c
@@ -4,7 +4,7 @@
  */
 
 #include <altera.h>
-#include <common.h>
+#include <config.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <init.h>
diff --git a/arch/arm/mach-socfpga/misc_gen5.c b/arch/arm/mach-socfpga/misc_gen5.c
index e7500c16f720..b898b6f8f226 100644
--- a/arch/arm/mach-socfpga/misc_gen5.c
+++ b/arch/arm/mach-socfpga/misc_gen5.c
@@ -3,7 +3,7 @@
  *  Copyright (C) 2012-2017 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <init.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-socfpga/misc_soc64.c b/arch/arm/mach-socfpga/misc_soc64.c
index 2acdfad07b35..ad1ef0db1869 100644
--- a/arch/arm/mach-socfpga/misc_soc64.c
+++ b/arch/arm/mach-socfpga/misc_soc64.c
@@ -5,7 +5,6 @@
  */
 
 #include <altera.h>
-#include <common.h>
 #include <asm/arch/mailbox_s10.h>
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
diff --git a/arch/arm/mach-socfpga/mmu-arm64_s10.c b/arch/arm/mach-socfpga/mmu-arm64_s10.c
index 91c6d7c55f13..b8e40d9a7889 100644
--- a/arch/arm/mach-socfpga/mmu-arm64_s10.c
+++ b/arch/arm/mach-socfpga/mmu-arm64_s10.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
 
diff --git a/arch/arm/mach-socfpga/pinmux_arria10.c b/arch/arm/mach-socfpga/pinmux_arria10.c
index f378fce7f02d..c8074f47e760 100644
--- a/arch/arm/mach-socfpga/pinmux_arria10.c
+++ b/arch/arm/mach-socfpga/pinmux_arria10.c
@@ -4,9 +4,9 @@
  */
 
 #include <log.h>
+#include <linux/errno.h>
 #include <asm/arch/pinmux.h>
 #include <asm/io.h>
-#include <common.h>
 #include <fdtdec.h>
 
 static int do_pinctr_pin(const void *blob, int child, const char *node_name)
diff --git a/arch/arm/mach-socfpga/reset_manager_arria10.c b/arch/arm/mach-socfpga/reset_manager_arria10.c
index 27c030801134..da335f4292cb 100644
--- a/arch/arm/mach-socfpga/reset_manager_arria10.c
+++ b/arch/arm/mach-socfpga/reset_manager_arria10.c
@@ -9,7 +9,6 @@
 #include <asm/arch/misc.h>
 #include <asm/arch/reset_manager.h>
 #include <asm/arch/system_manager.h>
-#include <common.h>
 #include <errno.h>
 #include <fdtdec.h>
 #include <wait_bit.h>
diff --git a/arch/arm/mach-socfpga/reset_manager_gen5.c b/arch/arm/mach-socfpga/reset_manager_gen5.c
index a65860ef021a..9395122dae13 100644
--- a/arch/arm/mach-socfpga/reset_manager_gen5.c
+++ b/arch/arm/mach-socfpga/reset_manager_gen5.c
@@ -4,7 +4,7 @@
  */
 
 
-#include <common.h>
+#include <mach/base_addr_ac5.h>
 #include <asm/io.h>
 #include <asm/arch/fpga_manager.h>
 #include <asm/arch/reset_manager.h>
diff --git a/arch/arm/mach-socfpga/reset_manager_s10.c b/arch/arm/mach-socfpga/reset_manager_s10.c
index f47fec10a0c6..dd0383c7c76d 100644
--- a/arch/arm/mach-socfpga/reset_manager_s10.c
+++ b/arch/arm/mach-socfpga/reset_manager_s10.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <hang.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-socfpga/scan_manager.c b/arch/arm/mach-socfpga/scan_manager.c
index 36d6880141ea..f8811525da4d 100644
--- a/arch/arm/mach-socfpga/scan_manager.c
+++ b/arch/arm/mach-socfpga/scan_manager.c
@@ -3,7 +3,7 @@
  *  Copyright (C) 2013 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <errno.h>
 #include <asm/io.h>
 #include <asm/arch/freeze_controller.h>
diff --git a/arch/arm/mach-socfpga/secure_reg_helper.c b/arch/arm/mach-socfpga/secure_reg_helper.c
index 0d4f45f33da5..802a966ce87a 100644
--- a/arch/arm/mach-socfpga/secure_reg_helper.c
+++ b/arch/arm/mach-socfpga/secure_reg_helper.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <hang.h>
 #include <asm/io.h>
 #include <asm/system.h>
diff --git a/arch/arm/mach-socfpga/secure_vab.c b/arch/arm/mach-socfpga/secure_vab.c
index e2db58850643..4347bf6e7927 100644
--- a/arch/arm/mach-socfpga/secure_vab.c
+++ b/arch/arm/mach-socfpga/secure_vab.c
@@ -8,7 +8,6 @@
 #include <asm/arch/secure_vab.h>
 #include <asm/arch/smc_api.h>
 #include <asm/unaligned.h>
-#include <common.h>
 #include <exports.h>
 #include <linux/errno.h>
 #include <linux/intel-smc.h>
diff --git a/arch/arm/mach-socfpga/smc_api.c b/arch/arm/mach-socfpga/smc_api.c
index 8ffc7a472b5b..ebaa0b8fa170 100644
--- a/arch/arm/mach-socfpga/smc_api.c
+++ b/arch/arm/mach-socfpga/smc_api.c
@@ -4,10 +4,11 @@
  *
  */
 
-#include <common.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
+#include <linux/errno.h>
 #include <linux/intel-smc.h>
+#include <linux/string.h>
 
 int invoke_smc(u32 func_id, u64 *args, int arg_len, u64 *ret_arg, int ret_len)
 {
diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index 3981d2d4f140..af5bed162e2f 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -3,7 +3,7 @@
  *  Copyright (C) 2012-2021 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <cpu_func.h>
 #include <hang.h>
 #include <init.h>
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index ee5a9dc1e2f5..cd1bf48d8324 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -10,7 +10,6 @@
 #include <asm/io.h>
 #include <asm/u-boot.h>
 #include <asm/utils.h>
-#include <common.h>
 #include <hang.h>
 #include <image.h>
 #include <spl.h>
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index 287fbd1713c6..d53592cba4d8 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -3,7 +3,6 @@
  *  Copyright (C) 2012 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index d056871d2924..a19602039397 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/firewall.h>
 #include <asm/arch/mailbox_s10.h>
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index c20e87cdbef3..9b3c75f97677 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -11,7 +11,6 @@
 #include <asm/io.h>
 #include <asm/u-boot.h>
 #include <asm/utils.h>
-#include <common.h>
 #include <debug_uart.h>
 #include <image.h>
 #include <spl.h>
diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_soc64.c
index ba6efc1d8641..4fe67ea08112 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <spl.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-socfpga/system_manager_gen5.c b/arch/arm/mach-socfpga/system_manager_gen5.c
index 09caebb3c882..c377d1c32c79 100644
--- a/arch/arm/mach-socfpga/system_manager_gen5.c
+++ b/arch/arm/mach-socfpga/system_manager_gen5.c
@@ -3,7 +3,6 @@
  * Copyright (C) 2013-2017 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/system_manager.h>
 #include <asm/arch/fpga_manager.h>
diff --git a/arch/arm/mach-socfpga/system_manager_soc64.c b/arch/arm/mach-socfpga/system_manager_soc64.c
index 958bb5107b5b..4b42158be9d9 100644
--- a/arch/arm/mach-socfpga/system_manager_soc64.c
+++ b/arch/arm/mach-socfpga/system_manager_soc64.c
@@ -8,7 +8,6 @@
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <common.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-socfpga/timer.c b/arch/arm/mach-socfpga/timer.c
index d9e8c84bfcfe..99de5744c48f 100644
--- a/arch/arm/mach-socfpga/timer.c
+++ b/arch/arm/mach-socfpga/timer.c
@@ -3,7 +3,7 @@
  *  Copyright (C) 2012 Altera Corporation <www.altera.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/timer.h>
diff --git a/arch/arm/mach-socfpga/timer_s10.c b/arch/arm/mach-socfpga/timer_s10.c
index 84b13ce9d3a9..809335863190 100644
--- a/arch/arm/mach-socfpga/timer_s10.c
+++ b/arch/arm/mach-socfpga/timer_s10.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <init.h>
 #include <div64.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-socfpga/vab.c b/arch/arm/mach-socfpga/vab.c
index e146f2c52901..e74c71cfbb44 100644
--- a/arch/arm/mach-socfpga/vab.c
+++ b/arch/arm/mach-socfpga/vab.c
@@ -4,9 +4,9 @@
  *
  */
 
+#include <vsprintf.h>
 #include <asm/arch/secure_vab.h>
 #include <command.h>
-#include <common.h>
 #include <linux/ctype.h>
 
 static int do_vab(struct cmd_tbl *cmdtp, int flag, int argc,
diff --git a/arch/arm/mach-socfpga/wrap_handoff_soc64.c b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
index 6aa9bb26b4ec..92051d19b737 100644
--- a/arch/arm/mach-socfpga/wrap_handoff_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_handoff_soc64.c
@@ -6,7 +6,6 @@
 
 #include <asm/arch/handoff_soc64.h>
 #include <asm/io.h>
-#include <common.h>
 #include <errno.h>
 #include "log.h"
 
diff --git a/arch/arm/mach-socfpga/wrap_iocsr_config.c b/arch/arm/mach-socfpga/wrap_iocsr_config.c
index ce86f04cad1f..43ce329dd10f 100644
--- a/arch/arm/mach-socfpga/wrap_iocsr_config.c
+++ b/arch/arm/mach-socfpga/wrap_iocsr_config.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <errno.h>
 #include <asm/arch/clock_manager.h>
 
diff --git a/arch/arm/mach-socfpga/wrap_pinmux_config.c b/arch/arm/mach-socfpga/wrap_pinmux_config.c
index 33ca14c9dc76..e494d2eb3f9f 100644
--- a/arch/arm/mach-socfpga/wrap_pinmux_config.c
+++ b/arch/arm/mach-socfpga/wrap_pinmux_config.c
@@ -3,8 +3,9 @@
  * Copyright (C) 2015 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
 #include <errno.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
 
 /* Board-specific header. */
 #include <qts/pinmux_config.h>
diff --git a/arch/arm/mach-socfpga/wrap_pll_config.c b/arch/arm/mach-socfpga/wrap_pll_config.c
index 0c40ae987613..e0d0f8f81b7c 100644
--- a/arch/arm/mach-socfpga/wrap_pll_config.c
+++ b/arch/arm/mach-socfpga/wrap_pll_config.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2015 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/arch/clock_manager.h>
 #include <qts/pll_config.h>
 
diff --git a/arch/arm/mach-socfpga/wrap_pll_config_soc64.c b/arch/arm/mach-socfpga/wrap_pll_config_soc64.c
index 6a0d6b5ead72..f13581033e6b 100644
--- a/arch/arm/mach-socfpga/wrap_pll_config_soc64.c
+++ b/arch/arm/mach-socfpga/wrap_pll_config_soc64.c
@@ -4,7 +4,6 @@
  *
  */
 
-#include <common.h>
 #include <asm/arch/clock_manager.h>
 #include <asm/io.h>
 #include <asm/arch/handoff_soc64.h>
diff --git a/arch/arm/mach-socfpga/wrap_sdram_config.c b/arch/arm/mach-socfpga/wrap_sdram_config.c
index cd3a0f663355..8f3fbaf80c8c 100644
--- a/arch/arm/mach-socfpga/wrap_sdram_config.c
+++ b/arch/arm/mach-socfpga/wrap_sdram_config.c
@@ -3,8 +3,10 @@
  * Copyright (C) 2015 Marek Vasut <marex@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <errno.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
 #include <asm/arch/sdram.h>
 
 /* Board-specific header. */
-- 
2.34.1

