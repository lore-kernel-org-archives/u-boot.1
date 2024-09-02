Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FE6CD342A
	for <u-boot@archiver.kernel.org>; Mon,  2 Sep 2024 10:28:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53DE688A54;
	Mon,  2 Sep 2024 12:27:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="zh71K2Ts";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0047F88A47; Mon,  2 Sep 2024 12:27:36 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8A50388785
 for <u-boot@lists.denx.de>; Mon,  2 Sep 2024 12:27:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vke7wj8KAETZafKyEbAqlIS+mpUJnqNKCbNSMABIwPkp8W8kJ/9ThvJ7B5igL/hNoFJzEoxTtAq9XkzdL+aacZepCY0Qbo4o2dVyGqoRCIOoNTarEQ10ipcELSs5ImTxdZWNEZ3M3k1s5Dyu0tw9A8qYaWx/BYfCRrcf4n1Qj+JhTgdXhNxGIyIA75ki0xia6en1s1UOqFSbGNQEflTwAM1SRS0ri+yphjPoTC0jhuKqzmD5QfuJdWf5mH9+hzukqzIXzoBjNIJDu/guo7uN/AYQxvcE2OeYmhpLLT1XIPRxRe5kP+xoA6KGdfbjdeaj6tc+gllzcbXwqsacTNW/UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TKYbIZWK3rPEvm6iETF7xikqv6g6rsA2kITg9FfbfqA=;
 b=KDr68ksiSHOQBdeNQ0k4N8pom0SqtfnIUTon46eb+V7OmDmI+HJCILUdjBzD9j99Cuz9nCMWb5x0T9JzXdoCQW/2obOXI+gu1KYHI6tRmk5oJdEmqh406c2zNM+HKAb+ZTCNQ16KLoJZ300KWEIpmYIYBiVLMbUFnC2R1UXFdY4XMzAjzX60d7MT0wI9Rqj4XHAfWzRxcWDBU/9uXIbQX8jDiG0c7/MeojQTTEdPqYcLvFmedDWvEIyNmLqy4OJdGL6ljmoYbGPSOEPDLdykf9K+RIkJghK4r9lwsYgnVz3dP4u7giS/O3psaW/7is1CWyuOanz2FCM9b9BFxLYoug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TKYbIZWK3rPEvm6iETF7xikqv6g6rsA2kITg9FfbfqA=;
 b=zh71K2Tse1MCsp/HjmhCPM7ms2BIDICLjQTyanxdKVtq7VhnynHeAT0VggkX09bG651qjjRB8uDb1UHnVXACLkrkgM30ZWURip7FtCti9aaXEkIXgZHG1e6gEq5GfkXtGhBry/TlY6zmyc9f3rnCA9g4h0iMx2xqBoZXTN1kUnU=
Received: from DS7PR03CA0195.namprd03.prod.outlook.com (2603:10b6:5:3b6::20)
 by SA1PR12MB7294.namprd12.prod.outlook.com (2603:10b6:806:2b8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Mon, 2 Sep
 2024 10:27:27 +0000
Received: from DS3PEPF000099D9.namprd04.prod.outlook.com
 (2603:10b6:5:3b6:cafe::53) by DS7PR03CA0195.outlook.office365.com
 (2603:10b6:5:3b6::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Mon, 2 Sep 2024 10:27:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D9.mail.protection.outlook.com (10.167.17.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 2 Sep 2024 10:27:26 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:26 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Sep
 2024 05:27:25 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 2 Sep 2024 05:27:23 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>,
 <trini@konsulko.com>, <git@amd.com>, Ashok Reddy Soma
 <ashok.reddy.soma@amd.com>
Subject: [PATCH v12 4/9] spi: spi-uclass: Read chipselect and restrict
 capabilities
Date: Mon, 2 Sep 2024 15:57:01 +0530
Message-ID: <20240902102706.1107-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
References: <20240902102706.1107-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D9:EE_|SA1PR12MB7294:EE_
X-MS-Office365-Filtering-Correlation-Id: c83a2493-0e09-4a72-ff80-08dccb39d783
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H0LkgCrVjxHnzvgQM6nNIX0uxXH8+dtQzXftJHpCUt4U3JytlDnO61YXXHaN?=
 =?us-ascii?Q?FbyvQ0CwCDPqvz3EenVpP2vPZWe14Wtjm+S2WSLiWaDarp9Zi41ZV1KXs0e2?=
 =?us-ascii?Q?lN8BGavbYezHWytnAOU4OPoZjMJ5jm1uvov2h9LfInfOCrkKl1X/XwluKKBs?=
 =?us-ascii?Q?8QX79pvMPnKweX5h64XqL9E6CKbOJNIIQTi98YGDcnjXCgdwTh8eFlVuLBqP?=
 =?us-ascii?Q?nmxEWjyqKFNbKMscXslcBcHXemzGzjSaUL32tD9BL3ziVesE0TlSY4kZtvRx?=
 =?us-ascii?Q?QpMSfEjgK75K14zx3y+56PO4073VE5ecjqDp6l13Vn61daPGppwfXTycEtNd?=
 =?us-ascii?Q?RfdGxPvMi1Cf74GQdMp6G8/LyTMHgIdJP6eiiKfLu2HP3jH5bDWve+qqehAI?=
 =?us-ascii?Q?REAP51j3M5XSWO771lixPZCQ2eDpvupIa1bJe1fxaEps36oZ88KhxR7dyoVe?=
 =?us-ascii?Q?+KNs2rx/jqQQlz0qtnsMO+XNSj2g7htk+4M2ZEfGBpNtDpsX5LuPDXVTV+Ru?=
 =?us-ascii?Q?0G1riUD4d7i+vgoftAVmzFkevuPt7PSq2hs5OBgfZW8a8taEWLtebl9BQMbo?=
 =?us-ascii?Q?fCwRHcVFP3fFahApbpPJgbpzn+kN/CyzR3uJhi+NAWc68tZLRX75L99nYqKt?=
 =?us-ascii?Q?/ZqthAUjHzQupQdJNxI+vJapO8HAY8KCvr5p+I2DbpC1womVUffrRgneb31s?=
 =?us-ascii?Q?8eHlX4Rn0r9Z5gWC10PIpBy9WI+SkBE+JWvJcy9q1FioFw57D0bK95Paf95w?=
 =?us-ascii?Q?xsCizvmQxv/ptGUKXMlPhtOgWNCiJUjm8oBxQTGij98k2NCYyS58c9Stfyt+?=
 =?us-ascii?Q?Fd9hfq5ITxNRGzvR/nqrlG8f4SPBAz4y0oj/vHE8EZiIbb/ZcCCIku9LY00j?=
 =?us-ascii?Q?MEP4AgsGwEoHwbIGZadTo625XwAdyW0WhHnoW9mNuOLKhyvluxsWOoZ2qg3n?=
 =?us-ascii?Q?P7lsZ7sduVFE8pDvJi40i9vzbiBtp+yrkx4+l/IiE2Uu5uPJUI+4kxsnYqTt?=
 =?us-ascii?Q?Oguwb2Y4L1jrQK9RPnPQuZ0wtPCp9SG7y0jtceLgSdgLw1dWkHgR9hXX8tGR?=
 =?us-ascii?Q?Z1gHbdGkuMLJ5rRjuVj6MDlWA1S8UnsJ8QzC5dykvetYeRYXXEj+zjiGjN76?=
 =?us-ascii?Q?qf/uTNiyjjjN99oEPpq+pdbASvtEDoer4pZNJdtooZB076EH+VlXif1Bya5w?=
 =?us-ascii?Q?LBbuFTqBYbFDTYdwTn+QFvC67kEb7c4+UsUJrG2fUbtgBlJPGDSkqWEvvvsR?=
 =?us-ascii?Q?knKBHUJ2oQdQsTuEA+BRjiOA/1ydDCZ7OSMTiO1tcCmKf1acSWj2jAnqIctc?=
 =?us-ascii?Q?vmoJH4GxsF3CalH8SiB1KdqpscX1yTSbqFRkQLbz3aepMeOvzQVdvKRg0NMm?=
 =?us-ascii?Q?ukAvp9xblRHsEvhlwpM8AHxWZvh0xKVPsBBrzJvcM5LTJq1gzwaoyBvm0LN4?=
 =?us-ascii?Q?O5kzHUKmSh979oT8Hva3zGr6YnFETV8u?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2024 10:27:26.8000 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c83a2493-0e09-4a72-ff80-08dccb39d783
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7294
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
 drivers/mtd/spi/sandbox.c    |  2 +-
 drivers/spi/altera_spi.c     |  4 ++--
 drivers/spi/atcspi200_spi.c  |  2 +-
 drivers/spi/ath79_spi.c      |  2 +-
 drivers/spi/atmel_spi.c      |  6 +++---
 drivers/spi/bcm63xx_hsspi.c  | 42 ++++++++++++++++++------------------
 drivers/spi/bcm63xx_spi.c    |  6 +++---
 drivers/spi/bcmbca_hsspi.c   | 34 ++++++++++++++---------------
 drivers/spi/cf_spi.c         |  6 +++---
 drivers/spi/davinci_spi.c    |  8 +++----
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
 drivers/spi/spi-uclass.c     | 33 +++++++++++++++++++++++-----
 drivers/spi/stm32_qspi.c     |  2 +-
 drivers/spi/stm32_spi.c      |  4 ++--
 drivers/spi/ti_qspi.c        | 14 ++++++------
 drivers/spi/xilinx_spi.c     |  6 +++---
 drivers/spi/zynq_qspi.c      |  6 +++---
 drivers/spi/zynq_spi.c       |  6 +++---
 include/spi.h                |  8 ++++++-
 lib/acpi/acpi_device.c       |  2 +-
 41 files changed, 180 insertions(+), 151 deletions(-)

diff --git a/drivers/mtd/spi/sandbox.c b/drivers/mtd/spi/sandbox.c
index 2d5a16bf6a..e5ebc3479f 100644
--- a/drivers/mtd/spi/sandbox.c
+++ b/drivers/mtd/spi/sandbox.c
@@ -138,7 +138,7 @@ static int sandbox_sf_probe(struct udevice *dev)
 		return ret;
 	}
 	slave_plat = dev_get_parent_plat(dev);
-	cs = slave_plat->cs;
+	cs = slave_plat->cs[0];
 	debug("found at cs %d\n", cs);
 
 	if (!pdata->filename) {
diff --git a/drivers/spi/altera_spi.c b/drivers/spi/altera_spi.c
index 8e227d187b..dafaf1130b 100644
--- a/drivers/spi/altera_spi.c
+++ b/drivers/spi/altera_spi.c
@@ -95,7 +95,7 @@ static int altera_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	uint32_t reg, data, start;
 
 	debug("%s: bus:%i cs:%i bitlen:%i bytes:%i flags:%lx\n", __func__,
-	      dev_seq(bus), slave_plat->cs, bitlen, bytes, flags);
+	      dev_seq(bus), slave_plat->cs[0], bitlen, bytes, flags);
 
 	if (bitlen == 0)
 		goto done;
@@ -110,7 +110,7 @@ static int altera_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		readl(&regs->rxdata);
 
 	if (flags & SPI_XFER_BEGIN)
-		spi_cs_activate(dev, slave_plat->cs);
+		spi_cs_activate(dev, slave_plat->cs[0]);
 
 	while (bytes--) {
 		if (txp)
diff --git a/drivers/spi/atcspi200_spi.c b/drivers/spi/atcspi200_spi.c
index 2178534baf..72b612c656 100644
--- a/drivers/spi/atcspi200_spi.c
+++ b/drivers/spi/atcspi200_spi.c
@@ -319,7 +319,7 @@ static int atcspi200_spi_claim_bus(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct nds_spi_slave *ns = dev_get_priv(bus);
 
-	if (slave_plat->cs >= ns->num_cs) {
+	if (slave_plat->cs[0] >= ns->num_cs) {
 		printf("Invalid SPI chipselect\n");
 		return -EINVAL;
 	}
diff --git a/drivers/spi/ath79_spi.c b/drivers/spi/ath79_spi.c
index fb2d77d7d4..b0ed14f0cf 100644
--- a/drivers/spi/ath79_spi.c
+++ b/drivers/spi/ath79_spi.c
@@ -73,7 +73,7 @@ static int ath79_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	if (restbits)
 		bytes++;
 
-	out = AR71XX_SPI_IOC_CS_ALL & ~(AR71XX_SPI_IOC_CS(slave->cs));
+	out = AR71XX_SPI_IOC_CS_ALL & ~(AR71XX_SPI_IOC_CS(slave->cs[0]));
 	while (bytes > 0) {
 		bytes--;
 		curbyte = 0;
diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 79f0100131..aaf3eddae4 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -125,7 +125,7 @@ static int atmel_spi_claim_bus(struct udevice *dev)
 	struct atmel_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	struct at91_spi *reg_base = bus_plat->regs;
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	u32 freq = priv->freq;
 	u32 scbr, csrx, mode;
 
@@ -174,7 +174,7 @@ static void atmel_spi_cs_activate(struct udevice *dev)
 	struct udevice *bus = dev_get_parent(dev);
 	struct atmel_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (!dm_gpio_is_valid(&priv->cs_gpios[cs]))
 		return;
@@ -189,7 +189,7 @@ static void atmel_spi_cs_deactivate(struct udevice *dev)
 	struct udevice *bus = dev_get_parent(dev);
 	struct atmel_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (!dm_gpio_is_valid(&priv->cs_gpios[cs]))
 		return;
diff --git a/drivers/spi/bcm63xx_hsspi.c b/drivers/spi/bcm63xx_hsspi.c
index 1aa43fd3a2..e9f0b343ab 100644
--- a/drivers/spi/bcm63xx_hsspi.c
+++ b/drivers/spi/bcm63xx_hsspi.c
@@ -174,7 +174,7 @@ static void bcm63xx_hsspi_activate_cs(struct bcm63xx_hsspi_priv *priv,
 	set = DIV_ROUND_UP(2048, set);
 	set &= SPI_PFL_CLK_FREQ_MASK;
 	set |= SPI_PFL_CLK_RSTLOOP_MASK;
-	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs));
+	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs[0]));
 
 	/* profile signal */
 	set = 0;
@@ -192,29 +192,29 @@ static void bcm63xx_hsspi_activate_cs(struct bcm63xx_hsspi_priv *priv,
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
@@ -290,7 +290,7 @@ static int bcm63xx_hsspi_xfer_dummy_cs(struct udevice *dev, unsigned int data_by
 
 	if (plat->mode & SPI_3WIRE)
 		val |= SPI_PFL_MODE_3WIRE_MASK;
-	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs));
+	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs[0]));
 
 	/* transfer loop */
 	while (data_bytes > 0) {
@@ -310,9 +310,9 @@ static int bcm63xx_hsspi_xfer_dummy_cs(struct udevice *dev, unsigned int data_by
 
 		/* issue the transfer */
 		val = SPI_CMD_OP_START;
-		val |= (plat->cs << SPI_CMD_PFL_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_PFL_SHIFT) &
 		       SPI_CMD_PFL_MASK;
-		val |= (!plat->cs << SPI_CMD_SLAVE_SHIFT) &
+		val |= (!plat->cs[0] << SPI_CMD_SLAVE_SHIFT) &
 		       SPI_CMD_SLAVE_MASK;
 		writel(val, priv->regs + SPI_CMD_REG);
 
@@ -450,7 +450,7 @@ static int bcm63xx_hsspi_xfer_prepend(struct udevice *dev, unsigned int data_byt
 			}
 		}
 		val |= (priv->prepend_cnt << SPI_PFL_MODE_PREPCNT_SHIFT);
-		writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs));
+		writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs[0]));
 
 		/* set fifo operation */
 		val = opcode | (data_bytes & HSSPI_FIFO_OP_BYTES_MASK);
@@ -459,9 +459,9 @@ static int bcm63xx_hsspi_xfer_prepend(struct udevice *dev, unsigned int data_byt
 
 		/* issue the transfer */
 		val = SPI_CMD_OP_START;
-		val |= (plat->cs << SPI_CMD_PFL_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_PFL_SHIFT) &
 		       SPI_CMD_PFL_MASK;
-		val |= (plat->cs << SPI_CMD_SLAVE_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_SLAVE_SHIFT) &
 		       SPI_CMD_SLAVE_MASK;
 		writel(val, priv->regs + SPI_CMD_REG);
 
@@ -537,16 +537,16 @@ static int bcm63xx_hsspi_child_pre_probe(struct udevice *dev)
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
index 595b41c8ab..e02ec7e8bd 100644
--- a/drivers/spi/bcm63xx_spi.c
+++ b/drivers/spi/bcm63xx_spi.c
@@ -275,7 +275,7 @@ static int bcm63xx_spi_xfer(struct udevice *dev, unsigned int bitlen,
 
 		/* issue the transfer */
 		cmd = SPI_CMD_OP_START;
-		cmd |= (plat->cs << SPI_CMD_SLAVE_SHIFT) & SPI_CMD_SLAVE_MASK;
+		cmd |= (plat->cs[0] << SPI_CMD_SLAVE_SHIFT) & SPI_CMD_SLAVE_MASK;
 		cmd |= (priv->tx_bytes << SPI_CMD_PREPEND_SHIFT);
 		if (plat->mode & SPI_3WIRE)
 			cmd |= SPI_CMD_3WIRE_MASK;
@@ -353,8 +353,8 @@ static int bcm63xx_spi_child_pre_probe(struct udevice *dev)
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
 	/* check cs */
-	if (plat->cs >= priv->num_cs) {
-		printf("no cs %u\n", plat->cs);
+	if (plat->cs[0] >= priv->num_cs) {
+		printf("no cs %u\n", plat->cs[0]);
 		return -ENODEV;
 	}
 
diff --git a/drivers/spi/bcmbca_hsspi.c b/drivers/spi/bcmbca_hsspi.c
index eff9e1117d..209ca71327 100644
--- a/drivers/spi/bcmbca_hsspi.c
+++ b/drivers/spi/bcmbca_hsspi.c
@@ -155,7 +155,7 @@ static void bcmbca_hsspi_setup_clock(struct bcmbca_hsspi_priv *priv,
 	set = DIV_ROUND_UP(2048, set);
 	set &= SPI_PFL_CLK_FREQ_MASK;
 	set |= SPI_PFL_CLK_RSTLOOP_MASK;
-	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs));
+	writel(set, priv->regs + SPI_PFL_CLK_REG(plat->cs[0]));
 
 	/* profile signal */
 	set = 0;
@@ -173,16 +173,16 @@ static void bcmbca_hsspi_setup_clock(struct bcmbca_hsspi_priv *priv,
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
@@ -194,7 +194,7 @@ static void bcmbca_hsspi_activate_cs(struct bcmbca_hsspi_priv *priv,
 
 	/* set the override bit */
 	val = readl(priv->spim_ctrl);
-	val |= BIT(plat->cs + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
+	val |= BIT(plat->cs[0] + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
 	writel(val, priv->spim_ctrl);
 }
 
@@ -205,7 +205,7 @@ static void bcmbca_hsspi_deactivate_cs(struct bcmbca_hsspi_priv *priv,
 
 	/* clear the cs override bit */
 	val = readl(priv->spim_ctrl);
-	val &= ~BIT(plat->cs + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
+	val &= ~BIT(plat->cs[0] + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
 	writel(val, priv->spim_ctrl);
 }
 
@@ -250,7 +250,7 @@ static int bcmbca_hsspi_xfer(struct udevice *dev, unsigned int bitlen,
 
 	if (plat->mode & SPI_3WIRE)
 		val |= SPI_PFL_MODE_3WIRE_MASK;
-	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs));
+	writel(val, priv->regs + SPI_PFL_MODE_REG(plat->cs[0]));
 
 	/* transfer loop */
 	while (data_bytes > 0) {
@@ -276,9 +276,9 @@ static int bcmbca_hsspi_xfer(struct udevice *dev, unsigned int bitlen,
 
 		/* issue the transfer */
 		val = SPI_CMD_OP_START;
-		val |= (plat->cs << SPI_CMD_PFL_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_PFL_SHIFT) &
 			  SPI_CMD_PFL_MASK;
-		val |= (plat->cs << SPI_CMD_SLAVE_SHIFT) &
+		val |= (plat->cs[0] << SPI_CMD_SLAVE_SHIFT) &
 			  SPI_CMD_SLAVE_MASK;
 		writel(val, priv->regs + SPI_CMD_REG);
 
@@ -326,22 +326,22 @@ static int bcmbca_hsspi_child_pre_probe(struct udevice *dev)
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
index 8234468b1d..84077c01d8 100644
--- a/drivers/spi/cf_spi.c
+++ b/drivers/spi/cf_spi.c
@@ -123,7 +123,7 @@ static int coldfire_spi_claim_bus(struct udevice *dev)
 	/* Clear FIFO and resume transfer */
 	clrbits_be32(&dspi->mcr, DSPI_MCR_CTXF | DSPI_MCR_CRXF);
 
-	dspi_chip_select(slave_plat->cs);
+	dspi_chip_select(slave_plat->cs[0]);
 
 	return 0;
 }
@@ -139,7 +139,7 @@ static int coldfire_spi_release_bus(struct udevice *dev)
 	/* Clear FIFO */
 	clrbits_be32(&dspi->mcr, DSPI_MCR_CTXF | DSPI_MCR_CRXF);
 
-	dspi_chip_unselect(slave_plat->cs);
+	dspi_chip_unselect(slave_plat->cs[0]);
 
 	return 0;
 }
@@ -168,7 +168,7 @@ static int coldfire_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	if ((flags & SPI_XFER_BEGIN) == SPI_XFER_BEGIN)
 		ctrl |= DSPI_TFR_CONT;
 
-	ctrl = setup_ctrl(ctrl, slave_plat->cs);
+	ctrl = setup_ctrl(ctrl, slave_plat->cs[0]);
 
 	if (len > 1) {
 		int tmp_len = len - 1;
diff --git a/drivers/spi/davinci_spi.c b/drivers/spi/davinci_spi.c
index 82049872d0..b264c52abb 100644
--- a/drivers/spi/davinci_spi.c
+++ b/drivers/spi/davinci_spi.c
@@ -338,13 +338,13 @@ static int davinci_spi_claim_bus(struct udevice *dev)
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
@@ -363,11 +363,11 @@ static int davinci_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	struct udevice *bus = dev->parent;
 	struct davinci_spi_slave *ds = dev_get_priv(bus);
 
-	if (slave->cs >= ds->num_cs) {
+	if (slave->cs[0] >= ds->num_cs) {
 		printf("Invalid SPI chipselect\n");
 		return -EINVAL;
 	}
-	ds->cur_cs = slave->cs;
+	ds->cur_cs = slave->cs[0];
 
 	return __davinci_spi_xfer(ds, bitlen, dout, din, flags);
 }
diff --git a/drivers/spi/fsl_dspi.c b/drivers/spi/fsl_dspi.c
index 1d4d90ce5a..f2393c041f 100644
--- a/drivers/spi/fsl_dspi.c
+++ b/drivers/spi/fsl_dspi.c
@@ -452,9 +452,9 @@ static int fsl_dspi_child_pre_probe(struct udevice *dev)
 	unsigned char pcssck = 0, cssck = 0;
 	unsigned char pasc = 0, asc = 0;
 
-	if (slave_plat->cs >= priv->num_chipselect) {
+	if (slave_plat->cs[0] >= priv->num_chipselect) {
 		debug("DSPI invalid chipselect number %d(max %d)!\n",
-		      slave_plat->cs, priv->num_chipselect - 1);
+		      slave_plat->cs[0], priv->num_chipselect - 1);
 		return -EINVAL;
 	}
 
@@ -469,12 +469,12 @@ static int fsl_dspi_child_pre_probe(struct udevice *dev)
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
@@ -527,13 +527,13 @@ static int fsl_dspi_claim_bus(struct udevice *dev)
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
@@ -559,7 +559,7 @@ static int fsl_dspi_release_bus(struct udevice *dev)
 	dspi_halt(priv, 1);
 
 	/* processor special release work */
-	cpu_dspi_release_bus(dev_seq(bus), slave_plat->cs);
+	cpu_dspi_release_bus(dev_seq(bus), slave_plat->cs[0]);
 
 	return 0;
 }
@@ -615,7 +615,7 @@ static int fsl_dspi_xfer(struct udevice *dev, unsigned int bitlen,
 	bus = dev->parent;
 	priv = dev_get_priv(bus);
 
-	return dspi_xfer(priv, slave_plat->cs, bitlen, dout, din, flags);
+	return dspi_xfer(priv, slave_plat->cs[0], bitlen, dout, din, flags);
 }
 
 static int fsl_dspi_set_speed(struct udevice *bus, uint speed)
diff --git a/drivers/spi/fsl_espi.c b/drivers/spi/fsl_espi.c
index 2638ed2520..7ed35aa3e6 100644
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
index 8a0a53cb37..c7f554826c 100644
--- a/drivers/spi/fsl_qspi.c
+++ b/drivers/spi/fsl_qspi.c
@@ -510,10 +510,10 @@ static void fsl_qspi_select_mem(struct fsl_qspi *q, struct spi_slave *slave)
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
index 7e72fb9e23..51cc487271 100644
--- a/drivers/spi/mpc8xx_spi.c
+++ b/drivers/spi/mpc8xx_spi.c
@@ -148,7 +148,7 @@ static void mpc8xx_spi_cs_activate(struct udevice *dev)
 	struct mpc8xx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *platdata = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[platdata->cs], 1);
+	dm_gpio_set_value(&priv->gpios[platdata->cs[0]], 1);
 }
 
 static void mpc8xx_spi_cs_deactivate(struct udevice *dev)
@@ -156,7 +156,7 @@ static void mpc8xx_spi_cs_deactivate(struct udevice *dev)
 	struct mpc8xx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *platdata = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[platdata->cs], 0);
+	dm_gpio_set_value(&priv->gpios[platdata->cs[0]], 0);
 }
 
 static int mpc8xx_spi_xfer_one(struct udevice *dev, size_t count,
diff --git a/drivers/spi/mpc8xxx_spi.c b/drivers/spi/mpc8xxx_spi.c
index cd624f4d6f..b34e1c2129 100644
--- a/drivers/spi/mpc8xxx_spi.c
+++ b/drivers/spi/mpc8xxx_spi.c
@@ -113,7 +113,7 @@ static void mpc8xxx_spi_cs_activate(struct udevice *dev)
 	struct mpc8xxx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[plat->cs], 1);
+	dm_gpio_set_value(&priv->gpios[plat->cs[0]], 1);
 }
 
 static void mpc8xxx_spi_cs_deactivate(struct udevice *dev)
@@ -121,7 +121,7 @@ static void mpc8xxx_spi_cs_deactivate(struct udevice *dev)
 	struct mpc8xxx_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
-	dm_gpio_set_value(&priv->gpios[plat->cs], 0);
+	dm_gpio_set_value(&priv->gpios[plat->cs[0]], 0);
 }
 
 static int mpc8xxx_spi_xfer(struct udevice *dev, uint bitlen,
@@ -137,10 +137,10 @@ static int mpc8xxx_spi_xfer(struct udevice *dev, uint bitlen,
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
index ad4daeba3c..75ab4ab1dd 100644
--- a/drivers/spi/mscc_bb_spi.c
+++ b/drivers/spi/mscc_bb_spi.c
@@ -123,11 +123,11 @@ int mscc_bb_spi_xfer(struct udevice *dev, unsigned int bitlen,
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
index e7c393ae18..9ab39a188b 100644
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
@@ -632,7 +632,7 @@ static int mxc_spi_claim_bus(struct udevice *dev)
 
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
index fefdaaa9e9..7489c896f9 100644
--- a/drivers/spi/nxp_fspi.c
+++ b/drivers/spi/nxp_fspi.c
@@ -962,7 +962,7 @@ static int nxp_fspi_claim_bus(struct udevice *dev)
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
index 3d82fc74ff..35bd876609 100644
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
index e11ae7fc7a..c4b31dc2a6 100644
--- a/drivers/spi/pic32_spi.c
+++ b/drivers/spi/pic32_spi.c
@@ -247,7 +247,7 @@ static int pic32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 	slave_plat = dev_get_parent_plat(slave);
 
 	debug("spi_xfer: bus:%i cs:%i flags:%lx\n",
-	      dev_seq(bus), slave_plat->cs, flags);
+	      dev_seq(bus), slave_plat->cs[0], flags);
 	debug("msg tx %p, rx %p submitted of %d byte(s)\n",
 	      tx_buf, rx_buf, len);
 
diff --git a/drivers/spi/rk_spi.c b/drivers/spi/rk_spi.c
index 4571dc9f9b..2c3d70ba71 100644
--- a/drivers/spi/rk_spi.c
+++ b/drivers/spi/rk_spi.c
@@ -444,7 +444,7 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
 
 	/* Assert CS before transfer */
 	if (flags & SPI_XFER_BEGIN)
-		spi_cs_activate(dev, slave_plat->cs);
+		spi_cs_activate(dev, slave_plat->cs[0]);
 
 	/*
 	 * To ensure fast loading of firmware images (e.g. full U-Boot
@@ -507,7 +507,7 @@ static int rockchip_spi_xfer(struct udevice *dev, unsigned int bitlen,
 
 	/* Deassert CS after transfer */
 	if (flags & SPI_XFER_END)
-		spi_cs_deactivate(dev, slave_plat->cs);
+		spi_cs_deactivate(dev, slave_plat->cs[0]);
 
 	rkspi_enable_chip(regs, false);
 	if (!out)
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
index 12320367e9..ca29cfd7c8 100644
--- a/drivers/spi/spi-aspeed-smc.c
+++ b/drivers/spi/spi-aspeed-smc.c
@@ -192,7 +192,7 @@ static u32 ast2400_get_clk_setting(struct udevice *dev, uint max_hz)
 
 	if (found) {
 		hclk_div = hclk_masks[i] << 8;
-		priv->flashes[slave_plat->cs].max_freq = hclk_clk / (i + 1);
+		priv->flashes[slave_plat->cs[0]].max_freq = hclk_clk / (i + 1);
 	}
 
 	dev_dbg(dev, "found: %s, hclk: %d, max_clk: %d\n", found ? "yes" : "no",
@@ -200,7 +200,7 @@ static u32 ast2400_get_clk_setting(struct udevice *dev, uint max_hz)
 
 	if (found) {
 		dev_dbg(dev, "h_div: %d (mask %x), speed: %d\n",
-			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs].max_freq);
+			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs[0]].max_freq);
 	}
 
 	return hclk_div;
@@ -311,7 +311,7 @@ static u32 ast2500_get_clk_setting(struct udevice *dev, uint max_hz)
 	for (i = 0; i < ARRAY_SIZE(hclk_masks); i++) {
 		if (hclk_clk / (i + 1) <= max_hz) {
 			found = true;
-			priv->flashes[slave_plat->cs].max_freq =
+			priv->flashes[slave_plat->cs[0]].max_freq =
 							hclk_clk / (i + 1);
 			break;
 		}
@@ -325,7 +325,7 @@ static u32 ast2500_get_clk_setting(struct udevice *dev, uint max_hz)
 	for (i = 0; i < ARRAY_SIZE(hclk_masks); i++) {
 		if (hclk_clk / ((i + 1) * 4) <= max_hz) {
 			found = true;
-			priv->flashes[slave_plat->cs].max_freq =
+			priv->flashes[slave_plat->cs[0]].max_freq =
 						hclk_clk / ((i + 1) * 4);
 			break;
 		}
@@ -340,7 +340,7 @@ end:
 
 	if (found) {
 		dev_dbg(dev, "h_div: %d (mask %x), speed: %d\n",
-			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs].max_freq);
+			i + 1, hclk_masks[i], priv->flashes[slave_plat->cs[0]].max_freq);
 	}
 
 	return hclk_div;
@@ -456,7 +456,7 @@ static u32 ast2600_get_clk_setting(struct udevice *dev, uint max_hz)
 
 		if (found) {
 			hclk_div = ((j << 24) | hclk_masks[i] << 8);
-			priv->flashes[slave_plat->cs].max_freq =
+			priv->flashes[slave_plat->cs[0]].max_freq =
 						hclk_clk / (i + 1 + j * 16);
 			break;
 		}
@@ -467,7 +467,7 @@ static u32 ast2600_get_clk_setting(struct udevice *dev, uint max_hz)
 
 	if (found) {
 		dev_dbg(dev, "base_clk: %d, h_div: %d (mask %x), speed: %d\n",
-			j, i + 1, hclk_masks[i], priv->flashes[slave_plat->cs].max_freq);
+			j, i + 1, hclk_masks[i], priv->flashes[slave_plat->cs[0]].max_freq);
 	}
 
 	return hclk_div;
@@ -588,7 +588,7 @@ static int aspeed_spi_exec_op_user_mode(struct spi_slave *slave,
 	struct udevice *bus = dev->parent;
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(slave->dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	u32 ce_ctrl_reg = (u32)&priv->regs->ce_ctrl[cs];
 	u32 ce_ctrl_val;
 	struct aspeed_spi_flash *flash = &priv->flashes[cs];
@@ -668,7 +668,7 @@ static int aspeed_spi_dirmap_create(struct spi_mem_dirmap_desc *desc)
 	const struct aspeed_spi_info *info = priv->info;
 	struct spi_mem_op op_tmpl = desc->info.op_tmpl;
 	u32 i;
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	u32 cmd_io_conf;
 	u32 ce_ctrl_reg;
 
@@ -725,7 +725,7 @@ static ssize_t aspeed_spi_dirmap_read(struct spi_mem_dirmap_desc *desc,
 	struct udevice *dev = desc->slave->dev;
 	struct aspeed_spi_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 	int ret;
 
 	dev_dbg(dev, "read op:0x%x, addr:0x%llx, len:0x%x\n",
@@ -750,7 +750,7 @@ static struct aspeed_spi_flash *aspeed_spi_get_flash(struct udevice *dev)
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	struct aspeed_spi_plat *plat = dev_get_plat(bus);
 	struct aspeed_spi_priv *priv = dev_get_priv(bus);
-	u32 cs = slave_plat->cs;
+	u32 cs = slave_plat->cs[0];
 
 	if (cs >= plat->max_cs) {
 		dev_err(dev, "invalid CS %u\n", cs);
@@ -1068,10 +1068,10 @@ static int aspeed_spi_claim_bus(struct udevice *dev)
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
@@ -1089,7 +1089,7 @@ static int aspeed_spi_release_bus(struct udevice *dev)
 	struct udevice *bus = dev->parent;
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 
-	dev_dbg(bus, "%s: release bus CS%u\n", bus->name, slave_plat->cs);
+	dev_dbg(bus, "%s: release bus CS%u\n", bus->name, slave_plat->cs[0]);
 
 	if (!aspeed_spi_get_flash(dev))
 		return -ENODEV;
diff --git a/drivers/spi/spi-mxic.c b/drivers/spi/spi-mxic.c
index b98bcd9b6b..3835865ea7 100644
--- a/drivers/spi/spi-mxic.c
+++ b/drivers/spi/spi-mxic.c
@@ -366,8 +366,8 @@ static int mxic_spi_mem_exec_op(struct spi_slave *slave,
 		nio = 2;
 
 	writel(HC_CFG_NIO(nio) |
-	       HC_CFG_TYPE(slave_plat->cs, HC_CFG_TYPE_SPI_NOR) |
-	       HC_CFG_SLV_ACT(slave_plat->cs) | HC_CFG_IDLE_SIO_LVL(1) |
+	       HC_CFG_TYPE(slave_plat->cs[0], HC_CFG_TYPE_SPI_NOR) |
+	       HC_CFG_SLV_ACT(slave_plat->cs[0]) | HC_CFG_IDLE_SIO_LVL(1) |
 	       HC_CFG_MAN_CS_EN,
 	       priv->regs + HC_CFG);
 	writel(HC_EN_BIT, priv->regs + HC_EN);
@@ -396,7 +396,7 @@ static int mxic_spi_mem_exec_op(struct spi_slave *slave,
 			ss_ctrl |= OP_READ;
 	}
 
-	writel(ss_ctrl, priv->regs + SS_CTRL(slave_plat->cs));
+	writel(ss_ctrl, priv->regs + SS_CTRL(slave_plat->cs[0]));
 
 	writel(readl(priv->regs + HC_CFG) | HC_CFG_MAN_CS_ASSERT,
 	       priv->regs + HC_CFG);
diff --git a/drivers/spi/spi-qup.c b/drivers/spi/spi-qup.c
index 836c550b0b..dc001e6e4c 100644
--- a/drivers/spi/spi-qup.c
+++ b/drivers/spi/spi-qup.c
@@ -718,7 +718,7 @@ static int qup_spi_xfer(struct udevice *dev, unsigned int bitlen,
 		if (ret != 0)
 			return ret;
 
-		ret = qup_spi_set_cs(bus, slave_plat->cs, false);
+		ret = qup_spi_set_cs(bus, slave_plat->cs[0], false);
 		if (ret != 0)
 			return ret;
 	}
@@ -736,7 +736,7 @@ static int qup_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (flags & SPI_XFER_END) {
-		ret = qup_spi_set_cs(bus, slave_plat->cs, true);
+		ret = qup_spi_set_cs(bus, slave_plat->cs[0], true);
 		if (ret != 0)
 			return ret;
 	}
diff --git a/drivers/spi/spi-sifive.c b/drivers/spi/spi-sifive.c
index 0c8666c05f..15407d482c 100644
--- a/drivers/spi/spi-sifive.c
+++ b/drivers/spi/spi-sifive.c
@@ -108,13 +108,13 @@ static void sifive_spi_prep_device(struct sifive_spi *spi,
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
index fc82791006..364ba4b3a9 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -497,7 +497,7 @@ static int f_ospi_exec_op(struct spi_slave *slave, const struct spi_mem_op *op)
 	int err = 0;
 
 	slave_plat = dev_get_parent_plat(slave->dev);
-	ospi->chip_select = slave_plat->cs;
+	ospi->chip_select = slave_plat->cs[0];
 
 	switch (op->data.dir) {
 	case SPI_MEM_DATA_IN:
diff --git a/drivers/spi/spi-sunxi.c b/drivers/spi/spi-sunxi.c
index 88550b8ea8..e00532a371 100644
--- a/drivers/spi/spi-sunxi.c
+++ b/drivers/spi/spi-sunxi.c
@@ -360,7 +360,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (flags & SPI_XFER_BEGIN)
-		sun4i_spi_set_cs(bus, slave_plat->cs, true);
+		sun4i_spi_set_cs(bus, slave_plat->cs[0], true);
 
 	/* Reset FIFOs */
 	setbits_le32(SPI_REG(priv, SPI_FCR), SPI_BIT(priv, SPI_FCR_RF_RST) |
@@ -391,7 +391,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 					false, SUN4I_SPI_TIMEOUT_MS, false);
 		if (ret < 0) {
 			printf("ERROR: sun4i_spi: Timeout transferring data\n");
-			sun4i_spi_set_cs(bus, slave_plat->cs, false);
+			sun4i_spi_set_cs(bus, slave_plat->cs[0], false);
 			return ret;
 		}
 
@@ -402,7 +402,7 @@ static int sun4i_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	}
 
 	if (flags & SPI_XFER_END)
-		sun4i_spi_set_cs(bus, slave_plat->cs, false);
+		sun4i_spi_set_cs(bus, slave_plat->cs[0], false);
 
 	return 0;
 }
diff --git a/drivers/spi/spi-synquacer.c b/drivers/spi/spi-synquacer.c
index eb522fd7b3..a3c0ad1712 100644
--- a/drivers/spi/spi-synquacer.c
+++ b/drivers/spi/spi-synquacer.c
@@ -193,12 +193,12 @@ static void synquacer_spi_config(struct udevice *dev, void *rx, const void *tx)
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
index 6e28172523..1a61926450 100644
--- a/drivers/spi/spi-uclass.c
+++ b/drivers/spi/spi-uclass.c
@@ -224,7 +224,7 @@ int spi_chip_select(struct udevice *dev)
 {
 	struct dm_spi_slave_plat *plat = dev_get_parent_plat(dev);
 
-	return plat ? plat->cs : -ENOENT;
+	return plat ? plat->cs[0] : -ENOENT;
 }
 
 int spi_find_chip_select(struct udevice *bus, int cs, struct udevice **devp)
@@ -261,8 +261,8 @@ int spi_find_chip_select(struct udevice *bus, int cs, struct udevice **devp)
 		struct dm_spi_slave_plat *plat;
 
 		plat = dev_get_parent_plat(dev);
-		dev_dbg(bus, "%s: plat=%p, cs=%d\n", __func__, plat, plat->cs);
-		if (plat->cs == cs) {
+		dev_dbg(bus, "%s: plat=%p, cs=%d\n", __func__, plat, plat->cs[0]);
+		if (plat->cs[0] == cs) {
 			*devp = dev;
 			return 0;
 		}
@@ -415,7 +415,7 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 			return ret;
 		}
 		plat = dev_get_parent_plat(dev);
-		plat->cs = cs;
+		plat->cs[0] = cs;
 		if (speed) {
 			plat->max_hz = speed;
 		} else {
@@ -445,6 +445,11 @@ int _spi_get_bus_and_cs(int busnum, int cs, int speed, int mode,
 
 	slave = dev_get_parent_priv(dev);
 	bus_data = dev_get_uclass_priv(bus);
+	
+	if ((dev_read_bool(dev, "parallel-memories")) && !slave->multi_cs_cap) {
+		dev_err(dev, "controller doesn't support multi CS\n");
+		return -EINVAL;
+	}
 
 	/*
 	 * In case the operation speed is not yet established by
@@ -508,8 +513,26 @@ int spi_slave_of_to_plat(struct udevice *dev, struct dm_spi_slave_plat *plat)
 {
 	int mode = 0;
 	int value;
+	int ret;
+
+	ret = dev_read_u32_array(dev, "reg", plat->cs, SPI_CS_CNT_MAX);
+
+	if (IS_ENABLED(CONFIG_SPL_BUILD)) {
+		if (ret == -FDT_ERR_BADLAYOUT) {
+			dev_read_u32(dev, "reg", &plat->cs[0]);
+		} else {
+			dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+			return ret;
+		}
+	} else {
+		if (ret == -EOVERFLOW) {
+			dev_read_u32(dev, "reg", &plat->cs[0]);
+		} else if (ret) {
+			dev_err(dev, "has no valid 'reg' property (%d)\n", ret);
+			return ret;
+		}
+	}
 
-	plat->cs = dev_read_u32_default(dev, "reg", -1);
 	plat->max_hz = dev_read_u32_default(dev, "spi-max-frequency",
 					    SPI_DEFAULT_SPEED_HZ);
 	if (dev_read_bool(dev, "spi-cpol"))
diff --git a/drivers/spi/stm32_qspi.c b/drivers/spi/stm32_qspi.c
index 2812a4da41..3216ec8010 100644
--- a/drivers/spi/stm32_qspi.c
+++ b/drivers/spi/stm32_qspi.c
@@ -394,7 +394,7 @@ static int stm32_qspi_claim_bus(struct udevice *dev)
 {
 	struct stm32_qspi_priv *priv = dev_get_priv(dev->parent);
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
-	int slave_cs = slave_plat->cs;
+	int slave_cs = slave_plat->cs[0];
 
 	if (slave_cs >= STM32_QSPI_MAX_CHIP)
 		return -ENODEV;
diff --git a/drivers/spi/stm32_spi.c b/drivers/spi/stm32_spi.c
index 97b83b1716..a1f31cf653 100644
--- a/drivers/spi/stm32_spi.c
+++ b/drivers/spi/stm32_spi.c
@@ -434,7 +434,7 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 
 	slave_plat = dev_get_parent_plat(slave);
 	if (flags & SPI_XFER_BEGIN)
-		stm32_spi_set_cs(bus, slave_plat->cs, false);
+		stm32_spi_set_cs(bus, slave_plat->cs[0], false);
 
 	/* Be sure to have data in fifo before starting data transfer */
 	if (priv->tx_buf)
@@ -485,7 +485,7 @@ static int stm32_spi_xfer(struct udevice *slave, unsigned int bitlen,
 	stm32_spi_stopxfer(bus);
 
 	if (flags & SPI_XFER_END)
-		stm32_spi_set_cs(bus, slave_plat->cs, true);
+		stm32_spi_set_cs(bus, slave_plat->cs[0], true);
 
 	return xfer_status;
 }
diff --git a/drivers/spi/ti_qspi.c b/drivers/spi/ti_qspi.c
index a16412ec6f..1f2494e592 100644
--- a/drivers/spi/ti_qspi.c
+++ b/drivers/spi/ti_qspi.c
@@ -163,7 +163,7 @@ static int ti_qspi_xfer(struct udevice *dev, unsigned int bitlen,
 	uchar *rxp = din;
 	uint status;
 	int timeout;
-	unsigned int cs = slave->cs;
+	unsigned int cs = slave->cs[0];
 
 	bus = dev->parent;
 	priv = dev_get_priv(bus);
@@ -344,7 +344,7 @@ static int ti_qspi_exec_mem_op(struct spi_slave *slave,
 	if (from + op->data.nbytes > priv->mmap_size)
 		return -ENOTSUPP;
 
-	ti_qspi_setup_mmap_read(priv, slave_plat->cs, op->cmd.opcode,
+	ti_qspi_setup_mmap_read(priv, slave_plat->cs[0], op->cmd.opcode,
 				op->data.buswidth, op->addr.nbytes,
 				op->dummy.nbytes);
 
@@ -363,7 +363,7 @@ static int ti_qspi_claim_bus(struct udevice *dev)
 	bus = dev->parent;
 	priv = dev_get_priv(bus);
 
-	if (slave_plat->cs > priv->num_cs) {
+	if (slave_plat->cs[0] > priv->num_cs) {
 		debug("invalid qspi chip select\n");
 		return -EINVAL;
 	}
@@ -371,13 +371,13 @@ static int ti_qspi_claim_bus(struct udevice *dev)
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
@@ -395,12 +395,12 @@ static int ti_qspi_release_bus(struct udevice *dev)
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
index 0e7fa3a452..b2af17ebae 100644
--- a/drivers/spi/xilinx_spi.c
+++ b/drivers/spi/xilinx_spi.c
@@ -291,7 +291,7 @@ static void xilinx_spi_startup_block(struct udevice *dev)
 	 * Perform a dummy read as a work around for
 	 * the startup block issue.
 	 */
-	spi_cs_activate(dev, slave_plat->cs);
+	spi_cs_activate(dev, slave_plat->cs[0]);
 	txp = 0x9f;
 	start_transfer(dev, (void *)&txp, NULL, 1);
 
@@ -306,7 +306,7 @@ static int xilinx_spi_xfer(struct udevice *dev, unsigned int bitlen,
 	struct dm_spi_slave_plat *slave_plat = dev_get_parent_plat(dev);
 	int ret;
 
-	spi_cs_activate(dev, slave_plat->cs);
+	spi_cs_activate(dev, slave_plat->cs[0]);
 	ret = start_transfer(dev, dout, din, bitlen / 8);
 	spi_cs_deactivate(dev);
 	return ret;
@@ -331,7 +331,7 @@ static int xilinx_spi_mem_exec_op(struct spi_slave *spi,
 		startup++;
 	}
 
-	spi_cs_activate(spi->dev, slave_plat->cs);
+	spi_cs_activate(spi->dev, slave_plat->cs[0]);
 
 	if (op->cmd.opcode) {
 		ret = start_transfer(spi->dev, (void *)&op->cmd.opcode,
diff --git a/drivers/spi/zynq_qspi.c b/drivers/spi/zynq_qspi.c
index b71b9a6fd6..e8bc196ce9 100644
--- a/drivers/spi/zynq_qspi.c
+++ b/drivers/spi/zynq_qspi.c
@@ -585,13 +585,13 @@ static int zynq_qspi_xfer(struct udevice *dev, unsigned int bitlen,
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
index d15d91a1d2..37fa12b96b 100644
--- a/drivers/spi/zynq_spi.c
+++ b/drivers/spi/zynq_spi.c
@@ -240,15 +240,15 @@ static int zynq_spi_xfer(struct udevice *dev, unsigned int bitlen,
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
index 6e8e0cce7f..b7148864e7 100644
--- a/include/spi.h
+++ b/include/spi.h
@@ -80,7 +80,7 @@ struct dm_spi_bus {
  * @mode:	SPI mode to use for this device (see SPI mode flags)
  */
 struct dm_spi_slave_plat {
-	unsigned int cs;
+	unsigned int cs[SPI_CS_CNT_MAX];
 	uint max_hz;
 	uint mode;
 };
@@ -166,6 +166,12 @@ struct spi_slave {
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
index ed94194346..0f3044bca7 100644
--- a/lib/acpi/acpi_device.c
+++ b/lib/acpi/acpi_device.c
@@ -728,7 +728,7 @@ static int acpi_device_set_spi(const struct udevice *dev, struct acpi_spi *spi,
 
 	plat = dev_get_parent_plat(slave->dev);
 	memset(spi, '\0', sizeof(*spi));
-	spi->device_select = plat->cs;
+	spi->device_select = plat->cs[0];
 	spi->device_select_polarity = SPI_POLARITY_LOW;
 	spi->wire_mode = SPI_4_WIRE_MODE;
 	spi->speed = plat->max_hz;
-- 
2.17.1

