Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A01FE6816B
	for <u-boot@archiver.kernel.org>; Tue, 17 Feb 2026 10:32:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC59280325;
	Tue, 17 Feb 2026 11:32:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="R9QbdO9k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D931283AA9; Tue, 17 Feb 2026 11:32:46 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B258280086
 for <u-boot@lists.denx.de>; Tue, 17 Feb 2026 11:32:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=a-dutta@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8O25mdlAzCzQBUHdoVDmMfX4BjvDbZOJ+pGYYr9kMYekumTBMKxsVPcZz6XHDYRQNcDtrva4S/hV+u83E0JfBYY0rsxIOZPg3nL2pFWtNwY+t4s3RD3jomainbVZGP2O3NgC50yCuzCocZxnNc+CUClI2BliG7+Froe4uYU69Zz8WpOzJlSjOewIkz1PzV7P6EoL8v36L0pQtNFhvlvVE7MUDtCU5S2pjPt11DVVtBvotr1tuVFKsoVawPwSEMSDZ4NDRmSTVoGVroKVjxrYIIXqWKUm83y6MrJumKiwxVTvuRuxgCZ89/21lvFm5jSJfrhgj4Q/cdIzx5KzxC+nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bq7qUjXwTsQQsBJxY1V+tNOQqqEcrMm9VPge7kgvd50=;
 b=Z036aQxDJCsBzB2Dn/HzkKaIp0jMfhkTxAFYZ2tQAMBSKO/KwZxpjnRFJi1PoXVTVhaoJWhXouxu2RdVc/VzetepOS36LJxBbSzXokkvel8GpuIiYGUNlz5dasg1lhPAgIYCgcTcUKRpzn3n7LUToqYwvXWXki50VdXYltn6t9DullRknjKDdqbe8O1gaJnE7oXXykLMS3X/bZYGKKxJERPsMjWLBZk+FS+sHhFy6GiPecT95kCitvWJR4SA67dgsCAonzEo2OZEkhp3AiLRlATAUOk2RC2i5JNnyhXtgIrpYNQmGrFck58Ge3IbkiwYwIa3Uy8F+sFlZsBCwBpOpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bq7qUjXwTsQQsBJxY1V+tNOQqqEcrMm9VPge7kgvd50=;
 b=R9QbdO9kT+k+UbhWknX8tLfAkFDG4VpfhZWdxb4EZJgOOEq4Um/H7Z8IS4u1BLza+zvhKwT3AQqCOs+E+KxYvOE+jH5vHnkaA+8GUXMAsleqKbtT/0tEWkeccV98j3Wj1S1bk2c4MElfakAIgEswDhQkqQNpmlKgXIL9t+O8HWg=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by CY5PR10MB6262.namprd10.prod.outlook.com (2603:10b6:930:42::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.13; Tue, 17 Feb
 2026 10:32:39 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::10) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.13 via Frontend Transport; Tue,
 17 Feb 2026 10:32:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 17 Feb 2026 10:32:38 +0000
Received: from DFLE213.ent.ti.com (10.64.6.71) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 04:32:37 -0600
Received: from DFLE205.ent.ti.com (10.64.6.63) by DFLE213.ent.ti.com
 (10.64.6.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Feb
 2026 04:32:36 -0600
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE205.ent.ti.com
 (10.64.6.63) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 17 Feb 2026 04:32:36 -0600
Received: from a-dutta.dhcp.ti.com (a-dutta.dhcp.ti.com [10.24.51.206] (may be
 forged))
 by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61HAWX503209319;
 Tue, 17 Feb 2026 04:32:33 -0600
From: Anurag Dutta <a-dutta@ti.com>
To: <jagan@amarulasolutions.com>, <trini@konsulko.com>
CC: <michal.simek@amd.com>, <venkatesh.abbarapu@amd.com>,
 <boon.khai.ng@altera.com>, <a-dutta@ti.com>, <s-k6@ti.com>,
 <gehariprasath@ti.com>, <vigneshr@ti.com>, <u-kumar1@ti.com>,
 <u-boot@lists.denx.de>
Subject: [PATCH] spi: cadence-qspi: Disable Auto-HW polling
Date: Tue, 17 Feb 2026 16:02:32 +0530
Message-ID: <20260217103232.244780-1-a-dutta@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|CY5PR10MB6262:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf7a276-93b7-4847-63ec-08de6e0fdf42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kZ359h0JGU9+e9BfxwjvxIosxEbGL1uDggNB/JqJGuYp1VjNFkNVqoKcrcnb?=
 =?us-ascii?Q?z6RSw+Wq11bJ6rPAOYdI2moKTpytItZPnIQUQ4y43eNxU/IX1/JK9L+095Nx?=
 =?us-ascii?Q?D33lKz0gHUXoQ2XpZOS1EN2i52aZCzAOv3F3cm9g6oCXjPbbHXmKHNmdcWU8?=
 =?us-ascii?Q?KxNOIj0qOCqv25jcvW53USdNcvlMStXInT2tOQTVgGFdZKhdL0XOeHsZZ9hd?=
 =?us-ascii?Q?UOq4ErsLx8xAZWo8wZXPFkECOIDmSziTZl/ylhXJ/iYk442speYM6ZjwMHIT?=
 =?us-ascii?Q?iUoik7cWCASmH8j1hYIyjJNYNZC8UjHF6Q5Ye7cHyE2rb4EBiy7ptqmiJgtS?=
 =?us-ascii?Q?CRyd9UBuu+RunpTt8UU8X8RFHxC6F3TH2GAB2DPx3LVymOSWLlMQ/0TkIgIv?=
 =?us-ascii?Q?HVRjzuSfmziqQQrDnU8py3BaZr5mN1FcQiKDN5yS13t7BcMS3UYHsj08rz4i?=
 =?us-ascii?Q?aJoIP/MBNVZpq7mGwBXAUX+V29eRo6n2G73mbm/4R4FZ2THNi6xUtbUeMALa?=
 =?us-ascii?Q?/5wA9pb789eNwrlRJ2KbjcSKSDU0NXEDDwLNunvtUf9zY4jg9kpBENZLcwDK?=
 =?us-ascii?Q?ViU7dlZYgSZpJflOB4MY7E7IBLlg5Zk+jgXGw3C+GKF+QeLbpZ2fkHmv8y+i?=
 =?us-ascii?Q?JsrtoHpXyTO8M++9ToDFmrbDmczyOt3RRpBm3qFxb8bmIXsYGxUtDeLOmoN4?=
 =?us-ascii?Q?P1YSHfHa9NuDEesjXbrXrQiYuL2lkvfltUW4qRHYTXzOd25PB7Q6XfAC6cky?=
 =?us-ascii?Q?wHUJPpPSjzMc0n66srzdP7QSut8fucHyKLDpblSLTcOCuf5vbSmhKElPyufc?=
 =?us-ascii?Q?JyRy8tvXdz27A6KWmDKml7i+hS9ToaPa9Af8z0QWBwwQi3p7XeDK8f+MTU+M?=
 =?us-ascii?Q?SYMIx1rV2cx8rj7hN9kzHPKgTpDMuIMwhKjkNuxV1+EXpy5eCZo4SoQbkM3D?=
 =?us-ascii?Q?W6GoFRWKCPNbIekSAFMdjc4wieu5pzhqOL2fnG8Q3s9mgFqJBFk8/QrKdtOG?=
 =?us-ascii?Q?Dt5PRQRLoDAD0qwX4TEXLwmknxqBZdq/gMxg4+NuyXXUYcjGB05wkoqW+A3x?=
 =?us-ascii?Q?CaHJIa+9whjBXwxZy7cX4W1IAe+spOVbdyiMMtWd+R60OhAW5DUZv+qeBYA4?=
 =?us-ascii?Q?n7rIUUghVdb49l0CgU/d0wuhuWKgMva2zEmyWgGA68QGMX/rWm25eGYxka7l?=
 =?us-ascii?Q?vmVO0o/RJEh530SKPAYbpYsex1BhislMN9x1PaqEA2LCjOIocCm5Tku8bdd5?=
 =?us-ascii?Q?HshJD/AcZNXOVygpffax1pBpiRmxFk1awduK1iAxBHWMHnAS5JN1Rxb0VTMC?=
 =?us-ascii?Q?Yox5Yu5XQWNMNm74ZRhYe4wMPnWQFknawvFPgw08AOGBdSTD4aAOHxYPG0Es?=
 =?us-ascii?Q?KPA6SspLjjGtsZ5HehDO4o7ZDxPTOLDuuRWAR8rMO4L7yAqM7R32EPr4Mr0F?=
 =?us-ascii?Q?4C8Wbms2OrGORw0YP1J7ShUFiNHVLU9Hes8hmwYue2Gcn09Xghqzui1NGO4v?=
 =?us-ascii?Q?XyBfvkv/3YP9XTZd/wm9pJ2/paKSCmjnZODwwoBm9O0BPm/Qk4cGei3c0TuB?=
 =?us-ascii?Q?wdXt7JeXHI4tU8DjQtKF8hpI4BwMw9qpsrc/92Z2dawPjvr+9DJ79H5df3mZ?=
 =?us-ascii?Q?UHG6/c8a8OXjnqZl7cH4HAPAfhQGPg6547i8OXzB7fzKvD+FXqm9DVIassqU?=
 =?us-ascii?Q?eunP9A=3D=3D?=
X-Forefront-Antispam-Report: CIP:198.47.21.195; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:flwvzet201.ext.ti.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bEu2xZEmeb8sAxAVAdIa6PPCspQRtlSrHAn8O5QvVm/w/dhO3ssTKRg3n+WaDq935u0uQw603gBUQ5lZlxxdz0Rg3gec8pvSAp96oUiJmOeodKwfUOfLgRJdeOJXFWw+UiaidHSZqDvqF4SmUrqcdg+z/9S7NYLzINGztvgmUgLHMXC5K9zmt/dSGj6WXZZ27LJB1F5L1wOz3IH7US0j5IPWM1IaILXmn5JTyTT0nETvmUtJPX8bs3eaE7KDpJb+eMGw3AvsHFlt6zYmqZGL2CTkXB/oZ7kJ0Rg564QYyP+YK47sj2QvTB0o160ts3PDVUbFfNrt6U6eejWQZ35p+gnHkEH0nDQMh6whNESDPpMJzeNMaRKXXzvwtGJVaF0Rn4zX9xZ2w4EdbeErebHYSqfftZw8mJplcrurSUSlpw5ruAGZbPmCGdMSJc6q9WsN
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2026 10:32:38.1158 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf7a276-93b7-4847-63ec-08de6e0fdf42
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.21.195];
 Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6262
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

From: Apurva Nandan <a-nandan@ti.com>

cadence-quadspi has a builtin Auto-HW polling funtionality
using which it keep tracks of completion of write operations.
When Auto-HW polling is enabled, it automatically initiates
status register read operation, until the flash clears its
busy bit.

However, the controller doesn't allow an address phase during
auto-polling. Unlike SPI NOR flashes, SPI NAND flashes do
require the address of status register when polling the busy
bit using the read register operation. As Auto-HW polling is
enabled by default, cadence-quadspi returns a timeout for
every write operation after an indefinite amount of polling
on SPI NAND flashes.

Add a quirk to write to the CQSPI_REG_WR_COMPLETION_CTRL register
on the controller in order to disable Auto-HW polling as the
spi-nor core, spinand core, etc. take care of polling the busy
bit on their own.

Signed-off-by: Apurva Nandan <a-nandan@ti.com>
Signed-off-by: Anurag Dutta <a-dutta@ti.com>
---

Hi
This patch is taken from kernel commit [1].
[1] 98d948eb8331 ("spi: cadence-quadspi: fix write completion support")

 drivers/spi/cadence_qspi.c     |  7 +++++++
 drivers/spi/cadence_qspi.h     |  1 +
 drivers/spi/cadence_qspi_apb.c | 21 ++++++++++++---------
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index d1404e13810..b164d6b8647 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -29,6 +29,7 @@
 /* Quirks */
 #define CQSPI_DISABLE_STIG_MODE		BIT(0)
 #define CQSPI_DMA_MODE			BIT(1)
+#define CQSPI_NO_SUPPORT_WR_COMPLETION	BIT(2)
 
 __weak int cadence_qspi_apb_dma_read(struct cadence_spi_priv *priv,
 				     const struct spi_mem_op *op)
@@ -231,6 +232,12 @@ static int cadence_spi_probe(struct udevice *bus)
 		debug("Cadence QSPI: DMA mode enabled\n");
 	}
 
+	/* write completion is supported by default */
+	priv->wr_completion = true;
+
+	if (priv->quirks & CQSPI_NO_SUPPORT_WR_COMPLETION)
+		priv->wr_completion = false;
+
 	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE))
 		xilinx_pm_request(PM_REQUEST_NODE, PM_DEV_OSPI,
 				  ZYNQMP_PM_CAPABILITY_ACCESS, ZYNQMP_PM_MAX_QOS,
diff --git a/drivers/spi/cadence_qspi.h b/drivers/spi/cadence_qspi.h
index 1e9081c2d17..2398e7a8dad 100644
--- a/drivers/spi/cadence_qspi.h
+++ b/drivers/spi/cadence_qspi.h
@@ -260,6 +260,7 @@ struct cadence_spi_priv {
 	bool		is_decoded_cs;
 	bool		use_dac_mode;
 	bool		is_dma;
+	bool		wr_completion;
 
 	/* Transaction protocol parameters. */
 	u8		inst_width;
diff --git a/drivers/spi/cadence_qspi_apb.c b/drivers/spi/cadence_qspi_apb.c
index 0d4bc685f5d..e43bd1f0f75 100644
--- a/drivers/spi/cadence_qspi_apb.c
+++ b/drivers/spi/cadence_qspi_apb.c
@@ -823,15 +823,18 @@ int cadence_qspi_apb_write_setup(struct cadence_spi_priv *priv,
 
 	writel(op->addr.val, priv->regbase + CQSPI_REG_INDIRECTWRSTARTADDR);
 
-	if (priv->dtr) {
-		/*
-		 * Some flashes like the cypress Semper flash expect a 4-byte
-		 * dummy address with the Read SR command in DTR mode, but this
-		 * controller does not support sending address with the Read SR
-		 * command. So, disable write completion polling on the
-		 * controller's side. spi-nor will take care of polling the
-		 * status register.
-		 */
+	/*
+	 * SPI NAND flashes require the address of the status register to be
+	 * passed in the Read SR command. Also, some SPI NOR flashes like the
+	 * cypress Semper flash expect a 4-byte dummy address in the Read SR
+	 * command in DTR mode.
+	 *
+	 * But this controller does not support address phase in the Read SR
+	 * command when doing auto-HW polling. So, disable write completion
+	 * polling on the controller's side. spinand and spi-nor will take
+	 * care of polling the status register.
+	 */
+	if (priv->wr_completion) {
 		reg = readl(priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
 		reg |= CQSPI_REG_WR_DISABLE_AUTO_POLL;
 		writel(reg, priv->regbase + CQSPI_REG_WR_COMPLETION_CTRL);
-- 
2.34.1

