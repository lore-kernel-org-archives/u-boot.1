Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F266E7717D
	for <u-boot@archiver.kernel.org>; Fri, 13 Dec 2024 10:33:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43F91801BF;
	Fri, 13 Dec 2024 11:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="aAEumIdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6397C8010E; Fri, 13 Dec 2024 11:32:34 +0100 (CET)
Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15C94802C2
 for <u-boot@lists.denx.de>; Fri, 13 Dec 2024 11:32:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 4BDAWTwr3074918
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 13 Dec 2024 04:32:29 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1734085949;
 bh=0suPjILW8K+UKTX+LmW+K7c2MgHT1Pm8TZslaTLlSoc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=aAEumIdk68XZgYzpmFfDwclHtI5X9P+HSBIjBoDK5ukZp4sKEesgSQLTvM/T3ekmH
 /8dhmczzhznZKXwGNVLnTGtmQTHNZ1UNC5C3cik7SG3CH4yK2CXMYSNK1YXY4GDilS
 /UErQl8VY/CFFt600dxG77Yx4+p7PY3KN6krrjhw=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAWTsu006515;
 Fri, 13 Dec 2024 04:32:29 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 13
 Dec 2024 04:32:28 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 13 Dec 2024 04:32:28 -0600
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4BDAVpqE067253;
 Fri, 13 Dec 2024 04:32:25 -0600
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <nm@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <bb@ti.com>, <m-chawdhry@ti.com>, <vaishnav.a@ti.com>, <j-choudhary@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v5 9/9] board: ti: Pull redundant DDR functions to a common
 location and Fixup DDR size when ECC is enabled
Date: Fri, 13 Dec 2024 16:01:29 +0530
Message-ID: <20241213103129.332246-10-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241213103129.332246-1-s-k6@ti.com>
References: <20241213103129.332246-1-s-k6@ti.com>
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
 arch/arm/mach-k3/Makefile              |  2 +-
 arch/arm/mach-k3/include/mach/k3-ddr.h | 15 ++++++
 arch/arm/mach-k3/k3-ddr.c              | 72 +++++++++++++++++++++++++
 board/ti/am62ax/evm.c                  | 17 +++---
 board/ti/am62px/evm.c                  | 17 +++---
 board/ti/am62x/evm.c                   | 63 +++-------------------
 board/ti/am64x/evm.c                   | 73 +++-----------------------
 board/ti/am65x/evm.c                   | 29 +---------
 board/ti/common/Makefile               |  1 +
 board/ti/common/k3-ddr.c               | 33 ++++++++++++
 board/ti/common/k3-ddr.h               | 12 +++++
 board/ti/j721e/evm.c                   | 29 +---------
 board/ti/j721s2/evm.c                  | 35 ++++--------
 board/ti/j784s4/evm.c                  | 17 +++---
 14 files changed, 190 insertions(+), 225 deletions(-)
 create mode 100644 arch/arm/mach-k3/include/mach/k3-ddr.h
 create mode 100644 arch/arm/mach-k3/k3-ddr.c
 create mode 100644 board/ti/common/k3-ddr.c
 create mode 100644 board/ti/common/k3-ddr.h

diff --git a/arch/arm/mach-k3/Makefile b/arch/arm/mach-k3/Makefile
index 8c4f6786a5b5..5ce7fc62d80c 100644
--- a/arch/arm/mach-k3/Makefile
+++ b/arch/arm/mach-k3/Makefile
@@ -6,7 +6,7 @@
 obj-$(CONFIG_ARM64) += arm64/
 obj-$(CONFIG_CPU_V7R) += r5/
 obj-$(CONFIG_OF_LIBFDT) += common_fdt.o
-obj-y += common.o security.o
+obj-y += common.o security.o k3-ddr.o
 obj-$(CONFIG_SOC_K3_AM62A7) += am62ax/
 obj-$(CONFIG_SOC_K3_AM62P5) += am62px/
 obj-$(CONFIG_SOC_K3_AM625) += am62x/
diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
new file mode 100644
index 000000000000..95496e1c59dc
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef _K3_DDR_H_
+#define _K3_DDR_H_
+
+int dram_init(void);
+int dram_init_banksize(void);
+
+void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
+void fixup_memory_node(struct spl_image_info *spl_image);
+
+#endif /* _K3_DDR_H_ */
diff --git a/arch/arm/mach-k3/k3-ddr.c b/arch/arm/mach-k3/k3-ddr.c
new file mode 100644
index 000000000000..6e3e60cdc865
--- /dev/null
+++ b/arch/arm/mach-k3/k3-ddr.c
@@ -0,0 +1,72 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <fdt_support.h>
+#include <dm/uclass.h>
+#include <k3-ddrss.h>
+#include <spl.h>
+
+#include <asm/arch/k3-ddr.h>
+
+__weak int dram_init(void)
+{
+	return 0;
+}
+
+__weak int dram_init_banksize(void)
+{
+	return 0;
+}
+
+#if defined(CONFIG_SPL_BUILD)
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
+	ret = uclass_next_device_err(&dev);
+
+	while (ret && ret != -ENODEV) {
+		ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
+		if (ret)
+			printf("Error fixing up ddr node %d for ECC use! %d\n", ctr, ret);
+
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
+#endif
diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index 62d3664936e7..3351544c5b37 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -12,6 +12,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/fdt_ops.h"
 
@@ -20,15 +21,17 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
+#if defined(CONFIG_XPL_BUILD)
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
index 7362fa4520a3..75359fa1614c 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -13,6 +13,7 @@
 #include <env.h>
 #include <fdt_support.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 #include "../common/fdt_ops.h"
 
 struct efi_fw_image fw_images[] = {
@@ -53,15 +54,17 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
+#if defined(CONFIG_XPL_BUILD)
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
 
 #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 9075df01cac6..279ceba95547 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -20,6 +20,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <dm/uclass.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/fdt_ops.h"
 
@@ -86,11 +87,6 @@ int board_init(void)
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
@@ -99,13 +95,7 @@ int board_late_init(void)
 }
 #endif
 
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
-}
-
 #if defined(CONFIG_XPL_BUILD)
-
 void spl_board_init(void)
 {
 	enable_caches();
@@ -114,53 +104,14 @@ void spl_board_init(void)
 
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
index 00b8317d6bf9..6f7e1f828668 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -15,6 +15,7 @@
 #include <fdt_support.h>
 #include <asm/arch/hardware.h>
 #include <env.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -66,28 +67,6 @@ int board_init(void)
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
@@ -132,52 +111,14 @@ static int fixup_usb_boot(const void *fdt_blob)
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
index 07073a5940b1..6658794a1375 100644
--- a/board/ti/am65x/evm.c
+++ b/board/ti/am65x/evm.c
@@ -20,6 +20,7 @@
 #include <env.h>
 #include <spl.h>
 #include <linux/printk.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
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
index 5ac361ba7fcf..caf6b9fa8c14 100644
--- a/board/ti/common/Makefile
+++ b/board/ti/common/Makefile
@@ -4,3 +4,4 @@
 obj-${CONFIG_TI_I2C_BOARD_DETECT} += board_detect.o
 obj-${CONFIG_CMD_EXTENSION} += cape_detect.o
 obj-${CONFIG_OF_LIBFDT} += fdt_ops.o
+obj-${CONFIG_ARCH_K3} += k3-ddr.o
diff --git a/board/ti/common/k3-ddr.c b/board/ti/common/k3-ddr.c
new file mode 100644
index 000000000000..a8425da8de5c
--- /dev/null
+++ b/board/ti/common/k3-ddr.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#include <fdt_support.h>
+#include <dm/uclass.h>
+#include <k3-ddrss.h>
+#include <spl.h>
+
+#include "k3-ddr.h"
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
diff --git a/board/ti/common/k3-ddr.h b/board/ti/common/k3-ddr.h
new file mode 100644
index 000000000000..737d45e2e509
--- /dev/null
+++ b/board/ti/common/k3-ddr.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2024, Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef __K3_DDR_INIT_H
+#define __K3_DDR_INIT_H
+
+int dram_init(void);
+int dram_init_banksize(void);
+
+#endif /* __K3_DDR_INIT_H */
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 6221be9dcff8..4b5b9dded7b0 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -15,6 +15,7 @@
 #include <asm/gpio.h>
 #include <spl.h>
 #include <dm.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
@@ -77,17 +78,6 @@ int board_init(void)
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
@@ -99,23 +89,6 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
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
index 2cfeb3bec6c2..1b5ad19df7f4 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -21,6 +21,7 @@
 #include <dm.h>
 #include <dm/uclass-internal.h>
 #include <dm/root.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/board_detect.h"
 #include "../common/fdt_ops.h"
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
+#if defined(CONFIG_XPL_BUILD)
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
index 548dbd5925df..d317f3eccbba 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -10,6 +10,7 @@
 #include <efi_loader.h>
 #include <init.h>
 #include <spl.h>
+#include <asm/arch/k3-ddr.h>
 #include "../common/fdt_ops.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -52,15 +53,17 @@ int board_init(void)
 	return 0;
 }
 
-int dram_init(void)
+#if defined(CONFIG_XPL_BUILD)
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

