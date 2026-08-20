Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3650CC5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:26:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id F1F7580C6F;
	Thu, 20 Aug 2026 09:26:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SSolIFz4v_Zp; Thu, 20 Aug 2026 09:26:55 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218015;
	bh=7pyhhLP3LTdGj9imhEpy/Sy1pNsFeACBNX7ALbEhrAg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=yOvWUAo1+SxW4wcOTl7HaocJem0mnU9haHNyob43q+r5LHXK2Dl/nwvNTcxj5lCXf
	 pAByVRqyT/bt21xYOZnwE6A8X3W/xVk2AXP9Gs47mkLnVJJI4GU/qrV/BifoUgXaEh
	 KduTQL6zSuueWqSVJxmGwkzAYpvO9A97EkijWhTpntDkGFfAhC3c7eYBK9MVuXMzBh
	 b1tmELk66HDFrt/IZn7XD/egka6g+jctqKjnu+DIqCY4ORZBW2ETywz+fpDEkoN7S7
	 Q2Zlyy2yo4yWVdEn/UwO2NesPXWy8GD1Euuo3KTdkRCPlSYL/FoLRyHfxZEKF1xvTG
	 Enorvz5Taa8eg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2418A80C66;
	Thu, 20 Aug 2026 09:26:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id C01BB2FD
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A656960619
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i2UgVUjgpJ6b for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:26:53 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c112::7;
 helo=cy3pr05cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=h2EeEbwo
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D1A3960603
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGA2lsA5y9daG6GLpCf6fc2Ze/ZaATRca2iK74/a9Dy4VPEgndhGvSMk1gVbSFErubJIUoQAD74AspmDYRU+lo5XJDcsRZpHq/7qoKo4iwlEEyF5OnPFT0+sUaj4qUCec5DxTENRtr/8nHg90EjO6tT7UqeKFYrSrm/fQ7lyMcS5HmyGKs+fEqxWvm47UtdCflYLQq2QPNzdrEaRqM/zVvAlPA5Tqq3G6Ow2gFCPsBx9jVYKi+2EpB4OK8aKKVj/yyJXp0+BYae/0EWVv9GEds17y4sf+W55g9pOZmbKaayolADTgYscUqZx8vY6Xe5vhYGrqVKv06cI1NUXa5N5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7pyhhLP3LTdGj9imhEpy/Sy1pNsFeACBNX7ALbEhrAg=;
 b=Qxn0cWIYAp6dLPzbX12nA7y0Rj01doBOUpL7QwiBxVlOcqQ1DizNp7iEVFoMQdRv7RhJfD20xB1iP2kyrBXX3s1edzi0hmOEW/fQ1mDWYVlxDEAtbTfxIVdSmSCESBy0VO6XBAsXgr9qsRYSKtcTo/NcqyVMUBZCiBsRJp8A1P46HiNEs6H2mMDCj01jgrdE6OCPTseFV2/OhmYnZnbzIYKC5iPiOpJf5///Xh8ZDa/hgBPml/9qR9Ysg00NTcuq7YjLkkZp6UWK67rc2I1mpBPEQlFbwLzuOsAEbItezGj9yoVIQ3D5Tjsusr7TEImvst2br/qIwxIRsWZWJVeguA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7pyhhLP3LTdGj9imhEpy/Sy1pNsFeACBNX7ALbEhrAg=;
 b=h2EeEbwoVrE43XeTpdCUR1VAcTyPc6LJ7BY6RD4JiVzBO1dvIRCSfCZCDvh5+FkmjcuxEVUh/8B6KCBB3bCpSeE5UfM3MzL/TBddtoucIFZtIBV+k23D5wnq7OLEn4ZIuDxBideDfBtE6b+Kh61qvq+Dztk71ag4lkjtOu80Cvs=
Received: from BN9PR03CA0424.namprd03.prod.outlook.com (2603:10b6:408:113::9)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:26:48 +0000
Received: from BN2PEPF0000A800.namprd02.prod.outlook.com
 (2603:10b6:408:113:cafe::77) by BN9PR03CA0424.outlook.office365.com
 (2603:10b6:408:113::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 09:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A800.mail.protection.outlook.com (10.167.245.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:26:47 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:26:46 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:26:44 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 2/8] net: mrmac: use a driver-owned RX buffer pool
Date: Thu, 20 Aug 2026 14:55:48 +0530
Message-ID: <20260820092623.1647844-3-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A800:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: db6cc892-6b0a-4060-438c-08defe9d2880
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: MJIY3xElFPMBQf+sreN1JkORIDGWFKcaS12GodJHaAv93TX0qLg0LDcOSKcWxuj7oSwGouybVWH47LKdsU+tRVceHfoFyXu9c/62emzTGY9CHcl8DGanMitgZMrDVegGE7wB2bG+9f0jdxzMFSUgcrUIYHZlZBXy8A2n5K+udx2YqYxYSjzhyFCKBv20o1S756v6EtQYMdVnVccqlLc6MrCcUxJkbhv9DxfH3p/WwRN4BrXc6kVtjyz23LgQbK4E5uFgunlwu4S27Cv8wk1R0+/vW41qgT9thk4op9qCf2z3SBwwBwSQQt//5ZUbjn2xFgcBoPDahBZx8gSVqSD4MKTUqpwCiZoBj0ToCP29nIzmJs+J0rSOtdN2Ne4jpDut+5KYc3wzVgh0mR4+4arKy1kvY1KTswESnpNFIScwVB9JLvXax++vxZZosC3pSgR43UvjYTHoEl5ZqyChxS4i+0/14pxzda+hFfMYhqAC/C3T3Vcd/hShkBbio0GzFIIMy9gg4tcYgMOx5b3/jPB5a52yD5WGYLrc2jTSqciZE4Wdu65uNNxPHq2Zb6j0hrbG4MWu2MqEa7axRdrcywf+0ron3PxsLZSDmQf7XD6B+U2z8+Ckh4O07g6Cf5zZurivX+T1htIBq+Vye2kh8CyRIrwQ4PE+0nbRp9Ujm1e/s0uS2lwV7CkJB+Fmsy8lKd4EPTGg5ZKKB62DteO0ax/2Qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aWVfVz4MzK+QH+lb3TUZhbA2Qd1dEWVD7rH5vjt8TtyO5108lRi8MFUupksZS5JBXQF/zNyYjAUDdX5+hjwE4n2L6eIk0jh5jCWo3eNq1nhJsxmux8Zgq0yEq18CMgnu+SdEX7Un29reagaztX/KWDUQep/r35aXtyXParWP99F7Oco07m70v4NrsxI9flVOukMyX49B+b50PiNVgbDlXqdOrp57btLkGFAGnJU2Nh1JHfpxpM9kZ2mxLw0bR6GwUUP/eXA/au1cjdXx4e+XprM/XNdM3ZM1NJMlXwTml8l7n4JOy9lH96qp/ucM1/7uz61FRiNtiA+atZYhe5MlWrsaBoB3pjA9arzozSdqZ04WQFS0Bjl5LTNf9t5Sann6tNcuSmKu6lMY1J2cF0HU44ycKLkFXlpJZ/nXXbnjkSrkhmhtlVTz5UpEanJmU1Rm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:26:47.5590 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6cc892-6b0a-4060-438c-08defe9d2880
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A800.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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

The RX path borrows the shared net_rx_packets[] global for its buffer
descriptors. That global is capped at PKTBUFSRX system-wide and is not
private to this device, so it cannot scale to a deeper RX ring and does
not compose well with multiple different drivers sharing it.

Allocate a driver-owned RX buffer pool (rx_buf, sized
RX_DESC * PKTSIZE_ALIGN) in probe() and point the RX descriptors at
slices of it instead.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 24 +++++++++++++++++-------
 drivers/net/xilinx_axi_mrmac.h |  1 +
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index 5ff304fc971..d9d4756d14f 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -185,17 +185,17 @@ static int axi_mrmac_start(struct udevice *dev)
 	memset(priv->rx_bd[0], 0, RX_BD_TOTAL_SIZE);
 
 	priv->rx_bd[0]->next_desc = lower_32_bits((u64)priv->rx_bd[1]);
-	priv->rx_bd[0]->buf_addr = lower_32_bits((u64)net_rx_packets[0]);
+	priv->rx_bd[0]->buf_addr = lower_32_bits((u64)priv->rx_buf);
 
 	priv->rx_bd[1]->next_desc = lower_32_bits((u64)priv->rx_bd[0]);
-	priv->rx_bd[1]->buf_addr = lower_32_bits((u64)net_rx_packets[1]);
+	priv->rx_bd[1]->buf_addr = lower_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
 
 	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
 		priv->rx_bd[0]->next_desc_msb = upper_32_bits((u64)priv->rx_bd[1]);
-		priv->rx_bd[0]->buf_addr_msb = upper_32_bits((u64)net_rx_packets[0]);
+		priv->rx_bd[0]->buf_addr_msb = upper_32_bits((u64)priv->rx_buf);
 
 		priv->rx_bd[1]->next_desc_msb = upper_32_bits((u64)priv->rx_bd[0]);
-		priv->rx_bd[1]->buf_addr_msb = upper_32_bits((u64)net_rx_packets[1]);
+		priv->rx_bd[1]->buf_addr_msb = upper_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
 	}
 
 	priv->rx_bd[0]->cntrl = PKTSIZE_ALIGN;
@@ -207,7 +207,7 @@ static int axi_mrmac_start(struct udevice *dev)
 	/* It is necessary to flush rx buffers because if you don't do it
 	 * then cache can contain uninitialized data
 	 */
-	flush_cache((phys_addr_t)priv->rx_bd[0]->buf_addr, RX_BUFF_TOTAL_SIZE);
+	flush_cache((phys_addr_t)priv->rx_buf, RX_BUFF_TOTAL_SIZE);
 
 	/* Start the hardware */
 	setbits_le32(&priv->s2mm_cmn->control, XMCDMA_CR_RUNSTOP_MASK);
@@ -413,7 +413,7 @@ static int axi_mrmac_free_pkt(struct udevice *dev, uchar *packet, int length)
 
 #ifdef DEBUG
 	/* It is useful to clear buffer to be sure that it is consistent */
-	memset(priv->rx_bd[0]->buf_addr, 0, RX_BUFF_TOTAL_SIZE);
+	memset(priv->rx_buf, 0, RX_BUFF_TOTAL_SIZE);
 #endif
 	/* Disable all Rx interrupts before RxBD space setup */
 	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_IRQ_ALL_MASK);
@@ -430,7 +430,7 @@ static int axi_mrmac_free_pkt(struct udevice *dev, uchar *packet, int length)
 	/* It is necessary to flush rx buffers because if you don't do it
 	 * then cache will contain previous packet
 	 */
-	flush_cache((phys_addr_t)priv->rx_bd[0]->buf_addr, RX_BUFF_TOTAL_SIZE);
+	flush_cache((phys_addr_t)priv->rx_buf, RX_BUFF_TOTAL_SIZE);
 
 	/* Enable all IRQ */
 	setbits_le32(&priv->mcdma_rx->control, XMCDMA_IRQ_ALL_MASK);
@@ -495,6 +495,15 @@ static int axi_mrmac_probe(struct udevice *dev)
 	priv->rx_bd[1] = (struct mcdma_bd *)((ulong)priv->rx_bd[0] +
 					     sizeof(struct mcdma_bd));
 
+	/*
+	 * Use a driver-owned RX buffer pool rather than the shared
+	 * net_rx_packets[] global, which is capped at PKTBUFSRX system-wide
+	 * and not private to this device.
+	 */
+	priv->rx_buf = memalign(ARCH_DMA_MINALIGN, RX_BUFF_TOTAL_SIZE);
+	if (!priv->rx_buf)
+		return -ENOMEM;
+
 	priv->txminframe = memalign(ARCH_DMA_MINALIGN, MIN_PKT_SIZE);
 	if (!priv->txminframe)
 		return -ENOMEM;
@@ -509,6 +518,7 @@ static int axi_mrmac_remove(struct udevice *dev)
 	/* Free buffer descriptors */
 	free(priv->tx_bd[0]);
 	free(priv->rx_bd[0]);
+	free(priv->rx_buf);
 	free(priv->txminframe);
 
 	return 0;
diff --git a/drivers/net/xilinx_axi_mrmac.h b/drivers/net/xilinx_axi_mrmac.h
index e2c2105450c..17849d39873 100644
--- a/drivers/net/xilinx_axi_mrmac.h
+++ b/drivers/net/xilinx_axi_mrmac.h
@@ -37,6 +37,7 @@ struct axi_mrmac_priv {
 	struct mcdma_bd *tx_bd[TX_DESC];
 	struct mcdma_bd *rx_bd[RX_DESC];
 	u8 *txminframe;		/* Pointer to hold min length Tx frame(60) */
+	u8 *rx_buf;		/* Driver-owned RX buffer pool (RX_DESC * PKTSIZE_ALIGN) */
 	u32 mrmac_rate;		/* Speed to configure(Read from DT 10G/25G..) */
 };
 
-- 
2.34.1

