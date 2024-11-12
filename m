Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE01AD41D53
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 05:13:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC126893B5;
	Tue, 12 Nov 2024 06:13:12 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pS9MLSyU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE7DE893AB; Tue, 12 Nov 2024 06:13:10 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2060e.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::60e])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E45D889D2
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 06:13:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNXkqs4zxtfJ8xC/BqbI6ym1EWQvLqQvTrkdR3EH/bym6XfneLmqWRh7jrLAN0rDgtNuvkvYf1V87FP6bfxSr/zlwvJLm0Trr3y0kmQl9QgMwbIHw8BAI5YwI9hB5vuc7vlF/ToowQUBTYlsv7r5FkpjKvwuBgSsKKkCeA6xMH2N2bFvAb4E5m2BxrmVMIS9XBXlNubuyi7ZlOcZFc+anbSusXZkDlKKLfqIGWxdPTXs3vmF6ZETv9f5Ohh+zp0qRg4FkL7R2wYTpqt3s1dxF8NgVDxZYAh9bat6iznnpiSGFKKvOB9Rq8DJAkCjBuqXAA7kK1zTCkgjER76S6iWBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k40IA2EFa7GRLDDDkFx0Ms+0tLqMjbW9/5P5w0rZr9Y=;
 b=i0vmipfWEE10gBYLPSiKh+S6Rk+9SMKk1lraORKlpgtMGpBpwScscDe+pN2YmneTtLPv5eQnEked2t5E3dUEq31yizNRXquzs6pGOulaTzgRco3vZLhm1W+XHVId5G9rwreqScF22szaymsj4mm0JbxxdJLZ34laQ33TYzle+KPSDwQqt/tNhY7Y880KCneDoMCJsuY1SROXK5z8pm6bT/p+D2nPI5M7nvIbBC9jZRn+BL0Z2S/wotrwFI76OyJY9Sb+iCAvIKK0KLXBHREb581myddERAAXIobkzDfnOT2YYEMPSoG2yQfLTkY3v5rcapOI2ywGfMYqGwan7AHMVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k40IA2EFa7GRLDDDkFx0Ms+0tLqMjbW9/5P5w0rZr9Y=;
 b=pS9MLSyU2gKqjLbheYISOrhYtPPTxQmQtUS4lAE8qYNlLYEtbsZS0WIUMZ9U9c7PerICRTJljLr9hh+swMm8vBlx1jMjkQp4UXAtpEfdLQy8IL4tbYX6i3P8HAeCnGA1kgaex/erUcxrrOMZCAZMTb++q7lz6N/UB5kp55ueU3o=
Received: from SN6PR05CA0032.namprd05.prod.outlook.com (2603:10b6:805:de::45)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.27; Tue, 12 Nov
 2024 05:13:05 +0000
Received: from SN1PEPF0002529D.namprd05.prod.outlook.com
 (2603:10b6:805:de:cafe::e6) by SN6PR05CA0032.outlook.office365.com
 (2603:10b6:805:de::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.15 via Frontend
 Transport; Tue, 12 Nov 2024 05:13:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529D.mail.protection.outlook.com (10.167.242.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 05:13:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 11 Nov
 2024 23:10:13 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 11 Nov 2024 23:10:12 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v11 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Tue, 12 Nov 2024 10:37:37 +0530
Message-ID: <20241112050740.15343-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
References: <20241112050740.15343-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529D:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d4c16d7-7343-42b9-3121-08dd02d8b023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SU9HQk5QVlRad0ZldzBXbStjSzM5K2V4ajNLeitybmFnTWRDVVl2dGRBeFpk?=
 =?utf-8?B?bzZTdmo5aUZOaVJkRUhoMVhjdXc0ZTltcHQ4Q2RaS3hrczhqcENKdDhXSjVz?=
 =?utf-8?B?RmN1dGNlaHVOdDRDaE8zYjdWdktvRytPbzRaSGgxSkc0OXkvY0l1QlN4eHM5?=
 =?utf-8?B?elEzbElDNjNGVVhhbE9CaGozSzVzMnFHaGhPZW8vZnRwM1Zla2dZeE4wN2Zo?=
 =?utf-8?B?bjZRM2tVbVQ4TEwrdzkyS1VKMFRRdVdNK3FRaHBqRTFkWERleVdjWE91VTFD?=
 =?utf-8?B?SEU1OFdiaE54aEpockVzNU5rQmNCSmlyK1Q2Wk9xZ2VOSmNQL2h2Y1ZKSDU3?=
 =?utf-8?B?SkRVdWdLQTNNSzcwVklLQVFxLy83VTlvaEpMRWJUamV1UmJ2K2VRclprL0U3?=
 =?utf-8?B?RVhSTUExSC9KdGZIc2NZQ1RDREtaRzc3S2NrREl1SFJQbUZzY1V0S3VCNzZs?=
 =?utf-8?B?dUZtRUF3Yys4SEc3cmlUU043REFSeGVXS3ExMDg0YTI5dlAxMFRwUDVnVEw3?=
 =?utf-8?B?RVl5RnZrVVhZOTRFalFPZFBtYjF2aWZMcUhZdkZvODhZeTNiOE5hT0FrK1Bk?=
 =?utf-8?B?Nys2Y28xd3ZpbjI2Rm1rTXlvU0d0Z0NUU3BPSk5RWFhuOEUrVDVnM2FicFNE?=
 =?utf-8?B?cVlreWQ3Nld1Q1dpOGMwWnRuZkhaYmQxeDV3UzRSajlHenIzS2pCVDZaVXVQ?=
 =?utf-8?B?Sy9pOVpiNWxNWVhhd3RhTlJhQjVzSndvL01STnZ2SGk3SXlYeXpKa0xtcVhL?=
 =?utf-8?B?OUV1TWxtcWZkTWFTTDdOT1dpRzI1Zk13OWhVNm14UnpKS01qVXArbXlRSm9n?=
 =?utf-8?B?RXNLVGFDRzZDQkxiY2FSN2lGdFkxT1hvZ296NVA3aGI1YktBWEZScHFoNko3?=
 =?utf-8?B?ajR1QllHZ3MrSzZ5d3RKTEZnSG5UcGxXT3dhcUozN3ZLUEIzQlhkWTlaZkNH?=
 =?utf-8?B?eFpoZjZZZnJhaFVoSTZ5MDdYZ3hHamtINTR0R0swK0hVNUZaUCt1eE91VHly?=
 =?utf-8?B?aG1NK1ZyMGxOQjAwYUgrNk8vRTdVVHVoNHdrRjM4RWo0ZjJmekk5YUQ2UHlp?=
 =?utf-8?B?VXB2dXNKU0Z5YTZLblNhUE52WUJhK1JDTDJLS1VBdnExQjM4cGh4MTc5a1FK?=
 =?utf-8?B?YnNsQnU0WHRiKy9sKzZ0VDRtcFJYaHBrRC81Z0hxUWxjb0RCR0t5YklyUmFo?=
 =?utf-8?B?cXFUK3JhalYycXc3Wkc1ZmsxWkhBd0FyL1BqK1J0dlVmTFhBdUVUcTVpbFpS?=
 =?utf-8?B?UXFOejFuUEs3UXhPTVZ0RUNkVFVlcG9hYnpYK05QVVQ3czg0dkJiN1VCTHhW?=
 =?utf-8?B?ZVZiODNiNnZkcDZoMU55QWJsSmZlaURha04wVng3UEZaa050dSswYUhCOERW?=
 =?utf-8?B?cXJHQ1hEaUdYZmNIZ0V1MmgzQ2g3eW1pbnd2a1NUNWdGUzVGZmp2RW1qMWFS?=
 =?utf-8?B?S3pYc2R6T3FTZlNXVllXNnFXdEZDWGYreUhpV0tPNTFsZUxEWW1DeXFVU3Bu?=
 =?utf-8?B?cHArRHEyb0c3QWRhQ0JhRXNydUxhS1Z4MTIya0M1MEQwN1h4aCtLeTczZ0JN?=
 =?utf-8?B?di83V0RBWDdWU3h2Mkl3Wkp6bW92TXdWMEc0dzhzQ2tlQVNqcEdRQlJkWERG?=
 =?utf-8?B?UnA3N056blg3amxxRjhNYzFka2ZVTXhaY0hac0RQVHFydSt6YzJoMkVQZEpv?=
 =?utf-8?B?eTgwNkhVRHVLeW9kU2VvMUM2S3dyU08wSWxCUHBSS2p5WUdwSWNINmRwVlls?=
 =?utf-8?B?cG1RWTZHN0N3RW4wd2hHMzFHTWNsUmlzMmJtNUI4ZndDekJJaTdxV0Ywendp?=
 =?utf-8?B?VE1CdmY1bGp6eHNwRlE2alE0bnY2a3hnMmtTY0tscnorV3JRdXB4Njgzd1VY?=
 =?utf-8?B?cTNvOWt5UFJmQTBSK3Q3UFdsaWZsNDFxbnllcWh1ZEVqUnc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 05:13:04.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d4c16d7-7343-42b9-3121-08dd02d8b023
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705
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
Reviewed-by: Marek Vasut <marex@denx.de>
---
 common/usb_onboard_hub.c | 106 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 1d146eccee..e209964f17 100644
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
@@ -53,6 +140,8 @@ int usb_onboard_hub_reset(struct udevice *dev)
 
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
@@ -70,7 +159,21 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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
@@ -93,6 +196,7 @@ static const struct onboard_hub_data usb2514_data = {
 };
 
 static const struct onboard_hub_data usb5744_data = {
+	.init = usb5744_i2c_init,
 	.power_on_delay_us = 10000,
 	.reset_us = 10000,
 };
-- 
2.17.1

