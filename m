Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6C3CCFA17
	for <u-boot@archiver.kernel.org>; Thu, 26 Sep 2024 04:57:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7DB9488CE1;
	Thu, 26 Sep 2024 06:56:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ilVKc/Tj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 542E588D4D; Thu, 26 Sep 2024 06:56:03 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A9E888CE1
 for <u-boot@lists.denx.de>; Thu, 26 Sep 2024 06:55:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNG0SLnJbeEar91RPA6r3NeD2BcIg5Je9q3svAjodhPNfjBhmoIDW1+KEzReTTI6WgUOuNbI0nQarGnA3XufJZqBhajmpVSGTMt6uw9ZImZzOGJ3kohOtUSBGEhwr7V3jkRV/4ZYJHMI+ALxkR2RYT3qpwBdpq1LMOuenXMrRm5/QybUcRfbY0LlWKwKy6BXbZQ3OWUitWow5LCSiZvU8vSUK01EE5EtbrPZXU6D3HzqzFo9xOqUr1M1A+ZcltDJeJNr9TgB+jSKO0o8d4DCUI5vR5utOqyicsQlDafvKH0pQkG0/tcBqaTqYNXyHHqT9KlzcvJqtQLPEmJxnrHLHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcWBnnNbCA235n9SWKAjyRgRH+XV6ALQ1W95zQe4/sI=;
 b=v4AegSHWl4OfPZdn2QN9Oqyi01lqSJqrN2jLNlJ0NDQ8mbDc4xqFs4jDpFD38G0AX5xZdsLLyxFXsuEfsooFzl3sxzy4B9QfEd7YYTt9e6chH1XCxyzKHn8DIQFowSORnJRs476bltxkhzZfyZUE2t147a/t7KB6lRGxl3HdRTLoFaSFtuwgIF4lhAJ3kho3M1xE8aE4z6PD5svXNZl/hymeP8LH6f+zrx7F+of/+kN8PRKUPpx/ZfQg5LDI8+T9+lSg2NwqfkTYlFTQF0hJow+cpz9ru6pu55j7pQAizC65LarPl35UuH7lMyi4dRz1g5U1xHr0zZ8+tlAf0L6Weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcWBnnNbCA235n9SWKAjyRgRH+XV6ALQ1W95zQe4/sI=;
 b=ilVKc/Tj5cVUzw3Xx6qHuYrhaRs+3Ol1pqTtmfIdg2XGx0U0g3NoPleUa8+YpcoiIpMF1LuZJcJ+doyC41Wvn/yonqz5/KwKRFMsOgSe0GKHQwmwnNmbkJxx/hoN6T8ny9JCYRb1Kh72dKUvXHvKJYUFtDJyw5xksQ7LP3ZxCWA=
Received: from BYAPR06CA0026.namprd06.prod.outlook.com (2603:10b6:a03:d4::39)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Thu, 26 Sep
 2024 04:55:35 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:d4:cafe::c7) by BYAPR06CA0026.outlook.office365.com
 (2603:10b6:a03:d4::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25 via Frontend
 Transport; Thu, 26 Sep 2024 04:55:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Thu, 26 Sep 2024 04:55:35 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 25 Sep
 2024 23:55:33 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 25 Sep 2024 23:55:31 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v14 7/8] spi: zynq_qspi: Add parallel memories support in QSPI
 driver
Date: Thu, 26 Sep 2024 10:25:07 +0530
Message-ID: <20240926045508.1492638-8-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
References: <20240926045508.1492638-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 38d04047-bca6-48b9-3a0e-08dcdde77563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s3YFqZOzF6AsDNUGpCGR4ZzQP9gDmsVzKF02DeokdDcg4sma7ZAvUNTzw3KY?=
 =?us-ascii?Q?tsilH/S/u+UmspwTf8wSx97h7o7JIwhk3fuuzkpzNB/AeAX/vMzZxt0KIVB7?=
 =?us-ascii?Q?m+eWHd2CefxRpfefP8foFAAz97VkSmzLI4bYllQyKUA0LSikiOSR7OyXUSVZ?=
 =?us-ascii?Q?KKbKXqawWIa1Oj33e4xuOJchmd9TbP5nAp8Fomnb+SvRvKpWpKK//dUqMPjr?=
 =?us-ascii?Q?BtTp/tLJc+QjFDQD5DU3P/Y4g/WbBQFt+5cKcEKe77VcgsrDljgYfp8Gf0Y+?=
 =?us-ascii?Q?F3Iwo8p/cV25BEZayNRljh+TzXFRpXFFHMWAWt2MoSBaBoAXipybGT/nwxl7?=
 =?us-ascii?Q?hGsNOhpEJtISz6jhzNimF8jvFsqzh24CNqfd+ag/nXTyz+yHEse87fk9vJVA?=
 =?us-ascii?Q?3mCq1SFLy8FQUeXhBWHCF9cLpSkxmDJoCatIBXIBRZc0FWc7Ls0M3ZF2Zvug?=
 =?us-ascii?Q?XWPcaIq8J5T9Tvv1pvAK8X9w1QKmqmFIfdd9QimaewxVvQlxdYC8llw1LkXs?=
 =?us-ascii?Q?P52+PukvzvABX5GSEJtKcXMhOq+RpR6L5PW4eD/XElo9e9XXai7M54EeU7ZS?=
 =?us-ascii?Q?E9TZlkX3Ba8hZXBJ13R5kIdGMCa42pyCQiuIYTRJbZJvGUnkxm3RWL6euCyy?=
 =?us-ascii?Q?M7tl4mC+o0TkjYYpjasIcdDDwtrk8uNtRbepomEDkA5QYrnTO9ruJbP9met3?=
 =?us-ascii?Q?dLbp8XeUYcoFtMZjrJmpqUn3zJ+he8VNCAJZb9SOVHNlNjV0CB9GBrpYOJB0?=
 =?us-ascii?Q?oBilOywVuFpMCKudpRvGUVt/rwtnTjhV7rcNY0CReOJ1GBRuqZ2WkQEOOx/i?=
 =?us-ascii?Q?Oe+DL7SnDuZtT5cyC+FSC1LpBDOOvRiHp1ozhRjdxxDLBJSZaNQDdiu0ApTE?=
 =?us-ascii?Q?gqB4DjAR1cDyLolVd9dWNx42ZzQltxWXpI56Uz7xYkEbOaDnXHlhnhC2GlMA?=
 =?us-ascii?Q?B24jzDNIbdLKkqSaVxMwP8C+0d1vla7WmqK145VosOcoFh9S+pOEDqTnOQFA?=
 =?us-ascii?Q?JS11NL2jfnameHWEhrn0Qc8OJ2rU+W3OPhH1KLqLXMm4IfKhPfCY2BLfI8yw?=
 =?us-ascii?Q?SNi+rllx10fjYiKo5RRSSee+E6PHkvQTHbHySJuR3uKGm3NYGO9SwJ5WWUPm?=
 =?us-ascii?Q?KybP6n+XcVK69NbK68+HOumrwQU4tUpfrVIVZLZQtIwD1/sHCmUhrVxx7F9w?=
 =?us-ascii?Q?gTQ32J+VY58Qhf5YPY75nlhRgwH72Cc9zbxUyPNBo2nZ2QL15bN/VsSNBn6M?=
 =?us-ascii?Q?Nq6yhEv0D7Z/CffJTpT0sSXIPqz6xZpVxD6Pq9+xAvh6PpIM6tve++9Gvfpd?=
 =?us-ascii?Q?qLE0J32CZ4jE8LrQCYO+Q81O8h3Met07i3itGHXJx/N6+i+7/ZmSl+Z8iT17?=
 =?us-ascii?Q?xTADXaUSLcZuYn8pbH+5tokfem/P?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2024 04:55:35.4982 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38d04047-bca6-48b9-3a0e-08dcdde77563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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
 drivers/spi/zynq_qspi.c | 115 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 104 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index e8bc196ce9..f5b3fb5c12 100644
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
@@ -12,10 +13,12 @@
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
 
@@ -41,6 +44,21 @@ DECLARE_GLOBAL_DATA_PTR;
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
@@ -100,7 +118,11 @@ struct zynq_qspi_priv {
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
@@ -111,7 +133,6 @@ static int zynq_qspi_of_to_plat(struct udevice *bus)
 
 	plat->regs = (struct zynq_qspi_regs *)fdtdec_get_addr(blob,
 							      node, "reg");
-
 	return 0;
 }
 
@@ -146,6 +167,9 @@ static void zynq_qspi_init_hw(struct zynq_qspi_priv *priv)
 	/* Disable Interrupts */
 	writel(ZYNQ_QSPI_IXR_ALL_MASK, &regs->idr);
 
+	/* Disable linear mode as the boot loader may have used it */
+	writel(0x0, &regs->lqspicfg);
+
 	/* Clear the TX and RX threshold reg */
 	writel(ZYNQ_QSPI_TXFIFO_THRESHOLD, &regs->txftr);
 	writel(ZYNQ_QSPI_RXFIFO_THRESHOLD, &regs->rxftr);
@@ -163,12 +187,11 @@ static void zynq_qspi_init_hw(struct zynq_qspi_priv *priv)
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
@@ -180,6 +203,7 @@ static int zynq_qspi_child_pre_probe(struct udevice *bus)
 	struct zynq_qspi_priv *priv = dev_get_priv(bus->parent);
 
 	priv->max_hz = slave->max_hz;
+	slave->multi_cs_cap = true;
 
 	return 0;
 }
@@ -362,8 +386,8 @@ static void zynq_qspi_fill_tx_fifo(struct zynq_qspi_priv *priv, u32 size)
 	unsigned len, offset;
 	struct zynq_qspi_regs *regs = priv->regs;
 	static const unsigned offsets[4] = {
-		ZYNQ_QSPI_TXD_00_00_OFFSET, ZYNQ_QSPI_TXD_00_01_OFFSET,
-		ZYNQ_QSPI_TXD_00_10_OFFSET, ZYNQ_QSPI_TXD_00_11_OFFSET };
+		ZYNQ_QSPI_TXD_00_01_OFFSET, ZYNQ_QSPI_TXD_00_10_OFFSET,
+		ZYNQ_QSPI_TXD_00_11_OFFSET, ZYNQ_QSPI_TXD_00_00_OFFSET };
 
 	while ((fifocount < size) &&
 			(priv->bytes_to_transfer > 0)) {
@@ -385,7 +409,11 @@ static void zynq_qspi_fill_tx_fifo(struct zynq_qspi_priv *priv, u32 size)
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
@@ -490,6 +518,7 @@ static int zynq_qspi_irq_poll(struct zynq_qspi_priv *priv)
  */
 static int zynq_qspi_start_transfer(struct zynq_qspi_priv *priv)
 {
+	static u8 current_u_page;
 	u32 data = 0;
 	struct zynq_qspi_regs *regs = priv->regs;
 
@@ -499,6 +528,34 @@ static int zynq_qspi_start_transfer(struct zynq_qspi_priv *priv)
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
@@ -598,7 +655,8 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	 * Assume that the beginning of a transfer with bits to
 	 * transmit must contain a device command.
 	 */
-	if (dout && flags & SPI_XFER_BEGIN)
+	if ((dout && flags & SPI_XFER_BEGIN) ||
+	    (flags & SPI_XFER_END && !priv->is_strip))
 		priv->is_inst = 1;
 	else
 		priv->is_inst = 0;
@@ -608,6 +666,11 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	else
 		priv->cs_change = 0;
 
+	if (flags & SPI_XFER_U_PAGE)
+		priv->u_page = 1;
+	else
+		priv->u_page = 0;
+
 	zynq_qspi_transfer(priv);
 
 	return 0;
@@ -671,14 +734,35 @@ static int zynq_qspi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
+bool update_stripe(const struct spi_mem_op *op)
+{
+	if (op->cmd.opcode == SPINOR_OP_BE_4K ||
+	    op->cmd.opcode == SPINOR_OP_CHIP_ERASE ||
+	    op->cmd.opcode == SPINOR_OP_SE ||
+	    op->cmd.opcode == SPINOR_OP_WREAR ||
+	    op->cmd.opcode == SPINOR_OP_WRSR
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
@@ -703,6 +787,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	if (op->dummy.nbytes)
 		memset(op_buf + pos, 0xff, op->dummy.nbytes);
 
+	if (slave->flags & SPI_XFER_U_PAGE)
+		flag |= SPI_XFER_U_PAGE;
+
 	/* 1st transfer: opcode + address + dummy cycles */
 	/* Make sure to set END bit if no tx or rx data messages follow */
 	if (!tx_buf && !rx_buf)
@@ -713,6 +800,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 	if (ret)
 		return ret;
 
+	if (priv->is_parallel)
+		priv->is_strip = update_stripe(op);
+
 	/* 2nd transfer: rx or tx data path */
 	if (tx_buf || rx_buf) {
 		ret = zynq_qspi_xfer(slave->dev, op->data.nbytes * 8, tx_buf,
@@ -721,6 +811,9 @@ static int zynq_qspi_exec_op(struct spi_slave *slave,
 			return ret;
 	}
 
+	priv->is_parallel = false;
+	priv->is_stacked = false;
+	slave->flags &= ~SPI_XFER_MASK;
 	spi_release_bus(slave);
 
 	return 0;
-- 
2.25.1

