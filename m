Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AABCFC5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:27:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 73D9E4058B;
	Thu, 20 Aug 2026 09:27:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HnkpVuMbZ6rn; Thu, 20 Aug 2026 09:27:41 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218061;
	bh=rfIcfZbqfDAGhixVzsEYioEgQP6QEydcJ6shSggGz9M=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JDU2CKaimL2HBiVyT3f6KMiqVBaF1zqBRobMobfj7hX0MIp24n3hde8KcbrBzIIqj
	 OPp4GwOCFCW+uMol4qOsqAvVQh+gI0TPnL+9hT88RAv/V7NmVJdmWx23+qZ1l7kiQU
	 5mp9HqeupRp+41RxZ+JCGMlF4Vc/+iao26Rd52DyarYfwEhmigaprGfXZssxO04ycU
	 f8P6uHDLWijU3msPdUuAGgZ+dawV+3F6AArwxqtM4lrwYjbGgRcspxOYAahHzr3IIK
	 TlUkJTxqd4IX0xFG8tpGsm/lZ8oqsxfT8vU35eWVfFgLl7K73M5At2Z/9/4q2QUckL
	 pV8zrddFohAJQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 42F294058E;
	Thu, 20 Aug 2026 09:27:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id ABC931460
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9D3D680C33
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:40 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iVm1dlXSssmU for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:27:39 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c107::3;
 helo=ph0pr06cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=EvdQDoCS
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 91BC180C36
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D6m/Dkpi1x+m3pOgvR7vzG/yeAO+s6QKSOYR1y/rRAyHWRq0Rea57iZxqHQroslAkEqt7pgbQnN8HZ+o8VS8hXpc9PemiECZLluiAcmh7vCAKLo3XAeYkjEnyFqLccMn515paoKEmTTEqEXiwghV55ltvLC1uM92lX3dCnaDaeIz3qpYpOyjq+/wn2xJG2+7/o7xalr58SaOiIR8Q2YhG9FIocG6QWG7BUvnt8Yt/ug/ukBka6OX4VEZh+3/8y3O18tlV7O8oy3+nCSpw3fvyBlIQtEyXGwCf7Zxg0cg6Xj6EMdycoMPBhNjyaFQowOqGchyIxGZE9ofpM3BNYQM5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rfIcfZbqfDAGhixVzsEYioEgQP6QEydcJ6shSggGz9M=;
 b=r8E4iHTIpXpcYYna5v+brYmK7CNPQFxEDPACupG0pjxk3kSq34gjIQLsIJpuY9oz6Cw9/a+QCSfThlbtHZ+w5LWkJSp3GTl0rEnC+Yyh+GTYag/HfEaAoP3OsMEvDD4BJQuyntdHleZwo4zY8NQz80Qn2qYaTdEm95NjNNVsN5nqRN0RNMkYhaFLGcLS4L9W3TUAaOVIk7qB3lWT7Hzsky9hZ/KUHKfdL4FzOQEKjFNeZPDf9p5ebIj9bRNAtKSoYJdklcKHmUmOpCPQSNXY1PDCbDOVt5hiIgH4vCdh6BFk8Pk2vVPNUeRdCFX5eTkf+E62dLIPQXm36Q8EKRlGWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rfIcfZbqfDAGhixVzsEYioEgQP6QEydcJ6shSggGz9M=;
 b=EvdQDoCS0lyVfuti6jUTLlfDlQTXMsRjIdsE7oIbnYh+ieKqr95qMm9c9wIqxT3ttmnsQ97I9LJp5OAD9UZjoHyMT9LVYt6w2YD2MK6DZ7jAsgGeotIXx525x0RkzS32c6s+ti8hMs4kcF+gwRAN6Xdfk4Nr+gTTeFIyh579cwA=
Received: from BN0PR04CA0121.namprd04.prod.outlook.com (2603:10b6:408:ed::6)
 by DM6PR12MB4419.namprd12.prod.outlook.com (2603:10b6:5:2aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:27:33 +0000
Received: from BN2PEPF0000A804.namprd02.prod.outlook.com
 (2603:10b6:408:ed:cafe::8b) by BN0PR04CA0121.outlook.office365.com
 (2603:10b6:408:ed::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.9 via Frontend Transport; Thu, 20
 Aug 2026 09:27:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A804.mail.protection.outlook.com (10.167.245.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:27:32 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:27:31 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:27:28 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 7/8] net: mrmac: fix Rx packet loss on back-to-back frames
Date: Thu, 20 Aug 2026 14:55:53 +0530
Message-ID: <20260820092623.1647844-8-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A804:EE_|DM6PR12MB4419:EE_
X-MS-Office365-Filtering-Correlation-Id: ee9fa48c-b1d5-4664-222b-08defe9d4303
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: VR9CnKd/xLEOhu9l4JdbN+z+CWRNxLJjJ5tk3e3dWC6sS3LZ5chPeUnU5JWXdeL0LXoTRFzA1AtnhWxl3OzBEBuggnwylBot0TlfLibUUZdC6NNhKugVQi/uzHKqK1OOZ0ASSskvl570JWHAbsExVz2vw2IvalSRayXnxrsPjijuc3rGwAeI/Pju63la+hbcpaYgDUSMvRy5zB3n4nLcYzMEu3UlELRGDlb+nk05BvvLeJKpRdp5L7gSXdwuxEizSGI7GM7eV4mGoOUN+s5UQqCa280FdVKug7PmIH0Po04PlXO0RZ6bDBaDrEa+XZtLiKp4tf5sokXyNx9ko9pAG2mk9l2k9DQQa+HvEuO7quLiDrK9dIOLwFTRCxwHtcaiPoUkogda36adPgbaMgyEcSQjOyNqFBySQXYiQLy/WkGKWoH/yUFhmW9P14IbkIXwV10Bi/Ucnva+BQYVZtovjXW9nxAHoZvk1VSNiI0liGZzE8pmG2Iq2j5sfY4K6H/GItmfz3eMwQgkmHM3IhS7IyndryiTni87UK+iRXkPSlU8tR1v1FZapLD75aoHOoK01t2IQcvTKw2mrfn6gEC8IFZjY15Cybx1qEeRCgM2O2nMUYGXBomsfhSExts8AYlEVx9dbDHCNtRWjFphwSqR6YtW0bZ+4I3T87U78fBFDOu8AF8KWa/mpDqs0A2KadKOUWEazGJ3vSBA0IAg/CP7zA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LmudRHZw8GMcRh3cEg3bDubuSowO0+itsq4MMwOBADfi96velUkguLBp3tlNQwHvmZNiJPFbUEjvVEOlZfIVNebcr2NZtJhw9Mga7xY8PS1KsCSy/Vu3jn7kwkkmut1evAgN3QgQ9o1glJJfQm/iNtKVnZTdlLvQNDBThhBgwTQHaM/FaXizwzINeYwvq4OmZGrsD468HgQA5NIkDxVH03NMoWy0ORl0KHbsa8GY2SzZ9tXi1B0cU5B8inn/vjHVQZRzpqVz3u5VsweSQBUHIXW3PG90ta5DjnSlL7gYJ4W8noe7bdQQCBoZlbSCzcJXlLlQ4m0i4HRyfv93eTWo4Vw5AZmDh8bCotND2JugrAQ3XhGpitXManr2TqwjUMnJnmq+D9WCImHON7kMxHNukiMmr7wzlsDtgWAyMGx66l4x792HoUrM4r18ihflP9fw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:27:32.0380 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee9fa48c-b1d5-4664-222b-08defe9d4303
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A804.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4419
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

The Rx path keeps no record of which descriptor holds the packet handed
to the network stack. recv() always starts at rx_bd[0], falls back to
rx_bd[1] only when rx_bd[0] carries no length, and then clears the
status of both descriptors:

	priv->rx_bd[0].status = 0;
	priv->rx_bd[1].status = 0;

The status field is the only record that a frame arrived, since it
holds both the COMPLETE bit and the length. free_pkt() then re-arms the
whole ring and lets hardware reuse every buffer.

So when two frames arrive back to back, recv() returns the one in
rx_bd[0] and wipes the status of rx_bd[1] in the same call. The second
frame still sits in memory, but nothing is left to show it is there.
free_pkt() hands its buffer back to hardware and it never reaches the
network stack. Nothing reports an error.

This shows up with multiple boards on a switch. The switch sends extra
traffic to the board, so packets often arrive back to back and one of
them is dropped. Network transfers then time out.

Completion also comes from the channel interrupt status register, which
only reports that a packet arrived on the channel, not which descriptor
holds it. That signal cannot drive a ring of more than one descriptor.

Track the descriptor to consume next in rx_bd_idx and touch only that
one:

 - recv() reads rx_bd[rx_bd_idx] and takes completion from the
   per-descriptor COMPLETE bit, so the descriptor is unambiguous. It
   leaves the status alone, keeping the descriptor owned by the driver
   while the network stack reads the buffer.

 - free_pkt() clears the status, restores the buffer length, flushes
   the descriptor and extends the tail pointer to it, then steps
   rx_bd_idx. Only the descriptor whose packet the stack has finished
   with goes back to hardware.

Clearing the status after delivery rather than before it means an
unread frame in the next descriptor keeps both its data and its
COMPLETE bit, and the following recv() returns it.

isrxready() loses its only caller once completion comes from the
descriptor, so drop it.

A completed descriptor with no length, or one flagged with an error,
holds no frame for the network stack. Report an empty packet for it, so
that the caller recycles the descriptor through axi_mrmac_free_pkt().

Fixes: 258ce79cfce4 ("net: xilinx: axi_mrmac: Add MRMAC driver")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 124 +++++++++++++++------------------
 drivers/net/xilinx_axi_mrmac.h |   1 +
 2 files changed, 57 insertions(+), 68 deletions(-)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index 45112a42758..e1531a4b548 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -202,6 +202,8 @@ static int axi_mrmac_start(struct udevice *dev)
 		bd->cntrl = PKTSIZE_ALIGN;
 	}
 
+	priv->rx_bd_idx = 0;
+
 	/* Flush the BDs so DMA core could see the updates */
 	flush_cache((phys_addr_t)priv->rx_bd, RX_BD_TOTAL_SIZE);
 
@@ -326,26 +328,6 @@ static int axi_mrmac_send(struct udevice *dev, void *ptr, int len)
 	return 0;
 }
 
-static bool isrxready(struct axi_mrmac_priv *priv)
-{
-	u32 status;
-
-	/* Read pending interrupts */
-	status = readl(&priv->mcdma_rx->status);
-
-	/* Acknowledge pending interrupts */
-	writel(status & XMCDMA_IRQ_ALL_MASK, &priv->mcdma_rx->status);
-
-	/*
-	 * If Reception done interrupt is asserted, call Rx call back function
-	 * to handle the processed BDs and then raise the according flag.
-	 */
-	if (status & (XMCDMA_IRQ_IOC_MASK | XMCDMA_IRQ_DELAY_MASK))
-		return 1;
-
-	return 0;
-}
-
 /**
  * axi_mrmac_recv - MRMAC Rx function
  * @dev:	udevice structure
@@ -354,47 +336,62 @@ static bool isrxready(struct axi_mrmac_priv *priv)
  *
  * Return:	received data length on success, negative value on errors
  *
- * This is a Rx function of MRMAC. Check if any data is received on MCDMA.
- * Copy buffer pointer to packetp and return received data length.
+ * This is a Rx function of MRMAC. Check whether the descriptor that
+ * rx_bd_idx points at has been completed by the DMA engine, and if so copy
+ * its buffer pointer to packetp and return the received data length. The
+ * descriptor stays owned by the driver until axi_mrmac_free_pkt() gives it
+ * back to hardware.
+ *
+ * A completed descriptor with no length, or one flagged with an error, holds
+ * no frame for the network stack. Report an empty packet for it, so that the
+ * caller recycles the descriptor through axi_mrmac_free_pkt().
  */
 static int axi_mrmac_recv(struct udevice *dev, int flags, uchar **packetp)
 {
 	struct axi_mrmac_priv *priv = dev_get_priv(dev);
-	u32 rx_bd_end;
+	struct mcdma_bd *bd;
+	uchar *buf;
 	u32 length;
 
+	bd = &priv->rx_bd[priv->rx_bd_idx];
+
+	/* Invalidate the descriptor to see the status written by DMA */
+	invalidate_dcache_range((phys_addr_t)bd,
+				(phys_addr_t)bd + roundup(sizeof(*bd),
+							  ARCH_DMA_MINALIGN));
+
 	/* Wait for an incoming packet */
-	if (!isrxready(priv))
+	if (!(bd->status & XMCDMA_BD_STS_COMPLETE))
 		return -EAGAIN;
 
-	/* Clear all interrupts */
-	writel(XMCDMA_IRQ_ALL_MASK, &priv->mcdma_rx->status);
-
-	/* Disable IRQ for a moment till packet is handled */
-	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_IRQ_ALL_MASK);
+	/*
+	 * A completed descriptor with an error, or with no data in it, holds
+	 * no frame to pass up. Report an empty packet so that the caller
+	 * recycles the descriptor through free_pkt() and moves on.
+	 */
+	if (bd->status & XMCDMA_BD_STS_ALL_ERR) {
+		*packetp = NULL;
+		return 0;
+	}
 
-	/* Disable channel fetch */
-	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
+	length = bd->status & XMCDMA_BD_STS_ACTUAL_LEN_MASK;
+	if (!length) {
+		*packetp = NULL;
+		return 0;
+	}
 
-	rx_bd_end = (ulong)priv->rx_bd + roundup(RX_BD_TOTAL_SIZE,
-						 ARCH_DMA_MINALIGN);
-	/* Invalidate Rx descriptors to see proper Rx length */
-	invalidate_dcache_range((phys_addr_t)priv->rx_bd, rx_bd_end);
+	buf = (uchar *)(ulong)(((u64)bd->buf_addr_msb << 32) | bd->buf_addr);
 
-	length = priv->rx_bd[0].status & XMCDMA_BD_STS_ACTUAL_LEN_MASK;
-	*packetp = (uchar *)(ulong)priv->rx_bd[0].buf_addr;
+	/* Invalidate the buffer before the network stack reads it */
+	invalidate_dcache_range((phys_addr_t)buf,
+				(phys_addr_t)buf + roundup(PKTSIZE_ALIGN,
+							   ARCH_DMA_MINALIGN));
 
-	if (!length) {
-		length = priv->rx_bd[1].status & XMCDMA_BD_STS_ACTUAL_LEN_MASK;
-		*packetp = (uchar *)(ulong)priv->rx_bd[1].buf_addr;
-	}
+	*packetp = buf;
 
 #ifdef DEBUG
 	print_buffer(*packetp, *packetp, 1, length, 16);
 #endif
-	/* Clear status */
-	priv->rx_bd[0].status = 0;
-	priv->rx_bd[1].status = 0;
 
 	return length;
 }
@@ -407,43 +404,34 @@ static int axi_mrmac_recv(struct udevice *dev, int flags, uchar **packetp)
  *
  * Return:	0 on success, negative value on errors
  *
- * This is Rx free packet function of MRMAC. Prepare MRMAC for reception of
- * data again. Invalidate previous data from Rx buffers and set Rx buffer
- * descriptors. Trigger reception by updating tail descriptor.
+ * This is Rx free packet function of MRMAC. The caller is done with the
+ * descriptor that axi_mrmac_recv() looked at, so give that one descriptor
+ * back to hardware by extending the tail pointer to it. The channel is
+ * never stopped, so nothing else has to be touched: no halt, no current
+ * descriptor rewrite and no re-arming of the whole ring.
  */
 static int axi_mrmac_free_pkt(struct udevice *dev, uchar *packet, int length)
 {
 	struct axi_mrmac_priv *priv = dev_get_priv(dev);
+	struct mcdma_bd *bd = &priv->rx_bd[priv->rx_bd_idx];
 
 #ifdef DEBUG
 	/* It is useful to clear buffer to be sure that it is consistent */
 	memset(priv->rx_buf, 0, RX_BUFF_TOTAL_SIZE);
 #endif
-	/* Disable all Rx interrupts before RxBD space setup */
-	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_IRQ_ALL_MASK);
-
-	/* Disable channel fetch */
-	clrbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
-
-	/* Update current descriptor */
-	axi_mrmac_dma_write(&priv->rx_bd[0], &priv->mcdma_rx->current);
-
-	/* Write bd to HW */
-	flush_cache((phys_addr_t)priv->rx_bd, RX_BD_TOTAL_SIZE);
-
-	/* It is necessary to flush rx buffers because if you don't do it
-	 * then cache will contain previous packet
+	/*
+	 * Clear the status written by the DMA engine, restore the buffer
+	 * length, flush the descriptor and extend the tail pointer to it so
+	 * the engine may reuse this slot.
 	 */
-	flush_cache((phys_addr_t)priv->rx_buf, RX_BUFF_TOTAL_SIZE);
+	bd->status = 0;
+	bd->cntrl = PKTSIZE_ALIGN;
 
-	/* Enable all IRQ */
-	setbits_le32(&priv->mcdma_rx->control, XMCDMA_IRQ_ALL_MASK);
+	flush_cache((phys_addr_t)bd, roundup(sizeof(*bd), ARCH_DMA_MINALIGN));
 
-	/* Channel fetch */
-	setbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
+	axi_mrmac_dma_write(bd, &priv->mcdma_rx->tail);
 
-	/* Update tail descriptor. Now it's ready to receive data */
-	axi_mrmac_dma_write(&priv->rx_bd[1], &priv->mcdma_rx->tail);
+	priv->rx_bd_idx = (priv->rx_bd_idx + 1) % RX_DESC;
 
 	log_debug("Rx completed, framelength = %x\n", length);
 
diff --git a/drivers/net/xilinx_axi_mrmac.h b/drivers/net/xilinx_axi_mrmac.h
index baf936f6b66..2c5c83421e5 100644
--- a/drivers/net/xilinx_axi_mrmac.h
+++ b/drivers/net/xilinx_axi_mrmac.h
@@ -38,6 +38,7 @@ struct axi_mrmac_priv {
 	struct mcdma_bd *rx_bd;	/* Base of the contiguous Rx BD ring */
 	u8 *txminframe;		/* Pointer to hold min length Tx frame(60) */
 	u8 *rx_buf;		/* Driver-owned RX buffer pool (RX_DESC * PKTSIZE_ALIGN) */
+	u32 rx_bd_idx;		/* Next Rx descriptor to consume: 0 .. RX_DESC-1 */
 	u32 mrmac_rate;		/* Speed to configure(Read from DT 10G/25G..) */
 };
 
-- 
2.34.1

