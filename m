Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586E4C02199
	for <u-boot@archiver.kernel.org>; Sun,  9 Feb 2025 14:30:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 795DC80821;
	Sun,  9 Feb 2025 15:30:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="IcOwmamO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 81DA38091A; Sun,  9 Feb 2025 15:30:38 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4999F80141
 for <u-boot@lists.denx.de>; Sun,  9 Feb 2025 15:30:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-6f47ed1f40dso27371017b3.1
 for <u-boot@lists.denx.de>; Sun, 09 Feb 2025 06:30:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1739111434; x=1739716234; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=qKkSFwWf/I7sjh3eQgSgotcfLnliO2bTX+bmhG4/3FY=;
 b=IcOwmamOjhgR0UjLo375nbHyBgRmg12ZzQg0Tz/QBe8GmJS574zV7JTtyzdBpxyE8/
 xHdPGZ/gDokn37KxgX58NOXLsd9lq3q3hI5QAj1LuTWoJcTqlVM9f4mw0SO3kL8jQcH1
 hI7RMqxhvjJ8Ja3s3P9+OpOzYLJhUw1bYj9ik=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739111434; x=1739716234;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qKkSFwWf/I7sjh3eQgSgotcfLnliO2bTX+bmhG4/3FY=;
 b=DHHJ5+Tk+XCa4GOi7SAF3LLskiymy8kxbtffR2DTmSTpSTHqxTAsmPsd687t17Kut4
 JH49jirmr0BewGi+98pIJ15vHkDaLskgIHsUWrJzxTP3eeVbLBjwauqzl26mbc/ob/1L
 hljBZyVOUd9p67/XFzgfNMO/X9gmEQVTRFJYWL4gtbQkhEx/B1uComauSllkeWdTjeiJ
 ifO9TcJqGryH/HLj/4oJEou5CUGQzcV2AX8wxB/3ZEwRcGKesAoxMcZ+y9VNyuqJh7lr
 KQjUCWlJO3swNxuzyktQNRDwQCoz3WtHF1CthjNobeR1bbcijUfsXTOyvcv0JBUVSgqT
 mU/A==
X-Gm-Message-State: AOJu0YydS3GD1iPtc3mG53womv8uucDQ6ylYVjOAUwBfyExxbbNOTBGf
 J58TUG+FTo9XESApkdgJ9T6AceyNbsl/wxXJPueCa/QcNUyXJHzaEhcyW9PEaXDEqs+t1duVREt
 p
X-Gm-Gg: ASbGncv/3oMqsECAt4NdrBGgre5gxvnE97OVf4SUz23rG7rc6E9tEMFZjAhKDVwyKbY
 PRIVMT7Ivr6jOXqLp0+Ay6SN0mIs/nEg+ii0NjxKtKhuINkoY05IWKbBTpVHp79Ws7fmuszfToI
 /kZhm2jajxjmSgLmSkHrYRmY78twT9wU+IqC9ousXg6sQTWRpOSoHY83dN5KGufnDlIWCXqTtH/
 R2tEGoOsjvg5Yl0DrmR7jlTnbismJ0VniAKY7emsIrztICDJMqPspGCdlnTE9lq99Mv5ijBtvN/
 ap2jy6apHY56aIg1Sw==
X-Google-Smtp-Source: AGHT+IGn2L4uDHoMIcq88A/LMSB8BggdyoC0HNYEU3XNPDZaLyLZF1KN0phrOWRlSSGDZ7MFaGLghg==
X-Received: by 2002:a05:690c:67c8:b0:6f9:a90a:f7f2 with SMTP id
 00721157ae682-6f9b2a182a0mr79505047b3.34.1739111433681; 
 Sun, 09 Feb 2025 06:30:33 -0800 (PST)
Received: from bill-the-cat.. ([189.177.145.20])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-6f99fd17024sm12349777b3.28.2025.02.09.06.30.32
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Feb 2025 06:30:32 -0800 (PST)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] configs: Migrate CONFIG_BOOTCOUNT_ALTBOOTCMD to defconfig
Date: Sun,  9 Feb 2025 08:30:30 -0600
Message-ID: <20250209143030.2764559-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250131100845.31380-1-atheiste@seznam.cz>
References: <20250131100845.31380-1-atheiste@seznam.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Now that we have moved CONFIG_BOOTCOUNT_ALTBOOTCMD to be in Kconfig so
that it can be more easily modified in many cases, we need to move it
from environment files / config.h files and in to the defconfig file.

This was done by generating u-boot-initial-env for all platforms before
the Kconfig change, to extract altbootcmd values and then again after to
compare the result.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
When applying I will fold this in to the original commit to make sure we
don't have bisect problems.
---
 board/comvetia/lxr2/lxr2.env                |  1 -
 board/keymile/scripts/develop-common.txt    |  1 -
 board/keymile/scripts/ramfs-common.txt      |  1 -
 board/keymile/secu1/socfpga_secu.env        |  1 -
 board/storopack/smegw01/smegw01.env         | 15 ---------------
 configs/am335x_guardian_defconfig           |  1 +
 configs/bk4r1_defconfig                     |  1 +
 configs/brppt2_defconfig                    |  1 +
 configs/capricorn_cxg3_defconfig            |  1 +
 configs/display5_defconfig                  |  1 +
 configs/draco-etamin_defconfig              |  1 +
 configs/draco-rastaban_defconfig            |  1 +
 configs/draco-thuban_defconfig              |  1 +
 configs/ge_b1x5v2_defconfig                 |  1 +
 configs/ge_bx50v3_defconfig                 |  1 +
 configs/imx6q_bosch_acc_defconfig           |  1 +
 configs/imx6qdl_icore_mmc_defconfig         |  1 +
 configs/imx8mm-mx8menlo_defconfig           |  1 +
 configs/imx8mm_data_modul_edm_sbc_defconfig |  1 +
 configs/imx8mp_data_modul_edm_sbc_defconfig |  1 +
 configs/imx8mp_dhcom_drc02_defconfig        |  1 +
 configs/imx8mp_dhcom_pdk2_defconfig         |  1 +
 configs/imx8mp_dhcom_pdk3_defconfig         |  1 +
 configs/imx8mp_dhcom_picoitx_defconfig      |  1 +
 configs/kmcent2_defconfig                   |  1 +
 configs/kmcoge5ne_defconfig                 |  1 +
 configs/kmeter1_defconfig                   |  1 +
 configs/kmopti2_defconfig                   |  1 +
 configs/kmsupx5_defconfig                   |  1 +
 configs/kmtepr2_defconfig                   |  1 +
 configs/lxr2_defconfig                      |  1 +
 configs/m53menlo_defconfig                  |  1 +
 configs/mx53ppd_defconfig                   |  1 +
 configs/pg_wcom_expu1_defconfig             |  1 +
 configs/pg_wcom_expu1_update_defconfig      |  1 +
 configs/pg_wcom_seli8_defconfig             |  1 +
 configs/pg_wcom_seli8_update_defconfig      |  1 +
 configs/pxm2_defconfig                      |  1 +
 configs/rut_defconfig                       |  1 +
 configs/smegw01_defconfig                   |  1 +
 configs/socfpga_secu1_defconfig             |  1 +
 configs/stm32mp13_dhcor_defconfig           |  1 +
 configs/stm32mp15_dhcom_basic_defconfig     |  1 +
 configs/stm32mp15_dhcor_basic_defconfig     |  1 +
 configs/tuge1_defconfig                     |  1 +
 configs/tuxx1_defconfig                     |  1 +
 include/configs/am335x_guardian.h           |  5 -----
 include/configs/bk4r1.h                     |  2 --
 include/configs/brppt2.h                    |  1 -
 include/configs/display5.h                  |  1 -
 include/configs/ge_b1x5v2.h                 |  8 --------
 include/configs/ge_bx50v3.h                 |  8 --------
 include/configs/imx6-engicam.h              |  1 -
 include/configs/imx6q-bosch-acc.h           |  3 +--
 include/configs/imx8mm-mx8menlo.h           |  8 --------
 include/configs/imx8mm_data_modul_edm_sbc.h |  1 -
 include/configs/imx8mp_data_modul_edm_sbc.h |  1 -
 include/configs/imx8mp_dhcom_pdk2.h         |  1 -
 include/configs/m53menlo.h                  |  7 -------
 include/configs/mx53ppd.h                   |  8 --------
 include/configs/siemens-am33x-common.h      |  1 -
 include/configs/siemens-env-common.h        |  1 -
 include/configs/snapper9g45.h               |  3 +--
 include/env/pg-wcom/common.env              |  1 -
 64 files changed, 43 insertions(+), 78 deletions(-)

diff --git a/board/comvetia/lxr2/lxr2.env b/board/comvetia/lxr2/lxr2.env
index ec213800222d..26ad4f18c684 100644
--- a/board/comvetia/lxr2/lxr2.env
+++ b/board/comvetia/lxr2/lxr2.env
@@ -2,7 +2,6 @@ addcons=setenv bootargs ${bootargs} console=${console},${baudrate}
 addip=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${netmask}:${hostname}:${netdev}:off
 addmisc=setenv bootargs ${bootargs} ${miscargs}
 addmtd=run mtdnand;run mtdspi;setenv bootargs ${bootargs} ${mtdparts}
-altbootcmd=run swupdate
 bootcmd=run nandboot;run swupdate
 bootcount=2
 bootlimit=3
diff --git a/board/keymile/scripts/develop-common.txt b/board/keymile/scripts/develop-common.txt
index 1bdff2f908f8..cfc69357e43e 100644
--- a/board/keymile/scripts/develop-common.txt
+++ b/board/keymile/scripts/develop-common.txt
@@ -1,4 +1,3 @@
-altbootcmd=run ${subbootcmds}
 bootcmd=run ${subbootcmds}
 configure=run set_uimage; run set_tftppath; km_setboardid && run try_import_nfs_path && saveenv && reset
 subbootcmds=tftpfdt tftpkernel nfsargs add_default boot
diff --git a/board/keymile/scripts/ramfs-common.txt b/board/keymile/scripts/ramfs-common.txt
index 0a4a9c80b7e3..c86e6267bdc4 100644
--- a/board/keymile/scripts/ramfs-common.txt
+++ b/board/keymile/scripts/ramfs-common.txt
@@ -1,6 +1,5 @@
 addramfs=setenv bootargs "${bootargs} phram.phram=rootfs${boot_bank},${rootfsaddr},${rootfssize}"
 boot_bank=-1
-altbootcmd=run ${subbootcmds}
 bootcmd=run ${subbootcmds}
 subbootcmds=save_and_reset_once tftpfdt tftpkernel setrootfsaddr tftpramfs flashargs add_default addpanic addramfs boot
 save_and_reset_once=setenv save_and_reset_once true && saveenv && reset
diff --git a/board/keymile/secu1/socfpga_secu.env b/board/keymile/secu1/socfpga_secu.env
index 147c4170ef54..609998829589 100644
--- a/board/keymile/secu1/socfpga_secu.env
+++ b/board/keymile/secu1/socfpga_secu.env
@@ -1,4 +1,3 @@
-altbootcmd=run bootcmd;
 bootlimit=6
 bootnum=1
 bootretry=CONFIG_BOOT_RETRY_TIME
diff --git a/board/storopack/smegw01/smegw01.env b/board/storopack/smegw01/smegw01.env
index 93de8669109d..c0d408e4a206 100644
--- a/board/storopack/smegw01/smegw01.env
+++ b/board/storopack/smegw01/smegw01.env
@@ -12,21 +12,6 @@
 			setenv bootmenu_${emmc_priority} eMMC=run boot_emmc; \
 			setenv bootmenu_${sd_priority} SD=run boot_sd;
 #endif
-
-altbootcmd=
-	echo Performing rollback...;
-	if test "${mmcpart_committed}" = 1; then
-		setenv mmcpart 2;
-		setenv mmcpart_committed 2;
-	else
-		setenv mmcpart 1;
-		setenv mmcpart_committed 1;
-	fi;
-	setenv bootcount 0;
-	setenv upgrade_available;
-	setenv ustate 3;
-	saveenv;
-	run bootcmd;
 boot_emmc=setenv mmcdev_wanted 1; run persist_mmcdev; run bootcmd;
 boot_sd=setenv mmcdev_wanted 0; run persist_mmcdev; run bootcmd;
 bootcmd=
diff --git a/configs/am335x_guardian_defconfig b/configs/am335x_guardian_defconfig
index 4059d07b5c8f..c550e5e121eb 100644
--- a/configs/am335x_guardian_defconfig
+++ b/configs/am335x_guardian_defconfig
@@ -77,6 +77,7 @@ CONFIG_SPL_DM=y
 CONFIG_REGMAP=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_AM33XX_NVMEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="setenv boot_syslinux_conf \"extlinux/extlinux-rollback.conf\"; run distro_bootcmd; setenv boot_syslinux_conf \"extlinux/extlinux.conf\"; run bootcmd_ubifs0;"
 CONFIG_CLK=y
 CONFIG_CLK_CCF=y
 CONFIG_CLK_TI_AM3_DPLL=y
diff --git a/configs/bk4r1_defconfig b/configs/bk4r1_defconfig
index 3ed587a10603..2b72ec916327 100644
--- a/configs/bk4r1_defconfig
+++ b/configs/bk4r1_defconfig
@@ -59,6 +59,7 @@ CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_ARP_TIMEOUT=500
 CONFIG_NETCONSOLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="led 5 on; boot"
 CONFIG_VYBRID_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/brppt2_defconfig b/configs/brppt2_defconfig
index f02aef240486..d468465a9ccb 100644
--- a/configs/brppt2_defconfig
+++ b/configs/brppt2_defconfig
@@ -76,6 +76,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 # CONFIG_OF_TRANSLATE is not set
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="setenv b_mode 0; run b_default;"
 CONFIG_SYS_I2C_MXC=y
 CONFIG_MMC_BROKEN_CD=y
 # CONFIG_SPL_DM_MMC is not set
diff --git a/configs/capricorn_cxg3_defconfig b/configs/capricorn_cxg3_defconfig
index 4832a795e50f..10e0cbd9ad28 100644
--- a/configs/capricorn_cxg3_defconfig
+++ b/configs/capricorn_cxg3_defconfig
@@ -95,6 +95,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_SPL_DM=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SPL_CLK=y
 CONFIG_CLK_IMX8=y
 CONFIG_CPU=y
diff --git a/configs/display5_defconfig b/configs/display5_defconfig
index 765920bd5d18..55f9bbaa1cf8 100644
--- a/configs/display5_defconfig
+++ b/configs/display5_defconfig
@@ -96,6 +96,7 @@ CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run recovery"
 CONFIG_SPL_SYS_I2C_LEGACY=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
 CONFIG_I2C_DEFAULT_BUS_NUMBER=0x2
diff --git a/configs/draco-etamin_defconfig b/configs/draco-etamin_defconfig
index f650dbca660f..6c175dd73b9d 100644
--- a/configs/draco-etamin_defconfig
+++ b/configs/draco-etamin_defconfig
@@ -79,6 +79,7 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_CLK=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
diff --git a/configs/draco-rastaban_defconfig b/configs/draco-rastaban_defconfig
index 511956ec8449..521a090e376d 100644
--- a/configs/draco-rastaban_defconfig
+++ b/configs/draco-rastaban_defconfig
@@ -76,6 +76,7 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_CLK=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
diff --git a/configs/draco-thuban_defconfig b/configs/draco-thuban_defconfig
index 1b2ce3b01045..2c16db237f86 100644
--- a/configs/draco-thuban_defconfig
+++ b/configs/draco-thuban_defconfig
@@ -76,6 +76,7 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_CLK=y
 CONFIG_CLK_TI_CTRL=y
 CONFIG_DFU_NAND=y
diff --git a/configs/ge_b1x5v2_defconfig b/configs/ge_b1x5v2_defconfig
index 215858c789b0..fec4b67aee22 100644
--- a/configs/ge_b1x5v2_defconfig
+++ b/configs/ge_b1x5v2_defconfig
@@ -78,6 +78,7 @@ CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_DM_BOOTCOUNT_SPI_FLASH=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="setenv mmcpart 1; run hasfirstboot || setenv mmcpart 2; run hasfirstboot || setenv mmcpart 0; if test ${mmcpart} != 0; then setenv bootcause REVERT; run swappartitions loadimage doboot; fi; run failbootcmd"
 CONFIG_DM_PCA953X=y
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/ge_bx50v3_defconfig b/configs/ge_bx50v3_defconfig
index c24513f6ab1f..676b5bc8a28e 100644
--- a/configs/ge_bx50v3_defconfig
+++ b/configs/ge_bx50v3_defconfig
@@ -52,6 +52,7 @@ CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run doquiet; setenv partnum 1; run hasfirstboot || setenv partnum 2; run hasfirstboot || setenv partnum 0; if test ${partnum} != 0; then run swappartitions loadimage doboot; fi; run failbootcmd"
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_I2C_MUX=y
diff --git a/configs/imx6q_bosch_acc_defconfig b/configs/imx6q_bosch_acc_defconfig
index 54758df8c015..017c27479d2c 100644
--- a/configs/imx6q_bosch_acc_defconfig
+++ b/configs/imx6q_bosch_acc_defconfig
@@ -86,6 +86,7 @@ CONFIG_SPL_DM=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_DM_BOOTCOUNT_PMIC_PFUZE100=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run handle_ustate; run switch_bootset; run save_env; run bootcmd"
 CONFIG_SYS_I2C_MXC=y
 CONFIG_SUPPORT_EMMC_BOOT=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx6qdl_icore_mmc_defconfig b/configs/imx6qdl_icore_mmc_defconfig
index fb0787d1beb2..269fe271a760 100644
--- a/configs/imx6qdl_icore_mmc_defconfig
+++ b/configs/imx6qdl_icore_mmc_defconfig
@@ -72,6 +72,7 @@ CONFIG_ENV_IS_IN_MMC=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run recoveryboot"
 CONFIG_SYS_BOOTCOUNT_MAGIC=0x0B01C041
 CONFIG_SYS_I2C_MXC=y
 CONFIG_FSL_USDHC=y
diff --git a/configs/imx8mm-mx8menlo_defconfig b/configs/imx8mm-mx8menlo_defconfig
index ae9595e82b48..ad310750c77c 100644
--- a/configs/imx8mm-mx8menlo_defconfig
+++ b/configs/imx8mm-mx8menlo_defconfig
@@ -102,6 +102,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_TFTP_BLOCKSIZE=4096
 CONFIG_SPL_DM=y
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="mmc partconf 0 mmcpart ; if test ${mmcpart} -eq 1 ; then mmc partconf 0 1 2 0 ; else mmc partconf 0 1 1 0 ; fi ; boot"
 CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C40000
 CONFIG_SPL_CLK_COMPOSITE_CCF=y
 CONFIG_CLK_COMPOSITE_CCF=y
diff --git a/configs/imx8mm_data_modul_edm_sbc_defconfig b/configs/imx8mm_data_modul_edm_sbc_defconfig
index 66cb1331ded0..debaa7cb5aa2 100644
--- a/configs/imx8mm_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mm_data_modul_edm_sbc_defconfig
@@ -37,3 +37,4 @@ CONFIG_SPL_USB_GADGET=y
 CONFIG_SPL_USB_HOST=y
 CONFIG_SPL_USB_SDP_SUPPORT=y
 CONFIG_SYS_LOAD_ADDR=0x60000000
+CONFIG_BOOTCOUNT_ALTBOOTCMD=run bootcmd
diff --git a/configs/imx8mp_data_modul_edm_sbc_defconfig b/configs/imx8mp_data_modul_edm_sbc_defconfig
index ea8109bf0496..5024c093b99d 100644
--- a/configs/imx8mp_data_modul_edm_sbc_defconfig
+++ b/configs/imx8mp_data_modul_edm_sbc_defconfig
@@ -52,3 +52,4 @@ CONFIG_USB_HOST_ETHER=y
 CONFIG_USB_XHCI_DWC3=y
 CONFIG_USB_XHCI_DWC3_OF_SIMPLE=y
 CONFIG_USB_XHCI_HCD=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
diff --git a/configs/imx8mp_dhcom_drc02_defconfig b/configs/imx8mp_dhcom_drc02_defconfig
index c43839cecf53..dccf5ffc1e6e 100644
--- a/configs/imx8mp_dhcom_drc02_defconfig
+++ b/configs/imx8mp_dhcom_drc02_defconfig
@@ -5,3 +5,4 @@ CONFIG_ARCH_IMX8M=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-drc02"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-drc02.dtb"
 CONFIG_PREBOOT=""
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/imx8mp_dhcom_pdk2_defconfig b/configs/imx8mp_dhcom_pdk2_defconfig
index aae2e210f44f..4f50806573ba 100644
--- a/configs/imx8mp_dhcom_pdk2_defconfig
+++ b/configs/imx8mp_dhcom_pdk2_defconfig
@@ -7,3 +7,4 @@ CONFIG_DEFAULT_FDT_FILE="freescale/imx8mp-dhcom-pdk2.dtb"
 CONFIG_PREBOOT=""
 CONFIG_OF_UPSTREAM=y
 CONFIG_OF_UPSTREAM_INCLUDE_LOCAL_FALLBACK_DTBOS=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/imx8mp_dhcom_pdk3_defconfig b/configs/imx8mp_dhcom_pdk3_defconfig
index f40bf269d978..d505ddfd09d9 100644
--- a/configs/imx8mp_dhcom_pdk3_defconfig
+++ b/configs/imx8mp_dhcom_pdk3_defconfig
@@ -14,3 +14,4 @@ CONFIG_PCIE_DW_IMX=y
 CONFIG_PHY_IMX8M_PCIE=y
 CONFIG_I2C_MUX=y
 CONFIG_I2C_MUX_PCA954x=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/imx8mp_dhcom_picoitx_defconfig b/configs/imx8mp_dhcom_picoitx_defconfig
index 99cd5f279dcb..d98ca9e434f6 100644
--- a/configs/imx8mp_dhcom_picoitx_defconfig
+++ b/configs/imx8mp_dhcom_picoitx_defconfig
@@ -5,3 +5,4 @@ CONFIG_ARCH_IMX8M=y
 CONFIG_DEFAULT_DEVICE_TREE="imx8mp-dhcom-picoitx"
 CONFIG_DEFAULT_FDT_FILE="imx8mp-dhcom-picoitx.dtb"
 CONFIG_PREBOOT=""
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd ; reset"
diff --git a/configs/kmcent2_defconfig b/configs/kmcent2_defconfig
index 4e37df2e6144..76e98c9b2a44 100644
--- a/configs/kmcent2_defconfig
+++ b/configs/kmcent2_defconfig
@@ -60,6 +60,7 @@ CONFIG_ENV_ADDR_REDUND=0xebf00000
 CONFIG_USE_ETHPRIME=y
 CONFIG_ETHPRIME="fm1-mac5"
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_FSL_CAAM=y
 CONFIG_DDR_CLK_FREQ=66666666
diff --git a/configs/kmcoge5ne_defconfig b/configs/kmcoge5ne_defconfig
index 6b2fc2ec6e75..cf50e2d27d85 100644
--- a/configs/kmcoge5ne_defconfig
+++ b/configs/kmcoge5ne_defconfig
@@ -166,6 +166,7 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_BOOTCOUNT_MEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xF0001001
diff --git a/configs/kmeter1_defconfig b/configs/kmeter1_defconfig
index 55e87b0215af..7638fc2f5cf6 100644
--- a/configs/kmeter1_defconfig
+++ b/configs/kmeter1_defconfig
@@ -145,6 +145,7 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_BOOTCOUNT_MEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xF0001001
diff --git a/configs/kmopti2_defconfig b/configs/kmopti2_defconfig
index df419b01c68c..1c750455fc66 100644
--- a/configs/kmopti2_defconfig
+++ b/configs/kmopti2_defconfig
@@ -152,6 +152,7 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_BOOTCOUNT_MEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xF0001001
 CONFIG_SYS_OR0_PRELIM=0xF0000E55
diff --git a/configs/kmsupx5_defconfig b/configs/kmsupx5_defconfig
index 1436860f1ccb..5dd98175cd3a 100644
--- a/configs/kmsupx5_defconfig
+++ b/configs/kmsupx5_defconfig
@@ -137,6 +137,7 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_BOOTCOUNT_MEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xF0001001
diff --git a/configs/kmtepr2_defconfig b/configs/kmtepr2_defconfig
index cce7a044aee9..2b240b3380da 100644
--- a/configs/kmtepr2_defconfig
+++ b/configs/kmtepr2_defconfig
@@ -151,6 +151,7 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_BOOTCOUNT_MEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xF0001001
 CONFIG_SYS_OR0_PRELIM=0xF0000E55
diff --git a/configs/lxr2_defconfig b/configs/lxr2_defconfig
index 7ab817960a2c..b41a6ed93fd6 100644
--- a/configs/lxr2_defconfig
+++ b/configs/lxr2_defconfig
@@ -77,6 +77,7 @@ CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
 CONFIG_ARP_TIMEOUT=200
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run swupdate"
 CONFIG_SYS_BOOTCOUNT_MAGIC=0xB0C4000
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DM_I2C=y
diff --git a/configs/m53menlo_defconfig b/configs/m53menlo_defconfig
index 6130cd8e466a..ccd1cb7475b1 100644
--- a/configs/m53menlo_defconfig
+++ b/configs/m53menlo_defconfig
@@ -79,6 +79,7 @@ CONFIG_USE_HOSTNAME=y
 CONFIG_HOSTNAME="m53menlo"
 CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="if test ${mmcpart} -eq 1 ; then setenv mmcpart 2 ; else setenv mmcpart 1 ; fi ; boot"
 CONFIG_SYS_BOOTCOUNT_MAGIC=0x0B01C041
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
diff --git a/configs/mx53ppd_defconfig b/configs/mx53ppd_defconfig
index d91c59ffe466..4ec8516015f9 100644
--- a/configs/mx53ppd_defconfig
+++ b/configs/mx53ppd_defconfig
@@ -47,6 +47,7 @@ CONFIG_ARP_TIMEOUT=200
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_DM_BOOTCOUNT_I2C_EEPROM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run doquiet; setenv partnum 1; run hasfirstboot || setenv partnum 2; run hasfirstboot || setenv partnum 0; if test ${partnum} != 0; then run swappartitions loadimage doboot; fi; run failbootcmd"
 CONFIG_DM_I2C=y
 CONFIG_SYS_I2C_MXC=y
 CONFIG_I2C_MUX=y
diff --git a/configs/pg_wcom_expu1_defconfig b/configs/pg_wcom_expu1_defconfig
index 1120191585ce..4b82b077ea7d 100644
--- a/configs/pg_wcom_expu1_defconfig
+++ b/configs/pg_wcom_expu1_defconfig
@@ -73,6 +73,7 @@ CONFIG_HOSTNAME="EXPU1"
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_SCSI_AHCI is not set
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
diff --git a/configs/pg_wcom_expu1_update_defconfig b/configs/pg_wcom_expu1_update_defconfig
index 772aa210fc21..53d547896879 100644
--- a/configs/pg_wcom_expu1_update_defconfig
+++ b/configs/pg_wcom_expu1_update_defconfig
@@ -71,6 +71,7 @@ CONFIG_HOSTNAME="EXPU1"
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_SCSI_AHCI is not set
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
diff --git a/configs/pg_wcom_seli8_defconfig b/configs/pg_wcom_seli8_defconfig
index 6cde217a34c4..731ca4350897 100644
--- a/configs/pg_wcom_seli8_defconfig
+++ b/configs/pg_wcom_seli8_defconfig
@@ -73,6 +73,7 @@ CONFIG_HOSTNAME="SELI8"
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_SCSI_AHCI is not set
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
diff --git a/configs/pg_wcom_seli8_update_defconfig b/configs/pg_wcom_seli8_update_defconfig
index e8afc95d6076..2598e477ed5e 100644
--- a/configs/pg_wcom_seli8_update_defconfig
+++ b/configs/pg_wcom_seli8_update_defconfig
@@ -71,6 +71,7 @@ CONFIG_HOSTNAME="SELI8"
 CONFIG_VERSION_VARIABLE=y
 # CONFIG_SCSI_AHCI is not set
 CONFIG_BOOTCOUNT_LIMIT=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_DDR_CLK_FREQ=50000000
 CONFIG_SYS_FSL_DDR3=y
diff --git a/configs/pxm2_defconfig b/configs/pxm2_defconfig
index 162b1f1c748d..fd2727e48d75 100644
--- a/configs/pxm2_defconfig
+++ b/configs/pxm2_defconfig
@@ -85,6 +85,7 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_DM_I2C=y
diff --git a/configs/rut_defconfig b/configs/rut_defconfig
index dd8df542aa38..b2930e8044d6 100644
--- a/configs/rut_defconfig
+++ b/configs/rut_defconfig
@@ -86,6 +86,7 @@ CONFIG_SPL_DM=y
 # CONFIG_SPL_BLK is not set
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_DFU_NAND=y
 CONFIG_SYS_DFU_DATA_BUF_SIZE=0x100000
 CONFIG_DM_I2C=y
diff --git a/configs/smegw01_defconfig b/configs/smegw01_defconfig
index 6dc95e551e34..ae6c9b60cd57 100644
--- a/configs/smegw01_defconfig
+++ b/configs/smegw01_defconfig
@@ -60,6 +60,7 @@ CONFIG_NET_RANDOM_ETHADDR=y
 CONFIG_BOUNCE_BUFFER=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTCOUNT_ENV=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="echo Performing rollback...; if test \"${mmcpart_committed}\" = 1; then setenv mmcpart 2; setenv mmcpart_committed 2; else setenv mmcpart 1; setenv mmcpart_committed 1; fi; setenv bootcount 0; setenv upgrade_available; setenv ustate 3; saveenv; run bootcmd;"
 CONFIG_DFU_MMC=y
 CONFIG_DM_I2C=y
 CONFIG_SUPPORT_EMMC_BOOT=y
diff --git a/configs/socfpga_secu1_defconfig b/configs/socfpga_secu1_defconfig
index dc6d66ade239..84badec60aaf 100644
--- a/configs/socfpga_secu1_defconfig
+++ b/configs/socfpga_secu1_defconfig
@@ -74,6 +74,7 @@ CONFIG_SPL_DM_SEQ_ALIAS=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_DM_BOOTCOUNT_RTC=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd;"
 CONFIG_DWAPB_GPIO=y
 CONFIG_DM_I2C=y
 CONFIG_I2C_SET_DEFAULT_BUS_NUM=y
diff --git a/configs/stm32mp13_dhcor_defconfig b/configs/stm32mp13_dhcor_defconfig
index ff948b904bee..4dc3954128db 100644
--- a/configs/stm32mp13_dhcor_defconfig
+++ b/configs/stm32mp13_dhcor_defconfig
@@ -44,3 +44,4 @@ CONFIG_OPTEE=y
 CONFIG_USB_ONBOARD_HUB=y
 CONFIG_USB_HUB_DEBOUNCE_TIMEOUT=2000
 CONFIG_ERRNO_STR=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="
diff --git a/configs/stm32mp15_dhcom_basic_defconfig b/configs/stm32mp15_dhcom_basic_defconfig
index a28f28620487..f89c921925d9 100644
--- a/configs/stm32mp15_dhcom_basic_defconfig
+++ b/configs/stm32mp15_dhcom_basic_defconfig
@@ -8,3 +8,4 @@ CONFIG_SYS_MEMTEST_END=0xc4000000
 CONFIG_SYS_I2C_EEPROM_BUS=3
 CONFIG_OF_LIST="st/stm32mp157c-dhcom-pdk2 st/stm32mp153c-dhcom-drc02 st/stm32mp157c-dhcom-picoitx"
 CONFIG_SYS_I2C_EEPROM_ADDR=0x50
+CONFIG_BOOTCOUNT_ALTBOOTCMD="
diff --git a/configs/stm32mp15_dhcor_basic_defconfig b/configs/stm32mp15_dhcor_basic_defconfig
index f6f2af6e7a2b..bde668761b32 100644
--- a/configs/stm32mp15_dhcor_basic_defconfig
+++ b/configs/stm32mp15_dhcor_basic_defconfig
@@ -8,3 +8,4 @@ CONFIG_OF_LIST="st/stm32mp157a-dhcor-avenger96 st/stm32mp151a-dhcor-testbench st
 CONFIG_SYS_I2C_EEPROM_ADDR=0x53
 CONFIG_PHY_MICREL=y
 CONFIG_PHY_MICREL_KSZ90X1=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="
diff --git a/configs/tuge1_defconfig b/configs/tuge1_defconfig
index d1b771993cf5..ab0fd12bc482 100644
--- a/configs/tuge1_defconfig
+++ b/configs/tuge1_defconfig
@@ -137,6 +137,7 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_BOOTCOUNT_MEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BOOTCOUNT_BE=y
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xF0001001
diff --git a/configs/tuxx1_defconfig b/configs/tuxx1_defconfig
index 1dc737e4954d..e5a99b24dab9 100644
--- a/configs/tuxx1_defconfig
+++ b/configs/tuxx1_defconfig
@@ -151,6 +151,7 @@ CONFIG_VERSION_VARIABLE=y
 CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_DM_BOOTCOUNT=y
 CONFIG_BOOTCOUNT_MEM=y
+CONFIG_BOOTCOUNT_ALTBOOTCMD="run bootcmd"
 CONFIG_SYS_BR0_PRELIM_BOOL=y
 CONFIG_SYS_BR0_PRELIM=0xF0001001
 CONFIG_SYS_OR0_PRELIM=0xF0000E55
diff --git a/include/configs/am335x_guardian.h b/include/configs/am335x_guardian.h
index 96efd38594a0..385dec2ff4f7 100644
--- a/include/configs/am335x_guardian.h
+++ b/include/configs/am335x_guardian.h
@@ -63,11 +63,6 @@
 		  "fi; " \
 		  "setenv extrabootargs $extrabootargs \"swi_attached\"; " \
 		"fi;" \
-		"run bootcmd_ubifs0;\0" \
-	"altbootcmd=" \
-		"setenv boot_syslinux_conf \"extlinux/extlinux-rollback.conf\"; " \
-		"run distro_bootcmd; " \
-		"setenv boot_syslinux_conf \"extlinux/extlinux.conf\"; " \
 		"run bootcmd_ubifs0;\0"
 
 #endif /* ! CONFIG_XPL_BUILD */
diff --git a/include/configs/bk4r1.h b/include/configs/bk4r1.h
index 5df8d03c7065..6d24c5decd5b 100644
--- a/include/configs/bk4r1.h
+++ b/include/configs/bk4r1.h
@@ -16,8 +16,6 @@
 #define BK4_EXTRA_ENV_SETTINGS \
 	"bootlimit=3\0" \
 	"eraseuserdata=false\0" \
-	"altbootcmd=led 5 on; " \
-		"boot\0" \
 	"set_gpio103=mw 0x400ff0c4 0x0080; mw 0x4004819C 0x000011bf\0" \
 	"set_gpio102=mw 0x400ff0c4 0x40; mw 0x40048198 0x000011bf\0" \
 	"set_gpio96=mw 0x40048180 0x282; mw 0x400ff0c4 0x1\0"\
diff --git a/include/configs/brppt2.h b/include/configs/brppt2.h
index d01f0d373163..93559a171ae9 100644
--- a/include/configs/brppt2.h
+++ b/include/configs/brppt2.h
@@ -64,7 +64,6 @@ BUR_COMMON_ENV \
 " do echo \"### booting ${target} ###\"; run b_${target};" \
 " if test ${b_break} = 1; then; exit; fi; done\0" \
 "loaddev=mmc 0\0" \
-"altbootcmd=setenv b_mode 0; run b_default;\0" \
 "bootlimit=1\0" \
 "net2nor=sf probe && dhcp &&" \
 " tftp ${loadaddr} SPL && sf erase 0 +${filesize} &&" \
diff --git a/include/configs/display5.h b/include/configs/display5.h
index 51fa2b03a2e6..98b1e5af2c08 100644
--- a/include/configs/display5.h
+++ b/include/configs/display5.h
@@ -170,7 +170,6 @@
 	"display=tianma-tm070-800x480\0" \
 	"board=display5\0" \
 	"mmcdev=0\0" \
-	"altbootcmd=run recovery\0" \
 	"bootdelay=1\0" \
 	"baudrate=115200\0" \
 	"ethact=FEC\0" \
diff --git a/include/configs/ge_b1x5v2.h b/include/configs/ge_b1x5v2.h
index f3d85c9c11e8..5e3f67124c05 100644
--- a/include/configs/ge_b1x5v2.h
+++ b/include/configs/ge_b1x5v2.h
@@ -82,14 +82,6 @@
 	"doboot=" \
 		"echo Booting from mmc:${mmcdev}:${mmcpart} ...; " \
 		"run helix;\0" \
-	"altbootcmd=" \
-		"setenv mmcpart 1; run hasfirstboot || setenv mmcpart 2; " \
-		"run hasfirstboot || setenv mmcpart 0; " \
-		"if test ${mmcpart} != 0; then " \
-			"setenv bootcause REVERT; " \
-			"run swappartitions loadimage doboot; " \
-		"fi; " \
-		"run failbootcmd\0" \
 	"tryboot=" \
 		"setenv mmcpart 1; run hasfirstboot || setenv mmcpart 2; " \
 		"run loadimage || run swappartitions && run loadimage || " \
diff --git a/include/configs/ge_bx50v3.h b/include/configs/ge_bx50v3.h
index 07b36706e56d..c8ef048bd43c 100644
--- a/include/configs/ge_bx50v3.h
+++ b/include/configs/ge_bx50v3.h
@@ -67,14 +67,6 @@
 		"Try again, or contact GE Service for support.\"; " \
 		"bootcount reset; " \
 		"while true; do sleep 1; done; \0" \
-	"altbootcmd=" \
-		"run doquiet; " \
-		"setenv partnum 1; run hasfirstboot || setenv partnum 2; " \
-		"run hasfirstboot || setenv partnum 0; " \
-		"if test ${partnum} != 0; then " \
-			"run swappartitions loadimage doboot; " \
-		"fi; " \
-		"run failbootcmd\0" \
 	"loadimage=" \
 		"ext2load ${dev} ${devnum}:${partnum} ${loadaddr} ${image}\0" \
 	"doboot=" \
diff --git a/include/configs/imx6-engicam.h b/include/configs/imx6-engicam.h
index 786b70fe064d..3d5701c636c8 100644
--- a/include/configs/imx6-engicam.h
+++ b/include/configs/imx6-engicam.h
@@ -47,7 +47,6 @@
 	"loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}\0" \
 	"loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr} ${fdt_file}\0" \
 	"loadfit=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${fit_image}\0" \
-	"altbootcmd=run recoveryboot\0"\
 	"fitboot=echo Booting FIT image from mmc ...; " \
 		"run mmcargs; " \
 		"bootm ${loadaddr}\0" \
diff --git a/include/configs/imx6q-bosch-acc.h b/include/configs/imx6q-bosch-acc.h
index 64ddbf711d31..84da8250684a 100644
--- a/include/configs/imx6q-bosch-acc.h
+++ b/include/configs/imx6q-bosch-acc.h
@@ -42,8 +42,7 @@
 	"env_persisted=0\0" \
 	"env_persist=if test ${env_persisted} != 1; " \
 		"then env set env_persisted 1; run save_env; fi;\0" \
-	"save_env=env save; env save\0" \
-	"altbootcmd=run handle_ustate; run switch_bootset; run save_env; run bootcmd\0"
+	"save_env=env save; env save\0"
 
 #define CFG_ENV_FLAGS_LIST_STATIC \
 	"bootset:bw," \
diff --git a/include/configs/imx8mm-mx8menlo.h b/include/configs/imx8mm-mx8menlo.h
index 7058d632d674..626ccae72057 100644
--- a/include/configs/imx8mm-mx8menlo.h
+++ b/include/configs/imx8mm-mx8menlo.h
@@ -18,14 +18,6 @@
 	"devtype=mmc\0"							\
 	"devnum=1\0"							\
 	"distro_bootpart=1\0"						\
-	"altbootcmd="							\
-		"mmc partconf 0 mmcpart ; "				\
-		"if test ${mmcpart} -eq 1 ; then "			\
-			"mmc partconf 0 1 2 0 ; "			\
-		"else "							\
-			"mmc partconf 0 1 1 0 ; "			\
-		"fi ; "							\
-		"boot\0"						\
 	"boot_file=fitImage\0"						\
 	"console=ttymxc0\0"						\
 	"fdt_addr=0x43000000\0"						\
diff --git a/include/configs/imx8mm_data_modul_edm_sbc.h b/include/configs/imx8mm_data_modul_edm_sbc.h
index 57ecb5e21907..5ce4219912f3 100644
--- a/include/configs/imx8mm_data_modul_edm_sbc.h
+++ b/include/configs/imx8mm_data_modul_edm_sbc.h
@@ -34,7 +34,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 #define CFG_EXTRA_ENV_SETTINGS						\
-	"altbootcmd=run bootcmd\0"					\
 	"bootlimit=3\0"							\
 	"devtype=mmc\0"							\
 	"devpart=1\0"							\
diff --git a/include/configs/imx8mp_data_modul_edm_sbc.h b/include/configs/imx8mp_data_modul_edm_sbc.h
index de5bdd30e18d..58a03b35ac4f 100644
--- a/include/configs/imx8mp_data_modul_edm_sbc.h
+++ b/include/configs/imx8mp_data_modul_edm_sbc.h
@@ -24,7 +24,6 @@
 #define FEC_QUIRK_ENET_MAC
 
 #define CFG_EXTRA_ENV_SETTINGS						\
-	"altbootcmd=run bootcmd\0"					\
 	"bootlimit=3\0"							\
 	"devtype=mmc\0"							\
 	"devpart=1\0"							\
diff --git a/include/configs/imx8mp_dhcom_pdk2.h b/include/configs/imx8mp_dhcom_pdk2.h
index c848fce8bdac..f3e239d780f7 100644
--- a/include/configs/imx8mp_dhcom_pdk2.h
+++ b/include/configs/imx8mp_dhcom_pdk2.h
@@ -28,7 +28,6 @@
 #define CFG_SYS_FSL_ESDHC_ADDR	0
 
 #define CFG_EXTRA_ENV_SETTINGS						\
-	"altbootcmd=run bootcmd ; reset\0"				\
 	"bootlimit=3\0"							\
 	"dfu_alt_info="							\
 		/* RAM block at DRAM offset 256..768 MiB */		\
diff --git a/include/configs/m53menlo.h b/include/configs/m53menlo.h
index 1ea4fa59fd53..a6aafb518542 100644
--- a/include/configs/m53menlo.h
+++ b/include/configs/m53menlo.h
@@ -93,13 +93,6 @@
 	"splashfile=boot/usplash.bmp.gz\0"				\
 	"splashimage=0x88000000\0"					\
 	"splashpos=m,m\0"						\
-	"altbootcmd="							\
-		"if test ${mmcpart} -eq 1 ; then "			\
-			"setenv mmcpart 2 ; "				\
-		"else "							\
-			"setenv mmcpart 1 ; "				\
-		"fi ; "							\
-		"boot\0"						\
 	"stdout=serial,vidconsole\0"					\
 	"stderr=serial,vidconsole\0"					\
 	"addcons="							\
diff --git a/include/configs/mx53ppd.h b/include/configs/mx53ppd.h
index 6d1f669de501..3707de254e14 100644
--- a/include/configs/mx53ppd.h
+++ b/include/configs/mx53ppd.h
@@ -59,14 +59,6 @@
 		"Try again, or contact GE Service for support.\"; " \
 		"bootcount reset; " \
 		"while true; do sleep 1; done; \0" \
-	"altbootcmd=" \
-		"run doquiet; " \
-		"setenv partnum 1; run hasfirstboot || setenv partnum 2; " \
-		"run hasfirstboot || setenv partnum 0; " \
-		"if test ${partnum} != 0; then " \
-			"run swappartitions loadimage doboot; " \
-		"fi; " \
-		"run failbootcmd\0" \
 	"loadimage=" \
 		"ext2load ${dev} ${devnum}:${partnum} ${loadaddr} ${image}\0" \
 	"doboot=" \
diff --git a/include/configs/siemens-am33x-common.h b/include/configs/siemens-am33x-common.h
index 74b7fe85800f..a918dc1350c4 100644
--- a/include/configs/siemens-am33x-common.h
+++ b/include/configs/siemens-am33x-common.h
@@ -128,7 +128,6 @@
 	"verify=no \0" \
 	"project_dir=targetdir\0" \
 	"upgrade_available=0\0" \
-	"altbootcmd=run bootcmd\0" \
 	"partitionset_active=A\0" \
 	"loadaddr=0x82000000\0" \
 	"kloadaddr=0x81000000\0" \
diff --git a/include/configs/siemens-env-common.h b/include/configs/siemens-env-common.h
index 36fa5d936f70..c028823e1ebd 100644
--- a/include/configs/siemens-env-common.h
+++ b/include/configs/siemens-env-common.h
@@ -183,7 +183,6 @@
 	"rootfs_name=/dev/mmcblk0\0" \
 	"upgrade_available=0\0" \
 	"bootlimit=3\0" \
-	"altbootcmd=run bootcmd\0" \
 	"optargs=\0" \
 
 /**********************************************************************/
diff --git a/include/configs/snapper9g45.h b/include/configs/snapper9g45.h
index df8ed451a43a..8ea708d0e92b 100644
--- a/include/configs/snapper9g45.h
+++ b/include/configs/snapper9g45.h
@@ -58,8 +58,7 @@
 	"boot_tftp=setenv bootargs $bootargs_def ip=any nfsroot=$nfsroot; setenv autoload y && bootp && bootm\0" \
 	"boot_usb=setenv bootargs $bootargs_def; usb start && usb storage && fatload usb 0:1 $loadaddr dds-xm200.bin && bootm\0" \
 	"boot_mmc=setenv bootargs $bootargs_def; mmc rescan && fatload mmc 0:1 $loadaddr dds-xm200.bin && bootm\0" \
-	"bootcmd=run boot_mmc ; run boot_usb ; run boot_working ; run boot_safe\0" \
-	"altbootcmd=run boot_mmc ; run boot_usb ; run boot_safe ; run boot_working\0"
+	"bootcmd=run boot_mmc ; run boot_usb ; run boot_working ; run boot_safe\0"
 
 /* Console settings */
 
diff --git a/include/env/pg-wcom/common.env b/include/env/pg-wcom/common.env
index 4b660cebd675..5f2ba1c4090b 100644
--- a/include/env/pg-wcom/common.env
+++ b/include/env/pg-wcom/common.env
@@ -22,7 +22,6 @@ add_default=setenv bootargs ${bootargs} ip=${ipaddr}:${serverip}:${gatewayip}:${
 		WCOM_UBI_LINUX_MTD
 
 addpanic=setenv bootargs ${bootargs} panic=1 panic_on_oops=1
-altbootcmd=run bootcmd
 backup_bank=0
 boot=bootm ${load_addr_r} - ${fdt_addr_r}
 
-- 
2.43.0

