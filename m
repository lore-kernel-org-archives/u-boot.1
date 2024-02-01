Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6339C47DDB
	for <u-boot@archiver.kernel.org>; Thu,  1 Feb 2024 12:40:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3FA7187CFC;
	Thu,  1 Feb 2024 13:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="bnAe1728";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F39D87CFF; Thu,  1 Feb 2024 13:40:26 +0100 (CET)
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04on070c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe0c::70c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B58187CF6
 for <u-boot@lists.denx.de>; Thu,  1 Feb 2024 13:40:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ke6LR7lynpzH2y0qxzX4vC6ttg7pF2SfTmgWsfCmmbNqtGkRAQZGW3wspbHsVgOm6i2oHUjqIfYPaYzLIc3hcU8MVpFfT37SzNLhD1erAQYhBZ4qZ8GXL3FgnQy92KpAmVV0T4ZwO6IkItZvqw3mt2zDSyY5qCOx1LSJGZ6ayybvgPTEHo2xfKdaFyH3196sEmn2I4zvc6R+LyJ5uPwEgZPaEdUA0l+/AcYQV0yp9yf5sbWTPGMfLS9dxlSpGynzJK1d/AHKXJv3pzwfBVZsCMp7vSrSGsITmkA0A5lIeM2RLWNlRhyxxr32lZLIw0/YGsv9Nk4rIBLk6fm1Ft2+yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HO+n39DO9YGvkuM3Loo132ZsMXoN8/4IvjJcIIjDLXM=;
 b=Q+q2/mWIIpkPoK3jiWWefSqOJXVP1OkDkXYIcFDfNQ1dqrEV/PvBgZo/FY0mjk6vZ/UVz8HBc4uR64xFUE3XjEcSg08klgPqKKapNaa6Yag33VJ2hmYuC6c+sJmt/wlhcVCxXTk4B/TORYjFR0C8mLRzGtqthuNxCpPmZB4/EHAdozw8gvRhriRcip1CtHA/w+KX6a+0pF8+gIICVcgdLVXty8Ha9L3rztCzLc8ly0m0ZK++0uZAqEHG6W5siACyPcIgTanud5TUUC/HWvr5uV8NICxXBLH9anQan9J850NKceiTh2soUGRjBoMr0QNem3ZFmQCVCw8P5oWI9WRL6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HO+n39DO9YGvkuM3Loo132ZsMXoN8/4IvjJcIIjDLXM=;
 b=bnAe1728AtYvPtcMXaFCTRgHZbivz+8bPhMYezfZ43LXp890IyF2niGJa5WyDs80CoagWRMHcAun9cQhqBgoaKkZIMgX7pX8XbQ4I3kFIEmOyDfihsCwa+YEn1rNvfGyC7BCO/MTSmibcAbMwmkqWAalOtYwuKe0cVRUAC/cAWVkDqiQlYxuyIcuzd67DPmp63EhdrKy0VWWi7OdvzU+WGTCerSePCwxktlIOxFOpY6dagzqlOFHiDdehr4cuxvz6NPFeeYIlXgmLP8cGTLPEHUGv6FHlF75hHSpSehia2aAA3K9OTrYh6t612z8S/lFdWY84r9AHT9DsXCzkrHgIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by GVXPR04MB10069.eurprd04.prod.outlook.com (2603:10a6:150:121::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 12:40:20 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.027; Thu, 1 Feb 2024
 12:40:20 +0000
Message-ID: <ab9af16d-37f5-43a1-9dc6-9d1ba93c1689@theobroma-systems.com>
Date: Thu, 1 Feb 2024 13:40:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rockchip: rk35xx: Remove use of eMMC DDR52 mode
To: Jonas Karlman <jonas@kwiboo.se>,
 Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Andy Yan <andyshrk@163.com>,
 Tianling Shen <cnsztl@gmail.com>, Akash Gajjar <gajjar04akash@gmail.com>,
 Joshua Riek <jjriek@verizon.net>
References: <20240126232615.6826-1-jonas@kwiboo.se>
 <20240126232615.6826-2-jonas@kwiboo.se>
 <515157a9-8d19-42f9-ae6d-914aaea8a3ba@collabora.com>
 <e1417a87-15ee-4e1b-9513-c101a02118d4@kwiboo.se>
 <23d7337a-88b7-4dcb-be08-c42b21e9dbd1@theobroma-systems.com>
 <e9d6883b-4331-4237-be19-5df6126a3962@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <e9d6883b-4331-4237-be19-5df6126a3962@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0031.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::15) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|GVXPR04MB10069:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a0c334a-3f18-4865-cb92-08dc2322f381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MqA4YmRtvhrjAtzVODZ3Z7fOaQMGPOmu6BtDNtXqDHchQ6KT0d8hzs7bml04xtbwzPkwZm4Er1ubbQLzrNbHxvoju+pBXmCgfcbRQyv0CLo6gumDvdpDT2zCJkwQa2ETOUvPAyIaOiMa6JYprHx9Co4vEpFswYjAdFFUlKr2z1V9HcWHkSxQ9VSgoBQ/JttXL1jnygW5xHrtDNrJmpiPCnlFSbjilqrtI6+WFN/DYCknFGzHXVPuUQlFwGyAkzT71rERf0KUfXwD0etu0/JvN/Mm50He5qVlJLxLJurHECkaQKBL/yKUahcPaIBZ87FxuVR+xgsXfVAvKmt2si55jCwYY0gLQCD1H4CZFVWxUE5eKXaNC08+Dw1STX5pIN5/WJtx7qr8YNbxk7Tb7XB27v7sjvQz9xP7PrMHKshtk83Ams6ulvyzvG3JtH9qVkEw7HHDklEGBdo+iEfd5boxp4P1EaAO8ZtDrKTMtHZ3CSKtpDZITjbzNM5dCaNCjgB3u3ACz3WjHGfVBN8wAE7A9Px/anNxFNw81tPyoftPD77WiUMBhpl2egH129sgKn3bvlwVfC1kUY1S89Khr38bEULvI32U9MU7kUXLG5G6jG0uIXGLODm+L5zM0qgLBcdEluHFRbGaT/DNcpC3g78D3A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(366004)(39850400004)(346002)(396003)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(110136005)(66476007)(5660300002)(2906002)(7416002)(66556008)(44832011)(316002)(8936002)(54906003)(66946007)(4326008)(8676002)(478600001)(6486002)(6506007)(36756003)(38100700002)(31696002)(86362001)(26005)(2616005)(41300700001)(53546011)(6512007)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dE9FS1dpWXR5aE1pbEdNMkNWL0pVS3h1N0J4ZjNpTHlFb2xFTnFXWmdOTzVq?=
 =?utf-8?B?aXZGOThBUHplVDRzT2dEV0NaNmdpblJseVowZlE3UVRSZVhTaXFydWNMQk9q?=
 =?utf-8?B?SW1KV09Xa0NTT0ZxQ3dmRm5IaUduZlpuWVF5SDVOUjRXVE8rWWhLUHZyUVgz?=
 =?utf-8?B?dWhic1FRcEhoZEd5RENVY3N3YVYwZFNlVmx6aUJwSWFNeU4yMnpwcGVpMVc3?=
 =?utf-8?B?aDM4RFp2SitNV1MxcUt4U292UkRxT0VnS2UxdGhDeWw0dlVYSzVCaVU4WlR1?=
 =?utf-8?B?SS80emJRWldNWGEvSUhOUjZnbHdlYnJneTRqdCs4SjhKZDlwNDYrZUxFSjNy?=
 =?utf-8?B?bzk1VzAyWnRLRjQ5NERnU1pRczBKdHJPTzkrZW5HUXFscVo4VnNFTzFKQm1t?=
 =?utf-8?B?L1hSSW9yNFg3U1VZU2g0SSt2b0NkUldBcmxKZUtiVXJtd3AyT29aMnB4dHVE?=
 =?utf-8?B?WnB3YzhmMG81QjVmQmZFSGdYSnFyaWVjYkQyYkxJWDZLK0htY2pzbVR5Q1dF?=
 =?utf-8?B?eGYzSzdDVGNpaTc4MS9LZlhtYVVuYStFSTZaMEIrUlZqREZ4a3R0Z2wzN1VV?=
 =?utf-8?B?TG5xbXI5ZXlrM0pwZEYycEpQZEpyR1EyU1pkbDVzRks2WThlUUk2ZGZmSWxP?=
 =?utf-8?B?MEQzdHcwK1BzY21kbi9NbnhVbmxXellXWWtzK1dGdlhpMS9GaWtIRnFOaFY0?=
 =?utf-8?B?eHhwOTViZ0h4VSs1Y29nQTc2MWhna1ZubDVDV08ySjF0ZGxpbk9zeHc0K0xW?=
 =?utf-8?B?Z1NVVTY1SWFvVkZteFBxTndlTm5rcWZURSsraVhOTEVpZHJ6WlM3RmZrM1F3?=
 =?utf-8?B?cEV6ZFNvd0kyU3o4Zys1QzN2Yk1MSmsxNTh1UWEyV3h0YUIraFhxMS9ZUTEz?=
 =?utf-8?B?RWZjVTE2YjJ4TGNuclkzNG1mSVF5STBRWkU5NTk0Z3JTc3FHS0U1aCt3UklJ?=
 =?utf-8?B?T0Q0SmhoODd0S3pZc0RkWXllMkM1OXVibWVwZFR3T0QwWFEzUHdyVXBDaDRk?=
 =?utf-8?B?dU1kMkp1bHlIUHUxcTh1UlJOK05MUmtWQUdBblRIZXQ3ME16eUQyUUFjMEdJ?=
 =?utf-8?B?b1JZcENGQXpISXVJUjZNRG92Y2hER2RPNVBYSVlrbjBGZVlVajYxaFZMalBo?=
 =?utf-8?B?S002WjNJa1d3UzJINHVodk4xRlFlT3dMcmdmNDFwM014T3drcndZREdqK1RU?=
 =?utf-8?B?QXJ1Mk5yZDN5TDRoamRHMDlhQ3R3bkY4bTZuWnZEQ1BPMkdnakptc0t1R1hY?=
 =?utf-8?B?MmxNQ2tWVW1XYkd0ME52ZkxrcG1oS2JHWXhNTEdsWjErYXpRUDZCSk5UbE54?=
 =?utf-8?B?NU1Ldi8zUEVWY2RvaG9ud2tKTEoxYjgrb0lpT0toTTZoMWthUWVyS0FjdjFM?=
 =?utf-8?B?K2VlV0twbDRwd253K0hSeUZ2SmZGK1lBcHFHYVc5QXB0TTg3TXpDamlBTWxx?=
 =?utf-8?B?WXZ1OStDcnhadnduNGVvaTVFRG5jdVZqVGxjYXVwSDNFQzFENksreVNJU2c5?=
 =?utf-8?B?ZnlTYXpyakp4dGJVV1BnMUl1MUgwTkxBL1lLTXRKZm9GVXExVnNUMW9meFhh?=
 =?utf-8?B?M1B4U2pJbm4xTW5CWEFOSHlZVmVraU5yeXVINDl5alBZeUUwbWF6aDlPZGMy?=
 =?utf-8?B?MS94UnBvUUNGdUFBMUhTWmE2TGVWVWhleXd2SHpEc3RZQXdlOUlGSTRUc3Jk?=
 =?utf-8?B?bDZWeE1LR0xhNUJtVW4vUVFUTzhRdVVTMFl4dThLeHBtUFJPMkJOb0wrVWJK?=
 =?utf-8?B?SHZ3Y0k4bzRWczIxSm5VOUlrZXZQQ1BOR0lyZXYrMFZyRmpva0I3cFA3L2p6?=
 =?utf-8?B?VzAzUE56Z1JvazROMHVURVc0ZitvMFcvWTBKQW01bWNMN3hQVWtiWFp6MGZW?=
 =?utf-8?B?ejZhOEVoSXVBdzgyZWhhV3F5TUpaTXJWR1NjOHZnME8wcFdGWEh5ZTJVcGJX?=
 =?utf-8?B?UXJnZXpVOFh2SGJsUGFHS3VUZHpVdStiVEdZbmJoQmk5TzRHOXdDSFJReEVk?=
 =?utf-8?B?M3BNc0lIajN5UG1QN09nUlhaRnhQY3dYTkxXaXpYZWU1MlQ0Rm1GWDBseWlR?=
 =?utf-8?B?VGE3OTljMnNoWkE0QTJtdGJ5MHdIZWFqaXBLNGE3b3FqbkloaDhGbTROVHlu?=
 =?utf-8?B?c3laZVhKYWdmUEJaRVhZandadk9TQllwSXMxV0RWZjV2Z2pUUkNMZE1SRzVN?=
 =?utf-8?Q?koPtuHhHxOwrCkzkdl8S1ro=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a0c334a-3f18-4865-cb92-08dc2322f381
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:40:20.2709 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SGm/I04sHmAAlzpz2c3JK54Ds4DNsAvjK8A0sRkNIFC2Z3jldOCa3tCarakjogrYo9c/io7N5BAPlD2+kO1CVzvLAFZk8jJoycrTxqC2uqHVq89n4zt5Cg9FCxEX4NJ8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10069
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

On 2/1/24 11:51, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-02-01 11:18, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 1/27/24 12:15, Jonas Karlman wrote:
>>> Hi Eugen,
>>>
>>> On 2024-01-27 04:48, Eugen Hristev wrote:
>>>> Hi Jonas,
>>>>
>>>>
>>>> On 1/27/24 01:26, Jonas Karlman wrote:
>>>>> Writing to eMMC using DDR52 mode does not work reliably or at all on
>>>>> RK356x and RK3588 boards.
>>>>>
>>>>
>>>>
>>>> This is related to the old issue I encountered last year with mmc write?
>>>
>>> Yes, I think it is.
>>>
>>> I did some testing on RK3566/RK3568/RK3588S/RK3588 boards with different
>>> eMMC modules with following result:
>>>
>>> Read seem to work with all enabled modes:
>>> RK3566: MMC legacy, MMC High Speed (26MHz), MMC High Speed (52MHz),
>>>           MMC DDR52 (52MHz) and HS200 (200MHz)
>>> RK3568/RK3588S/RK3588: all above + HS400 (200MHz) and HS400ES (200MHz)
>>>
>>> However, write had issues with some of the modes:
>>> MMC DDR52 (52MHz): all RK35xx
>>> HS400/HS400ES: only on RK3568 after changing hs400_txclk_tapnum to 8
>>>
>>> HS200 seem to be the most stable write speed that worked on all SoCs.
>>>
>>> So, dropping MMC DDR52 (52MHz) and enable use of HS200 (200MHz) seem to
>>> be the best option to get speedy and working read and write eMMC.
>>>
>>
>> 1) we have this enabled on RK3588 Jaguar in upstream Linux... I may have
>> improperly tested it then, would you mind sharing how you tested this
>> mode on RK3588 so I can reproduce this and fix it on our product if
>> we're impacted? I assume because we have HS200/HS400/HS400-ES enabled,
>> DDR52 would never be used? (our eMMC is soldered and support the former
>> modes).
> 
> My main mode of testing eMMC in U-Boot has been to enable following
> Kconfig options,
> 
> CONFIG_MMC_HS200_SUPPORT=y
> CONFIG_MMC_HS400_SUPPORT=y
> CONFIG_MMC_HS400_ES_SUPPORT=y
> CONFIG_MMC_SPEED_MODE_SET=y
> 
> and from U-Boot cli run following,
> 
> => mmc rescan <mode> && mmc info && mmc read 10000000 2000 10000
> => mmc rescan <mode> && mmc info && mmc write 20000000 4000 10000
> 
> for each of the modes below.
> 
>    0 = MMC legacy
>    1 = MMC High Speed (26MHz)
>    3 = MMC High Speed (52MHz)
>    4 = MMC DDR52 (52MHz)
>    10 = HS200 (200MHz)
>    11 = HS400 (200MHz)
>    12 = HS400ES (200MHz)
> 
> on different boards and different eMMC modules.
> 
> Using some modes the read or write return ERROR instead of OK. When
> ERROR was reported a rescan or board reset was needed to test next mode.
> 
> Please also note that I have only tested in U-Boot, not in linux.
> 

Thanks for the tips on how to test these.

I have run the following commands on an RK3588 Jaguar (master branch + 
your v6.8-rc1 DTS sync patch series + Jaguar patch series):

=> for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do for i 
in 0 1 3 4 10 11 12; do mmc rescan $i && mmc read 10000000 2000 100000; 
if test $? -ne 0; then echo $i FAILED; fi; done; done

Which is 20 iterations of an mmc read at each of the 7 supported modes. 
The result is:
1 fail in HS200, 2 fails in HS400, the rest passes just fine.

=> for j in 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19; do for i 
in 0 1 3 4 10 11 12; do mmc rescan $i && mmc write 20000000 4000 100000; 
if test $? -ne 0; then echo $i FAILED; fi; done; done

Which is 20 iterations of an mmc write at each of the 7 supported modes. 
The result is:
20 fails in DDR52, 2 fails in HS200, the rest passes just fine.

So it seems DDR52, HS200 and HS400 aren't stable on my board, but 
HS400ES somehow is (which is enabled in our defconfig).

I'll check if there's an easier way to test the Linux kernel than 
rebooting with a newer DTB between every try.

Cheers,
Quentin

>>
>> 2) Why are we not enabling HS400/HS400-ES for RK3588 boards? You seem to
>> be saying there are issues with HS400/HS400-ES on RK3568 but you didn't
>> mention the status for RK3588. Did I misunderstand the last sentence?
>> Can you please rephrase in that case?
> 
> I can see now that my wording was very confusing.
> 
> Write for HS400/HS400ES mode only worked on RK3568 after modification to
> the driver, on RK3588 write always returned error for me.
> 
> So on RK3568 HS400 modes could be made work, on remaining SoCs there was
> issues.
> 
> Regards,
> Jonas
> 
>>
>> Cheers,
>> Quentin
> 
