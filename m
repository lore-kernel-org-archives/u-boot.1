Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26665C25B75
	for <u-boot@archiver.kernel.org>; Mon,  3 Jun 2024 14:32:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0E3287ECD;
	Mon,  3 Jun 2024 16:32:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5OEYr25R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC10E8780E; Mon,  3 Jun 2024 16:32:24 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0BA488300
 for <u-boot@lists.denx.de>; Mon,  3 Jun 2024 16:32:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSXAXxuxqpz3dJ0DBqTW6nf4p0lfC0kzAaxNQEENgfNQajOEnoViz+pJc3pXx+gLgCD8u8ti2/pTDdvoPlf2aD3BzR7MpEUImPcexDtIebsuzaIz2nFng2Y/W0YxTaAfbTqAp4hgmyPDRHmI6Azqp3o3gvhaQiW0+ccb+jBW4c5XfWz3oQ7zuhkaC9rzf6ycoAVNR0LLPnWHBQEeGl5jG5mGLBX4bxylfNb8Ta4vxGC7MsPdx9kCdiRpOW4z6b1pjpLiA0qYy27+EZ/uxxbBIyk+2J/O+/EPxV8/X8Xj1NCukOUbjcYtZhBjxI21xo6v3rCJHzH8a0Ne1VPea0SUAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QyydWJQjDoXnKK2LVl2iT6zBHgPFWj1FLZq3uZ1KJA=;
 b=nRCi/u8/jm+zoYWqHmC7mKfPnvjvQuVobx3JJZ5K1KbpnWm9RsHaWXAXMxqhwYEo/Hy1si6VcAmMvQXn2BMJb2dQ+2Y3sJ/4rcM3CZUD5rJiuH8NbIRrIkbDgEybuBT/4P8s6DqO1E26POIeF3q06zE+rf34ZsBshzGkIrVhOJ0I5AEg7n+KiSAxaWnCe+7DuBYMAHgHmOtOnFooz8HKjMvMUW7IIto9PygDTjy69JPwd3M11sOlavhbdPU03eo/aByuOt9fC1qwwV3ZyzSC4wu9rTZC64nn31LN+dTVMiWfAJaX8iXNNXW7/QkxyiM/DSfeODiyTrlCumKlsvw3Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QyydWJQjDoXnKK2LVl2iT6zBHgPFWj1FLZq3uZ1KJA=;
 b=5OEYr25RsBDFlqs7OZGwyHHk68MYDOIZMI8ZaGqiCcSXtuCGoTrWsMn8HCX6iHvA9uFb92JAokAJTX7CjSPJivOwiSNMTI94dYRIsW39Oo8bTUkOL274ACasTqrlH2EU/LPzfHoWDZkjfSIQWVxm5XAYBg+ow/cAyMXJ4gsBCkI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.24; Mon, 3 Jun
 2024 14:32:19 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%6]) with mapi id 15.20.7611.016; Mon, 3 Jun 2024
 14:32:18 +0000
Message-ID: <d0489c83-7225-4127-9ba6-e9b29165d2b5@amd.com>
Date: Mon, 3 Jun 2024 16:32:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] xilinx: zynqmp: Enable reset_cpu() in SPL
To: lukas.funke-oss@weidmueller.com, u-boot@lists.denx.de
Cc: Lukas Funke <lukas.funke@weidmueller.com>, Tom Rini <trini@konsulko.com>, 
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <20240603133447.173402-1-lukas.funke-oss@weidmueller.com>
 <20240603133447.173402-3-lukas.funke-oss@weidmueller.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240603133447.173402-3-lukas.funke-oss@weidmueller.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:a03:338::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 01737a78-261b-4829-8924-08dc83d9f8ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NGJIODZKOXZ0RVVRK3JqZFE1bzRiUWpTQW1xMWVQYkU1YWc2L0xlZHljL3cz?=
 =?utf-8?B?TURBUUpIWWtkd3FiVzZUbFZQTDU4Mk0vWER6YmFhKzFsTzQrdTQrdUEzakdU?=
 =?utf-8?B?WEhKdXN0NkZLM2drdFYySW9xN281M1I1a01aNlVtSWRiLzRTdGJTaC9ZUjlH?=
 =?utf-8?B?U0RjYmF4WTQ0V3hnZEZuRGJxSmJvbWgrTjlvVDFVM3BLSi9wa0lFU2FVV01K?=
 =?utf-8?B?emRrUGsvUkpqMnBuTXdQU09CVDFJVFJ4U1FVWisxU2tlb1cxdEo5RUpzdDFR?=
 =?utf-8?B?VHlSaFo5d3BYOE5iM1BtUnVrQWVtcWJjOFN6R2RyM2M3KzhNVk5qb0hLRkRT?=
 =?utf-8?B?dzR3M3FES2s4eGJzMzF3NWU5dVZkSHFPM0NZMkNGSFFQOCtxQ1AzbWNIMzNR?=
 =?utf-8?B?b3BjaG1MZmJXT1Vwd3h1YzVDbkM5NE5vUVcvSzgwTzlaUmJuN01sNFBEV3p2?=
 =?utf-8?B?c1A2MG1aMG4xYVVaUkViWlh4Q2cwZkpQUHBsaE1OeUE2UEgra3V3RHBiOW4z?=
 =?utf-8?B?QmdNTy92WHo0RHM2MmZXQ3VXODFTT1ZwTy9pbmVpU0xuZXI1VHptMUk0Q1J5?=
 =?utf-8?B?R25ZMzNoK0d2TGhHSFZMdjE3MFdZMkdwb0ZtRVJPU3RrZitCZkU0N29LRHpS?=
 =?utf-8?B?Zkg1RW1nNUlYbWYzSkZ3djZZcitRTjJvelJjV29wdmJkK25OaHlnOVRsaW1W?=
 =?utf-8?B?Z3owMWdHaHZMYkc2VnRQYWFUQ1VBalVaM2czWXRjTzczcC9aOCtwdGlzSS9J?=
 =?utf-8?B?eGIzSDZhUnRrQk1VeEd5WmF3alpaL3lGYkxzeVNDOGpyWWE2SlRPVlhKUFBF?=
 =?utf-8?B?QlVNd1NubHEwenlveTA5U2krZ3RJZWdQUEptcUFMVHlzZzZSMkdabGN4WFVV?=
 =?utf-8?B?bHRvMXVYZXdKSkdLK3R1b3gzbmUxUEpoNEdoeGlpeDluV25taFhmWHhTMjZw?=
 =?utf-8?B?aDJqbmRmaXRRSyszTDFvVkVlLzlvT1FLK2FZMXpBNHMyRlpuTUJsamtKUkt4?=
 =?utf-8?B?bm0reWZFejhqbVJWSEg3Mi9NS0JnSHk5RDQ4cHZZUlIyK1NnMnh4M1d5L3pE?=
 =?utf-8?B?b3dmMjFlb3lUaS9Ib2xzMjdmay9iRnJINUw3M0cwVzk5WkNyQTI5Sk0xdEhn?=
 =?utf-8?B?VzgrUHc1RURDV1dRYkR4K3g3WktTNVVmY3gxTkFxYm5GdFJ0aDNOMjlsdVBI?=
 =?utf-8?B?QktJZjJIcjk2VSt2eHdyOUNsV09ndEVHNERqdnFDREFCZzZ5eFJPSXdscHVt?=
 =?utf-8?B?YTdVTjk0T09WODJ6ZmtNdmVJSGdnK3Q2dElwUkZBSllRNTI1ZW13K05YZVQ5?=
 =?utf-8?B?S0JRK3VBM2FSOUl0aVZkcitTcGVWK1M1NThUQ0NYT1FoT256cC9oSkZ2NGVY?=
 =?utf-8?B?MGVUajhiNFdlZ2ErVDBLWkNoWEowNDJNSXcwUERaeDFYSWo4MzJyVWJabjNr?=
 =?utf-8?B?czFRTGlSbzZHK3NLVUpMb1U5RmtGZkRGVGEvSUp0dThrazU2SmJVWHRWYjVz?=
 =?utf-8?B?L1ZmVzNFOVRWMm9BSHVMendiQ2RoQWgyZGtvYlVHeHk3dG1qMEMvbm9RSGor?=
 =?utf-8?B?RHpKM2xwcVdWKzh3QTVWSUZGemhwaDJqYjNNQm56dllwTDFiZFpweDJ2M2l3?=
 =?utf-8?B?Z1hDRmtkbEg2TEVnS2JZTFRVa0VTZjVZbHNFeHJtbU5Na2pLMEVLc3FiTWg5?=
 =?utf-8?B?a25qd0tsVVYvSVJwTWtiWFpOMGxKam9sUmIwdFMxRnMxKzByRkVkS3ZPVEI3?=
 =?utf-8?Q?3K2080ntgBYcC8P6WDbcoob/Wc5XxHd3VI5oiG0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(366007)(376005); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkpBengxRDN2MlJqNVVXbGNiRW5kaUpiVTcyYWRGMGhCc3lWQlRJTklxdXAy?=
 =?utf-8?B?azhpNFFVRmVDbjNCZGRBNERHZGNSVTFsRTdESXNKQjRLbUQxM2dZK1pQOVcz?=
 =?utf-8?B?d3VXOHhLLzNFOEVDa29kRWkzREIvUU9LRkV6N3BWZm5LcldFcjc0VXBhOS8w?=
 =?utf-8?B?blFDSnQ3dUNhTXdFanZsdkpVVldnVksyTGROdmh6UmRvRXlXOEFncDhBSDEr?=
 =?utf-8?B?SjE1c0xIQzBGVEJocEhoY2Y2MzJrSVZJZitBaFVERGIyVGk2K1YycDNYOG9I?=
 =?utf-8?B?RzNoM0R4YTNEMmlRUGpGbVE4L0hSWC9DaFVEd0pJN1NDVkk0czVLdnh5dFJk?=
 =?utf-8?B?am5ueEJ5RVIzN1R0ZVhXQnZXTlk4Wlkxc3dyQXZLOUVrQUszTUp5NlE5ZDF4?=
 =?utf-8?B?emJFemhTZTAvTW8xT1h1elo2QVZUM1dFQ1V5NDNvSGd2dnhMaS80OUJrMEpQ?=
 =?utf-8?B?US9DcWZ6Z2dVT0FNOUlvVldJb1orRHp2WHFPYTYxUGJQRzRSWEVJQUVMYTJK?=
 =?utf-8?B?eFFkQkpRb1JXUHZWaXpEdlA0dmo0VGdDNkgySVNFTENaWWpOVXhZUnViS2JS?=
 =?utf-8?B?MW40a1VUYjBZVTdzZnA3VTVZamJ3bERtcHJsUXJnVE45ZzRUd205bzZxTnor?=
 =?utf-8?B?RmRFRXJFQ3BkVVB5Q3M0ZkxScWVKY0FNMW9ycjhhR0M4eGlwK2dUbVA1Nld0?=
 =?utf-8?B?Y0lWWUNLM2pWTVBhaXhnRlg0NjVYR0grMWxoZG41bktkbk0vbE5FYVdaTklZ?=
 =?utf-8?B?allPSWtsK2YyT29nbktjREJOQlVLS3N1a0xwV3QzVjA0RlBxbnpVOGNBd0Zt?=
 =?utf-8?B?K3BFQWlZRlFyNzVCWndKclUvczluMmc4V2xYSFJuNU0yS0g5K21SMW1vUE42?=
 =?utf-8?B?TWQ2ZnA5c1B3VFc1Nm5rZmk3UG9xZlk2MHFMQnpSejBOQWt1N0tYYWhzYzYy?=
 =?utf-8?B?M3FjYUxxZXRSNjg4WFoyNHJzQmNnN3AreUlvY013dzFrUGtnRERjNHFrK3NQ?=
 =?utf-8?B?WXVIUGd1UXlEL2xSTDhSZVdKL3lQOEZlOGt6TEswNnRtdS9HMUpZRnRUWm5C?=
 =?utf-8?B?ZVc4ZDRxUnh2OTdJZVJ4b0gzUFZKNmsvaWZFMGt6bWNOT3hUSGl0RENNb0hS?=
 =?utf-8?B?VTdFaFFVRjFnd085NWxGY0VxMkwzTERpY2pFSWpINW5VeGJ3RWJJR2I3Y3or?=
 =?utf-8?B?S3lyVjE2N3NXYm40SGhsbENTQzE2N2t0TWEzelhHMDQrRFkwTUNxbXhjK2NZ?=
 =?utf-8?B?VVI5L21EZk1wbGdSQmhKQ0Q4ODNHTzRsR3JnaTY0dXVvQzBXU3NlSXJUdFkx?=
 =?utf-8?B?dSthUTdCZkZ4TGpkSzY4d01rSGswS2NaK010MVhpTXNCeFcySm92a2lDdU5Q?=
 =?utf-8?B?eGdsWHo4TTNZQU9JTmNObHBHRHNWd0RsTzlVTzMvOXdicDNWblFqelNtcmJt?=
 =?utf-8?B?MFU2MTR5VmhnemZ1Y3RjckZvOU9QRjdKdVFlMVpsb2NLLzRLdGhqTVJ5bGFm?=
 =?utf-8?B?UTNGQnVEendHT25wR3FpNVhETkFMVlNxNWd3M2NwSWR1cWw5RksxZ2gxL1JV?=
 =?utf-8?B?eUlGQmQrUlpoOFE2ckgrOFo0TGZZQzZ4OS9YeGZZdHFzcmhwVURNVnJuc1oy?=
 =?utf-8?B?TXo5Vmw0b2VUYWZMK21qZE9xVVdYNjRlRmlocVgwQW9JSUg4ZU9TeHJIZDlB?=
 =?utf-8?B?V0xIcmZyaFFjUkl3Nk12Nyt1WUcvcnlYYTBqcjU5ZzNrc1N1ZTNMakhQR2w2?=
 =?utf-8?B?dkYzUE55Ymc0dytpZmlWVHk1a3dHelJmMDQrdTA4Zi9VNkJ6Q1luN0JkRUd0?=
 =?utf-8?B?RklrRGwvejBTbUUvdGNIZElIMmo4M2xFVFlJcEtKL2RzT0ppM2tjdXYvQ1d2?=
 =?utf-8?B?VEtRbHZnMDROL25DaElueTlkRWwwTHVkVDRqeGVuY25hdUNwSS9wQnI2YVZ4?=
 =?utf-8?B?MlZxQ2dRYm4wQ2ZxV2pjT3VmRDREbzZ4cHNaYVRFeUQ5bmlUeUdlT0E5ck9T?=
 =?utf-8?B?OEE3RXRTWlNaRGFSWVpEWDNLU0VReHlyYnBWQkFyVWVKU3ZZR0NUbkpwRFU2?=
 =?utf-8?B?YnU3d2hkYjRoNVZJYTJKTFUxcDNpSjBvNzlkUE42TnJpbnoyNSszZFVWa1BL?=
 =?utf-8?Q?ai4gXNWvlnOEFE8qyouhwHsX7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01737a78-261b-4829-8924-08dc83d9f8ca
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 14:32:18.5806 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jHm1jn500zBC/4NZ3KV5+/Ybdb2zZS5Hkuuw+EoXMGp6Og393GN5EUQGKwjzl2XW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039
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



On 6/3/24 15:34, lukas.funke-oss@weidmueller.com wrote:
> From: Lukas Funke <lukas.funke@weidmueller.com>
> 
> This commit enables SPL to reset the CPU via PMU-firmware. The usual
> reset mechanism requires bl31 to be loaded which may not be the case in
> SPL.
> 
> Signed-off-by: Lukas Funke <lukas.funke@weidmueller.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp.c b/board/xilinx/zynqmp/zynqmp.c
> index 95a134b972d..99f5c178c1d 100644
> --- a/board/xilinx/zynqmp/zynqmp.c
> +++ b/board/xilinx/zynqmp/zynqmp.c
> @@ -40,6 +40,7 @@
>   #include <linux/bitops.h>
>   #include <linux/delay.h>
>   #include <linux/sizes.h>
> +#include <dt-bindings/reset/xlnx-zynqmp-resets.h>
>   #include "../common/board.h"
>   
>   #include "pm_cfg_obj.h"
> @@ -285,6 +286,14 @@ int dram_init(void)
>   #if !CONFIG_IS_ENABLED(SYSRESET)
>   void reset_cpu(void)
>   {
> +	if (!CONFIG_IS_ENABLED(ZYNQMP_FIRMWARE)) {
> +		log_warning("reset failed: ZYNQMP_FIRMWARE disabled");
> +		return;
> +	}
> +
> +	xilinx_pm_request(PM_RESET_ASSERT,
> +			  ZYNQMP_PM_RESET_START + ZYNQMP_RESET_SOFT,
> +			  PM_RESET_ACTION_ASSERT, 0, 0, NULL);

If you disable ZYNQMP_FIRMWARE xilinx_pm_request() should fail.

we should likely fix it in drivers/mmc/zynq_sdhci.c:114

Thanks,
Michal
