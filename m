Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3482CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 09:03:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39A548844E;
	Thu,  4 Apr 2024 11:01:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="fnCtqh8s";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 55ED188408; Thu,  4 Apr 2024 11:01:14 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8276C883F8
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 11:01:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=j-choudhary@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43490viT110190;
 Thu, 4 Apr 2024 04:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1712221257;
 bh=1AStoOrwwk/jcBLqhe6l0o6I22I2RyfoSUPe//Emul8=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=fnCtqh8saU+2YNlrXevFyNUMkZVV8DawvSH2ytxyRFP8UK2yxaC1VjNyjPMgU0pe6
 43HDo5oB9pK/Mm6CKEgcD5T1MUpSdK5GOx0/K4BGSzHoZPXf37e6XGR6G030dec4AV
 DW/9/f+Xy66eD45+9/ZdxbC58cE0E/8P5I+I7Qro=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43490vej062222
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 4 Apr 2024 04:00:57 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 04:00:56 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 04:00:57 -0500
Received: from localhost (jayesh-hp-probook-440-g8-notebook-pc.dhcp.ti.com
 [172.24.227.252])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43490u4g058204;
 Thu, 4 Apr 2024 04:00:56 -0500
From: Jayesh Choudhary <j-choudhary@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <jh80.chung@samsung.com>,
 <lukma@denx.de>, <seanga2@gmail.com>, <vaishnav.a@ti.com>,
 <n-francis@ti.com>, <u-kumar1@ti.com>, <j-choudhary@ti.com>,
 <sumit.garg@linaro.org>
CC: <vigneshr@ti.com>, <nm@ti.com>, <afd@ti.com>, <bb@ti.com>,
 <rogerq@kernel.org>, <r-gunasekaran@ti.com>
Subject: [RFC PATCH 11/15] board: ti: Introduce basic board files for the
 J722S family
Date: Thu, 4 Apr 2024 14:30:35 +0530
Message-ID: <20240404090039.87458-12-j-choudhary@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240404090039.87458-1-j-choudhary@ti.com>
References: <20240404090039.87458-1-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
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

Introduce the basic files needed to support the TI J722S family of SoCs.

Co-developed-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Vaishnav Achath <vaishnav.a@ti.com>
Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
---
 board/ti/j722s/Kconfig          |   26 +
 board/ti/j722s/MAINTAINERS      |    9 +
 board/ti/j722s/Makefile         |    7 +
 board/ti/j722s/board-cfg.yaml   |   36 +
 board/ti/j722s/evm.c            |   29 +
 board/ti/j722s/j722s.env        |   15 +
 board/ti/j722s/pm-cfg.yaml      |   12 +
 board/ti/j722s/rm-cfg.yaml      | 1119 +++++++++++++++++++++++++++++++
 board/ti/j722s/sec-cfg.yaml     |  379 +++++++++++
 board/ti/j722s/tifs-rm-cfg.yaml |  981 +++++++++++++++++++++++++++
 10 files changed, 2613 insertions(+)
 create mode 100644 board/ti/j722s/Kconfig
 create mode 100644 board/ti/j722s/MAINTAINERS
 create mode 100644 board/ti/j722s/Makefile
 create mode 100644 board/ti/j722s/board-cfg.yaml
 create mode 100644 board/ti/j722s/evm.c
 create mode 100644 board/ti/j722s/j722s.env
 create mode 100644 board/ti/j722s/pm-cfg.yaml
 create mode 100644 board/ti/j722s/rm-cfg.yaml
 create mode 100644 board/ti/j722s/sec-cfg.yaml
 create mode 100644 board/ti/j722s/tifs-rm-cfg.yaml

diff --git a/board/ti/j722s/Kconfig b/board/ti/j722s/Kconfig
new file mode 100644
index 0000000000..68c214e473
--- /dev/null
+++ b/board/ti/j722s/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if TARGET_J722S_R5_EVM || TARGET_J722S_A53_EVM
+
+config SYS_BOARD
+       default "j722s"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "j722s_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_J722S_R5_EVM
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+endif
diff --git a/board/ti/j722s/MAINTAINERS b/board/ti/j722s/MAINTAINERS
new file mode 100644
index 0000000000..7908c30def
--- /dev/null
+++ b/board/ti/j722s/MAINTAINERS
@@ -0,0 +1,9 @@
+J722S BOARD
+M:	Vaishnav Achath <vaishnav.a@ti.com>
+M:	Jayesh Choudhary <j-choudhary@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/j722s/
+F:	include/configs/j722s_evm.h
+F:	configs/j722s_evm_r5_defconfig
+F:	configs/j722s_evm_a53_defconfig
diff --git a/board/ti/j722s/Makefile b/board/ti/j722s/Makefile
new file mode 100644
index 0000000000..20d2ec934b
--- /dev/null
+++ b/board/ti/j722s/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/j722s/board-cfg.yaml b/board/ti/j722s/board-cfg.yaml
new file mode 100644
index 0000000000..f9a4c438ca
--- /dev/null
+++ b/board/ti/j722s/board-cfg.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for J722S
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
+        msmc_cache_size: 0x0
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/ti/j722s/evm.c b/board/ti/j722s/evm.c
new file mode 100644
index 0000000000..515aaa8187
--- /dev/null
+++ b/board/ti/j722s/evm.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for J722S platforms
+ *
+ * Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
+
+int board_init(void)
+{
+	return 0;
+}
+
+int dram_init(void)
+{
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
diff --git a/board/ti/j722s/j722s.env b/board/ti/j722s/j722s.env
new file mode 100644
index 0000000000..f8b6aff2c2
--- /dev/null
+++ b/board/ti/j722s/j722s.env
@@ -0,0 +1,15 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/mmc.env>
+
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot_targets=mmc1 mmc0 pxe dhcp
+boot=mmc
+mmcdev=1
+bootpart=1:2
+bootdir=/boot
+rd_spec=-
diff --git a/board/ti/j722s/pm-cfg.yaml b/board/ti/j722s/pm-cfg.yaml
new file mode 100644
index 0000000000..46b3ad2010
--- /dev/null
+++ b/board/ti/j722s/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for J722S
+#
+
+---
+
+pm-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/ti/j722s/rm-cfg.yaml b/board/ti/j722s/rm-cfg.yaml
new file mode 100644
index 0000000000..21ca30104c
--- /dev/null
+++ b/board/ti/j722s/rm-cfg.yaml
@@ -0,0 +1,1119 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for J722S
+#
+
+---
+
+rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                -
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -
+                    host_id: 20
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -
+                    host_id: 22
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -
+                    host_id: 38
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -
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
+            resasg_entries_size: 1160
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 192
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 2
+            type: 192
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 4
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 4
+            type: 320
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 26
+            type: 384
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 50176
+            num_resource: 164
+            type: 1666
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1667
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1677
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 1677
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 1677
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 16
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 73
+            num_resource: 5
+            type: 1678
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 73
+            num_resource: 5
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 78
+            num_resource: 2
+            type: 1678
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 32
+            num_resource: 12
+            type: 1679
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 6
+            type: 1679
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 50
+            num_resource: 2
+            type: 1679
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 52
+            num_resource: 2
+            type: 1679
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 54
+            num_resource: 3
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1696
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 4
+            type: 1696
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 4
+            type: 1696
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 5
+            type: 1697
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 5
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 2
+            type: 1697
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 2
+            type: 1697
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 1698
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 6
+            type: 1698
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 2
+            type: 1698
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 2
+            type: 1698
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 3
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 7
+            num_resource: 21
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 44
+            num_resource: 36
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 84
+            num_resource: 16
+            type: 1802
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 100
+            num_resource: 16
+            type: 1802
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 154
+            num_resource: 14
+            type: 1802
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 16
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 17
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 529
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 529
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 785
+            num_resource: 128
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 913
+            num_resource: 128
+            type: 1805
+            host_id: 20
+            reserved: 0
+        -
+            start_resource: 1041
+            num_resource: 128
+            type: 1805
+            host_id: 22
+            reserved: 0
+        -
+            start_resource: 1169
+            num_resource: 128
+            type: 1805
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 1297
+            num_resource: 239
+            type: 1805
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 29
+            type: 1807
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4608
+            num_resource: 99
+            type: 1808
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5120
+            num_resource: 24
+            type: 1809
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5632
+            num_resource: 51
+            type: 1810
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 6144
+            num_resource: 51
+            type: 1811
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8192
+            num_resource: 32
+            type: 1812
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8704
+            num_resource: 32
+            type: 1813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9216
+            num_resource: 32
+            type: 1814
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 9728
+            num_resource: 25
+            type: 1815
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10240
+            num_resource: 25
+            type: 1816
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 10752
+            num_resource: 25
+            type: 1817
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11264
+            num_resource: 25
+            type: 1818
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 11776
+            num_resource: 25
+            type: 1819
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 25
+            type: 1820
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 1923
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1936
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1936
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1936
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1936
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 64
+            type: 1937
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 83
+            num_resource: 8
+            type: 1938
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 91
+            num_resource: 8
+            type: 1939
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 99
+            num_resource: 10
+            type: 1942
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 109
+            num_resource: 3
+            type: 1942
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 112
+            num_resource: 3
+            type: 1942
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 115
+            num_resource: 3
+            type: 1942
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 118
+            num_resource: 16
+            type: 1943
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1944
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 134
+            num_resource: 8
+            type: 1945
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1946
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 142
+            num_resource: 8
+            type: 1947
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1955
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1955
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1955
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1955
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 8
+            type: 1956
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 27
+            num_resource: 1
+            type: 1957
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 28
+            num_resource: 1
+            type: 1958
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1961
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1961
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1961
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1961
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 10
+            type: 1962
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 10
+            num_resource: 3
+            type: 1962
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 13
+            num_resource: 3
+            type: 1962
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 16
+            num_resource: 3
+            type: 1962
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 1
+            type: 1963
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 19
+            num_resource: 16
+            type: 1964
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 1
+            type: 1965
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1966
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 21
+            num_resource: 1
+            type: 1967
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 35
+            num_resource: 8
+            type: 1968
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 1
+            type: 1969
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1970
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 1
+            type: 1971
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 43
+            num_resource: 8
+            type: 1972
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 2112
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 2122
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 51200
+            num_resource: 80
+            type: 12738
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 1
+            type: 12739
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 8
+            num_resource: 12
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 20
+            num_resource: 20
+            type: 12750
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12751
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 12
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12
+            num_resource: 20
+            type: 12769
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12770
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 22
+            num_resource: 18
+            type: 12810
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 64
+            type: 12813
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12352
+            num_resource: 64
+            type: 12813
+            host_id: 38
+            reserved: 0
+        -
+            start_resource: 12416
+            num_resource: 88
+            type: 12813
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 1536
+            num_resource: 8
+            type: 12823
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2048
+            num_resource: 8
+            type: 12824
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 2560
+            num_resource: 8
+            type: 12825
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 32
+            type: 12826
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 32
+            type: 12827
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 32
+            type: 12828
+            host_id: 128
+            reserved: 0
diff --git a/board/ti/j722s/sec-cfg.yaml b/board/ti/j722s/sec-cfg.yaml
new file mode 100644
index 0000000000..a41374b30c
--- /dev/null
+++ b/board/ti/j722s/sec-cfg.yaml
@@ -0,0 +1,379 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for J722S
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
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+            -
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        write_host_id: 0
+        otp_entry:
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+            -
+                host_id: 0
+                host_perms: 0
+    dkek_config:
+        subhdr:
+            magic: 0x5170
+            size: 12
+        allowed_hosts: [128, 0, 0, 0]
+        allow_dkek_export_tisci: 0x5A
+        rsvd: [0, 0, 0]
+    sa2ul_cfg:
+        subhdr:
+            magic: 0x23BE
+            size: 0
+        auth_resource_owner: 0
+        enable_saul_psil_global_config_writes: 0x5A
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock: 0x5A
+        allow_wildcard_unlock: 0x5A
+        allowed_debug_level_rsvd: 0
+        rsvd: 0
+        min_cert_rev: 0x0
+        jtag_unlock_hosts: [0, 0, 0, 0]
+    sec_handover_cfg:
+        subhdr:
+            magic: 0x608F
+            size: 10
+        handover_msg_sender: 0
+        handover_to_host_id: 0
+        rsvd: [0, 0, 0, 0]
diff --git a/board/ti/j722s/tifs-rm-cfg.yaml b/board/ti/j722s/tifs-rm-cfg.yaml
new file mode 100644
index 0000000000..5e8d7e0444
--- /dev/null
+++ b/board/ti/j722s/tifs-rm-cfg.yaml
@@ -0,0 +1,981 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2024 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for J722S
+#
+
+---
+
+tifs-rm-cfg:
+    rm_boardcfg:
+        rev:
+            boardcfg_abi_maj: 0x0
+            boardcfg_abi_min: 0x1
+        host_cfg:
+            subhdr:
+                magic: 0x4C41
+                size: 356
+            host_cfg_entries:
+                - #1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #2
+                    host_id: 20
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #3
+                    host_id: 22
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #4
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #5
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #6
+                    host_id: 38
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
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
+            resasg_entries_size: 976
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 1677
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 6
+                type: 1677
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 6
+                type: 1677
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 2
+                type: 1677
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 4
+                type: 1677
+                host_id: 22
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 4
+                type: 1677
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 16
+                type: 1678
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 5
+                type: 1678
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 73
+                num_resource: 5
+                type: 1678
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 78
+                num_resource: 2
+                type: 1678
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 1678
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 32
+                num_resource: 12
+                type: 1679
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 50
+                num_resource: 2
+                type: 1679
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 52
+                num_resource: 2
+                type: 1679
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 54
+                num_resource: 3
+                type: 1679
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 1696
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 6
+                type: 1696
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 6
+                type: 1696
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 2
+                type: 1696
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 4
+                type: 1696
+                host_id: 22
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 4
+                type: 1696
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 1697
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 5
+                type: 1697
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 5
+                type: 1697
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 2
+                type: 1697
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 2
+                type: 1697
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 12
+                type: 1698
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 1698
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 2
+                type: 1698
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 3
+                type: 1698
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 7
+                num_resource: 21
+                type: 1802
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 36
+                type: 1802
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 44
+                num_resource: 36
+                type: 1802
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 84
+                num_resource: 16
+                type: 1802
+                host_id: 20
+                reserved: 0
+        -
+                start_resource: 100
+                num_resource: 16
+                type: 1802
+                host_id: 22
+                reserved: 0
+        -
+                start_resource: 154
+                num_resource: 14
+                type: 1802
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 168
+                num_resource: 16
+                type: 1802
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 29
+                type: 1807
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4608
+                num_resource: 99
+                type: 1808
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 5120
+                num_resource: 24
+                type: 1809
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 5632
+                num_resource: 51
+                type: 1810
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 6144
+                num_resource: 51
+                type: 1811
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 8192
+                num_resource: 32
+                type: 1812
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 8704
+                num_resource: 32
+                type: 1813
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 9216
+                num_resource: 32
+                type: 1814
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 9728
+                num_resource: 25
+                type: 1815
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 10240
+                num_resource: 25
+                type: 1816
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 10752
+                num_resource: 25
+                type: 1817
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 11264
+                num_resource: 25
+                type: 1818
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 11776
+                num_resource: 25
+                type: 1819
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 12288
+                num_resource: 25
+                type: 1820
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1936
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1936
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1936
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 64
+                type: 1937
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 64
+                type: 1937
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 83
+                num_resource: 8
+                type: 1938
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 91
+                num_resource: 8
+                type: 1939
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 99
+                num_resource: 10
+                type: 1942
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 112
+                num_resource: 3
+                type: 1942
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 115
+                num_resource: 3
+                type: 1942
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 16
+                type: 1943
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 118
+                num_resource: 16
+                type: 1943
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1944
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1945
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1946
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1947
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1955
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1955
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1955
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 8
+                type: 1956
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 8
+                type: 1956
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 27
+                num_resource: 1
+                type: 1957
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 1958
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1961
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1961
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1961
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1962
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1962
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1962
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 16
+                type: 1964
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 19
+                num_resource: 16
+                type: 1964
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 1965
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1966
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 21
+                num_resource: 1
+                type: 1967
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1968
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 1
+                type: 1969
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1970
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 1
+                type: 1971
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1972
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 2112
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 2122
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 8
+                num_resource: 12
+                type: 12750
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 20
+                num_resource: 20
+                type: 12750
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 12751
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 12
+                type: 12769
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 12
+                num_resource: 20
+                type: 12769
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 12770
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 12810
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 22
+                num_resource: 18
+                type: 12810
+                host_id: 38
+                reserved: 0
+        -
+                start_resource: 1536
+                num_resource: 8
+                type: 12823
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2048
+                num_resource: 8
+                type: 12824
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 2560
+                num_resource: 8
+                type: 12825
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3072
+                num_resource: 32
+                type: 12826
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3584
+                num_resource: 32
+                type: 12827
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 32
+                type: 12828
+                host_id: 128
+                reserved: 0
-- 
2.25.1

