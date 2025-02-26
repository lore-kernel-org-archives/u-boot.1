Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BE28C021B8
	for <u-boot@archiver.kernel.org>; Wed, 26 Feb 2025 09:53:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C098680805;
	Wed, 26 Feb 2025 10:53:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="l77L64b5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 242AE80F88; Wed, 26 Feb 2025 10:53:21 +0100 (CET)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2417::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BBC2480805
 for <u-boot@lists.denx.de>; Wed, 26 Feb 2025 10:53:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O6Slx43gQm9bpXo9dMa+ty3HUN0ioxRYY93nLF6J4F1dGiVU5+yBuwSYKlMLmAQMfZTBS9h0SYUW1AdSymECyVbxy+RW2JzR9Vydq/Hw/2OXTyMWm+XxPUXDgrxzAFtUwhn8UVuj+WeXouW2RB+56d70OCqpbE1Hf/+METGtM3LkJ2mjNzG/KWIO7etdnT/5yjbcY6mRLQm1OiX5GGIfPMjyfq+AXW1bn6Oeq1GWCm4sDNODYGDZHp7zRBrlXetkCV2Ng4gcuumAMPxX4KGoktQl8/3HQ4EiJhVUFjhWHcO1qK22MCDEEC9ItuiShcC0++e1nTkoTd6YlOMY1e2U5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RaCEN+Db7BeUsI2RCk5CYNIeeDh03nJf7VHk2+UmKGU=;
 b=B9uh0QwYUWHgJk5JXUwSZEkWISEWMhu4tgkSo0zO4o1pYcPKlcipdiwlyO3wjfC0xydOHpMuo6gi8Z43ZsvCD1Ns8RcVD70eF1zmIdNPDVuifQ0AEYBZgBMQK8IYzA3o9Jrf2aEcSE+DZyv0i7fyo3CinxE7mXglGh578WBwn/lWoRjWcoM8cuEzebCuOGwD1zKL2Y248nqfRaF86lhRKQBuWG9GjPlXK8AkmVonng1DCNCCPzFaQe1uiKNXmeqcz3QHKv+17rvT2rQHNMN8VC+sbi8ggzZIiAV3tJ5HPEX3Tp/VEd8kNChHfqy1KT3ZFKg46PofSAXbiT0beXAwYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RaCEN+Db7BeUsI2RCk5CYNIeeDh03nJf7VHk2+UmKGU=;
 b=l77L64b5pex2us88CRGPoKucXtljmuyWXeZR9QP3C1eSAzkezlABxEleIXPWTyZ77uzbTgucITzgOkjWZNv00TO+K1OaRjPanRD2J8MKRvdZ7uz1ca9ADypoH0M0gt33EkPd43VYSUZr/5D+snt6Gad2AhSk8Ajjk94vC69ni1s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 09:53:15 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%7]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 09:53:15 +0000
Message-ID: <f0826439-eb4f-4804-8da1-a65e0a98b407@amd.com>
Date: Wed, 26 Feb 2025 10:53:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [UBOOT PATCH] xilinx: versal: Add firmware access to CRP Boot
 mode register
To: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>, u-boot@lists.denx.de
Cc: git@amd.com, Prasad Kummari <prasad.kummari@amd.com>
References: <20250221092248.1731965-1-venkatesh.abbarapu@amd.com>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20250221092248.1731965-1-venkatesh.abbarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0053.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::6) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: 18eb2a1e-60d7-4d21-936c-08dd564b6374
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Zmo1UmZJQUFsWmpKOHRqbVJMME1YeXBNc1Izdm8rbXJZMm5wYkx1MmFWVVNW?=
 =?utf-8?B?RTRwcTdWdEEzYmRScXNMcVk5WVkwZVdsaFY1Q3M2bnNDY1VtQ2x1MWxFWkRK?=
 =?utf-8?B?NTVBL29DM1ptZ0FpQVNxMTZ5MWlyN3JiR2grYkQrVlJDcUxYM3hERldyY2JF?=
 =?utf-8?B?a1g0NTVURFpJekV2bnl6UkNRRU80eHQ2bGdOY09DS1BabStBRlc3ck0zVGU4?=
 =?utf-8?B?eXhXbEYvMkpaZlN4ZXNsVWhMWGRha2dhVzNoc3oxbFZzLy8rQldIZjVoajdz?=
 =?utf-8?B?S1h4QlBad2N5SE1SODFMN0hBNm05OGRxbGdsa0ltdHMzZEF1K2t6NXAvV0Qz?=
 =?utf-8?B?allvUTdJaGtWNGpKc2FDMStqd1RmSXNLbUpnWFFmR1FRU2RwTmxKTS94QTNH?=
 =?utf-8?B?ZzltWG5ydzk4UnFRTkEyVkVYQlorS2NSMGxiSytkVm9rR0Z6aUdXUzdYeFZV?=
 =?utf-8?B?RU54L3JoTmtZUG5rZHRpQ1dRWU9JTm1CV29WWngrMHBxNE1WeTFwcHg4YXJ1?=
 =?utf-8?B?Tm4wbmdacWNuaWpaTTAvN2s2MWdONkdMOXVobnErdDJldUNUcDkvREhiTDZx?=
 =?utf-8?B?TWc4c2RPTE1qVnQ1TUJRUkUyenRZY2w3NjYyYVQrRnZ5S3MzRElQL3hGZ0Vy?=
 =?utf-8?B?V3RQcUdES2NYc1hQaTNiTU9FdjV0V0hZdEV3THlOQjl1ZTBZUkdIcjRJUW9Q?=
 =?utf-8?B?SzkwQ3ZHR2tZNm1KTUw0VXBabjVkbjQ3ODhEWHczZ0ZXcFBWQjVyTjA3bHYy?=
 =?utf-8?B?azVhWkxtU2NuQUJJZXFVTzBrVzVyUDV6dHMweTl1Ry8vbjY4OTA4clgyNCtK?=
 =?utf-8?B?aDgxVnVFY3VZbWRFM1FEZXhLSjZuc203SzRmemV6WlI3QUJ2bE5VaXdNVUNr?=
 =?utf-8?B?Vzl3QkYvdmVGUlUwdzFFWGdTYU8wM2MvNUhxVjdHS0hWVDh5amFhakxNaWEy?=
 =?utf-8?B?N1NjSklON2dwRDIxbTM1SVVmbzlySHpRQ05ubFV6ajVIb1k3Rkozd0xRWGF1?=
 =?utf-8?B?NXoxdmFSVERuNTJ4NWVUMFA2MjVWM2lWMDJUa3VJVXplV054cE5jVjF2eWph?=
 =?utf-8?B?RmFGNFh1aGNlRk1LMkJRbi9CQjRaMHJySUhTTXRNaFhsRjZ3OVVLV2FmOFNT?=
 =?utf-8?B?ZGYyajkvQ3dYU1FMVjQyeVhYbjF2dExIOUVwdFFycE1Vd1Zid0NBSEErdTJm?=
 =?utf-8?B?WXVYRjkrbThrQ0t0QmlxczN4bWl5bmpZeXFkSUx3V0pwVm91TS91UmNLRk5R?=
 =?utf-8?B?c3padFd1Zjh0RkdPaTNHc0xWWEFYY2pWZFJUbVVta3FXMmxDSXlyS3prMGpu?=
 =?utf-8?B?UHVVVDlDdFVZRlZ6bGJnMzRpOUgyVVo2MHVZbitBVDFLMU5kNWFJQWI3aTBX?=
 =?utf-8?B?ejViVHQ3elB5WGpGRDJrVDlhamt4WFhvRTlKTTg4THVIWHdKdTFrZlVUdVBS?=
 =?utf-8?B?cDhOTlgva014SDRIWnFadUpyeUtQanB4ZTUwU2IvcXMxdVhzcGFKRTUrQzMy?=
 =?utf-8?B?UUo5ZmMyTGV2VnlHS1JTMHFwaStZU0srU1NZUWQvM24yZDh5NWpSQ1lKVGJZ?=
 =?utf-8?B?SUFHYTdWV2tYUVBDWFdFN3k2Nko5dkVZSjcxNDUwbXF1MnJQTU5hVGh3NlVl?=
 =?utf-8?B?SkFFWUxmMTdlcytYTkVPS09zbWxUNnZRU2tOWU0zZ3BpelM3bFI3YWo3Q1NN?=
 =?utf-8?B?WFlMSWNDTlpTVGpYakhaSDNRZGdvYmJCYkhmMmd5UTFublZqbHd3TllpVzRa?=
 =?utf-8?B?MW1UZWVCajdaem9GTnN3WThHeGdVdGNwbDlPNXhIRTlMNmNSdXZTNWhKeGFE?=
 =?utf-8?B?N2lBNzYxMlRSRXdrMFRialFhMWpjbHIxeW5lb0Z4YUxZU0xFVzlraENoTGIx?=
 =?utf-8?Q?aYtqkjcnSQgv3?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RnJaMmdZcUVOcjlob0dEUFZzRkp6c01DdUZKSC9vdm5PSE5yUEJHYjVZY21x?=
 =?utf-8?B?eklmOVlBV0hnVEc1clNjSmw0eFJnLzRHZEVIZEpNNUdBcDg5UkI3c2FJMkxH?=
 =?utf-8?B?VWxZeGhncG0vSmNxRG80MUx1a1ZPd1ZFdEZaTStheGc2MnpnYmUrQkNJZWpO?=
 =?utf-8?B?QnUveE9wc1RwczNPMVNhckw2aWdrTWYzMmFDL1VhaFVaMDUrSUtSSGpiM1cx?=
 =?utf-8?B?SkhyeUJ5OFpONTc0d0tUaFBuNEsvZlJvYWJMSUNWOTBLd21acENVOXpBanNZ?=
 =?utf-8?B?UnEzYmlFVzNtZDB3RnFncGRicklNV1pkdFd3TTZaUUNFREdpZnZpRjd5dDVs?=
 =?utf-8?B?VU5Lb0pOT3VFMmRWaU81NFNJOU1LN1JyYUtSUzlUWjRPOXVOdmIwc1ltNmRF?=
 =?utf-8?B?UHVzOHZ6R3FXQVJFS002NUdLYlF3SHl0K0NTdDRZeFl2TVBPSEpxd2VpVFJz?=
 =?utf-8?B?djFuNVBkKzNzT0xPQXM2UVYyS0JEMEhnUktiekFYazBzR1p6bGZraXA4VVVZ?=
 =?utf-8?B?WDRFc2Z5bDlqdEM5QUFhZ1l6TVh2UkQxUE8yS0QvUDU2dXdQa3hGTW12MktR?=
 =?utf-8?B?dzYzUE8vTUpkQkVrd0V4UVUyUU05M3pjc1pnSHdpWFNoYlpBdkFEbStNK0FZ?=
 =?utf-8?B?YXVxZWN0RXNmTjV2QUxUbWlJdEJCYWtvS3lKZm5wWmc4ZjBwT0dFT1dyb0RQ?=
 =?utf-8?B?TEt0TlA2cTExSUFCZlA4SUdIRjNsZFFIOTBVcXlmcUNOTEZ1a3dlUDliNzRn?=
 =?utf-8?B?blRiNG1oSnNrcGpqOUtYMm5yZ3UvWXpHc0s3anE1SlBoY3N3ZjNWQUp0TUxh?=
 =?utf-8?B?TEhIZjd6ZmRya2xJSTArYmo5bHFCVlpMTVdZeGVWc29QREZmcnUxczdmT2th?=
 =?utf-8?B?L2ppZC9JenJKUzFxQ0E0UzY4OUxUeTFkT2hQZzFVZlMyekdhZWZKSzB2aUdo?=
 =?utf-8?B?NDRMSU9QUnBxOWFQcXB5OWVXL1IzY1RKS3pHN1JxR2ZJUlFiZGd6WHMvU2E2?=
 =?utf-8?B?d0FuZU1IZzU4WlN4SFVVSXBOSnB4VGw2d1JWSEhaMENvVm5kQ1BSdEN2Nk1i?=
 =?utf-8?B?dDFvN3lhR2FQb1UwZG90cCtmY3BxcEIvd0ttVzNRd01aZnJhemZYbXdaSElZ?=
 =?utf-8?B?MERlU29MWmxZZDYyWnJmNXI0UWxReFRiR3h6RDcxUy9WMWkvSkhFT3ZPaWtF?=
 =?utf-8?B?bzNGUW5LVmp4VFl2SVprOEFqdm9QR1NDVHlNQnVqUmFyeXFTZk15NkNxUnpS?=
 =?utf-8?B?Qi8vYWtwMjFUNnFDNnVDV1ViSW1OeHRYVWVORG5xRUFhaFdxelN3WWp6SVRh?=
 =?utf-8?B?bnUwWm0zYjVrcDYxalR0TmVKN2FpLzRKNDhock40YTFmVVVzd2Jkd1BWcnZI?=
 =?utf-8?B?V0NqUzZHMnNGaUhRZmozNjBxWnc0MFhweURxK1FSQmNqRVhKUVNwekNlTXh2?=
 =?utf-8?B?S1ArYmZrQ1pZemE5cmVMNTR0OVRnUjlFbFBUTjRsSXdrd0NXZ25VMDVDMzhw?=
 =?utf-8?B?c2xqUHhPSlVkUVdzQ0NlOEZvVHJ1djdEaTRjTG1LUVNpS0dzckhtUXdTYnps?=
 =?utf-8?B?OXJHQWZGR0x0Tm1TVGVkWThIYmM4bnU0bGgrYy9ZUmdIQ0xHQ0VsUy9XR3U5?=
 =?utf-8?B?Q0VGMm9oMjdOK2UzUVluQWdYcG9vdXkzajdsWnc0MHpIdjZ3V21EdFg4R3Qw?=
 =?utf-8?B?ZEFjN0FJajBxOUkzWjNBL3BCb21lYVJWUWh0ZDcydGs1SEVRU0xZaUNyczlT?=
 =?utf-8?B?RmtXZzVSOXlzMTdvcStFK1hVUmpnWkxCc3B0ZEcwT3NYcGdtYk5KODZ5aGhN?=
 =?utf-8?B?Rkk1Um4xOSt5OHNRQzZENTFudUg4QmVKSmRRaE9SY25xWTZNTXcybkhvKzZY?=
 =?utf-8?B?RG9sOGNZL0pBV2R2WDhST1NSK3d6WTJBUys1QVc1S01SdVdLWlZXSmY0bXda?=
 =?utf-8?B?RDRPcFpmeC9iSGg3YkQxNVg1ZUg0Mjd5VGp4KzgxdkZ4bVUvUytIQ3NVMXpi?=
 =?utf-8?B?SWs2NVpxSU5vMk5Ga0dzdnN6SFphaXlqRHVkRDZyQldmZHNTbHdMaVBibXV2?=
 =?utf-8?B?OFV2TE9pUEFxZ3VGZDRXV05MSUFxTlpySmx3Rm9OQ2pCRXBHVGQ1SEk5MGNs?=
 =?utf-8?Q?FqK5MR2EL86bD8OdOwgZDueTD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18eb2a1e-60d7-4d21-936c-08dd564b6374
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 09:53:14.9827 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cV5aIvNWYwyqvSoIf3ZZEl2RPc/u7L+kITGybF9Lc3uUxLcFogJwyDjBXi03bfxL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434
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



On 2/21/25 10:22, Venkatesh Yadav Abbarapu wrote:
> From: Prasad Kummari <prasad.kummari@amd.com>
> 
> Added extended support for retrieving the boot mode register
> via the firmware interface, which is preferred when U-Boot
> runs in EL2 and cannot directly access CRP registers via raw
> reads. Ideally, all secure registers should be accessed via
> xilinx_pm_request(). Introduced the secure zynqmp_pm_get_bootmode_reg()
> call, which uses xilinx_pm_request() to read the boot mode register.
> 
> When CONFIG_ZYNQMP_FIRMWARE is enabled, the secure
> zynqmp_pm_get_bootmode_reg() call is used; otherwise,
> direct raw reads are performed in the case of mini U-Boot.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> Signed-off-by: Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
> ---
>   board/xilinx/versal-net/board.c    |  7 ++++++-
>   board/xilinx/versal/board.c        |  7 ++++++-
>   drivers/firmware/firmware-zynqmp.c | 23 +++++++++++++++++++++++
>   include/zynqmp_firmware.h          |  4 ++++
>   4 files changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/board/xilinx/versal-net/board.c b/board/xilinx/versal-net/board.c
> index 4d5913cff1d..f8ac54e35a8 100644
> --- a/board/xilinx/versal-net/board.c
> +++ b/board/xilinx/versal-net/board.c
> @@ -21,6 +21,7 @@
>   #include <asm/arch/sys_proto.h>
>   #include <dm/device.h>
>   #include <dm/uclass.h>
> +#include <zynqmp_firmware.h>
>   #include "../common/board.h"
>   
>   #include <linux/bitfield.h>
> @@ -184,7 +185,11 @@ static u8 versal_net_get_bootmode(void)
>   	u8 bootmode;
>   	u32 reg = 0;
>   
> -	reg = readl(&crp_base->boot_mode_usr);
> +	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3) {
> +		reg = zynqmp_pm_get_bootmode_reg();
> +	} else {
> +		reg = readl(&crp_base->boot_mode_usr);
> +	}
>   
>   	if (reg >> BOOT_MODE_ALT_SHIFT)
>   		reg >>= BOOT_MODE_ALT_SHIFT;
> diff --git a/board/xilinx/versal/board.c b/board/xilinx/versal/board.c
> index b4483d00ad1..3046fd7e5f0 100644
> --- a/board/xilinx/versal/board.c
> +++ b/board/xilinx/versal/board.c
> @@ -26,6 +26,7 @@
>   #include <dm/device.h>
>   #include <dm/uclass.h>
>   #include <versalpl.h>
> +#include <zynqmp_firmware.h>
>   #include "../common/board.h"
>   
>   DECLARE_GLOBAL_DATA_PTR;
> @@ -42,7 +43,11 @@ static u8 versal_get_bootmode(void)
>   	u8 bootmode;
>   	u32 reg = 0;
>   
> -	reg = readl(&crp_base->boot_mode_usr);
> +	if (IS_ENABLED(CONFIG_ZYNQMP_FIRMWARE) && current_el() != 3) {
> +		reg = zynqmp_pm_get_bootmode_reg();
> +	} else {
> +		reg = readl(&crp_base->boot_mode_usr);
> +	}
>   
>   	if (reg >> BOOT_MODE_ALT_SHIFT)
>   		reg >>= BOOT_MODE_ALT_SHIFT;
> diff --git a/drivers/firmware/firmware-zynqmp.c b/drivers/firmware/firmware-zynqmp.c
> index 4b1b80d7abe..2adc132b4cc 100644
> --- a/drivers/firmware/firmware-zynqmp.c
> +++ b/drivers/firmware/firmware-zynqmp.c
> @@ -195,6 +195,29 @@ int zynqmp_pm_set_sd_config(u32 node, enum pm_sd_config_type config, u32 value)
>   	return ret;
>   }
>   
> +u32 zynqmp_pm_get_bootmode_reg(void)
> +{
> +	int ret;
> +	u32 ret_payload[PAYLOAD_ARG_CNT];
> +
> +	ret = zynqmp_pm_is_function_supported(PM_IOCTL, IOCTL_READ_REG);
> +	if (ret) {
> +		printf("%s: IOCTL_READ_REG is not supported failed with error code: %d\n"
> +		       , __func__, ret);
> +		return 0;
> +	}
> +
> +	ret = xilinx_pm_request(PM_IOCTL, CRP_BOOT_MODE_REG_NODE, IOCTL_READ_REG,
> +				CRP_BOOT_MODE_REG_OFFSET, 0, ret_payload);
> +	if (ret) {
> +		printf("%s: node 0x%x: get_bootmode 0x%x failed\n",
> +		       __func__, CRP_BOOT_MODE_REG_NODE, CRP_BOOT_MODE_REG_OFFSET);
> +		return 0;
> +	}
> +
> +	return ret_payload[1];
> +}
> +
>   int zynqmp_pm_feature(const u32 api_id)
>   {
>   	int ret;
> diff --git a/include/zynqmp_firmware.h b/include/zynqmp_firmware.h
> index 73198a6a6ea..e7275f72fac 100644
> --- a/include/zynqmp_firmware.h
> +++ b/include/zynqmp_firmware.h
> @@ -457,6 +457,7 @@ int zynqmp_pm_is_function_supported(const u32 api_id, const u32 id);
>   int zynqmp_mmio_read(const u32 address, u32 *value);
>   int zynqmp_mmio_write(const u32 address, const u32 mask, const u32 value);
>   int zynqmp_pm_feature(const u32 api_id);
> +u32 zynqmp_pm_get_bootmode_reg(void);
>   
>   /* Type of Config Object */
>   #define PM_CONFIG_OBJECT_TYPE_BASE	0x1U
> @@ -500,4 +501,7 @@ struct zynqmp_ipi_msg {
>   	u32 *buf;
>   };
>   
> +#define CRP_BOOT_MODE_REG_NODE		0x30000001
> +#define CRP_BOOT_MODE_REG_OFFSET	0x200
> +
>   #endif /* _ZYNQMP_FIRMWARE_H_ */

Applied.
M
