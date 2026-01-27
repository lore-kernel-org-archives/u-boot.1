Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81D0CD2F005
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 12:13:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 94DD383FE9;
	Tue, 27 Jan 2026 13:13:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="W/xJ327p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C135783FE9; Tue, 27 Jan 2026 13:13:07 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F50983FDE
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 13:13:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=p-mantena@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2KVKZFe6gW7B53y/+Jx5aqgrrUKwhFgnugPgPmWqGtLmoIAgOj8FmSrLU8TVJosHUyLk12EdIX37FgIvJTiNkokwZWsGd0kdI2RfjqHrFCjD9LeTRs8V0mGGcXwCbrYIUqPz7y/wuUoRJlqQSPzU4wEMWlL3hFh7dYCpqJqLl6RNJBPT7x3rF1buO2KYyQ4UVQJBRdPP/fDWaOOYUUl2YQyXGPGnSLfzz6lMiWu1MgspYmAyWTNCb8523cR1VUgeoZbZQ8JlRolM5zPdL+4N8M8wilpT0y7bJJwWHVmkMpxmokNm8DjD7+lXno2YGMKYxYfXPwtzUBbmdAOAjahuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AEg6eTMzhN79g35FukcLTBJO41MgOQp7VUGF/cAKpSo=;
 b=b/coBUFx3llPvAszP8t50rTl0u/Qk+D7inCQ1YelJwtzf+xxRezNnjTyUKugA0O1gNOMyF5EXJU+PYpbbqY5oHZNnrvdt058DuYF1A/x4sMAMlJ4eqd8gaV23yxdfpDWoNho0ND0owXa5tM6DKZd8fVt+CavjrZeu2cQrp8R9E/Tr9Knm1fRLl8bWaILtmUj6J3DqR2FGgCMemNVP2tKBGGxRG9YFDyOpE9m0tIZFqxIdjmoLwwV/aauPPjeUX5azR/aXW5cZ9J6aQlHY0GJELNvvNqSVMh6hqTTxM+TEEfJxpYKDfBfSIh1wPaWltRH70AQUwfzCUzkPy9nU2REAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=konsulko.com smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AEg6eTMzhN79g35FukcLTBJO41MgOQp7VUGF/cAKpSo=;
 b=W/xJ327p7jUDxmA6bjkgH1rsBSc4MYOMBlnTcysglCvnTD+Uu2rnIMQGWt93Bn4KPo41y4YtrFl1vXcfnZ7m41mvOaviWSyOSLHvLWdWU1ufo8jaj9MihaaVm0demkFqApBXQk+YwXt6zRc9apaTosPWMPa7fjJfirMGG148AFU=
Received: from CH0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:610:b1::16)
 by CH3PR10MB6883.namprd10.prod.outlook.com (2603:10b6:610:151::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 12:12:59 +0000
Received: from CH2PEPF0000009B.namprd02.prod.outlook.com
 (2603:10b6:610:b1:cafe::61) by CH0PR13CA0011.outlook.office365.com
 (2603:10b6:610:b1::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 12:12:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 CH2PEPF0000009B.mail.protection.outlook.com (10.167.244.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 12:12:58 +0000
Received: from DFLE210.ent.ti.com (10.64.6.68) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 06:12:57 -0600
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE210.ent.ti.com
 (10.64.6.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 06:12:57 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 27 Jan 2026 06:12:57 -0600
Received: from prasanth-server.dhcp.ti.com (prasanth-server.dhcp.ti.com
 [172.24.235.150])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 60RCCsCU136864;
 Tue, 27 Jan 2026 06:12:55 -0600
From: Prasanth Babu Mantena <p-mantena@ti.com>
To: <u-boot@lists.denx.de>, <trini@konsulko.com>, <n-francis@ti.com>
CC: <u-kumar1@ti.com>, <vigneshr@ti.com>, <m-chawdhry@ti.com>
Subject: [PATCH] ram: k3-ddrss: Add exit retention support
Date: Tue, 27 Jan 2026 17:42:53 +0530
Message-ID: <20260127121253.3011605-1-p-mantena@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009B:EE_|CH3PR10MB6883:EE_
X-MS-Office365-Filtering-Correlation-Id: a0110a89-15d0-4a8d-895f-08de5d9d68b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024|18082099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Shvp87Nbe7+8Hnwyy6lxAShn/mS3pxVaqCDgX4h5imHM2ortj3tJnE6vsnJS?=
 =?us-ascii?Q?agDj5Qi9W6U0ID/8npsqPlLmYTLJCA2K8EbAunfeec6NSNsUAJh8qNdlrNd5?=
 =?us-ascii?Q?kWUM8MAzOhWeEr6DzBVK+J03EXkbJmrWL2dtLj6dcxOGbl32Bm+Pvh9whAyQ?=
 =?us-ascii?Q?HPn/uFyZ415ZCZ1PLM5ZmeWzBG5EfPDJtqpTPrzqBvUp0HZ5BTndZN+jpZ/h?=
 =?us-ascii?Q?sRim0woLkhsxhh8vnOlK16s1DNvZe3LyynEILPuEqWUk8w3fS5HMpDrc/JiI?=
 =?us-ascii?Q?qhdMXt9KBNzuLeuDQTGLWl3LKvnjD8P6pHr7qJM31dLGzq1IonKEEi5NjzWc?=
 =?us-ascii?Q?YRVJTsEQ0sx421Fli4KyZGoxImoogBcU1Cb7bxHBBoRzLbt83ZJggkhKObhF?=
 =?us-ascii?Q?lOtI0PhqZnL16++M1+anIC8/WJVTr4okUePyiO3SvAZUo9pLaIanFgq8c84V?=
 =?us-ascii?Q?PLkjqEL5mslgSQesA8S+WboG/3BkXfEoJ8Jfh5SWf3LlTRyXe/G1fM09j3oT?=
 =?us-ascii?Q?C3ZMexkY1DpATiin4C7O/D0KkLxPKBaSYAq3hj8GP7ULa3P/payVmrODYVLh?=
 =?us-ascii?Q?/0WaJWfTAewanNi3iZc90gjlOtd4CF+B7fDIOtVl4aHkAd9IkvzOvfZM8bse?=
 =?us-ascii?Q?rI8h50pOpCztnjTAjn6QOKTO4gbdQtrgPWjkaXbNcl4JL1vxucrT87m5h5UB?=
 =?us-ascii?Q?7eyxtZXjx7SQ0xO7C15tyST7kme5bbuclt59xFBpuCe+LLlNb79jgUBlm/KZ?=
 =?us-ascii?Q?rkEw1lmfZ9Tgndj6fS9ku+MPiKj8Q2WMm0dXRKlI9KngHYAXy/lUjT2kHsNh?=
 =?us-ascii?Q?JI13cWcA1aqasClV6e7/RR/nHG6P4K03/fp+oYqBkqVvf74EUhYpce5snbrG?=
 =?us-ascii?Q?XtURUeu+ajZ7tqH/JeZzq0+gxdeGz0q9tgepY0CLLacoZX1a2U/aerC27z9p?=
 =?us-ascii?Q?gXLEESM+zc4WwMWPQtt1kGY3bKdF2O6AhPnTfU982nybhsu2pFcIuPSHT8EG?=
 =?us-ascii?Q?yuZpfdxRNs7dAkbZjWFgbzLb/X11dvPuUBnToBbAA/6SdmrEZVIycdctYCgL?=
 =?us-ascii?Q?GEQPbX6G7iIas8LgLShZamG+TOGSJi2/hRg4EsvFVYbkH3YGasMqka/z6ZrU?=
 =?us-ascii?Q?Wi5oXzFK9UdDAS+gJWC+fI+dlKpP1tnA6TsbvGEjUyx8pkJ8Yaz/0AjwMz2a?=
 =?us-ascii?Q?glYZReraLL944cJqT/8ZWzJEv3LrniiIu3q9VMY5T4ZGpBzwL1EfQ5M3c32l?=
 =?us-ascii?Q?6ntlkvdpqBdueUCZD2zAUimuM+ccDnMal35Rh/pVsy9xtFJrZaqArkqgXtdb?=
 =?us-ascii?Q?CJwB8jNhz/dZ0ezPgcYodCv6bk0cMy4cqY32lkocvSAv+Sf6F6ESbAJTGc8a?=
 =?us-ascii?Q?clMJgzhefnN2u7Qj+kYxsDMLux2wG5XidQA6lyCOmb4YtCg4RrVFQ/DXZUnC?=
 =?us-ascii?Q?ZFaRBZvEn5JvEIAwrUG4CQf9jXFLulCja5BqSimYFsLAPSundtemDrcDWAx/?=
 =?us-ascii?Q?AmEKdKmc/rh3SlA3YHw424VmDDdYU40wim6sncJAa/yT/3j1O6R1rbnc6OEF?=
 =?us-ascii?Q?uMDojjQeORkpzdzVFjnBnWnmEyrmFFtIjjEqeYv27xWJRYII41AgKhN1TYB+?=
 =?us-ascii?Q?DA=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet200.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(18082099003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 12:12:58.0061 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0110a89-15d0-4a8d-895f-08de5d9d68b3
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.194];
 Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6883
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
index 207e60b2763..c82c25ba285 100644
--- a/arch/arm/mach-k3/include/mach/k3-ddr.h
+++ b/arch/arm/mach-k3/include/mach/k3-ddr.h
@@ -7,6 +7,7 @@
 #define _K3_DDR_H_
 
 #include <spl.h>
+#include <compiler.h>
 
 /* We need 3 extra entries for:
  *   SoC peripherals, flash and the sentinel value.
@@ -14,10 +15,25 @@
 #define K3_MEM_MAP_LEN			((CONFIG_NR_DRAM_BANKS) + 3)
 #define K3_MEM_MAP_FIRST_BANK_IDX	2
 
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

