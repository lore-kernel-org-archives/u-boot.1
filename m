Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4663BCD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 11:21:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83C70880FC;
	Tue,  2 Apr 2024 13:21:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="CtQybXbd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E064E880FE; Tue,  2 Apr 2024 13:21:05 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20701.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::701])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFF02880FB
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 13:21:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPNnEtldGfr+sZuhnrIM2XHXrPiAbkUVpz21gy2dmNTsKmmxI9fCklT3ilmVuT7cze9HZkr3H/RuD1ysmVe0KH6UQc9tz3Is7mlr/aiiYKT414aQGsKhRuc3UWtb7t2Jl85Y37JuSel8zBLKSA6HCVWyYz6pBzc6C7ElzPYr4o8mbGAXo3M2CMu/eGvZtORgpsL+gTKLETUEOyNuk/DoU8M4HuSU3lO92X8luqDEvBXzqJs+BNBzx709zikW0RIVd7R9Va0qhx+4dS31K4hzq2g5G58WwJTQgB/bOd5TgkvnUJU/NTqFXw9PT/qy+6VkaM/rCunBQ71qYOoUdvzLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7HvUQUTr294+SaBDNesA0I+bW20CkLjffcDgwd9bwgU=;
 b=Olpxm5SeF67XE8wFyw35leEGUqZrVsUuA10WWwGOByXXxQuSnWL5D1aKiWDLi/UW7R/ysiWDc38JtBMTxDj++YOKzNe9AaXBdBlVHfLFYwdXtg50ypAVi/40g49A12ghp29SqNMLhnnogwRfVPmLeigcSkjcZfKT6oDIqQUK7vobd65AVlBUBh8jlIPN3HDwPIAg4/xMpqcdVMOqvlp/bRXwcUZ+6hJIjXSaELHelKYfu58FdPvMsg09PRcx9Ax2VVp4++dME3mGdB9itgBZjeKFE11/lSeLZM79n3Eqqw46NuqruzbEoasXcQXBAHcL8JvM8J3/R14sACNDMmtQRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7HvUQUTr294+SaBDNesA0I+bW20CkLjffcDgwd9bwgU=;
 b=CtQybXbdD6F0RaVxUQi2SY3avrIwjQc6BeMfr7zl/HNw7pRFRQh1HVeB8q8CnSkHn3/mjsFjm00M07fcOV2WqRnwMZFyzfDtEPsAl3oJ33U8Jf6plN38XHZyRQK6oCXN7ITSIGgyG81SzzJGK4GvSi7upd9ko7cz+gFgC0mqiVudnpFwKgZVGGw2OFndukYXQeiabjlknlKo5XhFffaYU+pvpDTHqKECGv0fKhi9DqBf8FHiGfISGJeCqQgEkFDDVK9D8TNWTZ/0opHEt05eHHp2h4q49sUXx4uG1++gWz0pHzBlwmnA94u0GKQqgYN1IQ7XBr9dxn4PsPhw9TqaWQ==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by VI1PR04MB6864.eurprd04.prod.outlook.com (2603:10a6:803:138::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:21:00 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 11:21:00 +0000
Message-ID: <68bbc86e-f412-4e3d-bc5d-d18027edf63f@theobroma-systems.com>
Date: Tue, 2 Apr 2024 13:20:58 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/19] rockchip: rk3588: Update bootph props
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>, Andy Yan <andyshrk@163.com>,
 John Clark <inindev@gmail.com>, Eugen Hristev <eugen.hristev@collabora.com>,
 Joshua Riek <jjriek@verizon.net>
Cc: u-boot@lists.denx.de
References: <20240329190224.3613471-1-jonas@kwiboo.se>
 <20240329190224.3613471-13-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240329190224.3613471-13-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0008.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::19) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|VI1PR04MB6864:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dcd6N0/4gQD3UaX8g0UJso/8lrY+e0wn7UqVIAle+6Qe3KA8St4aE6+9Q2wQ8zid421DbUw5VP15/WNuUFFoINGsAT5fJLuO4Y9Ieg7M6pJveJNMMAxfEX44SNtFDcYjSN1400uSRjmuteLg4ZSdgouAnFsDvoEandPxhPdVV7HlfOZJ9+oYZPj2rjXgeRJuJurbW4f4hlASqDl3o9HI1RUWdosgqgwg35Ur9AWVo3Bm3X34SxuBziiq/OtwxLfKqnNTBnMKXLTVjsg7BcbbWb7LbqnxVIuOOUdxgrLf2ztBYm0c1OsBvsdKeYfJoOUi061KU+EO9QkDgFFuaxAGgGjFBqhqVpKNFd4/xWsiKTS7zpz3CwwQBFHboKHc84iYLO5ybwv2T4NSP0qkisFiRhCPP8pa3zdhl77m0x9LWVpb/YG4uHc8zbeYtBv6yK9tZQwT4CUrcksuUO0hWJ6esmbmJTlGemCq0XwgSxwe11CUP5QCkNbLd50d8WP/oX1C7vUEV0xNEMpLWCx5COxGZBUOGOEloWhVy/GG9Bk8ojVHjrJrze/t/I/y49qPymCTrFB6Q0TWuRs7yMwIly1kr+yEcVTLnKTW5GUGeKTaA5w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(7416005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1pDVUNIWmQvNEJDN2Rudjc3VWIzNDVST1kwSlhDT1FDNGozSEMwRi9nZ1p6?=
 =?utf-8?B?RUgyWFIySitGdHYvOGV4Qy9jNFlSSnFhdFJ1YkNUcW5hYW96VzBiVWNVTWdH?=
 =?utf-8?B?b1FGMTRmQzFKZjJWNFFQLzFqTndLRStvc29FRnFWVGpnZnNBMGpDa3NTZjV4?=
 =?utf-8?B?WW5laHV4ajBXRkV4SkxVRmQzUVZzRkdqM3R6bkJuUXJneUJLdG5WaGU5UEZN?=
 =?utf-8?B?alhLNWQvREFKc2lsSStmYmtTTmlxQjl4dm5WRjlpZnNqSUlIVkk0Q1VONTNC?=
 =?utf-8?B?ZlArQk1EYVMweFFpRTY3NXl0d3k5ajlseUFrN3lwYS9BWVd5UU5Hek5vZXhT?=
 =?utf-8?B?RUpBM05lQ01xanRHNFd5ell4TzEzTnRWME1vcmh4ei96TGExVFpNSSsxcmlC?=
 =?utf-8?B?YUQ2WEdkOXpUZllqNTdOSC8yQTQ5Y1p2SEdvK1F0Z1pqdW83dGFMbkduOGlV?=
 =?utf-8?B?QzIzLzNjcEd5T0tRRzY3d2FEdklsV0Q2M2hiWVg3TExoemNYbituaFhsZG1R?=
 =?utf-8?B?c3pBeVlmZDJvZ3lNVEN2N0RSY2c3cnRtNEgzcFYvV0ZYTXd3M0hsUXdmY2pm?=
 =?utf-8?B?SnFobit0WVhWNWtwUDZQeWN2V1g0aFlPV3dPa1MyRW9xendiWUdsaTJPQ29v?=
 =?utf-8?B?WjFjZ3lJbFpzbmtPRjFoZkFmT3V0S3cwN3VpYnFNNmdmK2pnMFFBa0ZHcTlh?=
 =?utf-8?B?WEw0ak9nSWRpN1hWT1RKRzdLUHlNWDNDSHUrY1FrczFOUEYwbEhqWWxtdTFN?=
 =?utf-8?B?VFlZNEdEK0QvT3ZhWnhjN1VxK3luZ3pLSE9VNlRUeG9aODFDR3FDSzRwVzlN?=
 =?utf-8?B?dEx4RHo0S0VnL2wxYnNWZDZtdEJZeW5oT0I1TkcxRzZPY2J0d2JSaTQ4Q2VJ?=
 =?utf-8?B?b3ozYUF4WkcxVWlWV0pJemg5N3ZFMlRGNmtBaXQwWWpHdWFIbm9mRFJrR0Ny?=
 =?utf-8?B?QTQ2S2dhOEpkQXF0M1B1NTJ1blVWM3Q3WDBVOTdXY2ovK3Q0YWV3Rm45VzFK?=
 =?utf-8?B?ZStoMHZCcUxBN1hwRkZVUFRHYjRaVllpZjQzVnNrV3lpeTFpVTVwRk9hYUY1?=
 =?utf-8?B?RDRnTWE5Wkl6dnVDYXIxdmpDSnZwZ0ovQlJVQ2YxeWlCSkJQV09lN3VTTExu?=
 =?utf-8?B?QWFrTENnOUEreUJRb2ZkbklZUWJzd1RHaE9PKzNtWGVkditkR2NscVVSb0tu?=
 =?utf-8?B?UHVjZXRhRWVkcVRmMWRtdVdKZy9LRXBnUVVHN0RPR1ZiR0diWHRVYjJyUWh3?=
 =?utf-8?B?UGtucjRWWlJ1V0RaMjBBTnR3cjBDMTNSTTd3bkhLZ1ZKaFVlMDNyb3o1aFNG?=
 =?utf-8?B?SXhPRC9BWiswemgzUUFlQjlDZWkvenR5WGRkTnBGa0JuNWxjcnFsOHVHaUVP?=
 =?utf-8?B?eTNVUlFBdFFxL0YwMHlidzhiOEc5dHplRTFHUXh3YXpxTXduaFNaU21QMTU2?=
 =?utf-8?B?M0pBMURKUjBtNHp6YkxQRnJRQVhZTUhWRC9lZkxxdlVQZ01LQkM0M2tiYWFH?=
 =?utf-8?B?RTdrSGN4Q0xxQWFpWm40c2tyWUUwQm5HRUtPNDcrSW9KdnJVOFFkaGtrSHRR?=
 =?utf-8?B?SXhvYzdoUHB2empiY1p3MkNWRWRrYldOdmZXQW9NWHJxU0lmT1JUd09YVFIx?=
 =?utf-8?B?ZmhPMS84Wm1iV2M5RnlQc3l4R0FKbGV3RE5IMzB6a2s0Uk9ONlJTTGgzelht?=
 =?utf-8?B?NUkrLzZVUFN2MG1BRHFMQ2o0Y3p0b29rTEc3R1lqTG5oK2NJek12VkFJeFFF?=
 =?utf-8?B?ZFF2ck1WaE5Qa1R4K3VNcGYwcTR1cjBVVFp2MWtjbTVNN0lWd29HbGdEaHpE?=
 =?utf-8?B?WXJGdStkaHFOWjlyellJUCtINzdlTWJGV21FZVhjUGlEMkhGNmNWRUJvTE9V?=
 =?utf-8?B?S0ttZXpEaXZpRzRObW44SVFNM1ZJVHRvSHkzVTFaMDFsZ1pxaDFadFFROExT?=
 =?utf-8?B?c1R1dE8xTGxYcEdqNTBhS1dQZGJ5bTl5b29EOEJZVzBwM3Nvc29ZREx4bGhV?=
 =?utf-8?B?ZzNTbHd4STExYzREeTlkMjlBam54SzRnSVpZRFJ5QTV2QVVub0dnTUVoWXdU?=
 =?utf-8?B?bUF4WmtqMWF5VmwrVHZVQ0dUVG9FcDFjenFvNkZCcVd4RUN4YmpWWlR4SFdq?=
 =?utf-8?B?RFhhNkI0U0xKK1Y4VGtjYyt5eDg4MVBCbXpBU0s4N05oUDJ5OFFpMzFVZUlw?=
 =?utf-8?Q?rB32sm/yxWray0dfbJqvLuY=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb43236a-99f1-4641-25f0-08dc5306f9b7
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:21:00.5864 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CpDDczRXSK34QhJ1LocBielve+HoERKsNi8IuiFE+JsyQsL5Tc52Vf2LXVubA6bpt5IHzEZHBjiYn7Fgb/RR5RDeDcmkGALkpNwLnJG39K2fxwAqKGZ/16Jwz+RKZeW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6864
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

On 3/29/24 20:01, Jonas Karlman wrote:

[...]

> diff --git a/arch/arm/dts/rk3588s-u-boot.dtsi b/arch/arm/dts/rk3588s-u-boot.dtsi
> index e4171bd24d2a..a502a82fae6a 100644
> --- a/arch/arm/dts/rk3588s-u-boot.dtsi
> +++ b/arch/arm/dts/rk3588s-u-boot.dtsi
> @@ -121,31 +121,35 @@
>   };
>   
>   &cru {
> -	bootph-pre-ram;
> +	bootph-all;
>   };
>   
>   &emmc_bus8 {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &emmc_clk {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &emmc_cmd {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &emmc_data_strobe {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &emmc_rstnout {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &ioc {
> -	bootph-pre-ram;
> +	bootph-all;
> +};
> +
> +&pcfg_pull_down {
> +	bootph-all;
>   };
>   
>   &pcfg_pull_none {
> @@ -157,6 +161,10 @@
>   };
>   
>   &pcfg_pull_up_drv_level_2 {
> +	bootph-pre-ram;
> +};
> +
> +&php_grf {
>   	bootph-all;
>   };
>   
> @@ -189,19 +197,23 @@
>   };
>   
>   &sdmmc_bus4 {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &sdmmc_clk {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &sdmmc_cmd {
> -	bootph-all;
> +	bootph-pre-ram;
>   };
>   
>   &sdmmc_det {
> -	bootph-all;
> +	bootph-pre-ram;
> +};
> +

Please add bootph-some-ram to all nodes related to eMMC/SD card 
otherwise I assume some boards won't work anymore (e.g. the ones that 
need to find MMC devices through DT in arch_env_get_location, e.g. 
Theobroma's Jaguar (and soon Tiger)).

c.f. 
https://source.denx.de/u-boot/u-boot/-/commit/70f9212d61fe79c605b805c6eb0764b29f8ae3b6

It was not easy to have this merged, so I'd prefer to avoid having to go 
through it again to fix my board(s) :)

It'd be nice to split this into multiple commits so we can have some 
individual justification of why such a change is made, so that we know 
if we need to revert/update it in the future.

Cheers,
Quentin
