Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F39FEC54E67
	for <u-boot@archiver.kernel.org>; Wed, 27 Mar 2024 10:51:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 83B5388035;
	Wed, 27 Mar 2024 11:51:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="N0cA17jI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5CAD9880A3; Wed, 27 Mar 2024 11:51:23 +0100 (CET)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on20700.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::700])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 39D6888060
 for <u-boot@lists.denx.de>; Wed, 27 Mar 2024 11:51:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WkYnVC6w4arlmSAOZhfkTzb8ubdz6V6S7JZYaBS4ZYieP7sAXE8oeXMZu0vcfEN5Eqfa6onvJPLcYRjikwe75HXfsups1utwz/pTKVvUKJhYklrOQp+F8y/rmd0PdUVVC0TlsWHYwC4sciPP/RbH88YwvRN7YJIYIJyUyizbhgaC3VFYUB/r2MU61j4GOWAGuAhuulgrgIUZ/YiFfMo46DJtr2SPvYujozu8AAGsPQ2yf6J+Bxxzew/nJb/lNshUG5HOUB/ZIPDqyVGQhJTqAs5qzN6fQyzGol6fyMXQWRbM1wdXs1G7tszFVu16ETGf8uJuteYR25eqT8fxbx+RVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ey5zhtOVlT/03ME3UNEC8VW7lSkSogoPpv3ZT2O1Ha0=;
 b=FpYbCDSuOs/fSS65j4c7pDP7J7G2gKAPJ+QcEPVeNngbr3m5/WlTS9zyuxQ0smrw+pGgmezzRenmzXp49Uw6ZbeGD5RZMaa5FrOIY35AN8h8T4mEywHX5FNHpDqK2RYYrjqC6/amT0wrnmxt0zEWNZA6XkuHAkBklCYdWvnUjUlGiQ/DO67RTmP8FgU/TivP9865oEeIxuvoozbFPI/9QUz1beJZVZbP3szz35UrqcJ5jf80JSJUzJT+ivXecRDIQJq198+JLi3x5KzHn7M1GdD5lzTmgzTxeDIJG8XA5lcmJQZhrgQZEU+WtSvrTubfI4aZD4WkKNw03daU+iPUFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ey5zhtOVlT/03ME3UNEC8VW7lSkSogoPpv3ZT2O1Ha0=;
 b=N0cA17jI7tahZ8jN3oDFF7IcsCv4Do2RIVQYim+9Y/FWi5s56zzh47P2pSgbI41vbbzovEcerkrnX7jenEJTS0O3TxVZ0FqbQPZcsmdptzr+Nrpd6rsHR9e5Jh705BmDj89jHkgOF4t2OI+UH4wCd//fe3kfhFmGYXX/1KB/OTi/6KPjxfzlQ+ojM6mbDhy5l1DREL9+fc7U46f5oK+YvClX59J5lJ1TEpWWwX4MItOfDXlhue8dwEKVz3xeOp5/YaRVjfU+SdHgE2MFXb9uG8GLsmm6lxNNKpQrmnEMs31pDM7wJRlLHuWIuy7R2YDLGj8JureIeJjJf6ZbAT7X5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM7PR04MB6920.eurprd04.prod.outlook.com (2603:10a6:20b:101::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Wed, 27 Mar
 2024 10:51:19 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 10:51:19 +0000
Message-ID: <a73576d7-5c7c-49d5-bac3-682f669c2197@theobroma-systems.com>
Date: Wed, 27 Mar 2024 11:51:16 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rockchip: rk3588: Add Support for RAM Defines from
 ATAGs
To: Chris Morgan <macroalpha82@gmail.com>, u-boot@lists.denx.de
Cc: xypron.glpk@gmx.de, cym@rock-chips.com, kever.yang@rock-chips.com,
 philipp.tomsich@vrull.eu, sjg@chromium.org, trini@konsulko.com,
 eugen.hristev@collabora.com, jonas@kwiboo.se,
 Chris Morgan <macromorgan@hotmail.com>
References: <20240326204944.1572667-1-macroalpha82@gmail.com>
 <20240326204944.1572667-3-macroalpha82@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240326204944.1572667-3-macroalpha82@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR03CA0028.eurprd03.prod.outlook.com
 (2603:10a6:803:118::17) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM7PR04MB6920:EE_
X-MS-Office365-Filtering-Correlation-Id: c93795fc-a263-4f27-934b-08dc4e4bd556
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l6jbzrveG+noP//C6JSPQ7+ZCGJnMnHebhHpk8uv/5lTiQziY3i90z/9rUpPJEqjLWJati2gPHBxidXuN+tWBvSzn5UjM26m0wHL03O7i6H1d7b9u7A0T6aoGKAcvQmq4zILQgheiC2O9TA/U4wJsYX9TOzL7+o9eCrl+IfNJ0yU5+C6d1uzL/JgC9zzSZkBHGtx5PzLvKJBRZBkVgppbCfhbPHH8yoeKvWcNf/ffUBGWeqWTXrCzcYIbDiRc06FhdTpNrVJQ6vrXJ9Pyjh1Pry0dzkfJv5iQWFw59gNetqZlZOkhF2qlqsM8FJht7r7pZCWLn5U7L3uQV6xTbFfSZ5SfkGRpLfesK3D2US79cnfHibLKqa5GyI3miXD7LTkp2fIYkdRGJT85t/FJspCaY8ttSuX7Od0/BXR98YOolttE8kLZtfSaQsw4U8QBrso2xD/J8pgOLhGdWCsrW7/RPxNc5yA6VENzD1I3VdkWQSdurRxmiCU9kjU6Dk0EDf7hy7l5X/WsWVg+lQAphu8bCxZXxX/mdSQ897oqxDvWrob4JihPHvzAytYkI0coGCHpqqh04pNpPP55eYzd6q2tC+drOftBxVMQY+cuNPawaMzcfLTJNLx5DL2qoZfQO4IJhEzOj8p6KznCcmgy51/hi/lIwF3vV40c7v210+MyMo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(7416005)(376005)(1800799015)(366007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1ExYmhBOHpLK1lyTFNhcFpZbkNQOHFNRDE0R3d4SzdFd0F3R0J5dnRxSkY0?=
 =?utf-8?B?UnNTaktmd3Zvam9PaDNmVS8zR1NScjJPM051SE5Bci84YzhOTEMvd0U4Q0hh?=
 =?utf-8?B?bDJJWTg5c2daWHN0ZmNGNWs5NzhhNFFuZ3JFY29pV2NZSGhpaXErRWxzQ0Zq?=
 =?utf-8?B?UXdPaGZjK2h2bEZSbDMwZHRRY01Da29TWXZlWm14dWVwK2p1R2lsYkZ2M0t4?=
 =?utf-8?B?U1NDT1B3N2JqMFNHTmJYRk9ZQlFjeGNJczg3cEhDNG8xU2xBcG1HaXRCbWYv?=
 =?utf-8?B?Y2hER1BWRS85K2RMbDVuQStXbGhZVi96citZbWNiOWdFN2FqK003b2NmUUxm?=
 =?utf-8?B?YWM5dWJHTzBnOG1IWldkOUFDcklnTFNxNFBta1JtTW9RRWpocjFka3dWUDgy?=
 =?utf-8?B?eUJqZmRlS3BXTmQyTGhIMWxuQnJseWNFUVk0NFBjWTI0U2pCb3AyT3VWZW9i?=
 =?utf-8?B?aHh5Z0pwbFg5OXI4QlRCWFBUZmt5NGthLzcrcUQ3VEd0WWVvdkZ1ZklISnpm?=
 =?utf-8?B?T1NKaXZ2VjZ5VDNnZERKY3JUaG9iUDBUODZvdVF0SHVUd2dqYVVVZWRiNTVP?=
 =?utf-8?B?MVlmaXVDNXM1eW5hM1pZMUVDaHhjdndkcTVOKytTaFJlcW85VnBTb00zRkZp?=
 =?utf-8?B?eUVTR0FxRGUxdnYyV3FFUlFyUHIzQmRKZWhuOXdZRXM4Z3J4VTZXRVlGOFJQ?=
 =?utf-8?B?aUVzQ0tDSHRqMi9QS1VzZE9KMEg4R3hFK2x1a2hLbTE2aUdGNkRBSmhCUU1C?=
 =?utf-8?B?dnFhR3ZqemptYmk3YUFvb1A1aFErVmxZU0ZnM2FYVFNYWTg3Q0FPeHd4ak91?=
 =?utf-8?B?SXJrMVk4MEhQTFFickhhSUZnZlZDNnJlOFk2MnBUMERNeGJBS0ZFL0libyti?=
 =?utf-8?B?V296b0JXb2VqaG5KOVVLVmJyZXd3dUgvM1A5ZHVZYjVvYWVLSE1oUHh1eSsz?=
 =?utf-8?B?NjFOcGkrNWNoRVRyck00MnZkcy9STXMvWGdpclNTYkdUSy9KcUpUTWZMUDkx?=
 =?utf-8?B?ck1vbmV0c1huQXlOWkt1K2gzU3dYaTV2T2p1UEZQdFduaXd4azlSVVFnTE9o?=
 =?utf-8?B?eEdRWXBDWnFVMDMwUEtsOWt5WXYvRnQ4Qnh0bGlKdXZIOUlVUXFwdE5TNUwr?=
 =?utf-8?B?QW54RUxhWWNDOEhjS0c0Si9ZbEx0SHUzbUxabVl4MjN6am9UdkdGWjJUNlFT?=
 =?utf-8?B?VFJxWVF3UzZteUtsT25yQ25SaTlvc0huUDhaOUV4Y0ZxQW1xUHkxR2JPY2Qy?=
 =?utf-8?B?RWZVeXdmOFkySGJ0R203QkxZazJUZE1MWHNYSyttbjROWGQxY1c0MmNuMHpU?=
 =?utf-8?B?UFh2TkdZYlZHOFc3UmQzNVVId0NiVk1VNzVFcVpUQmpSM0kzalYyR3c5RVp6?=
 =?utf-8?B?ZkZ6QSsrbmRoSWIzbmRSUDRzYUFtWlR5aGl2L3kxbHdyODRKQWtqdTdobmZ0?=
 =?utf-8?B?NmFvM2d4UGdtTHVCREpKMG94cjFxZC80Qzk0OCt6ektVWDd2Z0pBbzZLTndv?=
 =?utf-8?B?UytoR0ltWkZ1bVFXdDQ4amdoVkszL3EwZmdSRVJkQy9xc1ZUZlB1Y0tMNkVS?=
 =?utf-8?B?WDAvdG1jd3FrNHdiTWRXMHVBNE1lZnQ5SVkxdWxnNnhMTERsbmd0dUlWRzh1?=
 =?utf-8?B?V1ROdWpGeTY4T1FwZk9uVXpGN1A1UjVmUzI4NEo0QUg5aVJwY0pnSitjcnJP?=
 =?utf-8?B?R3BGcGxJbTZ3T2JXSkNubHpYU0R4S2ljVDM4ekYzUXhMQUJ5dk9qZGFBeU8w?=
 =?utf-8?B?eVlLWEVQTmdmUkZJdzF2bDRLcEhFdU52Q1ptVzluWmlHeDY2MjAxYWpKS09k?=
 =?utf-8?B?UUIvbkl4YnFMMm0xdElsYTl5bXZNbUxkb1B3M1hzbHA1eVk1ZDVVQnZTOFFk?=
 =?utf-8?B?LzJES3Y2eVZtNTQ0K05YcE9ZenZwWk85V2lpNURtbHRBazRpbEhMVUFieXdi?=
 =?utf-8?B?dy9Qb29NZ2Y1Y0FkbmRBSGZXQnpyd3IzbVNjMXhkTHUzbVl0dk02V3g1ZWov?=
 =?utf-8?B?OFhPN2JuSHFlTU1wN0FobCtzWjBxWkhkelk2clIwc2MrazVZcExGUTJiZkJO?=
 =?utf-8?B?YVRnVXFuNU9vSWhrUjJBNlgzM1ZYUlZZek0xazdJazVrN2I1WTdhMlhoR1Rw?=
 =?utf-8?B?MXFJSFRDZTV2VjhoaVBTUVZId05nZTgrSXp4RElxYUtCZ0hYVkJPaWhnb01S?=
 =?utf-8?B?bnk1TmRsK1RKUGJOZklzdGE2RU5td2RQYzByNVRyOVFFMVU0cXJ3RnIxZ29V?=
 =?utf-8?B?NnREekNsN2toTUhlNGp6ZGh2NytBPT0=?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c93795fc-a263-4f27-934b-08dc4e4bd556
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2024 10:51:18.9688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DCPGg2WtvgXYM+PVBwJ8ZFspphgT/ckP/N13qbqqKiRJifgYW8+JwfegVntWbm6KyVNVBtV6bSCCo7ANPeNOSVV0VWNwKiKToE3x2Am49o1LZir7CaozLTEqAIvb170l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6920
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

Hi Chris,

On 3/26/24 21:49, Chris Morgan wrote:
> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add support for defining the usable RAM from ATAGs provided by the
> Rockchip binary TPL loader. This allows us to automatically account
> for necessary memory holes on RK3588 devices with 16GB of RAM or
> more, as well as ensure we can use the full amount of RAM available.
> 
> In the event we can't cleanly read the ATAG values from RAM or are
> not running an RK3588 board, simply fall back to the old method of
> detecting the RAM.
> 
> Tested on Indiedroid Nova with 4GB and 16GB of RAM.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
> ---
>   arch/arm/mach-rockchip/sdram.c | 58 ++++++++++++++++++++++++++++++++++
>   1 file changed, 58 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/sdram.c b/arch/arm/mach-rockchip/sdram.c
> index 0d9a0aef6f..58b78466b0 100644
> --- a/arch/arm/mach-rockchip/sdram.c
> +++ b/arch/arm/mach-rockchip/sdram.c
> @@ -10,6 +10,7 @@
>   #include <ram.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
> +#include <asm/arch-rockchip/atags.h>
>   #include <asm/arch-rockchip/sdram.h>
>   #include <dm/uclass-internal.h>
>   
> @@ -35,12 +36,69 @@ struct tos_parameter_t {
>   	s64 reserve[8];
>   };
>   
> +/*
> + * Read the ATAGs to identify all the memory banks. If we can't do it
> + * cleanly return 1 to note an unsuccessful attempt, otherwise return
> + * 0 for a successful attempt.

Return a valid error code instead? Negative if possible?

> + */
> +int rockchip_atag_ram_banks(void)
> +{
> +	struct tag *t;
> +	int bank_cnt;
> +	size_t tmp;
> +
> +	if (!CONFIG_IS_ENABLED(ARM64) && !CONFIG_IS_ENABLED(ROCKCHIP_RK3588))
> +		return 1;
> +
> +	t = atags_get_tag(ATAG_DDR_MEM);

I believe this will not compile for non RK3588 because this function is 
not defined.

There are a few ways to handle this:
- always compile atags.c but have ifdefs there with inline functions 
returning -ENOTSUPP or something like that.

> +	if (!t)
> +		return 1;
> +

-ENOENT? -ENOXIO?

> +	bank_cnt = t->u.ddr_mem.count;
> +
> +	/*
> +	 * Check to make sure the first bank ends at 0xf0000000, if it

Explain what 0xf0000000 represents here.

> +	 * does not fall back to the other methods of RAM bank
> +	 * detection.

Do we really need the first bank to ends exactly at 0xf0000000? Or 
should we rather make sure that it doesn't go into that space? (so 
anything below that would be fine?). I assume this is the result of some 
experiments, what did you learn from those boards?

> +	 */
> +	if (t->u.ddr_mem.bank[t->u.ddr_mem.count] != 0xf0000000)
> +		return 1;
> +

-EINVAL?

> +	/*
> +	 * Iterate over the RAM banks. If the start address of bank 0
> +	 * is less than or equal to 0x200000, set it to 0x200000 to
> +	 * reserve room for A-TF. Make sure the size of bank 0 doesn't
> +	 * bleed into the address space for hardware (starting at
> +	 * 0xf0000000). Banks 1 and on can be defined as-is.
> +	 */
> +	for (int i = 0; i < (t->u.ddr_mem.count); i++) {

This may result in out-of-bounds access. Indeed gd->bd->bi_dram is a 
build-time allocated array of size CONFIG_NR_DRAM_BANKS.

So I would recommend printing an error message if t->u.ddr_mem.count is 
bigger than CONFIG_NR_DRAM_BANKS. I assume we may want to still boot but 
with less RAM in that case? If we do, then only loop for the min between 
t->u.ddr_mem.count and CONFIG_NR_DRAM_BANKS.

> +		if (i == 0) {
> +			if (t->u.ddr_mem.bank[i] <= 0x200000)
> +				gd->bd->bi_dram[i].start = 0x200000;
> +			else
> +				gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
> +			tmp = gd->bd->bi_dram[i].start + t->u.ddr_mem.bank[(bank_cnt + i)];

This is incorrect, it may be offsetting up to 0x200000. If it's offset, 
you need to remove it from the address size.

"""
if (t->u.ddr_mem.bank[i] <= 0x200000)
     tmp -= 0x200000;
"""

> +			if (tmp > 0xf0000000)
> +				gd->bd->bi_dram[i].size = 0xf0000000 - gd->bd->bi_dram[i].start;

Shouldn't we do this check for all declared address spaces, not only the 
first one?

> +			else
> +				gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];

You may need to remove the 0x200000 offset here as well, e.g. with

"""

if (tmp > 0xf0000000)
     tmp = 0xf0000000;

gd->bd->bi_dram[i].size = tmp - gd->bd->bi_dram[i].start;
"""

Renaming tmp into end would probably also help figure out what it's 
supposed to contain.

> +		} else {
> +			gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
> +			gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];
> +		}
> +	};
> +

You can make this for-loop logic a bit more readable (well, to me :) ) with:

"""
/* Iterate over the RAM banks. */
/* If the start address of bank 0
  * is less than or equal to 0x200000, set it to 0x200000 to
  * reserve room for A-TF. Make sure the size of bank 0 doesn't
  * bleed into the address space for hardware (starting at
  * 0xf0000000).
  */
if (t->u.ddr_mem.bank[0] <= 0x200000)
     gd->bd->bi_dram[0].start = 0x200000;
else
     gd->bd->bi_dram[0].start = t->u.ddr_mem.bank[0];

tmp = gd->bd->bi_dram[0].start + t->u.ddr_mem.bank[bank_cnt];

if (tmp > 0xf0000000)
     gd->bd->bi_dram[0].size = 0xf0000000 - gd->bd->bi_dram[0].start;
else
     gd->bd->bi_dram[0].size = t->u.ddr_mem.bank[bank_cnt];

for (int i = 1; i < (t->u.ddr_mem.count); i++) {
     gd->bd->bi_dram[i].start = t->u.ddr_mem.bank[i];
     gd->bd->bi_dram[i].size = t->u.ddr_mem.bank[(bank_cnt + i)];
}
"""

Side question, do gd->bd->bi_dram have to store banks in a specific 
order (e.g. from lowest (0) to highest (0xfffffff) location in memory) 
or can it be random? If the former, is Rockchip guaranteeing us that the 
ATAGS will always be ordered properly or should we order them at runtime 
too?

Cheers,
Quentin
