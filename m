Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0892CE7AB6
	for <u-boot@archiver.kernel.org>; Fri,  6 Sep 2024 06:50:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2551288CF6;
	Fri,  6 Sep 2024 08:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d0182csV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6BED388CFB; Fri,  6 Sep 2024 08:50:54 +0200 (CEST)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on20608.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2414::608])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 60231885A5
 for <u-boot@lists.denx.de>; Fri,  6 Sep 2024 08:50:52 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6I3M7P/3LsKXzwp5OmRaPrIRetQzvFhrbB0uwnWMkf+8MmrtEC4IbFiFGSX7zQUeWOc5UDQ/BX+ztlhLZKsMpwiALmc4827iaabcDoIeEPA9DRMLQ5CJgSHEXG7bleO5TBxtwsqCIUetOumO61mfGopcTZWi3Hf4v/XGL7cVoxhp2A4VnnMHuAtmgjXjHqTx2vu/k6y70efKVERNzg0ntarJ3WR6mHFunF0Xj6HHmd30bBEpfq7QopJskxa8LcvY/BbjlqVGN4ZV5YoDGH8mPR/gJV/5yQj1qcuzLVFxP7ZBrYEUTog49HZg8DBe4yXFENXfIg8J1fCIPFcahPRdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xZg1G8RrLr4cnHajfzsGBSgcJEKzzcQhSe4OIufBrUc=;
 b=B8tA5gfTMpNrik8kOOpCKDZTYwOACDN0GzbLA7lUG9wTPsDI7DC81nRSMYc/hLi7bv7uSHCzD+9ThokmAavzIuuR8iuvzSC4d0kszN+QE+7IIOF2z2Me7OMtlvWHVRwJIglZC1VD3XfbmPfFUyCOgJV3Hb05geUCB+KssWNlzaVme2GaNLADOamlVAv594bvk8seM54+0HoC+FS5jSS3ZaiSQQZkyEaWHTIHrLa5gyZU/PS7pP2kPJvQVNWBrhX5Xqw4lqYmvWdcGMLi9Dc+u/efCS/qP5e5wbCO99JY71A2361Ai+h4WMmgWkuPDltjqR5IcxWWXQuUDtOiYktseQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xZg1G8RrLr4cnHajfzsGBSgcJEKzzcQhSe4OIufBrUc=;
 b=d0182csV/z4hbvmzw67OVte4TcjlySSg+2yjAAto/nvIsTyEauVnl12wrn8aZRMGKbvfBEKOoz0HK/ahFGys4rkyipToRR5kx0A3JNgj6UbuFOenJFQi0ghao/jnMp0HPJec9jXUb7uOz96SXDjp8ab9a2e3WG/1bpgORB/t2tc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS7PR12MB6006.namprd12.prod.outlook.com (2603:10b6:8:7d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Fri, 6 Sep
 2024 06:50:49 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 06:50:48 +0000
Message-ID: <64de4d21-4c67-43a5-95ca-822945cd3a4c@amd.com>
Date: Fri, 6 Sep 2024 08:50:40 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] xilinx: versal-net: fix no previous prototype for
 function warning.
To: Prasad Kummari <prasad.kummari@amd.com>, u-boot@lists.denx.de, git@amd.com
Cc: venkatesh.abbarapu@amd.com, padmarao.begari@amd.com, git@xilinx.com,
 jagan@amarulasolutions.com, n-francis@ti.com, d-gole@ti.com
References: <20240905115758.999936-1-prasad.kummari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240905115758.999936-1-prasad.kummari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0099.namprd04.prod.outlook.com
 (2603:10b6:610:75::14) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS7PR12MB6006:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c41e7e9-a352-427b-7614-08dcce403d39
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZTQvZ1BxTDh4Wm4wT2NUUnhlYm9aM1YxbUhzakhQdFZ3TTJ3WnZndTliQkUw?=
 =?utf-8?B?ZGtUOC9VcmhiazdJY0lxczR3K0FBRFJ0M0NFT1dVN2pLMFA1S214Vno0dGZW?=
 =?utf-8?B?QmdaVnJBVW9md2M5UkRwdVhxa3dPbEtkdW9Ld0pMS0VIQ085UFV0R0tBenFK?=
 =?utf-8?B?MjBlN0tRQTVEYWJXNkdjWlo1SzM5NWp2dlEzUElHYlc2U1EwTEdWRjJkQURR?=
 =?utf-8?B?WTZTZ1dNUDVQdk45WTFpMmFlUUxiWDAxd2Y3RzNiT3F5QWJDUzcveEVYYlZx?=
 =?utf-8?B?dHdTRVlxQktuSVYwMWErajhPN3RmWTZDM0RMTHRuSXdxSjNVUlo0MmF5YTZl?=
 =?utf-8?B?aVJUNHV4emo5SE1WOGo5NStrZmo5Q0V1cUd3UmpxUmVyS2dQc3Zla1A3YUxR?=
 =?utf-8?B?eHA1SUp0OUZCamgyTFRkZ0w2ckhINjRPU0dQM1hkZjVFV0dmN0FxaFo4WmNU?=
 =?utf-8?B?bXd3QkJDRnR1TUJ2M2tTLzlxTlJhQU44NFNsSEhoL3RiOGZiR0graXU4SlFL?=
 =?utf-8?B?VUdKemlxS1pzQnVGby9PUFFJUCs0NVBESTZnN0VsTjdwK3JNUG83UGs1eERS?=
 =?utf-8?B?dTVOQ3JVMCtJSjZpTVdlS0c0dnF0a0ZIbEU3ZzVOWVpWMFZrZzNQcUZyQ0x5?=
 =?utf-8?B?Y0FGN20rb0RWZnBIbXh4dW81dUxsQ3NhcjZYcjhJdStzeDdjSFF0S1A4Uzkv?=
 =?utf-8?B?NElEdEFxK3VPa3FUcFhJL0JQRmw2OXo2YjNMTlFoTFprcllCWW56RDVRNExq?=
 =?utf-8?B?eWNibmV1Zy84U1hpSTR5N0xabm1RbUE2Z3ZDNXFFYndTQzhQTmJkUlFLMmxY?=
 =?utf-8?B?TmRIbk16SFZ1d0pnNTZzNnI4dUNVeDY3R3hyY2QwSTk1VVJrQ1ZnMEttbTl6?=
 =?utf-8?B?a0hLZTZadVdORVVsenV5c3loRG5EaXl2VjBCblJ2OHRkZFNubytHUHNXQU1J?=
 =?utf-8?B?MmdBREdBTTByQmhEbDNIUHJmMmZYTi96ME9HdEk5NW1aUEpuOUVnV2wwUmh2?=
 =?utf-8?B?blVTL3c4ZE9semtkSXh0QTgrNGVPZGZ2ZFBPNUsrcEMybFZWOWJFZTVxWXg2?=
 =?utf-8?B?Y3BHSjdkeE1JaW85dUVKd2xRRDZlM3hhN1U1R0JaMGtyRTIvdHNsOFNCVVNR?=
 =?utf-8?B?ZURvVGd0K3ZqUmF1NkRqZlg1SW9VUnVnZmljRFlhRmlZWWhXL2tVeWVuTjJH?=
 =?utf-8?B?SG5kRjhDcmJzeWczYnByeTZoZEY3ck5HSURNeFpzdWpzTHMxY1MvU25TWlhE?=
 =?utf-8?B?SndXd1FKNDZNVVgwbkdTSjVmd3Z4cXZqMTEwMWc4Ulo4Z1hUVFRWSjVSU0Rn?=
 =?utf-8?B?RlhxMktWL2cxYUFyNlZQTkd4UjN4aThPYmZEVnBHY0RaR2pzMC9FK3FtK2RQ?=
 =?utf-8?B?Tko4UUlha2twSUpQZEpZQ2JVLzVSS0NzdS9BRW04aVRKZUZ3TFQwQkdYR0lW?=
 =?utf-8?B?UEZQbVpsSXByaHIvN0F1VVZXYXp2azF0b3ViakJTNnloTGhhLy80ZGpFaElU?=
 =?utf-8?B?YXZNMFllYWtzUXJjKy9TN0VaOGhLWVdaaURhcmlhQUxtM2dmNFBNbFRKRy9z?=
 =?utf-8?B?UjQwVTIvMFYwdEFwRjJvUHYvNm9reXNSRFI1N3V1K0Q1R3VHUGMyL0NUb0Yy?=
 =?utf-8?B?UDZJbG1BSGFGVWw2VnZyUXJ2cUR3TzhDNDBiTmxCem5keHBsRnYwQjNDaUp3?=
 =?utf-8?B?WWhhYW0zdERobU5EMm5zYkg1RXduNC9mUENpY1VnNGpadlBvenpxSTZ6dkor?=
 =?utf-8?B?OE85VEtNVmlzRGxlNCt2TnhxUHhzQllSUm50NXJOTTJlWllYcFpicE8va0Vw?=
 =?utf-8?B?NEdrcmhFNm83Und3aERIZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzNnQ05ZNGJTSDBJRGhhRVZVK2c4Z2I4emJ2UUJYaytRb3lndHZkbkFNZ3dt?=
 =?utf-8?B?bG04UjhCTWJJZHF1YlJzMURGMmN0c1grVnYyR0IxUzZwa3g3OTZQMUF3V0gv?=
 =?utf-8?B?b3U2WEpXUjVjMW5JbktGQTJLRlhiVHc2YmhxV3pNOXRJajBaMW1SWnQ5bU5o?=
 =?utf-8?B?WThDL0l5Nkt4NW1PNGFNWDJvUGJ6bzlVejA5Wm1nbEpPM2g3QytIYXhDVERV?=
 =?utf-8?B?ZEpCTlY5cFFYTWdUTUJEbzNiQU9yUzRQQkhHNU5Gbkw3WGYvUDIwakxOUWg2?=
 =?utf-8?B?WGd5M3dTNjF0MzNxRjBvemZyNVQwZnl6MXVtT3pOU253Nmh5dm02RXM3eU1u?=
 =?utf-8?B?WURnVTFabXhSeno1OUdFbUtlZndoYnpPeVZBeFVDY3B4eEUwemRJNWdacUhD?=
 =?utf-8?B?dkdma2xHY2hZdlVuTzR2MmVmTHZoZTNDbjdaRGlpNWNxOXBERG5qazNaZUdE?=
 =?utf-8?B?cmYwY01VbE9wd0dBdXNtUFp0bENTSmdhQTVYa2g3b2tCamYyU2tBbmZZMjMx?=
 =?utf-8?B?WHhSM3FXMkZmZURXT0tPMWZPcGlRV2c4WGtTeWtnSm12SFNmeU9uK0JPN1dZ?=
 =?utf-8?B?eXYwbjJvM0l3T2lROFdOYVhTS2pmZE9MQkVEMVIxTm5va1FTcFpFWldEMHhC?=
 =?utf-8?B?S3BhREVEL0RjUVByY2dnR1B5NTlWNGwxbUhUeldwY0ZHTmw5NWMrWE9FNFVw?=
 =?utf-8?B?N0lEZDRsczZ3bDF0NFRSU3NzY2cwYlhYTDJBVTc3SW1ZZTVVWUxtaDhrQjFK?=
 =?utf-8?B?ZWQyOS9HQy9vSWp0SkdpeDM5ZUpvekh5bUUrM1VOVzZZMWJWanNYdFZXK0dK?=
 =?utf-8?B?Q2FreWV4SW5xZUFtYU1nMjdlZkQwcVEyMUEvMWRBTkl3ZzJsalRlVXVYeEVP?=
 =?utf-8?B?RGtrQWF0MVU3dVdxM2hmZUFxbDNJWkYyTjdRbGtIOUI3UE1EemxNZW11TEty?=
 =?utf-8?B?NjN3SXBKaVVxT1AwbG5LSkwxSjJUNGNpTEJjNHEvTkllQ2FoRXFGb0FnbzJU?=
 =?utf-8?B?b2FuYUJVYkdUOWV6RjFnTGoxZkswTGllTEo2aFJlVzNDbXJRaGtZZTluakFu?=
 =?utf-8?B?SjVHelBVbjgrWlBReXhBWnEvK2swUk1hTDF1V0R4eEJNNVN5YWN2dkdjcUJS?=
 =?utf-8?B?N3FGcm1WbzZlSmtBaEN3dVI1K2JyWDdWQVBmVHJvU1B5bnk4L0lZbkN4ZVVh?=
 =?utf-8?B?L0hhZDliWGQ3R1dlbTRjZlkzRUVMd3pDcG53YzFPUUZMNmZTZUF4M0xRdjdZ?=
 =?utf-8?B?dTkrcEJSOEREeG96NFgraXZMbjRuT1hnc205WDdxNFRoVXc4WjhaM3NOaTh5?=
 =?utf-8?B?V2lFMHdidXRueGZLWTNib2ZPQW5PWXBHNDhlSC94U3RrVlBJaCttbW9qTkI5?=
 =?utf-8?B?UGlTYllhc3QvMitPNTdPbkdBcmNHYTF6WjdVN0dIZi9NSTFzTDVkNW1QL2hO?=
 =?utf-8?B?aFZ6UFZNSDlkVWYvM1luM05iYTkrY0h0VHg2dnlEMkZtSWVtTTBYWEI3cWgx?=
 =?utf-8?B?L0xiWk5oSldaeStNV1VOb2NDQ3VKbjdvSjJIdmRPZDloQkJUcnBSZG1SMTVL?=
 =?utf-8?B?UERtdDZzMmpiKzgzRUVMR2JQSGluNTlvamV2Y1FJYWhrTzJpRlc1NzVMcWF0?=
 =?utf-8?B?SzNqVFZQbzlCVEVCQnFvbHBVdzNmWmxyMkNyeW5DbFN5M1hhUmFxNVdycUIr?=
 =?utf-8?B?VFk5UTRLM2JHdzRtU3laMU05VExBMmU1MmczaUVSVUJVZmFVSTR1OG9BZG5C?=
 =?utf-8?B?WWMxUjh1RGF6TktjaGQyN0Nob0Z5YVVpcWkva05YYi9ya1pPYzcwOHFtN25a?=
 =?utf-8?B?cjE5Unl0YmRVNnljMU5IbVRvMllUM281Ri9WRmc1SE1QQk5aWGtUb2xNVy8v?=
 =?utf-8?B?TXQxaE1iSWplNWdzc29FNEE2U3FUZFJkSFpnTll5T3kwYzI1SzduN1hxcGl1?=
 =?utf-8?B?bGdMUlFRVFRqbEFGVGdLdG8rK1JNLzhsbE1yNVFMR2svamR0Z0dmME1YdHNB?=
 =?utf-8?B?eERFemNsdWJwK3hNZ0w5K04vcklmeElSNXZJK0lBK1VGTCtwVW5xWHZXZkVH?=
 =?utf-8?B?R0hKc3duWFZrUTFPZFJuOWN1QUpzK0N1QTBjWUVUaTcyTlhjQ1JXZHdoYktH?=
 =?utf-8?Q?3P3SenFktq+BkLNL/O1a31daR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c41e7e9-a352-427b-7614-08dcce403d39
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 06:50:48.1637 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ojpbg5T0s7yyiaaTAm8BGBkKSHPhMy8uyJT5CLXGzvdYp9In4gKc3vxCuKEBtoFZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6006
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



On 9/5/24 13:57, Prasad Kummari wrote:
> Included the SPI header to resolve the no previous prototypes
> for function. Removed unused mode variable.
> sparse warnings
> warning: no previous prototype for 'spi_get_env_dev'
> [-Wmissing-prototypes]
> warning: variable 'mode' set but not used
> [-Wunused-but-set-variable]
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> ---
>   board/xilinx/versal-net/board.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index 1d67e3f318..4d5913cff1 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -12,6 +12,7 @@
>   #include <env_internal.h>
>   #include <log.h>
>   #include <malloc.h>
> +#include <spi.h>
>   #include <time.h>
>   #include <asm/cache.h>
>   #include <asm/global_data.h>
> @@ -196,7 +197,6 @@ static u8 versal_net_get_bootmode(void)
>   int spi_get_env_dev(void)
>   {
>   	struct udevice *dev;
> -	const char *mode = NULL;
>   	int bootseq = -1;
>   
>   	switch (versal_net_get_bootmode()) {
> @@ -207,7 +207,6 @@ int spi_get_env_dev(void)
>   			debug("QSPI driver for QSPI device is not present\n");
>   			break;
>   		}
> -		mode = "xspi";
>   		bootseq = dev_seq(dev);
>   		break;
>   	case QSPI_MODE_32BIT:
> @@ -217,7 +216,6 @@ int spi_get_env_dev(void)
>   			debug("QSPI driver for QSPI device is not present\n");
>   			break;
>   		}
> -		mode = "xspi";
>   		bootseq = dev_seq(dev);
>   		break;
>   	case OSPI_MODE:
> @@ -227,7 +225,6 @@ int spi_get_env_dev(void)
>   			debug("OSPI driver for OSPI device is not present\n");
>   			break;
>   		}
> -		mode = "xspi";
>   		bootseq = dev_seq(dev);
>   		break;
>   	default:

Nice.

Applied.
M
