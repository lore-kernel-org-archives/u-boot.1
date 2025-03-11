Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FEE3C28B2E
	for <u-boot@archiver.kernel.org>; Tue, 11 Mar 2025 04:13:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 77BF3806D8;
	Tue, 11 Mar 2025 05:13:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCBWaPxE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5510E807D7; Tue, 11 Mar 2025 05:13:43 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B1AB8801FB
 for <u-boot@lists.denx.de>; Tue, 11 Mar 2025 05:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIVAmEnEv1yTggSl6b8cc91oUr8i93SHjRl43wQm0qSTzNOYj0jj5jx8G5XJfFTPyA6gZ29RPEQM0nP1BUP3vBBYFJSH/9zzazOoWqHNiHHBkx1pi316fI6Q30uOnk4hxYxM6UErbwuBkHnQes0XbhdzpH3ejC4QgiGvWd5zyC+l5ecqWqxfk6ah+PBun+0E9M9HPhmAOe9yVrgK1MsFVkah1ieBR4s83zVOSphS9JQIa6UfPU+XoakyrNugYTQlGg03Qu8cfyLcavRNW+ECr8bPRU4OxFy7l6jxFv2syln7bsE8iHngxBwDGWMFNgvVCt/EO0obX0S/Lg39yext0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNWEQ/RST5OYP6NpYfKRmXWtkRCRisa6K8gSKEnZ5yo=;
 b=f6zpFhit5c5jKU70pBnaSiJGvVIZ7v0FpdR1tfeAVeUgoLdfv1s/+AW7/m5kYySUijk53ngGJzXUTJES2JCSW2AY3SBEFMylD81cnat96e4dBlq3G7FmOT99d1t0pkU8S6zpZhLq39clHWa3mm/9PEo3beT93vlIfsaFCam+3mOYjQc9XQJ9MT7emBm2uG2HfJpEvdjKbL5A4gnhyMnwIxd1cGAoNXxtgg2DePUX47wgg+n1Ghzss/T2n4jBeBRebDdpt+TQwhrSEPHBfigKqBK9YYH16sJY+3uH8BypwLcViaA3phl/8NeDnutrhAfzldKPb0k7vNstPDpOeBghiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNWEQ/RST5OYP6NpYfKRmXWtkRCRisa6K8gSKEnZ5yo=;
 b=WCBWaPxEfbCMz/ARJD3qXNEi1ch6ofNkKkQzMlRMh77CUPCGWvi59O6cR86VJUqBnFuLZpzq1RDtanFvrPVunsFeFkR+XYQtyBR0btby7dH9u3ktfdtDqRht9PUs1AFeDeMYi/UGhqyVWFVbuKTjCGpiH1uoZz4wWx2rua74QR0=
Received: from DS7PR03CA0137.namprd03.prod.outlook.com (2603:10b6:5:3b4::22)
 by MN2PR12MB4077.namprd12.prod.outlook.com (2603:10b6:208:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 04:13:35 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b4:cafe::c8) by DS7PR03CA0137.outlook.office365.com
 (2603:10b6:5:3b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Tue,
 11 Mar 2025 04:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Tue, 11 Mar 2025 04:13:34 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 23:13:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 23:13:33 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 10 Mar 2025 23:13:29 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>, <tudor.ambarus@linaro.org>, <j-humphreys@ti.com>, 
 <marex@denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>,
 <quentin.schulz@cherry.de>, <Takahiro.Kuwano@infineon.com>,
 <p-mantena@ti.com>, <git@amd.com>
Subject: [PATCH v2] spi: cadence_ospi: Add device reset via OSPI controller
Date: Tue, 11 Mar 2025 09:43:17 +0530
Message-ID: <20250311041317.2992862-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|MN2PR12MB4077:EE_
X-MS-Office365-Filtering-Correlation-Id: 894aa06e-292a-4e6e-10aa-08dd6053179b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|7416014|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JhinA7L5xEWCMrGaQfqAlQgg+ebsrzPRV2UfvgTd4nVXEtbIBO382G0lnJFj?=
 =?us-ascii?Q?AAZq5kXp+F3elV1kH61hxuab5fXeO6Pwom7pQYmdhbtjqR9nA59Buw7RCaIP?=
 =?us-ascii?Q?rUSVxCzXLUPih/vp2AcbcIa0BFiSxDXxwM+C55IcL5toFQV8Im2zsRsr3Ifz?=
 =?us-ascii?Q?EZin2H1oDwgpAKf2B3k0VxnONaAz13NrS5D5PvZZenIx7mHY3bbO2+Ja1Tth?=
 =?us-ascii?Q?2z77POwEFyNXPXrj9SBkEiIDDUEJ1DTOpx9d4G2TEvWcCugy4VMkTAdPY+ft?=
 =?us-ascii?Q?1yFOWFo33bK+Bja++JyIHEaRI75iF3INbQdQJ+y8N9wD1WqqSvNQkF2a9dgl?=
 =?us-ascii?Q?cd4aOLTmmsoW66WKTsewSKVzLLIVzEYnX49WOn9ibSC8pFYdOeKiLHunKxyc?=
 =?us-ascii?Q?A91z0B+9vy1pJzzRXnt7+3vyYM+yYgau+7L7Hb2O3n8LUuMLYhoo4dFPu9Qh?=
 =?us-ascii?Q?LSV1imd6lbtdT2lGd6f7PckuXX91LRahoBrIgQ/ynRvrM3b/kZFIV3dcHevZ?=
 =?us-ascii?Q?Bf2JTxnxtmc583Y8nVV8I6F3PCC6s50R2u+ahpneWVwz7apfSpiJ1ILfcpeQ?=
 =?us-ascii?Q?7GwqbRLH548bA0z/EGXhfBCOtMswsBDMCwsxxkqeKb9UR2/LlSiGc9z3jY9u?=
 =?us-ascii?Q?2DzTx64JnjMEBPYEGe+ojJkCy++niNo8Izy6HxMLkfQwRcG5cXU4qLcdb3IX?=
 =?us-ascii?Q?us2GMvOQzQEAO+3EOQEBi8HgYUF26PzKz2GSGZDaIBG7Xn4+LKMy44LMGutG?=
 =?us-ascii?Q?6LazA9xWiZ48UxYwmGafwWDrYgYVRH9CxSLOw4uvmDXLeXAsMq6CTES9sbYg?=
 =?us-ascii?Q?B/KGI6OjrZn7gi0m8zSEnZvqCysAj1nXj4H7rm9TXk22r4fmi4xDCRoSUhKk?=
 =?us-ascii?Q?JixHyVfpwDYqw3iVLet2cJcQt0/SJwWtJCLbMxK/wsCw652d3RAgKEKXIN3o?=
 =?us-ascii?Q?lwuqSvQ+ne4C687+4eSTeDX1KhPFKdaCCFsjT+zsYFla+UqzhNssWyJFzjEF?=
 =?us-ascii?Q?FnBSJ2IK9+rOq4B6tXdpN1hDdTkUJ0a25h1RVMkKeZr5JAphBYxwXGfAPPuI?=
 =?us-ascii?Q?DDFrEo80OOODGRQW1i4efxe8uLbUItyb3YWWqbwU+YckRGU5C7ee4/1m/VNZ?=
 =?us-ascii?Q?zaN/vwykt4Iyh+RONdljmQW25WjHDeROaV/Lqkt2x7sXclgIPDK9RkwriBW/?=
 =?us-ascii?Q?CNw9gzT/ZkbCkNaHWmd43dQEcl4hBqmVF82NJggmv7rSLyDAooadnvMLMjgj?=
 =?us-ascii?Q?i1/IHjxmhpLCIBgUNJkwoEVpBIkeDs+dTc61uiftQ/j8hYVeYCCwcTQ+Tyt9?=
 =?us-ascii?Q?StMOXawxLA9Mk6GYlp1zGzfGwymKB+EMqm6hGrfqYeiorq6V1WBXr0muPr3g?=
 =?us-ascii?Q?p6M6sTdDBPL8a5NT931LSd6DWTqAzCDVGxOb3v1MeENvHzwwUi0HN+6RiMs2?=
 =?us-ascii?Q?ej4XqbaqORmxnzRoiXrWMwXP6HH0oz1amM3BI2q1qRtQVAYMfI2GXxzUm2HM?=
 =?us-ascii?Q?n8dqJcfUHe5/pHA=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 04:13:34.9975 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 894aa06e-292a-4e6e-10aa-08dd6053179b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4077
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
Changes in v2:
- Fixed the compilation issue for phycore_am62ax_a53_defconfig.
---
 drivers/spi/cadence_ospi_versal.c | 19 +++++++++++++++++++
 drivers/spi/cadence_qspi.c        |  9 +++++++++
 drivers/spi/cadence_qspi.h        |  3 +++
 3 files changed, 31 insertions(+)

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
index 623904ecdad..a78c00db4ff 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -33,6 +33,11 @@ __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 	return 0;
 }
 
+__weak int cadence_device_reset(struct udevice *dev)
+{
+	return 0;
+}
+
 __weak int cadence_qspi_flash_reset(struct udevice *dev)
 {
 	return 0;
@@ -251,6 +256,9 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
 
+	if (device_is_compatible(bus, "amd,versal2-ospi"))
+		return cadence_device_reset(bus);
+
 	/* Reset ospi flash device */
 	return cadence_qspi_flash_reset(bus);
 
@@ -452,6 +460,7 @@ static const struct dm_spi_ops cadence_spi_ops = {
 static const struct udevice_id cadence_spi_ids[] = {
 	{ .compatible = "cdns,qspi-nor" },
 	{ .compatible = "ti,am654-ospi" },
+	{ .compatible = "amd,versal2-ospi" },
 	{ }
 };
 
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1f9125cd239..731b6527cf3 100644
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
@@ -310,5 +312,6 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
+int cadence_device_reset(struct udevice *dev);
 
 #endif /* __CADENCE_QSPI_H__ */
-- 
2.34.1

