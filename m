Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C1ACD4F2C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 08:07:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A023846B0;
	Fri, 12 Jun 2026 10:07:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="PyrhSkMl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 52EB3846D3; Fri, 12 Jun 2026 10:07:21 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 15EAF8467A
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:07:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EVZTr/+BSLUT1kstAVwZTdwQW0hmd/39bFCHg3E9x+YDZ/u02Nxw4AZgAQ5f56FjEKETZsD2uVb6QezcEMAC1wEjFkgJZH9Pbjtq9ehmCl0/C1iIXs5L4eSsTe9Rxx5y3DByM8LurPU/jogwe/F8Lj8174sHS8H9Nhl+odV39ZwjlSgG69Xhp2c4aUSzFaqgVwPP90O7GllyLT32nJ+e/WUmhW8oDvCgs0ZQA2QPYvmADjihMPDlS8/HjET0dHI1kY4ET6Cw01vLG3qO5f7GhlnTC3DSpTDzgDt4iCm97FocmQo9OBfe/v7hOzcp8KK63zGbq1VZ3nid8wSwpW9VTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXg/NRbb58fHzRfpv9S8q5oi3kh4kOTacV+6rOCMFnk=;
 b=Bi9JIl144ve+W2prnEqhPWWxseRrMjWA7j6DI8ehdQWOXcayOC4YSsZD+L+wkONVqzzpKxkvNlyrbmjHW+y+9yt1gq0eFXakNoAtcGvMCzjzE+tyXktu8/MPaurXcMly2bJCCBgdAARx6Xu6q78Wgz3zY8lLpjz9gFksy/iUW32dgho6j8eTiLQ2pVaGFrULERW7ALOAIwWfG6mltJ3DvuIhXjV+HTCUM8JwgBg2J23WNQF+w7LCAXfV+zhoIg8N+1YLSj3K9MT/Enemn6tRud4ZZ+RoZDyPR2RoL28kLLVyghxhlLGIvL6bW7g6BzQBT1pMIg0fpymx5Fsbmd7lbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXg/NRbb58fHzRfpv9S8q5oi3kh4kOTacV+6rOCMFnk=;
 b=PyrhSkMlGuMCphGCdJCTn7gknsVs40FMeh+EXNZNJdKTXeaTG8WNGwE7KlHz4LZ0dnGMZ4yUHRaaTIbTeLal8ekwc/OsvSRUaba8YdORc+uQfMb5Ys0hXxJxmNhw0Z0crxC8W8az5rZnJmGfL+j7UH/vfNOfaYHbDbhOafjjmRhd0ivZmZ6y7rHB80UUUSeIySt7mzXh9j3eJZBX6ssFVeogkGZ9rhejdv4LFk+B2vqur7VMWuo4Qdv7HNC+TBIx1CzpjNSYi3Db7kv3WyGH+bemqdnT1z7HaEf3mP30oaj3awMFJeCSbNUeYogaVex4erCoY2ePwhpDRLLrnrI8fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB4992.namprd03.prod.outlook.com (2603:10b6:208:1aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 08:07:16 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:07:16 +0000
Message-ID: <a3048c83-e31e-4a6a-bcb5-4d59c64896c5@altera.com>
Date: Fri, 12 Jun 2026 16:07:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] ddr: altera: gen5: Add DRAM size checking
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 patrice.chotard@foss.st.com, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>
References: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
 <20260609020358.25985-3-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260609020358.25985-3-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR02CA0039.apcprd02.prod.outlook.com
 (2603:1096:990:76::12) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN2PR03MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: fcd914aa-2885-40f3-d278-08dec8599dc1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|55112099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 6UW/F5+UqxY7c8rTZBVRI/aSeHM8NjF7SmoU6RqMkryDWlOgyZFkqB/XjsjD2keqq61YCxdlq3PF/hWDn4VLKMXYhii2m9ECvISYGWqG8anVsWKTkurnP5W1J5nHHeIltPNjje2JB5n+Bh+wonJcOl/ZSoT1rOPu1AyltchkOFL2isaoN3oekepO46Z/uo+vp11c30b/DUJtdHREdMzPiC74heiIfeUl76H9S7veRO9zvreiui+wH2P/FWG1oIFGR6aPVWInkxZcyNgpf+oJ2IvgGJEPFVltk4ip48dLEQLqpTdvtbMs0W2Kt8h20K1qieIMBjoUXOjpg8YFTcdjTD2iOF1DEqhj/c5z/GHFyYMb2f8ghHQhZ4wRLMS5Uq25dAjOXN6ZACUv1Yf1qsGfsqdhNHmQuAdxduV8qzVqKZE7USA6B5uochG9tu4lYZ+3TFi3BD/w3NUZUgypFD3hqs8inquiGPI5N3s5cZZ7p1xQFFNfq6uVnZIc080Gwd42WA7RkYf49Tov0uKtA+c6ODo9ZjsYoU58o2rwurPV0JFCm36izX6tRZvo3nuwTi0xhVmZwVSU7JBrthk30IIQy8skT+ffBlCt894bC0Ops+IAHXJOg6Xg2E5QljmMnBmZRVI0qojyOMJTyLHRGhsGG++tnefbHDLTbanp1+5vJN+xPxNQL5XjkejFXL3zlcmv
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(55112099003)(6133799003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M1ZmM1RzZ0NFVk5GZFlneVRFVnFIQ2dManhLUHY0NzhKTFhQZWt0Q2xVc3lV?=
 =?utf-8?B?eE5LNWVOTExLdEJSK2VuQm9EVjZwOVdaWDh4Ty9qcGJyWERyNTk2YWFtTWcz?=
 =?utf-8?B?bkZZMGhWbVJxOWlxSWVKVVl2TXNKL0diL0RSQkp6VUJQTUFicTd0NndTMU5s?=
 =?utf-8?B?QUFKM0NkSjJ3Y0luY3Vzc3ZPTk5QRWZjeEs5THJERFZQQmZaSkxqYVZodUdF?=
 =?utf-8?B?ajJSREs2UDFGZnRrMUhRcitmb0xaZ3g3V3VsNG9EaXZQaFBMUXFNSXFlSHFl?=
 =?utf-8?B?UVdDTTVHL3pnQldzQWZkS1RyNHhFTDdDK2I5eUV6ZkJZcTV3L3pBTjQ0SzZC?=
 =?utf-8?B?bmp0d2xITkpxaTQyY09UQ0Y3M0Z4UTlpUGtyTVhDRlhleWd1SmF0Y2JSK2l4?=
 =?utf-8?B?d1o5UFdxckh4RFQ1VlA1R0JCMzh4SDJQcW1TTFVOYU1Lc3Q0RktPS051K2th?=
 =?utf-8?B?MjRJYUNBbEgvZXRXeVJyZ00wUm1nMktoOXQxeW10RnNCRXVWVE1tS0kvR3lN?=
 =?utf-8?B?TEk2WVdrRVBYc21iNkNLdkVOb1E4Um55dnlYcWNsQXAvSUg4bHgvbkhGQnd0?=
 =?utf-8?B?dUtXeDlvaHk3M1Nxeld1YUxoUGdXNVZHcVhLV1ZLVUhsZElkaXk2RlJpMlp6?=
 =?utf-8?B?MDFjSm81Y2krZldKRXhONnlKVTJ1MENlNFJtUXlJNGdjekRhdGNRQzJFSmx3?=
 =?utf-8?B?YjI4OG5KWjViU3VZbW83U2s1bmlWVTl0c015b0dRUzNtcVgrVTZGMjg2cFhi?=
 =?utf-8?B?OUowUGRoRnpaWStGRlE5MHlCUE5SMTZTY0xzNGZJak9xQWRPRHdmdExab2ly?=
 =?utf-8?B?dTYzTG00czhXWjdJUFV4ak80dDN3aXpGV3pVMytvWHlhM0hoSUM1anliazBa?=
 =?utf-8?B?aGJYdkJ4NWJmMHovSS9GWk5hZjkxUkVMZnJlOTZPd242d28vazFzRkU5QXlK?=
 =?utf-8?B?YkNFZWM5aVRsd2pBdFJDVWV6S25ubDgrYzJWeWh6RmdOKzlyT1VEZkFGVk5s?=
 =?utf-8?B?YlBUV3l2YzBkakNTYzBJeHg3VGF5bng1d1ByajJiYTVoWmlTV0Z6Q01TSnBJ?=
 =?utf-8?B?VElDOHVmajJJZm9Kd1d4Zkk4WHB3Q2ZvQmhBNEFFalpYR1ZaNFdUZW9IYVVp?=
 =?utf-8?B?UTNIZVNJRk9SN3ZHS1B4OW9Ec0FyYnFGSDFMcXZxWjVQRXRTOExVQ0hGZ1lW?=
 =?utf-8?B?di8yYWM0K0pGaTZsNGtxZW1Yay9OamxNS3A3ek1pTVVFeWFlV2FKbUoxSWZI?=
 =?utf-8?B?dm1mdTZMOXJreWt5bXZLUlloK2pCRXF1NGtqVXhGY3VTSktUbDA0MlZRNDJ4?=
 =?utf-8?B?SVVOeVI5eUViNTdjL211ZERsTU5kM1A5Ky9KbmJjeW1WR1FHM3ZKVW1JTHU3?=
 =?utf-8?B?cldCN3VmTm5sYWRaZmVzMGdVbmRpN1EvcmUxN3BTTVl1MTZDMlBBMVhZVHht?=
 =?utf-8?B?YUpvSnF2T2FFeUY0NmlmaFNGYU5EaUJWR3gvNVZHNkpkd0dtYkYwZ1VHQzcw?=
 =?utf-8?B?TXhTS1l5L1lJVnljNnhvS0NEWmtBSjQyR2U4Z1lFb0E3a0l3dzdrbS9la0hh?=
 =?utf-8?B?eTRweXNDbTZiL1VuMm1Ec01QQUR1b0Q4R3d3R3lDNUxJc214cFFDNGNBMDJ4?=
 =?utf-8?B?Yml6b1gvYTlhVHNBZG91aCtselJ4bi9nYlF6RFFUZTdxSFEvR0xHNE93ajVX?=
 =?utf-8?B?dnVGSGxUelFibWRCMVBuVDhPSlBmZHNnQmhWR3hOTkZHdWluNWxvWlBlenZr?=
 =?utf-8?B?Skl6aFZFQURTbmlJc1RHUnNBSkwzTzBFK2ZXR3YraXNRMzVCL2QyMVRrSnUr?=
 =?utf-8?B?Ulh0aENlbC80Rm5sU0U1Y1A3alJGM1pSMzRiQzNrclJXTHNRVWFCRW5ZVUQ0?=
 =?utf-8?B?WkIveVpXUEZaWHB3ZGNSRHNLdER1d1Y0bGhsT25yMmxOREFPaFE3YUhKZTdP?=
 =?utf-8?B?T25tWmIwY0pralpBWDErTkhnb2RldFQrL0hTYVRZK1JKalZScWwyc3pYMkNE?=
 =?utf-8?B?L3ZqYlpLKzVnSzQ1amNoTWlTaElnWU9hUDBLcXpWZ0VaUmNuWWlKeVJldWFq?=
 =?utf-8?B?eVpmd1FBcmkySEFRT0tQM05pazdZZGlMRFVBaEdVam1ZeVF3cWpEVDRUSWtY?=
 =?utf-8?B?dThmUmRKMEx2cTZlL3E3OTJRMURQMXhUNFl6S2NENDFkUTB1OStmejlhdjhI?=
 =?utf-8?B?bE9OOXlIZHM0MERLeDJEcTZTMzdzeGNBdTYzZ2I4YXdlZnNYSVBIQ2EvcGxs?=
 =?utf-8?B?ZVFjYUZ3angwcU1hS3hhbTZqMjk3Z1ppa3d5a3pMalBYaWhCZFQyTXF1ZkRs?=
 =?utf-8?B?OWZHc2MvMVBnTHk1N0dtU01JNS9RRGxJd0VOUWtobzN1VmxheEF0aERZbUtO?=
 =?utf-8?Q?JwQpd51p4mWT7v3w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd914aa-2885-40f3-d278-08dec8599dc1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 08:07:16.1307 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k4Sx79IcUeKo2G4vboLLcshk3lVWedYtff4BuaZzjSoBt3IgkWTDLhrIsRijEwbDWFbw9mR3sEGbsj6pRext7ixnz2NpzXmY3tOtuYUxVNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR03MB4992
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

On 9/6/2026 10:03 am, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Add DRAM size checking compare between size from device tree and actual
> hardware.
>
> Trigger hang if DRAM size from device tree is greater than actual hardware.
> Display warning message if DRAM size mismatch between device tree and
> actual hardware.
>
> get_ram_size() uses size from device tree. So, it has consistency with
> other device families.
>
> New Kconfig is introduced to enable this implementation only on the default
> CycloneV board as this will increase the SPL size which will exceed some
> Gen5 devices' SPL size limit.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> (no changes since v3)
>
> Changes in v3:
> - Move the bdata declaration and gd->bd = &bdata assignment from spl_gen5.c
>    in patch 3 into this patch, making this patch self-contained
>
> Changes in v2:
> - DRAM size checking is set as optional via Kconfig and defaulted on only
>    for the reference Arria10/CycloneV boards to avoid SPL overflows on
>    size-limited Gen5 defconfigs.
>
>   arch/arm/mach-socfpga/Kconfig    |  9 +++++++++
>   arch/arm/mach-socfpga/spl_gen5.c | 11 +++++++++++
>   drivers/ddr/altera/sdram_gen5.c  | 27 +++++++++++++++++++++++++++
>   3 files changed, 47 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index fb98b647442..b814e034ecd 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -6,6 +6,12 @@ config ERR_PTR_OFFSET
>   config NR_DRAM_BANKS
>   	default 1
>   
> +config SOCFPGA_DRAM_SIZE_CHECK
> +	bool "Enable DRAM size checking for safety"
> +	help
> +	 Compares device tree DRAM size with actual hardware. Hangs on
> +	 oversized claim.
> +
>   config SOCFPGA_SECURE_VAB_AUTH
>   	bool "Enable boot image authentication with Secure Device Manager"
>   	depends on ARCH_SOCFPGA_AGILEX || ARCH_SOCFPGA_N5X || \
> @@ -111,6 +117,9 @@ config SOCFPGA_ARRIA10_ALWAYS_REPROGRAM
>   config ARCH_SOCFPGA_CYCLONE5
>   	bool
>   	select ARCH_SOCFPGA_GEN5
> +	select SOCFPGA_DRAM_SIZE_CHECK if !TARGET_SOCFPGA_TERASIC_SOCKIT \
> +	  && !TARGET_SOCFPGA_EBV_SOCRATES && \
> +	  !TARGET_SOCFPGA_SOFTING_VINING_FPGA
>   
>   config ARCH_SOCFPGA_GEN5
>   	bool
> diff --git a/arch/arm/mach-socfpga/spl_gen5.c b/arch/arm/mach-socfpga/spl_gen5.c
> index 08b756db2ca..a9825173189 100644
> --- a/arch/arm/mach-socfpga/spl_gen5.c
> +++ b/arch/arm/mach-socfpga/spl_gen5.c
> @@ -6,6 +6,7 @@
>   #include <hang.h>
>   #include <init.h>
>   #include <log.h>
> +#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/utils.h>
>   #include <image.h>
> @@ -24,6 +25,12 @@
>   #include <dm/uclass.h>
>   #include <linux/bitops.h>
>   
> +DECLARE_GLOBAL_DATA_PTR;
> +
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +static struct bd_info bdata __attribute__ ((section(".data")));
> +#endif
> +
>   u32 spl_boot_device(void)
>   {
>   	const u32 bsel = readl(socfpga_get_sysmgr_addr() +
> @@ -143,6 +150,10 @@ void board_init_f(ulong dummy)
>   	/* enable console uart printing */
>   	preloader_console_init();
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +	gd->bd = &bdata;
> +#endif
> +
>   	ret = uclass_get_device(UCLASS_RAM, 0, &dev);
>   	if (ret) {
>   		debug("DRAM init failed: %d\n", ret);
> diff --git a/drivers/ddr/altera/sdram_gen5.c b/drivers/ddr/altera/sdram_gen5.c
> index 3c79bb11802..1c3c70ea8ae 100644
> --- a/drivers/ddr/altera/sdram_gen5.c
> +++ b/drivers/ddr/altera/sdram_gen5.c
> @@ -5,6 +5,7 @@
>   #include <dm.h>
>   #include <errno.h>
>   #include <div64.h>
> +#include <hang.h>
>   #include <init.h>
>   #include <log.h>
>   #include <ram.h>
> @@ -15,6 +16,7 @@
>   #include <asm/arch/sdram.h>
>   #include <asm/arch/system_manager.h>
>   #include <asm/bitops.h>
> +#include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <dm/device_compat.h>
>   
> @@ -22,6 +24,8 @@
>   
>   #ifdef CONFIG_XPL_BUILD
>   
> +DECLARE_GLOBAL_DATA_PTR;
> +
>   struct altera_gen5_sdram_priv {
>   	struct ram_info info;
>   };
> @@ -604,8 +608,31 @@ static int altera_gen5_sdram_probe(struct udevice *dev)
>   	sdram_size = sdram_calculate_size(sdr_ctrl);
>   	debug("SDRAM: %ld MiB\n", sdram_size >> 20);
>   
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +	/* setup the dram info within bd */
> +	dram_init_banksize();
> +
> +	if (sdram_size != gd->bd->bi_dram[0].size) {
> +		printf("DDR: Warning: DRAM size from device tree (%lu MiB)\n",
> +		       (ulong)(gd->bd->bi_dram[0].size >> 20));
> +		printf(" mismatch with hardware (%lu MiB).\n",
> +		       (ulong)(sdram_size >> 20));
> +	}
> +
> +	if (gd->bd->bi_dram[0].size > sdram_size) {
> +		printf("DDR: Error: DRAM size from device tree is greater\n");
> +		printf(" than hardware size.\n");
> +		hang();
> +	}
> +#endif
> +
>   	/* Sanity check ensure correct SDRAM size specified */
> +#if IS_ENABLED(CONFIG_SOCFPGA_DRAM_SIZE_CHECK)
> +	if (get_ram_size(0, gd->bd->bi_dram[0].size) !=
> +	    gd->bd->bi_dram[0].size) {
> +#else
>   	if (get_ram_size(0, sdram_size) != sdram_size) {
> +#endif
>   		puts("SDRAM size check failed!\n");
>   		goto failed;
>   	}


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

