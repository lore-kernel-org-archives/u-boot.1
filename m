Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C16BD49205
	for <u-boot@archiver.kernel.org>; Mon, 18 Nov 2024 10:11:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B5F1B8944C;
	Mon, 18 Nov 2024 11:11:56 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gjiKqE8j";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A418388E3F; Mon, 18 Nov 2024 11:11:55 +0100 (CET)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2409::623])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AE4ED8944C
 for <u-boot@lists.denx.de>; Mon, 18 Nov 2024 11:11:51 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iSL+RmZWYFL8LXO3VBwnr4vlgzKWX2c328i2qrIMn4QFbV3MdrZJ5O5bIaPHRdmfKSqPzFGstNgvpxD02MxhHw8p4xZxT3BGMWzjUMwsYCT5FpJqDj4HXFbfFpYm41+LTd0+5j3sBvTqMe5M4Ier5HZCAtAyhiX66R2QmFIAoac9YI+dSGHrh62FvCwARjnCHatKPXuht8cClBvZoPcooGg2FHVuBXomU+xhYa3s3ZZtzsdiuN9dOI5aau+0aiFrWidxNs41lsu3kuqjOli29EIC3Cf5NL764RktbwOUJ1sKOXHM23jEwFMkKRLW0LT0JQk+ODi3q9EgC3MjHAO8vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qo+w4uMG1mYeUsj3LZXlCAdH2EN+ej94E80TvIQa7f4=;
 b=voCLYgAs0H+bFms9qaQtSYMPFdLFO0Sqe+ko1lNpuCD1BG1+4bzhC5iuyiejPfE+EJP+IeGYOnNaEvujao5HKcNqbmUgqoxO1UGYxo9Mef5VVur+js5I+sJn9i1nPhYN73+gMTtH0pZXe5cLm18/SmbuWTqzAFg20fqXJ+GnWEFva1HBB8jBA6A6dgpcYErlCjOW7nsAULitdkrU3P8Y57VkGkHtY4duR6/hIOcxBvuDsdyXxu3F35neuz+auVLbIOdw8d6zmqRFEOdA99RrZMkOP7SqzbAZiu4B9Gb2IIx5H8vTeBrI0SxejurUjB6YG57qh+UACwXvMVorL3Vzfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.12) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=fail (p=quarantine sp=quarantine pct=100) action=quarantine
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qo+w4uMG1mYeUsj3LZXlCAdH2EN+ej94E80TvIQa7f4=;
 b=gjiKqE8jowbiR7FCKCm0KkEk9VBNjlaj6IMPnz85cqR0FPXmJqyKwFpHdxXxSu+OZB4NohQbzxNTGFhuFlysVz3ONVpQ68TrJl1lBcDuKQ3Ai0pDFFIA4o+C7BPgbeqZkbGXuxX2qviwm3Bc89DwXprefVtlB05I1xcjmW6NtTg=
Received: from CH2PR05CA0042.namprd05.prod.outlook.com (2603:10b6:610:38::19)
 by BL3PR12MB6451.namprd12.prod.outlook.com (2603:10b6:208:3ba::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 10:11:47 +0000
Received: from CH1PEPF0000AD7F.namprd04.prod.outlook.com
 (2603:10b6:610:38:cafe::1b) by CH2PR05CA0042.outlook.office365.com
 (2603:10b6:610:38::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Mon, 18 Nov 2024 10:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.12) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.12 as permitted sender)
Received: from SATLEXMB04.amd.com (165.204.84.12) by
 CH1PEPF0000AD7F.mail.protection.outlook.com (10.167.244.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 10:11:47 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 04:08:03 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 18 Nov 2024 04:08:01 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v13 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Mon, 18 Nov 2024 15:37:44 +0530
Message-ID: <20241118100747.30121-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
References: <20241118100747.30121-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7F:EE_|BL3PR12MB6451:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e174eea-d53a-41a5-7eba-08dd07b9692f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eUpsbndlbFU3bjN5TWlPdURxSi9RaVZ3RktBekVwb3czV1BOUjZPNU54WmND?=
 =?utf-8?B?OVRTM0FWZDlhR1FCbjdZd1FvMHhVaDdTNzdCQzdUY1lJdERFYUZWZG9JVFVk?=
 =?utf-8?B?eVZ6NFZib0ovQmFhUTk3RUYrN29TYVdRR2dmbVZzN1lmbk9vU2RUWFpKQlQ4?=
 =?utf-8?B?dnhXTDFpVG9UMUJ6YnJLcUUxR1h5Q3ZaNkRhWCs0TEFTMmQycVF3ODJxMFB0?=
 =?utf-8?B?bWpkUU5xUHlsUzVQcnAwWlRkdWs4L3FjdUF5Nk9lTDFiM3NXVjh2bmtITDVH?=
 =?utf-8?B?TjUwSlExb2lZZHRXaVVXckNZZ214ZjZWWFVSU3JXQlp4cVM4dExtN3dicHl6?=
 =?utf-8?B?bCt4WVVmNVdqaHZycFo3N0NNdjEyV0l3VEF3UG1ZbGNDSmRrTlRKc0lPekpS?=
 =?utf-8?B?TDd5SG82djJ0V0RkVnZiUk9oYlAwZFRIS2NSOHlhSEl0Z2o2NFFhK2RETVpZ?=
 =?utf-8?B?R3N2NzM1SW5xeVoxOXVsKzB5eTN5OEFhMHFSYzBDa2FWbWZqcTNNclZnRjJm?=
 =?utf-8?B?R0xGY3ZVNVRQbDVUOHdJa0Y3VkdjcXc0dm93TWIyK2RVTHFPMXB6dmsyS2pT?=
 =?utf-8?B?RzFkMnFQMVhicUJjQ012S2R1RnczT2lzWFJiRDhhOVhiTitxRnByMmoxdDdz?=
 =?utf-8?B?RnRZV2lCcGJZT2VYUDJ6ZDJNd253bG9HYkNjbXVlQUQyRHljS203eEVWUXVj?=
 =?utf-8?B?dy9jNldzTHF5T2UwbU9IU1NWOUZ6T1Zka0F3MGNLdkR4NjlxQjZsclFOYTVO?=
 =?utf-8?B?VnhPaVhxbTgzdDJMVXNlQjVleW9xRUYrTlBlNGEwdWYvUmlNbWw2Rks5d2JU?=
 =?utf-8?B?Q3czTk5vMG15d3c0cDlDRUhvMVJ2enlEM0RwRTFnL2padktqaTNnOG5PRmZZ?=
 =?utf-8?B?L0VrdFRGQkIrUTdRc2QwVlVsTFpYTlZPMGRVNGoyRG02RmFac094QjM2Z2dC?=
 =?utf-8?B?RTI2K1k3YjlxMXdqNjM4b0czWmJvanB5aktnNHlmbVY2czF2MGN4M2V2SHVH?=
 =?utf-8?B?YzZZeHJ1UjZxZUhqZlcyazI1THIrVVh2SGFUMG1BK2xnZTNxOGRjZ0dsVGhU?=
 =?utf-8?B?SjlZdUI5RzdTdFY4YjJHWkZ0MVYwemk3NU5WeGhURHJVSXdVc3VrSUVDbFNZ?=
 =?utf-8?B?cFBBNTRHbmVLU0JNV1JGZUl3OHJ6MW5BVGhZKzhZRFZqdHhuVHNJYmNKMnNV?=
 =?utf-8?B?azQyQVpIcTB5VHhCTlA0ZmMvcGhHZ3c0djR4Qk45SGFWdjFOT1lvWWkxWDRY?=
 =?utf-8?B?eW9FTmFKc1VodjhaYnFHdnZ5bytqWlplU1g2YTR2MUF5bWdNc2hZWjNleklp?=
 =?utf-8?B?TXhQdm5NNnRaK0VHbi9UMFVFZFZvY1NMVTltZ0tGZGtvVzNlVmlwSHNTYkor?=
 =?utf-8?B?VEtFZVFaWm9xTTRYK0ZYQUE4Yno2TzVWdW1zaEJrbkhBbnZHYTQyQWVqRmFh?=
 =?utf-8?B?M0s5N2ZOSGxYM0FNZDN4dVdHZGdseldRdGZ0VnQvVFVZbmFid01LRFVwZzk4?=
 =?utf-8?B?cEhXRTZkMnhMRWt6a2tCeEdDbHRaVkhFbkszb29OdmxSc3JrZ1BqMXFtZEhB?=
 =?utf-8?B?NDZlL1V2a05OeEI1eGwySlhyTkl4ZVAwSVM0dkxDZ2dtZlljWEhmZEZEZXhV?=
 =?utf-8?B?ZzhmYzBWblhvUnNpRnNIbzUwR2FvY1pxN05mNElyVGVXMWMzT1VEbmVPYXVj?=
 =?utf-8?B?Y09NOHFmSmVIcnJEbSt4bk5RNUxuTE1wWGc5OHpVMjdTWGkzWUNKYndrN2g3?=
 =?utf-8?B?QkVkMUlrKzQ2QktnS1JJNWNKakI2YnJEUytUYjVhMFNZQkh5THJFY2JqMzRF?=
 =?utf-8?B?cW5oU1dhZEJUVFFiL3gvMkxmbHNOdmFEdEVKSHVQd296SWhLb1BSMDNZejc4?=
 =?utf-8?B?UHpPOG45T0RkUXpRcXJsUC9xMzNMOXlsNzVHc2o5NE4xM2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.12; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:atlvpn-bp.amd.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 10:11:47.0761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e174eea-d53a-41a5-7eba-08dd07b9692f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.12];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6451
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
2.17.1

