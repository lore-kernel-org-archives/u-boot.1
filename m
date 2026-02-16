Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CADFCE7BD83
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:28:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8812983D8A;
	Mon, 16 Feb 2026 11:28:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="oZvg9YNu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E1C83DDD; Mon, 16 Feb 2026 11:28:11 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6895A8063E
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:28:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYjamEKqinnKFBbkYiwuuyFond1q7vuiyahdhsBm2AftgZ6inoq/Dr5Hl3W9Dvsxe5Wt4g8O2uRKSO3+HzFs8iMnjQV1WraAZaDv1ilxv0KyKE35B9oa8BbPVVNIBB4n7/w4D0TplfrvSZB1r/HkRR9+GznBw15tzViuFzscfL/Irjs/MDSA7Pih1Kq2vxE2CK1YjzSwPTPFSZ3le9Ib9kXd33hvEOonY4s5jwgM8YfAxSnFsSW8ofWLoIeeORf+yum4x4b8C15cn3n1Cgr5/npLI7sKb0ODQsRKTdjM3DNl5Id/swknxSZh2j4hRENkielI6xLit7iaN6DqPWAhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZOeb+tqNDfFRk0FTweE+WevbcetMt+JcSuFr1L1VIcc=;
 b=q9R/GcE3R7Sxev06EBNWCMdMoVWFp9Y47IghF5qhfGEImkUD2L7pLlda1qD8LraMzchF5tm2pMpL7j025M7fxuu5AWothtWVoVkMCyhxV6OY7OcU2+UY/Xedc3gOWTy08bqVvCF95Bh9TgyNQmSZIC6gVavuFy4msp6yPKCVKC0F+E1YDMK1H52UmFwbJnfB8orGWWuL0HHPJd4aSkctkbOMa3qF9ArMamoiNZ0SDHKt281UjdNv1dPobZln4eDigBPp7WtCxMBMdkculTMeSvQVXuFwRwsQ3nfo0WRl9DlwXvuAxOwomNAP1VpSC1BumleDq/K9uJjDNd+qjWpDAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZOeb+tqNDfFRk0FTweE+WevbcetMt+JcSuFr1L1VIcc=;
 b=oZvg9YNuGVwPaQ/J9sDYr2uzsgFPzW4WzWDFxCfsyKS5bkK22W5oUHyt7hgN5zzdgiRysBbz8hJU0AFblhigUxF5ZEKEDDB/PyUG/c3VaD8gSSMOR+A4nreTFSP1vV9xtDtnQO7k5pqgZ+/PTAKFMXyBQxnr8AnLNhU3TG69DG8=
Received: from SJ0PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:33b::31)
 by BLAPR10MB4914.namprd10.prod.outlook.com (2603:10b6:208:30d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.16; Mon, 16 Feb
 2026 10:28:05 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::86) by SJ0PR05CA0026.outlook.office365.com
 (2603:10b6:a03:33b::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 10:27:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:28:04 +0000
Received: from DLEE201.ent.ti.com (157.170.170.76) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:04 -0600
Received: from DLEE209.ent.ti.com (157.170.170.98) by DLEE201.ent.ti.com
 (157.170.170.76) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:03 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE209.ent.ti.com
 (157.170.170.98) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:28:03 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHf1147835;
 Mon, 16 Feb 2026 04:27:59 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 06/10] configs: am69_sk_r5_defconfig: Disable PCIe boot
 configs
Date: Mon, 16 Feb 2026 15:58:34 +0530
Message-ID: <20260216102858.2745657-7-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|BLAPR10MB4914:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f71548d-9f1a-4918-4247-08de6d4611ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5czIc6fXdgRZZOtzHAXPMsV+Jw5oWYYXhxUxqt+nrvKFy9Bv8eY0UYw7c0IG?=
 =?us-ascii?Q?UHAMq5MU7Uo17H6JKv/e71z357v2vFIrAkEdpzl5eh/R0+q4nY2RHEshVFVB?=
 =?us-ascii?Q?3mezlcVY4XyAXm3IbjzgQe3QMFCvlX40TFOail8CNO6hkUOeZQ/rZN3k8rMK?=
 =?us-ascii?Q?nRF4NEd+iKvcNluCwrC2AN9EgQkc89aOsbBoWExNjLJisHh8PAgA3VTStutz?=
 =?us-ascii?Q?SnkPxgpzbsZI4dYEOhI1asb4+m7PSX5BDP8ZvdMk+dzZsnmMW/N9+Fi+rnSs?=
 =?us-ascii?Q?wMvmD97x6a11ya7TAI9gXJN64wRwoG7HL927fikf6aY547f3NrZnMcvNNfC8?=
 =?us-ascii?Q?l38ekNHyMXVJKoPGdGfDoMS1osDMOl+JJ3CgnglX9zicdj7ZRxgC0hKHd2sX?=
 =?us-ascii?Q?kELdw7OMlkdFbye/+tqHIJF/5qS+cOGEiYNzifnP4BlmIHMEURVPhXUxHdKq?=
 =?us-ascii?Q?DRFZhCOLPOaWs50sSFYG0xHxZ5U7ADvjX10IPHfgqEWsVXTcoWsTqITJrdAI?=
 =?us-ascii?Q?8/Ib+Me2VKNv6SGR3rnu0Su3vCpUxTeXBqZ9VTn0BaycmQED235Q4PB44Gl1?=
 =?us-ascii?Q?09I/zh28ZZE1qU9uj7ApFBC/mQQeU+xKFFOib/+CUrDWEPo5G+cgOpYLUdeC?=
 =?us-ascii?Q?Mh50qBnS8IC/liNFdtcMWe8mKEMH+Eb6kg8tjfLLwV+emkfZ/7dj1BgaCJea?=
 =?us-ascii?Q?RWOai2oc0JAMm3XZt5TllSxdIAGdFYY2MXfS5TIdz330q5i+YpMxRVI4RMYL?=
 =?us-ascii?Q?1uj+G6N9v9jY2qbYe2Ens68ywF+KcwKiof+EKKyf6dwjbIIhAwPxTG//BcX7?=
 =?us-ascii?Q?GyEIPpAltcwBTV6/XC6rnaK4y6oU6EOoze2w0GF25bWvnDWX7egYILIPk6nu?=
 =?us-ascii?Q?pSs0usYUtfhGVEeinZfTmXTjNSN3XqiFwUaGzde6n0u/V/TOdI6qLhkVffqT?=
 =?us-ascii?Q?laxpIqleq42qz1VuuhQ0v8NFmrsSFovcHQ/ggNZZ/drkV59JGWD31kpU6JIm?=
 =?us-ascii?Q?E9bP56GtLh5oc5sdq1DP7mZ+5AX6Ur3G7JnK33UfEeXEKiE5IOEwqgOPU1cA?=
 =?us-ascii?Q?hrd2LeE1sJCJAkpcJsZI9uqxgcmec1RKA+0C2SHwLJlORBzI6VQJgeK2QOLW?=
 =?us-ascii?Q?9lNdkJ+5vFpfxCW1Q85u4ndXvMqEpfDUeFUYaL8kpk5wite/QW21MabaBe3M?=
 =?us-ascii?Q?sxfrsZjoXZzUG7KUww0ptainyUzYJWhonyeVZpMb2ouCtoUclHBcVXiB1N6h?=
 =?us-ascii?Q?X6fZePil7HHcNm/p/s15QcQhbt3z199JIaD4zUVxZdG+da6hzkejGEMFahIn?=
 =?us-ascii?Q?Zq9cVnQJqWnUMKOy/SwqDux0dd1ZZrRqGPQ1gZqglLGy01ahasUW1socYN2m?=
 =?us-ascii?Q?EE8dkzx61WxE/+FRhc8e8pGUp7gm3eQyUI/kPPdgYGEo2xlE0GNize3s1iy7?=
 =?us-ascii?Q?14gNp4TfRGZzK+J9QAJ9rkxIINUYjDAAmOp8/2iVF3ETwXxQDBVzIZ7B/dAw?=
 =?us-ascii?Q?VF1QQG4IRGIsswZK3VjZi3gTn64U2ywJ8OQxdz019yczHe91/dMTxG5FkhKs?=
 =?us-ascii?Q?lrKNFSlSMcKRaeikg96VCUs4svWCAQib05aKAqf2Ul9NbKES4+ai6VW9Iuiw?=
 =?us-ascii?Q?ThF5YyvEOhwKGdLS906qbhIhU0ZNb9Ppo+FMa2HxzTaqneHfd0GyahZLIPvx?=
 =?us-ascii?Q?FqP4Bg=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wproT3k56ZIRvyVMgwhQbUL8Dk8KSPLI57YAhmV0oq+VkXeoL6wzot9DG8MqWV2Vv8QHx8RT461dVLAK84aB3QAxb8BEj9+HR23P4iLY9/Sw91yGaMZzYFb3IVSqs9mpjGoTz7MwO2+d7ITpRQckUHH1HXTqd1wil8hWFXTvLMhHmcterpEPoRI6KB/F3wr679XGf+OGrxS31s2Qaj/NI+5VcotcEbA8+6iYlhmPvUTnCtEZ3uXOQOSItMupjtdhYOULL77wfZUXG+1GVF/C7L/TlQnrbnAAjV8xYVb43Z1KmGGK9Pzf5VkCx7nXSZPJNQfgnf/G4Rt3aLOCXjgzvSjOSh5F9yblAYkYOXYGBZRyCSbf4DIUrLOuno0Hantck03oTs6eUFvk5W5ku9197DhIczmEuQvzKf+gEN6Orh1smsk8adSdQXRlx2X+Suns
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:28:04.7829 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f71548d-9f1a-4918-4247-08de6d4611ed
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4914
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

From: Hrushikesh Salunke <h-salunke@ti.com>

AM69 SK does not contain PCIe Boot in the list of supported Boot Modes.
Hence, disable PCIe Boot related configurations that are not applicable.

Signed-off-by: Hrushikesh Salunke <h-salunke@ti.com>
Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 configs/am69_sk_r5_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configs/am69_sk_r5_defconfig b/configs/am69_sk_r5_defconfig
index 2186b9a0490..166f774aade 100644
--- a/configs/am69_sk_r5_defconfig
+++ b/configs/am69_sk_r5_defconfig
@@ -5,6 +5,12 @@ CONFIG_ARCH_K3=y
 CONFIG_SOC_K3_J784S4=y
 CONFIG_TARGET_J784S4_R5_EVM=y
 
+CONFIG_MULTIPLEXER=n
+CONFIG_SPL_MUX_MMIO=n
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
+CONFIG_SPL_PHY=n
+
 CONFIG_DEFAULT_DEVICE_TREE="k3-am69-r5-sk"
 CONFIG_SPL_OF_LIST="k3-am69-r5-sk"
 CONFIG_OF_LIST="k3-am69-r5-sk"
-- 
2.51.1

