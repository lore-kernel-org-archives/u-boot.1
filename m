Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25A80C4829A
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 04:22:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3C3198783B;
	Mon,  5 Feb 2024 05:22:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ENUH8W4R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A00578798C; Mon,  5 Feb 2024 04:47:25 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C65F387A0B
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 04:47:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wan.yee.lau@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1707104844; x=1738640844;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=R1PL9QtzAktF/HCD0GiUnUKHhUiN162YtgbDzimoHm4=;
 b=ENUH8W4RZFryYENMHiek5hL5vU/dIjkahb86OgaVE+AE8yB/l3E1Xc8Z
 ZPI4WAGzFlxZQ/wQJfK+qBkMqVRn6TYxHgAi5oWqpU+tzwXanspG6SRCE
 f140ff3G4LeGXsbhC7WwcHBTsDLCm/Fyqa6ky07Exv9yrY22WDNXevBhM
 zRfikaazpV7b9Rvkvvix73+b+t3qQgkew3VK1OPmo2R1pEO/dKduGN/DR
 EoVAhVhW2e0szL2QesIaU33OcCVsxYt+DgA/Echr2OA8V5kuz1SUFyP0a
 BkH7CHobbzCuSS7xJ09gQa3AchfY6b9h7DKgl/8JQDnapBY0lpZZoqW6Z A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="337840"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="337840"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Feb 2024 19:47:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; d="scan'208";a="31405175"
Received: from pgli0078.png.intel.com ([10.221.240.41])
 by orviesa002.jf.intel.com with ESMTP; 04 Feb 2024 19:47:19 -0800
From: wan.yee.lau@intel.com
To: u-boot@lists.denx.de
Cc: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>
Subject: [PATCH v2 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Date: Mon,  5 Feb 2024 11:47:16 +0800
Message-Id: <20240205034716.10812-1-wan.yee.lau@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 05 Feb 2024 05:22:14 +0100
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

From: Wan Yee Lau <wan.yee.lau@intel.com>

Add socfpga_dtreg driver enablement for Intel SoCFPGA.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
---
Changes for v2:
- Rearranged header file in socfpga_drteg.c, moved <asm/io.h> lower.

 arch/arm/Kconfig                              |   2 +
 .../misc/socfpga_dtreg.txt                    |  74 +++++++++++
 drivers/misc/Kconfig                          |   7 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/socfpga_dtreg.c                  | 117 ++++++++++++++++++
 5 files changed, 201 insertions(+)
 create mode 100644 doc/device-tree-bindings/misc/socfpga_dtreg.txt
 create mode 100644 drivers/misc/socfpga_dtreg.c

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 531b081de9..6087345eb8 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1092,6 +1092,8 @@ config ARCH_SOCFPGA
 	select SPL_LIBGENERIC_SUPPORT
 	select SPL_OF_CONTROL
 	select SPL_SEPARATE_BSS if TARGET_SOCFPGA_SOC64
+	select SPL_DRIVERS_MISC if TARGET_SOCFPGA_SOC64
+	select SPL_SOCFPGA_DT_REG if TARGET_SOCFPGA_SOC64
 	select SPL_SERIAL
 	select SPL_SYSRESET
 	select SPL_WATCHDOG
diff --git a/doc/device-tree-bindings/misc/socfpga_dtreg.txt b/doc/device-tree-bindings/misc/socfpga_dtreg.txt
new file mode 100644
index 0000000000..6057f792b9
--- /dev/null
+++ b/doc/device-tree-bindings/misc/socfpga_dtreg.txt
@@ -0,0 +1,74 @@
+* Firewall and privilege register settings in device tree
+
+Required properties:
+--------------------
+
+- compatible: should contain "intel,socfpga-dtreg"
+- reg: Physical base address and size of block register.
+- intel,offset-settings: 32-bit offset address of block register,
+			 followed by 32-bit value settings and
+			 the masking bits, only masking bit
+			 set to 1 allows modification.
+
+The device tree node which describes secure and privilege register access
+configuration in compile time.
+
+Most of these registers are expected to work except for the case which some
+registers configuration are required for granting access to some other
+registers, for example CCU registers have to be properly configured before
+allowing register configuration access to fpga2sdram firewall as shown in
+below example.
+
+Some registers depend on runtime data for proper configuration are expected
+to be part of driver that generating these data for example configuration for
+soc_noc_fw_ddr_mpu_inst_0_ddr_scr block register depend on DDR size parsed from
+memory device tree node.
+
+Please refer details of tested examples below for both fpga2sdram and QoS
+configuration with default reset value and the comments.
+
+Example:
+--------
+
+Configuration for multiple dtreg node support in device tree:
+
+	socfpga_dtreg0: socfpga-dtreg0 {
+		compatible = "intel,socfpga-dtreg";
+                	#address-cells = <1>;
+                        #size-cells = <1>;
+		        bootph-all;
+
+                        coh_cpu0_bypass_OC_Firewall_main_Firewall@f7100200 {
+                        	reg = <0xf7100200 0x00000014>;
+                                intel,offset-settings =
+                                	/* Disable ocram security at CCU for non secure access */
+                                        <0x0000004 0x8000ffff 0xe007ffff>,
+                                        <0x0000008 0x8000ffff 0xe007ffff>,
+                                        <0x000000c 0x8000ffff 0xe007ffff>,
+                                        <0x0000010 0x8000ffff 0xe007ffff>;
+                                bootph-all;
+                        };
+                };
+
+	socfpga_dtreg1: socfpga-dtreg1 {
+        	compatible = "intel,socfpga-dtreg";
+                	#address-cells = <1>;
+                        #size-cells = <1>;
+			bootph-all;
+
+                        soc_noc_fw_mpfe_csr_inst_0_mpfe_scr@f8020000 {
+                                reg = <0xf8020000 0x0000001c>;
+                                intel,offset-settings =
+                                        /* Disable MPFE firewall for SMMU */
+                                        <0x00000000 0x00010101 0x00010101>,
+                                        /* Disable MPFE firewall for HMC adapter */
+                                        <0x00000004 0x00000001 0x00010101>;
+				bootph-all;
+                        };
+                };
+
+To call the nodes use:
+
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-dtreg0", &dev);
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-dtreg1", &dev);
+
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index fccd9b89b8..c423905ba2 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -683,4 +683,11 @@ config SL28CPLD
 	  the base driver which provides common access methods for the
 	  sub-drivers.

+config SPL_SOCFPGA_DT_REG
+	bool "Enable register setting from device tree in SPL"
+	depends on SPL
+	help
+	  Enable register setting from device tree. This also
+	  provides user a clean interface and all register settings are
+	  centralized in one place, device tree.
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index b67b82358a..b74c8b9f80 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_K3_AVS0) += k3_avs.o
 obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
+obj-$(CONFIG_SPL_SOCFPGA_SEC_REG) += socfpga_dtreg.o
diff --git a/drivers/misc/socfpga_dtreg.c b/drivers/misc/socfpga_dtreg.c
new file mode 100644
index 0000000000..a8554bfd1d
--- /dev/null
+++ b/drivers/misc/socfpga_dtreg.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Intel Corporation <www.intel.com>
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <errno.h>
+#include <asm/io.h>
+#include <linux/sizes.h>
+
+#define NUMBER_OF_ELEMENTS 3
+
+static int socfpga_dtreg_probe(struct udevice *dev)
+{
+	const fdt32_t *list;
+	fdt_addr_t offset, base;
+	fdt_val_t val, read_val, mask, set_mask;
+	int size, i;
+	u32 blk_sz, reg;
+	ofnode node;
+	const char *name = NULL;
+
+	debug("%s(dev=%p)\n", __func__, dev);
+
+	if (!dev_has_ofnode(dev))
+		return 0;
+
+	dev_for_each_subnode(node, dev) {
+		name = ofnode_get_name(node);
+		if (!name)
+			return -EINVAL;
+
+		if (ofnode_read_u32_index(node, "reg", 1, &blk_sz))
+			return -EINVAL;
+
+		base = ofnode_get_addr(node);
+		if (base == FDT_ADDR_T_NONE)
+			return -EINVAL;
+
+		debug("%s(node_offset 0x%lx node_name %s ", __func__,
+		      node.of_offset, name);
+		debug("node addr 0x%llx blk sz 0x%x)\n", base, blk_sz);
+
+		list = ofnode_read_prop(node, "intel,offset-settings", &size);
+		if (!list)
+			return -EINVAL;
+
+		debug("%s(intel,offset-settings property size=%x)\n", __func__,
+		      size);
+		size /= sizeof(*list) * NUMBER_OF_ELEMENTS;
+
+		/*
+		 * First element: offset
+		 * Second element: val
+		 * Third element: mask
+		 */
+		for (i = 0; i < size; i++) {
+			offset = fdt32_to_cpu(*list++);
+			val = fdt32_to_cpu(*list++);
+
+			/* Reads the masking bit value from the list */
+			mask = fdt32_to_cpu(*list++);
+
+			/*
+			 * Reads out the offsets, value and masking bits
+			 * Ex: <0x00000000 0x00000230 0xffffffff>
+			 */
+			debug("%s(intel,offset-settings 0x%llx : 0x%llx : 0x%llx)\n",
+			      __func__, offset, val, mask);
+
+			if (blk_sz < offset + SZ_4) {
+				printf("%s: Overflow as offset 0x%llx or reg",
+				       __func__, offset);
+				printf(" write is more than block size 0x%x\n",
+				       blk_sz);
+				return -EINVAL;
+			}
+
+			if (mask != 0) {
+				if (mask == 0xffffffff) {
+					reg = base + offset;
+					writel(val, (uintptr_t)reg);
+				} else {
+					/* Mask the value with the masking bits */
+					set_mask = val & mask;
+
+					reg = base + offset;
+
+					/* Clears and sets specific bits in the register */
+					clrsetbits_le32((uintptr_t)reg, mask, set_mask);
+				}
+			}
+
+			read_val = readl((uintptr_t)reg);
+
+			/* Reads out the register, masked value and the read value */
+			debug("%s(reg 0x%x = wr : 0x%llx  rd : 0x%llx)\n",
+			      __func__, reg, set_mask, read_val);
+
+		}
+	}
+
+	return 0;
+};
+
+static const struct udevice_id socfpga_dtreg_ids[] = {
+	{.compatible = "intel,socfpga-dtreg"},
+	{ }
+};
+
+U_BOOT_DRIVER(socfpga_dtreg) = {
+	.name		= "socfpga-dtreg",
+	.id		= UCLASS_NOP,
+	.of_match	= socfpga_dtreg_ids,
+	.probe		= socfpga_dtreg_probe,
+};
--
2.25.1

