Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE358C3601E
	for <u-boot@archiver.kernel.org>; Thu, 10 Apr 2025 07:39:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 07B58839DF;
	Thu, 10 Apr 2025 09:39:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q49E357Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C804839DF; Thu, 10 Apr 2025 09:39:12 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 005B0839DD
 for <u-boot@lists.denx.de>; Thu, 10 Apr 2025 09:39:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qd/yWZRmpF9Iz+nTuNQf1jGlwJWJ3yddR2R1BCLzjous/hZOEaGAmYsnkmDXrqSBD9Esi2l6cjCfW2KLhUXepvIpeeyDx2HJERa5I9xPm5Cwq+GfQgO1B4vCywaRPmVM/EpEj5HHPMq+tviWyI6gHP0kC6BS7s/odOrpy+1F8GoPRFExEZ6eSGN6DVtNMwivsCnu0vUbzAmltGlrJFdmSYDuRe84ZCPFs77IS0NkQW1s3n67vjYSamlDXtAnX0fzG+PTKVxvUA2XjB2sMpRjYC7bI8jsqUKYWC+yE7B1LiyO2pa6rJSbXm1UbbRQwi4hTeuLNvhEACQh4wugWoX6ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DnNoo6LOlRhvaAF8lW4yS+AbIpLvwnVisqlaEBnMs+U=;
 b=Z6chXWploVE5PHZapGn6JahAjS8Om3JH0X1oYc6JyxuWITb1L9l0YTa4iDhVitAMQ0MhRZzdeSQTt3+TAifeK/9/LgTTDReQe7bQg0/k1Uw697zU1G1z/1WInS5U2r9VuJge8YifPWNzZHObvOaH8XG+CxmbiFv1dLdrM0D9IQawvHMMjECmrJ7tP3mpagwbgGaBLNVTPzrjanH8dc591WmY870pKaxPQB7vlf+mILcQDIbMhK4ouxro4Df4O2ygAjMnCyW8Q9NpJiUERg95AEgLcYUC/Ukfw/iqW2od6JkHJx7zqbAg3CylPQwQbJQjea2zKQQ2uKJRnNZ0hU0oIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DnNoo6LOlRhvaAF8lW4yS+AbIpLvwnVisqlaEBnMs+U=;
 b=Q49E357Qy4VYo/ae0C0rWmDEdXuTadqoG5bb7OBBqFi/cg5YPfNw/WoUTLELRbJ+/x6tNBivY5Km7w8roiEIxONYKdw7Z/B69yYATcCF0YQkGtwyZUOJd2m7haLZIHeA3A0V3zXzy/0h+evW9PO05hkPD0I/NSiBS3ccpqPYuIA=
Received: from SJ0PR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:332::6)
 by SN7PR12MB6670.namprd12.prod.outlook.com (2603:10b6:806:26e::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.21; Thu, 10 Apr
 2025 07:39:05 +0000
Received: from SJ1PEPF00002322.namprd03.prod.outlook.com
 (2603:10b6:a03:332:cafe::e) by SJ0PR05CA0061.outlook.office365.com
 (2603:10b6:a03:332::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.8 via Frontend Transport; Thu,
 10 Apr 2025 07:39:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002322.mail.protection.outlook.com (10.167.242.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 07:39:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Apr
 2025 02:39:02 -0500
Received: from localhost (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 10 Apr 2025 02:39:01 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] xilinx: Free memory when variable is saved in
 boot_targets_setup()
Date: Thu, 10 Apr 2025 09:38:51 +0200
Message-ID: <fa10fc22193a1a23258466056b3d02f7496fccfe.1744270729.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002322:EE_|SN7PR12MB6670:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e97b3a-1777-43cd-8be5-08dd7802c51b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zhwaaVDefO/O5C5vyTDg1Dgq/M2hCtnJNyT/XpIsDGRFxq6likjtV0JBwh+6?=
 =?us-ascii?Q?AcyIhSSmig2acnGj/n3P3qd47DoEAspInRiUpFw3OVngeZGsIdEymV3Fbyvm?=
 =?us-ascii?Q?v+C1k6UoIW0S6MHiTV0tAySLgB5WDeaTsgWoU7uq6lDKL4rJIqttmtcVwfvY?=
 =?us-ascii?Q?mn7hnuLqlX/0PFt+4teO8hygtsLc/8XEU5aXvssDQvxsHFbx5cvcmoWitV2V?=
 =?us-ascii?Q?fl4L7fPrekl47xy/yHcZ2BT5flSwRjDp9SfXH5X1dABARFuVwr0+54fRVMAl?=
 =?us-ascii?Q?2xPyQuQR37VG0HVR0aGIhyV2CtrnlbhZemLWyGSNwq2gxVOGmRrrrYgpTfpR?=
 =?us-ascii?Q?dvWfpLqaEXyRXQ+hFEpVI/P3SYbG8sEsTLGXYYRdBmxM5oGJfeF24158gblm?=
 =?us-ascii?Q?wr7gdOvsxgZaTkFBfM1AiRuGBqzaBmtxW6+VIvvydrCRKwEocncs1nTE0fKZ?=
 =?us-ascii?Q?sIGvno5m8wynBJ79DsUv2ruO6qm66tfnB3fF5AtYyNSdaAY7mDF4wK47W3rK?=
 =?us-ascii?Q?G4Z7OgSnwgQ24YEDlCWz1avFZdpZZ+fwHDEZ4fkdj987liyvXLWBKxrYiHEJ?=
 =?us-ascii?Q?PM+O0pBpAs9Y8iNkMyAP/4B3M1m1Ct7e3cnjRDx1T4rj2Z97mEVia6IIe3EJ?=
 =?us-ascii?Q?hRmx8bjIb93MLISAPZlXsLNWaFVi4LAzc8lXmTJZSNh5kOuG8BZ5E6ip8Oc4?=
 =?us-ascii?Q?feRtpG2nbNnX29lusQFHp7qQ9OnNo6VowsNYvIi6/KmUdJR0rDB/443Xw1ly?=
 =?us-ascii?Q?aPBsd73mNUVTRTUMBf65VTMjDyrQg2o8NtFq2J+AmmJZORBgi6iV/tS2dVn3?=
 =?us-ascii?Q?8X54Aj/JKnRoWQGvfsAj3YENFL4/wLVqjM+euUVob46GSbnx63AkxO2XXE7e?=
 =?us-ascii?Q?JXLGi7oiZQ/9fHAaDPug13uvSXj7eqiiBtnsj1NmQkzz7PCXTD9gQGViFbds?=
 =?us-ascii?Q?psifsYa7w+kJwtAYK2cmfWDrEVusWI142V+EhZzH+OtpLqs17o8CkTH8uxdQ?=
 =?us-ascii?Q?G52Gmu43otJePUIw1vzuS1DWIEV3y3+x+6YbOZSnr+5k4gJXzXKviv/Xe3aN?=
 =?us-ascii?Q?IbOGEfpIF8zH2PmudVfiMs0EPFY6uEEOKZCOMPKxQTPEy5oyGLCecMPDl/98?=
 =?us-ascii?Q?Mu9egnUM36+8JXrjMq3OpNJaP5TUm4vrqLrknX57EZ5TLgXhymvEty40r8Zg?=
 =?us-ascii?Q?D/PVVs0uGCLwNaDY4mBfoLf1CWL3BpM7sDDD+u2tr3sL/cUIafbyJEVlgc3Y?=
 =?us-ascii?Q?a2yeFEKa021NvBhJntEEey795AipnTKxnIwJ4dz03Xq0RqNFXyvdHhkDpUKO?=
 =?us-ascii?Q?+5Y2DKvfnGc+VSDuOm8GO20TnEuUxTZJzDdDAHtwMvtOmISIQd7unTeovwdD?=
 =?us-ascii?Q?efxz15pzPdrW3odPCwUr7B3sRW1/4UWV16b40nfUlXActHGMwf487LqGrhfN?=
 =?us-ascii?Q?dMz9VsmJemCsH7F3GwgiDN+Cc2u67E3aXK/TK5GDlOJswO2XeS83utCUCMhL?=
 =?us-ascii?Q?ckJBklKHE/T0YW8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 07:39:04.7256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e97b3a-1777-43cd-8be5-08dd7802c51b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002322.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6670
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

When boot_targets variable is saved there is no reason to keep string in
malloc area that's why free it. This change is already done in ZynqMP code.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/amd/versal2/board.c   | 3 ++-
 board/xilinx/versal/board.c | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index aea3bf022600..ee0dc3487831 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2021 - 2022, Xilinx, Inc.
- * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ * Copyright (C) 2022 - 2025, Advanced Micro Devices, Inc.
  *
  * Michal Simek <michal.simek@amd.com>
  */
@@ -307,6 +307,7 @@ static int boot_targets_setup(void)
 				env_targets ? env_targets : "");
 
 		env_set("boot_targets", new_targets);
+		free(new_targets);
 	}
 
 	return 0;
diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
index 6c4a2f5ead62..de53657b0c4e 100644
--- a/board/xilinx/versal/board.c
+++ b/board/xilinx/versal/board.c
@@ -282,6 +282,7 @@ static int boot_targets_setup(void)
 				env_targets ? env_targets : "");
 
 		env_set("boot_targets", new_targets);
+		free(new_targets);
 	}
 
 	return 0;
-- 
2.43.0

