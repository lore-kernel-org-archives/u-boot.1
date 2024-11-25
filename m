Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB194D3B7D3
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:13:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC9F899F5;
	Mon, 25 Nov 2024 05:13:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rlNjfD5b";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EDBE899F2; Mon, 25 Nov 2024 05:13:39 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E63EC899F9
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:13:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jxwm+lf+gOHfug420Fm2nY9++TAWsHMCNrpDWutBX1PBL6ZVcPRZ4HcC8fzWiqsw5cfb0H1X27kQLCcB9UH7xlDAwIG+LQTRgVxzuqg0IzewKLnGqUiDJ7eQUAFs2fVAK6FHAWR8euB9SNleWhAov7B8ZneU6kAcROFOtdJGU0N8bjRTc+FT0O61w78LgmnSfqIh+VDLGgxUEWRpZjaidB9n7ZI2WiF/bwZeG3Ba6GmEXqGzXp3zJZw/oLTwMWmE+dTpRkTpwf+I1C/v37G8bPzTbSEKMEEDt2ueCN5IAIVji81Bp7WSDdr6GxhkHgDvAKNMMBMcmhwUyfbjNnAzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1Ox8enfA/54VlGHVsAK2AFInuFVCzAYPbL63aKOJU4=;
 b=lVAfK/Gm21MfxNx2a61fmq9+N+CVc8g8wfSXO8crCzFGvo3I0ED7XUD4Dd0UWpC2icNp0yMhvOVFHR+UABXb4bxGnrSuOwcN21CR/IHCKnFF6gwqqktFHHyVcc1pwgxCkKmiTd4wyNdldgKOZognSo3vv6FmaZNQl4dLRJ3kjfD53jnobLhoaUCnaq/IKlpQJats/zgDy/7H2GLu5+wxRB6C2+uXurVTPSGJO2DBpp3n8hgWqlCuAGkYaRJEzDlTkqCH2lVBEj7tIJcHUJHJ2ydnv7DPEE2MVOR0FncMuIF7gaeqo2+ckhbC7qNcJBG9HuKT4oHDt/XXghPpyuondA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1Ox8enfA/54VlGHVsAK2AFInuFVCzAYPbL63aKOJU4=;
 b=rlNjfD5boqmifpIJweOSdSHRSk0lLJv+o4yG/WEE8ICkFoCBv8m1RmW134/gESORLINq6EXxFxDI/pPM+5Trq+7WuYFiErWo/xnZV4KNvRRHnKH/D6JdhSPXNVTaA4rn+hRXu3wHKiIyJAF8+ukFCisSuC8q7G3ycvjp8jG8pkQ=
Received: from MW2PR2101CA0024.namprd21.prod.outlook.com (2603:10b6:302:1::37)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 25 Nov
 2024 04:13:31 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:302:1:cafe::35) by MW2PR2101CA0024.outlook.office365.com
 (2603:10b6:302:1::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.11 via Frontend
 Transport; Mon, 25 Nov 2024 04:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 04:13:30 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:33 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:22 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Nov 2024 22:12:20 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v14 1/5] usb: onboard-hub: Add reset-gpio support
Date: Mon, 25 Nov 2024 09:41:58 +0530
Message-ID: <20241125041202.980-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: b3942f83-a0b5-445b-5097-08dd0d078554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rqR0MpCXiZiPxyy3z2p9OQxJvKI9++TEEHD+5J2ocfhvdn+OjEQXsFjaMOEi?=
 =?us-ascii?Q?vvQCoc7X1yTW5mq+zLm2Vhz5bDOddFz0nuRVbO0JBZwZvVnfaFLvUW7ao3EG?=
 =?us-ascii?Q?fv/C8CjU8eAh+ILcMaan/JjJ4egZTscqjdM/bXDVavXfwX3c8TfKrywYHqdU?=
 =?us-ascii?Q?vku5YnDF/Z1Rqcog9VPwq7JKAB60FBI3+cijcNbNuBSZ8+CeN8SiWQiJa++z?=
 =?us-ascii?Q?WQagEfZMBDivX21fn/3KodLt2vNgp+Ojw2J5s5+d3J9QaaFXFLGDNYyUhwQz?=
 =?us-ascii?Q?YjjF1zb5HUCohv9xeRqCaQVW2uOi2euQSO0SZ1aHhGcFcC6B1PinbHzJBQTI?=
 =?us-ascii?Q?FDEB2LsSrwxamU5djCSLy8ukEreYNeNiq9N36pfU3+A1b1kpx+vGJUjbKStK?=
 =?us-ascii?Q?a3Dzs20qTAV0shxkO2E9RqwcHwOhDFq3f6RP9b+zst2sl8bxW2BHf3x/ikPT?=
 =?us-ascii?Q?NDQuUCksmAxm1Rp4x6Z+8Ea2/3DYSbKgx1I8FJqCnTsS9O7EEEjGDtU7DIRN?=
 =?us-ascii?Q?ExMEAoGeK7TbU4Bwiuf4846j9vbu8oBjMFOIf0rR31giNvpid/TuhgtgWKmD?=
 =?us-ascii?Q?dHaa0dgMqUbqQoARcCjGdN4bx+F6DlJPtQR1b/YzFof11MGYWLrmN/geecX6?=
 =?us-ascii?Q?llfZmsYw+LrehbY+t63TLew8gZJ1/Dey0X0KtWXxg/SMQWOd/zZGMTW/EUU2?=
 =?us-ascii?Q?YtvPjIEyse5bnq/kTjcaTb+XYR/isw7XMm29uX9IcacrQY1MGZDbKtaLxjHc?=
 =?us-ascii?Q?iFs04n03Ihox/8/owP9yRZdwGL7Nh3psuLF7udTF+izmfpz02pj7vYFMTJFO?=
 =?us-ascii?Q?tdvkb02VCQRST1wCMEjE1OLSf72jXtEZcjD18oeBvsWNFyieB1Vt+reT0oGS?=
 =?us-ascii?Q?5NeZWo0aaZf82iGy6aZhdYO1xnBbwpgWPbBTq6W+Was+mAer9EozUnq5Ipz4?=
 =?us-ascii?Q?KXbQtH/+KMKawItkF7Z2ei0/OOtivO12kXEWem9KcU6OjkmGTF+NHo3/x/O/?=
 =?us-ascii?Q?74NhVvsdJAAFb/tuDMrNHnpAXn+nK4N7/YQJVHSOysnOpidFLXfB8FF7H0H7?=
 =?us-ascii?Q?xf+azuFN6spUe1zW9Lv0wrDDE72dldmeMh5Qz08S/WhOdVp4kDTwBsn4huAs?=
 =?us-ascii?Q?v6zCDeNJunjoEQPmITiOurv0BkTz3KUibXDh5JCQl82yBB3xfnu9bcnAGSEd?=
 =?us-ascii?Q?yJmkbeilou7jQJYKpXQyKMcCDpRwFD3XGiuN/N1VBm+jvfobMKmke/YvN0gi?=
 =?us-ascii?Q?RlDI53WM6ews6uJAyVS8fEJGNLheidVX40adcAte3i+7WlJClQwSUQuHCVlx?=
 =?us-ascii?Q?x/p09TeVIrOojWnc6+Yt9Zu2YCTg9KtsL9/4Y2UW9anO7reKkfBooDEjnFrE?=
 =?us-ascii?Q?ibgwz2ZIOkBUVLDz/Qzrw1F/8TSvIGTFbYj3e7UXp0Izg07uM0NYbV1wlgzc?=
 =?us-ascii?Q?GTN5g3UowlMHMVfwRKT70u4OrOmQAmkf?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 04:13:30.7743 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3942f83-a0b5-445b-5097-08dd0d078554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008
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
Update the usb2514 hub_data with the reset delay and power on
delay values.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 51 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 48 insertions(+), 3 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..e4d1f12cb4 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,14 +7,50 @@
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
+	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_IS_OUT);
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
@@ -30,7 +66,7 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
 
-	return ret;
+	return usb_onboard_hub_reset(dev);
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -38,6 +74,9 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
+	if (hub->reset_gpio)
+		dm_gpio_free(hub->reset_gpio->dev, hub->reset_gpio);
+
 	ret = regulator_set_enable_if_allowed(hub->vdd, false);
 	if (ret)
 		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
@@ -45,10 +84,16 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	return ret;
 }
 
+static const struct onboard_hub_data usb2514_data = {
+	.power_on_delay_us = 500,
+	.reset_us = 1,
+};
+
 static const struct udevice_id usb_onboard_hub_ids[] = {
 	/* Use generic usbVID,PID dt-bindings (usb-device.yaml) */
-	{ .compatible = "usb424,2514" }, /* USB2514B USB 2.0 */
-	{ }
+	{	.compatible = "usb424,2514",	/* USB2514B USB 2.0 */
+		.data = (ulong)&usb2514_data,
+	}
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {
-- 
2.25.1

