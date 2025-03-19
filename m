Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A967C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:33:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7F55B82063;
	Wed, 19 Mar 2025 16:33:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MAWeGyzH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 138048141E; Wed, 19 Mar 2025 16:33:15 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2062a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::62a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EE81D81FFC
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:33:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qGOreJAqR2671X2ReTB14k3ZWqoNEd6edN0CG/JqcUl78glqqLLNTQjgSWdHvBEc61YSg1Q84ys5fOOiTVzn6f728XVQYPGTGvqCeb3iZRTw2XvUY4jEKefPhja9N7QXRySxbqiNDpxYSzzSDFhDzRFnyd8eoL2e2Pw4g33PGEfuh21vPJWeJ9Wq+8p0wP81t87gmnFAyY+IbHtcw8HGPv7im7plS2rubt98diVOFLlkeeNPxnzhkUoCxO4FtAHArEj9fq/OQpqLziP4CRnKMvAPE0lVf7B5HCkpbcm0BX/b2k3IFclQkQJSRPI6kku5MKvMhRha1duailY8axQ4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTAfnah/grdnxvgzl75JyJYduaFritAooID//e67mxQ=;
 b=F7OUTUdjD4lPxhSaUqP00MFgvtuA+DaaKxv3f/owYn28ofNkj83mwgfu4W8I/esfuA5EydexhiNrAmto+bCym3Yo0So9W/KFs//WSOXrv0XZMD05m2j+F4Q5YRActIvmpcAYhcZe1RJEdoJAaQnREANNSjRL+Y/sckAjPhAt09rrNZjckWB61N8PV9+dfdRxFh/Rx2T4WSf2zBJ0tCUxLeQmQY7AYndseHu7Q3HFWsPdOTJRBn/n4yzUxD4jie4gW4m7UB1cNac//QUiNrCpT/n4hKBPUwZtGXUa6+kqicHAW4sQf4v7AhAzc0d22KaxjtY+LFGoKeOOJRc5UMc98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nTAfnah/grdnxvgzl75JyJYduaFritAooID//e67mxQ=;
 b=MAWeGyzH7No819pvfXxLsAQCRuLAI6QkZgAPEtFgk6BEsuYcCzBRp7pib2Eng3rY9z0hkUoFe0oNHMkgyAvu+bjJ8vpMrr15+uwcdgLuNpYnptZSLV6ZZFu6YOIN4nFHYnYr9M8Uw54pWe0q2McN6kkZ4MdCq1eNR/A+/ifNAN0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA0PR12MB8983.namprd12.prod.outlook.com (2603:10b6:208:490::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 15:33:10 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 15:33:10 +0000
Message-ID: <20491107-8d81-4af4-b5ea-2659f2be872e@amd.com>
Date: Wed, 19 Mar 2025 16:33:08 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: versal2: Disable debug console
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <aa122482cf5b32ded4497469cac1829c6944f0fa.1741868926.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <aa122482cf5b32ded4497469cac1829c6944f0fa.1741868926.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:208:32f::35) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA0PR12MB8983:EE_
X-MS-Office365-Filtering-Correlation-Id: ee2a8a17-1085-4b7c-e543-08dd66fb5ac9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VlZ0bFdCems1VVJXbzhCMFVjWnFQZnU5WWhHalBETHRmRy9yTnNxQk1NUFI1?=
 =?utf-8?B?VmwrdlhRUytWWGs4T1FtOU8wLzh0WkJDYjRjc2tRVUVQUktjTThVRzFLTjdS?=
 =?utf-8?B?ZHJqSUZDUWR4ZmlxOENzM3lLR0g0YUk1LzIxejRyMHF4Z01Fa0ZzMmtQR3dt?=
 =?utf-8?B?WDBTcGNRdVNVMXNNNTkxcWFlSk5vL2lXaXlaUkFYMkZVWTVSaVNSdXJ6Nkww?=
 =?utf-8?B?NDJQanlrWitnWXZBL2VsUWlBVHUvc0VWSEhBcmRIWVJIejQwdUk3Tkw5Q0Rq?=
 =?utf-8?B?anVDWkZlRHBseklnMDRTN0ttcXBoQk9xblh6ZWJ2bmZveWtmS3M2MGRURE1E?=
 =?utf-8?B?TTVvVFEwQXF3Mi9IVHlrY0M5d05ONHg0MjRYYzgzWVNmMEhVa3dLL0J6UkY4?=
 =?utf-8?B?RGZISDF0OTNPQlRPNjdKQ2VSM3NsS3FZaWFGZVkyeWc4R0dlcDJhMnoyMmlh?=
 =?utf-8?B?Wk9COEd6UENOWlVaN2FmUDE3VjF1M281OFhJS3Y0c0hhRmJPTU5NWWMzeWpp?=
 =?utf-8?B?OHpxL1ZDZTN1N0tDSEdTQ3I4bGNzcHZ5RlpxUTE5dkd5QVMzN3hxY04wenlt?=
 =?utf-8?B?d09HZGhqRXZNNDVTeTBJbWp0a0FhOWtzZytERFZJa3dLQ0tmVVVMd2RTY1V3?=
 =?utf-8?B?NCtDMVdWc1BkQjQrQmgxaldaMW5rRjBtSGdsUy9rdUZta0NFNEpxVDBxek9v?=
 =?utf-8?B?QjRZSDhBenhGVllDcjdWVmZoZklnaTdvS3R4ZjdYWWdoa0JKTmdoaWFzU0Z4?=
 =?utf-8?B?aTBWcGNkditsYnI1bUdVZlNWU1dzMVcvcVk0T0JuTWdZT2VCQm5iS2NHaTNJ?=
 =?utf-8?B?eWxmSXRsMjJzS2R6VTgzVXlETE1qN2tISGhpYjFuczFOQUNnYnk1VXh4eEFh?=
 =?utf-8?B?Y1lJVTV6bEY3TmF4RmZ3ZUtQdDQ4cm9hSWxBcjQxOGpDVkNXT1VGcVpMQXI5?=
 =?utf-8?B?dEpWbERJYUFZVTEvV0dGbEdzRXZSRmMwNFRKNUE1UVA1NEJvV2FydnpDY3Z3?=
 =?utf-8?B?cWZuK2FqeWxiQ2M5K29LVTBDdGE2akV3V2RkeGI5MjE1WkpveUljT3lMdTZY?=
 =?utf-8?B?RERDSVluV2QwSms5ajFmbzJjYUM5UzRmZUxETm9QVDBlY3dJT21Idmk0VzA1?=
 =?utf-8?B?ekVjejBtbm1uZVpvREdrTGxsQ2U2UGx3RnBkYlZLbnpLbHBhbUh0YTdJRnNv?=
 =?utf-8?B?SmducjBXZ1R5QkVWSnFXT2owdkM0ZSs5dlk2Y0t1cnZ3QWJJVm45MU5NSUtP?=
 =?utf-8?B?OCswMnY5aGdCUUNwYy9TbVdSTXdUZkh4QVM4OWpwS051eEtFdFliVHZGejZv?=
 =?utf-8?B?VGtvUytHR1NvTjVUOUk3WEx4dUNSRnAyUjFjcG43NFF6dHdSaDU4ZlZ5SzNU?=
 =?utf-8?B?dGZBR3pWYmlxd3Y4VXhRUDFNYmNHM2IxZ1VUdGpRT3ZWa2E2T1E4cWJpN2ha?=
 =?utf-8?B?SXVZelVVd1JhSk1OOXJtM3l5OFpvenJWaTFnbWdQTmwzMkxoZFNaTUtBZ0V0?=
 =?utf-8?B?R3Jtd1FqTWpibko5QnZpY0ZuMk9FVCtTUHRmbXJKZ2lFTGlHRjZhelVDdlJi?=
 =?utf-8?B?Qk9ZQTYzOXN4M1EzTS8zMnVPS1FaOHJWaitGSG1tRDVnYTVYc21RNDJiV2Ft?=
 =?utf-8?B?ZUFTUTFDRTR5V2MydFNOS01DeVNuZUk0Z2dwRHJ0akhjbGg1NkFycmkrcUJU?=
 =?utf-8?B?L1JjaUhYZCtzdExDbXBCQmNCcWVKWnlpK3FKdzdFVnovL0o4QTUzOGdYOEo4?=
 =?utf-8?B?MnhRRWpVdHg2K0ZUMDloeXlNMStVWjdtZVhGYjNEaWFnNUNNcG1KUzRSeWhx?=
 =?utf-8?B?bkZtamw4MVJqYU9MRElFTHdhdEt0dlhRWlpWYklJdk9hdTVzOWxLOUxuQUVz?=
 =?utf-8?Q?InuoVPsixlJ+h?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnpuUjNkd0FwZHFXQ21OWnFPRm5NZ2xKTHNyeHZjYmhDdVhtaGx5S1d6bFE1?=
 =?utf-8?B?UmlrSktOd0cvOElaUm4vSXdld3EvdHJFdk5IRkREWTlQQ25KRjAvWDBoaG1E?=
 =?utf-8?B?MmpSMW4ybFFMQlBIampFZ0Z1U1Rzc2FyOUpocDdTWXM3SFR2T3ZDL1Nlc1ht?=
 =?utf-8?B?UkJjUjBXUmZuQjBPd3NMUk9rSW1iQWxxTnR5WWlQbDVnSEwydnpNcXRsYUNz?=
 =?utf-8?B?T0hKdm5wTm82WUZvMHMyYURlQ3UrOTJ2aUxxL3FqemxBeVJsY2g3Y014K0VO?=
 =?utf-8?B?TEZTa3dPSXkyeFlIVjBUeTBHN0s5RzFVSm0vNDFVQW1vY1UwTEQzUXFMV1g0?=
 =?utf-8?B?ODdGWUNMTFc0MGxOdXdrb2t6TVRmc1lzYnoxZ3l0MjdBTU5sN0ZZTXl4VDEx?=
 =?utf-8?B?eWJYSkVKZ0cxU0NtL0dlZWJZSEVsMUx1bXMzRVFhS1pWS3lGd211UUs0RFl6?=
 =?utf-8?B?TERxNlpKQ2N4WDJydVNnakdUZGNsMEFBWFIrbG9ETlRIRVZhNGxOMjJpRkM0?=
 =?utf-8?B?enpPOHFzS0cyM3NRNjAyUExxcUdXNlVKME90cFpSMnYvbFJjMkkxUUs0NUh6?=
 =?utf-8?B?ZHpPTXhOSHJ1T1VtUGpBRnk4Sk1Jc0k3azE3NmRRb0NicjAyU0VNbWVtdmhZ?=
 =?utf-8?B?Q0hCeGNQdUZMZUMvM2RzaUtCZWRTdnlWaW13aDF1RFFBRFc5LzFhMTBYWWEw?=
 =?utf-8?B?SlJaOTEvejlzZ3IyY1k1VVdqS1hMQXNtdzJTS2V6NmpESmMzYUFIV29SaXEw?=
 =?utf-8?B?WTVNbGNZUmQwTkNYelYwVVFqeTZCQ1JJWUJ1Qk1QTnE1czJxeVUrcmFnR2Fp?=
 =?utf-8?B?MEs4WlNzVHExRjNWMGppNWNiTnozendXY3ZRMGoyakV0dFBMTEhBOVBNd0RN?=
 =?utf-8?B?bzRZTzRGY1BnbTZiRklZMGFJWGx6QVlKYUgvM0NiVTFGS0tGWklVQWFrb0NW?=
 =?utf-8?B?NHdnN3pHUWJJb0dzQWIxekFEVU1KS3RqWVZDZEhOMThBRGdlS2s4bFpjeVUr?=
 =?utf-8?B?MG81ZnNTNEZ3Qm9hZjk1OHU5V1dvR2x3QUNPWTJlcnFXODgwbUttTCszdnRu?=
 =?utf-8?B?djVIT0NJQk9GcWhRRFltc0hLbURrR3hCcGVhWEFxd3ExdnpFTGZ1dnNFeTJS?=
 =?utf-8?B?M2NnY3pSL3pZaFAxMVZZR3hUTjZrTjM4cGdUM1NBeEVwRDV1TjI1WGhnUmdJ?=
 =?utf-8?B?dDdBR0E1Q3JFZ3o1aUNYS0lQemY2d2JIbVdWSkxLSkFYZlgrQ0RZRk15ajNo?=
 =?utf-8?B?ZE52dVIzaktPWWRiWDgrYm1zQ2hMdnRQUXVoRVlCVmRyWHJseUsvdjBKUmJu?=
 =?utf-8?B?WWQvdFhzWjk1VVlPZVd0a1lwemNyYjhmZUJZc0Q0UU9uUkc2eVdmb1locHNh?=
 =?utf-8?B?YnNoT3pRQWtPQW0wSTdRN0dhTU9EOW1wUFI5UGI5QnhzWWFqc3Z4NldoZUJy?=
 =?utf-8?B?b1VvTXY5YzY2M0Z1K0M0UkRsanE5YlY5c1lEakdsWGJtU2w5cTQxWVJ5YldS?=
 =?utf-8?B?ejl1TTNiS25Xa21MUmVHUnBHa245RTBNMzVUN3o3TVVvMGFkUElCL3Z2M0Rh?=
 =?utf-8?B?a2ltMlNwV2Ewbk9xd0VJcDBRRzgwZG92eXc0SWkyTWtWNDR6SVM5N21MUEZI?=
 =?utf-8?B?dkhOK1hweSszUmlPSm1sRWZvYU9KT3ZVMzhZYUkwb3RUdUl3bzhSU3VaV1FK?=
 =?utf-8?B?a293T2FNcjRHdk5zSm1TRUljcE5hTjZnbyt4ZVdVcjU4SzVWc3FlNTJVVWtY?=
 =?utf-8?B?TjNGR29ZWW1mTVdPV2l1aEdWVHBpNXpFbG0relNXdE9BS1pXc0RqNVdPd3Np?=
 =?utf-8?B?VU5xNTJXM0E2WEEyUzVFUTVqY1hZb1oxVjFvWnpXTnVtckcxa1lYM25mdkJH?=
 =?utf-8?B?UUhLVDRoQ2hZb0dnNDBYNE1XWjROaC9jeXZFMkI3MzRDcGdLeHpJcXFWZ01V?=
 =?utf-8?B?dGwxOW03M095VmFIcUpzRzhwVlByY3hIN3BSaFNxZUVNL3FUT3UybDl2anJk?=
 =?utf-8?B?MHdjTDkvc3Vmb01zS2swblYzNlpBOURicjNXZnR5N1NVOENBQmYyQzNPT3NT?=
 =?utf-8?B?K3VhTkJ3WGlYbjhkNzgvaEJkeUZtWjk5U3JNeEF2bzlnU3ZWZDBicy9LL1pG?=
 =?utf-8?Q?44YLMbFAVOmIcWyPMH9+T8fX1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2a8a17-1085-4b7c-e543-08dd66fb5ac9
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 15:33:10.4141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zifuo55Oh7LLezIPZuv1skRTmcZ7hIRk4vkMTtJY4+u6J9aoK4u0KI5gdGL9rfjp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8983
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



On 3/13/25 13:28, Michal Simek wrote:
> Platforms can use uart0, uart1, dcc or even any other console that's why
> disable debug console. It should be used for debugging purpose only.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   configs/amd_versal2_virt_defconfig | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/configs/amd_versal2_virt_defconfig b/configs/amd_versal2_virt_defconfig
> index a80a62612397..59bda4c71fb0 100644
> --- a/configs/amd_versal2_virt_defconfig
> +++ b/configs/amd_versal2_virt_defconfig
> @@ -10,10 +10,7 @@ CONFIG_OF_LIBFDT_OVERLAY=y
>   CONFIG_DM_RESET=y
>   CONFIG_SYS_BOOTM_LEN=0x6400000
>   CONFIG_SYS_LOAD_ADDR=0x8000000
> -CONFIG_DEBUG_UART_BASE=0xf1920000
> -CONFIG_DEBUG_UART_CLOCK=100000000
>   CONFIG_CMD_FRU=y
> -CONFIG_DEBUG_UART=y
>   CONFIG_SYS_MEMTEST_START=0x00000000
>   CONFIG_SYS_MEMTEST_END=0x00001000
>   CONFIG_REMAKE_ELF=y
> @@ -117,9 +114,6 @@ CONFIG_ZYNQMP_POWER_DOMAIN=y
>   CONFIG_RESET_SCMI=y
>   CONFIG_RESET_ZYNQMP=y
>   CONFIG_SCSI=y
> -CONFIG_DEBUG_UART_PL011=y
> -CONFIG_DEBUG_UART_ANNOUNCE=y
> -CONFIG_DEBUG_UART_SKIP_INIT=y
>   CONFIG_ARM_DCC=y
>   CONFIG_PL01X_SERIAL=y
>   CONFIG_SOC_DEVICE=y

Applied.
M
