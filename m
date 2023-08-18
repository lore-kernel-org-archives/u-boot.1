Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CEAC05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:22:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1DF6886CA1;
	Fri, 18 Aug 2023 06:22:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="h49ovQem";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 35FBC86C97; Fri, 18 Aug 2023 06:22:14 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8a::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE68186C89
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:22:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ashok.reddy.soma@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U78tMlHPzwPXsL04tePLIkEFHwQuI6UtiFrTFdxi7lvnSthDPM/oAGHo75L+ZkSYPeX8yP3F2OCEoWOe/nNeGem4G1xOArBU9RrJG+9shwduD88JacbqzTX2STm5s3bS+Ff8zHNCCX6/XQSGid/jtNUEV2rWED94VEgj0lbtRM73VEzOoztI/Dmms/Xp/O1S+3YdhYjrokonflFXC3l9GSlu9Rka6YQRj1tlQh3Xz7Q9X6n88aubC8CYLkhvaFh5xOoFjHGoG25dlj7mq4l8E/+/bW9vi46Sm2p5F7iM+e40KeXBH2dVsoX1ZqPYKNzH1wS6SiZwqVMAurzX0UxGuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=87xJ4kEuu0H5UxG7HiJC76P3qf7yTQW4APe4lq6xZI0=;
 b=KRycCafPE8WgXn4tT1QvqKdQoisPyn/PBUoQFg/ki+PSDi4S98p+ZyQZ6l/Qkr5WFbfa7ENrUZGXXVY0BhZfO1Y/GY9hFzb7ibE//twAqNiPp1n6LuqBboBfq7m+7aRQfRFPP6BQMOQDqyhkny4C3SpqhCkpvGeZt12aH59KnSPu+MF9uGyJmurpn3Y8V5RhSQIRGyKOVNVwLVm44e8r6YxinB79os/o07BddFnmwM/l60YsbpO/ix5NhzofYBhArxHARlhMMf5xc+tLyOGoBi2O9mucJX5LgtZiY08zbsoLmlwJTxGmPFPgbxiArqvd9vjlELNqjOb1L1jo2J3vBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=87xJ4kEuu0H5UxG7HiJC76P3qf7yTQW4APe4lq6xZI0=;
 b=h49ovQemR+jocSdi7UunpjUELw9q3KcbyHHoHzebXNX2yqgUqPJJuN7fJmNkyiF1FRMNiybzq+ya3cSTs+5vKvSoO8DcLUKXy4QZyLT82apgkyqK423wBwmCNjHy8c33LVu2K7jQRIp9YMlS+7Q9k5PYdLlNnqvhJLhdWxqCFvA=
Received: from SN7PR04CA0188.namprd04.prod.outlook.com (2603:10b6:806:126::13)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 04:22:06 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::4a) by SN7PR04CA0188.outlook.office365.com
 (2603:10b6:806:126::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 04:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 04:22:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:22:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:22:03 -0500
Received: from xhdashokred41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 23:22:00 -0500
From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <sjg@chromium.org>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 6/7] spi: zynqmp_gqspi: Add parallel memories support in GQSPI
 driver
Date: Thu, 17 Aug 2023 22:21:18 -0600
Message-ID: <20230818042119.25722-7-ashok.reddy.soma@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 6374cad8-7e1d-483d-d605-08db9fa2adce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uYgWrbxXRrqRdEXF7w3sxQ+VZwI1voytaR//Hu5d41WVzWQsquv0ICpHKeHOlP1hYro2zB1Foq9Qdjdr0x8SkD9WMtat9U23vGePydSAQozx8LXh+ko6VMl5J87z+ykmq8Ciyxd9ghQiAL5DZSBMmoihi2R8g6GiKEMYQtwgiKiOR7vIaSN1vrARa0mlsWZmltmsx8p8p0lb79yYaSJJjiRLSCN5R3irvTXZGSh+y2CnfLl16WmL7qH67F0AzzZ/FZlNhLUMZ1lQo7yUlMOWDQj+VoKdb45KE3L9ShvG9JUDykLzxsvWrB2GhAMTL/bgEdEaSDbj7JLJSrCGyHa1zEbdcUBrBUfH4NtZ3dMqNG1xAWpv6+0AeWxcfF1FQrfBbQU/N16TeFzJPa0HnxYh30k8J9MCkN1DrrVoi7JFB+do56oIlJN52f7Wla0wzGYCJyiW7DNZwOXk+q956+Vx3JddCaRl1W1H5cSeHlV7Zx+B1TPTa0394/rRz+PgaJzDk92t7t3g0sh5XYz44KSkswUDS1JCG65eidHoPlCZJ/6CW+DOWpRiy1J3hmTjlk2mP2qZ5H5Z0hRhfuj8ltjqNU5biaF+fmRPWgwmgeah8OTDOZ5mReZbOeXtbklHqEb5DgTTHwKlPKyMAFrLuKBcAYwg9HukU/3uFDd2wKyJG2k4wYS+l4TqTD2nbyJHQUHBjcgCb1q77xagq9fIECoo+bokzWNv4TbdU75dudafSCpfiDcxQeP7Co2vSgfNzyOmS/1aYI9fRQ67zSeMvEBytA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(346002)(376002)(1800799009)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(6666004)(40460700003)(83380400001)(81166007)(336012)(356005)(426003)(103116003)(26005)(82740400003)(86362001)(36756003)(47076005)(36860700001)(40480700001)(2616005)(1076003)(6916009)(41300700001)(2906002)(316002)(70586007)(70206006)(54906003)(5660300002)(8676002)(8936002)(4326008)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 04:22:05.1964 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6374cad8-7e1d-483d-d605-08db9fa2adce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

 drivers/spi/zynqmp_gqspi.c | 146 ++++++++++++++++++++++++++++++++-----
 include/spi.h              |  12 +++
 2 files changed, 140 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index c4aee279aa..1c7483bbd8 100644
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
@@ -23,6 +24,8 @@
 #include <linux/bitops.h>
 #include <linux/err.h>
 #include <linux/sizes.h>
+#include <linux/mtd/spi-nor.h>
+#include "../mtd/spi/sf_internal.h"
 #include <zynqmp_firmware.h>
 
 #define GQSPI_GFIFO_STRT_MODE_MASK	BIT(29)
@@ -86,6 +89,9 @@
 #define SPI_XFER_ON_LOWER		1
 #define SPI_XFER_ON_UPPER		2
 
+#define GQSPI_SELECT_LOWER_CS		BIT(0)
+#define GQSPI_SELECT_UPPER_CS		BIT(1)
+
 #define GQSPI_DMA_ALIGN			0x4
 #define GQSPI_MAX_BAUD_RATE_VAL		7
 #define GQSPI_DFLT_BAUD_RATE_VAL	2
@@ -181,13 +187,14 @@ struct zynqmp_qspi_priv {
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
 
@@ -279,7 +307,6 @@ static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
 				GQSPI_TIMEOUT, 1);
 	if (ret)
 		printf("%s Timeout\n", __func__);
-
 }
 
 static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
@@ -291,7 +318,13 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
 		gqspi_fifo_reg |= GQSPI_SPI_MODE_SPI |
 				  GQSPI_IMD_DATA_CS_ASSERT;
 	} else {
-		gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
+		if (priv->is_parallel)
+			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS |
+					 GQSPI_GFIFO_LOW_BUS;
+		else if (priv->u_page)
+			gqspi_fifo_reg = GQSPI_GFIFO_UP_BUS;
+		else
+			gqspi_fifo_reg = GQSPI_GFIFO_LOW_BUS;
 		gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
 	}
 
@@ -362,13 +395,15 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
 	u32 confr;
 	u8 baud_rate_val = 0;
 
-	debug("%s\n", __func__);
-	if (speed > plat->frequency)
-		speed = plat->frequency;
+	/*
+	 * If speed == 0 or speed > max freq, then set speed to highest
+	 */
+	if (!speed || speed > priv->max_hz)
+		speed = priv->max_hz;
+
+	debug("%s %d\n", __func__, speed);
 
 	if (plat->speed_hz != speed) {
-		/* Set the clock frequency */
-		/* If speed == 0, default to lowest speed */
 		while ((baud_rate_val < 8) &&
 		       ((plat->frequency /
 		       (2 << baud_rate_val)) > speed))
@@ -391,6 +426,18 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
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
@@ -455,7 +502,7 @@ static int zynqmp_qspi_set_mode(struct udevice *bus, uint mode)
 
 static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
 {
-	u32 data;
+	u32 data, ier;
 	int ret = 0;
 	struct zynqmp_qspi_regs *regs = priv->regs;
 	u32 *buf = (u32 *)priv->tx_buf;
@@ -464,6 +511,11 @@ static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
 	debug("TxFIFO: 0x%x, size: 0x%x\n", readl(&regs->isr),
 	      size);
 
+	/* Enable interrupts */
+	ier = readl(&regs->ier);
+	ier |= GQSPI_IXR_ALL_MASK | GQSPI_IXR_TXFIFOEMPTY_MASK;
+	writel(ier, &regs->ier);
+
 	while (size) {
 		ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_TXNFULL_MASK, 1,
 					GQSPI_TIMEOUT, 1);
@@ -587,6 +639,9 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_TX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	while (priv->len) {
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
@@ -690,7 +745,7 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 		writel(GQSPI_DMA_DST_I_STS_MASK, &dma_regs->dmaier);
 		addr = (unsigned long)buf;
 		size = roundup(priv->len, GQSPI_DMA_ALIGN);
-		flush_dcache_range(addr, addr + size);
+		invalidate_dcache_range(addr, addr + size);
 
 		while (priv->len) {
 			zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
@@ -707,6 +762,8 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 			return -ETIMEDOUT;
 		}
 
+		invalidate_dcache_range(addr, addr + size);
+
 		writel(GQSPI_DMA_DST_I_STS_DONE, &dma_regs->dmaisr);
 
 		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",
@@ -733,6 +790,9 @@ static int zynqmp_qspi_genfifo_fill_rx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_RX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	/*
 	 * Check if receive buffer is aligned to 4 byte and length
 	 * is multiples of four byte as we are using dma to receive.
@@ -773,6 +833,33 @@ static int zynqmp_qspi_release_bus(struct udevice *dev)
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
@@ -784,6 +871,25 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
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
@@ -797,6 +903,9 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 
 	zynqmp_qspi_chipselect(priv, 0);
 
+	priv->is_parallel = false;
+	slave->flags &= ~SPI_XFER_MASK;
+
 	return ret;
 }
 
@@ -827,4 +936,5 @@ U_BOOT_DRIVER(zynqmp_qspi) = {
 	.plat_auto	= sizeof(struct zynqmp_qspi_plat),
 	.priv_auto	= sizeof(struct zynqmp_qspi_priv),
 	.probe  = zynqmp_qspi_probe,
+	.child_pre_probe = zynqmp_qspi_child_pre_probe,
 };
diff --git a/include/spi.h b/include/spi.h
index f050227168..b013f2eaa3 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -39,6 +39,9 @@
 
 #define SPI_DEFAULT_WORDLEN	8
 
+#define SPI_3BYTE_MODE	0x0
+#define SPI_4BYTE_MODE	0x1
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
+	 * Flag indicating that the spi-controller has multi chip select
+	 * capability and can assert/de-assert more than one chip select
+	 * at once.
+	 */
+	bool multi_cs_cap;
 };
 
 /**
-- 
2.17.1

