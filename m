Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A00D7496D
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 05:23:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A39689206;
	Wed, 30 Oct 2024 06:22:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EzzcolMz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9E36689209; Wed, 30 Oct 2024 06:22:56 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CC29089204
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 06:22:52 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hto3QFtWRJ0alryXd0CA+kspWbj/HWpv7gNh7gv4o09zbNiqxxfM2UOHlKovJgEpJw8pr/McYwr8rOneWwxq5QYvJy7RIzKe4fmn1pYs+6XbgW3Txfjlq80aJw0cPCpltXDeWObK0K2BREKDX/A/XNVgdaCwLryDVa+AxzpPJe+t7h73xJf6K10DvWPH+G5SpvbJl5tPIMxHBcY0vp/nOmBS/aQNshEkvXNK8ZR5yPiH96EdVpEk0+2y6W6SO/V9R+BwgTEnrwYiNHwjo4+Z/dAIMFBItjRl8Q+xAhvlYLVnTejlNHZHBWwzGVAk3PS2717rGs1ZQVSeI3/hCsrnyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sj2JuvGGx8TsmQe0cpfwDq/9lDvQNkK7w+cyflzRshQ=;
 b=TwvrGCwBMzpXJzm5p+DlrVREvL7B6H8rASn1951ap9uT7g7UdV1XqISTnF4U0DSYsAXYkxwrGxw5KGn2QJmI5Z12tGnLXLqeGDzUwUdC/i97b5nQhvt2EVQtdVNbcV0O15g2fKAV53Psa6Rxf3/RHEHZnQ/vm6jFefEs/iz2OEOZvVZvjwsnJkLRZfdyIFGX/yamURA42G+9q0ahK3OGmBlaiKSgJMjrQq0B7sT8tnO+amPQ69p1zpXZebKpaDb2OrmkLkKjqOzP7NHW7yuZ0TWkF476fSiQpqUinv8TyVkN7c4ADBPqtq3vsQAPFsEGzQm7uwQLapVlBAjn60LoUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sj2JuvGGx8TsmQe0cpfwDq/9lDvQNkK7w+cyflzRshQ=;
 b=EzzcolMzEwYAZsPYOtgcmVZZ7shnjKcPvex4+CxuEXF1ejwdI8KUn8EGjt4Dmr2Kx7Q2gOoPXlAblRjdZWjnYq3NeLT8PH23v5ZfFf7U4XowAnB5HiWZKQW+m+PTSw8/fmuqUBpNQyhdRIK5X4SFLM5iqrFmwXnJlHYg3URe9XE=
Received: from BLAPR03CA0014.namprd03.prod.outlook.com (2603:10b6:208:32b::19)
 by DM4PR12MB6136.namprd12.prod.outlook.com (2603:10b6:8:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 05:22:44 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:32b:cafe::40) by BLAPR03CA0014.outlook.office365.com
 (2603:10b6:208:32b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.26 via Frontend
 Transport; Wed, 30 Oct 2024 05:22:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 05:22:43 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 00:22:37 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 00:22:20 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v8 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Wed, 30 Oct 2024 10:51:57 +0530
Message-ID: <20241030052200.24243-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
References: <20241030052200.24243-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM4PR12MB6136:EE_
X-MS-Office365-Filtering-Correlation-Id: 646b0468-d3c1-456a-d71b-08dcf8a2e1f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZllidHhJL1NJa0V5SFF1QzNCOUNrUTdaQjk2bUN4UEVoNTZjeWxvQVUxYXNN?=
 =?utf-8?B?ckt6bldkK1RmMUhMZlRiZGFHMVQzbzZBZGc2RGE2NmZnaU00c2EwN2ZOQW5m?=
 =?utf-8?B?d0pXaDgyMjdHZEtrcktURFdWR1dEUmFKMDhUYTlZN1ZHN3Y1N1JlSWxwQU4z?=
 =?utf-8?B?ZXNNNk4vcUxTdFVZOFI0Q0R6VVd0RURROWxMd25lNWtvbUY2V0hSVk5LWnlT?=
 =?utf-8?B?WFBxZVV6eFo1NTZES2N3WENobXFQcldaMGd4d2JIdGl6ZFl1TjZBY1pVampJ?=
 =?utf-8?B?bTNSWG85dy9wdlJLNWZwaE84cW9zbVl0YlFGakJMd0l1N3RTczU1d3Z5MW9p?=
 =?utf-8?B?d0VFd1ZFU2I2RVB2NDFJcks3eWJZYTEwTFNVUG4yTVdGOVBnc2g1a2ZPOEtr?=
 =?utf-8?B?NGExN1ZDOEVua2lrTTU1ZmdqNmRuVzlvdkw2MHlTQjBGSm8vNUQ3VFlEc2dy?=
 =?utf-8?B?QlpzTWVMdFd4UEZ5bWpIZVFZMHNIMVNuaFVqRVdzUUV4ZFlxV21rbFMxdXFI?=
 =?utf-8?B?TlZBQVRxZkFTZThPVmJpbVNMQ1JaU0lsRzh5ZkU1SjZEY0R2d0pjUU5keEdj?=
 =?utf-8?B?VU1jNDB3M3ZBZ0U2YkdXcHhvaXVWL0R0N1pRSHl6YStCSkw1Q2RTRi9LRDVl?=
 =?utf-8?B?bW1DUHp2NGJFZHFkQ1dGVFdaUkhwUGpndGR0eXZ1Z0crVm15OGNmWmUvUCtj?=
 =?utf-8?B?NThKMXh3U2RjdHBXZ2hKQWViMldjM1BrVDA2VEVDTkZnem00SmVRdlZJVDIz?=
 =?utf-8?B?Ulp4dWJBUmZhek9OV1dCNUhnNUNIS3NzdTN5dXQrd1EzWWp0VXpBMWtlZVRa?=
 =?utf-8?B?SGFpWW9OMXQzb3FiSnRRbHBKSThocFhyc21hckpkOTBrdDJyOUE3Z203TFUx?=
 =?utf-8?B?UDdqTTFic2R2amdHRkpIVGw3OTJ0TG5iMEptc0t0T3BPNHhaNDQrT2dSODRy?=
 =?utf-8?B?T3JLaGRaOC9NOGU3QjRWdzluTE9BdjJQRVprYzM2TS92SEZ2eEp4Zndhc2RT?=
 =?utf-8?B?bG5icmJOanZuUC94TTNuWFdyWDUyZ3VBZHlvbU9aVEtGZWhjNERZZ1kzck9h?=
 =?utf-8?B?OERzeHNmK3hXa0dyTi9QYk13eGFYcHVqeEFkWm4wQ3VjblQ1a0RyakNlMkow?=
 =?utf-8?B?UjJjWnY4OXloSHQvNnFhUVA5KzIzUGFia1EvdzNpOXp1T1J5S2I5MmFYQzFy?=
 =?utf-8?B?OGs2YWl5UzV6RXFYYnlHV1h3R08yUkZ4YUJSRWtLUUJpcXBSbXZEMXpnNWdB?=
 =?utf-8?B?c1llWHhJSEdGYkRTR3RkZEJYekJZM01YdXhuNm4xSXg0NnpCRzQ4eGlydFIx?=
 =?utf-8?B?WmtpU1RxWDdqV01pS2FkaGdldGJjVGdRcFZCOGo0RFUwN0tOV1R3N1dGYlFi?=
 =?utf-8?B?Mm0xNWczeEM1dnlEbHBMMmhFY2hKRHA4Yjg2NnE3cHJPM2NXL05CaVdlZFRu?=
 =?utf-8?B?Mk52b0lLeU9tVjZkQ3ppaG9WYjhiOTdHeWFObVpUOWZFY2lZT3pNcEU4RjlQ?=
 =?utf-8?B?WjRSZE9BQVFsNm9XcnZUaFlFOGxpUHlONGFYT2tTZldFbHJLZlFYVGNQMjlO?=
 =?utf-8?B?VEZ2OTd4OXdSYmdDcmgvVHdqVUcvdFlUeTdRdGJjZmNQR2d6YW45eTlWdXEw?=
 =?utf-8?B?dVRSdHlWSS9GTFYvbEs1VHpZaFY0YmpaT0hoK3dsOWdwSEFWMzBnOEh4RHFh?=
 =?utf-8?B?UlBONnRFVFNmMElwNFUvcVlZdzhNbDFOeWpmWFZGb1YycTdYYnVBZWhKdk5C?=
 =?utf-8?B?TElBRjhQZzBwYnlVR2pvaFdnODdDbEo2cWNrY3dCM3BXdGdVMjRPa2x2NHRm?=
 =?utf-8?B?NUphTUhZd1VzNWxsWTB0TFI2RUVaUDRpUXJxWTBzWUYxNEZsYTQxYkl5M0Mx?=
 =?utf-8?B?VVhwZ3d4dVZzWmxtTWY1cUVqVSs0ZFgwcTkyQjlaOFovdVE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 05:22:43.8518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 646b0468-d3c1-456a-d71b-08dcf8a2e1f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6136
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

Add i2c initialization hook and set usb5744 platform
data with function having required i2c initialization sequence.

Apart from the USB command attach, prevent the hub from suspend.
when the “USB Attach with SMBUS (0xAA56)” command is issued to the hub,
the hub is getting enumerated and then it puts in a suspend mode.
This causes the hub to NAK any SMBUS access made by the SMBUS Master
during this period and not able to see the hub's slave address while
running the "i2c probe" command.

Prevent the MCU from the putting the HUB in suspend mode through register
write. The BYPASS_UDC_SUSPEND bit (Bit 3) of the RuntimeFlags2 register at
address 0x411D controls this aspect of the hub. The BYPASS_UDC_SUSPEND
bit in register 0x411Dh must be set to ensure that the MCU is always
enabled and ready to respond to SMBus runtime commands. This register
needs to be written before the USB attach command is issued.
The byte sequence is as follows:
Slave addr: 0x2d           00 00 05 00 01 41 1D 08
Slave addr: 0x2d           99 37 00
Slave addr: 0x2d           AA 56 00

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 106 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index fc7953e8bd..1a3569a135 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -10,9 +10,15 @@
 #include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <i2c.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
 
+#define USB5744_COMMAND_ATTACH		0x0056
+#define USB5744_COMMAND_ATTACH_LSB	0xAA
+#define USB5744_CONFIG_REG_ACCESS	0x0037
+#define USB5744_CONFIG_REG_ACCESS_LSB	0x99
+
 struct onboard_hub {
 	struct udevice *vdd;
 	struct gpio_desc *reset_gpio;
@@ -21,8 +27,89 @@ struct onboard_hub {
 struct onboard_hub_data {
 	unsigned long reset_us;
 	unsigned long power_on_delay_us;
+	int (*init)(struct udevice *dev);
 };
 
+static int usb5744_i2c_init(struct udevice *dev)
+{
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
+	u8 data_buf[8] = {0x0, 0x5, 0x0, 0x1, 0x41, 0x1D, 0x08};
+	u8 config_reg_access_buf = USB5744_CONFIG_REG_ACCESS;
+	struct udevice *i2c_bus = NULL, *i2c_dev;
+	struct ofnode_phandle_args phandle;
+	u8 buf = USB5744_COMMAND_ATTACH;
+	struct dm_i2c_chip *i2c_chip;
+	int ret, slave_addr;
+
+	ret = dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle);
+	if (ret) {
+		dev_err(dev, "i2c-bus not specified\n");
+		return ret;
+	}
+
+	ret = device_get_global_by_ofnode(ofnode_get_parent(phandle.node), &i2c_bus);
+	if (ret) {
+		dev_err(dev, "Failed to get i2c node, err: %d\n", ret);
+		return ret;
+	}
+
+	ret = ofnode_read_u32(phandle.node, "reg", &slave_addr);
+	if (ret)
+		return ret;
+
+	ret = i2c_get_chip(i2c_bus, slave_addr, 1, &i2c_dev);
+	if (ret) {
+		dev_err(dev, "%s: can't find i2c chip device for addr 0x%x\n", __func__,
+			slave_addr);
+		return ret;
+	}
+
+	i2c_chip = dev_get_parent_plat(i2c_dev);
+	if (!i2c_chip) {
+		dev_err(dev, "parent platform data not found\n");
+		return -EINVAL;
+	}
+
+	i2c_chip->flags &= ~DM_I2C_CHIP_WR_ADDRESS;
+	/* SMBus write command */
+	ret = dm_i2c_write(i2c_dev, 0, (uint8_t *)&data_buf, 8);
+	if (ret) {
+		dev_err(dev, "data_buf i2c_write failed, err:%d\n", ret);
+		return ret;
+	}
+
+	/* Configuration register access command */
+	ret = dm_i2c_write(i2c_dev, USB5744_CONFIG_REG_ACCESS_LSB,
+			   &config_reg_access_buf, 2);
+	if (ret) {
+		dev_err(dev, "config_reg_access i2c_write failed, err: %d\n", ret);
+		return ret;
+	}
+
+	/* USB Attach with SMBus */
+	ret = dm_i2c_write(i2c_dev, USB5744_COMMAND_ATTACH_LSB, &buf, 2);
+	if (ret) {
+		dev_err(dev, "usb_attach i2c_write failed, err: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int usb_onboard_hub_reset(struct udevice *dev)
 {
 	struct onboard_hub_data *data =
@@ -54,6 +141,8 @@ int usb_onboard_hub_reset(struct udevice *dev)
 
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
@@ -71,7 +160,21 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 		}
 	}
 
-	return usb_onboard_hub_reset(dev);
+	ret = usb_onboard_hub_reset(dev);
+	if (ret)
+		return ret;
+
+	if (data->init) {
+		ret = data->init(dev);
+		if (ret) {
+			dev_err(dev, "onboard i2c init failed: %d\n", ret);
+			goto err;
+		}
+	}
+	return 0;
+err:
+	dm_gpio_set_value(hub->reset_gpio, 0);
+	return ret;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -90,6 +193,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 }
 
 static const struct onboard_hub_data usb5744_data = {
+	.init = usb5744_i2c_init,
 	.power_on_delay_us = 10000,
 	.reset_us = 10000,
 };
-- 
2.17.1

