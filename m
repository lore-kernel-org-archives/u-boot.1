Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8D27D3B7D3
	for <u-boot@archiver.kernel.org>; Mon, 25 Nov 2024 04:13:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 15E7989A02;
	Mon, 25 Nov 2024 05:12:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="E6w1xL3B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 82141899F0; Mon, 25 Nov 2024 05:12:49 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::620])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 00F7D899F2
 for <u-boot@lists.denx.de>; Mon, 25 Nov 2024 05:12:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K/ah0EhzmL9H5L5P1N1V3XwlhWCQUBJliJ5GNWJZLmXzNMkuZuxX+Wje2qi0PPV4JmurU8+nVqJq79y56uj7wgNZ777yBOf4Q5ahpE8A7MaV3G0DU6V7zQfe0Bv/nJhuatY51D9FWWcmE6G2nsCDa/cz1d9HfdB/kIhxChXfrfSZOf6D/433FOUvWTQTMtObibX4oG20LmBPwJCFNkNQv5nQ4mCmB11nDCMQWbOlJP7UU8en+vtTZGVvaXoKo/1phitjwb5coQu1gdY+YwL1XOMqWQ0RsJQkelsIXHUIo8pNpi5+2I0xyjBprA0T1AOMXZMiti8OjHKXSWhFhZWvGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=diSYgFCVOBkZwlqW3U2vd4DW7O/6LtYkyu7O+NOxIjU=;
 b=aLixaU7IiSoNztbWPNPohs3S5cVqzFWOpZhTN+IfaC5LEB4iDHBSJS/gSFkG6V9Yn+Jvfx8qk9SJiupxEQAuMz4106oAmT2JZYWiEWzzUcEvCBj9ZWd0xLjdfoud5Yo0NiNV352a9rE7SoL86ksE7pJqLXq3yD0uv0RHfKOx04YVDpDHeXe/dZKW4mU5K0GK0nUabTwaZLqIjllM5ytjulTf/LpQ8qye3zHONBwW+cFRuYw1L1kIQP2XsXxAciEbODDnl9kMSsJyi2Zdt5sFytO1tAamY3LBw7gNwDv6jE2H1rmnsWMok/JLyOyPkXqu2y6O88BLL9CxMDD/rDObZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=diSYgFCVOBkZwlqW3U2vd4DW7O/6LtYkyu7O+NOxIjU=;
 b=E6w1xL3BiCnCj41/I2gtgjfUM+t1Xcqbu6lA9tPiVr8fyJxRrfcZOzjKTJVg6Em4g72OIkK9T5zzJGmavQLIowv/yQkjn8hfu6nhYLG8gld+f9FqObwtcsiId2aSROcL5DE+MDO5qdf9fJgU0di6QMYrA6gQQwiNaZTphhMlmKw=
Received: from CYZPR02CA0009.namprd02.prod.outlook.com (2603:10b6:930:a1::27)
 by PH8PR12MB7135.namprd12.prod.outlook.com (2603:10b6:510:22c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Mon, 25 Nov
 2024 04:12:39 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::16) by CYZPR02CA0009.outlook.office365.com
 (2603:10b6:930:a1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 04:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 04:12:38 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 24 Nov
 2024 22:12:36 -0600
Received: from xhdlovek40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 24 Nov 2024 22:12:35 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v14 4/5] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Mon, 25 Nov 2024 09:42:01 +0530
Message-ID: <20241125041202.980-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
References: <20241125041202.980-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|PH8PR12MB7135:EE_
X-MS-Office365-Filtering-Correlation-Id: 818e52e5-b05c-4f27-2e28-08dd0d07665d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0xXTEo2THE1UFZaN1N2VnRRaGlFZjliN0lGc0xHVHNteEg4NU5EQkRGZlRz?=
 =?utf-8?B?Z1JhSWdWTFUxTkwxNFEyRHRHeU1sb25qSFBsUEZKTkQ1Tm9Ud0dFS3F4U2ht?=
 =?utf-8?B?NTJkd2Q0RjJTelJ4Y0I3UzA1cFozRE9YSU10V0xLK2JlZ1lWd3NYZ002Vmlk?=
 =?utf-8?B?VE9RTGFvM1pTWUZaZ0NvN2h4THFWYnRBYXZpcnZ0UkVZME0rRm12aEFWOExZ?=
 =?utf-8?B?T0xQTVVYKzlVcjN5OHFFd3dGNzdCdllJdGJJbnlIamZ0OWpMZVpSQVpnMkYy?=
 =?utf-8?B?akpjazFONkNRR1R0NTllSEg2UTJ0WDlMZFB0U2lwbitleTA0cWZweG96eWp1?=
 =?utf-8?B?N3NKQ3RlaWdaUDg5REsyMEp0VTNVa2M1NldCTVRVN2NudWlSS3ZiWjZZZ3Ns?=
 =?utf-8?B?b0FFSzI5czdxSkFoNS9OTlIrcDh5bC9KRURjMDBQd085ekN3ZDJwMS9TaG5z?=
 =?utf-8?B?dUZyNGNQNlpsODhWenpMUzVYdmNPTE1QQzRnNnJ5bkF6ZXdnRUZOMkw3QlFm?=
 =?utf-8?B?eTdBbFErMTN2MWZGYkNTNWUrUVFkZVlpMlhrbFhndjlPYVYrd05XKzRnamR6?=
 =?utf-8?B?bU9seE0zRFRSZGFlNGoyZVVGY1UwTGt0R2NZTjRmdlF4UEJzWnk4YzJCa2FG?=
 =?utf-8?B?dnFNSVlNbWZOWnBYMC8zalBFRUpJQUVBeWdGbVl4OEhoekhHTXFXQ1Q1cnZw?=
 =?utf-8?B?L01rbXI2UlQxL1VoYThsOXZEbllyZmsrVk5ZQjVtZGRTNUxVTnlCaFlhdjdU?=
 =?utf-8?B?MHJHWGsrNExLY1FrMi84ajdIQ2pZL3RldkdkT3VFWmpNaitUQm5ranI3OUpN?=
 =?utf-8?B?NXpkMW1BOFk1VXBpWmJkc3prWDJnOEh4bkZDSDJIeU96OEM5SmU1ZlRiQUMy?=
 =?utf-8?B?Ry9tWE5PcnJaRi9wVGphdVMyeXRKNlFlMDBBZ1BkY1J5ZVh0clkwUGFNYXVR?=
 =?utf-8?B?RURZLzZuckRPbWNhS0xYWCttWmFwUXV4UEUzR2pQb1lyNGE1a3VqL1lxRUpy?=
 =?utf-8?B?TG1TQTZWNHBQS3RVVGgzQWJ3QjFuSW95ZVhhV1lnVnhxb0VWY29LUkg1b2Y3?=
 =?utf-8?B?Nm1QVDgzelZycDM2QS9PM0VCSmFIek1WQmIrS1c0M3EzSVVaVEdQbzkxUU1J?=
 =?utf-8?B?K0NPOEhOY1JHbDFOSHUrak1PcEh4TXIwUmJDWUFGK2htNUNhUnNrbTFIR2Ja?=
 =?utf-8?B?TGczdzRSYXh5VWhkd09FcmI3WlVoeVczb1gvaG00bXMzOHMybGtIVkt1clRi?=
 =?utf-8?B?dXc3TTJtZTc3elFnU0pWejhIeWNLdC9FRUFVWExKaW5kT0dRRE92MlBGUWVJ?=
 =?utf-8?B?bzBmTFlnY2Y5cExyUk8xdmZWbXhhUUJqaXd0MGlyN05zNTE1NE8xQ0s2M1lM?=
 =?utf-8?B?aUNuSjduR3hLZ3VYNWVmRVpyYzN6SnRyV0xWS0J3MzhSK1VxaFUxaThqdGlD?=
 =?utf-8?B?V1ZzOTlFek0zUk1aVGtLMk51cGdsQUJvNDBzK2dibFA1aHFvRWNhT2ZyNGcz?=
 =?utf-8?B?K0dYUEJZeUFQUmNnN0kydmRKbTdXUUhOUDBCTWxCaHZ1ZFRBaFhFMmNlM3lH?=
 =?utf-8?B?VnVVTWdRTWxYMzRaOVJISnhlUnJFQkNvVDZlZmNta3pxcXlCRVY2MlcvTjZ3?=
 =?utf-8?B?OCt2cjZtbkxndmJOdVZsU2JIWVF3dXB1Z0VRblQyOVJoeitkYUVTeHNEZkZi?=
 =?utf-8?B?ZWdlWTkwOTQyYVN0NFFaRC9na2kraWFlT2MvR05KMjRKT3JuS0UrVXB4SFJW?=
 =?utf-8?B?b1RVMEx5YnpRd1B4S3BHUC9nZUNFeDcvcEJ5akUydDd2T0RlKzlnZ01SOVJT?=
 =?utf-8?B?R0xibFFxSHBpL3NIaXoxUkZFMUhHN1dSRk5NS1pSc0Zzc2VlN3kvV3g4ekt3?=
 =?utf-8?B?V0V2cmcyVTQ3Um9kYVFudXh2VHFFOUZwMGNETy9xL3E3aEdPMjYvMktYVGJ5?=
 =?utf-8?Q?ugnRC9ho64Nj0iG6PZOWpws08Ssj84xn?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 04:12:38.8074 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818e52e5-b05c-4f27-2e28-08dd0d07665d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7135
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
index 4860de5323..bf71266272 100644
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
@@ -94,6 +197,7 @@ static const struct onboard_hub_data usb2514_data = {
 };
 
 static const struct onboard_hub_data usb5744_data = {
+	.init = usb5744_i2c_init,
 	.power_on_delay_us = 1000,
 	.reset_us = 5,
 };
-- 
2.25.1

