Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F394BD41D6F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 53DA189428;
	Tue, 12 Nov 2024 09:50:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SnH8Q94i";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D34498931D; Tue, 12 Nov 2024 09:50:46 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2060b.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::60b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8170B89428
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2SpKndkdXXssixMP4vewZTw5mGOTx+LNStK70vOOCITBSeVN2KqssvdcvtAtRnGEVlgTB6ms/+kasD5qWdz5NbGsFQo2U4CKq1NDGB7Wy6ycScfBcwGCtNrDUqqLIvBbs43c17KQc+EpiWwAWgejLh6VV+84/CfjTtWLrIjrVTy+HBDq3S3r78TWKrFkVr6uT0pmLYBnMzBe/sAd/wfyDh7oH4lDaYjp94gDbZ8+bxQwL1qlsezmll3RyUpeji2Yi35aMys39UARZnHq0I9GHqriec45bcvJ5tOKPB9624ThfUT798BLADrwNHtoWcMCXWIbb93buwZI5k58kQhQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkIQLeT0+rz+YgCt4xFi2smOyMFY21TNTYhgY337fGk=;
 b=r50vqF25d48k7K3+8EREpY2Fo5xGWkeJsX0SXC6tNZfe53ixC9/p/0AgQ9Ebkw7a0PRoESyhpic2elPzCSTrxc5PG01MMwW0IG3uDj/ozhUXft7pLBSQroon/RAoo2mMvFCzLe+8zO6ybjh6X+p6M2W5WS1+BsxJuRhPeVhE6aotZSrIsZWjCPVFDk3pWefTNZ3c5G01/ihI+yIa6d7kYPV5+JSbpnFlH4jBnj7IFoi8iQZzxMrZ0/fsxLN8ZgJ5YhMplRrNmZmbzQ0QKOhnJCHFqIAqAGctzZq+a6xTfujB8x0F6cGmmmQqJ0Pk9xer0Qws5c3nY9vbi527HYpRPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkIQLeT0+rz+YgCt4xFi2smOyMFY21TNTYhgY337fGk=;
 b=SnH8Q94ib9O1r89RHrzBQO5ECH/IlrGjVF2Y2v+qqTXikY8AYhvcBWtp91NQPVmfMQmr0qaaqtktfqnaauS5TQjcaybzmjg+PJHlvMW07mLIF7giysaZuqkLaWGtIhR/8za2BW8Q6jrbEI8pC9XHkB837Kthzlh/WjaXlK57cXs=
Received: from BN9PR03CA0585.namprd03.prod.outlook.com (2603:10b6:408:10d::20)
 by CH3PR12MB8509.namprd12.prod.outlook.com (2603:10b6:610:157::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Tue, 12 Nov
 2024 08:50:40 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:10d:cafe::22) by BN9PR03CA0585.outlook.office365.com
 (2603:10b6:408:10d::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:39 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:37 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:36 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 1/7] usb: onboard-hub: Add reset-gpio support
Date: Tue, 12 Nov 2024 14:20:21 +0530
Message-ID: <20241112085027.21352-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
References: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|CH3PR12MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: beefa87d-c4ac-413f-6239-08dd02f71567
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OnGI8x5kQ+cMUd2fl1v/wcPycmiHfK0OsmF7R+RqllKwbAeME9xIOjLUbPIs?=
 =?us-ascii?Q?xmpIk/Dg+ktQvs8Ymc8+mz/Rg0LmZTNlEIdcHPLR5HmMZKNQpzSi8I8LjSF5?=
 =?us-ascii?Q?Z/jdxUoWFxPK2fNe+i3Kn9r7wuAshdqpcnkiUOSYvHLoTrRkTls8U4LSsi7g?=
 =?us-ascii?Q?xIR5vmuXO0Xan02IQzWgpgyBoICiW73Lo2nIvw0wbaEpSICPtXVnMerw6Shv?=
 =?us-ascii?Q?u5VkZXchzVk23WgQ5a8kE64s2WF0BDB6PA5u4zx1V4RA/Svb/HrwxdgFM7ne?=
 =?us-ascii?Q?ZZ1rUxw6fXR7mKs7Y4v13eFNagC7eqUFViUdLrUh3vHchEqpy0tf2MqGdIuE?=
 =?us-ascii?Q?lpytQuLbH8T9S3k7Ry3RD9RQ/xVMMVQPlvx6txxVt+PJTQwUbZMqvp/10xHi?=
 =?us-ascii?Q?mMjWGWM2QQIg1qVvpcSGFj7kgLOgbuZRbqfJX5ra7BpuXjuS/+W8Qw6N6vX5?=
 =?us-ascii?Q?Q9bsz7BP50YKYezz8NgTOuX5ymme5ZDejx/9Qb4/2uWpUy4LFaJRUdhbu1e4?=
 =?us-ascii?Q?hA0+3lNGLlakhWg5uMNbrW8uglC3oJGU12fyyI+lmBeVroEwdwvL7ovXd1qC?=
 =?us-ascii?Q?BPUR+0oqAbK4hL6yG2KKMfZqGMwflNeTGTcaUMXQQEg6UT3r9lYEIOge4t5C?=
 =?us-ascii?Q?mnkwSxn1OxzMXHRhLidjE6bYJObNnLDjswj/U6FV/K8llAAwpXN34dx79NK+?=
 =?us-ascii?Q?EDV25E7SpKeS7X4Jvctp4f9Tw5ffLA7GQJK9ar/4NtKjWwawKfQT/s6BYmiJ?=
 =?us-ascii?Q?J1/SecyPJVyvFmKZ7W2xXhhAsFaDIuHhLV4pfxCyBgM82qnA0IWdsthXlM2r?=
 =?us-ascii?Q?WlaELl20RXu8AM+jIoEkZ1KeD7n55t5TMz2re1moV2l2Ng+zSXUiiEJDCz49?=
 =?us-ascii?Q?zQh0/4Z6uaml96bqsytGMZat3heLy9ZDDZK3i+0LsCejep7Yf7oNMTYQ9JRH?=
 =?us-ascii?Q?0FLmyG5TKrXTX3qpRtRdMftheUQwfMzOX1o3PFBOe9mvmAGcoob4JHmLIgci?=
 =?us-ascii?Q?SVDN2eNKCQFmd5cwUHzPKrFZx79rRROFuuDnxt1dL0ihjofhapRvoM+3BPvQ?=
 =?us-ascii?Q?v6H0Fq1g5cn2TZ8Rx/7N5+RBWcn/iisL6B86n0VlLXFGLR/x6+PBGyu2/Hs2?=
 =?us-ascii?Q?XbtOjlOzs3bhkRstXRRGS2++z1Ep3QekJ0efZkysecIPRFD6nh48uHj0SqIy?=
 =?us-ascii?Q?xo7iisfKCmHuPqJzlKzKKVH1KWFyl4l9NJzGc/e8QVmbgiRfX/TALJsW7sl2?=
 =?us-ascii?Q?bmLv+cu/4fqdMPPIiWliAZwFLOf1CFI64HTgxpYcw0FOmTZyGFx5lvySKKvX?=
 =?us-ascii?Q?MiWt8dNnBO6Roiln2E+u/8jNvRhrRQhftgBdJ32t+L3H/uooOvr0A0A8RDS/?=
 =?us-ascii?Q?5AGLubfoSrxV5f6cZPECWaIpHfLrph/M1tdX/281Oxovl6Ha9Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:39.5128 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: beefa87d-c4ac-413f-6239-08dd02f71567
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8509
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
index 68a04ac041..cc0501832e 100644
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
+	{ 	.compatible = "usb424,2514", /* USB2514B USB 2.0 */
+		.data = (ulong)&usb2514_data,
+	}
 };
 
 U_BOOT_DRIVER(usb_onboard_hub) = {
-- 
2.17.1

