Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268F3C28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 09:13:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 65005810F2;
	Thu, 20 Mar 2025 10:13:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="STO1aTMW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5EC668129F; Thu, 20 Mar 2025 10:13:39 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::61b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 153E88003E
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 10:13:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xbIn/XGJkDDrKO+mRyoQrdAnD63mcb+hq3oyEidroPg+H+PSukmbz8Byx14595Bw78lFbtlNe/XVthRMOf0qwZzSPwyhD9nt75lnVOXrzqTzTRWdKaUqgJXUQn0X1sLqVOB0P4QL4FBQT3UCSixZdqRzNa9EEjcaGgqOpvM1GxU9dgx3g45Rg7a8QW0HSeHnsLAthWRrsN55rGWY5rGM7UV0Sg5sP2M4D1F8SdDQoav9qeAgGqh3CyNfi8mOjXxc10GH8OSZ87AEqqsYavqFKmTSVMK8ZITQ40/ihtPBWB3UdjE4EDjbQD+qzNNNDUpepmfzLV8oXGp61t5iH9PVTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=scGxqc/eWc8wT8xCEBK2J0Dg4EP9y6KHmmHQOwTNbdw=;
 b=ePVxOydpwU0d2xq+r7guDr0zmC/B/i2kx19aRRweupyjW1V0Rk5+tGKTdFjiESA0V8Glr8GIYMoZbsvxbPKOOl90arw0hisiY6tlrj1Q73GXbazkbc0VJoAgcFn2P9a3xWqEQeTQNDN1Kf2jogEZwXXXyDke3QQYw0vmI5mYI/aP/u69Hsj1RX8mqjQT8Lkk8Tig2YVx1vqajllm+0evCA0x3+OfpVWFriloR5DL5FKDwUajCLsM0KjEOEm7W2xSJt64b9dJ70I7O8garl8BPQDxel8ldoIXVHZIpGGE18BvbeDeAn9rpAbYGx9rjESZmHngSCuXTteJ2hV/JzWwmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=scGxqc/eWc8wT8xCEBK2J0Dg4EP9y6KHmmHQOwTNbdw=;
 b=STO1aTMWFLxxEmhYDg2sSH2cli29oUE9pQOa0zg03C+virw7RmPIyx1hLiF4m3pM986NZjgtzbO7a4UlewDuLx63NYIZdSlLelK40plW/rDPbRoyvtf9mJhnCd1EZxQ2X8grUgMysjkV0hQj99Da/kdaMuGx24Q1HlNJ5FNa3sA=
Received: from SJ0PR05CA0038.namprd05.prod.outlook.com (2603:10b6:a03:33f::13)
 by DS5PPF016FC81DF.namprd12.prod.outlook.com (2603:10b6:f:fc00::644)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Thu, 20 Mar
 2025 09:13:32 +0000
Received: from CO1PEPF000044EF.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::75) by SJ0PR05CA0038.outlook.office365.com
 (2603:10b6:a03:33f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Thu,
 20 Mar 2025 09:13:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044EF.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 09:13:31 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Mar
 2025 04:13:28 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, Bhupesh Sharma
 <bhupesh.linux@gmail.com>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Neha Malcom Francis <n-francis@ti.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Prasad Kummari <prasad.kummari@amd.com>, "Simon
 Glass" <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] ufs: amd-versal2: Use raw read/write for SLCR/CACHE registers
Date: Thu, 20 Mar 2025 10:13:24 +0100
Message-ID: <ee2d1ad2e07e96f1948ab6ffe8f3c50a3b8f9be9.1742462001.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6904; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Vyz/UL9qYpXGqhBIzZ11ROu0NPlyGoAMUzogdtz+z1o=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvTbd0wPG/Qs6D7/s+/d98QYYX6D9dwP7KSOak1cVW7c8
 5XHTvB5RywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZiITAPD/AjGMwmJHp3mOrr1
 KxefN13h23LoAcP8HJbt5eo6X4UTu+r82Rdl5xxdfH0uAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044EF:EE_|DS5PPF016FC81DF:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d6b6d1-a400-4ebf-7403-08dd678f7c60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HJKASEj6u3TxvtMxn+Cn2lfcOclKxE3kQoQeU3t3NP1mcTBuEMQ5JiWrkqgI?=
 =?us-ascii?Q?3ikEc5sOWIuz9zTG0+jcMR5FfAQEdAEDuJ+ZQ0v+tARLKph2J0lIHkgt2+cf?=
 =?us-ascii?Q?zQfbzSolrfEc1Vs+d0EWwGWkaY7ZfPGZO5vQHiDbxlrxDiXh1W/67ToTfkG8?=
 =?us-ascii?Q?1Q00qlYtQCu6Be+S5b6mfLVRSQRvuQWUfECTmxxCSAZKf91wWd1XEhqIn2qu?=
 =?us-ascii?Q?zlNfEHuBTNub5u//EkUbU+xxq0VN+3MZPI0UXV9YUzWNvOo3N+68pRXiS65m?=
 =?us-ascii?Q?tCEA3pfXtcLuzE50x/jUYCUwLAWkKNss+0BvE1/kRYSFdcLiNNjQaex/5CAj?=
 =?us-ascii?Q?UwxkqNlDQncZf2aXV7k7w8bpBq7dbdmDt52f+xT5avnE9uqqRhEjKcnoUhKD?=
 =?us-ascii?Q?HroW5AUqgYP6F6BtUeUA+J8emsg1b+q8nocW7Cq2hxGFukmAmw4oljEiCTlG?=
 =?us-ascii?Q?lbbssAjj75+0t8d4SBNuIe4NiXkYuiR6bKJIpKWDYP2TKILDNpTxxhgIEY4Q?=
 =?us-ascii?Q?uECKoJPXvaGh3wTV45CHvrSnW0WnzMarfgQvgtEv+7manLqzI2M+SHsBGXfj?=
 =?us-ascii?Q?d1kZigIqygGpiXUJjzTox49zaAch5Nl9jr0Ic/1FQUzCYJGQYF7HJmGa6Ndf?=
 =?us-ascii?Q?g1IwvBtRWMoRhYuArTF8LR1wn/CrC4EWGhA8vRYEmWqBXCAbtehn77U1w1Q3?=
 =?us-ascii?Q?6Eru3zrthRx1nDhI0EfmzSsAvGDb/xmSOHZXtovoKudOeFEFlDd64yAGWdQS?=
 =?us-ascii?Q?3jPdX/jb1b3ROh3xUfvEdm91Eb9YzOPCLQWZascRNuABHAsk2zfpVoIFlXx3?=
 =?us-ascii?Q?A5X8jjqi1ZUiwY3FFBxXu/Aravrks3KBS5AQj/19n5d5w+NsccQjKFSHAsO6?=
 =?us-ascii?Q?BbxDbutEfW6fPVqP4PAdmqykxF7AMQEXRYHq0oNawY224Q8uJkSu/U2I9g8w?=
 =?us-ascii?Q?s7i9/ogFwgxqyOCt8pzpu2u+DujMN1MUD9IK4iqCrn8NE4WOgpMOA5icEj8M?=
 =?us-ascii?Q?K78VvvfkaSPTDcUwutBxos0A5FuxzN9E1q1rglpcLEIK2L1vYjPq70g4mixU?=
 =?us-ascii?Q?KaaClfsHWlYV/G+UIv0D58F7850IWR/IcvaDuOWTo8GZK26yGVh4LiPBo7b0?=
 =?us-ascii?Q?KuBQZca1/LaR1TR/x+qgGQfaKdkxdqUvxiaU743TIvmUDLMi7EeATu53Z4QJ?=
 =?us-ascii?Q?kesuTlrjuxfFFA2dOTtvZMRKR4WQSMLcmLMzd13PR8cx5pHGsDiy8QF39KwQ?=
 =?us-ascii?Q?UoKNEtY949w9G05/bsPnuMDdLN0/t61BB4bFvT99q4JQ/nMFnBAywJA4YuQ1?=
 =?us-ascii?Q?a7VFF/T9FSInrlklIq0OviEbRN8N04Cz1KnfThbFKWg48trxjzPOvGiz/pU8?=
 =?us-ascii?Q?+5fzVK10tSmYzH8QBroXYy8JZVw3yQ4he2jF98XBgVTB15wg5hhe9Cw/J7G7?=
 =?us-ascii?Q?CeCq/2RQTEKAO7DkiYQ4HEipdj2/Dfiemv+88QTtObXkzolU477DU8r9xpg+?=
 =?us-ascii?Q?A4hAS243CVsuwIg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 09:13:31.9596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d6b6d1-a400-4ebf-7403-08dd678f7c60
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044EF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF016FC81DF
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

From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>

Update the firmware driver UFS APIs zynqmp_pm_ufs_* to directly
read/write to the pmc_iou_slcr and efuse_cache registers. Replace
these raw reads/writes with the xilinx_pm_request() API with the
correct arguments once the PM related changes are done.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/mach-versal2/include/mach/hardware.h |  6 ++
 drivers/firmware/firmware-zynqmp.c            | 28 ++++++++
 drivers/ufs/ufs-amd-versal2.c                 | 66 ++++---------------
 include/zynqmp_firmware.h                     |  4 ++
 4 files changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/arm/mach-versal2/include/mach/hardware.h b/arch/arm/mach-versal2/include/mach/hardware.h
index a961032b4d5b..7ca2bbb7550f 100644
--- a/arch/arm/mach-versal2/include/mach/hardware.h
+++ b/arch/arm/mach-versal2/include/mach/hardware.h
@@ -97,3 +97,9 @@ enum versal2_platform {
 #define MIO_PIN_12	0xF1060030
 #define BANK0_OUTPUT	0xF1020040
 #define BANK0_TRI	0xF1060200
+
+#define PMXC_EFUSE_CACHE_BASE_ADDRESS	0xF1250000
+#define PMXC_SLCR_BASE_ADDRESS		0xF1061000
+#define PMXC_UFS_CAL_1_OFFSET		0xBE8
+#define PMXC_SRAM_CSR			0x4C
+#define PMXC_TX_RX_CFG_RDY		0x54
diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
index 584397ba29a3..2940181e83e9 100644
--- a/drivers/firmware/firmware-zynqmp.c
+++ b/drivers/firmware/firmware-zynqmp.c
@@ -5,6 +5,8 @@
  * Copyright (C) 2018-2019 Xilinx, Inc.
  */
 
+#include <asm/arch/hardware.h>
+#include <asm/io.h>
 #include <cpu_func.h>
 #include <dm.h>
 #include <dm/device_compat.h>
@@ -169,6 +171,32 @@ unsigned int zynqmp_firmware_version(void)
 	return pm_api_version;
 };
 
+#if defined(CONFIG_ARCH_VERSAL2)
+int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value)
+{
+	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_TX_RX_CFG_RDY);
+	return 0;
+}
+
+int zynqmp_pm_ufs_sram_csr_read(u32 *value)
+{
+	*value = readl(PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
+	return 0;
+}
+
+int zynqmp_pm_ufs_sram_csr_write(u32 *value)
+{
+	writel(*value, PMXC_SLCR_BASE_ADDRESS + PMXC_SRAM_CSR);
+	return 0;
+}
+
+int zynqmp_pm_ufs_cal_reg(u32 *value)
+{
+	*value = readl(PMXC_EFUSE_CACHE_BASE_ADDRESS + PMXC_UFS_CAL_1_OFFSET);
+	return 0;
+}
+#endif
+
 int zynqmp_pm_set_gem_config(u32 node, enum pm_gem_config_type config, u32 value)
 {
 	int ret;
diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index bfd844e41938..1c5ed538370e 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -19,8 +19,6 @@
 #include "ufshcd-dwc.h"
 #include "ufshci-dwc.h"
 
-#define VERSAL2_UFS_DEVICE_ID		4
-
 #define SRAM_CSR_INIT_DONE_MASK		BIT(0)
 #define SRAM_CSR_EXT_LD_DONE_MASK	BIT(1)
 #define SRAM_CSR_BYPASS_MASK		BIT(2)
@@ -32,19 +30,12 @@
 
 #define TIMEOUT_MICROSEC		1000000L
 
-#define IOCTL_UFS_TXRX_CFGRDY_GET	40
-#define IOCTL_UFS_SRAM_CSR_SEL		41
-
-#define PM_UFS_SRAM_CSR_WRITE		0
-#define PM_UFS_SRAM_CSR_READ		1
-
 struct ufs_versal2_priv {
 	struct ufs_hba *hba;
 	struct reset_ctl *rstc;
 	struct reset_ctl *rstphy;
 	u32 phy_mode;
 	u32 host_clk;
-	u32 pd_dev_id;
 	u8 attcompval0;
 	u8 attcompval1;
 	u8 ctlecompval0;
@@ -102,41 +93,6 @@ static int ufs_versal2_phy_reg_read(struct ufs_hba *hba, u32 addr, u32 *val)
 	return 0;
 }
 
-int versal2_pm_ufs_get_txrx_cfgrdy(u32 node_id, u32 *value)
-{
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-	int ret;
-
-	if (!value)
-		return -EINVAL;
-
-	ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_TXRX_CFGRDY_GET,
-				0, 0, ret_payload);
-	*value = ret_payload[1];
-
-	return ret;
-}
-
-int versal2_pm_ufs_sram_csr_sel(u32 node_id, u32 type, u32 *value)
-{
-	u32 ret_payload[PAYLOAD_ARG_CNT];
-	int ret;
-
-	if (!value)
-		return -EINVAL;
-
-	if (type == PM_UFS_SRAM_CSR_READ) {
-		ret =  xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
-					 type, 0, ret_payload);
-		*value = ret_payload[1];
-	} else {
-		ret = xilinx_pm_request(PM_IOCTL, node_id, IOCTL_UFS_SRAM_CSR_SEL,
-					type, *value, 0);
-	}
-
-	return ret;
-}
-
 static int ufs_versal2_enable_phy(struct ufs_hba *hba)
 {
 	u32 offset, reg;
@@ -281,7 +237,7 @@ static int ufs_versal2_phy_init(struct ufs_hba *hba)
 	time_left = TIMEOUT_MICROSEC;
 	do {
 		time_left--;
-		ret = versal2_pm_ufs_get_txrx_cfgrdy(priv->pd_dev_id, &reg);
+		ret = zynqmp_pm_ufs_get_txrx_cfgrdy(&reg);
 		if (ret)
 			return ret;
 
@@ -312,8 +268,7 @@ static int ufs_versal2_phy_init(struct ufs_hba *hba)
 	time_left = TIMEOUT_MICROSEC;
 	do {
 		time_left--;
-		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
-						  PM_UFS_SRAM_CSR_READ, &reg);
+		ret = zynqmp_pm_ufs_sram_csr_read(&reg);
 		if (ret)
 			return ret;
 
@@ -341,10 +296,10 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 	struct ufs_versal2_priv *priv = dev_get_priv(hba->dev);
 	struct clk clk;
 	unsigned long core_clk_rate = 0;
+	u32 cal;
 	int ret = 0;
 
 	priv->phy_mode = UFSHCD_DWC_PHY_MODE_ROM;
-	priv->pd_dev_id = VERSAL2_UFS_DEVICE_ID;
 
 	ret = clk_get_by_name(hba->dev, "core_clk", &clk);
 	if (ret) {
@@ -371,6 +326,15 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 		return PTR_ERR(priv->rstphy);
 	}
 
+	ret =  zynqmp_pm_ufs_cal_reg(&cal);
+	if (ret)
+		return ret;
+
+	priv->attcompval0 = (u8)cal;
+	priv->attcompval1 = (u8)(cal >> 8);
+	priv->ctlecompval0 = (u8)(cal >> 16);
+	priv->ctlecompval1 = (u8)(cal >> 24);
+
 	return ret;
 }
 
@@ -397,8 +361,7 @@ static int ufs_versal2_hce_enable_notify(struct ufs_hba *hba,
 			return ret;
 		}
 
-		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
-						  PM_UFS_SRAM_CSR_READ, &sram_csr);
+		ret = zynqmp_pm_ufs_sram_csr_read(&sram_csr);
 		if (ret)
 			return ret;
 
@@ -410,8 +373,7 @@ static int ufs_versal2_hce_enable_notify(struct ufs_hba *hba,
 			return -EINVAL;
 		}
 
-		ret = versal2_pm_ufs_sram_csr_sel(priv->pd_dev_id,
-						  PM_UFS_SRAM_CSR_WRITE, &sram_csr);
+		ret = zynqmp_pm_ufs_sram_csr_write(&sram_csr);
 		if (ret)
 			return ret;
 
diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
index 82781dfd16bc..dc06abc52fce 100644
--- a/include/zynqmp_firmware.h
+++ b/include/zynqmp_firmware.h
@@ -458,6 +458,10 @@ int zynqmp_mmio_read(const u32 address, u32 *value);
 int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
 int zynqmp_pm_feature(const u32 api_id);
 u32 zynqmp_pm_get_bootmode_reg(void);
+int zynqmp_pm_ufs_get_txrx_cfgrdy(u32 *value);
+int zynqmp_pm_ufs_sram_csr_read(u32 *value);
+int zynqmp_pm_ufs_sram_csr_write(u32 *value);
+int zynqmp_pm_ufs_cal_reg(u32 *value);
 u32 zynqmp_pm_get_pmc_multi_boot_reg(void);
 
 /* Type of Config Object */
-- 
2.43.0

