Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 947E9CD1284
	for <u-boot@archiver.kernel.org>; Tue,  2 Apr 2024 13:10:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1B43E87D70;
	Tue,  2 Apr 2024 15:10:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="PQ9CjNZw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 003B287F07; Tue,  2 Apr 2024 15:10:54 +0200 (CEST)
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur01on0719.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe02::719])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A65C2879BB
 for <u-boot@lists.denx.de>; Tue,  2 Apr 2024 15:10:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hzh3UuH/oEEhJSjSe4Bba9QleLHfh5DM2iMlB1Y1tUWgTWzP0mccBwc4FNOuoSyVCJ1OhblLypNtdOCbSpi9X4WgMCvCkaSlU6vVLhzPzFPg3llAF6XjdBWNlqfoDP3mwKLrVEjenP9GrH0i9hTTrugAnaQkuua8GhI13gn+tPv/ki+RSpcmVzzxwKx+qRkUIOsBNza8C7Tq5P7mi3d386okmXWW4naNivJhkmXqFu7M9F2fNR5/MnDECut3vgJnT19lx1B0Xvsea9aHTvYCeWIE55/tvt14ry/l3azIYvlltkre7vmSIuP6xyH2wy6SH21fK0B8fMrsz4VRfOkJ0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWHwkLptDT+3gdsUi7zGDWaay5dU54w7JYBPjgeCAcE=;
 b=SB9BaimjX5Htws8kWU9VYd4rrVwUIc0FGbgae3z65/7R1G2kmHRSd3TmvXIHJDAb4yJwMlv/TDustorZZBCwqP87rOs1y8vJxjGb7DB0U4PRv8Gm94gBs7avoNKWNsaCHjQNahzMw5SVfpbvWXmQ3M1oL+kR1ZyKaXlen5gFzhRIQoQP2pHQX6uKmG3Q8RBPJ8NoY4XukAz/VhGrel7F2WTywV4aLKHxFVhNuVN8V3ieKcb24JuqooR4mZi5pMlfapxUciJfd5fSiMyOvK0S8XyYPr1rF65IeEcyQFSvFfqqsqvzgDqxkzy8HW7KpHQnfWN8uYBWIU8sUuQGKSAQig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWHwkLptDT+3gdsUi7zGDWaay5dU54w7JYBPjgeCAcE=;
 b=PQ9CjNZwini9mN3KNyLKjMUHQ5fztvzmFVgf19/tfXRbXsoJBY5XhTPqwxUxxlYRq8F5yrmgI3Tqgv/kOGwbLpQMesl+DMjSSnkJ0U4l+aXzQXVDoMmcFrvFE29oFp3zGghehpmKDliRAggwFUxa6uzs4GVLf7eulGX1HJRcAbjNscDH8WQhHB5OZiyMR5BIoi9cr0lN+BpnDwwA9JeRbqkInei3w1udyX1Ir7cY0MnI2mKVuqK4G/AKB7PbZy7J6bv7G4bAZObjRX/+GcD8AmfIaxeA++VOoCaGm2QJASeLFVds+rGeTU/R6+04iXcDcl+ME9YsmXUfc2VFwebAZw==
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DB9PR04MB9449.eurprd04.prod.outlook.com (2603:10a6:10:36a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 13:10:50 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::3e70:7029:faf2:7779%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 13:10:49 +0000
Message-ID: <2d1ee75c-898e-433a-ba60-37aa532736d6@theobroma-systems.com>
Date: Tue, 2 Apr 2024 15:10:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/31] rockchip: rk3399-ficus: Enable TPL and use common
 bss and stack addr
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: u-boot@lists.denx.de
References: <20240331202921.262323-1-jonas@kwiboo.se>
 <20240331202921.262323-3-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240331202921.262323-3-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DB9PR04MB9449:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pXmKeNOBMZgZ8EmU0tP0eNlkyDhXG1/8G/wuDfI6DrHCi4Rvj4G3qspmYOjBLUc4wW8ekum16buOra0UfA/3rvPuKrNUu0flQF/R6YKINvxqMBnvbE0dhJ33M5FyXlEkkA8AJy0eZ8FrMCbSASgxBdbvusseQ3XN8c+3dFP0Om8Jmm1BegyRq7xCcHkx30Tat6L97EUFnSw49EjHG3FdRDxnHkSYh4a97EMWo1XbiKlreT8TJ0s76S9dTunK+Lb5a2Jz9NfSZp9LGCkff4yIi7d26oiKeC9w4c4CArFKc/X8H72FGRbDdQ/TYBzYAQFHGSqbSMlmxtuPZZNCVsC5FHDQSV+AeMGrP7eMHpS4psLoKQc1I8L3ZMJnCP6pNaQ/8vjd/iydwWz+sUGhye1M4Mgnnos0rhpyTG5v6KLOn5cTSCLGHdFSHIjXGCO/w5ZrkJzUG7RgSp+doWSa6Yu6PTDM3GyNOSR6bcUpSh42+0p8JAzIndng4vCRhE1QLcIO6DGjOY6mOLPIR3Qn175dTRxb8Qake36P5DwTDppks/700RNCbccfrdN+8AfZzYf0dGNeXv7EpSoPJX5p02oecVLwvWqmUOGC8+dmI+8A28w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(366007)(1800799015); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2Y3YWt4U0xDdFI1TUljeTRNMis3N0c0VkhTbGF2UDNUckdmNEFYSm9zblJW?=
 =?utf-8?B?M0NHaVMvdUpQUlhjVm9VVWgvSGFnYnFmbS9kQUt6UFpOUkQrc2JYWHhnQU81?=
 =?utf-8?B?TUswdnhrekhuUDViZW04QXlzN2ZxY0F3RVBvdUlmazgyVkp0NzZKbXowVGFa?=
 =?utf-8?B?MWFMTC9Jemd3UUdwRW94NlFwbmU2alJ4RExhaXM1WmdiS0pXMi9zT216enZh?=
 =?utf-8?B?cmZ3TVhGMmkyRlcrL2xpL3VKRzA5amNObXMzSTFZdHFoTldQMHFqT2ZHRjNP?=
 =?utf-8?B?Q0p1MDNRRnVtVXdhVUxrcXFxdS8ra0RTaVd5YTVMZFZodks0RU1oOWw2OUdz?=
 =?utf-8?B?NkRRdVFSSXpYU1VENzdZZHRGRWhjMjFpM2plZTRveWtXMWR0blQxdm1MTktF?=
 =?utf-8?B?SGtYUzh3a3VlLzVTZThtVFJ1SWE0M3NHRkdFUmRodElkaTgxV1gwYThNOFZ6?=
 =?utf-8?B?RnNWV3pkSjJ3VTJRQWlwVDU1ZmxQQ0txdVdCS2thc1k4SVZXZjRiTE9TSHBO?=
 =?utf-8?B?WlNsaTRPalFOcWhzcS94ZHpXWWJob0liLzhIV1FrcHhqWTduamovdy82bWxv?=
 =?utf-8?B?OGZkZCtMUEt3WlkzQXFKQVRsTmtaVFBrcm5YbkIxd2IreHUwSTg2aDlTdjFY?=
 =?utf-8?B?TjJPcEdKTlM3MzI4VWtkZGdYam9nR1ZWZ0w3bURKejhoR0YwaHVtNThiR2Vi?=
 =?utf-8?B?NDJhbmE4aDVqb1hlQldWdjdtVWZQR09ZQVJ1SWRUam9ocGFick5QS3NsVWVx?=
 =?utf-8?B?N3g0dkM4ZFRDM1lHcnV3SnlVanVuc3VWWGZFMExzMDVXaml6MmNaakFQaFB0?=
 =?utf-8?B?NkRVd3dpQUYyMGp0cVZWK2hpWlllMTdpRllLck8wbTcxekFXeEEwek83YXN1?=
 =?utf-8?B?UXVqSTRYMFkzS3czRTFlVVFWZXpWTnpvY2g3ZGYvelpzRy9CM1FCZGdXVUU1?=
 =?utf-8?B?d1NKQUNzK2FhM3MzVDM2aXoyMVluQ3RnMVhEc0VWZzd6U1p0dXNHZlhyaDFk?=
 =?utf-8?B?L2dPbDlOcndmM0R3bVFOQlZPWlNHekMvaE9rQmtNZTBlK09hR2tPUFIxb29K?=
 =?utf-8?B?TENiSGdEaWE3eVBkZ216ZEM2Vk04MVRpMmVyRFhUWUk3UlBObzJZWWgzUTNX?=
 =?utf-8?B?aXVKZ3FGSHFENVkyS1F4OENFQ2dYSGlCdHh5WFdaTktJSkdRMk5xa085QSty?=
 =?utf-8?B?S1dFckV4ZGtBRU9wM25RUWUxMStkOGlJTWdkdGRucjhtQ2wwZ2MvanRIZG9s?=
 =?utf-8?B?WElsZ0ZpU0NOdzZBdy9lcmlqVjdpZ2hobWxiRFpITjN3V1ZWcVMyVnU3V0tH?=
 =?utf-8?B?czVjbkJaQ2JMdVArUGZpUityTE9oMWRvclArVWZDRmZEdzU3QTZQRmNkOUl1?=
 =?utf-8?B?Nk9VdWU3OExhU3dyemx1WFJvaC9DOUR0VGx2OTVpVjhYQVFUeUtjQ2ZoYWw5?=
 =?utf-8?B?S1ZiWUdjaDV1THJaNWg5OGdsT2dQaUhCOVVzdUtYNW1lOWNoT2tVOHlYQ0wy?=
 =?utf-8?B?VnFaWEJjWmw2VFVyRHZodzFHNDI1OWNlS0tSSSsvVEFWc0MxUEV2TmJPL05m?=
 =?utf-8?B?ZDd6a3RkWGlNYnZVRGJnU3Y4dklKdy9xcUVadEw0OUlocmJ2elA1eVlIM2E3?=
 =?utf-8?B?OGZsR0E1QzQzbUovaEhrUkVJSkh1cU5DWUFIMUFjaFhEUVBuZW00RVJYbXl1?=
 =?utf-8?B?Ky9NS3JncWdPTFdmNWRtbmhZQlZpVFRML1dOL3h1RnBuSnNrcitISXU4N2Yy?=
 =?utf-8?B?cnhNRTdiL3VKdEw5bXlRSXMvMXF1dDN1ditlYWVEMzRteXcydzV4eUMwWnh6?=
 =?utf-8?B?Ny9MdXVVMnlsUlM5aUwxZnRMNHZzNElIRzVqZjlzbTY1a2E3MVQ4UFc1SnBo?=
 =?utf-8?B?dVlTSjhUdzJIT3lHZzZsVHF3SW12ZTczNlV4M0oxRlNJY3F3cGs5ZVpGd0Yw?=
 =?utf-8?B?V05SNndwZmw5VW95NDRhWXRPWWhrNEVwNTJ0RXBBalYya1hRMlk2WmhRdFht?=
 =?utf-8?B?dzY2UnhWYkpGZTByeXltdUx1ZmVmNDQvVWV3ekFBNzdLeUZ6SFpjY3cvSE5P?=
 =?utf-8?B?WkRlR2U1M1lycEtNNUh4eWpHbnhFYlpXcDhiOFV5MUtobGRkTzFKUTNGTERk?=
 =?utf-8?B?LzMvcDQwSUpDR1NCYXhMazdHMkJSSEl4UGVoMWc0ZGdaTi9VTG9wYTFxS1ZC?=
 =?utf-8?Q?SJRbDDjcjRwOqjovYx2qYBs=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1702eb1-6c51-485c-8922-08dc53165103
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 13:10:49.6612 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDZbVwXxFdfsaVMOpSYBCFQ3r58cdSsuSq7+K2KtXO4aN2PqCum8HdOTD5EFQ9bqRtOoblK1I981J7vvbe3neRjK4c12BqMrEPymNozIUlL856XjduWa2KUvLMNaJZWx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9449
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

On 3/31/24 22:28, Jonas Karlman wrote:
> The rk3399-ficus board is only using SPL and not TPL+SPL like all other
> RK3399 boards, chromebook bob/kevin excluded. It does not seem to be any
> technical reason why this board was left using only SPL.
> 
> Switch to use TPL+SPL and use common bss and stack addresses to allow
> for more options to be enabled in a future patch. Also add the missing
> DEFAULT_FDT_FILE option.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   configs/ficus-rk3399_defconfig | 14 ++------------
>   1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/configs/ficus-rk3399_defconfig b/configs/ficus-rk3399_defconfig
> index 4859042d6b56..3bcd0fd66b91 100644
> --- a/configs/ficus-rk3399_defconfig
> +++ b/configs/ficus-rk3399_defconfig
> @@ -2,32 +2,22 @@ CONFIG_ARM=y
>   CONFIG_SKIP_LOWLEVEL_INIT=y
>   CONFIG_COUNTER_FREQUENCY=24000000
>   CONFIG_ARCH_ROCKCHIP=y
> -CONFIG_TEXT_BASE=0x00200000
> -CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
> -CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_SPEED=20000000
>   CONFIG_ENV_OFFSET=0x3F8000
>   CONFIG_DEFAULT_DEVICE_TREE="rk3399-ficus"
> -CONFIG_SPL_TEXT_BASE=0xff8c2000
>   CONFIG_ROCKCHIP_RK3399=y
> -CONFIG_ROCKCHIP_SPL_RESERVE_IRAM=0x4000
>   CONFIG_TARGET_ROCK960_RK3399=y
> -CONFIG_SPL_STACK=0xff8effff
>   CONFIG_DEBUG_UART_BASE=0xFF1A0000
>   CONFIG_DEBUG_UART_CLOCK=24000000
>   CONFIG_SYS_LOAD_ADDR=0x800800
>   CONFIG_DEBUG_UART=y
> +CONFIG_DEFAULT_FDT_FILE="rockchip/rk3399-ficus.dtb"
>   CONFIG_DISPLAY_BOARDINFO_LATE=y
>   CONFIG_SPL_MAX_SIZE=0x2e000
>   CONFIG_SPL_PAD_TO=0x7f8000
> -CONFIG_SPL_HAS_BSS_LINKER_SECTION=y
> -CONFIG_SPL_BSS_START_ADDR=0xff8e0000
> -CONFIG_SPL_BSS_MAX_SIZE=0x10000
>   # CONFIG_SPL_RAW_IMAGE_SUPPORT is not set
> -# CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
> -CONFIG_SPL_STACK_R=y
> -CONFIG_SPL_STACK_R_MALLOC_SIMPLE_LEN=0x4000
>   CONFIG_SPL_ATF_NO_PLATFORM_PARAM=y
> +CONFIG_TPL=y
>   CONFIG_CMD_BOOTZ=y
>   CONFIG_CMD_GPT=y
>   CONFIG_CMD_MMC=y

I think we want to move CONFIG_SPL_STACK to match other RK3399 devices 
as well?

Indeed, it is currently set to 0xff8effff which matches the default 
value for when TPL was NOT enabled. 0x400000 is used for devices with 
TPL support. c.f. 
https://source.denx.de/u-boot/u-boot/-/commit/f113d7d3034672de7d074506a05a7055f1f0dcae

Cheers,
Quentin
