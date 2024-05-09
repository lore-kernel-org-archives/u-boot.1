Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0EDC04FFE
	for <u-boot@archiver.kernel.org>; Thu,  9 May 2024 01:03:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F73B882A8;
	Thu,  9 May 2024 03:03:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=andestech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6A3D38833D; Thu,  9 May 2024 03:03:26 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 33FD28811D
 for <u-boot@lists.denx.de>; Thu,  9 May 2024 03:03:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none)
 header.from=andestech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=ycliang@andestech.com
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44913FjY046290
 for <u-boot@lists.denx.de>; Thu, 9 May 2024 09:03:15 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Thu, 9 May 2024 09:03:15 +0800
From: Leo Yu-Chi Liang <ycliang@andestech.com>
To: <u-boot@lists.denx.de>
CC: <ycliang@andestech.com>, <tim609@andestech.com>, <randolph@andestech.com>, 
 <dylan@andestech.com>
Subject: [PATCH 1/1] andes: Unify naming policy for Andes related source
Date: Thu, 9 May 2024 09:03:10 +0800
Message-ID: <20240509010310.3680186-1-ycliang@andestech.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44913FjY046290
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

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 arch/riscv/Kconfig                            |  2 +-
 arch/riscv/cpu/{andesv5 => andes}/Kconfig     |  4 +-
 arch/riscv/cpu/{andesv5 => andes}/Makefile    |  0
 arch/riscv/cpu/{andesv5 => andes}/cache.c     | 12 +++---
 arch/riscv/cpu/{andesv5 => andes}/cpu.c       |  0
 arch/riscv/cpu/{andesv5 => andes}/spl.c       |  0
 board/{AndesTech => andestech}/ae350/Kconfig  |  4 +-
 .../ae350/MAINTAINERS                         |  0
 board/{AndesTech => andestech}/ae350/Makefile |  0
 board/{AndesTech => andestech}/ae350/ae350.c  |  2 +-
 drivers/cache/Kconfig                         |  6 +--
 drivers/cache/Makefile                        |  2 +-
 .../cache/{cache-v5l2.c => cache-andes-l2.c}  | 40 +++++++++----------
 13 files changed, 36 insertions(+), 36 deletions(-)
 rename arch/riscv/cpu/{andesv5 => andes}/Kconfig (91%)
 rename arch/riscv/cpu/{andesv5 => andes}/Makefile (100%)
 rename arch/riscv/cpu/{andesv5 => andes}/cache.c (90%)
 rename arch/riscv/cpu/{andesv5 => andes}/cpu.c (100%)
 rename arch/riscv/cpu/{andesv5 => andes}/spl.c (100%)
 rename board/{AndesTech => andestech}/ae350/Kconfig (94%)
 rename board/{AndesTech => andestech}/ae350/MAINTAINERS (100%)
 rename board/{AndesTech => andestech}/ae350/Makefile (100%)
 rename board/{AndesTech => andestech}/ae350/ae350.c (99%)
 rename drivers/cache/{cache-v5l2.c => cache-andes-l2.c} (84%)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7e20ef63bb..120ee1a01c 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -93,7 +93,7 @@ source "board/thead/th1520_lpi4a/Kconfig"
 source "board/xilinx/mbv/Kconfig"
 
 # platform-specific options below
-source "arch/riscv/cpu/andesv5/Kconfig"
+source "arch/riscv/cpu/andes/Kconfig"
 source "arch/riscv/cpu/cv1800b/Kconfig"
 source "arch/riscv/cpu/fu540/Kconfig"
 source "arch/riscv/cpu/fu740/Kconfig"
diff --git a/arch/riscv/cpu/andesv5/Kconfig b/arch/riscv/cpu/andes/Kconfig
similarity index 91%
rename from arch/riscv/cpu/andesv5/Kconfig
rename to arch/riscv/cpu/andes/Kconfig
index e3efb0de8f..120fec5e54 100644
--- a/arch/riscv/cpu/andesv5/Kconfig
+++ b/arch/riscv/cpu/andes/Kconfig
@@ -1,4 +1,4 @@
-config RISCV_NDS
+config RISCV_ANDES
 	bool
 	select ARCH_EARLY_INIT_R
 	select SYS_CACHE_SHIFT_6
@@ -8,7 +8,7 @@ config RISCV_NDS
 	imply ANDES_PLMT_TIMER
 	imply SPL_ANDES_PLMT_TIMER
 	imply ANDES_PLICSW if (RISCV_MMODE || SPL_RISCV_MMODE)
-	imply V5L2_CACHE
+	imply ANDES_L2_CACHE
 	imply SPL_CPU
 	imply SPL_OPENSBI
 	imply SPL_LOAD_FIT
diff --git a/arch/riscv/cpu/andesv5/Makefile b/arch/riscv/cpu/andes/Makefile
similarity index 100%
rename from arch/riscv/cpu/andesv5/Makefile
rename to arch/riscv/cpu/andes/Makefile
diff --git a/arch/riscv/cpu/andesv5/cache.c b/arch/riscv/cpu/andes/cache.c
similarity index 90%
rename from arch/riscv/cpu/andesv5/cache.c
rename to arch/riscv/cpu/andes/cache.c
index 269bb27f75..801857ab8f 100644
--- a/arch/riscv/cpu/andesv5/cache.c
+++ b/arch/riscv/cpu/andes/cache.c
@@ -12,21 +12,21 @@
 #include <dm/uclass-internal.h>
 #include <asm/arch-andes/csr.h>
 
-#ifdef CONFIG_V5L2_CACHE
+#ifdef CONFIG_ANDES_L2_CACHE
 void enable_caches(void)
 {
 	struct udevice *dev;
 	int ret;
 
 	ret = uclass_get_device_by_driver(UCLASS_CACHE,
-					  DM_DRIVER_GET(v5l2_cache),
+					  DM_DRIVER_GET(andes_l2_cache),
 					  &dev);
 	if (ret) {
-		log_debug("Cannot enable v5l2 cache\n");
+		log_debug("Cannot enable andes-l2 cache\n");
 	} else {
 		ret = cache_enable(dev);
 		if (ret)
-			log_debug("v5l2 cache enable failed\n");
+			log_debug("andes-l2 cache enable failed\n");
 	}
 }
 
@@ -78,7 +78,7 @@ void dcache_enable(void)
 	asm volatile("csrsi %0, 0x2" :: "i"(CSR_MCACHE_CTL));
 #endif
 
-#ifdef CONFIG_V5L2_CACHE
+#ifdef CONFIG_ANDES_L2_CACHE
 	cache_ops(cache_enable);
 #endif
 }
@@ -89,7 +89,7 @@ void dcache_disable(void)
 	asm volatile("csrci %0, 0x2" :: "i"(CSR_MCACHE_CTL));
 #endif
 
-#ifdef CONFIG_V5L2_CACHE
+#ifdef CONFIG_ANDES_L2_CACHE
 	cache_ops(cache_disable);
 #endif
 }
diff --git a/arch/riscv/cpu/andesv5/cpu.c b/arch/riscv/cpu/andes/cpu.c
similarity index 100%
rename from arch/riscv/cpu/andesv5/cpu.c
rename to arch/riscv/cpu/andes/cpu.c
diff --git a/arch/riscv/cpu/andesv5/spl.c b/arch/riscv/cpu/andes/spl.c
similarity index 100%
rename from arch/riscv/cpu/andesv5/spl.c
rename to arch/riscv/cpu/andes/spl.c
diff --git a/board/AndesTech/ae350/Kconfig b/board/andestech/ae350/Kconfig
similarity index 94%
rename from board/AndesTech/ae350/Kconfig
rename to board/andestech/ae350/Kconfig
index a85e7d6351..1c95e8447f 100644
--- a/board/AndesTech/ae350/Kconfig
+++ b/board/andestech/ae350/Kconfig
@@ -1,7 +1,7 @@
 if TARGET_ANDES_AE350
 
 config SYS_CPU
-	default "andesv5"
+	default "andes"
 
 config SYS_BOARD
 	default "ae350"
@@ -33,7 +33,7 @@ config SYS_FDT_BASE
 
 config BOARD_SPECIFIC_OPTIONS # dummy
 	def_bool y
-	select RISCV_NDS
+	select RISCV_ANDES
 	select SUPPORT_SPL
 	select BINMAN if SPL
 	imply SMP
diff --git a/board/AndesTech/ae350/MAINTAINERS b/board/andestech/ae350/MAINTAINERS
similarity index 100%
rename from board/AndesTech/ae350/MAINTAINERS
rename to board/andestech/ae350/MAINTAINERS
diff --git a/board/AndesTech/ae350/Makefile b/board/andestech/ae350/Makefile
similarity index 100%
rename from board/AndesTech/ae350/Makefile
rename to board/andestech/ae350/Makefile
diff --git a/board/AndesTech/ae350/ae350.c b/board/andestech/ae350/ae350.c
similarity index 99%
rename from board/AndesTech/ae350/ae350.c
rename to board/andestech/ae350/ae350.c
index 62b93b4ecb..5ae5baed6b 100644
--- a/board/AndesTech/ae350/ae350.c
+++ b/board/andestech/ae350/ae350.c
@@ -99,7 +99,7 @@ void *board_fdt_blob_setup(int *err)
 #ifdef CONFIG_SPL_BOARD_INIT
 void spl_board_init()
 {
-	/* enable v5l2 cache */
+	/* enable andes-l2 cache */
 	if (!CONFIG_IS_ENABLED(SYS_DCACHE_OFF))
 		enable_caches();
 }
diff --git a/drivers/cache/Kconfig b/drivers/cache/Kconfig
index 26c2d80a1c..4f35865744 100644
--- a/drivers/cache/Kconfig
+++ b/drivers/cache/Kconfig
@@ -22,11 +22,11 @@ config L2X0_CACHE
 	  ARMv7(32-bit) devices. The driver configures the cache settings
 	  found in the device tree.
 
-config V5L2_CACHE
-	bool "Andes V5L2 cache driver"
+config ANDES_L2_CACHE
+	bool "Andes L2 cache driver"
 	select CACHE
 	help
-	  Support Andes V5L2 cache controller in AE350 platform.
+	  Support Andes L2 cache controller in AE350 platform.
 	  It will configure tag and data ram timing control from the
 	  device tree and enable L2 cache.
 
diff --git a/drivers/cache/Makefile b/drivers/cache/Makefile
index 78e673d09e..e1b71e0ed5 100644
--- a/drivers/cache/Makefile
+++ b/drivers/cache/Makefile
@@ -3,6 +3,6 @@ obj-$(CONFIG_$(SPL_TPL_)CACHE) += cache-uclass.o
 obj-$(CONFIG_SANDBOX) += sandbox_cache.o
 obj-$(CONFIG_L2X0_CACHE) += cache-l2x0.o
 obj-$(CONFIG_NCORE_CACHE) += cache-ncore.o
-obj-$(CONFIG_V5L2_CACHE) += cache-v5l2.o
+obj-$(CONFIG_ANDES_L2_CACHE) += cache-andes-l2.o
 obj-$(CONFIG_SIFIVE_CCACHE) += cache-sifive-ccache.o
 obj-$(CONFIG_SIFIVE_PL2) += cache-sifive-pl2.o
diff --git a/drivers/cache/cache-v5l2.c b/drivers/cache/cache-andes-l2.c
similarity index 84%
rename from drivers/cache/cache-v5l2.c
rename to drivers/cache/cache-andes-l2.c
index fe3f9392b2..45d29f2fbd 100644
--- a/drivers/cache/cache-v5l2.c
+++ b/drivers/cache/cache-andes-l2.c
@@ -73,7 +73,7 @@ static u32 status_bit_offset = 0x4;
 
 DECLARE_GLOBAL_DATA_PTR;
 
-struct v5l2_plat {
+struct andes_l2_plat {
 	struct l2cache	*regs;
 	u32		iprefetch;
 	u32		dprefetch;
@@ -81,9 +81,9 @@ struct v5l2_plat {
 	u32		dram_ctl[2];
 };
 
-static int v5l2_enable(struct udevice *dev)
+static int andes_l2_enable(struct udevice *dev)
 {
-	struct v5l2_plat *plat = dev_get_plat(dev);
+	struct andes_l2_plat *plat = dev_get_plat(dev);
 	volatile struct l2cache *regs = plat->regs;
 
 	if (regs)
@@ -92,9 +92,9 @@ static int v5l2_enable(struct udevice *dev)
 	return 0;
 }
 
-static int v5l2_disable(struct udevice *dev)
+static int andes_l2_disable(struct udevice *dev)
 {
-	struct v5l2_plat *plat = dev_get_plat(dev);
+	struct andes_l2_plat *plat = dev_get_plat(dev);
 	volatile struct l2cache *regs = plat->regs;
 	u8 hart = gd->arch.boot_hart;
 	void __iomem *cctlcmd = (void __iomem *)CCTL_CMD_REG(regs, hart);
@@ -114,9 +114,9 @@ static int v5l2_disable(struct udevice *dev)
 	return 0;
 }
 
-static int v5l2_of_to_plat(struct udevice *dev)
+static int andes_l2_of_to_plat(struct udevice *dev)
 {
-	struct v5l2_plat *plat = dev_get_plat(dev);
+	struct andes_l2_plat *plat = dev_get_plat(dev);
 	struct l2cache *regs;
 
 	regs = dev_read_addr_ptr(dev);
@@ -138,9 +138,9 @@ static int v5l2_of_to_plat(struct udevice *dev)
 	return 0;
 }
 
-static int v5l2_probe(struct udevice *dev)
+static int andes_l2_probe(struct udevice *dev)
 {
-	struct v5l2_plat *plat = dev_get_plat(dev);
+	struct andes_l2_plat *plat = dev_get_plat(dev);
 	struct l2cache *regs = plat->regs;
 	u32 cfg_val, ctl_val;
 
@@ -183,23 +183,23 @@ static int v5l2_probe(struct udevice *dev)
 	return 0;
 }
 
-static const struct udevice_id v5l2_cache_ids[] = {
+static const struct udevice_id andes_l2_cache_ids[] = {
 	{ .compatible = "cache" },
 	{}
 };
 
-static const struct cache_ops v5l2_cache_ops = {
-	.enable		= v5l2_enable,
-	.disable	= v5l2_disable,
+static const struct cache_ops andes_l2_cache_ops = {
+	.enable		= andes_l2_enable,
+	.disable	= andes_l2_disable,
 };
 
-U_BOOT_DRIVER(v5l2_cache) = {
-	.name   = "v5l2_cache",
+U_BOOT_DRIVER(andes_l2_cache) = {
+	.name   = "andes_l2_cache",
 	.id     = UCLASS_CACHE,
-	.of_match = v5l2_cache_ids,
-	.of_to_plat = v5l2_of_to_plat,
-	.probe	= v5l2_probe,
-	.plat_auto	= sizeof(struct v5l2_plat),
-	.ops = &v5l2_cache_ops,
+	.of_match = andes_l2_cache_ids,
+	.of_to_plat = andes_l2_of_to_plat,
+	.probe	= andes_l2_probe,
+	.plat_auto	= sizeof(struct andes_l2_plat),
+	.ops = &andes_l2_cache_ops,
 	.flags  = DM_FLAG_PRE_RELOC,
 };
-- 
2.34.1

