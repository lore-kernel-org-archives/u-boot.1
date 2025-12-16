Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45B8CD5B161
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:40:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C71CC80077;
	Tue, 16 Dec 2025 07:40:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="lmRT4YaC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D1080077; Tue, 16 Dec 2025 07:40:14 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 19E4C835FD
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:40:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uzDhEwfcw+CrTZxIioh+3QSfCw2Ek33SNRGPHJgjJm3VfIkOhn1oK/qPvVSaJlP2C8TJ6r290s6NrGf9Pg5oe5e8SD0JzFmpMjdx6WDwXf4tl2mBZkEEfwL2yE92VAqNhvRDsquhdLsy3I0l4QkYDwigFzkLRoGlZpVmfd/xnk8cqzrO6OL6eUD4+3YxbQ+dXe6E7Wj8ekUiqn0/4hvNwaBMnfHA7tNY7JLXF0r7gx9nMCz2m7AiuD+qATWEpmM9weD3mtjZDsLwYgFw/quXKOtfbKxjvTzHuvZsmobBdmNjtgBIjN49HAwxdumQFzJX0yVIS1NVO+NNWYxf7RvmKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFDKnAjLL7u1sK1H27zVL8mwgv4WulX26GdsbHTnfnE=;
 b=w1/s+WZN/S5nWAveeU31AvH4ZKdY+OjNz3fwuYUHA4W5eq/YVNvgrvizeQnMWQHmpgbIISpgGGVCZOzOqWMQKXVh5pCR/iUP086lECyeYZyb7G1vvt8d60ADvnz+DkGX3WEwNzGZ/fwDO/XkYRilNmJXMR/Y+dsk1MIgaASTV71uI7NqeCrp+elVNuw3hOFjDxHtgbw1qdNf1/33qoEuOKPd1ieY1NaaC9rI5FLiEAyMdKUEQ4Zl41YoR05v8wZjZscz0A6RgE2p6q3IkiFg+lnAxcZbCAS0EsKVaZC6vf2TLkceN0u75hZEVEtQKFkqOzO6y979HN2J0V3mupoqrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFDKnAjLL7u1sK1H27zVL8mwgv4WulX26GdsbHTnfnE=;
 b=lmRT4YaC5lyOPmQO2pE3gaFZ7rml9LwP4Gq/mxLusNsgem757bJw/Fu+COsLS1ByRnHzWPL+nMY6ygy5cC/NEMZNE6UWemOA+k0IfXQcdpvyrD+lCRT6wWERspb/yr5sMG6db/LNq90x5qMLMXvLMjUbwWLunISDsETAqBl4aGoyOgBbGvNJQ3/ZOR93RVyiuCFWPyp7HaV8fbm1gtZzRb2izrpNuR9pIJPwmfiafMaSmVnjsKkz9rL9KQ6vz2+sK/CwI9QVCMwdf/DItLPlThj9LwwpjAnCloXoi+sF77WFjpGZzPJZ+PIQlUS1g5E4b8sMbyJNkHN6lZX9t3WKrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:40:10 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:40:10 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 16 Dec 2025 14:38:38 +0800
Subject: [PATCH v1 6/7] usb: gadget: ci_udc: Add i.MX8ULP support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-imx8ulp-v1-6-504115a53020@nxp.com>
References: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
In-Reply-To: <20251216-imx8ulp-v1-0-504115a53020@nxp.com>
To: "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, u-boot@lists.denx.de
Cc: Stefano Babic <sbabic@nabladev.com>, Fabio Estevam <festevam@gmail.com>, 
 Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>, 
 Marek Vasut <marek.vasut@mailbox.org>, Ye Li <ye.li@nxp.com>, 
 Tim Harvey <tharvey@gateworks.com>, Peng Fan <peng.fan@nxp.com>, 
 Mattijs Korpershoek <mkorpershoek@kernel.org>, 
 Lukasz Majewski <lukma@denx.de>, Sherry Sun <sherry.sun@nxp.com>, 
 Kever Yang <kever.yang@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>, 
 Quentin Schulz <quentin.schulz@cherry.de>, 
 George Chan <gchan9527@gmail.com>, Simon Glass <sjg@chromium.org>, 
 David Zang <davidzangcs@gmail.com>, Alice Guo <alice.guo@nxp.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|AM8PR04MB7794:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eb71ee0-3b46-4a27-5fcf-08de3c6df57d
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WkxKZXE1VHVPUWx6SVNuRVRIL2VRUWlDVlQ5bys1OUJoKytNbWY1akhyaUll?=
 =?utf-8?B?N3JUUm9TQ3AxbTVQWjZzUk43cWZ6dm1Lbk53WW5BYTFuR3UrQjBkSHYyK2V6?=
 =?utf-8?B?MlFib1pLckh2MHpLZlRxdlVsaGE2YjNlcHV4ZUtZOFFEeDdyenVJUEc0SGhn?=
 =?utf-8?B?ckx2UkwvZzFCV2xMVTRPeVpUNmUxcFQ0ZmRXVVdGRjBJVkRUZ240MG5XM3I5?=
 =?utf-8?B?QWxvODRjSzRraEhSS0p6c1dSa2VQQXJOYXJZSEVwa0NzREp6S3ZURXRwUFJS?=
 =?utf-8?B?OWh4UWlTUDkzRlhLWHdPaE1JbWIyV0dGem1lN0J2ZGJhdWJHci8xQXpZb0M2?=
 =?utf-8?B?c3JibG5zSEVpYWRIQ3NLTlBEOFFGams0NG1USFozQmpSVWdzM1BjNGlZeXVq?=
 =?utf-8?B?VmhQc1VjbDdqdnMrVVpyUlR1UENEUEd2SVJQM291NzZyTHpmVlhSbEtMblUy?=
 =?utf-8?B?dHZLdENqQTVBdHVMY3hUYUUzREhTNnIvWlBlSFdaQ0Rxb1lKS3MyQTltZmR0?=
 =?utf-8?B?RjdMRmxKd2xjQkVoNCtxTmlidG9MVUdnOGhjSkRpb2U2QVlBcXVmM0ZLWWh0?=
 =?utf-8?B?d2tUbUowYlJsdnI3STlwRnJ3VXdtK3FLZDBMU3RjeENaRkM5SHp4Q2JxN1Yw?=
 =?utf-8?B?aEFuY2x1KzRIZE9JRmdLMmlkQnNoL013ZWJOSmxLQS9LUGZac2pWdXczdUFI?=
 =?utf-8?B?Mlkwb1pqZDR3dFlDSlhFOWhzR1lzY0hXL1FjYXlNNko3cnJqc3NsNFJWeW50?=
 =?utf-8?B?YU45citrajRGUmxNQW1sQkpUWXhnSXZpR2V3Z29MK3M5NjBvdUExUzZXMXl3?=
 =?utf-8?B?YmZ3WVFYbXdzRHZtL1ltZDhma2N3RUNXV3ZaeXJNZ3ZSMitxSCtoKzVHS2Rz?=
 =?utf-8?B?RDBEWG5DZVJ0b1lXQ0sycEkvSEF6VHJ0dmNDTkQrT25WRXU0VFNYU0p2SUVs?=
 =?utf-8?B?VitOMUVOOVRIYTVOZUYrT1o4ZjVGSDYvNXpLUEptcnBGY0JVVmk3TmdnZWVa?=
 =?utf-8?B?NmdLaU5MbEFWZStkakRLMTUvZWU0Q1ltUE9mVklZcnJoSWZvbGpRQ1MrYUh3?=
 =?utf-8?B?RkdDNnU2UlZIc2NDTlhWR3MxRXVEWG9qUFd2NDZPOEVnN1hOOUZhR2NCaHZR?=
 =?utf-8?B?TmZmWTE2cjNsSWZYa2xkZlZ6Qzg2amExSGRPK2pJVzlPQ0Zla2laaG4xUWk2?=
 =?utf-8?B?cnhjdGZ2cG80eTh2WVNUWHJJaVNsYkVXazlXSStlOEs1eTduRkVHeUFRdnhj?=
 =?utf-8?B?YUxGNUdYVnUzbzlKOWxuQ3pPTXg5RVRzR0MvcFcrcWF3UUpTaysyZDFtenVY?=
 =?utf-8?B?WUlxUDgyVWVGdU9Kejc3aTUzQmhMdy9aWDQ2SmgvZ0ovL2NXN3JESytMeXVW?=
 =?utf-8?B?T2xSNXBJcGFuLzRIMGJ1UmRoK2J3QW5BclA3Tms1K29RV1pkNW5pWTlZcXpK?=
 =?utf-8?B?ZjZCTUZCR3VERHUveUE4SXVFakpkbkhwTk1saE1lM1UwNFlaNGwrRWlGdUI2?=
 =?utf-8?B?SElid2RUMkRyU2VMNGJKaWxyYm5kalRwY3R5Nm45VStLSncvMmhWVXBzZW9M?=
 =?utf-8?B?R0taNTVzbVZzS1V0RVBETnBlODZzc0ZJVVpmTmRPRHdBSCtVdENCNndsQit2?=
 =?utf-8?B?bWRlT1BhWE1XM3V5djFRWXVXRFlyb3E5MkRYTlMwc0xHcC9EWU9FZDd1U3JP?=
 =?utf-8?B?M3FDOWd1Y0hiOXJSKzBQNkg0eC9sYmVYWGJybFc5SkJsbVQ3SnE3eVF2aHRi?=
 =?utf-8?B?SGxYYXMrY0RvMTNuOEc5Y2hGa2krUVB5ZVRSYXV2SVVZRGNueEp0dlVwamFZ?=
 =?utf-8?B?TzBKcHJsMmY0alpRVkx1WThDYklCTTFFYldMYk1uSzgrU0FHancxWHE4b0lH?=
 =?utf-8?B?N3F5MkNlUkQzejdjNy8wVE85K3RsL2NTS1dzcDlveVlQL1Q0VjBZSUFDK3M3?=
 =?utf-8?B?bXVHLzBieEgxQkhMV0ZiWGRGUkxBbTdUOHMwbmp3cnViRXBHMktXWkFqVU90?=
 =?utf-8?B?SjUyL2ZhWjVOcUxaMW1xd0paMmYxTm1KSk9vNXplcUpGU29DQTZQYVBabzJN?=
 =?utf-8?Q?17IgMW?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlJoZDVGNk9zd3JpbW1WQ2h0YllHdXpaYkJXaXJqT0lFc05HT1FFcis1SVdI?=
 =?utf-8?B?K2pDWVpUNVhEZGVCUGY2dTlUOVRkZkxjbzNnN05nTkdiR1F2SEdHMG91K2NV?=
 =?utf-8?B?dnN6L091My9IQ3VBenowNVNKUlJPN2ZqY1BaOWZZbDVOcGZXdUVKNDRnVXFX?=
 =?utf-8?B?aXNSVUVMM0dmRHkrVnVvWjcyVmpyMTBSekptc1JUSTdGenE5azRMOEhBOXpJ?=
 =?utf-8?B?NmRxaGk5aksxbHZOandOT0R2QXVWOHh6RkpvbG9BMlNtd2xlY2F6Rm9qOEJI?=
 =?utf-8?B?M1pZOUNla0xSM2dTZVNOaHlvVXVaa1doaEhjZ0w5VlA2QmNCY0dXdVJBWVJa?=
 =?utf-8?B?K096bCswUXM1MjFheFB4cGhUTXJtSDlZcWt2ekpkckdjVW56MiszNllTMEts?=
 =?utf-8?B?bnY0STdUSzJRSU9Tdy93Q2sxL21Rd3IxeUw0WXBQSnRFRzFweStmNVNHS1d1?=
 =?utf-8?B?QnZaZzdzdHE1RmxpQ2tEbkhQQTE4c3RkTzVSb0J0ZnFFOWVlcWVhRUZMTVhH?=
 =?utf-8?B?M2ltRExIN3hJenI0c3NqRUgvcjFwcXJ4YUNBNmRmNzh2NkhPczdZejlBeXd2?=
 =?utf-8?B?MmpoWmlqcmc5N3FFTmxDRnF2Q0N3WVBNNGdWamo1VW5obGN4WlBRbnVqelE2?=
 =?utf-8?B?WlYxZXN6aENQSGNvK012MTlZdC9kMk1yTGJyTUpHUFBBZWcyNXNqN054NGpu?=
 =?utf-8?B?RDl5UFgrTTRVMjVBYlZZNHZwYTgyd21IS2RYYloyWG9lNzk2ZnFBMHY1bmUy?=
 =?utf-8?B?bndoMHUzZ0lOc3E3YXhxeVF3VFc0ZHpzWXFld0hUMndnNTQ4RHgvaDM3Nkpu?=
 =?utf-8?B?RUE1MHhDeHNPWmlwWE1tQlRGaGVkTWNhSENaYzdLbC8yNzI1TjZyTjg5MUxi?=
 =?utf-8?B?MUpPTnkzc0NGUG4yMFRYMHF1dWdITlF6ZnkyWVhwbmVIc25JU3JId0JsNyt4?=
 =?utf-8?B?VEY1QmJHMVBHZFBya0VqMDQzZ0dHWktGa3FhaklHeEt0ZVVWeVVFQ1V1aGJM?=
 =?utf-8?B?UHhsdkxUK2tmcllIYkpFbTdUU2NEb29hRmwyVkVJckZnQlQ3UUY5WE5icUYz?=
 =?utf-8?B?cHFvU3IzNWlhOUFTdkp2QTFaOEQ1TU5KZHRHRkFlU1BIeE82TDVVanZ5dzQw?=
 =?utf-8?B?dXFiTlJ5TVRJb3JQY1gvaHZHcEdrZkJSYno3RmNoQTdwU0sybC85dnl0cUl6?=
 =?utf-8?B?cWtHL202alM5dUtRQmIra0hyYnNUMFRqU3M4d1RBelV5U25TaTVUY05NWFh5?=
 =?utf-8?B?UGR2MUJJMWliWUpEL3BDb0lQMUI5UnA5TitBVzlYQ2tYV1ZGbzVNdmZNYnor?=
 =?utf-8?B?ZVVGaE5ncHkyYjU1SDRBL09VekF1V3AxL2pCNGplY0pJQnlMSysrL3V0Tkk0?=
 =?utf-8?B?d3JXMFNGSDRjMUNUamNYbkh2VWwvbEJ1RVNZOEhOMkdCK2JtUDBvSm5OZGJX?=
 =?utf-8?B?Q1Nzbm1HaXZjVVhZcTh5UWMyVnUyYkxFK1FRYUs2enNQeDNtRmRkUFNMRVdS?=
 =?utf-8?B?cVdOM2hheFQ3UDR2bmZ5YkNzenA3Zi9qOWl1c3c4K09Bb0NlV1NiYjBhek4x?=
 =?utf-8?B?RlJoaW5UUHRhb2dPcUpXM2E1dm9lTCtiNFgzZ1hCUEhpa1czWVJ3dzFDMndD?=
 =?utf-8?B?bU03QmZVdGZYemlXV1NGbTd5T0RRTTdyck5DeFRjUHYyNHc0bnVQUHRlU2J0?=
 =?utf-8?B?MFk3bmZpTitLR2ptSHQraTJSYVhKV1RoT2NBY2VpK0R6OU9rRmJYSzBPMExl?=
 =?utf-8?B?elRUQjRxZHc1RjNHWjgxUE45VzI2eldReXNwOXJHaUlZQzg1TThiWUg1N3R0?=
 =?utf-8?B?a1pZUmoxZEtrNXBNTW5FeHJBbG9yeXJTcG93eERWRTB5NC9HQXZBTzJGTEJh?=
 =?utf-8?B?WDM5L29RWmdEeFRyMDJrSjQ0dmE0bXZ3Y00xZFJsR2p4bU1wYzQxQjNrWUU4?=
 =?utf-8?B?eHFaeXVveWdpbUM5b0U4Qi9ta1llL3Z6NG9WdWQyeDRmZERuZ3UwYmgwVUxS?=
 =?utf-8?B?eE1Xcm5peXMzbXMvZTV5RG1tMEJmMG5YRDhKaUJvMlNlWU1qcXFnajdod2hs?=
 =?utf-8?B?L0RyemFtQmdlbDRxYURpc0xLaTVzQ3F2NVZTYmgrOS93ZFBUTVNXaUpmTU95?=
 =?utf-8?Q?x62LqXqXf6IpuOJHwehHGtDDq?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb71ee0-3b46-4a27-5fcf-08de3c6df57d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:40:10.3199 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XLHCaI+VqX7UpC8yaK+JiEtFa36OjuYMiIN24AzXH9jmSlibCSxTFHq60x9f4x92mqCfWvbtipC3O6dClkNEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7794
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

Replace fdtdec_get_addr() with fdtdec_get_addr_size_auto_noparent() to
properly handle device tree address translation with different #address-cells
and #size-cells values.

Add i.MX8ULP platform support in ci_udc_otg_phy_mode() function to
ensure correct PHY base address is used.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/gadget/ci_udc.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/ci_udc.c b/drivers/usb/gadget/ci_udc.c
index 154a3ab7f22..98d6dd99055 100644
--- a/drivers/usb/gadget/ci_udc.c
+++ b/drivers/usb/gadget/ci_udc.c
@@ -1213,7 +1213,8 @@ static int ci_udc_phy_setup(struct udevice *dev, struct ci_udc_priv_data *priv)
 			return -EINVAL;
 	}
 
-	addr = (void __iomem *)fdtdec_get_addr(gd->fdt_blob, priv->phy_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(gd->fdt_blob, priv->phy_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		addr = NULL;
 
@@ -1223,7 +1224,8 @@ static int ci_udc_phy_setup(struct udevice *dev, struct ci_udc_priv_data *priv)
 	if (misc_off < 0)
 		return -EINVAL;
 
-	addr = (void __iomem *)fdtdec_get_addr(gd->fdt_blob, misc_off, "reg");
+	addr = (void __iomem *)fdtdec_get_addr_size_auto_noparent(gd->fdt_blob, misc_off,
+								  "reg", 0, NULL, false);
 	if ((fdt_addr_t)addr == FDT_ADDR_T_NONE)
 		return -EINVAL;
 
@@ -1326,10 +1328,10 @@ static int ci_udc_otg_phy_mode(struct udevice *dev)
 	void *__iomem phy_base = (void *__iomem)devfdt_get_addr(&priv->otgdev);
 	u32 val;
 
-	if (is_mx6() || is_mx7ulp() || is_imx8()) {
-		phy_base = (void __iomem *)fdtdec_get_addr(gd->fdt_blob,
-							   priv->phy_off,
-							   "reg");
+	if (is_mx6() || is_mx7ulp() || is_imx8() || is_imx8ulp()) {
+		phy_base = (void __iomem *)fdtdec_get_addr_size_auto_noparent(gd->fdt_blob,
+									      priv->phy_off, "reg",
+									      0, NULL, false);
 		if ((fdt_addr_t)phy_base == FDT_ADDR_T_NONE)
 			return -EINVAL;
 

-- 
2.43.0

