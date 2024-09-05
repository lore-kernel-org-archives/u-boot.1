Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4391ACD4F4E
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 03:23:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA39B88C47;
	Thu,  5 Sep 2024 05:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZGJUPgQi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A22F888C90; Thu,  5 Sep 2024 05:23:19 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20625.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::625])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B7A4E88C63
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 05:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eOfDaz7t/2CH4+7Td6C1KzowZS9bwskmzRkHzUfuXi54PTJpJWx9l3afeii0uNOo0UpT+9toHOKRr5dTx72zDtfEGf8TBefwBYU0bZX7zp4PUCNOQMZyBolNGPiOqtBgRFBkaXqKFf4ZcrjVPW2EsJFYVnNIMrv2psq5Yr0YZiKycIaP6HtYegJ8y7D7oi8ig70NoivXxKuoYwZpvJWqNO4TdCXw18T9bkNOPtKqmSR4eRJwuiuD7xsFBoZg+tJdHQ3rrREolwjXhXZ2ZuQMpQx2UkutqjDXOLrmnNTVsdF9VEzYwmHtUdMY8PUSl6vZGN6VS7Vpp00b0sEh2oCNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YMYMx2CpL6XMOFGy12gs5P9FknIOfI6QreIpOcB20ho=;
 b=VbwTjM7gacsEa3PIP5B8NVYmyoXdCanA7FJnjwBlK5Wcc2N2vTmltJ7zPOUYc2zQqtaKjjmx6IAixW3XsKiSqCDswD8TQx7Rew++XMnvvYq8bcHiYtU0Bj/Yv/YFRv3fCKplOmbN0X1WeLTGJX+EDloqxm0MV+wd+aoenSmC6PzIB0EVK+a2vYU/NBvSkW4C8Au+B1KkOXev9dVQcp9u25LW7YAU/FnVV31pCoky7EbKNi68XrOlg00Gdo2e0dkfoSpaxx+gCNMDiAlxpQIVqTKuf0GRSqRmCXqXRHsavRF0U6aWq1NT3i74RniXLXh7KH6IoVdFU65pbA0W7swHIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YMYMx2CpL6XMOFGy12gs5P9FknIOfI6QreIpOcB20ho=;
 b=ZGJUPgQiWci7AS3R3lxukYpVzCYZ69NSW6CoCo4KemciLFBI9nttLF4oZNQ6Lg9sTDHB9OQIk32k6D2nQc/baNuZM/YDDkpRP4O1Mo3kCRGoK+yreoLgc4EtD4pbrxrxWj/Hi8DWLMY4Lb7dW4VZQ2NDQc/29IjrhpQ/FSDbDwY=
Received: from BY3PR03CA0021.namprd03.prod.outlook.com (2603:10b6:a03:39a::26)
 by CY8PR12MB7658.namprd12.prod.outlook.com (2603:10b6:930:9e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 03:23:10 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::c7) by BY3PR03CA0021.outlook.office365.com
 (2603:10b6:a03:39a::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Thu, 5 Sep 2024 03:23:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 03:23:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:23:05 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:03 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v13 7/8] spi: zynqmp_gqspi: Add parallel memories support in
 GQSPI driver
Date: Thu, 5 Sep 2024 08:51:45 +0530
Message-ID: <20240905032146.2470396-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
References: <20240905032146.2470396-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|CY8PR12MB7658:EE_
X-MS-Office365-Filtering-Correlation-Id: 08d2c9c2-7bf6-481d-29e4-08dccd5a117b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EnPffHWHg/rIVAem9i8qYJiAMPrn+Mmt0bylqNMnmuXGx32JXKRybDE/BGrg?=
 =?us-ascii?Q?tCoM1szidKhjn2x7Y8qL+NwTBzXlC9xL8jPf7A+XL6KX0KZ/EoF5MckFQ27P?=
 =?us-ascii?Q?QG+dL+p/WvsL3p2a1iIgMNNqW9q/z2ncbGvE2cwcTxattCfpWKTR/bOYBFXN?=
 =?us-ascii?Q?2pftXNpFiMkIOYewrNuySCAfxYiFUl3wIxrIPvEQZnBMUHdSmZCMBGBqs9iP?=
 =?us-ascii?Q?8H1QDzR4iNfcQ424VisVtZ1HBjRKH6cYA8EZRKe2J4O2spSf+EIU0hOcB55M?=
 =?us-ascii?Q?Egyu2rReC5I5yFwNw4kM9haUPz6HB0az3XiZpCIJyOTu1cyacH2qnjKogkXD?=
 =?us-ascii?Q?e9WnUWLtC1dwOAA2B7kyW94f+zhhjduhD85AWnCgbu0UZKzg1h2Y2uZjk9fs?=
 =?us-ascii?Q?WuejYf4Ab3nvUHLNQu0mdANEr8iH2rI0vvfVW0JNVUvpuWxV3uXD5xa8Izvj?=
 =?us-ascii?Q?IY4LDRG5Od2Ob4GOLUh5/8oBxzs/U8r0bPymskMa0iC1EdD26UaUhcGZbQpY?=
 =?us-ascii?Q?IPPxFu3t43ga6O9+igguj7OD2C2TjO9pS6pt4KrBkHbf59Lpw0Vo2j02WL7B?=
 =?us-ascii?Q?GJnDW4kZsl1PImLqHn57ny92sojSsalX0KhgbHPjBWE9Do7kJK2BhyUM0/Nb?=
 =?us-ascii?Q?3WnyngD3C7Mt3pSxyhFdyUgALV54ckcF0R9j4RxLKrrEuXNuzXrWApzn7LsL?=
 =?us-ascii?Q?Mjq/k5IS2QU9ts0/mlG6SxoTrP5wtS7JYyInNQrLZ3nr4pD92lEZ1h6JiWQR?=
 =?us-ascii?Q?O1ozPYizOg32jNn/DKXQ6/2RiDDHmtJ7V7LNubdmPuGmm9Jxg39qw9ml9ILM?=
 =?us-ascii?Q?gGhJAkO9pVNEH0f0Y1DoDQD9P7QO8r2BrGojJgMrXsUA/FkTRlaJGua5uXU1?=
 =?us-ascii?Q?1TzlUnO7mYtw8+jYxA9ACtKJuNCdLsw/h28l1lS6TBb2dYkg4HdhFJd5DIoH?=
 =?us-ascii?Q?8HOEA+GL2fLP9bvnOLcJ1ktYpbB4QjrSRyxW2DhY+Qj46k2hVxT7lagvRZvC?=
 =?us-ascii?Q?FNxm5iDNH3g/iLonNGxH3mhTrKLwtrr2rKroT2orkHX25p6HmUeFIoXdnopg?=
 =?us-ascii?Q?RLlNuXVmgKxwv17dxaK27Ur0sQwgtl6TFyaek78espd8cynWo2g9J9bLtHeB?=
 =?us-ascii?Q?97AmM/lBdvLYTV/bOr+USGXjKMaA2VFHBRnWH6Yic/ZcOIdrNoGLEsjQ/NVn?=
 =?us-ascii?Q?BmNR//OcT0DbRKfL7QHlmwWVI8SK1e+wHDKH/MX9ISCbRtM7/qqH5aQWYoNH?=
 =?us-ascii?Q?CWNBGMEOF0UpCTA8hoB+e3ik+A3CgUEqxEVRP9qUgiJOpzyI1zch418LZx9u?=
 =?us-ascii?Q?Pkx/9qosM0aRihmlhUjAfkerLOEBJL602GFkK/aRbxLZPngVnZhVNrU7N0TK?=
 =?us-ascii?Q?RrvNhyo7EfhCWs8T0TyatrmRRiG5wMis5ZFRw7Qo59DMNna6pW8df5ZiBTfs?=
 =?us-ascii?Q?3ZQ+h7LmRan5CjfnedObECa1lONn4FFu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:23:10.2240 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d2c9c2-7bf6-481d-29e4-08dccd5a117b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7658
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

