Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1DD0E6FE2F
	for <u-boot@archiver.kernel.org>; Fri, 22 Sep 2023 13:54:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A51E864DD;
	Fri, 22 Sep 2023 15:54:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=outlook.com header.i=@outlook.com header.b="XMRxYi40";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48D6D86575; Fri, 22 Sep 2023 15:54:39 +0200 (CEST)
Received: from JPN01-OS0-obe.outbound.protection.outlook.com
 (mail-os0jpn01olkn20821.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:700c::821])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C461C86484
 for <u-boot@lists.denx.de>; Fri, 22 Sep 2023 15:54:36 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=wiagn233@outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfxUdtVxc14JjyrVIjScyuzjUgRlUyIT/edqiyPt/shpSlmyrPE7nyxI8wt+quN44+jHfxNOn0lhRo17UEXJQ6x5XXd18O8/cmAVZCSJjyUg7i0lNnXtXVQP/JDdSG+M45wHA1UVn57v9ono/I9Wf8M3pjr3kDeFIjoXUum5Q6f048c2ffa+fiTcAtJVFa3QZM0DO1RM+HKGEGDaHJM6MyqL4fb0hSNLXkpM3DPxB2EJzsqnAoej44c1+9MH7tstjrh0wT1J+kirPvUsRUmBGRQSnV0Wt+YN29CmKC+h6nqLAcSzqzLMRfBu1gxgqeR8U990Syckb1hE+wBeiF2GBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q133JKA1pRwKd1PLjZMjk3Zj1FBsFl6Nf4POcC46av4=;
 b=i9mKDGpHYabzARkyq6PvIZcgYYh2z9jgpuQVW2C97YjzgUNLI8bilnUIROM72TclQQIsG36ebRaDU/yeZ8ePlcq1XX2S2s09rgPKY7pkrTqe/pr7jCoZCzOIFrq47GYNfd4HFD3n/t8tnx5kU9w+UlgQpziu4q6HHtDUyiIezGIqiuhoR3ueY3jsfIzwe0c4iRR8s1T/3YYab7u+fZiFRTRS4G01MFaNG/vQrAPDXGEthePNrKIbCIridT0QYQho6Y9723CIiZuQq6GZVB3lDYNgPKyHDikN1Jk/HEvnPDRS9BYi6VHLnkAGJ7nkkXblW4vfZQ0rhulrbaaMHGHOKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q133JKA1pRwKd1PLjZMjk3Zj1FBsFl6Nf4POcC46av4=;
 b=XMRxYi409LpyGo0DaDGzg+S7zpnTdFMgdRg5qKc9q9VGFpcT11Fd4VkhU90JaXfk7CpstQZn983GzHb9NUj5tabYqOYmXSW4RH9u8nZOjaGJ70fmhl0GJti684tcZzmxLczY3/P55nu+43oO4/zUKXe5ieh5l8cJhIj+pPVkF+7DQ4fFkdIcz3VeEQgYhZJGgYHA68yHR+jA43spGudhRSjTOmbxPXYXWMYv3DU6Pj78W6F2/jpzLqvvb4GKspRigIBlQspLU2CvnAEjbfvASc0qI+lwcxH8InGlTqRyRuD2Pdyrn2R/hwyW4NZm94R3CcGeToBf8hfcGff3rTNfAw==
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:23e::10)
 by TYYP286MB1835.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.10; Fri, 22 Sep
 2023 13:54:31 +0000
Received: from TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f741:44af:3f66:bdd5]) by TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 ([fe80::f741:44af:3f66:bdd5%4]) with mapi id 15.20.6838.013; Fri, 22 Sep 2023
 13:54:31 +0000
Message-ID: <TY3P286MB2611E76FC176D2A629BFF01698FFA@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
Date: Fri, 22 Sep 2023 21:54:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: wiagn233@outlook.com, u-boot@lists.denx.de, mps@arvanta.net
Subject: Re: [PATCH 1/1] riscv: set fdtfile on VisionFive 2
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230907112128.342315-1-heinrich.schuchardt@canonical.com>
From: Shengyu Qu <wiagn233@outlook.com>
In-Reply-To: <20230907112128.342315-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [f5JKlseMNEfmvbhHqiN4GvohZ2BaiMd5jgd+dJMl+6N476q9UXJI0WQtIh/0ddyo]
X-ClientProxiedBy: SI2PR01CA0036.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::22) To TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:23e::10)
X-Microsoft-Original-Message-ID: <6650153d-14a3-bed1-9a02-2aab427eacca@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY3P286MB2611:EE_|TYYP286MB1835:EE_
X-MS-Office365-Filtering-Correlation-Id: dce037b1-bafb-4a3d-848a-08dbbb7371cb
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lBjC8zxvQ73pb74smCY1mnkZORnZLQbkwOQ1v6QZb+CEjsekDOsJoxi13DXWn58hWQatAc6GBtSTDDxNsJFY/pmOW5+OVWqXOAyRF/GVYFjlkT1BzUz/SFq8AIAQs/AaPl7xglqx8NjQvTs0jycbucqLzksYR4bzTfOk4rvICTGy38LZ0CpK2Pzdy6kPVVyPdyauj/96bEYLX1RWbpKf+jWWiYbwcw7gdlmqQ+R8UebcklAhnioaHONA41nJ4McX2DltU1AjeRvyMk9RdHj4h63hOkcfQhfvEazu/vTOcsoibBcuNJsn5a1dM4CdMk8FlO4PURTdFa7973ABGGlMa6wWfheovgCCvBjjJcgsT344yB23FahvqLHFobquwOFh1fFoF2RPH8Gh9sKUXAzE2As7/OMmt+Il1bLSvDCpwod74QCE2zwBkptgrUxqkMb+vnao5ta7rivimwmQgpPj2z/SRgJasL7ZwGciqditDTg+d9SR9CLFbWtXBnLiYAASDGveOx6s1Hfx7xQg9UpnbGP7ySzTDSz7iMiMg41EUYCIte5UyoXSuxOzHdROHH8E+gNvQDcV/w5sV60R9iobMhX13PHbMIxMyt4t/ELXVXi7WH+UA94mn9Hy+oXtrzSY
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Zk4xYzVZRm5wVTdVdjNjMnFuSjM5aHJLeCtsSjViZzZyakU1blhFV3RlRE52?=
 =?utf-8?B?bFhobWFhNElRMVpBWFhiS2lCQ1hxdmN6Y083SCtUSkNlakswOFp5NSt0ZkdL?=
 =?utf-8?B?UVdoSzNNSFNqUmFWcXJ0Y29YV2loazhOK2p6ZjU3dUgrVWJzQkdpSGJHWmp4?=
 =?utf-8?B?WXN4a0o5S2JhZVRLbGxJckFsR3ZTL0NwQXFoZWJUaHp0NkFBN3YwQTdvRXpB?=
 =?utf-8?B?Q1E3ODF4UUxWN05rd3BYVW9oSkVweTMvajc0Wno2RVArVk16UllrOVNFNmdJ?=
 =?utf-8?B?alB2VmFRMDZqNDJZL3hvNXp1Z1BXMGFVOUthQ2JLWFZLeFR3elpib3pnL3dh?=
 =?utf-8?B?WVhFK3p6TmluWCtBWmFhLy91VlpOdlZheDZMSmhNOVZUVHFxOCs4blFGbUdQ?=
 =?utf-8?B?RjJHNXRpVHFLWWs1dGZkWjlBc1RhMEhDdk1ueE13M295clhma1ZyaXRPMTJJ?=
 =?utf-8?B?T3hEcll5VWJ4Q3ErNkFsTGd6U25hZEQyQVV6VnIvZy96VDBWVGF4NkhBU1c1?=
 =?utf-8?B?Nk9pZFprS0kySXptYVQzR0MzdjRzMjMyc1RVUm9tbHFGUngrSG1zWmJTakI2?=
 =?utf-8?B?Ykd2amEwL2lPTnoyaFJtanYzTWk2SmQ5MW5uQkZ1Nmxibk9pbjBNaElaRHh6?=
 =?utf-8?B?eVM5Q0RtWDFGQjVkS3ZiSC9wNERUa3pGOTFQVVNZaU91VEZwMGxpak5jcXIy?=
 =?utf-8?B?VmN4NXZYaHluZ1h5WTd5ZlYxbDMwNzU0bUg5cnlZVzB3aXR0WkxXVERZcFBJ?=
 =?utf-8?B?QjM1ZWhzdldPS3QxZ0JmeGFucUtiUTdsMHRsRVNFUHYvLzRLb2lsclZsbXRx?=
 =?utf-8?B?Yk4yNXp0bExjVllzOFFDMXNEMTFVK1VyQitoWkJkSTRXWWY2bkh2RDZxaVVY?=
 =?utf-8?B?ZlhlU2Y5SDBmWlNla08xbDVYQndTT0VydEJPUyt6QTNvZXVnd3p5U2FPaE1M?=
 =?utf-8?B?dWNkOU9yQnNyZlcrcTdTYng3NGhreDZ6dXFGL0pOTkVPWlpIWGZ6RVIxUHcv?=
 =?utf-8?B?aFB4ZXBYWmltY3FIRDdGcEVsdUx5Sm12V2ZiRHd6OW5KSWpvMnd2cSt2SFBy?=
 =?utf-8?B?S0ZLTHAybnVCN3pXNXFJY0FLRmkzOGxPY0k0cDl1K3hBUFdUQjllZ2tGTHkw?=
 =?utf-8?B?TC9ZY3FJSHpQeFEwbzQrNG0xU0RKNTlHVDZiNlNHQ2xQRFF2MnJ4TCt3b1VS?=
 =?utf-8?B?S0pMNUY4Uk1vMjJ5QlFrK1c2UjdpaHNjeGpBaUdEZ043WVlleCsydVkvVU1J?=
 =?utf-8?B?ZGlhemF2eUQ5WTRkQXpuUlVhM1FpMi9GdzFENHdOOThMTTlXc0Z3K2R1bVVZ?=
 =?utf-8?B?VEtYVXZpV1RNZW1HNlhFV1NkM1cwczNZNURzZ0RCVWplTVNWOGFsb1ZsRlRp?=
 =?utf-8?B?RU82OXZud0pxcGdlOVNRN290T1VCSlZEbm1wQkZkZkMrK0pUbkhRLzh3K3RH?=
 =?utf-8?B?S3Nob1NCRVpsWjNmQ1M5eVpQNFJPVEM5K3FYRlNkWTJ5WHJmZEZuTnZSY2V3?=
 =?utf-8?B?d3MvTm9uanNLWnJ3MzF2UFl0MmZjUU04d0NMVDNVZEVVODZxTHZWcys4Vml5?=
 =?utf-8?B?NHhMWGJMSGNublQxQkE3QkxDd2Y0aVc3VmpvUXpjMGdsb0tML1UzcWFCUmRY?=
 =?utf-8?B?Rzdyd1ZGRFpGaWg5QzZwRVFFWEMxWUZLMzRrcTRHdExkcU1xVVA1VnQ1TUg5?=
 =?utf-8?B?K1pZb1QycnRnRDAyNzJNV2tSRktJcXZvR1dGdVpRTXJCSm9VRU5aVVh3PT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dce037b1-bafb-4a3d-848a-08dbbb7371cb
X-MS-Exchange-CrossTenant-AuthSource: TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 13:54:31.1867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB1835
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

Hello Leo,

This patch seems only landed in next branch, not master. It is seriously

needed to make visionfive 2 working properly. Could you merge it to

master branch?

Best regards,

Shengyu

> Multiple revisions of the StarFive VisionFive 2 board exist. They can be
> identified by reading their EEPROM.
>
> Linux uses two differently named device-tree files. To load the correct
> device-tree we need to set $fdtfile to the device-tree file name that
> matches the board revision.
>
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> Tested-by: Milan P. Stanić <mps@arvanta.net>
> ---
>   arch/riscv/Kconfig                            |  1 +
>   .../visionfive2/starfive_visionfive2.c        | 43 ++++++++++++++++++-
>   2 files changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 6771d8d919..1c62c2345b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -26,6 +26,7 @@ config TARGET_SIFIVE_UNMATCHED
>   
>   config TARGET_STARFIVE_VISIONFIVE2
>   	bool "Support StarFive VisionFive2 Board"
> +	select BOARD_LATE_INIT
>   
>   config TARGET_TH1520_LPI4A
>   	bool "Support Sipeed's TH1520 Lichee PI 4A Board"
> diff --git a/board/starfive/visionfive2/starfive_visionfive2.c b/board/starfive/visionfive2/starfive_visionfive2.c
> index d609262b67..05d8d2d657 100644
> --- a/board/starfive/visionfive2/starfive_visionfive2.c
> +++ b/board/starfive/visionfive2/starfive_visionfive2.c
> @@ -5,14 +5,20 @@
>    */
>   
>   #include <common.h>
> -#include <asm/io.h>
> -#include <asm/sections.h>
>   #include <cpu_func.h>
>   #include <dm.h>
> +#include <env.h>
> +#include <asm/arch/eeprom.h>
> +#include <asm/io.h>
> +#include <asm/sections.h>
>   #include <linux/bitops.h>
>   
>   #define JH7110_L2_PREFETCHER_BASE_ADDR		0x2030000
>   #define JH7110_L2_PREFETCHER_HART_OFFSET	0x2000
> +#define FDTFILE_VISIONFIVE2_1_2A \
> +	"starfive/jh7110-starfive-visionfive-2-v1.2a.dtb"
> +#define FDTFILE_VISIONFIVE2_1_3B \
> +	"starfive/jh7110-starfive-visionfive-2-v1.3b.dtb"
>   
>   /* enable U74-mc hart1~hart4 prefetcher */
>   static void enable_prefetcher(void)
> @@ -33,6 +39,31 @@ static void enable_prefetcher(void)
>   	}
>   }
>   
> +/**
> + * set_fdtfile() - set the $fdtfile variable based on the board revision
> + */
> +static void set_fdtfile(void)
> +{
> +	u8 version;
> +	const char *fdtfile;
> +
> +	version = get_pcb_revision_from_eeprom();
> +	switch (version) {
> +	case 'a':
> +	case 'A':
> +		fdtfile = FDTFILE_VISIONFIVE2_1_2A;
> +	        break;
> +
> +	case 'b':
> +	case 'B':
> +	default:
> +		fdtfile = FDTFILE_VISIONFIVE2_1_3B;
> +	        break;
> +	};
> +
> +	env_set("fdtfile", fdtfile);
> +}
> +
>   int board_init(void)
>   {
>   	enable_caches();
> @@ -41,6 +72,14 @@ int board_init(void)
>   	return 0;
>   }
>   
> +int board_late_init(void)
> +{
> +	if (CONFIG_IS_ENABLED(ID_EEPROM))
> +		set_fdtfile();
> +
> +	return 0;
> +}
> +
>   void *board_fdt_blob_setup(int *err)
>   {
>   	*err = 0;
