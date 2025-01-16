Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3084BC02187
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 13:07:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2878180719;
	Thu, 16 Jan 2025 14:05:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id F0D8980658; Thu, 16 Jan 2025 04:47:08 +0100 (CET)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn
 (mail-bjschn02on20702.outbound.protection.partner.outlook.cn
 [IPv6:2406:e500:4440:2::702])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1E80980214
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 04:47:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=starfivetech.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=hal.feng@starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSDERIty4NyhWXns+gbs/88sNwNKRqOUbojXfPXGjdMsJrbcwe/1Pqc3GsxN+ZPtKpZ70mla9oCKINUTEEZQqI4RniQQqLiN4wPpkWS40S1g6MNYhx4hRrAI7WmH1NU74lBcZatp/FDjOdxoU7VdV5PpstoPheME7hqeJ+Se9vd4fQh2bu92wxAYKbN0rVhTqAZpxU7vCghoJJ3JSujYCtZFF5e20d1/d/BjK7WQk3ijpYIGZiSxQ5wmo4zdK9+32AOzGd16xs8PRI0BmCkgQ6DmwFvKwXCB2vRJ5SxrKAL3Sl2aI74+MqkqN73EF97dSsBm4HM/gvMG15wwlyeRLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wOa5y64gUBOGZQPT5u4OXuGRGpEgGhwpqaVqd5th1bc=;
 b=DYJTSiFWZLM9arFxX6WVn29MjXclX26ai+4HKEoWacfM5iAmTYo/DN8hNdGmNLf8SQIV21dDNYVGvXiOKSELHXB4NN0sKnrKynCVkGN4RgiOXRL+JVnHXv59U3m8/vihjfNg9SjltsO7YbHGb7eSIqFtJhWI9asWrqtoBvo47GMEv5TqTXrMRTK5NkHkbvoImp2SAXosSzXmLtsWWi3E1PpoFrty3bIobC8RK/RYz2XZjBSmxm2uJvBYLwHrSbnCfK36a3siffl6zwyVL2CeYrIit0au666KfgCBEc8oWWLIt1Kt4nD9ZKL6Cm1w1UWso4U/JnZj+yPHJRnYAc0MDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1306.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:11::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.14; Thu, 16 Jan
 2025 03:46:57 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%3]) with mapi id 15.20.8356.010; Thu, 16 Jan 2025
 03:46:57 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Leo <ycliang@andestech.com>, Tom Rini <trini@konsulko.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>,
 Sumit Garg <sumit.garg@linaro.org>, Rick Chen <rick@andestech.com>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	u-boot@lists.denx.de
Subject: [PATCH v1] pinctrl: starfive: Correct driver declaration for
 starfive_gpio
Date: Thu, 16 Jan 2025 11:45:34 +0800
Message-ID: <20250116034534.91513-1-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0011.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::23) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1306:EE_
X-MS-Office365-Filtering-Correlation-Id: dbcaecc3-b25f-470f-450d-08dd35e06ccd
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|41320700013|1800799024|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: PocNIASCJmU57T3JU0snC4p/oI0y0mQKLdyFLtu3unTQYdrnvMlo9wX+Uzpk3HXbqY0IPMEmmmouhg/Nzk9GZFjzYqkn3l+YqikkGozi0BU92TWeVDp5DsQP+1gEBTr5Cn2lS0Z6Wdt1+0Xpoi8xnLlXGXRlvzs0ZW98AaSEXWdEnjS7XlTPioWum8BRnvoo6oQasx/ajh+KXhCHoORDH0kml3qElAmdlJp5Pc51WYhDmYPRDaJUIncnkEe1UaYZs1yxQEpDDRH/IjDpqwKhhOQMWr5tMRE6ij6VpFJYadUk4OTfr8enc4hc1f8KucxMJ8epA+LzJ0HKnW1QEPVP4nLK+Tu+EDK8Gx1QPeqdFdfdRMImaS8kyZ5TBH/M8VFTi9xswgOT3dYL+NPyL/Fo4L/jmZoTcxPjlxp7oBj7yBibhC2BZwwE1wUi0PHx9zQukWHDNDvNZMP2Rhk/PRv67XPPxttBHsXfc6nBw1UP8Va3/zhyRGbZwAI5WJa9sLWYsHD/ET5E8unLsQPhiK/uj+n+Wgh3U65UHGgDw2bc2LL8bC9uL0AYYLNTUfhW4unq72raJWGUnMHaB8GxpNad4MiXbn39HUK+mH3PAgtAMLQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn; PTR:;
 CAT:NONE;
 SFS:(13230040)(366016)(41320700013)(1800799024)(52116014)(38350700014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uts67jj0QfVPv7j0vl+vk9bD5zAwuYC4EM3jRsxr8fIeWH9uPa1JtO4FFQ2b?=
 =?us-ascii?Q?zgp1gbSoob8SoXFXHdLG059GqtSlpg27hElAVu5wrC2yTe9Peg5YTU0gz8Bv?=
 =?us-ascii?Q?jjyVO18uZt0AN4pwufGSuC1NOVFRF6DXXAuHFrMzhV7jCz896W0ymMBLTjJh?=
 =?us-ascii?Q?V8fTYC1jLwrN405ierZWab4oJTs11dznCKBSWDiaMmSXEJngvto3QjaQqYcn?=
 =?us-ascii?Q?gneUzoT23YPSjeag5awBnYQOjJMAVNpxNdmvan+FgVywNLxGhotJ9aH5wOh/?=
 =?us-ascii?Q?qCmEJJQxHCftcA8/ObYlXI1TYo3OhHkDbbLtoia4SAcW2LMbWyKSo5lGQMm3?=
 =?us-ascii?Q?fbwUZ0Xy0Tm/HqsraPXPYmd5mAzyN1k5w/Tco+NUlBSgrGHqgR7ZCaiZVGc5?=
 =?us-ascii?Q?Sn8zd+qdVMxGFr+eciRF99PboycV+wdejQ82u1+kI8ykQPlHMpr7y/irJJpd?=
 =?us-ascii?Q?gymTS/DsdQaR2EprhFQeViRwxZ9ARYGhdAHXh3eep3e3YBn2MOYPk8tfTQTQ?=
 =?us-ascii?Q?/hmNhS7pAXFV/pbS4CAByZH71o8O3ADEhp+yx9mssrMXOJaqjNa7buGNEH7H?=
 =?us-ascii?Q?q1N3jSLl3E8qNHCWX4W9gZWMw6RW093/29NiFTZXJaq3wgu+zSDis4nnGHNC?=
 =?us-ascii?Q?PTLWgZq4mdYBQbn7kLlPZArhgGvmhVAnP7pOfQNBhmLkRlsQ5v+bmmuVodLE?=
 =?us-ascii?Q?J6dlKv8NAPd56qOF6w9yIT8mpYt4aFMhSlJ0Q74HhKmalJVU2iGKG/1dCE+P?=
 =?us-ascii?Q?VdjWd8GqcQjP3fVp++SM02AtQFffQoynxpi3oSH2EJkGio/zH5bJo8yZ/AUa?=
 =?us-ascii?Q?BL9fS5tlAmT3fAfqZnJFctoidog9C3aWwSrLojhX7fxOUPjc1Z/w/OAWHIp5?=
 =?us-ascii?Q?rvUqBi+Yw2zKNy8i378rnktAkxNlsH8BvfnUsdnfrvTN4EgaVuZMat/vqSKT?=
 =?us-ascii?Q?FmCb6u2KmPOlgZDaTwunF37VPDxOmEApklIgM7awh/FpThOFUSS2pllnNcX6?=
 =?us-ascii?Q?phFG7cVle2+zzrz1OvWSz04azdZr4c4Mle9nbI0CWmWVidW/NpN68C5yz9jB?=
 =?us-ascii?Q?u50yw2z8BfrWjVlL/QZXUBPaGFaygx7BLrwkvQJl/BUUu6wECy/dU6T9mJ18?=
 =?us-ascii?Q?oXqldjV7wJ4vga6u9QY+LiYcEoejthyFjeWC6qXQrMeP17W/TpDA92MiPgV9?=
 =?us-ascii?Q?cyaFwf4/EiXObtCjI5kxnMYdP2bLdJop5CVS7gSbIoq/3AgNyAxXxg61Grly?=
 =?us-ascii?Q?FWezhT6Rdf13ohJPhrWFLmuUo6GQha4CvpxF+aJfrbTq0gJUY0K/l1BKATW3?=
 =?us-ascii?Q?DHB2OKB2uSAqFtIDM/KruuELuhtgNCuO41tJb9atBLEd7Q65qy0bSN+je/fA?=
 =?us-ascii?Q?6ZWcLXOTx3RJyLXSOoNFyf2BzMLuk/2vJy1XsI6I7QdzdUh1jdXyZ0ybGZP9?=
 =?us-ascii?Q?3AXu5YdTQvyTvz224PKBqVfNmgvLsTrkeHNfnCwdizaWz3j5TVZWrKBfDQOu?=
 =?us-ascii?Q?MIxIwXynjqp4MLKdMvRD8iW+Nv5UH33WOrkfkiIZ7XnToCsXL+FMp6IujQkK?=
 =?us-ascii?Q?W7fkUrKZDEsUUzQQ+JWoXCiSNPuwgIJ5iOEzvgikPULaWt3vpDFVoYSeALaI?=
 =?us-ascii?Q?AQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbcaecc3-b25f-470f-450d-08dd35e06ccd
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 03:46:57.2270 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FnNstMkRP8YlUpLZvOqwOJvWgT1/mcpesg1SFaOJISwkSMaZ3mkqxMunpTUW44MHExjzXUWkvTHk1kaLH0w/T6/cf2W093LLrsPj/cr0R6U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1306
X-Mailman-Approved-At: Thu, 16 Jan 2025 14:05:52 +0100
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

Use the driver macros so that the driver appears in the
linker list.

Reported-by: Simon Glass <sjg@chromium.org>
Fixes: 732f01aabf53 ("pinctrl: starfive: Add StarFive JH7110 driver")
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 drivers/pinctrl/starfive/pinctrl-starfive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive.c b/drivers/pinctrl/starfive/pinctrl-starfive.c
index 95b1a752de2..1b942e6f045 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive.c
@@ -348,7 +348,7 @@ static const struct dm_gpio_ops starfive_gpio_ops = {
 	.set_value = starfive_gpio_set_value,
 };
 
-static struct driver starfive_gpio_driver = {
+U_BOOT_DRIVER(starfive_gpio) = {
 	.name = "starfive_gpio",
 	.id = UCLASS_GPIO,
 	.probe = starfive_gpio_probe,
@@ -367,7 +367,7 @@ static int starfive_gpiochip_register(struct udevice *parent)
 		return -ENOENT;
 
 	node = dev_ofnode(parent);
-	ret = device_bind_with_driver_data(parent, &starfive_gpio_driver,
+	ret = device_bind_with_driver_data(parent, DM_DRIVER_REF(starfive_gpio),
 					   "starfive_gpio", 0, node, &dev);
 
 	return (ret == 0) ? 0 : ret;

base-commit: 178f6ecb21fe12ada74a9a1a08093c812b15eea5
-- 
2.43.2

