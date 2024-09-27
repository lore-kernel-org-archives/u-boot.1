Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B9ECEBF7A
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:01:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 32FBB89089;
	Fri, 27 Sep 2024 09:01:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RQ5Gj/zy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93CE689034; Fri, 27 Sep 2024 09:01:46 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9543E89081
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DE0yWNmhCVgyHBuWn+vdN9g+onzlYEXIMTFY38TjpdKGlZrnPU8n+LdZ+eu04TPXGxGkHarJZFjqXbIUvVOOaoZFC3nMYiOZN8ICAoaEjIzzOcvQRsuAMY51CmYmRuI5fBhrONtiGGIY3MQ6ppMqdScBPtYwlnRRjyQajkAOALx1iu6wiaGG2QfJewqq0HInafhqsxaxtp51cueka+D2jQBqYz7H1XXdDPeOkwe3eh1ZaYSA9OZ0h3Imiyb4S/oC6Mcf6z1+m3pxe2BelSA1wQvrf+w5w0GjO3UlD5vZdr6qbraumbTHrOWrmy1g9NQ6RYQF9AuyuGRqQ6kbloYJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl54GhIgD39uolGAVeCkn4WngOJsurBYgOirGM98zTY=;
 b=T5xZ7jpqTyzQB9pBbHxew3VdTPApZj3HW3EZE4mfNP2VvX5MsRmvfHYHUkSksEaRLXZlU7VPBLa21hI/hU1Abn+quEo0HuDWFfD7lubhT5oJUpDMs3yclG+mxAgGztpZc6tnroZKMdmJZ+2tz9Y9/uAeH6921kboonM4/QcNGZ7CY7zCLsQ+B9c1iXHOC7PP4J46ksGSTp2oFXbbFsOAXWxgBP7iplvhVSJhHTYp4d2IGHSllTXO9QAaUteONNblZGJeB+TO03AOBL1UElzaQ5FugG4nrXpP8OI+99Zh5W8eElZe9fJ2eJc90khMIthJe6pcfj8HNrhLkRtwfSM1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl54GhIgD39uolGAVeCkn4WngOJsurBYgOirGM98zTY=;
 b=RQ5Gj/zyZEzuqmIadZCyOjoBI+RRdtf/D13jiL+wtceLIOvL9BLhKbFdyzlAECoSOgEEtGjQpBFCgxLGU1x7luFI4e15wW/5n83I95RXqRgydUy17cEUa+SzrMi1um/f3P/JvMF9hEhB0Ff6w3OU/8ldf7IGRF16zWmFvqaFA4s=
Received: from BN9PR03CA0746.namprd03.prod.outlook.com (2603:10b6:408:110::31)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.21; Fri, 27 Sep
 2024 07:01:38 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:408:110:cafe::b5) by BN9PR03CA0746.outlook.office365.com
 (2603:10b6:408:110::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.16 via Frontend
 Transport; Fri, 27 Sep 2024 07:01:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 07:01:38 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:36 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 02:01:35 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2 1/7] usb: onboard-hub: Add reset-gpio support
Date: Fri, 27 Sep 2024 12:31:31 +0530
Message-ID: <20240927070137.21816-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: 752fafa3-c3bf-49dc-3b3c-08dcdec23bb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?u1RzxTYjXgPGEKMgQNhWH1Pqa0Kq9Hq9O9DqzRVw+OloiM8ZUJ1036BtJFvp?=
 =?us-ascii?Q?6AEOaVAWj7ahIyLZv7Xe/VxXCUHvwpivqJX++g8wGAAIgx2VytDk7F2JPoPt?=
 =?us-ascii?Q?312jVgLVwWP9FtzF0iq8SZjT/2z2yMBFqHnO7HC/4YBGg8nhJEukjmPzRsR2?=
 =?us-ascii?Q?2svoX5GNkl4nlmwwOmTiue7v0HbqMKXcIdVgiJkMSczBvKcj1h0/XCHO1uo9?=
 =?us-ascii?Q?U3ZdfAcq/LoReZp8Eo9BY2/rouvGsg0un2ibgb/uu0d3UDV+ON4ty+h80/NX?=
 =?us-ascii?Q?0AzUmpk78aCRMwx/s3R5Go8C8WpxGJ0q+O+Zd+siSvWkCUJt/dVnmMumRXDT?=
 =?us-ascii?Q?vGXmLYh4Jqth7f9wveAJ8clATI09N2h4b4q+DsVpkizr2EkZhUbWakkkcQ/4?=
 =?us-ascii?Q?sUVwjx734qOLulcA0l1CTKI0nMCvDHroE3NBCs+VuZKsA8vO4AWwxvHYOt7y?=
 =?us-ascii?Q?wwNd5w3pJCq5ZSgu2dS9Ut6r24ykEt7/q/7ACwqwC7oZ8ducaYz9SgRK5beU?=
 =?us-ascii?Q?PlQ00U3p/mNhtwFg88tzaW7l57vmX0fruMx4PgYr5OBliZd4/MVOAiRMdFiX?=
 =?us-ascii?Q?a6cDp9gnwPdnH8ZwVjMxWK4D+f9c2Xp6oeD3a/SLd7H8QbAvnaiBGpWgNWc2?=
 =?us-ascii?Q?fDfcaPciht5Dx7ylh3sDFqk6rwsQyOi79tk5h7LVJDb9TXBXEqJvagVliC0z?=
 =?us-ascii?Q?03Vgc4aUVfeP40+iNsA4dnPUE3I+VT5Ts1DoVDN1CCHl+rIZWFvaAph7DH3P?=
 =?us-ascii?Q?azBLbtBsnx/3slY7eAVAGghTiAHdT51uTzEYQnk1Vo+WNb64MuBYRFm5yQoC?=
 =?us-ascii?Q?Ff+Z8GBObxnUOflLTpEUAR4TzWIRezvwy19KJgVj9fLpf31Xjc+FcMvw9/9c?=
 =?us-ascii?Q?zmPNrScWl4szXbfEgpAVogqKnkdD65ud56jaADLlhD3LYPa6krxJMpJeqI+z?=
 =?us-ascii?Q?BSPU3+tFEXC2+rgoCpx/ckdMAorUijef5bZVa1hzO0+SfQ1dV90TvfvAjwh4?=
 =?us-ascii?Q?7UugjyEV4YRkVsAuyVqlzcxr3jeAjpv1I7YSvvz6HZtkDJNtlJzV9J/mlTDQ?=
 =?us-ascii?Q?FyQv13dJkLIC+c9tzU3hfhXG8QLn061xoFwkZcJH10kJfR2s0kKbtiG1fpdy?=
 =?us-ascii?Q?t81HTPnZvxLPnR7vLJVUI+34vz1Y0hIe7u28tr1UPXrzdEfmlCPvPqoDFdzz?=
 =?us-ascii?Q?VcIjWuHg7h14SQIqnRh3LYO95pIrR1iMS0PaTy1Hfr6Nb+n5FqPWx/lDkwoG?=
 =?us-ascii?Q?6srgXrfLuntEA4001NyJPMakcnnhMl9syORbvvSB0hhxWvXP0vZ/aJjkinte?=
 =?us-ascii?Q?GstEcaM2a8uGqJOvVguf4jlnY6sAP5oGGi6KcKKEyRDY0w1oRzE5ApqWrf6L?=
 =?us-ascii?Q?US9eO6D38pYAeoMMbPX966zJoZlTbqQ7NWdRiA2X9P0rYvqPrXtUtrGjANlD?=
 =?us-ascii?Q?Cl0BMPyGqpwzw+xnlAvxHNQWgAzSI2iu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:01:38.5428 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 752fafa3-c3bf-49dc-3b3c-08dcdec23bb5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906
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

