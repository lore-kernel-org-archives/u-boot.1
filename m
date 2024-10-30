Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D24AD74977
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:43:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 85642891E1;
	Wed, 30 Oct 2024 07:43:37 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2+Kl1qzz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24505890AE; Wed, 30 Oct 2024 07:43:37 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::60b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F337D891EA
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:43:33 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ab7xxSi+RjFv935o4YPhg5Qz524+SagZnANlSUCtc9MxxzvYQbwzTW7n+ej220dd3hx03E2x9PdRsQX+q1e4uxHBun4pzMmMlobPuDmy9Ms01vJBlIUffCWHaQSIO3CuDhAMOg4ojytTBDwH8U4w19j0pRKl20vQQepDrBESCRLuahxoKI4hv9kll6eJK/rsjR7ZVDJAw5nZz3WUJStfbVE4AhNlBWtzPg6MVlYEg4p+vggCDd2cAqILx0widPcWcXu2l4sjYW4V5NW9QHdqFpcMavMLFXIqmsLR07NA36WJlPQcg9mlONaFYsFnoN+eovHOS8wNEBE5CA/PZuOvQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRGzxzPx/exwD4Aix6031fWq/bDsUWmH8laEBLvpaQU=;
 b=YTNHw+pDqj0MD77OAie5eXobwX9iMeNqmx2ozzkiB1Z7VkjFr7bojcA4fef0Rt3s/1TmcECTS55r/ah6rtIMATaKzP83p2wVRQfMA9UaE1ayVikrXzCXRZQ20Dsa8FAF1deBmmGIDu7gar56VmV3MUMFrM3/aQSP7E37g5i/nYH5TtcB2SSq5ug/+HuzzNML8mMsYc6/a5dAECf/8lJe09Mx2Jf/hg3mt/SrbNna5gSEfwmhxo27YZGYf7OEMJ7RwYKuJTg/VkqwQcfwdlY2pGWNtRg2dhGEQVy1qF0PVONMwcdKZWhada+szrJhshDWtuDBUYcbXh5o12P81MgOuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRGzxzPx/exwD4Aix6031fWq/bDsUWmH8laEBLvpaQU=;
 b=2+Kl1qzzVyeOOcKrX9w+JO2mMq1aiy0Fj5YMUDQms5y4z2TpGuEw0XlvmLYGxKojfzsrFFTbfkal2gz/Cc0ffnKf4bqN0ThbMybpiuNupmxwf+8UC16I9khi7xZzOUzBJThl0eHDDxW6341OR0onnX/0t1pa56mbI/UZlVWPz0s=
Received: from MW4PR04CA0311.namprd04.prod.outlook.com (2603:10b6:303:82::16)
 by DS7PR12MB9526.namprd12.prod.outlook.com (2603:10b6:8:251::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:43:27 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:303:82:cafe::5f) by MW4PR04CA0311.outlook.office365.com
 (2603:10b6:303:82::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 06:43:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:43:26 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:24 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:43:22 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v9 1/7] usb: onboard-hub: Add reset-gpio support
Date: Wed, 30 Oct 2024 12:13:08 +0530
Message-ID: <20241030064314.28604-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|DS7PR12MB9526:EE_
X-MS-Office365-Filtering-Correlation-Id: 38f83151-468a-4b95-b088-08dcf8ae2830
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s9SIQXS671Aw8xBs8YDp9tC+tG0TQRH9aX2Y70iFpXmqLNRJmw+KpviLAisH?=
 =?us-ascii?Q?xUNOXxl4wAJ+7e1jkv/dUYErcPXoTSVAG/0PVa49xrimaRBw7M8KaJKi/1Ol?=
 =?us-ascii?Q?10T7QZxjKxZg/sX9BwxKftbpMHr5v3/dF1YkjUNPApWRtg3ke4Yn+5X7hiHh?=
 =?us-ascii?Q?pfrVV0Ek1aC0JWe//lIRKPrG6eun+L+5V2yY5YCTFXsNV493CoYlXFu9I4RL?=
 =?us-ascii?Q?aAz5VkGMI81huEHSSQGUsuWhdcJMSedFFYwZnGn5Qhk7i4GVuVr5Jtx71nWP?=
 =?us-ascii?Q?A9zLjNLC9UmnbipnQXIHbelVvscOsh2Tt2DsYLLQiAiZasq4esg3vP29w7Ei?=
 =?us-ascii?Q?t+1fJlaDLDsvnePPtYBr7LKEsHhcWSW5yh3IPsCzIubVFNQSSa6399rOxb37?=
 =?us-ascii?Q?POgxaKk2fesx6+swxNdzg8cWWazqun28u2LhEhb31/8TtCIhkhZEsFeDyDzK?=
 =?us-ascii?Q?nVwiaXzgLzZwj8hmAKJC13bl5Vv85svZl5MCfM2HLxWCnHHeLp1mrVYfDslV?=
 =?us-ascii?Q?24zFlsKpfl5PtZGBIXjSXJoaxcEDkTOCTv7IEc1ep/84z3E+LtMEocMSCrFh?=
 =?us-ascii?Q?NJbRJw6jGlN/Z56W8+RWkQkYlRA98Qj6xzOjIy3H/u5+FJcgEjxKUDiWfBjZ?=
 =?us-ascii?Q?eaQRSzhXgpniACLnjgCPCJ1ilq1INE7irm7Q+5wgtkhUEpM1gXPUDglWzTwe?=
 =?us-ascii?Q?z6UNG2NbkkgV7dLhQvszTn75nPyiMpjfPvI95lxtiibO0CDiGjinXDIO94jA?=
 =?us-ascii?Q?NZpDZj1B/BTIPpjmz3qzOd28ZM9TavsFyTaJBBjhOoXZdsk6T+BLTwCxarpN?=
 =?us-ascii?Q?w44dUmZJEmB4S0baI2HN5I0Xwjx+ihJjx1/az5t+0myzHIBIUacIOdRZjn+W?=
 =?us-ascii?Q?RxuwI1OUf4/gE02eu328qDrFOcewFDdFr3CWzow6TMiTyUXYp/W2EiUh0KbD?=
 =?us-ascii?Q?ts2m3tiSNfmuntZv07iigacDpeZogVx4I1AcwxlWrnMlu6/zx3IsPp7NO3re?=
 =?us-ascii?Q?R7Kx2au2Bd8Lz2e86pJP5fbD3D9CiYSWxMJEl9mwA9LrFeDH4bwBUQ9/Peb0?=
 =?us-ascii?Q?wv4aJzbitHKA6SzhhXH2nfq+TxqOWrW2FSeVaCv89J72LdzDMeHGHn5l0yal?=
 =?us-ascii?Q?tno1h/DAM13ADUKZRHOUwErszw6aR/R2Dmnzfv1yjx2YTQ6/dIG+lEcbKno/?=
 =?us-ascii?Q?rGQlNc3qiQ3dMA882t/U8MIlGRBhJSJG4IpsOlPlYgm8FXQf23f1UnVRagmf?=
 =?us-ascii?Q?9Fzldw3GdUhL0a28TJXg63XhdAlOfwcC5XJhqTv3S0ViI/2Q5MPXlU9bH45r?=
 =?us-ascii?Q?jGqGhg7NDJlQlHhDGr0ezrVq+rRYuASvUrQWZH/aDu41u20YiRCG9HuOmcPc?=
 =?us-ascii?Q?eePR6Wl5S1iPavvIHrEqgEYssxg6X19ISBuP23aBM/q5HXIomg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:43:26.1264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38f83151-468a-4b95-b088-08dcf8ae2830
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB9526
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
 common/usb_onboard_hub.c | 42 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..4174575893 100644
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
@@ -30,7 +67,7 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
 
-	return ret;
+	return usb_onboard_hub_reset(dev);
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -38,6 +75,9 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

