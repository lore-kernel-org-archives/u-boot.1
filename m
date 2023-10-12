Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51FCBCDB474
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 23:18:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5A5D686E2C;
	Fri, 13 Oct 2023 01:14:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="yusATIDz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3BD686AE6; Fri, 13 Oct 2023 01:09:40 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 82F6086E95
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 01:06:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=bb@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6Jdv034158;
 Thu, 12 Oct 2023 18:06:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1697151979;
 bh=wDpZTyxqfpGAFI8+gh2vYZOpjFctMGCVrd7JCSZGsoM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=yusATIDz9bYWACQfDe7nLQ+SRqNozHXFedS2Je3Bx8mRf4NcOgrnPOe8V/yFiIZHX
 akjcdrnbF4ECQZbBnofSni6qIhvwUuhi9s7eM2436tlSGyMtR9ytSVOHWjIqBQi7Yz
 059EmcWnryKOMfjgYIjrS+PjqR9rwCvupGtx/OKE=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 39CN6JkI062787
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 12 Oct 2023 18:06:19 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 12
 Oct 2023 18:06:19 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 12 Oct 2023 18:06:19 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 39CN6JqY032143;
 Thu, 12 Oct 2023 18:06:19 -0500
From: Bryan Brattlof <bb@ti.com>
To: Tom Rini <trini@konsulko.com>, Vignesh Raghavendra <vigneshr@ti.com>, Hari
 Nagalla <hnagalla@ti.com>, Lukasz Majewski <lukma@denx.de>, Sean Anderson
 <seanga2@gmail.com>, Jaehoon Chung <jh80.chung@samsung.com>
CC: UBoot Mailing List <u-boot@lists.denx.de>, Andrew Davis <afd@ti.com>,
 Nishanth Menon <nm@ti.com>, Bryan Brattlof <bb@ti.com>
Subject: [PATCH 06/11] board: ti: introduce basic board files for the am62px
 family
Date: Thu, 12 Oct 2023 18:06:23 -0500
Message-ID: <20231012230616.2101992-19-bb@ti.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231012230616.2101992-13-bb@ti.com>
References: <20231012230616.2101992-13-bb@ti.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=79053; i=bb@ti.com;
 h=from:subject; bh=LqMaHPmpP1KGRFl6544RzL4HpOJ4LZWKlQ977gW4mfE=;
 b=owNCWmg5MUFZJlNZKl1dzQAAZ3/////79jdtzdffmdnX+7zf3d+30na/vvc/67v96tnO/newA
 RsxRyaaA2oAAAAABoGgABoAABppoAAaNAAD1AAMmgAMah4o0aZqekejFDtQBpoaBpo0AADQ0DQa
 bUAADQAGg0PU0ZMTJpiMmgGjQZDQDQPUAyB6g2o09IHCaA0DTTJoxGQDRgTQaYQaaNAZNNAGJgj
 EAYIyANAAaAAyZAA0ADQAIEchaiXfl2K+hqqjhfoRbFrKUgZ8p0EIygcBj4sSAq/fnAAwTJkzkh
 JxO85ngFEaRGFCfwgLGuJz89Qc77oqOoIdm2jBlzLxQ8A4XvCuuxpJwQ8rN04/91ZBIeIcSE1iJ
 GxBmdD9PNxCdCo5gtgzAJe3X63SSxiL0DqFGa7jP5HjsrHmlXJWW8sE3sFVdn1KfvtJqT2ERfck
 lRP7WV7Zj27R9NYNOKE0VA+8O+lIx1CJKMe7PtYqTioBwbFKQEjrgfEMI5CMfklDSYR9tTEEPxR
 lbciGJGe0aHfrAzdE9pHgXKIOIFaFdJdJoVjoMBVt+Gp43EAQ6+LyT34O4Ll3rZhXvn9O4EoYGf
 wUDAz+gbi+MaAfTaozEbnyEnAMKHqnIDJYii3xFADJoCb+3jCQSlaP+1Yx0ZpWAWx+URpYgk6aB
 KLLN/4u5IpwoSBUurua
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
 arch/arm/mach-k3/Kconfig         |    1 +
 board/ti/am62px/Kconfig          |   52 ++
 board/ti/am62px/MAINTAINERS      |    9 +
 board/ti/am62px/Makefile         |    7 +
 board/ti/am62px/am62px.env       |   18 +
 board/ti/am62px/board-cfg.yaml   |   37 +
 board/ti/am62px/evm.c            |   30 +
 board/ti/am62px/pm-cfg.yaml      |   12 +
 board/ti/am62px/rm-cfg.yaml      | 1150 ++++++++++++++++++++++++++++++
 board/ti/am62px/sec-cfg.yaml     |  378 ++++++++++
 board/ti/am62px/tifs-rm-cfg.yaml | 1010 ++++++++++++++++++++++++++
 11 files changed, 2704 insertions(+)
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

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 5af567a24a2ba..26749acfaecd9 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -195,6 +195,7 @@ source "board/ti/am65x/Kconfig"
 source "board/ti/am64x/Kconfig"
 source "board/ti/am62x/Kconfig"
 source "board/ti/am62ax/Kconfig"
+source "board/ti/am62px/Kconfig"
 source "board/ti/j721e/Kconfig"
 source "board/siemens/iot2050/Kconfig"
 source "board/ti/j721s2/Kconfig"
diff --git a/board/ti/am62px/Kconfig b/board/ti/am62px/Kconfig
new file mode 100644
index 0000000000000..3ef1ff113ab00
--- /dev/null
+++ b/board/ti/am62px/Kconfig
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+choice
+	prompt "TI K3 AM62Px based boards"
+	optional
+
+config TARGET_AM62P5_A53_EVM
+	bool "TI K3 based AM62P5 EVM running on A53"
+	select ARM64
+	select BINMAN
+	imply BOARD
+	imply SPL_BOARD
+	imply TI_I2C_BOARD_DETECT
+
+config TARGET_AM62P5_R5_EVM
+	bool "TI K3 based AM62P5 EVM running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+	imply TI_I2C_BOARD_DETECT
+
+endchoice
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
index 0000000000000..a7ac6d0a588a8
--- /dev/null
+++ b/board/ti/am62px/am62px.env
@@ -0,0 +1,18 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/mmc.env>
+
+default_device_tree=ti/k3-am62p5-sk.dtb
+findfdt=
+	setenv name_fdt ${default_device_tree};
+	setenv fdtfile ${name_fdt}
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot=mmc
+mmcdev=1
+bootpart=1:2
+bootdir=/boot
+rd_spec=-
diff --git a/board/ti/am62px/board-cfg.yaml b/board/ti/am62px/board-cfg.yaml
new file mode 100644
index 0000000000000..de4a438c27826
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
+
diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
new file mode 100644
index 0000000000000..44793cbed6536
--- /dev/null
+++ b/board/ti/am62px/evm.c
@@ -0,0 +1,30 @@
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
+#include <common.h>
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
index 0000000000000..59f31f6090c4e
--- /dev/null
+++ b/board/ti/am62px/rm-cfg.yaml
@@ -0,0 +1,1150 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62Px
+#
+---
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
+            resasg_entries_size: 1032
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 64
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 64
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 4
+                type: 64
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 20
+                num_resource: 22
+                type: 64
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 16
+                type: 192
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 34
+                num_resource: 2
+                type: 192
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 4
+                type: 320
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 4
+                num_resource: 4
+                type: 320
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 26
+                type: 384
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 50176
+                num_resource: 164
+                type: 1666
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 1667
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1677
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1677
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1677
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 54
+                num_resource: 18
+                type: 1678
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 72
+                num_resource: 6
+                type: 1678
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 72
+                num_resource: 6
+                type: 1678
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 78
+                num_resource: 2
+                type: 1678
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 1678
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 32
+                num_resource: 12
+                type: 1679
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 50
+                num_resource: 2
+                type: 1679
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 52
+                num_resource: 2
+                type: 1679
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1696
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1696
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1696
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1697
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1697
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1697
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1697
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 26
+                num_resource: 2
+                type: 1697
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 12
+                type: 1698
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 1698
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 20
+                num_resource: 2
+                type: 1698
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 6
+                num_resource: 34
+                type: 1802
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 36
+                type: 1802
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 36
+                type: 1802
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 168
+                num_resource: 8
+                type: 1802
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 14
+                num_resource: 512
+                type: 1805
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 526
+                num_resource: 256
+                type: 1805
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 526
+                num_resource: 256
+                type: 1805
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 782
+                num_resource: 128
+                type: 1805
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 910
+                num_resource: 626
+                type: 1805
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 1024
+                type: 1807
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 4096
+                num_resource: 29
+                type: 1808
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 4608
+                num_resource: 99
+                type: 1809
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 5120
+                num_resource: 24
+                type: 1810
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 5632
+                num_resource: 51
+                type: 1811
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 6144
+                num_resource: 51
+                type: 1812
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 6656
+                num_resource: 51
+                type: 1813
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 8192
+                num_resource: 32
+                type: 1814
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 8704
+                num_resource: 32
+                type: 1815
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 9216
+                num_resource: 32
+                type: 1816
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 9728
+                num_resource: 22
+                type: 1817
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 10240
+                num_resource: 22
+                type: 1818
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 10752
+                num_resource: 22
+                type: 1819
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 11264
+                num_resource: 28
+                type: 1820
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 11776
+                num_resource: 28
+                type: 1821
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 12288
+                num_resource: 28
+                type: 1822
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 1923
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1936
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1936
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1936
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 64
+                type: 1937
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 64
+                type: 1937
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 83
+                num_resource: 8
+                type: 1938
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 91
+                num_resource: 8
+                type: 1939
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 99
+                num_resource: 10
+                type: 1942
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 112
+                num_resource: 3
+                type: 1942
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 115
+                num_resource: 3
+                type: 1942
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 118
+                num_resource: 16
+                type: 1943
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 118
+                num_resource: 16
+                type: 1943
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1944
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1945
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1946
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1947
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1955
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1955
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1955
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 8
+                type: 1956
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 8
+                type: 1956
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 27
+                num_resource: 1
+                type: 1957
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 1958
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1961
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1961
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1961
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1962
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1962
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1962
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 16
+                type: 1964
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 16
+                type: 1964
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 1965
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1966
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 21
+                num_resource: 1
+                type: 1967
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1968
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 22
+                num_resource: 1
+                type: 1969
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1970
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 23
+                num_resource: 1
+                type: 1971
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1972
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 2112
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 2122
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 51200
+                num_resource: 12
+                type: 12738
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 12739
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 6
+                type: 12750
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 6
+                type: 12769
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 12810
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 12288
+                num_resource: 128
+                type: 12813
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 3072
+                num_resource: 6
+                type: 12828
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 3584
+                num_resource: 6
+                type: 12829
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 4096
+                num_resource: 6
+                type: 12830
+                host_id: 128
+                reserved: 0
diff --git a/board/ti/am62px/sec-cfg.yaml b/board/ti/am62px/sec-cfg.yaml
new file mode 100644
index 0000000000000..9a6e52136d1c5
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
index 0000000000000..f2ec18efc980c
--- /dev/null
+++ b/board/ti/am62px/tifs-rm-cfg.yaml
@@ -0,0 +1,1010 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62Px
+#
+---
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
+            resasg_entries_size: 872
+            reserved: 0
+    resasg_entries:
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1677
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1677
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1677
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1677
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 54
+                num_resource: 18
+                type: 1678
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 72
+                num_resource: 6
+                type: 1678
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 72
+                num_resource: 6
+                type: 1678
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 78
+                num_resource: 2
+                type: 1678
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 80
+                num_resource: 2
+                type: 1678
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 32
+                num_resource: 12
+                type: 1679
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 6
+                type: 1679
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 50
+                num_resource: 2
+                type: 1679
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 52
+                num_resource: 2
+                type: 1679
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1696
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1696
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1696
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 26
+                num_resource: 6
+                type: 1696
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 18
+                type: 1697
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1697
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 6
+                type: 1697
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 24
+                num_resource: 2
+                type: 1697
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 26
+                num_resource: 2
+                type: 1697
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 12
+                type: 1698
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 12
+                num_resource: 6
+                type: 1698
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 18
+                num_resource: 2
+                type: 1698
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 20
+                num_resource: 2
+                type: 1698
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 6
+                num_resource: 34
+                type: 1802
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 36
+                type: 1802
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 44
+                num_resource: 36
+                type: 1802
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 168
+                num_resource: 8
+                type: 1802
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 1024
+                type: 1807
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 4096
+                num_resource: 29
+                type: 1808
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 4608
+                num_resource: 99
+                type: 1809
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 5120
+                num_resource: 24
+                type: 1810
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 5632
+                num_resource: 51
+                type: 1811
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 6144
+                num_resource: 51
+                type: 1812
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 6656
+                num_resource: 51
+                type: 1813
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 8192
+                num_resource: 32
+                type: 1814
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 8704
+                num_resource: 32
+                type: 1815
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 9216
+                num_resource: 32
+                type: 1816
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 9728
+                num_resource: 22
+                type: 1817
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 10240
+                num_resource: 22
+                type: 1818
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 10752
+                num_resource: 22
+                type: 1819
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 11264
+                num_resource: 28
+                type: 1820
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 11776
+                num_resource: 28
+                type: 1821
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 12288
+                num_resource: 28
+                type: 1822
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1936
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1936
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1936
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1936
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 64
+                type: 1937
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 64
+                type: 1937
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 83
+                num_resource: 8
+                type: 1938
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 91
+                num_resource: 8
+                type: 1939
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 99
+                num_resource: 10
+                type: 1942
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 109
+                num_resource: 3
+                type: 1942
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 112
+                num_resource: 3
+                type: 1942
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 115
+                num_resource: 3
+                type: 1942
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 118
+                num_resource: 16
+                type: 1943
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 118
+                num_resource: 16
+                type: 1943
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1944
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 134
+                num_resource: 8
+                type: 1945
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1946
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 142
+                num_resource: 8
+                type: 1947
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1955
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1955
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1955
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1955
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 8
+                type: 1956
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 8
+                type: 1956
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 27
+                num_resource: 1
+                type: 1957
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 28
+                num_resource: 1
+                type: 1958
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1961
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1961
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1961
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1961
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 10
+                type: 1962
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 10
+                num_resource: 3
+                type: 1962
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 13
+                num_resource: 3
+                type: 1962
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 16
+                num_resource: 3
+                type: 1962
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 1
+                type: 1963
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 16
+                type: 1964
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 19
+                num_resource: 16
+                type: 1964
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 20
+                num_resource: 1
+                type: 1965
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1966
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 21
+                num_resource: 1
+                type: 1967
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 35
+                num_resource: 8
+                type: 1968
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 22
+                num_resource: 1
+                type: 1969
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1970
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 23
+                num_resource: 1
+                type: 1971
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 43
+                num_resource: 8
+                type: 1972
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 1
+                type: 2112
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 2
+                num_resource: 2
+                type: 2122
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 6
+                type: 12750
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 6
+                type: 12769
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 0
+                num_resource: 8
+                type: 12810
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 3072
+                num_resource: 6
+                type: 12828
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 3584
+                num_resource: 6
+                type: 12829
+                host_id: 128
+                reserved: 0
+
+        -
+                start_resource: 4096
+                num_resource: 6
+                type: 12830
+                host_id: 128
+                reserved: 0
-- 
2.42.0

