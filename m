Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C60B9C54E4A
	for <u-boot@archiver.kernel.org>; Fri,  8 Mar 2024 15:29:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F310787DB0;
	Fri,  8 Mar 2024 16:29:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=theobroma-systems.com header.i=@theobroma-systems.com header.b="c5PGz11K";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1EDE87EB5; Fri,  8 Mar 2024 16:29:40 +0100 (CET)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on071a.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe1f::71a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F393287D9C
 for <u-boot@lists.denx.de>; Fri,  8 Mar 2024 16:29:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=theobroma-systems.com
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=quentin.schulz@theobroma-systems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i8cMwM0S6RZ1/kKWys1e2+2karfc7iHh3SvbBnKvRlG9zULpTospxa9dhRwjet3n+Fv+5BT8XWt1eFhL078TmxRmhWawk27SlWFuYhFbG+COXwkJ05YrrwW0RvK8AilzUITfBQv2t3a9l+t87uK9WfK8H/S8ImZvjcVg5R2DksTXpkmYFDqq973bTgcCnm/jkk2+LKabt04sjdmEFhMX/3Rd/8PGIMVvNFOaaURaTGgof9QjTH/LZWEBHJ2X54j/AtN/Jt0OJOjMrY5XL2DUV9lluVilYN2aLzEw9k85i6pG4ySJCcqR4U4JXFX7jaRtXObAsqUgD716Ob4T0BXqAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=clj4smHv5Uy7FxFDp5bvutGzo23rabxadqw5qOvzqGE=;
 b=hariiNk6lDkcrqdV+MmnHoIIFQDCIpa0j5nJ6lG74ENaYfNHLsRdVLOqhd0BwtjKBJNXyeDjGP04OhvDTTt62XY+Gk0RvmKOW1+yqWjVad2/A+tFF2PbuFb6xYyeTZ+kJVmSQtup+3RL0PUhXJBrNqs8lnrTN3ntnWbCVmMTr0c+sIyv999wyuNGC69Dps9XuFRr6u3wDJBGF/ogKqB+/M8UKW2qS0zIAYKSXEEQ1E7k03AuUeWNux68G+7VUg3qEb1x4QzdRhVs9MDN0bwSOFI2ynr6rDDYY+8OxU222xySsFSW8vNy2mQPHREaJCGOIsLxDDv9bR3k1F24xzaKBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=theobroma-systems.com; dmarc=pass action=none
 header.from=theobroma-systems.com; dkim=pass header.d=theobroma-systems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=theobroma-systems.com; 
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=clj4smHv5Uy7FxFDp5bvutGzo23rabxadqw5qOvzqGE=;
 b=c5PGz11K4ojYal0x/0jLqs+vyG+Ib2t1hJ2ODV+1DiBaLREUnFTUCQg2sixSD4JODpKF8A2/fTVuu/lG4dHvX/2pQmCawtYqVRD2BI/8ElmdWwoI47AZOpSj7zj/SH4Nbw+QRsrXCZkx2izHo4a4qtLMgCVV+AxPqbZAs1YGL4tGYoFrUHa5+z21vB6BKVXBP8qyKkjkT8o67dUskLzEc7HktvBWX2FflMY8OvYFlnLXahQppQpnNVc5B1p/odVTKjMXpnfcJvdExvcT4vQJ0BkDSlYZ7RBvMrWDvF7b9995V0sgA1yQ9aQOdAaaU9cLCr5IOo+ui10+9d7K06ACug==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=theobroma-systems.com;
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com (2603:10a6:10:2d7::10)
 by AM9PR04MB8523.eurprd04.prod.outlook.com (2603:10a6:20b:432::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Fri, 8 Mar
 2024 15:29:34 +0000
Received: from DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda]) by DU2PR04MB8536.eurprd04.prod.outlook.com
 ([fe80::23:4118:ae4a:8dda%5]) with mapi id 15.20.7339.033; Fri, 8 Mar 2024
 15:29:34 +0000
Message-ID: <4e39f65f-54ac-4488-8d19-d65087a79d0a@theobroma-systems.com>
Date: Fri, 8 Mar 2024 16:29:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rockchip: load env from boot MMC device
Content-Language: en-US
To: Ben Wolsieffer <benwolsieffer@gmail.com>, u-boot@lists.denx.de
Cc: "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Klaus Goger <klaus.goger@theobroma-systems.com>,
 Kever Yang <kever.yang@rock-chips.com>, Lin Huang <hl@rock-chips.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
References: <20240308030051.370824-1-benwolsieffer@gmail.com>
From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
In-Reply-To: <20240308030051.370824-1-benwolsieffer@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0051.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f0::20) To DU2PR04MB8536.eurprd04.prod.outlook.com
 (2603:10a6:10:2d7::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8536:EE_|AM9PR04MB8523:EE_
X-MS-Office365-Filtering-Correlation-Id: aa84dafd-7125-4616-ed84-08dc3f848ec3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ylSmwubS8JDv9ODWwVZM7MD3v3MK+g8YBv4TdrHuHCeBbAYnG7ig4WALEq+ac7Xo6qhoXkEp9e6Xdnp8Eey5df6ZOVNsdIfQWw8Nj4Vcs/OwsYT6lVX4Kr9H+ua8K41/Eib58LP70Z0Ww10p5g5xSpWCPIx6SfQCV+SA8t1WdQqKkpibe9OdjaCT8uPs/QvtdAllWotByTsN+UpFMPVa9tloJWRLqNOgLE3qA/cK9VwdH+7dCRBxFA8yn5PIRbOouEXqe5EMfXd1ZA7sh0dU0RHJldT+qgsrzDaAT4y3wExIOsoAm3lbr+LNpkkMS95RSeqnJPdOUPDwAV/YsuKFbO/0WTVCxjl6J2XPoxaDvelimuUZCGyt8hJ5VsreyYLAbaf783KCvG7B2WuCXxC2r4ogt5IrOzSltdpOOhaE8bERWo9/LmlM31OQgoG2lrNRctswgXpaFqkuBnU4JLRaYVkyo4ervEg+JPQK2I5ce40Fmpt4vhmOhLoawaa42UqEumD8JCut0SUO0QLWfMdOQrEuc0kTOtiurfkNlkwrDQmeMn2Qa2ytOr5TMlHnqLnB0ET9nipgC7M8pAZDCJPk+M1E6EqiLARpxpCt0pCsJak=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU2PR04MB8536.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXpRYjZVenhNTk1paWNpVzRRM2F5eUVvVFJNak5yc3BCRnhCV2hUOUwvMmxJ?=
 =?utf-8?B?c2RLeWZnYWRraE92N043MnJnaGVEby9zdnZ1cUt6b21oQks3aERQaXpkK05G?=
 =?utf-8?B?ZTFieDlCTUtlZ2dnYTFQNUlSYlJteml0eWwwbXlMeWlMd2dvUk5oK21VQ1FI?=
 =?utf-8?B?VWZTWTJ3OXNZMlBQL1U5enB2VGR3YTdrdXhUUEhBT0plTTFRSmpndE90eGJZ?=
 =?utf-8?B?VDBuK0hSWU9qVXVhTlB3LzUzS05JR0s3czFURGRBYnhpVDNwdFJzZWxGcGRU?=
 =?utf-8?B?bTFwWVg4ZzFRaUVkRUdPNG9vTE5XTWtDYWdWaG14N2ZzeTNwMk82VW0zTk8r?=
 =?utf-8?B?L0lpY09yZlR1QmVEaTBVVnM2WWxNMHRicDUvRlR1VzdseFlWS2Q2MDNkb2No?=
 =?utf-8?B?b2dWL0dOK2d4SlkwYmhzQ1YycUpqL1dPWXBld0JtM0VUc0hXVDI2SjFMaklO?=
 =?utf-8?B?Yjk0Sk51dHQrc09iR2ozamxLWjA2MGRoV3dHL1B2ZVRSTEpBbUMwSnVNNjFJ?=
 =?utf-8?B?WVlCQXBmMmFUMEVrTnlka0IrTjdWUjViWVBTSXJsNkNPaXFHZ3NKU1kvQTdp?=
 =?utf-8?B?R2dYUDY1c084RjR0V2FxV1VLQ2JSbnJ2YVBQRE9nUS9ncmFDZVhHZnB6c25r?=
 =?utf-8?B?ZkREdE9UM0tJTDFrQ3lyRHdoNlhwVGZ1dTI0dnIrNmpMbEp1SEJreTlWVEll?=
 =?utf-8?B?OFhjRXRNVUZYRXk2bXBkU0F0U3VNOUNDcFBGUmloQ2VHRlp2SjF4T3lzUUlE?=
 =?utf-8?B?WDRibk5hcit1empvaGpmbDdYc2VoVEwzS3ZJd2Y0bjQvSDJZbStEZjJKT1BH?=
 =?utf-8?B?WkEzck50UHdPckxaTTRVUjIxU04zT0JsUzArZmlhYjNJUUtieTVwa3VjeEYx?=
 =?utf-8?B?dWZPbGJzZE5aR0NKWEFtWS9BNnFMYzhJUkhZUmFPUDZucHM2ekRLdDd5MGlR?=
 =?utf-8?B?TFVuclE1UWdSTEd5Q2pTMzJ6eGFicjYvNjE2Z1M3QWRweWo0VEhScFVLajdo?=
 =?utf-8?B?MGQ5czZneThMTDZWT01KbkR0WGExS3hmZVROQ3IyRStlMmJZNG1uTUdTRHZC?=
 =?utf-8?B?cjFuMmxBVG1tODBzUklOS2Z0aEpNM2oveWR4bFl5YXBacTM2Q1E2ajd0NlY3?=
 =?utf-8?B?Sy9oL2VzdnMyMkNoWlVaaDFpbkYzTTZud3hYZ3NRVUN4VVUwbEJMMzY2REVE?=
 =?utf-8?B?aks1ZVJzSjVkOVUyV2dSeldRYlZXUm84MEp1NUtFM2s5dmlwMlJ3Z0ZBUHUy?=
 =?utf-8?B?L3RHelE4ajM0cWZuY255NjZlTmNBMnRBL3I3MnNPVGl4M0l5M1hmTWdtRTJW?=
 =?utf-8?B?NUZjRFJ6UWZYemRBTkI0VGJVeElDTkJNUjhZZGE1UXpEOFpXazZjREMyS3VB?=
 =?utf-8?B?ZjVGQmJTRG5mTGNJRFhSeEFtYWd5N3BQY3ZpbzcvbDdjTi8zaEp1MEJ3SzBH?=
 =?utf-8?B?REN3b3djdW9tdHdEbnl6OFJTOGJzN2RsaVFJOExtaDB5VzB2R1Y4TTNaSEtv?=
 =?utf-8?B?QUJPNndEaFp1S3dDMHE2WVFEWDY0U3JxSW03Zy9TdWRUVXozNlFOYTJYbkxG?=
 =?utf-8?B?WkxVWVJvcFZvYytzcUkyd1lLVVV5SEZkV25LVkNUQ01LaTY2N3h0UTRYeVJE?=
 =?utf-8?B?VFhDa2lYdk5xb1FPQ2VYcUJXbEg2aHd4U2c4M1RLOGgxSGdHY1pyQU0wYXZ4?=
 =?utf-8?B?SDNFOE1OMG9SQXhvc1F4M3phcVRIMWNwUzJ3aEVMNzZZOCtSclY4KzFZVVRT?=
 =?utf-8?B?bHRjMk1ZTjdWanhoNHNjdEdlNC9rdEZBWStpYjVqMkF0REttMEtPTVMzMTVT?=
 =?utf-8?B?V2V4TTlIYWRjMTNRYU5Pdi93dnNzTnFZemk2aDg3UnJKUHFhcm1UR0J0cll2?=
 =?utf-8?B?S3h1aFdLVUFBYmhuZXpTRFk4S2QzVXRTMytJYVpEZlJiVHhScnRBQVBKQUlM?=
 =?utf-8?B?bzNzaUNqQytoclNob1hIN2J3Y3RNK0JYZTlNNWxKc1JhN2p3T3lFdUZyL0lP?=
 =?utf-8?B?bkl0Zk1BblAxbmpraGJZUmVUVkl4ZWtHVjQ5MWRXM2xjV0JPYkdENnZCWDcr?=
 =?utf-8?B?c2FTNEticmpnMm9Gclp1M2dCOWNDbTM5L0xRSDJJc0x1U0p0SHJlcTF1cFBa?=
 =?utf-8?B?YnB0WnVGQ1ViVnJ1NzE2R0U0YzRSTkVGRXl6UTVld1hhdHkxdkVDUGJrWHVB?=
 =?utf-8?Q?zUJPKmeNROZ6F+TFwumRNn4=3D?=
X-OriginatorOrg: theobroma-systems.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa84dafd-7125-4616-ed84-08dc3f848ec3
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8536.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:29:34.4404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DxMf9qofmI60iuNA+osjkJoIImnqBZGDOE354ACfOjeK/TxXEUH4dxWbQJ/Myn6s27S6RypdAsMk4dPXqfxdbACmW/Ry2ARk2ppeHNpmcfIJ+4zzVUDY6fIDCdcYossI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8523
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

On 3/8/24 04:00, Ben Wolsieffer wrote:
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

Minor (optional I believe) comments below but for the "logic" part:

Reviewed-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>

> ---
> v2:
> * Use #ifdef rather than if(CONFIG_IS_ENABLED(...))
> * Add a debug message if boot device is not found
> 
>   arch/arm/mach-rockchip/board.c               | 31 ++++++++++++++++++++
>   board/rockchip/tinker_rk3288/tinker-rk3288.c | 12 --------
>   board/theobroma-systems/common/common.c      | 30 -------------------
>   3 files changed, 31 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/arm/mach-rockchip/board.c b/arch/arm/mach-rockchip/board.c
> index 2620530e03..8aa09f44b3 100644
> --- a/arch/arm/mach-rockchip/board.c
> +++ b/arch/arm/mach-rockchip/board.c
> @@ -6,6 +6,7 @@
>   #include <clk.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> +#include <dm/uclass-internal.h>

c.f. 
https://docs.u-boot.org/en/latest/develop/codingstyle.html#include-files

"""
In all cases, they should be listed in alphabetical order. First comes 
headers which are located directly in our top-level include diretory. 
This excludes the common.h header file which is to be removed. Second 
are headers within subdirectories, Finally directory-local includes 
should be listed.
"""

So it should be after
asm/arch-rockchip/misc.h
and before
power/regulator.h

>   #include <efi_loader.h>
>   #include <fastboot.h>
>   #include <init.h>
> @@ -349,3 +350,33 @@ __weak int board_rng_seed(struct abuf *buf)
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

This rule isn't written in the coding style I think, but some kernel 
people like the reverse Christmas tree order.

So, here it'd be:
"""
+       const char *boot_device;
+       struct udevice *dev;
+       int devnum;
"""

Cheers,
Quentin
