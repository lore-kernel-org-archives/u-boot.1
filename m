Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C33D4CDB47E
	for <u-boot@archiver.kernel.org>; Fri, 13 Oct 2023 16:57:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E2BF86E2F;
	Fri, 13 Oct 2023 18:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BdEztB5l";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0F4F086E81; Fri, 13 Oct 2023 14:38:01 +0200 (CEST)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2C1F986D62
 for <u-boot@lists.denx.de>; Fri, 13 Oct 2023 14:37:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ibai.erkiaga-elorza@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oVLttQGlKXETZIWvCBrRqfl9tsfc2IQrVgehJqdMjEOjFH0UL5j2JlWh6jkIkExkhVutZP+2BML/M8yforNX1Io0jnS03w+8cma9w/OjIz656izsAUv3RZ1e0abd3Tn1lEyh7cQGxx591YEj44Gu1jhrj+5Lb5au6HvVzMnBa9sVI43qc3zzZZIH4JrWUoy0n5jqAWCftBmUWZCcXhz5EOwc1MrQ9GokTA6uBCQlobiQq0EOMnZYxmpRBpTLR2uoVA+AqUyb1bPjPr3sfsXWsyM/8V1JsNHTFaNRvBNzyG0EIiIpCqWZbdrgiba5ZB0XAObZnjKQ/4Y5rdmebSTQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uBxzaxp2dWLGF4bJ1+FL023LKifWLm35OqVAFJ9EPJg=;
 b=YbmZHIv+udUS1w+r7YQU9FMrze1JK54U5qJShUg8Vyk+fbL+UIp6SrQx+2HPcB8Mx/fbSpAJDJV0a9lw2AsV6/UnaZkDSJbIllg/okjZ/ZofKz8sayx8g07USjpPpNHRztysQfgzDfGYZBNxKWzmvlXGNlZpihcs16TunrnfYtPPg8VBpIpBIRaGKIGbYrp0WQW8z/Ypkbb6o5FGz0fUgXrQAJZYIUrAapVK0Pz/ucRTDVhw86gyWQ8GGqd99S/lpy6R2nNRBGbitrUjuFakDaQqW64Wnd1/8OdqpK8KPROqCcuIQujae6S/S8844Nht2WZxq8pmyUP1c+tMhYDPlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uBxzaxp2dWLGF4bJ1+FL023LKifWLm35OqVAFJ9EPJg=;
 b=BdEztB5lnXRNicf+Rpob6pzDYMvBWGPT+J4NFL4G+2qXGyNwAE2C5LI3OSEpQ0iM15oIG8LKcP4i47PGpy5hYk4TeJCLEBinjRpkHH2V2kRiXPIj4VwtnXlctFyJ+NjTGXScnKpPXl4odfbt6Ef26miIszSILU1N/K9TtYxO4jk=
Received: from MN2PR19CA0033.namprd19.prod.outlook.com (2603:10b6:208:178::46)
 by CH0PR12MB5330.namprd12.prod.outlook.com (2603:10b6:610:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 12:37:53 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:178:cafe::48) by MN2PR19CA0033.outlook.office365.com
 (2603:10b6:208:178::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 12:37:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 12:37:52 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 07:37:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 07:37:51 -0500
Received: from xirengwts04.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 13 Oct 2023 07:37:51 -0500
From: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: <michal.simek@amd.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
Subject: [PATCH v1] zynqmp: migrate gqspi debug to logging
Date: Fri, 13 Oct 2023 13:37:27 +0100
Message-ID: <20231013123739.2757979-1-ibai.erkiaga-elorza@amd.com>
X-Mailer: git-send-email 2.42.0.325.g3a06386e31
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|CH0PR12MB5330:EE_
X-MS-Office365-Filtering-Correlation-Id: a8e0d48c-47e3-4b25-0a18-08dbcbe937ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ir7X2XiqHW3S6LSFNe/UM5klg5UqNjc4dBftj0ipq01jvvouL2IMhpcKIbhRjAcMBygJrTGQqYdTaC9DfgTD4vGhIiCKrCbERKlfbOoIpamsNBeezBrqNSDvQ6i7RY+AEw3tIV5KQPUFCPhQ1jSpWf1X6Xk4PCMzY6fblU3oe6OsfbcetlnUSCY3ckX8Dt1ZbgCZBCDvsIIJUPlu9rGh7cxvPFvospr6E2PR9XiIxrlkJFd1cpFKx/yXGHyge9o3mScdbJyh5oCQdHngQbzyUrtz8nZHQuYgat9KW+IBjZq45PzEDAirGPls1b5WUG1kD1cl9VN93NygV/8JjPR92aVkGpIr3WMZ4MQOlXfgca3rWEeAiI7OOI7J2XGI+aG8IkLmhVkxL2ApnoXg95bVPDLZhP4lGsgN/rIsZjBpUYlubGxiA3CB/ofHPiVTYdVzeT8mdpmJhiSmntjz1INHOC8LrxiXx5iZx+Y7off5qXLW7O77BkC4Anke9PXU7uO1rEbt5TPSv0jJQjkD0dl+OOIUNZZWATgRgoWFNxuzMGZ0+MuofWScn8KtTFB3+nNbFQ6o8GboOJtKsqIkdBif1Eem0tiJb/z7VYfDPJGq81CMuuCJCWEfjeofk/oags4D6vKIb4/yp+ZrN8mqa+6YVP9TALPU6eB2r2Ic2RMnslACJJVvsuN/rLc+oTCOXk2Iv0Bf7HSk1Um56nZ6w1u66cwntS+o6HCv1EiyblKlqGZILuSlDUSwBNDeF5gq5gz/8q7GGoNYGNaoKmZpqk2W2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(39860400002)(346002)(376002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(47076005)(2906002)(40460700003)(40480700001)(5660300002)(4326008)(41300700001)(8676002)(8936002)(36756003)(70586007)(2616005)(86362001)(478600001)(54906003)(110136005)(6666004)(1076003)(82740400003)(336012)(81166007)(356005)(36860700001)(70206006)(426003)(26005)(316002)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 12:37:52.4715 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8e0d48c-47e3-4b25-0a18-08dbcbe937ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5330
X-Mailman-Approved-At: Fri, 13 Oct 2023 18:57:17 +0200
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

The following patch migrates the usage of debug and printf functions
to the relevant logging function as per U-Boot DM guidelines.

Additionally some of the debugging statements have been rearanged for
a more meaningfull debug experience.

aarch64-linux-gnu-size reports 229 bytes less when debug is enabled at
file level, while is just 5bytes more when disabled.

Signed-off-by: Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>
---
 drivers/spi/zynqmp_gqspi.c | 82 +++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 49 deletions(-)

diff --git a/drivers/spi/zynqmp_gqspi.c b/drivers/spi/zynqmp_gqspi.c
index ec59ef5804..a323994fb2 100644
--- a/drivers/spi/zynqmp_gqspi.c
+++ b/drivers/spi/zynqmp_gqspi.c
@@ -5,6 +5,8 @@
  * Xilinx ZynqMP Generic Quad-SPI(QSPI) controller driver(master mode only)
  */
 
+#define LOG_CATEGORY UCLASS_SPI
+
 #include <common.h>
 #include <cpu_func.h>
 #include <log.h>
@@ -192,8 +194,6 @@ static int zynqmp_qspi_of_to_plat(struct udevice *bus)
 {
 	struct zynqmp_qspi_plat *plat = dev_get_plat(bus);
 
-	debug("%s\n", __func__);
-
 	plat->regs = (struct zynqmp_qspi_regs *)(dev_read_addr(bus) +
 						 GQSPI_REG_OFFSET);
 	plat->dma_regs = (struct zynqmp_qspi_dma_regs *)
@@ -250,7 +250,7 @@ static u32 zynqmp_qspi_genfifo_mode(u8 buswidth)
 	case 4:
 		return GQSPI_SPI_MODE_QSPI;
 	default:
-		debug("Unsupported bus width %u\n", buswidth);
+		log_warning("Unsupported bus width %u\n", buswidth);
 		return GQSPI_SPI_MODE_SPI;
 	}
 }
@@ -262,6 +262,8 @@ static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
 	u32 config_reg, ier;
 	int ret = 0;
 
+	log_content("%s, GFIFO_CMD: 0x%X\n", __func__, gqspi_fifo_reg);
+
 	writel(gqspi_fifo_reg, &regs->genfifo);
 
 	config_reg = readl(&regs->confr);
@@ -278,7 +280,7 @@ static void zynqmp_qspi_fill_gen_fifo(struct zynqmp_qspi_priv *priv,
 	ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_GFEMTY_MASK, 1,
 				GQSPI_TIMEOUT, 1);
 	if (ret)
-		printf("%s Timeout\n", __func__);
+		log_warning("%s, Timeout\n", __func__);
 
 }
 
@@ -286,6 +288,8 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
 {
 	u32 gqspi_fifo_reg = 0;
 
+	log_debug("%s, assert: %d\r\n", __func__, is_on);
+
 	if (is_on) {
 		gqspi_fifo_reg = zynqmp_qspi_bus_select(priv);
 		gqspi_fifo_reg |= GQSPI_SPI_MODE_SPI |
@@ -295,8 +299,6 @@ static void zynqmp_qspi_chipselect(struct zynqmp_qspi_priv *priv, int is_on)
 		gqspi_fifo_reg |= GQSPI_IMD_DATA_CS_DEASSERT;
 	}
 
-	debug("GFIFO_CMD_CS: 0x%x\n", gqspi_fifo_reg);
-
 	zynqmp_qspi_fill_gen_fifo(priv, gqspi_fifo_reg);
 }
 
@@ -311,8 +313,8 @@ static void zynqmp_qspi_set_tapdelay(struct udevice *bus, u32 baudrateval)
 	clk_rate = plat->frequency;
 	reqhz = (clk_rate / (GQSPI_BAUD_DIV_SHIFT << baudrateval));
 
-	debug("%s, req_hz:%d, clk_rate:%d, baudrateval:%d\n",
-	      __func__, reqhz, clk_rate, baudrateval);
+	log_debug("%s, clk_rate:%d, baudrateval:%d, bus_clk: %d\n",
+		  __func__, clk_rate, baudrateval, reqhz);
 
 	if (!(IS_ENABLED(CONFIG_ARCH_VERSAL) ||
 	      IS_ENABLED(CONFIG_ARCH_VERSAL_NET))) {
@@ -362,7 +364,8 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
 	u32 confr;
 	u8 baud_rate_val = 0;
 
-	debug("%s\n", __func__);
+	log_debug("%s, Speed: %d, Max: %d\n", __func__, speed, plat->frequency);
+
 	if (speed > plat->frequency)
 		speed = plat->frequency;
 
@@ -383,9 +386,8 @@ static int zynqmp_qspi_set_speed(struct udevice *bus, uint speed)
 		confr &= ~GQSPI_BAUD_DIV_MASK;
 		confr |= (baud_rate_val << 3);
 		writel(confr, &regs->confr);
-		zynqmp_qspi_set_tapdelay(bus, baud_rate_val);
 
-		debug("regs=%p, speed=%d\n", priv->regs, plat->speed_hz);
+		zynqmp_qspi_set_tapdelay(bus, baud_rate_val);
 	}
 
 	return 0;
@@ -399,8 +401,6 @@ static int zynqmp_qspi_probe(struct udevice *bus)
 	unsigned long clock;
 	int ret;
 
-	debug("%s: bus:%p, priv:%p\n", __func__, bus, priv);
-
 	priv->regs = plat->regs;
 	priv->dma_regs = plat->dma_regs;
 	priv->io_mode = plat->io_mode;
@@ -416,7 +416,6 @@ static int zynqmp_qspi_probe(struct udevice *bus)
 		dev_err(bus, "failed to get rate\n");
 		return clock;
 	}
-	debug("%s: CLK %ld\n", __func__, clock);
 
 	ret = clk_enable(&clk);
 	if (ret) {
@@ -429,6 +428,8 @@ static int zynqmp_qspi_probe(struct udevice *bus)
 	/* init the zynq spi hw */
 	zynqmp_qspi_init_hw(priv);
 
+	log_debug("%s, Rerence clock frequency: %ld\n", __func__, clock);
+
 	return 0;
 }
 
@@ -438,7 +439,8 @@ static int zynqmp_qspi_set_mode(struct udevice *bus, uint mode)
 	struct zynqmp_qspi_regs *regs = priv->regs;
 	u32 confr;
 
-	debug("%s\n", __func__);
+	log_debug("%s, 0x%X\n", __func__, mode);
+
 	/* Set the SPI Clock phase and polarities */
 	confr = readl(&regs->confr);
 	confr &= ~(GQSPI_CONFIG_CPHA_MASK | GQSPI_CONFIG_CPOL_MASK);
@@ -461,16 +463,11 @@ static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
 	u32 *buf = (u32 *)priv->tx_buf;
 	u32 len = size;
 
-	debug("TxFIFO: 0x%x, size: 0x%x\n", readl(&regs->isr),
-	      size);
-
 	while (size) {
 		ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_TXNFULL_MASK, 1,
 					GQSPI_TIMEOUT, 1);
-		if (ret) {
-			printf("%s: Timeout\n", __func__);
-			return ret;
-		}
+		if (ret)
+			return log_msg_ret("Timeout\n", ret);
 
 		if (size >= 4) {
 			writel(*buf, &regs->txd0r);
@@ -501,10 +498,8 @@ static int zynqmp_qspi_fill_tx_fifo(struct zynqmp_qspi_priv *priv, u32 size)
 
 	ret = wait_for_bit_le32(&regs->isr, GQSPI_IXR_TXFIFOEMPTY_MASK, 1,
 				GQSPI_TIMEOUT, 1);
-	if (ret) {
-		printf("%s: Timeout\n", __func__);
-		return ret;
-	}
+	if (ret)
+		return log_msg_ret("Timeout\n", ret);
 
 	priv->tx_buf += len;
 	return 0;
@@ -516,6 +511,9 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
 	u32 gen_fifo_cmd;
 	u8 i, dummy_cycles, addr;
 
+	log_debug("%s, opcode: 0x%0X, addr.nbytes: %d, dummy.mbytes: %d\r\n",
+		  __func__, op->cmd.opcode, op->addr.nbytes, op->dummy.nbytes);
+
 	/* Send opcode */
 	gen_fifo_cmd = zynqmp_qspi_bus_select(priv);
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(op->cmd.buswidth);
@@ -532,8 +530,6 @@ static void zynqmp_qspi_genfifo_cmd(struct zynqmp_qspi_priv *priv)
 		gen_fifo_cmd |= GQSPI_GFIFO_TX;
 		gen_fifo_cmd |= addr;
 
-		debug("GFIFO_CMD_Cmd = 0x%x\n", gen_fifo_cmd);
-
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
 	}
 
@@ -583,6 +579,8 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 	u32 len;
 	int ret = 0;
 
+	log_debug("%s, length: %d\r\n", __func__, priv->len);
+
 	gen_fifo_cmd = zynqmp_qspi_bus_select(priv);
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_TX | GQSPI_GFIFO_DATA_XFR_MASK;
@@ -591,8 +589,6 @@ static int zynqmp_qspi_genfifo_fill_tx(struct zynqmp_qspi_priv *priv)
 		len = zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
 
-		debug("GFIFO_CMD_TX:0x%x\n", gen_fifo_cmd);
-
 		if (gen_fifo_cmd & GQSPI_GFIFO_EXP_MASK)
 			ret = zynqmp_qspi_fill_tx_fifo(priv, 1 << len);
 		else
@@ -608,7 +604,6 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
 				u32 gen_fifo_cmd, u32 *buf)
 {
 	u32 len;
-	u32 actuallen = priv->len;
 	u32 config_reg, ier, isr;
 	u32 timeout = GQSPI_TIMEOUT;
 	struct zynqmp_qspi_regs *regs = priv->regs;
@@ -623,7 +618,7 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
 		else
 			priv->bytes_to_receive = len;
 		zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
-		debug("GFIFO_CMD_RX:0x%x\n", gen_fifo_cmd);
+
 		/* Manual start */
 		config_reg = readl(&regs->confr);
 		config_reg |= GQSPI_STRT_GEN_FIFO;
@@ -652,13 +647,8 @@ static int zynqmp_qspi_start_io(struct zynqmp_qspi_priv *priv,
 			}
 		}
 
-		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",
-		      (unsigned long)buf, (unsigned long)priv->rx_buf,
-		      *buf, actuallen);
-		if (!timeout) {
-			printf("IO timeout: %d\n", readl(&regs->isr));
-			return -1;
-		}
+		if (!timeout)
+			return log_msg_retz("Timeout\n", timeout);
 	}
 
 	return 0;
@@ -695,26 +685,18 @@ static int zynqmp_qspi_start_dma(struct zynqmp_qspi_priv *priv,
 		while (priv->len) {
 			zynqmp_qspi_calc_exp(priv, &gen_fifo_cmd);
 			zynqmp_qspi_fill_gen_fifo(priv, gen_fifo_cmd);
-
-			debug("GFIFO_CMD_RX:0x%x\n", gen_fifo_cmd);
 		}
 
 		ret = wait_for_bit_le32(&dma_regs->dmaisr,
 					GQSPI_DMA_DST_I_STS_DONE, 1,
 					GQSPI_TIMEOUT, 1);
-		if (ret) {
-			printf("DMA Timeout:0x%x\n", readl(&dma_regs->dmaisr));
-			return -ETIMEDOUT;
-		}
+		if (ret)
+			return log_msg_ret("Timeout:\n", ret);
 
 		invalidate_dcache_range(addr, addr + size);
 
 		writel(GQSPI_DMA_DST_I_STS_DONE, &dma_regs->dmaisr);
 
-		debug("buf:0x%lx, rxbuf:0x%lx, *buf:0x%x len: 0x%x\n",
-		      (unsigned long)buf, (unsigned long)priv->rx_buf, *buf,
-		      actuallen);
-
 		if (buf != priv->rx_buf)
 			memcpy(priv->rx_buf, buf, actuallen);
 
@@ -731,6 +713,8 @@ static int zynqmp_qspi_genfifo_fill_rx(struct zynqmp_qspi_priv *priv)
 	u32 *buf;
 	u32 actuallen = priv->len;
 
+	log_debug("%s, length: %d\r\n", __func__, priv->len);
+
 	gen_fifo_cmd = zynqmp_qspi_bus_select(priv);
 	gen_fifo_cmd |= zynqmp_qspi_genfifo_mode(priv->op->data.buswidth);
 	gen_fifo_cmd |= GQSPI_GFIFO_RX | GQSPI_GFIFO_DATA_XFR_MASK;
-- 
2.42.0.325.g3a06386e31

