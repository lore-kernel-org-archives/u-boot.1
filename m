Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C554C02185
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 13:31:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B840280713;
	Wed, 15 Jan 2025 14:30:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="oGwshvv2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C4A4F80753; Wed, 15 Jan 2025 14:30:17 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260e::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D7A02800C2
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 14:30:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y91Ob+LPNAicyrpmpC34wEuJHVLGJsVTY1FvzFhWIESaWyu5BLkSPrHCL0uFeOk2TqW1Vhaax+N3LOj7jewVf/ghBxGNc/JxHXSbxkVBDvlXwZJ4BKsc158H07InEYdsG72BEXXzXxZNqdbjumAeiytxaR1KUWN5f31+BzoODnLyxBTZwwj6H7CWsmgeaLwwBgXrUwE92nc/GS7aObqukBO2h7Z8lsV9WjUQXClNPStVXpE9Y/q/mVSwW/WlHVmPQggwec2ESE18tc8jGDFjdsrkxePp7ckiKgSpqsnrmAhxl2N5b5H5BxrxhyYq2EF6fChCcPGxinQhjhwm3SmjiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzIS+EorfZphE3L8vZkLouOGYwj24TBhySa75d2mYo4=;
 b=eWQAlIV6hdEncmBGqf/Gs4fqzj751NAzv8lr1Wta1N7wcwvyEi3vRX9UCEai6z41NH9DIbu9lHtejWSP8y0AsYqdgYWXAbxsKSFgSR07C8FXrBCmur27epmyuIH7pOcN6JhOKyeM4hZz4746wKNKGtk+EPQ7AHXfEWipJVjUqh9VSJ6nB8gaWZe1cytqH1S4X06LoddlmUWWVFPBDs7PnPnvl4Psv3aOTxudkuFyp4fDNe3nvphbCPuLIZ2S7Fr7aIuv79VrJ730ZrcXnkczEtP3SIEShWP0GPxxb7ccILkx3/9pWUihDTdCYcRf+YfqEpiSDgS2lF2QoUbu3YYS6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzIS+EorfZphE3L8vZkLouOGYwj24TBhySa75d2mYo4=;
 b=oGwshvv2401li0lJ/hHdFSlz0w97fuJTtjxiho/APupXv42cgxJ9Uv3ckXHf/AFAmTg4nw2Gd3DuSkqiUuF+SvnrZjxUVEPOAC5rTUmTWXCIO9di0z9tVBJR4nmGp/zatxv5+O5IeibDlYKN+TUXncihryh3pt8WPd7UH3k4VtgHBbxCCs00eIXZtY4vo4LXzvYIL3+zbuXnRI6zoYLUwoL6JhWZIHGisTErxoKZMSonmCbuySRdL2n7SsJmJaAtvakR6QdSNJUYQgx+6dmmOb7fjND0xIeivi3K3TFBDXE2RQ82euJqfiYIlH478mRzTPZzz/OTC99cYCpCZPpJgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7764.eurprd04.prod.outlook.com (2603:10a6:20b:244::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 13:30:09 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8335.017; Wed, 15 Jan 2025
 13:30:09 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Wed, 15 Jan 2025 21:29:02 +0800
Subject: [PATCH v4 15/20] imx: Kconfig: IMX8_ROMAPI is not configured for
 i.MX95
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250115-imx95-v1-15-93b28a514dea@oss.nxp.com>
References: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
In-Reply-To: <20250115-imx95-v1-0-93b28a514dea@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, marex@denx.de
Cc: u-boot@lists.denx.de, tharvey@gateworks.com, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1736947742; l=838;
 i=alice.guo@oss.nxp.com; s=20250115; h=from:subject:message-id;
 bh=qFnDLk5UGg3n289p9q9s+aG7DJldt3JWcpA6cpeJkUc=;
 b=fSByIXNBEobpQa2LP520Lr21bc3ed2NjnR7EZqKtbN5zFuj0/8NShBQL0fXaT+Yd4xBjXk1lR
 4a6IRC/g4GpDZvhWTLHRvxLI16dXD+Q2ld0b2GhUfdUX9MHaeyhYj6n
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=MQFotjdbgvdbpnpHmN/PUzfJXX0wchusR4L7yfs2VZQ=
X-ClientProxiedBy: SG3P274CA0022.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::34)
 To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7764:EE_
X-MS-Office365-Filtering-Correlation-Id: ce11ba25-f253-401e-ad9f-08dd3568bb85
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|7416014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RjFNL1J5R054U1lTN0NmUkxsNkFCSEdGUkJ1cmE2TnhLOFZWazBoc3FMZDBu?=
 =?utf-8?B?Y0t6REI1QzZZMi9uTzNkU1JCZEFPTmNNZUJnVUtOMkgrZlVmQldlbi9OQTdY?=
 =?utf-8?B?TzUxbkY0c2I5ME83OE5GRjRmYitvNnAzMGp1Q3lXSG5oSDR1aXhqSDFiYSt1?=
 =?utf-8?B?S3A4L29iTVQzQWhaR2VDMFQrclJPRnVpZFhNVG40L1dLeTQ1VTNYRHlLZEpJ?=
 =?utf-8?B?VUtucjdHT3VMTW1vakVuSUJkVmVkSUc5QThaYjkvWGlhQkZjc0YwZDkwVGxi?=
 =?utf-8?B?eEpTbGtheHZaWEQxcVBpWWl2QWlKSGRmODlWV2pOVWZlVVlRQ2J0UWJxVlJQ?=
 =?utf-8?B?N25kaWZiMEl0Q2poSCs2MFJJbDZ4bjFqc3FMa05NVE5NR3htcmpDTWhpQ25T?=
 =?utf-8?B?ZUYxUU5KQjVGNDB5TXZ3RWxnUGJDSDRpeDZjWXRtcElFdE1kMzJNY1JuditQ?=
 =?utf-8?B?UFhrRXl4QlFicXJwSjZwa3BOZ0dSbHdJclFpU0R2R1RkQS9XQlh4ZHdRYndy?=
 =?utf-8?B?cUwxYWszTkZpcnBKR1M5Qjh5ZWQzWng4dkJDUDlGQlVONDNOWm1zT0RmRWV3?=
 =?utf-8?B?QXRybGFraHVhTEZRdkxhV2hwWWlOS3NwQkRCSW56NWdBNUFCVVVqZzNzK1ZU?=
 =?utf-8?B?YmZtLzBZdVd2NGx6SEVmbldZRllLNUUvV2NlSWFKMUdjWGxYakZJblhRMzY4?=
 =?utf-8?B?eFVaSm5wQTNFTUtSUDdzZ095R0RvaS9MRmQyWW5FdjNzRk1lZUx3a3lNUHow?=
 =?utf-8?B?WlcwdHpVNDlmMTRzS01OZDhqT2ovanFSaVRmM0RsYkZwZ2dHKzROV1BXL2lR?=
 =?utf-8?B?NlA4dVRhRTViNU41VkcrWGxjdXkrQ0FaVU1OZkFCWjg2TUZqdUg3K3VmVTh6?=
 =?utf-8?B?OUEwQkZvQWlGZWJwbWFnTEtoT0NackhjNGdPeDd2VzF2NE9UYzhnZENEaitz?=
 =?utf-8?B?ZE5LcDlyVDgxMXp6M0JoRFRUVjladWdQWEZ4eWYxbGNEK1MxUmlFajAyWjZN?=
 =?utf-8?B?cnR4Q3lZbk85dnNRSDRPMnhRZXg3djVTWjBRNXFnSHZRWmdJWjJ3aXNuUXVk?=
 =?utf-8?B?MXFXWm1ickF6L0lua2tvOC91SFAwa0gxWXFlT3N4emtnV2xhMXZWOHk2WTlu?=
 =?utf-8?B?UHpYT2dGejVEeVlyOGxkQnB0VXBoSGVCMHh5b0d0KzhFS2EzWFVjK0lQK2dM?=
 =?utf-8?B?dDl0aEJSdHpnSnh2NFAzbHp5amRRT2p0YVBCc0xGaW9KQ3NxUDJUK0kydU1C?=
 =?utf-8?B?cUZ1NXFaU2VMdHBRbENyNlN5U0Q4UnpRbUxVMXpFVm81ZDRYWFgrekJzVDZH?=
 =?utf-8?B?VmFodk9pQms3RWlLOGdSd0grMzFzVmZqMnBrUkk4V1lpaElRR1ZNQkxwYUdK?=
 =?utf-8?B?TjdWVXpBU2VWdVgyc093ajBkSmlTTXo4V3NxMXJ0ZFdnanZia1c5UEtDcHhn?=
 =?utf-8?B?SDV0b0R4SENoK3BVWmhxOEZnM24xZ2dDbmpwbXcrcWx5czhtSGFweFR2NCtR?=
 =?utf-8?B?MFdUbTlzM0lGUWZwUExnSStaVnpucWVEOGJkUHk5ekltYS8xTkR6VVl3YWVh?=
 =?utf-8?B?L2VzaDkwUzMwM09xYWo1N1FPQ1BBWE15S1dBV1pqZnVlUFg5Wk9qc2t0cGlq?=
 =?utf-8?B?ME9hSzVnVnkyT2xLMmFDOE1ud0dUVVhVdGpBU3RmaTZEOFdmYXhlLzhpNS9K?=
 =?utf-8?B?RjN1eHhlSWhkR0VIc0VxM3QzM0FPU0VPR05XdCtvaHZGVGVkV0psTmhHWW4v?=
 =?utf-8?B?TUhvWFQxNVhQcmd5WDJaeXpGWE84K3dubElnQ0l3TzcxZkxTbHB3eGxEZVMw?=
 =?utf-8?B?a0xrL0xLWnFTMnE1NHdoT2JGTU5DcXdGaFVlSkdKOExaNyttWmVab2lvWWE2?=
 =?utf-8?B?MFFHVCtTU3NlZkJySWNxalhEYVVhV2M4T2ZuUithRXI2SHpYMlc5SmFDOFZB?=
 =?utf-8?Q?ekOb7JL1hD9zr5/XNDlT+fKGiGxVJQ2J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(7416014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1NwRThqakQyYVNxdUlBdU83b2FNSE9oVkE5aFkxTXN6MGhvRlNBdzByUUY4?=
 =?utf-8?B?ZFZpTHQ1dXJPQUp3c1JhYVJ3eTQ3K2orY1FGZ3JrbGdBLzE3NXBGNmw1d1l2?=
 =?utf-8?B?V1VERi96dWtDWHY2a1dhUG56T0RTUU5jZFNobmVUZDZIM0Z5bDNKOFZXMVdj?=
 =?utf-8?B?VWZhNGR2T3NTUjdRMi8zVjZCVWVOb25PNGVPNVNsV1FoMlptbGtwVWdZRURk?=
 =?utf-8?B?bzhpN2t3WTZOakhSVHA4NWd3Z1VRRlZNMEJjMytmVENqU3ljOG1uZzl6NlFJ?=
 =?utf-8?B?OUFJaWZVK2JLcGo4VmNzbUIzZC9ST1Z3MjZzVFdQalU3RXN0Z2JMT2wvUWVL?=
 =?utf-8?B?RGc3VytFWHE0MERIZ2hnMU5qZXUzMG1CZ2dRbFNkWk5NM3IyKzc5VmpUaVFB?=
 =?utf-8?B?MFNhRm0rdkQ2UWJkTTByRXZpaG0vbzNWVzE0UGdESHBjck9Va3RLbmd3WUVj?=
 =?utf-8?B?NEZHaStKaEtDZXliVWhDRUlZOWt0S1UxTEdMZm5veHBHS0IrYm54RWx6S0Vk?=
 =?utf-8?B?VUUvSXRPT3hqSGJaaTBLOVdiVzdQNUNZMmhOR1QwWnF6amYrZzRCaGxuYjRt?=
 =?utf-8?B?L2tqUm44ekw2VjNLbVVTRjVQYzY5TTlSNnRkOVRVY3Q3cUJzRkxqWUZpNVFu?=
 =?utf-8?B?MlBJSGVFa0ZldCtmSG1CakppK0VpTTY0TmQ4U2NNT1hQSHl6NjVSdFQ2MWRB?=
 =?utf-8?B?UlFoYlE5d3FxNEFSSjlVdU9DNFZ5ZzNxb2Y5SmtEMjNBRE9JMGcrb2pGNUhB?=
 =?utf-8?B?b2cwSXhKaTljVkxnT1NaSlFXYkRyZnVIVFdHRDcrZDIxbVA0eGh4b3cxbWI2?=
 =?utf-8?B?Ky81RUFvUWJnVGluMnBDNFNiWEdoclZCc2ExRXBsQWdRZHU4NXNFOVFPNytl?=
 =?utf-8?B?OElDWHlOdDByTWIxdHExQ0R3cC9ERXBCUFNqb096YTBxWUhseTE4TkQ3OFRF?=
 =?utf-8?B?Vm1DNG5SOHU2M0VYZk1mdU1RWm1UeldaOFRRQlZJWmZwc2ZrWnF6TVJRNUl0?=
 =?utf-8?B?ZFRiNHc1SjBOMTRyWnViVGIwZEUzZjNjUWJ0eXlQNkxETUNXYStkNHgrc2F0?=
 =?utf-8?B?Nnc2Q3RGd2R2MWVGMjBPc2xkcllrNHM1dC81Y1BjT1MzaHIvNUsvK1pIVzJw?=
 =?utf-8?B?cFZWOUZGTi9VMFJWbHBqSXhROGVibkZ4amZ1TU9kcEZHQzFCcFNxTXN2UTBs?=
 =?utf-8?B?UFhqQlBPcVIrN0hiOUh5Znh2MlhFbU1SK3JmZTlUeTFPNHFRQkpBY2ZRZVc4?=
 =?utf-8?B?aWQ4NWtXNHMvR05DZnowcXp5Vm83MzZOcXdkbXVGMG54MHZQSVNGemVJSVFR?=
 =?utf-8?B?TFh2MGQ3YVYwaGcyaVhyUUlwSk9aWWJGeS9UL1dvNFFqOGpGZEJDOUU0Vkhi?=
 =?utf-8?B?aE42aGdRV0owVXpUUUFobnNVQUNiY1VqOVVOc1B1TEU4Nk1ObDJZWTNJTGhY?=
 =?utf-8?B?YVc2dldMK0JMSHFYdHgweldUMUoyWVFXeTI5NjNjS090dXltN295eTZKQzEz?=
 =?utf-8?B?emRNVHgwai81TVVIQTFmVjRoOVU4SFNuaWRHSTZJbjRoK0hIZExTZE1CbUth?=
 =?utf-8?B?N3Rtd2o0TUtVV2Jwbzc4OE00aGgvYkZyZ1JGUkVMR09YdzI2ZnJyQXgwSjMw?=
 =?utf-8?B?TlZsMnN6cS81TDcwTCtaVHNFcUo3Qy82V2JQWlV6YU1lbDNPeExqQklUVU0r?=
 =?utf-8?B?WHJrTkpJdStRMTFIRlJ0M1FGUUNrVW9mK0JZK3hkcW9EMExCd0dzd3NzdFJj?=
 =?utf-8?B?TW1JeitJNy9nNThDVjZQMDlrSHZoWU5zL09EQnJqTG5SMzdpekxsTm4yMUV3?=
 =?utf-8?B?ZGplQm9HSExrS2tadE1UWDJ0NStOcVVUY0E4VTBCMzFzWmd0aXFHVFBtZmxi?=
 =?utf-8?B?bWZBRmdYRUw4NGtRbXJ1S2JQSW9uZVhBOVROZ1ByczlLbUtJbTFraXdTNkZk?=
 =?utf-8?B?NkUydnhXcUN5S0xxenU5WHAvblFTQWxsUEJkMks4d2p4R21tM0RSeXhESEgv?=
 =?utf-8?B?OXRxdnpsRi9PK1oxWVBWSEg5NStuRHZXWGNCQ1RTY3BSblVKMEVNbkZIOXFt?=
 =?utf-8?B?dkZaT3NsMHN2V1phaTIzSWdDeldTWm8zbkY0U1VreEU4N21Sa05KcGxyTFRh?=
 =?utf-8?Q?JpiHQeWKFh6qtVf2jthidwRMK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce11ba25-f253-401e-ad9f-08dd3568bb85
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 13:30:09.6925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dH/Z0cSdp1a8+A8Ijesx6w043mD4Lov356ytDcPl6+cDF5RhcrtnFnhyow5tq/ASMYbmQgRpUmBHyWoQ0/UGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7764
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

From: Alice Guo <alice.guo@nxp.com>

i.MX95 only supports low power boot, which means A55 is kicked by M33.
There is no ROM runs on A55 in such case so that deselect IMX8_ROMAPI
for i.MX95.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 arch/arm/mach-imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
index 134e42028c3787d78e28af03d40c41a8b2b1981b..daf6443aa5b40b6410f2645937239a4ec785fa34 100644
--- a/arch/arm/mach-imx/Kconfig
+++ b/arch/arm/mach-imx/Kconfig
@@ -180,7 +180,7 @@ config DDRMC_VF610_CALIBRATION
 
 config IMX8_ROMAPI
 	def_bool y
-	depends on IMX8MN || IMX8MP || IMX8ULP || IMX9
+	depends on IMX8MN || IMX8MP || IMX8ULP || (IMX9 && !IMX95)
 
 config SPL_IMX_ROMAPI_LOADADDR
 	hex "Default load address to load image through ROM API"

-- 
2.34.1

