Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D0CEE6459
	for <u-boot@archiver.kernel.org>; Fri, 15 Sep 2023 11:27:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 183BA868D7;
	Fri, 15 Sep 2023 13:26:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QjxN80C6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68F6F86828; Fri, 15 Sep 2023 05:18:19 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 677A4866DA
 for <u-boot@lists.denx.de>; Fri, 15 Sep 2023 05:18:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfZOAlyemXA9Fx+gYYRH+WOtQB+BnmJRG7+FNt9e03eyA3/p+pFJcBx/jy+PEfAK48/CswVs5TL5YH/HpG2iNwCBtNpdQt9EgoMdTdluJ+ARAZPbgeI2brhfbvbNyE+so6P8VDGOHrJna0yWTwfiW9A4kLQOUe3BOneZbSwKu7orkGZ7zURD4NhjaLXUVmxgIzJ/6kb5DsIzXoQF4wbChiHmsojEyKVmxazgpY8KZ3zOjyD62tTOfjMuYDCmXISDYj3xJKrPcuD+ZgpeBIK3yU2EEHQbB+V0P3hOF0GLCdb9VvLCjUsOjHeuHI4Zm9zh88UzVBAjzUn16pnQ6BDGpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3R8T3Prgd24ZBGSdKd9xxwcZsP3tBKBlQvCPpqrAhPk=;
 b=ks2UUrLPly14wd8LNxIB3od2E1t6SjNXjwq3LAaRIX/3xJgYjitaKN7YUsql5FdJjiQzHJ6oswmA3YDHM6ZxDQp/uWr/5HQDEpZgAw9XAb/jMH3YGAKxh0zv35pSt91HvI/0JAGK97aNK62Zh0LfnDCdEhxTb2SmX4c8vBL075sy4HanVrcyw/2EKe7GDcShr5f0hnAQ3Ojj7bZjpsb2Ena6rGryyhiZG03W8TGtbwfqgK3Cyo8hSb8UZwMCGYZRHXmbJ6evGbQpnOOn09yQv9aUJkg8VKis/TtexqT49Zk79sX9hQd2j7qFL5Uw3i7JrKYR8mZAtT911mbaUoU44A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3R8T3Prgd24ZBGSdKd9xxwcZsP3tBKBlQvCPpqrAhPk=;
 b=QjxN80C6twZOxkTPMg1ejZpZhDtLY3FCs56r3sdd6hta6Xr1OgSVAM/QDGjmyLX+VI3vRC+90BuK2Ahm5+53mbrZ5ZwhKGJ/CnrxX/39Kz5w2pRwOFsahxZFEeqoP8KCdALOHHwPOPJmqpOnVVVJcv6Jdqoft5rSpT/PiRT+fxg=
Received: from SA1P222CA0159.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::7)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.35; Fri, 15 Sep
 2023 03:18:13 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:3c3:cafe::ef) by SA1P222CA0159.outlook.office365.com
 (2603:10b6:806:3c3::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 03:18:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 03:18:12 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 22:18:09 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 14 Sep 2023 22:18:08 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v2 1/2] spi: zynqmp_qspi: Change flush cache to invalidate
 cache
Date: Fri, 15 Sep 2023 08:47:58 +0530
Message-ID: <20230915031759.28889-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230915031759.28889-1-venkatesh.abbarapu@amd.com>
References: <20230915031759.28889-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: a660496e-7577-4d37-7358-08dbb59a6516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ya0tOoCe2a5A8XX7lkCr1dHwqhNNK/0JbOCp1HgHH0To/5ZZIuHQfD5NqvhVhH4vvKm9v3rsuzZoGoONrEVUfiDAOkOsuxhZ9rSl8PStY7wvZ3h/FoCKzKpLtL0PcXFpEiYXQOuf8Db3AY3nbUwT4FzinrfQ6l6ciFL+1cCjsJgEpl7pVFP7E+bVyBbUNFDsOjWS6UkbhvuHlkf6iwQyCyPgil1FXCox2GEFLTNPAq2UHDtqTuC9X0jVcDcV7Ha4Jfvh31nmqK/YaOzBkQXE78/EeeEku2PwdQ7ePDlZcOdeIrQBOH8N0jWU9ujjpoNQlP7xsfa8kl8P+77VqWO4xfyZzD6NQ1fuZh525hFGZwOVJT73P3xAoL4/YRqpb43LaNUhtIqW5p34S+oH6ZDxdpJQnMR+jV/Zzfo8kJbLNHiP31Gp3HiLU044D2v+VuVa2rnrJ6nlzFFV9+wlGuKEeOmIWbW9smiBDfS6BSCkBVDpMZQtn7t3mXRCPObFls25c1baMY3M0nifYQwCXuF7KC1f0v7vFLAWsQTgZGpW2ElYAlT2BPv9Xs+K/sJDCh6hj51Tg8m1hSG/HQd0za2zXx2KFqupnzzWuWAGdBM49La7okbeO/T7NaiZ2boXZOF6iqMLSZz7RcVWJzyMCuUdDab89krsnjEhh+tXQnipWtCGnz7yW5O076NFRmwFdzatmDcxPZVyiCxi6sDxDIQQgVO0+vHEe/uSvlg8KcqRs78ppy0MPxx9dMSsCGXYOnoUecytIydRiHZVRNdwdix+6g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(396003)(376002)(136003)(1800799009)(186009)(82310400011)(451199024)(46966006)(36840700001)(40470700004)(83380400001)(6666004)(336012)(70586007)(40460700003)(478600001)(1076003)(8676002)(41300700001)(2906002)(426003)(6916009)(26005)(54906003)(2616005)(8936002)(4326008)(70206006)(36756003)(81166007)(47076005)(40480700001)(86362001)(82740400003)(36860700001)(356005)(316002)(5660300002)(66899024)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:18:12.7993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a660496e-7577-4d37-7358-08dbb59a6516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
X-Mailman-Approved-At: Fri, 15 Sep 2023 13:26:40 +0200
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

Before DMA read, ideally cache should be invalidated, so that data from
memory will be updated to cache after DMA is completed. But
flush_dcache_range is being used which is incorrect. Change
flush_dcache_range to invalidate_dcache_range.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index c4aee279aa..a506d15227 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -690,7 +690,7 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 		writel(GQSPI_DMA_DST_I_STS_MASK, &dma_regs->dmaier);
 		addr = (unsigned long)buf;
 		size = roundup(priv->len, GQSPI_DMA_ALIGN);
-		flush_dcache_range(addr, addr + size);
+		invalidate_dcache_range(addr, addr + size);
 
 		while (priv->len) {
 			zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
-- 
2.17.1

