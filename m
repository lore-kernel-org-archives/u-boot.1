Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8C93CD4F2C
	for <u-boot@archiver.kernel.org>; Fri, 12 Jun 2026 08:06:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 368A48056B;
	Fri, 12 Jun 2026 10:06:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="iSqgdp2F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F68D83FEC; Fri, 12 Jun 2026 10:06:49 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C47088005D
 for <u-boot@lists.denx.de>; Fri, 12 Jun 2026 10:06:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v25JzJSzb1DM2zGX5P0WrQooI4KrSXAH3aCe+Jy+uxTl5fUA8Re+eMaAJbJpP+hIQ0nP4I+VYZP5XPMxiIXzIQnzRjdQSd8B6IE9tc+e3hioHeKK75hYHMEClv/pE7kQ7GiXy1d0znbxu4jo84HkFdHB4rTXMAXIwg2/+5OwDve7mKxcwcupbhgrMovQEVQWnHSmhfAQyROXkpkhabL9e0l5BWuy+tyfh9E2V5CmsEH0pfrzsj3p1bY+YipDMfek1nRVeQJlItG7Q1Rbi/dulorwieWDhFDKj64sGIpvV6E3kbR8UpNbZQXrR3PzkUpu+3dHm9PKJ+YZWfSnLjTDuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DGlBsqj6XmIQTRvUbDBruHlACEcRoaIeeDdE9Qkvvg=;
 b=O9LyvwgpTmzgYzPrCv0aNwfsU5HmlS88g2l8b9WOurAjJ3Vgrh3aKX7cE3Oj5aWHv2hkLLRGSbUNwifoBTqaZ0/rj9YV0P7q7nW27ZMZx5jX79mV/NGrgoBP++/+UROzSESoJtxfGjrG5OX949/Ofc3OUH7YlhMbIKLkzK9gpeKfR7fk07JcJRCREenL/a5F24bW/CsbfAGZG5n59mvR0GvsOmLW5f5bYniGSbamSI6cOG4AYIm745tMipD2ujUPQsKpsG+cR/Fx8S8XP0Ez2Ejb2YBt6yZDWamI7gxlT8wdCA4j+08V6xKUlEhaAD2VINjzRQ6C5G+SWw0Id8SEuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DGlBsqj6XmIQTRvUbDBruHlACEcRoaIeeDdE9Qkvvg=;
 b=iSqgdp2FYr6VQ4hVchpS+uXap0PF6DOo5siDy3ikOPEvStsUJJbW8WXcPjB9lJ+M69cueG9TfuSpYwfxn0meVhxPr/YNLOvZGHaEgrlpL06kSeCul5hV2J/o2P2Bunj1iH/ug7xxe5vGq8QK7dqO5DWB/CLJsNAk3JYCzwVrw7mcOoXRFitMO3MiKx4HiNNpzcJo9PxuLan51fVwFqua0teAeCRf4zdCfoUyguHWZM5vn0NwfE2xqO5dhKjaJvdBBflIgtmSNf2NuqffT1sj24+GHOhLxrOOqxvMX7MY8OHGDIAYWX4WV9ybnIV5s77jZOg8453Xs+mtMADEe+32JA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by MN2PR03MB4992.namprd03.prod.outlook.com (2603:10b6:208:1aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.15; Fri, 12 Jun
 2026 08:06:43 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%4]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 08:06:43 +0000
Message-ID: <9b80c7c2-499a-4d8b-ab96-0929a6d3c7b1@altera.com>
Date: Fri, 12 Jun 2026 16:06:34 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] arm: socfpga: Consolidate dram_bank_mmu_setup()
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Brian Sune <briansune@gmail.com>,
 patrice.chotard@foss.st.com, Peng Fan <peng.fan@nxp.com>,
 Yao Zi <me@ziyao.cc>, Simon Glass <sjg@chromium.org>
References: <20260609020358.25985-1-alif.zakuan.yuslaimi@altera.com>
 <20260609020358.25985-2-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tien.fong.chee@altera.com>
In-Reply-To: <20260609020358.25985-2-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:990:76::8) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|MN2PR03MB4992:EE_
X-MS-Office365-Filtering-Correlation-Id: 83494d6f-238a-4dad-1e82-08dec8598a1c
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|22082099003|18002099003|55112099003|6133799003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: 5X9ablC5csdUWVEXgs9+NrAeL0jbAoqadRUFlV9f2RkJQ+oJdNtnzHH3FWZBiiokhgq9BKotLiMY30/BMajDSURGzBuc3v/vIUQ+74Pb0C8dFl4fCeK1uVmkTtgTj9jNpdpmij/AGwULJwxCdVV/u5KxiAuJSA4yKb3EUijohQTuNAOlkh0Lt03tdFr0JQLjAFoOv60Z4wH/evMVX2mWw2vghSjdDwFpJKMbRHCtxa/WM/JOXUQyX5Awz23FL5RhBhgwiE8OmxWmLqrpZqJ4KY3HGu06MkgKa4V+s4gi8n9sluYJPZJij/0m68PsyVsEl4Em9WFu+H/P+daQVwZuFSKNMytcSf9mKIQFDmGdGE3VrBrOoQ+1Z1OT6zx+giGPS1ZBAlSLV7ujLsIaKgOadyjrMODseV+6GECKYQ+P9fPhO70hcDQWwijtS6PmpQwz/RW2XkJ86LKtZSVrVS+VAFgt3gXNYAYppL87i7NejeAWpsG15Hlu2maapDT3fO3TEDuL1H1BTHe9/6bO9BFlIbGAHDgW6+vLR8aotI5wkKH0U87vXnuIBJ4fGBE3hrciK7qGoyk3vHATLuaGVKzKMQdhwJVxhFuopcOrMfZBWcrbUuMsv0vU20nY2f1TiWsY5AvNv/BOIRJ/hPG8I4M2uChrsvq/n7XpJIqGy4sO4b5tkqkCOD+62lwi7uoN0jzE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(22082099003)(18002099003)(55112099003)(6133799003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZXVyR2dkU0JMeG5vSXU2RVdXWk5zNjkwc3N1QTBocEdyM1dIakprVkw0SWJt?=
 =?utf-8?B?WTUvczRFU0RNR0NGUUwrcXVBQ3FZaUlRYTRkQnpoS0k5VVg2WkxmODNhUXgz?=
 =?utf-8?B?b092QXFjeW5qNHUwN0V4eGJMdnpuTFZucFJwT2hqaHcrV1NhUS9SVHZkV1Zy?=
 =?utf-8?B?QWdpOHNxRVZZWWdKODU5dG9zTzJCLzBud0xHZUJ5MTMycG8wQ1Y4dzlObk9R?=
 =?utf-8?B?QXZZWnU1TnBjVWtDQmVaaU5HZ3ExVXM4YjJGYU1SemxXa1ZlejE4NXZSaDZx?=
 =?utf-8?B?enhyT3FKM1U3dUQrRVcyMG83clRINXJqWlZ6S1VKMS9hcGhGckNmUmJvMzZE?=
 =?utf-8?B?VzM4NUNYbnRZTmltZGJsKzNOZlBZTTN3L0dzWTlVRmEySGZTOXk2ak5LK05x?=
 =?utf-8?B?TU9hSXg0eHdOWjdpTW1xd2FYUXNZYSsxeUVVRjdRcVQvQkoxZXJSekoxTTBC?=
 =?utf-8?B?RUVUdUM2ZmZkN2tVNGRSeEdkVE8wK2NMSVEyTmJxc0RXcjk5K3pCNVRKQjlm?=
 =?utf-8?B?eG1wSCtmMEtFRlBvWEY0emR5ckNpb3RUemlIK3lJaE94WGk3Z2lTUzNhS3o3?=
 =?utf-8?B?VEJKa2R2QkQ1THpxYlVveDJQLzRxMlo2R3VYL0FLT0ZPemJXM2cxdFBJSnl5?=
 =?utf-8?B?cEJZUWIvb0JKWEVhQlR5NytVQ3YzVkVoay9Ya2dUc3U3SFNiKzg3dHM0Y2lV?=
 =?utf-8?B?UmRVcnh1Ni8zSk9ZVVM1SGY1UUdkVUVQMVlXaEZZZVBHMXVHcW9vcUc2RDEw?=
 =?utf-8?B?T0pnVm51cVRHaHc2RGJmcWJmTTdrRlUwdk5xYUNkaTdRV0Q4NjVoMDgva3RC?=
 =?utf-8?B?Rm1zYmVaMU81WlBYS0pVd1pUQ21lZ2VIVXVuVG5Vd0ZCMm0vK0YzbW5LbHcr?=
 =?utf-8?B?Smt1SWQ3VFJGRk5oL1I0Vkd2dnZLSWQ4ZCt1ZU9QK25SbWszQ2N4UnEvZ1BW?=
 =?utf-8?B?MDFaY243blRIYXQ1OFdHUE8rNGVnNlFjOVU4emVBYWQ0NWc5VTRLU09ZMWZQ?=
 =?utf-8?B?aURWRXpTbllOdmZyZ2VtMVZ4eldJOUJBWUFoU1RYc0VQV3FQczFDcnJaS280?=
 =?utf-8?B?ZHBFVjVLQkhRVjVNVDNCZWdrOXY4WG1qSW9oZXhROHoxMkhNUmppNlFsdWdZ?=
 =?utf-8?B?SlFmRGs2SmZlaUI1Rzk5NkE1R29ZY2Uvc0N6Sm9tcW9VRHk5bHF2S2I1azRS?=
 =?utf-8?B?TXVWWHRMZmJVZmJSYXU5OHBpekJxZG1iSW43Ni8wb0NUM3N5aG5MRHBpMEVn?=
 =?utf-8?B?c3FHNjI2MXFLeVpGRXREOHlQRDZTdjRZNEpwVXQxODlCcVl3c3hUdGVlM1Ir?=
 =?utf-8?B?RkZFQTVHVFR0U3EyelV5Qjhwdlo0VFdPTE9jNGJOZVhuWTc0TEVUWHMwSFpn?=
 =?utf-8?B?SUEvdjJUUXFxY2tid0pQRUMwMnV2ZEYydlhTMHNiN08yVUFSOUZlSkNZWU5v?=
 =?utf-8?B?YnhycmlFcWw0b0lmNXRjK2RuTTRhWTRDL1ZpQUxUWXFtRWo0TEZIdTVVUTBh?=
 =?utf-8?B?bytYb3hxbWM3eFFKWmNOd3IrM0hqTzNoYisweUZHWnF3NlluV1hUNTJiQ0E0?=
 =?utf-8?B?N2RDK2paQUgvRUcwWTN0Z2wyeCtnYVQwc01sUWx0cUFTOWk2S3BjWWRwbmR2?=
 =?utf-8?B?OStQOFF2MU9WemlTRldqUkQrdG5kWVNVdHYxWitIRUc1QllyVDgxVWdydzlj?=
 =?utf-8?B?cU9OdHFXOFZmc3N3cStjUTd0NVNCVGtrN2wzRmJnMDR3SzA0WnM3UjEzemlR?=
 =?utf-8?B?eElLN05YU2JkUGQ1MytIUmZKS2RnNjBFT2tpdEQ2ZmR5OUFtQ3dhWTlPSWpV?=
 =?utf-8?B?dmZ6dDJ4b01tVURBRDdmcW10ODZucWFPdzN4UVNqMlhOaUd4b3lKMFkzNklN?=
 =?utf-8?B?MisyMXlOM3NTSkt1cGZ6cEVQbGluMWlBSUhQVWZqTnNuK2V4MURuTWF5UmZV?=
 =?utf-8?B?UjZMZWhXNUFLeXdieHBURVRVSko4UHZYVmRDbko4SXUxaDBMWEhtanRKU1RF?=
 =?utf-8?B?UzVGdXhUdXhUZUU3SXFTam5SNG5jUzJDUzJFNWFYRXp5UTNnLzdZWWsraTFo?=
 =?utf-8?B?dEwyODI2ZEh5TDBWL3FRTzAyWW1WRXJxMm9iMk81Y2hJbk5Gc1ZHMnFrRmhL?=
 =?utf-8?B?N0hkeG5QdVZyOTN6ZStJS1NUd2dnRUM1RkliTUYxekNqb2JFTkM2QWJ1ZW04?=
 =?utf-8?B?cWRiS3Q1Q3hHVTVYbjFqVlpib3JPeWdUKzRaUWxqOS9HYkMyblhFNlc0K3Aw?=
 =?utf-8?B?aVdmYlVEZmtENE9iMDRaVlE0VEY2T1UzRDJlbkwrZnAwRTk3dTNJRXBhM0dC?=
 =?utf-8?B?ckNMVEo4N0dmWnBKbDFTVVk5ZHp4MVpTS1JCZG81NTZjS082NzcwU1B2YUVY?=
 =?utf-8?Q?G2OtJ7fqbTf9NkuI=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83494d6f-238a-4dad-1e82-08dec8598a1c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 08:06:43.2851 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3xZ6m6rsTbxyC2MggeES5oaBUzIXt0S+lceSUUc3J6dJ3hdN1P3L5nRi2WFDyaobYqUAoLct7b+KEtoulSzXfIwRbZh8b1QckHjMshNBc+U=
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
> Share dram_bank_mmu_setup() between Gen5 and Arria10 in misc.c. Before
> relocation, map OCRAM and DRAM write-through so SPL can run
> sdram_init_ecc_bits() with dcache; after relocation, use default DRAM
> cache attributes.
>
> Fixes: 503eea451903 ("arm: cp15: update DACR value to activate access
> control")
> Link: e26ecebc684b ("socfpga: arria10: Allow dcache_enable before
> relocation")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>
> Changes in v4:
> - Commit message clean up
>
> Changes in v3:
> - Removed 'select SPL_CACHE if SPL' Kconfig guard from this patch and
>    applied this condition alongside SOCFPGA_ECC_SUPPORT on patch 3
>
> Changes in v2:
> - Shared dram_bank_mmu_setup() is set as optional via Kconfig and defaulted
>    on only for the reference Arria10/CycloneV boards to avoid SPL overflows
>    on size-limited Gen5 defconfigs.
>
>   arch/arm/mach-socfpga/misc.c         | 31 ++++++++++++++++++++++++++++
>   arch/arm/mach-socfpga/misc_arria10.c | 26 -----------------------
>   2 files changed, 31 insertions(+), 26 deletions(-)
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 1eef7893e54..80b054dcae9 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -318,3 +318,34 @@ phys_addr_t socfpga_get_clkmgr_addr(void)
>   {
>   	return socfpga_clkmgr_base;
>   }
> +
> +#if IS_ENABLED(CONFIG_SYS_ARM_CACHE_CP15)
> +void dram_bank_mmu_setup(int bank)
> +{
> +	struct bd_info *bd = gd->bd;
> +	u32 start, size;
> +	int i;
> +
> +	/* If we're still in OCRAM, don't set the XN bit on it */
> +	if (!(gd->flags & GD_FLG_RELOC)) {
> +		set_section_dcache(CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
> +				   DCACHE_WRITETHROUGH);
> +
> +		/*
> +		 * The default implementation of this function allows the DRAM dcache
> +		 * to be enabled only after relocation. However, to speed up ECC
> +		 * initialization, we want to be able to enable DRAM dcache before
> +		 * relocation.
> +		 */
> +		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
> +		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
> +		for (i = start; i < start + size; i++)
> +			set_section_dcache(i, DCACHE_WRITETHROUGH);
> +	} else {
> +		start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
> +		size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
> +		for (i = start; i < start + size; i++)
> +			set_section_dcache(i, DCACHE_DEFAULT_OPTION);
> +	}
> +}
> +#endif
> diff --git a/arch/arm/mach-socfpga/misc_arria10.c b/arch/arm/mach-socfpga/misc_arria10.c
> index 7e0f3875b7c..635fc3568fb 100644
> --- a/arch/arm/mach-socfpga/misc_arria10.c
> +++ b/arch/arm/mach-socfpga/misc_arria10.c
> @@ -243,29 +243,3 @@ int qspi_flash_software_reset(void)
>   	return 0;
>   }
>   #endif
> -
> -void dram_bank_mmu_setup(int bank)
> -{
> -	struct bd_info *bd = gd->bd;
> -	u32 start, size;
> -	int i;
> -
> -	/* If we're still in OCRAM, don't set the XN bit on it */
> -	if (!(gd->flags & GD_FLG_RELOC)) {
> -		set_section_dcache(
> -			CFG_SYS_INIT_RAM_ADDR >> MMU_SECTION_SHIFT,
> -			DCACHE_WRITETHROUGH);
> -	}
> -
> -	/*
> -	 * The default implementation of this function allows the DRAM dcache
> -	 * to be enabled only after relocation. However, to speed up ECC
> -	 * initialization, we want to be able to enable DRAM dcache before
> -	 * relocation, so we don't check GD_FLG_RELOC (this assumes bd->bi_dram
> -	 * is set first).
> -	 */
> -	start = bd->bi_dram[bank].start >> MMU_SECTION_SHIFT;
> -	size = bd->bi_dram[bank].size >> MMU_SECTION_SHIFT;
> -	for (i = start; i < start + size; i++)
> -		set_section_dcache(i, DCACHE_DEFAULT_OPTION);
> -}


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

