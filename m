Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADDAC41535
	for <u-boot@archiver.kernel.org>; Tue, 19 Dec 2023 04:17:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D86AF8744F;
	Tue, 19 Dec 2023 05:16:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="myK9McC+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 446D5874F3; Tue, 19 Dec 2023 05:16:38 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3A6B8874D9
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 05:16:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kjtUl1paW1SE80YnLNoN3ghFaOFovy66mPMdkrok7fkWSzQ3VCbdjDLVripdaJCX7AR+LIWUl7dw+7tOCjT2RyC85zfSPm3mADxAxFtoE28c6wqMHRskCs8wVXkawzB7YpGpO90dJ8fk0F3qH8EcxV/X5p7ADPFvX0PLDvi1z7YE2Ucf0APPXsLWYnVNvFc3EhF4aW0w/+mbgZ/LDZO15aJ0qKuLCodJJohAPMbBgK2HDsL7lOmFsKb8ylwBQNQzPy+kibZo1D2Y1KvPdV55iZ+Fd+1gDqsVDa50cJXaoeRRRU6LqPLKLCYINpWJd0RXl+ANOpCzhgk6g2f3R2rA6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MgzZ4pQBLpC/Zx/5m5KGlvd2M+AGzdqgUMBOZ81A2E=;
 b=BqjpnNWktllX2rzqTSgvt98Yqn1m1DPlzEjyVFeiAdbM25ULCiBA0PK8eFVLWrnrnlmbORB7/EJD03uEmvEEC6xJWQqAFq41wddht2ZnqXwhLU4aJEiw4k4JUrwBQ6qggWtqIQ6yNp4R9YK8n9rjKvisNqT/01kz9GSGhzuGe/13Khl02JaoiyckEYxUOkk1YvfUxsgrKxRQrftwK7emivmbDKAjRJPXBU0JbwKjN7PMalogH6tIlCmHDonEaVuUMzcIAYWb2nS4ouIKyAGdDredsUuh7yxKQxwNWaQBLM+J1lawQqGug0f5WpC19B2EEydA87XejGhu3R45EmnZpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MgzZ4pQBLpC/Zx/5m5KGlvd2M+AGzdqgUMBOZ81A2E=;
 b=myK9McC+8l/RRpLyJLwpkjTAyHDhRq8b5zdtw2mtTHGv0da7Oe7vPmy+fehWrkeCr3VwY6HvLJTk0WUnmWhe2fS+Ktu7Ow+1pdt+TJYvA6Hskp83QaNr8hd4nJYwdccl7MIwGSELZml1C6LbZF8GwEz3+DcEQSL2uXcLdk9SxFE=
Received: from MN2PR08CA0006.namprd08.prod.outlook.com (2603:10b6:208:239::11)
 by MN6PR12MB8589.namprd12.prod.outlook.com (2603:10b6:208:47d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.37; Tue, 19 Dec
 2023 04:16:18 +0000
Received: from BL02EPF0001A106.namprd05.prod.outlook.com
 (2603:10b6:208:239:cafe::a) by MN2PR08CA0006.outlook.office365.com
 (2603:10b6:208:239::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Tue, 19 Dec 2023 04:16:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A106.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Tue, 19 Dec 2023 04:16:18 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 22:16:16 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 18 Dec
 2023 22:16:14 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Mon, 18 Dec 2023 22:16:12 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v7 6/6] spi: zynq_qspi: Add parallel memories support in QSPI
 driver
Date: Tue, 19 Dec 2023 09:45:37 +0530
Message-ID: <20231219041537.1240070-7-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
References: <20231219041537.1240070-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A106:EE_|MN6PR12MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: e9d3c0b2-eb43-435f-0fad-08dc00493fef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4zIxspsVggHEQLo4Rc0XrlPy+dHtNQWQtZNcEwrJv8c7LnJ1WeIHVI73GV6KKg1LQ74tRh6RLMCJnlnLlFTlVBYk9J7mhfXG6ADuTbtQDVL478X7ehgt23jR+hUAJsEPEQDzGBfksyYRFt+h3hvB/Lg3YBeE6fiwxmmcdcJBA8enCyhEDV7EK3k4jyiLZ6coZcW1yLf3nsF4x6E7D+TVogVy7E0WGzkg4G3MyHBtbOpVllbRuy2byUZAQSH+OsHqY8CAklWJ/jV1gvNHM2bQYYHsJbUF2o9voPfpBpQG7H1Z8vHe0PaYHbYNazY8CLNj9Sl5nTqnWLiCu5IDLNWvN5qIm3L+ktmNe3EhC4SS96ZHPkzDUZ9Iuz961mDzD6Rbj/hFhfh5ncw2Iku83IB59ifxyxHUsYl6VEmGf2diIwSmjnIFrnTy9Kr22K7vD6xy7pj23jZgs0+7BCtXBtia55ogJnB6sHSv7IePc/BWrUKbTlZ/iWblU7zpw2/7tFDyN8H5O3kvw3fQuMmX0t7cvubBIrnR5/LdzDXBfbiXhXyuQpJkGkcFcV21DQmBR7+bG0MK9bXLOBHXLJ7KALkvebudfajbvutYoZoPR+xLP04Jzi2nBV1zoABHnt3Q/c9HoHC7ZXQbYxl4JsW5HnaVnIn4g4lGf5WPZFVl7eD72P04Uhc6rlABpCSkY4BSFBH5UopG3v5YBI5NXzeyHEpZEBepiNTM01rDQ17jJWDJPbJX/ka2RqkO1FLKXShifBNiPaAH+LHu9idcAFVd9FfaBQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799012)(46966006)(36840700001)(40470700004)(82740400003)(356005)(40460700003)(2906002)(81166007)(41300700001)(36756003)(86362001)(54906003)(70586007)(316002)(6916009)(70206006)(426003)(336012)(83380400001)(6666004)(40480700001)(2616005)(1076003)(478600001)(26005)(36860700001)(5660300002)(4326008)(8676002)(47076005)(8936002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2023 04:16:18.3918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9d3c0b2-eb43-435f-0fad-08dc00493fef
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A106.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8589
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

Add support for parallel memories in zynq_qspi.c driver. In case of
parallel memories STRIPE bit is set and sent to the qspi ip, which will
send data bits to both the flashes in parallel. However for few commands
we should not use stripe, instead send same data to both the flashes.
Those commands are exclueded by using zynqmp_qspi_update_stripe().

Also update copyright info for this file.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/zynq_qspi.c | 113 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index bc82acd0b6..41f7ae2ab2 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -1,7 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0+
 /*
- * (C) Copyright 2013 Xilinx, Inc.
+ * (C) Copyright 2013 - 2022, Xilinx, Inc.
  * (C) Copyright 2015 Jagan Teki <jteki@openedev.com>
+ * (C) Copyright 2023, Advanced Micro Devices, Inc.
  *
  * Xilinx Zynq Quad-SPI(QSPI) controller driver (master mode only)
  */
@@ -13,10 +14,12 @@
 #include <log.h>
 #include <malloc.h>
 #include <spi.h>
+#include <spi_flash.h>
 #include <asm/global_data.h>
 #include <asm/io.h>
 #include <linux/bitops.h>
 #include <spi-mem.h>
+#include "../mtd/spi/sf_internal.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -42,6 +45,21 @@ DECLARE_GLOBAL_DATA_PTR;
 #define ZYNQ_QSPI_TXD_00_01_OFFSET	0x80	/* Transmit 1-byte inst */
 #define ZYNQ_QSPI_TXD_00_10_OFFSET	0x84	/* Transmit 2-byte inst */
 #define ZYNQ_QSPI_TXD_00_11_OFFSET	0x88	/* Transmit 3-byte inst */
+#define ZYNQ_QSPI_FR_QOUT_CODE		0x6B    /* read instruction code */
+
+#define QSPI_SELECT_LOWER_CS            BIT(0)
+#define QSPI_SELECT_UPPER_CS            BIT(1)
+
+/*
+ * QSPI Linear Configuration Register
+ *
+ * It is named Linear Configuration but it controls other modes when not in
+ * linear mode also.
+ */
+#define ZYNQ_QSPI_LCFG_TWO_MEM_MASK     0x40000000 /* QSPI Enable Bit Mask */
+#define ZYNQ_QSPI_LCFG_SEP_BUS_MASK     0x20000000 /* QSPI Enable Bit Mask */
+#define ZYNQ_QSPI_LCFG_U_PAGE           0x10000000 /* QSPI Upper memory set */
+#define ZYNQ_QSPI_LCFG_DUMMY_SHIFT      8
 
 #define ZYNQ_QSPI_TXFIFO_THRESHOLD	1	/* Tx FIFO threshold level*/
 #define ZYNQ_QSPI_RXFIFO_THRESHOLD	32	/* Rx FIFO threshold level */
@@ -101,7 +119,11 @@ struct zynq_qspi_priv {
 	int bytes_to_transfer;
 	int bytes_to_receive;
 	unsigned int is_inst;
+	unsigned int is_parallel;
+	unsigned int is_stacked;
+	unsigned int u_page;
 	unsigned cs_change:1;
+	unsigned is_strip:1;
 };
 
 static int zynq_qspi_of_to_plat(struct udevice *bus)
@@ -112,7 +134,6 @@ static int zynq_qspi_of_to_plat(struct udevice *bus)
 
 	plat->regs = (struct zynq_qspi_regs *)fdtdec_get_addr(blob,
 							      node, "reg");
-
 	return 0;
 }
 
@@ -147,6 +168,9 @@ static void zynq_qspi_init_hw(struct zynq_qspi_priv *priv)
 	/* Disable Interrupts */
 	writel(ZYNQ_QSPI_IXR_ALL_MASK, &regs->idr);
 
+	/* Disable linear mode as the boot loader may have used it */
+	writel(0x0, &regs->lqspicfg);
+
 	/* Clear the TX and RX threshold reg */
 	writel(ZYNQ_QSPI_TXFIFO_THRESHOLD, &regs->txftr);
 	writel(ZYNQ_QSPI_RXFIFO_THRESHOLD, &regs->rxftr);
@@ -164,12 +188,11 @@ static void zynq_qspi_init_hw(struct zynq_qspi_priv *priv)
 	confr |= ZYNQ_QSPI_CR_IFMODE_MASK | ZYNQ_QSPI_CR_MCS_MASK |
 		ZYNQ_QSPI_CR_PCS_MASK | ZYNQ_QSPI_CR_FW_MASK |
 		ZYNQ_QSPI_CR_MSTREN_MASK;
-	writel(confr, &regs->cr);
 
-	/* Disable the LQSPI feature */
-	confr = readl(&regs->lqspicfg);
-	confr &= ~ZYNQ_QSPI_LQSPICFG_LQMODE_MASK;
-	writel(confr, &regs->lqspicfg);
+	if (priv->is_stacked)
+		confr |= 0x10;
+
+	writel(confr, &regs->cr);
 
 	/* Enable SPI */
 	writel(ZYNQ_QSPI_ENR_SPI_EN_MASK, &regs->enr);
@@ -181,6 +204,7 @@ static int zynq_qspi_child_pre_probe(struct udevice *bus)
 	struct zynq_qspi_priv *priv = dev_get_priv(bus->parent);
 
 	priv->max_hz = slave->max_hz;
+	slave->multi_cs_cap = true;
 
 	return 0;
 }
@@ -363,8 +387,8 @@ static void zynq_qspi_fill_tx_fifo(struct zynq_qspi_priv *priv, u32 size)
 	unsigned len, offset;
 	struct zynq_qspi_regs *regs = priv->regs;
 	static const unsigned offsets[4] = {
-		ZYNQ_QSPI_TXD_00_00_OFFSET, ZYNQ_QSPI_TXD_00_01_OFFSET,
-		ZYNQ_QSPI_TXD_00_10_OFFSET, ZYNQ_QSPI_TXD_00_11_OFFSET };
+		ZYNQ_QSPI_TXD_00_01_OFFSET, ZYNQ_QSPI_TXD_00_10_OFFSET,
+		ZYNQ_QSPI_TXD_00_11_OFFSET, ZYNQ_QSPI_TXD_00_00_OFFSET };
 
 	while ((fifocount < size) &&
 			(priv->bytes_to_transfer > 0)) {
@@ -386,7 +410,11 @@ static void zynq_qspi_fill_tx_fifo(struct zynq_qspi_priv *priv, u32 size)
 				return;
 			len = priv->bytes_to_transfer;
 			zynq_qspi_write_data(priv, &data, len);
-			offset = (priv->rx_buf) ? offsets[0] : offsets[len];
+			if ((priv->is_parallel || priv->is_stacked) &&
+			    !priv->is_inst && (len % 2))
+				len++;
+			offset = (priv->rx_buf) ?
+				 offsets[3] : offsets[len - 1];
 			writel(data, &regs->cr + (offset / 4));
 		}
 	}
@@ -491,6 +519,7 @@ static int zynq_qspi_irq_poll(struct zynq_qspi_priv *priv)
  */
 static int zynq_qspi_start_transfer(struct zynq_qspi_priv *priv)
 {
+	static u8 current_u_page;
 	u32 data = 0;
 	struct zynq_qspi_regs *regs = priv->regs;
 
@@ -500,6 +529,34 @@ static int zynq_qspi_start_transfer(struct zynq_qspi_priv *priv)
 	priv->bytes_to_transfer = priv->len;
 	priv->bytes_to_receive = priv->len;
 
+	if (priv->is_parallel)
+		writel((ZYNQ_QSPI_LCFG_TWO_MEM_MASK |
+			ZYNQ_QSPI_LCFG_SEP_BUS_MASK |
+			(1 << ZYNQ_QSPI_LCFG_DUMMY_SHIFT) |
+			ZYNQ_QSPI_FR_QOUT_CODE), &regs->lqspicfg);
+
+	if (priv->is_inst && priv->is_stacked && current_u_page != priv->u_page) {
+		if (priv->u_page) {
+			/* Configure two memories on shared bus
+			 * by enabling upper mem
+			 */
+			writel((ZYNQ_QSPI_LCFG_TWO_MEM_MASK |
+				ZYNQ_QSPI_LCFG_U_PAGE |
+				(1 << ZYNQ_QSPI_LCFG_DUMMY_SHIFT) |
+				ZYNQ_QSPI_FR_QOUT_CODE),
+				&regs->lqspicfg);
+		} else {
+			/* Configure two memories on shared bus
+			 * by enabling lower mem
+			 */
+			writel((ZYNQ_QSPI_LCFG_TWO_MEM_MASK |
+				(1 << ZYNQ_QSPI_LCFG_DUMMY_SHIFT) |
+				ZYNQ_QSPI_FR_QOUT_CODE),
+				&regs->lqspicfg);
+		}
+		current_u_page = priv->u_page;
+	}
+
 	if (priv->len < 4)
 		zynq_qspi_fill_tx_fifo(priv, priv->len);
 	else
@@ -599,7 +656,8 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	 * Assume that the beginning of a transfer with bits to
 	 * transmit must contain a device command.
 	 */
-	if (dout && flags & SPI_XFER_BEGIN)
+	if ((dout && flags & SPI_XFER_BEGIN) ||
+	    (flags & SPI_XFER_END && !priv->is_strip))
 		priv->is_inst = 1;
 	else
 		priv->is_inst = 0;
@@ -609,6 +667,11 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	else
 		priv->cs_change = 0;
 
+	if (flags & SPI_XFER_U_PAGE)
+		priv->u_page = 1;
+	else
+		priv->u_page = 0;
+
 	zynq_qspi_transfer(priv);
 
 	return 0;
@@ -672,14 +735,34 @@ static int zynq_qspi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
+bool update_stripe(const struct spi_mem_op *op)
+{
+	if (op->cmd.opcode == SPINOR_OP_BE_4K ||
+	    op->cmd.opcode == SPINOR_OP_CHIP_ERASE ||
+	    op->cmd.opcode == SPINOR_OP_SE ||
+	    op->cmd.opcode == SPINOR_OP_WREAR
+	)
+		return false;
+
+	return true;
+}
+
 static int zynq_qspi_exec_op(struct spi_slave *slave,
 			     const struct spi_mem_op *op)
 {
+	struct udevice *bus = slave->dev->parent;
+	struct zynq_qspi_priv *priv = dev_get_priv(bus);
 	int op_len, pos = 0, ret, i;
 	unsigned int flag = 0;
 	const u8 *tx_buf = NULL;
 	u8 *rx_buf = NULL;
 
+	if ((slave->flags & QSPI_SELECT_LOWER_CS) &&
+	    (slave->flags & QSPI_SELECT_UPPER_CS))
+		priv->is_parallel = true;
+	if (slave->flags & SPI_XFER_STACKED)
+		priv->is_stacked = true;
+
 	if (op->data.nbytes) {
 		if (op->data.dir == SPI_MEM_DATA_IN)
 			rx_buf = op->data.buf.in;
@@ -704,6 +787,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	if (op->dummy.nbytes)
 		memset(op_buf + pos, 0xff, op->dummy.nbytes);
 
+	if (slave->flags & SPI_XFER_U_PAGE)
+		flag |= SPI_XFER_U_PAGE;
+
 	/* 1st transfer: opcode + address + dummy cycles */
 	/* Make sure to set END bit if no tx or rx data messages follow */
 	if (!tx_buf && !rx_buf)
@@ -714,6 +800,8 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	if (ret)
 		return ret;
 
+	priv->is_strip = update_stripe(op);
+
 	/* 2nd transfer: rx or tx data path */
 	if (tx_buf || rx_buf) {
 		ret = zynq_qspi_xfer(slave->dev, op->data.nbytes * 8, tx_buf,
@@ -722,6 +810,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 			return ret;
 	}
 
+	priv->is_parallel = false;
+	priv->is_stacked = false;
+	slave->flags &= ~SPI_XFER_MASK;
 	spi_release_bus(slave);
 
 	return 0;
-- 
2.25.1

