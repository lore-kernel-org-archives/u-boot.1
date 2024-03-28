Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0219C54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 23:47:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9CAEB88073;
	Thu, 28 Mar 2024 00:47:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="ljQe9YYB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8B382880DD; Thu, 28 Mar 2024 00:47:20 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 991D187F36
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 00:47:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=je1CFPXjME/8lOviq4A/b3FxI3o8JbVA27oZQO8IG2SsLEH2AHOJt951RRYesMd3JC62UCmlt5aa0fZlHtNHe2ECZ6dewNLd4mJqgVdC6B24JarE9fYCTAP2+A+dTCD0VkDLPVSFUmttv5JwsL3ahtNvxc+NVf+Sl5c5SlFsXtlhZ7kHDrJAbz9APlN8On2v112orR32k0Ls9g2zTQOiE0jMTd4LE7X2fSDD/t6V0n5FtFfONRW/hld8hPlPS3A3bQ3jNJ+lkHT0WGzOtNFj8I+kJfPGUe6jk8PdC3xSftd70xOEtqKyeNPJb9vGqk0RcCWPL3dU/I8eb5kUGaQf/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=V5MtgNrW2S0FlkryWC7ARAlymhdjaweK9RcJHsEJWwnIdfwPUrQnQ4+1HHr1AcoaDlM3EUq+jgIa3gd8O+b8jPsCDkF5551Atl7/Vu6h7e43L0pUaDAx/ha+Wnf1eeIQKA2bDtVGQQF4sc4BDwfuyz1y52YfMAFF0ktLbm4lQOfjKczgkPRToQvdzG7f+B78uzKU6WrayWfMlz4AuJUIbyqnNPtvvUZv7MGqHDKmZbVyJqvH97+YCqGlVl4vpXo/gsLdC5brZbXa51pXxG1ZHR5FeTy1ja8CDBzk8MKhiJ1p3CQzKrEy6QpCghP+2KPWhsluwTTiYCLDt7gWeVOGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=ljQe9YYB7USMzV87oxbYk0FvqTsvD2tWCzuJ6/dd+jbCg5dDyz9JVb2KpkfONXFGMvKKLy+0PdmuJRiRIH2ZzeFW9f8UddwCsnS/lkqr4M+br9SIga1CSt4nV8PUpzzqSAE8AQWNSzTm+lyadnwJu4arw87IBgGcsdd1yqXtlmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9999.eurprd04.prod.outlook.com (2603:10a6:20b:67f::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Wed, 27 Mar
 2024 23:47:17 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Wed, 27 Mar 2024
 23:47:17 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 08:46:47 +0800
Subject: [PATCH v2 1/6] gpio: imx_rgpio2p: support one address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-1-909f5d37da87@nxp.com>
References: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-0-909f5d37da87@nxp.com>
To: Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
Cc: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, 
 u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SG2PR01CA0177.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::33) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AS5PR04MB9999:EE_
X-MS-Office365-Filtering-Correlation-Id: 66acfb35-a7f9-43a2-aab6-08dc4eb83c21
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ggjahpz4rI7/C9XXjPv5aYX+gDEOqDYoC9rEpcpxiOYzgoCmPyiBvdp8E/hLoOcs/8OHIurPSGPXHfxXKEd35+BSPmNZSrbxDNLFTJf+RUf0rsq1US+QxEmZYdiZqF+aSO3qZ1IR9aCnDpVDxJ0cZouobqTyGCnxpYRCbaQRx8POQuJgnm7LQ2lDkD0+hAV4uXTaliRF6LWVNE8NyKD7mz7jJ6Srhs1EVOAkch4UASyTyyWbgn4o6Ih/UKmSMVTTE/EWg8ub6ZSK35d/CTSOxbvEmsd8qr+xvSI3gPpsQcImIJLKNtze0zZMqLdCWvsim65/hDd2DXMcDrzkdxYaTqIe5p7PqkvxY3E4qJoIKsZWkpdI+yEQsAx7N7gJF6AKN3SiZBYEvuE4E2b+SGuvpVUXxtT17vW76+VpjqxCc3hkvCZMYHYsKasHa4EW1eJXMKgLDg7Kksx3SxxFynMJEhw2Sdo4OyiqRUGVRZjWaJz9qPYi8bmbXZattnP+98LXGrQVZefpr1mAs8gnz0qhFTtPDdliLuhaBU+Ax0XZWiYPuVfYF8/sYaxEDDRwZX2y7gTPvgJMWmR4DUAI+QXUK37V4hjEmVvt9nytUljs+ULfQBOUjXB5RZv4Dva6I/5WpH/igly9pzNVAs/kOwbq+LvKJGvhIq52Ab2UqJL+SUV69L2jFamL+D9gqXAMnFTNBbLrDmwx4SjVcPiGjhF8IrBY6mzIFQTq1bTp2hMzSmI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(52116005)(366007)(376005)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1VmQWszK3piWkV3UUZBcXFIUkFEY0FXM1RCZ2VNdUVNaENyQWtzbVRaM1VM?=
 =?utf-8?B?M0VueTJnZVlRMXM3WHZkTmVrMkpsdDk0Q2pFbVRsS3BuVCtQWTdHNUYrUEoz?=
 =?utf-8?B?WE83WDB1U0NmeDMvemJYWDZzbVRRK3BISWVocVpSVUhnZU5tOVpEblB5QU5L?=
 =?utf-8?B?Y2IydjZJeVE3VW5UWlFsK1pncjJSTXAyR2Frc3RhVFlxMEhOcnRJOFVKSkhm?=
 =?utf-8?B?SldzejVOdlRJMnhyc2t2WDJHeVpsYloveTdNNktDdkk2Qk15SHJsTlZOMDZJ?=
 =?utf-8?B?VDNvTFZkNE1EekZEamxid3E4T3R1TEsrM2EzaEpUbEN2SG0wai9JYWdNTWYx?=
 =?utf-8?B?MHZxS1djVTdNdlY1MEV1cGE0Rm5ybDR2K25SZHJBU0hMNnNRQVJLZkx4cFBo?=
 =?utf-8?B?VDloc0dpWk5ncmdvZGQ1dW9WOFF3bVZYNGd4NWRqazUzbnJkdFhSMWpEM01t?=
 =?utf-8?B?NGZMQW9MbkoyajdMbkRQMy8vbkNNQVpIQUlKSUt6ZmJSemNQVit4eUhnRmI5?=
 =?utf-8?B?KzlMbmd2V2RQOFRQbnhDT2tXOWUvSWpoTVo2KzkvUjBaNSt0RTNCWXFWZThw?=
 =?utf-8?B?NUxGUXRtM0hjMUp1N2FzL0pESWdoakJKbzJGNmpZaHBQNnBXdVVkbGh5TU9k?=
 =?utf-8?B?S3k5WHpqc0Z2U0hwdVVGWG5PT3N4OXdwYjFqVVhGdHZBdEtwaGhxSjZvMUpR?=
 =?utf-8?B?KzdaYTZvSVBVNytHQjVCYU1hTXUwUGhEazdDMFpocmRmUStaWVZqdnB5alQr?=
 =?utf-8?B?WXBFbklJNy9SOE1YTWh6U1NOZzVuQ1VjNHZOMGhjMjBlQVR1THBUbFpwS0F3?=
 =?utf-8?B?QlRxbW5NQlBnNVU5MXdWcHBmbWVtdlEzcHdNS1QwK01aYmVkKy9tNmJYUVZD?=
 =?utf-8?B?Y0lXUklKbXdDYTFVRExobXFkQk9jcElVQ0tmZUxwckVXTk5NdXR3THF2TitB?=
 =?utf-8?B?VzRvbFVVbWN6UDhWdjVybXpMWnhITU5RUUtOc0pyVnNVWTErRHhSRDVDT1R1?=
 =?utf-8?B?UkZSdFN6UFVITkF1ZFNHNWlNOVVBR3UzNTVSWHdrb2FKeGc4SkxxYnNTcEZI?=
 =?utf-8?B?YXVaVFl6N1RVQk5ZZ3JncWlzYzZMRDZpZUFvTTdQdzNJTmpvbnVpbHBRR3lx?=
 =?utf-8?B?MWNRQldGYkZnUXI0dk01VUxyR0dKWmNoYVhSNGY4VTdMeVZBdEZIK1RKVUM4?=
 =?utf-8?B?MXQ5c0lqZEtjQUhoVWV6aFlzMlBvTlUzWkIzZlZacUx5OTh2YXNTTzRrU2ty?=
 =?utf-8?B?YzM4ZGxrNXBZOWhmYjdRWmZ6M3BleVpSbGFNcjgzcEtYaXdzZzFRdm1BY2pm?=
 =?utf-8?B?dkM4SElEM2Z4WmVxZ0d1ZlJ2aDU4TFowMXZvNURpUUdmTmlkVHRnNnpWM1NE?=
 =?utf-8?B?U013YmVybmcrV1YrWkp5ZUthL1AzWWJrWGVFYWlVSUhBWXlnZDFRK1NYekRw?=
 =?utf-8?B?Q2lIMVRvR0laeXlkT0l1eWRta2Rta25oQXZhMkxvMGlPV0d1OEpKZmEyMml5?=
 =?utf-8?B?Y3VNWk4yYWU4MjNZYjNqL1ljdEV0Z2tQREVHbWxPNU5lbFNGdmFZakh4K0R5?=
 =?utf-8?B?R1BLOWMyYlhhaG9UUGR4TmhhUldpNEpTUGZjby9oY1lUTzhDUndiVDFONG1T?=
 =?utf-8?B?U1pBSjJrbStTSTlTUW5zNGlmMStQekhqWC9YRzBCUWhKTUdYdWRVRXRGSms1?=
 =?utf-8?B?dDd5dW51V3FPREhyTE9uNkR5SFd0VzkvM3pTaCtGQjV3TEV4aUhDcG44bE53?=
 =?utf-8?B?SVM1WlVEVDZhMFVubTh2d3NwL2VMK29MTDdsMURjYnpYcjlmUnd1Z0hldFpq?=
 =?utf-8?B?c2lDMlZNRmQzQkZKVjdoalFzV2JySjBTRVVCVmd2ZE95UG5HcWJiS1g4M3J1?=
 =?utf-8?B?cUJZZUZDUzJPYnRTL3FGdEo5NmdBYlE3dmFEOEhMc0lBMk5qN0V5NHQ4NmJQ?=
 =?utf-8?B?NHdGcFVDYTFRdkdPY3VhQmIzQWNadDNKcWdMQ0gxVmlRVXNMNld3dERUMkxX?=
 =?utf-8?B?Y3YxSytnRmFvVmZRVE11ZDFhZEk0Z0ErakNla3NOYy85dGFDcTk1K0tHdFJk?=
 =?utf-8?B?UEdtZUN1Vkt1QzE5Y1VqSEtSTGY3ZU0welFlYzFjdE5PZlRYRXU0R3J4eHhW?=
 =?utf-8?Q?5mHgNSQuy9yu+LDRSk4zUcbcK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66acfb35-a7f9-43a2-aab6-08dc4eb83c21
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 23:47:17.0497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: knqbpR+/Sg617nveTd1qI95TTeyEDdZjxl6ZRhtGa7R0NDqNPiuT9w9AJ0jv5n6yoJ1fxq4lk5Ic2MqpjDHYBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9999
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

