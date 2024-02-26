Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EABC48BF6
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 11:27:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A8E8687E1B;
	Mon, 26 Feb 2024 12:27:13 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="Ys+QztmH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 450B487ECD; Mon, 26 Feb 2024 12:27:12 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05on20710.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e1a::710])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A42B87DF9
 for <u-boot@lists.denx.de>; Mon, 26 Feb 2024 12:27:08 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGGCf6GLtib9cQSm81/XQtp6qga4t/PbH+vUdr1/fEVA6e+D9e3o+jGCiRK1HiQW6g128aJny0ClSlRz458tX1BfKU+bveSl1P2FzHn0C4t7nYqZNyOFPa1jCYtHKE3Qy5OQz2j3ve95VYKMWR6H2EaKON7Umq13xTyqqnmmSRc5r0Egici53wduMGkuBh2woP5cJ+A9EV33441d3Vb1LMzqvi8jFa3+9ctHM52byi8QWj9mkwYtdGVsubFLCgWhcTE/L4e5wb7KPJxW062DTyJhVLKXLuqiQL/sO4waMxkcaE381pvlP50gkXLKXT+c0SbtRWdTo4vW7sqICNavdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qp2PzaQY/lmAw0Tg9rpNu1tPgezasRWoXvreKQzXmMQ=;
 b=c88htjOjHooHu1aInoRL8CnRvKZWDDUkbLZncTHVdkYm+UeZ7udyzv9QY3W6fGZRRGm5Rf6Ftpiw9C0I5U5PCPQTM63xDOLgpMuOvHH6vcYJ1LSJKwuvFOzp16aExH4hV47SEaKw8L4p4736P1XjUF0SYEGqrcHYs83KiyUqkChPcslqeozAadWs7GaZvKQxKC6K2RzxhSVRfKDRcGbhteK7thVduOtYL+Nk5MsEkI/XMdlz8s3ibOpdZxPAt9XPEQ/P3lvZVzXD7gmSNQPpNzJAp5crXPwhCmCV7opKkemu1WrpvkVMYq7qS6CNlWbOSiucN59UGWyns+bbnrOIhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qp2PzaQY/lmAw0Tg9rpNu1tPgezasRWoXvreKQzXmMQ=;
 b=Ys+QztmHuhuJahhE5iRWJtSMMcxsrKH1JtoQx+GbhGr4GAqVB+yaWnjMxuQq4Vxa7wTuLnkZo5uladT0XqUeJUgZcLjgnJieXYErA/v7aIbKmXzq+3ECl5AnAWZ7HrrEPQ0mPPfn9MNMwFrr2yi3QUHWB9PMEoLB+8ZfUSyXXzJMS68/WNLgPBU6CjjmFKY4TEezvuqzI3pmAkquf+K1KRZhH5DJ+6nvX0FedocVa81riXeHyDYRjMe3BnhaRPWElsKNGQpHlboRAxdnvE8V/2HCYAGHu1rFqm1a25du71/qVBDCsQFBO+EeE4Riijh3wdTtwQMZuYnt677AFc0PVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by DU0PR04MB9587.eurprd04.prod.outlook.com (2603:10a6:10:317::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 11:27:05 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::550d:ad96:e3cb:9a6e%5]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 11:27:02 +0000
Message-ID: <22deb119-2e55-4612-bcaa-c4f2acecd13d@theobroma-systems.com>
Date: Mon, 26 Feb 2024 12:26:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rockchip: load env from boot MMC device
Content-Language: en-US
To: Ben Wolsieffer <benwolsieffer@gmail.com>, u-boot@lists.denx.de
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20240226011413.435713-2-benwolsieffer@gmail.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240226011413.435713-2-benwolsieffer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0212.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::11) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|DU0PR04MB9587:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d0b8d8-bf36-4dbe-274a-08dc36bdda4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+VA4b7/C/EZUj5ZyEIvgT1Luk1SNcvdn8K/XnSwh1YDUQeFZuRN2WOYdMNvpjXXLJPOER89QPXVvdUkIke8CzAO9Bx3wjsThR5g5iYmP+k+gVhDF6GdJscODhTtW3ffKqxnqAcPG3m9cfin8ogCSXQj58zj8Muv25U2ZPi7EGkJF6oNNsGG6QpX2xBhTi5rr8LRVSQ5SA9FYsghfgby5531zQ3qCwmf6UtybhFaILc7vlO/5iivQI+6e7s85U4PEQVtjhsxyCEHXQySYc9Y6qFXNO8+NpGzhiMK/h7tqQi1rBKiNnwSLS79bzuNUVVrGmr21lGQD3BoA/ig129V9a/qvRJ26ag0a3Am0gD+rmIqnOBGI9cXZFA5GdBqW1a7RUAvk6Nw4jYBCLBr8MNynL0VAHB5En7Pj9gyhxzFbCXXeZcWExBJ/NmqcjCy9ZYQgQG5mhN7r4btLr8B0ZHNrSuD3WKD7WMYFBmpMqlQqPBofMxXQhGvpPPz2Vg48q5nciTfVNjIOUrc1FJorneeBQP5B35hChpQJhcja7jKJzDWZMHxTxxbossX0l4J5VDPKGWnm3ibcs1nEfmz8PrCS+KPmFeIrapN+Fp3hAul4qSNP3pwJnKSRqNxQ4KHbyyVGKA/dgZMkSqvukxnefF3eg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(230273577357003); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUljejI2UGw0bkpPaWIxamc1VkRGdjgyYnowa0JBZ3FsS2plbm5oS09wdDhy?=
 =?utf-8?B?blMvUGZMcUl2b2NwV3NBR2ZoZkZQcTBvc2lWbXdlcnhGeUN0Yld2QUFMK1Nu?=
 =?utf-8?B?YzhPZG45TlQ4VUlrMnRnRjN2dHFaM3pRWktrWi8wd2VCTmFwcWg1WGRWeGEx?=
 =?utf-8?B?ckszR2l4Wko3V3hhbDBicjNlRlhCUW0rcnBzVzR4VDE1RDM4enFmMUtES1lq?=
 =?utf-8?B?eVZSekxzRlBXSWdZQkZ1RU42cldYTmpmN1NPWENsNzVXeXNMRDZjY2hQMER1?=
 =?utf-8?B?RkV6MW15NjZ5KzllMVdqK2FIQVdCakZPenpjeGN5czNqSDB5QUdFdWZSOE5v?=
 =?utf-8?B?N1l0WTVLWTV0ay9zVS9seDllSXdEM3hja0tjTWQ5NlVjYlNXUDF3OTdtd3c1?=
 =?utf-8?B?VXl4b0hySklKTVVjUkQvT0V0czNTMUpnS0k4ZmEvRkZaeGwrQjZnc2RoQ29Y?=
 =?utf-8?B?aG1hVVkrYmY3S0pDODU1TktOQVYvb2ZMVUlFMDhLenNwQzlZVkFtNmRsOWF0?=
 =?utf-8?B?cTlRTG14bEx2OTNHb1MvaWhJbUxrMXo5ayt4T1B6c2ZjWVBkYitpcVNJMmVP?=
 =?utf-8?B?eHhJYWhDVnJPbG16Um9JcG9KWTlsSFNoazZrazNIbDArOHhyWm42Uk42MW1Z?=
 =?utf-8?B?b3YyMVB0OEU0VzFIUG5mL2dPcWg4ZDVhcm9YZTdSTmhiR2lmci92aUVTZzd2?=
 =?utf-8?B?UGtMUjdaVU16MzRwOXBhRTdyRE1XcmpCSDVrVnlsUGVoK083MWpxWUV6RVhY?=
 =?utf-8?B?MDlpQWRFbjZkVFU2djlrcGw0ZFY3cU56Y1pBVE9EcXphU3QyZFJlbXI2Q1pM?=
 =?utf-8?B?V0t5T1A5K1JzNm5zQ0wzdTJaSXhIOGRFMjEvb2lJeHY2SGdZNDRjaHArc0s0?=
 =?utf-8?B?ZGl3Mm5tSFFGbFVTRzh3TW9aY2s5Z0hkWDVNZi9RZHpXY2JLK05pUHFicktn?=
 =?utf-8?B?N1JpakRuNm9IbWFKYXJMY1VMWXdBazhFVkJrTnJiY2Vjb0diWHc1TE40T1U3?=
 =?utf-8?B?bHZnT1FEWTFQekppY3RpbkUweGtzSGhiR1Q1aGl6b1VrVWorOVV2bVJXNjlR?=
 =?utf-8?B?SEJlUVplMzg2d25MbkdjRDFlM3l4d2hvbmovTWpnVnp1VHljcGQvQm9YRXcz?=
 =?utf-8?B?N1ZsRUg1TWxmc205MFk3bEY0NjFSOHVjVHFVMTF3Qld2ckQrOWZ5VHRSazlD?=
 =?utf-8?B?ZSs4eE5mdlpaR2taSzJ3MGJkUWl3MDdvT01PY2V5b0RXbkVhT2o0WHl1LzFa?=
 =?utf-8?B?MDVHTGRseTNqcXNGNGc3Ni9FNTVQbmw4ZVVlSnVlMFpJVU1wTzJBZXV1SEhu?=
 =?utf-8?B?cnVKRHlMTHVMQ1NuZVZiK0dtL21pTnJWK1QzUmNjVXlYQWg1QWw4V1crNENH?=
 =?utf-8?B?TmwzRC9pUDBONnM5ZUh5SUF1MUJJa2F3WFp1bnBrMFVoeXp5aVF0MWVjWk1E?=
 =?utf-8?B?aGxtc1BNMGFDcHpZVitNbGw4VVovNU9TMDR5VjkzQUxubkIybEVwcjNsSVpy?=
 =?utf-8?B?YS9rZGRSNW1PR3pnbjJGMVQ0TmJjRFpJQWp4R0NpeWN0aW9YV0dVdXdYWmg4?=
 =?utf-8?B?Z0xvMDhwSHNnUkwvcVlHU1ZibnQ1bm8vbWIzdmFZYmZpUkgyOEVLSTlJZ1Z3?=
 =?utf-8?B?MTRVSWE5LzAxWDlFbjhiZFRlRytYMUtaaTBYS1lhdFRhQ3U2RTdtS0lpSDE4?=
 =?utf-8?B?VSt1eGhBYktJa2xYRXVlM3BsdFVIUFIveGg2dms5U256Q0kxZUxsbHU0bTRS?=
 =?utf-8?B?cU9hWTFLOVVwTlpIYXNjc0lSZFpsVFN1VmpmMWtMZDZseWcwL2dmdmNZWUk2?=
 =?utf-8?B?WUg2OS9sMHpXdzVpa1R1enpZQXRydmJudWR6WkFPSjRPTXV3NG95Sm1tYitw?=
 =?utf-8?B?QnFieXBTZFIvVUdGVDFtb1VaYW80TFZJTk5jdDMwTU1ObjBLeTdWem5jejdM?=
 =?utf-8?B?SGIxWEtmeHg2dzUwTmloU0JLNjdUb2NRZnBhWFJRcXBSVGZRUDVWQVgwWkwz?=
 =?utf-8?B?aTJxRWczbzB4WDVhL20rWnJwUFhUOWt2Q1MrU2MvTi9XU205YlNBWEJDTUxu?=
 =?utf-8?B?VGs1Y3FBazZlTkwwUFc2ZG9MOWkxRUZ6cUxhM29CcDhQRnVYRXJFdURBRFBJ?=
 =?utf-8?B?MXhnNXQrcjdUSkRBYW9vUHFOd2NJVkdxZjdGQTNheWc0M2N6ZDA1b2M2NGJO?=
 =?utf-8?Q?YtAQM3hEtIZiKkbSTljhHWg=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d0b8d8-bf36-4dbe-274a-08dc36bdda4c
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 11:27:02.0157 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oIz/iTkT+qDaT6Sr1vwSm2Z0nQYx6mwR1PKRhaKY1WMM4X1EYVBFVTMqWfFWsVwTjXOjbkH5OH4vq01J20r1ZMjETSXOhFxTEl6O6qnDj1M6MzkEu6g47kFn58t/sbLU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9587
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

Hi Ben,

On 2/26/24 02:14, Ben Wolsieffer wrote:
> [Some people who received this message don't often get email from benwolsieffer@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently, if the environment is stored on an MMC device, the device
> number is hardcoded by CONFIG_SYS_MMC_ENV_DEV. This is problematic
> because many boards can choose between booting from an SD card or a
> removable eMMC. For example, the Rock64 defconfig sets
> CONFIG_SYS_MMC_ENV_DEV=1, which corresponds to the SD card. If an eMMC
> is used as the boot device and no SD card is installed, it is impossible
> to save the environment.
> 
> To avoid this problem, we can choose the environment MMC device based on
> the boot device. The theobroma-systems boards already contain code to do
> this, so this commit simply moves it to the common Rockchip board file,
> with some refactoring. I also removed another implementation of
> mmc_get_env_dev() from tinker_rk3288 that performed MMC boot device
> detection by reading a bootrom register.
> 
> This has been tested on a Rock64v2.
> 
> Signed-off-by: Ben Wolsieffer <benwolsieffer@gmail.com>
> ---
>   arch/arm/mach-rockchip/board.c               | 28 ++++++++++++++++++
>   board/rockchip/tinker_rk3288/tinker-rk3288.c | 12 --------
>   board/theobroma-systems/common/common.c      | 30 --------------------
>   3 files changed, 28 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 2620530e03..04db809e97 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -6,6 +6,7 @@
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> +#include <dm/uclass-internal.h>
>   #include <efi_loader.h>
>   #include <fastboot.h>
>   #include <init.h>
> @@ -349,3 +350,30 @@ __weak int board_rng_seed(struct abuf *buf)
>          return 0;
>   }
>   #endif
> +
> +int mmc_get_env_dev(void)
> +{
> +       int devnum;
> +       const char *boot_device;
> +       struct udevice *dev;
> +
> +       if (IS_ENABLED(CONFIG_SYS_MMC_ENV_DEV))
> +               devnum = CONFIG_SYS_MMC_ENV_DEV;

This sadly will not compile if CONFIG_SYS_MMC_ENV_DEV is not defined, so 
you need to use the #ifdef the same way we did in 
board/theobroma-systems/common/common.c

> +       else
> +               devnum = 0;
> +
> +       boot_device = ofnode_read_chosen_string("u-boot,spl-boot-device");
> +       if (!boot_device) {
> +               debug("%s: /chosen/u-boot,spl-boot-device not set\n", __func__);
> +               return devnum;
> +       }

Note that this would mean that mmc_get_env_dev called in any context 
before U-Boot proper is executed would result in this check failing. So 
this would return devnum in SPL for example. We don't have environment 
support in SPL for our Theobroma boards, so that was something I 
explicitly didn't have to handle.

> +
> +       debug("%s: booted from %s\n", __func__, boot_device);
> +
> +       if (uclass_find_device_by_ofnode(UCLASS_MMC, ofnode_path(boot_device), &dev))

I know I didn't add it in board/theobroma-systems/common/common.c but I 
think it'd make sense to have a debug message here?

I think this may not work if mmc_get_env_dev is called before U-Boot 
proper is relocated on e.g. RK3588 and RK356x (the former will be fixed 
after 
https://lore.kernel.org/u-boot/20240221-jaguar-v3-15-1f256a82201b@theobroma-systems.com/ 
is merged). So giving some hint at where this fails could be nice too.

Something like:
"""
debug("%s: no U-Boot device found for %s\n", __func__, boot_device);
"""

for example?

> +               return devnum;
> +
> +       devnum = dev->seq_;
> +       debug("%s: get MMC env from mmc%d\n", __func__, devnum);
> +       return devnum;
> +}
> diff --git a/board/rockchip/tinker_rk3288/tinker-rk3288.c b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> index f85209c649..eff3a00c30 100644
> --- a/board/rockchip/tinker_rk3288/tinker-rk3288.c
> +++ b/board/rockchip/tinker_rk3288/tinker-rk3288.c
> @@ -11,8 +11,6 @@
>   #include <init.h>
>   #include <net.h>
>   #include <netdev.h>
> -#include <asm/arch-rockchip/bootrom.h>
> -#include <asm/io.h>
> 
>   static int get_ethaddr_from_eeprom(u8 *addr)
>   {
> @@ -38,13 +36,3 @@ int rk3288_board_late_init(void)
> 
>          return 0;
>   }
> -
> -int mmc_get_env_dev(void)
> -{
> -       u32 bootdevice_brom_id = readl(BROM_BOOTSOURCE_ID_ADDR);
> -
> -       if (bootdevice_brom_id == BROM_BOOTSOURCE_EMMC)
> -               return 0;
> -
> -       return 1;
> -}

This could be an issue. Indeed, /chosen/u-boot,spl-boot-device doesn't 
report the storage medium used to load TPL+SPL (as does BROM_BOOTSOURCE_ 
as far as I know?), but rather U-Boot proper, which may be loaded from a 
different storage medium than what was used for loading TPL+SPL. So this 
would be a change in behavior (which could be fine, it depends on what 
maintainers of the RK3288 TInker board would like to have). E.g. for 
u-boot,spl-boot-order = "same-as-spl", <sd>, <emmc>; if TPL+SPL is 
loaded from eMMC but U-Boot proper isn't found on the eMMC, it'll try to 
load it from SD card next. In that scenario 
/chosen/u-boot,spl-boot-device would be <sd> while the current 
implementation for mmc_get_env_dev would select eMMC instead.

Cheers,
Quentin
