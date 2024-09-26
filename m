Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855C2CCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:56:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C147F88C9C;
	Thu, 26 Sep 2024 06:55:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="0CT4SWI3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4F2188C53; Thu, 26 Sep 2024 06:55:37 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 640E787BF4
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8yYZe9xNd2SKvEVH9fyZuXJlYsQtim+Jhun4YF1EjV7RQBCMlzBI4ldgX/hCPLX5KRT5xh67DJYw7+y4k1Os8uWZya7e1p/K24tdRJJa7iZGjUFI9gha/x8fHtnUSLhCVw7dmAQf64bVdZkZEvjAPWtux5EDxbom81Q1hIzra15p2LLD8AAoLkA86cjTyjBxjY/7jqwqpXOQQfAAawgZsppuNamPTsv7PTkWZAV8jyGeSFDmbkkkSBkHopiEuUjzJwMVwOCg+UYbZwtFe5IfZKNeXp47qglLZC5q7K974NlEQ375m3QFaAmPLt6k0Er7DuIvL+8upF1ZeADQx0fqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZ39GvdBuMnSzmvec3syLG2jmHDRaP1an1mkNkojafs=;
 b=mQhYHw17v/5FPE/92aBRfmo7US1RmVltlFYwLocaNE+w5oJOE81oK21koKAVB3oLSZSewynMK9U3Rkubi48C/K5RsVvhHa9vmIXqBoxzSe0m3u5iW0h5I1MYNwRSIOKxWPg/zxuTVLfygiMYyYTr5JZsA+xf/u0k5r8X2ALw2peb/QHyljLbW4Q9+E4yHjsveH6zx59L2vgtON18Z8Mnu18v2XuP/R9OM1M8MA3pAXP0tfNSBBaoMgwnN+BbRZTa+wyQmSYNSO1vxCuaZwBDuhqAFV4GsGJIhmAUjNRCaedOyPSP1bPQ3NcBa2vCF10RpLr/b3eAcNdDoVZOW771ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZ39GvdBuMnSzmvec3syLG2jmHDRaP1an1mkNkojafs=;
 b=0CT4SWI37bkTR4kuetK2GM67kTNT/k/2POqmk3Gnjv+m+k3F/+gdILy4qjNMaJQuHAhufNDOwI+dgAycfrY9+zPIVOdPhHEioc77H2TzQukWrAcKXnFi0DXzedektvJ34b4IKZpCfTqm11IRhy8ZOEZ+BVj9iWB2WR4ziEiZGVg=
Received: from CH5P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::28)
 by PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.28; Thu, 26 Sep
 2024 04:55:28 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::4c) by CH5P220CA0022.outlook.office365.com
 (2603:10b6:610:1ef::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.19 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:28 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:26 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:24 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v14 4/8] mtd: spi-nor: Add parallel and stacked memories
 support in read_bar and write_bar
Date: Thu, 26 Sep 2024 10:25:04 +0530
Message-ID: <20240926045508.1492638-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: df917d00-e3a8-4626-1247-08dcdde770e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?b3H4YJC2BiE8eYI9xU9O128mAJaWC8UUPeJBIeRPKT95E/FBd5Q5exjqgc1j?=
 =?us-ascii?Q?qnwN7npRp0YWOQ3M726Wa3zTxcojNhx4nHMkyz8ZHipCb/vcBpKCmpJ8n8WP?=
 =?us-ascii?Q?A+vOTNp2M6C7r+AwTkfgTWfbMXRrEAbJ74HSTWSh1HYRC/DbGgagtJ79Zi/Y?=
 =?us-ascii?Q?bpMIFawqAlGyryrFaf0VfbDRLMH1vD7ZX5vJt/ERMG00O3pdiR8vKmI6+1W5?=
 =?us-ascii?Q?xUSX5F9mffRZ7ROJQucR5xR5xpmqhJxmqK8/nQt2GPMC02bmFpqnzp9iAMPn?=
 =?us-ascii?Q?L3tzyLCOuLOakwfJOj4DHn2zP6LXJEuIJOVPfOicsVhCdt8ETAq7ID0yBgt1?=
 =?us-ascii?Q?ZzlqWhN9G3PbyUpszP9viSpIsMRaSTWTu1VsdZ8xjtYxl+Pwp3qvz5QUVMKR?=
 =?us-ascii?Q?//AkFgYLoyDBNXNU4uLb39ni1KiWyDepfLGyPmobCWp3mo3k4X51AvEE5LrO?=
 =?us-ascii?Q?rItNDk8iNNQqHRdh4uMSyJCWXsf7+pUpyZqCdfTH0M8nIuqzgFDdMu310ccN?=
 =?us-ascii?Q?YvjSLDHVUe5d75kxICnbU7HGIIgnYnJHgWzymI63RBiBj/91Tc1dNn70fnQi?=
 =?us-ascii?Q?JpkEyvBwsiE8KsBSlp6k9ops6poi2VREY/uZEcUiAh5Q+gw2PcAJ+VuoNsrF?=
 =?us-ascii?Q?9ZAcBHyO+mlWVGBlEMwraUTj6QCd+SKfnbJ6fMQR4NMP1vV3bCAoewQnYrse?=
 =?us-ascii?Q?KnmdjgquJA/M6ipmliRmLwh6+cl8RVawYehp2h5hfElhmSgcojeCnGV1fEAu?=
 =?us-ascii?Q?LX7QiF35Xsl4e3VZy7rGOuvrOIstnwATRFgKkaWsBons37p4z5KLNUEAqNyj?=
 =?us-ascii?Q?Heh9iKPRPfst0rtphe0HDVQKthv4MPnid++BGmAl8UP4Tvb9ZPX1e1zUS5qE?=
 =?us-ascii?Q?t/fOgoBt7qHIirh01ZbOJog8z8GJrK+bzqzutKfrX+IDuHbyMVKpkcemkCl/?=
 =?us-ascii?Q?2Icv4x/ozYH9AMFKxVoxQazVDEuVxCuvqXWNsGNeuceMdHZlhk1wfzsG5SuO?=
 =?us-ascii?Q?2JUUr9XtxmDFoI/Y/NsMT+m/d8vISIvFMjFvuosCGKB/4IVmwqN63ZosN+vp?=
 =?us-ascii?Q?Ric1q58DF5pgWb6+BK7uLzTEf/5GS9FrwKP6vCM+SwRklnPKI1mDcch6SS8E?=
 =?us-ascii?Q?xI/aeRLMTHcMpHnfqdTXkJsC03t8apFmzkUdLHbwhoEMizFehqJhwc3yAxCz?=
 =?us-ascii?Q?5ZsjmRr01ZEnrEg9mPA5nSqTx/DkgBgKxa6kqWUW52Hc49ZBJG7TmCOSGFuL?=
 =?us-ascii?Q?SU8egI5Ev00/96qbgxOTL+SqXZnvqr4EBegBgXM2jFlxqPlevgd6WakkYzKG?=
 =?us-ascii?Q?RWYwSW0QVOKJm6fuG/iSViTCG1J3JQu3Jo7dVYCAtgBUdKdHwTH2t9wsRHE8?=
 =?us-ascii?Q?1ZjcqGelIhl/I69nm2mlJ7AiFLdU?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:28.0336 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df917d00-e3a8-4626-1247-08dcdde770e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073
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
index ecebb44171..032e429d3f 100644
--- a/drivers/mtd/spi/spi-nor-core.c
+++ b/drivers/mtd/spi/spi-nor-core.c
@@ -928,12 +928,32 @@ static int clean_bar(struct spi_nor *nor)
 
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
@@ -943,15 +963,19 @@ static int write_bar(struct spi_nor *nor, u32 offset)
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
@@ -963,15 +987,30 @@ static int read_bar(struct spi_nor *nor, const struct flash_info *info)
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

