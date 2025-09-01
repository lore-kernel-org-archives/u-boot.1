Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52DA5CA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:17:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69927833E9;
	Mon,  1 Sep 2025 08:17:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="qO0/J3FW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B6B3883980; Mon,  1 Sep 2025 08:17:11 +0200 (CEST)
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 864F9833AD
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from lelvem-sh01.itg.ti.com ([10.180.77.71])
 by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5816H5Ps2251128;
 Mon, 1 Sep 2025 01:17:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756707425;
 bh=2T8RsmfSwogtS1Yc7fq+edl0iUYDit4nY2r/iwaeeBU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=qO0/J3FWLf5V19eXfEJ8hzRIwJn9d0bDHlUpWl17xuhC/lqFejIMjjozNcL8B1xqu
 G970VWrgLE6hsHTP947558nIzTP56FIw+Z9iX5uaW8RB13jlClYksDK+Rv65OpxC1d
 pj7wrZNAfXDDoE9dfW5NQDtiwZreytmuQZztFdx8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelvem-sh01.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5816H5VT1338540
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 1 Sep 2025 01:17:05 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 01:17:04 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 01:17:04 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5816H0GS1998362;
 Mon, 1 Sep 2025 01:17:03 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <a-dutta@ti.com>
Subject: [PATCH v2 1/4] include: env: ti: Use .env for environment variables
Date: Mon, 1 Sep 2025 11:46:56 +0530
Message-ID: <20250901061659.986164-2-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901061659.986164-1-a-dutta@ti.com>
References: <20250901061659.986164-1-a-dutta@ti.com>
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

Add omap common environment variables to .env. We retain the old-style C
environment .h files to maintain compatibility with other omap devices that
have not moved to using .env yet.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 include/configs/ti_omap5_common.h | 228 ------------------------------
 include/env/ti/dfu.env            |  53 +++++++
 2 files changed, 53 insertions(+), 228 deletions(-)
 create mode 100644 include/env/ti/dfu.env

diff --git a/include/configs/ti_omap5_common.h b/include/configs/ti_omap5_common.h
index 39102f15eb9..9e02b0d0040 100644
--- a/include/configs/ti_omap5_common.h
+++ b/include/configs/ti_omap5_common.h
@@ -39,216 +39,6 @@
 #define DFUARGS
 #endif
 
-#include <env/ti/mmc.h>
-#include <env/ti/nand.h>
-
-#ifndef CONSOLEDEV
-#define CONSOLEDEV "ttyS2"
-#endif
-
-#ifndef PARTS_DEFAULT
-/*
- * Default GPT tables for eMMC (Linux and Android). Notes:
- *   1. Keep partitions aligned to erase group size (512 KiB) when possible
- *   2. Keep partitions in sync with DFU_ALT_INFO_EMMC (see dfu.h)
- *   3. Keep 'bootloader' partition (U-Boot proper) start address in sync with
- *      CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR (see common/spl/Kconfig)
- */
-#define PARTS_DEFAULT \
-	/* Linux partitions */ \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=bootloader,start=384K,size=1792K,uuid=${uuid_gpt_bootloader};" \
-	"name=rootfs,start=2688K,size=-,uuid=${uuid_gpt_rootfs}\0" \
-	/* Android partitions */ \
-	"partitions_android=" \
-	"uuid_disk=${uuid_gpt_disk};" \
-	"name=xloader,start=128K,size=256K,uuid=${uuid_gpt_xloader};" \
-	"name=bootloader,size=2048K,uuid=${uuid_gpt_bootloader};" \
-	"name=uboot-env,start=2432K,size=256K,uuid=${uuid_gpt_reserved};" \
-	"name=misc,size=128K,uuid=${uuid_gpt_misc};" \
-	"name=boot_a,size=20M,uuid=${uuid_gpt_boot_a};" \
-	"name=boot_b,size=20M,uuid=${uuid_gpt_boot_b};" \
-	"name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};" \
-	"name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};" \
-	"name=vbmeta_a,size=64K,uuid=${uuid_gpt_vbmeta_a};" \
-	"name=vbmeta_b,size=64K,uuid=${uuid_gpt_vbmeta_b};" \
-	"name=recovery,size=64M,uuid=${uuid_gpt_recovery};" \
-	"name=super,size=2560M,uuid=${uuid_gpt_super};" \
-	"name=metadata,size=16M,uuid=${uuid_gpt_metadata};" \
-	"name=userdata,size=-,uuid=${uuid_gpt_userdata}"
-#endif /* PARTS_DEFAULT */
-
-#if defined(CONFIG_CMD_AVB)
-#define AVB_VERIFY_CHECK "if run avb_verify; then " \
-				"echo AVB verification OK.;" \
-				"set bootargs $bootargs $avb_bootargs;" \
-			"else " \
-				"echo AVB verification failed.;" \
-			"exit; fi;"
-#define AVB_VERIFY_CMD "avb_verify=avb init 1; avb verify $slot_suffix;\0"
-#else
-#define AVB_VERIFY_CHECK ""
-#define AVB_VERIFY_CMD ""
-#endif
-
-#define CONTROL_PARTITION "misc"
-
-#if defined(CONFIG_CMD_BCB) && defined(CONFIG_ANDROID_AB)
-#define AB_SELECT_SLOT \
-	"if part number mmc 1 " CONTROL_PARTITION " control_part_number; " \
-	"then " \
-		"echo " CONTROL_PARTITION \
-			" partition number:${control_part_number};" \
-		"bcb ab_select slot_name mmc ${mmcdev}:${control_part_number};" \
-	"else " \
-		"echo " CONTROL_PARTITION " partition not found;" \
-		"exit;" \
-	"fi;" \
-	"setenv slot_suffix _${slot_name};"
-#define AB_SELECT_ARGS \
-	"setenv bootargs_ab androidboot.slot_suffix=${slot_suffix}; " \
-	"echo A/B cmdline addition: ${bootargs_ab};" \
-	"setenv bootargs ${bootargs} ${bootargs_ab};"
-#else
-#define AB_SELECT_SLOT ""
-#define AB_SELECT_ARGS ""
-#endif
-
-/*
- * Prepares complete device tree blob for current board (for Android boot).
- *
- * Boot image or recovery image should be loaded into $loadaddr prior to running
- * these commands. The logic of these commnads is next:
- *
- *   1. Read correct DTB for current SoC/board from boot image in $loadaddr
- *      to $fdtaddr
- *   2. Merge all needed DTBO for current board from 'dtbo' partition into read
- *      DTB
- *   3. User should provide $fdtaddr as 3rd argument to 'bootm'
- */
-#define PREPARE_FDT \
-	"echo Preparing FDT...; " \
-	"if test $board_name = am57xx_evm_reva3; then " \
-		"echo \"  Reading DTBO partition...\"; " \
-		"part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start; " \
-		"part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size; " \
-		"mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size}; " \
-		"echo \"  Reading DTB for AM57x EVM RevA3...\"; " \
-		"abootimg get dtb --index=0 dtb_start dtb_size; " \
-		"cp.b $dtb_start $fdtaddr $dtb_size; " \
-		"fdt addr $fdtaddr 0x80000; " \
-		"echo \"  Applying DTBOs for AM57x EVM RevA3...\"; " \
-		"adtimg addr $dtboaddr; " \
-		"adtimg get dt --index=0 dtbo0_addr dtbo0_size; " \
-		"fdt apply $dtbo0_addr; " \
-		"adtimg get dt --index=1 dtbo1_addr dtbo1_size; " \
-		"fdt apply $dtbo1_addr; " \
-	"elif test $board_name = beagle_x15_revc; then " \
-		"echo \"  Reading DTB for Beagle X15 RevC...\"; " \
-		"abootimg get dtb --index=0 dtb_start dtb_size; " \
-		"cp.b $dtb_start $fdtaddr $dtb_size; " \
-		"fdt addr $fdtaddr 0x80000; " \
-	"else " \
-		"echo Error: Android boot is not supported for $board_name; " \
-		"exit; " \
-	"fi; " \
-
-#define DEFAULT_COMMON_BOOT_TI_ARGS \
-	"console=" CONSOLEDEV ",115200n8\0" \
-	"fdtfile=undefined\0" \
-	"finduuid=part uuid mmc 0:2 uuid\0" \
-	"usbtty=cdc_acm\0" \
-	"vram=16M\0" \
-	AVB_VERIFY_CMD \
-	"partitions=" PARTS_DEFAULT "\0" \
-	"optargs=\0" \
-	"dofastboot=0\0" \
-	"emmc_android_boot=" \
-		"setenv mmcdev 1; " \
-		"mmc dev $mmcdev; " \
-		"mmc rescan; " \
-		AB_SELECT_SLOT \
-		"if bcb load " __stringify(CONFIG_FASTBOOT_FLASH_MMC_DEV) " " \
-		CONTROL_PARTITION "; then " \
-			"setenv ardaddr -; " \
-			"if bcb test command = bootonce-bootloader; then " \
-				"echo Android: Bootloader boot...; " \
-				"bcb clear command; bcb store; " \
-				"fastboot 1; " \
-				"exit; " \
-			"elif bcb test command = boot-recovery; then " \
-				"echo Android: Recovery boot...; " \
-				"setenv ardaddr $loadaddr;" \
-				"setenv apart recovery; " \
-			"else " \
-				"echo Android: Normal boot...; " \
-				"setenv ardaddr $loadaddr; " \
-				"setenv apart boot${slot_suffix}; " \
-			"fi; " \
-		"else " \
-			"echo Warning: BCB is corrupted or does not exist; " \
-			"echo Android: Normal boot...; " \
-		"fi; " \
-		"setenv eval_bootargs setenv bootargs $bootargs; " \
-		"run eval_bootargs; " \
-		"setenv machid fe6; " \
-		AVB_VERIFY_CHECK \
-		AB_SELECT_ARGS \
-		"if part start mmc $mmcdev $apart boot_start; then " \
-			"part size mmc $mmcdev $apart boot_size; " \
-			"mmc read $loadaddr $boot_start $boot_size; " \
-			PREPARE_FDT \
-			"bootm $loadaddr $ardaddr $fdtaddr; " \
-		"else " \
-			"echo $apart partition not found; " \
-			"exit; " \
-		"fi;\0"
-
-#define DEFAULT_FDT_TI_ARGS \
-	"findfdt="\
-		"if test $board_name = omap5_uevm; then " \
-			"setenv fdtfile omap5-uevm.dtb; fi; " \
-		"if test $board_name = dra7xx; then " \
-			"setenv fdtfile dra7-evm.dtb; fi;" \
-		"if test $board_name = dra72x-revc; then " \
-			"setenv fdtfile dra72-evm-revc.dtb; fi;" \
-		"if test $board_name = dra72x; then " \
-			"setenv fdtfile dra72-evm.dtb; fi;" \
-		"if test $board_name = dra71x; then " \
-			"setenv fdtfile dra71-evm.dtb; fi;" \
-		"if test $board_name = dra76x_acd; then " \
-			"setenv fdtfile dra76-evm.dtb; fi;" \
-		"if test $board_name = beagle_x15; then " \
-			"setenv fdtfile am57xx-beagle-x15.dtb; fi;" \
-		"if test $board_name = beagle_x15_revb1; then " \
-			"setenv fdtfile am57xx-beagle-x15-revb1.dtb; fi;" \
-		"if test $board_name = beagle_x15_revc; then " \
-			"setenv fdtfile am57xx-beagle-x15-revc.dtb; fi;" \
-		"if test $board_name = am5729_beagleboneai; then " \
-			"setenv fdtfile am5729-beagleboneai.dtb; fi;" \
-		"if test $board_name = am572x_idk; then " \
-			"setenv fdtfile am572x-idk.dtb; fi;" \
-		"if test $board_name = am574x_idk; then " \
-			"setenv fdtfile am574x-idk.dtb; fi;" \
-		"if test $board_name = am57xx_evm; then " \
-			"setenv fdtfile am57xx-beagle-x15.dtb; fi;" \
-		"if test $board_name = am57xx_evm_reva3; then " \
-			"setenv fdtfile am57xx-beagle-x15.dtb; fi;" \
-		"if test $board_name = am571x_idk; then " \
-			"setenv fdtfile am571x-idk.dtb; fi;" \
-		"if test $fdtfile = undefined; then " \
-			"echo WARNING: Could not determine device tree to use; fi; \0"
-
-#define GET_OVERLAY_MMC_TI_ARGS \
-	"get_overlay_mmc=" \
-		"fdt address ${fdtaddr};" \
-		"fdt resize 0x100000;" \
-		"for overlay in $name_overlays;" \
-		"do;" \
-			"load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/${overlay} &&" \
-			"fdt apply ${dtboaddr};" \
-		"done;\0" \
-
 #define BOOT_TARGET_DEVICES(func) \
 	func(TI_MMC, ti_mmc, na) \
 	func(MMC, mmc, 0) \
@@ -265,24 +55,6 @@
 #include <config_distro_bootcmd.h>
 
 #define CFG_EXTRA_ENV_SETTINGS \
-	DEFAULT_LINUX_BOOT_ENV \
-	DEFAULT_MMC_TI_ARGS \
-	"bootpart=0:2\0" \
-	"bootdir=/boot\0" \
-	"get_name_kern=" \
-	"if test $boot_fit -eq 1; then " \
-		"setenv bootfile fitImage; " \
-	"else " \
-		"setenv bootfile zImage; " \
-	"fi\0" \
-	DEFAULT_FIT_TI_ARGS \
-	"get_fit_config=setenv name_fit_config ${fdtfile}\0" \
-	DEFAULT_COMMON_BOOT_TI_ARGS \
-	DEFAULT_FDT_TI_ARGS \
-	GET_OVERLAY_MMC_TI_ARGS \
-	DFUARGS \
-	NETARGS \
-	NANDARGS \
 	BOOTENV
 
 /*
diff --git a/include/env/ti/dfu.env b/include/env/ti/dfu.env
new file mode 100644
index 00000000000..b925730c6f5
--- /dev/null
+++ b/include/env/ti/dfu.env
@@ -0,0 +1,53 @@
+dfu_alt_info_mmc=
+	boot part 0 1;
+	rootfs part 0 2;
+	MLO fat 0 1;
+	MLO.raw raw 0x100 0x200;
+	u-boot.img.raw raw 0x300 0x1000;
+	u-env.raw raw 0x1300 0x200;
+	spl-os-args.raw raw 0x1500 0x200;
+	spl-os-image.raw raw 0x1700 0x6900;
+	spl-os-args fat 0 1;
+	spl-os-image fat 0 1;
+	u-boot.img fat 0 1;
+	uEnv.txt fat 0 1
+
+dfu_alt_info_emmc=
+	rawemmc raw 0 3751936;
+	boot part 1 1;
+	rootfs part 1 2;
+	MLO fat 1 1;
+	MLO.raw raw 0x100 0x200;
+	u-boot.img.raw raw 0x300 0x1000;
+	u-env.raw raw 0x1300 0x200;
+	spl-os-args.raw raw 0x1500 0x200;
+	spl-os-image.raw raw 0x1700 0x6900;
+	spl-os-args fat 1 1;
+	spl-os-image fat 1 1;
+	u-boot.img fat 1 1;
+	uEnv.txt fat 1 1
+
+#if CONFIG_MTD_RAW_NAND
+dfu_alt_info_nand=
+	SPL part 0 1;
+	SPL.backup1 part 0 2;
+	SPL.backup2 part 0 3;
+	SPL.backup3 part 0 4;
+	u-boot part 0 5;
+	u-boot-spl-os part 0 6;
+	kernel part 0 8;
+	rootfs part 0 9
+#endif
+
+dfu_alt_info_ram=
+	kernel ram 0x80200000 0x4000000;
+	fdt ram 0x80f80000 0x80000;
+	ramdisk ram 0x81000000 0x4000000
+
+dfu_alt_info_qspi=
+	MLO raw 0x0 0x040000;
+	u-boot.img raw 0x040000 0x0100000;
+	u-boot-spl-os raw 0x140000 0x080000;
+	u-boot-env raw 0x1C0000 0x010000;
+	u-boot-env.backup raw 0x1D0000 0x010000;
+	kernel raw 0x1E0000 0x800000
-- 
2.34.1

