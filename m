Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63020E95360
	for <u-boot@archiver.kernel.org>; Wed,  4 Feb 2026 09:35:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 273EB83B30;
	Wed,  4 Feb 2026 10:34:45 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E2F483A24; Wed,  4 Feb 2026 08:47:24 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 83D7283A36
 for <u-boot@lists.denx.de>; Wed,  4 Feb 2026 08:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=qijian.guo@nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 47E701A049A;
 Wed,  4 Feb 2026 08:47:21 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA1CF1A049E;
 Wed,  4 Feb 2026 08:47:20 +0100 (CET)
Received: from lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com
 (lsvm11u0000395.swis.ap-northeast-2.aws.nxp.com [10.52.9.99])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id A08EC180009C;
 Wed,  4 Feb 2026 15:47:18 +0800 (+08)
From: Joseph Guo <qijian.guo@nxp.com>
Date: Wed, 04 Feb 2026 16:47:13 +0900
Subject: [PATCH 2/2] imx: Add FRDM-IMX95 initial support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-imx95_frdm-v1-2-85dc80e98a6d@nxp.com>
References: <20260204-imx95_frdm-v1-0-85dc80e98a6d@nxp.com>
In-Reply-To: <20260204-imx95_frdm-v1-0-85dc80e98a6d@nxp.com>
To: u-boot@lists.denx.de, "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Lei Xu <lei.xu@nxp.com>, Stefano Babic <sbabic@nabladev.com>, 
 Fabio Estevam <festevam@gmail.com>, Ye Li <ye.li@nxp.com>, 
 Alice Guo <alice.guo@nxp.com>, Peng Fan <peng.fan@nxp.com>, 
 Adam Ford <aford173@gmail.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Sam Protsenko <semen.protsenko@linaro.org>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Ji Luo <ji.luo@nxp.com>, 
 Simon Glass <sjg@chromium.org>, Justin Jiang <justin.jiang@nxp.com>, 
 qijian.guo@oss.nxp.com, xinyu.chen@nxp.com, Joseph Guo <qijian.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770191234; l=19641;
 i=qijian.guo@nxp.com; s=20250519; h=from:subject:message-id;
 bh=JVIzfaYWaIhxOY4Bjb0iR+ciIyim9sLchcvvJ6AuIAk=;
 b=l3FOB3nJGf9eRZwFvNybl4cpjuAB7tsbjAf9hIqnpHxGgPDBw3azdrFu64enqbcP5uNyrXO5A
 XjNBS0kSZyrCLJJhi/F10v+h1b31nKeJgzB/ESCbtwgrb3bUfFXV4oA
X-Developer-Key: i=qijian.guo@nxp.com; a=ed25519;
 pk=VRjOOFhVecTRwBzK4mt/k3JBnHoYfuXKCm9FM+hHQhs=
X-Mailman-Approved-At: Wed, 04 Feb 2026 10:34:42 +0100
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

Add boot support and peripherals like eMMC/SD, UART, I2C, GPIO, ENETC0/1
and PCIE0/1 for iMX95 15x15 FRDM.
Updated doc for build instructions.

Signed-off-by: Lei Xu <lei.xu@nxp.com>
Signed-off-by: Joseph Guo <qijian.guo@nxp.com>
---
 arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi |  85 ++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig            |   8 ++
 board/nxp/imx95_frdm/Kconfig              |  12 +++
 board/nxp/imx95_frdm/MAINTAINERS          |   6 ++
 board/nxp/imx95_frdm/Makefile             |  11 +++
 board/nxp/imx95_frdm/imx95_frdm.c         |  31 +++++++
 board/nxp/imx95_frdm/imx95_frdm.env       |  91 +++++++++++++++++++
 board/nxp/imx95_frdm/spl.c                |  79 +++++++++++++++++
 configs/imx95_15x15_frdm_defconfig        | 143 ++++++++++++++++++++++++++++++
 doc/board/nxp/imx95_frdm.rst              | 131 +++++++++++++++++++++++++++
 doc/board/nxp/index.rst                   |   1 +
 include/configs/imx95_frdm.h              |  25 ++++++
 12 files changed, 623 insertions(+)

diff --git a/arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi b/arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..651352e0883a6a5213b4173e321448edef97fca9
--- /dev/null
+++ b/arch/arm/dts/imx95-15x15-frdm-u-boot.dtsi
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include "imx95-u-boot.dtsi"
+
+/ {
+	aliases {
+		pci0 = &netc_bus0;
+		pci1 = &netc_bus1;
+	};
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-imem} {
+	filename = "lpddr4x_imem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr/imx-lpddr-dmem} {
+	filename = "lpddr4x_dmem_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-imem-qb} {
+	filename = "lpddr4x_imem_qb_v202409.bin";
+};
+
+&{/binman/m33-oei-ddrfw/imx-lpddr-qb/imx-lpddr-dmem-qb} {
+	filename = "lpddr4x_dmem_qb_v202409.bin";
+};
+
+&lpuart1 {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index d9f97e4328c956554c777eebdf64e7024128dd42..bf8608fd838a41c9e235aa44e8c08a4cf7f2c45d 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -142,6 +142,13 @@ config TARGET_IMX95_15X15_EVK
 	imply BOOTSTD_FULL
 	imply OF_UPSTREAM
 
+config TARGET_IMX95_15X15_FRDM
+	bool "imx95_frdm"
+	select IMX95
+	imply BOOTSTD_FULL
+	imply BOOTSTD_BOOTCOMMAND
+	imply OF_UPSTREAM
+
 config TARGET_IMX943_EVK
 	bool "imx943_evk"
 	select IMX94
@@ -165,6 +172,7 @@ source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
 source "board/nxp/imx94_evk/Kconfig"
 source "board/nxp/imx95_evk/Kconfig"
+source "board/nxp/imx95_frdm/Kconfig"
 source "board/toradex/smarc-imx95/Kconfig"
 
 endif
diff --git a/board/nxp/imx95_frdm/Kconfig b/board/nxp/imx95_frdm/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..0da9a56adadec661792c38b1258e4eb914af5aa5
--- /dev/null
+++ b/board/nxp/imx95_frdm/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_15X15_FRDM
+
+config SYS_BOARD
+	default "imx95_frdm"
+
+config SYS_VENDOR
+	default "nxp"
+
+config SYS_CONFIG_NAME
+	default "imx95_frdm"
+
+endif
diff --git a/board/nxp/imx95_frdm/MAINTAINERS b/board/nxp/imx95_frdm/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..33870f054e7452ed3af36f19236163d451c93665
--- /dev/null
+++ b/board/nxp/imx95_frdm/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX95 FRDM BOARD
+M:	Joseph Guo <qijian.guo@nxp.com>
+S:	Maintained
+F:	board/nxp/imx95_frdm/
+F:	include/configs/imx95_frdm.h
+F:	configs/imx95_15x15_frdm_defconfig
diff --git a/board/nxp/imx95_frdm/Makefile b/board/nxp/imx95_frdm/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..6965c61a281d44950d2619d3bfebceab39351c4d
--- /dev/null
+++ b/board/nxp/imx95_frdm/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2026 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_frdm.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/nxp/imx95_frdm/imx95_frdm.c b/board/nxp/imx95_frdm/imx95_frdm.c
new file mode 100644
index 0000000000000000000000000000000000000000..fe0111be5081dc1c0e60c9a195fbbf0d3f39321b
--- /dev/null
+++ b/board/nxp/imx95_frdm/imx95_frdm.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2025 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+int board_late_init(void)
+{
+	if (IS_ENABLED(CONFIG_ENV_IS_IN_MMC))
+		board_late_mmc_env_init();
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/nxp/imx95_frdm/imx95_frdm.env b/board/nxp/imx95_frdm/imx95_frdm.env
new file mode 100644
index 0000000000000000000000000000000000000000..a7309d734b0d3b98b2dd405a975610c24f7f6a32
--- /dev/null
+++ b/board/nxp/imx95_frdm/imx95_frdm.env
@@ -0,0 +1,91 @@
+sec_boot=no
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+scriptaddr=0x93500000
+kernel_addr_r=CONFIG_SYS_LOAD_ADDR
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=CONFIG_DEFAULT_FDT_FILE
+bootm_size=0x10000000
+mmcdev=CONFIG_ENV_MMC_DEVICE_INDEX
+mmcautodetect=yes
+mmcargs=setenv bootargs console=${console} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs console=${console} root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
diff --git a/board/nxp/imx95_frdm/spl.c b/board/nxp/imx95_frdm/spl.c
new file mode 100644
index 0000000000000000000000000000000000000000..97e5549c337e66de22a5fc5627185dbe7f9286fd
--- /dev/null
+++ b/board/nxp/imx95_frdm/spl.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2026 NXP
+ */
+
+#include <asm/arch/clock.h>
+#include <asm/arch/mu.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <hang.h>
+#include <init.h>
+#include <spl.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	int ret;
+
+	puts("Normal Boot\n");
+
+	ret = ele_start_rng();
+	if (ret)
+		printf("Fail to start RNG: %d\n", ret);
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	get_reset_reason(true, false);
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_15x15_frdm_defconfig b/configs/imx95_15x15_frdm_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..c3d9819bde454f35216eee189afd86ad3ea7e5b1
--- /dev/null
+++ b/configs/imx95_15x15_frdm_defconfig
@@ -0,0 +1,143 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_GPIO=y
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_ENV_SOURCE_FILE="imx95_frdm"
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-15x15-frdm"
+CONFIG_TARGET_IMX95_15X15_FRDM=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_SPL_MMC=y
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SPL=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_PCI=y
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_FIT=y
+CONFIG_FIT_VERBOSE=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_BOOTCOMMAND="bootflow scan -l; run bsp_bootcmd"
+CONFIG_DEFAULT_FDT_FILE="imx95-15x15-frdm.dtb"
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_BOARD_EARLY_INIT_F=y
+# CONFIG_BOARD_INIT is not set
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_PCI_INIT_R=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_I2C=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_POWER=y
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PCI=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_ENV_RELOC_GD_ENV_ADDR=y
+CONFIG_ENV_MMC_DEVICE_INDEX=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_SPL_DM=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_SPL_CLK=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_CLK_SCMI=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_CLK_IMX95_BLKCTRL=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_SPL_FIRMWARE=y
+# CONFIG_SCMI_AGENT_SMCCC is not set
+CONFIG_IMX_RGPIO2P=y
+CONFIG_DM_PCA953X=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_IMX_MU_MBOX=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_MTD=y
+CONFIG_PHYLIB=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_MOTORCOMM=y
+CONFIG_DM_MDIO=y
+CONFIG_MII=y
+CONFIG_FSL_ENETC=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCIE_DW_IMX=y
+CONFIG_PHY=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_POWER_DOMAIN=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
diff --git a/doc/board/nxp/imx95_frdm.rst b/doc/board/nxp/imx95_frdm.rst
new file mode 100644
index 0000000000000000000000000000000000000000..85ef9022e76fc0d8f2a5524128309939f22f4715
--- /dev/null
+++ b/doc/board/nxp/imx95_frdm.rst
@@ -0,0 +1,131 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx95_frdm
+=======================
+
+U-Boot for the NXP i.MX95 15x15 FRDM board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-2.0.2-89161a8.bin
+   $ sh firmware-ele-imx-2.0.2-89161a8.bin --auto-accept
+
+i.MX95 A0 silicon version
+
+.. code-block:: bash
+
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx95a0-ahab-container.img $(srctree)
+
+i.MX95 B0 silicon version
+
+.. code-block:: bash
+
+   $ cp firmware-ele-imx-2.0.2-89161a8/mx95b0-ahab-container.img $(srctree)
+
+Get DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.28-994fa14.bin
+   $ sh firmware-imx-8.28-994fa14.bin --auto-accept
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr5*v202409.bin $(srctree)
+   $ cp firmware-imx-8.28-994fa14/firmware/ddr/synopsys/lpddr4x*v202409.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-oei.git
+   $ cd imx-oei
+
+i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
+
+.. code-block:: bash
+
+   $ make board=mx95lp4x-15 oei=ddr DEBUG=1 r=B0 all
+   $ cp build/mx95lp4x-15/ddr/oei-m33-ddr.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ git clone -b master https://github.com/nxp-imx/imx-sm.git
+   $ cd imx-sm
+   $ make config=mx95evk all
+   $ cp build/mx95evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.12
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ unset LDFLAGS
+   $ unset AS
+   $ git clone -b lf_v2.12 https://github.com/nxp-imx/imx-atf.git
+   $ cd imx-atf
+   $ make PLAT=imx95 bl31
+   $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+--------------------------
+
+i.MX95 B0 silicon version on 15x15 LPDDR4X FRDM Board
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_15x15_frdm_defconfig
+   $ make
+
+Copy imx-boot-imx95.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=flash.bin of=/dev/sd[x] bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX95 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 01d3468a47da8ddd25cf45b52920a35e4e131c48..c7d5bf36f1145186d8bfc77939fdd7d77e5d0953 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -17,6 +17,7 @@ NXP Semiconductors
    imx93_9x9_qsb
    imx93_11x11_evk
    imx93_frdm
+   imx95_frdm
    imx943_evk
    imx95_evk
    imxrt1020-evk
diff --git a/include/configs/imx95_frdm.h b/include/configs/imx95_frdm.h
new file mode 100644
index 0000000000000000000000000000000000000000..815b6c4fa66982688825ff20de07c7fe525dc99a
--- /dev/null
+++ b/include/configs/imx95_frdm.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2026 NXP
+ */
+
+#ifndef __IMX95_EVK_H
+#define __IMX95_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_INIT_RAM_ADDR	0x90000000
+#define CFG_SYS_INIT_RAM_SIZE	0x200000
+
+#define CFG_SYS_SDRAM_BASE		0x90000000
+#define PHYS_SDRAM				0x90000000
+
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB - 256MB DDR */
+
+#define PHYS_SDRAM_2_SIZE		0x180000000 /* 6GB (Totally 8GB) */
+
+#define WDOG_BASE_ADDR			WDG3_BASE_ADDR
+
+#endif

-- 
2.34.1

