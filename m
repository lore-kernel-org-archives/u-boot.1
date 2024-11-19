Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A542D4415F
	for <u-boot@archiver.kernel.org>; Tue, 19 Nov 2024 13:38:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BEBCD8959F;
	Tue, 19 Nov 2024 14:38:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Gw+Js2GR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8781F895AA; Tue, 19 Nov 2024 14:38:25 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C48089596
 for <u-boot@lists.denx.de>; Tue, 19 Nov 2024 14:38:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5VRHywMMWIScOsCEZMRBFumt1RFuJwErw9QSdGXsqClr6tou8D06bkwrvG1k45a/S2rzp64tpkyFye6WQYcAM4o6xru/sylfMr7TOrHV5+nlmMP4uq6kxtgbhBBqQpJegF0PS7Qdlz+0CYvAe52//rB0Xz6kcHynvXo7UXnJDt1TQWB1Ta5Zlas+bZScLmEkr2A2YnCtFIiEcKjAG4meqWb5alvAgbTkRwtOdhbgSgs5waprMUUT3E/gzX7A/67GqWlMx+ETI2aGeJWQwdE2KcaQpYSqVFZaafdtiByZuZTMTMl8K8j2UZOOP3ZDbRNFHkoXM+D1Hu6vIDTt27Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/9lsKTw3iDBGi7ccJJ4zhl/WGGnFhwNziMMlljAm+ME=;
 b=NFvOvlfSiE4jAx/yVm6Q5bJZM16ziiS4gxz6RSVMvybcZibxwvqDGdhcanwIww0szfxPwo0oKgNvlEJ6WPehSU8/C0NVxCDXkBRXfGY2s18mx4Pta+fRmPcNiHOlZTAnBg4wrRF9gId9bAhy+8VaG2NoESTw4CM9NRiAzIBUSAa5a+tS1OfN+lFW3Nt5V1hixDtJ+koWYIXXY45DgnL0BueeY0qUxZ/rt29N42fFIiFlnQRYA3uahjEbY+55+wEBR1qIWlgAcI3e+95g12uvS1dypCJB81ETmPdGrh6/+py843FJp+glcwQWk7pkW9r7oR/Wd9UDImSm5Jycl760DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/9lsKTw3iDBGi7ccJJ4zhl/WGGnFhwNziMMlljAm+ME=;
 b=Gw+Js2GRHSMCOcVZcQdUmY9dEXP+7/GSjQ9ZLtKIVdr6PMRCvXg6ahznhVpqaEBGD8c7znbLHkMbAvcNIZsGgJZtf1xkf7H2LftbmHeUEr0ruYqO9m1il/gdShPGA/3I4A0HtMB5xq/dINBCCWxD7mkfvZr9tNSIIZe3XaBxVNI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Tue, 19 Nov
 2024 13:38:20 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.8158.021; Tue, 19 Nov 2024
 13:38:20 +0000
Message-ID: <81d62bc3-2944-4f1c-a5fe-60398e4ee273@amd.com>
Date: Tue, 19 Nov 2024 14:38:09 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Set default RTC device at start
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 John Vicky Vykuntapu <johnvicky.vykuntapu@amd.com>,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <01155f1555dbd42adc618906629f5fb45754d5a4.1731419926.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <01155f1555dbd42adc618906629f5fb45754d5a4.1731419926.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0025.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f1::20) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB5805:EE_
X-MS-Office365-Filtering-Correlation-Id: fe33e55f-3da1-41e6-3db1-08dd089f6e4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RG55VmdsbVE4cTRWYm9nWGFCTHcwWGZiZFZ2YyswaTJzbGhmRiszYlpTb3hQ?=
 =?utf-8?B?azV1SDNkRXVLNjZxTFNiYzFYTTlCNkc5VU9TVEQvenhGT1VRb0xVU2QyTXQw?=
 =?utf-8?B?SnVienJBV1EvbFRwTi96akl5MFVCREY0SUNnUUNsVGl6aDNzZ0NGRWdJalVQ?=
 =?utf-8?B?RDRtUDc4YmJac29BZmhXdnN1ZXNJVEtxRHpLYzBYZ0VKVXh0NWpuNlV4SFhT?=
 =?utf-8?B?S2V4aXZIVHVhSzBhTEJqWVJ2eDJQQWczd1cxRUx0SEV3bUNmZ0dWRHZzQlhz?=
 =?utf-8?B?ZjJJWldlSlkvKytzL3B6bEFRd2MvRzAzYUZET3M5TVc0dlQ5Q041RlUzYjRo?=
 =?utf-8?B?dTQwQlgrMXpzamZNbzhEeFVvZ1FZcTJsbDF0UmVxaFVYWVN4aXk3YWxkeVFP?=
 =?utf-8?B?RTZxK1ptWlpVUmNIaWwvbDN6NGwvalBEdzNRdXVXYUhGNENic25OVzlUQlo3?=
 =?utf-8?B?UWxZbkl6bW1KNzJETS84Z0NCNGNVLzBpeG1zbHNFbGk1ckhXNGdsWWwwd1ZG?=
 =?utf-8?B?ZnR0bWJwZG0vclkzQTFhNUR6a3k4S1RoVGFhNk1ZZjNpU1krYm9ua283bWxk?=
 =?utf-8?B?S0ZMU1U1dXhreGJvTXhRbjlKbU4xUGl2WWhwVk93eXZmamZoNG5sR1pqVTRt?=
 =?utf-8?B?emFxc2w1dkZtM1dDaWdvanVZQmRLWDhKZVZEWWw2b3JzZThkKzA4ZDZzV3ZK?=
 =?utf-8?B?MkxGdS9pZTRQOVVmVlNvYThHRktHbFBXdyt0K3FteWVCNmpRY242TjRDQXNS?=
 =?utf-8?B?WXRhbmpsUVV5R05ra1RTdVY2VGViYzNjUzY0c2ltWEpCd0hwNkRTcmdYZldh?=
 =?utf-8?B?clBGK2E0ZDczbkwvYW5tSW1tRHhVbFpNaDdQU0JlNjZ6ZGE5dlcybytudDJj?=
 =?utf-8?B?TnNrNE9HNEhOQy9xYUt0UzZDRG1BYmloQ1ZiZDdWcURlOTVCMFJqSDFCeUdZ?=
 =?utf-8?B?c3d6cEtVWDc2T3FPQzdGdmM1dXpQMHZob0o1NUpWK1dvbG13Rm1NTERwUFgy?=
 =?utf-8?B?MW1EVDF5QjZvVzE4ak16Q3ZFM0dlWFNFd05yK3Q2VHI0ZS9OS2cyNzl1algz?=
 =?utf-8?B?N2JlVDJPdmRVSHA5ZWtYbDFhSlU2dVRCN2c2V21mc3ZZeTMwMXdvWXZyWnUy?=
 =?utf-8?B?QUdFTkFkTjMzU21vM1MxZmErSkRjRWdCZ1plSUM4cHdSN2VpN3UxaWlvdjRx?=
 =?utf-8?B?UFMrWnZEUWJXa2lFdVpBSEd6R09wMzJMQm90MWl4MTFCK2xYa2NabEYxK0U5?=
 =?utf-8?B?clRhRm9VUThyem0vK2xGSnZWeXZQalV2MG0wUlIzVzQyeUR4Z1JSUnQxcjEr?=
 =?utf-8?B?NUNtVStoZHVqbitKZDc1R2t4TWphSVhPenA5azNRZXVydUJmUGZHU01EZHhE?=
 =?utf-8?B?S0NlUzcwSFAxTUtsdDVST2crbjVJQzZVNmdwR3NBVEpEa3c2TURNbHEvTnNW?=
 =?utf-8?B?bFBLUWQzN2xQdElOdWJzK0ZDV3RnZ2RYbDdvY2NPZ0lnRmx5UThLRjlNK1RB?=
 =?utf-8?B?MFVqU1NmeU9LUGVXRndvVkl2bHZXRlRWTHNBUEM4OWQ2d0RLTitoUEJzUGlw?=
 =?utf-8?B?RHY4bzE3YkgxNzJDNWIwOGpqT0NhTXloYXhUSklCNFhjT0k5ZjBNZUJaZUZx?=
 =?utf-8?B?ejN6b3M0cXI0ZlJlZEJLTmRadlFpVEdxNVNnUDdzdlFCZDhuWWQ2WmNaV3Br?=
 =?utf-8?B?Vlp6c1Y4K1h5UDRiejhkNm4rNmtwUnpDdEh1RlE3MUFsQVQ0d201c2FNNkhO?=
 =?utf-8?Q?UT7EwvR6YV9w70Q+uPg8k3qOxV8k3Kx/9DzTlRl?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3RKY1AwNWw1bEZuMms3WUpsa2puSVZGR1g4elFudk5YRXBkZENtNXhYRkx1?=
 =?utf-8?B?Um5VYmJ2NGlWTGJ5YlpxZlpRRmNvQlZib1RnYUk4cGxtU25WNjhkNE1tTCtM?=
 =?utf-8?B?Wnl0QUhVZFAzUDJEMm9rZ0hvYzN3bVd6dkFQNzlzVzZnNDRUVDNJcHBhblBm?=
 =?utf-8?B?UEQ0dmM0c0YzYUN1ZHNHQ2E1M3dwclVxcjYvSkJzejkzbjMrdGJlQTlLbTZ1?=
 =?utf-8?B?Vm90ejBDTGlSNWhCdldpc2VrdWVJTUhqNG54QUt5blJWMFZNa0FLSlJlRkdu?=
 =?utf-8?B?SEZTaWpxaEJyS3g3c0RGSlF2L0lIRlJRZmg5QitEc3lvY251SXlyRGxsSDZ1?=
 =?utf-8?B?c0NUbTYyWEJkeVJRWTJTaGR6WjFIeTlzTktHWUpVdllsNmFBRU1XS2ZUTGVm?=
 =?utf-8?B?MzlmVkFNSllpWnRmZ3R2R0RSdWwzTEtaZjJjUEVLNU9qL3hESnhHWXk5TEpM?=
 =?utf-8?B?WFM1TmNJSGt0UVVRbGtYOFRYTGVEVzc0em9MQlI5QUV1eWhGYjhSWHl6SW9O?=
 =?utf-8?B?TzdYWUgyVmFDL2FuTk03RHlLYTQwYm9JVTBQOEZDR2NtT2JNV2NWOWFxb25o?=
 =?utf-8?B?V0FPcTB4MlR6TGN5aHdqSTVHMXhyMlByRGFHNEJ2V1lRTGRTYTFZeE1QQ2hX?=
 =?utf-8?B?VUViTmlDZEMxY3lSR01xK1Fma2NTZFQxRzJ6Mkc2RWJPcEVHS3piMlJRNEVs?=
 =?utf-8?B?LzVtOUE2RHNEaFp5eTEzQnZITlJxMFEvc2xwR0c5ZHpyN2VYSmZXVDJxMVdD?=
 =?utf-8?B?VWhRR0lIWnJtSFRDcVk4ZUt3Qjh1TFZ2OXJzeG01RGNsQlp2aG1mMzJ5elNR?=
 =?utf-8?B?ck4vTXJLbTJtVjEzVGtwOGhvTzZTNmdaSGNsN21QYWdyYThESDdwQ2swTEpE?=
 =?utf-8?B?aWpibFNSZUxtekYzekY1RmxNSG1yYlNDTjBqaTFPRGl6L2JuaTU1c1AwQmFi?=
 =?utf-8?B?T1lsZlVkWTZTblB5SFBCaE5RaVA3eFBuemU5UktKL2dQelNZV2ppL1N4S0M0?=
 =?utf-8?B?V0hFbjN1VDNmcUlaS3BMUDdtazVIMWdZbjFiNFEvaWdMYnpHQ1hTbnlEclU2?=
 =?utf-8?B?L1VCNSswQnB5a1FZaStqd1dOTWhiVUV1Z0kwZDlRMTQ4b0d4MTNKMFBvanQ4?=
 =?utf-8?B?MHBhSmNmT2pZSDBpa0R1bThKR2xDZFh0emdDQW5CK0JuZ0g2TGdLL2Ztcjlk?=
 =?utf-8?B?K2FFc0xmTnQxMnBIakxUWm5UVkhOQzd0a2locEZyRkp3MVlxcFRQSFkzWG1D?=
 =?utf-8?B?cmR3d3h2ejBUUkE4TU1hTmFVK1NnRngyNk13bjlMSm1BU0ZKUEZ1MitWd3N5?=
 =?utf-8?B?WkxwK0had1J3ampqSTRYWmlpL1hiSGJ3UHNaVmZXaHA1T0VVNWEyemcyOTdP?=
 =?utf-8?B?R29pV3A5L3QwWnkyMzB4YkN2NnMwQ0NWS1pFRDFsdTN4K2RBbjNFYmVvKzFn?=
 =?utf-8?B?dXhLM2QyTVBpeTEzU3ltMDYwN282dUJrTElCSE9paXNwSlRUMDhkUlRqdlpI?=
 =?utf-8?B?MkNZeWZVNlExMXpWLzBINjhrZUJzOUZ4azBDcnpTYzlXaGRZcStUNWdzWG5u?=
 =?utf-8?B?N2tTMWZoQitmZnJjaHRlSkNiSDVWek9CVHZCeWJHTHZVZUhKcjJnSmVjWWQv?=
 =?utf-8?B?ZExnb0RJektYSHhwV2tkbWhZamptejM5UTdYT3RuWGJVeUZBOGcwZTY3ay9l?=
 =?utf-8?B?UU54bC93ME5Od2I3THA5dXdTWUpSUit4Mm5PWkFockcvR1NXeExyVndBeGxr?=
 =?utf-8?B?ckliQVJCMXZMM0U2TFZKcE9uS3NsMURmM2JWYXFFYlNkUHdwWnRjamg1MmZr?=
 =?utf-8?B?cUxkOG5icndBYTNPQXNSdFBKZ1lBb2xMUjQvRGpmaHFzMG00T0NucXlPaEZY?=
 =?utf-8?B?cG5MRi9NVTdnbDlRYThEKzhxVHk2V1lCNXczcnR2L3RvNjZoTnNjUzF2aGF4?=
 =?utf-8?B?VXN1Z3lISGtOOEtMMGxCZjFkSEJuMHBGTCtuVVdaamxkemhvbUNldkd3MURw?=
 =?utf-8?B?cVh6QUZIYTZ3ZXQxQXQwdk5yNHQzdGc2Z0ROc2Myc1lsSWFPNk9hOXd1VWZL?=
 =?utf-8?B?dWppTmNRZFFuRlI5RTNXajFpVHlkSEpJbzVrQUpZZ3lsL3JmbFQ5c1lxSW9J?=
 =?utf-8?Q?Yei1Erb5BANIEp3Ld+D2+lXVd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe33e55f-3da1-41e6-3db1-08dd089f6e4b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 13:38:20.2231 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6XNQVMjaEbbQUy4W9BNOtW4nx117QVkzvdABNhm1U6KZiZXz+B727zgL3NmVJnTu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5805
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



On 11/12/24 14:58, Michal Simek wrote:
> For RTC to start to operate there is a need to call the driver. The simple
> way to do it is to set default RTC instance which will call the probe and
> do basic initialization.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 927f398c3c38..ff3a0924de7d 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -77,6 +77,7 @@ tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${
>   tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
>   
>   board_setup=\
> +rtc dev 0; \
>   zynqmp mmio_write 0xFFCA0010 0xfff 0; \
>   if test ${card1_name} = SCK-KV-G; then run kv260_setup; run tpm_kv260; fi;\
>   if test ${card1_name} = SCK-KR-G; then run kr260_setup; run tpm_reset; fi;\

Applied.
M
