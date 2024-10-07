Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AB7CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 04:46:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B224E889E1;
	Mon,  7 Oct 2024 06:46:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="i+z0nvHI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EAEF7889AA; Mon,  7 Oct 2024 06:46:13 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2418::61f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C7E49889E1
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 06:46:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9BMe652XBc1i/NNa0eUfUTwEctPWqHQqCWGE2eAzmeshP+WeUnzOsis6v5Gk5rRYb+e+8e2+MwufhNEhTpQuBK1p6jSmL2FjnQgtg4NjpPfJ2PRChAYcbcHoMy3Yppo/sy9fB66OfVRFNumziYIioAnI8i7EhsWam9/SjVUSVXM2UkbJwejftz575xkUJjouqVDDvSkxv9CeDXMBJvmsxx+EkGjfDu2RSIXDQdFEA3wAcgLuSHULP4XAm0IiuKrAasH5W/fiHVQPbDKfEtI5NRIUXEBJTHvnjv8byPsTvIQVEBfDtsMRUHqvY89jWd2z6a0kHW2VqU9sP9sliN5eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WGJBvyaGJ8FwEGoTH67IiGTUdugcl9NT8yUXpKOgYc=;
 b=UTXYkAaeM6Ri9GsGJrM7sDenVuQggp5t+nktRobCP7+8NnrYqyPJlWraAgamPEoNH9Y8FlY7ebJIOKMlc3zxKIcdnLBLniJmC/FDduvq7dDcATYU1UbXxvQJyGZjYeGVcxcJxWo9a9OjKHq897Wu9+/PtTlhkxxXMily0/EFZ4Iw8MZ2MvWO8Tr866TWlQTZ5a91H74LLrEacvogTPSZEoyB1MIew28DkYRf/S9mLDvdTrY6CE1lKkWXrwiGQkWof9Atb5r9vVJH2R0E75KdMnyUGQ1bv5uxTE4hLVRwl/Bo2exKVc92+k0yHGCMkK8nA5Zfrq1XQ42UZCxZPXO35Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WGJBvyaGJ8FwEGoTH67IiGTUdugcl9NT8yUXpKOgYc=;
 b=i+z0nvHIQMrCcxui782LrHZNOPNRBeieK3dEUqGYk4EGdfU0oUKjQLBaTq00Qa3C/lla/WXMPOlJaihycEsC6FLlFatYilfpEKgu2ap+xOn4F7Yvnebcdn2mPTILUzd6V7OXpDttlLXIKtvZyXQkbZq1YhaKo0JdUDG4ZW989GE=
Received: from CH5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:610:1f4::11)
 by CY8PR12MB8241.namprd12.prod.outlook.com (2603:10b6:930:76::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 04:46:08 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::4a) by CH5PR04CA0006.outlook.office365.com
 (2603:10b6:610:1f4::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.21 via Frontend
 Transport; Mon, 7 Oct 2024 04:46:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:46:07 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:05 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Oct 2024 23:46:04 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v5 1/7] usb: onboard-hub: Add reset-gpio support
Date: Mon, 7 Oct 2024 10:15:41 +0530
Message-ID: <20241007044547.23896-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|CY8PR12MB8241:EE_
X-MS-Office365-Filtering-Correlation-Id: ece0dc1d-5f3e-4c61-19bd-08dce68af569
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hf6J/S/mgM0kyaLSWAeSTDxONGkzj756UNqbOLcvGBDiIMH9L5zIaT8WPY7u?=
 =?us-ascii?Q?uC2tUzTZBUga47949tutJxAjsUWsRf8I7kvnh1EZNzy/F7XXwmAGQwlKiztz?=
 =?us-ascii?Q?9GUCfJ4L/magLLfJsg4MgQIr5hQ698mU6ni4axbZ91qL9MRqPeEWU111MtdQ?=
 =?us-ascii?Q?Rn7RFNecrMsYRL1BWKFNXGsy4ScQOBbr+hEB9e6KpewRWz2MMO+OUbtes7l2?=
 =?us-ascii?Q?OcvmmWohCJ9tFwpIIAZro4cjY5YD4K8KoCfH4tBBcaM6/XBYqKyBOScYAjEe?=
 =?us-ascii?Q?u4TujH8XTxin98AS4tuqiXGBb3TvUo7DH3kFODCDo19bmgIFpCTgnAZDjOzX?=
 =?us-ascii?Q?f/sBQTJuOo/ZK9KBMatPhgfgy/LRfiPIRoEe9wr7xFXc/i9L2E8RrazfNf2m?=
 =?us-ascii?Q?YmGFRreV90VvKE8x3b8BAQdfWfOlMqitSvJgPdeAi8Mz/iNTSYsqrwJeS07K?=
 =?us-ascii?Q?BPCELg3kIP6zNoGFf3WpcpoO3HpTN+gdj+7BalwcebIT+L9ULXnHnSSxHV9n?=
 =?us-ascii?Q?M+5+3+Qaen/fqHBOaqolFodz8cB5JSfZITbl+SLvOCJZeR1YLFMmYQuSNkdL?=
 =?us-ascii?Q?vZHsADP0TndI8qzOrHmwCzuls7SWGuOjMqegKYqQOumn1QnPcFK/dmCK7C8c?=
 =?us-ascii?Q?eCPGKE7z9EU5nHjZQp9mdAW4VOQdmQmFqAky1uZ+3oQRiX3Ko6Kyz82n+O0s?=
 =?us-ascii?Q?FBTo9AsxWfVVfcTBA27zSyKg/xv6IfETXcRvRDACdxbZ8o7kVZGqCcnfAIHy?=
 =?us-ascii?Q?0KrwaShZ9xDGvRLKWHEOFuB/u/3smcYffkLf9useiWXBSM3xXoodSpfVmxzX?=
 =?us-ascii?Q?Tj4VDLyHEZNMf6lExr4rHvasNpvLlaQpk9S3IDpkHPw+4Dd7pCHkIiOPzSSu?=
 =?us-ascii?Q?iair9E8yY3w3SmctlFRUezrhCLJbgCXewQJPj7v7NkgvWPw/rLkKrATTHyL9?=
 =?us-ascii?Q?2vSO0nymKYRyHGnKAvEbL7YElphigZGPdegoOQ1pUSM/MMKcf1FKVUWzelU0?=
 =?us-ascii?Q?NfAXQQ9yCW/Bq2vn4zeoWci4vHZzT+ySwiIkjH1LPne00x/RTpexQ47IiKFn?=
 =?us-ascii?Q?tFO2Bd5ZwJ7Ok5m27mfbCjJbpZCVQVF9vl8tsEFSza3Y1T76Y4ThDnYAMQ4A?=
 =?us-ascii?Q?0m4LLufdNztjY3QOv/8fKmbISw/uQ9jNu89Grc+SGqbIw+dILiSjaERLzPP+?=
 =?us-ascii?Q?NEtkWc2X9ztBtS+HMJJaMmVkcj3SbdFB564+y5ltYzrvTmmWnTyyeO4//TWd?=
 =?us-ascii?Q?GCD1wVK9MQ2Vq2/Mtctr9UTnFrpIBI7HSWq3NuV7R1Zk2Bpi8VC/Qqap0xX6?=
 =?us-ascii?Q?o3Ml9iWJIsSHF+nxWxXswvhFGeMYhqGcbdmkI3taBRuEKyyHI70vOeEiGdqj?=
 =?us-ascii?Q?uJKi79MFfndEoziP3Vemb5AMu7c5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:46:07.6167 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ece0dc1d-5f3e-4c61-19bd-08dce68af569
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8241
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
 common/usb_onboard_hub.c | 49 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..4317e81ed8 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,14 +7,51 @@
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
 };
 
+struct onboard_hub_data {
+	unsigned long reset_us;
+	unsigned long power_on_delay_us;
+};
+
+int usb_onboard_hub_reset(struct udevice *dev)
+{
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
+	struct onboard_hub *hub = dev_get_priv(dev);
+	int ret;
+
+	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+
+	/* property is optional, don't return error! */
+	if (!hub->reset_gpio)
+		return 0;
+
+	ret = dm_gpio_set_value(hub->reset_gpio, 1);
+	if (ret)
+		return ret;
+
+	udelay(data->reset_us);
+
+	ret = dm_gpio_set_value(hub->reset_gpio, 0);
+	if (ret)
+		return ret;
+
+	udelay(data->power_on_delay_us);
+
+	return 0;
+}
+
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
@@ -30,7 +67,11 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
 
-	return ret;
+	ret = usb_onboard_hub_reset(dev);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -38,6 +79,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

