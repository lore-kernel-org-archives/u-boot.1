Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94614C47DA9
	for <u-boot@archiver.kernel.org>; Tue, 30 Jan 2024 04:45:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFB0287D99;
	Tue, 30 Jan 2024 05:45:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BOR5iMQf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 16A4387DC1; Tue, 30 Jan 2024 05:45:12 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9310F87D78
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 05:45:09 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DnIuCvw3hXA0uVVoImF7hTMi5E02Nldx7Dnl4m7euFAEkrhNnAABHrKh8rPUwxgkwBtxDes5NJOdjET1OYLtC7RDnbdXCGp9DkyQPOsopLwXB2PTGRVBydvC+Y3WbVrirFKlAjgh/KnsadC0nDbJezjxd1Nu5XCYEgd53zoqLKNs4cTAMC95sQWXmcCVZfpB3m+wrXrBWbp5hEfQLT9UDem+GQSlryvibDxjHD65eq7uA3oCvyz6cbAm4GqU9ozFAQBnnu3AQgne0cPuRhWVefBv79qLwPifdCSRQ8bB1wI1gAn3TzFOtFMmKOMYAJfSNb02LRIkrciU7PaEeYUCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlygGryy3iPJrNyMab5wJFu5lIOIT7Nnrm0CIXdhIZM=;
 b=mQy4/nE6ZU81gMCi3wwUhVovfzjqjD+IUhvPI6u6woEfMnGMy9XNgwczyRUipfgAKA31ZPY+9aKY7C0shsFSg4hq0zE2CCQYOptRbrxHOeuo987cbc645mBueUE/rqJpLAAzaFATx9bZzUtywLpZZAU8GbyMsoxfQb0EU7OoHAFbfWzZhYXJMEInFLNoeRUnqv96Qbl1hZJSqsJwxDcxK/JBpCx2SoK0qE0c4TWDhxKuyfFB7e4EDPpO+8CDuZI/PQn1WHHrSpVtCeCgo15UE7ZAYjuLvTB+19hHjFNyOjHHoPMnh5AValyG0GuoygcJwjL9Nr8BKA6cxB03Cn9USA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlygGryy3iPJrNyMab5wJFu5lIOIT7Nnrm0CIXdhIZM=;
 b=BOR5iMQfnyHyl02LWaXzE6sqz87BjlU3Sx4zQXVV+/+TQuJXy8jglOHUyXItIN7fKEzh6Y6B7P4JvdU2tG17IQHhTy9aTYfITH3FNGxGrfLW+z6eih3ph5W5rOdN+KDyLuq7CJSTQUkSS2d665T5TOMNxDtx6/+yNUJqHae/f3o=
Received: from BN0PR08CA0017.namprd08.prod.outlook.com (2603:10b6:408:142::24)
 by CY8PR12MB7636.namprd12.prod.outlook.com (2603:10b6:930:9f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 04:45:05 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:142:cafe::3d) by BN0PR08CA0017.outlook.office365.com
 (2603:10b6:408:142::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 04:45:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 04:45:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:45:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 22:45:04 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 29 Jan 2024 22:45:03 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <git@xilinx.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v10 5/8] spi: zynqmp_gqspi: Add parallel memories support in
 GQSPI driver
Date: Tue, 30 Jan 2024 10:14:20 +0530
Message-ID: <20240130044423.1391251-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
References: <20240130044423.1391251-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|CY8PR12MB7636:EE_
X-MS-Office365-Filtering-Correlation-Id: facb8a38-cb42-47d3-2003-08dc214e3aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UwoUS+JVbRxounucYarIjw9j2axPAqV2BQTHGKr+Csz989Vc5dU1cyrOKs1Tt2yCmvFhKnsWROU6tGhxAtQj332SDfqG2mBaZWWNmKTfSnzM87CC3hMRBSAzC9T6kJ9MfI7bRB4YRMHyEsAg+vzvhWE2jm1/TDr6q7JEtYbH4lV2f1TEB09aLX7Dt0vsuFBwXqzslravlM63K9O/5f9274Tl7SMLHOvo95H7CE1t2eMoYtVjMu3RvjFKsjNOD6FijxZ50iB+DbWZH2iTn3ICJjnRYxn0AomsmpfkmE8R9mStOyWaLWhO5fB+XOah7/6dj6yS0ku8dePqjV2oRpuPuL+1yfai3Pr6Xdep24aUT58DqwjqPeYf0KHU2AtAciGOdg6I2tCy0Mr1OnvjhyyxeCDh5liy3GtZxuN/4+9Pj6CIiTZm6XPNfDWy4abVPAAgRKs+ARB5RlTI08CD1zAJ/a1+TwA/4rMlb0RexBGRrGO9YQQ3S50Eel6gctLtOHzN+Pu/eHg7KySbuxqz9W5eVFIwb9VUoSKA+QWFVjn3hX7Hex72H7kWKL9fInhZtQQRSCb64y0iAUtbXz0LlvTnmrVDQOCNwmeaplZTBaOWzdPN/0Uv7NeX0BVesu1MySbqr4wsRGLIBAFa7yAtnNYYXNepLDnDqQde4uNxLL4Nsq+YVnMLVf8hymGnxlybCKzufWBHWi3KE53ZcF9+y0t9DCFoexrpRzpJj8XJ7Lp5I5ONYQl0bpTYtDDUXCx8cgmnJD+CW70a0KNO0bDKxkuyw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(230922051799003)(186009)(82310400011)(1800799012)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(83380400001)(41300700001)(356005)(86362001)(36756003)(82740400003)(81166007)(47076005)(426003)(1076003)(26005)(336012)(2616005)(2906002)(478600001)(70206006)(70586007)(6916009)(316002)(36860700001)(54906003)(6666004)(5660300002)(8936002)(8676002)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 04:45:05.4496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: facb8a38-cb42-47d3-2003-08dc214e3aa7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7636
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
index a323994fb2..dedf8270a8 100644
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
 
@@ -25,6 +25,8 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/sizes.h>
+#include <linux/mtd/spi-nor.h>
+#include "../mtd/spi/sf_internal.h"
 #include <zynqmp_firmware.h>
 
 #define GQSPI_GFIFO_STRT_MODE_MASK	BIT(29)
@@ -88,6 +90,9 @@
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
@@ -366,12 +401,13 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
 
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
@@ -393,6 +429,18 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
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
@@ -457,12 +505,17 @@ static int zynqmp_qspi_set_mode(struct udevice *bus, uint mode)
 
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
@@ -585,6 +638,9 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_TX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	while (priv->len) {
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
@@ -719,6 +775,9 @@ static int zynqmp_qspi_genfifo_fill_rx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_RX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	/*
 	 * Check if receive buffer is aligned to 4 byte and length
 	 * is multiples of four byte as we are using dma to receive.
@@ -759,6 +818,33 @@ static int zynqmp_qspi_release_bus(struct udevice *dev)
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
@@ -770,6 +856,25 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
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
@@ -783,6 +888,9 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 
 	zynqmp_qspi_chipselect(priv, 0);
 
+	priv->is_parallel = false;
+	slave->flags &= ~SPI_XFER_MASK;
+
 	return ret;
 }
 
@@ -813,4 +921,5 @@ U_BOOT_DRIVER(zynqmp_qspi) = {
 	.plat_auto	= sizeof(struct zynqmp_qspi_plat),
 	.priv_auto	= sizeof(struct zynqmp_qspi_priv),
 	.probe  = zynqmp_qspi_probe,
+	.child_pre_probe = zynqmp_qspi_child_pre_probe,
 };
diff --git a/include/spi.h b/include/spi.h
index cec5ace9a3..ee0f86fd3d 100644
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

