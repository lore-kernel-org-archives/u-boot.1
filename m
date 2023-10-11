Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26183CD98E6
	for <u-boot@archiver.kernel.org>; Wed, 11 Oct 2023 03:15:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 381E586BED;
	Wed, 11 Oct 2023 05:15:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qG5FzQyW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8A13786C39; Wed, 11 Oct 2023 05:15:40 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2DCCD86BED
 for <u-boot@lists.denx.de>; Wed, 11 Oct 2023 05:15:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9FRNf55TrK10gEkPUdCLFFAyCBHCh1itRi85CZa6A3elmne5h7+OCUkef9sP0qCXr177FfYAneiXn6WzHWljhSBKD0U3AfTiG41ZD7KLeefznvMe14TX0lHs7zCZz1uVkaDRXg+Sfm269olWf37w0aG+TUIUcL98QSyd+qw38qaS2pt5ZwXOWobcDWBIqM0kU0bz2uB8PQ/2egsnxpRK326kGUuWFQEfwddW+t57l2C78hj1GIOMWc78vtAtjxp0WXXmw5Sjl5emeXzeiNYnkAJzWNcijtxJjWyZc7d8RkK8bCJsm3rrjMnu1/Yg2e5/MRRz7JDmwLb/NCHPB/mTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/+9ia3pDcimrNSy4C27LCpeDsfwxLln8wqNyDYZGJA=;
 b=CreWpv90ToeTkuDRT+eFsjIZvMJxXmAonnRJ6akVuKgAbpXOmEPD+IqoIwJBeToKa1Xnbv/CDFCGhbMoOj+Kocqm7i2G5tXkAl2UgKjI72IwgfLnoBlx/qJWiGmxz2WgT/nCiPSL1M6AFTc/D9UBS9yuVpHvXrON1YwEJCZjI/umO2nrNCK/UGfXjG+MGyKuHYtHwV65D/4AlzH/NDg/7rWzwd+N36lP+HjekjwjO/BFPrHMPZ6TcO1nbCHSoNkQY/L9g5lYYdTmTIW45eqactsv1fAjeYRgu9i5vBX+SnmJE+Wjm4z262stj9n1zXQJydXFrPYPY+9sJGNjwUo7mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/+9ia3pDcimrNSy4C27LCpeDsfwxLln8wqNyDYZGJA=;
 b=qG5FzQyW7TVj9wE+fT8eZvjjtrQ1JuR69SQpkDS0OiH47bq1HgLOBKusHIyRoz7aU8AOrvD4iIg5bX4gqboBlm64Q8YtIbJxHcSeFPAH756W2nmcL2CS9ZSNa6cY5tYglNc8vq620FDI4Y2g7i8uj29mh1ku77e+O9OsM2/7YNE=
Received: from CYXPR03CA0008.namprd03.prod.outlook.com (2603:10b6:930:d0::25)
 by SJ0PR12MB8137.namprd12.prod.outlook.com (2603:10b6:a03:4e5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 03:15:28 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:930:d0:cafe::2) by CYXPR03CA0008.outlook.office365.com
 (2603:10b6:930:d0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41 via Frontend
 Transport; Wed, 11 Oct 2023 03:15:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 03:15:27 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 22:15:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 10 Oct
 2023 22:15:23 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Tue, 10 Oct 2023 22:15:22 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>
Subject: [PATCH] spi: cadence_ospi_versal: Add support for 64-bit address
Date: Wed, 11 Oct 2023 08:45:15 +0530
Message-ID: <20231011031515.4151-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|SJ0PR12MB8137:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b276c7d-41a6-4a8f-a3eb-08dbca08517f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L1uWFvNOEXg8eh+B0hySmeloaIhy7Q2h9tlmdfmgdbmXdeHfmZps1VDzCKtxvR2qRZja2lVix2LZ0d1OFiAyK1xHH9KRo0Vy8oZwGBsLMhTUZX1S0dKGgQSk67OZlYN9f8mgfNjPH6X3Ww9/IOfynFWjJHrxwCq3divgq5aQAP9aCQdjIXN+LG51jhwBODEbGadh7bgHvOrNTJgrRErZFjYxtzgg4qACBEV2BRWAjZy7/BwoM8eEJE0eAGzGABpk/yR6tZflyFHatKnli4M0kDsVngt67RK2gI7xAsLYitqWGkbErbhsNPteZQV5Lv9rkwZq6gqanVu0tlpfcjHXSmA/CtyLZNbqwQ2a/m5Mq1JesdzkqWkrbnk3LyS/0ffJSgObnAwZh56ZMG72fRGgLPuwvbZ6iXNzvZGWBkpaBkwqDVVnCxJbR4W0E1TbcsxAbu86uhKcVp40WPOGKTNLdeYpGKu0cFd+b+Dc/b5lUae0/AdU7A8j0Ef7wd/Bxt7cCCN/Ea32+CvEW1rtyWeLXmUQkV0MOcmD9BrZdf+Q81xTI/zMHyVNlajCNzdC+xucmnNdjwducrwGCgoosk9yTIJla++5HGhd97pKUxZKSJtjWJ4G3QdLQhRRXY6OtjG/+3HhoPCg1/rAc2aoWctGyAAqSooydojytRKmt9y72t01JZpxJYu2vwgNeEzcaNP2IzWz8lrbUHF91l58fu+teegym96aVD//fFY/qwYOe0wqEza22xz6Od+pM89B6rrqCk7rn8/ERMw+KxPIx3X8/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(186009)(64100799003)(1800799009)(82310400011)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(107886003)(26005)(478600001)(8936002)(6666004)(47076005)(4326008)(426003)(336012)(83380400001)(2906002)(8676002)(70586007)(5660300002)(54906003)(70206006)(6916009)(41300700001)(316002)(356005)(82740400003)(36860700001)(86362001)(36756003)(81166007)(2616005)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 03:15:27.6738 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b276c7d-41a6-4a8f-a3eb-08dbca08517f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8137
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

When 64-bit address is passed only lower 32-bit address
is getting updated. Program the upper 32-bit address in the
DMA destination memory address MSBs register.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index a7685a2f51..e02a3b3de3 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -44,8 +44,10 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 		       priv->regbase + CQSPI_REG_INDIR_TRIG_ADDR_RANGE);
 		writel(CQSPI_DFLT_DMA_PERIPH_CFG,
 		       priv->regbase + CQSPI_REG_DMA_PERIPH_CFG);
-		writel((unsigned long)rxbuf, priv->regbase +
+		writel(lower_32_bits((unsigned long)rxbuf), priv->regbase +
 		       CQSPI_DMA_DST_ADDR_REG);
+		writel(upper_32_bits((unsigned long)rxbuf), priv->regbase +
+		       CQSPI_DMA_DST_ADDR_MSB_REG);
 		writel(priv->trigger_address, priv->regbase +
 		       CQSPI_DMA_SRC_RD_ADDR_REG);
 		writel(bytes_to_dma, priv->regbase +
-- 
2.17.1

