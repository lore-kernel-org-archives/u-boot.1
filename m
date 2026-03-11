Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916DA1125806
	for <u-boot@archiver.kernel.org>; Wed, 11 Mar 2026 13:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6299D8409B;
	Wed, 11 Mar 2026 14:15:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=163.com header.i=@163.com header.b="eYSgkRiR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5166583F9A; Wed, 11 Mar 2026 06:21:08 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C1CC283F93
 for <u-boot@lists.denx.de>; Wed, 11 Mar 2026 06:21:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sgdfkk@163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Yn
 ZcYOfQSeP7u1K4jyKJzHRlYri5X03aasDAzKM+1cI=; b=eYSgkRiR9D7ACrqu6b
 7ZIOT5UEjNjoIzt06HMNAc3r5WsZdZF5xu8rV95wYt1PuuLitkFtNiuRnMZzujtx
 hEYElWOKNgq4M2n6W9TN8Ta3CpQvxp7CIEjYmWgLnR5VqISMj0VdYsGmSCAOFMAD
 ha6ZPij1RvRTHU1Nyr/TeWD6s=
Received: from server-e.. (unknown [])
 by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id
 _____wCn7zWu+7BpNZ9SAQ--.53920S3; 
 Wed, 11 Mar 2026 13:20:47 +0800 (CST)
From: sgdfkk@163.com
To: duhuanpeng@139.com,
	u-boot@lists.denx.de
Cc: chenhuacai@loongson.cn, jiaxun.yang@flygoat.com,
 Du Huanpeng <u74147@gmail.com>
Subject: [PATCH v6 1/7] mips: loongson: minimal initial SoC support
Date: Wed, 11 Mar 2026 13:20:40 +0800
Message-ID: <20260311052046.11265-2-sgdfkk@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260311052046.11265-1-sgdfkk@163.com>
References: <20260311052046.11265-1-sgdfkk@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wCn7zWu+7BpNZ9SAQ--.53920S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxKryDCw1fZFWrur43XF47urg_yoWDGrW5pa
 n0ka1rGrs7Zr47Jr93A34UWrs3Aan5GFW2vF43tFyUAa97Z3WDXFs3tFnxtrW7JFWDJayr
 WryrWFW7KF4qvw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1OJOUUUUU=
X-Originating-IP: [240e:3b0:4805:1b6:5ef3:fcff:feed:1d83]
X-CM-SenderInfo: xvjgwyrn6rljoofrz/xtbCvxCxCWmw+7AL8QAA3-
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

Loongson 1C is a cost-effective SOC chip for industrial control and
the Internet of Things. The Loongson 1C includes a floating-point
processing unit, supports multiple types of memory, and supports
high-capacity MLC NAND Flash. Loongson 1C provides developers with a
wealth of peripheral interfaces and on-chip modules, including Camera
controller, USB OTG and USB HOST interfaces, AC97/I2S controller, LCD
controller, SPI interface, UART interface, etc., providing sufficient
computing power and multi-application connectivity.

Some highlights of this SoC are:
- Single core LS232, MIPS32 instruction set compatible, main frequency
300MHZ
- 16KB data cache and 16KB instruction cache
- 64 bit float unit, hardware division
- 8/16 bit SDRAM controller, 45 ~ 133MHz
- 8/16 bit SRAM, NAND
- I2S/AC97, LCD, MAC, USB, OTG, SPI, I2C, PWM, CAN, SDIO, ADC
- 12 UARTs

Links:
https://www.loongson.cn/

introduce base support for the ls1c300 SoC.
- debug UART2
- serial console
- clock
- watchdog
- sysreset
- uart

Signed-off-by: Du Huanpeng <u74147@gmail.com>
---
 MAINTAINERS                              |  9 ++++
 arch/mips/Kconfig                        | 11 ++++
 arch/mips/Makefile                       |  1 +
 arch/mips/mach-loongson/Kconfig          | 69 ++++++++++++++++++++++++
 arch/mips/mach-loongson/Makefile         |  6 +++
 arch/mips/mach-loongson/cpu.c            | 19 +++++++
 arch/mips/mach-loongson/ls1c300/Makefile |  7 +++
 arch/mips/mach-loongson/ls1c300/init.c   | 61 +++++++++++++++++++++
 arch/mips/mach-loongson/spl.c            | 46 ++++++++++++++++
 9 files changed, 229 insertions(+)
 create mode 100644 arch/mips/mach-loongson/Kconfig
 create mode 100644 arch/mips/mach-loongson/Makefile
 create mode 100644 arch/mips/mach-loongson/cpu.c
 create mode 100644 arch/mips/mach-loongson/ls1c300/Makefile
 create mode 100644 arch/mips/mach-loongson/ls1c300/init.c
 create mode 100644 arch/mips/mach-loongson/spl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index d2040fee252..d1e6e4bc0da 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1385,6 +1385,15 @@ F:	drivers/net/cortina_ni.c
 F:	drivers/net/cortina_ni.h
 F:	drivers/net/phy/ca_phy.c
 
+MIPS LOONGSON LS1C300
+M:	Du Huanpeng <u74147@gmail.com>
+S:	Maintained
+F:	arch/mips/dts/loongson32-ls1c300b.dtsi
+F:	arch/mips/mach-loongson/
+F:	drivers/clk/loongson/
+F:	drivers/watchdog/loongson_wdt.c
+F:	include/dt-bindings/clock/ls1c300-clk.h
+
 MIPS MEDIATEK
 M:	Weijie Gao <weijie.gao@mediatek.com>
 R:	GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 36612756294..0e3fc9ceeb5 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -88,6 +88,16 @@ config ARCH_MTMIPS
 	select SUPPORT_LITTLE_ENDIAN
 	select SUPPORT_SPL
 
+config ARCH_LSMIPS
+	bool "Support Loongson MIPS platforms"
+	select DM
+	select DM_SERIAL
+	select OF_CONTROL
+	select SUPPORTS_CPU_MIPS32_R1
+	select SUPPORTS_CPU_MIPS32_R2
+	select SUPPORTS_LITTLE_ENDIAN
+	select SUPPORT_SPL
+
 config ARCH_JZ47XX
 	bool "Support Ingenic JZ47xx"
 	select SUPPORT_SPL
@@ -202,6 +212,7 @@ source "arch/mips/mach-bmips/Kconfig"
 source "arch/mips/mach-jz47xx/Kconfig"
 source "arch/mips/mach-pic32/Kconfig"
 source "arch/mips/mach-mtmips/Kconfig"
+source "arch/mips/mach-loongson/Kconfig"
 source "arch/mips/mach-octeon/Kconfig"
 
 if MIPS
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 453c7885075..72b800c755b 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -19,6 +19,7 @@ machine-$(CONFIG_ARCH_BMIPS) += bmips
 machine-$(CONFIG_ARCH_JZ47XX) += jz47xx
 machine-$(CONFIG_MACH_PIC32) += pic32
 machine-$(CONFIG_ARCH_MTMIPS) += mtmips
+machine-$(CONFIG_ARCH_LSMIPS) += loongson
 machine-$(CONFIG_ARCH_MSCC) += mscc
 machine-${CONFIG_ARCH_OCTEON} += octeon
 
diff --git a/arch/mips/mach-loongson/Kconfig b/arch/mips/mach-loongson/Kconfig
new file mode 100644
index 00000000000..57d22927270
--- /dev/null
+++ b/arch/mips/mach-loongson/Kconfig
@@ -0,0 +1,69 @@
+menu "Loongson MIPS platforms"
+	depends on ARCH_LSMIPS
+
+config SYS_MALLOC_F_LEN
+	default 0x1000
+
+config SYS_SOC
+	default "ls1c300" if SOC_LS1C300
+
+config SYS_DCACHE_SIZE
+	default 16384
+
+config SYS_DCACHE_LINE_SIZE
+	default 32
+
+config SYS_ICACHE_SIZE
+	default 16384
+
+config SYS_ICACHE_LINE_SIZE
+	default 32
+
+config SPL_PAYLOAD
+	default "u-boot-lzma.img" if SPL_LZMA
+
+config BUILD_TARGET
+	default "u-boot-with-spl.bin" if SPL
+	default "u-boot.bin" if !SPL
+
+choice
+	prompt "Loongson MIPS SoC select"
+
+config SOC_LS1C300
+	bool "LS1C300"
+	select CLK_CCF
+	select SPL_SEPARATE_BSS if SPL
+	select SPL_INIT_STACK_WITHOUT_MALLOC_F if SPL
+	select SPL_LOADER_SUPPORT if SPL
+	select SPL_OF_CONTROL if SPL_DM
+	select SPL_SIMPLE_BUS if SPL_DM
+	select SPL_DM_SERIAL if SPL_DM
+	select SPL_CLK if SPL_DM && SPL_SERIAL
+	select SPL_SYSRESET if SPL_DM
+	select SPL_OF_LIBFDT if SPL_OF_CONTROL
+	help
+	  This supports Loongson LS1C300
+
+endchoice
+
+choice
+	prompt "Board select"
+
+config BOARD_LS1C300
+	bool "Loongson LS1C300 Eval"
+	depends on SOC_LS1C300
+	help
+	  ls1c300-eval board has a LS1C300 SoC with 64MiB of SDRAM
+	  and 512KiB of flash (SPI NOR) and additional NAND storage.
+
+endchoice
+
+config CONS_PIN
+	int "pin group used in uart"
+	default 0
+	help
+	  Select pin group connected to UART for your board.
+
+source "board/loongson/ls1c300-eval/Kconfig"
+
+endmenu
diff --git a/arch/mips/mach-loongson/Makefile b/arch/mips/mach-loongson/Makefile
new file mode 100644
index 00000000000..654143a5f70
--- /dev/null
+++ b/arch/mips/mach-loongson/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+
+obj-y += cpu.o
+obj-$(CONFIG_SPL_BUILD) += spl.o
+
+obj-$(CONFIG_SOC_LS1C300) += ls1c300/
diff --git a/arch/mips/mach-loongson/cpu.c b/arch/mips/mach-loongson/cpu.c
new file mode 100644
index 00000000000..249fdcbdc5f
--- /dev/null
+++ b/arch/mips/mach-loongson/cpu.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Stefan Roese <sr@denx.de>
+ * Copyright (C) 2022-2026 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <init.h>
+#include <malloc.h>
+#include <linux/bitops.h>
+#include <linux/io.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int dram_init(void)
+{
+	gd->ram_size = get_ram_size((void *)KSEG1, SZ_256M) - CONFIG_TEXT_BASE % SZ_256M;
+	return 0;
+}
diff --git a/arch/mips/mach-loongson/ls1c300/Makefile b/arch/mips/mach-loongson/ls1c300/Makefile
new file mode 100644
index 00000000000..17b9d6fb9ca
--- /dev/null
+++ b/arch/mips/mach-loongson/ls1c300/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += lowlevel_init.o
+obj-y += sdram.o
+obj-y += init.o
+obj-y += gpio.o
+obj-$(CONFIG_SPL_BUILD) += serial.o
diff --git a/arch/mips/mach-loongson/ls1c300/init.c b/arch/mips/mach-loongson/ls1c300/init.c
new file mode 100644
index 00000000000..aea0a863e3e
--- /dev/null
+++ b/arch/mips/mach-loongson/ls1c300/init.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 MediaTek Inc.
+ *
+ * Author:  Gao Weijie <weijie.gao@mediatek.com>
+ *
+ * based on: arch/mips/mach-mtmips/mt7628/init.c
+ * Copyright (C) 2020-2026 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <clk.h>
+#include <dm.h>
+#include <dm/uclass.h>
+#include <dt-bindings/clock/ls1c300-clk.h>
+#include <linux/io.h>
+#include <linux/sizes.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int print_cpuinfo(void)
+{
+	struct udevice *udev;
+	struct clk clk;
+	int ret;
+	ulong xtal;
+	char buf[SZ_32];
+
+	printf("CPU: Loongson ls1c300b\n");
+
+	ret = uclass_get_device_by_driver(UCLASS_CLK, DM_DRIVER_GET(ls1c300_clk), &udev);
+	if (ret) {
+		printf("error: clock driver not found.\n");
+		return 0;
+	}
+
+	clk.dev = udev;
+
+	ret = clk_request(udev, &clk);
+	if (ret < 0)
+		return ret;
+
+	clk.id = CLK_XTAL;
+	xtal = clk_get_rate(&clk);
+
+	clk.id = CLK_CPU_THROT;
+	gd->cpu_clk = clk_get_rate(&clk);
+
+	clk.id = CLK_APB;
+	gd->mem_clk = clk_get_rate(&clk);
+
+	printf("Clock: CPU: %sMHz, ", strmhz(buf, gd->cpu_clk));
+	printf("SDRAM: %sMHz, ", strmhz(buf, gd->mem_clk));
+	printf("XTAL: %sMHz\n", strmhz(buf, xtal));
+
+	return 0;
+}
+
+ulong notrace get_tbclk(void)
+{
+	return gd->cpu_clk / 2;
+}
diff --git a/arch/mips/mach-loongson/spl.c b/arch/mips/mach-loongson/spl.c
new file mode 100644
index 00000000000..40454d2cbc9
--- /dev/null
+++ b/arch/mips/mach-loongson/spl.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 MediaTek Inc. All Rights Reserved.
+ *
+ * Author: Gao Weijie <weijie.gao@mediatek.com>
+ *
+ * Copyright (C) 2022-2026 Du Huanpeng <u74147@gmail.com>
+ */
+
+#include <init.h>
+#include <spl.h>
+#include <asm/sections.h>
+#include <linux/libfdt.h>
+#include <linux/sizes.h>
+#include <mach/serial.h>
+
+void __noreturn board_init_f(ulong dummy)
+{
+	spl_init();
+
+#ifdef CONFIG_SPL_SERIAL
+	/*
+	 * loongson_spl_serial_init() is useful if debug uart is enabled,
+	 * or DM based serial is not enabled.
+	 */
+	loongson_spl_serial_init();
+	preloader_console_init();
+#endif
+
+	board_init_r(NULL, 0);
+}
+
+void board_boot_order(u32 *spl_boot_list)
+{
+	spl_boot_list[0] = BOOT_DEVICE_NOR;
+}
+
+unsigned long spl_nor_get_uboot_base(void)
+{
+	void *uboot_base = __image_copy_end;
+
+	if (fdt_magic(uboot_base) == FDT_MAGIC)
+		return (unsigned long)uboot_base + fdt_totalsize(uboot_base);
+
+	return (unsigned long)uboot_base;
+}
-- 
2.43.0

