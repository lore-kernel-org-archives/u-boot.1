Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F7ECEED615
	for <u-boot@archiver.kernel.org>; Thu, 12 Sep 2024 15:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73F5589031;
	Thu, 12 Sep 2024 17:51:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="U/MSiSjw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06DCA88FFA; Thu, 12 Sep 2024 17:51:24 +0200 (CEST)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DC07A8902A
 for <u-boot@lists.denx.de>; Thu, 12 Sep 2024 17:51:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=devnull+Oliver.Gaskell.analog.com@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D729EA456FF;
 Thu, 12 Sep 2024 15:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4842FC4CEC3;
 Thu, 12 Sep 2024 15:51:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726156275;
 bh=zGBG8XJR3nn9eYFUvCyWAPyPXnW/HOAIy4mO4qq83zA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=U/MSiSjwsHwRN4onNLi97DoyYYuU+KGf514U4RZ5CzbhIpCrgs+zgl7RG4tJmfQvW
 lnZomPaS/f72YUqXR65RiBN5I2/8nMvUU8uZFR5Ksm1p+Su02jwSU+abAmbv+ATbEd
 5jTkZhuGm8cNbIWa+XkJ6bpVp/1uW/rEK9uEXPuQlnOPlNhMMgE+l3BQi4Ji32U21J
 UMjHOzkXtWCno3NpFN141xM3ShakNs0k0VP0ACor8by/A8isvve4dS3m+kwmh+K2+l
 VJiQdENEqCkv23Mph4I2AmNqVrQ98huiq0j7PjRClfhKxpcsfCfrtz6liD7JIIw4rY
 Rkwrfn/Msf0Ug==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 410ABEED61D;
 Thu, 12 Sep 2024 15:51:15 +0000 (UTC)
From: Oliver Gaskell via B4 Relay
 <devnull+Oliver.Gaskell.analog.com@kernel.org>
Date: Thu, 12 Sep 2024 16:50:58 +0100
Subject: [PATCH v2 17/20] arm: SC584-EZKIT initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240912-sc5xx-upstreaming-patches-v2-17-1185a80df79e@analog.com>
References: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
In-Reply-To: <20240912-sc5xx-upstreaming-patches-v2-0-1185a80df79e@analog.com>
To: Tom Rini <trini@konsulko.com>, 
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>, 
 Greg Malysa <greg.malysa@timesys.com>, 
 Ian Roberts <ian.roberts@timesys.com>, 
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>, 
 Utsav Agarwal <utsav.agarwal@analog.com>, 
 Arturs Artamonovs <arturs.artamonovs@analog.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Cc: u-boot@lists.denx.de, adsp-linux@analog.com, 
 Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Trevor Woerner <twoerner@gmail.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726156261; l=7547;
 i=Oliver.Gaskell@analog.com; s=20240821; h=from:subject:message-id;
 bh=FFJKFXB50rfjhE/QQXRCI7br0EWGQKNXClra1BxgjvU=;
 b=4HRW4PVdcxcBLhtbTJDgwWf/+Tz6mMbEKZCAOxOWqDasRsUSszkYRTJ9WrKUw0Dt9ypY3OHXw
 XozVBeBAFDxBK4y6UilcRu18ORQJb43T1b7bm04s9cI7E60sNYoy+nt
X-Developer-Key: i=Oliver.Gaskell@analog.com; a=ed25519;
 pk=Icq9TxwFJ6FePHS28YbBWMvtZpFWxpPQLhLA9cNvZ/Y=
X-Endpoint-Received: by B4 Relay for Oliver.Gaskell@analog.com/20240821
 with auth_id=197
X-Original-From: Oliver Gaskell <Oliver.Gaskell@analog.com>
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
Reply-To: Oliver.Gaskell@analog.com
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

From: Oliver Gaskell <Oliver.Gaskell@analog.com>

Adds support for Analog Devices' SC584-EZKIT board. Includes:
- SoC specific configs in mach-sc5xx/Kconfig
- Memory Map for SPL
- SPL config options in common/spl/Kconfig
- Necessary board-specific init functions
- Board-specific Kconfig and environment in board/adi/
- Memory configuration

Co-developed-by: Greg Malysa <greg.malysa@timesys.com>
Signed-off-by: Greg Malysa <greg.malysa@timesys.com>
Co-developed-by: Trevor Woerner <twoerner@gmail.com>
Signed-off-by: Trevor Woerner <twoerner@gmail.com>
Co-developed-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Nathan Barrett-Morrison <nathan.morrison@timesys.com>
Signed-off-by: Oliver Gaskell <Oliver.Gaskell@analog.com>
---
 Kconfig                               |   1 +
 arch/arm/mach-sc5xx/Kconfig           |  15 +++++
 arch/arm/mach-sc5xx/Makefile          |   1 +
 arch/arm/mach-sc5xx/sc58x-spl.c       |  26 ++++++++
 board/adi/sc584-ezkit/Kconfig         | 116 ++++++++++++++++++++++++++++++++++
 board/adi/sc584-ezkit/sc584-ezkit.env |  13 ++++
 common/spl/Kconfig                    |   3 +
 include/configs/sc584-ezkit.h         |  18 ++++++
 8 files changed, 193 insertions(+)

diff --git a/Kconfig b/Kconfig
index f797105751..2422b94e6d 100644
--- a/Kconfig
+++ b/Kconfig
@@ -647,6 +647,7 @@ config TEXT_BASE
 	default 0x42e00000 if SUNXI_MINIMUM_DRAM_MB >= 64
 	default 0x96000000 if ARCH_SC5XX && SC59X_64
 	default 0xB2200000 if ARCH_SC5XX && SC59X
+	default 0x89200000 if ARCH_SC5XX && TARGET_SC584_EZKIT
 	hex "Text Base"
 	help
 	  The address in memory that U-Boot will be copied and executed from
diff --git a/arch/arm/mach-sc5xx/Kconfig b/arch/arm/mach-sc5xx/Kconfig
index b57c21cf16..ac2b669940 100644
--- a/arch/arm/mach-sc5xx/Kconfig
+++ b/arch/arm/mach-sc5xx/Kconfig
@@ -49,6 +49,20 @@ config SC59X_64
 
 endchoice
 
+if SC58X
+
+choice
+	prompt "SC58x board select"
+
+config TARGET_SC584_EZKIT
+	bool
+	prompt "SC584-EZKIT"
+	select ADI_USE_DDR2
+
+endchoice
+
+endif
+
 if SC59X
 
 choice
@@ -530,5 +544,6 @@ source "board/adi/sc598-som-ezkit/Kconfig"
 source "board/adi/sc598-som-ezlite/Kconfig"
 source "board/adi/sc594-som-ezkit/Kconfig"
 source "board/adi/sc594-som-ezlite/Kconfig"
+source "board/adi/sc584-ezkit/Kconfig"
 
 endif
diff --git a/arch/arm/mach-sc5xx/Makefile b/arch/arm/mach-sc5xx/Makefile
index a8079b6120..9a00a430b4 100644
--- a/arch/arm/mach-sc5xx/Makefile
+++ b/arch/arm/mach-sc5xx/Makefile
@@ -12,6 +12,7 @@ obj-y += soc.o init/
 
 obj-$(CONFIG_SC57X) += sc57x.o
 obj-$(CONFIG_SC58X) += sc58x.o
+obj-$(CONFIG_SC58X) += sc58x-spl.o
 obj-$(CONFIG_SC59X) += sc59x.o
 obj-$(CONFIG_SC59X) += sc59x-spl.o
 obj-$(CONFIG_SC59X_64) += sc59x_64.o
diff --git a/arch/arm/mach-sc5xx/sc58x-spl.c b/arch/arm/mach-sc5xx/sc58x-spl.c
new file mode 100644
index 0000000000..ae809f09e5
--- /dev/null
+++ b/arch/arm/mach-sc5xx/sc58x-spl.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+#include <asm/arch-adi/sc5xx/spl.h>
+
+// Table 53-13 in SC58x HRM
+const struct adi_boot_args adi_rom_boot_args[] = {
+	// JTAG/no boot
+	[0] = {0, 0, 0},
+	// SPI master, used for qspi as well
+	[1] = {0x60020000, 0x00040000, 0x00010207},
+	// SPI slave
+	[2] = {0, 0, 0x00000212},
+	// reserved, no boot
+	[3] = {0, 0, 0},
+	// reserved, no boot
+	[4] = {0, 0, 0},
+	// reserved, also no boot
+	[5] = {0, 0, 0},
+	// Linkport slave
+	[6] = {0, 0, 0x00000014},
+	// UART slave
+	[7] = {0, 0, 0x00000013},
+};
diff --git a/board/adi/sc584-ezkit/Kconfig b/board/adi/sc584-ezkit/Kconfig
new file mode 100644
index 0000000000..14c47f1d69
--- /dev/null
+++ b/board/adi/sc584-ezkit/Kconfig
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+#
+# (C) Copyright 2024 - Analog Devices, Inc.
+
+if TARGET_SC584_EZKIT
+
+config LDR_CPU
+	default	"ADSP-SC584-0.1"
+
+config SYS_BOARD
+	default "sc584-ezkit"
+
+config SYS_CONFIG_NAME
+	default "sc584-ezkit"
+
+config DEFAULT_DEVICE_TREE
+	default "sc584-ezkit"
+
+config ADI_IMAGE
+	default "tiny"
+
+config CUSTOM_SYS_INIT_SP_ADDR
+	default 0x8903f000
+
+# SPI Flash
+
+config SF_DEFAULT_BUS
+	default 2
+
+config SF_DEFAULT_CS
+	default 1
+
+config SF_DEFAULT_SPEED
+	default 5000000
+
+# Clocks
+
+config CGU0_DF_DIV
+	default 0
+
+config CGU0_VCO_MULT
+	default 18
+
+config CGU0_CCLK_DIV
+	default 1
+
+config CGU0_SCLK_DIV
+	default 2
+
+config CGU0_SCLK0_DIV
+	default 2
+
+config CGU0_SCLK1_DIV
+	default 2
+
+config CGU0_DCLK_DIV
+	default 2
+
+config CGU0_OCLK_DIV
+	default 3
+
+config CGU1_VCO_MULT
+	default 5
+
+config CGU1_DF_DIV
+	default 0
+
+config CGU1_CCLK_DIV
+	default 1
+
+config CGU1_SCLK_DIV
+	default 2
+
+config CGU1_SCLK0_DIV
+	default 2
+
+config CGU1_SCLK1_DIV
+	default 2
+
+config CGU1_DCLK_DIV
+	default 2
+
+config CGU1_OCLK_DIV
+	default 3
+
+config CDU0_CLKO0
+	default 1
+
+config CDU0_CLKO1
+	default 1
+
+config CDU0_CLKO2
+	default 1
+
+config CDU0_CLKO3
+	default 1
+
+config CDU0_CLKO4
+	default 1
+
+config CDU0_CLKO5
+	default 1
+
+config CDU0_CLKO6
+	default 1
+
+config CDU0_CLKO7
+	default 5
+
+config CDU0_CLKO8
+	default 1
+
+config CDU0_CLKO9
+	default 1
+
+endif
diff --git a/board/adi/sc584-ezkit/sc584-ezkit.env b/board/adi/sc584-ezkit/sc584-ezkit.env
new file mode 100644
index 0000000000..af9a9e01bc
--- /dev/null
+++ b/board/adi/sc584-ezkit/sc584-ezkit.env
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later+ */
+
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+#include <env/adi/adi_boot.env>
+
+adi_stage2_offset=0x20000
+adi_image_offset=0xE0000
+adi_rfs_offset=0x6E0000
+loadaddr=0x89300000
+jffs2file=adsp-sc5xx-__stringify(CONFIG_ADI_IMAGE)-adsp-sc584-ezkit.jffs2
diff --git a/common/spl/Kconfig b/common/spl/Kconfig
index e723ff1996..a7378bea8f 100644
--- a/common/spl/Kconfig
+++ b/common/spl/Kconfig
@@ -87,6 +87,7 @@ config SPL_MAX_SIZE
 	default 0x10000 if ASPEED_AST2600
 	default 0x27000 if IMX8MM && SPL_TEXT_BASE = 0x7E1000
 	default 0x30000 if ARCH_SC5XX && (SC59X_64 || SC59X)
+	default 0x20000 if ARCH_SC5XX && SC58X
 	default 0x0
 	help
 	  Maximum size of the SPL image (text, data, rodata, and linker lists
@@ -124,6 +125,7 @@ config SPL_BSS_START_ADDR
 	default 0x2ff80000 if ARCH_SUNXI && MACH_SUN9I
 	default 0x1000 if ARCH_ZYNQMP
 	default 0x200B0000 if ARCH_SC5XX && (SC59X_64 || SC59X)
+	default 0x20080000 if ARCH_SC5XX && SC58X
 
 choice
 	prompt "Enforce SPL BSS limit"
@@ -395,6 +397,7 @@ config SPL_STACK
 	default 0x18000 if MACH_SUN9I
 	default 0x8000 if ARCH_SUNXI
 	default 0x200E4000 if ARCH_SC5XX && (SC59X_64 || SC59X)
+	default 0x200B0000 if ARCH_SC5XX && SC58X
 	help
 	  Address of the start of the stack SPL will use before SDRAM is
 	  initialized.
diff --git a/include/configs/sc584-ezkit.h b/include/configs/sc584-ezkit.h
new file mode 100644
index 0000000000..905836cc2c
--- /dev/null
+++ b/include/configs/sc584-ezkit.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * (C) Copyright 2024 - Analog Devices, Inc.
+ */
+
+#ifndef __CONFIG_SC584_EZKIT_H
+#define __CONFIG_SC584_EZKIT_H
+
+/*
+ * Memory Settings
+ */
+#define MEM_MT47H128M16RT
+#define MEM_DMC0
+
+#define CFG_SYS_SDRAM_BASE	0x89000000
+#define CFG_SYS_SDRAM_SIZE	0x7000000
+
+#endif

-- 
2.34.1


