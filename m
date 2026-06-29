Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC9F4C43458
	for <u-boot@archiver.kernel.org>; Mon, 29 Jun 2026 09:00:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CB384A3E;
	Mon, 29 Jun 2026 11:00:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="IjWHWHKW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2820984A45; Mon, 29 Jun 2026 11:00:56 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazlp170120007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c101::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A3F9F84A35
 for <u-boot@lists.denx.de>; Mon, 29 Jun 2026 11:00:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcdHW62f8WiSW+U8Qsh8THv5hRqkfE5lTCJXVlE26eKx8ITl1Zjt0wu7VNvjIxmxyB/g+dSQ2HFYVtlhXCcSDF7PAKpB0YhP2Jj4kiF1ozrbD1hrH9bmJFLFF8OG0WkQRWBC6gNjvkjhglioW8nXzw0bwndsfiR9aPcIdP2HjiuM+OxuC/PFh4vc4/ItmD5xw2PNveononT5W3cuMcfH2otIzXEM4KTN1CmA6wDB2srdyKTYiHaB8t8+wqhKWDSBkMx5+BwRAEGTWWzrgo4bwaQj4SbwHPiKbeA5MDD2LgMX0AKifOnWlKby/I67tNRD82Gv04ZcYMz7CansmmuK1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BZ81fLe/bYR/gTrzqHCAC+z5Ba30dyaJjcxvWOIyNeA=;
 b=Dj6YMzyI5ZpdQGm4FhJXwV9ZHVvXUAH5w7+r0ey+CMwJiMp/2SuefHMt8ossSyWj+7PHbJRmglPGLnmPS/z5LyD6sFxXgHvNBuS0SQ6MHFOV4XfiTVQ8oBBgdv7YrJUQejaLFfl4UlrN9qBmTG+WGjhpQ8Quwa8S5HT1t04XZd4hzwDJ9Zeq3fvTEm4AXMfcyceI4cgPniN1cJO/sEKOe2ssKBW4jnuuuOvGL5+UB9Hd0I2nBuC1Jz7llouxJ5MusAoByvhk+ywwCtcXVdzS50q9ruYprzvzMlXX4NciX+1oW64uWzgXszMJtE6uhFNqD0URZAZ0KTpkVu0+h5w//A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BZ81fLe/bYR/gTrzqHCAC+z5Ba30dyaJjcxvWOIyNeA=;
 b=IjWHWHKWTk97UP7m0ct0TymahaGum2ZerYa7o4EdG4v83h/3690pQnxYW8PLywYpn8QAh6hclBy6njjc5CbvMDKxrFlpb3kO4x68P+rD+uxJ3uoeXM/0XIyngPiWZ5Unzsv8ohaNQ6+vPNEjmuDWPaFatV+fKWGYViBS/G+Kfn8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from LV5PR12MB9779.namprd12.prod.outlook.com (2603:10b6:408:301::14)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 09:00:46 +0000
Received: from LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287]) by LV5PR12MB9779.namprd12.prod.outlook.com
 ([fe80::8ac8:e862:8ae9:9287%3]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 09:00:45 +0000
Message-ID: <967b6d66-15f2-4e5c-9de9-3c530700cd05@amd.com>
Date: Mon, 29 Jun 2026 11:00:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Skip riscv_cpu_setup() when CPU driver is
 disabled
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com, Tom Rini <trini@konsulko.com>
Cc: Yao Zi <me@ziyao.cc>, Leo <ycliang@andestech.com>,
 Rick Chen <rick@andestech.com>
References: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <8953b5de682097450d7434e267380ac40cba6347.1778488310.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0085.namprd03.prod.outlook.com
 (2603:10b6:a03:331::30) To LV5PR12MB9779.namprd12.prod.outlook.com
 (2603:10b6:408:301::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV5PR12MB9779:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbb8d56-f5bf-41d7-557f-08ded5bce7d4
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|22082099003|6133799003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: CFu/iM/eDImF3OGIWOYZJkdesFEivcNznFLKUehxjEWaVz+YA2PumIlmv7vz+exjPSHyISsY0LlHPdFaA19z1S/uYcFuEY0YM4Dfa/5sI0DdAmXsff7BP9+DOSXLOQqq9vWVB6VGU0Lb0VwcNgF71gVmqLBvQ4pr6RWv7Gdy0fXzQtdnMs0T6XyJb6n2LXzuN6wncflRQ0Qg7UBUce0PtsaEm7oa9miQKr/60OyID/1kzKwhuyhbR5c7obQ5Awot6OtpIrO/UOXDgktyKAF+CQ28vHorinbsYQd8E/3SVghpwnP6mrBW4CBpMZvjEix/6vHA/TBnm+VsP5zvURyyggUJps2zhBZr6TI2pB8wBT2VNgb/k6oFyyrfFZjXzkVvp7hOv1u/Q3OSuxVoitj/ksJSzqAWVhy7tCe+5gsF5ijK8B/yOICgs3A/F3cYX53rZNTfZ0zywcEzQxq0ucoZ/ZzCADESlFZWpoyympGxFqFCLh6wfWfrUOdcVar9Z1tKGR16QVZOwWZeVDyM41WXBO9I41T0YdGPvcDzHQsaoxmZfVNwwNyh5CQRwW2dfOKsaQpPmYa2DEeDEjzp8IRbw1IR+5UqlaWEPNNAxK6Ix2Ko7J+mib5Jrr1k+TnhEUBMX328ikK2AZZw+WVAy69fwN7srhD2U6PDIFQidMCOooc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV5PR12MB9779.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(22082099003)(6133799003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YitZd3JZc2JZZC9TRnNqd2RabjNRR0JNckxDbk1wcjR5aXRQWlA1bU9JSXdY?=
 =?utf-8?B?aEtpUEpZTERJVVpCNHZaMmh6cFZqZDdBU0F3N3M0c1J6bDdoRkQ2THoxSWdM?=
 =?utf-8?B?VHJYY2xUc2JpTFFWR0tDek9yaGpFQ1Fhd2hCRTd3L0ZDa2Ivdmc4YVM3OWpO?=
 =?utf-8?B?dE9pZXI5bUM1RWllUTFraEZISmxxSEFMUzJ2QVdORzdJdHdaN2R3b3NtZXlm?=
 =?utf-8?B?TEtvVURDM2gvY0FhK3dXNzhCKzMrQTY0K01Ic29kMmFRQUY0ZjYzMlo0aUtl?=
 =?utf-8?B?ZllVWTdwNEhJQnVHOEZYZ0Q3QUFRSFZZUDFvd2F1MHVDVXlmaDFUaUpzK2lr?=
 =?utf-8?B?U0JtbSt5MnkrMHBiOXQ4eHZSVXFmL2ZzQ3d6VXlNVUgybitRb3ZleVpkZWNL?=
 =?utf-8?B?cmtnaWIzMTE0anFwbUxKRjB1SG5yY1FkM1hRMkVEUHNNNzFmSGd6cXZLZlNy?=
 =?utf-8?B?eDExQkVZZy9pTDMxaUE1Vk12MlZYNGZDWDduK0NocnBTanZqc204dHlqK2xv?=
 =?utf-8?B?VGRQZitOT2tieTRyR2xrQ2VCLzdnM05ZekhyU0FzVEtVcmwwUWtBeHplNHBl?=
 =?utf-8?B?S1NTYlBTckdEQ2V6U2ZZUHg4U216U1hjLy9MQmpGbm9VZVU0YkE3NDdqd2pE?=
 =?utf-8?B?L0FRMFQ2N0ZkSUZ6WC9IT08wbm44QXYzdHRVdThvYm9RclF6TmJVRUVxV0hB?=
 =?utf-8?B?NWFsOEFFMnZ2T3dkWDJlY1ZHU1JSMHBPZ3FkRitsNHNjMEZQZVl4N0RFb0lv?=
 =?utf-8?B?dXp6cFFJT2t0YURURlZyY0gwK0JwU3lCbkIxRTJUVVVyOVc3ekFQZGRSenhG?=
 =?utf-8?B?Z2lUdkpEYkVXN0JLSDZlaTZqZnBEaUNaM21rR2YwK29oOTFsWUU4UzZ6eW1M?=
 =?utf-8?B?b2ZGYnQwcWRNQWd6WFI0bG9JaWh2U05KM3d2bDBkVzFhVlFQaStmaVdwNjE5?=
 =?utf-8?B?SlJYU0s5cE5EdjI2b2tkeGZRb1RXNWdYUHFXa2xYUERxUDlGVXJNYVZ0T0cx?=
 =?utf-8?B?eTg4RUQrbTBCeis4T1IveEgzMWROdTJ2bjREcDlSdUxmVk9DUWdGQUdaWDJu?=
 =?utf-8?B?UmtCV2IzUVpGRW8wTDhvOENqZ01oUGJUQTZRSlBnRGFGYndwZXBPRDdkamJF?=
 =?utf-8?B?OXhGNTlub2pKZWx4WWlXeE16SzhZL3VQNVhySmpwNDU5R3dZZmI4U0dnRnJH?=
 =?utf-8?B?NFA0L005Y25xeDY1aUFwWXlkcDZMN1ZTM1QzTFRoekhzaTdheVZmU1lPYjhL?=
 =?utf-8?B?aGNvc2szdmRMZDY3ZURTNEJBRHppVFlWbktrRVlaTXppVFQvelRrY2krTkFU?=
 =?utf-8?B?QWhmaVNQU1owajZsL0lDWnB0OU45cXJ2aTdscDM0ZzVEYjVPa1ZQVEZYMzJw?=
 =?utf-8?B?NGN3bjBXM1N6OU1PVDdrTUhSdFp6YXYwOEdOektQaEVtYWxlYUVVTG05V0dQ?=
 =?utf-8?B?MHBicTllUkZQVHkrQWZ0UWZaa3N2NW5Wa3dOWEsrVmExdVdkZDU2TnlPbDE4?=
 =?utf-8?B?Z2FWRDVQenJ5YzU5clVvL25IT2hVSi9ISHdDbnlTdWJQcXJEWStRNzIvemR0?=
 =?utf-8?B?ZTl0ZkpzTnlSSjZTdlpoZkNEbzRleUJRTkJnNlhLU1ZRSDVmT1RSR3hsRHda?=
 =?utf-8?B?VXgzdER5UHducXBvbWhJYmpCM1hhQytjdVFqS2FHbURVOG5Hbi9sRmxHZG85?=
 =?utf-8?B?Y2o3K1FPM21QN0dYUGFNM2RQcUJDYytaMnlJU2s2TUFHU2ViYWhqUHpOTUVv?=
 =?utf-8?B?eCszUktDRWRMN2lkaXpkY1dFZWxDRHJOYWl6UDNLRFZXRlBDd2dFMG1KSFhu?=
 =?utf-8?B?Y0g4aEg5MkhyUUU2SVAyZXdPT0psK0UvWk8yVHpLOW42bllmbDQ3cG5qcDRV?=
 =?utf-8?B?YXRVcm44VTAwMmNuNXc3bkZTejl0NWRXTHZ6SFVOQUxURWY3MWtGRUFZZ2l1?=
 =?utf-8?B?bUw5VFNHajVNUGd3bDNVUHFDVkFsZjE3UlE0UjliTVc1WE80eUVrNlpUbVRz?=
 =?utf-8?B?YmI0OHhLSFoxd1ZBZ3p3L0hnd1kzTTQveEtxWWFVcUtZOUJBVWlWUTBHOXl4?=
 =?utf-8?B?NnVTS2NTSGhHY1VReHlWUkYrQ1BleEFNQlR2bzY1TWxya2FjbXB1YzFVK0Np?=
 =?utf-8?B?ZnN0cGp4bk9sZlhVaDcwL0RyajhGYU9JODdlME1ZejIvT1FDQ0hyNHIyYzZt?=
 =?utf-8?B?WXdUSW9PRU9OUkVTaTRpdGlHQ1NPTkdlOGZnOGVueWNOaEp1ay9WNzNnc1Iw?=
 =?utf-8?B?a212a0Q4N3R0U2FqajNLNVlhVUcxelUvLzljL0YrbURweXUxeWVzaHJ2cDdo?=
 =?utf-8?B?amxQSWl2TXArTzZNTVlIZjB3b0hvc2VCblp4QzEyRm9WQSttei9CZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbb8d56-f5bf-41d7-557f-08ded5bce7d4
X-MS-Exchange-CrossTenant-AuthSource: LV5PR12MB9779.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 09:00:45.4014 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kjKdZI1pYrQsy43NpCxul6pusaKq3/QuOxw539o03ILBcciWTqF/A23JC9D3+UId
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

Hi Tom,

On 5/11/26 10:31, Michal Simek wrote:
> Building on commit c64fc632a86a ("riscv: cpu: Use CONFIG_IS_ENABLED(CPU)
> instead of plain ifdef"), add an early return in riscv_cpu_setup() when
> CONFIG_CPU is not enabled. This allows platforms to save code space in
> SPL by disabling CONFIG_SPL_CPU.
> 
> Without this patch, building U-Boot with CONFIG_CPU=n and CONFIG_EVENT=y
> is broken: riscv_cpu_setup() is registered as an EVT_DM_POST_INIT_F event
> spy, and when the CPU uclass is unavailable uclass_find_first_device()
> returns no device, so the function returns -ENODEV. That in turn makes
> event_notify_null() in dm_init_and_scan() fail and triggers a boot hang
> ("initcall initf_dm() failed"). Returning 0 early avoids that failure.
> 
> The compiler's dead-code elimination combined with --gc-sections
> removes the unreachable code and all associated static data,
> achieving significant size reduction without preprocessor guards:
> 
>    spl/u-boot-spl:all -4332 spl/u-boot-spl:rodata -2872
>    spl/u-boot-spl:text -1460
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Reviewed-by: Yao Zi <me@ziyao.cc>
> ---
> 
> Changes in v2:
> - extend commit message
> 
>   arch/riscv/cpu/cpu.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/riscv/cpu/cpu.c b/arch/riscv/cpu/cpu.c
> index bbadd0c9a469..3bec7c7cb6d0 100644
> --- a/arch/riscv/cpu/cpu.c
> +++ b/arch/riscv/cpu/cpu.c
> @@ -638,6 +638,9 @@ int riscv_cpu_setup(void)
>   	const char *isa, **exts;
>   	struct udevice *dev;
>   
> +	if (!CONFIG_IS_ENABLED(CPU))
> +		return 0;
> +
>   	uclass_find_first_device(UCLASS_CPU, &dev);
>   	if (!dev) {
>   		debug("unable to find the RISC-V cpu device\n");

Can you please take it directly to next branch?

Thanks,
Michal
