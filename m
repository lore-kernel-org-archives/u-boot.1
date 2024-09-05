Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02118CD4F4E
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 03:23:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D05E88C78;
	Thu,  5 Sep 2024 05:23:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5mWRpBJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C0C388BF2; Thu,  5 Sep 2024 05:23:20 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB99188C66
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 05:23:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VcIKKuRk0sc8XZd0appjLTqJjhH4qvo4Mt5f6vvypWJn1QUm0F2/VD/OsJhD73dJtBsUBRynz6Kp1Nri9JnYZfLDMBqAV8pyLSxZV+tRvEIU89fkUQwfNqNfjLkPbbIjr6g39kYRqwgAU5bUyUJTcuwN7l98w0Xn/XPWRQ2KpURvXXaH4h1eGhtiWPVRkUsN9PkuogBEB19FOBkM56Rs83z8Y9sjv6OvnJ9UKxrM3i/b1AJ1d+FHO1ic577t2LHbnVPqd6iVxkapN0WbhDCjVHsxeBfsJdn7NDoHLFMXGkpXpnbofmGQmv9qiXpHF7FrE6aPARHy3jGL/qpwdSLw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcWBnnNbCA235n9SWKAjyRgRH+XV6ALQ1W95zQe4/sI=;
 b=yIgwAXGHqvLdyiTEPFTfDWAKCgo24d1v/C6BX9T58aAps3HSHOOinmT3r4hIRjynwtzccvtMvfqrv1CkhnIpXe2HVUYCrzlM6g5Q6bTEqa4pjmPva00i2CivYCMRCvIfCtaVcYUf7Tj2n0rG4YhdbQKAGUaGEeOc9g1IOS908pMzaQeHCwwnvQ8oINID9KnKolIj71n/QeBlVEZefEmAm/GNQoytBDl8WqzfMwBam6t19rhmDhrGzBIQvZWgBmvmrzwVknELuN2PZShKaqLqKuBdDB/0BTcu2fi/jFaClLZQxWPBUhLzVYNPjiBG/ceMuACMfR+CWKin2Vwzkqi5uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcWBnnNbCA235n9SWKAjyRgRH+XV6ALQ1W95zQe4/sI=;
 b=5mWRpBJK1fncW9y75nlyxS6Z6OIQmDNVwU3zFMkavcHdXRMoJg8P40gjaMZQUK5qiovt5jZOmHiBdW63RH2uTJjFAHXTRLa0u5SZFBxRx4/5Tz3ZVpALJkld5IjGevKh/84wXs743KIDemUASEkk4R7hB9HbK9iTnA96uV+En4U=
Received: from BY3PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:39a::32)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Thu, 5 Sep
 2024 03:23:11 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:39a:cafe::c7) by BY3PR03CA0027.outlook.office365.com
 (2603:10b6:a03:39a::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14 via Frontend
 Transport; Thu, 5 Sep 2024 03:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 5 Sep 2024 03:23:11 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 4 Sep
 2024 22:23:08 -0500
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 4 Sep 2024 22:23:06 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v13 8/8] spi: zynq_qspi: Add parallel memories support in QSPI
 driver
Date: Thu, 5 Sep 2024 08:51:46 +0530
Message-ID: <20240905032146.2470396-9-venkatesh.abbarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b0b09ce-2301-4e54-ada9-08dccd5a1200
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?V3DDtVCyUzHlS5E8oH1gyJIzbQBF7bclOGxeLq5rHDrGDABWFtveRA/ShSR5?=
 =?us-ascii?Q?lb6ZyxrPJ2nM1+zYAu3QWN0B1Y5rYmAfo/TIgerF+EBb4NRRpCwROd4Tpm1H?=
 =?us-ascii?Q?7gFfE3/KVqGVgZasReiWNofqY0F5S1akpXjBrwjseO/+iofYICafc/MV7yeL?=
 =?us-ascii?Q?Bo3CxlSHih2oIxvu7wAfWQC0VgKjJIWLqTbCFhHUrbD9TquG74QZnhjJD4wy?=
 =?us-ascii?Q?xwSpkabObhbJuTse7RLHSONaTa4YCO24o+TND7Q3xhslHr/ki9OJyKQCikQS?=
 =?us-ascii?Q?3CGFFl4laW0FvraIL0xGQPLahEi+o/pIStSBQjEtCoGjkkg7nn9A2EPVg6UI?=
 =?us-ascii?Q?+FqAS5cKTm9QuPZpRSaUJk5l1jdCUoNoGz3K+Pe0wHMhxVFmDDA6zxtnkK4r?=
 =?us-ascii?Q?m7gkW/HoRYX9yBiTwg752OSnW7YJwkWpkY7UN31W3WZxqJI+z9tm9qMdBGdc?=
 =?us-ascii?Q?Ywevx+Y/GsAtQi54CbaWvvlEVDcZ0795mqf2IpPPbtXc2TATjBVpp3TN9ri6?=
 =?us-ascii?Q?FuqNoeF9pKWOi3wZ73atdUEf6/byb6s/eb68BSyzNF9ou/O/JOAXSskymhYM?=
 =?us-ascii?Q?MmctrSbO3+q47UD6CWR/+8MFrw2gkfEskFx2M/zQ2ZQhMSBi8hWKSuWqoC2N?=
 =?us-ascii?Q?B8+Y2b59+Jf6pTMpOe/1X1lYDabicgd+239DF9Y4vPIUeSQsA4NqFOIoUUyF?=
 =?us-ascii?Q?4AMC2iUbgiKi1Gkgb/YqRKrGQBwQXx5NRoebrc19X5bSe90Il3T0VOPQBgcJ?=
 =?us-ascii?Q?+gnGwB3MNcH6vXAXozHWn7gxe9opKr+Pzosi0NnhNsYALeUsYEEJ5pngSU0T?=
 =?us-ascii?Q?mgTWnATMpIWG4Vc2n0DNZGRu3LFGvdBOnazgHxvq73hTWe4e/1YCvjWk3e2y?=
 =?us-ascii?Q?xIeUBH1SoHRvHH2eSPA0O2YH9pHLeZSs2rEeFCS7u47wD+azFoaI3bzXsKL7?=
 =?us-ascii?Q?LmBrFG8b2jw4N50dC3FwEUNOihLiVi9mxNafAH/HV1xicbuOkkW9NMKGt8Ss?=
 =?us-ascii?Q?g2SkDTVouDVexF1LYVy0m6gBO5rnN+JNp8I8jT3s5wNCF/QnFwGiO2LCHZzE?=
 =?us-ascii?Q?Rsb92T8BTuZ9LtLIgO3GEHFYDkXELm1rDfHJNFTZwbEdL9ulKrF1BG3lCzu/?=
 =?us-ascii?Q?OrMrin+oh1sOKCIZudEAJC2QwnA8YvlfHmuEYnLiXZosJfKdInMIfOwAP10q?=
 =?us-ascii?Q?q3q8ebOnzQtivkJ1gaDhUxwww1frqG7unsphtyk0nUL5wsFmw26YBPOSYae3?=
 =?us-ascii?Q?aIqfTqwh9KX0inHgQyk+THpd1fumjUuVNwahjsa98nnOUWEQ2SpbVDhEmknh?=
 =?us-ascii?Q?rzUHUMuMKqlKUVFDeCfCNE13CG5qecsWucjm0PKD001ANZnNmp7Qwf9hI/6d?=
 =?us-ascii?Q?uWS0GMe/ckdmddZPlfMHYjVVULCNHn/L4ixRmws+E2hN87/BmmZrIgxhj8P6?=
 =?us-ascii?Q?2OLBmjQLjLnazkJ8IQN7oerTvOAo+Uvc?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 03:23:11.0990 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b0b09ce-2301-4e54-ada9-08dccd5a1200
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414
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

