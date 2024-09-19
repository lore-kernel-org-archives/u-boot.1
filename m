Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 392CDCE8D61
	for <u-boot@archiver.kernel.org>; Thu, 19 Sep 2024 09:18:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 23AE78910E;
	Thu, 19 Sep 2024 11:18:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ieBi/iLE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C663C8910F; Thu, 19 Sep 2024 11:17:59 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 68ECB8911E
 for <u-boot@lists.denx.de>; Thu, 19 Sep 2024 11:17:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndG0p2wYe4xWppEJM8B6aM/QG2RGGIyHjxctTjpLQsoeQIRyxqThx89uFAJD8mRNfEH1e2aK13b6FXkLT15aXeDHyf1y2tqKWLww4UYzIQEW1eS6QCtsyZbkKerPcvwMD6ZQIfXqychu2nNaX9o91c+xdyr+N+qsbUnq5hDSTv9r5H8rda00vf9qXZFsh9ZjQgNK1BDVTKFrGrMYtJvpgW0Mo46SUYCw3L8simXBKEVTe11AUYZYtgk1IMjBUkrLkSNu2u9+Gx0g/+5XXRf+mEFBUodcSxRfr/rU0hpmw8A7inKfsFozee3DrdBjOfkOFB2gymwc+dZt9AfOBB1pJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hNGijAOAutP2FItcxCeecBgDrXlkyY0M/Vb1JHVa4g0=;
 b=oBQv868LydW7+VKpjJFJCofMCLe7mwQIwr5X3CTQqQyAVDMXB5Y+QuIFh70xNdcNX/Irn6/78fl1PL3KNLtGdVkFYt2rueNQeQUlAnGz0tDxL9Jj5NeOSc86tjMJrYcLeXh9ayZ7Ls/u9rBMdF47vNGguuVJgW2Ugu+b5NpaXCyrsvP+mJlDF0BRijh07WaAq8h/ceWxGO4KmKX7kg2hicfvBH8sVxElP6jP4ZyQ7li0RhIQl0cu3EXKeq93UM7TmTf6G8Hs0azjI31ZV3Q/CXRBBdmZ/0Qeh816QYJs9NI/m/xEkM9e2bybhO5T27bDLJuxuzH8XqAMxIMYOr1hkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hNGijAOAutP2FItcxCeecBgDrXlkyY0M/Vb1JHVa4g0=;
 b=ieBi/iLE+dghprskbWIPx/FJDrMHhtrtj1YAWNaRK+PbpSB7epNx5/0v3v95S5Y79iDncKwD1kOnCU6l9/LYFHQcxop+zaPqWZ/duxaZH7BkmxLSXLQFGfBsxjNwTGUtu+NGQ9h3ly6cGpNmbvGBtqRFtCgPJIYw+9KPUZ29jkM=
Received: from BL1PR13CA0407.namprd13.prod.outlook.com (2603:10b6:208:2c2::22)
 by PH7PR12MB6953.namprd12.prod.outlook.com (2603:10b6:510:1ac::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16; Thu, 19 Sep
 2024 09:17:53 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:208:2c2:cafe::27) by BL1PR13CA0407.outlook.office365.com
 (2603:10b6:208:2c2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.16 via Frontend
 Transport; Thu, 19 Sep 2024 09:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Thu, 19 Sep 2024 09:17:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 19 Sep
 2024 04:17:48 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 19 Sep 2024 04:17:46 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <neil.armstrong@linaro.org>,
 <bhupesh.linux@gmail.com>, <n-francis@ti.com>, <git@amd.com>
Subject: [PATCH 3/3] configs: versal2: Add support for AMD UFS platform driver
Date: Thu, 19 Sep 2024 14:47:31 +0530
Message-ID: <20240919091731.26338-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
References: <20240919091731.26338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|PH7PR12MB6953:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f456764-7cdb-40d8-1da9-08dcd88bf06c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XS6iPE7eLLvSUTL8TudCXmqKtuujhdCIPsp2tQucy9VAXHoVHAccsTjnoZ6+?=
 =?us-ascii?Q?awyK/3K/WKNh2wJRbYi3zOM9Ta/QkMfGZVcM7eMj5FdWalo8acry4YatniP8?=
 =?us-ascii?Q?8JsMIqjnQUlCycyTQT+82d7bJICHYkB3cJA6gHAzpnLnG9IMCa6jeGK0Njbi?=
 =?us-ascii?Q?2QGYksGWBtFH9Y4ZQQS27y9u43ylwBeSntBWHn53uvx7jA79Vv7j4vWUie5g?=
 =?us-ascii?Q?5h24Wfwi52FlbzGo18Ane2+dI9j6kLjrALNW1CjjaCM+KeZ0WkptbXUsb+V5?=
 =?us-ascii?Q?vuVphHm140dKsR29R4pa2LiSF7m67Uzkx92u/IgthDiJxRbi9PkpGyXBpDv1?=
 =?us-ascii?Q?o0B/NN61Fd5pMZR2E6qOms1mqDbHpRGl/zRhYMJ2v6c5Hs9zBWF9YqE/tsK/?=
 =?us-ascii?Q?TrXXx9G7w5Inf/9nUotuZLYEKsphjyUtIvhSLHLl9AQMUpSgI8n2fmJHDl5J?=
 =?us-ascii?Q?tBnQC6/JHjfwSb8ZcK5lUHfyUhHhXix0tRLkhigBcrSlND/U/SSJDiaIFgMn?=
 =?us-ascii?Q?Ar4YOMULB/CSrtLPHAU+bu6UNUskIPHvV/p5X9Zhxi1Q1mpDnThLcQI4d19J?=
 =?us-ascii?Q?mYx89kMhU+7KrcewKzrcWpN9OXicVoKGnjI4dtUpybDwg3PoFPPHwcdDmLLo?=
 =?us-ascii?Q?3csoyHNGai6nfmlGFOJ3x0rfowdBK0nHWUP/g6zRnK4Y+igz+FAPln6TT3v9?=
 =?us-ascii?Q?k4WfF3er2dndSuJpLEWotIJcozJS2B6JOOoBF6WBwLjm1X/fGwfr55Ei8lyd?=
 =?us-ascii?Q?Jsgf3TupIIB8pxYOdFWqmQebdt1HvKkb43T5EwGN4JRIWQwaTAINNUcPUdG7?=
 =?us-ascii?Q?UXXimQjfkbQix16CGOC754Yo3hJNDXteOUdMiIh677Pnd6Bu2PySMkzZILXQ?=
 =?us-ascii?Q?JP51w0GuSRq9ijOsz1blZzOxF6F96kDOxu14yC6UZhH7f7UqHQ9KUIyQ0h+S?=
 =?us-ascii?Q?IFs/pr3YADmrB/FmANxM2sGvaKYKQl/gFIgGlSrED1Yo0+5XecnnBaY7IopT?=
 =?us-ascii?Q?HYiQvelA7YGbVq50YTZq8Y+1eg1s11J0Xw51auEpWZIaV/X6dRXPQ461DM6W?=
 =?us-ascii?Q?/ADudmgSNG3aNbmeNmWo0bneRtqywCpUMxPtF/H9V3SYh32IJQDyizuvU87a?=
 =?us-ascii?Q?8TtSLfjgVRqUqzqvlCdeXxTxyVz0HGOFvqgboNV2MCVf6dqbMPZKAQX0JqGg?=
 =?us-ascii?Q?1f7b72h7hMAF6vY2cZ+g/dRjM/OO/eQJ1V9MgA0zfZQR2qHtoPLEMH25r0w6?=
 =?us-ascii?Q?lkVn4KgTuIlKH3WHDmo79mgv2/uiDpiTS074BAR95e+hX5eAJztfv/0wqvhH?=
 =?us-ascii?Q?L8VHs4U2RpQF3OpbNFQtLJTpQ4P37vkWeXau4o5n5y64bvTr6eo74teKSSUn?=
 =?us-ascii?Q?Ai2B52/qcGfJ9cfrSAQJKgNQNVnNVpG+EfizVj8QA3S+t5Uwr64FJaG3z5hp?=
 =?us-ascii?Q?mR7lO2+ZAjCRzUPoBBbSh/GJstwF4El/?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 09:17:52.4813 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f456764-7cdb-40d8-1da9-08dcd88bf06c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6953
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

Enable AMD UFS platform driver.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index c4bf77186c..666d76c449 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -145,7 +145,7 @@ CONFIG_USB_GADGET_PRODUCT_NUM=0x0300
 CONFIG_USB_GADGET_DOWNLOAD=y
 CONFIG_USB_FUNCTION_THOR=y
 CONFIG_UFS=y
-CONFIG_CADENCE_UFS=y
+CONFIG_UFS_AMD_VERSAL2=y
 CONFIG_VIRTIO_MMIO=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_BLK=y
-- 
2.17.1

