Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0CDD6DDD1
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 05:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3A7089658;
	Fri, 15 Nov 2024 06:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2XJzYiKr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A4BD98933B; Fri, 15 Nov 2024 06:08:34 +0100 (CET)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 095E589652
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gUhXgu/OJaOERgsy4MU4hL5AP7RZ69mBwQiOQiSrIukUcG9WhAicBKkmM7bFAupp0NK1l9o8dgQrapjDG48O/KpWoN5H5aPUJsnFw8kdHbwcQUO9d/vrSR28GWZjkoe/bRX3fObEgoVZR+UPJrO6UJ5oxatS6SLzNwpwV0eDaLuuR7cZ/XVQLFLq3ZYYVUqQJUoslfRa4rUVbyttivYXQBh31fBZ/up6NrQllQnybqMY3aZUawCcac+FY13iQukhH3Se2Fi+MdacH4kHoZztm2HOGuMW1tc9MDO4GeSWTFJHjdnZY1+tkv5OZs+cMwsTSGLmQv1bMJ0UlEC/17PoaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tn8PHEYjlVDx1a+zbzB00UeN3tvSVIrZffbyg+t0WLY=;
 b=cVLGitrbCEfujq20v2YDhB2FjrLMXgpiXYsimj/LKbHwrusklj+R4qLnyrqqZ6AwKVsE+9ubm15fMysel32tb4wsbZ9moQRBTAHgJOFEv6OzBWqgEHGfqZN3qZz+1Ey2BAIcAG0vz5qJoJhuyh5VbhWq6905H2M1/A4Nlykq47dyCGBIx2OSCfimeq3X0chwOJ0VS69oTB1zeRMOmAuAveam/4Rv6ySv0Xo5N+wIlxpwnyU00l10UovpxFaFNTKRDIxtRgzUYgBQgcx46no7V8AnHg6XiTiJjCHsxnKwSo4MD7CkERdmp/I56jhQ97JTt3Xbe9tUs9C0pKa+pToxlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tn8PHEYjlVDx1a+zbzB00UeN3tvSVIrZffbyg+t0WLY=;
 b=2XJzYiKryftfw4f15HA4mQjh6qPrH1Lu6z0165VoD/g4pDv3ciRSK5w+uUctJEZmMt4T9KNw44J69Yg36c+Nthgcbd2H1zSaSmbG1nX+TPDDsWtwENLQMCAoZwX6G2NPXDfIEtrCtjKmiwM22P0tPsupBgqofcpacXoRXuupfgc=
Received: from CH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:32::24)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 05:08:27 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:32:cafe::e4) by CH0PR07CA0019.outlook.office365.com
 (2603:10b6:610:32::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17 via Frontend
 Transport; Fri, 15 Nov 2024 05:08:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Fri, 15 Nov 2024 05:08:26 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 14 Nov
 2024 23:07:26 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 14 Nov 2024 23:07:07 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <git@amd.com>, Tejas Bhumkar
 <tejas.arvind.bhumkar@amd.com>
Subject: [PATCH] mtd: spi-nor: Address the Macronix flash probe failure
Date: Fri, 15 Nov 2024 10:36:56 +0530
Message-ID: <20241115050656.30439-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f7f554-aff0-4f86-282b-08dd053389db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3yrBFKJOJ261adnj4377Iicra71yxbRMntekANxndsVFBf6Ss7pKHuL05jmp?=
 =?us-ascii?Q?gjWYONUrr9wkFBut/rs6QfvmrSlptvnY3AvSNh7r4HT7L48JHUwU4quNhmF6?=
 =?us-ascii?Q?GGTbJY0gpplV/HLrikLogH0x1TdUiQCmgd70P07idSaMQe7TaB8KSQ8xXD9z?=
 =?us-ascii?Q?FM4XPFV+4yp51bRRoR+rJql/8OVr5iYDV2n55pUhdmHTKE97/lPvCaaZCFOW?=
 =?us-ascii?Q?wr/tXH2tny6t2BYla0SaFyCxlDWk+r0zGN7xOWfz+j5W5AZ3ib2b/fjpqnEn?=
 =?us-ascii?Q?PGsJCMPVO8xONXijjgVTUpuWJPjE9PIIorHC3vE+trhC9EIiuCSSCttGGEND?=
 =?us-ascii?Q?1KaoE6rBKuL1ARHpiyEhVnTEVZ6b0BZj5DO2dPuHrityk91tCCDaGv8hXons?=
 =?us-ascii?Q?1bk1wCre7eMzupa9gIs76HLoEtu9LIeNZ0aYKjipPfFMwQojCayv1kp1KpOO?=
 =?us-ascii?Q?K8XDx38mD2/ahoR5fGy/eLHnQbIsH/JABK8OEs2AeEU/WvOItEKV5lX5UK8m?=
 =?us-ascii?Q?doElSBuJy0TN8aQke6DsvJ7b0KuQE/iU7XhPEd4sFiZHHMri9asEpVm6Bx/O?=
 =?us-ascii?Q?/6qmYxmJJ3nsP/TxDkayy9FOSce7J/ZXeFrfTSji4nuPJOMt6bROzlXu69vC?=
 =?us-ascii?Q?fk9OZ4V9OWDO5umQnZHQhSyzLZX14a3XgTnCRKXa7YFbm1MGPl4ppM7H2Plb?=
 =?us-ascii?Q?162nQwDgF9zOWeUHOLKyuBjQRwNffPjXWRKm2aIQDQotZg3hn6Hr9vuNAgEi?=
 =?us-ascii?Q?GXbSMOMp26jzsF9//PXNOg0yI8P+01bMgbLbCvpPRAjhXqpCmXCNJgRHWtaQ?=
 =?us-ascii?Q?BHDRZK3Zgtu8p8KwM6Tq7lL6z6rjjj2U44ln1A3uChRziv6GuSKyvT6o8AF7?=
 =?us-ascii?Q?r9m4tnHF1sVg56HzJI9OMCkZRmBRMJRMfexn9Rb60YM69Y2h0p7KJZhlc+5e?=
 =?us-ascii?Q?RrXCMQza9UCgw2+C8it/QMIiaJIhWsXnQnVH5ILRRMnlQ8GdLGCaj8lJ5Qoi?=
 =?us-ascii?Q?t6cfquZ/SoBC4anZ32mmdWQYLKzSLG+rV7SmzIVCnqzT6UEE1dY1+0eFnoWQ?=
 =?us-ascii?Q?u6yY/bD04U4RvaMqBottuFP3xdos3YrWmBuXyY25+C0jeGPGkNGo91PU9RGI?=
 =?us-ascii?Q?6Xs4FOun5tXlSriJtnpDEi63QsZF2Yt6TlRjPE9L7y09YSpj40ABPLSlXrn+?=
 =?us-ascii?Q?l9R5DHk09aKLB66qFxGPRRxG28vZmcfjeKNgn1osv8ohDsSwSU8zzBWMgT92?=
 =?us-ascii?Q?4yOPYojh/Yki/WqO66/OVGBkaeLF/HpA1C8cvNp9UVhcXRlmxhr74rSXtBBn?=
 =?us-ascii?Q?rYUTqcNp+4IZZfwCqGAokVOmatWssWprmyLHHiWMBoeqEdhA2SLFUtgYgh4e?=
 =?us-ascii?Q?8t3+M/Ig07/BOhZwO+JWdIfm6yxTzQYPB0GnPIoeu5kyE+M0uw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 05:08:26.9853 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f7f554-aff0-4f86-282b-08dd053389db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402
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

When performing a soft reset on the OSPI flash, the default
cmd_ext_type is set to SPI_NOR_EXT_REPEAT. However, Macronix
flash requires the command type SPI_NOR_EXT_INVERT for soft
reset.

To address this issue, read the Manufacturer ID from the
flash. If the Manufacturer ID indicates Macronix, then
update the command type to SPI_NOR_EXT_INVERT.

Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..baf1941d76 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4316,6 +4316,7 @@ static int spi_nor_soft_reset(struct spi_nor *nor)
 {
 	struct spi_mem_op op;
 	int ret;
+	u8 id[SPI_NOR_MAX_ID_LEN];
 	enum spi_nor_cmd_ext ext;
 
 	ext = nor->cmd_ext_type;
@@ -4326,6 +4327,16 @@ static int spi_nor_soft_reset(struct spi_nor *nor)
 #endif /* SPI_NOR_BOOT_SOFT_RESET_EXT_INVERT */
 	}
 
+	ret = nor->read_reg(nor, SPINOR_OP_RDID, id, SPI_NOR_MAX_ID_LEN);
+	if (ret < 0) {
+		dev_dbg(nor->dev, "error %d reading JEDEC ID\n", ret);
+		return ret;
+	}
+
+	if (id[0] ==  SNOR_MFR_MACRONIX) {
+		nor->cmd_ext_type = SPI_NOR_EXT_INVERT;
+	}
+
 	op = (struct spi_mem_op)SPI_MEM_OP(SPI_MEM_OP_CMD(SPINOR_OP_SRSTEN, 0),
 			SPI_MEM_OP_NO_DUMMY,
 			SPI_MEM_OP_NO_ADDR,
-- 
2.17.1

