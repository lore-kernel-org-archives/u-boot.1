Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7C6CEB2FE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 05:13:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F30EF890FD;
	Tue,  1 Oct 2024 07:13:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jhKBsRXL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 437468910D; Tue,  1 Oct 2024 07:13:02 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2416::62a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1962688CBD
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 07:13:00 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrhHoreCW2CK62oz0bEt+C72/aktdswzn3wzHrga5qPi8+TX9LWNBTrd8eV5kquFVGSypzcl1ZVb9hQRiT3sGQd4qctNKQfXOGSj++gJVur9BvVE+nOkJGU+xLU5z/pqOuT0GvowOK4gr3xpEvPz2UXU92S3dJl2CCo/GVbBluFKA/bvAM0WlAKUcNvFhTpx0w/jaeA9B7kOrDJvTM3kos8McGgpiaVGjaA1k3istoHPnEh/1T9ygUE9I1Nkz7KljBNl+/brskqXjm0YUF3netObqXKENkxWOlSVYpsZFVuAED2lc/oy109JHwPEBvdKpQnvm3VX/RAECMo5Nycs5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hl54GhIgD39uolGAVeCkn4WngOJsurBYgOirGM98zTY=;
 b=apYnYC+CqHGQKLR9WqVmTInoRLYBn9pqzo9IF81dYJGFIEd3/CWjl5GJQBwzpA2acAijGeSRekD1M9Dn3ys+f1OhuvctXfABSd6UE21lnJHI2SBd658rneN2JYOq52fNhGWOY7W+BTw3vlJIiUa5gh9wltFMsiUkDxA/7Pwif1miBux601xBmxh6GnIEi5F6rMrMBuZxzQsqhURZPw1NXRdRkAoUln62D+oH9tcPOtuaMPn4/d3C5733bIno+dgeg6XnKLb0LZeOlofF8ga7+dtF6Hh3TMchpe2eg8G9ompVVitFj3C9uOKab/xIRWkDybUFZk7BofypTOKwKtWoxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hl54GhIgD39uolGAVeCkn4WngOJsurBYgOirGM98zTY=;
 b=jhKBsRXLi/nmGyq0rofMAjvZL65kdSitgY0d2Njuu7C9ymY1u0BYNRVCmClNNX2kfFRgQ7lYjor6QQAWaYcxmWmrprcjGk4OSz0ETP9HFYYxbxgRtqR8nBJHl7Xy192M7vqmK2RXR7+D3isPGQ9v/yCOHCVayLL9pjwoFJKdqqY=
Received: from BY1P220CA0023.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::11)
 by CH3PR12MB9251.namprd12.prod.outlook.com (2603:10b6:610:1bd::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 05:12:53 +0000
Received: from SJ5PEPF000001D4.namprd05.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::24) by BY1P220CA0023.outlook.office365.com
 (2603:10b6:a03:5c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 05:12:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D4.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 05:12:53 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 1 Oct
 2024 00:07:07 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Tue, 1 Oct 2024 00:07:05 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v3 1/7] usb: onboard-hub: Add reset-gpio support
Date: Tue, 1 Oct 2024 10:35:23 +0530
Message-ID: <20241001050529.17922-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
References: <20241001050529.17922-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D4:EE_|CH3PR12MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 85173de7-a60f-45e9-e8e4-08dce1d7b401
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pwcsReyDehAc1Ym5ZeAM6XRUuxGi64SScp9VASeIpEymZLsnqGf34xsSdZZy?=
 =?us-ascii?Q?U9c1J25B6MetyWecgDnx9HavWzMriB7538n2EdzmYq68Rsdq54WVPHZ/BaL6?=
 =?us-ascii?Q?UwWYs0rjS1/X5KpSc4PrChqtQi/R4LTcgipM2+8Zwzn32yXfGzrDjxjaf2v0?=
 =?us-ascii?Q?CZeJqzVlyA3HnljAC09DO/RSnmh1FaRBbgS+pw7Fui/I2crCamTiWT+emheh?=
 =?us-ascii?Q?Gr/w4H0+uS8J78n6O8MF/QBIv1xqwmCKQbbv9CYVLDICSxPlFz1B9zMyhmvG?=
 =?us-ascii?Q?/YdY4/KMARlJxYyfIFdzcuk8giWA6LVa2vDfYrKPquUVRSACVU7E1rSRbIU/?=
 =?us-ascii?Q?HGGHW5Ecav3QrK3udb/RVTfk5D1YE3B7llhx0OUZ3pNhc0GZm+FR2q06suta?=
 =?us-ascii?Q?dpF9CQTO+4l/AcIjyi5j4hAhgehLdvYoZF76gmIhPURSaejAhy+5gxet8NX7?=
 =?us-ascii?Q?iFP/K0F7mnhgfmaumz7Aw3aEOR7Nk1sIC46XwkSdZ6DDmUEOoAjUI0BTUjJG?=
 =?us-ascii?Q?SW5ofd3DFpgZG4Id/ivlSz+SvR3i8yChiT1sen3UCuVMAKHHdbj7em50WXAQ?=
 =?us-ascii?Q?PBXTvfc5a7ZCVXaa/WWzpBuplMB5g0FDSuEq/VOcJxJxOOpRTk+pN3Hy6QQn?=
 =?us-ascii?Q?4Q1grz4LqqHmVXqddvhoa2ZdlKgP4fjHY2TyzFbCca2Q8/I4MWN4pi2qUnl3?=
 =?us-ascii?Q?P/1ZeXoDocrY4RDcEt9FREntmWcAMRLOVV9YvnmTNDEgdlFwHFYSDVPJh54x?=
 =?us-ascii?Q?ZKAHvwW7bRmnX+7SxsoApPqHS/U1zO5ISeTfi2J5gYrikrBSbuwCOF6wAXsu?=
 =?us-ascii?Q?Dian7o8gMHerk7bRbpmmTya6QqPIWsdWFAuwa+tD/IOLBXOsyRaszl3BOJ+n?=
 =?us-ascii?Q?+2/TSmZc9lyg9BKa5jHGTKP+KZdYJY8DMp3ZnPKKx3PcXqmXltin6OczxpOB?=
 =?us-ascii?Q?URMP5kO7icB0UhIajV4xa+x/P+xZmyBoOJBC6T9JlvVLHCCjkX80Hvz7RLQE?=
 =?us-ascii?Q?a9hkZkNBIsMpxFVlpmheUxPkO83rGUbnKnXY8AV5JnpdASqqKLv1MBTqC2oE?=
 =?us-ascii?Q?1YLXMjbRYXz0JSCMaMka3eCXPdBGTLiIpkw3owsNRFIL2MjtKSF60Jil6q1X?=
 =?us-ascii?Q?hwg0TJAflprbJJ56FubV5zw5FfbazuDrSsN8wQr+w9xZ0Sfg3NxQm5xfaTQu?=
 =?us-ascii?Q?vIFDu5DrYXeyM36ViR3/3IBKEwQLFZQFubwkQiwHVecCO4YWTmj406E85INO?=
 =?us-ascii?Q?L5QIO4xsFuNup8Vy8jD+ui46JclG4dcvfg8gu8ro4mtf9pf5TLHUOj/hHbyA?=
 =?us-ascii?Q?htXvXtrhGT4OV/m1BgNV13DUupDG0pKFaSRBd+QjDreb6Z+B1CRy/6FaDMVS?=
 =?us-ascii?Q?NowwdimladsdmtbwBZh7o/1u8ll5?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 05:12:53.2603 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85173de7-a60f-45e9-e8e4-08dce1d7b401
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9251
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

As part of the reset, sets the direction of the pin to output before
toggling the pin. Delay of millisecond is added in between low and
high to meet the setup and hold time requirement of the reset.

Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
---
 common/usb_onboard_hub.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..9ecc638c7a 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,16 +7,26 @@
  * Mostly inspired by Linux kernel v6.1 onboard_usb_hub driver
  */
 
+#include <asm/gpio.h>
 #include <dm.h>
 #include <dm/device_compat.h>
+#include <linux/delay.h>
 #include <power/regulator.h>
 
 struct onboard_hub {
 	struct udevice *vdd;
+	struct gpio_desc *reset_gpio;
+};
+
+struct onboard_hub_data {
+	unsigned long reset_us;
+	unsigned long power_on_delay_us;
 };
 
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
@@ -30,7 +40,24 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
 
-	return ret;
+	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+	/* property is optional, don't return error! */
+	if (hub->reset_gpio) {
+		ret = dm_gpio_set_value(hub->reset_gpio, 1);
+		if (ret)
+			return ret;
+
+		udelay(data->reset_us);
+
+		ret = dm_gpio_set_value(hub->reset_gpio, 0);
+		if (ret)
+			return ret;
+
+		udelay(data->power_on_delay_us);
+	}
+
+	return 0;
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -38,6 +65,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
 	struct onboard_hub *hub = dev_get_priv(dev);
 	int ret;
 
+	if (hub->reset_gpio) {
+		struct gpio_desc *hub_reset_gpio = hub->reset_gpio;
+
+		dm_gpio_free(hub_reset_gpio->dev, hub_reset_gpio);
+	}
+
 	ret = regulator_set_enable_if_allowed(hub->vdd, false);
 	if (ret)
 		dev_err(dev, "can't disable vdd-supply: %d\n", ret);
-- 
2.17.1

