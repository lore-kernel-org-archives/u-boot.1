Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F0EC54E67
	for <u-boot@archiver.kernel.org>; Thu, 28 Mar 2024 04:06:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA7F18808D;
	Thu, 28 Mar 2024 05:06:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IWWL50d/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7664288035; Thu, 28 Mar 2024 05:06:15 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::601])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E15787BE0
 for <u-boot@lists.denx.de>; Thu, 28 Mar 2024 05:06:13 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YfDPZeZIEo86RUfrLtFET/TVGFDX89QUlwn32xOr3adVAqn80bZtwpREzHxLbtlfFGFHlXu0wjED79RJ4N8Sj9rsgleaeRkaF3UhEuNidHBaaSTSOq21XAafutHdAdoBemtBq47PUfScPhFOLY/EFH+by0w1Ld345BPmMxdqit/oGlzSdPLajdA2bs3T7AdYd9br6+8QDwtC8W2YGOwOazxSgte77A9cPPJSM7tlZqC/BXD0q0tJdZ+jRL7ZGYgOMaYI8oAz3Obu9tneGqXLF51aZC+3l3OPVnd6UT8b2pufNe8fNazGPcEjXJ/WOn8ODxgeL3ty5FJ1pvZCRp+z/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=BUfSLHjaeYZ6JH8g5oAHIxbqDtTXxIGohRpp8py7eGhVtyjWVMli4+4iQOgDJz9sQmJna8ZFQ4u3JLVm2mj3AoCoPsf2wEP3JDtquzWRIyOMoVnVpulmSDceRZ1AfbR6pwtFIc8efPrXsqVZDMdcDoItRisem5XPnOYyjTrTW2EELzgT7DClKro6W44ZPsBfw16tmweRRHlauawEqnjsdpRfhzzU/jcrp6kr1DXcPMG7DP8d/hFcguRVJJ3MWec3CfGuRS0DbUyE5Z7MRhpVHEfqYsBH8JCbSfnBjzYMYeadMwocemo+4D94zByPexCrAe+omUTfkG1PBppIBsrIcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3i3haQXlV3blF7oFjyEvD87LBI+PouqducUOa9tuVIU=;
 b=IWWL50d/vqlzKrrOcn3+7ZazkI1uxXlvHhXRBtY0jnAkmygHhRKgYExeqcYXhMiy+vyISLpIGhCgb7M0R8kuIFQT2570fkMpdhB5Aha8FqUA9xnYfBooqEbAIzXXbrlBgqKc6mK9Gj11svMHRzY/Sz0h9GFe65NT2ciCSJnuXQI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9488.eurprd04.prod.outlook.com (2603:10a6:102:2af::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 04:06:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Thu, 28 Mar 2024
 04:06:11 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Thu, 28 Mar 2024 13:05:45 +0800
Subject: [PATCH v4 1/5] gpio: imx_rgpio2p: support one address
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-imx93-of-v2-v4-1-338d15a65c36@nxp.com>
References: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
In-Reply-To: <20240328-imx93-of-v2-v4-0-338d15a65c36@nxp.com>
To: =?utf-8?q?S=C3=A9bastien_Szymanski?= <sebastien.szymanski@armadeus.com>, 
 Stefano Babic <sbabic@denx.de>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Mathieu Othacehe <m.othacehe@gmail.com>
Cc: u-boot@lists.denx.de, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-ClientProxiedBy: SI2PR01CA0045.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA4PR04MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8b83ac-6ab7-4cfb-69cf-08dc4edc6793
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pLbYwjmQgL6Hk6aYacvHJ607CAz8ALKMIkRBlJ/72Zl1eEY8NSCEoGnHjNql2mURJ58zHSahHDv4MvqU1NLjPlzfQsbeuT73UWdYSbLSsWew2FSnUTivFzZIn6dCE8OW0MQMhUEiPU2/QS98o7x+ou05jy7/AtfsH9yFhuGDyu7gwjQnqkfK88IPnusuZ2NxIF5iX7d+hC+yd0SKmnU4Io3u2T+uqg7nsyE1s6qZEfPMB0Qf15JEIbH0gaGVoJLwzyNAA7dVyRY9xcpN5TaLjcRLxABgPErU0TYnmMNLSp3Zr0Y19KFZwWdxIT0OGnIcvb00N9WXFZIxxlA7lYab6bMun56Gsi2v+Zha4HRlT/dGuabsVLtutIVbFcH86lZFz1iTs9pHw+KBi6wKJ0c7O19BO0MNezZcWx60wogbAQnHB13TQxQ8uhvobsvSm3CeqsJyBado0nGt10U9DYHxVs5phPk2i1QDQmgrNCYVCD8GRPeE/tQWhmVOJ/OWy7wHvvVckcO7IiSnXK1uydcd1+nbkXWjzQx4T/SJJb59e3Img/zwv/IXeqwXX5yTNHXFe8SyTv2Cdfx5o1djrisGfh/aoHAaEuCYsjQXWGHQ1e8X0fJyVtO4JGq1beJvz1T6ARQ8i0DmAwAq0e1OFU8HCi+B2cF/Gi94XwEc9fU4qquWEQ5iELdyH8cakS4KOFZRoorkiIw/sYK7CDoBfDkWr9dj5G1gkPVpFOHWcBXkLQI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR04MB9417.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1hqSi9DOUZTTzJFN1g3OTdZallObWNkMHduYnBpYWluNER6cHcvTnZ4eXF4?=
 =?utf-8?B?ZGNwdjlmYnJoWS81ZDVSVXJCYkZodHNWU2c3QXZCQ3ZaaXAzbEtBYThpVHFm?=
 =?utf-8?B?R1ZCZk5DdXRLeS93SnZWaUNxYmhBSkVDeDYybEN4a3VkZ2dkWEJ2aFcxZVVL?=
 =?utf-8?B?dy9UMWhJL1Q4dWZiRDQ4QXRnWFZSbHZYTWtRWWpNV0RuZWsyWkt4Vi92R0lW?=
 =?utf-8?B?dE90YUowNFNCUjRRcUJpZmQ3ZTZNbXBZRnRjS3NlQXJGQkdKRUUwM2pzT3ZG?=
 =?utf-8?B?ckVUdHFoSE9BYjZSZXErcXgrenhpZVhmR0lhREgzUnRsdzRqdkhIQU1yWDZ2?=
 =?utf-8?B?OGN5Y1RYN0paYWNnN1J4NDBBZ1I2RHQxQ0ZYbzg4c1BNQVBGS2F3RTk4OVhZ?=
 =?utf-8?B?UDJvY1AyVnNLNDg4eUwxVFh2Z25vSXBRVkhuTGxvU1BqVDFwbkUyYkw4V3pa?=
 =?utf-8?B?cEU5TDNZaDN6Y2pwTzRVNmVzaXN6T1cwSU5WNmhZMFViZEVzSkxwWjZJZ2dD?=
 =?utf-8?B?QmdDTHFGZElEdU9TL0xVOStQOU4rYlY1OHhwaXJkMmtBSWJtaFgwNiswQzhi?=
 =?utf-8?B?OHFjQzcydUxWOWJJQUhjZFJGZ3hFWlY2aFVhMitZaVRlQm1ob1A0WHR3UGtD?=
 =?utf-8?B?TVljR3l0L0p2Nm5yK2ZsVjh4NjVHZFdUdzJZWHBmSVdDTTg0WmErYXU2K3BP?=
 =?utf-8?B?cWtXMjkrOEhEWWJnMmR6VHd3Qkc3T0JHaUtybWo3UnVKNXVlQzF5TkRTN01V?=
 =?utf-8?B?czVMZE1ja2NSMlFkajNKSEltWk1CRFBZRm9lSytwM1dCbkZMb05LZTFOVHNW?=
 =?utf-8?B?bkF1dzJQS2lpbCtMNE9YdlFUQjBvMTkyakJyMS8zVlMxbHZFSGFCWEpWMjlC?=
 =?utf-8?B?M1QvNWRya29JaFE3NHk1a2pDYjIwOGx0UHVub0w4NFlZaWNqckZQVW93M0JJ?=
 =?utf-8?B?eUJBMlBTblRnand5ck1VSmE0dmptR2FOOGNZd3Q0QWJOOWo3TDF4STFCditY?=
 =?utf-8?B?dTE3YzAwNkJyQklBN3pPQTBwYVg2dDJONStYL2xhSCt2K3Jwa2NWQUpUY3Vl?=
 =?utf-8?B?WlZFVE5ETk9SWW5zN1dmc1lKbGRydUxvV0MweFVDNzUyaGtkNmt2SlZrSVU0?=
 =?utf-8?B?L2FXUzl2L2l4d2RtVjdocnRpckpuUityQ2NGMXE5RmZSM0xSdTBWWm1uTE5l?=
 =?utf-8?B?bGNsR2JlRkg4czJTQ0gwWDUyUUtDZVN6aWRmMHl4WUNUaG11WjhYOG5iVytk?=
 =?utf-8?B?UktYWURqMUNSRFFqZFlXMXNJTlZYNC83czlZVENJTi9EbUtraEVLaVVJWnFm?=
 =?utf-8?B?QTMzQnlBWkNIMEVrRU1TVE43anhTaTFRQ3RkUXVtc2dadVZ0TVhlTkRmTWph?=
 =?utf-8?B?bU9jSkpKUDBnd0hyVExVYUZnUXR2RHJLMWpWUmEvTmZCb2lLbkxibGFiT2xk?=
 =?utf-8?B?eHhZZ1NBbzBoNjBTV2V2a0VXSUpibkxNTFl5bFlDK3VwSTBtalNxeUFZRGpB?=
 =?utf-8?B?akQwN2VKQkNmNzk2TjF6d2lFUHpFSFZyWkhkM3ZSNExjR2dOOTcycHd1UWNt?=
 =?utf-8?B?RkVWOWxRbmhJRXRmWnNyL0I1WDhUSkp0M2JsaUNJZURvVGxKYjNFTVI4QW11?=
 =?utf-8?B?RGx6YlVjWTBJZTN5U1N3cjY4bGhuT3lGd1pqZ3dERnBDSkV3dUU5UjBIQnQ5?=
 =?utf-8?B?bVh4eHBRVU5jMGdsNFNxOHlUK0pIRVFzZUZSWWZFZm5sUStRSmxSUFVNaHhn?=
 =?utf-8?B?cXBCZlZ5U0RlYWM2TEttaWExN1dqOFRrUFJ6RDlUbTE2aU1QY25VamRuWEly?=
 =?utf-8?B?K3htOE4yY01leWdKOVpYV1BBbTNVMWVlelBiL1JUNitaVlNlUkVBY3hzTEFq?=
 =?utf-8?B?amtKWmFTZlF6bnNDYVJnL1lJOTAvb0dKcU1lcmJoaWdmdjhPNzM2c2lVQ0Fy?=
 =?utf-8?B?V3dxM3ZtT216L1U3eHdIT3AxcFhGcnh5aUxUM1IrTnB5bTZIK2RWV0ZORDEv?=
 =?utf-8?B?K2NoN1JUMXVwUWNxb1MwMkRRdjFnUFRYaEVkQnJsUkhpQlAySTNCR1Avc0Qz?=
 =?utf-8?B?ZndMbTlyU3ZpWFNqeFE2REtVRGJxbjVuMWlUTVBSU1ZYUFY3T0Yzc3hXcEh6?=
 =?utf-8?Q?78XtHmDnECWDiYgEJvTHs2vjo?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8b83ac-6ab7-4cfb-69cf-08dc4edc6793
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:06:11.8032 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jp8tYTmsQbXdUU8FzwFl3ALpRA0Rm6XULrl2uNbGnqjA7Lf7eLeSvwocl7LWJL99UUpHDshAj7kk6G+FN1bulg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9488
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

