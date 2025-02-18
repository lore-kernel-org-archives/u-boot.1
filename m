Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4099C021AA
	for <u-boot@archiver.kernel.org>; Tue, 18 Feb 2025 12:49:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11023807C0;
	Tue, 18 Feb 2025 13:49:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="C4v1F6mY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D056880ADF; Tue, 18 Feb 2025 13:49:39 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on20624.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::624])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 208B98043C
 for <u-boot@lists.denx.de>; Tue, 18 Feb 2025 13:49:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=love.kumar@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rSPFR22H9E8PB808Guqef8Fib7ZupblxtJwgOwOBdj6wvJGkfizxu0PG3in+yzAZ0bLPw0henpoIkgZg5NFrTrhSFoDdoj1jvhZs+mU2kr/WY6E+YuFCwKlyO5wSl9WEMJ/1wBErpf8LgBBFJocbQidMOgZsiKeB1Sls6fcGi5u/nD3qlUcsPbCqmG/66aTgMcNe1WizcKfe6F6VQBE7CssTEdPl225c/yxBJJ07o8Am1nlS2xBl5bCNeHA3Zze4H9IZD9DnNJ9ac7Ffbw34gV+ynKD8rOgS2WOKDcw06Y47Aj1hvwnK+DgvW3dnPgce1C5v9A6/NaTvOOzjzeklvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LSwpdgjwCzBCwHdmr29gm4qHoBdiv2/Ym0Qd/WTfJSo=;
 b=QFCMpczWkHB77oFUjHSUXsV1lcmooyZT1EYA+9pU/aVAx/Wj6DokiWRBKXXz5UUjAFcDInKaGB9iP5poVAnAmoFIshXzFUX7SL/fPY0eZTDtOLDLGTa8cfEs+D/H3wScx3ZGQKJjflUmsj101b8ahqjocvhfk/w/jHbHVv1kjXx4f+7ygFjx62JC6FTTIC6yO0yxhRwv1GZxmTg4IyN1QKq9Vk/AGMWdEmLIsj5RtGTPXG5vhogU2l8qWqaXgE3Ed2xl0J3ElAv35BnlwirSIjN1Bvsg7I10sMZ6CVYEKtwJ/kytDvEGoBSbqKfEUqTZWlE9C0mJoQreXcBtec8ucQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSwpdgjwCzBCwHdmr29gm4qHoBdiv2/Ym0Qd/WTfJSo=;
 b=C4v1F6mYa4mbGW2zoxUAy9N/e0+upJlJQVnE9/OIlX7/0v4PCR4N7SHnH5e2OZ5YAP3n2jvH2d44uk7BeBpE+caH1hpl/AiT1kRKv+XMyTFRdxGBowVcneG4bN7adCS6wQTexQerUrSsviDj0Htw75FO1cag6jnlPDW9wmylLLs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6538.namprd12.prod.outlook.com (2603:10b6:510:1f1::11)
 by SN7PR12MB8170.namprd12.prod.outlook.com (2603:10b6:806:32c::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Tue, 18 Feb
 2025 12:49:28 +0000
Received: from PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f]) by PH7PR12MB6538.namprd12.prod.outlook.com
 ([fe80::f0e4:5de5:39b7:ea7f%6]) with mapi id 15.20.8445.017; Tue, 18 Feb 2025
 12:49:28 +0000
Message-ID: <2926aeed-be69-4b5c-bc0d-f8bb425faabe@amd.com>
Date: Tue, 18 Feb 2025 18:19:19 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: versal: Consistently use enum tcm_mode
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Charlie Johnston <charlie.johnston@loftorbital.com>,
 Michal Simek <michal.simek@amd.com>,
 Padmarao Begari <padmarao.begari@amd.com>,
 Prasad Kummari <prasad.kummari@amd.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250206213039.42756-1-marex@denx.de>
Content-Language: en-US
From: Love Kumar <love.kumar@amd.com>
In-Reply-To: <20250206213039.42756-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0139.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::9) To PH7PR12MB6538.namprd12.prod.outlook.com
 (2603:10b6:510:1f1::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6538:EE_|SN7PR12MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: c8a86204-497a-437e-59b1-08dd501aae18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NlUzN2N1WlZzNTh1dXZzUDdzY0daN1M0SjEzWWdEM1JKMzVVYTk4cGJDUHFR?=
 =?utf-8?B?S2ExQjdhc0VnK0VnOWVSNFUyc1hpSy9NVmNkQWxWVmxJUWJEclJ1UHlzcEhI?=
 =?utf-8?B?bXNRcmI1SGJUUnJNNUZBeDZ4WTE5dE1jZ0t5OEtEY1g5TGdDSkpDNnRvdnF3?=
 =?utf-8?B?UjZqSmVvYlJ0ZkV1VERlNXBJMnJWaWNGWmJFNEJFNnZHL0NjQzVCei9KcmFq?=
 =?utf-8?B?SmgrYnRYMmZQcXUxQ3R6aDdQWmVRd2JvbjNVSjVQa3Y4Wko1WTdmbVJyQ2Y4?=
 =?utf-8?B?cWVycnViblIvTU1IOHQwQWFvOHBkMVhmYm1qajd5UlhCV0dNM2JZZ1RSeUZs?=
 =?utf-8?B?R1FZWVpHYmoyWW5WbWVUbDFIUEhGZWFtOWlkcy90MlJiL0p2Rmg5M09Rcm5n?=
 =?utf-8?B?VmlhM0NuK1FYMWtuRTgwaGkrYUJNbGZJUWRkZkQ5SVk0a3dXSHpSUEw2Wmd0?=
 =?utf-8?B?ZEtZdDhrUWQ2VkVrSjZ0emE2QW01Zk5EeWs0WmpZN052VURjRVdibWFXTUxB?=
 =?utf-8?B?b0xVUDJYKzdkejhlN0R3SlpxVlkyUDFRbG8vdzZ1aTZQWU9MZlI4NW9Wb0xs?=
 =?utf-8?B?ZVMzSVlHKy9TQVFSN3JNMUtEMDVtV21QcWYrRndCOFovZmhFbzE0SDVlRU9I?=
 =?utf-8?B?TEk4ZUpKYkRhN0dweStzaTYvR016SWFOMXlpYzBubjhDTGNHcFlMNG5ueFlJ?=
 =?utf-8?B?RW5USkJNL3ZqbEJZQks0WE1aS25JQTFISXV5bmZibmRJakJib0NORzdXcG13?=
 =?utf-8?B?T2FzMEpVM3FhYy9iMlB3SC8zci9YTVh5Ni9FS2s0M1NRNHp1RzY3amNYS2VF?=
 =?utf-8?B?akZnTjFvaWVXNTg1SlIyb1ZwK3NEZW83YndYc2x0OHlrWDhrVzVVSnJlSmtE?=
 =?utf-8?B?THJwclVCdE9QWGdhZmhiZjM5RFYzd0R0VloxdytHS1YzQ2hWSlBZVUpjRjFi?=
 =?utf-8?B?UG5uRWdNQ1pTS0JCZFhMb2Nta2FRVmFoazA5cXBTVXh0R3pPVmFMeUlBSjRi?=
 =?utf-8?B?YzA1aktPVzJyRTRPNlZMcWNxN2N5Mkt1TThzUU9qa1lxdEN2UVlOalBJek5V?=
 =?utf-8?B?RnplalpXcUNJRU1aU29RRjliWlQzN0JaY0Exa3pVb2F1TStOaGFkT0psNlpC?=
 =?utf-8?B?cHZnWHlBOU8yb0JxaEZBb3g1NFFNcGsrNG12RlRySWZ2S3RHM2VXTjNYSjIw?=
 =?utf-8?B?TlFFWVYxR3RLLy9lTnZSODJab0graW5kcFVmSU9zTDRQd0dZOGlKV3UyTm11?=
 =?utf-8?B?YTBQV2l0N1ZMRDlJZVRBV1NmOGhQTG9kYjUwdTFRU1FGNk1xM01iMFVJRTBt?=
 =?utf-8?B?N243Z1VOc1lkbnZ4bno3Y3ZnRC9CZmluOGZFY2RIL1lmallhak9vRGNmTWVQ?=
 =?utf-8?B?R3NDaVoyTXVXVnYxUEVUeWErREN3bXBESDJFaHY3VHhGT1l5QUxxalFFaHM5?=
 =?utf-8?B?SzBEZjBsRDZwQnBzTkVTZ1lDQXY5NEVYM2lOaTl1YkRvaVNrbFp3REFyTDdm?=
 =?utf-8?B?RTFqRjRxc3N1ZFFUR1ZMSEIraFJZYU9mNVRlbSt4dnVCd29tNHBRZlZLM284?=
 =?utf-8?B?eTdLcUJvN3h2OHM0Vk1KTVhCWVJCSjJ6Tnk2a2hpQVFZOWpJaDdtaHZoYkMr?=
 =?utf-8?B?ZzFUbzMxZlBFZXJTSXNRSWppa1BEUWlsMG4wSDBoVTVCcnpQSzdtRGJ4T3g1?=
 =?utf-8?B?RFpHS1RTTmwxY0ZoUmRZYmJJZlBkTkdOWDlCejlqV1lOZ3VKdUFEVWtsdTFZ?=
 =?utf-8?B?dlcwaGRQOUlMUmgvN2k2S3BDSHJMWUkzT2E2cG1TTjBpY0hJZEloclpuZmJG?=
 =?utf-8?B?cXFZY1JKMk9MYlEzSXJOenpaZEZvTzYzeXRqT3N2TWorVlpCakkrTkNmS2dy?=
 =?utf-8?Q?AUSedYc8+vJMI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB6538.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWRPdUVWVGRSWU0zaTNMS3pBY0VmcHJod1Jqb29nbVA1czJvWjVwZ3R4cFRX?=
 =?utf-8?B?NTBDWnRtR1ZrWDd4Wnc2aS9HQWhaZ2ptQUZCVmtWRjRJMnhlY0MrcUNIZ1hC?=
 =?utf-8?B?WnI4SjhVTXlPTHpYQU5oZWpmNVc4bThRTXo4RHJvZzRPVGZVbnp6YkprbXpK?=
 =?utf-8?B?VlJwdkZwTUptNW84MnhGS3NjRStxcGpFTkZIVXpleWxJZ1psa0h5SzM3ckdH?=
 =?utf-8?B?cFo5NUZqQ2l6VTAzVUFRYVRYbHJjcXN0dDJQYnY0K0l6ayswdFdCTlZxWnR5?=
 =?utf-8?B?cWJmNTF1TVpoZ2RvMWlsUDZMQ3BaKzR1eGtESCtFcUZGejBwNzFVNExRcEdR?=
 =?utf-8?B?WjVkWkdTY0o3RHIwRmZYVW5GR1cyZ2pkN2E0d3Rzb0c5RjVUTHM0ZnZDM0R0?=
 =?utf-8?B?QllEb1FlRHlRS3ZtTFhtKzE1bUlIeGhXMys0YmUyTlYxeTB6Ulp1OGZQbUEx?=
 =?utf-8?B?QnJmZStJYWtSUUs4Uk5tTTlNcjRjY0xOMDZFQkl4U29lcms1TC9qYlBoZ2R2?=
 =?utf-8?B?aHYzaGJEY2xid3Y0SG12elhsdDBBWlNmQzVrcW9WamUyRWd6T0djV0FvKy8w?=
 =?utf-8?B?eGN6bTVLYklvQTllNFNxQmNGR3ZEZ3BVRlNBTkdLQis5UDQzTWc3NEhFaG5J?=
 =?utf-8?B?M1dIZUI5aEZURzI0cmVlM2VjYzh2QzBpRTNDU3FqdFprWkdiNTZsamg0ZjZv?=
 =?utf-8?B?ZGVkU1JvNUJKbVVyVlNaeVNSMmlJdVBuV2c1VEpLdForWmVSZDFwTUJyZTRz?=
 =?utf-8?B?M3F0MkZSdHpVWU9rV3c4eE5PZ1FJZFpzZ1hKV3JTcjVLTGlUNFdBckwyODB3?=
 =?utf-8?B?LzVEaHl5bEFCeHdVa3hFYXUwdGZTZjFUbGhNSDdNSUNkYVhGWGNWZmhIQkFZ?=
 =?utf-8?B?dFhEQmNxdGU5ZzZoSzdPTk5RejdJZEJma2Q2SzhHaWVsZktLR1hJSzNHc3hB?=
 =?utf-8?B?QVA2cjBuQWRHSE45QjkwZytZMVhzaGJHS2pQamh6b3RJOEtUSnZFY0FJbHEz?=
 =?utf-8?B?UnpGL2JpcU9ZT3EwcktMV01Ddmt4TmtpUGtWUWI1R1JvR1QzMFgrelhnVXVx?=
 =?utf-8?B?TjZjV3NMbmRhci9rSFZOcXA4d2EyV3hCSnBuUDZtWWpoQ3gwUDN1UStVSHh1?=
 =?utf-8?B?TlhuR210bTN1QmRkUU8yV0R3eTB5N3JrenBmNVVTdjN6Um5zQmlYZThDWnpq?=
 =?utf-8?B?TmVRNXdCN1VlQ2pDdXdKSDY3Q1hpVFNJZUNZWGRsM0tCaVhCd3JHcmU5OERC?=
 =?utf-8?B?WDY3TkpiTjVJNFRxVnlURlQ2TzZjaDYyZkllanZmc2U1eDJyekdzRmdlTFdL?=
 =?utf-8?B?bFlseWFoM0JDbVd6bnVnMnFxS1JXeElvOEk2RTgrcmtqQVViYVRWQzJYMlNw?=
 =?utf-8?B?ZUpqeEw4UTB5OTFHaWNxai9XR0RoeUJlRkFFWWdVZ0tNR0sxVTZjb3IwZEpu?=
 =?utf-8?B?TXBHTEI2d2hQYTFpbGQvZEdEeElOcmxiZ3FBUUNvQWdvWlV3b1lobnFNQ0dt?=
 =?utf-8?B?WnY1eHhvc2RYWExvR1lEWHhtZHdoYmp1dE9LWDV3OXYyd0dGV0VBNmtUczR6?=
 =?utf-8?B?Mm9nVXdwYnM0SThmZ1pPTGlJby9pTk15U1FjbHFQS2V5dmtCaVJqYlNKYy9G?=
 =?utf-8?B?bXRza2VQaVlmZUxBWnpyWUw5VHBHUXB1WnkwTXhZN0NQcjFKc1hwQUlhUHFy?=
 =?utf-8?B?dTRReWxkMW9NNjBnbjBZYlFzNFNZNFhMNXhNT2tQL2JmOG1QQVAxcmxnb3R3?=
 =?utf-8?B?blNiVHZNcTBOL0ppRllnQUNNdHBvQzNlb2R4TXNMMVE2ZFN5ck1YNS9nWjBx?=
 =?utf-8?B?ZWJ4czFTcDVGVHpOMW13ZmhWYVZVMVZFQk1aUk5zczhXc09lRkYvdzc4Rkpy?=
 =?utf-8?B?WGxIVXRLdWpMRnJZNVQyK0pWUE5KMHh5MWsrQmduOVZhRXJxZklncTUvQUp3?=
 =?utf-8?B?NjZQU01ldWxnc3pvUUkweFg3WExONXY4dXhLd2VoaFErN3h3L1VZOFJLMFRU?=
 =?utf-8?B?Rmx6MWhtUUVsNkRON1VnNmJmMTlIOGtvVEQ5RjdKUWtFVW1Mdm9UYUpWMytW?=
 =?utf-8?B?eHVpZTAzOWtsVHpTOHh4dHMxa3pqd1VrWXovdE5TYjFtL09BMExYS1FIZngx?=
 =?utf-8?Q?g6UaWN3h5u+QZY7atPJYe2fGj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8a86204-497a-437e-59b1-08dd501aae18
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6538.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2025 12:49:28.1912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gjxuHqE4QC4hs3gPTIWMRcomOccfzpRG96rB6CVZ3qxmryGwfzOCqrax1QQ+rq8C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8170
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

Hi Marek,

On 07/02/25 2:59 am, Marek Vasut wrote:
> Turn anonymous enum TCM_LOCK/TCM_SPLIT into enum tcm_mode {}, set
> TCM_LOCK as 0 and TCM_SPLIT as 1 to match LOCK and SPLIT macros in
> mach-zynqmp/mp.c, and unify all the functions and their parameters
> on this one single enum tcm_mode {} instead of a mix of bool and u8.
> No functional change intended.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Verified it on AMD platforms and didn't observe any issue.

Tested-by: Love Kumar <love.kumar@amd.com>

Regards,
Love Kumar

> ---
> NOTE: Compile tested only
> ---
> Cc: Charlie Johnston <charlie.johnston@loftorbital.com>
> Cc: Michal Simek <michal.simek@amd.com>
> Cc: Padmarao Begari <padmarao.begari@amd.com>
> Cc: Prasad Kummari <prasad.kummari@amd.com>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   arch/arm/mach-versal/include/mach/sys_proto.h | 10 +--
>   arch/arm/mach-versal/mp.c                     | 12 +--
>   arch/arm/mach-zynqmp/cpu.c                    |  2 +-
>   arch/arm/mach-zynqmp/include/mach/sys_proto.h | 12 +--
>   arch/arm/mach-zynqmp/mp.c                     | 81 +++++++++----------
>   arch/arm/mach-zynqmp/zynqmp.c                 |  2 +-
>   6 files changed, 58 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/arm/mach-versal/include/mach/sys_proto.h b/arch/arm/mach-versal/include/mach/sys_proto.h
> index 757bd873fbe..a6dfa556966 100644
> --- a/arch/arm/mach-versal/include/mach/sys_proto.h
> +++ b/arch/arm/mach-versal/include/mach/sys_proto.h
> @@ -5,11 +5,11 @@
>   
>   #include <linux/build_bug.h>
>   
> -enum {
> -	TCM_LOCK,
> -	TCM_SPLIT,
> +enum tcm_mode {
> +	TCM_LOCK = 0,
> +	TCM_SPLIT = 1,
>   };
>   
> -void initialize_tcm(bool mode);
> -void tcm_init(u8 mode);
> +void initialize_tcm(enum tcm_mode mode);
> +void tcm_init(enum tcm_mode mode);
>   void mem_map_fill(void);
> diff --git a/arch/arm/mach-versal/mp.c b/arch/arm/mach-versal/mp.c
> index 921ca49c359..7423b8dc312 100644
> --- a/arch/arm/mach-versal/mp.c
> +++ b/arch/arm/mach-versal/mp.c
> @@ -24,7 +24,7 @@
>   #define VERSAL_CRL_RST_CPU_R5_RESET_PGE_MASK	0x10
>   #define VERSAL_CRLAPB_CPU_R5_CTRL_CLKACT_MASK	0x1000000
>   
> -static void set_r5_halt_mode(u8 halt, u8 mode)
> +static void set_r5_halt_mode(u8 halt, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> @@ -45,7 +45,7 @@ static void set_r5_halt_mode(u8 halt, u8 mode)
>   	}
>   }
>   
> -static void set_r5_tcm_mode(u8 mode)
> +static void set_r5_tcm_mode(enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> @@ -63,7 +63,7 @@ static void set_r5_tcm_mode(u8 mode)
>   	writel(tmp, &rpu_base->rpu_glbl_ctrl);
>   }
>   
> -static void release_r5_reset(u8 mode)
> +static void release_r5_reset(enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> @@ -87,9 +87,9 @@ static void enable_clock_r5(void)
>   	writel(tmp, &crlapb_base->cpu_r5_ctrl);
>   }
>   
> -void initialize_tcm(bool mode)
> +void initialize_tcm(enum tcm_mode mode)
>   {
> -	if (!mode) {
> +	if (mode == TCM_LOCK) {
>   		set_r5_tcm_mode(TCM_LOCK);
>   		set_r5_halt_mode(HALT, TCM_LOCK);
>   		enable_clock_r5();
> @@ -102,7 +102,7 @@ void initialize_tcm(bool mode)
>   	}
>   }
>   
> -void tcm_init(u8 mode)
> +void tcm_init(enum tcm_mode mode)
>   {
>   	puts("WARNING: Initializing TCM overwrites TCM content\n");
>   	initialize_tcm(mode);
> diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
> index 960ffac2105..b7a4142fd54 100644
> --- a/arch/arm/mach-zynqmp/cpu.c
> +++ b/arch/arm/mach-zynqmp/cpu.c
> @@ -113,7 +113,7 @@ u64 get_page_table_size(void)
>   }
>   
>   #if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
> -void tcm_init(u8 mode)
> +void tcm_init(enum tcm_mode mode)
>   {
>   	int ret;
>   
> diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> index 9af3ab5d6b6..b6a41df1da4 100644
> --- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> @@ -41,18 +41,18 @@ enum {
>   	ZYNQMP_SILICON_V4,
>   };
>   
> -enum {
> -	TCM_LOCK,
> -	TCM_SPLIT,
> +enum tcm_mode {
> +	TCM_LOCK = 0,
> +	TCM_SPLIT = 1,
>   };
>   
>   unsigned int zynqmp_get_silicon_version(void);
>   
> -int check_tcm_mode(bool mode);
> -void initialize_tcm(bool mode);
> +int check_tcm_mode(enum tcm_mode mode);
> +void initialize_tcm(enum tcm_mode mode);
>   void mem_map_fill(void);
>   #if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
> -void tcm_init(u8 mode);
> +void tcm_init(enum tcm_mode mode);
>   #endif
>   
>   #endif /* _ASM_ARCH_SYS_PROTO_H */
> diff --git a/arch/arm/mach-zynqmp/mp.c b/arch/arm/mach-zynqmp/mp.c
> index 448bc532867..d2a7f305ccc 100644
> --- a/arch/arm/mach-zynqmp/mp.c
> +++ b/arch/arm/mach-zynqmp/mp.c
> @@ -17,9 +17,6 @@
>   #include <linux/errno.h>
>   #include <linux/string.h>
>   
> -#define LOCK		0
> -#define SPLIT		1
> -
>   #define HALT		0
>   #define RELEASE		1
>   
> @@ -65,11 +62,11 @@ int cpu_reset(u32 nr)
>   	return 0;
>   }
>   
> -static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
> +static void set_r5_halt_mode(u32 nr, u8 halt, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU0) {
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU0) {
>   		tmp = readl(&rpu_base->rpu0_cfg);
>   		if (halt == HALT)
>   			tmp &= ~ZYNQMP_RPU_CFG_CPU_HALT_MASK;
> @@ -78,7 +75,7 @@ static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
>   		writel(tmp, &rpu_base->rpu0_cfg);
>   	}
>   
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU1) {
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU1) {
>   		tmp = readl(&rpu_base->rpu1_cfg);
>   		if (halt == HALT)
>   			tmp &= ~ZYNQMP_RPU_CFG_CPU_HALT_MASK;
> @@ -88,12 +85,12 @@ static void set_r5_halt_mode(u32 nr, u8 halt, u8 mode)
>   	}
>   }
>   
> -static void set_r5_tcm_mode(u8 mode)
> +static void set_r5_tcm_mode(enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
>   	tmp = readl(&rpu_base->rpu_glbl_ctrl);
> -	if (mode == LOCK) {
> +	if (mode == TCM_LOCK) {
>   		tmp &= ~ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK;
>   		tmp |= ZYNQMP_RPU_GLBL_CTRL_TCM_COMB_MASK |
>   		       ZYNQMP_RPU_GLBL_CTRL_SLCLAMP_MASK;
> @@ -106,12 +103,12 @@ static void set_r5_tcm_mode(u8 mode)
>   	writel(tmp, &rpu_base->rpu_glbl_ctrl);
>   }
>   
> -static void set_r5_reset(u32 nr, u8 mode)
> +static void set_r5_reset(u32 nr, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
>   	tmp = readl(&crlapb_base->rst_lpd_top);
> -	if (mode == LOCK) {
> +	if (mode == TCM_LOCK) {
>   		tmp |= (ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
>   			ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK |
>   			ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK);
> @@ -130,16 +127,16 @@ static void set_r5_reset(u32 nr, u8 mode)
>   	writel(tmp, &crlapb_base->rst_lpd_top);
>   }
>   
> -static void release_r5_reset(u32 nr, u8 mode)
> +static void release_r5_reset(u32 nr, enum tcm_mode mode)
>   {
>   	u32 tmp;
>   
>   	tmp = readl(&crlapb_base->rst_lpd_top);
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU0)
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU0)
>   		tmp &= ~(ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
>   			 ZYNQMP_CRLAPB_RST_LPD_R50_RST_MASK);
>   
> -	if (mode == LOCK || nr == ZYNQMP_CORE_RPU1)
> +	if (mode == TCM_LOCK || nr == ZYNQMP_CORE_RPU1)
>   		tmp &= ~(ZYNQMP_CRLAPB_RST_LPD_AMBA_RST_MASK |
>   			 ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK);
>   
> @@ -165,9 +162,9 @@ static int check_r5_mode(void)
>   
>   	tmp = readl(&rpu_base->rpu_glbl_ctrl);
>   	if (tmp & ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK)
> -		return SPLIT;
> +		return TCM_SPLIT;
>   
> -	return LOCK;
> +	return TCM_LOCK;
>   }
>   
>   int cpu_disable(u32 nr)
> @@ -249,27 +246,27 @@ static void write_tcm_boot_trampoline(u32 nr, u32 boot_addr)
>   	}
>   }
>   
> -void initialize_tcm(bool mode)
> +void initialize_tcm(enum tcm_mode mode)
>   {
> -	if (!mode) {
> -		set_r5_tcm_mode(LOCK);
> -		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, LOCK);
> +	if (mode == TCM_LOCK) {
> +		set_r5_tcm_mode(TCM_LOCK);
> +		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, TCM_LOCK);
>   		enable_clock_r5();
> -		release_r5_reset(ZYNQMP_CORE_RPU0, LOCK);
> +		release_r5_reset(ZYNQMP_CORE_RPU0, TCM_LOCK);
>   	} else {
> -		set_r5_tcm_mode(SPLIT);
> -		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, SPLIT);
> -		set_r5_halt_mode(ZYNQMP_CORE_RPU1, HALT, SPLIT);
> +		set_r5_tcm_mode(TCM_SPLIT);
> +		set_r5_halt_mode(ZYNQMP_CORE_RPU0, HALT, TCM_SPLIT);
> +		set_r5_halt_mode(ZYNQMP_CORE_RPU1, HALT, TCM_SPLIT);
>   		enable_clock_r5();
> -		release_r5_reset(ZYNQMP_CORE_RPU0, SPLIT);
> -		release_r5_reset(ZYNQMP_CORE_RPU1, SPLIT);
> +		release_r5_reset(ZYNQMP_CORE_RPU0, TCM_SPLIT);
> +		release_r5_reset(ZYNQMP_CORE_RPU1, TCM_SPLIT);
>   	}
>   }
>   
> -int check_tcm_mode(bool mode)
> +int check_tcm_mode(enum tcm_mode mode)
>   {
>   	u32 tmp, cpu_state;
> -	bool mode_prev;
> +	enum tcm_mode mode_prev;
>   
>   	tmp = readl(&rpu_base->rpu_glbl_ctrl);
>   	mode_prev = FIELD_GET(ZYNQMP_RPU_GLBL_CTRL_SPLIT_LOCK_MASK, tmp);
> @@ -279,7 +276,7 @@ int check_tcm_mode(bool mode)
>   			      ZYNQMP_CRLAPB_RST_LPD_R51_RST_MASK, tmp);
>   	cpu_state = cpu_state ? false : true;
>   
> -	if ((mode_prev == SPLIT && mode == LOCK) && cpu_state)
> +	if ((mode_prev == TCM_SPLIT && mode == TCM_LOCK) && cpu_state)
>   		return -EACCES;
>   
>   	if (mode_prev == mode)
> @@ -288,11 +285,11 @@ int check_tcm_mode(bool mode)
>   	return 0;
>   }
>   
> -static void mark_r5_used(u32 nr, u8 mode)
> +static void mark_r5_used(u32 nr, enum tcm_mode mode)
>   {
>   	u32 mask = 0;
>   
> -	if (mode == LOCK) {
> +	if (mode == TCM_LOCK) {
>   		mask = ZYNQMP_RPU0_USE_MASK | ZYNQMP_RPU1_USE_MASK;
>   	} else {
>   		switch (nr) {
> @@ -358,30 +355,30 @@ int cpu_release(u32 nr, int argc, char *const argv[])
>   				return 1;
>   			}
>   			printf("R5 lockstep mode\n");
> -			set_r5_reset(nr, LOCK);
> -			set_r5_tcm_mode(LOCK);
> -			set_r5_halt_mode(nr, HALT, LOCK);
> +			set_r5_reset(nr, TCM_LOCK);
> +			set_r5_tcm_mode(TCM_LOCK);
> +			set_r5_halt_mode(nr, HALT, TCM_LOCK);
>   			set_r5_start(boot_addr);
>   			enable_clock_r5();
> -			release_r5_reset(nr, LOCK);
> +			release_r5_reset(nr, TCM_LOCK);
>   			dcache_disable();
>   			write_tcm_boot_trampoline(nr, boot_addr_uniq);
>   			dcache_enable();
> -			set_r5_halt_mode(nr, RELEASE, LOCK);
> -			mark_r5_used(nr, LOCK);
> +			set_r5_halt_mode(nr, RELEASE, TCM_LOCK);
> +			mark_r5_used(nr, TCM_LOCK);
>   		} else if (!strcmp(argv[1], "split") || !strcmp(argv[1], "1")) {
>   			printf("R5 split mode\n");
> -			set_r5_reset(nr, SPLIT);
> -			set_r5_tcm_mode(SPLIT);
> -			set_r5_halt_mode(nr, HALT, SPLIT);
> +			set_r5_reset(nr, TCM_SPLIT);
> +			set_r5_tcm_mode(TCM_SPLIT);
> +			set_r5_halt_mode(nr, HALT, TCM_SPLIT);
>   			set_r5_start(boot_addr);
>   			enable_clock_r5();
> -			release_r5_reset(nr, SPLIT);
> +			release_r5_reset(nr, TCM_SPLIT);
>   			dcache_disable();
>   			write_tcm_boot_trampoline(nr, boot_addr_uniq);
>   			dcache_enable();
> -			set_r5_halt_mode(nr, RELEASE, SPLIT);
> -			mark_r5_used(nr, SPLIT);
> +			set_r5_halt_mode(nr, RELEASE, TCM_SPLIT);
> +			mark_r5_used(nr, TCM_SPLIT);
>   		} else {
>   			printf("Unsupported mode\n");
>   			return 1;
> diff --git a/arch/arm/mach-zynqmp/zynqmp.c b/arch/arm/mach-zynqmp/zynqmp.c
> index 3aa218545bb..279006b4d13 100644
> --- a/arch/arm/mach-zynqmp/zynqmp.c
> +++ b/arch/arm/mach-zynqmp/zynqmp.c
> @@ -146,7 +146,7 @@ static int do_zynqmp_aes(struct cmd_tbl *cmdtp, int flag, int argc,
>   static int do_zynqmp_tcm_init(struct cmd_tbl *cmdtp, int flag, int argc,
>   			      char *const argv[])
>   {
> -	u8 mode;
> +	enum tcm_mode mode;
>   
>   	if (argc != cmdtp->maxargs)
>   		return CMD_RET_USAGE;
