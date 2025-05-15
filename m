Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2BBFC3ABC9
	for <u-boot@archiver.kernel.org>; Thu, 15 May 2025 14:53:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F9D582B77;
	Thu, 15 May 2025 16:52:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cvc+YjFh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 24D6382BE3; Thu, 15 May 2025 16:52:58 +0200 (CEST)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2606::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 084EB82AFC
 for <u-boot@lists.denx.de>; Thu, 15 May 2025 16:52:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3kcld4VoKojNTgm0lRx7pI2+fE4wX42pAorIC6bUGX629Yr+NNpLzeu4kUdxpQY3/tQXQHGZMcAs/M254U+wnCjWdLEociGqedErQb8/3COxQqSYskj4CDqZRee8gOFg973PvwuW2eeoOqW4v8/k/f5lwh401GTGc5/pTXPE8WyN318r5XYDelsTLYiSLOUxEUhqykK1lqzBVuHm5fry6bPJKqxde+g4p5ZD3ZrLh/d1fiPH5PkXdmXNy5nIL4qxEFEor6SXnZqm/kwWVkzJWdeRIPNIo5m2dYCSMm7SyuDDCLZCKTH5lol33uFOODk7bxIFQ8FaMVZ2dPr5ssNfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CG8XN/GLLnXl3CbfyjuxB7udKddOga1CHuhxYVnEsMQ=;
 b=Axo96sj3MJOlDBxq0oi5BkcMYXPL/7moLOHM70XhTtkRAWsts4x8cRpx7Ee2lIp9gdqBItqJS6aGBazDLSEkaR22M8otsHIC5rA0fjOMMycyDgppMnddmXCJt5Cw/btoB/hQvvveyB7iqT/Dm///p9q2voHMf6PKq4tCosHQpRjYZIezMqb91VVrBy/8Dmgt5NOYrkBC9ssRzPRKIZj5vdn+Mqnb2+bYVmyN4B8/rwZzI+NRb+nfAyo8ANoMePq+plR8XD0bmI2H8BSp3+Jwn9i/WYy9Xzw8CZMHDCxYWbTJfOnQp1c2HbswiIVb1Uxbynnd0GJaJUDrXI19JJEfjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CG8XN/GLLnXl3CbfyjuxB7udKddOga1CHuhxYVnEsMQ=;
 b=cvc+YjFhcqSqu2cCFGKhXMl8eYg6fvxZCM5S4R3EB11nfYGm6xShR/0VkCKSoXiJFq3r0hlQcCZu1AwDa3WmjaKr0CFbhtoZvvOoLi25pIXd2pLlD8zndBTZxes7dime8gtbADR8a7qabUJqWq7JISQ4NsQHedYvwWqKebQuv7Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by AM7PR04MB7141.eurprd04.prod.outlook.com (2603:10a6:20b:11d::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Thu, 15 May
 2025 14:52:54 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%4]) with mapi id 15.20.8722.031; Thu, 15 May 2025
 14:52:54 +0000
Message-ID: <abe0fdc6-8f55-41f3-8acb-3700fe34af08@cherry.de>
Date: Thu, 15 May 2025 16:52:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/3] spl: Kconfig: allow to enable
 SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR for i.MX8M
To: Tom Rini <trini@konsulko.com>
Cc: Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 u-boot@lists.denx.de, michael@amarulasolutions.com,
 linux-amarula@amarulasolutions.com, Anshul Dalal <anshuld@ti.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Lukas Funke <lukas.funke@weidmueller.com>, Marek Vasut <marex@denx.de>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 Trevor Woerner <twoerner@gmail.com>
References: <20250515131246.784206-1-dario.binacchi@amarulasolutions.com>
 <20250515131246.784206-2-dario.binacchi@amarulasolutions.com>
 <257158ee-7496-4da2-84c1-6bc74965cde0@cherry.de>
 <20250515143035.GH603748@bill-the-cat>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250515143035.GH603748@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0080.eurprd04.prod.outlook.com
 (2603:10a6:803:64::15) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|AM7PR04MB7141:EE_
X-MS-Office365-Filtering-Correlation-Id: ece06c97-5a83-46f6-eba9-08dd93c02c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bk9qS2JzNWx0M1h0Q0E3WmNTbXduZ201YUE4eWJycnVRVlBNenFNMVZVQW5R?=
 =?utf-8?B?Y01lTlhIZHV5Wk01ODN6YVc5YVl0Y1N5anpJNzdEZHViUHNPbCszMmt1cEdz?=
 =?utf-8?B?TXNYblZqRStha284cFI1M3dWNlFVeU0vWGE0amw2b0gveXc4eTQwVWs2OHRB?=
 =?utf-8?B?MUp6Vmtwc3I5OGRrNXYvenBhZU1MenlodHFZTjArem1VcWNmLzIrWkRXbHBR?=
 =?utf-8?B?Ymd2ZmsxYjl4bDlOVlNmN3NtRlRKbCtVYkZRZG9uZlhzenFXK3Z2UUUyZnFt?=
 =?utf-8?B?Mm1BK3Jjb2xhcEpWVkYwZ1lQaHIvRlJsbVpTc2tOSWdoR1p0T2I4NUJYaitS?=
 =?utf-8?B?WmFQc2JkS3BkckR4TWxlVkdwT1FXalI3T1dpVjNuWGpFYm5mWElmYnY2eE9S?=
 =?utf-8?B?TElpOERXdlQ3UnlHMFBGRzJyQWxqZG0xQzJWTEY0M0hwNzlOWnZvUkJ4RS9F?=
 =?utf-8?B?Tmk4WlZVSm5rYUxTL0l6a2xqUU5qSitrMkd0Rm43S09ycjZDdHQrV25OQ2lB?=
 =?utf-8?B?VXFDc1I4WHhINmVKQlZsYis4RXFLbFMvR2lRQ2FET3h4dTBYZFdGTzVIeFla?=
 =?utf-8?B?Vk11L1Q0QVlybUFUc2FPa2s0R01HUDU5OXNKRTJHZW10Sk5uQ3p3Yk9uS0x5?=
 =?utf-8?B?dW9La2dEUnEwRU1tbFYyNVFQQm1IeHBjenA1NkQ4RHNYcE1JeThvNFlyMm5x?=
 =?utf-8?B?dWJsckJQVXh0QSswV20xeGMvRzdVL2dVSFBxTmlVa2srenhFaU5SdTNtcmlU?=
 =?utf-8?B?WldRSEpMNHo2YytFUkZFOUVpaVc0U0J2SzE5VTJ1NEFZTll6dUVRcFNqSU8x?=
 =?utf-8?B?VzQ4YitqcTRvNmEwaWFESFhiT2czdGxRMmRaaVhGVmZxZGRpcWxsSTc3bnFH?=
 =?utf-8?B?M1JxaFlMS0ZZb2NHaEltVmxOZ0IrTWF2dVNoT2FKRXAxMG1qcXN0Q3FiOGNC?=
 =?utf-8?B?NEFBR2tNNnM3TnNHQ3liV3lrUVZNdTFzMisxc3V3VXhqaGxVdTBqU21WM293?=
 =?utf-8?B?d3NVd0ZIS2ozNUx4Tzh1MnVuM3BiRzRZYkxPVWJKOXVwdlRQVXcxVG50eUQy?=
 =?utf-8?B?TEp6NXhXVGI3S0gwNDlPYUhBRXVqMlcybDJ5aVJYWFI2VDRwZ0c4eTQrNmJ2?=
 =?utf-8?B?dHluOXBxZ2pZc0xYMFdyUjBHdlM3M0RSemxMY2dGME9vTDEvNW1NSVJQK2Rv?=
 =?utf-8?B?dEVXNUhnY2ErYWpOZ3pMVXdjN2ErSlNyWE9zSkVUUlBic1U3a0RRT2RMYkl2?=
 =?utf-8?B?RWVYaHZSR3dFMjZQYUFuZmluUzJiNzhmNjZRWko1R0xrNnhXWHdYZng0T0M3?=
 =?utf-8?B?VWZUc3VlL3NOZDVjLy9KWmk3dE5PTE93aldvMm1aZHNhZVd4NVZJWWpnbGdF?=
 =?utf-8?B?NGNiRTM3Qnp2THlxUmNHYjRnYlZDK0RIMVJIOU03cWkyYXpSRldFNURqYW9M?=
 =?utf-8?B?SmRvMG5uV1hXSStzQmxoMzdLTFlLSDBSUExoQmFiOFlsWGxaR0NTRVdJR3Vr?=
 =?utf-8?B?a0RrNjBLTEJ3MUdZMHBDd09JOHlJTUczeGVRTERjUDBWMjMwb0lWSldPQnZi?=
 =?utf-8?B?WWJOOE1rTml2K0d0UUFNcXRLY3ZneDZ2TU5IVlRhUkpqZTN0dTlMcEJKZEZT?=
 =?utf-8?B?eVdGZ2xsSDJxZ1lva0p4OC9pek82dnVQZjlXcG4vM0tzaERIdzhBZ282STZZ?=
 =?utf-8?B?REQ4RndiUXBWejY0bmVVUDBGcWJXdFp6alRtVXlJSkgxOElVM1hGOHZIUlVr?=
 =?utf-8?B?V1dNY3h6eVYyRnRYQmlSMzNjazc2WEsxV1JDR09hS09KRGJ0VlpTcDNaY08w?=
 =?utf-8?B?bXMrL284aWdxa3JlWU85ZkF3L1lqSUptOVh3eEtpVENTQmZaVnhCRHJQNEZR?=
 =?utf-8?B?MS9WQnd3aFdKVGJMUG9WNnJMMy8rWUE1UWdWQ09vV1VZOW51Nmg5Y0tTQU54?=
 =?utf-8?Q?f60EM7oPCMA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7416014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHRqZEd6bTB6VFhhNm9Ubkk1QUlRMFFxUlNLVWFRbHVWOUY2TU1EWXNleTVX?=
 =?utf-8?B?WWI0TEk1em1SbEhkUmJsWlA4QXpaYzZ0M3BsV3VWdHlaQW9YTzdua2tpK2FI?=
 =?utf-8?B?eVlJcDhqQlkvVHd3SUwyVDVOVTBFRzNzczltVndDRjdSL0w1LytpVEk2S3RY?=
 =?utf-8?B?MzJqYUtQbGVReHpNTytrWTA0ZHdtNHZtQ1BnV08zL3QzTTFxZ3hpVUdxSE9y?=
 =?utf-8?B?Q01rRE9ZYVhMeWFnYkt0dDN4QlRRT0ZUSFU5UmdQZjB2YVh6VVVPSUU5SWpK?=
 =?utf-8?B?ckJSOFFhWkwveW94VUI0V0ZJSUxjM3BXdTJGa0dNeXBISjMraHoxQ2hPWExM?=
 =?utf-8?B?eEdhYk1LU2ZZNHRLUVU4YURueVNVelc1RTNNWmxQMFNFSTJ1UWwybFRqemZ4?=
 =?utf-8?B?NEZ3TURlTjFDMWZUMUt2SG0vVnN5R1dFMXZMemRjU1d6anZqNDRERXNUckpQ?=
 =?utf-8?B?SnZWYUFvc0lmbWRkWkZvaytaeUNGNXhxS054VGRIUWo3aDc3LzRrZHUxN29J?=
 =?utf-8?B?QkRTYVZ4eklCZFRPeEYrYzcwOFErZ1lhRVk5YWN3a1VCU0tFemxaRVczY1Zu?=
 =?utf-8?B?dkZ6L2lmSnk0WUtMOWU3Q2ZvbWh1eit0a2pnLzhkTWtOem1VRlpnNzFjQUIr?=
 =?utf-8?B?L21xNTdab01MQmtRZDhFVjAzK0RQak9MMzVoNjVEMlRpRnBhUVVHSU10TGlP?=
 =?utf-8?B?Q2pwQ0hXRVZNV2VNNHZRc2VBWmMzS1NtRFhKOFRHYlpodkp3NWJCajF6WUJq?=
 =?utf-8?B?ZitRczM3UHIycnZOa25WbzBtRW1nSGg5ZW1nZ25vakl0T0txS1JpZGxRRktw?=
 =?utf-8?B?YStxR1RXZUZmZlpPYTlxK29yTGoxTUd0aXBIc2FRR2V2V05uOXBlK01mblg0?=
 =?utf-8?B?NDhaTCtzSC91b0RhVGlJS0lWN0NoUDltVnlHdXlmWXoyRGltRG5sc284N2lr?=
 =?utf-8?B?enVkV3BHc2V2bWVEOHhVY2hKUHJIeHYxTE5LWHd6ZHZIcDJ1OVJGWGJEQ1FZ?=
 =?utf-8?B?TkFsaVoxRDl1VUNCQmw0MEgycUNZQTRqRXBvTXY1bGl5OW1KRVJoTTlpSTUy?=
 =?utf-8?B?OGh3YTN4UU1PYk55NUdrRFAyVkdER1VhOHJaeTRRazdKdjFmUFJvS20rTjAv?=
 =?utf-8?B?NUFFYTNsbmVhbGM1aURiMFFUTElLamprdW4yeWhqa01RVHBjY1RrRmdqSkEx?=
 =?utf-8?B?elZacmZLZ1JGV3M0cmgvWHB5M1BjMnRMOUJYVDJSU0F0RXVxN2VFMHZaN1Nw?=
 =?utf-8?B?WlVLOGpMN3FhRHRPbjNkbHBIR3RtR3hqT1BEV0JqNFdSRm13N01OTERCTHBT?=
 =?utf-8?B?ajNDd1NZM3JXYlZNdDUxclM1Z05CanAwZ0pnSXBVb1RCV2NQUHh4eVZ3UUJQ?=
 =?utf-8?B?U3piZXowWWZXeXBZN2hVZWJ1Wlo2cjhHVkx0dXE5ZEZrcnduSERJVDRKWWRO?=
 =?utf-8?B?T0M3QTkvMVZLVGlSNDl1bjZyMGlCQlk2bzY5M2hVT2FhVmdObkpISk9QTHdt?=
 =?utf-8?B?SHNIQnA4Ykdma1VyWklWVHAycElmekUxZ0hTQ3llaVoyWUUyZWxPWlRWc0NG?=
 =?utf-8?B?NVdYdVZmdTJBY0x3VnFTV0M2WDdoYVpxRjNoSWhTaUpTTWYrQkd2eGRMYUNB?=
 =?utf-8?B?WHNFeE9kNmJEZW5YTDZ2M1dSTk5zL1hGRkt3SlVkdm5vV3g3U0FvVnhkalpU?=
 =?utf-8?B?TXRtWjkxVXRmZ21MZndyait2MWhKZmZHRzRPYUZUaTM1bTVqSWF3cDZPTDRa?=
 =?utf-8?B?SExwYTdWcTBxTHlISk9GTzhWamgzK1dRL21zVVpaN0FQdUlrSnIxcnZITmI2?=
 =?utf-8?B?azZzdHZUVGNkN0pzanBCbVN2OW1lSmdIVWlJc0JyRCs1aklZY1ZWeWVBcjhy?=
 =?utf-8?B?bnpqamJwYU5DbjdQOCt2NkNvbnI5RkNsdi9QT2JnVmIxWjJ6dUVsZ3lGd3dz?=
 =?utf-8?B?aitDelB1a0FXK1QzcDhCUWlnTlhIVHdtcU9oVW4yVmU5Y2V4VFNEMi85Y2FN?=
 =?utf-8?B?SXBUbkl3MFhoTWU3WGZJZlpOVkliNllOaStUNzZVVTdGNjdqL05NdkVObjEr?=
 =?utf-8?B?blNXUkQ0U2xiaExpZFlBQUx3SVBmSnhHSkllQkZlT0UycTkxZjVYSGdTNkdT?=
 =?utf-8?B?Z1c0Q0JxV1FKNjhwQnlJU0ExZ2FicnBoVUxXZnpIS3p0MDZsMUhDZUtudVZZ?=
 =?utf-8?B?Z0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: ece06c97-5a83-46f6-eba9-08dd93c02c2e
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 14:52:54.2394 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxmmSwDNgOkfwIiF63pfVhN8zFF2rh+v5oO27eUEuh+rC3kQiPt4XXVlRVk+hzmukNynzZk3RG4WJHQnvDlV39amH5nGYn8IZKvIqtOOoAI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7141
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

On 5/15/25 4:30 PM, Tom Rini wrote:
> On Thu, May 15, 2025 at 03:26:18PM +0200, Quentin Schulz wrote:
>> Hi Dario,
>>
>> On 5/15/25 3:12 PM, Dario Binacchi wrote:
>>> Commit 2a00d73d081a ("spl: mmc: Try to clean up raw-mode options") breaks
>>> the boot of the BSH SMM S2 board. As stated in the commit itself, "Some
>>> boards use this value even though MMC is not enabled in SPL, for example
>>> imx8mn_bsh_smm_s2". The same commit makes SPL_SYS_MMCSD_RAW_MODE depend
>>> on SPL_DM_MMC || SPL_MMC. With SPL_SYS_MMCSD_RAW_MODE unset, it is not
>>> possible to enable SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR, thus breaking
>>> the board's boot process.
>>>
>>> The patch once again allows SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR to be
>>> selected also for boards that do not use MMC, in this case on the i.MX8M
>>> platform.
>>>
>>
>> Why would you use SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR if you don't have any
>> MMC? Shouldn't we rather fix the incorrect usage of this variable to be
>> something else (or better guarded?).
> 
> It appears that arch/arm/mach-imx/spl_imx_romapi.c::spl_romapi_get_uboot_base()
> will use the value so that we (apparently) go ROM->U-Boot, or at least
> ROM->some series of prior stage loaders->ROM->U-Boot. I'm not sure I
> love overloading the value like this, but I can't say it's wrong.
> Perhaps the help needs to be updated too?
> 

Isn't it rather U-Boot SPL asking the BootROM to load the image for it 
instead of doing it by itself? Some MMC is technically present then, 
just that because the BootROM handles it and not U-Boot, we need to 
specify the offset in the MMC even though we only return that value to 
the BootROM.

If that is correct, then I'm not sure we want to use 
SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR considering it selects SPL_LOAD_BLOCK 
which I would assume to be useless if the BootROM is doing all the work 
for the SPL?

Cheers,
Quentin
