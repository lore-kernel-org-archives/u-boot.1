Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7067CC3600B
	for <u-boot@archiver.kernel.org>; Thu, 27 Mar 2025 09:12:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CFDDB81273;
	Thu, 27 Mar 2025 10:12:07 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="paZuWivZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7331581273; Thu, 27 Mar 2025 10:12:06 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2062d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2413::62d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B4817800C1
 for <u-boot@lists.denx.de>; Thu, 27 Mar 2025 10:12:03 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhRse+GEr61BPzZRM+WCY6+hvzGVnxPKXIoLMOgtILeTyloaMBAUKZuYbVXEctHGg1nvLfxzlhoejqaJTwa5aVs0RSaNa5AAN4JIoIA2M/rMUSelkklRgwv1GLfjTPCayvbuFXNwNav45y8U9PqybtkJKzNdys/0ubxzWNX3k2XrxrnuLcptmfXifw354KnhkRZ0ZATy8AtCwA4eaAMX408xw1wELTRpXUBKqC/44Wzutr4TvsjIJeuK81t8paQvn3lDauhbcg3O8mc7xKuYQkGNV4YF+DPU/CJWKMBPS0TzWxXH3A4dLqwoBDzSS7jQ0HkaMp7P4njXjmqvNNFPcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wSXPD2z68HiPE2cYl9ri5egmB5Tj91zvJleEwsuXTDs=;
 b=OPgr5L9ZarINnLiOTw2GYwsIzBP52oj/EAKxhY9wT0hvqqpm/1LUgAosSUP7iLnbXtZPiQHRmdGYHJ0AFWpkszEtbTtRYERtL2VliPyZQjlmsll6OUj6GC9PhrnZkyu7GyQdkTsW5+uLeu38EoB0ZgLeiVRmvD6x9qj2F4P8S0AXznUH0+UEirQsLYR94YErnZYas8EXkMC4Zo2rj8NG5spSag3IovGiUwnYmbWrU8UZ4w2BXNzJjJnLWEeXQwaT4cB5n45SgdcBfSbMCWWyV99iPS2uVgHKsRRomc6pa7f+4x96SYn7JG9TUTZKwS5FiRWNZ/rHZwdZaj268Yo+Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wSXPD2z68HiPE2cYl9ri5egmB5Tj91zvJleEwsuXTDs=;
 b=paZuWivZtNo/0UEdPYYvs5uiekmExLAPnRGIeDLb4L+NVdUcng1GWcq316vgkdjTAeMnei4GgmdUZZBWUzfLgS6skFYAtzGFXpnXi2qHgU0YoauHsexXOKxJwBidgfPGBTE3jPBdYxk/pgzwsRVKbs13IIuONf3eNg9zUqLgiXc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB5975.namprd12.prod.outlook.com (2603:10b6:510:1da::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Thu, 27 Mar
 2025 09:12:01 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.8534.040; Thu, 27 Mar 2025
 09:12:00 +0000
Message-ID: <7359fd8c-8235-4530-abae-b97c80cb3c79@amd.com>
Date: Thu, 27 Mar 2025 10:11:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: Use CONFIG_SPL_FS_LOAD_PAYLOAD_NAME in
 binman
To: Quentin Schulz <quentin.schulz@cherry.de>, u-boot@lists.denx.de,
 git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <022449eaa99ce8b96bd1c0af9bece2241180be6d.1742389724.git.michal.simek@amd.com>
 <421afd11-7a50-415d-b43b-9db62e416dd9@cherry.de>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <421afd11-7a50-415d-b43b-9db62e416dd9@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0163.namprd04.prod.outlook.com
 (2603:10b6:303:85::18) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB5975:EE_
X-MS-Office365-Filtering-Correlation-Id: f2f7c1f0-d9f4-4610-ece0-08dd6d0f6ecc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OWc0NWdhaVVESkMwd2x6M2x4cmFKT090THlNM01FcXg5VDVYdTZ6VnFKc2ZN?=
 =?utf-8?B?Tnp6WXRTM2JEYS9zQ2Z0dHNWRkFPMERzZEZPWkk1c2ZWdTAxM0QwRktaS2tq?=
 =?utf-8?B?WmRYUFgrZXhPTGd3b1F6S2JrZnlqWG9qS1I1Sk9iRm9veklIWGZtVGFpKzhn?=
 =?utf-8?B?L1VsNGdsVmlCTlRSSVBMc2NXSHdBaGhJc0xZM3NMUllYUEVGMm96ampvbjcx?=
 =?utf-8?B?Z2x3MDV5RWpQbTJVeE9QU3JBV0ZTbjQ4STdnK3VSbmxOOVVVU1VScGxZOVNz?=
 =?utf-8?B?MHpHWXREVnUxU0lDdG9qZTVuUGdMQ3pKRUFlT1RPaFV1ZjV4YnptOXhFVlVZ?=
 =?utf-8?B?TUZQdDNrSHpaaWFmN2treHVGcEgxKzVON24vOUhxSU55ZUh0RU9ZSEdYb3dj?=
 =?utf-8?B?c1BCcXRDS0MzV2M3M3ppVGx5dlhTV09RUGtMajBJTjh2aG1KQU9FUHcvNmx4?=
 =?utf-8?B?V3huYnAwbGQ1anJ1WnlHSitXc1piRWlodnVEMVR4eGRBbk9OS2I3NzlVRmFo?=
 =?utf-8?B?d3BUOU4zZE9saFlEREI2UElvNXpLalplNVhWUWNtaWhLMlhxN3M0MmJ4U29o?=
 =?utf-8?B?L0VLZkhPZkEwOEdvWVFNWGJUK3ZVOG5EZkNqTWRYYWlwdXFOcWQzMlNLa1JS?=
 =?utf-8?B?VEs4QjY5Y0ZyU2hzc09id3dPYzgwMzJXbjV5MnY3WExPNEhWUnZQQ2FKelZk?=
 =?utf-8?B?ZmxkR2phVDJNQ28weGZkTWN2UmI4RW5CSDI4WmhEWFYxWm44NTQyMUgwOVRm?=
 =?utf-8?B?eGkxRndKa0RzOHk3b3RNTFh2ZmZoVDJyNzk2Uitha055Smhyc09zQk9JSTZM?=
 =?utf-8?B?Ulk4Z1ZSQlFLNkpaa1ZTUGpIQ1hZeU9PckpMTHBHbDdJb0VYTTF2cURLekR1?=
 =?utf-8?B?alpaZ0Z1Wm9POUs1R2orUE05U3ZsZVoyd2svSFJWWElIbU5sNVhKMkxFNHpy?=
 =?utf-8?B?V0ZzZlU1emhDS0xDOEhNcXdIVi94VDFjeExOazNERXlDQTlTTkNqMjhlMDdp?=
 =?utf-8?B?UEpod0NSSGhMSHU4Y2NiMUdidVRPY2taN2dwbFEybC9HeE5nQk9ZYTlZK2ZK?=
 =?utf-8?B?UDNQNzRZcEFHK2VYYUVZTnRoT0p5Rm9VbGZJSTRhN280TU84Z2pxMUhDTmJX?=
 =?utf-8?B?dXNzNGdKbmNraW9oUStlTTFwcFl6QkpXS3dibWtySlgySzhTL21FWE80Ylcw?=
 =?utf-8?B?L1JJeEEvY0lvSklHZjJBeVZ2VWNHQ1RLUlB5RWFjU1o1M0RsM1BQN1Z5ditu?=
 =?utf-8?B?L01qUkI4VldEMUQ0Zzl0VG1EeS9XUk9NZUc5NDBVaGhKRXFKRS9lc3hOQ1hU?=
 =?utf-8?B?YzlTTGpXSTFYNVM4QmlxaEZoWHo3U2VQcmZIem9jMEJySXVRaGpJaytweHZj?=
 =?utf-8?B?eWoxYU43RVpMWktzV3h4Q2ppVWFoMVNNcEJWRExRYXZNTUJMNlcyS3E2WERP?=
 =?utf-8?B?NnNTV2oyd2w0d2lpWHhlNzB6QkQvK3dqVzZaNk1kc3JKN3dkMWsyVW5tcC8r?=
 =?utf-8?B?RUljaDR1bk9OZGtsWnA5WTV2L2hnYThCUjczTkJJbFZGWFZvenRDdDAvSklu?=
 =?utf-8?B?UzJKRzFkWTg3dEZobkh5clMrUi8ycTBXeGloT1hjSHB1THdHUXhkZ2xBRG9T?=
 =?utf-8?B?NklsWG5MeDlNSzZnKy95NUh6RkErTmhBZWhQZFV4aTNqblpQaHkvZzh3dUVB?=
 =?utf-8?B?am9od0Q2Yi9MclVEczJWc0lSdlB6YkxIaWxITHpxOGZTaExDVHZyMnV5ZzNk?=
 =?utf-8?B?bHBHNzFKblNRdTM3WEJrRDVHNE14VzNlYkpqQ2Z6VElTc0dzWlVnQ1VOamZJ?=
 =?utf-8?B?V0wrTUV6VFlDSjhNSDFXTjJDc1pFbWxaMnNsRW5xTzdTdWFHcmhqNXg5dngw?=
 =?utf-8?B?S3BMUmI2bDV1VWdIL0JGbkowZ2JUZ01VdEZBd3lYdVdBcGcxdnAwVkFFTGVX?=
 =?utf-8?Q?s8Y6iES/6VY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bWN0Y1ZVUjBhMVNTZWVrT0Q4YnEvR1JQQk9yWmdlMm1TY20zN0prdUw4RGdP?=
 =?utf-8?B?MFY0clV3dHlNaFBWcFVGaWxkZTBsQzErODlQWWIvdXRzdEs4V0MrWHEydHNr?=
 =?utf-8?B?am9OeEdkRzdtb2l3U3d4VXFLY3pKcTVMUnhJdHhPYmNKY0ozU2w3THBKd2hs?=
 =?utf-8?B?NngxMzBUUVE3UWl4aVRMTnBrdlFmaE4rRGF3SEtPemc0aUtEUm14UDVYRWZx?=
 =?utf-8?B?UityYmlraHI3NTZNNFR3LzFUWHE5NHhoZHJMNVd4UlM3V1JYelVSSlNRcVNm?=
 =?utf-8?B?VEl5bnBSc3gwZ0lNM0N1azdBNzAyNUUyN0ZncHdFYy9qUk55MTZtS0lXMTUr?=
 =?utf-8?B?WEpaazJMaC83WlRYZTB4cm5sKzU5Q3d2VUZTV0NXK0NORDk1TWZFUG1EdGdp?=
 =?utf-8?B?WW9JLzBmdUFXWGpXOVVOU1M2SjNvWHlQUUVvcHFHd1ZJbFNtZW9ucVhsRWpE?=
 =?utf-8?B?WVk4K0lnaFFESXRFTWtkQnowUjdWS2tMb3d4c1VsQjNrR3orSGhqSnVZcHNp?=
 =?utf-8?B?UmZJdllZTEpjM2x0MUExUXZWcU8rK05ESUl2Yi90cE1HTnhPa2htcy9KNzdI?=
 =?utf-8?B?c3pFQ1dzTEFBMHBrbFIyNzlaUytlWmlDcGFoV0JrcDdCTmM3OWhyY2pqYkhD?=
 =?utf-8?B?dnFWeEpENVFla2lzM1ZpT2V1a2pxeVQwTDN4U1NiL1hsMFc0ZEtnRFUvYVVv?=
 =?utf-8?B?QXV0OXlJUFExdzZVRXEyWE55QVhZb24wY1p0TkdIZ0o3elRjRVBLT3RCOUFN?=
 =?utf-8?B?TTduWjd4aXh4OUtDb00rWUxiNGRkQUpVcTFXdUt3bm5OU0owMVQxVFVDSFRq?=
 =?utf-8?B?QkhsZEVnUzd0KzV3QWNrYTBrTFRjV3NSMVZZN3pBWENPZTBoQkxiNHVOTEZX?=
 =?utf-8?B?UkMvOW5EN3A1YkFDU0RxTXVVZEwvLzB5UHYyd2lzc2laWGRzSWZ5cVVua1Z3?=
 =?utf-8?B?L1lvUEFtQm1ueW5qODJ2azVqYVBTMFFMcVNJYjNOcTdYNFJqVWxoU2N6SUU3?=
 =?utf-8?B?di9jU2RQMlBBdUpPTWRVWlllK2tNOXhvblByeXR3bzVCbEQrNFI3VnFWMXdH?=
 =?utf-8?B?dmJ5YzlZMVFJLzVuejJMMzN3N1hPeEl6OTJvcTZCTlBQUmEra1NxZ2kxalYw?=
 =?utf-8?B?VXJJWHNDZ1lhT2pZOUFiQmFPRmMyR0QvMElXSGRHaFpCV2NXZUxVK3I4RjlI?=
 =?utf-8?B?VURkQ3JZZTl2NS9xaFRMQWwxUWdDVzRxRDlMdzNYM1NyT3BoU1FKbk9CK0Nx?=
 =?utf-8?B?VEZOaEE2TWFzTjBSQWQ4R3hpRElJMEhOMmRRY1p2dlA2d3p1SEt5VXRTTU1I?=
 =?utf-8?B?ekhLaVRDdzhJRW5FTUF4bzVkZWlkWFNIRVNQaTdUVWlwcEpOYTRxeldjcytG?=
 =?utf-8?B?Q2ZMYit1UGQ2ZVg0UnJOQXF1eHZLNS8zMkJ5NUpHdTVRNXpFS0dLNnJYUkYw?=
 =?utf-8?B?Z0Q1SUFXMVJwcTdQSUlzOVo2QW9DOHVneE5SU2xkaXhWcUhPTGU4c3JNNDZT?=
 =?utf-8?B?YTk5NXRzbjQvU2JqUzhNQytXbDBycTh3WFZuNWMrMVlNcmpnUDJhendSMDNZ?=
 =?utf-8?B?NkVSMk5UaG94NThPVnJhQjh6ejhtVzVmL3NmZmE0WTM4OG0vTStSZ1dJNWEy?=
 =?utf-8?B?YWJYVEJWcnAvTVA5VityWjZaTTlldDZ2blZxWStmSlU3Nk91WlZscVpnMk9t?=
 =?utf-8?B?aUxBdjJDV3Jpek5jZXhQWmI1QkRSRUhKV2poblBLTW4yQXA5cGNwbDBvaHBW?=
 =?utf-8?B?SGtNWW02YW1VR29Wa2ZWMlIrNjFvc1FpL3ljc3lkS2g0WExOb0Qxa3JEN3dS?=
 =?utf-8?B?bzJyY1NPbWd3OXpmcGwwSzgxQU5BMnRlM2pOTk1WSkJ4Mmp2L012WUxJUTBE?=
 =?utf-8?B?L2UvbHNWdFpYVEVGYUJhb3VJZXl6cTRMNU5keENYcmVkeHQwelNaSUR6Wm1X?=
 =?utf-8?B?MlRGeUlxMU9HZzVqZWpuMzc2eE5KcStGei84aExPc0hqZ09zWjBGOFphT2hu?=
 =?utf-8?B?ZnY3OEdSUjVNNTZWMjBERTBGMlNZUDFGRTdnQ3R5MC9VS1Z3Z1ZSUVpBeGp6?=
 =?utf-8?B?NHRwaWhnQ3dJMVRjVnBLbEZKRDBzL01HWncxQXhOWit1R1V3Vzkvb09uMDUy?=
 =?utf-8?Q?QmfWxunB0NxOlT3tRlvAxbJv/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2f7c1f0-d9f4-4610-ece0-08dd6d0f6ecc
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 09:12:00.8536 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zid1AZeqri2WbiuFRdENKA6nQk91raPnOI2lMrkiJIRERXo6FaHqVzFe9Q5i1BPF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5975
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

Hi,

On 3/25/25 10:48, Quentin Schulz wrote:
> Hi Michal,
> 
> On 3/19/25 2:08 PM, Michal Simek wrote:
>> u-boot.itb name is coming via CONFIG_SPL_FS_LOAD_PAYLOAD_NAME and it's
> 
> They are unrelated as far as I can tell?
> 
> Isn't CONFIG_SPL_FS_LOAD_PAYLOAD_NAME the name of the U-Boot FIT that the SPL is 
> going to load from some filesystem?

yes.

> 
> u-boot.itb in the binman nodes below is the name of the generated U-Boot FIT on 
> your disk.
> 
> Your disk FS != SPL FS, no?
> 
> I can get behind wanting the same name for the file on both FS, but the issue I 
> have is the additional CONFIG_SPL_FS_LOAD_PAYLOAD_NAME #ifdef will prevent the 
> generation of this U-Boot FIT image if the symbol isn't defined anymore (which 
> is possible if SPL has no support for FS (ext4, fat, squashfs, semihosting)). U- 
> Boot likely work just fine by trying to load u-boot.itb from another source no? 
> (No experience with AMD, typically only Aarch64 for me, where u-boot.itb is 
> usually loaded from a specific offset in the storage medium, outside of any FS).
> 
> Basically, do we really need to NOT build U-Boot FIT if SPL_FS_LOAD_PAYLOAD_NAME 
> is not defined?

There are couple of things here. AMD/Xilinx evaluation boards are capable to 
boot from multiple devices.

On ZynqMP we have one official supported flow which is FSBL or alternative SPL.

In FSBL boot mode FIT image is not handled and boot image contains just 
u-boot.elf and that's it and no matter which boot mode you use.

In SPL boot mode boot image (boot.bin) has only SPL and that's it. Then FIT 
image should be created to be able to start TF-A, U-Boot, etc.

Then based on boot device there are in general two options which are raw mode 
(for example SPI) and then filesystem one (SD or EMMC).

In RAW mode qspi image is created (maybe we can rename it because it can be also 
used for NAND for example) and image is expected at certain offset and name 
obviously doesn't matter.

But in filesystem mode names matter and image should match 
CONFIG_SPL_FS_LOAD_PAYLOAD_NAME because that's the filename which SPL is looking 
for that's why these has to match.

And if I go back when FSBL is used there is no reason to generate raw boot image 
as qspi.bin or fit image as u-boot.itb because all binaries are the part of 
boot.bin already.

Please let me know if you have any other question.

Thanks,
Michal

