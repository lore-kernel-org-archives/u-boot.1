Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC014D6EBF7
	for <u-boot@archiver.kernel.org>; Fri, 29 Nov 2024 10:23:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5F8DD89382;
	Fri, 29 Nov 2024 11:23:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vyrn8+l0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5D3B893D8; Fri, 29 Nov 2024 11:23:08 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 47C3D8922D
 for <u-boot@lists.denx.de>; Fri, 29 Nov 2024 11:23:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VV8rfKkD42qfJD9mUUSiIAKkEg7lAD615h+LjwHMufMJQu+kP6HLfMLa+Zm6GOoaDTbR8msFOpapbzWwqZQfkjJuvrPoro5PnPDYSeRnIYUSsQEDrVcifrZF0hv9hWUhnl43rw+D+bKSp964bSHJz3EbDFxE+34IdV+WahjAr4gt7sjWMn8DTr+KjqgYUGCXiUvb1KnZdMV8f/I7K4907sFQvDje0U2i62HMgGaWOquELVEjHq6Z/+Y6SxHedCDFndFoNNbc4uQM0bnTN5QiuXPgWihoHeUEOO07VCZ+AANcLFfFAIVYJFd0feWVFjViuKgfbYIj4ZlTg25g7So/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZdfxHOGE721W1xdZkbUh2+5Vqt9pEluSseSe7qBve4=;
 b=DtoHmgs94v9WZdhbE2A4QhjYPavv2yGdCS3C/2TS2c/UzsAp4lQ4wMtiqwakz+On+69gDoJDs/e3aL+f/5jeYwDwCI74UG8ziKyUhSQOZoyyE2u0l5H6qvPILghp52tgVLRmmbTbX0NFV5SG1mhZHk+pTkOZ9tzNvbWqvIAaV5WoCfosSTgQQpTGUtqOpIfagZdF9caQVPAhEX0W6N8v32VBoZ+XBO7Zsv2I1qpFfQSUslyayuV+PBr/AOYhTBNsu+eSckfJH54wn/DZ810f9LU6BLbTMoDWud7Zck+OIIGrD4scX1WdFFZggaTxqPLSP8AD5c/wMa6Ru6lGnUvV/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZdfxHOGE721W1xdZkbUh2+5Vqt9pEluSseSe7qBve4=;
 b=Vyrn8+l0lFZ8eLV+wpPE7aG7VAk5tgdzzN83CJpvYxnTmnf1lzmAEcuu52MPmMw4gVvhZK9W5BHNQQ4oiuw/ylBb5uv+0dFwgPv2IJNH9mbF5Qw1LX0zUA2l0jJXuLHmwCqNBFKU6YDKiajJCS012wGyvakawAB5Rf0VksbxFkU=
Received: from MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31)
 by SJ0PR12MB6991.namprd12.prod.outlook.com (2603:10b6:a03:47c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 10:23:02 +0000
Received: from CO1PEPF000044F8.namprd21.prod.outlook.com
 (2603:10b6:303:b8:cafe::9) by MW4PR03CA0206.outlook.office365.com
 (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Fri,
 29 Nov 2024 10:23:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.0 via Frontend Transport; Fri, 29 Nov 2024 10:23:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 29 Nov
 2024 04:22:59 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 29 Nov 2024 04:22:55 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <j-humphreys@ti.com>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <tudor.ambarus@linaro.org>,
 <Takahiro.Kuwano@infineon.com>, <p-mantena@ti.com>, <git@amd.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH v2] mtd: spi-nor: Enable mt35xu512aba_fixups for all mt35xx
 flashes
Date: Fri, 29 Nov 2024 15:52:48 +0530
Message-ID: <20241129102248.670635-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F8:EE_|SJ0PR12MB6991:EE_
X-MS-Office365-Filtering-Correlation-Id: 56513ec0-ed26-4555-d677-08dd105fce18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GScaFWyBMfNdewft6hDaIz6HgbY8bRv4GbLomqzgLcYzca8OKiknCnzlcZ6L?=
 =?us-ascii?Q?INsy1STZpEGpiv8S6RUwAxuApfDZvlED1CPP6Gne7Ob3RexMS30tKclNNKMC?=
 =?us-ascii?Q?aEj58imt9tAMPHKgHIRLG0e6gM4gq4WrEQHbrSR3I+TH3TmHOSKdM//kTQRQ?=
 =?us-ascii?Q?m8jhFDeNi5obHxVYROiezYw0miu1v6MrLUxnyfsWFE0c5p8G3UPFjIe+SPXP?=
 =?us-ascii?Q?iLzG9Q+Xar+f11EgS2aCBJouit4ITzxy6FYpYVS1NnGl+AHFP75oR5aOzPPf?=
 =?us-ascii?Q?FQhYKQeH+mtni8eYV7oU7cYPgILT3D9FXFQK2YGDnoEeGicYlrW7sfWjQpCe?=
 =?us-ascii?Q?3SVN5N21Uz9SQQYv/Uf7mUmdGufvGU4lPMDlI5LQq2qOUq9AIMOyywpGIfgF?=
 =?us-ascii?Q?k5iS3hndKBtEuTGxmlkcoy5ks9+wY4RI20TU3GM9cJQGIgYfjtQujAsZRZx+?=
 =?us-ascii?Q?GMm2D/uJwu65e3358pJoh7Io5BG0Zq6KqXg6RKLxBY6HIEJcv0BQ+k3n19wW?=
 =?us-ascii?Q?GjwMtk1jj4EmA1pbyIkv/pYoH5Gfrhku8N5DqimRVaM//x93K+9OVSwlKxa1?=
 =?us-ascii?Q?m7Ar62oPJyOBjHyWk4sHRiNjFPjRoQW+rnYP5hPefRvG1oYRve831Xuz7/cg?=
 =?us-ascii?Q?dathR6M48UDQER9qd4Sc2CJhQ86+rblP/limUVt3yd0SiJRPmZqxAqIxc9BQ?=
 =?us-ascii?Q?kN+ZA4wBqUPMsHHQUdSYyRztPtSk6x/H1LJs7pc9Y2W2+YHMTzPgp+IwMyNT?=
 =?us-ascii?Q?raI4lUEhOJuokvPMCTXlXqKQvJzdH4A1okwDd3auqq8O9VEKsbxnuuLu3cGt?=
 =?us-ascii?Q?mpYjUHUKNdMTjwd8YuucaAgksLFq/KYJysdIXcl2fhty1rR9M6Zx93ZqVulG?=
 =?us-ascii?Q?k4GD3/cYeRKiMI47WzoBeJY8EmkE8p02czZ0dyTHSLCROuBm1uI3oqd4Yf9Z?=
 =?us-ascii?Q?E5SrZ7QOlN4nTn5ltMhcSD/z8Cae6qFhbLK8WhHyt/BwkHxXxwxkmE+Xf+6/?=
 =?us-ascii?Q?RxVCKvDJKz2ZmnDPPlb1u6aXqIPAVeJQgKrsy64tE97DK1zfjOFy50bfyhHB?=
 =?us-ascii?Q?9/nCVG/I+KC/0rAKfU1t27Bo7l+yctmpxOTfS5cVy9p04jW+TB00rEmECocq?=
 =?us-ascii?Q?wlYy/O37n+WT07rsQH6RKDH8mPXadP94PZm90WSWyjvyhrbhKemLPzUA9Ht7?=
 =?us-ascii?Q?C1Cg+2KZyUbnH65NYVuQots1bHPz+DjC+p3nfWNCUcj1sTrXwHxfxVYLG0sC?=
 =?us-ascii?Q?7uU+R1ZrPnaCc7cxwiznpMtSEku5254Vp8Tbyg46gPy13AiKl5OvVLTkLlZy?=
 =?us-ascii?Q?F4ITNS1emi3VvJFg2qB2eE9WCo0QhLrXwDqh9G3TqkderD7fpQ++qGS+Hpga?=
 =?us-ascii?Q?u9I+f94CGFrlILDRRBjmvfo5ntD9658M3v/xPjzrJxq1NNFaLtb1RbfZbx/G?=
 =?us-ascii?Q?RfNN9Sf4OVORENILNY1+khIx+X4kAhLq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 10:23:02.0431 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56513ec0-ed26-4555-d677-08dd105fce18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F8.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6991
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

Enable mt35xu512aba_fixups for all mt35 series flashes to work
in DTR mode, and return after nor->fixups is updated, otherwise
it will get overwritten with macronix_octal_fixups.
This flash works in DTR mode only if CONFIG_SPI_FLASH_MT35XU
is enabled and SPI_NOR_OCTAL_DTR_READ flag is set in id table.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
Changes in v2:
- Removed the SPI_XFER_SET_DDR flag.
---
 drivers/mtd/spi/spi-nor-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ec841fb13b..96f749f7a8 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -4404,8 +4404,13 @@ void spi_nor_set_fixups(struct spi_nor *nor)
 #endif
 
 #ifdef CONFIG_SPI_FLASH_MT35XU
-	if (!strcmp(nor->info->name, "mt35xu512aba"))
+	if (!strcmp(nor->info->name, "mt35xu512aba") ||
+	    !strcmp(nor->info->name, "mt35xl512aba") ||
+	    !strcmp(nor->info->name, "mt35xu01g") ||
+	    !strcmp(nor->info->name, "mt35xu02g")) {
 		nor->fixups = &mt35xu512aba_fixups;
+		return;
+	}
 #endif
 
 #if CONFIG_IS_ENABLED(SPI_FLASH_MACRONIX)
-- 
2.34.1

