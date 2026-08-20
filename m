Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19DA9C5DF82
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 09:26:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C36414058E;
	Thu, 20 Aug 2026 09:26:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gg6ZqubRttD8; Thu, 20 Aug 2026 09:26:54 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787218014;
	bh=HPiGIzlHjXZU5ZLx8V3LFVBl25oj1l6GXRn12auXPVs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Zh7RNx9//OztZBMrDtFM16GPeMmLmye53hjnTBeY3Ja/+p8dcf5qz00rXJ4RoAVk5
	 DPlyQHl05ZC7HYNXQqtkiTIi806ulWHT1/BLuWdiGms6uVpFMv7woGNnW4SCQOf5xd
	 6z1xy4cgIQZDGwpHz3BRehGr6+clz+wIZXKzSu0ErdPd3vRcL6tj/diIK1J98YCW+y
	 KSh1HP/zLjvpmo/+VJK55zVuiFCvOy8UicZFf6iKLxXSKzm+4kNcriaHPf9CNDBGqb
	 g0AkfnnLHQVcT6WH6i694449EI64/HAtMs65kl/HfS4t047IxZruGTu6FQkk9qumb1
	 pNjDaUSknEAnw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1F404058F;
	Thu, 20 Aug 2026 09:26:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id BCF0239E
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AE5D780C6A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SGrwfk2use_G for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 09:26:50 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a01:111:f403:c110::3;
 helo=bn8pr05cu002.outbound.protection.outlook.com;
 envelope-from=padmarao.begari@amd.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256
 header.s=selector1 header.b=z9iqJ/lT
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73D6280C2D
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 09:26:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+S0Ls1swpubk/5AYJt5GK0h5vHn+nFHArPB180DgBm/vkdfF2E7KuVLzSopoj3sY22c2FGcWLl1WzPoZp7qH6B7DUPewHxZ5WozAT4BajUkjB1+7Cb17ouH7wvebvFH6P9RZ/RCU8RhVTsYwtq4c8369jJXhw/MvD5xh9mSCTAF/3k7gqmPvW7TwwYffCpobSR5PnIxxOGBNqXwF5D9ab+sOjdnHCQZMErEfh15bManiEWcD36qbwkQm66JlWd1VaAHfrV9ti9pk9WJ8nmc/380x5bUURKYMOw1BeJ2nuBDsGW3Po+0fjJl/uR6xbnwiL9T+GXDtAGpwv6HS92R8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPiGIzlHjXZU5ZLx8V3LFVBl25oj1l6GXRn12auXPVs=;
 b=p04l0qx7XkP0mfDy8FS+Ye1bpCcFHziBjvn48zr1JhiP6T5UOzAGTm7cJeIipM/8ALy4jzU6bNTYwBuD3ylF7y01pJvRLsbPWVZQjeAUpShZiHs3RaS3oTgauKRnFawCB22FBWXLNw3hd1XD+/ljBJNDlwN+Y/MUtOF8ocBhxwcn6AX4k7IixtVLNJtA3nY97TQn80ugeGuk21Jo2LPIUEp5FJKzYbFyEcLQs6i81Q1HyZ30M6AL8gZ6jyW0eslcf62ccxQqRMNMHUP1fhLSVXB1oFlHlBdn+c2ykZKOlWZ+Ccz2YIWXEca9G+r1bsIn0IOUKZRyJpIpp/nxSayvWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.u-boot-project.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HPiGIzlHjXZU5ZLx8V3LFVBl25oj1l6GXRn12auXPVs=;
 b=z9iqJ/lT19dgwVpeSif15Yzh3leH7Yb8l7T4g8RutA+e98kU5jc9Cc13PM9jlkXKmdVSRcAlu9OSN//BSKVSHy6RA3lDT7wannltxCUujyqicZ9O4Dk5/36YgmLGWj0vmg0TzStPXmtjBNnwYhcWjateIVUkWM3hhyNuax1Ph0Q=
Received: from BN9PR03CA0369.namprd03.prod.outlook.com (2603:10b6:408:f7::14)
 by SA1PR12MB9001.namprd12.prod.outlook.com (2603:10b6:806:387::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Thu, 20 Aug
 2026 09:26:43 +0000
Received: from BN2PEPF0000A7FE.namprd02.prod.outlook.com
 (2603:10b6:408:f7:cafe::98) by BN9PR03CA0369.outlook.office365.com
 (2603:10b6:408:f7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Thu, 20
 Aug 2026 09:26:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF0000A7FE.mail.protection.outlook.com (10.167.245.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.339.3 via Frontend Transport; Thu, 20 Aug 2026 09:26:42 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Thu, 20 Aug
 2026 04:26:41 -0500
Received: from xhdpabegari40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 04:26:39 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.u-boot-project.org>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Jerome Forissier
 <jerome.forissier@arm.com>, Tom Rini <trini@konsulko.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 1/8] net: mrmac: check memalign() return values
Date: Thu, 20 Aug 2026 14:55:47 +0530
Message-ID: <20260820092623.1647844-2-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260820092623.1647844-1-padmarao.begari@amd.com>
References: <20260820092623.1647844-1-padmarao.begari@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A7FE:EE_|SA1PR12MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: b5dbca49-ca36-46a9-b463-08defe9d25a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Q5iS143KZ4QgHlHoZjU4we1KoGcUvg7Bcaz8o7uD8UT3ma6GzP8IRJ6HPZ/O+l01zpZPGk+0HMv3t9Y/Lf0Q2+/q53NR+HpQuxmLvJPU/Zr47Uj9ej3jrsPlejENjAdPA3xke/kTkuYW1+P121ilAevZxg/btKEW+FFROeMy/eRDgfuwMvwWcXhLeqTPnJVKwQUQIt1ZyO54BtJCOdwI9Dn7BySMdrLrSoNYJXXesinftg+vNzyNOpC6j9Suci4CHoqlHaFSdwnNMFsxZGhXbbzp2RkaHdeNKMqfPdATYRgvIQpTqgv6BSLL60QJJKkqPStsMB1sr3y+OkMPixMErP2QolKg2rtUB7XSP1uAHLO2DJbGngW0TKRsdEdLHIF+tlr/kTxJRxGpMagDHo0m8I5jxCbH7zVt2kI0o3jlwgdxZxtel3vgg/Fu6jsYZG1qdfICnNr7tjMOXInkVkfdsHEWcTWeQRdN4iM/CIlUvY1jBvbaGitgAcKJENTbPf/d0YpYyn9CxuWGDA1PUnfiiHP6HEYELj8B1T9CP8rmSBqolRYhskgplLj23SAHSnXrqXe//vtHXXyijpqWD1JuF8PIT3H+qd8aOZruoaRnVgeU2EMfWLlkezka+WP6MAQ3r7pOgxjvJ+EshkkD9WvxJOUQOWnINggD8JVl8LxcTB/dPs88EnOe8XHjemKdV90MPeARsvevOFuLVzhyYPlpAQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YdU120wpBjReQabdldPzaCfmUCQZ1F5Ylixf9BBCPPrVwrIWjzfbxVpGq+ycbb+tJFZ5ocbKooZSfogrQLR0FHGeyIlCKsVcsB5LAG9IIXbCxFY7zjKv3n2UZgMGT6xVAFTWcO8qylBK0MAZY5XuCXxplFB9fYGCN1h/FiMyIiBJRTkzy9W8C5nMXs5WKrrUfQMpkDUFWN92t/nrPDdFNPIkn2zmegt4PZNp6xznEHrI2XKZ3xnGfi1vKp6pJ7oAThIY7U3/HuhClEVBDufAe1fqoGOU4ioM7P9aZcW7nfU/7tksd7YTzCR78dGcGDOUqmQgkv/xxtvTPvURCYTFfQqQM0FLOflxpmEzlth6mpX6pla+h3MFNtU84xeMa24PnNoOJjxp3BirXp2+zTfsJ3b0YuU77iQ4Uu3E/XyREnnIy7DMikWRgPXTjes1NPFU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 09:26:42.7905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5dbca49-ca36-46a9-b463-08defe9d25a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A7FE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9001
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

The memalign() allocations in probe() are used without checking for
failure. Bail out with -ENOMEM if any of them fails.

Fixes: 258ce79cfce4 ("net: xilinx: axi_mrmac: Add MRMAC driver")
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/net/xilinx_axi_mrmac.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/xilinx_axi_mrmac.c b/drivers/net/xilinx_axi_mrmac.c
index 56f877c20a6..5ff304fc971 100644
--- a/drivers/net/xilinx_axi_mrmac.c
+++ b/drivers/net/xilinx_axi_mrmac.c
@@ -484,14 +484,20 @@ static int axi_mrmac_probe(struct udevice *dev)
 
 	/* Align buffers to ARCH_DMA_MINALIGN */
 	priv->tx_bd[0] = memalign(ARCH_DMA_MINALIGN, TX_BD_TOTAL_SIZE);
+	if (!priv->tx_bd[0])
+		return -ENOMEM;
 	priv->tx_bd[1] = (struct mcdma_bd *)((ulong)priv->tx_bd[0] +
 					     sizeof(struct mcdma_bd));
 
 	priv->rx_bd[0] = memalign(ARCH_DMA_MINALIGN, RX_BD_TOTAL_SIZE);
+	if (!priv->rx_bd[0])
+		return -ENOMEM;
 	priv->rx_bd[1] = (struct mcdma_bd *)((ulong)priv->rx_bd[0] +
 					     sizeof(struct mcdma_bd));
 
 	priv->txminframe = memalign(ARCH_DMA_MINALIGN, MIN_PKT_SIZE);
+	if (!priv->txminframe)
+		return -ENOMEM;
 
 	return 0;
 }
-- 
2.34.1

