Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF6D4E77184
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 02:57:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF6E8803CB;
	Fri, 20 Dec 2024 03:56:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="xVo/EFq+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3ADF18036F; Fri, 20 Dec 2024 03:56:13 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20628.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2614::628])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AA87803AB
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 03:56:10 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alice.guo@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdQvEttRemrjrBcYLq4gt4+IFyM3ORvM4qZQvsQOPxJMrSNBBJlVOq/VuGbMQYn75HUbGE4QutmRslYbixPg+PkSgCF4VbT3dwWrTA+TC8yfC/HceL9zaE5VgZakr+08fD4+iIxUDkdaiGhg4hyTkAML7fepbhvxIqir4I8ym0Yt1eD1md43xIx7XGBeqYizSuD5E5TKN5swAexztMwVpkjrexaC87e3GS/ScImbnUu3R8PD1DE6QyL0uzLvRzQUVABKKcr/4UXkzHu5ccYqp7S/zCQmslto+wdN3PJTR//dVIWLO51Ykr1fy2rxIrSrs8+I0wLMwSji3ASJxgmEIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8rnZmhoQh1hB1z5Pi/sFLDfdDvx447JJ4xTtZKmhJMo=;
 b=luXInx7qKk0YndTDgwYWMOPcXwjM6A46a5rx1qSkinbt4SoLEk0AgRYic4/xoHVfGHHHQ2kqTR5rw/uBdM6TbatgtRL1Ym6inVpRJy1JeJbLw3IkmK+PAovEqd9p+dypb+NESFmKtdKnvMUfBnuP6LoXoxrTgsAsO4ukS2Q3z9Eow710X7TCxiIuMeRGlfVHkmhAebpe9twJlq49QlRGs3Ci7dNUlE50a0W1NKh5SBKAg7tQ4NHz298JaEN1S/V0SGZ1Lykgh8XcQ0PnJDv8Fih92vbNi+Gc7IOqGhNaGntNL5ADhfT5LGEVyY/VtnQ2rZJDTauCm4HHwgUSbb3ETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8rnZmhoQh1hB1z5Pi/sFLDfdDvx447JJ4xTtZKmhJMo=;
 b=xVo/EFq+WCmlykyy6obmbM1MwxpOA37V/GMMZ9hSlxPXkYskFuxdzvczIUal/vXly+5jOTrPKwGzweBTQi1wjtjOos8W/zouJd+YKT3MP1CO2Hf2dQMB61XjYtlP5ax6O26O2maoMy+GymZuhOEhyjCdFwHmn5+1FLY5P2HN99ddawh00Y71QIemnt1ft2++wP6pKX/dazSO0i/6w+h+Gp6UxnFZ59Q9tZTi95XtyqPmBnzchdm4eMyG1UORn6PfGp8hQkr4u0EZ/nhQWi+BeZjRC6Xal5ZkAxQ80TvI8dOchxL0mx6yBauwhx+SNT+n++MOOC9jSgImTOY2/YLUkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com (2603:10a6:102:242::11)
 by VI1PR04MB7005.eurprd04.prod.outlook.com (2603:10a6:803:136::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Fri, 20 Dec
 2024 02:56:08 +0000
Received: from PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49]) by PAXPR04MB9644.eurprd04.prod.outlook.com
 ([fe80::6979:311a:bf0c:1a49%5]) with mapi id 15.20.8251.015; Fri, 20 Dec 2024
 02:56:07 +0000
From: Alice Guo <alice.guo@oss.nxp.com>
Date: Fri, 20 Dec 2024 10:55:14 +0800
Subject: [PATCH v2 16/17] imx95_evk: add i.MX95 19x19 EVK board basic support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-imx95-v1-16-ba81dfd8e369@oss.nxp.com>
References: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
In-Reply-To: <20241220-imx95-v1-0-ba81dfd8e369@oss.nxp.com>
To: Tom Rini <trini@konsulko.com>, Stefano Babic <sbabic@denx.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Lukasz Majewski <lukma@denx.de>, 
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>
Cc: u-boot@lists.denx.de, marex@denx.de, Alice Guo <alice.guo@nxp.com>, 
 Ye Li <ye.li@nxp.com>, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734663311; l=25918;
 i=alice.guo@oss.nxp.com; s=20241220; h=from:subject:message-id;
 bh=wyDSkERVfu7u7N2GWNL8FMksGMUW0PMSkyVdeulFMAo=;
 b=yMs8Z2CfgKGUPeGitwOED4Y8I4ub0ZC9DgJEI5jFU8wivIs0mypUcbo42E8Dx6KzvnTNRhUpg
 WcbaiEbJmokDJXiJh/sez2TcNCrekVPpcTvbZZprvwZ7xiQK6row4yE
X-Developer-Key: i=alice.guo@oss.nxp.com; a=ed25519;
 pk=I4wA8H8Q53tsp7q3voqI5LHsTQDw4TELC8szgsg5azM=
X-ClientProxiedBy: SI2PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:194::20) To PAXPR04MB9644.eurprd04.prod.outlook.com
 (2603:10a6:102:242::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9644:EE_|VI1PR04MB7005:EE_
X-MS-Office365-Filtering-Correlation-Id: 2687557d-a2ba-4760-a39b-08dd20a1da06
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eW1wRFYzajJ0eVZtQVBRdERqRnZQMXZ0L0FKMUxwdVJDdkFvbzZCTmkyM2pQ?=
 =?utf-8?B?U3Y0WDhUWDZyS2dJWVlUa3FYTWJDbDNMQ3orWVhLYUJOc0FsQ3ZVVEU1NVdQ?=
 =?utf-8?B?QUd2bFVtdHBDcU1ab3VxWHpMWDFZWHZMUldzUFd0ZzV5bGNuZmZXMzRMZ3Fw?=
 =?utf-8?B?VUloWnozSDcvVVc5REwvVk1qRUo4TEZ5Tnhjb0VZOGhQT2NMczJSclRqbzR4?=
 =?utf-8?B?N29vZU9EMkZ1eEVYd0NvZU01RWdVQ1doUXpVS2N0YjB5SkVnZmR0NXVWaVhu?=
 =?utf-8?B?U3NkbUNQQ2xDdXU0Nmx5MzJoZEVIL1dQN0pVbFJIMitFeUJPNGVTbExKb2Rp?=
 =?utf-8?B?c2s1Tmx1Rk91bGtWNkZyYmJKcDNuUWxsM2JPR25FTTlCWFUxRzk1N1AwY0Vy?=
 =?utf-8?B?SEd6SVQva0JQbEJMZDlQN09Eaktld3IyQXQ5SGxZditxL1VNZ0VLVjd2bW0y?=
 =?utf-8?B?TzZlRkNLRmJ5M2hVWWg2TnQvOFdRVlYvdkZnMUJycmFTdnZZSzI4Qlh6bDhR?=
 =?utf-8?B?czdBamxpMmNSVUVjbEdXQ21CMkRNMjhtNWVBRGY4VHEyYXArNUltK1ZTTDN2?=
 =?utf-8?B?eTZPbGVsa3JiampMcUU0NkV4USszVDNkS1o1OE9lYUJnMk1lZTkrei85WDlI?=
 =?utf-8?B?SXg0WVNtbFhFenVnQjIwTzdnbGsxWW9uY0RWWTZHM2dUQ2hwaEp5QUZsKzgw?=
 =?utf-8?B?eTJ3RlYvTnlKM01EODIyc2FBNU5HeThGZ3BPOU9KSk9qQXBuMEplVWMvUHp0?=
 =?utf-8?B?S0xKL0QxeGZsWFFNSXZRZU92NSs5eDRzZGlaQm0zaUs1aEdnbTB0aGt2Zit4?=
 =?utf-8?B?QktyYmxjMURpbGFZNWJTZjMxQVBudGYvMG90WjB2bHBGdGVBZW9OV09hditQ?=
 =?utf-8?B?NzZBaDhtcThrYnI5MjFuZTBxcUJPVUFHRzZGUWM4WlVwM2RBT1ozbEtFRzl1?=
 =?utf-8?B?dEJnaGt1YXZRdThpZ2FiL2MyaXhYSkRjdkwzZzIycU1FSStReFJiZ1ZBbXNZ?=
 =?utf-8?B?TzRBQXFFZkt1RXhhR3QxcEFSVzdBNjRIcmNxWWtUejR2aHV3ZU5MMDJhMXYx?=
 =?utf-8?B?cElkQVdrRnBtcERkVkV0aFJMQ0JYendmS3lLbm5YdmF5RUtDcFM5MDVLeisr?=
 =?utf-8?B?SnN4a2x3WTNrK2ZYL1BWSit4V1FUVkdnTVBGeCt1bGFlKzFldlQ1YnhZWGNK?=
 =?utf-8?B?czlldU5ZeGplbHgvVHlyaFkzeTRwaHNpQ090bGhVZXUrSHEzM2x1Mk5tTnZw?=
 =?utf-8?B?c0dzT3pRc0JHWUVjSDhvbERlZnRoOFZXOGJjNFJESzJBcEovbks2T0xrVkpH?=
 =?utf-8?B?ZU9HK29Vbk9INTd3Ukc5NUxPZ3JqWm1iMHpkTnRBZDJtRFVFbExBNjhFbURN?=
 =?utf-8?B?Ly9ORmZlbSszYW1WRHFGWTJscDV3NGhieVBvY2VsU0wxNkNKWXRPRFU5b3lQ?=
 =?utf-8?B?T1VoemIya21EaWQ2REZUa2swWDNMbDR1TnFYWGZPKy94a1dLV3BFcTVGZnZF?=
 =?utf-8?B?bDRjL0RTRVM5eHdqTWFKMTFRcEdERVduU3prOHJpKzQ3S2x1bE9rajJqcUI1?=
 =?utf-8?B?SmxVRnRQUzBtNUJjc3VEK1prVVh2c3JDMHNYeStBTTM1K0ZBVGJqYmJsSytq?=
 =?utf-8?B?M3NUR1dFZVZFU1VxU2FZdmpQSkFSbzFYM0RVamhqeHlaSnVCMDlLNk1jSStM?=
 =?utf-8?B?NVVuR0lCaUZSbHFBUUdRT2VJTGxMS2VGWWFhOFlSOHh6NkxNTXdvZU40bTdr?=
 =?utf-8?B?RTBXWitrbGtxc21UM3VrWFllZEZYQ1l4SWdxM1AxcGVBUUk2OGI1U3pGeTNK?=
 =?utf-8?B?ZGltWkJvVHJNZytMMVo2Zlc3Uk5FcG0wYUtxVlcwZjlodnFSbjB0V0p5NVNy?=
 =?utf-8?B?S2h4TFIrTHVDTjVmRTFNMGgzaXo2bzJZMzdpOVVIMjllMlE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9644.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2MxK0NTT0dWY29FaWVtdzFkdFYrSGxWc1NMNFQ5L0pEZk1sc2xvclJkaDY1?=
 =?utf-8?B?YXl1dnA2blQ3UEo2RVRJeXZObll5a0ZJTlJsL2x5Ykl5cUw2OTZZME5MaTdJ?=
 =?utf-8?B?a01ycmp0b25mOUJUS1UvenZBa1VubTZ5V3h2ZXFMRWdrUm1WOHB4aHFMdWlw?=
 =?utf-8?B?akpRRWJuMjZjSzVybXM4SmpSczk5RVVPZEwzQUpYSXc1K2ZkL2dOMkRhNFpp?=
 =?utf-8?B?elQvWml5SlMxUTdWMnI4Sisrd1BnR00zVlNJcW1UZHhsbmtONk9YU3d2Mndk?=
 =?utf-8?B?T2xobnhGWEtFaW9URzYrVXZPYzlPSTFQamhQY2NhR3hRakZuV0xCZ3Eycmx5?=
 =?utf-8?B?Q0cvL2M0SEJZTGdiNG5GZmJ0bE9sS2c1dk5EL3RSNGhsL3M3WkRWY0tRL1hu?=
 =?utf-8?B?OHViODQ1aHU5ekxXMUlXM2wwYmRlYy8zdXlETHhEazlQbzRHTkZXMHJVaG9a?=
 =?utf-8?B?Y3lmWjFMZDArY25HRkRkTlk4YXpYT1RwMEhzeU1iZ1UxMHc0ZitzVVBBUU90?=
 =?utf-8?B?Rjd3OHZsaDAveitYY2ZQR3VzMFFSNUE1QURkdDMxVU50d25vQVV5OW8yRzlK?=
 =?utf-8?B?R0Z6VnlEMWZHb0dVVnoydDUxYzYwT21zckVCQzE2ZkNMQXVwQnJDendJOHYy?=
 =?utf-8?B?UDVRcUFaR2FEVDJxaUVSdldpMFdUdlRmTEhWc0g2MGttb0pISmlZdnBBQjBa?=
 =?utf-8?B?OEhZUktXbHVXT0x5RUNLSTd1RG04TGNpM2x4RTgvL29IYkVEdDUzU0FiZUZ2?=
 =?utf-8?B?a0c0YXdXRmJiRXdKWHNQYjR2S2xSTVBYVkhkOHdlMzkvdEZUMnUxTHdRS2l1?=
 =?utf-8?B?VVZYMnJxQnZ3dXp2Q1V0ekZzWk9TSUVCN2wzd0JpZzFrTTc4MGh5dldSL0cv?=
 =?utf-8?B?MENhL1pWRkZ1ZVNEcHhJOXdzOWYrZUNSTVdaVnFpeGU3QXNBaytnOGsremR2?=
 =?utf-8?B?a1hPNWhNdmNHSnI3VlA5RFA5TDh4WmhZVVRVSnJycXIyanlOUGIvQ1hCVDdS?=
 =?utf-8?B?bmZ5MDVpZTQ2dnd0K0x2VisyODZ4dE0xSzVBNExKVyt1c0JKZEMxTG5xa0lC?=
 =?utf-8?B?SkpNT0FMZ2JpbFpob2RxaVJSMVRYQndOZDk4QURNSnByNkJFWFhiTjVYWTc2?=
 =?utf-8?B?a3R6a0t3QmtLT2JLLzlBRmFnbVN0UzNSd3RwWjlOVmE4ZnFnWW9qSEtNcW5B?=
 =?utf-8?B?N01tTVRrTk1UMHNYSWJ0ZS9ZL0RFSnNyVXRSZ09ZU0lRVHdyclQvbGlONWx6?=
 =?utf-8?B?NDB4Qk53V29URU9SVHJLcldhanlSMW52dnZwK0RucFJTQ0VDQXl3UVg0enNt?=
 =?utf-8?B?WnZaM2NkTTd5emU1cFYydjRyeVJOVks4Y29wMENXTERZb0c4WS9uS3ZmUURn?=
 =?utf-8?B?eUpqU3hJVk9MQ1BoWFdLQXRlc1hpTDhXUUFEODEvZ3pQZjc0bXVvYUhaQ01H?=
 =?utf-8?B?YlRGQzFTMFlpZFFWbDZhUWJGSWhNY2p6OThtdUc3SU94RzQzYmE1ZDFlVEox?=
 =?utf-8?B?b1FDYTU4RXZPVDMyUWNGRjd0MWYzVmlYSEUxeXNVN3pwNlUvOTM0TU1ZdDJa?=
 =?utf-8?B?RkU4Q0RQc1JqbHBHU2hTYlkrTkNMeVdPWlJQUUhSTENHZzFhRFduUmE2cWJu?=
 =?utf-8?B?dUtUU1lTWFRKT0tvQ3d5RC9yUitRUTRpMnZRbW8yaWhiczlqUTVGMmRJbzkz?=
 =?utf-8?B?ejR6MUMvWHJYL3V5YmFjRTd0eGJMNk1YRG51cUtMTjRUbUxYK3g1bmsyTDRF?=
 =?utf-8?B?MC84cWhza3FPMktOY1c4VjVzZDBqRTVrRnhob2dXbDJodDc5Uys2SDZJT2xx?=
 =?utf-8?B?MnVxWkpiaFducWpmM1ZrWkVuWURBNUVWMDU2S0tXNmZLVnRINVRJK1Fxa3dH?=
 =?utf-8?B?U2tlbVVxTE9lVXoramhiQk9JU3UvdXM1ODFUbjB1Y1o0MDRwUXhJYVFZRmZV?=
 =?utf-8?B?d1poYjh2Z2RWR050bExncmVITCtTaS9acnQwaEhXbWNqL0ZNc0R0STNxODlU?=
 =?utf-8?B?dWw1T3pPc3d5aEVtNC9mWXdxdFlyYXFlVWJrbjVYWmJva3B4bmdjejFIR3lN?=
 =?utf-8?B?TWU4U2plNEtzb0hLUGdRWmNUOWYxZkloVEhGaFVLZFlKalR6Q1NKWUlzb215?=
 =?utf-8?Q?E1+wOxLnHggS0j38yjDDTz9gb?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2687557d-a2ba-4760-a39b-08dd20a1da06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9644.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 02:56:07.8088 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rWbEGobTiA/g1ZZ8gJYLFITIekl7wnz74MNvoecwa6eVcKUlpX53KRIf07oAZAwFwbGBF1AvACtcd3/aYAH/uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7005
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

This patch adds i.MX95 19x19 EVK board basic support.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/dts/imx95-19x19-evk-u-boot.dtsi      | 224 ++++++++++++++++++++++++++
 arch/arm/mach-imx/imx9/Kconfig                |   6 +
 arch/arm/mach-imx/imx9/scmi/container.cfg     |  10 ++
 arch/arm/mach-imx/imx9/scmi/imximage.cfg      |  15 ++
 arch/arm/mach-imx/imx9/scmi/soc.c             |   1 +
 board/freescale/imx95_evk/Kconfig             |  12 ++
 board/freescale/imx95_evk/MAINTAINERS         |   6 +
 board/freescale/imx95_evk/Makefile            |  11 ++
 board/freescale/imx95_evk/imx95_19x19_evk.env |  95 +++++++++++
 board/freescale/imx95_evk/imx95_evk.c         |  54 +++++++
 board/freescale/imx95_evk/spl.c               | 117 ++++++++++++++
 configs/imx95_19x19_evk_defconfig             | 178 ++++++++++++++++++++
 doc/board/nxp/imx95_evk.rst                   | 109 +++++++++++++
 doc/board/nxp/index.rst                       |   1 +
 include/configs/imx95_evk.h                   |  36 +++++
 15 files changed, 875 insertions(+)

diff --git a/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
new file mode 100644
index 0000000000000000000000000000000000000000..5c891518448d24204f5ca2a00957b47a0a24bd70
--- /dev/null
+++ b/arch/arm/dts/imx95-19x19-evk-u-boot.dtsi
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifdef CONFIG_BINMAN
+/ {
+	binman {
+		multiple-images;
+
+		m33-oei-ddrfw {
+			filename = "m33-oei-ddrfw.bin";
+
+			nxp-append-ddrfw {
+				oei_m33_ddr_image = "oei-m33-ddr.bin";
+				lpddr_imem = "lpddr5_imem_v202311.bin";
+				lpddr_dmem = "lpddr5_dmem_v202311.bin";
+				lpddr_imem_qb = "lpddr5_imem_qb_v202311.bin";
+				lpddr_dmem_qb = "lpddr5_dmem_qb_v202311.bin";
+			};
+		};
+
+		spl {
+			filename = "spl.bin";
+
+			mkimage {
+				args = "-n spl/u-boot-spl.cfgout -T imx8image";
+			};
+		};
+
+		u-boot {
+			filename = "uboot.bin";
+
+			mkimage {
+				args = "-n u-boot-container.cfgout -T imx8image";
+			};
+		};
+
+		imx-boot {
+			filename = "imx-boot-imx95.bin";
+			pad-byte = <0x00>;
+
+			blob-ext@1 {
+				align = <0x400>;
+				align-size = <0x400>;
+				offset = <0x0>;
+				filename = "spl.bin";
+			};
+
+			blob-ext@2 {
+				filename = "uboot.bin";
+			};
+		};
+	};
+};
+#endif
+
+&{/soc} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips2 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&aips3 {
+	bootph-pre-ram;
+};
+
+&gpio1 {
+	reg = <0 0x47400000 0 0x1000>, <0 0x47400040 0 0x40>;
+};
+
+&gpio2 {
+	reg = <0 0x43810000 0 0x1000>, <0 0x43810040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio3 {
+	reg = <0 0x43820000 0 0x1000>, <0 0x43820040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio4 {
+	reg = <0 0x43840000 0 0x1000>, <0 0x43840040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&gpio5 {
+	reg = <0 0x43850000 0 0x1000>, <0 0x43850040 0 0x40>;
+	bootph-pre-ram;
+};
+
+&lpuart1 {
+	clocks = <&scmi_clk IMX95_CLK_LPUART1>, <&scmi_clk IMX95_CLK_LPUART1>;
+	clock-names = "ipg", "per";
+	bootph-pre-ram;
+};
+
+&mu2 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&osc_24m {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&clk_ext1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&sram0 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&scmi_buf0 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&scmi_buf1 {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@11} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@13} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@14} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&{/firmware/scmi/protocol@19} {
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&pinctrl_uart1 {
+	bootph-pre-ram;
+};
+
+&usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc1_200mhz {
+	bootph-pre-ram;
+};
+
+&usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2 {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_100mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_200mhz {
+	bootph-pre-ram;
+};
+
+&pinctrl_usdhc2_gpio {
+	bootph-pre-ram;
+};
+
+&reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&pinctrl_reg_usdhc2_vmmc {
+	bootph-pre-ram;
+};
+
+&elemu3 {
+	compatible = "fsl,imx93-mu-s4";
+	status = "okay";
+	bootph-all;
+	bootph-pre-ram;
+};
+
+&wdog3 {
+	status = "disabled";
+};
diff --git a/arch/arm/mach-imx/imx9/Kconfig b/arch/arm/mach-imx/imx9/Kconfig
index 596e753f2897c11d7ca3bcc9211af786d005bfd9..1ba277baeb353de301a1e67a7adf70f281752ded 100644
--- a/arch/arm/mach-imx/imx9/Kconfig
+++ b/arch/arm/mach-imx/imx9/Kconfig
@@ -66,6 +66,11 @@ config TARGET_PHYCORE_IMX93
 	select OF_BOARD_FIXUP
 	select OF_BOARD_SETUP
 
+config TARGET_IMX95_19X19_EVK
+	bool "imx95_19x19_evk"
+	select IMX95
+	imply OF_UPSTREAM
+
 endchoice
 
 source "board/freescale/imx91_evk/Kconfig"
@@ -73,6 +78,7 @@ source "board/freescale/imx93_evk/Kconfig"
 source "board/freescale/imx93_qsb/Kconfig"
 source "board/phytec/phycore_imx93/Kconfig"
 source "board/variscite/imx93_var_som/Kconfig"
+source "board/freescale/imx95_evk/Kconfig"
 
 endif
 
diff --git a/arch/arm/mach-imx/imx9/scmi/container.cfg b/arch/arm/mach-imx/imx9/scmi/container.cfg
new file mode 100644
index 0000000000000000000000000000000000000000..29f346e59c4afd0c2689667abe36f4b776b29ba8
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/container.cfg
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+CONTAINER
+IMAGE A55 bl31.bin 0x8a200000
+IMAGE A55 u-boot.bin CONFIG_TEXT_BASE
\ No newline at end of file
diff --git a/arch/arm/mach-imx/imx9/scmi/imximage.cfg b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
new file mode 100644
index 0000000000000000000000000000000000000000..c90432f5efa78dccb2c67e237b88a96174446b96
--- /dev/null
+++ b/arch/arm/mach-imx/imx9/scmi/imximage.cfg
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+BOOT_FROM SD
+SOC_TYPE IMX9
+APPEND mx95a0-ahab-container.img
+CONTAINER
+IMAGE OEI m33-oei-ddrfw.bin 0x1ffc0000
+HOLD 0x10000
+IMAGE OEI oei-m33-tcm.bin 0x1ffc0000
+IMAGE M33 m33_image.bin 0x1ffc0000
+IMAGE A55 spl/u-boot-spl.bin 0x20480000
+DUMMY_V2X 0x8b000000
\ No newline at end of file
diff --git a/arch/arm/mach-imx/imx9/scmi/soc.c b/arch/arm/mach-imx/imx9/scmi/soc.c
index 8a7df24afecc1d6d77b7162be639b56af95fd975..38ade99964b64512ba93423efcaa0cfb58094b00 100644
--- a/arch/arm/mach-imx/imx9/scmi/soc.c
+++ b/arch/arm/mach-imx/imx9/scmi/soc.c
@@ -43,6 +43,7 @@
 #endif
 #include <spl.h>
 #include <mmc.h>
+#include <asm/arch/mu.h>
 
 DECLARE_GLOBAL_DATA_PTR;
 
diff --git a/board/freescale/imx95_evk/Kconfig b/board/freescale/imx95_evk/Kconfig
new file mode 100644
index 0000000000000000000000000000000000000000..f9a67353e5db6d3ec94784cf091e45d8817d541c
--- /dev/null
+++ b/board/freescale/imx95_evk/Kconfig
@@ -0,0 +1,12 @@
+if TARGET_IMX95_19X19_EVK
+
+config SYS_BOARD
+	default "imx95_evk"
+
+config SYS_VENDOR
+	default "freescale"
+
+config SYS_CONFIG_NAME
+	default "imx95_evk"
+
+endif
diff --git a/board/freescale/imx95_evk/MAINTAINERS b/board/freescale/imx95_evk/MAINTAINERS
new file mode 100644
index 0000000000000000000000000000000000000000..5caf763e0cc390c46fc54ee627bc966b2b110958
--- /dev/null
+++ b/board/freescale/imx95_evk/MAINTAINERS
@@ -0,0 +1,6 @@
+i.MX95 EVK BOARD
+M:	Alice Guo <alice.guo@nxp.com>
+S:	Maintained
+F:	board/freescale/imx95_evk/
+F:	include/configs/imx95_evk.h
+F:	configs/imx95_19x19_evk_defconfig
diff --git a/board/freescale/imx95_evk/Makefile b/board/freescale/imx95_evk/Makefile
new file mode 100644
index 0000000000000000000000000000000000000000..a278d58ee0085176948b812703d120aaad3a3116
--- /dev/null
+++ b/board/freescale/imx95_evk/Makefile
@@ -0,0 +1,11 @@
+#
+# Copyright 2024 NXP
+#
+# SPDX-License-Identifier:      GPL-2.0+
+#
+
+obj-y += imx95_evk.o
+
+ifdef CONFIG_SPL_BUILD
+obj-y += spl.o
+endif
diff --git a/board/freescale/imx95_evk/imx95_19x19_evk.env b/board/freescale/imx95_evk/imx95_19x19_evk.env
new file mode 100644
index 0000000000000000000000000000000000000000..27e09d3d70a068efb97d69b27089d1f213f39ee9
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_19x19_evk.env
@@ -0,0 +1,95 @@
+sec_boot=no
+initrd_addr=0x93800000
+emmc_dev=0
+sd_dev=1
+prepare_mcore=setenv mcore_clk clk-imx95.mcore_booted
+scriptaddr=0x93500000
+kernel_addr_r=" __stringify(CONFIG_SYS_LOAD_ADDR) "
+image=Image
+splashimage=0xA0000000
+console=ttyLP0,115200 earlycon
+fdt_addr_r=0x93000000
+fdt_addr=0x93000000
+cntr_addr=0xA8000000
+cntr_file=os_cntr_signed.bin
+boot_fit=no
+fdtfile=" CONFIG_DEFAULT_FDT_FILE "
+bootm_size=0x10000000
+mmcdev=" __stringify(CONFIG_SYS_MMC_ENV_DEV)"
+mmcpart=1
+mmcroot=/dev/mmcblk1p2 rootwait rw
+mmcautodetect=yes
+mmcargs=setenv bootargs ${mcore_clk} console=${console} root=${mmcroot}
+loadbootscript=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${script};
+bootscript=echo Running bootscript from mmc ...; source
+loadimage=fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} ${image}
+loadfdt=fatload mmc ${mmcdev}:${mmcpart} ${fdt_addr_r} ${fdtfile}
+loadcntr=fatload mmc ${mmcdev}:${mmcpart} ${cntr_addr} ${cntr_file}
+auth_os=auth_cntr ${cntr_addr}
+boot_os=booti ${loadaddr} - ${fdt_addr_r};
+mmcboot=echo Booting from mmc ...;
+		run mmcargs;
+		if test ${sec_boot} = yes; then
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if run loadfdt; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+netargs=setenv bootargs ${mcore_clk} console=${console}
+		root=/dev/nfs
+		ip=dhcp nfsroot=${serverip}:${nfsroot},v3,tcp
+netboot=echo Booting from net ...;
+		run netargs;
+		if test ${ip_dyn} = yes; then
+			setenv get_cmd dhcp;
+		else
+			setenv get_cmd tftp;
+		fi;
+		if test ${sec_boot} = yes; then
+			${get_cmd} ${cntr_addr} ${cntr_file};
+			if run auth_os; then
+				run boot_os;
+			else
+				echo ERR: failed to authenticate;
+			fi;
+		else
+			${get_cmd} ${loadaddr} ${image};
+			if test ${boot_fit} = yes || test ${boot_fit} = try; then
+				bootm ${loadaddr};
+			else
+				if ${get_cmd} ${fdt_addr_r} ${fdtfile}; then
+					run boot_os;
+				else
+					echo WARN: Cannot load the DT;
+				fi;
+			fi;
+		fi;
+bsp_bootcmd=echo Running BSP bootcmd ...;
+			mmc dev ${mmcdev}; if mmc rescan; then
+			if run loadbootscript; then
+				run bootscript;
+			else
+				if test ${sec_boot} = yes; then
+					if run loadcntr; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				else
+					if run loadimage; then
+						run mmcboot;
+					else run netboot;
+					fi;
+				fi;
+			fi;
+		fi;
\ No newline at end of file
diff --git a/board/freescale/imx95_evk/imx95_evk.c b/board/freescale/imx95_evk/imx95_evk.c
new file mode 100644
index 0000000000000000000000000000000000000000..c75a8f2450288a34cfc01150d3c42b07f2215491
--- /dev/null
+++ b/board/freescale/imx95_evk/imx95_evk.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <env.h>
+#include <init.h>
+#include <asm/global_data.h>
+#include <asm/arch-imx9/ccm_regs.h>
+#include <asm/arch/clock.h>
+#include <fdt_support.h>
+#include <asm/io.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <miiphy.h>
+#include <netdev.h>
+#include <asm/gpio.h>
+#include <asm/mach-imx/sys_proto.h>
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int board_early_init_f(void)
+{
+	/* UART1: A55, UART2: M33, UART3: M7 */
+	init_uart_clk(0);
+
+	return 0;
+}
+
+int board_init(void)
+{
+	return 0;
+}
+
+int board_late_init(void)
+{
+#ifdef CONFIG_ENV_IS_IN_MMC
+	board_late_mmc_env_init();
+#endif
+
+	return 0;
+}
+
+int board_phys_sdram_size(phys_size_t *size)
+{
+	*size = PHYS_SDRAM_SIZE + PHYS_SDRAM_2_SIZE;
+
+	return 0;
+}
diff --git a/board/freescale/imx95_evk/spl.c b/board/freescale/imx95_evk/spl.c
new file mode 100644
index 0000000000000000000000000000000000000000..006239f0751f9264d44304828bc9b9a26465abd1
--- /dev/null
+++ b/board/freescale/imx95_evk/spl.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2024 NXP
+ */
+
+#include <command.h>
+#include <cpu_func.h>
+#include <clk.h>
+#include <hang.h>
+#include <image.h>
+#include <init.h>
+#include <log.h>
+#include <spl.h>
+#include <asm/global_data.h>
+#include <asm/io.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/sys_proto.h>
+#include <asm/mach-imx/boot_mode.h>
+#include <asm/mach-imx/syscounter.h>
+#include <asm/mach-imx/ele_api.h>
+#include <asm/sections.h>
+#include <dm/uclass.h>
+#include <dm/device.h>
+#include <dm/uclass-internal.h>
+#include <dm/device-internal.h>
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <asm/arch/clock.h>
+#include <asm/arch/ccm_regs.h>
+#ifdef CONFIG_SCMI_FIRMWARE
+#include <scmi_agent.h>
+#include <scmi_protocols.h>
+#include "../../../dts/upstream/src/arm64/freescale/imx95-clock.h"
+#include "../../../dts/upstream/src/arm64/freescale/imx95-power.h"
+#endif
+#include <asm/arch/mu.h>
+
+DECLARE_GLOBAL_DATA_PTR;
+
+int spl_board_boot_device(enum boot_device boot_dev_spl)
+{
+	switch (boot_dev_spl) {
+	case SD1_BOOT:
+	case MMC1_BOOT:
+		return BOOT_DEVICE_MMC1;
+	case SD2_BOOT:
+	case MMC2_BOOT:
+		return BOOT_DEVICE_MMC2;
+	case USB_BOOT:
+		return BOOT_DEVICE_BOARD;
+	default:
+		return BOOT_DEVICE_NONE;
+	}
+}
+
+void spl_board_init(void)
+{
+	puts("Normal Boot\n");
+}
+
+void board_init_f(ulong dummy)
+{
+	int ret;
+	bool ddrmix_power = false;
+
+	/* Clear the BSS. */
+	memset(__bss_start, 0, __bss_end - __bss_start);
+
+#ifdef CONFIG_SPL_RECOVER_DATA_SECTION
+	if (IS_ENABLED(CONFIG_SPL_BUILD))
+		spl_save_restore_data();
+#endif
+
+	timer_init();
+
+	/* Need dm_init() to run before any SCMI calls can be made. */
+	spl_early_init();
+
+	/* Need enable SCMI drivers and ELE driver before enabling console */
+	ret = imx9_probe_mu();
+	if (ret)
+		hang(); /* if MU not probed, nothing can output, just hang here */
+
+	arch_cpu_init();
+
+	board_early_init_f();
+
+	preloader_console_init();
+
+	debug("SOC: 0x%x\n", gd->arch.soc_rev);
+	debug("LC: 0x%x\n", gd->arch.lifecycle);
+
+	/* Will set ARM freq to max rate */
+	clock_init_late();
+
+	/* Check is DDR MIX is already powered up. */
+	u32 state = 0;
+	struct udevice *dev;
+
+	ret = uclass_get_device_by_name(UCLASS_CLK, "protocol@14", &dev);
+	if (ret)
+		printf("%s: %d\n", __func__, ret);
+
+	ret = scmi_pwd_state_get(dev, IMX95_PD_DDR, &state);
+	if (ret) {
+		printf("scmi_pwd_state_get Failed %d for DDRMIX\n", ret);
+	} else {
+		if (state == BIT(30)) {
+			panic("DDRMIX is powered OFF, Please initialize DDR with OEI \n");
+		} else {
+			printf("DDRMIX is powered UP \n");
+			ddrmix_power = true;
+		}
+	}
+
+	board_init_r(NULL, 0);
+}
diff --git a/configs/imx95_19x19_evk_defconfig b/configs/imx95_19x19_evk_defconfig
new file mode 100644
index 0000000000000000000000000000000000000000..23c7ebf4694a9d2cf2604528b142ce716e66b85a
--- /dev/null
+++ b/configs/imx95_19x19_evk_defconfig
@@ -0,0 +1,178 @@
+CONFIG_ARM=y
+CONFIG_ARCH_IMX9=y
+CONFIG_TEXT_BASE=0x90200000
+CONFIG_SYS_MALLOC_LEN=0x2000000
+CONFIG_SYS_MALLOC_F_LEN=0x10000
+CONFIG_SPL_LIBCOMMON_SUPPORT=y
+CONFIG_SPL_LIBGENERIC_SUPPORT=y
+CONFIG_NR_DRAM_BANKS=3
+CONFIG_ENV_SIZE=0x4000
+CONFIG_ENV_OFFSET=0x700000
+CONFIG_ENV_SECT_SIZE=0x10000
+CONFIG_DM_GPIO=y
+CONFIG_DEFAULT_DEVICE_TREE="freescale/imx95-19x19-evk"
+CONFIG_SPL_TEXT_BASE=0x20480000
+CONFIG_TARGET_IMX95_19X19_EVK=y
+CONFIG_SYS_PROMPT="u-boot=> "
+CONFIG_SPL_SERIAL=y
+CONFIG_SPL_DRIVERS_MISC=y
+CONFIG_SPL_STACK=0x204d6000
+CONFIG_SPL=y
+CONFIG_SPL_LOAD_IMX_CONTAINER=y
+CONFIG_IMX_CONFIG="arch/arm/mach-imx/imx9/scmi/imximage.cfg"
+CONFIG_IMX_CONTAINER_CFG="arch/arm/mach-imx/imx9/scmi/container.cfg"
+CONFIG_SYS_LOAD_ADDR=0x90400000
+CONFIG_SYS_MEMTEST_START=0x90000000
+CONFIG_SYS_MEMTEST_END=0xA0000000
+CONFIG_REMAKE_ELF=y
+CONFIG_SYS_MONITOR_LEN=524288
+CONFIG_DEFAULT_FDT_FILE="imx95-19x19-evk.dtb"
+CONFIG_ARCH_MISC_INIT=y
+CONFIG_BOARD_EARLY_INIT_F=y
+CONFIG_BOARD_LATE_INIT=y
+CONFIG_SPL_MAX_SIZE=0x20000
+CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
+CONFIG_SPL_BSS_START_ADDR=0x204d6000
+CONFIG_SPL_BSS_MAX_SIZE=0x2000
+CONFIG_SPL_BOARD_INIT=y
+CONFIG_SPL_MMC=y
+CONFIG_SPL_GPIO=y
+# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
+CONFIG_SPL_SYS_MALLOC=y
+CONFIG_SPL_HAS_CUSTOM_MALLOC_START=y
+CONFIG_SPL_CUSTOM_SYS_MALLOC_ADDR=0x93200000
+CONFIG_SPL_SYS_MALLOC_SIZE=0x80000
+CONFIG_SPL_SYS_MMCSD_RAW_MODE=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR=y
+CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR=0x1040
+CONFIG_SPL_POWER=y
+CONFIG_SDP_LOADADDR=0x90400000
+CONFIG_SPL_WATCHDOG=y
+CONFIG_SYS_MAXARGS=64
+CONFIG_SYS_CBSIZE=2048
+CONFIG_SYS_PBSIZE=2074
+CONFIG_CMD_ERASEENV=y
+CONFIG_CMD_NVEDIT_EFI=y
+CONFIG_CMD_CRC32=y
+CONFIG_CRC32_VERIFY=y
+CONFIG_CMD_MEMTEST=y
+CONFIG_CMD_CLK=y
+CONFIG_CMD_DFU=y
+CONFIG_CMD_FUSE=y
+CONFIG_CMD_GPIO=y
+CONFIG_CMD_GPT=y
+CONFIG_CMD_I2C=y
+CONFIG_CMD_MMC=y
+CONFIG_CMD_PART=y
+CONFIG_CMD_POWEROFF=y
+CONFIG_CMD_DHCP=y
+CONFIG_CMD_MII=y
+CONFIG_CMD_PING=y
+CONFIG_CMD_SNTP=y
+CONFIG_CMD_CACHE=y
+CONFIG_CMD_EFIDEBUG=y
+CONFIG_CMD_RTC=y
+CONFIG_CMD_TIME=y
+CONFIG_CMD_GETTIME=y
+CONFIG_CMD_TIMER=y
+CONFIG_CMD_REGULATOR=y
+CONFIG_CMD_HASH=y
+CONFIG_CMD_EXT2=y
+CONFIG_CMD_EXT4=y
+CONFIG_CMD_EXT4_WRITE=y
+CONFIG_CMD_FAT=y
+CONFIG_CMD_FS_GENERIC=y
+CONFIG_OF_CONTROL=y
+CONFIG_SPL_OF_CONTROL=y
+CONFIG_ENV_OVERWRITE=y
+CONFIG_ENV_IS_NOWHERE=y
+CONFIG_ENV_IS_IN_MMC=y
+CONFIG_SYS_RELOC_GD_ENV_ADDR=y
+CONFIG_SYS_MMC_ENV_DEV=1
+CONFIG_ENV_VARS_UBOOT_RUNTIME_CONFIG=y
+CONFIG_USE_ETHPRIME=y
+CONFIG_ETHPRIME="eth0"
+CONFIG_NET_RANDOM_ETHADDR=y
+CONFIG_SPL_DM=y
+CONFIG_REGMAP=y
+CONFIG_SYSCON=y
+CONFIG_DFU_MMC=y
+CONFIG_DFU_RAM=y
+CONFIG_IMX_RGPIO2P=y
+CONFIG_MTD=y
+CONFIG_DM_SPI_FLASH=y
+CONFIG_DM_SPI=y
+CONFIG_NXP_FSPI=y
+CONFIG_SPI=y
+CONFIG_SPI_FLASH_STMICRO=y
+CONFIG_SPI_FLASH_MT35XU=y
+CONFIG_SF_DEFAULT_BUS=0
+CONFIG_SF_DEFAULT_SPEED=40000000
+CONFIG_DM_PCA953X=y
+CONFIG_DM_I2C=y
+CONFIG_SYS_I2C_IMX_LPI2C=y
+CONFIG_SUPPORT_EMMC_BOOT=y
+CONFIG_MMC_IO_VOLTAGE=y
+CONFIG_MMC_UHS_SUPPORT=y
+CONFIG_MMC_HS400_ES_SUPPORT=y
+CONFIG_MMC_HS400_SUPPORT=y
+CONFIG_FSL_USDHC=y
+CONFIG_PHY=y
+CONFIG_MII=y
+CONFIG_PINCTRL=y
+CONFIG_SPL_PINCTRL=y
+CONFIG_SPL_DM_REGULATOR=y
+CONFIG_SPL_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR=y
+CONFIG_DM_REGULATOR_FIXED=y
+CONFIG_DM_REGULATOR_GPIO=y
+CONFIG_DM_RTC=y
+CONFIG_DM_SERIAL=y
+CONFIG_FSL_LPUART=y
+CONFIG_ULP_WATCHDOG=y
+CONFIG_LZO=y
+CONFIG_BZIP2=y
+CONFIG_HUSH_PARSER=y
+CONFIG_OF_LIBFDT_OVERLAY=y
+CONFIG_OF_SYSTEM_SETUP=y
+CONFIG_ADP5585_GPIO=y
+CONFIG_SPL_I2C=y
+CONFIG_POWER_DOMAIN=y
+# SCMI options
+CONFIG_DM_MAILBOX=y
+CONFIG_SCMI_FIRMWARE=y
+CONFIG_SCMI_AGENT_SMCCC=n
+CONFIG_CLK_SCMI=y
+CONFIG_CLK=y
+CONFIG_SPL_CLK_SCMI=y
+CONFIG_SPL_CLK=y
+CONFIG_PINCTRL_IMX_SCMI=y
+CONFIG_SCMI_POWER_DOMAIN=y
+CONFIG_SPL_DM_MAILBOX=y
+CONFIG_SPL_FIRMWARE=y
+#CONFIG_SPL_POWER_DOMAIN=y
+CONFIG_SPL_IMX_MU_MBOX=y
+CONFIG_IMX_MU_MBOX=y
+#CONFIG_REMOTEPROC_SCMI_LMM=y
+#CONFIG_CMD_REMOTEPROC=y
+# CONFIG_RESET_SCMI=y
+# CONFIG_DM_REGULATOR_SCMI=y
+CONFIG_SPL_OF_TRANSLATE=y
+CONFIG_PCI=y
+CONFIG_PCIE_ECAM_GENERIC=y
+CONFIG_PCI_SCAN_SHOW=y
+CONFIG_CMD_PCI=y
+CONFIG_DM_ETH=y
+CONFIG_DM_MDIO=y
+CONFIG_PHYLIB=y
+CONFIG_PHYLIB_10G=y
+CONFIG_PHY_AQUANTIA=y
+CONFIG_PHY_REALTEK=y
+CONFIG_FSL_ENETC=y
+CONFIG_SYS_RX_ETH_BUFFER=8
+CONFIG_IMX8_ROMAPI=n
+CONFIG_CLK_CCF=y
+CONFIG_SPL_CLK_CCF=y
+CONFIG_SPL_RECOVER_DATA_SECTION=y
+CONFIG_BINMAN_FDT is not set
+CONFIG_ENV_SOURCE_FILE="imx95_19x19_evk"
diff --git a/doc/board/nxp/imx95_evk.rst b/doc/board/nxp/imx95_evk.rst
new file mode 100644
index 0000000000000000000000000000000000000000..c2be474aa71f0f8d934f956c8840d330fbee98df
--- /dev/null
+++ b/doc/board/nxp/imx95_evk.rst
@@ -0,0 +1,109 @@
+.. SPDX-License-Identifier: GPL-2.0+
+
+imx95_evk
+=======================
+
+U-Boot for the NXP i.MX95 19x19 EVK board
+
+Quick Start
+-----------
+
+- Get ahab-container.img
+- Get the DDR PHY Firmware Images
+- Get and Build OEI Images
+- Get and Build System Manager Image
+- Get and Build the ARM Trusted Firmware
+- Build the Bootloader Image
+- Boot
+
+Get ahab-container.img
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-ele-imx-1.3.0-17945fc.bin
+   $ chmod +x firmware-ele-imx-1.3.0-17945fc.bin
+   $ ./firmware-ele-imx-1.3.0-17945fc.bin
+   $ cp firmware-ele-imx-1.3.0-17945fc.bin/mx95a0-ahab-container.img $(srctree)
+
+Get the DDR PHY Firmware Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+
+.. code-block:: bash
+
+   $ wget https://www.nxp.com/lgfiles/NMG/MAD/YOCTO/firmware-imx-8.26-d4c33ab.bin
+   $ chmod +x firmware-imx-8.26-d4c33ab.bin
+   $ ./firmware-imx-8.26-d4c33ab.bin
+   $ cp firmware-imx-8.26-d4c33ab/firmware/ddr/synopsys/lpddr5*v202311.bin $(srctree)
+
+Get and Build OEI Images
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get OEI from: https://github.com/nxp-imx/imx-oei
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ make board=mx95lp5 oei=ddr DEBUG=1
+   $ cp build/mx95lp5/ddr/oei-m33-ddr.bin $(srctree)
+
+   $ make board=mx95lp5 oei=tcm DEBUG=1
+   $ cp build/mx95lp5/tcm/oei-m33-tcm.bin $(srctree)
+
+Get and Build System Manager Image
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get System Manager from: https://github.com/nxp-imx/imx-sm
+branch: master
+
+.. code-block:: bash
+
+   $ sudo apt -y install make gcc g++-multilib srecord
+   $ wget https://developer.arm.com/-/media/Files/downloads/gnu/13.3.rel1/binrel/arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ tar xvf arm-gnu-toolchain-13.3.rel1-x86_64-arm-none-eabi.tar.xz
+   $ export TOOLS=$PWD
+   $ make config=mx95evk all
+   $ cp build/mx95evk/m33_image.bin $(srctree)
+
+Get and Build the ARM Trusted Firmware
+--------------------------------------
+
+Note: srctree is U-Boot source directory
+Get ATF from: https://github.com/nxp-imx/imx-atf/
+branch: lf_v2.10
+
+.. code-block:: bash
+
+   $ unset LDFLAGS
+   $ make PLAT=imx95 bl31
+   $ cp build/imx95/release/bl31.bin $(srctree)
+
+Build the Bootloader Image
+------------
+
+.. code-block:: bash
+
+   $ export CROSS_COMPILE=aarch64-poky-linux-
+   $ make imx95_19x19_evk_defconfig
+   $ make
+
+Copy imx-boot-imx95.bin to the MicroSD card:
+
+.. code-block:: bash
+
+   $ sudo dd if=imx-boot-imx95.bin of=/dev/sdb bs=1k seek=32 conv=fsync
+
+Boot
+----
+
+Set i.MX95 boot device to MicroSD card
diff --git a/doc/board/nxp/index.rst b/doc/board/nxp/index.rst
index 8ca4b5619863f616dbedc7eb0ff8a286a3fbbf48..e7ec725cc04e9755ba3dac37561c26ebc3f1c716 100644
--- a/doc/board/nxp/index.rst
+++ b/doc/board/nxp/index.rst
@@ -15,6 +15,7 @@ NXP Semiconductors
    imx91_11x11_evk
    imx93_9x9_qsb
    imx93_11x11_evk
+   imx95_evk
    imxrt1020-evk
    imxrt1050-evk
    imxrt1170-evk
diff --git a/include/configs/imx95_evk.h b/include/configs/imx95_evk.h
new file mode 100644
index 0000000000000000000000000000000000000000..0f37fcddebaf7c6ed45c344d8992d2aa28c798d3
--- /dev/null
+++ b/include/configs/imx95_evk.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright 2024 NXP
+ */
+
+#ifndef __IMX95_EVK_H
+#define __IMX95_EVK_H
+
+#include <linux/sizes.h>
+#include <linux/stringify.h>
+#include <asm/arch/imx-regs.h>
+
+#define CFG_SYS_UBOOT_BASE	\
+	(QSPI0_AMBA_BASE + CONFIG_SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR * 512)
+
+#define CFG_SYS_INIT_RAM_ADDR        0x90000000
+#define CFG_SYS_INIT_RAM_SIZE        0x200000
+
+#define CFG_SYS_SDRAM_BASE           0x90000000
+#define PHYS_SDRAM                      0x90000000
+/* Totally 16GB */
+#define PHYS_SDRAM_SIZE			0x70000000 /* 2GB  - 256MB DDR */
+#define PHYS_SDRAM_2_SIZE		0x380000000 /* 14GB */
+
+#define CFG_SYS_FSL_USDHC_NUM	2
+
+/* Using ULP WDOG for reset */
+#define WDOG_BASE_ADDR          WDG3_BASE_ADDR
+
+/* USB configs */
+#if defined(CONFIG_CMD_NET)
+#define PHY_ANEG_TIMEOUT 20000
+/* Number of Rx BD rings: 8 per ENETC instance */
+#endif
+
+#endif

-- 
2.34.1

