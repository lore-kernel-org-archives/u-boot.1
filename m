Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A209E7BD88
	for <u-boot@archiver.kernel.org>; Mon, 16 Feb 2026 10:28:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C6A9983E13;
	Mon, 16 Feb 2026 11:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="OcNRrzT8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7F3783E0E; Mon, 16 Feb 2026 11:28:13 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C430783DDD
 for <u-boot@lists.denx.de>; Mon, 16 Feb 2026 11:28:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=s-vadapalli@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E2FdOskByitAT6irPuog+oTur2hSLKp8KbsO9xIioGvf9cALsyVGRRAko92qH7gi4TDG9MAt3e3V8UpEfZtVvpX7K5reVyMv7N8gtzjaUNqSvYp6XAIOJ/SOw9tiUrRXBu3vPb1FnwZ1W71t3HWlFGwN1edy7e1JbsNUjT9AtgF3yn8x27h4YPotfzCwxhlwTIz184N/cnm68Y5BsA4u8TTOFDcroP+552sHadKa7pHaUCCU1HleolB8BlpZ/WT8J7S2D7Q5sXQ+iBymbpjHMhtFbEq+R8WI2XxmN0y/DvLdk7clwGe7k46cfdR8rYFgFgmCWaxXtsU+Mlnb1q2B7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RUQhpBAvXJO/ZDEdz9wt/0o3rtLZFl7jl9iwKuSQdk=;
 b=fDePm2PbUHrPh1Qp5nmiqkhix3ULldcyWkscmgGEu8OImGd1IKfuABdwoIA0ImoWPYGGXJFT4Z6ihh411fHNtEVaqA4O09lGqcmkEBw9dzZKl8/Rt1lEl3xdECILMxA6WcZwpKimAvuN5S5Az9coutlGXJ1+hJmZTJq4lg1cJrCil6NjTZ8EN8Hf6WXKy1Ryzcrj1+S/ig+/Q3v3YdP9AaqQ8TdmOh8riHKalEUZkYXEgPXfmnUkzzj3h9WDWTrALCukmgiQaIoKhFVAvsg7DQEFK3N6U99+IYIW1UzieeJ48xMX1XdC8tqTIKtbL12c3lGPDEsakQfkqQuxh4ka2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RUQhpBAvXJO/ZDEdz9wt/0o3rtLZFl7jl9iwKuSQdk=;
 b=OcNRrzT8tPKyUNBLIACR40/5s3t7IAhJFFLIoecwU936UtaC+Ojjh8ppbRWn+8W1CBUblu7Zfc52pJuteUBDIXg0H75L/bvtwrEywxnmCtiHkVq38VL6OAxTKl02cnl0441QzA57BHPLgq0bFpR4mA/2gwr1C7JJIJGGtQ4XBKs=
Received: from SJ0PR05CA0085.namprd05.prod.outlook.com (2603:10b6:a03:332::30)
 by BLAPR10MB4898.namprd10.prod.outlook.com (2603:10b6:208:327::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9611.12; Mon, 16 Feb
 2026 10:28:10 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::b5) by SJ0PR05CA0085.outlook.office365.com
 (2603:10b6:a03:332::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Mon,
 16 Feb 2026 10:28:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Mon, 16 Feb 2026 10:28:09 +0000
Received: from DLEE214.ent.ti.com (157.170.170.117) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:08 -0600
Received: from DLEE208.ent.ti.com (157.170.170.97) by DLEE214.ent.ti.com
 (157.170.170.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 16 Feb
 2026 04:28:08 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE208.ent.ti.com
 (157.170.170.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 16 Feb 2026 04:28:08 -0600
Received: from toolbox.dhcp.ti.com (uda0492258.dhcp.ti.com [10.24.73.74])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61GARUHg1147835;
 Mon, 16 Feb 2026 04:28:04 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <trini@konsulko.com>, <m-chawdhry@ti.com>, <c-vankar@ti.com>,
 <neil.armstrong@linaro.org>, <marek.vasut+renesas@mailbox.org>,
 <u-kumar1@ti.com>, <j-keerthy@ti.com>, <semen.protsenko@linaro.org>,
 <afd@ti.com>, <anshuld@ti.com>, <peng.fan@nxp.com>, <ahalaney@redhat.com>,
 <mkorpershoek@kernel.org>, <n-francis@ti.com>
CC: <u-boot@lists.denx.de>, <srk@ti.com>, <s-vadapalli@ti.com>
Subject: [PATCH v5 07/10] configs: am69_sk_a72_defconfig: Disable PCIe boot
 configs
Date: Mon, 16 Feb 2026 15:58:35 +0530
Message-ID: <20260216102858.2745657-8-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260216102858.2745657-1-s-vadapalli@ti.com>
References: <20260216102858.2745657-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|BLAPR10MB4898:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d728186-9d30-47d0-b4a0-08de6d4614bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YKZ//QLErCVFpuEYreD2hEnvpoYix8Wh1Qz0XPthE/jx6EA96xP9Tef8M1yK?=
 =?us-ascii?Q?Y1ivc8n5x1rr9jSDUc5XbhC1+nzRNE3AcDA0w+eqir7Dwg+QlONPDav9v+T5?=
 =?us-ascii?Q?1zcckGqCBNuNluCtgXPibAZo/WFUwm6KUB0ATTMzUGg+gBqnp7HHnd4nQ+/I?=
 =?us-ascii?Q?lc2SoQCALD9+s4oQqgXOi8BHXQ4qzIRJmwROyVrQwCmxKXB9MG5x5URxZGk1?=
 =?us-ascii?Q?MVXXIzXHRGhh9VPHmNR2fHL2Uzs2YNh2F1Y/wTTI9t3apLL69A2pv4feeLac?=
 =?us-ascii?Q?5joWJCuv7N8BbVhTJx3fE0PQXkkOxdxCNVR73Hq+4YkdEpQMnkhDlR9ksPmt?=
 =?us-ascii?Q?us/PeswzjzWReAY/w2gAAzG5KLzakikNi+18Vl/z2vsRWz9rw1Ldc7HdOVrU?=
 =?us-ascii?Q?Fnp/mliixbYyn7fvpbnio2n3ltSC6UoXXLBDMrQ09pyEfS7vlBYepQVvaGzs?=
 =?us-ascii?Q?DONaEw2lvg2fRA+kBg3CcTBXyqEyvrP9EIl4+P14xZPSd1+2f+BJd0xNzbX5?=
 =?us-ascii?Q?RW9KQPi2HcJNv6ftzoxLRyE58H1l6tflGeqVs1QcezsFH6XV3BVEAZZxWzl9?=
 =?us-ascii?Q?dwGUtgX9ve32a87qU0OWQb1s8MvBeIOXS3+jzRNX+e+VjoBWqnXLOLyGCWw+?=
 =?us-ascii?Q?leF1vQtGWkY1gw3pmIjLkpICiIGf7S3wb7jgOjI17cgzn3HOpm+yKHbVQ5pC?=
 =?us-ascii?Q?i7PlJA3EC/IRcDwqpV1+GwIoEwjOCObqnhajzwN8yww/h5aiG9cMCKxp3Ky4?=
 =?us-ascii?Q?9g/8a/NCVzyUMI+Rhru4mqwCHturaVt4LEo0+zFSYxWGPb75zWotmkwNCzhB?=
 =?us-ascii?Q?o/KloQvCRKaKKQdI2fA+pB6AiyH+KK8Mpl+qwyfe8FX9bs3Hd2JywuQH0604?=
 =?us-ascii?Q?kqyHIAS4nsehgUGRqidZHrNyVNW9nMM9wZPgDBJuJ0Xd81Y72EpMo5UkkBoG?=
 =?us-ascii?Q?QVRuqIlEc3fjJqGiX/y+GkMzCGyDDKdJa7McTkdcPjmVGX9iksgNuS/Mktpc?=
 =?us-ascii?Q?TS9U3+6MynFTuepVZz0RH+Rre/SAuT6T7jYDTHdCpUqqMsTJLWV/CQif+DFN?=
 =?us-ascii?Q?HYpyVObXr3OoWbPda6SEW51l+xTiTxbYtP9qmKuMYf2E26S4BsHpSNw9PZ4W?=
 =?us-ascii?Q?9jfVZ5k3nj2Hu+k9IJznMjHnvfZD878RcYlY++UcxTXf31FymxalHJmHI6Mr?=
 =?us-ascii?Q?9HKwFwo8LwDKnsrCW3IoPxkHEz/gpINLFI2QOn+vkLwymOREIgBYBMtbU8Zu?=
 =?us-ascii?Q?wjVIc1fYukCnHRSak/8wmQcN7d8zoLaD41p0SsYSNr+4n7pazd63taFNWsBg?=
 =?us-ascii?Q?u9HXoDXPl4nC3AADa59US6AG85Ln2mUIafw4lkon+pw1XtT4/xELeqoNSEWa?=
 =?us-ascii?Q?/yNbPiR+Zeq3pMOIcp/2LduJy6jwVLh3TvA1vrVrZp0nPmy7Mf9nGnmQplIz?=
 =?us-ascii?Q?DQnduPYYsvI6i/3UYPVH5bwL7UFXda4ZfCE0AvHJT7kme+rre71q1d9a6vu5?=
 =?us-ascii?Q?It0EpOjAU/We59zdqDVkj8x7hrk8zAow2hu9LN7u98tLMhMmkgAUPp4L0uqR?=
 =?us-ascii?Q?S3L8uSO/zz06dwCEjJrs7ZusnxtG3SOa48ZyTaN7kgPPrrfOWsehhNXK9bDZ?=
 =?us-ascii?Q?YQSefGKnWvITMg7IvAcmVSC1syWIyFypog8UKmmEuzlr2h3/GljDrkr4Cnn7?=
 =?us-ascii?Q?4TmhN1wBhdcdbz/ev0eKarpJrXA=3D?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: RK8DW+S+1DikzWIuMuluE6AmfYxyb4orTRHOlmirw1NIbPNprQrct71PuAa0knLOpL89Fy/xVWJ54c0tv4KWCbxEIIjoWw/Jd/UPFVJ90V08o++35/EuAYrZ2YaFs2s5WjjXqG2DRoz5JyOEgKZgdXgbMT6C3aTzp355YWxx6OV920EOE6/PwvH3maEcz3bLwFPLqyE5fxEUIDPLM+jPANkOr1zzpHl9ClXuUXypNki1tv5ptEYN+oiHFxYI//nppY7XKdCUfB50QCrLYjcdcjbOOBj+6JaGYiRmCWZB5PpMfOnjKPYttXoLCpHwftU8ImRob2NMMbJ7F/WQRJV7U7xPpfYW/SIUNbPaJY/f64J2p673GTAwskoJb8xRnJTradSeQYLG8Y5/6qsSE9+KAfwWRPRDOBHaEBzRhaQ8UpIqG5yrl2Ps/yqPb6mHyRJX
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2026 10:28:09.4820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d728186-9d30-47d0-b4a0-08de6d4614bb
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4898
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
 configs/am69_sk_a72_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/configs/am69_sk_a72_defconfig b/configs/am69_sk_a72_defconfig
index 746b36a34ed..cf2881258e1 100644
--- a/configs/am69_sk_a72_defconfig
+++ b/configs/am69_sk_a72_defconfig
@@ -9,6 +9,9 @@ CONFIG_CMD_UFS=n
 CONFIG_UFS=n
 CONFIG_UFS_CADENCE=n
 CONFIG_UFS_TI_J721E=n
+CONFIG_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_ENDPOINT=n
+CONFIG_SPL_PCI_DFU=n
 
 CONFIG_DEFAULT_DEVICE_TREE="ti/k3-am69-sk"
 CONFIG_OF_LIST="ti/k3-am69-sk"
-- 
2.51.1

