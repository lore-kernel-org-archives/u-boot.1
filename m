Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50909C3DA7F
	for <u-boot@archiver.kernel.org>; Wed,  7 Aug 2024 09:21:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA68588B0F;
	Wed,  7 Aug 2024 11:20:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ERTi2qTI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E44588B54; Wed,  7 Aug 2024 11:20:58 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170110001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5DDA88AD4
 for <u-boot@lists.denx.de>; Wed,  7 Aug 2024 11:20:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jw7e5GnwV6F21LVhdeFjLhNran6PukHq9gK9UXxaBTrllGSnZf90PsfKHqGb3Z+SbO/iLfX5k/lCBEyJRqihRQ0wZ2dQLpZmRA+9iOE+yOvuaDgDFksw+7B1bfj8tuiYz4QlK4si93l9lP1pAgkU4XsbXDj5LU8dpknTXUSYfh5GlsdobAU3I1B44oAh0Z21zMGCDBeFpqXFsf8m4Tdtmg9bQcSj1qfuJWJULYwrptYiNws4/Hnzpu+bQ/2P37kNHH6QhpLAPBFPqKHH6IOHJz0g3deqH36YLuoISawWCB3584KHXt5rz6/LxgZpRYzhjXVVoTumP5h9E+M+TTNL2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMRl8TJBJhpCK6+JjqsviZs95CrfkSz3itxTDD0OgHY=;
 b=VFz5ggApPIb8qeVFPzuTgTiFtN2/Ze0mUx644pzgluL+8vXuYOyf9b0GeuF87ZAr7H5MZQhyP3R/g+Sh4KsVghtMvI+azBjjrUHl3qnKPo62tuFAE4OuNBZMBJG/H8jTMLJM6RDcuw6HoFEbeAncvUe/8EtanEo9lm5Oau5iSr8IiZSWmph0H5FsXHVam47/T1CnKAVT7EKJGkrDz5tz/nZ5mxVbYs7WOI6mz447OlszgYlUuv/4HITzKWnxojYlnUifgWkmgqeJuxiG7kof69HOB/LOfqUtA460AP7cYiImJqewlZ8yFbhN0aivWDFsI7j4Ory/vIKQNRumSXt8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMRl8TJBJhpCK6+JjqsviZs95CrfkSz3itxTDD0OgHY=;
 b=ERTi2qTIYsjpG1jxpE+EzdJJUgi42hjoO8Fr5IldZ6b6+k3/FOxAtcoWRUrRfFWOy49HtZ04Yw5g4diSiEfFkPJYrA2OqQx/wkMuJrJ/Eac/gjM3/aFePYdFH4o8uzcW+F+Ix/WdAhj6uK9YMq1S7eYGfUB8a/0Kq6luKOoxruc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com (2603:10a6:20b:409::9)
 by PA4PR04MB9389.eurprd04.prod.outlook.com (2603:10a6:102:2a8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 09:20:53 +0000
Received: from AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea]) by AM9PR04MB8906.eurprd04.prod.outlook.com
 ([fe80::d379:5378:b1:cea%3]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 09:20:53 +0000
Message-ID: <010abc01-5687-4bfa-867f-3ac3a43f0d58@cherry.de>
Date: Wed, 7 Aug 2024 11:20:51 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/10] pinctrl: rockchip: Add pinmux status related ops
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20240802225705.2640999-1-jonas@kwiboo.se>
 <20240802225705.2640999-5-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20240802225705.2640999-5-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0064.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:26::12) To AM9PR04MB8906.eurprd04.prod.outlook.com
 (2603:10a6:20b:409::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8906:EE_|PA4PR04MB9389:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f91bfe-83a0-4fbf-b87e-08dcb6c23c3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aXh2aTlIdTNwbzNCQWFJT2czQ0t2TFJqQWRTOGt1MFdYZDRMamV3dmhTcnU3?=
 =?utf-8?B?REM1WGMxb0JWZ25Sem9TRlNYeHVIWmRUbmE2ajlIbGRzVzloaGg2TC9uNXZY?=
 =?utf-8?B?MGlqeVFqNFJSODIyQ1dWbFM5WWpPZHJ2OVpLZVJwWEFwM0JGdUpuTnR1N1lV?=
 =?utf-8?B?QnE1ZVBSR0NQcG9xa3hKVHorOHZ0SFkvQ3VlZGtocWZVMUcweFk3Sy9kR0Zl?=
 =?utf-8?B?WnlOVTAwbE9ub3RDOG9iZXZDUWJ3bXN2NzV3NlRzTVlkQkpSV0Z4aTRXMmdN?=
 =?utf-8?B?RmdkSGNjQVVqMU1FVVZsekpsL09KUXA1UEFaU2xTejJTcDhqM3dibkZmUDl6?=
 =?utf-8?B?OWJTV0RucUw3V3lCamhreUFMbGFKS212YzIvazVEL0NYVDdtUEVJc1NrSzFJ?=
 =?utf-8?B?anZnbjhXVzBXemJ1V2l5SHJwRVNQeEM5cFAyby9kbUducUhVWlBHZzluMWQv?=
 =?utf-8?B?ZkJLZGEzUmVHbld1dFRveTRxUUJYY2VMaG9RK012UHJ6K0ZFZUZpSU9tWUZq?=
 =?utf-8?B?Q01Rd1EyNHFtbUpYZXIrR3dReTd2UkxLT1dValVIZzlBZGlOY0xyQTJ1eHpv?=
 =?utf-8?B?cXJvbUFUUS94S28wUlRKUGtVRG81ekkwTTdCdWRHMDZFUVk3RUREb2hGazdl?=
 =?utf-8?B?NEFGOFZ0cGk0V3E5bVI0UzZmNjdsc0NnNnZJMUJmQXVtWWNrY3p6MHNlVm8r?=
 =?utf-8?B?THIySlJhREg5d1cyUkIwV3VhR0hRRlh5a1VsRHpyc2xGN1k0SnFKdnVPMFE1?=
 =?utf-8?B?WmJHWitOVTlSNktvVXZDYWVsdUpVSFNBd1JtSkVhN2hhY2VzL1MxcUNYQmhp?=
 =?utf-8?B?N2FwaHMwK2RiY1Zsb1dIbXlrbllaWGY3SzVyWGFOOVR3cEFKTmVkMktaTFIr?=
 =?utf-8?B?Z3UwZW40OEo3QkZBT25NWUxIc1o3Z0ZBeFNINkVlVXFraTRmSjVJbk9BaGhh?=
 =?utf-8?B?K09OSHVBcmsxZU12UWZiNmYrWHJCSmpIeEk4a0RNYWRTckhxa0lVL1lFOTJR?=
 =?utf-8?B?TjFETXlraFZ1UXlZTm1mTTlMdUNRemt2T0JrYjZMdElMZEYxVzg2U1lDZXlD?=
 =?utf-8?B?NTVlWnh5NitRc1ZGbzdObWhCRHgrVXNCYjJDT1FFTlR4aW5UQk5CZUVEZUZw?=
 =?utf-8?B?OGY1TldCaEZuM3VlWGxCV0lCakUrOFhVaHRBZTF2OVllR1pyRHpDdHRPeE5C?=
 =?utf-8?B?bDBhcHJsdnVpd2VvcURFL1pEUHhwT2JLNmlzYm42U0dQM09yT0NtNXhTUExj?=
 =?utf-8?B?cXdPZkZBWTQxdUc5dFN1cWFhRHY5ZmZtTnplYXZJalJmK1M0dndsNkQrLzVC?=
 =?utf-8?B?VDNkSE1MS01YUUpoZ0N0UjE0cy9URHl6Ykphd3NHMERiSE8zdU56d2hhR3hW?=
 =?utf-8?B?RnNrQW42MVE2VmFiZmtOSUN4cmZPWWtJcGprTk8wdVBvVXMrUkZ6ZkdlUlBW?=
 =?utf-8?B?Y0lUTDd5K016VDZLUmRKSWc0bEZRbkNESEphY1lZdDRiU2EwM3o1Zm1PU3NX?=
 =?utf-8?B?dFUwNXpnWlp6SmVWM2pxOFpqSWtRT3pRa0ZZellsUWV4bG5qMnRYVHd2akc4?=
 =?utf-8?B?REJSSW1GZUpwRTdNZlRWSzlpSVA4YjVkcG1BZkxzT2NTMENZOUJuOXRKeUVn?=
 =?utf-8?B?L3dzQ2YxanpENFZ0NlhuUmsrTEZFbC85bVhleEdtQ1FYMGZtY1pWMVNSME5Q?=
 =?utf-8?B?YWwycHl2Z08yUnM2UFBOT2IwRHJlTXorY3NJdVFBS20yU0IwcEN0UFBKNVZC?=
 =?utf-8?Q?03Bq3grPIiQ5mY9rVA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8906.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OHZ6WEdIdm5QcDZRRVMzakN2NjYxS3Nia1ZBWmRuTTUyVzRrSGJxZnZnKzZo?=
 =?utf-8?B?WWFQaDNqUGdZVTU3THc4bmFVa2VMbnhPODJIVHhwYWFmSFA0NEgraHloeUxQ?=
 =?utf-8?B?LzV2cWRCZmtjNHhwbFZxclEzNzRaS0UvcUZNdHZPWW1aNmFuS2NtSGZvNHo1?=
 =?utf-8?B?K1hSbzVMYnF3dEVyR0Z2ekl3eGVBQjR1U0M2WU5ZeWhPU2g4QzFiSy95dE5s?=
 =?utf-8?B?ZmFOb2Z2bDlYYlBsUzh0QXlPVllWaHBSVGdlL2dJbmJZYVlKNXNDTVVacW1p?=
 =?utf-8?B?ZDludFNYN2NJalFSUjRXV01NUnZwdHRERVRvQUJhVGJBUk9ueE1wRVVRcU9y?=
 =?utf-8?B?Z0JwbEtNdnlpT0IyT3BNQUZyZkgrQ2ljbi9LcWhreEtWS2ViSm1IbG9yRkJN?=
 =?utf-8?B?UmdNdmlNRisrMmZDdmpxdFowVXlsSlBtTk1pQUJWL3hSYTNtcDBPWnl0VHNt?=
 =?utf-8?B?N3pZTEgzQVFRTEZMUDFMVUtJQUxqWHVxUnZNcHJPNzdrMmtib0ZHN3JQWnZP?=
 =?utf-8?B?U0c5TS9vOGZPQ0JoWGZrSmJVOGdCS29aQzRVL2RlOU9IeEFOYzV3andVUWht?=
 =?utf-8?B?dy91RnVZREx4ajZBcUJjNzdERXZMSktEUmVYVUxidjE2ZXhHYTZNMnpIVnBw?=
 =?utf-8?B?REdpU2NDVWIvTWFkWWwvdkpwV3pGd0c0OGZ4YldEWXpEMFVzYWhmY1BoVWRy?=
 =?utf-8?B?TUorNDFMVWRYVzFsVm5zdHA3NVJpS1BtSjNzdEdjL0NmWFlVR1FMdDEwZHcx?=
 =?utf-8?B?VFdPblU2QlozcGk0dTNjcmtqVzN6V2ZQb2JrVGllWjJPYlBzOGlkakdwSmMr?=
 =?utf-8?B?UFp4S29tdGNUZ2JYUXc3QTQ5UUI5aGJsalYzVGJZSmZSVklHQThQU2l5UDVM?=
 =?utf-8?B?SEhXRHZwTmhjVGZ2Lyt0UGt4RlNZN2RUclFmZmlUU204bWNKaG9VekpDQy8v?=
 =?utf-8?B?L0h3UDRseXY3ZUpmTVAvVko3Nkx4R3hJS1MyWVFIV3c3d2FxemxLWDd2RFNU?=
 =?utf-8?B?TUwzS0U4aGdDS0xPeGp6M2dIdGpJVk11WHdZNFRRZUYwcDJxanlDeEN1bVJs?=
 =?utf-8?B?eG9hd2Y4R3BKV2pUWHJJR0JSSXVzanFpRkFXSys3UHdZUW9DKy91WFVrL3NM?=
 =?utf-8?B?bkwwMzYzUnFnbmpvSlVmb0p6RlpLSTU3MWtiRGVSNlRKWkVsWHRIbSszS0dZ?=
 =?utf-8?B?a2d5cGxqamk1RXdTdmxaREZuamRtTEJ1MEZWUHlwVUpOMjlRSWsrU1BRS2I5?=
 =?utf-8?B?blNEcjZSTnBRMkpJaDNaZDV5Z2I2M0RUaG41clJuNlVZdEJsMWFFQW04a3Ra?=
 =?utf-8?B?bmIyMFdoejArNnNncjRRZVpES0hRdkNaQUNUa0E3QVdMdTM5cFlXL1FrRmlY?=
 =?utf-8?B?Mk0xUG5hWmJhWEVIR2tIR01Vd21zL1FrOXg2aitmUWxWZnFSc3ZjMmtmQnVs?=
 =?utf-8?B?MkJ5U3dqRzc2aHNIVmhpaG1raXoveDExdnVMY3VoQkpJc0l3MENxWm9STEJs?=
 =?utf-8?B?SXNPTlVQekFsbGl2bE1JQ0trQjV3azJVaVFvTm96TGFXWFU4QkhHbXA2RWNk?=
 =?utf-8?B?Tko0alVJOG4vaEx3MisyNWFyRzBzOFZJajRjR3lOMTVhR2pBS2w1L3R3YXZY?=
 =?utf-8?B?NzlHS3V0TmxYUVpSbC9tcHp1Wmhtd0RBQ3B4ajkzbTYySEl4K0JDWkI4dWY5?=
 =?utf-8?B?Y3lZYVI0ZE1EbWFIUjdOWG56OFNLdzNwMHdUTzhyeWZmbWR6T3A0MDg3WmNC?=
 =?utf-8?B?RldZYzllb1ZKOUJKdFhVY2RQU1YyT1NIVDBkc0RpenZ1bkhNNDNJTExHOVc3?=
 =?utf-8?B?WFkrNy9LSk1sTnk2eEd0Mk9uZ2htYXFPNjgvTkdjWmJKK3d5VzNqaWxCejV2?=
 =?utf-8?B?ZlFRallzWVVZWkpuVTRXSUI4N1ZTRzdLNGVRS2pUcWVuR1E5eTdrUjZlcE96?=
 =?utf-8?B?OWtOV3JxNFlYTk9WSCtaSFdWQnkwYkJBMVFnRnRGVk0yQXpLUG9BMEt5UGxS?=
 =?utf-8?B?b0FyVlIxUUU0U0gwQ3ZxOWs2R283bTdGY3FFL2FPWWNlVDNHOWJYWTRheFd1?=
 =?utf-8?B?TjZsSHhHQ1Jrb1lHL1NTcStVQklSRExlWG1Tbkh2TWJQNEtnMXBITGFTMzY0?=
 =?utf-8?B?VUpvR1hrV1lVQnYza3lNc0ZrOUMrekJGakhXUzRRVmNqL1c3cS9UR09mQ2Vp?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f91bfe-83a0-4fbf-b87e-08dcb6c23c3a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8906.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 09:20:53.1281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtjJJ+CbOjpnvlQLmt0vC4Exm7UYPM83FepXsg7yxWObi3psY8hGPvyBLxfWLDh6vSmkzFR5KPXV0K87YHeuH52RZrzNGaeJHz3nktKQlEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9389
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

Hi Jonas,

On 8/3/24 12:56 AM, Jonas Karlman wrote:
> Add get_pins_count(), get_pin_name() and get_pin_muxing() ops to support
> the pinmux status cmd.
> 
>    => pinmux dev pinctrl
>    dev: pinctrl
>    => pinmux status
>    GPIO0_A0  : gpio
>    GPIO0_A1  : func-1
>    GPIO0_A2  : gpio
>    GPIO0_A3  : gpio
>    GPIO0_A4  : func-1
>    GPIO0_A5  : gpio
>    GPIO0_A6  : gpio
>    GPIO0_A7  : func-1
>    GPIO0_B0  : gpio
>    GPIO0_B1  : func-1
>    GPIO0_B2  : func-1
>    GPIO0_B3  : gpio
>    [...]
> 
> The change to use ENOENT for unrouted pins also help hide a "Error -22"
> message for unrouted pins using the gpio status -a cmd.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> v2: Collect r-b tag
> ---
>   .../pinctrl/rockchip/pinctrl-rockchip-core.c  | 50 ++++++++++++++++++-
>   1 file changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> index 8ede74da40c9..345e0abdf5d1 100644
> --- a/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> +++ b/drivers/pinctrl/rockchip/pinctrl-rockchip-core.c
> @@ -126,7 +126,7 @@ static int rockchip_get_mux(struct rockchip_pin_bank *bank, int pin)
>   
>   	if (bank->iomux[iomux_num].type & IOMUX_UNROUTED) {
>   		debug("pin %d is unrouted\n", pin);
> -		return -EINVAL;
> +		return -ENOENT;

Rather ENODEV or ENXIO according to the comments in 
https://elixir.bootlin.com/u-boot/v2024.07/source/include/linux/errno.h?

>   	}
>   
>   	if (bank->iomux[iomux_num].type & IOMUX_GPIO_ONLY)
> @@ -193,6 +193,32 @@ static struct rockchip_pin_bank *rockchip_pin_to_bank(struct udevice *dev,
>   	return NULL;
>   }
>   
> +static int rockchip_pinctrl_get_pins_count(struct udevice *dev)
> +{
> +	struct rockchip_pinctrl_priv *priv = dev_get_priv(dev);
> +	struct rockchip_pin_ctrl *ctrl = priv->ctrl;
> +
> +	return ctrl->nr_pins;
> +}
> +
> +static const char *rockchip_pinctrl_get_pin_name(struct udevice *dev,
> +						 unsigned int selector)
> +{
> +	static char name[PINNAME_SIZE];
> +	struct rockchip_pin_bank *bank;
> +	unsigned int index;
> +
> +	bank = rockchip_pin_to_bank(dev, selector);
> +	if (!bank)
> +		return NULL;
> +
> +	index = selector - bank->pin_base;
> +	snprintf(name, sizeof(name), "GPIO%u_%c%u",
> +		 bank->bank_num, 'A' + (index / 8), index % 8);
> +

So before I forget, I think we have an issue on PX30 (unrelated to this 
patch) because GPIO0 is said to have 32 pins but it doesn't, it has 24, 
c.f. the TRM where GPIO0 doesn't have a D "sub-bank". I'll have to check 
the Linux kernel driver(s) too, but considering we've been using sysfs 
for setting GPIOs on PX30 for a while in the kernel, I assume somehow 
this is handled properly (or just luck).

I'm also wondering if the name shouldn't rather be the one coming from 
gpio-line-names too? This probably is more for the gpio command than the 
pinctrl one though I assume? I guess we could also tackle this in the 
future if someone would like to have this instead.

Cheers,
Quentin
