Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A51C2C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 22:53:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8C8F987504;
	Fri, 17 Nov 2023 23:53:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kTjwVJz7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14C68874FD; Fri, 17 Nov 2023 23:53:28 +0100 (CET)
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com
 [IPv6:2607:f8b0:4864:20::b2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C841874CC
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 23:53:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-d9ace5370a0so2507007276.0
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 14:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700261596; x=1700866396; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=V3nGL06rG7XLeXM2mgUB6BcfI2eppDB0HdUybgTPYZA=;
 b=kTjwVJz7TcGQAuwyFvgs4/OLdkPdFdrPRUJUW6iJG65M/6DSd32zds4xHhk35hkaM5
 dm3aOjEF2b6fUQIfwpQB1dUYcNA7sAHjXJZVC2Hz6F0VCC/B92Ew0d3xN07+ueorinvp
 8zHrj4RJwWKNZsNFQh75MksmpHIhJVlsn/fF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700261596; x=1700866396;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=V3nGL06rG7XLeXM2mgUB6BcfI2eppDB0HdUybgTPYZA=;
 b=wwiMeyeLr+Dn5Y+G06WMiLPfDM43EcsyXpj8nL/zSuuR9/xNIbXe1iLEmEJY7ypBjY
 x4BT2l51HjmkIa+pfSmUL6nsUJzlCEdyPVYsVgXWnvxMTspo4x58oP3iMPS5IQxq4A76
 3tbzQLfQhnbPUPdZWpfnZLdNH1H6s2ZTe1UICPGFALiiKKEz6V1w9xAABTUXnEQRfwqc
 ebMG2iFPzRhINYkABB1+10a2vD+blEugxsQva0BZQJrfezL9CIGABTnNrrRoM3yDtzuI
 dyLv4KDZozIQOq5gPgU5MHhXzv3SDnZTazKuVmtgY7ItFVfyRcnabYlFO+MCX896zvHa
 TKgQ==
X-Gm-Message-State: AOJu0Yw4CNsUnXZdzoji/iwWMamCqf7F+61XewzIfvi0YVE0dJOGuu5k
 q5160rbKYsh5aK58aAwxfHXmIm0lgQ+hqbBcqVSncQ==
X-Google-Smtp-Source: AGHT+IEUoJaydYonBZqqV+ZGK2W/ClNqJLsilSJbBmhXTOVXDN6g6ZLMs3c2MEg8vAie5uvcWv7CfQ==
X-Received: by 2002:a25:d308:0:b0:d9a:6c74:49b with SMTP id
 e8-20020a25d308000000b00d9a6c74049bmr998695ybf.2.1700261596129; 
 Fri, 17 Nov 2023 14:53:16 -0800 (PST)
Received: from bill-the-cat.lan
 (2603-6081-7b00-6400-dbd8-aafa-ccfe-bf84.res6.spectrum.com.
 [2603:6081:7b00:6400:dbd8:aafa:ccfe:bf84])
 by smtp.gmail.com with ESMTPSA id
 r12-20020a05621410cc00b0065b08bb01afsm961084qvs.124.2023.11.17.14.53.15
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 14:53:15 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH 3/5] arm: Partial cleanup and audit usage of <config.h>
Date: Fri, 17 Nov 2023 17:53:11 -0500
Message-Id: <20231117225313.2144665-3-trini@konsulko.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231117225313.2144665-1-trini@konsulko.com>
References: <20231117225313.2144665-1-trini@konsulko.com>
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

We need to include <config.h> directly when a file needs to have
something such as CFG_SYS_SDRAM_SIZE referenced as this file is not
automatically globally included and is most commonly indirectly included
via common.h.  Remove most cases of arm including config.h directly, but
add it where needed. This includes a few board-specific fixes.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h | 2 --
 arch/arm/include/asm/arch-ls102xa/fsl_serdes.h        | 2 --
 arch/arm/include/asm/assembler.h                      | 1 -
 arch/arm/include/asm/secure.h                         | 1 -
 arch/arm/include/asm/string.h                         | 2 --
 arch/arm/mach-davinci/include/mach/pinmux_defs.h      | 1 -
 arch/arm/mach-exynos/exynos4_setup.h                  | 1 -
 arch/arm/mach-exynos/exynos5_setup.h                  | 1 -
 arch/arm/mach-k3/common.c                             | 1 +
 arch/arm/mach-k3/include/mach/clock.h                 | 2 --
 arch/arm/mach-k3/include/mach/j721e_hardware.h        | 1 -
 arch/arm/mach-k3/include/mach/j721s2_hardware.h       | 1 -
 arch/arm/mach-k3/r5_mpu.c                             | 1 +
 board/freescale/ls1088a/eth_ls1088aqds.c              | 1 +
 board/freescale/ls2080aqds/eth.c                      | 1 +
 board/toradex/verdin-am62/verdin-am62.c               | 1 +
 drivers/ddr/marvell/axp/ddr3_axp.h                    | 2 ++
 17 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h b/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
index 8f4365175697..9e29350ca4ba 100644
--- a/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
+++ b/arch/arm/include/asm/arch-fsl-layerscape/fsl_serdes.h
@@ -7,8 +7,6 @@
 #ifndef __FSL_SERDES_H__
 #define __FSL_SERDES_H__
 
-#include <config.h>
-
 #ifdef CONFIG_FSL_LSCH3
 enum srds_prtcl {
 	/*
diff --git a/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h b/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
index d99a6f318f8b..9244e0a78fd3 100644
--- a/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
+++ b/arch/arm/include/asm/arch-ls102xa/fsl_serdes.h
@@ -6,8 +6,6 @@
 #ifndef __FSL_SERDES_H
 #define __FSL_SERDES_H
 
-#include <config.h>
-
 enum srds_prtcl {
 	/*
 	 * Nobody will check whether the device 'NONE' has been configured,
diff --git a/arch/arm/include/asm/assembler.h b/arch/arm/include/asm/assembler.h
index 8d42ef4823e9..4fda483b8d8d 100644
--- a/arch/arm/include/asm/assembler.h
+++ b/arch/arm/include/asm/assembler.h
@@ -14,7 +14,6 @@
  *  assembler source.
  */
 
-#include <config.h>
 #include <asm/unified.h>
 
 /*
diff --git a/arch/arm/include/asm/secure.h b/arch/arm/include/asm/secure.h
index c7b00be8e0b9..abfa46470b2c 100644
--- a/arch/arm/include/asm/secure.h
+++ b/arch/arm/include/asm/secure.h
@@ -1,7 +1,6 @@
 #ifndef __ASM_SECURE_H
 #define __ASM_SECURE_H
 
-#include <config.h>
 #include <asm/global_data.h>
 
 #define __secure __section("._secure.text")
diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index ead3f2c35643..c9ecdde0d3d8 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -1,8 +1,6 @@
 #ifndef __ASM_ARM_STRING_H
 #define __ASM_ARM_STRING_H
 
-#include <config.h>
-
 /*
  * We don't do inline string functions, since the
  * optimised inline asm versions are not small.
diff --git a/arch/arm/mach-davinci/include/mach/pinmux_defs.h b/arch/arm/mach-davinci/include/mach/pinmux_defs.h
index 4901ba49c9bb..120935310807 100644
--- a/arch/arm/mach-davinci/include/mach/pinmux_defs.h
+++ b/arch/arm/mach-davinci/include/mach/pinmux_defs.h
@@ -9,7 +9,6 @@
 #define __ASM_ARCH_PINMUX_DEFS_H
 
 #include <asm/arch/davinci_misc.h>
-#include <config.h>
 
 /* SPI0 pin muxer settings */
 extern const struct pinmux_config spi0_pins_base[3];
diff --git a/arch/arm/mach-exynos/exynos4_setup.h b/arch/arm/mach-exynos/exynos4_setup.h
index fbb45eb897e3..23c9011fbc63 100644
--- a/arch/arm/mach-exynos/exynos4_setup.h
+++ b/arch/arm/mach-exynos/exynos4_setup.h
@@ -8,7 +8,6 @@
 #ifndef _ORIGEN_SETUP_H
 #define _ORIGEN_SETUP_H
 
-#include <config.h>
 #include <asm/arch/cpu.h>
 
 /* Bus Configuration Register Address */
diff --git a/arch/arm/mach-exynos/exynos5_setup.h b/arch/arm/mach-exynos/exynos5_setup.h
index af7a5afb03cd..e9874a8c1b24 100644
--- a/arch/arm/mach-exynos/exynos5_setup.h
+++ b/arch/arm/mach-exynos/exynos5_setup.h
@@ -8,7 +8,6 @@
 #ifndef _SMDK5250_SETUP_H
 #define _SMDK5250_SETUP_H
 
-#include <config.h>
 #include <asm/arch/dmc.h>
 
 #define NOT_AVAILABLE		0
diff --git a/arch/arm/mach-k3/common.c b/arch/arm/mach-k3/common.c
index eff2fff3c706..2bbdd1077652 100644
--- a/arch/arm/mach-k3/common.c
+++ b/arch/arm/mach-k3/common.c
@@ -6,6 +6,7 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
+#include <config.h>
 #include <cpu_func.h>
 #include <image.h>
 #include <init.h>
diff --git a/arch/arm/mach-k3/include/mach/clock.h b/arch/arm/mach-k3/include/mach/clock.h
index e3adbcd9dedc..850067d5afac 100644
--- a/arch/arm/mach-k3/include/mach/clock.h
+++ b/arch/arm/mach-k3/include/mach/clock.h
@@ -7,8 +7,6 @@
 #ifndef __ASM_ARCH_CLOCK_H
 #define __ASM_ARCH_CLOCK_H
 
-#include <config.h>
-
 /* Clock Defines */
 #define V_OSCK				24000000
 #define V_SCLK				V_OSCK
diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 376db389ba19..d71d3b7a63f7 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -7,7 +7,6 @@
 #ifndef __ASM_ARCH_J721E_HARDWARE_H
 #define __ASM_ARCH_J721E_HARDWARE_H
 
-#include <config.h>
 #ifndef __ASSEMBLY__
 #include <linux/bitops.h>
 #endif
diff --git a/arch/arm/mach-k3/include/mach/j721s2_hardware.h b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
index 7948bcf4789b..c994961c1d19 100644
--- a/arch/arm/mach-k3/include/mach/j721s2_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721s2_hardware.h
@@ -7,7 +7,6 @@
 #ifndef __ASM_ARCH_J721S2_HARDWARE_H
 #define __ASM_ARCH_J721S2_HARDWARE_H
 
-#include <config.h>
 #ifndef __ASSEMBLY__
 #include <linux/bitops.h>
 #endif
diff --git a/arch/arm/mach-k3/r5_mpu.c b/arch/arm/mach-k3/r5_mpu.c
index 6786e7e1e5af..ac28ff0f6b4b 100644
--- a/arch/arm/mach-k3/r5_mpu.c
+++ b/arch/arm/mach-k3/r5_mpu.c
@@ -6,6 +6,7 @@
  *	Lokesh Vutla <lokeshvutla@ti.com>
  */
 
+#include <config.h>
 #include <asm/io.h>
 #include <linux/kernel.h>
 #include "common.h"
diff --git a/board/freescale/ls1088a/eth_ls1088aqds.c b/board/freescale/ls1088a/eth_ls1088aqds.c
index 2fece3a1b09b..e6033d251c56 100644
--- a/board/freescale/ls1088a/eth_ls1088aqds.c
+++ b/board/freescale/ls1088a/eth_ls1088aqds.c
@@ -3,6 +3,7 @@
  * Copyright 2017 NXP
  */
 
+#include <config.h>
 #include <vsprintf.h>
 #include <linux/string.h>
 #include <asm/io.h>
diff --git a/board/freescale/ls2080aqds/eth.c b/board/freescale/ls2080aqds/eth.c
index 048ab44c5919..b47e2ec5a793 100644
--- a/board/freescale/ls2080aqds/eth.c
+++ b/board/freescale/ls2080aqds/eth.c
@@ -3,6 +3,7 @@
  * Copyright 2015 Freescale Semiconductor, Inc.
  */
 
+#include <config.h>
 #include <vsprintf.h>
 #include <linux/string.h>
 #include <asm/io.h>
diff --git a/board/toradex/verdin-am62/verdin-am62.c b/board/toradex/verdin-am62/verdin-am62.c
index d09dda5bccc9..2718263eb19b 100644
--- a/board/toradex/verdin-am62/verdin-am62.c
+++ b/board/toradex/verdin-am62/verdin-am62.c
@@ -6,6 +6,7 @@
  *
  */
 
+#include <config.h>
 #include <asm/arch/hardware.h>
 #include <asm/io.h>
 #include <dm/uclass.h>
diff --git a/drivers/ddr/marvell/axp/ddr3_axp.h b/drivers/ddr/marvell/axp/ddr3_axp.h
index c40cd768abf5..c3d282477f5c 100644
--- a/drivers/ddr/marvell/axp/ddr3_axp.h
+++ b/drivers/ddr/marvell/axp/ddr3_axp.h
@@ -6,6 +6,8 @@
 #ifndef __DDR3_AXP_H
 #define __DDR3_AXP_H
 
+#include <config.h>
+
 #define MV_78XX0_Z1_REV			0x0
 #define MV_78XX0_A0_REV			0x1
 #define MV_78XX0_B0_REV			0x2
-- 
2.34.1

