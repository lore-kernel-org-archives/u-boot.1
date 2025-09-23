Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 728C0CAC5AA
	for <u-boot@archiver.kernel.org>; Tue, 23 Sep 2025 02:17:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9968A8362C;
	Tue, 23 Sep 2025 04:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="XWoRzpqL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 36F2D8362C; Tue, 23 Sep 2025 04:15:47 +0200 (CEST)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8F40683621
 for <u-boot@lists.denx.de>; Tue, 23 Sep 2025 04:15:44 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bkvra+TBwtCpT8kAudG1mGGwd5mhqFUi7kgcSZwrLMlLCwUg9MVfDcqZ5BOXIqYLYVdZN3w0C/le/3fPVf4AboZV8IadD9+MvaUtSgfj5ziX2w5Oz/5MMloDEOvGvRfOJ3/hP8vzOQiHppR9CAZDmj+kkemvYY5ajdEkVB4SIYovaTSKTcptIEAHF4Pnyn5CNsZf1iwYwYLlwIsBnTL7VrXgjFU+hDbp7NoaEjlwLrXDOJD01Wlolm5VoWPrcZAxWdCV2d4KB0o4eiIk9tBfGC2g/1he4tioY72XrUil7xAnMTGAquTYNMhtc8NN5+qvomBxyEGGFxaVJa8P3MRZTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cblFkktCfzXKIVW5MIHT9kz611Pu9FOMcZsfVEtsPgc=;
 b=HQzGFuDD63skr8L21mtk8jdLXuyGfeGpCdp5oAiM3b4UGKSINrJWdAQK18dmJWdcUBeRwlqfVgHTKdOvqNKvjQDQCFaJBxIeTFpdIM7xYOPFlnpSBhc/X15DniVLQ9B/FyP9qdiNHn7eufQwfMnYU7IaqinYX7b3Y749dG4H+zcOWOOKHqS4Wlq5CeAqWTF8Pns6Ptpsq2e3pJAdd0gp23A0tmFs0JSCAhMGljM6HP0QISRRxfPzMNcQ1F5tcroO19qxnWMO63YSScD/coa9RVvhjgESPXmO/1PrDXMGxwSeQTA0mHABTTcf0SnlTm1kJSiyT+zJ2b4pVyF/YLAoNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cblFkktCfzXKIVW5MIHT9kz611Pu9FOMcZsfVEtsPgc=;
 b=XWoRzpqLwYR/QRXefaoOX+QXmMLch/RkyeHPnRmmO9SJJQ5D2syrRNwgKZs98rNCVJ38J83bhJ+bu2h+YAP6IkVW5/cbW/1AjTlbpndaPcOScu+Oa31prahcicEoTCRSWYOjzRbYJRZoy4qGQtfYWs0yxfDUbewtEuxCptFfMaF9eSS4bDb1iSBcS8kBQlgN25fKnOGGDQaTWNzuuJiQuKrcOD1XPFHXwyyf91HZEafhSVcpYsrAPWgk6xNqZmv/UyLIo2HgYeTrzK3T1BLSyEE4fLn8YS9xHVbedfv7rx5veP9yI/bWfiXEUOQi2VtLDb8sULc/CdpcL5k+525KtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB9835.eurprd04.prod.outlook.com (2603:10a6:800:1e1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Tue, 23 Sep
 2025 02:15:42 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9160.008; Tue, 23 Sep 2025
 02:15:42 +0000
From: "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Date: Tue, 23 Sep 2025 10:15:02 +0800
Subject: [PATCH v3 10/12] imx: ele_ahab: Add i.MX94 support to
 display_life_cycle()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-imx94-v1-10-cb3b65169048@oss.nxp.com>
References: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
In-Reply-To: <20250923-imx94-v1-0-cb3b65169048@oss.nxp.com>
To: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Tom Rini <trini@konsulko.com>, 
 Alice Guo <alice.guo@nxp.com>
Cc: u-boot@lists.denx.de, Ye Li <ye.li@nxp.com>, 
 Jacky Bai <ping.bai@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:4:196::8) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB9835:EE_
X-MS-Office365-Filtering-Correlation-Id: 54082ea3-950b-4485-f4c4-08ddfa4718f9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TWZjZXl6MExod01HaE1UZlpWZ05KT09xbm9CU3E4SjQ1ckYyQm5xZzRlZE5q?=
 =?utf-8?B?WWpDbC9IZ1ZrOTZlMEVQUEIzSU1uYzh0ZzlNU292VXU2TEpXUThVbFNDSE96?=
 =?utf-8?B?dHdHdlBiekJ4eGMxUjBFVE1xelgrMGE4QlA5MEVkTGd3MGhZYW85b1M3ZzEv?=
 =?utf-8?B?eDk1TWhYWnhtN1Y3NVorMzYzM0NhZXh5SUJXaFhXVGR1SS82aU53akxMMDc0?=
 =?utf-8?B?dWpCZUZSUThyWC9OanFoVlNCa1B6R2d3ZzJZNmZuVGdNVmJCc1R3b2dMTTJu?=
 =?utf-8?B?MEhPVE5xVGxBYkI2Rkx0U2FGaFBCUzBJNVQ0dWswWXlsR1RQSHY5dU1QczVZ?=
 =?utf-8?B?eUF6YnBHUzRRcDlJelkraGFQZjJ2MXJyQU5rRjNXN1RKenBlYjZaZGZvNnk1?=
 =?utf-8?B?RVVZMUEyQnBsRTFOeENCQWkvVDlzZWZCNis0ZWhINXcvRWNEbXdyRnhLR0Zx?=
 =?utf-8?B?L2tuV0dxdGFHeDY1c29uSVlpbUVCSzFCR0xiQTd6YndTczNTT0JtQ1Z3TzZS?=
 =?utf-8?B?a1FFTGh5MzUySFp0dFpDc1oyZWR0RjliS29aOVp2ckFUMVA1a1ZuNGlWTExx?=
 =?utf-8?B?cllmRWpaczBQTFowSGdjaGE1VEUwNmJNRklsdzhjWWNLenRTeEVUSFVqd1Uy?=
 =?utf-8?B?Zy92WDZYS1JwaTlGQmhwM1hiQ2Q5b2xpViswSDJvOU83RjZPN2lMdTZjRThM?=
 =?utf-8?B?WDlXcHRYenovRmgwbm4za0Zza1B6WDN0Mm1xT2REWk1NVzhWOWpWc1JBSnhO?=
 =?utf-8?B?aDgxT2lhNEswa0duUVZwMjdRTGdpNEtjYVBrWENZTndWSjhQYTRZbzNLdmt3?=
 =?utf-8?B?Rkt4MG5HTjhNcGg2Q2hjSjFaQUVQV1hIRDBOZU9ZWjRKVUh5NVYrQTl3MFBq?=
 =?utf-8?B?SnZMOUhNRlpCUUk1QkorZm15Vmw3eWJaMTJZVWhKcmxjMzUwUHk0WEk0TFBh?=
 =?utf-8?B?d1Z3NFlCTWxrdFAwM1ZoTStUMmNWcG5LQXBVT0J6aHdMOHBiQXdoK3dEZno2?=
 =?utf-8?B?Um1BRGluNTdZVkxrb1MyS2I4NTVqdlVTek1aUVUrNjFkTkRSQ1hPOTlPV2VF?=
 =?utf-8?B?d3ZYdHhZdkxaRlFQbDJmbldaYml3Uk5rdkhSNzZrTFBHZENxaGdFSW5ITlFI?=
 =?utf-8?B?dW9BdHYrdDVuUExoemUwZmNYNEtSOEIxZWRtTFBFdVBZWXFjWmV1MFlVb1Ez?=
 =?utf-8?B?enJIU3RuT3IxVHBJa3NkMjk2Vyt5Y0psbnBDSTBzNmpwb1RKdWh2dE02Smtl?=
 =?utf-8?B?NDVhVW1zOEZxNWdPN1ZPVVR4bGMwTnRPSEZYK3hvY1hwbERUaWtCSVF6SFdQ?=
 =?utf-8?B?bzVLQnJMaXUxckZQd051YkxCdk0rVlNjaFNGa3VDeWFNN1FnZTFrRTg5WHQ4?=
 =?utf-8?B?NVdhei9BUVE0d3ZFY1dEeFlnOXJxaHB6bTV2SFVmQWNHRDlialN5NFVxUlNR?=
 =?utf-8?B?QlhBM0x6STNTaTVCdjN5dE53MlFEdHFVT2pHNWkwMHJ5RzRGVGZ4WlZ5aUdH?=
 =?utf-8?B?ZmhFcHhPYVRJa2RlVkppTDVNQ3dGU3JYRDlTVUdKU3Z5U3RUaVc5c3hNUDR6?=
 =?utf-8?B?N3p1UkZwTmxEZGdoRittRjdjRFpCV3dnSzlGS0JuZ0hPQTNDd25EVVhQMEhn?=
 =?utf-8?B?ajFuZmEzRlEreHhsZEhxL3lobGw5R0x0NHk4QVZMdFBFVk1kYWFETHZ2ZitQ?=
 =?utf-8?B?bjJnMm1OMVRiME1JNklvcHgxQlB5WnQzR3YwV3RpcTQ3SG1tT2hUeUg0WVNE?=
 =?utf-8?B?Rk1lL2pDeGlvVFRaT05QRkZvQlVWNHo4RXJnQWJON0tCYnNRb1VBbHZZR0ZL?=
 =?utf-8?B?ckY1U0JEVnpOV0hxcDNEdnZYUytpUm1ZSzVjMmxUb2xFYWFickRId21aUldF?=
 =?utf-8?B?Uy9NMEZBQURmK3czVExtejF6cGxpUCtvZ0pHUi8zeER1WGRJNkQ5dFErejZI?=
 =?utf-8?B?YVh4cXhsakRYRU9YZTBRMkNYSFVRajQ5S0gzeklsUjUrRzVkeFFpTUFGNXhU?=
 =?utf-8?B?c01waDYrN0l3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MXdwWkttNGpMYUdGaDhPNVM5eFEwUHA3YWJzc2h3SllUVytFNU5QSkVDMDAy?=
 =?utf-8?B?VjNsVHZ0ZmQzYkVaV2JWSVcrTXU1cUlldUhKQ1M0c1cycVdCTDEvN0ZxRTQz?=
 =?utf-8?B?WmxKb3ppTTZpeUJCSG1yaGVZTmY3Y3A5SFBMeTN3dlVEckFUQnhWc2JYZE9E?=
 =?utf-8?B?aEtHZ2NZOFpZZFl4bU45ZVVYOUVrQThCdkFYZks0T3VzU0F0SG9odHVONTQ3?=
 =?utf-8?B?YitHOU5kTVY3bTl5aTg5akJreEtGUnJhRTRtRFJkZ0hjazNtSksrZ3ZiZUdK?=
 =?utf-8?B?RVFpZlh1NDh4RUg5NlVJanJZZ0E5WmluR2h4cmR1Z011UGZXbEdueHpMdi9C?=
 =?utf-8?B?U2tVUVBLU3Y5VmZIWCtSQ3lINFlQdUoxMVBhOU02WmgybjA4YkVlOUtpZjRQ?=
 =?utf-8?B?WXlQUEFETXE5b2dScGF3djNhNXJ2Rk9DdWdzNjc5RHZhYVNrdjVYM1hNNE5F?=
 =?utf-8?B?RzlXa21yay8wdWdZK2dmMjhsOHRjaEY3TjBidHNUamd4OWRlTHRZS0ZiOTg5?=
 =?utf-8?B?d1c1ME9QdkhTeHY4K0k0cGdEenJrYkJnRUZMQlBsNDhtT3ExOWtKOXVCQVQ0?=
 =?utf-8?B?M1JGTnJTQjRyZ3ZFK0Rsdk40ekF3bkRKeXN4UlovMTM3NjVabHl5cU51dGsw?=
 =?utf-8?B?MHIzeXVadU9UTU05dlJCaWdPYWpaQmsxYTkvZGFWdmZIb3FxWlI0WHZBQWV2?=
 =?utf-8?B?RHI5Ukl1Y1hRdGdLU3AyMkNWV2taRGUyUENwQ3pXS01iazNLWmdSdzcyMVVK?=
 =?utf-8?B?NzRIQU5wb2FqRWlCTUZUbnRndWJMNWd5eUdzcGcyUmxxVXN2d0phSFkwTmcw?=
 =?utf-8?B?ZVYwMG5HUGhILzAya3N6Rm80NnoxUTBWc2lDYlJESzQ2SjF0cFBqNmM3Nk0y?=
 =?utf-8?B?UUZWclVpTFdaTHl5TFV1TUNhNFcxYkFpWG9rbkxucmhBRks4T0gxWUFQeG5I?=
 =?utf-8?B?QWxLajNhNDdUL3BtVUo5ckZQa3E4QW5hVmJuRlkxWXJRL2gxK2xxTkduTGhh?=
 =?utf-8?B?T3ZqYnlYNm5jN3l0ZWExNTNSWGhXQ3gvQWh4aUErL3UyTzdIOGYyZEFIRVg0?=
 =?utf-8?B?ZTg2dGFlZFRUSkNvY2lDeUZlTmN6bDVVUlpxUk53SU52TzNKSWV3YnZ6QjJK?=
 =?utf-8?B?THhuMG42MllkL3NkMGZibWF5cjFucDdCSTgzMStOSXZ5Z2tUSkRBcHVrWFJm?=
 =?utf-8?B?UERTck5aRlpPMjdISjNwNFRGbkhXWkUxSUNqdS9yaERpSE9CQ0M2enNGUlpO?=
 =?utf-8?B?MUtBQzI0NWdTckJGcHNmQnVmNGlXUTRXMitOZXhUM2ZYTEw4RyttcWhvOE9n?=
 =?utf-8?B?bVZORE9jRWtqMmxXeUpHT3hqUE9KRW41VW93dzFQUUhIcjRpa2Z0di9GUlNo?=
 =?utf-8?B?dHBIK1FKcDFkSmNsTVVjVGNFWkxxb25Xc3BLNXZmMkQzVmFRNDRyeTFEenh5?=
 =?utf-8?B?TCtFdUloTHZodTQ1M1cwS1dsNzNhaVZvVlZrQ1BxcXZQckRTaDNSaEdwd3d6?=
 =?utf-8?B?L1RRTUxoSE5WSHg0eCtnblY4WEZ1MFdQMHA3NUx6YWNCbHZZVVJDcDg5U2FC?=
 =?utf-8?B?aVBHL0NnUHZQVTk3ZW5YWlp6QjdzQkxUZlVQWFAvTGpBZm16UVdiSG1CclVK?=
 =?utf-8?B?Sm53MmFCbklIay9tVStDbHRCSkhCSXBtZTNtZGRDOHk2dWZZVm5Fd2VqWkp4?=
 =?utf-8?B?NXdNR1BhQ25MTkh5SVpEcnlyZkhJblF4SmlUUjFQRkMzS2JkVjJrT2V1N0dG?=
 =?utf-8?B?MzdlOXRCd2EwZE8yWFptL1loUzVzZ1luY0JZeTcxTHMvQkdNcnphZGlzTWIr?=
 =?utf-8?B?bTZlVm9hM3RDREJ2WDkwSXFLRXNTUkdOazAxQzlYUGVVL2hMK3hYUHhmMHJC?=
 =?utf-8?B?Tmh1ay9LditWeTVSL0xzcHdQUzdjelJwdTRwWnN6NjR4Qno5ekEzOUZIdzB2?=
 =?utf-8?B?cHJnVkVSbUhEejlSeWxKVjJOZXRHbEtVZXMxa21hNzN0bHJiZnRaSkt6VmZX?=
 =?utf-8?B?KzNFVFZWWWhnbG9sVisyU1lpZWE4czJHVFFSTm1YNGs1QjVteEJaMTJHbDBr?=
 =?utf-8?B?L2JjMEFBd0g0RStTSlRyaEZlVzBabUNUbDY3TldoL0NSVzB5WUJZbGpkaWJW?=
 =?utf-8?Q?bFdGOrgTFc5xNnZi4xmSoN7Ij?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54082ea3-950b-4485-f4c4-08ddfa4718f9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 02:15:42.6416 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eu+l6bqoUExPNqw4aCa3tNnW/RepkQQVL2VGJXjFuXlHvCZuA+zg7JO7gt8tN7caQWYOs6xtvMoBtuubHOVJCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9835
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

From: Ye Li <ye.li@nxp.com>

Extend display_life_cycle() to support i.MX94.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Acked-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/ele_ahab.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/ele_ahab.c b/arch/arm/mach-imx/ele_ahab.c
index 39aba65d29e..38e671e3935 100644
--- a/arch/arm/mach-imx/ele_ahab.c
+++ b/arch/arm/mach-imx/ele_ahab.c
@@ -411,7 +411,7 @@ static int do_authenticate(struct cmd_tbl *cmdtp, int flag, int argc,
 	return CMD_RET_SUCCESS;
 }
 
-#if IS_ENABLED(CONFIG_IMX95)
+#if IS_ENABLED(CONFIG_IMX95) || IS_ENABLED(CONFIG_IMX94)
 #define FSB_LC_OFFSET 0x414
 #define LC_OEM_OPEN 0x10
 static void display_life_cycle(u32 lc)

-- 
2.43.0

