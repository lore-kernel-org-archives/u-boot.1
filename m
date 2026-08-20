Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53344C5DF81
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:27:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1E6A780C8D;
	Thu, 20 Aug 2026 09:27:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VcNE-uTK_Y2v; Thu, 20 Aug 2026 09:27:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218032;
	bh=J4LxvyJwXIoZMZZXrlGGjMpKSk6sE0qyLKLhzf3cBa4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=u/v/22C/0l4p6QRX+HCAddE28T87Eq1Lh2pTzlEOzxyVTIeg5f/pYzg9W9opQMJ32
	 /cU2y1zwYawUksiJUqCCYtI7aHO9DRVD2X1fUDb4YfnQXf8Czi9xSIHlIvsVz0kVkC
	 AK5pP3ViguMVrdukz9dPsUvGv3b6wmhHD/QHbYDls11FywgQsCWtKfN3ezataze0Ao
	 UyhCFMMIqrB0YKmf5m1Vrmx6GyBdtJ70lx4H0+dCkefrVdyRfRV4CFG94VWfEJ5zRC
	 a9DtGF0iWSSOwVM8rQWL+a3rgYYgpa8MIvN5eA27RUsAdJpr2M/U7Lty/m0VdUMBjw
	 cvvenKSPHzoDQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id C528780C53;
	Thu, 20 Aug 2026 09:27:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id D412639E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAE8D60623
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LMRNfotGbJMy for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:27:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c105::1;
 helo=ch1pr05cu001.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=wy3qDfvj
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D9F8560619
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:27:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nImOASS8+vQoidpxxfEqNWd/v0sb2uOGXbM2BXoGLhPl/0RB1psEN4zW9nZ6Iaan5By036gpmf1X7oc64Uc05v5l0VBUnG1oi9gbmeyJ6Den6rAtZBO+C3ieX7tXAKB2fyhxCIfZpWllTSNN8QMQGcGlokNR9wvOBaPw74n7ORVdwfUkA6uconh+kzcedoFdYTg6wNdYPbAhuVIatTIR4GHfylIxz2cwbEK/l5cdc7/GPenuGzSJHlGmh/KvTpWfoVkDnzbNkwhULclxbghVO49P6ApSaIKtmebPAXwzIghr+rj8T4dDSCt3cidOBFmMqh/DjF5NdwS7xkHIsZ0mfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J4LxvyJwXIoZMZZXrlGGjMpKSk6sE0qyLKLhzf3cBa4=;
 b=qJ2fz04n9N+GTad5ZhLT0FoMeVI1DYWcjiRnM15g+Aux/9pju1kdWYEJYXEaeBOWNkMdXqHngU61crUN6ME6kCEJV0nYyaSgTNTlOJKaUt+ZfFjJm2Jj3O0r6sthVOWwx/ZvO+Zq+QGZ1WyBraURpr0LPPDpNPBqA+bCEsS0y/pSPIxmyDlJqfAqznY/Nzu1mtxvPKrTo0ZBkSJh13DNzTtOpbNd/X35M6740YCsShGeX4GowVkzbg5oePOixqFZEzWaV5hnLYCfFoq58iAaSOc4Ov4ZMO15VTRdYsVVgQm/ql55NiajFPAyehnZVOFfNNKKgk05TNG0rXcF+iNKbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J4LxvyJwXIoZMZZXrlGGjMpKSk6sE0qyLKLhzf3cBa4=;
 b=wy3qDfvjh1D1/DaBnFlOr/6GSP5aAb8bPDNfxxW7r4euDlQLMSO5CVsH8ILkKaFZkmGQ3AgAXVRFPhpCGxuFJlHvmgyrJU8oYnGKBA+jNtucTcQUO5jbSmtwyXypN+HxYtr4h6enNKUejxCog4VmjI6jI3lNbWSFDOykcpVEmnU=
Received: from BN1PR12CA0009.namprd12.prod.outlook.com (2603:10b6:408:e1::14)
 by SA0PR12MB4496.namprd12.prod.outlook.com (2603:10b6:806:9b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 20 Aug
 2026 09:27:06 +0000
Received: from BN2PEPF0000A7FF.namprd02.prod.outlook.com
 (2603:10b6:408:e1:cafe::8c) by BN1PR12CA0009.outlook.office365.com
 (2603:10b6:408:e1::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.10 via Frontend Transport; Thu,
 20 Aug 2026 09:27:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FF.mail.protection.outlook.com (10.167.245.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:27:06 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:27:05 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:27:03 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH 5/8] net: mrmac: initialize the Rx BD ring in a loop
Date: Thu, 20 Aug 2026 14:55:51 +0530
Message-ID: <20260820092623.1647844-6-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FF:EE_|SA0PR12MB4496:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b2c3532-6cfb-4529-76ee-08defe9d33b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: E8oFsrVf6UnMm++faIyCqneF4AjvOsOTrU3ffewr0PCeYzp6YCxq97VzpX2pvOeMdKiWLzV6H9zHnql2gF75epDuLI2qFtr0AnAytiqm0fWhChItlRFTUhU1TEfnScOYxDmTC+AftkgVeknN83peHp+TrDhAsl0uGcDqjzm+ZL2h/HiH5bOZ91tRUO1y9Db5kPv36jiIRmnqOwEwSEcgm3SkfZLed9IgYYwWDQbEWGY44n/5mM2WUIPw4+3WuKpy0jFd6qm6SVZuxK+RgYyOmfhN+ohxf8vykSmCqJ2TSCL6QvcTq/gcklAgKbQBzvt5/yPLqMktGRxbYEHVkik7XDZu8ETmuNuSELnHLW+k/UynfGTk2fcuN5uOmqzKSjJ9L9bWKZ/GdT7xSiS/e5Mm26AOb2U/Adn3bJSD5zaDFlB7d5GKj3h2xEeTIkTIin8wE340rnTYq8Ps1buBXFDgclvfJwMMlPJEfwRgdV+z7TO9S+0z3CgXqfBO+PxPcNXQtjNn7BVm05U1XuuPC3t+fzcEH/V8CGm3KyA0jXpXX94uYowfzpZjlb/oNQPcwY5vjmurb6A07D+kjxWclQTACwrfrcHBvPIzhi1elxPa4Dk+O0NuJLpCNIqU+rvq/Hppk5u6vbt24p5JTOz7wM684dwuXi88HUk8JUzuNidgFcT0BjK2dh2zrbiFBfeJCR8XQl+s4xoV3uGeuwg1vHZeJA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DbXw+Ah8Pc/GzRAv19xdS9z4wPFc9OIZgwRA2ku8qQH4bASO81P0c2AaW+uJR5Zd+2pfgMpc1/RTQxbOYc0rc8wYv9e9h5hd2y+G9sr1QoNJrk0I76lHwb+cJQmy8uR4MQMHFBcUh/v0Wl+7KCikymmtzS/Jmgl+uW2FZvS2D5sjSzDXAEDMNu9szH52wxLgWXm50EBusU9nPYbko5011TkE2vPfJ1jX5a7yLbgfDgG+BBPAFkaL1ir29fZlEqge+x8xZEqAH/aa781h1U5SQWlBdzfKkTHAHX+99qxyVqXu/itqiWEYArRke4GGi8iyzAWfi/lMy5H1l9VdQ+JVn4elghXkoA7fgo5EuAqAbMVKsZ39SHYvGIX960Nkt6CXohJ2f9hXlw7yx6ash4lTyB9rGqy6MartSN0iDIIjQFiLHJaCvEn5RyhUep1qb1UR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:27:06.3852 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2c3532-6cfb-4529-76ee-08defe9d33b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4496
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

The Rx descriptors are chained by hand, one assignment per descriptor
and per field. Adding a descriptor means adding another block of
next_desc/buf_addr/cntrl assignments, so the number of Rx descriptors
is effectively frozen at two.

Build the same chain in a loop over RX_DESC instead. Each descriptor
points at its successor, the last one wraps back to the first, and each
gets its own PKTSIZE_ALIGN slice of the Rx buffer pool. The tail
descriptor is now the last one of the ring rather than a hardcoded
rx_bd[1]. The resulting ring is identical to the hand-written one for
RX_DESC = 2, but the descriptor count is now a single constant to
change.

Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 34 +++++++++++++++++++---------------
 1 file changed, 19 insertions(+), 15 deletions(-)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index d77b0e3445b..2c97e9576c9 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -162,6 +162,7 @@ static int axi_mrmac_start(struct udevice *dev)
 {
 	struct axi_mrmac_priv *priv = dev_get_priv(dev);
 	struct mrmac_regs *regs = priv->iobase;
+	int i;
 
 	/*
 	 * Initialize MCDMA engine. MCDMA engine must be initialized before
@@ -181,27 +182,30 @@ static int axi_mrmac_start(struct udevice *dev)
 	/* Update current descriptor */
 	axi_mrmac_dma_write(&priv->rx_bd[0], &priv->mcdma_rx->current);
 
-	/* Setup Rx BD. MRMAC needs atleast two descriptors */
+	/*
+	 * Setup Rx BDs as a closed ring: every descriptor points at the next
+	 * one and the last one wraps back to the first, each with its own
+	 * slice of the Rx buffer pool. MRMAC needs at least two descriptors.
+	 */
 	memset(priv->rx_bd, 0, RX_BD_TOTAL_SIZE);
 
-	priv->rx_bd[0].next_desc = lower_32_bits((u64)&priv->rx_bd[1]);
-	priv->rx_bd[0].buf_addr = lower_32_bits((u64)priv->rx_buf);
+	for (i = 0; i < RX_DESC; i++) {
+		struct mcdma_bd *next = &priv->rx_bd[(i + 1) % RX_DESC];
+		u8 *buf = priv->rx_buf + i * PKTSIZE_ALIGN;
+		struct mcdma_bd *bd = &priv->rx_bd[i];
 
-	priv->rx_bd[1].next_desc = lower_32_bits((u64)&priv->rx_bd[0]);
-	priv->rx_bd[1].buf_addr = lower_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
+		bd->next_desc = lower_32_bits((u64)next);
+		bd->buf_addr = lower_32_bits((u64)buf);
 
-	if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
-		priv->rx_bd[0].next_desc_msb = upper_32_bits((u64)&priv->rx_bd[1]);
-		priv->rx_bd[0].buf_addr_msb = upper_32_bits((u64)priv->rx_buf);
+		if (IS_ENABLED(CONFIG_PHYS_64BIT)) {
+			bd->next_desc_msb = upper_32_bits((u64)next);
+			bd->buf_addr_msb = upper_32_bits((u64)buf);
+		}
 
-		priv->rx_bd[1].next_desc_msb = upper_32_bits((u64)&priv->rx_bd[0]);
-		priv->rx_bd[1].buf_addr_msb = upper_32_bits((u64)priv->rx_buf + PKTSIZE_ALIGN);
+		bd->cntrl = PKTSIZE_ALIGN;
 	}
 
-	priv->rx_bd[0].cntrl = PKTSIZE_ALIGN;
-	priv->rx_bd[1].cntrl = PKTSIZE_ALIGN;
-
-	/* Flush the last BD so DMA core could see the updates */
+	/* Flush the BDs so DMA core could see the updates */
 	flush_cache((phys_addr_t)priv->rx_bd, RX_BD_TOTAL_SIZE);
 
 	/* It is necessary to flush rx buffers because if you don't do it
@@ -218,7 +222,7 @@ static int axi_mrmac_start(struct udevice *dev)
 	setbits_le32(&priv->mcdma_rx->control, XMCDMA_CR_RUNSTOP_MASK);
 
 	/* Update tail descriptor. Now it's ready to receive data */
-	axi_mrmac_dma_write(&priv->rx_bd[1], &priv->mcdma_rx->tail);
+	axi_mrmac_dma_write(&priv->rx_bd[RX_DESC - 1], &priv->mcdma_rx->tail);
 
 	/* Enable Tx */
 	setbits_le32(&regs->tx_config, MRMAC_TX_EN_MASK);
-- 
2.34.1

