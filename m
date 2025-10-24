Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57D99CCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:04:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF56183678;
	Fri, 24 Oct 2025 19:03:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Gf6g3ONv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 807E8836F0; Fri, 24 Oct 2025 19:03:59 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3844F83677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:03:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLqpIS7OaP+9yseE/lf8VSI3r2S3fQrHlEcdy21NTZcy7mvyKYoo46L14PFSQJlr43cGNilwr5jxFx8HsQWtSgPo8xXJGXzbAUZLjrYD+BjjbdOlvtanQyvhXTCkGTCAY6ZTHD4DoiqB+jNieO7thflMMeN2LfaK/q81Fmat8zWMkNzpyqPJY0E7UBYHqvO5Xh0kUvwvG/sfNUy83FRb5Hw869UP/FCAC7M1IdQxV6weuRodbH/KoACAZ2jYfb6+J+HR94yZ4EaO9xe06fCk5M+5j9q9KofJuRkimLKoXGmzk8vuXT66Sh0tqPx91zwtUOWNZGqVwxcJE3s4VIW66Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qWUHmntHypaYesa0WvOAFygTxoGpoGOnPaHO1WzaaGk=;
 b=FsHaoFyXFMsJ3muGuJonZMEIvOv096LwbKfqZZzUkW7rsdwHlvkL+bnSCzc5lSN32e481hCKj6y7gGtQFlfEUakf6ERYEUVxwfLL0RnbVKvctCE+lBfKw3MADqCvNElaDfaV4k0vd9giu2NiQwEaPeChnXW7cpTiBMGOyoFaXyIeB17t2m2b/2MA5Z7TiOvYYoMzRwgKgOY32pjrZuEwL4WhhKk1c5jB5YXsi3SVyKQusD8s5Yrbe0kxUjDEDruD8PRRkOnLFWfdxtnN/GD8YdngEP7brf8DA1Fi0JM4Nu0DZ2cZmCNz28KmssXJA4UWjMzFFmKHyvQyum2ZSMhDuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qWUHmntHypaYesa0WvOAFygTxoGpoGOnPaHO1WzaaGk=;
 b=Gf6g3ONvaGrRD1kjod4iqCAD2eMwJvXg+VBhct6biIlC22EDNATPm92UYN/1tIo/9DotisOz6yPOAfdC7ElENXieWm8CNMHnFWgCDJMG66RPbXsKzHoqKvKMcfU25pjZ/7dVQ1Qjk3RBh9ZVS1LSJ15Bjzbnf3fti4cAA7kd2W0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PAXPR04MB8688.eurprd04.prod.outlook.com (2603:10a6:102:21f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 17:03:56 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 17:03:56 +0000
Message-ID: <325c2789-dbaa-458e-b48b-a5228373c3ee@cherry.de>
Date: Fri, 24 Oct 2025 19:03:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc: seama: Reword return value section
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20251024160557.2317081-1-trini@konsulko.com>
 <20251024160557.2317081-4-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20251024160557.2317081-4-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0187.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ca::9) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PAXPR04MB8688:EE_
X-MS-Office365-Filtering-Correlation-Id: f9648bb5-df67-4bce-2d72-08de131f5117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SGpLdEU0SmRCdTVkVnRCUmhxVkZiMWJ4Q1JFZXZ4T0NkTGQ0R0VZMWlXR21h?=
 =?utf-8?B?QW14b2dPcC85Tlp1UnYyclRIc3ZZM2dWTGpDOHUwWER3TlBSQ1hFYWxPdUw2?=
 =?utf-8?B?bDNRVTVsMWhkdWhEcGl1VjI0N1VUSjhiZ2pJSjAxbmFpM1JWSHNSV05xdGtX?=
 =?utf-8?B?SVJuNXc0bnE5STIrVXQxV0VpL2hnQ2ZtOGZ3MTliQXlOMmlWK1M2bWNoTktt?=
 =?utf-8?B?R25meWZSSXh5VFVDN0hZS3FzcisvWmQ1Q2lsTHRMVjNHbDJiUUdCTUNKajJK?=
 =?utf-8?B?dkJBN3JYMVBPWUUvV0ZtaHBDT2tVaUpmU0FGVEZPY1BlMytoeVZxMVlLTGNG?=
 =?utf-8?B?cHk5ZFBsdHAwR3BCd1BXTGpGZ0ZPOW9MS0g0blN3dms2aXgrRmN6MTJnTmlB?=
 =?utf-8?B?a1B4cG1lQzFYUDZhekFrSTdsT0tMazdVQ0VJWWtXMlNNNkQvNWZ2M2tvOE1r?=
 =?utf-8?B?Nk1QSHRjeTBZR0dHOU1PZWdnb1hSQm9JQzM2dDRKSDNncE5tMDQ0ZXBoRUNT?=
 =?utf-8?B?cWZSemlwbFJHN3RBMFhGYXpJdTFZeHpQOW1tTjZscEduNjNZL1FTYllKbG9z?=
 =?utf-8?B?eXk2RHBVRUdDc240K291UVJOeXpJajlJd0s2K2ZJNGtHRUFHRFRIdlBIVVVF?=
 =?utf-8?B?VjhyYis2eU11N1VUVnNvb3R3UzZBM3FSSjdITkIzQnJ0RUZHbzduaEtFSUs0?=
 =?utf-8?B?UDIyNW53cnk0bWpJRWtBV3pLY2svNUg3NDlSL0IzOVowUmVETmtuSTdHMnBK?=
 =?utf-8?B?bTFxQVZmb1BYcm54Wlc5eVdCSlkwcTRoK2hiL1F2Uis0bDl6MXErZ09tTkVJ?=
 =?utf-8?B?NDRIZDZGcGlzTzJnbkFEYkpiNndzdWxKbGR2cFBhOGNock03aDFXTWgyL0oy?=
 =?utf-8?B?enhtOVAxRFhaLzNGVHYvUHlhSUhJMThqdG1ZY3dXU0tJYldGZlg0a2QxeCsv?=
 =?utf-8?B?d3I5aVk3c3A2ZlQrZEE2Q2RqNzVYYWJwaU1teHI1RUxuMWMyYVlKM2ljMW8v?=
 =?utf-8?B?SWZjeVFDb01hdUVTU2xYRW5GSzcydVBWaEtFbm45cUYySTlVV20vQitDS0F2?=
 =?utf-8?B?akpTdXdlbEp1K1c0dlJGejhnYlRsbFc2Tm12QlRoNUxuMDU1TkpxdjNwYlF6?=
 =?utf-8?B?dHY5V09FL2Z1ZkxzcVNVdWtrTWNhRTIrdzcxQ3M5ZnkyNFhISUttSEQ4QjhF?=
 =?utf-8?B?eVBTclp3bFpTVUkvRy9zbWIwSnZNTk1SNzdlR0wvN2puRTB3NFpXZjJxdmlo?=
 =?utf-8?B?UGw5UFpzTlZzT2JzaklDbWkrUGhFS3MrTnRqSU5BemFTaUZSWWJ2Z0NDcGFN?=
 =?utf-8?B?aHhIUGNvbjNCVG91ZVlvWmp3clk4UHVhNWFIa0JPVTVsRDR5SjB1dnQyS1hH?=
 =?utf-8?B?bHdjUzRpaExiQ1Q5azJ2a1ZIWThVN0RWdnB6VUN4YWlCL1poWHV1V3Z1dTVV?=
 =?utf-8?B?SG9uZTJXT0tCNjc2SWlIdlhFejlRV3QyMXNpeWNUZkdUU1Q1amhmUWhsdkpU?=
 =?utf-8?B?VTFYdVN6U0d5T0dnZVVFcDU1TGs4ZG5TZDFzajJ5N0YvQ3FKa0l3RGZ2blBT?=
 =?utf-8?B?NkVNaWZSUzhUUU9JN1YrR1F1SGlxYm15aEwrQU5Da01iSVFTS21GL0JmNlVt?=
 =?utf-8?B?Q21rckorSFdVZkcvZjFyZXp2amowdm1Yd2IwNVd0aTRGYzJnZUVPWjU5UjFj?=
 =?utf-8?B?OStTNTNFZ1hnRmczNHRRVXg4WFZMa2crTlN0SC9sUEk5TEw4bHNqTnlaZ2la?=
 =?utf-8?B?WHAwb3FlQlZYT1Q3WVkwd2JZT1gvejVZUlJoeW04WFdZUmZqTFBHMnRXVndS?=
 =?utf-8?B?bW9nRm5nR21lMHFjRy9ZbHpsS3F4RHlkYnhVejIyWStsV0dXakttMlNRWERS?=
 =?utf-8?B?VGx4L3lkL0xYY3U3RmtuZWh5WWFmTTUrY2ZzcnNoYnFIYWc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEg4VmdNVGVRZytGVkxBZERJbG4zdnZKMHBRd2UyQ0I5VUhaRU4yUmNBeVRl?=
 =?utf-8?B?U00rVk9IU1ViSUZ6VlRNMmg5VjRSeEVQSjYxTWFWSFNZcUFTWDFiU09aVlQ5?=
 =?utf-8?B?eUdJWjVmbmFVa09Sa2JScm9QWWl4YVlxQWlMajN4aFJ0bzBBVDUvYU1MNUxr?=
 =?utf-8?B?aEJoTDY5bSt5K3NKZTFmODQ1L0pHcjRVM1plVjFWTzNrd3BLbWFrRTR6Y3dL?=
 =?utf-8?B?SUxFVlFLTld3NFM2eHFORXdnc1A5Rk51L3NROHZYZXFvV1Y1c0NveUJ6YVlr?=
 =?utf-8?B?SVRYMDNEWWZ2RUJONnJUUDd2NGIxcGM5OThaTWJKU2hGTkI1Q0J1L2dwRXRz?=
 =?utf-8?B?RU9BZkQwaktPYmdiblpYS2k5dDYwU0Y0SzZXb09sd0c5LzF3MUdrQWowbSsx?=
 =?utf-8?B?N0lPQ2VicVo0ZHAzaVArZ2JpaFRoTTdkSWZKSmM2MUlyT09iMTVETVlNbmRM?=
 =?utf-8?B?a1J6OS9HSVNHcDZicTRnYTAzRHpPTlNnaFVDWWRyS2ZLa2M1aWJoRnd4d0xu?=
 =?utf-8?B?YW1TKzJrN0xHWXpUTS9USWVkRUU2Q09yZnV2N0NDSTI3UisxSEVhMVIwNlJ5?=
 =?utf-8?B?KzlPQUR6dk0xZmJTYzZqbGp1ZWJBcnIrd0sweFpqRzUwSHdTN1ZNeDFWWC81?=
 =?utf-8?B?T3pQT2RFRWdEQ0dqd1JZV1ptYVhDNHh6UnRuYjBNK1NNcjFEZm51MWx1MC9T?=
 =?utf-8?B?SFFXRE1yandtUXp5WkQyL0cxcE8vSk11QjRXelN0ZDNtUCtnRFZROVp3dXIv?=
 =?utf-8?B?dDNVL2dBZ05CdjJoT0cxNkhxUzFkbjloOElmYk81QThMUHVqdzB3SVkzcDAr?=
 =?utf-8?B?UGNzSW93T3d1Sm0xajUzWm9PTThxS1JsMlV4ZlZHNHBLaU9sZUtBVm9HSkRs?=
 =?utf-8?B?S0VmNDdFeGVCUGx1KzJpRGxlWGkwVFF1Z0ZadFJ6OStNcGZPd0hIV3pkN20r?=
 =?utf-8?B?eWMrcXY0RXNPU3hQdlZYWXNhalVQbHpyTVI2STEyR2tpeXJyOCszZmo3d3Yx?=
 =?utf-8?B?TVRnclBqaWM0cTFtZkt1dHBIYWlYeHZyYVNPekJpZWVhK1VrN1ZCcEpYeFIy?=
 =?utf-8?B?Sk1QOGRodUgvazlnUnVSREtUNEhRMlVmcXdrdXBoUEY0b2pLeDU4SE5LeCtW?=
 =?utf-8?B?K0NEVXFJQnVNTWpyeUNFeEgvVzl4MlQrOU5RWW5uRVMvV2dkMGhJM0lPUnho?=
 =?utf-8?B?MTRPTUJpNjd5ZnRVTWkyeXZaS3E2bXp5WktkRFNnTlB3cTdlSkJQQlBsdHdR?=
 =?utf-8?B?OTQrY0g5K1Y5UHVsWnlXZHRHaDdKY1prRHBjNm43dmEzdW5SK2F0TDNIUDJo?=
 =?utf-8?B?SnRDaTI5clo5aWRoVkVTZlFIa0pUYTJZcmM3U21CNnB2d2dCRjdIZFI3Vlh4?=
 =?utf-8?B?Qk9ENlJ3Ty9JcEt1ZGxPM3I0ajdOYm96Vk9IQ2dzcGFpNFB0L3Nvd3l0Uk1O?=
 =?utf-8?B?TlJudjNJM01WV0J3WjVFQzRxbG5Bc2Q3TmdzS3lsM3JxbVZuN0gyZllTRTZR?=
 =?utf-8?B?NjlzbmloRlNZUFpmR2tJTUJnT3hRZHdlVHdWRUp5SStXa3VVbjZMWXIwQU1E?=
 =?utf-8?B?TDFwWUVpTG9xYjZ5Tk5kVjlSdmZnQlQ3Wm1VSUozaGsyekhCK2orSzNpVVlK?=
 =?utf-8?B?QTZqc2pMdnBaM3F3MXZBckh3VUtyc09MQzMrcHlsN3dFcEpZVFJVajVZemp5?=
 =?utf-8?B?RDZSOFdCcHBYVThoUlB2SkFWajJHK05nVm5lVUgyc2ZLeHh5UjJKaTdEMzZL?=
 =?utf-8?B?emdRL1QzV1VkOWZWUjRyclRKbmQwQTZPUmpEY0dRYXFTWTFBN3J0ZGFmYklv?=
 =?utf-8?B?VUI3cmhycXB0bmdmUExaaW44SHNPUzZlZmtFVjZpWWNtTmwvaXRzYy9COFpP?=
 =?utf-8?B?QTY4NmRzUjZ3cmpKT09Qa0M2dS91UW9DdGdYSkFNVnVlS1hxa0l0c3VQc1VX?=
 =?utf-8?B?NEpCd3MwYSthaWN5SXluL3NHb3I5ZEFBa2l4bnBpTUlKZ2NSUFAvbTdCem5l?=
 =?utf-8?B?UlY3Mmd4RXNuSDZGTXV3cmFzY1F0dElXaUZmOFFxUE0zTHZRekRDc2k0dlJr?=
 =?utf-8?B?Vmo0NUZQODZYZDNHOXhqWU1ZeTBDL094MnRzMzJ0ZGpmYjJIaXNKRVVudGoy?=
 =?utf-8?B?VEpGdC94MmFqWmN3UktucitaVDF2VXk0NFJXdXNZa3dnRUFlRzZkTUhzaXNK?=
 =?utf-8?B?NEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: f9648bb5-df67-4bce-2d72-08de131f5117
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 17:03:55.9556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPTHqbRNxof+Pur4eWsDE6bHDE4fUhuAuUc/JNRo6/tuz6erwftErPlJbuFf+9Swoobfn9NQanB/5f/zFxHWceCMZonwCbF3CFc8CTA/uCw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8688
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

Hi Tom,

On 10/24/25 6:02 PM, Tom Rini wrote:
> With the addition of general text about how the return value is handled,
> reference that while retaining the additional information about setting
> $seama_image_size
> 
> Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> ---
>   doc/usage/cmd/seama.rst | 7 ++-----
>   1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
> index 17fd559f4856..a6b00f32902e 100644
> --- a/doc/usage/cmd/seama.rst
> +++ b/doc/usage/cmd/seama.rst
> @@ -56,8 +56,5 @@ The command is available if CONFIG_CMD_SEAMA=y.
>   Return value
>   ------------
>   
> -The return value $? is set 0 (true) if the loading is succefull, and
> -is set to 1 (false) in case of error.
> -
> -The environment variable $seama_image_size is set to the size of the
> -loaded SEAMA image.
> +Along with the general rules for setting $?, the environment variable
> +$seama_image_size is set to the size of the loaded SEAMA image.

Maybe we could link to the general rules section.

Adding a cross-reference label above the text added in patch 01 and then

:ref:`the general rules for setting $? <the cross-reference link you'd add>`

should do the trick (note that we need to use a text for the reference 
because the cross-reference in Sphinx cannot guess it for anything but a 
section title, c.f. 
https://www.sphinx-doc.org/en/master/usage/referencing.html#role-ref).

In any case,

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
