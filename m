Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2489C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B0F2876EF;
	Wed,  6 Dec 2023 06:34:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WCM284FE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6D926876F4; Wed,  6 Dec 2023 06:34:27 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20603.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::603])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 742CE87683
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:22 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwUV9PG+/7jMIv/MI3f4/0TpaQStkMmRm3i1YMTEC9b/k7R3BUvHg3nCcTEoqtc0a1Q8JZLlL4haUzD5hhco+Sk51mwsHSsZExgsNW+FM5Xf3mPUP/ZTsFJWBrsuItpcOOAIiPRJKV6T88ReuW3dCyGyskFlXDXN2eyqmmcN+jL7oKw863AIvvX96bY0SGY4m7xgX+ax4n2dWKcY9IwHYWlwCyVH/Aj6AqDV42pMfOlCUDhl02+DRHVavQb1rq2VM2VFG8XzqpH4QWHg0H5ScObhfUxjWh72j0yW0RWttToDecNs4msZgTvgQATr6fyB8Kkwg0WeS53Nfqt963Yvtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QPekjedamzi/kBt0qC3u3Teka5WYvjawg6gHGuSIdfM=;
 b=S0DVdMAaf8BpVpIzO132+ZgJwv04SH3PejOPRDfUpNa7e1XNv86BZwmKz0aZckHXDVk3FKloXFU5VJFrnLc6YsQsWN6SagOhzom/WPWxT+ItvQ62o29KJytxJXYvaqol+8SqJnT2u47DiasYb3UTdL776djRBz9OmjjJP3mmyZBhdu8tal7yiiqsjH0JGbqIK5bDtLpuPVS7vZ2eNU8MpF/FMefufLLvB/Od+2nKmVfFy8NFkp4j8EK1MbABsylblx22L7psaGEVc+LVmy2XJJMy7Lv5aOZ5HtJvFqeF2B7rVTvFyGGMXBQTf3Us9YfnJvBkra6cu+nE7ug5MalbyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QPekjedamzi/kBt0qC3u3Teka5WYvjawg6gHGuSIdfM=;
 b=WCM284FErdARPgWzAdZu+GWT5vYl+ZsdTA07lpMNabWkgnJ5yNfFGYVUsRR0pd5xMqXR9zZxKDnbtT52Da0tO1AYvtqYkblJ2tsV6G/8uTU5dt9YwexWH300B7MxnMgliGgWbGjVg2VStZPLaeRntCPR5gMYe95TvpDX0HIXFbc=
Received: from BL1PR13CA0194.namprd13.prod.outlook.com (2603:10b6:208:2be::19)
 by BN9PR12MB5340.namprd12.prod.outlook.com (2603:10b6:408:105::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 05:34:18 +0000
Received: from MN1PEPF0000ECD6.namprd02.prod.outlook.com
 (2603:10b6:208:2be:cafe::a) by BL1PR13CA0194.outlook.office365.com
 (2603:10b6:208:2be::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 MN1PEPF0000ECD6.mail.protection.outlook.com (10.167.242.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:18 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:16 -0600
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:13 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@xilinx.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH 14/30] spi: cadence_qspi: Setup ddr mode in cadence qspi driver
Date: Wed, 6 Dec 2023 11:03:48 +0530
Message-ID: <20231206053353.3745918-5-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD6:EE_|BN9PR12MB5340:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be69700-7e97-450d-d484-08dbf61cfe10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q1HOg71NZmzTiUK/mltqrcyiYz/H1Fi2Gndhrv888CZOP2hgHuM3+s0itLi8OBUtTdxXRRvENMt1dg8UaO8PcDwvUo/qg469HRXcVGg6xiqAFpstBMOqs/ztSRizK/Bfop11ZEUXvKXLE1S5iVMCUQ8ClgHvYTPX1iSwUWM4CFwqaNwOr5gCWqMUrzNbyqRr54oz4r81wyQfin3l00t0/AXz4ZyLHd4UGDiuxjoP5K3V62uCleBH2VL3f2KC4xVLESN/ITCUtHKhUSNMOPMuOCV2OIRz2PWpDR1knkPgQtXIH7u2vuLBx/THdvA1VhZtc8xc6K5VZW6vI0OtyJNan+AmiWR6/xw/MKOC5e9tfLt99G/f/7Xw3NMhyJ3097EzbMLUJVS4i/B33UfAUeliYlHYG3a7hoWZN2EmWJPrOvwFBTd7+pNZ3PHehTe9U4PGirwgV8f4/pauZVeOWredeNyaX8MDP+llpdwNSQ3jbKPtgnFFcAbpcjtw/xkfWylbi8DUleZQ754Op+CtyYaNzJo9/7ryeyiF/o5ok/KvItIfiBpJnYM+wikgBk026Ajf2olyGMO+UCAjWiBVHU/PluQwdgrUx5IneZkCZ996KUnqjXqVjEUGzQMZRjqrI1irStIqxTnfpJnaTWFmUwIf/pASRJqrdsbjS3pUeRusHa+zmHK9ZmlpC2oYPVgzTH+moD0C9eG4Hfr2bN5xQ7Vbu4PwW7Wtj47V+d2jLrolB3oZztC0cNvyJeeVK8SNykgx/RB350PvcUvBoNaX+9YBPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(186009)(64100799003)(82310400011)(1800799012)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(30864003)(2906002)(5660300002)(36860700001)(41300700001)(86362001)(103116003)(36756003)(356005)(82740400003)(1076003)(2616005)(26005)(6666004)(4326008)(336012)(478600001)(8676002)(8936002)(47076005)(70586007)(70206006)(426003)(54906003)(316002)(6916009)(83380400001)(81166007)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:18.4621 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be69700-7e97-450d-d484-08dbf61cfe10
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5340
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

From: T Karthik Reddy <t.karthik.reddy@xilinx.com>

To switch the OSPI controller from SDR to DDR mode, the
RX delay should be configured through flash tuning. Begin
by establishing a constant value for the TX delay and then
increase the RX delay by inspecting the flash IDs. To fine-tune
the RX delay, compare the flash IDs with a set of predetermined
"golden" flash IDs. This tuning process is borrowed from the
Linux Cadence driver. Moreover, make the necessary adjustments
in the DDR PHY setup to facilitate the transition from SDR
to DDR mode within the OSPI controller.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_ospi_versal.c |  25 +++
 drivers/spi/cadence_qspi.c        | 321 +++++++++++++++++++++++++++++-
 drivers/spi/cadence_qspi.h        |  52 +++++
 drivers/spi/cadence_qspi_apb.c    |  33 ++-
 4 files changed, 416 insertions(+), 15 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index e02a3b3de3..74994a690d 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -15,6 +15,7 @@
 #include <cpu_func.h>
 #include <zynqmp_firmware.h>
 #include <asm/arch/hardware.h>
+#include <soc.h>
 #include "cadence_qspi.h"
 #include <dt-bindings/power/xlnx-versal-power.h>
 
@@ -129,6 +130,30 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
 	return 0;
 }
 
+static const struct soc_attr matches[] = {
+	{ .family = "Versal", .revision = "v2" },
+	{ }
+};
+
+/*
+ * cadence_qspi_versal_set_dll_mode checks for silicon version
+ * and set the DLL mode.
+ * Returns 0 in case of success, -ENOTSUPP in case of failure.
+ */
+int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(dev);
+	const struct soc_attr *attr;
+
+	attr = soc_device_match(matches);
+	if (attr) {
+		priv->dll_mode = CQSPI_DLL_MODE_MASTER;
+		return 0;
+	}
+
+	return -ENOTSUPP;
+}
+
 #if defined(CONFIG_DM_GPIO)
 int cadence_qspi_versal_flash_reset(struct udevice *dev)
 {
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index cc3a54f295..32f91825fd 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -89,11 +89,21 @@ static int spi_calibration(struct udevice *bus, uint hz)
 	/* Enable QSPI */
 	cadence_qspi_apb_controller_enable(base);
 
-	/* read the ID which will be our golden value */
-	err = cadence_spi_read_id(priv, 3, (u8 *)&idcode);
-	if (err) {
-		puts("SF: Calibration failed (read)\n");
-		return err;
+	if (!priv->ddr_init) {
+		/* read the ID which will be our golden value */
+		err = cadence_spi_read_id(priv, CQSPI_READ_ID_LEN, (u8 *)&idcode);
+		if (err) {
+			puts("SF: Calibration failed (read)\n");
+			return err;
+		}
+
+		/* Save flash id's for further use */
+		priv->device_id[0] = (u8)idcode;
+		priv->device_id[1] = (u8)(idcode >> 8);
+		priv->device_id[2] = (u8)(idcode >> 16);
+	} else {
+		idcode = priv->device_id[0] | priv->device_id[1] << 8 |
+			 priv->device_id[2] << 16;
 	}
 
 	/* use back the intended clock and find low range */
@@ -109,7 +119,7 @@ static int spi_calibration(struct udevice *bus, uint hz)
 		cadence_qspi_apb_controller_enable(base);
 
 		/* issue a RDID to get the ID value */
-		err = cadence_spi_read_id(priv, 3, (u8 *)&temp);
+		err = cadence_spi_read_id(priv, CQSPI_READ_ID_LEN, (u8 *)&temp);
 		if (err) {
 			puts("SF: Calibration failed (read)\n");
 			return err;
@@ -190,6 +200,20 @@ static int cadence_spi_set_speed(struct udevice *bus, uint hz)
 	return 0;
 }
 
+static int cadence_spi_child_pre_probe(struct udevice *bus)
+{
+	struct spi_slave *slave = dev_get_parent_priv(bus);
+
+	slave->bytemode = SPI_4BYTE_MODE;
+
+	return 0;
+}
+
+__weak int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
+{
+	return -ENOTSUPP;
+}
+
 static int cadence_spi_probe(struct udevice *bus)
 {
 	struct cadence_spi_plat *plat = dev_get_plat(bus);
@@ -247,6 +271,14 @@ static int cadence_spi_probe(struct udevice *bus)
 		priv->qspi_is_init = 1;
 	}
 
+	priv->edge_mode = CQSPI_EDGE_MODE_SDR;
+	priv->dll_mode = CQSPI_DLL_MODE_BYPASS;
+
+	/* Select dll mode */
+	ret = cadence_qspi_versal_set_dll_mode(bus);
+	if (ret == -ENOTSUPP)
+		debug("DLL mode set to bypass mode : %x\n", ret);
+
 	priv->wr_delay = 50 * DIV_ROUND_UP(NSEC_PER_SEC, priv->ref_clk_hz);
 
 	/* Versal and Versal-NET use spi calibration to set read delay */
@@ -290,6 +322,279 @@ static int cadence_spi_set_mode(struct udevice *bus, uint mode)
 	return 0;
 }
 
+static int cadence_qspi_rx_dll_tuning(struct cadence_spi_priv *priv,
+				      u32 txtap, u8 extra_dummy)
+{
+	void *regbase = priv->regbase;
+	int ret, i, j;
+	u8 id[CQSPI_READ_ID_LEN + 1], min_rxtap = 0, max_rxtap = 0, avg_rxtap,
+	max_tap, windowsize, dummy_flag = 0, max_index = 0, min_index = 0;
+	s8 max_windowsize = -1;
+	bool id_matched, rxtapfound = false;
+	struct spi_mem_op op =
+		SPI_MEM_OP(SPI_MEM_OP_CMD(CQSPI_READ_ID | (CQSPI_READ_ID << 8), 8),
+			   SPI_MEM_OP_NO_ADDR,
+			   SPI_MEM_OP_DUMMY(8, 8),
+			   SPI_MEM_OP_DATA_IN(CQSPI_READ_ID_LEN, id, 8));
+
+	op.cmd.nbytes = 2;
+	op.dummy.nbytes *= 2;
+	op.cmd.dtr = true;
+	op.addr.dtr = true;
+	op.data.dtr = true;
+
+	max_tap = CQSPI_MAX_DLL_TAPS;
+	/*
+	 * Rx dll tuning is done by setting tx delay and increment rx
+	 * delay and check for correct flash id's by reading from flash.
+	 */
+	for (i = 0; i <= max_tap; i++) {
+		/* Set DLL reset bit */
+		writel((txtap | i | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+		       regbase + CQSPI_REG_PHY_CONFIG);
+		/*
+		 * Re-synchronisation delay lines to update them
+		 * with values from TX DLL Delay and RX DLL Delay fields
+		 */
+		writel((CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK | txtap | i |
+		       CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+		       regbase + CQSPI_REG_PHY_CONFIG);
+		/* Check lock of loopback */
+		if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+			ret = wait_for_bit_le32
+				(regbase + CQSPI_REG_DLL_LOWER,
+				 CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK, 1,
+				 CQSPI_TIMEOUT_MS, 0);
+			if (ret) {
+				printf("LOWER_DLL_LOCK bit err: %i\n", ret);
+				return ret;
+			}
+		}
+
+		ret = cadence_qspi_apb_command_read_setup(priv, &op);
+		if (!ret) {
+			ret = cadence_qspi_apb_command_read(priv, &op);
+			if (ret < 0) {
+				printf("error %d reading JEDEC ID\n", ret);
+				return ret;
+			}
+		}
+
+		id_matched = true;
+		for (j = 0; j < CQSPI_READ_ID_LEN; j++) {
+			if (priv->device_id[j] != id[j]) {
+				id_matched = false;
+				break;
+			}
+		}
+
+		if (id_matched && !rxtapfound) {
+			if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+				min_rxtap =
+				readl(regbase + CQSPI_REG_DLL_OBSVBLE_UPPER) &
+				      CQSPI_REG_DLL_UPPER_RX_FLD_MASK;
+				max_rxtap = min_rxtap;
+				max_index = i;
+				min_index = i;
+			} else {
+				min_rxtap = i;
+				max_rxtap = i;
+			}
+			rxtapfound = true;
+		}
+
+		if (id_matched && rxtapfound) {
+			if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+				max_rxtap =
+					readl(regbase +
+					      CQSPI_REG_DLL_OBSVBLE_UPPER) &
+					      CQSPI_REG_DLL_UPPER_RX_FLD_MASK;
+				max_index = i;
+			} else {
+				max_rxtap = i;
+			}
+		}
+
+		if ((!id_matched || i == max_tap) && rxtapfound) {
+			windowsize = max_rxtap - min_rxtap + 1;
+			if (windowsize > max_windowsize) {
+				dummy_flag = extra_dummy;
+				max_windowsize = windowsize;
+				if (priv->dll_mode == CQSPI_DLL_MODE_MASTER)
+					avg_rxtap = (max_index + min_index);
+				else
+					avg_rxtap = (max_rxtap + min_rxtap);
+				avg_rxtap /= 2;
+			}
+
+			if (windowsize >= 3)
+				i = max_tap;
+
+			rxtapfound = false;
+		}
+	}
+
+	if (!extra_dummy) {
+		rxtapfound = false;
+		min_rxtap = 0;
+		max_rxtap = 0;
+	}
+
+	if (!dummy_flag)
+		priv->extra_dummy = false;
+
+	if (max_windowsize < 3)
+		return -EINVAL;
+
+	return avg_rxtap;
+}
+
+static int cadence_spi_setdlldelay(struct udevice *bus)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	void *regbase = priv->regbase;
+	u32 txtap;
+	int ret, rxtap;
+	u8 extra_dummy;
+
+	ret = wait_for_bit_le32(regbase + CQSPI_REG_CONFIG,
+				1 << CQSPI_REG_CONFIG_IDLE_LSB,
+				1, CQSPI_TIMEOUT_MS, 0);
+	if (ret) {
+		printf("spi_wait_idle error : 0x%x\n", ret);
+		return ret;
+	}
+
+	if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+		/* Drive DLL reset bit to low */
+		writel(0, regbase + CQSPI_REG_PHY_CONFIG);
+
+		/* Set initial delay value */
+		writel(CQSPI_REG_PHY_INITIAL_DLY,
+		       regbase + CQSPI_REG_PHY_MASTER_CTRL);
+		/* Set DLL reset bit */
+		writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
+		       regbase + CQSPI_REG_PHY_CONFIG);
+
+		/* Check for loopback lock */
+		ret = wait_for_bit_le32(regbase + CQSPI_REG_DLL_LOWER,
+					CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK,
+					1, CQSPI_TIMEOUT_MS, 0);
+		if (ret) {
+			printf("Loopback lock bit error (%i)\n", ret);
+			return ret;
+		}
+
+		/* Re-synchronize slave DLLs */
+		writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK,
+		       regbase + CQSPI_REG_PHY_CONFIG);
+		writel(CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK |
+		       CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK,
+		       regbase + CQSPI_REG_PHY_CONFIG);
+
+		txtap = CQSPI_TX_TAP_MASTER <<
+			CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB;
+	}
+
+	priv->extra_dummy = false;
+	for (extra_dummy = 0; extra_dummy <= 1; extra_dummy++) {
+		if (extra_dummy)
+			priv->extra_dummy = true;
+
+		rxtap = cadence_qspi_rx_dll_tuning(priv, txtap, extra_dummy);
+		if (extra_dummy && rxtap < 0) {
+			printf("Failed RX dll tuning\n");
+			return rxtap;
+		}
+	}
+	debug("RXTAP: %d\n", rxtap);
+
+	writel((txtap | rxtap | CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+	       regbase + CQSPI_REG_PHY_CONFIG);
+	writel((CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK | txtap | rxtap |
+	       CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK),
+	       regbase + CQSPI_REG_PHY_CONFIG);
+
+	if (priv->dll_mode == CQSPI_DLL_MODE_MASTER) {
+		ret = wait_for_bit_le32(regbase + CQSPI_REG_DLL_LOWER,
+					CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK,
+					1, CQSPI_TIMEOUT_MS, 0);
+		if (ret) {
+			printf("LOWER_DLL_LOCK bit err: %i\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int priv_setup_ddrmode(struct udevice *bus)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	void *regbase = priv->regbase;
+	int ret;
+
+	ret = wait_for_bit_le32(regbase + CQSPI_REG_CONFIG,
+				1 << CQSPI_REG_CONFIG_IDLE_LSB,
+				1, CQSPI_TIMEOUT_MS, 0);
+	if (ret) {
+		printf("spi_wait_idle error : 0x%x\n", ret);
+		return ret;
+	}
+
+	/* Disable QSPI */
+	cadence_qspi_apb_controller_disable(regbase);
+
+	/* Disable DAC mode */
+	if (priv->use_dac_mode) {
+		clrbits_le32(regbase + CQSPI_REG_CONFIG,
+			     CQSPI_REG_CONFIG_DIRECT);
+		priv->use_dac_mode = false;
+	}
+
+	setbits_le32(regbase + CQSPI_REG_CONFIG,
+		     CQSPI_REG_CONFIG_PHY_ENABLE_MASK);
+
+	/* Program POLL_CNT */
+	clrsetbits_le32(regbase + CQSPI_REG_WRCOMPLETION,
+			CQSPI_REG_WRCOMPLETION_POLLCNT_MASK,
+			CQSPI_REG_WRCOMPLETION_POLLCNT <<
+			CQSPI_REG_WRCOMPLETION_POLLCNY_LSB);
+
+	setbits_le32(regbase + CQSPI_REG_CONFIG,
+		     CQSPI_REG_CONFIG_DTR_PROT_EN_MASK);
+
+	clrsetbits_le32(regbase + CQSPI_REG_RD_DATA_CAPTURE,
+			(CQSPI_REG_RD_DATA_CAPTURE_DELAY_MASK <<
+			 CQSPI_REG_RD_DATA_CAPTURE_DELAY_LSB),
+			CQSPI_REG_READCAPTURE_DQS_ENABLE);
+
+	/* Enable QSPI */
+	cadence_qspi_apb_controller_enable(regbase);
+
+	return 0;
+}
+
+static int cadence_spi_setup_ddrmode(struct udevice *bus)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	int ret;
+
+	ret = priv_setup_ddrmode(bus);
+	if (ret)
+		return ret;
+
+	priv->edge_mode = CQSPI_EDGE_MODE_DDR;
+	ret = cadence_spi_setdlldelay(bus);
+	if (ret) {
+		printf("DDR tuning failed with error %d\n", ret);
+		return ret;
+	}
+	priv->ddr_init = 1;
+
+	return 0;
+}
+
 static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 				   const struct spi_mem_op *op)
 {
@@ -350,6 +655,9 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 		break;
 	}
 
+	if (!priv->ddr_init && (spi->flags & SPI_XFER_SET_DDR))
+		err = cadence_spi_setup_ddrmode(bus);
+
 	return err;
 }
 
@@ -466,6 +774,7 @@ U_BOOT_DRIVER(cadence_spi) = {
 	.plat_auto	= sizeof(struct cadence_spi_plat),
 	.priv_auto	= sizeof(struct cadence_spi_priv),
 	.probe = cadence_spi_probe,
+	.child_pre_probe = cadence_spi_child_pre_probe,
 	.remove = cadence_spi_remove,
 	.flags = DM_FLAG_OS_PREPARE,
 };
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1c59d1a9d9..eec090a7ed 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -10,6 +10,7 @@
 #include <reset.h>
 #include <linux/mtd/spi-nor.h>
 #include <spi-mem.h>
+#include <wait_bit.h>
 
 #define CQSPI_IS_ADDR(cmd_len)		(cmd_len > 1 ? 1 : 0)
 
@@ -21,6 +22,8 @@
 #define CQSPI_REG_RETRY                         10000
 #define CQSPI_POLL_IDLE_RETRY                   3
 
+#define CQSPI_TIMEOUT_MS			1000
+
 /* Transfer mode */
 #define CQSPI_INST_TYPE_SINGLE                  0
 #define CQSPI_INST_TYPE_DUAL                    1
@@ -33,6 +36,23 @@
 #define CQSPI_DUMMY_BYTES_MAX                   4
 #define CQSPI_DUMMY_CLKS_MAX                    31
 
+#define CQSPI_TX_TAP_MASTER			0x1E
+#define CQSPI_MAX_DLL_TAPS			127
+
+#define CQSPI_DLL_MODE_MASTER			0
+#define CQSPI_DLL_MODE_BYPASS			1
+
+#define CQSPI_EDGE_MODE_SDR			0
+#define CQSPI_EDGE_MODE_DDR			1
+
+#define SILICON_VER_MASK			0xFF
+#define SILICON_VER_1				0x10
+
+#define CQSPI_READ_ID				0x9F
+#define CQSPI_READ_ID_LEN			3
+#define CQSPI_READID_LOOP_MAX			10
+#define TERA_MACRO				1000000000000l
+
 /****************************************************************************
  * Controller's configuration and status register (offset from QSPI_BASE)
  ****************************************************************************/
@@ -65,6 +85,7 @@
 #define CQSPI_REG_RD_INSTR_TYPE_ADDR_MASK       0x3
 #define CQSPI_REG_RD_INSTR_TYPE_DATA_MASK       0x3
 #define CQSPI_REG_RD_INSTR_DUMMY_MASK           0x1F
+#define CQSPI_REG_RD_INSTR_DDR_ENABLE		BIT(10)
 
 #define CQSPI_REG_WR_INSTR                      0x08
 #define CQSPI_REG_WR_INSTR_OPCODE_LSB           0
@@ -109,9 +130,14 @@
 
 #define CQSPI_REG_WR_COMPLETION_CTRL		0x38
 #define CQSPI_REG_WR_DISABLE_AUTO_POLL		BIT(14)
+#define CQSPI_REG_WRCOMPLETION			0x38
+#define CQSPI_REG_WRCOMPLETION_POLLCNT_MASK	0xFF0000
+#define CQSPI_REG_WRCOMPLETION_POLLCNY_LSB	16
+#define CQSPI_REG_WRCOMPLETION_POLLCNT		3
 
 #define CQSPI_REG_IRQSTATUS                     0x40
 #define CQSPI_REG_IRQMASK                       0x44
+#define CQSPI_REG_ECO				0x48
 
 #define CQSPI_REG_INDIRECTRD                    0x60
 #define CQSPI_REG_INDIRECTRD_START              BIT(0)
@@ -162,7 +188,31 @@
 #define CQSPI_REG_OP_EXT_STIG_LSB               0
 
 #define CQSPI_REG_PHY_CONFIG                    0xB4
+#define CQSPI_REG_PHY_CONFIG_RESYNC_FLD_MASK	0x80000000
 #define CQSPI_REG_PHY_CONFIG_RESET_FLD_MASK     0x40000000
+#define CQSPI_REG_PHY_CONFIG_TX_DLL_DLY_LSB	16
+
+#define CQSPI_REG_PHY_MASTER_CTRL              0xB8
+#define CQSPI_REG_PHY_INITIAL_DLY              0x4
+#define CQSPI_REG_DLL_LOWER                    0xBC
+#define CQSPI_REG_DLL_LOWER_LPBK_LOCK_MASK     0x8000
+#define CQSPI_REG_DLL_LOWER_DLL_LOCK_MASK      0x1
+
+#define CQSPI_REG_DLL_OBSVBLE_UPPER		0xC0
+#define CQSPI_REG_DLL_UPPER_RX_FLD_MASK		0x7F
+
+#define CQSPI_REG_EXT_OP_LOWER			0xE0
+#define CQSPI_REG_EXT_STIG_OP_MASK		0xFF
+#define CQSPI_REG_EXT_READ_OP_MASK		0xFF000000
+#define CQSPI_REG_EXT_READ_OP_SHIFT		24
+#define CQSPI_REG_EXT_WRITE_OP_MASK		0xFF0000
+#define CQSPI_REG_EXT_WRITE_OP_SHIFT		16
+#define CQSPI_REG_DMA_SRC_ADDR			0x1000
+#define CQSPI_REG_DMA_DST_ADDR			0x1800
+#define CQSPI_REG_DMA_DST_SIZE			0x1804
+#define CQSPI_REG_DMA_DST_STS			0x1808
+#define CQSPI_REG_DMA_DST_CTRL			0x180C
+#define CQSPI_REG_DMA_DST_CTRL_VAL		0xF43FFA00
 
 #define CQSPI_DMA_DST_ADDR_REG                  0x1800
 #define CQSPI_DMA_DST_SIZE_REG                  0x1804
@@ -247,6 +297,7 @@ struct cadence_spi_priv {
 	u32		tsd2d_ns;
 	u32		tchsh_ns;
 	u32		tslch_ns;
+	u8              device_id[CQSPI_READ_ID_LEN];
 	u8              edge_mode;
 	u8              dll_mode;
 	bool		extra_dummy;
@@ -304,6 +355,7 @@ int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv);
 int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_versal_flash_reset(struct udevice *dev);
+int cadence_qspi_versal_set_dll_mode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
 
 #endif /* __CADENCE_QSPI_H__ */
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 9ce2c0f254..d1a5a4c679 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -465,6 +465,9 @@ int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
 	unsigned int dummy_clk;
 	u8 opcode;
 
+	if (priv->dtr)
+		rxlen = ((rxlen % 2) != 0) ? (rxlen + 1) : rxlen;
+
 	if (priv->dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
@@ -477,6 +480,9 @@ int cadence_qspi_apb_command_read(struct cadence_spi_priv *priv,
 	if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 		return -ENOTSUPP;
 
+	if (priv->extra_dummy)
+		dummy_clk++;
+
 	if (dummy_clk)
 		reg |= (dummy_clk & CQSPI_REG_CMDCTRL_DUMMY_MASK)
 		     << CQSPI_REG_CMDCTRL_DUMMY_LSB;
@@ -553,6 +559,9 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 	void *reg_base = priv->regbase;
 	u8 opcode;
 
+	reg = cadence_qspi_calc_rdreg(priv);
+	writel(reg, reg_base + CQSPI_REG_RD_INSTR);
+
 	if (priv->dtr)
 		opcode = op->cmd.opcode >> 8;
 	else
@@ -609,7 +618,6 @@ int cadence_qspi_apb_command_write(struct cadence_spi_priv *priv,
 int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 				const struct spi_mem_op *op)
 {
-	unsigned int reg;
 	unsigned int rd_reg;
 	unsigned int dummy_clk;
 	unsigned int dummy_bytes = op->dummy.nbytes;
@@ -647,6 +655,9 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 		if (dummy_clk > CQSPI_DUMMY_CLKS_MAX)
 			return -ENOTSUPP;
 
+		if (priv->extra_dummy)
+			dummy_clk++;
+
 		if (dummy_clk)
 			rd_reg |= (dummy_clk & CQSPI_REG_RD_INSTR_DUMMY_MASK)
 				<< CQSPI_REG_RD_INSTR_DUMMY_LSB;
@@ -655,10 +666,10 @@ int cadence_qspi_apb_read_setup(struct cadence_spi_priv *priv,
 	writel(rd_reg, priv->regbase + CQSPI_REG_RD_INSTR);
 
 	/* set device size */
-	reg = readl(priv->regbase + CQSPI_REG_SIZE);
-	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
-	reg |= (op->addr.nbytes - 1);
-	writel(reg, priv->regbase + CQSPI_REG_SIZE);
+	clrsetbits_le32(priv->regbase + CQSPI_REG_SIZE,
+			CQSPI_REG_SIZE_ADDRESS_MASK,
+			op->addr.nbytes - 1);
+
 	return 0;
 }
 
@@ -828,10 +839,10 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 		writel(reg, priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
 	}
 
-	reg = readl(priv->regbase + CQSPI_REG_SIZE);
-	reg &= ~CQSPI_REG_SIZE_ADDRESS_MASK;
-	reg |= (op->addr.nbytes - 1);
-	writel(reg, priv->regbase + CQSPI_REG_SIZE);
+	clrsetbits_le32(priv->regbase + CQSPI_REG_SIZE,
+			CQSPI_REG_SIZE_ADDRESS_MASK,
+			op->addr.nbytes - 1);
+
 	return 0;
 }
 
@@ -846,6 +857,10 @@ cadence_qspi_apb_indirect_write_execute(struct cadence_spi_priv *priv,
 	unsigned int write_bytes;
 	int ret;
 
+	if (priv->edge_mode == CQSPI_EDGE_MODE_DDR && (n_tx % 2) != 0)
+		n_tx++;
+	remaining = n_tx;
+
 	/*
 	 * Use bounce buffer for non 32 bit aligned txbuf to avoid data
 	 * aborts
-- 
2.27.0

