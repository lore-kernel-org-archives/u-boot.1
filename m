Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC76CCD185
	for <u-boot@archiver.kernel.org>; Fri, 10 Oct 2025 13:45:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B61FE8455B;
	Fri, 10 Oct 2025 15:44:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="URFL0lgO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 839138445C; Fri, 10 Oct 2025 15:44:53 +0200 (CEST)
Received: from lelvem-ot01.ext.ti.com (lelvem-ot01.ext.ti.com [198.47.23.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 195A984479
 for <u-boot@lists.denx.de>; Fri, 10 Oct 2025 15:44:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=anshuld@ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
 by lelvem-ot01.ext.ti.com (8.15.2/8.15.2) with ESMTP id 59ADil2O326627;
 Fri, 10 Oct 2025 08:44:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1760103887;
 bh=NVuFrNinPSS2oMV7YUvcLguoRYHxdMVyKeDtS/xAeM4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=URFL0lgOKhtXV8ZUc7l1ncXWTTgh5Zi7CuKNgWlo9j5oH/oe4i2zuoGCcZz8y2NTV
 ppwbUmS1XE1Ay4+Kitc06YmuK8FVHbZ77LW/HrE4pf8qPs86VfaPmKTOVMvk0ybZHl
 vQ6D8oj/yR6vFuKwFBktDhjw9RkyobRfbCP4Z7Sw=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
 by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 59ADilGb1713817
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Fri, 10 Oct 2025 08:44:47 -0500
Received: from DLEE202.ent.ti.com (157.170.170.77) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Fri, 10
 Oct 2025 08:44:46 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE202.ent.ti.com
 (157.170.170.77) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 10 Oct 2025 08:44:46 -0500
Received: from localhost (dhcp-172-24-233-105.dhcp.ti.com [172.24.233.105])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 59ADijcV1722158;
 Fri, 10 Oct 2025 08:44:46 -0500
From: Anshul Dalal <anshuld@ti.com>
To: <u-boot@lists.denx.de>
CC: Anshul Dalal <anshuld@ti.com>, <d-gole@ti.com>, <b-padhi@ti.com>,
 <vigneshr@ti.com>, <trini@konsulko.com>, <nm@ti.com>,
 <robertcnelson@gmail.com>, <w.egorov@phytec.de>,
 <francesco.dolcini@toradex.com>, <ggiordano@phytec.com>,
 <m-chawdhry@ti.com>, <afd@ti.com>, <bb@ti.com>, <u-kumar1@ti.com>,
 <devarsht@ti.com>, <ilias.apalodimas@linaro.org>, <xypron.glpk@gmx.de>
Subject: [PATCH v10 08/11] spl: split spl_board_fixups to arch/board specific
Date: Fri, 10 Oct 2025 19:14:14 +0530
Message-ID: <20251010134424.3835757-9-anshuld@ti.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251010134424.3835757-1-anshuld@ti.com>
References: <20251010134424.3835757-1-anshuld@ti.com>
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

The current spl_board_fixups API allows for modification of spl_image
before the SPL jumps to it. This can be used to modify the DT for the
next boot stage, however the current API only allows either the machine
arch or the board to use it.

This limits the utility of the API as there might be certain fixups that
should be applied to all boards sharing the same machine architecture
with others being board specific.

For TI's K3 specifically, this prevents us from performing architecture
level fixups since a lot of TI boards are already making use of the
spl_board_fixups API.

Therefore this patch splits the API into two to allow both board and the
architecture specific fixups. The order is kept as arch then board to
give board specific fixups the precedence.

Reviewed-by: Dhruva Gole <d-gole@ti.com>
Signed-off-by: Anshul Dalal <anshuld@ti.com>
Tested-by: Wadim Egorov <w.egorov@phytec.de>
---
 arch/arm/cpu/armv7m/cpu.c                  |  2 +-
 arch/arm/mach-rockchip/spl-boot-order.c    |  2 +-
 arch/arm/mach-socfpga/spl_soc64.c          |  2 +-
 board/beagle/beagley-ai/beagley-ai.c       |  2 +-
 board/dhelectronics/dh_stm32mp1/board.c    |  2 +-
 board/phytec/phycore_am62x/phycore-am62x.c |  2 +-
 board/phytec/phycore_am64x/phycore-am64x.c |  2 +-
 board/renesas/sparrowhawk/sparrowhawk.c    |  2 +-
 board/starfive/visionfive2/spl.c           |  2 +-
 board/ti/am62ax/evm.c                      |  2 +-
 board/ti/am62px/evm.c                      |  2 +-
 board/ti/am62x/evm.c                       |  2 +-
 board/ti/am64x/evm.c                       |  2 +-
 board/ti/j721e/evm.c                       |  2 +-
 board/ti/j721s2/evm.c                      |  2 +-
 board/ti/j722s/evm.c                       |  2 +-
 board/ti/j784s4/evm.c                      |  2 +-
 common/spl/spl.c                           | 12 +++++++++---
 include/spl.h                              | 12 +++++++++---
 19 files changed, 35 insertions(+), 23 deletions(-)

diff --git a/arch/arm/cpu/armv7m/cpu.c b/arch/arm/cpu/armv7m/cpu.c
index b4440d3f3f8..bea0e1d3263 100644
--- a/arch/arm/cpu/armv7m/cpu.c
+++ b/arch/arm/cpu/armv7m/cpu.c
@@ -57,7 +57,7 @@ void reset_cpu(void)
 		| V7M_AIRCR_SYSRESET, &V7M_SCB->aircr);
 }
 
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 {
 	spl_image->entry_point |= 0x1;
 }
diff --git a/arch/arm/mach-rockchip/spl-boot-order.c b/arch/arm/mach-rockchip/spl-boot-order.c
index 1bfd120adc4..561bddd12a6 100644
--- a/arch/arm/mach-rockchip/spl-boot-order.c
+++ b/arch/arm/mach-rockchip/spl-boot-order.c
@@ -240,7 +240,7 @@ int spl_decode_boot_device(u32 boot_device, char *buf, size_t buflen)
 #endif
 }
 
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 {
 	const char *bootrom_ofpath = board_spl_was_booted_from();
 	void *blob = spl_image_fdt_addr(spl_image);
diff --git a/arch/arm/mach-socfpga/spl_soc64.c b/arch/arm/mach-socfpga/spl_soc64.c
index 651d9fc9cb8..fa7b1506ce6 100644
--- a/arch/arm/mach-socfpga/spl_soc64.c
+++ b/arch/arm/mach-socfpga/spl_soc64.c
@@ -130,7 +130,7 @@ u32 spl_boot_mode(const u32 boot_device)
 #endif
 
 /* board specific function prior loading SSBL / U-Boot */
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_arch_fixups(struct spl_image_info *spl_image)
 {
 	int ret;
 	struct udevice *dev;
diff --git a/board/beagle/beagley-ai/beagley-ai.c b/board/beagle/beagley-ai/beagley-ai.c
index 26fa54e27bb..500cc3060c3 100644
--- a/board/beagle/beagley-ai/beagley-ai.c
+++ b/board/beagle/beagley-ai/beagley-ai.c
@@ -32,7 +32,7 @@ int dram_init_banksize(void)
 }
 
 #if defined(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/board/dhelectronics/dh_stm32mp1/board.c b/board/dhelectronics/dh_stm32mp1/board.c
index bd9326d6b1b..d98b2c6e809 100644
--- a/board/dhelectronics/dh_stm32mp1/board.c
+++ b/board/dhelectronics/dh_stm32mp1/board.c
@@ -776,7 +776,7 @@ int ft_board_setup(void *blob, struct bd_info *bd)
 #endif
 
 #if defined(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	dh_stm32_ks8851_fixup(spl_image_fdt_addr(spl_image));
 }
diff --git a/board/phytec/phycore_am62x/phycore-am62x.c b/board/phytec/phycore_am62x/phycore-am62x.c
index 51da864aa80..3cdcbf2ecc9 100644
--- a/board/phytec/phycore_am62x/phycore-am62x.c
+++ b/board/phytec/phycore_am62x/phycore-am62x.c
@@ -199,7 +199,7 @@ int do_board_detect(void)
 #endif
 
 #if IS_ENABLED(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS) && IS_ENABLED(CONFIG_K3_INLINE_ECC))
 		fixup_ddr_driver_for_ecc(spl_image);
diff --git a/board/phytec/phycore_am64x/phycore-am64x.c b/board/phytec/phycore_am64x/phycore-am64x.c
index 33c39376ceb..114aa217023 100644
--- a/board/phytec/phycore_am64x/phycore-am64x.c
+++ b/board/phytec/phycore_am64x/phycore-am64x.c
@@ -118,7 +118,7 @@ int do_board_detect(void)
 #endif
 
 #if IS_ENABLED(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS) && IS_ENABLED(CONFIG_K3_INLINE_ECC))
 		fixup_ddr_driver_for_ecc(spl_image);
diff --git a/board/renesas/sparrowhawk/sparrowhawk.c b/board/renesas/sparrowhawk/sparrowhawk.c
index 58de7f25cbd..29a67dae34e 100644
--- a/board/renesas/sparrowhawk/sparrowhawk.c
+++ b/board/renesas/sparrowhawk/sparrowhawk.c
@@ -134,7 +134,7 @@ unsigned int spl_spi_get_uboot_offs(struct spi_flash *flash)
 	return CONFIG_SYS_SPI_U_BOOT_OFFS;
 }
 
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	void *blob = spl_image_fdt_addr(spl_image);
 	int err, offs;
diff --git a/board/starfive/visionfive2/spl.c b/board/starfive/visionfive2/spl.c
index 420a8cf8d91..48b034af305 100644
--- a/board/starfive/visionfive2/spl.c
+++ b/board/starfive/visionfive2/spl.c
@@ -20,7 +20,7 @@ DECLARE_GLOBAL_DATA_PTR;
 #define JH7110_CLK_CPU_ROOT_SHIFT		24
 #define JH7110_CLK_CPU_ROOT_MASK		GENMASK(29, 24)
 
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	/* Update the memory size which read from eeprom or DT */
 	if (spl_image->fdt_addr)
diff --git a/board/ti/am62ax/evm.c b/board/ti/am62ax/evm.c
index a445f983255..da6c31176cd 100644
--- a/board/ti/am62ax/evm.c
+++ b/board/ti/am62ax/evm.c
@@ -17,7 +17,7 @@
 #include "../common/fdt_ops.h"
 
 #if defined(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/board/ti/am62px/evm.c b/board/ti/am62px/evm.c
index c06e3878d67..85c332b9339 100644
--- a/board/ti/am62px/evm.c
+++ b/board/ti/am62px/evm.c
@@ -50,7 +50,7 @@ void spl_board_init(void)
 #endif
 
 #if defined(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/board/ti/am62x/evm.c b/board/ti/am62x/evm.c
index d7b07a0d34d..c2c7a0216b9 100644
--- a/board/ti/am62x/evm.c
+++ b/board/ti/am62x/evm.c
@@ -91,7 +91,7 @@ void spl_board_init(void)
 
 }
 
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/board/ti/am64x/evm.c b/board/ti/am64x/evm.c
index 8e89b3b15df..f9bb593e4c6 100644
--- a/board/ti/am64x/evm.c
+++ b/board/ti/am64x/evm.c
@@ -98,7 +98,7 @@ static int fixup_usb_boot(const void *fdt_blob)
 }
 #endif
 
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 1527eaf1e16..e030fe7dc87 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -127,7 +127,7 @@ static void __maybe_unused detect_enable_hyperflash(void *blob)
 
 #if defined(CONFIG_XPL_BUILD) && (defined(CONFIG_TARGET_J7200_A72_EVM) || defined(CONFIG_TARGET_J7200_R5_EVM) || \
 					defined(CONFIG_TARGET_J721E_A72_EVM) || defined(CONFIG_TARGET_J721E_R5_EVM))
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	detect_enable_hyperflash(spl_image->fdt_addr);
 }
diff --git a/board/ti/j721s2/evm.c b/board/ti/j721s2/evm.c
index 5d3b84607d8..b6d1964146d 100644
--- a/board/ti/j721s2/evm.c
+++ b/board/ti/j721s2/evm.c
@@ -40,7 +40,7 @@ phys_addr_t board_get_usable_ram_top(phys_size_t total_size)
 }
 
 #if defined(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/board/ti/j722s/evm.c b/board/ti/j722s/evm.c
index 32d767cb7d2..1173adc072b 100644
--- a/board/ti/j722s/evm.c
+++ b/board/ti/j722s/evm.c
@@ -24,7 +24,7 @@ void spl_board_init(void)
 #endif
 
 #if defined(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 6335676081a..cabb3017ee1 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -42,7 +42,7 @@ struct efi_capsule_update_info update_info = {
 };
 
 #if defined(CONFIG_XPL_BUILD)
-void spl_perform_fixups(struct spl_image_info *spl_image)
+void spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 	if (IS_ENABLED(CONFIG_K3_DDRSS)) {
 		if (IS_ENABLED(CONFIG_K3_INLINE_ECC))
diff --git a/common/spl/spl.c b/common/spl/spl.c
index 55ad497c86d..2b321284b59 100644
--- a/common/spl/spl.c
+++ b/common/spl/spl.c
@@ -120,8 +120,13 @@ int __weak booti_setup(ulong image, ulong *relocated_addr, ulong *size, bool for
 }
 #endif
 
-/* Weak default function for arch/board-specific fixups to the spl_image_info */
-void __weak spl_perform_fixups(struct spl_image_info *spl_image)
+/* Weak default function for arch specific fixups to the spl_image_info */
+void __weak spl_perform_arch_fixups(struct spl_image_info *spl_image)
+{
+}
+
+/* Weak default function for board specific fixups to the spl_image_info */
+void __weak spl_perform_board_fixups(struct spl_image_info *spl_image)
 {
 }
 
@@ -775,7 +780,8 @@ void board_init_r(gd_t *dummy1, ulong dummy2)
 		hang();
 	}
 
-	spl_perform_fixups(&spl_image);
+	spl_perform_arch_fixups(&spl_image);
+	spl_perform_board_fixups(&spl_image);
 
 	os = spl_image.os;
 	if (os == IH_OS_U_BOOT) {
diff --git a/include/spl.h b/include/spl.h
index 7c10c7f792e..cf45d411ecb 100644
--- a/include/spl.h
+++ b/include/spl.h
@@ -1116,10 +1116,16 @@ int board_return_to_bootrom(struct spl_image_info *spl_image,
 ulong board_spl_fit_size_align(ulong size);
 
 /**
- * spl_perform_fixups() - arch/board-specific callback before processing
- *                        the boot-payload
+ * spl_perform_arch_fixups() - arch specific callback before processing the
+ *                        boot-payload
  */
-void spl_perform_fixups(struct spl_image_info *spl_image);
+void spl_perform_arch_fixups(struct spl_image_info *spl_image);
+
+/**
+ * spl_perform_board_fixups() - board specific callback before processing the
+ *                        boot-payload
+ */
+void spl_perform_board_fixups(struct spl_image_info *spl_image);
 
 /*
  * spl_get_load_buffer() - get buffer for loading partial image data
-- 
2.51.0

