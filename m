Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C43C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 16:10:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AAAA880C7E;
	Fri, 24 Jan 2025 17:09:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id B26DA80ADC; Fri, 24 Jan 2025 16:50:23 +0100 (CET)
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36EA180A52
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 16:50:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id D548282CE2;
 Fri, 24 Jan 2025 16:50:20 +0100 (CET)
From: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date: Fri, 24 Jan 2025 16:47:49 +0100
Subject: [PATCH v3 2/3] arm: mmp: add initial support for PXA1908 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250124-coreprimevelte-v3-2-870dd251b1d1@skole.hr>
References: <20250124-coreprimevelte-v3-0-870dd251b1d1@skole.hr>
In-Reply-To: <20250124-coreprimevelte-v3-0-870dd251b1d1@skole.hr>
To: Tom Rini <trini@konsulko.com>, Stefan Roese <sr@denx.de>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht, 
 u-boot@lists.denx.de, 
 =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=9957;
 i=duje.mihanovic@skole.hr; s=20240706; h=from:subject:message-id;
 bh=J2qgv7/sFyIQE5cDagMQeabbatAn/9c7jJmpcINiAjs=;
 b=owGbwMvMwCW21nBykGv/WmbG02pJDOmTtxn9MjM+Vtb2tiHs1XGJWvfEonlc/Urr46dtXBK2b
 v1zQRP/jlIWBjEuBlkxRZbc/47XeD+LbN2evcwAZg4rE8gQBi5OAZjIei+G//VTZ0rfn3A0+3/p
 7KNffiswnZU8n/ho9dR3gtFTly9cni3I8D9zqdqFKTGzHN48u8TmIlFWtuqD/wbxrK3sb6RkwyY
 y5PECAA==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=6DFF41D60DF314B5B76BA630AD319352458FAD03
X-Mailman-Approved-At: Fri, 24 Jan 2025 17:09:55 +0100
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

Add initial support for Marvell PXA1908. The SoC has 4 Cortex-A53 cores,
a GC7000UL GPU and a variety of peripheral controllers.

Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
 MAINTAINERS                |   8 ++++
 arch/arm/Kconfig           |  11 +++++
 arch/arm/Makefile          |   1 +
 arch/arm/dts/pxa1908.dtsi  | 106 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/Kconfig  |   6 +++
 arch/arm/mach-mmp/Makefile |   1 +
 arch/arm/mach-mmp/board.c  |  84 +++++++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/mmu.c    |  30 +++++++++++++
 include/configs/pxa1908.h  |  18 ++++++++
 9 files changed, 265 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc8e048dde491c81fea568793d409ced6c5073dd..247f525847e73c6791cba816c00708044086b149 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -386,6 +386,14 @@ T:	git https://source.denx.de/u-boot/custodians/u-boot-marvell.git
 F:	drivers/pci/pci-aardvark.c
 F:	drivers/pci/pci_mvebu.c
 
+ARM MARVELL PXA1908
+M:	Duje Mihanović <duje.mihanovic@skole.hr>
+S:	Maintained
+T:	git git://git.dujemihanovic.xyz/u-boot.git
+F:	arch/arm/dts/pxa1908*
+F:	arch/arm/mach-mmp/
+F:	include/configs/pxa1908.h
+
 ARM MARVELL SERIAL DRIVERS
 M:	Pali Rohár <pali@kernel.org>
 M:	Stefan Roese <sr@denx.de>
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 314916527c9e5ef3b4cf8388511dbd224aaac512..f504d7d07601e2e275888bc179748a7ff9593a00 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -842,6 +842,15 @@ config ARCH_MEDIATEK
 	  Support for the MediaTek SoCs family developed by MediaTek Inc.
 	  Please refer to doc/README.mediatek for more information.
 
+config ARCH_MMP
+	bool "Marvell MMP"
+	select ARM64
+	select DM
+	select DM_SERIAL
+	select OF_CONTROL
+	select SAVE_PREV_BL_FDT_ADDR
+	select SAVE_PREV_BL_INITRAMFS_START_ADDR
+
 config ARCH_LPC32XX
 	bool "NXP LPC32xx platform"
 	select CPU_ARM926EJS
@@ -2310,6 +2319,8 @@ source "arch/arm/mach-meson/Kconfig"
 
 source "arch/arm/mach-mediatek/Kconfig"
 
+source "arch/arm/mach-mmp/Kconfig"
+
 source "arch/arm/mach-qemu/Kconfig"
 
 source "arch/arm/mach-rockchip/Kconfig"
diff --git a/arch/arm/Makefile b/arch/arm/Makefile
index cb87a68475406890713ad356024ee16b53ae464e..7334e79965f1f4701cf1d2aed13ccb24d2138507 100644
--- a/arch/arm/Makefile
+++ b/arch/arm/Makefile
@@ -69,6 +69,7 @@ machine-$(CONFIG_ARCH_KIRKWOOD)		+= kirkwood
 machine-$(CONFIG_ARCH_LPC32XX)		+= lpc32xx
 machine-$(CONFIG_ARCH_MEDIATEK)		+= mediatek
 machine-$(CONFIG_ARCH_MESON)		+= meson
+machine-$(CONFIG_ARCH_MMP)		+= mmp
 machine-$(CONFIG_ARCH_MVEBU)		+= mvebu
 machine-$(CONFIG_ARCH_NEXELL)		+= nexell
 machine-$(CONFIG_ARCH_NPCM)             += npcm
diff --git a/arch/arm/dts/pxa1908.dtsi b/arch/arm/dts/pxa1908.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..e8ec2606c2515ee2031004ab3102fec37b7d4b87
--- /dev/null
+++ b/arch/arm/dts/pxa1908.dtsi
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Marvell Armada PXA1908";
+	compatible = "marvell,pxa1908";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	interrupt-parent = <&gic>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 0>;
+			enable-method = "psci";
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 1>;
+			enable-method = "psci";
+		};
+
+		cpu2: cpu@2 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 2>;
+			enable-method = "psci";
+		};
+
+		cpu3: cpu@3 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a53";
+			reg = <0 3>;
+			enable-method = "psci";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gic: interrupt-controller@d1df9000 {
+			compatible = "arm,gic-400";
+			reg = <0 0xd1df9000 0 0x1000>,
+				<0 0xd1dfa000 0 0x2000>,
+				/* The subsequent registers are guesses. */
+				<0 0xd1dfc000 0 0x2000>,
+				<0 0xd1dfe000 0 0x2000>;
+			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+
+		apb@d4000000 {
+			compatible = "simple-bus";
+			reg = <0 0xd4000000 0 0x200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0 0xd4000000 0x200000>;
+
+			uart0: serial@17000 {
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
+				reg = <0x17000 0x1000>;
+				clock-frequency = <14745600>;
+				reg-shift = <2>;
+			};
+
+			uart1: serial@18000 {
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
+				reg = <0x18000 0x1000>;
+				clock-frequency = <14745600>;
+				reg-shift = <2>;
+			};
+
+			uart2: serial@36000 {
+				compatible = "mrvl,mmp-uart", "intel,xscale-uart";
+				reg = <0x36000 0x1000>;
+				clock-frequency = <117000000>;
+				reg-shift = <2>;
+			};
+		};
+	};
+};
diff --git a/arch/arm/mach-mmp/Kconfig b/arch/arm/mach-mmp/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..b9438c6facb2e7f29f608bc72e97657d97a0d7dc
--- /dev/null
+++ b/arch/arm/mach-mmp/Kconfig
@@ -0,0 +1,6 @@
+if ARCH_MMP
+
+config LNX_KRNL_IMG_TEXT_OFFSET_BASE
+	default TEXT_BASE
+
+endif
diff --git a/arch/arm/mach-mmp/Makefile b/arch/arm/mach-mmp/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..99beaed05c2493b55610f1012383755015c62958
--- /dev/null
+++ b/arch/arm/mach-mmp/Makefile
@@ -0,0 +1 @@
+obj-y += board.o mmu.o
diff --git a/arch/arm/mach-mmp/board.c b/arch/arm/mach-mmp/board.c
new file mode 100644
index 0000000000000000000000000000000000000000..3384e5377a7e0f0f379d58d18a3147fd2b8c62ae
--- /dev/null
+++ b/arch/arm/mach-mmp/board.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024
+ * Duje Mihanović <duje.mihanovic@skole.hr>
+ */
+#include <errno.h>
+#include <init.h>
+#include <fdt_support.h>
+#include <asm/io.h>
+#include <asm/global_data.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+/* Timer constants */
+#define APBC_COUNTER_CLK_SEL	0xd4015064
+#define COUNTER_BASE		0xd4101000
+#define COUNTER_EN		BIT(0)
+#define COUNTER_HALT_ON_DEBUG	BIT(1)
+
+int timer_init(void)
+{
+	u32 tmp = readl(APBC_COUNTER_CLK_SEL);
+
+	if ((tmp >> 16) != 0x319)
+		return -1;
+
+	/* Set timer frequency to 26MHz */
+	writel(tmp | 1, APBC_COUNTER_CLK_SEL);
+	writel(COUNTER_EN | COUNTER_HALT_ON_DEBUG, COUNTER_BASE);
+
+	gd->arch.timer_rate_hz = 26000000;
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+	if (fdtdec_setup_mem_size_base() != 0)
+		puts("fdtdec_setup_mem_size_base() has failed\n");
+
+	return 0;
+}
+
+#ifndef CONFIG_SYSRESET
+void reset_cpu(void)
+{
+}
+#endif
+
+/* Stolen from arch/arm/mach-snapdragon/board.c */
+int board_fdt_blob_setup(void **fdtp)
+{
+	struct fdt_header *fdt;
+	bool internal_valid, external_valid;
+	int ret = 0;
+
+	fdt = (struct fdt_header *)get_prev_bl_fdt_addr();
+	external_valid = fdt && !fdt_check_header(fdt);
+	internal_valid = !fdt_check_header(*fdtp);
+
+	/*
+	 * There is no point returning an error here, U-Boot can't do anything useful in this situation.
+	 * Bail out while we can still print a useful error message.
+	 */
+	if (!internal_valid && !external_valid)
+		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%#llx)\n",
+		      (phys_addr_t)fdt);
+
+	if (internal_valid) {
+		debug("Using built in FDT\n");
+		ret = -EEXIST;
+	} else {
+		debug("Using external FDT\n");
+		/* So we can use it before returning */
+		*fdtp = fdt;
+	}
+
+	return ret;
+}
diff --git a/arch/arm/mach-mmp/mmu.c b/arch/arm/mach-mmp/mmu.c
new file mode 100644
index 0000000000000000000000000000000000000000..ad2f1e3d994ba21bc63d05f3b33586d0bfffe702
--- /dev/null
+++ b/arch/arm/mach-mmp/mmu.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2024
+ * Duje Mihanović <duje.mihanovic@skole.hr>
+ */
+#include <asm/armv8/mmu.h>
+#include <linux/sizes.h>
+
+static struct mm_region pxa1908_mem_map[] = {
+	{
+		.virt = 0x0UL,
+		.phys = 0x0UL,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+			 PTE_BLOCK_INNER_SHARE
+	},
+	{
+		.virt = 0x80000000UL,
+		.phys = 0x80000000UL,
+		.size = 2UL * SZ_1G,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_INNER_SHARE |
+			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
+	},
+	{
+		0,
+	}
+};
+
+struct mm_region *mem_map = pxa1908_mem_map;
diff --git a/include/configs/pxa1908.h b/include/configs/pxa1908.h
new file mode 100644
index 0000000000000000000000000000000000000000..b0d6cdfeb760e215ff4a0e75d3d071c3a58ff82e
--- /dev/null
+++ b/include/configs/pxa1908.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (c) 2024
+ * Duje Mihanović <duje.mihanovic@skole.hr>
+ */
+
+#ifndef __PXA1908_H
+#define __PXA1908_H
+
+#define CFG_SYS_SDRAM_BASE	0x1000000
+#define CFG_SYS_INIT_RAM_ADDR	0x10000000
+#define CFG_SYS_INIT_RAM_SIZE	0x4000
+#define CFG_SYS_NS16550_IER	0x40
+#define CFG_SYS_BAUDRATE_TABLE	{ 115200, 230400, 460800, 921600 }
+#define CFG_EXTRA_ENV_SETTINGS \
+	"bootcmd=bootm $prevbl_initrd_start_addr\0"
+
+#endif

-- 
2.48.1


