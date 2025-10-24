Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0825CCF9E0
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:38:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 34265838A5;
	Fri, 24 Oct 2025 19:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="je7e803K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1573F83835; Fri, 24 Oct 2025 19:29:17 +0200 (CEST)
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C905283677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:29:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kauschluss@disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id 8E57525C66;
 Fri, 24 Oct 2025 19:29:14 +0200 (CEST)
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UGWdnPGHrgD4; Fri, 24 Oct 2025 19:29:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1761326953; bh=VSGWn5paNRd34xI7IPyloiyp13qdxbfvpZh+38FEnwY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=je7e803KhD5/GPTQDEX392vF2hUiPAulTewt1nJENuklgQolYmOBdk4K8E/ddq6Oy
 AZZik1BVynx+x7MtKhueLhHs08l92aYe4WHbLRtJymK6TAUEW7+psKir+K9fMia15a
 mduGwaYAXzhyqOROoI4RwuYQG4E+I0pX1E0awMdUzyqyWsMpzVJAsIDwspor/cX/dR
 kpKc7X2I50RbU1/wtwGBKwgVGkcqTbho1sDJXi31VZf51bcOob+AVeGqySPANmuE1x
 OwBEcQQ/Kbf3QiqJiUM7VNEAZz0K7scBa/q3l6BVGIC+a4vw7FTkkDU33q+K+Dv2xx
 s48TcEEwBSbQQ==
From: Kaustabh Chakraborty <kauschluss@disroot.org>
Date: Fri, 24 Oct 2025 22:58:27 +0530
Subject: [PATCH v2 1/3] board: samsung: add support for Samsung Exynos
 mobile device boards
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-board-exynos-mobile-v2-1-e6fce69e60c3@disroot.org>
References: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
In-Reply-To: <20251024-board-exynos-mobile-v2-0-e6fce69e60c3@disroot.org>
To: u-boot@lists.denx.de
Cc: Minkyu Kang <mk7.kang@samsung.com>, Tom Rini <trini@konsulko.com>, 
 Peter Robinson <pbrobinson@gmail.com>, Henrik Grimler <henrik@grimler.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Ion Agorria <ion@agorria.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761326916; l=17186;
 i=kauschluss@disroot.org; s=20250202; h=from:subject:message-id;
 bh=VSGWn5paNRd34xI7IPyloiyp13qdxbfvpZh+38FEnwY=;
 b=ibaKQhpAId8gQ/N5tevWS7uUXLG9Hcn+/2Roirw/VWV3kEIHAl51J+fSw5ghE4Q/DRbfP80Vv
 SgsyWia1dc6CRsLXDZJwQToTvMcTe7eNo7mcB/0gp4YDynac4NMm5Tj
X-Developer-Key: i=kauschluss@disroot.org; a=ed25519;
 pk=h2xeR+V2I1+GrfDPAhZa3M+NWA0Cnbdkkq1bH3ct1hE=
X-Mailman-Approved-At: Fri, 24 Oct 2025 19:37:56 +0200
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
boards powered by ARMv8 Samsung Exynos SoCs. Some important features
include:
 * Fastboot: This is present to provide an open alternative to Samsung's
   proprietary Odin protocol. The board file configures certain features
   for fastboot, such as a dynamically allocated fastboot buffer, and
   standardized (lowercase) partition aliases.
 * EFI: Kernel image can be loaded from an EFI partition. This
   adopts a standard booting process, which multiple OS distributions
   can rely on.

Signed-off-by: Kaustabh Chakraborty <kauschluss@disroot.org>
---
 arch/arm/mach-exynos/Kconfig                  |  11 +-
 board/samsung/exynos-mobile/Kconfig           |  18 ++
 board/samsung/exynos-mobile/MAINTAINERS       |   6 +
 board/samsung/exynos-mobile/Makefile          |   5 +
 board/samsung/exynos-mobile/exynos-mobile.c   | 287 ++++++++++++++++++++++++++
 board/samsung/exynos-mobile/exynos-mobile.env |  18 ++
 configs/exynos-mobile_defconfig               |  68 ++++++
 doc/board/samsung/exynos-mobile.rst           |  40 ++++
 doc/board/samsung/index.rst                   |   1 +
 include/configs/exynos-mobile.h               |  14 ++
 10 files changed, 467 insertions(+), 1 deletion(-)

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
diff --git a/board/samsung/exynos-mobile/exynos-mobile.c b/board/samsung/exynos-mobile/exynos-mobile.c
new file mode 100644
index 0000000000000000000000000000000000000000..c16281dbc36fb07cf5e9f64604632bb98393cd86
--- /dev/null
+++ b/board/samsung/exynos-mobile/exynos-mobile.c
@@ -0,0 +1,287 @@
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
+#include <linux/sizes.h>
+#include <lmb.h>
+#include <part.h>
+#include <stdbool.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+#define lmb_alloc(size, addr) \
+	lmb_alloc_mem(LMB_MEM_ALLOC_ANY, SZ_2M, addr, size, LMB_NONE)
+
+struct exynos_board_info {
+	const char *name;
+	const char *chip;
+	const u64 *const dram_bank_bases;
+
+	char serial[64];
+
+	int (*const match)(struct exynos_board_info *);
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
+/*
+ * This array is used for matching the models and revisions with the
+ * devicetree used by U-Boot. This allows a single U-Boot to work on
+ * multiple devices.
+ *
+ * Entries are kept in lexicographical order of board SoCs, followed by
+ * board names.
+ */
+static struct exynos_board_info exynos_board_info_match[] = {
+};
+
+static void exynos_parse_dram_banks(const struct exynos_board_info *board_info,
+				    const void *fdt_base)
+{
+	u64 mem_addr, mem_size = 0;
+	u32 na, ns, i, j;
+	int offset;
+
+	if (fdt_check_header(fdt_base) < 0)
+		return;
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
+	struct exynos_board_info *board_info;
+	char buf[128];
+	unsigned int i;
+	int ret;
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
+	/*
+	 * Execute match logic for the target board. This is separated
+	 * as the process may be different for multiple boards.
+	 */
+	ret = board_info->match(board_info);
+	if (ret)
+		return ret;
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
+	char buf[128];
+
+	if (!gd->board_type)
+		return -ENODATA;
+	board_info = (const struct exynos_board_info *)gd->board_type;
+
+	env_set("platform", board_info->chip);
+	env_set("board", board_info->name);
+
+	if (strlen(board_info->serial))
+		env_set("serial#", board_info->serial);
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
index 0000000000000000000000000000000000000000..2dbf90010bac8182ea202a484252a5b527eb6ad9
--- /dev/null
+++ b/configs/exynos-mobile_defconfig
@@ -0,0 +1,68 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=26000000
+CONFIG_POSITION_INDEPENDENT=y
+CONFIG_ARCH_EXYNOS=y
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x16000
+CONFIG_TARGET_EXYNOS_MOBILE=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_SYS_BOOTM_LEN=0x2000000
+CONFIG_SYS_LOAD_ADDR=0x80000000
+CONFIG_ARMV8_CNTFRQ_BROKEN=y
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
+CONFIG_MULTI_DTB_FIT=y
+CONFIG_BUTTON=y
+CONFIG_BUTTON_REMAP_PHONE_KEYS=y
+CONFIG_CLK=y
+CONFIG_CLK_CCF=y
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
index 0000000000000000000000000000000000000000..d5c1c83a4e84ac0fc9401b02de0ec786c9397892
--- /dev/null
+++ b/doc/board/samsung/exynos-mobile.rst
@@ -0,0 +1,40 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Kaustabh Chakraborty <kauschluss@disroot.org>
+
+Samsung Exynos Generic ARMv8 Boards (for mobile devices)
+=======================================================
+
+Overview
+--------
+This document describes how to build and run U-Boot for Samsung Exynos generic
+boards. Boards are expected to boot with a primary bootloader, such as S-BOOT or
+S-LK, which hands off control to U-Boot. Presently, only ARMv8 devices are
+supported.
+
+The U-Boot image is built with all device tree blobs packed in a single FIT
+image. During boot, it uses simple heuristics to detect the target board, and
+subsequently the appropriate FDT is selected.
+
+Installation
+------------
+Building
+^^^^^^^^
+If a cross-compiler is required, install it and set it up like so:
+
+.. prompt:: bash $
+
+	export CROSS_COMPILE=aarch64-linux-gnu-
+
+Then, run the following commands to build U-Boot:
+
+.. prompt:: bash $
+
+	make O=.output exynos-mobile_defconfig
+	make O=.output -j$(nproc)
+
+If successful, the U-Boot binary will be present in ``.output/u-boot.bin``.
+
+Preparation and Flashing
+^^^^^^^^^^^^^^^^^^^^^^^^
+Since U-Boot supports multiple boards, and devices have different requirements,
+this step will vary depending on your target.
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

-- 
2.51.0

