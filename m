Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9539AE77199
	for <u-boot@archiver.kernel.org>; Mon,  6 Jan 2025 08:30:26 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F26C7801DE;
	Mon,  6 Jan 2025 09:30:24 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="QyyXeEt3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D13F5801E8; Mon,  6 Jan 2025 09:30:23 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E5C680137
 for <u-boot@lists.denx.de>; Mon,  6 Jan 2025 09:30:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MMDXZVBB6XAcx23AvCWIugPTKp43aZ57SkUYjESJwqKF9uktPnoD6aBHwieKNNSpszlaeQv/G6ArOt44un80xMiZFaISquPfCyp3TtuUg7IPk2x7cShg9X8astqOKyAfTx+C6GV8XpQa90RxbPS2Z0rbnRhWN+gRCIGRPnNtehopv6gZBhx6L7AO8a0SufJCBwzbiVZr1CD3eNpr1rHbI3893pLJEep7ghMd0CF83ox6hVCA5gD+zEeL0JFsTMy4nj2xquuoDQCPiBp4NL3J4lqGACeddvSyXZkyWVS7qoCcfApB3E89IqDqmqcv1H5B1cJUCZmYITZTzAIf2JCcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0zweDtdAAAtHni60YBD3nzGiQJJosifq/BMgRHBzYj0=;
 b=ho2TmRn0VF6wRPJXNz5c3XFDR1PPuXsAeVf+RQ/kid4nMwLj6S13UZzRXKLbUaqQzDr1OPAZj979ZXwOuV32HFFyegtvHmh2/hfFwZB3Cr+7oiW+S0H4stT2Wwtyna4JdQOTBZociVV1umMphFkFPrBNnK37rf6RHDj/qQsrA6Fp0TU9qYLXzb6CznCDlE52QysBz8jYeOQgCAsSzuF3nJk4rNILjGpiX8oavBaSNu3bVEYYaYEkvKbT/ncmsJx+UMKu7zGBlzxrJPEYD5UAWmLtNFsaplqNfhlIJ3Wm9z1wONloNQKpfNAuXmR7zF5FDWt68sCFqsKHchW5iJMB/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0zweDtdAAAtHni60YBD3nzGiQJJosifq/BMgRHBzYj0=;
 b=QyyXeEt3rPPhOTFPJ40UbKV+Stq2nQZtyfEhvkcn+347kV1OR/ZVBcX4QhKDRpuiGDh2IT+G8qarwSWBbJuPT0xTbc/scjDeqx+11k92+d9A/EC8ZQWWeLaqa/wjmhlLSw8IPUWBqiyizkfRi4I4JMrEz6kPr3N3ypcRz8mXJ7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Mon, 6 Jan
 2025 08:30:11 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8314.015; Mon, 6 Jan 2025
 08:30:11 +0000
Message-ID: <bd2457dc-875d-47f9-b927-bc5c20b747d3@amd.com>
Date: Mon, 6 Jan 2025 09:30:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] config: xilinx: Enable the SPI_STACKED_PARALLEL config
 option
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com
References: <20250103044812.18828-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250103044812.18828-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR08CA0274.eurprd08.prod.outlook.com
 (2603:10a6:803:dc::47) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: 26274ca1-6215-4849-4d00-08dd2e2c55de
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?V0k1cXZtQ1NXcXliYkVlengwRWtqVitKa3hUTldjMS9wNStiYUh1bEt4YXdO?=
 =?utf-8?B?cnBuRXl2dnpzNERIZjZhSlNWMDUxUHlXaER1S29yMG1PY0d6bUdrVnJtdWdx?=
 =?utf-8?B?aXR5dmZNc09FVGtoUWhQQ1U0Vlp4c0hNakNrVFBpanNRN1NVUUJwWVd2MEx4?=
 =?utf-8?B?YVdhRlcxVDVhYlRPSWhVaU5za0JWTnVJWk43MmdlaG5NTUdKRkFNdkw0ZXYv?=
 =?utf-8?B?MDJXUXhtRStvbHBFVXFnc0RtSExFWVMxbXBzZGhFc0FXYWthZEsxQSs4ajA4?=
 =?utf-8?B?cERGWmtvQ3FNOHU1YjJHenFBVVVlMXZQZ1htclVGeUtYTzI1TXNaZVdwTTM5?=
 =?utf-8?B?SlgxcWUvZ0tFVWk1YitZYTBJRGIwMk9lYTd0ZEg3a2x4Sk9QUTRzRS8wbk9M?=
 =?utf-8?B?UEV5MG85UHgyVWxuaTFLcUFlYllMN0ZFZnN6ZkFlNjhoQ3M0NmNxeDZDdElS?=
 =?utf-8?B?MGdQT2pWalZ5RTZvWDBYbE1RUDNPWU1acVl2MitUVmFSLzIrNllNT3pTa2k2?=
 =?utf-8?B?UE43cjJjSnkwNGgwdlV5d3dDdEVrT3NSbUgyOXFHakJIYWxrMkVqN3R6VS9M?=
 =?utf-8?B?dGhtUXZBaTNpMFFxUTBicjdMVjFTS1M0ZnQ3ZHZ1TDUxUlQxUDRtdE02WExZ?=
 =?utf-8?B?MGZlb2dJYSszMTRuenVqVXNkTEMva09JT1JuNWRwcnZMbHQ0eU8xc2hWWFRo?=
 =?utf-8?B?UC9CNEZQVWIrai8yTForODFrSWRCam95UmNjUlNvZWNJZWwwTUY5NlpGYmgw?=
 =?utf-8?B?aG9FcmJQT0FFNzU1Q2I4aWZuQ2F1dVlzYlM1OGhDMzhHYVFQRkJGNFR1MkF3?=
 =?utf-8?B?eDNsU1VpOHhmMmcyMGdFKzc3SkRQR0N1OW5Pa01vcU5LS1FMZmJTQW5CZStM?=
 =?utf-8?B?enRsaDNUM2RTYnJFRTdaQk0zdWx2cmt1WVR5YmJWUGhiTmdwL3VzWFZMT1pp?=
 =?utf-8?B?L09rMDFQUlEyK0lSRG8vMjVlY0d4S3RGN1VrSUhSY2JzSVVLMi9UM1ZCUlNw?=
 =?utf-8?B?aVZaekpBNGJLMWZRRk5neDgxWnFTZ1ZoWTFtU0xlRVRHWlNiYU1BSUNLMzdk?=
 =?utf-8?B?QlF2bzBncGR6SVZIeGdHakZReGw4WWNWQ1pvVTM1UW4ybVowS01OWEZxa1JV?=
 =?utf-8?B?MmFjYTRCclRrRkx1aFRXV1Z1alNQbXBEblgzd2l1YTJ3anZwOFkrNStualVr?=
 =?utf-8?B?UHUrNW1rRG9rcHVNQzQrMkovQVpaSTM4VlFjckhMa1pPSFVOWENHSkxDRFFr?=
 =?utf-8?B?bjU0ZTVJS1cxVGdGRWo5SldYWDRQb0I4ZGV2c3J1WVBJWVFwNGt5bkVyT0lM?=
 =?utf-8?B?WEFMSm0yb1lCc0FtNVB4RHRvRUVuTWw0NEpoOWRzT2dmaXhodHZNQlFXTCtz?=
 =?utf-8?B?bzIvME9JbWFRVmZJajR4ZnhSdW5ScE52dTRDcHhwTitldUZYR3Y3cmEvWXRU?=
 =?utf-8?B?UGxjK0RpL29LMjJaT0VMWXcrdjFJMU81QUNNSVJkYmtIcVhYZVArUnF3ZEd2?=
 =?utf-8?B?dVVteU5tNWFJWEdFVDlXYTNmSFNqRE5pZzZZampET1phSzlSczNZV0lxUzUz?=
 =?utf-8?B?NUw3RGFySWRQdUxrbWlRaTFFOXp3YXFvQkxJSVczd3BjTXlqbmh4bWN2UGNB?=
 =?utf-8?B?MUlDcEd2MVg0ak1NQmdRRWpoMlRzSmRyN2NwT0lxNHJvYm1yNFhjOUU2OUJG?=
 =?utf-8?B?dVpST28rN0ZlU0JjRG5RbWRWTGVPNU80WnNyUGF5czFmLzFrWm9zdVNLbENU?=
 =?utf-8?B?SmlXSWJNN2kzK3d0VFY2bERDRnJYOHRZN216V0RBanp6T3JydnNOSEFNVThH?=
 =?utf-8?B?eTJSNTg5ZjdDVGZIZkpkV3FuNXlVNi9rUy9adkwvQ2hRNHBsRDdPdHNXeGw3?=
 =?utf-8?Q?Jp6EtH1+CkoMe?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0x3VUdxdjNoSVlEa1I5QVJpdnJLM0s1bjlTa2ZsODE3UzZqYXpZT3BoM1R0?=
 =?utf-8?B?aTBpQ2RndE1TN1VTTnB0UitRYkFaR29ua0d5b1YzUnhqS0NnUkxtUG9XYnFn?=
 =?utf-8?B?dDgwWm1xNWNucmtFYmJUN0xqbE1VQ2VXWFhkTTQ1QVZBZ2JmRXQ2QXhUd3JR?=
 =?utf-8?B?QzFxYXpKNFdYWk5jVUh2SXJxcjBtOUhJWEFvOFErTFB0dEM0K1FrRXpPemI5?=
 =?utf-8?B?ZkpqeVcxbVBKVnhjVFBvanN6T0xzVWdJa043R3FvWURQSTdjaXhuM3FVQzdE?=
 =?utf-8?B?K0VqTFdQSkNka0JraTVzcmdCOGxrS1BYbkEyOHhQaWFnWFRCWXJqT2owKzNz?=
 =?utf-8?B?MVV6ejlRNlJtaGZBcXVsMlM3Z20vbXZpWXhNckJjSGNnL0V6Y1VqTW8ySGti?=
 =?utf-8?B?aDRabnNGMHY3Zmp6bjA3ckhzU1BuMSs2QUlmWmpQYXRKL0Fhc1p4R1RYbHlV?=
 =?utf-8?B?cUs2ekRtRHRvSDEyUlhGS0laR3lZOUJMSC9QK2JlakdOR0JzUVp3Z3lrQ3Zx?=
 =?utf-8?B?RTBFTnplT0lzdjNiNUkyV0JZUHMrNnZOTmVXb3dqUzlGT0VrMGVtcjNETWd6?=
 =?utf-8?B?b0J6VUh0OUtQV3FqWk5YVGxXWmE1Y3B3Nml4d0Z0THFqY1NIY2ltSStHTFBO?=
 =?utf-8?B?enFLVHhpYmxEU3h6emRyeEMxM0xOd0pzamhoU05jdW1Rek14eXZjMzMwcGpi?=
 =?utf-8?B?UjBpQWp3N0FyYUJBM3V3RzlGdFRrUitWYzdnazFCdTMzOWRxU1ZZd1gyais5?=
 =?utf-8?B?dm5aZjZ2d01TM3FYRlhPdnpTQy9lN2RrUjBTVXJ1cFhxcVdoQzVucnkxaE90?=
 =?utf-8?B?YnoxQWwrcXNoT0psdmhuS3dCU21HY1JBUVY1ZEg4VW9MNWVUeGtlNzRWejdF?=
 =?utf-8?B?U2VLdlRRMUZPZUxuUDlJajBVTENCam1EbWxyd29DWHZaK3UwL3hmQnlFSm8x?=
 =?utf-8?B?b09ndm1aZjMzR1RjM0tEdVpubXhCS3Q2empCSnl0R2QxeS9UajI1SkhVVU51?=
 =?utf-8?B?KzhhRjhwelM2WWxEbk01RmZvc3JOSUtnS2wvNEp3bnBJb1oxK0tNN1p6S2Zr?=
 =?utf-8?B?TW1GanNQMlFLN0FnUDJqTlcraWpuYnFvcU9KWC9aOUY4TjJ0TDlTblE3aGxD?=
 =?utf-8?B?dUhvaWRUUEg4MWtXeER6UVRWa1h0VkFOeXJsd1A3dVc0WnFId0pjQjVNVCt4?=
 =?utf-8?B?OTRPL2JkNzJGNVU3cU5CZmJPVlVoSjI2MWNBcXdsS1VoNUNtYk1TTHFpUHVE?=
 =?utf-8?B?MFpiTXlNdVQrSERjOTRoRDhiTXorSVJPT3RYaTc3WVFCQ2N0UUo5U2lYRWQ3?=
 =?utf-8?B?NlhkcTJnZWJCdVVDODlBeUJMUmxQNlNucXdMOGFucW9sZFE5QmZKcWdhbEkz?=
 =?utf-8?B?eGxMdTJYTHFxclVjdUNOclNJYldjeWZyZW5FdmZsY0VyZldQa0tKcnN4WDFE?=
 =?utf-8?B?aXNQTEhWQ1B5cTRRT2dRdi9UNmtBMnEvOVlOeExoeUVlME1DaXJadTFhc1Fz?=
 =?utf-8?B?S0F2YURvc095OXZwbllGak9hanJTbzA0ZHIzNWVaRndyd0FRT3QxVnVwMTBy?=
 =?utf-8?B?QVk1MEZDZGh6R25taFZwWEwwbXBzeEtWWUZkZ1NGa3pyMW1YUDlFdDVuNG1a?=
 =?utf-8?B?em5kS3R4U3pjaGVCTEtOSXo5RHN3YkY0UnpRSVIzMEhZZ2xib3ZFZmdOQ1Zn?=
 =?utf-8?B?VjJxelE4YjFqZmxud3laTFpsTSs0MVJTOVBwMFB4RGxRbHlQSEc1QjJYaTVl?=
 =?utf-8?B?Z1k1cFZMSkVObmoyUUw1QnNULzBBZGJ4UVNHTjV6T2FMSy9DNGl1Tk1sSEtj?=
 =?utf-8?B?b0xOT3RsdW5CMlhNUWg3b2ltMzhDQnVxRkNrYUp4ZlRvS2drQ3Z5Sks1Yzd3?=
 =?utf-8?B?Y3RkbmVoZW9vUW05MjVVajZwcS9KQk8yaUVnMWlQRjV1dllUMVk4dFFET1ZN?=
 =?utf-8?B?eG5RTExaQTlJK3NTaUZ1T0phMjV0U2tYUU9XM1JSRnB3Ritka1ZWaEF2YitT?=
 =?utf-8?B?Z1lwTHJIRVZBTUFJY1h1UVoveWUvamYyVGNjSys1eU4xTmJxUmcrSGJ6aFY0?=
 =?utf-8?B?cVlWdHpXOWJvb0l3UlNmWWpicjR1NW1QenFFSG56eUE2Rm9xUUxXL0MvWlRX?=
 =?utf-8?Q?e7tCYrNVkJI4D4CieRpFdt26h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26274ca1-6215-4849-4d00-08dd2e2c55de
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jan 2025 08:30:11.3132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dfXqPEUAmmOgVk7EQ1SLYcLaHbAsBHEuBIePUWTO+tKwSi1hZMOhORijEPDiMEmS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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



On 1/3/25 05:48, Venkatesh Yadav Abbarapu wrote:
> Enable the SPI_STACKED_PARALLEL config option for
> all AMD/xilinx platforms, as this is required for parallel and
> stacked memories.
> 
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
> Changes in v2:
> - Updated the SPI_STACKED_PARALLEL config for zynq.
> ---
>   configs/amd_versal2_mini_qspi_defconfig       | 1 +
>   configs/xilinx_versal_mini_qspi_defconfig     | 1 +
>   configs/xilinx_versal_net_mini_qspi_defconfig | 1 +
>   configs/xilinx_zynqmp_kria_defconfig          | 1 +
>   configs/xilinx_zynqmp_mini_qspi_defconfig     | 1 +
>   configs/zynq_cse_qspi_defconfig               | 1 +
>   6 files changed, 6 insertions(+)
> 
> diff --git a/configs/amd_versal2_mini_qspi_defconfig b/configs/amd_versal2_mini_qspi_defconfig
> index eb63f060c1b..2750fa2cc27 100644
> --- a/configs/amd_versal2_mini_qspi_defconfig
> +++ b/configs/amd_versal2_mini_qspi_defconfig
> @@ -74,5 +74,6 @@ CONFIG_PL01X_SERIAL=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   # CONFIG_GZIP is not set
>   # CONFIG_LMB is not set
> diff --git a/configs/xilinx_versal_mini_qspi_defconfig b/configs/xilinx_versal_mini_qspi_defconfig
> index 4d23b353409..529815afe16 100644
> --- a/configs/xilinx_versal_mini_qspi_defconfig
> +++ b/configs/xilinx_versal_mini_qspi_defconfig
> @@ -78,4 +78,5 @@ CONFIG_ARM_DCC=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   # CONFIG_LMB is not set
> diff --git a/configs/xilinx_versal_net_mini_qspi_defconfig b/configs/xilinx_versal_net_mini_qspi_defconfig
> index 8453be5a590..818c62c6959 100644
> --- a/configs/xilinx_versal_net_mini_qspi_defconfig
> +++ b/configs/xilinx_versal_net_mini_qspi_defconfig
> @@ -76,4 +76,5 @@ CONFIG_ARM_DCC=y
>   CONFIG_SPI=y
>   CONFIG_DM_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   # CONFIG_LMB is not set
> diff --git a/configs/xilinx_zynqmp_kria_defconfig b/configs/xilinx_zynqmp_kria_defconfig
> index e5ffc7076fb..5d91338c12e 100644
> --- a/configs/xilinx_zynqmp_kria_defconfig
> +++ b/configs/xilinx_zynqmp_kria_defconfig
> @@ -196,6 +196,7 @@ CONFIG_SOC_XILINX_ZYNQMP=y
>   CONFIG_SPI=y
>   CONFIG_ZYNQ_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_SYSRESET=y
>   CONFIG_SYSRESET_CMD_POWEROFF=y
>   CONFIG_SYSRESET_PSCI=y
> diff --git a/configs/xilinx_zynqmp_mini_qspi_defconfig b/configs/xilinx_zynqmp_mini_qspi_defconfig
> index a60403d82c2..1204c1583d4 100644
> --- a/configs/xilinx_zynqmp_mini_qspi_defconfig
> +++ b/configs/xilinx_zynqmp_mini_qspi_defconfig
> @@ -92,6 +92,7 @@ CONFIG_SPI_FLASH_WINBOND=y
>   CONFIG_ARM_DCC=y
>   CONFIG_SPI=y
>   CONFIG_ZYNQMP_GQSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_PANIC_HANG=y
>   # CONFIG_GZIP is not set
>   # CONFIG_LMB is not set
> diff --git a/configs/zynq_cse_qspi_defconfig b/configs/zynq_cse_qspi_defconfig
> index cd84df1e290..6a5e1dd5d95 100644
> --- a/configs/zynq_cse_qspi_defconfig
> +++ b/configs/zynq_cse_qspi_defconfig
> @@ -92,6 +92,7 @@ CONFIG_SPI_FLASH_WINBOND=y
>   # CONFIG_SPI_FLASH_USE_4K_SECTORS is not set
>   CONFIG_ARM_DCC=y
>   CONFIG_ZYNQ_QSPI=y
> +CONFIG_SPI_STACKED_PARALLEL=y
>   CONFIG_SYS_TIMER_COUNTS_DOWN=y
>   # CONFIG_GZIP is not set
>   # CONFIG_LMB is not set

Applied.
M
