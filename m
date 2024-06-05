Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF58DC27C53
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:03:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAC1F883D3;
	Wed,  5 Jun 2024 12:02:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1htN3K53";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1180D88369; Wed,  5 Jun 2024 12:02:52 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:240a::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D2C88883CF
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OvY9FZlYDiw6qMZ3rYKnNh1pmBq3B4VuhvL2k06r5Uv8GkE+MJ7BMcC9Bhs0n/ESaTZbOrhNYjVLyqKS3JBhtzLQdavyTNJH3CJcnoA29UNAtGGFM49ptY8eUdJfs52i5vJts9nIy+Z3o1A8uudxOaVtaoDI2ZzYY7ullxRwBF20xryVkAgxnSp4uuBtD63GYDBhyffh6S598D8YrvmYjOqlf0v0rXEhCzDOF762fEZ5x8FBHlkJyRi0yJaN9aP0eCVgE69jUzrwXUg0LxeBbtqeiWFjfffotZYsUWP4BzDUwiEP44W5lXqUsxWYktpGuJnpM6TFvHskEIbTzplwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ShcBO4Plu/a3XSpPPVfgSogA6S3BhPE4jwB7F0CsAJc=;
 b=c86GcJLjkncrhqSyq0zwgSmyhzkoMZyj8e7oAwIE4lnKYsTlXkJf7OvSM1tVl+KPRhYGUd1u82Lx2l9zPVTnupb27k14DdiyFkFjN4wc/Z3OnfJu++b8gFlM++SPbSH/0VKLPjp6iSuUu6z/fmnW4TYcHa7Y3As5WeVoaq9sRRPt/A08NWetdHAmlpaMc2kYRqH6K1L0wB+bXmRiIrE9oKqxzPxDiolLCtGYlVmRNC/3hxfyUqkRws/JTocP+nAfqziCWRimnMXZe17uVUl/9lydmY0TGDf7pq/M0Cy0RiVJgN7NoUZD42hCBV1eOISe8jfO1I4if6a4SIb/TlNMng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ShcBO4Plu/a3XSpPPVfgSogA6S3BhPE4jwB7F0CsAJc=;
 b=1htN3K53L2lLszmoyUVh4yQNLC4L5IIqSIXe4sHlJbqAj/vOhzI6aLZAQyENERDaCAYnyZcFLHk8Y8s76BDyqLtOqPS7yzAk60CsKcl62ap5X07MZO6t+V//IjW9i+yUmxqgBYzqNQC+UDleT9FysS9Vl+tZdKK3GmL1CG3XFX0=
Received: from DS7PR06CA0040.namprd06.prod.outlook.com (2603:10b6:8:54::28) by
 CH3PR12MB7570.namprd12.prod.outlook.com (2603:10b6:610:149::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Wed, 5 Jun
 2024 10:02:42 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:8:54:cafe::19) by DS7PR06CA0040.outlook.office365.com
 (2603:10b6:8:54::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.29 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:41 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:40 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:38 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 5/7] usb: onboard-hub: Bail out if peer hub is already probed
Date: Wed, 5 Jun 2024 15:32:19 +0530
Message-ID: <20240605100221.3571-6-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|CH3PR12MB7570:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c7423f4-4638-4690-94e9-08dc8546a36e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|36860700004|82310400017|1800799015; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8QLY8AEUrbMpEeid5alu9CvjjVS92ayjTMc0EmtVK6Ov7mO4Bh8O9yBxIBMR?=
 =?us-ascii?Q?2tTdJVDqO1GDrfJ2Jbt3SfrY3UBUOXXz/brF5HiCvCbDiRCNP/OH3ggtykYo?=
 =?us-ascii?Q?mvTHhwCGogp/VNOilsh95ZZIC4PAHdGxTnnrPeUyW8+WxiZO/y587R+ebYh/?=
 =?us-ascii?Q?IPAWBq/HNXYjLNipLbHkp2cZZLdHv/gBp2DOeZU+6UWFgVRTY1/GXW39nF7f?=
 =?us-ascii?Q?YiFC8WfGZgBkGMsEMLJr7dU/1dATHtgaYc0hYe5a1n/JxsyBcMmgmL35UYYO?=
 =?us-ascii?Q?qaKAQEnlyPEEbKFXb8KLqXCARfi1X5zuF843CEMoCl+B0EnxnMVam/97kbiu?=
 =?us-ascii?Q?KfeWM7plZ40HGb45N7F0hc+44mcCqGfT/ixBCeQLN6DS5RQEbfa3s/OIcdc4?=
 =?us-ascii?Q?u3yWN1A7CySym1vNoOKbuBpNLDNjYUvmAozAhPBqoclTtAovvNGTVfPtAThz?=
 =?us-ascii?Q?VLUmmB/kLkL28MnNJVj1mKZlhz7AEXBJDFUCaVtTn0cC39N2iRBh76L5nrRV?=
 =?us-ascii?Q?KCFvy0Hi5Fho2StjESuPbjPqa0AsKxw+nZuGKNc90QqjEZhJIOPcWHOCqsRE?=
 =?us-ascii?Q?AWqzq4WClNd9eclCZveC6Xb0U1iD3BqZGz+29JI1T2LZrPgwd+LW+EukOJ0+?=
 =?us-ascii?Q?NreLw3GSwG8AnEd9Zs+CAuXVSbyMr3PNp6iMivU9aJGtUUg2fsEXcy5vGSNK?=
 =?us-ascii?Q?Y/8W3i2uVZVA7qc8a7RhqGSJGM075ULIi6dIVfN+3XjOCbM8abYeLx+X9MpA?=
 =?us-ascii?Q?mbFkY8XLvgV4JXfB9EFCY5xGnoHtRTw4ZvzYmpFRv3+6Cb5bLBuZGeZ3Bbgp?=
 =?us-ascii?Q?+XZj0oeS+OZ0LnL++Cuh64u6i3Azt4ZiGurJrB1PWr09nB1q3NdFuFK8fZBX?=
 =?us-ascii?Q?3047Lgrm40x4Num2JiX/k/biQ0mNhXeC93OK094fYpvYCeLQFcBGQ4Ot8U9f?=
 =?us-ascii?Q?giODWo7HEXAs1Pqiltsjk0EPj3w7a4x8pfAlzQ0UtgNBhFLtiYk1DrHZQCsR?=
 =?us-ascii?Q?4RFewJrGaQLcyb/SsXP4baJJ6VGpGOaiBlrbv5REQjMMle71KkO6pltFimTC?=
 =?us-ascii?Q?oKFHH+1mzp5adRSfrWsUd2vadtVlCJa7IH/+ub71VDHXv1tmJ+vOUHknFMGt?=
 =?us-ascii?Q?6oN2+TcE/QhDm4FTMnH5Y9UKrsg2zaYAE6tnezRv1iqfvH6JL+1W2E6s8aJ7?=
 =?us-ascii?Q?e8rL3dzsAbXDFUb5zC7W0cN5xkC9NdYxP3CBUJg97br/J0HvU6xY8JDO/mF1?=
 =?us-ascii?Q?qcJrbTEs32j1M5GlUARRUvfMNrMUJIxPTkX2XZd4VcCv6RiNYsgICll+DZuo?=
 =?us-ascii?Q?LofBUY0dhZAlhN+PVVzOft/vrAtkpNUDiwp4kq+l4ahWwQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(36860700004)(82310400017)(1800799015); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:41.2624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c7423f4-4638-4690-94e9-08dc8546a36e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7570
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

Many physical hub chips include multiple logical hubs to handle both
USB and 2 and 3. Both logical hubs will then match the onboard hub
driver, which means it will end up with two driver instances trying to
control the reset GPIO that is only present once on the physical chip.

The reference for this change is taken from
https://lore.barebox.org/barebox/20240327165554.894805-1-l.stach@pengutronix.de/

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 09ce452af1b..519bad337e1 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -11,6 +11,7 @@
 #include <common.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <dm/uclass-internal.h>
 #include <i2c.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
@@ -21,7 +22,7 @@
 #define USB5744_CONFIG_REG_ACCESS_LSB 0x99
 
 struct onboard_hub {
-	struct udevice *vdd;
+	struct udevice *vdd, *dev;
 	struct gpio_desc *reset_gpio;
 };
 
@@ -106,8 +107,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	struct onboard_hub_data *data =
 		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
+	struct ofnode_phandle_args phandle;
+	struct udevice *hub_dev;
 	int ret;
 
+	if (!dev_read_phandle_with_args(dev, "peer-hub", NULL, 0, 0, &phandle)) {
+		if (ofnode_valid(phandle.node)) {
+			ret = uclass_find_device_by_ofnode(UCLASS_USB_HUB, phandle.node, &hub_dev);
+			if (hub_dev && hub_dev->priv_)
+				return 0;
+		}
+	}
+
 	if (CONFIG_IS_ENABLED(DM_REGULATOR)) {
 		ret = device_get_supply_regulator(dev, "vdd-supply",
 						  &hub->vdd);
@@ -148,6 +159,9 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 			return ret;
 		}
 	}
+	hub->dev = dev;
+	dev->priv_ = hub;
+
 	return 0;
 }
 
-- 
2.17.1

