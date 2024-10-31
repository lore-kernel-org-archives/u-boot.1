Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D819EE68975
	for <u-boot@archiver.kernel.org>; Thu, 31 Oct 2024 11:14:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3A38689262;
	Thu, 31 Oct 2024 12:14:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="WfJadg43";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 912FF8928E; Thu, 31 Oct 2024 12:13:59 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::613])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56DB48904C
 for <u-boot@lists.denx.de>; Thu, 31 Oct 2024 12:13:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FfE8l3FutZZ3XaBJLfQnBqWdV6XTd9YdGD68SpaZxCbOktsbcDVbeCjUBK7Q34NvqCS5+F9sdrXSBV9e9L2sy2SeKcR6ld28o+eyC3hBlpzNGjlcPsCcmAFuB2tKqHMCJjLFrkWAATKtWds4C2iqMuPIG/acl8yXDqX/iUedlXDFkA+K9d0VlIDlVTP3HianSqNukHAQfKPCKsH3khidSVk3D+yx8IZH5x/IeZer91WuLo6XPc8pEGm4RGtcNKDlxGsxoESCz9zSXntknnmm3X4TNZEiAzuXBdI4Wq5nrFVDU8TYBzoQYO6Gue58vkHRb9tNSA17VHoD0nKOPFP/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K6cUbFDQ6iX9uLkPdeExaXKCRIQ6PuOaEokDn8goyGg=;
 b=on1zspugYr6pY4nGUsRNaNX7LmmuVR+lRYB0/0fSMvDTMH10+6U11owC7vObUMIk1KCguSbggEYQX5+6DEWi8BviSO+ZGw4wMvYfGP0y4RKbtuAUub4pqYtTKLEVGUq1V71HNzsta2mxqYOIvkScJrEY1HlAvZVk1aLQNSlaEjDeKbMvCdqlFt2POt2Jkaxz/1uRrR09HKdnwuWO7dYcTSDS+L6m2hY0GXHXPh169bQUoX99THXaXrAhR7/rCMxs4Hpslk2s/khCIlTBdehySiKahN2OYq8RvzHliSoIZNNDCm9tYYof5iA8wwuoOBlk9UmSV8y4+SZCNsXJY0OsGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K6cUbFDQ6iX9uLkPdeExaXKCRIQ6PuOaEokDn8goyGg=;
 b=WfJadg43ffS7rzAwHe1X/mXWcK/uERg8urV8sWC0feElDCSVgBG26TKZR/C5XmsdY6BKEHe+Xc64m5LxuvIS3LCOJNveCZ4RY3/47tT99+SEi2LYtPlExAp+xnCLg8U9G7jjSFNn8FUBXNQtU7vZW1BN2vqS/9mFLz/ha9c2yWA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GVXPR04MB9850.eurprd04.prod.outlook.com (2603:10a6:150:11a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 11:13:53 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%7]) with mapi id 15.20.8093.027; Thu, 31 Oct 2024
 11:13:52 +0000
Message-ID: <83aae0b1-c25d-4b3a-aa68-3590ecbaec1a@cherry.de>
Date: Thu, 31 Oct 2024 12:13:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] configs: rockchip: enable RK806 SPI PMIC for Radxa
 ROCK 5A
To: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
Cc: eugen.hristev@linaro.org, jonas@kwiboo.se, kever.yang@rock-chips.com,
 macromorgan@hotmail.com, o451686892@gmail.com,
 sebastian.reichel@collabora.com
References: <20241031032245.32749-1-naoki@radxa.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20241031032245.32749-1-naoki@radxa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::22)
 To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GVXPR04MB9850:EE_
X-MS-Office365-Filtering-Correlation-Id: 01394d90-bdb1-4602-b5c4-08dcf99d1a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Vm51Z2xXU28rVFlPK2JFbkdHYUVIYytSM2JVTmlCSXF4ZTdvRzZ5SEpST1ZO?=
 =?utf-8?B?eEx1ZkNwU2huVDRUcnZzaFF4bmFHOXFUR1R4RnUraHczNEFrTEoxcjZ6eUl4?=
 =?utf-8?B?WWhFbWNSQ09UcGRDY1IxTHFHVmV1cGdhdW82eWVVYjBObm1yaHJZL2FqMkhk?=
 =?utf-8?B?Y0tpK2pxczB2OFVWbUdKZnVvNGFkMWZ2UWliTW9lS3RkYjVzRk1YSXB2UVpt?=
 =?utf-8?B?SUpHaVQ1Rmp2a3FsUm9CTi9lM2lCNVRDQmpOMnZJa20yUC94V0Y0RnJhcVhK?=
 =?utf-8?B?dythRGU0eGpkSzRhd2tGTVVNRlJmeU1jVlFQeEpiMEdUaFk2c3RTN1p3emw4?=
 =?utf-8?B?T3VYUnQ5VitkMTlrZTV1eUg3YXF6QSs2anhFMlZZZGh6V1NrZ2UxSW93ZDhC?=
 =?utf-8?B?aW1uNXZ1cjFtWlBncmVycGFHZXJhSHp1bG9LS0c0Yi84WnFxelZ1QkhJcVZw?=
 =?utf-8?B?ZkRQa29ObEtWNnh3UVhkb3d3RDZTSHltSVBMaGcycXNjRnNURmdrTXcxVXV5?=
 =?utf-8?B?UDM2emRjeFl5bk4vVVphVVA4aU9TazBjcXJUMlZMTUVMd1NBNTM4YjBxTWJV?=
 =?utf-8?B?RDlBbk8xZm5zSkxmR2QxZEY2WVNySHVOWGprRlRsajVhUDBrcDNjUWlJSXlj?=
 =?utf-8?B?ZlovWXkrNEJvT05qRFhPLzlWR09HalZ0SU1pOEhNd2gyUUg2T0JvYVJaRXFV?=
 =?utf-8?B?SU1YcFhVS3JLRUxnRDBzbTBNS1FpaVBaUGg3a21tS0g1UzVoNCtOQXg5MHht?=
 =?utf-8?B?ZmZwOTBsWUErRGp4MEY5V2MwRnR4andtNDBwanEybGQwSkYwOHd5LzljVU43?=
 =?utf-8?B?ZmV3VjR0VXlLZUs1VnQzZlJ1WWVGSXI0Z2hoZFpKVzJBSEdwVGJSTXR0QkZY?=
 =?utf-8?B?WlJTYlBrQm56Y3BVTU1Qek41Z1hvR2ovbXdzQzFYK1ppemRYeTdyTHhZS25S?=
 =?utf-8?B?Z2FQSkF6VVlCSTZFSTJXWlhNMW5tL3FxeGhzSW9kakNXc1d1RU0rY0JkbWY0?=
 =?utf-8?B?S1NFMWE5L3J6eE1zWHByR3ZmUERQdFVSd216eGN3UFY1UEVwS1dpaG9JMGh4?=
 =?utf-8?B?VjJHMzZlWFphVmdxcndyZFc0bHFtOGlJd3hHdC9NTzNlRStjYWdFZWloMUJP?=
 =?utf-8?B?VkEwZ1dmTjJhMHVDRndpQTEzZityS0dwdEJYUldMQXVnVWFvMTFSN1dYRHp1?=
 =?utf-8?B?Y0pUZnBVQmx3TmJjOHAwYjRGRys3aEtQUjMwZ2d1dDRNRVRQUmNpeWpNd1Ro?=
 =?utf-8?B?WTlPWnpUNnZieUFJN2NPNzBCODQwMVF1d2lpcnJOdUhEQVJRcWxwajlLLzM0?=
 =?utf-8?B?NU9WU3dWbVN4WlBGVElGL2JPanI3M1JVNWFJSkRaTWtMaFRBeDErMTdEcm5i?=
 =?utf-8?B?dzdJT0k1TGJTUEwxVDRoc1hGK2ZTUDArMlZTMEsrZEpucjhLZkxIMnJoN1VO?=
 =?utf-8?B?WEZDMnFJZmVMY3lXMkc0QXB5Y1ZZeTlUdVB1b2dRNkF5OExEQzlxMWc4Ynh6?=
 =?utf-8?B?SDJMTmt3SHRYbFBRVHVOUkJCMEtpR0hLMnk2ZDRmMFhHVzh5Q0FObWY3dUl3?=
 =?utf-8?B?ck1LcU16R0c5L2wrOXFld3FlK1JwQURtNHB6ZHRMWFFHeG9hS1NjNjkvS3lx?=
 =?utf-8?B?bFFIZnQyUm9kdk5RUUNFK1JBM1E4TStpcVdUTVBPb2VhTHNrSGMrUlNNMTJJ?=
 =?utf-8?B?UE1qUlgwOHJOUzdmbTlSYm5lY1pTNUZnMTZtOUNhYmxNcTVNb0JWd3ZLTlVj?=
 =?utf-8?Q?jYlAB6P1indKz8QdG6J+6X39/HnQSW0perp1Ts1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bTFOUXdkbnRpSDVQTXNmQ2g0TjZIM1hXc0h6a3J6T0ZnOG9iMHJ3Y0YrTHN4?=
 =?utf-8?B?azgyZDYrWVNsTzdKa0JQdm1qb1I5eGRlYXRwK2FydVE4Y3BMTE5DQnpNcVMr?=
 =?utf-8?B?VFZTLys2T2pDN3RWTE9hN1RMcEp5TmVIZE1IQjhFS0xWOG9EMWFqY2toYjVH?=
 =?utf-8?B?L05Ea1Zxa0owVm5xTmtjd0txSEpJeU5lZlArT3BOSlA5VDh4cDFqODM1Vm9h?=
 =?utf-8?B?QlcyRlJOeDRlU1gwN0pUK3BaOXpIN1FjNmNSUUQzbmxlUU1xaU4wOVAwTU5Q?=
 =?utf-8?B?VWFiRUtyWmxGS1NtTWdIVDVIUFdORTYzMkVrYUk5SHR3ZlgxSE92OEtZbzRx?=
 =?utf-8?B?R1g2c1BrUzlHdHdtWDV3aytGcEMzZDR1cVA1S2JQNXZvdkloUk9ka3hoUzJT?=
 =?utf-8?B?aXZPdCtYeERKQzZkKzdRWTF3MWxKcC9rR3dXVWVHMjJyK1VNTnljZ0VGb0Z4?=
 =?utf-8?B?a3ZZY2RGbFZjWHNodjlnSmlIcXE0aDFxN1V2cEpKL1c5bFVlVmxqSkUwYU9W?=
 =?utf-8?B?eTQvRVFoVUFITWtpQkxrVVVYUStFQkdoeENXRkNMWTlrcGdmQ3pvK01oZ1hT?=
 =?utf-8?B?YTZxT3NWMzFrbkhOR3c2bXdJL3RibG9BcStJQ0xYeGJORkxNYUZ4Q0NseGdT?=
 =?utf-8?B?eVFHTDBFbTdKeE1NR3Q2WXdUdXEzZUVWNUMvWjhBc0tjV2ZSOHordjNLek5s?=
 =?utf-8?B?MWVESmllKzlOMzh1V1hQNTh1VEJ1a3JNTFlPUkZzc1RLdncyMDU0byt3RGhi?=
 =?utf-8?B?enhCSy8xaHk4aGc3ZkNsZmdTczd5bWNZc2U0Vm4yU0NOQnNhYnZ2MnFtb01x?=
 =?utf-8?B?c2U2cHYyQWl6ayt5ZU5CQS90akVqYXFKM3l3UlphNzdQeEl0cjc3eGlXaTJm?=
 =?utf-8?B?RWVJc0s4UWUvTjU2U3RRUGNTUmVRMnZmKzVUQUhtTCt0U1FOWUkxQ0tEMmZW?=
 =?utf-8?B?cU4rM2NkcWFsTGsvYlpyRXpvb21pQytlcGhqSWRMRzdObnFPNHUrdFl1UDFX?=
 =?utf-8?B?UWhidzQ2SWttL2Y1dzJTbHVjUFFLNWIxWWh2UjJqcDgwWWtmRWtGVDdqWFpp?=
 =?utf-8?B?clVDZER4UnhVcG5vTkxHaEQyNUl0Q0RVQ0psdGkrM1lHNTBITGpmc3Y2ckFz?=
 =?utf-8?B?WFdTbnFpNEpmVXR2MmFQS2ZaVXRUNmZqNDB0dFB4UThSYTcxc2FZQkJUWlEr?=
 =?utf-8?B?U1o2elhuNGFmOTBMeU1wSFBtTWxhZWVCcWR4bHFCYndEVW1abVI0dldBZXlq?=
 =?utf-8?B?aXA2dDNNRXZFb0VjclpxUlpWcEFZSlVUbGIveHA4SGg4azlrcXNmNFVWSTVB?=
 =?utf-8?B?Nlp2dkdKSU9SangxdmhzcTI3WkpnTnAwNWVrRlU2MS9iY1dDTGVBeUhIQVEw?=
 =?utf-8?B?TkllMUUrRTM0cUxmSm8rZFpUUzd0YWtoK0Jkb01WMnlRaTJZYmFxTVgwaTNx?=
 =?utf-8?B?d211aUFPL092QUlJLzUxbnBLc0twQmVEN0NFbTU3ekRacVdIYWpZUlcxSWJE?=
 =?utf-8?B?MlN5V2hiS01Tc2I0c0x2ZHlldzlQUzJ0R3BJeWd5SStidUdWbThaTXo5L0Iy?=
 =?utf-8?B?Y0NKWEs1MTQ0bnpSTUY0WDVXeUtNeGswOUFueUxVMGxqRjdsR04rRTEzSEsv?=
 =?utf-8?B?MWxIcGZITHBhTEJNNjdnaFhiaUpoLzVnMXVmRXR1VVdsTXJpOXNOelRMek5h?=
 =?utf-8?B?UEhIWG5BendVQzEyMWpsdlQ5aHcwL3FWNmE2VFlRaVJBT0pEWERiZ1lVWi9p?=
 =?utf-8?B?TFc2SU1JUnE2YUdZaEoxN1REUnpCYUNtM3E5eUw5TW1vdmZnM2FZKzV6bjk3?=
 =?utf-8?B?aVZGeWpTaC9YOHBuUHZXdDdNUDhpZFo5dm9LZTgxZ1Zhc0gwdlcxQkhpWUN5?=
 =?utf-8?B?M000eExBbHp3V2c1dlZ0ZzJvdjZ2cmM1ZERMUFcvZ0ZVdWw5OWxzaUNjSk1B?=
 =?utf-8?B?dlc4bWs0cUtUdnpCUUhhWUJIOW4yTmc2MFlCREVVMFU4V2YybkhQNG5QV0Rl?=
 =?utf-8?B?NnU5THV4S0oySS9wUEF0a2JVTXFTSGJDbkVzTTFpYWZ0WVVmSE9mdUp3eW1i?=
 =?utf-8?B?R3RjSFBxTVlpc3ZjU2luTWYveERBM1ZLb0JIVlU4VEFiQjUzMTFHRkhNNmRx?=
 =?utf-8?B?NmVMSWV1bm5PUFdleTdjUmVvRUpjWVVIczM1aDMwd1Fja0p0YW5QN2FyNGJW?=
 =?utf-8?B?VkE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 01394d90-bdb1-4602-b5c4-08dcf99d1a42
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 11:13:52.7006 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bCnC/IXFGvXymCd5HuZOXLdrf5uSavut0UIjmrf2Q0ilDVCv+/E+QSbYaBUVwpJTF0w9z8LRqZEFfkFg3LetN6tQSpU7bsxqzWrYp8lf+lA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9850
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

Hi Naoki,

On 10/31/24 4:22 AM, FUKAUMI Naoki wrote:
> enable RK806 SPI PMIC driver and related cmd/configs for Radxa ROCK 5A.
> 
> Signed-off-by: FUKAUMI Naoki <naoki@radxa.com>
> ---
>   configs/rock5a-rk3588s_defconfig | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/configs/rock5a-rk3588s_defconfig b/configs/rock5a-rk3588s_defconfig
> index 9618d590009..d2770198ef2 100644
> --- a/configs/rock5a-rk3588s_defconfig
> +++ b/configs/rock5a-rk3588s_defconfig
> @@ -28,6 +28,7 @@ CONFIG_CMD_I2C=y
>   CONFIG_CMD_MMC=y
>   CONFIG_CMD_USB=y
>   # CONFIG_CMD_SETEXPR is not set
> +CONFIG_CMD_PMIC=y
>   CONFIG_CMD_REGULATOR=y
>   # CONFIG_SPL_DOS_PARTITION is not set
>   CONFIG_SPL_OF_CONTROL=y
> @@ -55,11 +56,16 @@ CONFIG_PHY_ROCKCHIP_INNO_USB2=y
>   CONFIG_PHY_ROCKCHIP_NANENG_COMBOPHY=y
>   CONFIG_PHY_ROCKCHIP_USBDP=y
>   CONFIG_SPL_PINCTRL=y
> +CONFIG_DM_PMIC=y
> +CONFIG_PMIC_RK8XX=y
> +CONFIG_SPL_PMIC_RK8XX=y

This won't be useful as neither the SPI controller, SPI pinmux nor PMIC 
nodes are marked as to keep for SPL in the DT as far as I could tell.

Same remark for patch 3 in this series.

Cheers,
Quentin
