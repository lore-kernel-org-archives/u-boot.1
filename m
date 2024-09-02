Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC98CD13CF
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:27:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A141A886E5;
	Mon,  2 Sep 2024 12:27:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pi7/glJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 372A08895D; Mon,  2 Sep 2024 12:27:29 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D7DB87873
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0sM1IIUON8nLFYRKI9kpsndl5l14G7BxGJBwvRcU9vBtvjzzivRlJ66zN5iOqkDYQ/Fsp1FLjSv6fKkcavxVfMHPE5IfUFSBTgW0T5l3tyNiQ1fR7tRdpEY9TV7Vipeyjw8KYGmTf17RQ4PRxvSlP3W5rIYLONPqyttjKMcIJNJODBqiIXJrd4KAQXYNK7I+8yZG0cp/ZkYyTp5/ogq7xRU+uqqR2gPJGUL2EHtNRzmrUk2e3vfPA2i6D+K9LRtJCfE6csLxXVq7Zm/pgccd0wTl4d22F9nITUVApUA3a5Vs4muGvxm2ushlTr+4HouldRN780LbI2hHXAdbTXROg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bBQS2PtO2D348xG4SILxLweWGhXgc0IaUG10ezMiYyY=;
 b=inKijdzEMauqZQkfFOGpO4vUuF5/CREt3I4gwB6n74ElVLvwX8Xf/PuEjnYfCOErLQAyFt/AtMPuraoUTJU3/wxpyh9f7b52qLuNVCNCuK+v/zQPQYgSrkm9zwDZ1RyfcuoB0Yctj3VQnnCrpq+s+DBOwWQ+3soubbpsxHHbBq02GwB8faHdzButKJAweGDtJE7+ZfnE+/TGMbXwG3ipB5+C+sVmkelSw5UAD0pcktz9EiCmjcyknLDZ0Repwu/igan+g+MPDfFfxKYBSQcQ6w2RJMdqqn5F/p1qBJcp4fc0lj+2lQb9xQ+9DTrxlbBDuDv7YY8L+BoTF39gxgjGyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBQS2PtO2D348xG4SILxLweWGhXgc0IaUG10ezMiYyY=;
 b=pi7/glJ+MvnAKgXxNBswolwolVDx9W8V6DjaMS958+hHqFBwuheGmzuflqFNaQf7Q4H0yZiZ662BIVOr8JehyUCBrOhBF7OlPwAqXc3S9VuNoSDntRwwg1ikdUFaGlKN7C4ntgOlL3qShSQTX1K6AEGZNxiOEMpIbK1YvlC4ucQ=
Received: from SJ0PR03CA0138.namprd03.prod.outlook.com (2603:10b6:a03:33c::23)
 by BL1PR12MB5969.namprd12.prod.outlook.com (2603:10b6:208:398::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 10:27:22 +0000
Received: from SJ5PEPF000001EB.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a9) by SJ0PR03CA0138.outlook.office365.com
 (2603:10b6:a03:33c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001EB.mail.protection.outlook.com (10.167.242.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:21 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:20 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:18 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v12 2/9] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Mon, 2 Sep 2024 15:56:59 +0530
Message-ID: <20240902102706.1107-3-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EB:EE_|BL1PR12MB5969:EE_
X-MS-Office365-Filtering-Correlation-Id: 67d2ea2d-5fc2-4a09-65df-08dccb39d47f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g7ODlkUYr8S9aEZRxbd8W0XAbscLKyEWHHlDlldWZCvtE6StgZmSF43SM+OD?=
 =?us-ascii?Q?G5IvIzKgQXH6OGz81alZWcaejrUhg9uae0bjA7yKbrfTujBQO4ql/ODye65T?=
 =?us-ascii?Q?gknEe6IMpf8RJDsGnnyJ4NxztgD6g1CEr0eAHXCQGLeQfJU3Jsht3hcJ82cS?=
 =?us-ascii?Q?A1HW302gkMkBslwYBmwQI3GeO3pGKvEAhvtRweGzPEBvMnrCAC3mFhvD2SVb?=
 =?us-ascii?Q?+AjvEwiF2+01ATdt0pkL2uKv5gAzzNFnjr0AVThPbVQ4jv9aadzPTrUDsVb3?=
 =?us-ascii?Q?hsVYrxTxfMyGXZbzzF4HzQPBYSyKs0h9au8TnpPxhxPhmGj880aKECBCrD1V?=
 =?us-ascii?Q?UZlsn3xt7M7Pc4niGxD4FO1q9Qrq1WgwUvmm2bA/w1xt8SvsJjd+1XdsPA0q?=
 =?us-ascii?Q?gxT2RhDBv6yjEST2mfD2haOVepS3Cy0TietusR1sgYiDsQt/H24+0FSS3T7Z?=
 =?us-ascii?Q?imQgBMR0q3oU6WWAOtq3K+6Y4FduZtWsYC+mkMyKU8tl6+EGWNKNSnSVkvP5?=
 =?us-ascii?Q?hRzlP+UTztwHxCg+OioKRgbln73CGn2rG8s6hSsyO+WN5Toib/Sk5TUOcCji?=
 =?us-ascii?Q?nSJ3Lg8suFlPkO7QrIMYrKIfjREs+T9PY4tALA1ebIGlPtqLHh04iQxFqGcw?=
 =?us-ascii?Q?h1v6yIqoa52Ba0r4aSdehnXpBlLX7wNlAk0IuBfkWrTBckzLuHnJIEqQc4td?=
 =?us-ascii?Q?3xNCUjlAGwGbGl6vQMbiYoYUcjkvyODjXtcMWIVKH0r/tnHZMIqRJ5FgVygl?=
 =?us-ascii?Q?hA5lUvkTQa3AC2PyHJlttIHGwlwR/0g4VZS/Y0dAavBaY88B2du3nVWuYl34?=
 =?us-ascii?Q?PaN1tTKY5EIDamatKeQvANgK7KYl2eDzi/0edSPBPtLQ7hRPPDk1Of6WteoD?=
 =?us-ascii?Q?Wi4q+pNFxvsNxyCY9QdCZEZq3gKtSryTPSCNPvAObOg8Hk/Jom9BFtveLllN?=
 =?us-ascii?Q?0Pmh5MBCw7FXF4y5yuW8kUY3oVhQDeFdJGol3qZQbi1+HpLAZViT6vmGIwIR?=
 =?us-ascii?Q?wYZUlgrX5LM4ecEMsL/iTZT+ah+4MrF/zonKlyfW8D5AqSO6Q0aZhmgpg9WD?=
 =?us-ascii?Q?7kLbRDi+3q6t7DD9CXWAQKiygYE23/6rT0yJgouQY+STo6ppvBw8QZyVoXP5?=
 =?us-ascii?Q?wmfNtlt68b8JF/HVWvXG521ERbqAbC0/U3rWYscxNtzEertF7/tYvL+uW1Y6?=
 =?us-ascii?Q?4ebjfTlh4nFGwQJMsqGSIdbYKi5pFg7Y+tkiQVs0XUHh7KkX7fmTaiu+l519?=
 =?us-ascii?Q?zkYz/lPDDIZOMzJI98z72e+YZLD3t7RuSqxrox4AH3hgSxTJU5ZfHygFh3Et?=
 =?us-ascii?Q?vhiayxey8FS/DwAm8PjR0cVvz2yBKo7ZOHkozfYI4Vm56RbBYU2dVp8+xSYt?=
 =?us-ascii?Q?HYk0Xq5ygQLLyjbutoSGwp+l4CgWZE/2xQs83KIJdEyh4G12j5y0YMMlvGt1?=
 =?us-ascii?Q?biH2HRMhN8O5O6evVs952fhKdGQXgJTC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:21.7054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67d2ea2d-5fc2-4a09-65df-08dccb39d47f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5969
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
index afe6527a83..bc090094f4 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -461,8 +461,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
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
@@ -494,18 +495,29 @@ static int read_sr(struct spi_nor *nor)
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
@@ -537,13 +549,23 @@ static int read_fsr(struct spi_nor *nor)
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
2.17.1

