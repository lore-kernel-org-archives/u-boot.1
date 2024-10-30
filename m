Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4007DD74978
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 06:43:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3D2A089216;
	Wed, 30 Oct 2024 07:43:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ZZXqV5tQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B531891FA; Wed, 30 Oct 2024 07:43:43 +0100 (CET)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2062f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2405::62f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 31257891FC
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 07:43:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s+o3FTwpwYV8k5HgQPa1Ya3O41Xp5EHHOX7swaWfJiiulzDvXi58k8mlkl8JtBk0lmKScomrc4rTshLp+Jxp6h+eBZ2+ytWBTAjIxW3XhPUDYGz0UgJ3b9S4y4Pz5dn2a2X86GikWzTsT9ESDjZquoACJQcAqqwfoMRGxDHPLg0+guIHYNqRCpb8VDBxmLTBf/GftYVTO9cbixV9BNER7caF0Ru2SnDokCTHs042FDwij0vi5X7MmNCYx2uHytp9UyHOL6JAeK7f8OP/l2EG6R2tfqxpqpc25UzCbGwVh09gRbLNtItr8pmHkYnlKCY3W/+Q2gsv+qkgEsmYecMCrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kfd2wIuJWtUgP/UrO52WNxqaNQEJ4EtF++9K9riRtU=;
 b=cFD3pK6ZE5LQuRJud3pBz+bCMdNQH5HC7fa5R2d+dFc1G8G8yv6LBKcrMD9gh5dFtIwx4wrmMXBm9Jwi1vXdWR+khA5u/vftaeQ860ExeH+aiB2R+OR6BKFhfQC3bjela4jZTPqvN31EXDSq1MCoMY2LK3gLSvoVYDA6fSEHwqh44D46VYlDxW1826wPwpR8RssnMOhdwwDrr7ZcqScLWOkQICWiPNP4FWo8vukMWudRriGMC9TBDoO6q1e/Z+Q2gejWwGxAQubJKqdpHsjoHosin1NzOVtnku6irVAmLVCRijR/mVJjHJ3bP4ktr4x3sQJqQN714Kn2tkGVwM+xqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kfd2wIuJWtUgP/UrO52WNxqaNQEJ4EtF++9K9riRtU=;
 b=ZZXqV5tQOKAA8/GbVW28xlkEfGaO5B3l+elpem1JtyPoM5aG7en2aV6U0v2yw6x4aeVZ4jM9yWKTNcik0QwFAnpd3S7uX4o7iJLyXQ0mPCKsZ4w4YLhhoKQHVYZZf9ZcehfaXCSMb6RtEmyzxGOhObvQJURlo9/ms0jo5y9d2Yc=
Received: from PH7P220CA0078.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::34)
 by SJ1PR12MB6292.namprd12.prod.outlook.com (2603:10b6:a03:455::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 06:43:33 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::a5) by PH7P220CA0078.outlook.office365.com
 (2603:10b6:510:32c::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Wed, 30 Oct 2024 06:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Wed, 30 Oct 2024 06:43:31 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:31 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 30 Oct
 2024 01:43:30 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 30 Oct 2024 01:43:28 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v9 4/7] usb: onboard-hub: Add i2c initialization for usb5744
 hub
Date: Wed, 30 Oct 2024 12:13:11 +0530
Message-ID: <20241030064314.28604-5-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
References: <20241030064314.28604-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|SJ1PR12MB6292:EE_
X-MS-Office365-Filtering-Correlation-Id: 92606eca-3ea5-420e-66c6-08dcf8ae2ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3hiMDR3TWxJNlVTSHRPRnBTL1JRUzh1b29XM3h1c2hLRHc5VHhKS25vNHhJ?=
 =?utf-8?B?bHVtcU5peXJ6TS9SaHdPQmdGWFhTcTlMbWY5aEF1UzFUd0w1bGVKVzdFUVdj?=
 =?utf-8?B?Z0Y0M1RnSS9UbHl5aWg1amVGNUNzeGgvSlk3QlBaN01FbzlEcmR4TjV6Vndh?=
 =?utf-8?B?TnNxRkRreUdQVHQ0bHQ1MVBJQ3RsTk9BT056Mk5jQ1U1c0QrNWF1YW44eGdH?=
 =?utf-8?B?SzNTS2ZyOVhKTE1MclVMZ3lWb2NXS0xlRWw4RnFNLzlLVS96MmtSTm8xRlhG?=
 =?utf-8?B?ZTlkdUVISC9JeWNFZWcrYW9VbWN0SWZBNDN0Ym0yc1hFQ25tWC91bWRjUjBp?=
 =?utf-8?B?OWVncWhNR3RhaDdwL3NkZzRoYkJZZWRPdGx6c3M4U2Q5eGV3Y2lOM0JLYjJE?=
 =?utf-8?B?WWErZ3IxaUVyMWRlSmZMc0JwNHh4VnhvbTFNTFZsc3JSME1nbDFQTlpJRjJH?=
 =?utf-8?B?NmJ5WFBYd0xPdGdISFNYUENiT290M2llWHFWdkF3K00vQXorRTIwUjg1OUxP?=
 =?utf-8?B?MHNwQ3l2S28zVmpWMG02bytISll3WEUxaTZMeUpHZm1WU3Z0b2xxcUMyMTl3?=
 =?utf-8?B?REpHbzRyMzNId1ZQTWpkYmpmclhJUTd5Wkt5dXJlcHRsNERqS3k3a2w2elQy?=
 =?utf-8?B?aHY5NDhseVJTRzRxNG9qamYwa3dlZjJScS9Qa3FLSmdsam5jK1Y4UWRjRFZj?=
 =?utf-8?B?R05RcDIwMDZ4K29hNnpDUFJobGFIT1h6dERsdnhiQzN6bmFIN0xtUGdaTWhC?=
 =?utf-8?B?aEkwU3locVRrL3YrdFF6bkUxY3ZlYjRVT1ArY0E2ZkoyNHBJeHJGczVYSU0z?=
 =?utf-8?B?czBGSFBPMFBmK3BhWndDekErR0ZEUnpQeDNZSUhOY0tLdTFmejJVQnRQMFBj?=
 =?utf-8?B?TFB2WldGUTVDb1hzZnFqenp4U2xxdzZ6M2hieCtxa05DcWkvU1hkajNjV040?=
 =?utf-8?B?bWhKLzRHVGMzajRtMmYyS3JRL3dzZldpbjd4M2tTTG1LNTFFOGNESktHUHo4?=
 =?utf-8?B?b2FJZ2h5RG9SVkZGU21ESkNDaGtQSUk0eGFsUk1UMVNsWWZ3TjVDRUM2THdo?=
 =?utf-8?B?WjY4bmljSlFTZnY4OGFIV0U2TTROaEpoZ0tsUUxueSt1V0FjZDlneC8yWHFj?=
 =?utf-8?B?bVJXVUFiVjdSaDJNNkR5aCtDcnAvSGtoekJ0bXFaSGxtQzhqbW1rNC9OazVx?=
 =?utf-8?B?VW9kSWZnL2o1ZU9UWVJVbTRqNXdzQ1hCdklSQ0dITlBFMFFVNDlPam9CSEVl?=
 =?utf-8?B?Z1RmS0t2Tk50RzZjaGRpZkJEYys4SlU0bDBOR3dmNWdFVlZKaWkzQmJvR0Q3?=
 =?utf-8?B?OGVsdWFxN2FTT1RLMVFvVDZQMzFON01PbXVKRi80dHZDQjFFMm5Zcy9WRSsx?=
 =?utf-8?B?anltdlgraW0rblFwUmx1V2R5RzNnTlhBT3ZWUEZhV01XMTV3VXRFdC9Ua2Iy?=
 =?utf-8?B?OWhkdTFuRlZWQUhiU2pvUERKWnMvMkluL0xiMzNDeVFveWVUMEl3M0pNbldp?=
 =?utf-8?B?VUdIV25KUnc1Y2U3U0xrZUFsWnppYnVLZVVueU9KMm5jOG9LNlUwa0lRVi9T?=
 =?utf-8?B?ZGc4RVVsd3N1dkorZkg3Rk5kMXBPTWpyL3hXQWFPcGFLR2tqZEFMWG42cTRw?=
 =?utf-8?B?WDV4Z1BBMlV4eGtESXFjdFUyWk0yYmRuNUkyQ2dlN0huc2ZMMEllUUh2Rjg5?=
 =?utf-8?B?R2hvV3BUVHFSN0pCNElqNGVCczMzU0UwL3gxQTZsRGJoM2N3OHFpTnI1UU4x?=
 =?utf-8?B?c2VlWlNaUFdrUEhUNmtFYTBlUUk4SDJNY3pSSjBGeVJmdDh3c2lLMi9aV3NT?=
 =?utf-8?B?a2NCL1hCZDlLSEhPemRhWU8rU2hHa0gwSmUxN1A2b0JEcE5sQWlqZHJucFlN?=
 =?utf-8?B?eWtGbWVWeDdXY0hmQ3RoeDdlSHBsYktJSFcwMGN2OEhKVGc9PQ==?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 06:43:31.9506 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92606eca-3ea5-420e-66c6-08dcf8ae2ba9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6292
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
index fc7953e8bd..1a3569a135 100644
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
@@ -90,6 +193,7 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 }
 
 static const struct onboard_hub_data usb5744_data = {
+	.init = usb5744_i2c_init,
 	.power_on_delay_us = 10000,
 	.reset_us = 10000,
 };
-- 
2.17.1

