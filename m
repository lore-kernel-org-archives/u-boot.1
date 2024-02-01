Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F3E5C47DB3
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 03:08:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3B7E87CE3;
	Thu,  1 Feb 2024 04:06:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OrXXMjir";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242F787D04; Thu,  1 Feb 2024 04:06:57 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A618C87CEA
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 04:06:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41136bSD082263;
 Wed, 31 Jan 2024 21:06:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1706756797;
 bh=+gM/Y13TKXejUmN2WP6I9HjiHHhtIiQ2+28QfAImq38=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OrXXMjircTOVf6NQKFf1RlPuLlXi2o1VJp2qARdsjWMry05KhzoL0TI2rxmC+xMCE
 l8W+A3I92HvgGkyg3PTbhfg6bLjnXH+NaYAHH+1Zau1TkdoVgCvSE7t3jPf7BsSweL
 Y+JMzbtEJCfzB/bOKPTeZ9IHN43ECVD6pitEEoIY=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41136bHh013797
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 31 Jan 2024 21:06:37 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 31
 Jan 2024 21:06:37 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 31 Jan 2024 21:06:37 -0600
Received: from localhost (bb.dhcp.ti.com [128.247.81.12])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41136b1i043584;
 Wed, 31 Jan 2024 21:06:37 -0600
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>
CC: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Nishanth Menon <nm@ti.com>,
 Andrew Davis <afd@ti.com>, Neha Malcom Francis <n-francis@ti.com>,
 UBoot Mailing List <u-boot@lists.denx.de>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH v2 07/13] board: ti: introduce basic board files for the
 am62px family
Date: Wed, 31 Jan 2024 21:06:43 -0600
Message-ID: <20240201030634.1120963-24-bb@ti.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201030634.1120963-16-bb@ti.com>
References: <20240201030634.1120963-16-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=73291; i=bb@ti.com;
 h=from:subject; bh=JHWqmMjlyOq1Kr+SVpBGJpk7cdR6V0WJWC/cmxBvS1M=;
 b=owNCWmg5MUFZJlNZlbYW6gAAZf///7/pS3f5mJ6x6dzmu9rW5fl+X23zj3fdX73fv/vT6X+wA
 RswHagADT1AAPJqNAaeoDTTQAaNAAAaaDQNGmhoeoHqADQNG1MhtTTR6mmho0wnppEBoaZAaMmh
 po0MJkZGmhtIyaZGhkYNTCZNMmgNABoDEGjQ0aGgGmhiMmg00MgcmamJ6hpkAZBiNNGQ0GBDQ0Y
 hhGgZAGgAAGjIGCDTTRoZGjIyGjTI0wQAArgaa0BEwsQQMlRuKWKEBHNy2AJC/mxgTSL3XeFzFf
 CrT1k/Ruzlf6Bavy9sqyH0EdbA0qmGAsefacNdZxMgD69q2fGPg/E0KgpLGvVkg7TBzxP0rc0o9
 QwZr0Yycc36aE1Nt+73wtb0ggIKOQIQ3vI4dk+MLjMWYDdrp5twwNu4GWCFylDJ7OyT+oRL6sot
 IIPZNvsxiux2bKGZCiR2wiOrQz80+IVjs+zYIUxHBG9QdDajEMRSnXSwjOWbJqpbzl4nMrxhEaw
 leaZSfc4W9rQEdu7AMvcXIDPeQV09MxkvynKJ+PQo1fm7xMNiA3yf2KJFn9VvM7wUiHEc6E6jW4
 dgIA8a+v0Y1e3KkDKHMCLbYKBW/BQKUpA02f0sCeJbo/5wgVRSoEhwQbSLgXJpSQoF63QBw48Ls
 XZh5WY8Tqf8XckU4UJCVthbqA==
X-Developer-Key: i=bb@ti.com; a=openpgp;
 fpr=D3D177E40A38DF4D1853FEEF41B90D5D71D56CE0
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

Introduce the basic files needed to support the am62px family of SoCs

Co-developed-by: Hari Hagalla <hnagalla@ti.com>
Signed-off-by: Hari Hagalla <hnagalla@ti.com>
Signed-off-by: Bryan Brattlof <bb@ti.com>
---
 board/ti/am62px/Kconfig          |  26 +
 board/ti/am62px/MAINTAINERS      |   9 +
 board/ti/am62px/Makefile         |   7 +
 board/ti/am62px/am62px.env       |  16 +
 board/ti/am62px/board-cfg.yaml   |  37 ++
 board/ti/am62px/evm.c            |  29 +
 board/ti/am62px/pm-cfg.yaml      |  12 +
 board/ti/am62px/rm-cfg.yaml      | 987 +++++++++++++++++++++++++++++++
 board/ti/am62px/sec-cfg.yaml     | 378 ++++++++++++
 board/ti/am62px/tifs-rm-cfg.yaml | 879 +++++++++++++++++++++++++++
 10 files changed, 2380 insertions(+)
 create mode 100644 board/ti/am62px/Kconfig
 create mode 100644 board/ti/am62px/MAINTAINERS
 create mode 100644 board/ti/am62px/Makefile
 create mode 100644 board/ti/am62px/am62px.env
 create mode 100644 board/ti/am62px/board-cfg.yaml
 create mode 100644 board/ti/am62px/evm.c
 create mode 100644 board/ti/am62px/pm-cfg.yaml
 create mode 100644 board/ti/am62px/rm-cfg.yaml
 create mode 100644 board/ti/am62px/sec-cfg.yaml
 create mode 100644 board/ti/am62px/tifs-rm-cfg.yaml

diff --git a/board/ti/am62px/Kconfig b/board/ti/am62px/Kconfig
new file mode 100644
index 0000000000000..9d95ffd9b2908
--- /dev/null
+++ b/board/ti/am62px/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if TARGET_AM62P5_R5_EVM || TARGET_AM62P5_A53_EVM
+
+config SYS_BOARD
+       default "am62px"
+
+config SYS_VENDOR
+       default "ti"
+
+config SYS_CONFIG_NAME
+       default "am62px_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_AM62P5_R5_EVM
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+endif
diff --git a/board/ti/am62px/MAINTAINERS b/board/ti/am62px/MAINTAINERS
new file mode 100644
index 0000000000000..57c86ddbc4aef
--- /dev/null
+++ b/board/ti/am62px/MAINTAINERS
@@ -0,0 +1,9 @@
+AM62Px BOARD
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+M:	Bryan Brattlof <bb@ti.com>
+M:	Tom Rini <trini@konsulko.com>
+S:	Maintained
+F:	board/ti/am62px/
+F:	include/configs/am62p5_evm.h
+F:	configs/am62px_evm_r5_defconfig
+F:	configs/am62px_evm_a53_defconfig
diff --git a/board/ti/am62px/Makefile b/board/ti/am62px/Makefile
new file mode 100644
index 0000000000000..921afdff27a24
--- /dev/null
+++ b/board/ti/am62px/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/am62px/am62px.env b/board/ti/am62px/am62px.env
new file mode 100644
index 0000000000000..e982c8104c192
--- /dev/null
+++ b/board/ti/am62px/am62px.env
@@ -0,0 +1,16 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/default_findfdt.env>
+#include <env/ti/mmc.env>
+
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot_targets=mmc1 pxe dhcp
+boot=mmc
+mmcdev=1
+bootpart=1:2
+bootdir=/boot
+rd_spec=-
diff --git a/board/ti/am62px/board-cfg.yaml b/board/ti/am62px/board-cfg.yaml
new file mode 100644
index 0000000000000..d539011aff9f3
--- /dev/null
+++ b/board/ti/am62px/board-cfg.yaml
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for AM62Px SoCs
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
+        msmc_cache_size: 0x10
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables: 0x00
+        trace_src_enables: 0x00
diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
new file mode 100644
index 0000000000000..97a95ce8cc2d5
--- /dev/null
+++ b/board/ti/am62px/evm.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for AM62Px platforms
+ *
+ * Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
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
diff --git a/board/ti/am62px/pm-cfg.yaml b/board/ti/am62px/pm-cfg.yaml
new file mode 100644
index 0000000000000..3ff27ce702c26
--- /dev/null
+++ b/board/ti/am62px/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for AM62Px
+#
+#
+---
+pm-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
diff --git a/board/ti/am62px/rm-cfg.yaml b/board/ti/am62px/rm-cfg.yaml
new file mode 100644
index 0000000000000..caa2f7a5a83e1
--- /dev/null
+++ b/board/ti/am62px/rm-cfg.yaml
@@ -0,0 +1,987 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62P
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
+                -  # 1
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                -  # 4
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 7
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 8
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 9
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 10
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 11
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 12
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 13
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 14
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 15
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 16
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 17
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 18
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 19
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 20
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 21
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 22
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 23
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 24
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 25
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 26
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 27
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 28
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 29
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 30
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 31
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                -  # 32
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
+            resasg_entries_size: 984
+            reserved: 0
+    resasg_entries:
+        -
+            start_resource: 0
+            num_resource: 16
+            type: 192
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 34
+            num_resource: 2
+            type: 192
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 2
+            type: 320
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 2
+            num_resource: 2
+            type: 320
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 4
+            num_resource: 4
+            type: 320
+            host_id: 30
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
+            num_resource: 18
+            type: 1677
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1677
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1677
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1677
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 57
+            num_resource: 18
+            type: 1678
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 75
+            num_resource: 5
+            type: 1678
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 80
+            num_resource: 2
+            type: 1678
+            host_id: 30
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
+            host_id: 35
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
+            num_resource: 5
+            type: 1679
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1696
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 6
+            type: 1696
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 24
+            num_resource: 2
+            type: 1696
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 26
+            num_resource: 6
+            type: 1696
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 18
+            type: 1697
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 18
+            num_resource: 5
+            type: 1697
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 23
+            num_resource: 2
+            type: 1697
+            host_id: 30
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
+            host_id: 35
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
+            num_resource: 5
+            type: 1698
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 5
+            num_resource: 35
+            type: 1802
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 45
+            num_resource: 35
+            type: 1802
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 45
+            num_resource: 35
+            type: 1802
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 168
+            num_resource: 8
+            type: 1802
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 14
+            num_resource: 512
+            type: 1805
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 526
+            num_resource: 256
+            type: 1805
+            host_id: 35
+            reserved: 0
+        -
+            start_resource: 526
+            num_resource: 256
+            type: 1805
+            host_id: 36
+            reserved: 0
+        -
+            start_resource: 782
+            num_resource: 128
+            type: 1805
+            host_id: 30
+            reserved: 0
+        -
+            start_resource: 910
+            num_resource: 626
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
+            host_id: 128
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
+            host_id: 128
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
+            host_id: 128
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
+            host_id: 128
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
+            host_id: 128
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
+            num_resource: 12
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
+            start_resource: 0
+            num_resource: 6
+            type: 12750
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 6
+            type: 12769
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 0
+            num_resource: 8
+            type: 12810
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 12288
+            num_resource: 128
+            type: 12813
+            host_id: 12
+            reserved: 0
+        -
+            start_resource: 3072
+            num_resource: 6
+            type: 12826
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 3584
+            num_resource: 6
+            type: 12827
+            host_id: 128
+            reserved: 0
+        -
+            start_resource: 4096
+            num_resource: 6
+            type: 12828
+            host_id: 128
+            reserved: 0
diff --git a/board/ti/am62px/sec-cfg.yaml b/board/ti/am62px/sec-cfg.yaml
new file mode 100644
index 0000000000000..46be354972afc
--- /dev/null
+++ b/board/ti/am62px/sec-cfg.yaml
@@ -0,0 +1,378 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security configuration for AM62Px
+#
+---
+sec-cfg:
+    rev:
+        boardcfg_abi_maj: 0x0
+        boardcfg_abi_min: 0x1
+    processor_acl_list:
+        subhdr:
+            magic: 0xF1EA
+            size: 164
+        proc_acl_entries:
+            -  # 1
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 2
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 3
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 4
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 5
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 6
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 7
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 8
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 9
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 10
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 11
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 12
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 13
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 14
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 15
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 16
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 17
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 18
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 19
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 20
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 21
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 22
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 23
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 24
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 25
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 26
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 27
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 28
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 29
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 30
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 31
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+            -  # 32
+                processor_id: 0
+                proc_access_master: 0
+                proc_access_secondary: [0, 0, 0]
+    host_hierarchy:
+        subhdr:
+            magic: 0x8D27
+            size: 68
+        host_hierarchy_entries:
+            -  # 1
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 2
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 3
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 4
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 5
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 6
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 7
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 8
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 9
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 10
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 11
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 12
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 13
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 14
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 15
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 16
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 17
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 18
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 19
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 20
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 21
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 22
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 23
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 24
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 25
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 26
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 27
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 28
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 29
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 30
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 31
+                host_id: 0
+                supervisor_host_id: 0
+            -  # 32
+                host_id: 0
+                supervisor_host_id: 0
+    otp_config:
+        subhdr:
+            magic: 0x4081
+            size: 69
+        write_host_id: 0
+        otp_entry:
+            -  # 1
+                host_id: 0
+                host_perms: 0
+            -  # 2
+                host_id: 0
+                host_perms: 0
+            -  # 3
+                host_id: 0
+                host_perms: 0
+            -  # 4
+                host_id: 0
+                host_perms: 0
+            -  # 5
+                host_id: 0
+                host_perms: 0
+            -  # 6
+                host_id: 0
+                host_perms: 0
+            -  # 7
+                host_id: 0
+                host_perms: 0
+            -  # 8
+                host_id: 0
+                host_perms: 0
+            -  # 9
+                host_id: 0
+                host_perms: 0
+            -  # 10
+                host_id: 0
+                host_perms: 0
+            -  # 11
+                host_id: 0
+                host_perms: 0
+            -  # 12
+                host_id: 0
+                host_perms: 0
+            -  # 13
+                host_id: 0
+                host_perms: 0
+            -  # 14
+                host_id: 0
+                host_perms: 0
+            -  # 15
+                host_id: 0
+                host_perms: 0
+            -  # 16
+                host_id: 0
+                host_perms: 0
+            -  # 17
+                host_id: 0
+                host_perms: 0
+            -  # 18
+                host_id: 0
+                host_perms: 0
+            -  # 19
+                host_id: 0
+                host_perms: 0
+            -  # 20
+                host_id: 0
+                host_perms: 0
+            -  # 21
+                host_id: 0
+                host_perms: 0
+            -  # 22
+                host_id: 0
+                host_perms: 0
+            -  # 23
+                host_id: 0
+                host_perms: 0
+            -  # 24
+                host_id: 0
+                host_perms: 0
+            -  # 25
+                host_id: 0
+                host_perms: 0
+            -  # 26
+                host_id: 0
+                host_perms: 0
+            -  # 27
+                host_id: 0
+                host_perms: 0
+            -  # 28
+                host_id: 0
+                host_perms: 0
+            -  # 29
+                host_id: 0
+                host_perms: 0
+            -  # 30
+                host_id: 0
+                host_perms: 0
+            -  # 31
+                host_id: 0
+                host_perms: 0
+            -  # 32
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
diff --git a/board/ti/am62px/tifs-rm-cfg.yaml b/board/ti/am62px/tifs-rm-cfg.yaml
new file mode 100644
index 0000000000000..a80a275046716
--- /dev/null
+++ b/board/ti/am62px/tifs-rm-cfg.yaml
@@ -0,0 +1,879 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62P
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
+                    host_id: 12
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #2
+                    host_id: 30
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #3
+                    host_id: 36
+                    allowed_atype: 0x2A
+                    allowed_qos: 0xAAAA
+                    allowed_orderid: 0xAAAAAAAA
+                    allowed_priority: 0xAAAA
+                    allowed_sched_priority: 0xAA
+                - #4
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #5
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
+                - #6
+                    host_id: 0
+                    allowed_atype: 0
+                    allowed_qos: 0
+                    allowed_orderid: 0
+                    allowed_priority: 0
+                    allowed_sched_priority: 0
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
+            resasg_entries_size: 840
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1677
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1677
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1677
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 57
+                num_resource: 18
+                type: 1678
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 75
+                num_resource: 5
+                type: 1678
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 75
+                num_resource: 5
+                type: 1678
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 1678
+                host_id: 30
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
+                host_id: 35
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
+                num_resource: 5
+                type: 1679
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1696
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1696
+                host_id: 30
+                reserved: 0
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1696
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1697
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 5
+                type: 1697
+                host_id: 35
+                reserved: 0
+        -
+                start_resource: 18
+                num_resource: 5
+                type: 1697
+                host_id: 36
+                reserved: 0
+        -
+                start_resource: 23
+                num_resource: 2
+                type: 1697
+                host_id: 30
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
+                host_id: 35
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
+                num_resource: 5
+                type: 1698
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 5
+                num_resource: 35
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
+                start_resource: 168
+                num_resource: 8
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
+                host_id: 128
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
+                host_id: 128
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
+                host_id: 128
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
+                host_id: 128
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
+                host_id: 128
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
+                start_resource: 0
+                num_resource: 6
+                type: 12750
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 6
+                type: 12769
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 12810
+                host_id: 12
+                reserved: 0
+        -
+                start_resource: 3072
+                num_resource: 6
+                type: 12826
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 3584
+                num_resource: 6
+                type: 12827
+                host_id: 128
+                reserved: 0
+        -
+                start_resource: 4096
+                num_resource: 6
+                type: 12828
+                host_id: 128
+                reserved: 0
-- 
2.43.0

