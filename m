Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB20CD98F2
	for <u-boot@archiver.kernel.org>; Mon, 22 Jun 2026 10:32:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB21784866;
	Mon, 22 Jun 2026 12:32:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PJk7N+86";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 618C4848DC; Mon, 22 Jun 2026 12:32:17 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FA7984832
 for <u-boot@lists.denx.de>; Mon, 22 Jun 2026 12:32:15 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0+LyvUbmoHfblTVjwIJOjv40obXWpGHmyOEGHW8h3OjPzWUW/gwESBsj9t12+KodjC1KgqxIQfmoEVZoaiGYUT08YsHYFDCCyu52OgzUgQc7KJPJTd4Pjkgr4TH1EQfmMGAbjlIGgp1Tq6yOS5TnK88forzqfIUtN2GRLfH9s2DwJ9BfItAj+uz3WSoz1Rt6Ku/k4AuF9bxFRKiGHVLmDnPb9cmpK8oEBxZGfH3ITntyl1a7A8XWLQHHchaeFGudcI0zwEWx/QZMQrfOk946S3mk2oU5ZePxn193guAc2/eTA5uyON9GR9bhxLbIjEQgTnrE/wlIXX5rd16uCcdQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SCQ3g058F/cUg5Rccljsy0ehZX+JzTKsVt4FqYVGMOY=;
 b=BFD3AOC3kls0kvfWrJcX0ZDzUnzmAlc+9YbwaoPb+BlqIepm+0zGJsLvwDy+Thy7cnHzHQ4lNqhujZ+uVKg/RDNKBJrrZhyzbu4gki7n4tdWwDZ00AR6E9QiPzyaFU5KtdYZoquu9nOd8ytu24CQOymxZw3KMPnpvoKwvHlxOLNkmtGsImUi2lQJI5+ihXbdZGSm1Io6kSTWTcc18hA/b8DKm9G50oneZpzNCmRl/S7m7XgsytU8MwmuTTES3G+tQ0sxhZ59Z430LXMu7QS0bO+aV6HE8R26R+EYLexpfec7A97/tnBbJpvsSToAptraCAn7kWRNKlH6y1COz1aTTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SCQ3g058F/cUg5Rccljsy0ehZX+JzTKsVt4FqYVGMOY=;
 b=PJk7N+86Md/7WFm+etEKAkgiq0OqHJf3+CflYV2A8/FfOK6FjWQ7p1vkkFHrNnmJ6BWKBIF8GJeN/nPNbiKI1dnHYCmmCdhmMByBr55u2JtaZC4zIn5IxstNxzzqxXYBM0Omq9xRtCoMn1FtNnDK/YgNzucW9mkPrKMmmvBQrncLXZo8vRD5gaEMNGaodX+bFl3yEAvE9VT7kXqoJS9dLEmZVpD3iN7e9mu1OQPIcL0C0JC1XEcs/rHRJR2ner8cWWn6pZFRZkRrKz+OHewn3MND38ibDurwF13ecGXoA6CyHG/RMNIexkd3BGzBMLorbHV7pjp1J1fHk2cngGqH9g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from CY1PR03MB8121.namprd03.prod.outlook.com (2603:10b6:930:106::16)
 by DS0PR03MB7773.namprd03.prod.outlook.com (2603:10b6:8:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Mon, 22 Jun
 2026 10:32:11 +0000
Received: from CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0]) by CY1PR03MB8121.namprd03.prod.outlook.com
 ([fe80::fe3c:a06b:8724:fab0%6]) with mapi id 15.21.0113.013; Mon, 22 Jun 2026
 10:32:10 +0000
Message-ID: <7a41a912-1fe5-461a-9b20-60c38a92040a@altera.com>
Date: Mon, 22 Jun 2026 18:32:03 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] arch: arm: dts: n5x: switch to using upstream
 Linux DT config
To: Chen Huei Lok <chen.huei.lok@altera.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Dinesh Maniyam <dinesh.maniyam@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20260608012741.23760-1-chen.huei.lok@altera.com>
 <20260608012741.23760-7-chen.huei.lok@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260608012741.23760-7-chen.huei.lok@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI1PR02CA0038.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::15) To CY1PR03MB8121.namprd03.prod.outlook.com
 (2603:10b6:930:106::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR03MB8121:EE_|DS0PR03MB7773:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dfaba1d-5e00-499c-fa5a-08ded0498420
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|4143699003|11063799006|56012099006|6133799003|55112099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: e2fid06YWH7Tuu77arx0e3lewpnnK/IcQf+HuKEI2ZrJl+eqWO6nS1cpp8zj3fLKaV3Boy4dGsIKcwoxWuXEoBuD7nZ8YlUPKOCvSQdVg6DEuF52KssY258ePUIivx8mnlppaDdSpgddjh7pu1VaFbUJ2n/LGqFDXBs+TpMqUr00S4HUxM69Fn3KAzUQI6CKP9rXx6YMKsJwHZ9GuQHsZGdkmgVG3ZuBLbg2t0m7/n7mkyN2B2ZfPZr0fm89FK/HAMwJTCXJ/NZdnhu6j1jllKF+upK0BlrlKHPikin71EsofUpRL7Q54M+pDkTQyBedN1qwYgTDRH+3TnKWZtHM4DWj//XsK7p0yIZU8Kb6ld7EuTLbbX6hPn3oZcRP1SvG8L3t88fyVoeBiJWytJyomb15by/JDI4Y5xUgfmgVH/rhO/XOX/TJzuhICy3E/sHJRbF2HxV2Y1hjQlYMdq5+CtlLACqyJVmw+DMMxhSYNy0crSHL/YwnWAsVDbHksnQW8jtUV1NbdWiAfZz/cD9il+1yt682jHBUM3I+nvcqfN8l0SUSrxgGRKxaW32+hyjXqdj5A7eb8rROcN9XnHlChVCOuj+S25nFjVkm3lKtmDKECJwEZufjjcC+bM0zdygdewgTtSmvjxzGwpjWe6FdN2pRUGFGk62AeopnrF9SH3U=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY1PR03MB8121.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(4143699003)(11063799006)(56012099006)(6133799003)(55112099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDdEV1UrVkxFM3B3T3d3a1ljRitzaW84NllwOWVVZGE0VDRaOHNDMXlnOUZq?=
 =?utf-8?B?SythRGNJOHBKbGZla2dNcGk3TmticEs4ZUYwMkoyOXo0dVVhanc2WW9nbGNy?=
 =?utf-8?B?YmhSYVd2RFhzcGlJZHBheWwrb1BtakRqbVE1djNRamFIemErNUo5YU5PSmgw?=
 =?utf-8?B?VDV3ejhSSzdVdEppanhCaDVFTzl5bStCYzYrbVQ0LzFvQlhEL29oQ01sUFZ2?=
 =?utf-8?B?YmY5eWNMMk5NQzdlaWMxQ2YrdmtncFl3bC90bmVORitIVzd2b1JGMTJrdHk3?=
 =?utf-8?B?dlFLTElNTWpTdVdMc3ZpdHJQcHFZQ1UvRXJpOXNkbFlVTmRrdUZDeXdoUFgy?=
 =?utf-8?B?TEo1R2k0akM1THh0eDJvQS9ROWxmb3JDS2RSYmRVZGdkNmpaSjBTV0NQSVo3?=
 =?utf-8?B?bVRENXZ4aUlJR1ljVkw5ZGdDN01UWThYSWVqZmVxMkdDN0JHVVVzYkZsZGJr?=
 =?utf-8?B?TGZuaFhUVTVCSFBLZ1ExMEJlOEMwWVRyTm0xZVlmZ1Jpc2o3N2UydnYxRTBN?=
 =?utf-8?B?ZlpjNy9rZjREOCs5MDY3TlpBazZROVRFa3k1eUpLNDB0R01jVi9tOGljKzl1?=
 =?utf-8?B?NExpY2NxTFlaQWJ1T2FRVWx0QWxia09aRHBsQmNlTWZqVGl5Sitsc2ljemI5?=
 =?utf-8?B?cTJ1VlRTOW9lVjZMeUhnUFBIaC9WZHFhVno4S2d2dVNUcFhCL2tUQTRvZ3B4?=
 =?utf-8?B?Q3ZMWGc5b1MwMUVVNGszaVJ5TEJDUW1HVHlqTlBmRnRPQk0yenNieVpCYndZ?=
 =?utf-8?B?RjIyWURtZHdzL1pMaFgvQ09WOXZSUklUNG1ad3JJTjFtVktTWGloc0plSE5y?=
 =?utf-8?B?cW1kOE0xV0F6a296MTZHNVVoTEJTazRmZllqMmhydktSZ1R6VVE1WDhPY00y?=
 =?utf-8?B?Yk9sbW0vUUNtYUNEK252RjRNbWdFeUI2NjdYdVhOQzhDalhUQTA5bkNIYjE2?=
 =?utf-8?B?VWs0dkg3K1BJZDJlbFJFN0tVT05VaXBvSzIxcXFhMm5CQ0pDWGFUSFU1OGdS?=
 =?utf-8?B?ZERFTVVueHlwN0NSOG9OWXlaK2tuTDRZTTQ5Um1sVElnMC9FQXdpRCtlUnRp?=
 =?utf-8?B?V0xDL294RkRjU2I4NTBVUWxGcU5ya3VZckI1RlRCU2tqdlVIUDNvcjJMN0FE?=
 =?utf-8?B?bmtNWnZ6OWdhd1JnakVZeEw3dVc4NXJUdWRtS3c0UG1GdkVMdmpjM0Mwckg2?=
 =?utf-8?B?b1BCN2pyT3dZN3B6M0NIWGkxSk4wZk9QYU80VUhTSkhjL1VDQ3BReTJNNnN6?=
 =?utf-8?B?dm5FQlNoVUp4Uk9mSHN2K0plRGJEZEpabmViSHUrN2ZNbXNnOTlSaEk0cVZ6?=
 =?utf-8?B?Lyt6a3BlWjBXWVJIL0hYaFBUcldmbUxFeFRtc3YyZmJxekVBaWFDUW5ZY2Va?=
 =?utf-8?B?V2docUwvek0xNDNIWVl2QitUbWhRRVpmeFBDWFhPUE9NNlhOc3NlMlc2cG5T?=
 =?utf-8?B?VWY3M2lwdWROUlU4M0FNbXpoWEdCdW9NTDluZVN2RTI4d2ZiQWlORWFNOUZB?=
 =?utf-8?B?Q05SK1FQMEdLMUhjMTc2SjJkUWNqTFplMHk2RGJCUTNPVG1MWjlDdnBKcmQz?=
 =?utf-8?B?ZmNOdW5vcGlMSC9UZGkydnBKckdHRmRZeTBINEswQzYzYW9pRDI4UmtaWjdQ?=
 =?utf-8?B?RGhVNldMOFVOMzFKbUYwellHeDg4QVhhZnVoZE0rVmYxY1ZOU09GUXVIbEh2?=
 =?utf-8?B?eGVFdWN1MjVqOWoreGZMTCt1bGdZYSs3ZmErRTI4cmJTQzJ1UENzdDlRVU9k?=
 =?utf-8?B?ZnN0N212K2JjVSs5S09RSmVLTVVlVWVkNmV4SWRaeWorVWx2V01qOGJhRm9y?=
 =?utf-8?B?ODVDZmNweW9Sb0JoWjhjeTgyd2h6aEQzbXNoKytrTEVTZndnVS9UNjlEUUsw?=
 =?utf-8?B?ZlJBWU1CdnVsam1PN3RoZEd4RnJXZ0ZzMXoxaGMxdVZNL0xhV0FnK2hrejlE?=
 =?utf-8?B?bXlSZUxPL2g3Z3pvT1d2dzVUekR6Y05DM1d6UjZxNmFwZEN4MWIzN3g4Mytp?=
 =?utf-8?B?dUcrYzlaWHFicC82cjVzYnBkVm5BSDAyVHFjUjl0S29YVVZzemgvdEd6NjM1?=
 =?utf-8?B?UFQyLzBqZzVnMGNIMUJqY3I4Vmk3eVllQW16VUVoV0FPVDlGTFNDQVB4L0p5?=
 =?utf-8?B?dzlyWEVJS3IrSzBTTDlocjdyOFo0by9MMnNaM1dnWVpHVHloZ0NGRkIwLzRj?=
 =?utf-8?B?dXhzWjFia0JUTmZ1MkxtbExkc0w2V0VLdmJYSW1pcStSYTFVVk12STByK3pw?=
 =?utf-8?B?aVdzMUwzVy95VWlxMmtraFU0QVloU2pHdzJqdnpZMVJUNGVaMzNGSStTWXR1?=
 =?utf-8?B?UlhLSVZFaEZxOVdhTHpFUmkvTU1DY0FRZ0JvYW03RHByZVFtRjhEcWxwZFIv?=
 =?utf-8?Q?xcZe/LzewE7ExWv0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dfaba1d-5e00-499c-fa5a-08ded0498420
X-MS-Exchange-CrossTenant-AuthSource: CY1PR03MB8121.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 10:32:10.3655 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8dGZQcdypIqmjgVm12voQTXqOHqOxg16Fqm+F99pqHON05z5wvbnX6u49fPPgUGFDHpgVRWNg0xy8BoK+XpEYIEGVw2GWyv7+JXHNAVm3RE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7773
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

Hi Lok,


On 8/6/2026 9:27 am, Chen Huei Lok wrote:
> Migrate the legacy n5x platform to use the upstream Linux device tree
> configuration. This helps reduce maintenance overhead and aligns U-Boot
> with the Linux kernel's DTS hierarchy and naming conventions.
>
> This change improves consistency between U-Boot and Linux by removing
> custom/legacy DTS handling and instead relying on the standardized
> definitions provided by the upstream Linux DTS.
>
> Signed-off-by: Chen Huei Lok <chen.huei.lok@altera.com>
> ---
>
> Changes in v3:
> - Fix CONFIG_OF_UPSTREAM position in defconfig: correctly placed after
>    CONFIG_CMD_FS_GENERIC per canonical savedefconfig ordering (was
>    placed at end of file in v2)
>
>   arch/arm/dts/Makefile                      |  3 +--
>   arch/arm/dts/socfpga_n5x-u-boot.dtsi       | 17 +++++++++++++++--
>   arch/arm/dts/socfpga_n5x_socdk-u-boot.dtsi | 13 ++++++-------
>   configs/socfpga_n5x_defconfig              |  3 ++-
>   4 files changed, 24 insertions(+), 12 deletions(-)
>
> diff --git a/arch/arm/dts/Makefile b/arch/arm/dts/Makefile
> index cbb58180814..c753564f134 100644
> --- a/arch/arm/dts/Makefile
> +++ b/arch/arm/dts/Makefile
> @@ -452,8 +452,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) +=				\
>   	socfpga_cyclone5_sr1500.dtb			\
>   	socfpga_cyclone5_vining_fpga.dtb		\
>   	socfpga_cyclone5_ac501soc.dtb			\
> -	socfpga_cyclone5_ac550soc.dtb			\
> -	socfpga_n5x_socdk.dtb
> +	socfpga_cyclone5_ac550soc.dtb

P6 removes:  arch/arm/dts/Makefile entry socfpga_n5x_socdk.dtb
P6 changes:  CONFIG_DEFAULT_DEVICE_TREE → intel/socfpga_n5x_socdk
Still present: arch/arm/dts/socfpga_n5x_socdk.dts
Upstream:    dts/upstream/src/arm64/intel/socfpga_n5x_socdk.dts

Runtime build no longer uses the in-tree vendor socfpga_n5x_socdk.dts 
once OF_UPSTREAM is enabled. Leaving it creates a stale duplicate that 
may confuse reviewers.


Best regards,

Tien Fong


