Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E7BFD3C93D
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 04:42:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BD614892D5;
	Mon, 21 Oct 2024 06:41:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="iYmDagCH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6639689202; Mon, 21 Oct 2024 06:41:33 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E960892D4
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 06:41:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-k6@ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49L4fRoQ011059;
 Sun, 20 Oct 2024 23:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1729485687;
 bh=gsnlNc6LDB5ttS1AnQC2mTziWC7rlh16qCRUpTpF2Ro=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=iYmDagCH8a9EBGn9ik4KebuPpnsT9nGQUclFmgdgnHrAlD2jV9hnmGSv/p236p+iY
 +8ixpJd9lINDVF2K1S4cNXsg9zTNh53QPnhNv/Xnr1RYXMns/W6n5IkKaR7TCGUlLy
 iRc8zkmIh6txZ9+WZ1de1oA6svK7dB1/oXKmTydw=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49L4fR1k080095
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Sun, 20 Oct 2024 23:41:27 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Oct 2024 23:41:26 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Oct 2024 23:41:26 -0500
Received: from santhoshkumark.dhcp.ti.com (santhoshkumark.dhcp.ti.com
 [172.24.227.241])
 by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49L4f2u0059251;
 Sun, 20 Oct 2024 23:41:24 -0500
From: Santhosh Kumar K <s-k6@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <nm@ti.com>, <u-kumar1@ti.com>, 
 <vigneshr@ti.com>, <bb@ti.com>
CC: <u-boot@lists.denx.de>, <w.egorov@phytec.de>, <n-francis@ti.com>,
 <s-k6@ti.com>
Subject: [PATCH v4 7/8] board: ti: Pull redundant DDR functions to a common
 location and Fixup DDR size when ECC is enabled
Date: Mon, 21 Oct 2024 10:10:23 +0530
Message-ID: <20241021044024.835846-8-s-k6@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241021044024.835846-1-s-k6@ti.com>
References: <20241021044024.835846-1-s-k6@ti.com>
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
 arch/arm/mach-k3/include/mach/k3-ddr.h | 15 +++++
 arch/arm/mach-k3/k3-ddr.c              | 88 ++++++++++++++++++++++++++
 board/ti/am62ax/evm.c                  | 17 +++--
 board/ti/am62px/evm.c                  | 17 +++--
 board/ti/am62x/evm.c                   | 62 ++----------------
 board/ti/am64x/evm.c                   | 73 ++-------------------
 board/ti/am65x/evm.c                   | 29 +--------
 board/ti/j721e/evm.c                   | 29 +--------
 board/ti/j721s2/evm.c                  | 35 +++-------
 board/ti/j784s4/evm.c                  | 17 +++--
 11 files changed, 160 insertions(+), 224 deletions(-)
 create mode 100644 arch/arm/mach-k3/include/mach/k3-ddr.h
 create mode 100644 arch/arm/mach-k3/k3-ddr.c

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
index 000000000000..754e9ba29dac
--- /dev/null
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0+
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
index 000000000000..2383d061e93e
--- /dev/null
+++ b/arch/arm/mach-k3/k3-ddr.c
@@ -0,0 +1,88 @@
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
+int dram_init(void)
+{
+        s32 ret;
+
+        ret = fdtdec_setup_mem_size_base_lowest();
+        if (ret)
+                printf("Error setting up mem size and base. %d\n", ret);
+
+        return ret;
+}
+
+int dram_init_banksize(void)
+{
+        s32 ret;
+
+        ret = fdtdec_setup_memory_banksize();
+        if (ret)
+                printf("Error setting up memory banksize. %d\n", ret);
+
+        return ret;
+}
+
+#if defined(CONFIG_SPL_BUILD)
+
+void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image)
+{
+        struct udevice *dev;
+        int ret, ctr = 1;
+
+        dram_init_banksize();
+
+        ret = uclass_get_device(UCLASS_RAM, 0, &dev);
+        if (ret)
+                panic("Cannnot get RAM device for ddr size fixup: %d\n", ret);
+
+        ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
+        if (ret)
+                printf("Error fixing up ddr node for ECC use! %d\n", ret);
+
+        ret = uclass_next_device_err(&dev);
+
+        while (ret && ret != -ENODEV)
+        {
+                ret = k3_ddrss_ddr_fdt_fixup(dev, spl_image->fdt_addr, gd->bd);
+                if (ret)
+                        printf("Error fixing up ddr node %d for ECC use! %d\n", ctr, ret);
+
+                ret = uclass_next_device_err(&dev);
+                ctr++;
+        }
+}
+
+void fixup_memory_node(struct spl_image_info *spl_image)
+{
+        u64 start[CONFIG_NR_DRAM_BANKS];
+        u64 size[CONFIG_NR_DRAM_BANKS];
+        int bank;
+        int ret;
+
+        dram_init();
+        dram_init_banksize();
+
+        for (bank = 0; bank < CONFIG_NR_DRAM_BANKS; bank++)
+        {
+                start[bank] = gd->bd->bi_dram[bank].start;
+                size[bank] = gd->bd->bi_dram[bank].size;
+        }
+
+        ret = fdt_fixup_memory_banks(spl_image->fdt_addr, start, size,
+                                     CONFIG_NR_DRAM_BANKS);
+
+        if (ret)
+                printf("Error fixing up memory node! %d\n", ret);
+}
+
+#endif
diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index 62d3664936e7..ce359be6eaa2 100644
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
index 7362fa4520a3..e85bac40a910 100644
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
 
 #if IS_ENABLED(CONFIG_BOARD_LATE_INIT)
 int board_late_init(void)
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index 9bdd0223cdb6..3dd8d1722a1a 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -19,6 +19,7 @@
 #include <asm/io.h>
 #include <asm/arch/hardware.h>
 #include <dm/uclass.h>
+#include <asm/arch/k3-ddr.h>
 
 #include "../common/fdt_ops.h"
 
@@ -85,11 +86,6 @@ int board_init(void)
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
@@ -98,11 +94,6 @@ int board_late_init(void)
 }
 #endif
 
-int dram_init_banksize(void)
-{
-	return fdtdec_setup_memory_banksize();
-}
-
 #if defined(CONFIG_SPL_BUILD)
 
 void spl_board_init(void)
@@ -113,52 +104,13 @@ void spl_board_init(void)
 
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
index 609e5cf6d51f..61ab1714e5dc 100644
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
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index f3452ff0a8fb..d0385aa25973 100644
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
index 5a0281d6b483..be21b0d95da5 100644
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
index 548dbd5925df..c843c9501588 100644
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

