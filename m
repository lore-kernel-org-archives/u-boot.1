Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 869781099B30
	for <u-boot@archiver.kernel.org>; Fri, 20 Mar 2026 20:53:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6E71283F9B;
	Fri, 20 Mar 2026 21:53:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="PDDrYuRd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 659CF83F9B; Fri, 20 Mar 2026 21:53:31 +0100 (CET)
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com
 [IPv6:2001:4860:4864:20::29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B66B58394E
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 21:53:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x29.google.com with SMTP id
 586e51a60fabf-404254ffe8aso1623928fac.0
 for <u-boot@lists.denx.de>; Fri, 20 Mar 2026 13:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1774040006; x=1774644806; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=lZD0JUxePjQ+gCk0F0GVIFToK1M8hAVL8mzuyJ/BvHY=;
 b=PDDrYuRdqSXkJhugd4CnF/9G2EnKa6XwAe1LVG+Lqo0kOMI64P5S2pN8LDYBgIMxU2
 4YJF9gSAsvjUEogooLFHyaDA7Pkw6UZj4RcqXwdLeiH/B2jKdyK8smUPg3MhIYFTQclY
 uml4V3na3PzHPcjwsUHFBARFVNENTPELQMyB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774040006; x=1774644806;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lZD0JUxePjQ+gCk0F0GVIFToK1M8hAVL8mzuyJ/BvHY=;
 b=hmDkNg+MY3NPL5WbLz0Rfo2SBVV5u2ky8pSa4feEJkHsbQnRygcpTmaNa05PFZgXoR
 bhyKW0qx55KXS9evSCDe3L9zsQWb44zaF+7eFi7L3MX6VwGDbVisYUSIPrpX2A7WEypG
 vaXnBUHFT58sqjsZpPMqf8+f3KvQXEUkEMpY+JssT0NtBRmiqoaMdOMi3rVCawu71wja
 bk0xS8nsUEk0Ym3Nry2vxZ7Hp8lsNNT3+LamT5FaiMQkOhwTajtLZ3vOQDtyVdK7nHyd
 WqnEAPjwErGRDO25LZ6rfzM6el149vWRT25gj2fq7CtWZj/vdlyXtwPavqOuzwhFGpa+
 ipZQ==
X-Gm-Message-State: AOJu0YzWwBgzUpfGk4sCWL2PPZnIzFAJgSnV1pkTTr1G6o4sDZKl+Hh8
 MWZT2Oig8SSjmSe479UIDWoCQkzDYtepeGNFQzg73S53qhVcZ7yj0Dz36nL499sagBfluJGnP/F
 8Rr1N
X-Gm-Gg: ATEYQzxnxCp4eH7uvNOLv0Tw9EP2GPlH7xPtNXL9MDzZbkd8Ydl5dIt1zomvhnoNeZY
 Vif/QZ4RIqaD9+sXfXuw83fcIyobMf29GcCMrKvPch9CTfanr7/gy8GMMaOqiN6RVoCm4LE3giM
 7acpIooasgiTevApZZKjXNsse0hJb6HLoHZzYNKnz1Lro9kFj1DbCGcZ0IPiKHrzMicMOOFyu2f
 ysk2QLEV1mn+tOPSFzR0ahqlDwb7VwO7aK6U0aZP0CuMYaWPyfES+v+Fy2bAg2XDtPUc0gpzH5n
 HrJuHlBBb7AaeYmgIL2pfWsK7yxJPyUI/bdoYvsZkFB+D8eJp/BCV0oj6Dgqem1jX/MHRzW9NdH
 uKJ+P9WqS4Xxlx5euwbeIsQt96JlBbvM3rdCzKF+lvSCkdtzC4s+sanWlJ3pxdoakxsRJbNhglM
 7lFgXQdWNfYfJuP1xWrTWSHRHHWXfarJOUKHL0/PWN0QRAsvPaXdRRpXmqPpj8mcrVPExaLdmIl
 XVf6WETkCD+CWOXX6+i6u1rsEMGpQw26D6O74ozi8PDreXgTxo=
X-Received: by 2002:a05:6871:a18e:b0:417:3689:a380 with SMTP id
 586e51a60fabf-41befea5a0emr4011331fac.16.1774040005937; 
 Fri, 20 Mar 2026 13:53:25 -0700 (PDT)
Received: from bill-the-cat.. (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-41c14ddbca8sm3176378fac.15.2026.03.20.13.53.25
 for <u-boot@lists.denx.de>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 13:53:25 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de
Subject: [PATCH] sata: Rework the CMD_SATA and SATA symbols
Date: Fri, 20 Mar 2026 14:53:24 -0600
Message-ID: <20260320205324.3788589-1-trini@konsulko.com>
X-Mailer: git-send-email 2.43.0
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

Today we typically enable CMD_SATA in order to have the SATA
functionality itself enabled, despite there being a clean split between
the two symbols. This in turn leads to potential configuration problems.
Split things so that SATA continues to be separate and not CMD_SATA
instead depends, functionally, on AHCI being enabled.

To do all of this:
- Have X86 select AHCI directly rather than "default y" it later.
- Make CMD_SATA be a default y option, given the split of platforms that
  enabled SATA and did, or did not, enable CMD_SATA.
- Change "imply CMD_SATA" to "imply SATA"
- Correct TARGET_VEXPRESS64_JUNO because you cannot select SATA_SIL
  without PCI (and in turn, SATA is needed for SATA_SIL).
- Update a number of defconfigs to have no functional change.

Signed-off-by: Tom Rini <trini@konsulko.com>
---
 arch/Kconfig                                  |  1 +
 arch/arm/mach-imx/mx6/Kconfig                 |  8 ++--
 arch/arm/mach-mvebu/Kconfig                   |  4 +-
 arch/powerpc/cpu/mpc85xx/Kconfig              | 46 +++++++++----------
 arch/x86/Kconfig                              |  3 --
 board/armltd/vexpress64/Kconfig               |  3 +-
 cmd/Kconfig                                   |  3 +-
 configs/MPC837XERDB_defconfig                 |  2 +-
 configs/aristainetos2c_defconfig              |  2 +-
 configs/aristainetos2ccslb_defconfig          |  2 +-
 configs/chromebook_coral_defconfig            |  2 +-
 configs/chromebook_samus_defconfig            |  2 +-
 configs/chromebook_samus_tpl_defconfig        |  2 +-
 configs/cm_fx6_defconfig                      |  2 +-
 configs/coreboot64-no-spl_defconfig           |  2 +-
 configs/coreboot64_defconfig                  |  2 +-
 configs/coreboot_defconfig                    |  2 +-
 configs/d2net_v2_defconfig                    |  2 +-
 configs/db-mv784mp-gp_defconfig               |  2 +-
 configs/dh_imx6.config                        |  2 +-
 configs/dreamplug_defconfig                   |  2 +-
 configs/goflexhome_defconfig                  |  2 +-
 configs/inetspace_v2_defconfig                |  2 +-
 configs/kontron_sl28_defconfig                |  1 +
 configs/ls1012a2g5rdb_tfa_defconfig           |  1 +
 configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig |  1 +
 configs/ls1012afrwy_tfa_defconfig             |  1 +
 configs/ls1012aqds_tfa_defconfig              |  1 +
 configs/ls1012ardb_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls1012ardb_tfa_defconfig              |  1 +
 configs/ls1021aiot_qspi_defconfig             |  1 +
 configs/ls1021aiot_sdcard_defconfig           |  1 +
 configs/ls1021aqds_ddr4_nor_defconfig         |  1 +
 configs/ls1021aqds_ddr4_nor_lpuart_defconfig  |  1 +
 configs/ls1021aqds_nand_defconfig             |  1 +
 configs/ls1021aqds_nor_SECURE_BOOT_defconfig  |  1 +
 configs/ls1021aqds_nor_defconfig              |  1 +
 configs/ls1021aqds_nor_lpuart_defconfig       |  1 +
 configs/ls1021aqds_qspi_defconfig             |  1 +
 configs/ls1021aqds_sdcard_ifc_defconfig       |  1 +
 configs/ls1021aqds_sdcard_qspi_defconfig      |  1 +
 configs/ls1021atwr_nor_SECURE_BOOT_defconfig  |  1 +
 configs/ls1021atwr_nor_defconfig              |  1 +
 configs/ls1021atwr_nor_lpuart_defconfig       |  1 +
 configs/ls1021atwr_qspi_defconfig             |  1 +
 configs/ls1021atwr_sdcard_ifc_defconfig       |  1 +
 configs/ls1021atwr_sdcard_qspi_defconfig      |  1 +
 configs/ls1028aqds_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls1028aqds_tfa_defconfig              |  1 +
 configs/ls1028aqds_tfa_lpuart_defconfig       |  1 +
 configs/ls1028ardb_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls1028ardb_tfa_defconfig              |  1 +
 configs/ls1043aqds_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls1043aqds_tfa_defconfig              |  1 +
 configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig |  1 +
 configs/ls1046afrwy_tfa_defconfig             |  1 +
 configs/ls1046aqds_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls1046aqds_tfa_defconfig              |  1 +
 configs/ls1046ardb_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls1046ardb_tfa_defconfig              |  1 +
 configs/ls1088aqds_tfa_defconfig              |  1 +
 configs/ls1088ardb_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls1088ardb_tfa_defconfig              |  1 +
 configs/ls2080aqds_nand_defconfig             |  1 +
 configs/ls2080aqds_qspi_defconfig             |  1 +
 configs/ls2080ardb_nand_defconfig             |  1 +
 configs/ls2088aqds_tfa_defconfig              |  1 +
 configs/ls2088ardb_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/ls2088ardb_tfa_defconfig              |  1 +
 configs/lschlv2_defconfig                     |  2 +-
 configs/lsxhl_defconfig                       |  2 +-
 configs/lx2160aqds_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/lx2160aqds_tfa_defconfig              |  1 +
 configs/lx2160ardb_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/lx2160ardb_tfa_defconfig              |  1 +
 configs/lx2160ardb_tfa_stmm_defconfig         |  1 +
 configs/lx2162aqds_tfa_SECURE_BOOT_defconfig  |  1 +
 configs/lx2162aqds_tfa_defconfig              |  1 +
 .../lx2162aqds_tfa_verified_boot_defconfig    |  1 +
 configs/mvebu_espressobin-88f3720_defconfig   |  2 +-
 configs/mx6cuboxi_defconfig                   |  2 +-
 configs/mx6qsabrelite_defconfig               |  2 +-
 configs/net2big_v2_defconfig                  |  2 +-
 configs/netspace_lite_v2_defconfig            |  2 +-
 configs/netspace_max_v2_defconfig             |  2 +-
 configs/netspace_mini_v2_defconfig            |  2 +-
 configs/netspace_v2_defconfig                 |  2 +-
 configs/nitrogen6q2g_defconfig                |  2 +-
 configs/nitrogen6q_defconfig                  |  2 +-
 configs/novena_defconfig                      |  2 +-
 configs/nsa310s_defconfig                     |  2 +-
 configs/nsa325_defconfig                      |  2 +-
 configs/octeon_nic23_defconfig                |  1 +
 configs/odroid-hc4_defconfig                  |  1 +
 configs/pogo_v4_defconfig                     |  2 +-
 configs/qnap-ts433-rk3568_defconfig           |  2 +-
 configs/rockpro64-rk3399_defconfig            |  1 +
 configs/sheevaplug_defconfig                  |  2 +-
 configs/synquacer_developerbox_defconfig      |  2 +-
 configs/tbs2910_defconfig                     |  2 +-
 configs/turing-rk1-rk3588_defconfig           |  1 +
 configs/turris_mox_defconfig                  |  2 +-
 configs/turris_omnia_defconfig                |  2 +-
 configs/udoo_defconfig                        |  2 +-
 configs/vexpress_aemv8a_juno_defconfig        |  2 +-
 configs/wandboard_defconfig                   |  2 +-
 configs/xilinx_zynqmp_kria_defconfig          |  1 +
 configs/xilinx_zynqmp_virt_defconfig          |  1 +
 108 files changed, 135 insertions(+), 75 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 10755fec8bbe..4c4c070df87b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -297,6 +297,7 @@ config SH
 
 config X86
 	bool "x86 architecture"
+	select AHCI
 	select HAVE_SETJMP
 	select SUPPORT_SPL
 	select SUPPORT_TPL
diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kconfig
index f64bebfc14ba..552537895fcf 100644
--- a/arch/arm/mach-imx/mx6/Kconfig
+++ b/arch/arm/mach-imx/mx6/Kconfig
@@ -120,7 +120,7 @@ config TARGET_APALIS_IMX6
 	select DM_THERMAL
 	select SUPPORT_SPL
 	imply CMD_DM
-	imply CMD_SATA
+	imply SATA
 
 config TARGET_ARISTAINETOS2C
 	bool "Support aristainetos2-revC"
@@ -130,7 +130,7 @@ config TARGET_ARISTAINETOS2C
 	select MXC_UART
 	select FEC_MXC
 	select DM
-	imply CMD_SATA
+	imply SATA
 	imply CMD_DM
 
 config TARGET_ARISTAINETOS2CCSLB
@@ -141,7 +141,7 @@ config TARGET_ARISTAINETOS2CCSLB
 	select MXC_UART
 	select FEC_MXC
 	select DM
-	imply CMD_SATA
+	imply SATA
 	imply CMD_DM
 
 config TARGET_CM_FX6
@@ -230,7 +230,7 @@ config TARGET_GW_VENTANA
 	select SUPPORT_SPL
 	select GATEWORKS_SC
 	select MISC
-	imply CMD_SATA
+	imply SATA
 	imply CMD_SPL
 
 config TARGET_KONTRON_MX6UL
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index b76510ab4527..4afaee234eaf 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -74,7 +74,7 @@ config MV78230
 config MV78260
 	bool
 	select ARMADA_XP
-	imply CMD_SATA
+	imply SATA
 
 config MV78460
 	bool
@@ -204,7 +204,7 @@ config TARGET_THEADORABLE
 	bool "Support theadorable Armada XP"
 	select BOARD_LATE_INIT if USB
 	select MV78260
-	imply CMD_SATA
+	imply SATA
 
 config TARGET_CONTROLCENTERDC
 	bool "Support CONTROLCENTERDC"
diff --git a/arch/powerpc/cpu/mpc85xx/Kconfig b/arch/powerpc/cpu/mpc85xx/Kconfig
index c5c2220593fa..55152ab227e3 100644
--- a/arch/powerpc/cpu/mpc85xx/Kconfig
+++ b/arch/powerpc/cpu/mpc85xx/Kconfig
@@ -93,7 +93,7 @@ config TARGET_P3041DS
 	select ARCH_P3041
 	select BOARD_LATE_INIT if CHAIN_OF_TRUST
 	select FSL_NGPIXIS
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_P4080DS
@@ -102,7 +102,7 @@ config TARGET_P4080DS
 	select ARCH_P4080
 	select BOARD_LATE_INIT if CHAIN_OF_TRUST
 	select FSL_NGPIXIS
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_P5040DS
@@ -112,7 +112,7 @@ config TARGET_P5040DS
 	select BOARD_LATE_INIT if CHAIN_OF_TRUST
 	select FSL_NGPIXIS
 	select SYS_FSL_RAID_ENGINE
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_MPC8548CDS
@@ -129,7 +129,7 @@ config TARGET_P1010RDB_PA
 	select SUPPORT_TPL
 	select SYS_L2_SIZE_256KB
 	imply CMD_EEPROM
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_P1010RDB_PB
@@ -140,7 +140,7 @@ config TARGET_P1010RDB_PB
 	select SUPPORT_TPL
 	select SYS_L2_SIZE_256KB
 	imply CMD_EEPROM
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_P1020RDB_PC
@@ -150,7 +150,7 @@ config TARGET_P1020RDB_PC
 	select ARCH_P1020
 	select SYS_L2_SIZE_256KB
 	imply CMD_EEPROM
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_P1020RDB_PD
@@ -160,7 +160,7 @@ config TARGET_P1020RDB_PD
 	select ARCH_P1020
 	select SYS_L2_SIZE_256KB
 	imply CMD_EEPROM
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_P2020RDB
@@ -170,7 +170,7 @@ config TARGET_P2020RDB
 	select ARCH_P2020
 	select SYS_L2_SIZE_512KB
 	imply CMD_EEPROM
-	imply CMD_SATA
+	imply SATA
 	imply SATA_SIL
 
 config TARGET_TURRIS_1X
@@ -190,7 +190,7 @@ config TARGET_P2041RDB
 	select FSL_CORENET
 	select PHYS_64BIT
 	select SYS_L3_SIZE_1024KB
-	imply CMD_SATA
+	imply SATA
 	imply FSL_SATA
 
 config TARGET_QEMU_PPCE500
@@ -229,7 +229,7 @@ config TARGET_T2080QDS
 	select FSL_DDR_FIRST_SLOT_QUAD_CAPABLE
 	select FSL_DDR_INTERACTIVE
 	select SYS_L3_SIZE_512KB
-	imply CMD_SATA
+	imply SATA
 
 config TARGET_T2080RDB
 	bool "Support T2080RDB"
@@ -238,7 +238,7 @@ config TARGET_T2080RDB
 	select SUPPORT_SPL
 	select PHYS_64BIT
 	select SYS_L3_SIZE_512KB
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_T4240RDB
@@ -248,7 +248,7 @@ config TARGET_T4240RDB
 	select PHYS_64BIT
 	select FSL_DDR_FIRST_SLOT_QUAD_CAPABLE
 	select SYS_L3_SIZE_512KB
-	imply CMD_SATA
+	imply SATA
 	imply PANIC_HANG
 
 config TARGET_KMP204X
@@ -405,7 +405,7 @@ config ARCH_MPC8536
 	select SYS_PPC_E500_USE_DEBUG_TLB
 	select FSL_ELBC
 	imply CMD_NAND
-	imply CMD_SATA
+	imply SATA
 	imply CMD_REGINFO
 
 config ARCH_MPC8540
@@ -482,7 +482,7 @@ config ARCH_P1010
 	imply CMD_EEPROM
 	imply CMD_MTDPARTS
 	imply CMD_NAND
-	imply CMD_SATA
+	imply SATA
 	imply CMD_PCI
 	imply CMD_REGINFO
 	imply FSL_SATA
@@ -521,7 +521,7 @@ config ARCH_P1020
 	select SYS_PPC_E500_USE_DEBUG_TLB
 	select FSL_ELBC
 	imply CMD_NAND
-	imply CMD_SATA
+	imply SATA
 	imply CMD_PCI
 	imply CMD_REGINFO
 	imply SATA_SIL
@@ -543,7 +543,7 @@ config ARCH_P1021
 	select FSL_ELBC
 	imply CMD_REGINFO
 	imply CMD_NAND
-	imply CMD_SATA
+	imply SATA
 	imply CMD_REGINFO
 	imply SATA_SIL
 
@@ -579,7 +579,7 @@ config ARCH_P1024
 	select FSL_ELBC
 	imply CMD_EEPROM
 	imply CMD_NAND
-	imply CMD_SATA
+	imply SATA
 	imply CMD_PCI
 	imply CMD_REGINFO
 	imply SATA_SIL
@@ -599,7 +599,7 @@ config ARCH_P1025
 	select SYS_FSL_SEC_COMPAT_2
 	select SYS_PPC_E500_USE_DEBUG_TLB
 	select FSL_ELBC
-	imply CMD_SATA
+	imply SATA
 	imply CMD_REGINFO
 
 config ARCH_P2020
@@ -687,7 +687,7 @@ config ARCH_P3041
 	select SYS_FSL_USB2_PHY_ENABLE
 	select FSL_ELBC
 	imply CMD_NAND
-	imply CMD_SATA
+	imply SATA
 	imply CMD_REGINFO
 	imply FSL_SATA
 
@@ -730,7 +730,7 @@ config ARCH_P4080
 	select SYS_FSL_SEC_BE
 	select SYS_FSL_SEC_COMPAT_4
 	select FSL_ELBC
-	imply CMD_SATA
+	imply SATA
 	imply CMD_REGINFO
 	imply SATA_SIL
 
@@ -761,7 +761,7 @@ config ARCH_P5040
 	select SYS_FSL_USB2_PHY_ENABLE
 	select SYS_PPC64
 	select FSL_ELBC
-	imply CMD_SATA
+	imply SATA
 	imply CMD_REGINFO
 	imply FSL_SATA
 
@@ -903,7 +903,7 @@ config ARCH_T2080
 	select SYS_PMAN if !NOBQFMAN
 	select SYS_PPC64
 	select FSL_IFC
-	imply CMD_SATA
+	imply SATA
 	imply CMD_NAND
 	imply CMD_REGINFO
 	imply FSL_SATA
@@ -946,7 +946,7 @@ config ARCH_T4240
 	select SYS_PMAN if !NOBQFMAN
 	select SYS_PPC64
 	select FSL_IFC
-	imply CMD_SATA
+	imply SATA
 	imply CMD_NAND
 	imply CMD_REGINFO
 	imply FSL_SATA
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 48b033e7e27c..8bf5a300d1fb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -130,9 +130,6 @@ source "arch/x86/cpu/tangier/Kconfig"
 
 # architecture-specific options below
 
-config AHCI
-	default y
-
 config RAMBASE
 	hex
 	default 0x100000
diff --git a/board/armltd/vexpress64/Kconfig b/board/armltd/vexpress64/Kconfig
index 9ef3fa1b379f..49c7fda0b83a 100644
--- a/board/armltd/vexpress64/Kconfig
+++ b/board/armltd/vexpress64/Kconfig
@@ -41,7 +41,8 @@ config TARGET_VEXPRESS64_BASER_FVP
 config TARGET_VEXPRESS64_JUNO
 	bool "Support Versatile Express Juno Development Platform"
 	select PCIE_ECAM_GENERIC if PCI
-	select SATA_SIL
+	select SATA if PCI
+	select SATA_SIL if PCI
 	select SMC911X if DM_ETH
 	select SMC911X_32_BIT if SMC911X
 	select CMD_USB if USB
diff --git a/cmd/Kconfig b/cmd/Kconfig
index 322ebe600c54..667c4e0ae811 100644
--- a/cmd/Kconfig
+++ b/cmd/Kconfig
@@ -1715,7 +1715,8 @@ config CMD_REMOTEPROC
 
 config CMD_SATA
 	bool "sata - Access SATA subsystem"
-	select SATA
+	depends on SATA && AHCI
+	default y
 	help
 	  SATA (Serial Advanced Technology Attachment) is a serial bus
 	  standard for connecting to hard drives and other storage devices.
diff --git a/configs/MPC837XERDB_defconfig b/configs/MPC837XERDB_defconfig
index dd30e8d30da1..243484852c3c 100644
--- a/configs/MPC837XERDB_defconfig
+++ b/configs/MPC837XERDB_defconfig
@@ -133,7 +133,7 @@ CONFIG_LOADS_ECHO=y
 CONFIG_SYS_LOADS_BAUD_CHANGE=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
diff --git a/configs/aristainetos2c_defconfig b/configs/aristainetos2c_defconfig
index 6d59ccfb15bb..6923d27f79ae 100644
--- a/configs/aristainetos2c_defconfig
+++ b/configs/aristainetos2c_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_PINMUX is not set
-# CONFIG_CMD_SATA is not set
+# CONFIG_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
diff --git a/configs/aristainetos2ccslb_defconfig b/configs/aristainetos2ccslb_defconfig
index cd67ed1c46d0..3ffebb15375a 100644
--- a/configs/aristainetos2ccslb_defconfig
+++ b/configs/aristainetos2ccslb_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_PINMUX is not set
-# CONFIG_CMD_SATA is not set
+# CONFIG_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
diff --git a/configs/chromebook_coral_defconfig b/configs/chromebook_coral_defconfig
index 6bfcda1d6a34..c90a9d6159cf 100644
--- a/configs/chromebook_coral_defconfig
+++ b/configs/chromebook_coral_defconfig
@@ -62,7 +62,7 @@ CONFIG_CMD_MEM_SEARCH=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_READ=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_BOOTP_BOOTFILESIZE=y
diff --git a/configs/chromebook_samus_defconfig b/configs/chromebook_samus_defconfig
index ed1c62330c98..07f318386bae 100644
--- a/configs/chromebook_samus_defconfig
+++ b/configs/chromebook_samus_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_CPU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PART=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/chromebook_samus_tpl_defconfig b/configs/chromebook_samus_tpl_defconfig
index dbc8be49ee71..52fb471c97e0 100644
--- a/configs/chromebook_samus_tpl_defconfig
+++ b/configs/chromebook_samus_tpl_defconfig
@@ -52,7 +52,7 @@ CONFIG_CMD_CPU=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PART=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/cm_fx6_defconfig b/configs/cm_fx6_defconfig
index 4eb86fee70bd..e042364de9c3 100644
--- a/configs/cm_fx6_defconfig
+++ b/configs/cm_fx6_defconfig
@@ -51,7 +51,7 @@ CONFIG_CMD_I2C=y
 # CONFIG_CMD_LOADB is not set
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
diff --git a/configs/coreboot64-no-spl_defconfig b/configs/coreboot64-no-spl_defconfig
index aadf11e98673..5e71ce839203 100644
--- a/configs/coreboot64-no-spl_defconfig
+++ b/configs/coreboot64-no-spl_defconfig
@@ -24,7 +24,7 @@ CONFIG_LOGF_FUNC=y
 CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
diff --git a/configs/coreboot64_defconfig b/configs/coreboot64_defconfig
index 719b2f02c1e6..8261c39d87b0 100644
--- a/configs/coreboot64_defconfig
+++ b/configs/coreboot64_defconfig
@@ -28,7 +28,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_SPL_NO_BSS_LIMIT=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
diff --git a/configs/coreboot_defconfig b/configs/coreboot_defconfig
index b49fc80167b3..c7520def6dc9 100644
--- a/configs/coreboot_defconfig
+++ b/configs/coreboot_defconfig
@@ -27,7 +27,7 @@ CONFIG_DISPLAY_BOARDINFO_LATE=y
 CONFIG_PCI_INIT_R=y
 CONFIG_CMD_IDE=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_BOOTP_BOOTFILESIZE=y
diff --git a/configs/d2net_v2_defconfig b/configs/d2net_v2_defconfig
index 55977e896b16..cfb44a41812f 100644
--- a/configs/d2net_v2_defconfig
+++ b/configs/d2net_v2_defconfig
@@ -32,7 +32,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
diff --git a/configs/db-mv784mp-gp_defconfig b/configs/db-mv784mp-gp_defconfig
index 5162f70ab9e5..d6b773b0f976 100644
--- a/configs/db-mv784mp-gp_defconfig
+++ b/configs/db-mv784mp-gp_defconfig
@@ -38,7 +38,7 @@ CONFIG_SPL_I2C=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_I2C=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/dh_imx6.config b/configs/dh_imx6.config
index b1eeb8901f46..c9165b28e8bf 100644
--- a/configs/dh_imx6.config
+++ b/configs/dh_imx6.config
@@ -28,7 +28,7 @@ CONFIG_BOOTCOUNT_LIMIT=y
 CONFIG_BOOTDELAY=3
 
 CONFIG_BZIP2=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_UNZIP=y
 CONFIG_CMD_WDT=y
 CONFIG_DISTRO_DEFAULTS=y
diff --git a/configs/dreamplug_defconfig b/configs/dreamplug_defconfig
index bd0e07bba08a..31fb4ffa449d 100644
--- a/configs/dreamplug_defconfig
+++ b/configs/dreamplug_defconfig
@@ -25,7 +25,7 @@ CONFIG_USE_PREBOOT=y
 CONFIG_HUSH_PARSER=y
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_IDE=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/goflexhome_defconfig b/configs/goflexhome_defconfig
index ab58edb605f6..e6fbd7e48652 100644
--- a/configs/goflexhome_defconfig
+++ b/configs/goflexhome_defconfig
@@ -26,7 +26,7 @@ CONFIG_CONSOLE_MUX=y
 CONFIG_SYS_PROMPT="GoFlexHome> "
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_NAND=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/inetspace_v2_defconfig b/configs/inetspace_v2_defconfig
index 04ce0b8f0afc..5c44ba63ce0b 100644
--- a/configs/inetspace_v2_defconfig
+++ b/configs/inetspace_v2_defconfig
@@ -32,7 +32,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
diff --git a/configs/kontron_sl28_defconfig b/configs/kontron_sl28_defconfig
index e97534ecc0a4..4a97c51e88cb 100644
--- a/configs/kontron_sl28_defconfig
+++ b/configs/kontron_sl28_defconfig
@@ -71,6 +71,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_WDT=y
diff --git a/configs/ls1012a2g5rdb_tfa_defconfig b/configs/ls1012a2g5rdb_tfa_defconfig
index 32d95162e9b0..ffd5644274ed 100644
--- a/configs/ls1012a2g5rdb_tfa_defconfig
+++ b/configs/ls1012a2g5rdb_tfa_defconfig
@@ -33,6 +33,7 @@ CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
index 9ccd35ac2236..82ca6cbd48e4 100644
--- a/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012afrwy_tfa_SECURE_BOOT_defconfig
@@ -36,6 +36,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1012afrwy_tfa_defconfig b/configs/ls1012afrwy_tfa_defconfig
index 70f051f76e8a..a5868a8c8505 100644
--- a/configs/ls1012afrwy_tfa_defconfig
+++ b/configs/ls1012afrwy_tfa_defconfig
@@ -36,6 +36,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls1012aqds_tfa_defconfig b/configs/ls1012aqds_tfa_defconfig
index e7f7031f42df..81b225e80474 100644
--- a/configs/ls1012aqds_tfa_defconfig
+++ b/configs/ls1012aqds_tfa_defconfig
@@ -45,6 +45,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_SPI=y
 CONFIG_DEFAULT_SPI_BUS=1
 CONFIG_CMD_USB=y
diff --git a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
index bb9cf573cc2e..54a058825ab9 100644
--- a/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1012ardb_tfa_SECURE_BOOT_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1012ardb_tfa_defconfig b/configs/ls1012ardb_tfa_defconfig
index 428fc58e2f31..b490486c7888 100644
--- a/configs/ls1012ardb_tfa_defconfig
+++ b/configs/ls1012ardb_tfa_defconfig
@@ -37,6 +37,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls1021aiot_qspi_defconfig b/configs/ls1021aiot_qspi_defconfig
index 9353979a2e7c..73853ef060f1 100644
--- a/configs/ls1021aiot_qspi_defconfig
+++ b/configs/ls1021aiot_qspi_defconfig
@@ -34,6 +34,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
diff --git a/configs/ls1021aiot_sdcard_defconfig b/configs/ls1021aiot_sdcard_defconfig
index c631590df1e7..334993ed5965 100644
--- a/configs/ls1021aiot_sdcard_defconfig
+++ b/configs/ls1021aiot_sdcard_defconfig
@@ -62,6 +62,7 @@ CONFIG_CMD_MEMINFO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_MII=y
 # CONFIG_CMD_MDIO is not set
diff --git a/configs/ls1021aqds_ddr4_nor_defconfig b/configs/ls1021aqds_ddr4_nor_defconfig
index 4bea39a636f7..18e60a092254 100644
--- a/configs/ls1021aqds_ddr4_nor_defconfig
+++ b/configs/ls1021aqds_ddr4_nor_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_ddr4_nor_lpuart_defconfig b/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
index f897e41e4445..04248c67fb3c 100644
--- a/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
+++ b/configs/ls1021aqds_ddr4_nor_lpuart_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_nand_defconfig b/configs/ls1021aqds_nand_defconfig
index d606a4ff002c..55c8fee4f549 100644
--- a/configs/ls1021aqds_nand_defconfig
+++ b/configs/ls1021aqds_nand_defconfig
@@ -77,6 +77,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
index 3934d2598875..57e44138aaf3 100644
--- a/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021aqds_nor_SECURE_BOOT_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_nor_defconfig b/configs/ls1021aqds_nor_defconfig
index 8fa9bb60238b..87de073ddc38 100644
--- a/configs/ls1021aqds_nor_defconfig
+++ b/configs/ls1021aqds_nor_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_nor_lpuart_defconfig b/configs/ls1021aqds_nor_lpuart_defconfig
index 881fe3dabaee..2d863a6c7a6a 100644
--- a/configs/ls1021aqds_nor_lpuart_defconfig
+++ b/configs/ls1021aqds_nor_lpuart_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_qspi_defconfig b/configs/ls1021aqds_qspi_defconfig
index 5b28997dbaa5..76bcc3525e7a 100644
--- a/configs/ls1021aqds_qspi_defconfig
+++ b/configs/ls1021aqds_qspi_defconfig
@@ -46,6 +46,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_sdcard_ifc_defconfig b/configs/ls1021aqds_sdcard_ifc_defconfig
index 098c62db51df..edd49197a5e2 100644
--- a/configs/ls1021aqds_sdcard_ifc_defconfig
+++ b/configs/ls1021aqds_sdcard_ifc_defconfig
@@ -77,6 +77,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021aqds_sdcard_qspi_defconfig b/configs/ls1021aqds_sdcard_qspi_defconfig
index ce0b190de3c0..317f5de92a67 100644
--- a/configs/ls1021aqds_sdcard_qspi_defconfig
+++ b/configs/ls1021aqds_sdcard_qspi_defconfig
@@ -74,6 +74,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_DHCP=y
diff --git a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
index 503afd1847b4..93fff8b45df1 100644
--- a/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
+++ b/configs/ls1021atwr_nor_SECURE_BOOT_defconfig
@@ -46,6 +46,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1021atwr_nor_defconfig b/configs/ls1021atwr_nor_defconfig
index ffaecb5c90c3..433bd2cad949 100644
--- a/configs/ls1021atwr_nor_defconfig
+++ b/configs/ls1021atwr_nor_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1021atwr_nor_lpuart_defconfig b/configs/ls1021atwr_nor_lpuart_defconfig
index f666f4777270..8db7633d1b7e 100644
--- a/configs/ls1021atwr_nor_lpuart_defconfig
+++ b/configs/ls1021atwr_nor_lpuart_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1021atwr_qspi_defconfig b/configs/ls1021atwr_qspi_defconfig
index f8c6d82887bb..9646f404b013 100644
--- a/configs/ls1021atwr_qspi_defconfig
+++ b/configs/ls1021atwr_qspi_defconfig
@@ -47,6 +47,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1021atwr_sdcard_ifc_defconfig b/configs/ls1021atwr_sdcard_ifc_defconfig
index a6041337800f..c68ee9d5d2e9 100644
--- a/configs/ls1021atwr_sdcard_ifc_defconfig
+++ b/configs/ls1021atwr_sdcard_ifc_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1021atwr_sdcard_qspi_defconfig b/configs/ls1021atwr_sdcard_qspi_defconfig
index d3194ffdbcd2..daea28235660 100644
--- a/configs/ls1021atwr_sdcard_qspi_defconfig
+++ b/configs/ls1021atwr_sdcard_qspi_defconfig
@@ -76,6 +76,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_SPL_EFI_PARTITION is not set
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
index 97eb7d9dca4c..ebe4b02a5dbd 100644
--- a/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028aqds_tfa_SECURE_BOOT_defconfig
@@ -43,6 +43,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls1028aqds_tfa_defconfig b/configs/ls1028aqds_tfa_defconfig
index cc53c17f543b..19bbb07a81f9 100644
--- a/configs/ls1028aqds_tfa_defconfig
+++ b/configs/ls1028aqds_tfa_defconfig
@@ -45,6 +45,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/ls1028aqds_tfa_lpuart_defconfig b/configs/ls1028aqds_tfa_lpuart_defconfig
index 8da7271c7f85..32634a572a72 100644
--- a/configs/ls1028aqds_tfa_lpuart_defconfig
+++ b/configs/ls1028aqds_tfa_lpuart_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
index 3f71a37559be..6d79e47ada1c 100644
--- a/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1028ardb_tfa_SECURE_BOOT_defconfig
@@ -42,6 +42,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls1028ardb_tfa_defconfig b/configs/ls1028ardb_tfa_defconfig
index 89e452bdb1a8..19d0416ef917 100644
--- a/configs/ls1028ardb_tfa_defconfig
+++ b/configs/ls1028ardb_tfa_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
index 3d38f5841500..b742d872a3b8 100644
--- a/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1043aqds_tfa_SECURE_BOOT_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
diff --git a/configs/ls1043aqds_tfa_defconfig b/configs/ls1043aqds_tfa_defconfig
index e3fcdd37a40c..1c1e0de7a804 100644
--- a/configs/ls1043aqds_tfa_defconfig
+++ b/configs/ls1043aqds_tfa_defconfig
@@ -55,6 +55,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:1m(nand_uboot),1m(nand_uboot_env),20m(nand_fit);spi0.0:1m(uboot),5m(kernel),1m(dtb),9m(file_system)"
diff --git a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
index 6efe356e842a..8c47112fbd02 100644
--- a/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046afrwy_tfa_SECURE_BOOT_defconfig
@@ -36,6 +36,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=1550000.spi:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
diff --git a/configs/ls1046afrwy_tfa_defconfig b/configs/ls1046afrwy_tfa_defconfig
index 1282cb355d3d..6043454e7820 100644
--- a/configs/ls1046afrwy_tfa_defconfig
+++ b/configs/ls1046afrwy_tfa_defconfig
@@ -38,6 +38,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=1550000.spi:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
diff --git a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
index 941224b5ac21..bcbc891b4165 100644
--- a/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046aqds_tfa_SECURE_BOOT_defconfig
@@ -55,6 +55,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
diff --git a/configs/ls1046aqds_tfa_defconfig b/configs/ls1046aqds_tfa_defconfig
index 191ab45aec03..ea4b01faf212 100644
--- a/configs/ls1046aqds_tfa_defconfig
+++ b/configs/ls1046aqds_tfa_defconfig
@@ -56,6 +56,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=60000000.nor:2m@0x100000(nor_bank0_uboot),40m@0x1100000(nor_bank0_fit),7m(nor_bank0_user),2m@0x4100000(nor_bank4_uboot),40m@0x5100000(nor_bank4_fit),-(nor_bank4_user);7e800000.flash:4m(nand_uboot),36m(nand_kernel),472m(nand_free);spi0.0:2m(uboot),14m(free)"
diff --git a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
index 8a8a4e1c8d6e..b151cbee22f1 100644
--- a/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1046ardb_tfa_SECURE_BOOT_defconfig
@@ -42,6 +42,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
diff --git a/configs/ls1046ardb_tfa_defconfig b/configs/ls1046ardb_tfa_defconfig
index 62c4a6a66ead..28af48d1660c 100644
--- a/configs/ls1046ardb_tfa_defconfig
+++ b/configs/ls1046ardb_tfa_defconfig
@@ -43,6 +43,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_MTDPARTS_DEFAULT="mtdparts=1550000.spi-0:1m(rcw),15m(u-boot),48m(kernel.itb);7e800000.flash:16m(nand_uboot),48m(nand_kernel),448m(nand_free)"
diff --git a/configs/ls1088aqds_tfa_defconfig b/configs/ls1088aqds_tfa_defconfig
index dafbe9b3b2b7..06ec7e04c4b1 100644
--- a/configs/ls1088aqds_tfa_defconfig
+++ b/configs/ls1088aqds_tfa_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
index df472eeb404d..dd19b9f8127b 100644
--- a/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls1088ardb_tfa_SECURE_BOOT_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls1088ardb_tfa_defconfig b/configs/ls1088ardb_tfa_defconfig
index 46390a05adba..7116b4101ba8 100644
--- a/configs/ls1088ardb_tfa_defconfig
+++ b/configs/ls1088ardb_tfa_defconfig
@@ -50,6 +50,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls2080aqds_nand_defconfig b/configs/ls2080aqds_nand_defconfig
index 77f5a7ac7089..8fe6a398fa71 100644
--- a/configs/ls2080aqds_nand_defconfig
+++ b/configs/ls2080aqds_nand_defconfig
@@ -59,6 +59,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls2080aqds_qspi_defconfig b/configs/ls2080aqds_qspi_defconfig
index d07ca3217a2b..dd541d2dfa31 100644
--- a/configs/ls2080aqds_qspi_defconfig
+++ b/configs/ls2080aqds_qspi_defconfig
@@ -40,6 +40,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls2080ardb_nand_defconfig b/configs/ls2080ardb_nand_defconfig
index 8c623d6a8e5d..0cee45b8f9fb 100644
--- a/configs/ls2080ardb_nand_defconfig
+++ b/configs/ls2080ardb_nand_defconfig
@@ -66,6 +66,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls2088aqds_tfa_defconfig b/configs/ls2088aqds_tfa_defconfig
index 51475f2733fb..01f5aff7efc9 100644
--- a/configs/ls2088aqds_tfa_defconfig
+++ b/configs/ls2088aqds_tfa_defconfig
@@ -44,6 +44,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
index 3fd1de967896..7f339da1bb31 100644
--- a/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/ls2088ardb_tfa_SECURE_BOOT_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/ls2088ardb_tfa_defconfig b/configs/ls2088ardb_tfa_defconfig
index f053044fa56e..c42cb2b9ddc8 100644
--- a/configs/ls2088ardb_tfa_defconfig
+++ b/configs/ls2088ardb_tfa_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_CACHE=y
diff --git a/configs/lschlv2_defconfig b/configs/lschlv2_defconfig
index 65a55b40e014..68c89e23eb6b 100644
--- a/configs/lschlv2_defconfig
+++ b/configs/lschlv2_defconfig
@@ -31,7 +31,7 @@ CONFIG_DEFAULT_FDT_FILE="kirkwood-lschlv2.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/lsxhl_defconfig b/configs/lsxhl_defconfig
index c537d6d0ca6a..c35149340215 100644
--- a/configs/lsxhl_defconfig
+++ b/configs/lsxhl_defconfig
@@ -32,7 +32,7 @@ CONFIG_DEFAULT_FDT_FILE="kirkwood-lsxhl.dtb"
 CONFIG_SYS_CONSOLE_INFO_QUIET=y
 # CONFIG_DISPLAY_BOARDINFO is not set
 CONFIG_SYS_MAXARGS=32
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
index 321ed71993b8..39d4469c2b7a 100644
--- a/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160aqds_tfa_SECURE_BOOT_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/lx2160aqds_tfa_defconfig b/configs/lx2160aqds_tfa_defconfig
index 465f07ee7f82..4f20c9bd105c 100644
--- a/configs/lx2160aqds_tfa_defconfig
+++ b/configs/lx2160aqds_tfa_defconfig
@@ -51,6 +51,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
index 478a01b566c6..ab69287f2ca9 100644
--- a/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2160ardb_tfa_SECURE_BOOT_defconfig
@@ -48,6 +48,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_OF_CONTROL=y
diff --git a/configs/lx2160ardb_tfa_defconfig b/configs/lx2160ardb_tfa_defconfig
index 8fd18825569c..eebc1426621f 100644
--- a/configs/lx2160ardb_tfa_defconfig
+++ b/configs/lx2160ardb_tfa_defconfig
@@ -52,6 +52,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/lx2160ardb_tfa_stmm_defconfig b/configs/lx2160ardb_tfa_stmm_defconfig
index cf65897af898..0da49cb75641 100644
--- a/configs/lx2160ardb_tfa_stmm_defconfig
+++ b/configs/lx2160ardb_tfa_stmm_defconfig
@@ -53,6 +53,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EFIDEBUG=y
diff --git a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
index 46b6085a52fe..eeb24616fe84 100644
--- a/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
+++ b/configs/lx2162aqds_tfa_SECURE_BOOT_defconfig
@@ -49,6 +49,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/lx2162aqds_tfa_defconfig b/configs/lx2162aqds_tfa_defconfig
index 41e0262f3ca5..3330f6e2fd9d 100644
--- a/configs/lx2162aqds_tfa_defconfig
+++ b/configs/lx2162aqds_tfa_defconfig
@@ -53,6 +53,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/lx2162aqds_tfa_verified_boot_defconfig b/configs/lx2162aqds_tfa_verified_boot_defconfig
index 7abfdbafbdf1..a409f5becd76 100644
--- a/configs/lx2162aqds_tfa_verified_boot_defconfig
+++ b/configs/lx2162aqds_tfa_verified_boot_defconfig
@@ -54,6 +54,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_OPTEE_RPMB=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/mvebu_espressobin-88f3720_defconfig b/configs/mvebu_espressobin-88f3720_defconfig
index f3222e89b91f..af3bf1a04fce 100644
--- a/configs/mvebu_espressobin-88f3720_defconfig
+++ b/configs/mvebu_espressobin-88f3720_defconfig
@@ -35,7 +35,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
diff --git a/configs/mx6cuboxi_defconfig b/configs/mx6cuboxi_defconfig
index 6a7c8d414e15..b0ae93162718 100644
--- a/configs/mx6cuboxi_defconfig
+++ b/configs/mx6cuboxi_defconfig
@@ -37,7 +37,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_PINMUX is not set
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
 # CONFIG_CMD_VIDCONSOLE is not set
diff --git a/configs/mx6qsabrelite_defconfig b/configs/mx6qsabrelite_defconfig
index da07b38b4bc4..816b9a50358e 100644
--- a/configs/mx6qsabrelite_defconfig
+++ b/configs/mx6qsabrelite_defconfig
@@ -31,7 +31,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_PINMUX is not set
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_BMP=y
diff --git a/configs/net2big_v2_defconfig b/configs/net2big_v2_defconfig
index 0b65a3f99cc1..a24df5f478d4 100644
--- a/configs/net2big_v2_defconfig
+++ b/configs/net2big_v2_defconfig
@@ -33,7 +33,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
diff --git a/configs/netspace_lite_v2_defconfig b/configs/netspace_lite_v2_defconfig
index cee6449babc8..2860c166fb6b 100644
--- a/configs/netspace_lite_v2_defconfig
+++ b/configs/netspace_lite_v2_defconfig
@@ -33,7 +33,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
diff --git a/configs/netspace_max_v2_defconfig b/configs/netspace_max_v2_defconfig
index 6ba7eb51c40e..3eda61c0f34e 100644
--- a/configs/netspace_max_v2_defconfig
+++ b/configs/netspace_max_v2_defconfig
@@ -33,7 +33,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
diff --git a/configs/netspace_mini_v2_defconfig b/configs/netspace_mini_v2_defconfig
index ad9f3361baa0..16ff0313a8c1 100644
--- a/configs/netspace_mini_v2_defconfig
+++ b/configs/netspace_mini_v2_defconfig
@@ -33,7 +33,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
 CONFIG_CMD_DHCP=y
diff --git a/configs/netspace_v2_defconfig b/configs/netspace_v2_defconfig
index 73e3616acbb0..85cd5c96087a 100644
--- a/configs/netspace_v2_defconfig
+++ b/configs/netspace_v2_defconfig
@@ -33,7 +33,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_EEPROM=y
 CONFIG_SYS_EEPROM_PAGE_WRITE_BITS=4
 CONFIG_CMD_I2C=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_SYS_DISABLE_AUTOLOAD=y
diff --git a/configs/nitrogen6q2g_defconfig b/configs/nitrogen6q2g_defconfig
index a31261406870..4d18ec252111 100644
--- a/configs/nitrogen6q2g_defconfig
+++ b/configs/nitrogen6q2g_defconfig
@@ -34,7 +34,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
diff --git a/configs/nitrogen6q_defconfig b/configs/nitrogen6q_defconfig
index f9018f12aac3..59942f20eca3 100644
--- a/configs/nitrogen6q_defconfig
+++ b/configs/nitrogen6q_defconfig
@@ -34,7 +34,7 @@ CONFIG_SYS_ALT_MEMTEST=y
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
diff --git a/configs/novena_defconfig b/configs/novena_defconfig
index 4fd29ef8564b..2da31a26d5d0 100644
--- a/configs/novena_defconfig
+++ b/configs/novena_defconfig
@@ -45,7 +45,7 @@ CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 # CONFIG_CMD_SCSI is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_CACHE=y
diff --git a/configs/nsa310s_defconfig b/configs/nsa310s_defconfig
index 3a6c996a1dfc..ceae9b063600 100644
--- a/configs/nsa310s_defconfig
+++ b/configs/nsa310s_defconfig
@@ -27,7 +27,7 @@ CONFIG_SYS_PBSIZE=1050
 CONFIG_SYS_PROMPT="NSA310s> "
 CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_NAND=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_MTDPARTS=y
diff --git a/configs/nsa325_defconfig b/configs/nsa325_defconfig
index 284a74d08d8a..418cc4d51da8 100644
--- a/configs/nsa325_defconfig
+++ b/configs/nsa325_defconfig
@@ -37,7 +37,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_SNTP=y
diff --git a/configs/octeon_nic23_defconfig b/configs/octeon_nic23_defconfig
index 06fe9f785912..42f5f05cccda 100644
--- a/configs/octeon_nic23_defconfig
+++ b/configs/octeon_nic23_defconfig
@@ -35,6 +35,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_DHCP=y
 CONFIG_CMD_PING=y
 CONFIG_CMD_TIME=y
diff --git a/configs/odroid-hc4_defconfig b/configs/odroid-hc4_defconfig
index eaa54a42557d..e8fc47039832 100644
--- a/configs/odroid-hc4_defconfig
+++ b/configs/odroid-hc4_defconfig
@@ -33,6 +33,7 @@ CONFIG_CMD_GPIO=y
 # CONFIG_CMD_LOADS is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
diff --git a/configs/pogo_v4_defconfig b/configs/pogo_v4_defconfig
index faeaf07df80c..711e128d38ef 100644
--- a/configs/pogo_v4_defconfig
+++ b/configs/pogo_v4_defconfig
@@ -36,7 +36,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_DNS=y
 CONFIG_CMD_SNTP=y
diff --git a/configs/qnap-ts433-rk3568_defconfig b/configs/qnap-ts433-rk3568_defconfig
index e29232339806..e36f7b8037a6 100644
--- a/configs/qnap-ts433-rk3568_defconfig
+++ b/configs/qnap-ts433-rk3568_defconfig
@@ -29,7 +29,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_PMIC=y
diff --git a/configs/rockpro64-rk3399_defconfig b/configs/rockpro64-rk3399_defconfig
index 24b81f794c36..6a42aeadb610 100644
--- a/configs/rockpro64-rk3399_defconfig
+++ b/configs/rockpro64-rk3399_defconfig
@@ -33,6 +33,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 # CONFIG_CMD_SETEXPR is not set
 CONFIG_CMD_TIME=y
diff --git a/configs/sheevaplug_defconfig b/configs/sheevaplug_defconfig
index e26f8c0a9617..8efe405d98a8 100644
--- a/configs/sheevaplug_defconfig
+++ b/configs/sheevaplug_defconfig
@@ -31,7 +31,7 @@ CONFIG_SYS_MAXARGS=32
 # CONFIG_CMD_XIMG is not set
 CONFIG_CMD_MMC=y
 CONFIG_CMD_NAND=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_MTDPARTS=y
 CONFIG_MTDIDS_DEFAULT="nand0=orion_nand"
diff --git a/configs/synquacer_developerbox_defconfig b/configs/synquacer_developerbox_defconfig
index 26c00ef594d5..27d4ef1121e1 100644
--- a/configs/synquacer_developerbox_defconfig
+++ b/configs/synquacer_developerbox_defconfig
@@ -33,7 +33,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_DHCP=y
diff --git a/configs/tbs2910_defconfig b/configs/tbs2910_defconfig
index ef7d5ca3e2ce..5236aff54da2 100644
--- a/configs/tbs2910_defconfig
+++ b/configs/tbs2910_defconfig
@@ -47,7 +47,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PART=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_USB_MASS_STORAGE=y
 CONFIG_CMD_DHCP=y
diff --git a/configs/turing-rk1-rk3588_defconfig b/configs/turing-rk1-rk3588_defconfig
index 999d9088bf84..18caf12686a1 100644
--- a/configs/turing-rk1-rk3588_defconfig
+++ b/configs/turing-rk1-rk3588_defconfig
@@ -29,6 +29,7 @@ CONFIG_CMD_GPT=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_PCI=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_ROCKUSB=y
 # CONFIG_CMD_SETEXPR is not set
diff --git a/configs/turris_mox_defconfig b/configs/turris_mox_defconfig
index 7ecab30b624e..ef848c134271 100644
--- a/configs/turris_mox_defconfig
+++ b/configs/turris_mox_defconfig
@@ -39,7 +39,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
diff --git a/configs/turris_omnia_defconfig b/configs/turris_omnia_defconfig
index de39e19ec6df..c1f5c1177fad 100644
--- a/configs/turris_omnia_defconfig
+++ b/configs/turris_omnia_defconfig
@@ -70,7 +70,7 @@ CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_CMD_SPI=y
 CONFIG_CMD_USB=y
 CONFIG_CMD_WDT=y
diff --git a/configs/udoo_defconfig b/configs/udoo_defconfig
index db0d9e2c789c..a17f4b0a0b09 100644
--- a/configs/udoo_defconfig
+++ b/configs/udoo_defconfig
@@ -31,7 +31,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_MMC=y
 # CONFIG_CMD_PINMUX is not set
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 # CONFIG_CMD_SCSI is not set
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_EXT4_WRITE=y
diff --git a/configs/vexpress_aemv8a_juno_defconfig b/configs/vexpress_aemv8a_juno_defconfig
index 7ac70edc2ea4..5cb2f328bb96 100644
--- a/configs/vexpress_aemv8a_juno_defconfig
+++ b/configs/vexpress_aemv8a_juno_defconfig
@@ -22,7 +22,7 @@ CONFIG_SYS_PROMPT="VExpress64# "
 CONFIG_CMD_MEMTEST=y
 CONFIG_CMD_ARMFLASH=y
 CONFIG_CMD_PCI=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 CONFIG_BOOTP_BOOTFILESIZE=y
 CONFIG_CMD_CACHE=y
 CONFIG_CMD_UBI=y
diff --git a/configs/wandboard_defconfig b/configs/wandboard_defconfig
index 06f8f1ec4d2b..e29f0c51d7e5 100644
--- a/configs/wandboard_defconfig
+++ b/configs/wandboard_defconfig
@@ -42,7 +42,7 @@ CONFIG_SYS_MAXARGS=32
 CONFIG_CMD_GPIO=y
 CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
-CONFIG_CMD_SATA=y
+CONFIG_SATA=y
 # CONFIG_CMD_SCSI is not set
 CONFIG_CMD_USB=y
 CONFIG_CMD_BMP=y
diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
index 1e0728fa4f3f..72a4668b448b 100644
--- a/configs/xilinx_zynqmp_kria_defconfig
+++ b/configs/xilinx_zynqmp_kria_defconfig
@@ -78,6 +78,7 @@ CONFIG_CMD_I2C=y
 CONFIG_CMD_MMC=y
 CONFIG_CMD_MTD=y
 CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
diff --git a/configs/xilinx_zynqmp_virt_defconfig b/configs/xilinx_zynqmp_virt_defconfig
index a00000be2247..1433b63979ae 100644
--- a/configs/xilinx_zynqmp_virt_defconfig
+++ b/configs/xilinx_zynqmp_virt_defconfig
@@ -79,6 +79,7 @@ CONFIG_CMD_MTD=y
 CONFIG_CMD_NAND_LOCK_UNLOCK=y
 CONFIG_CMD_PCI=y
 CONFIG_CMD_POWEROFF=y
+# CONFIG_CMD_SATA is not set
 CONFIG_CMD_SDRAM=y
 CONFIG_CMD_SF_TEST=y
 CONFIG_CMD_SPI=y
-- 
2.43.0

