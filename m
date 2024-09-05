Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33383CD4848
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 03:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11A6B88B89;
	Thu,  5 Sep 2024 05:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SJQWvyiX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3156C88BFF; Thu,  5 Sep 2024 05:22:47 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 186C488B84
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 05:22:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZRb3fqx1DbO+93DMkC8j4u26cKYCqHTnX1JJnREjOImpKyJyt1+RbI8ZbjuHVMf9/+3v3ynLVwIzH9QvLDohJuDeZBIdhKUUSDJRw1MmNXIF5GAZ9v92HYqtA97ze8yZGQ6nQ2Gdgd8fTmGdgGs1MZiqRJeP9os4WjuGr0WVDggJFQFM9JMxc9+vzOT9+vSohzRPiQUhvTJNcdLJWXDH0qb8DCJIVV2/0ygrc9d+G/TtQc+0/2bfYaitjfHSSFTjcBVhLwzWXyva9w9bt4xm5ygJ7ltrjRGJH84F4zchUKWftMxLUbn9vlQkjtGKCra7Vpt+5CWWplT6l46jPXDuDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe99L6q+YXhVQRUNLtMW1rza3nb0FSXiC3hWB/PD1rc=;
 b=GuNBpWuy0kSjbM/vLsiXmemxHViZeR7WiCkI4J75RqpC2ZyNxZtaGPNI4+lZlt0jgS0Y1fHjgipeQdVT3v4sFdkASQfXtbcmNBgSbpf9WicvV/rYxpiKX9OpvDYoh7Hd4xFGaBqIGEG9QtT/YgvjqU3Hy/+yQbMG0N3Py4YGrWaqsQEAFphrSdN/LXPptGob+gj3Fff084oPrCff0Y4BXUtkywD+GXgQ3nTv9jRHVZMBkFrwGrl/aEysNAf11BohDMQgA3mJLNDaFuJo0gXyv9eZxvB2BysIZbc+YEa+0j3px+95EbBM/NfBJHXVJyRAUCNClu26XYpXrrjRfCEZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe99L6q+YXhVQRUNLtMW1rza3nb0FSXiC3hWB/PD1rc=;
 b=SJQWvyiXcovwsS4rSYB1zdTFZnwv4bIXUpH+MnqRrVwIfKN3sc9HfOEM++x1OCDqkrUctcxlFrie02nIYW71EgyCpVv3Hd981PB4CGrRPUxh1pg3VquHeKVz54fNWs1jYKpdXZvHvcPmyUuB+sGu0D3p7KOBSNYrv1pA6VjVRBo=
Received: from CH0PR04CA0093.namprd04.prod.outlook.com (2603:10b6:610:75::8)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 03:22:40 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:610:75:cafe::7d) by CH0PR04CA0093.outlook.office365.com
 (2603:10b6:610:75::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 03:22:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7962.2 via Frontend Transport; Thu, 5 Sep 2024 03:22:40 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:22:37 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:22:09 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 22:22:07 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v13 3/8] mtd: spi-nor: Add parallel memories support for
 read_sr and read_fsr
Date: Thu, 5 Sep 2024 08:51:41 +0530
Message-ID: <20240905032146.2470396-4-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|PH7PR12MB6539:EE_
X-MS-Office365-Filtering-Correlation-Id: 69c51bce-0b90-4c6f-422b-08dccd59ffaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IRIHd5PJuNmKFFOIZGHEkI4t+zlSUVMHFcKencVGYPMHeCp/v2NnfwDibTKm?=
 =?us-ascii?Q?oWeZ1xEVB/xWEYKhi4XLdRZsBokybXZVnbQSc47QS+9LvI799hKJX1USyRGn?=
 =?us-ascii?Q?yQxYdfV3AC2a1l6Ats7GdK8vdDkbqFOpBMmpY2IWr2tGUyTGJ7X0cCFFcg3h?=
 =?us-ascii?Q?JTsO8RT4q3JSxgO/ZFKeQpaXzAS0+gVs5wZjm+T5aqNbasEVqneyo0IQEtdC?=
 =?us-ascii?Q?eZd8xqkOO452t++NdhQa64ctk+GVc39r4wQv+KCOwr5nTE7DUrNf3GPW6rpz?=
 =?us-ascii?Q?5filQ90PojQ7T+Zv2MlYC0UqB3P6ACiCdxB+3r74UfqkCdYZ9DH9SNXXtCkI?=
 =?us-ascii?Q?pb6LM+uj6I3RkqecfA1eGjXNQ4XZ5gv03XFne2G1yzoY/qxIfeKWIx1dm+8J?=
 =?us-ascii?Q?7qel3CyujDtOJpTlgZkPSOkHk544Fjn8YbEZvzk0m4VrhXaXjvrrRlAzjj9t?=
 =?us-ascii?Q?TfF/064kqsfIUMlCMSzqZhWuEeeohZMZaoqk0WpzM3QJHT5uzuXWgU23k7HU?=
 =?us-ascii?Q?NkW+p2uo0Yfa3nQ7rtTa0ZhewZyUhyAaS1TzVTzpqxsN1EgZYDOlOopDAVxR?=
 =?us-ascii?Q?8MXxB/dv+R2jVl1dnZIphfRsIq7pYWLYt2+2UWdA6QqXp9FJ5b9BehLrqC1g?=
 =?us-ascii?Q?CJMWOe20xhY/A10SV8YJekP5Zs3V36XtVe7cT7VmlC9QAly3WSWherxa0BMu?=
 =?us-ascii?Q?DJLC1uFTihsKiNdPvDox6HIjDilfoQS/akc6vmFW+VUhiVVAR+yylTyJu1iE?=
 =?us-ascii?Q?FHy6yL6o2Mn6Tro2SWaPo/NOk1zzS2R+I2SbnkQ2w0lN3fYjWpFkHfyY8VyV?=
 =?us-ascii?Q?17jpXF+c/+62MCUVBX2gffleA+QFnifa64019o8vh6D8x8pVmhvWmpXnGJDl?=
 =?us-ascii?Q?be3AFAz7ngbC9dkcHWVhQ4ajFNwCc/d8m67GcEM6k51mze3GkNsmvXEy9mWq?=
 =?us-ascii?Q?o53ozrqOxdplX6l8KMQzwRsr3c1tdDVMctlCoAGmdA2eB8TMXcsQwMKygQvr?=
 =?us-ascii?Q?mvYLB6cgow2mQE8jhchaKaoqT+satTL+XIKzEsQyL1Hk7kZP04DUUcJ+GFIT?=
 =?us-ascii?Q?8JL8H5XYMjSTT7GrY4kylup8j1DMtS165CFnZp7/JK7rrjSkZ/gfA3bR+YUZ?=
 =?us-ascii?Q?rt5S0jF74aVKuLs5NVKp7VZo7Jp8/iZoV/lmoQYVVnBhKSvzSNZDriuLhvwO?=
 =?us-ascii?Q?C8tvZkDNpqCw4cN9PRna5G+x/0bVLSlk7XOJdulf44LNrX9L6jeIn4DjArRm?=
 =?us-ascii?Q?PEFqlqc5nHb9oHnfbpC0GAF1kVeS5wt1k4V4sACvLryty/PaChgTxOZcer47?=
 =?us-ascii?Q?8owqBPVuid7QH4sL3Ja+Ygu8iyY36NIW5dCk+cBIZT+44jad8bmWULw9SI1w?=
 =?us-ascii?Q?OGSl7aA5jGVCb+AYVBkffzM7FOgYJzqawUGcQqqK1erM9a0YAM4CyAJYUR2n?=
 =?us-ascii?Q?iNIKDg2oeTlmUZpQsQlNNcsLJtWiH4B3?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:22:40.4445 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c51bce-0b90-4c6f-422b-08dccd59ffaf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
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
2.25.1

