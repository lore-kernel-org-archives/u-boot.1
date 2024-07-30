Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46203C3DA7E
	for <u-boot@archiver.kernel.org>; Tue, 30 Jul 2024 12:00:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 70B0588155;
	Tue, 30 Jul 2024 14:00:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="GA7sTCK1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C57D883A9; Tue, 30 Jul 2024 14:00:33 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0BBE8751B
 for <u-boot@lists.denx.de>; Tue, 30 Jul 2024 14:00:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNPCd9KHg+XeNGc+KyKvBSX1v2bXSGw7EeZX+YZ0wKQ5RnfA8OuIacvIMlLZc5FsXIga0U7Lc3q46lpaX78JstjkQugI4t+ZJamZMXEYx9pCFv4/VNIrH+2HO+D7/Pn+eeYc31K4JGN2okJkQEU/oEeLSQUNjarUoSlErnNn2RP+O6FCqXITIvHPehN0tTyb7OOzSVZaO6SmXQS9bYmTXoFL0I787+zr3iM691DxGMXhiZcUx/Ht7H7t7GZyr64VOYjibu7hsIOnagcHxr3hIFW91pXcUWxADwhxcvbAoHYrSBFWfbaUMrLm7uQkkgD0V7MvmvyqAGKT00IrXQ9M4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=45yhi95GoasLI0XsmyfXTpjd7LVK8e8hghzAgQ36DVs=;
 b=LpGKQ2sHxHnpRKd45a04TwKBC+yTHWsCLYsAcYLuylJNAMoygs5vhVj6t88wGls0s/TIG4PsVpm7H5dFEmd004KgoCYYwdSuXHYh+kQO/PQGsYo3Mb6if6Hy8gAtrG3HsCWplpf73wghRDQkTKNe6iN54n4HL/PfNBXfWzRUwrlNG2a2cd/D5dEVV6WwFHFj9WGozMo0K1FqvaShOvXSpMCb4Ess5bXN1pvc93ZVvkKXH26gAjg+rW5sAtv2hk6juLMQ0QqMCrWKQhgbvHMb7nAi3WlAujXxZWarJJJnlLqXwwmVNu3QwQnqKX94UjbCBHM5XgFCVLHQFMq//+gRPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=45yhi95GoasLI0XsmyfXTpjd7LVK8e8hghzAgQ36DVs=;
 b=GA7sTCK1tgF8HTV0kSMkeuITwdVvmSeYFODDmE6bZYF3c60i5DOK4hQeKk4rxkfelpC8suMqZygdYuniCK5vDQlMn/4fpScpuYqvE3/T2kxrkO9mOKA1EYxzlNRfDrSvRQ2smi6ocdQLNWF+hzUCtDI+M6UENVSkbIecVmFLlAM=
Received: from MN0PR04CA0001.namprd04.prod.outlook.com (2603:10b6:208:52d::35)
 by CH3PR12MB8903.namprd12.prod.outlook.com (2603:10b6:610:17a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 12:00:27 +0000
Received: from MN1PEPF0000F0E3.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::ae) by MN0PR04CA0001.outlook.office365.com
 (2603:10b6:208:52d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.35 via Frontend
 Transport; Tue, 30 Jul 2024 12:00:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E3.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 12:00:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 30 Jul
 2024 07:00:25 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 30 Jul 2024 07:00:23 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Tejas
 Bhumkar" <tejas.arvind.bhumkar@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>
Subject: [PATCH 2/2] mtd: spi-nor: Disable chip erase for S28HS02GT flash
Date: Tue, 30 Jul 2024 17:29:25 +0530
Message-ID: <20240730115924.12285-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E3:EE_|CH3PR12MB8903:EE_
X-MS-Office365-Filtering-Correlation-Id: e4f4259b-a4e3-4056-e0da-08dcb08f3354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?q6ZjXVLX1C8h5cFGs/S8uBxploP67cnS4700xYvLvBXTHu49W0DkVkwJ10fu?=
 =?us-ascii?Q?sDRIDIoWqAVkDb9O89qchQuqEqvUtmyfy+ZAKRm8eGiLs/fCVl5kOv84l45W?=
 =?us-ascii?Q?k53TPuOizAErG1gF3vaA0yiCA/Gp8xDhDJz1Hv5a+rCNkPiz125p9O6HhhqI?=
 =?us-ascii?Q?r+PQfOzNoezA3/ivDHAu6JKFxsCIX8WoZ4mmB8+wOW/TbJQ4Qfzhks02HEOE?=
 =?us-ascii?Q?BiK8YW/DdpCDbIuJf8INztJufPvkeq2Do7VAH5gJNzKf+bGz0saYUPNg3hIE?=
 =?us-ascii?Q?q7Mhzp7ZrDg2bnQDra0JfDoaixEmf6xocRd8vtjLlSYFbp+PpSJfE8BZEGzk?=
 =?us-ascii?Q?awfJoyRcvAMUKhHsG8f/6oHu+iwIJoY+Ec90j6v58U/wHktzsRV3Iu/rHeEi?=
 =?us-ascii?Q?0eM58ircZwF05NaP550AvNJCLRzkJUlbCelLRaBz2Io12GA4nOctrBWNLznZ?=
 =?us-ascii?Q?pkafnq/v/gdtURss4kRN//K2n63NJvreSqgES21+PM3ILhzT17OYNjDzaf5L?=
 =?us-ascii?Q?eYDx2a82++wWzPXigRKnTUdSMD+L9W86riWotK6wI1O365uRijTeHgzYJ0BR?=
 =?us-ascii?Q?c9yFAK5YWKtOmo75CB0hMsc1BRv7AmdQCzo3J8ADRSHYUqepZgLeicycsYll?=
 =?us-ascii?Q?jhzaeI87Vdc9gykEI09L1Ba6OkS0l0ksw/MlaWBTKhRgpWurVDCnBMQ9T5l3?=
 =?us-ascii?Q?Yvg3awMM16iIYzrTFvEtIK8gDhiUyDpClA0AxWaMVYcekOTZXDTqYEbDYAmH?=
 =?us-ascii?Q?QUlIcycfbydKDx8qTXkOfEyowXzN041EFLaeyhM2Qea0XyHFNl2eiz3A0XuQ?=
 =?us-ascii?Q?Ck7opR2NRtkdfbQRop9xcPtMKBZ3T9lTd/HbPE4QCPqduKUA9Qc67WckByow?=
 =?us-ascii?Q?bc3tP7TCcO4XmMZdCMH8UOyvsCwJmPj9MOKvEnGhrPbp93CJY4rQosRs3GXH?=
 =?us-ascii?Q?NinFEX+r+z6a4KVUFkJsr4tyIuIzbISaUrRmbOKedAR1RZuE8eveJtIWEy2R?=
 =?us-ascii?Q?rU1s+GdhlXmHOBsPXHrB9iB/RYYonoHOiyOc6xEO1ULL8DC4SFw85Tk/qHRm?=
 =?us-ascii?Q?mUhOXHOIkaOfTvvr8L4Lt3tdXQFQLHmt0DeGbHvJWXMhwGPGfq8ARy+32BHn?=
 =?us-ascii?Q?Ph6mzgx3NgFUQmHcX0mTtXf9RHlsC1JN0sV4sD4YN9FBdrvorWTm5bRPKQm8?=
 =?us-ascii?Q?pwMeNKjwsxj5D/w1vglHocSFsy2kD3mY4w85cqNW0BowBjHTr4a8SH6vfyzi?=
 =?us-ascii?Q?o6qoD9UI6RN8OWQxCANhh3w9HYlP3Wh22h2wpYJPOE6Z8RIRnFazFNkvGfiV?=
 =?us-ascii?Q?4R4FBb9LzjuL3M8U4W5+xZJ8fLXDBkBQlck+xhI/2ADGKlvcpiXTOKXMDc5e?=
 =?us-ascii?Q?yqFDjSlNtLXvR1ARrOwWAGPkhvX+XFd1fpF/qns6yF5GfG1Nx0Vw/enu+oid?=
 =?us-ascii?Q?eS3ACAG2wLNSHv3QhLcldvz44yCT1Z5q?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 12:00:26.7155 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4f4259b-a4e3-4056-e0da-08dcb08f3354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8903
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

From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>

Since the opcode SPINOR_OP_CHIP_ERASE (0xc7) is not supported
for the S28HS02GT flash, the NO_CHIP_ERASE flag has been added
to enable sector erase functionality instead.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 0908fb954e..1b737a3507 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -383,7 +383,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("s28hl01gt",  0x345a1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs512t",  0x345b1a,      0, 256 * 1024, 256, SPI_NOR_OCTAL_DTR_READ) },
 	{ INFO("s28hs01gt",  0x345b1b,      0, 256 * 1024, 512, SPI_NOR_OCTAL_DTR_READ) },
-	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | SPI_NOR_MULTI_DIE) },
+	{ INFO("s28hs02gt",  0x345b1c,      0, 256 * 1024, 1024, SPI_NOR_OCTAL_DTR_READ | SPI_NOR_MULTI_DIE | NO_CHIP_ERASE) },
 #endif
 #endif
 #ifdef CONFIG_SPI_FLASH_SST		/* SST */
-- 
2.25.1

