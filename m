Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6003CA0FED
	for <u-boot@archiver.kernel.org>; Tue,  9 Sep 2025 05:34:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 644318318E;
	Tue,  9 Sep 2025 07:34:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="B9dV6D7C";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A09BD8313B; Tue,  9 Sep 2025 07:34:45 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2AD47830B4
 for <u-boot@lists.denx.de>; Tue,  9 Sep 2025 07:34:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-bhagat@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5895YfAF3953638
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 00:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1757396081;
 bh=ywcCNrnhGuorYFf1PS5VupmM1BnGlwpn/S0/F0sO/wU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=B9dV6D7CZG5oKZBLY/h+HKycvx8Psecp4XZhT3uM1zDP+HbgueWvlFpLoVAxvqrjT
 KDJTHAZeHFjlwzed8esNozqb+Cts/X7FXRb6q9dyX6INQI6LL+H5+POHXRspARQ6FS
 44wXn2nIb7vW0NG5QOnmgGQzz5foE1parOhVNPMs=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5895YfEM2927556
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL)
 for <u-boot@lists.denx.de>; Tue, 9 Sep 2025 00:34:41 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 9
 Sep 2025 00:34:41 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Tue, 9 Sep 2025 00:34:41 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5895YeI52100343;
 Tue, 9 Sep 2025 00:34:40 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <vigneshr@ti.com>, <praneeth@ti.com>, <nm@ti.com>
CC: <u-boot@lists.denx.de>, <bb@ti.com>, <khasim@ti.com>, <v-singh1@ti.com>,
 <afd@ti.com>, <anshuld@ti.com>
Subject: [RFC PATCH v2 1/5] board: ti: Introduce the basic files needed to
 support am62d
Date: Tue, 9 Sep 2025 11:04:25 +0530
Message-ID: <20250909053429.444854-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250909053429.444854-1-p-bhagat@ti.com>
References: <20250909053429.444854-1-p-bhagat@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
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

Introduce the bare minimum SD and UART support for AM62D2-EVM.

Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 board/ti/am62dx/Kconfig     | 26 ++++++++++++++++++++++++++
 board/ti/am62dx/MAINTAINERS |  8 ++++++++
 board/ti/am62dx/Makefile    |  7 +++++++
 board/ti/am62dx/am62dx.env  | 21 +++++++++++++++++++++
 board/ti/am62dx/evm.c       | 37 +++++++++++++++++++++++++++++++++++++
 5 files changed, 99 insertions(+)
 create mode 100644 board/ti/am62dx/Kconfig
 create mode 100644 board/ti/am62dx/MAINTAINERS
 create mode 100644 board/ti/am62dx/Makefile
 create mode 100644 board/ti/am62dx/am62dx.env
 create mode 100644 board/ti/am62dx/evm.c

diff --git a/board/ti/am62dx/Kconfig b/board/ti/am62dx/Kconfig
new file mode 100644
index 00000000000..0bdd6a61846
--- /dev/null
+++ b/board/ti/am62dx/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+#
+
+if TARGET_AM62D2_R5_EVM || TARGET_AM62D2_A53_EVM
+
+config SYS_BOARD
+	default "am62dx"
+
+config SYS_VENDOR
+	default "ti"
+
+config SYS_CONFIG_NAME
+	default "am62ax_evm"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_AM62D2_R5_EVM
+
+config SPL_LDSCRIPT
+	default "arch/arm/mach-omap2/u-boot-spl.lds"
+
+endif
diff --git a/board/ti/am62dx/MAINTAINERS b/board/ti/am62dx/MAINTAINERS
new file mode 100644
index 00000000000..e7af7be35bc
--- /dev/null
+++ b/board/ti/am62dx/MAINTAINERS
@@ -0,0 +1,8 @@
+AM62Dx BOARD
+M:	Vignesh Raghavendra <vigneshr@ti.com>
+M:	Bryan Brattlof <bb@ti.com>
+S:	Maintained
+F:	board/ti/am62dx/
+F:	include/configs/am62a7_evm.h
+F:	configs/am62dx_evm_r5_defconfig
+F:	configs/am62dx_evm_a53_defconfig
diff --git a/board/ti/am62dx/Makefile b/board/ti/am62dx/Makefile
new file mode 100644
index 00000000000..5f247ec1cc2
--- /dev/null
+++ b/board/ti/am62dx/Makefile
@@ -0,0 +1,7 @@
+#
+# Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+#
+# SPDX-License-Identifier:     GPL-2.0+
+#
+
+obj-y	+= evm.o
diff --git a/board/ti/am62dx/am62dx.env b/board/ti/am62dx/am62dx.env
new file mode 100644
index 00000000000..6fa80a964c1
--- /dev/null
+++ b/board/ti/am62dx/am62dx.env
@@ -0,0 +1,21 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/mmc.env>
+#include <env/ti/k3_dfu.env>
+#if CONFIG_CMD_REMOTEPROC
+#include <env/ti/k3_rproc.env>
+#endif
+
+name_kern=Image
+console=ttyS2,115200n8
+args_all=setenv optargs ${optargs} earlycon=ns16550a,mmio32,0x02800000
+	${mtdparts}
+run_kern=booti ${loadaddr} ${rd_spec} ${fdtaddr}
+
+boot_targets=mmc1 mmc0 usb pxe dhcp
+boot=mmc
+mmcdev=1
+bootpart=1:2
+bootdir=/boot
+rd_spec=-
+
+rproc_fw_binaries= 0 /lib/firmware/am62d-mcu-r5f0_0-fw 1 /lib/firmware/am62d-c71_0-fw
diff --git a/board/ti/am62dx/evm.c b/board/ti/am62dx/evm.c
new file mode 100644
index 00000000000..1d8216128c9
--- /dev/null
+++ b/board/ti/am62dx/evm.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Board specific initialization for AM62Dx platforms
+ *
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ *
+ */
+
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
+#include <dm/uclass.h>
+#include <env.h>
+#include <fdt_support.h>
+#include <spl.h>
+#include <asm/arch/k3-ddr.h>
+
+#include "../common/fdt_ops.h"
+
+#if defined(CONFIG_XPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
+{
+	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
+		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+			fixup_ddr_driver_for_ecc(spl_image);
+	} else {
+		fixup_memory_node(spl_image);
+	}
+}
+#endif
+
+#ifdef CONFIG_BOARD_LATE_INIT
+int board_late_init(void)
+{
+	ti_set_fdt_env(NULL, NULL);
+	return 0;
+}
+#endif
-- 
2.34.1

