Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1EAC4167B
	for <u-boot@archiver.kernel.org>; Fri,  8 Dec 2023 13:20:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4DE6B8754A;
	Fri,  8 Dec 2023 14:20:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EVFfjGpS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6056683414; Fri,  8 Dec 2023 09:37:50 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AF5E8642A
 for <u-boot@lists.denx.de>; Fri,  8 Dec 2023 09:37:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wan.yee.lau@intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702024666; x=1733560666;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=wHI5oNqxECHqe/ym5hpRDPuS35JhBCm02lE70Y58gsU=;
 b=EVFfjGpSuNmXpHWSgfqB2ZzHi1AJNRORpBIoSau5XNCSmJe4FDwZ+1pR
 4Qy9msx4ufUCGgbPP1oSJfOUoXqnRruDUbiT04GwEQKG+mRvHvUPYaq/5
 YrB5S8WdQLVSU+3fQuNs3L/Vz6/rtUtcN5yJln+RLYlZWMtLDOtGMfVdG
 lgHevjscMCRJFSKUy1yX0+uI31PXUTIWg9ZHRMNr0pBT2iDmC1us/B0rx
 PNF8JnDo3+/1A43zXd9+bCE5s2mHfsZIEbcqfWrzM+uXWN7rPRN6NndnW
 w+gi9koiQH8+ZlnIPj+QPIO1x69sPKWkdm1TLfyreVuU9N/d5aA7pne+z A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="460855852"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; d="scan'208";a="460855852"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2023 00:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="945350199"
X-IronPort-AV: E=Sophos;i="6.04,260,1695711600"; d="scan'208";a="945350199"
Received: from pglc00507.png.intel.com ([10.221.239.199])
 by orsmga005.jf.intel.com with ESMTP; 08 Dec 2023 00:37:31 -0800
From: wan.yee.lau@intel.com
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>, Kever Yang <kever.yang@rock-chips.com>,
 Bin Meng <bmeng.cn@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Jean-Marie Lemetayer <j.lemetayer@kerlink.fr>, Peng Fan <peng.fan@nxp.com>,
 Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong <tien.fong.chee@intel.com>, Kok Kiang <kok.kiang.hea@intel.com>,
 Dinesh <dinesh.maniyam@intel.com>, Boon Khai <boon.khai.ng@intel.com>,
 Alif <alif.zakuan.yuslaimi@intel.com>,
 Teik Heng <teik.heng.chong@intel.com>,
 Hazim <muhammad.hazim.izzat.zamri@intel.com>,
 Jit Loon Lim <jit.loon.lim@intel.com>,
 Sieu Mun Tang <sieu.mun.tang@intel.com>
Subject: [PATCH v1 1/1] drivers: misc: Add socfpga_dtreg driver for Intel
 SoCFPGA
Date: Fri,  8 Dec 2023 16:37:26 +0800
Message-Id: <20231208083726.26906-1-wan.yee.lau@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 08 Dec 2023 14:20:38 +0100
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

This driver can be used to provide user a clean interface and all register
settings are centralized in one place, device tree without need for
hardcoding in the source code.

Signed-off-by: Wan Yee Lau <wan.yee.lau@intel.com>
---
 .../misc/socfpga_dtreg.txt                    |  66 ++++++++++
 drivers/misc/Kconfig                          |   7 ++
 drivers/misc/Makefile                         |   1 +
 drivers/misc/socfpga_dtreg.c                  | 117 ++++++++++++++++++
 4 files changed, 191 insertions(+)
 create mode 100644 doc/device-tree-bindings/misc/socfpga_dtreg.txt
 create mode 100644 drivers/misc/socfpga_dtreg.c

diff --git a/doc/device-tree-bindings/misc/socfpga_dtreg.txt b/doc/device-tree-bindings/misc/socfpga_dtreg.txt
new file mode 100644
index 0000000000..5458103f88
--- /dev/null
+++ b/doc/device-tree-bindings/misc/socfpga_dtreg.txt
@@ -0,0 +1,66 @@
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
+This driver can be used to provide user a clean interface and all register
+settings are centralized in one place, device tree without need for
+hardcoding in the source code.
+
+General setup would be to set the memory address used by the register,
+followed by the offset-settings containing the 32-bit offset address
+of the block register, then the 32-bit value settings and
+lastly the masking bits.
+
+Example:
+--------
+
+Configuration for multiple dtreg node support in device tree:
+
+	socfpga_mainfirewall: socfpga-mainfirewall {
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
+	socfpga_mpfefirewall: socfpga-mpfefirewall {
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
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-mainfirewall", &dev);
+	ret = uclass_get_device_by_name(UCLASS_NOP, "socfpga-mpfefirewall", &dev);
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
index b67b82358a..8f813edd84 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -89,3 +89,4 @@ obj-$(CONFIG_K3_AVS0) += k3_avs.o
 obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
+obj-$(CONFIG_SPL_SOCFPGA_DT_REG) += socfpga_dtreg.o
diff --git a/drivers/misc/socfpga_dtreg.c b/drivers/misc/socfpga_dtreg.c
new file mode 100644
index 0000000000..982f9592cb
--- /dev/null
+++ b/drivers/misc/socfpga_dtreg.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Intel Corporation <www.intel.com>
+ */
+
+#include <asm/io.h>
+#include <common.h>
+#include <dm.h>
+#include <errno.h>
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

