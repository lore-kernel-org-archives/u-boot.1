Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21D61C10DC1
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:36:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F10B887796;
	Wed,  6 Dec 2023 06:35:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AEq7VQ92";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F0EE87683; Wed,  6 Dec 2023 06:34:46 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 298F0876F9
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=clBJ3sz7MX0DD0CtKYbormUguvUlt7iMuHThqj+MVf9c8/I1tcj5sc+1FXrwwvXLCX6vu5ijmGP7T4QLAw779R1RSrhQzgc/ZZRyDQVDFVf8VSdVetOX1xoF9XoH6p2qiF0Dthn+hvIk6c1/0tj2jBU9q5PRat3TYdutkz1vmvKWJTJGapIOTFfZtIoEamEaP+64DOLYV3rfkFWbCBmFu0bMzlb/vB1NKmYckgrjgjqUk5k1AnT+PVt94eDbZUM5jPFj9YZ0v73a+jQmHhED+7XGa1w5g4V/RvfpNZriWVeDUJwDrxW6J97aW7xNGMGA1T4E26JLunBs+T3UnbCkfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTB6NFMd/a06XzZearT9AOP0NxB8B2KGvAHJP+JjBLI=;
 b=KYflhwcQaG+pgXWbWfHu7MQ+T2mWWpd8In19npHDoEyBNsiuuyTVSXuPkZt+j53uO36YGGCfaaAce07sV8L8f0IherC4ksyxEv8ScZVVSdIXSC5cvU1c2zjWcrlWy/PYxZKlgANDcMS+64GjzLw4TLCl16libuYne1cwMcmSkWhrepLWCrNFXlnqFfXHQUfAFAOyBrwSQkEp0/Pg4ffYlO3o6TRNIE6D2ILE3R3NNL89korGT1z3XcxU1m2PfwFxHc0bf30TCf7dsSW1duPpGhwDB4fy15j/XGyVV3eJ6AtfbPJq8Fr6Oqcl5yYMvaB/dp6FI44/U7orxyTVjTC0kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTB6NFMd/a06XzZearT9AOP0NxB8B2KGvAHJP+JjBLI=;
 b=AEq7VQ92jDG4PIyRx5skWH7V7nURI8FCwTtjZ1Ou3YZacpuQc07FNlcFZrQijpx8Vzo3ERhQSM0teUxaVbEu47mmugpNRHAbgt8+pSt2vOSiop7dA5/rLjKZ/M//0dQey1adM5gNktuMi/TEmP9VbFuqvRKFakSby1qb9VQryoo=
Received: from BLAPR03CA0069.namprd03.prod.outlook.com (2603:10b6:208:329::14)
 by MW4PR12MB6922.namprd12.prod.outlook.com (2603:10b6:303:207::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:34:30 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:329:cafe::69) by BLAPR03CA0069.outlook.office365.com
 (2603:10b6:208:329::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:29 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:29 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:28 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:26 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@xilinx.com>
Subject: [PATCH 19/30] spi: cadence_qspi: Clean up registers in init
Date: Wed, 6 Dec 2023 11:03:53 +0530
Message-ID: <20231206053353.3745918-10-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|MW4PR12MB6922:EE_
X-MS-Office365-Filtering-Correlation-Id: d40abb7e-b6ca-4bf5-e5ec-08dbf61d04df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gg7G3mropqHXL30Sn8ap3RkeS/tTBJHRskk6ZNQ5aufHIpZvc+rwsUObBKanclI3n4dlQhG1O0TZbcaTCPbQv9lE3hPKCy+UFLeZnJf4MPM2uRV7RgPyHEPtEgCLkAKikdZzvPbaBzY4XjpFI3M6h0InxwYmuGoHXqwkTa0YnBGzJnM/UMfPn2SYATxbMiptt0RFLsCmIInpCIc2tWh9bdzWPH9j8xj32OWrok1s3FUZyG+DOh51CAvY/G3C01c7vZvL5sybX2rzv0onxM7A9CK6tFJYLcu46/2nVNtiIx+DxoIGUDNVjDcWkYoMuGmO07Ly6w7tzlbuks8NNMUI4WJSapxlSZsoPtcyRmxtvnwKTMfiE4t1OqVyc35o0mK89/KobQewrXDH2WPhauMi2VwVZPyDqUgUGu9NdHRZa2KgWTeG1suIWJ8Z0EotMtg0qx9XRQbJUzDsfVULRCdlS9MdxksNrYrCESA6XVmdPLxp1F0K8k+xVJkkIjWVOgIPdlasFsNIQHw7G8hhHJdhILQzEycHwAccnxFu2Y0rkbeh7XVD5kUY3+pUvDZmleNz/CF0KfbOV1WJkY5bn9omSrYid4iQPSw2AjW5oGe++HWcS83W+xVkiHh7orI5IzMYAjQEhp9gp4wikUcc6QUxFkBt4Nb64XPtm8H4aH8rpMkzA9I3Ih7wziuMUNNIRZt/r6dXXGvvKY+xPtVq/KnThjY+N+mKgEiFTaR+6z/G6/Vp3Yrk9pwINgSvsHmngC74EarXNpisS7CDhI6sp88sRg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(316002)(81166007)(82740400003)(5660300002)(2906002)(41300700001)(36860700001)(86362001)(103116003)(36756003)(356005)(47076005)(336012)(26005)(6666004)(2616005)(478600001)(1076003)(8676002)(70586007)(4326008)(70206006)(54906003)(8936002)(6916009)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:29.8855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d40abb7e-b6ca-4bf5-e5ec-08dbf61d04df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6922
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

From: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>

This patch cleans up the cadence qspi registers in the init.
The register contents may be invalid if this controller is
used in previous boot and comes to uboot after a softreset
(no power on reset). This may cause issues in uboot.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_qspi_apb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 0bb46f6ac2..5fc5279061 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -346,12 +346,34 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
 	/* Configure the remap address register, no remap */
 	writel(0, priv->regbase + CQSPI_REG_REMAP);
 
+	/* Clear instruction read config register */
+	writel(0, priv->regbase + CQSPI_REG_RD_INSTR);
+
+	/* Reset the Delay lines */
+	writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
+	       priv->regbase + CQSPI_REG_PHY_CONFIG);
+
+	reg = readl(priv->regbase + CQSPI_REG_RD_DATA_CAPTURE);
+	reg &= ~CQSPI_REG_READCAPTURE_DQS_ENABLE;
+	reg &= ~(CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK
+		 << CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB);
+	writel(reg, priv->regbase + CQSPI_REG_RD_DATA_CAPTURE);
+
 	/* Indirect mode configurations */
 	writel(priv->fifo_depth / 2, priv->regbase + CQSPI_REG_SRAMPARTITION);
 
 	/* Disable all interrupts */
 	writel(0, priv->regbase + CQSPI_REG_IRQMASK);
 
+	reg = readl(priv->regbase + CQSPI_REG_CONFIG);
+	reg &= ~CQSPI_REG_CONFIG_DTR_PROT_EN_MASK;
+	reg &= ~CQSPI_REG_CONFIG_PHY_ENABLE_MASK;
+	reg &= ~CQSPI_REG_CONFIG_DIRECT;
+	reg &= ~(CQSPI_REG_CONFIG_CHIPSELECT_MASK
+			<< CQSPI_REG_CONFIG_CHIPSELECT_LSB);
+
+	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
+
 	cadence_qspi_apb_controller_enable(priv->regbase);
 }
 
-- 
2.27.0

