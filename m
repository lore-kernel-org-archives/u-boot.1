Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE26C4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:35:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56BC0876F8;
	Wed,  6 Dec 2023 06:34:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1yPkZDEK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 870D6876EA; Wed,  6 Dec 2023 06:34:30 +0100 (CET)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::604])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC210876F2
 for <u-boot@lists.denx.de>; Wed,  6 Dec 2023 06:34:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=tejas.arvind.bhumkar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQHWBCpywVbveBWxDjca4YD5sB5D955e5flL7O9ycp46zFsRn3A6m3SYK+joL9bpberc9i7y5c3Hs7VYwAJABZz85QYSHXo7yZ3T76xizwG9q42qhfh9bnf7TvYkoFIxFPJM4S5rK4emcrRb9VW8Wpwv5vZ6c/PXoiIaAGcohgI9CVh8RtZ6Rm03JSyieXeB+eRc2rhBmUrnaE9UMgg5X10hSXfmSoboQrfGriPxtL0Lk4rBQdWNwwzkfBboTCoQQqREiqZHzX8li3n4tbyRjnT7s/EN8NihLWwWzh+GloDr0gijyyRXJFNP9X9ag9yubo4M2gHYaFOsBtA/44R0Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Bm7Anvx0H4sVksCOtZ+M4IHETLOzgcVCUYIIYch9Rw=;
 b=cE0UkZZPEguJL7YOSGknu6XHZSJNV2yuCSoA1mLot9frkVMwHNeq0zC0EQhXsh3MnWhVdExKq4Pj8howujVkEk7CKSaQNdnXZFebkxOI/tbkniwZt6tSSZKuOxCevVqvWnV1y7qjt8J1DDW3tkv0rRjYq4NxL60kpSqOJqWuR8q04H6LasesheuG+1k7Pl7nSaUXKREtKgXWvzZ4/9Px2nPh/7jIl5E/O/JqJ2jeq+zQ5FZknMZL34WZTKJ4Eu/VAHog+QgSmT5CMxi20dL6VZE3lpOQPzfR8Rfz7CNkMKL2jhL/t72BbniCIwy+NM7oUd0JrDiAeA+AZ2p8yKzaag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Bm7Anvx0H4sVksCOtZ+M4IHETLOzgcVCUYIIYch9Rw=;
 b=1yPkZDEK3rYsrsCKStpFOjJGYLQl1Nsa4/Xf7BjuM7zIRIzQ0dvvA9fm/HTa8pKNLmECiIp106LmBMglVGIxSQiPZP/oJvI7ARDt37ob4qATAhmICmZ9YwMvSLn3BYdUEVgHgWRzz7dAriTjoFQ6RmSPc74JADS0wKPSZsyeh04=
Received: from PA7P264CA0539.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3db::19)
 by CY8PR12MB7123.namprd12.prod.outlook.com (2603:10b6:930:60::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 05:34:21 +0000
Received: from SN1PEPF0002BA4B.namprd03.prod.outlook.com
 (2603:10a6:102:3db:cafe::18) by PA7P264CA0539.outlook.office365.com
 (2603:10a6:102:3db::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25 via Frontend
 Transport; Wed, 6 Dec 2023 05:34:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA4B.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7068.20 via Frontend Transport; Wed, 6 Dec 2023 05:34:19 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 5 Dec
 2023 23:34:19 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Tue, 5 Dec
 2023 21:34:18 -0800
Received: from xhdcl190040.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Tue, 5 Dec 2023 23:34:16 -0600
From: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
To: <u-boot@lists.denx.de>
CC: <joe.hershberger@ni.com>, <rfried.dev@gmail.com>, <michal.simek@amd.com>, 
 <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <git@xilinx.com>,
 "T Karthik Reddy" <t.karthik.reddy@amd.com>
Subject: [PATCH 15/30] spi: cadence-qspi: Switch SDR/DTR using
 SPI_FLASH_DTR_ENABLE config
Date: Wed, 6 Dec 2023 11:03:49 +0530
Message-ID: <20231206053353.3745918-6-tejas.arvind.bhumkar@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
References: <20231206053353.3745918-1-tejas.arvind.bhumkar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4B:EE_|CY8PR12MB7123:EE_
X-MS-Office365-Filtering-Correlation-Id: 87623154-fed5-43a3-59d7-08dbf61cfee4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CAcUzJXkTVb3JCq8HeEQS5n5BgStsWO2JiqudGlUDbmKmEWmjP9kb+5dHF4UU4/aEqRWH7AjuhWpLOwIP5Ipc6R2zmXGmX0OLWeKHywQ2BAr3oY2h+TXyePweMLZ977c5v3LvXxZCtYb/7NdVOqcejH4jiYhKkr+W8dphBsheZ0ElOy8Ie2kaVcWs+Hrz7No5H4xK8dCdseesgq9e/DQhgiCAmo82v1CaptfWiol/NnIuANSRzgLw0WtTi8dLRF5UtamJyssPYqSporTUA0PpCWAQDhb3+Q1wjTJvgfMepcEYXSu8Yv/QO+jGMtQ9/D2yquEschhGdlDbSG0eEcn2OzcxqsuOPj7iSXX8RrCrwNr1knSbeiBAVTqeGRgD1mfiFwV0sKGJTaUfirWlTEw1I2wmPK/2/4xtHpYNHpyK2MjDSgk5RkDNuQhK7owD8+CgpIwoWUsMd61cbSuKqFcx+cY3wJnlKt1P5u3CixYiWxsLCJ0HugyySBB5L+3LgSdZ4TwXLFbl1DsRk6B0XU2HcU+FvxW1hxed2CqKjnDowhWUsKsyXWpZVPQ3vp+NEGV2BZeXNMypyTMg6OcTpcRwvZLOik8kPFPc6tS46RDJZg4+iZS+Dk+K2JiAQb5URIpxKj5ObameT4/l/nqSC/4RoIVbjZbhzEUQrAAItSmQhFtwnR0A7z510Qdd4+Cp4B81j651DjMzhln4qXSBIIGlRnkk71u7nZJH9gB+UrqSZKPjk3yX+5ivnv4yivnTnHYfOjGhIBQnPjWNGUxrqT+6w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(396003)(136003)(376002)(346002)(230922051799003)(82310400011)(64100799003)(186009)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(40460700003)(316002)(81166007)(82740400003)(5660300002)(2906002)(41300700001)(36860700001)(86362001)(103116003)(36756003)(356005)(47076005)(336012)(26005)(6666004)(2616005)(478600001)(1076003)(8676002)(70586007)(4326008)(70206006)(54906003)(83380400001)(8936002)(6916009)(426003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 05:34:19.8327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87623154-fed5-43a3-59d7-08dbf61cfee4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7123
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

Cadence driver need to switch from SDR to DTR and vice versa based on
the commands from spi-nor framework and based on SPI_FLASH_DTR_ENABLE
config. If SPI_FLASH_DTR_ENABLE is not defined, do not switch to DTR
mode as it represents that controller does not support DTR. Also do
not reinitilize the SDR/DTR tuning if it is already done.
Also added the functionality to reset the controller when switching
from DTR to STR mode.
Use reset_assert, reset_deassert api's to reset the ospi controller.
In mini U-Boot case as ZYNQMP_FIRMWARE config is disabled, reset the
controller directly using register writes.

The configuration of the chip select in the Cadence QSPI driver is
now determined based on the flags received from SPI-NOR framework.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@amd.com>
Signed-off-by: Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 29 +++++++++++++
 drivers/spi/cadence_qspi.c        | 69 ++++++++++++++++++++++++++++---
 drivers/spi/cadence_qspi.h        |  7 ++++
 3 files changed, 99 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 74994a690d..243de6efaf 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -154,6 +154,35 @@ int cadence_qspi_versal_set_dll_mode(struct udevice *dev)
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
index 32f91825fd..710c4a532d 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -154,7 +154,7 @@ static int spi_calibration(struct udevice *bus, uint hz)
 
 	/* just to ensure we do once only when speed or chip select change */
 	priv->qspi_calibrated_hz = hz;
-	priv->qspi_calibrated_cs = spi_chip_select(bus);
+	priv->qspi_calibrated_cs = priv->cs;
 
 	return 0;
 }
@@ -179,7 +179,7 @@ static int cadence_spi_set_speed(struct udevice *bus, uint hz)
 						  priv->read_delay);
 	} else if (priv->previous_hz != hz ||
 		   priv->qspi_calibrated_hz != hz ||
-		   priv->qspi_calibrated_cs != spi_chip_select(bus)) {
+		   priv->qspi_calibrated_cs != priv->cs) {
 		/*
 		 * Calibration required for different current SCLK speed,
 		 * requested SCLK speed or chip select
@@ -580,6 +580,9 @@ static int cadence_spi_setup_ddrmode(struct udevice *bus)
 	struct cadence_spi_priv *priv = dev_get_priv(bus);
 	int ret;
 
+	if (priv->ddr_init)
+		return 0;
+
 	ret = priv_setup_ddrmode(bus);
 	if (ret)
 		return ret;
@@ -590,7 +593,47 @@ static int cadence_spi_setup_ddrmode(struct udevice *bus)
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
@@ -604,9 +647,22 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 	int err = 0;
 	u32 mode;
 
+	if (!op->cmd.dtr) {
+		err = cadence_spi_setup_strmode(bus);
+		if (err)
+			return err;
+	}
+
+	if (!CONFIG_IS_ENABLED(SPI_FLASH_DTR_ENABLE) && op->cmd.dtr)
+		return 0;
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
@@ -655,7 +711,8 @@ static int cadence_spi_mem_exec_op(struct spi_slave *spi,
 		break;
 	}
 
-	if (!priv->ddr_init && (spi->flags & SPI_XFER_SET_DDR))
+	if (CONFIG_IS_ENABLED(SPI_FLASH_DTR_ENABLE) &&
+	    (spi->flags & SPI_XFER_SET_DDR))
 		err = cadence_spi_setup_ddrmode(bus);
 
 	return err;
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index eec090a7ed..505f59bed9 100644
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
@@ -53,6 +56,8 @@
 #define CQSPI_READID_LOOP_MAX			10
 #define TERA_MACRO				1000000000000l
 
+#define OSPI_CTRL_RST				0xF1260304
+
 /****************************************************************************
  * Controller's configuration and status register (offset from QSPI_BASE)
  ****************************************************************************/
@@ -284,6 +289,7 @@ struct cadence_spi_priv {
 	size_t		data_len;
 
 	int		qspi_is_init;
+	unsigned int    cs;
 	unsigned int	qspi_calibrated_hz;
 	unsigned int	qspi_calibrated_cs;
 	unsigned int	previous_hz;
@@ -357,5 +363,6 @@ int cadence_qspi_apb_exec_flash_cmd(void *reg_base, unsigned int reg);
 int cadence_qspi_versal_flash_reset(struct udevice *dev);
 int cadence_qspi_versal_set_dll_mode(struct udevice *dev);
 void cadence_qspi_apb_enable_linear_mode(bool enable);
+int cadence_spi_versal_ctrl_reset(struct cadence_spi_priv *priv);
 
 #endif /* __CADENCE_QSPI_H__ */
-- 
2.27.0

