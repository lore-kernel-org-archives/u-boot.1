Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67814D5B841
	for <u-boot@archiver.kernel.org>; Mon, 15 Dec 2025 15:40:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 796E3807B1;
	Mon, 15 Dec 2025 16:40:42 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AtWgFZGG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD9DF82BF2; Mon, 15 Dec 2025 16:40:41 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E004380081
 for <u-boot@lists.denx.de>; Mon, 15 Dec 2025 16:40:38 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFHJegHD5vKUIk1Kdg0VewbZpXu7/2TAp+R7KmYlwJ8OwfFyHoz3+DkNjuSFNsej0YC/X2UxOJsabnZRTXokBXebJmpdOwG01+5OMozkrgeIymDBvAGUsMXbj9T8n7PM5mazLLKzOEEUDcpjnPvKWoA6qnqFTUU4Rr9Rnu8Al920craKWRYWD8WbYKmPC8wmGNSk8SZQNsAJTTwaoGUIcHlk6kLwqzG5Tiyeq2Vl6hekDSAS9NeO96agQxRcMgCqwE8LU7c9v41lgTHE8MsxSkKTO58YFiRTkqBM7q45+iK0bMgfmM7y3ICIxFr3lCADEZgvBLGwF0mT+Uyy3fE9tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8+cWENzZHqep0qMQbMUNUBlP+sL3T0N0d7GYEcgYes=;
 b=Ua8weW7+hKafKixHRFFfjG+DauoKQBfVrsjaq+Za30o69TNZOQDGjdZAXU3UHjexklzqZirTlfkkO85W9mWRZ5fUMJ8cnwdmhZABjlZhmXX8hCi0vz9QSSruwo+e9N1GmDSgFMmyrRakx+h1MGU0b8sZ1m1RzEipKC+9AKhdIxDuYeH6Ug/p/L3MDwXCBtUs1CfhmTibm5WVNtDxjH+PkOlZGq7KPhZIwSAZE02Rnc3VogweUnG74jhyQ4l/j0KRzDBrxaCY4p58OAz8JLYDBM9aQeJvDsvXQx7o2NXxPaIYqDT6ArF4jthdiBtJC+tuoGLkFtPzi0L4mY5hE7gizQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W8+cWENzZHqep0qMQbMUNUBlP+sL3T0N0d7GYEcgYes=;
 b=AtWgFZGGUxl5GCqbTtrxS0tiX7YufeaqfEcDAYwXMW6Hz1oe/xYqeLCrk41hlk68a7SPcr3JqYWN75aV/Bif7oEHIMOFry+nM/tC17di/GWO/L7VRbVYcWuPSBFG+IiN2y80vRUEBCeuNiyW38hwD7ofNRlDBw0x13FFg/iSkNo=
Received: from PH1PEPF000132F1.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::34)
 by SA1PR12MB8948.namprd12.prod.outlook.com (2603:10b6:806:38e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 15:40:34 +0000
Received: from CY4PEPF0000E9D6.namprd05.prod.outlook.com
 (2a01:111:f403:f912::5) by PH1PEPF000132F1.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9412.13 via Frontend Transport; Mon,
 15 Dec 2025 15:40:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D6.mail.protection.outlook.com (10.167.241.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9434.6 via Frontend Transport; Mon, 15 Dec 2025 15:40:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 15 Dec
 2025 09:40:23 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Dec
 2025 09:40:21 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 15 Dec 2025 09:40:20 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Bhupesh Sharma <bhupesh.linux@gmail.com>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, Neha Malcom Francis <n-francis@ti.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH] ufs: amd-versal2: Fix reset names with binding
Date: Mon, 15 Dec 2025 16:40:14 +0100
Message-ID: <e1082054610fe73d4487d12f4274315030592c77.1765813212.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1470; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=gpkJaYlcDyOMm5PbgqOaeyspEH5U/suZc+7ZjBRvRsk=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ6aN9TXhK6ju/ZZs+O6D/isuUKt+dN8frm1nZofxXrr
 StztnrKdJSyMIhxMMiKKbJMZ9JxWPPt2lKx5ZH5MHNYmUCGMHBxCsBETvgyMpyUt7u5RsXvwOaq
 ZaW6B9IV77XGLOzy7193+ELnm6kla+cy/C90+b6n+c3ilmnq5r9e7s9dpFi7gVtpfsPr3aYzopN
 tV/ECAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D6:EE_|SA1PR12MB8948:EE_
X-MS-Office365-Filtering-Correlation-Id: cbc73f73-aca0-4797-5bab-08de3bf04941
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?svOk2dhxHXTlVs91/dpC8wZzjaaUOKBXhjayWhM1HLICrI1y4TTxPuRenJKY?=
 =?us-ascii?Q?NhUBV9Mfk80XS0bDRfKcgnU6MQ0TaGYtdeqYyIuSEPVI7PPuns6+U6SmqRyS?=
 =?us-ascii?Q?L2eeUR+1ffTr1CBQvF2SDzRWAiSzeRnLGxuHxJU8ZedHNzWEkhwDxbfotSN9?=
 =?us-ascii?Q?V2K4cL1Kj/ymgJsa6gGVjHiIPfc733h1FiYtKVHDIJ4VzlmfCJRW6qDQ30AT?=
 =?us-ascii?Q?9DO4xSYLXWKueDqBOju69wzWLbg2EPFvxdB7pzLDstMCLUg16StpL13fMOFq?=
 =?us-ascii?Q?wM1XwelXlqqgWT7R3C2tQMoByE/HMZiRxvgnxs01WiZRWC9yOfEaxbdRJ8zj?=
 =?us-ascii?Q?Xld5tdkeD2OGgdoQK+mu3HcWJzp7AiiQEI4I6UbNRqNFoLJhRHSGmvGX+f3I?=
 =?us-ascii?Q?i689OW/v+MyMJSqicc7pa9QU56chroj5IGYtAvP3iPvbM0AqAOUBEk7Y3K26?=
 =?us-ascii?Q?GFu6GrwoyYALKkXP/FRJJPRJ4NkWqVUr3wPifZPx8MyhYSxwW453eCcJEOTg?=
 =?us-ascii?Q?wRr/IUZWWbSJT4EDF3QgVWcQZLY18ylMMWiQALR4ej6ACA7+y5sHEd7LWwfk?=
 =?us-ascii?Q?TbysPwkHgra35aRokJ3oWJQzF0vl26GsvRjRnN7OeOQHzpg1fy1EPDqjw3oN?=
 =?us-ascii?Q?vFmh8dt+RL2MM1YbbIa7QI/A39RzGjsBMKCypFRtK2cZnQP9MX7ZJaQwyYoM?=
 =?us-ascii?Q?YhWvXWlhLZQYOhjbIXbH89BE2NE4lVRfDpckVSq9ZkY4jcGoK3PcJCigAMSr?=
 =?us-ascii?Q?E0zPKLDzq6nlLZ+AE8k8nPLpsUL45WP7OfiXO2Qqi8/UzPG5+DkOC50sQC0Q?=
 =?us-ascii?Q?Svil4bFcv9xHkFrm3Hc+/QschENucHQbhueigxsyYwSwRvk+wPwGqO44jspE?=
 =?us-ascii?Q?XSJqQ6ECMurkJtsbQ5CggiiyWaJHH6zP0Q/n+z86BEvs31QNLaVnkToBy5we?=
 =?us-ascii?Q?H6SMsDdl1a0HzK7WqLxlQLP7f273ncKFyBG9dCVNaO27+2n2hwJNHf/9OcUT?=
 =?us-ascii?Q?U8JvBAG+Z8/wfdvUEJ37Wbip8oUvkOa5yocgawiIPqVbrAsLwpgJIvPg6OsB?=
 =?us-ascii?Q?99roqaGwHhvf+dzSDYHaf4CrS+yK5FefkpFf6i12hIz9jzYh5/x0TFdW3Hq1?=
 =?us-ascii?Q?3QUccas5gEw/QiVGKgL7enbxaF8eut4dox/WgvHog/Yn3tGKxzmFg3nQDtbb?=
 =?us-ascii?Q?NlUO1GTNJJWz7G2/dLgyQbJd/88urgftsbxNI20hIaey2b7+PhrZTfUrNark?=
 =?us-ascii?Q?dnM1sJVPJorDPLmCZZe6w9HKPeCEDMW6Fkgws7asBqIIq+Yq0vBaQjkNkzMd?=
 =?us-ascii?Q?bCtP+SMlKGIFEWOSZdpWZLM+psZUEPX5jAAR/tnlT9h4xg29QHRCs96ep9UM?=
 =?us-ascii?Q?Oivr2wo3pTQnQB+rBLjVAtJYNUG8dPpU4+VqjvwCpmX0MyWh06AlTbghlqsV?=
 =?us-ascii?Q?pGd0g3SikUyqqX9Jrtlds9CoE6HpOSb0vdgkP/ZNIc2LYkrZzBC8SazLw9IX?=
 =?us-ascii?Q?ALBNjKqKElaKVhU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 15:40:33.9552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbc73f73-aca0-4797-5bab-08de3bf04941
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8948
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

Align reset names with DT binding.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Binding is available here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/ufs/amd,versal2-ufs.yaml?h=v6.19-rc1
---
 drivers/ufs/ufs-amd-versal2.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ufs/ufs-amd-versal2.c b/drivers/ufs/ufs-amd-versal2.c
index bf23439e59d7..97de0756f70a 100644
--- a/drivers/ufs/ufs-amd-versal2.c
+++ b/drivers/ufs/ufs-amd-versal2.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ * Copyright (C) 2024-2025 Advanced Micro Devices, Inc.
  */
 
 #include <clk.h>
@@ -319,12 +319,12 @@ static int ufs_versal2_init(struct ufs_hba *hba)
 	}
 	priv->host_clk = core_clk_rate;
 
-	priv->rstc = devm_reset_control_get(hba->dev, "ufshc-rst");
+	priv->rstc = devm_reset_control_get(hba->dev, "host");
 	if (IS_ERR(priv->rstc)) {
 		dev_err(hba->dev, "failed to get reset ctl: ufshc-rst\n");
 		return PTR_ERR(priv->rstc);
 	}
-	priv->rstphy = devm_reset_control_get(hba->dev, "ufsphy-rst");
+	priv->rstphy = devm_reset_control_get(hba->dev, "phy");
 	if (IS_ERR(priv->rstphy)) {
 		dev_err(hba->dev, "failed to get reset ctl: ufsphy-rst\n");
 		return PTR_ERR(priv->rstphy);
-- 
2.43.0

base-commit: a5286b15d0db5b7deaab481921bf1008a6fad23a
branch: debian-sent3
