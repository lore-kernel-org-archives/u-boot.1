Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EAC811125807
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:17:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A74B8410B;
	Wed, 11 Mar 2026 14:16:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="mG+vds3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A5E4E83FED; Wed, 11 Mar 2026 09:41:46 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7CF083FB6
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 09:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=bR
 gf4tHx2QPaRnplCllVjIny7siKEOzymzrQuqq67/E=; b=mG+vds3F9z2uyBG5UG
 rXv19BtCvFV/M8lrFME//6Up4LPZvsq0qoHN2OjZ6VJP55huG9lx9o62vAcYTQwQ
 qF4VmqoSG+OFyIsBQT27KwMrVu5fymxK5j1HHqITQ2MOsQzKlJNZqDX3yV8fEq6w
 XHRK0EZVwfLdiXU5OhyMaDSHA=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAHLsa5KrFpe9OOAQ--.40770S4; 
 Wed, 11 Mar 2026 16:41:31 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 2/7] mips: loongson: lowlevel initialize
Date: Wed, 11 Mar 2026 16:41:24 +0800
Message-ID: <20260311084129.12809-3-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311084129.12809-1-sgdfkk@163.com>
References: <20260311084129.12809-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAHLsa5KrFpe9OOAQ--.40770S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3GrWrCw1rXrW8Gw1xZw45GFg_yoWxCr4Dpr
 1jkay5tw18Ga17Wwn3KF1rKr13JFnYgryYyrnrXr48uF4xJw1xGFWqgw43tr9xXFsYyayr
 JrykXa1j939rZw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jshLnUUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbCwBt-1mmxKrvZKgAA3I
X-Mailman-Approved-At: Wed, 11 Mar 2026 14:15:12 +0100
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

From: Du Huanpeng <u74147@gmail.com>

- pll
- spi controller
- sdram

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 .../mach-loongson/ls1c300/lowlevel_init.S     | 134 ++++++++++++++++++
 arch/mips/mach-loongson/ls1c300/sdram.S       |  95 +++++++++++++
 2 files changed, 229 insertions(+)
 create mode 100644 arch/mips/mach-loongson/ls1c300/lowlevel_init.S
 create mode 100644 arch/mips/mach-loongson/ls1c300/sdram.S

diff --git a/arch/mips/mach-loongson/ls1c300/lowlevel_init.S b/arch/mips/mach-loongson/ls1c300/lowlevel_init.S
new file mode 100644
index 00000000000..8d9ba97130c
--- /dev/null
+++ b/arch/mips/mach-loongson/ls1c300/lowlevel_init.S
@@ -0,0 +1,134 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author:  Gao Weijie <weijie.gao@mediatek.com>
+ *
+ * Copyright (C) 2020-2023 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <config.h>
+#include <asm-offsets.h>
+#include <asm/cacheops.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <linux/sizes.h>
+
+/* PLL control register */
+#define NAND_BASE	0xbfe70000
+#define START_FREQ	0x8030
+#define CLK_DIV_PARAM	0x8034
+#define CPU_THROT	0xc010
+
+/* START_FREQ */
+#define PLL_VALID	31
+#define Reserved_24	24
+#define FRAC_N		16
+#define M_PLL		8
+#define Reserved_4	4
+#define RST_TIME	2
+#define SDRAM_DIV	0
+ #define SDRAM_DIV2	0
+ #define SDRAM_DIV4	1
+ #define SDRAM_DIV3	2
+
+/* CLK_DIV_PARAM */
+#define PIX_DIV		24
+#define CAM_DIV		16
+#define CPU_DIV		8
+#define PIX_DIV_VALID	5
+#define PIX_SEL		4
+#define CAM_DIV_VALID	3
+#define CAM_SEL		2
+#define CPU_DIV_VALID	1
+#define CPU_SEL		0
+
+/* Document:
+ * Freq_PLL = XIN *(M_PLL + FRAC_N)/4
+ */
+#define XIN			24000000
+#define PLL_VALID_1		(1<<PLL_VALID)
+#define PREP_M_PLL(Freq_PLL)	(((Freq_PLL * 4) / XIN) << M_PLL)
+#define PREP_SDRAM_DIV(div)	(div<<SDRAM_DIV)
+#define PREP_CPU_DIV(div1)	((0x80|div1)<<CPU_DIV | (div1&&div1)<<CPU_DIV_VALID)
+#define PREP_PIX_DIV(div2)	(div2<<PIX_DIV)
+#define PREP_CAM_DIV(div3)	(div3<<CAM_DIV)
+
+/* PLL @264MHz, CPU @132MHz, SDRAM @66MHz */
+#define CFG_START_FREQ		(PLL_VALID_1 | PREP_M_PLL(264000000) | SDRAM_DIV2)
+#define CFG_CLK_DIV_PARAM	(PREP_CPU_DIV(2) | PREP_PIX_DIV(0x24) | PREP_CAM_DIV(0x24))
+#define CFG_CPU_THROT		15
+
+/* SPI0 control register */
+#define SPI0_BASE		0xbfe80000
+#define SPCR			0
+#define SPSR			1
+#define TxFIFO			2
+#define RxFIFO			2
+#define SPER			3
+#define SFC_PARAM		4
+    #define CLK_DIV		4
+    #define DUAL_IO		3
+    #define FAST_READ		2
+    #define BURST_EN		1
+    #define MEMORY_EN		0
+#define SFC_SOFTCS		5
+#define SFC_TIMING		6
+    #define T_FAST		2
+    #define T_CSH		0
+
+	.set noreorder
+LEAF(ls1c300_pll_init)
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
+	li	t0, NAND_BASE
+	li	t1, CFG_START_FREQ
+	li	t2, CFG_CLK_DIV_PARAM
+	li	t3, CFG_CPU_THROT
+
+	sw	t3, CPU_THROT (t0)
+	sw	t2, CLK_DIV_PARAM (t0)
+	sw	t1, START_FREQ (t0)
+
+	ori	t2, 1<<CPU_SEL
+	sw	t2, CLK_DIV_PARAM (t0)
+#endif
+	jr	ra
+	 nop
+END(ls1c300_pll_init)
+
+LEAF(ls1c300_spi_init)
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
+	li	t0, SPI0_BASE
+	li	t1, (1<<MEMORY_EN) | (1<<BURST_EN) | (1<<FAST_READ) | (1<<DUAL_IO)
+	sb	t1, SFC_PARAM (t0)
+	li	t2, (1<<T_FAST) | (1<<T_CSH)
+	sb	t2, SFC_TIMING (t0)
+#endif
+	jr	ra
+	  nop
+END(ls1c300_spi_init)
+
+NESTED(lowlevel_init, 0, ra)
+	/* Save ra and do real lowlevel initialization */
+	move	s0, ra
+	/* Setup PLL @264MHz */
+	PTR_LA	t9, ls1c300_pll_init
+	jalr	t9
+	  nop
+
+	/* Setup SPI Dual IO@33MHz */
+	PTR_LA	t9, ls1c300_spi_init
+	jalr	t9
+	  nop
+
+	/* Setup external SDRAM @66MHz */
+	PTR_LA	t9, ls1c300_sdram_init
+	jalr	t9
+	  nop
+
+	move	ra, s0
+	jr	ra
+	 nop
+END(lowlevel_init)
diff --git a/arch/mips/mach-loongson/ls1c300/sdram.S b/arch/mips/mach-loongson/ls1c300/sdram.S
new file mode 100644
index 00000000000..0dadd41adea
--- /dev/null
+++ b/arch/mips/mach-loongson/ls1c300/sdram.S
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2023 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <config.h>
+#include <asm-offsets.h>
+#include <asm/cacheops.h>
+#include <asm/regdef.h>
+#include <asm/mipsregs.h>
+#include <asm/addrspace.h>
+#include <asm/asm.h>
+#include <linux/sizes.h>
+
+/* sdram control 64 bit register */
+#define SD_CONFIG	0xbfd00000
+#define SD_CONFIGHI	0x414
+#define SD_CONFIGLO	0x410
+
+#define VALID		41
+#define HANG_UP		40
+#define DEF_SEL		39
+#define TWR		37
+#define TREF		25
+#define TRAS		21
+#define TRFC		17
+#define TRP		14
+#define TCL		11
+#define TRCD		8
+
+#define SD_BIT		6
+  #define SD_8BIT       (0<<SD_BIT)
+  #define SD_16BIT      (1<<SD_BIT)
+  #define SD_32BIT      (2<<SD_BIT)
+#define SD_CSIZE	3
+  #define SD_CSIZE_512	(0<<SD_CSIZE)
+  #define SD_CSIZE_1K	(1<<SD_CSIZE)
+  #define SD_CSIZE_2K	(2<<SD_CSIZE)
+  #define SD_CSIZE_4K	(3<<SD_CSIZE)
+  #define SD_CSIZE_256	(7<<SD_CSIZE)
+#define SD_RSIZE	0
+  #define SD_RSIZE_2K	(0<<SD_RSIZE)
+  #define SD_RSIZE_4K	(1<<SD_RSIZE)
+  #define SD_RSIZE_8K	(2<<SD_RSIZE)
+  #define SD_RSIZE_16K	(3<<SD_RSIZE)
+
+#define SD_CFG_1(tWR, tREF, tRAS, tRFC, tRP, tCL, tRCD) \
+	((tWR<<TWR)|(tREF<<TREF)|(tRAS<<TRAS)|(tRFC<<TRFC)|(tRP<<TRP)|(tCL<<TCL)|(tRCD<<TRCD))
+#define CFG_SD_0(b, c, r) \
+	((b<<SD_BIT)|(c<<SD_CSIZE)|(r<<SD_RSIZE))
+/*
+ * recommended values by ls1c300 user manual,
+ * tweak to fit your board.
+ */
+#define SD_CONFIG_133MHz	SD_CFG_1(2, 0x818, 6, 8, 3, 3, 3)
+#define SD_CONFIG_100MHz	SD_CFG_1(2, 0x620, 5, 6, 2, 3, 2)
+#define SD_CONFIG_75MHz		SD_CFG_1(1, 0x494, 4, 5, 2, 2, 2)
+#define SD_CONFIG_33MHz		SD_CFG_1(1, 0x204, 2, 2, 1, 2, 1)
+
+#define SD_CONFIG_66MHz		SD_CFG_1(1, 0x401, 4, 4, 2, 2, 2)
+
+#define SD_CONFIG64	(SD_CONFIG_66MHz | SD_16BIT | SD_CSIZE_1K | SD_RSIZE_8K)
+#define CFG_SDCONFIGHI	(SD_CONFIG64 /(1<<32))
+#define CFG_SDCONFIGLO	(SD_CONFIG64 %(1<<32))
+
+	.set noreorder
+/*
+ * Loongson ls1c300 SoC do not have onchip sram for initial stack,
+ * initialize the external sdram on reset as early as possiable.
+ */
+LEAF(ls1c300_sdram_init)
+#if !CONFIG_IS_ENABLED(SKIP_LOWLEVEL_INIT)
+	li	t0, SD_CONFIG
+	li	t1, CFG_SDCONFIGLO
+	li	t2, CFG_SDCONFIGHI
+
+/* store twice as the hardware manual required. */
+	sw	t1, SD_CONFIGLO (t0)
+	sw	t2, SD_CONFIGHI (t0)
+	sync
+
+	sw	t1, SD_CONFIGLO (t0)
+	sw	t2, SD_CONFIGHI (t0)
+	sync
+
+	ori	t2, 1<<(VALID-32)
+	sw	t1, SD_CONFIGLO (t0)
+	sw	t2, SD_CONFIGHI (t0)
+	sync
+#endif
+	jr	ra
+	 nop
+END(ls1c300_sdram_init)
+
+
-- 
2.43.0

