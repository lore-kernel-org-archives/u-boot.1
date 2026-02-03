Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE745E8305C
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:53:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4496683FF9;
	Tue,  3 Feb 2026 08:53:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lXLiOBpf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 09B5883FC8; Tue,  3 Feb 2026 08:53:04 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C373983FC8
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:52:56 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kO9CJy4NeMyf5/3j56KBVPg9fY/7F1F6uJ0DinclKJ874V/zBA01EG0nERzflsjp8icHrchKG7Twr3L09s+IyVHo/9WroLJduJs7/z8BoBifguD67TsxjATyeZYE/BWDR3ZspJS/ecmErcuS/ijPCsxPiH7f7ywyUIPUL8p0B+HS2tAdrjUgvm6DQh0eOYJ/XF0ovgzGWadwoTOjcJvjV/OtqVY4o8HpZHM/TpbVPrSESeQhz0NbUrasCopExD6Nt7gipJHN9TkDr9vBxO0D30jZryTQePNEpwYIfW7dIhmlqp4OIkLp2N6VhjFn7SOwsZGjOx9UT9UF0U3LfEN9gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdlchwLFw3VI9tcZVP3+meRcUwCnSzGVg41Jz25cUxk=;
 b=ABFPVK7uRT6iIcnc3VMZCk2BCrPHTPsrDBEb9BgH8KcJMYAbQbVB0OIvduCgSJl/CQ0z5Dn0TRuxDTLsgobbNxSQ7ksO42tWTA4IxKwhXk+gxiqSxyY/oPrvfYGKHgt268fdmYUZGZ+Zx/t61jjfZw7q8GTInj6POkrRMoAlrpObjRjVwbQjaHvySqnnHze/uBM0DVW/BWCIfw79CHU5cigRamutYz9m6gHkPjcB6cTBwBl0Dmj9DVZ78O8pTnnySib8dasH0zHzkfq2ieD4AwaLjzyJEBmbJRp+NBrS6gresZB7anBwdm+7V+xKss8IrwwVOGzfGGsn6vxH+jmW2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdlchwLFw3VI9tcZVP3+meRcUwCnSzGVg41Jz25cUxk=;
 b=lXLiOBpf8liNygKyttmdPAVWviZeO1ovngg1h+JGDXmi7r6IuTmYdiI30pcy71+SaCG5G6I8M4BHTgxo8NQqVfrCWChBAwfJ8x1ahf7ipU8CpaqePOa9JB8QqmtjOqxiAFOh+jxJaDwhnNMeocv64csTsi5waXtAPldCvDp3Jvc=
Received: from SA0PR11CA0134.namprd11.prod.outlook.com (2603:10b6:806:131::19)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 07:52:51 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::4) by SA0PR11CA0134.outlook.office365.com
 (2603:10b6:806:131::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 07:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 07:52:50 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:52:49 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 01:52:48 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Tue, 3 Feb 2026 01:52:47 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Arturs Artamonovs <arturs.artamonovs@analog.com>, Eoin Dickson
 <eoin.dickson@microchip.com>, Greg Malysa <malysagreg@gmail.com>, Ian Roberts
 <ian.roberts@timesys.com>, =?UTF-8?q?J=2E=20Neusch=C3=A4fer?=
 <j.ne@posteo.net>, Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Oliver Gaskell
 <Oliver.Gaskell@analog.com>, Philip Molloy <philip.molloy@analog.com>,
 "Rasmus Villemoes" <ravi@prevas.dk>, Tanmay Kathpalia
 <tanmay.kathpalia@altera.com>, Tom Rini <trini@konsulko.com>, Utsav Agarwal
 <utsav.agarwal@analog.com>, Vasileios Bimpikas
 <vasileios.bimpikas@analog.com>
Subject: [PATCH v2 1/3] gpio: Add GPIO delay driver
Date: Tue, 3 Feb 2026 08:52:30 +0100
Message-ID: <575998efc6ba0e405640789cf8d05f0b633f496e.1770105146.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1770105146.git.michal.simek@amd.com>
References: <cover.1770105146.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5455; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=+HixeVndBLxs9HRMxAOLxdlSmc+gEiXDj6ORzxaVbRc=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQ2rnRm6T+1iTXu/CwRQ5nzKefrzzk6Tmd9wn9YRJqxd
 F9KZaVIRykLgxgHg6yYIst0Jh2HNd+uLRVbHpkPM4eVCWQIAxenAEyk4zwjw7dl81b06dRwvmjZ
 0prM+JfTfZ1J1bJr3NOr2xUYriVN2MLI8ObaG4lpc6XnMvKw1D72XNmz7bh9vslaFQaZGuvY1C1
 G3AA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: d46cb863-2a8c-4dc4-a9d4-08de62f93ab9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E1mhqt9+Ie/XotXKEoeLRRIk0eKJNjn7pj1wp/F4ajZqTnnTRfQeqCKKTv0V?=
 =?us-ascii?Q?3KkCLJs1UikDymVlh9ItwcEIJyFrSOF7Zi+q4/kJA0a1mgzMTzAXYVA168Zp?=
 =?us-ascii?Q?OIqux70ji4IFTMr4GqQs7dZ+EMTTuqi0GQisNKG4BmeKu997kYRovB/8jxoy?=
 =?us-ascii?Q?g3ibDiagvm1gpuA9HBBayKydtT3leFD1kr9PGgravT5xPSbvWOMkr3x3KGCC?=
 =?us-ascii?Q?S0x50gnPvkIqvBBSbJocxuecObteKCMLacyptnFUJui61Dmq9oaU7ziEA5+a?=
 =?us-ascii?Q?hCzT2UHAYKAdiQUMNo+ejXOBX6Kztc0OBN7zEl3zxUXUHC1Sw2rImbiMxys4?=
 =?us-ascii?Q?KtOvDplzYuUSboBRJEAqTqxfo+ys59blRCoyFVbdZ2pmL5eGZ9cmK1zIbuFs?=
 =?us-ascii?Q?EOhF3+l1B7xNCWaUbunzKdAex2w5PcBufDbb7icS+8QF+B0Km/UI4rPMof0n?=
 =?us-ascii?Q?jQOUDT3Hz0PSbD39ycnYBZK09Os8VoiSWWCzn2E1hM/NY1LycdOMduB+2PW2?=
 =?us-ascii?Q?5TXDZEPEinh1Plagmhch3IMyaJry+9EO+QUgiRFKL+hOQoNi1Dqw/BdaEZCp?=
 =?us-ascii?Q?wZ+YIXfpFlFzGTNFQ0p1UlVU/v/lTGEkvu9B+4YQowLlit+MR94hm9tGZKLO?=
 =?us-ascii?Q?oRmj7C4emFtUW1sSa2B/DcgQXPsgA3TgDRulx3FTBgaittTcJNZJ5Pof2/14?=
 =?us-ascii?Q?8oEnjYbG0FtfsfaSBG4RDL8BKwHKxUVqMMssvQ5OP9qunq5eHqypq94pLhe0?=
 =?us-ascii?Q?/GXMfDuyVUA0h+44ShZQekf/Ms27KaL/zCDSUEj4xJKD3GjUJZVYDw3elW/X?=
 =?us-ascii?Q?iOOTZWjxoU9gVfgT2ocor+gPS6aXAoy4+xMkRy+oUDYYbgureRVhFF3OVmyd?=
 =?us-ascii?Q?KuUW7z9FYw/VFi1PnxRRMQDAf2u+atSo1hkzrItbBmcS23WdbgWnlGHfI0jh?=
 =?us-ascii?Q?0nEv7MMpNVVRCowFXJmpcZ9V8dstbH7baHR1FmauettHuk1iHMb6hE9tf+fi?=
 =?us-ascii?Q?t+bD3yoMNgtlmP58ZhUbHcjzCsDskM3+gP6KYXxwhEES7TCMVo/MY6LYxNMg?=
 =?us-ascii?Q?bB4DUX+fsVFC9XTdjecbV0n6nARpIPMjhFqXCIGmCIPLPPeZiPUbFSrPXoTN?=
 =?us-ascii?Q?bYx8Hw8XeCq8subom4lzsLV2ZjGseZMl7jvzgTguFdzNqW5h3SnNBkI3N54b?=
 =?us-ascii?Q?MhBQrmyJbryWATaWrLOBRMCZegiFpDpnlC/H0rtUGuTbmKQxQ6/7mHN04i98?=
 =?us-ascii?Q?v7k+ifWQqUhLzi6v9vPK2MT7/ixquX8k9qoOEYO2u5qHF1e3ULd0ERYYxgIO?=
 =?us-ascii?Q?WZr3QW5NG+/KHYRzaIEzIk0lUaC2YxrPWUxYzRrJz3QQLlh0OmZqA1MLVie8?=
 =?us-ascii?Q?MQs6d/icEN4qJcAJu2I4apYdrakD0QHpuzP6B/HTQx51eOmJayZuBHFqwXED?=
 =?us-ascii?Q?R3K6SzIbTGD3SwGHlyv95eFoDVd/+Mxq7Tk2RWO0vuKhVw+Jvt5y+bJmC0FL?=
 =?us-ascii?Q?5O66odq/dLV1W4RlKN+Mnf+0PyEtmB6CVrczSfDf87gQC72KxOv9dCfaIEBm?=
 =?us-ascii?Q?9jOreuY5MdZ53eS1I5TCjHsPxTCSMw4EbdlaESan59PGFfgRTj4WdCmzkNSb?=
 =?us-ascii?Q?iudNLSXbX9ODx3iSgbw44AVvUitVdggXanqbfCev2BWbxw/ni1eF5XXQQBHV?=
 =?us-ascii?Q?0NrZRA=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fpOf5T3y9zs6+ZFEnCkYaI/ellYSRAmoz84zMxZbpmDHnt4UVPbpbK6ylrQoMyA2ffs4zibDhwMk6ViL+MeHG6TXy/6U22BUTaIIQDgJPAsrpvGqc+plvro88QHvrUaElSxfjhKg9pTnnZ8M4XDL2so5tnnzhWUzF9RVCaa75hS1oyOageg2605ZydnS1GjrQl1/8bWExRvqPCwBXnyjaiF0mo4u/BK14vsaWqO1gU14CGLQFLfdnIfMl60+x4AQpX3BNcK33b7pKceF3dKFSKWv1XGPkImLEfiOzfni6ZS+Ex/SqxjilwRhftXPPvtmW81Ax40xdlNVwgp4u+KHtHpIdUsjYtYVv2rz8kaWCgSQL9zGR/G90SjOiN/6hlGl52okiP3JyPBeVlLt2fdG/1mE5JBI7UG2eKCkrHptwPXvVoXh5/k2QX/O1QERVNA7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:52:50.4360 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d46cb863-2a8c-4dc4-a9d4-08de62f93ab9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

Add a GPIO controller driver that provides configurable delays when
setting GPIO output values. This is useful for hardware that requires
specific timing delays during power sequencing or GPIO state changes.

The driver wraps underlying GPIO controllers and adds programmable
ramp-up and ramp-down delays specified in microseconds through the
device tree. Each GPIO can have independent delay timings.

Device tree binding matches Linux.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

Changes in v2:
- Check return value from dm_gpio_set_value()
- Do not use GPIOD_IS_OUT when requesting gpio

 drivers/gpio/Kconfig      |   8 +++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-delay.c | 139 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 drivers/gpio/gpio-delay.c

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 60c5c54688e6..f69919abc05b 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -1,3 +1,11 @@
+config GPIO_DELAY
+	bool "GPIO delay driver"
+	depends on DM_GPIO
+	help
+	  Enable the GPIO delay driver.
+	  This driver allows wrapping another GPIO controller and inserting
+	  ramp-up/ramp-down delays on output changes, as described in the
+	  Linux gpio-delay binding.
 #
 # GPIO infrastructure and drivers
 #
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 910478c0c7a9..fec258f59f52 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_ATMEL_PIO4)	+= atmel_pio4.o
 obj-$(CONFIG_BCM6345_GPIO)	+= bcm6345_gpio.o
 obj-$(CONFIG_CORTINA_GPIO)      += cortina_gpio.o
 obj-$(CONFIG_FXL6408_GPIO)	+= gpio-fxl6408.o
+obj-$(CONFIG_GPIO_DELAY)	+= gpio-delay.o
 obj-$(CONFIG_INTEL_GPIO)	+= intel_gpio.o
 obj-$(CONFIG_INTEL_ICH6_GPIO)	+= intel_ich6_gpio.o
 obj-$(CONFIG_INTEL_BROADWELL_GPIO)	+= intel_broadwell_gpio.o
diff --git a/drivers/gpio/gpio-delay.c b/drivers/gpio/gpio-delay.c
new file mode 100644
index 000000000000..9105deecc4f3
--- /dev/null
+++ b/drivers/gpio/gpio-delay.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 - 2026, Advanced Micro Devices, Inc.
+ *
+ * Michal Simek <michal.simek@amd.com>
+ */
+
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <dm/devres.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+
+struct gpio_delay_desc {
+	struct gpio_desc real_gpio;
+	u32 ramp_up_us;
+	u32 ramp_down_us;
+};
+
+struct gpio_delay_priv {
+	struct gpio_delay_desc *descs;
+};
+
+static int gpio_delay_direction_input(struct udevice *dev, unsigned int offset)
+{
+	return -ENOSYS;
+}
+
+static int gpio_delay_get_value(struct udevice *dev, unsigned int offset)
+{
+	return -ENOSYS;
+}
+
+static int gpio_delay_set_value(struct udevice *dev, unsigned int offset,
+				int value)
+{
+	struct gpio_delay_priv *priv = dev_get_priv(dev);
+	struct gpio_delay_desc *desc = &priv->descs[offset];
+	u32 wait;
+	int ret;
+
+	dev_dbg(dev, "gpio %d set to %d\n", offset, value);
+
+	ret = dm_gpio_set_value(&desc->real_gpio, value);
+	if (ret) {
+		dev_err(dev, "Failed to set gpio %d, value %d\n", offset, value);
+		return ret;
+	}
+
+	if (value)
+		wait = desc->ramp_up_us;
+	else
+		wait = desc->ramp_down_us;
+
+	udelay(wait);
+
+	dev_dbg(dev, "waited for %d us\n", wait);
+
+	return 0;
+}
+
+static int gpio_delay_direction_output(struct udevice *dev, unsigned int offset,
+				       int value)
+{
+	return gpio_delay_set_value(dev, offset, value);
+}
+
+static int gpio_delay_xlate(struct udevice *dev, struct gpio_desc *desc,
+			    struct ofnode_phandle_args *args)
+{
+	struct gpio_delay_priv *priv = dev_get_priv(dev);
+
+	if (args->args_count < 3)
+		return -EINVAL;
+
+	if (args->args[0] >= 32)
+		return -EINVAL;
+
+	struct gpio_delay_desc *d = &priv->descs[args->args[0]];
+
+	d->ramp_up_us = args->args[1];
+	d->ramp_down_us = args->args[2];
+
+	dev_dbg(dev, "pin: %d, ramp_up_us: %d, ramp_down_us: %d\n",
+		args->args[0], d->ramp_up_us, d->ramp_down_us);
+
+	return 0;
+}
+
+static const struct dm_gpio_ops gpio_delay_ops = {
+	.direction_output = gpio_delay_direction_output,
+	.direction_input = gpio_delay_direction_input,
+	.get_value = gpio_delay_get_value,
+	.set_value = gpio_delay_set_value,
+	.xlate = gpio_delay_xlate,
+};
+
+static int gpio_delay_probe(struct udevice *dev)
+{
+	struct gpio_delay_priv *priv = dev_get_priv(dev);
+	struct gpio_delay_desc *d;
+	ofnode node = dev_ofnode(dev);
+	int i = 0, ret, ngpio;
+
+	ngpio = gpio_get_list_count(dev, "gpios");
+	if (ngpio < 0)
+		return ngpio;
+
+	dev_dbg(dev, "gpios: %d\n", ngpio);
+
+	priv->descs = devm_kmalloc_array(dev, ngpio, sizeof(*d), GFP_KERNEL);
+	if (!priv->descs)
+		return -ENOMEM;
+
+	/* Request all GPIOs described in the controller node */
+	for (i = 0; i < ngpio; i++) {
+		d = &priv->descs[i];
+		ret = gpio_request_by_name_nodev(node, "gpios", i,
+						 &d->real_gpio, 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static const struct udevice_id gpio_delay_ids[] = {
+	{ .compatible = "gpio-delay" },
+	{ }
+};
+
+U_BOOT_DRIVER(gpio_delay) = {
+	.name = "gpio-delay",
+	.id = UCLASS_GPIO,
+	.of_match = gpio_delay_ids,
+	.ops = &gpio_delay_ops,
+	.priv_auto = sizeof(struct gpio_delay_priv),
+	.probe = gpio_delay_probe,
+};
-- 
2.43.0

