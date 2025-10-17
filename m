Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED48CCD199
	for <u-boot@archiver.kernel.org>; Fri, 17 Oct 2025 16:51:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B03DD83849;
	Fri, 17 Oct 2025 18:51:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="O+GUibbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 077F383849; Fri, 17 Oct 2025 18:38:03 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D167C83804
 for <u-boot@lists.denx.de>; Fri, 17 Oct 2025 18:37:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 837EB25CCA;
 Fri, 17 Oct 2025 18:37:59 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hcFVDhgqkqDc; Fri, 17 Oct 2025 18:37:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1760719077; bh=MMzyAF2nWjgji2bQvKYHnFvI6O2DqfgAkQij7tB/FQw=;
 h=From:Date:Subject:To:Cc;
 b=O+GUibbdoXYi1msBIK13lX7cgiZ+pd+JudeGNktZSvt4kHUjhns38nloHn8VWJLE5
 4nnfdZIFX6aehFFT2gUuzYB/cexanhtRvgxX8u1sndiRlupuBLOWYKzFBeH/Sdca/U
 gJ+QyEr4/ofxyWIVlfqfkw809fw/SBvUchw3V2wLVgWJ9Yb3yJbyTaVimNU5u1tON5
 NuZPoC7gOJjP+oKBhaAybd6zpxJUmT4MzBJHS5LVUrIPari4QBxJtypJu2AjYLJnDv
 WmE4fAmQdHBGJFu0bWo1ZHdYjcuYNkFEzcwH8k83aby5Jw+rZ130R7brMhqsfFSdH9
 zFKSaRhSWWgaQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 17 Oct 2025 22:07:35 +0530
Subject: [PATCH] board: samsung: add support for Samsung Exynos mobile
 device boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-board-exynos-mobile-v1-1-55f47dd52fc7@disroot.org>
X-B4-Tracking: v=1; b=H4sIAM5w8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3aT8xKIU3dSKyrz8Yt3c/KTMnFRd82TzFBNjC2MjM0tjJaDOgqL
 UtMwKsKnRsRB+UWphKdDwEqhgbS0Abk+13XoAAAA=
X-Change-ID: 20251017-board-exynos-mobile-7c7d43832693
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Henrik Grimler <henrik@grimler.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760719065; l=23673;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=MMzyAF2nWjgji2bQvKYHnFvI6O2DqfgAkQij7tB/FQw=;
 b=aHUgTQUaIUJ9Nmpzy/wHl2Dub4m5IVosVcj7HdWnc8e3M9IwO3hvGWp0YGAjGnFirpuCpHbhC
 yRj24Ecq0FLDotYnYFMlIfx/6JoBuZCGaJqYIOPg1AuloXzvLJjFTFz
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 17 Oct 2025 18:51:45 +0200
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

Add support for a generic platform which intends to support multiple
boards powerid by Samsung Exynos SoCs. This patch also includes initial
support for three boards:
* Samsung Galaxy A2 Core
* Samsung Galaxy J6
* Samsung Galaxy J7 Prime

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
This patch has the following dependencies:
(NOTE: `x` indicates applied)

armv8-broken-cntfrq		- https://patch.msgid.link/20251017-armv8-broken-cntfrq-v2-1-1e043cbb657e@disroot.org
clk-exynos7870			- https://patch.msgid.link/20251017-clk-exynos7870-v1-0-83f90d425699@disroot.org
gpio-s5p-bank-fix		- https://patch.msgid.link/20251017-gpio-s5p-bank-fix-v1-1-41050462cea5@disroot.org
i2c-hs-exynos7			- https://patch.msgid.link/20251017-i2c-hs-exynos7-v1-1-ca080895d4b6@disroot.org
mmc-dw-exynos7870		- https://patch.msgid.link/20251017-mmc-dw-exynos7870-v1-0-a2c5139d9afe@disroot.org
phy-usb-exynos7870		- https://patch.msgid.link/20251017-phy-usb-exynos7870-v1-0-5885b00f0c87@disroot.org
pinctrl-exynos7870		- https://patch.msgid.link/20251017-pinctrl-exynos7870-v1-0-beaa92f95a0c@disroot.org
power-pmic-regulator-s2mpu05	- https://patch.msgid.link/20251017-power-pmic-regulator-s2mpu05-v1-0-91cadc0f4156@disroot.org
serial-s5p-exynos8895		- https://patch.msgid.link/20251017-serial-s5p-exynos8895-v1-1-b412dd112cfd@disroot.org
soc-pmu-exynos7			- https://patch.msgid.link/20251017-soc-pmu-exynos7-v1-1-553d18eaab0d@disroot.org
usb-dwc3-exynos7870		- https://patch.msgid.link/20251017-usb-dwc3-exynos7870-v1-0-fe46e2ed1908@disroot.org
---
 arch/arm/mach-exynos/Kconfig                       |  11 +-
 board/samsung/exynos-mobile/Kconfig                |  18 +
 board/samsung/exynos-mobile/MAINTAINERS            |   6 +
 board/samsung/exynos-mobile/Makefile               |   5 +
 .../samsung/exynos-mobile/debug-exynos7870.config  |   7 +
 board/samsung/exynos-mobile/exynos-mobile.c        | 372 +++++++++++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.env      |  18 +
 configs/exynos-mobile_defconfig                    |  71 ++++
 doc/board/samsung/exynos-mobile.rst                | 112 +++++++
 doc/board/samsung/index.rst                        |   1 +
 include/configs/exynos-mobile.h                    |  14 +
 11 files changed, 634 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-exynos/Kconfig b/arch/arm/mach-exynos/Kconfig
index 2cd67d023867de29bf85fe6d68b3485dbb67853c..b084b7284aa08eafbc740e47fbc8385f8eb2d7db 100644
--- a/arch/arm/mach-exynos/Kconfig
+++ b/arch/arm/mach-exynos/Kconfig
@@ -2,7 +2,7 @@ if ARCH_EXYNOS
 
 config BOARD_COMMON
 	def_bool y
-	depends on !TARGET_SMDKV310 && !TARGET_ARNDALE && !TARGET_E850_96
+	depends on !TARGET_SMDKV310 && !TARGET_ARNDALE && !TARGET_EXYNOS_MOBILE && !TARGET_E850_96
 
 config SPI_BOOTING
 	bool
@@ -252,6 +252,14 @@ config TARGET_E850_96
 endchoice
 endif
 
+config TARGET_EXYNOS_MOBILE
+	bool "Samsung Exynos Generic Boards (for mobile devices)"
+	select ARM64
+	select BOARD_EARLY_INIT_F
+	select CLK_EXYNOS
+	select LINUX_KERNEL_IMAGE_HEADER
+	select OF_CONTROL
+
 config SYS_SOC
 	default "exynos"
 
@@ -277,5 +285,6 @@ source "board/samsung/smdk5420/Kconfig"
 source "board/samsung/espresso7420/Kconfig"
 source "board/samsung/axy17lte/Kconfig"
 source "board/samsung/e850-96/Kconfig"
+source "board/samsung/exynos-mobile/Kconfig"
 
 endif
diff --git a/board/samsung/exynos-mobile/Kconfig b/board/samsung/exynos-mobile/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..ed7d16b8c6b718e1a0c2bcb24113b62135ec397c
--- /dev/null
+++ b/board/samsung/exynos-mobile/Kconfig
@@ -0,0 +1,18 @@
+if TARGET_EXYNOS_MOBILE
+
+config ENV_SOURCE_FILE
+	default "exynos-mobile"
+
+config LNX_KRNL_IMG_TEXT_OFFSET_BASE
+	default TEXT_BASE
+
+config SYS_BOARD
+	default "exynos-mobile"
+
+config SYS_CONFIG_NAME
+	default "exynos-mobile"
+
+config SYS_VENDOR
+	default "samsung"
+
+endif # TARGET_EXYNOS_MOBILE
diff --git a/board/samsung/exynos-mobile/MAINTAINERS b/board/samsung/exynos-mobile/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..11fea212fb15bb5714ad1de46aace231f0600b69
--- /dev/null
+++ b/board/samsung/exynos-mobile/MAINTAINERS
@@ -0,0 +1,6 @@
+Exynos Generic Boards (for mobile devices)
+M:	Kaustabh Chakraborty <kauschluss@disroot.org>
+S:	Maintained
+F:	board/samsung/exynos-mobile/
+F:	configs/exynos-mobile_defconfig
+F:	include/configs/exynos-mobile.h
diff --git a/board/samsung/exynos-mobile/Makefile b/board/samsung/exynos-mobile/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..e049ed217c18c7e2c173249608a8abc433299687
--- /dev/null
+++ b/board/samsung/exynos-mobile/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+
+obj-y := exynos-mobile.o
diff --git a/board/samsung/exynos-mobile/debug-exynos7870.config b/board/samsung/exynos-mobile/debug-exynos7870.config
new file mode 100644
index 0000000000000000000000000000000000000000..1aa506a675d30b025651dd4575aee36de82b8d07
--- /dev/null
+++ b/board/samsung/exynos-mobile/debug-exynos7870.config
@@ -0,0 +1,7 @@
+CONFIG_DEBUG_UART=y
+CONFIG_DEBUG_UART_BASE=0x13820000
+CONFIG_DEBUG_UART_CLOCK=133250000
+CONFIG_DEBUG_UART_S5P=y
+CONFIG_LOG=y
+CONFIG_LOG_CONSOLE=y
+CONFIG_LOG_MAX_LEVEL=8
diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
new file mode 100644
index 0000000000000000000000000000000000000000..96316b1bfc90ae40c89585901b57318bfae9fe36
--- /dev/null
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -0,0 +1,372 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung Exynos Generic Board Source (for mobile devices)
+ *
+ * Copyright (c) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#include <asm/armv8/mmu.h>
+#include <blk.h>
+#include <bootflow.h>
+#include <ctype.h>
+#include <dm/ofnode.h>
+#include <env.h>
+#include <errno.h>
+#include <init.h>
+#include <limits.h>
+#include <linux/sizes.h>
+#include <lmb.h>
+#include <part.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define lmb_alloc(size, addr) \
+	lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
+
+struct exynos_board_info {
+	const char *name;
+	const char *chip;
+	const u64 *dram_bank_bases;
+
+	const char *match_model;
+	const u8 match_max_rev;
+};
+
+/*
+ * The memory mapping includes all DRAM banks, along with the
+ * peripheral block, and a sentinel at the end. This is filled in
+ * dynamically.
+ */
+static struct mm_region exynos_mem_map[CONFIG_NR_DRAM_BANKS + 2] = {
+	{
+		/* Peripheral MMIO block */
+		.virt = 0x10000000UL,
+		.phys = 0x10000000UL,
+		.size = 0x10000000UL,
+		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
+			 PTE_BLOCK_NON_SHARE | PTE_BLOCK_PXN | PTE_BLOCK_UXN,
+	},
+};
+
+struct mm_region *mem_map = exynos_mem_map;
+
+const u64 exynos7870_common_dram_bank_bases[CONFIG_NR_DRAM_BANKS] = {
+	0x40000000, 0x80000000, 0x100000000,
+};
+
+/*
+ * This array is used for matching the models and revisions with the
+ * devicetree used by U-Boot. This allows a single U-Boot to work on
+ * multiple devices.
+ *
+ * Entries are kept in lexicographical order of board SoCs, followed by
+ * board names.
+ */
+const struct exynos_board_info exynos_board_info_match[] = {
+	{
+		/* Samsung Galaxy A2 Core */
+		.name = "a2corelte",
+		.chip = "exynos7870",
+		.dram_bank_bases = exynos7870_common_dram_bank_bases,
+		.match_model = "A260",
+		.match_max_rev = U8_MAX,
+	}, {
+		/* Samsung Galaxy J6 */
+		.name = "j6lte",
+		.chip = "exynos7870",
+		.dram_bank_bases = exynos7870_common_dram_bank_bases,
+		.match_model = "J600",
+		.match_max_rev = U8_MAX,
+	}, {
+		/* Samsung Galaxy J7 Prime */
+		.name = "on7xelte",
+		.chip = "exynos7870",
+		.dram_bank_bases = exynos7870_common_dram_bank_bases,
+		.match_model = "G610",
+		.match_max_rev = U8_MAX,
+	},
+};
+
+static const char *exynos_prev_bl_get_bootargs(void)
+{
+	void *prev_bl_fdt_base = (void *)get_prev_bl_fdt_addr();
+	int chosen_node_offset, ret;
+	const struct fdt_property *bootargs_prop;
+
+	ret = fdt_path_offset(prev_bl_fdt_base, "/chosen");
+	chosen_node_offset = ret;
+	if (ret < 0) {
+		log_err("%s: /chosen node not found (FDT_ERR %d)\n", __func__,
+			ret);
+		return NULL;
+	}
+
+	bootargs_prop = fdt_get_property(prev_bl_fdt_base, chosen_node_offset,
+					 "bootargs", &ret);
+	if (!bootargs_prop) {
+		log_err("%s: /chosen/bootargs property not found (FDT_ERR %d)\n",
+			__func__, ret);
+		return NULL;
+	}
+
+	return bootargs_prop->data;
+}
+
+static void exynos_parse_dram_banks(const struct exynos_board_info *board_info,
+				    const void *fdt_base)
+{
+	u64 mem_addr, mem_size = 0;
+	u32 na, ns, i, j;
+	int offset;
+
+	/* #address-cells and #size-cells as defined in the fdt root. */
+	na = fdt_address_cells(fdt_base, 0);
+	ns = fdt_size_cells(fdt_base, 0);
+
+	fdt_for_each_subnode(offset, fdt_base, 0) {
+		if (strncmp(fdt_get_name(fdt_base, offset, NULL), "memory", 6))
+			continue;
+
+		for (i = 0; ; i++) {
+			mem_addr = fdtdec_get_addr_size_fixed(fdt_base, offset,
+							      "reg", i, na, ns,
+							      &mem_size, false);
+			if (mem_addr == FDT_ADDR_T_NONE)
+				break;
+
+			if (!mem_size)
+				continue;
+
+			for (j = 0; j < CONFIG_NR_DRAM_BANKS; j++) {
+				if (board_info->dram_bank_bases[j] != mem_addr)
+					continue;
+
+				mem_map[j + 1].phys = mem_addr;
+				mem_map[j + 1].virt = mem_addr;
+				mem_map[j + 1].size = mem_size;
+				mem_map[j + 1].attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
+						       PTE_BLOCK_INNER_SHARE;
+				break;
+			}
+		}
+	}
+}
+
+static int exynos_fastboot_setup(void)
+{
+	struct blk_desc *blk_dev;
+	struct disk_partition info = {0};
+	char buf[128];
+	phys_addr_t addr;
+	int offset, i, j;
+
+	/* Allocate and define buffer address for fastboot interface. */
+	if (lmb_alloc(CONFIG_FASTBOOT_BUF_SIZE, &addr)) {
+		log_err("%s: failed to allocate fastboot buffer\n", __func__);
+		return -ENOMEM;
+	}
+	env_set_hex("fastboot_addr_r", addr);
+
+	blk_dev = blk_get_dev("mmc", CONFIG_FASTBOOT_FLASH_MMC_DEV);
+	if (!blk_dev) {
+		log_err("%s: required mmc device not available\n", __func__);
+		return -ENODEV;
+	}
+
+	strcpy(buf, "fastboot_partition_alias_");
+	offset = strlen(buf);
+
+	for (i = 1; i < CONFIG_EFI_PARTITION_ENTRIES_NUMBERS; i++) {
+		if (part_get_info(blk_dev, i, &info))
+			continue;
+
+		/*
+		 * The partition name must be lowercase (stored in buf[]),
+		 * as is expected in all fastboot partitions ...
+		 */
+		strlcpy(buf + offset, info.name, sizeof(buf) - offset);
+		for (j = offset; buf[j]; j++)
+			buf[j] = tolower(buf[j]);
+		if (!strcmp(buf + offset, info.name))
+			continue;
+		/*
+		 * ... However, if that isn't the case, a fastboot
+		 * partition alias must be defined to establish it.
+		 */
+		env_set(buf, info.name);
+	}
+
+	return 0;
+}
+
+int board_fit_config_name_match(const char *name)
+{
+	const struct exynos_board_info *board_info;
+	const char *prev_bl_bootargs;
+	char buf[128];
+	int val, ret;
+	unsigned int i;
+
+	/*
+	 * Iterate over exynos_board_info_match[] to select the
+	 * appropriate board info struct. If not found, exit.
+	 */
+	for (i = 0; i < ARRAY_SIZE(exynos_board_info_match); i++) {
+		board_info = exynos_board_info_match + i;
+		snprintf(buf, sizeof(buf), "%s-%s", board_info->chip,
+			 board_info->name);
+
+		if (!strcmp(name, buf))
+			break;
+	}
+	if (i == ARRAY_SIZE(exynos_board_info_match))
+		return -1;
+
+	prev_bl_bootargs = exynos_prev_bl_get_bootargs();
+	if (!prev_bl_bootargs)
+		return -1;
+
+	/*
+	 * Read the cmdline property which stores the
+	 * bootloader/firmware version. An example value of the option
+	 * can be: "J600GDXU3ARH5". This can be used to verify the model
+	 * of the device.
+	 */
+	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.bootloader", &val);
+	if (ret < 0) {
+		log_err("%s: unable to find property for bootloader version (%d)\n",
+			__func__, ret);
+		return -1;
+	}
+
+	if (strncmp(prev_bl_bootargs + val, board_info->match_model,
+		    strlen(board_info->match_model)))
+		return -1;
+
+	/*
+	 * Read the cmdline property which stores the hardware revision.
+	 * This is required to allow selecting one of multiple dtbs
+	 * available of a single device, varying in hardware changes in
+	 * different revisions.
+	 */
+	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.revision", &val);
+	if (ret < 0)
+		ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.hw_rev", &val);
+	if (ret < 0) {
+		log_err("%s: unable to find property for bootloader revision (%d)\n",
+			__func__, ret);
+		return -1;
+	}
+
+	if (strtoul(prev_bl_bootargs + val, NULL, 10) > board_info->match_max_rev)
+		return -1;
+
+	/*
+	 * Store the correct board info struct in gd->board_type to
+	 * allow other functions to access it.
+	 */
+	gd->board_type = (ulong)board_info;
+	log_debug("%s: device detected: %s\n", __func__, name);
+
+	return 0;
+}
+
+int timer_init(void)
+{
+	ofnode timer_node;
+
+	/*
+	 * In a lot of Exynos devices, the previous bootloader does not
+	 * set CNTFRQ_EL0 properly. However, the timer node in
+	 * devicetree has the correct frequency, use that instead.
+	 */
+	timer_node = ofnode_by_compatible(ofnode_null(), "arm,armv8-timer");
+	gd->arch.timer_rate_hz = ofnode_read_u32_default(timer_node,
+							 "clock-frequency", 0);
+
+	return 0;
+}
+
+int board_early_init_f(void)
+{
+	const struct exynos_board_info *board_info;
+
+	if (!gd->board_type)
+		return -ENODATA;
+	board_info = (const struct exynos_board_info *)gd->board_type;
+
+	exynos_parse_dram_banks(board_info, gd->fdt_blob);
+	/*
+	 * Some devices have multiple variants based on the amount of
+	 * memory and internal storage. The lowest bank base has been
+	 * observed to have the same memory range in all board variants.
+	 * For variants with more memory, the previous bootloader should
+	 * overlay the devicetree with the required extra memory ranges.
+	 */
+	exynos_parse_dram_banks(board_info, (const void *)get_prev_bl_fdt_addr());
+
+	return 0;
+}
+
+int dram_init(void)
+{
+	unsigned int i;
+
+	/* Select the largest RAM bank for U-Boot. */
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		if (gd->ram_size < mem_map[i + 1].size) {
+			gd->ram_base = mem_map[i + 1].phys;
+			gd->ram_size = mem_map[i + 1].size;
+		}
+	}
+
+	return 0;
+}
+
+int dram_init_banksize(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < CONFIG_NR_DRAM_BANKS; i++) {
+		gd->bd->bi_dram[i].start = mem_map[i + 1].phys;
+		gd->bd->bi_dram[i].size = mem_map[i + 1].size;
+	}
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int misc_init_r(void)
+{
+	const struct exynos_board_info *board_info;
+	const char *prev_bl_bootargs = exynos_prev_bl_get_bootargs();
+	char buf[128];
+	int val, ret;
+
+	if (!gd->board_type)
+		return -ENODATA;
+	board_info = (const struct exynos_board_info *)gd->board_type;
+
+	if (!prev_bl_bootargs)
+		return -ENODATA;
+
+	env_set("platform", board_info->chip);
+	env_set("board", board_info->name);
+
+	ret = cmdline_get_arg(prev_bl_bootargs, "androidboot.serialno", &val);
+	if (ret > 0) {
+		snprintf(buf, ret, "%s", prev_bl_bootargs + val);
+		env_set("serial#", buf);
+	}
+
+	/* EFI booting requires the path to correct dtb, specify it here. */
+	snprintf(buf, sizeof(buf), "exynos/%s-%s.dtb", board_info->chip,
+		 board_info->name);
+	env_set("fdtfile", buf);
+
+	return exynos_fastboot_setup();
+}
diff --git a/board/samsung/exynos-mobile/exynos-mobile.env b/board/samsung/exynos-mobile/exynos-mobile.env
new file mode 100644
index 0000000000000000000000000000000000000000..aa2e89afbacadcc86d0f1f5539f06bdb28bdc3b3
--- /dev/null
+++ b/board/samsung/exynos-mobile/exynos-mobile.env
@@ -0,0 +1,18 @@
+stdin=serial,button-kbd
+stdout=serial,vidconsole
+stderr=serial,vidconsole
+
+bootdelay=0
+bootcmd=bootefi bootmgr; pause; bootmenu
+
+fastbootcmd=echo "Fastboot Mode";
+	fastboot -l $fastboot_addr_r usb 0
+
+bootmenu_0=Continue Boot=boot
+bootmenu_1=Enter Fastboot Mode=run fastbootcmd
+bootmenu_2=UEFI Maintenance Menu=eficonfig
+bootmenu_3=Reboot=reset
+bootmenu_4=Power Off=poweroff
+
+button_cmd_0_name=Volume Down Key
+button_cmd_0=bootmenu
diff --git a/configs/exynos-mobile_defconfig b/configs/exynos-mobile_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..33fc2f2bf094017bba38579d47430ab68d5c6eaa
--- /dev/null
+++ b/configs/exynos-mobile_defconfig
@@ -0,0 +1,71 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=26000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_EXYNOS=y
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x16000
+CONFIG_TARGET_EXYNOS_MOBILE=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_DEFAULT_DEVICE_TREE="exynos/exynos7870-a2corelte"
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x80000000
+# CONFIG_PSCI_RESET is not set
+CONFIG_BUTTON_CMD=y
+CONFIG_SAVE_PREV_BL_FDT_ADDR=y
+CONFIG_SAVE_PREV_BL_INITRAMFS_START_ADDR=y
+CONFIG_SYS_PBSIZE=1024
+CONFIG_BOARD_TYPES=y
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_MISC_INIT_R=y
+CONFIG_HUSH_PARSER=y
+CONFIG_CMD_BOOTMENU=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_EFI_PARTITION=y
+CONFIG_OF_UPSTREAM=y
+CONFIG_OF_LIST="exynos/exynos7870-a2corelte exynos/exynos7870-j6lte exynos/exynos7870-on7xelte"
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_REMAP_PHONE_KEYS=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
+CONFIG_CLK_EXYNOS7870=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdead0000
+CONFIG_FASTBOOT_FLASH=y
+CONFIG_FASTBOOT_FLASH_MMC_DEV=0
+CONFIG_SYS_I2C_S3C24X0=y
+CONFIG_BUTTON_KEYBOARD=y
+CONFIG_MISC=y
+CONFIG_MMC_BROKEN_CD=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_MMC_DW=y
+CONFIG_PHY=y
+CONFIG_PHY_EXYNOS_USBDRD=y
+CONFIG_PINCTRL=y
+CONFIG_PINCTRL_EXYNOS78x0=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_S2MPS11=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_S2MPS11=y
+CONFIG_SOC_SAMSUNG=y
+CONFIG_EXYNOS_PMU=y
+CONFIG_SYSRESET=y
+CONFIG_SYSRESET_CMD_POWEROFF=y
+CONFIG_SYSRESET_SYSCON=y
+CONFIG_USB=y
+CONFIG_DM_USB_GADGET=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_MANUFACTURER="Samsung"
+CONFIG_USB_GADGET_VENDOR_NUM=0x04e8
+CONFIG_USB_GADGET_PRODUCT_NUM=0x6602
+CONFIG_VIDEO=y
+CONFIG_VIDEO_SIMPLE=y
+CONFIG_FS_EXT4=y
+CONFIG_FS_FAT=y
diff --git a/doc/board/samsung/exynos-mobile.rst b/doc/board/samsung/exynos-mobile.rst
new file mode 100644
index 0000000000000000000000000000000000000000..6390c66ffc38a41f01cb51c7406397cfc5a3d223
--- /dev/null
+++ b/doc/board/samsung/exynos-mobile.rst
@@ -0,0 +1,112 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Kaustabh Chakraborty <kauschluss@disroot.org>
+
+Samsung Exynos Generic Boards (for mobile devices)
+==================================================
+
+Overview
+--------
+This document describes how to build and run U-Boot for Samsung Exynos generic
+boards. Boards are expected to boot with a primary bootloader, such as S-BOOT or
+S-LK, which hands off control to U-Boot, disguised as an Android boot image.
+
+U-Boot is packed with multiple FDTs since it targets multiple boards. The
+appropriate FDT is selected during boot. Additionally, a DTB is also required
+for embedding in the Android boot image. The previous bootloader can apply
+useful overlays on it. Both DTBs are consulted for figuring out the memory
+layout.
+
+Installation
+------------
+Building
+^^^^^^^^
+To buiid U-Boot, run the following commands
+
+.. prompt:: bash $
+
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output exynos-mobile_defconfig
+	make CROSS_COMPILE=aarch64-linux-gnu- O=.output -j$(nproc)
+
+If succcessful, the U-Boot binary will be present in ``.output/u-boot.bin``.
+
+Preparation
+^^^^^^^^^^^
+The U-Boot binary is not flashable as-is, it needs to be encapsulated in an
+Android boot image. Since it supports multiple boards, and devices have
+different requirements (thanks to the lack of standards), this step varies
+depending on your target.
+
+Exynos 7870 Boards
+""""""""""""""""""
+Create the following devicetree (named ``stub.dts``)
+
+.. code-block:: devicetree
+
+	/dts-v1/;
+
+	/ {
+		compatible = "samsung,exynos7870";
+		#address-cells = <2>;
+		#size-cells = <1>;
+
+		model_info-chip = <7870>;
+		model_info-hw_rev = <0>;
+		model_info-hw_rev_end = <255>;
+
+		chosen {
+		};
+
+		memory@80000000 {
+			device_type = "memory";
+			reg = <0x0 0x80000000 0x0>;
+		};
+
+		memory@100000000 {
+			device_type = "memory";
+			reg = <0x1 0x00000000 0x0>;
+		};
+	};
+
+The chosen node and memory ranges are populated by S-BOOT.
+
+Compile it to a devicetree blob, then use ``dtbTool-exynos`` in order to pack it
+in the QCDT format [1]_, using the following commands:
+
+.. prompt:: bash $
+
+	dtc -I dts -O dtb -o stub.dtb stub.dts
+	dtbTool-exynos -o stub.dt.img stub.dtb
+
+Finally, use mkbootimg by osm0sis [2]_ to generate the boot image:
+
+.. prompt:: bash $
+
+	mkbootimg -o u-boot.img \
+		--kernel	.output/u-boot.bin \
+		--dt		stub.dt.img
+
+Offsets are not provided to ``mkbootimg`` as S-BOOT ignores them.
+
+Flashing
+^^^^^^^^
+If flashing for the first time, it must be done via Samsung's Download (Odin)
+mode. Heimdall can be used for flashing, like so:
+
+.. prompt:: bash $
+
+	heimdall flash --BOOT u-boot.img
+
+However, if U-Boot is already installed, you may also use its fastboot interface
+for flashing. Boot into the boot menu by holding the volume down key. Enable
+fastboot mode from there, connect the device to your host, then run:
+
+.. prompt:: bash $
+
+	fastboot flash boot u-boot.img
+
+To flash an OS image in internal storage, fastboot is a reliable option.
+
+References
+----------
+.. [1] https://wiki.postmarketos.org/wiki/QCDT
+.. [2] https://github.com/osm0sis/mkbootimg
diff --git a/doc/board/samsung/index.rst b/doc/board/samsung/index.rst
index 1b92c9518a57df102c2b64ff934b460548ce3d53..1fbe88130c049e1a33d22ae9230fb60ddccea131 100644
--- a/doc/board/samsung/index.rst
+++ b/doc/board/samsung/index.rst
@@ -8,4 +8,5 @@ Samsung
 
    axy17lte
    e850-96
+   exynos-mobile
    n1
diff --git a/include/configs/exynos-mobile.h b/include/configs/exynos-mobile.h
new file mode 100644
index 0000000000000000000000000000000000000000..862db5779ef4c9ff7f53bef78d7cee5107b7226e
--- /dev/null
+++ b/include/configs/exynos-mobile.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Samsung Exynos Generic Board Configuration (for mobile devices)
+ *
+ * Copyright (C) 2025 Kaustabh Chakraborty <kauschluss@disroot.org>
+ */
+
+#ifndef __CONFIG_EXYNOS_MOBILE_H
+#define __CONFIG_EXYNOS_MOBILE_H
+
+#define CPU_RELEASE_ADDR	secondary_boot_addr
+#define CFG_SYS_BAUDRATE_TABLE	{9600, 115200}
+
+#endif /* __CONFIG_EXYNOS_MOBILE_H */

---
base-commit: 582a04763aa80738c1c8ac60c47d1a5159a42833
change-id: 20251017-board-exynos-mobile-7c7d43832693

Best regards,
-- 
Kaustabh Chakraborty <kauschluss@disroot.org>

