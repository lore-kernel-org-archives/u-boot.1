Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01642EE8009
	for <u-boot@archiver.kernel.org>; Fri,  8 Sep 2023 14:03:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C3A86AD8;
	Fri,  8 Sep 2023 16:01:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="RV4FZJrZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 06EDC86A24; Fri,  8 Sep 2023 13:07:15 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6370086410
 for <u-boot@lists.denx.de>; Fri,  8 Sep 2023 13:07:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-nandan@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 388B6uFe092773;
 Fri, 8 Sep 2023 06:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1694171216;
 bh=K6hMe5N8Lb/c3EEo6rc0x27YOx1BexyuTKNyKG56XzA=;
 h=From:To:Subject:Date:In-Reply-To:References;
 b=RV4FZJrZK4djOYsWyXOSmGj2BKCo3Nraz7gJ9h04oSgLBtxkhuWwlGLnVtilAT9Re
 2n9PVnxQl8ZfrLxIrbklqZciq/smm4tM7ueEYXekQeH2/X+sDcXo/3luv/hZo11n9r
 dsJBide113W/AqHugK3+QZXrUW5pW9JBFRWBfn+4=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 388B6tgA075325
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 8 Sep 2023 06:06:56 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 8
 Sep 2023 06:06:55 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 8 Sep 2023 06:06:55 -0500
Received: from TI.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 388B5qEL018063;
 Fri, 8 Sep 2023 06:06:48 -0500
From: Apurva Nandan <a-nandan@ti.com>
To: Apurva Nandan <a-nandan@ti.com>, Hari Nagalla <hnagalla@ti.com>, Lukasz
 Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jaehoon Chung
 <jh80.chung@samsung.com>, Neha Malcom Francis <n-francis@ti.com>,
 Simon Glass <sjg@chromium.org>, Andrew Davis <afd@ti.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>,
 Aradhya Bhatia <a-bhatia1@ti.com>, Bryan Brattlof <bb@ti.com>,
 Christian Gmeiner <christian.gmeiner@gmail.com>, Nishanth Menon
 <nm@ti.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>, Marcel Ziswiler
 <marcel.ziswiler@toradex.com>, Roger Quadros <rogerq@kernel.org>, Jason
 Kacines <j-kacines@ti.com>, Jayesh Choudhary <j-choudhary@ti.com>, Ralph
 Siemsen <ralph.siemsen@linaro.org>, Yanhong Wang
 <yanhong.wang@starfivetech.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, <u-boot@lists.denx.de>
Subject: [PATCH v3 08/16] board: ti: j784s4: Add board support for J784S4 EVM
Date: Fri, 8 Sep 2023 16:35:43 +0530
Message-ID: <20230908110551.861575-9-a-nandan@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908110551.861575-1-a-nandan@ti.com>
References: <20230908110551.861575-1-a-nandan@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Fri, 08 Sep 2023 16:01:41 +0200
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

Add board files for J784S4 EVM.

Signed-off-by: Hari Nagalla <hnagalla@ti.com>
[ add env and board specific yaml files for binman ]
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
[ cleaned up the env files ]
Signed-off-by: Manorit Chawdhry <m-chawdhry@ti.com>
Signed-off-by: Apurva Nandan <a-nandan@ti.com>
---
 arch/arm/mach-k3/Kconfig         |    1 +
 board/ti/j784s4/Kconfig          |   63 +
 board/ti/j784s4/MAINTAINERS      |   20 +
 board/ti/j784s4/Makefile         |    8 +
 board/ti/j784s4/board-cfg.yaml   |   36 +
 board/ti/j784s4/evm.c            |   87 +
 board/ti/j784s4/j784s4.env       |   35 +
 board/ti/j784s4/pm-cfg.yaml      |   12 +
 board/ti/j784s4/rm-cfg.yaml      | 3057 ++++++++++++++++++++++++++++++
 board/ti/j784s4/sec-cfg.yaml     |  379 ++++
 board/ti/j784s4/tifs-rm-cfg.yaml | 2655 ++++++++++++++++++++++++++
 include/configs/j784s4_evm.h     |   20 +
 12 files changed, 6373 insertions(+)
 create mode 100644 board/ti/j784s4/Kconfig
 create mode 100644 board/ti/j784s4/MAINTAINERS
 create mode 100644 board/ti/j784s4/Makefile
 create mode 100644 board/ti/j784s4/board-cfg.yaml
 create mode 100644 board/ti/j784s4/evm.c
 create mode 100644 board/ti/j784s4/j784s4.env
 create mode 100644 board/ti/j784s4/pm-cfg.yaml
 create mode 100644 board/ti/j784s4/rm-cfg.yaml
 create mode 100644 board/ti/j784s4/sec-cfg.yaml
 create mode 100644 board/ti/j784s4/tifs-rm-cfg.yaml
 create mode 100644 include/configs/j784s4_evm.h

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 0af2ec6ddb..ba3dd393e3 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -197,4 +197,5 @@ source "board/ti/j721e/Kconfig"
 source "board/siemens/iot2050/Kconfig"
 source "board/ti/j721s2/Kconfig"
 source "board/toradex/verdin-am62/Kconfig"
+source "board/ti/j784s4/Kconfig"
 endif
diff --git a/board/ti/j784s4/Kconfig b/board/ti/j784s4/Kconfig
new file mode 100644
index 0000000000..7eeb21f451
--- /dev/null
+++ b/board/ti/j784s4/Kconfig
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+#	Hari Nagalla <hnagalla@ti.com>
+
+choice
+	prompt "K3 J784S4 board"
+	optional
+
+config TARGET_J784S4_A72_EVM
+	bool "TI K3 based J784S4 EVM running on A72"
+	select ARM64
+	select SOC_K3_J784S4
+	select BOARD_LATE_INIT
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J784S4_R5_EVM
+	bool "TI K3 based J784S4 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select SOC_K3_J784S4
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
+endchoice
+
+if TARGET_J784S4_A72_EVM
+
+config SYS_BOARD
+       default "j784s4"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j784s4_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_J784S4_R5_EVM
+
+config SYS_BOARD
+       default "j784s4"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j784s4_evm"
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/ti/j784s4/MAINTAINERS b/board/ti/j784s4/MAINTAINERS
new file mode 100644
index 0000000000..7d3549dd31
--- /dev/null
+++ b/board/ti/j784s4/MAINTAINERS
@@ -0,0 +1,20 @@
+J784S4 BOARD
+M:	Hari Nagalla <hnagalla@ti.com>
+S:	Maintained
+F:	board/ti/j784s4
+F:	arch/arm/mach-k3/j784s4
+F:	include/configs/j784s4_evm.h
+F:	configs/j784s4_evm_r5_defconfig
+F:	configs/j784s4_evm_a72_defconfig
+F:	arch/arm/dts/k3-j784s4.dtsi
+F:	arch/arm/dts/k3-j784s4-main.dtsi
+F:	arch/arm/dts/k3-j784s4-mcu-wakeup.dtsi
+F:	arch/arm/dts/k3-j784s4-thermal.dtsi
+F:	arch/arm/dts/k3-j784s4-evm.dts
+F:	arch/arm/dts/k3-j784s4-evm-u-boot.dtsi
+F:	arch/arm/dts/k3-j784s4-r5-evm.dts
+F:	arch/arm/dts/k3-j784s4-ddr.dtsi
+F:	arch/arm/dts/k3-j784s4-ddr-evm-lp4-4266.dtsi
+F:	arch/arm/dts/k3-am69-sk.dts
+F:	arch/arm/dts/k3-am69-sk-u-boot.dtsi
+F:	arch/arm/dts/k3-am69-r5-sk.dts
diff --git a/board/ti/j784s4/Makefile b/board/ti/j784s4/Makefile
new file mode 100644
index 0000000000..fc98b24a2d
--- /dev/null
+++ b/board/ti/j784s4/Makefile
@@ -0,0 +1,8 @@
+#
+# Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+#	Hari Nagalla <hnagalla@ti.com>
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/j784s4/board-cfg.yaml b/board/ti/j784s4/board-cfg.yaml
new file mode 100644
index 0000000000..ea9a8b4a26
--- /dev/null
+++ b/board/ti/j784s4/board-cfg.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for J784S4
+#
+
+---
+
+board-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    control:
+        subhdr:
+            magic: 0xC1D3
+            size: 7
+        main_isolation_enable: 0x5A
+        main_isolation_hostid: 0x2
+    secproxy:
+        subhdr:
+            magic: 0x1207
+            size: 7
+        scaling_factor: 0x1
+        scaling_profile: 0x1
+        disable_main_nav_secure_proxy: 0
+    msmc:
+        subhdr:
+            magic: 0xA5C3
+            size: 5
+        msmc_cache_size: 0x8
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
\ No newline at end of file
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
new file mode 100644
index 0000000000..d6e695f183
--- /dev/null
+++ b/board/ti/j784s4/evm.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for J784S4 EVM
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
+ *
+ */
+
+#include <common.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <generic-phy.h>
+#include <image.h>
+#include <init.h>
+#include <log.h>
+#include <net.h>
+#include <asm/arch/hardware.h>
+#include <asm/gpio.h>
+#include <asm/io.h>
+#include <spl.h>
+#include <dm.h>
+#include <dm/uclass-internal.h>
+
+#include "../common/board_detect.h"
+
+#define board_is_j784s4_evm()	board_ti_k3_is("J784S4-EVM")
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+#ifdef CONFIG_PHYS_64BIT
+	gd->ram_size = 0x100000000;
+#else
+	gd->ram_size = 0x80000000;
+#endif
+
+	return 0;
+}
+
+phys_size_t board_get_usable_ram_top(phys_size_t total_size)
+{
+#ifdef CONFIG_PHYS_64BIT
+	/* Limit RAM used by U-Boot to the DDR low region */
+	if (gd->ram_top > 0x100000000)
+		return 0x100000000;
+#endif
+
+	return gd->ram_top;
+}
+
+int dram_init_banksize(void)
+{
+	/* Bank 0 declares the memory available in the DDR low region */
+	gd->bd->bi_dram[0].start = CFG_SYS_SDRAM_BASE;
+	gd->bd->bi_dram[0].size = 0x7fffffff;
+	gd->ram_size = 0x80000000;
+
+#ifdef CONFIG_PHYS_64BIT
+	/* Bank 1 declares the memory available in the DDR high region */
+	gd->bd->bi_dram[1].start = CFG_SYS_SDRAM_BASE1;
+	gd->bd->bi_dram[1].size = 0x77fffffff;
+	gd->ram_size = 0x800000000;
+#endif
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_TI_I2C_BOARD_DETECT)) {
+		setup_board_eeprom_env();
+		setup_serial();
+	}
+
+	return 0;
+}
+
+void spl_board_init(void)
+{
+}
diff --git a/board/ti/j784s4/j784s4.env b/board/ti/j784s4/j784s4.env
new file mode 100644
index 0000000000..07e1a2ab3c
--- /dev/null
+++ b/board/ti/j784s4/j784s4.env
@@ -0,0 +1,35 @@
+#include <env/ti/ti_armv7_common.env>
+#include <env/ti/mmc.env>
+#include <env/ti/ufs.env>
+#include <env/ti/k3_dfu.env>
+
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
+default_device_tree=ti/k3-j784s4-evm.dtb
+findfdt=
+	setenv name_fdt ${default_device_tree};
+	if test $board_name = j784s4; then
+		setenv name_fdt ti/k3-j784s4-evm.dtb; fi;
+	setenv fdtfile ${name_fdt}
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02880000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot_targets=ti_mmc mmc0 mmc1 usb pxe dhcp
+boot=mmc
+mmcdev=1
+dorprocboot=1
+bootpart=1:2
+bootdir=/boot
+rd_spec=-
+
+rproc_fw_binaries= 2 /lib/firmware/j784s4-main-r5f0_0-fw 3 /lib/firmware/j784s4-main-r5f0_1-fw 4 /lib/firmware/j784s4-main-r5f1_0-fw 5 /lib/firmware/j784s4-main-r5f1_1-fw 6 /lib/firmware/j784s4-main-r5f2_0-fw 7 /lib/firmware/j784s4-main-r5f2_1-fw 8 /lib/firmware/j784s4-c71_0-fw 9 /lib/firmware/j784s4-c71_1-fw 10 /lib/firmware/j784s4-c71_2-fw 11 /lib/firmware/j784s4-c71_3-fw
+
+splashfile=ti.gz
+splashimage=0x82000000
+splashpos=m,m
+splashsource=mmc
diff --git a/board/ti/j784s4/pm-cfg.yaml b/board/ti/j784s4/pm-cfg.yaml
new file mode 100644
index 0000000000..5d32453564
--- /dev/null
+++ b/board/ti/j784s4/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for J784S4
+#
+
+---
+
+pm-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
\ No newline at end of file
diff --git a/board/ti/j784s4/rm-cfg.yaml b/board/ti/j784s4/rm-cfg.yaml
new file mode 100644
index 0000000000..0ec092ab56
--- /dev/null
+++ b/board/ti/j784s4/rm-cfg.yaml
@@ -0,0 +1,3057 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for J784S4
+#
+
+---
+
+rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj : 0x0
+            boardcfg_abi_min : 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size : 356
+            host_cfg_entries:
+                - #1
+                    host_id: 3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #2
+                    host_id: 5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #3
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #4
+                    host_id: 13
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #5
+                    host_id: 21
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #6
+                    host_id: 23
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #7
+                    host_id: 25
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #8
+                    host_id: 27
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #9
+                    host_id: 35
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #10
+                    host_id: 37
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #11
+                    host_id: 40
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #12
+                    host_id: 42
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #13
+                    host_id: 45
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #14
+                    host_id: 47
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 3744
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 0
+                num_resource: 4
+                type: 640
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 4
+                type: 640
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 4
+                type: 640
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 4
+                type: 640
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 640
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 4
+                type: 640
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 4
+                type: 640
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 4
+                type: 640
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 12
+                type: 640
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 12
+                type: 640
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 704
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 32
+                type: 11072
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 24
+                type: 11072
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 8
+                type: 11072
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 24
+                type: 11136
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 16
+                type: 11136
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 8
+                type: 11136
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 48
+                type: 11264
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 11328
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 11328
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 6
+                type: 11328
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 6
+                type: 11328
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 2
+                type: 11328
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 2
+                type: 11328
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 50176
+                num_resource: 96
+                type: 17986
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 17987
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 17998
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 16
+                type: 17998
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 17999
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 17999
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 18017
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 18017
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 18018
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 18018
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 80
+                type: 18112
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 96
+                num_resource: 14
+                type: 18112
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 110
+                num_resource: 21
+                type: 18112
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 131
+                num_resource: 21
+                type: 18112
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 152
+                num_resource: 12
+                type: 18112
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 164
+                num_resource: 12
+                type: 18112
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 196
+                num_resource: 28
+                type: 18112
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 228
+                num_resource: 28
+                type: 18112
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 260
+                num_resource: 28
+                type: 18112
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 292
+                num_resource: 28
+                type: 18112
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 324
+                num_resource: 28
+                type: 18112
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 356
+                num_resource: 28
+                type: 18112
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 400
+                num_resource: 4
+                type: 18112
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 404
+                num_resource: 4
+                type: 18112
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19850
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 20480
+                num_resource: 1024
+                type: 19853
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19914
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 22528
+                num_resource: 1024
+                type: 19917
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 4
+                type: 19968
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 4
+                type: 19968
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 4
+                type: 19968
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 4
+                type: 19968
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 19968
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 4
+                type: 19968
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 12
+                type: 19968
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 4
+                type: 19968
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 4
+                type: 19968
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 4
+                type: 19968
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 4
+                type: 19968
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 4
+                type: 19968
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 19968
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 19968
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20160
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 423
+                num_resource: 10
+                type: 20161
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 433
+                num_resource: 20
+                type: 20161
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 453
+                num_resource: 16
+                type: 20161
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 469
+                num_resource: 13
+                type: 20161
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 482
+                num_resource: 128
+                type: 20161
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 610
+                num_resource: 46
+                type: 20161
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 656
+                num_resource: 10
+                type: 20161
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 666
+                num_resource: 20
+                type: 20161
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 686
+                num_resource: 64
+                type: 20161
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 750
+                num_resource: 10
+                type: 20161
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 760
+                num_resource: 4
+                type: 20161
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 764
+                num_resource: 4
+                type: 20161
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 878
+                num_resource: 128
+                type: 20161
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1006
+                num_resource: 10
+                type: 20161
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 345
+                num_resource: 6
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 0
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 1
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 352
+                num_resource: 1
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 353
+                num_resource: 1
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 354
+                num_resource: 1
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 355
+                num_resource: 4
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 359
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 360
+                num_resource: 1
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 361
+                num_resource: 1
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 362
+                num_resource: 3
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 365
+                num_resource: 1
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 366
+                num_resource: 1
+                type: 20162
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 367
+                num_resource: 1
+                type: 20162
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 368
+                num_resource: 25
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 393
+                num_resource: 1
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 394
+                num_resource: 2
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 396
+                num_resource: 2
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 398
+                num_resource: 2
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 400
+                num_resource: 2
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 402
+                num_resource: 12
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 414
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 415
+                num_resource: 2
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 417
+                num_resource: 2
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 419
+                num_resource: 2
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 421
+                num_resource: 2
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20163
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20163
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20164
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20164
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20164
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20164
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20164
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 343
+                num_resource: 1
+                type: 20165
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 344
+                num_resource: 1
+                type: 20165
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 341
+                num_resource: 1
+                type: 20166
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 342
+                num_resource: 1
+                type: 20166
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20167
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20167
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20168
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20168
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 20170
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20170
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 20171
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 20171
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 3
+                type: 20171
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 3
+                type: 20171
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20171
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20171
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 6
+                type: 20171
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 3
+                type: 20171
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 3
+                type: 20171
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 3
+                type: 20171
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 20171
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20171
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20171
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20171
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 16
+                type: 20416
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 98
+                num_resource: 16
+                type: 20416
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 114
+                num_resource: 110
+                type: 20416
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20417
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 49152
+                num_resource: 1024
+                type: 20418
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20419
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20426
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20426
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 74
+                num_resource: 2
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 2
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 2
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20427
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20427
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20428
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20428
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20429
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20429
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20430
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20430
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20430
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20430
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20430
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20431
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20431
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20432
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20432
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 56
+                type: 20554
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 112
+                num_resource: 24
+                type: 20554
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 136
+                num_resource: 12
+                type: 20554
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 12
+                type: 20554
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 160
+                num_resource: 10
+                type: 20554
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 170
+                num_resource: 10
+                type: 20554
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 28
+                type: 20554
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 8
+                type: 20554
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 216
+                num_resource: 12
+                type: 20554
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 228
+                num_resource: 8
+                type: 20554
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 236
+                num_resource: 10
+                type: 20554
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 246
+                num_resource: 10
+                type: 20554
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 1024
+                type: 20557
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1080
+                num_resource: 512
+                type: 20557
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 1592
+                num_resource: 256
+                type: 20557
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 1848
+                num_resource: 256
+                type: 20557
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 2104
+                num_resource: 256
+                type: 20557
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 2360
+                num_resource: 256
+                type: 20557
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 2616
+                num_resource: 512
+                type: 20557
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 3128
+                num_resource: 256
+                type: 20557
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 3384
+                num_resource: 256
+                type: 20557
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 3640
+                num_resource: 256
+                type: 20557
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 3896
+                num_resource: 256
+                type: 20557
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 4152
+                num_resource: 256
+                type: 20557
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 4408
+                num_resource: 32
+                type: 20557
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 4440
+                num_resource: 32
+                type: 20557
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 4472
+                num_resource: 136
+                type: 20557
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 1536
+                num_resource: 16
+                type: 20559
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2048
+                num_resource: 16
+                type: 20560
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2560
+                num_resource: 16
+                type: 20561
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3072
+                num_resource: 32
+                type: 20562
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3584
+                num_resource: 32
+                type: 20563
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 32
+                type: 20564
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 12
+                type: 20736
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 20
+                type: 20736
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 2
+                type: 20928
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 4
+                type: 20928
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 4
+                type: 20928
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 4
+                type: 20928
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 4
+                type: 20928
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 4
+                type: 20928
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 16
+                type: 20928
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 4
+                type: 20928
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 4
+                type: 20928
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 47
+                num_resource: 4
+                type: 20928
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 51
+                num_resource: 3
+                type: 20928
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 2
+                type: 20928
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 20928
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 20928
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20992
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 96
+                num_resource: 20
+                type: 20993
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 116
+                num_resource: 8
+                type: 20993
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 124
+                num_resource: 8
+                type: 20993
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 132
+                num_resource: 8
+                type: 20993
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 140
+                num_resource: 8
+                type: 20993
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 8
+                type: 20993
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 156
+                num_resource: 16
+                type: 20993
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 172
+                num_resource: 8
+                type: 20993
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 8
+                type: 20993
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 188
+                num_resource: 8
+                type: 20993
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 196
+                num_resource: 8
+                type: 20993
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 204
+                num_resource: 4
+                type: 20993
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 32
+                type: 20993
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 240
+                num_resource: 12
+                type: 20993
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 50
+                num_resource: 3
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 0
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 1
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 58
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 62
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 63
+                num_resource: 2
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 0
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 8
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 86
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 87
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 88
+                num_resource: 3
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 91
+                num_resource: 2
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 20995
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 0
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 2
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 21002
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21002
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 21003
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 21003
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 2
+                type: 21003
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 2
+                type: 21003
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 2
+                type: 21003
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 2
+                type: 21003
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 21003
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 2
+                type: 21003
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 21003
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 2
+                type: 21003
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 2
+                type: 21003
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 21003
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 3
+                type: 21003
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 3
+                type: 21003
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 8
+                type: 21056
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 21056
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 8
+                type: 21056
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 68
+                num_resource: 4
+                type: 21056
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 72
+                num_resource: 4
+                type: 21056
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 4
+                type: 21056
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 21056
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 2
+                type: 21056
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 8
+                type: 21056
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 92
+                num_resource: 4
+                type: 21056
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 21057
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 56320
+                num_resource: 256
+                type: 21058
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 21059
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 21069
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 32
+                type: 21194
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 64
+                type: 21194
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 4
+                type: 21194
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 122
+                num_resource: 134
+                type: 21194
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 16406
+                num_resource: 128
+                type: 21197
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16534
+                num_resource: 256
+                type: 21197
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 16790
+                num_resource: 64
+                type: 21197
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 16854
+                num_resource: 1066
+                type: 21197
+                host_id: 128
+                reserved: 0
\ No newline at end of file
diff --git a/board/ti/j784s4/sec-cfg.yaml b/board/ti/j784s4/sec-cfg.yaml
new file mode 100644
index 0000000000..ef1d1154fe
--- /dev/null
+++ b/board/ti/j784s4/sec-cfg.yaml
@@ -0,0 +1,379 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for J784S4
+#
+
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+        proc_acl_entries:
+            - #1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            - #32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            - #1
+                host_id: 0
+                supervisor_host_id: 0
+            - #2
+                host_id: 0
+                supervisor_host_id: 0
+            - #3
+                host_id: 0
+                supervisor_host_id: 0
+            - #4
+                host_id: 0
+                supervisor_host_id: 0
+            - #5
+                host_id: 0
+                supervisor_host_id: 0
+            - #6
+                host_id: 0
+                supervisor_host_id: 0
+            - #7
+                host_id: 0
+                supervisor_host_id: 0
+            - #8
+                host_id: 0
+                supervisor_host_id: 0
+            - #9
+                host_id: 0
+                supervisor_host_id: 0
+            - #10
+                host_id: 0
+                supervisor_host_id: 0
+            - #11
+                host_id: 0
+                supervisor_host_id: 0
+            - #12
+                host_id: 0
+                supervisor_host_id: 0
+            - #13
+                host_id: 0
+                supervisor_host_id: 0
+            - #14
+                host_id: 0
+                supervisor_host_id: 0
+            - #15
+                host_id: 0
+                supervisor_host_id: 0
+            - #16
+                host_id: 0
+                supervisor_host_id: 0
+            - #17
+                host_id: 0
+                supervisor_host_id: 0
+            - #18
+                host_id: 0
+                supervisor_host_id: 0
+            - #19
+                host_id: 0
+                supervisor_host_id: 0
+            - #20
+                host_id: 0
+                supervisor_host_id: 0
+            - #21
+                host_id: 0
+                supervisor_host_id: 0
+            - #22
+                host_id: 0
+                supervisor_host_id: 0
+            - #23
+                host_id: 0
+                supervisor_host_id: 0
+            - #24
+                host_id: 0
+                supervisor_host_id: 0
+            - #25
+                host_id: 0
+                supervisor_host_id: 0
+            - #26
+                host_id: 0
+                supervisor_host_id: 0
+            - #27
+                host_id: 0
+                supervisor_host_id: 0
+            - #28
+                host_id: 0
+                supervisor_host_id: 0
+            - #29
+                host_id: 0
+                supervisor_host_id: 0
+            - #30
+                host_id: 0
+                supervisor_host_id: 0
+            - #31
+                host_id: 0
+                supervisor_host_id: 0
+            - #32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        write_host_id: 0
+        otp_entry:
+            - #1
+                host_id: 0
+                host_perms: 0
+            - #2
+                host_id: 0
+                host_perms: 0
+            - #3
+                host_id: 0
+                host_perms: 0
+            - #4
+                host_id: 0
+                host_perms: 0
+            - #5
+                host_id: 0
+                host_perms: 0
+            - #6
+                host_id: 0
+                host_perms: 0
+            - #7
+                host_id: 0
+                host_perms: 0
+            - #8
+                host_id: 0
+                host_perms: 0
+            - #9
+                host_id: 0
+                host_perms: 0
+            - #10
+                host_id: 0
+                host_perms: 0
+            - #11
+                host_id: 0
+                host_perms: 0
+            - #12
+                host_id: 0
+                host_perms: 0
+            - #13
+                host_id: 0
+                host_perms: 0
+            - #14
+                host_id: 0
+                host_perms: 0
+            - #15
+                host_id: 0
+                host_perms: 0
+            - #16
+                host_id: 0
+                host_perms: 0
+            - #17
+                host_id: 0
+                host_perms: 0
+            - #18
+                host_id: 0
+                host_perms: 0
+            - #19
+                host_id: 0
+                host_perms: 0
+            - #20
+                host_id: 0
+                host_perms: 0
+            - #21
+                host_id: 0
+                host_perms: 0
+            - #22
+                host_id: 0
+                host_perms: 0
+            - #23
+                host_id: 0
+                host_perms: 0
+            - #24
+                host_id: 0
+                host_perms: 0
+            - #25
+                host_id: 0
+                host_perms: 0
+            - #26
+                host_id: 0
+                host_perms: 0
+            - #27
+                host_id: 0
+                host_perms: 0
+            - #28
+                host_id: 0
+                host_perms: 0
+            - #29
+                host_id: 0
+                host_perms: 0
+            - #30
+                host_id: 0
+                host_perms: 0
+            - #31
+                host_id: 0
+                host_perms: 0
+            - #32
+                host_id: 0
+                host_perms: 0
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci : 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x23BE
+            size : 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock : 0x0
+        allow_wildcard_unlock : 0x0
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev : 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x608F
+            size: 10
+        handover_msg_sender : 0
+        handover_to_host_id : 0
+        rsvd: [0, 0, 0, 0]
\ No newline at end of file
diff --git a/board/ti/j784s4/tifs-rm-cfg.yaml b/board/ti/j784s4/tifs-rm-cfg.yaml
new file mode 100644
index 0000000000..c2da58ffa2
--- /dev/null
+++ b/board/ti/j784s4/tifs-rm-cfg.yaml
@@ -0,0 +1,2655 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for J784S4
+#
+
+---
+
+tifs-rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj : 0x0
+            boardcfg_abi_min : 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size : 356
+            host_cfg_entries:
+                - #1
+                    host_id: 3
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #2
+                    host_id: 5
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #3
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #4
+                    host_id: 13
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #5
+                    host_id: 21
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #6
+                    host_id: 23
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #7
+                    host_id: 25
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #8
+                    host_id: 27
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #9
+                    host_id: 35
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #10
+                    host_id: 37
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #11
+                    host_id: 40
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #12
+                    host_id: 42
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #13
+                    host_id: 45
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #14
+                    host_id: 47
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #32
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size: 8
+            resasg_entries_size: 3208
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 17998
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 16
+                type: 17998
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 17999
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 17999
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 18017
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 16
+                type: 18017
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 18018
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 8
+                type: 18018
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19850
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 64
+                type: 19914
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 4
+                type: 19968
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 4
+                type: 19968
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 4
+                type: 19968
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 4
+                type: 19968
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 19968
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 4
+                type: 19968
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 12
+                type: 19968
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 4
+                type: 19968
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 4
+                type: 19968
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 4
+                type: 19968
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 4
+                type: 19968
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 4
+                type: 19968
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 19968
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 19968
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20160
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 423
+                num_resource: 10
+                type: 20161
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 433
+                num_resource: 20
+                type: 20161
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 453
+                num_resource: 16
+                type: 20161
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 469
+                num_resource: 13
+                type: 20161
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 482
+                num_resource: 128
+                type: 20161
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 610
+                num_resource: 46
+                type: 20161
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 656
+                num_resource: 10
+                type: 20161
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 666
+                num_resource: 20
+                type: 20161
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 686
+                num_resource: 64
+                type: 20161
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 750
+                num_resource: 10
+                type: 20161
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 760
+                num_resource: 4
+                type: 20161
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 764
+                num_resource: 4
+                type: 20161
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 878
+                num_resource: 128
+                type: 20161
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1006
+                num_resource: 10
+                type: 20161
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 345
+                num_resource: 6
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 0
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 351
+                num_resource: 1
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 352
+                num_resource: 1
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 353
+                num_resource: 1
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 354
+                num_resource: 1
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 355
+                num_resource: 4
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 359
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 360
+                num_resource: 1
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 361
+                num_resource: 1
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 362
+                num_resource: 3
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 365
+                num_resource: 1
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 366
+                num_resource: 1
+                type: 20162
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 367
+                num_resource: 1
+                type: 20162
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 368
+                num_resource: 25
+                type: 20162
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 393
+                num_resource: 1
+                type: 20162
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 394
+                num_resource: 2
+                type: 20162
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 396
+                num_resource: 2
+                type: 20162
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 398
+                num_resource: 2
+                type: 20162
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 400
+                num_resource: 2
+                type: 20162
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 402
+                num_resource: 12
+                type: 20162
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 414
+                num_resource: 1
+                type: 20162
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 415
+                num_resource: 2
+                type: 20162
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 417
+                num_resource: 2
+                type: 20162
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 419
+                num_resource: 2
+                type: 20162
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 421
+                num_resource: 2
+                type: 20162
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20163
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20163
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20163
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20163
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20163
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20163
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20163
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20163
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20163
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20163
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20163
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20163
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20163
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20163
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20164
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20164
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20164
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20164
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20164
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20164
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20164
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20164
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 343
+                num_resource: 1
+                type: 20165
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 344
+                num_resource: 1
+                type: 20165
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 341
+                num_resource: 1
+                type: 20166
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 342
+                num_resource: 1
+                type: 20166
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20167
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20167
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20168
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20168
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 20170
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20170
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 20171
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 20171
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 3
+                type: 20171
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 3
+                type: 20171
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20171
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20171
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 6
+                type: 20171
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 3
+                type: 20171
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 3
+                type: 20171
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 3
+                type: 20171
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 20171
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20171
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20171
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20171
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 16
+                type: 20416
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 98
+                num_resource: 16
+                type: 20416
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 114
+                num_resource: 110
+                type: 20416
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20417
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20426
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20426
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20426
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20426
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20426
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20426
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20426
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20426
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20426
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 1
+                type: 20426
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 74
+                num_resource: 2
+                type: 20426
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 2
+                type: 20426
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 2
+                type: 20426
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 20426
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20427
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20427
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20428
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20428
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 4
+                num_resource: 6
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 0
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 4
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 1
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 3
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 1
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 1
+                type: 20429
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 1
+                type: 20429
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 25
+                type: 20429
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 1
+                type: 20429
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 2
+                type: 20429
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 2
+                type: 20429
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 2
+                type: 20429
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 2
+                type: 20429
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 12
+                type: 20429
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20429
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 2
+                type: 20429
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 2
+                type: 20429
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20429
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 2
+                type: 20429
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 8
+                type: 20430
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 93
+                num_resource: 8
+                type: 20430
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 101
+                num_resource: 6
+                type: 20430
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 107
+                num_resource: 4
+                type: 20430
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 111
+                num_resource: 2
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 113
+                num_resource: 2
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 0
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 2
+                type: 20430
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 117
+                num_resource: 96
+                type: 20430
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 213
+                num_resource: 96
+                type: 20430
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 309
+                num_resource: 32
+                type: 20430
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 1
+                type: 20431
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 1
+                type: 20431
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20432
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 1
+                type: 20432
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 56
+                type: 20554
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 112
+                num_resource: 24
+                type: 20554
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 136
+                num_resource: 12
+                type: 20554
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 12
+                type: 20554
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 160
+                num_resource: 10
+                type: 20554
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 170
+                num_resource: 10
+                type: 20554
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 28
+                type: 20554
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 8
+                type: 20554
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 216
+                num_resource: 12
+                type: 20554
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 228
+                num_resource: 8
+                type: 20554
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 236
+                num_resource: 10
+                type: 20554
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 246
+                num_resource: 10
+                type: 20554
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 1536
+                num_resource: 16
+                type: 20559
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2048
+                num_resource: 16
+                type: 20560
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2560
+                num_resource: 16
+                type: 20561
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3072
+                num_resource: 32
+                type: 20562
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3584
+                num_resource: 32
+                type: 20563
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 32
+                type: 20564
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 1
+                num_resource: 2
+                type: 20928
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 4
+                type: 20928
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 4
+                type: 20928
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 4
+                type: 20928
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 4
+                type: 20928
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 4
+                type: 20928
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 16
+                type: 20928
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 4
+                type: 20928
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 4
+                type: 20928
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 47
+                num_resource: 4
+                type: 20928
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 51
+                num_resource: 3
+                type: 20928
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 2
+                type: 20928
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 20928
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 4
+                type: 20928
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 20992
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 96
+                num_resource: 20
+                type: 20993
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 116
+                num_resource: 8
+                type: 20993
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 124
+                num_resource: 8
+                type: 20993
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 132
+                num_resource: 8
+                type: 20993
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 140
+                num_resource: 8
+                type: 20993
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 148
+                num_resource: 8
+                type: 20993
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 156
+                num_resource: 16
+                type: 20993
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 172
+                num_resource: 8
+                type: 20993
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 180
+                num_resource: 8
+                type: 20993
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 188
+                num_resource: 8
+                type: 20993
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 196
+                num_resource: 8
+                type: 20993
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 204
+                num_resource: 4
+                type: 20993
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 208
+                num_resource: 32
+                type: 20993
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 240
+                num_resource: 12
+                type: 20993
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 50
+                num_resource: 3
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 0
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 53
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 55
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 1
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 58
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 59
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 61
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 62
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 63
+                num_resource: 2
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 0
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 65
+                num_resource: 8
+                type: 20994
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 4
+                type: 20994
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 77
+                num_resource: 1
+                type: 20994
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 1
+                type: 20994
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 79
+                num_resource: 1
+                type: 20994
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 1
+                type: 20994
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 81
+                num_resource: 2
+                type: 20994
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 1
+                type: 20994
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 1
+                type: 20994
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 85
+                num_resource: 1
+                type: 20994
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 86
+                num_resource: 1
+                type: 20994
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 87
+                num_resource: 1
+                type: 20994
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 88
+                num_resource: 3
+                type: 20994
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 91
+                num_resource: 2
+                type: 20994
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 20995
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 20995
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 20995
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 20995
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 20995
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 20995
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 20995
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 20995
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 20995
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 20995
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 20995
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 20995
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 20995
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 20995
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 20995
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 0
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 2
+                type: 20997
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 20999
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 5
+                type: 21002
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21002
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 3
+                type: 21003
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3
+                num_resource: 2
+                type: 21003
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 2
+                type: 21003
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 2
+                type: 21003
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 2
+                type: 21003
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 2
+                type: 21003
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 21003
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 2
+                type: 21003
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 21003
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 2
+                type: 21003
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 2
+                type: 21003
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 21003
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 3
+                type: 21003
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 3
+                type: 21003
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 48
+                num_resource: 8
+                type: 21056
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 56
+                num_resource: 4
+                type: 21056
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 60
+                num_resource: 8
+                type: 21056
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 68
+                num_resource: 4
+                type: 21056
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 72
+                num_resource: 4
+                type: 21056
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 76
+                num_resource: 4
+                type: 21056
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 21056
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 82
+                num_resource: 2
+                type: 21056
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 8
+                type: 21056
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 92
+                num_resource: 4
+                type: 21056
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 21057
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21066
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21066
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21066
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21066
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21066
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21066
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21066
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21066
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21066
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21066
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21066
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21066
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21066
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21066
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21067
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 3
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 0
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 6
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 9
+                num_resource: 1
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 11
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 14
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 15
+                num_resource: 2
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 0
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 17
+                num_resource: 8
+                type: 21069
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 25
+                num_resource: 4
+                type: 21069
+                host_id: 13
+                reserved: 0
+        -
+                start_resource: 29
+                num_resource: 1
+                type: 21069
+                host_id: 21
+                reserved: 0
+        -
+                start_resource: 30
+                num_resource: 1
+                type: 21069
+                host_id: 23
+                reserved: 0
+        -
+                start_resource: 31
+                num_resource: 1
+                type: 21069
+                host_id: 25
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 1
+                type: 21069
+                host_id: 27
+                reserved: 0
+        -
+                start_resource: 33
+                num_resource: 2
+                type: 21069
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 1
+                type: 21069
+                host_id: 37
+                reserved: 0
+        -
+                start_resource: 36
+                num_resource: 1
+                type: 21069
+                host_id: 40
+                reserved: 0
+        -
+                start_resource: 37
+                num_resource: 1
+                type: 21069
+                host_id: 42
+                reserved: 0
+        -
+                start_resource: 38
+                num_resource: 1
+                type: 21069
+                host_id: 45
+                reserved: 0
+        -
+                start_resource: 39
+                num_resource: 1
+                type: 21069
+                host_id: 47
+                reserved: 0
+        -
+                start_resource: 40
+                num_resource: 3
+                type: 21069
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 2
+                type: 21069
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 45
+                num_resource: 1
+                type: 21069
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 0
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 2
+                type: 21071
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 32
+                type: 21194
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 64
+                type: 21194
+                host_id: 3
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 4
+                type: 21194
+                host_id: 5
+                reserved: 0
+        -
+                start_resource: 122
+                num_resource: 134
+                type: 21194
+                host_id: 128
+                reserved: 0
\ No newline at end of file
diff --git a/include/configs/j784s4_evm.h b/include/configs/j784s4_evm.h
new file mode 100644
index 0000000000..7ce7383f0c
--- /dev/null
+++ b/include/configs/j784s4_evm.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Configuration header file for K3 J784S4 EVM
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - https://www.ti.com/
+ *	Hari Nagalla <hnagalla@ti.com>
+ */
+
+#ifndef __CONFIG_J784S4_EVM_H
+#define __CONFIG_J784S4_EVM_H
+
+#include <linux/sizes.h>
+
+/* DDR Configuration */
+#define CFG_SYS_SDRAM_BASE1		0x880000000
+
+/* Now for the remaining common defines */
+#include <configs/ti_armv7_common.h>
+
+#endif /* __CONFIG_J784S4_EVM_H */
-- 
2.34.1

