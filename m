Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D924D2E01B
	for <u-boot@archiver.kernel.org>; Wed, 23 Oct 2024 07:30:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DDBC588B0B;
	Wed, 23 Oct 2024 09:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hoep0/yh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 169C589271; Wed, 23 Oct 2024 09:29:58 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::626])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E9BE788B0A
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 09:29:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPCkscbA+VVMz1MP4V9iSXL6NeGhjZNzUnu6YXb78pBLzSESITf9w62163NJwF1UozuFzK17SBtbvWlhJ1XJsUWXCbB5TSrIinbGGTu2IPufUls0V3obEkb8rtbSFWs/GUTZoFyattWn2+HwkUaqRYRZr277DvZ2C81mmj7XcSryBdUmbNxz5fdZyotPrNDHojptdn2UUr5Pv74uEmPGpqD+vStFr/GbduD8crRTLvkQUvb5u0tOjwX4k2IQXc+CbCsVaYIugRylLzyC5SimRz52zDJdWcfuDWi/T4KGTDYRPNU0kw7PqfzOQOLUwgnxsBb/bdv07qqnLyFaqybaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=56zKQnFLx0mpOfzG7j1+sSW48QKgoWhSfo7OjlMkZIw=;
 b=VLcmZRhtbpJUbdTcrcNDFwv5El+ubPekYEZolkga43SqvehPdJRrEv44tKB+nyyKVXM+qXOXcbZU13EuIxxylu/lWCG1X413dtYW52ts0uUH3BCFm89IxGPU37Wc6mtCtpArDDabkbtwEX9PtwN+jda7OciywluZIDAcmhNH2ippdxPV1dlMiIg+Yo+85L72YHMwFLT3mHaVscJwubCIK3J70KhhQ/Z2PZoX5zXsZ2EBmKAiH96Nljn3m2fUFfhZFOgwxcJmgu2NF/sr2yXMQd2s92x7B83DOFQjmAmJe455g7aU/2xgnIP73OZ0K7oUpC8WiXbDjGpKWQvL7ZmQsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56zKQnFLx0mpOfzG7j1+sSW48QKgoWhSfo7OjlMkZIw=;
 b=hoep0/yhK4XCCquMoeIbdTOz+TzZtZOOqdw+QMl0EHwb286e0f3lwGpbOhzP20CO642StiRmQc5HPX1kn8O+JHpea+dAobmRVBMCV7yg3arOwHMu9M02LRmqrRd8JQ85zszivBmPsyOOeJ5MKdfx3Hn5937sM3OvM6O5dZb5mwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN2PR12MB4391.namprd12.prod.outlook.com (2603:10b6:208:269::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Wed, 23 Oct
 2024 07:29:51 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8069.027; Wed, 23 Oct 2024
 07:29:51 +0000
Message-ID: <63678daf-25e8-484b-86ca-abf526403319@amd.com>
Date: Wed, 23 Oct 2024 09:29:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: fix tcm initialization for mini u-boot
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, venkatesh.abbarapu@amd.com, Prasad.Kummari@amd.com
References: <20241011113435.1966604-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20241011113435.1966604-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0024.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::34) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN2PR12MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: d4deefc9-e657-49a1-d7ca-08dcf3347b9b
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YjhobStlQnNqNEJtV1lHMEtpVWlXcSsvTnA3VldVYU0wbkhUQzFsSXRNWjZ0?=
 =?utf-8?B?dlRLeVhuSFZOWnkxbWlxVXJ2UTI0aHRKeURxMVlDMDFVbnAvTzNPSkJpTFRK?=
 =?utf-8?B?R0oxU0RGQ05qaUNQOGpRTGVzMjhnbUdmOVdsUlF4YnNYcEFZbVAxdUlISlBK?=
 =?utf-8?B?eHFBU3ZNVlNnb21ONC9qMkJZdk9LUW1LWURQUEprWktmd0lSZUY1MUkxMkxi?=
 =?utf-8?B?NzQ5SUlxOWpEbUdrN3R5U1I2Q1pBa1VDYUhrVXdGRW9pcGc2MHRCNG5ZK09Z?=
 =?utf-8?B?OWZLb3ErL3FmdW1oUkVRSWR4MnBNY040R0UwVWVsbXpqWDdXN1pVQWV0VHVH?=
 =?utf-8?B?bzFNZnozYmFvK3IzSzZXWnRNeXhRTUZDZzUwdDNTb0FRQzZkeXBXbGgrdkVR?=
 =?utf-8?B?L1F3aWpzWXV0NWptdjNBZW1KUGQ1MVdBZVhpc2QxS3dQR1Jub253N2szMzZu?=
 =?utf-8?B?WUVZYnJqamJtTVAwZmdPMTlyY0NCN2NkZC9UcVZPVFJYMFhpc0RGWStwb3pN?=
 =?utf-8?B?TzIvNVhEd2Jpb2M1Q25rY08zUWd4UCtqcWpJZWdjbVl6UkZIWnpockhjMkNr?=
 =?utf-8?B?WXZXYmRiNlBMdURXWHFOcUpTTmxwODliRWpHNFdGVXFTN2xVNDR1eDltYnZx?=
 =?utf-8?B?cmhISmRDcE8xTlRwaGE0MTY1SmIzcmttRmVEUDVCeldNQUZYbmVKaU5FU1c2?=
 =?utf-8?B?SjlMSTUrM2ZPK2VJbVpVNnNkb21LVHJkaFhzTTdSWHVKOXNlSGtRdjQ1KzNp?=
 =?utf-8?B?TUV6UjhqSTRqSDB5UXB6cWw5bCtLb1k4MU45VUw1dVR2Z0x4RTFNbmZxempC?=
 =?utf-8?B?OGF4eXhqa241OURiOHlpSXNpUHdLRkt2NDZtYmk5L2RKVW84YnIzMXJPTCtB?=
 =?utf-8?B?QXpnKzNVUW9yRFE5YTJJOGxkYWptSmUvTW5jUHp0N1ZqbnhESyszSGNEOHJW?=
 =?utf-8?B?Y0FtbzJVa0Z1eTRmZUc2NGIrYjBqeHo4YXJIOGQ0QVpZZXFid0czS1pqUHRt?=
 =?utf-8?B?RFdxV1p6cU1ONEpiRkRUN2dJeUZiY2w4RmN1RVcwWlhhaWlmeFBXaEhaaFg4?=
 =?utf-8?B?NFE2RmE1T1IxbGRPZ1ZQRlZ4U295Y3BxOThyZzZ5V3l4OTdOOHVuREovZWNM?=
 =?utf-8?B?djNZOThxRC84NHRNYnVwUjh4YXY0UHFHUFpTSG9vK0NTSzVYVFpTWFBFNGsw?=
 =?utf-8?B?eXZEaG5CQ2tHMi9XNGlBUnVmWWs2N2haQWJ4bS8wYzEzM25OYjNrNjVjMXNr?=
 =?utf-8?B?NW5CVllEYi9CWUdPYy9pS0YrdVlDVWFqYmo5WHZIYURGVVhabDc2bUdHNEha?=
 =?utf-8?B?RE8yZWNZOGtFUFI2YXNlQTRhREJhdndTN05TWExycmt0VTNON2FScG5ZTm5i?=
 =?utf-8?B?R04wUjRFY2MwL3FXL0xTZFNMZy9iMGxuVlZUQVpYb1A3MTBzOUlaNFZSSDQx?=
 =?utf-8?B?SDFRdVc3eHNxUDBkLzFoTGZiUitsazIxRjZVTGN5V3lHMEhKSFBKVU1hckZx?=
 =?utf-8?B?bUozM2lVcVRkc3dhOHlER0w0Qm9hR3pGOHBmN21pQ0NkYWJWUS9lZlVkcEtx?=
 =?utf-8?B?N2hXZFhWNUZCVVpYai9SeDBDQ01zRjIvbDZxNm00S05qelNkaTQ3UFFZd01Y?=
 =?utf-8?B?Rk02TktzWjJOWUMyMEdaU3Nsa2FYa0p3UnIrbXNNVDVJc2lrQk5LODhVektz?=
 =?utf-8?B?REFDSy9seFNRcUJjbUFqY3FxQlJ6VkV0MWZSWGhqYUoyb21CUmhITHg5ODFl?=
 =?utf-8?Q?ykE3/uixqY/2ClWghI8rKQX0yeFqwkyCJ2YjPM3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGlTTjA0cWoxZ0w0NWFYU2c0MHRKR1lyRlo0TmhDL1pURGRGN0Y5MEl1VHZY?=
 =?utf-8?B?RUh5VHhENlpjb2RqYXpFTGdNRVZHdnp6YjVwNEpYSER0eDl3RGNXdDZyVmFY?=
 =?utf-8?B?anJUd1hkQWpaeXpBWXVGcllKSDlkdnRqa3ZwTkh6Um9zSmVGbnc3RUI2c3Ra?=
 =?utf-8?B?dGRNTFJCanBaVTVXMlR4OGFDcUMyNlFhb0NxWTRHaXBxM294cnU4SFdWZHRN?=
 =?utf-8?B?V1Ircng2VjJvb3FabWVJMXBWUGVUSE1yZzNmb3BHT0VjSEQzeFQ0NG83RHNa?=
 =?utf-8?B?dVdKUlVKSHgrNzk1ZTNzRm1VVUIySnhkVG9IRytNQ3NONEU5Z0RialI4SHZL?=
 =?utf-8?B?Ujgwb1dCNUthc2JPL3ZmY1hxL0daby9HK2J1SFljSXpEbkt0RjJzbkd0akZX?=
 =?utf-8?B?bWlkUnBhRjJEeTU0SjhhUE1MNXhLUE0rVjNvYWxrQWhxaVJuL05sejJjYS9V?=
 =?utf-8?B?TDdRc250TlVaS0lPS1g3VHZmU0E4WThjS0MwdkFPODM4QjNIYmdsTkZWRGFZ?=
 =?utf-8?B?NEV2YW9VWTZVWjQ5elJYWTNSbTV1NHd0MVdYdGNhY3R5WDh2MVhKbTJoRWJi?=
 =?utf-8?B?Wjg5S0xTSXVkV21ZYnk1RFVldjVKRVVYN1BiaERBVU8wVDlvZWJtL20wb1Ja?=
 =?utf-8?B?d2h0MUNkQkdURXJSTVo0T3FGUURLRXdoejZIYlE1RWQrT2ZqQnpQTm9QSnNX?=
 =?utf-8?B?WHpIOGFBb1ZJQzIxclo0U3Zib2pSOWhVWUgvS1hJY2dMNnpheWZNWVRyd3Mw?=
 =?utf-8?B?ZmZrN3prSEVJYVNZVUxZVGV6UUp2ekpEdEgzQmYxM1FCMkloclVmQVc2dFVi?=
 =?utf-8?B?STRReDJTWU1VTDdQekdtaVAzSlZLQmNoUG1VK1M2KzBZdU53ZlAybjU0SzIy?=
 =?utf-8?B?Ky9qbk5taCs2L1h2V3MrTHU5NUhJYi9URDBxUGd5OFlxazBsckQvUWFaOEVU?=
 =?utf-8?B?Q09mSkZmU2VEbEFYYVhMY0FKT0dQZ2FiL3E2N2Z6bmlqWEVpdENjSElaa3Jv?=
 =?utf-8?B?MnNXakI0NERzeFFnZk5CeHJBc2lnMnNHS2kvVk5IOVdML3ZlbmN0a2hQRWNL?=
 =?utf-8?B?Qjg0N2h0Sm9Ga05iNGRrYlRRbEU0SEVqSkdKUFRHNkdsTk1kRk9USE1hWklk?=
 =?utf-8?B?OEtvZjlOSmczT212bXRrSnhSU3IvTmVnVm9LVGx1czJMSk1NWG91TUFVV0c5?=
 =?utf-8?B?QW9wbEZWUWozZjM4NFJOUkxJUnE4WlMxN095QmRrSGRjbHhPMzRwVzlDV2l3?=
 =?utf-8?B?eFRvd0NoeUJCUVY2Z1N2WlJQV2NyM0puaWFLVGhJUlgrSEtEWlFVMmRPa1My?=
 =?utf-8?B?WFdUeFIydDY1RDlmdGFWQUkvRWFxYzloRFpFb0JPUGdTUVFWWFdkMW53NURU?=
 =?utf-8?B?WC85eHlma0pJZjU4Q3BJV2lCNExXWHVqbGZWZWVJRXBHb1ZLMDJnd3JlSFB6?=
 =?utf-8?B?TjNQeVZKc2ozM2IzbCtDaEpENjMvNVd0MlRoU1E0R2I3TDE1alFIMjRZekFh?=
 =?utf-8?B?aVovT3pQMklmQUhQV2x4a2tvbnRMazdPWWk4WERnbnlGejR4a01Lb2x2V3BM?=
 =?utf-8?B?dkxxTnNycEROb1gvQWxyTk9hSXZRN0dVRlJlZ0dNVEEreUVSZDhyR3JUK1Nu?=
 =?utf-8?B?cUxIdjJhUlJRSDB0bDRsQjVWSUM4Unlpc3lzNEFSWFcyMUdlRmtRVDlBZDZ0?=
 =?utf-8?B?b1crTlowQWN4UkRkZVpIdGw4RWcyRnJLSkIwQWVENHlocDJDWjUwQTBMK0tF?=
 =?utf-8?B?bnhsaWpLMFlWUFByZUFZRWd3SjdmU1NYTTlFdXBEV3NWVktmMHQ5elp5djU5?=
 =?utf-8?B?Z3RrWTZWRWwyTDNUaEVNNDhhTEl1bThLM0ZGRWF5QUh0a0lQVDAxMHdoSUpW?=
 =?utf-8?B?c05LMHBEWlRyckUyVFlqY1hiVDMyaXp1MnhCOGNLSGE5NFBya2F1aFI0Sk10?=
 =?utf-8?B?MkFxdjhZWU0vY3JFTmN3c2o0aXErS3ZyQXVtK0Z6ckpEZ1R3YnpjUEpLUTc5?=
 =?utf-8?B?U3JGMzVRdXhURW9xYXI0eE03TVNjcWpoemZtM2MzVk1MekJJOVZOTGRJZFNC?=
 =?utf-8?B?V20wQ2FxY2xHeWZWRzdRaVh6YVF6eUFNZzdGOVpEUFpNamtrdHN0YWtFcGNq?=
 =?utf-8?Q?1wttlD6aR430XLa4WachKJG+t?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4deefc9-e657-49a1-d7ca-08dcf3347b9b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 07:29:51.8556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh0uwHOpyj7kJjexKBVjDH+bbJuVSMZXqQh8O84ygINKl6Gev12iZMiHPUpnXcLr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4391
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



On 10/11/24 13:34, Padmarao Begari wrote:
> Fix the issue introduced by commit fed064477c2c
> ("arm64: zynqmp: Print an error for split to lock mode switch").
> The mini u-boot is hanging, because of the tcm is not initialized.
> The mini u-boot is using the tcm to reserve the mmu table and
> currently it is not initialized, so allowing u-boot to initialize
> the tcm.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   arch/arm/mach-zynqmp/cpu.c                    | 7 +++++--
>   arch/arm/mach-zynqmp/include/mach/sys_proto.h | 2 +-
>   2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/mach-zynqmp/cpu.c b/arch/arm/mach-zynqmp/cpu.c
> index b24c1631479..6c43063bf23 100644
> --- a/arch/arm/mach-zynqmp/cpu.c
> +++ b/arch/arm/mach-zynqmp/cpu.c
> @@ -112,7 +112,7 @@ u64 get_page_table_size(void)
>   	return 0x14000;
>   }
>   
> -#if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
> +#if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
>   void tcm_init(u8 mode)
>   {
>   	int ret;
> @@ -134,7 +134,10 @@ void tcm_init(u8 mode)
>   #ifdef CONFIG_SYS_MEM_RSVD_FOR_MMU
>   int arm_reserve_mmu(void)
>   {
> -	tcm_init(TCM_LOCK);
> +	puts("WARNING: Initializing TCM overwrites TCM content\n");
> +	initialize_tcm(TCM_LOCK);
> +	memset((void *)ZYNQMP_TCM_BASE_ADDR, 0, ZYNQMP_TCM_SIZE);
> +
>   	gd->arch.tlb_size = PGTABLE_SIZE;
>   	gd->arch.tlb_addr = ZYNQMP_TCM_BASE_ADDR;
>   
> diff --git a/arch/arm/mach-zynqmp/include/mach/sys_proto.h b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> index b3396db28f0..9af3ab5d6b6 100644
> --- a/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> +++ b/arch/arm/mach-zynqmp/include/mach/sys_proto.h
> @@ -51,7 +51,7 @@ unsigned int zynqmp_get_silicon_version(void);
>   int check_tcm_mode(bool mode);
>   void initialize_tcm(bool mode);
>   void mem_map_fill(void);
> -#if defined(CONFIG_SYS_MEM_RSVD_FOR_MMU) || defined(CONFIG_DEFINE_TCM_OCM_MMAP)
> +#if defined(CONFIG_DEFINE_TCM_OCM_MMAP)
>   void tcm_init(u8 mode);
>   #endif
>   

Applied.
M
