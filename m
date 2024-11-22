Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F02D3D6ED3E
	for <u-boot@archiver.kernel.org>; Fri, 22 Nov 2024 09:48:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 22BD2897D6;
	Fri, 22 Nov 2024 10:48:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kkFSZBXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1E00788360; Fri, 22 Nov 2024 10:48:16 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::608])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09D07897E0
 for <u-boot@lists.denx.de>; Fri, 22 Nov 2024 10:48:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2nlYo3brbNVpmUFtEIaAyRV/sE7OSvo3d82KtV/JfcqwI+Fq6PaMY3ZFmb41daKyoJ6TqTb1doc6id6MywKWqUCl2i2YEeN0nhs1NyYXW5fr3ZJJYM3PjQtzf5EvwLk/s2yYDTo2chXAtALbsEppvW4wiF7S6EswKuTdsFz7HTKkDEPJdf3xfbNoe8vbNagBPj47w37o+9jwKz/sJGgiCpGLZp5PvZWgSMxRcaNnYuYkXMDXV5sz477Wf6ESkfB8z/GonwrtZJLp79SLlLRuM6aCV0X+0tnHT0acn1VZlMXGTzlPxBbyOOYekbBqO+mY1JdoAFR8whgPPi8wbtvqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Evvawzij1G5PCTUezKNWwfCVBCbndrnUs7xbpr2qrRA=;
 b=WfoTdmAh4j1sKDU5W6T3GlDJwVhUspvDzehdbKgNH6BsgafxiMZobvX/HxvZaGo9lf3GdmMsD+x7vgqLxNM2ho71BvQ9J1q7hQNMHPGf7e22uMyEX+bPn2vInvnS0S3+ZjRxsgHl1ZaN7lX0APM2ZotaW572y1ajEHmUB45+57jpKx1NLrFB7iTjYLHriwQh32Y6LJurXKPg0/SXjs4YsNF0YsxFemiPZusjh9vFDqjmGh0nTjfrKKYXf8ZwdwPt3aWpH2BNneXabvAqeWVTeYpmx77TqInKQ47vdUVmg3i7hUa5Hh5cED/3Dud+CAkOAs/Dbka7ykdRZeHNuB0u1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Evvawzij1G5PCTUezKNWwfCVBCbndrnUs7xbpr2qrRA=;
 b=kkFSZBXMUxobXx6OEZLgMdphWKIrYkvT5Is5e24nToT35YiAg/W7UYPuMgmGiaGMJgDeyu6C216qhxDMGz17lbW7xEZ0pDsLO69rJg+Tbz2URoeViTDVz+TswETKBEOKkNSNy9y0QcxR8x5t5hsq37MQT3dgsAcAYE+JFnO1iLY=
Received: from MN2PR14CA0005.namprd14.prod.outlook.com (2603:10b6:208:23e::10)
 by DM4PR12MB8558.namprd12.prod.outlook.com (2603:10b6:8:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15; Fri, 22 Nov
 2024 09:48:08 +0000
Received: from BL6PEPF0001AB51.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::a8) by MN2PR14CA0005.outlook.office365.com
 (2603:10b6:208:23e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.15 via Frontend
 Transport; Fri, 22 Nov 2024 09:48:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 BL6PEPF0001AB51.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Fri, 22 Nov 2024 09:48:08 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 03:48:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Nov
 2024 03:48:03 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 22 Nov 2024 03:47:59 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <j-humphreys@ti.com>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <tudor.ambarus@linaro.org>,
 <Takahiro.Kuwano@infineon.com>, <git@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>, Dragan Simic <dsimic@manjaro.org>
Subject: [PATCH] mtd: spi-nor: Add support for Macronix flash part
Date: Fri, 22 Nov 2024 15:17:47 +0530
Message-ID: <20241122094747.1398068-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB51:EE_|DM4PR12MB8558:EE_
X-MS-Office365-Filtering-Correlation-Id: c3630cd4-e441-4554-bc1f-08dd0adac50c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CTkL3URkGVbSXGsNVST87qAxz4sEFV2vAK6fHEi7Mb0RzSX6tJeXfZ110sQi?=
 =?us-ascii?Q?5nBA0hYyb9okrjL9z6Uzq91o6QTj9x2HeOMmN7SLyRqa6yexieu2KThrzvS2?=
 =?us-ascii?Q?AEZzvhQLfDyw/nLdXKNkUo4cUfWTXyr6XmGAjcE5oP4X5ITL9Vjw9s8KkAnI?=
 =?us-ascii?Q?shug5c81HGh9jSiwtxo+3Jn38sd5o0pDLESnh2/Yx5f7U2OGAvL5/iVBNqbH?=
 =?us-ascii?Q?OT3mni6XypYgKyDefFHwYA9BrbxIQDZy5qNjs/+Qm4oKsTJbIn/5Pzr9fjgS?=
 =?us-ascii?Q?kWlc/ZLfMxyjKsnbddKqUwREM4IsohTNZoFXmCWZIRO0VHf1wVAHDMT/v7oo?=
 =?us-ascii?Q?EtE9kCbhvYLd0J4M10u5VLxYoDxoMZtV1rXkMLoXbjrgRhA5ytKTXf+QU9yr?=
 =?us-ascii?Q?POcrQ5xb6SmApfExOi/DPHwJcb4sdng8gm5yTStosp9Br2KVeiw8mi00nJc7?=
 =?us-ascii?Q?PEBRGyOuloTRQsZCP9JnlQvBtgpb3u42TQfR9wjBSsoMmRJjA/2qGDAF8Imi?=
 =?us-ascii?Q?Tj3wXW7ehD6py5+pAvvldPEGDjVtd8PHIqxMA3dKMiluYQmWzuW6OHflZfRL?=
 =?us-ascii?Q?vXPcXplyQKWCIeGVxGZbLfb4BreHMEbPTcGo+/oYmPl3wqNuxGeqGCFuMSXQ?=
 =?us-ascii?Q?FozE1t9LgEI17AJko5TuJ98KYCs2wX+pF2+iwhDXhoDT604l9dEx52PJ3ZA8?=
 =?us-ascii?Q?WuRgcYFoe2dM+ucgwibXec3hcphTezOrGjp3PwqOgKUl7DTla7VetFmJ4Wc8?=
 =?us-ascii?Q?hLVV7Glj3VY30sh1mIDbeM5XdUP8xmASIw3AlznCwhfUrFK3q6isSecRXaBD?=
 =?us-ascii?Q?X+mbDYVB9LUK8Ryg2fpIioNFvyY+Fzg07lWHK95P1hWkkr6P/mY1E4U2hkS5?=
 =?us-ascii?Q?QT/VsYKW235SKbR1CK+kRdUHqarjA0S3xw3LsL0b3T+/heA6unLoffQL4isc?=
 =?us-ascii?Q?2jJxzk8B4jcJEO7e2A4btvZQo2iHAlBLlfX+IsgoWY1Si1hyYOsJjU+EwJUp?=
 =?us-ascii?Q?RDZ4uU2kVnNtTPZpidL1R9d+Jc+5ehLtPSzlFKF5X/79KsD4pzMDve6/bc/a?=
 =?us-ascii?Q?Cb2RZQ2e2kISp4TWbghJnm3rub2IgvZk7HWYX+HYZxrHH+9PH/w2DFb1lGF+?=
 =?us-ascii?Q?vKQAvwuoK7JW8RdLJ+lCRCcpjSChy7vPuD0KgtyhgYjqb+9nh/+ogmyUyd/0?=
 =?us-ascii?Q?q707/0WAsaL3wwmh5z17PdDwYk4wtHoniqWrGnumx1vLAV0lHNdlCgM637NT?=
 =?us-ascii?Q?/RTz7LASjLL7B00v0Tx+8NcP6urBqe772MJ84DYgTePcukjRpJr+YlYi13c0?=
 =?us-ascii?Q?GH0LNmf4eAwIQyutTuih9LrBlcIc6IESMAfKGGL5HT6f780i37/qwQL9cR7Y?=
 =?us-ascii?Q?hm6UjnxmZSROTUP4TF9F07vLYLogfVK0Dh6YRz8PZ0bfqNOw5g=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2024 09:48:08.0479 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3630cd4-e441-4554-bc1f-08dd0adac50c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB51.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8558
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

Added support for Macronix OSPI flash parts MX25UM51345G
and MX66UM2G45G, with initial testing conducted on the
Tenzing-se1 board using STR mode for basic erase, write,
and readback operations.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Dragan Simic <dsimic@manjaro.org>
---
 drivers/mtd/spi/spi-nor-ids.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-ids.c b/drivers/mtd/spi/spi-nor-ids.c
index 91ae49c948..a130845d41 100644
--- a/drivers/mtd/spi/spi-nor-ids.c
+++ b/drivers/mtd/spi/spi-nor-ids.c
@@ -275,6 +275,8 @@ const struct flash_info spi_nor_ids[] = {
 	{ INFO("mx66l2g45g",  0xc2201c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25l1633e", 0xc22415, 0, 64 * 1024,   32, SPI_NOR_QUAD_READ | SPI_NOR_4B_OPCODES | SECT_4K) },
 	{ INFO("mx25r6435f", 0xc22817, 0, 64 * 1024,   128,  SECT_4K) },
+	{ INFO("mx25um51345g",   0xc2813a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_4B_OPCODES) },
+	{ INFO("mx66um2g45g",    0xc2803c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx66uw2g345gx0", 0xc2943c, 0, 64 * 1024, 4096, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES | SPI_NOR_OCTAL_READ) },
 	{ INFO("mx66lm1g45g",    0xc2853b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
 	{ INFO("mx25lm51245g",   0xc2853a, 0, 64 * 1024, 1024, SECT_4K | SPI_NOR_OCTAL_DTR_READ | SPI_NOR_4B_OPCODES) },
-- 
2.25.1

