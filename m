Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6A2C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 13:05:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6816E84B43;
	Thu,  9 Jul 2026 15:05:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WH1j+Wmk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3DE084AB8; Thu,  9 Jul 2026 10:38:59 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 40A38849BA
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 10:38:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Suraj.HanumantKakade@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxcNaxWyE4MB1fSrOO7waTBFlQI+pVQUu7SbJom1ixpqhjhPF2uySZLFs8+IiHxj3Gc3oiB7wxzhyJE8gJay675VVNQKuVRfRHih8jYLKU4Bt5byx2YOS4FToS8uzep8O4ToKI/Wi3cLHp9/KntwYW8BF0mvsp/zFmpHeaWcdoJsQ1s2uh5s755yMHgpCFknFZhnECq8/iv/Q5RoCNb5CfKSXXgSapmnX4+vCYFrbyTf391DTPQr/eEYeE2yWmhDEsiPiz/cBg8Hmb9e3loePVx4cc4fJHypKlIgAsN0rPkuGMJhxYAfNAetn2IeVIZ0e2Nrrt7+EwxhAQ8qy2Y5kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xdkJrbkPzD/3IBwXF+rcJaPig/JtsU5HXmeOgB0K+/U=;
 b=xqgw2FZZnkZ13AVFr2Jc2pxLDygpQaZHVBQ7q53vLV5jLjkHHi3u4twbC58nWCo6d1IeW6lCp/Q7G/p8xcUOzzGeYkIQ1zNiLpNsAQRT4D2igJPZso6ga/MbUspMpPUtHzmCNGB5zDsK3gSBDXCY8njyNDhibXThbqus13Onh6QCUmD8WcC/MnvhqqkL3ol7+kSAkX/vrs5l14cMP4JUxVZExcDG5+QLFeuB0DQUKr1QJqwnYy5Xa5C6qRdmrz03sRgKF8HZ8OD7L2efsS1aZhJjD9gLkMoQr5kay2X6KTNkAQIMLWAChL3sgT9wFz5UMOCAhIWoUZZI8XWugz/GbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xdkJrbkPzD/3IBwXF+rcJaPig/JtsU5HXmeOgB0K+/U=;
 b=WH1j+Wmk01FdrV4xCoL7ayi9cYvZW6qy4hqLBAXjyPqSzNbkYkpWYuhQXoFlL0VP8ccDM68w0wLRdEek0C8LJ3eeb2b5iLoXHuqE4ybulv7giHJlQ8+uTB20/QEN0MhQ5NshKF482uKOcQie8nIcbel0GFmmxzRYlXdhKcV9UE0=
Received: from BLAPR03CA0120.namprd03.prod.outlook.com (2603:10b6:208:32a::35)
 by DS0PR12MB8342.namprd12.prod.outlook.com (2603:10b6:8:f9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 08:38:51 +0000
Received: from MN1PEPF0000F0E1.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::69) by BLAPR03CA0120.outlook.office365.com
 (2603:10b6:208:32a::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Thu, 9
 Jul 2026 08:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E1.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 08:38:51 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 03:38:49 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41 via Frontend
 Transport; Thu, 9 Jul 2026 03:38:47 -0500
From: Suraj Kakade <suraj.hanumantkakade@amd.com>
To: <u-boot@lists.denx.de>, <michal.simek@amd.com>
CC: <git@amd.com>, <padmarao.begari@amd.com>, Suraj Kakade
 <suraj.hanumantkakade@amd.com>, Tom Rini <trini@konsulko.com>, Jagan Teki
 <jagan@openedev.com>, Siva Durga Prasad Paladugu
 <siva.durga.prasad.paladugu@amd.com>
Subject: [PATCH] spi: zynqmp_gqspi: fix quad mode bus conflict
Date: Thu, 9 Jul 2026 14:07:26 +0530
Message-ID: <20260709083757.1851446-1-suraj.hanumantkakade@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E1:EE_|DS0PR12MB8342:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f3a3b7-c6a6-4390-fc24-08dedd9580e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|18002099003|56012099006|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: pwLKlpSvszSOTzDW+fSHLOEWOGXjRepIVM5Q+foLocHUewgD2GaxYgIm74uu+WQpIynEfCzwRBnccXIKfOb5mNhknzd/fO4gDVgbRqJyWsuhmAJ6HfArAFdVEHw2RHuu3GjiJdiq1s+ldO5qN4y6iiHEMv4cGtiTgKkRFm27NfQ6bGIJWpKQS/xNb71QQJjahG6cfMrEf8BmhlBqqvhN9TSq+fma7Cf9hD2RdwKMsF82HCCjiPc3tqxQY+PcUYLqaSyQ9nDq4KzUhDtXzZdbCn8dSdmvSDNGSTnQaf9tOwQUf3BXjsEVVG727kzzngwoS11QbfTxI0ec8bBflL5wJ+YLJxW9yP0MrkoH7JMDAX6z6AW+eIZD4gZu3NzP2814cCtD0lVd9bnTAILJwtbbwV+8xvSDrIggkBEdAG53S5yYtVEWU0fCXTIfAK1rsNa3ExJulQQTD0NSYub7U2F5BlbsDgtJ0PMVWfCGGnYymbxC3fA2zss7HNpyncdlIphKNv8CEoE3daCJeifJ1/XqZ5EEvUrhlhnag4rVJBxkcJThZj3fpzqnQ2YGvXPWfwlS4LAF6BbZyrXqfz/GRaz//+mREgglZoU5vIKDz7Ug+1C1yEriJReHj6oMKvGuwF2Oo89jNBglw8q3+kcqJEarQ8iJkTFIfSzJh7oPHjP5268Ycr482IIYedKRZjGp6efPSIXqo589AVvr4+ShPByX1A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(18002099003)(56012099006)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: UrglKB5nzrPiZLPUBkJC34b/KC/eBBwvqLu5Wrmo5g9tOyoY/zMeUB82X53tOmXKc6icJdk4hEbFhe5J+JJviY9lOI36BQnNMj5VCF4rFGKLdOkznYozfmM/cthKK3brDUJ3MS9i5EITBOezi7PnJP1yTjOm5fwJd785rSCCCqr8xLLXPkVae9PK+OkvkX+ygvdOJ3TJdIS13L8jBQgkU7pkEKF4rkJsbQ0KjfSepqN6U/X97H7dCVfAsQpzphhQ+CtRqT86hZ8oR4FE9FMNaNA3NLjlKoMiyJCyneX+f63QGelr1VGm6ZG+czCrpzDoZUAJdVmFCiIYFm8Vz7IP6mu1FRynZ01tdRjMqv2OWDFRUsxhyrS74egjaSLwNGHveqYPEwADVBzV7ltDHeWu3OVpJil7QGYUGc4FsM1TQaEvEzWuuTBZ7vvpDKl0fr2d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 08:38:51.5516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f3a3b7-c6a6-4390-fc24-08dedd9580e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8342
X-Mailman-Approved-At: Thu, 09 Jul 2026 15:05:30 +0200
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

Starting the GENFIFO after each CMD and ADDR entry creates a gap
between the address phase (TX) and data phase (RX). For read commands
without dummy cycles, the controller is still driving DQ2/DQ3 HIGH
when the flash switches to output mode, causing a bus conflict.

Split the GENFIFO helper into a write-only variant and a
start-and-wait variant. Queue CMD, ADDR and dummy entries without
starting the GENFIFO. The data phase appends its entry and starts
the queued sequence, keeping the address-to-data transition
continuous.

Since genfifo_cmd() no longer triggers after each entry, operations
without a data phase have no trigger path. Call start_gen_fifo()
from exec_op() before deasserting chip select to execute the queued
CMD and ADDR entries.

Fixes: 22cca1730ec4 ("spi: zynqmp_gqspi: Add support for ZynqMP qspi driver")
Signed-off-by: Suraj Kakade <suraj.hanumantkakade@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 43 +++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index 2a095d0c58e..f572f2b3f15 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -283,16 +283,21 @@ static u32 zynqmp_qspi_genfifo_mode(u8 buswidth)
 	}
 }
 
-static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
-				      u32 gqspi_fifo_reg)
+static void zynqmp_qspi_write_gen_fifo(struct zynqmp_qspi_priv *priv,
+				       u32 gqspi_fifo_reg)
 {
 	struct zynqmp_qspi_regs *regs = priv->regs;
-	u32 config_reg, ier;
-	int ret = 0;
 
 	log_content("%s, GFIFO_CMD: 0x%X\n", __func__, gqspi_fifo_reg);
 
 	writel(gqspi_fifo_reg, &regs->genfifo);
+}
+
+static int zynqmp_qspi_start_gen_fifo(struct zynqmp_qspi_priv *priv)
+{
+	struct zynqmp_qspi_regs *regs = priv->regs;
+	u32 config_reg, ier;
+	int ret = 0;
 
 	config_reg = readl(&regs->confr);
 	/* Manual start if needed */
@@ -310,6 +315,15 @@ static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
 	if (ret)
 		log_warning("%s, Timeout\n", __func__);
 
+	return ret;
+}
+
+static int zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
+				     u32 gqspi_fifo_reg)
+{
+	zynqmp_qspi_write_gen_fifo(priv, gqspi_fifo_reg);
+
+	return zynqmp_qspi_start_gen_fifo(priv);
 }
 
 static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
@@ -573,7 +587,7 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(op->cmd.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_TX;
 	gen_fifo_cmd |= op->cmd.opcode;
-	zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+	zynqmp_qspi_write_gen_fifo(priv, gen_fifo_cmd);
 
 	/* Send address */
 	for (i = 0; i < op->addr.nbytes; i++) {
@@ -584,7 +598,7 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
 		gen_fifo_cmd |= GQSPI_GFIFO_TX;
 		gen_fifo_cmd |= addr;
 
-		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+		zynqmp_qspi_write_gen_fifo(priv, gen_fifo_cmd);
 	}
 
 	/* Send dummy */
@@ -596,7 +610,7 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
 		gen_fifo_cmd &= ~(GQSPI_GFIFO_TX | GQSPI_GFIFO_RX);
 		gen_fifo_cmd |= GQSPI_GFIFO_DATA_XFR_MASK;
 		gen_fifo_cmd |= dummy_cycles;
-		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+		zynqmp_qspi_write_gen_fifo(priv, gen_fifo_cmd);
 	}
 }
 
@@ -644,7 +658,9 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 
 	while (priv->len) {
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
-		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+		ret = zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+		if (ret)
+			return ret;
 
 		if (gen_fifo_cmd & GQSPI_GFIFO_EXP_MASK)
 			ret = zynqmp_qspi_fill_tx_fifo(priv, 1 << len);
@@ -666,6 +682,7 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
 	struct zynqmp_qspi_regs *regs = priv->regs;
 	u32 last_bits;
 	u32 *traverse = buf;
+	int ret;
 
 	while (priv->len) {
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
@@ -674,7 +691,9 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
 			priv->bytes_to_receive = (1 << len);
 		else
 			priv->bytes_to_receive = len;
-		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+		ret = zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+		if (ret)
+			return ret;
 
 		/* Manual start */
 		config_reg = readl(&regs->confr);
@@ -741,7 +760,9 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 
 		while (priv->len) {
 			zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
-			zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+			ret = zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
+			if (ret)
+				return ret;
 		}
 
 		ret = wait_for_bit_le32(&dma_regs->dmaisr,
@@ -886,6 +907,8 @@ static int zynqmp_qspi_exec_op(struct spi_slave *slave,
 		ret = zynqmp_qspi_genfifo_fill_rx(priv);
 	else if (op->data.dir == SPI_MEM_DATA_OUT)
 		ret = zynqmp_qspi_genfifo_fill_tx(priv);
+	else
+		ret = zynqmp_qspi_start_gen_fifo(priv);
 
 	zynqmp_qspi_chipselect(priv, 0);
 
-- 
2.34.1

