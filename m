Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F5CC4167B
	for <u-boot@archiver.kernel.org>; Fri,  1 Dec 2023 03:20:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E98D8775B;
	Fri,  1 Dec 2023 04:20:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="T655SdUz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B004487760; Fri,  1 Dec 2023 04:20:10 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0C6C87684
 for <u-boot@lists.denx.de>; Fri,  1 Dec 2023 04:20:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QXDD1VQ1pLVgKxj7v16Y6HANzIBvNxWg9+PmHiyc4hYolsrZJW7BMDa9cIpr41h20aoIvzvBhCs09djn4T8ndkuELuj8iiAKA+lDdYnp9uuv7Q0F+e4FhfZkC131m7g9IriI/vxHzBSurt3F5J1uqSca+uLXN8jRvKiwf7AFGH0cHDA6v1Ainxdxh/pXQY4t652LSsI1e10dN0xwyBZ5PXwLz4jhEpb1VUhzbqlNTPBfAITL/7kdoEW1QLf3k2Zr1eayeyQnF4Zb41czMxvlyeO8MsWkycXSh3P7ZomW7zbxnNrNN24SVkZ2MOHWJuPNZXApsZBcgbgeJBFzuraa/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZCDlUZoc2WDN8b/Vx4AcUgB1PpslQQQKvjSK9e7INo=;
 b=f0N8DWbWexHB1uclBm0A5xGzlpvgHbtd/gVoWPufrGNJjqzSF8pfsn0JhbOnQdfyalHnAo+mld4w7TRxRirHpHa4W+VSCwM6rEGcEuJEFZzLuK/4OWRadvZrUMz9GXClFwvW1fOHPKsChk/utTeTbOSSyEp4yjNAWQG3ZA2OPCIUITnkZujG1vG4Z1xw6yZjWcY2APOj/BgK3dQ15gWu7fueJtfry5DUWw6adS4OYYL0/aAlVFIBuqbznIKw64HH1nfpwaYX90pZ2Djz/RJChnbTafZX34/r7h7QY34tFBwKK59+SFw98l6+n8ZiNUw19gjGc6Kh3EUlckxH/A20kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZCDlUZoc2WDN8b/Vx4AcUgB1PpslQQQKvjSK9e7INo=;
 b=T655SdUzFygZ28wIKs4H7D3yel4ncs7Ab8TjFGz7fSw24346bbKKVd9NS/So879wA5VZ1/iAbJURZf+2LoiMYC8GBO1QyB7g929dogTYc/vqYr3L5zZ6OVeW/R2Bh102Ny5c3rGhT7uVw6Az+n4tXBHf2wVf3dCHhxQSbe7hFD0=
Received: from CH5P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::6)
 by BN9PR12MB5338.namprd12.prod.outlook.com (2603:10b6:408:103::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Fri, 1 Dec
 2023 03:20:05 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::eb) by CH5P222CA0014.outlook.office365.com
 (2603:10b6:610:1ee::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24 via Frontend
 Transport; Fri, 1 Dec 2023 03:20:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Fri, 1 Dec 2023 03:20:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 30 Nov
 2023 21:19:49 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 30 Nov 2023 21:19:47 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v5 3/6] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Fri, 1 Dec 2023 08:48:36 +0530
Message-ID: <20231201031839.239567-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201031839.239567-1-venkatesh.abbarapu@amd.com>
References: <20231201031839.239567-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|BN9PR12MB5338:EE_
X-MS-Office365-Filtering-Correlation-Id: 443be5f4-3b4c-4130-6889-08dbf21c69e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PnI5swFO5LthjnxnulLGsZOZ7PeEbSttn6KV4pMIR64Q/e7VR5f/zflJGwUH21fvzOEk7DSN8VeAzILlLy2g63LqbvKb8vDRrHV/jBKJlo4UjMqfrCP0yACDfUjok2rhXh3CswR7LjPTAK5E2ouDniG9yJnuTO3KoU7w/7za3sS7aEYRnMkgEnuPrJgjkJbv6R7YEPhga/Jh5pJxCMe7J2Q2Mg5oqJGm8NhZPl3UqaatFPnhofMA6tfQmg8vilfR6EaAW0Qv3pfLt8hQ5YmFMEqqjUPbcKEzwK8nSyZ+wjGm0Vlgx46tYLhgkXSxniZ04oU/WPfHqESKX7vQ/EGmheKeTJ4KbY74nuJSSbP7OLUVL2lpz4hSOpw9XyoBVJQq3FFf6y5DRdp+P/afHIH2KjSEKpKThfB4hSJxtNp/DWX6TtGDfce6+KOaz/TXgHMh0kTK59Z8WBk8zOLkBfxDFf1VqvYrxFKKSizJ+AZVfYD3JJLfv/cC3Vdwxl6t/baLRoJQ4loKFejlfNjFNlpoKpVPyZ6Vq7vkmkx1A86Hfk4gZR+f8+F02aXgHgmVm8zsjz1VPYiZcGyJn4a1+z3qgRHiOVWO3MLBGASvkC+kMq08YCWAXRCYOMTyI75QZkAjjZNaMfaF2yxcWCjaF3Ok+EJ4fgIik+utUkrc1Wl9ZkK6vEnzbqP3/4UefRxh3uydxw9ipxg8IA+ZA7ksi8tg2r0Bddu4SBAvVXqywglW/cfifKgiZCpTrip+a2r44NiDD7lf4xBNjqdPLLU+aHJXUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(1800799012)(82310400011)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(5660300002)(6666004)(2906002)(40460700003)(478600001)(4326008)(86362001)(8936002)(8676002)(6916009)(54906003)(316002)(70206006)(70586007)(26005)(1076003)(83380400001)(356005)(82740400003)(40480700001)(81166007)(47076005)(426003)(2616005)(36860700001)(336012)(41300700001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2023 03:20:04.8174 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443be5f4-3b4c-4130-6889-08dbf21c69e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5338
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Add support for parallel memories and stacked memories configuration
in read_bar and write_bar functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 55 +++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index 0e29b3020c..5c3ffc80eb 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -885,12 +885,32 @@ static int clean_bar(struct spi_nor *nor)
 
 static int write_bar(struct spi_nor *nor, u32 offset)
 {
-	u8 cmd, bank_sel;
+	u8 cmd, bank_sel, upage_curr;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	/* Wait until previous write command is finished */
+	if (spi_nor_wait_till_ready(nor))
+		return 1;
+
+	if (nor->flags & (SNOR_F_HAS_PARALLEL | SNOR_F_HAS_STACKED) &&
+	    mtd->size <= SZ_32M)
+		return 0;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
+
+	offset = offset % (u32)mtd->size;
+	bank_sel = offset >> 24;
 
-	bank_sel = offset / SZ_16M;
-	if (bank_sel == nor->bank_curr)
-		goto bar_end;
+	upage_curr = nor->spi->flags & SPI_XFER_U_PAGE;
+
+	if (!(nor->flags & SNOR_F_HAS_STACKED) && bank_sel == nor->bank_curr)
+		return 0;
+	else if (upage_curr == nor->upage_prev && bank_sel == nor->bank_curr)
+		return 0;
+	else
+		nor->upage_prev = upage_curr;
 
 	cmd = nor->bank_write_cmd;
 	write_enable(nor);
@@ -900,15 +920,19 @@ static int write_bar(struct spi_nor *nor, u32 offset)
 		return ret;
 	}
 
-bar_end:
 	nor->bank_curr = bank_sel;
-	return nor->bank_curr;
+
+	return write_disable(nor);
 }
 
 static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 {
 	u8 curr_bank = 0;
 	int ret;
+	struct mtd_info *mtd = &nor->mtd;
+
+	if (mtd->size <= SZ_16M)
+		return 0;
 
 	switch (JEDEC_MFR(info)) {
 	case SNOR_MFR_SPANSION:
@@ -920,15 +944,30 @@ static int read_bar(struct spi_nor *nor, const struct flash_info *info)
 		nor->bank_write_cmd = SPINOR_OP_WREAR;
 	}
 
+	if (nor->flags & SNOR_F_HAS_PARALLEL)
+		nor->spi->flags |= SPI_XFER_LOWER;
+
 	ret = nor->read_reg(nor, nor->bank_read_cmd,
-				    &curr_bank, 1);
+			    &curr_bank, 1);
 	if (ret) {
 		debug("SF: fail to read bank addr register\n");
 		return ret;
 	}
 	nor->bank_curr = curr_bank;
 
-	return 0;
+	// Make sure both chips use the same BAR
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		write_enable(nor);
+		ret = nor->write_reg(nor, nor->bank_write_cmd, &curr_bank, 1);
+		if (ret)
+			return ret;
+
+		ret = write_disable(nor);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
 }
 #endif
 
-- 
2.25.1

