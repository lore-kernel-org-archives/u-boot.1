Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD090C021B1
	for <u-boot@archiver.kernel.org>; Thu, 20 Feb 2025 14:20:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3F5E58007D;
	Thu, 20 Feb 2025 15:20:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3igKg/yf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 428CB8007D; Thu, 20 Feb 2025 15:20:03 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20612.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::612])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9FE2980077
 for <u-boot@lists.denx.de>; Thu, 20 Feb 2025 15:20:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XyM5pi9lYtyUx4kxxj2HdvvqCwgViHyOYRcGFuAGH+GM9xD8oDF3njT328sfovAXM9m51ypNydHTtt55Y45U6qVoAoJfCmOTUsqtFM8e0RGjv7xs6lfAkfc8MnlhP/yPq8Z7N2D1fKFl239RKMlYPlVAxihP9znrNNl9/9M7JfOvywNBnaDlfsYzoimacnZPw7sReOSOwSwx7MP1ka5It9Y4+c7UVZPy+3zrpUV4X1Icw9mlT9D7vSQ7b45QC/eAvdsRKbAkGR8UvyX4h8Rpnh4p/+JxwPhP7HiTng1rLNi+tDELDAyYuLyzXrm4JU7pOZx2lRcgBfpiISY6FOXqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yRicvnVcl+iekmPWcYVOTdtgBvLaKrlXWF4aYda8+/M=;
 b=Ps7X2pUgtV3aG8etksSDuBWZIVMFMao6qzibURY2FZh0Guc1QVxj7XgD7JOuA9JSS4VGLgD6cPqUJIEkKjkVdq4dcIDMlVRyWJRFnVU+HxbJR5ltUALykITT91WTo733KAIPKab/xdOo3UVHNWur3WiFZd9bAXVYOIzDFdAuq7wyVuqpc6UXvbVcNeaEBldMUxj7U8HEzMUXwi9kgJDqTmPjNWgnDNqvn0ld+HL5FmQAnrVWdURKqYZZlejgzjka9Rzn/iMVNPOGZ2kf39wapKjnFYVB1FgVw9S30kYvS5BRK1aZWGJCpEl5p5qtiG7H6b36gQXKy0WjOvC4qEFHbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yRicvnVcl+iekmPWcYVOTdtgBvLaKrlXWF4aYda8+/M=;
 b=3igKg/yf93wVEVKbhmoSDRdA4Xl91WIKIeTVPeDiIp9fw7L1e5g2+8LkfpL9+XiUFpUEipfhCjjRQzODQjNv1m6FoOWTp5deHUGEViljBSOmMrmIHcpNAcjqSgb5BwzGZdsZPShYQel3fKPTfE+nYE1mtrTI+sMja45HvRbMB4o=
Received: from DS7P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:223::9) by
 LV2PR12MB5894.namprd12.prod.outlook.com (2603:10b6:408:174::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 14:19:55 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:223:cafe::a9) by DS7P220CA0015.outlook.office365.com
 (2603:10b6:8:223::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 14:19:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 14:19:54 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 08:19:53 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Feb 2025 08:19:48 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH] spi: cadence_ospi: Add device reset via OSPI controller
Date: Thu, 20 Feb 2025 19:49:41 +0530
Message-ID: <20250220141941.1509674-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|LV2PR12MB5894:EE_
X-MS-Office365-Filtering-Correlation-Id: b14e8bc8-a3ca-4cc5-275a-08dd51b9a5ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fjAtjtkcgDSeDGq2uCRM0eGzfM+ijRRHv+tCcPytMr+L4q2H4IY0gOlK30WG?=
 =?us-ascii?Q?Gr2hrv85Ep+xaZlR/kA6QW3RRY54xrhZLxJCOq7ytsKQXrL0t9kb1PDNePvZ?=
 =?us-ascii?Q?puKseOVCvkTFzlUmbtGm+Pn+E4F236BOCB1CxjM4DQifbafrr1LzZjEALjT2?=
 =?us-ascii?Q?B7DI6xAX8/6RJZU+6sjHjqr2b3L/2Cyb7qHhKJP2vGiUH9jQ9QP9n/uR/VFb?=
 =?us-ascii?Q?RL5GCLAA6PEt4mZumYxLU48Us7w2QVJgor08c9T1TAli/2cj3uh0sh5dI/fN?=
 =?us-ascii?Q?84IgwZ0cOMVMkUF107WCyMi58Xs8Fso1H+EmlThv15QqtbLUpIsDgsMhwURl?=
 =?us-ascii?Q?+pP6x0LKzE4/7yJcftHByHO6NpegK4wfBHc3MvIK2dPAsUYrzfDgugH6JInJ?=
 =?us-ascii?Q?zsWrJYY/Vt7X3cq3dhURO0IK75LJz5ld7HYVC2FmAjzVw7ilaLqxYULm4K/c?=
 =?us-ascii?Q?hB0qMeQpW3KiFznXyMjK+jeOZ8BVd/tSiUGs9jy+6QDdrEVf04M9NtvvkstW?=
 =?us-ascii?Q?+yB+soI3uSbE8ldNzHARapslCiXIJJ85G795r4Th3n72dmq+IPWnKgGB1wvW?=
 =?us-ascii?Q?TbM/GAafL+1vfg1qQiCmUWh5srTuZhuUdXo0+8Lr+v2uPfBJTk7+y8CUtgLX?=
 =?us-ascii?Q?NhWwhYBZhkeacqvK3+pwb5t+480sm6gxT3mLsHMuXsBUJ/12kgvhFvzW+gp9?=
 =?us-ascii?Q?/CjOUHjEvt+v/uXkuWK4tiQ9d1tHxxXS9Q4Qb8353Bb3WStdAtYV/9vXHhKe?=
 =?us-ascii?Q?mkty1hEL/o8g2fSmXgdbX49YbKTMwfMYEDq3IHRwl3R+IaYivyY21H/8VhhH?=
 =?us-ascii?Q?pd2JJrJzNcP9ZnRZYCHtvswD0Hz412yc1XUS5gW1mJTYk2Zv2zU+U4IJ13Qq?=
 =?us-ascii?Q?wc6KFlpgUsG7KK0N4yCyzhihqYY38Sez/aFNNsFXTSWyyGoWfLIXNvCbEYEu?=
 =?us-ascii?Q?vJYiCRL+Ev/X/0+H+bPnVtn8ZUoI1e8Nwm+2rt8Cy8I21oo13r3ua4XbGhJV?=
 =?us-ascii?Q?gGLSTWwJvfXPTSLKHa+o4b+mLLJ8VMBvDJDQAywdri2Iz8WBnyMKi3PVGGkm?=
 =?us-ascii?Q?RV0R7JIQnThnoa+JaxWY2h6EAl3zDGQ2wyIKBfER5yqevGL5hsD7M1Py3J5j?=
 =?us-ascii?Q?iPSqNecgVw2Ei+SXezfrfoT1osu6qMWU+XMA4DMe4HC4jPvbv0/c738ShzMr?=
 =?us-ascii?Q?yuurA9Ynjx5KDRf8poZ43vnANTNH98/oYf+Z8f6VwMSrhP6mHuM1KGrY3xSf?=
 =?us-ascii?Q?zWMXBuSeQyiUEcxvN2ULls1DNwf63RFEgE36Grc4kdwtM9COiRQo3E0sxmDc?=
 =?us-ascii?Q?lfFmm+TTkFl7iu1wQ7fFzB9jc7unNigR040mLxR2DRFTVxqFNZcAPo+t9U/K?=
 =?us-ascii?Q?RG3ZvmU2kAffnxHSKq4v9oxcZ3XSI9hxNRAz7rA+PEtxehAYnEU/nZGeFcQd?=
 =?us-ascii?Q?nvUY9pT807Ye9cSL0MXZhbvtwe6W7ChcXOTQJuFDEMAbc70ww8ybRlgYA+vW?=
 =?us-ascii?Q?YJMx8w550K6GWt8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 14:19:54.6085 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b14e8bc8-a3ca-4cc5-275a-08dd51b9a5ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5894
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

Add support for flash device reset via OSPI controller
instead of using GPIO, as OSPI IP has device reset
feature on Versal Gen2 platform. Also add compatible
string for Versal Gen2 platform.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 19 +++++++++++++++++++
 drivers/spi/cadence_qspi.c        |  4 ++++
 drivers/spi/cadence_qspi.h        |  4 +++-
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 816916de16d..fbeb0c6a85c 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -204,3 +204,22 @@ void cadence_qspi_apb_enable_linear_mode(bool enable)
 			       ~VERSAL_OSPI_LINEAR_MODE, VERSAL_AXI_MUX_SEL);
 	}
 }
+
+int cadence_device_reset(struct udevice *bus)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	u32 reg;
+
+	reg = readl(priv->regbase + CQSPI_REG_CONFIG);
+	reg |= CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK;
+	writel(reg, priv->regbase + CQSPI_REG_CONFIG);
+
+	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
+	udelay(5);
+	writel(reg | CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
+	udelay(150);
+	writel(reg & ~CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK, priv->regbase + CQSPI_REG_CONFIG);
+	udelay(1200);
+
+	return 0;
+}
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 623904ecdad..05356ad2e03 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -251,6 +251,9 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
 
+	if (device_is_compatible(bus, "amd,versal2-ospi"))
+		return cadence_device_reset(bus);
+
 	/* Reset ospi flash device */
 	return cadence_qspi_flash_reset(bus);
 
@@ -452,6 +455,7 @@ static const struct dm_spi_ops cadence_spi_ops = {
 static const struct udevice_id cadence_spi_ids[] = {
 	{ .compatible = "cdns,qspi-nor" },
 	{ .compatible = "ti,am654-ospi" },
+	{ .compatible = "amd,versal2-ospi" },
 	{ }
 };
 
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1f9125cd239..d7db37c1463 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -45,6 +45,8 @@
 #define CQSPI_REG_CONFIG_CLK_POL                BIT(1)
 #define CQSPI_REG_CONFIG_CLK_PHA                BIT(2)
 #define CQSPI_REG_CONFIG_PHY_ENABLE_MASK        BIT(3)
+#define CQSPI_REG_CONFIG_RESET_PIN_FLD_MASK	BIT(5)
+#define CQSPI_REG_CONFIG_RESET_CFG_FLD_MASK	BIT(6)
 #define CQSPI_REG_CONFIG_DIRECT                 BIT(7)
 #define CQSPI_REG_CONFIG_DECODE                 BIT(9)
 #define CQSPI_REG_CONFIG_ENBL_DMA               BIT(15)
@@ -310,5 +312,5 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
-
+int cadence_device_reset(struct udevice *dev);
 #endif /* __CADENCE_QSPI_H__ */
-- 
2.34.1

