Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7785BCEBF65
	for <u-boot@archiver.kernel.org>; Fri, 27 Sep 2024 07:02:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 57199890B4;
	Fri, 27 Sep 2024 09:01:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d+YJvnl5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19F5E89027; Fri, 27 Sep 2024 09:01:53 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::614])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A8F3589092
 for <u-boot@lists.denx.de>; Fri, 27 Sep 2024 09:01:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qMWn3rX8LG1b2Aj/T7EqpmdA4ckyaA2CO6UUqbmKirMxHtpOmc/i7Jr6AjXxVn1RPCCtyPFyS4dUH9gWS+92o7E+NpTQ6+GtDNWjT9qsmLR3auoWCwbGZysoPE7OLT4bvgVZuVKnj881QJfSif+u9sslE6HJIpMJkwPmROAnf/65QN/iB43Fjxbw6ht5Gr9C8Iy4px+Gr1kENm4TgScOvsCRAjNJV0xzUf3THEb4W4Uu4RFbTTKmB7gw2sE2zYSk8YST/7cP9hWqnuIsDNjluTg/jR2SPMKpeTVvfpembRZ80yh0ZU1dpzB4KO0q/o69ZIXsLx9PUUKaT65a7xsuZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PZPFR+a/0TKWOd77ObRYNSpEGmbiSjBCZbGeumsQoas=;
 b=yAgg4/7NS8IIRKugZvoEFjfIjNRakfnnMHza4J/84h+ZFxFtJjHbfIp9wHtGwezxK0/3rnbxG6rJCvfApFQKzIWFMJIY1rh/7haf/aHjtWW2GSdqDAovsCJZKYaB5p31ITjCkKnCIOghsbebAoAtg5UOq1+pyhIB6eGrLeNEE74XMeeveFcMFaqLVLMlqycw87ROMJKbckOUDchTFYAdgWXIbs81TYyilawt3XPQpLxT6HUXOVIgi7icht2+QgQqpq5xabe2/yQHiRLBxVHeSsnkubexhz3hcZeBe+1L6gfhbdXNX5M+DUeXIvPcoUMLQ0eIrAomzUt/qnMcVwbj1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZPFR+a/0TKWOd77ObRYNSpEGmbiSjBCZbGeumsQoas=;
 b=d+YJvnl5uMiVTmBp+M2p7Jd8YcouRuX/m0jczY9vhFtVwMW29QLrsDM3KJLOTPPFVxzj7Ds40PhajUGm1mPxnBJXui7tNSbQRA1b7l3u8Gk3Hv7q8fbpvrYNKLgGfftLptpDXxddMh6elg2+kpk63QY6lSDM2TtaXAU+6HIUhgM=
Received: from CH2PR12CA0020.namprd12.prod.outlook.com (2603:10b6:610:57::30)
 by LV3PR12MB9234.namprd12.prod.outlook.com (2603:10b6:408:1a0::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.22; Fri, 27 Sep
 2024 07:01:45 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::32) by CH2PR12CA0020.outlook.office365.com
 (2603:10b6:610:57::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Fri, 27 Sep 2024 07:01:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Fri, 27 Sep 2024 07:01:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:44 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 27 Sep
 2024 02:01:42 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Fri, 27 Sep 2024 02:01:41 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v2 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Fri, 27 Sep 2024 12:31:34 +0530
Message-ID: <20240927070137.21816-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
References: <20240927070137.21816-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|LV3PR12MB9234:EE_
X-MS-Office365-Filtering-Correlation-Id: 29dadc7d-1f54-412d-d98b-08dcdec23f57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QWJlTVBEMnNxSXdpdHhMK3JaWHk1K2pvaTRReDMwcGhVRG9HVjFUak04K2xV?=
 =?utf-8?B?MUJDaGFPem1OcUdVVlZvY0NYcjYyUVNmNGQ3TlVGL3dEaDF1d2xMM0NmUFdu?=
 =?utf-8?B?WEtOZER3TmFzdWR1ZGg0QWhDZzhKcUVscFFpOEZZbkpZUEFPVlE3cUVkS2lw?=
 =?utf-8?B?K3hzQmFGbmlLUkNZeS85VkNYTTFsU0tHMm9seWluSS80TmQ5ZVVlOHd3d0J6?=
 =?utf-8?B?UXlwMjNMU0YvbE1DU2lQdHZPREpnM1RxOWQ1eEprOVRwekkxZnp1eituZ2pp?=
 =?utf-8?B?NUU5NzltUUV4dW5NaGRKRGpsNXpBVlRreHRBSXA3VGFlaGVTWlN1WTFXZThV?=
 =?utf-8?B?dGE5NCtVODFBRVV4a3BTcXBJa3g0N2hGL3JkME9nSHFxMTFtc0hYVE0zbmQ0?=
 =?utf-8?B?c3VaTnh4cjJUdFprVExtblhrVU5VdEl1RUhRazdMTVNBalJyS0RGQjVGaXNC?=
 =?utf-8?B?TE5TOVVWcGprbG9uU2ptdzE1NDhVVEFzU1pmSE1odlY3QXA0TW5hYy9sNi9r?=
 =?utf-8?B?WWVScGdKUUtXU0VVbXJQWGVONFdVUlVnT1lEY09QdVBWSGVRV0YyOEExQnBL?=
 =?utf-8?B?WW9jVmQzTnUyWVFocGNRS0Z4K0NUSzFuWVJoNmJIQXEvSUxRY2NkV2lINW1D?=
 =?utf-8?B?UlFqQkNhdFVGa0dZV3ZKekg2cEhUV3FwdU1WUmpSZ3lvclhDVHdtNGNJS1lr?=
 =?utf-8?B?eTIxUENWTFk5VUYvYkRJUEJiZFdoeitZSkRyck5MMGRwclY1MHVYc1ZSTlIz?=
 =?utf-8?B?T0lDUTV1cVNQMThGbU5YeDY4SlVYOTVZNkErS1BpaElldUc5dEw5VzZId0xN?=
 =?utf-8?B?SE51Y1RTdkZ0bGduTVh4UFNubkRDYUkrTlRFaTgvQlJkMVRwOHVyZlJadldj?=
 =?utf-8?B?RjNsWFlkRFNCNlZ0U0R3UkM5aHA2VHpnMEd2ZFZDanJiWnZ1ZlN3MnBYelcw?=
 =?utf-8?B?NDZKUWJJd1MzTVRFU3dPb09oa3Ftd1pPMUIydkNyQzV4SlZXd3kxL2FQWXlL?=
 =?utf-8?B?MzBXc1cvak8yYWI0T1lRQkc3NmpiQmwvdzE0cEdMSkxhSEZWSkpiUmpFZHE5?=
 =?utf-8?B?U1JKVE5YRjg3QTk3TTZqdlpJZWJYNzh4QzB5QWdQVkVYemxlTzN1YjFqck14?=
 =?utf-8?B?QmdpeXpnK1RPZHNpZHlQVzFVMVhPVU44SHZTdDcwQXFFcE8zcGpsb0J5QTlt?=
 =?utf-8?B?WEdiTkE5U3ZaY1JQMzdPN3Fxbmh6T3NWWUNwTkptelBtWkVPR1djQ0t4WkRC?=
 =?utf-8?B?S3gveTI5b2hXdkhJcHVMcDE0ZFIwVzJqNlhPZTl5ZEJGMndIQUl5R1pzYkhF?=
 =?utf-8?B?T3BZUUU2TkJNUjRaQ0tubEFOSnpBYlpSQzRBZXAyOUJEbWswVG0vK1ZxL1Fw?=
 =?utf-8?B?alFIZkhZSnpCLzdSbGZUdGxYVmU4WFJtREFaaWNVNTNPSkQ0c3FlczhXMk13?=
 =?utf-8?B?ZUJrU0pmVFAzN0pid0tZYlllcjhLN01OSS9TSHlreGN0dnprejU4NmQrV1Y4?=
 =?utf-8?B?MUVkbGRoNkZDQTZxNmVaK3BvTElaR2dnQ25rMG04NUNiSjUveUlGR052RytW?=
 =?utf-8?B?K0dNTW55MG1maWx0UUhiZGh2NFFTaW1Pbm9vUnN3T1JLNktsa0g1b0xTOERM?=
 =?utf-8?B?bmhGRjhmYUNYY3E0cGZYbWI0cExGNGJuUmhWaHBvTW9DeHBRWFdobWhwMTZm?=
 =?utf-8?B?amFURUI0clBkcllwZDRtNDg2cGt4bFcwbHV6UTVEZ3Y4OVVCSzJBMFUrSUdY?=
 =?utf-8?B?K2RJVk8rZGVEK1JWbjdRVmlYWXRGUVk0SVhaaDdQQ01PcGE5c01QVmEvZmlN?=
 =?utf-8?B?Um92VldrbVZOOU9BTlVtMFBtVWZnS0pFWGNWU0RtYndmSkFoZmlDTnEzWEd0?=
 =?utf-8?B?OG50SmovMEF0M1Y2b3k5S3NibkhmT0c2K1R1cUtaK0xmMldRNjI2akJSa21y?=
 =?utf-8?Q?K9t40C56OJZDTnpTbpXLPAE7IBXKlMHC?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2024 07:01:44.6730 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29dadc7d-1f54-412d-d98b-08dcdec23f57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9234
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
index 8319144d10..00808ed45e 100644
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
@@ -21,8 +27,86 @@ struct onboard_hub {
 struct onboard_hub_data {
 	unsigned long reset_us;
 	unsigned long power_on_delay_us;
+	int (*i2c_init)(struct udevice *dev);
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
+	int ret, slave_addr;
+	u8 buf = USB5744_COMMAND_ATTACH;
+	u8 config_reg_access_buf = USB5744_CONFIG_REG_ACCESS;
+	struct dm_i2c_chip *i2c_chip;
+	struct ofnode_phandle_args phandle;
+	struct udevice *i2c_bus = NULL, *i2c_dev;
+
+	if (dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle)) {
+		dev_err(dev, "i2c-bus not specified\n");
+		return -ENOENT;
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
+	if (!i2c_chip)
+		return 0;
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
+			   (uint8_t *)&config_reg_access_buf, 2);
+	if (ret) {
+		dev_err(dev, "config_reg_access i2c_write failed, err: %d\n", ret);
+		return ret;
+	}
+
+	/* USB Attach with SMBus */
+	ret = dm_i2c_write(i2c_dev, USB5744_COMMAND_ATTACH_LSB, (uint8_t *)&buf, 2);
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
@@ -61,7 +145,21 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 		udelay(data->power_on_delay_us);
 	}
 
+	if (data->i2c_init) {
+		ret = data->i2c_init(dev);
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
@@ -85,6 +183,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 10000,
 	.power_on_delay_us = 10000,
+	.i2c_init = usb5744_i2c_init,
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
-- 
2.17.1

