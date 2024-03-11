Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59682C54E58
	for <u-boot@archiver.kernel.org>; Mon, 11 Mar 2024 17:23:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9677787F17;
	Mon, 11 Mar 2024 18:23:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W3/8rfw4";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 609118786A; Mon, 11 Mar 2024 18:23:11 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EBA5B87EFF
 for <u-boot@lists.denx.de>; Mon, 11 Mar 2024 18:23:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUSbsynxp87ZaQN7IzU4iNzMijKs54O1SkiJnq5bVCjzX8zwgqBlfzumDlIdgxjFa0lyEB0taHulur1NSGGRLEJiuRvuza1OU9zy+/fVN3wJR1HDHTc5oE2XKgsgnq4JMIGOY1rrdwi844N1G/4NE6WFHXfIdRklZNVPjKqQMydjY8FEsP7T+aEYBRAAn26i14QS4sPkXNUl7f+mY+pPK3EJzDZb6k0dVCdMBS9no+5U8lYZISP4MdfKqUQrXICWmxpK+FJhU4xXnv8bECEEY14HG8aF7UCggeQMsEr4sFXh/RKHkJVw19qVlNGhjfmk3CHg2sR5SVCUmDRxotqgHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBNWClPdvx6XZMWsskeg6lSLDKMIOZ5xbF+/dIq3+FY=;
 b=KmW/5K7HhRnt6/AZcfzhnTTgqZAmlqTGnfj8+fc6g8jHRSZz0k+SoTMkLxIJcPE/ZVD95Eg0LNoz4c2/KYenOzNfWJStokwkoPkyICao41mJiqETHI3k/rXQCw9vkwDI+koKCJlo9XyDjFTe6G0PVqmve8pQ5x5XTsHooXWULd8PUMlDrbOb3qJLMMRN5dg9+M/TuvvV13xXnzCFGRzHajB08fzLxOp4eVAeq6JvT1xr42UEulhZs5KocPj7+OYRpfzZ7SAleruOaPo1MQaA4gGik7f7eRGH/Zz4aO8DuSLX/Vf6hDtHu3jBWutITnKiC6oRtuTK6NqYYP9nKAne6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBNWClPdvx6XZMWsskeg6lSLDKMIOZ5xbF+/dIq3+FY=;
 b=W3/8rfw4k8zZluBc+Na4g+KDca66n0EDQUh85Kk92oEwD+WndSLOGXSZxWndlnPaQRMzbqO3cHn7LnYiZU9YRK6PTvN2+W5ZnYvWGujA5IoJtZ+69w/lVqn+EWiuFZBio9vWfXYhZkWzQ13SgLYaXkLq0HtpADERKlY8E/dYu38=
Received: from CH2PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:52::13)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 17:23:05 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::2c) by CH2PR04CA0003.outlook.office365.com
 (2603:10b6:610:52::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36 via Frontend
 Transport; Mon, 11 Mar 2024 17:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 17:23:04 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 12:23:03 -0500
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Mon, 11 Mar 2024 12:23:01 -0500
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <n-francis@ti.com>, <michal.simek@amd.com>, 
 <venkatesh.abbarapu@amd.com>, <git@amd.com>, T Karthik Reddy
 <t.karthik.reddy@amd.com>
Subject: [PATCH 02/19] spi: cadence-qspi: reset the ospi controller
Date: Mon, 11 Mar 2024 22:52:32 +0530
Message-ID: <9b53c04884a0a9b648e03a0c1d2f2dd7d74fed31.1710098033.git.tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
References: <cover.1710098033.git.tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: tejas.arvind.bhumkar@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: 18510b74-423b-4be3-44d7-08dc41efe954
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDBtF7kwYmtwq5UBfwT3rlui8VYfFVnmpL1RCAK18BdkmNlJrRlUJR7qFx1HMe87DCSsqJLrrSl1q3FbfE2PukjCtdjSlVaiRu3zTCpj+KmQBY7gq7FOEh6g/kuKKhZo5MTT5ZOQoesE2HaakVoW+zueJ54LSfM9SgtnlVxVdvVqoAIajIYMTSSjJ9bfMEqf4ReVaL1gxIlr2SdAe6/sFjfisffuwJWiaqgJENdazQ0uAl7vU6PwTzak+xVmk9zULlUATYQNiBDtxsHls243xuyM+0cUF6hrsVEKPr8J3HR+6MUucqNdESxcHYnsBBByaRqxAU5VfLZ0f77v8mE95lnvOq65y6Pbezjq8zOtJDOK9zrb0zGQql6MoqZCXziKl+UcdAoACQF6iIhLViBEIhl6pICTr0dYz3aPDTPghsIJtnbH1v0Q8OENDsJ5DwNRUdhS6ThEY4RAxjpiWxL8WXLhzVyvk3UaJVexb2lPmlGJMge4STTMSizlOfSmvwJiT9y+Pz9Y853CydH3T4a0bBuq2BmSVqBHUfUx9YVwp6F5QdZ7EK1EKHWHpZXrGD1s2M8FSO3+C21C2oMiwtnbyqzqoOm8YPI6DllvOojSguXN+bBoC2O54yzVbMdtoz4B4MAcg04/w6+WUcBG3PAIBUr4QejwEpOMWpF6n3MS+3WljJjbewS3iPT9DU4h8DZKbrmx7vcJ4v7ESlTguIqZuAdZbib4vUDTyNYjlus6hOfs7fMSqPo6OpAjF8Vz6QGj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 17:23:04.6745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18510b74-423b-4be3-44d7-08dc41efe954
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791
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

From: T Karthik Reddy <t.karthik.reddy@amd.com>

The Cadence driver must switch between SDR and DTR modes as
directed by commands from the spi-nor framework. It should
avoid reinitializing SDR/DTR tuning if it has already been
completed.
Additionally, functionality has been added to reset the
controller when transitioning from DTR to SDR mode. This
reset is achieved using the reset_assert and reset_deassert
APIs for the OSPI controller. In cases where the ZYNQMP_FIRMWARE
configuration is disabled in mini U-Boot, the controller is
reset directly using register writes.

The configuration of the chip select in the Cadence QSPI driver
is now determined based on the flags received from the SPI-NOR
framework.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 29 ++++++++++++++
 drivers/spi/cadence_qspi.c        | 63 ++++++++++++++++++++++++++++---
 drivers/spi/cadence_qspi.h        |  7 ++++
 3 files changed, 94 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 70682490e6..30abb7b431 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -151,6 +151,35 @@ int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
 	return -ENOTSUPP;
 }
 
+int cadence_spi_versal_ctrl_reset(struct cadence_spi_priv *priv)
+{
+	int ret;
+
+	if (CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
+		/* Assert ospi controller */
+		ret = reset_assert(priv->resets->resets);
+		if (ret)
+			return ret;
+
+		udelay(10);
+
+		/* Deassert ospi controller */
+		ret = reset_deassert(priv->resets->resets);
+		if (ret)
+			return ret;
+	} else {
+		/* Assert ospi controller */
+		setbits_le32((u32 *)OSPI_CTRL_RST, 1);
+
+		udelay(10);
+
+		/* Deassert ospi controller */
+		clrbits_le32((u32 *)OSPI_CTRL_RST, 1);
+	}
+
+	return 0;
+}
+
 #if defined(CONFIG_DM_GPIO)
 int cadence_qspi_versal_flash_reset(struct udevice *dev)
 {
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 0a1257352a..dd6aef9ab5 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -148,7 +148,7 @@ static int spi_calibration(struct udevice *bus, uint hz)
 
 	/* just to ensure we do once only when speed or chip select change */
 	priv->qspi_calibrated_hz = hz;
-	priv->qspi_calibrated_cs = spi_chip_select(bus);
+	priv->qspi_calibrated_cs = priv->cs;
 
 	return 0;
 }
@@ -173,7 +173,7 @@ static int cadence_spi_set_speed(struct udevice *bus, uint hz)
 						  priv->read_delay);
 	} else if (priv->previous_hz != hz ||
 		   priv->qspi_calibrated_hz != hz ||
-		   priv->qspi_calibrated_cs != spi_chip_select(bus)) {
+		   priv->qspi_calibrated_cs != priv->cs) {
 		/*
 		 * Calibration required for different current SCLK speed,
 		 * requested SCLK speed or chip select
@@ -574,6 +574,9 @@ static int cadence_spi_setup_ddrmode(struct spi_slave *spi, const struct spi_mem
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
 	int ret;
 
+	if (priv->ddr_init)
+		return 0;
+
 	ret = priv_setup_ddrmode(bus);
 	if (ret)
 		return ret;
@@ -584,7 +587,47 @@ static int cadence_spi_setup_ddrmode(struct spi_slave *spi, const struct spi_mem
 		printf("DDR tuning failed with error %d\n", ret);
 		return ret;
 	}
-	priv->ddr_init = 1;
+	priv->ddr_init = true;
+
+	return 0;
+}
+
+static int cadence_spi_setup_strmode(struct udevice *bus)
+{
+	struct cadence_spi_priv *priv = dev_get_priv(bus);
+	void *base = priv->regbase;
+	int ret;
+
+	if (!priv->ddr_init)
+		return 0;
+
+	/* Reset ospi controller */
+	ret = cadence_spi_versal_ctrl_reset(priv);
+	if (ret) {
+		printf("Cadence ctrl reset failed err: %d\n", ret);
+		return ret;
+	}
+
+	ret = wait_for_bit_le32(base + CQSPI_REG_CONFIG,
+				BIT(CQSPI_REG_CONFIG_IDLE_LSB),
+				1, CQSPI_TIMEOUT_MS, 0);
+	if (ret) {
+		printf("spi_wait_idle error : 0x%x\n", ret);
+		return ret;
+	}
+
+	cadence_qspi_apb_controller_init(priv);
+	priv->edge_mode = CQSPI_EDGE_MODE_SDR;
+	priv->extra_dummy = 0;
+	priv->previous_hz = 0;
+	priv->qspi_calibrated_hz = 0;
+
+	/* Setup default speed and calibrate */
+	ret = cadence_spi_set_speed(bus, 0);
+	if (ret)
+		return ret;
+
+	priv->ddr_init = false;
 
 	return 0;
 }
@@ -598,9 +641,19 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	int err = 0;
 	u32 mode;
 
+	if (!op->cmd.dtr) {
+		err = cadence_spi_setup_strmode(bus);
+		if (err)
+			return err;
+	}
+
+	if (spi->flags & SPI_XFER_U_PAGE)
+		priv->cs = CQSPI_CS1;
+	else
+		priv->cs = CQSPI_CS0;
+
 	/* Set Chip select */
-	cadence_qspi_apb_chipselect(base, spi_chip_select(spi->dev),
-				    priv->is_decoded_cs);
+	cadence_qspi_apb_chipselect(base, priv->cs, priv->is_decoded_cs);
 
 	if (op->data.dir == SPI_MEM_DATA_IN && op->data.buf.in) {
 		/*
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 6d7e31da50..d11209ffa8 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -18,6 +18,9 @@
 #define CQSPI_DECODER_MAX_CS		16
 #define CQSPI_READ_CAPTURE_MAX_DELAY	16
 
+#define CQSPI_CS0				0
+#define CQSPI_CS1				1
+
 #define CQSPI_REG_POLL_US                       1 /* 1us */
 #define CQSPI_REG_RETRY                         10000
 #define CQSPI_POLL_IDLE_RETRY                   3
@@ -56,6 +59,8 @@
 #define CQSPI_READID_LOOP_MAX			10
 #define TERA_MACRO				1000000000000l
 
+#define OSPI_CTRL_RST				0xF1260304
+
 /****************************************************************************
  * Controller's configuration and status register (offset from QSPI_BASE)
  ****************************************************************************/
@@ -287,6 +292,7 @@ struct cadence_spi_priv {
 	size_t		data_len;
 
 	int		qspi_is_init;
+	unsigned int    cs;
 	unsigned int	qspi_calibrated_hz;
 	unsigned int	qspi_calibrated_cs;
 	unsigned int	previous_hz;
@@ -360,5 +366,6 @@ int cadence_qspi_versal_flash_reset(struct udevice *dev);
 ofnode cadence_qspi_get_subnode(struct udevice *dev);
 int cadence_qspi_versal_set_dll_mode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
+int cadence_spi_versal_ctrl_reset(struct cadence_spi_priv *priv);
 
 #endif /* __CADENCE_QSPI_H__ */
-- 
2.27.0

