Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8E7CEFC26
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:42:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DE85288E8E;
	Tue,  8 Oct 2024 17:42:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="R+LV/uNc";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4C41988C8F; Tue,  8 Oct 2024 17:42:11 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1706A88E8E
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:09 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INcPyQ1V3J2L5TfozPDOUKzrTjDhjL/NEVDh9Gfxi+bCS760hwWaqOuJmplD8uXE0TK8aSfJF8pBLnm7zwRZhzHQvMC7QHJP2v0Jy4XIn7fKEihlwSHxiNaDe25jTfLhRzwZQNRMA9/BxB9A9nvMzY5L7Tp9OVEo9RXVdvjo/FmfMc44zrIRURnuA6oQjBZRu7hBwu9+E8aNaVzbiim6GXyddEMvJr5t/Xk6Lc3EXGSoeAdEoiHKquvNh4hzGICfLCU/ZXHTMQdcz3yvZnBLWlXty2+0l6D3Ah/u3TKZIeYzYzpnxH9Zk2AIQzQ02RpWI38lpn9rhZY+D9kzrw8kGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D4THxLWpu0/nm05yaMtP8XsYynmnXI8Z3MVnOeWh+6A=;
 b=k6Aje/zYGG9t5uIhPLbSJnNqiKC6Q+UK7oDJRaPL7M2fkkhbHsESJbJyvFh4T8kaJbbSxPV36sdDW6vj+m7vE7OUvMI9NQKvFhjAt4UIOVxi3e7tcPilKkJWRcft7jtwR0v6MziClvYWr9ImP0oMXEsVAwITPBE3JltvGtF7q9owRQ/JX7shz6slXH+p6BkY7Ct4d26YPXkdl2dPGJgMLDTyoZ1NeCV/MAtT7HpioLuK38JJxomhs9Nlad5T/cq7j2xZavx9QyssDqC4xYHskhuAVtr+MXaEPRxJUfSFs6S7R1TXMvLyc/zucpzbOIkPoJbZGa9gnaRR4SOaBSCFeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4THxLWpu0/nm05yaMtP8XsYynmnXI8Z3MVnOeWh+6A=;
 b=R+LV/uNcURncqC5Ustdd7pW+GZQr/H4CgkoZBrYaebsA/SE6zGH8k+8kXfK4IK+JDl/U9wVzCqYBLxP6HHzKigMXt98Shh/t8FDhASfZyrTzXn8Wy3pDTC4Md0ZtlkOAktOvhFV9TbyIUU+om9C+G5jR9aAIaWffPcTbnZvutDI=
Received: from SJ0PR03CA0083.namprd03.prod.outlook.com (2603:10b6:a03:331::28)
 by LV2PR12MB5728.namprd12.prod.outlook.com (2603:10b6:408:17c::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:42:03 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:331:cafe::5d) by SJ0PR03CA0083.outlook.office365.com
 (2603:10b6:a03:331::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:00 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:41:59 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 1/7] usb: onboard-hub: Add reset-gpio support
Date: Tue, 8 Oct 2024 21:11:33 +0530
Message-ID: <20241008154139.31204-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|LV2PR12MB5728:EE_
X-MS-Office365-Filtering-Correlation-Id: a93e58a6-d021-4715-82a2-08dce7afc141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4WpzzK+Bi6/UljbCxhB8bvSPqkfhlo3twSh5SjGqnC1E/hy07KH2YwP7OEmu?=
 =?us-ascii?Q?dJvz/Q4TLj0zIPFOyracH7qnumQaFiwutARgC6ZJ+7S8WtOpDMOOqY0Xyn7/?=
 =?us-ascii?Q?HGk5vjO8YKWnguOxgcb0Y2XMuOisQP4fEdJ8bqDp4i/OZCz2HsB0+yBnhNHz?=
 =?us-ascii?Q?r1wlbITVAYjRZcxidWdBYhQibv5IpiaMhrPN/Uzp5kBI8z/vFFb4xUotcd74?=
 =?us-ascii?Q?f5evhdJJiArldCZ01wfcK5hhm53LMjci0ohrzqT9o5iRj8cJNvbnW31RsJYp?=
 =?us-ascii?Q?uunuSxAC8mpRxUKH57rs8UyKyjyDyNfQYF3p7Reoq+HRYoctNqpmLRsNyO4H?=
 =?us-ascii?Q?iL3POjNrFd5dTtI/K4cxrJmicFQeSoXq3MW/lgKo0X4rkqjiOdn2kHo/cH1b?=
 =?us-ascii?Q?FM1oh3psgtP9zotUAQcA36Hu0ZuJiOQE9TJUYIDBaGw37RlqUdnadyjFjOtp?=
 =?us-ascii?Q?vvzd9TFLq7Y6P+9Yw1qAblfv3rEGIBgfltDFXlJV4R1oJBHEm9SmPqPeWbPb?=
 =?us-ascii?Q?TjesSoZo6ZStC8GjBXrlVM0Lj+4tdaim3EmomUbKOvROgPKyWvOg0tZWScEX?=
 =?us-ascii?Q?onPmLf7lEtlUFLmf8e8+BiO2Ehk/KQsG8idM9AnYi3A/J9OUKXZDYzHa0ND/?=
 =?us-ascii?Q?6JOOpdEqiryuYlm7hbQ3NzkfyOdH/HmnWgiJD8pSadHBk+45+4vIB+71E4rr?=
 =?us-ascii?Q?bj2wqk7qazHfVpnlURHyqOePYBMpdjAVEHntRbHfYc8SJN2zCrCCHxsuLy3a?=
 =?us-ascii?Q?eqnMIKtt8fdMNURJafDN+detfHURRfNOW7UIklLPpSQNlBQLwH0QHyPhj0dn?=
 =?us-ascii?Q?11ykCSeHxOIxsvokpvX+TPjYfSakXpc9ecYtYh+4KravxYVCSsz9U+zZUVMh?=
 =?us-ascii?Q?O0vW5bI/GOL/ZydIdRxxXboz0kYitFylycMdp8gLnHVKGWvhxDAn15bOxKse?=
 =?us-ascii?Q?mWwrkI4OVTFeZmYabk9/M0vs3U1BFZUloRUiumHKKMyc55hfBDJgNEOOE3K1?=
 =?us-ascii?Q?kUxc96qSLMH7WWtN1bZ1k8zS+DsAiL+NM+jQL0GShw2NTOsSz4qR4gdrMUxG?=
 =?us-ascii?Q?/7tmaSsQVqaw9idqVD2vTWUvjkDx3JmBtC2O8Si0Yg9kDgNScMGDLHOcybIB?=
 =?us-ascii?Q?/NAjyyhUsaF5jb3PRwHAg4HXU+3BikzcOtQUcjmHr4F6cyThCgBZuJhf+5ed?=
 =?us-ascii?Q?ASLTWwN1J3Qh6xM2N94YAwrog1h4S/dpDfbmsbUOWXMElKUmfERnZ9qN+7cO?=
 =?us-ascii?Q?eAbx5xjLml17xQkkHEx/v0msxfWrcEc20/mef8LotQzY1F9MgQbIQJgzX6pt?=
 =?us-ascii?Q?JemxLOR5yXPJgbJpZP6mECUQBxH/uwROAODcD0bZcu+Bi4pdyKbB8GXfh0Q9?=
 =?us-ascii?Q?flu2zdGXhgc4ViH4nwq3zgMWSXd5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:02.5950 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a93e58a6-d021-4715-82a2-08dce7afc141
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5728
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

