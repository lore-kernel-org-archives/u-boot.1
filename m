Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D4FC4345F
	for <u-boot@archiver.kernel.org>; Fri, 12 Apr 2024 13:25:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 95CA8880A8;
	Fri, 12 Apr 2024 15:24:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="L/R2Xb3k";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 65AA487FED; Fri, 12 Apr 2024 15:24:54 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 80A6387FE8
 for <u-boot@lists.denx.de>; Fri, 12 Apr 2024 15:24:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCCE7ytkJRWhm2kuPb5pn3TDHNBtAApghGWH913DNG9kF6VfZwUFMUOUw5r/HmxOn8C/KWImxGTeBEyXpHtHKQ37/qBdnsT4dXnnohD5i4g54rvgFAtqzplJCMZYV+w6AS1c7wuyCPuDMI1oMi2DmIOscX0a0ynU7W4/xgZfJAEm+9WxUiSNa8Dg/ENPwLNmUlrE418bAM2iAht35aZ9ID7vXsf1vY3tXc04CPUvfnooCVUPBXiDrcH2xxS6OKkwzU+a3vfrknhbsx1Z6Xqlv1NKOWFeUf+HGU5pOvOVEk4eEePnZXhreR0HDjcc0Y4deOBvgDH4nVSOdYhE4LEAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=IWNkp9Bd6/HglqUe+D7/kGVpeAjwwnoMVN9X9KVYiURAv4QSejXsKj02cm2MIt5rulB8wqleYokMfn2mkflfimqB7UCy3Fjqi1n4njNm+4WnQW+BbWkPmRhwftwn4YweOtKCYE9XcESWgiM29Ki4DkM1zyfivLdKH6Pflpzl33CbSphJ8ahN0hPMUeHwbvmYNSwf6g/R0k6Woo6ZECYFOxoyqMhLRpd6KIaaEmPD5kHqVacOWQrcMklU6d/GVSShPjBgL0TW706GqbkibxzSQZVmxLSje7jgmKjya6leWxr1ql+Fwho3tUVqRNnaYZJ8V1nXtEB8APCQ4qnLQ7XfeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=L/R2Xb3kCg8ZDc8EnaUWAqiK7YeHJ5ErNSpZBU2BoULnbbWhZUCmQ/+r1JKZWhmClCXg0azmAIs22/PeOuzCyJ8E52HfOv6GjNHyZXdoBOELd12IDmO5LKMk8VdbHbphJDqTJlDac13VtaDFM+D9NMLzUrIhNyBZiXCOyELLY8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by PA4PR04MB7966.eurprd04.prod.outlook.com (2603:10a6:102:c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 13:24:51 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::9d65:d883:afbd:7f54%3]) with mapi id 15.20.7409.039; Fri, 12 Apr 2024
 13:24:50 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 12 Apr 2024 22:24:51 +0800
Subject: [PATCH v6 1/5] gpio: imx_rgpio2p: support one address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240412-imx93-of-v2-v6-1-c2ad48e46eca@nxp.com>
References: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
In-Reply-To: <20240412-imx93-of-v2-v6-0-c2ad48e46eca@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI1PR02CA0028.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::6) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9416:EE_|PA4PR04MB7966:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d465dc-b79c-4dc1-f4bd-08dc5af3eeb5
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFE49gvskKavxxhnT4yCEd3jhv7t5T5W9CWEREdyAuhdn7oyGJbBCtyMsMe7xied87nLUKzhAQf0BM9aPXZDPy9lOmfwf8uCaxwzbwNuTtvvPkUQheJTnISCu9fNse1f3W5o9F/pHMOFYwyF0r+F1HgpDw7CTWS4N68wVbyjBAvmpZZbixyKavgqqCmbwzysS8K4iQXXLIqZSibEZqcrVdmFE2I4VaKWUEtfcCvZPfmt1SdFuVaG4GI3Qs7ftpqEA0zCQGF04xXx2e2yY0VdQvleCG8tN6cLNiio/6gIlu5dEKXqQDE4JZtqhZZleBNN4FrCoY+SbnLLPXHraN0esZjWaEJZu1NWg4I40kHCrO0FAkzRRqjayV8+TFmn4fXywa82k+KBb/6V9rMwjkvX9HenYV7KPOgzuNvvq9/YIsE5jMW4AZGog6X1iOUB1LkgcTqz/IkwW3wyn8NUi4vEJNsLtv2BS0PVk6fbGIccFWBxMl9v8KaOhMy3Rv4/51nl2UyYls/us9mk0aUAIjN9eq4f7R8ERjD+WEWCj/6DEGzy7iV8rOWWZKK6byTrfQRGJrOIVtpqPVnV/5Eeuydnv/8si7MOYuBRX76JSQTmAhmB019y+ygwjFKaLuybGoXfKwavOlwMLbDAetvNt0jzgz060FAhlaNxVWT0i6EOCBEdH2hklh5Hs5MP03JrUug2/BpD8pbETBQFbPz8NR6fC0FypLBOYaRNZkW5KMSW1R0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB9416.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(52116005)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZkYvVnFURVBCamxoYjVWbXkvQ2thOFR1bkIvbWF4ZW5oelRUNTA5VTFiUTFm?=
 =?utf-8?B?N0hvV2Vqb0RrbTRYRzlhRmxncm1mNWZCZmd1Q1pYYVJWVUNEZlRtU1VySzh4?=
 =?utf-8?B?aDZYS1grbDdmQmtZN1JCckFKYTQzUXJIekpVTURsZCtNZjVCbTJtL2xUdTBD?=
 =?utf-8?B?M1VqOE1MazZONk5HdExSZ1BJQ0UzeE5CczhOR3RjVHhLOFlyUE5HQXFzLzZx?=
 =?utf-8?B?NHowTjFOT01mMitvTTJJYnRid0lET2NWNUgvZXp4YnFtTG4xWEs1aU03Qks0?=
 =?utf-8?B?TjBob3hlcFI0SDZyNGkxSm5RVDByZTZKQ0xIWEhHQmdyZUxrdHZ3dEI0UjZY?=
 =?utf-8?B?alRrREs3V0ZZNkdpeHp1dXRPcDEvS0ozUmpWM3h2c2plb05LNXlpOWRxWWV2?=
 =?utf-8?B?cGh3QmJkRkt4cnFuM3lmcDBsdnhiUEk2NmhpekVYMXFBMGhOZ3E0Q05vdit0?=
 =?utf-8?B?ZVlaWkwwaTRNak1UNFlidlgyS0ZIVHVHcFBwUFRqZnBPOWsvM3I4TnFwc05P?=
 =?utf-8?B?S2JFeStveTEwTnJzaWRkV2pmdVZpZVR6eUZ5N3JBRDJhWURJTm5XVkF6NWNk?=
 =?utf-8?B?VXFxUERTY3kyZHZQUkF6ZW1sL2RQNDZKTk51dzVucTRzN3VUMVo5TFJLV0tL?=
 =?utf-8?B?aDgrT3drM0NNbDdCVkozS3hkdy9zbldhT3oxMXZhWXpwdVdjWG91ZFd0ZjQ2?=
 =?utf-8?B?ZUNhNkNuaUhBUWhhbzlxQXVJelA4dVBjWXU5NVdMZjNSL2pjM01KeDZwbmlL?=
 =?utf-8?B?TVZiZTRNYnJLY2xQUTc4WEtDTFlYakpaWk9KWGdxcExxazdJb0RTekpWSDNx?=
 =?utf-8?B?VmtLVlZvNzkwZXZWMS9uVnF5QXJ4b0hhUWQ2aEM2MXF3d3oxd00yYzkrYk1M?=
 =?utf-8?B?QVhmTFRoTHYrcVNWVkp6WGxndEtlc3FOcmFTUnRPYVpITkhqZUJwVjgzMVIr?=
 =?utf-8?B?a2x2dG9MOVUzSWRXYkZGZ08xRjFkTTNWVFhycnFJZHNXZmM5WW9Ec2JSS2o1?=
 =?utf-8?B?ZVVDTXpYbTRxbVdzUW5DRjVPeXdQb1M2NXNhcEtBRjduZERjZWs0ZGFNSGs4?=
 =?utf-8?B?b2EyZ2ZyRWNrWExIUFVnMjJ6N0pRUUpOL2p6WGFVVlIwaklOMnJpZ0tKNVRz?=
 =?utf-8?B?aGw0RUg3V1Rsd2sxUUZjL04rMFpZS0kwVU5majZBSFFQd1RJcXU4S25mb1k5?=
 =?utf-8?B?TThpa1NoTFN0VE1WdUFBbUc2VmdwUGRmejFTOE5namErTVVsL0Z0alJrWVV0?=
 =?utf-8?B?L29jUXRsTjRtODdlM3l0cFBKQzdYMlNhWFJWVkF6YXhOYVNuWHphU1lIOTNi?=
 =?utf-8?B?Zk1oNWQvTno2VTVtekxQdXVBTUpPQkNJbHVhbWlGZWhxeXFKUXVyNE53dGxV?=
 =?utf-8?B?MjFrNWxRVGxwb3c2bDdweUNjN0Z4RDdOOTBCN3JTTkR5V1RhQ1o2a0NxTjFJ?=
 =?utf-8?B?aUhKdEk2Y2RzQlBnekxVcWdnWS9xZzNmdGM5VkhwaTRwcGs0ZGVpd3o4NlE2?=
 =?utf-8?B?VTNhS0hxSFZJU0xRVDFSU0tERDlFTUxYWS9aN1FaV0VzMU5wT2lramFjZ2FL?=
 =?utf-8?B?ZTdGcE55TkxMcW5uM0x3emozTEk1MGErTksvUWdQanczTS9GMnY3TmMycWVr?=
 =?utf-8?B?Q2Z3dHl3QXMvTkZuVTJ0alBmYnFHajlwaldPVG1zTVhXT3loUU5hTHFHakxD?=
 =?utf-8?B?Q1VSQzdnbTc2bmlBWmgzUU1RV3FuMnVsY1NEcmR3d1A5MTV6emRZVUlMTVQ1?=
 =?utf-8?B?T0Nla1FCNncyS2hEcTcxN1B4VWxCa1YwMmd6OCsvV1hUZkR3RkpBZlRGdEpU?=
 =?utf-8?B?cURnUXFlZVFieEFmTWgxMjFnbEpCaE1RWStzcHMvTVdNTWVIRDZPcUZKMG9R?=
 =?utf-8?B?UDFPWlJYT1grZ3VLekhUbEx4U3pMQzQ0d01vc0RjV29yN3RzaHFwZjNrN2kw?=
 =?utf-8?B?ZzFNL1F4WStSWG10ampWK3hINEFhSFFnd2VnUVNjUFVSVXNaTzVMNjZoUi90?=
 =?utf-8?B?aExQVUVzeHNDQ3B1WGpjeVNlMjZ3S0RmZjhNNmJCZDMxVEdNSGlEMXdxVUhu?=
 =?utf-8?B?UDhJTnhHb3dsQ3FySTVzdnpSdXN3WS83MW1YdGRrS3hYR3JsN0tlYjB1Y2Zz?=
 =?utf-8?Q?SAcMeVES2mrk/3InWb0FP2cyc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d465dc-b79c-4dc1-f4bd-08dc5af3eeb5
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 13:24:50.9211 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+knFsjnNq1PmFjDAq+oZNeCquQaHHASlu6fga/+pkzPfyv5B04Fa8Eu7emDe/8coFLLlV4PMEXx0gBzj6L+yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7966
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

From: Peng Fan <peng.fan@nxp.com>

The i.MX8ULP/93 gpio dt-schema have been updated to only have one
address entry, update the driver to support it.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/imx_rgpio2p.c | 42 ++++++++++++++++++++++++++++++++++++++----
 1 file changed, 38 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/imx_rgpio2p.c b/drivers/gpio/imx_rgpio2p.c
index 175e460aff5..3227a8d5b57 100644
--- a/drivers/gpio/imx_rgpio2p.c
+++ b/drivers/gpio/imx_rgpio2p.c
@@ -21,6 +21,12 @@ enum imx_rgpio2p_direction {
 
 #define GPIO_PER_BANK			32
 
+struct imx_rgpio2p_soc_data {
+	bool have_dual_base;
+};
+
+#define IMX8ULP_GPIO_BASE_OFF	0x40
+
 struct imx_rgpio2p_data {
 	struct gpio_regs *regs;
 };
@@ -165,6 +171,9 @@ static int imx_rgpio2p_probe(struct udevice *dev)
 static int imx_rgpio2p_bind(struct udevice *dev)
 {
 	struct imx_rgpio2p_plat *plat = dev_get_plat(dev);
+	struct imx_rgpio2p_soc_data *data =
+		(struct imx_rgpio2p_soc_data *)dev_get_driver_data(dev);
+	bool dual_base = data->have_dual_base;
 	fdt_addr_t addr;
 
 	/*
@@ -176,9 +185,26 @@ static int imx_rgpio2p_bind(struct udevice *dev)
 	if (plat)
 		return 0;
 
-	addr = devfdt_get_addr_index(dev, 1);
-	if (addr == FDT_ADDR_T_NONE)
-		return -EINVAL;
+	/*
+	 * Handle legacy compatible combinations which used two reg values
+	 * for the i.MX8ULP and i.MX93.
+	 */
+	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
+	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
+	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
+		dual_base = true;
+
+	if (dual_base) {
+		addr = devfdt_get_addr_index(dev, 1);
+		if (addr == FDT_ADDR_T_NONE)
+			return -EINVAL;
+	} else {
+		addr = devfdt_get_addr_index(dev, 0);
+		if (addr == FDT_ADDR_T_NONE)
+			return -EINVAL;
+
+		addr += IMX8ULP_GPIO_BASE_OFF;
+	}
 
 	/*
 	 * TODO:
@@ -202,9 +228,17 @@ static int imx_rgpio2p_bind(struct udevice *dev)
 	return 0;
 }
 
+static struct imx_rgpio2p_soc_data imx7ulp_data = {
+	.have_dual_base = true,
+};
+
+static struct imx_rgpio2p_soc_data imx8ulp_data = {
+	.have_dual_base = false,
+};
 
 static const struct udevice_id imx_rgpio2p_ids[] = {
-	{ .compatible = "fsl,imx7ulp-gpio" },
+	{ .compatible = "fsl,imx7ulp-gpio", .data = (ulong)&imx7ulp_data },
+	{ .compatible = "fsl,imx8ulp-gpio", .data = (ulong)&imx8ulp_data },
 	{ }
 };
 

-- 
2.35.3

