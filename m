Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1CE7D41D6F
	for <u-boot@archiver.kernel.org>; Tue, 12 Nov 2024 08:51:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3723C89456;
	Tue, 12 Nov 2024 09:51:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="225ffzHh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4099B89462; Tue, 12 Nov 2024 09:51:00 +0100 (CET)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 08A998931D
 for <u-boot@lists.denx.de>; Tue, 12 Nov 2024 09:50:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KTPNK6Ojhqs5mDK9QoUExCSb6hOIYPEPoA/AOzzz4oWBH5QqnonpIzBID8FH3nJOhCgrDQSMGadWmQxnmNDQZxtubD5VCj0YSdrLDiiMxPoIN9tcXcUex0ONP0SYzJnj6ZpJrjK0kGiYOVeMbZ/RpPlDYvITTqaKRul8nEyXxfuMh1nELIc2m+3pS45N0i/2Bo09TbVL2BKcLGx5gCDlyJDnPdi9LWm4DW5A5GpZlcpAHtv+SrDu8CiqDZjsb1OvLJzq+xMN7As3Xr2bRRmhSgMmVXi2nO1XSyatZp4dxfV9bx3Tm7ImRH2aPLmJttxhKgAtX62sl0+plyDZntdyMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DU6LzH91coOTK6Axh7kThDHPALhSJlL406gTpAkjXwM=;
 b=xUu6ZFvuXGHSATqcYTWQWSuGk4ioJA1eItIdXWfRHdDSTWjAuiIbQ2l/opfGkWPQqUeGVFYO5PIdpLnUEREeBNxROuZdNaoe6qQgcTqtYKx3SkwddJnNCTd7i//h1K1XJ6+LizfY0/QMJh0ZqiNZQ2vQqatouHcQJwThKQ8bOldZrgulyW7xz/6oARpusIxJxeUbn1/qyNiMSowx+XW0NLe+EpDc5Bd06I3YrL+UcqeUTqLSWXhj5fkVDGJp8FtRgY3+J6Wk6LvNACszTDxFwO4/BjgZxZXSVFeXeAlKelVcB8T9bzYgyPXG55jf0mHsKw2DGJ3F2s6T3hwp8+IW0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DU6LzH91coOTK6Axh7kThDHPALhSJlL406gTpAkjXwM=;
 b=225ffzHh6BAS0Ey9o9pgQJu+5CB5V/bOiV23/P1eUAkjsyY0Y8p7Zt71v5n0kR0X6ViusIgizYe9ILagyUdPwgQo7bNG0aL/+45JbIvBuOcFYcaSZ6f0eDmh90kJU57OSwTjm3oTAPC1WesgKeUP6g10SvYHfmluY1Td0m5M5zg=
Received: from BL1PR13CA0075.namprd13.prod.outlook.com (2603:10b6:208:2b8::20)
 by SJ2PR12MB8832.namprd12.prod.outlook.com (2603:10b6:a03:4d0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Tue, 12 Nov
 2024 08:50:52 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::26) by BL1PR13CA0075.outlook.office365.com
 (2603:10b6:208:2b8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Tue, 12 Nov 2024 08:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Tue, 12 Nov 2024 08:50:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 12 Nov
 2024 02:50:43 -0600
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 12 Nov 2024 02:50:42 -0600
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v12 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Tue, 12 Nov 2024 14:20:24 +0530
Message-ID: <20241112085027.21352-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
References: <20241112085027.21352-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|SJ2PR12MB8832:EE_
X-MS-Office365-Filtering-Correlation-Id: a367e6cd-5017-4cda-00f7-08dd02f71cae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TzlrUFZYWm9vTzJXVjBrMVlFMHlFbFlOR0VNby9pTFdVWGhDdWdRandRZitM?=
 =?utf-8?B?bjBiNEF0QzYvdFoxaVYrK2ZLWnpQQy9UZGw2T0tMNk81SEdwQ25vdGkxTmJo?=
 =?utf-8?B?RGl3REY2YTlkRzVkTytYalB5M0k1ekUyTHVWRkdPWmRjNkRHSWRFUzZ3TlJB?=
 =?utf-8?B?bmpENWRMQW9ybFZWc015ZDh3RlJPODVFNms0WHJZeFd6THhmdHhrbmlkSGlM?=
 =?utf-8?B?Wkw2Q21VZkV1SDFMSHhSTVlWOWh5YXp6VEdaWjdvaUtoT1FNSkdvRDRZWnQw?=
 =?utf-8?B?SHFlY3Mxb29jTnN0NDVLbm5MazY2VGp2eXdRUW12UjNtK3hSeWtXeVJnS21z?=
 =?utf-8?B?cURnRTdHM1FvazBwbVpKTFBoOW5MTUhlR21OUzVmY2M4dTd1VFN6YWdkaVRy?=
 =?utf-8?B?b3FYYnF5MU1oemJmdHcxUWNoa2xUT1Jld3U4aytwNCtuMWpSZHRtZTFIajBC?=
 =?utf-8?B?NFlaMk94YmplVFZYOVBzTktaKzgyUmZsMEtIOWhvU0Y0NDJEcXRCcENyTTYz?=
 =?utf-8?B?QitqNjkrY2R6NUEvbHorK2VVN3ZrSG80RGcwU0VlTWhzeW5FNXB2ZzBSOTEx?=
 =?utf-8?B?WDd0ZXRrU1lDcUZMVDBqUXZCZFdxdEx3ak1mRFFheC9FL2U5dlFJVWtPUjBt?=
 =?utf-8?B?aHNVbitFWGN3TzB2NzNmdXE2MStWM1Nqc25hUzRUdkppK0NEUytPckFkTmk2?=
 =?utf-8?B?b2gvazI5cjRUamtyK01kNTI1NTBBOW1Ydm42NkpJZUJYNzNjbEdJelU0VDlP?=
 =?utf-8?B?djJrSUZ6Vk9ReUF5cm9VcEhCQnBxckdtYm5FVlgrN3RKY2FObC9XK0d6UCty?=
 =?utf-8?B?V3VSL3F5Y1VRRHdOYm0rb0diL0VET0w5VGR3ZXpSSVlJTUF3NXc1RUVVZzRn?=
 =?utf-8?B?Y0V0WXluQ2ExUXJ6a0I1RktTRktwODk5VjU4QnlReER6d0d2cXJsL21QYmhF?=
 =?utf-8?B?bjlrc0g5dHlOVW9jSE4zQnRLTDJha1Q1NjVaYWZnYTVuM0N2S3B3V0VOcktN?=
 =?utf-8?B?ZHl2NXVuMjlOSWpqNVR2RXlHSXNLSkRLWUFzSlVrRnRnZG1hdUtsR1I1aWo5?=
 =?utf-8?B?ZmJUanlMdzlIZlhXTktYTjZyQ3lmODNSN1p2eE96OGtUbjhON0RxTG1ScVdn?=
 =?utf-8?B?b0lOc2xCbU1hRWRFT25hNmVyanlrZFhIMjdsNTArSXFiUTJ3d2EvRXFkZkpW?=
 =?utf-8?B?ODYrakFIcXFzbENuZGpVYVJYRUY3YU51eDFFQURqVUpQMksrNzI3d2NpWWlo?=
 =?utf-8?B?V0ZwMnlybmJLM0RSOTZUdjA4N0xXRk1Dd3hwem9KVzJMd3JmUDBWSGp6WWlu?=
 =?utf-8?B?MUxvUnAwa0MxZnhCZHVhUW44a0VhWlQ2dlVQMVI5K2hta2YyZkEycWV3ekpJ?=
 =?utf-8?B?L2hXMEV6dHc3Qm9yazBaYWtvSWlGL3pydzNGRUc3dGtzVzRkalBtdWpKNlo3?=
 =?utf-8?B?bjNkWXRId3hFa201L1g1MWxWQVZNUVpiYkVKL2Z2cTJHNS9nNXhkQURNR0VH?=
 =?utf-8?B?bE4vYVdJMm9ldjJpNkxtMGhXak12ZWpHU1ViQ2hFbTdpRElZVWgyNnJnSDVD?=
 =?utf-8?B?TkZ6ZWFlTVp3UDRHVU1QcyttRy9YWDN4Vk43WkNZUEFpUVJVaUJDRjRoWktr?=
 =?utf-8?B?MC92S2lIUlZSWi9nakZLNVFiWFgwc1JmbWQzcFRHRzNHbzRDMy9yaHpmcms1?=
 =?utf-8?B?TS9oaitrSFdkeFlPN0EyeVZNNjA0OEdVZnB6MDRVWWZRemFjWUowTzhMaDIr?=
 =?utf-8?B?RlQ3R0srYWtqRWpkVld0T0NBQ0Z0ZjhNUVVtM09MWGk4ekU4bDdGL25Xa2c3?=
 =?utf-8?B?TGNRT1AvdVlJSHZhcGZlQnY1VTJybnRoZEVyRjZJZWh1L09aTWdFWXd3R3RO?=
 =?utf-8?B?SDZOcWgyazRwYjVPbVY5MjZHKytSQlpRMHlGeENBMlBrY2c9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 08:50:51.7196 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a367e6cd-5017-4cda-00f7-08dd02f71cae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8832
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
index 83f37d2fc5..c01cafdfe2 100644
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
 	.power_on_delay_us = 10000,
 	.reset_us = 10000,
 };
-- 
2.17.1

