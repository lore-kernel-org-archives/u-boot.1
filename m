Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0D49D5E127
	for <u-boot@archiver.kernel.org>; Fri,  8 Nov 2024 04:01:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7636D88FC4;
	Fri,  8 Nov 2024 05:01:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="OpLlU7AG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7F35F88F6C; Fri,  8 Nov 2024 05:01:33 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061c.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::61c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4B20988E3C
 for <u-boot@lists.denx.de>; Fri,  8 Nov 2024 05:01:31 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L4USmi2V5hKpnmu/VSmYosVmhDmzNjZewSHDzF/JcTPKYH/iLGtvrhhpHiGqiXa/imUkNxL9ZHUe1DdI2THPxabcQL9K/q2zrpcJv3yPYSP6k4aHZH7HwYXqxYr/jIh7NevXHHQihF57by/BYefhfDo/IVz4/fK/sVaMG9ytMS29NGlub4M1m19AKVKS22mTc9j9gBNcz0vxF5ZriD/PA/Egp2NQw2bN+XusOyGAzdLT0eXjOmL0pxYcCju0uKKpO5GBKG1Thk/8W5V/QD/NrfJ24NyjSMXKKsVycdlh/L2cEdwo0j+w3SAUIR/j3YOvWjykcpjB/q0kqJuowzghYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcckEUxUR6L3k6/glOVijHnsGFbSaJq3UQT6Kibbdqw=;
 b=iY7hJ1bIQwaIo3vxyJTST2oqFXm9IMTuWpI5EPNlbMPFtQsmr86bFe03M7UZQLmZ6rRNO2jSfVWzCsizs/kKyoD4R5yWi7a0koXDhMUXxhG9Y6bwy4DupqcNwavnd2L10QJRU+z89BTD7yl77VixocIX0iK+UPM0aVHh5Un/ECweMr3T1E2dEtG7NIFvx8Dv4AVW6jvOP/mjaDB64ebn35tFFKSSWCpmh5b9765iSCKOcVfnldIPqx4Bb2xkSrbf+QERh/Tq+leOVNilB9Pj1nDqS6fjQlwh0+uSFx2PJ1zQhe93KUeoMqUzaGq+zriiY2B7osAwjgAYpD2yksJ4Ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcckEUxUR6L3k6/glOVijHnsGFbSaJq3UQT6Kibbdqw=;
 b=OpLlU7AGLVg1iI8mEdFRtbqwstJlbvPcf2tfcGNp2ASzm0lOaJiouTO6n7uCPinNgC7XTFrspAtIvv+RJkaOYQOGI/w7jv38v0NINALxzt4is+RCs4q1E5wR/s9Ml7ZGtuseOH6q/27XMG3McgUbPno0iWKTySO//ESUiMEHA6c=
Received: from MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::34)
 by PH7PR12MB6586.namprd12.prod.outlook.com (2603:10b6:510:212::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 04:01:27 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:303:114:cafe::1d) by MW4P222CA0029.outlook.office365.com
 (2603:10b6:303:114::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Fri, 8 Nov 2024 04:01:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8137.17 via Frontend Transport; Fri, 8 Nov 2024 04:01:26 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:01:21 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 7 Nov
 2024 22:00:16 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 7 Nov 2024 22:00:14 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v10 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Fri, 8 Nov 2024 09:29:56 +0530
Message-ID: <20241108035959.19970-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
References: <20241108035959.19970-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|PH7PR12MB6586:EE_
X-MS-Office365-Filtering-Correlation-Id: 36fb0243-bd45-4103-faed-08dcffaa04a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YnQrYjhpM1ByTnVEOFIydVprTlJCZ0NTNUNsREx5dWFzSy8rWU5oWHRVeTRs?=
 =?utf-8?B?amtnSXJkY0VTUzhQbGEzM3JVdWdTbC96cnhEdkdTY1lMZXdqZVE2ZmxCYXVr?=
 =?utf-8?B?UHNwVklleWhTMm8zNVFmVFAyRk9nMTlRT2FDOFVxN2xrTmRIeU1PMUlKSDJa?=
 =?utf-8?B?R3I3cWVjTjJVcEhMZmduOTVnWEMxdVNCZUtJOFhZSDh1YnhiL3FoeGh6ejNL?=
 =?utf-8?B?eGJmOXcwSzRuVHdTMlUvQ1JFaVp0N1JUdTd0OUsxSnE0TlFHS1BoMU02RHRW?=
 =?utf-8?B?SDJGcURra3lxbWlNVEZZNEhOaU9ISGpaM1VXQ2E2Vmt5YTdOWWk3OTBkYWxy?=
 =?utf-8?B?a1dNeDkwSllPcXk2aitDMW5IZkpvQkZBcUVTVlVXRGpkdXoyTXRpbm9naWFS?=
 =?utf-8?B?alJPZk56U2VQYXpaSU8zcTBXQk1zcnVVVzJLU3FzMTdnNm51dEVFZ1hqanZa?=
 =?utf-8?B?L2ZPZmxGT0FzVEEzd3lBMCtEMythNkx3L0JHUDBxajYwNXBpd3JSWmZzTENQ?=
 =?utf-8?B?RHZZbkphT3Z5TE1WT3loOUFXMWMzNTJFWDNSYXgrNGZhajlKQ0UxZStZd3Vo?=
 =?utf-8?B?L1MrQ0hGaXQxQ2pwVjN2L1FGT3BhOVFWam14ZFJjNkt2am9kbDRrV1d2czJZ?=
 =?utf-8?B?V0lZTjZZcFJJWm9CSS8wb2FNblIwMFJrYzZQSFVBcTc3UmxUL1ZKZWhYOGhZ?=
 =?utf-8?B?SUVHSXVrWlppa0F6bEtpNkxVdUJwNWZmR1Fkc2kxa1E3aG1hQi80d0FBOVFW?=
 =?utf-8?B?b0d5T1NHck9PbThraXdzWXhMSHBKaTZwM2ErOGVoMm4yNnNEd1oxYkNMTXZ0?=
 =?utf-8?B?WUZRNUUyeWFDV3dIS084djU4b2NScTJNcDhodjlEYnhZa0ZUWXMyNCt0Nmww?=
 =?utf-8?B?bmpNaFBHRzB5QXFZS0tNekpVS0dvaHFuL05NNWFjWXcwUWwrcHpBRzl6N01Y?=
 =?utf-8?B?UnZvMmJkM240YldtOUI5dXlXeGJzL2d2TjQ1RFZPWFNvNVowbkJubXhLUjFK?=
 =?utf-8?B?ZlY5dit1N1pNOEo3NXlBL2lLTlNJQWtZV2tka0J0dG0zRE8wNVExdzM0ODlL?=
 =?utf-8?B?S0dSU2dFOFJIeHdac0ZadE1EMkhuNHJvVDJBVG9Dc3N6RW92RVIwU0xTWks0?=
 =?utf-8?B?djZvWit2ZG1GMHB1VC92YlFjKzJSeDA2c255QlY1azVyR1ZEZzdWeDRPSWlz?=
 =?utf-8?B?OXZjY3RZSWIxYVA4YmUzTFFFckhTZ0sxcTZIV040YzJ5RTBGdFRWd2ZkaVNx?=
 =?utf-8?B?ZWU4L0pXM0llR251aEx1K21PWWRXVDltd0RLcUpZVVFDSWtaQ0t1b21nNkUv?=
 =?utf-8?B?dEFrUzFkdkJETUk5Sk5TeUsyWU1ENUNoL0pOcyt3S0NWRkZYNlcxY0ZkUndQ?=
 =?utf-8?B?YTlhUTNpdzB5eVA4YjZ0aTh4NEt4aGpiZHdOM25meU9FMS8vMWZkUk9KNUVm?=
 =?utf-8?B?YWp5YVRyQ2ZWdndENFQ3ZGRiWlphNUwyY256TTRyRll2WmhTczAwOWwyR0d4?=
 =?utf-8?B?NU14dVM3RGlyZ1hCdHlkS2EyaGN5WlpmeWdDNjVEMkdLYi9Lb2syY0s3cmFQ?=
 =?utf-8?B?V3lxSURRNGRGMjBvYWxoR0pIT2FCM2RHZUlpNjdIQTc5MXlPaFRRWktrVEI1?=
 =?utf-8?B?REJKREFVUDRpRFVJOE1aL3VxbVdEbXF1VnV6N2dTL2ZnZ1l5TG44aXRrb2dj?=
 =?utf-8?B?NTRreXE4R1JRTmI0NlU2UmUvY2pCU1JiVWlaenlINENyN3dvVU94c2V1YmpT?=
 =?utf-8?B?aHpKQXhJdHg2c1Uxb2U5bEhHN3FPY1VxaEI2djk3VWh4RStwR2pIcnp6cmZ6?=
 =?utf-8?B?MnBoS0FoVnBDWXN6MFRYQU8zVVA4Qld1WGRhYkxkeGptNUJQS2ZYNE5YRWZj?=
 =?utf-8?B?SnZwRHVCcjRDVFVHOVlMSkR0Rk1FNkZQcU5ad2dMbHhFbEE9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 04:01:26.5846 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36fb0243-bd45-4103-faed-08dcffaa04a7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6586
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
index e604c86d8a..dda41e1a94 100644
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
@@ -89,6 +192,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 }
 
 static const struct onboard_hub_data usb5744_data = {
+	.init = usb5744_i2c_init,
 	.power_on_delay_us = 10000,
 	.reset_us = 10000,
 };
-- 
2.17.1

