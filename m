Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A7C46CD2
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 04:16:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 911C68747A;
	Tue, 19 Dec 2023 05:16:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OrhGuu+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BDCA88700D; Tue, 19 Dec 2023 05:16:18 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::631])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B4C886F1E
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:16:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LzaoDJmNeW+fXWSccON2WlbAs1ASyadLLbEyCLSPhl9952by1ojc1ilyx/gejQEjwsQZfXCbfjnhYe5HigCyBI+MX7KM9MnGbi2UJRsduhCfowHX5j4CWmlQ44bvdXygFmH0X208WihEDZGnWQDa9rq/W259gbTNYzCucthgX1zSypLHkWwp/SoS6yejpxXq5iyw0ehmx9035z4FwQuprZTLVQGbn/01fhuklpBPiuct+7HMkCmoLhQQ3Srj7CgoiXoB7Wrd6eacLbb0zOw9QVvL8oKlPXU1WbCgk+aoBwfzzC9CzhIlBurbYY+fEld5W0Ss3c3MiyYPFsQLG5zufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rlMt9tXWN/rxKSG4/hkktUF7cfM9FD3Q9gvXUPAJdzY=;
 b=EVPJ1SO9pD+N9b4LxtLjv7a0Lbn0MZSOHjqQH2KjCHWQchFx4W6LhqWDc3/yEJFjuSt4XPByCCik9AN83iRRwKePV4oFLsgENKVqSlqBDvUKcWMMBpZaiMW6iWbu3/h5yVUGO2c2ENjBOzGzBzJTUlh+FMAH9DZDngFBfttZmgiPqSVdR5WcjTQwAX0qPvtH5u86J5NWXdVxl9TDNv/cqBMo9OazbpeS0ikLPisiPG6filBFh7GKaFF3qhvoJ4SytUyEbcoJmpKoO/aA51xUL+o0UX0sdAS+Uejtjct/JzDxgZBhNngLV9a89qi7CMz15IRwNUo/shg7rVPeQWuSiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rlMt9tXWN/rxKSG4/hkktUF7cfM9FD3Q9gvXUPAJdzY=;
 b=OrhGuu+phgE4qFMIRRourjtUfUaar0Q/HyEtGgQxVSAxF/42NN4EzxdqlrhuonbDAkdAdskOFzoAGz2M2C5tZ4q2etQux7DdcXABi0H2+eeowQkPUkRI6lV5Uy+eOJHSLyZCDo26fupcg7G2PayNnmNyGGdfccH4FNDFJRrkZsk=
Received: from DM6PR12CA0025.namprd12.prod.outlook.com (2603:10b6:5:1c0::38)
 by DM4PR12MB7503.namprd12.prod.outlook.com (2603:10b6:8:111::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 04:16:08 +0000
Received: from DS1PEPF0001709A.namprd05.prod.outlook.com
 (2603:10b6:5:1c0:cafe::34) by DM6PR12CA0025.outlook.office365.com
 (2603:10b6:5:1c0::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37 via Frontend
 Transport; Tue, 19 Dec 2023 04:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709A.mail.protection.outlook.com (10.167.18.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 04:16:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 22:16:07 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 22:16:07 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 22:16:05 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v7 3/6] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Tue, 19 Dec 2023 09:45:34 +0530
Message-ID: <20231219041537.1240070-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
References: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709A:EE_|DM4PR12MB7503:EE_
X-MS-Office365-Filtering-Correlation-Id: 512a2ba8-bcdd-4295-6568-08dc004939c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o7GSMvvH3pPUJUgF0EcAcx00lrR2JayKATLoOo0I0LhWPFW6XGXFdmcNplR5WzJbgstnuhfHqOhRhTdGJremUp8IDKDf/No96lYheeK9psZ2bXFIHaWW9CFEaIrQu7Y9G1/Wo++301W3DT8gO0knqTk7RTenk7lTdFZjr5ey9ZZciw2CW7hd6fBNIbQStMfr0aTsYzdegAJ5XFinqcqbDBVH3y2doiGUD82IeYhyoEO5q/l/x95vvAlbAeUQC9qeQIVWQTLF78EoAxMqe2sfjvL5ggGoLzsWqM2IDYUSROZhnRt9uoktDL/uS9ezu3FCLQcT863yWGVyX6KfqmS7m9muqvWG/C/OWHDc3D2ruWUGgBGUL7nGKXclV1mxh0E++cYmcIIUVTgoiKFUU0YDmi5uqnxTuyfOLs/86NR6xPfyhy4ML29ZVIapP/7S3fIBLTbnonLtepVBeYmzCN8TUND4IqkL+fNJxPgUOFSPwXEQmYJjw0kYMbHN8AhaRP3qWEbSb9mE5rDsadgZMLSEeWtxV7CqBqaiXtI4miisKxqZz2OPgWbPzZHYthJGp1Y1oSGyCr6MJmAuO9wHuuN4fXV71CTos58grbS7IEN6gOr+mvl8NfeJAQrQeHZgXLDFRq5ZCmawihtWKcpolZvpCggFbVlF7xtdTD2lQhqB8mv/W4YYtoGKBQRkZ1CxK7BxT7rDUWhFlPjTmQTPkr/oDixhcai0Y9lmSp+Iv5DFJujXYiTlIGHgmiJrokyuuvsa9e5s0MwSCTEIFwrER6etuQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(376002)(396003)(346002)(230922051799003)(82310400011)(1800799012)(186009)(64100799003)(451199024)(40470700004)(36840700001)(46966006)(83380400001)(2616005)(6916009)(478600001)(70206006)(54906003)(316002)(70586007)(40480700001)(336012)(1076003)(426003)(26005)(8676002)(4326008)(47076005)(8936002)(40460700003)(6666004)(36860700001)(5660300002)(2906002)(86362001)(356005)(82740400003)(36756003)(81166007)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:16:08.0705 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a2ba8-bcdd-4295-6568-08dc004939c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7503
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
index 3112f93af0..410f7320a8 100644
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
+
+	nor->upage_prev = upage_curr;
 
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

