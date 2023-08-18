Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D06C05052
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:22:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 68B0586BF5;
	Fri, 18 Aug 2023 06:22:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ThnGk+pm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECA8F86AB9; Fri, 18 Aug 2023 06:22:16 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eae::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F0C4886C78
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:22:13 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ashok.reddy.soma@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVVw6YNVmogVpJoTnEQtBOqyWj3ovGmOkCx2fMVROmOUvdI3Vs8X9zZwog1fu43bhzsMqETPnCAfCQUDexoYeE6E8UOozHzMxU1Jd+GWtziRYFhIzcDFcBfEQKW3hvBxzR14SQaJ6RZ5fx5kp7BfF2B5aAs9qYBWQx4MBMdXagonQKv9jsnOH28RwFcy356HrYPVPcDb8tt8+kg9s5ET8R/dm3PQES+qROyVYJmX21K+gSNrZJHDr5m/A/lomM7uL9H5i3UY8M21F1GX5iF8k7aoMzf7yJHSkEmBZButY8RLiwEJUY9gNcL15WB57D/mkioNYXBho4V0pO2MW7sCgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=idoa35qVotnGFf3DAqM8pOztqPy0VJ2u2goyr3kfBy4=;
 b=KTQ3IO+DnJFm3PZC4Rng/89jj9u3W5CZL3xp1TsK+6aPIWEDCo19GUTxCO9+ywNXZs/1o6aczX1e4OvoKj8ML/0MkbvjeETia4MeV2Twr4ZCgXw3PnxVaK5zNLwNz0FmloSt7bTtc5wH+0Ms8SuGNBYNpXazq9H60xCLYadb4wpiU5/LtYd7zYOPMpeMrEdWONDLb5hnur+YT5vf7/UuYIabU5ot28h2i4UpHWlg+oTA94Q7qhPz7er6lY+Pmyf0h7Pt47ajCGyz2/6qEW8rAT88dfxP4Qa/liLc8YFXkKF5S36Jg1RTvZuZpM0i3s3rgH4JqiONlE6Kih87s4UQxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=idoa35qVotnGFf3DAqM8pOztqPy0VJ2u2goyr3kfBy4=;
 b=ThnGk+pmY0LOp22wEwGbTQ29EikHTWpc7z06cH9T9os4UUKIrffD9aV/xEG1JlERKuqtKlVtkCB9PQcRMfloAHoXypzWWuxLJ+/H9uG+XKiDmA+hiWSz0y1w1zC0h+9ABMVzOrVmva5XeyrbvxzFF2AI4YzYAlSyWPB9U6nhUhQ=
Received: from SN7PR04CA0181.namprd04.prod.outlook.com (2603:10b6:806:126::6)
 by PH0PR12MB7791.namprd12.prod.outlook.com (2603:10b6:510:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 04:22:06 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::23) by SN7PR04CA0181.outlook.office365.com
 (2603:10b6:806:126::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
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
 15.20.6699.14 via Frontend Transport; Fri, 18 Aug 2023 04:22:06 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:22:06 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 21:22:05 -0700
Received: from xhdashokred41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 23:22:03 -0500
From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <sjg@chromium.org>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 7/7] spi: zynq_qspi: Add parallel memories support in QSPI
 driver
Date: Thu, 17 Aug 2023 22:21:19 -0600
Message-ID: <20230818042119.25722-8-ashok.reddy.soma@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH0PR12MB7791:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c5c807d-1b59-4d35-cc62-08db9fa2aea7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X1JQL6BLXi9e+LhM5ymhR+CWPYQrTYD5amMQR/M2C2eVKfrj5KJH1I4+WSaY9vxo9KnGvUjPAgCYdoCVN3wcQCqYK3VuH5Ifru65S3Ws0fIszhnEKjGJpRXL82ly0vhCyyJPjhWArYDUwLXQsNwZe3KnJgezNclSloLyjYQqrclUySpCYoPEIPzmzZ+VTjgTPgwdMmq0b46ylXQXBAShQNemparhtlK8fS0WqiuTsOOqw4TIheiaEwqRRXE/bMW2seoll46olTtM7QpeoQV8seBX43IMipJTreWIOD/m7E1JF/RP3ouE/BWe1ne1h/aHxWv13p61cF5Hp5wc/UqpBX2cEuUMJ7MuaeFh3vQX7/wWV0H7WtMHHZ3LhlFQkuSsLbpLB8F7W3eJ9QQsNcvwh/2vpl2WZEo1Or+4t7VMCVxRSB2MgdFELnJib7k4f8/l+ZYFdVlxJ2CjM3pzRKWV+gDIU1Z3b6qWef8OiggB0Tvsa+VGzzLlOaVr17kEpjlqG+5InA+PBpo2F94Wjv9xFegP18/BaF/+5ULBjBBEnN5QAQovLqBFYcwpcV2gPlrB4zTLktM33e3NWEJ7VesCuLoOJvQyBF5EL9BH/Sw4vf5TDfk+pDGQVW7axuAQOrKKf4dPQ4XPpLbr4C9eIhc/6On5HEGc/zihVstjDlG3L8uK/MoX+YzReCt/PnoR9I7frjLCoI2OFOj2VIib8251c08urA7R948hEjsVDexaectWXeLQarNgDzzauqA8l0FySUJKpoc/aNXaH3Y5qvjk3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199024)(82310400011)(186009)(1800799009)(36840700001)(40470700004)(46966006)(40460700003)(2616005)(36860700001)(426003)(1076003)(336012)(26005)(6666004)(47076005)(83380400001)(5660300002)(8936002)(8676002)(4326008)(2906002)(478600001)(41300700001)(70586007)(70206006)(6916009)(54906003)(316002)(82740400003)(356005)(81166007)(40480700001)(103116003)(86362001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 04:22:06.6182 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c5c807d-1b59-4d35-cc62-08db9fa2aea7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7791
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

 drivers/spi/zynq_qspi.c | 139 ++++++++++++++++++++++++++++++++++++----
 include/spi.h           |   3 +
 2 files changed, 129 insertions(+), 13 deletions(-)

diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index 069d2a77de..9f4c1f487b 100644
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
 
@@ -42,6 +45,22 @@ DECLARE_GLOBAL_DATA_PTR;
 #define ZYNQ_QSPI_TXD_00_01_OFFSET	0x80	/* Transmit 1-byte inst */
 #define ZYNQ_QSPI_TXD_00_10_OFFSET	0x84	/* Transmit 2-byte inst */
 #define ZYNQ_QSPI_TXD_00_11_OFFSET	0x88	/* Transmit 3-byte inst */
+#define ZYNQ_QSPI_FR_QOUT_CODE		0x6B	/* read instruction code */
+#define ZYNQ_QSPI_FR_DUALIO_CODE	0xBB
+
+#define QSPI_SELECT_LOWER_CS		BIT(0)
+#define QSPI_SELECT_UPPER_CS		BIT(1)
+
+/*
+ * QSPI Linear Configuration Register
+ *
+ * It is named Linear Configuration but it controls other modes when not in
+ * linear mode also.
+ */
+#define ZYNQ_QSPI_LCFG_TWO_MEM_MASK	0x40000000 /* QSPI Enable Bit Mask */
+#define ZYNQ_QSPI_LCFG_SEP_BUS_MASK	0x20000000 /* QSPI Enable Bit Mask */
+#define ZYNQ_QSPI_LCFG_U_PAGE		0x10000000 /* QSPI Upper memory set */
+#define ZYNQ_QSPI_LCFG_DUMMY_SHIFT	8
 
 #define ZYNQ_QSPI_TXFIFO_THRESHOLD	1	/* Tx FIFO threshold level*/
 #define ZYNQ_QSPI_RXFIFO_THRESHOLD	32	/* Rx FIFO threshold level */
@@ -101,7 +120,12 @@ struct zynq_qspi_priv {
 	int bytes_to_transfer;
 	int bytes_to_receive;
 	unsigned int is_inst;
+	unsigned int is_parallel;
+	unsigned int is_stacked;
+	unsigned int is_dio;
+	unsigned int u_page;
 	unsigned cs_change:1;
+	unsigned is_strip:1;
 };
 
 static int zynq_qspi_of_to_plat(struct udevice *bus)
@@ -112,7 +136,6 @@ static int zynq_qspi_of_to_plat(struct udevice *bus)
 
 	plat->regs = (struct zynq_qspi_regs *)fdtdec_get_addr(blob,
 							      node, "reg");
-
 	return 0;
 }
 
@@ -147,6 +170,9 @@ static void zynq_qspi_init_hw(struct zynq_qspi_priv *priv)
 	/* Disable Interrupts */
 	writel(ZYNQ_QSPI_IXR_ALL_MASK, &regs->idr);
 
+	/* Disable linear mode as the boot loader may have used it */
+	writel(0x0, &regs->lqspicfg);
+
 	/* Clear the TX and RX threshold reg */
 	writel(ZYNQ_QSPI_TXFIFO_THRESHOLD, &regs->txftr);
 	writel(ZYNQ_QSPI_RXFIFO_THRESHOLD, &regs->rxftr);
@@ -164,12 +190,11 @@ static void zynq_qspi_init_hw(struct zynq_qspi_priv *priv)
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
@@ -180,6 +205,8 @@ static int zynq_qspi_child_pre_probe(struct udevice *bus)
 	struct spi_slave *slave = dev_get_parent_priv(bus);
 	struct zynq_qspi_priv *priv = dev_get_priv(bus->parent);
 
+	slave->multi_cs_cap = true;
+	slave->dio = priv->is_dio;
 	priv->max_hz = slave->max_hz;
 
 	return 0;
@@ -363,8 +390,8 @@ static void zynq_qspi_fill_tx_fifo(struct zynq_qspi_priv *priv, u32 size)
 	unsigned len, offset;
 	struct zynq_qspi_regs *regs = priv->regs;
 	static const unsigned offsets[4] = {
-		ZYNQ_QSPI_TXD_00_00_OFFSET, ZYNQ_QSPI_TXD_00_01_OFFSET,
-		ZYNQ_QSPI_TXD_00_10_OFFSET, ZYNQ_QSPI_TXD_00_11_OFFSET };
+		ZYNQ_QSPI_TXD_00_01_OFFSET, ZYNQ_QSPI_TXD_00_10_OFFSET,
+		ZYNQ_QSPI_TXD_00_11_OFFSET, ZYNQ_QSPI_TXD_00_00_OFFSET };
 
 	while ((fifocount < size) &&
 			(priv->bytes_to_transfer > 0)) {
@@ -386,7 +413,11 @@ static void zynq_qspi_fill_tx_fifo(struct zynq_qspi_priv *priv, u32 size)
 				return;
 			len = priv->bytes_to_transfer;
 			zynq_qspi_write_data(priv, &data, len);
-			offset = (priv->rx_buf) ? offsets[0] : offsets[len];
+			if ((priv->is_parallel || priv->is_stacked) &&
+			    !priv->is_inst && (len % 2))
+				len++;
+			offset = (priv->rx_buf) ?
+				  offsets[3] : offsets[len - 1];
 			writel(data, &regs->cr + (offset / 4));
 		}
 	}
@@ -491,6 +522,7 @@ static int zynq_qspi_irq_poll(struct zynq_qspi_priv *priv)
  */
 static int zynq_qspi_start_transfer(struct zynq_qspi_priv *priv)
 {
+	static u8 current_u_page;
 	u32 data = 0;
 	struct zynq_qspi_regs *regs = priv->regs;
 
@@ -500,6 +532,47 @@ static int zynq_qspi_start_transfer(struct zynq_qspi_priv *priv)
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
+			if (priv->is_dio == SF_DUALIO_FLASH)
+				writel((ZYNQ_QSPI_LCFG_TWO_MEM_MASK |
+					ZYNQ_QSPI_LCFG_U_PAGE |
+					(1 << ZYNQ_QSPI_LCFG_DUMMY_SHIFT) |
+					ZYNQ_QSPI_FR_DUALIO_CODE),
+					&regs->lqspicfg);
+			else
+				/* Configure two memories on shared bus
+				 * by enabling upper mem
+				 */
+				writel((ZYNQ_QSPI_LCFG_TWO_MEM_MASK |
+					ZYNQ_QSPI_LCFG_U_PAGE |
+					(1 << ZYNQ_QSPI_LCFG_DUMMY_SHIFT) |
+					ZYNQ_QSPI_FR_QOUT_CODE),
+					&regs->lqspicfg);
+		} else {
+			if (priv->is_dio == SF_DUALIO_FLASH)
+				writel((ZYNQ_QSPI_LCFG_TWO_MEM_MASK |
+					(1 << ZYNQ_QSPI_LCFG_DUMMY_SHIFT) |
+					ZYNQ_QSPI_FR_DUALIO_CODE),
+					&regs->lqspicfg);
+			else
+				/* Configure two memories on shared bus
+				 * by enabling lower mem
+				 */
+				writel((ZYNQ_QSPI_LCFG_TWO_MEM_MASK |
+					(1 << ZYNQ_QSPI_LCFG_DUMMY_SHIFT) |
+					ZYNQ_QSPI_FR_QOUT_CODE),
+					&regs->lqspicfg);
+		}
+		current_u_page = priv->u_page;
+	}
+
 	if (priv->len < 4)
 		zynq_qspi_fill_tx_fifo(priv, priv->len);
 	else
@@ -599,7 +672,8 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	 * Assume that the beginning of a transfer with bits to
 	 * transmit must contain a device command.
 	 */
-	if (dout && flags & SPI_XFER_BEGIN)
+	if ((dout && flags & SPI_XFER_BEGIN) ||
+	    (flags & SPI_XFER_END && !priv->is_strip))
 		priv->is_inst = 1;
 	else
 		priv->is_inst = 0;
@@ -609,6 +683,11 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	else
 		priv->cs_change = 0;
 
+	if (flags & SPI_XFER_U_PAGE)
+		priv->u_page = 1;
+	else
+		priv->u_page = 0;
+
 	zynq_qspi_transfer(priv);
 
 	return 0;
@@ -672,14 +751,35 @@ static int zynq_qspi_set_mode(struct udevice *bus, uint mode)
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
+	u32 dummy_bytes = 0;
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
@@ -688,6 +788,11 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	}
 
 	op_len = op->cmd.nbytes + op->addr.nbytes + op->dummy.nbytes;
+	if (op->dummy.nbytes) {
+		op_len = op->cmd.nbytes + op->addr.nbytes +
+			 op->dummy.nbytes / op->dummy.buswidth;
+		dummy_bytes = op->dummy.nbytes / op->dummy.buswidth;
+	}
 
 	u8 op_buf[op_len];
 
@@ -701,8 +806,11 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 		pos += op->addr.nbytes;
 	}
 
-	if (op->dummy.nbytes)
-		memset(op_buf + pos, 0xff, op->dummy.nbytes);
+	if (dummy_bytes)
+		memset(op_buf + pos, 0xff, dummy_bytes);
+
+	if (slave->flags & SPI_XFER_U_PAGE)
+		flag |= SPI_XFER_U_PAGE;
 
 	/* 1st transfer: opcode + address + dummy cycles */
 	/* Make sure to set END bit if no tx or rx data messages follow */
@@ -714,6 +822,8 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	if (ret)
 		return ret;
 
+	priv->is_strip = update_stripe(op);
+
 	/* 2nd transfer: rx or tx data path */
 	if (tx_buf || rx_buf) {
 		ret = zynq_qspi_xfer(slave->dev, op->data.nbytes * 8, tx_buf,
@@ -722,6 +832,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 			return ret;
 	}
 
+	priv->is_parallel = false;
+	priv->is_stacked = false;
+	slave->flags &= ~SPI_XFER_MASK;
 	spi_release_bus(slave);
 
 	return 0;
diff --git a/include/spi.h b/include/spi.h
index b013f2eaa3..7d350bf04b 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -42,6 +42,8 @@
 #define SPI_3BYTE_MODE	0x0
 #define SPI_4BYTE_MODE	0x1
 
+#define SF_DUALIO_FLASH	0x1
+
 /* SPI transfer flags */
 #define SPI_XFER_STRIPE	(1 << 6)
 #define SPI_XFER_MASK	(3 << 8)
@@ -172,6 +174,7 @@ struct spi_slave {
 #define SPI_XFER_U_PAGE		BIT(4)
 #define SPI_XFER_STACKED	BIT(5)
 
+	u8 dio;
 	u32 bytemode;
 
 	/*
-- 
2.17.1

