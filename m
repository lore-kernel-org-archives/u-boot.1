Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54DF1CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 20 Oct 2023 03:19:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B55487248;
	Fri, 20 Oct 2023 05:19:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C/K4GT6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 75AD587248; Fri, 20 Oct 2023 05:19:20 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06F948723E
 for <u-boot@lists.denx.de>; Fri, 20 Oct 2023 05:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaFB21saqDrv9s+2rrKH8iZGBQnKnrrkXLsFb6tV33pq73CkAgMIHXLSvcMKyD4qFqdZQo8GjdIIUtPThC3xXNiwFgrGYT2JNVHaQkLR4d8jpmd62Ojsgsm9w0J+C52w4ug1U9YVly9/1tiMxTFDEUdk5ZHWqAaP69Z5EhTBApwN8hdCE51sbswo54/gi9rldD9xF5STwjPAyLp8wf1CwJWeJcd8jnvjiYPbZAQcXloX3HaAhJQLfUbw5saNzY/Gdx/7efHwHPSzvj7Drup+2bNvV2Dc5vArKeoLuyUjbUVkgZRlSpoaelvqK0C9MPB6MZKZLym3GyP7OJ/xefaTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v4dbGEySSnjA97wOetGN/1LE/4fO4ElHjvnXgkEzCt4=;
 b=SnWkuc6mhCSSjYvcO9GdIVRlC/S9cBksxnkEfeKJFxbXDcVNQuy9nVgWZqwh0aQqFX3n36nX5hpBCvK2UbRwSAiR7O5/V3X/RdNPzbdxfKH25H5S8YzpQ3kLYCFh06Rj8wq048RzvFNSIM8akfoKxIut/G28M7zxa+R3aVeM9co6g0kk72lvouWyv0WVbaX5D24ozqL2LkMNs3uTkbgt4ihCYJ/oR4oYnegPzBS9QYrAMxBHcMAXpgsAOuqznrT1xjEhwBwwLDv4y8iXs0GufkZrhQcdavPM4z/5Jy8t2tjXiQphpeHKTSR+mxniNi4bGHNBsefEiaQrB0aNFtAlng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v4dbGEySSnjA97wOetGN/1LE/4fO4ElHjvnXgkEzCt4=;
 b=C/K4GT6X9ESpWQnoQ7QI9iUTDen6jXJOOenvY/+cgEHTAhlvi4RbytCk8bhAIwr/dcdudGGajVcA2NsMIwoB8rsxc4+zM9tBLkVpYRZoV8MnIruP9333/jZ85T67ACWvMFvYrcvqETkGVD3tGfk2L4QBo3IGEICswIiq+i37vgc=
Received: from BL1P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::14)
 by MW4PR12MB7263.namprd12.prod.outlook.com (2603:10b6:303:226::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Fri, 20 Oct
 2023 03:19:14 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::cc) by BL1P221CA0010.outlook.office365.com
 (2603:10b6:208:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24 via Frontend
 Transport; Fri, 20 Oct 2023 03:19:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 03:19:13 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 19 Oct
 2023 22:19:12 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 19 Oct 2023 22:19:10 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v3 5/6] spi: zynqmp_gqspi: Add parallel memories support in
 GQSPI driver
Date: Fri, 20 Oct 2023 08:48:16 +0530
Message-ID: <20231020031817.267959-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
References: <20231020031817.267959-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|MW4PR12MB7263:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eb101c0-86cf-4d0a-2f6f-08dbd11b55f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SXIV0Upm8/tnNDeljGuYFgKOTsxKHWrxAuyY8p8OcZnpzLckfACo7zLypvYqbXvhAvsF/0tvWCQc/kfK9SjxNqEHaUlMD0S7XhYdYDcFR/ZDWinabS//XlXTehvYTM9I1mmD6AnfJjeTGSJy53ZZ5Dm1Kk8uWcb7YEovD29HAza2YczEfQ7xyjxmt+g0/MD8+15Y4jgaYuhZmdI0wX0GbgceM0n5RWlryxF2mwdmNuZhKRp90BoKYkqyvpMMz+7Hgr8fy2rspHJ/SMU1Zkc/r9Lw0O/uW50R51ZJQvhw1L4kQdyV+HkGiiRJoftGq/Lb+YYavdvjxWDwszWzMAIekUzdYKSsuAXRR7dhH51ECGXDFFCKAUDyptn6GrIWkGJVV625Dbl+Kkt9OL10192/JqymM6gJ3/lQ1BQqxr8h64keaVbKraIz6fN3y/kT0gsHRr5QdDghkQcbOdqJ5lEKznNGeE2l5F7m6JVs/Q+OWAA1cJXxQ9ejt49Khsb34y6qnFpq0H1Wkofva9NILCBimV8PUo/sk+pwnUse9tdA1G8fn5th/3Eu7CzrLB+na8XdtLji2vV+g5i8cU74gp42WsMxsRTWjJkeiq1kxuUAHkBeNXzwfhrG4AclmJIuYyAiWHO0VV6AYVVZ1eZqeNaBUZenaCypjT/qej1u4Qkm5IGF47Amd4G6QsDtovow+qYdNRD6/yoRGvgkvjqIn+c+/HhTJOLlTlRjn8wNI+dkbwUU/y7SBCFJ2/Niyo+XjT1JknelFQDvTy84nzdYO34Tcw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(186009)(82310400011)(1800799009)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(5660300002)(54906003)(70206006)(6916009)(478600001)(70586007)(2616005)(86362001)(26005)(1076003)(426003)(316002)(36756003)(2906002)(8676002)(41300700001)(8936002)(81166007)(336012)(4326008)(83380400001)(82740400003)(36860700001)(47076005)(356005)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 03:19:13.9173 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eb101c0-86cf-4d0a-2f6f-08dbd11b55f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7263
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
 drivers/spi/zynqmp_gqspi.c | 142 ++++++++++++++++++++++++++++++++-----
 include/spi.h              |  12 ++++
 2 files changed, 138 insertions(+), 16 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index ec59ef5804..620b5e4fc7 100644
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
 
+#define GQSPI_SELECT_LOWER_CS          BIT(0)
+#define GQSPI_SELECT_UPPER_CS          BIT(1)
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
 
@@ -291,7 +319,13 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
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
 
@@ -362,13 +396,16 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
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
+
 
 	if (plat->speed_hz != speed) {
-		/* Set the clock frequency */
-		/* If speed == 0, default to lowest speed */
 		while ((baud_rate_val < 8) &&
 		       ((plat->frequency /
 		       (2 << baud_rate_val)) > speed))
@@ -391,6 +428,18 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
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
@@ -455,7 +504,7 @@ static int zynqmp_qspi_set_mode(struct udevice *bus, uint mode)
 
 static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
 {
-	u32 data;
+	u32 data, ier;
 	int ret = 0;
 	struct zynqmp_qspi_regs *regs = priv->regs;
 	u32 *buf = (u32 *)priv->tx_buf;
@@ -464,6 +513,11 @@ static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
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
@@ -587,6 +641,9 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_TX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	while (priv->len) {
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
@@ -735,6 +792,9 @@ static int zynqmp_qspi_genfifo_fill_rx(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_RX | GQSPI_GFIFO_DATA_XFR_MASK;
 
+	if (priv->stripe)
+		gen_fifo_cmd |= GQSPI_GFIFO_STRIPE_MASK;
+
 	/*
 	 * Check if receive buffer is aligned to 4 byte and length
 	 * is multiples of four byte as we are using dma to receive.
@@ -775,6 +835,33 @@ static int zynqmp_qspi_release_bus(struct udevice *dev)
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
@@ -786,6 +873,25 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
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
@@ -799,6 +905,9 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 
 	zynqmp_qspi_chipselect(priv, 0);
 
+	priv->is_parallel = false;
+	slave->flags &= ~SPI_XFER_MASK;
+
 	return ret;
 }
 
@@ -829,4 +938,5 @@ U_BOOT_DRIVER(zynqmp_qspi) = {
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
2.25.1

