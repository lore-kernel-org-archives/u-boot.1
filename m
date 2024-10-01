Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D90CEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:15:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8D9389114;
	Tue,  1 Oct 2024 07:15:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fla0Zrpi";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0CC289114; Tue,  1 Oct 2024 07:15:01 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20610.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::610])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D00A989125
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:14:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXrblHq/idGdvQmGndH+dT8oAjZ34WX14WTYAEZDCG+R54O2y38BAeJklphr3ml4UrrtTZ25d4gdwLG1QOmqNgE5JU43a3Aeodxx/mWzHgjnDwt47q55Vk2uCtrhAIze7f5TZcA4xDxp9KpPpDGGwCAUiW0ko/mU7bTeWG+omtMSlRr02INHanjnh57qpfKI42oppJBi5ND68sZuQBLTko2442EL+g+q5SzvDGr0fwEUm7SJN1QBsw0GDauj7UEYzwggW1C2yeV+9nnwf8t1NmZGiot2tGQdpc/6SKYDqhX1yHasCaEC2oCK1niKSj765COpB8kiLL/S+mFXRbciwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GuPUAvtRHBBWLSNJ85b2t4rsWc5+019Tfz/5DyGcUgg=;
 b=wkRJXkEbiZ9QutIOkjnF2V2NQOw89k5kV2uEKcCMtSfb8FWEbgLz8uStxepR4clnaS6I6s6bvYxLupMx/dVnhN+IQFGReU2dM9/uvF0lLqy5/sgswXSE/jnBuUMxRY92/aM2GfvxMvAjDeZdz1SylbhFSBdyczPg0I5EhT8B4osdifS5kCMxT7AVBxRXqG2L2nOkL1nr8/1JVHtf9PlwCOGXVxG8g0/kfqrkDjYHgxYDxB4f3PhqOSvY2HeFLiNi2U+Fpz1+RzBYwjtfhee3OxVQABM3ARyNG8+99kZgFBMrzPTEHIer99eZ+9hZ2T2i24woZGckkS1XkTUJPWVi0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GuPUAvtRHBBWLSNJ85b2t4rsWc5+019Tfz/5DyGcUgg=;
 b=fla0ZrpiD7u5lxOIUxHholq7V3wIROTJSpx9Vc4AhKJxghoP6JIOhIjGGtjh0cA0Ek4Z5yQTOv/5+24Acm8W29MCl0e82Ix1p0A+iNVw3SgBKuhGtEKK+qjBMIa0dj7GaKZsuyDY1wH2t9/cDt8RTtHmwy7pj/Oz5FbbhGkUnUA=
Received: from BL0PR02CA0010.namprd02.prod.outlook.com (2603:10b6:207:3c::23)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Tue, 1 Oct
 2024 05:14:54 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:207:3c:cafe::2e) by BL0PR02CA0010.outlook.office365.com
 (2603:10b6:207:3c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 05:14:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.2 via Frontend Transport; Tue, 1 Oct 2024 05:14:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:13:05 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:13:03 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Tue, 1 Oct 2024 10:35:26 +0530
Message-ID: <20241001050529.17922-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be791f4-90f8-4a0a-3c44-08dce1d7fbbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RUhsa2c2ZUhOSm1SbHloY3ArRmRmSnd5c3lWU2JqcmdPb1V2SlRHNmp4VVBX?=
 =?utf-8?B?VHZIdTJ3NjRlNEpkMnZsUlpiQ1FqL1UzdlZmNEVtbzg0U1Z4TG5iYk1OVTlW?=
 =?utf-8?B?bWRRc0tHQjZ4cTFFcUg0RGZiU1RzMHRaVVFXdGxJNzFrYmZqakJUTUE3TktY?=
 =?utf-8?B?TGxuVHFpNzc0U0FoU0FpVVAyMyt1UnJxaVFCMWZhRnhza2RaUjVUSVY4Y1pZ?=
 =?utf-8?B?bGoxZnliSGpmclc2Y0FKSFp3dSsyTURwY01MbEMxVG8vQkpzZXZzSitVWlF1?=
 =?utf-8?B?aW5iKytLMCtPcDlaRW1xcmE4Z1BMbWJxVE44YWo2NTFLOEQvcFdtU0wxQWxl?=
 =?utf-8?B?VDJYalVIVllDeDlUallZWk9GeVY2OGZxK1gveElDbENkbDQxMG1KajY3REZJ?=
 =?utf-8?B?YllhR25NN1pqNkpUUThiZ3Y3dERNdWFqVHJxU2p5aWw5LzM5dFJidmtYY2la?=
 =?utf-8?B?cFNKSkRFS0pmSjdtdTlLYXpKd1hhQ0NtM3gxZy9ZQ1hPSVFrVXVIT3FvWEh5?=
 =?utf-8?B?bkczWWhyd1J5TlpHbDlQUkNIMktoNCsvMEdEWnRCblNEbmVLR09kTi9SdWl0?=
 =?utf-8?B?TXJhemlJMkxEajB3cmZKTzBpVVdEQ0RRcVBlemh4c0NtTC9NaC9sY0pCOVA4?=
 =?utf-8?B?L256K3czZU83OVk4d0czV3RGRWR1RHJCdklrUGJwaVB6R0NYdU1Oa0JwRGVH?=
 =?utf-8?B?S1R6OVZkeFpPT1UwTFF3bHByVWZxRzU3TmQvVDFBbzhPNFdFbGFDdlZZdjhY?=
 =?utf-8?B?ZkZ2UmcwZ29OZUJuTTQ4d1VRcElwa2ZiY2lSM3dJZE0yRjRHWGtyV29SS2Jm?=
 =?utf-8?B?WkFwM0hZRVUzRUtiNGZ6L3c3SzJhYmVleklPb2xXbnNTTFJLUUIvWEg2dXBZ?=
 =?utf-8?B?YmdiK2lyem45SVU4MVYrZURSak50dWpRRlVPMHFMaHhTYXR2ZWpsZHMwNjdW?=
 =?utf-8?B?ZS9CdmJhdVpQYkFYMHV6Yi9IUFRRVHNHdDJuZzFFSlE4OUxwWUhrQXVNNXdH?=
 =?utf-8?B?TzNlT1lxLzUvK01SVmc2bDQ4Wkl2b1BvVDlqTUtxSHRyYlZJMllyUGJ2dXNM?=
 =?utf-8?B?TW1rcDl5WS9HT21IR0dORGc3Zzc0TkFSWk0zek02VE02TkxBcTBDUSt3eEgy?=
 =?utf-8?B?U0FSajRTNUxzRXJ4TDdRUTR6cHZVTDYrM0ViMDJHV01DbWVKRlJBOVJnTXli?=
 =?utf-8?B?WTFZQWFaSXVVQUo0ektOYkhqSG15Zy9HSTFzN0tseThvL1pKWVJJakFoRVpX?=
 =?utf-8?B?REtjL1ZhV3hETWNlQlI0TWVtRnk4bFhpNHpJUGh0SDVPbjRpa1V0T25Fd0RS?=
 =?utf-8?B?SUhFV3pJV0huaVlTdkhxUTVDWUY1eXlCOXVZZElhZVk3ZzVJalZMeTZxV0VX?=
 =?utf-8?B?ak9IeXU2ZVNOVFgyOEVTbzdnNDJxN0dRYXE1QTJiM0FiQ1k5YzFUSHZKbnNG?=
 =?utf-8?B?bFlHdEZrb0ZQVmUwaGhuQmhYK1NLMUxOeURudDdrbFY0NDdFL0t5blhLS2VT?=
 =?utf-8?B?cTJWZ3gxa2dBMzAvb2ZRMmdjb3VUYkkwTm9qRm1DRkVNb29CRVowL3JlV3B2?=
 =?utf-8?B?WVJuYkFIZkhsdW5Tem1YV09CMEpGSktCY3hIZ0oxT2pHZElYS2RFUmg3TDh3?=
 =?utf-8?B?OEE4VldWTnhsb3p2TndPWC9ZN1BFNzFMMDFhOHdIb1FLYzNGSHY1SnZONzRI?=
 =?utf-8?B?TWpCZmxlcWc0SU5YYmg5dG5yVkVDTW1NbkxDOUJoeXVwYWoxUnpUUldhdUhm?=
 =?utf-8?B?dzdEYm9vV1RaSy95NTdmMlgvTG1OdW1mUVlCS2JiMTFmd3ZTeGZNRWZXSGRp?=
 =?utf-8?Q?4/o0h0xrmmXQZ/mKWJK9lhX5QpqTHIan8LROo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:14:53.6843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be791f4-90f8-4a0a-3c44-08dce1d7fbbd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146
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
 common/usb_onboard_hub.c | 102 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 102 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 8319144d10..f5012ebfbe 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -10,9 +10,15 @@
 #include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <i2c.h>
 #include <linux/delay.h>
 #include <power/regulator.h>
 
+#define USB5744_COMMAND_ATTACH        0x0056
+#define USB5744_COMMAND_ATTACH_LSB    0xAA
+#define USB5744_CONFIG_REG_ACCESS     0x0037
+#define USB5744_CONFIG_REG_ACCESS_LSB 0x99
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
+	u8 buf = USB5744_COMMAND_ATTACH;
+	u8 config_reg_access_buf = USB5744_CONFIG_REG_ACCESS;
+	int ret, slave_addr;
+	struct dm_i2c_chip *i2c_chip;
+	struct ofnode_phandle_args phandle;
+	struct udevice *i2c_bus = NULL, *i2c_dev;
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
+		dev_dbg(dev, "%s: can't find i2c chip device for addr %x\n", __func__,
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
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
 	struct onboard_hub_data *data =
@@ -61,7 +148,21 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 		udelay(data->power_on_delay_us);
 	}
 
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
+	ret = dm_gpio_set_value(hub->reset_gpio, 0);
+	if (ret)
+		return ret;
+
+	return ret;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -85,6 +186,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 10000,
 	.power_on_delay_us = 10000,
+	.init = usb5744_i2c_init,
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
-- 
2.17.1

