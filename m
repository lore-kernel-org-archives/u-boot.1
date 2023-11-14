Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 363B9C4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 04:57:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23768715E;
	Tue, 14 Nov 2023 05:57:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oz6bF4X0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C198D871AB; Tue, 14 Nov 2023 05:57:08 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A853D8714D
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:57:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kaV74la/b5K8WgYxvqC0fsPAZ3KOOA4w3SBOEp8KDPUNeIP/b7u8heIK+1WXO7wKEHvvjhMbCHYOJ3TMK8ZEaefzhruPEaKpYw09Oe2970J2FvvyS+Nsb5FjSx9ujbi7Nyz+p6igvhYZE1NASlvDjr0aafb0+zqFv3/us0joP6z60dcwFHz4OfKRt9WBqPSMxpx36dAO3cTiScaXHihjnSyjZGQgZwnlkYiglxXsHDCmo2OMklkpl80dTqxb7UMmHDEnZRGqONRCJS3VKf+v7+9bcmQ/HsyPfIFx/sOwnqWbZSYeLNdFvkZXOco319/O3ZVtrXrYVrC9LAeh3Oevew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9DP9rfu+74QOFyRt0I9Oo5mu6yQ5JbdQGDyRycjJLE=;
 b=XcNYXvYWyGJlskdcl2iYUtAIKLeaYLbFolOk+Lck4W5G9Xeq7f82q8g9zMKR7gzZEz1WUYtY9oMe5mXAqz5iQwZNaQXjYOOCp2251sMP2ItIbFClMAnkUuCxE9zjyEzVCVs7jL5i/DT58N8DWW24KWQXU9g35b4TeCcQ/Stmo3fE+LWlkVuXmLgNkgS9PZuPCtnwZWDATqGk/0yepMuN+gXkH+LgXO1Q3AAxzrcOAjuYkvcQogSg+EYtxanULsOTPkXjhGEOGUtZ3w++ZjJeXpHtsyb/NCUgg3VIGuQ7O6Amgf+FVzGkLr0V/Cmx5xJUG5hBQUWhcLXOuSUrRQYokg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9DP9rfu+74QOFyRt0I9Oo5mu6yQ5JbdQGDyRycjJLE=;
 b=oz6bF4X0p+9pJDeY9sRiABGLRRIx48f4xfp8TF/tbanGZiTH7Gco+NGMMp7/2X7Q2TAqlfZFM4NqJuPRZzuvang4CBZsWNZVLaooKDVuLvKBKD9eGZ2MLuaH0ZllzBiZLmpERLnMo6tr+MLsuiKk1I+QcOMMa6EXReu+IVtKTNk=
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by SA0PR12MB4416.namprd12.prod.outlook.com (2603:10b6:806:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:57:01 +0000
Received: from BL6PEPF0001AB56.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::6e) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31 via Frontend
 Transport; Tue, 14 Nov 2023 04:57:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB56.mail.protection.outlook.com (10.167.241.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.14 via Frontend Transport; Tue, 14 Nov 2023 04:57:00 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 22:57:00 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 20:56:59 -0800
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Mon, 13 Nov 2023 22:56:58 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v4 3/6] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Tue, 14 Nov 2023 10:26:35 +0530
Message-ID: <20231114045638.6463-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
References: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB56:EE_|SA0PR12MB4416:EE_
X-MS-Office365-Filtering-Correlation-Id: 18a96321-a71e-4292-818d-08dbe4ce231c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmptxUC5ASHKqFxOcncrp5M9ZodE2nRfc/LKqJMTH1T+XmGCfopXdZ6Qve6TDCVYyOcQEU8C4sKdItjdoh06A2SLx4XNh879qrHuQGp0LJYofaDVMd9BP9J9xD8AHvM4FYzO+OlAQXrIzZA7YMssOR745j7TVXXTzzWrHf8ytwAdp8QS5v6zE2UdIUQI1HsiBViApu7neEiWPsb4WkSQKvSUytfK75a/4zKjYQN9xpUZV4lpo4gWlgGk5lex7RvQy/PNdTYRax0OWmzrUMR6lsapYpvvERuwjm/XMznOKL/375wcyxFcmmKIGAAOe3c9WOPF7p6CQ8GoxQkU3V89qzYSSXRnb7fC4vZNBrZfiva/zUWC79dwheXf3s3f0Ka2DMSzapMRXkXgv1Hvi0L7VsCISg/h/yqqvul7Hlwa988T8ab0ivK4nB+o8o7c/Mm7I/xVsyZz821uSzH/LgCYJO9LRp5a9O2/RgBqRcCsMvS9qhPRgFru/HPqD4P8FSfy8gBru0xgGuh0jBwws2vtxPXNolDSuXNOdu+R9EV5zx8XKdxEqrbcwXgg/gqq+YyTJ9GtO9o9M2mq9rz+qIQDwc6B1OYMczzqTRnihm2Bp7VWV/vHQSiybr3uC7gre6O0VBsohpg1N746WbApZpBdyo7vTQcC3Ov+uWF4HX4joZNcoLWQdzSVlc+vTH6LlU+K6YF22ARGAhrShggyCrm5FENqY7M5G47cCWNS0HDVe4xJebBiiye/NrLxYnPYTXXCpGtH6ELlYLx4wzUGs0LhVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(82310400011)(46966006)(40470700004)(36840700001)(47076005)(5660300002)(86362001)(36860700001)(36756003)(356005)(316002)(6916009)(81166007)(4326008)(8936002)(8676002)(40480700001)(70206006)(54906003)(70586007)(41300700001)(2906002)(336012)(40460700003)(426003)(26005)(2616005)(1076003)(83380400001)(82740400003)(6666004)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 04:57:00.6055 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18a96321-a71e-4292-818d-08dbe4ce231c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB56.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4416
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
index c1c9d007f9..d245d5e415 100644
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
2.17.1

