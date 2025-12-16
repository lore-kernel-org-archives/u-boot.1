Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAD30D5B87C
	for <u-boot@archiver.kernel.org>; Tue, 16 Dec 2025 06:40:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4C2F083642;
	Tue, 16 Dec 2025 07:40:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="amCHmcPa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8F91083642; Tue, 16 Dec 2025 07:40:05 +0100 (CET)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 183738003E
 for <u-boot@lists.denx.de>; Tue, 16 Dec 2025 07:39:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xw0riGQUVNwp+G86hDoxp9RaA7os5yFBp5OFUB2n7DV2JSaYcEsJzxATEc2Bgs58qCfKKJjMlJQUwCOboc8POrwMwYP7gXEHmlox23owsgkAx/m9mgQAQ7RY93bgv4oLeaw1/K91n30nJjgl0Pg2vjwm5uEhomwN60qB0jBr+qTbp4c4sKxIaeVx1mX9ro3V3HUXFxlhUFnGEKZHt+D15BsMPv96mRSX2D15YKEGP1gwdXMzzd7nmki4AoifXoPRap0vUUQcshIORupN4c3kEJfmJF0u7XP6ByoGMh0YCHeBxygUl5SWDgwS48EUB3k8Zm9eX0+fqX285g7iBv1Ouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoIXeqRlqPlbXk9KVnJnb+xyx8XOwW0ej9hPf/Os9Mk=;
 b=LiRL5ztLCBQA6iOya7NnD0hlHezl5pI8DDfYyd/gptdhq3weCoCoXjoYCRpDTuTjBQD/UIEqf/n2JSEBp7zbK0JeJQxI9vG9oULNi8n0BO7ich2hNgzo0tUYRzZ2xxVtA1yX1tSBfm4EXqG/jyjHgqe/PsdG1Q3Im2v72O+Utcx9ESlLMIQLPfu6jgO005GxqY+KyKRuLhtkRGmIOb36sl+F9vXoEJEEwTxbZgZ9H2MZxnHTcbIzTrTcT8yWPyM43GmAQsglWfO01CtbZbhyWQ+q7RcDK/jlnOGyM6CIyTP0IJUKU5UrPWfMARcaFy1fZ6R/ND0JEUi5zKIFnTGdng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoIXeqRlqPlbXk9KVnJnb+xyx8XOwW0ej9hPf/Os9Mk=;
 b=amCHmcPaWlwGLe0ZInOgyATxTSgcYeCXybuA5Ps+Cop7S3eKIAAH4QgjrhdOMfPT8omQnkyc2YooGt/nYIFAINjltz8z3k507OJID6dJ8Erl4b4lmAIvQyoDGWYQkFRq42n/MRYkNrg874OFwxLxIF3NyVTQmpPqCLLvCSWe2p3pLYaYUATq9f/Hxh/HfIyfQiL5BYi78aVy/uU23ahLr2tKt5bTGzEKjkzN482MNjYfw0sXI5WA+Bo6DqQwpYkuklv5taJkAl00dZ9S8pyVYNZr3dgLg2Dytdcmez5ssY9DT7kEXFertLCSXEab/ZcSHVQPI1I7rfkU+SjPr2S1rw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by AM8PR04MB7794.eurprd04.prod.outlook.com (2603:10a6:20b:247::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Tue, 16 Dec
 2025 06:39:54 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%7]) with mapi id 15.20.9434.001; Tue, 16 Dec 2025
 06:39:54 +0000
From: alice.guo@oss.nxp.com
Date: Tue, 16 Dec 2025 14:38:35 +0800
Subject: [PATCH v1 3/7] usb: ehci-mx6: Extract PHY initialization into
 reusable function
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251216-imx8ulp-v1-3-504115a53020@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e835069c-a586-43df-b92d-08de3c6debb9
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|376014|7416014|366016|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VEFzL2wzNDlweHkrbEI5Mng1d2ZmRlVFaWNHTG1odEtIMmJ2dUIzNllUQ1Bt?=
 =?utf-8?B?SDcwTnJocVBzeGJZYktLUlR1NEhSRHVnajByNHhud0FYMlFxTWdISWpjN3h0?=
 =?utf-8?B?TGNqSlYxaHY2ekppKzBGYy80R0JoZEw2eWJUbXNZYUp5ODhsL2p4ZlFGZ1BK?=
 =?utf-8?B?d1l0NXBZdVRMdDR2REpvdzU1QkpvQlR0YmVJSFFzbnBMZEF4YTZVQzlXRlkx?=
 =?utf-8?B?YTlzSkxxL3VsRHhBeHhhRy8xdEswekV0ZEZNTWVkUVd5ZnFWQ0VBYlM1bFVE?=
 =?utf-8?B?YjNObGlFdjNSZjRHNzB5blpLU1JGQllBNDRleWVubGMwWnJmb1VIS0tXaDBB?=
 =?utf-8?B?Y1laYi9NZklaeCt1RmtxNnlsUnlrTTM3UUJXeERPMHdrQS9EVmk1NkhTWFB0?=
 =?utf-8?B?NGVIRURqMTlRblF1NXQ2TE52UC9ZaDVlV3hlRE5zV1pYMlI3UzhleEJ0N0FQ?=
 =?utf-8?B?QU04eEtZZm0wNW5OaTVVRWJ0RkM4cEVhYkN2TzdDQmRzU0x6RTRWbzkzbE9S?=
 =?utf-8?B?VUZKM0t3OHhsc2JITVRmcUUrNm1raC9EQmlOaGlnZk1hNEVxV2tJWTgvTEI3?=
 =?utf-8?B?WjU1bG5BZWZ4K3VTWDQ2VndOc2hQWEpRTmd6ems2dnBWZWJtU2hKbDdKa2lz?=
 =?utf-8?B?TGVQSGVLbXQ2aHhzdFpjUXhWeDBNSEMrajZjcCttbGdhbFQ0S0wwbXR2U3R6?=
 =?utf-8?B?YTRoMm9ZRXdHKzdadnpVMVo0OWQ5TjRHckxzWHMxTFRFeTg5clcwazc3M3di?=
 =?utf-8?B?cC81WWROaHZrZnpBblNORVg5aUI4bWRSeTJQU2lMS2R2ZkFhYW1jb3BrcDdk?=
 =?utf-8?B?cTdWUzExOXdkc2lpWVRZdVlFaytESHBwL2ZYaU04b3p4eTRCdXdzbHZJQXBH?=
 =?utf-8?B?TUdnRW1kNkN3dmo5dEZra0RkdFY5OUYwbFd4eXhxUXY4NXc4R0JmS2Fjd1I0?=
 =?utf-8?B?RG9jWlE4VUovbUtqRjlWamZHWGlOeHowTVRsejlBbXZFdVhFTGpTcy80NFk1?=
 =?utf-8?B?alJVNllWYkJVb3h4NnA0dEdVUHBkQ2UxUzN3K0VSL3V4MVpIbDB6NURGeWJD?=
 =?utf-8?B?Ty9iNko2Y0t0R0N5TVhqN3owNlNUdzZna3I2T2FVYTRHbHo5cEhRbTJJK2Ev?=
 =?utf-8?B?bk02MjFSbXFMSjJ1MUFwZzl1Rm91eUIzT1NjQ0NLOENGOEQyRDBRVmg1U0Uv?=
 =?utf-8?B?ZURXQThZRjVWU0NFZWxTM254WFNRSmxyRjZuclVnaTNVRFVwcTVEU1UvdWNJ?=
 =?utf-8?B?UHdSN2xBL094V25kcUd4VFROT3dSZEs5dkdOSGI0UkwxeUdlcTlKT1pOcW5k?=
 =?utf-8?B?a29GTWQ2T2JaS3lwQTV1Qm85cWY3anRoWndUWG5NbE5scmg2QkxLUzd3MFB4?=
 =?utf-8?B?MXh4TWNHMll0WmQrOEU2S0ZydUNiMS9RZVVtdzVZem5lYmYxRXVaU1VnYnNp?=
 =?utf-8?B?by9WUVV5cnJXcjVCWS9xaEh1K2c1QUoxMWkyaENtWEx3bVZ1WE8wWmorbXd2?=
 =?utf-8?B?T3RTbjV3RFAzMHRkVjlsNVZXbkY1eFJQbVlNVkhadU5kdXJEY2s3aUtzYXdQ?=
 =?utf-8?B?VHJhUmtydGN1blk1WVdkQzRRa3FCZXZsTWNzYVR4dWlUcW5ndHNzQUt4M010?=
 =?utf-8?B?ekh5RFlmOUUxRDc1Z241VlNTV082TnQwUmZWc0l6aFZXeHJVVGkvbEplWWEv?=
 =?utf-8?B?OG5QMXRvdXdBTllCaUdLZWZHc2QyTGcydENtckMxRWJhM29DbFFQU0M5VTRk?=
 =?utf-8?B?amtEby9JQ1BNRGwxdWFyZTREVlU3ZHJLbThwUFZKY2h2QU13UEFycEtRL3VG?=
 =?utf-8?B?dDgrK0xmT3VsS05NZ2s4eEFReXNWTHBYMWUwQmRiT0ROUDhtQmdxaVpHVnhs?=
 =?utf-8?B?ZllqVGVLR1dyZWpKVU01c0F6Y2RzbFlKS0ZROC85cDQzSnhXeXlTRlR0NDJl?=
 =?utf-8?B?U2RaK2E3K3M1MnpPSmgybHBzaVVjN2V0dERTQ1MvZm9YWENPMm5lOFluQzJX?=
 =?utf-8?B?ZFY1RE5QcmFuVC82VzdPOE1nb3hTLytKb2NoMmZUN0hRbGhsbDJVRnZSSXRV?=
 =?utf-8?Q?fpIF5u?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(376014)(7416014)(366016)(52116014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U0NhR1lmWjVvQkhrL2liaWpHQkI2cTZJQ1hVSHUwalNld09lY3hRZm56Rk4r?=
 =?utf-8?B?UlJ3cC83djUvQk5qSFo3dmZpWjUvRmh0ZXY4WWdUc2kvNzdMMVUvTWxYSmFQ?=
 =?utf-8?B?ZmIwaFJIQUthcHJJbGxmalcwYXdoRVpmTjJMY3hKMGZhU1lGdEEwaVRqcElY?=
 =?utf-8?B?emJVMU9rWnVxbTFaVjVwaktDbEQrUEhwZEVRUVJiWDJjVjVzWTZFVkNoVlg2?=
 =?utf-8?B?a3lmNGhPdWhQMTlQbzQyMG1nbjVVNUZtUUova0dzWGl5Mkg1cGxRWVEwTGZJ?=
 =?utf-8?B?WDlPUGtpYmxmQ0VmRXFhN1VtZHVIRUMvZE43ZGdOaVM0TjFZcUZJRlMrUnp4?=
 =?utf-8?B?VUU5dWlVVUpoVTNmWGxtQ25ZUjhpN3Vsd214WjhqaDdGY2Z3eks5R25qdGh1?=
 =?utf-8?B?TkI3U2trYjU1cGI2eWN4WEh1a3czZTRUaWRuL0I2QWVmNE5rdXdhbFZoUHJQ?=
 =?utf-8?B?NU5aYzdERm5XUE1ZQk4wdGFZZFB5aWJ2b1JQbTc3WFVoNVRsclQ3ODA0NE1N?=
 =?utf-8?B?TTR2NFVrS0RLU3NUUkFMc1hySEt3OWltVUV0dXJ4RHIzMHpUM201VHl4ZzBh?=
 =?utf-8?B?SWExMGVKYmV1QjlsMTV2ZUJwQUswQ3VPOS9nNmlTUnNOcUxNM1FIaGc0d0lH?=
 =?utf-8?B?WTNVK09DaFhhSmlNeitCQnhZbC8wc0RvZCtlY2RaNGs1bHZoZTZEaDZTMXA5?=
 =?utf-8?B?RDlnci93RXFrMFdQYUQxRURYWGNHRmNvOVM3Z0lNUWdiY2lNdjl1TEk0Mmo3?=
 =?utf-8?B?Mmg5VmwxODd6STA2c0I1VnlvbC9XbENWZyt1S1hWTFg3WnRuVk1ITVVnaHRw?=
 =?utf-8?B?SlB2Y0Erb0lzOWFaTjJIMDhUMHBxa3F0eUdHWnBoUnV3ZmNDVHg3T0FWK1o1?=
 =?utf-8?B?aElEaGNVNDBUU1RXeldISXFsSXZoWmJSNGNsUlBnYjAyQ1VmbFg4SHdFbldG?=
 =?utf-8?B?c1JEak9PUTNLSFZ2NHg0VVhzOUVyelFzZXFObm9QWHNuRmJUVThtdVdHMkxH?=
 =?utf-8?B?V1hRWGJJTkZXekZXaDh1MXpDU1Uybi9ONzhsZDROM3lhNFR4LzdOMUhFa2ly?=
 =?utf-8?B?Nk1lTHB4VXlXaXl1NUwrUFdkK2dsUEpCU1FmMmZ3ekVieUpWb0p6TXB3QmNJ?=
 =?utf-8?B?OVV4NmlHcVVDaUFpMVBnV3FHRXRLbXVvZVNZc3FIQlo3MU1PWURJcU5iZ0dK?=
 =?utf-8?B?V3ovREVxT2pLQVVicXFoWmNpQU1hM3BVbzZRaVlZUElKNUJLcHpUbUU0U1Av?=
 =?utf-8?B?M0VieFJEczNaUjliQ3VNdHRZMUNDRHpncDZ1MVd6bDMwdXI0Q0x0bXV6cnpM?=
 =?utf-8?B?OVhnVVVITHh4bE9BcGpSdzBNWnhrVUFhQkpSdzFUMUxEVE4zclNDTm4vdHA5?=
 =?utf-8?B?NWV4aDdSOTd0UFUzbDNwd2l0ZkZzcU9uekJ4Q3FMbUVjK0NWOVBLeUpnWHQr?=
 =?utf-8?B?QW5QMHFtVXByNjBIOVRBNlJReU9WUDBoQXdSQldaV2JsZm11MmxSd1BhTHEv?=
 =?utf-8?B?NzlWS1ViMkJZRjZZYk5DdTVsSklnZzlJTTdFSjl2VG5lRGRjN3V5KzZHTk1W?=
 =?utf-8?B?L0ZyNW10N29uR1Q3dEYzRjFnemR6c0Q0bGxKTnpoSnhvbWN0aUtrRGJjNlBy?=
 =?utf-8?B?eWZVcG1kYU14MWR4V21saGtYTnVhaHdoa3VQLytobHhvNUloR1NUTE9BRzcw?=
 =?utf-8?B?OE5kcXBMcGl4YVF2Y0hzUXRCMkFraWRaTlRUQ1MzZXJKdFdMRE9ERHZiZTA2?=
 =?utf-8?B?VTFJUWYzL25CcmdjNS9UTkY5TUNOOGpxVWxzSlJ2eFYrZldKQTZDUG83QXA1?=
 =?utf-8?B?dk9DdzNVcWRaVkxyV1BUb1QzaklLcExSWDVxUmc1YmM3MXU1aWhJTDRsalV5?=
 =?utf-8?B?WGh2bjB5LzZxa1h6VEp2SFZ5blllLzVpa3BObHVtbmRlVFlRc0VPZTFBLys0?=
 =?utf-8?B?NG1VNjBSdTZJUFo2Q3pmaTJ1SmFnQXQ3TlBjWkVscE5nMXZUeWVudksyVEMw?=
 =?utf-8?B?ZFJKU3VDZDlYU3ZtZWIweEk0QW1KYzFVeGNoVjVCKzdZSE5mSElmVldKeW4v?=
 =?utf-8?B?c1hTbWhobDNZZGx6WSs1N2t1c0pVQmdxRW1yTnpqZVc0c2lkY1RaNHJJL0VF?=
 =?utf-8?Q?mL42WnXLTHJrsq6FOkMGpC1WK?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e835069c-a586-43df-b92d-08de3c6debb9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2025 06:39:53.8773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h2Q7bLJDnHlasVlJFjcjOjNXfOeM9ITTE6fk3n7HZyUiGPBPY+sH0rq3af3Rzmaa/G/dZv0HhM5UX7mDh7N2jA==
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

Extract USB PHY initialization code from ehci-mx6.c into a new function
ehci_mx6_phy_init() that can be shared with the ChipIdea UDC driver.

Signed-off-by: Alice Guo <alice.guo@nxp.com>
---
 drivers/usb/host/ehci-mx6.c | 73 ++++++++++++++++++++++++++++++++++++++++++++-
 include/usb/ci_udc.h        |  9 ++++++
 2 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/ehci-mx6.c b/drivers/usb/host/ehci-mx6.c
index 03ff4ce10d5..52f14e6eca0 100644
--- a/drivers/usb/host/ehci-mx6.c
+++ b/drivers/usb/host/ehci-mx6.c
@@ -12,6 +12,7 @@
 #include <asm/global_data.h>
 #include <linux/compiler.h>
 #include <linux/delay.h>
+#include <usb/ci_udc.h>
 #include <usb/ehci-ci.h>
 #include <asm/io.h>
 #include <asm/arch/imx-regs.h>
@@ -168,6 +169,54 @@ static void __maybe_unused
 usb_power_config_mx7ulp(void *usbphy) { }
 #endif
 
+#if defined(CONFIG_IMX8)
+static void usb_power_config_imx8(void __iomem *usbphy_base)
+{
+	struct usbphy_regs __iomem *usbphy = (struct usbphy_regs __iomem *)usbphy_base;
+
+	if (!is_imx8())
+		return;
+
+	int timeout = 1000000;
+
+	if (!(readl(&usbphy->usb1_pll_480_ctrl) & PLL_USB_LOCK_MASK)) {
+		/* Enable the regulator first */
+		writel(PLL_USB_REG_ENABLE_MASK,
+		       &usbphy->usb1_pll_480_ctrl_set);
+
+		/* Wait at least 25us */
+		udelay(25);
+
+		/* Enable the power */
+		writel(PLL_USB_PWR_MASK, &usbphy->usb1_pll_480_ctrl_set);
+
+		/* Wait lock */
+		while (timeout--) {
+			if (readl(&usbphy->usb1_pll_480_ctrl) &
+			    PLL_USB_LOCK_MASK)
+				break;
+			udelay(10);
+		}
+
+		if (timeout <= 0) {
+			/* If timeout, we power down the pll */
+			writel(PLL_USB_PWR_MASK,
+			       &usbphy->usb1_pll_480_ctrl_clr);
+			return;
+		}
+	}
+
+	/* Clear the bypass */
+	writel(PLL_USB_BYPASS_MASK, &usbphy->usb1_pll_480_ctrl_clr);
+
+	/* Enable the PLL clock out to USB */
+	writel((PLL_USB_EN_USB_CLKS_MASK | PLL_USB_ENABLE_MASK),
+	       &usbphy->usb1_pll_480_ctrl_set);
+}
+#else
+static void __maybe_unused usb_power_config_imx8(void __iomem *usbphy_base) { }
+#endif
+
 #if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT) || \
     defined(CONFIG_IMX8ULP)
 static const ulong phy_bases[] = {
@@ -276,7 +325,6 @@ static void ehci_mx6_powerup_fixup(struct ehci_ctrl *ctrl, uint32_t *status_reg,
 	*reg = ehci_readl(status_reg);
 }
 
-#if !defined(CONFIG_PHY)
 /* Should be done in the MXS PHY driver */
 static void usb_oc_config(struct usbnc_regs *usbnc, int index)
 {
@@ -298,7 +346,30 @@ static void usb_oc_config(struct usbnc_regs *usbnc, int index)
 	clrbits_le32(ctrl, UCTRL_PWR_POL);
 #endif
 }
+
+void ehci_mx6_phy_init(struct usb_ehci *ehci, struct ehci_mx6_phy_data *phy_data, int index)
+{
+	u32 portsc;
+
+	portsc = readl(&ehci->portsc);
+	if (portsc & PORT_PTS_PHCD) {
+		debug("suspended: portsc %x, enabled it.\n", portsc);
+		clrbits_le32(&ehci->portsc, PORT_PTS_PHCD);
+	}
+
+	usb_power_config_mx6(phy_data->anatop_addr, index);
+	usb_power_config_mx7(phy_data->misc_addr);
+	usb_power_config_mx7ulp(phy_data->phy_addr);
+	usb_power_config_imx8(phy_data->phy_addr);
+
+	usb_oc_config(phy_data->misc_addr, index);
+
+#if defined(CONFIG_MX6) || defined(CONFIG_MX7ULP) || defined(CONFIG_IMXRT) || \
+    defined(CONFIG_IMX8) || defined(CONFIG_IMX8ULP)
+	usb_internal_phy_clock_gate(phy_data->phy_addr, 1);
+	usb_phy_enable(ehci, phy_data->phy_addr);
 #endif
+}
 
 #if !CONFIG_IS_ENABLED(DM_USB)
 /**
diff --git a/include/usb/ci_udc.h b/include/usb/ci_udc.h
index 9f15dbabe53..ccef4daf741 100644
--- a/include/usb/ci_udc.h
+++ b/include/usb/ci_udc.h
@@ -6,7 +6,16 @@
 
 #ifndef __CI_UDC_H__
 #define __CI_UDC_H__
+#include <usb/ehci-ci.h>
 
 #define EP_MAX_PACKET_SIZE	0x200
 #define EP0_MAX_PACKET_SIZE	64
+
+struct ehci_mx6_phy_data {
+	void __iomem *phy_addr;
+	void __iomem *misc_addr;
+	void __iomem *anatop_addr;
+};
+
+void ehci_mx6_phy_init(struct usb_ehci *ehci, struct ehci_mx6_phy_data *phy_data, int index);
 #endif /* __CI_UDC_H__ */

-- 
2.43.0

