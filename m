Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6619CCFA15
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:57:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A06D88D38;
	Thu, 26 Sep 2024 06:55:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ApLd4Ppp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 068E788D35; Thu, 26 Sep 2024 06:55:47 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20605.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::605])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B90BB88D1C
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n3SBk1Zqm6FbybqYav+9iOmOmhxGRn1RDyOQOj6AoCt/GqEqDq1PjxZafUO/g+sNTISxm2ddqwDV0xty7sOnRS+RR/i2kzbpogNVPDnuq6gHfQsgXGHfgcBXcqCIVbHdZLulL+67PYuzNNfrosoOrU6Fq4KglxlGki94Q9Qs1cZvNRy0tLSXWBrPRGGEPh5D82Lhpsi7m5ZLgulszfUrRFDRhuq3kuzqOyQnLz0A59a133k2mqoue/FruRVSOgIe2F5VlE0sUto3kM2viCvTVqp0lpiPEuwa5HE4PFwEO+dGaXTky3kPpG+JzUg2R//kAzmu0fvIU7/pzk5poewCYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMYMx2CpL6XMOFGy12gs5P9FknIOfI6QreIpOcB20ho=;
 b=rULhY5e2GVVU6NqLdB6nLMMjP6q8OchJPSqoFztdYTj6UaaGarLmC1dfHdqDDHBF3FRSjMujnbYvLp6K77EC7yi8REFs4ptyrA5qKNFtA3GxaTTpkhG+8ZVZPA6tuyv2YEnan2u7wxQ0j0vCSYOM4D/LwR0qReHtDGx00Y/GaddcjRbSS50o+HuqXldjCFRT5bh0F0tKvtjV4KkRyQBs81Km2rXQQnzCvn+75DzPrye3SfInC8OL8rWZ0f/TNBqagMHZqqNEAlE+IeSiOmMOnZXzXYf9W4NQC2V28trWbaOJpr2KEyjGxJN9rWMMLX5gSnTCE+A/Rm86H6STasBlmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMYMx2CpL6XMOFGy12gs5P9FknIOfI6QreIpOcB20ho=;
 b=ApLd4PppH40amHC5EqEsnqX57oleqMG1aKQwNTQ0uQUz3Ujp0Syq+ZJC2hSH8BJN3WiEkZc1ePbtgtmIglGZQWp/w1mXkBkvdReqaWPBxDdlwujkleqv2J0vuHh42s2yTQl5HZuaaqyYcsJ0qtxTsfsL6JvuNtaDYpUZeZlYIEs=
Received: from PH8PR15CA0017.namprd15.prod.outlook.com (2603:10b6:510:2d2::7)
 by SA3PR12MB7857.namprd12.prod.outlook.com (2603:10b6:806:31e::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 04:55:33 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:510:2d2:cafe::4a) by PH8PR15CA0017.outlook.office365.com
 (2603:10b6:510:2d2::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.20 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:33 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:31 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:29 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v14 6/8] spi: zynqmp_gqspi: Add parallel memories support in
 GQSPI driver
Date: Thu, 26 Sep 2024 10:25:06 +0530
Message-ID: <20240926045508.1492638-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SA3PR12MB7857:EE_
X-MS-Office365-Filtering-Correlation-Id: 500cad95-17c7-490f-c561-08dcdde773ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rEXn5FkBjGLlLnzHEc/uuBdCQWPWsdqGTn/jadwqJi5dzfm+nrvQb7IzOxhn?=
 =?us-ascii?Q?UwqJOv8Cn8wBSXE7FL4ru+e4uNUSMvzt8yb3VcrxV9lfdBoEqjFeyOM1AffI?=
 =?us-ascii?Q?sJbMaY2zfy4FQhk4DlVeJLz0czV8/FNRN1WFjUMtsQWruQMhsmeymqXEHdUw?=
 =?us-ascii?Q?nSey0qwdNi8A4Q69CfXetDgM3LpMYjiEZCDBzhg+tVDloHigGywzHshw13do?=
 =?us-ascii?Q?v04aT+fRuC+09HR85qahFsJEZ15ruDkpm2ufkOIGReNw+2qXUvF3UyNtjPQd?=
 =?us-ascii?Q?iv7agCCPjtNKjyPWP8bOxxQe70wDOI0LxAwbXMtxZmgKEH9q7jCHbR+uJAh8?=
 =?us-ascii?Q?2ig9jRTn1y3laYKWukV4YgZg034vbvXRObb6x+jHx6Tn5912ih0r4tRjIhbv?=
 =?us-ascii?Q?Mq9kxsOdETHi7FzDaPyHlTPusEZJMvva8h7v7gcfUn1sPJ6f0+4jd/8a7sb7?=
 =?us-ascii?Q?HQLFxwbNLdxy8qx4D9kQlWihaeK/4pRnWVg66ZE83vfw305mG/WjC7gopx/U?=
 =?us-ascii?Q?I+SmPELgFN4woJrWgfGTwgTuwDCImPBOBbj2Dr3UDTC4Qc33d4CE80Wza1oo?=
 =?us-ascii?Q?xEaRBw5NcUTbZzXn+eMRPhpbArMkZ1vnpmxDXBEXnaCK5R3cMWVWW2V3Ee2H?=
 =?us-ascii?Q?fMruVkt7YNxI/YBCxzwb3LOzPzHtli33kWtN31M4iiAhiyMSFXOHmMCwBYv6?=
 =?us-ascii?Q?PaE3Us+5eEvUsWrwPgqy9ZTWhS4mXvNS5VD0HLK2jfrGZIjiHfj8EUiEAHLP?=
 =?us-ascii?Q?KGDDk4sdBE8M3YLV//yTjFfeLMzP2HBR0Z85V6TtoPP+ZeYtqbdYQNsufbRK?=
 =?us-ascii?Q?UH2ts9cOswDlttxtyI9CmcCsK7498le1lqpzhcCvwhI5TYY7vxbV/BXIbkcl?=
 =?us-ascii?Q?7evOSrIiHMqrY6pDtfuLHokmbiL+vR2f3k81a+qcIhlm7OLBV4d8P2jvAdm1?=
 =?us-ascii?Q?GAhrydh0okZp15NF0xZmZcLjFnVTWCFK5vqCK7IWByK+4nx5SYWTQLEstMi1?=
 =?us-ascii?Q?gO0qcuF8HxEmUsOLmABJ5fDAr+XhMeNEiyDszIxGunV9eevaeZn/EihH92lY?=
 =?us-ascii?Q?pBmjfYuvIT3dRWo/TBpozznEfXgTQKYP2X8SIoc+a9W1R5WbbOZWKBajMUwM?=
 =?us-ascii?Q?e+5hnmTOdm+q3IVW+3vE0/MDUmWOXNQYo8XW94mfylxMVGCasHLFT1FP+/Z8?=
 =?us-ascii?Q?ZK/n+/LtJOZtxnMGH6FjV7D7EQrjCwG2ImTNITyczGi1ZnG5zRZ26ARaiHy5?=
 =?us-ascii?Q?YHwayfB4WBUuQ6UP635XprTuxKzsQ17T6pcgf0krA/ICaq6c8sag4Czmiqw9?=
 =?us-ascii?Q?fFLEh6A/PVC8EhJVxSaoUCrbzjLwDkenkXmjrxQ0/STyOw+D3ThzoDqFCsBE?=
 =?us-ascii?Q?m3/watd54V5RLFlr0viCwk5LHtJi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:33.0820 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 500cad95-17c7-490f-c561-08dcdde773ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7857
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

Add support for parallel memories in zynqmp_gqspi.c driver. In case of
parallel memories STRIPE bit is set and sent to the qspi ip, which will
send data bits to both the flashes in parallel. However for few commands
we should not use stripe, instead send same data to both the flashes.
Those commands are exclueded by using zynqmp_qspi_update_stripe().

Also update copyright info for this file.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 141 ++++++++++++++++++++++++++++++++-----
 include/spi.h              |   4 ++
 2 files changed, 129 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index ae795e50b0..1d19b2606c 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2018 Xilinx
- *
+ * (C) Copyright 2013 - 2022, Xilinx, Inc.
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
  * Xilinx ZynqMP Generic Quad-SPI(QSPI) controller driver(master mode only)
  */
 
@@ -24,6 +24,8 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/sizes.h>
+#include <linux/mtd/spi-nor.h>
+#include "../mtd/spi/sf_internal.h"
 #include <zynqmp_firmware.h>
 
 #define GQSPI_GFIFO_STRT_MODE_MASK	BIT(29)
@@ -87,6 +89,9 @@
 #define SPI_XFER_ON_LOWER		1
 #define SPI_XFER_ON_UPPER		2
 
+#define GQSPI_SELECT_LOWER_CS          BIT(0)
+#define GQSPI_SELECT_UPPER_CS          BIT(1)
+
 #define GQSPI_DMA_ALIGN			0x4
 #define GQSPI_MAX_BAUD_RATE_VAL		7
 #define GQSPI_DFLT_BAUD_RATE_VAL	2
@@ -183,13 +188,14 @@ struct zynqmp_qspi_priv {
 	int bytes_to_transfer;
 	int bytes_to_receive;
 	const struct spi_mem_op *op;
+	unsigned int is_parallel;
+	unsigned int u_page;
+	unsigned int bus;
+	unsigned int stripe;
+	unsigned int flags;
+	u32 max_hz;
 };
 
-__weak int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value)
-{
-	return 0;
-}
-
 static int zynqmp_qspi_of_to_plat(struct udevice *bus)
 {
 	struct zynqmp_qspi_plat *plat = dev_get_plat(bus);
@@ -234,8 +240,30 @@ static u32 zynqmp_qspi_bus_select(struct zynqmp_qspi_priv *priv)
 {
 	u32 gqspi_fifo_reg = 0;
 
-	gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
-			 GQSPI_GFIFO_CS_LOWER;
+	if (priv->is_parallel) {
+		if (priv->bus == SPI_XFER_ON_BOTH)
+			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
+					 GQSPI_GFIFO_UP_BUS |
+					 GQSPI_GFIFO_CS_UPPER |
+					 GQSPI_GFIFO_CS_LOWER;
+		else if (priv->bus == SPI_XFER_ON_LOWER)
+			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
+					 GQSPI_GFIFO_CS_UPPER |
+					 GQSPI_GFIFO_CS_LOWER;
+		else if (priv->bus == SPI_XFER_ON_UPPER)
+			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS |
+					 GQSPI_GFIFO_CS_LOWER |
+					 GQSPI_GFIFO_CS_UPPER;
+		else
+			debug("Wrong Bus selection:0x%x\n", priv->bus);
+	} else {
+		if (priv->u_page)
+			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
+					 GQSPI_GFIFO_CS_UPPER;
+		else
+			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
+					 GQSPI_GFIFO_CS_LOWER;
+	}
 
 	return gqspi_fifo_reg;
 }
@@ -295,8 +323,15 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
 		gqspi_fifo_reg |= GQSPI_SPI_MODE_SPI |
 				  GQSPI_IMD_DATA_CS_ASSERT;
 	} else {
-		gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
-		gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
+		if (priv->is_parallel) {
+			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS |
+					 GQSPI_GFIFO_LOW_BUS;
+		} else if (priv->u_page) {
+			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS;
+		} else {
+			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
+			gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
+		}
 	}
 
 	zynqmp_qspi_fill_gen_fifo(priv, gqspi_fifo_reg);
@@ -367,12 +402,13 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
 
 	log_debug("%s, Speed: %d, Max: %d\n", __func__, speed, plat->frequency);
 
-	if (speed > plat->frequency)
-		speed = plat->frequency;
+	/*
+	 * If speed == 0 or speed > max freq, then set speed to highest
+	 */
+	if (!speed || speed > priv->max_hz)
+		speed = priv->max_hz;
 
 	if (plat->speed_hz != speed) {
-		/* Set the clock frequency */
-		/* If speed == 0, default to lowest speed */
 		while ((baud_rate_val < 8) &&
 		       ((plat->frequency /
 		       (2 << baud_rate_val)) > speed))
@@ -394,6 +430,18 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
 	return 0;
 }
 
+static int zynqmp_qspi_child_pre_probe(struct udevice *bus)
+{
+	struct spi_slave *slave = dev_get_parent_priv(bus);
+	struct zynqmp_qspi_priv *priv = dev_get_priv(bus->parent);
+
+	slave->multi_cs_cap = true;
+	slave->bytemode = SPI_4BYTE_MODE;
+	priv->max_hz = slave->max_hz;
+
+	return 0;
+}
+
 static int zynqmp_qspi_probe(struct udevice *bus)
 {
 	struct zynqmp_qspi_plat *plat = dev_get_plat(bus);
@@ -458,12 +506,17 @@ static int zynqmp_qspi_set_mode(struct udevice *bus, uint mode)
 
 static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
 {
-	u32 data;
+	u32 data, ier;
 	int ret = 0;
 	struct zynqmp_qspi_regs *regs = priv->regs;
 	u32 *buf = (u32 *)priv->tx_buf;
 	u32 len = size;
 
+	/* Enable interrupts */
+	ier = readl(&regs->ier);
+	ier |= GQSPI_IXR_ALL_MASK | GQSPI_IXR_TXFIFOEMPTY_MASK;
+	writel(ier, &regs->ier);
+
 	while (size) {
 		ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_TXNFULL_MASK, 1,
 					GQSPI_TIMEOUT, 1);
@@ -586,6 +639,9 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_TX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	while (priv->len) {
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
@@ -720,6 +776,9 @@ static int zynqmp_qspi_genfifo_fill_rx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_RX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	/*
 	 * Check if receive buffer is aligned to 4 byte and length
 	 * is multiples of four byte as we are using dma to receive.
@@ -760,6 +819,33 @@ static int zynqmp_qspi_release_bus(struct udevice *dev)
 	return 0;
 }
 
+static bool zynqmp_qspi_update_stripe(const struct spi_mem_op *op)
+{
+	/*
+	 * This is a list of opcodes for which we must not use striped access
+	 * even in dual parallel mode, but instead broadcast the same data to
+	 * both chips. This is primarily erase commands and writing some
+	 * registers.
+	 */
+	switch (op->cmd.opcode) {
+	case SPINOR_OP_BE_4K:
+	case SPINOR_OP_BE_32K:
+	case SPINOR_OP_CHIP_ERASE:
+	case SPINOR_OP_SE:
+	case SPINOR_OP_BE_32K_4B:
+	case SPINOR_OP_SE_4B:
+	case SPINOR_OP_BE_4K_4B:
+	case SPINOR_OP_WRSR:
+	case SPINOR_OP_WREAR:
+	case SPINOR_OP_BRWR:
+		return false;
+	case SPINOR_OP_WRSR2:
+		return op->addr.nbytes != 0;
+	default:
+		return true;
+	}
+}
+
 static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 			       const struct spi_mem_op *op)
 {
@@ -771,6 +857,25 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	priv->rx_buf = op->data.buf.in;
 	priv->len = op->data.nbytes;
 
+	if (slave->flags & SPI_XFER_U_PAGE)
+		priv->u_page = 1;
+	else
+		priv->u_page = 0;
+
+	if ((slave->flags & GQSPI_SELECT_LOWER_CS) &&
+	    (slave->flags & GQSPI_SELECT_UPPER_CS))
+		priv->is_parallel = true;
+
+	priv->stripe = 0;
+	priv->bus = 0;
+
+	if (priv->is_parallel) {
+		if (slave->flags & SPI_XFER_MASK)
+			priv->bus = (slave->flags & SPI_XFER_MASK) >> 8;
+		if (zynqmp_qspi_update_stripe(op))
+			priv->stripe = 1;
+	}
+
 	zynqmp_qspi_chipselect(priv, 1);
 
 	/* Send opcode, addr, dummy */
@@ -784,6 +889,9 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 
 	zynqmp_qspi_chipselect(priv, 0);
 
+	priv->is_parallel = false;
+	slave->flags &= ~SPI_XFER_MASK;
+
 	return ret;
 }
 
@@ -814,4 +922,5 @@ U_BOOT_DRIVER(zynqmp_qspi) = {
 	.plat_auto	= sizeof(struct zynqmp_qspi_plat),
 	.priv_auto	= sizeof(struct zynqmp_qspi_priv),
 	.probe  = zynqmp_qspi_probe,
+	.child_pre_probe = zynqmp_qspi_child_pre_probe,
 };
diff --git a/include/spi.h b/include/spi.h
index b7148864e7..3a92d02f21 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -38,6 +38,9 @@
 
 #define SPI_DEFAULT_WORDLEN	8
 
+#define SPI_3BYTE_MODE 0x0
+#define SPI_4BYTE_MODE 0x1
+
 /* SPI transfer flags */
 #define SPI_XFER_STRIPE	(1 << 6)
 #define SPI_XFER_MASK	(3 << 8)
@@ -172,6 +175,7 @@ struct spi_slave {
 	 * at once.
 	 */
 	bool multi_cs_cap;
+	u32 bytemode;
 };
 
 /**
-- 
2.25.1

