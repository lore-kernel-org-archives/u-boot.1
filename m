Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3381CC25B10
	for <u-boot@archiver.kernel.org>; Fri, 10 May 2024 08:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 797B48885C;
	Fri, 10 May 2024 10:48:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="BVp0kCbu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 955A488287; Fri, 10 May 2024 10:48:38 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C48DF88256
 for <u-boot@lists.denx.de>; Fri, 10 May 2024 10:48:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mYlW022464;
 Fri, 10 May 2024 03:48:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1715330914;
 bh=ea8+XzR5Js4wHlM+T/q+8r+rLm86BT5lZyz3ZuIL8JI=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=BVp0kCbueW/irhzqGbYe16kfgK9ifFEi/3bqN6uCzuE/MWZrUKYDD6u9J8bmQ0sNI
 pcjtmRpeGEABsfuEZuMIiCMXrjN31H0/P6w2G2dz05jwpWvqomSvkEXQPsFrtz1TDx
 yHGbhAwzudL6kDV1ok2ZzN63CQ35tNlpSK9v5Its=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44A8mYgd000630
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 10 May 2024 03:48:34 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 10
 May 2024 03:48:34 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 10 May 2024 03:48:33 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44A8mA1g107745;
 Fri, 10 May 2024 03:48:31 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <bb@ti.com>,
 <u-kumar1@ti.com>, <m-chawdhry@ti.com>
CC: <u-boot@lists.denx.de>, <n-francis@ti.com>, <s-k6@ti.com>
Subject: [PATCH v2 7/8] board: ti: Pull redundant DDR functions to a common
 location and Fixup DDR size when ECC is enabled
Date: Fri, 10 May 2024 14:17:06 +0530
Message-ID: <20240510084707.1903133-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240510084707.1903133-1-s-k6@ti.com>
References: <20240510084707.1903133-1-s-k6@ti.com>
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

As there are few redundant functions in board/ti/*/evm.c files, pull
them to a common location of access to reuse and include the common file
to access the functions.

Call k3-ddrss driver through fixup_ddr_driver_for_ecc() to fixup the
device tree and resize the available amount of DDR, if ECC is enabled.
Otherwise, fixup the device tree using the regular
fdt_fixup_memory_banks().

Also call dram_init_banksize() after every call to
fixup_ddr_driver_for_ecc() is made so that gd->bd is populated
correctly.

Ensure that fixup_ddr_driver_for_ecc() is agnostic to the number of DDR
controllers present.

Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
Signed-off-by: Neha Malcom Francis <n-francis@ti.com>
---
 board/ti/am62ax/evm.c         | 17 ++++---
 board/ti/am62px/evm.c         | 18 ++++---
 board/ti/am62x/evm.c          | 63 ++++---------------------
 board/ti/am64x/evm.c          | 73 +++-------------------------
 board/ti/am65x/evm.c          | 29 +-----------
 board/ti/common/Makefile      |  1 +
 board/ti/common/k3-ddr-init.c | 89 +++++++++++++++++++++++++++++++++++
 board/ti/common/k3-ddr-init.h | 15 ++++++
 board/ti/j721e/evm.c          | 29 +-----------
 board/ti/j721s2/evm.c         | 35 ++++----------
 board/ti/j784s4/evm.c         | 17 ++++---
 11 files changed, 163 insertions(+), 223 deletions(-)
 create mode 100644 board/ti/common/k3-ddr-init.c
 create mode 100644 board/ti/common/k3-ddr-init.h

diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index 62d3664936e7..3d7bd369a452 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -14,21 +14,24 @@
 #include <spl.h>
 
 #include "../common/fdt_ops.h"
+#include "../common/k3-ddr-init.h"
 
 int board_init(void)
 {
 	return 0;
 }
 
-int dram_init(void)
+#if defined(CONFIG_SPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-	return fdtdec_setup_mem_size_base();
-}
-
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
+	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
+		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+			fixup_ddr_driver_for_ecc(spl_image);
+	} else {
+		fixup_memory_node(spl_image);
+	}
 }
+#endif
 
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index 97a95ce8cc2d..aa7db61eb411 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -13,17 +13,21 @@
 #include <fdt_support.h>
 #include <spl.h>
 
+#include "../common/k3-ddr-init.h"
+
 int board_init(void)
 {
 	return 0;
 }
 
-int dram_init(void)
-{
-	return fdtdec_setup_mem_size_base();
-}
-
-int dram_init_banksize(void)
+#if defined(CONFIG_SPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-	return fdtdec_setup_memory_banksize();
+	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
+		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+			fixup_ddr_driver_for_ecc(spl_image);
+	} else {
+		fixup_memory_node(spl_image);
+	}
 }
+#endif
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index b3e8680dfab2..32ba37963212 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -21,6 +21,8 @@
 
 #include "../common/fdt_ops.h"
 
+#include "../common/k3-ddr-init.h"
+
 DECLARE_GLOBAL_DATA_PTR;
 
 #if CONFIG_IS_ENABLED(SPLASH_SCREEN)
@@ -51,11 +53,6 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
-{
-	return fdtdec_setup_mem_size_base();
-}
-
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
 {
@@ -64,11 +61,6 @@ int board_late_init(void)
 }
 #endif
 
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
-}
-
 #if defined(CONFIG_SPL_BUILD)
 
 void spl_board_init(void)
@@ -79,52 +71,13 @@ void spl_board_init(void)
 
 }
 
-#if defined(CONFIG_K3_AM64_DDRSS)
-static void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
-{
-	struct udevice *dev;
-	int ret;
-
-	dram_init_banksize();
-
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret)
-		panic("Cannot get RAM device for ddr size fixup: %d\n", ret);
-
-	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
-	if (ret)
-		printf("Error fixing up ddr node for ECC use! %d\n", ret);
-}
-#else
-static void fixup_memory_node(struct spl_image_info *spl_image)
-{
-	u64 start[CONFIG_NR_DRAM_BANKS];
-	u64 size[CONFIG_NR_DRAM_BANKS];
-	int bank;
-	int ret;
-
-	dram_init();
-	dram_init_banksize();
-
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] =  gd->bd->bi_dram[bank].start;
-		size[bank] = gd->bd->bi_dram[bank].size;
-	}
-
-	/* dram_init functions use SPL fdt, and we must fixup u-boot fdt */
-	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
-				     CONFIG_NR_DRAM_BANKS);
-	if (ret)
-		printf("Error fixing up memory node! %d\n", ret);
-}
-#endif
-
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-#if defined(CONFIG_K3_AM64_DDRSS)
-	fixup_ddr_driver_for_ecc(spl_image);
-#else
-	fixup_memory_node(spl_image);
-#endif
+	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
+		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+			fixup_ddr_driver_for_ecc(spl_image);
+	} else {
+		fixup_memory_node(spl_image);
+	}
 }
 #endif
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index b8de69da06c5..e63f2d028263 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -17,6 +17,7 @@
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
+#include "../common/k3-ddr-init.h"
 
 #define board_is_am64x_gpevm() (board_ti_k3_is("AM64-GPEVM") || \
 				board_ti_k3_is("AM64-EVM") || \
@@ -32,28 +33,6 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
-{
-	s32 ret;
-
-	ret = fdtdec_setup_mem_size_base();
-	if (ret)
-		printf("Error setting up mem size and base. %d\n", ret);
-
-	return ret;
-}
-
-int dram_init_banksize(void)
-{
-	s32 ret;
-
-	ret = fdtdec_setup_memory_banksize();
-	if (ret)
-		printf("Error setting up memory banksize. %d\n", ret);
-
-	return ret;
-}
-
 #if defined(CONFIG_SPL_LOAD_FIT)
 int board_fit_config_name_match(const char *name)
 {
@@ -98,52 +77,14 @@ static int fixup_usb_boot(const void *fdt_blob)
 }
 #endif
 
-#if defined(CONFIG_K3_AM64_DDRSS)
-static void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
-{
-	struct udevice *dev;
-	int ret;
-
-	dram_init_banksize();
-
-	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
-	if (ret)
-		panic("Cannot get RAM device for ddr size fixup: %d\n", ret);
-
-	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
-	if (ret)
-		printf("Error fixing up ddr node for ECC use! %d\n", ret);
-}
-#else
-static void fixup_memory_node(struct spl_image_info *spl_image)
-{
-	u64 start[CONFIG_NR_DRAM_BANKS];
-	u64 size[CONFIG_NR_DRAM_BANKS];
-	int bank;
-	int ret;
-
-	dram_init();
-	dram_init_banksize();
-
-	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
-		start[bank] =  gd->bd->bi_dram[bank].start;
-		size[bank] = gd->bd->bi_dram[bank].size;
-	}
-
-	/* dram_init functions use SPL fdt, and we must fixup u-boot fdt */
-	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size, CONFIG_NR_DRAM_BANKS);
-	if (ret)
-		printf("Error fixing up memory node! %d\n", ret);
-}
-#endif
-
 void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-#if defined(CONFIG_K3_AM64_DDRSS)
-	fixup_ddr_driver_for_ecc(spl_image);
-#else
-	fixup_memory_node(spl_image);
-#endif
+	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
+		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+			fixup_ddr_driver_for_ecc(spl_image);
+	} else {
+		fixup_memory_node(spl_image);
+	}
 
 #if CONFIG_IS_ENABLED(USB_STORAGE)
 	fixup_usb_boot(spl_image->fdt_addr);
diff --git a/board/ti/am65x/evm.c b/board/ti/am65x/evm.c
index 07073a5940b1..ea60752d3719 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -23,6 +23,7 @@
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
+#include "../common/k3-ddr-init.h"
 
 #define board_is_am65x_base_board()	board_ti_is("AM6-COMPROCEVM")
 
@@ -49,17 +50,6 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
-{
-#ifdef CONFIG_PHYS_64BIT
-	gd->ram_size = 0x100000000;
-#else
-	gd->ram_size = 0x80000000;
-#endif
-
-	return 0;
-}
-
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 #ifdef CONFIG_PHYS_64BIT
@@ -71,23 +61,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return gd->ram_top;
 }
 
-int dram_init_banksize(void)
-{
-	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = 0x80000000;
-	gd->bd->bi_dram[0].size = 0x80000000;
-	gd->ram_size = 0x80000000;
-
-#ifdef CONFIG_PHYS_64BIT
-	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = 0x880000000;
-	gd->bd->bi_dram[1].size = 0x80000000;
-	gd->ram_size = 0x100000000;
-#endif
-
-	return 0;
-}
-
 #ifdef CONFIG_SPL_LOAD_FIT
 int board_fit_config_name_match(const char *name)
 {
diff --git a/board/ti/common/Makefile b/board/ti/common/Makefile
index 5ac361ba7fcf..070dec3aebf5 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -4,3 +4,4 @@
 obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
 obj-${CONFIG_CMD_EXTENSION} += cape_detect.o
 obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
+obj-${CONFIG_ARCH_K3} += k3-ddr-init.o
diff --git a/board/ti/common/k3-ddr-init.c b/board/ti/common/k3-ddr-init.c
new file mode 100644
index 000000000000..228b95774b97
--- /dev/null
+++ b/board/ti/common/k3-ddr-init.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2023, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <fdt_support.h>
+#include <dm/uclass.h>
+#include <k3-ddrss.h>
+#include <spl.h>
+
+#include "k3-ddr-init.h"
+
+int dram_init(void)
+{
+	s32 ret;
+
+	ret = fdtdec_setup_mem_size_base_lowest();
+	if (ret)
+		printf("Error setting up mem size and base. %d\n", ret);
+
+	return ret;
+}
+
+int dram_init_banksize(void)
+{
+	s32 ret;
+
+	ret = fdtdec_setup_memory_banksize();
+	if (ret)
+		printf("Error setting up memory banksize. %d\n", ret);
+
+	return ret;
+}
+
+#if defined(CONFIG_SPL_BUILD)
+
+void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
+{
+	struct udevice *dev;
+	int ret, ctr = 1;
+
+	dram_init_banksize();
+
+	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+	if (ret)
+		panic("Cannnot get RAM device for ddr size fixup: %d\n", ret);
+
+	ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
+	if (ret)
+		printf("Error fixing up ddr node for ECC use! %d\n", ret);
+
+	dram_init_banksize();
+
+	ret = uclass_next_device_err(&dev);
+
+	while (!ret) {
+		ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
+		if (ret)
+			printf("Error fixing up ddr node %d for ECC use! %d\n", ctr, ret);
+
+		dram_init_banksize();
+		ret = uclass_next_device_err(&dev);
+		ctr++;
+	}
+}
+
+void fixup_memory_node(struct spl_image_info *spl_image)
+{
+	u64 start[CONFIG_NR_DRAM_BANKS];
+	u64 size[CONFIG_NR_DRAM_BANKS];
+	int bank;
+	int ret;
+
+	dram_init();
+	dram_init_banksize();
+
+	for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++) {
+		start[bank] = gd->bd->bi_dram[bank].start;
+		size[bank] = gd->bd->bi_dram[bank].size;
+	}
+
+	ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
+				     CONFIG_NR_DRAM_BANKS);
+
+	if (ret)
+		printf("Error fixing up memory node! %d\n", ret);
+}
+
+#endif
diff --git a/board/ti/common/k3-ddr-init.h b/board/ti/common/k3-ddr-init.h
new file mode 100644
index 000000000000..9d1826815dfd
--- /dev/null
+++ b/board/ti/common/k3-ddr-init.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2023, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __K3_DDR_INIT_H
+#define __K3_DDR_INIT_H
+
+int dram_init(void);
+int dram_init_banksize(void);
+
+void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
+void fixup_memory_node(struct spl_image_info *spl_image);
+
+#endif /* __K3_DDR_INIT_H */
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 539eaf47186a..e0cd8529bc2b 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -17,6 +17,7 @@
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
+#include "../common/k3-ddr-init.h"
 
 #define board_is_j721e_som()	(board_ti_k3_is("J721EX-PM1-SOM") || \
 				 board_ti_k3_is("J721EX-PM2-SOM"))
@@ -37,17 +38,6 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
-{
-#ifdef CONFIG_PHYS_64BIT
-	gd->ram_size = 0x100000000;
-#else
-	gd->ram_size = 0x80000000;
-#endif
-
-	return 0;
-}
-
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 #ifdef CONFIG_PHYS_64BIT
@@ -59,23 +49,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return gd->ram_top;
 }
 
-int dram_init_banksize(void)
-{
-	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = 0x80000000;
-	gd->bd->bi_dram[0].size = 0x80000000;
-	gd->ram_size = 0x80000000;
-
-#ifdef CONFIG_PHYS_64BIT
-	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = 0x880000000;
-	gd->bd->bi_dram[1].size = 0x80000000;
-	gd->ram_size = 0x100000000;
-#endif
-
-	return 0;
-}
-
 #ifdef CONFIG_SPL_LOAD_FIT
 int board_fit_config_name_match(const char *name)
 {
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 5a0281d6b483..fca30107cddb 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -24,6 +24,7 @@
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
+#include "../common/k3-ddr-init.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -32,17 +33,6 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
-{
-#ifdef CONFIG_PHYS_64BIT
-	gd->ram_size = 0x100000000;
-#else
-	gd->ram_size = 0x80000000;
-#endif
-
-	return 0;
-}
-
 phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 {
 #ifdef CONFIG_PHYS_64BIT
@@ -54,22 +44,17 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 	return gd->ram_top;
 }
 
-int dram_init_banksize(void)
+#if defined(CONFIG_SPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-	/* Bank 0 declares the memory available in the DDR low region */
-	gd->bd->bi_dram[0].start = 0x80000000;
-	gd->bd->bi_dram[0].size = 0x7fffffff;
-	gd->ram_size = 0x80000000;
-
-#ifdef CONFIG_PHYS_64BIT
-	/* Bank 1 declares the memory available in the DDR high region */
-	gd->bd->bi_dram[1].start = 0x880000000;
-	gd->bd->bi_dram[1].size = 0x37fffffff;
-	gd->ram_size = 0x400000000;
-#endif
-
-	return 0;
+	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
+		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+			fixup_ddr_driver_for_ecc(spl_image);
+	} else {
+		fixup_memory_node(spl_image);
+	}
 }
+#endif
 
 #ifdef CONFIG_TI_I2C_BOARD_DETECT
 /*
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index aed0ea5b9495..73056a16dd5f 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -10,6 +10,7 @@
 #include <init.h>
 #include <spl.h>
 #include "../common/fdt_ops.h"
+#include "../common/k3-ddr-init.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -18,15 +19,17 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
+#if defined(CONFIG_SPL_BUILD)
+void spl_perform_fixups(struct spl_image_info *spl_image)
 {
-	return fdtdec_setup_mem_size_base();
-}
-
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
+	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
+		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
+			fixup_ddr_driver_for_ecc(spl_image);
+	} else {
+		fixup_memory_node(spl_image);
+	}
 }
+#endif
 
 #ifdef CONFIG_BOARD_LATE_INIT
 int board_late_init(void)
-- 
2.34.1

