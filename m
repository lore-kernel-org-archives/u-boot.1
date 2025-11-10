Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3955ECCFA13
	for <u-boot@archiver.kernel.org>; Mon, 10 Nov 2025 15:20:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A52DF83A03;
	Mon, 10 Nov 2025 16:20:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CMCbsPU1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EDDB383A3D; Mon, 10 Nov 2025 16:20:30 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23B9C839B7
 for <u-boot@lists.denx.de>; Mon, 10 Nov 2025 16:20:28 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wMvcP4s8qNXerz6bYH7JEiJpXUeQbMAIfQIVZvASrEORo5055MAWKbGM8l1DW14hJbY7+p35dMV9zC8Fbt+A1m9SsziDauR3NaCnj9XOhjFTTRP86dXscJ9/8Ws/CZxs2IhNp0N++v8YzgH7LC3JCG2zYdFs88Y+TK1cFDCLafvve55yvJggxMC81jYjOqyAp0R8zjZKwjFOMiNk5NsVVxT7Mmd0WyW634cvncVba0Zz5JG3XgU5y6HHJ09U74QHhloDurNte3kvla504pYhCt1lH52JPWCpBiulDsvy5OIcDsUKIrzdw7Ks4gwdWivz0vzsRKzTAl/u2DNxS0hZ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZ5OQRNKoSyk9Tg3RSaDAmXEtoM8XMsPE2I3Kqtrjw8=;
 b=FPWVs0wCofrwhVQVX7N8Ageqk4B3EacoLI/MfVs3FDP715rATr0zrUm2K48K5q2hPRaVP5WIwu7ZjlI0ZKkdUGhJbEVMI9jrPCS7YbtKh4XjQn9rwwxlg3E/QUCG8NVYxbcPm/mtx546PkOr/wtic5NtwEfQK4RA9Oa0y3T4NcEyxP6kf3YXGd0VPpx1nM8TGI3E4lnV20ULX1ciuIB5Zr8K10uivqBXnBjzNQDPKi8ZubyEsrnAySu1vSmzHl+E96l8VBAAXOkvbys/d3OalZ3uP+ZEbrJ6jqloKC6U2U9wDFhnm3G+9ghPTi8CinPfujhFCxq01e3+H88V0tNfiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZ5OQRNKoSyk9Tg3RSaDAmXEtoM8XMsPE2I3Kqtrjw8=;
 b=CMCbsPU1LgSOfBDn/Ei0pbYDRpuzWpy3eO/Bq5GyuQb/lisgGqqK4eINUSd9j6o93OUEW1MwDJAiFJG4dRcMT8LcGKHW3hI3Buf2dtbPn5+KUbL0z/VNvpIBdVqyfNcuqiyYmIaVKeixZXrvLzF2Bd2QRaUBkX7IoTYdiCgYDOc=
Received: from CH2PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:59::27)
 by LV2PR12MB5749.namprd12.prod.outlook.com (2603:10b6:408:17f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Mon, 10 Nov
 2025 15:20:22 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:59:cafe::5c) by CH2PR03CA0017.outlook.office365.com
 (2603:10b6:610:59::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Mon,
 10 Nov 2025 15:19:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Mon, 10 Nov 2025 15:20:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:20:05 -0800
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 10 Nov
 2025 07:20:04 -0800
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 10 Nov 2025 07:20:03 -0800
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>, <e@freeshell.de>
CC: Andrew Goodbody <andrew.goodbody@linaro.org>, Boon Khai Ng
 <boon.khai.ng@altera.com>, Jagan Teki <jagan@amarulasolutions.com>, "Naman
 Trivedi" <naman.trivedimanojbhai@amd.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Tien Fong Chee <tien.fong.chee@altera.com>, "Tom
 Rini" <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] spi: cadence: Remove cdns,is-dma DT property
Date: Mon, 10 Nov 2025 16:19:56 +0100
Message-ID: <f109829793900e57558d98ed22caf80c1a72b232.1762787994.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4557; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=FmlTWX40nn6XLEM3fx2uWZvDLoZSWiTnQOl8hN08LXM=;
 b=kA0DAAgWqwf+8E71EfUByyZiAGkSAp3IdGq+bn0oYX939PpkJINpj615ceiU3XhBwcHm49UBr
 4h1BAAWCAAdFiEElwIsQKz21qUWp1lvqwf+8E71EfUFAmkSAp0ACgkQqwf+8E71EfUBnAD/ctvx
 BI1uWyNDxK8WqB2Hd3g7kF6p9VoMojeZs1fLGfMA/0b8UOLDF5E++u4T9Ou6x0iBxxRtlYkEwRh
 l0fKv6mUN
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|LV2PR12MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: a1320ed2-aa0a-4ac2-b3e6-08de206caa96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3nA2AB0edXTSAoLYo33yRzBQOgsDZ4Zb/ozgDVr5a6cdgWoAoRlhYmO/Y2i6?=
 =?us-ascii?Q?mK/j2jU4u6nFo3Zs+xcoAPlnZwF20LJJwUeKl4m2PCnTY4L++6bf5pQL094U?=
 =?us-ascii?Q?3PHc/Jb9QjL3uidGfa9gCni9CGvLz24ZzXP+IzNnl8PsXsBIpVAY8pKzpacF?=
 =?us-ascii?Q?2hwNCl52xbGS1W314umqKxTr30lnGD+jPUJ6q8fNnqsqe1/5N1M1YAivnzP+?=
 =?us-ascii?Q?peTgMafuJqp2HAR6ZCGDRzhYuy24u32E3busV5QybQoAU6JN+ImxkWwKu3es?=
 =?us-ascii?Q?tigyy5AdBEknVA1fZhSxe2VrdSzkvCuRtp44Rv09UurayqKp2HGLDY1VUKk6?=
 =?us-ascii?Q?beohZ6PqArPmpBkuRKzk9+XhbLhohbV7fOVBTUUPoxeJjam2RNGGvFH4J1jG?=
 =?us-ascii?Q?Lr+JqtTKcPzujRTg7hdlGTwYvFVNJe/tbtdmW7F0shVASVghtKK0nYFy1Oqd?=
 =?us-ascii?Q?LzRmJyoUousHoo0a5fRbmZFxOB5x3MiNh5yzz/b21B7urD6G6D2VJXh/OWOD?=
 =?us-ascii?Q?6ekUE8gn1nkNwb76Yg79ZSdF/xTYD+Pd8ggUaQJBgYVO3Y/PGhNpub7Vhq5Y?=
 =?us-ascii?Q?KzetLRnNrNFQJ55qkrVVTFbQ65FNqOnjeZjmmRvXGW9NgDCGQIHGgZe+6EZg?=
 =?us-ascii?Q?U5k0g2Qfr0fmha3oO2gxI8KKNm/iBYV5h7/9gVkuDO/jrjELcqYDN1AZ+O4S?=
 =?us-ascii?Q?RedAznY6z+njNu7FYmDNznuAdJq2uB5YSGs/huRmLb3q2snFKVn+NpU5L3TP?=
 =?us-ascii?Q?481DieIyqU1Vl7nQ48PU+P+Sr2EZfcY7FheDdwoFF2NB3MmmDwXjODQSSzId?=
 =?us-ascii?Q?YOTVYrdV/qzfDWx4gjP6qbWDACuxKQxpkv69Q1fqdX01c0wWruvV6WHvgxAF?=
 =?us-ascii?Q?p8o2osm05auX8vJFiYZjSu0mxyF9HbxlJsihK11WUaz1DNj+vilgtfFHpibO?=
 =?us-ascii?Q?6grPI+SfR4CzN2bzCRfzshWp0PM0aZNmlr/cgShbSiYXr1PhrrFuCm9eWjiJ?=
 =?us-ascii?Q?G+Grl7CkyUTcircULgjFEqtB2ae2cJV5f6ucfwc6UxhguNaFqO7DkSAl8E5B?=
 =?us-ascii?Q?FwK6vyN2uF7zujNeEXinBA6fSwcDyAP1uDSMGta+fk9II9Zkb0srD+MVr4cO?=
 =?us-ascii?Q?pfjVWDIvmB9zZvrTmKw2psh4TAYa/rTcZvZuP+7VJeidAEUO+ShQDDTALyi/?=
 =?us-ascii?Q?++s/+Ad2llOj3q81heqW5DLOQZPDW7J0YxeqCirwx0LDeCR5y8f61pTAgItc?=
 =?us-ascii?Q?pYr0mhK8Kd7zc9vj5wJfMJKmh9RHYEr5ysZ5hajObIGUyIC082PtjE48U55I?=
 =?us-ascii?Q?rsT+3qplUHcvD0R8x7soVmtsIS+XxxEuYVefy44k5zn6tl5seJZLqicwNxP7?=
 =?us-ascii?Q?JFRtHEDW5cQqYBoCtO2s7cwyG0vkMka/xhg0HDzNXi+vRkwHNuvMxjWBGEPT?=
 =?us-ascii?Q?+gVz+THAHGRzd7Zs2ANdDpq1k9lHUThvs8gPK7SD6EtlcIBuF8Xermx8wi5o?=
 =?us-ascii?Q?78rXQZmn7RPsxPuyuWNChk6ADwSby23VkZFK2BHKZeMCckCox2fzPd3N2AhF?=
 =?us-ascii?Q?kgVm0z5WurG8Ul6yNqg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 15:20:22.3215 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1320ed2-aa0a-4ac2-b3e6-08de206caa96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5749
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

cdns,is-dma is not documented property that's why setup CQSPI_DMA_MODE
quirk to enable DMA mode based on compatible string. And also change
compatible string for mini configurations also with recording compatible
string in the driver (Compatible string is already the part of existing DT
binding).

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 arch/arm/dts/versal-mini-ospi.dtsi     |  3 +--
 arch/arm/dts/versal-net-mini-ospi.dtsi |  3 +--
 drivers/spi/cadence_qspi.c             | 20 ++++++++++++++++----
 drivers/spi/cadence_qspi.h             |  2 --
 4 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index eec2a08e7c70..8429dc585d51 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -29,7 +29,7 @@
 	};
 
 	ospi: spi@f1010000 {
-		compatible = "cdns,qspi-nor";
+		compatible = "xlnx,versal-ospi-1.0", "cdns,qspi-nor";
 		status = "okay";
 		reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
 		clock-names = "ref_clk", "pclk";
@@ -38,7 +38,6 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
-		cdns,is-dma = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index 1c94b352dc97..78404960f2f3 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -43,7 +43,7 @@
 	};
 
 	ospi: spi@f1010000 {
-		compatible = "cdns,qspi-nor";
+		compatible = "xlnx,versal-ospi-1.0", "cdns,qspi-nor";
 		status = "okay";
 		reg = <0 0xf1010000 0 0x10000>, <0 0xc0000000 0 0x20000000>;
 		clock-names = "ref_clk", "pclk";
@@ -52,7 +52,6 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
-		cdns,is-dma = <1>;
 		cdns,is-stig-pgm = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 9b45cab9c04c..892dc3557a5e 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -29,6 +29,7 @@
 
 /* Quirks */
 #define CQSPI_DISABLE_STIG_MODE		BIT(0)
+#define CQSPI_DMA_MODE			BIT(1)
 
 __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				     const struct spi_mem_op *op)
@@ -210,7 +211,6 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->regbase		= plat->regbase;
 	priv->ahbbase		= plat->ahbbase;
-	priv->is_dma		= plat->is_dma;
 	priv->is_decoded_cs	= plat->is_decoded_cs;
 	priv->fifo_depth	= plat->fifo_depth;
 	priv->fifo_width	= plat->fifo_width;
@@ -227,6 +227,11 @@ static int cadence_spi_probe(struct udevice *bus)
 	priv->tslch_ns		= plat->tslch_ns;
 	priv->quirks		= plat->quirks;
 
+	if (priv->quirks & CQSPI_DMA_MODE) {
+		priv->is_dma = true;
+		debug("Cadence QSPI: DMA mode enabled\n");
+	}
+
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
 		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
 				  ZYNQMP_PM_CAPABILITY_ACCESS, ZYNQMP_PM_MAX_QOS,
@@ -412,8 +417,6 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	if (plat->ahbsize >= SZ_8M)
 		priv->use_dac_mode = true;
 
-	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
-
 	/* All other parameters are embedded in the child node */
 	subnode = cadence_qspi_get_subnode(bus);
 	if (!ofnode_valid(subnode)) {
@@ -473,6 +476,10 @@ static const struct cqspi_driver_platdata cdns_qspi = {
 	.quirks = CQSPI_DISABLE_STIG_MODE,
 };
 
+static const struct cqspi_driver_platdata cdns_xilinx_qspi = {
+	.quirks = CQSPI_DMA_MODE,
+};
+
 static const struct udevice_id cadence_spi_ids[] = {
 	{
 		.compatible = "cdns,qspi-nor",
@@ -482,7 +489,12 @@ static const struct udevice_id cadence_spi_ids[] = {
 		.compatible = "ti,am654-ospi"
 	},
 	{
-		.compatible = "amd,versal2-ospi"
+		.compatible = "amd,versal2-ospi",
+		.data = (ulong)&cdns_xilinx_qspi,
+	},
+	{
+		.compatible = "xlnx,versal-ospi-1.0",
+		.data = (ulong)&cdns_xilinx_qspi,
 	},
 	{ }
 };
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 879e7f8dbfb8..1e9081c2d17b 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -223,8 +223,6 @@ struct cadence_spi_plat {
 	u32		tchsh_ns;
 	u32		tslch_ns;
 	u32		quirks;
-
-	bool            is_dma;
 };
 
 struct cadence_spi_priv {
-- 
2.43.0

base-commit: 21da4d59b629d4d756c307dc278508c9e2f5dfdb
