Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAED1C4332F
	for <u-boot@archiver.kernel.org>; Thu, 14 Dec 2023 05:24:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9568B87A06;
	Thu, 14 Dec 2023 06:24:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aZCwC3WJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 73DE887A08; Thu, 14 Dec 2023 06:24:14 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7B0787A06
 for <u-boot@lists.denx.de>; Thu, 14 Dec 2023 06:24:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PIuu+4fxTGUa4sc+Cftz3qfUPk2z51DK96bBnGKTeEVYa3JbKUCH/bGFta61oqbHup3+TmiDf36iHwwQR23qqIBME/bK7uZ8E+iH9coQn1Z7/kzCGGONDjSD9NrEotVoFWCgqfwqu4fm1wh/lYIty+DsAZvp+RruN5Ij+s4NZnimZ09siEDdlnNbZuJMzwpWvyy9TYnYBfjVILAGORuw+5kLIfyzlOhEzlUuRxSZ2XhLWlOn5On2LwWPH1nRanR88WolOi2KSfELxKJ/x5EJ9XI8tI79I3uWXQe4b0b6IKdBX39oZgrDqn12ZMz1aVxNrRrPhWeSs4loWy1l1ECwZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LGY8T1aQuoOp71DuFgN7iBxED3eU0XKyH/tlQbEquJk=;
 b=ThKZkCjfgzBYSVB7WS2u3o6OZg1Ro4Sv1mejK83A9Vx7GUHMqH5VCH9yY63DOph5s8GLCbYlerj0+YzJrh8jJflMXepfSCCJ0BMPMWCcjmv2rJg9+oo4A5apOYPL0L5EpyeKAEkQnDhcPU4wUkcxZrhpgqC153PnoizfGagiYi98G8/t2qKR4q+HdSQXIShEcmjBSp9KbbNLMI3zE5it6QEUeEBYsQRcDZ8aUMGSHuhn3totAepQ9khMqaS7RqntSjXHCPV384dX1ikbqzJAcgdobz7oLTPcZ+pLnJSYztruEaylLKzEBwjUyvo1K+HS5c2wjmdsAcxF9a6SCQzD/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LGY8T1aQuoOp71DuFgN7iBxED3eU0XKyH/tlQbEquJk=;
 b=aZCwC3WJfjZZTi2Lh9ltd2y2nFoatYvdnNkRpV2F6sHDh3O1kEY/1IoFO1ZyvKSmtKpfdzn4G8+RoSD1oKPWbKjbrpqGHmU1A54ZgnqPOhaMTS03pdaYC7U3fsrhKCCmubD9C1mWH8Ia33tdEMUnkQrRNIT1XTfVV250vdotcCc=
Received: from SA1P222CA0071.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::18)
 by IA1PR12MB8189.namprd12.prod.outlook.com (2603:10b6:208:3f0::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 05:24:05 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:806:2c1:cafe::66) by SA1P222CA0071.outlook.office365.com
 (2603:10b6:806:2c1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28 via Frontend
 Transport; Thu, 14 Dec 2023 05:24:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Thu, 14 Dec 2023 05:24:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 13 Dec
 2023 23:24:03 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Wed, 13 Dec 2023 23:24:01 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <git@xilinx.com>, Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Subject: [PATCH v6 4/6] spi: spi-uclass: Read chipselect and restrict
 capabilities
Date: Thu, 14 Dec 2023 10:53:37 +0530
Message-ID: <20231214052339.82382-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214052339.82382-1-venkatesh.abbarapu@amd.com>
References: <20231214052339.82382-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|IA1PR12MB8189:EE_
X-MS-Office365-Filtering-Correlation-Id: 73112cb2-1b79-43e9-efb2-08dbfc64e3a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: febUFmNJktjdkvqXLp/HKtdCo81bFStCAyqAYvi33RWZg0WaNHI3zjYCaj5XmVOLOt9EmspNe+JiQwKFN5XIcl6NSNB7yx5h6+oTPRhpwbhAr+PMIx3hqZNC8c0bPVLhBfOBuJB077L3/J7a8jx0n7kBy3ZQWjq7R+iy52kWmKmGmNhL7D5+9pfBxkUp0TcmXzF1MNO4JPHt99HYivrNVLEVO+bXsM2/ciKyAP1fsiJCOHj1Jg+QskRTuYoN70FqzYoxjsihpUZXB+S1wlfljKCA40ggtSsCA2iEKW1sLLZWXWRnd4rAGBBptTIwnLvAMdeBIjW5xr7fHhuMOi5/s2+YtWQWYPU8h7S5P1Px8WTyluU++bXr75Hz2u0GM1s02NcXaR+E4v98O2tD5H98BtzwZTncvk/D+esMI7i55KH3kwrch3nMWeWYIAtQS8QtUT4o6/2BdzB3exG/PV2GadF5lnc1KJzd1qQU3tUIpNEXwOoMJpgS0m89bEDkgjdnv+LU9/iefKAqOZx0VGvZf7UJN+VriPadVuc2JD3N5Bu0zMVaw0Vv4siPIK/lqND9F6ltBOkZzhjPlTNKLS15hvM1J3WYtW4npeCdw8OUO65iXazJKowN8AIl5ZCvQKwx5S9MS80ausmK03jBwfHEIrRji6yXNvnkP1eyuUJZ1FWcLbtiS4UQBy9P9lWqu3UFOaS4zVdcG48agOYWgev0MUPQRDtg+rM9qGFJ3EtUHvtuSsLMbkZtEiJkl+dYJxbL63X7LK33MB98t+ry0BfptQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(40480700001)(478600001)(5660300002)(6666004)(6916009)(54906003)(82740400003)(2906002)(30864003)(47076005)(2616005)(1076003)(86362001)(26005)(336012)(426003)(36756003)(70206006)(70586007)(316002)(4326008)(40460700003)(8936002)(8676002)(356005)(41300700001)(81166007)(83380400001)(36860700001)(36900700001)(579004);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2023 05:24:04.8729 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73112cb2-1b79-43e9-efb2-08dbfc64e3a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8189
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

From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>

Read chipselect properties from DT which are populated using 'reg'
property and save it in plat->cs[] array for later use.

Also read multi chipselect capability which is used for
parallel-memories and return errors if they are passed on using DT but
driver is not capable of handling it.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/mtd/spi/sandbox.c    |  2 +-
 drivers/spi/altera_spi.c     |  4 ++--
 drivers/spi/atcspi200_spi.c  |  2 +-
 drivers/spi/ath79_spi.c      |  2 +-
 drivers/spi/atmel_spi.c      |  6 +++---
 drivers/spi/bcm63xx_hsspi.c  | 42 ++++++++++++++++++------------------
 drivers/spi/bcm63xx_spi.c    |  6 +++---
 drivers/spi/bcmbca_hsspi.c   | 34 ++++++++++++++---------------
 drivers/spi/cf_spi.c         |  6 +++---
 drivers/spi/davinci_spi.c    |  6 +++---
 drivers/spi/fsl_dspi.c       | 18 ++++++++--------
 drivers/spi/fsl_espi.c       |  4 ++--
 drivers/spi/fsl_qspi.c       |  4 ++--
 drivers/spi/gxp_spi.c        |  2 +-
 drivers/spi/mpc8xx_spi.c     |  4 ++--
 drivers/spi/mpc8xxx_spi.c    | 10 ++++-----
 drivers/spi/mscc_bb_spi.c    |  4 ++--
 drivers/spi/mxc_spi.c        |  6 +++---
 drivers/spi/npcm_fiu_spi.c   | 14 ++++++------
 drivers/spi/nxp_fspi.c       |  2 +-
 drivers/spi/octeon_spi.c     |  2 +-
 drivers/spi/omap3_spi.c      |  4 ++--
 drivers/spi/pic32_spi.c      |  2 +-
 drivers/spi/rk_spi.c         |  4 ++--
 drivers/spi/rockchip_sfc.c   |  2 +-
 drivers/spi/spi-aspeed-smc.c | 28 ++++++++++++------------
 drivers/spi/spi-mxic.c       |  6 +++---
 drivers/spi/spi-qup.c        |  4 ++--
 drivers/spi/spi-sifive.c     |  6 +++---
 drivers/spi/spi-sn-f-ospi.c  |  2 +-
 drivers/spi/spi-sunxi.c      |  6 +++---
 drivers/spi/spi-synquacer.c  |  4 ++--
 drivers/spi/spi-uclass.c     | 23 +++++++++++++++-----
 drivers/spi/stm32_qspi.c     |  2 +-
 drivers/spi/stm32_spi.c      |  4 ++--
 drivers/spi/ti_qspi.c        | 14 ++++++------
 drivers/spi/xilinx_spi.c     |  4 ++--
 drivers/spi/zynq_qspi.c      |  6 +++---
 drivers/spi/zynq_spi.c       |  6 +++---
 include/spi.h                |  8 ++++++-
 lib/acpi/acpi_device.c       |  2 +-
 41 files changed, 168 insertions(+), 149 deletions(-)

diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
index 4fe547171a..72036d5a88 100644
--- a/drivers/mtd/spi/sandbox.c
+++ b/drivers/mtd/spi/sandbox.c
@@ -139,7 +139,7 @@ static int sandbox_sf_probe(struct udevice *dev)
 		return ret;
 	}
 	slave_plat = dev_get_parent_plat(dev);
-	cs = slave_plat->cs;
+	cs = slave_plat->cs[0];
 	debug("found at cs %d\n", cs);
 
 	if (!pdata->filename) {
diff --git a/drivers/spi/altera_spi.c b/drivers/spi/altera_spi.c
index 989679e881..48782f81c1 100644
--- a/drivers/spi/altera_spi.c
+++ b/drivers/spi/altera_spi.c
@@ -96,7 +96,7 @@ static int altera_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	uint32_t reg, data, start;
 
 	debug("%s: bus:%i cs:%i bitlen:%i bytes:%i flags:%lx\n", __func__,
-	      dev_seq(bus), slave_plat->cs, bitlen, bytes, flags);
+	      dev_seq(bus), slave_plat->cs[0], bitlen, bytes, flags);
 
 	if (bitlen == 0)
 		goto done;
@@ -111,7 +111,7 @@ static int altera_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		readl(&regs->rxdata);
 
 	if (flags & SPI_XFER_BEGIN)
-		spi_cs_activate(dev, slave_plat->cs);
+		spi_cs_activate(dev, slave_plat->cs[0]);
 
 	while (bytes--) {
 		if (txp)
diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index de9c14837c..acee743653 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -321,7 +321,7 @@ static int atcspi200_spi_claim_bus(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct nds_spi_slave *ns = dev_get_priv(bus);
 
-	if (slave_plat->cs >= ns->num_cs) {
+	if (slave_plat->cs[0] >= ns->num_cs) {
 		printf("Invalid SPI chipselect\n");
 		return -EINVAL;
 	}
diff --git a/drivers/spi/ath79_spi.c b/drivers/spi/ath79_spi.c
index 205567ef54..ad10cec2a6 100644
--- a/drivers/spi/ath79_spi.c
+++ b/drivers/spi/ath79_spi.c
@@ -74,7 +74,7 @@ static int ath79_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	if (restbits)
 		bytes++;
 
-	out = AR71XX_SPI_IOC_CS_ALL & ~(AR71XX_SPI_IOC_CS(slave->cs));
+	out = AR71XX_SPI_IOC_CS_ALL & ~(AR71XX_SPI_IOC_CS(slave->cs[0]));
 	while (bytes > 0) {
 		bytes--;
 		curbyte = 0;
diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index aec6f4eca9..e2de39d1ef 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -126,7 +126,7 @@ static int atmel_spi_claim_bus(struct udevice *dev)
 	struct atmel_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	struct at91_spi *reg_base = bus_plat->regs;
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	u32 freq = priv->freq;
 	u32 scbr, csrx, mode;
 
@@ -175,7 +175,7 @@ static void atmel_spi_cs_activate(struct udevice *dev)
 	struct udevice *bus = dev_get_parent(dev);
 	struct atmel_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (!dm_gpio_is_valid(&priv->cs_gpios[cs]))
 		return;
@@ -190,7 +190,7 @@ static void atmel_spi_cs_deactivate(struct udevice *dev)
 	struct udevice *bus = dev_get_parent(dev);
 	struct atmel_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (!dm_gpio_is_valid(&priv->cs_gpios[cs]))
 		return;
diff --git a/drivers/spi/bcm63xx_hsspi.c b/drivers/spi/bcm63xx_hsspi.c
index a24bb430cb..9614a7f536 100644
--- a/drivers/spi/bcm63xx_hsspi.c
+++ b/drivers/spi/bcm63xx_hsspi.c
@@ -175,7 +175,7 @@ static void bcm63xx_hsspi_activate_cs(struct bcm63xx_hsspi_priv *priv,
 	set = DIV_ROUND_UP(2048, set);
 	set &= SPI_PFL_CLK_FREQ_MASK;
 	set |= SPI_PFL_CLK_RSTLOOP_MASK;
-	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs));
+	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs[0]));
 
 	/* profile signal */
 	set = 0;
@@ -193,29 +193,29 @@ static void bcm63xx_hsspi_activate_cs(struct bcm63xx_hsspi_priv *priv,
 	if (speed > SPI_MAX_SYNC_CLOCK)
 		set |= SPI_PFL_SIG_ASYNCIN_MASK;
 
-	clrsetbits_32(priv->regs + SPI_PFL_SIG_REG(plat->cs), clr, set);
+	clrsetbits_32(priv->regs + SPI_PFL_SIG_REG(plat->cs[0]), clr, set);
 
 	/* global control */
 	set = 0;
 	clr = 0;
 
 	if (priv->xfer_mode == HSSPI_XFER_MODE_PREPEND) {
-		if (priv->cs_pols & BIT(plat->cs))
-			set |= BIT(plat->cs);
+		if (priv->cs_pols & BIT(plat->cs[0]))
+			set |= BIT(plat->cs[0]);
 		else
-			clr |= BIT(plat->cs);
+			clr |= BIT(plat->cs[0]);
 	} else {
 		/* invert cs polarity */
-		if (priv->cs_pols & BIT(plat->cs))
-			clr |= BIT(plat->cs);
+		if (priv->cs_pols & BIT(plat->cs[0]))
+			clr |= BIT(plat->cs[0]);
 		else
-			set |= BIT(plat->cs);
+			set |= BIT(plat->cs[0]);
 
 		/* invert dummy cs polarity */
-		if (priv->cs_pols & BIT(!plat->cs))
-			clr |= BIT(!plat->cs);
+		if (priv->cs_pols & BIT(!plat->cs[0]))
+			clr |= BIT(!plat->cs[0]);
 		else
-			set |= BIT(!plat->cs);
+			set |= BIT(!plat->cs[0]);
 	}
 
 	clrsetbits_32(priv->regs + SPI_CTL_REG, clr, set);
@@ -291,7 +291,7 @@ static int bcm63xx_hsspi_xfer_dummy_cs(struct udevice *dev, unsigned int data_by
 
 	if (plat->mode & SPI_3WIRE)
 		val |= SPI_PFL_MODE_3WIRE_MASK;
-	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs));
+	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs[0]));
 
 	/* transfer loop */
 	while (data_bytes > 0) {
@@ -311,9 +311,9 @@ static int bcm63xx_hsspi_xfer_dummy_cs(struct udevice *dev, unsigned int data_by
 
 		/* issue the transfer */
 		val = SPI_CMD_OP_START;
-		val |= (plat->cs << SPI_CMD_PFL_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_PFL_SHIFT) &
 		       SPI_CMD_PFL_MASK;
-		val |= (!plat->cs << SPI_CMD_SLAVE_SHIFT) &
+		val |= (!plat->cs[0] << SPI_CMD_SLAVE_SHIFT) &
 		       SPI_CMD_SLAVE_MASK;
 		writel(val, priv->regs + SPI_CMD_REG);
 
@@ -451,7 +451,7 @@ static int bcm63xx_hsspi_xfer_prepend(struct udevice *dev, unsigned int data_byt
 			}
 		}
 		val |= (priv->prepend_cnt << SPI_PFL_MODE_PREPCNT_SHIFT);
-		writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs));
+		writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs[0]));
 
 		/* set fifo operation */
 		val = opcode | (data_bytes & HSSPI_FIFO_OP_BYTES_MASK);
@@ -460,9 +460,9 @@ static int bcm63xx_hsspi_xfer_prepend(struct udevice *dev, unsigned int data_byt
 
 		/* issue the transfer */
 		val = SPI_CMD_OP_START;
-		val |= (plat->cs << SPI_CMD_PFL_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_PFL_SHIFT) &
 		       SPI_CMD_PFL_MASK;
-		val |= (plat->cs << SPI_CMD_SLAVE_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_SLAVE_SHIFT) &
 		       SPI_CMD_SLAVE_MASK;
 		writel(val, priv->regs + SPI_CMD_REG);
 
@@ -538,16 +538,16 @@ static int bcm63xx_hsspi_child_pre_probe(struct udevice *dev)
 	struct spi_slave *slave = dev_get_parent_priv(dev);
 
 	/* check cs */
-	if (plat->cs >= priv->num_cs) {
-		printf("no cs %u\n", plat->cs);
+	if (plat->cs[0] >= priv->num_cs) {
+		printf("no cs %u\n", plat->cs[0]);
 		return -ENODEV;
 	}
 
 	/* cs polarity */
 	if (plat->mode & SPI_CS_HIGH)
-		priv->cs_pols |= BIT(plat->cs);
+		priv->cs_pols |= BIT(plat->cs[0]);
 	else
-		priv->cs_pols &= ~BIT(plat->cs);
+		priv->cs_pols &= ~BIT(plat->cs[0]);
 
 	/*
 	 * set the max read/write size to make sure each xfer are within the
diff --git a/drivers/spi/bcm63xx_spi.c b/drivers/spi/bcm63xx_spi.c
index 0600d56c69..82bccf09ee 100644
--- a/drivers/spi/bcm63xx_spi.c
+++ b/drivers/spi/bcm63xx_spi.c
@@ -276,7 +276,7 @@ static int bcm63xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
 
 		/* issue the transfer */
 		cmd = SPI_CMD_OP_START;
-		cmd |= (plat->cs << SPI_CMD_SLAVE_SHIFT) & SPI_CMD_SLAVE_MASK;
+		cmd |= (plat->cs[0] << SPI_CMD_SLAVE_SHIFT) & SPI_CMD_SLAVE_MASK;
 		cmd |= (priv->tx_bytes << SPI_CMD_PREPEND_SHIFT);
 		if (plat->mode & SPI_3WIRE)
 			cmd |= SPI_CMD_3WIRE_MASK;
@@ -354,8 +354,8 @@ static int bcm63xx_spi_child_pre_probe(struct udevice *dev)
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
 	/* check cs */
-	if (plat->cs >= priv->num_cs) {
-		printf("no cs %u\n", plat->cs);
+	if (plat->cs[0] >= priv->num_cs) {
+		printf("no cs %u\n", plat->cs[0]);
 		return -ENODEV;
 	}
 
diff --git a/drivers/spi/bcmbca_hsspi.c b/drivers/spi/bcmbca_hsspi.c
index fbe315a7d4..cc3a5185c9 100644
--- a/drivers/spi/bcmbca_hsspi.c
+++ b/drivers/spi/bcmbca_hsspi.c
@@ -156,7 +156,7 @@ static void bcmbca_hsspi_setup_clock(struct bcmbca_hsspi_priv *priv,
 	set = DIV_ROUND_UP(2048, set);
 	set &= SPI_PFL_CLK_FREQ_MASK;
 	set |= SPI_PFL_CLK_RSTLOOP_MASK;
-	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs));
+	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs[0]));
 
 	/* profile signal */
 	set = 0;
@@ -174,16 +174,16 @@ static void bcmbca_hsspi_setup_clock(struct bcmbca_hsspi_priv *priv,
 	if (priv->speed > SPI_MAX_SYNC_CLOCK)
 		set |= SPI_PFL_SIG_ASYNCIN_MASK;
 
-	clrsetbits_32(priv->regs + SPI_PFL_SIG_REG(plat->cs), clr, set);
+	clrsetbits_32(priv->regs + SPI_PFL_SIG_REG(plat->cs[0]), clr, set);
 
 	/* global control */
 	set = 0;
 	clr = 0;
 
-	if (priv->cs_pols & BIT(plat->cs))
-		set |= BIT(plat->cs);
+	if (priv->cs_pols & BIT(plat->cs[0]))
+		set |= BIT(plat->cs[0]);
 	else
-		clr |= BIT(plat->cs);
+		clr |= BIT(plat->cs[0]);
 
 	clrsetbits_32(priv->regs + SPI_CTL_REG, clr, set);
 }
@@ -195,7 +195,7 @@ static void bcmbca_hsspi_activate_cs(struct bcmbca_hsspi_priv *priv,
 
 	/* set the override bit */
 	val = readl(priv->spim_ctrl);
-	val |= BIT(plat->cs + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
+	val |= BIT(plat->cs[0] + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
 	writel(val, priv->spim_ctrl);
 }
 
@@ -206,7 +206,7 @@ static void bcmbca_hsspi_deactivate_cs(struct bcmbca_hsspi_priv *priv,
 
 	/* clear the cs override bit */
 	val = readl(priv->spim_ctrl);
-	val &= ~BIT(plat->cs + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
+	val &= ~BIT(plat->cs[0] + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
 	writel(val, priv->spim_ctrl);
 }
 
@@ -251,7 +251,7 @@ static int bcmbca_hsspi_xfer(struct udevice *dev, unsigned int bitlen,
 
 	if (plat->mode & SPI_3WIRE)
 		val |= SPI_PFL_MODE_3WIRE_MASK;
-	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs));
+	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs[0]));
 
 	/* transfer loop */
 	while (data_bytes > 0) {
@@ -277,9 +277,9 @@ static int bcmbca_hsspi_xfer(struct udevice *dev, unsigned int bitlen,
 
 		/* issue the transfer */
 		val = SPI_CMD_OP_START;
-		val |= (plat->cs << SPI_CMD_PFL_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_PFL_SHIFT) &
 			  SPI_CMD_PFL_MASK;
-		val |= (plat->cs << SPI_CMD_SLAVE_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_SLAVE_SHIFT) &
 			  SPI_CMD_SLAVE_MASK;
 		writel(val, priv->regs + SPI_CMD_REG);
 
@@ -327,22 +327,22 @@ static int bcmbca_hsspi_child_pre_probe(struct udevice *dev)
 	u32 val;
 
 	/* check cs */
-	if (plat->cs >= priv->num_cs) {
-		dev_err(dev, "no cs %u\n", plat->cs);
+	if (plat->cs[0] >= priv->num_cs) {
+		dev_err(dev, "no cs %u\n", plat->cs[0]);
 		return -EINVAL;
 	}
 
 	/* cs polarity */
 	if (plat->mode & SPI_CS_HIGH)
-		priv->cs_pols |= BIT(plat->cs);
+		priv->cs_pols |= BIT(plat->cs[0]);
 	else
-		priv->cs_pols &= ~BIT(plat->cs);
+		priv->cs_pols &= ~BIT(plat->cs[0]);
 
 	/* set the polarity to spim cs register */
 	val = readl(priv->spim_ctrl);
-	val &= ~BIT(plat->cs + SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
-	if (priv->cs_pols & BIT(plat->cs))
-		val |= BIT(plat->cs + SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
+	val &= ~BIT(plat->cs[0] + SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
+	if (priv->cs_pols & BIT(plat->cs[0]))
+		val |= BIT(plat->cs[0] + SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
 	writel(val, priv->spim_ctrl);
 
 	return 0;
diff --git a/drivers/spi/cf_spi.c b/drivers/spi/cf_spi.c
index 1a841b5dce..9df1d690c0 100644
--- a/drivers/spi/cf_spi.c
+++ b/drivers/spi/cf_spi.c
@@ -124,7 +124,7 @@ static int coldfire_spi_claim_bus(struct udevice *dev)
 	/* Clear FIFO and resume transfer */
 	clrbits_be32(&dspi->mcr, DSPI_MCR_CTXF | DSPI_MCR_CRXF);
 
-	dspi_chip_select(slave_plat->cs);
+	dspi_chip_select(slave_plat->cs[0]);
 
 	return 0;
 }
@@ -140,7 +140,7 @@ static int coldfire_spi_release_bus(struct udevice *dev)
 	/* Clear FIFO */
 	clrbits_be32(&dspi->mcr, DSPI_MCR_CTXF | DSPI_MCR_CRXF);
 
-	dspi_chip_unselect(slave_plat->cs);
+	dspi_chip_unselect(slave_plat->cs[0]);
 
 	return 0;
 }
@@ -169,7 +169,7 @@ static int coldfire_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	if ((flags & SPI_XFER_BEGIN) == SPI_XFER_BEGIN)
 		ctrl |= DSPI_TFR_CONT;
 
-	ctrl = setup_ctrl(ctrl, slave_plat->cs);
+	ctrl = setup_ctrl(ctrl, slave_plat->cs[0]);
 
 	if (len > 1) {
 		int tmp_len = len - 1;
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 25f5e9fdeb..2f79ad0ae7 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -339,13 +339,13 @@ static int davinci_spi_claim_bus(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct davinci_spi_slave *ds = dev_get_priv(bus);
 
-	if (slave_plat->cs >= ds->num_cs) {
+	if (slave_plat->cs[0] >= ds->num_cs) {
 		printf("Invalid SPI chipselect\n");
 		return -EINVAL;
 	}
 	ds->half_duplex = slave_plat->mode & SPI_PREAMBLE;
 
-	return __davinci_spi_claim_bus(ds, slave_plat->cs);
+	return __davinci_spi_claim_bus(ds, slave_plat->cs[0]);
 }
 
 static int davinci_spi_release_bus(struct udevice *dev)
@@ -368,7 +368,7 @@ static int davinci_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		printf("Invalid SPI chipselect\n");
 		return -EINVAL;
 	}
-	ds->cur_cs = slave->cs;
+	ds->cur_cs = slave->cs[0];
 
 	return __davinci_spi_xfer(ds, bitlen, dout, din, flags);
 }
diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index f8ec268812..83d56ce9ba 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -456,9 +456,9 @@ static int fsl_dspi_child_pre_probe(struct udevice *dev)
 	unsigned char pcssck = 0, cssck = 0;
 	unsigned char pasc = 0, asc = 0;
 
-	if (slave_plat->cs >= priv->num_chipselect) {
+	if (slave_plat->cs[0] >= priv->num_chipselect) {
 		debug("DSPI invalid chipselect number %d(max %d)!\n",
-		      slave_plat->cs, priv->num_chipselect - 1);
+		      slave_plat->cs[0], priv->num_chipselect - 1);
 		return -EINVAL;
 	}
 
@@ -473,12 +473,12 @@ static int fsl_dspi_child_pre_probe(struct udevice *dev)
 	/* Set After SCK delay scale values */
 	ns_delay_scale(&pasc, &asc, sck_cs_delay, priv->bus_clk);
 
-	priv->ctar_val[slave_plat->cs] = DSPI_CTAR_DEFAULT_VALUE |
+	priv->ctar_val[slave_plat->cs[0]] = DSPI_CTAR_DEFAULT_VALUE |
 					 DSPI_CTAR_PCSSCK(pcssck) |
 					 DSPI_CTAR_PASC(pasc);
 
 	debug("DSPI pre_probe slave device on CS %u, max_hz %u, mode 0x%x.\n",
-	      slave_plat->cs, slave_plat->max_hz, slave_plat->mode);
+	      slave_plat->cs[0], slave_plat->max_hz, slave_plat->mode);
 
 	return 0;
 }
@@ -531,13 +531,13 @@ static int fsl_dspi_claim_bus(struct udevice *dev)
 	priv = dev_get_priv(bus);
 
 	/* processor special preparation work */
-	cpu_dspi_claim_bus(dev_seq(bus), slave_plat->cs);
+	cpu_dspi_claim_bus(dev_seq(bus), slave_plat->cs[0]);
 
 	/* configure transfer mode */
-	fsl_dspi_cfg_ctar_mode(priv, slave_plat->cs, priv->mode);
+	fsl_dspi_cfg_ctar_mode(priv, slave_plat->cs[0], priv->mode);
 
 	/* configure active state of CSX */
-	fsl_dspi_cfg_cs_active_state(priv, slave_plat->cs,
+	fsl_dspi_cfg_cs_active_state(priv, slave_plat->cs[0],
 				     priv->mode);
 
 	fsl_dspi_clr_fifo(priv);
@@ -563,7 +563,7 @@ static int fsl_dspi_release_bus(struct udevice *dev)
 	dspi_halt(priv, 1);
 
 	/* processor special release work */
-	cpu_dspi_release_bus(dev_seq(bus), slave_plat->cs);
+	cpu_dspi_release_bus(dev_seq(bus), slave_plat->cs[0]);
 
 	return 0;
 }
@@ -619,7 +619,7 @@ static int fsl_dspi_xfer(struct udevice *dev, unsigned int bitlen,
 	bus = dev->parent;
 	priv = dev_get_priv(bus);
 
-	return dspi_xfer(priv, slave_plat->cs, bitlen, dout, din, flags);
+	return dspi_xfer(priv, slave_plat->cs[0], bitlen, dout, din, flags);
 }
 
 static int fsl_dspi_set_speed(struct udevice *bus, uint speed)
diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
index b1d964d79d..76f219be6c 100644
--- a/drivers/spi/fsl_espi.c
+++ b/drivers/spi/fsl_espi.c
@@ -513,8 +513,8 @@ static int fsl_espi_child_pre_probe(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct fsl_spi_slave *fsl = dev_get_priv(bus);
 
-	debug("%s cs %u\n", __func__, slave_plat->cs);
-	fsl->cs = slave_plat->cs;
+	debug("%s cs %u\n", __func__, slave_plat->cs[0]);
+	fsl->cs = slave_plat->cs[0];
 
 	return 0;
 }
diff --git a/drivers/spi/fsl_qspi.c b/drivers/spi/fsl_qspi.c
index 3f97730bad..207caa21c3 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -511,10 +511,10 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_slave *slave)
 	struct dm_spi_slave_plat *plat =
 		dev_get_parent_plat(slave->dev);
 
-	if (q->selected == plat->cs)
+	if (q->selected == plat->cs[0])
 		return;
 
-	q->selected = plat->cs;
+	q->selected = plat->cs[0];
 	fsl_qspi_invalidate(q);
 }
 
diff --git a/drivers/spi/gxp_spi.c b/drivers/spi/gxp_spi.c
index 70d76ac66a..3ee369c5a0 100644
--- a/drivers/spi/gxp_spi.c
+++ b/drivers/spi/gxp_spi.c
@@ -87,7 +87,7 @@ static int gxp_spi_xfer(struct udevice *dev, unsigned int bitlen, const void *do
 		value = readl(priv->base + OFFSET_SPIMCFG);
 		value &= ~(1 << 24);
 		/* set chipselect */
-		value |= (slave_plat->cs << 24);
+		value |= (slave_plat->cs[0] << 24);
 
 		/* addr reg and addr size */
 		if (len >= 4) {
diff --git a/drivers/spi/mpc8xx_spi.c b/drivers/spi/mpc8xx_spi.c
index 5c8d760935..58d8f46e7a 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -134,7 +134,7 @@ static void mpc8xx_spi_cs_activate(struct udevice *dev)
 	struct mpc8xx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *platdata = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[platdata->cs], 1);
+	dm_gpio_set_value(&priv->gpios[platdata->cs[0]], 1);
 }
 
 static void mpc8xx_spi_cs_deactivate(struct udevice *dev)
@@ -142,7 +142,7 @@ static void mpc8xx_spi_cs_deactivate(struct udevice *dev)
 	struct mpc8xx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *platdata = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[platdata->cs], 0);
+	dm_gpio_set_value(&priv->gpios[platdata->cs[0]], 0);
 }
 
 static int mpc8xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
diff --git a/drivers/spi/mpc8xxx_spi.c b/drivers/spi/mpc8xxx_spi.c
index 7d15390c56..d219bcbc4e 100644
--- a/drivers/spi/mpc8xxx_spi.c
+++ b/drivers/spi/mpc8xxx_spi.c
@@ -114,7 +114,7 @@ static void mpc8xxx_spi_cs_activate(struct udevice *dev)
 	struct mpc8xxx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[plat->cs], 1);
+	dm_gpio_set_value(&priv->gpios[plat->cs[0]], 1);
 }
 
 static void mpc8xxx_spi_cs_deactivate(struct udevice *dev)
@@ -122,7 +122,7 @@ static void mpc8xxx_spi_cs_deactivate(struct udevice *dev)
 	struct mpc8xxx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[plat->cs], 0);
+	dm_gpio_set_value(&priv->gpios[plat->cs[0]], 0);
 }
 
 static int mpc8xxx_spi_xfer(struct udevice *dev, uint bitlen,
@@ -138,10 +138,10 @@ static int mpc8xxx_spi_xfer(struct udevice *dev, uint bitlen,
 	ulong type = dev_get_driver_data(bus);
 
 	debug("%s: slave %s:%u dout %08X din %08X bitlen %u\n", __func__,
-	      bus->name, plat->cs, (uint)dout, (uint)din, bitlen);
-	if (plat->cs >= priv->cs_count) {
+	      bus->name, plat->cs[0], (uint)dout, (uint)din, bitlen);
+	if (plat->cs[0] >= priv->cs_count) {
 		dev_err(dev, "chip select index %d too large (cs_count=%d)\n",
-			plat->cs, priv->cs_count);
+			plat->cs[0], priv->cs_count);
 		return -EINVAL;
 	}
 	if (bitlen % 8) {
diff --git a/drivers/spi/mscc_bb_spi.c b/drivers/spi/mscc_bb_spi.c
index 95bea0da1b..b0150a60eb 100644
--- a/drivers/spi/mscc_bb_spi.c
+++ b/drivers/spi/mscc_bb_spi.c
@@ -124,11 +124,11 @@ int mscc_bb_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	u8		*rxd = din;
 
 	debug("spi_xfer: slave %s:%s cs%d mode %d, dout %p din %p bitlen %u\n",
-	      dev->parent->name, dev->name, plat->cs,  plat->mode, dout,
+	      dev->parent->name, dev->name, plat->cs[0],  plat->mode, dout,
 	      din, bitlen);
 
 	if (flags & SPI_XFER_BEGIN)
-		mscc_bb_spi_cs_activate(priv, plat->mode, plat->cs);
+		mscc_bb_spi_cs_activate(priv, plat->mode, plat->cs[0]);
 
 	count = bitlen / 8;
 	for (i = 0; i < count; i++) {
diff --git a/drivers/spi/mxc_spi.c b/drivers/spi/mxc_spi.c
index 33360a1832..8baae075f8 100644
--- a/drivers/spi/mxc_spi.c
+++ b/drivers/spi/mxc_spi.c
@@ -135,7 +135,7 @@ static void mxc_spi_cs_activate(struct mxc_spi_slave *mxcs)
 	struct udevice *dev = mxcs->dev;
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (!dm_gpio_is_valid(&mxcs->cs_gpios[cs]))
 		return;
@@ -153,7 +153,7 @@ static void mxc_spi_cs_deactivate(struct mxc_spi_slave *mxcs)
 	struct udevice *dev = mxcs->dev;
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (!dm_gpio_is_valid(&mxcs->cs_gpios[cs]))
 		return;
@@ -633,7 +633,7 @@ static int mxc_spi_claim_bus(struct udevice *dev)
 
 	mxcs->dev = dev;
 
-	return mxc_spi_claim_bus_internal(mxcs, slave_plat->cs);
+	return mxc_spi_claim_bus_internal(mxcs, slave_plat->cs[0]);
 }
 
 static int mxc_spi_release_bus(struct udevice *dev)
diff --git a/drivers/spi/npcm_fiu_spi.c b/drivers/spi/npcm_fiu_spi.c
index 73c506442a..7b8271c8bb 100644
--- a/drivers/spi/npcm_fiu_spi.c
+++ b/drivers/spi/npcm_fiu_spi.c
@@ -203,7 +203,7 @@ static int npcm_fiu_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	int len;
 
 	if (flags & SPI_XFER_BEGIN)
-		activate_cs(regs, slave_plat->cs);
+		activate_cs(regs, slave_plat->cs[0]);
 
 	while (bytes) {
 		len = (bytes > CHUNK_SIZE) ? CHUNK_SIZE : bytes;
@@ -222,7 +222,7 @@ static int npcm_fiu_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (flags & SPI_XFER_END)
-		deactivate_cs(regs, slave_plat->cs);
+		deactivate_cs(regs, slave_plat->cs[0]);
 
 	return ret;
 }
@@ -325,9 +325,9 @@ static int npcm_fiu_exec_op(struct spi_slave *slave,
 	bytes = op->data.nbytes;
 	addr = (u32)op->addr.val;
 	if (!bytes) {
-		activate_cs(regs, slave_plat->cs);
+		activate_cs(regs, slave_plat->cs[0]);
 		ret = npcm_fiu_uma_operation(priv, op, addr, NULL, NULL, 0, false);
-		deactivate_cs(regs, slave_plat->cs);
+		deactivate_cs(regs, slave_plat->cs[0]);
 		return ret;
 	}
 
@@ -339,9 +339,9 @@ static int npcm_fiu_exec_op(struct spi_slave *slave,
 	 * Use HW-control CS for read to avoid clock and timing issues.
 	 */
 	if (op->data.dir == SPI_MEM_DATA_OUT)
-		activate_cs(regs, slave_plat->cs);
+		activate_cs(regs, slave_plat->cs[0]);
 	else
-		writel(FIELD_PREP(UMA_CTS_DEV_NUM_MASK, slave_plat->cs) | UMA_CTS_SW_CS,
+		writel(FIELD_PREP(UMA_CTS_DEV_NUM_MASK, slave_plat->cs[0]) | UMA_CTS_SW_CS,
 		       &regs->uma_cts);
 	while (bytes) {
 		len = (bytes > CHUNK_SIZE) ? CHUNK_SIZE : bytes;
@@ -361,7 +361,7 @@ static int npcm_fiu_exec_op(struct spi_slave *slave,
 			rx += len;
 	}
 	if (op->data.dir == SPI_MEM_DATA_OUT)
-		deactivate_cs(regs, slave_plat->cs);
+		deactivate_cs(regs, slave_plat->cs[0]);
 
 	return 0;
 }
diff --git a/drivers/spi/nxp_fspi.c b/drivers/spi/nxp_fspi.c
index 5db27f9ae2..b8f8040614 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -963,7 +963,7 @@ static int nxp_fspi_claim_bus(struct udevice *dev)
 	bus = dev->parent;
 	f = dev_get_priv(bus);
 
-	nxp_fspi_select_mem(f, slave_plat->cs);
+	nxp_fspi_select_mem(f, slave_plat->cs[0]);
 
 	return 0;
 }
diff --git a/drivers/spi/octeon_spi.c b/drivers/spi/octeon_spi.c
index 4bc38beaa6..0e6e0f7dbe 100644
--- a/drivers/spi/octeon_spi.c
+++ b/drivers/spi/octeon_spi.c
@@ -93,7 +93,7 @@ static u64 octeon_spi_set_mpicfg(struct udevice *dev)
 	if (max_speed > OCTEON_SPI_MAX_CLOCK_HZ)
 		max_speed = OCTEON_SPI_MAX_CLOCK_HZ;
 
-	debug("\n slave params %d %d %d\n", slave->cs,
+	debug("\n slave params %d %d %d\n", slave->cs[0],
 	      slave->max_hz, slave->mode);
 	cpha = !!(slave->mode & SPI_CPHA);
 	cpol = !!(slave->mode & SPI_CPOL);
diff --git a/drivers/spi/omap3_spi.c b/drivers/spi/omap3_spi.c
index 5cce6baa62..92ebd9ea79 100644
--- a/drivers/spi/omap3_spi.c
+++ b/drivers/spi/omap3_spi.c
@@ -393,7 +393,7 @@ static int omap3_spi_claim_bus(struct udevice *dev)
 	struct omap3_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	priv->cs = slave_plat->cs;
+	priv->cs = slave_plat->cs[0];
 	if (!priv->freq)
 		priv->freq = slave_plat->max_hz;
 
@@ -422,7 +422,7 @@ static int omap3_spi_set_wordlen(struct udevice *dev, unsigned int wordlen)
 	struct omap3_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	priv->cs = slave_plat->cs;
+	priv->cs = slave_plat->cs[0];
 	priv->wordlen = wordlen;
 	_omap3_spi_set_wordlen(priv);
 
diff --git a/drivers/spi/pic32_spi.c b/drivers/spi/pic32_spi.c
index 45f07f083d..aed18f46e3 100644
--- a/drivers/spi/pic32_spi.c
+++ b/drivers/spi/pic32_spi.c
@@ -248,7 +248,7 @@ static int pic32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 	slave_plat = dev_get_parent_plat(slave);
 
 	debug("spi_xfer: bus:%i cs:%i flags:%lx\n",
-	      dev_seq(bus), slave_plat->cs, flags);
+	      dev_seq(bus), slave_plat->cs[0], flags);
 	debug("msg tx %p, rx %p submitted of %d byte(s)\n",
 	      tx_buf, rx_buf, len);
 
diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index 7de943356a..bedc63b66d 100644
--- a/drivers/spi/rk_spi.c
+++ b/drivers/spi/rk_spi.c
@@ -445,7 +445,7 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
 
 	/* Assert CS before transfer */
 	if (flags & SPI_XFER_BEGIN)
-		spi_cs_activate(dev, slave_plat->cs);
+		spi_cs_activate(dev, slave_plat->cs[0]);
 
 	/*
 	 * To ensure fast loading of firmware images (e.g. full U-Boot
@@ -498,7 +498,7 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
 
 	/* Deassert CS after transfer */
 	if (flags & SPI_XFER_END)
-		spi_cs_deactivate(dev, slave_plat->cs);
+		spi_cs_deactivate(dev, slave_plat->cs[0]);
 
 	rkspi_enable_chip(regs, false);
 
diff --git a/drivers/spi/rockchip_sfc.c b/drivers/spi/rockchip_sfc.c
index 596c22aa01..71e9b707e8 100644
--- a/drivers/spi/rockchip_sfc.c
+++ b/drivers/spi/rockchip_sfc.c
@@ -409,7 +409,7 @@ static int rockchip_sfc_xfer_setup(struct rockchip_sfc *sfc,
 
 	/* set the Controller */
 	ctrl |= SFC_CTRL_PHASE_SEL_NEGETIVE;
-	cmd |= plat->cs << SFC_CMD_CS_SHIFT;
+	cmd |= plat->cs[0] << SFC_CMD_CS_SHIFT;
 
 	dev_dbg(sfc->dev, "sfc addr.nbytes=%x(x%d) dummy.nbytes=%x(x%d)\n",
 		op->addr.nbytes, op->addr.buswidth,
diff --git a/drivers/spi/spi-aspeed-smc.c b/drivers/spi/spi-aspeed-smc.c
index 3962031021..56c8a67da8 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -193,7 +193,7 @@ static u32 ast2400_get_clk_setting(struct udevice *dev, uint max_hz)
 
 	if (found) {
 		hclk_div = hclk_masks[i] << 8;
-		priv->flashes[slave_plat->cs].max_freq = hclk_clk / (i + 1);
+		priv->flashes[slave_plat->cs[0]].max_freq = hclk_clk / (i + 1);
 	}
 
 	dev_dbg(dev, "found: %s, hclk: %d, max_clk: %d\n", found ? "yes" : "no",
@@ -201,7 +201,7 @@ static u32 ast2400_get_clk_setting(struct udevice *dev, uint max_hz)
 
 	if (found) {
 		dev_dbg(dev, "h_div: %d (mask %x), speed: %d\n",
-			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs].max_freq);
+			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs[0]].max_freq);
 	}
 
 	return hclk_div;
@@ -312,7 +312,7 @@ static u32 ast2500_get_clk_setting(struct udevice *dev, uint max_hz)
 	for (i = 0; i < ARRAY_SIZE(hclk_masks); i++) {
 		if (hclk_clk / (i + 1) <= max_hz) {
 			found = true;
-			priv->flashes[slave_plat->cs].max_freq =
+			priv->flashes[slave_plat->cs[0]].max_freq =
 							hclk_clk / (i + 1);
 			break;
 		}
@@ -326,7 +326,7 @@ static u32 ast2500_get_clk_setting(struct udevice *dev, uint max_hz)
 	for (i = 0; i < ARRAY_SIZE(hclk_masks); i++) {
 		if (hclk_clk / ((i + 1) * 4) <= max_hz) {
 			found = true;
-			priv->flashes[slave_plat->cs].max_freq =
+			priv->flashes[slave_plat->cs[0]].max_freq =
 						hclk_clk / ((i + 1) * 4);
 			break;
 		}
@@ -341,7 +341,7 @@ end:
 
 	if (found) {
 		dev_dbg(dev, "h_div: %d (mask %x), speed: %d\n",
-			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs].max_freq);
+			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs[0]].max_freq);
 	}
 
 	return hclk_div;
@@ -457,7 +457,7 @@ static u32 ast2600_get_clk_setting(struct udevice *dev, uint max_hz)
 
 		if (found) {
 			hclk_div = ((j << 24) | hclk_masks[i] << 8);
-			priv->flashes[slave_plat->cs].max_freq =
+			priv->flashes[slave_plat->cs[0]].max_freq =
 						hclk_clk / (i + 1 + j * 16);
 			break;
 		}
@@ -468,7 +468,7 @@ static u32 ast2600_get_clk_setting(struct udevice *dev, uint max_hz)
 
 	if (found) {
 		dev_dbg(dev, "base_clk: %d, h_div: %d (mask %x), speed: %d\n",
-			j, i + 1, hclk_masks[i], priv->flashes[slave_plat->cs].max_freq);
+			j, i + 1, hclk_masks[i], priv->flashes[slave_plat->cs[0]].max_freq);
 	}
 
 	return hclk_div;
@@ -589,7 +589,7 @@ static int aspeed_spi_exec_op_user_mode(struct spi_slave *slave,
 	struct udevice *bus = dev->parent;
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(slave->dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	u32 ce_ctrl_reg = (u32)&priv->regs->ce_ctrl[cs];
 	u32 ce_ctrl_val;
 	struct aspeed_spi_flash *flash = &priv->flashes[cs];
@@ -669,7 +669,7 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	const struct aspeed_spi_info *info = priv->info;
 	struct spi_mem_op op_tmpl = desc->info.op_tmpl;
 	u32 i;
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	u32 cmd_io_conf;
 	u32 ce_ctrl_reg;
 
@@ -726,7 +726,7 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	struct udevice *dev = desc->slave->dev;
 	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	int ret;
 
 	dev_dbg(dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
@@ -751,7 +751,7 @@ static struct aspeed_spi_flash *aspeed_spi_get_flash(struct udevice *dev)
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (cs >= plat->max_cs) {
 		dev_err(dev, "invalid CS %u\n", cs);
@@ -1070,10 +1070,10 @@ static int aspeed_spi_claim_bus(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
-	struct aspeed_spi_flash *flash = &priv->flashes[slave_plat->cs];
+	struct aspeed_spi_flash *flash = &priv->flashes[slave_plat->cs[0]];
 	u32 clk_setting;
 
-	dev_dbg(bus, "%s: claim bus CS%u\n", bus->name, slave_plat->cs);
+	dev_dbg(bus, "%s: claim bus CS%u\n", bus->name, slave_plat->cs[0]);
 
 	if (flash->max_freq == 0) {
 		clk_setting = priv->info->get_clk_setting(dev, slave_plat->max_hz);
@@ -1091,7 +1091,7 @@ static int aspeed_spi_release_bus(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	dev_dbg(bus, "%s: release bus CS%u\n", bus->name, slave_plat->cs);
+	dev_dbg(bus, "%s: release bus CS%u\n", bus->name, slave_plat->cs[0]);
 
 	if (!aspeed_spi_get_flash(dev))
 		return -ENODEV;
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index f663b9dcbb..854f9dacfe 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -367,8 +367,8 @@ static int mxic_spi_mem_exec_op(struct spi_slave *slave,
 		nio = 2;
 
 	writel(HC_CFG_NIO(nio) |
-	       HC_CFG_TYPE(slave_plat->cs, HC_CFG_TYPE_SPI_NOR) |
-	       HC_CFG_SLV_ACT(slave_plat->cs) | HC_CFG_IDLE_SIO_LVL(1) |
+	       HC_CFG_TYPE(slave_plat->cs[0], HC_CFG_TYPE_SPI_NOR) |
+	       HC_CFG_SLV_ACT(slave_plat->cs[0]) | HC_CFG_IDLE_SIO_LVL(1) |
 	       HC_CFG_MAN_CS_EN,
 	       priv->regs + HC_CFG);
 	writel(HC_EN_BIT, priv->regs + HC_EN);
@@ -397,7 +397,7 @@ static int mxic_spi_mem_exec_op(struct spi_slave *slave,
 			ss_ctrl |= OP_READ;
 	}
 
-	writel(ss_ctrl, priv->regs + SS_CTRL(slave_plat->cs));
+	writel(ss_ctrl, priv->regs + SS_CTRL(slave_plat->cs[0]));
 
 	writel(readl(priv->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
 	       priv->regs + HC_CFG);
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 572cef1694..da28a4e7f8 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -719,7 +719,7 @@ static int qup_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		if (ret != 0)
 			return ret;
 
-		ret = qup_spi_set_cs(bus, slave_plat->cs, false);
+		ret = qup_spi_set_cs(bus, slave_plat->cs[0], false);
 		if (ret != 0)
 			return ret;
 	}
@@ -737,7 +737,7 @@ static int qup_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (flags & SPI_XFER_END) {
-		ret = qup_spi_set_cs(bus, slave_plat->cs, true);
+		ret = qup_spi_set_cs(bus, slave_plat->cs[0], true);
 		if (ret != 0)
 			return ret;
 	}
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index ea372a05f8..43904d74a2 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -109,13 +109,13 @@ static void sifive_spi_prep_device(struct sifive_spi *spi,
 {
 	/* Update the chip select polarity */
 	if (slave_plat->mode & SPI_CS_HIGH)
-		spi->cs_inactive &= ~BIT(slave_plat->cs);
+		spi->cs_inactive &= ~BIT(slave_plat->cs[0]);
 	else
-		spi->cs_inactive |= BIT(slave_plat->cs);
+		spi->cs_inactive |= BIT(slave_plat->cs[0]);
 	writel(spi->cs_inactive, spi->regs + SIFIVE_SPI_REG_CSDEF);
 
 	/* Select the correct device */
-	writel(slave_plat->cs, spi->regs + SIFIVE_SPI_REG_CSID);
+	writel(slave_plat->cs[0], spi->regs + SIFIVE_SPI_REG_CSID);
 }
 
 static int sifive_spi_set_cs(struct sifive_spi *spi,
diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index e3633a5260..36f180451e 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -498,7 +498,7 @@ static int f_ospi_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 	int err = 0;
 
 	slave_plat = dev_get_parent_plat(slave->dev);
-	ospi->chip_select = slave_plat->cs;
+	ospi->chip_select = slave_plat->cs[0];
 
 	switch (op->data.dir) {
 	case SPI_MEM_DATA_IN:
diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index c56d82d998..4a1ed71766 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -338,7 +338,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (flags & SPI_XFER_BEGIN)
-		sun4i_spi_set_cs(bus, slave_plat->cs, true);
+		sun4i_spi_set_cs(bus, slave_plat->cs[0], true);
 
 	/* Reset FIFOs */
 	setbits_le32(SPI_REG(priv, SPI_FCR), SPI_BIT(priv, SPI_FCR_RF_RST) |
@@ -369,7 +369,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 					false, SUN4I_SPI_TIMEOUT_MS, false);
 		if (ret < 0) {
 			printf("ERROR: sun4i_spi: Timeout transferring data\n");
-			sun4i_spi_set_cs(bus, slave_plat->cs, false);
+			sun4i_spi_set_cs(bus, slave_plat->cs[0], false);
 			return ret;
 		}
 
@@ -380,7 +380,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (flags & SPI_XFER_END)
-		sun4i_spi_set_cs(bus, slave_plat->cs, false);
+		sun4i_spi_set_cs(bus, slave_plat->cs[0], false);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index 553f9687e3..5dea074fed 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -194,12 +194,12 @@ static void synquacer_spi_config(struct udevice *dev, void *rx, const void *tx)
 	/* if nothing to do */
 	if (slave_plat->mode == priv->mode &&
 	    rwflag == priv->rwflag &&
-	    slave_plat->cs == priv->cs &&
+	    slave_plat->cs[0] == priv->cs &&
 	    slave_plat->max_hz == priv->speed)
 		return;
 
 	priv->rwflag = rwflag;
-	priv->cs = slave_plat->cs;
+	priv->cs = slave_plat->cs[0];
 	priv->mode = slave_plat->mode;
 	priv->speed = slave_plat->max_hz;
 
diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index f4795e6867..33320a545b 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -225,7 +225,7 @@ int spi_chip_select(struct udevice *dev)
 {
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
-	return plat ? plat->cs : -ENOENT;
+	return plat ? plat->cs[0] : -ENOENT;
 }
 
 int spi_find_chip_select(struct udevice *bus, int cs, struct udevice **devp)
@@ -262,8 +262,8 @@ int spi_find_chip_select(struct udevice *bus, int cs, struct udevice **devp)
 		struct dm_spi_slave_plat *plat;
 
 		plat = dev_get_parent_plat(dev);
-		dev_dbg(bus, "%s: plat=%p, cs=%d\n", __func__, plat, plat->cs);
-		if (plat->cs == cs) {
+		dev_dbg(bus, "%s: plat=%p, cs=%d\n", __func__, plat, plat->cs[0]);
+		if (plat->cs[0] == cs) {
 			*devp = dev;
 			return 0;
 		}
@@ -416,7 +416,7 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 			return ret;
 		}
 		plat = dev_get_parent_plat(dev);
-		plat->cs = cs;
+		plat->cs[0] = cs;
 		if (speed) {
 			plat->max_hz = speed;
 		} else {
@@ -447,6 +447,11 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 	slave = dev_get_parent_priv(dev);
 	bus_data = dev_get_uclass_priv(bus);
 
+	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
+		dev_err(dev, "controller doesn't support multi CS\n");
+		return -EINVAL;
+	}
+
 	/*
 	 * In case the operation speed is not yet established by
 	 * dm_spi_claim_bus() ensure the bus is configured properly.
@@ -509,8 +514,16 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 {
 	int mode = 0;
 	int value;
+	int ret;
+
+	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
+	if (ret == -EOVERFLOW) {
+		dev_read_u32(dev, "reg", &plat->cs[0]);
+	} else if (ret) {
+		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+		return ret;
+	}
 
-	plat->cs = dev_read_u32_default(dev, "reg", -1);
 	plat->max_hz = dev_read_u32_default(dev, "spi-max-frequency",
 					    SPI_DEFAULT_SPEED_HZ);
 	if (dev_read_bool(dev, "spi-cpol"))
diff --git a/drivers/spi/stm32_qspi.c b/drivers/spi/stm32_qspi.c
index 2ffa201a66..fa9b2ca4b6 100644
--- a/drivers/spi/stm32_qspi.c
+++ b/drivers/spi/stm32_qspi.c
@@ -395,7 +395,7 @@ static int stm32_qspi_claim_bus(struct udevice *dev)
 {
 	struct stm32_qspi_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	int slave_cs = slave_plat->cs;
+	int slave_cs = slave_plat->cs[0];
 
 	if (slave_cs >= STM32_QSPI_MAX_CHIP)
 		return -ENODEV;
diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index 82f6ed783f..192ba6cf2b 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -435,7 +435,7 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 
 	slave_plat = dev_get_parent_plat(slave);
 	if (flags & SPI_XFER_BEGIN)
-		stm32_spi_set_cs(bus, slave_plat->cs, false);
+		stm32_spi_set_cs(bus, slave_plat->cs[0], false);
 
 	/* Be sure to have data in fifo before starting data transfer */
 	if (priv->tx_buf)
@@ -486,7 +486,7 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 	stm32_spi_stopxfer(bus);
 
 	if (flags & SPI_XFER_END)
-		stm32_spi_set_cs(bus, slave_plat->cs, true);
+		stm32_spi_set_cs(bus, slave_plat->cs[0], true);
 
 	return xfer_status;
 }
diff --git a/drivers/spi/ti_qspi.c b/drivers/spi/ti_qspi.c
index 99acb10882..dfb74ce877 100644
--- a/drivers/spi/ti_qspi.c
+++ b/drivers/spi/ti_qspi.c
@@ -164,7 +164,7 @@ static int ti_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	uchar *rxp = din;
 	uint status;
 	int timeout;
-	unsigned int cs = slave->cs;
+	unsigned int cs = slave->cs[0];
 
 	bus = dev->parent;
 	priv = dev_get_priv(bus);
@@ -345,7 +345,7 @@ static int ti_qspi_exec_mem_op(struct spi_slave *slave,
 	if (from + op->data.nbytes > priv->mmap_size)
 		return -ENOTSUPP;
 
-	ti_qspi_setup_mmap_read(priv, slave_plat->cs, op->cmd.opcode,
+	ti_qspi_setup_mmap_read(priv, slave_plat->cs[0], op->cmd.opcode,
 				op->data.buswidth, op->addr.nbytes,
 				op->dummy.nbytes);
 
@@ -364,7 +364,7 @@ static int ti_qspi_claim_bus(struct udevice *dev)
 	bus = dev->parent;
 	priv = dev_get_priv(bus);
 
-	if (slave_plat->cs > priv->num_cs) {
+	if (slave_plat->cs[0] > priv->num_cs) {
 		debug("invalid qspi chip select\n");
 		return -EINVAL;
 	}
@@ -372,13 +372,13 @@ static int ti_qspi_claim_bus(struct udevice *dev)
 	writel(MM_SWITCH, &priv->base->memswitch);
 	if (priv->ctrl_mod_mmap)
 		ti_qspi_ctrl_mode_mmap(priv->ctrl_mod_mmap,
-				       slave_plat->cs, true);
+				       slave_plat->cs[0], true);
 
 	writel(priv->dc, &priv->base->dc);
 	writel(0, &priv->base->cmd);
 	writel(0, &priv->base->data);
 
-	priv->dc <<= slave_plat->cs * 8;
+	priv->dc <<= slave_plat->cs[0] * 8;
 	writel(priv->dc, &priv->base->dc);
 
 	return 0;
@@ -396,12 +396,12 @@ static int ti_qspi_release_bus(struct udevice *dev)
 	writel(~MM_SWITCH, &priv->base->memswitch);
 	if (priv->ctrl_mod_mmap)
 		ti_qspi_ctrl_mode_mmap(priv->ctrl_mod_mmap,
-				       slave_plat->cs, false);
+				       slave_plat->cs[0], false);
 
 	writel(0, &priv->base->dc);
 	writel(0, &priv->base->cmd);
 	writel(0, &priv->base->data);
-	writel(0, TI_QSPI_SETUP_REG(priv, slave_plat->cs));
+	writel(0, TI_QSPI_SETUP_REG(priv, slave_plat->cs[0]));
 
 	return 0;
 }
diff --git a/drivers/spi/xilinx_spi.c b/drivers/spi/xilinx_spi.c
index b58a3f632a..7c4a9b79bb 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -270,7 +270,7 @@ static void xilinx_spi_startup_block(struct spi_slave *spi)
 	 * Perform a dummy read as a work around for
 	 * the startup block issue.
 	 */
-	spi_cs_activate(spi->dev, slave_plat->cs);
+	spi_cs_activate(spi->dev, slave_plat->cs[0]);
 	txp = 0x9f;
 	start_transfer(spi, (void *)&txp, NULL, 1);
 
@@ -298,7 +298,7 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 		startup++;
 	}
 
-	spi_cs_activate(spi->dev, slave_plat->cs);
+	spi_cs_activate(spi->dev, slave_plat->cs[0]);
 
 	if (op->cmd.opcode) {
 		ret = start_transfer(spi, (void *)&op->cmd.opcode, NULL, 1);
diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index cb52c0f307..bc82acd0b6 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -586,13 +586,13 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	struct zynq_qspi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	priv->cs = slave_plat->cs;
+	priv->cs = slave_plat->cs[0];
 	priv->tx_buf = dout;
 	priv->rx_buf = din;
 	priv->len = bitlen / 8;
 
-	debug("zynq_qspi_xfer: bus:%i cs:%i bitlen:%i len:%i flags:%lx\n",
-	      dev_seq(bus), slave_plat->cs, bitlen, priv->len, flags);
+	debug("%s: bus:%i cs[0]:%i bitlen:%i len:%i flags:%lx\n", __func__,
+	      dev_seq(bus), slave_plat->cs[0], bitlen, priv->len, flags);
 
 	/*
 	 * Festering sore.
diff --git a/drivers/spi/zynq_spi.c b/drivers/spi/zynq_spi.c
index b3e0858eb9..17bb1015fa 100644
--- a/drivers/spi/zynq_spi.c
+++ b/drivers/spi/zynq_spi.c
@@ -242,15 +242,15 @@ static int zynq_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	u8 *rx_buf = din, buf;
 	u32 ts, status;
 
-	debug("spi_xfer: bus:%i cs:%i bitlen:%i len:%i flags:%lx\n",
-	      dev_seq(bus), slave_plat->cs, bitlen, len, flags);
+	debug("spi_xfer: bus:%i cs[0]:%i bitlen:%i len:%i flags:%lx\n",
+	      dev_seq(bus), slave_plat->cs[0], bitlen, len, flags);
 
 	if (bitlen % 8) {
 		debug("spi_xfer: Non byte aligned SPI transfer\n");
 		return -1;
 	}
 
-	priv->cs = slave_plat->cs;
+	priv->cs = slave_plat->cs[0];
 	if (flags & SPI_XFER_BEGIN)
 		spi_cs_activate(dev);
 
diff --git a/include/spi.h b/include/spi.h
index 56b8c26e9d..d591522001 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -81,7 +81,7 @@ struct dm_spi_bus {
  * @mode:	SPI mode to use for this device (see SPI mode flags)
  */
 struct dm_spi_slave_plat {
-	unsigned int cs;
+	unsigned int cs[SPI_CS_CNT_MAX];
 	uint max_hz;
 	uint mode;
 };
@@ -167,6 +167,12 @@ struct spi_slave {
 #define SPI_XFER_ONCE		(SPI_XFER_BEGIN | SPI_XFER_END)
 #define SPI_XFER_U_PAGE		BIT(4)
 #define SPI_XFER_STACKED	BIT(5)
+	/*
+	 * Flag indicating that the spi-controller has multi chip select
+	 * capability and can assert/de-assert more than one chip select
+	 * at once.
+	 */
+	bool multi_cs_cap;
 };
 
 /**
diff --git a/lib/acpi/acpi_device.c b/lib/acpi/acpi_device.c
index 1b838fdbd6..b80a45aefc 100644
--- a/lib/acpi/acpi_device.c
+++ b/lib/acpi/acpi_device.c
@@ -729,7 +729,7 @@ static int acpi_device_set_spi(const struct udevice *dev, struct acpi_spi *spi,
 
 	plat = dev_get_parent_plat(slave->dev);
 	memset(spi, '\0', sizeof(*spi));
-	spi->device_select = plat->cs;
+	spi->device_select = plat->cs[0];
 	spi->device_select_polarity = SPI_POLARITY_LOW;
 	spi->wire_mode = SPI_4_WIRE_MODE;
 	spi->speed = plat->max_hz;
-- 
2.25.1

