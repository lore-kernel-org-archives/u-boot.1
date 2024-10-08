Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD335CEFC26
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 15:42:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13E8A88EE6;
	Tue,  8 Oct 2024 17:42:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="buflQCVj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4282188DD4; Tue,  8 Oct 2024 17:42:17 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0A8D788E31
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 17:42:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KnV+rv/DmABOshkZJye8PjNME2Xli1Yh38UM07qbv+EcDQfvCxwB+N/DwAPFHZvqe85zuAH6IzOaWZZCgqS1Lxwibm7u4xfY3bwoAxXChFKG1ReSzM43KygZu3EAs5G88ATAq63urkxve8PkBa0vTXJmnEkYBKgIPe8QGqHflO/ZwmB0/+eH3u/me21Lx5FQrwuneicQj9jvgEsSQ2PeFvP9efjn1wnwIIRzcYKtlmLFDo/OOnYNDDx04HRqgXAcgiwXH890k6AtttzE8oKf0pVEKWcN68TeCdSouf41DJjxk/pvV+57enY/Jb+t0Nb1xtMUjIeb41BgGGAo9Aw+Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKRHRQMtV8mRxTKI90jDQWc3yzIVbsU8jd2DobI3ShE=;
 b=FADo2IZ0rB6jV2p1aeLM1qZ2A0TNRx8JHJxdNvsHA5DRJNSEI/CkmcEQPeDgIf7z6Fe1EUQvPanufSXZKEFcRiU01w/962RqQKh1XoGBAZidbQMb73RT8JtCgd7scBxsoRyeq9XrRgNJkfSn1r694D9Tv7rV+BcBLxDfpz5C8oRaiKDnbK1wNmH35ZvJp7KRQXOahLH82gjmAjzcMyx+cR713yckUu7AX1RbRNDm2V3yLUNLTGGhAspneUz8WK0/vq5arl1CB2Fbvnb33qcdkHR1A544bv/rPCRkvWYHrNO0tF+46lECTgRtNpbgZOXwaWOFbHjGNBXoow77J5RZ2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKRHRQMtV8mRxTKI90jDQWc3yzIVbsU8jd2DobI3ShE=;
 b=buflQCVjkA0eO5UurierzJJsyRBhkR8qPbhKuq0afmtZZ2qk/8rDq20p4/28t6CYyxYF0xfWcj3/qo5IUVY3dqo1gEAD5JYvIR5558c43IdNAiQRXkYOlMKeaalIKo8KNDxEcW5OpwbAmxz8cHrL82jKURHZT1i0LfB5L26MLZw=
Received: from MW2PR16CA0042.namprd16.prod.outlook.com (2603:10b6:907:1::19)
 by IA0PR12MB8350.namprd12.prod.outlook.com (2603:10b6:208:40d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Tue, 8 Oct
 2024 15:42:10 +0000
Received: from SJ1PEPF00002313.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::4d) by MW2PR16CA0042.outlook.office365.com
 (2603:10b6:907:1::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.22 via Frontend
 Transport; Tue, 8 Oct 2024 15:42:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002313.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 15:42:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 8 Oct
 2024 10:42:07 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 8 Oct 2024 10:42:05 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v7 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Tue, 8 Oct 2024 21:11:36 +0530
Message-ID: <20241008154139.31204-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
References: <20241008154139.31204-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002313:EE_|IA0PR12MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: bdd81cd8-5ef5-4a88-e33e-08dce7afc521
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWI5bXhFa3NpeDJrM2V2a2srQkdKbW9oT2JneTFHVW5kaGZ3eHByRVh0WmxB?=
 =?utf-8?B?V2hndVB5VFJ3VlJpZ0FuQ2RsT0dadGJnb0FMWmJvekZ1TC9zU25lQmV1eHFH?=
 =?utf-8?B?YmZXMU5HcDdCcDQ1RjZQOEZNbDUyc2JLUE9GSlc3QUErRFBOcDA3TitVcGF6?=
 =?utf-8?B?cUQvMFVxcDZrdGFsN1R4cmZ4ZUR3dU1aUjBTa1RoK2FjUHBlbnV6aktZbUh3?=
 =?utf-8?B?Rm44UVRNZVdDQjd3OTN3ZzFiRXp3c1VucHlpVWVWaExXNkluZ2FBakZFaGZO?=
 =?utf-8?B?M2MxNGcxUzBJUFVvVS8xdXBkbnpjT25mcUwxSXJaYTF5cCtpRG9ZNTErREtF?=
 =?utf-8?B?eFZCVjUxM3lLU29XNWljT2VxWkJ4OGxWcXZ4TVpTWWNoM3lITzYwMCtUZkFF?=
 =?utf-8?B?c1EvdUhkdytmeXVTOEU2andmVm9URUdCbmpvZlZ4eHhUUTBVZ3ZISGdPU25P?=
 =?utf-8?B?Qkg0TnBmVGtzblFqK0pHdmpLVWJmdkhPTlN2dGRvL3N6UmFCMXhQWjZQS1ky?=
 =?utf-8?B?b1pma0U1bTAvaTVrU2N6TmFJK3JVNHFobjNveTF3TlpJWUtwcWxWOWFVNUdF?=
 =?utf-8?B?TjdCVVJsVUsvQSt6a0FnelV4QkwzN3NER1RKTmlBbk5HZ2EzS21va2dUaXVp?=
 =?utf-8?B?a1hVemdyaUVpSkN1RnJhTVpiVDhvb2VVR2d5VzI0REJrejU3TWJqV0VTZjR2?=
 =?utf-8?B?QWJOdGRFSEFYZnNuVHo0NkljbE5qZnR2VHRqcjMxT2RFeXhvbzY5UHd1L2g4?=
 =?utf-8?B?Vms2NFJ2TXZKMVhwVGhDZXJqUUE4ejNNOUhueUh5K0RhbmswV01Yd0N0RHd5?=
 =?utf-8?B?NEl1RUtEQWUrTEF3TENNQTdUamJoTndma0dWM0YwOGhERUw0V1F6UzYvNER0?=
 =?utf-8?B?WEQ0eHREVS9aZWpGRXNBM0xRS3hFdEc1cXk4TnZ2cERuVFFMT3lJZUI2c1lE?=
 =?utf-8?B?QW1JMWl0dU8wKzhQeHA5SDdnTG5yUWZZd2MrSkQ1dEgzZ284K2tOUUpDNTRn?=
 =?utf-8?B?U3ZFeUxqc09iYllqMW1kc2NkbEhZc243cUJzcjRlWUZNaHl6N2tkTTJyK1RF?=
 =?utf-8?B?amdZY25SWUl2bDNWUWMwejUwMjF0UXhBS200VjFOc1ZQazFCL01TT1poREZu?=
 =?utf-8?B?dU1KTFdOWENHN2s0aDdiMGVFWlRsY2QwS2RkVllzWWc3ZG9BdHpUU25ROGdM?=
 =?utf-8?B?RnQ1ellPWHpOa3grUVdSbUZQNmxteEpEb25sRjNJS280UmZ6aUZBLzg1ZFZJ?=
 =?utf-8?B?T01RaGU2aCt5UjY0c3BWajk2VWxiSWNFcjNHeEZLRHJaMXRCbmFwQmZ1cGNZ?=
 =?utf-8?B?Zmo0UUF3YUFWdCtWK2VoM3B5eGFEQkwrVTZyMWxZejlwbEowYnpNZkNOQ1Fs?=
 =?utf-8?B?cWRHTEJGWk05b3lPUlo3SytGbEVWMGFvRDRIbUhyY0xMUXlCeUNtTzNlL0dP?=
 =?utf-8?B?enBtc3RJbm5DUllDQ2dMRHZxV2IybWtJUnFMQ1poVSszZ0VmS21UVkVGNU85?=
 =?utf-8?B?U2FvVFZsaXpBbml4U295eWZ4bGx3eDhiN3I2bDVRK3dJZlY3ZnVZWUNoaVJY?=
 =?utf-8?B?L2Y2bzBPWURtRVovbk1XVnNuTUNtSXlZQmlGNmk2eXZNaWNCeDN4eTVYdzNI?=
 =?utf-8?B?cVllNC9jV2VjUmdmV2hUNklTTHl5NHZDeUxtMUd4OXVGZEJ1dk8zUkswLzZm?=
 =?utf-8?B?Vy91M1VBRnp0TGpTeGx5VVVydDBmTlFnbU9pQWxHN3BHS3pabTRCdEVCNlVt?=
 =?utf-8?B?czV0M2FtelRISzB3OXhFQXJwWUJwQXJlV3RLQkxBQlIyTVMzZ3NGaXZ0Vjdy?=
 =?utf-8?Q?6upD5qUKMotPRVPw8jEUoXEBQ4kO3gdlhXyJg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 15:42:09.1455 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdd81cd8-5ef5-4a88-e33e-08dce7afc521
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002313.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8350
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
 common/usb_onboard_hub.c | 108 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 2 deletions(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 53b7a9c3ba..1a3569a135 100644
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
@@ -90,8 +193,9 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 }
 
 static const struct onboard_hub_data usb5744_data = {
-	.reset_us = 10000,
+	.init = usb5744_i2c_init,
 	.power_on_delay_us = 10000,
+	.reset_us = 10000,
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
-- 
2.17.1

