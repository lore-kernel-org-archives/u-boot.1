Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 697CED58E78
	for <u-boot@archiver.kernel.org>; Mon,  2 Mar 2026 07:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B09E183F54;
	Mon,  2 Mar 2026 08:44:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BDSx3c9h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8971283F20; Mon,  2 Mar 2026 08:44:08 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1CDEE83F2A
 for <u-boot@lists.denx.de>; Mon,  2 Mar 2026 08:44:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UG+eq3FXtAh4u6OBqN1APPUx5dlpx5VACnvX934IJvmGwGSg0UH/6cMmh3ccRo6UiPUcm+AmYScYN8JnyILYW3E4YkKBizeOa/DvxmnDWd+iWtSa8iTyhhaKVXbM1QYh29a3GpMqPUMXRPh13sHjjNcq7hFV0MPSGzdTecaSbbTLFuwKWtE0W6kZoaB4qDOCnTzXdr45Yot6d2Omfs383nh9umF2ukqPOosFU+cCPvFzr+wqn8PQaf4tgkOFTlwccQjRr09M5Bv3O26MB+ssC3qOJrVA9hkrpPnfy28ExGWWPg6+U59nMaBTyYMdsChnBsapTwscERkJO0iwgX7Prg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cGsNmbDokrgL8aaDxzC8ox/QDIKwIRB1MYjgY+gdWbE=;
 b=o4CUN7qPneoagPtaxJgs3nXVp703JXDRzC6JmSF2o7apopXgWID3IWLZKY6IMPxuTGDvSIJO9KQJ6h9tmaIORLKK1Aqg1qlg0vf6cFTIXCo7gShSehuyUO2vKySesFkrPXuw8u9Z/PAyC6vEe3wUM4M/6VMb8ntVH2avaQLpZLipWv8XFlZDfKPUSFRwxp+xYEP9+s/D0wu6sDXXD9U/wgFLRtKwuPRd3DzbYmFVM+Sm0aXQLPvXwgoqS3Bg1vnfTLtGXgqrsqZEMybQm9xGUbZKRnrMu+kScg7qwlUNrm2ONn6mGIJEX2nHTTZdH4+WGtOLaDBWglMghKCs8eS6DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cGsNmbDokrgL8aaDxzC8ox/QDIKwIRB1MYjgY+gdWbE=;
 b=BDSx3c9hqCJGSH8Xzr7NzfdkS1f3YrRx9/zQ3fGXX5ZKfRmGDsr/Q8PdxsqlM0uG7qZ8+tKxL8gLFo3dv1MDj+xVBHjZJ/nZ2AI1ybdzDXG3V/Gq0TANAXM+dfcuXw+WXZ4pSXGaojQcT0HW2Jc30+IrTbzhDm8l75TZ1fxyG5I=
Received: from SA9PR13CA0143.namprd13.prod.outlook.com (2603:10b6:806:27::28)
 by DM3PR12MB9436.namprd12.prod.outlook.com (2603:10b6:8:1af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.20; Mon, 2 Mar
 2026 07:43:57 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:27:cafe::d0) by SA9PR13CA0143.outlook.office365.com
 (2603:10b6:806:27::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.20 via Frontend Transport; Mon,
 2 Mar 2026 07:43:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 2 Mar 2026 07:43:57 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 2 Mar
 2026 01:43:56 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Mar
 2026 01:43:55 -0600
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 2 Mar 2026 01:43:55 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Harini Katakam <harini.katakam@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Martin Kaistra <martin.kaistra@linutronix.de>,
 Padmarao Begari <padmarao.begari@amd.com>, Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Subject: [PATCH 3/3] net: zynq_gem: Add support for dma-coherent flag
Date: Mon, 2 Mar 2026 08:43:34 +0100
Message-ID: <10c7a40364162cc8d3c82cb3e64e043f49a5153e.1772437409.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1772437409.git.michal.simek@amd.com>
References: <cover.1772437409.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2868; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=Hy9Gq96K0aGdXQ5uQ3EqEK3NwCOr0rfil5AaRUVYrm8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQutV9VlWf3L6SWQ3Th08aGPXGrpDaVeU24JLmr4lPip
 nWmc5SSOkpZGMQ4GGTFFFmmM+k4rPl2banY8sh8mDmsTCBDGLg4BWAioQcYGc4nHL4unj8t+PV/
 sxTjdVEut27wO5Tz7Zi32/3kO/9i/h5Ghu7vv+ddD20Mi45eJXH9wl++g8dnce8NmzVVQeT3lsz
 sE2wA
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|DM3PR12MB9436:EE_
X-MS-Office365-Filtering-Correlation-Id: 053b194d-143a-41b9-2d42-08de782f761d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: V4cWh4iQuQhvOh8e1ki31K4q6WEktVqZsgNvSYcsi8oYqWPjUaDkOgoT5LJPHgyHXFSkSLyx3vw0n6WlzMp+GnF3OalRMj7gMY6k7gjkWE2sm0Vhd9TahYuH96ppQ6Z1ZNqwUqDSOEZw6VgVVKwKiXs6mHYXDj73O2ra91LbmhmGk2oiz6I6U0ctOuDFfo610PUe8790UEj0W7eFiJvLMmq1NlUuE0RmUOjMWTdIKwSiYCHfDRJMCS6JEkC1MLjiRS9LLj2P++Hq4U0pUX680gmJ+hqYaHYoFHfun0DFfQVpp1rcAAk/fzAdwV0YXw6hnMjZVA/t9W9xP3leMgNhNZbjrw0lWqwLA2NZavJJ51R40380ho7PbB41KH8bBgAyJC+rdY6L/nl8CA7kCS+AH5I4uJNnBAXiAq/jwXZyoZYY50pr9tCs072L3J8b0KabjWskXZpVTKjjDzBUwQLCYNYQzG5dKV7owJJafwtJLVXwt3zxan6IckAbVs36CjbAjdG4D2LjT0GFajSTNXsjNZjDBMyG88xy+eAZ1UM8d4dExk7/ZcNGN6gjVyNnTp2P5BhmdcjmBTfY12rahAKCUBr+brtJwqDFpRo37+66HEKogA2djxpurqCSQ3T20pDokCb5KkKnamWbiM1w5fHVeWLoaPJsam9dcdrVpYDDywNJfvrMkn2ZK2yyFkI8+cfZzBn7OokI9j7qlyC/dvYHzGLW1aFx3IvgKX+zwuyqj0/Dvxi4rB9ipNdZmCfGxrVuh3un3S7jY5g5m9NF+/VckWTxfSKBt1zbbVHr2lOdUTn5lLRgTPnaQE4yyqphdrXE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: FwtSylMdZPWXZQil3qevOsVZ4NHr1xXRWF6UPuURK6CpffjKvUv7IRCwbNg0lByOY/vhE8znp4Te8YOPaEad9wvyr101IyIz9duIgI5dohWsWFc+Bi+gdt/xgz6PYtfztnQewhrn9YvjEI43OPAknEg8vtVGk5eZFFbOItGUBySw0JdJr/QPoSsHXL+2uc5xB72mQRyQk+Z5Orh+pEs/ULNKUos58mkfcdFYalaVI6/4+DuF83JxgOVGDy3hjP12d6ae9O3P0eP9pQRKWEvpYA6LwyaecfAqYNn/tDEz/+1P2x0u+R8G5G4KCG8MBb6FH2le7XKKlk8fk2nMKCaE1yENc/E+OqJeUU6v3gPTT28h2sEGCY0Cwq9M0X+p8f7hocTjWv6SRaPx3bBxivfZVQi1ZXtiJkN9Nxqw0c0BV+H8qNGZbG043AX/ihffpY+d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2026 07:43:57.3001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053b194d-143a-41b9-2d42-08de782f761d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9436
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

When dma-coherent DT property is passed there is no need to do any cache
operations.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 drivers/net/zynq_gem.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index 41883a440528..a50d5aee03fe 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -258,6 +258,7 @@ struct zynq_gem_priv {
 	struct clk pclk;
 	u32 max_speed;
 	bool dma_64bit;
+	bool cache_on;
 	u32 clk_en_info;
 	struct reset_ctl_bulk resets;
 };
@@ -725,7 +726,8 @@ static int zynq_gem_send(struct udevice *dev, void *ptr, int len)
 	addr = (ulong) ptr;
 	addr &= ~(ARCH_DMA_MINALIGN - 1);
 	size = roundup(len, ARCH_DMA_MINALIGN);
-	flush_dcache_range(addr, addr + size);
+	if (priv->cache_on)
+		flush_dcache_range(addr, addr + size);
 	barrier();
 
 	/* Start transmit */
@@ -777,7 +779,8 @@ static int zynq_gem_recv(struct udevice *dev, int flags, uchar **packetp)
 
 	*packetp = (uchar *)(uintptr_t)addr;
 
-	invalidate_dcache_range(addr, addr + roundup(PKTSIZE_ALIGN, ARCH_DMA_MINALIGN));
+	if (priv->cache_on)
+		invalidate_dcache_range(addr, addr + roundup(PKTSIZE_ALIGN, ARCH_DMA_MINALIGN));
 	barrier();
 
 	return frame_len;
@@ -810,8 +813,8 @@ static int zynq_gem_free_pkt(struct udevice *dev, uchar *packet, int length)
 #else
 	addr = current_bd->addr & ZYNQ_GEM_RXBUF_ADD_MASK;
 #endif
-	flush_dcache_range(addr, addr + roundup(PKTSIZE_ALIGN,
-						ARCH_DMA_MINALIGN));
+	if (priv->cache_on)
+		flush_dcache_range(addr, addr + roundup(PKTSIZE_ALIGN, ARCH_DMA_MINALIGN));
 	barrier();
 
 	if ((++priv->rxbd_current) >= RX_BUF)
@@ -934,7 +937,8 @@ static int zynq_gem_probe(struct udevice *dev)
 
 	memset(priv->rxbuffers, 0, RX_BUF * PKTSIZE_ALIGN);
 	ulong addr = (ulong)priv->rxbuffers;
-	flush_dcache_range(addr, addr + roundup(RX_BUF * PKTSIZE_ALIGN, ARCH_DMA_MINALIGN));
+	if (priv->cache_on)
+		flush_dcache_range(addr, addr + roundup(RX_BUF * PKTSIZE_ALIGN, ARCH_DMA_MINALIGN));
 	barrier();
 
 	/* Align bd_space to MMU_SECTION_SHIFT */
@@ -944,8 +948,9 @@ static int zynq_gem_probe(struct udevice *dev)
 		goto err1;
 	}
 
-	mmu_set_region_dcache_behaviour((phys_addr_t)bd_space,
-					BD_SPACE, DCACHE_OFF);
+	if (priv->cache_on)
+		mmu_set_region_dcache_behaviour((phys_addr_t)bd_space,
+						BD_SPACE, DCACHE_OFF);
 
 	/* Initialize the bd spaces for tx and rx bd's */
 	priv->tx_bd = (struct emac_bd *)bd_space;
@@ -1058,6 +1063,9 @@ static int zynq_gem_of_to_plat(struct udevice *dev)
 	/* Hardcode for now */
 	priv->phyaddr = -1;
 
+	if (!dev_read_bool(dev, "dma-coherent"))
+		priv->cache_on = true;
+
 	if (!dev_read_phandle_with_args(dev, "phy-handle", NULL, 0, 0,
 					&phandle_args)) {
 		fdt_addr_t addr;
-- 
2.43.0

