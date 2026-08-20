Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F262FC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:27:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BCD62405B7;
	Thu, 20 Aug 2026 09:27:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UuBgsoZ1fa5J; Thu, 20 Aug 2026 09:27:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218026;
	bh=0Tx+HcrqkkBBN5uIAL5tof+442LdhA2+we5hOWWi5Ds=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yFEbfyaYzl0sgsXDuTfF0YSZMSSUwJijYcI6TDXO7Hoci/CqAo0TFRukLSzm7hwt4
	 n4mrFd8Xt9G3mDG+U9Le2Zy5tleJnPtUjVJUC9yeDQ5ahynlyZuPblXreCsZMPYisR
	 I653CT+uOKBJApCENPNAXMSeCsPFtfyBeSSjhSjJpAaCHc0Okj/SoTyrGWnErx0vtg
	 aRc+K/n1/fjVHBy/tUBa3Yk23tFijvF3f21IZbKnWafOLCgBlQ2sSohPIYvGM9vruO
	 xmFX3V5gE7SHETVH4O0jNybhKsSF+DwjSiIOZ5WhguUzHicIHVmYp4NTh7AC/SQmos
	 u0Bo8RPuoG8Fg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8E34F405A7;
	Thu, 20 Aug 2026 09:27:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1D316263
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F19980C49
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:05 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yZCVZYtPTiP1 for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:27:04 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c005::5;
 helo=co1pr03cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=DRqSmbaB
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 by smtp1.osuosl.org (Postfix) with ESMTPS id CFCED80C98
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA40iU0KrsHGLz/inTJ/0lcBXJvAXJ0RDZkgyqEVOGJoBICtqqxB8N8vFKgvNGGfwnmXNAapZDg4ZAFpoLsoobtdg1XJwcXIdnXyMitq5N5Asg523O/yJjIq4VJG7oaXAv6qyGg15K/bmabGkTp7xMfnoHYB6dSLJKUFRvFC7H/ivC/e3ZnjhI0TruhV/toSwBo7vsQRKMiO/fYmi9JpFLKw+wWtbWcosFibT8nrDZyX8I676wigZ9yiS2nlBOtxEzHg2q+5Q3BlOlB0bijcnECd6kLZ+d0mhfHmDD+Oeoy+yGej1kw8Cb75t1tFGSEo7z5EVMTEd7LMNzUwkkrejA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Tx+HcrqkkBBN5uIAL5tof+442LdhA2+we5hOWWi5Ds=;
 b=FP8gXu938UKULxxARYVv6IexisgQ/YUU9yyzbiY78Xd8cuGG0i7xC0oxsjqRXmF8nFJ3F9m0lqolrLi5lLYZ0KxH7MkYOn22TJyDOeOz6pmSj1UYBROOZUl+M7ykltwSk3fk9NyQpeKbACPWRav6pVmFDhthuvHNwA2Je5Wov5sIMY+eg7qM2X4xqmDjgRS6xD9DOmn6klhUpC5FhnPh6dp+OBEOKOwVT5DH03y7m0aQAGWCUs56zo6PjRLoYBAUa5hjBTt4DaXbwGjL2MtTqtd5vAz4SJJnN6u2p/v0DsZXGyxByO+L2l7GxnhEynUng5apoyEFdf6YRPgbAwD7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Tx+HcrqkkBBN5uIAL5tof+442LdhA2+we5hOWWi5Ds=;
 b=DRqSmbaBEPLAti3RhaP6+PhJoV2xPremwuCR9+Uc+uBsp9EVGAq2PdcbptB5/1F6il+K3CeDJyIPw8pC5/jO/+kKOIT4HOxl2Ju/lqhwr5uBbBzGKrLhONiXP56/Gf5cWEcSNA8vzO2a82tX2jEcTvuau7xc7PVs97pwUYEHr8I=
Received: from SJ0PR13CA0209.namprd13.prod.outlook.com (2603:10b6:a03:2c3::34)
 by SA1PR12MB6995.namprd12.prod.outlook.com (2603:10b6:806:24e::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.13; Thu, 20 Aug
 2026 09:26:58 +0000
Received: from MWH0EPF000C6188.namprd02.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::a5) by SJ0PR13CA0209.outlook.office365.com
 (2603:10b6:a03:2c3::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.3 via Frontend Transport; Thu, 20
 Aug 2026 09:26:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000C6188.mail.protection.outlook.com (10.167.249.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:26:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:26:56 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:26:55 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:26:54 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 4/8] net: mrmac: use contiguous BD arrays
Date: Thu, 20 Aug 2026 14:55:50 +0530
Message-ID: <20260820092623.1647844-5-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C6188:EE_|SA1PR12MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ceb9900-362d-4eb3-ad9f-08defe9d2e53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: UaeVaBA3zP6vmSvft3eXDMTtcDZ+4qqW9xkKgMMZaeDOQfb5LDfk308hE3qHp/D3E9G6e4HKEimBKyPIhoxyiy4B/mFBK9hhhNbC8hDGkC45AogglRxGz8fR8HnKfbRpqqydJGGqjUHRLaaDivKOx0leM1Ycj6sTLbS/uY2RJp70lbljUeGFgLY0RoEfGP83tl9wW2eiE/HD2gLtLfCwTw0FCbO93uy98Xr0ByYEqN8NUaG4ozpMxyiUbWHmNepNYwyKgmiw36djtgTjjGsfCB2Vr2fQpD6yQgDXhaVCbmKAxHGcvTfwOXaJsLV6ggs8YmsUX8Zu6C2yWQg6yOK6PDiYIcNrKJkghirUEvqm1ESQkTuFJf56bMFWKNm+u1t/ukxe5oeIi6GKUaL1mRTj1Tmw7cjYd+PjDFQEJlmB/0izZMIEcoVuDdkZfQ58BX5H9cqjv2LHhnA6+XPmjOqhhBPcsxz1TxN8J+accPeGdZBDhWNqDJqXr5DfLcLs64DAw3m7R3RzVk8VEQpJJKje4hCNdrPALKM7x1b0trHQt7QEJK5MuqjGNCVf0unXDWjWBoET4ipHfJqG092B+1uEqEgheVggF9zjIOqd8Xej8AI2goXvTHi3pBVaFhM0bH7+gBphpTFPRJgWaG189SeE2WHUhL5JPlR7GYdjcKIMKPN3Dv270Vxg0vZCAKSad007YUJUzfajkcAaHZCUMJn2YA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rfKJM967R0SIi05GnDsU+NHEAVdf/4do97AvYjRlg+p4M98xohfFJQ+LfzzVrUTkgW2C4J+n22qK0qlbd/TLGh0D/k7Of1Lv1qOFlPg/0IimNuJn64x3Hnt2IZp2d4BttCHgHfal5tCzFeL8+7nNTnCQdhifqX/PnVJ0gyWwz8XDO0U69eZN1bt6X5hytdt+E+5Bs08MbiCBsAsLg1myCUniwXPbKRO/LAgyFfCY6AuFMAVhgNSjMMlJSX6TgK/NmNEz0MRLsPLHammIzsXwf++w/HiaOTV3EGFrgv+kwyqzFMieossVZ3ZqZTYYQzTrlZNI8s91U/rNJq77W7SJCoS0R2ZfeMq5usBYMHtXeL0o/zkpPQ8FnxlWjP2wrCkvmA6mfq44Am9gTyI8jDkA7y2Tt7aJiMtiUaNS2829YYDi8E/8F7pXuCZf23+su0Ab
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:26:57.2441 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ceb9900-362d-4eb3-ad9f-08defe9d2e53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C6188.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6995
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

The Tx and Rx buffer descriptors are each allocated as one contiguous
block by a single memalign() call, but they are tracked as an array of
pointers into that block, with every pointer past the first derived by
hand:

	priv->tx_bd[1] = (struct mcdma_bd *)((ulong)priv->tx_bd[0] +
					     sizeof(struct mcdma_bd));

That per-descriptor pointer arithmetic has to be repeated for every
descriptor added, so it does not scale beyond the current two.

Keep only the base pointer of each ring and index it directly.
priv->tx_bd[0] and priv->tx_bd[1] then address the first and second
descriptor of the contiguous block, and the hand-written pointer setup
in probe() disappears.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 100 ++++++++++++++++-----------------
 drivers/net/xilinx_axi_mrmac.h |   4 +-
 2 files changed, 50 insertions(+), 54 deletions(-)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index 8778ab1aaa9..d77b0e3445b 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -179,30 +179,30 @@ static int axi_mrmac_start(struct udevice *dev)
 	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_IRQ_ALL_MASK);
 
 	/* Update current descriptor */
-	axi_mrmac_dma_write(priv->rx_bd[0], &priv->mcdma_rx->current);
+	axi_mrmac_dma_write(&priv->rx_bd[0], &priv->mcdma_rx->current);
 
 	/* Setup Rx BD. MRMAC needs atleast two descriptors */
-	memset(priv->rx_bd[0], 0, RX_BD_TOTAL_SIZE);
+	memset(priv->rx_bd, 0, RX_BD_TOTAL_SIZE);
 
-	priv->rx_bd[0]->next_desc = lower_32_bits((u64)priv->rx_bd[1]);
-	priv->rx_bd[0]->buf_addr = lower_32_bits((u64)priv->rx_buf);
+	priv->rx_bd[0].next_desc = lower_32_bits((u64)&priv->rx_bd[1]);
+	priv->rx_bd[0].buf_addr = lower_32_bits((u64)priv->rx_buf);
 
-	priv->rx_bd[1]->next_desc = lower_32_bits((u64)priv->rx_bd[0]);
-	priv->rx_bd[1]->buf_addr = lower_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
+	priv->rx_bd[1].next_desc = lower_32_bits((u64)&priv->rx_bd[0]);
+	priv->rx_bd[1].buf_addr = lower_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
 
 	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
-		priv->rx_bd[0]->next_desc_msb = upper_32_bits((u64)priv->rx_bd[1]);
-		priv->rx_bd[0]->buf_addr_msb = upper_32_bits((u64)priv->rx_buf);
+		priv->rx_bd[0].next_desc_msb = upper_32_bits((u64)&priv->rx_bd[1]);
+		priv->rx_bd[0].buf_addr_msb = upper_32_bits((u64)priv->rx_buf);
 
-		priv->rx_bd[1]->next_desc_msb = upper_32_bits((u64)priv->rx_bd[0]);
-		priv->rx_bd[1]->buf_addr_msb = upper_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
+		priv->rx_bd[1].next_desc_msb = upper_32_bits((u64)&priv->rx_bd[0]);
+		priv->rx_bd[1].buf_addr_msb = upper_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
 	}
 
-	priv->rx_bd[0]->cntrl = PKTSIZE_ALIGN;
-	priv->rx_bd[1]->cntrl = PKTSIZE_ALIGN;
+	priv->rx_bd[0].cntrl = PKTSIZE_ALIGN;
+	priv->rx_bd[1].cntrl = PKTSIZE_ALIGN;
 
 	/* Flush the last BD so DMA core could see the updates */
-	flush_cache((phys_addr_t)priv->rx_bd[0], RX_BD_TOTAL_SIZE);
+	flush_cache((phys_addr_t)priv->rx_bd, RX_BD_TOTAL_SIZE);
 
 	/* It is necessary to flush rx buffers because if you don't do it
 	 * then cache can contain uninitialized data
@@ -218,7 +218,7 @@ static int axi_mrmac_start(struct udevice *dev)
 	setbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
 
 	/* Update tail descriptor. Now it's ready to receive data */
-	axi_mrmac_dma_write(priv->rx_bd[1], &priv->mcdma_rx->tail);
+	axi_mrmac_dma_write(&priv->rx_bd[1], &priv->mcdma_rx->tail);
 
 	/* Enable Tx */
 	setbits_le32(&regs->tx_config, MRMAC_TX_EN_MASK);
@@ -267,32 +267,32 @@ static int axi_mrmac_send(struct udevice *dev, void *ptr, int len)
 	flush_cache((phys_addr_t)ptr, len);
 
 	/* Setup Tx BD. MRMAC needs atleast two descriptors */
-	memset(priv->tx_bd[0], 0, TX_BD_TOTAL_SIZE);
+	memset(priv->tx_bd, 0, TX_BD_TOTAL_SIZE);
 
-	priv->tx_bd[0]->next_desc = lower_32_bits((u64)priv->tx_bd[1]);
-	priv->tx_bd[0]->buf_addr = lower_32_bits((u64)ptr);
+	priv->tx_bd[0].next_desc = lower_32_bits((u64)&priv->tx_bd[1]);
+	priv->tx_bd[0].buf_addr = lower_32_bits((u64)ptr);
 
 	/* At the end of the ring, link the last BD back to the top */
-	priv->tx_bd[1]->next_desc = lower_32_bits((u64)priv->tx_bd[0]);
-	priv->tx_bd[1]->buf_addr = lower_32_bits((u64)ptr + len / 2);
+	priv->tx_bd[1].next_desc = lower_32_bits((u64)&priv->tx_bd[0]);
+	priv->tx_bd[1].buf_addr = lower_32_bits((u64)ptr + len / 2);
 
 	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
-		priv->tx_bd[0]->next_desc_msb = upper_32_bits((u64)priv->tx_bd[1]);
-		priv->tx_bd[0]->buf_addr_msb = upper_32_bits((u64)ptr);
+		priv->tx_bd[0].next_desc_msb = upper_32_bits((u64)&priv->tx_bd[1]);
+		priv->tx_bd[0].buf_addr_msb = upper_32_bits((u64)ptr);
 
-		priv->tx_bd[1]->next_desc_msb = upper_32_bits((u64)priv->tx_bd[0]);
-		priv->tx_bd[1]->buf_addr_msb = upper_32_bits((u64)ptr + len / 2);
+		priv->tx_bd[1].next_desc_msb = upper_32_bits((u64)&priv->tx_bd[0]);
+		priv->tx_bd[1].buf_addr_msb = upper_32_bits((u64)ptr + len / 2);
 	}
 
 	/* Split Tx data in to half and send in two descriptors */
-	priv->tx_bd[0]->cntrl = (len / 2) | XMCDMA_BD_CTRL_TXSOF_MASK;
-	priv->tx_bd[1]->cntrl = (len - len / 2) | XMCDMA_BD_CTRL_TXEOF_MASK;
+	priv->tx_bd[0].cntrl = (len / 2) | XMCDMA_BD_CTRL_TXSOF_MASK;
+	priv->tx_bd[1].cntrl = (len - len / 2) | XMCDMA_BD_CTRL_TXEOF_MASK;
 
 	/* Flush the last BD so DMA core could see the updates */
-	flush_cache((phys_addr_t)priv->tx_bd[0], TX_BD_TOTAL_SIZE);
+	flush_cache((phys_addr_t)priv->tx_bd, TX_BD_TOTAL_SIZE);
 
 	if (readl(&priv->mcdma_tx->status) & XMCDMA_CH_IDLE) {
-		axi_mrmac_dma_write(priv->tx_bd[0], &priv->mcdma_tx->current);
+		axi_mrmac_dma_write(&priv->tx_bd[0], &priv->mcdma_tx->current);
 		/* Channel fetch */
 		setbits_le32(&priv->mcdma_tx->control, XMCDMA_CR_RUNSTOP_MASK);
 	} else {
@@ -303,7 +303,7 @@ static int axi_mrmac_send(struct udevice *dev, void *ptr, int len)
 	setbits_le32(&priv->mcdma_tx->control, XMCDMA_IRQ_ALL_MASK);
 
 	/* Start transfer */
-	axi_mrmac_dma_write(priv->tx_bd[1], &priv->mcdma_tx->tail);
+	axi_mrmac_dma_write(&priv->tx_bd[1], &priv->mcdma_tx->tail);
 
 	/* Wait for transmission to complete */
 	ret = wait_for_bit_le32(&priv->mcdma_tx->status, XMCDMA_IRQ_IOC_MASK,
@@ -314,8 +314,8 @@ static int axi_mrmac_send(struct udevice *dev, void *ptr, int len)
 	}
 
 	/* Clear status */
-	priv->tx_bd[0]->sband_stats = 0;
-	priv->tx_bd[1]->sband_stats = 0;
+	priv->tx_bd[0].sband_stats = 0;
+	priv->tx_bd[1].sband_stats = 0;
 
 	log_debug("Sending complete\n");
 
@@ -372,25 +372,25 @@ static int axi_mrmac_recv(struct udevice *dev, int flags, uchar **packetp)
 	/* Disable channel fetch */
 	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
 
-	rx_bd_end = (ulong)priv->rx_bd[0] + roundup(RX_BD_TOTAL_SIZE,
-						    ARCH_DMA_MINALIGN);
+	rx_bd_end = (ulong)priv->rx_bd + roundup(RX_BD_TOTAL_SIZE,
+						 ARCH_DMA_MINALIGN);
 	/* Invalidate Rx descriptors to see proper Rx length */
-	invalidate_dcache_range((phys_addr_t)priv->rx_bd[0], rx_bd_end);
+	invalidate_dcache_range((phys_addr_t)priv->rx_bd, rx_bd_end);
 
-	length = priv->rx_bd[0]->status & XMCDMA_BD_STS_ACTUAL_LEN_MASK;
-	*packetp = (uchar *)(ulong)priv->rx_bd[0]->buf_addr;
+	length = priv->rx_bd[0].status & XMCDMA_BD_STS_ACTUAL_LEN_MASK;
+	*packetp = (uchar *)(ulong)priv->rx_bd[0].buf_addr;
 
 	if (!length) {
-		length = priv->rx_bd[1]->status & XMCDMA_BD_STS_ACTUAL_LEN_MASK;
-		*packetp = (uchar *)(ulong)priv->rx_bd[1]->buf_addr;
+		length = priv->rx_bd[1].status & XMCDMA_BD_STS_ACTUAL_LEN_MASK;
+		*packetp = (uchar *)(ulong)priv->rx_bd[1].buf_addr;
 	}
 
 #ifdef DEBUG
 	print_buffer(*packetp, *packetp, 1, length, 16);
 #endif
 	/* Clear status */
-	priv->rx_bd[0]->status = 0;
-	priv->rx_bd[1]->status = 0;
+	priv->rx_bd[0].status = 0;
+	priv->rx_bd[1].status = 0;
 
 	return length;
 }
@@ -422,10 +422,10 @@ static int axi_mrmac_free_pkt(struct udevice *dev, uchar *packet, int length)
 	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
 
 	/* Update current descriptor */
-	axi_mrmac_dma_write(priv->rx_bd[0], &priv->mcdma_rx->current);
+	axi_mrmac_dma_write(&priv->rx_bd[0], &priv->mcdma_rx->current);
 
 	/* Write bd to HW */
-	flush_cache((phys_addr_t)priv->rx_bd[0], RX_BD_TOTAL_SIZE);
+	flush_cache((phys_addr_t)priv->rx_bd, RX_BD_TOTAL_SIZE);
 
 	/* It is necessary to flush rx buffers because if you don't do it
 	 * then cache will contain previous packet
@@ -439,7 +439,7 @@ static int axi_mrmac_free_pkt(struct udevice *dev, uchar *packet, int length)
 	setbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
 
 	/* Update tail descriptor. Now it's ready to receive data */
-	axi_mrmac_dma_write(priv->rx_bd[1], &priv->mcdma_rx->tail);
+	axi_mrmac_dma_write(&priv->rx_bd[1], &priv->mcdma_rx->tail);
 
 	log_debug("Rx completed, framelength = %x\n", length);
 
@@ -483,17 +483,13 @@ static int axi_mrmac_probe(struct udevice *dev)
 	priv->mrmac_rate = plat->mrmac_rate;
 
 	/* Align buffers to ARCH_DMA_MINALIGN */
-	priv->tx_bd[0] = memalign(ARCH_DMA_MINALIGN, TX_BD_TOTAL_SIZE);
-	if (!priv->tx_bd[0])
+	priv->tx_bd = memalign(ARCH_DMA_MINALIGN, TX_BD_TOTAL_SIZE);
+	if (!priv->tx_bd)
 		return -ENOMEM;
-	priv->tx_bd[1] = (struct mcdma_bd *)((ulong)priv->tx_bd[0] +
-					     sizeof(struct mcdma_bd));
 
-	priv->rx_bd[0] = memalign(ARCH_DMA_MINALIGN, RX_BD_TOTAL_SIZE);
-	if (!priv->rx_bd[0])
+	priv->rx_bd = memalign(ARCH_DMA_MINALIGN, RX_BD_TOTAL_SIZE);
+	if (!priv->rx_bd)
 		return -ENOMEM;
-	priv->rx_bd[1] = (struct mcdma_bd *)((ulong)priv->rx_bd[0] +
-					     sizeof(struct mcdma_bd));
 
 	/*
 	 * Use a driver-owned RX buffer pool rather than the shared
@@ -516,8 +512,8 @@ static int axi_mrmac_remove(struct udevice *dev)
 	struct axi_mrmac_priv *priv = dev_get_priv(dev);
 
 	/* Free buffer descriptors */
-	free(priv->tx_bd[0]);
-	free(priv->rx_bd[0]);
+	free(priv->tx_bd);
+	free(priv->rx_bd);
 	free(priv->rx_buf);
 	free(priv->txminframe);
 
diff --git a/drivers/net/xilinx_axi_mrmac.h b/drivers/net/xilinx_axi_mrmac.h
index 17849d39873..baf936f6b66 100644
--- a/drivers/net/xilinx_axi_mrmac.h
+++ b/drivers/net/xilinx_axi_mrmac.h
@@ -34,8 +34,8 @@ struct axi_mrmac_priv {
 	struct mcdma_common_regs *s2mm_cmn;
 	struct mcdma_chan_reg *mcdma_tx;
 	struct mcdma_chan_reg *mcdma_rx;
-	struct mcdma_bd *tx_bd[TX_DESC];
-	struct mcdma_bd *rx_bd[RX_DESC];
+	struct mcdma_bd *tx_bd;	/* Base of the contiguous Tx BD ring */
+	struct mcdma_bd *rx_bd;	/* Base of the contiguous Rx BD ring */
 	u8 *txminframe;		/* Pointer to hold min length Tx frame(60) */
 	u8 *rx_buf;		/* Driver-owned RX buffer pool (RX_DESC * PKTSIZE_ALIGN) */
 	u32 mrmac_rate;		/* Speed to configure(Read from DT 10G/25G..) */
-- 
2.34.1

