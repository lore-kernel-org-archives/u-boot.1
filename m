Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09E2DC001DE
	for <u-boot@archiver.kernel.org>; Fri, 18 Aug 2023 04:22:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C929786CAF;
	Fri, 18 Aug 2023 06:22:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Qtgoetp2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8BB6586CAD; Fri, 18 Aug 2023 06:22:09 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8773F86AB9
 for <u-boot@lists.denx.de>; Fri, 18 Aug 2023 06:22:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=ashok.reddy.soma@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K05P4AsLXJuFvpG9rd+s9AZ/Mz5EuHgsM5LSTzrTuXgUiq1AY79batO407nBfAKSLLGxRlw43y9fQDNKowKvsFSHgRAP4C8Atq0YS28Nxj0m0dkv5YxTOrtxjOT9pHt8+MB6my8SIUPIQ4yJqTgLRGLmgquiduXNsRr1NNhVWPzyY5zOSB7cAdwcB0e/QpEk0C8ssLG4lGMXd3/UKcuw9G247/7RqBh3xacVZ4lYQusJ4Qy6BdktZIYdggrKI07VzeqCM3SbOl1kbMqxefF1lPqH6TIRSUccIes2HrnxWEL6SQOuC0+yQs+rkI4VrFEV+jAqvDQdZq8wT/YxYLClJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gxwrWqnRlx02mqWo2B8l4gtqjduaaZCeSPROMp8C84=;
 b=kN8Boh2732U0cmC3kNaM2RL6tg/IRk0xFuqShoqZWO752fiY/Dfonk+y9QVfvQe+L27BCppci9cqfazYBMthM4EwU3QiGd8REhXP1MNHnyOs9ypFUs/a0gjCJb56URq75vzZGG8Uukoluyj3JwuahEFwrUmVKMOwIjQmHwjzI7AjavRow609UtmoCKLD2xUzCnSbuzW4UQuPddsQ3ME52HwM+fpMCrPcp/7CDZgjRoq2xO+S20YPe3sCVGLs+nh0is3CueECxqvDPZNh9jy6UdS3o9iZoGGGu+edtCjRfFf8xdjGl50R623rE45jVQgPWUn/eRsl9Oypi9megRQizA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gxwrWqnRlx02mqWo2B8l4gtqjduaaZCeSPROMp8C84=;
 b=Qtgoetp28MAWHOxKUOitNfuK+Ubq/VgswuktCMaO/RgmPDbDl564rew/26wRFGvXriv+dvhujs/RrMeL3nnV3Nz2QiuEGkgyRr215uqxllqJH0PAKHjauNAllLz0oGdySciiTa0NNS4DJUKKQ9La3IpdeXU2uCL4Wz4uGJVW6P0=
Received: from MW4PR03CA0232.namprd03.prod.outlook.com (2603:10b6:303:b9::27)
 by DS0PR12MB7581.namprd12.prod.outlook.com (2603:10b6:8:13d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 04:22:03 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:b9:cafe::d5) by MW4PR03CA0232.outlook.office365.com
 (2603:10b6:303:b9::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Fri, 18 Aug 2023 04:22:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 04:22:01 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:22:00 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 17 Aug
 2023 23:22:00 -0500
Received: from xhdashokred41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27 via Frontend
 Transport; Thu, 17 Aug 2023 23:21:58 -0500
From: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
To: <u-boot@lists.denx.de>
CC: <jagan@amarulasolutions.com>, <vigneshr@ti.com>, <michal.simek@amd.com>,
 <sjg@chromium.org>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 5/7] spi: spi-uclass: Read chipselect and restrict capabilities
Date: Thu, 17 Aug 2023 22:21:17 -0600
Message-ID: <20230818042119.25722-6-ashok.reddy.soma@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
References: <20230818042119.25722-1-ashok.reddy.soma@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|DS0PR12MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a330091-b845-4f8d-5b82-08db9fa2abc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FvML8w/Xuq7b92iocV+OQGEW/sag2ADJldiXjPNMOI8LFUDpT7OePqu4q8I2gfKiT7nj+zeEM/4kcR/ljaGh/hFezx7vWhHHZlBZTuQ2q15A0PN3llADXCwLAp6OW1sFEXloUVApUbz3D0qhAm1FRH9MGVTy6M4RzjIP4ADMAGe3Fjs4pJl8dbifZAJ6/q0NZbXpFDTCBVX7LUUUeYGxPPbw4FnBmbYXyMFoUqRzZqHLM3EHcPdynwDO/48x+Doyqdn1WQ8cOB7J1+q73+G2jCTmp4TpdwadGpc0LZHcbYZeshVRKox1H63kwQrejIw/Fm8yUsushrtsCWRsIYtVHBgjYVfmp++2uQUwKfZ6EgRYdWP7aGCLdY6CB2CcfPn8Bc8j5a49kvZNM9kn9Q0Xk4usAfA8zBoAmd+JMrVunNasEr1brF4YmTvB/9g94wXPgpUeBSfnGz4CI5irnRe51Cp6nX1Kij5L0obZMN2lULqR6dgEIO7IwP0gy2C3Ymm2Km5fQ5y23NJq20RA9pHh4p0IYK6XUFx250OnsBicw5gvUU+cHuN4TEk4B4/Xm8sh6ic/jkJepQoOi85WL9UzVzQUOD1PvyMGKbg+EF2fre0d6j0V90GvJY9Uhna3QdcOK5ujswCi0NLrF2wBKCbrQDZ8YFUer0v3o4tK+msHGoBB9zLpq+3P2CLrK7p42sV32DPjmvcgBeLcZtKabbSUsjU4l+CrI26maqJLE1rWzFEtAIag0EIrsoA8DuDWMPtGX7apMBcIJPo7pOHK/h7pDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(103116003)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(2616005)(5660300002)(70586007)(478600001)(70206006)(6666004)(54906003)(316002)(6916009)(26005)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(426003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 04:22:01.6679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a330091-b845-4f8d-5b82-08db9fa2abc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7581
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

Read chipselect properties from DT which are populated using 'reg'
property and save it in plat->cs[] array for later use.

Also read multi chipselect capability which is used for
parallel-memories and return errors if they are passed on using DT but
driver is not capable of handling it.

Signed-off-by: Ashok Reddy Soma <ashok.reddy.soma@amd.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---

 drivers/spi/spi-uclass.c | 21 ++++++++++++++++-----
 drivers/spi/xilinx_spi.c |  4 ++--
 drivers/spi/zynq_qspi.c  |  6 +++---
 drivers/spi/zynq_spi.c   |  6 +++---
 include/spi.h            |  2 +-
 5 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-uclass.c b/drivers/spi/spi-uclass.c
index c929e7c1d0..cdcf16d346 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -257,7 +257,7 @@ int spi_chip_select(struct udevice *dev)
 {
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
-	return plat ? plat->cs : -ENOENT;
+	return plat ? plat->cs[0] : -ENOENT;
 }
 
 int spi_find_chip_select(struct udevice *bus, int cs, struct udevice **devp)
@@ -294,8 +294,8 @@ int spi_find_chip_select(struct udevice *bus, int cs, struct udevice **devp)
 		struct dm_spi_slave_plat *plat;
 
 		plat = dev_get_parent_plat(dev);
-		dev_dbg(bus, "%s: plat=%p, cs=%d\n", __func__, plat, plat->cs);
-		if (plat->cs == cs) {
+		dev_dbg(bus, "%s: plat=%p, cs=%d\n", __func__, plat, plat->cs[0]);
+		if (plat->cs[0] == cs) {
 			*devp = dev;
 			return 0;
 		}
@@ -448,7 +448,7 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 			return ret;
 		}
 		plat = dev_get_parent_plat(dev);
-		plat->cs = cs;
+		plat->cs[0] = cs;
 		if (speed) {
 			plat->max_hz = speed;
 		} else {
@@ -479,6 +479,11 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
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
@@ -541,8 +546,14 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 {
 	int mode = 0;
 	int value;
+	int ret;
+
+	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
+	if (ret && ret != -EOVERFLOW) {
+		dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+		return ret;
+	}
 
-	plat->cs = dev_read_u32_default(dev, "reg", -1);
 	plat->max_hz = dev_read_u32_default(dev, "spi-max-frequency",
 					    SPI_DEFAULT_SPEED_HZ);
 	if (dev_read_bool(dev, "spi-cpol"))
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
index cb52c0f307..069d2a77de 100644
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
+	debug("zynq_qspi_xfer: bus:%i cs[0]:%i bitlen:%i len:%i flags:%lx\n",
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
index 2a3ccaa754..f050227168 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -82,7 +82,7 @@ struct dm_spi_bus {
  * @mode:	SPI mode to use for this device (see SPI mode flags)
  */
 struct dm_spi_slave_plat {
-	unsigned int cs;
+	unsigned int cs[SPI_CS_CNT_MAX];
 	uint max_hz;
 	uint mode;
 };
-- 
2.17.1

