Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052F1C4345F
	for <u-boot@archiver.kernel.org>; Tue, 30 Apr 2024 13:38:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 765B288A56;
	Tue, 30 Apr 2024 15:36:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="C7G71g5q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 058C288A34; Tue, 30 Apr 2024 15:36:23 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB9F788A20
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 15:36:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-3c75075ad30so3644236b6e.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 06:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714484177; x=1715088977; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=jD4D294878t/OED6QV7DeWNjEdc6BN+D4uGf17GbvPA=;
 b=C7G71g5qflc9NS3enH6pDRcfpa2A2k0N7ohtgEkelw4Y8WYo7iZmiQr4tcaAiNkoQw
 OL2pexrYVypx1t4sIGs2nLObu1IJngP+cyHnqEZyq9Ub4oxvWraLA8Rg6ZViBU8+etVm
 8IbVEUWxV+wzS6kLhGQ9gZcP+Cakb6am/CmMU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714484177; x=1715088977;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jD4D294878t/OED6QV7DeWNjEdc6BN+D4uGf17GbvPA=;
 b=cnb3HTRhMPKTkI0z9RIn2SKDOrtEqWzQ2iUkrIb72WebsLJGaAaDgxDywWdM/AfhuL
 bltb/tGoZlXu4e9MJ9+PphKUC7+UKQrx+QAHKqPBc4abr+Jh8/fNxGrMUaGlNIeyBfy4
 /gKV1vx5ZuQANyVxuO3YKc+QGV7Rhsd1eyHIRBkpLh4OAlGYof1QnAKkkwQF6wzockUv
 kFcDGMccGad8U8dqQajzP5hNHaOlqE2BeSNaHTnDRu+th5k+GlLgetrqjEZgASVqUl0M
 lZdFqEflKX7fiPVAPPbYwPRNt/LNP+rA/dMYWkK8ALagL5cs0IwUARXd1WUgl+csf1M6
 8m/g==
X-Gm-Message-State: AOJu0YzWsBaFkOUo0L1jAiqY+e96rYVNsFiIxe9W4htYy3TnD1ygUEzu
 onp19fjqxGYTPgW9xGMx/nl14TQMsj6UZRN9smz5z3JRX13BQRLn75uFiaI/ZbkZ1GPCRajlvHD
 1JT6x4w==
X-Google-Smtp-Source: AGHT+IHBXOqDSLArL5whMaM+d//ay1dXvkkrqDpl+tV5HzG7y1BtEBRI4j3vNXUhCGK0j1fxlfQCIA==
X-Received: by 2002:a05:6808:1990:b0:3c8:4d28:b5f7 with SMTP id
 bj16-20020a056808199000b003c84d28b5f7mr18676276oib.12.1714484177010; 
 Tue, 30 Apr 2024 06:36:17 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a05621400cc00b006a0d0d792cesm1743877qvs.83.2024.04.30.06.36.16
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 06:36:16 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 13/33] arm: omap2: Remove <common.h> and add needed includes
Date: Tue, 30 Apr 2024 07:35:39 -0600
Message-Id: <20240430133559.1836389-13-trini@konsulko.com>
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

Remove <common.h> from all mach-omap2 files and when needed add
missing include files directly.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/arch-am33xx/clk_synthesizer.h | 2 ++
 arch/arm/mach-omap2/abb.c                          | 1 -
 arch/arm/mach-omap2/am33xx/board.c                 | 2 +-
 arch/arm/mach-omap2/am33xx/chilisom.c              | 1 -
 arch/arm/mach-omap2/am33xx/clk_synthesizer.c       | 3 +--
 arch/arm/mach-omap2/am33xx/clock.c                 | 1 -
 arch/arm/mach-omap2/am33xx/clock_am33xx.c          | 1 -
 arch/arm/mach-omap2/am33xx/clock_am43xx.c          | 1 -
 arch/arm/mach-omap2/am33xx/ddr.c                   | 2 +-
 arch/arm/mach-omap2/am33xx/emif4.c                 | 1 -
 arch/arm/mach-omap2/am33xx/fdt.c                   | 1 -
 arch/arm/mach-omap2/am33xx/mux.c                   | 1 -
 arch/arm/mach-omap2/am33xx/sys_info.c              | 1 -
 arch/arm/mach-omap2/boot-common.c                  | 1 -
 arch/arm/mach-omap2/clocks-common.c                | 1 -
 arch/arm/mach-omap2/emif-common.c                  | 2 +-
 arch/arm/mach-omap2/fdt-common.c                   | 2 +-
 arch/arm/mach-omap2/hwinit-common.c                | 1 -
 arch/arm/mach-omap2/mem-common.c                   | 2 +-
 arch/arm/mach-omap2/omap-cache.c                   | 3 ++-
 arch/arm/mach-omap2/omap3/am35x_musb.c             | 2 +-
 arch/arm/mach-omap2/omap3/board.c                  | 1 -
 arch/arm/mach-omap2/omap3/boot.c                   | 1 -
 arch/arm/mach-omap2/omap3/clock.c                  | 3 ++-
 arch/arm/mach-omap2/omap3/emac.c                   | 1 -
 arch/arm/mach-omap2/omap3/emif4.c                  | 3 ++-
 arch/arm/mach-omap2/omap3/sdrc.c                   | 2 +-
 arch/arm/mach-omap2/omap3/spl_id_nand.c            | 1 -
 arch/arm/mach-omap2/omap3/sys_info.c               | 3 ++-
 arch/arm/mach-omap2/omap4/boot.c                   | 1 -
 arch/arm/mach-omap2/omap4/emif.c                   | 1 -
 arch/arm/mach-omap2/omap4/hw_data.c                | 1 -
 arch/arm/mach-omap2/omap4/hwinit.c                 | 1 -
 arch/arm/mach-omap2/omap4/sdram_elpida.c           | 1 -
 arch/arm/mach-omap2/omap5/abb.c                    | 2 +-
 arch/arm/mach-omap2/omap5/boot.c                   | 1 -
 arch/arm/mach-omap2/omap5/dra7xx_iodelay.c         | 2 +-
 arch/arm/mach-omap2/omap5/emif.c                   | 1 -
 arch/arm/mach-omap2/omap5/fdt.c                    | 2 +-
 arch/arm/mach-omap2/omap5/hw_data.c                | 1 -
 arch/arm/mach-omap2/omap5/hwinit.c                 | 1 -
 arch/arm/mach-omap2/omap5/sdram.c                  | 1 -
 arch/arm/mach-omap2/sec-common.c                   | 2 +-
 arch/arm/mach-omap2/timer.c                        | 2 +-
 arch/arm/mach-omap2/utils.c                        | 2 +-
 arch/arm/mach-omap2/vc.c                           | 2 +-
 46 files changed, 25 insertions(+), 46 deletions(-)

diff --git a/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h b/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h
index 8e3d55f3e763..393bc7a6a8a5 100644
--- a/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h
+++ b/arch/arm/include/asm/arch-am33xx/clk_synthesizer.h
@@ -10,6 +10,8 @@
 #ifndef __CLK_SYNTHESIZER_H
 #define __CLK_SYNTHESIZER_H
 
+#include <linux/types.h>
+
 #define CLK_SYNTHESIZER_ID_REG		0x0
 #define CLK_SYNTHESIZER_XCSEL		0x05
 #define CLK_SYNTHESIZER_MUX_REG		0x14
diff --git a/arch/arm/mach-omap2/abb.c b/arch/arm/mach-omap2/abb.c
index 722e6db0566d..ce33d2fe1297 100644
--- a/arch/arm/mach-omap2/abb.c
+++ b/arch/arm/mach-omap2/abb.c
@@ -8,7 +8,6 @@
  * Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
  */
 
-#include <common.h>
 #include <asm/omap_common.h>
 #include <asm/arch/clock.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-omap2/am33xx/board.c b/arch/arm/mach-omap2/am33xx/board.c
index 09659da5867d..78c1e965c9f5 100644
--- a/arch/arm/mach-omap2/am33xx/board.c
+++ b/arch/arm/mach-omap2/am33xx/board.c
@@ -7,7 +7,7 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <dm.h>
 #include <debug_uart.h>
 #include <errno.h>
diff --git a/arch/arm/mach-omap2/am33xx/chilisom.c b/arch/arm/mach-omap2/am33xx/chilisom.c
index d4f2abe17a97..4765ce0adeea 100644
--- a/arch/arm/mach-omap2/am33xx/chilisom.c
+++ b/arch/arm/mach-omap2/am33xx/chilisom.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2017, Grinn - http://grinn-global.com/
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/clk_synthesizer.h>
diff --git a/arch/arm/mach-omap2/am33xx/clk_synthesizer.c b/arch/arm/mach-omap2/am33xx/clk_synthesizer.c
index 0969a404bf69..b75eb58ee827 100644
--- a/arch/arm/mach-omap2/am33xx/clk_synthesizer.c
+++ b/arch/arm/mach-omap2/am33xx/clk_synthesizer.c
@@ -7,8 +7,7 @@
  * Copyright (C) 2016, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-
-#include <common.h>
+#include <stdio.h>
 #include <asm/arch/clk_synthesizer.h>
 #include <i2c.h>
 
diff --git a/arch/arm/mach-omap2/am33xx/clock.c b/arch/arm/mach-omap2/am33xx/clock.c
index 3273632c648d..f07003c95bc2 100644
--- a/arch/arm/mach-omap2/am33xx/clock.c
+++ b/arch/arm/mach-omap2/am33xx/clock.c
@@ -7,7 +7,6 @@
  *
  * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
-#include <common.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-omap2/am33xx/clock_am33xx.c b/arch/arm/mach-omap2/am33xx/clock_am33xx.c
index d39e7e4fed13..c33d974dccdd 100644
--- a/arch/arm/mach-omap2/am33xx/clock_am33xx.c
+++ b/arch/arm/mach-omap2/am33xx/clock_am33xx.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
diff --git a/arch/arm/mach-omap2/am33xx/clock_am43xx.c b/arch/arm/mach-omap2/am33xx/clock_am43xx.c
index 8039bc2fe751..abd65ffd77fc 100644
--- a/arch/arm/mach-omap2/am33xx/clock_am43xx.c
+++ b/arch/arm/mach-omap2/am33xx/clock_am43xx.c
@@ -8,7 +8,6 @@
  * Copyright (C) 2013, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-omap2/am33xx/ddr.c b/arch/arm/mach-omap2/am33xx/ddr.c
index 61b95c937338..41eec005cb1b 100644
--- a/arch/arm/mach-omap2/am33xx/ddr.c
+++ b/arch/arm/mach-omap2/am33xx/ddr.c
@@ -5,7 +5,7 @@
  * Copyright (C) 2011 Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/ddr_defs.h>
diff --git a/arch/arm/mach-omap2/am33xx/emif4.c b/arch/arm/mach-omap2/am33xx/emif4.c
index b29250b8d207..f19c66822d20 100644
--- a/arch/arm/mach-omap2/am33xx/emif4.c
+++ b/arch/arm/mach-omap2/am33xx/emif4.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/ddr_defs.h>
 #include <asm/arch/hardware.h>
diff --git a/arch/arm/mach-omap2/am33xx/fdt.c b/arch/arm/mach-omap2/am33xx/fdt.c
index 2ec30b1f9c38..3e81616cb746 100644
--- a/arch/arm/mach-omap2/am33xx/fdt.c
+++ b/arch/arm/mach-omap2/am33xx/fdt.c
@@ -3,7 +3,6 @@
  * Copyright 2017 Texas Instruments, Inc.
  */
 
-#include <common.h>
 #include <hang.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
diff --git a/arch/arm/mach-omap2/am33xx/mux.c b/arch/arm/mach-omap2/am33xx/mux.c
index 496055939798..06b08e89e7fb 100644
--- a/arch/arm/mach-omap2/am33xx/mux.c
+++ b/arch/arm/mach-omap2/am33xx/mux.c
@@ -13,7 +13,6 @@
  * GNU General Public License for more details.
  */
 
-#include <common.h>
 #include <asm/arch/mux.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-omap2/am33xx/sys_info.c b/arch/arm/mach-omap2/am33xx/sys_info.c
index 390d540e85a0..87afc096602d 100644
--- a/arch/arm/mach-omap2/am33xx/sys_info.c
+++ b/arch/arm/mach-omap2/am33xx/sys_info.c
@@ -11,7 +11,6 @@
  *      Syed Mohammed Khasim <khasim@ti.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-omap2/boot-common.c b/arch/arm/mach-omap2/boot-common.c
index aa0ab13d5fb1..e1ea3515ac10 100644
--- a/arch/arm/mach-omap2/boot-common.c
+++ b/arch/arm/mach-omap2/boot-common.c
@@ -7,7 +7,6 @@
  * Copyright (C) 2011, Texas Instruments, Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
 #include <ahci.h>
 #include <log.h>
 #include <dm/uclass.h>
diff --git a/arch/arm/mach-omap2/clocks-common.c b/arch/arm/mach-omap2/clocks-common.c
index 390d1f2a649b..2a0c22841d03 100644
--- a/arch/arm/mach-omap2/clocks-common.c
+++ b/arch/arm/mach-omap2/clocks-common.c
@@ -12,7 +12,6 @@
  *	Santosh Shilimkar <santosh.shilimkar@ti.com>
  *	Rajendra Nayak <rnayak@ti.com>
  */
-#include <common.h>
 #include <hang.h>
 #include <i2c.h>
 #include <init.h>
diff --git a/arch/arm/mach-omap2/emif-common.c b/arch/arm/mach-omap2/emif-common.c
index 9daaeef73190..4d431e20779d 100644
--- a/arch/arm/mach-omap2/emif-common.c
+++ b/arch/arm/mach-omap2/emif-common.c
@@ -8,7 +8,7 @@
  * Aneesh V <aneesh@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <init.h>
 #include <log.h>
diff --git a/arch/arm/mach-omap2/fdt-common.c b/arch/arm/mach-omap2/fdt-common.c
index e90d5776703d..c6b4c03b5085 100644
--- a/arch/arm/mach-omap2/fdt-common.c
+++ b/arch/arm/mach-omap2/fdt-common.c
@@ -3,7 +3,7 @@
  * Copyright 2016-2017 Texas Instruments, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <log.h>
 #include <linux/libfdt.h>
 #include <fdt_support.h>
diff --git a/arch/arm/mach-omap2/hwinit-common.c b/arch/arm/mach-omap2/hwinit-common.c
index 0e4572ca41a7..138501602c35 100644
--- a/arch/arm/mach-omap2/hwinit-common.c
+++ b/arch/arm/mach-omap2/hwinit-common.c
@@ -10,7 +10,6 @@
  *	Aneesh V	<aneesh@ti.com>
  *	Steve Sakoman	<steve@sakoman.com>
  */
-#include <common.h>
 #include <debug_uart.h>
 #include <event.h>
 #include <fdtdec.h>
diff --git a/arch/arm/mach-omap2/mem-common.c b/arch/arm/mach-omap2/mem-common.c
index 19197482aa42..00f144eb747b 100644
--- a/arch/arm/mach-omap2/mem-common.c
+++ b/arch/arm/mach-omap2/mem-common.c
@@ -12,7 +12,7 @@
  *     Syed Mohammed Khasim <khasim@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #if IS_ENABLED(CONFIG_TARGET_AM335X_GUARDIAN)
diff --git a/arch/arm/mach-omap2/omap-cache.c b/arch/arm/mach-omap2/omap-cache.c
index 36db58824339..132b205220ca 100644
--- a/arch/arm/mach-omap2/omap-cache.c
+++ b/arch/arm/mach-omap2/omap-cache.c
@@ -11,11 +11,12 @@
  *	Steve Sakoman	<steve@sakoman.com>
  */
 
-#include <common.h>
 #include <cpu_func.h>
 #include <log.h>
+#include <linux/string.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-omap2/omap3/am35x_musb.c b/arch/arm/mach-omap2/omap3/am35x_musb.c
index 1121acc00589..d3807623bc64 100644
--- a/arch/arm/mach-omap2/omap3/am35x_musb.c
+++ b/arch/arm/mach-omap2/omap3/am35x_musb.c
@@ -8,8 +8,8 @@
  * Hema HK <hemahk@ti.com>
  */
 
-#include <common.h>
 #include <log.h>
+#include <time.h>
 #include <dm/device.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
diff --git a/arch/arm/mach-omap2/omap3/board.c b/arch/arm/mach-omap2/omap3/board.c
index c76a95dd5d09..c5ada607f978 100644
--- a/arch/arm/mach-omap2/omap3/board.c
+++ b/arch/arm/mach-omap2/omap3/board.c
@@ -15,7 +15,6 @@
  *      Syed Mohammed Khasim <khasim@ti.com>
  *
  */
-#include <common.h>
 #include <command.h>
 #include <dm.h>
 #include <init.h>
diff --git a/arch/arm/mach-omap2/omap3/boot.c b/arch/arm/mach-omap2/omap3/boot.c
index ea26115b7118..2a36a25e2799 100644
--- a/arch/arm/mach-omap2/omap3/boot.c
+++ b/arch/arm/mach-omap2/omap3/boot.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015 Paul Kocialkowski <contact@paulk.fr>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
 #include <spl.h>
diff --git a/arch/arm/mach-omap2/omap3/clock.c b/arch/arm/mach-omap2/omap3/clock.c
index 13685e0567af..417d1eb846f3 100644
--- a/arch/arm/mach-omap2/omap3/clock.c
+++ b/arch/arm/mach-omap2/omap3/clock.c
@@ -11,11 +11,12 @@
  *      Syed Mohammed Khasim <khasim@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/clock.h>
 #include <asm/arch/clocks_omap3.h>
 #include <asm/arch/mem.h>
+#include <asm/arch/omap.h>
 #include <asm/arch/sys_proto.h>
 #include <command.h>
 
diff --git a/arch/arm/mach-omap2/omap3/emac.c b/arch/arm/mach-omap2/omap3/emac.c
index d0d0b7a75a61..7348e92cabdf 100644
--- a/arch/arm/mach-omap2/omap3/emac.c
+++ b/arch/arm/mach-omap2/omap3/emac.c
@@ -6,7 +6,6 @@
  * (C) Copyright 2011, Ilya Yanok, Emcraft Systems
  */
 
-#include <common.h>
 #include <net.h>
 #include <asm/io.h>
 #include <asm/arch/am35x_def.h>
diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
index 4fbfb387ab08..79960bf46f8b 100644
--- a/arch/arm/mach-omap2/omap3/emif4.c
+++ b/arch/arm/mach-omap2/omap3/emif4.c
@@ -9,9 +9,10 @@
  * Texas Instruments Incorporated - https://www.ti.com/
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index 4d27d82c7881..f08e4b3af5e2 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -21,9 +21,9 @@
  *      Manikandan Pillai <mani.pillai@ti.com>
  */
 
-#include <common.h>
 #include <init.h>
 #include <asm/global_data.h>
+#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-omap2/omap3/spl_id_nand.c b/arch/arm/mach-omap2/omap3/spl_id_nand.c
index 84a0b0ade931..d4712629d9de 100644
--- a/arch/arm/mach-omap2/omap3/spl_id_nand.c
+++ b/arch/arm/mach-omap2/omap3/spl_id_nand.c
@@ -11,7 +11,6 @@
  *     Jian Zhang <jzhang@ti.com>
  */
 
-#include <common.h>
 #include <jffs2/load_kernel.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/omap_gpmc.h>
diff --git a/arch/arm/mach-omap2/omap3/sys_info.c b/arch/arm/mach-omap2/omap3/sys_info.c
index 5f535e278277..1e3fcd597968 100644
--- a/arch/arm/mach-omap2/omap3/sys_info.c
+++ b/arch/arm/mach-omap2/omap3/sys_info.c
@@ -11,9 +11,10 @@
  *      Syed Mohammed Khasim <khasim@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/io.h>
 #include <asm/arch/mem.h>	/* get mem tables */
+#include <asm/arch/omap.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/bootm.h>
 #include <asm/omap_common.h>
diff --git a/arch/arm/mach-omap2/omap4/boot.c b/arch/arm/mach-omap2/omap4/boot.c
index 90b5380ae398..a60249f7fd62 100644
--- a/arch/arm/mach-omap2/omap4/boot.c
+++ b/arch/arm/mach-omap2/omap4/boot.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015 Paul Kocialkowski <contact@paulk.fr>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/omap_common.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-omap2/omap4/emif.c b/arch/arm/mach-omap2/omap4/emif.c
index 35a51645be7f..5b0d3b5c78a0 100644
--- a/arch/arm/mach-omap2/omap4/emif.c
+++ b/arch/arm/mach-omap2/omap4/emif.c
@@ -8,7 +8,6 @@
  * Aneesh V <aneesh@ti.com>
  */
 
-#include <common.h>
 #include <asm/emif.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/utils.h>
diff --git a/arch/arm/mach-omap2/omap4/hw_data.c b/arch/arm/mach-omap2/omap4/hw_data.c
index d587a4d4def0..a81d76554949 100644
--- a/arch/arm/mach-omap2/omap4/hw_data.c
+++ b/arch/arm/mach-omap2/omap4/hw_data.c
@@ -8,7 +8,6 @@
  *
  * Sricharan R <r.sricharan@ti.com>
  */
-#include <common.h>
 #include <asm/arch/omap.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/omap_common.h>
diff --git a/arch/arm/mach-omap2/omap4/hwinit.c b/arch/arm/mach-omap2/omap4/hwinit.c
index 27dfa9142dcd..e3e6cc8e5785 100644
--- a/arch/arm/mach-omap2/omap4/hwinit.c
+++ b/arch/arm/mach-omap2/omap4/hwinit.c
@@ -10,7 +10,6 @@
  *	Aneesh V	<aneesh@ti.com>
  *	Steve Sakoman	<steve@sakoman.com>
  */
-#include <common.h>
 #include <palmas.h>
 #include <asm/armv7.h>
 #include <asm/arch/cpu.h>
diff --git a/arch/arm/mach-omap2/omap4/sdram_elpida.c b/arch/arm/mach-omap2/omap4/sdram_elpida.c
index 2a18cf0215d9..a29a264016ed 100644
--- a/arch/arm/mach-omap2/omap4/sdram_elpida.c
+++ b/arch/arm/mach-omap2/omap4/sdram_elpida.c
@@ -9,7 +9,6 @@
  * Aneesh V <aneesh@ti.com>
  */
 
-#include <common.h>
 #include <asm/emif.h>
 #include <asm/arch/sys_proto.h>
 
diff --git a/arch/arm/mach-omap2/omap5/abb.c b/arch/arm/mach-omap2/omap5/abb.c
index 2f9f8e65d03e..21da0b11661d 100644
--- a/arch/arm/mach-omap2/omap5/abb.c
+++ b/arch/arm/mach-omap2/omap5/abb.c
@@ -8,7 +8,7 @@
  * Andrii Tseglytskyi <andrii.tseglytskyi@ti.com>
  */
 
-#include <common.h>
+#include <asm/arch/omap.h>
 #include <asm/omap_common.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
diff --git a/arch/arm/mach-omap2/omap5/boot.c b/arch/arm/mach-omap2/omap5/boot.c
index 15d6836c6eae..5b479a87516b 100644
--- a/arch/arm/mach-omap2/omap5/boot.c
+++ b/arch/arm/mach-omap2/omap5/boot.c
@@ -5,7 +5,6 @@
  * Copyright (C) 2015 Paul Kocialkowski <contact@paulk.fr>
  */
 
-#include <common.h>
 #include <asm/io.h>
 #include <asm/omap_common.h>
 #include <spl.h>
diff --git a/arch/arm/mach-omap2/omap5/dra7xx_iodelay.c b/arch/arm/mach-omap2/omap5/dra7xx_iodelay.c
index 8569eff31ab5..d50452b5a30b 100644
--- a/arch/arm/mach-omap2/omap5/dra7xx_iodelay.c
+++ b/arch/arm/mach-omap2/omap5/dra7xx_iodelay.c
@@ -6,7 +6,7 @@
  * Lokesh Vutla <lokeshvutla@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <log.h>
 #include <asm/utils.h>
diff --git a/arch/arm/mach-omap2/omap5/emif.c b/arch/arm/mach-omap2/omap5/emif.c
index 2de36b6feca6..d243ff3bd8f0 100644
--- a/arch/arm/mach-omap2/omap5/emif.c
+++ b/arch/arm/mach-omap2/omap5/emif.c
@@ -8,7 +8,6 @@
  * Aneesh V <aneesh@ti.com> for OMAP4
  */
 
-#include <common.h>
 #include <log.h>
 #include <asm/emif.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-omap2/omap5/fdt.c b/arch/arm/mach-omap2/omap5/fdt.c
index 0ca02e664c4b..f75ec47d8210 100644
--- a/arch/arm/mach-omap2/omap5/fdt.c
+++ b/arch/arm/mach-omap2/omap5/fdt.c
@@ -3,7 +3,7 @@
  * Copyright 2016 Texas Instruments, Inc.
  */
 
-#include <common.h>
+#include <config.h>
 #include <hang.h>
 #include <log.h>
 #include <linux/libfdt.h>
diff --git a/arch/arm/mach-omap2/omap5/hw_data.c b/arch/arm/mach-omap2/omap5/hw_data.c
index b39132222ee5..e65727026eff 100644
--- a/arch/arm/mach-omap2/omap5/hw_data.c
+++ b/arch/arm/mach-omap2/omap5/hw_data.c
@@ -8,7 +8,6 @@
  *
  * Sricharan R <r.sricharan@ti.com>
  */
-#include <common.h>
 #include <palmas.h>
 #include <asm/arch/omap.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-omap2/omap5/hwinit.c b/arch/arm/mach-omap2/omap5/hwinit.c
index edab9a92982e..7f41e85c4a67 100644
--- a/arch/arm/mach-omap2/omap5/hwinit.c
+++ b/arch/arm/mach-omap2/omap5/hwinit.c
@@ -11,7 +11,6 @@
  *	Steve Sakoman	<steve@sakoman.com>
  *	Sricharan	<r.sricharan@ti.com>
  */
-#include <common.h>
 #include <cpu_func.h>
 #include <palmas.h>
 #include <asm/armv7.h>
diff --git a/arch/arm/mach-omap2/omap5/sdram.c b/arch/arm/mach-omap2/omap5/sdram.c
index 786da45fac83..6bf4cf4a7582 100644
--- a/arch/arm/mach-omap2/omap5/sdram.c
+++ b/arch/arm/mach-omap2/omap5/sdram.c
@@ -10,7 +10,6 @@
  * Sricharan R <r.sricharan@ti.com>
  */
 
-#include <common.h>
 #include <asm/emif.h>
 #include <asm/arch/sys_proto.h>
 
diff --git a/arch/arm/mach-omap2/sec-common.c b/arch/arm/mach-omap2/sec-common.c
index 64560b21e3f5..16bbc93f4a35 100644
--- a/arch/arm/mach-omap2/sec-common.c
+++ b/arch/arm/mach-omap2/sec-common.c
@@ -12,7 +12,7 @@
  * Andrew F. Davis <afd@ti.com>
  */
 
-#include <common.h>
+#include <config.h>
 #include <command.h>
 #include <cpu_func.h>
 #include <hang.h>
diff --git a/arch/arm/mach-omap2/timer.c b/arch/arm/mach-omap2/timer.c
index 71fdf5bf487c..ed0620e7b63f 100644
--- a/arch/arm/mach-omap2/timer.c
+++ b/arch/arm/mach-omap2/timer.c
@@ -15,7 +15,7 @@
  * Gary Jennejohn, DENX Software Engineering, <garyj@denx.de>
  */
 
-#include <common.h>
+#include <config.h>
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
diff --git a/arch/arm/mach-omap2/utils.c b/arch/arm/mach-omap2/utils.c
index 0623281a3c7d..2326d153b12f 100644
--- a/arch/arm/mach-omap2/utils.c
+++ b/arch/arm/mach-omap2/utils.c
@@ -3,9 +3,9 @@
  * Copyright 2011 Linaro Limited
  * Aneesh V <aneesh@ti.com>
  */
-#include <common.h>
 #include <env.h>
 #include <part.h>
+#include <vsprintf.h>
 #include <asm/setup.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/omap_common.h>
diff --git a/arch/arm/mach-omap2/vc.c b/arch/arm/mach-omap2/vc.c
index 054782efbdbd..cb377aa12723 100644
--- a/arch/arm/mach-omap2/vc.c
+++ b/arch/arm/mach-omap2/vc.c
@@ -14,7 +14,7 @@
  * GNU General Public License for more details.
  */
 
-#include <common.h>
+#include <config.h>
 #include <asm/omap_common.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/arch/clock.h>
-- 
2.34.1

