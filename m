Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F7BC27C77
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 04:49:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BFDD3882B7;
	Mon, 17 Jun 2024 06:48:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="yUYyw85X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2E2C488246; Mon, 17 Jun 2024 06:19:32 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::623])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2B42880DB
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 06:19:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ksGnKsrjCrPDtoj9h7d+OlQCm1nRbgDBnzQU998NDFaV1H7blqTaeU4LSlkATX7MEoObjFSHEEiGq7eQh/1irF14Niar2iZY653SuD/XjqyjRmEDxFak0GcaSMvhnf2x8JZdi0yLFw1FQenz6ga2TVQ5tDxuM4pHdoZjGnEaZrL0dxfMM3b8y21KXDh+CRi1svx9SYwLqEbJ9GD0fGOryRNtQThfxbWemKYJr27DEWmo9ELZP/gSFmozHRu7KPnnXd1xSFDd0zgamlcSxm/7yWsFqucjjvGvaY9rrGaz+8b3keRl+xPWrshhzEZpbP2VipT2AsEGA5Eb6z0M3qeuMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLBDDUGPQLEaxn4uVrfSXjuKM4GOLDnhsTpgLWQ8sk4=;
 b=lFVZP4qVo9J2uiCDrVY3yXqzx0vvPDIx9AWg3IW2wt0lCXHSMMvBxr5e6J4KSt87no5+Mu4o023n7TKlSpcjv4bnkatpBCW1ESokcjc6LG/0NNg3p0Ik3fgdgjcCHpwhVOAPOQQ9rj1Ferz6pkzGigYQxlWJkarvLTFbuYUG/6FfYAWlx4LpV3iQRkesvU4bF3105jxR+h1VKWAoM5Oqn97UZs5UYIqoibP7crzQHTX5YKVX0yuvrPBZM5ZNNxD6y88/3oZQNYMigeiL+fX+5BwdZHIksBVfrK1vXurrEf7YlQ8kmezB6qK4Fth8+9a+0UqoGQ48Jo2yCW4/Qvw/qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLBDDUGPQLEaxn4uVrfSXjuKM4GOLDnhsTpgLWQ8sk4=;
 b=yUYyw85X6lCUQb9hZryD+O5adoH5jfNriaXsXWLJtdNS85E2RpZfJK1ELpoS97mpf3c8w/aQULmV56l4TG7N7v3CIKbxWJncmBPpY1O7sxXdWQQN76OzhSMqNO1LbB/I3qy+4vjEHglxcmR3KH+4RrrkNNZtplKgiaS0a6lfBkQ=
Received: from DM6PR05CA0045.namprd05.prod.outlook.com (2603:10b6:5:335::14)
 by DS0PR12MB9275.namprd12.prod.outlook.com (2603:10b6:8:1be::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 04:19:25 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:335:cafe::f4) by DM6PR05CA0045.outlook.office365.com
 (2603:10b6:5:335::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.27 via Frontend
 Transport; Mon, 17 Jun 2024 04:19:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 04:19:24 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Jun
 2024 23:19:24 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 16 Jun
 2024 23:19:23 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 16 Jun 2024 23:19:21 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH] mtd: spi-nor: ids: Add IS25LP01GG flash support
Date: Mon, 17 Jun 2024 09:48:42 +0530
Message-ID: <20240617041841.1336632-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|DS0PR12MB9275:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b4034b8-1dbb-4541-ff06-08dc8e84abe9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230037|36860700010|376011|82310400023|1800799021; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yktcmFMNBpvcGcITGhNiYnPtF903ZV0JkSv1nPbSVtLsV3J9QtYCP8gCgK95?=
 =?us-ascii?Q?7sTh3/ADtDmPeyJ1qekJ7uLZa8JFNFTO4OYPrS0zMDSv3MP/6qjA2wbT1dXf?=
 =?us-ascii?Q?at0s2jQyhnTKXD5q/Wm+AFT/uOiuMqYTQF+drDpno6sNNu1o0QR+ViprOPAf?=
 =?us-ascii?Q?4A3BCs9BMkY8A+CC+F6fMSNjez8R/r6pKG8nT+rYvghl67o71n/CpdDkSQ/5?=
 =?us-ascii?Q?e9KScXDbKUDrZQBXLuFS7fYiEXqVpdDEbaoQu4Ws3HYpDeMEmFgWHsc8WoTu?=
 =?us-ascii?Q?SIqi1cZJb3ELxaMmO7zB7NwSwMv9rJyT6KaxVFk0Uc4CxBQY7NwObyJzJGmD?=
 =?us-ascii?Q?wfe7F8zxBleIMEiurqT0h3v5wmQ6lS+Vtid0bODTJL0qLeuz0ix22Nieb1R0?=
 =?us-ascii?Q?IQkk3OsXA/yH0ujp0NJ4IcO2HNQIvgzBEYBRzjOyHiFx2zv5Nsd5vMGg6y/i?=
 =?us-ascii?Q?HXXpzo7Ui7uyrswOhCFNL4r84kb2MJxlJA07genwdoowLxrP8bAVEQ5iRPA+?=
 =?us-ascii?Q?Tx8a7HYEaqm6nLMDe4JjoPsSqqE80J1RTssX+dKHK3XslLUrG0A/PtNpoxsg?=
 =?us-ascii?Q?w2mHFvGfulO7lgeSwzUm8/oqaWuXGQlTo++WN+8npLzyNOYgxq3WJfatEB/T?=
 =?us-ascii?Q?s/AykPNGoPjxciORAbLnUlKzF17/l+gSJZaFvT7Q5KvgJzWTt0oTwQIwaxjx?=
 =?us-ascii?Q?PLi970aVLW1qIEZ2In2ZAhKxLVgy6npoApa74thCVw6HLJr6a70dsrnQl0gL?=
 =?us-ascii?Q?0gbpMDLE6Z8pImrZAul/cFcHONALpKutYnDSBsnWIi5gbU2zSg2J2RchzdhY?=
 =?us-ascii?Q?lw6WkF+8dkZiKRQ1E9rCwP0BeOOsHXkCD/SSuLhHngB26KX2iNTorM83SWFU?=
 =?us-ascii?Q?JVMLNwOa+YzSy1zGKYnAhvxESy457ILpsc6noefjwpBc+M0uZC3BJfAS3pjs?=
 =?us-ascii?Q?wmBVaPXstHA7MLz1xft+MYE2TJNwUdWea6jKyrCJGc3Q8J1eE4d0o4RXanTx?=
 =?us-ascii?Q?9aiHCNfS9OoBqIBhtEmzSin7SjOYwxf4PH1Q3IfSLEIBIakH0Rz8J7oRURcz?=
 =?us-ascii?Q?BrTEkjhPuL0uEBWZyBBvb+t1N2nBozz/xxLWgWRwE+7Zk/HnzEhKuzfop53P?=
 =?us-ascii?Q?1Qmssh2Te37QZLPZqjoUZXluipH1VFjV5rbC2tMkc7G1VFT4t7vacWusEIx4?=
 =?us-ascii?Q?Wl8wCQ7UdrHuFVmsfbg3waar9esnX03E3EXSYtEDT2nI/9JjeA7LxH+UmsKA?=
 =?us-ascii?Q?R895zmkwIy9QmvtpOi2cu+Rkz3W8+v3tSbwMFpJyGnSqcLcafe6q7xzEPNId?=
 =?us-ascii?Q?u82KNbC/L1RtXTHvBMVkovIgNaqUAHv7gyFCmGEj10zpN8JCzRYS3bzNhVRk?=
 =?us-ascii?Q?55ra/DbvKyBx+RqhWlXdQfnbwqXZaEU2k1GKIetAVmhh12WgHg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230037)(36860700010)(376011)(82310400023)(1800799021); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 04:19:24.9740 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4034b8-1dbb-4541-ff06-08dc8e84abe9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9275
X-Mailman-Approved-At: Mon, 17 Jun 2024 06:48:41 +0200
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

Add support for ISSI 128MB flash IS25LP01GG. This part
supports 4byte opcodes. It also supports dual and quad
read.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c..8cad764237 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -242,6 +242,8 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | USE_FSR | SPI_NOR_OCTAL_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("is25lx512",  0x9d5a1a, 0, 64 * 1024, 1024,
 			SECT_4K | USE_FSR | SPI_NOR_4B_OPCODES | SPI_NOR_HAS_TB) },
+	{ INFO("is25lp01gg",  0x9d6021, 0, 64 * 1024, 2048,
+			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_HAS_TB) },
 #endif
 #ifdef CONFIG_SPI_FLASH_MACRONIX	/* MACRONIX */
 	/* Macronix */
-- 
2.25.1

