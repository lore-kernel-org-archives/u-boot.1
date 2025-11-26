Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F520D1038C
	for <u-boot@archiver.kernel.org>; Wed, 26 Nov 2025 08:08:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A1D5D840BE;
	Wed, 26 Nov 2025 09:08:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="v71EwVOf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CE46B840C1; Wed, 26 Nov 2025 09:08:34 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 65D3D84047
 for <u-boot@lists.denx.de>; Wed, 26 Nov 2025 09:08:32 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IbdPpk1R34NU9jxJu4MJdNJvTJzy0PZqqCIPfUx9aCt73RPDlxbx3nnrvOuNeZzgd0W7/4dQDXBrryyRbgtqFNVFGpygNfYKMuwQ359rOgU5jF4EJKywQFuzmqsnLbdzI8x/syR3FBx6GhKyOJOM9hOMTK16GA635TjCT8jH+tmtW59IaDDIArrCLXuhuqLZhQUQSsWZN8Z77THyLmqQpiHhq5CjWfAnKAAjGH7pMSV0TgILA1qBWxM22iOskArhVKQDdOE/+tD8Po1suxwrJqtKY90gn/68LYaw/CphAWpZzbT7pwdu7CnFWIJZgwBYjUsSkzJW//t2CkJov/I57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxb/IHy2lClJQz1s9xuTfT1xJitB93CeLCErQoAVJx4=;
 b=kdOr8rxe58cOpzazj8CLbpXCgG+0zs2NBp2wI4xOQhOHJLdoBgMnF8BkqwNSsTW2+7yqeJb74KJTuvJTOT/d6XkQMmhar6Q74qjPIFrLIBRYLTHAd4Ivt6OlJ8ifGzq52Dn63InhTjO6+DH7FkBrPOVOqqdxs/0b9LKQwQWHKoMhguPX6WlrjacRA4+4BpCdp2BhTVjahMRfEYDcn1uj7nTq25cheNvWicDao+cUFuAnJUVMawVxOo7zeoEcZMYv31jS/DlckN2MNffPU5bpAc689NQ1XKtSKpr5JjAL0mX5StgOKki2dZ2uHIfvTA3vfEvntPqBKNIGvddaDvBYXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxb/IHy2lClJQz1s9xuTfT1xJitB93CeLCErQoAVJx4=;
 b=v71EwVOfx1xg6Llv9PD0VVW0xZ6/yu/g6ugNqV5ONqmXKrUKd/3hO73WibitV+3TXDbdRff6MEjEFDYykiSCSh3gdTrtoVBTMOdcAAK9UJC9xPHqlU79EuIoIh2Z5zQM4e4qxWh7aaHsJuSIcYVjoZc3g40zvrGpou/KrdZT+ME=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN6PR12MB8490.namprd12.prod.outlook.com (2603:10b6:208:470::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 08:08:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9366.009; Wed, 26 Nov 2025
 08:08:26 +0000
Message-ID: <98d68ebe-15dd-49aa-964f-e235f19cce12@amd.com>
Date: Wed, 26 Nov 2025 09:08:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: Update ESRT after copying GUID
To: Padmarao Begari <padmarao.begari@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20251104125725.1628068-1-padmarao.begari@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20251104125725.1628068-1-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0084.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN6PR12MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: ee00f5cd-5ef4-4661-a385-08de2cc2fa28
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S0xPakVSTjdPYU10eEhqUnFPSFl5a1NrUStVSUZ4UFNtVVVaNnJFSlAxYUNE?=
 =?utf-8?B?VFBva1RGci9FbmpOanVWMDIyWXVDektENk9vNVpkaG5KTkY1QkVoMzJQTVFw?=
 =?utf-8?B?QkhPa05WWXNxYUpRWDV5UHM3SzRXS1FnakEwUWtmU0tMczB6bWpmbGkzVGh5?=
 =?utf-8?B?MnFYdHduTTB5Ry8yUnlDNmJBVFI3QiswYndwNjl6OWNGL0J1WDRzQXB5Q3U5?=
 =?utf-8?B?RWZoSzZUZFlmMTdiUHNoNW9ieFVWMTRlZEtXNXRVc0ZSdGg3cTdUcUp3b0Zk?=
 =?utf-8?B?a2xZdnV1TWU5NWV2MXl2QXYxNnpLMHkyY3NaeUdkUVVodmtGS2FvU0FpSkdl?=
 =?utf-8?B?WW1mb0VrNXB0dnN1ZVROdDVFV3Z0cnI0WURhaVYrNVp6RTVmWk5xSXVZTHZp?=
 =?utf-8?B?aEJXcnkwR2pJRVdDWVd5Y0N1MThSemU5UGJXNG9HVU9sSEREYUlEQVdYRG1H?=
 =?utf-8?B?VXdEeUFqTnFOZTFDRmVTK3BDTkZRSFNqa1dNWmVyZ2NyYU5rcFViejByTzcy?=
 =?utf-8?B?TXFCcWIzMC9KOGR4aGRvREVqdEdYV1ZxUUhObU1SUWxFdG51MnVFeldWYWRR?=
 =?utf-8?B?QXlGYnEwYk0vaERUMlk1eTZHbDlSVTUwbE5wOTV1UUsvcnhLZmlXSGdWSzd2?=
 =?utf-8?B?eHFvYk5hTnFmYllSRHpZenBDSTh3a2lrSUE3cU5GdVl0WUttUzhtRzhWRDVP?=
 =?utf-8?B?cVJmNWd4VTd6WFNyS2J6VDVxSHRzTW8rNE9ManhrRG9xYW5CejFqK3pGbjVY?=
 =?utf-8?B?ZHl6dDJodGxCYit1bzFGWktMWUgyWThtOElFdWpkUFVmc1dFK20xU3RyTit0?=
 =?utf-8?B?dXJwQmlrSU91enJhWVpoNGU4Z2NVaHVqUjR0Vkt5em5yWGxmcUgyZVo0RDh0?=
 =?utf-8?B?ZE5VZE95T01lNW9oM2p5VVZxam9vUi94dStPWi80c3RFb0syWEhYYjhhYnR2?=
 =?utf-8?B?S3RXUGhsMmZablp3VytmaGZTczZnZitQK25NNW1sS2UxZWJVTE1PRWlzelJw?=
 =?utf-8?B?NnM4L1ZPNFQ0OVVjR0R6RkF4dlozWTVyLzZETnBrT00wR29MUmFVbWN2ZjJP?=
 =?utf-8?B?bHk0dUUrUWdJbW4rWXRMNFhkKzBBR1lFeXpwSnVISThGUW9iRFRsbXFxdTRF?=
 =?utf-8?B?bTFDbEhLdFpDVTV1VnB4eGp1MGUrbEo1YUcyM0tVR0lqTFZQYm44Q1VtbVA5?=
 =?utf-8?B?Yng4UVdYQTRaVmFHM2NQY2VWaUx2amg1aEVUY3Z6OUhXMkVrMWNUK25iUnhn?=
 =?utf-8?B?V2dHRnd5ZU9IdHNNWm8yaHlKN1V2RWxEL204ZTdBUkdFTUFSUXRkVytRUGFY?=
 =?utf-8?B?aTBLNWVabjhIdjF4UlUzTXJMWFNSaGRURXQxOEhIaFBDZlJJSERkRWZ4ZFJL?=
 =?utf-8?B?NDFKS0JRaVA0eUtTbVVOQUl2SGQ0SHdzZnNZcWdwSEExQVBxOWdKZnI2Q1oz?=
 =?utf-8?B?QS9NYzNtdXZINmlLYndVeGt4VHVDMi9BNEFQQUx4UUUvdFZNdThWUnRhY01F?=
 =?utf-8?B?a1grazFaV2o1MXh2Y0JQdnhtVjdiWDdvQStRU3kzbE1tU0crZitQdWtXV21n?=
 =?utf-8?B?UFZtSmQzMEpyemc3UUpQOWFCM1YrNGlJY0NxTW1pU3cyWjhDT0psUUpvNWVv?=
 =?utf-8?B?WU1IZ0djQUVjZ1ZUditjKzAzOGY3UmZXckdiSldUZXRya0loUkJVay83bk0v?=
 =?utf-8?B?QS8zRjdxSWJ5L3ZienF4OWEzR0FrQnFpUE1sTHErcnVsZHRyVHBJUEN4d0NF?=
 =?utf-8?B?alRvSm83MmFJK0JqNGhxMHpaYWVLV3BmYklYNzQwb0xEYU9LVSt2ZFJ3eDdS?=
 =?utf-8?B?SDdneUZ0SXpTc1JWUElDWTVaZi9OVkh5UWpnbDJsRFF2aHpSOXFubnJnaGxq?=
 =?utf-8?B?WUlrWW1JclR4VHJrU1FsSGszNS84Y2FsMEtFc0lGNHlzYVU3Mk9wS21TbU9V?=
 =?utf-8?Q?FLBWP3R7E1OrZpToN0voVcFBOXNVobW3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SG95aW9nM0J2QnB3MHFhbC9yeVNFYXFVVHI4NHdVRHovTEJRTFo5S2VnYURU?=
 =?utf-8?B?MHRtQXE1QWQvZzlDSGY5YmNPc1pTVm4zZ1NYdWtwWkl6MUpMWTQzVVl3Mkcw?=
 =?utf-8?B?QnVqUDBoZUJzdUtiVzNhWkFTTG1na1FRQWhxVXBZdnZDcXI4Q3BWSnptL2xi?=
 =?utf-8?B?RCsvN3ZvRW9iakUvYWFNdmIxQjlLMXpoZC9mbGR5d2VvaEkxNXVObTB3N2pq?=
 =?utf-8?B?bUFLayt5bXcxS0hiMXhlN2xobVphVUh5UlU4ak90bSs1bHYvQ1YwdzYvWi9p?=
 =?utf-8?B?QW02QWc5a0dOejVSTGdOYkN3cmwrOXMvWnlTRjZ1bzRyN2orQWVqK3JmWGRL?=
 =?utf-8?B?Tk1KZmRXVDhJL2xPa3V3dVVsWjloOFRlanJ5dnVKYmtNZEdlK2dqRWJBWWNG?=
 =?utf-8?B?Smxwbkl0MzNFVU5IVGZqQlZ3UE1UV0FYL0FDYjJkQU9Xang0MXNkRzF6b3dV?=
 =?utf-8?B?MVhIdlBMZGdrc3Iray9iUS90VDZwWldic0JjcytGNXhpME5JSU44Mmw0RWgw?=
 =?utf-8?B?VXlydU16czZ6dExTL0pUTXBOdmFmYk1Ta0FhM3RsTkJ0L0Y1WDJWRlpTN3ds?=
 =?utf-8?B?S29yaGdtbno4MlZYd2tsN1FHcXVFN3F0QlRnbVYxazBsV21mb2cwREpzWWpJ?=
 =?utf-8?B?RjN2ZTltM1dlYWlxR28rMTYwN3ZsVWhTTHJvVWx3TWZjK0lkYVRTMGRBL0RN?=
 =?utf-8?B?ZVREM0VJOEhHRm1nUTVTZ1JkRUFxNU9tT2g3UURzOERjSFNlc2l0R2pHeUp5?=
 =?utf-8?B?aFMvQk1wT2tZSGVTRDEzWmdzTjh6ZkYzSzhZZ1VFK3k0Nk5YVW5EWktEWVph?=
 =?utf-8?B?NVcrN3ZtLzV6cmJnejI4VmQyYVQvcWk3Q2p0c0tCTjJhbVcrN3J2Zk5ncnUy?=
 =?utf-8?B?TFZTTWFpWXBMVGxIZ2Fjb1MrcGpYNlpTaS92R2ZhZmdhcFU2YU1NQVBxN3RY?=
 =?utf-8?B?K0gzVEs2T0phdGtOTHV4OXlDMHI0SHpoeXhPMXpTemZIQTExUEtFdlNFbGJG?=
 =?utf-8?B?SCtJOTZRa0o0elRQWVZEcmx3aFVJZm1od0lUTkxwZVUyNTNDcUhSbDZKRnRl?=
 =?utf-8?B?YXNFZGFXVjl6RTdINXNsb2RKSloyMU1wWlUza2l1WGk1N2gvVWxvdWpzNVRT?=
 =?utf-8?B?RVlNckNOWnQySHpCbmxrSTg1SWVkekx2bjF4bC8zc3BJQ3p2Q3JzdXhWbUpj?=
 =?utf-8?B?dXVNeXg2VjJEZXlGM0lGYjBaZjlLL1ZnRGRpWDJ3MnBlMC9lN2diOG13WDh0?=
 =?utf-8?B?VWtDNXRoTGQxcGRPQ1Q1Vnp6Ti9yb25pS2tWOTAyR05kcWpPM0dzSDArNXRZ?=
 =?utf-8?B?QmNiMndjSW02QTBPaXFHOVpwVnVGeHRYNnZpVEovcDlDYjhwWDZRaU9YVk9D?=
 =?utf-8?B?czUzWll2SGFLSG1NRjFVeU52MlY1VWdpQ1lIN3kyQkkrUmlCc0FhcUZXN1Jw?=
 =?utf-8?B?R3I2a29RWmR0OU9HMTFrRDZEb1Bua3V2Z2tQdHB5bmorUVJ5M01JT1JPK09I?=
 =?utf-8?B?Qm1qYTlPZDM3ZlFCWEpSdjFXeHhublozakQ3NlFldklqejQxYVhvdHJCOW5Q?=
 =?utf-8?B?b2dxU3dSYTBhL1dPdXNuMmlSYjd1K3NxYjlsMzZXN0haaCtJYnY3b1V0Sll1?=
 =?utf-8?B?MG5uMnBLU3hqdld0dmZod3hmWWVlSGMyUlMzdHdhNm5aLzhqZUpGM0cvSVFM?=
 =?utf-8?B?VEVrc0o1L0RkMDFxOXZpSWJJTWlZNVlkTHp0eTV0SVE3ek5LQzZ3dDloTnk5?=
 =?utf-8?B?c2hUcmNIM2MzaGpaei9Jd0JpL2ROQWtqZmhTYUdnVDRIaCtNZEVWaXB5VFJi?=
 =?utf-8?B?OTUrMGtZYUJyWEFDS2l3OHdRb2NxZ05uUGdienBpNmZLOHFzQkxaNkV4ekM2?=
 =?utf-8?B?Mm9xV3FUZTYwUDRCYWlpR21SVHhxV2ZwNDZMdEdocVVCckY5VzVqUVRwMTRV?=
 =?utf-8?B?b0tBMDJGbTcveVhkT2FUb21BK2tJcXhLUGMzMEtRS01NNjdSKytHT1dyemVp?=
 =?utf-8?B?cGlKYmpKUXR6RkhxbEovNU5QUTg0YnJDc3pJYzB0bmhIWTZFSnVqNkZPVzU0?=
 =?utf-8?B?cW5FWE85TnROaWRpTXNEOTB2Y09Zb3RqZ1NINnJmMzJqekUyc0tCSWNtWGFZ?=
 =?utf-8?Q?UEgzMaPcIh5xEzRDjICYDCpmk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee00f5cd-5ef4-4661-a385-08de2cc2fa28
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 08:08:26.7240 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hszj9k0wkq1+N+6ZawbdtW65d/RSYYdUmakivUgVs8Dx9CzECvcnp25READ2Qi0L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8490
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



On 11/4/25 13:57, Padmarao Begari wrote:
> The EFI System Resource Table (ESRT) is updated after the firmware
> image GUID is copied to the fw_images structure. This ensures that
> the ESRT accurately reflects the current firmware resources.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
>   board/xilinx/common/board.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/board/xilinx/common/board.c b/board/xilinx/common/board.c
> index 26facb6daea..ab50a795e6b 100644
> --- a/board/xilinx/common/board.c
> +++ b/board/xilinx/common/board.c
> @@ -766,6 +766,17 @@ int fwu_platform_hook(struct udevice *dev, struct fwu_data *data)
>   	/* Copy image type GUID */
>   	memcpy(&fw_images[0].image_type_id, &img_entry->image_type_guid, 16);
>   
> +	if (IS_ENABLED(CONFIG_EFI_ESRT)) {
> +		efi_status_t ret;
> +
> +		/* Rebuild the ESRT to reflect any updated FW images. */
> +		ret = efi_esrt_populate();
> +		if (ret != EFI_SUCCESS) {
> +			log_warning("ESRT update failed\n");
> +			return ret;
> +		}
> +	}
> +
>   	return 0;
>   }
>   

Applied.
M
