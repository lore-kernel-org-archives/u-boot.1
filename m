Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52534C25B76
	for <u-boot@archiver.kernel.org>; Wed,  5 Jun 2024 10:03:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF85D8837B;
	Wed,  5 Jun 2024 12:02:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="bZQ2uWiH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 71AB688354; Wed,  5 Jun 2024 12:02:45 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e88::622])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AC454883AA
 for <u-boot@lists.denx.de>; Wed,  5 Jun 2024 12:02:42 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dILykvzt37koilU6WGiPPyUTcqzQw1t0+G2DkzLJiBKx+gCzp08DmMTrzStKj6ZJZeYOeL1y578dWkAn1SEHZPE+LcutffWafb+F5c6tgl27ov40VURGHTqvyg4kdRfqzUgFeqzRsH3IfXHL54AqbCk/coS/h8Yehii8nCo4I0DIofZyQang2byKTgWpSUkpEzmeePxWtzmvPvgfDvHGrzBr2nOvF1y04eIRuJQ71GJZxTRi3Rd1iTQXMOdGOadBdvhlQUyw1S21cBtjGSvaGD4BTiG+CqujjmdkD8yQrdq5NtUNBJkHfnpe7jWGakDj6nhIyPLtWVFPpq3n5Airqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gftsfgkrWpo96nbqqA/pZbx3IAwEvqmr+8ztp2om5v0=;
 b=ixkkVus39iM1czH/YcLIGugHMxAgAzEEtPR0/eKXU7WM0qVzyI3+jUmOY+/7elrXiN4sY+jng44jZ6de7PFKxzzh/aOTKnUOygO8EpZ1uzA3g1CyXMC0t9y0WMSmNgG5dNu0sxyt5uuFfEiSJqe+zHbUoggoh55y68V1g0astmAxXaTfWP26fQdwb2rl61MHNhcm+709XVfAk/EWpWJkV/RsPrldJSNbHda12+UKGRIliRFhbGqSrxoGLUKZE5sR+qgR29bGaJUaobeHiW8k8dfc0FJvRqiRRcd7jUGLhZIfLPCPg5B1+MzMKDDZNaUgJylz72zHmLKF8Frl3Yg7tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gftsfgkrWpo96nbqqA/pZbx3IAwEvqmr+8ztp2om5v0=;
 b=bZQ2uWiHS+sRVm7UO75v43lp7y5zmlwxIHVqnzFVafOOC8YlDS2jVvAQ+nnJC7yo2E8MIN/nJQkUsMPQuhhtAuqk8bDYCIx9Y3W+R5qTAKOeE0gE5fw4xUYI9E8sL3quJY4YWnVF9cgpEPde3RMNcP+9hi6MSrVkg14Na1K4pGA=
Received: from CH0PR03CA0426.namprd03.prod.outlook.com (2603:10b6:610:10e::10)
 by DS0PR12MB9421.namprd12.prod.outlook.com (2603:10b6:8:1a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.26; Wed, 5 Jun
 2024 10:02:39 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::dc) by CH0PR03CA0426.outlook.office365.com
 (2603:10b6:610:10e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 10:02:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:02:39 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:38 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:02:38 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:02:36 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH 4/7] usb: onboard-hub: Add i2c initialization for usb5744 hub
Date: Wed, 5 Jun 2024 15:32:18 +0530
Message-ID: <20240605100221.3571-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
References: <20240605100221.3571-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DS0PR12MB9421:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cb6b20-6785-4b70-b008-08dc8546a22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|376005|82310400017|1800799015|36860700004; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2YyUC9ReU95MEk4N0JvNy8yaHFHVGxNSHdUQThNcmxTWnRlWU9KVUtFSW5w?=
 =?utf-8?B?OXFtS3pSMVVZeW5kdGRFREFoRk9HUmNXOFRWOTdtSVJTQ0JURnB0UDNidElw?=
 =?utf-8?B?Z3MyRFdQZFcwbHZUc0VmaS9wb05vdG1PTzhnaXVValBlOVp6K1ErNytiN1Bn?=
 =?utf-8?B?SE1DbTNWRjAvUnlVcWd0Y3pqOWZjdVo4WTVlZHB1YVllKzRxRE5LT1hRUmlJ?=
 =?utf-8?B?NzVYUXptNnVPRkh6TlNSd0tRTERnUFV3eUVTbVF4WjlTalhtWGd4MHpBNXhZ?=
 =?utf-8?B?eU5DQ2ZaTkt2WWkxUmRmWTZXMnB5SkpUcGlUYlAwMkNRbk03eHNQdm45UXRI?=
 =?utf-8?B?L1VCbnFLUlpuK0s2UkxFa0VMcERlaXpGb1dwUXpqdm1hbzRXdUQwZFhWbzly?=
 =?utf-8?B?VldBTTdSTTZ1d3JyU2JNeFpPdXN2MzZRUUxtUTlSSDc5cHl5SmZVTGlsZzRy?=
 =?utf-8?B?MjZXM3hVYUVyQW05c1dFaCtPT0prZVNWKzk2MTVzSW5KaThkSEZ5SUx3eEJT?=
 =?utf-8?B?emVWcm9TYlAxdmpwRzBkcXM0UlVZbUJjYUxZeFdGc1J2UEpqUlZJajFkMTdN?=
 =?utf-8?B?cG9CdmtCa3ExeTQrRkdOOFQ5dUgvMVY5NzdyMWpoVmF6TUc5VTZ1L3F0eVlD?=
 =?utf-8?B?WXR0emNqTTRtV1V5WWY1QjZhNitheG4yM1h4MWlSSUtxcExMWDd5SzlQZzJr?=
 =?utf-8?B?YWNaOGZ0OThRZHlPams1RGVhMVNqZFBtdG5Md0VOL01SekI2UjNBczJjcjM2?=
 =?utf-8?B?RmhCVUowUEFuU1B0VVU0YmdlZTVxcGNtaUZlS244QWVWRk9ZSDRadFd6NVBn?=
 =?utf-8?B?WnNmMmpEOWM3N3EwYXdmVkU3ZDJHbjQyQkJlTFhFaDRGdVlpZEkyT1NSSmc2?=
 =?utf-8?B?cWE5NmIrOEoyay9UM2VNcEU0WnFobTcvSUhZVWxUMmo0VjA5OFUyYnpMNWZE?=
 =?utf-8?B?K1V3WjlSZUtqTENWcTV6dEY5cGRpZWpaaUZJTmVoYTYrVU9Eb2dlSVN5R2R1?=
 =?utf-8?B?R2lRZFJwUGFVWndUT0c3ZmhQaUd4anBPQ25sL0tacmprRjg0NzZsOWRsaVY0?=
 =?utf-8?B?M0VaNzQ1ekdVWW01WXN6cFIrdFBQNjUzQjBVT1dLNDF6WmFqREJZeEM0TjFS?=
 =?utf-8?B?am5PZEhid2lTZTUrSGl3UWF0dFFpemVDSUtkblVweExzTVZIOEhXNGhJaVJV?=
 =?utf-8?B?d0FNb1djRGJvVjYyWmNGZ2RXQVdrQlBnYUpsSVNmWFN0c0dWUXdFejdSRHVQ?=
 =?utf-8?B?U1ZMbVhOcE0vUmtnWUJHVGxBWTlJU01JVUxuNThIb3ZERWlPeHR6Q3lXbTVB?=
 =?utf-8?B?enk5NWdqSkdqTmY4Ky96c3A3bnlmaHVZZGJJUWZlRGhRSGsxbTZGZlN1NEla?=
 =?utf-8?B?V2FUb3BkSjRhVE83S2t5VHR3ZUZncEtSbkxndENlTjlaUDhoVGI0RDN2Y0JK?=
 =?utf-8?B?UVpuTVZLaS90aXhzdm53UFYzVzUxWWdjWWhsUnQwY1dMUEFzbHVPY3NYOEFF?=
 =?utf-8?B?Y29BM3pvUStYR1lyMUd0QlllT2ZwUFVPcXJQZ1IxZnNNQU9XSFNzazlmWW1O?=
 =?utf-8?B?cEt1T0xFaFF1T0pFZkZZS1U0MThlbVlsc2VVU0tPQWk0VkZCb1Z1NWtqZHFE?=
 =?utf-8?B?Y3krZ3MxVjVUTjhqaGxsNCtSeXNSSXZLb0pSWVZNeGh2dEZlbk0rNWM5YVFF?=
 =?utf-8?B?L1ZkaTBLdnlqaTYybTVEeDZtNmljSkJaRm4yWVRHODl0azNzQUZPbS9OTXhE?=
 =?utf-8?B?L1BqcGx4VDQyTDVnR3RqTU00REwxb3hWdnZlOXlnZXhnQ3RqOXJjb3hCV1Ji?=
 =?utf-8?Q?kZJtb3NOByxIGb5e2yzn9TPzuuOHyik+WKX4s=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(376005)(82310400017)(1800799015)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:02:39.3847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cb6b20-6785-4b70-b008-08dc8546a22e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9421
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
 common/usb_onboard_hub.c | 86 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 50870285995..09ce452af1b 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -11,9 +11,15 @@
 #include <common.h>
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
@@ -21,8 +27,80 @@ struct onboard_hub {
 
 struct onboard_hub_data {
 	unsigned long reset_us;
+	int (*onboard_dev_i2c_init)(struct udevice *dev);
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
+	char data_buf[8] = {0x0, 0x5, 0x0, 0x1, 0x41, 0x1D, 0x08};
+	int ret, slave_addr;
+	u32 buf = USB5744_COMMAND_ATTACH;
+	u32 config_reg_access_buf = USB5744_CONFIG_REG_ACCESS;
+	struct dm_i2c_chip *i2c_chip;
+	struct ofnode_phandle_args phandle;
+	struct udevice *i2c_bus = NULL, *i2c_dev;
+
+	if (!dev_read_phandle_with_args(dev, "i2c-bus", NULL, 0, 0, &phandle)) {
+		ret = device_get_global_by_ofnode(ofnode_get_parent(phandle.node), &i2c_bus);
+		if (ret) {
+			dev_err(dev, "Failed to get i2c node, err: %d\n", ret);
+			return ret;
+		}
+		ret = ofnode_read_u32(phandle.node, "reg", &slave_addr);
+		if (ret)
+			return ret;
+
+		ret = i2c_get_chip(i2c_bus, slave_addr, 1, &i2c_dev);
+		if (ret) {
+			debug("%s: can't find i2c chip device for addr %x\n", __func__,
+			      slave_addr);
+			return ret;
+		}
+
+		i2c_chip = dev_get_parent_plat(i2c_dev);
+		if (i2c_chip) {
+			i2c_chip->flags &= ~DM_I2C_CHIP_WR_ADDRESS;
+			/* SMBus write command */
+			ret = dm_i2c_write(i2c_dev, 0, (uint8_t *)&data_buf, 8);
+			if (ret) {
+				dev_err(dev, "data_buf i2c_write failed, err:%d\n", ret);
+				return ret;
+			}
+
+			/* Configuration register access command */
+			ret = dm_i2c_write(i2c_dev, USB5744_CONFIG_REG_ACCESS_LSB,
+					   (uint8_t *)&config_reg_access_buf, 2);
+			if (ret) {
+				dev_err(dev, "config_reg_access i2c_write failed, err: %d\n", ret);
+				return ret;
+			}
+
+			/* USB Attach with SMBus */
+			ret = dm_i2c_write(i2c_dev, USB5744_COMMAND_ATTACH_LSB, (uint8_t *)&buf, 2);
+			if (ret) {
+				dev_err(dev, "usb_attach i2c_write failed, err: %d\n", ret);
+				return ret;
+			}
+		}
+	}
+	return 0;
+}
+
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
 	struct onboard_hub_data *data =
@@ -63,6 +141,13 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 		udelay(data->reset_us);
 	}
 
+	if (data->onboard_dev_i2c_init) {
+		ret = data->onboard_dev_i2c_init(dev);
+		if (ret) {
+			dev_err(dev, "onboard i2c init failed: %d\n", ret);
+			return ret;
+		}
+	}
 	return 0;
 }
 
@@ -90,6 +175,7 @@ static const struct onboard_hub_data usb2514_data = {
 
 static const struct onboard_hub_data usb5744_data = {
 	.reset_us = 10000,
+	.onboard_dev_i2c_init = usb5744_i2c_init,
 };
 
 static const struct udevice_id usb_onboard_hub_ids[] = {
-- 
2.17.1

