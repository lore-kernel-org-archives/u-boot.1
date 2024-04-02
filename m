Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A85BFC6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:36:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2260B88173;
	Tue,  2 Apr 2024 15:36:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="hQ80PbHJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B14387964; Tue,  2 Apr 2024 15:36:32 +0200 (CEST)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0711.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::711])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9227D8830E
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:36:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHTZmcQ61mum7ijt6YEGx3tltXKay3iX6W8uPXbAa9qHnPlRqV8HTCl0DlHIHIyh2xQDVSBzOSoug+yu5pBD0w3zMsoTebyaa5avHSyc5DFgPi5fq/h/mqCbSNP8JH6F9fIMUAGhOI0r4iDtTjPzgwn7xmXh+OGhHm1BVjOzhz3ShunQw0dO0KiroZpwbe61uPYc/QEZKcC2E+aJ+PDgh8yttEyn1Ak+BcK9PeosqWixgAc+LRj9wyV69wfRF05WLD2ilDlJrCzuMeSE6kamZ+Ag7NOquHMHaLTtXAEBbNvqqiIj2vWmQ9B5FCbmZ9WTXccwC/IwVHuoG2hPwVOwjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9FrsLu1URUotWLh6OMrhg8JuUqj/9LnegjBilw+4ejE=;
 b=RLejG9dMwbEiAHJC06i7Y6Xu6A6PqLXtV3RcAjZtcGU/2YXzIABHAxn/t7gjxeNCAtiI/wqkiy6RLCtxn6mrOlcfqPVuek/pOjOtw4ySH2UrWnGfIK0I5zCjFqkmutQmMtqNnLWSui9cffwHVOZRIpdX26YSm20yUOygC4gGFda5tg728Bcqg8OQw96gTR503xC4UVq+ekx7TksqTEPDwcTvPesD36Q6JEWxEFp9tWUz1jb3zGH2NkwYLyGgn3zo1XDo0MEBaprZyW8XHtFqTNfqySmJZH463DFWoPoopQzquat4Pe74TT36wcYNzul9eo0rs0WmpmPzO9W9V4+apQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9FrsLu1URUotWLh6OMrhg8JuUqj/9LnegjBilw+4ejE=;
 b=hQ80PbHJkBY94MxG8f6m6KQRl+Lxr84fR8IpC9SJ7vmIC9pGIWPeh7BovhLIEu1L8jVhwLaBkqaAW+/Z9y8OGf3y8t22LeW8u1gLg4GcPI33o3D2l3ljbwIZ0bX2BtI3xcLzUzKkQ1RqGsQP/MC6V+OL17bTDRNEr9Y/o/WOugJYIrWFgmn1ihpnRkzOfPBynitlzbO4OujjCneY2WTqQDe8AZpb6q/M7mouO4gKEwx94vhT/K+9vGTOZRFqGaGfcGgLO6V26isKnLWZEfqUTAN82TtZGLPrXppjRMkHcWZ07fAewz/1WxGzwpjizzKcny3FfrYUXM9kE06j2IbEDQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PR3PR04MB7324.eurprd04.prod.outlook.com (2603:10a6:102:91::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 2 Apr
 2024 13:36:27 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:36:27 +0000
Message-ID: <53d830f8-fd51-4d21-9945-6ccad833ffee@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:36:25 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/19] rockchip: rk35xx: Imply support for GbE PHY
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Kever Yang <kever.yang@rock-chips.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-9-jonas@kwiboo.se>
 <d210412c-ec9d-480b-ac0a-da7976490f78@theobroma-systems.com>
 <2113e684-09db-4145-afb8-c1166366a30f@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <2113e684-09db-4145-afb8-c1166366a30f@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0022.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::29) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PR3PR04MB7324:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 82uQLeUqGzbQq+Iq6UwuXVzL06aEPMX6yjhaaOh9GtiQ/SaKHC4NyUiWvGXrXf5RMR25p61QLGQ56/lGidzDMmR/Zou4NVwgWDhU9K6Rb/L6e0WQIvXxcYEfi1kePGZkKm3CJFMi9GGgEGyzsNpCbvEWvB+hhHqnq9YOKT+CEBChS/zjuBHclYCSfvLMDucO5pcNhCD8qmd0jI0bCQPQO8w7cpbu3PwOQZNbqxzwvsnpzDgIfWseFSVfoLzSmdOuXNQxjZCfuP2VGP6lxzuRAqCs0KQZ+zcZtp8bR8eJ6Va9D2/d5Q8un0Sq1DyyqdkdnxR8BZfuUh8RT9Z13klse3Sal4a9snwa6sgf2MS3VwSv69msfj6f4SJx3+YXuZCwFafDsQZeyR6K1JLclPiuuCNJ9peiaq8WpkBan1IttqgQCVRDZrtoPborWO9s+P2Tz52jHaDESR1cVSMaRqXBJ3nHCsqOh8GHfrAsJFr8R59ghu8kmpAEEsc7yC3yd3RxI29p7YzeO5Edwo2oOIk6v3AP9xXMFzzCBvPr0u3/1wwHwQU5AAcRNXpJB5dHz8PhZyEF001AlYDLqQbNCykWxlr6XCv+8puOgeHXyneHA5Qan2gYOXQsPi/qw5j5xgFIgjgIzh3HO4fLSrSZLphTDCc8eywm272NqyC75j7JwGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWloWWhHZ0UvVmxXWnEyRUk3SEIwQ0NNTFlGK3BUNWl2RC94eWhZcUwzdEdw?=
 =?utf-8?B?WXZzOUFzcC9XazRSSkgyd2NGd3NkT04ycTA5Y0J0dURWVExYdy85aTdWT1Bx?=
 =?utf-8?B?cUFTL2VqT1l4ZHdGRG1HRFdmdXMxL1RUaTR5UkVNVWNUcnl2ZmI1U2Fkekcx?=
 =?utf-8?B?Yi9uRWJxMExQbVpuREpuY09oVFUzNEZEZ3RSL0dSR3ZMbEF5clc5VVJPZWly?=
 =?utf-8?B?eU92MWk0ekFyZ2lReWVjejJLS2JOdXY0TXNUUkxtL1FYQU1MbWg5d1lJQ3NP?=
 =?utf-8?B?eUIzSGQ3akFUaHZ5UzhXTWpsMjRZOFJzS3ByTVI4WG9TVTRDQkJ4Q3FxSlVW?=
 =?utf-8?B?enEvZUpndVNuc0F0ekVrcHRmMDJvdGE3bHVTMjJ1aUxDT3QrVXlzY0F1SENP?=
 =?utf-8?B?TzduSmcyR1Y1c0dpc2FrcDJTaHNLR2FqYWZjYU9MK2ZQN1pFZHNxdEdkd2Rz?=
 =?utf-8?B?RTd3SUd6bVNZTG5Kd3Vuajh4QnRCckRIeFhpdENsMXlpaUdsb01hZnVQK0lh?=
 =?utf-8?B?QWhFTW1kWHh2VDJiODJRTk1ORjZQbkhUeU9Id3hoV25LWGh6SkVuU01HNUtO?=
 =?utf-8?B?ZlFtOUN3MDRabHBLQXFBWi81SHIxRlRMQlpxZzhxWnhXWUFXREgzV2xEUHdD?=
 =?utf-8?B?UnBmT0xrVis2UThDemRHalNNempRWWhjdGlqWWpUcldaTGVoL244UlN2RTRU?=
 =?utf-8?B?d1ZnVWJ5VitoNFpUbmNYK0VsYmVINGpINksraEg2TnNiQ0RKdlhaZXNqL2Jx?=
 =?utf-8?B?Tzd4VkdWQmw2S1dXNTdmenFSZmhBeWdzcnREM2FhWVdiWWNTbUlmcmxNOFly?=
 =?utf-8?B?d1hrYkFFRWhqRTBkc3poZ1FjVmt6M1FudkRsMG9vRVA5dk9lMVVPZTRxVC9n?=
 =?utf-8?B?WUxibytUWXFwcWRvTk9INzg5WkJVTlNJS3Zzc2RuKzBCZytDMG1RT3d2cUdC?=
 =?utf-8?B?Mk9ZREFrejhIV1hNakJGMCtsWTJzM2dWRml0TEpZZFZmRVBGWWpzbktRUnF3?=
 =?utf-8?B?MmFQNHRYNUhsbTJ0L3ZtSWtieVluYVBveUZ3QUtHckMzQmVmSXdhaFd5QVhW?=
 =?utf-8?B?cDUrbWdEdDBSLzZITWhYeE1vaEFSb2QyWVgyOUVMbjlUOWFEU2dHb0QxeUlH?=
 =?utf-8?B?Ry9sb1lOVXN6b0RQT0tjZTd4OEsvVEJxVkpDZkVCaUhJbUUxcldlLzhZdWdu?=
 =?utf-8?B?QnFQWS9Td25lTjVZeUNwRG1RT215NWVUSitXZ0xCUEFoZnpQRTI3V0tXdkd3?=
 =?utf-8?B?bG9hRVQ3TEhjR25tc2NYN0VGbVhjdDRuTFVDYlJBOUVta1FRS1pFWDlBR0Rw?=
 =?utf-8?B?N2NFcFBOdnNuUjhIREJaWW5sK0VVTG5CYVdTUDdTY2ZkcloxcGZHYk9HZUhC?=
 =?utf-8?B?S2tKcW5yKzBZeTJ0eVBxdXgzSG45VkVLcUU5SkZQM21YUWJQM3RQRmdJSU1U?=
 =?utf-8?B?QmQzRFd6RWJZM2tVNWpXTjgyRmJrSU9EMnhzZVl0VmViK2xGYTdOSzJjTmdZ?=
 =?utf-8?B?RzlnOGdEbEpJNnFDUGJLMldlWWdPU3dDZVZWRXdEUnZhRjV5dVErcER2dk5E?=
 =?utf-8?B?anpYZFlMamxsREhWMXpOMDlVekdpbUI5aEYyb2Qvb1pCODJWYmIrN0pvTDhx?=
 =?utf-8?B?V29TbzZHV3dLUkVEejNCZ3h6eDBWYmkrR1I5c2xpUzJGdkhnZjNPUUVQMWVX?=
 =?utf-8?B?KzdPY3NHWDRqUDVkT0NXUVhKcXpJVmh6eWxYdFdENEE1eXczcVRuMXpHY2Rt?=
 =?utf-8?B?eUxmNURPUWlocnBtVWwzZUhGdnErdFBUUjNzNG1PNXZ5SWpvSjVRbEpLYWFT?=
 =?utf-8?B?WGx5V3c2UGxzaGxDVnV4bzVLM0I0bmtuaUtuRGlwQ3lyRU1Fei9EZ3drV2hX?=
 =?utf-8?B?bUc0N1BvTlEyQTYzRHZrNWJrOUNEYXlzVndTWFhPS1p1bWUyb0ZOV0hPS29L?=
 =?utf-8?B?dDlZcTF0VkpKTjFmY3pOeStTbkFhdEhubVNOZDlJZ3A2VkVYQ1ZlaE05cWhJ?=
 =?utf-8?B?aW5JUjgzaWJDckc4ZVJNZzJobjVXUFNSUTNhR0FUdDNYWjhoQXNyU2g1bGw5?=
 =?utf-8?B?VkJmYjlnVllVV1MyVzNtd3dlTDZNYmRWRTBVY3E3czFyUklIVUF0djF3Z0Mw?=
 =?utf-8?B?MmIzVE1iZUFhRDhZTmE2bW5KNUlRbGIxRllPWUF2THNMSjgzazRtb1N6NFVz?=
 =?utf-8?Q?/wg6JGBFIVvlqgtoh1Boqu0=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a05a33e-4913-42c2-8e80-08dc5319e5b8
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:36:27.5875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JYKnDhAMz5epnsp2Rf0NQplWoq3tCGRz7SbONqh8xD7PI6N4kpI7xVpG0dH11rkRFaq3DWOTv6kSKjUcWpeFMUpKoUe7b/n9XjaaRImpJdE5qzRC34dgMGTfatY9aftg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7324
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

On 4/2/24 14:54, Jonas Karlman wrote:
> Hi Quentin,
> 
> On 2024-04-02 13:11, Quentin Schulz wrote:
>> Hi Jonas,
>>
>> On 3/29/24 20:01, Jonas Karlman wrote:
>>> Imply support for GbE PHY status parsing and configuration when support
>>> for onboard ethernet is enabled.
>>>
>>> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
>>> ---
>>>    arch/arm/mach-rockchip/Kconfig | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>> diff --git a/arch/arm/mach-rockchip/Kconfig b/arch/arm/mach-rockchip/Kconfig
>>> index d518913f8a37..d85b59a92da2 100644
>>> --- a/arch/arm/mach-rockchip/Kconfig
>>> +++ b/arch/arm/mach-rockchip/Kconfig
>>> @@ -316,6 +316,7 @@ config ROCKCHIP_RK3568
>>>    	imply MISC_INIT_R
>>>    	imply MMC_HS200_SUPPORT if MMC_SDHCI_ROCKCHIP
>>>    	imply OF_LIBFDT_OVERLAY
>>> +	imply PHY_GIGE if DWC_ETH_QOS_ROCKCHIP
>>
>> Is this really something we expect most devices to use?
>>
>> We have two products based on RK3588, none use it. If I'm not mistaken,
>> Rock5B doesn't as well as Orange Pi 5 Plus, RK3588 EVB, Rock5A, (likely
>> not the Edgeble as well since they have 2.5Gbps connectors), NanoPC T6,
>> IndieDroid Nova, Cool Pi 4B, Cool Pi CM5 EVB, NanoPi R6S, Rockchip
>> Toybrick TB-RK3588X.
>>
>> So, I'm not sure it's worth it making it the default? (Even though we
>> could remove it from the defconfig manually). Wouldn't this make more
>> sense in your generic defconfigs?
> 
> The PHY_GIGE option is only used to control if miiphy_speed() and
> miiphy_duplex() should use MII_STAT1000 reg to determine speed/duplex.
> 
> This patch only imply this option if a board use on-board gmac and have
> DWC_ETH_QOS_ROCKCHIP enabled.
> 
> Mostly this only help the "mii info" command to show 1000baseT instead
> of max 100baseT.
> 
> I can drop this if you think it will cause an issue for any board?
> 

No no, this is fine thanks for the correction. I don't know what 
happened for my brain to read this as "enable support for integrated PHY 
by default" (c.f. the list of boards I listed not having integrated PHYs).

Sorry for the noise,

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

Thanks,
Quentin
