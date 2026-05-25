Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D5BECD5BAB
	for <u-boot@archiver.kernel.org>; Mon, 25 May 2026 01:54:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5E745846AE;
	Mon, 25 May 2026 03:54:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="CaB+xBXM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 50EC0846BD; Mon, 25 May 2026 03:54:00 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 35F9A8039B
 for <u-boot@lists.denx.de>; Mon, 25 May 2026 03:53:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oK1iNloAFJMT6h74ELHGHlEm/fDS08f1GAucfDqdsZrJu0dpfisiSl8QnzvNI4UDfWO4QN6b1AFLlzInCxyjHAt878GP+C5c9EROeymlCoYwpPCjRG0Z6pFbp4rZo2RDeMxlisbuyA1d7kvqkJaCEaNnzTAsl/ySUFKwl8pMJOHgs2DptWX3p382PowMpwaV+wKoVKFqQCPxyIgI1hQI6SbuRuIYHbJqYWgF7XfCC2CCfIFWHCT62t+RAVTFeUA+c8voCk8JnDCZpgn5p9lT0N3mUcYU6ZnzOX4as7qHQ7sbeDceq6Aplqnok95/mT5JghXfXLgUMAgbOForYzzXEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gYTL+d6tSHqaLWabu7oIfQVIpB962o/nJfw9MXxL5XQ=;
 b=IHyYU3AHkiFCxQLF3nLxQT9p5Nc6u0TdOM4BAs4j6eHadzhNQuj2tzh6+CTfhu9xfYo/IaHBctD6uQefiiV4duWsiHX4vquK7iOB0cN2yKFcCa40aKAe/H/mg7Vtj8vCe8Aif4EwNG8hYIxBWwHQkpM8mSuehGYd2otEctwCGFAWv+htZiLiMyCyO+yT78D1sSeiivzewWbgkrV6p3suifjyj/HEx93EqDtpWSI/1AC5ASx9iWlnnm8DcCDPFXl55V/94Hoey75EiaaC4lagEJfr3ncIjf2ck8O+g6hpvTk+MVndG1pzKBzd4XiLxbraIIRze9bcZFyMd9WovUGQ3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gYTL+d6tSHqaLWabu7oIfQVIpB962o/nJfw9MXxL5XQ=;
 b=CaB+xBXMdTw1jjK2vRC0IWmWJPS0BpAgxy0sQhLCV5yyeyNvfSTppGCmEIfiDS4g9os+j2tQmpixwhA/HgYMLKq1jQ0oUhdnBZ0uzcPscUr+kU9IGsVCp1MNBjp0lm0i1MX82sPgKHzCCE1ELWE2OWKsN9LyIdKLtuvRp8ZcjSHzq9jSmjpX/o1fMJrp1nDoM8+UOe7705bOwt66+5cdqfha1jBGncYia+nypIjuTQeqoEpDrcjekZE/l+uHugRHua7859z8WVS94vxL8mAoAe214tf6us/KQKq+XF92CCPlmcoleL22BmhAchmz87kYWzi6oC1ngynDArP+mBPcZg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by VI0PR04MB12323.eurprd04.prod.outlook.com (2603:10a6:800:320::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.19; Mon, 25 May
 2026 01:53:55 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Mon, 25 May 2026
 01:53:55 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 25 May 2026 11:10:20 +0800
Subject: [PATCH 3/5] clk: aspeed: Use dev_read_addr_ptr()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260525-devfdt-clk-v1-3-f0dee4083e82@nxp.com>
References: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
In-Reply-To: <20260525-devfdt-clk-v1-0-f0dee4083e82@nxp.com>
To: u-boot@lists.denx.de, Aspeed BMC SW team <BMC-SW@aspeedtech.com>, 
 Joel Stanley <joel@jms.id.au>, uboot-snps-arc@synopsys.com
Cc: Lukasz Majewski <lukma@denx.de>, Tom Rini <trini@konsulko.com>, 
 Varshini Rajendran <varshini.rajendran@microchip.com>, 
 Manikandan Muralidharan <manikandan.m@microchip.com>, 
 Balamanikandan Gunasundar <balamanikandan.gunasundar@microchip.com>, 
 Romain Sioen <romain.sioen@microchip.com>, 
 Ryan Wanner <Ryan.Wanner@microchip.com>, Simon Glass <sjg@chromium.org>, 
 Marek Vasut <marek.vasut+usb@mailbox.org>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, Heiko Schocher <hs@nabladev.com>, 
 Andrew Goodbody <andrew.goodbody@linaro.org>, Yao Zi <me@ziyao.cc>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, 
 Ryan Chen <ryan_chen@aspeedtech.com>, 
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: SI2PR01CA0029.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::8) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|VI0PR04MB12323:EE_
X-MS-Office365-Filtering-Correlation-Id: eecfa923-a56c-4cef-56d4-08deba007acb
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|1800799024|7416014|376014|38350700014|11063799006|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: Se06aq4X59HGf9c2Ut5eqS4UuNP4J/7X3Ec+AMzvhqT4xijG9CMTwLvy1/dGi9uIAf78E46nvDUPoUUi4mh96H3r8YVU7LFCikfHD1gl1zog1+Tn9OhKjmqsMq1fpXwYBWaeWaT2rnKjzqKgApHubf3kavsaPrD7N64NcpyT+hdw0TFZ3IWIEbRruLbUW1fNL3N4yey7Kdtu0K28bdJ4vxVn+00Z4FyUUJ2IaTQYwmqvGrSDeRxaVXOyoX+Wpc9gNNipQ7SDI4F7WiJbkfPuBsYQj1/cC6WxF9cbvkkN7L5tzJWqOhmm9MxbXkAIE7XQxqdLOOSprYJMVjHG2zNCB+YTjuw+gP5ktU/6RaII+Lr34iluevLrnBBCL1pwJx1EXQwA5eRw/AazCr4NuCBabJ90bNQJJIDvPRlmwWUmkTed09BJslYnWU/rs9gwKqzU6M3KIn6nHxbWauDceqi+tspI0smiXH72FHhkOUqZBhkcWUv/ByakQLq02idwLpDdobYqZvd3zBA2dyyqoZLUzHkSzaY8VBbRM/gCZaG18LRMwtecVwZmPr0wi6t3/r+oDprUe/gYkDU0kFLYf0k3I789z0wjFoE7/6+Bie4/qqCvwmZpNplM+WLSVWbU+FYGjDNlT/bAUzNE1FH8ykrEVNkaJVoVUIKbQ0bwLqmbfPEWSgRpONTGXHbGYRL8TYh+6l5POeYt7c0FytmxXdVIxzXGCPlCmFcjJiT8kMCxDhiz3Uxdfcgg2wDKV26SFdql
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(1800799024)(7416014)(376014)(38350700014)(11063799006)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDRUS21qY21oK2hURmpuZUdHTkQrWTlGd21UN3hzTlBTaTkxcktkTUIvSG5E?=
 =?utf-8?B?aGdmQlhjYTFWUFR4anI0ekNVcTZvVHRuOGQzNkRNQ002emVNS1FUbU9kTGwv?=
 =?utf-8?B?amtrSEtkcTh5TUdwSDhZK1VaM0NYNFlsNEE4dVdYZWNHVE9qdW55NWdpRUdi?=
 =?utf-8?B?cFhrMlZZNGZ4aUppNGlFZFB4YjJ6cDJVSTJPbzR0c1NwRWVEMER4SFJHK2FZ?=
 =?utf-8?B?VWx3L1Z0UE1iNllHclNLRjRDUUhEam1GQjdOTGFSdUxiSVV2VFVGK1hzc0w4?=
 =?utf-8?B?UUs4WUJYS0xTUEJvRk9pTnhyS3VNbWk5RnAzTjJuK0dxUm0vUDV5cFB2c1BG?=
 =?utf-8?B?bGQwOEVKQ3dwbmtYcC9rMDZUc0cxRDVidHk3NkZiOVF6bVNsdVdtdmtDQllX?=
 =?utf-8?B?Z0hEaUVhanU5UllTcXJhZVZTR3piWG9pUDIzRXNZQy9nTzFqNFY1eDVDS2VG?=
 =?utf-8?B?b1dDby9yN0ViNUozY3VscFBCZm1JLzJuVkhMTHNaSzVBeVVEbW1acEFkQzJF?=
 =?utf-8?B?YXAzTmRKbmp5ZDZVekcraTROd1VhK1VTWndteFZ6bVBhYUExelpxNnZNUkk0?=
 =?utf-8?B?ZmFwNjg0K0c0UmFQUXFOMWZYMHdaK2ZRY3AwRzRWOWFDeUlMU3BpeXUwTWFv?=
 =?utf-8?B?TVpSc0YzNmFZUXJ1K2h1WUtvUDFzdHJYUlpKV3NSYVgzUHI5YkRNaFY2RWFt?=
 =?utf-8?B?Q1V0eWtSMXdoMEh2NUdJRW1XbjNZT3o0czB5TlE2N2F3eEN2SzlTVkdQZ0lK?=
 =?utf-8?B?R1Y2Wm82ZUNHSU5GS0s1LzZKKzNWekdXUktWalFuUi90dXJzcXNBbUZqQUxM?=
 =?utf-8?B?YjNqZmN6ejhORWtOUkhHa3BKZ2RxTUZoOVk4NkdIYTdIOXZ3NERoZHBVNTht?=
 =?utf-8?B?NSs5ajRHSE43M0YvMFpsM1dyd3ZvQjlEaEhLNW1QUTFvVTQxOXcwSzdyNFRk?=
 =?utf-8?B?VkZ3UnlSS2RXRkorcE8zd0xLSSs0cW56a25kMUxDRzU3RGRMV3VVa3BVSnNM?=
 =?utf-8?B?NWV0MEU0eGZ3NEFWSWViNllLa1lMRE1TWGwrRlpiM2c1UHIxVEpaL1dqOEt3?=
 =?utf-8?B?VTRjZ015R2tKVWt1NGJjSnl6L2EyYk5Id1JEZ0NYNUpUd0lFbUlycWowQ3py?=
 =?utf-8?B?UEZyWm15cVBiQ0dZRUNVbEl2WkNhK3R0RXhUUEEzcDFSTTJodmxlNm9LeEZM?=
 =?utf-8?B?STlNeUxBK2xQNXZwRzBFZzNLVTNXQ2Z0VWs5YTRVdGowTmM2ZHFzTXd2RWdp?=
 =?utf-8?B?RktkaXNvVDU2eW1LSDZLOCtuSUN3OEVkT2c3aVpwdm9WU3B3M2h5dTRLUG5E?=
 =?utf-8?B?cE1MVUx4aFVWcnRyWCtiWUw3ZWowUTlXdWU0K3MwRkVCNHAxS2dmMHFqcStW?=
 =?utf-8?B?QU9kckw0dXlWUUZicGd5aER2aXczY0pOMG9MV2U4bytCcGg4ZFV6UU9UNFZQ?=
 =?utf-8?B?ZkdDcmdsM05ydmZvYUhkUk9NTW4wazkwYmVyeWtzQTg3ckNmZGxzUHdhVVlj?=
 =?utf-8?B?WWlwSmNwSW9pa2lXNktPME5BWm43RUtDalNoZk1jTkJoUEk0aDFaeEZBN2Nm?=
 =?utf-8?B?YS9UWGRaRVFNdFE0L29IM2kzNGM1VnZ2bGZqOHpiVi8wOXF6Q3dEOFNWRDZx?=
 =?utf-8?B?bzBPdWtiYXN1VjlJWGJxTjBuUmNDdzZScDF3d0RYckprQmdWM1pZMHVhcTJz?=
 =?utf-8?B?and3MERtOWlKSkxuWExGSlN0dzZqeUord001aTljVnNTNHJKOVFwYnBya2NP?=
 =?utf-8?B?ZGVtQnNRSmFhN0NoVndQc2xXUUhUblBSVHQ3aGxkUHBOSG1MVkcxVGJnbHl6?=
 =?utf-8?B?OVdBRnFzMUFCdDllRkVvbXNBaEZwU0gxT2duSTJ5RXdReHJ3aVVtQU9zWUVr?=
 =?utf-8?B?cUpiV1VyK0ptMnJsVWRwMnd4QWRqWDlkd1BYelFmM05ZNEIrMFhoK2JNcnd4?=
 =?utf-8?B?MWp4R3lBd0oyNXVESXg4MWI2YWhsdGIremd3WkJoUG8rZGdtaFNRbUkvV0lq?=
 =?utf-8?B?Y1VRTDFLRGkyMG1oMWdpZ3l2U3h2ajJuNjRPMnNHUzdPWTZ2Qk4rK0ZZQnoy?=
 =?utf-8?B?c3RJeHVpUXp4bWtoR1Y4ZE5qZkRwaFJ4eGdxTTdTVkRUNG1XN3dGTnVDc0wx?=
 =?utf-8?B?cnVmNVh2NVpqdGpwRE03WU41MlZOb3JwZXppQ21WUStwYXlaMXRGTENGQ0pT?=
 =?utf-8?B?ZkNOUXlsR3JQWkNTbyt5dVNuOUFBQm1ZWkdTdjlLWU1LZ2Q4YTVQeEZwaXIz?=
 =?utf-8?B?Zyt5T3VmVmdLOEd1OThOd2RiZ3d2cGVQWXFMazY1WnVVM1lCQ1I2ZTR6ejNi?=
 =?utf-8?B?Y003RDIrMTBOTVU5TkZxem9vcmN6dkNZOFpFVEdXNHRTQytYU3Mrdz09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eecfa923-a56c-4cef-56d4-08deba007acb
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 01:53:55.6770 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyFVR1GmnqeYxAq9Ewqr3j6gffcjt22fjCuk0jmP/9ZoYGs7cZjjpB70Norv/mxDKGrORFTTX1lS5fIuRKJzLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB12323
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

Replace devfdt_get_addr_ptr() with dev_read_addr_ptr() when retrieving the
register base address.

dev_read_addr_ptr() supports both live device tree and flat DT backends,
avoiding direct dependency on devfdt_* helpers.

No functional changes.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/aspeed/clk_ast2500.c | 6 +++---
 drivers/clk/aspeed/clk_ast2600.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/aspeed/clk_ast2500.c b/drivers/clk/aspeed/clk_ast2500.c
index b07d7cd419c..94c7f662319 100644
--- a/drivers/clk/aspeed/clk_ast2500.c
+++ b/drivers/clk/aspeed/clk_ast2500.c
@@ -544,9 +544,9 @@ static int ast2500_clk_of_to_plat(struct udevice *dev)
 {
 	struct ast2500_clk_priv *priv = dev_get_priv(dev);
 
-	priv->scu = devfdt_get_addr_ptr(dev);
-	if (IS_ERR(priv->scu))
-		return PTR_ERR(priv->scu);
+	priv->scu = dev_read_addr_ptr(dev);
+	if (!priv->scu)
+		return -EINVAL;
 
 	return 0;
 }
diff --git a/drivers/clk/aspeed/clk_ast2600.c b/drivers/clk/aspeed/clk_ast2600.c
index 4530053bc6b..74209e947ed 100644
--- a/drivers/clk/aspeed/clk_ast2600.c
+++ b/drivers/clk/aspeed/clk_ast2600.c
@@ -1174,9 +1174,9 @@ static int ast2600_clk_probe(struct udevice *dev)
 {
 	struct ast2600_clk_priv *priv = dev_get_priv(dev);
 
-	priv->scu = devfdt_get_addr_ptr(dev);
-	if (IS_ERR(priv->scu))
-		return PTR_ERR(priv->scu);
+	priv->scu = dev_read_addr_ptr(dev);
+	if (!priv->scu)
+		return -EINVAL;
 
 	ast2600_init_rgmii_clk(priv->scu, &rgmii_clk_defconfig);
 	ast2600_init_rmii_clk(priv->scu, &rmii_clk_defconfig);

-- 
2.51.0

