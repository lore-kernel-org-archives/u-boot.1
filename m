Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6104F8FA9A
	for <u-boot@archiver.kernel.org>; Tue, 21 Apr 2026 16:37:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1C4D083A91;
	Tue, 21 Apr 2026 18:37:55 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="AfYaL444";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5405283BC8; Tue, 21 Apr 2026 18:37:54 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 16C3D805D7
 for <u-boot@lists.denx.de>; Tue, 21 Apr 2026 18:37:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mmXj+wdZrmvb73vaWL65wOIbWbE/Ou++InMzpENnE4BtuboTv5S3n/5FzJ7pCmnGaNdAz1IAxnRw3ENsRJqaMQnmgOUaza7Nngsg1dlXII/IsOLJziV+lxDxqzDlSJ2sP46mGhCl4q7xTzoMbaq15epujSaszGSSdEsF7T8b44ShtN34WrpEzW2QrFpLMv+g7g9jGBJXjQC01sRSzmiWMrPASIdAQTKiWvAI3W3rKwBygOCidbiwey13TNPRSHbyQ/sotcw8v4Uk6q8y8jkk5EmAOu+SmOXF5EtRghMZBTyNQ1aH/HM03zpPexOnKhY00ECFiO+y3sYuCBbhXSrcjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VjvkblvHAkmlQNP0hUUUxVb6DZuuamxkaO9Q591Tp/g=;
 b=UwC29Dwzy9KyjMhOCmBi08IWiV9ISuQowFOAReL/dQHY7EKva2tWYtx6rK3k6g2d5cDCpAop5KvOaH1bfMqHDtmnz82ec+WL87vCQC5WhWqZScCFQaVyyTga+UZ3iol6VlIYGQByLB34R2LwgMj5ZOe5i3eT2N1cVJJbbwT8cDhH+YdUXu2egft3rzgHnOcQVNocEwFC7N08Mzqp3pgw6pBWC+rqX3ClnSv3XbkjkO1DL+2lxW0I/TzDHHXz/g3ApbL+8tpJld0jstBQyAVa2+E/5iF3XuSFpyS/SeHggEr+gfj11D5BBW3ByqaGvJBex+Jm6bLN6sC8CDc9pXvAcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VjvkblvHAkmlQNP0hUUUxVb6DZuuamxkaO9Q591Tp/g=;
 b=AfYaL444wIcb+zWMzlIZFv9zeD6t8Vw3h3ib5TZ7JI63aseyMALmH8H8H+TAdSd2y/dVimZrkH0Bdsy0LqFuVTf01wn/X4NFLzv0nznh4P4exw8RmvV1ZnibtmcJbTNPSjfH2qKW8oVLxtJVbaLIq2DcVNaui5S9B7mMZoXYDds=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com (2603:10a6:102:b8::20)
 by DBAPR04MB7272.eurprd04.prod.outlook.com (2603:10a6:10:1ad::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 16:37:49 +0000
Received: from PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7]) by PA4PR04MB7743.eurprd04.prod.outlook.com
 ([fe80::9a4e:252f:2fd:97b7%6]) with mapi id 15.20.9846.016; Tue, 21 Apr 2026
 16:37:49 +0000
Message-ID: <83f03231-f05b-48cd-bf94-eb73398c55a0@cherry.de>
Date: Tue, 21 Apr 2026 18:37:45 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: renesas: Add Cortex-M33 build option to R-Car Gen5
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Anshul Dalal <anshuld@ti.com>, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Udit Kumar <u-kumar1@ti.com>
References: <20260329232419.352743-1-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260329232419.352743-1-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P190CA0004.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:2b::17) To PA4PR04MB7743.eurprd04.prod.outlook.com
 (2603:10a6:102:b8::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7743:EE_|DBAPR04MB7272:EE_
X-MS-Office365-Filtering-Correlation-Id: c5366f3a-4496-4d67-d23e-08de9fc452c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|10070799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: sqDEbczBArT3OJkiTqdgCUHi/2X2i6dbz/bMGbL9YvMws34IY9BpsrvuLb4GwauaGhZW7Y+c5KN+wlX3H/hPhypPucFmIDUAUXFHQhBDKxg0EOBLlcYDrIMRe0GyEj7O62RPW89h+nyBDOcz1PzgIVQzAuVA/a8GRoFznaPyaM7H48MutJ3MXasZ13CygkcqUEwIFP6mOQOnmxfqhHVtsVEHlNAuxcTyQOwHnQKF2pxOROKbNx8TRRO10mtojh56imlG241V+O7aoHbrG5YR6KL+dwBtR6kW4kqgjZWhYS63bTqnwlSeLmn6uDP46wpKjQL9tWIOjEj4g/2sRio+LP2iEcXC6Pn1er1YZ2eVpZbychjTxdcfGPowbH8hPYI3lEwUui7RXJYBQgW8sAvGN6/I0zEnGjNZ/tbhXn0/hwuuiiLZsMShrG96VXv/5wke1x8fxr/M6MwIRAz6RTPqLzZRE9ouspw2Pez/Nx1mBxDO2onRbI+2Xt2u68MYr18qG35C9xteBbzAUFEWLWbsV/txi9s2oTHy5tgq9aClMqQL0HrCgj3lz1nKAi1VSRA352C5gkR4aYizeWTFAlKuHwwWfwvU11ycwpy//TK2ltiqxzPwJP1pCrjOB9IDzY3ZyEWv0KilPkfX7PaWEh5tQ0lr7E6heG5hRRMqIUf2YAHANjQUk2xStbTUTJz3Wq71VrjViPSFpzNlhuMilXryTMNe95CTBXYCrkF71OxQLw8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7743.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUFaajRJR2hyZGpHQ3R1akplQ3V0TXBCbzBtcXBlOGxQcHZudWRhWGVGMHhB?=
 =?utf-8?B?cU1LRkZPVG0xbEUxUnNJUHVSaHRYYUd4bG9wSEhuVEpKNjRaTE9NNFV5RXVo?=
 =?utf-8?B?YU1kQ08xVjlHWEM5V0IwZ0ZiN0R3aWZDK1V5SVB0TmJkZkFTTjNYUmsxOUtE?=
 =?utf-8?B?T3hxTHdvdU9RZEZVaGtmYUN1NElGR2tsWG1pcnNOR05JN20vdDYvVFgwZ0Za?=
 =?utf-8?B?L05QU3BxSzVMd0luRCtmRTYwQkN6S0tYd3ZJd3lGUHVld0ZkNUZOdE1Yc3E2?=
 =?utf-8?B?azFzNU5VVXVOQi81OWszaU1KZGFyeThJTDM3QmcrY3lJRUpCSDBoWFdFNFVG?=
 =?utf-8?B?NFJMNjRyTFRNZTRZTzBKU3VXSTliMm9FVi9VQXJRb2szV2NNMjRVVnJMMU54?=
 =?utf-8?B?eTVBMWd4OUN5TG9rSjBTS0R6MnltTS9jbzN6TkRqdTJvWUdDUnRGTnU2SEox?=
 =?utf-8?B?WUlaYmxTdDFPb1huZXJFaEhCQVZKSjZhYUlGaFJHaXd3Zm5aK1BLOElTTFVq?=
 =?utf-8?B?bkpEVk5LQ2NnYndLeEc0dmJtS29rNXc3R2I3SDhhZjJrR1FzQWNKQlprOHVs?=
 =?utf-8?B?S1d0MngyZERNSCtkWms3a2ZYQ0I3RXE0Ymt0RzZOakh4KzRhSVhzNUJCK3hs?=
 =?utf-8?B?UG8vK2dIUEVzdUdWTmtCb2prcnpyNnkyTHBFYmJzaXpDclVVU1dCWFdwUTRJ?=
 =?utf-8?B?TVdBaTZZaUdaaDhtYzN2cTdjZDMyYnhJQ01Sc1J3VzJJSElrWDllSG5xakov?=
 =?utf-8?B?ek1TV1ZIcnRKK1FJTktBOHZTaXF3VnRLMmpBdzZMOHRDNGNQNk83Snh5anl4?=
 =?utf-8?B?WXlYOGppY1FWc04xRU9KVldYYkdsNzQ2UzBVWmpqMUtva1RpOWJ4MEdzZzRE?=
 =?utf-8?B?VTU4dlJKRnlTbGYvYThJODZhSm95cEl4MG9MRGg0R3dESExXeHFCUCtIYVNi?=
 =?utf-8?B?RkdLaTlkMTQ2NlYvS25ad2M0c2lwRHoyeEdibnB0eUZzN0RTYTh3ZklWbzMy?=
 =?utf-8?B?aXNocUcwV29kZTh0TlhMQTVra0tTSG9RM242UkRGajFicVZZTWtTNS9OYm9w?=
 =?utf-8?B?MGJ3KzZwS0NteEVONFdCL1grYnVJbGs1d1N1QWlTL1F4cjZCdG82TE1vWURV?=
 =?utf-8?B?dnNRZGxMaG90anF3dUVUWkl5RGdETS9UbzBDcVhvWmxjZkZTTG1xbGVTakcv?=
 =?utf-8?B?QlVzWFlxTndsamVzT0RScHN0SmEwaUZrTEMxZjVTa0ZvKzJzYXhIWmJSUUJV?=
 =?utf-8?B?ODI2WnJkQ2NwVHZWQVkrV3Q5bDJ4YktxUVd3djIrcndUc3RsTmdwZXd0OGh4?=
 =?utf-8?B?V2FsYjlYZEhOZmdBcy8xc05hR0NaOG50TSsvU0paMGNYdklob1B0TXF5ZDdo?=
 =?utf-8?B?QkJZNkQvZENKVW4wcFNWc3IybGJNTFZ2V1N5ZVNuQlRyQmRKMElHK0lRb0hF?=
 =?utf-8?B?SENEeXFoRVdraWpMTWg5QSt1cW9QbDRwcUZyS2JhUXNvWVJlWklhZExQd1Jy?=
 =?utf-8?B?MytqVU5GYU04SnhSSEE1bGVMMUVyYnNjMC9xNU0yZk9HTUc2T3U2Qkg3OHlp?=
 =?utf-8?B?TTUzSHErOFlxOGl3ZXBoK1J5Z3hlQ0lvL3Uwd0RHZ3pmU0V0dHJZSXdOeXRa?=
 =?utf-8?B?bFN4QkJlaHNYdnE2Z1Q5NVZvNEZQbkhSWlY0WS8xaUVqNXhWNVp4VDhGWFBU?=
 =?utf-8?B?TDBXR0s1LzhuTU9iNlZsOFpRQWhKZ3g3Q0wyNUxwdXpLK05DYzB1MGEyQTZq?=
 =?utf-8?B?Qzl3UmF5Zm5BNkZ0Z095RkJja3NzeWUxcFJ2aThQWUp1N1hqM2JzVTNGRXhQ?=
 =?utf-8?B?aVNjNTVjTkZBQXM1dGZPUEUxT2tOTVdnMGMyTFVWdDhYUEJSaENtaHJaRFNh?=
 =?utf-8?B?aDVvWnkwTEYzQnJiYndvWlBRcWFMNnFPK3hTZHRSRTF4YklIdGtDekxvdktS?=
 =?utf-8?B?aDUvK20xNUZwd2c3N3NPWFNnT05mKzdBa01peVhzU2hHNGptYStKWk5oN1V0?=
 =?utf-8?B?SGFtT2l5ckxlY3p6OWJvaG1tSnV1MXM5ZzlJZ1hhaEpubldkdHE0R1FGV3Nt?=
 =?utf-8?B?enZQRkhIS3l4VkdvVEJDdXJYRUJuZnIzZ3RQQ3d4Z0tuWGhZeUpLdEN6Vk9P?=
 =?utf-8?B?UXVrQ09JeU96OW12OStMSVlNT2FYSmgwRm1pcjdlUi9JcXBwQXFCWnhEY0Fv?=
 =?utf-8?B?TlQyR1JibWRMSzdzS1hxRExPZnA1YlRDbWRCdWdQeG1hOVdVV1hWc0Uxa1du?=
 =?utf-8?B?dzJDQjljUU1wM2k3T3JCd1gvblVCakVGcjJnMjNxL2JSTTd2SGVqRmhMOW9F?=
 =?utf-8?B?NlU2OEwzS0NvTDduK0pIOUVpblczMzVSem9ZQm9kRnFrRUpEb3gxVkpTS2hL?=
 =?utf-8?Q?bQ0Nwql49024wStNeZlnuVjnb4EJd2xAAWzo3?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c5366f3a-4496-4d67-d23e-08de9fc452c0
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7743.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2026 16:37:49.6168 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PkpM5+FTSI3Im3rwewK5J9KAI5n/6W+c0vyAEsYfxBke1vQaBTdfYJNL0qkGeopAwZpFsp8zC3Apl6I6nvlzA/eAp7pONGLGkWDsYA06n00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7272
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

Hi Marek,

On 3/30/26 1:23 AM, Marek Vasut wrote:
> The R-Car Gen5 SoCs contains Cortex-M33, Cortex-R52 and Cortex-A720AE
> cores. Add U-Boot build options for the Cortex-M33 core.
> 
> Since the Cortex-M33 core is a 32bit core, select V8M and ARM64 for
> RCAR64 accordingly. Select TMU timer on the 32bit core, where it is
> used instead of the ARMv8 timer. Adjust TMU timer base address to match
> the address map of the Cortex-M33 core. Disable unused OF_BOARD_SETUP
> as well as unavailable POSITION_INDEPENDENT configuration options.
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Anshul Dalal <anshuld@ti.com>
> Cc: Hai Pham <hai.pham.ud@renesas.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Jesse Taube <mr.bossman075@gmail.com>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Tien Fong Chee <tien.fong.chee@altera.com>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Udit Kumar <u-kumar1@ti.com>
> Cc: u-boot@lists.denx.de
> ---
>   Kconfig                                             |  2 ++
>   arch/arm/mach-renesas/Kconfig                       | 11 ++++++++---
>   arch/arm/mach-renesas/Kconfig.rcar5                 |  7 +++++++
>   arch/arm/mach-renesas/include/mach/rcar-gen5-base.h |  6 ++++++
>   include/configs/rcar-gen5-common.h                  |  6 ++++++
>   5 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/Kconfig b/Kconfig
> index 0bbdc0cbea6..7033a255675 100644
> --- a/Kconfig
> +++ b/Kconfig
> @@ -476,6 +476,7 @@ config SKIP_RELOCATE
>   
>   config SKIP_RELOCATE_CODE
>   	bool
> +	default y if RCAR_64_CM
>   	help
>   	  Skips relocation of U-Boot code to the end of RAM, but still does
>   	  relocate data to the end of RAM. This is mainly meant to relocate
> @@ -485,6 +486,7 @@ config SKIP_RELOCATE_CODE
>   
>   config SKIP_RELOCATE_CODE_DATA_OFFSET
>   	hex
> +	default 0xa0000000 if RCAR_64_CM
>   	default 0x0
>   	depends on SKIP_RELOCATE_CODE
>   	help

Can't you set those in arch/arm/mach-renesas/Kconfig instead? e.g. in 
arch/arm/mach-rockchip/Kconfig we have a few symbols we provide defaults 
for. I think it would make more sense to have this in the arch-specific 
file and avoid everyone polluting the main declaration of the symbol? 
What do you think?

> diff --git a/arch/arm/mach-renesas/Kconfig b/arch/arm/mach-renesas/Kconfig
> index fa4e312a4dd..3f21755a226 100644
> --- a/arch/arm/mach-renesas/Kconfig
> +++ b/arch/arm/mach-renesas/Kconfig
> @@ -1,15 +1,20 @@
>   if ARCH_RENESAS
>   
> +config TMU_TIMER
> +	bool
> +

def_bool y if RCAR_64_CM

?

>   # Renesas ARM SoCs R-Car Gen3/Gen4 (64bit)
>   config RCAR_64
>   	bool
> -	select ARM64
> +	select CPU_V8M if RCAR_64_CM
> +	select ARM64 if !RCAR_64_CM
> +	select TMU_TIMER if RCAR_64_CM
>   	select CMD_CACHE
> -	select OF_BOARD_SETUP
> +	select OF_BOARD_SETUP if !RCAR_64_CM
>   	select PHY
>   	select PINCONF
>   	select PINCTRL
> -	select POSITION_INDEPENDENT
> +	select POSITION_INDEPENDENT if !RCAR_64_CM
>   	imply CMD_FS_UUID
>   	imply CMD_GPT
>   	imply CMD_MMC_SWRITE if MMC

I don't understand this choice. RCAR_64 is clearly a 64b platform, but 
here for some reason we add support for a 32b platform. Why not follow 
the same implem as for RCAR_32 or RZN1? Add yet another choice for 
RCAR_GEN34_CM for example?

The main issue I have with this is that RCAR_64 doesn't mean a 64b 
machine anymore, and the naming doesn't help with that. I'm pretty sure 
in the future someone's going to make the mistake of doing a simple 
CONFIG_IS_ENABLED(RCAR_64) to check if it's a 64b machine or not.

> diff --git a/arch/arm/mach-renesas/Kconfig.rcar5 b/arch/arm/mach-renesas/Kconfig.rcar5
> index 528fc5aecc9..2e6d119a328 100644
> --- a/arch/arm/mach-renesas/Kconfig.rcar5
> +++ b/arch/arm/mach-renesas/Kconfig.rcar5
> @@ -1,5 +1,12 @@
>   if RCAR_GEN5
>   
> +config RCAR_64_CM
> +	bool "Renesas ARM SoCs R-Car Gen5 (use Cortex-M33)"
> +	default n

default n
is the default, no need to specify.

I'm wondering why CM in the symbol name? *C*ortex-*M*? *C*ompanion 
*M*icrocontroller? Would _M33 help making this clearer maybe?

> +	help
> +	  Build U-Boot for the Cortex-M33 core present on selected SoC.
> +	  The default is n, meaning U-Boot is built for the Cortex-A core.
> +
>   menu "Select Target SoC"
>   
>   config R8A78000
> diff --git a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
> index f9af3ef885a..4cb9a1fbc42 100644
> --- a/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
> +++ b/arch/arm/mach-renesas/include/mach/rcar-gen5-base.h
> @@ -9,7 +9,13 @@
>   /*
>    * R-Car (R8A78000) I/O Addresses
>    */
> +#if defined(CONFIG_RCAR_64_CM)
> +/* Cortex-M33 address */
> +#define TMU_BASE		0xC0680000
> +#else
> +/* Cortex-A720AE address */
>   #define TMU_BASE		0x1C030000
> +#endif
>   

Should that be a symbol instead? Then you can have

default 0xC0680000 if RCAR_64_CM
default 0x1C030000

for example.

Cheers,
Quentin
