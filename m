Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F374CF855A
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 06:29:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2917489207;
	Thu,  3 Oct 2024 08:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BIW1t4Wm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4DB07891BF; Thu,  3 Oct 2024 08:29:09 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20616.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::616])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21E8E891C3
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:29:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wkh3ZEfUTURdKvHQHt1t23drZM/mw1FcEH/2ZFqqD1rbBaa21uh8nCg9sHbP88IVWyV1SL0oV2Pis9stXmZsd7ftHX4U+xFjjwmqx99+JXca2gty6Lh+KqG68hXYFbh+TGSAf4VcbW2xYfNr/fnPjq7OhVgGLUp5amk0Qv3Ls+j49tdqbN4e2ccVidotjjLZsUEycc10/BVV79gOCITeSQb9KDhqWKtudKNYYH9vN8XyPgT12t5C3h5gIqxjxMSskD6fsW3E3qh3nLZMmMYQ8OxLVnZDnDeoAqILuwwEugidDEngSwA8ezHiEIq7nm2Up86EdmQNIlt2BzvG5AvEWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl54GhIgD39uolGAVeCkn4WngOJsurBYgOirGM98zTY=;
 b=wuX+iVWawrqMt2rWiCAPFqZ9+DBlLX3f4UW3E7Z0d3pbTauTbXEV6+9KbOWoiryRVNRQR7alqK8YTIYfOFyjcUwbfGOGIkRIHD+Z2i9OsvtjgRmEPmc49jSNjlHYekGtqYpIyZz5yFI7fmWAPzEZDelTfRZ/fNt0jGAiYHvWYOHEQ3VbHtUJQo2Lp8Vk5ILOnABrxgVHnRIhbDej7TORnLv7ScMgeQJitjDTyIksX0tdIam3z6M1rnMO5vxp5Tm2aEdd5R5jDDy9pw67NlAB416Tsi/Y7/D3L23oBRjSMvULUDnTTolE79bN6H/WFaoDsvroOJa0XEIVhjdCeqG7WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl54GhIgD39uolGAVeCkn4WngOJsurBYgOirGM98zTY=;
 b=BIW1t4Wm6HT03Ze7uqqs4noChn8bMUO/ck+30+wbOsQ7KRU4ARUonU9arXy/pdg5J4n6C2lggDNmjJ27iklpgpzCxCu+eiGA949mpU4Vi28boFHxcN660HpId4eNp0Ts2VMuZG+7c3t0cHaBCC22CP/4vDDszJxlWT3h7idbAR8=
Received: from BN1PR13CA0006.namprd13.prod.outlook.com (2603:10b6:408:e2::11)
 by SJ0PR12MB7476.namprd12.prod.outlook.com (2603:10b6:a03:48d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 06:29:00 +0000
Received: from BN3PEPF0000B372.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::48) by BN1PR13CA0006.outlook.office365.com
 (2603:10b6:408:e2::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.9 via Frontend
 Transport; Thu, 3 Oct 2024 06:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN3PEPF0000B372.mail.protection.outlook.com (10.167.243.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Thu, 3 Oct 2024 06:28:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:28:59 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:28:54 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 01:28:53 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v4 1/7] usb: onboard-hub: Add reset-gpio support
Date: Thu, 3 Oct 2024 11:58:38 +0530
Message-ID: <20241003062844.15338-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
References: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B372:EE_|SJ0PR12MB7476:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a6a8644-c935-45c8-e311-08dce374aa82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wVmD0/L8PdEG2TIwWv83RtuiYhdgySrVKeKIi3LiE1iYKHVq7sSZXhbePtnI?=
 =?us-ascii?Q?8V6qYkzx3d4KaWorumliB6Nc4yNvrbjvj3IIFZi3i2gn+iFL3yZmrHsnc4z3?=
 =?us-ascii?Q?kfTNXVw3hnDwK0s8q8v8swdfQTbnPoJb+jVwnSsZrfs9QR62+AlBc210cogf?=
 =?us-ascii?Q?CE6luD+ku/ZNAZqarfRoqakq0YWI/frpMfwYnJ2ygOtD7XESvIknr9JiTNUI?=
 =?us-ascii?Q?jLv4lD/kk2MHnuu+EKGx1cYpHiz2fgldKtE2+cZreKnmcD/esoFAJJ7cFwmn?=
 =?us-ascii?Q?GrxkkE2DsjdsmIsGlac6mgpNirgcIT37hH1uDraulF8kLg+c5hNiPbhwmJcH?=
 =?us-ascii?Q?UO3BKRwXyG0qr0tc0wkV1WF5TgZkCo/p5aV/XvAOKyDe3kgKqWWYzaWxHRv/?=
 =?us-ascii?Q?3fk3oYloTdYz/ePhqsOAmSJe6FEBx7myeem9LG3XtNmWMCztjtAqkXqNeL9v?=
 =?us-ascii?Q?LmyGu0n4sdzOn7bX9JX9QjQbkFXHSe0Ygeg9RFsVl8fWoc9bupKpkRIBwxIX?=
 =?us-ascii?Q?DlGSdP3ABgNeli6iI2ungZdqwzbeJZLtFhO2N8l33LFoXlebJBaFi88hLNKr?=
 =?us-ascii?Q?PwkSTg4l2FFy0Y28iAKMzyuOcm9+/0JkxZihOi+Ch6S0WrD8e0ZKMdeNsRDo?=
 =?us-ascii?Q?EpIFve3vvbaySVa6XJjK6v5lSkknvLgRNstLV8lhn6BvjbJmXsoxUKB5Ub6w?=
 =?us-ascii?Q?PrpJIsfLAgIBwzA/7K9XkIb8LW3M9KUoG36VKreguH6kxKnutYfGGL3ym0Oj?=
 =?us-ascii?Q?/AcL+hgespDrQcEhF/u59yXyfcq4/5sXXG/SDyLYOZgON/LYaFb3PSvLqZ93?=
 =?us-ascii?Q?2SWZiSdbF7ge+3uOY0kanOb+VRZKACcJv1XQm1w9GbO38wCb30qzWtFaz2nJ?=
 =?us-ascii?Q?6/SvY6eXQNJfMIQ5al87cdQ6QjqEJbzpE6tRCavz+8/qAwtgkCe8p4NX/AHN?=
 =?us-ascii?Q?Q/IquMf+B4pdbEQhSv1/iKBAQm5/EDOQsM6p1MIw1pdxnv5zqYkV4RizWT8j?=
 =?us-ascii?Q?agASJferRLqJTzVmXmGMGPyJ1iIUz44Khp4k8c1sBCWdK2WmzOkVDCtGGQok?=
 =?us-ascii?Q?kqOlBwPd/NV2Uo1ElMWgVe5ewRGSenjKxMWwIVAvOaX6JyUyVCQpBf6/goas?=
 =?us-ascii?Q?3x1+1JQ5B89jXCsIJOSRE36GDa5ccNuAfzaRbmgl5p8aCqiaCovsatshWstJ?=
 =?us-ascii?Q?lxsbP68U1uL2R6r4R1aG1AgOo7Rrk3uA1SpcUhtnFgfEp9iUMPTjgDlH52Tn?=
 =?us-ascii?Q?BIfHZxoh43j8nxIp//UTG/sDzPyMR1tpRvGufldzljowlh2pJIj1qzgLw61S?=
 =?us-ascii?Q?K5qqApb90SOvO3sQOplidNIt+h5LR6IetehoVevbpIl8xHRLngnkOZZbMh3C?=
 =?us-ascii?Q?t1xLL10U5hotcigqz0z3yEsa04yL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:28:59.5402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a6a8644-c935-45c8-e311-08dce374aa82
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B372.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7476
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

As part of the reset, sets the direction of the pin to output before
toggling the pin. Delay of millisecond is added in between low and
high to meet the setup and hold time requirement of the reset.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..9ecc638c7a 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,16 +7,26 @@
  * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
  */
 
+#include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <linux/delay.h>
 #include <power/regulator.h>
 
 struct onboard_hub {
 	struct udevice *vdd;
+	struct gpio_desc *reset_gpio;
+};
+
+struct onboard_hub_data {
+	unsigned long reset_us;
+	unsigned long power_on_delay_us;
 };
 
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
@@ -30,7 +40,24 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
 
-	return ret;
+	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	/* property is optional, don't return error! */
+	if (hub->reset_gpio) {
+		ret = dm_gpio_set_value(hub->reset_gpio, 1);
+		if (ret)
+			return ret;
+
+		udelay(data->reset_us);
+
+		ret = dm_gpio_set_value(hub->reset_gpio, 0);
+		if (ret)
+			return ret;
+
+		udelay(data->power_on_delay_us);
+	}
+
+	return 0;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -38,6 +65,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
+	if (hub->reset_gpio) {
+		struct gpio_desc *hub_reset_gpio = hub->reset_gpio;
+
+		dm_gpio_free(hub_reset_gpio->dev, hub_reset_gpio);
+	}
+
 	ret = regulator_set_enable_if_allowed(hub->vdd, false);
 	if (ret)
 		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
-- 
2.17.1

