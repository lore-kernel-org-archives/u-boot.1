Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0813CA0EF5
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 08:57:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F093182BF6;
	Tue, 19 Aug 2025 10:57:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RmPIGwyu";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19D6982CEA; Tue, 19 Aug 2025 10:57:40 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20626.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2412::626])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BF13780FA1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 10:57:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AIp3R/CgjyBnl22MWtMju3bFin3Y8GebYDjuolxhr3HM4fMs7KcF/qdf6GNvzAZhn6wRYo89Wb2wk5QCOEVfpkwuOxnTJyzOCJ9+Xb3X8YKitVbx1ZiKyb76aOnCPtQA6ggoUvoyPBn2ORfe2S7aWGGnJh/XmKvlDEDHwCFL/O8cz7nfjO5NR9jCyxy0LCKM9pNhUgJYlwJZNSA2R2mIr6znS4bU2Qa4BCkAgrNqi5E2REMbt3dEmOUfVc2ce5Pn/71vY332e/OoBbjfF4hineWJ9tg6vn9GFrdyouprQzcA9F5aOPX8aliTgTkJf+Ttq/nJRc24e4Zi+0UDWHsh1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aaGRKDNOpwk3fqPJHFAG9AR4nT4/bBZ2u+z8eBiA39w=;
 b=ZSHl2LZxzT6Q9JOEaHOy43riU9U7ZUPqyPlngBqZyNQDtgU1C/HTD9spok9v6Cf66/JHRenU1UN5CpS1Hje9gvg2/QAfZ8fUWdGGb6zLm7Ahb7GbmBDUtTjE7PPosNNcj3TkeFc9TUBG6vhrnKspPe388bIxxHe/tSXnRZgh+GSjtXS5kLx0dYfHMMHi8Pm/UcAKENhjrWOksOGYCCETmQ3QKWHChbKNw2VctfAMrzzri11BTr1wzcgiNarnok6g9WnlihPLTGkL60RP1KRiNYdPS0xVnll7SY6jgsWmY2mIefmzga9MIOwdwu/daITkaDWLT5kRkkiw1M7ZByje9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aaGRKDNOpwk3fqPJHFAG9AR4nT4/bBZ2u+z8eBiA39w=;
 b=RmPIGwyuPMKilNF0Zl2BWPygh8Sj+gOCQcfdRqjR9I2vX7KXHluutmDszpwlxB+U+0e01yI7JWVZqTI+/EW0ivcbrfMwrU1cBVknwFgMc6TeP2ifRifHh3+J3OQsBy0USDdMbShHmGaa/bBNslB9jGABulF43sFkj7DDCbCD0qc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Tue, 19 Aug
 2025 08:57:33 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%4]) with mapi id 15.20.9031.023; Tue, 19 Aug 2025
 08:57:32 +0000
Message-ID: <a838f66d-d209-4339-af69-87ccb23da54d@amd.com>
Date: Tue, 19 Aug 2025 10:57:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: Smatch report for Cadence PWM
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: Tom Rini <trini@konsulko.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
References: <f7b87c8d-63c1-461a-857c-d8e2cdc0c630@linaro.org>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <f7b87c8d-63c1-461a-857c-d8e2cdc0c630@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::35) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 259b4faf-a6c1-4b66-dde2-08dddefe6f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M0Fha1g0b1lWMU0wVm1MNUV6R3h4L3FOYk0xVzNLdjQ5a09SYUNxVTlrZ0Vj?=
 =?utf-8?B?QkQzaXpMQndRM0hRRlZPbm5UUzI2MW50RlNadVFhT1VQODlCU21YUFpsNWNl?=
 =?utf-8?B?d0dicjQxdkpzTTRMOGxyUThqUmRWaWNDZWxWVDdHcHRmNXFCWERuUzNBdC9r?=
 =?utf-8?B?KzZzSGhUMXRFb1A3U205WjRhVlRhcTVLcWZUbjVkN0VNa29UTGRLYldQMi9J?=
 =?utf-8?B?cjZEakthNjJQM1VjdGlrTzVKSy9mbHJKYyt5c2Urc3RWSllWdXV0V0RLeXZ6?=
 =?utf-8?B?S052cndNTzRRS1I5QnJQKy9LU2tsRXhqYmFiSUIybFlQQ3FJOWhqMUNKelBi?=
 =?utf-8?B?VzZMeHpnQUQ2ZWw5aXQxSVBHK05UMlRpaml5VkxLa2QyU2tCajVGMVp5UGNF?=
 =?utf-8?B?SUQvMjNqRUgzWXpEdVN6VXNKcFVybXVsRGRrSitoKzNHR240cDlCVHJlTmcr?=
 =?utf-8?B?R0EzRU1ibFNCOVhiMjhJMkJWcW5nNUZYU1lzSytzYXJHQ1Y2Rm1aMGJkN1dr?=
 =?utf-8?B?WUwwM0prZEIwa1Z6UlVEY242YW8xaVF2cU9xK3VhZEdjSW1LTmoxa0JkS0FQ?=
 =?utf-8?B?NlV5eFNMQ2wzQ1Z3VGgzVldhWG43dWlSckNZelh2TmkrclBvbGdvNHY4VU1a?=
 =?utf-8?B?K2ZIUHU1bTZWSlBBSElUN0hBb0dNYm9oMDlRb2NIajBidFRWcXRRUjd1SlZs?=
 =?utf-8?B?MTZGNUhDN0dyZGl3OUJIK284c1ZMVmJXZUx2UnBvbExZOFJEeHR0RHBGSkgy?=
 =?utf-8?B?Z0gzMzRpdFpncVYrM054YVF0ckYvaWFoVDZwbG53NXJYdzJtSHcwS2MxRzFI?=
 =?utf-8?B?a1RoU0dNT3NLcEJpb3VOaE5yZFNDbDNha0lJQmluWlNGOXZlbWQybnpjaVFz?=
 =?utf-8?B?endDTDNCR2VkQXNJZDVhNjRZcEdKdXVuYUkzQWxJbCtTZGVUL2ZXcjZVTmNm?=
 =?utf-8?B?ZFdydG9ob0pVZlVlSmhHTjJEUFZ0aUM0RFV5WWQvZmhSQUZndkh0d0UrRUtR?=
 =?utf-8?B?N09qY1ZaVmtNK205UFhPTHdGUVZDOUlOUVQwd3lud0w4M1hPUjFZMFA4bkZr?=
 =?utf-8?B?dW82YTRaaE03SW5qK2phVTNQbHdlWm9xM1RlUEw1bW5GdGJyaDZqRHdkRW9z?=
 =?utf-8?B?TnBPVnlVV1dCSFV1bDhBa0hTa0hwbXdWTC80TVAxYlhvbFM4TjJKRnVCOUxU?=
 =?utf-8?B?azlkb3B5VU0rbXYwTEpYTkhFd3QxNlNhZEsvcW5ZYnlvV3NnME81dzlUNFVT?=
 =?utf-8?B?UXZFeDFqM2NlcGQrb0dXQ1FDRGpQSWI3aEZLaWw5Sy8yWERSRjc1aXFDNjVX?=
 =?utf-8?B?ZWNHWlBoeFVnUTFBc1c1REtPVTBQU1BYZUZ1TlJyUGdQdzllVHVjdHpHeXg3?=
 =?utf-8?B?VnZpWlNRVVdnNFQ5RXFnUFRrb1JuVGlNVEV0YzArMmlycUY4VnlwMndEUi90?=
 =?utf-8?B?MkdpK3ZQVmU2REJzVFFIdjBQM2lLNXF3MUI1RjZaQW9IRERaUUx1NEdRbzRX?=
 =?utf-8?B?RUxtZHUzMmM4blc0RFljdDlYWkQzZjVVUEJDOEUrQW5LM0pRc1V1b3JwS2lQ?=
 =?utf-8?B?SEwxdFpwSVo1dXVRbGxvTjlZb1BTU2xRWVR4aDJZeE1YL3ZKK1NXa1UxaGwx?=
 =?utf-8?B?dUlSOW94VlhUd2Y2QjJPeE45L2hWRHBRalo5K2tMa2c3RmMvb0xZSXQ0OURl?=
 =?utf-8?B?T1dUMktEV0VVMGhXOWFtcWMzRnVxMERwR09LbmVhRVYwaE1UTUtVQWhXRHFz?=
 =?utf-8?B?Q1JLMU1lOTh1R1lTdzZhcDMwQ3pHbFlGNitVMnl5QUhadjNrelB1Z3NKK2FW?=
 =?utf-8?B?ZjBhSlFDRFdKYzlMcjlxNUZaNXZjazBMT21Mb3hnU2ZVRWUxRmtQWjB1UHRM?=
 =?utf-8?B?ZkxjMFFGaXRzNkxISHArY2NpRVN1L1dEY0ZqRzMvcTVrSVRldVlYcVBkaEhm?=
 =?utf-8?Q?kiUieo7SJ2U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VXlVeUFqeDJIMnVocnAzc1RvS3J2T1NNYkh1Y1hUZFNVR2F2MnZTaEhJcXdr?=
 =?utf-8?B?QXZYbEZZb043RklVWGx0Uk91YjlUaDBsRVR2U2NRdythek85Um1CZ1dQbWE1?=
 =?utf-8?B?NW0yVS9JMWpNeldjMG5JZFpYVU5qTmc5MXVVQnpWVUpHUFRiRldwZFdCRHRN?=
 =?utf-8?B?L3pFTU1Uc3RBZTYrVE1hLzhERGVPc05kU2g5UXFWeENlOWdSbWtBT3FFNG9j?=
 =?utf-8?B?dmhRa3ZpdDZqTjgyVmJ0VXdNcWdJUlZqbS9HYTR4clJReXBEVXAyYkUyckVz?=
 =?utf-8?B?QlZmUUFPZmZwcUJiekswNC8vemVGZG5YTWRCMTc5TGlnSHV2ZDUxNE1nQUk2?=
 =?utf-8?B?WWVqWkFORktRVUJaS3RScTVwVFJ5Ukt4TzNJMmdnVGROZWtvL0xzdHcxT0tC?=
 =?utf-8?B?VGZ2Zk5RUGJlNFFnMC9BS21QRzJlVWk4ZnYvM0ExTTRWYTRvM04vRlBMY3k1?=
 =?utf-8?B?WW81WEtQSVZOU3QwdjJBTnR1TFFpSEtmVURZemYvUHNDZ0dackZPeFoxL2xN?=
 =?utf-8?B?K28xYmRmazIzbFplem5IcVlIK084SC9MMW43RFUydjBUNmhNRTdidXZ2cmlB?=
 =?utf-8?B?bkdNQWRZRzBNdW51WTRkNmNob3M2YzZ4VGp2ekxPbDhTaGRsN2FPWjZPZXZm?=
 =?utf-8?B?ejl1cGxYVXdXdkxZT1ZqcmN3bWxEcXdWUzhTemJocFJWVEllcVVobW1YZkpD?=
 =?utf-8?B?WEg2YWIzaFgveUdhQzBSVUVpSytqSjJiZFc2YTFhZDV1YWRaQ1N3eWNsY25V?=
 =?utf-8?B?Rm8xVVZZN2RjZW96VmQ3dUFhV1NRb3JqRXBCR2lYVXVLT3JwVm8yRlRkeEx6?=
 =?utf-8?B?RzRKVUtXZXVnUjdrN3JPWDZyZjdzTnZGYzRqbVgyZE0vWlZvZzY3dUpkUlo3?=
 =?utf-8?B?VngwTUZKWlZlUWJjTzl2T1Z4Tzh6WXBuMzdUeE9ndzhxYld1K3F3L1FTNW1P?=
 =?utf-8?B?bTBrd2NyQ1lQbU14c0wxV0gwam5Fc3NKK1lPV1p6TXh3K0hydVBxbFpScEFj?=
 =?utf-8?B?dDJCd1IvU0FqV1E3bHJESG5HWVBmRldOallvdzFoL3lmWHB4UnkzN2pBYzh4?=
 =?utf-8?B?L3FjTG0xRGFxZittS2JNWk42TFpvNzdGODVibHJvZlA1REFUcjVKNU5jOGV0?=
 =?utf-8?B?ZnZ1TlJOUUpvU3NoZzZRRXZhTGRuQ0VlQ3gvNDJGVG9sTDROdlRsMnpFdnRC?=
 =?utf-8?B?bXRtdnkydlgzcWpQQldZbjBBaHdyS2ZxWHRBOHdCQVAyUUdIYnI1R0cxYVFK?=
 =?utf-8?B?NHBMN21QenNCZEJzeFV5aVpqQTUrZ0pvNFNLN2sxVC83M3B3ZHlHUmR2a3dV?=
 =?utf-8?B?MzVLajF2L0tIYTRXZFZwZGVHa0RVeWZaRmt6dWZldDcyTzBSZXZ5SVBlakM3?=
 =?utf-8?B?ZFJwTjM0WUUzdEdaeXpPd2lCYTdjYklGOHpZd01SUzBNeTMwREVmb1pYSEtz?=
 =?utf-8?B?ekNMaHJJRTZCdzdKTDhDSjk4MXVjRVRXb0dBS2NhZXRYbTFNem8rOEJIOWZ2?=
 =?utf-8?B?Uk14RW1xNmNIQ3Noa0NBalZlMlIzczRzNTBLT0ZuU2NUaFhmemgxSkRlUG51?=
 =?utf-8?B?eG14LzJSR3FCOW9XZmdZY2pWeTlraFBYL2RPVXdYdGxTMUM0WUU1RXdLRGdQ?=
 =?utf-8?B?aGVBVmVkUmdOS0grN3FRVnRmRFoyRm1CZjM0RFFYc1ZNSVlGWlFOMDJ5YlZW?=
 =?utf-8?B?RWNrZGg2V2dCNXFjZVYxMnVzQldOaEQ3S1JvdWZSYituc2UyNXRwTi9scjlx?=
 =?utf-8?B?eXpqeXV3Ujd6SFRzQjQ5UzVFRWlxdVFzUE5vVkFSc1JBNlp0czlpcCs3d25G?=
 =?utf-8?B?UXhuVjdBazZVbExFWDdaZ2ljTGZndTZsdk1lRjN1UjAwQUlEU3dJNjcyUXd2?=
 =?utf-8?B?SEdodnN2ZXM4a0ZiRit4c2d6K2p3MTNCbERBQ0JnZ0s3c1pvUTN6c2VucWZR?=
 =?utf-8?B?TGdPNVZ0T0NIQlcyNy84SUNiWk0zd1lhWHRBMDFoeGJzRWdTSDh2T3lOZ2pk?=
 =?utf-8?B?a0p3VEJrVEprb2FRd0dzQ25lSWxRdHY3TTdaVTBnb3AzLzdsQ3hCVjVFTmE5?=
 =?utf-8?B?M1pSc3NwYmVXU0ZLZ0UyVXZncnB6a3ZIUEJUUU9iUE4vWDNjRUFGcm5XKzg5?=
 =?utf-8?Q?C9Tkw2CQ2pq8Qq7hWRAdIFNbs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259b4faf-a6c1-4b66-dde2-08dddefe6f4e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 08:57:32.8595 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ldQd9CMzqmoAE0vkz2HO1WtN++WgVqzZdjAwQI8G9O6Axvqh8gkobOZ62MP9WAJh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198
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

Hi Andrew,

On 8/8/25 11:16, Andrew Goodbody wrote:
> I have the following Smatch report.
> 
> drivers/pwm/pwm-cadence-ttc.c:73 cadence_ttc_pwm_set_invert() error: buffer 
> overflow 'priv->invert' 2 <= 2
> drivers/pwm/pwm-cadence-ttc.c:138 cadence_ttc_pwm_set_config() error: buffer 
> overflow 'priv->invert' 2 <= 2
> 
> Indeed yes, the code allows a maximum index of 2 into an array with 2 elements, 
> so that is out of bounds. My question is which is wrong? Should the array have 3 
> elements or should the index be limited to 1, or is the value being checked 1 
> based?

There are maximum 3 PWMs.

I think the best way to fix would be to create macro with number 3 and use it in 
array and in boundary check too.

Thanks,
Michal

