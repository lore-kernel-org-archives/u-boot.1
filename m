Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54E8DCD4F26
	for <u-boot@archiver.kernel.org>; Tue, 23 Jun 2026 08:03:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 495F1849BB;
	Tue, 23 Jun 2026 10:03:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C+2pOWCp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A3AAE800AE; Tue, 23 Jun 2026 10:03:00 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E97B800AE
 for <u-boot@lists.denx.de>; Tue, 23 Jun 2026 10:02:58 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yxmluwMomQQxIlJm65m+7xtbPQ6aZb59RQEPBg4upAxB/qWH5b9rnuugH5GpjjqcRaYTHCqO4AU5IkRhtbYd9FlfNe+JudZyKq0xAmSs3GruhbIPSsrRq7pqwFXKIta0+zRYiN2HUCpUCHfCi1E+i2oYNwWFrWz2MGToZLX6z43R38vVtxNrwwOA0dumgWGxvuPgh+CYe3QPDqPdc0p1CckVQtlwupX3QW2JnY9pgUWZV7anGyMA8xdhjdCt3OTbWZfOKTwiaEdpGE1N9XSNQoYGoM5ftVnufXLag6jpDu/VfRpSKJcsMS4E1iZO7nQLCsf5wh3MLs1mODdXw2E4vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gEpZ3NWsGuQXqT+DZLTA/C2ebgPDwiUhQaM0KU6pYxg=;
 b=FY12SZQzEtMwotR76BjDU5bp5ykuuXtO/rP/L1PcklQ52totgdgbppSpiVYL504t8/HoNXRIsiVVxKmJN2SJZ16+SiKMPHTwHM2up5Rm6YYEYWpOqbSnl8pRfOX/W0oLXcw4RA8+7tbxK2w4UgHQviit/S06Ex6l3G66mr2QyTP8XFazFIKlAlvJefWhTqn7m46Fhp9WUSkLW+JQdRkUJIckejXyP0BRYjRum99vYeEbtcn1N1VgukqdJO+K272CjijrgGoBgOTMmwERUcK8q0PFdF9KvSq8Hg3zD6+mYjRKQP6zLJsPB+FUp/PErv4JHkmhAXub+taP9vUwNoEhTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gEpZ3NWsGuQXqT+DZLTA/C2ebgPDwiUhQaM0KU6pYxg=;
 b=C+2pOWCpZvqFy5DTbt9Tiaimo+Tf0YhljBCAbuSYulmJA36xGNZHGVCEQRPMwVdmOSUfCw0QOuyuhhTA50KRH9e7wkBEPoE4dhuUMHeKBkHYW5KisJbEogp8W+OBYWPU8aQUjGhoAOom0qpWQ0LaExJDsZAAUdhLRGkUxlRnAj4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by PH0PR12MB7009.namprd12.prod.outlook.com (2603:10b6:510:21c::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Tue, 23 Jun
 2026 08:02:46 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 08:02:46 +0000
Message-ID: <7e9f238e-0acf-44dc-9908-9fe8a45b8246@amd.com>
Date: Tue, 23 Jun 2026 10:02:38 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] arm64: versal2: Drop static DDR MMU mappings
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Pranav Sanwal <pranav.sanwal@amd.com>, Tom Rini <trini@konsulko.com>
References: <156e48d8228acfeba8866618038b48cd51490ea7.1781179823.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <156e48d8228acfeba8866618038b48cd51490ea7.1781179823.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0108.eurprd04.prod.outlook.com
 (2603:10a6:803:64::43) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|PH0PR12MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: f8e43ea9-cd02-4498-d256-08ded0fdcf81
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: MB570K457ePWX+vGQUZg5bjCTStu/Gc6xtK9n3OcobbjKsD8SWutifJFa9NjP0WsurjffhXiIP8ktYQolZX2oh81EL9tv5cugUTyjUpniN4hyab9HhyE9gimf4GsVgu81ut6jx3sPmkPqGkkrlGsmrfeu0RjihF4VkBmS3RR5tkJWs9uvB7bgDAoeiKVmGL8jp06WSCBclJOJBPR02KDyTG/OyVEp4hKMLLbVJFKKwRJbbbticj+OubbXp3upghKIV/ekwXG2qpJ3u0kgejZQUFwot/jfTOujWoFZV15EO+kRHXZPT9V69nc+MdGejosm2rfrZ7+8BKT02Woo//f74aqBZ1Zzna2LybreWP27RkPt4zcyP2oXQmMxNQ1cE9eavDlVlMf13EjN2TntwRNGgpb3hc6lpAxZYTovUbtx/Fit8jT3VmEGl1Fan4KyuHMqu76AFR2uK3bHHyBWssoLEL+nFRqdreVun65IsawXVYwEKPH9EIicP5wXjWLTFPimwyTewmDxyvgyAKmzJx88Hiy0a0SJOuzEp+1dWYZc4iE/K+mdYMg+HFaeJVdLNOv7YHE5DQGcwRzJbtw7cnyInE60WUl93m4v7wiQBq1Dw+wzJL2z/aehFq/7NHpaBP9GwtC+50hStwlT3A1W7l8Da2dqDVNzT0CAanln3qMd6c=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(22082099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWdmbElzNjNRTUJiQklIb0RIelJZSGkwZjcyTXJKalFNR2ljc3VVWkhhNXdu?=
 =?utf-8?B?elYwckdEcmtFdUorVlNxZzhEOE5TcStkT3praGppVEhFOWJHUTJHMjJET3dr?=
 =?utf-8?B?Y2MzZFpUTFRsd29JY2pPdFRpbDBjZHRPakpKT2w5UEpuRTVqZHRnODd1N2JW?=
 =?utf-8?B?QTRTQ3dHT0YzaE5uMWZQWE12YmdNV2VXRUd0U2VCMTlORDVZVXFOSEFxMGRt?=
 =?utf-8?B?S0k3SUhjY2dGajg3RnBrOTVyaUMvL0xONkR6a1BaRDZKQzlmYUpNR2ozM0Jk?=
 =?utf-8?B?UjBMYVdOUTFEQzBIVEFRdytubnhjYXNSQ0VXdWJ2d3AxTVAxQXhuZEhoY2ZW?=
 =?utf-8?B?OFkvQnpSQnNIbXZic3p1S3h6V0NlUENzekxZc3Z1MXZ6OFdCbFZJaEpOcEdO?=
 =?utf-8?B?WjFMbWxKL3puUDFMVDhoQXZEbHZVSGQzRjM3T29oVWJVSHJhUGt4UU4vZnFN?=
 =?utf-8?B?ZHNidDZieHBZT1MwajdwcFFzamFFVk1kYmVlSGZIT0pYRjBHanVrczBneEh1?=
 =?utf-8?B?Z2M0eFU2SkYxNG01RC9MN2RveW5vK3JKaE94UjZHd0NmNERUZWtPQjZNOGF1?=
 =?utf-8?B?TDRVK0p6QmRzWEw0WDhKcE8rMVRuTEVQQXFodUlQdkVzMXlvOXFGVTkvdTFx?=
 =?utf-8?B?aEU4U1F2Qk52Y24wMkVKMGRwb1N6MEhHaEF1Q2ZYNVlwdk02M2tZRzUzRVlz?=
 =?utf-8?B?NmNCMklnNHNWRkp0S3FsUFZvbSswM3FEV2Y3dVZKNEEwU2tVMG5GVVhpOG9z?=
 =?utf-8?B?OVd5NG5lTG4rVlFIcHFja1d2N1NSdFNGRDIvZlRJaHA5NmF3SXN3cjVuQ2NV?=
 =?utf-8?B?U2luMVQ3YkwvS1JlL0dQdnR1UHVhMXJhWG9FUkh5ZE1RMHRjdUdQeFZXcTI2?=
 =?utf-8?B?T3g3REw2STloTEpDc1ppVE1qeEgwd2s2QW9YUS9XUXUwNWdGUlZvUEpyVzZx?=
 =?utf-8?B?b1hNbDFHczM3eHQ0WVl6WFJZT2srcElVblp0aVNqd1FFMFJ0TUN3L2pOTzVY?=
 =?utf-8?B?dlpZNzFwTnNXVjFhY2VHdGUrQzVQbGhjNnZqdXg3a2QzTzRrK29vWlh2OEtn?=
 =?utf-8?B?c1p4YjcxNU50aGZ0NnphbU1hZi9rZVZDaWUxeHlkdVFVN1FpeldJSXZHalor?=
 =?utf-8?B?U3NpTnlFbkJLM2M0VFhNWXU1VjV0M1F5clJ5bERVSjQvM0FkQzFMZFBsOHdY?=
 =?utf-8?B?bTVDMUdhekFuMzAvbUEyZmllL1g5OFJpTVk0KzBqYzJxVTlFNjdLeEpiYytI?=
 =?utf-8?B?SjlCUmRWQnFEK25leWZzbWxBUEh0ajRCb2M3Sk1uM3lGUlJQbElOZ0RLMllY?=
 =?utf-8?B?OWp4OW9FQTc2bGMrZU9LZ1VMaG9jTGdjRWErMWxZSmxXcC85Y0JYYzdUWnJo?=
 =?utf-8?B?OGZqaHJ3cS9WWnZtUWwzQ21UQUt2bWFlTlFIL05UUWt2V0FSWWF6aFNCazM5?=
 =?utf-8?B?R1E3TXhIQTNSMVJsVWt1MUhnSHl0M3JJZThJRHNFYVp5UUpCOWt3ZUJjNlhJ?=
 =?utf-8?B?d2paTzU2c3ZVK0NZdVRJdW1mUDJqc1c4Ly9EMGNYb2wwa1Nna00vZW5DVEZR?=
 =?utf-8?B?ZUN0SDR2WXZLamFjTmpncjZvUytKeXNTb1Rwb3M1QXNrU21ZMWlieWN1dys1?=
 =?utf-8?B?Nlh1UHN4L2VybENFUldtRE1OLzI5R3l5c0JTVVorWmZqR3RLN3M5TUNQRFpo?=
 =?utf-8?B?RHJkVEhMYXpCZXk2R1M3OUZiemd5UjRCc2N6RU5RV3cxbTVWUTlWYVQzZEJx?=
 =?utf-8?B?N1JXaE54MWNyNVpUWTlMOGNPL0N3eUNEOFE3VFJobGpwVUVtZGM1ckRldDk0?=
 =?utf-8?B?VFcrMXpwZVRjQmg0SitRSkhlZHNsbnpiNERLdjBDL3JZK05KWUE1UFVoTzZZ?=
 =?utf-8?B?TzVPYWVkc3BiZ2lOTmtwdXQwc2ZQdGF2MjFhM2R5d2N3Nk9wWmJPaytDWmhh?=
 =?utf-8?B?MkFhVk5CeFNtaWpNT3VXZ2JMVjJPMnNWN0xGbzdXRWhkODJYdjBBLysxVnY1?=
 =?utf-8?B?QUt2WEVNK2NrTUIzOWRNWldPL0FjdDJ5OU1YMkR3RkVhWnVYT25SeWNMQlJi?=
 =?utf-8?B?YlRWOWJiZWdTN2RPNWxOeTZYWmx2N1NWUVVJWXpGVG85dTgxOHFmTlNnSVY3?=
 =?utf-8?B?a0g1ZjJubXBJNDZKcWxkRjBWdFdwbU9WMUdFUStHQThzUzUrUW5wTWNlV05n?=
 =?utf-8?B?NkFNSGJwOUkxM1BpcFN4ZzVWQTBZYUJpQXhqRFpRa3dpcUpvZ3EzM1hTS3Jn?=
 =?utf-8?B?cWdYWWp2TEsyd2o0VHV5dGV2Sjk2Z3plREdDQm00TllncVlpLy9TSlY3Q1lG?=
 =?utf-8?B?Z3NsSk13cmRHN2NFYVFhb0ViS2pIVFBKc2l2QlVpUEY1N0hOSy9XZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8e43ea9-cd02-4498-d256-08ded0fdcf81
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:02:46.1506 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hEizcci6cFBX3wxjfW4xa3rL08lFGBDLc68yYG1ScCc0/2X8uTOKFs0ayBRKEfrn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7009
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



On 6/11/26 14:10, Michal Simek wrote:
> DDR coverage is already populated later from the DRAM banks discovered by
> mem_map_fill(). Drop the stale static mappings so the MMU table matches
> address map more closely.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/mach-versal2/cpu.c | 17 ++---------------
>   1 file changed, 2 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-versal2/cpu.c b/arch/arm/mach-versal2/cpu.c
> index 3f3bfc949360..f5db0660ad54 100644
> --- a/arch/arm/mach-versal2/cpu.c
> +++ b/arch/arm/mach-versal2/cpu.c
> @@ -27,9 +27,9 @@
>   DECLARE_GLOBAL_DATA_PTR;
>   
>   #if CONFIG_IS_ENABLED(PCIE_DW_AMD)
> -#define VERSAL2_MEM_MAP_USED	6
> +#define VERSAL2_MEM_MAP_USED	4
>   #else
> -#define VERSAL2_MEM_MAP_USED	5
> +#define VERSAL2_MEM_MAP_USED	3
>   #endif
>   
>   #define DRAM_BANKS CONFIG_NR_DRAM_BANKS
> @@ -59,19 +59,6 @@ static struct mm_region versal2_mem_map[VERSAL2_MEM_MAP_MAX] = {
>   		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
>   			 PTE_BLOCK_NON_SHARE |
>   			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
> -	}, {
> -		.virt = 0x600000000UL,
> -		.phys = 0x600000000UL,
> -		.size = 0x800000000UL,
> -		.attrs = PTE_BLOCK_MEMTYPE(MT_NORMAL) |
> -			 PTE_BLOCK_INNER_SHARE
> -	}, {
> -		.virt = 0xe00000000UL,
> -		.phys = 0xe00000000UL,
> -		.size = 0xf200000000UL,
> -		.attrs = PTE_BLOCK_MEMTYPE(MT_DEVICE_NGNRNE) |
> -			 PTE_BLOCK_NON_SHARE |
> -			 PTE_BLOCK_PXN | PTE_BLOCK_UXN
>   #if CONFIG_IS_ENABLED(PCIE_DW_AMD)
>   	}, {
>   		/* PCIe DBI (1 MB) and config space (255 MB) are contiguous */

Applied.
M
