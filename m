Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 965BCC43458
	for <u-boot@archiver.kernel.org>; Wed,  8 Jul 2026 04:39:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 92E1F84A3E;
	Wed,  8 Jul 2026 06:39:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="VTfV4fYo";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E0F84A4C; Wed,  8 Jul 2026 06:39:53 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 95CBC84A3C
 for <u-boot@lists.denx.de>; Wed,  8 Jul 2026 06:39:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpC0KqbgQpLp41et7MhxTIsPd1vpmH+9BDADALkWXFx0X41611oKJazrWd+zxHGkvPjTuRZEacxWkIiVqX8KgFvCTn6hleILX3e4DCbtkTE6rH7tDOehec5HWtzrTt6vQsHE0kq0D0lUyuBs5KwCVlg1xIpG5pJjouR3YeHhGsT6f5ew6tabUZ/Zzb+hvgKZEF7nLYY2/fUGbjyVDnsHcUl+OhsI4aMk25+GmasGxVhgL2WKrNj6d6nFSvXPOT1bMBENE1JfZX2egriLAY3M26KyXJp7C+unJCJmvqN7YhZZXt8vHdLrCeBcUzukOEM1VoP6gPhqAq1VPvC655gg7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=99K10wK8pyKSl047XLOoJ62IbCE5oodPCzHMz8yltwU=;
 b=geasBJPIO5FFSrYU7C2uFllqgq+QfxJG3wWdVXFUHPwTY45WM9zhHZWYeuAIQ4OoKHQjoFB7i2L8F7g7SxHOrh1++nVo+vHgyRR/6O8fvW079tM0DXp0mxv3euIyz3bTbT0vf+kANZR24KypvWFf5zqHIrLF7cGpHRKpLDqjqH8fBPEMl0WAgPE11Mn8qPGUGjqrfLqMIv7pS9BI4xZ3pJDRZgThWm6GFK/sO7FrHs3ehZ6FHk3/Y2/OjuEw/Ohoevddqst0iWhBnGEuCR2L/Z4wTZwWYq+S7wwyZH6DL3b1nPU21Cn8bjpwS+PvSSOnD4JXoqcIm+D4Xj8hkGJwSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=99K10wK8pyKSl047XLOoJ62IbCE5oodPCzHMz8yltwU=;
 b=VTfV4fYobWelarGn6e3gbMbRjpweZewF0kiwP5bS9GTm5U9Yr+4ifYQqOhiDmtBiBTryXNfeghyGA/nPdKWqRCiWBYwa/6oiECp/qbczhzqM43D12/WjVnKWgFwZYEZqG5XClRfogTJ2IcI3kyA/yHG1bqES9L6mbP5Bd19uxi1XXInSFCaM4xkj8sdU9jGSyyQRbT37s6GyH4dtSDVajcSf5Z+fKgQ76lgC15BzxuPx9wLQgywEs1U4ImjgbhOgdJuZDP1Vo+Y8DIqChgJU+GFsGMD1xn/f3xdN0YtaGgS/HBBgXV93gfrIO51O/zYGyywSnQFfOk8ObQKZop8d5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by PH0PR03MB6589.namprd03.prod.outlook.com (2603:10b6:510:b2::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Wed, 8 Jul
 2026 04:39:47 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 04:39:47 +0000
Message-ID: <a5645fd0-8da2-4af0-97c9-1b920c8ac453@altera.com>
Date: Wed, 8 Jul 2026 12:39:39 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/7] arm: socfpga: n5x: update SPL data save and
 restore implementation
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260623020221.32362-1-chen.huei.lok@altera.com>
 <20260623020221.32362-8-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260623020221.32362-8-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|PH0PR03MB6589:EE_
X-MS-Office365-Filtering-Correlation-Id: 240c2e6f-b539-4a0d-a992-08dedcaaf07d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|22082099003|18002099003|55112099003|11063799006|56012099006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: YuAI++PHe8d+NLuNKIikHrAq21urSpEp4YPjpB/fZR2pgn4kzH/hSrnSq702yd+HPc7wlZrJfNt4ck/jS8CrHHQm/P8fEJstukl6/R7To7aN5YcZkvLls89tbDiX0gJOnS+TxLuGEc6bg0lV6G7xRQSeiphLuG1tWdyBD2EgwHIFE2mCGOyTvas6LXYDabmA6Xi8E034h8BwMW7hBAHNWXDhD6tunwOXxdDzvnm0NHsB9+bXvSoIAMB6pTLnKEJTRkFlKArYVAeJxeAhy/j058awhSZYC7PAq012fF4s3gjV0jMZ2pt/ANnF6SHD8jQXGjWl9VwbqRj7xAr9HJeFwxAF+ityEP20evNkD9HH85HX7x1SX7f1uk5J3gBbEYLRuTA0SKDsUJPt4zFYKo9YOsTO+0AZvfzQbULp2DxbVJD64zKpACOqIFwdCrmxHe1kBlsLDdGRHKN1/OB6wSOtNv31XwrAxykl6v7cf9kxDoG6zLmeWz9+zd+3UD2scdps1dNhDqTyv7Bp2aKfLbmqxtc1XSnWxhZYVYRwAqQ+vkT9Hbm3hI7sBZHKEpzgZ9nDLMPN7Nvf/XU8IDpEo0TtWDt5z+CN4tTTRqkUShUUx0PACR7BZORHDR3HiFDr0cFO+WNaCD7J1JNaSsZVdqM2FMJxUZzP72T9t/PSpuSskPQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(22082099003)(18002099003)(55112099003)(11063799006)(56012099006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VlpwMnR1TUwxMFZuc0w0SVVwVlh3Y3MzWVhrVndaTVJzRXo2QXkrczNhbUJW?=
 =?utf-8?B?d1JDYVk3NUJteUNaY2hCeklyZmFBQi9lUkhvMTIydzVRdUF3Q1ZPOGoyajNo?=
 =?utf-8?B?b0FhaVdkYnArOWdwR1N0cWJtMHgxYVlaL0k2RE1wR0hqdFFNN3JVSWVZdUUy?=
 =?utf-8?B?dk4zU0ZVaml1N0xKdFliZGV3OTFtQTRhR3dsRUNTeDdoMThZbWNaa2JXbWZR?=
 =?utf-8?B?eUQrbzdERXhORFB0eHRmdkVuVnpHMFJKa3ZURG5zVmlCRXVRdEVaYnhWNTE2?=
 =?utf-8?B?c0ZBWE1NWjUyM3cyQWtPRG9oL3BBSnNhWk1EekZ4MHpCUGFHYlZPVTdJVDMy?=
 =?utf-8?B?Z2NuK2FQcGdXQ0JYdEVLcHIrMksvdlRPemo3Y1B2c2RmdWxMWjBRT3VldU1q?=
 =?utf-8?B?Q0xGamF0RHRpbmFKTnJJdU1lMWU3ZENkWDhtbVJQTHQwTXh3a3JTamZvMTVn?=
 =?utf-8?B?WTFBd3B0akxpQTdCTFNyd0dmRmRzbFNmNEE2MkdlZU9TY2hXSm1weXNJVFpk?=
 =?utf-8?B?Ymk2a1l5alpWdG96MlAvZm1uR21XYUNwSk9ORURRcUlLOW5pSVZhczFJVytW?=
 =?utf-8?B?RWRETm9NVmRac0JFTHNyRHRhanZGVG5rQ3RkK3lhclR2TWRUQXZheGkyZmIx?=
 =?utf-8?B?a0xiY2p6UEhibHJQRVRGSkVZd0c1bjRMWlNUSDgrL2lRNGxhZ0g3VlFBU1VW?=
 =?utf-8?B?VTRXK2VwOWp2dVF5OU5uMThMdXJsSGZseVdRL2k5cmNYbG1wRVFQcWI0S3ht?=
 =?utf-8?B?ZkN4MTNmTDJNNGRiOWl3TEtOdUI3QXZGV2RsVDRoellJanBvQSsvTDdiRzh4?=
 =?utf-8?B?ZnlwOWtPVlptdlJjYmU4ZjJZSTdYcUdVZjFmUVdZQndPK1RMRTJ2S0VXcU1o?=
 =?utf-8?B?dnNKR3U1K3V4ZFcwclFPRDlVblN2T1Jqdm5BKzJVQmtlcEdCaitsdjJ4UmRw?=
 =?utf-8?B?aENhQ3Yxbzl3TjVadWZNc2tGam5jdGIza3VNTVhkUHhabWQxUHlJY1lhYXIw?=
 =?utf-8?B?MEE4emdHYURucDVHRCs1TitLUmpiYklDc2xXMDM3K21UQ1pjcDRDc05VVE5Z?=
 =?utf-8?B?RU41WWxEeGZiYWFyQXdrSW5NTVgwaHRMTGpIMGREUEtoR3BQckdheXliaFdx?=
 =?utf-8?B?VU1xWnhROXNDOHdKME1XQU8wa2grT2ZvdGtITlMvSFJaaEFZYWlxNGJKS2p1?=
 =?utf-8?B?akcxdVloZmNQcG9WbzROTXlhRVBRaVVwc2NBUDRNRDVwc3ZwNmg3QnpVWjBa?=
 =?utf-8?B?NTN5aVk3S25TU1FTUXpNb2Y1bjN6QkZTMVUyOGc2NmQ4WGIwUlY3UVE4aWsr?=
 =?utf-8?B?RmdMMkQ4N1p3ak55WTV5YWJDRDlYTFpiZVhTMVZHcVc2MVpzUktKaXZVQXpi?=
 =?utf-8?B?YzJmVDVnZ3l6MlQ4RzVkcXMwMnlRK3ZuZ1V0ekRTNXN6bVY3RWJIOHlIM20x?=
 =?utf-8?B?ejlJZVN1SnhHcmNWcnkwVS9aZEV6SDdyTnNRek1CMllpZXpNR25lNFRrRDlx?=
 =?utf-8?B?Z3ZPSWhxRzQ3dFNFUCtuQU1tOFdMb2QrcytIYzdVNGRVZHZQVG1vWVZJQUIv?=
 =?utf-8?B?Qm45bGFFU09EdHVvSURWNTFINnNDcVk5SklNanJQQ1d6S2YrTGVHNi9NVXpX?=
 =?utf-8?B?MkRCbXZHcnFXbjNVVktjRUg1K0ZwWURXczU5QUtOSDBDZHNlSDVWQjBpNStk?=
 =?utf-8?B?ZzZhdnpFUEdJZEM1bXNjTGdOWjN6RjVQemcycnJzQ29lTjZjbHRNVnE2c1ps?=
 =?utf-8?B?cmxnSCtCa3RuV21ucU1xY2hJWnBRcWhtUWU3SStrYkY4WTgzeUVYMllPWUh2?=
 =?utf-8?B?MmY1aXQvTUVBWlJMN3FINnpXMXBaOHhuVS9PSWtyK0V0R3FmekRCRjI5c2dw?=
 =?utf-8?B?dXlBNzRHWGNzTzVsa21jQ3pxNmNKRHV0SDRvZTdGbUdqdVhoTHRBT3g0VnJx?=
 =?utf-8?B?dEltakVZTE0rMXU1cXpBb1FnVGprVTgyVWZNOXVCbG5pV3QzTjNMRW5OZmZT?=
 =?utf-8?B?Q2FadU15Z1g3TG9NMHRuaGZQYTU2ZllkdTdmRWpYMXpiQkcrVC9TblkvU296?=
 =?utf-8?B?bFRvL1NGcWZPcnhVYnh1b0NqbHlpUzgxQ3FySkl5QXJkdW13N2o3Sm5uclZY?=
 =?utf-8?B?aVVxVm1Db0hnMWVGZjhMRmN4NFlheE9xdVdVYXhUWmF4MHZ2M29hU0RiSWdq?=
 =?utf-8?B?UjhCdW9OSVhQbjYwZFA3M1JHeVUreGlKellVbEpCZlhuVW5neTlzVXQrNjhk?=
 =?utf-8?B?NVhaYVRqYzR6eWdmODl6dWV6NjFHU3UyZkI1eG42U3E2ODlXSzBhY3g1a0xw?=
 =?utf-8?B?dXF0TzY2QkJIRXYwZzhFS0RtWkJMZXBOdW9OejY4bk1hblNpUnl4RTJZblV5?=
 =?utf-8?Q?I6EUeMBXVzoHzQbg=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 240c2e6f-b539-4a0d-a992-08dedcaaf07d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:39:47.4905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xyGzzjoGrc+eAcDWeMAcy59olOVuBD27v27cZiEVg0EEtZn5nv94hUpWuRhUfl9Y8SI3vgt3t+Ig+RC5sp4zhzCZeHh+MwE9R6SXA4ws1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6589
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

On 23/6/2026 10:02 am, Chen Huei Lok wrote:
> Enable backup for data section to support warm reset as no SPL image
> would be reloaded in warm reset.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>   arch/arm/mach-socfpga/spl_n5x.c | 18 ++++++++++++++++++
>   configs/socfpga_n5x_defconfig   |  1 +
>   2 files changed, 19 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/spl_n5x.c b/arch/arm/mach-socfpga/spl_n5x.c
> index 0a8dd6d0fee..8b03d047f33 100644
> --- a/arch/arm/mach-socfpga/spl_n5x.c
> +++ b/arch/arm/mach-socfpga/spl_n5x.c
> @@ -18,11 +18,29 @@
>   #include <spl.h>
>   #include <watchdog.h>
>   
> +u32 reset_flag(u32 flag)
> +{
> +	/* Check rstmgr.stat for warm reset status */
> +	u32 status = readl(SOCFPGA_RSTMGR_ADDRESS);
> +
> +	/* Check whether any L4 watchdogs or SDM had triggered warm reset */
> +	u32 warm_reset_mask = RSTMGR_L4WD_MPU_WARMRESET_MASK;
> +
> +	if (status & warm_reset_mask)
> +		return 0;
> +
> +	return 1;
> +}
> +
>   void board_init_f(ulong dummy)
>   {
>   	int ret;
>   	struct udevice *dev;
>   
> +#if defined(CONFIG_XPL_BUILD) && defined(CONFIG_SPL_RECOVER_DATA_SECTION)
> +	spl_save_restore_data();
> +#endif
> +
>   	ret = spl_early_init();
>   	if (ret)
>   		hang();
> diff --git a/configs/socfpga_n5x_defconfig b/configs/socfpga_n5x_defconfig
> index d706366337f..8f4723398df 100644
> --- a/configs/socfpga_n5x_defconfig
> +++ b/configs/socfpga_n5x_defconfig
> @@ -21,6 +21,7 @@ CONFIG_SYS_BOOTM_LEN=0x2000000
>   CONFIG_TARGET_SOCFPGA_N5X_SOCDK=y
>   CONFIG_IDENT_STRING="socfpga_n5x"
>   CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_RECOVER_DATA_SECTION=y
>   CONFIG_REMAKE_ELF=y
>   CONFIG_FIT=y
>   CONFIG_SPL_FIT_SIGNATURE=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

