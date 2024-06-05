Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30659C27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:02:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C680B8837D;
	Wed,  5 Jun 2024 12:02:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="xbwLQgG6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 719E688252; Wed,  5 Jun 2024 12:02:39 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20627.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::627])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 57B2688315
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBt2yTVq7NiNFpN42ZV0S6RKgbFbSZX8N/6WFTLlm/rRClOwMwfh61zd6HzJ0A49TFTgywqO4rR+wlsPIV//pYszcz/fFoIC+oAlM4ZFok0Af8WP8EfdduwGepNNpGLXyfAFpe4UJ+zyRidYlx3T8rcghcBIqJPo3zw728du14TDTo3/SWrHXlCGzkTRtWx8aeuLvcTek3W7t2tiFQ7MikbqJJYtG+gpezfZPGEN/UZffb0KzNPRY4sTwwOijFPs+0V+lItIg0Zaaz0VxMs4xm4IXJ8bN+G2824Bmqg5BmySkW2bvF3j2lacGZJRP2NSJIOnibfMgP/pCXGPjeJTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO0Idt3xxU4CrEo/SYvg0GgOAFC8r2KIu9K5trax6tE=;
 b=j6GZXXqN3zKd8/BxDj28Rgr/bP+4zAvtWqTjiqLVs1miQLhQb1jfGIbVfzvY/W+6qfMt9iCF+0sDBQRL4nlVkUqQ6dkhuWYH20IpBqe8QtZXWpirPCLZ6ZCK7/6RfjiTEAsmmQtB6LXzn9K4ZlUHSOpSR/tWM51Hh+eu7xbxCC1oTj3MiSgFic2vtusQEyPcZYiSSW9Da0aSeSnVVah4RMXZ1E2EwqK9jeWO2ItoFxAfw27wTZ5n/inzJby3y0tBuSXnAT9gNSVSXCla9bffq2mUi1m98j81qqK2I/hb8TCDvSWZRir/F0kC4rQXpKA3RcA8WrdQIynoRC/xJSj+2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO0Idt3xxU4CrEo/SYvg0GgOAFC8r2KIu9K5trax6tE=;
 b=xbwLQgG6//amLxfHBPIwqw+f8k4KI1A4XPb4T7ExNo3aVLcVjWe1+7G3e2ZhOdjV8D48C97GkvTRg6YnN7fbl4CtxGtwm8++94LHOtqWOPm2m/p1hk4023pBjhW4iXNDIMdrfD7d4N2o9LeRUNsTw/iRYPI2CCFMXc1Kt11geaA=
Received: from DS7PR03CA0196.namprd03.prod.outlook.com (2603:10b6:5:3b6::21)
 by SN7PR12MB7883.namprd12.prod.outlook.com (2603:10b6:806:32b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Wed, 5 Jun
 2024 10:02:33 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:5:3b6:cafe::cb) by DS7PR03CA0196.outlook.office365.com
 (2603:10b6:5:3b6::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:33 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:32 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:32 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:30 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 1/7] usb: onboard-hub: Add reset-gpio support
Date: Wed, 5 Jun 2024 15:32:15 +0530
Message-ID: <20240605100221.3571-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|SN7PR12MB7883:EE_
X-MS-Office365-Filtering-Correlation-Id: 92b4f91b-5961-4533-66e9-08dc85469e96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|36860700004|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zHmK6D4fSMVBh+0z7eBJYhMAUmWgISRq9QsAuLi3CqQQfnFLLeeQUzXRhL5S?=
 =?us-ascii?Q?/jodiqyRpLOsi8EcAc1vMHvJOzU096APf+BAJGwFuVOTFMs1MPqWlSNPCpSh?=
 =?us-ascii?Q?VAU4MNnztOhE2RMLASrms8oCtOE7TFMDilCaelcwKO/fie1imqsPiyvSA7F9?=
 =?us-ascii?Q?niyvGdPCFIlTl4lGUhjYyatzwc28EcKUf4sSYYHS1mq/Mw6OPdoF/VOmuOS3?=
 =?us-ascii?Q?NVICQD87zi/dj1HcN4F4SC0BylB7Es0CR1tL9ji/ip2mv/rptAuuoLbAFhxI?=
 =?us-ascii?Q?lHmcOWkmz/yFKATXX90Q3LHXskZsNnITrDiT3WHTUwgFLwpeSIroXx4ljGBQ?=
 =?us-ascii?Q?18wvTZoL3fDQQtP4pMaiE0sTfwkgMssZaM0R+Cy3W9j8ZUq/ZytmfF4QTL5E?=
 =?us-ascii?Q?RVVbj7bF8ek5Qk7++Oa8NQv8BWix7qTkYO+wsh8+NAGI3e9J11DBI5UkTW3V?=
 =?us-ascii?Q?kKgYkZQA8tC1OcbumYAbKsdCr9YWYLOvtb19gL5DMm5nUs/MPgD3cdGD+EDc?=
 =?us-ascii?Q?3SrQM7ZsVgnG/Rg37d9K8U5F64FYKOxcVwmhlXNp+dMycu3lFtQelEiogUCG?=
 =?us-ascii?Q?K8qCYpn5neZ61BLKYu5k0HIpCoij98WD51cT9Ua38G4nWrT4M3QEMHHpNNhi?=
 =?us-ascii?Q?/oNYyvHpM2H00FGr2niMhSEjPnvyIITw+0JJZsytRjoG8j6zxUZHw8qY39WI?=
 =?us-ascii?Q?IcbSq4f6LLPHPl1oQuDwyfzM4cwQGxPi+Bj5IV1TanWpevyA0gHi+H1pSv01?=
 =?us-ascii?Q?Xs7/voGEXu5mDPokuhwjHLceUAHmuAyNQsQg+vzm8Oy88QWuGei4Go7cum1Z?=
 =?us-ascii?Q?QbuHhDCZ6gxSyE5rPNQBJ0MMYbVwvtJpPOqRWqMT6bkr6Bqj//4Z2YQOfKAP?=
 =?us-ascii?Q?86kVSIyIASrtiJsLryKbEUj1G67Z9Q3H7JNb+lfzC6YqFkwMjtmWmstSQgT+?=
 =?us-ascii?Q?FlGOX3Dp2xyIJybp3ETrQPWFWDdxabsegimcRRkBZnED1J+4+54ZA4N7k+JI?=
 =?us-ascii?Q?kmy3Hm89XbGLhHtvVNmdRABQVSAZd898TZIT1eeWijxvNyx0pcn2SWWB2SFc?=
 =?us-ascii?Q?XHOfV1D/SlYE8/V3IyFYiFfHzow/nbRwdH99g9AVyWp9ywauKVfGDToP1DeO?=
 =?us-ascii?Q?filwd/LpFue/Zb9crJ2g/5zDFVnKfh433tsAVcmhaMpRd41X6ec8Yly2BL7g?=
 =?us-ascii?Q?1HZorh334nxEVy7cZe2UViNC0nVJMfqM0OKL9KPc/up27WGsFyugqiHbjZ+a?=
 =?us-ascii?Q?i8Pzr71qTIPtYXhBl0sNfyhpATnwp36o8LpymnjG6wkZKhrhKiNnVZX7UCAi?=
 =?us-ascii?Q?D2lWV5t+uB/0OgMElRM8ijNsWJe4RZs5TsxkijinOQYlXAdrmEc+STb8jKVj?=
 =?us-ascii?Q?Rr5/rUz9g7u8BMcec1ONoEHZvausOkGrsVmn0s7YGNwv1/nPwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(36860700004)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:33.3692 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92b4f91b-5961-4533-66e9-08dc85469e96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7883
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
 common/usb_onboard_hub.c | 44 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 89e18a2ddad..2f6fb71935d 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,17 +7,26 @@
  * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
  */
 
+#include <asm/gpio.h>
 #include <common.h>
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
 };
 
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
@@ -31,7 +40,24 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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
+		udelay(data->reset_us);
+	}
+
+	return 0;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -39,6 +65,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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
@@ -46,10 +78,16 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data usb2514_data = {
+	/* TBD */
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
-	{ }
+	{
+		.compatible = "usb424,2514", /* USB2514B USB 2.0 */
+		.data = (ulong)&usb2514_data,
+	}
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {
-- 
2.17.1

