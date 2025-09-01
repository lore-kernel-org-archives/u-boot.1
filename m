Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A93AECA0FFD
	for <u-boot@archiver.kernel.org>; Mon,  1 Sep 2025 06:17:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B50EE8399D;
	Mon,  1 Sep 2025 08:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="wWhvdM72";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 371E5833AD; Mon,  1 Sep 2025 08:17:13 +0200 (CEST)
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08DF98397A
 for <u-boot@lists.denx.de>; Mon,  1 Sep 2025 08:17:08 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
Received: from fllvem-sh04.itg.ti.com ([10.64.41.54])
 by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 5816H7FM2745388;
 Mon, 1 Sep 2025 01:17:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1756707427;
 bh=ckICdV74Dgs3IL1JQ3u3We8CiJ0ncr4dBTt2xGXZcM4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=wWhvdM72hHifmaut0rBE1S6F6dClchVFI5pPGVI74zXkkG4jBWkSdAtL23SToxLw/
 Rvg525EmxSqXtELsQpqhXHyuyKQWzgNbaaTLatGrlz8ayIltdlxx3tw4Rni8Rxu/H4
 olRdNkVNzORPKi6AKQyzdWc5rBO+dqV8lB4O5J1s=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by fllvem-sh04.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 5816H7DI2514196
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
 Mon, 1 Sep 2025 01:17:07 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Mon, 1
 Sep 2025 01:17:06 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Mon, 1 Sep 2025 01:17:06 -0500
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.68.237])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5816H0GT1998362;
 Mon, 1 Sep 2025 01:17:05 -0500
From: Anurag Dutta <a-dutta@ti.com>
To: <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <u-boot@lists.denx.de>, <a-dutta@ti.com>
Subject: [PATCH v2 2/4] board: ti: am57xx: Change to using .env
Date: Mon, 1 Sep 2025 11:46:57 +0530
Message-ID: <20250901061659.986164-3-a-dutta@ti.com>
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

Move to using .env file for setting up environment variables
for am57xx and dra7xx.

Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---
 board/ti/am57xx/Kconfig      |  12 +++
 board/ti/am57xx/am57xx.env   | 162 +++++++++++++++++++++++++++++++++++
 include/configs/am57xx_evm.h |  19 +---
 include/configs/dra7xx_evm.h |  24 ------
 4 files changed, 175 insertions(+), 42 deletions(-)
 create mode 100644 board/ti/am57xx/am57xx.env

diff --git a/board/ti/am57xx/Kconfig b/board/ti/am57xx/Kconfig
index 0c566820158..b6943938391 100644
--- a/board/ti/am57xx/Kconfig
+++ b/board/ti/am57xx/Kconfig
@@ -9,6 +9,18 @@ config SYS_VENDOR
 config SYS_CONFIG_NAME
 	default "am57xx_evm"
 
+config ENV_SOURCE_FILE
+	default "am57xx"
+
+source "board/ti/common/Kconfig"
+
+endif
+
+if TARGET_DRA7XX_EVM
+
+config ENV_SOURCE_FILE
+	default "am57xx"
+
 source "board/ti/common/Kconfig"
 
 endif
diff --git a/board/ti/am57xx/am57xx.env b/board/ti/am57xx/am57xx.env
new file mode 100644
index 00000000000..7d029a3e859
--- /dev/null
+++ b/board/ti/am57xx/am57xx.env
@@ -0,0 +1,162 @@
+#include <env/ti/ti_common.env>
+#include <env/ti/mmc.env>
+#include <env/ti/dfu.env>
+
+bootpart=0:2
+bootdir=/boot
+get_name_kern=
+	if test $boot_fit -eq 1; then
+		setenv bootfile fitImage;
+	else
+		setenv bootfile zImage;
+	fi
+get_fit_config=setenv name_fit_config ${fdtfile}
+console=ttyS2,115200n8
+fdtfile=undefined
+finduuid=part uuid mmc 0:2 uuid
+usbtty=cdc_acm
+vram=16M
+
+#if CONFIG_CMD_AVB
+avb_verify=avb init 1; avb verify $slot_suffix;
+#endif
+
+partitions=uuid_disk=${uuid_gpt_disk};
+	name=bootloader,start=384K,size=1792K,uuid=${uuid_gpt_bootloader};
+	name=rootfs,start=2688K,size=-,uuid=${uuid_gpt_rootfs}
+	partitions_android=
+	uuid_disk=${uuid_gpt_disk};
+	name=xloader,start=128K,size=256K,uuid=${uuid_gpt_xloader};
+	name=bootloader,size=2048K,uuid=${uuid_gpt_bootloader};
+	name=uboot-env,start=2432K,size=256K,uuid=${uuid_gpt_reserved};
+	name=misc,size=128K,uuid=${uuid_gpt_misc};
+	name=boot_a,size=20M,uuid=${uuid_gpt_boot_a};
+	name=boot_b,size=20M,uuid=${uuid_gpt_boot_b};
+	name=dtbo_a,size=8M,uuid=${uuid_gpt_dtbo_a};
+	name=dtbo_b,size=8M,uuid=${uuid_gpt_dtbo_b};
+	name=vbmeta_a,size=64K,uuid=${uuid_gpt_vbmeta_a};
+	name=vbmeta_b,size=64K,uuid=${uuid_gpt_vbmeta_b};
+	name=recovery,size=64M,uuid=${uuid_gpt_recovery};
+	name=super,size=2560M,uuid=${uuid_gpt_super};
+	name=metadata,size=16M,uuid=${uuid_gpt_metadata};
+	name=userdata,size=-,uuid=${uuid_gpt_userdata}
+optargs=
+dofastboot=0
+emmc_android_boot=
+	setenv mmcdev 1;
+	mmc dev $mmcdev;
+	mmc rescan;
+#if CONFIG_CMD_BCB
+#if CONFIG_ANDROID_AB
+	if part number mmc 1 misc control_part_number; then
+		echo "misc partition number:${control_part_number};"
+		bcb ab_select slot_name mmc ${mmcdev}:${control_part_number};
+	else
+		echo "misc partition not found;"
+		exit;
+	fi;
+	setenv slot_suffix _${slot_name};
+#endif
+#endif
+if bcb load CONFIG_FASTBOOT_FLASH_MMC_DEV misc; then
+	setenv ardaddr -;
+	if bcb test command = bootonce-bootloader; then
+		echo "Android: Bootloader boot...";
+		bcb clear command; bcb store;
+		fastboot 1;
+		exit;
+	elif bcb test command = boot-recovery; then
+		echo "Android: Recovery boot...";
+		setenv ardaddr $loadaddr;
+		setenv apart recovery;
+	else
+		echo "Android: Normal boot...";
+		setenv ardaddr $loadaddr;
+		setenv apart boot${slot_suffix};
+	fi;
+else
+	echo "Warning: BCB is corrupted or does not exist";
+	echo "Android: Normal boot...";
+fi;
+setenv eval_bootargs setenv bootargs $bootargs;
+run eval_bootargs;
+setenv machid fe6;
+#if CONFIG_CMD_AVB
+if run avb_verify; then
+	echo "AVB verification OK.";
+	set bootargs $bootargs $avb_bootargs;
+else
+	echo "AVB verification failed.";
+	exit;
+fi;
+#endif
+#if CONFIG_CMD_BCB
+#if CONFIG_ANDROID_AB
+setenv bootargs_ab androidboot.slot_suffix=${slot_suffix};
+echo "A/B cmdline addition: ${bootargs_ab}";
+setenv bootargs ${bootargs} ${bootargs_ab};
+#endif
+#endif
+if part start mmc $mmcdev $apart boot_start; then
+	part size mmc $mmcdev $apart boot_size;
+	mmc read $loadaddr $boot_start $boot_size;
+	echo "Preparing FDT...";
+	if test $board_name = am57xx_evm_reva3; then
+		echo "  Reading DTBO partition...";
+		part start mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_start;
+		part size mmc ${mmcdev} dtbo${slot_suffix} p_dtbo_size;
+		mmc read ${dtboaddr} ${p_dtbo_start} ${p_dtbo_size};
+		echo "  Reading DTB for AM57x EVM RevA3...";
+		abootimg get dtb --index=0 dtb_start dtb_size;
+		cp.b $dtb_start $fdtaddr $dtb_size;
+		fdt addr $fdtaddr 0x80000;
+		echo "  Applying DTBOs for AM57x EVM RevA3...";
+		adtimg addr $dtboaddr;
+		adtimg get dt --index=0 dtbo0_addr dtbo0_size;
+		fdt apply $dtbo0_addr;
+		adtimg get dt --index=1 dtbo1_addr dtbo1_size;
+		fdt apply $dtbo1_addr;
+	elif test $board_name = beagle_x15_revc; then
+		echo "  Reading DTB for Beagle X15 RevC...";
+		abootimg get dtb --index=0 dtb_start dtb_size;
+		cp.b $dtb_start $fdtaddr $dtb_size;
+		fdt addr $fdtaddr 0x80000;
+	else
+		echo "Error: Android boot is not supported for $board_name";
+		exit;
+	fi;
+	bootm $loadaddr $ardaddr $fdtaddr;
+else
+	echo "$apart partition not found";
+	exit;
+fi;
+get_overlay_mmc=
+	fdt address ${fdtaddr};
+	fdt resize 0x100000;
+	for overlay in $name_overlays;
+	do;
+		load mmc ${bootpart} ${dtboaddr} ${bootdir}/dtb/${overlay};
+		fdt apply ${dtboaddr};
+	done;
+#if CONFIG_CMD_NET
+static_ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}::off
+nfsopts=nolock
+rootpath=/export/rootfs
+netloadimage=tftp ${loadaddr} ${bootfile}
+netloadfdt=tftp ${fdtaddr} ${fdtfile}
+netargs=setenv bootargs console=${console} ${optargs}
+	root=/dev/nfs
+	nfsroot=${serverip}:${rootpath},${nfsopts} rw
+	ip=dhcp
+netboot=echo Booting from network ...;
+	setenv autoload no;
+	dhcp;
+	run netloadimage;
+	run netloadfdt;
+	run netargs;
+	bootz ${loadaddr} - ${fdtaddr}
+#endif
+#if CONFIG_MTD_RAW_NAND
+#include <env/ti/nand.env>
+#endif
+dfu_bufsiz=0x10000
diff --git a/include/configs/am57xx_evm.h b/include/configs/am57xx_evm.h
index 266b77fbf68..8c29c940478 100644
--- a/include/configs/am57xx_evm.h
+++ b/include/configs/am57xx_evm.h
@@ -11,30 +11,13 @@
 #ifndef __CONFIG_AM57XX_EVM_H
 #define __CONFIG_AM57XX_EVM_H
 
-#include <env/ti/dfu.h>
 #include <linux/sizes.h>
 
 #define CFG_SYS_NS16550_COM1		UART1_BASE	/* Base EVM has UART0 */
 #define CFG_SYS_NS16550_COM2		UART2_BASE	/* UART2 */
 #define CFG_SYS_NS16550_COM3		UART3_BASE	/* UART3 */
 
-#ifndef CONFIG_XPL_BUILD
-#define DFUARGS \
-	"dfu_bufsiz=0x10000\0" \
-	DFU_ALT_INFO_MMC \
-	DFU_ALT_INFO_EMMC \
-	DFU_ALT_INFO_RAM \
-	DFU_ALT_INFO_QSPI
-#else
-#ifdef CONFIG_SPL_DFU
-#define DFUARGS \
-	"dfu_bufsiz=0x10000\0" \
-	DFU_ALT_INFO_RAM
-#endif
-#endif
-
-#include <configs/ti_omap5_common.h>
-
 /* CPSW Ethernet */
 
+#include <configs/ti_omap5_common.h>
 #endif /* __CONFIG_AM57XX_EVM_H */
diff --git a/include/configs/dra7xx_evm.h b/include/configs/dra7xx_evm.h
index 3c960ca2ce2..9df7ef055bf 100644
--- a/include/configs/dra7xx_evm.h
+++ b/include/configs/dra7xx_evm.h
@@ -11,40 +11,16 @@
 #ifndef __CONFIG_DRA7XX_EVM_H
 #define __CONFIG_DRA7XX_EVM_H
 
-#include <env/ti/dfu.h>
-
 #define CFG_MAX_MEM_MAPPED		0x80000000
 
 #ifndef CONFIG_QSPI_BOOT
 /* MMC ENV related defines */
 #endif
 
-#if (CONFIG_CONS_INDEX == 1)
-#define CONSOLEDEV			"ttyS0"
-#elif (CONFIG_CONS_INDEX == 3)
-#define CONSOLEDEV			"ttyS2"
-#endif
 #define CFG_SYS_NS16550_COM1		UART1_BASE	/* Base EVM has UART0 */
 #define CFG_SYS_NS16550_COM2		UART2_BASE	/* UART2 */
 #define CFG_SYS_NS16550_COM3		UART3_BASE	/* UART3 */
 
-#ifndef CONFIG_XPL_BUILD
-#define DFUARGS \
-	"dfu_bufsiz=0x10000\0" \
-	DFU_ALT_INFO_MMC \
-	DFU_ALT_INFO_EMMC \
-	DFU_ALT_INFO_RAM \
-	DFU_ALT_INFO_QSPI
-#endif
-
-#ifdef CONFIG_XPL_BUILD
-#ifdef CONFIG_SPL_DFU
-#define DFUARGS \
-	"dfu_bufsiz=0x10000\0" \
-	DFU_ALT_INFO_RAM
-#endif
-#endif
-
 #include <configs/ti_omap5_common.h>
 
 /* NAND support */
-- 
2.34.1

