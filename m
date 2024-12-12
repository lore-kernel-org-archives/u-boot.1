Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9F2E77180
	for <u-boot@archiver.kernel.org>; Thu, 12 Dec 2024 13:41:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD8788021A;
	Thu, 12 Dec 2024 14:41:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="sf3nfXkl";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="qWE2qcDt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF64480274; Thu, 12 Dec 2024 14:41:03 +0100 (CET)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC0B48008A
 for <u-boot@lists.denx.de>; Thu, 12 Dec 2024 14:40:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut+renesas@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4Y8DBd4zXcz9sW6;
 Thu, 12 Dec 2024 14:40:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ji7K3fLsI5MtXdI5++gjaSJYcSujtayrt7g8ujF0E2I=;
 b=sf3nfXklWrup3ZqEvNTM1dHMsAFAZlE2nr6AOkxYZFRsKeIq2WoIjyYKe6Umvx7XWct4Ya
 t+OrvyK1j/VbgvoOyAN5sgcBx3MIGohFpal3va9UwQ95v/oxhuLZqBVSzQS2sBspOUKwMP
 qL9HQZvYH5//DheAA9uO1xZO9pNhV35QJ+aJs6oSV/QWr4BB7DOC5Rs1Grcxwi4VmEXJES
 TVQD8kRdBERjf32mGi9t/sA0RN+tli36IKzPnBmuf8wD0XI3J5SStAgmMQr949fnB5MSil
 dVJHvq56dwLENY1Fg/4ZO+uTlgyC6tAFfS9z9DjueDew+CA8jcy/XsxEhkjJKA==
From: Marek Vasut <marek.vasut+renesas@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1734010855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ji7K3fLsI5MtXdI5++gjaSJYcSujtayrt7g8ujF0E2I=;
 b=qWE2qcDtDE0JevD50oCQzkgxuxFYie6oATXCQI0zaRUdb+VXimmFKtwurfPlkt+csSInyP
 i3ujWm9IZ/7WIqtCv21bhOyHyMF/1O/HUNeJwtUvwEkJwQ0mEQ7VCHLFACzrh9VtoO5FVU
 bGxn26tezJDWmEVpWDHu7lpTvyq18CXg+MmqoMwwcLnxsqWz6Chn76vf6RWif5UC/EG4Vh
 BU+BYQUOTctgF1u3GY5TDKsfFsJLFED52rqn9Ypkgae+2bzFJ7Z65MjEmWutYwsvqeYqoY
 ba51Wvqv0YCa98xSylZnhLhgLO87lboMW3CjG9yksXDjfdqHHaAQZN+b+O+4Rw==
To: u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Adam Ford <aford173@gmail.com>, Biju Das <biju.das.jz@bp.renesas.com>,
 Hai Pham <hai.pham.ud@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 3/3] arm64: renesas: Add Renesas R-Car V4H SPL implementation
Date: Thu, 12 Dec 2024 14:38:29 +0100
Message-ID: <20241212134025.84612-3-marek.vasut+renesas@mailbox.org>
In-Reply-To: <20241212134025.84612-1-marek.vasut+renesas@mailbox.org>
References: <20241212134025.84612-1-marek.vasut+renesas@mailbox.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: mgnu8u7r9mc66t7pkaabgzut39pygmo1
X-MBO-RS-ID: 7380639f308f9d23609
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

Add support for building U-Boot SPL for Renesas R-Car Gen4 R8A779G0 V4H SoC.
The SPL initializes the DBSC5 DRAM controller, RT-VRAM and loads and starts
U-Boot proper on the Cortex-A76 core.

The SoC BootROM can not boot the CA76 core directly, instead the SPL starts
on the CR52 core which immediately brings up the CA76 core, which in turn
starts executing the actual SPL. This is achieved by placing a tiny bit of
precompiled Aarch32 code at the very beginning of the SPL. The code consists
of some 32 instructions, uses APMU to configure CA76 start address to offset
0x80 Bytes from start of the SPL, and uses APMU to start the CA76 core. The
code parts the CR52 core in an endless loop once the CA76 core got started.

The 32 instructions are completely arbitrary number, so is the offset 0x80
Bytes from start of SPL, because 0x80 = 128 decimal and 128 / 4 bytes per
instruction is 32 instructions. The 32 instructions turned out to be enough
to started the CA76 and 0x80 is nicely aligned.

Once the SPL completes hardware initialization, the SPL loads U-Boot proper.
The u-boot.itb proper fitImage contains 64bit build on u-boot-nodtb.bin and
a DT for R8A779G0 V4H White Hawk board and is generated by binman. The
u-boot.itb is loaded from SPI NOR offset 0x80000.

In order to install this setup on an existing R8A779G0 V4H White Hawk board,
build using r8a779g0_whitehawk_defconfig, generate SPI NOR image flash.bin
and write flash.bin to SPI NOR offset 0x0 . Finally, configure board MD pin
switches according to the R8A779G0 V4H White Hawk board documentation for
40 MHz SPI NOR boot using DMA and restart the board.

Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
---
Cc: Adam Ford <aford173@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Hai Pham <hai.pham.ud@renesas.com>
Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
Cc: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
---
 arch/arm/dts/r8a779g0-u-boot.dtsi            | 150 ++++++++++++++++++-
 arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi |   6 +
 arch/arm/mach-renesas/Kconfig.rcar4          |  10 ++
 arch/arm/mach-renesas/include/mach/boot0.h   |  58 +++++++
 board/renesas/rcar-common/gen4-spl.c         | 119 +++++++++++++++
 board/renesas/whitehawk/Makefile             |   4 +
 configs/r8a779g0_whitehawk_defconfig         |  38 +++++
 7 files changed, 384 insertions(+), 1 deletion(-)
 create mode 100644 board/renesas/rcar-common/gen4-spl.c

diff --git a/arch/arm/dts/r8a779g0-u-boot.dtsi b/arch/arm/dts/r8a779g0-u-boot.dtsi
index 42df321178b..90f021299c5 100644
--- a/arch/arm/dts/r8a779g0-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-u-boot.dtsi
@@ -7,12 +7,160 @@
 
 #include "r8a779x-u-boot.dtsi"
 
+/ {
+	binman: binman {
+		multiple-images;
+
+		section {
+			filename = "flash.bin";
+			pad-byte = <0xff>;
+
+			/* Offset 0x0000 set to 0x0000_0000 */
+			fill@0 {
+				offset = <0x0>;
+				size = <0x4>;
+				fill-byte = [00];
+			};
+
+			/* Offset 0x300c set to 0x0000_0000 */
+			fill@300c {
+				offset = <0x300c>;
+				size = <0x4>;
+				fill-byte = [00];
+			};
+
+			/* Offset 0x3154 set to 0xeb21_0000 */
+			fill@3154 {
+				offset = <0x3154>;
+				size = <0x2>;
+				fill-byte = [00];
+			};
+
+			fill@3156 {
+				offset = <0x3156>;
+				size = <0x1>;
+				fill-byte = [21];
+			};
+
+			fill@3157 {
+				offset = <0x3157>;
+				size = <0x1>;
+				fill-byte = [eb];
+			};
+
+			/* Offset 0x3264 set to 0x0003_b000 */
+			fill@3264 {
+				offset = <0x3264>;
+				size = <0x1>;
+				fill-byte = [00];
+			};
+
+			fill@3265 {
+				offset = <0x3265>;
+				size = <0x1>;
+				fill-byte = [b0];
+			};
+
+			fill@3266 {
+				offset = <0x3266>;
+				size = <0x1>;
+				fill-byte = [03];
+			};
+
+			fill@3267 {
+				offset = <0x3267>;
+				size = <0x1>;
+				fill-byte = [00];
+			};
+
+			u-boot-spl {
+				offset = <0x40000>;
+				align-end = <4>;
+			};
+
+			u-boot {
+				offset = <CONFIG_SYS_SPI_U_BOOT_OFFS>;
+				filename = "u-boot.itb";
+
+				fit {
+					description = "U-Boot mainline";
+					fit,fdt-list = "of-list";
+					#address-cells = <1>;
+
+					images {
+						uboot {
+							arch = "arm64";
+							compression = "none";
+							description = "U-Boot (64-bit)";
+							type = "standalone";
+							/*
+							 * This is in DRAM. We cannot
+							 * use TEXT_BASE here because
+							 * this system uses PIE build
+							 * and TEXT_BASE=0x0 .
+							 */
+							entry = <0x44100000>;
+							load = <0x44100000>;
+
+							uboot-blob {
+								filename = "u-boot-nodtb.bin";
+								type = "blob-ext";
+							};
+						};
+
+						@fdt-SEQ {
+							compression = "none";
+							description = "NAME";
+							type = "flat_dt";
+
+							uboot-fdt-blob {
+								filename = "u-boot.dtb";
+								type = "blob-ext";
+							};
+						};
+					};
+
+					configurations {
+						default = "@config-DEFAULT-SEQ";
+
+						@config-SEQ {
+							description = "NAME";
+							fdt = "fdt-SEQ";
+							firmware = "uboot";
+						};
+					};
+				};
+			};
+		};
+	};
+};
+
+&cpg {
+	bootph-all;
+};
+
+&extalr_clk {
+	bootph-all;
+};
+
+&hscif0 {
+	bootph-all;
+};
+
+&hscif0_pins {
+	bootph-all;
+};
+
+&pfc {
+	bootph-all;
+};
+
 &rpc {
 	bank-width = <2>;
 	num-cs = <1>;
 };
 
-&extalr_clk {
+&rst {
 	bootph-all;
 };
 
diff --git a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
index 531767cfdb2..85e32208b29 100644
--- a/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
+++ b/arch/arm/dts/r8a779g0-white-hawk-u-boot.dtsi
@@ -22,8 +22,14 @@
 };
 
 &rpc {
+	bootph-all;
 	flash@0 {
+		bootph-all;
 		spi-tx-bus-width = <1>;
 		spi-rx-bus-width = <1>;
 	};
 };
+
+&qspi0_pins {
+	bootph-all;
+};
diff --git a/arch/arm/mach-renesas/Kconfig.rcar4 b/arch/arm/mach-renesas/Kconfig.rcar4
index e80dce11f54..c2812fd75e4 100644
--- a/arch/arm/mach-renesas/Kconfig.rcar4
+++ b/arch/arm/mach-renesas/Kconfig.rcar4
@@ -17,6 +17,16 @@ config R8A779F0
 config R8A779G0
 	bool "Renesas SoC R8A779G0"
 	select GICV3
+	select BINMAN
+	select SUPPORT_SPL
+	imply SPL
+	imply SPL_BOARD_INIT
+	imply SPL_LIBCOMMON_SUPPORT
+	imply SPL_LIBGENERIC_SUPPORT
+	imply SPL_SERIAL
+	imply SPL_SYS_MALLOC_SIMPLE
+	imply SPL_TINY_MEMSET
+	imply SPL_USE_TINY_PRINTF
 	imply CLK_R8A779G0
 	imply PINCTRL_PFC_R8A779G0
 
diff --git a/arch/arm/mach-renesas/include/mach/boot0.h b/arch/arm/mach-renesas/include/mach/boot0.h
index fe88a2e0373..9cc0b819e4d 100644
--- a/arch/arm/mach-renesas/include/mach/boot0.h
+++ b/arch/arm/mach-renesas/include/mach/boot0.h
@@ -6,6 +6,7 @@
 #ifndef __BOOT0_H
 #define __BOOT0_H
 
+#if IS_ENABLED(CONFIG_RCAR_GEN2)
 _start:
 	ARM_VECTORS
 
@@ -19,5 +20,62 @@ _start:
 	.word	0x0badc0d3;
 	.word	0x0badc0d3;
 #endif
+#endif
+
+#if IS_ENABLED(CONFIG_R8A779G0)
+
+#ifdef CONFIG_XPL_BUILD
+	/* r1=0xe6170800 */
+	.inst	0xe3a004e6	/* mov     r0,     #0xe6000000 */
+	.inst	0xe3801817	/* orr     r1, r0, #0x170000 */
+	.inst	0xe3811b02	/* orr     r1, r1, #0x800 */
+
+	/* r0=0xe6280000 */
+	.inst	0xe380070a	/* orr     r0, r0, #0x280000 */
+
+	/* APMU_RVBARPLC0 = (address of 'b reset' below) | CA_CORE0_VLD_RVBARP */
+	.inst	0xe28f3068	/* add     r3, pc, #0x68 */
+	.inst	0xe3833001	/* orr     r3, r3, #1 */
+	.inst	0xe5813038	/* str     r3, [r1, #56]   @ 0x38 */
+
+	/* APMU_RVBARPHC0 = 0 */
+	.inst	0xe3a03000	/* mov     r3, #0 */
+	.inst	0xe581303c	/* str     r3, [r1, #60]   @ 0x3c */
+
+	/* PRR & 0xff00 ?= 0x5c00, test if this is V4H or V4M */
+	.inst	0xe3a024ff	/* mov     r2, #0xff000000 */
+	.inst	0xe382260f	/* orr     r2, r2, #0xf00000 */
+	.inst	0xe5923044	/* ldr     r3, [r2, #68]   @ 0x44 */
+	.inst	0xe2033cff	/* and     r3, r3, #0xff00 */
+	.inst	0xe3530b17	/* cmp     r3, #0x5c00 */
+	.inst	0x1a00000a	/* bne     68 <reset-0x18> */
+	/* if (SoC is V4H) { */
+	/* AP_CORE_APSREG_AP_CLUSTER_N_AUX0 |= AP_CORE_APSREG_AP_CLUSTER_N_AUX0_INIT */
+	.inst	0xe5903010	/* ldr     r3, [r0, #16] */
+	.inst	0xe3833003	/* orr     r3, r3, #3 */
+	.inst	0xe5803010	/* str     r3, [r0, #16] */
+	/* AP_CORE_APSREG_CCI500_AUX |= AP_CORE_APSREG_CCI500_AUX_ACTDIS */
+	.inst	0xe3800a09	/* orr     r0, r0, #36864  @ 0x9000 */
+	.inst	0xe5903010	/* ldr     r3, [r0, #16] */
+	.inst	0xe3833001	/* orr     r3, r3, #1 */
+	.inst	0xe5803010	/* str     r3, [r0, #16] */
+	/* AP_CORE_APSREG_P_CCI500_AUX |= AP_CORE_APSREG_P_CCI500_AUX_ASPRTM */
+	.inst	0xe3800802	/* orr     r0, r0, #131072 @ 0x20000 */
+	.inst	0xe5903010	/* ldr     r3, [r0, #16] */
+	.inst	0xe3833002	/* orr     r3, r3, #2 */
+	.inst	0xe5803010	/* str     r3, [r0, #16] */
+	/* } */
+	/* APMU_PWRCTRLC0 = CA_CORE0_WUP_REQ */
+	.inst	0xe3a03001	/* mov     r3, #1 */
+	.inst	0xe5813000	/* str     r3, [r1] */
+	/* Endless loop */
+	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
+	.inst	0xeafffffd	/* b       70 <reset-0x10> */
+	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
+	.inst	0xe1a00000	/* nop                     @ (mov r0, r0) */
+	/* Offset 0x80 */
+#endif
+	b	reset
+#endif
 
 #endif /* __BOOT0_H */
diff --git a/board/renesas/rcar-common/gen4-spl.c b/board/renesas/rcar-common/gen4-spl.c
new file mode 100644
index 00000000000..2aca8baf3dd
--- /dev/null
+++ b/board/renesas/rcar-common/gen4-spl.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * R-Car Gen4 Cortex-R52 SPL
+ *
+ * Copyright (C) 2024 Marek Vasut <marek.vasut+renesas@mailbox.org>
+ */
+
+#include <asm/arch/renesas.h>
+#include <asm/io.h>
+#include <cpu_func.h>
+#include <dm/uclass.h>
+#include <dm/util.h>
+#include <hang.h>
+#include <image.h>
+#include <init.h>
+#include <linux/bitops.h>
+#include <log.h>
+#include <mapmem.h>
+#include <spl.h>
+
+#define CNTCR_EN	BIT(0)
+
+#ifdef CONFIG_SPL_BUILD
+void board_debug_uart_init(void)
+{
+}
+#endif
+
+static void init_generic_timer(void)
+{
+	const u32 freq = CONFIG_SYS_CLK_FREQ;
+
+	/* Update memory mapped and register based freqency */
+	if (IS_ENABLED(CONFIG_ARM64))
+		asm volatile("msr cntfrq_el0, %0" :: "r" (freq));
+	else
+		asm volatile("mcr p15, 0, %0, c14, c0, 0" :: "r" (freq));
+
+	writel(freq, CNTFID0);
+
+	/* Enable counter */
+	setbits_le32(CNTCR_BASE, CNTCR_EN);
+}
+
+void board_init_f(ulong dummy)
+{
+	struct udevice *dev;
+	int ret;
+
+	if (CONFIG_IS_ENABLED(OF_CONTROL)) {
+		ret = spl_early_init();
+		if (ret) {
+			debug("spl_early_init() failed: %d\n", ret);
+			hang();
+		}
+	}
+
+	preloader_console_init();
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "ram@e6780000", &dev);
+	if (ret)
+		printf("DBSC5 init failed: %d\n", ret);
+
+	ret = uclass_get_device_by_name(UCLASS_RAM, "ram@ffec0000", &dev);
+	if (ret)
+		printf("RTVRAM init failed: %d\n", ret);
+};
+
+u32 spl_boot_device(void)
+{
+	return BOOT_DEVICE_SPI;
+}
+
+struct legacy_img_hdr *spl_get_load_buffer(ssize_t offset, size_t size)
+{
+	return map_sysmem(CONFIG_SYS_LOAD_ADDR + offset, 0);
+}
+
+void __noreturn jump_to_image_no_args(struct spl_image_info *spl_image)
+{
+	debug("image entry point: 0x%lx\n", spl_image->entry_point);
+	if (spl_image->os == IH_OS_ARM_TRUSTED_FIRMWARE) {
+		typedef void (*image_entry_arg_t)(int, int, int, int)
+			__attribute__ ((noreturn));
+		image_entry_arg_t image_entry =
+			(image_entry_arg_t)(uintptr_t) spl_image->entry_point;
+		image_entry(IH_MAGIC, CONFIG_SPL_TEXT_BASE, 0, 0);
+	} else {
+		typedef void __noreturn (*image_entry_noargs_t)(void);
+		image_entry_noargs_t image_entry =
+			(image_entry_noargs_t)spl_image->entry_point;
+		image_entry();
+	}
+}
+
+#define APMU_BASE 0xe6170000U
+#define CL0GRP3_BIT			BIT(3)
+#define CL1GRP3_BIT			BIT(7)
+#define RTGRP3_BIT			BIT(19)
+#define APMU_ACC_ENB_FOR_ARM_CPU	(CL0GRP3_BIT | CL1GRP3_BIT | RTGRP3_BIT)
+
+void s_init(void)
+{
+	/* Unlock CPG access */
+	writel(0x5A5AFFFF, CPGWPR);
+	writel(0xA5A50000, CPGWPCR);
+	init_generic_timer();
+
+	/* Define for Work Around of APMU */
+	writel(0x00ff00ff, APMU_BASE + 0x10);
+	writel(0x00ff00ff, APMU_BASE + 0x14);
+	writel(0x00ff00ff, APMU_BASE + 0x18);
+	writel(0x00ff00ff, APMU_BASE + 0x1c);
+	clrbits_le32(APMU_BASE + 0x68, BIT(29));
+}
+
+void reset_cpu(void)
+{
+}
diff --git a/board/renesas/whitehawk/Makefile b/board/renesas/whitehawk/Makefile
index 38726cd79f3..80f92e6b041 100644
--- a/board/renesas/whitehawk/Makefile
+++ b/board/renesas/whitehawk/Makefile
@@ -6,4 +6,8 @@
 # SPDX-License-Identifier: GPL-2.0+
 #
 
+ifdef CONFIG_SPL_BUILD
+obj-y	:= ../rcar-common/gen4-spl.o
+else
 obj-y	:= ../rcar-common/gen4-common.o ../rcar-common/common.o
+endif
diff --git a/configs/r8a779g0_whitehawk_defconfig b/configs/r8a779g0_whitehawk_defconfig
index 758b0ff5c97..dc6fd6333f7 100644
--- a/configs/r8a779g0_whitehawk_defconfig
+++ b/configs/r8a779g0_whitehawk_defconfig
@@ -10,6 +10,7 @@ CONFIG_TARGET_WHITEHAWK=y
 CONFIG_SYS_CLK_FREQ=16666666
 CONFIG_SYS_BOOT_GET_CMDLINE=y
 CONFIG_SYS_BARGSIZE=2048
+CONFIG_BINMAN=y
 CONFIG_BOOTCOMMAND="tftp 0x48080000 Image && tftp 0x48000000 Image-r8a779g0-white-hawk.dtb && booti 0x48080000 - 0x48000000"
 CONFIG_DEFAULT_FDT_FILE="r8a779g0-white-hawk.dtb"
 CONFIG_SYS_CBSIZE=2048
@@ -21,3 +22,40 @@ CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
 CONFIG_RENESAS_RAVB=y
 CONFIG_BAUDRATE=921600
+
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0xeb300000
+CONFIG_SPL_DM_SPI=y
+CONFIG_SPL_TEXT_BASE=0xeb210000
+CONFIG_SPL_STACK_R_ADDR=0x44000000
+CONFIG_SPL_SYS_MALLOC_F_LEN=0x20000
+CONFIG_SPL_STACK_R=y
+CONFIG_SPL_SPI_FLASH_SUPPORT=y
+CONFIG_SPL_SPI=y
+CONFIG_SPL_FIT_PRINT=y
+CONFIG_SPL_LOAD_FIT=y
+CONFIG_SPL_LOAD_FIT_ADDRESS=0x48000000
+# CONFIG_SPL_BOARD_INIT is not set
+# CONFIG_SPL_LEGACY_IMAGE_FORMAT is not set
+# CONFIG_SPL_SEPARATE_BSS is not set
+CONFIG_SPL_DM_SPI_FLASH=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_SPI_LOAD=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_SPL_DM=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_PINCONF=y
+CONFIG_SPL_RAM=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_RAM=y
+CONFIG_RAM_RENESAS_DBSC5=y
+CONFIG_SPL_MAX_SIZE=0x40000
+CONFIG_ENABLE_ARM_SOC_BOOT0_HOOK=y
+CONFIG_SYS_SPI_U_BOOT_OFFS=0x80000
+CONFIG_SPL_BSS_MAX_SIZE=0x10000
+CONFIG_SF_DEFAULT_SPEED=40000000
+# CONFIG_SPL_PARTITIONS is not set
+# CONFIG_SPL_DOS_PARTITION is not set
+# CONFIG_SPL_EFI_PARTITION is not set
+# CONFIG_SPL_PARTITION_UUIDS is not set
+# CONFIG_SPL_DM_MMC is not set
-- 
2.45.2

