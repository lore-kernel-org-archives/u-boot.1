Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE6E8C4707C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 04:47:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 43C3587937;
	Fri, 12 Jan 2024 05:47:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J4FrwO+p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B806687937; Fri, 12 Jan 2024 05:47:54 +0100 (CET)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8c::624])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E92B5878BA
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:47:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k34jvUg6B/sFvLEuvD+BbvCrgB237lIEYnXOz/Jq/vxMK4Ic8DNZVYnovpH2fdgk/FTEGF9wpEojLduEYh2uOtqMjz5V+RkCXijL4yafkgNKqd8CTGhfu2YBmW3xe7GkG1FuJDeFLnPDkFl4ksMnPxn8jIJeKY3SBG7PR8GIFwg2mveR374MFlXOsGjPAkhweOyqQeXCRvd7rNSLJiDDTPbk0Wtj9fTLip1jxexgHCskN0aOSRPbP4c9OvJvxxrx1mXhZ9Ey+XVmkj/JhjP7J9Roj4302LmjenE2h/3uPfGYL7zDMQUgHPclnemLohqZ9R55Fkz3TWRmnyhUGY/D5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KOfWegwUpHG6KAiJLuW1sYFxJELu10GHHvyASlCf51U=;
 b=UUGCAXyxPvhxgi/3tamAOJcATeqHdKuPW+0UEdLfV0JbD+zsrsfplF+6J5rDmebsDRPuI+itNb+mN1mM8ou/kPxZN3kTAUb+V/Ez10+dK/SowgPovr0814J1XQR5uOZ6kiU7bpQwY+0odubvJo5Rq71ciSxbiZSiFpssSjSbgALSyvp1FB6Hxu09FWCHaDMu92oT5+gYR9pP+mNC8TQxFHbzMxlOQKGLsuh4CL00Y6IOXWaaA+hL9aLHcNIdJjFlkn2yz87WBH7IIMJ4GIM2uFh9VfUrVOsy5wDBuHfKGclV0ML1QOLBOxMiwjx3XdpEmFNMmk1UpPBI3yedolqxyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KOfWegwUpHG6KAiJLuW1sYFxJELu10GHHvyASlCf51U=;
 b=J4FrwO+p3wxU6uXcOCdWNf6pIa0qZEyOq0Y/jdKLb7vxgIyCUj6hkeAZNiLhrqHCb1RnsHDvNZEti0Y78WRWX/bv3KqqQL0UfE58mpD5dyrJFmOM/hhrYZa7JOkoAGwIRco9G1zihhKmI2A6PFFHgoHRrfJ28p3Nru1MHrXRV9E=
Received: from MN2PR05CA0041.namprd05.prod.outlook.com (2603:10b6:208:236::10)
 by DM4PR12MB7528.namprd12.prod.outlook.com (2603:10b6:8:110::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Fri, 12 Jan
 2024 04:47:48 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::68) by MN2PR05CA0041.outlook.office365.com
 (2603:10b6:208:236::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.12 via Frontend
 Transport; Fri, 12 Jan 2024 04:47:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Fri, 12 Jan 2024 04:47:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 22:47:40 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 22:47:36 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 22:47:35 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>
Subject: [PATCH] misc: usb2244: Add support to reset usb2244 usb2.0 SD
 controller
Date: Fri, 12 Jan 2024 10:17:28 +0530
Message-ID: <20240112044728.3248343-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|DM4PR12MB7528:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b589b46-488f-4239-356c-08dc1329a045
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N0RalnzIKuEMxJC/jPXazBSqFaURVt8BUov0GkZwE3BI7L5ax7lwsUqrSDM5pyhzNpzNiEUGS+feHnbsXyLFLDNLj8zbchI2Yi6chB7XW0Bb+zwBPHws17SOKnEUkHxiudEI6FZd3iLQqiAvoFU32lGkVAw0K9ne1nuKlMKj8ldshgILrRPCX1+dtRcwZV+8cadphpjvwfgiooslCuJB1rSzlBNdp6vdyUDmrfxHn1Msnm+M8iVSWnQEjKU1c6KruO//S78ppkSIc/Hs65R31kj/CpJiz4m8OmVikEQXt8PHA3l9364YXnHVoI/HftmEiDm0qwcOVDb7eGk0O2VzawGHqEiubkAQVWQbORAMsO/jp95F5ploJ7xSvSh9R6gM9Hi+2aLcCZVtJBpPcy3QLdGiF4v8BPXms3dOz+ehvx27IIZu5ulFYZMAgFXAX9a50xC18+Nx3t2wYg0GLkaYLrBCqUpd560JofBwXeVSGJoeMkXtyzyykPNVrcmKpGtn1S0PnudaT9Pq9/49P/DDaO27sGyF+dxQTqd+n+4FVLsXUsdlNOiU2dps9wu+NCUe/L/a7RoGAmfrH4i4iHZiljbzS5sjNwyDw9ftEv7HbGpQzIMeofkFSHrhTH8x8Fxni8PTjuTB/NhBJguEd0+vSGfYBLr+tHRVMp4sOJoQs8tg3BVFxZaA+HjYn6f0ZnD+rxoCE6C7BV1pzWBJd2GtNSQ+j76XXU26uyRgJHZYovJFE1AI4r495A5t+ohfPzdvhkxF3LYEVR8gm+Aj9WyTKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(46966006)(40470700004)(36840700001)(83380400001)(54906003)(86362001)(26005)(1076003)(2906002)(2616005)(5660300002)(426003)(8936002)(336012)(8676002)(316002)(6916009)(70206006)(70586007)(4326008)(478600001)(6666004)(82740400003)(41300700001)(81166007)(356005)(47076005)(36860700001)(40460700003)(36756003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 04:47:48.2932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b589b46-488f-4239-356c-08dc1329a045
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7528
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

Usb2244 driver needs to be reset to bring usb2244 out of reset. This
driver will reset the controller using gpio.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 MAINTAINERS            |  1 +
 drivers/misc/Kconfig   |  8 +++++
 drivers/misc/Makefile  |  1 +
 drivers/misc/usb2244.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 79 insertions(+)
 create mode 100644 drivers/misc/usb2244.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 1e950c3b45..be50fddc38 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -815,6 +815,7 @@ F:	drivers/i2c/i2c-cdns.c
 F:	drivers/i2c/muxes/pca954x.c
 F:	drivers/i2c/zynq_i2c.c
 F:	drivers/mailbox/zynqmp-ipi.c
+F:	drivers/misc/usb2244.c
 F:	drivers/misc/usb5744.c
 F:	drivers/mmc/zynq_sdhci.c
 F:	drivers/mtd/nand/raw/zynq_nand.c
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index b7022c31ee..3b6ca7d4bc 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -696,4 +696,12 @@ config USB5744
 	  This enables support for Microchip USB5744 Hub. This driver reset
 	  the hub using gpio pin and configure hub via i2c.
 
+config USB2244
+	bool "Microchip USB2244 Ultra Fast USB 2.0 SD driver"
+	depends on DM_USB && DM_GPIO
+	help
+	  This option enables support for Microchip USB2244 Ultra Fast USB 2.0
+	  SD controller. This driver will reset the usb2244 controller using a
+	  gpio pin.
+
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 19f5afa885..82b7b92c0a 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -91,3 +91,4 @@ obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
 obj-$(CONFIG_USB5744)  += usb5744.o
+obj-$(CONFIG_USB2244)  += usb2244.o
diff --git a/drivers/misc/usb2244.c b/drivers/misc/usb2244.c
new file mode 100644
index 0000000000..19dcd1eef6
--- /dev/null
+++ b/drivers/misc/usb2244.c
@@ -0,0 +1,69 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip USB2244 Ultra Fast USB 2.0 SD controller.
+ *
+ * Copyright (C) 2024,Advanced Micro Devices, Inc.
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <usb.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+
+struct usb2244_priv {
+	struct gpio_desc reset_gpio;
+};
+
+static int usb2244_probe(struct udevice *dev)
+{
+	struct usb2244_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 1);
+	if (ret)
+		return ret;
+
+	mdelay(5);
+
+	ret = dm_gpio_set_value(&priv->reset_gpio, 0);
+	if (ret)
+		return ret;
+
+	mdelay(5);
+
+	return 0;
+}
+
+static int usb2244_plat(struct udevice *dev)
+{
+	struct usb2244_priv *priv = dev_get_priv(dev);
+	int ret;
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0, &priv->reset_gpio,
+				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	if (ret) {
+		printf("%s, gpio request failed err: %d\n", __func__, ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(usb2244) = {
+	.name = "usb2244",
+	.id = UCLASS_MISC,
+	.probe = usb2244_probe,
+	.of_to_plat = usb2244_plat,
+	.priv_auto = sizeof(struct usb2244_priv),
+};
+
+static const struct usb_device_id usb2244_id_table[] = {
+	{
+		.idVendor = 0x0424,
+		.idProduct = 0x2240
+	},
+	{ }
+};
+
+U_BOOT_USB_DEVICE(usb2244, usb2244_id_table);
-- 
2.25.1

