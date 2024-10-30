Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08ADCD74963
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:23:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55D42891FC;
	Wed, 30 Oct 2024 06:22:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="df/jmpgy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D5BBB89206; Wed, 30 Oct 2024 06:22:53 +0100 (CET)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5D97A891E8
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:22:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NTa2ABDSWIyORxMAnPXrY1ooTp52rxaZ+FESN1zTDExQyV6gdYWeSUzWJ2D5x8q6ZqiNgDHyA28dPy4LDs39W0MSVRC6werylq12dZ1n+yAOVAHKt1+ulOSo48gP8hCTCjNLozwAl25YUrnSIFBA07nrQVCJwmQ+qH8J9O86Rd8Nk9hzuiOPU5rItDdDwY8fH3OxiH7hxpgakzSgJso9LQfSMhYVHsvc0NUtxJCN8KaH7vxm3N+ltgVbXA+fn9USGYYl39LLJchAXeJpGVdQ8lbdcFxKlrV9Z+KwCI3YhJmZpZgjqtd5PtNzo0XPybjh/HiT++cqUc99Jgv7+gBufw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4THxLWpu0/nm05yaMtP8XsYynmnXI8Z3MVnOeWh+6A=;
 b=S0aTGcTAXUit9gXtKRmLFmPGonBRLA4jFTtB/n2t2AamvbiMFndjR1u2Gy7FJwiyD769wK9M38rYwN0SKhADlg8EG+GBhfCVKP7Pec1MD2DlQRDyHvUf6ZjSVgjooPRNbE09S11HfeaK1uXHCBx6dMrCAhqYQ2HdABvI/HOE6Bni11CYv2A4o6l8gGtUsRZjV+bjd2qZYM7gvE4p/X0ykeAJDcyr283T8Zd47DmbFyQKH8b4EJ4p6DZg4n2ZFHuyDSWJiMRHzgs5T4ZZyRZqoAx7kTKhpNOKyPv6TxDHb+8LV+/G8Ie5by1wyIb8mr5zSz6j5vuCxYEuE4zacnYovQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4THxLWpu0/nm05yaMtP8XsYynmnXI8Z3MVnOeWh+6A=;
 b=df/jmpgyOHmaU94Tme13idpo8PY+zqIAhtI8BpVYsCOQqkUX5OQkjnSPDrl1vIjPC8exBx3QvA6TkrJyJCeaKn1dHxVTMMObYSWgVOidMsSYOMSPswfIuKRwg5ceNVRpAchl/DGoonWqrUvAFtwh1rrwLsAIF8r3YlZnmQ1GXt4=
Received: from BLAPR03CA0022.namprd03.prod.outlook.com (2603:10b6:208:32b::27)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Wed, 30 Oct
 2024 05:22:42 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::ee) by BLAPR03CA0022.outlook.office365.com
 (2603:10b6:208:32b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29 via Frontend
 Transport; Wed, 30 Oct 2024 05:22:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:22:42 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:37 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:16 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 00:22:14 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v8 1/7] usb: onboard-hub: Add reset-gpio support
Date: Wed, 30 Oct 2024 10:51:54 +0530
Message-ID: <20241030052200.24243-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
References: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d25498-fe7b-4b16-6b96-08dcf8a2e107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?diKQLetSoMWdjpBpZ+IHq4pA1a4B/tnmBx9lQpJXJUB/wZrbSs+lDbgzJTA6?=
 =?us-ascii?Q?a2goiQxnAn93cN9k5QqpjECCrBEm+NINpVTpSeYCwGM224ls5QB1ZFrVH00j?=
 =?us-ascii?Q?NqG5WO/NIw3u90WlZcunwDNB7TZ9hF02+RAF/ZcdoYKYmq0yqCMDgsUiVG+n?=
 =?us-ascii?Q?LmM81QZ/PvOnp2RCVjvHH0fu9tFAN1jOPJyKbr1DOPKa7ZtF1B4IsXU1O9st?=
 =?us-ascii?Q?L3SCyowsWGQNohwj4vKAaAYVdHX3jRdF4WdZoZWrSj9hhjWwoNrtBy3su7RZ?=
 =?us-ascii?Q?u7nVx3pMvlwTGQfJghGttrYxFrXuLs8sQ3SYGlUQjHesOGv0TfV88CPYKqvC?=
 =?us-ascii?Q?1x7DciXHflK7VxeyYpa+KjUEdyuT/uwEY2J2HkgObWo4f3Mggjdq72mdef7G?=
 =?us-ascii?Q?oAL+qPWONDsC8SCqv09Lj3kQ7BjHAX2wfh9c1PoVpU/3xYmeF8/kjsKwr4ri?=
 =?us-ascii?Q?N2+HhwJjPKvAT4ldx9BsXtlV9ZyTtQ5jt5Cq6MxtZI9GvvNGKB1qkuRHyD6G?=
 =?us-ascii?Q?xCqpMoziyHU2jcQSt+EHfeJWTpQv6nsazIRbH+J5Sacbcg37cnOSqUZsI3q9?=
 =?us-ascii?Q?Ddw7/PsSvyT+OdmnZZVEP4IJPJkN6uPA7lNfrtvgEuKf+llhgAGDO53CxeT0?=
 =?us-ascii?Q?iCLcmQTEATejA32V3/iFFiCABL21btXtukovUFIeVbBrmGsvOX0NGIOENnnA?=
 =?us-ascii?Q?B6ubMJglT6k5UguN0wmWtIaN40EXcTnEJnM2aDgxKxBW+0Pz58iHue2NDuu5?=
 =?us-ascii?Q?sH9CzMDA2zJ/GUxznXk04056sHjZmnj1xUrUPJQpkD5kGkzYsYFOQLxGIMDX?=
 =?us-ascii?Q?E3elekvuGzNv0QbedE8aS9C+dQlHjUtm++EPQqG/H4YPcKkgUT7UY2QZg45q?=
 =?us-ascii?Q?IiZw3I1ivSoouhPxFv41/buPzyUHK8+Qn9BdRD2YiCII95DCy5rFnzwGPWTi?=
 =?us-ascii?Q?NtTCKCcU9EPl79wx6Y7j4uDJZf0ns3gsJtKdYuanij4/OrzvaBXm9SyAavMU?=
 =?us-ascii?Q?0l1b6TrXCcBs3OZe8x1ZDLGUyf3I4xJZJaFx/dAm9At44iAEPHBzZfd7t7HB?=
 =?us-ascii?Q?J8LDDZIagERy8ygzz/i/s0v3txrRV0QdrrbO5m9tAFw2hbQIsocDbZWXO24U?=
 =?us-ascii?Q?/i0RGouA/UupXmihIisiGtKFlTqzEpVTSMVrlx8LnthAAqCbfxPIvyFLAP8J?=
 =?us-ascii?Q?yXZfwSoilHMuakuB1k0wju6UFfmwga0hZi4794NnUC4bpwWX9RgFafYEjxR1?=
 =?us-ascii?Q?dRvMNQBj6dvGSzdqq4XaTQ6aD3JTr/h/3aOTLw/wK9wTnes5Y0ebfWgRkPSw?=
 =?us-ascii?Q?czMdE4Fvx1luDWhvLtR+ATvK/31BmLGB7H3BQy2DgQRzCWyWFyjdZqf0eiBl?=
 =?us-ascii?Q?/Dq0UCN8vQTAgEfwr5bc8uRnAsIToqHCUm0t1QB20qK2zRo2Zg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:22:42.2736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d25498-fe7b-4b16-6b96-08dcf8a2e107
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
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

