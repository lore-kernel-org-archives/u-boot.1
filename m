Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3384D5E129
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 04:04:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38A7288F4A;
	Fri,  8 Nov 2024 05:04:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bBQq9F2J";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3779488E63; Fri,  8 Nov 2024 05:04:03 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::610])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7410E88EC6
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 05:03:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMz5YWLQ+GhpkcKMZYDvj6IAKuELFXtF49Lx1n4dc/3EWTPEY7iV/UkM4wKOtLWgm4F/rz1qnvwyBoOsJ6GfxRUdbVwGJMB64H1Tz/RA9wX74vebQ4IVYG3grcy4HCGlU5LrElNbG51aYv5OHoTaifjp9UqzdEcWUbDjNHAO6SRo2hY8426R3KJVltDzE5vsnjAYOX2OZOaK7yWY38gONJjNgSqxFzSAiaNPdkZ4leXokAv8dIgUaY1FrBPYzVcVMywvFMAA6Qpv3kGIm4ff7AlzmIxpUfhMu3nYMd5Zo/702//uyUTpWwqt8SqSLCQi+1oW89WStj/ZMLzDTZeyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1szPMcWraebpb1rXX6KKfmqS2n1sWKjIM1r0BJvYa0=;
 b=bbP9SgFdOhqxuqXFHjaQLepuMf9zHtZNxNrEwslK53byGiXCsgP8MYgRuCXzFAPy+6J9fpuhZ+DOrCImNu+LiJH+CI+loBb/UTlBZ0uLvxcQwElLTitHsO2xajQJXVTIQ6+pNtI+yxnEy0OrqsTgaURaf8CCxnkd37DIgDZQTGeHWhu/EMd4gmHvAkfnf3T5XF2w0TsLuDx9v83dTF+FrdP5XLOkZvKUrXlMhAZ/KqhvgdhBmylwjfP85aQZld3vfnWRWKkOLM3YMsYPz280zskyW9bd0aKdWpT6sBksCv97x4UyxE2D5UnEEVxhkTUoPfZlKIVPoeK4vfEoThIQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1szPMcWraebpb1rXX6KKfmqS2n1sWKjIM1r0BJvYa0=;
 b=bBQq9F2JWk/xoRgYezYfzOJfVjRSLhDU9ugR3FH/ksXcC2X0khwrVg7lKIDHPhbVT9nZR9/C8w1HPCKjcHLhEDdf3WOAMO/QHDGqTBfZA6gOFBosMMqVtEXdREfc/pjM6Y3VK/HkzXqYLCgdV5e/feuWTTbTykML23uk0qPtlsg=
Received: from BN9PR03CA0957.namprd03.prod.outlook.com (2603:10b6:408:108::32)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 04:03:56 +0000
Received: from BN2PEPF00004FC0.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::32) by BN9PR03CA0957.outlook.office365.com
 (2603:10b6:408:108::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Fri, 8 Nov 2024 04:03:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FC0.mail.protection.outlook.com (10.167.243.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:03:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:01:20 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:00:10 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:00:08 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v10 1/7] usb: onboard-hub: Add reset-gpio support
Date: Fri, 8 Nov 2024 09:29:53 +0530
Message-ID: <20241108035959.19970-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FC0:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 414a49d8-0458-4e46-c6dc-08dcffaa5d6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s9cG4+SwqzlsO9Z0SXQt5jCasLfJqPgDHNQUIPYKI3hvQFPdy3ldVmxK8wsS?=
 =?us-ascii?Q?ooXtyxD0/17loeybg8w/M6PoQoOcqys3cNWBkOEnppoPbNXYL6rs9O97il6I?=
 =?us-ascii?Q?jZJrixKvl+74eMbaVGQyqPw+mXfOT219IK2tQF2v6Ch07veUwaKQvhQEjzst?=
 =?us-ascii?Q?BOJ7edhZhIoOZdWTFDLNM9KHtjRUqVnAVyLzW87Filz7tvyd0cXI1M054zgb?=
 =?us-ascii?Q?5VB2PA8/e1hUQ3cFxKo8PzzyHaWW0KcSNNy/mx4OXGSiKt4gXRuFuSSkU8u4?=
 =?us-ascii?Q?7kS7m5ARBBky4jEtVJu4BlGspYCY8IFlwsesVqaQv7g/iyYdiRe9y1iFrQzm?=
 =?us-ascii?Q?QPgj5i65QyFEiOg/cTMEkxwZorUbcu2VYrlaIguW1il5WicQHWioU2Ua/EBp?=
 =?us-ascii?Q?5O707ownAJKg5PjJpddv9Bzk523gxnymPDjYfV70kvyKme7fz3j/w6Vp4OaH?=
 =?us-ascii?Q?HBw16/o3oCOi9K9MDT75XJvayQQcKDkXtnDU5UxJ692sOF+2zGvJtBPfeats?=
 =?us-ascii?Q?Elfdli6dlsDncrqVybpBbVs8hOK1jYB4RjrH8qa7mThlzA5VNdDdd6Vcafm9?=
 =?us-ascii?Q?BZSlaObKyp1ZCH2lHhZpwURNQS6E3vEVeAoWsJ9fmC8UAj75jo4ijvcN81qx?=
 =?us-ascii?Q?Kg3OnQ39EK7gpHOFy6i2hazfncAw/bxX7OCm1wixShICjGjeKvrWeboHYLxr?=
 =?us-ascii?Q?/oTcANUIwMmjZNp9Mat0CwQjLT5clcrA3pmf6ceRuDTd3vtZbGrAj7qy2S6X?=
 =?us-ascii?Q?9MLJq+rbRdcp2mRZMgaxsb5nZLbAIRpQ+GeZTcznsuBEvVztPxQlOFvBephf?=
 =?us-ascii?Q?pUk7GdjXC+ah7TAxhdoUBosOeAWlNHBGz9SgR3hvBkHIAkk1IyqRbQCON0jF?=
 =?us-ascii?Q?8fGlAxcxUKd/C7m69pWg92vi4qQHBMSC4OTJaOuOUV/z7BpqM7zgc4sHGWpl?=
 =?us-ascii?Q?0vI/RBDj71p2qGvkg0zNmH46Zw93HFQebyhmzU1TMk7KJBdQ+7dextRPKF1P?=
 =?us-ascii?Q?PRUYwALUdC+2iCXUKzBfz1fzDlYUPaw04I6BT9aY5FLtUICYnyTihd6m9ww5?=
 =?us-ascii?Q?0C4j7BX3UlcAGKteuO63axRYDl5Mx5H2E78Mh4/SBHg96fxjpZvbo03N2Myx?=
 =?us-ascii?Q?Y9HKHPf94chGbTFuUZRsyuK+Cu31IzOcGW1jEADvpmpB0X6hj1n23TMqqvLt?=
 =?us-ascii?Q?uA6DDYpkYAiRF2exR4nx1xYdBysUgtllrNVJQL4S6b71dgaLe7BBBGHh08KC?=
 =?us-ascii?Q?epOR+07QpUAg03Y0w91F4if1I0VPfW5JLWm8lsFmIIIZTIrcV5Sy3myzPboG?=
 =?us-ascii?Q?SvFEgR7kt07mnIXp8VEexI3QCoMWlgFBJw914P+g8cgweyiRdxlmS+plTk4G?=
 =?us-ascii?Q?2FFh+825yEQAqDgHHqhWNOlEI7lXDOp/DRvF21eFV5wwedYJlw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:03:55.5787 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 414a49d8-0458-4e46-c6dc-08dcffaa5d6a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF00004FC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 41 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..43f4cee40b 100644
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
-- 
2.17.1

