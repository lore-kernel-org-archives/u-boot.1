Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F7FCF855C
	for <u-boot@archiver.kernel.org>; Thu,  3 Oct 2024 06:29:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E048889224;
	Thu,  3 Oct 2024 08:29:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p0rnhjpR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D19EB891FB; Thu,  3 Oct 2024 08:29:10 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7ea9::60c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8918989187
 for <u-boot@lists.denx.de>; Thu,  3 Oct 2024 08:29:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=meU+/A9IZg566VVtGtZt0WPs1OKMDaS/SHklrBdZBR/xm3VaCPL0W0XTHRYxwDNtIDASSwyVz4HNUEg8HmY9U3USAKM84Sf45uL41tdgk3PWyy4rFWbPVJ3yhgWRQSHjynqEu2TAMCIGWtQNlvylJm2+KfW3/Ef+JnqiAkXcZb8iUePtF/6/sq7J2FrqHFRLbYXHuIXt+TDrK1S+qCp0qoJbYEsuP//+edbebXn5QPBd9woPNHtBTXlRBFMwq7hzf5rT9ylYVvb8l55lDH3wDkGAipTzLeDxA4GiktyMc+IbMA3YBGqezJxCMprPvzsmJbkb0E0IvTEJIZhvCQwL3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jEqQwQjiu6Vmg+e6PD3ysf3my8Gtcj9bcDR/c3mFug=;
 b=G1kZaNV7nuHsKRut0I82bJI0nWmgpkB6G0ewPISBTTRT/3girkdrSWnxk0rXp1hQz73IdPo7DqCzIsOV0wWyLwHwSEPqutkaFlgIF4xU0urGCJyM1JKEjIRqIIBmtOgx+KaDEjPlHvVoroHdDnXuhk0OsMfXXfLVgMXSJ1AKOJp51uBGaQIfPuERCPgG4lT3CnzxIZh9X70CC1GlD70UQ9aNxsufhhRGhOFrMtsOJ8rxzfR98vUCMhOdzxngFr6lXWLkBYtDMJL2FfWHtXPmYzWwc+k+p4YKFKZ81h0MSSclNrEOjPEfasWvUwaZ8U4QzyjiJyG6O6m3becKEiIoqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jEqQwQjiu6Vmg+e6PD3ysf3my8Gtcj9bcDR/c3mFug=;
 b=p0rnhjpRpq4BQxUObY0NOl62vOi3tfG7/zTYJL2587lUCTVrxvFxI3Y68nlvkjIBvfHmpJSgO+GN5pME/q/Ps8SBMZwGP43h8nUUegvgLr1kaU/TjlYC0k8mbn+bK8Xj0t/JKpj1b90S/uDlY6juKeYzmlB5neDrVW5DGvcQ+5Q=
Received: from PH7PR02CA0026.namprd02.prod.outlook.com (2603:10b6:510:33d::35)
 by IA0PR12MB8839.namprd12.prod.outlook.com (2603:10b6:208:493::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 06:29:04 +0000
Received: from CY4PEPF0000E9CD.namprd03.prod.outlook.com
 (2603:10b6:510:33d:cafe::be) by PH7PR02CA0026.outlook.office365.com
 (2603:10b6:510:33d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.17 via Frontend
 Transport; Thu, 3 Oct 2024 06:29:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CD.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 06:29:03 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:29:02 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 01:29:01 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Thu, 3 Oct 2024 01:28:59 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v4 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Thu, 3 Oct 2024 11:58:41 +0530
Message-ID: <20241003062844.15338-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
References: <20241003062844.15338-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CD:EE_|IA0PR12MB8839:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdb0d94-881c-4914-2e14-08dce374ad02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?R2JjcEN3anFoa2oxY0F0UzNGZWl0anBXanE0ZkxpZ3hyZHV1ZGxxbXJSVDBU?=
 =?utf-8?B?UTZwemVJV3hlcUtuTGdIWUlkb3JmeHk0dG4rQjZNWnJzMEtld1lsWTF3NTN0?=
 =?utf-8?B?ME5ycVE5SG53Q3hxVFIzOHd6SE1pbmMwbnJFNnJnUVpmZlRieUFqVnBocDN3?=
 =?utf-8?B?UVgrVnRKRFJFclNKNXlJaktJdHZwSWRMRnNuRWpVMlRJRks4MlZGUEVHUDNS?=
 =?utf-8?B?b3hycmJ4YSsyLzFYZGROZzU0eWlWRmwxQ0I5bWhFS1lVRXFmSXIzU0FWNkta?=
 =?utf-8?B?SGRMcE9SSFRucUY4VVV6K0lUck9ZSUVxQ3QrV2c3K1hqL3lZOGlIN1ZtNmJl?=
 =?utf-8?B?UWE5S29sdU1wc0JSbzE5QStTTlEwTlp5VHdZU3pjdWR2MkpOYzlUOXR4RVlM?=
 =?utf-8?B?dlAyaXJXcHZvaHFDY3NtSGlGMjBNN3VSQ0xhZVdrdEttLzZvcnpHZldmdWNI?=
 =?utf-8?B?SUNwMTZ5UjZKdmpWZ1ZRMWJ4b2VsdldUZVlDa0VGT2JIT2g0ZFA0NVlYditX?=
 =?utf-8?B?TkNLNmN2blBxaWVYT1BCc09PcUlMamxGUmlXV1RyR2c1M0ZMTkovS1dPSUI0?=
 =?utf-8?B?YzA1dFM2SktwMFhjQnFKWWxKNThzaUhsSEtNSy9UTnUrZlpoYmFpVTdUY3Z3?=
 =?utf-8?B?UmphZU1jUlVSUHd3TTNOVjlHLysvaGpTblJBenFHclNYa05pK21NVXgzZmRZ?=
 =?utf-8?B?eW1uNTNTK04vTk0vd0drRHdHbjZmekNsZUtpWVJ1aWh0Q3ZKZVJqTStGS0Iw?=
 =?utf-8?B?US9NYStrbncyMjU0MzJRc1lzcE03MmNEQ0JOS09sVGxYdHgzeHJKbHRjSnJY?=
 =?utf-8?B?dHRaZ01uMnNRZHBaT2VKU1g0eUlIY1cvd0lrbXN6QjhQVFdrQjJ4Q2l4NVU0?=
 =?utf-8?B?Y2NyZmZaWEdsTlZCcm56T09LZnllYkVadXVkREpZcHBWaHczUzNFdlNDWGJX?=
 =?utf-8?B?Z3B5d1hjc2dWZ285bThYMmFmUU9XMDI5RnR5MlJqbDJ3SFQyRmpBL0dMaStG?=
 =?utf-8?B?T2JUSDE3ck1qNUNhVEpRSUhacWhmNU1Sbm1WZEY0ck9rVE5EL3lDejNhdEJ6?=
 =?utf-8?B?YTBzVUVGRE5LNDNEUncraW5tQzNQWUQ5VnVFaVkxUzVTZHdIdERLcnZ5emx1?=
 =?utf-8?B?TzlOdGROeFcxTGN1UHAyWkZKcjBETnU1ZUhKM3RjRUt1cFBFcjFRWG14MWtE?=
 =?utf-8?B?Zm0yaEtnMUIwVXhFaHJlNEhhaGF4N2RTbDhDYjc4WS9iSDhranQ5T1lQeE1r?=
 =?utf-8?B?K0I2dlB6S3hDOGJTa1Y3T2dsQXpIOEUvRUZobTFFeXNFL0QxOUdDcVZqeFV1?=
 =?utf-8?B?dU5uR2tlZEh4dHJsUXcra202S1J2R21tOWhZUnJYY3hnVVlTTitLQ2pYUFVG?=
 =?utf-8?B?cWNWaGV2TkE4Y3QwMEtaZXNxbE5RVHAzTFdrQVNIRlA3OWN4S3FhTW9jVzRS?=
 =?utf-8?B?UkRHRFV4YWF1ZTVqcHpEQjYvUU5SMzZKUFVXOXhqNjNWZVFFODdLVXdYd0lj?=
 =?utf-8?B?ZEVPRUxxMHhRMmtDS3IyUkVCYURvV3dIM0lRVW1oWkNYSTlqQjk4T083cUpr?=
 =?utf-8?B?YkhkWXE0QnlTekgxb0J0ODVhNTRJSmUrM3dtR1hKUEdvZFNsQ0ljMCtNMTIx?=
 =?utf-8?B?cnlSd3JadkREWmdFbEZVVFlYeTRCNkVMaDBUajFYazViZUpna2twdFd5Q2Mw?=
 =?utf-8?B?WmRMVU5paWFlS1lXY015V3hTKzlOUW5qcitGcC95dzd0RDRVdEFKVVpmTjY3?=
 =?utf-8?B?emMzc2VhZWJ6dWNLMXRqS0p5dXRoQWZnTTJSUUtUZDdCV3NiaVVuQWVCNWQy?=
 =?utf-8?Q?bFSU/CJSqB0j43+T4mVPKqaXbTI7WsF2pAvjg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 06:29:03.6205 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdb0d94-881c-4914-2e14-08dce374ad02
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9CD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8839
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
 common/usb_onboard_hub.c | 99 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 5caebf8574..94ea01a7b0 100644
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
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
 	struct onboard_hub_data *data =
@@ -61,7 +148,18 @@ static int usb_onboard_hub_probe(struct udevice *dev)
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
+	dm_gpio_set_value(hub->reset_gpio, 0);
+	return ret;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -85,6 +183,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 10000,
 	.power_on_delay_us = 10000,
+	.init = usb5744_i2c_init,
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
-- 
2.17.1

