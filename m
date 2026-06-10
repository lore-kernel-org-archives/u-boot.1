Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260A4CD98C7
	for <u-boot@archiver.kernel.org>; Wed, 10 Jun 2026 08:50:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ABF6A80087;
	Wed, 10 Jun 2026 10:50:53 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="LUMTdxpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2C5948407D; Wed, 10 Jun 2026 10:50:53 +0200 (CEST)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 260CC80086
 for <u-boot@lists.denx.de>; Wed, 10 Jun 2026 10:50:51 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T9czZ2D7EIOrhHHGNgsDBlqd9gRRF6KxLRQP7opn0Ss3Rub5QpTHItec4wL63D+76tHKUS6FnPyzaDD7s0iW4ehwkOnMmDE8XXhSznGCXiywpzl+ecyosjwbHFNm2nEFc2qVfS1F2SnXGTxZpBSBhymNa7N9bdmC/kFuwjT87WZ7zv3Hpqr2NpZ8qX6Pl6P4NndbqeXz/0czel0YEznz6mRd2hg5cOBoXgy7lPu89NBvSQqEYGSznfU9wTCGJr0ZhmTxVq+PjQi6Uo9GOv/0VlkuPDyy2j3lvaQqZR1gcgWlfsUeKnDbL5vfXjTOFeEJ4ZJvQPJ3kLeCHqo9ExFMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pjummMSl/GGamVRFrJjQxcan89sBlg57apmQTneOqU=;
 b=kPDoa+R2z6TIi8QuZ5A2+ke1upfGwQrdqQhsmQY3zUyzXKEC8F4DGa4zvSWHuJwt9+jbqlgG5Dj+ogp1Fmy3jaiZNCnTHfiiFry+WpA8yxAn8nufSWi/tb4Soe9SibYnP3RUtValioyJfNDw7Bj6M5NDUp4iKX+s7Z/qoHNGxL2r2CsTUWppJckgYFGvjOtXnwAlG8RdwlsmyEIjJzf6raIH2UCU7tLpVwD75dOtDknnLbO1sfKRReY9KiVHMXGu1LvL5g1KqlBAFT/foYoFEcaIb0v5s7gqp+16FIQnNKMpZJmKIJAp+6V5QRlLymapWJgVlnQj6oHfwu26+UmzLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pjummMSl/GGamVRFrJjQxcan89sBlg57apmQTneOqU=;
 b=LUMTdxpt7yzxdEe7rnSIiyuA6jxWK3LhmEhsNSF2i440FyVHS6ttK0h3ilf2eQDLleOQiw81hn84cHVZntF1S6h4+CdQnQALtHp5W2Xo+zwPjaPcDBIKV6i28rOHRtkCDo7+DS2U3jrj/DLI3k3EE6Hcgt8cEGTV2FybMjOqZXE4rdNj/a9OsRdNCnYkdiHOhYF7oVSy6s2nsjJ6eJeOOk1Z9kg+7GbKoDf19bjrJt0Cqx0MBR0Ab2gfgQQ2lj1PNYbeRXnSw4JPSxwJBO8wejeWx2054gd26lp7icLYMeN+QJJTMfXfGZ6zJXQ/KAI3a9Juw1anvq9kKlr69frlgA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by SA1PR03MB6324.namprd03.prod.outlook.com (2603:10b6:806:1b7::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.14; Wed, 10 Jun
 2026 08:50:48 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 08:50:48 +0000
Message-ID: <4ec56a4d-0c7a-4445-888f-d6abee2b4e7f@altera.com>
Date: Wed, 10 Jun 2026 16:50:40 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] ddr: altera: soc64: Add secure region support for
 ATF flow
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Lukasz Majewski <lukma@denx.de>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Simon Glass <sjg@chromium.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>, Yao Zi <me@ziyao.cc>
References: <20260605015503.11709-1-alif.zakuan.yuslaimi@altera.com>
 <20260605015503.11709-7-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260605015503.11709-7-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI3PR01CA0002.apcprd01.prod.exchangelabs.com
 (2603:1096:4:296::9) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|SA1PR03MB6324:EE_
X-MS-Office365-Filtering-Correlation-Id: 76c26959-10e8-4548-98f5-08dec6cd5e04
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|7416014|55112099003|22082099003|18002099003|6133799003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info: Rtz+ribxbtc6YQI5t2y9/Nm6/puDfzGe413s5nhKzyJoGTlmIK7nnjvgC9YWX+1WV0Omxp9B4RZzE6yuU0/zd1AdpjedsqV/eENPCBH/2sDTKRI0DyKfNFCz6t0qhIFj3sDKh2i7g2HURo2jKUUugwV+KgwV1uv3htCdyz9LGwcFxBPWkQwJWKJnhIc/TysKrT8z+0BzQqCgiuCgab141Su2bW9U0k/HWjHh16e612PYuiL9BubsrWsId9pYgOsYFgAe14BKbTk1Rou9BO5W4PpGiwWBmyufigg//6FjxrREPo3kv4LltxYldMzPX0JQKkOW3gO38WPqW/gITKgX+ETMfzvFrGjc/Ov8uBnd/H6Gg6JBT/B6ZAPTuqpUH9R4gL12s0W5X4cWBz5kZC5E5xx5mfHX25Cz2F1L5+d6BwL8H/Td59mVmWNoJpv1IsZEC7CyApGsRODpAVCgHWvWlhJvukyLVdnahbOxEzu4Ohw7TICNg16ENOFGTwPJRX76WYMKtQh9h5m5ihpX/nrovWCv4pSiEBLwrSEZwxFXAfT3++C2R6SLFfhJbgqJ1C7lxUJau/uBFFcHOmaovIknjdBELKoLyKaV6qZzIvEWKrvanDMNJR8FwMk/L4yIEpVzmne9O6MzpZyVXSNE+YS90kCBJNgW9dz3cPC9wApdyU0LEeO76z4RcYfiGfP+XzX9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(7416014)(55112099003)(22082099003)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHpncWhTMzNRQmlVK0R3aTdUS2FxcmlhOE4vb3BQa3A3SXArWUFrSkRCdFRS?=
 =?utf-8?B?ZmFiODBQYzBwUDBvT0lvMklCaElGYUdiSU54K0h3SmdnWmUrSFB2TlBBMzcv?=
 =?utf-8?B?V1NrR21EaHhxNkgrTXR2clc2N1NpOStaaDduWFh3S25NOXhYYWpDZ1NIUldl?=
 =?utf-8?B?eFpqVmFjUm1tdCtqNTM0UkNqS3llUGRONVpoZU5NUWExZlJINkJSSE5DVTBZ?=
 =?utf-8?B?UzJQeFlheEZaN3N6MEhEdFNaajZzNCt2a1FsaGdyRDVSVFdRbmhkdEV2Y1kw?=
 =?utf-8?B?eExkRHUxbjFEV1RRUDdMTlFYWnh5ZUVxamhnU3NreS93dUNzSU4wdjU4UEQ4?=
 =?utf-8?B?SzliTFU4b2xaM2xuLzhpcWhSN1JnQWJvTWpHZ3B5S2RkSDY0OGNsdmxyTFRU?=
 =?utf-8?B?NDAyamhNVUZvM0JyWWxncEZtRVp4ZE9aYUhuT1d6THRzYlpZOStRU0pQL25E?=
 =?utf-8?B?aXB6RGl6eG9VQzU2RWZBRTNkc3N2cmFJZ2dlK0hySHY2b1A1RFVzb3RWVHNB?=
 =?utf-8?B?T0xKQ1pNSndNRVBGejBsbWhLdmR3VVNhc25hczMxRGtsczM2TFRMdlY0K2Q3?=
 =?utf-8?B?V1FIRGZCYUNlaVFnV1lnZGcwTncwR204UFdwOWI1L2lPdWtkY1FyUzlra2FX?=
 =?utf-8?B?Y2pvY0NFdVN0MGt4anZVc05YZXhvMmllUUZEaW5uUjdWaGxZUmVjVGtmbUJp?=
 =?utf-8?B?ekxtOVN2VWZHQ016UHpzZlFPK1dDbGtON2hpT1RxeXJidzBwTmZqbG9xd0w1?=
 =?utf-8?B?M20rWHNCTmhaT3FZdjRYYnczQjhBM0UyeVhKYWFlUzZiaDZSejlhTjBjeDho?=
 =?utf-8?B?bjVXdUp3dEIycWR2NE9Xb05OWnQ1eklKbFVqb0YyZ2dRK2lMVTgrNi9GTlhX?=
 =?utf-8?B?ZkZnNUdZR3B3R21IQldSa0pEVENlbWZrcWMwZlpVRGptcjgyd0txa1ZGZGdT?=
 =?utf-8?B?YkpMaU5vZmpSL3lKblRVU0JWb1AxNUI5TExRTExrdUZ2WENyNHM3b3NMNVpD?=
 =?utf-8?B?a3ROcDZTeUh3NStyTTV4eE9UUWtYeEVDY21ZVmFaTjV4YVpBbFFkTHVIUVgw?=
 =?utf-8?B?aTVZeWtFYjYwL2JEcHY5aUZZUWljQVFlWmc3YWV1UlBLaTBtV1M2eGhmNmxw?=
 =?utf-8?B?ZEtQL2s2TS9tREs1UUFrVjRRVXV3TU45QXcvR0ZkcVZhdDVPVkdHQXZZSksy?=
 =?utf-8?B?cmdBRUgxZVExTGJ5bkxCU2p0TGw5aXRuckVQdER1WUF3VHQ3RE9wRFNtd0la?=
 =?utf-8?B?KzRJem5vdk1nRjg4bllEVE0vNEpheG1RYjBOWHdiN0dEdjFobzlleHZPeHVt?=
 =?utf-8?B?ZHk3aDBhVW1YeTJtSEdhTFRMTzlGVHBvaWlFeUhBcWhSZGQwVnZnUTl6VUQy?=
 =?utf-8?B?MEk3WXFGMndHUUoyd25OaWt3b3VjZFJJVVRxbmZ6MDhNWWx1K2ZBbzFXSkVr?=
 =?utf-8?B?KzdoSXBVU1VwZ0x1aTRpOHNNdllYRWFoWHd6WVlIU2tVK3ZlejlEVnRENWts?=
 =?utf-8?B?MTJQSFBNSFEvT3pUSm1FTWEyL2hSVkloU0FCUlNzdTFlVVltZ1p1bGMvMXRq?=
 =?utf-8?B?UkdEYnU5WUYrSW5Vb0ZzUFREQkZLM05sZ1FvSDRUWXUwaGlBRVZqNU1IMkdQ?=
 =?utf-8?B?aGJiM0hVSStyQW15V1NHNUswakczTG1kajlVNWhQcTk2bHFZdXcvT0tZd0Rs?=
 =?utf-8?B?OXR1bGUxZjZCSVZ0NjZTVmFoeHlKVFd6VmtqQjMxMk5rQ1RCeWlycERxVzZz?=
 =?utf-8?B?RmQzVDRIRTgrZWJMYlNtMVRVOFhXY2FJS0s1YXdlK2RNQU9VOFBnVkhWVGxw?=
 =?utf-8?B?YkV3aExKWnZrMW9WbTk2S3p1VW9MTmdrVGUyQlJlN2RnSWROMmF0MzUwOWlD?=
 =?utf-8?B?dGpNN21BcEZHUDc5RGdwN2ZYT29TL3NWbE8ySlhMb1RhQmtIWGVNZWhHWEY2?=
 =?utf-8?B?UTliMmpaNU1XcmU4V2xKRThJR0NFamNKcS9jMW13L3F5bk5zYytPRmpvVklP?=
 =?utf-8?B?ampIYVFCVk1wWjVxVWROUHJ2cjVCblhNdjVqcldwWGVQZWZnUGxYaUdNc3pW?=
 =?utf-8?B?dFhCVld1Q24rbHhsNkIvTjkycjFqNlBmVlNTRzdrUmZkWi9vaVpKYlg4ei9v?=
 =?utf-8?B?Y09rVWdlc0sxU25rRnRyQUpYaUNDTzBQdU5FN2h6M2FjV0dvVWxjZjVtT2Ri?=
 =?utf-8?B?S2tSTFZNOGFOUkg2VDdwaERSQWJOM01xdGVpQzF2TlphNVV6bjdON0NEWUVy?=
 =?utf-8?B?b2QzVTZEYllrQnJ4SzdUL2dVa0kwbDhSQXJqNW9sb0QydStHcFRENG9QNjhF?=
 =?utf-8?B?a2tDZ3JxY0hJR1RSU3NWZUl0MXFnSnV5TE5TVkpmeDljSmtkQU5US0FCRUt0?=
 =?utf-8?Q?aPa4Qbqkcth+E77U=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76c26959-10e8-4548-98f5-08dec6cd5e04
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 08:50:48.3772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZzGHQallWWZj5abr1rlty/KDGM0eR9P6d7ACWps104PVYRM7KKDy7p8mjZjR2cm7QilzZzUyg3WHr9ssMAalC+QqwNYy+ukY9EW6rQIt8zI=
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

On 5/6/2026 9:55 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Setting up firewall regions based on SDRAM memory banks configuration
> (up to CONFIG_NR_DRAM_BANKS banks) instead of using whole address space.
>
> First 1 MiB (0 to 0xfffff) of SDRAM is configured as secure region,
> other address spaces are non-secure regions. The ARM Trusted Firmware (ATF)
> image is located in this first 1 MiB memory region. So, this can prevent
> software executing at non-secure state EL0-EL2 and non-secure masters
> access to secure region.
>
> Add common function for firewall setup and reuse for all SoC64 devices.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v1)
>
>   drivers/ddr/altera/sdram_s10.c | 16 ++--------------
>   1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/ddr/altera/sdram_s10.c b/drivers/ddr/altera/sdram_s10.c
> index 1497a8e4aab..aed53ae58eb 100644
> --- a/drivers/ddr/altera/sdram_s10.c
> +++ b/drivers/ddr/altera/sdram_s10.c
> @@ -78,20 +78,6 @@ int sdram_mmr_init_full(struct udevice *dev)
>   	phys_size_t hw_size;
>   	struct bd_info bd = {0};
>   
> -	/* this enables nonsecure access to DDR */
> -	/* mpuregion0addr_limit */
> -	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMIT);
> -	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_MPUREGION0ADDR_LIMITEXT);
> -
> -	/* nonmpuregion0addr_limit */
> -	FW_MPU_DDR_SCR_WRITEL(0xFFFF0000,
> -			      FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMIT);
> -	FW_MPU_DDR_SCR_WRITEL(0x1F, FW_MPU_DDR_SCR_NONMPUREGION0ADDR_LIMITEXT);
> -
> -	/* Enable mpuregion0enable and nonmpuregion0enable */
> -	FW_MPU_DDR_SCR_WRITEL(MPUREGION0_ENABLE | NONMPUREGION0_ENABLE,
> -			      FW_MPU_DDR_SCR_EN_SET);
> -
>   	/* Ensure HMC clock is running */
>   	if (poll_hmc_clock_status()) {
>   		puts("DDR: Error as HMC clock not running\n");
> @@ -284,6 +270,8 @@ int sdram_mmr_init_full(struct udevice *dev)
>   
>   	sdram_size_check(&bd);
>   
> +	sdram_set_firewall(&bd);
> +
>   	priv->info.base = bd.bi_dram[0].start;
>   	priv->info.size = gd->ram_size;
>   


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

