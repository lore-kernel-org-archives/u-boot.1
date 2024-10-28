Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB64D13588
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 08:28:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBEFC89040;
	Mon, 28 Oct 2024 09:28:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WtNIWi9x";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 61C7989089; Mon, 28 Oct 2024 09:28:52 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 75FA68909E
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 09:28:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Prasad.Kummari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bGEULAQNfRsQCJiaUiNbcGBmRHyLyA1dZ1eUjVV+pkvsZ54lSQIWmyM1yNTU3sqKoM0GdrovLqhMZWc5wRFMdQn9JQuTiDkmRWaAeEqvtYn1ppz1yuRkDs4tqQ4RTISyCXMI+n836448S8DABeHmJf4w/2w6vOdUt1H4jQO2KJuNRSYjiFmJZyS3i6YO0g0EADvlbO8bl8/rhnHisAOdqMFHykoga9SWSCgsi3IAsLMh7v6UnCOjqgFNdHI78Pv2RrIJhtO4Uoo96YlIoXy0eUeFvY7h6fxvuq+JPJKYnLmbZabfBMKpA9U7EbewZG2VXoKc7HjFNNtRrB7lYyTvHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dYE3Xtq9ED8BXEo6sYSGHWy8ysGd11MhNeG7EN9FTA=;
 b=VaSMiHXqtLcfx7Y+UovXjLHD6tnV1asaxEhfyP60jwqPWsZZ4aWjqBeZPuRY2LfLQZU3PMAZPxtdGe9mneVwwWMX4MfWWvuDJumUIyff0krk5FbTUhNJnq+AQONImuFnShUFRz1EttzexdoqeL0F641LmQMjQ69BKlUF3CKhDvTeJKLZ7OiLScN89/mRelBXxxrT6G+MkvQn9ikDMA7Q61DwJidtAIuwpIG6Gme8CmnMR+K5eoBhaVMdgtLRHCnveoLeyKxZB9iEpR9L1kob3w/2vcGgMiRDoyulc1DUU6ld+tFP2W1uaziRmrQaDt53b5lGVpiktbhoO1fzSqsHIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dYE3Xtq9ED8BXEo6sYSGHWy8ysGd11MhNeG7EN9FTA=;
 b=WtNIWi9xdqxh5/n5lP+wYoIthd6IkgQpbLZKkL6wmR6S8BE/7ufMqKmMja3lOX7FrJMaukdUhFtRjS81099X3H9vcRNvENz1LuPyAV3G7nLCD3OJRVNPFuqRY6SJTZ0noijCMN6O4Av3ZKDGfsQ7JRi1ZLVy1wrluD/VrgNi1Po=
Received: from MW2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:907:1::35)
 by PH8PR12MB6699.namprd12.prod.outlook.com (2603:10b6:510:1ce::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 08:28:39 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:907:1:cafe::ce) by MW2PR16CA0058.outlook.office365.com
 (2603:10b6:907:1::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Mon, 28 Oct 2024 08:28:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 08:28:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 03:28:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 03:28:36 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Oct 2024 03:28:32 -0500
From: Prasad Kummari <prasad.kummari@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <padmarao.begari@amd.com>, <git@xilinx.com>, <jagan@amarulasolutions.com>,
 <n-francis@ti.com>, <d-gole@ti.com>, <mwalle@kernel.org>,
 <patrice.chotard@foss.st.com>, <patrick.delaunay@foss.st.com>,
 <p.yadav@ti.com>, <quentin.sulz@cherry.de>, <seanga2@gmail.com>,
 <sjg@chromium.org>, <Takahiro.Kuwano@infineon.com>, <trini@konsulko.com>,
 <tudor.ambarus@linaro.org>, Prasad Kummari <prasad.kummari@amd.com>
Subject: [PATCH] mtd: spi-nor: Store stacked memories sizes in parameter array
Date: Mon, 28 Oct 2024 13:57:25 +0530
Message-ID: <20241028082723.3842308-1-prasad.kummari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|PH8PR12MB6699:EE_
X-MS-Office365-Filtering-Correlation-Id: d2ab7854-7855-495b-60a4-08dcf72a85fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L2EOTMaEXpNXI6iyT+qmXIliWaeTVlqydOrgkh2EUqiJ7IHqz19+L1JUzXj9?=
 =?us-ascii?Q?C/0aH9tnnNWZl9ymb3uxeCaIXtIx8qMDMETvbGSiEYCxd35JI+Z/Bx6TI0mP?=
 =?us-ascii?Q?AByl5swdaYtAW0JwHO/QgNEiRxyVQjGIU7UIGB1ElhchtFNGQ+df21FaijoG?=
 =?us-ascii?Q?jfK66GIOo7DguEy+ROTqDzVrUa0Ot3IADJbamu3C2NJIZTi50XlNR7I7quQG?=
 =?us-ascii?Q?0xlgMIvUh6fF6W2/+VLRGR9sDkpP+KlO0+LgAhQsq3C8Sbnx0dxouZadgCz/?=
 =?us-ascii?Q?JI8hJZADQtHOkJ6tqP84IL+t3i6kJ11MM+w1bFy4s5v+Qrh1VbkUp768V91C?=
 =?us-ascii?Q?UGtNg171Esi34JUMeavWjGy50+0dp4mf4/IdRUVAcygZgULAQj0eHcZ3bqYd?=
 =?us-ascii?Q?ArQF0FdU3jEtFBWNXrJ2MHN3efVGC0rn1hFqxJe0Z0vs5IQGy4f+WKmIbiWI?=
 =?us-ascii?Q?CX2V9VlgXyuIv7CtSliLPyiQdRiS6PYV4Few5jnW6b/OHVhpnhbZgbiIvQwF?=
 =?us-ascii?Q?XpfEquxwCRn55AJ4vY0jhLUHGrZ9f+tyHVos6iBhFTMdS899UFH1znrnZ0XC?=
 =?us-ascii?Q?bsySHiJ8Ms8r9pXpzD55YbWLoBESzcGFFqgngcVxqxfi0j53EbtfTdaXNxNf?=
 =?us-ascii?Q?IQXNiKdkvN8c4fvPMapy8ZOtkdiW/MH5B18nWgFuVS9ji++jCuCpz02sC3EJ?=
 =?us-ascii?Q?boIO4J0oa0iJAt43iglmbQaq8AROY7IRu0vYdcH3oPm+AokAuV1A1nwZgV8l?=
 =?us-ascii?Q?j0AGJH/4n2Rrhq+JODUTmrr7VUc/xL5R1o4ACieurosIN+gLYFJsrNwpLaCt?=
 =?us-ascii?Q?Kd1EXzdn8zIK1WHOlJv5mU+Xq37dxPopn//TQYVdKV1YuMqQNQOtz5704Rd2?=
 =?us-ascii?Q?HITrTBLvJ8D588gZuRDhMUS2BcyPK7+vkdxHcPyeoo3wMLrAq8jqmrC23jaB?=
 =?us-ascii?Q?H8QHkSPPtErmNqKhetPsL3ycoh+apk3OmGSKUFLIaeOj69K3Qzzsz5QXFoXM?=
 =?us-ascii?Q?RJTf8I1CJRT005mSgkSBGR8kB+GnsVcOB73KvRss9NjIdZ9xTNyC+ljtwRza?=
 =?us-ascii?Q?qQSy+X+jN6ODMt/D3QufoflXCdRFLkRh49AZyBv+BtfLiZRBXw+D0Tx9khI5?=
 =?us-ascii?Q?HFtp541RHNdYZeKpG3J+hHA0kx85zQWxnVpHWeWA+roWV+XFiAo+maBJARPT?=
 =?us-ascii?Q?wEMuZYHar8zqTNGuA3BxfcRNX5cDeuXBOuCDyckTlN+RQMvA6qkuJB7oeBS2?=
 =?us-ascii?Q?oDUDqxI34u0RBPnwjQ5zQRRVzQKrEQjVlWnnyHcd50/oIKjwWwxWIEhK67XT?=
 =?us-ascii?Q?m2k4Za17MJ5p5lSHh6c+Wpv3VuiUYe5Le7ULW8fbMKBjPauS1UXyjyWO3z3N?=
 =?us-ascii?Q?TV0eALN2AQJ61iZQkF2RNjDmegDsU+tSddtKDOE1MBq2mg0ptxVukeBBZ0QD?=
 =?us-ascii?Q?39gg1FbYGhI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 08:28:38.7245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2ab7854-7855-495b-60a4-08dcf72a85fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6699
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

Each flash connected in stacked mode should have a array of integers
to the nor structure to store each flash size. This array stores the
sizes parameters of each flash connected in a stacked or parallel mode.

The current stacked implementation assumes a maximum of two flashes
connected in stacked mode, with both flashes being of the same make
but potentially differing in size. Thus, except for the sizes, all
other flash parameters of both flashes are identical.

In the current implementation of stacked mode operation, the full
chip erase in stack mode does not work correctly for the upper flash.
This problem occurs because spi-nor cannot set the SPI_XFER_U_PAGE
flag. It only sets this flag for the lower flash and
calls spi_nor_erase_chip(), which erases only the lower flash.
Also, spi-nor does not know which chip select values to use.
It will select the upper flash if SPI_XFER_U_PAGE is set, otherwise,
it will select the lower flash.

To fix this issue, spi-nor needs to send the full chip erase command
to both the upper and lower flash. Since spi-nor does not know the
chip select values, it will determine which flash to erase based on
the individual flash sizes stored in array of params. The code changes
will loop through the number of flashes and set the SPI_XFER_U_PAGE
flag to indicate the upper flash. Using the individual index,
spi-nor will call spi_nor_erase_chip() for each flash and wait until
the chip is ready.

Need to rebase top of this commit:
https://lore.kernel.org/u-boot/20241018082644.22495-1-venkatesh.abbarapu@amd.com/T/#u

Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 47 ++++++++++++++++++++++++++++++----
 include/linux/mtd/spi-nor.h    |  3 +++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 2034d84251..0d96373a1e 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -1063,7 +1063,7 @@ static int spi_nor_erase_chip(struct spi_nor *nor)
 	if (ret)
 		return ret;
 
-	return nor->mtd.size;
+	return ret;
 }
 
 /*
@@ -1104,7 +1104,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 	struct spi_nor *nor = mtd_to_spi_nor(mtd);
 	u32 addr, len, rem, offset, max_size;
 	bool addr_known = false;
-	int ret, err;
+	int ret, err, idx = 0, rc = 0;
 
 	dev_dbg(nor->dev, "at 0x%llx, len %lld\n", (long long)instr->addr,
 		(long long)instr->len);
@@ -1155,7 +1155,35 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 		if (len == mtd->size &&
 		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
-			ret = spi_nor_erase_chip(nor);
+			if (nor->flags & SNOR_F_HAS_STACKED) {
+
+				ret = 0; idx = 0;
+				while (idx < nor->num_flash) {
+					if (idx == 1) {
+						nor->spi->flags |= SPI_XFER_U_PAGE;
+						rc = write_enable(nor);
+						if (rc < 0)
+							goto erase_err;
+					}
+					rc = spi_nor_erase_chip(nor);
+					if (rc < 0)
+						goto erase_err;
+
+					rc = spi_nor_erase_chip_wait_till_ready(nor,
+										nor->cs_params[idx]);
+					if (rc)
+						goto erase_err;
+
+					ret += nor->cs_params[idx];
+					idx++;
+				}
+
+			} else {
+				ret = spi_nor_erase_chip(nor);
+				if (ret < 0)
+					goto erase_err;
+				ret = nor->mtd.size;
+			}
 		} else {
 			ret = spi_nor_erase_sector(nor, offset);
 		}
@@ -1166,7 +1194,7 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 		len -= ret;
 
 		if (max_size == mtd->size &&
-		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE)) {
+		    !(nor->flags & SNOR_F_NO_OP_CHIP_ERASE) && !idx) {
 			ret = spi_nor_erase_chip_wait_till_ready(nor, mtd->size);
 		} else {
 			ret = spi_nor_wait_till_ready(nor);
@@ -3204,6 +3232,9 @@ static int spi_nor_init_params(struct spi_nor *nor,
 		spi_nor_post_sfdp_fixups(nor, params);
 	}
 #if CONFIG_IS_ENABLED(DM_SPI) && CONFIG_IS_ENABLED(SPI_ADVANCE)
+
+	nor->num_flash = 0;
+
 	/*
 	 * The flashes that are connected in stacked mode should be of same make.
 	 * Except the flash size all other properties are identical for all the
@@ -3225,6 +3256,7 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			if (!(nor->spi->flags & SPI_XFER_STACKED))
 				nor->spi->flags |= SPI_XFER_STACKED;
 		}
+		nor->num_flash++;
 	}
 
 	i = 0;
@@ -3242,13 +3274,18 @@ static int spi_nor_init_params(struct spi_nor *nor,
 			if (!(nor->flags & SNOR_F_HAS_PARALLEL))
 				nor->flags |= SNOR_F_HAS_PARALLEL;
 		}
+		nor->num_flash++;
 	}
 
 	if (nor->flags & (SNOR_F_HAS_STACKED | SNOR_F_HAS_PARALLEL)) {
 		params->size = 0;
-		for (idx = 0; idx < SNOR_FLASH_CNT_MAX; idx++)
+
+		for (idx = 0; idx < nor->num_flash; idx++) {
+			nor->cs_params[idx] = flash_size[idx];
 			params->size += flash_size[idx];
+		}
 	}
+
 	/*
 	 * In parallel-memories the erase operation is
 	 * performed on both the flashes simultaneously
diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
index 1ae586b2e5..f0719206c5 100644
--- a/include/linux/mtd/spi-nor.h
+++ b/include/linux/mtd/spi-nor.h
@@ -616,6 +616,9 @@ struct spi_nor {
 	u32 size;
 	u32 sector_size;
 	u32 erase_size;
+/* Number of flashes connected in parallel or stacked mode parameters */
+	u32 num_flash;
+	u64 cs_params[SNOR_FLASH_CNT_MAX];
 };
 
 #ifndef __UBOOT__
-- 
2.25.1

