Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAC8C02198
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:41:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E390F807F1;
	Tue, 18 Feb 2025 13:41:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="vS/PnMeu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E39580BA8; Tue, 18 Feb 2025 13:41:09 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::618])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2613D807C0
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:41:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fm9EowOsufdnYOHnwd1Y8I3ra//U6Vf+7rSPgWjQfohgR0JtFAwVPzIB9iPKAgU1Sh7sOPsG2AuvddlH9RCFNDly3sVPhCpxeQ3mjUMivqn1BQpPRl+sZFZlF4RTSwwwGFLOxTgBUN7Ua61JWeShT8shjjyQXmrzRU94L7gylGPiHsXtxaGyTYL4DqJJDl+xTEwamN+VV/pzmVH5GgLu5a0ghZoEb3c5S0491Y3tqyueg5rrlGxB0geYx3ju9k3aL2d60V1yxiYT/O0ZKeukv/ZeMmT4SX0oSitDphPx9QLir5mrCHeE984qqc4/fT79ZQbZMO9f6nxGD8NtkPrRAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qVccE9DCUSbF4B9tj7RadKufBkBjOuXWLlcOVUWw190=;
 b=INW/sdzpY8UW4AcfvXP17AZcgy7F7x4YrbJrDsS9+fpBH/KOTXdTiNwFp7rYEHiABdxAyiJBZLCmO8VzSV6ulYmN2UyXjmU92WCyC2ZPSNSIihY0oNIuSIuhQMXMulDO8NaXTFPa09HMOASCc5tFuaiCcJG+/ooTKqeckBDrSrj4ljfz1WcaJiPSFyUhSqsDsseo6CrymkpzNYRQfsVNemrWkBHC8wOPPUtycOimgfgPQJvHWLN/hGuPXh79Y6cYBKtpbVWCIpgB2WQ2Ljw4u7yV4PYBeum/j7cDjIfhkYO9+CVWOQxaVCVoFvNYxqm4HXRW7RWxXz1W3msUTeA7TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qVccE9DCUSbF4B9tj7RadKufBkBjOuXWLlcOVUWw190=;
 b=vS/PnMeui+pN5iHzubjIKaqg5K00LWp8b4cd+Rx+ikHfNGWrz27uHlJU6B5VSsrWYBXVGnccmeJDrKSjJvNrcsYGNwK57bUJqI8gRwLWORXN5DkpMMNAYR/fp3EaqB5gS8b8iHkJR+4c11PSK5HwNyRbQAyyviPaVvNOuOFQhlU=
Received: from CY5PR15CA0197.namprd15.prod.outlook.com (2603:10b6:930:82::24)
 by DS0PR12MB8248.namprd12.prod.outlook.com (2603:10b6:8:f3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Tue, 18 Feb
 2025 12:41:00 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:82:cafe::f8) by CY5PR15CA0197.outlook.office365.com
 (2603:10b6:930:82::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8445.17 via Frontend Transport; Tue,
 18 Feb 2025 12:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Tue, 18 Feb 2025 12:41:00 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 18 Feb
 2025 06:40:56 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Tom Rini <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] versal2: Fix .*get_bootmode function name
Date: Tue, 18 Feb 2025 13:40:48 +0100
Message-ID: <bd8cb2f9783bda47663927f78bf0bf908393334b.1739882445.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=833; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=cn2X57/PpGgiicl+02H1x3EvEi5okNscLIWpEjXLAbs=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhvQt9Rc+nOA6svfKtHVO5q7eQksrrqkk3v3TqP55wd0n+
 rZCVSr7OmJZGASZGGTFFFmkba6c2Vs5Y4rwxcNyMHNYmUCGMHBxCsBEtr5kmJ8ffGbly595+vKN
 xlGfT+q39d3SWciwYELclauGaVfv6305UTzj97061ZMCqwE=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|DS0PR12MB8248:EE_
X-MS-Office365-Filtering-Correlation-Id: 36f2ec10-1bdf-4462-7bf7-08dd50197f9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Szd/q+fX114m/jBJSzQ/6SLYuWB6RwB8A5msHVzjrE1ZYxmnvcwG631LYaPj?=
 =?us-ascii?Q?lsWUPhIRnlgr/7U0qHrNezFN7slYXe24kjObrNA72Bp9WnBJ0/+EAaOmMM7/?=
 =?us-ascii?Q?iR+1IKX1h93k977hg0AwRrL9CwnLGMafo/HzliqFF3FIhWOB/iGGxCxSVmPa?=
 =?us-ascii?Q?ybdoA1s44xFaiTjf+Ar8f835w5FDTZy6vU6swmQMtXcoh6P8MeDFouvUF9wO?=
 =?us-ascii?Q?07xvM55/auS7k4LZJ5rGPdm67vuBPGrX3SZjpioiVIQMWLkpYr+UDQj8T9aN?=
 =?us-ascii?Q?0p51hOc3IOGK3r/PBWecWYOaWIzi8gzsl6xNa0Kkf0ylxbLi1ehosMy83FvI?=
 =?us-ascii?Q?HvWFqZ3FHT1dpn/XILa5zRWMX8DzPGsUzgM5D6VJz/mv73XzVFbaHIKHwWbS?=
 =?us-ascii?Q?cv0HbiYPM7zj5ZtWz6NSvOAvGo/kYlY9OLlYwC1S5yRe50kVq1CnUQold6lm?=
 =?us-ascii?Q?Wtw4BgrpJ/NdFgqVDn82syZWrSTIun1WEh7gs11e3YnZ5LbEVNp65NJI3JcO?=
 =?us-ascii?Q?msTvpzlC4Nx2eMbym3ht79cUN8ybSfamvvRvhT+usiB0hp7bFAX8YM3BSlmv?=
 =?us-ascii?Q?C2Ak65kZfMS+4zJnJV1JA5kyRg//2NB3TLQFmEAu9oJApYbDtCOElvGJPmMd?=
 =?us-ascii?Q?a4uk+RZFNrSu6nFOilOAWYQV4WIQUehULKGV0MORnA2WNIESSx7PQhNLL1Ai?=
 =?us-ascii?Q?oMjRzAMs86zYsza23gO1YJXJ24MjvgYSrW78DpbyG4f1wXIVYju0aGjeBS8R?=
 =?us-ascii?Q?f/BkePBy1OeFc5ZLZlWb6sRFtFqaD/eELw8IUAzNQjgMAgdzYswD/5TMaYIs?=
 =?us-ascii?Q?/Ah2T5QZwDxxpNLEQlotlmrX4Bvbogd7YmeqnFxijdp5yN8FdiQy4MpnqcZX?=
 =?us-ascii?Q?9jnIcW1yQwMe0JHJ1tsecWjBYtBsh6Qjp9paAdd59bVZmLO3E5HdExQIxFoh?=
 =?us-ascii?Q?OQPtTIPvhyrh84v14snm5P5qM1d14zBnpAd0SnKWE8cnBDWDjo7IsWtLcW8W?=
 =?us-ascii?Q?gmkGX07peb0GAs1r81xD9hAae4DG2qqTnj953dNdiFOK16ovRcL1x+l4sIIT?=
 =?us-ascii?Q?N4xZ31wrgPqkYUDqKYFEwwK2cyi2bafChAeGd0oyXw4lM0b6ZkvgnutGM84A?=
 =?us-ascii?Q?7f0QjL7hG40zA+js5meLxhW4RXUBWSxoNlECHnqwrYY530qWPWkOtmZ+JPrU?=
 =?us-ascii?Q?+piH5lSzQth10OYoZP4qTXC2QsxJbiK1JKQrGaVYsu1OYdmqM4+ZWYENfNKN?=
 =?us-ascii?Q?WQhkjJB/BQy+78EFliSDKexVgWOIRustae9vz/GOHued7giSRLMLlRL+dbGo?=
 =?us-ascii?Q?jzPfTPJt2H5mU7DyJhfAUzPWbucvE7lW7X6DzsOn1xJs+HCVcAj2LshauE+k?=
 =?us-ascii?Q?+0AauvZDf7GhLUwbAPy3aW4HlPyvt33F7X3slZM/oE3NJOBsWMKMksQhxRTa?=
 =?us-ascii?Q?PXrYB31PPfCG1OWFNbgYJgrj8RrPntvegl43QW5R0dD3qi9ccrf9Z6Ltiwf0?=
 =?us-ascii?Q?OUYxowxpe5sZqF8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:41:00.0322 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36f2ec10-1bdf-4462-7bf7-08dd50197f9f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8248
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

Function was c&p from Versal NET and should use soc specific name instead.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 board/amd/versal2/board.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/board/amd/versal2/board.c b/board/amd/versal2/board.c
index 5651d516a9e3..d3e6547eada9 100644
--- a/board/amd/versal2/board.c
+++ b/board/amd/versal2/board.c
@@ -149,7 +149,7 @@ int board_early_init_r(void)
 	return 0;
 }
 
-static u8 versal_net_get_bootmode(void)
+static u8 versal2_get_bootmode(void)
 {
 	u8 bootmode;
 	u32 reg = 0;
@@ -175,7 +175,7 @@ static int boot_targets_setup(void)
 	char *new_targets;
 	char *env_targets;
 
-	bootmode = versal_net_get_bootmode();
+	bootmode = versal2_get_bootmode();
 
 	puts("Bootmode: ");
 	switch (bootmode) {
-- 
2.43.0

