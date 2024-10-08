Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9713CCED266
	for <u-boot@archiver.kernel.org>; Tue,  8 Oct 2024 04:59:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1D80F88DEE;
	Tue,  8 Oct 2024 06:58:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mN3Sffho";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ABDC488DD0; Tue,  8 Oct 2024 06:58:39 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC29488DC0
 for <u-boot@lists.denx.de>; Tue,  8 Oct 2024 06:58:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=venkatesh.abbarapu@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TSXLH/r6GQjiPeckILrLCvhaP1BONpbVYabGEaYENRx8ZFb2nkCUt9p9E0fXJ0lHxwBvk5VZmoqbmLzl/7jg0ebBSBgXvni2v2UydR/q+bkBx0NCjR7//f5vwm8VxGG97kHXePJH0XjGmw+wW1EzlWgWl7nEiZnoyZUya8jsyfX/7qcd0zvq/l9t6jROz1AwisgY70+3IcUouafBaAxSdt+5M1vsvyXVfxIkKnDPFi5gyqHV4uX0bM4rergB6lZIeZ2tZSTQCgSf9gWCA02deM9SYzLnbX+1Hv95+P/lKBF5OlQ9roOSGoaFP+e7rzsQko2pTGe73pDkFQj9cC4PQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUZYQ4Vi4xNGxVuqQUaF4B5d/6VKML/NK1ejgihuzY8=;
 b=dy8CW8n8jiTpF8p5ai7VW2K0dSlPllHT5XMuJD5LLPcvf2QSRuuidKhck/rFWl12zrKaE50HSRvKWVLth8sZqmZYkGps0PWgfZB5AuVEOtrWGMHZTlqNEUW8O+SRhn4cs4to3q1NyImwQbcjEDrNcrMEikjP+v8Cpsdmusg+cy87KGBl9MWs/i6QCZh6z2G4Umtr3HoRhKfSdro3bRUWatLIE8iu8n4JZXs6wrEyMDFniXQrDQVqLKZldjvOAedL9nZNY/HfSy2wHDm4OW5vtbp7/jX0RbwKmPqpCxeu0HwhQRNKEHU2RxGZ+NT7ndAG5LXDXiQMY7ebOc3VTONRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.denx.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUZYQ4Vi4xNGxVuqQUaF4B5d/6VKML/NK1ejgihuzY8=;
 b=mN3SffhojekvW+9YaH9QiYAfzmWumXAfKdnmuIqjvehjq2vN/BC34p8/NKFWrE/3L2Uvm4ciSe29cSwRgMLpGpti9L4ChODfBohJRHqaoAWxE203lItwIGTpSue0+/lZcHLjlAa6qDjQ7ujexSpkdvRZY9vx2jdd+zXoHhNczv0=
Received: from CH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::17)
 by CYYPR12MB8961.namprd12.prod.outlook.com (2603:10b6:930:bf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Tue, 8 Oct
 2024 04:58:31 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::f7) by CH0P220CA0029.outlook.office365.com
 (2603:10b6:610:ef::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23 via Frontend
 Transport; Tue, 8 Oct 2024 04:58:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Tue, 8 Oct 2024 04:58:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 7 Oct
 2024 23:58:29 -0500
Received: from xhdvabbarap40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Mon, 7 Oct 2024 23:58:27 -0500
From: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
To: <u-boot@lists.denx.de>
CC: <michal.simek@amd.com>, <marex@denx.de>, <fabrice.gasnier@foss.st.com>,
 <git@amd.com>
Subject: [PATCH v6 1/7] usb: onboard-hub: Add reset-gpio support
Date: Tue, 8 Oct 2024 10:28:02 +0530
Message-ID: <20241008045808.28757-2-venkatesh.abbarapu@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
References: <20241008045808.28757-1-venkatesh.abbarapu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: venkatesh.abbarapu@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|CYYPR12MB8961:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e38fadd-b343-4722-5fc6-08dce755daca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SJ0II8GXj0jaYvA6puLT/E6Jx1X4uj8mcr6327h4+PdG4r44a6skZ081p8tl?=
 =?us-ascii?Q?swjLX9AUXJZ/dzg3uITd1XbZWaoYLhbNerHB3evIHzT8ge42nA8KNujlfa80?=
 =?us-ascii?Q?XXjFbf/CCAeY4UNrz+yNqvcN53B7BBdqAJ8G90hlddcSv3uk2HGyv+APNeca?=
 =?us-ascii?Q?UgG2Ni0IFZs70550oDAUs5FwP9zBs8z95/ql9US+jczfs4/t+KuIW2kKkeNv?=
 =?us-ascii?Q?SbsNzuuARF8CWkt1NQObHMTgEGEM5MTAxVw5tG4Qth8vxrTWsk2AzJ3RfYZ1?=
 =?us-ascii?Q?0RuTGXjpLiRuVuWC4Pnq1XbV+F7ZX9BKanTnUISE75a6Wm4jGBYjSvxOaWPz?=
 =?us-ascii?Q?XpMTONe7oqeLTe9OTZA8kidoL9ua+qEEbcSekcV3IYnOGH9UjlQu+8Ny5eKU?=
 =?us-ascii?Q?eG2zFoH919Jn7NeK5DXysSx8LDzGWgpCbV/d0Rgatk/DCuT8/Rbrly+tXWjI?=
 =?us-ascii?Q?qlnhPs76xq/Wa3meqMRna4hoMQUVkUrGbJ63HMONleznxryL6Llksvvs74Zc?=
 =?us-ascii?Q?fpV+t1yvps0Tag68KsEHKWx3Im1G9EpbG/C7LUe1Nxa46DetZs44EwLIC/R9?=
 =?us-ascii?Q?8tJcUZ82KlAxCWOFfYwiRp4DlhTX6jUJBTmc3FIyU4ZGAh5MtflE66bmAyJH?=
 =?us-ascii?Q?wdJRnQ9qNfPcOeAl7A1GjuD7Znqk4121S72FKqqjvJxha0sAqpRc8Znu/ddU?=
 =?us-ascii?Q?Q6w+yaYEprokxiuZajxPF+TMYCTnHgSIIxrNH0JlVlSrqHuegA8YmFYqV+uL?=
 =?us-ascii?Q?vJ3CSzwSufKnIpRYDo0RGuC0XgdBttGMbe1jdGwlVSk7p3optxjbMLqzyfs/?=
 =?us-ascii?Q?gTrefqGANcixVWvVceqEF4i/X9GCTh34Tmmrc17vl2uFPV190bb60D8CaU7J?=
 =?us-ascii?Q?J2zsTQG30A6VJwvnihX2ozKMtGDMa4O018bJ7vUDQWeUZFdaUXn2OZ0S/AE9?=
 =?us-ascii?Q?Vte0ofLGXrZALWv25QRdoUAO9HhV6FBfcathAUiU5H5lERxCvXm1eynwy3E/?=
 =?us-ascii?Q?hqy621jRhFeocP2pGvPXwM/dAz79nAWpMUy//XRlWNHNzfMIjpLiD+iirYPr?=
 =?us-ascii?Q?mrwgVOtWxHKug2a4vkDBje5h+k2SXKfx6WVHbuGGFkejaltgXm9kXXJuOiAv?=
 =?us-ascii?Q?EOWB5w1qJK1NqB/dUzvwhf8FaCqWsqcTbYKtIr3r4rroA2h+aX9IBZzNNNh3?=
 =?us-ascii?Q?x9TXFUBrKkDwhDOGoynSyl+ItEztEiT/pard5iPTTrCgODqouiUyEELvpxGy?=
 =?us-ascii?Q?M8wZ6yE1s5To2AIpPIxLgQTwkT2n4JvB54htFOIfZvHe80MywNPozLsB3msJ?=
 =?us-ascii?Q?/pI/Dqn+3pq9Q+zJrcnMq7Lnc/Pu9H2MShvfIuUVApt/qXEFtoj0SBznYazT?=
 =?us-ascii?Q?5OFmEJunyiCpjMxd7RiEO51CSRLt?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2024 04:58:30.7762 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e38fadd-b343-4722-5fc6-08dce755daca
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8961
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
 common/usb_onboard_hub.c | 45 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/common/usb_onboard_hub.c b/common/usb_onboard_hub.c
index 68a04ac041..df255d55a5 100644
--- a/common/usb_onboard_hub.c
+++ b/common/usb_onboard_hub.c
@@ -7,14 +7,51 @@
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
 };
 
+struct onboard_hub_data {
+	unsigned long reset_us;
+	unsigned long power_on_delay_us;
+};
+
+int usb_onboard_hub_reset(struct udevice *dev)
+{
+	struct onboard_hub_data *data =
+		(struct onboard_hub_data *)dev_get_driver_data(dev);
+	struct onboard_hub *hub = dev_get_priv(dev);
+	int ret;
+
+	hub->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						  GPIOD_IS_OUT | GPIOD_ACTIVE_LOW);
+
+	/* property is optional, don't return error! */
+	if (!hub->reset_gpio)
+		return 0;
+
+	ret = dm_gpio_set_value(hub->reset_gpio, 1);
+	if (ret)
+		return ret;
+
+	udelay(data->reset_us);
+
+	ret = dm_gpio_set_value(hub->reset_gpio, 0);
+	if (ret)
+		return ret;
+
+	udelay(data->power_on_delay_us);
+
+	return 0;
+}
+
 static int usb_onboard_hub_probe(struct udevice *dev)
 {
 	struct onboard_hub *hub = dev_get_priv(dev);
@@ -30,7 +67,7 @@ static int usb_onboard_hub_probe(struct udevice *dev)
 	if (ret)
 		dev_err(dev, "can't enable vdd-supply: %d\n", ret);
 
-	return ret;
+	return usb_onboard_hub_reset(dev);
 }
 
 static int usb_onboard_hub_remove(struct udevice *dev)
@@ -38,6 +75,12 @@ static int usb_onboard_hub_remove(struct udevice *dev)
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

