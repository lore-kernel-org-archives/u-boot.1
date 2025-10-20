Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736E3CCD199
	for <u-boot@archiver.kernel.org>; Mon, 20 Oct 2025 13:14:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DE6E8334F;
	Mon, 20 Oct 2025 15:14:06 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l/uMlAxa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BCEED807C0; Mon, 20 Oct 2025 15:14:04 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2E0568334F
 for <u-boot@lists.denx.de>; Mon, 20 Oct 2025 15:14:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJVVvuuFP+IXSJ9ixqTzS4VGVCTmCLzDMt/kSgsp7Vlv5szKQKwuTbtI55Iw73toWuP1ewho2ih5ENzq2xXZSbUS9Ns5o6H36zVvlJps/SNe3dElH+DiVmkm7gJEr+zpbZiBMfbf/4hvBAs7mxwdOagXn0NkQu+M+uoS3RcNgQMXHT0IqnHsna5j03Fo44kV7uZKTYenRJN+LoRvUXX2jIVS/XeXYiDH3H4CSJvbOeAidW89Tf11n1uIEWwuZ6zPh49lLmrBWVVaOVd4oRiI5S6eiYTo0rcj9JSCLAxXC3s1vzPfaecXlS7UVO0wyn4IJhzjCnL39+dcE2hYOZRMGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORrPHRxYXDvSXwAqeZh10IZULUPnHlqkMOi6spA4rgk=;
 b=d6iwMBjvpKTSS1FQx8qGA2HIWAtsXgD8pJ5o+9fc6fVIaPCyxrBnkmyTcWR67Y57tY071Azsi8t0eeXW3xN4E+PlYVvp5bqRUmq4lDbI+4iixik4faBM94dfiow08Dm/AQCDXlltq3JmIwB+kjUBHfauauKLcj8oaTQUX/G1rBXmnvzX0vVstMr5hMazDXQRws+J5ODbJnBaA3XFqY52+Zx4yxowvMBfC1+iV3vPP1GDxhsxTJZGoUcJ7NpYxT4glBvjsS6sZJZdLKAkgmiRx3H4cVGrH6CJ/G4OTUHy+yEUTPmAswLEM8mRvMewhRl84XJmOdNdyt3EvRVJGJM6JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=konsulko.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORrPHRxYXDvSXwAqeZh10IZULUPnHlqkMOi6spA4rgk=;
 b=l/uMlAxaQdyY97bEeNWEP5JdZwCUX+xMr5hhBf3DldqT8a36axVy6RF+1r3kq92p5jOD9HZFk2gAEASBJr8nSSu1UM8QSVVdBI5ODbu9Mux9US+BPbhJRf09LFCtLzEl3vB9DoWcMDJkKo/3aAk9LyQFItx5vN95kBVZLOXaiMM=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by DM4PR12MB5890.namprd12.prod.outlook.com (2603:10b6:8:66::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Mon, 20 Oct
 2025 13:13:52 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::4f) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.15 via Frontend Transport; Mon,
 20 Oct 2025 13:13:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 13:13:52 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 20 Oct
 2025 06:13:51 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 20 Oct
 2025 08:13:50 -0500
Received: from localhost (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Mon, 20 Oct 2025 06:13:49 -0700
From: Michal Simek <michal.simek@amd.com>
To: Tom Rini <trini@konsulko.com>, <u-boot@lists.denx.de>, <git@amd.com>,
 <ronald.wahl@legrand.com>, <e@freeshell.de>
CC: Ashok Reddy Soma <ashok.reddy.soma@amd.com>, Boon Khai Ng
 <boon.khai.ng@altera.com>, Jagan Teki <jagan@amarulasolutions.com>, "Naman
 Trivedi" <naman.trivedimanojbhai@amd.com>, Naresh Kumar Ravulapalli
 <nareshkumar.ravulapalli@altera.com>, Prasad Kummari
 <prasad.kummari@amd.com>, Prasanth Babu Mantena <p-mantena@ti.com>, "Senthil
 Nathan Thangaraj" <senthilnathan.thangaraj@amd.com>, Tien Fong Chee
 <tien.fong.chee@altera.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH] Revert "spi: cadence-qspi: Remove cdns,
 is-dma property handling"
Date: Mon, 20 Oct 2025 15:13:42 +0200
Message-ID: <eed1378a51e63a58fda116f8cdf580ebd779ca7e.1760966019.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7440; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=OjLAlEsq26WWpVxBWmWh3l+FrsPxwiGbH18P2Ff49S8=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWR8M20/aLjq/tG4YxE/Jmw6ae66T8M+f0taNEvryit9b
 afbt94P6ChlYRDjYJAVU2SZzqTjsObbtaViyyPzYeawMoEMYeDiFICJvExgZDjCfmBf+AbT160v
 FgbtWHa7S9I4aaPrlBS/8ukvPi6bv6CG4b/PHd7r1zZaJTaZ6XN4LD1Sui1D0Od68wymuzO1DzX
 08nEBAA==
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|DM4PR12MB5890:EE_
X-MS-Office365-Filtering-Correlation-Id: 945adc43-5030-4e79-f71f-08de0fda83cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KyblsWvcxOqdlpwsk4UVgUO3orufH4g7oY9K2Ga6BzylmP/Z3mE+iXLrSImT?=
 =?us-ascii?Q?M38W3BDmjaqhZ9NjsM4GUM9/NqW0P2WjsFO3+rygMHPEVT/YaMo+qBZPoNuP?=
 =?us-ascii?Q?chggv2buESlkzA4uuaxTIAIC9aPjsen2aiByF9cENGNG+ozQHBw3ew3Q6rsi?=
 =?us-ascii?Q?rOk4YLdPw30oeozsTK7tPqtEIfWzxW1tSWhleJAQ/o9d3ExnLX/4MWAv2Skc?=
 =?us-ascii?Q?puReZSFbAHXTOAK58OFIk9VMR9x9YMz6KJtjZ2pnjigQF9wCV2ag3/fWKMir?=
 =?us-ascii?Q?sPupKGaaB/HD4cpoffx24JnM1QBi8GGK7Kwuf1XRcyKHJ6AWDZON29GE3UVl?=
 =?us-ascii?Q?c5u/0MWZg9uxbQ05nhu/G2hI6FFIdLVMKM6CA9WQ09gq3Va2uplp8P9DJPiU?=
 =?us-ascii?Q?06nigA88Bijtj9p02DEoGT+Ha/a4pjF/eqi+VR+IeTS2rsHG16U+J4tVQ/V1?=
 =?us-ascii?Q?iIhLUWEtobCzR4C7qaOyCQe00ING62BhgKqy5ISoqZOsMBxS9T7/Xbp01ZRC?=
 =?us-ascii?Q?+7T2PvH8ofS/7H03I34SW4hGu85T+37srsLxzqUqsuiIxVnCFe/tRMGG5U8+?=
 =?us-ascii?Q?2FAQWUqxmOXwcy86moBsZkNBxE3He12SyAHOxX7YZx2B8lsctf6oqAl/k+0S?=
 =?us-ascii?Q?/3gqdwBSHOZiuoPrT3fgME0oUybWDH4iLbwJPBFNvKte126zOPdlSoNoooPA?=
 =?us-ascii?Q?FlIxc1x2BPH+OLr8jbzOqwc76CbVQkzFlix411G/O82ZEPiS5kBwbXPjXkTl?=
 =?us-ascii?Q?s1myl/pmrJ/AbS8140S9UfZ41w67toDzzZ62bZdrnWnbdOp4lPWQ+AmR0f3S?=
 =?us-ascii?Q?MrEPrzehwsPucBQrofMIKWbR4YDsIh32S22J4uMFe4Fiq9LpZE0KVyqMOBP8?=
 =?us-ascii?Q?mFX5Nh6c1AcrgR8dAto8cvAuqDZKD2Is2fkdOymtsCu3rV9+8gU00wsQyqSR?=
 =?us-ascii?Q?RWJ9kJKRZDQBXRxTV5yaOizEXvDUyElTS5M1bkbZTjW9lnGvBfgybP7daKyI?=
 =?us-ascii?Q?fQ8rGQVgoDfifnS/DEl4UY7a9mlrb2B1/79jmk9+V/HkKEzwJ+WuA88S7PsM?=
 =?us-ascii?Q?OdkWcUZmxN3IqEcXp2v+UWDIAIjNz9tXjM6/mz2081tc3v7Jniwy3aR3tcu3?=
 =?us-ascii?Q?oN+T6jeGEwV178kkgNseRkrJw/H/ipU2lcOpJqvUCSCjvBNuXKkci5Dp/PRA?=
 =?us-ascii?Q?ckXEkWRsK9Mrlv8lAVXEC4Wfk3xi+r6q7bNH4PAD9cqN9k+2X2Z+bQgrTclQ?=
 =?us-ascii?Q?4mTwld09tD7zLZogm6o7mTHW8aA9JLXYwf4onUAyPhDIK7WW3CoH98cBi5v1?=
 =?us-ascii?Q?dPP1dD+XV5u5uINmPZx7Yba+65R3d44K32nNEvPJVoV8qAT04C25KjXFCA9b?=
 =?us-ascii?Q?sTKGudcPOjJg3vXIKeIiIPacC1rePa1Aye+rzk3fcjpI15mBIFFpZJpm8Ndz?=
 =?us-ascii?Q?BfS19VmPXCi54S2cNQe+QtnLWPCG9JAyUgfRCikFMpVNTdd5iUlDHBI/JcjC?=
 =?us-ascii?Q?Hnhcy8cpBR2yNOTC/+0e3OSlPzjfBv9qCrZ3RVCY1E2By6VWlMRy+7hVRLhx?=
 =?us-ascii?Q?oRMSdC2aw0/A7ll5ttU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 13:13:52.0944 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 945adc43-5030-4e79-f71f-08de0fda83cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5890
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

This reverts commit a040578d8270ed8788d7663808ea63ce5ffd7840.

Based on feedback other SOCs (for example Star64) are using driver in non
DMA mode which is causing issues that's why revert this patch.
cdns,is-dma should be removed differently.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Tom: Would be good if you can get this to rc1.
---
 arch/arm/dts/versal-mini-ospi.dtsi     |   1 +
 arch/arm/dts/versal-net-mini-ospi.dtsi |   1 +
 drivers/spi/cadence_qspi.c             |   8 +-
 drivers/spi/cadence_qspi.h             |   5 ++
 drivers/spi/cadence_qspi_apb.c         | 119 +++++++++++++++++++++++++
 5 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/arch/arm/dts/versal-mini-ospi.dtsi b/arch/arm/dts/versal-mini-ospi.dtsi
index 6991f6a51db0..eec2a08e7c70 100644
--- a/arch/arm/dts/versal-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-mini-ospi.dtsi
@@ -38,6 +38,7 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
+		cdns,is-dma = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/dts/versal-net-mini-ospi.dtsi b/arch/arm/dts/versal-net-mini-ospi.dtsi
index d2d5ec8e5cbf..1c94b352dc97 100644
--- a/arch/arm/dts/versal-net-mini-ospi.dtsi
+++ b/arch/arm/dts/versal-net-mini-ospi.dtsi
@@ -52,6 +52,7 @@
 		num-cs = <1>;
 		cdns,fifo-depth = <256>;
 		cdns,fifo-width = <4>;
+		cdns,is-dma = <1>;
 		cdns,is-stig-pgm = <1>;
 		cdns,trigger-address = <0xc0000000>;
 		#address-cells = <1>;
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 849bd930edf0..599596f9f087 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -210,6 +210,7 @@ static int cadence_spi_probe(struct udevice *bus)
 
 	priv->regbase		= plat->regbase;
 	priv->ahbbase		= plat->ahbbase;
+	priv->is_dma		= plat->is_dma;
 	priv->is_decoded_cs	= plat->is_decoded_cs;
 	priv->fifo_depth	= plat->fifo_depth;
 	priv->fifo_width	= plat->fifo_width;
@@ -347,7 +348,10 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	case CQSPI_READ:
 		err = cadence_qspi_apb_read_setup(priv, op);
 		if (!err) {
-			err = cadence_qspi_apb_dma_read(priv, op);
+			if (priv->is_dma)
+				err = cadence_qspi_apb_dma_read(priv, op);
+			else
+				err = cadence_qspi_apb_read_execute(priv, op);
 		}
 		break;
 	case CQSPI_WRITE:
@@ -408,6 +412,8 @@ static int cadence_spi_of_to_plat(struct udevice *bus)
 	if (plat->ahbsize >= SZ_8M)
 		priv->use_dac_mode = true;
 
+	plat->is_dma = dev_read_bool(bus, "cdns,is-dma");
+
 	/* All other parameters are embedded in the child node */
 	subnode = cadence_qspi_get_subnode(bus);
 	if (!ofnode_valid(subnode)) {
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 10c4ad14cc05..879e7f8dbfb8 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -223,6 +223,8 @@ struct cadence_spi_plat {
 	u32		tchsh_ns;
 	u32		tslch_ns;
 	u32		quirks;
+
+	bool            is_dma;
 };
 
 struct cadence_spi_priv {
@@ -259,6 +261,7 @@ struct cadence_spi_priv {
 	bool		ddr_init;
 	bool		is_decoded_cs;
 	bool		use_dac_mode;
+	bool		is_dma;
 
 	/* Transaction protocol parameters. */
 	u8		inst_width;
@@ -289,6 +292,8 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 
 int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 				const struct spi_mem_op *op);
+int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
+				  const struct spi_mem_op *op);
 int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 				 const struct spi_mem_op *op);
 int cadence_qspi_apb_write_execute(struct cadence_spi_priv *priv,
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 58be017720bc..4696c09f754b 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -667,6 +667,125 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 	return 0;
 }
 
+static u32 cadence_qspi_get_rd_sram_level(struct cadence_spi_priv *priv)
+{
+	u32 reg = readl(priv->regbase + CQSPI_REG_SDRAMLEVEL);
+	reg >>= CQSPI_REG_SDRAMLEVEL_RD_LSB;
+	return reg & CQSPI_REG_SDRAMLEVEL_RD_MASK;
+}
+
+static int cadence_qspi_wait_for_data(struct cadence_spi_priv *priv)
+{
+	unsigned int timeout = 10000;
+	u32 reg;
+
+	while (timeout--) {
+		reg = cadence_qspi_get_rd_sram_level(priv);
+		if (reg)
+			return reg;
+		udelay(1);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int
+cadence_qspi_apb_indirect_read_execute(struct cadence_spi_priv *priv,
+				       unsigned int n_rx, u8 *rxbuf)
+{
+	unsigned int remaining = n_rx;
+	unsigned int bytes_to_read = 0;
+	int ret;
+
+	writel(n_rx, priv->regbase + CQSPI_REG_INDIRECTRDBYTES);
+
+	/* Start the indirect read transfer */
+	writel(CQSPI_REG_INDIRECTRD_START,
+	       priv->regbase + CQSPI_REG_INDIRECTRD);
+
+	while (remaining > 0) {
+		ret = cadence_qspi_wait_for_data(priv);
+		if (ret < 0) {
+			printf("Indirect write timed out (%i)\n", ret);
+			goto failrd;
+		}
+
+		bytes_to_read = ret;
+
+		while (bytes_to_read != 0) {
+			bytes_to_read *= priv->fifo_width;
+			bytes_to_read = bytes_to_read > remaining ?
+					remaining : bytes_to_read;
+			/*
+			 * Handle non-4-byte aligned access to avoid
+			 * data abort.
+			 */
+			if (((uintptr_t)rxbuf % 4) || (bytes_to_read % 4))
+				readsb(priv->ahbbase, rxbuf, bytes_to_read);
+			else
+				readsl(priv->ahbbase, rxbuf,
+				       bytes_to_read >> 2);
+			rxbuf += bytes_to_read;
+			remaining -= bytes_to_read;
+			bytes_to_read = cadence_qspi_get_rd_sram_level(priv);
+		}
+	}
+
+	/* Check indirect done status */
+	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
+				CQSPI_REG_INDIRECTRD_DONE, 1, 10, 0);
+	if (ret) {
+		printf("Indirect read completion error (%i)\n", ret);
+		goto failrd;
+	}
+
+	/* Clear indirect completion status */
+	writel(CQSPI_REG_INDIRECTRD_DONE,
+	       priv->regbase + CQSPI_REG_INDIRECTRD);
+
+	/* Check indirect done status */
+	ret = wait_for_bit_le32(priv->regbase + CQSPI_REG_INDIRECTRD,
+				CQSPI_REG_INDIRECTRD_DONE, 0, 10, 0);
+	if (ret) {
+		printf("Indirect read clear completion error (%i)\n", ret);
+		goto failrd;
+	}
+
+	/* Wait til QSPI is idle */
+	if (!cadence_qspi_wait_idle(priv->regbase))
+		return -EIO;
+
+	return 0;
+
+failrd:
+	/* Cancel the indirect read */
+	writel(CQSPI_REG_INDIRECTRD_CANCEL,
+	       priv->regbase + CQSPI_REG_INDIRECTRD);
+	return ret;
+}
+
+int cadence_qspi_apb_read_execute(struct cadence_spi_priv *priv,
+				  const struct spi_mem_op *op)
+{
+	u64 from = op->addr.val;
+	void *buf = op->data.buf.in;
+	size_t len = op->data.nbytes;
+
+	cadence_qspi_apb_enable_linear_mode(true);
+
+	if (priv->use_dac_mode && (from + len < priv->ahbsize)) {
+		if (len < 256 ||
+		    dma_memcpy(buf, priv->ahbbase + from, len) < 0) {
+			memcpy_fromio(buf, priv->ahbbase + from, len);
+		}
+		if (!cadence_qspi_wait_idle(priv->regbase))
+			return -EIO;
+		return 0;
+	}
+
+	return cadence_qspi_apb_indirect_read_execute(priv, len, buf);
+}
+
 /* Opcode + Address (3/4 bytes) */
 int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 				 const struct spi_mem_op *op)
-- 
2.43.0

base-commit: 5946afb20b6409eb72db634e2e61c97e8663895f
