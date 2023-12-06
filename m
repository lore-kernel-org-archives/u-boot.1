Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366A6C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9ABD587716;
	Wed,  6 Dec 2023 06:35:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2AOnZkRC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 34256877B3; Wed,  6 Dec 2023 06:35:12 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eab::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0D71087737
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lM7NFRDQf80U/+TX7q7hdXdfF90FYU+44R2iBhQmjIOYODv+H3A5oHpsNfET6guQWy8+bYyPk3qGXP4suMoMmp7rHSA/RHC4gxJtRQC1dLQjg9PfJ99bCZ+2m+VZNHMUDKbPqUBjujuMUEtf9YL1GEoiiQx4YGBCcwnX1vueUyK2TWfjhRWSwdr+xIlSUefpdkbczV4rLC9oCgTL9LsXs4EDDiBoc9QVdrcc/Gzs98c6OA5bmv4H8xi9JD29mKFrQen+mWw3IBSHiCjN2JYsUUVTzeMb4ZBMPtJxAdb0IF508tMByy4JpZ8cbJFczoia1O/oPZTFgpDS7YdvA06VJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ChZc/OlT5tg+fOWmP24IbIlL+pLus2CinvGuG2JUimE=;
 b=Z3cT5IUw9HiY428/FcKd5acepEiouvleMMIYyuZT3RWKwnDDTMeXfy/NI6wcC58o8TceNrupdXUr+Xsmf+LxBtesnZVS8zQOHY+yKLvOU0JBEbbkvTf9EYFmR/fhVsO2EL14tj9CV6swGBbas3d4ZZlaDsbCoF6738IAHsJe2JLImHYNQJ3U4LxDpZEU4tLbOA+WSZLe3oe94N8leZH3VUnMufxA7/PJ3GDq8KFENijaZ1N/ExmwTlVjJM4Ur6Fq0KAQZOLvSSypKgSrTK6rSy/19EfYjxVMALpXEPMWxLgocRItmhgw8xpGBuQokYwqsw590Rjgn1V0jByUSn2W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ChZc/OlT5tg+fOWmP24IbIlL+pLus2CinvGuG2JUimE=;
 b=2AOnZkRCEsnqpFMqsN73FSeCK+ijjxDE+eSRYpPSfJHWYGu8Zur95mC1sca0i2OlNnzoTE7YJhihxqxd9sekjg/EM4DJePN8Yu27RhumsLmZz7+Dvn+tZtAWYIOO0A4aMF9KyaLG2kPxv1kz75MB5V4HbpOyCqCF8NsU1c9Kqho=
Received: from BLAPR03CA0155.namprd03.prod.outlook.com (2603:10b6:208:32f::13)
 by MN2PR12MB4453.namprd12.prod.outlook.com (2603:10b6:208:260::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:34:55 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::ca) by BLAPR03CA0155.outlook.office365.com
 (2603:10b6:208:32f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:52 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:50 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@amd.com>
Subject: [PATCH 20/30] spi: cadence_qspi: Initialize read and write watermark
 registers
Date: Wed, 6 Dec 2023 11:04:34 +0530
Message-ID: <20231206053443.3746237-1-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|MN2PR12MB4453:EE_
X-MS-Office365-Filtering-Correlation-Id: eefeb1a4-75b8-4f3e-468d-08dbf61d141f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: goS5mRiolBJFLTaAEfkG2eGQy64bd7IC+6MTZl1hA0XuBEUAod72XFrSaa0FovvF4nRmcSUeMLouasAbaKys0RGzgO5yrau1s+XTvtXi9iAahFINFZKWPTqoFKQRG86cWua+Kcj61Uv0yEHW1iTYlz0MYnpxxEAgkkEAe5pgG+YoItiDlE3d1tt03VAJHtykc2ZJxhNK3swb3yHOxiQIQkXAdJtXueR6atZK3pIlegRWXTPgTuEa8JnGYHyUgM18XzOiVGYDkxO9b/k+RI9HODB7o4ToqM0U2Ki0+/NN41b1FM1ei1UVV6qPodxOt8anHL0c1W/Rfv5aQfg37zaMR2BMp19sVI79hVCW9WbB57zZgy4mhpjqpc98ezl+/1EPCTkamuh8uu3WojJy1qd+cV1xwLSRvrpwGXnqJDLmH8EC5R7q/KRhKxdYLtCSPk8p6N9zVZLtMM3rCbPBFKB5ZHNVdBS+wErYajs10pnBxHugVJ0eBcayjgtN1nSH9/IzhVH6rfzEcppsREmn5o5nyTnkie5yQ5QjTFhK6SXcptXYn0F/P5htzXM+TuAiKzGXcck8D++nPNyJ5Uvi5v2ReGLkMu3pPf4+KuD5FTtuFfZetq0zGuu0m25mF6ApLmcqIbXSQFXFaPvfxqpBJuL65Fpg2eo8gp8NtLyMIvi/ZKkZQM69coFVWgHydq8ByFiuZdcxyNgZEDXOs0vRt7A+W8BKX+lKXOW5yd3jJ684Welfy+4eYql2IzZRQlzEMBdPFz6Y7Oa4rySTbyj35UdZow==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(230922051799003)(82310400011)(451199024)(64100799003)(186009)(1800799012)(36840700001)(46966006)(40470700004)(4326008)(36756003)(41300700001)(5660300002)(2906002)(40460700003)(103116003)(86362001)(82740400003)(356005)(47076005)(81166007)(478600001)(6666004)(336012)(26005)(2616005)(1076003)(426003)(40480700001)(70586007)(6916009)(36860700001)(8676002)(8936002)(316002)(54906003)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:55.4666 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eefeb1a4-75b8-4f3e-468d-08dbf61d141f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4453
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

Read and Write watermark registers are not initialized. Set read
watermark to half of the FIFO and write watermark to 1/8 of the
FIFO size.

Read watermark indicates if SRAM fill level is above this watermark,
interrupt will be generated and read or DMA can be performed.

Write watermark indicates the maximum fill level of SRAM when write is
performed to device.

These values of 1/2 for read and 1/8 for write are chosen similar to
Linux driver.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 5fc5279061..052d7a1766 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -362,6 +362,14 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Indirect mode configurations */
 	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
 
+	/* Program read watermark -- 1/2 of the FIFO. */
+	writel(priv->fifo_depth * priv->fifo_width / 2,
+	       priv->regbase + CQSPI_REG_INDIRECTRDWATERMARK);
+
+	/* Program write watermark -- 1/8 of the FIFO. */
+	writel(priv->fifo_depth * priv->fifo_width / 8,
+	       priv->regbase + CQSPI_REG_INDIRECTWRWATERMARK);
+
 	/* Disable all interrupts */
 	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
 
-- 
2.27.0

