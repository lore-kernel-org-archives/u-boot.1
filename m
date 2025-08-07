Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC770C87FCA
	for <u-boot@archiver.kernel.org>; Thu,  7 Aug 2025 11:39:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C448452C;
	Thu,  7 Aug 2025 13:38:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4D4FE84508; Thu,  7 Aug 2025 13:38:57 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C56B84564
 for <u-boot@lists.denx.de>; Thu,  7 Aug 2025 13:38:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS34.andestech.com [10.0.1.134])
 by Atcsqr.andestech.com with ESMTPS id 577Bcbkc077785
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK)
 for <u-boot@lists.denx.de>; Thu, 7 Aug 2025 19:38:37 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Aug
 2025 19:38:37 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <randolph@andestech.com>, <tim609@andestech.com>
Subject: [PATCH 4/6] board: andestech: Add Voyager board support
Date: Thu, 7 Aug 2025 19:38:32 +0800
Message-ID: <20250807113832.362507-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs34.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 577Bcbkc077785
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

Introduce Voyager board specific code, including
- dram info
- shared cache enabling

Signed-off-by: Randolph Sheng-Kai Lin <randolph@andestech.com>
Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 board/andestech/voyager/Makefile  |  6 +++
 board/andestech/voyager/voyager.c | 71 +++++++++++++++++++++++++++++++
 include/configs/voyager.h         | 40 +++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 board/andestech/voyager/Makefile
 create mode 100644 board/andestech/voyager/voyager.c
 create mode 100644 include/configs/voyager.h

diff --git a/board/andestech/voyager/Makefile b/board/andestech/voyager/Makefile
new file mode 100644
index 00000000000..d293e3e2d89
--- /dev/null
+++ b/board/andestech/voyager/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Copyright (C) 2025 Andes Technology Corporation.
+# Randolph Lin, Andes Technology Corporation <randolph@andestech.com>
+
+obj-y	:= voyager.o
diff --git a/board/andestech/voyager/voyager.c b/board/andestech/voyager/voyager.c
new file mode 100644
index 00000000000..22d4a18d94e
--- /dev/null
+++ b/board/andestech/voyager/voyager.c
@@ -0,0 +1,71 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2025 Andes Technology Corporation
+ * Randolph Lin, Andes Technology Corporation <randolph@andestech.com>
+ */
+
+#include <asm/csr.h>
+#include <asm/global_data.h>
+#include <asm/sbi.h>
+#include <config.h>
+#include <cpu_func.h>
+#include <dm.h>
+#include <env.h>
+#include <fdtdec.h>
+#include <flash.h>
+#include <image.h>
+#include <init.h>
+#include <linux/io.h>
+#include <net.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
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
+
+#ifdef CONFIG_SPL_BOARD_INIT
+void spl_board_init(void)
+{
+	/* enable andes-l2 cache */
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		enable_caches();
+}
+#endif
+
+
+#ifdef CONFIG_BOARD_EARLY_INIT_R
+int board_early_init_r(void)
+{
+	/* enable andes-l2 cache */
+	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
+		enable_caches();
+
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_SPL
+void board_boot_order(u32 *spl_boot_list)
+{
+	u8 i;
+	u32 boot_devices[] = {
+#ifdef CONFIG_SPL_RAM_SUPPORT
+		BOOT_DEVICE_RAM,
+#endif
+#ifdef CONFIG_SPL_MMC
+		BOOT_DEVICE_MMC1,
+#endif
+	};
+
+	for (i = 0; i < ARRAY_SIZE(boot_devices); i++)
+		spl_boot_list[i] = boot_devices[i];
+}
+#endif
diff --git a/include/configs/voyager.h b/include/configs/voyager.h
new file mode 100644
index 00000000000..f6630b07ec9
--- /dev/null
+++ b/include/configs/voyager.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2025 Andes Technology Corporation
+ * Randolph Lin, Andes Technology Corporation <randolph@andestech.com>
+ */
+
+#ifndef __CONFIG_H
+#define __CONFIG_H
+
+#define RISCV_MMODE_TIMERBASE           0xe6000000
+#define RISCV_MMODE_TIMER_FREQ          60000000
+
+#define RISCV_SMODE_TIMER_FREQ          60000000
+
+/* support JEDEC */
+#define PHYS_FLASH_1                   0x8000000       /* BANK 0 */
+#define CFG_SYS_FLASH_BASE             PHYS_FLASH_1
+#define CFG_SYS_FLASH_BANKS_LIST       { PHYS_FLASH_1, }
+#define CFG_SYS_FLASH_BANKS_SIZES      { 0x4000000 }
+
+/* Enable distro boot */
+#define BOOT_TARGET_DEVICES(func) \
+	func(MMC, mmc, 0) \
+	func(DHCP, dhcp, na)
+
+#include <config_distro_bootcmd.h>
+
+#define CFG_EXTRA_ENV_SETTINGS	\
+				"fdt_high=0xffffffffffffffff\0" \
+				"initrd_high=0xffffffffffffffff\0" \
+				"kernel_addr_r=0x400600000\0" \
+				"kernel_comp_addr_r=0x404600000\0" \
+				"kernel_comp_size=0x04000000\0" \
+				"pxefile_addr_r=0x408600000\0" \
+				"scriptaddr=0x408700000\0" \
+				"fdt_addr_r=0x408800000\0" \
+				"ramdisk_addr_r=0x408900000\0" \
+				BOOTENV
+
+#endif /* __CONFIG_H */
-- 
2.34.1

