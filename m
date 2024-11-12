Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6BDD41D53
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:11:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA6C489393;
	Tue, 12 Nov 2024 06:11:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lAWojZCm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E3E9789383; Tue, 12 Nov 2024 06:11:13 +0100 (CET)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AC26893A0
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:11:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SX24zFX0UtaD/jXxxoeiOea2b4T3+4DC6Q3rgUvIoFVdB6aWif/fy8PGnRDgAq8XJ94l6vTQLPzHtfoIiPDOeaYGEvnH92HlbXQV8lBlHNgvslU/RXRWnL8OItVdCx0++C2Msq+GK1A5msue2b75je1XpR7NDziGdTm7Z+xpt2raJJFrtMZjXFrMHR4tlOe9dGqhbfZwSvzzmSdqkkN6DPgTAf0Pro8E6nbHnkeuKWeRcO94cOyQqaLPEjguvkduyUB36PCjWEqCrIS5zvRS1zZO3Q2gHBLwS1AvrEi8iEqsIn6Clzf/CJmFG4BgKNrh1QV+nOo5hXk2zkLZJs43cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1szPMcWraebpb1rXX6KKfmqS2n1sWKjIM1r0BJvYa0=;
 b=iahbXsB1/7NHzQgKW3OpIMZKm7A2m+/IZPFYj+8ksHpQ984mWMJs0PuE4DRqXzX/WVbkeyJwXAN8WlP8Xw7CNJJruQGUoDMVauDF3MFi6ompOdS+7CCm3jo6/k+p5kl+5ur5xafLeKbKzAvN3oZwvx2sJDNld6MC80POlef83xNoyS8KTlYlGL9vvKcMyF2Ru4WbtLUMxzDQgzvgSMHHEKgHMDYrdvI8lRiMqMEZMsU2tIEYQmoM7l7axpizmlkXjcGQrPa75E/Xt6qYPYWjimHXcxKOJsqquVRvVlsED0LbKvrIWVHtcTZMWVThQGvZ6Cf3OW3nTM5aZyNSb7X/1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1szPMcWraebpb1rXX6KKfmqS2n1sWKjIM1r0BJvYa0=;
 b=lAWojZCmrCB/KjrBnuNFk5Kpsg49FlWqloxgsPLSTHaAYA/Ll9eXDpSmnF3JqviyHuQfJStSAZ32pJWgUC5yIrfw1iHsAm6yS7e0yan1rdwbFeExj5cpZOJNZ0cQe4VdAyYis4T1dvPEHECYGKCM80p64AL/cZ4HQyw/RINvtxc=
Received: from BY1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::11)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 05:11:07 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::f5) by BY1P220CA0011.outlook.office365.com
 (2603:10b6:a03:59d::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28 via Frontend
 Transport; Tue, 12 Nov 2024 05:11:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:11:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:08:43 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:07:50 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:07:49 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 1/7] usb: onboard-hub: Add reset-gpio support
Date: Tue, 12 Nov 2024 10:37:34 +0530
Message-ID: <20241112050740.15343-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 1be5cd64-54b0-4da8-f3bf-08dd02d86a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OyYEFh1faeQaLlLt3DI92VOAWRd1zKKeIW/juRs9ngVhg1PpwuEJnNwCDjM8?=
 =?us-ascii?Q?HKjnefGKn2+Fex7Bmxc1Pf2K62VfTrfDYJx7WWPCn2eLt4jFLLkUsjQhGgO1?=
 =?us-ascii?Q?0+2OkNU4zH76F910BgJX0tBtFWxd5VRzXoM8Wd9h+QaQc7BMZw0pv5Gx/Eie?=
 =?us-ascii?Q?p1MILa8b0cXKBNtiYHW7SE3dMUTrffy0bZa8ypEuoNAlhIjN5zYdbc0Zv6QC?=
 =?us-ascii?Q?T1fRbDdjOHhlZDAyt06zPeJpKCtO9PccklzkPnIEbyK7zf7JPngp77LjbraH?=
 =?us-ascii?Q?yW6dWWQlMGzhds6Wqw4bPA4GXrE+iXEJ8m9pbJ2ZbSRrOadq0qvoIm9xHnOC?=
 =?us-ascii?Q?lbqJaQuu/GzA/l4jCoa6oWYlMAd/SfWGf+VZ8QcZ7PBSEcNs87oY611RTnhM?=
 =?us-ascii?Q?r+v69kRM3N76lrYfxPZYHYYnEIAcFEqfeM/dD/Nveq+Xw+m9DkmLdnW5seNX?=
 =?us-ascii?Q?jHNekt1ZYGLxqIc5uCuivGFCq0tYKJYJzfgCWpI1G+/J+7buNJ/vPh9zUEPu?=
 =?us-ascii?Q?l6UURhsKqrf38NThCpl38uTp5kPf/6LODKzGUrBV5b3nXWf1H1ct0tQ+hKFF?=
 =?us-ascii?Q?bJyLKNWVwyvrNbkqWbaIrgpDEeujogme7cwqJVJ1ZKm/HOSYffaPjTiRE/vB?=
 =?us-ascii?Q?pVmFXN6VlzD5CJboksMafTgWFn71kTT6JKbcwLtBrWuWDaNu2PRHDVygSTQI?=
 =?us-ascii?Q?65SsuH4t80J8yutMe5h4dImRUu+l18DakBk5wuUOani4PH5a8l6zvH6yppLf?=
 =?us-ascii?Q?QJ+kvO87h0fIN4y6maVzWHWn3FhXvWSx/Laz6RPkyy4GSjom4DfXAnUDNMRo?=
 =?us-ascii?Q?Y6/UjqImu6k9xYJAKplvHZJuvJAajoBYwLO0l4hfwhJcLdujokU3OKnShypk?=
 =?us-ascii?Q?m2xe7O5RdPPU6LIVeNc5UuHXE41TkeVptxf6NT9Rln3Vyf/ZBIdVC3cP7L/+?=
 =?us-ascii?Q?PZD2oncdtgjGQ1vkVlHcGwfHOx+kq6V9R2834Tz9UvNNBxFS328nkpX3kikg?=
 =?us-ascii?Q?S/oJ2aH+iJaLVMBpB1lS79Xr+fZRsGJjdUR8j91yhMCsjRseJTU0BHA1kzDj?=
 =?us-ascii?Q?MspjuNfc4ccWN1VbG13C95pU92cO22PwQCg/iaGPtyB6IE8r/iamm1kaVuNB?=
 =?us-ascii?Q?K99s3PWM2+w5rsb6RvKiZlDVm3d3qkzJQQycBZ17Si9k7PCJ/XTKm89vGe6H?=
 =?us-ascii?Q?pw7gtugSGs/qTosiw3zCC5n/PJVjFTGGEMqbpXhr42CY09B1iagD0VMEifnf?=
 =?us-ascii?Q?3fcBv8sk44va77ImByZUlneQMSBKxYBvt+i5H6v5FdwE8DHc/VXe5+i5SMhR?=
 =?us-ascii?Q?4WNGm0Kotj2+92GVWoDcwEzrd4Zlu0CtCFThueCgjJctdmLDwntxg332VExx?=
 =?us-ascii?Q?dpF+Xq69cNl3prgnhirN2sywYYK6wl7N6EycNZqe0f3wVpsPyw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:11:07.1233 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1be5cd64-54b0-4da8-f3bf-08dd02d86a1c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523
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

