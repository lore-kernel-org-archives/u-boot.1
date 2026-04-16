Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB21DF433D5
	for <u-boot@archiver.kernel.org>; Thu, 16 Apr 2026 01:34:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E48CB83C2B;
	Thu, 16 Apr 2026 03:34:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="CyEZvY8o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D641083EEF; Thu, 16 Apr 2026 03:34:27 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6364383B99
 for <u-boot@lists.denx.de>; Thu, 16 Apr 2026 03:34:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=weeGnFOh7vtO09C2KXTw4Py0b6TRBzG5+arj5pHjqx8E0bSNwSwINOfyLhVAMC9EERUxH6erZAaBJ2DQvbZesnFCpsvzORV/ivedJr2E4Ra5xqsEUYBD08Bg7PBNWldehezo1RmY/x52Th7MTnARKE4UGYCU8TB0C+AjBGiivvsSdc/6wkWZQ0+D9YYGHgecbyOnMfQO4PgJMSr/zHtnPZOfWubnBvrkj8xn/2S+fSQaZ2jgQJZJBGi/p3yREh71bxOnzmENZbIXeLPxq5kdsl+mZfkoSjOtuxkgQQ44dalkn7fD97hg6r37R2qh+g4VUXq79NOsisM5hfiwz7N+TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OSiDgMHqdfizxi07Jtt4A6ji1cHfSgJ6Re5P0/FhVBw=;
 b=ttzPohbJqcz5R3jcl53IT+mcekjfuIBztuJBUtZGm+OlKzMkSYJaihceZa2+53TNajsgh9t4ZKiSflTCVnP79GN1zaCNpuOEkqFyzE5j+mnSCoDZr5DdPMe+3LwUpAT3VNz/RGs7cEdmvwe0yXRHWbrU9Gopp6UPUGlJi1IcvEr3hcfg/kFMXzX8POaIpkNbTHpVzkBZ7SeSKdpyeYx/eLUaaC6lb3/rSvyvTKrri+KypS2X9XDsKP8FpTLVDbyyyoC52qIxDDF4GXcRt1CCPKJbnCXISNVLGnB9DrUwR9FsRjjem5EofhiNGqtQIJ8MBVCd2Iix3fvan7WSlcV68Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OSiDgMHqdfizxi07Jtt4A6ji1cHfSgJ6Re5P0/FhVBw=;
 b=CyEZvY8oCy4wxB2KCzu4oF7viI8u9X0sYIjbKs/Vi/Q8qPPWVKjcM8BB0QYIETWq7devVgGW8SvYpYeYFbS4kpZ3Qi1P1d8CNbBRsvWkqxWga/C1yrOVqECwSMh2P5JrrWYPYCcwt1xCsVE0Up3SMLxZSGmOQc244cZn4TDEPWiWZHpIe2Fbu0SDf4sJVxeV4UetsIrgWj5l3Ga91ouAf8GVtUycGx4A6vNNVCqnKCOQSxXozCWhgjTdLTQRxmH6NptyLgJCdeezyZM1Gr2gYHGualuAJv74Pkdgv2x/9lM8RKsAB8hBM9pzUpz9mf6AJAqqILfRDEubXyzgZvStVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BN9PR03MB6010.namprd03.prod.outlook.com (2603:10b6:408:133::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Thu, 16 Apr
 2026 01:34:21 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9818.017; Thu, 16 Apr 2026
 01:34:21 +0000
Message-ID: <e8cc7683-8347-48ee-a5fc-9c545b7ba968@altera.com>
Date: Thu, 16 Apr 2026 09:34:13 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm: arria10: Add correct mask bits for RTRIM and
 PU_DRV_STRG
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Michal Simek <michal.simek@amd.com>,
 Kok Kiang <kok.kiang.hea@altera.com>, Boon Khai <boon.khai.ng@altera.com>,
 Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260304041246.17900-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260304041246.17900-1-dinesh.maniyam@altera.com>
X-ClientProxiedBy: SI2PR01CA0048.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::17) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BN9PR03MB6010:EE_
X-MS-Office365-Filtering-Correlation-Id: 04c1fb6b-e024-430d-3283-08de9b584869
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|56012099003|22082099003|55112099003|8096899003;
X-Microsoft-Antispam-Message-Info: rEXJPGg3jdF1H4G43EsAXYwgwJgXr3sdVwMJfAOiKIMA/NO9XO8CThbDxnuUCgfNbZZGxIIfJoKq98xsv9jD4Rq3SG183yKglProW1ihcQlkGj5GfRmTIURCw30oFQVnuli10GeHFoQQL11xryz6gl7XqKTdD2zqpoJIFoWpwYN/K9PidqEAU0AOE7/GIzQKpCQat7SoAoEN8/S+94BNF3nPbY83M1pAqLl6HyXlK780DckSKB9cy33HBxa30XQGQ+m+RbdX6J0u0oEHEh9i9//0eG2GSUFKG4sE4CYuheOunc0rRbWeacliJZ4DFnYEkCu8LWM6V1gLnRY8wv5mMcHyMjqkV2AwKagJ5/TcPUu7U/pqzeFjQcAMOO9UVxg+bVbEVwunP/ctaAfWbZ0teq3DqxxvjQnKGFEfyhplq42iNl4eMVjMolZ8EgOCPxF2L6Y2Dlzjn2OFewd1S79r+wN3PZ5KVwFn5oSa5nDEmoduyk2FuTWcPE+IgnzyLptz9DX1Ha8PZ3YpfM78l0a5A+UPPEXRb+Oneq+YK04RhNQ0Y+0PeSTmtNVZmJETmYD5kMvC9TAF/TAoTYWITss0XfZ/9Vpljni5SI/Rw33I3g2CcPr5KDieNzZlSALVXrZWs7cED0WVKb0NPwfVtPaxYJFLC8UWLNerehKhyOaORiO0CuWxUSiBH04fgYw+6TDmSNIGpCqBB5avEsPxa/qBOa6rxsA2aWSgWdsYoxfPcRA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(55112099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M2xlNlJoeFowbE0ycWtsZjZxaGtndWFzMHMwamNUOWdTK3JqWXQwQ0w5MXV4?=
 =?utf-8?B?cTNhQWZXVzQvSEpDQ2s0aFpaYTRkditaVUlPd2ttaXB3MDhXVi81d1d6cGFI?=
 =?utf-8?B?cWJQT3h3eGk0THc3L0lrU3VMbDM4T0tNckludmd2b01YVmFCZC9jU3YvbGdj?=
 =?utf-8?B?STdCTXNoV1Zpc1d5QWR0Z0pJYTBzN1FwYzc3dkxyMzEwcmViWVJSdGY3NUl2?=
 =?utf-8?B?Z2VKNUgrekVLR2U5cnNwenk1YnczQ2NkZkdaalJLUFNhcGdCY0UrRXZSRTgz?=
 =?utf-8?B?UG1sMDI1aHZ6N3YrSFN0UHE4UXZsSnNpbWRUOFFUb0pObWVsbUVyQnhMRm1r?=
 =?utf-8?B?TDZib3poNmtSOUZNSjdvODFocUlJZ2hrL2luUGdiUWJNWTNJV0F3b3hiNXB1?=
 =?utf-8?B?SFVBcXZZT0E5S0ZUT245S0ZpY2pvbHduRWNIc1QvZEsrcExCeDZ0WWNRMURJ?=
 =?utf-8?B?Q2NJT2hFZ21jNkRyYk1UMTlXUG9tTTZWNW9JcmZpbVlIdVk2bVlCYTN2N2x5?=
 =?utf-8?B?NnVOYlYzcmIwMitQNlJTTTUrQi80N2p6UzhQODllejlDcTZzb2lYK05JQzhQ?=
 =?utf-8?B?Zm16K05ocGUrYnY4WTh1OWgvWmR3cVh2bk1ZMmtqb1pJRjhlRHBIbkdhZnZH?=
 =?utf-8?B?ZmQ5STBRNFVOeWhEUXpGdnQwTWplN2h0QmxOQlZRdGZIbnRkdloxZDhXN0x0?=
 =?utf-8?B?UWNjWThPM0RoaDg1V1pob1pzV1ZnMThxM2NxWm4rblJnWGlyNzdURE93YnF2?=
 =?utf-8?B?WGFvWUJLMm9zQ3FNNlVuVVNKVEg2Y0FybGVhRm8xaVVQQ1JhRExjaUErQ2tm?=
 =?utf-8?B?QURzY1FOSUxzSk1NMDB5S2UweUNGaXFkSlhMUWVPaE9WSlc5bjErZ2dodzF2?=
 =?utf-8?B?WDJoR0ozRFZLUnhhWFJWanlRdUxybWhlemw1MVMxT2ZJb2RkOStNd1pVV3Vj?=
 =?utf-8?B?MXRPVGNyUWlrdUt5d2wrTTdoelpOdHFjKzhiSFNadENOUHRKbnJUVHVYNWE5?=
 =?utf-8?B?VjkzY2hvc0FKRllTQldyY3VYMTg2YmUvR2xqV01xUWJUd2x1OUlPLzRJempx?=
 =?utf-8?B?SVR3WU1yS2xKMTFhd0F4dll2dWMzZmhMdHM4cjRpbTZIeVhDL2V5Z20zaytW?=
 =?utf-8?B?Sm9ncTF0VUxvZUNVVzVmd2NKVGRvS3pZQWhDeDA4NUprZno3YitWUjFKdmtH?=
 =?utf-8?B?bWFtdnRRUnF4TnpkWHdEcU5meDBQU2xhTDExaFNBSFJKMkxkc3RPWmZ3YjNR?=
 =?utf-8?B?VWlCNWZ6QkphaldOU2ppTnQxUjhSZGVwbWFKNEtlYzFncUNoemsyMzNsQkdS?=
 =?utf-8?B?ZUdjUEQwSWxqMnhUUkU0ZkVtZCtHb3RiVFdFWDZ5WWIrTDJVeVZDdmNYeDFZ?=
 =?utf-8?B?WGdyNDZpTlRlZlJGM0V0MzFLVFByaUlUb3pnai82YlJTQlZJbld3TG4ySXgz?=
 =?utf-8?B?VmJHMXhOYUFvTEd0V2lNSFQvWC82TzRJelV4Yml2MHBXNDdHdVpCd01vVzBD?=
 =?utf-8?B?OFZYbHphcE1JcTltcTduNHY1SXRGekljcXYrZVlhZnRjaUVKRk5lMXBPZlQ2?=
 =?utf-8?B?c0pyZXZEUmNzSWt6cFFQVVlvZzZ0S2d5TkFYMW9CUWtUUGFVcGFPUUJ2ZExz?=
 =?utf-8?B?VDJ4aFBNa1dsZ3dXeGJPMFdtaDFHa2hrcFpjTkN5M3Nwb0I5aitUQmlmZTRy?=
 =?utf-8?B?RWxGV3hQYUYyREVqSkU5NVRIdWdGM0I4T2F4aUxSbVJFNmNHM0pINlZTTWRJ?=
 =?utf-8?B?amkzd1d3NlJRNzhZMmtFREVSaDh3TC9oRWkrVytFOXAyWVM0bHZXemtUTVBz?=
 =?utf-8?B?RXJWdHNGc0dkZGc4MVZ5Vi9SZFNSdWpGRXNmczBpWlRydHFtWWFXU0VLd2V6?=
 =?utf-8?B?bEpzYk1yQlhKbGt3Q3pmZDFwbldzaE93Sll4MmRNVFQwMk41emdoTWlZKzFV?=
 =?utf-8?B?MkoveW9JNzFpN29EUjZkYVBMT0gySVV0M2E5OGNzNGZVTUVPYTE4OTh4azVD?=
 =?utf-8?B?TzlnZHo0cDdCNVBoS0JseEQzejN1TWRuWEUrckdJdHdSZXNXemIrdkxDZ1k1?=
 =?utf-8?B?M0NQUXpyOTNDVmdKc1pNalUxUnF1Lzlya210UmU0TEtDSGR5VjBxdFdMSnBr?=
 =?utf-8?B?MUlUWFo1R3hJOWJYaDFmZkpLYkhZZjVJU3N0YTdCNEtpUTdKb0l1ZVNNQnpi?=
 =?utf-8?B?OCs0TzhqQjJwcnQxaFRKTC9hOGhEOVUzdm4xaktVa01FOFZKV3hHTDVqQWZR?=
 =?utf-8?B?K2ttZ05ib3VIc05xM0hnVlJBdW1OSitvMFVQTTZaODlmMmp5NHU0TlhIVFRI?=
 =?utf-8?B?OE5qOG4vTUxZN3F5eVNLYk9weDY4RjlhQXg4YmR0MEViOGlzcEMwdGN6MGdN?=
 =?utf-8?Q?x0A2Oijwtw+9JW3E=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c1fb6b-e024-430d-3283-08de9b584869
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2026 01:34:21.3039 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JAWKv4B7nn86XdeNjGamn4MHOrcsfQu6WxsMHw3c5nkm7HTrvrbXtfEEn/I/lmV1FX800v58UTPX5ku3zsVKPF/ufme2UVd9uNgWn0ZvHhE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6010
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

On 4/3/2026 12:12 pm, dinesh.maniyam@altera.com wrote:

> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>
> The current mask bits of RTRIM and PU_DRV_STRG are mismatched with the
> configuration register of arria10. The correct register for RTRIM and
> PU_DRV_STRG should be 0x7 and 0x1f respectively.
>
> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
> ---
>   arch/arm/mach-socfpga/qts-filter-a10.sh | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/qts-filter-a10.sh b/arch/arm/mach-socfpga/qts-filter-a10.sh
> index ab16522add5..510947d5632 100755
> --- a/arch/arm/mach-socfpga/qts-filter-a10.sh
> +++ b/arch/arm/mach-socfpga/qts-filter-a10.sh
> @@ -106,11 +106,11 @@ EOF
>   	echo
>   	echo "/* Macro for Config IO bit mapping */"
>   	echo -n "#define CONFIG_IO_MACRO(NAME) "
> -	echo "(((NAME ## _RTRIM & 0xff) << 19) | \\"
> +	echo "(((NAME ## _RTRIM & 0x7) << 19) | \\"
>   	echo "	((NAME ## _INPUT_BUF_EN & 0x3) << 17) | \\"
>   	echo "	((NAME ## _WK_PU_EN & 0x1) << 16) | \\"
>   	echo "	((NAME ## _PU_SLW_RT & 0x1) << 13) | \\"
> -	echo "	((NAME ## _PU_DRV_STRG & 0xf) << 8) | \\"
> +	echo "	((NAME ## _PU_DRV_STRG & 0x1f) << 8) | \\"
>   	echo "	((NAME ## _PD_SLW_RT & 0x1) << 5) | \\"
>   	echo "	(NAME ## _PD_DRV_STRG & 0x1f))"
>   

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com> Best regards, 
Tien Fong
