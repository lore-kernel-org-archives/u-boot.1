Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CC06E65D3F
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 09:40:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A307E897D6;
	Fri, 22 Nov 2024 10:40:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zjx7zOUt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BBE81897D0; Fri, 22 Nov 2024 10:40:43 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640E8897E0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 10:40:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JGCgU8t73RDm+aTpmX0G3Yalq9t5JPkzRBX1NZvA/rIWQ62OaeI5xC8woUHCNn0bjeIbrpZV+Adcf7W5Qf6V23Cz+eR/dPkZMt15kELDnNZJAVQzyMw1nonE7MCwqIEzoadTPXSB18g5OcrVg2rvhsVzhUIE7/+tr/SooOg2eEEV5Ie/n9jcCFKD/9YgwDubdSWxFF13pBdk3BhbUkhWmrjue4RzabLCmF0yjsKZvQ0s7nstQeVT8tY/wNb0SXXmmh3Du61Gquop1Wv6QKGDppaQ27pgh4p3l5px6InGN4nfnQSB+llFtlHZc+as5f8TtHpulQOPMcdHLBwmn8UDQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nz/E537nh/b7ojIPdmUZLYZuu0inYh/DsuY6OcFsbv0=;
 b=myMvQ0k67EWtPI/ZcmdnjVSqsr1D7ydeN58bqEZVmgXZvyjzQLIWOJSt5M42SKHsBQXM36zbU/WfuRsYgHNYMTt/ahKvIg1skBvuxQeTtjF1BcslV3HMGyRVfY+vKOKe1UQnaxO33ecsnFbI1FqnIn3UQK9A5Yet/wPKGYeIFAsgQD5XDqsSUhB4oXW82aeSeL8iU6G3N6NcR5VEnDAXsDaUQ9QggJLJA64sC4Ark4BvS8l2mtq/mQz2/jCHEszz5QqqhnZ+HEOyAxljKYnbC/7G9X8uZgXETw0oSUR2y6uuh/dJ8WRYm8Or0ijcTcGYDEx6UiZp5jjrI38Oa+7SmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nz/E537nh/b7ojIPdmUZLYZuu0inYh/DsuY6OcFsbv0=;
 b=zjx7zOUthqwDCLtQiop47vfZo+naZJTJ+2x1wLYjJt8tKqHtZVM2wpcW6TPQk93CHSyjEdNaNp/4/2a9aXSwucoetz3w4zBhwNuKv57saJvQsZfxhOSm+rzcxsKHuhHg5WFEz0SQpYz4MzrRWABcBKuSCme14UwwWBdCwmUXwac=
Received: from BN9PR03CA0413.namprd03.prod.outlook.com (2603:10b6:408:111::28)
 by DM4PR12MB6157.namprd12.prod.outlook.com (2603:10b6:8:ac::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14; Fri, 22 Nov
 2024 09:40:37 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:111:cafe::cc) by BN9PR03CA0413.outlook.office365.com
 (2603:10b6:408:111::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8182.16 via Frontend Transport; Fri,
 22 Nov 2024 09:40:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8207.0 via Frontend Transport; Fri, 22 Nov 2024 09:40:37 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 03:40:35 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 03:40:31 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <j-humphreys@ti.com>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <tudor.ambarus@linaro.org>,
 <Takahiro.Kuwano@infineon.com>, <git@amd.com>, Algapally Santosh Sagar
 <santoshsagar.algapally@amd.com>
Subject: [PATCH] mtd: spi-nor-ids: Add support for W25Q02NW
Date: Fri, 22 Nov 2024 15:10:24 +0530
Message-ID: <20241122094024.1392195-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DM4PR12MB6157:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ad3fc5-b7af-47bb-df17-08dd0ad9b880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HSBEtQhjNumZzkEuKLQX/fS7AYXBBx+S51G9GNEEdWrNlqHmuYqm7XVl+qxm?=
 =?us-ascii?Q?VUBSNbam42m8oQe5qwcjIL9RooOmX+dkJv5cGcn6q1fjHjg3PSYY+Vv6WmMZ?=
 =?us-ascii?Q?2JgOU497307B973WoAvuifF3YwA/GYLXdo8kKCkNoWhl/nXW9drT698pDXO6?=
 =?us-ascii?Q?C5ruAulJvTUtseolTs7HBvi5At7wa4pfBMrLi5pxcsQ6n0U8ahCfQ32PvUeC?=
 =?us-ascii?Q?j36gaRM7ANkDgEvxEgj2csIwLPTogULBADAyh8yduplndFH6FrblH/eVi9Io?=
 =?us-ascii?Q?P7NfJHTAq0YcKjUCNDjJD6nipiQdoGiENCgTrnmu4TwEMN0mhzr0SPR4+O+1?=
 =?us-ascii?Q?N82F5/3uKbzBG24AihgX6ZCd+RvAhnWP8jhTPXlDv74kpxBwB6h/hwrLZyKv?=
 =?us-ascii?Q?f4mL+pzD7uFgS8eJtidZIU5Zk9AjcVdFm16BAD7yTiR6P/caVkz1BoBri5jL?=
 =?us-ascii?Q?UbMaCOuNf+sXKu3+w0f57nS19MaZeFWh8WU7849Q1HPUTE3UpF6Gy+mlZ5O9?=
 =?us-ascii?Q?i9+2gegaLg17oEwMelnJ7zTaOyayEkWIsVM3mY0Ou9SLD3Dd8A3FCW/igrjq?=
 =?us-ascii?Q?JVsR6Gduo/1p+1rbMJdTyrlJakHP3n8qS6/xo+XYH2f4KHB+ogLjxgzDPLlu?=
 =?us-ascii?Q?oWaBaQHlQsz07WdQZMvsn2Qs6awCOEvfcXqJliHTDFIMGHc7wQ/RuQ1bEk4s?=
 =?us-ascii?Q?gN7BSRQFq3PHf3Qx7LmURLdCQ72YO6V4YV+K0TkONtFplN9YbO71Rit8Z9Ar?=
 =?us-ascii?Q?6iQBw+u18RY/bDDKld5yTAsNbRaLdcHRgSewEUjY1Kj7ItvhMyW34SF//pU2?=
 =?us-ascii?Q?wHcmig65xL4bMkftemB5tgOe7i7kIOzE3dKMo4KRHSQTVqzU7NzeVJ6b8jyS?=
 =?us-ascii?Q?DFbRPQqp3VzgbHM8PnjshdlJH6cKY2GQqAs9u9iqle5P4/UdwuIoPoFPfHMw?=
 =?us-ascii?Q?6eRQyUbFTAc/u3BgBSkQjrLm8aHmAqVCZ4yO4EuULj94D2byU7HKBZ/QJ/XV?=
 =?us-ascii?Q?gBzL1kIDC3jhYczjrTsIm7/aDSenss6JL2G2lsYLjlB4NcF2RBegpc+A0VDQ?=
 =?us-ascii?Q?l0wDmopC20Sw6M76vJqu7NFfii/13vxl1EbSl5CkIz59XyfwGvjKOjZZC0mk?=
 =?us-ascii?Q?s+fgKsuIyEr4WEbJWpcQHscJOTehARJswkUqeJkSUsV1COKttPXKSTtiHrun?=
 =?us-ascii?Q?9YdfUJ6JURXo2h6426ZX/KmovXvdEG8mj4nosEcjJnzQqfRYgwoBU5nW9yoS?=
 =?us-ascii?Q?7BLhyFuv0HWqM+Nv81KT31RC98WivKEsaig2AVCXBCWraR6SShInO3VRJa+1?=
 =?us-ascii?Q?5+LhC92/iW8m4mY4XVMxmKRVeijaJ7ZOiliUab090B8YTlKOe8jgpNinDmNC?=
 =?us-ascii?Q?Bj7NErZPjnl0rvyVdiAcPkUZWG3ja9wU5B05GkzVkRBQRy0MR6wq9gwvhYoe?=
 =?us-ascii?Q?NVXxkXpXHm9ZYzkKVGYamVAUqVYJGKrw?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 09:40:37.5175 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ad3fc5-b7af-47bb-df17-08dd0ad9b880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6157
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

Add support for Winbond 256MB flash W25Q02NW which supports 4byte
opcodes and also dual and quad read.

Signed-off-by: Algapally Santosh Sagar <santoshsagar.algapally@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c948..d5258a1fc3 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -569,6 +569,11 @@ const struct flash_info spi_nor_ids[] = {
 			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
 			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
 	},
+	{
+		INFO("w25q02nw", 0xef8022, 0, 64 * 1024, 4096,
+			SECT_4K | SPI_NOR_QUAD_READ | SPI_NOR_DUAL_READ |
+			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB | SPI_NOR_4B_OPCODES)
+	},
 	{ INFO("w25q80", 0xef5014, 0, 64 * 1024,  16, SECT_4K) },
 	{ INFO("w25q80bl", 0xef4014, 0, 64 * 1024,  16, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{
-- 
2.25.1

