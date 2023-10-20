Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1B0CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 03:19:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0244787240;
	Fri, 20 Oct 2023 05:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="e7wWArE5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD4908723E; Fri, 20 Oct 2023 05:19:16 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6ACC787033
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 05:19:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTZOV5FA4TGygd00JS/QEmuf2+GyEybawjcFj0S7lqKkWoA1pBobEAg4S3XgaGsW/ymDBt1gL77rW3Y7cg2b3rfGpsPwWBdmDXpRRsHwcz5wlqIUaeE/PCTu4Q5vBX2X0PliorGPs6JZ7DK5fygbq293FFd3dACfzRQGYc2aS23QFOSoJ+j0a7VxecYJ6zysDrB/vT9OOS/VCDzlUlG9XYjIGcxxpmxkjAMORBuUPR7gI0yhwb/0eRpV0cdrbD7B/kblGtc7Nfg8IHKC57rAaatqiycAXhbsvmmJQnuh+0L7EN+wOpFKoCP2VclBjSrR7JJt0WQPjy/62Y3SI3Gz+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0HqD9f0ZXdEH3QRxczFhfX03sKvlYtUhLCT1YTpC9M=;
 b=cjxBDnM5PApTP4u2P3IxLpUFvSas9BKox8NVQAaonzMrPJUpw9FOBuNz7+woG/pTL+xY2g8kM+cwpwgDrIrpy3jbmCbNon3w1F3Qpc/mEohjtj8DFP8NhhduSLusYajWWQLn62wkpIMDrN+SdZqDd5lOLfVk55HrRvxgs0UB6PTRLL4AUcbZciiVhfvSu1wFZPMue7WQCbMj7tq+XMgooq+fjJyRTJKqX9BWhx0eHEc4D1H9CiB+yxd/tbujlWUpwDC2gXDK3/LRN58t6a0NgRrEt6mbzlQv0XGHWRJ6GzqSTeO4US6kXai36X0vZqSybGKudhxYlNh8YjB2NwkOhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0HqD9f0ZXdEH3QRxczFhfX03sKvlYtUhLCT1YTpC9M=;
 b=e7wWArE5etbGNPCzZhVe/UHXoKnPl2M9eGcsCOPxOiglmtk1qV5oZ4yfgAySnRIfj5GpNRcRxnKT3gqWO3I88dBm5rqwbLFDjsNq4ASsuDCTPJRqKT9BZO6uMGIDChWC7qWAKeIvMjDQs3iIuu7AhwYdd3Z3IepAMt8Iw4Dvx68=
Received: from MN2PR08CA0027.namprd08.prod.outlook.com (2603:10b6:208:239::32)
 by DS0PR12MB7970.namprd12.prod.outlook.com (2603:10b6:8:149::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Fri, 20 Oct
 2023 03:19:10 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:239:cafe::71) by MN2PR08CA0027.outlook.office365.com
 (2603:10b6:208:239::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 03:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 03:19:10 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 22:18:51 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 22:18:49 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v3 3/6] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Fri, 20 Oct 2023 08:48:14 +0530
Message-ID: <20231020031817.267959-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
References: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB7970:EE_
X-MS-Office365-Filtering-Correlation-Id: 185ddc97-eb93-49a7-2070-08dbd11b53e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R5e5NcSW3wuZK/CrFFD6F6lXgmLv1PjiYc6X1fG/YlTdoWx/v6wdcKPmB6CEsUoNuP/9HWXNaVKCUQtCkWcrVI4CApdiE/rT+ogR+Ooj32G/zp1UDtmISCAySs5hqO/5Gr5VWdrdfA16Kt+B3tVQtPYYYXybrvTD7QPnQ00dCUUdyYXWNKncTcWsOvkHeRCAQ5Mp1kx+RadZQE1/lbBglq03nmZCfAzfJHxtjCCN/I4KLYiAVa4m1h/c3aSBEkpmxK3r+cQ7tq4uUhyB7eR16qChXzBvf5WAlA4bSv4LbJTvhRY2vFObdFLkaz69KCq+AUyphiJVUwzN9lQY7WI0RpWYqQfv3VBk5cF6fW6Idsap7i11VwEldsQkwVUd2RN5/Ki1DI+eHtXKrCw0/Qtv/QazS74eseTG6YS4Xj3F+OunFpl+kss6Spzgxdo3lKBTKFjRYpsNet+9Mxv8FOFSxaUqrNf5LoQVH9WpCgF0c7kTh9EeaslvzMxSJYDpeBd7efPNKxwfGHvnGhzEzJAD3D2hE+YLfnUx4nLBcapsjgeku5TjswXV7ghfyXly6UT45w2ut1Yrgtw/g5VNIynvjnVkbqm4ShwleS/13L9bCBtbJeZcJjyWTGPWyBkLmd0p8QwGCyICC0O79N/fRoPTlYJ5BllLunARj+bCSjryp5EIB+hcvl+TZ+bjhbOawTEieHrDLCYUiupryh4fxIzklV4esoxximv7cJ1bN/Nez5T4OIbUKtuYIExOnI0QPmPG1aNoJe/6HKVAR/sNIzyp6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(186009)(451199024)(64100799003)(82310400011)(1800799009)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(2906002)(316002)(70586007)(8936002)(6916009)(70206006)(54906003)(6666004)(478600001)(8676002)(36756003)(5660300002)(4326008)(41300700001)(47076005)(86362001)(36860700001)(2616005)(81166007)(83380400001)(1076003)(26005)(356005)(426003)(82740400003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:19:10.4632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 185ddc97-eb93-49a7-2070-08dbd11b53e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7970
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
index 373979d19b..264aa6080b 100644
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

