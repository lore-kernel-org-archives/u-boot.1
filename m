Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69C7FCCFA05
	for <u-boot@archiver.kernel.org>; Fri,  7 Nov 2025 10:13:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1EF083CB9;
	Fri,  7 Nov 2025 11:13:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CpaLZfgG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8FAA383CD2; Fri,  7 Nov 2025 11:13:38 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7945D83CB8
 for <u-boot@lists.denx.de>; Fri,  7 Nov 2025 11:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p+R3UCix4qh1XRDau6Eckgd6QIpxPVo71GCBlUoQ5n/WVKBDse8CrD5W9M9yq3gFFsu5eb3ts0aLHLH2g4o13we1YTlufBScc/J1QvO6VJj5P/ytTslxNyGBt8nASg/OazmR5uj8ltswqirsowXk7KEYMZ6epp3ZZcKVfhfE5u/sDmNWYh7uJ153bLOMmw7cukdWgLeM/rXgJe82ftY0iUGJe1UDyMbk2w+WmdlOxOcYOGWkHZSYa34lvJcI7Wa03p7M6agHE/7dPuDVBhiKoUwNE0107XLPXlIfaWR3ZemuzDtDEId8wzaRFs21ac0eDtmzf2oezcwEvCpNnSHL/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WWvdTWA6Pw1RrnRNBubRjqYTYApzzAIALIcXZ8g+m8E=;
 b=KsZhY0s4xf3bJlsQsHsb25OHUGY99nH/51sN7+TgEGLM2PiAJyRuv8k6DfU6dGWze0W9IOzAad3+d63MAVfXrah1y6oQ7v33rb5djHM/AxfwukXVUZcP37aRcfIs0cogr9RjAGlVTAAt97A0t+lv3O/jLD+I6GjPw0VD8oFLHm2c8uJM1XKviGLPB1SMMUpGbZxEQ1cLdVGPRm0Ra8+J7r/tbAv9qkYQKRZwh/wdRkwmNy+Ymw6pUmvhNvab1N96Vo78MmGVwQTLHGFVj8NZ8xk1s12cK1mciFJaWWTwElChViyDa2+1ehQilAqKGdumCykyQdi+hRENJBHjqwGbag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WWvdTWA6Pw1RrnRNBubRjqYTYApzzAIALIcXZ8g+m8E=;
 b=CpaLZfgGNtJgWXn/tsw6ke7Ni/V7RkqZ2Aqiz8nHujJYrmFNaiYJh38Aw6gfo2UXoYiaElFpRPsGOYntAws/CpNyET9Osa7zrtDRadIMZEfjcJE+TclBBHOFbTvsgXm3PvgL0aNyl2GrR3vxPn2WhKh0yjiusQPA5n0GKGJAgEs=
Received: from MN2PR13CA0024.namprd13.prod.outlook.com (2603:10b6:208:160::37)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 10:13:29 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:208:160:cafe::68) by MN2PR13CA0024.outlook.office365.com
 (2603:10b6:208:160::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Fri,
 7 Nov 2025 10:13:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 10:13:29 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:13:28 -0800
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 7 Nov
 2025 02:13:27 -0800
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Fri, 7 Nov 2025 02:13:27 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>, Andrew Goodbody
 <andrew.goodbody@linaro.org>, Jerome Forissier <jerome.forissier@linaro.org>, 
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried <rfried.dev@gmail.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Tom Rini <trini@konsulko.com>
Subject: [PATCH] net: axi_emac: Fix compilation warnings
Date: Fri, 7 Nov 2025 11:13:23 +0100
Message-ID: <11b1d9b1a5589d06cff724e807832f366794c075.1762510401.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3132; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=e1mAF7A/mp52p1ZvQejOrhvfK4LUKUPftqkEMagg8yI=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWTyHnN5/IT/QKBh9Z6CK8WTH5W0dZj2WxeLTapNcJzk7
 PCOTf9FRwkLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEzEL5Lhx/Vy7QS34vux91c+
 n/HnUElk6O6ctDzr0363y7X2sLBZMDJM2l10ZOkzHkaJ1KyctVE+n6S1Gl+V8drbv7K7objP4xI
 HAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0c4ed4-8b0f-4f76-3967-08de1de64c2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+LYpgmx2YZQ2U7ah7WLh4Lb1Mekc2bfmUPwYrhYc+hho3l9TvGe5fNhUNz6x?=
 =?us-ascii?Q?JypEGePSVDfCNO0av4D7IHdfzxC4NALXkuPzbWEoCkuP2hrErbK9DfXQOQap?=
 =?us-ascii?Q?UF8JlrmgQ3Mcilc+hykhAgkjOaL+3LDM8L2lQPDfdvLxh9SNmVSRM2wrjw7W?=
 =?us-ascii?Q?zs3mK/nc90n2nSUyGl9tWhbzlrZSsIdGnmXCZ32fDvGrkIpZrDUnCJIZNGgk?=
 =?us-ascii?Q?C4ZpTm32NNNOyZKm9JdZHnPUEfQ7D+US2tB29LqBYczwoOCLS739J/choBMX?=
 =?us-ascii?Q?y/UBwmL4lh1szF6eSIsZrF1/Rn6cMBSJZ7xfrjlD0F9wKuSy04toeGBvVOoP?=
 =?us-ascii?Q?XWG6zkbtftnB/EVY8+fuzAntPrlPpMXiLZS4HnovYINf6hjC3oiGv90bJg+y?=
 =?us-ascii?Q?gmCffuEdSqzklM7GQP8RrRfN6ITZfTZkrTageSPySJgqvw/nNJQFABZU0Rp9?=
 =?us-ascii?Q?G/dKfJVvk1ByLaAB8YZKxcvkWHCML1zuMeWeI56jjL0yzLZJS31oVMQkp2C+?=
 =?us-ascii?Q?7rUE13leHhYONvYth5D4Wskif1h2Eqkj9mxTCsHxgzV/GLLJkk7c0Y3VR4Rg?=
 =?us-ascii?Q?nvwUFEOwSRX0gCumXJ7BmDqjt6A6Cok+KR72M2ooljPnOqqVr30ZbfjR0YQP?=
 =?us-ascii?Q?o2hdSwQAlUHeEe+hiZFHlKV4A/Eg8lGFulSStN7IF/2QcFLWPhlDSQ69QTKQ?=
 =?us-ascii?Q?tdDtzA0gNZMTjt27bnJ8vAXaSeuy/TQGezJc6ggOioGA9ys1wWk+5KhITBL+?=
 =?us-ascii?Q?x3y5gX7FixXwip6RkDNOUO1bB3zE3OYVD03JhFCvX1f6NMWgeQw+nO++uZAJ?=
 =?us-ascii?Q?cxAbT2vF+6gxpzxtkZb9J8eNVMERrEBMGtif2CLO7siD4Pqhu9YJ68qmtgT7?=
 =?us-ascii?Q?W3nxxsa8xRB5ZjbhEYYceEM3HBS7053IvuYT64GVtaK6l4WRfeXosOXl5D8q?=
 =?us-ascii?Q?tQoQqPLOEDkkJh5HIDIesxDVdGM1pf4poQZiDgthtAvnr+MaG8EKlCAmjXUT?=
 =?us-ascii?Q?hilYZAZ4XRefoQjzzUT+XwG0LNsatfpEdqal4W8cZKDv2ljPYMLUrKEY0nbq?=
 =?us-ascii?Q?MvZApmFXROQVC26yAm/Li6H9kZDLZ6IxttarYSnxgahWAftCWjQaD6iUAtie?=
 =?us-ascii?Q?82heVOEPafE3d+N/FnQZcgBU6of6imsh6aJzZX5Wq2UOetLZ4thi4jukhTYR?=
 =?us-ascii?Q?tKxSrA3TVS17BQUtD03n7YSQMTANG+KU4n3aLr0g8qjsj0W2cjxfNJgW1Dx6?=
 =?us-ascii?Q?liK1VgeUpqlx/YbOrnoz6h1J62hbUHJkpnC9sRsm7ksLrQl0TIj7x9msjo4L?=
 =?us-ascii?Q?+aIxB/Z9U70BN9MIKQC99PrJqbvV7/kgPluGns4guGk+8cNiYUMs8TzvtRJd?=
 =?us-ascii?Q?HGLKzO4Xp9JNFhswE8Hy3Bp7r6SBJ41E3FJ5mwTP8bmwO45OqdPpOy8/Ze/T?=
 =?us-ascii?Q?A0ZlsG6AaOOIKCqL8opbn6WiVbCkV6Ln3idQfdPw5z45GIboILxctPQ5LoOs?=
 =?us-ascii?Q?dwFe7BSmyKyPRDKcppD/9D6L6LHYxpM01QLfWNI/6tjd8rT+Fwxea54jvpRr?=
 =?us-ascii?Q?LNs6iySp9GLsZBc0gVg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 10:13:29.0483 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0c4ed4-8b0f-4f76-3967-08de1de64c2d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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

From: Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>

Fix compiler warnings about casting integers to pointers of different
sizes by using uintptr_t as intermediate type. This ensures proper
type conversion across 32-bit and 64-bit architectures.

Signed-off-by: Sai Varun Venkatapuram <saivarun.venkatapuram@amd.com>
Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/net/xilinx_axi_emac.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/xilinx_axi_emac.c b/drivers/net/xilinx_axi_emac.c
index 22e119370c84..fb48feb4469a 100644
--- a/drivers/net/xilinx_axi_emac.c
+++ b/drivers/net/xilinx_axi_emac.c
@@ -619,11 +619,11 @@ static int axiemac_start(struct udevice *dev)
 #endif
 	rx_bd.cntrl = sizeof(rxframe);
 	/* Flush the last BD so DMA core could see the updates */
-	flush_cache((phys_addr_t)&rx_bd, sizeof(rx_bd));
+	flush_cache((phys_addr_t)(uintptr_t)&rx_bd, sizeof(rx_bd));
 
 	/* It is necessary to flush rxframe because if you don't do it
 	 * then cache can contain uninitialized data */
-	flush_cache((phys_addr_t)&rxframe, sizeof(rxframe));
+	flush_cache((phys_addr_t)(uintptr_t)&rxframe, sizeof(rxframe));
 
 	/* Start the hardware */
 	temp = readl(&priv->dmarx->control);
@@ -675,7 +675,7 @@ static int axiemac_send(struct udevice *dev, void *ptr, int len)
 	}
 
 	/* Flush packet to main memory to be trasfered by DMA */
-	flush_cache((phys_addr_t)ptr, len);
+	flush_cache((phys_addr_t)(uintptr_t)ptr, len);
 
 	/* Setup Tx BD */
 	memset(&tx_bd, 0, sizeof(tx_bd));
@@ -691,7 +691,7 @@ static int axiemac_send(struct udevice *dev, void *ptr, int len)
 						XAXIDMA_BD_CTRL_TXEOF_MASK;
 
 	/* Flush the last BD so DMA core could see the updates */
-	flush_cache((phys_addr_t)&tx_bd, sizeof(tx_bd));
+	flush_cache((phys_addr_t)(uintptr_t)&tx_bd, sizeof(tx_bd));
 
 	if (readl(&priv->dmatx->status) & XAXIDMA_HALTED_MASK) {
 		u32 temp;
@@ -791,11 +791,11 @@ static int axiemac_free_pkt(struct udevice *dev, uchar *packet, int length)
 	rx_bd.cntrl = sizeof(rxframe);
 
 	/* Write bd to HW */
-	flush_cache((phys_addr_t)&rx_bd, sizeof(rx_bd));
+	flush_cache((phys_addr_t)(uintptr_t)&rx_bd, sizeof(rx_bd));
 
 	/* It is necessary to flush rxframe because if you don't do it
 	 * then cache will contain previous packet */
-	flush_cache((phys_addr_t)&rxframe, sizeof(rxframe));
+	flush_cache((phys_addr_t)(uintptr_t)&rxframe, sizeof(rxframe));
 
 	/* Rx BD is ready - start again */
 	axienet_dma_write(&rx_bd, &priv->dmarx->tail);
@@ -831,10 +831,10 @@ static int axi_emac_probe(struct udevice *dev)
 	struct axidma_priv *priv = dev_get_priv(dev);
 	int ret;
 
-	priv->iobase = (struct axi_regs *)pdata->iobase;
+	priv->iobase = (struct axi_regs *)(uintptr_t)pdata->iobase;
 	priv->dmatx = plat->dmatx;
 	/* RX channel offset is 0x30 */
-	priv->dmarx = (struct axidma_reg *)((phys_addr_t)priv->dmatx + 0x30);
+	priv->dmarx = (struct axidma_reg *)((uintptr_t)priv->dmatx + 0x30);
 	priv->mactype = plat->mactype;
 
 	if (priv->mactype == EMAC_1G) {
-- 
2.43.0

base-commit: 2bcc9e92f6531ae9b75420eb1c7640a34d03a993
branch: vek385
