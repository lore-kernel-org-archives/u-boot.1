Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2E1CA0ED3
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:28:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D87BA88A49;
	Mon,  2 Sep 2024 12:27:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="brStPH49";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2CC1C87873; Mon,  2 Sep 2024 12:27:36 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0EF4488A27
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XfJAagrWuQXOEGAZF8lmubXSpE1S35lY+5X9etvTptns8Egp66vcEM8Pl1pfq9o+So5kSy3qJkyiBdCL47j98E7oEKdPhHdpYkKlpmqW8mg7u5ppefVVnkoPGuVNFZZ6X/Ihhusq4rcN5YCSrfhmaflL1u0mgiB7aix7aWVdJaH7j12Kkgori4jxBZeJcUuLmb+G52N5qHk6G8FkcwqQaIlWJjEf/WPHfIi4p49BgngVwjAEvsuhpiuuSO93zmcO46qTAkMnYQVeqtksYxO2OwOSFOV1erV1U6Bp1a0UWvP/1jVGRYHUCVH2BgNv2TQ1NeCjYLQeOB9RFHuYxUGyPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TN6ng4Q39JbKHaTq1UB8zCzSrNk/P922MtvUUTyUkCg=;
 b=XARZEyzt5D2Uuvb/ZmISlZzkig3bzHyCOeEOS0VIYQcDjfE+wfzGshvetFusUhoyZcP56L+c0zxGr/IOzoiSEbMDllLpsYTgm3RSw+3LJc0h5xULmUqH8Tnqazu2JuNntd0zWyU3OvqIrXViTr2C1IyBjlhyGPOgcpiQJ1BmiCVnrEJyl2KdX25VTC/rm3tbGWra7Ita6ZzKwFpoUGhtZbVyWfzg85jOlsSJzxIQIW2pCqH2iRshBmIE7EVc8gShiCBWgQVyzeuLjy6XkQvNKHHwx885TdL2OGybz37Oprnp63MpKHN/TtMh3xvfU1Pfg+Hj0IOMR7Anx0Zx1CA6eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TN6ng4Q39JbKHaTq1UB8zCzSrNk/P922MtvUUTyUkCg=;
 b=brStPH49HZyRWV8zspMWyaj3hjRRr+48sUUqIE1gD1of8ShUMdbSUz2kxYQlwKwa/YxnjE9xxRs4YNHgK2DM4fylEfsBNK8W7L1e0iZZc4mC3PnDIKBcsm2XaQJMwh1RMGTwhd1C2kwy66v4ETOVjCcdSnq9+Wdm2Mw3Hx4xo/c=
Received: from BY5PR17CA0054.namprd17.prod.outlook.com (2603:10b6:a03:167::31)
 by DS0PR12MB8574.namprd12.prod.outlook.com (2603:10b6:8:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Mon, 2 Sep
 2024 10:27:26 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a03:167:cafe::9b) by BY5PR17CA0054.outlook.office365.com
 (2603:10b6:a03:167::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:23 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:22 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:20 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v12 3/9] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Mon, 2 Sep 2024 15:57:00 +0530
Message-ID: <20240902102706.1107-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|DS0PR12MB8574:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e90d0f9-b217-424d-1b4f-08dccb39d6b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?jgzze+GCxLxtbdBdgIp3HtvzqvPP7UN1lbEwulFrUFFWn7HoGf4lIskaHdK8?=
 =?us-ascii?Q?wL6KWKGoedoUf/VV4jbKxztoIzTxqQ9vnpkexhSBk+f6p4i2KF77KgHZE7Ni?=
 =?us-ascii?Q?jvSIEthHvSNFrTUIPGjwPmrsCNiyfzSd4jSwdXrpacolph960pYydd5XJY2E?=
 =?us-ascii?Q?7iLm1FjvKITGVswMFb27nlCvytFsWuVZ5nD2ZhivV1zomNmUoHodqNNWA0RO?=
 =?us-ascii?Q?FDiuK0yOHzaZbY3yOAQ3HvfMKBx/AoU8EXqDd9nPc0rWer3q27FPzbVULCW2?=
 =?us-ascii?Q?DX+qpI3vxcRMi0Tc7kIzhWbAc9GkSiMGWHymrxvnlNtzn6uXgAmbP0vpUTAm?=
 =?us-ascii?Q?wXX2zq9/U82wx2Q9nI4LZ7NT2YUkJu6L/oDwksdY7SiU8+bSF988CGqx3a5R?=
 =?us-ascii?Q?08gzjYkeBpXRM2RDOYaPa92MiBY+91+vKeRhG2SXqDLqbAQ7BTg+pPwJSjhM?=
 =?us-ascii?Q?hrOn0swqbdltgPLDxI055rYbmn7lQqFJC21g3HX+c5DtMHJ/nLBIKKx0wrxw?=
 =?us-ascii?Q?F95OngjEy7EpOnYw5Hf8+C3b8nK+TEDA02dJFEMYbIZRQ0yA0H1qI8BHWOIb?=
 =?us-ascii?Q?YXZXWMIEcajAE/xe67c6j//6nEK5stVledxBwaJ3Sbg+n180xxBTHowPxV5S?=
 =?us-ascii?Q?CRs2ztvg+XIPMd0gg1AP7gofmBA3ywsNR+J90aaFWSQgtcdd/7mxqLlgrBzT?=
 =?us-ascii?Q?gJR/6JkOUnkhUNivuA7OUpq+TBAr+cZUZY+IaYVy5CmwkYuGCqBxmo1n4T8O?=
 =?us-ascii?Q?3wKtbZWQLJ/DtrUSYWLxFRVIxG/thdd9dZsyR1MecthaYojUSXnMUWeaDH08?=
 =?us-ascii?Q?UjyEUXe5pAagl7M0W3fyY1lmrkD5CeP6cDXWXN6pOf9+2DZj3WIBEbO6G34O?=
 =?us-ascii?Q?5x2LmOaJJQVu9eIoY1kOwjBxbuUiXlnnePDDkWz3MAQ4f5q3SvN+8AToPE0B?=
 =?us-ascii?Q?cfcSwOvOXelo296M6wUObuAPB1rFB9rOVf4vyHl6a2Kk+qBkOD3JvznEM06m?=
 =?us-ascii?Q?ml9jTLMu0oHI0R5kzrb/hXUZs4l97kFRc0m3DV141f6J0TWWgjX/OutDlFO3?=
 =?us-ascii?Q?ExomK03h5Qx9Fm40UzEHjDXkwPCKLVBmN+u7y0acmQR+6Kyr79O2VJMyMhfZ?=
 =?us-ascii?Q?6g4aQlDJu3eJtDmsaIKOC4mGnw84Bu9DD69fDGbEWCIUgwrJ+/HW+zOXtjTe?=
 =?us-ascii?Q?b+O/n1Qd7+RjdmOjkmbb16udkZxImMnWJia4uK5HtsiwbNdbdBRZqoTCjxip?=
 =?us-ascii?Q?c3IA4/XB3uXlwT8rqZCNS9Pc0W+7BecmPig55SWYtUN1YH2HP4MTlO7SNOYO?=
 =?us-ascii?Q?moCpHJf1lYWAYVbsDY1oJImeltvjmQHKEg7E3I7nZpykRH+Qkpr5mmxwHNPw?=
 =?us-ascii?Q?8lDHnQWmC+Emp5d9omAyCDzJpC0PXdosgxlC07tk08XClS+s9qZUvcPwjiWO?=
 =?us-ascii?Q?gRODlvWdyJDSUKtkKWVb42BPXtGyq9xp?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:25.3710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e90d0f9-b217-424d-1b4f-08dccb39d6b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8574
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
index bc090094f4..0fc92fe7c2 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -908,12 +908,32 @@ static int clean_bar(struct spi_nor *nor)
 
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
@@ -923,15 +943,19 @@ static int write_bar(struct spi_nor *nor, u32 offset)
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
@@ -943,15 +967,30 @@ static int read_bar(struct spi_nor *nor, const struct flash_info *info)
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

