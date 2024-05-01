Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D22EC4345F
	for <u-boot@archiver.kernel.org>; Wed,  1 May 2024 02:43:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7425188A78;
	Wed,  1 May 2024 04:43:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CHR7Bxb+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3116388A83; Wed,  1 May 2024 04:43:25 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D810A88A77
 for <u-boot@lists.denx.de>; Wed,  1 May 2024 04:43:21 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6a071595d22so33890776d6.3
 for <u-boot@lists.denx.de>; Tue, 30 Apr 2024 19:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1714531400; x=1715136200; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=O+pz41t2szHdytz2cxQo4O8wQab3uhC54qupxEAAGjs=;
 b=CHR7Bxb+7BWXYwglCSb+doKyGv25skXXxK28mNaNksCzaQbTS6TRZvDNNujwLIwwG6
 6y5ne4x11qYGH/UXJGdVXRo/cK1KnWmfrN2YTwIvA0tMHlzwvvIeuxEvFxD4kEoCMz+y
 xLYov+THSPaoKivo9FjlVO6BwVHsZ0Mk918ug=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714531400; x=1715136200;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+pz41t2szHdytz2cxQo4O8wQab3uhC54qupxEAAGjs=;
 b=Dt3eyuxwssEglMTDQserGXyszdrFjG1+n4t7goYJowxr3Y5ywiL55CVOu+Cps0XBY5
 jjUfluFLP42rCtFWuwYW8DwCKuxwD7yv+n62jy+XFgTqXKuUf+hYMlrD3lynMFxVDJrn
 k/Z+7UigwqUnEuuJVa/o2q0ZO1RU+SFY+iOkMV0Is915xvhEPWaosWYPswZYE/L8w13e
 D9vnhs0fXI+kQ55NfsxlW1y0WfUBD6CQX4JbP6SWAug60BTNHqmoCKKbJvUggEXtMU8y
 Y2UQqYiX7rOusAggWL91GGrrB0SNB64Y1dx1anHwHP0QXt8Me/qW3141OF1A01a5VLDS
 jE1Q==
X-Gm-Message-State: AOJu0YzALGlsSOE0BB4u6RkEvfL4AkEAhu1n9s9ownzConAxfuhBO7w5
 BRLAAqVhLsJnUaOIwM99HX5l+QVbrtpdirg9srgDnZ8nwqr9nNiwBDKHn+DqCaYKo4vL4a98Iq5
 DHWS16Q==
X-Google-Smtp-Source: AGHT+IFBScyknM86SMqcW1wquOjVVQDzJaN+SGeNll+7/5wxMfEb25qMSZjTswloAWCghgmdmeNYAQ==
X-Received: by 2002:ad4:5dc9:0:b0:6a0:c912:b7f5 with SMTP id
 m9-20020ad45dc9000000b006a0c912b7f5mr1064493qvh.12.1714531399232; 
 Tue, 30 Apr 2024 19:43:19 -0700 (PDT)
Received: from bill-the-cat.tail58a08.ts.net ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 p3-20020a0cf683000000b006a0ed3ea821sm391763qvn.72.2024.04.30.19.43.17
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Apr 2024 19:43:18 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 001/149] global: Make <asm/global_data.h> include
 <asm/u-boot.h>
Date: Tue, 30 Apr 2024 20:40:48 -0600
Message-Id: <20240501024316.1767971-1-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
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

This follows the example of RISC-V where <asm/global_data.h> includes
<asm/u-boot.h> directly as "gd" includes a reference to bd_info already
and so the first must include the second anyhow. We then remove
<asm/u-boot.h> from all of the places which include references to "gd"
an so have <asm/global_data.h> already.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 api/api_platform-arm.c                         | 1 -
 api/api_platform-mips.c                        | 1 -
 api/api_platform-powerpc.c                     | 1 -
 arch/arc/include/asm/global_data.h             | 2 ++
 arch/arm/include/asm/global_data.h             | 1 +
 arch/arm/lib/bdinfo.c                          | 1 -
 arch/arm/lib/cache-cp15.c                      | 1 -
 arch/arm/mach-davinci/cpu.c                    | 1 -
 arch/arm/mach-davinci/misc.c                   | 1 -
 arch/arm/mach-davinci/spl.c                    | 1 -
 arch/arm/mach-imx/ele_ahab.c                   | 1 -
 arch/arm/mach-imx/mx5/mx53_dram.c              | 1 -
 arch/arm/mach-mediatek/mt7622/init.c           | 1 -
 arch/arm/mach-mediatek/mt7981/init.c           | 1 -
 arch/arm/mach-mediatek/mt7986/init.c           | 1 -
 arch/arm/mach-mediatek/mt7988/init.c           | 1 -
 arch/arm/mach-mvebu/armada8k/dram.c            | 1 -
 arch/arm/mach-mvebu/dram.c                     | 1 -
 arch/arm/mach-omap2/omap-cache.c               | 1 -
 arch/arm/mach-omap2/omap3/emif4.c              | 1 -
 arch/arm/mach-omap2/omap3/sdrc.c               | 1 -
 arch/arm/mach-owl/soc.c                        | 1 -
 arch/arm/mach-renesas/memmap-gen3.c            | 1 -
 arch/arm/mach-renesas/memmap-rzg2l.c           | 1 -
 arch/arm/mach-socfpga/clock_manager.c          | 1 -
 arch/arm/mach-socfpga/clock_manager_agilex5.c  | 1 -
 arch/arm/mach-socfpga/spl_a10.c                | 1 -
 arch/arm/mach-socfpga/spl_agilex.c             | 1 -
 arch/arm/mach-socfpga/spl_gen5.c               | 1 -
 arch/arm/mach-socfpga/spl_n5x.c                | 1 -
 arch/arm/mach-socfpga/spl_s10.c                | 1 -
 arch/arm/mach-uniphier/dram_init.c             | 1 -
 arch/arm/mach-versal-net/clk.c                 | 1 -
 arch/arm/mach-versal-net/cpu.c                 | 1 -
 arch/arm/mach-versal/clk.c                     | 1 -
 arch/arm/mach-versal/cpu.c                     | 1 -
 arch/arm/mach-zynqmp/clk.c                     | 1 -
 arch/arm/mach-zynqmp/cpu.c                     | 1 -
 arch/m68k/include/asm/global_data.h            | 2 ++
 arch/m68k/lib/bdinfo.c                         | 1 -
 arch/microblaze/cpu/spl.c                      | 1 -
 arch/microblaze/include/asm/global_data.h      | 1 +
 arch/mips/include/asm/global_data.h            | 1 +
 arch/mips/lib/traps.c                          | 1 -
 arch/nios2/include/asm/global_data.h           | 1 +
 arch/powerpc/cpu/mpc83xx/interrupts.c          | 1 -
 arch/powerpc/cpu/mpc83xx/pcie.c                | 1 -
 arch/powerpc/cpu/mpc83xx/spd_sdram.c           | 1 -
 arch/powerpc/cpu/mpc83xx/speed.c               | 1 -
 arch/powerpc/cpu/mpc85xx/b4860_ids.c           | 1 +
 arch/powerpc/cpu/mpc85xx/cmd_errata.c          | 1 -
 arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c | 1 -
 arch/powerpc/cpu/mpc85xx/p2041_ids.c           | 3 ++-
 arch/powerpc/cpu/mpc85xx/p2041_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/p3041_ids.c           | 1 +
 arch/powerpc/cpu/mpc85xx/p4080_ids.c           | 1 +
 arch/powerpc/cpu/mpc85xx/p5040_ids.c           | 1 +
 arch/powerpc/cpu/mpc85xx/speed.c               | 1 -
 arch/powerpc/cpu/mpc85xx/spl_minimal.c         | 1 -
 arch/powerpc/cpu/mpc85xx/t1024_ids.c           | 3 ++-
 arch/powerpc/cpu/mpc85xx/t1024_serdes.c        | 1 -
 arch/powerpc/cpu/mpc85xx/t1040_ids.c           | 3 ++-
 arch/powerpc/cpu/mpc85xx/t1040_serdes.c        | 3 ++-
 arch/powerpc/cpu/mpc85xx/t2080_ids.c           | 3 ++-
 arch/powerpc/cpu/mpc85xx/t2080_serdes.c        | 3 ++-
 arch/powerpc/cpu/mpc85xx/t4240_ids.c           | 3 ++-
 arch/powerpc/cpu/mpc85xx/t4240_serdes.c        | 1 -
 arch/powerpc/cpu/mpc8xxx/fsl_lbc.c             | 1 -
 arch/powerpc/cpu/mpc8xxx/fsl_pamu.c            | 4 +++-
 arch/powerpc/cpu/mpc8xxx/law.c                 | 1 -
 arch/powerpc/cpu/mpc8xxx/pamu_table.c          | 1 -
 arch/powerpc/cpu/mpc8xxx/srio.c                | 3 ++-
 arch/powerpc/include/asm/fsl_liodn.h           | 4 +++-
 arch/powerpc/include/asm/fsl_portals.h         | 2 ++
 arch/powerpc/include/asm/global_data.h         | 2 ++
 arch/powerpc/lib/bdinfo.c                      | 1 -
 arch/riscv/lib/boot.c                          | 3 ++-
 arch/sandbox/include/asm/global_data.h         | 1 +
 arch/sh/include/asm/global_data.h              | 2 ++
 arch/x86/cpu/coreboot/sdram.c                  | 1 -
 arch/x86/cpu/efi/payload.c                     | 1 -
 arch/x86/cpu/efi/sdram.c                       | 1 -
 arch/x86/cpu/ivybridge/sdram_nop.c             | 1 -
 arch/x86/cpu/qemu/dram.c                       | 1 -
 arch/x86/cpu/quark/dram.c                      | 1 -
 arch/x86/cpu/tangier/sdram.c                   | 1 -
 arch/x86/include/asm/global_data.h             | 1 +
 arch/xtensa/include/asm/global_data.h          | 2 ++
 board/keymile/kmcent2/tlb.c                    | 2 +-
 board/phytium/pe2201/pe2201.c                  | 1 -
 board/phytium/pomelo/pomelo.c                  | 1 -
 board/renesas/falcon/falcon.c                  | 1 -
 board/renesas/grpeach/grpeach.c                | 1 -
 common/init/handoff.c                          | 1 -
 common/spl/spl.c                               | 1 -
 common/spl/spl_ext.c                           | 1 -
 common/spl/spl_fat.c                           | 1 -
 common/spl/spl_mmc.c                           | 1 -
 common/spl/spl_sata.c                          | 1 -
 common/spl/spl_usb.c                           | 1 -
 common/spl/spl_ymodem.c                        | 1 -
 drivers/clk/altera/clk-agilex5.c               | 1 -
 include/dm/of.h                                | 1 -
 include/fsl_errata.h                           | 2 +-
 104 files changed, 48 insertions(+), 88 deletions(-)

diff --git a/api/api_platform-arm.c b/api/api_platform-arm.c
index 6cfd9e6cc20c..9afba66c2442 100644
--- a/api/api_platform-arm.c
+++ b/api/api_platform-arm.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <api_public.h>
 
-#include <asm/u-boot.h>
 #include <asm/global_data.h>
 
 #include "api_private.h"
diff --git a/api/api_platform-mips.c b/api/api_platform-mips.c
index e1509663af54..262b35a27779 100644
--- a/api/api_platform-mips.c
+++ b/api/api_platform-mips.c
@@ -9,7 +9,6 @@
 #include <linux/types.h>
 #include <api_public.h>
 
-#include <asm/u-boot.h>
 #include <asm/global_data.h>
 
 #include "api_private.h"
diff --git a/api/api_platform-powerpc.c b/api/api_platform-powerpc.c
index 847a4a3015b0..3a04a9f691c5 100644
--- a/api/api_platform-powerpc.c
+++ b/api/api_platform-powerpc.c
@@ -12,7 +12,6 @@
 #include <linux/types.h>
 #include <api_public.h>
 
-#include <asm/u-boot.h>
 #include <asm/global_data.h>
 
 #include "api_private.h"
diff --git a/arch/arc/include/asm/global_data.h b/arch/arc/include/asm/global_data.h
index e35a26f1eb14..fd9b7fb5f8db 100644
--- a/arch/arc/include/asm/global_data.h
+++ b/arch/arc/include/asm/global_data.h
@@ -6,6 +6,8 @@
 #ifndef	__ASM_ARC_GLOBAL_DATA_H
 #define __ASM_ARC_GLOBAL_DATA_H
 
+#include <asm/u-boot.h>
+
 #ifndef __ASSEMBLY__
 /* Architecture-specific global data */
 struct arch_global_data {
diff --git a/arch/arm/include/asm/global_data.h b/arch/arm/include/asm/global_data.h
index 452bcd1b8fd9..45401d5e3c8a 100644
--- a/arch/arm/include/asm/global_data.h
+++ b/arch/arm/include/asm/global_data.h
@@ -12,6 +12,7 @@
 #include <config.h>
 
 #include <linux/types.h>
+#include <asm/u-boot.h>
 
 /* Architecture-specific global data */
 struct arch_global_data {
diff --git a/arch/arm/lib/bdinfo.c b/arch/arm/lib/bdinfo.c
index 40255ace4051..7c49462c8eb4 100644
--- a/arch/arm/lib/bdinfo.c
+++ b/arch/arm/lib/bdinfo.c
@@ -9,7 +9,6 @@
 #include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/mach-types.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/lib/cache-cp15.c b/arch/arm/lib/cache-cp15.c
index 0b2a0c351547..947012f29963 100644
--- a/arch/arm/lib/cache-cp15.c
+++ b/arch/arm/lib/cache-cp15.c
@@ -7,7 +7,6 @@
 #include <cpu_func.h>
 #include <log.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/system.h>
 #include <asm/cache.h>
 #include <linux/compiler.h>
diff --git a/arch/arm/mach-davinci/cpu.c b/arch/arm/mach-davinci/cpu.c
index 033411235391..7c0a26389775 100644
--- a/arch/arm/mach-davinci/cpu.c
+++ b/arch/arm/mach-davinci/cpu.c
@@ -9,7 +9,6 @@
 #include <init.h>
 #include <asm/arch/hardware.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-davinci/misc.c b/arch/arm/mach-davinci/misc.c
index 93a144757a9e..6c97e5810cdb 100644
--- a/arch/arm/mach-davinci/misc.c
+++ b/arch/arm/mach-davinci/misc.c
@@ -16,7 +16,6 @@
 #include <net.h>
 #include <asm/arch/hardware.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/davinci_misc.h>
 
diff --git a/arch/arm/mach-davinci/spl.c b/arch/arm/mach-davinci/spl.c
index 4603c8fbc575..8c6cf9c21925 100644
--- a/arch/arm/mach-davinci/spl.c
+++ b/arch/arm/mach-davinci/spl.c
@@ -7,7 +7,6 @@
 #include <hang.h>
 #include <init.h>
 #include <spl.h>
-#include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <nand.h>
 #include <asm/arch/dm365_lowlevel.h>
diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index eaeecf600423..c13d9f0e00e3 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -14,7 +14,6 @@
 #include <console.h>
 #include <cpu_func.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-imx/mx5/mx53_dram.c b/arch/arm/mach-imx/mx5/mx53_dram.c
index 6459b4a82d25..180a745d4351 100644
--- a/arch/arm/mach-imx/mx5/mx53_dram.c
+++ b/arch/arm/mach-imx/mx5/mx53_dram.c
@@ -6,7 +6,6 @@
 
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-mediatek/mt7622/init.c b/arch/arm/mach-mediatek/mt7622/init.c
index 00d3eb9ce7a4..6e970acf8b05 100644
--- a/arch/arm/mach-mediatek/mt7622/init.c
+++ b/arch/arm/mach-mediatek/mt7622/init.c
@@ -9,7 +9,6 @@
 #include <asm/armv8/mmu.h>
 #include <asm/system.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-mediatek/mt7981/init.c b/arch/arm/mach-mediatek/mt7981/init.c
index 862f0ca4793d..07da58971904 100644
--- a/arch/arm/mach-mediatek/mt7981/init.c
+++ b/arch/arm/mach-mediatek/mt7981/init.c
@@ -9,7 +9,6 @@
 #include <asm/armv8/mmu.h>
 #include <asm/system.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-mediatek/mt7986/init.c b/arch/arm/mach-mediatek/mt7986/init.c
index 905a3ab4e272..a521c95bd9d3 100644
--- a/arch/arm/mach-mediatek/mt7986/init.c
+++ b/arch/arm/mach-mediatek/mt7986/init.c
@@ -9,7 +9,6 @@
 #include <asm/armv8/mmu.h>
 #include <asm/system.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-mediatek/mt7988/init.c b/arch/arm/mach-mediatek/mt7988/init.c
index 082f12bf65e5..2efc8c6a88fe 100644
--- a/arch/arm/mach-mediatek/mt7988/init.c
+++ b/arch/arm/mach-mediatek/mt7988/init.c
@@ -8,7 +8,6 @@
 #include <init.h>
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/system.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/arm/mach-mvebu/armada8k/dram.c b/arch/arm/mach-mvebu/armada8k/dram.c
index 8a87e4a8e035..fd58551d0e32 100644
--- a/arch/arm/mach-mvebu/armada8k/dram.c
+++ b/arch/arm/mach-mvebu/armada8k/dram.c
@@ -7,7 +7,6 @@
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/ptrace.h>
 #include <asm/system.h>
 #include <linux/sizes.h>
diff --git a/arch/arm/mach-mvebu/dram.c b/arch/arm/mach-mvebu/dram.c
index daf2f8e3f671..c00c6b9b3fc2 100644
--- a/arch/arm/mach-mvebu/dram.c
+++ b/arch/arm/mach-mvebu/dram.c
@@ -8,7 +8,6 @@
 #include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/cpu.h>
 #include <asm/arch/soc.h>
diff --git a/arch/arm/mach-omap2/omap-cache.c b/arch/arm/mach-omap2/omap-cache.c
index 132b205220ca..200a08fa5c83 100644
--- a/arch/arm/mach-omap2/omap-cache.c
+++ b/arch/arm/mach-omap2/omap-cache.c
@@ -16,7 +16,6 @@
 #include <linux/string.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-omap2/omap3/emif4.c b/arch/arm/mach-omap2/omap3/emif4.c
index 79960bf46f8b..049eedfeb65b 100644
--- a/arch/arm/mach-omap2/omap3/emif4.c
+++ b/arch/arm/mach-omap2/omap3/emif4.c
@@ -12,7 +12,6 @@
 #include <config.h>
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-omap2/omap3/sdrc.c b/arch/arm/mach-omap2/omap3/sdrc.c
index f08e4b3af5e2..404333689f60 100644
--- a/arch/arm/mach-omap2/omap3/sdrc.c
+++ b/arch/arm/mach-omap2/omap3/sdrc.c
@@ -23,7 +23,6 @@
 
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/mem.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-owl/soc.c b/arch/arm/mach-owl/soc.c
index e6332452e3ee..0130cad76782 100644
--- a/arch/arm/mach-owl/soc.c
+++ b/arch/arm/mach-owl/soc.c
@@ -10,7 +10,6 @@
 #include <init.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
 #include <asm/io.h>
diff --git a/arch/arm/mach-renesas/memmap-gen3.c b/arch/arm/mach-renesas/memmap-gen3.c
index 4dff9e07629d..c50700df078d 100644
--- a/arch/arm/mach-renesas/memmap-gen3.c
+++ b/arch/arm/mach-renesas/memmap-gen3.c
@@ -7,7 +7,6 @@
 
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <cpu_func.h>
 
 #define GEN3_NR_REGIONS 16
diff --git a/arch/arm/mach-renesas/memmap-rzg2l.c b/arch/arm/mach-renesas/memmap-rzg2l.c
index 9934a775220b..3b3c6f7cde9a 100644
--- a/arch/arm/mach-renesas/memmap-rzg2l.c
+++ b/arch/arm/mach-renesas/memmap-rzg2l.c
@@ -8,7 +8,6 @@
 
 #include <asm/armv8/mmu.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <cpu_func.h>
 
 #define RZG2L_NR_REGIONS 16
diff --git a/arch/arm/mach-socfpga/clock_manager.c b/arch/arm/mach-socfpga/clock_manager.c
index 4fcb13f17e6c..160f6e73ca9e 100644
--- a/arch/arm/mach-socfpga/clock_manager.c
+++ b/arch/arm/mach-socfpga/clock_manager.c
@@ -6,7 +6,6 @@
 #include <asm/arch/clock_manager.h>
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <command.h>
 #include <init.h>
diff --git a/arch/arm/mach-socfpga/clock_manager_agilex5.c b/arch/arm/mach-socfpga/clock_manager_agilex5.c
index b92f0b3af806..7ec28d91ef32 100644
--- a/arch/arm/mach-socfpga/clock_manager_agilex5.c
+++ b/arch/arm/mach-socfpga/clock_manager_agilex5.c
@@ -16,7 +16,6 @@
 #include <vsprintf.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <asm/u-boot.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
 #include <linux/types.h>
diff --git a/arch/arm/mach-socfpga/spl_a10.c b/arch/arm/mach-socfpga/spl_a10.c
index af5bed162e2f..c20376f7f8ef 100644
--- a/arch/arm/mach-socfpga/spl_a10.c
+++ b/arch/arm/mach-socfpga/spl_a10.c
@@ -10,7 +10,6 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/pl310.h>
-#include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <image.h>
 #include <asm/arch/reset_manager.h>
diff --git a/arch/arm/mach-socfpga/spl_agilex.c b/arch/arm/mach-socfpga/spl_agilex.c
index cd1bf48d8324..52617a39ccaf 100644
--- a/arch/arm/mach-socfpga/spl_agilex.c
+++ b/arch/arm/mach-socfpga/spl_agilex.c
@@ -8,7 +8,6 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <hang.h>
 #include <image.h>
diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
index d53592cba4d8..df79cfe0f7fa 100644
--- a/arch/arm/mach-socfpga/spl_gen5.c
+++ b/arch/arm/mach-socfpga/spl_gen5.c
@@ -8,7 +8,6 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <image.h>
 #include <asm/arch/reset_manager.h>
diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
index a19602039397..5ff137e5c6fb 100644
--- a/arch/arm/mach-socfpga/spl_n5x.c
+++ b/arch/arm/mach-socfpga/spl_n5x.c
@@ -12,7 +12,6 @@
 #include <asm/arch/system_manager.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <dm/uclass.h>
 #include <hang.h>
diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
index 9b3c75f97677..53852cb74439 100644
--- a/arch/arm/mach-socfpga/spl_s10.c
+++ b/arch/arm/mach-socfpga/spl_s10.c
@@ -9,7 +9,6 @@
 #include <log.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
-#include <asm/u-boot.h>
 #include <asm/utils.h>
 #include <debug_uart.h>
 #include <image.h>
diff --git a/arch/arm/mach-uniphier/dram_init.c b/arch/arm/mach-uniphier/dram_init.c
index e6f1286e71fd..0e1164a2680f 100644
--- a/arch/arm/mach-uniphier/dram_init.c
+++ b/arch/arm/mach-uniphier/dram_init.c
@@ -12,7 +12,6 @@
 #include <linux/printk.h>
 #include <linux/sizes.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 #include "init.h"
 #include "sg-regs.h"
diff --git a/arch/arm/mach-versal-net/clk.c b/arch/arm/mach-versal-net/clk.c
index a88b5101eb1b..61b8fe71b1ae 100644
--- a/arch/arm/mach-versal-net/clk.c
+++ b/arch/arm/mach-versal-net/clk.c
@@ -9,7 +9,6 @@
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-versal-net/cpu.c b/arch/arm/mach-versal-net/cpu.c
index 59b0cb2e78f3..d088e440f638 100644
--- a/arch/arm/mach-versal-net/cpu.c
+++ b/arch/arm/mach-versal-net/cpu.c
@@ -10,7 +10,6 @@
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-versal/clk.c b/arch/arm/mach-versal/clk.c
index 0c7d468f1dd0..19943dfdd4ca 100644
--- a/arch/arm/mach-versal/clk.c
+++ b/arch/arm/mach-versal/clk.c
@@ -7,7 +7,6 @@
 #include <init.h>
 #include <time.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-versal/cpu.c b/arch/arm/mach-versal/cpu.c
index 7de431e55005..363ce3007fd1 100644
--- a/arch/arm/mach-versal/cpu.c
+++ b/arch/arm/mach-versal/cpu.c
@@ -8,7 +8,6 @@
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
diff --git a/arch/arm/mach-zynqmp/clk.c b/arch/arm/mach-zynqmp/clk.c
index dc8e2cbd3da4..9b573b1746aa 100644
--- a/arch/arm/mach-zynqmp/clk.c
+++ b/arch/arm/mach-zynqmp/clk.c
@@ -10,7 +10,6 @@
 #include <asm/arch/hardware.h>
 #include <asm/arch/sys_proto.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
index d7b5e99504c4..07668c946891 100644
--- a/arch/arm/mach-zynqmp/cpu.c
+++ b/arch/arm/mach-zynqmp/cpu.c
@@ -13,7 +13,6 @@
 #include <asm/armv8/mmu.h>
 #include <asm/cache.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/io.h>
 #include <zynqmp_firmware.h>
 #include <asm/cache.h>
diff --git a/arch/m68k/include/asm/global_data.h b/arch/m68k/include/asm/global_data.h
index c2ef5770a3df..93efc722ba8a 100644
--- a/arch/m68k/include/asm/global_data.h
+++ b/arch/m68k/include/asm/global_data.h
@@ -7,6 +7,8 @@
 #ifndef	__ASM_GBL_DATA_H
 #define __ASM_GBL_DATA_H
 
+#include <asm/u-boot.h>
+
 /* Architecture-specific global data */
 struct arch_global_data {
 #ifdef CONFIG_SYS_I2C_FSL
diff --git a/arch/m68k/lib/bdinfo.c b/arch/m68k/lib/bdinfo.c
index 3719f11c03c6..cf6ae5adddfd 100644
--- a/arch/m68k/lib/bdinfo.c
+++ b/arch/m68k/lib/bdinfo.c
@@ -8,7 +8,6 @@
 
 #include <config.h>
 #include <init.h>
-#include <asm/u-boot.h>
 #include <asm/global_data.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/microblaze/cpu/spl.c b/arch/microblaze/cpu/spl.c
index cb224bd25423..521776705786 100644
--- a/arch/microblaze/cpu/spl.c
+++ b/arch/microblaze/cpu/spl.c
@@ -10,7 +10,6 @@
 #include <log.h>
 #include <spl.h>
 #include <asm/io.h>
-#include <asm/u-boot.h>
 #include <linux/stringify.h>
 
 void board_boot_order(u32 *spl_boot_list)
diff --git a/arch/microblaze/include/asm/global_data.h b/arch/microblaze/include/asm/global_data.h
index 93506dec894e..bb4112f22a3c 100644
--- a/arch/microblaze/include/asm/global_data.h
+++ b/arch/microblaze/include/asm/global_data.h
@@ -9,6 +9,7 @@
 #define __ASM_GBL_DATA_H
 
 #include <asm/cpuinfo.h>
+#include <asm/u-boot.h>
 
 /* Architecture-specific global data */
 struct arch_global_data {
diff --git a/arch/mips/include/asm/global_data.h b/arch/mips/include/asm/global_data.h
index 34b7e0bed945..147a95ecea8b 100644
--- a/arch/mips/include/asm/global_data.h
+++ b/arch/mips/include/asm/global_data.h
@@ -9,6 +9,7 @@
 
 #include <linux/types.h>
 #include <asm/regdef.h>
+#include <asm/u-boot.h>
 
 struct octeon_eeprom_mac_addr {
 	u8 mac_addr_base[6];
diff --git a/arch/mips/lib/traps.c b/arch/mips/lib/traps.c
index 40469d1be090..89846c9723c7 100644
--- a/arch/mips/lib/traps.c
+++ b/arch/mips/lib/traps.c
@@ -20,7 +20,6 @@
 #include <asm/mipsregs.h>
 #include <asm/addrspace.h>
 #include <asm/system.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/nios2/include/asm/global_data.h b/arch/nios2/include/asm/global_data.h
index b56e8a5078e0..d9bbd54734e5 100644
--- a/arch/nios2/include/asm/global_data.h
+++ b/arch/nios2/include/asm/global_data.h
@@ -7,6 +7,7 @@
 #define __ASM_NIOS2_GLOBALDATA_H_
 
 #include <linux/types.h>
+#include <asm/u-boot.h>
 
 /* Architecture-specific global data */
 struct arch_global_data {
diff --git a/arch/powerpc/cpu/mpc83xx/interrupts.c b/arch/powerpc/cpu/mpc83xx/interrupts.c
index 6238eec605f2..d86c981811e9 100644
--- a/arch/powerpc/cpu/mpc83xx/interrupts.c
+++ b/arch/powerpc/cpu/mpc83xx/interrupts.c
@@ -6,7 +6,6 @@
  * Copyright 2004 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <command.h>
 #include <irq_func.h>
 #include <mpc83xx.h>
diff --git a/arch/powerpc/cpu/mpc83xx/pcie.c b/arch/powerpc/cpu/mpc83xx/pcie.c
index feecf8a8193c..efa30c683389 100644
--- a/arch/powerpc/cpu/mpc83xx/pcie.c
+++ b/arch/powerpc/cpu/mpc83xx/pcie.c
@@ -7,7 +7,6 @@
  *          Anton Vorontsov <avorontsov@ru.mvista.com>
  */
 
-#include <asm/u-boot.h>
 #include <clock_legacy.h>
 #include <pci.h>
 #include <mpc83xx.h>
diff --git a/arch/powerpc/cpu/mpc83xx/spd_sdram.c b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
index 37234e00abd0..e847c03f378b 100644
--- a/arch/powerpc/cpu/mpc83xx/spd_sdram.c
+++ b/arch/powerpc/cpu/mpc83xx/spd_sdram.c
@@ -12,7 +12,6 @@
 
 #ifndef CONFIG_MPC83XX_SDRAM
 
-#include <asm/u-boot.h>
 #include <cpu_func.h>
 #include <log.h>
 #include <time.h>
diff --git a/arch/powerpc/cpu/mpc83xx/speed.c b/arch/powerpc/cpu/mpc83xx/speed.c
index bfc624232179..72464962613f 100644
--- a/arch/powerpc/cpu/mpc83xx/speed.c
+++ b/arch/powerpc/cpu/mpc83xx/speed.c
@@ -8,7 +8,6 @@
 
 #ifndef CONFIG_CLK_MPC83XX
 
-#include <asm/u-boot.h>
 #include <clock_legacy.h>
 #include <mpc83xx.h>
 #include <command.h>
diff --git a/arch/powerpc/cpu/mpc85xx/b4860_ids.c b/arch/powerpc/cpu/mpc85xx/b4860_ids.c
index 39cfd20129ff..df2f0efe3eda 100644
--- a/arch/powerpc/cpu/mpc85xx/b4860_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/b4860_ids.c
@@ -4,6 +4,7 @@
  */
 
 #include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/cmd_errata.c b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
index 01763b54e8af..f91a4d441d3a 100644
--- a/arch/powerpc/cpu/mpc85xx/cmd_errata.c
+++ b/arch/powerpc/cpu/mpc85xx/cmd_errata.c
@@ -3,7 +3,6 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <command.h>
 #include <init.h>
 #include <linux/compiler.h>
diff --git a/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c b/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
index 3383bb5c9b02..945020f7ecbe 100644
--- a/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/fsl_corenet2_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <log.h>
 #include <asm/fsl_serdes.h>
 #include <asm/immap_85xx.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p2041_ids.c b/arch/powerpc/cpu/mpc85xx/p2041_ids.c
index 67a21e15a64d..ae5227a1eed1 100644
--- a/arch/powerpc/cpu/mpc85xx/p2041_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p2041_ids.c
@@ -3,7 +3,8 @@
  * Copyright 2011 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/p2041_serdes.c b/arch/powerpc/cpu/mpc85xx/p2041_serdes.c
index d915665df8f5..3943859a5188 100644
--- a/arch/powerpc/cpu/mpc85xx/p2041_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/p2041_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/p3041_ids.c b/arch/powerpc/cpu/mpc85xx/p3041_ids.c
index e5d600fa2a4d..0675a59414be 100644
--- a/arch/powerpc/cpu/mpc85xx/p3041_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p3041_ids.c
@@ -4,6 +4,7 @@
  */
 
 #include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/p4080_ids.c b/arch/powerpc/cpu/mpc85xx/p4080_ids.c
index 250504128374..15ab4ac93852 100644
--- a/arch/powerpc/cpu/mpc85xx/p4080_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p4080_ids.c
@@ -4,6 +4,7 @@
  */
 
 #include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/p5040_ids.c b/arch/powerpc/cpu/mpc85xx/p5040_ids.c
index de1d372631bb..0a34e066e940 100644
--- a/arch/powerpc/cpu/mpc85xx/p5040_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/p5040_ids.c
@@ -4,6 +4,7 @@
  */
 
 #include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/speed.c b/arch/powerpc/cpu/mpc85xx/speed.c
index 1a4ee87cb348..a7e1b3c98a9d 100644
--- a/arch/powerpc/cpu/mpc85xx/speed.c
+++ b/arch/powerpc/cpu/mpc85xx/speed.c
@@ -9,7 +9,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <asm/u-boot.h>
 #include <cpu_func.h>
 #include <clock_legacy.h>
 #include <ppc_asm.tmpl>
diff --git a/arch/powerpc/cpu/mpc85xx/spl_minimal.c b/arch/powerpc/cpu/mpc85xx/spl_minimal.c
index e7031c1338b7..29318fad5f0b 100644
--- a/arch/powerpc/cpu/mpc85xx/spl_minimal.c
+++ b/arch/powerpc/cpu/mpc85xx/spl_minimal.c
@@ -3,7 +3,6 @@
  * Copyright 2009 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <asm/processor.h>
 #include <asm/global_data.h>
 #include <fsl_ifc.h>
diff --git a/arch/powerpc/cpu/mpc85xx/t1024_ids.c b/arch/powerpc/cpu/mpc85xx/t1024_ids.c
index 01a62b86926a..7239d28f9368 100644
--- a/arch/powerpc/cpu/mpc85xx/t1024_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t1024_ids.c
@@ -3,7 +3,8 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t1024_serdes.c b/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
index 3ab743c3d628..0d958fe131b5 100644
--- a/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t1024_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2014 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc85xx/t1040_ids.c b/arch/powerpc/cpu/mpc85xx/t1040_ids.c
index d0f9b0ca758a..bb92fc392cc2 100644
--- a/arch/powerpc/cpu/mpc85xx/t1040_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t1040_ids.c
@@ -3,7 +3,8 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t1040_serdes.c b/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
index 1f1b23a3aaaf..2033ebbaa5e6 100644
--- a/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t1040_serdes.c
@@ -3,10 +3,11 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <linux/kernel.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
+#include <asm/ppc.h>
 
 
 static u8 serdes_cfg_tbl[][SRDS_MAX_LANES] = {
diff --git a/arch/powerpc/cpu/mpc85xx/t2080_ids.c b/arch/powerpc/cpu/mpc85xx/t2080_ids.c
index 51ac367dd809..26a2d745a864 100644
--- a/arch/powerpc/cpu/mpc85xx/t2080_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t2080_ids.c
@@ -3,7 +3,8 @@
  * Copyright 2013 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t2080_serdes.c b/arch/powerpc/cpu/mpc85xx/t2080_serdes.c
index 16fa16b08081..6702acaf7723 100644
--- a/arch/powerpc/cpu/mpc85xx/t2080_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t2080_serdes.c
@@ -5,9 +5,10 @@
  * Shengzhou Liu <Shengzhou.Liu@freescale.com>
  */
 
-#include <asm/u-boot.h>
+#include <linux/kernel.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
+#include <asm/ppc.h>
 #include "fsl_corenet2_serdes.h"
 
 struct serdes_config {
diff --git a/arch/powerpc/cpu/mpc85xx/t4240_ids.c b/arch/powerpc/cpu/mpc85xx/t4240_ids.c
index 94b4409cecad..c319bf5cff57 100644
--- a/arch/powerpc/cpu/mpc85xx/t4240_ids.c
+++ b/arch/powerpc/cpu/mpc85xx/t4240_ids.c
@@ -3,7 +3,8 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <config.h>
+#include <linux/kernel.h>
 #include <asm/fsl_portals.h>
 #include <asm/fsl_liodn.h>
 
diff --git a/arch/powerpc/cpu/mpc85xx/t4240_serdes.c b/arch/powerpc/cpu/mpc85xx/t4240_serdes.c
index 956b5ea37aa5..36fe34f11ecc 100644
--- a/arch/powerpc/cpu/mpc85xx/t4240_serdes.c
+++ b/arch/powerpc/cpu/mpc85xx/t4240_serdes.c
@@ -3,7 +3,6 @@
  * Copyright 2012 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <asm/fsl_serdes.h>
 #include <asm/processor.h>
 #include <asm/io.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c b/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
index c7bae5a88151..843dd191ccf7 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_lbc.c
@@ -3,7 +3,6 @@
  * Copyright 2010-2011 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <hang.h>
 #include <init.h>
 #include <asm/fsl_lbc.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
index 523367ddf1c1..29399bcd8b68 100644
--- a/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
+++ b/arch/powerpc/cpu/mpc8xxx/fsl_pamu.c
@@ -5,12 +5,14 @@
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <config.h>
 #include <log.h>
 #include <linux/bitops.h>
 #include <linux/log2.h>
 #include <malloc.h>
 #include <asm/fsl_pamu.h>
+#include <asm/io.h>
+#include <asm/ppc.h>
 
 struct paace *ppaact;
 struct paace *sec;
diff --git a/arch/powerpc/cpu/mpc8xxx/law.c b/arch/powerpc/cpu/mpc8xxx/law.c
index 5c6e26b9aa15..f16bc1996639 100644
--- a/arch/powerpc/cpu/mpc8xxx/law.c
+++ b/arch/powerpc/cpu/mpc8xxx/law.c
@@ -6,7 +6,6 @@
  * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
  */
 
-#include <asm/u-boot.h>
 #include <display_options.h>
 #include <asm/bitops.h>
 #include <asm/global_data.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/pamu_table.c b/arch/powerpc/cpu/mpc8xxx/pamu_table.c
index e55173a890b7..831a11736cc8 100644
--- a/arch/powerpc/cpu/mpc8xxx/pamu_table.c
+++ b/arch/powerpc/cpu/mpc8xxx/pamu_table.c
@@ -3,7 +3,6 @@
  * Copyright 2012-2016 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
 #include <log.h>
 #include <asm/fsl_pamu.h>
 #include <asm/global_data.h>
diff --git a/arch/powerpc/cpu/mpc8xxx/srio.c b/arch/powerpc/cpu/mpc8xxx/srio.c
index 185cbabbcd85..0c7288c75740 100644
--- a/arch/powerpc/cpu/mpc8xxx/srio.c
+++ b/arch/powerpc/cpu/mpc8xxx/srio.c
@@ -3,12 +3,13 @@
  * Copyright 2011 Freescale Semiconductor, Inc.
  */
 
-#include <asm/u-boot.h>
+#include <config.h>
 #include <log.h>
 #include <time.h>
 #include <asm/fsl_law.h>
 #include <asm/fsl_serdes.h>
 #include <asm/fsl_srio.h>
+#include <asm/ppc.h>
 #include <linux/delay.h>
 #include <linux/errno.h>
 
diff --git a/arch/powerpc/include/asm/fsl_liodn.h b/arch/powerpc/include/asm/fsl_liodn.h
index 0af3d8902ace..4ce869b5c189 100644
--- a/arch/powerpc/include/asm/fsl_liodn.h
+++ b/arch/powerpc/include/asm/fsl_liodn.h
@@ -6,7 +6,9 @@
 #ifndef _FSL_LIODN_H_
 #define _FSL_LIODN_H_
 
-#include <asm/types.h>
+#include <config.h>
+#include <linux/types.h>
+#include <asm/ppc.h>
 #include <fsl_qbman.h>
 
 struct srio_liodn_id_table {
diff --git a/arch/powerpc/include/asm/fsl_portals.h b/arch/powerpc/include/asm/fsl_portals.h
index 54ef4fb62954..021eec72382d 100644
--- a/arch/powerpc/include/asm/fsl_portals.h
+++ b/arch/powerpc/include/asm/fsl_portals.h
@@ -6,6 +6,8 @@
 #ifndef _FSL_PORTALS_H_
 #define _FSL_PORTALS_H_
 
+#include <linux/types.h>
+
 /* entries must be in order and contiguous */
 enum fsl_dpaa_dev {
 	FSL_HW_PORTAL_SEC,
diff --git a/arch/powerpc/include/asm/global_data.h b/arch/powerpc/include/asm/global_data.h
index f7860122a00b..a9efbbdd3d49 100644
--- a/arch/powerpc/include/asm/global_data.h
+++ b/arch/powerpc/include/asm/global_data.h
@@ -93,4 +93,6 @@ struct arch_global_data {
 
 #define DECLARE_GLOBAL_DATA_PTR     register volatile gd_t *gd asm ("r2")
 
+#include <asm/u-boot.h>
+
 #endif /* __ASM_GBL_DATA_H */
diff --git a/arch/powerpc/lib/bdinfo.c b/arch/powerpc/lib/bdinfo.c
index c12e4c6371fe..6491c210f4e2 100644
--- a/arch/powerpc/lib/bdinfo.c
+++ b/arch/powerpc/lib/bdinfo.c
@@ -8,7 +8,6 @@
 
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/riscv/lib/boot.c b/arch/riscv/lib/boot.c
index 03014c56dce2..161335abee18 100644
--- a/arch/riscv/lib/boot.c
+++ b/arch/riscv/lib/boot.c
@@ -4,7 +4,8 @@
  * Rick Chen, Andes Technology Corporation <rick@andestech.com>
  */
 
-#include <asm/u-boot.h>
+#include <linux/types.h>
+#include <asm/u-boot-riscv.h>
 
 unsigned long do_go_exec(ulong (*entry)(int, char * const []),
 			 int argc, char *const argv[])
diff --git a/arch/sandbox/include/asm/global_data.h b/arch/sandbox/include/asm/global_data.h
index 001b2b53c1c8..309422f75e3f 100644
--- a/arch/sandbox/include/asm/global_data.h
+++ b/arch/sandbox/include/asm/global_data.h
@@ -10,6 +10,7 @@
 #define __ASM_GBL_DATA_H
 
 #include <linux/types.h>
+#include <asm/u-boot.h>
 
 /* Architecture-specific global data */
 struct arch_global_data {
diff --git a/arch/sh/include/asm/global_data.h b/arch/sh/include/asm/global_data.h
index bd946ffd8fd7..933c302d68ce 100644
--- a/arch/sh/include/asm/global_data.h
+++ b/arch/sh/include/asm/global_data.h
@@ -10,6 +10,8 @@
 #ifndef	__ASM_SH_GLOBALDATA_H_
 #define __ASM_SH_GLOBALDATA_H_
 
+#include <asm/u-boot.h>
+
 /* Architecture-specific global data */
 struct arch_global_data {
 };
diff --git a/arch/x86/cpu/coreboot/sdram.c b/arch/x86/cpu/coreboot/sdram.c
index ee0491eab1c8..013225f129a9 100644
--- a/arch/x86/cpu/coreboot/sdram.c
+++ b/arch/x86/cpu/coreboot/sdram.c
@@ -9,7 +9,6 @@
 #include <asm/e820.h>
 #include <asm/cb_sysinfo.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/efi/payload.c b/arch/x86/cpu/efi/payload.c
index cb57f15f710b..642a87a37d8b 100644
--- a/arch/x86/cpu/efi/payload.c
+++ b/arch/x86/cpu/efi/payload.c
@@ -16,7 +16,6 @@
 #include <asm/e820.h>
 #include <asm/global_data.h>
 #include <asm/post.h>
-#include <asm/u-boot.h>
 #include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/cpu/efi/sdram.c b/arch/x86/cpu/efi/sdram.c
index 1f0e87735b21..6fe400711402 100644
--- a/arch/x86/cpu/efi/sdram.c
+++ b/arch/x86/cpu/efi/sdram.c
@@ -6,7 +6,6 @@
 #include <efi.h>
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 #include <asm/u-boot-x86.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/cpu/ivybridge/sdram_nop.c b/arch/x86/cpu/ivybridge/sdram_nop.c
index e7ec35bbe2a6..d20c9a2a379f 100644
--- a/arch/x86/cpu/ivybridge/sdram_nop.c
+++ b/arch/x86/cpu/ivybridge/sdram_nop.c
@@ -5,7 +5,6 @@
 
 #include <init.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/qemu/dram.c b/arch/x86/cpu/qemu/dram.c
index 6ac363f3d8c7..62a301c0fd3e 100644
--- a/arch/x86/cpu/qemu/dram.c
+++ b/arch/x86/cpu/qemu/dram.c
@@ -7,7 +7,6 @@
 #include <asm/global_data.h>
 #include <asm/post.h>
 #include <asm/arch/qemu.h>
-#include <asm/u-boot.h>
 #include <linux/sizes.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/cpu/quark/dram.c b/arch/x86/cpu/quark/dram.c
index 7d32b98e8daf..34e576940d4f 100644
--- a/arch/x86/cpu/quark/dram.c
+++ b/arch/x86/cpu/quark/dram.c
@@ -17,7 +17,6 @@
 #include <asm/arch/mrc.h>
 #include <asm/arch/msg_port.h>
 #include <asm/arch/quark.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/arch/x86/cpu/tangier/sdram.c b/arch/x86/cpu/tangier/sdram.c
index 7e1d290fc595..6192f2296b80 100644
--- a/arch/x86/cpu/tangier/sdram.c
+++ b/arch/x86/cpu/tangier/sdram.c
@@ -8,7 +8,6 @@
 #include <asm/e820.h>
 #include <asm/global_data.h>
 #include <asm/sfi.h>
-#include <asm/u-boot.h>
 #include <linux/printk.h>
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/arch/x86/include/asm/global_data.h b/arch/x86/include/asm/global_data.h
index 1ef7f1f0349e..06bd80ccc135 100644
--- a/arch/x86/include/asm/global_data.h
+++ b/arch/x86/include/asm/global_data.h
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <asm/processor.h>
 #include <asm/mrccache.h>
+#include <asm/u-boot.h>
 
 enum pei_boot_mode_t {
 	PEI_BOOT_NONE = 0,
diff --git a/arch/xtensa/include/asm/global_data.h b/arch/xtensa/include/asm/global_data.h
index 1157978ab688..40c129db4ace 100644
--- a/arch/xtensa/include/asm/global_data.h
+++ b/arch/xtensa/include/asm/global_data.h
@@ -6,6 +6,8 @@
 #ifndef	_XTENSA_GBL_DATA_H
 #define _XTENSA_GBL_DATA_H
 
+#include <asm/u-boot.h>
+
 /* Architecture-specific global data */
 
 struct arch_global_data {
diff --git a/board/keymile/kmcent2/tlb.c b/board/keymile/kmcent2/tlb.c
index 41b24e39433d..77e11e9bc1ed 100644
--- a/board/keymile/kmcent2/tlb.c
+++ b/board/keymile/kmcent2/tlb.c
@@ -7,7 +7,7 @@
  */
 
 #include <asm/mmu.h>
-#include <asm/u-boot.h>
+#include <asm/ppc.h>
 
 struct fsl_e_tlb_entry tlb_table[] = {
 	/* TLB 0 - for temp stack in cache */
diff --git a/board/phytium/pe2201/pe2201.c b/board/phytium/pe2201/pe2201.c
index 0e837b0f50f4..fbbf6789b505 100644
--- a/board/phytium/pe2201/pe2201.c
+++ b/board/phytium/pe2201/pe2201.c
@@ -12,7 +12,6 @@
 #include <asm/io.h>
 #include <linux/arm-smccc.h>
 #include <scsi.h>
-#include <asm/u-boot.h>
 #include "cpu.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/phytium/pomelo/pomelo.c b/board/phytium/pomelo/pomelo.c
index 960e491c7687..0ea335e7486b 100644
--- a/board/phytium/pomelo/pomelo.c
+++ b/board/phytium/pomelo/pomelo.c
@@ -14,7 +14,6 @@
 #include <linux/arm-smccc.h>
 #include <scsi.h>
 #include <init.h>
-#include <asm/u-boot.h>
 #include "cpu.h"
 
 DECLARE_GLOBAL_DATA_PTR;
diff --git a/board/renesas/falcon/falcon.c b/board/renesas/falcon/falcon.c
index 27fccacf6f80..c88257d96772 100644
--- a/board/renesas/falcon/falcon.c
+++ b/board/renesas/falcon/falcon.c
@@ -14,7 +14,6 @@
 #include <asm/processor.h>
 #include <linux/errno.h>
 #include <asm/system.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/renesas/grpeach/grpeach.c b/board/renesas/grpeach/grpeach.c
index c475c3f50ab3..88f65c3b6a07 100644
--- a/board/renesas/grpeach/grpeach.c
+++ b/board/renesas/grpeach/grpeach.c
@@ -10,7 +10,6 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/arch/sys_proto.h>
-#include <asm/u-boot.h>
 
 #define RZA1_WDT_BASE	0xfcfe0000
 #define WTCSR		0x00
diff --git a/common/init/handoff.c b/common/init/handoff.c
index 687513bda353..a7cd065fb385 100644
--- a/common/init/handoff.c
+++ b/common/init/handoff.c
@@ -7,7 +7,6 @@
 
 #include <handoff.h>
 #include <asm/global_data.h>
-#include <asm/u-boot.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 4e92771ecaae..9a879e9fb102 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -23,7 +23,6 @@
 #include <system-constants.h>
 #include <asm/global_data.h>
 #include <asm-generic/gpio.h>
-#include <asm/u-boot.h>
 #include <nand.h>
 #include <fat.h>
 #include <u-boot/crc.h>
diff --git a/common/spl/spl_ext.c b/common/spl/spl_ext.c
index 2399e1d806d4..76f49a5a8a6a 100644
--- a/common/spl/spl_ext.c
+++ b/common/spl/spl_ext.c
@@ -4,7 +4,6 @@
 #include <part.h>
 #include <spl.h>
 #include <spl_load.h>
-#include <asm/u-boot.h>
 #include <ext4fs.h>
 #include <errno.h>
 #include <image.h>
diff --git a/common/spl/spl_fat.c b/common/spl/spl_fat.c
index 2e320ba7c018..bd8aab253a98 100644
--- a/common/spl/spl_fat.c
+++ b/common/spl/spl_fat.c
@@ -12,7 +12,6 @@
 #include <log.h>
 #include <spl.h>
 #include <spl_load.h>
-#include <asm/u-boot.h>
 #include <fat.h>
 #include <errno.h>
 #include <image.h>
diff --git a/common/spl/spl_mmc.c b/common/spl/spl_mmc.c
index f4481b90463a..ccab0be4be23 100644
--- a/common/spl/spl_mmc.c
+++ b/common/spl/spl_mmc.c
@@ -12,7 +12,6 @@
 #include <spl_load.h>
 #include <linux/compiler.h>
 #include <errno.h>
-#include <asm/u-boot.h>
 #include <errno.h>
 #include <mmc.h>
 #include <image.h>
diff --git a/common/spl/spl_sata.c b/common/spl/spl_sata.c
index 18acc40e46fc..67fc620d9bea 100644
--- a/common/spl/spl_sata.c
+++ b/common/spl/spl_sata.c
@@ -9,7 +9,6 @@
  */
 
 #include <spl.h>
-#include <asm/u-boot.h>
 #include <sata.h>
 #include <scsi.h>
 #include <errno.h>
diff --git a/common/spl/spl_usb.c b/common/spl/spl_usb.c
index 31fc4b57d486..932da56ab6db 100644
--- a/common/spl/spl_usb.c
+++ b/common/spl/spl_usb.c
@@ -10,7 +10,6 @@
 
 #include <log.h>
 #include <spl.h>
-#include <asm/u-boot.h>
 #include <errno.h>
 #include <usb.h>
 #include <fat.h>
diff --git a/common/spl/spl_ymodem.c b/common/spl/spl_ymodem.c
index fd48f80f75e3..4c7222af612d 100644
--- a/common/spl/spl_ymodem.c
+++ b/common/spl/spl_ymodem.c
@@ -13,7 +13,6 @@
 #include <log.h>
 #include <spl.h>
 #include <xyzModem.h>
-#include <asm/u-boot.h>
 #include <linux/libfdt.h>
 
 #define BUF_SIZE 1024
diff --git a/drivers/clk/altera/clk-agilex5.c b/drivers/clk/altera/clk-agilex5.c
index 92f2abdaf935..72b923465df5 100644
--- a/drivers/clk/altera/clk-agilex5.c
+++ b/drivers/clk/altera/clk-agilex5.c
@@ -15,7 +15,6 @@
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <asm/system.h>
-#include <asm/u-boot.h>
 #include <dm/lists.h>
 #include <dm/util.h>
 #include <linux/bitops.h>
diff --git a/include/dm/of.h b/include/dm/of.h
index b1c934f610d3..b7404c139d19 100644
--- a/include/dm/of.h
+++ b/include/dm/of.h
@@ -7,7 +7,6 @@
 #ifndef _DM_OF_H
 #define _DM_OF_H
 
-#include <asm/u-boot.h>
 #include <asm/global_data.h>
 
 /* integer value within a device tree property which references another node */
diff --git a/include/fsl_errata.h b/include/fsl_errata.h
index 44547645df87..9f070726acb2 100644
--- a/include/fsl_errata.h
+++ b/include/fsl_errata.h
@@ -7,7 +7,7 @@
 #define _FSL_ERRATA_H
 
 #if defined(CONFIG_PPC)
-#include <asm/processor.h>
+#include <asm/ppc.h>
 #elif defined(CONFIG_ARCH_LS1021A)
 #include <asm/arch-ls102xa/immap_ls102xa.h>
 #elif defined(CONFIG_FSL_LAYERSCAPE)
-- 
2.34.1

