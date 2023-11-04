Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D41FBC4332F
	for <u-boot@archiver.kernel.org>; Sat,  4 Nov 2023 12:22:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 02C51870E9;
	Sat,  4 Nov 2023 13:20:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="j414uVhD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6A3E870F6; Sat,  4 Nov 2023 09:11:34 +0100 (CET)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 003E08703A
 for <u-boot@lists.denx.de>; Sat,  4 Nov 2023 09:11:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=nm@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3A48B5nS069751;
 Sat, 4 Nov 2023 03:11:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1699085465;
 bh=rv47N+AQG4aUDDlbsjw0g//xVf5lLrHSTXglZZIU+VI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=j414uVhDPEyjJdUKZiNZvwztSycOCUPrU1dRfgQXrc+VYIXpUxskNSafitMtzGxuV
 zGl8R/bIFZoazFOiKINMsJgRwTNTkqF0ynJGhI9v0Io97mOBmjnrmNeqqwGlN6LpGX
 MJR6Up/oNZ+fdinxFmkE8vcEPX/Pw1XHM8dzc+0o=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3A48B57K017587
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sat, 4 Nov 2023 03:11:05 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sat, 4
 Nov 2023 03:11:05 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sat, 4 Nov 2023 03:11:04 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
 by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3A48B4p0106367;
 Sat, 4 Nov 2023 03:11:04 -0500
From: Nishanth Menon <nm@ti.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Sinthu Raja <sinthu.raja@ti.com>,
 Manorit Chawdhry <m-chawdhry@ti.com>, Reid Tonking <reidt@ti.com>,
 Neha Malcom Francis <n-francis@ti.com>, Andrew Davis <afd@ti.com>,
 Simon Glass <sjg@chromium.org>, Robert Nelson <robertcnelson@gmail.com>,
 Jason Kridner <jkridner@beagleboard.org>, Nishanth Menon <nm@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH V2 2/4] board: beagle: Add BeagleBone AI-64 support
Date: Sat, 4 Nov 2023 03:11:01 -0500
Message-ID: <20231104081103.10607-3-nm@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20231104081103.10607-1-nm@ti.com>
References: <20231104081103.10607-1-nm@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Mailman-Approved-At: Sat, 04 Nov 2023 13:20:38 +0100
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

Add base support for BeagleBone AI-64 board support.

Further information at  https://beagleboard.org/ai-64

Signed-off-by: Nishanth Menon <nm@ti.com>
---
 arch/arm/mach-k3/Kconfig                      |    1 +
 board/beagle/beagleboneai64/Kconfig           |   59 +
 board/beagle/beagleboneai64/Makefile          |   10 +
 board/beagle/beagleboneai64/beagleboneai64.c  |   30 +
 .../beagle/beagleboneai64/beagleboneai64.env  |   19 +
 board/beagle/beagleboneai64/board-cfg.yaml    |   36 +
 board/beagle/beagleboneai64/pm-cfg.yaml       |   12 +
 board/beagle/beagleboneai64/rm-cfg.yaml       | 3174 +++++++++++++++++
 board/beagle/beagleboneai64/sec-cfg.yaml      |  380 ++
 9 files changed, 3721 insertions(+)
 create mode 100644 board/beagle/beagleboneai64/Kconfig
 create mode 100644 board/beagle/beagleboneai64/Makefile
 create mode 100644 board/beagle/beagleboneai64/beagleboneai64.c
 create mode 100644 board/beagle/beagleboneai64/beagleboneai64.env
 create mode 100644 board/beagle/beagleboneai64/board-cfg.yaml
 create mode 100644 board/beagle/beagleboneai64/pm-cfg.yaml
 create mode 100644 board/beagle/beagleboneai64/rm-cfg.yaml
 create mode 100644 board/beagle/beagleboneai64/sec-cfg.yaml

diff --git a/arch/arm/mach-k3/Kconfig b/arch/arm/mach-k3/Kconfig
index 666394b5cfde..ee17e8484fc4 100644
--- a/arch/arm/mach-k3/Kconfig
+++ b/arch/arm/mach-k3/Kconfig
@@ -201,4 +201,5 @@ source "board/siemens/iot2050/Kconfig"
 source "board/ti/j721s2/Kconfig"
 source "board/toradex/verdin-am62/Kconfig"
 source "board/beagle/beagleplay/Kconfig"
+source "board/beagle/beagleboneai64/Kconfig"
 endif
diff --git a/board/beagle/beagleboneai64/Kconfig b/board/beagle/beagleboneai64/Kconfig
new file mode 100644
index 000000000000..7cfccf9baf01
--- /dev/null
+++ b/board/beagle/beagleboneai64/Kconfig
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2023 Jason Kridner, BeagleBoard.org Foundation
+# Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+#
+
+choice
+	prompt "BeagleBoard.org J721E/TDA4VM based BeagleBone AI-64 board"
+	optional
+
+config TARGET_J721E_A72_BEAGLEBONEAI64
+	bool "BeagleBoard.org J721E BeagleBone AI-64 running on A72"
+	select ARM64
+	select SYS_DISABLE_DCACHE_OPS
+	select BINMAN
+
+config TARGET_J721E_R5_BEAGLEBONEAI64
+	bool "BeagleBoard.org J721E BeagleBone AI-64 running on R5"
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
+if TARGET_J721E_A72_BEAGLEBONEAI64
+
+config SYS_BOARD
+       default "beagleboneai64"
+
+config SYS_VENDOR
+       default "beagle"
+
+config SYS_CONFIG_NAME
+       default "j721e_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_J721E_R5_BEAGLEBONEAI64
+
+config SYS_BOARD
+       default "beagleboneai64"
+
+config SYS_VENDOR
+       default "beagle"
+
+config SYS_CONFIG_NAME
+       default "j721e_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
diff --git a/board/beagle/beagleboneai64/Makefile b/board/beagle/beagleboneai64/Makefile
new file mode 100644
index 000000000000..f2a2526ae75e
--- /dev/null
+++ b/board/beagle/beagleboneai64/Makefile
@@ -0,0 +1,10 @@
+# SPDX-License-Identifier:     GPL-2.0+
+#
+# https://beagleboard.org/ai-64
+#
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+# Copyright (C) 2022-2023 Jason Kridner, BeagleBoard.org Foundation
+# Copyright (C) 2022-2023 Robert Nelson, BeagleBoard.org Foundation
+#
+
+obj-y	+= beagleboneai64.o
diff --git a/board/beagle/beagleboneai64/beagleboneai64.c b/board/beagle/beagleboneai64/beagleboneai64.c
new file mode 100644
index 000000000000..c8c1c78ae5a2
--- /dev/null
+++ b/board/beagle/beagleboneai64/beagleboneai64.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * https://beagleboard.org/ai-64
+ *
+ * Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+ * Copyright (C) 2022-2023 Jason Kridner, BeagleBoard.org Foundation
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
diff --git a/board/beagle/beagleboneai64/beagleboneai64.env b/board/beagle/beagleboneai64/beagleboneai64.env
new file mode 100644
index 000000000000..4f0a94a8113e
--- /dev/null
+++ b/board/beagle/beagleboneai64/beagleboneai64.env
@@ -0,0 +1,19 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/default_findfdt.env>
+#include <env/ti/mmc.env>
+
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+set_led_state_fail_load= led led-0 off; led led-1 on;
+	led led-2 off; led led-3 on; led led-4 off
+set_led_state_start_load=led led-0 on; led led-1 off;
+	led led-2 on; led led-3 off; led led-4 on
+boot=mmc
+mmcdev=1
+bootpart=1:1
+bootdir=/boot
+boot_targets=mmc1 mmc0 usb pxe
+bootmeths=script extlinux efi pxe
+rd_spec=-
diff --git a/board/beagle/beagleboneai64/board-cfg.yaml b/board/beagle/beagleboneai64/board-cfg.yaml
new file mode 100644
index 000000000000..1375dcad3572
--- /dev/null
+++ b/board/beagle/beagleboneai64/board-cfg.yaml
@@ -0,0 +1,36 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Board configuration for J721E
+#
+
+---
+
+board-cfg:
+        rev:
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
+        control:
+                subhdr:
+                        magic: 0xC1D3
+                        size: 7
+                main_isolation_enable: 0x5A
+                main_isolation_hostid: 0x2
+        secproxy:
+                subhdr:
+                        magic: 0x1207
+                        size: 7
+                scaling_factor: 0x1
+                scaling_profile: 0x1
+                disable_main_nav_secure_proxy: 0
+        msmc:
+                subhdr:
+                        magic: 0xA5C3
+                        size: 5
+                msmc_cache_size: 0x0
+        debug_cfg:
+                subhdr:
+                        magic: 0x020C
+                        size: 8
+                trace_dst_enables: 0x00
+                trace_src_enables: 0x00
diff --git a/board/beagle/beagleboneai64/pm-cfg.yaml b/board/beagle/beagleboneai64/pm-cfg.yaml
new file mode 100644
index 000000000000..7ae52b3358e2
--- /dev/null
+++ b/board/beagle/beagleboneai64/pm-cfg.yaml
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Power management configuration for J721E
+#
+
+---
+
+pm-cfg:
+        rev:
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
diff --git a/board/beagle/beagleboneai64/rm-cfg.yaml b/board/beagle/beagleboneai64/rm-cfg.yaml
new file mode 100644
index 000000000000..9f604cf1aa64
--- /dev/null
+++ b/board/beagle/beagleboneai64/rm-cfg.yaml
@@ -0,0 +1,3174 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Resource management configuration for J721E
+#
+
+---
+
+rm-cfg:
+        rm_boardcfg:
+                rev:
+                        boardcfg_abi_maj: 0x0
+                        boardcfg_abi_min: 0x1
+                host_cfg:
+                        subhdr:
+                                magic: 0x4C41
+                                size: 356
+                        host_cfg_entries:
+                                - #1
+                                        host_id: 3
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #2
+                                        host_id: 5
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #3
+                                        host_id: 12
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #4
+                                        host_id: 13
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #5
+                                        host_id: 21
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #6
+                                        host_id: 26
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #7
+                                        host_id: 28
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #8
+                                        host_id: 35
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #9
+                                        host_id: 37
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #10
+                                        host_id: 40
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #11
+                                        host_id: 42
+                                        allowed_atype: 0x2A
+                                        allowed_qos: 0xAAAA
+                                        allowed_orderid: 0xAAAAAAAA
+                                        allowed_priority: 0xAAAA
+                                        allowed_sched_priority: 0xAA
+                                - #12
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #13
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #14
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #15
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #16
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #17
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #18
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #19
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #20
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #21
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #22
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #23
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #24
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #25
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #26
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #27
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #28
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #29
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #30
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #31
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                                - #32
+                                        host_id: 0
+                                        allowed_atype: 0
+                                        allowed_qos: 0
+                                        allowed_orderid: 0
+                                        allowed_priority: 0
+                                        allowed_sched_priority: 0
+                resasg:
+                        subhdr:
+                                magic: 0x7B25
+                                size: 8
+                        resasg_entries_size: 3344
+                        reserved: 0
+        resasg_entries:
+                -
+                        start_resource: 4
+                        num_resource: 93
+                        type: 7744
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 93
+                        type: 7808
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 32
+                        type: 7872
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 32
+                        type: 8192
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 32
+                        type: 8192
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 24
+                        type: 8320
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 24
+                        type: 8320
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 8
+                        type: 8384
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 8
+                        type: 8384
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 4
+                        type: 8384
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 4
+                        type: 8384
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 4
+                        type: 8384
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 4
+                        type: 8384
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 4
+                        type: 8384
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 36
+                        num_resource: 4
+                        type: 8384
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 40
+                        num_resource: 12
+                        type: 8384
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 52
+                        num_resource: 12
+                        type: 8384
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 128
+                        type: 8576
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 128
+                        num_resource: 128
+                        type: 8576
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 128
+                        type: 8640
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 128
+                        num_resource: 128
+                        type: 8640
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 48
+                        type: 8704
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 8
+                        type: 8768
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 8
+                        type: 8768
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 6
+                        type: 8768
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 22
+                        num_resource: 6
+                        type: 8768
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 2
+                        type: 8768
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 30
+                        num_resource: 2
+                        type: 8768
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 64
+                        type: 13258
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 20480
+                        num_resource: 1024
+                        type: 13261
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 64
+                        type: 13322
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 22528
+                        num_resource: 1024
+                        type: 13325
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 38
+                        num_resource: 86
+                        type: 13386
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 124
+                        num_resource: 32
+                        type: 13386
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 156
+                        num_resource: 12
+                        type: 13386
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 168
+                        num_resource: 12
+                        type: 13386
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 180
+                        num_resource: 12
+                        type: 13386
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 192
+                        num_resource: 12
+                        type: 13386
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 204
+                        num_resource: 12
+                        type: 13386
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 216
+                        num_resource: 28
+                        type: 13386
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 244
+                        num_resource: 8
+                        type: 13386
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 252
+                        num_resource: 4
+                        type: 13386
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 38
+                        num_resource: 1024
+                        type: 13389
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 1062
+                        num_resource: 512
+                        type: 13389
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 1574
+                        num_resource: 32
+                        type: 13389
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 1606
+                        num_resource: 32
+                        type: 13389
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 1638
+                        num_resource: 256
+                        type: 13389
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 1894
+                        num_resource: 256
+                        type: 13389
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 2150
+                        num_resource: 256
+                        type: 13389
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 2406
+                        num_resource: 256
+                        type: 13389
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 2662
+                        num_resource: 256
+                        type: 13389
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 2918
+                        num_resource: 512
+                        type: 13389
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 3430
+                        num_resource: 256
+                        type: 13389
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 3686
+                        num_resource: 922
+                        type: 13389
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 4
+                        type: 13440
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 4
+                        type: 13440
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 4
+                        type: 13440
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 4
+                        type: 13440
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 4
+                        type: 13440
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 4
+                        type: 13440
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 4
+                        type: 13440
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 4
+                        type: 13440
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 4
+                        type: 13440
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 36
+                        num_resource: 12
+                        type: 13440
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 4
+                        type: 13440
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 52
+                        num_resource: 12
+                        type: 13440
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 13504
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 440
+                        num_resource: 150
+                        type: 13505
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 590
+                        num_resource: 40
+                        type: 13505
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 630
+                        num_resource: 6
+                        type: 13505
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 636
+                        num_resource: 6
+                        type: 13505
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 642
+                        num_resource: 10
+                        type: 13505
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 652
+                        num_resource: 10
+                        type: 13505
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 662
+                        num_resource: 32
+                        type: 13505
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 694
+                        num_resource: 38
+                        type: 13505
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 732
+                        num_resource: 12
+                        type: 13505
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 744
+                        num_resource: 182
+                        type: 13505
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 926
+                        num_resource: 40
+                        type: 13505
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 966
+                        num_resource: 8
+                        type: 13505
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 316
+                        num_resource: 8
+                        type: 13506
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 324
+                        num_resource: 2
+                        type: 13506
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 324
+                        num_resource: 0
+                        type: 13506
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 326
+                        num_resource: 2
+                        type: 13506
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 328
+                        num_resource: 2
+                        type: 13506
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 330
+                        num_resource: 2
+                        type: 13506
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 332
+                        num_resource: 2
+                        type: 13506
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 334
+                        num_resource: 8
+                        type: 13506
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 342
+                        num_resource: 2
+                        type: 13506
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 344
+                        num_resource: 4
+                        type: 13506
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 348
+                        num_resource: 1
+                        type: 13506
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 349
+                        num_resource: 47
+                        type: 13506
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 396
+                        num_resource: 1
+                        type: 13506
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 397
+                        num_resource: 4
+                        type: 13506
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 401
+                        num_resource: 4
+                        type: 13506
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 405
+                        num_resource: 4
+                        type: 13506
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 409
+                        num_resource: 8
+                        type: 13506
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 417
+                        num_resource: 6
+                        type: 13506
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 423
+                        num_resource: 16
+                        type: 13506
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 439
+                        num_resource: 1
+                        type: 13506
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 8
+                        type: 13507
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 2
+                        type: 13507
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 0
+                        type: 13507
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 2
+                        type: 13507
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 2
+                        type: 13507
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 30
+                        num_resource: 2
+                        type: 13507
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 2
+                        type: 13507
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 34
+                        num_resource: 8
+                        type: 13507
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 42
+                        num_resource: 2
+                        type: 13507
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 44
+                        num_resource: 4
+                        type: 13507
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 1
+                        type: 13507
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 49
+                        num_resource: 47
+                        type: 13507
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 96
+                        num_resource: 1
+                        type: 13507
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 97
+                        num_resource: 4
+                        type: 13507
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 101
+                        num_resource: 4
+                        type: 13507
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 105
+                        num_resource: 4
+                        type: 13507
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 109
+                        num_resource: 8
+                        type: 13507
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 117
+                        num_resource: 6
+                        type: 13507
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 123
+                        num_resource: 10
+                        type: 13507
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 133
+                        num_resource: 6
+                        type: 13507
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 139
+                        num_resource: 1
+                        type: 13507
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 140
+                        num_resource: 16
+                        type: 13508
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 156
+                        num_resource: 6
+                        type: 13508
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 162
+                        num_resource: 6
+                        type: 13508
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 168
+                        num_resource: 2
+                        type: 13508
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 170
+                        num_resource: 2
+                        type: 13508
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 172
+                        num_resource: 96
+                        type: 13508
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 268
+                        num_resource: 32
+                        type: 13508
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 304
+                        num_resource: 0
+                        type: 13509
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 304
+                        num_resource: 4
+                        type: 13509
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 304
+                        num_resource: 0
+                        type: 13509
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 308
+                        num_resource: 6
+                        type: 13509
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 314
+                        num_resource: 2
+                        type: 13509
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 300
+                        num_resource: 0
+                        type: 13510
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 300
+                        num_resource: 2
+                        type: 13510
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 300
+                        num_resource: 0
+                        type: 13510
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 302
+                        num_resource: 2
+                        type: 13510
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 0
+                        type: 13511
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 4
+                        type: 13511
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 0
+                        type: 13511
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 6
+                        type: 13511
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 2
+                        type: 13511
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 13512
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 2
+                        type: 13512
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 13512
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 2
+                        type: 13512
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 5
+                        type: 13514
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 7
+                        num_resource: 1
+                        type: 13514
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 3
+                        type: 13515
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 3
+                        num_resource: 2
+                        type: 13515
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 5
+                        num_resource: 1
+                        type: 13515
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 1
+                        type: 13515
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 7
+                        num_resource: 3
+                        type: 13515
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 10
+                        num_resource: 3
+                        type: 13515
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 3
+                        type: 13515
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 3
+                        type: 13515
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 19
+                        num_resource: 3
+                        type: 13515
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 22
+                        num_resource: 6
+                        type: 13515
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 3
+                        type: 13515
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 31
+                        num_resource: 1
+                        type: 13515
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 140
+                        num_resource: 16
+                        type: 13568
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 156
+                        num_resource: 16
+                        type: 13568
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 172
+                        num_resource: 128
+                        type: 13568
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 13569
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 49152
+                        num_resource: 1024
+                        type: 13570
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 13571
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 8
+                        type: 13578
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 2
+                        type: 13578
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 0
+                        type: 13578
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 2
+                        type: 13578
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 2
+                        type: 13578
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 30
+                        num_resource: 2
+                        type: 13578
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 2
+                        type: 13578
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 34
+                        num_resource: 8
+                        type: 13578
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 42
+                        num_resource: 2
+                        type: 13578
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 44
+                        num_resource: 4
+                        type: 13578
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 1
+                        type: 13578
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 49
+                        num_resource: 47
+                        type: 13578
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 96
+                        num_resource: 1
+                        type: 13578
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 97
+                        num_resource: 4
+                        type: 13578
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 101
+                        num_resource: 4
+                        type: 13578
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 105
+                        num_resource: 4
+                        type: 13578
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 109
+                        num_resource: 8
+                        type: 13578
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 117
+                        num_resource: 6
+                        type: 13578
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 123
+                        num_resource: 16
+                        type: 13578
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 139
+                        num_resource: 1
+                        type: 13578
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 0
+                        type: 13579
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 4
+                        type: 13579
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 0
+                        type: 13579
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 6
+                        type: 13579
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 2
+                        type: 13579
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 13580
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 2
+                        type: 13580
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 13580
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 2
+                        type: 13580
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 8
+                        type: 13581
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 2
+                        type: 13581
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 0
+                        type: 13581
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 2
+                        type: 13581
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 28
+                        num_resource: 2
+                        type: 13581
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 30
+                        num_resource: 2
+                        type: 13581
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 32
+                        num_resource: 2
+                        type: 13581
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 34
+                        num_resource: 8
+                        type: 13581
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 42
+                        num_resource: 2
+                        type: 13581
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 44
+                        num_resource: 4
+                        type: 13581
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 1
+                        type: 13581
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 49
+                        num_resource: 47
+                        type: 13581
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 96
+                        num_resource: 1
+                        type: 13581
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 97
+                        num_resource: 4
+                        type: 13581
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 101
+                        num_resource: 4
+                        type: 13581
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 105
+                        num_resource: 4
+                        type: 13581
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 109
+                        num_resource: 8
+                        type: 13581
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 117
+                        num_resource: 6
+                        type: 13581
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 123
+                        num_resource: 10
+                        type: 13581
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 133
+                        num_resource: 6
+                        type: 13581
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 139
+                        num_resource: 1
+                        type: 13581
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 140
+                        num_resource: 16
+                        type: 13582
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 156
+                        num_resource: 6
+                        type: 13582
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 162
+                        num_resource: 6
+                        type: 13582
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 168
+                        num_resource: 2
+                        type: 13582
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 170
+                        num_resource: 2
+                        type: 13582
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 172
+                        num_resource: 96
+                        type: 13582
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 268
+                        num_resource: 32
+                        type: 13582
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 0
+                        type: 13583
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 4
+                        type: 13583
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 4
+                        num_resource: 0
+                        type: 13583
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 6
+                        type: 13583
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 2
+                        type: 13583
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 13584
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 2
+                        type: 13584
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 13584
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 2
+                        type: 13584
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 10
+                        num_resource: 100
+                        type: 13632
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 110
+                        num_resource: 32
+                        type: 13632
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 142
+                        num_resource: 46
+                        type: 13632
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 196
+                        num_resource: 28
+                        type: 13632
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 228
+                        num_resource: 28
+                        type: 13632
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 260
+                        num_resource: 28
+                        type: 13632
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 292
+                        num_resource: 28
+                        type: 13632
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 320
+                        num_resource: 24
+                        type: 13632
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 352
+                        num_resource: 24
+                        type: 13632
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 400
+                        num_resource: 4
+                        type: 13632
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 404
+                        num_resource: 4
+                        type: 13632
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 16
+                        num_resource: 32
+                        type: 14922
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 16
+                        type: 14922
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 64
+                        num_resource: 64
+                        type: 14922
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 128
+                        num_resource: 4
+                        type: 14922
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 132
+                        num_resource: 16
+                        type: 14922
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 148
+                        num_resource: 16
+                        type: 14922
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 164
+                        num_resource: 8
+                        type: 14922
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 172
+                        num_resource: 8
+                        type: 14922
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 180
+                        num_resource: 8
+                        type: 14922
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 188
+                        num_resource: 24
+                        type: 14922
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 212
+                        num_resource: 8
+                        type: 14922
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 220
+                        num_resource: 36
+                        type: 14922
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 16400
+                        num_resource: 128
+                        type: 14925
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 16528
+                        num_resource: 128
+                        type: 14925
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 16656
+                        num_resource: 256
+                        type: 14925
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 16912
+                        num_resource: 64
+                        type: 14925
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 16976
+                        num_resource: 128
+                        type: 14925
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 17104
+                        num_resource: 128
+                        type: 14925
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 17232
+                        num_resource: 64
+                        type: 14925
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 17296
+                        num_resource: 64
+                        type: 14925
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 17360
+                        num_resource: 64
+                        type: 14925
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 17424
+                        num_resource: 128
+                        type: 14925
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 17552
+                        num_resource: 128
+                        type: 14925
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 17680
+                        num_resource: 240
+                        type: 14925
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 1
+                        num_resource: 4
+                        type: 14976
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 5
+                        num_resource: 4
+                        type: 14976
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 4
+                        type: 14976
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 4
+                        type: 14976
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 17
+                        num_resource: 4
+                        type: 14976
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 21
+                        num_resource: 4
+                        type: 14976
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 25
+                        num_resource: 4
+                        type: 14976
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 29
+                        num_resource: 4
+                        type: 14976
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 33
+                        num_resource: 4
+                        type: 14976
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 37
+                        num_resource: 16
+                        type: 14976
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 53
+                        num_resource: 4
+                        type: 14976
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 57
+                        num_resource: 7
+                        type: 14976
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 15040
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 96
+                        num_resource: 20
+                        type: 15041
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 116
+                        num_resource: 8
+                        type: 15041
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 124
+                        num_resource: 32
+                        type: 15041
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 156
+                        num_resource: 12
+                        type: 15041
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 168
+                        num_resource: 8
+                        type: 15041
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 176
+                        num_resource: 8
+                        type: 15041
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 184
+                        num_resource: 8
+                        type: 15041
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 192
+                        num_resource: 8
+                        type: 15041
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 200
+                        num_resource: 8
+                        type: 15041
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 208
+                        num_resource: 16
+                        type: 15041
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 224
+                        num_resource: 8
+                        type: 15041
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 232
+                        num_resource: 20
+                        type: 15041
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 50
+                        num_resource: 4
+                        type: 15042
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 54
+                        num_resource: 2
+                        type: 15042
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 54
+                        num_resource: 0
+                        type: 15042
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 56
+                        num_resource: 0
+                        type: 15042
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 56
+                        num_resource: 1
+                        type: 15042
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 57
+                        num_resource: 1
+                        type: 15042
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 58
+                        num_resource: 1
+                        type: 15042
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 59
+                        num_resource: 1
+                        type: 15042
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 60
+                        num_resource: 1
+                        type: 15042
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 61
+                        num_resource: 1
+                        type: 15042
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 62
+                        num_resource: 1
+                        type: 15042
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 63
+                        num_resource: 9
+                        type: 15042
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 72
+                        num_resource: 6
+                        type: 15042
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 78
+                        num_resource: 3
+                        type: 15042
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 81
+                        num_resource: 2
+                        type: 15042
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 83
+                        num_resource: 1
+                        type: 15042
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 84
+                        num_resource: 1
+                        type: 15042
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 85
+                        num_resource: 1
+                        type: 15042
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 86
+                        num_resource: 1
+                        type: 15042
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 87
+                        num_resource: 1
+                        type: 15042
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 88
+                        num_resource: 2
+                        type: 15042
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 90
+                        num_resource: 1
+                        type: 15042
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 91
+                        num_resource: 2
+                        type: 15042
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 4
+                        type: 15043
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 2
+                        type: 15043
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 0
+                        type: 15043
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 0
+                        type: 15043
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 1
+                        type: 15043
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 1
+                        type: 15043
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 10
+                        num_resource: 1
+                        type: 15043
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 11
+                        num_resource: 1
+                        type: 15043
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 1
+                        type: 15043
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 1
+                        type: 15043
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 1
+                        type: 15043
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 15
+                        num_resource: 9
+                        type: 15043
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 6
+                        type: 15043
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 30
+                        num_resource: 3
+                        type: 15043
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 33
+                        num_resource: 2
+                        type: 15043
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 35
+                        num_resource: 1
+                        type: 15043
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 36
+                        num_resource: 1
+                        type: 15043
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 37
+                        num_resource: 1
+                        type: 15043
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 38
+                        num_resource: 1
+                        type: 15043
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 39
+                        num_resource: 1
+                        type: 15043
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 40
+                        num_resource: 2
+                        type: 15043
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 42
+                        num_resource: 1
+                        type: 15043
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 43
+                        num_resource: 3
+                        type: 15043
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 0
+                        type: 15045
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 2
+                        type: 15045
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 15047
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 2
+                        type: 15047
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 5
+                        type: 15050
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 7
+                        num_resource: 1
+                        type: 15050
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 3
+                        type: 15051
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 3
+                        num_resource: 2
+                        type: 15051
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 5
+                        num_resource: 3
+                        type: 15051
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 3
+                        type: 15051
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 11
+                        num_resource: 3
+                        type: 15051
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 3
+                        type: 15051
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 17
+                        num_resource: 3
+                        type: 15051
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 20
+                        num_resource: 3
+                        type: 15051
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 23
+                        num_resource: 3
+                        type: 15051
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 26
+                        num_resource: 3
+                        type: 15051
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 29
+                        num_resource: 3
+                        type: 15051
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 48
+                        num_resource: 8
+                        type: 15104
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 56
+                        num_resource: 4
+                        type: 15104
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 60
+                        num_resource: 8
+                        type: 15104
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 68
+                        num_resource: 4
+                        type: 15104
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 72
+                        num_resource: 4
+                        type: 15104
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 76
+                        num_resource: 4
+                        type: 15104
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 80
+                        num_resource: 8
+                        type: 15104
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 88
+                        num_resource: 4
+                        type: 15104
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 92
+                        num_resource: 4
+                        type: 15104
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 15105
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 56320
+                        num_resource: 256
+                        type: 15106
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 1
+                        type: 15107
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 4
+                        type: 15114
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 2
+                        type: 15114
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 0
+                        type: 15114
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 0
+                        type: 15114
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 1
+                        type: 15114
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 1
+                        type: 15114
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 10
+                        num_resource: 1
+                        type: 15114
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 11
+                        num_resource: 1
+                        type: 15114
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 1
+                        type: 15114
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 1
+                        type: 15114
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 1
+                        type: 15114
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 15
+                        num_resource: 9
+                        type: 15114
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 6
+                        type: 15114
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 30
+                        num_resource: 3
+                        type: 15114
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 33
+                        num_resource: 2
+                        type: 15114
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 35
+                        num_resource: 1
+                        type: 15114
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 36
+                        num_resource: 1
+                        type: 15114
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 37
+                        num_resource: 1
+                        type: 15114
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 38
+                        num_resource: 1
+                        type: 15114
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 39
+                        num_resource: 1
+                        type: 15114
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 40
+                        num_resource: 2
+                        type: 15114
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 42
+                        num_resource: 1
+                        type: 15114
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 43
+                        num_resource: 2
+                        type: 15114
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 15115
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 2
+                        type: 15115
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 2
+                        num_resource: 4
+                        type: 15117
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 2
+                        type: 15117
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 6
+                        num_resource: 0
+                        type: 15117
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 0
+                        type: 15117
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 8
+                        num_resource: 1
+                        type: 15117
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 9
+                        num_resource: 1
+                        type: 15117
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 10
+                        num_resource: 1
+                        type: 15117
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 11
+                        num_resource: 1
+                        type: 15117
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 1
+                        type: 15117
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 13
+                        num_resource: 1
+                        type: 15117
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 14
+                        num_resource: 1
+                        type: 15117
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 15
+                        num_resource: 9
+                        type: 15117
+                        host_id: 12
+                        reserved: 0
+
+                -
+                        start_resource: 24
+                        num_resource: 6
+                        type: 15117
+                        host_id: 13
+                        reserved: 0
+
+                -
+                        start_resource: 30
+                        num_resource: 3
+                        type: 15117
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 33
+                        num_resource: 2
+                        type: 15117
+                        host_id: 5
+                        reserved: 0
+
+                -
+                        start_resource: 35
+                        num_resource: 1
+                        type: 15117
+                        host_id: 40
+                        reserved: 0
+
+                -
+                        start_resource: 36
+                        num_resource: 1
+                        type: 15117
+                        host_id: 42
+                        reserved: 0
+
+                -
+                        start_resource: 37
+                        num_resource: 1
+                        type: 15117
+                        host_id: 21
+                        reserved: 0
+
+                -
+                        start_resource: 38
+                        num_resource: 1
+                        type: 15117
+                        host_id: 26
+                        reserved: 0
+
+                -
+                        start_resource: 39
+                        num_resource: 1
+                        type: 15117
+                        host_id: 28
+                        reserved: 0
+
+                -
+                        start_resource: 40
+                        num_resource: 2
+                        type: 15117
+                        host_id: 35
+                        reserved: 0
+
+                -
+                        start_resource: 42
+                        num_resource: 1
+                        type: 15117
+                        host_id: 37
+                        reserved: 0
+
+                -
+                        start_resource: 43
+                        num_resource: 3
+                        type: 15117
+                        host_id: 128
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 0
+                        type: 15119
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 0
+                        num_resource: 2
+                        type: 15119
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 12
+                        num_resource: 20
+                        type: 15168
+                        host_id: 3
+                        reserved: 0
+
+                -
+                        start_resource: 36
+                        num_resource: 28
+                        type: 15168
+                        host_id: 5
+                        reserved: 0
diff --git a/board/beagle/beagleboneai64/sec-cfg.yaml b/board/beagle/beagleboneai64/sec-cfg.yaml
new file mode 100644
index 000000000000..1eab5883a78b
--- /dev/null
+++ b/board/beagle/beagleboneai64/sec-cfg.yaml
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (C) 2022-2023 Texas Instruments Incorporated - https://www.ti.com/
+#
+# Security configuration for J721E
+#
+
+---
+
+sec-cfg:
+        rev:
+                boardcfg_abi_maj: 0x0
+                boardcfg_abi_min: 0x1
+        processor_acl_list:
+                subhdr:
+                        magic: 0xF1EA
+                        size: 164
+                proc_acl_entries:
+                        - #1
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #2
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #3
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #4
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #5
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #6
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #7
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #8
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #9
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #10
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #11
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #12
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #13
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #14
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #15
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #16
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #17
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #18
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #19
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #20
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #21
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #22
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #23
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #24
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #25
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #26
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #27
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #28
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #29
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #30
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #31
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+                        - #32
+                                processor_id: 0
+                                proc_access_master: 0
+                                proc_access_secondary: [0, 0, 0]
+
+        host_hierarchy:
+                subhdr:
+                        magic: 0x8D27
+                        size: 68
+                host_hierarchy_entries:
+                        - #1
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #2
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #3
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #4
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #5
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #6
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #7
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #8
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #9
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #10
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #11
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #12
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #13
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #14
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #15
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #16
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #17
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #18
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #19
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #20
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #21
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #22
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #23
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #24
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #25
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #26
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #27
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #28
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #29
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #30
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #31
+                                host_id: 0
+                                supervisor_host_id: 0
+                        - #32
+                                host_id: 0
+                                supervisor_host_id: 0
+        otp_config:
+                subhdr:
+                        magic: 0x4081
+                        size: 69
+                otp_entry:
+                        - #1
+                                host_id: 0
+                                host_perms: 0
+                        - #2
+                                host_id: 0
+                                host_perms: 0
+                        - #3
+                                host_id: 0
+                                host_perms: 0
+                        - #4
+                                host_id: 0
+                                host_perms: 0
+                        - #5
+                                host_id: 0
+                                host_perms: 0
+                        - #6
+                                host_id: 0
+                                host_perms: 0
+                        - #7
+                                host_id: 0
+                                host_perms: 0
+                        - #8
+                                host_id: 0
+                                host_perms: 0
+                        - #9
+                                host_id: 0
+                                host_perms: 0
+                        - #10
+                                host_id: 0
+                                host_perms: 0
+                        - #11
+                                host_id: 0
+                                host_perms: 0
+                        - #12
+                                host_id: 0
+                                host_perms: 0
+                        - #13
+                                host_id: 0
+                                host_perms: 0
+                        - #14
+                                host_id: 0
+                                host_perms: 0
+                        - #15
+                                host_id: 0
+                                host_perms: 0
+                        - #16
+                                host_id: 0
+                                host_perms: 0
+                        - #17
+                                host_id: 0
+                                host_perms: 0
+                        - #18
+                                host_id: 0
+                                host_perms: 0
+                        - #19
+                                host_id: 0
+                                host_perms: 0
+                        - #20
+                                host_id: 0
+                                host_perms: 0
+                        - #21
+                                host_id: 0
+                                host_perms: 0
+                        - #22
+                                host_id: 0
+                                host_perms: 0
+                        - #23
+                                host_id: 0
+                                host_perms: 0
+                        - #24
+                                host_id: 0
+                                host_perms: 0
+                        - #25
+                                host_id: 0
+                                host_perms: 0
+                        - #26
+                                host_id: 0
+                                host_perms: 0
+                        - #27
+                                host_id: 0
+                                host_perms: 0
+                        - #28
+                                host_id: 0
+                                host_perms: 0
+                        - #29
+                                host_id: 0
+                                host_perms: 0
+                        - #30
+                                host_id: 0
+                                host_perms: 0
+                        - #31
+                                host_id: 0
+                                host_perms: 0
+                        - #32
+                                host_id: 0
+                                host_perms: 0
+                write_host_id: 0
+        dkek_config:
+                subhdr:
+                        magic: 0x5170
+                        size: 12
+                allowed_hosts: [128, 0, 0, 0]
+                allow_dkek_export_tisci: 0x5A
+                rsvd: [0, 0, 0]
+        sa2ul_cfg:
+                subhdr:
+                        magic: 0x23BE
+                        size: 0
+                auth_resource_owner: 0
+                enable_saul_psil_global_config_writes: 0
+                rsvd: [0, 0]
+        sec_dbg_config:
+                subhdr:
+                        magic: 0x42AF
+                        size: 16
+                allow_jtag_unlock: 0x5A
+                allow_wildcard_unlock: 0x5A
+                allowed_debug_level_rsvd: 0
+                rsvd: 0
+                min_cert_rev: 0x0
+                jtag_unlock_hosts: [0, 0, 0, 0]
+        sec_handover_cfg:
+                subhdr:
+                        magic: 0x608F
+                        size: 10
+                handover_msg_sender: 0
+                handover_to_host_id: 0
+                rsvd: [0, 0, 0, 0]
-- 
2.37.2

