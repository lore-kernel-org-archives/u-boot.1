Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7B7BD49205
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:12:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EFEB89467;
	Mon, 18 Nov 2024 11:11:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="FjpsUCYI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA1A989187; Mon, 18 Nov 2024 11:11:56 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20604.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::604])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EDB5F8945C
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sTywxW40AeQiGmwBcWMGRdcoqTDbNAJ/1ICBiWJkZIteSMs1nqFsBaVXmGw+Us7t5xdO5yeDv8dzpnvUK+5+mvS7UTaXlazkvgnNKndv7J5se5HjLDWINp5FKE2S6s6A2rF2kdaZHZ3JQHwhjyVO8+BfXutiiTeeOgWa6KWaOiHwqEYMcFvNG+nNa+1tFOlfQ+vF8yY9DztHQxW2bGzHB/C/X6tkblVIIp0XDIoiQcYOyvYkj1rySxFCNgAoKFeHKpk7XgEArBkq1Pw2wyF6O2K/foqiU62DXqbX1cbkBU1jnFGROs0tP79nJOYEc6lTZFBpDiYGTlGfsVxojqbDSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SMQsay0q+ZtQE6fMqYl+TsqIz49pe/AdJGNtJuHRF5I=;
 b=cy5ewgJTkObkWRrcU3+2GlOVmfyVqj8iLZ32y7GuugL6VlXyt745DKfgToirTAkKfUOOPi7HPImLxcoW5cv5z3GQEdUxlfpml7TQe3W2u+LocjlNIvJj9JaoChOKStUdViP1Kbano5SS3+yrOKDHS8hYzmCmpSm8gPSPNpfnj7iyORbkIkrFQqsohHcYLAP/9Tlv+Aw6BooeBH4eS5TQF0xgwO5Nl/2A4G7U4q7AaB7EONMnrMHbSyBvQmcm8uNPOlGKLnslRIakruzySbE2FqmjfN0/WqLKYiJ0MTiIP3C+pDENBz9QBfwVk0bo2kdsdeQqKrS/kgQcRKTPuNx4iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMQsay0q+ZtQE6fMqYl+TsqIz49pe/AdJGNtJuHRF5I=;
 b=FjpsUCYI1JtZ0KpRwzpordrsp0ufmifFZJcWamfBTEAMdvmLKlVRvrbtXut9g1bdYqZG5iQY541qP+2hxro6Ta350fu8Px77y2UBYMMZGYhzAppFckcl05DUsLeUNPTKu6lZXwO+TXikfCM6bOwa2jhosRwhAfH4bMzi1VefKOM=
Received: from CH0P223CA0010.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::20)
 by PH7PR12MB5878.namprd12.prod.outlook.com (2603:10b6:510:1d6::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Mon, 18 Nov
 2024 10:11:47 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::88) by CH0P223CA0010.outlook.office365.com
 (2603:10b6:610:116::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 10:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:11:46 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:07:57 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:07:55 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v13 1/7] usb: onboard-hub: Add reset-gpio support
Date: Mon, 18 Nov 2024 15:37:41 +0530
Message-ID: <20241118100747.30121-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|PH7PR12MB5878:EE_
X-MS-Office365-Filtering-Correlation-Id: f5ac4b2f-9008-408c-3d12-08dd07b9691f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?W6rCFHlMvuY2KivKjcbrGWGijtPUGV+ABa2zLunvSyiqwerH6ralEtZGto0L?=
 =?us-ascii?Q?PpOiNmx+qSBzfCCImPOQwlRplO3sHeck4yLlDVvCS2S61QOkvkJLs03uTsJc?=
 =?us-ascii?Q?0jGo5shySRfgdxKWMqZCxXrsnsEHWwEzpo9IN+l6Q1WocUI4wgbWUKDB1hvB?=
 =?us-ascii?Q?3CPQzX2xdPWAaOGoTGTGYKC51ZfABxDNTY/HHNmQxgpmZEqeAjvVIHNEWbjw?=
 =?us-ascii?Q?x62T3+PJilIHYiJMUesKB6uDK+6RHp1l7GhT5n/Wif14frQndoOnT8bzMbC8?=
 =?us-ascii?Q?Lp9Wx9FSJ5vlTSgmOPUO8KtxmuhDXjCzaNxjSnCShfM/df0CJP/fYTpiwURB?=
 =?us-ascii?Q?YR3UsoQFPF05yWccCjyZn+osx2B6zqBr2PVo8ZZRhSmH72V9ficxcktgMi6k?=
 =?us-ascii?Q?OzTIXvyEJtK9QW93DZbRhXkXsKJCsW4vIehBmSw0T4S8MsLXJSk7gE6C0NXb?=
 =?us-ascii?Q?12KW6F5QDZZrOXut6J4mUnCKGDbHjTkNvNXnHaDWHmvu0ZdPNvCG5htV9cb4?=
 =?us-ascii?Q?tIlrvfa3OHFJ7Kvqa53VMGInR8MaUY7qrUQ0nFRHZEYm1EVodiGmY0jdQ9Jr?=
 =?us-ascii?Q?1hPUUhHG+l8uLPh3krRXX6kvU7iPIGQ383/+0ZSFy+S33C/jaS/Jx/eOLKyc?=
 =?us-ascii?Q?nAWFtmKZr+GUS2K8oPQHXd9tvncjCq33Os69MAirWitd0AdJDvsZB2cVW008?=
 =?us-ascii?Q?cCL86jNYItJ8XFI1jmGnzC1Ab4NxO72K6TQCTEJGiNi3BbBwNsYLFHDOAKec?=
 =?us-ascii?Q?Uvb/G9ZCun+yGmsDorDn2Q6y9dhLosAawh4oNBLWyh0NR5xACVr7Ng8hwsZn?=
 =?us-ascii?Q?7l3flZK997meMstotu7E8dlYiR+3b6tg2P0y5ygu4cQDXeqpRPH+/kDoNgpP?=
 =?us-ascii?Q?wM5Ay2Axxm4qUlGoAue7iVC3OaUzEZqSvfeOuHM5h3ryFy4miDIThoL/kDWV?=
 =?us-ascii?Q?QYSysWwHiPpK2eXcePSBMGUch7Cg/NaYowqcmG5KtrZWFLewhLZlIPum9cM2?=
 =?us-ascii?Q?aCSAIDj8eAXaJaDzs9Htqz1JE3c5SbEy2wsMHnFlxLmA65Or2JI9q5U30HVQ?=
 =?us-ascii?Q?SFnezIMYkFWHM5jgT/OvO+ahWyn/0k0V5nwHCuaz3dorJRb/m8SKr59pOtrp?=
 =?us-ascii?Q?ZeMMjecV8YZF80w5HmsYEkbytkpRzEkEnuC4zdy/SVCr4eyJsGIxhRRo82Qf?=
 =?us-ascii?Q?dRIZaozi/89eYTyAUQSOrcg3PDy2nUk0d0tKJBsRB5Z+KNA+piQgSqGovqMU?=
 =?us-ascii?Q?dNJXxgkeEetsJijmzmvBSoXQHHtzYTc8NhtU+xKvF8Gw2MR1Dfvj8oO2qHld?=
 =?us-ascii?Q?WKAbUcmwA0yI1om8xBH6mZrpQqej7WgeZTNFTO8hIiC47gsEmQdRt+nSDPZE?=
 =?us-ascii?Q?M3Rg2UWEv25mGEenbdt91VbQrtWnglmpShOQfRCZt956o/zEPw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:11:46.9540 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5ac4b2f-9008-408c-3d12-08dd07b9691f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5878
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
2.17.1

