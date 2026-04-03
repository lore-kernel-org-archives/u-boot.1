Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 476EFE88D86
	for <u-boot@archiver.kernel.org>; Sat,  4 Apr 2026 06:32:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCDF284197;
	Sat,  4 Apr 2026 08:31:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=seznam.cz header.i=@seznam.cz header.b="jK9BnWTh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7FB7807C0; Sat,  4 Apr 2026 01:19:38 +0200 (CEST)
Received: from mxd-2-a16.seznam.cz (mxd-2-a16.seznam.cz
 [IPv6:2a02:598:64:8a00::1000:a16])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D46EF840AA
 for <u-boot@lists.denx.de>; Sat,  4 Apr 2026 01:19:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=michael.srba@seznam.cz
Received: from email.seznam.cz by smtpc-mxd-7644845457-sbn6w
 (smtpc-mxd-7644845457-sbn6w [2a02:598:64:8a00::1000:a16])
 id 004f70d55b4124bc01e6bc8b; Sat, 04 Apr 2026 01:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
 t=1775258329; bh=2soOWfVhmNy0W+FBpW/cEv8iddoZdqIIsCUljmn5tZM=;
 h=From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:To:Cc;
 b=jK9BnWThVG+OCjL0NYU1gpcni1H4zrhsE635XEAmIx+3cDXv2dDqdP1HkXYbEQXpG
 dkKvenK+YIXZaGzb6XaHWQaEpcHgNds+9gcr6WylzRMfqEXmQPtT2JGeMbMZNcQe4X
 MM7Tc5sgp07Hx8WBvYIzvYEvOxz9vj4ncKUpog207Myd0673iipQJJjfjh1MRvpKuF
 3yOC1+TvutY9e22alBJOr4H9KORYiJj/kVv/Xk0kaDazcUWVJ4k7IBO1zGaYlDBpAH
 xVbWYGuuDoHbiC92SE4zKUaF5WwOLOkHalQpKX4cZCUVA9PV+mSifnwCH7p3J3eWoR
 GiGsUv83/zjDQ==
Received: from [127.0.0.1] (ip-111-27.static.ccinternet.cz [147.161.27.111])
 by smtpd-relay-789d8dfb5c-z7n27 (szn-email-smtpd/2.0.71) with ESMTPA
 id 0009c753-e3da-4000-be84-7dcd0d540e49;
 Sat, 04 Apr 2026 01:18:31 +0200
From: michael.srba@seznam.cz
Date: Sat, 04 Apr 2026 01:18:19 +0200
Subject: [PATCH 4/5] mach-snapdragon: support building SPL
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260404-qcom_spl-v1-4-9e6c2ac66587@seznam.cz>
References: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
In-Reply-To: <20260404-qcom_spl-v1-0-9e6c2ac66587@seznam.cz>
To: u-boot@lists.denx.de, Sumit Garg <sumit.garg@kernel.org>, 
 u-boot-qcom@groups.io
Cc: Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Simon Glass <sjg@chromium.org>, Sughosh Ganu <sughosh.ganu@arm.com>, 
 Anshul Dalal <anshuld@ti.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>, Andrew Davis <afd@ti.com>, 
 Hrushikesh Salunke <h-salunke@ti.com>, 
 Dario Binacchi <dario.binacchi@amarulasolutions.com>, Ye Li <ye.li@nxp.com>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>, 
 Leo Yu-Chi Liang <ycliang@andestech.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Dhruva Gole <d-gole@ti.com>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>, 
 Jerome Forissier <jerome.forissier@arm.com>, 
 Heiko Schocher <hs@nabladev.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Lukasz Majewski <lukma@denx.de>, 
 Mateusz Kulikowski <mateusz.kulikowski@gmail.com>, 
 Dinesh Maniyam <dinesh.maniyam@altera.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Michal Simek <michal.simek@amd.com>, Yao Zi <me@ziyao.cc>, 
 Peter Korsgaard <peter@korsgaard.com>, 
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>, 
 Casey Connolly <casey.connolly@linaro.org>, 
 Tingting Meng <tingting.meng@altera.com>, 
 Tien Fong Chee <tien.fong.chee@altera.com>, Alice Guo <alice.guo@nxp.com>, 
 George Chan <gchan9527@gmail.com>, 
 Balaji Selvanathan <balaji.selvanathan@oss.qualcomm.com>, 
 Michael Srba <Michael.Srba@seznam.cz>
X-Mailer: b4 0.15.1
X-Mailman-Approved-At: Sat, 04 Apr 2026 08:31:19 +0200
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

From: Michael Srba <Michael.Srba@seznam.cz>

Initially sdm845 support is added, and only usb boot
is supported for the next stage.

Signed-off-by: Michael Srba <Michael.Srba@seznam.cz>
---
 arch/arm/Kconfig                                   |   6 +-
 arch/arm/dts/sdm845-u-boot.dtsi                    |  16 +++
 arch/arm/mach-snapdragon/Kconfig                   |  98 +++++++++++++++-
 arch/arm/mach-snapdragon/board.c                   |  26 +++++
 arch/arm/mach-snapdragon/include/mach/boot0.h      |  61 ++--------
 .../mach-snapdragon/include/mach/msm8916_boot0.h   |  54 +++++++++
 .../include/mach/sdm845_spl_boot0.h                | 120 +++++++++++++++++++
 arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds |  25 ++++
 board/qualcomm/sdm845_spl.env                      |   1 +
 configs/sdm845_spl_defconfig                       | 130 +++++++++++++++++++++
 doc/board/qualcomm/index.rst                       |   1 +
 doc/board/qualcomm/spl.rst                         |  70 +++++++++++
 12 files changed, 554 insertions(+), 54 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index cd6a454fd60..5b45eabddda 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1135,9 +1135,13 @@ config ARCH_SNAPDRAGON
 	select SAVE_PREV_BL_FDT_ADDR if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select LINUX_KERNEL_IMAGE_HEADER if !ENABLE_ARM_SOC_BOOT0_HOOK
 	select SYSRESET
-	select SYSRESET_PSCI
+	select SYSRESET_PSCI if !SPL
 	select ANDROID_BOOT_IMAGE_IGNORE_BLOB_ADDR
 	select MMU_PGPROT
+	imply DM_EVENT if USB_DWC3_GENERIC || SPL_USB_DWC3_GENERIC
+	imply SPL_EVENT if SPL_USB_DWC3_GENERIC
+	imply OF_LIVE if USB_DWC3_GENERIC
+	imply SPL_OF_LIVE if SPL_USB_DWC3_GENERIC
 	imply OF_UPSTREAM
 	imply CMD_DM
 	imply DM_USB_GADGET
diff --git a/arch/arm/dts/sdm845-u-boot.dtsi b/arch/arm/dts/sdm845-u-boot.dtsi
new file mode 100644
index 00000000000..59abc5dbd66
--- /dev/null
+++ b/arch/arm/dts/sdm845-u-boot.dtsi
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+&gcc {
+	bootph-all;
+};
+
+&usb_1_hsphy {
+	bootph-all;
+};
+
+&usb_1_dwc3 {
+	bootph-all;
+};
+
+&rpmhcc: clock-controller {
+	bootph-all;
+};
diff --git a/arch/arm/mach-snapdragon/Kconfig b/arch/arm/mach-snapdragon/Kconfig
index 976c0e35fce..938e6ebd8bf 100644
--- a/arch/arm/mach-snapdragon/Kconfig
+++ b/arch/arm/mach-snapdragon/Kconfig
@@ -1,6 +1,24 @@
 if ARCH_SNAPDRAGON
 
+# SoC specific SRAM addresses
+
+# sdm845
+SDM845_BOOT_IMEM_BASE := 0x14800000
+SDM845_BOOT_IMEM_SIZE := 0x180000
+# we may not be able to use the whole BOOT_IMEM depending on the whitelisted regions hardcoded in PBL
+# (we could technically relocate ourselves after the fact)
+SDM845_BOOT_IMEM_OFFSET := 0x3f000
+SDM845_BOOT_IMEM_USABLE_SIZE := 0xc1000
+# technically the below would work, except the memory from 0x14833000 to 0x1483F000 gets trashed
+# between the ELF getting loaded and XBL_SEC jumping to our code
+#SDM845_BOOT_IMEM_OFFSET := 0x16000
+#SDM845_BOOT_IMEM_USABLE_SIZE := 0xea000
+SDM845_OCIMEM_BASE := 0x14680000
+SDM845_OCIMEM_SIZE := 0x00040000
+SDM845_OCIMEM_END  := $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_OCIMEM_BASE) + $(SDM845_OCIMEM_SIZE) - 1))")
+
 config SYS_SOC
+	default "sdm845" if SPL_TARGET_SDM845
 	default "snapdragon"
 
 config SYS_VENDOR
@@ -11,8 +29,13 @@ config SYS_VENDOR
 	  Based on this option board/<CONFIG_SYS_VENDOR>/<CONFIG_SYS_BOARD>
 	  will be used as the custom board directory.
 
+# per-SoC dtsi isn't actually per SoC, to work around that we need to only build for one SoC
+config OF_UPSTREAM_BUILD_VENDOR
+	default n if SPL_TARGET_SDM845
+
 config SYS_MALLOC_LEN
 	default 0x10000000
+	default $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_OCIMEM_SIZE) / 2))") if SPL_TARGET_SDM845
 
 config SYS_MALLOC_F_LEN
 	default 0x2000
@@ -21,7 +44,7 @@ config SPL_SYS_MALLOC_F
 	default y
 
 config SPL_SYS_MALLOC_F_LEN
-	default 0x2000
+	default $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_OCIMEM_SIZE) / 2))") if SPL_TARGET_SDM845
 
 config SYS_MALLOC_LEN
 	default 0x800000
@@ -45,4 +68,77 @@ config SYS_CONFIG_NAME
 	  Based on this option include/configs/<CONFIG_SYS_CONFIG_NAME>.h header
 	  will be used for board configuration.
 
+config QCOM_SPL
+	bool "Enable SPL for Snapdragon SOCs"
+	select SUPPORT_SPL
+	select ARMV8_SPL_EXCEPTION_VECTORS
+	select ENABLE_ARM_SOC_BOOT0_HOOK
+	select SPL
+	select SPL_DM
+	select SPL_DM_GPIO
+	select SPL_DM_PMIC
+	select SPL_DM_USB_GADGET
+	select SPL_ENV_SUPPORT
+	select SPL_GPIO
+	select SPL_HAS_BSS_LINKER_SECTION
+	select SPL_LIBCOMMON_SUPPORT
+	select SPL_LIBDISK_SUPPORT
+	select SPL_LIBGENERIC_SUPPORT
+	select SPL_MMC
+	select SPL_OF_REAL
+	select SPL_OF_CONTROL
+	select SPL_PINCONF
+	select SPL_PINCTRL
+	select SPL_PINCTRL_FULL
+	select SPL_PINCTRL_GENERIC
+	select SPL_PINCONF_RECURSIVE
+	select SPL_PINMUX
+	select SPL_SPRINTF
+	select SPL_STRTO
+	select SPL_USB_GADGET
+
+config SPL_SHARES_INIT_SP_ADDR
+	default n
+
+config SPL_HAVE_INIT_STACK
+	default y
+
+# SPL targets
+
+config SPL_TARGET_SDM845
+	bool "Set reasonable default values for running SPL in SRAM on sdm845 devices"
+
+# config options selected based on target
+
+config SPL_REMAKE_ELF_LDSCRIPT
+	default "arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds" if SPL_TARGET_SDM845
+
+config SPL_BSS_START_ADDR
+	default $(SDM845_OCIMEM_BASE) if SPL_TARGET_SDM845
+
+# arbitrarily half of SDM845_OCIMEM_SIZE
+config SPL_BSS_MAX_SIZE
+	default $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_OCIMEM_SIZE) / 2))") if SPL_TARGET_SDM845
+
+config SYS_MALLOC_LEN
+	default 0x20000 if SPL_TARGET_SDM845
+
+config SPL_STACK
+	default $(SDM845_OCIMEM_END) if SPL_TARGET_SDM845
+
+config SPL_TEXT_BASE
+	default $(shell, printf "0x%x\n" "$(dollar)(($(SDM845_BOOT_IMEM_BASE) + $(SDM845_BOOT_IMEM_OFFSET)))")  if SPL_TARGET_SDM845
+
+# these are used when running u-boot proper without DRAM initialized
+config MSM_OCIMEM_BASE
+	hex
+	default $(SDM845_OCIMEM_BASE) if SPL_TARGET_SDM845
+
+config MSM_OCIMEM_SIZE
+	hex
+	default $(SDM845_OCIMEM_SIZE) if SPL_TARGET_SDM845
+
+config SPL_MAX_SIZE
+	default $(SDM845_BOOT_IMEM_USABLE_SIZE) if SPL_TARGET_SDM845
+
 endif
diff --git a/arch/arm/mach-snapdragon/board.c b/arch/arm/mach-snapdragon/board.c
index 5fb3240acc5..0f980a954e4 100644
--- a/arch/arm/mach-snapdragon/board.c
+++ b/arch/arm/mach-snapdragon/board.c
@@ -33,6 +33,8 @@
 #include <sort.h>
 #include <time.h>
 
+#include <spl.h>
+
 #include "qcom-priv.h"
 
 DECLARE_GLOBAL_DATA_PTR;
@@ -223,6 +225,7 @@ int board_fdt_blob_setup(void **fdtp)
 		panic("Internal FDT is invalid and no external FDT was provided! (fdt=%#llx)\n",
 		      (phys_addr_t)external_fdt);
 
+#if !defined(CONFIG_SPL_BUILD)
 	/* Prefer memory information from internal DT if it's present */
 	if (internal_valid)
 		ret = qcom_parse_memory(internal_fdt);
@@ -239,6 +242,7 @@ int board_fdt_blob_setup(void **fdtp)
 
 	if (ret < 0)
 		panic("No valid memory ranges found!\n");
+#endif
 
 	/* If we have an external FDT, it can only have come from the Android bootloader. */
 	if (external_valid)
@@ -258,7 +262,9 @@ int board_fdt_blob_setup(void **fdtp)
 		ret = 0;
 	}
 
+#if CONFIG_IS_ENABLED(SYSRESET_PSCI) && !defined(CONFIG_SPL_BUILD)
 	qcom_psci_fixup(*fdtp);
+#endif
 
 	return ret;
 }
@@ -313,7 +319,9 @@ void __weak qcom_board_init(void)
 
 int board_init(void)
 {
+#if CONFIG_IS_ENABLED(SYSRESET_PSCI) && !defined(CONFIG_SPL_BUILD)
 	show_psci_version();
+#endif
 	qcom_board_init();
 	return 0;
 }
@@ -749,3 +757,21 @@ void enable_caches(void)
 	}
 	dcache_enable();
 }
+
+/* for SPL */
+
+__weak void reset_cpu(void)
+{
+	/* TODO */
+	while (1) {
+		/* loop forever */
+	};
+}
+
+u32 spl_boot_device(void)
+{
+	/* TODO: check boot reason to support UFS and sdcard */
+	u32 boot_device = BOOT_DEVICE_DFU;
+
+	return boot_device;
+}
diff --git a/arch/arm/mach-snapdragon/include/mach/boot0.h b/arch/arm/mach-snapdragon/include/mach/boot0.h
index 953cccad790..d0020da4cd1 100644
--- a/arch/arm/mach-snapdragon/include/mach/boot0.h
+++ b/arch/arm/mach-snapdragon/include/mach/boot0.h
@@ -1,54 +1,11 @@
 /* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Workaround for "PSCI bug" on DragonBoard 410c
- * Copyright (C) 2021 Stephan Gerhold <stephan@gerhold.net>
- *
- * Syscall parameters taken from Qualcomm's LK fork (scm.h):
- * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
- *
- * The PSCI implementation in the TrustZone/tz firmware on DragonBoard 410c has
- * a bug that starts all other CPU cores in 32-bit mode unless the TZ syscall
- * that switches from 32-bit to 64-bit mode is executed at least once.
- *
- * Normally this happens inside Qualcomm's LK bootloader which runs in 32-bit
- * mode and uses the TZ syscall to boot a kernel in 64-bit mode. However, if
- * U-Boot is installed to the "aboot" partition (replacing LK) the switch to
- * 64-bit mode never happens since U-Boot is already running in 64-bit mode.
- *
- * A workaround for this "PSCI bug" is to execute the TZ syscall when entering
- * U-Boot. That way PSCI is made aware of the 64-bit switch and starts all other
- * CPU cores in 64-bit mode as well.
- */
-#include <linux/arm-smccc.h>
-
-#define ARM_SMCCC_SIP32_FAST_CALL \
-	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, 0)
-
-	/*
-	 * U-Boot might be started in EL2 or EL3 with custom firmware.
-	 * In that case, we assume that the workaround is not necessary or is
-	 * handled already by the alternative firmware. Using the syscall in EL2
-	 * would demote U-Boot to EL1; in EL3 it would probably just crash.
-	 */
-	mrs	x0, CurrentEL
-	cmp	x0, #(1 << 2)	/* EL1 */
-	bne	reset
-
-	/* Prepare TZ syscall parameters */
-	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
-	movk	x0, #0x10f	/* SCM_SVC_MILESTONE_CMD_ID */
-	mov	x1, #0x12	/* MAKE_SCM_ARGS(0x2, SMC_PARAM_TYPE_BUFFER_READ) */
-	adr	x2, el1_system_param
-	mov	x3, el1_system_param_end - el1_system_param
-
-	/* Switch PSCI to 64-bit mode. Resets CPU and returns at el1_elr */
-	smc	#0
-
-	/* Something went wrong, perhaps PSCI is already in 64-bit mode? */
+#if defined(CONFIG_SPL_BUILD)
+#if CONFIG_SPL_TARGET_SDM845
+#include "sdm845_spl_boot0.h"
+#else
 	b	reset
-
-	.align	3
-el1_system_param:
-	.quad	0, 0, 0, 0, 0, 0, 0, 0, 0	/* el1_x0-x8 */
-	.quad	reset				/* el1_elr */
-el1_system_param_end:
+#endif
+#else
+/* db410c */
+#include "msm8916_boot0.h"
+#endif
diff --git a/arch/arm/mach-snapdragon/include/mach/msm8916_boot0.h b/arch/arm/mach-snapdragon/include/mach/msm8916_boot0.h
new file mode 100644
index 00000000000..953cccad790
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/msm8916_boot0.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Workaround for "PSCI bug" on DragonBoard 410c
+ * Copyright (C) 2021 Stephan Gerhold <stephan@gerhold.net>
+ *
+ * Syscall parameters taken from Qualcomm's LK fork (scm.h):
+ * Copyright (c) 2011-2015, The Linux Foundation. All rights reserved.
+ *
+ * The PSCI implementation in the TrustZone/tz firmware on DragonBoard 410c has
+ * a bug that starts all other CPU cores in 32-bit mode unless the TZ syscall
+ * that switches from 32-bit to 64-bit mode is executed at least once.
+ *
+ * Normally this happens inside Qualcomm's LK bootloader which runs in 32-bit
+ * mode and uses the TZ syscall to boot a kernel in 64-bit mode. However, if
+ * U-Boot is installed to the "aboot" partition (replacing LK) the switch to
+ * 64-bit mode never happens since U-Boot is already running in 64-bit mode.
+ *
+ * A workaround for this "PSCI bug" is to execute the TZ syscall when entering
+ * U-Boot. That way PSCI is made aware of the 64-bit switch and starts all other
+ * CPU cores in 64-bit mode as well.
+ */
+#include <linux/arm-smccc.h>
+
+#define ARM_SMCCC_SIP32_FAST_CALL \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, 0)
+
+	/*
+	 * U-Boot might be started in EL2 or EL3 with custom firmware.
+	 * In that case, we assume that the workaround is not necessary or is
+	 * handled already by the alternative firmware. Using the syscall in EL2
+	 * would demote U-Boot to EL1; in EL3 it would probably just crash.
+	 */
+	mrs	x0, CurrentEL
+	cmp	x0, #(1 << 2)	/* EL1 */
+	bne	reset
+
+	/* Prepare TZ syscall parameters */
+	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
+	movk	x0, #0x10f	/* SCM_SVC_MILESTONE_CMD_ID */
+	mov	x1, #0x12	/* MAKE_SCM_ARGS(0x2, SMC_PARAM_TYPE_BUFFER_READ) */
+	adr	x2, el1_system_param
+	mov	x3, el1_system_param_end - el1_system_param
+
+	/* Switch PSCI to 64-bit mode. Resets CPU and returns at el1_elr */
+	smc	#0
+
+	/* Something went wrong, perhaps PSCI is already in 64-bit mode? */
+	b	reset
+
+	.align	3
+el1_system_param:
+	.quad	0, 0, 0, 0, 0, 0, 0, 0, 0	/* el1_x0-x8 */
+	.quad	reset				/* el1_elr */
+el1_system_param_end:
diff --git a/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
new file mode 100644
index 00000000000..5f9081c9aaf
--- /dev/null
+++ b/arch/arm/mach-snapdragon/include/mach/sdm845_spl_boot0.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Workaround for non-qcom-signed code being entered in EL1 on sdm845
+ * Copyright (C) 2026 Michael Srba <Michael.Srba@seznam.cz>
+ *
+ * This code uses an unintentional ownership enhancing feature in older builds of XBL_SEC
+ * in order to elevate our privileges to EL3 as soon as possible after a system reset.
+ * This allows for a very close approximation of a clean state.
+ *
+ * Do note that you still need to own the device in the sense that you control the code that
+ * XBL_SEC jumps to in EL1, which is sadly not a level of ownership commonly afforded to you
+ * by the device manufacturer. On such devices, CVE-2021-30327 could help, but it's not documented
+ * and there is no PoC available utilizing it
+ *
+ */
+#include <linux/arm-smccc.h>
+
+#define SCM_SMC_FNID(s, c)	((((s) & 0xFF) << 8) | ((c) & 0xFF))
+
+#define ARM_SMCCC_SIP32_FAST_CALL \
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL, ARM_SMCCC_SMC_32, ARM_SMCCC_OWNER_SIP, 0)
+
+/* same as with qcom's TZ */
+#define QCOM_SCM_SVC_MEM_DUMP 0x03
+/* unlike the TZ counterpart, in XBL_SEC this simply unlocks the XPUs */
+#define QCOM_SCM_MEM_DUMP_UNLOCK_SECURE_REGIONS 0x10
+
+/*
+ * We put our payload in place of some SCM call, the important thing is that it's hopefully
+ * in a memory region that is not in cache.
+ *
+ * It would be cleaner to just put our code at the scm entry point in the vector table,
+ * however it seems that we can't force cache coherency from EL1 if EL3 doesn't have
+ * any reason to care about that.
+ */
+#define QCOM_SCM_SVC_DONOR 0x01
+#define QCOM_SCM_DONOR 0x16
+/* we replace the instructions at this address with a jump to the start of u-boot */
+/* NOTE: this address is specific to a particular XBL_SEC elf */
+#define XBL_SEC_DONOR_SCM_ADDR 0x146a0ce0
+
+/* gnu as doesn't implement these useful pseudoinstructions */
+.macro movq Xn, imm
+    movz    \Xn,  \imm & 0xFFFF
+    movk    \Xn, (\imm >> 16) & 0xFFFF, lsl 16
+    movk    \Xn, (\imm >> 32) & 0xFFFF, lsl 32
+    movk    \Xn, (\imm >> 48) & 0xFFFF, lsl 48
+.endm
+
+.macro movl Wn, imm
+    movz    \Wn,  \imm & 0xFFFF
+    movk    \Wn, (\imm >> 16) & 0xFFFF, lsl 16
+.endm
+
+/* copy 32 bits to an address from a label */
+.macro copy32 addr, text_base, addrofval, offset
+	movl	x0, \addr
+	add	x0, x0, \offset
+	movq	x1, \text_base
+	add	x1, x1, \addrofval
+	add	x1, x1, \offset
+	ldr	w2, [x1]
+	str	w2, [x0]
+	dc	cvau, x0 // flush cache to RAM straight away, we need to do it by address anyway
+.endm
+
+.macro copy_instructions addr, text_base, start_addr, num_bytes // num_bytes must be a multiple of 4
+	mov x3,	#0x0 // x0, x1 and w2 used by copy32
+1:
+	copy32	\addr, \text_base, \start_addr, x3
+	add	x3, x3, #0x4 // i+=4
+	cmp	x3, \num_bytes
+	blo	1b
+.endm
+
+	/*  If we're already in EL3 for some reason,  skip this whole thing */
+	mrs	x0, CurrentEL
+	cmp	x0, #(3 << 2)	/* EL3 */
+	beq	reset
+
+	/* disable the mmu */
+	mrs	x0, sctlr_el1
+	and     x0, x0, #~(1 << 0) // CTRL_M
+	msr	sctlr_el1, x0
+
+	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
+	movk	x0, #SCM_SMC_FNID(QCOM_SCM_SVC_MEM_DUMP, QCOM_SCM_MEM_DUMP_UNLOCK_SECURE_REGIONS)
+	mov	x1, #0x0	/* no params */
+	mov	x6, #0x0
+
+	smc	#0 /* unlock XBL_SEC code area for writing (assuming old enough XBL_SEC build) */
+
+	/* this will also flush the writes from cache */
+	copy_instructions XBL_SEC_DONOR_SCM_ADDR, CONFIG_SPL_TEXT_BASE, el3_payload, #((el3_payload_end - el3_payload))
+
+	/* this probably doesn't affect EL3, but it doesn't hurt */
+	dsb	ish	/* block until cache is flushed */
+	ic	iallu	/* force re-fetch of our shiny new instructions */
+	dsb	ish	/* block until invalidation is finished */
+	isb	sy	/* unify here ? */
+
+	mov	x0, #ARM_SMCCC_SIP32_FAST_CALL
+	movk	x0, #SCM_SMC_FNID(QCOM_SCM_SVC_DONOR, QCOM_SCM_DONOR)
+	mov	x1, #0x0	/* no params */
+	smc	#0	/* call the payload */
+
+el3_ret_point:
+	b	reset
+
+el3_payload:
+	/* disable the mmu for EL3 too */
+	mrs	x0, sctlr_el3
+	and     x0, x0, #~(1 << 0) // CTRL_M
+	msr	sctlr_el3, x0
+
+	/*  */
+	movl	x0, CONFIG_SPL_TEXT_BASE
+	add	x0, x0, el3_ret_point
+	br	x0
+el3_payload_end:
diff --git a/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
new file mode 100644
index 00000000000..10912f416cc
--- /dev/null
+++ b/arch/arm/mach-snapdragon/u-boot-spl-elf-sdm845.lds
@@ -0,0 +1,25 @@
+TARGET("binary")
+INPUT("./xbl_sec.elf")
+
+OUTPUT_FORMAT("default")
+
+ENTRY(CONFIG_PLATFORM_ELFENTRY)
+PHDRS
+{
+	data PT_LOAD FLAGS(7);
+	xbl_sec PT_LOAD FLAGS(5 | (0x5 << 24));
+}
+SECTIONS
+{
+	. = 0x0000000014699000;
+	.xbl_sec : { // XBL_SEC nested ELF
+		. = .;
+		"./xbl_sec.elf"
+	} :xbl_sec
+
+	. = CONFIG_PLATFORM_ELFENTRY;
+
+	.data : {
+		*(.data*)
+	} :data
+}
diff --git a/board/qualcomm/sdm845_spl.env b/board/qualcomm/sdm845_spl.env
new file mode 100644
index 00000000000..5f1583c75f0
--- /dev/null
+++ b/board/qualcomm/sdm845_spl.env
@@ -0,0 +1 @@
+dfu_alt_info_ram=uboot.bin ram 0x1487FFC0 0x180000
diff --git a/configs/sdm845_spl_defconfig b/configs/sdm845_spl_defconfig
new file mode 100644
index 00000000000..eacee34cad6
--- /dev/null
+++ b/configs/sdm845_spl_defconfig
@@ -0,0 +1,130 @@
+CONFIG_ARM=y
+CONFIG_SKIP_LOWLEVEL_INIT=y
+CONFIG_COUNTER_FREQUENCY=19200000
+CONFIG_POSITION_INDEPENDENT=y
+# CONFIG_INIT_SP_RELATIVE is not set
+CONFIG_ARCH_SNAPDRAGON=y
+CONFIG_TEXT_BASE=0x14880000
+CONFIG_SYS_MALLOC_LEN=0x20000
+CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
+CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x146bffff
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SYS_BOOTM_LEN=0x4000000
+CONFIG_SYS_LOAD_ADDR=0x0
+CONFIG_WATCHDOG_TIMEOUT_MSECS=60000
+CONFIG_QCOM_SPL=y
+CONFIG_SPL_TARGET_SDM845=y
+CONFIG_SPL_MAX_SIZE=0x0
+CONFIG_SPL_PAYLOAD="u-boot.img"
+CONFIG_BUILD_TARGET="u-boot-with-spl.elf"
+CONFIG_SKIP_RELOCATE=y
+# CONFIG_EFI_LOADER is not set
+CONFIG_OF_BOARD_SETUP=y
+CONFIG_USE_PREBOOT=y
+CONFIG_CONSOLE_RECORD=y
+CONFIG_CONSOLE_RECORD_OUT_SIZE=0xA000
+CONFIG_CONSOLE_RECORD_OUT_SIZE_F=0xA000
+CONFIG_LOGLEVEL=9
+CONFIG_SYS_STDIO_DEREGISTER=y
+CONFIG_LOG_MAX_LEVEL=9
+CONFIG_SPL_LOG=y
+CONFIG_SPL_LOG_MAX_LEVEL=9
+# CONFIG_DISPLAY_CPUINFO is not set
+CONFIG_SPL_DMA=y
+CONFIG_SPL_DM_RESET=y
+CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_BOOTM_NETBSD=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_UFS=y
+CONFIG_CMD_CAT=y
+CONFIG_CMD_RNG=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_LOG=y
+CONFIG_ENV_USE_DEFAULT_ENV_TEXT_FILE=y
+CONFIG_ENV_DEFAULT_ENV_TEXT_FILE="board/qualcomm/sdm845_spl.env"
+CONFIG_NET_RANDOM_ETHADDR=y
+# CONFIG_OFNODE_MULTI_TREE is not set
+CONFIG_BUTTON_QCOM_PMIC=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK=y
+CONFIG_CLK_STUB=y
+CONFIG_SPL_CLK_STUB=y
+CONFIG_CLK_QCOM_SDM845=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_DFU_SCSI=y
+CONFIG_SYS_DFU_DATA_BUF_SIZE=0x5000
+CONFIG_DMA=y
+CONFIG_DMA_CHANNELS=y
+CONFIG_USB_FUNCTION_FASTBOOT=y
+CONFIG_FASTBOOT_BUF_ADDR=0xdeadbeef
+CONFIG_MSM_GPIO=y
+CONFIG_QCOM_PMIC_GPIO=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_QUP=y
+CONFIG_I2C_MUX=y
+CONFIG_IOMMU=y
+CONFIG_QCOM_HYP_SMMU=y
+CONFIG_MISC=y
+CONFIG_NVMEM=y
+CONFIG_I2C_EEPROM=y
+CONFIG_MMC_SDHCI=y
+CONFIG_MMC_SDHCI_ADMA=y
+CONFIG_MMC_SDHCI_MSM=y
+CONFIG_DM_ETH_PHY=y
+CONFIG_PHY=y
+CONFIG_SPL_PHY=y
+CONFIG_PHY_QCOM_QMP_UFS=y
+CONFIG_PHY_QCOM_QUSB2=y
+CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=y
+CONFIG_PHY_QCOM_SNPS_EUSB2=y
+CONFIG_PHY_QCOM_USB_HS_28NM=y
+CONFIG_PHY_QCOM_USB_SS=y
+CONFIG_PINCTRL=y
+CONFIG_PINCONF=y
+CONFIG_PINCTRL_QCOM_APQ8016=y
+CONFIG_PINCTRL_QCOM_APQ8096=y
+CONFIG_PINCTRL_QCOM_QCM2290=y
+CONFIG_PINCTRL_QCOM_QCS404=y
+CONFIG_PINCTRL_QCOM_SDM845=y
+CONFIG_PINCTRL_QCOM_SM6115=y
+CONFIG_PINCTRL_QCOM_SM8250=y
+CONFIG_PINCTRL_QCOM_SM8550=y
+CONFIG_PINCTRL_QCOM_SM8650=y
+CONFIG_PINCTRL_QCOM_X1E80100=y
+CONFIG_DM_PMIC=y
+CONFIG_PMIC_QCOM=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_QCOM_RPMH=y
+CONFIG_DM_RNG=y
+CONFIG_RNG_MSM=y
+CONFIG_SCSI=y
+CONFIG_MSM_SERIAL=y
+CONFIG_SOC_QCOM=y
+CONFIG_QCOM_COMMAND_DB=y
+CONFIG_QCOM_RPMH=y
+CONFIG_SPL_SPMI=y
+CONFIG_SPMI_MSM=y
+CONFIG_SYSINFO=y
+CONFIG_SYSINFO_SMBIOS=y
+CONFIG_SYSRESET_QCOM_PSHOLD=y
+CONFIG_USB=y
+CONFIG_USB_DWC3=y
+CONFIG_USB_DWC3_GENERIC=y
+CONFIG_SPL_USB_DWC3_GENERIC=y
+CONFIG_USB_GADGET=y
+CONFIG_USB_GADGET_VENDOR_NUM=0x0525
+CONFIG_USB_GADGET_PRODUCT_NUM=0xb4a4
+CONFIG_USB_ETHER=y
+CONFIG_USB_ETH_CDC=y
+CONFIG_SPL_DFU=y
+CONFIG_SPL_USB_SDP_SUPPORT=y
+CONFIG_UFS=y
+# CONFIG_SPL_USE_TINY_PRINTF is not set
+CONFIG_CIRCBUF=y
diff --git a/doc/board/qualcomm/index.rst b/doc/board/qualcomm/index.rst
index 3238a68e859..65e3e222f68 100644
--- a/doc/board/qualcomm/index.rst
+++ b/doc/board/qualcomm/index.rst
@@ -14,3 +14,4 @@ Qualcomm
    iq8
    phones
    rdp
+   spl
diff --git a/doc/board/qualcomm/spl.rst b/doc/board/qualcomm/spl.rst
new file mode 100644
index 00000000000..817c76b659e
--- /dev/null
+++ b/doc/board/qualcomm/spl.rst
@@ -0,0 +1,70 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. sectionauthor:: Michael Srba <Michael.Srba@seznam.cz>
+
+======================================
+Booting U-Boot SPL on Qualcomm SoCs
+======================================
+
+Overview
+----------
+The boot process on sdm845 (and some other Qualcomm SoCs) starts with the bootrom
+of the Application Processor, which executes XBL_SEC, which jumps to "OEM" code
+in EL1. Production device typically are "fused", with a hash of the OEM's signing
+key burnt into one of the "QFUSE" banks on the SoC making it impossible to run
+custom bootloader code. As a result U-Boot SPL is only supported on unfused
+("secureboot off") devices. XBL_SEC is always signed by qualcomm, and the fuses
+to disable turning off signature verification for it are always burnt at the
+factory, so replacing XBL_SEC is impossible without using JTAG. Of course JTAG
+is typically disabled on devices that have secure boot enabled, or at minimum
+greatly neutered.
+
+U-Boot SPL for Qualcomm platforms uses a custom linker script (per SoC) to build a bootable ELF.
+For sdm845 (and some other platforms) this has two sections, u-boot code and an embedded
+xbl_sec elf (signed by qualcomm). To boot on an unfused SoC, the elf additionally
+needs to have hash sections added, which can be accomplished with qtestsign.
+
+Currently, sdm845 is supported. You need a device with secure boot disabled
+(or with secure boot enabled if you enabled it yourself and have the private key,
+though for full security you'd also want to disable JTAG which will remove your ability
+to mess with the control flow in the bootrom (immutable) and in XBL_SEC (signed)).
+
+Building
+----------
+First, obtain an xbl_sec that includes the EL3 privilege escalation feature
+and place it at .output/xbl_sec.elf. You can extract it from an xbl elf.
+If you're unable to find one, you can also use JTAG/SWD to break at the SMC
+entry and use gdp to jump to the u-boot entry point in EL3.
+
+To build a bootable image, you need to use a defconfig specific to your SoC.
+This is because the ELF has to specify where in the address space to put u-boot SPL,
+and this may differ per SoC. There may be other SoC-dependent build time choices,
+though in principle those could be made at runtime.
+
+.. code-block:: shell
+   make CROSS_COMPILE=aarch64-suse-linux- O=.output DEVICE_TREE=qcom/sdm845-shift-axolotl sdm845_spl_defconfig
+
+Then compile u-boot and specify the dts for your board (technically nothing about the resulting
+SPL image should be board-specific, but there are no non-board-specific device trees in Linux)
+
+.. code-block:: shell
+   make CROSS_COMPILE=aarch64-suse-linux- O=.output DEVICE_TREE=qcom/sdm845-shift-axolotl
+
+Finally, use qtestsign to add the hash segments required by PBL
+
+.. code-block:: shell
+   qtestsign -v 5 -o .output/spl/u-boot-spl_signed.elf prog .output/spl/u-boot-spl.elf
+
+Running
+----------
+Currently, U-Boot SPL for qualcomm platforms expects to be booted via EDL:
+
+.. code-block:: shell
+   edl.py --loader=$PWD/.output/spl/u-boot-spl_signed.elf
+
+SPL will then launch the DFU gadget and wait for you to upload u-boot proper:
+
+.. code-block:: shell
+   dfu-util -RD .output/u-boot.img
+
+u-boot proper will then likely crash, since SPL currently doesn't init DRAM on qualcomm platforms
+and u-boot proper currently doesn't support running from SRAM. The latter should be an easy fix.

-- 
2.53.0

