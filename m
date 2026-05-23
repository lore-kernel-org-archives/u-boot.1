Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC330CD5BAC
	for <u-boot@archiver.kernel.org>; Sat, 23 May 2026 12:24:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4828848C3;
	Sat, 23 May 2026 14:23:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="IoTRUebI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4F93384881; Sat, 23 May 2026 14:23:19 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 43EB884881
 for <u-boot@lists.denx.de>; Sat, 23 May 2026 14:23:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=URT3MIpemFjeNfYVgY45Sh/BICsbwnoyFHZvATyvP2A85ilHHs5rC+YYCkpqeTGKxzSUl9xyRiT5QEyuE1T4WY50lpI0JyK5JyseYTIa3Hal4iw7JO3Xm5OBnYFWfX1udcICdh91jlLMXmsq6lViQIwg0CqwRDaRXwYqpfUrM+FuJ3jAQHQNLwS1MECxLQ0jL1WHfpKGBB3fID64jo0AdcEmLI+S9uIMJhOB18uCePnznHUAmO4S991KlvnrQchyM/fJXaJsO6fHmspOZsPIXbyVuQ11IuonuwX0Xlmm6QWSP7D0NV8X7c7FZO3BpZJVG+dOrWEUFji1KILjTwKvgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NidWQ+/cwRzyHGEeVBSt+hUW1cClTRUCFJFcWrLWG90=;
 b=cmjPrFffuXsFAFDbH7dsOYWhy5OmFeltLgon1xKZO7hDKnw+ged0Ms4KZmANMcwEkBvMUl5JzCnFFBKO+peRtxKYMooNj76+E36YwMQ7iDrKIfgOTEAFc8xU1RAF+HZK36bOyMVVKzBvI2dGHehkP9OO1PnzXjhrLVz2BRC46MEQxRPh5oHevX9tZ8OlOYsNbXJy+BsKtpzYmSj5K7XYZ0fqf6/Rl4CyW10wpz1hSEfIYYcen0SpY8jPgP46cf/n8x40qHeB++q1U2qU9iliP0DNeg5KChKK3Fx0urdWTKJMsX053flXnXGBVzasTuYN8gfI7orQV1qma9sSWKWI0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NidWQ+/cwRzyHGEeVBSt+hUW1cClTRUCFJFcWrLWG90=;
 b=IoTRUebIzYJJOraoM2ouCDpIKETO8VjHS/+txYM0HdYNtlliAEofKdpidiSux55EKpib/h2RegpKp7o3Qr1xjBXC80F+7qXajUDRF5bgFCJKHsYk73ZfneTOiJULfq3Wpr//JAgUgw70dc1P+ZJwowZYfBLHa8MHbf7a6waV+CSQjglo5d32+4AaVon5cXytLLROakcN39sSfOWod4OOHJTxXfuzJB4+N6BYCmxRIdUfgNP7rU6MsWaTPrV8+WZFBI/lqKcUnOaDBZxAry3i+3cbSisEO4NXXTmMjz0AJuqDGFf1urTiuZ4wKOVVEorOutezlGW49q0ygabcxW6Iwg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com (2603:10a6:501:7f::23)
 by GV4PR04MB11976.eurprd04.prod.outlook.com (2603:10a6:150:2e9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.18; Sat, 23 May
 2026 12:23:15 +0000
Received: from MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889]) by MRWPR04MB12330.eurprd04.prod.outlook.com
 ([fe80::ca22:f8c8:6aca:7889%6]) with mapi id 15.21.0048.016; Sat, 23 May 2026
 12:23:15 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Sat, 23 May 2026 21:39:49 +0800
Subject: [PATCH 06/13] imx: Guard print_cpuinfo with
 !CONFIG_IS_ENABLED(CPU)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260523-imx-misc-v1-6-2898c9eca9f8@nxp.com>
References: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
In-Reply-To: <20260523-imx-misc-v1-0-2898c9eca9f8@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de, 
 Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>
Cc: Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.3
X-ClientProxiedBy: MA5PR01CA0255.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:223::6) To MRWPR04MB12330.eurprd04.prod.outlook.com
 (2603:10a6:501:7f::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MRWPR04MB12330:EE_|GV4PR04MB11976:EE_
X-MS-Office365-Filtering-Correlation-Id: e4fbb8df-c5de-48bc-cdc8-08deb8c6108d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|376014|52116014|1800799024|18002099003|22082099003|56012099003|38350700014|11063799006;
X-Microsoft-Antispam-Message-Info: yAcgwNBXd1TbLPbLKwZpsQslB6pvs1dzwfI0goqV3RS9gW4ffkM9/Mel1LT5OPAiqTb1YxQ3HAf6v6eoO6Ji1iW7DPMlYQsKlRxtYzVIhqdxx1m9zW5MiYWaA6aClcCxaGbKvoHppPGJCnZ6F/x+x8WbEJWcZhTRB0xT5e85fu4vPO3F9H5HC24nLJTkMG0ObrHkQY2NwHn3ngGTgWTYqNrs4c/hxLIFlQiAp236MGQrkaK927+gpiBOehd1bKiqcsxo0tnUl5qNXyTBgQ/2TKDn5wojSlsXhxK2C+pJQtMWsTKRu59il8m9zHS4VV76JF+gg0xE8AMOSfsWiCRxgi+KrnPP1ZBmYUGoSKfyEospNIR3jvN6I2R0XOzfPsXEvVZISMk2P8g2VXfSywy49ecTjYRSKbDc3gIq5y8wt/wiSR5mKbstpDTnejZf3GmYl2n3hYboXtA7Ak2avSr9ICmuUVJs0FQl4kQOBN03D7WmOcxk4jcHmR8IH4NTBrgXt3OSe8mjcNLL9+Izs09i9jHFbs2RRfUzOcJARxeHWE38hCBYv4lLqiB7O+WXJ1q/hb11U6X22q+ODRi1dAfmF3fsbxZqJK3UhSa9W4p9wvpJ22lNXqlVMZxzPtBULVy/3ws6eNOnlwXnf3I8CdsAxUcN21MdU0uFELwtbu3jMyqrHoj6ui+x9C9XJ1Q8d67gIsHmcZPoDJlftgS2BceQj87MBlW6TxMXc234Lq+VFWJgS30iivSvkYdLFe6fZkaT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MRWPR04MB12330.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(376014)(52116014)(1800799024)(18002099003)(22082099003)(56012099003)(38350700014)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUo0dVBDZkNaY3EybytaWkFvdklDYm0rbmswdThiTkU1ejRWQmNKVzkxdnlZ?=
 =?utf-8?B?eXBUTEUrZlljbzEwQzI3M3NWVnYyakoydmtybm4yZXA4M05aN0NLeUpCdVpN?=
 =?utf-8?B?VjMwUDhCeTdGV3NyS211bFVXUXRWV21uTCtneEVXRFpWc3BSUFRwaFBkNkll?=
 =?utf-8?B?ei9IaGRhYVczem5pdGVpV2FEVkxxc21zczQvWDRjWUd5YU1BSUh2bHUyRUor?=
 =?utf-8?B?UUNrUHBmQVMwTmVqcTlrSTNVbDlQKy9QM1hHS0NrYXZNNGFqZGlDaGdydmJx?=
 =?utf-8?B?Uk5LOE80VkExRzM2S2w0Nk5JMTlHYzB5bzI3cm1WSlMyeEFDcG1xbUlLam9I?=
 =?utf-8?B?RHVHMDJMb2VUMUc2YmhVSW0veUhrWTBXWnBKQ3NSM3l3bXVHWDdoUGJjVlYx?=
 =?utf-8?B?NWRET1BUdFg2M0hRWXBSeDNaUFFxTWNMSmxveEVoa0w2U0hGeWt0T1dld1BS?=
 =?utf-8?B?THlVVjJCTTdoQWFET1RVSmFQblFBNWhxNEkyL25DTUdTSmJrazE4bG0wOXdV?=
 =?utf-8?B?dHVIbmJIQjZvYkVFcS9kWEEraHZwcDIrQ1lrQWtMRHNsU2cveWo5emVnYlFj?=
 =?utf-8?B?R0pENGNpMU9kQU1HUVZTMjNseXRnWk9sb3FpNWpLYUxmekYwN3Aya2xkb0hJ?=
 =?utf-8?B?WXdqc21WMkc1bDNBL205aHJmNzB1U1Z4WkxnV1dlWkhLZDlmWlQ0cis3MjA4?=
 =?utf-8?B?Z1dmaWVlcFVmOXJ3MkZNdEhWTlpjTVFraSt1eDdPSFY5dFBrMHlxUnBTVUda?=
 =?utf-8?B?bURsbVZ6NnFWdDdrZlVkWGJiSWJ5UWFHbFYxUGkyYUw1Yi9zQStNUThHVUNR?=
 =?utf-8?B?TU1rYmtWV2hpWFMxcjNVSjVUUFQydnExb2V3RWpRZTN2bC9aT2pxa0hBQys4?=
 =?utf-8?B?NmVKdHpobXNZMmIxOUhhTzBBWjRwcFN5VTVjSVdEeURHUDVLQ3hGdDBtM0RG?=
 =?utf-8?B?TkpOWkJ3NG1FQjE5bkM0TExKd0lEdlNCalVlWGloVjZ5eW9Tb1Zrcm9lcWdL?=
 =?utf-8?B?VWN4Y2lnSGZBdXlTWnE3cndWSG1nT0txT3FiRlBPNXVkR3JCVGpPRFNXdU5S?=
 =?utf-8?B?UWl3UGVRbktQSnpZMWEzcEpVaXNqTHJYS1Q4K3VxUzl5bkFhdzd4VENGWWM4?=
 =?utf-8?B?cm1lWnFlejlpUUxzeTRkZCtEY2tpS0hmdXBUZDhjREwxMGhVb29zalZyVklS?=
 =?utf-8?B?bEpXQm4vamNRSndlbFdWVDI1WnJqQk1hN0tlbWhMbUVMRERsWGNzdVU0ZkNJ?=
 =?utf-8?B?R2FnQlVla1BkbGtDU3QxeUZFejFSbkE2ZWhGWmlDeVJUL3E2VkRFaGZhT1U4?=
 =?utf-8?B?WWN4dm9GY28xS1VEYit0NDlpZ2tJMVh0WmFGN2ZhdldLV1c5bW9GRHY5Vkp4?=
 =?utf-8?B?OW1Yd0pGTklPRVFTU3kxYTRsOGh4TVVVSXRMbUozd3NxNTFFSVNXaTh0eVJK?=
 =?utf-8?B?cEllTWlmclN6Z3gxVVJ6ZlIvWjEzb0dISmRPTjFQemx0V3FNK0U0SGJmVkNH?=
 =?utf-8?B?b1BBdVV2RUwrdDU3TTRJYVZHMW1VblFSN0taQjFBSW5CYWJNb2U1c3F5QTBz?=
 =?utf-8?B?TG9pWVgydW9RQ1g4WHNpcTlLNzNNem9kdFFXTHd0Yjc3b0VidWY1dExuUnZD?=
 =?utf-8?B?WEN1UjVxcVlFbVhyQ3FGRXpLYVEweEZKYS9Fd1djRVdkZXd0TGZsbDBnRGJ3?=
 =?utf-8?B?Tk5VV0d1UnRtMnhTbjZRbksyMEhOYzhmN0JvWmNnYmVLTFkyQjR2OXNPVGxJ?=
 =?utf-8?B?M05EWjhoaXUwcG82N3U5KzJ3Z0ZReGJmelZrTVFKK2ZUaCtGY0RRR25XRTUw?=
 =?utf-8?B?VnZVWEhObjJmTksyYkxjY0Rwa3RIU1BJZjU3cE5YZCtlTXhpdTlvdmFuMkZP?=
 =?utf-8?B?b2ZaNy9Ob0lIWTdlRkRLd2xzYk1HUytmbXVEeGZNZHFpM0RLditJS0dDd28x?=
 =?utf-8?B?VFBTNTViRXk4SUhTamdQQ1Z2UzFXRElPTnlFYk0zTlY2dG9aUkVwNWV5dHF4?=
 =?utf-8?B?ZitZOTB0dEYycWtiQXYyckRGSGFUN1ZDNlhkTFFwNjhPaE9RSm45dVNjemxw?=
 =?utf-8?B?bE5DdXo0Y0JOVDZmZFZyZzR1Z2F0WEZqYzRrQmo0ZWN3enkvM282OGpnQjhS?=
 =?utf-8?B?RWtSSDE1T2JJM0ZHUnQwc011UXpNYVhiNzBjNUZSRFpBZ2dlbGZWdVNlMnRp?=
 =?utf-8?B?V21GUGVXUWNPejlpdERkK0grRTNFWU9IdVROSHJ0L0JOOXVpRkhpb3ZVdWIy?=
 =?utf-8?B?aURlZHo5d1NxN1JCSUxqZ3NDMVphZnFTNTJvaGZQZUI3Ym5jZHU1a2xZdEVv?=
 =?utf-8?B?K1NqUFZXMzcyZ0ZjN1RsR1RoL0doYUVyZjFtTXplSktaWWdtWDZCUT09?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4fbb8df-c5de-48bc-cdc8-08deb8c6108d
X-MS-Exchange-CrossTenant-AuthSource: MRWPR04MB12330.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2026 12:23:15.4744 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VzDB7uENTH9XGWNK1OA/VrkP8DASAOjAnbNc8WYSD6MZbag/RsKwlXp+VWcs0zP1j4aysxhc4kdlsoGrAKUw/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR04MB11976
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

When CONFIG_CPU is enabled, print_cpuinfo is defined in common/board_f.c
with static property. However in imx cpu.c, print_cpuinfo is not a local
function, so guard it with !CONFIG_IS_ENABLED(CPU).

And all i.MX8M boards has CONFIG_CPU and CONFIG_CPU_IMX set, so remove the
dead code.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/cpu.c | 56 +------------------------------------------------
 1 file changed, 1 insertion(+), 55 deletions(-)

diff --git a/arch/arm/mach-imx/cpu.c b/arch/arm/mach-imx/cpu.c
index 8af45e14707..93be5644c88 100644
--- a/arch/arm/mach-imx/cpu.c
+++ b/arch/arm/mach-imx/cpu.c
@@ -47,7 +47,7 @@ u32 get_imx_reset_cause(void)
 	return reset_cause;
 }
 
-#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD)
+#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD) && !CONFIG_IS_ENABLED(CPU)
 static char *get_reset_cause(void)
 {
 	switch (get_imx_reset_cause()) {
@@ -75,11 +75,6 @@ static char *get_reset_cause(void)
 		return "WDOG4";
 	case 0x00200:
 		return "TEMPSENSE";
-#elif defined(CONFIG_IMX8M)
-	case 0x00100:
-		return "WDOG2";
-	case 0x00200:
-		return "TEMPSENSE";
 #else
 	case 0x00100:
 		return "TEMPSENSE";
@@ -90,59 +85,10 @@ static char *get_reset_cause(void)
 		return "unknown reset";
 	}
 }
-#endif
-
-#if defined(CONFIG_DISPLAY_CPUINFO) && !defined(CONFIG_XPL_BUILD)
 
 const char *get_imx_type(u32 imxtype)
 {
 	switch (imxtype) {
-	case MXC_CPU_IMX8MP:
-		return "8MP[8]";	/* Quad-core version of the imx8mp */
-	case MXC_CPU_IMX8MPD:
-		return "8MP Dual[3]";	/* Dual-core version of the imx8mp */
-	case MXC_CPU_IMX8MPL:
-		return "8MP Lite[4]";	/* Quad-core Lite version of the imx8mp */
-	case MXC_CPU_IMX8MP6:
-		return "8MP[6]";	/* Quad-core version of the imx8mp, NPU fused */
-	case MXC_CPU_IMX8MPUL:
-		return "8MP UltraLite";	/* Quad-core UltraLite version of the imx8mp */
-	case MXC_CPU_IMX8MN:
-		return "8MNano Quad"; /* Quad-core version */
-	case MXC_CPU_IMX8MND:
-		return "8MNano Dual"; /* Dual-core version */
-	case MXC_CPU_IMX8MNS:
-		return "8MNano Solo"; /* Single-core version */
-	case MXC_CPU_IMX8MNL:
-		return "8MNano QuadLite"; /* Quad-core Lite version */
-	case MXC_CPU_IMX8MNDL:
-		return "8MNano DualLite"; /* Dual-core Lite version */
-	case MXC_CPU_IMX8MNSL:
-		return "8MNano SoloLite";/* Single-core Lite version of the imx8mn */
-	case MXC_CPU_IMX8MNUQ:
-		return "8MNano UltraLite Quad";/* Quad-core UltraLite version of the imx8mn */
-	case MXC_CPU_IMX8MNUD:
-		return "8MNano UltraLite Dual";/* Dual-core UltraLite version of the imx8mn */
-	case MXC_CPU_IMX8MNUS:
-		return "8MNano UltraLite Solo";/* Single-core UltraLite version of the imx8mn */
-	case MXC_CPU_IMX8MM:
-		return "8MMQ";	/* Quad-core version of the imx8mm */
-	case MXC_CPU_IMX8MML:
-		return "8MMQL";	/* Quad-core Lite version of the imx8mm */
-	case MXC_CPU_IMX8MMD:
-		return "8MMD";	/* Dual-core version of the imx8mm */
-	case MXC_CPU_IMX8MMDL:
-		return "8MMDL";	/* Dual-core Lite version of the imx8mm */
-	case MXC_CPU_IMX8MMS:
-		return "8MMS";	/* Single-core version of the imx8mm */
-	case MXC_CPU_IMX8MMSL:
-		return "8MMSL";	/* Single-core Lite version of the imx8mm */
-	case MXC_CPU_IMX8MQ:
-		return "8MQ";	/* Quad-core version of the imx8mq */
-	case MXC_CPU_IMX8MQL:
-		return "8MQLite";	/* Quad-core Lite version of the imx8mq */
-	case MXC_CPU_IMX8MD:
-		return "8MD";	/* Dual-core version of the imx8mq */
 	case MXC_CPU_MX7S:
 		return "7S";	/* Single-core version of the mx7 */
 	case MXC_CPU_MX7D:

-- 
2.51.0

