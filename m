Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0073105F7AC
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 14:00:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D243784314;
	Fri, 13 Mar 2026 14:59:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="nUBZK1Fk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D47C8431E; Fri, 13 Mar 2026 14:59:32 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E35684319
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 14:59:29 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TcHNo0/gIwXV2vY7Ky0AJXD1DWIiKKLEhNQFTkDQmq49MYHb/kGV3pyp4nnAK6s8ggyJ0WpH94MVOtQXjhpV8TbsEU5QrCfR6RyIPm2LDXo9/9AHm/hZo0AGf9fFBcTyd2qMHlqZSGApdgNowRDzMN7nN/rXzKyQLP25Rerx13cunUm6NCNuV5ZEqrPjmG772ipM4UJFoLSOBkP/ammVNAT3el5cCFu023NapKd+RySokSXGRUAy/jMjsSbHBl1mECOD2fvZjua4A50UNoMt6horFNg2xEwgM05hzE7vnWmHIxhPTPiI9bpsPmGROOw+oibZU8O3GtPuMygpcsOHsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KsbMbQ5m4Y13RBWZC47HOPETP8EASDnqOOjhLQrar64=;
 b=eQOCUBs7icBTEU0JZFw43jMqr4y04Fp5FSk/y80AxrWjZSP2jUzffJ1VHxMHEiiBDdHQ8ai9P6njdzNww1u0qVdyRNhwBArhVC/A6Fi46HruJeRD5GcRrWkwXLPX/yM1xTrVgczxeEEH765RRgvycgWqDy0nPNwI3W8MODv03y56a58+A6wE78YWkIzBAI2MQjI/0iKHsZElOHGEa6KKWP3pEN1fykfnc1X6ZfbY361Ko62KIIrovEj7G2yjHQo4FsFVobjMP7bxq7XyYNhnFjdIcbLJP2edy9z0mLdlPN7VV74Pf8H0Cd4wcoCqtJaTuaeM+yLpsaWVvmKpIqAKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KsbMbQ5m4Y13RBWZC47HOPETP8EASDnqOOjhLQrar64=;
 b=nUBZK1FkM5obzApuTs+kaVAeQSwKOg7FxD8yC3aArndCtB8Nh6Xv5C7tIYTe20qKz/3gSFHSOBVhGJ4TppI2dbKnyulPCK/JRaHWFoCFVSuK8zJ9rFZ/oSqKPfwYX0FOHC/TnM+SLCegIQNkXMV747VWh+OfGVN1CasFoyrB/7s=
Received: from BN9PR03CA0963.namprd03.prod.outlook.com (2603:10b6:408:109::8)
 by CH0PR10MB7439.namprd10.prod.outlook.com (2603:10b6:610:189::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.17; Fri, 13 Mar
 2026 13:59:23 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:408:109:cafe::42) by BN9PR03CA0963.outlook.office365.com
 (2603:10b6:408:109::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.16 via Frontend Transport; Fri,
 13 Mar 2026 13:59:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 13:59:21 +0000
Received: from DFLE207.ent.ti.com (10.64.6.65) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:18 -0500
Received: from DFLE215.ent.ti.com (10.64.6.73) by DFLE207.ent.ti.com
 (10.64.6.65) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 13 Mar
 2026 08:59:18 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE215.ent.ti.com
 (10.64.6.73) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 13 Mar 2026 08:59:18 -0500
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [10.24.53.104])
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62DDx6Ja638000;
 Fri, 13 Mar 2026 08:59:16 -0500
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <a-kumar2@ti.com>
Subject: [RFC PATCH 04/19] ram: k3-ddrss: Add exit retention support
Date: Fri, 13 Mar 2026 19:28:45 +0530
Message-ID: <20260313135900.3430264-5-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313135900.3430264-1-p-mantena@ti.com>
References: <20260313135900.3430264-1-p-mantena@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|CH0PR10MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: a0867d7c-5731-4aa8-6871-08de8108ba34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18082099003|56012099003|22082099003|18002099003|18092099006;
X-Microsoft-Antispam-Message-Info: apFZYzzDRMn/9npn8WwIsPjvMQQHWhimlcB4vF7YCn+Wgb80fJX+Fw44lBrksGsioxvGhvB3fOR+cbilSwFDXN02upIO4wpjupCUIjv4DPy4Mwy3I0vtV1Wr7M+QY8W+7+vGrfaHaBTWi/zmeMGJFB1ur62VxBRFNjcpou9VIQTYffDhg066UtKbR9DHymsjPQXJp9FxsLYGz8pVokek5XPyeSraUL48zpRTNjAbTHOT7LxlzF1pcdN+5YoIn9miH2cQoVp8bnOMvDIwmpfqBPzEqwsinOFAAtj04n6/sn89MZ/r7Bt3QRVmVwnUt/vnCtGWrAGWlJ6mCdW11QUH1plmsWe07xTS8bc1VAk5R6z+QrI276y18w3EAD2aMeYB+yfmT0Oso3ON/cf5CfOP1nsswj6PHr41kxGmCJ1Nj4qwsSSAYeebgzFbmuR+EZdE+L4cuhvsHtbIQXDEEPJ+qiWWfoCHngH4Elp2VTNWzKP/8JCCcfe6dpZv1j2KU0J+59gN6KQzcW7UolQ4HT2tBj7gn0p1BtF9uQzKvcxwU+eVCzxVK+/USTK8pBOmG8lfklcb4uLGAEG7UYeuPYma/QkJg9XH1XBidY6lzUEVyHAYSQnEKUlzVecx0DG/ni/hhlVSyA42GvSbN+d+v7tvYwvWPRdoZAOc6rL9X2GeltYQ4V7jBZxaN0YJWhUDbk+1pVUL5EkKnpVKFZWFIgUTmw==
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18082099003)(56012099003)(22082099003)(18002099003)(18092099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0iyoDDKO1ihX9tNBenHZ3IjO9lN6npc6aG2hV0v1D7+ZkEPdgmjqXgg3cjpWJM4aq6IGLa4bWUq0faDOeblrIMkpdV3As8uO2MEKvXDDaazOcimiywaxkmfZDDABgsZLc/P/GhDSrXj0i7XX0yUQGQfiu0V6+iIaDE5qKcTCLB5R38kDQiBCgUMhfVZS9URDPX9BXDUbGmyW0hwxTqjIkGyLZ2qAiv3cG0ZlIDATjmw+ceOnNkC39u3/wfDVVg1StEncWzSLVH0dztQz7dE5Az/SUn4Jp0s31YcGta40DIQ2vZptTitogv1PXQPEKAttXPP6s+jT0o5D7xjXVJc3Xd3Sd0UYO4vKEMUdZn4rBLVTMSG2eA9EvM4SsOOY/xM4qpOMfLrEhpkiJ2x+UnT/8oARYg03h53T2A+awtDHCikiwkPiMYdo+J0QAk/lUN1w
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 13:59:21.5732 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0867d7c-5731-4aa8-6871-08de8108ba34
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7439
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

From: Thomas Richard <thomas.richard@bootlin.com>

Add functions that implements retention exit sequence of DDR.

Typical DDR resume sequence is:
- exit DDR from retention
- de-assert the DDR_RET pin
- restore DDR max frequency
- exit DDR from low power

We have to separate each action in order to de-assert the DDR_RET pins
at the right time, because the DDR_RET pins are all tied together
in hardware.
Additional interleaving to be taken care and configuring of PMIC differs
device to device depending on number of PMIC.

Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Prasanth Babu Mantena <p-mantena@ti.com>
---
 arch/arm/mach-k3/include/mach/k3-ddr.h |  16 ++
 drivers/ram/k3-ddrss/k3-ddrss.c        | 253 +++++++++++++++++++++++++
 drivers/ram/k3-ddrss/lpddr4_k3_reg.h   | 120 ++++++++++++
 3 files changed, 389 insertions(+)
 create mode 100644 drivers/ram/k3-ddrss/lpddr4_k3_reg.h

diff --git a/arch/arm/mach-k3/include/mach/k3-ddr.h b/arch/arm/mach-k3/include/mach/k3-ddr.h
index 6ac7f682fb8..5dd4025bdbb 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -7,6 +7,7 @@
 #define _K3_DDR_H_
 
 #include <spl.h>
+#include <compiler.h>
 
 /* We need 4 extra entries for:
  * 1. SoC peripherals
@@ -17,10 +18,25 @@
 #define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 4)
 #define K3_MEM_MAP_FIRST_BANK_IDX	3
 
+struct k3_ddrss_regs {
+	u32 ctl_141;
+	u32 phy_1305;
+	u32 ctl_88;
+	u32 pi_134;
+	u32 pi_7;
+	u32 ctl_20;
+	u32 wdqlvl_f1;
+	u32 wdqlvl_f2;
+};
+
 int dram_init(void);
 int dram_init_banksize(void);
 
 void fixup_ddr_driver_for_ecc(struct spl_image_info *spl_image);
 void fixup_memory_node(struct spl_image_info *spl_image);
 
+/* LPDDR4 power management functions */
+void k3_ddrss_lpddr4_exit_retention(struct udevice *dev, struct k3_ddrss_regs *regs);
+void k3_ddrss_lpddr4_change_freq(struct udevice *dev);
+void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev, struct k3_ddrss_regs *regs);
 #endif /* _K3_DDR_H_ */
diff --git a/drivers/ram/k3-ddrss/k3-ddrss.c b/drivers/ram/k3-ddrss/k3-ddrss.c
index 5144470b931..140bd7678bb 100644
--- a/drivers/ram/k3-ddrss/k3-ddrss.c
+++ b/drivers/ram/k3-ddrss/k3-ddrss.c
@@ -19,11 +19,13 @@
 #include <power-domain.h>
 #include <wait_bit.h>
 #include <power/regulator.h>
+#include <mach/k3-ddr.h>
 
 #include "lpddr4_obj_if.h"
 #include "lpddr4_if.h"
 #include "lpddr4_structs_if.h"
 #include "lpddr4_ctl_regs.h"
+#include "lpddr4_k3_reg.h"
 
 #define SRAM_MAX 512
 
@@ -438,6 +440,257 @@ static int k3_ddrss_ofdata_to_priv(struct udevice *dev)
 	return ret;
 }
 
+#if defined(CONFIG_K3_J721E_DDRSS)
+
+void k3_ddrss_lpddr4_exit_retention(struct udevice *dev,
+				    struct k3_ddrss_regs *regs)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval;
+	unsigned int pll_ctrl;
+	volatile unsigned int val;
+
+	/*
+	 * Saving registers
+	 */
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
+	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_134, &regs->pi_134);
+	// PI_139 cannot be restored
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_20, &regs->ctl_20);
+
+	/* disable auto entry / exit */
+	lpddr4_k3_clr_ctl(ddrss, DENALI_CTL_141, (0xF << 24) | (0xF << 16));
+
+	/* Configure DFI Interface, DDR retention exit occurs through PHY */
+	lpddr4_k3_readreg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, &regval);
+	regval &= ~0xF0F; // Set DFI_Input_1 = 0
+	regval |= 0x01;   // Set DFI Input_0 = 1
+	lpddr4_k3_writereg_phy(ddrss, LPDDR4__PHY_SET_DFI_INPUT_0__REG, regval);
+
+	/* PWRUP_SREFRESH_EXIT = 1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__PWRUP_SREFRESH_EXIT__REG, 0x1);
+
+	/* PI_PWRUP_SREFRESH_EXIT = 0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_PWRUP_SREFRESH_EXIT__REG, 0x1 << 16);
+
+	/* PI_DRAM_INIT_EN = 0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_DRAM_INIT_EN__REG, 0x1 << 8);
+
+	/* PI_DFI_PHYMSTR_STATE_SEL_R = 1  (force memory into self-refresh) */
+	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_DFI_PHYMSTR_STATE_SEL_R__REG, (1 << 24));
+
+	/*  PHY_INDEP_INIT_MODE = 0 */
+	lpddr4_k3_clr_ctl(ddrss, LPDDR4__PHY_INDEP_INIT_MODE__REG, (0x1 << 16));
+
+	/* PHY_INDEP_TRAIN_MODE = 1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__PHY_INDEP_TRAIN_MODE__REG, 0x1);
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG, &regs->wdqlvl_f1);
+	regs->wdqlvl_f1 &= LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_MASK;
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG, &regs->wdqlvl_f2);
+	regs->wdqlvl_f2 &= LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_MASK;
+
+	/* clear periodic WDQLVL for F0 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F0__REG,
+			0x2 << LPDDR4__DENALI_PI_212__PI_WDQLVL_EN_F0_SHIFT);
+
+	/* clear periodic WDQLVL for F1 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F1__REG,
+			0x2 << LPDDR4__DENALI_PI_214__PI_WDQLVL_EN_F1_SHIFT);
+
+	/* clear periodic WDQLVL for F2 */
+	lpddr4_k3_clr_pi(ddrss, LPDDR4__PI_WDQLVL_EN_F2__REG,
+			0x2 << LPDDR4__DENALI_PI_217__PI_WDQLVL_EN_F2_SHIFT);
+
+#define PLL_CTRL_OFF 0x20
+#define PLL_CFG 0x00680000
+	switch (ddrss->instance) {
+	case 0:
+		pll_ctrl = PLL_CFG + 12 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 1:
+		pll_ctrl = PLL_CFG + 26 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 2:
+		pll_ctrl = PLL_CFG + 27 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	case 3:
+		pll_ctrl = PLL_CFG + 28 * 0x1000 + PLL_CTRL_OFF;
+		break;
+	}
+
+	*(unsigned int *)pll_ctrl |= 0x80000000;
+	val = *(volatile unsigned int *)pll_ctrl;
+	if ((val & 0x80000000) != 0x80000000)
+		val = *(volatile unsigned int *)pll_ctrl;
+}
+
+void k3_ddrss_lpddr4_change_freq(struct udevice *dev)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval;
+	unsigned long tmo;
+
+	/* PI_START=1 */
+	lpddr4_k3_set_pi(ddrss, LPDDR4__PI_START__REG, 0x01);
+	/* START=1 */
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__START__REG, 0x01);
+
+	k3_lpddr4_freq_update(ddrss);
+
+	tmo = timer_get_us() + 100000;
+	do {
+		lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 0)) == 0x00);
+
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (1 << 9)) == 0x00);
+
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_INT_STATUS__REG, &regval);
+	debug("%s: PI interrupt status: 0x%08x\n", __func__, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+	debug("%s: Controller interrupt status: 0x%08x\n", __func__, regval);
+
+	debug("%s: Successfully exited Retention\n", __func__);
+}
+
+void k3_ddrss_lpddr4_exit_low_power(struct udevice *dev,
+				    struct k3_ddrss_regs *regs)
+{
+	struct k3_ddrss_desc *ddrss = dev_get_priv(dev);
+	u32 regval, fspop, fspwr;
+	unsigned long tmo;
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/* make sure that LP flag is clear before going through this process */
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, &regval);
+	regval &= ~(0x7F << 24);
+	regval |= (0x2 << 24); // set low power mode exit
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__CKSRX_F1__REG, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/* wait until low power operation has been completed */
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__INT_STATUS_0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & (0x1 << 10)) == 0);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	lpddr4_k3_writereg_ctl(ddrss, LPDDR4__INT_ACK_0__REG, (0x1 << 10));
+
+	/*
+	 * bit 6 / 14 -- lp_state valid
+	 * bits 13:8 / 5:0 0x0F SRPD Long with Mem and Controller Clk Gating
+	 */
+	tmo = timer_get_us() + 4000;
+	do {
+		lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+		if (timer_get_us() > tmo) {
+			printf("%s:%d timeout error\n", __func__, __LINE__);
+			hang();
+		}
+	} while ((regval & 0x4F4F) != 0x4040);
+
+	lpddr4_k3_readreg_ctl(ddrss, LPDDR4__LP_STATE_CS0__REG, &regval);
+	debug("%s: LP State: 0x%08x\n", __func__, regval);
+
+	/*
+	 * MR13 data within the PI is based upon CS but NOT based upon
+	 * frequency set point.
+	 * MR13 is the current MR13 value
+	 */
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_MR13_DATA_0__REG, &regval);
+	fspop = (regval & ((u32)1 << 31)) >> 31;
+	fspwr = (regval & ((u32)1 << 30)) >> 30;
+
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_OP_CURRENT__REG,
+			 fspop << LPDDR4__DENALI_CTL_192__FSP_OP_CURRENT_SHIFT);
+
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_WR_CURRENT__REG,
+			 fspwr << LPDDR4__DENALI_CTL_192__FSP_WR_CURRENT_SHIFT);
+
+	// do not allow CTL to update MR
+	lpddr4_k3_set_ctl(ddrss, LPDDR4__FSP_PHY_UPDATE_MRW__REG,
+			 1 << LPDDR4__DENALI_CTL_191__FSP_PHY_UPDATE_MRW_SHIFT);
+
+	// do not allow PI to update MR
+	lpddr4_k3_clr_pi(ddrss, DENALI_PI_64, 1 << 0);
+
+	// PI_FREQ_MAP defines supported working frequencies
+	lpddr4_k3_readreg_pi(ddrss, LPDDR4__PI_FREQ_MAP__REG, &regval);
+	if (regval & (0x1 << 1)) {
+		// define FSP0 and FSP1 as trained
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
+				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F1__REG,
+				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F1_MASK);
+	}
+	if (regval & (0x1 << 2)) {
+		// define FSP0 and FSP2 as trained
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F0__REG,
+				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F0_MASK);
+		lpddr4_k3_set_ctl(ddrss, LPDDR4__MR_FSP_DATA_VALID_F2__REG,
+				 LPDDR4__DENALI_CTL_190__MR_FSP_DATA_VALID_F2_MASK);
+	}
+
+	/*
+	 * Restore registers
+	 */
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_141, regs->ctl_141);
+	lpddr4_k3_writereg_phy(ddrss, DENALI_PHY_1305, regs->phy_1305);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_88, regs->ctl_88);
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_134, regs->pi_134);
+	// PI_139 cannot be restored
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_7, regs->pi_7);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_20, regs->ctl_20);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_141, &regs->ctl_141);
+	lpddr4_k3_readreg_phy(ddrss, DENALI_PHY_1305, &regs->phy_1305);
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_88, &regs->ctl_88);
+	// PI_139 cannot be restored
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_7, &regs->pi_7);
+
+	lpddr4_k3_readreg_pi(ddrss, DENALI_PI_79, &regval);
+	lpddr4_k3_writereg_pi(ddrss, DENALI_PI_80, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_293, &regval);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_295, regval);
+
+	lpddr4_k3_readreg_ctl(ddrss, DENALI_CTL_294, &regval);
+	lpddr4_k3_writereg_ctl(ddrss, DENALI_CTL_296, regval);
+
+	lpddr4_k3_set_pi(ddrss, DENALI_PI_214, regs->wdqlvl_f1);
+	lpddr4_k3_set_pi(ddrss, DENALI_PI_217, regs->wdqlvl_f2);
+}
+#endif /* CONFIG_K3_J721E_DDRSS */
+
 void k3_lpddr4_probe(struct k3_ddrss_desc *ddrss)
 {
 	u32 status = 0U;
diff --git a/drivers/ram/k3-ddrss/lpddr4_k3_reg.h b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
new file mode 100644
index 00000000000..ba8e8b619fb
--- /dev/null
+++ b/drivers/ram/k3-ddrss/lpddr4_k3_reg.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: BSD-3-Clause */
+/*
+ * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.com/
+ */
+
+#ifndef LPDDR4_K3_REG
+#define LPDDR4_K3_REG
+
+#define lpddr4_k3_readreg_ctl(ddrss, reg, pt) do {	\
+		u16 offset = 0U;					\
+		u32 result = 0U;					\
+		TH_OFFSET_FROM_REG(reg, CTL_SHIFT, offset);			\
+		result = ddrss->driverdt->readctlconfig(&ddrss->pd, pt, (u16 *)(&offset), 1); \
+		if (result > 0U) {					\
+			printf("%s: Failed to read %s\n", __func__, xstr(reg));	\
+			hang();						\
+		}			\
+	} while (0)
+
+#define lpddr4_k3_readreg_pi(ddrss, reg, pt) do {	\
+		u16 offset = 0U;					\
+		u32 result = 0U;					\
+		TH_OFFSET_FROM_REG(reg, PI_SHIFT, offset);			\
+		result = ddrss->driverdt->readphyindepconfig(&ddrss->pd, pt, (u16 *)(&offset), 1); \
+		if (result > 0U) {					\
+			printf("%s: Failed to read %s\n", __func__, xstr(reg));	\
+			hang();						\
+		}			\
+	} while (0)
+
+#define lpddr4_k3_readreg_phy(ddrss, reg, pt) do {	\
+		u16 offset = 0U;					\
+		u32 result = 0U;					\
+		TH_OFFSET_FROM_REG(reg, PHY_SHIFT, offset);			\
+		result = ddrss->driverdt->readphyconfig(&ddrss->pd, pt, (u16 *)(&offset), 1); \
+		if (result > 0U) {					\
+			printf("%s: Failed to read %s\n", __func__, xstr(reg));	\
+			hang();						\
+		}			\
+	} while (0)
+
+#define lpddr4_k3_writereg_ctl(ddrss, reg, value)  do {	\
+		u16 offset = 0U;					\
+		u32 result = 0U;					\
+		u32 writeval = value;					\
+		TH_OFFSET_FROM_REG(reg, CTL_SHIFT, offset);			\
+		result = ddrss->driverdt->writectlconfig(&ddrss->pd, &writeval, (u16 *)(&offset), 1); \
+		if (result > 0U) {					\
+			printf("%s: Failed to write %s\n", __func__, xstr(reg)); \
+			hang();						\
+		}		\
+	} while (0)
+
+#define lpddr4_k3_writereg_pi(ddrss, reg, value)  do {	\
+		u16 offset = 0U;					\
+		u32 result = 0U;					\
+		u32 writeval = value;					\
+		TH_OFFSET_FROM_REG(reg, PI_SHIFT, offset);			\
+		result = ddrss->driverdt->writephyindepconfig(&ddrss->pd, &writeval, (u16 *)(&offset), 1); \
+		if (result > 0U) {					\
+			printf("%s: Failed to write %s\n", __func__, xstr(reg)); \
+			hang();						\
+		}		\
+	} while (0)
+
+#define lpddr4_k3_writereg_phy(ddrss, reg, value) do {	\
+		u16 offset = 0U;					\
+		u32 result = 0U;					\
+		u32 writeval = value;					\
+		TH_OFFSET_FROM_REG(reg, PHY_SHIFT, offset);			\
+		result = ddrss->driverdt->writephyconfig(&ddrss->pd, &writeval, (u16 *)(&offset), 1); \
+		if (result > 0U) {					\
+			printf("%s: Failed to write %s\n", __func__, xstr(reg)); \
+			hang();						\
+		}		\
+	} while (0)
+
+#define lpddr4_k3_set_ctl(k3_ddrss, reg, mask) do {	\
+	u32 val;					\
+	lpddr4_k3_readreg_ctl(ddrss, reg, &val);		\
+	val |= mask;					\
+	lpddr4_k3_writereg_ctl(ddrss, reg, val);		\
+	} while (0)
+
+#define lpddr4_k3_clr_ctl(k3_ddrss, reg, mask) do {		\
+		u32 val;					\
+		lpddr4_k3_readreg_ctl(ddrss, reg, &val);		\
+		val &= ~(mask);					\
+		lpddr4_k3_writereg_ctl(ddrss, reg, val);		\
+	} while (0)
+
+#define lpddr4_k3_set_pi(k3_ddrss, reg, mask) do {		\
+		u32 val;					\
+		lpddr4_k3_readreg_pi(ddrss, reg, &val);		\
+		val |= mask;					\
+		lpddr4_k3_writereg_pi(ddrss, reg, val);		\
+	} while (0)
+
+#define lpddr4_k3_clr_pi(k3_ddrss, reg, mask) do {		\
+		u32 val;					\
+		lpddr4_k3_readreg_pi(ddrss, reg, &val);		\
+		val &= ~(mask);					\
+		lpddr4_k3_writereg_pi(ddrss, reg, val);		\
+	} while (0)
+
+#define lpddr4_k3_set_phy(ddrss, reg, mask) do {		\
+	u32 val;					\
+	lpddr4_k3_readreg_phy(ddrss, reg, &val);		\
+	val |= mask;					\
+	lpddr4_k3_writereg_phy(ddrss, reg, val);		\
+	} while (0)
+
+#define lpddr4_k3_clr_phy(ddrss, reg, mask) do {		\
+	u32 val;					\
+	lpddr4_k3_readreg_phy(ddrss, reg, &val);		\
+	val &= ~(mask);					\
+	lpddr4_k3_writereg_phy(ddrss, reg, val);		\
+	} while (0)
+
+#endif  /* LPDDR4_K3_REG */
-- 
2.34.1

