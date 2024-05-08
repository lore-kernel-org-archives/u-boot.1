Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33DCC19F4F
	for <u-boot@archiver.kernel.org>; Wed,  8 May 2024 12:36:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 168D98843F;
	Wed,  8 May 2024 14:36:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZHf87zFW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E2D888438; Wed,  8 May 2024 07:28:46 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20629.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::629])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66CE987C7F
 for <u-boot@lists.denx.de>; Wed,  8 May 2024 07:28:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRY8Glr9IFWzqBEoQPqr49Mv65Byh9w3n1fCLvyQBc8i1TYHoPfh5uiN0NRLege2CfJ9PEw9yApFme4yDcL+9FofsZD/eNZSgSGHqL2KiEgz7fGn/XfQyuqkxPvW59Kp1YpszdVIrDjsk8IyPJOmW7mEQxd5e5YL1WGWDHXJLqwIJRvCsrEGZTGXLHJPo7zcXEqJAc3prsHO3FMWjBEFyGd7ve/olCHTaTac5udxdeTwhm422bOWRWkLJgs1Ini3BAcdwokMoy7k1nqP6QnEb4qq7EEJnxWtEYXjv1Xj9rWL/RvFCmmlGE24RPRiZ1m8MjflUhM0eW62S2WulQWAuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DZvvCLL6n8T+7riVRn8q8aQBPGGNySE0gqVPNCaMxxg=;
 b=OaCWLCfNNGe9J5m64kazwZiCEjAfU4Bi1sLaqtH3vrrkuCe7Q2Qm3KlXr2zwyOxVrA5EZVu30NS9iRt/trMPPehH/D1bhlwdTgcj/kIAP2N/MNsVZp3mABweqEG0BLm0Ndk2ZH+2UH3D3a37dZFY1VP7/5P10freTEOMTX/UGy56twtTeKLf3FuJRj6ZKZ2+i3tHEDLNW60tNkURo5ozPujFVV7i6IS7hiSrYncz3p2J/lhx5Aj5+byMoboO9wO4gE95ypGRKeL1WHiRubmI6j6/RFRWd9w5H226kMYOkTxRCiEuu0d4Tof7jCQ2yYktJAJYlSkl6QaJMhMpZwvR0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DZvvCLL6n8T+7riVRn8q8aQBPGGNySE0gqVPNCaMxxg=;
 b=ZHf87zFW8cI/ctLV9TYBYqY1xvYsh7etKQv93Z3rTj7C401oqFN2Dzk+n/5TmQAwRT+LRVl+SPSUv31Vq73NaAzBJbK/9ptexLeqVBCL0AQEvoIqGy3t2tHZgeEX7jXvnsb/n9eOH3u0Y80qqTJJZFn7miuh+gD2I0L3ozyR3H0=
Received: from CH5PR03CA0015.namprd03.prod.outlook.com (2603:10b6:610:1f1::13)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45; Wed, 8 May
 2024 05:28:40 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::2e) by CH5PR03CA0015.outlook.office365.com
 (2603:10b6:610:1f1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.45 via Frontend
 Transport; Wed, 8 May 2024 05:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 05:28:39 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 00:28:38 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 8 May 2024 00:28:36 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>, <git@xilinx.com>,
 <jagan@amarulasolutions.com>, <n-francis@ti.com>, <d-gole@ti.com>, "Prasad
 Kummari" <prasad.kummari@amd.com>
Subject: [PATCH ] mtd: spi-nor: Add SPI_NOR_OCTAL_READ flag for mx66uw2g345gx0
 flash part
Date: Wed, 8 May 2024 10:57:50 +0530
Message-ID: <20240508052749.214286-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: prasad.kummari@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 3099bf70-b0f8-4ff7-1eef-08dc6f1fb7be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|36860700004|376005|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FH14Bau21HubupRPh5t/kIYvGw8D0x0AHMHqfsBPjz3W6E5FkivpjMB6Wsos?=
 =?us-ascii?Q?5BAneuYq/qakLzBhK0ulNKcryZgisoLR4C4H6QCuacN733R4TEPeMjPn5uG5?=
 =?us-ascii?Q?NPB4nP2YCD0k8vueRnYbD5+OjayuDtkyOa+06p7ZUjSKfAVtP44pi+0jk2ZQ?=
 =?us-ascii?Q?VSpK353pzGYHW5EiReTOZ7QGmNc29ZAzrQeryj+hYuOwxvxIcaYQusWYl499?=
 =?us-ascii?Q?E9MTuzTOcPFNogPLVNFDTcAi/FvtvDS3+JV2LMuDzMZ1ecg3JLralBKxysCP?=
 =?us-ascii?Q?XxciMKOnuSIQjhVU5gQDZHqjRf9gya+/RTKZ3HnNZK4ZBcj7qOGa8UTvk8sm?=
 =?us-ascii?Q?HJbPsahb1Vg+LRkL0C1NfklsI4jJ678bxNfhjW+tzozf5udLI6aYAnaeUcbv?=
 =?us-ascii?Q?xMMj84uyCKAv7G/gsFzry0O+fIzk9nGPaTt/K3RHNTGXTaGc5Nyo30KoXrst?=
 =?us-ascii?Q?lfU+VD//OwC9WV+ITSx+6p86Sox1g8aUEEI5/SKGR1XOtvYTXOv1n1LxeeZZ?=
 =?us-ascii?Q?8LeqsCHEJDBZr+fYmlH/O34S1hN4BMWjrjfRFSuV6dOO+8Ns/UiKxE2t9aq+?=
 =?us-ascii?Q?nh62XU3SLi+G57TYZEo3RQ1Md83Sz1QqHNJ8N7Ry9TuCmHIENbav/VCp3igk?=
 =?us-ascii?Q?teEOOV1mdWbw5mv07URNGnGhk+k/99u/1MqvLK7w+m2a5wL+sFlxGH/RvPBY?=
 =?us-ascii?Q?2AfGz2wrG466DvCyp6OCc0f5o7rrkuXtmsdGNyf14z/hEyzz8HZQl+BTqJOi?=
 =?us-ascii?Q?i4nkqGpci1BBU2Fq/g69RxPxs0yxQkWF40Nblbd8eauQiD80ru0ph4cfuqw0?=
 =?us-ascii?Q?4UIkiJuoSGWK+zL9dgb9/b3qXNx1i8Bf0IwMryUfwbCuMTAheHCqtEMlJ9H8?=
 =?us-ascii?Q?R5ndmimORz0FjwGe7oPmDFTS2HPQqP3wmFQ7EALpDxOywEVysbeOD9qgn89f?=
 =?us-ascii?Q?mRvFvp3pJLxRzs5vaCGzSD0RiP/hErL73rcZpDAmHmNRomHLR0jZLQ+3ZJY7?=
 =?us-ascii?Q?NDdfs/9t+g91tb4LGoCw4oIXHxnEUnuX0+6qzVEkbiRC7jRpSRcr0S1/D4pn?=
 =?us-ascii?Q?t/ancUkMyQlDGk40MC0wD53hYVlYr0oUPMRWq1kElj2cMfHNvHfSmXlOPq54?=
 =?us-ascii?Q?BljBUXQi82IfMkrx2EMhug0ygJG1Po7u0FWXtHdRdvIl5iHLx1aRX67vzStN?=
 =?us-ascii?Q?LqAatCmHgtG6HL1qLKOxiCL+MaxOFGF5qsntdInN3NUSdFvR/WkhreDyTdsD?=
 =?us-ascii?Q?lI2NgX6qqnzy1ONenHwoIFpcjhHxZ5xUKajOer3fz0BCuO/Zwk4RJTQ7rpkP?=
 =?us-ascii?Q?VMQhwXLy3w1iAxPjmYwEQ5F/aGajHxN+IX2mZPjvU7lRFq5k0IbKrsWlqgOO?=
 =?us-ascii?Q?QdYnyqOAQq/exs3aj4wTTenluHbd?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(376005)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:28:39.6502 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3099bf70-b0f8-4ff7-1eef-08dc6f1fb7be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417
X-Mailman-Approved-At: Wed, 08 May 2024 14:36:34 +0200
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

Added SPI_NOR_OCTAL_READ flag for Macronix mx66uw2g345gx0 2Gb(256MB)
NOR Flash memory has been added. Initial testing was conducted on the
Versal NET board using SDR mode, which included basic erase, write,
and read-back operations.

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 4e83b8c94c..dacc26d7b3 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -275,7 +275,7 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | SECT_4K) },
 	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
-	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
+	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_READ) },
 	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25lw51245g",   0xc2863a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
-- 
2.25.1

