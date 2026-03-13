Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C566105F7AF
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B56684370;
	Fri, 13 Mar 2026 14:59:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="grlovX58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3107784382; Fri, 13 Mar 2026 14:59:51 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 44ECC84358
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wU6DwYXhRP0UiGJKIgR++Vy89d8+sCsi4OTB0AKtEq2JMlDgu7lDvRCmb843UXKP5FPTC1jc+jC8HGZZPn32f5kZZ1Z61zPNuNKzbgJBsr5+z0H5kMvFjwbHiIOCGzNu5KE7EWAXd3katp0LY3OBacP/6aee1RgV9ddeyGwCM3QJjreARb9HZ1zqZkYtizV5tAYLMLWzPw2uwVRiC9x7o4oIU5uQBwjXGoByd5Oi0jhfNJrN8DS5S3aM1UBwxa+OIa9BcpSeyCwjpgytEKoNYHQlVE3c6MG3l+qPqMwLGe/CbE53GcJyO7FbjGyG0mCCrakByIXf7UutiiP1N6ytBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pCHzFZDEDnOPG8cjWqQp+AfN+4g1qotBr+46SDVUG/c=;
 b=u7q8n8hBbarZofZeaWiuAla8uoSfKeJRo9VFGBeGH35OiCTMYmVQLKRLAZbt1IiKIOpFrFd8bssCup38lwsNdpRgEB2pOXVEADHhnM3lY79mRc60AZ0/qdxqOdvpmazpSmOiiMHodm693CJ6i1fTaBjaRqZmAi2kZGVNobnWLt8vl49ktns/D4OMjF/dTAT/hRJh4A8651IgJJO6gehh1/QYVQAAL+/p2vyPmji4k2hQsP8N3896HUrbF7yYv5hGyYOuAyDkKPj3dPGWiyd3NW+rdKvD+RrkEjN0IZJ0rjjZqk9VldPFIMbRbYlCuuvzI/XKQHkRQmYpYElxTyPZyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pCHzFZDEDnOPG8cjWqQp+AfN+4g1qotBr+46SDVUG/c=;
 b=grlovX586+5AkVyob9ynFwqn75M+G26B2DGtDITfgu2ZdmxjASrl/Y9HR6uIxitv2MDdWEXIDeX+SWeMNUCQdsxaYUMMu8szr0mzGhMpKezmIZqc07K/Vyio3BrzTLVKnylTSpV6u17Ywa2tHi8RmPS7HOzqBtl2lyJVAyQ81/k=
Received: from BN1PR14CA0009.namprd14.prod.outlook.com (2603:10b6:408:e3::14)
 by MN0PR10MB5958.namprd10.prod.outlook.com (2603:10b6:208:3ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 13:59:45 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:408:e3:cafe::7d) by BN1PR14CA0009.outlook.office365.com
 (2603:10b6:408:e3::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Fri,
 13 Mar 2026 13:59:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:43 +0000
Received: from DFLE206.ent.ti.com (10.64.6.64) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:39 -0500
Received: from DFLE211.ent.ti.com (10.64.6.69) by DFLE206.ent.ti.com
 (10.64.6.64) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:39 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE211.ent.ti.com
 (10.64.6.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:39 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Jj638000;
 Fri, 13 Mar 2026 08:59:37 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 13/19] board: ti: evm: Store wakeup reason on scratchpad
 memory
Date: Fri, 13 Mar 2026 19:28:54 +0530
Message-ID: <20260313135900.3430264-14-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|MN0PR10MB5958:EE_
X-MS-Office365-Filtering-Correlation-Id: a1e38fcc-f929-47ad-dc1a-08de8108c772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|376014|82310400026|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eZit09dKIBU/bXdkbceuhuBINZUCbzym/hFdVi0WF5DOPZaRUbr9DxDYDb5nboec2waN6qPP9N8S4LmsUkV8Dtj4FkzPnaZy4Z/3vjdLu6M3/NqEKTxKqHlnUocVowrKrxv63hLcTSyZMLHqkMh3cR7y3sG9rFUYJWyLumgklBQpYEe3x/BpOpWlZRmD/gqW3CbaRKsw+HCTlw+KSiEaWcEKOYyklBHYAR0y/WATPLewAoeGEP0cRtLE+MC0DxXEowaMswKBYbuglSTy9w0AKW56QeWegQ3O4ro0Xn2MyW7I3DAx3Wayept3FZsmVhBSSKHH1xLyFoQpYQt47/oTu2Ia+xxfUs60QqvBw9gHOwBG/LZdJih+2UEeHdO18WsSZJN7BSVxwxA6kcYkiM3HRQ0jiZDHL6kuQU89Fbss2HnWVz8suPNSlP9c81U44lkSrEOECaH6l/XI1SJs2pf6Nk9Bik82XlKBye+rO8Z4FjrayH6vX/PyYyMsIFZJmkWRWnshU7bWcjXwIzoEnjNBX36sknf3IGbtr+eG49nHP/npGQVPLHfreOpdbIN3vntU3v0Vmi0b8kqKYPEzkLPTPFpbvK28c+39CDP3DNTTH8jGsqJgnSPYzoU0fgM9VaCAHpU+e30RsfR/8SIR+1RRhWIqWWxZCfxz1NalO6OAOGEKhoeOUoDCWhjRPd+sEu+8IXUUCarHX1bODnzyd8M/qBtcqfIKMJRsYsvSE5nqehcsKI/OrD5/jlDH9aS4E55U3Eh/9fu+BIDnGoG1uAOZMw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fqNmuukZovq6BcRSAtO2ORu2c65KWNE+nNYpcwuC4P7bgw0kNi0gsb13UvpOaOICFkNF/WPr2eIxlX9P+N43sI3KLmHb1oIyNKobmGbK2RUGUO1noDOxdmg58ORqDgfINFp/GSpICX01RzDKYhJmt+5Vf6KqszxFD0cOZ/JwbrZJ2xUWoAaWPuRVGKEfp5nSZvx9WvEYhKTCkCIvu0IvANOiKdR/hmhxoV9NE/J7efnAgsJ+BOmpxOrevBgWN5ef0sUQ0prJajJjU/YWVwh36wW2xIkBnzQS+4qzpMs1BzgzrsRKf4I/zm+MH3gZukyKTjuJu1/BjAsIPLSJ3qmA2mRKaWA7R+UGVML17f3l7fKagzSxWU35BB1EfwO2xpBtn35LnHC1P00I1YzkR0WD7Kmije0ad5l/q6EF06CGFZ/ohLyiz/6lcrPsP4wSehFm
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:43.7963 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1e38fcc-f929-47ad-dc1a-08de8108c772
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5958
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

From: Abhash Kumar Jha <a-kumar2@ti.com>

While resuming from suspend, the wakeup reason need to be stored
and this will be used by the linux kernel once its up.

Use the 32 bytes of MCU_PSRAM0_RAM area (addr = 0x40280000) to
store the wakeup reason.

Read the value as soon as it starts and store it internally.

Signed-off-by: Abhash Kumar Jha <a-kumar2@ti.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/include/mach/j721e_hardware.h  | 9 +++++++++
 arch/arm/mach-k3/include/mach/j784s4_hardware.h | 9 +++++++++
 board/ti/j721e/evm.c                            | 9 ++++++++-
 board/ti/j784s4/evm.c                           | 8 +++++++-
 4 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-k3/include/mach/j721e_hardware.h b/arch/arm/mach-k3/include/mach/j721e_hardware.h
index 587dd10eb1e..6913b992614 100644
--- a/arch/arm/mach-k3/include/mach/j721e_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j721e_hardware.h
@@ -47,6 +47,7 @@
 
 /* MCU SCRATCHPAD usage */
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
+#define TI_SRAM_SCRATCH_LPM_START    0x40280000
 
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
@@ -63,6 +64,14 @@ static const u32 put_device_ids[] = {
 #define J721E_DEV_MCU_ARMSS0_CPU0		250
 #define J721E_DEV_MCU_ARMSS0_CPU1		251
 
+struct lpm_scratch_space {
+	u16 wake_src;
+	u16 reserved;
+} __packed;
+
+#define TI_SRAM_LPM_SCRATCH ((struct lpm_scratch_space *)\
+				TI_SRAM_SCRATCH_LPM_START)
+
 static const u32 put_core_ids[] = {
 	J721E_DEV_MCU_ARMSS0_CPU1,
 	J721E_DEV_MCU_ARMSS0_CPU0,	/* Handle CPU0 after CPU1 */
diff --git a/arch/arm/mach-k3/include/mach/j784s4_hardware.h b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
index dd51473419d..6137481e8a6 100644
--- a/arch/arm/mach-k3/include/mach/j784s4_hardware.h
+++ b/arch/arm/mach-k3/include/mach/j784s4_hardware.h
@@ -46,6 +46,7 @@
 
 /* MCU SCRATCHPAD usage */
 #define TI_SRAM_SCRATCH_BOARD_EEPROM_START	CONFIG_SYS_K3_MCU_SCRATCHPAD_BASE
+#define TI_SRAM_SCRATCH_LPM_START    0x40280000
 
 #if defined(CONFIG_SYS_K3_SPL_ATF) && !defined(__ASSEMBLY__)
 
@@ -67,4 +68,12 @@ static const u32 put_core_ids[] = {
 	J784S4_DEV_MCU_ARMSS0_CPU0,     /* Handle CPU0 after CPU1 */
 };
 
+struct lpm_scratch_space {
+	u16 wake_src;
+	u16 reserved;
+} __packed;
+
+#define TI_SRAM_LPM_SCRATCH ((struct lpm_scratch_space *)\
+				TI_SRAM_SCRATCH_LPM_START)
+
 #endif /* __ASM_ARCH_J784S4_HARDWARE_H */
diff --git a/board/ti/j721e/evm.c b/board/ti/j721e/evm.c
index 368381c422a..efa4832f034 100644
--- a/board/ti/j721e/evm.c
+++ b/board/ti/j721e/evm.c
@@ -474,8 +474,10 @@ err_free_gpio:
 #if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J7200_R5_EVM))
 
 #define SCRATCH_PAD_REG_3 0xCB
-
 #define MAGIC_SUSPEND 0xBA
+#define LPM_WAKE_SOURCE_PMIC_GPIO 0x91
+#define LPM_WAKE_SOURCE_MAIN_IO   0x80
+
 static void clear_isolation(void)
 {
 	int ret;
@@ -501,12 +503,14 @@ int board_is_resuming(void)
 	struct udevice *pmica;
 	struct udevice *pmicb;
 	u32 pmctrl_val = readl(PMCTRL_IO_1);
+	struct lpm_scratch_space *lpm_scratch = (struct lpm_scratch_space *)TI_SRAM_LPM_SCRATCH;
 	int ret;
 
 	if (gd_k3_resuming() >= 0)
 		goto end;
 
 	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		lpm_scratch->wake_src = LPM_WAKE_SOURCE_MAIN_IO;
 		clear_isolation();
 		gd_set_k3_resuming(1);
 		debug("Resuming from IO_DDR mode\n");
@@ -531,6 +535,7 @@ int board_is_resuming(void)
 
 	if (pmic_reg_read(pmica, SCRATCH_PAD_REG_3) == MAGIC_SUSPEND) {
 		debug("%s: board is resuming\n", __func__);
+		lpm_scratch->wake_src = LPM_WAKE_SOURCE_PMIC_GPIO;
 		gd_set_k3_resuming(1);
 
 		/* clean magic suspend */
@@ -538,6 +543,8 @@ int board_is_resuming(void)
 			printf("Failed to clean magic value for suspend detection in PMICA\n");
 	} else {
 		debug("%s: board is booting (no resume detected)\n", __func__);
+		lpm_scratch->wake_src = 0;
+		lpm_scratch->reserved = 0;
 		gd_set_k3_resuming(0);
 	}
 end:
diff --git a/board/ti/j784s4/evm.c b/board/ti/j784s4/evm.c
index 56d5abea6a9..3fd1a00c683 100644
--- a/board/ti/j784s4/evm.c
+++ b/board/ti/j784s4/evm.c
@@ -67,8 +67,9 @@ int board_late_init(void)
 #if (IS_ENABLED(CONFIG_SPL_BUILD) && IS_ENABLED(CONFIG_TARGET_J784S4_R5_EVM))
 
 #define SCRATCH_PAD_REG_3 0xCB
-
 #define MAGIC_SUSPEND 0xBA
+#define LPM_WAKE_SOURCE_PMIC_GPIO 0x91
+#define LPM_WAKE_SOURCE_MCU_IO    0x81
 
 static void clear_isolation(void)
 {
@@ -95,12 +96,14 @@ int board_is_resuming(void)
 {
 	struct udevice *pmic;
 	u32 pmctrl_val = readl(WKUP_CTRL_MMR0_BASE + PMCTRL_IO_0);
+	struct lpm_scratch_space *lpm_scratch = (struct lpm_scratch_space *)TI_SRAM_LPM_SCRATCH;
 	int err;
 
 	if (gd_k3_resuming() >= 0)
 		goto end;
 
 	if ((pmctrl_val & IO_ISO_STATUS) == IO_ISO_STATUS) {
+		lpm_scratch->wake_src = LPM_WAKE_SOURCE_MCU_IO;
 		clear_isolation();
 		gd_set_k3_resuming(1);
 		debug("board is resuming from IO_DDR mode\n");
@@ -117,6 +120,7 @@ int board_is_resuming(void)
 
 	if (pmic_reg_read(pmic, SCRATCH_PAD_REG_3) == MAGIC_SUSPEND) {
 		debug("%s: board is resuming\n", __func__);
+		lpm_scratch->wake_src = LPM_WAKE_SOURCE_PMIC_GPIO;
 		gd_set_k3_resuming(1);
 
 		/* clean magic suspend */
@@ -124,6 +128,8 @@ int board_is_resuming(void)
 			printf("Failed to clean magic value for suspend detection in PMIC\n");
 	} else {
 		debug("%s: board is booting (no resume detected)\n", __func__);
+		lpm_scratch->wake_src = 0;
+		lpm_scratch->reserved = 0;
 		gd_set_k3_resuming(0);
 	}
 end:
-- 
2.34.1

