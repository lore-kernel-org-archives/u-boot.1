Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91339CFB440
	for <u-boot@archiver.kernel.org>; Mon,  7 Oct 2024 04:47:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E16A488CA2;
	Mon,  7 Oct 2024 06:47:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UYC4iG60";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3595188D1C; Mon,  7 Oct 2024 06:47:10 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on20618.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::618])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6407688D07
 for <u-boot@lists.denx.de>; Mon,  7 Oct 2024 06:47:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNtlRk9Fszumly4J85EbRkCqCHuWw/tUf/ZHM1arPWYFaGMgAj5P8lG+wbsKIS3v8WytSLRpf9iWRtIAyt0mtCUOm5f04ORQBzOl07u9ULDSmVJWo4cbN1TQ0J8jJwGfm9Fi9UJ8TBPVGQti/9sWaLKBSAJymRvJe6dk4b1XJZKTWcaB3r0RhE17MBt8REHV+HY2EOptwP4cBSorqZ11if9OBXLK+oKo3PuEJT/X5BzX1S5b1dvvZjea73vzPzsmuTOzbd/KG8/o+1gB3I+nfw0FmtDgODJbAZXpBEy9RlnIhSljPPCYDCIktwtmFdpQB/53euPqVtU0e/6SQzAo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJq5rkJkPaUib7XvVlJ4kZEl8Cku/hDR4xb/6NVyrZk=;
 b=nvp6JOFS40hZfSv5HPX6vxlaRYZt09osYuZA6Pbwp5V0GBhhDCjCq/4nIBqZdEtrSk5I368mFvrEas0SIVrCsGZqkCpLsudx3Pd7HCJr0UVrZvz162HCwBP9UcCn0hWTk5m0dRh7UKSFAg90XYUhIFv1L1QP71Rgohkly2H4cnKaz8ULoGXGpuX/ri1+y1wx5SSVnujdpe/kcld9A5Snzo6akYG8D4QCH/bxs/Ilx0vHhCNwMC/yAhk1HYziHEl5YB6yKJcgV7/UGq9EuxcobiIqXRnqrV5AH21cWS922SlrROLVPz9yZdohR2kSsyfTJSKVp7VKdR2AVr2wwH7MBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJq5rkJkPaUib7XvVlJ4kZEl8Cku/hDR4xb/6NVyrZk=;
 b=UYC4iG60qHy+ULVPy6bScORQeQMkl6jGXa4FfBU7ieChv7arjDdfBUopVUjBl51ehdcl7kXK6hJ5pFk6qjsnhGkcgW5lcrYSY2z+VlB0PgR8aQAvcPmLf7VSf1UwmHjTJCE8aBQ1ZDsIQ8fh+Za/ME9JtrIaQew3EpyB5MVIuxM=
Received: from BN9PR03CA0213.namprd03.prod.outlook.com (2603:10b6:408:f8::8)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 04:47:03 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:f8:cafe::fb) by BN9PR03CA0213.outlook.office365.com
 (2603:10b6:408:f8::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20 via Frontend
 Transport; Mon, 7 Oct 2024 04:47:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Mon, 7 Oct 2024 04:47:01 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 6 Oct
 2024 23:46:18 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Sun, 6 Oct 2024 23:46:10 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v5 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Mon, 7 Oct 2024 10:15:44 +0530
Message-ID: <20241007044547.23896-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
References: <20241007044547.23896-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: 1689f06c-eae3-41dc-ca05-08dce68b15d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZjJwTVVSWVJ5SnNrQkk4MUp4VVkxMUhjaDlIZ1B5cmhtMWN0TTlrQWlJRUpv?=
 =?utf-8?B?RnNXbXI3Zm4xZzJ2TWk0M1pZa0l0ZWxSQmVoNFk3OU8yMHcyYndMWDdMVDZS?=
 =?utf-8?B?aW9ZOVBYOE91Uk94QmFjS2grYkJIMjA2TldobWI0WjI3STFWdzJBemRrMDFa?=
 =?utf-8?B?UkE4bzVYMUI0UGRwbHQvVVhUZ0xNOE1oaWZiMU1EdEwwUDNYZlR6ZGRqWFRI?=
 =?utf-8?B?QVphbWZDSkdCK25MbDNpZDF6UmhabURaTG1EQkNqV2k4UElIaldHK2txQkFz?=
 =?utf-8?B?MHJJa0EzMFo4Njd1NW5ET0RIc1lrTjUyRlh2aS9jaWRzWnVkZnY0MXBKdzBS?=
 =?utf-8?B?MlBOa28vdy9zTkFYQW0yS0l3bVloZUlBdW5lMHBjV1pPR2FHUDVscldRZGh3?=
 =?utf-8?B?aVVmQk5UdEt6L1I5TXJkWjBybldFOUsvdnNsU0F2aUNlTTZvU01RVGVlOWFZ?=
 =?utf-8?B?blBOb3FKR3YvZmxpbXlIRGdaS2dQejhURnFReXk4RFVHUWIvQ2EyU3pvc3Fq?=
 =?utf-8?B?cy90U09hNTNjRk5qRkFOaTlDK0N4N2M3OFB6WW9oODRUZE1uS29VVExmVk9X?=
 =?utf-8?B?a2ZZY2d5SUZLZHY3bXp5YUtwMGY4YTA1VFNZT3ZuckdmbkxWeHdSbkZMOWdW?=
 =?utf-8?B?aG5SYlQrSXM2aUNuZFZFblcxb0ZvRld2ZzBQRnNGSFlWeFhmRnJYWmNaRmov?=
 =?utf-8?B?Q3BmZGw2MGN3UmFFOUIwTjFRUHV0VUhxamh2c1ZYRnZwdmoyMWY2eU1jY3JO?=
 =?utf-8?B?Z2NPWllsQStKTlhmaUk2YnZnMnFzNmFxcDlVT3BYSUZzOWpBc2J5YTJVZWtu?=
 =?utf-8?B?K3N5QlhMc3ltRTRTdVF6QXNxQmtDUHVGY2hNL1lpclY4dWUxMUh2SGZXeThz?=
 =?utf-8?B?eXVpcFB1b29ReXhXeHpJSGlseFBBVURqekdkZnMvUmJSWmcyUjhFR0d1U2lv?=
 =?utf-8?B?Mk9iSk1US2c2Vml0YktlOEQzcmc4WGtZd1I1U3UvT3ErYjh6b01kdnQzU1BF?=
 =?utf-8?B?WjNoU2dkdDlqc28zYnRaRWNPK2xmb1F5MUVEY01uS2ZOV2hRdDFNcjJ5RTRQ?=
 =?utf-8?B?OUJONkZUd1FVYmtpQlV6NkFwZ2dpQ2FlajBwb3RnT2Y0MnpWbUVxVU5VVWVi?=
 =?utf-8?B?eFZWOS9kR1c5TzlROFlBdGo1NTNrb2ZSUnlkc1krYnVnOFFDL3owOUtsbUdu?=
 =?utf-8?B?T0tlSFR5aWJ0NGtaODN4WVZvMldPZ0VxL0FmMXlDalVzNk1VYy9mTUZ5bEpY?=
 =?utf-8?B?ZFhwRlQ2SWxwR0J2NE90NDlwOUZBS1prU2ZNKzR1emVCSTE2OFVJMzlTR0pO?=
 =?utf-8?B?SGtaOUZyeG9qaFEwSmVVR205dGZsSWg1cXJLK01EOUphVHk5RllxVFdVS1hB?=
 =?utf-8?B?VXY3Qjk1Qmh0Tlh0SC9CUnlEdnIxR21iS3NXQVJUQWo0NzZSeDNXYThFZnoz?=
 =?utf-8?B?K3ZKOU42ODlnUlJqbnpnVDVKQ0I0ZWgyU21rNVVQTkkyQ09IdUhvV2NVMmhV?=
 =?utf-8?B?cnJnTS9zOCtBQ2ovbkJtdWFiQXBkamUybkZoWnVXNG1QRU5nTXFEYWlYNGo2?=
 =?utf-8?B?NWx3NE93NWJwUzNxZXhaaHlvNnp3c1Fab2QxWWhDaEZ1WXR4d1lsazFSeTZj?=
 =?utf-8?B?SXVILy9pQ2owd2VwM3NpbU10OHV4YVhIejltWE8zVFY3RmpYRXVhQlZXWUFF?=
 =?utf-8?B?UGxZeFVsOHpzVWI3MENONGFTUGJ6V0ZhOUVRTzJnb2thRS9PYk1aL3Vxa1JP?=
 =?utf-8?B?VENnNnNPNXRPdmR4UGxUSGsvakUraXZOR0F4T2tLSTUxWG91cmlmalJzeWZq?=
 =?utf-8?Q?H08in6rAnZHkth/Sgp2XlaJeHrjQX2JAoFVIk=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 04:47:01.9833 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1689f06c-eae3-41dc-ca05-08dce68b15d0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555
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
 common/usb_onboard_hub.c | 101 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index bb4402455c..ba58ff8c10 100644
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
 
@@ -75,7 +164,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	if (ret)
 		return ret;
 
+	if (data->init) {
+		ret = data->init(dev);
+		if (ret) {
+			dev_err(dev, "onboard i2c init failed: %d\n", ret);
+			goto err;
+		}
+	}
+
 	return 0;
+err:
+	dm_gpio_set_value(hub->reset_gpio, 0);
+	return ret;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -99,6 +199,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 10000,
 	.power_on_delay_us = 10000,
+	.init = usb5744_i2c_init,
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
-- 
2.17.1

