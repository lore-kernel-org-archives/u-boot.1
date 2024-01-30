Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFEAC47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:45:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 73E3C87DC1;
	Tue, 30 Jan 2024 05:45:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E7Ik6fdk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B75F87D7A; Tue, 30 Jan 2024 05:45:09 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15F8D87D78
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:45:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mtZMpfS0SAj3jxUk0RvMqxfEbaYWSjCueHmPG+ISdaqc7nrZqR7LY/VwEoWL3gzHEkex8xKnBasATv/pSsOCo3qotTjVkAvD3Famk8ftsxXOEBdTByLa85qtOOtLemz6yjQEumPTl2GVmSuc4gPeFeRlWEjfWHS+Uz59j/S1kAn/N588GDhg+A19kQ1O+JGQrskgmT8XdKDZw5X3sAPkg6e8PYtECUQMWwnycHITP40W0JNabrmpQQ695sEeIc+mYb1uH5x7gLDjA3HPQlRH/xoMkBNOP+REzeCV42Sr3eFIgZt4N2upebDNQQb/L1URIGQksqxg5LTrx2Rqa3VnZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i2W6FSBauR2QyMxq6e0TkFmIiY59FxBV2qJPzuZeANI=;
 b=gle9RJxsdv+kBsTEGe2Gh7mAyK3BmJO5+FWXRxCShw7RERgj8crGJBYWJljgUj3WbR6yfJjZNrAa6YWJHfExFK9Km1O9rN90dBf0Tc2E4wpr/zcAPaQCjkJTtlZvhVu5MyewIzvnglhW4NoRLOECECpajLXVMvuXDqitHfDRw9O8guyrR4jHArCziwuUbpIC2AsDQI6ZY8lbJT4xR0Wddy82HCwNY+Lo27TN8t0NcFwlVYXFu9qaGrM3Ic+LNDb14ftr+K3gi/ytx8fpfPhqzrCDYy65yRlqy1r+R/rDAIdOrL3G9M+zUCoj619AtviMZbbq+iSoorifjcImzOChZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i2W6FSBauR2QyMxq6e0TkFmIiY59FxBV2qJPzuZeANI=;
 b=E7Ik6fdk1MOxXBPFlf+dT1wVQOzHJTfUlOlu8hbopuqB8Ku1P6ff0Gl+mr8Pa6gN3Tig5a+FMSYdPevoZGizEOILygtkIfSG3DrHL1bCVxDsbxtxRdKKlDYeidac2kh3P+rNLsRcj0zc6mESvaz8+bhHUHRfesIrQBleRdHdXo4=
Received: from BN0PR08CA0024.namprd08.prod.outlook.com (2603:10b6:408:142::14)
 by LV8PR12MB9407.namprd12.prod.outlook.com (2603:10b6:408:1f9::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 04:45:01 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::25) by BN0PR08CA0024.outlook.office365.com
 (2603:10b6:408:142::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:45:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 04:45:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:44:58 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:44:47 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 29 Jan 2024 22:44:45 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v10 2/8] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Tue, 30 Jan 2024 10:14:17 +0530
Message-ID: <20240130044423.1391251-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
References: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV8PR12MB9407:EE_
X-MS-Office365-Filtering-Correlation-Id: 483e6ef2-deec-4d19-4e32-08dc214e386d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fCVQ35lbK8R70TUCPmooXPgMg7XHTi/OczCySnx2YWJQHDuEqk+1yFdj9DQHJgmvsvIl1nIv24nLUl4fRWYHQJrdGDoiyfniCEhSEzP1hnlARW3YLogAU8TcvsMhjN2A0JV2XOdMHl62J6iNaq7Se/MUfdUEcXNE+VxmId2zAJdz0FGjQlZ4quNnbzTsUFYnW+IYm1Ba4SoWuva3P7Hdh+TOdGf44ivS0gnpV7HazfhvmAfmIgoaUhdnAOotKjVUy5ACNr/MRC98SjdQvix9wQCeVjAOt6RGzd2s7ewHe5/NJ9Uw+Um+3fZjBqpX18J6uGCbABF57yj8dAToWQDMuRlQX/7JCc53RHn4YiC+b2Rqxrh3mdgKy8wRVkGAnLx6Pdcy1N5gk1kFmH2lyQGlXv4Yn9GLefQN34K+i+DAMq/bzxgr1sKu/XWtNSVuFUvP/fQwG6ZtNhUvf1mUarLfFwMgga6mtTZy4bGQ4Gt/nRCvNrlv8j1cY0HUhOKDOmVnIZJVKC8agI8iD2JsquUaDuRjkYk0MrRV16RqlRaqCqE6T2eyxrpmUlwd9ra157hWAAQWi0wMigmD/I93/7uip5PikNPscBOphPyKkWvwJd3KzeApd7UMhozGXwapFc08yv2Uy0ioY1c64JXVVmm4B7x2f4Mmksa7Y2QrVbIDQbdNt3Z/A/l/d3mFdsKV07ANoElBGbD41UBf89CfF4WWwt+br/UOjrZ7FmkAhqcx1AY7+/VwolvPa7lSzxy57T/0tyNa9yV7aWWrn/zatWoIj8MC+tfJJ6DqQ+attuB50Jg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(1076003)(426003)(26005)(83380400001)(336012)(36756003)(86362001)(82740400003)(356005)(8676002)(5660300002)(2906002)(8936002)(41300700001)(4326008)(47076005)(36860700001)(6666004)(70206006)(6916009)(70586007)(54906003)(478600001)(2616005)(316002)(81166007)(334744004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 04:45:01.7152 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 483e6ef2-deec-4d19-4e32-08dc214e386d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9407
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

Add support for parallel memories flash configuration in read status
register and read flag status register functions.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/spi-nor-core.c | 50 ++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/drivers/mtd/spi/spi-nor-core.c b/drivers/mtd/spi/spi-nor-core.c
index ef42964ace..b7e5f253a3 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -462,8 +462,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
 }
 
 /*
- * Read the status register, returning its value in the location
- * Return the status register value.
+ * Return the status register value. If the chip is parallel, then the
+ * read will be striped, so we should read 2 bytes to get the sr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_sr(struct spi_nor *nor)
@@ -495,18 +496,29 @@ static int read_sr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading SR\n", (int)ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] |= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
- * Read the flag status register, returning its value in the location
- * Return the status register value.
+ * Return the flag status register value. If the chip is parallel, then
+ * the read will be striped, so we should read 2 bytes to get the fsr
+ * register value from both of the parallel chips.
  * Returns negative if error occurred.
  */
 static int read_fsr(struct spi_nor *nor)
@@ -538,13 +550,23 @@ static int read_fsr(struct spi_nor *nor)
 	if (spi_nor_protocol_is_dtr(nor->reg_proto))
 		op.data.nbytes = 2;
 
-	ret = spi_nor_read_write_reg(nor, &op, val);
-	if (ret < 0) {
-		pr_debug("error %d reading FSR\n", ret);
-		return ret;
+	if (nor->flags & SNOR_F_HAS_PARALLEL) {
+		op.data.nbytes = 2;
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading SR\n", (int)ret);
+			return ret;
+		}
+		val[0] &= val[1];
+	} else {
+		ret = spi_nor_read_write_reg(nor, &op, &val[0]);
+		if (ret < 0) {
+			pr_debug("error %d reading FSR\n", ret);
+			return ret;
+		}
 	}
 
-	return *val;
+	return val[0];
 }
 
 /*
-- 
2.25.1

