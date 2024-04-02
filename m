Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E2F5C6FD1F
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:32:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DF22588130;
	Tue,  2 Apr 2024 13:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Z+iyNRcC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A17348813F; Tue,  2 Apr 2024 13:32:21 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 761BB8812F
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:32:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbuQw5RBXHQL2fX2J6VPx2eohnMNwOtpCoXu5dHHWhSiJUuJUJ8tyG1/0VXWZab4WZFiRrHH/tG5VMwu0zzoRPj6SQTfloleSQIi/N3oPvGYK0NX4DjL+iMXu40k2zu6mxrGnAhJIjnqbwSQo6dO740hmVMI5TRRFlDRiqB2MjHr//P5EeAlWEO0qnRw9hJgwiuoeEku06uhSbaI1km+2ql6Ngz5i2b2PDjk9EmeOKHwXN9ktnnnbtDjEs1adxOfM3+QqMyduOF2SScFjjjEjeJjRwJl+Fg969qrsos2vi/fM7hXCml491d/LeWmT9Ibwkg3yx9UAxDkLde9BDeMOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyqNov2xjy4grUnpOEQtJvzAmiZF7kOj91kKPQE+EZI=;
 b=gPOLo8OffivmTT0E8K5fo1xJXNKAulifzmH9eNoZ+CiOqwf72zLkNB6nvIuVOifTzHsWPYcL5R9lJwddA7mPgSuFbn/rG5s4JldUSrmxDVypVWKT8mbJKU3HBgiKsNrN3Iu5eq6W0i7krbeZfKatHgAikzJSqMahGplaAOHoucRLVojze4iih2FOT+ck6Ew8ryHeMCVm2QujXdVRkvY49gSIrsh/NI4m711dgfQyBgABenVEGHDYNu3Vh7Z+Lho//1k4T24qnfktwGT2bDH3SM1vovm9A+TCQhVjdKgejFn1AA3cKuCO/hzzhthDolSvsZec9Se0OLOpXpHt05DQkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyqNov2xjy4grUnpOEQtJvzAmiZF7kOj91kKPQE+EZI=;
 b=Z+iyNRcChQ8GCjIbmqhkpg7mzkmWTrUFm18t0bPeUpzI5rY8AaXM9fPSTR70x9qLRgSwd5jaseOfwXpUBAFFKq16BqAXKpphNo2YgIA+huw115W/eZNJU/3FoNThYZA6+NaThes9olFTAutjjkVUrEOPdQsWVBD4NnmvIJTkgSy3SABIDc14gHk/jO5+gp/4j2WwiyuPTG9H6yzt1k59ZmUj9r+MPE3soyTYHa0S1W9Ibm3SgC3C7A5RzCjZj9i3J2DWAGawk63UF4NjwI38vzlz/yILMSNbTUeoA9cTeHZKz8o/HUNCIWJBXwAnXds6hSzCVDbxxGyKwizpGV089w==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:32:05 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:32:05 +0000
Message-ID: <f5416379-7240-48f8-b9ed-f39efd11afdc@theobroma-systems.com>
Date: Tue, 2 Apr 2024 13:32:03 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: rockchip: rk3399: Add SCLK_UART4_PMU support
To: xiaofengvskuye <xiaofengvskuye@hotmail.com>, kever.yang@rock-chips.com,
 sjg@chromium.org, philipp.tomsich@vrull.eu, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com
Cc: u-boot@lists.denx.de, jonas@kwiboo.se
References: <PH7P222MB0668C67CD89312A9CED6E64DDD3E2@PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <PH7P222MB0668C67CD89312A9CED6E64DDD3E2@PH7P222MB0668.NAMP222.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0012.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::9) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|PAXPR04MB9642:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HN4qHXUJh9yaJmZ2bJ+ZYiK98AIS3G4yIpIAYmkebJTtYCebblsAGXgBc/a+fgo3qO0ANyYimg2eRqmFm/EFhmDaFkfPw8HBynxKJ3jMdzjUKiwoj8nAZGUWFaABjy6rkXju3DwrYwfXLTNRr3398ilqiyE4ZJnENpYTIEHbUPEDL2czn8SAEqubi2ctkIKcUKX7qIkUJvu4h3R6JjpfpaFnMWSpxUTuosh1uzcM2whwc5lJjxU47w2Px617TXZbE7jHocaUKT+DAw/IO4jiRrthW82ibSVl1kIY3VnHmdm7kQaGUlR4Qi6ZsGUv0c1uyrMtnYTjVv6XOlyABqiePNMQ79xiuEylEmXLbXGXKBPQBX89LfTk3sla7I3wIITNbuUVlxrfIemk9vmNoKQOxDs11Knv97YNbm6vD96zfOcOvZNKgyzWqodUD5SU970rgwGZxQM2PyubSLYuabOV1c6mS2bFuqjzn2HSA2Zn1VWqYkh+ZV5M2mVSCe7xy5qd+k9rgdDtqMUJFX1/4mWO/bwc+U7MgR/Hlz4nFLL5lmBsSP5kJPF7BYYbilQH4iK0+mAF8DuisW4ARFk3/ebt7K4WcFl0MxeQ7N61plPa6YKQl/Q793TlKUmvQueSE9EiL0FRJI9nfwYlVzRCu454pPltVHrdFIf//+ejTlflEtQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366007)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVpnRU5nVTExVmJSTkJKNlk4YklGTG1pOEwrb0tGQ3pYejJaRWFteElkNG9Y?=
 =?utf-8?B?ajZ3WVZzNU5rMEJSdzF0dlVsWFRsejJPZlhaR2ozdytYV1p1MXptNTVWKzZy?=
 =?utf-8?B?cDVBcHE3UXliYmptTmxBT2dwWDZ4V29IMmdMUnF5dmp2TUJEdWx0L1JkUndF?=
 =?utf-8?B?R3FOR2NMa2NMcmtpMjhYNjZKeE1RSi9UMytxQmpNcFNTVVpnYnhZVVNYbUxh?=
 =?utf-8?B?bUl4bFFaNDJ3R1dpTldOeEZmTjFnbWlGajFMUGpEdHY1UDNuQzVJWWRhMko0?=
 =?utf-8?B?US8rK3VFNTR6KzN6Q1pDZHRCd0hzYjlLNFAvQmQyL3cwQmd3aC9aU2s4OWZi?=
 =?utf-8?B?dzZHbUptbzBUcS9NZlpTamlyRjhxV0RZN0VPSTA3WURpUy9md1Y4YU53eG9D?=
 =?utf-8?B?RGYvZ0ZuVDRuMkhIOXlFMEVpbTA2NVlHVmxjMmhjWjZudWRBRFVremkvcVJ0?=
 =?utf-8?B?bVZQTE9EdHJhb2JKajROVHQwcklaZFdNS2QvNnBObEUwL0FTbjZsNlFYMGRh?=
 =?utf-8?B?RnQvMm5FemxkU1RhZEtQczMzam5SZU9EMEFnbmJNMThmaWdrRFNPeDJtWHlX?=
 =?utf-8?B?ckFTUHFDSGlmUGg0UVh6V1hZNmY5YlJqQW80UGp6T3dINk4wd2t3Vlk3N0pR?=
 =?utf-8?B?c0dDNkIrVFJkRTZ2Q2p2aC9mODd6bklkOUNITGZMYTIxMU85amhMNFRUZ05K?=
 =?utf-8?B?WkpOMWd4ZDZEc3VsY1ZORElzdGhjc1hJcEpMd1hheXFxaktBZFdzQktqYjZi?=
 =?utf-8?B?OW0rcWRwYTJ6eklZU3RwTWVXa09PWDNvZmU2MVA2dEV2RnpiSmYrTWhQSHI3?=
 =?utf-8?B?OEc4ZDRoUXVYanlYSTRJRFQxNTI1citSRW4rTHJoUWh3ZWVWTHh6OEx3Mmd6?=
 =?utf-8?B?VVdvTjZlSzBhendCbnplcDJzNHRwSEhmK2dyeXFwYUJSckEvVE53Q0p4TlJH?=
 =?utf-8?B?MjQybEtOVUJBV09UMWgwajIvMlFhWkdlV2tlTFpaMWVnQkxrSWtaR0VET01K?=
 =?utf-8?B?NGs4VEJQL3VMdUNYU2hwU2thTHZHUGdjaGdyTjFVY0lxcXJqbCtBOUc4WHZR?=
 =?utf-8?B?YXcwRTJNM0RtdUI1bXpQSmpTY0V1UXVpT01SU04vbG9aWmZpeXgwVG90YW9s?=
 =?utf-8?B?TytrM3BLWmlHTHdRVStEUEZGZjdIREtjTlNKdHNqcm9IclJNaGh5U1JvSitw?=
 =?utf-8?B?MnY2OCtiNWltVURycStkL3d6WStHdWZBOWIwODd4dzVOd0svSXY4RXhPMzAz?=
 =?utf-8?B?YVNkdUpRWVF0SDNyeEpsZGlmelVXcElxWUdCaWM4clZEOTVhSHhpckhQR0I3?=
 =?utf-8?B?a3lDaGtyTzN3N0dQcEtsakpFdTdxYUNVZG8renBpZlRYeXNiQmtaZW1xd0xI?=
 =?utf-8?B?bWJ5bGF0elc0ZDhuNjJZbi93SlFBbS9WdkxiUWpzaFpJdEljTlpJQUxLbW1m?=
 =?utf-8?B?VlBhR1FRWCtscEJFbXBzWldERnB6ajkrZU9SdldiTWxmRGlNaE1DUFNhSXRI?=
 =?utf-8?B?TmhGQ2c2RDlrelhGTmltMjhCM1VXTkh5YitZZ3VvMG90blhHSzA3Z0oyV1Ri?=
 =?utf-8?B?blFqeHRlM2ZkZExTNDVSN0M2K0JPWFlPcS9FRytzL1JMTHM3S21YTzlmajcy?=
 =?utf-8?B?S3lBNXE1NXhtaUlvbW1oZkV5YTlMUkZMRUMyaUJ6NVVhK2NuV1pVeTNpSHFE?=
 =?utf-8?B?WTBTQ3lMdFpRRzlFaTV4Z0JJSTJIWUNpNElzYUlnNkc0R01jYng1ckJaeEx4?=
 =?utf-8?B?RkZZa3llUjJseUxuRmlPa3pSY3RtSE40eklUZ0xuYUswSXhLakZQVUVRU0FN?=
 =?utf-8?B?UzBoWXVxY0cvOHJaMDNYTG11QXczY1gyWEpnV20yK3BNMVp1MURrZXk0MUxI?=
 =?utf-8?B?SlZYaml4WUEvejJDWVpVVys4WjZzT3NDZ1FpTjgrc1Rrd0QrMmo4VkJla0hm?=
 =?utf-8?B?alN3L1JhcU1VcHJ6OHZvRlVNN29yb1BIeTVkMWtRbjFiUDgyTzVlTTFlcjVo?=
 =?utf-8?B?YmFnNmMzMWxhRGZPNnBNTTA4SE0yRGNSV1RpTytNN2NXd3E2bzlFbE1hekF5?=
 =?utf-8?B?aEZYblBOVCtwVE1wYktiVE1zTHRQYlYvS0krbWV4bkk0LzcyVXhyTXMrSzBF?=
 =?utf-8?B?ejNPYjNMN1NxSEZHekV1VnpmcndheThpaVZhWEZSTXpmY1ZLOEVoS21oa1Jq?=
 =?utf-8?Q?08/jboNCjNs+nCg1cPIcXCU=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2428f57-fe17-4f24-6bf2-08dc53088611
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:32:05.7092 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AQJ/tYDl4CT9CHrwQFyZiWHOfEIYVHbqeCTqFPSHDvagRv+xvqN9f2D5urhJHMLU06rqxNG46Fkw0C+LFsBhB7vaycUredRMa0qsbon1m8SksBApU0HYM+QoSZQM2224
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642
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

Hi,

On 4/2/24 12:01, xiaofengvskuye wrote:
> [You don't often get email from xiaofengvskuye@hotmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The SCLK_UART4_PMU clocks is used as reference clock for UART4 block.
> 
> Add simple support to get rate of SCLK_UART4_PMU clocks to fix
> reference clock period configuration.
> 
> Signed-off-by: xiaofengvskuye <xiaofengvskuye@hotmail.com>
> ---
>   drivers/clk/rockchip/clk_rk3399.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_rk3399.c b/drivers/clk/rockchip/clk_rk3399.c
> index c37e8a53a2..a9114c4b02 100644
> --- a/drivers/clk/rockchip/clk_rk3399.c
> +++ b/drivers/clk/rockchip/clk_rk3399.c
> @@ -1563,6 +1563,8 @@ static ulong rk3399_pmuclk_get_rate(struct clk *clk)
>          case SCLK_I2C8_PMU:
>                  rate = rk3399_i2c_get_pmuclk(priv->pmucru, clk->id);
>                  break;
> +    case SCLK_UART4_PMU:
> +               return 24000000;

Please be mindful about the indentation.

Additionally, UART4 can be at a different rate than 24MHz, it depends on 
the value of uart4_clk_sel (which defaults to 24MHz source clock, indeed).

I would suggest to do this support entirely and handle all three clock 
sources and return the current rate.

Cheers,
Quentin
