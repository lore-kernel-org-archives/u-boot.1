Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C82CCF9F8
	for <u-boot@archiver.kernel.org>; Thu,  6 Nov 2025 08:59:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE6383B64;
	Thu,  6 Nov 2025 09:59:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=ti.com header.i=@ti.com header.b="lkZL2JwR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 085AB83B5E; Thu,  6 Nov 2025 09:59:01 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 863EA83B22
 for <u-boot@lists.denx.de>; Thu,  6 Nov 2025 09:58:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=s-jain1@ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NI+pvoUb30BtYuW+W/nc9z2O31OLqx+E5s8Fkgwj5L2Ata6Cj34IG1O4v5u/ARyFX9hKzLftoM/cKAqECwmYp0HIPjXMGryfsr/x7JjxdIpU/cXPn8To65SyCEDYaU12K+Q9MalgCsaPUFrejD7gCjdq6AIPvgBi5bIq5WucMrXqoakqgpCoii7qqIIGY7Ge92liBym4Gocxd194gFk1Mh1xKDIsh4clLfAsEW9uTdVbqzaRatjDEeLuIJWwOVV5nbhvnI8iOoriw6zNwm075Z9Y/PuTm6VW/NEWWQNE1DKIzfRWClK/JD6lscDGYuWAmTXNhQ5Zw6aQtFIFqbH1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lyirwo+zRLiMsDC2JjMr6sRuiQP/QK/Sjz0Z8xlYfgo=;
 b=xTGhW4CFsCJsYkRWY8hqq2fCbgLagu8l6vSp45dLlnOXE/gdlJyEFZqBI1t+TD6ugsV8rVyR7zjjCuV6erFryECWvI2O0SsNITnSz+k20YCEgJ2PKjhX1kb1PUY+uJOmqiu1+TBu9/iMQ5WppCkjE2hsjlK9PE+et8K5Q4sWespdhN6Nm+KD7OP+xXruvpHOddFw1YV7dx3jCdRVIsrOXbGOAWIAqg4IPIp0rVF/DqKiCLJXDTRrNYUZJbj0t9XCBmISeHQ1OTJhGpSnWNYUO9u4oAhIBYLF3VtGScbWYC7hdGFBLmH9n9Jj9zPhMHM6mEbUV0yirKl6sLcceT2TCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.23.194) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lyirwo+zRLiMsDC2JjMr6sRuiQP/QK/Sjz0Z8xlYfgo=;
 b=lkZL2JwRfSrrNGR3KMT/JWCXoXIsFPN0jemsAYSay1yPVgQTPs5BxwwsRIaPLZvBC6XQzhYMPFo24lHMZR5W4K5vULXkOwGsNGL6LXWzUSDYDZv3ZabUnX0AtsaIHMGy+P/y377GLwG1yJMGvts8UoMHzhUtG/yhOZSeA2pdUl4=
Received: from BN0PR02CA0022.namprd02.prod.outlook.com (2603:10b6:408:e4::27)
 by CO6PR10MB5634.namprd10.prod.outlook.com (2603:10b6:303:149::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.9; Thu, 6 Nov
 2025 08:58:53 +0000
Received: from BN3PEPF0000B06B.namprd21.prod.outlook.com
 (2603:10b6:408:e4:cafe::b8) by BN0PR02CA0022.outlook.office365.com
 (2603:10b6:408:e4::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.10 via Frontend Transport; Thu,
 6 Nov 2025 08:58:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.23.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none; dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.23.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.23.194; helo=lewvzet200.ext.ti.com; pr=C
Received: from lewvzet200.ext.ti.com (198.47.23.194) by
 BN3PEPF0000B06B.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.0 via Frontend Transport; Thu, 6 Nov 2025 08:58:53 +0000
Received: from DLEE206.ent.ti.com (157.170.170.90) by lewvzet200.ext.ti.com
 (10.4.14.103) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:58:50 -0600
Received: from DLEE207.ent.ti.com (157.170.170.95) by DLEE206.ent.ti.com
 (157.170.170.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 6 Nov
 2025 02:58:50 -0600
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE207.ent.ti.com
 (157.170.170.95) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 6 Nov 2025 02:58:50 -0600
Received: from a0512632.dhcp.ti.com (a0512632.dhcp.ti.com [172.24.233.20])
 by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 5A68whm7994350;
 Thu, 6 Nov 2025 02:58:47 -0600
From: Swamil Jain <s-jain1@ti.com>
To: <devarsht@ti.com>, <aradhya.bhatia@linux.dev>, <n-jain1@ti.com>,
 <tomi.valkeinen@ideasonboard.com>, <trini@konsulko.com>
CC: <vigneshr@ti.com>, <praneeth@ti.com>, <h-shenoy@ti.com>,
 <u-kumar1@ti.com>, <n-francis@ti.com>, <u-boot@lists.denx.de>,
 <s-jain1@ti.com>
Subject: [PATCH v4 1/2] drivers: video: tidss: Refactor tidss_drv
Date: Thu, 6 Nov 2025 14:28:41 +0530
Message-ID: <20251106085842.629521-2-s-jain1@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106085842.629521-1-s-jain1@ti.com>
References: <20251106085842.629521-1-s-jain1@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06B:EE_|CO6PR10MB5634:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a75d79d-316b-41c1-bc65-08de1d12b5f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|34020700016|36860700013|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+i2zphiB0YCBODpxsWXha1VXg92jfcffH4oHG2P7W63Wp5VybH8czWSw1oQF?=
 =?us-ascii?Q?RxShoSmhlkR9tSyy12ojPSSShPK+vH00GXXe6sxT+4E5MNYvdc/4YsJkxqdL?=
 =?us-ascii?Q?pRSfBUF4ZiC7xeUYTpm4e5Ltya4jsv3uwsPOEVjMFT02IAkjJBIGJlIvbCbX?=
 =?us-ascii?Q?FUbqJXTXNxSvkoBFlE3j3li/nsmFiCifc4FLy7XKZrL4GCdUxE2z9kSsx9hn?=
 =?us-ascii?Q?i1HHIM/1y7rfaNWei6dzV1fnYMcE/ORv9ybu4/GPDiYa8ebaeKYFO/GYUT7m?=
 =?us-ascii?Q?tWx+wrEopS9PNe2kB6+fzdDb6V3ToQFA88oYBnvSzKaxDHtzmzggcsK7LK0m?=
 =?us-ascii?Q?9UwB9a/lbqX8JHXq2V89HROS/3gw8G8XO8Bpi5TM5ijpNwL636gFfE8kZNPG?=
 =?us-ascii?Q?mLCiCGu8f7OpAZOFvtcq8HZZAzchRNdxu0wwv3vLsqqNwE8U0HEkuiA3c9lp?=
 =?us-ascii?Q?hNXec5hwKCwz3GAW7HfjHJceqfou/DQGp+AmMNj9Nu9muQh0bkCjxyfnlGKc?=
 =?us-ascii?Q?3LbtgvBGuMy6MfqTsLGHIrm++zq+O43RitPiMKHbIgpwDHTixSVbT/6h/bG7?=
 =?us-ascii?Q?ReK8iFT/jE8l+DFRP1AP7JuhSuyb3ekh8kvKM9EVTRFHkKXWxuUccttRFIwZ?=
 =?us-ascii?Q?3/J2+MfsZ36chTDBCyO9lr7DCCwJDiJBy4qgiEZfn2uCKJJXSwS7s/GXOApf?=
 =?us-ascii?Q?W6sBjSbKGKyASdU3P7duYnqL0GuHeG/yt0wdruAkU54rVsUWWSx9ND7Aq2wP?=
 =?us-ascii?Q?qfKvvPpYgqw9Bq3rZ3NHG/maECJCl3A5M7PJutYB+oVXIi2KVaZylNPgfqLf?=
 =?us-ascii?Q?E1M2aODglHeKVR+dp7YAmg+MUBB4aBEVokNWm/Nf9mTQb7UQ8xfw7RKuhX+M?=
 =?us-ascii?Q?Ah/Uc5NyLC0bkW+Pa4Gdlm5pt5PytvUw4K0GxwvYkA3g6sKLZPBRpeZdbySH?=
 =?us-ascii?Q?eOYpTJb4iaNHxg0sLCQDpCKlrzpTdApAMPfXyNFw3509uyLAS9jdMiBBu6gx?=
 =?us-ascii?Q?tkcjxZEl35qyYTwSFP0gpjDdJcBnMYNQEcJLqU8xRPRvubatsLtTkY0Fmjdu?=
 =?us-ascii?Q?L08V0tocCaF0w517jc1f9uXIyeG0y+pU0U165um3oNOZYhNUUjqR8DVl3ugg?=
 =?us-ascii?Q?7by/lMCqqWmPU+kwhE1nMEjqtHi/xZqIB50UIf3cfxwOKq7/ff5xs/OTOBJd?=
 =?us-ascii?Q?0Mwhx75+GJwYyF7iCYxvoSEYLaFnDTKY/L1XW0DDcT4YDPzylnYZJdeny+G1?=
 =?us-ascii?Q?TwsmxjM5NkSRympv5WkOLoFNbXldn+xcfAIQ/Fs0a0OFKJbmuk6iRpKe/WU4?=
 =?us-ascii?Q?LpDh4UyCeoyEcTL1Llh7E7kFvf44G1ly4k/YtxN+L1HfW3oO3UQs1Ov0Qc/E?=
 =?us-ascii?Q?loOOicQ67ROHNLvcB4LcZXpSDN+hY2z8YxTsmG4zs/iTnj6nkJE5OY/yAGQS?=
 =?us-ascii?Q?1B996HDm6FF3TwDS0ZEX/DQwFAEwd0mLAW4g31N5e+W2khuhs/HAx8ZjUx+D?=
 =?us-ascii?Q?+eLRQQmH+5ICYPZ7uyTGzfxTBtKNC+G/DzCa?=
X-Forefront-Antispam-Report: CIP:198.47.23.194; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:lewvzet200.ext.ti.com; PTR:InfoDomainNonexistent;
 CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(34020700016)(36860700013)(13003099007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:58:53.1422 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a75d79d-316b-41c1-bc65-08de1d12b5f6
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7; Ip=[198.47.23.194];
 Helo=[lewvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06B.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5634
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

- Refactor tidss_drv to improve modularity, enabling support for more
  display interfaces beyond OLDI in the future
- Add detection and initialization of active OLDI panels using the DT
- Port tidss_oldi.c from the upstream Linux kernel oldi series[0] and
  derive several APIs from it to determine the dual link pixel order
- Add tidss_oldi_init() and helper routines to handle OLDI-specific
  setup and move related helper routines to tidss_oldi.c

[0]: https://lore.kernel.org/all/20250528122544.817829-1-aradhya.bhatia@linux.dev/

Signed-off-by: Swamil Jain <s-jain1@ti.com>
---
 drivers/video/tidss/Makefile     |   2 +-
 drivers/video/tidss/tidss_drv.c  | 236 +++++++++++++-------
 drivers/video/tidss/tidss_drv.h  |  40 ++--
 drivers/video/tidss/tidss_oldi.c | 364 +++++++++++++++++++++++++++++++
 drivers/video/tidss/tidss_oldi.h |  72 ++++++
 drivers/video/tidss/tidss_regs.h |  21 --
 6 files changed, 612 insertions(+), 123 deletions(-)
 create mode 100644 drivers/video/tidss/tidss_oldi.c
 create mode 100644 drivers/video/tidss/tidss_oldi.h

diff --git a/drivers/video/tidss/Makefile b/drivers/video/tidss/Makefile
index 3381a5fec57..846c19c5a7b 100644
--- a/drivers/video/tidss/Makefile
+++ b/drivers/video/tidss/Makefile
@@ -9,4 +9,4 @@
 # Author: Tomi Valkeinen <tomi.valkeinen@ti.com>
 
 
-obj-${CONFIG_$(PHASE_)VIDEO_TIDSS} = tidss_drv.o
+obj-${CONFIG_$(PHASE_)VIDEO_TIDSS} = tidss_drv.o tidss_oldi.o
diff --git a/drivers/video/tidss/tidss_drv.c b/drivers/video/tidss/tidss_drv.c
index 865d4bddb7f..790ff6e591c 100644
--- a/drivers/video/tidss/tidss_drv.c
+++ b/drivers/video/tidss/tidss_drv.c
@@ -25,13 +25,13 @@
 
 #include <asm/io.h>
 #include <asm/cache.h>
-#include <asm/utils.h>
 #include <asm/bitops.h>
 
 #include <dm/devres.h>
 #include <dm/of_access.h>
 #include <dm/device_compat.h>
 #include <dm/device-internal.h>
+#include <dm/ofnode_graph.h>
 
 #include <linux/bug.h>
 #include <linux/err.h>
@@ -40,6 +40,7 @@
 
 #include "tidss_drv.h"
 #include "tidss_regs.h"
+#include "tidss_oldi.h"
 
 DECLARE_GLOBAL_DATA_PTR;
 
@@ -79,6 +80,18 @@ static const u16 tidss_am62x_common_regs[DSS_COMMON_REG_TABLE_LEN] = {
 	[DSS_SECURE_DISABLE_OFF] =		0xac,
 };
 
+static struct dss_bus_format dss_bus_formats[] = {
+	{ MEDIA_BUS_FMT_RGB444_1X12,		12, false, 0 },
+	{ MEDIA_BUS_FMT_RGB565_1X16,		16, false, 0 },
+	{ MEDIA_BUS_FMT_RGB666_1X18,		18, false, 0 },
+	{ MEDIA_BUS_FMT_RGB888_1X24,		24, false, 0 },
+	{ MEDIA_BUS_FMT_RGB101010_1X30,		30, false, 0 },
+	{ MEDIA_BUS_FMT_RGB121212_1X36,		36, false, 0 },
+	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, SPWG_18 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, SPWG_24 },
+	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, JEIDA_24 },
+};
+
 /* TIDSS AM62x Features */
 const struct dss_features dss_am625_feats = {
 	.max_pclk_khz = {
@@ -249,37 +262,6 @@ static void OVR_REG_FLD_MOD(struct tidss_drv_priv *priv, u32 ovr, u32 idx,
 					      val, start, end));
 }
 
-static void dss_oldi_tx_power(struct tidss_drv_priv *priv, bool power)
-{
-	u32 val;
-
-	if (WARN_ON(!priv->oldi_io_ctrl))
-		return;
-
-	if (priv->feat->subrev == DSS_AM625) {
-		if (power) {
-			switch (priv->oldi_mode) {
-			case OLDI_SINGLE_LINK_SINGLE_MODE:
-				/* Power down OLDI TX 1 */
-				val = OLDI1_PWRDN_TX;
-				break;
-			case OLDI_DUAL_LINK:
-				/* No Power down */
-				val = 0;
-			break;
-			default:
-				/* Power down both the OLDI TXes */
-				val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
-				break;
-			}
-		} else {
-			val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
-		}
-		regmap_update_bits(priv->oldi_io_ctrl, OLDI_PD_CTRL,
-				   OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX, val);
-	}
-}
-
 static void dss_set_num_datalines(struct tidss_drv_priv *priv,
 				  u32 hw_videoport)
 {
@@ -333,19 +315,19 @@ static void dss_enable_oldi(struct tidss_drv_priv *priv, u32 hw_videoport)
 	oldi_cfg |= BIT(0); /* ENABLE */
 
 	switch (priv->oldi_mode) {
-	case OLDI_MODE_OFF:
+	case OLDI_MODE_UNSUPPORTED:
 		oldi_cfg &= ~BIT(0); /* DISABLE */
 		break;
 
-	case OLDI_SINGLE_LINK_SINGLE_MODE:
+	case OLDI_MODE_SINGLE_LINK:
 		/* All configuration is done for this mode.  */
 		break;
 
-	case OLDI_SINGLE_LINK_DUPLICATE_MODE:
+	case OLDI_MODE_CLONE_SINGLE_LINK:
 		oldi_cfg |= BIT(5); /* DUPLICATE MODE */
 		break;
 
-	case OLDI_DUAL_LINK:
+	case OLDI_MODE_DUAL_LINK:
 		oldi_cfg |= BIT(11); /* DUALMODESYNC */
 		oldi_cfg |= BIT(3); /* data-mapping field also indicates dual-link mode */
 		break;
@@ -562,7 +544,7 @@ int dss_vp_enable_clk(struct tidss_drv_priv *priv, u32 hw_videoport)
 void dss_vp_prepare(struct tidss_drv_priv *priv, u32 hw_videoport)
 {
 	dss_vp_set_gamma(priv, hw_videoport, NULL, 0);
-	dss_vp_set_default_color(priv, 0, 0);
+	dss_vp_set_default_color(priv, hw_videoport, 0);
 
 	if (priv->feat->vp_bus_type[hw_videoport] == DSS_VP_OLDI) {
 		dss_oldi_tx_power(priv, true);
@@ -734,27 +716,111 @@ static void dss_vp_init(struct tidss_drv_priv *priv)
 		VP_REG_FLD_MOD(priv, i, DSS_VP_CONFIG, 1, 2, 2);
 }
 
-static int dss_init_am65x_oldi_io_ctrl(struct udevice *dev,
-				       struct tidss_drv_priv *priv)
+bool is_pipeline_components_enabled(ofnode endpoint, ofnode prev)
 {
-	struct udevice *syscon;
-	struct regmap *regmap;
-	int ret = 0;
+	ofnode ports_parent = ofnode_graph_get_port_parent(endpoint);
+	ofnode ports = ofnode_find_subnode(ports_parent, "ports");
+	ofnode port, local_endpoint, remote_endpoint;
 
-	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "ti,am65x-oldi-io-ctrl",
-					   &syscon);
-	if (ret) {
-		debug("unable to find ti,am65x-oldi-io-ctrl syscon device (%d)\n", ret);
-		return ret;
+	if (!ofnode_valid(ports) || !ofnode_valid(ports_parent))
+		return false;
+
+	if (strstr(ofnode_get_name(ports_parent), "dss"))
+		/*
+		 * If we reach dss again, return true. In the case of a dual-link OLDI,
+		 * we have 2 ports. While traversing oldi@0, this API also traverses oldi@1
+		 * and hence it will reach dss_ports again. If it reaches dss_ports,
+		 * that means every element in the pipeline is enabled already, and hence
+		 * if dss is reached, return true.
+		 */
+		return true;
+
+	/*
+	 *Traverse all endpoints of the ports node.
+	 */
+	ofnode_for_each_subnode(port, ports) {
+		if (strncmp(ofnode_get_name(port), "port", 4))
+			continue;
+		ofnode_for_each_subnode(local_endpoint, port) {
+			if (strncmp(ofnode_get_name(local_endpoint), "endpoint", 8))
+				continue;
+			remote_endpoint = ofnode_graph_get_remote_endpoint(local_endpoint);
+			if (prev.np == remote_endpoint.np)
+				continue;
+			return ofnode_is_enabled(remote_endpoint) &&
+			       is_pipeline_components_enabled(remote_endpoint, local_endpoint);
+		}
 	}
+	return true;
+}
+
+static bool is_bridge_and_panel_enabled(ofnode endpoint)
+{
+	ofnode remote_endpoint = ofnode_graph_get_remote_endpoint(endpoint);
+	ofnode prev_endpoint = endpoint;
+
+	return is_pipeline_components_enabled(remote_endpoint, prev_endpoint);
+}
+
+static int tidss_enable_pipeline_components(struct tidss_drv_priv *priv)
+{
+	/*
+	 * Check if any bridge is present in the pipeline and initialize it.
+	 * Pipeline here refer to DSS=>bridges=>panel. If we find all elements
+	 * of a pipeline enabled in DT then only pipeline is enabled.
+	 * This function returns active panels count with all bridges with sink
+	 * are enabled in DT.
+	 */
+	ofnode dss_node = dev_ofnode(priv->dev);
+	ofnode dss_ports = ofnode_find_subnode(dss_node, "ports");
+	ofnode port, remote_port, local_endpoint;
+	int hw_videoport;
+	int active_pipelines = 0;
+	int ret;
+
+	ofnode_for_each_subnode(port, dss_ports) {
+		if (strncmp(ofnode_get_name(port), "port", 4))
+			continue;
 
-	/* get grf-reg base address */
-	regmap = syscon_get_regmap(syscon);
-	if (!regmap) {
-		debug("unable to find rockchip grf regmap\n");
-		return -ENODEV;
+		ofnode_for_each_subnode(local_endpoint, port) {
+			if (strncmp(ofnode_get_name(local_endpoint), "endpoint", 8))
+				continue;
+
+			if (!is_bridge_and_panel_enabled(local_endpoint))
+				continue;
+
+			/* Get videoport id*/
+			ret = ofnode_read_u32(port, "reg", &hw_videoport);
+			if (ret) {
+				dev_warn(priv->dev,
+					 "Failed to read videoport id, reg property not found for node: %s\n",
+					 ofnode_get_name(local_endpoint));
+				/* Check for other video ports */
+				continue;
+			}
+
+			remote_port = ofnode_graph_get_remote_port_parent(local_endpoint);
+			if (strstr(ofnode_get_name(remote_port), "oldi")) {
+				/* Initialize oldi */
+				ret = tidss_oldi_init(priv->dev);
+				if (ret) {
+					if (ret != -ENODEV)
+						dev_warn(priv->dev, "oldi panel error %d\n", ret);
+					break;
+				}
+
+				priv->active_hw_vps[active_pipelines++] = hw_videoport;
+				/*
+				 * Only one dual-link oldi panel supported at a time so
+				 * initialize it only and then check for other videoports
+				 */
+				break;
+			}
+		}
 	}
-	priv->oldi_io_ctrl = regmap;
+	priv->active_pipelines = active_pipelines;
+	if (active_pipelines == 0)
+		return -1;
 	return 0;
 }
 
@@ -772,7 +838,6 @@ static int tidss_drv_probe(struct udevice *dev)
 	priv->dev = dev;
 
 	priv->feat = &dss_am625_feats;
-
     /*
      * set your plane format based on your bmp image
      * Supported 24bpp and 32bpp bmpimages
@@ -782,6 +847,18 @@ static int tidss_drv_probe(struct udevice *dev)
 
 	dss_common_regmap = priv->feat->common_regs;
 
+	/*
+	 * Check for all components present in the pipeline. Pipeline here refers
+	 * to: DSS_HW_VP*=>bridge[0]=>....=>bridge[n]=>panel. Enable all
+	 * components in the pipeline.
+	 */
+	ret = tidss_enable_pipeline_components(priv);
+	if (ret) {
+		if (ret == -1)
+			dev_warn(priv->dev, "NO active panels detected, check status of panel nodes\n");
+		return ret;
+	}
+
 	ret = uclass_first_device_err(UCLASS_PANEL, &panel);
 	if (ret) {
 		if (ret != -ENODEV)
@@ -829,10 +906,12 @@ static int tidss_drv_probe(struct udevice *dev)
 	dss_vid_write(priv, 0, DSS_VID_BA_1, uc_plat->base & 0xffffffff);
 	dss_vid_write(priv, 0, DSS_VID_BA_EXT_1, (u64)uc_plat->base >> 32);
 
-	ret = dss_plane_setup(priv, 0, 0);
-	if (ret) {
-		dss_plane_enable(priv, 0, false);
-			return ret;
+	for (i = 0; i < priv->active_pipelines; i++) {
+		ret = dss_plane_setup(priv, 0, priv->active_hw_vps[i]);
+		if (ret) {
+			dss_plane_enable(priv, 0, false);
+				return ret;
+		}
 	}
 
 	dss_plane_enable(priv, 0, true);
@@ -844,34 +923,31 @@ static int tidss_drv_probe(struct udevice *dev)
 		priv->base_vp[i] = dev_remap_addr_name(dev, priv->feat->vp_name[i]);
 	}
 
-	ret = clk_get_by_name(dev, "vp1", &priv->vp_clk[0]);
-	if (ret) {
-		dev_err(dev, "video port %d clock enable error %d\n", i, ret);
-		return ret;
-	}
+	uc_priv->xsize = timings.hactive.typ;
+	uc_priv->ysize = timings.vactive.typ;
 
-	dss_ovr_set_plane(priv, 1, 0, 0, 0, 0);
-	dss_ovr_enable_layer(priv, 0, 0, true);
+	for (i = 0; i < priv->active_pipelines; i++) {
 
-	/* Video Port cloks */
-	dss_vp_enable_clk(priv, 0);
+		ret = clk_get_by_name(dev,
+				      dss_am625_feats.vpclk_name[priv->active_hw_vps[i]],
+				      &priv->vp_clk[priv->active_hw_vps[i]]);
+		if (ret) {
+			dev_err(dev, "video port %d clock enable error %d\n", i, ret);
+			return ret;
+		}
 
-	dss_vp_set_clk_rate(priv, 0, timings.pixelclock.typ * 1000);
+		dss_ovr_set_plane(priv, 1, priv->active_hw_vps[i], 0, 0, 0);
+		dss_ovr_enable_layer(priv, priv->active_hw_vps[i], 0, true);
 
-	priv->oldi_mode = OLDI_MODE_OFF;
-	uc_priv->xsize = timings.hactive.typ;
-	uc_priv->ysize = timings.vactive.typ;
-	if (priv->feat->subrev == DSS_AM65X || priv->feat->subrev == DSS_AM625) {
-		priv->oldi_mode = OLDI_DUAL_LINK;
-		if (priv->oldi_mode) {
-			ret = dss_init_am65x_oldi_io_ctrl(dev, priv);
-			if (ret)
-				return ret;
-		}
+		/* Video Port cloks */
+		dss_vp_enable_clk(priv, priv->active_hw_vps[i]);
+
+		dss_vp_set_clk_rate(priv, priv->active_hw_vps[i], timings.pixelclock.typ * 1000);
+
+		dss_vp_prepare(priv, priv->active_hw_vps[i]);
+		dss_vp_enable(priv, priv->active_hw_vps[i], &timings);
 	}
 
-	dss_vp_prepare(priv, 0);
-	dss_vp_enable(priv, 0, &timings);
 	dss_vp_init(priv);
 
 	ret = clk_get_by_name(dev, "fck", &priv->fclk);
diff --git a/drivers/video/tidss/tidss_drv.h b/drivers/video/tidss/tidss_drv.h
index e229d975ff4..3d36b45fc7b 100644
--- a/drivers/video/tidss/tidss_drv.h
+++ b/drivers/video/tidss/tidss_drv.h
@@ -13,9 +13,12 @@
 #define __TIDSS_DRV_H__
 
 #include <media_bus_format.h>
+#include <syscon.h>
+#include <regmap.h>
 
 #define TIDSS_MAX_PORTS 4
 #define TIDSS_MAX_PLANES 4
+#define TIDSS_MAX_OLDI_TXES 2
 
 enum dss_vp_bus_type {
 	DSS_VP_DPI,		/* DPI output */
@@ -24,13 +27,17 @@ enum dss_vp_bus_type {
 	DSS_VP_MAX_BUS_TYPE,
 };
 
-enum dss_oldi_modes {
-	OLDI_MODE_OFF,				/* OLDI turned off / tied off in IP. */
-	OLDI_SINGLE_LINK_SINGLE_MODE,		/* Single Output over OLDI 0. */
-	OLDI_SINGLE_LINK_DUPLICATE_MODE,	/* Duplicate Output over OLDI 0 and 1. */
-	OLDI_DUAL_LINK,				/* Combined Output over OLDI 0 and 1. */
+enum tidss_oldi_link_type {
+	OLDI_MODE_UNSUPPORTED,
+	OLDI_MODE_SINGLE_LINK,
+	OLDI_MODE_CLONE_SINGLE_LINK,
+	OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK,
+	OLDI_MODE_DUAL_LINK,
+	OLDI_MODE_SECONDARY_DUAL_LINK,
 };
 
+enum oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
+
 struct dss_features_scaling {
 	u32 in_width_max_5tap_rgb;
 	u32 in_width_max_3tap_rgb;
@@ -96,25 +103,11 @@ struct dss_features {
 	u32 vid_order[TIDSS_MAX_PLANES];
 };
 
-enum dss_oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
-
 struct dss_bus_format {
 	u32 bus_fmt;
 	u32 data_width;
 	bool is_oldi_fmt;
-	enum dss_oldi_mode_reg_val oldi_mode_reg_val;
-};
-
-static struct dss_bus_format dss_bus_formats[] = {
-	{ MEDIA_BUS_FMT_RGB444_1X12,		12, false, 0 },
-	{ MEDIA_BUS_FMT_RGB565_1X16,		16, false, 0 },
-	{ MEDIA_BUS_FMT_RGB666_1X18,		18, false, 0 },
-	{ MEDIA_BUS_FMT_RGB888_1X24,		24, false, 0 },
-	{ MEDIA_BUS_FMT_RGB101010_1X30,		30, false, 0 },
-	{ MEDIA_BUS_FMT_RGB121212_1X36,		36, false, 0 },
-	{ MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,	18, true, SPWG_18 },
-	{ MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,	24, true, SPWG_24 },
-	{ MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,	24, true, JEIDA_24 },
+	enum oldi_mode_reg_val oldi_mode_reg_val;
 };
 
 struct tidss_drv_priv {
@@ -128,10 +121,15 @@ struct tidss_drv_priv {
 	const struct dss_features *feat;
 	struct clk fclk;
 	struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
-	enum dss_oldi_modes oldi_mode;
+	enum tidss_oldi_link_type oldi_mode;
 	struct dss_bus_format *bus_format;
 	u32 pixel_format;
 	u32 memory_bandwidth_limit;
+	unsigned int num_oldis;
+	struct tidss_oldi *oldis[TIDSS_MAX_OLDI_TXES];
+	u8 active_hw_vps[TIDSS_MAX_PORTS];
+	u8 active_pipelines;
 };
 
+struct tidss_oldi;
 #endif
diff --git a/drivers/video/tidss/tidss_oldi.c b/drivers/video/tidss/tidss_oldi.c
new file mode 100644
index 00000000000..a9beea9cbc8
--- /dev/null
+++ b/drivers/video/tidss/tidss_oldi.c
@@ -0,0 +1,364 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Swamil Jain <s-jain1@ti.com>
+ *
+ * based on the linux tidss_oldi.c, which is
+ *
+ * Copyright (C) 2024 - Texas Instruments Incorporated
+ * Author: Aradhya Bhatia <a-bhatia1@ti.com>
+ */
+
+#include <dm.h>
+#include <malloc.h>
+#include <syscon.h>
+#include <clk.h>
+#include <regmap.h>
+
+#include <dm/ofnode_graph.h>
+#include <dm/ofnode.h>
+#include <dm/device_compat.h>
+
+#include <linux/bug.h>
+
+#include "tidss_oldi.h"
+
+enum tidss_oldi_pixels {
+	OLDI_PIXELS_EVEN = BIT(0),
+	OLDI_PIXELS_ODD = BIT(1),
+};
+
+/**
+ * enum tidss_oldi_dual_link_pixels - Pixel order of an OLDI dual-link connection
+ * @TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS: Even pixels are expected to be generated
+ *    from the first port, odd pixels from the second port
+ * @TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS: Odd pixels are expected to be generated
+ *    from the first port, even pixels from the second port
+ */
+enum tidss_oldi_dual_link_pixels {
+	TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS = 0,
+	TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS = 1,
+};
+
+static int tidss_oldi_get_port_pixels_type(ofnode port_node)
+{
+	bool even_pixels =
+		ofnode_has_property(port_node, "dual-lvds-even-pixels");
+	bool odd_pixels =
+		ofnode_has_property(port_node, "dual-lvds-odd-pixels");
+	return (even_pixels ? OLDI_PIXELS_EVEN : 0) |
+	       (odd_pixels ? OLDI_PIXELS_ODD : 0);
+}
+
+static int tidss_oldi_get_remote_pixels_type(ofnode port_node)
+{
+	ofnode endpoint = ofnode_null();
+	int pixels_type = -EPIPE;
+
+	ofnode_for_each_subnode(endpoint, port_node) {
+		ofnode remote_port;
+		int current_pt;
+
+		if (!ofnode_name_eq(endpoint, "endpoint"))
+			continue;
+
+		remote_port = ofnode_graph_get_remote_port(endpoint);
+		if (!ofnode_valid(remote_port))
+			return -EPIPE;
+
+		current_pt = tidss_oldi_get_port_pixels_type(remote_port);
+		if (pixels_type < 0)
+			pixels_type = current_pt;
+
+		if (!current_pt || pixels_type != current_pt)
+			return -EINVAL;
+	}
+
+	return pixels_type;
+}
+
+int tidss_oldi_get_dual_link_pixel_order(ofnode port1, ofnode port2)
+{
+	int remote_p1_pt, remote_p2_pt;
+
+	if (!ofnode_valid(port1) || !ofnode_valid(port2))
+		return -EINVAL;
+
+	remote_p1_pt = tidss_oldi_get_remote_pixels_type(port1);
+	if (remote_p1_pt < 0)
+		return remote_p1_pt;
+
+	remote_p2_pt = tidss_oldi_get_remote_pixels_type(port2);
+	if (remote_p2_pt < 0)
+		return remote_p2_pt;
+
+	/*
+	 * A valid dual-lVDS bus is found when one remote port is marked with
+	 * "dual-lvds-even-pixels", and the other remote port is marked with
+	 * "dual-lvds-odd-pixels", bail out if the markers are not right.
+	 */
+	if (remote_p1_pt + remote_p2_pt != OLDI_PIXELS_EVEN + OLDI_PIXELS_ODD)
+		return -EINVAL;
+
+	return remote_p1_pt == OLDI_PIXELS_EVEN ?
+		TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS :
+		TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS;
+}
+
+static int get_oldi_mode(ofnode oldi_tx, u32 *companion_instance)
+{
+	ofnode companion;
+	ofnode port0, port1;
+	u32 companion_reg;
+	bool secondary_oldi = false;
+	int pixel_order;
+
+	/*
+	 * Find if the OLDI is paired with another OLDI for combined OLDI
+	 * operation (dual-lvds or clone).
+	 */
+	companion = ofnode_parse_phandle(oldi_tx, "ti,companion-oldi", 0);
+	if (!ofnode_valid(companion))
+		/*
+		 * OLDI TXes in Single Link mode do not have companion
+		 * OLDI TXes and, Secondary OLDI nodes don't need this
+		 * information.
+		 */
+		return OLDI_MODE_SINGLE_LINK;
+
+	if (ofnode_read_u32(companion, "reg", &companion_reg))
+		return OLDI_MODE_UNSUPPORTED;
+
+	if (companion_reg > (TIDSS_MAX_OLDI_TXES - 1))
+		/* Invalid companion OLDI reg value. */
+		return OLDI_MODE_UNSUPPORTED;
+
+	*companion_instance = companion_reg;
+
+	if (ofnode_read_bool(oldi_tx, "ti,secondary-oldi"))
+		secondary_oldi = true;
+
+	/*
+	 * We need to work out if the sink is expecting us to function in
+	 * dual-link mode. We do this by looking at the DT port nodes we are
+	 * connected to, if they are marked as expecting even pixels and
+	 * odd pixels than we need to enable vertical stripe output.
+	 */
+	port0 = ofnode_graph_get_port_by_id(oldi_tx, 1);
+	port1 = ofnode_graph_get_port_by_id(companion, 1);
+	pixel_order = tidss_oldi_get_dual_link_pixel_order(port0, port1);
+	switch (pixel_order) {
+	case -EINVAL:
+		/*
+		 * The dual link properties were not found in at least
+		 * one of the sink nodes. Since 2 OLDI ports are present
+		 * in the DT, it can be safely assumed that the required
+		 * configuration is Clone Mode.
+		 */
+		return (secondary_oldi ? OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK :
+			OLDI_MODE_CLONE_SINGLE_LINK);
+
+	case TIDSS_OLDI_DUAL_LINK_ODD_EVEN_PIXELS:
+		/*
+		 * Primary OLDI can only support "ODD" pixels. So, from its
+		 * perspective, the pixel order has to be ODD-EVEN.
+		 */
+		return (secondary_oldi ? OLDI_MODE_UNSUPPORTED :
+			OLDI_MODE_DUAL_LINK);
+
+	/* Unsupported OLDI Modes */
+	case TIDSS_OLDI_DUAL_LINK_EVEN_ODD_PIXELS:
+		/*
+		 * Secondary OLDI can only support "EVEN" pixels. So, from its
+		 * perspective, the pixel order has to be EVEN-ODD.
+		 */
+		return (secondary_oldi ? OLDI_MODE_SECONDARY_DUAL_LINK :
+			OLDI_MODE_UNSUPPORTED);
+
+	default:
+		return OLDI_MODE_UNSUPPORTED;
+	}
+}
+
+static int get_parent_dss_vp(ofnode oldi_tx, u32 *parent_vp)
+{
+	ofnode ep, dss_port;
+	int ret;
+
+	ep = ofnode_graph_get_endpoint_by_regs(oldi_tx, 0, -1);
+	if (ofnode_valid(ep)) {
+		dss_port = ofnode_graph_get_remote_port(ep);
+		if (!ofnode_valid(dss_port))
+			ret = -ENODEV;
+
+		ret = ofnode_read_u32(dss_port, "reg", parent_vp);
+		if (ret)
+			return -ENODEV;
+		return 0;
+	}
+
+	return -ENODEV;
+}
+
+static int tidss_init_oldi_io_ctrl(struct udevice *dev, struct tidss_oldi *tidss_oldi)
+{
+	struct udevice *syscon;
+	struct regmap *regmap = NULL;
+	int ret = 0;
+
+	ret = uclass_get_device_by_phandle(UCLASS_SYSCON, dev, "ti,am65x-oldi-io-ctrl",
+					   &syscon);
+	if (ret) {
+		debug("unable to find ti,am65x-oldi-io-ctrl syscon device (%d)\n", ret);
+		return ret;
+	}
+
+	/* get grf-reg base address */
+	regmap = syscon_get_regmap(syscon);
+	if (!regmap) {
+		debug("unable to find rockchip grf regmap\n");
+		return -ENODEV;
+	}
+	tidss_oldi->io_ctrl = regmap;
+	return 0;
+}
+
+int tidss_oldi_init(struct udevice *dev)
+{
+	struct tidss_drv_priv *priv = dev_get_priv(dev);
+	u32 parent_vp, oldi_instance, companion_instance;
+	int ret, tidss_oldi_panel_count = 0;
+	enum tidss_oldi_link_type link_type;
+	struct tidss_oldi *tidss_oldi;
+	struct clk *serial;
+	ofnode child;
+	ofnode oldi_parent = ofnode_find_subnode(dev_ofnode(dev), "oldi-transmitters");
+
+	if (!ofnode_valid(oldi_parent))
+		/* Return gracefully */
+		return 0;
+
+	ofnode_for_each_subnode(child, oldi_parent) {
+		priv->oldis[tidss_oldi_panel_count] = NULL;
+
+		ret = get_parent_dss_vp(child, &parent_vp);
+		if (ret == -ENODEV) {
+			/*
+			 * ENODEV means that this particular OLDI node
+			 * is not connected with the DSS, which is not
+			 * a harmful case. There could be another OLDI
+			 * which may still be connected.
+			 * Continue to search for that.
+			 */
+			ret = 0;
+			continue;
+		}
+
+		ret = ofnode_read_u32(child, "reg", &oldi_instance);
+		if (ret) {
+			ret = -ENODEV;
+			break;
+		}
+
+		link_type = get_oldi_mode(child, &companion_instance);
+		if (link_type == OLDI_MODE_UNSUPPORTED) {
+			dev_warn(dev, "OLDI%u: Unsupported OLDI connection.\n", oldi_instance);
+			ret = OLDI_MODE_UNSUPPORTED;
+			/* Return gracefully, no supported OLDI panel found */
+			goto return_err;
+		} else if ((link_type == OLDI_MODE_SECONDARY_CLONE_SINGLE_LINK) ||
+			(link_type == OLDI_MODE_CLONE_SINGLE_LINK)) {
+		/*
+		 * The OLDI driver cannot support OLDI clone mode
+		 * properly at present.
+		 * The clone mode requires 2 working encoder-bridge
+		 * pipelines, generating from the same crtc. The DRM
+		 * framework does not support this at present. If
+		 * there were to be, say, 2 OLDI sink bridges each
+		 * connected to an OLDI TXes, they couldn't both be
+		 * supported simultaneously.
+		 * This driver still has some code pertaining to OLDI
+		 * clone mode configuration in DSS hardware for future,
+		 * when there is a better infrastructure in the DRM
+		 * framework to support 2 encoder-bridge pipelines
+		 * simultaneously.
+		 * Till that time, this driver shall error out if it
+		 * detects a clone mode configuration.
+		 */
+			ret = -EOPNOTSUPP;
+			goto return_err;
+		} else if (link_type == OLDI_MODE_SECONDARY_DUAL_LINK) {
+		/*
+		 * This is the secondary OLDI node, which serves as a
+		 * companion to the primary OLDI, when it is configured
+		 * for the dual-link mode. Since the primary OLDI will
+		 * be a part of bridge chain, no need to put this one
+		 * too. Continue onto the next OLDI node.
+		 */
+			ret = 0;
+			continue;
+		}
+
+		serial = malloc(sizeof(struct clk));
+		ret = clk_get_by_name_nodev(child, "serial", serial);
+		if (ret) {
+			dev_err(dev, "video port %d clock enable error %d\n", parent_vp, ret);
+			free(serial);
+			goto return_err;
+		}
+
+		tidss_oldi = malloc(sizeof(struct tidss_oldi));
+		ret = tidss_init_oldi_io_ctrl(dev, tidss_oldi);
+		if (ret) {
+			debug("tidss could not initialize oldi_io_ctrl\n");
+			free(serial);
+			free(tidss_oldi);
+			goto return_err;
+		}
+
+		tidss_oldi->dev = dev;
+		tidss_oldi->parent_vp = parent_vp;
+		tidss_oldi->oldi_instance = oldi_instance;
+		tidss_oldi->companion_instance = companion_instance;
+		tidss_oldi->link_type = link_type;
+		tidss_oldi->serial = serial;
+		priv->oldis[tidss_oldi_panel_count] = tidss_oldi;
+		priv->oldi_mode = link_type;
+		tidss_oldi_panel_count++;
+	}
+	priv->num_oldis = tidss_oldi_panel_count;
+	ret = 0;
+return_err:
+	return ret;
+}
+
+void dss_oldi_tx_power(struct tidss_drv_priv *priv, bool power)
+{
+	u32 val;
+
+	if (WARN_ON(!priv->oldis[0]->io_ctrl))
+		return;
+
+	if (priv->feat->subrev == DSS_AM625) {
+		if (power) {
+			switch (priv->oldi_mode) {
+			case OLDI_MODE_SINGLE_LINK:
+				/* Power down OLDI TX 1 */
+				val = OLDI1_PWRDN_TX;
+				break;
+			case OLDI_MODE_DUAL_LINK:
+				/* No Power down */
+				val = 0;
+			break;
+			default:
+				/* Power down both the OLDI TXes */
+				val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
+				break;
+			}
+		} else {
+			val = OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX;
+		}
+		regmap_update_bits(priv->oldis[0]->io_ctrl, OLDI_PD_CTRL,
+				   OLDI_BANDGAP_PWR | OLDI0_PWRDN_TX | OLDI1_PWRDN_TX, val);
+	}
+}
diff --git a/drivers/video/tidss/tidss_oldi.h b/drivers/video/tidss/tidss_oldi.h
new file mode 100644
index 00000000000..fe1b2d8c1b9
--- /dev/null
+++ b/drivers/video/tidss/tidss_oldi.h
@@ -0,0 +1,72 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (C) 2025 Texas Instruments Incorporated - https://www.ti.com/
+ * Swamil Jain <s-jain1@ti.com>
+ *
+ * based on the linux tidss_oldi.c, which is
+ *
+ * Copyright (C) 2024 - Texas Instruments Incorporated
+ * Author: Aradhya Bhatia <a-bhatia1@ti.com>
+ */
+
+#ifndef __TIDSS_OLDI_H__
+#define __TIDSS_OLDI_H__
+
+#include <dm/ofnode.h>
+#include <dm/of_access.h>
+
+#include "tidss_drv.h"
+
+/* OLDI PORTS */
+#define OLDI_INPUT_PORT    0
+#define OLDI_OURPUT_PORT   1
+
+/* Control MMR Registers */
+
+/* Register offsets */
+#define OLDI_PD_CTRL            0x100
+#define OLDI_LB_CTRL            0x104
+
+/* Power control bits */
+#define OLDI_PWRDOWN_TX(n)	BIT(n)
+
+/* LVDS Bandgap reference Enable/Disable */
+#define OLDI_PWRDN_BG		BIT(8)
+
+/*
+ * OLDI IO_CTRL register offsets. On AM654 the registers are found
+ * from CTRL_MMR0, there the syscon regmap should map 0x14 bytes from
+ * CTRLMMR0P1_OLDI_DAT0_IO_CTRL to CTRLMMR0P1_OLDI_CLK_IO_CTRL
+ * register range.
+ */
+#define OLDI_DAT0_IO_CTRL			0x00
+#define OLDI_DAT1_IO_CTRL			0x04
+#define OLDI_DAT2_IO_CTRL			0x08
+#define OLDI_DAT3_IO_CTRL			0x0C
+#define OLDI_CLK_IO_CTRL			0x10
+
+/* Only for AM625 OLDI TX */
+#define OLDI_PD_CTRL				0x100
+#define OLDI_LB_CTRL				0x104
+
+#define OLDI_BANDGAP_PWR			BIT(8)
+#define OLDI_PWRDN_TX				BIT(8)
+#define OLDI0_PWRDN_TX				BIT(0)
+#define OLDI1_PWRDN_TX				BIT(1)
+
+struct tidss_oldi {
+	struct udevice *dev;
+
+	enum tidss_oldi_link_type link_type;
+	u32 oldi_instance;
+	u32 companion_instance;
+	u32 parent_vp;
+
+	struct clk *serial;
+	struct regmap *io_ctrl;
+};
+
+int tidss_oldi_init(struct udevice *dev);
+void dss_oldi_tx_power(struct tidss_drv_priv *priv, bool power);
+
+#endif /* __TIDSS_OLDI_H__ */
diff --git a/drivers/video/tidss/tidss_regs.h b/drivers/video/tidss/tidss_regs.h
index 440db8d1c7a..4ee8b330a20 100644
--- a/drivers/video/tidss/tidss_regs.h
+++ b/drivers/video/tidss/tidss_regs.h
@@ -231,27 +231,6 @@ enum dss_common_regs {
 #define DSS_VP_DSS_DMA_THREADSIZE		0x170 /* J721E */
 #define DSS_VP_DSS_DMA_THREADSIZE_STATUS	0x174 /* J721E */
 
-/*
- * OLDI IO_CTRL register offsets. On AM654 the registers are found
- * from CTRL_MMR0, there the syscon regmap should map 0x14 bytes from
- * CTRLMMR0P1_OLDI_DAT0_IO_CTRL to CTRLMMR0P1_OLDI_CLK_IO_CTRL
- * register range.
- */
-#define OLDI_DAT0_IO_CTRL			0x00
-#define OLDI_DAT1_IO_CTRL			0x04
-#define OLDI_DAT2_IO_CTRL			0x08
-#define OLDI_DAT3_IO_CTRL			0x0C
-#define OLDI_CLK_IO_CTRL			0x10
-
-/* Only for AM625 OLDI TX */
-#define OLDI_PD_CTRL				0x100
-#define OLDI_LB_CTRL				0x104
-
-#define OLDI_BANDGAP_PWR			BIT(8)
-#define OLDI_PWRDN_TX				BIT(8)
-#define OLDI0_PWRDN_TX				BIT(0)
-#define OLDI1_PWRDN_TX				BIT(1)
-
 /* Supported plane formats */
 #define DSS_FORMAT_ARGB4444 0x0
 #define DSS_FORMAT_ABGR4444 0x1
