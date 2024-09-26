Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B33CCFA17
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:56:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9404688D13;
	Thu, 26 Sep 2024 06:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1iWKlCXG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1692D87BF4; Thu, 26 Sep 2024 06:55:38 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::609])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78A7E8891E
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:31 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D/+1EdMdH1oJM+3UxbNRiDhqzZvBJWNFyAKrUnk+9ElKv8z/st2JfSjTc+TC7oIYBIK92aJyCBFDRBAUvvK/LOydIUjzmvssOjTZQrRIjh1KOgCh9XU7eUKs/vSdX0uoyKbJvYsmYyiU8SCR6hILMsvjkPvXTWeqWbMawdULKsg95WKEYQ+OhAA6kImjMXZUj3Fbsm9hzJGE+4tqtWFnw+emEALZcrDoWhZx667PhyEqa3cuvXlGghw24GhqcNCf6z5wGVkvzkHL5n19D19fbyzX13aZCrwjXTj7OQX9XQHWoA2Nzpfze2mi59kVWivDnt0o3kdbYZaAjl9CqODjUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20QIJ/mFvz3J81Pu9OpVHCrEcv1thVqNocETVsGj71I=;
 b=yt1s73pabJ1Uisxjc6WFKoQrVov9cqNXkYB3iE/j9ndyH1KQgN/lq8K9hDkje/hmgT8PpcWvp1jOGTeN2Y4NsslM7crbxVZ4SFwD1MqmhR4NsVfBqH9qTXYcD39oqFZf70U8LxU9yT0nZ7TcJp+4dPaiNQ/FlQBUSV9ZKXmcHgJPVyPsv2ZepzcGCTHjfuDyKSCOUldUhcgy3XL+IQ1T0se1EKqmWGganCffqtZB2bGUGT79GrSuipRBBK7Lp+FbhbN5xnv5SdjYvyCNOHix+Hy+Y8sjlWZtK09QrUng/qOk3PZhOtQC2TEhkujcO2ODzUofCYmy2jZqvzddYNjTKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20QIJ/mFvz3J81Pu9OpVHCrEcv1thVqNocETVsGj71I=;
 b=1iWKlCXG+pi1WuietVk0gx7wSDrWVsJsAES3L5D3ybSVbx2rnB5/V9oBxrmTAoLg+wTMLukRyxpd6TkEdPwLZ33jHU3/72a9rZDLzLSLLGswtHXrpYaq3h2uT3ZhH2ZEk6/b0zuoosUvUmdpkHAkyGEnS/NsGFh9XYN5DK0Huck=
Received: from MW4PR03CA0114.namprd03.prod.outlook.com (2603:10b6:303:b7::29)
 by SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 04:55:26 +0000
Received: from SJ5PEPF000001D5.namprd05.prod.outlook.com
 (2603:10b6:303:b7:cafe::46) by MW4PR03CA0114.outlook.office365.com
 (2603:10b6:303:b7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D5.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:25 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:23 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:22 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v14 3/8] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Thu, 26 Sep 2024 10:25:03 +0530
Message-ID: <20240926045508.1492638-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D5:EE_|SJ0PR12MB7007:EE_
X-MS-Office365-Filtering-Correlation-Id: a1241509-5974-4166-85ab-08dcdde76fad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Uxq2p8Zt5R1eK8OBFbZR8QUR1nMmcOU48bn4PDwN5PIr8c5rTxPODJ4fU9cB?=
 =?us-ascii?Q?R20Qkuw6ZhDqbU++7CGIXCYtNw4WRiVX2VrclL9BZBNoJV8RDQOwBujsbXIN?=
 =?us-ascii?Q?iFpM+q6Bnl6GJZYLPNUZJnupnq4Rnh9HpbmrEFZ6ODsGQZrDZ25ug/kiPUX4?=
 =?us-ascii?Q?SXyaJfCTpQystxbBCTdnVjCYGwZZj1m6S0xAmluaAh4nZ3eC1YveGG0BtmrI?=
 =?us-ascii?Q?cZMtDPZsQQt06GHFctdHh4DF5BO20zIlNqvOfiMPJby5gK9S0Njlb7GnfgX/?=
 =?us-ascii?Q?k+fEm+D1K/0d3KRodbucAOV0v6stINupNoCj3xqcSHY40Oaru/udujA7irKz?=
 =?us-ascii?Q?wZ2ub3bSacS7qsDyfnnYH9nKOGQ5rtPzdL495R8J2JJPGoOlSTg0GVlntHvT?=
 =?us-ascii?Q?xm8n5WEje5/BY17D6MI40eg3mOGlZ3S6/Z6Ck7qUEZmq610iE7Io7Zm/ZaDW?=
 =?us-ascii?Q?uvdQiKkhZuDRk1MoHi+jrzeQSJfmyZtQVhCQHRXeeBDtTJ4voYwlpF4mEL/a?=
 =?us-ascii?Q?SFdTf3k8ckfWMS6d69hS/tOnDLEIxTIsMgv+GxK9wz3zpG2kPJHEqsoRCi8m?=
 =?us-ascii?Q?+NJj7n48o00yggRYRyPSg+rpkhiowdZV2ZChMLY4/caNvbWEa7Z7RDKzI7Cx?=
 =?us-ascii?Q?6qHuqEUslA6JGt/UxdVFCMByRyZfskE6XSo9Wl2xiwUOdUTawARJ9T2AyE1S?=
 =?us-ascii?Q?1cPF60bA2y9f17nMzEEq3yM5VH3oBCC96urDSqlAjChrffmForKO4Lt0bmad?=
 =?us-ascii?Q?13goDUm080ieT3fdVfI1wRXZFZF36frSUlroXm5FYQR2GhE6SLjYJuCQrscm?=
 =?us-ascii?Q?euleWT91VDj45RrFLjP1jaoWm8ejmJLqpCI+PRm63E25DkxYd7CztJzybJ6S?=
 =?us-ascii?Q?x8NimVR4E//iVFI6u3IOXQbNkxfj/LQ9Q6DVFCqcNosACHxoMqTd+1ePlL4T?=
 =?us-ascii?Q?o/8zf+fu1QXsqoqRnVoe1CtaKz8uu7CIyExbo9xGye0fR3Sy07W/R8aiX697?=
 =?us-ascii?Q?jgibn0i9ZIxoHoCtyChnqc0EvxMNaeCwwS+6EEhqDjE0UZdCzi29+iTobSv2?=
 =?us-ascii?Q?0WSM4kASB6GQeJwAUg7IDAPFMEqefWHyclqKDhojb7GTta+DHseSQ/AYS1+i?=
 =?us-ascii?Q?aFSla7w3CaQ3iHXunD565PXz25gjrY84EvJsALxtvR1olpcLquome2HCFRop?=
 =?us-ascii?Q?BUaQ7Em+PQ1O9ScTqWf7BTJD1kIpfJZ8D7RGbLdmiVJi0r93B1zA6Ssm6Iit?=
 =?us-ascii?Q?b0JQChWlM9CHOd1k14KjwGhOWZzwQXkz40twV5j+tk85P+c6/AIjrGujl6ts?=
 =?us-ascii?Q?N7DUQtZoi1Euh4YjV1p4HxxB38DgYuDnab3MU/cdDEdw1mRSkfKMVfFQqG5z?=
 =?us-ascii?Q?NHSlYcyVlk3kxzPybYF1x+CFrbbjAS/eVc7ybYoCu72ceOOsdAaaFyckcTXU?=
 =?us-ascii?Q?/wIodKAnN20k5Plxm5CmTXic0fYMczUN?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:25.9188 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1241509-5974-4166-85ab-08dcdde76fad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7007
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
index 8ba3a9bd60..ecebb44171 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -467,8 +467,9 @@ static ssize_t spi_nor_write_data(struct spi_nor *nor, loff_t to, size_t len,
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
@@ -500,18 +501,29 @@ static int read_sr(struct spi_nor *nor)
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
@@ -543,13 +555,23 @@ static int read_fsr(struct spi_nor *nor)
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

