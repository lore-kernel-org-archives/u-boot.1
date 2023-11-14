Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51D5AC4332F
	for <u-boot@archiver.kernel.org>; Tue, 14 Nov 2023 04:57:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69E40871AB;
	Tue, 14 Nov 2023 05:57:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XqXb+269";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35C68871AB; Tue, 14 Nov 2023 05:57:11 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eaa::61e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7D0E871AB
 for <u-boot@lists.denx.de>; Tue, 14 Nov 2023 05:57:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i4dy7YgLU3tT5GfBh4z//mXKDaXZwJBQiJ4MUPoxxXBSKu3Pub6xqui+8xeIt8+vWyiq4LB2ziJbfaXJALYXAQ8dmdJIdY7GNRGqMjUqsMaYhp862ZqfuQg7LaKWAshRE4UFKtp12UzsCnziFjEwDPFryoz0LxmnoJOvps1GXvB2Kre/MfnRXmMB4t+SfviLMIgj4ieF/x9lkdWYLlurb4Ev5Frcyfy3OPXCnx69Fy40feYRwjhp5hPhLzVrFuFqazc+2PaXtSc5dfDhVUDwZM92STBSm/SSj34KodX6fmr5rhHrQs4sfY0cRS9jIfrDq9YTB7mYT20or37NDVDEQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7YfVkJTCajYQ3BwUiU+5xOc18uPzeh4i519itrLly/s=;
 b=EueZavM68uAd6o3BbIKKn4AxFPqZP+7VWBEdTqsFwIdwTqSdIxvfswChUvcdyylqTSurEPIQ3DkI8JkaVbjPziyBmPbBg6zCXLMv3OZs9R8w26ilE56ubQd13UlIeRSslS0lQaFZkaFf9qwG+soHPMzpKkACs7WuHuwdMyGqOPI4t29DYEgfUxI5OZzF70Iz4sq0NfD/v4JbVomHFO6PJ3uqgqc9bObmuM3uUvBYFP868no2dS0K2QGoS95Nm5rw342OOYjwSkW5Oo/F1+keUk20/SLB6IBwuqssvbshXzxl/wMlwZ7Ku9qdEQMVNBICcYJD4ldGtCk62FCURJruzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7YfVkJTCajYQ3BwUiU+5xOc18uPzeh4i519itrLly/s=;
 b=XqXb+269jRphqMJSriRmDq+k6qHcVF+MBI1gWdDjwQnPiq0LJIAaoGEFWqOlOKpz+LpqWw4q3+6VbnqIb4aaSUXGkgAs78vSbiy02EIfR9vHg/dKlN5cEGMvDyjeRuOTjfEONNsVa9KtpLxVNQT5ywAUMTqeY80BC6LOekDITWo=
Received: from MN2PR13CA0006.namprd13.prod.outlook.com (2603:10b6:208:160::19)
 by CH0PR12MB8552.namprd12.prod.outlook.com (2603:10b6:610:18e::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 04:57:05 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:160:cafe::49) by MN2PR13CA0006.outlook.office365.com
 (2603:10b6:208:160::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.17 via Frontend
 Transport; Tue, 14 Nov 2023 04:57:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.13 via Frontend Transport; Tue, 14 Nov 2023 04:57:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 22:57:05 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Mon, 13 Nov
 2023 22:57:04 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32 via Frontend
 Transport; Mon, 13 Nov 2023 22:57:02 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v4 5/6] spi: zynqmp_gqspi: Add parallel memories support in
 GQSPI driver
Date: Tue, 14 Nov 2023 10:26:37 +0530
Message-ID: <20231114045638.6463-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
References: <20231114045638.6463-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH0PR12MB8552:EE_
X-MS-Office365-Filtering-Correlation-Id: 9520bb69-b8ea-4f0d-f322-08dbe4ce25f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aSyeNbrV5LPTnKGTxAvpH/lbW5alOq9RrjZVMalE9BNA5hsAWQqwqpneE8fBT2wfDKfQga7TNW1CafvQQBoEtzJNAjWofCYtpcm7WUeiBiK2p5nMJyDc3af970FEZ3QnNmI39ko3ewZf2e1MzUfQwdnZa287XVq+ItoL++YoFxLXeIIHwI3do8490GViQiYdf9FTThFOh0kC4Og+P8+zrqfjXbbEyyC5Mf9xuKeHsLSr6QWP3jWVTrG42UdiAo740DlMxhXet13Zg2WkS90Y19fz86c1OwRmpK6k6mkAYTZ4Xqm7otq41K7P8tt7215yGZnF1+NnTS+ZfsD0PLQoQ6umYe40dEYAaBZbnHz9k5UNqz4FRdbA+zkHdbySl4siO0foqUPF0bLYo4Tbj7gek29So/mSdJKs+VnWrZAKpKmKhwoxGLpccRq/9cjgbt4+n5KsO5FNF+ANZTPTF1W43tsPssDDA4iK+LcoDvaYxHs2ykiBMeFWC77Ts/ke68pemqbzpfMaYv8kj/w2/ceel0pC8nuK4rHbvH11F49HyZvmkNJny9Fsk5m/bzpHj3JjkqNfAOiV8qfmFj0rCoLsiuxyPhcRJqtMxY94zX6EZvRLt/x3xRKfKUNKzn33pOcHTQFCgluz2Wo4kGzaaFn/j9c+6dHeFCmePJaulTLo2pPs5Jn/Z5MAp4/52RX1dsCWmsp/fLDJQiumF7cyUXc6wn7EGloe+YSNCsK7qqBEd5x7ylz5qev2MvgG1Aur5tf9oTB85TD8tQXQijfocj1KEQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(82310400011)(64100799003)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2616005)(336012)(426003)(40460700003)(1076003)(26005)(2906002)(478600001)(4326008)(36756003)(86362001)(5660300002)(41300700001)(8676002)(8936002)(316002)(6916009)(70586007)(70206006)(54906003)(82740400003)(6666004)(356005)(81166007)(40480700001)(47076005)(83380400001)(36860700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 04:57:05.3990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9520bb69-b8ea-4f0d-f322-08dbe4ce25f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8552
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
 drivers/spi/zynqmp_gqspi.c | 140 ++++++++++++++++++++++++++++++++-----
 include/spi.h              |  12 ++++
 2 files changed, 136 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index a323994fb2..7e90a989dd 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2018 Xilinx
+ * (C) Copyright 2013 - 2022, Xilinx, Inc.
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
  *
  * Xilinx ZynqMP Generic Quad-SPI(QSPI) controller driver(master mode only)
  */
@@ -25,6 +26,8 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/sizes.h>
+#include <linux/mtd/spi-nor.h>
+#include "../mtd/spi/sf_internal.h"
 #include <zynqmp_firmware.h>
 
 #define GQSPI_GFIFO_STRT_MODE_MASK	BIT(29)
@@ -88,6 +91,9 @@
 #define SPI_XFER_ON_LOWER		1
 #define SPI_XFER_ON_UPPER		2
 
+#define GQSPI_SELECT_LOWER_CS          BIT(0)
+#define GQSPI_SELECT_UPPER_CS          BIT(1)
+
 #define GQSPI_DMA_ALIGN			0x4
 #define GQSPI_MAX_BAUD_RATE_VAL		7
 #define GQSPI_DFLT_BAUD_RATE_VAL	2
@@ -183,13 +189,14 @@ struct zynqmp_qspi_priv {
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
@@ -234,9 +241,30 @@ static u32 zynqmp_qspi_bus_select(struct zynqmp_qspi_priv *priv)
 {
 	u32 gqspi_fifo_reg = 0;
 
-	gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS |
-			 GQSPI_GFIFO_CS_LOWER;
-
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
 
@@ -295,8 +323,14 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
 		gqspi_fifo_reg |= GQSPI_SPI_MODE_SPI |
 				  GQSPI_IMD_DATA_CS_ASSERT;
 	} else {
-		gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
-		gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
+		if (priv->is_parallel)
+			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS |
+					 GQSPI_GFIFO_LOW_BUS;
+		else if (priv->u_page)
+			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS;
+		else
+			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
+			gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
 	}
 
 	zynqmp_qspi_fill_gen_fifo(priv, gqspi_fifo_reg);
@@ -366,12 +400,13 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
 
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
@@ -393,6 +428,18 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
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
@@ -457,12 +504,17 @@ static int zynqmp_qspi_set_mode(struct udevice *bus, uint mode)
 
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
@@ -585,6 +637,9 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_TX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	while (priv->len) {
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
@@ -719,6 +774,9 @@ static int zynqmp_qspi_genfifo_fill_rx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_RX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	/*
 	 * Check if receive buffer is aligned to 4 byte and length
 	 * is multiples of four byte as we are using dma to receive.
@@ -759,6 +817,33 @@ static int zynqmp_qspi_release_bus(struct udevice *dev)
 	return 0;
 }
 
+static bool zynqmp_qspi_update_stripe(const struct spi_mem_op *op)
+{
+	/*
+	* This is a list of opcodes for which we must not use striped access
+	* even in dual parallel mode, but instead broadcast the same data to
+	* both chips. This is primarily erase commands and writing some
+	* registers.
+	*/
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
@@ -770,6 +855,25 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 	priv->rx_buf = op->data.buf.in;
 	priv->len = op->data.nbytes;
 
+	if (slave->flags & SPI_XFER_U_PAGE)
+		priv->u_page = 1;
+	else
+		priv->u_page = 0;
+
+	if ((slave->flags & GQSPI_SELECT_LOWER_CS) &&
+            (slave->flags & GQSPI_SELECT_UPPER_CS))
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
@@ -783,6 +887,9 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 
 	zynqmp_qspi_chipselect(priv, 0);
 
+	priv->is_parallel = false;
+	slave->flags &= ~SPI_XFER_MASK;
+
 	return ret;
 }
 
@@ -813,4 +920,5 @@ U_BOOT_DRIVER(zynqmp_qspi) = {
 	.plat_auto	= sizeof(struct zynqmp_qspi_plat),
 	.priv_auto	= sizeof(struct zynqmp_qspi_priv),
 	.probe  = zynqmp_qspi_probe,
+	.child_pre_probe = zynqmp_qspi_child_pre_probe,
 };
diff --git a/include/spi.h b/include/spi.h
index f050227168..c33acd9eac 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -39,6 +39,9 @@
 
 #define SPI_DEFAULT_WORDLEN	8
 
+#define SPI_3BYTE_MODE 0x0
+#define SPI_4BYTE_MODE 0x1
+
 /* SPI transfer flags */
 #define SPI_XFER_STRIPE	(1 << 6)
 #define SPI_XFER_MASK	(3 << 8)
@@ -168,6 +171,15 @@ struct spi_slave {
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
 #define SPI_XFER_U_PAGE		BIT(4)
 #define SPI_XFER_STACKED	BIT(5)
+
+	u32 bytemode;
+
+	/*
+	* Flag indicating that the spi-controller has multi chip select
+	* capability and can assert/de-assert more than one chip select
+	* at once.
+	*/
+	bool multi_cs_cap;
 };
 
 /**
-- 
2.17.1

