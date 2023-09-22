Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C16D7E7D0C2
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 04:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92945863DE;
	Fri, 22 Sep 2023 06:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hRcJ6nPS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F1A286366; Fri, 22 Sep 2023 06:50:29 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061b.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::61b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 383DE86458
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 06:50:27 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPzt1evSjaEYLJKqen9Sac2+LDxkUqeeAWhhajeE/HbqM8aO45mhwM2YdOnlIJWiO2FAR9QF7Fell1EZl//DcX/hBJwIXhizahqQhlSHKiwR2Afq++G9DMMbOQDIJVLT/EjKeNkqkcjxgzY00R1s8kBDg1xXqxW3l2iZrJbgwQBBm/ZsnSiU6A90bANDYXUFUh2Na+IqgbPBnXT2f2Q540TigT8bp+wF+e/gwQCtcxdHqboQXhKltrvriALscTAD/Wfb7lCFXy2qm5JAHt8xxXxOQZ7YLs/aKl/bBxFhBDcr1tdTdAZufwQ/EwHbiA8XiUIogXmkA446h7mbj439Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kXCgMh3zjRKz57FTynmLRgTuJ2qLH7uvFRquK7+lzec=;
 b=QHQdXB5OkwMuidTi2q+DA38JnTQY9Kt/9zJrFhFt8riys2Bp9957BwJd6I6pIDCN0vX/QieAy3AfdxrBXfbX4EffCYmE7Pc0C2U6/iwOAZ+P7kMKwn0SKNcjBF5HtJRGJJ1z24BaMIMDfkVmJInfam+NNvDHf+QCFUI6lE1sFcmA7F5fy5d8gG8McfHp0BzeR6OfML/vXxuOTTndno0vdrMDTkyttCQEr2zjX3oKzAOkcYl8n3ByyoBEtPH0BfLp7s5EfTQLcIUcbQp8YhLHqTwUHviPTyvXcKtfkRhlfZYrJuqzusBGp3suuLOZyVCL/strmPtUY/N5Yt4678+rUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kXCgMh3zjRKz57FTynmLRgTuJ2qLH7uvFRquK7+lzec=;
 b=hRcJ6nPS3OnNG3GSXxTekxSHI/7lW6vcvJUTPj1tMKq7frz4ywV5W8Vz2t3lTKgptSHuNgaOPNIoUiQsOZWILpDdg5w+1JcuaohFrx/4WnSDxAdzsgPqbVDbKgv6Ug2A0yEi2R0uram5B4td60xLYFcMr0sIDDOVgseUjcI0zKI=
Received: from BLAP220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::18)
 by MW6PR12MB8867.namprd12.prod.outlook.com (2603:10b6:303:249::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 04:50:22 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::b9) by BLAP220CA0013.outlook.office365.com
 (2603:10b6:208:32c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Fri, 22 Sep 2023 04:50:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Fri, 22 Sep 2023 04:50:21 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 23:50:19 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 23:50:19 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 21 Sep 2023 23:50:17 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <git@xilinx.com>
Subject: [PATCH] net: zynq_gem: Update the MDC clock divisor in the probe
 function
Date: Fri, 22 Sep 2023 10:20:10 +0530
Message-ID: <20230922045010.22852-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MW6PR12MB8867:EE_
X-MS-Office365-Filtering-Correlation-Id: b521a462-2559-4a36-6aa2-08dbbb276d4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C5hnPy4XiX5adLjvONnMF07IS4zNdvybSkaOS5OMFIKCimfXWbiZShjFPyjPWj27TixOU1rmNK8Wwhb+/nh51JFSYUN8OU92Sw7Pd3j5LfX0LCKnLqsjgPGuvtCatlY1MSo7YcJoHYHDUnXzG2moU9dTvahF0Za7ae1ewLxSWGD9uEqEEQXeGE8ZSzX2Nxh8eDatB/UtmRCVXv+LWzF2Ni3ifCM+AEMlUEwCVJxi50rwGNzwxm7gh3yeXQD8vXPVcWFCrV1x0v/JgH2fqkaU3q5hHU6HEQJ9rl7cHZrZh8Z0kv4FLqd4/jVli9LMsC2rfNo6NHnKRSffEODHU43kz05Ov734HagGFq2xcwCZf9GsQ8zzHObe6/aBoaTb+vcNIICl3zl95WZBLbUfGYBguZaokDO83pQiXTVq3PsuQW27Pb72jVNNSJKgDLTuWmyFRKYBknCCum/XvjQouYz1n7K4IChI3ATOGoGX4O+QSrXnS8DBvdDBif7nTn28Oe4n/2rso4woMlyPt2Vma8pOxQ4j6bJSBoq5BKXTW3XllSfFB3acpEktCc1eqQfhzkkY1QOWEO/uwP9BaxocEt5AXxW/kVyN2BuUT2oY8jdFlpiiS3qLkcvtePfF3fLZonniEgWRPhU2YVVGvD5x02IXelrGHuZNijrHP+rG78xFtPtTYw0rW7XFVJnGa7lE7pMX9hyAqaLtmQvo5lefvW6KUyrmkDWGEGbt/sm9fIP3/dL9dzSEqNNuKJoJfmcR5V3XfTONRHxf/Wf2C2bfK8g/CcLpIRqNWKJqmaqGY3AFkVjxQp6hS/S5fpJetjQuD6ZZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(396003)(376002)(346002)(451199024)(230921699003)(186009)(82310400011)(1800799009)(46966006)(40470700004)(36840700001)(426003)(4326008)(107886003)(478600001)(41300700001)(1076003)(8936002)(8676002)(2616005)(40480700001)(81166007)(82740400003)(70586007)(54906003)(316002)(70206006)(83380400001)(6916009)(336012)(5660300002)(26005)(6666004)(2906002)(47076005)(356005)(40460700003)(36860700001)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 04:50:21.4784 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b521a462-2559-4a36-6aa2-08dbbb276d4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8867
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

MDC clock change needs to be done when the driver probe function
is called as mdio is enabled at probe and not when the ethernet starts.
Setup the MDC clock at the probe itself.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/net/zynq_gem.c | 73 +++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/net/zynq_gem.c b/drivers/net/zynq_gem.c
index f3cdfb0275..f7a7897d9c 100644
--- a/drivers/net/zynq_gem.c
+++ b/drivers/net/zynq_gem.c
@@ -321,11 +321,38 @@ static int zynq_gem_setup_mac(struct udevice *dev)
 	return 0;
 }
 
+static u32 gem_mdc_clk_div(struct zynq_gem_priv *priv)
+{
+	u32 config;
+	unsigned long pclk_hz;
+
+	pclk_hz = clk_get_rate(&priv->pclk);
+	if (pclk_hz <= 20000000)
+		config = GEM_MDC_SET(GEM_CLK_DIV8);
+	else if (pclk_hz <= 40000000)
+		config = GEM_MDC_SET(GEM_CLK_DIV16);
+	else if (pclk_hz <= 80000000)
+		config = GEM_MDC_SET(GEM_CLK_DIV32);
+	else if (pclk_hz <= 120000000)
+		config = GEM_MDC_SET(GEM_CLK_DIV48);
+	else if (pclk_hz <= 160000000)
+		config = GEM_MDC_SET(GEM_CLK_DIV64);
+	else if (pclk_hz <= 240000000)
+		config = GEM_MDC_SET(GEM_CLK_DIV96);
+	else if (pclk_hz <= 320000000)
+		config = GEM_MDC_SET(GEM_CLK_DIV128);
+	else
+		config = GEM_MDC_SET(GEM_CLK_DIV224);
+
+	return config;
+}
+
 static int zynq_phy_init(struct udevice *dev)
 {
-	int ret;
+	int ret, val;
 	struct zynq_gem_priv *priv = dev_get_priv(dev);
 	struct zynq_gem_regs *regs_mdio = priv->mdiobase;
+	struct zynq_gem_regs *regs = priv->iobase;
 	const u32 supported = SUPPORTED_10baseT_Half |
 			SUPPORTED_10baseT_Full |
 			SUPPORTED_100baseT_Half |
@@ -333,6 +360,10 @@ static int zynq_phy_init(struct udevice *dev)
 			SUPPORTED_1000baseT_Half |
 			SUPPORTED_1000baseT_Full;
 
+	val = gem_mdc_clk_div(priv);
+	if (val)
+		writel(val, &regs->nwcfg);
+
 	/* Enable only MDIO bus */
 	writel(ZYNQ_GEM_NWCTRL_MDEN_MASK, &regs_mdio->nwctrl);
 
@@ -360,35 +391,10 @@ static int zynq_phy_init(struct udevice *dev)
 	return phy_config(priv->phydev);
 }
 
-static u32 gem_mdc_clk_div(struct zynq_gem_priv *priv)
-{
-	u32 config;
-	unsigned long pclk_hz;
-
-	pclk_hz = clk_get_rate(&priv->pclk);
-	if (pclk_hz <= 20000000)
-		config = GEM_MDC_SET(GEM_CLK_DIV8);
-	else if (pclk_hz <= 40000000)
-		config = GEM_MDC_SET(GEM_CLK_DIV16);
-	else if (pclk_hz <= 80000000)
-		config = GEM_MDC_SET(GEM_CLK_DIV32);
-	else if (pclk_hz <= 120000000)
-		config = GEM_MDC_SET(GEM_CLK_DIV48);
-	else if (pclk_hz <= 160000000)
-		config = GEM_MDC_SET(GEM_CLK_DIV64);
-	else if (pclk_hz <= 240000000)
-		config = GEM_MDC_SET(GEM_CLK_DIV96);
-	else if (pclk_hz <= 320000000)
-		config = GEM_MDC_SET(GEM_CLK_DIV128);
-	else
-		config = GEM_MDC_SET(GEM_CLK_DIV224);
-
-	return config;
-}
 
 static int zynq_gem_init(struct udevice *dev)
 {
-	u32 i, nwconfig;
+	u32 i, nwconfig, nwcfg;
 	int ret;
 	unsigned long clk_rate = 0;
 	struct zynq_gem_priv *priv = dev_get_priv(dev);
@@ -494,8 +500,7 @@ static int zynq_gem_init(struct udevice *dev)
 		return -1;
 	}
 
-	nwconfig = gem_mdc_clk_div(priv);
-	nwconfig |= ZYNQ_GEM_NWCFG_INIT;
+	nwconfig = ZYNQ_GEM_NWCFG_INIT;
 
 	/*
 	 * Set SGMII enable PCS selection only if internal PCS/PMA
@@ -509,19 +514,21 @@ static int zynq_gem_init(struct udevice *dev)
 
 	switch (priv->phydev->speed) {
 	case SPEED_1000:
-		writel(nwconfig | ZYNQ_GEM_NWCFG_SPEED1000,
-		       &regs->nwcfg);
+		nwconfig |= ZYNQ_GEM_NWCFG_SPEED1000;
 		clk_rate = ZYNQ_GEM_FREQUENCY_1000;
 		break;
 	case SPEED_100:
-		writel(nwconfig | ZYNQ_GEM_NWCFG_SPEED100,
-		       &regs->nwcfg);
+		nwconfig |= ZYNQ_GEM_NWCFG_SPEED100;
 		clk_rate = ZYNQ_GEM_FREQUENCY_100;
 		break;
 	case SPEED_10:
 		clk_rate = ZYNQ_GEM_FREQUENCY_10;
 		break;
 	}
+	nwcfg = readl(&regs->nwcfg);
+	nwcfg |= nwconfig;
+	if (nwcfg)
+		writel(nwcfg, &regs->nwcfg);
 
 #ifdef CONFIG_ARM64
 	if (priv->interface == PHY_INTERFACE_MODE_SGMII &&
-- 
2.17.1

