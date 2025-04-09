Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01706C369A1
	for <u-boot@archiver.kernel.org>; Wed,  9 Apr 2025 16:27:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F0DC6838DF;
	Wed,  9 Apr 2025 18:27:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qbLexEww";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0DEF5838F0; Wed,  9 Apr 2025 18:27:00 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DD613838D7
 for <u-boot@lists.denx.de>; Wed,  9 Apr 2025 18:26:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QEOQwlCZKtUbyjHaAyyp3oDNbFGPHrQD9BawHDq/1sh/xrJJIiAnQhyVtkWsnETBCzaFiR6Uqbk+nGYWpF4rU0SEw5OODGLlLr7VYaFKzi9x1W7nuG5G27nWZRnKweVNqe+g8YV7u0+DcygzAcWUuD73b10WnXcUa+MOpjRs08bianESUBELjQykaDtWuNQ4NNi9j6CSbNYQN+se+tbTQjYtVtSoEii8j3X8A5CCrHJ5V0PsfivwSXL+Wd+RDH6UzVbfTLvSSiiWedFAxqleAGhN4IwDqj0TqGqpA3nPXf7JLH//KeXs3WU6Gd7NLXpJdY5qSqyST00SkuOllavb5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8E1z5eCRDBhZ5sE+2tx/zvXx695AJktIx3PLZiiHWQ=;
 b=FE2tv+QlLQ3ygrAcznln0ArTJ4alL9yJ/1czMxYH6OxygFo71QOSF8h0g/a7DD9c2dxMeD06Yy4KSQlgTnKOIUdEgKWqxiL4y4NFXNb+FM5ipRBNYfphVyoCFCpY6YVAg3hQJ71wsP6hPWBXYKmLNX3/CUi7mvW7Ujl1jslfFwrd0OgkeEkYsav3EZ0tSDntxHM5zedRR6MykXsV43b01Aif4iubLjbYaudE+Z7Rx1gaC7fJ3XtohaIu9rPhKszNR2FDSndPF0DU9KamMJDLCLXCj4I39kMQowSJbsbgLPYgjGD5w2dE8guJGf8YxLxjnqv6jMOK2L0e6GFyQ3DpCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8E1z5eCRDBhZ5sE+2tx/zvXx695AJktIx3PLZiiHWQ=;
 b=qbLexEwwtvQSNDLYzaVKjJu4K2uHc+hgk4oH2YqMe8zC6Gzf+a656PLsRVC4BcsFyDd5CJyN0S5r1v66koMoSgcIiNTgkCQy3or1764vc3v686p8eZEbHgsKvjdJ/vkRcRlUd+iDbMCgNV4EoLz6jraip5QFISxghsjr6gVfyeE=
Received: from SJ0PR03CA0148.namprd03.prod.outlook.com (2603:10b6:a03:33c::33)
 by SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.23; Wed, 9 Apr
 2025 16:26:51 +0000
Received: from SJ5PEPF000001D0.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::bd) by SJ0PR03CA0148.outlook.office365.com
 (2603:10b6:a03:33c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.23 via Frontend Transport; Wed,
 9 Apr 2025 16:26:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D0.mail.protection.outlook.com (10.167.242.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8632.13 via Frontend Transport; Wed, 9 Apr 2025 16:26:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Apr
 2025 11:26:49 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 9 Apr 2025 11:26:48 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>
Subject: [PATCH 1/2] arm64: versal2: Remove dtb reselect and multi dtb
Date: Wed, 9 Apr 2025 21:56:38 +0530
Message-ID: <20250409162639.588487-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.44.1
In-Reply-To: <20250409162639.588487-1-padmarao.begari@amd.com>
References: <20250409162639.588487-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: padmarao.begari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D0:EE_|SJ1PR12MB6075:EE_
X-MS-Office365-Filtering-Correlation-Id: 84c17a4d-493d-48d1-c4ed-08dd77835563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?AvgNDgvz0U5zKnOzvGwF+KQ868fODxnbvPfnF3WOb998dLF0d8SeYfOzxTcc?=
 =?us-ascii?Q?YtKrC39vsOdwh+uLue8tOgayWxHclmqMZ42VaX6dToFiG0NoSKROqdF+Reao?=
 =?us-ascii?Q?eEGTsSginmqoNyZRNQHK1KDzCy1A45NwkqVkg9nbcClmAuRvSo+2rMJSnXCI?=
 =?us-ascii?Q?3+p7Jx7dxBsyTdAF9ObGjUgx6qg85W+PI1xWAZiosN1annLBjq4VPt/lM4u4?=
 =?us-ascii?Q?BQRLb/94DPTDKR5BeVWCayuKjgHNubKLoqHjz2Ba+HRksJQghcmnIye1bjGs?=
 =?us-ascii?Q?A2VaytV9fMc0V1nZg17CiobOplS3AEP8tccD8u5SnTSAT+/9Hjsb66+n63js?=
 =?us-ascii?Q?iu9FoqiXXI6YaPo2ddA3EP9f37Q9ow7MtYNUIuE9Ad8oqB1jDM7Uuo9Ooh3W?=
 =?us-ascii?Q?dFeB8CDM2PLBqASTvU/LUMljtnjAnHDITdWr+A0/fH00mhi2zWlxGgn5S6KZ?=
 =?us-ascii?Q?d3xzZHd9pKx9CGSAsreWRBuBJpTCkdU+HJjOfXmVENaOWnusMYmgoDsSz7sz?=
 =?us-ascii?Q?T5fGFG36gjdKd+ZGrd5eev4cyex6wYc6LxrCRsauVxxFlBj8NStkHqWUomXz?=
 =?us-ascii?Q?ameVccBRlGfJTgYBg9iRv4lgEl//4PmhLrBW94dvWf5cj+BlQ/7Svz0N82JV?=
 =?us-ascii?Q?lvJKNs2D9Wy67qDfcs7oLE0zYEtLl923MsP3TO2UGEGJVWHk+4IXBxK6GpL+?=
 =?us-ascii?Q?VvpE3kQyZXNfpnWRunbRATf1z+Rv5BYaL7FFBCDkVKtANzud/0JaaviFGnjb?=
 =?us-ascii?Q?HJniO/HrmYLPhQW5oLEVbP2z9YpKVay2xKKxepghtk/iPvL5KXp+XMq019zQ?=
 =?us-ascii?Q?kGgPIOdz4jvfWuFWdK6vW8RJ2cVhW3iS6PAZ1stjJzj53sO4BvBlPP6O3ELu?=
 =?us-ascii?Q?Os/6v6uDmttlCo9ztl+XxJfCF5/FwrCga16cD4YTE+cT+oxq1LKSdgPykQna?=
 =?us-ascii?Q?2/bOpP4v1o8W+tm4lG3Qc5cMvOuyZp16JhnMsYfKOvzi1EY+UAnXM+TRhVxk?=
 =?us-ascii?Q?IrUyUZL7mMsbVZ9+piCOJ07H+1IW9CPiaJ3b0kwLnfDFql9RA9zcHVrS9e7n?=
 =?us-ascii?Q?jBAQtFFIDZXK6ZAisceIVhHLJy98+PD1ZGBwBQCnFvNFaSizpY9mT+vIjUh6?=
 =?us-ascii?Q?/kTH2qvnbnUkjL5713OkRXrLZgEC29mkJ6MBFFu30TELbUDE1A8gxYwMq4u1?=
 =?us-ascii?Q?7snI5lA0BzRZX8ekN2CCuh50jfzhrthlDqo7vj0tXqZD1U6MJTR3JHUsanG2?=
 =?us-ascii?Q?R+UTUtMOnd9bGy2+mQU+FLOgP97QrXPu2xVRlNdYWG0lnFjDtiMfyuBMIgzJ?=
 =?us-ascii?Q?CVyVPhas8LKtDjDoT3AmKAyYfCwO6CuSx0DquskzYHtc4z2NOudCU4H+t1Fx?=
 =?us-ascii?Q?Y+qGz7nMIQq64/asE25r2EYN/NYSGrb4HKbLXCMv8ffdpEDPJ2SMV8WcutRG?=
 =?us-ascii?Q?i58pOMW1+v/ZD+jIlSSOop+NZe5acTT4O1+fxyD3nQbeovkDww308rXJiZZj?=
 =?us-ascii?Q?nKAn0LGjbOGE9PNOInf46NOImEU56abHkDS6?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2025 16:26:51.2251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84c17a4d-493d-48d1-c4ed-08dd77835563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6075
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

Presently the multi dtb's are not using on versal Gen 2
platform, so remove CONFIG_DTB_RESELECT and CONFIG_MULTI_DTB_FIT
from defconfig.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 configs/amd_versal2_virt_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 9911caa0e46..1b8bd17fa8e 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -64,8 +64,6 @@ CONFIG_CMD_MTDPARTS=y
 CONFIG_CMD_UBI=y
 CONFIG_PARTITION_TYPE_GUID=y
 CONFIG_OF_BOARD=y
-CONFIG_DTB_RESELECT=y
-CONFIG_MULTI_DTB_FIT=y
 CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
 CONFIG_SYS_RELOC_GD_ENV_ADDR=y
 CONFIG_NET_LWIP=y
-- 
2.44.1

