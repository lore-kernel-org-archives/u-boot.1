Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D94EC48295
	for <u-boot@archiver.kernel.org>; Mon,  5 Feb 2024 13:12:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7FAE486D38;
	Mon,  5 Feb 2024 14:12:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="TIc9pDu8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C9E6286F8E; Mon,  5 Feb 2024 14:12:08 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4CFD486308
 for <u-boot@lists.denx.de>; Mon,  5 Feb 2024 14:12:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GFA1AgiUn8NvipvjP2X8W8u7bzrBbDiLHjzejNK1Gu18gNNkbviKC8bK5wQvxz77QCiM8X2mnATb4VnfnJrXny8LaOfRbH0OZgqztizPfyKIw0Birr7ToveJ7vA2xOHuT2gmM3FcuNsuUDDbRsa+lwWYNNUR6VTL0Tg+3ejHvXa3xmTS8z/NWUO7+hTe6rUD+wvDc0kRllZ7TKgVLOsZHDfI4IB4hI2oJXkCLv863csHSbk/tvR1coSRHGsnPpziS9+ZuKseUPpR0FDPxH/rDPsAgU9Zu2r2kdM4Rq1FHYhPdnUtzpxC3gi/IZjxDOIMDo+NV6bHV63z7QSh+OW/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+XH7xByJwfL3QW+UlR1X+Pn7VI2GoLrjvgR7rAPQSkU=;
 b=bu1T21ZllBMMTfdRUVl8Bdnd7liIjOpEWqjwdIURt9xFEm/EG+URFXwbeb2irg1DR4EjjApsQ6FJnx+FjXe8vMo0ibiLroYddnEJEO9LYAQzyLOkUNudJdGfTLmBXe4DytZpsjh86TWhumfRViuf2+1ofBkP2LAWJjG/msqihTNf+GHzYGXLrWMuS6U833xzqSv6CVKiDw40RRyV/YHiKF7K7JJhLKKGDxCHPh/M0gPsmw9u8UK1DvWJAooF+LAUgUcid4sKdkEpVm7HOYLDf5v1MHv99czZ5Zxn98LxzAIapptnUk91H8AMuqDpRXjzvoKY/BR1WPc61CMDgks/SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+XH7xByJwfL3QW+UlR1X+Pn7VI2GoLrjvgR7rAPQSkU=;
 b=TIc9pDu8gXOwpg9eB+VczkHy4B+XFAwCrOOM67SfWm0TJa8AyPvYWKTZ5YhXvKVqoJODJ4KQiQkMWwuKZPzSE0nXqypDAeQFmyvf9l5NaMt3MGygd0FLGRlFQ5+eyi+3mm0T4uZ7X6NQ/KAOLIsD88ah7ls3wqwYWQ2uKwWCXHhqlXVvrdC0TJ3ubuf0EHMd3jQVOJX6+fNitv5E9/G3z3mqHhB2E58lu7B/dz9YmPbqn+IUVI/hm+4nk4W7T/BuROluEcm/njew3SazCMWWp9muyefTGiHvwqtExEBwNvUGOM04cwgAaLYozc+RPMpN/hTyPZDsG9AKAJzn13Wxxg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB8462.eurprd04.prod.outlook.com (2603:10a6:10:2cd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34; Mon, 5 Feb
 2024 13:12:04 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7249.032; Mon, 5 Feb 2024
 13:12:03 +0000
Message-ID: <7619749e-0d34-446b-bf82-40e7b5b4bf18@theobroma-systems.com>
Date: Mon, 5 Feb 2024 14:12:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] rockchip: rk35xx: Enable eMMC HS200 mode by default
Content-Language: en-US
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Tianling Shen <cnsztl@gmail.com>
Cc: Eugen Hristev <eugen.hristev@collabora.com>,
 Weizhao Ouyang <o451686892@gmail.com>, u-boot@lists.denx.de
References: <20240204205312.2342868-1-jonas@kwiboo.se>
 <20240204205312.2342868-3-jonas@kwiboo.se>
 <5124b52c-47d7-4232-907d-d09a5065ff1e@theobroma-systems.com>
 <be4737c1-57e0-4648-b583-56fcab91b20f@kwiboo.se>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <be4737c1-57e0-4648-b583-56fcab91b20f@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: FR0P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:49::13) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB8462:EE_
X-MS-Office365-Filtering-Correlation-Id: 094fdbc2-efc7-4a00-f74b-08dc264c0bdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D4RLDqwipxq5pR3YBT22o3majzahcFgLjNUoXpq136j01hUzr8ctwH8YqssK63jo+EnCr3YbuJzLX4O0tVxIBqtFBm1aR72i90KGm4TiFiyUXUkG3Tkgz7LRfHQ8ywWhYdhMPcmjz1Fv5CJxVWo14yEkI+rfBFlvuYdoUESK9/bqcd6fXll0pbr3HKSe7fhCAww5rpGI+FwmzUkW6otqt9m+mt6ta9rwf3aZ4DTVGuNuxy/qfYvxbpPuNJ+BInhLCWs31VH3Vpc2OyWsGmcsgPuyj5uVMWUM2+xb7AvNp0vCLuA7KHZnzhVEHVZZxyryf4JAQn4YBrfS32C/Kzbd45aopfRRXMXUuG7EetsI8onwJ91j3sbAFCg0mk09bbrIrXInGhjtQtfOb+elsJyLcsz0L4LYlFuo9nlKLONoRVtUyqk79OffigGVp8nndeoyuMAnBzmlCGVmYGpiCwewejjVb4eghyRaw8+IBvEbgTWXoQx5J8+G+fxuw3u7AVK+hdoFdz6B/nEAIh+g3GOy1jcd+DDN/ZVIMN+9NujEuBmJWeD/nOO+CAkg+M7OrhXv4BIaZOkOFTRtJ6a/c6+3cdd0ke5QbZZGAwFV01OmovlwWT99xp41ZAiFvGC8MFZMusSI4wnBy+zT6bmyneapTg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(346002)(39850400004)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(41300700001)(36756003)(83380400001)(6506007)(53546011)(26005)(2906002)(38100700002)(45080400002)(6512007)(2616005)(66556008)(316002)(66476007)(966005)(54906003)(66946007)(6486002)(478600001)(110136005)(31696002)(86362001)(8676002)(4326008)(8936002)(44832011)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L08vUU9ac2NtQjF4UWRtL0JVdHo3OVNURGR6OUV1dVc3aktRMlVDQ1RiWjMx?=
 =?utf-8?B?WmZsUnhRUDd3VXBhQW1TOGxiNU9DNnRvN1dTSnJjczlOOURybngxWjlFWm9R?=
 =?utf-8?B?RUk5c3UzRjV3WEZnOC83NkdwV2xMNE9oWDFXNzNEaU8zc1FzS096R0ZrZDFv?=
 =?utf-8?B?T2RpZUN2VTg0T0ZQdCtUYWE1dWMyZFhwMy90Vjd2Nng3WUJNa1NDK3BCWXpN?=
 =?utf-8?B?b25HQmgwWmdyNkhUMkZDSWRjU0t2ZWlFYmdtUGlLQkRQVXFhYnhDNGZuQ2py?=
 =?utf-8?B?Z0wrdEc1a01lSmRPUFBrNStyS2g2Vms0VHhpZTZWR3IrM2Q4MW4rdkp4dkpF?=
 =?utf-8?B?OVNaTS9mcEhQWWtIaVRFNFFvQ3QyRFB0QTNkTUJlTlJCb01BWWlhTTd3c013?=
 =?utf-8?B?TU5IVXhKaWh4eWIyS3VBREwxNXF4TzZuTlB1RFVxNkozeWZqUDNMZFlSTzdP?=
 =?utf-8?B?TGdQK1VDZDNqZktCTVJpbHR4ZVM2K3RqdnE0dVcwMmV3RHp0N2t4TnJoWGdU?=
 =?utf-8?B?eXZCNzRrMm5NZER4bkNiaFhSQVQ1ZDVJOGtpL3V5NFhkaS9nU28vcWRkRzMz?=
 =?utf-8?B?Qmh4VUNCMXNRMmdsY1BZNHJvTHovVmNMNFZaVkJTTU9DbGJIbXVNV0hXRVI5?=
 =?utf-8?B?RHpvS2hlL2JVWHoxcitJZTE3alBFbnY2cFdHT0EvOFlReEVtUUZLOWh5TXpJ?=
 =?utf-8?B?WHZCbXBMVHlyRHZNT0tkNC9sUkpNdjRnRTgvcFpzS2EwTUozWUxyRUwrTWM0?=
 =?utf-8?B?NmR6V1hxSXA3aHliRUFFekJ6ZjB6SkhCUG0rOEErNFh6dkdQbVVjTmVKcXl1?=
 =?utf-8?B?OTh6Qnlob3JpZUcwejVUYlZDWm5GRXlaLzJzMFRweHJlQnlURGZOOE1QYXF3?=
 =?utf-8?B?amFPcldkU1UrNEwwZGJQM2ViMlNQKzNFQlVXU3MzZVAwRld3NkQxVkwvdHl3?=
 =?utf-8?B?d0pYK25ncFFYQzZGZTBJdEdLTUNBbkZ4RGF2ZjBtZ2lIK0pHWVFWbGtUaXp1?=
 =?utf-8?B?cU4wM0xQOHFScUsvMy9XbVlSNis3TXc3R0ptTGRydkpVR0FCcDdtcUZBTWV0?=
 =?utf-8?B?NHFpZ09EVWlMWUdzbjA2WlNxdVpGOTVRUGJlci9iNjg0Nmp4c0VoekRadkxk?=
 =?utf-8?B?WUFrY1NwNTBhU1dGU2xtWVpMYUYzRTRLUTAyOWdjV0tCUjB1Q1hQZENlU0Nw?=
 =?utf-8?B?Uk1EZ2w3L1Z3OXBjMTVOanVXV2FJdEJJOUl0ZzF4RjVRUTNvWU5rbWsyZjRE?=
 =?utf-8?B?M0UrYzJxT1hBRmx4cVhheXNUVjl4dTcrVjgvZW1rb2l1RmhabE5JMTZlM1l0?=
 =?utf-8?B?Uzd1Wnc4VkhBeWVCNFhTZkIyakJ6QmtFQTJSa1ZRTmdrczJVaFQ5RkhCYXA4?=
 =?utf-8?B?RFhidlB5VGRCSm1RcnlJKzZHZm5ncnJLckxuRzdJcWc2V0ZXZm9TbjF6NTNy?=
 =?utf-8?B?Rk55dkc2d0FlNDdYUklocGJKLzlQeEZmQUMrcUJza3pPb3VRQlRsbzlPTTNh?=
 =?utf-8?B?bHUvcFFsZXJPY1d1V0FGVk5QcmhhZDE1RFJCQjd6R3dFenJZbUZweWlzNldo?=
 =?utf-8?B?bjlCT2JtYzhYSmlrSk54cHBuOVRjSEY1VlJtVU1ucGV2VUtna3gwRDdKa3Jo?=
 =?utf-8?B?WXUrNWN4bTFkQnBlUFMrN2k1YU1IU1BJZ2RDTmRlYTFoZ1hZdW5wNjlMb29o?=
 =?utf-8?B?bXBUd0k2TUthZm13eVdORW5JNXZMdisxUVQ5QWdyOEVjWTJSMGptMUJXMzlo?=
 =?utf-8?B?MEYzYi93YnIzN2tCazdsRWhQYWJiTDVxOHQ3SmcwdGlWQUpYQVZqZTBsTEc0?=
 =?utf-8?B?N25KcnpUM2IvdStVWkIreEhCbkZZT3lRNjd0WkFqTDlIcldkV3U1VzRYWFJP?=
 =?utf-8?B?ZmRLOUduZ2I2TmxvNkVjV2JQY0NUNXJoUktQQ2ZhQXczL1VKUVQzQ1l4MTlJ?=
 =?utf-8?B?UkhDMEN3T1hHRWtveUZ0NStuYk5tUEt3NUY2UUJDUHYvZXVJakUvYjFzN2xH?=
 =?utf-8?B?c283c2NNQzRGOGszcndoUDJuNmcwL1EyUDl0eUsvZ3dsbG9RUjYycTdnSWZT?=
 =?utf-8?B?L1RLcjBxMzdnSFJWR0FIVXRFcS9pZTJOZ05xMDhoYjg3dTI0akx3RGZmWmh6?=
 =?utf-8?B?SGRrRkQrR05YczloRmFwWUhHSFBKVDFYcHpwalVXdHZMa3BCM1d5amRIbFVN?=
 =?utf-8?Q?RYC174WIPBBHhNiLDvBqTBI=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 094fdbc2-efc7-4a00-f74b-08dc264c0bdb
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 13:12:03.9463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSckOWqdnWgziRUJ/u9BM0Wkm5u/rucrRnS9QOD4kTQ9CosgX1Ft1ZRIyTmxgzAjLfIipU6tf8o8uhkABvG5mISRW+uZsyuWEZzTP0/6SiPoGuJl1f0Av5FsCf3fK6Sb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8462
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

On 2/5/24 14:05, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-02-05 10:47, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 2/4/24 21:53, Jonas Karlman wrote:
>>> Testing has shown that writing to eMMC using a slower mode then HS200
>>> typically generate an ERROR on first attempt on RK3588.
>>>
>>>     # Rescan using MMC legacy mode
>>>     => mmc rescan 0
>>>
>>>     # Write a single block to sector 0x4000 fails with ERROR
>>>     => mmc write 20000000 4000 1
>>>
>>>     # Write a single block to sector 0x4000 now works
>>>     => mmc write 20000000 4000 1
>>>
>>> With the MMC_SPEED_MODE_SET Kconfig option enabled.
>>>
>>> Writing to eMMC using HS200 mode work more reliably than slower modes on
>>> RK35xx boards. Enable MMC_HS200_SUPPORT Kconfig option by default to
>>> prefer use of HS200 mode on RK356x and RK3588.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>> Changes in v2:
>>> - Imply MMC_HS200_SUPPORT and SPL_MMC_HS200_SUPPORT in arch Kconfig
>>>     instead of adding to each boards defconfig
>>> - R-b tags not collected because of above change
>>> - Combine changes for rk356x and rk3588 in one patch
>>> - Update commit message
>>>
>>> Link to v1: https://patchwork.ozlabs.org/patch/1891693/
>>> ---
>>>    arch/arm/mach-rockchip/Kconfig      | 4 ++++
>>>    configs/nanopi-r5c-rk3568_defconfig | 2 --
>>>    configs/nanopi-r5s-rk3568_defconfig | 2 --
>>>    configs/radxa-e25-rk3568_defconfig  | 2 --
>>>    4 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>>> index 6ff0aa6911e2..946ef5d7023d 100644
>>> --- a/arch/arm/mach-rockchip/Kconfig
>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>> @@ -292,6 +292,8 @@ config ROCKCHIP_RK3568
>>>    	imply OF_LIBFDT_OVERLAY
>>>    	imply ROCKCHIP_OTP
>>>    	imply MISC_INIT_R
>>> +	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>>
>> MMC_SDHCI_ROCKCHIP is also required for eMMC on RK3399, which would
>> change the current default, at the very least for Puma RK3399.
>>
>> Doing a:
>>
>> rg -lU --multiline-dotall 'RK3399.*MMC_HS.*' configs/
>>
>> Only returns:
>> configs/evb-rk3399_defconfig
>> configs/pinebook-pro-rk3399_defconfig
>>
>> and there are 29 defconfigs for RK3399-based boards right now, so maybe
>> that's a bit too big of a change?
> 
> The imply statements added in this patch should only affect
> ROCKCHIP_RK3568 and ROCKCHIP_RK3588, nothing should change for RK3399,
> at least not intentionally.
> 

Clearly misread the patch, sorry for the noise.

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Cheers,
Quentin
