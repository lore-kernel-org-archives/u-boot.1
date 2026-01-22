Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF0FCD2ED14
	for <u-boot@archiver.kernel.org>; Thu, 22 Jan 2026 12:51:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5CE3E83AE9;
	Thu, 22 Jan 2026 13:50:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="olGDsWe/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3B0BB83A6A; Thu, 22 Jan 2026 13:50:58 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C6983AB0
 for <u-boot@lists.denx.de>; Thu, 22 Jan 2026 13:50:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K5pwQjGI69mfk81nX3Pyn+cbWCtiM3mUIs+Lsac9wLSkUvyYQgswfVmh3i0ReznASGJpVFrW0xebV3vcATU/byyANe0ICJTlavSP8QGfEkZesT/SgOaNzW0oz/INekpk/d+3ReFobDCMNY0QQpAnKsTl6odCOIQfeKB3sjK0ySOhziBtcsv58fMeNpi88ZRUb0USDsD5+LMqLTryVU0niYjV1w8HRh4CMbfgiwdQDJma9/H7wGxqWQLpWP4SMaGiI8FEMYhoa6PAhTCuk2DRKEI3eCL4g+IDqtpW/ZSGMYAiaIuLk5CFKbLdWa7z8JzSAEWksKv3qW1uFlFAtqmWnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mpv+Qwq5x+yXmWPLK+8k5AnQb0yM8AhCrcpsCAacp6E=;
 b=ZT+JD/GK8UWDQ17dlVjWmdybp9K6i1bax/1gPfUvlec2CCc/yKtKgsLNO4nM6Byk9D6fiOiGoO/akAdk8Q78u3Xp+nDkiQ7DP9HrmehzoBVYzBoLZJ7NCZxyYaiGTJr5y43ykv1eVMOyH3VcyRWL8so0etn62RF4P73lFnNyzDHctx5RGRt9kPtj0g6GAjMshNsKY9Aa+/7HLfLzhpK5BDwKS6VubquKrVf7RWImeH4HEGO/raHux4ntomDA4w40YWqBK27Mdp/uqVRx2Jqs7LcKwHSykPyNH1ZRQ8RFtP+tAdPVyrF+QoaeECfF1zMNlm+ZKAjlPdbjwu65ygLfJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mpv+Qwq5x+yXmWPLK+8k5AnQb0yM8AhCrcpsCAacp6E=;
 b=olGDsWe/aIU+R6uV4SBoJNaqDre4Wz4H/+xBz8vkeRB8RBUtirmcCJXiHykbzpl9J37aUoycLYT5v7AhQh1NZheK4JuDNC4qRSXWcm56+n3PZejpBy/eCGFf+bbD199/sHKB/Jdomvqd4wyH/1KleXL+c1DLYSDsn+idv9+Sb/c=
Received: from CH2PR16CA0008.namprd16.prod.outlook.com (2603:10b6:610:50::18)
 by PH7PR12MB5712.namprd12.prod.outlook.com (2603:10b6:510:1e3::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 12:50:51 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:50:cafe::89) by CH2PR16CA0008.outlook.office365.com
 (2603:10b6:610:50::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Thu,
 22 Jan 2026 12:50:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 12:50:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Thu, 22 Jan
 2026 06:50:47 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 22 Jan
 2026 06:50:45 -0600
Received: from localhost (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17 via Frontend
 Transport; Thu, 22 Jan 2026 06:50:45 -0600
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@amd.com>
CC: Arturs Artamonovs <arturs.artamonovs@analog.com>, Eoin Dickson
 <eoin.dickson@microchip.com>, Greg Malysa <malysagreg@gmail.com>, Ian Roberts
 <ian.roberts@timesys.com>, Nathan Barrett-Morrison
 <nathan.morrison@timesys.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>, Tom Rini
 <trini@konsulko.com>, Utsav Agarwal <utsav.agarwal@analog.com>, "Vasileios
 Bimpikas" <vasileios.bimpikas@analog.com>, Yegor Yefremov
 <yegorslists@googlemail.com>
Subject: [PATCH 1/3] gpio: Add GPIO delay driver
Date: Thu, 22 Jan 2026 13:50:33 +0100
Message-ID: <6a6cd2da427e13bc69d2e0ae4070b715791be02e.1769086229.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769086229.git.michal.simek@amd.com>
References: <cover.1769086229.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5239; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=v+IGz2uwrRq6LPLA/J7BulWb5H4HdCDgG2m6jCsojPM=;
 b=owGbwMvMwCG2mv3fB7+vgl8ZT6slMWQWycqJfoqWMnq+Ib0pzsaV38h0QZeRq+ec41ezzz7zO
 ipX/0O7o5SFQYyDQVZMkWU6k47Dmm/Xlootj8yHmcPKBDKEgYtTACZybQvDXxF2hp76CasXFVpv
 X770GEPPjgTNrIadCkFpW1fVnavyK2Nk+HG9fOVm9RlOfi+T+532X7CUZl2YXyK7/6l31b9fofG
 /2QA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: michal.simek@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH7PR12MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 08dcdac1-d58a-4f2e-e99a-08de59b4df85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GqCL4vbiJaGm8tMtVNlCUJjJz7hnhWmg3VoAsP+4k7fYGO45AoHSwG03mpMQ?=
 =?us-ascii?Q?TXP2E0l7NlKGv8kcHTjqnuAhBywPb7WqKVFbOYQbQ7lJbzPGHsXpz4/8jP+7?=
 =?us-ascii?Q?boxjMG0jjooM1SMRNDEaiSK5N8yIjRyHgtjXxQEqvsiChlyJ907XvEZHY2Yy?=
 =?us-ascii?Q?zBC230U6HGSEjR6fQbJ5uaOQ8HTcZv/3CD94NLceZS/naWkGNtVlqnxTUkdn?=
 =?us-ascii?Q?if4W16NzKda1uGCIFKckKUyowtFxr00UXgNwb+PDAUwxVWdAsb3+/ht+Qu3Y?=
 =?us-ascii?Q?/xT+XsNfwotWqwBJRfPLsLd3lmqy3VYyOPRgtIsL8QtcCfUml37FNzUfcyrv?=
 =?us-ascii?Q?9Uh77c2Vw5HbWJW78Qb6oNV/qQtm8p0bWanF6ToOy1dXgNtaNObeijyS9Uux?=
 =?us-ascii?Q?6F3NY5Oe8sOlwgOW8HJozGWCsMiP8y9RRRtKBkXdNPqipbN3iXtD+6Zj0pmb?=
 =?us-ascii?Q?Za8RUhU7I3EREnb1Fp1qRzwgdlYSWZH6POy3Q6hxTsIPK4ysoI3e+vlwCAJQ?=
 =?us-ascii?Q?YnjS3xEFyoa3ARH56KwdSPbq0vaGXYMbWls4mgL+gC6HPKa/E/7VnIu2rwv9?=
 =?us-ascii?Q?jEgfEzfI/VImOPCLfQ7GyKeQbxUVehkfqihcU/vuJhrejX8YrvKry3ICFnK7?=
 =?us-ascii?Q?IFEYxUwrpp4R2V44wW/N7DnCj9D5LG7a0PBjSI0qou8sqEYD4HA/2kb07ptR?=
 =?us-ascii?Q?qLQLOEQ4wRyTFq1wahw2uWBxqySJHWHjga0egbSmoen1X0wRuLUPY0KwJdQL?=
 =?us-ascii?Q?OSAtYS2NUNKAqGfCR3Ubt4QNP9SVgVElBjVrp8sFsnyLl6Ijf945jce/QhTP?=
 =?us-ascii?Q?3ecK1DWc+W7CoAelIYRZ0EswVyghTY2YMG6kwr/xr+d7Y6vUV4Wkdjr7Qz7C?=
 =?us-ascii?Q?mAqIADbCj+s2ZDpk3A0omjsaF+4ZZOf213o4YFuJ4UQN3aQSelFsWrS70srd?=
 =?us-ascii?Q?1Ine5TOHWbHueJ2qHrJhbVLIcDCQdcSMpAGpztYjTHU8aeWd0NoWJeEA69jQ?=
 =?us-ascii?Q?bAeKABPcsHNcNArm7tg1Tk00aU01fk0xrH3gxKr66jbx5lw4bf+vvHwwPPBx?=
 =?us-ascii?Q?zC6JLZ6hSkdFxoVbbWx8GHkEe7SkkDrpTxAKmnzjLSRij5fFaHVPv6GxWV0I?=
 =?us-ascii?Q?obmz2xSLYyYqfkMRUSvJV9dwIT7mwvwaxPUOSX0DNMuf4smV4VUSCcojvaGF?=
 =?us-ascii?Q?jB9ZgaGmm0qwGhaUgllR8qeEVIrkeTMO8EheXwhKfvTLJ+Drx/GEgUfAMage?=
 =?us-ascii?Q?YrtZP7cOB2sMg9mfnRHFVox5WpGXz1Wd2dET/nFyXWWQw8wx0iB1BV9gHnJ1?=
 =?us-ascii?Q?z0N4o1MYQQ/ZPgtKrxr0oq00fzIilg9WSrsGDV7W0Y2HiN6TshTSAO3jnzq0?=
 =?us-ascii?Q?IDAyDKf9JWdlTuBZzh/R67/V816fRh89p9GHWZARV8KnmW5pVU9BK2mtESvX?=
 =?us-ascii?Q?zmzQfYegPUC0arFLx572nSBHEAZ5TnBvn8SXdtpY3jZ8tzqQJgj8jXN+cxuT?=
 =?us-ascii?Q?qciV9hpQuHGHoCeKydE7jMsHz8a5rZg4zwOVCHucpv60MuRJFI0nnC48enWk?=
 =?us-ascii?Q?LPaifhA+LIJGuf+nE6+a55+8y2GFdYwYRoU2fITvErCiJXrAHBr6AKNt80sc?=
 =?us-ascii?Q?PUOqgV8qXz2r6tHVEHA/ffv9DvQHDDHJxKsCm1azeJfSzQz71BKr+OpkVEZX?=
 =?us-ascii?Q?wtUBNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 12:50:51.1991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08dcdac1-d58a-4f2e-e99a-08de59b4df85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5712
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

 drivers/gpio/Kconfig      |   8 +++
 drivers/gpio/Makefile     |   1 +
 drivers/gpio/gpio-delay.c | 133 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
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
index 000000000000..0c0d05ccb493
--- /dev/null
+++ b/drivers/gpio/gpio-delay.c
@@ -0,0 +1,133 @@
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
+	int ret = dm_gpio_set_value(&desc->real_gpio, value);
+	u32 wait;
+
+	dev_dbg(dev, "gpio %d set to %d\n", offset, value);
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
+	return ret;
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
+						 &d->real_gpio, GPIOD_IS_OUT);
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

