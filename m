Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6358CDB465
	for <u-boot@archiver.kernel.org>; Tue, 17 Oct 2023 03:33:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15C0C86D18;
	Tue, 17 Oct 2023 05:32:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JBSkrJSb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3391A86C58; Tue, 17 Oct 2023 05:32:49 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20607.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::607])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C930086BDB
 for <u-boot@lists.denx.de>; Tue, 17 Oct 2023 05:32:40 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S4loJ77tQETfJV09XGV+am/NmVLRR2Kx+NapKW4THTogmx/XOhfPISRwIOouH5tLysyVhX8kNIxNjVjT7R9vz9VhD41D5gfIEJwtPjN5R/QZm0NTnYPXlBcvbLrplJtCo8OKBmfCWGvtBTXc25+j/+0VuAajT7MIOlWxRiI6givtBXo7CIe9d/eWNKqcQ8YQjXNUcXGcfFVeU/eznifkr0d/ivuVJ0AVs3SZ4pUdQy6/mn7B5CDjeGS6VlVUns1Xjboj6IXJoWbB/Ii6yGvnG5ORfpati18GWcbvsuMGiqz441QQw2lTFQtRGRRcUDAX+hFOPXfIUj/K85lhb92Gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nuc1cHy4x4hhU7LL4mZX9GC+oHkHeXUWTFP6xN3yKCk=;
 b=QLtlRWlqJpJi8gcArwA3UZ2h2mh6GFK+YcsPFy19iXAeAFV+Wb73O+aSIqXCVbjXT5IgpqvRc0isCYbW0VRm10sLjCNPweD8Gna8AFExTTu4m5phi2APhmr5C9Y3BuLqSpGjAyusXhJ3Xr4YLeH+9R/yKixT3k5TkHxNSd9ihJ+4IaCRvksL8wK56d8rTxd2BM03ENbA2QdnRayRJ4lrNLXQoEAo4h1mFQkUXid1y4F8Gyq+um0mmQhaNJAjRMYM3aMeYNCjQ4osNhJy9CA9o+yVaFXRJgQkjTbaKD0hM4PdjcxsotixVBJboDzr7YwGUlEGWb4UDKJSdjpj8apAeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nuc1cHy4x4hhU7LL4mZX9GC+oHkHeXUWTFP6xN3yKCk=;
 b=JBSkrJSbXd+TQbx+p9sjA3wKSXeEbP7aa223jagbVZ+afLWh9s/vdNV0hV2sFAqc2U0sU6BJSueWmc3J1PbyZUBVx3H8t9tTZBulsIkf5OldC9vXXcnn5/SnQ8so2BVSx13RydCZZrEPWTx4eeZsIgZw8Kh8hp13zTiRWDrkbpg=
Received: from DS7PR05CA0058.namprd05.prod.outlook.com (2603:10b6:8:2f::11) by
 BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 03:32:34 +0000
Received: from DS1PEPF00017094.namprd03.prod.outlook.com
 (2603:10b6:8:2f:cafe::d8) by DS7PR05CA0058.outlook.office365.com
 (2603:10b6:8:2f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.18 via Frontend
 Transport; Tue, 17 Oct 2023 03:32:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF00017094.mail.protection.outlook.com (10.167.17.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Tue, 17 Oct 2023 03:32:34 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 22:32:33 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Mon, 16 Oct 2023 22:32:32 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 3/6] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Tue, 17 Oct 2023 09:01:55 +0530
Message-ID: <20231017033158.27740-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231017033158.27740-1-venkatesh.abbarapu@amd.com>
References: <20231017033158.27740-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: b007d1f3-13bb-4c82-70cb-08dbcec1b404
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EnXqcWcy8I1z057anH6xjai050/HgWS//7X6QLXQE523gbmCjkKymi794E1woK3blNsSlJKVrBz9UtO4H5SazEDLJDf4bYkPdY0BLqoaJpJJnKYdP8ZyyBjKkczER7XnFpw3Ljhn/EEiTvBPjm/+3PWw+BldrHpwPjnhxJjc+YhGSFFGkScUzsyWtRd6S8Lzc1LkQVj/BivopvwyVTPjaneu4smqf3s5APlihSzJl0UbpWxFkTzzrtisQjh9J8GNGH0g8Gsnw4vQ/exfUq44N8JKVo9NAghaH+37CO9ACb48IlDT9E8RyQRUxa9A16zWlyqNLHLQUUJtc6X7ZVQIaOFdV0SZa5pdbWZq5NpDkrA/01MHf7POgPhtC1/qmX4IqmJC58spt8ZnUBW/YXKXcSdxXkyKf0ncQEIRuGeqb8KDj7oYOc3h5CcJKZBb0m6BoMC2YfOwONxV5KWP+oVjBoVEg1a5GDkuVUYHPH80naCfxJvhx9Z1CamL5CgZWVc2PobFJ622Yy7LG4yVfCSc4P9g8eqiTVzT3b7VYOzQVSwAoBTG4OC2pC4wQTYO6lfMdELyosVXHVTYTIqPGyVQwgxvyhFQRlsaMgUrTzeyjLOr2E+QYfSi4W9Slkvbst6isJ3u9Ma3Vn5D5HEPEgSp0WsSn+HUsyyFpstWQsBQ9NYAcn7suKlLtnrKGmE2u/PZuLfiNZ59cRJ0nLKSbXvk3ZDaBmsE/DpRZ2ULIciNJi5hylGtLIkon+1SYgGp0t0OrluaOmek72m8UlUupg0bGw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799009)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(478600001)(47076005)(70586007)(70206006)(54906003)(6916009)(6666004)(316002)(36860700001)(356005)(83380400001)(82740400003)(86362001)(26005)(2616005)(1076003)(426003)(336012)(36756003)(41300700001)(81166007)(5660300002)(8676002)(4326008)(8936002)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 03:32:34.6475 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b007d1f3-13bb-4c82-70cb-08dbcec1b404
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078
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
2.17.1

