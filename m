Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F9A4C25B75
	for <u-boot@archiver.kernel.org>; Wed, 29 May 2024 14:48:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B29B18860D;
	Wed, 29 May 2024 16:48:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hX4Whnj7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 293548860E; Wed, 29 May 2024 16:48:28 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::62c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BB36E883F6
 for <u-boot@lists.denx.de>; Wed, 29 May 2024 16:48:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnG163TTa8snXyTHeOCU7N65yei26vedbEjkmN9xFE3XqnTJ/zJbmnlDsbz6X7QP0Ek6ubcpKTtlweJxITaBXoiXqT0rMmsP72r7AYFI5i8D79lO47DKw0L7kICltpzjaMol7rrrlKWfcSsUIhxJqoDFvz3bKv9uQAsFmjcwvEz8lT+h5jj2ln7V39nuIBTwnwXUdWMZhuaEV6KuvX/0nWUt3CquXCSasWn7QZN9TBe/ZYkd5yWQWCMlZtFsDdvg2eLQb6/8T1t/sPPgSZURpoCPvUKi4f5ZxvqC1T9kpI4SNjDnYa5WE4+mr+m1bnbgBdWft6bhlUEBiHasu63TqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yc8D0p2FoGUcPtWTTBvlyYUJfIxJHD7WFEOLnbYb/2g=;
 b=b5XtJyTMYzyt/snaIWh9i8bfEFuSoaX8sAL9ePFi3iw8zVi6te2Gfm7D+1N2I6GAb6BzP2L7cjI4gUhPhta2JBh8k/oebWJmHte5nMQI/PTRIO+fuoUQgfS+byrgaDR845ddYaR1uHNcC6OPwbSp2R9gjLnvkmkvm5igSDxrD7m5yi1LnzCNu4Y/q9uY3cL+wzDe6dMsrtdbPQVSUc3h6dHGX8FibI4hIglgO9bmayGRyX+jNbTZHo2CW2D2hbataztc2+LQ5dGurOjCVlvVxKOyEZ9xz/4hnpaB9IYa1r2TCWOufIWKAblW0cs2ASVrlWiokTNLz+m8ByK2Cd4Cvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yc8D0p2FoGUcPtWTTBvlyYUJfIxJHD7WFEOLnbYb/2g=;
 b=hX4Whnj7ldEIVhzQI78qYB5GWk+0TF24Hj/Snwb8r6m9C6K4kUoO7cWiijd8URSy2uOKWOQSmb6ol+r7nBwWzWzsZK6ayE3og5GaUnakQaoY+I7I04tDcpUjDpZcXVvFLudUl9iahKY/vXnWV6eY0N5GHYmJZ60j51j4Treydrs=
Received: from BN9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::31)
 by BY5PR12MB4163.namprd12.prod.outlook.com (2603:10b6:a03:202::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 29 May
 2024 14:48:20 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:408:10a:cafe::dd) by BN9P221CA0011.outlook.office365.com
 (2603:10b6:408:10a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30 via Frontend
 Transport; Wed, 29 May 2024 14:48:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 29 May 2024 14:48:16 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 29 May
 2024 09:48:15 -0500
From: Michal Simek <michal.simek@amd.com>
To: <u-boot@lists.denx.de>, <git@xilinx.com>
CC: Chanho Park <chanho61.park@samsung.com>, Minkyu Kang
 <mk7.kang@samsung.com>, Sam Protsenko <semen.protsenko@linaro.org>, "Simon
 Glass" <sjg@chromium.org>, Tejas Bhumkar <tejas.arvind.bhumkar@amd.com>, "Tom
 Rini" <trini@konsulko.com>, Venkatesh Yadav Abbarapu
 <venkatesh.abbarapu@amd.com>
Subject: [PATCH 2/4] soc: versal2: Add SoC driver for AMD Versal Gen 2
Date: Wed, 29 May 2024 16:47:59 +0200
Message-ID: <22cf9c765e47ab03dbf2b8363e6626e809113432.1716994063.git.michal.simek@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1716994063.git.michal.simek@amd.com>
References: <cover.1716994063.git.michal.simek@amd.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4148; i=michal.simek@amd.com;
 h=from:subject:message-id; bh=fp0ZLsq2V0VAFore2H0Q6JBG7xXCs40ptgEm7huFFso=;
 b=owGbwMvMwCR4yjP1tKYXjyLjabUkhrRwB1kTvrOXPjOd2FE3K/zjkfIvLAIXvjBdtuzXLFfw0
 nqx6bBoRywLgyATg6yYIou0zZUzeytnTBG+eFgOZg4rE8gQBi5OAZjIzUyGuTKJlicWPtL+oan6
 a76vZDS/uPWC+wwLZnNnrTr2bLK3PTfXroOC5men/LW4AgA=
X-Developer-Key: i=michal.simek@amd.com; a=openpgp;
 fpr=67350C9BF5CCEE9B5364356A377C7F21FE3D1F91
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|BY5PR12MB4163:EE_
X-MS-Office365-Filtering-Correlation-Id: 8012da78-0466-4a26-abe4-08dc7fee5ff4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|82310400017|1800799015|36860700004|376005; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ExNF11lwikseZhI3AOgmFrOcn6uzkLXieWwhH1u0Pac6Tdmnn1nuhdEzSjZm?=
 =?us-ascii?Q?dp7p1Cu4VtveNkkbA7sv1Ofmwzpx1w54UNmwbM/ESK/vzD5AU5nwAsr724g0?=
 =?us-ascii?Q?ZQ4Q8cuKoByBPNOHDMG2BChsUvK3ph32QlQS98puJyP9IDsZNSeWx4v75IkD?=
 =?us-ascii?Q?htdCJUfwhSEP4YEnW3yrGBIK0QXls9nuJZ3z595clh11v2zDSXqWx3QTWr5x?=
 =?us-ascii?Q?TfNdPWNUx35GSwvlC46sT2eEYs702ZE38OzSlXUiAewKb1xLEx4jebZuWZzM?=
 =?us-ascii?Q?s2UVaFwS0vJyboSbJh3QKtwplrn0QNxJNq2xzaFOdfjkWqdq46DF6ZL4mMu3?=
 =?us-ascii?Q?jygD0dKwiDWx6+KrWtOA6bS0SRmQl0loSIJ9jtcmkc0yEJ4uesRI/spiknC2?=
 =?us-ascii?Q?GYFEl0ymlfDozR9YGWpfG6HfPXoVkkVM4Y0d7vJbB4u8ZZRS/d1KrjUDpzVd?=
 =?us-ascii?Q?ayij6uAO5WFWlM8Odpepv4FIYBHcLY4Ji5y7IlD9FUf53XAmsxhJR+AEEKmH?=
 =?us-ascii?Q?VDwh/hFrm+KjrRo2R0oCx0dr6afj0JLDvErL2S6IAUmGrqua8Mux5LODK8dB?=
 =?us-ascii?Q?nFvSsq0pIweoT1HjHYfNJ46VNwYgYcZFOPbynpMHy+4EHhMXncOSW3IahhQh?=
 =?us-ascii?Q?NV/3bhy0lx7WjtdlGQE8y1C6F+10TeQpOsrfIlaz5HOirrPzsFkE0vQjfgoK?=
 =?us-ascii?Q?9+4GFF2oP5wehnO2Cgqt8jhAWjWogI8olxuR7n7jEkmPQ0zy4/BTr3UCcEmY?=
 =?us-ascii?Q?iYav6wYrOHa9ytiMtGBofTQopygcclBxf5qxG+sekApZLXQkn7a3WPixv1GH?=
 =?us-ascii?Q?cY8H1rLFPLsdxd2UJop2BrfK/mHBHoWlxk6bfIfys86kTCeGolrtFZlJ5KMB?=
 =?us-ascii?Q?xJX8XgaJYApAYR0Gsu8T42F7iwOmbGEsMiQSQMNHe82FSGIfsyafr3yjmA2r?=
 =?us-ascii?Q?N6Ye2At2nPlurbQyDzsrr3z5rBYPhJ/DV2qEDXXbXHCpZBwjrpnFerIWqlij?=
 =?us-ascii?Q?XRKw8dGUA0P4vp1DiHBcfUYyqTZzh2v9fVPCjbP/7WkrTiZSFgFOAjOv/axr?=
 =?us-ascii?Q?vpCrMxui39Q5eYzIYOgkcp+/IHsDRxkuQgyqkHS+pWkAfMY/OC6ATKXx72S0?=
 =?us-ascii?Q?VJbjfbEfZgEz94slKSuMEWSktoV+1+rnOb+mmMpjlm7pKfH2O9o13m4/fVgV?=
 =?us-ascii?Q?c86yjX5FMgkiaJNT+5zX02tAXeYYpElNkoVh5vDXLgOFNFuQi6Dc7aiMDdPy?=
 =?us-ascii?Q?0WhUb7E/kPDk5TWT9tOFgzc3RlpgqcrTcy0LCe0epYuaBDxxDhWeVZC73h4f?=
 =?us-ascii?Q?5DOc3+McsB46dS2/9lDtRfCiwTiqjOJvsUVqee1LlJgBKrJdzhyOYEcC9Emb?=
 =?us-ascii?Q?33isrSG2OpsomR97x8DCsjx0ZkJq?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400017)(1800799015)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2024 14:48:16.6238 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8012da78-0466-4a26-abe4-08dc7fee5ff4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4163
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

Communication is happening via firmware interface (SMC) or via direct
register reading if firmware driver is not available.

Also enable it via defconfig.

Signed-off-by: Michal Simek <michal.simek@amd.com>
---

 configs/amd_versal2_virt_defconfig |  1 +
 drivers/soc/Kconfig                |  8 ++++
 drivers/soc/Makefile               |  1 +
 drivers/soc/soc_amd_versal2.c      | 77 ++++++++++++++++++++++++++++++
 4 files changed, 87 insertions(+)
 create mode 100644 drivers/soc/soc_amd_versal2.c

diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
index 5eea07f03f51..8ef86f1f3830 100644
--- a/configs/amd_versal2_virt_defconfig
+++ b/configs/amd_versal2_virt_defconfig
@@ -119,6 +119,7 @@ CONFIG_ARM_DCC=y
 CONFIG_PL01X_SERIAL=y
 CONFIG_XILINX_UARTLITE=y
 CONFIG_SOC_DEVICE=y
+CONFIG_SOC_AMD_VERSAL2=y
 CONFIG_SPI=y
 CONFIG_DM_SPI=y
 CONFIG_ZYNQ_SPI=y
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 03433bc0e6d2..cee506fe4747 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -9,6 +9,14 @@ config SOC_DEVICE
 	  need different parameters or quirks enabled depending on the
 	  specific device variant in use.
 
+config SOC_AMD_VERSAL2
+	bool "Enable SoC Device ID driver for AMD Versal Gen 2"
+	depends on SOC_DEVICE && ARCH_VERSAL2
+	help
+	  Enable this option to select SoC device id driver for AMD Versal Gen 2.
+	  This allows other drivers to verify the SoC familiy & revision using
+	  matching SoC attributes.
+
 config SOC_DEVICE_TI_K3
 	depends on SOC_DEVICE && ARCH_K3
 	bool "Enable SoC Device ID driver for TI K3 SoCs"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 610bf816d40a..5ec89a053165 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 #
 # Makefile for the U-Boot SOC specific device drivers.
 
+obj-$(CONFIG_SOC_AMD_VERSAL2) += soc_amd_versal2.o
 obj-$(CONFIG_SOC_SAMSUNG) += samsung/
 obj-$(CONFIG_SOC_TI) += ti/
 obj-$(CONFIG_SOC_DEVICE) += soc-uclass.o
diff --git a/drivers/soc/soc_amd_versal2.c b/drivers/soc/soc_amd_versal2.c
new file mode 100644
index 000000000000..66bcb22b4fa9
--- /dev/null
+++ b/drivers/soc/soc_amd_versal2.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Versal Gen 2 SOC driver
+ *
+ * Copyright (C) 2022 - 2024, Advanced Micro Devices, Inc.
+ */
+
+#include <dm.h>
+#include <soc.h>
+#include <zynqmp_firmware.h>
+#include <asm/io.h>
+#include <asm/arch/hardware.h>
+
+#include <linux/bitfield.h>
+
+/*
+ * v1 -> 0x10 - ES1
+ * v2 -> 0x20 - Production
+ */
+static const char versal2_family[] = "Versal Gen 2";
+
+struct soc_amd_versal2_priv {
+	const char *family;
+	char revision;
+};
+
+static int soc_amd_versal2_get_family(struct udevice *dev, char *buf, int size)
+{
+	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
+
+	return snprintf(buf, size, "%s", priv->family);
+}
+
+static int soc_amd_versal2_get_revision(struct udevice *dev, char *buf, int size)
+{
+	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
+
+	return snprintf(buf, size, "v%d", priv->revision);
+}
+
+static const struct soc_ops soc_amd_versal2_ops = {
+	.get_family = soc_amd_versal2_get_family,
+	.get_revision = soc_amd_versal2_get_revision,
+};
+
+static int soc_amd_versal2_probe(struct udevice *dev)
+{
+	struct soc_amd_versal2_priv *priv = dev_get_priv(dev);
+	u32 ret_payload[PAYLOAD_ARG_CNT];
+	int ret;
+
+	priv->family = versal2_family;
+
+	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE)) {
+		ret = xilinx_pm_request(PM_GET_CHIPID, 0, 0, 0, 0,
+					ret_payload);
+		if (ret)
+			return ret;
+	} else {
+		ret_payload[2] = readl(PMC_TAP_VERSION);
+		if (!ret_payload[2])
+			return -EINVAL;
+	}
+
+	priv->revision = FIELD_GET(PS_VERSION_MASK, ret_payload[2]);
+
+	return 0;
+}
+
+U_BOOT_DRIVER(soc_amd_versal2) = {
+	.name		= "soc_amd_versal2",
+	.id		= UCLASS_SOC,
+	.ops		= &soc_amd_versal2_ops,
+	.probe		= soc_amd_versal2_probe,
+	.priv_auto	= sizeof(struct soc_amd_versal2_priv),
+	.flags		= DM_FLAG_PRE_RELOC,
+};
-- 
2.40.1

