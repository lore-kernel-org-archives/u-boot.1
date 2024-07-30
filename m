Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF02C3DA49
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 14:53:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C2EC8882F;
	Tue, 30 Jul 2024 16:53:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l2ZJXPOR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 244698882F; Tue, 30 Jul 2024 16:53:35 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B27E88882C
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 16:53:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wn+Hcts+U7IzEryOn/Ky3SzztWJYyIWhfuVD1rlqMD4yp/beYLfkiHaEJpVbdp5f0xASlF6fdP2UiTKFjBuZN7ZgGK34GZT3xhIjQpPfS9ONAd+4VQkWNcWNPCyaCoj0NKUEvVLvkILECfVvJekYBkvwc6I2kc7quzRhhPeMJKoAlYz1gof/QuLak1+YHyZiWSKruQ+DcDnUDdt7NrAWGzqcqVOyqfzGB5JCAjN4JJDr9CYYtL4yWIWxL4q3X3KiFsJOAe0bwsPsAT2uW7VEpt62030oqQKeqh+NaclkC5VysYegDnNbeNCCdX1Imu5/tdzkRCBMLs1R8SWO+lD4oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLWv0NoacR0i921sLiXNEMp9jeHB2qfNzypnPjw+COs=;
 b=U8Dmz6sS+mqTEpekZUddRkOK3SkTB/KNU14iFkIXK00ZkCbAHJtoRFM3tBl5Gs+SDCV0fPcT5BQm0OfCi4zzjZPnc9zGLOGvkZHCaJ6EjLiIWK0FhSQROHwPgUxeP3Qjw8nzQH4CtlgIR3iLIQ+9exMaUI6acg5YPb/hO529Ok0z0LS/tjy8btUQD+EeMrQMzmkaBhMAA1D8b/F5hHBf3K0yCUc8U0tLsO+/ttIFT+Aga4AiHfkJz40DWrFrZZ077vcY4LGlkEHlb3NncTBLSmIXBAygEXko51VwPoNm58y35a3laa+9F2AegTOjhRP8dGbZsSpdaEjIN619idmiJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLWv0NoacR0i921sLiXNEMp9jeHB2qfNzypnPjw+COs=;
 b=l2ZJXPORSLPULv5XRritk4W7I96ejpIA0i116vNg4VQ/0AetW+4dFs5KvR/5MFCUGcdYh1gJ1Cxb+T/J4wafZnSMu10b0/nZsI4gR+CEyTo07G4uGK+RG8Bxo61mLvLZ3O+gNpGR2lGT9vmIc5C9sd82eRs0owmJVPHfuXOnNQQ=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by MW4PR12MB7468.namprd12.prod.outlook.com (2603:10b6:303:212::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 14:53:29 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::e) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 14:53:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 14:53:28 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 09:53:27 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Bryan Brattlof <bb@ti.com>, Tom Rini <trini@konsulko.com>, "Venkatesh
 Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH] soc: zynqmp: Add support for zu1eg_lr device
Date: Tue, 30 Jul 2024 16:53:23 +0200
Message-ID: <12a939e2c88e82a9828852a8f7f33dfa14a6a4b8.1722351201.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1504; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=C5LTnWXutWq3n43wkFxtc66zWV2wiKmrqumpw2VO8iE=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrQV/5IPmq27NW3tpLTjcm+W8nN9lGrV/Xi6jWlKZ1Coo
 4df2TXHjlgWBkEmBlkxRRZpmytn9lbOmCJ88bAczBxWJpAhDFycAjARxb0M8zRrs0JCb/g/2Lsx
 PE24YDJbc45GBsOC2duV1Z3f+s6dnVTzu9FZh3uX5wcjAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|MW4PR12MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d3a614a-87a8-434e-29de-08dcb0a75f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ookUN+qMrMESfhuvoKKs6DVkFigiTVok7eqa+J26MAXGf/Yf4txT6YZQSUiC?=
 =?us-ascii?Q?PGuKcxQiYH8CR7nJ1UOvRMG+fHYzbUQTenKHuk/dwuZHJR/xuaVQFDE2kP6d?=
 =?us-ascii?Q?STRuWkfJ4Bfq1RUNjXCVCA+FZ3PXHXl/jHhEwi0eVhCLcbercILuumbtr2VK?=
 =?us-ascii?Q?Lfcqj1+dWsWeEnLuULpHQtzO6MDRFx1hQ1x/9slztvQLwCwJb+Mxwyzd/P0T?=
 =?us-ascii?Q?S+wNUxKpXwX5YcAACCsHF4z9+lLA3nUaX8NI7KvTRAiok8kz523Nbk6oOKrF?=
 =?us-ascii?Q?JeIv2PUI9vSF0nMSNUTDJ4WLDe1b6E8+DoBuf3l0rqPKD2xgVDXy6MNbta3G?=
 =?us-ascii?Q?y7iLrqZhww2yUqxno4HFshp8K5AlvUAURX46knYUoebQ3M/1gso7fuNyjWUm?=
 =?us-ascii?Q?IuZwWSXZmEG3JRE+GyGUwScZ++OljXn3ULfsAIhQuEpdFVv3bjtJTennsR9L?=
 =?us-ascii?Q?zP+mIriuLhTOjvfDgMKq5yrqNDWo60S9rwWd2/gqiYuAU2dkSyIqOpFRgTTL?=
 =?us-ascii?Q?ZA/Yi5+U+7KFxDGVshaK04bmcjfdX59orU01xTV4SGtSmbXF58e6jNCwIsXN?=
 =?us-ascii?Q?AL7ceJ3xC/m9aXWlV4ho1OF49dH/k2o/c4u2w3nWPKOH7q1FBH/LW6OBjTSl?=
 =?us-ascii?Q?aBx8039e6heVVr0Pish8OvpT/caES8YF3VOJ7Io32wA1C13A+PdTuaRxJBw/?=
 =?us-ascii?Q?/vsRenM6xH/dm2dNmImEgPYvnviWKXfYAXizq6PN9i5I35aeyfPaOUkK1iTE?=
 =?us-ascii?Q?DvescxBJXR5zf7KZFXSqur5jGtCeOLzmFYYfy9VMZTKW98C+m2y0dpZko0yg?=
 =?us-ascii?Q?w6AnOlqr0zTc3LIFE9UkaOVRrXCpfGsWjD+1yU56aBmZtzp1JAHCurxlP6MV?=
 =?us-ascii?Q?RQ+r1E/1E0JGUgSRLP7wLySRDhvWkLl+2LtLoIVgwStfx7SZGQmKISnmEOXV?=
 =?us-ascii?Q?MV/vKuEguYz+iCkZRfhplaMnV5xywKTFUnXTxSww09uo5mEvLkLnz9Dllwn5?=
 =?us-ascii?Q?rFO3JcX12F0+ewEEqtNxaPLSCDsmCrjDZc6SegsKrkhUDaR/DtJqj7uxM1gW?=
 =?us-ascii?Q?+bg3+UzHGwHjIxI3JhcymyD4uUvHMiZcXfPYsyXEWfZ0TycRXdrHopjTzuTO?=
 =?us-ascii?Q?XELut0HyrZE91A04pa/K3Jw7jvBbtFOmkkExN5CQvh9jHB0OScklmntyVY8V?=
 =?us-ascii?Q?NSTj63eMoyaSjfe9bLYrny+pQZrng2LO65sdQQOr8vx1/otg4S4ug44pbW4f?=
 =?us-ascii?Q?GLOgLnQRfamkAl48EeBxnZT9zVEe7GRtsgTCxu1WCTri7bOwbJDMnvt8a3Jf?=
 =?us-ascii?Q?/l6ocj8chpKXXZE6zGIUBf0KvDCCjIyHla+VbSNGaXQ+aqnfZ/TKL3LpD1Nl?=
 =?us-ascii?Q?VZRSy5c9LVL8ivWnip3XVF3KOKpPjrc5e3o48MSq6/AXBWDQGeXI/2SlrnZj?=
 =?us-ascii?Q?fl4Vi/08CYOhBOkcZNgBv90US5YgkVIB?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:53:28.8498 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d3a614a-87a8-434e-29de-08dcb0a75f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7468
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

There is new chip coming which is using new _lr suffix that's why record it
in the list to enable bitstream in bit format loading.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/soc/soc_xilinx_zynqmp.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/soc/soc_xilinx_zynqmp.c b/drivers/soc/soc_xilinx_zynqmp.c
index a2d5b82fd34d..0c45c781fef4 100644
--- a/drivers/soc/soc_xilinx_zynqmp.c
+++ b/drivers/soc/soc_xilinx_zynqmp.c
@@ -44,6 +44,7 @@ enum {
 	ZYNQMP_VARIANT_DR_SE = BIT(4),
 	ZYNQMP_VARIANT_EG_SE = BIT(5),
 	ZYNQMP_VARIANT_TEG = BIT(6),
+	ZYNQMP_VARIANT_EG_LR = BIT(7),
 };
 
 struct zynqmp_device {
@@ -64,6 +65,11 @@ static const struct zynqmp_device zynqmp_devices[] = {
 		.device = 1,
 		.variants = ZYNQMP_VARIANT_EG,
 	},
+	{
+		.id = 0x04689093,
+		.device = 1,
+		.variants = ZYNQMP_VARIANT_EG_LR,
+	},
 	{
 		.id = 0x04711093,
 		.device = 2,
@@ -300,6 +306,8 @@ static int soc_xilinx_zynqmp_detect_machine(struct udevice *dev, u32 idcode,
 		strlcat(priv->machine, "eg", sizeof(priv->machine));
 	} else if (device->variants & ZYNQMP_VARIANT_EG_SE) {
 		strlcat(priv->machine, "eg_SE", sizeof(priv->machine));
+	} else if (device->variants & ZYNQMP_VARIANT_EG_LR) {
+		strlcat(priv->machine, "eg_LR", sizeof(priv->machine));
 	} else if (device->variants & ZYNQMP_VARIANT_DR) {
 		strlcat(priv->machine, "dr", sizeof(priv->machine));
 	} else if (device->variants & ZYNQMP_VARIANT_DR_SE) {
-- 
2.43.0

