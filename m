Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90BEECD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:49:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F3BA2846BE;
	Wed, 10 Jun 2026 10:49:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PPGOe+Cj";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E02B847B0; Wed, 10 Jun 2026 10:49:36 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7B0778407D
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:49:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrX2mcmFOQZSfthJ/3yIQQ38S9HPdGV+aRI/mKdNYRAKxlKDVaukjc0nXXUtTfuT4zcoDje5lyrG/CtruswHqZP/pNDeBnPaWYVw63zDHLwWjrmJnDDaELCZEQltfxA+qWcxXwBLci+T+bkucbY33NjAWMgjgjDLPY5+uZllj0S+CnnsL55m9wyFmsTU0V/LkDLs5ZIG6uNW8HsC3giOMH9pyoxAJkx/CKtGM4pNRF68HPRDr6b4wzQWM2I1ZsDEgXAFr7PPKQHe4ElQYw11fG+TBiRqDsaXyVDmp6pRk2Ks3Vf9GmC59IfrI6qPz+YiV4BFYvlOYXHtTViw9iWrsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B4BGXtkUN9iZpJe6KMtUl/ruru+n2KVKu6zaEdZYuRc=;
 b=tcMxAd1tDCnulIxGBallqZcw2LoDi4+DqKQZ69k7h7zRrU+0VLiWtPa49LVc27DDpQvo7WGpK/mNc2PvZGjYLPoz7Y8Z7qZq7IecbMdSYYiRI7KvdloDq+kAfgJ3ATF3ozMNDWYpRRjZSRO7B2rQA80MDq5YHvOSvrKaz/Dsy5PFZVm23sWZFA6cjzsM51DkPjCM3JXgX2xwOrmjkRXqb62arzl/no88iSa5q/IZLIOP5ZH57a4ZzKQWvPK2baZOdfPmIvyh74A0TT6nLAZNyGAQMEcoUhzuOl3Fde/CdXAvfw9qs8i4N/mKN9H9iqai+uyYqPQ/xniPtTSkrBcV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B4BGXtkUN9iZpJe6KMtUl/ruru+n2KVKu6zaEdZYuRc=;
 b=PPGOe+Cj6S4eE9uzkmWgE0DYFn/jphXpf/G7mfpER5C2HupwUDVhd+/LOlXbgJDBfaEc8KCUfroEHBkO2GAwg83Uu8zqseNw3Vr5K5HUHP+wSp9NHXM3szfSP0EI6c6L8PrN+NNaA+5Yn3Iu+PBQk+GH3/U5BT+/CbOTNuR4CtyGC6HFAgHFDXxzHCdg0fwcVE8Wd+7aeZa1AC+AQAWMb9NXlLFc7owm0cqh9sZkY44P2+yJjLyYPA9137csHDdPWbv4XoM4eI6wg06r9/sAeax87rsvdeimsSmOBlOQw6ZwrYVB4emZ/CarI2Ni8GngQHE4MyWq3nOzbv49KH1KFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:49:29 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:49:28 +0000
Message-ID: <9ff74265-8ba6-4ab1-92ad-084e40f74eeb@altera.com>
Date: Wed, 10 Jun 2026 16:49:19 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/9] arm: socfpga: Update Stratix10 SPL data save and
 restore implementation
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-5-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-5-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR03CA0010.apcprd03.prod.outlook.com
 (2603:1096:4:297::7) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 9fe2475c-1d7d-49cc-b4a9-08dec6cd2e6f
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: +viOpg5JZq8AjnVnqo8IQugi8BvRmm/Ho0SFeEgM9z5nb40pyYL+GMgXJe6B2/eJj8JPpJO4QQRpr+7XdX5s2M/iDbkKdoc5YiJ8YA+1uxCoqhCBszxOqv7Tmrmci7r9nYqIYfufGKhufQOCmLLPWs0k5h/KeP/AlRUrM/z2Y7n4UnA7WNRFZK0IvSSNtpEGH0DMof1UBYjNCq6A2gbPGQZF0XWHIS41qqQyOl2jZ1C7fKsAew57I+YcFOU9+mSgKaLDtFTez1RlYs6AGcIZtbo1b5HSgDDMAqB56YQh7Js+Gt9Wx90GaZVuXQWzGpDrQC/vBzyB0SWhRJHdOWj7eddSHv4SZ00icw4m0qdmw0CKZDK9f0joEXZa5eatHhkPNs1TsIpzOZm9OhuaXw0tXCSOOWdZs7jPzEZw8fdwOwSsqjHB0SHeakf1JZtajuBEwsxmv57EaRASZvZ0Twq3pi58VowrtRdzNdAMMOZLMFgIbPXgP+x3aYKWvL6vYRN14deSa6DzgBHYZtxZsEo0qpBDtO2NeqM6kIKk9/R/M7egYj69r7p+qIVY7+eIxBJci06gBe4hASIGkdcrS3CFjOy90/7unfYw95AH+h4axOL29XvGunKfOV1y0APAkARivkJg1lkbJc4nwrLNK6BaalLK1h34j9sX39fjfpW9p1dncfBlJY9HQRXyGVaO2qwb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akpiOTVSdXVDeERvdDRZVlZNVUZoOERkUXRiRmwyQUdjN0p0VWRLMTJhS1FZ?=
 =?utf-8?B?eGdqcE1NcCtXSHdFNytlSDBQc0NjWC9MdVdwclJsTGh3MnBzdGYwajMrd1h5?=
 =?utf-8?B?WDZTdmkwY3ppTDV4WWh2V3NWMUliZnZVWE9MTnQxTHNDL3p2K2NLVFE4U05n?=
 =?utf-8?B?ZHNPYnNKbUVjSWgvb3g4N2dFdGVpaFllQk5kQ3BZdDROOVpCOVpUcExoUjRi?=
 =?utf-8?B?Y3IrTWVyWlJwOGJYM0h2NjFFK1Q4Q0xwc2d5MXdtdExBdytIOGp1elRGekoz?=
 =?utf-8?B?bXU4RzkwdE16TlZBY3VCR0gwSlp4V3h4OWovRWpCSFlsNVJVK2JUQytEZUZJ?=
 =?utf-8?B?elp0bjlSVTBFbGJGNjFYQlNvQjRqVUhkbFIyUnpHWitIait2Zzd2K2pJa0VB?=
 =?utf-8?B?WjdaNDhIc1dlZWVla2VhTXE3ZCtHNDRqSEhzVkFrVDNaS2N1RmdUNzE0UlZr?=
 =?utf-8?B?aUFhZ1ZaUFFkYURQdFhoa000OXBVc0tsUVlwWEZLbTR5QWptWjltR2hNTFBy?=
 =?utf-8?B?ZG43Tm9XVTFQbktyeG5qUGdvOVJJTlMyNGtEZmtmNWFnUkFEakk1azRVQ0tF?=
 =?utf-8?B?Ums2MnBBMVRqU0VPbE8rU21yaGxxbS82VkNkOGM3YWU3SWFvdDg4b1ZzNTU1?=
 =?utf-8?B?THI0RysxM1U4L1NWVEFLekxjWnUxR0lUMEd5cG5YTFFidGtTaFpKTS90RkNr?=
 =?utf-8?B?UUJqdHpLWTFXOFZVNVEreDRBUTM3VVc2NDl6OHlnNGptVEdzVloyR05KSXNP?=
 =?utf-8?B?U3BPa2Z4UmVQZCtYU25QMjB2NU5RZit0dUVZVVFnQXVHeUxkU2kwMXlJejY4?=
 =?utf-8?B?WkJ6c3pDSlUxa1hlcWVWWFJBaWZUb2xweE5ISlNVR0V5V2M4aVcvYjZ4MmNE?=
 =?utf-8?B?bEs5Qk9vSGF2ZHc0SGxwdUVscFRzUk1CU2ZWT2U0WkI2bXJpWmYySXZXZStp?=
 =?utf-8?B?RHFKd1NYdXJDcjZPNXozUDBXYkNpbDRwWTIyNU5VMzUyVjlxSzZVU20rMzVK?=
 =?utf-8?B?NlErVW01RGZETGEybXRsRHFLcnNqQ256SWx4S01EdEpWQ0hJRkxsMlpVcjFN?=
 =?utf-8?B?OURwSkNSZjhBeUxtWXFubjk4anJWaHdIdzFoMUdlcUtBWGpxbVF5SW5rU1gr?=
 =?utf-8?B?dHFEeFRmRkJaMmYyMG5mRWFJKzA0U3ZDQ2FYclllU1RZSDJ5TWc0ZFk2cUxM?=
 =?utf-8?B?dHhxSFJoNnF4M1dSMk5JZTBaTHZGRlFjWitqNFh6K25ZV0d3ZFgvcTlEeGZm?=
 =?utf-8?B?c0diNkhNTG5OY243SlBBd0RRbXppYkFaMytwczY0bHlxZm1QcFd6ZEVGWm1i?=
 =?utf-8?B?V3plWDJrTERhMER6N3hRVVRXbnl5YStkTUh0bEwzUFNyaHJrOHdYTVVJbW9T?=
 =?utf-8?B?VHlUeTlnY1VUR2NSeGh0RmxiMXNob1JQTkVOWUFXdFl4WGpOcHpGZTFqOHFh?=
 =?utf-8?B?WFVUaFUxV0phTEN5Vk93akw4THUrSm5Ba21pTVFjWTRudXUwZTJXcDJ4S014?=
 =?utf-8?B?Z240V1hnWUdpTnFNWUcrMlJQVkVEOWdKZC8xWEI2U0RlYW83dEpac3B2TXFo?=
 =?utf-8?B?bFlSa3ZIQ2VqMlUvQWYxNTR0cGxjSFhKaXZ6aHpaRDRHak82M3dqdFB2bFRp?=
 =?utf-8?B?Y1ZLWFJZazhhTkxXV3V4NU1GTGVaY3pHVjM2dmRIYWw1WjVuYVZrQkIwZTRi?=
 =?utf-8?B?RUtCQlZ6YmhXSEhncW9UU0xsajNCelMzS1dpQXpEUWRUUERzQU92bGNyNmwr?=
 =?utf-8?B?WGJySTRGZ2tLckNoRmwxa3BCNGhabHhVSTNCbHdJdDlnc1JaVnNiU1Vkd0FW?=
 =?utf-8?B?Z2ZUQXdLRVRjeXB0ZGRnczJuNjZiaVpuOXB4UzJzZkRUUWx6Z2w0Z3FTZEI1?=
 =?utf-8?B?Wm82SEVYVitBR2xxUDl2U25BVFR3S3VTV2tpcGhPclVBNmVJb0NwbHdyQzQv?=
 =?utf-8?B?Vmpmdm1LMjM5NHJSTGJUMTJ6amVpN1AxN1hqZW5qNU9IeVV5S2NvTUwwMjI4?=
 =?utf-8?B?OEx3d1VwSm5JcDZteWJWOERKQ0xJZEJaL1l1Z05TTFFnZ01adFY0NnoxQVZi?=
 =?utf-8?B?d09qSHcrWFRsZXZWU0NKMGtUOVRFa2xXZVhrSit3c05lbDhScXZybmN3TkhK?=
 =?utf-8?B?QjVEbzlGZnRxNEYrbS9NK0pVQnJKclU1TFdPbFduZTZsQnJ0TkxuWW5SeXFr?=
 =?utf-8?B?eG1mU3IvdEF2Yk5oNHhMcS9INW42bHo5SDZ6cFJlVDVtTThjdG1MMzdaU1dK?=
 =?utf-8?B?SzBYNHNNNjF0K1RPV2JOdWp5bXJqbnF6WHR2OGk0SVZjZXF1UHBPZ3VmQ3dV?=
 =?utf-8?B?V0Q5bVV2OUNMc0lmVjEzYUg2clZadGsweDFjeE5obEhlNlViUHh6MVQrb3k2?=
 =?utf-8?Q?xRJwOg7jNCljo4qs=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fe2475c-1d7d-49cc-b4a9-08dec6cd2e6f
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:49:28.6259 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qHoCp775nx1gGmppg3ZzPN1A8yGgNd6V9qLJUnzYsCQKb7Zw8AeKbJqJzfeLKnAZakfE/gpBw6x7AqqhfeOdIHewI8AbMhGoynn8LFDdk9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6324
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

On 5/6/2026 9:54 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable backup for data section to support warm reset in Stratix10 SPL as
> no SPL image would be reloaded in warm reset.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v4:
> - Update reset_flag() weak function to take in u32 flag parameter
>
>   arch/arm/mach-socfpga/spl_s10.c     | 17 +++++++++++++++++
>   configs/socfpga_stratix10_defconfig |  2 +-
>   2 files changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-socfpga/spl_s10.c b/arch/arm/mach-socfpga/spl_s10.c
> index 8ab80740c6e..00d43460fce 100644
> --- a/arch/arm/mach-socfpga/spl_s10.c
> +++ b/arch/arm/mach-socfpga/spl_s10.c
> @@ -21,12 +21,29 @@
>   #include <watchdog.h>
>   #include <dm/uclass.h>
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
>   	const struct cm_config *cm_default_cfg = cm_get_default_config();
>   	int ret;
>   	struct udevice *dev;
>   
> +	if (IS_ENABLED(CONFIG_XPL_BUILD))
> +		spl_save_restore_data();
> +
>   	ret = spl_early_init();
>   	if (ret)
>   		hang();
> diff --git a/configs/socfpga_stratix10_defconfig b/configs/socfpga_stratix10_defconfig
> index 82f0cceafb4..be0c452ead0 100644
> --- a/configs/socfpga_stratix10_defconfig
> +++ b/configs/socfpga_stratix10_defconfig
> @@ -3,7 +3,6 @@ CONFIG_COUNTER_FREQUENCY=400000000
>   CONFIG_ARCH_SOCFPGA=y
>   CONFIG_TEXT_BASE=0x200000
>   CONFIG_NR_DRAM_BANKS=2
> -CONFIG_SPL_LDSCRIPT="arch/arm/mach-socfpga/u-boot-spl-soc64.lds"
>   CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=y
>   CONFIG_CUSTOM_SYS_INIT_SP_ADDR=0x300000
>   CONFIG_SF_DEFAULT_MODE=0x2003
> @@ -19,6 +18,7 @@ CONFIG_SPL_BSS_MAX_SIZE=0x100000
>   CONFIG_TARGET_SOCFPGA_STRATIX10_SOCDK=y
>   CONFIG_IDENT_STRING="socfpga_stratix10"
>   CONFIG_SPL_FS_FAT=y
> +CONFIG_SPL_RECOVER_DATA_SECTION=y
>   CONFIG_FIT=y
>   CONFIG_SPL_FIT_SIGNATURE=y
>   CONFIG_SPL_LOAD_FIT=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

