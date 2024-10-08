Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0BB0CED268
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 05:13:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AC58888DEA;
	Tue,  8 Oct 2024 07:13:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v0tW53QZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1D26488E17; Tue,  8 Oct 2024 07:13:29 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2728884D2
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 07:13:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fb8DXRJmsN56L1gtm7ttbvqSgYIZY1MCx6XtsmTijJ94uqrjtuznFajC2K6Nh/vvfAYEz4+kx5+/LN+P+FsEoiNMp+lhCQ7kCY1hLi50loD6yB88q0sYDkKs3PBW6Pxjavpy6JFHue7PHu47naEiJYMRj3S7cVkB/FYeUDQozSXH/tCQlbACcKJqwo9n9TWI+mMDQ4P9fRxiCVyj7A5rcAeREIZEWE6wMuecAgll+K+K17RvKFu18MqfjT4kL9BaHDVW4o1sQH3uHjlRk9Q7GcMHszAQeS26we6N3HYiR9ZueT/o1L8V2FkDucfP2rpZqGmheGikBPz6h6ZRu3vXkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GW1USLGqH7Lg4IfX13L+hFYmXmKDbj+E6n2EyUJQEwc=;
 b=Eb+EjFGZb5H6ntKruAteWNPCiPQ7zc21IPM/QTyEJ4CvbutPGmdJdT4qREses/UI9BBuroPqNwZk3sKRyT1m8/Fx3OhRx1NWFJcNRXn1obrST1eb2+Lu3E1lP9UALqRL5Z+V/CRmReVXw/nelyyPE1xypVd/Y8FGTQ85NgjTZ6Ser4DtETKAgycBIuMHxs1IPFhgQn/TG3DRrPiDV3Z5H1nB1YbkGLVDicmWU5g0se3BL4sC/StjcA27D0a6cq8bkQRbO3henY6yuLGtrG9qaoFWJltWNke4m8BEcUgFexGHq1W+4ZD3Bi662VojF3hjMQIikY6Qmkpr6aSL5Rhlhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GW1USLGqH7Lg4IfX13L+hFYmXmKDbj+E6n2EyUJQEwc=;
 b=v0tW53QZF/ErEh+wEZTJVNZBwxxblLJxaH7o2qIGoHMKq+lGn5gcwvb6lk1dWL4F1ATjF03BYOOphTt/lAPvbIyXZQxo0Z1+v8NTJlm3OiKbtpKn69YLmvVWQKWuCvpNxDh3fUH88/iiozNWlyaUrTWR6OpMY3Astv+WVLmfpPU=
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by SJ2PR12MB8873.namprd12.prod.outlook.com (2603:10b6:a03:53d::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 04:58:37 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::69) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 04:58:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 04:58:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:35 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 23:58:33 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v6 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Tue, 8 Oct 2024 10:28:05 +0530
Message-ID: <20241008045808.28757-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|SJ2PR12MB8873:EE_
X-MS-Office365-Filtering-Correlation-Id: 377ac482-8426-4fa2-3122-08dce755de75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWRVYllMRWxWSkZzTUx1MzZiL2h5aDJtT3pDVEUxMENnZkx2emRZMThBWjNT?=
 =?utf-8?B?SW5KcGtLd1pxQ2ZLOWNINjh3N0haS3lzN29rNlk1UzBHcjgvRkFGSkxCSFR4?=
 =?utf-8?B?Y2ErcWdwZitCazNhdGZXSGxZWDY1bWxyMTFLNTZUWVYwb25md1MrNy9qSXhC?=
 =?utf-8?B?UDYybWplUzJsTEh0Tm40dmt5c1FjQ1hJTGRFaUFzKy9oaS9oWmFmQXU2dk1r?=
 =?utf-8?B?Yk1sWm1IVVNjL0VMSThJcEZqdHFneVp6L1FnTFN3VWRodnpubklNazdQUWht?=
 =?utf-8?B?S29TdUFic0d2Ujh2SEQvaHpGM0Q1U09QQllPbUJIWE53TXVvS3dBK1NlM3dR?=
 =?utf-8?B?b0trUERiSnprQzR1VHN3ZGx0MEZTaGczRDBOZ1NucXZNTkp3SEFzb3hyWFMw?=
 =?utf-8?B?L3liVFpkUGR0RXRHQ2FxOCsyd1pSZkNMd2czbnM2Ulp4amJPNWczUGVKeVU4?=
 =?utf-8?B?Vzl3aEZZa2l6NzN4YjBJMzZkZjU3MGs4NEp3a2t3aVBad0pzOVl1NFpiaGhm?=
 =?utf-8?B?K2lwMXc4K3pCczBGbnUyaXZ2akVPT0RTeXJsaFYzM0RqaUpieGNLNGtHRUpq?=
 =?utf-8?B?U3lTWmsrQ29uUG9URmMzU29IbXZlcmpRajRhQzRiUXRKbExUNGxjZVprL3h2?=
 =?utf-8?B?anI1dkF4QmF0THRVK0taZUFiYmRkQk9LV2Z0WEQ3V1c3QWwxaUZXQ3ZGd3dq?=
 =?utf-8?B?U3p0KzZJdFN5azUzZ0x4VWVwcU9lQkMxMGJKRDkySGFtM0JVUm5GanBCZnVZ?=
 =?utf-8?B?Z3NRdjA3Nys2cld4MVhDeDlSYk42Nmk4RGdnK3VSbjIrMFRWZ0pybE5JTXZW?=
 =?utf-8?B?TUtqNERPV2owQkg2eUZyb0ovZ2FYcTdpbGpSdkdLNUlQWEN3TkNQZlk1RUFG?=
 =?utf-8?B?NVZiaVRQdTlaMVFsbTBQdmg5M1pTYStMVzdLZkh6VEZGakpuVDF2ZHZYd3JK?=
 =?utf-8?B?QlFSQ25ta013d1hYZTRCcWRWdlNKdFlEU24yR1l3TzhLOUhqWUxpaGtmalpV?=
 =?utf-8?B?bDRiVzZPZ3VaU1h6TVV3ZERUMFYwWFNyeVE3THVkajNGM0VPZDB3R1g4Szkv?=
 =?utf-8?B?eHNaQ2pFYkJSQmt4WUdZbTlzUS9OREJTd0JIT3k1bkZ5aHh5VWhndHJNcldr?=
 =?utf-8?B?VDY4SEJFNzZaQk9IU1I5WC9VdERVMFhQMTEzS2hSWTYwdXR2OW5qMzc3OHBk?=
 =?utf-8?B?OTlKN2RiMHpydEtIaXdWZytwaFI4WjF4KytFWGtDSE9neDZGWkNPNTBUNFdL?=
 =?utf-8?B?UmVQWWU2djZTMVU2YnJvZkhnR3hxTlhwckZzQ1p4eWJpQVhpaXZjMlBOWHRn?=
 =?utf-8?B?MjRhZlB0bHFOZG8xNGRya2hnbi92NkdRa3M1Y2JEY0ttRU5QSE1rM1NaL0h1?=
 =?utf-8?B?c1VVUkMzT3A4NnZ6NEgwZk5XUUtueW5DcVhxR0lqQnZIc3N6ZXVuV212d3lD?=
 =?utf-8?B?dWRQaFhRNDcrbTl1dXRjWTlpVHI4UWZGazcrRHhBVk5yTU96QmVvUFRaditC?=
 =?utf-8?B?SVdsem5ZWVFNU21Vbk9KQlh4NWRUUmRHR29JTXk3M3hZaXp4MWJjbi9rNnFv?=
 =?utf-8?B?aWZESUFnM3VVSG5NTEZjY1lvUGptVmlHM2tFcnQ0cDl1dTlOMkNPdjlhcjdu?=
 =?utf-8?B?VmU0dGg2czFtMDJBVEl5TW1lamxvZDBEN0tYZURhRGRNVSsyWlROM25wRk9I?=
 =?utf-8?B?WjRIeUVVcTFkRXpaMGVURWdiT0l3QVVUVDJ2OHowMllmMWpYZlE2cnZuYkxs?=
 =?utf-8?B?R04ySVpvSTZvcWwxaTBUaXo5eTNheUNLNmJpVFdMSThROXFSM1ZUekZkWlVT?=
 =?utf-8?Q?FOc6y10e0WMwPvH4hcV7tQ9LA5G2uoBslWM30=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:58:36.9288 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 377ac482-8426-4fa2-3122-08dce755de75
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8873
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
index 6eef93171d..5588a3baae 100644
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
@@ -95,6 +198,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 10000,
 	.power_on_delay_us = 10000,
+	.init = usb5744_i2c_init,
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
-- 
2.17.1

