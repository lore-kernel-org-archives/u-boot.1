Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56980C7115D
	for <u-boot@archiver.kernel.org>; Mon, 23 Jun 2025 08:25:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 815CF81F66;
	Mon, 23 Jun 2025 10:24:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J8DZ7U0f";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E14E681FEE; Mon, 23 Jun 2025 10:24:57 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D6CA80548
 for <u-boot@lists.denx.de>; Mon, 23 Jun 2025 10:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=Padmarao.Begari@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQpYcw8pavElGZiInYy7/14ztycvh/p91IN7NhTsiw6AsJr1AKnJVAdFlQvwIBwtgwWLpyM5MkbsFUe/u6J7RHDpEXLQcrzOz+e+OWYAmMcWbqTtexb3tR1Vwmqrwq+/gB5CmxfGKvzc4SjHrjg7HZrg85/bZ1bsEb+MHBlZS8ijjVH9ZRKQYt5VLGVQyf8O3/Xf9UQnmgdEoi8vuotcQny/B19CWqtbCBgpzhfR8F6r2emfTa0KE6L9y1fVyxLavWWehYrY71OsAVz4Yei1/xhGfR/seVN5FDiv1mebEz359/VIa/K2raSQ4aH40nVGtgl8v6A6ldzMRS8mfmVdvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHC6AVbP+eAL3DxR1EkXHy6BbdNJGrXHkMnzwuXr24w=;
 b=uB2z9l4XWQriHxCjuhLFAwm6EoJ/t7TxegGk0M/VgiLdEsXVLls0FF/TfrCGQb1bZsDHnUsrdKgHZijnG3CIxxDouMgrf7vUY6MjhLfmhKGZ/IsGXZ1aynfgrm0OO2zvU+VaZXRi58Twt+ZxlEdoLwSgmoecJvWFQjTJFSYSXByU1jDvdC1Xacu46JfgmKJuxVP/261PrLNKWwWGijVW2AJytAq4A1qI6ELBKsVUATAf+04QktWZUawK0nAHIXO3DbS6HG8xVCkd4jqIv++7NoubiTNZkMcl8FF/nLRl5D9nG3NCxdEcFA+3Ymni5yUkL3173HWoJK2yzzi4cNW35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHC6AVbP+eAL3DxR1EkXHy6BbdNJGrXHkMnzwuXr24w=;
 b=J8DZ7U0fX9lQSYGEyC6XW2+hpJcXQyo2SmvXhtnVhjcqpV3FQtDStraWwHkmbxx/OF2zSUfjsdnjNPKWM/XL7qEmFrjdWLA8W5c/LBPVP659SwjRFoIFo4si6B/dYYiIDWgctQVzQQrMmUU5MSzo7KxGWfNG85JsTX5Bi+PQ+1w=
Received: from PH8P222CA0007.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:2d7::29)
 by PH8PR12MB7351.namprd12.prod.outlook.com (2603:10b6:510:215::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.19; Mon, 23 Jun
 2025 08:24:50 +0000
Received: from CY4PEPF0000EE34.namprd05.prod.outlook.com
 (2603:10b6:510:2d7:cafe::66) by PH8P222CA0007.outlook.office365.com
 (2603:10b6:510:2d7::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.29 via Frontend Transport; Mon,
 23 Jun 2025 08:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EE34.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 08:24:50 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 03:24:49 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 23 Jun
 2025 03:24:48 -0500
Received: from xhdkummari40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 23 Jun 2025 03:24:46 -0500
From: Padmarao Begari <padmarao.begari@amd.com>
To: <u-boot@lists.denx.de>
CC: <git@amd.com>, <michal.simek@amd.com>, <hs@denx.de>,
 <jonathan.stroud@amd.com>, <bigunclemax@gmail.com>
Subject: [PATCH] i2c: muxes: Add PCA9541 i2c arbitrator driver
Date: Mon, 23 Jun 2025 13:54:39 +0530
Message-ID: <20250623082439.949845-1-padmarao.begari@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE34:EE_|PH8PR12MB7351:EE_
X-MS-Office365-Filtering-Correlation-Id: 9862a02a-cb72-4340-775f-08ddb22f6c24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026|30052699003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y3jaLNcAuHQBmjhNMj0HVlsYHc80O/ZPRqhJSw2yCi45Rte3puRYf2YC1xjm?=
 =?us-ascii?Q?Z/EP+DicEdKglSJVt8TugVm2EEC+98l+cSQso26OoxMD+4WLsRrlaNfL6ssi?=
 =?us-ascii?Q?0OepI8sUxotACS3E8BX5Xi/ioF3Hbi1Op18oUfMdV0tT8Q7VSNfMcVE2Qkxy?=
 =?us-ascii?Q?rW8HFWQ2Upjr1JxD3ubrG7Jh18q5u0Fp9f3yZ0THSpi6ZTZ8kT0CzrhQZM1M?=
 =?us-ascii?Q?8/7d97lQOTA5vep7z7+yf1PpcenBPIX3W4LsOyl2rrQtAziw/dOx6biSvpma?=
 =?us-ascii?Q?vA/4UVsx3P6YgC1uTf+FomUzKKYH+xy5RfI8uovWSBdqpEqkK3ZDyj9QmqCq?=
 =?us-ascii?Q?wVI4p4vChU2CaR96okCwhMJTpqBM6Vuf13H7DAcG1ga2QwS+TcfOtCOaPhbb?=
 =?us-ascii?Q?uZlXDGQJtNGQtUkCegNJKKUeHqtFrRs9E4CNRFW+oJHq5ogd29Rwxr82Wq2c?=
 =?us-ascii?Q?MknYztyJjxOtLG6JuFtgSNOARK8jVeDn8oPKDGq98eCJeLYaXpmZclkABN+t?=
 =?us-ascii?Q?uTesFFzoVygdXaaWbRrIyiyCXrmoRXFN5Iliae585u41kX23vny0H8yzUGXr?=
 =?us-ascii?Q?iOxMXzgd/Q3GWClVD4JkfbQF9h8NKA8FQHuyYssZ2Brl+wNBwUN61KhfnPEA?=
 =?us-ascii?Q?FwLTrPM16KXOiuG7Eo3yActyMEtuDgWuWx/vIh0R+siY9Gb8BcHl5pazVS0l?=
 =?us-ascii?Q?iAyJGSDO3HNexTcMZdPestH0BXjcTxEJf5I+PyHjEm4r+BEtqmZJ3zeIAswM?=
 =?us-ascii?Q?3cGvnLPJDkk96v7N2jyr0gE812DhE0yD/ACVgs2uoEBxdlOD1+q8VP8yaIeV?=
 =?us-ascii?Q?jee1gxofdCc5NgzKuSgVleh+0RhLJmDwBw+OJxETadAmBn9QVEVFVRRjpXxi?=
 =?us-ascii?Q?253n54G1mzZaPMfEc0uIbXqkxHf1XBWIJ33FoDmQuZcEPC0TYBV1VkmM9Vsf?=
 =?us-ascii?Q?kIJl0nogSIHpQElzmW/RDDsJG4kTKlmGzlzYXXWXwesniOivYhD58WqsJ+j4?=
 =?us-ascii?Q?T31coB7r8Rt1CbAuOVGznqhFgIYtLSKsWZU1EwhHf3XHiz6RnPfmVPNM1KCD?=
 =?us-ascii?Q?KzNJh7wR2cv0BcJaK8Mk05CVYh9zmF+zzHQrJn4CxYZsMgZ6BJoS3gGVNHt5?=
 =?us-ascii?Q?oOaM/DDNHKcekF/frZUmD6vPrCNHPmdbd6e/9fRUkXVCE7c+s16N3skJUdM7?=
 =?us-ascii?Q?mnNMTW7PMxhzLeiVS38FZCd8NVlxjOPx0v//kH5U0XeazNexyY65d6Yz14Py?=
 =?us-ascii?Q?Jef+tVoSNhlXqbc+wWTbapA7/Pti9i0JzsOIt2RH27nM4umgCvsu7TxXbm9i?=
 =?us-ascii?Q?83StUuVx/bnknXaKizE7WOmOZtsLDLgjOJy+hYJgXqp2R/bN3xJM2x0wJLVL?=
 =?us-ascii?Q?42AhfOgMbxLXJgijAos43Oizw/HPgPwpXs3YfJJTFfbzspFPpmQ6tM6Ub5zk?=
 =?us-ascii?Q?ILAH63nrs9Dzn/Ue0vqhTc/4W0FDADySS6wA9z1Bx3vvSuEBTPq4mpGhsIIp?=
 =?us-ascii?Q?f4dOKyVkMf81phBhiG+IlsmnuEzrE0rumlnK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(30052699003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 08:24:50.3145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9862a02a-cb72-4340-775f-08ddb22f6c24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE34.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7351
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

Add a driver for the PCA9541 i2c bus arbitrator based
on the Linux driver for the same device.

Co-developed-by: Jonathan Stroud <jonathan.stroud@amd.com>
Signed-off-by: Jonathan Stroud <jonathan.stroud@amd.com>
Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
---
 drivers/i2c/muxes/Kconfig   |   7 +
 drivers/i2c/muxes/Makefile  |   1 +
 drivers/i2c/muxes/pca9541.c | 297 ++++++++++++++++++++++++++++++++++++
 3 files changed, 305 insertions(+)
 create mode 100644 drivers/i2c/muxes/pca9541.c

diff --git a/drivers/i2c/muxes/Kconfig b/drivers/i2c/muxes/Kconfig
index cd5579aa55a..65319bb6fd8 100644
--- a/drivers/i2c/muxes/Kconfig
+++ b/drivers/i2c/muxes/Kconfig
@@ -25,6 +25,13 @@ config I2C_ARB_GPIO_CHALLENGE
 	  response mechanism where masters have to claim the bus by asserting
 	  a GPIO.
 
+config I2C_MUX_PCA9541
+	tristate "NXP PCA9541 I2C Master Selector"
+	depends on I2C_MUX
+	help
+	  If you say yes here you get support for the NXP PCA9541
+	  I2C Master Selector.
+
 config I2C_MUX_PCA954x
 	tristate "TI PCA954x I2C Mux/switches"
 	depends on I2C_MUX
diff --git a/drivers/i2c/muxes/Makefile b/drivers/i2c/muxes/Makefile
index b690821199f..844d4520e43 100644
--- a/drivers/i2c/muxes/Makefile
+++ b/drivers/i2c/muxes/Makefile
@@ -3,5 +3,6 @@
 # Copyright (c) 2015 Google, Inc
 obj-$(CONFIG_I2C_ARB_GPIO_CHALLENGE) += i2c-arb-gpio-challenge.o
 obj-$(CONFIG_I2C_MUX) += i2c-mux-uclass.o
+obj-$(CONFIG_I2C_MUX_PCA9541) += pca9541.o
 obj-$(CONFIG_I2C_MUX_PCA954x) += pca954x.o
 obj-$(CONFIG_I2C_MUX_GPIO) += i2c-mux-gpio.o
diff --git a/drivers/i2c/muxes/pca9541.c b/drivers/i2c/muxes/pca9541.c
new file mode 100644
index 00000000000..021088acaee
--- /dev/null
+++ b/drivers/i2c/muxes/pca9541.c
@@ -0,0 +1,297 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2008-2009 Rodolfo Giometti <giometti@linux.it>
+ * Copyright (c) 2008-2009 Eurotech S.p.A. <info@eurotech.it>
+ * Copyright (c) 2010 Ericsson AB.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
+ */
+
+#include <dm.h>
+#include <errno.h>
+#include <i2c.h>
+#include <log.h>
+#include <malloc.h>
+#include <linux/delay.h>
+
+/*
+ * The PCA9541 is a bus master selector. It supports two I2C masters connected
+ * to a single slave bus.
+ *
+ * Before each bus transaction, a master has to acquire bus ownership. After the
+ * transaction is complete, bus ownership has to be released. This fits well
+ * into the I2C multiplexer framework, which provides select and release
+ * functions for this purpose. For this reason, this driver is modeled as
+ * single-channel I2C bus multiplexer.
+ *
+ * This driver assumes that the two bus masters are controlled by two different
+ * hosts. If a single host controls both masters, platform code has to ensure
+ * that only one of the masters is instantiated at any given time.
+ */
+
+#define PCA9541_CONTROL		0x01
+#define PCA9541_ISTAT		0x02
+
+#define PCA9541_CTL_MYBUS	BIT(0)
+#define PCA9541_CTL_NMYBUS	BIT(1)
+#define PCA9541_CTL_BUSON	BIT(2)
+#define PCA9541_CTL_NBUSON	BIT(3)
+#define PCA9541_CTL_BUSINIT	BIT(4)
+#define PCA9541_CTL_TESTON	BIT(6)
+#define PCA9541_CTL_NTESTON	BIT(7)
+
+#define PCA9541_ISTAT_INTIN	BIT(0)
+#define PCA9541_ISTAT_BUSINIT	BIT(1)
+#define PCA9541_ISTAT_BUSOK	BIT(2)
+#define PCA9541_ISTAT_BUSLOST	BIT(3)
+#define PCA9541_ISTAT_MYTEST	BIT(6)
+#define PCA9541_ISTAT_NMYTEST	BIT(7)
+
+#define BUSON			(PCA9541_CTL_BUSON | PCA9541_CTL_NBUSON)
+#define MYBUS			(PCA9541_CTL_MYBUS | PCA9541_CTL_NMYBUS)
+
+/* arbitration timeouts, in jiffies */
+#define ARB_TIMEOUT_US		125000	/* 125 ms until forcing bus ownership */
+#define ARB2_TIMEOUT_US		250000	/* 250 ms until acquisition failure */
+
+/* arbitration retry delays, in us */
+#define SELECT_DELAY_SHORT	50
+#define SELECT_DELAY_LONG	1000
+
+struct pca9541_plat {
+	u32 addr;
+};
+
+struct pca9541_priv {
+	u32 addr;
+	unsigned long select_timeout;
+	long arb_timeout;
+};
+
+static inline int mybus(int x)
+{
+	return !(x & MYBUS) || ((x & MYBUS) == MYBUS);
+}
+
+static inline int busoff(int x)
+{
+	return !(x & BUSON) || ((x & BUSON) == BUSON);
+}
+
+static int pca9541_reg_write(struct udevice *mux, struct pca9541_priv *client,
+			     u8 command, u8 val)
+{
+	return dm_i2c_write(mux, command, &val, 1);
+}
+
+static int pca9541_reg_read(struct udevice *mux, struct pca9541_priv *client,
+			    u8 command)
+{
+	int ret;
+	uchar byte;
+
+	ret = dm_i2c_read(mux, command, &byte, 1);
+
+	return ret ?: byte;
+}
+
+/*
+ * Arbitration management functions
+ */
+
+/* Release bus. Also reset NTESTON and BUSINIT if it was set. */
+static void pca9541_release_bus(struct udevice *mux, struct pca9541_priv *client)
+{
+	int reg;
+
+	reg = pca9541_reg_read(mux, client, PCA9541_CONTROL);
+	if (reg >= 0 && !busoff(reg) && mybus(reg))
+		pca9541_reg_write(mux, client, PCA9541_CONTROL,
+				  (reg & PCA9541_CTL_NBUSON) >> 1);
+}
+
+/*
+ * Arbitration is defined as a two-step process. A bus master can only activate
+ * the slave bus if it owns it; otherwise it has to request ownership first.
+ * This multi-step process ensures that access contention is resolved
+ * gracefully.
+ *
+ * Bus	Ownership	Other master	Action
+ * state		requested access
+ * ----------------------------------------------------
+ * off	-		yes		wait for arbitration timeout or
+ *					for other master to drop request
+ * off	no		no		take ownership
+ * off	yes		no		turn on bus
+ * on	yes		-		done
+ * on	no		-		wait for arbitration timeout or
+ *					for other master to release bus
+ *
+ * The main contention point occurs if the slave bus is off and both masters
+ * request ownership at the same time. In this case, one master will turn on
+ * the slave bus, believing that it owns it. The other master will request
+ * bus ownership. Result is that the bus is turned on, and master which did
+ * _not_ own the slave bus before ends up owning it.
+ */
+
+/* Control commands per PCA9541 datasheet */
+static const u8 pca9541_control[16] = {
+	4, 0, 1, 5, 4, 4, 5, 5, 0, 0, 1, 1, 0, 4, 5, 1
+};
+
+/*
+ * Channel arbitration
+ *
+ * Return values:
+ *  <0: error
+ *  0 : bus not acquired
+ *  1 : bus acquired
+ */
+static int pca9541_arbitrate(struct udevice *mux, struct pca9541_priv *client)
+{
+	int reg, ret = 0;
+
+	reg = pca9541_reg_read(mux, client, PCA9541_CONTROL);
+	if (reg < 0)
+		return reg;
+
+	if (busoff(reg)) {
+		int istat;
+
+		/*
+		 * Bus is off. Request ownership or turn it on unless
+		 * other master requested ownership.
+		 */
+		istat = pca9541_reg_read(mux, client, PCA9541_ISTAT);
+		if (!(istat & PCA9541_ISTAT_NMYTEST) ||
+		    client->arb_timeout <= 0) {
+			/*
+			 * Other master did not request ownership,
+			 * or arbitration timeout expired. Take the bus.
+			 */
+			pca9541_reg_write(mux, client, PCA9541_CONTROL,
+					  pca9541_control[reg & 0x0f]
+					  | PCA9541_CTL_NTESTON);
+			client->select_timeout = SELECT_DELAY_SHORT;
+		} else {
+			/*
+			 * Other master requested ownership.
+			 * Set extra long timeout to give it time to acquire it.
+			 */
+			client->select_timeout = SELECT_DELAY_LONG * 2;
+		}
+	} else if (mybus(reg)) {
+		/*
+		 * Bus is on, and we own it. We are done with acquisition.
+		 * Reset NTESTON and BUSINIT, then return success.
+		 */
+		if (reg & (PCA9541_CTL_NTESTON | PCA9541_CTL_BUSINIT))
+			pca9541_reg_write(mux, client, PCA9541_CONTROL,
+					  reg & ~(PCA9541_CTL_NTESTON
+					  | PCA9541_CTL_BUSINIT));
+		ret = 1;
+	} else {
+		/*
+		 * Other master owns the bus.
+		 * If arbitration timeout has expired, force ownership.
+		 * Otherwise request it.
+		 */
+		client->select_timeout = SELECT_DELAY_LONG;
+		if (client->arb_timeout <= 0) {
+			/* Time is up, take the bus and reset it. */
+			pca9541_reg_write(mux, client, PCA9541_CONTROL,
+					  pca9541_control[reg & 0x0f]
+					  | PCA9541_CTL_BUSINIT
+					  | PCA9541_CTL_NTESTON);
+		} else {
+			/* Request bus ownership if needed */
+			if (!(reg & PCA9541_CTL_NTESTON))
+				pca9541_reg_write(mux, client, PCA9541_CONTROL,
+						  reg | PCA9541_CTL_NTESTON);
+		}
+	}
+
+	return ret;
+}
+
+static int pca9541_select_chan(struct udevice *mux, struct udevice *bus,
+			       uint channel)
+{
+	struct pca9541_priv *priv = dev_get_priv(mux);
+	int ret;
+	long timeout = ARB2_TIMEOUT_US; /* Give up after this time */
+
+	/* Force bus ownership after this time */
+	priv->arb_timeout = ARB_TIMEOUT_US;
+	do {
+		ret = pca9541_arbitrate(mux, priv);
+		if (ret)
+			return ret < 0 ? ret : 0;
+
+		udelay(priv->select_timeout);
+		timeout -= priv->select_timeout;
+		priv->arb_timeout -= priv->select_timeout;
+	} while (timeout > 0);
+
+	debug("I2C Arbitration select timeout\n");
+
+	return -ETIMEDOUT;
+}
+
+static int pca9541_release_chan(struct udevice *mux, struct udevice *bus,
+				uint channel)
+{
+	struct pca9541_priv *priv = dev_get_priv(mux);
+
+	pca9541_release_bus(mux, priv);
+
+	return 0;
+}
+
+/*
+ * I2C init/probing/exit functions
+ */
+static int pca9541_of_to_plat(struct udevice *dev)
+{
+	struct pca9541_plat *plat = dev_get_plat(dev);
+
+	plat->addr = dev_read_u32_default(dev, "reg", 0);
+	if (!plat->addr) {
+		debug("Reg property is not found\n");
+		return -ENODEV;
+	}
+
+	debug("Device %s at 0x%x\n", dev->name, plat->addr);
+
+	return 0;
+}
+
+static int pca9541_probe(struct udevice *dev)
+{
+	struct pca9541_plat *plat = dev_get_plat(dev);
+	struct pca9541_priv *priv = dev_get_priv(dev);
+
+	priv->addr = plat->addr;
+
+	return 0;
+}
+
+static const struct i2c_mux_ops pca9541_ops = {
+	.select = pca9541_select_chan,
+	.deselect = pca9541_release_chan,
+};
+
+static const struct udevice_id pca9541_ids[] = {
+	{ .compatible = "nxp,pca9541", },
+	{ }
+};
+
+U_BOOT_DRIVER(pca9541) = {
+	.name = "pca9541",
+	.id = UCLASS_I2C_MUX,
+	.of_match = pca9541_ids,
+	.probe = pca9541_probe,
+	.ops = &pca9541_ops,
+	.of_to_plat = pca9541_of_to_plat,
+	.plat_auto = sizeof(struct pca9541_plat),
+	.priv_auto = sizeof(struct pca9541_priv),
+};
-- 
2.25.1

