Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9230CD13570
	for <u-boot@archiver.kernel.org>; Mon, 28 Oct 2024 09:24:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCCA58905F;
	Mon, 28 Oct 2024 10:24:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mvFg7hqM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7112A8905F; Mon, 28 Oct 2024 10:24:51 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E17D788A24
 for <u-boot@lists.denx.de>; Mon, 28 Oct 2024 10:24:46 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zNPe00LABNUsLj4ZS3S1a9/EIhk8Kjvb8EC+XWZFR3lyQLMgxNj5oqJChXnAS2HuK8L9nQPQ+kww9muPnffxGo4dolWKfv14ZqpVbUkJSPo08KeEaEiLemXtJK4Gdo6qXxg1daXZzSZmSROQ3WmZk06qLcd9gBE1pphKhE01Dit1MeheN9HOyzaDgdgmykqhY6aFQbKc/gUXgh2ds3zSgXgjDZ0AGTLTFRaNpgQbf+7zmEqxiUoE/mLRQmhDdwgRuupVgaI42PC+uCS9S913xRVaz1GoM/j3GriIQLnf9+N/dQlEupsLPiqH1s6EIZwiIsg2vLnmL3TxEuNZbLRb4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iTyGE8GkEQs9swfmD3E5jQUVx6kfZ9B4guvq6rpTM4=;
 b=prR0eTD7hpm44V0pzo9Qdzgiw8N2ume1wgkQeoks+x77OxwblMzV9G+1X/KoiZtrHBHbY/PLr8iEy1bfUgtcENEl/XbrNTjxgLmzSU15hQO0f4Or12a4jPlpl11k2y1FVQTTDO2J20EuCDD6umG4VJ2GKKY0Nuxwt9FMasabE9An6h5FSmwZXYTlsBzeeqoOHgE0R2QW4mUXh1FhhU/r1N10/RpyfP8eMO9Z1TC6TrEACMA2XVM3aHlkSpYBQGtz9E0kdS7Vqzbyw23OmhiSec2/XRqGPR7y0iCJAqbjvOhtijxttTECaUwh7UIgVvUTUwI5LOqgza7ONunviH+c2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iTyGE8GkEQs9swfmD3E5jQUVx6kfZ9B4guvq6rpTM4=;
 b=mvFg7hqMxuVRWrymATjbPqweq8v5X4ZsyRX7s3fF85aovYMc0WsnSaZ2nCBe1kpfXmuW4p3utI2vvCyXWCEKGqtrzwmEKjdA5by8pSDRplGbBE9KBgkGU3NFjv5k3tMa7t+012b5MQ9vnYZmpID1uXjZ0cPMXAgeu7MV0ioYk7o=
Received: from CH2PR12CA0029.namprd12.prod.outlook.com (2603:10b6:610:57::39)
 by PH0PR12MB7469.namprd12.prod.outlook.com (2603:10b6:510:1e9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:24:42 +0000
Received: from CH1PEPF0000A346.namprd04.prod.outlook.com
 (2603:10b6:610:57:cafe::82) by CH2PR12CA0029.outlook.office365.com
 (2603:10b6:610:57::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25 via Frontend
 Transport; Mon, 28 Oct 2024 09:24:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A346.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:24:41 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:24:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:24:40 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 28 Oct 2024 04:24:37 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <jagan@amarulasolutions.com>, <vigneshr@ti.com>,
 <u-kumar1@ti.com>, <trini@konsulko.com>, <seanga2@gmail.com>,
 <caleb.connolly@linaro.org>, <sjg@chromium.org>,
 <william.zhang@broadcom.com>, <stefan_b@posteo.net>, <git@amd.com>
Subject: [PATCH] cadence_qspi: Refactor the flash reset functionality
Date: Mon, 28 Oct 2024 14:54:30 +0530
Message-ID: <20241028092430.19841-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A346:EE_|PH0PR12MB7469:EE_
X-MS-Office365-Filtering-Correlation-Id: 95d4c435-2c4b-4265-3e4f-08dcf7325aa2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ltk6gg/7wOUPglKJROPeiQDOAT/ziOmYwxIMvlsZZsWDn+AgOrVghObRtOie?=
 =?us-ascii?Q?ghYyh8ny09yvIsaLoC5k3aLytMPML99w+JUSwANySi4uAOMVEKiy0sozFvER?=
 =?us-ascii?Q?fkj8Byxtg3OdKkFA7l4P3wl8Ex9X0BBYtRRfFkaE6ovN0avkVUQh5aehpWTZ?=
 =?us-ascii?Q?73yx3zIB/X0bPK90WB2ZDCo+Bkd+SNn66v6JDluR+Lm3B5jzuXQBujJs77QN?=
 =?us-ascii?Q?jO+9D4gUSXBRU+YOZg6Kzs1PIeTgXZvQ2YZJ8OBmA4wzyJ86jM7rXOxTOoFX?=
 =?us-ascii?Q?U1kD6KrjjTsJm1fIuJJhYOzgVZIzOysK6eeQKw4s1nQbL40RpEKGiipv0Hz+?=
 =?us-ascii?Q?t54o+Pq6CbY9egv0dNQSwIGyYr7yanf2JqwvYYFqHpW1OEE4+wU8JjUdCEgy?=
 =?us-ascii?Q?rSwuf0cQo7Huv1XWDUmsWk3fVCak2llW20PrCSafAnBePQq9n2kzD3BdBBa5?=
 =?us-ascii?Q?WgmFLgKtifDy/BzS3zVwq+qC3gm6u7ox023cOdP3rtiVPFEk8ZULbHXLzNsC?=
 =?us-ascii?Q?alVIfYGtudBaJvV9IWJ9poOPyOZMPZ9BECKioRg13F0QCN+R8q7zuqI8rHax?=
 =?us-ascii?Q?T/KGPncUnI3CpyHcoa2FS1/w0aUOJwcEwd3b+lyNLjOfSL8xsXbS0JzJy/Un?=
 =?us-ascii?Q?V9OKdes/g1IOHIPdqLKTPAUCiO9r4bdFk4TDkYvQZYMmqWl1XY8+1c81hI4q?=
 =?us-ascii?Q?dEbuEHJb1f0nHPvnTES/U6/uPXaiGxEZY1Qsufd5SVldRSAVM4F3Rn4nFf3G?=
 =?us-ascii?Q?Rm9SouBnBJImlmM2bRvVBPd1/GCUvC87PlB8ISA087Dz1bA/RE2Am07pFFOP?=
 =?us-ascii?Q?xtYrsJz9Znp5ftB8ie5bz/yxzupiX2MEpUBBkof4uxGDBMfDQTZi7jfGVe5N?=
 =?us-ascii?Q?kfBIlfkkYSILzEpCQaxJ96l8m9DJprBRdeFo5yAvmV6p019i3LGVK/2BILxH?=
 =?us-ascii?Q?NrkAsGvNHyM83lHY4HkOh6uwqSZ+BdrYIs212wn1JuSpVrq43KPdivcnE0nW?=
 =?us-ascii?Q?H+DEez2Trf8CKwqrNJDXC0+GELjiWkxnHakTfMia2CBPr+ogXX33KPyh1aga?=
 =?us-ascii?Q?oE3fPdjngZPDXaIq9zisaWlrObnELntHe9ywpX7+OIc7o7xZ/CNOx1+zkrEr?=
 =?us-ascii?Q?YbAqRIJWEyPX3Z85xku3O8L75chSJUgYbQEf7ZtA0wIlPLk3dOXdFxSbQstH?=
 =?us-ascii?Q?5d7LqzqCNLr760B+/KSxRQWuGG9bnR85gZ+sm7yIbSHUvn7gOPlG9/dYDXf4?=
 =?us-ascii?Q?5kl7ZKmj5DNE5GW260fXydMHUzRaXwzGENwj+AcgH7pG4Mi7xeeqVXd32gjN?=
 =?us-ascii?Q?h1qkYbTzKESryG5R5gGCG2vtFHwc/lRuAWxq1Ny09pJB7N0Qeho6QKao93vf?=
 =?us-ascii?Q?hSzbq8LTFzC82VQ5LDYKib8RJ4S+xZ4hHFwCbP5YhoyzUpZ1iw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:24:41.9994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95d4c435-2c4b-4265-3e4f-08dcf7325aa2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A346.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7469
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

As the flash reset is handled in spi nor core, removing the
flash reset functionality. As the configuration like tristate
and hysterisis need to be enabled by the cdo. Handle the flash
reset only for mini u-boot case.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 drivers/spi/cadence_ospi_versal.c | 43 -------------------------------
 drivers/spi/cadence_qspi.c        |  7 +++--
 2 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/cadence_ospi_versal.c b/drivers/spi/cadence_ospi_versal.c
index 222f828f54..de51e4c37f 100644
--- a/drivers/spi/cadence_ospi_versal.c
+++ b/drivers/spi/cadence_ospi_versal.c
@@ -125,48 +125,6 @@ int cadence_qspi_apb_wait_for_dma_cmplt(struct cadence_spi_priv *priv)
 	return 0;
 }
 
-#if defined(CONFIG_DM_GPIO)
-int cadence_qspi_versal_flash_reset(struct udevice *dev)
-{
-	struct gpio_desc gpio;
-	u32 reset_gpio;
-	int ret;
-
-	/* request gpio and set direction as output set to 1 */
-	ret = gpio_request_by_name(dev, "reset-gpios", 0, &gpio,
-				   GPIOD_IS_OUT | GPIOD_IS_OUT_ACTIVE);
-	if (ret) {
-		printf("%s: unable to reset ospi flash device", __func__);
-		return ret;
-	}
-
-	reset_gpio = PMIO_NODE_ID_BASE + gpio.offset;
-
-	/* Request for pin */
-	xilinx_pm_request(PM_PINCTRL_REQUEST, reset_gpio, 0, 0, 0, NULL);
-
-	/* Enable hysteresis in cmos receiver */
-	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
-			  PM_PINCTRL_CONFIG_SCHMITT_CMOS,
-			  PM_PINCTRL_INPUT_TYPE_SCHMITT, 0, NULL);
-
-	/* Disable Tri-state */
-	xilinx_pm_request(PM_PINCTRL_CONFIG_PARAM_SET, reset_gpio,
-			  PM_PINCTRL_CONFIG_TRI_STATE,
-			  PM_PINCTRL_TRI_STATE_DISABLE, 0, NULL);
-	udelay(1);
-
-	/* Set value 0 to pin */
-	dm_gpio_set_value(&gpio, 0);
-	udelay(1);
-
-	/* Set value 1 to pin */
-	dm_gpio_set_value(&gpio, 1);
-	udelay(1);
-
-	return 0;
-}
-#else
 int cadence_qspi_versal_flash_reset(struct udevice *dev)
 {
 	/* CRP WPROT */
@@ -209,7 +167,6 @@ int cadence_qspi_versal_flash_reset(struct udevice *dev)
 
 	return 0;
 }
-#endif
 
 void cadence_qspi_apb_enable_linear_mode(bool enable)
 {
diff --git a/drivers/spi/cadence_qspi.c b/drivers/spi/cadence_qspi.c
index 9c466f8695..f8c3fe8428 100644
--- a/drivers/spi/cadence_qspi.c
+++ b/drivers/spi/cadence_qspi.c
@@ -258,8 +258,11 @@ static int cadence_spi_probe(struct udevice *bus)
 		if (priv->read_delay >= 0)
 			priv->read_delay = -1;
 
-	/* Reset ospi flash device */
-	return cadence_qspi_versal_flash_reset(bus);
+	if (!CONFIG_IS_ENABLED(DM_GPIO))
+		/* Reset ospi flash device */
+		return cadence_qspi_versal_flash_reset(bus);
+
+	return 0;
 }
 
 static int cadence_spi_remove(struct udevice *dev)
-- 
2.17.1

