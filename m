Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF50C4706C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jan 2024 04:29:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AA82878C6;
	Fri, 12 Jan 2024 05:29:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lHl98xKe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5AFA1878BA; Fri, 12 Jan 2024 05:29:06 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4625878C8
 for <u-boot@lists.denx.de>; Fri, 12 Jan 2024 05:29:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA3/HYVJ/4c5+LljnOqLN1jt1RHzHT6Tstp3/q0rnKKv7QnRQ/rJLwj/ZzPKoYBkekYQQZxhHWG8kGYfL9tqfqLyecgzuEpV260X+KpeH50oCd8n73W2kNAfDOXtseVs0Cmon0ugeDOH5z32lxcPAj35hdmq13WW5M3CbM6ErJvr3R2yvU7Pus2cgOOhrTYLBqYmRaB2s32ruPp1LgVTr5SxXN1wFz9LJYG3MISiaEGavSzkV3KQlind0JeGErqmbKNpW1GgeItAxh5KDo9WInUMH+SIfGLt1Rx+x2M1jrJ+wESwoLGi2Ga9OoWbxOjmOOnMcdMQl/pm9TxJQeFPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBBvLrYemprfDEX5JQYQTeSXJI6iaSAmeu5gcGHFV/0=;
 b=EPyaGELODasHIeuOYu90kf2SmAQCAKQ8xX+evniuNF4iwYZniamB9+bQGkFGkTuEnDWvXm1jjTgQ+iqqgs6xifZ5Oryc5Ir4VTqC//xqMRS8+Z9qHnzIoIMrop3MYnzqcRO2naVK1nvl/MYPCw5zcsgwLf5w+RLk3Iz/75/hnFDOB5K/KXhemCtgw95mWevf8SPmdGdmcwZz/0nTdJhzT9uxEN1vnMpK46CCF1LikQbQXgaEJ8/J/enCrqImwhfYFSgm6k/jmZLP7PAAR42cuM3/Wq2CKaLP5kSyFHi47Cz4tbVNKEKvl45SNK1Sw884rN7suI12PHs2VeTdZKSEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBBvLrYemprfDEX5JQYQTeSXJI6iaSAmeu5gcGHFV/0=;
 b=lHl98xKeSyQCTRtt0q2acSCYpF7wPUfGvy+StQQoiOn3t8PRAzyTeYyS1sGcjAPLlmlVBM/eRBJi59DVeZ8aB+oA9ES49cdxTwoaWMQCZ7RjloJ1fjXsSyPie2x7nEA+Szd7w64Osbl6DpqpdC44w4qenZBnavinQh5vsy8woTo=
Received: from MW3PR05CA0004.namprd05.prod.outlook.com (2603:10b6:303:2b::9)
 by SN7PR12MB7419.namprd12.prod.outlook.com (2603:10b6:806:2a6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.25; Fri, 12 Jan
 2024 04:29:00 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::27) by MW3PR05CA0004.outlook.office365.com
 (2603:10b6:303:2b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.12 via Frontend
 Transport; Fri, 12 Jan 2024 04:28:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.4 via Frontend Transport; Fri, 12 Jan 2024 04:28:57 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 11 Jan
 2024 22:28:31 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34 via Frontend
 Transport; Thu, 11 Jan 2024 22:28:29 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <git@xilinx.com>, T Karthik Reddy
 <t.karthik.reddy@xilinx.com>
Subject: [PATCH] misc: usb5744: Add support for usb5744 usb hub driver
Date: Fri, 12 Jan 2024 09:58:17 +0530
Message-ID: <20240112042817.3235850-1-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|SN7PR12MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a0d2d3f-d890-476f-ab8b-08dc1326fe8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2gKTopycCmA5DJUjRAk5CIBw45w2kR08W1rRgIAjUNvQ3fs40v/GXeOxaHaGRtopMXn+3WjJ6g5pRnLzXOKvTqBYNUBT2QKFi3TT4v+vu5d2H0dVyieaIcw5TkDS7xBxDhOGZHRTdZbwPFHOhY4QcQqLn6J2F4/NNo4WprH/eN2rl14NwhdzZfrZOhQaQ3OP1U1R1VeFesFvtRa9XRASxZJBHfUzSc24amm1g522u6S4W2FYXpdjSbXTnAFbmT3TByAwilpj9vp0wFYU90/HINIboDh44Fhhrfu8FH6+0iDooLAHoz86KIofGOPGtTAsLSCL1Glz4YqYnUz2xP4NGKqwSp8MzyiAB1LzMrD5IOWKeEhXSN+oiPad1mtVJmuPiQoDYFbhPu+rkjILoPQELjptj3X1oNEhyAZq7Rf9CLQeJD4rDDUuIVeMjsMlp1nys1ACxDLZHzivION7HaR4iPWFNjdMu+n1oUo7CME+yw0y+PENNLSrkFRKJEf7dbN/u6biAbzcT3Br2ySVu/Uz9Ph883fZjRIPuuQBmfuRxr7QYYw8X4E0FTtGewa2U3kGTA5w3IfZ9j+omiAr5vbjTGJg2qpFfJ/WN78dqfoA29ESMNNfLpkosni+hQE/RtO5kFgU4FmARAaaTJRzwPt9U5pg5Ut2VvCYpNMuKqrQCG2JDV6Tsbtfq5eMssyy76x4DqR0Y1JDvn7N6vVscj60cwVpI9gcKNFR23y0olTTswUbORh4WKfpVxsykYFoWM2fTaOvWJaeAWPFOIaaywrY2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(186009)(1800799012)(82310400011)(64100799003)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(2906002)(6666004)(5660300002)(36860700001)(478600001)(81166007)(356005)(4326008)(8936002)(70206006)(316002)(70586007)(36756003)(6916009)(54906003)(41300700001)(82740400003)(2616005)(1076003)(86362001)(426003)(26005)(336012)(83380400001)(47076005)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2024 04:28:57.8522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a0d2d3f-d890-476f-ab8b-08dc1326fe8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7419
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

Microchip usb5744 driver resets the usbhub by toggling gpio to bring the
hub from reset. Also configures the usbhub by sending command using i2c
after hub reset.

Signed-off-by: T Karthik Reddy <t.karthik.reddy@xilinx.com>
Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 MAINTAINERS            |   1 +
 drivers/misc/Kconfig   |   7 +++
 drivers/misc/Makefile  |   1 +
 drivers/misc/usb5744.c | 138 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 147 insertions(+)
 create mode 100644 drivers/misc/usb5744.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4fec063a24..1e950c3b45 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -815,6 +815,7 @@ F:	drivers/i2c/i2c-cdns.c
 F:	drivers/i2c/muxes/pca954x.c
 F:	drivers/i2c/zynq_i2c.c
 F:	drivers/mailbox/zynqmp-ipi.c
+F:	drivers/misc/usb5744.c
 F:	drivers/mmc/zynq_sdhci.c
 F:	drivers/mtd/nand/raw/zynq_nand.c
 F:	drivers/net/phy/xilinx_phy.c
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index e8e4400516..b7022c31ee 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -689,4 +689,11 @@ config SL28CPLD
 	  the base driver which provides common access methods for the
 	  sub-drivers.
 
+config USB5744
+	bool "Microchip USB5744 usb hub"
+	depends on DM_USB && DM_I2C && DM_GPIO
+	help
+	  This enables support for Microchip USB5744 Hub. This driver reset
+	  the hub using gpio pin and configure hub via i2c.
+
 endmenu
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index cda701d38e..19f5afa885 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -90,3 +90,4 @@ obj-$(CONFIG_K3_AVS0) += k3_avs.o
 obj-$(CONFIG_ESM_K3) += k3_esm.o
 obj-$(CONFIG_ESM_PMIC) += esm_pmic.o
 obj-$(CONFIG_SL28CPLD) += sl28cpld.o
+obj-$(CONFIG_USB5744)  += usb5744.o
diff --git a/drivers/misc/usb5744.c b/drivers/misc/usb5744.c
new file mode 100644
index 0000000000..7dbc4fba90
--- /dev/null
+++ b/drivers/misc/usb5744.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for the Microchip USB5744 4-port hub.
+ *
+ * Copyright (C) 2024,Advanced Micro Devices, Inc.
+ */
+
+#include <common.h>
+#include <dm.h>
+#include <dm/device_compat.h>
+#include <i2c.h>
+#include <usb.h>
+#include <asm/gpio.h>
+#include <linux/delay.h>
+#include <asm/global_data.h>
+
+#define I2C_ADDR	0x2D
+#define USB_COMMAND_ATTACH	0x0056
+#define USB_CONFIG_REG_ACCESS	0x0037
+
+struct usb5744_priv {
+	struct gpio_desc reset_gpio;
+	struct udevice *i2c_dev;
+};
+
+static int usb5744_probe(struct udevice *dev)
+{
+	struct usb5744_priv *priv = dev_get_priv(dev);
+	struct dm_i2c_chip *i2c_chip;
+	int ret;
+	u32 buf = USB_COMMAND_ATTACH;
+	u32 config_reg_access_buf = USB_CONFIG_REG_ACCESS;
+	/*
+	 *  Prevent the MCU from the putting the HUB in suspend mode through register write.
+	 *  The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2 register at address
+	 *  0x411D controls this aspect of the hub.
+	 *  Format to write to hub registers via SMBus- 2D 00 00 05 00 01 41 1D 08
+	 *  Byte 0: Address of slave 2D
+	 *  Byte 1: Memory address 00
+	 *  Byte 2: Memory address 00
+	 *  Byte 3: Number of bytes to write to memory
+	 *  Byte 4: Write configuration register (00)
+	 *  Byte 5: Write the number of data bytes (01- 1 data byte)
+	 *  Byte 6: LSB of register address 0x41
+	 *  Byte 7: MSB of register address 0x1D
+	 *  Byte 8: value to be written to the register
+	 */
+	char data_buf[8] = {0x0, 0x5, 0x0, 0x1, 0x41, 0x1D, 0x08};
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
+	mdelay(10);
+
+	i2c_chip = dev_get_parent_plat(priv->i2c_dev);
+	if (i2c_chip) {
+		i2c_chip->flags &= ~DM_I2C_CHIP_WR_ADDRESS;
+		/* SMBus write command */
+		ret = dm_i2c_write(priv->i2c_dev, 0x0, (uint8_t *)&data_buf, 8);
+		if (ret) {
+			dev_err(dev, "data_buf i2c_write failed, err:%d\n", ret);
+			return ret;
+		}
+
+		/* Configuration register access command */
+		ret = dm_i2c_write(priv->i2c_dev, 0x99, (uint8_t *)&config_reg_access_buf, 2);
+		if (ret) {
+			dev_err(dev, "config_reg_access i2c_write failed, err: %d\n", ret);
+			return ret;
+		}
+
+		/* USB Attach with SMBus */
+		ret = dm_i2c_write(priv->i2c_dev, 0xAA, (uint8_t *)&buf, 2);
+		if (ret) {
+			dev_err(dev, "usb_attach i2c_write failed, err: %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int usb5744_plat(struct udevice *dev)
+{
+	struct usb5744_priv *priv = dev_get_priv(dev);
+	struct udevice *i2c_bus = NULL;
+	ofnode i2c_node;
+	u32 phandle;
+	int ret;
+
+	ret = gpio_request_by_name(dev, "reset-gpios", 0,
+				   &priv->reset_gpio,
+				   GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	if (ret) {
+		dev_err(dev, "Gpio request failed, err: %d\n", ret);
+		return ret;
+	}
+
+	if (!ofnode_read_u32(dev_ofnode(dev), "i2c-bus", &phandle)) {
+		i2c_node = ofnode_get_by_phandle(phandle);
+		ret = device_get_global_by_ofnode(i2c_node, &i2c_bus);
+		if (ret) {
+			dev_err(dev, "Failed to get i2c node, err: %d\n", ret);
+			return ret;
+		}
+
+		ret = i2c_get_chip(i2c_bus, I2C_ADDR, 1, &priv->i2c_dev);
+		if (ret)
+			return -ENODEV;
+	}
+
+	return 0;
+}
+
+U_BOOT_DRIVER(usb5744) = {
+	.name = "usb5744",
+	.id = UCLASS_MISC,
+	.probe = usb5744_probe,
+	.of_to_plat = usb5744_plat,
+	.priv_auto = sizeof(struct usb5744_priv),
+};
+
+static const struct usb_device_id usb5744_id_table[] = {
+	{
+		.idVendor = 0x0424,
+		.idProduct = 0x5744
+	},
+	{ }
+};
+
+U_BOOT_USB_DEVICE(usb5744, usb5744_id_table);
-- 
2.25.1

