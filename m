Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7FCC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 09:35:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0C75877E9;
	Wed,  6 Dec 2023 10:33:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2E0t3Gfw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B2EEA876F0; Wed,  6 Dec 2023 10:33:34 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 91E2B86CF4
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 10:33:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJAtxKVFMnz9PJaQIvZS6Ocldea8l229NqB5Rn3wdp4yFC5FpDMeHoJFW5xJulvdPvwI5iT7kPgEvykgJN59HuvOgHZiLRTVbTJwL8YKQ6FFoC+M9nvzihT0Qc2g/G/0MqaPNt8DnFwwZ9UVq1m168ugjOGE2urQMfI/GsnayYowL/7L8ee9irRUnYIV/dhxuAK5uETYQ751U7SuCJZNWn0JoEydnBkdyblQibzElyMr2lW6WLKZHjk/LTV6zte3hlQaTuXi9vNP1+jhL3qbQL0m7YWkZqUh7uQEj1iIqQvNSBRTnekEWmeelFucIi0a60silRXMA7AH2Z7nYt5O+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wTB6NFMd/a06XzZearT9AOP0NxB8B2KGvAHJP+JjBLI=;
 b=SPYorC6NbEW9wJYR+PR3WFPPFhq9EpnVpXNh+P9QdZckm+V39XXNg4F0bPE29JQogDd9Furzu+w6jxRQRZR66CW4A2cDjzPuGDuxH7KhvyBT1zqe9gut+xxwnqME/1Z4GmPP+o5r4tWzoHqokYM0InIhEgDrukN3fdOb5tj+zvcs/NAWqkDqdU6euJuqZc9jnXXEdvWyZVcpjz5xzoarB2oT/8+fd/EJC3LQ3e+7kX63DxW5e3MUnnlrRx6pd2LmaqeMibh9ei6akuCYX0/aTsaTf4Kox2fWWbEhBGRi5yhkHyCm063wYOruymZIyQ7YdQ4U9kdMS8o9DQxFCJJI9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wTB6NFMd/a06XzZearT9AOP0NxB8B2KGvAHJP+JjBLI=;
 b=2E0t3GfwM2WPz/tRB5LxQSwemkTqkoogEMcCf4gPcDDmlaHBDDOcFOk1ZHA3Dzt6I4NUIfzuavN3puoRCyPBq8t9XuG/l2WQzmH8QPAn7bwPTJDN1n/P94qr5ao2zT4JZn5r/+zIT8vw6beXTpLpcgnNY+1h1AeYP1btnwmpjRE=
Received: from DS7PR03CA0223.namprd03.prod.outlook.com (2603:10b6:5:3ba::18)
 by CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 09:33:30 +0000
Received: from DS3PEPF000099D3.namprd04.prod.outlook.com
 (2603:10b6:5:3ba:cafe::a9) by DS7PR03CA0223.outlook.office365.com
 (2603:10b6:5:3ba::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34 via Frontend
 Transport; Wed, 6 Dec 2023 09:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D3.mail.protection.outlook.com (10.167.17.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 09:33:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 6 Dec
 2023 03:33:25 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 6 Dec 2023 03:33:23 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>, "Ashok
 Reddy Soma" <ashok.reddy.soma@xilinx.com>
Subject: [PATCH v2 19/30] spi: cadence_qspi: Clean up registers in init
Date: Wed, 6 Dec 2023 15:01:30 +0530
Message-ID: <05ef7927ad845ba74385adcf92706616e8647590.1701853668.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1701853668.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D3:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a34792e-b5b1-41e5-add9-08dbf63e684d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50RudengTaQKp48rpzTq7dI4EPJvG6cHKj8+Xo+9mRJMprSdFgUnUsKXu4o/eQCFyq27ZGwv7kisFWEi7MDM4rSwUKfq5okVfUFszf+ZZRs8By2Fz1QXS9m8x9t8W9RDf6Oqwbv2BKe7JmW2wTsVUBhm4Kri3Sd4D9p7UqTWeksvXgtoMnfif1AZ2DEvixBRxGs8XwBcnxTz+gkGu+JJQfQbeqeZ+ZCFQXWBe4UfZVIgAS3mfH21diOr8do5f9ah+6YF1hmc/8gP6FH/CoNJNHnZaf3mWfcSpwJiRuDYDfSVs/61iAfRhijN8OeUSmzhSe9uMNfxXNjLzaSdgjnejRf5lT5BtwBndyuNLiAvq+hKkoY8QFpj4TrFR+qqLAZQmzXFlt3eNw/akSiV1VXjziFl0d7AId2cDg4bDQ18MfxtJhUZGyyjb5VpVXUjP+UokHu6t0umRSlbVuiWBd5cTuJQ6zDF5u2igJxuZimVSkLDSzLlVyNaqijeQzjgZbJmTDMVNT2QDRXylGcS39TfdmKCyMeApXpRNP+grMkAH1j85tSzAvuQN89k4pDtFV6oQmi4SG1r5v+Opu8uZtEOG9FyE5Um+iK9/xBOZn3yqnmlzIZHI42LYWmpDSIRgPQ2nMwqycCTx0Ul8w2Zu31kBVewlFyWzgGzXiwl/eQRHm291jy/wwLycJ5gmn+Lj1W6JqmdutiyEtCdpI1xSmGyjzV4H51mBJHxnnrleFTFbLmGKluNoZbEDmbj9PEuwPb+iO6HhGW1EVs4Wf3nB3zMWg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(1800799012)(82310400011)(186009)(451199024)(64100799003)(36840700001)(46966006)(40470700004)(36860700001)(47076005)(5660300002)(356005)(81166007)(82740400003)(6666004)(86362001)(36756003)(8676002)(8936002)(4326008)(41300700001)(40480700001)(2906002)(426003)(40460700003)(26005)(70206006)(70586007)(2616005)(478600001)(316002)(336012)(6916009)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 09:33:30.0602 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a34792e-b5b1-41e5-add9-08dbf63e684d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040
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

