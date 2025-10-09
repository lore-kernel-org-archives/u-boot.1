Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9004ECCA470
	for <u-boot@archiver.kernel.org>; Thu,  9 Oct 2025 10:35:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 138C6844DE;
	Thu,  9 Oct 2025 12:35:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BWhAwwO1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A8C15844F0; Thu,  9 Oct 2025 12:35:38 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4093844D8
 for <u-boot@lists.denx.de>; Thu,  9 Oct 2025 12:35:35 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=US2MAEz6uNtCYq41I5E5OW9qvPJncfaY5IRXIt0+txj7JOiapx1g3yWp7wNDixi+vnmciMpqKPOSfe4vI79H0QkihsMZbzXbT+3odRkHCPQtEvaiMTknxm3MOugwBjB2Mwdgl/i6pYRJlosD+AW4xmdFBfKesCQ58o4/VtBLjN+1CU7G3E4gdjCfatyJws4ZjOqMpyxA1Go32Mc8Cgw4fbmlBnu6ipAXM3ItKWsJ8/dbjJYuju4d5o8HuLAHnfXzUBVOocfUjMZNPvRarXJpdEYSlRsFWl7Z37bp1e+JOCgvrqqQZxdEsBd29k6c96u/DCV4BFAjnIa0TAH3KSlYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ajW6QGv9Qi49wyLkTWkT1MLTriSNNm1rzmpDmiUWU0=;
 b=uvdBDT6idPR3D3L6DCwwCtmpX46KyPOxFAUKTsl6LBPJMQWne8gWsmhDOG/Nrs2KNALyAMjb0BG4srjtf+Wd/laNED0aZ5oho6pNwoDdEEDFdg+LkmaxV8RDbVQHVld8TTo07JQuBX1FADm5tL3fbn/cDNq1si8O2NrxGP/6RIqUM+7p1pH8bFWb1WQlOEQhWm/GmyzAXI83ZV6rwHWhttns4y64H1CzLpUg2dh1WhmBM5jcoAI2gOZ0Qzg6uHc5M2/kYl6GWMKqECHufWvMCXLiRc3Usap4rp/dlZYznaozfeDMPuWTtOaBhX93TAhDa0EcquY5RgjT2vHWWSZKqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ajW6QGv9Qi49wyLkTWkT1MLTriSNNm1rzmpDmiUWU0=;
 b=BWhAwwO13aYYH5srPE0enHXkaZeW+i9zaggLnNnYj4MhhTnU4T+51hgw4664fPPPb84Ak+qCIuQDyeCVtR7i7joMTiAQmXyeyU49/zRqOSO6ItAUcPT5iptGQwzK6iBe4Mj34enB8h3jkIgNhNsbnn++nq/xDZyu5+xWjldYoNY=
Received: from BY3PR05CA0052.namprd05.prod.outlook.com (2603:10b6:a03:39b::27)
 by CH3PR12MB7522.namprd12.prod.outlook.com (2603:10b6:610:142::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.9; Thu, 9 Oct
 2025 10:35:28 +0000
Received: from SJ1PEPF000023D1.namprd02.prod.outlook.com
 (2603:10b6:a03:39b:cafe::35) by BY3PR05CA0052.outlook.office365.com
 (2603:10b6:a03:39b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.6 via Frontend Transport; Thu, 9
 Oct 2025 10:35:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000023D1.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 9 Oct 2025 10:35:27 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 03:35:04 -0700
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 9 Oct 2025 03:35:03 -0700
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Boon Khai Ng <boon.khai.ng@altera.com>, Jagan Teki
 <jagan@amarulasolutions.com>, Naman Trivedi <naman.trivedimanojbhai@amd.com>, 
 Naresh Kumar Ravulapalli <nareshkumar.ravulapalli@altera.com>, "Neha Malcom
 Francis" <n-francis@ti.com>, Prasad Kummari <prasad.kummari@amd.com>,
 "Prasanth Babu Mantena" <p-mantena@ti.com>, Ronald Wahl
 <ronald.wahl@legrand.com>, "Tejas Bhumkar" <tejas.arvind.bhumkar@amd.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 "Venkatesh Yadav Abbarapu" <venkatesh.abbarapu@amd.com>
Subject: [PATCH v2] spi: cadence-qspi: Remove cdns,is-dma property handling
Date: Thu, 9 Oct 2025 12:34:48 +0200
Message-ID: <6205c6585589b423692b6ed063506b4c51c04c77.1760006086.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7652; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=fkgthvYiy08NA4Y7o0SGxC8yjIVZZv5vZ1DMHnnERXY=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ87z95SD7VReS+f5HDEVF/lz2B1n4iQfpxF7Z+i7Pp3
 b/m+eXQjlIWBjEOBlkxRZbpTDoOa75dWyq2PDIfZg4rE8gQBi5OAZjIrCSG/6lB83b7sD/T/a4x
 L1CjIDoy4e3/mK+vg0Puz1hwKPje7VUM/2tT+vj+SxtFR2qZRpmLcX6LU2kN/v4ibl1bzWVllXJ
 +TgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D1:EE_|CH3PR12MB7522:EE_
X-MS-Office365-Filtering-Correlation-Id: 60500c55-afe7-4d76-327e-08de071f905a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014|13003099007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yIKk2r7V0m0t2aUO3FoNKY/AiaXVTj27ediGvBJ5bg1dUCbXzIUFSkuI+EXJ?=
 =?us-ascii?Q?00X8F4mNb/4QXhk5zGQn6I2HUERxm0139UC+/NTbOiTl6XXhjFdE7UPQr14O?=
 =?us-ascii?Q?n3EuXvbwWlKkyMv18GWzPch2+6wGPm9y9awvyuSxMMi7EXq8zxRqLKFBQdLi?=
 =?us-ascii?Q?Kb0KxhrqYeKm74dX1mXnKdiHRZl/hBNUEEam9xzuZ1T5W7j7O+6m4JfJ/bIA?=
 =?us-ascii?Q?DgP5Cgs/+IP9lDLWDOo1oqxr27N3k6Z1W7Eh8XfP/EuKutHnXdTsemC3tluF?=
 =?us-ascii?Q?2ZII2Ivb/zIi/snpPuHdHGjYTq1rRy3lYUSmloRXvXRt0K1xKh1DEn4Vzml9?=
 =?us-ascii?Q?3lbxQ9XUAxaPqibv5jN7D6Ihmjn+/pXlNHSjtzbYvkzEuaVWyooOylen7m5j?=
 =?us-ascii?Q?tj2sifhYqpd81nxRU6e+xanues5RwalL+v2ag2qddtCbSFsf/04PnKIChdCB?=
 =?us-ascii?Q?iEQ2SH4bLAzWb2AICAS1dmDzm2dp8IH+sb3Cov6kDnpFmCsxXOsA9QTyJfRD?=
 =?us-ascii?Q?vqnMMUfeThAxGPed00N9IAgFSjflrgCJsulYLNXltaYaZrVKJxKBmGGa/xwc?=
 =?us-ascii?Q?i8PdIF7jcTQvK9filwm43xvOVQr75FXT3+2vIYhdkM/ugQLHK3ACTyIYsLmT?=
 =?us-ascii?Q?hRSmsNGNPwXymYSvBOUyLs0bN8385Z5q3xqjGQ+W272rOZP5GqfvTDKwQLjM?=
 =?us-ascii?Q?AQD8gONN6YpeZWEIrsxWd31n8Ck8TTlUxz1DIGg6tR+BcjpyvkNJJcVV/UVI?=
 =?us-ascii?Q?iiawc/nvvc9AGRa0BL/Y2RtCe3p8T9QnldZHHsu88i2DWsI/wbAbzwpJWkMZ?=
 =?us-ascii?Q?FkJr6NTZbSQCdIopwF7HXKRP4NYOMbUJJD3kwx2qBsI5jUy5bpX+I+Hi0hnt?=
 =?us-ascii?Q?zV9EtykFPZjyRN8+ckmhaS3n2o8FDbaAlLDdtYo9kByzjBrOzCAYD5N+LPDF?=
 =?us-ascii?Q?JRw96xbfzJCZ6+c7ZDioi7BVKUxtSQsHz19z7uaZW/MoE3nCl7IRRsSk/Zvu?=
 =?us-ascii?Q?RYaMqsprFGaAq7E0YCJWdz1bvWTvlF6Yq8UZF70YUQLwo+StDE0iedbb18en?=
 =?us-ascii?Q?CK4dZ7F67k3LhkjIPSpCXK7Kr2bH2heosdyqfCCR0/gZbiAJAZfMZmj5KBF0?=
 =?us-ascii?Q?aauh5VhPksTu0eBjgi1fenbPwvS3PWHa0GnWSRdBuVTXXH0gqavHOyF2kh7t?=
 =?us-ascii?Q?bIcVb+iLwPNyPTKtuWOZFUhvmjW1nUpUywSKXys7l5m/7Vn6Uuh10iQ7P9eZ?=
 =?us-ascii?Q?HesyAxZWAlrGlV7s9/+1mQklo+3+VNJXU6WFTz7LrZ7/V7NeOKU2VGRsWz58?=
 =?us-ascii?Q?NATSTZYii2MM4tYEgivE6DgK6btx+yYSGmwtRvb7JLhddPe/GxMElg3kxTH0?=
 =?us-ascii?Q?QRDDIwVtoFID5LTlwZzJEamFHiK/fn0z8xsD3jf8SKHidcY3Oa8de4qlz3xD?=
 =?us-ascii?Q?ZyvMqSrpFvBxAPNwobFlgJdxIE3tL/Zmw+a3qquyybi2txYTg1GB4nVEE5xk?=
 =?us-ascii?Q?9UrOv/GXBbyb3CjXcsaa3jlwnDiwSsK0Jfkl?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 10:35:27.9127 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60500c55-afe7-4d76-327e-08de071f905a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D1.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7522
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

Remove cdns,is-dma DT property handling. Property is not the part of DT
binding and it is also hardcoded to value 1 in all DTs that's why remove it
because none is also testing value 0.
If there is any use case when this configuration should be supported this
patch can be reverted.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Remove other functions which are reported as unused by gitlab CI.

v1: https://lore.kernel.org/r/c6a5b4bfe565668eb3299d5c5a5548a2163b129a.1758786568.git.michal.simek@amd.com
---
 arch/arm/dts/versal-mini-ospi.dtsi     |   1 -
 arch/arm/dts/versal-net-mini-ospi.dtsi |   1 -
 drivers/spi/cadence_qspi.c             |   8 +-
 drivers/spi/cadence_qspi.h             |   5 --
 drivers/spi/cadence_qspi_apb.c         | 119 -------------------------
 5 files changed, 1 insertion(+), 133 deletions(-)

diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index eec2a08e7c70..6991f6a51db0 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -38,7 +38,6 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
-		cdns,is-dma = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index 1c94b352dc97..d2d5ec8e5cbf 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -52,7 +52,6 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
-		cdns,is-dma = <1>;
 		cdns,is-stig-pgm = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 599596f9f087..849bd930edf0 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -210,7 +210,6 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->regbase		= plat->regbase;
 	priv->ahbbase		= plat->ahbbase;
-	priv->is_dma		= plat->is_dma;
 	priv->is_decoded_cs	= plat->is_decoded_cs;
 	priv->fifo_depth	= plat->fifo_depth;
 	priv->fifo_width	= plat->fifo_width;
@@ -348,10 +347,7 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	case CQSPI_READ:
 		err = cadence_qspi_apb_read_setup(priv, op);
 		if (!err) {
-			if (priv->is_dma)
-				err = cadence_qspi_apb_dma_read(priv, op);
-			else
-				err = cadence_qspi_apb_read_execute(priv, op);
+			err = cadence_qspi_apb_dma_read(priv, op);
 		}
 		break;
 	case CQSPI_WRITE:
@@ -412,8 +408,6 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	if (plat->ahbsize >= SZ_8M)
 		priv->use_dac_mode = true;
 
-	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
-
 	/* All other parameters are embedded in the child node */
 	subnode = cadence_qspi_get_subnode(bus);
 	if (!ofnode_valid(subnode)) {
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 879e7f8dbfb8..10c4ad14cc05 100644
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
@@ -261,7 +259,6 @@ struct cadence_spi_priv {
 	bool		ddr_init;
 	bool		is_decoded_cs;
 	bool		use_dac_mode;
-	bool		is_dma;
 
 	/* Transaction protocol parameters. */
 	u8		inst_width;
@@ -292,8 +289,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 
 int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 				const struct spi_mem_op *op);
-int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
-				  const struct spi_mem_op *op);
 int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 				 const struct spi_mem_op *op);
 int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 4696c09f754b..58be017720bc 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -667,125 +667,6 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 	return 0;
 }
 
-static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv *priv)
-{
-	u32 reg = readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
-	reg >>= CQSPI_REG_SDRAMLEVEL_RD_LSB;
-	return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
-}
-
-static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv)
-{
-	unsigned int timeout = 10000;
-	u32 reg;
-
-	while (timeout--) {
-		reg = cadence_qspi_get_rd_sram_level(priv);
-		if (reg)
-			return reg;
-		udelay(1);
-	}
-
-	return -ETIMEDOUT;
-}
-
-static int
-cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
-				       unsigned int n_rx, u8 *rxbuf)
-{
-	unsigned int remaining = n_rx;
-	unsigned int bytes_to_read = 0;
-	int ret;
-
-	writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
-
-	/* Start the indirect read transfer */
-	writel(CQSPI_REG_INDIRECTRD_START,
-	       priv->regbase + CQSPI_REG_INDIRECTRD);
-
-	while (remaining > 0) {
-		ret = cadence_qspi_wait_for_data(priv);
-		if (ret < 0) {
-			printf("Indirect write timed out (%i)\n", ret);
-			goto failrd;
-		}
-
-		bytes_to_read = ret;
-
-		while (bytes_to_read != 0) {
-			bytes_to_read *= priv->fifo_width;
-			bytes_to_read = bytes_to_read > remaining ?
-					remaining : bytes_to_read;
-			/*
-			 * Handle non-4-byte aligned access to avoid
-			 * data abort.
-			 */
-			if (((uintptr_t)rxbuf % 4) || (bytes_to_read % 4))
-				readsb(priv->ahbbase, rxbuf, bytes_to_read);
-			else
-				readsl(priv->ahbbase, rxbuf,
-				       bytes_to_read >> 2);
-			rxbuf += bytes_to_read;
-			remaining -= bytes_to_read;
-			bytes_to_read = cadence_qspi_get_rd_sram_level(priv);
-		}
-	}
-
-	/* Check indirect done status */
-	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
-				CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
-	if (ret) {
-		printf("Indirect read completion error (%i)\n", ret);
-		goto failrd;
-	}
-
-	/* Clear indirect completion status */
-	writel(CQSPI_REG_INDIRECTRD_DONE,
-	       priv->regbase + CQSPI_REG_INDIRECTRD);
-
-	/* Check indirect done status */
-	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
-				CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
-	if (ret) {
-		printf("Indirect read clear completion error (%i)\n", ret);
-		goto failrd;
-	}
-
-	/* Wait til QSPI is idle */
-	if (!cadence_qspi_wait_idle(priv->regbase))
-		return -EIO;
-
-	return 0;
-
-failrd:
-	/* Cancel the indirect read */
-	writel(CQSPI_REG_INDIRECTRD_CANCEL,
-	       priv->regbase + CQSPI_REG_INDIRECTRD);
-	return ret;
-}
-
-int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
-				  const struct spi_mem_op *op)
-{
-	u64 from = op->addr.val;
-	void *buf = op->data.buf.in;
-	size_t len = op->data.nbytes;
-
-	cadence_qspi_apb_enable_linear_mode(true);
-
-	if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
-		if (len < 256 ||
-		    dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
-			memcpy_fromio(buf, priv->ahbbase + from, len);
-		}
-		if (!cadence_qspi_wait_idle(priv->regbase))
-			return -EIO;
-		return 0;
-	}
-
-	return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
-}
-
 /* Opcode + Address (3/4 bytes) */
 int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 				 const struct spi_mem_op *op)
-- 
2.43.0

base-commit: 0cb6970639ee9d3fcff23372d3adfb77e1c5f4b9
branch: debian-sent4444
