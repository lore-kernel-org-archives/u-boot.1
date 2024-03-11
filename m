Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C393C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A94A587F2F;
	Mon, 11 Mar 2024 18:23:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C3s6myBt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7C29387E6F; Mon, 11 Mar 2024 18:23:18 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BC2A87F04
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX8B3Qe5r8j5VFwt0rtpx+lH+s3M/sZFsP5uLUyKruikjzIL6oeU1+gRK8HyC9TKrOdbopsRhvZn0wNNXPRVlIC1eAZy+IQiJT6lZWlyPigxzC8HClzmzDFbX9gdFiWJ0fMDsD0onvuVJEWggt/9+uAXepl1OfUZi5dRvsxZrbCA33VB6GluxxvBSccsi9ukzmdqbq7ztiQ4r6ejRBd7g7wiwVT9rsL4sReq6GVckn3Vyy1+PXfCInMRnz/S9jSLDL5Xi50mIVdTMheR4DYs4bsuuvcHpL7D0vGWhnypmt7aUPljihvJXqH2hTbTutO8vKWLA2V8tjtLRdXF9NjmKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VycRJZFp4FhFR0yCQSJaMK9F8lX4hMCrM5dltEFUMvk=;
 b=EXichYHILAYCfQ7DyMQ9zaHdWmhMzt3Wjph9weSxzx58yfd4Lv3YOj+PnTEsE6CfTG0WwYamnlgy5Z9NrJUYSOZnRzZmnrzUroCSal+m4MfxpKBpAxv/bj8/LzlUThbIisWUtdLSj53P6Zz60Ip23wlAHUOZrJNK8a2v4/OvjVI/o64oiLMhTwbN5YtVR2hVWfc5VFAc94ccdtbIkqcz+6jgco7IOorQ957mjTbMmgY4I0hr1dSYnVQSa3pqao576oqw/ZCw59HWBLpfQ5fOFe0t+ql4c0NVRuEdaVIU8PgJ8VKXF83I1nytD8EC8cbHo5AAiZBs/IRh3b3vQTV1YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VycRJZFp4FhFR0yCQSJaMK9F8lX4hMCrM5dltEFUMvk=;
 b=C3s6myBt6zWbjYF8ULxUETS5H+Yp4Zq4Ofkyx1FIbE5m4W3EkD0CExAFFnIr+62GRJ5wltiO5hkdrceNWgTyDSXSA6iNICD/pHeEIA3n0wo+VMSfuABcgAi+cvPusGmROzOX2qTQ25ea8iJDvC6617U4ezBobHfk5yfSO+re3u8=
Received: from CH0P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::10)
 by SN7PR12MB7835.namprd12.prod.outlook.com (2603:10b6:806:328::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Mon, 11 Mar
 2024 17:23:13 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::67) by CH0P221CA0028.outlook.office365.com
 (2603:10b6:610:11d::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:12 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:11 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 10:23:11 -0700
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:09 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@xilinx.com>
Subject: [PATCH 05/19] spi: cadence_qspi: Clean up registers in init
Date: Mon, 11 Mar 2024 22:52:35 +0530
Message-ID: <c6380e5dc56be27d0f2157e9cd9398bdd8f416f5.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|SN7PR12MB7835:EE_
X-MS-Office365-Filtering-Correlation-Id: 1da40b1c-ec51-4467-4bcd-08dc41efedd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hgR3BiQimFLm4T3oP2O/CwTd0zSVk3bs9ryuv0bOh69psLKD+vEE9t0/Q5W4GoHJVpAjj2ALpXyPUbUgEImz8Mfr5Pra502ToEalR9MFBnIDmCcKJq6EeJwromZdeuhIcju5TSAynTPT8r8a0K2rOmUPH0JJPkXgYmjFEWM8eI19E/X33TYFNYxdFkCuf5pO/zl4A/S9WDO4K2Mp2TrOw3ZDs6FNRaGKf5rtpZoETa31sXfcomtRb1rGbo+1Efx7Xn34A0q/EoXcrLGMbOxSfA+nfmCYzwXLV3er0waVcz6hyYTj2clJXoEuOqjNyNlPSECAgpZJxy2QmNLYEzBQfJ0PjgiEWzf7Z6/UdwTek8+aYWe0qf7CgSOpijeTLDCmq4rIh/NaRcKvXc9c43c3zcoq//91PI/sfxsz/wEJmcOBGJSmxmazbfLUxfclle6SX1dukbJ+OTNMPKnKSFS0/jfSC+fM28Cu57j8v6w6SVz9Jfh/zwpVoUBo+TAVfGlUF50tmq7tJ3NDj1QvkxNiGXCs4oICzr+6/GOnrd+qlG39MypbIieWDORtYLDl25o0F47tYQTYDecspMcHuHK2aJLyIDfDYSanN8o5g7I956JDwbJ+AScglFoSgWdlVCytd2VKY7neQ5OpbwVp8dCamqJ5KWnx9/ol3rKUDFssDqkYldaMgrLYcWAYULHk1fZKdL9ln5BJTCMHabLAHXinQAiuuot92mvoHcEB8EL4XjZNlLP4IgJCvqL5PSyxtZgO
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:12.2572 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1da40b1c-ec51-4467-4bcd-08dc41efedd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7835
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
index 7576dacfb0..35a21a2727 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -340,12 +340,34 @@ void cadence_qspi_apb_controller_init(struct cadence_spi_priv *priv)
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

