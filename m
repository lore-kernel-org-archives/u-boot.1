Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBE8C83F03
	for <u-boot@archiver.kernel.org>; Fri,  4 Jul 2025 09:09:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CB9482F00;
	Fri,  4 Jul 2025 11:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2gmJLCLQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4999682F14; Fri,  4 Jul 2025 11:09:37 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E3F3782A76
 for <u-boot@lists.denx.de>; Fri,  4 Jul 2025 11:09:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iobpOi3dIsHuRiQvQL9mJQWsPa79eKBQgp6RBWWUStoR+edjhmC0oNMDWjI3gdJfUu3mbhQvrK7Ia+4z6gry0OdUdoL6qsQSysk9D4EtoMSSsUfuMKkYB9glePwY3zFkPdfXJMRxFFa2JKCC9U54s9F0f8jnNLXcloOgOlBN1mBNWqwXtJdWkZTlUdlPEdQ4LQIafM9vNmlbXzV0+wFZYqsAcdUZcgdGN+NulMmfWQKH5ga/HHNqInCHrHo1naFWI4P0FXbicOp9P905JSCEDjgjYQ/1Mz4y/zu57994JSQtk97C5s9OYoGTk6lNjyaRe8VwzJrSC+11isK8hVmoUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nr92Rn552uGNVoBVvEP6r3jBJVppDsRWVIDZoxT+ixE=;
 b=Nzx/Wpa+cEJVa/sYM5kmzPjGpMFE0XOySZPwSr1zCjAZZM03YhQFF0ebzNBRdj9hkSRebMXoK0T1IRsHjyDbSmp9D525X3JZwK1deXIKYAsV5iuXPMOB/26AxIAYx5BMURht8rd06Hy6gS1X5VCK1s3QpPFFCuDMIMdLbM2sBFg6xVz2/rfhSGmLMq2GHOy53a1ytVqTvEBSx/0gRsPaNAn5aSaP8MIOTKLnjWMcCby65E0dJrUQPKC9/S6DAyRd9fpH2P54YJKBNI20jTF70Cp+VBeLOfAMwOrbztTCdDGmKXEA3r38djVHiGh96j+9l0/zyG10CUj1RiJApBQ85g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nr92Rn552uGNVoBVvEP6r3jBJVppDsRWVIDZoxT+ixE=;
 b=2gmJLCLQPju3Tpncm0GRnGYnfi+uAUns4kGqlTr9azZL7LRRZW6tjRsZue4ZuJ7g4PeKp/nWcKXthsLJ3VKcAY7A+1BxHgSZXslwpdmD9L09byQxSKYNJ2KnfJjq1sjiUTnmdxM6BqTqFYFNmFhoDo1QNzQ3FU4RmZGKtg/72+w=
Received: from SJ0PR03CA0164.namprd03.prod.outlook.com (2603:10b6:a03:338::19)
 by DS2PR12MB9824.namprd12.prod.outlook.com (2603:10b6:8:2be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Fri, 4 Jul
 2025 09:09:31 +0000
Received: from SJ5PEPF00000208.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::99) by SJ0PR03CA0164.outlook.office365.com
 (2603:10b6:a03:338::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.19 via Frontend Transport; Fri,
 4 Jul 2025 09:09:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000208.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 09:09:31 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 4 Jul
 2025 04:09:28 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 4 Jul 2025 04:09:27 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@amd.com>
Subject: [PATCH] config: versal2: Update timer clock to 100Mhz
Date: Fri, 4 Jul 2025 14:39:20 +0530
Message-ID: <20250704090920.678557-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000208:EE_|DS2PR12MB9824:EE_
X-MS-Office365-Filtering-Correlation-Id: c4ed4692-5d6d-469e-50f1-08ddbada7c9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?h2c5Y3zJKvb3Qvzy4uSSCzams5BXUVSaCyVz3RmczsM3ePWW+Po01r4tFpce?=
 =?us-ascii?Q?H8UYO2QpX2PFEqNS3rw6uUbUmejfw3l72quM92SM/smFrjxXzGWMrLRJvDfi?=
 =?us-ascii?Q?8aDJW9OMvjtiog90bUx4OFkzHT1+94Bb6gQDNx63uwUEUevv1WJ1zU9/40kR?=
 =?us-ascii?Q?16v8vjwaJqswsO/PJwMz+w0IGrkbmSlRTCFfi94E9FwrRsdAa9xg3PlKEIFY?=
 =?us-ascii?Q?HvYs67AjqWGXekn6Yy5kyDOQm6dd1Ee9P9TmawfQS0T3J/4uK2thPPO627yi?=
 =?us-ascii?Q?XzErSrtFk//CrvhArt5JQn5Svxfqhe1rOZxiI44xI6J+s53Q4xX+/oPasw+D?=
 =?us-ascii?Q?l4pClcYhm9b11H1W87CnZc80nBkgdTpXv+VWdKjP7qKFI6FLIt4KF/AGX3w1?=
 =?us-ascii?Q?ktAnwCscvg0KU2jQEJpTSL9jfNerkneU7Dn7/8+9z0CbliBGI2AC2LZLNt8k?=
 =?us-ascii?Q?ppJ+tNKd0hUhX1AyxG8wwx8Y/WsSz27ieauKpuIhOFX1MHvcXwpeWlY6+c/q?=
 =?us-ascii?Q?aUk6LVJDzeWn+zHLJLm1TeHMuoo/Pb2FcF0qQDT+9AftaVYryosD04fRsYQZ?=
 =?us-ascii?Q?HYErlPdcDSc2LfLr+sNTIawEizvPgpqBgMwOum4tzzYJkyheO/p7rKqelgi3?=
 =?us-ascii?Q?nkUeHDMnGLRTFX4DjuraQqJwCHOmJmzrTR+BvsCzifDzGmWkNMVdv1vjePfF?=
 =?us-ascii?Q?APZaXvuEGVGUzSfK62nsQDkqUbU7olQ/fPMytb3HuCmvsT8ZI0oND6WtahaH?=
 =?us-ascii?Q?4IBWpQW17VDZhkHmgQn5dgWfulLI9AwSGspWBYmMu4xdKkh+RYapDPNAa4qz?=
 =?us-ascii?Q?NbO9o+KehnxIyLIcnpiWHYU2CcT4ujhtZdrrcVPYYxV8XxiLoml+IVsmiued?=
 =?us-ascii?Q?80c5QLiI+bIV1UCg2jyYSrErS1kxtx9iAusiBYTRlX6g5sYR2Rlri8Ta+BlK?=
 =?us-ascii?Q?7Ocl6fJPwVSf8/BxQKlDV40rsDcvzSi1sv2XiimSz4aZ/wev+nOb2CwD46+m?=
 =?us-ascii?Q?v0iVyp1IRoDe97wjDfKnBN59C3yOYG14cr114IeryX+8wrx9F/tDnu9G5MTG?=
 =?us-ascii?Q?X86s+zDBQr9TZIKEhl55g0qhkkhx32AtkZ9leQ++IKaAkYLcR6riOSQa0rTJ?=
 =?us-ascii?Q?iJaWbRGb9n7ZetvMP+KqEV3f8DL3Z0cL0h9BjpOSfk8gZG7VwHOWyoAIYgGm?=
 =?us-ascii?Q?FZpIeW/dzCqjq5kIPluw1ktVWpvCKNI1L6I3e+dOfjBTNRgg3TxYp+m7aWMI?=
 =?us-ascii?Q?Qy+pOJunX0RKH1O6A/QECEmcvnmHSi2kfggS1pmQWImTMi0QKs8MGYW3yOqS?=
 =?us-ascii?Q?UJT+m1SOx2HtfH0NxPisAILGC6VXrgR8L+MbuTCnHmu1FF3XggDWGL/lCf77?=
 =?us-ascii?Q?gtye0N1uEjvrAldmUGU/5+L2WqUppdXAIFQXn/y4WN2AXkbumetkgp6Mofgj?=
 =?us-ascii?Q?7rcQssMCheJSZ93RFGbxYzDZxkn5xu47cexPdX41rN0wBXwTjBARKduQhXeh?=
 =?us-ascii?Q?sRfn7y/3UhL6q1GyvFuv9GjkFZcKjiUL9uaz?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 09:09:31.1459 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ed4692-5d6d-469e-50f1-08ddbada7c9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000208.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9824
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

U-Boot timer clock is not updated when it is migrated from
emulator to silicon. Update CONFIG_COUNTER_FREQUENCY to 100Mhz.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 configs/amd_versal2_virt_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 15ac0211828..052d637649e 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -1,5 +1,5 @@
 CONFIG_ARM=y
-CONFIG_COUNTER_FREQUENCY=375000
+CONFIG_COUNTER_FREQUENCY=100000000
 CONFIG_POSITION_INDEPENDENT=y
 CONFIG_SYS_INIT_SP_BSS_OFFSET=1572864
 CONFIG_ARCH_VERSAL2=y
-- 
2.34.1

