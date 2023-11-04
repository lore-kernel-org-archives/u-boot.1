Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A9BC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 08:04:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 04C8087518;
	Sat,  4 Nov 2023 09:02:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="i68CwFuf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E94BF870F8; Sat,  4 Nov 2023 09:02:17 +0100 (CET)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 720D2870FC
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:01:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gYb019485;
 Sat, 4 Nov 2023 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699084902;
 bh=2eMA9dI1m9rW/Sn0vQ9aQyL5gjObrHVW4u2v4aBV4Mw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=i68CwFufF49JiovIztVtcd6EHFMw1rxcRrJXHxZ2DdEEvZhaI6cyOrq6uC1cpUrhE
 WS1+bDE4nXVPXQ+lJJ9incaKHUJtQ6tfVOsEH8Y66hrdFzTAbBwBAmVHgUpCUOrHD/
 Uo7v5HrbgabAGO18XBml2smqkp22Ihm+gg6MYlB8=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A481gqD025400
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:01:42 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:01:42 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:01:42 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A481gMj018705;
 Sat, 4 Nov 2023 03:01:42 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>, <bb@ti.com>, <praneeth@ti.com>
Subject: [PATCH 3/5] board: Move beagleplay under beagle vendor folder
Date: Sat, 4 Nov 2023 03:01:35 -0500
Message-ID: <20231104080137.9628-4-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104080137.9628-1-nm@ti.com>
References: <20231104080137.9628-1-nm@ti.com>
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

Move beagleplay support away from ti/am62x to it's own beagle vendor
folder.

This forms the starting point for new beagle platforms added under it's
own board vendor folder.

As part of this create all the associated files with a bare minimum
beagleplay.c file.

Suggested-by: Andrew Davis <afd@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/Kconfig                      |    1 +
 board/beagle/beagleplay/Kconfig               |   60 +
 board/beagle/beagleplay/MAINTAINERS           |    6 +
 board/beagle/beagleplay/Makefile              |    9 +
 board/beagle/beagleplay/beagleplay.c          |   29 +
 .../beagleplay}/beagleplay.env                |    0
 board/beagle/beagleplay/board-cfg.yaml        |   36 +
 board/beagle/beagleplay/pm-cfg.yaml           |   12 +
 board/beagle/beagleplay/rm-cfg.yaml           | 1088 +++++++++++++++++
 board/beagle/beagleplay/sec-cfg.yaml          |  379 ++++++
 board/ti/am62x/MAINTAINERS                    |    7 -
 configs/am62x_beagleplay_a53_defconfig        |    3 +-
 configs/am62x_beagleplay_r5_defconfig         |    3 +-
 13 files changed, 1622 insertions(+), 11 deletions(-)
 create mode 100644 board/beagle/beagleplay/Kconfig
 create mode 100644 board/beagle/beagleplay/MAINTAINERS
 create mode 100644 board/beagle/beagleplay/Makefile
 create mode 100644 board/beagle/beagleplay/beagleplay.c
 rename board/{ti/am62x => beagle/beagleplay}/beagleplay.env (100%)
 create mode 100644 board/beagle/beagleplay/board-cfg.yaml
 create mode 100644 board/beagle/beagleplay/pm-cfg.yaml
 create mode 100644 board/beagle/beagleplay/rm-cfg.yaml
 create mode 100644 board/beagle/beagleplay/sec-cfg.yaml

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 57e2dd966eb8..666394b5cfde 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -200,4 +200,5 @@ source "board/ti/j721e/Kconfig"
 source "board/siemens/iot2050/Kconfig"
 source "board/ti/j721s2/Kconfig"
 source "board/toradex/verdin-am62/Kconfig"
+source "board/beagle/beagleplay/Kconfig"
 endif
diff --git a/board/beagle/beagleplay/Kconfig b/board/beagle/beagleplay/Kconfig
new file mode 100644
index 000000000000..7dbd833acb4c
--- /dev/null
+++ b/board/beagle/beagleplay/Kconfig
@@ -0,0 +1,60 @@
+# SPDX-License-Identifier:     GPL-2.0+
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+#
+
+choice
+	prompt "BeagleBoard.org AM625 based BeaglePlay board"
+	optional
+
+config TARGET_AM625_A53_BEAGLEPLAY
+	bool "BeagleBoard.org AM625 BeaglePlay running on A53"
+	select ARM64
+	select BINMAN
+
+config TARGET_AM625_R5_BEAGLEPLAY
+	bool "BeagleBoard.org AM625 BeaglePlay running on R5"
+	select CPU_V7R
+	select SYS_THUMB_BUILD
+	select K3_LOAD_SYSFW
+	select RAM
+	select SPL_RAM
+	select K3_DDRSS
+	select BINMAN
+	imply SYS_K3_SPL_ATF
+
+endchoice
+
+if TARGET_AM625_A53_BEAGLEPLAY
+
+config SYS_BOARD
+       default "beagleplay"
+
+config SYS_VENDOR
+       default "beagle"
+
+config SYS_CONFIG_NAME
+       default "am62x_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_AM625_R5_BEAGLEPLAY
+
+config SYS_BOARD
+       default "beagleplay"
+
+config SYS_VENDOR
+       default "beagle"
+
+config SYS_CONFIG_NAME
+       default "am62x_evm"
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/beagle/beagleplay/MAINTAINERS b/board/beagle/beagleplay/MAINTAINERS
new file mode 100644
index 000000000000..eed996a23ddb
--- /dev/null
+++ b/board/beagle/beagleplay/MAINTAINERS
@@ -0,0 +1,6 @@
+BEAGLEPLAY BOARD
+M:     Nishanth Menon <nm@ti.com>
+M:     Robert Nelson <robertcnelson@gmail.com>
+M:     Tom Rini <trini@konsulko.com>
+S:     Maintained
+N:     beagleplay
diff --git a/board/beagle/beagleplay/Makefile b/board/beagle/beagleplay/Makefile
new file mode 100644
index 000000000000..b7a3cdb24514
--- /dev/null
+++ b/board/beagle/beagleplay/Makefile
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier:     GPL-2.0+
+#
+# https://beagleboard.org/play
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+#
+
+obj-y	+= beagleplay.o
diff --git a/board/beagle/beagleplay/beagleplay.c b/board/beagle/beagleplay/beagleplay.c
new file mode 100644
index 000000000000..1c376dea372f
--- /dev/null
+++ b/board/beagle/beagleplay/beagleplay.c
@@ -0,0 +1,29 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * https://beagleplay.org/
+ *
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+ */
+
+#include <cpu_func.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
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
+	return fdtdec_setup_mem_size_base();
+}
+
+int dram_init_banksize(void)
+{
+	return fdtdec_setup_memory_banksize();
+}
diff --git a/board/ti/am62x/beagleplay.env b/board/beagle/beagleplay/beagleplay.env
similarity index 100%
rename from board/ti/am62x/beagleplay.env
rename to board/beagle/beagleplay/beagleplay.env
diff --git a/board/beagle/beagleplay/board-cfg.yaml b/board/beagle/beagleplay/board-cfg.yaml
new file mode 100644
index 000000000000..36cfb550adf9
--- /dev/null
+++ b/board/beagle/beagleplay/board-cfg.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for AM62
+#
+
+---
+
+board-cfg:
+    rev:
+        boardcfg_abi_maj : 0x0
+        boardcfg_abi_min : 0x1
+    control:
+        subhdr:
+            magic: 0xC1D3
+            size: 7
+        main_isolation_enable : 0x5A
+        main_isolation_hostid : 0x2
+    secproxy:
+        subhdr:
+            magic: 0x1207
+            size: 7
+        scaling_factor : 0x1
+        scaling_profile : 0x1
+        disable_main_nav_secure_proxy : 0
+    msmc:
+        subhdr:
+            magic: 0xA5C3
+            size: 5
+        msmc_cache_size : 0x0
+    debug_cfg:
+        subhdr:
+            magic: 0x020C
+            size: 8
+        trace_dst_enables : 0x00
+        trace_src_enables : 0x00
diff --git a/board/beagle/beagleplay/pm-cfg.yaml b/board/beagle/beagleplay/pm-cfg.yaml
new file mode 100644
index 000000000000..5d04cf82ef77
--- /dev/null
+++ b/board/beagle/beagleplay/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for AM62
+#
+
+---
+
+pm-cfg:
+    rev:
+        boardcfg_abi_maj : 0x0
+        boardcfg_abi_min : 0x1
diff --git a/board/beagle/beagleplay/rm-cfg.yaml b/board/beagle/beagleplay/rm-cfg.yaml
new file mode 100644
index 000000000000..c28707be8e2a
--- /dev/null
+++ b/board/beagle/beagleplay/rm-cfg.yaml
@@ -0,0 +1,1088 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for AM62
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
+                    host_id: 12
+                    allowed_atype : 0x2A
+                    allowed_qos : 0xAAAA
+                    allowed_orderid : 0xAAAAAAAA
+                    allowed_priority : 0xAAAA
+                    allowed_sched_priority : 0xAA
+                - #2
+                    host_id: 30
+                    allowed_atype : 0x2A
+                    allowed_qos : 0xAAAA
+                    allowed_orderid : 0xAAAAAAAA
+                    allowed_priority : 0xAAAA
+                    allowed_sched_priority : 0xAA
+                - #3
+                    host_id: 36
+                    allowed_atype : 0x2A
+                    allowed_qos : 0xAAAA
+                    allowed_orderid : 0xAAAAAAAA
+                    allowed_priority : 0xAAAA
+                    allowed_sched_priority : 0xAA
+                - #4
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #5
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #6
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #7
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #8
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #9
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #10
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #11
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #12
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #13
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #14
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #15
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #16
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #17
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #18
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #19
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #20
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #21
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #22
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #23
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #24
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #25
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #26
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #27
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #28
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #29
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #30
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #31
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+                - #32
+                    host_id: 0
+                    allowed_atype : 0
+                    allowed_qos : 0
+                    allowed_orderid : 0
+                    allowed_priority : 0
+                    allowed_sched_priority : 0
+        resasg:
+            subhdr:
+                magic: 0x7B25
+                size : 8
+            resasg_entries_size: 960
+            reserved : 0
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
+                start_resource: 5
+                num_resource: 35
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
+                start_resource: 13
+                num_resource: 512
+                type: 1805
+                host_id: 12
+                reserved: 0
+
+        -
+                start_resource: 525
+                num_resource: 256
+                type: 1805
+                host_id: 35
+                reserved: 0
+
+        -
+                start_resource: 525
+                num_resource: 256
+                type: 1805
+                host_id: 36
+                reserved: 0
+
+        -
+                start_resource: 781
+                num_resource: 128
+                type: 1805
+                host_id: 30
+                reserved: 0
+
+        -
+                start_resource: 909
+                num_resource: 627
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
+                host_id: 36
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
+                host_id: 36
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
+                host_id: 36
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
+                host_id: 36
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
+                host_id: 36
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
diff --git a/board/beagle/beagleplay/sec-cfg.yaml b/board/beagle/beagleplay/sec-cfg.yaml
new file mode 100644
index 000000000000..07081ce06ca0
--- /dev/null
+++ b/board/beagle/beagleplay/sec-cfg.yaml
@@ -0,0 +1,379 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security management configuration for AM62
+#
+
+---
+
+sec-cfg:
+    rev:
+        boardcfg_abi_maj : 0x0
+        boardcfg_abi_min : 0x1
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
+        write_host_id : 0
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
+        enable_saul_psil_global_config_writes: 0x5A
+        rsvd: [0, 0]
+    sec_dbg_config:
+        subhdr:
+            magic: 0x42AF
+            size: 16
+        allow_jtag_unlock : 0x5A
+        allow_wildcard_unlock : 0x5A
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
diff --git a/board/ti/am62x/MAINTAINERS b/board/ti/am62x/MAINTAINERS
index 6ac4e65f5afc..105e741995ed 100644
--- a/board/ti/am62x/MAINTAINERS
+++ b/board/ti/am62x/MAINTAINERS
@@ -6,10 +6,3 @@ F:	board/ti/am62x/
 F:	include/configs/am62x_evm.h
 F:	configs/am62x_evm_r5_defconfig
 F:	configs/am62x_evm_a53_defconfig
-
-BEAGLEPLAY BOARD
-M:     Nishanth Menon <nm@ti.com>
-M:     Robert Nelson <robertcnelson@gmail.com>
-M:     Tom Rini <trini@konsulko.com>
-S:     Maintained
-N:     beagleplay
diff --git a/configs/am62x_beagleplay_a53_defconfig b/configs/am62x_beagleplay_a53_defconfig
index eca94a0a3b9a..03ca3ac0c811 100644
--- a/configs/am62x_beagleplay_a53_defconfig
+++ b/configs/am62x_beagleplay_a53_defconfig
@@ -7,8 +7,7 @@ CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
 CONFIG_K3_ATF_LOAD_ADDR=0x9e780000
-CONFIG_TARGET_AM625_A53_EVM=y
-CONFIG_ENV_SOURCE_FILE="beagleplay"
+CONFIG_TARGET_AM625_A53_BEAGLEPLAY=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x80b80000
 CONFIG_DM_GPIO=y
diff --git a/configs/am62x_beagleplay_r5_defconfig b/configs/am62x_beagleplay_r5_defconfig
index 44d44428bb37..2f3264b7ede6 100644
--- a/configs/am62x_beagleplay_r5_defconfig
+++ b/configs/am62x_beagleplay_r5_defconfig
@@ -6,7 +6,7 @@ CONFIG_SPL_LIBCOMMON_SUPPORT=y
 CONFIG_SPL_LIBGENERIC_SUPPORT=y
 CONFIG_NR_DRAM_BANKS=2
 CONFIG_SOC_K3_AM625=y
-CONFIG_TARGET_AM625_R5_EVM=y
+CONFIG_TARGET_AM625_R5_BEAGLEPLAY=y
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x43c3a7f0
 CONFIG_ENV_SIZE=0x20000
@@ -36,7 +36,6 @@ CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
 CONFIG_SPL_BSS_START_ADDR=0x43c3b000
 CONFIG_SPL_BSS_MAX_SIZE=0x3000
 CONFIG_SPL_SYS_REPORT_STACK_F_USAGE=y
-CONFIG_SPL_BOARD_INIT=y
 CONFIG_SPL_SYS_MALLOC_SIMPLE=y
 CONFIG_SPL_STACK_R=y
 CONFIG_SPL_SEPARATE_BSS=y
-- 
2.37.2

