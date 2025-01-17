Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0901C02183
	for <u-boot@archiver.kernel.org>; Fri, 17 Jan 2025 01:43:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3E5688069D;
	Fri, 17 Jan 2025 02:43:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="rSXfnTLw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1264806FB; Fri, 17 Jan 2025 02:43:27 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20728.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::728])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C51C280312
 for <u-boot@lists.denx.de>; Fri, 17 Jan 2025 02:43:25 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=W.Egorov@phytec.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZs1BEgRBYwsC6shAWiVRO0FYFb2sAVIungzW0+KLNVmScPGqvmlF38dubGXRsrsYGVJRkRmkJpwxk2iXHXszqje9JV12RkOkwuKfhtWNddRVX59fGOmxrvqNB4L2f06ysEt2WDlMd342Y2sbU9gGJXFyyCNSnh3FSo4l8JboKQjA0gVYz150xvu0bl1ZAuIaTkHjfHdDigfxQdlK93okQXtkvdFYF7uz3In3XH0qzJITXZveLTKKr8aJUz5C4cWwcPguU+50Eiw5AqjMT3qb7fHwcplXAeKW84SAuDFJqutwWE+er5dJRabmBXUHW9e673pSBWGdP+blTsYE8CRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SM79MtzmDnX0MlPQEKBpIJ5dsLI8u1231SysqTh/gPg=;
 b=cPO8uzqvbrmJsxQVlV8GKC7LapOMZ8um++Pv+vLAFWAdA3nS3PMXHU4lpFQTft4s4Vm2MZwTjqhJP3EsBRAJIzHg7yuzkLxVkTMGf6l/Ui6MK78K+8hMXDXZWkghonPgpy0I7GQqKTmZMxeTOAMSB8RMXHIFH5G+b4p/QmjlGC0Gy/6N9gv6fbw74wXqc8ZKy0p8LYxscNFCRb5uwcWMZm7Fx9YS2zgrEL35pd/7+AF5MW4V3fvcwi50MkUfJlZD+16fclIMXEwco8jmZ78DSl5x4Fj2fbjRcTT+mRhGPmMM50QVuLOxOyZRH4mfSwlTFQ8zoEOhx4onEjpW+la3vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.de; dmarc=pass action=none header.from=phytec.de;
 dkim=pass header.d=phytec.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SM79MtzmDnX0MlPQEKBpIJ5dsLI8u1231SysqTh/gPg=;
 b=rSXfnTLwy2xIR4RFhJcroQeT221pSCOSc8RW3f20WN4xILIWPZDdZwqwlRpFZkvIqFGDA5ke31WD834BhD0flr5Bhj//kejXXMWId81lJTmotD8u7IZXYBvgWVMP6yd69aHAUkIvqEyc2ZhXa9olCzh+FhVeJ/03/gPRvwOJrHuFJTJIOKQwvn0nS1OUb7C+atbjYULj+y0n7KvLo+XR2sAutf1nvcLSd53bj80iRQxhH46wG7AyOQxtBMS0Bhvf7v6keUO4wT9hqHLdqimPMZ9i+OrBevOL3WYkjqrJsn5SvwNHODSW/vRLYBuSQOu8u5iabVeUBkp5d5gxXiZVig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.de;
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:4b3::21)
 by GV1P195MB1809.EURP195.PROD.OUTLOOK.COM (2603:10a6:150:5c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Fri, 17 Jan
 2025 01:43:24 +0000
Received: from AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a]) by AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 ([fe80::369c:a760:5bf9:8d4a%6]) with mapi id 15.20.8356.014; Fri, 17 Jan 2025
 01:43:24 +0000
Message-ID: <05de0dd0-0026-4cc1-98b8-f85400ec039d@phytec.de>
Date: Fri, 17 Jan 2025 08:43:18 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] configs: phycore_am64x_a53_defconfig: Fix environment
To: Daniel Schultz <d.schultz@phytec.de>, trini@konsulko.com,
 u-boot@lists.denx.de
Cc: d-gole@ti.com, n-francis@ti.com, mkorpershoek@baylibre.com,
 upstream@lists.phytec.de
References: <20250116112932.1983801-1-d.schultz@phytec.de>
 <20250116112932.1983801-4-d.schultz@phytec.de>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <20250116112932.1983801-4-d.schultz@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KL1PR02CA0003.apcprd02.prod.outlook.com
 (2603:1096:820:c::8) To AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:4b3::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4P195MB1456:EE_|GV1P195MB1809:EE_
X-MS-Office365-Filtering-Correlation-Id: 130fa2b4-8a28-41ec-25a5-08dd369854c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NTQxTEdBckRyQ25DelpxcTY5OFY1M1pkeWVhL01VRjdLM1NIVVFERUZ0ckpU?=
 =?utf-8?B?ZE5XZzY2ZzYzUTUyQkF2eUJ5aUFnTWlLZTh5V0Ezd2pPa0ZMUFArbndoTkIw?=
 =?utf-8?B?bkRYdnRwVmI4eUo0WmN2a2FNZ3JWYXBNUTZRQWp3MFU4TXo3b28raWF3NFFT?=
 =?utf-8?B?SmlvcWYzaDlDdFdtNitJUFlOcWtiTnZ3RE1MRjZJVWtoRXlvYlQ5dmxiTVh1?=
 =?utf-8?B?VzdVaFl5WHYxdXdOeTV5SWMvRm9pam1VbGJwVDZ0d2dqTWs3ZW1RaXB5UG5W?=
 =?utf-8?B?ZzJhZytQTzRZM21kL0UzMEd4ZlNBUDFOSFVuSXF6dmQ0V0pYcGI2cVRWUlNv?=
 =?utf-8?B?L08vUWt2M2NNbEQzQ0I2UkhRQTY5c1cvY3B5NFM3ODNqWURabEozVmZlSklt?=
 =?utf-8?B?amhXNW9Ob2VqTVY3WWV5OWE5dFByRUpRMGhHSFVtSHhkYW1HNW5LRGlsTWgv?=
 =?utf-8?B?amYrRHBoS3A0aUlxREZDbW5RencrM1JWNnc5RzFpVDIxSXRMNkpJYmZFYjVm?=
 =?utf-8?B?bzYvSlVJTmYzSmg4eU5aci9DMkMyclBDS3g2OThiV256QllWbzl2NjdmcVJk?=
 =?utf-8?B?dTVBaUUrcWFvSU9FQ2gzZk9KRTdMenFrdEtjNWowcGxxWnBvTG9ua3U0dUEx?=
 =?utf-8?B?WG9FWkNhdG9ibXloQzRldCt2MjQ2WE10Qjc1V0FCNVg1dzRISXhLNFplN24v?=
 =?utf-8?B?MFNLOWtVU1hsa1JnUFkzNUhsMlJyeW1tK2VUTDJsRUIrMmFsWGo5a0c4MXQ5?=
 =?utf-8?B?R1lBdVYvWGhpM2E0NGkrcW9BQWlmcG51cFpFZlRpbXFUSXZBdTJlYUpVL00y?=
 =?utf-8?B?SmJidm5PeUU5Wnp2clYrSUhVV3BpMVd1OG1NMUZYaXA1bU1jclAveDZ4QnRa?=
 =?utf-8?B?WkEvalFzV09rcmJnQlgzejFQVXN0WmFTUklrSXd3Zy83K1BGcmtsWFJjMzE0?=
 =?utf-8?B?WUFGSVBIckplNDdkMDJzY29XZ1o1bGd5MlNMak55SWxFdWtSTG5LWkE4cjFp?=
 =?utf-8?B?UkdDK3pGYzFrL0MrUW1Vb2VWR1ZibTMxVmtUY01YUk5yVmdIZlQyc25VWFdH?=
 =?utf-8?B?b2RMMUhmdHIwMTFRNXJ4dEVUdlFWMGNFM1pQdlJnUXRPOVQrQzZtQUQ1Z2Vl?=
 =?utf-8?B?aGl0NE03N2ltOGRaWGlhTVkyTDlhSlFpcTc0MDFNSEhZL2xmZ2RUMlRVK2FJ?=
 =?utf-8?B?dzkxbis5NWxON3U4RURlWU5sZFkrTWxkTDE1anRzQ3RHaHZZaCtOMXBYY1du?=
 =?utf-8?B?TXB5Q2xZQitpWTBPcjJnN05KQzNxUHczbmFaQ3MxNlFNN1FqbUI4SFVvT01Z?=
 =?utf-8?B?b2puSmpaVGpDUWVaNFlFeHNEbGhSeE1yVzR4QWZ2U0tKRm8vbkNZU0VETG9O?=
 =?utf-8?B?akdQdjd1YlZ0K3FJNGhLVDNieUtsdms2VTNjQ3Ava0lUKzQ5ZkRvejFpdWdV?=
 =?utf-8?B?YnErdGIrSktzY2VxM1p6ZTl5M0ZHS1JjUEVJYXNKQlU3K0FPN2NNby9aejIr?=
 =?utf-8?B?b2t1ODJDWWdZamIySllaRk9HL2MrM2xsQVVaY0szYTlScDZ0OUdMM2tuM2dS?=
 =?utf-8?B?MUFCU0RrWjVHdUw1azhCQ3M5YnZTdndOejJXSUtvT3hmejNGZ3RITGszd1Bn?=
 =?utf-8?B?Vk1tWEhCREhlUHNpTEg1UDV5Q0wvTUhJUXRYVVR4WGxPY2tJSjJncnRjckFN?=
 =?utf-8?B?Mnc1VUNXR3gxQmlRY21xZmNXM0dGOTlQdGdJM0J6MTdWeXZ6Sms2T0VIZjBr?=
 =?utf-8?B?aGtNdnBtMER5N3QzQzBjeCtndEYwdXcya3FVUThwaUptRytkTmlNTjJVSmpZ?=
 =?utf-8?B?anFITkp2amdPUUUrdEpkS2NqZTA2a3h1Z3VSTGRUbDdrR1ZucnNlS0RkV21x?=
 =?utf-8?Q?84ZIV6iizHnl1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4P195MB1456.EURP195.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjBoWXhLQlFnV1ZXMW5VamdEOHFTWjBpTkp1cytHYmVTZmw4M29CRmJmMjZ2?=
 =?utf-8?B?ZXlLZzhCblU2YkhnY1FFSHRTelJpQ2RXS2xmcHVOWDY2bTd0UDVFMFpkTExT?=
 =?utf-8?B?YzdENVpua0FRUjk5S25maFBIMUhnamFJOWxQanM5emZTNmZYcFdyTEJCWUZT?=
 =?utf-8?B?Y09pOTJRMEYxZHBZQ1ZRV3hhYW5scFpSM0lPdy8rdnhpTTBCczFLUjlnZ0dq?=
 =?utf-8?B?RHJ0TmNFK3ZlOTdmV2gxT1ZxRU5UZE9qUEJBT1BSdnc0MVl2Z3pHMSt4S2th?=
 =?utf-8?B?dGZKaGM0SVZOd3c0OVR6MlFSYXRUbWxGUlVFc0ZVRllzV3ozREhhYzNCS2NI?=
 =?utf-8?B?ZVNkQzU1MFAzOXNaMXVSdFQrdnlyQnVPQ2hCdkZCenhmR2lrU0dHWVl6alFS?=
 =?utf-8?B?RjNNd0ZUcGIzcU11UTVhalFJSjVnVCtKN2xlZkxJMCtyb2dLNW16UTlJb1RT?=
 =?utf-8?B?WldmMk1HV3JiaTJFNlVLU1pVdkU3emRZb2lXNkd0UWtYQ3R5WHBsNW92Sis2?=
 =?utf-8?B?Z05ySG1KdGMzTGFGU2dMbDY5aUV5Z1ZLb2tpN3NaMjVsL24vUGxJSHZLbzVh?=
 =?utf-8?B?WjJSdzcvcXJHdmhEakM0NUx3V0NnTCs5aUFUTzZSMVJ5TjNrQkRqYWN5Tzcx?=
 =?utf-8?B?aTB3QkRWaUI4S1pxcklBWFk2aVhGOFhmOGFaZzdGKzY3R0N4SWF3U3BUREcz?=
 =?utf-8?B?RGxjVVBXUDNzZDc1ZFpsNngwRWtLdzRlY2t6TDE1OTF0dnJaZ1luZ1k0KzJX?=
 =?utf-8?B?Zkk2USt3WFJ4UXA3aERHNGNHd05vNDczbFIyd1JhajJlcXc1U1ZhRmJCNFNR?=
 =?utf-8?B?OVhZRTRSN2JjemRERWJ2UkJOV0FqYlV2U1pnMCs2amFzbURHTkcrQ2pXQXJT?=
 =?utf-8?B?d2VkYXd3bUFVZjg1NW5HNFdoenFEdUd5b09sa3JMWDBpV0RXenVLWTVNVXRy?=
 =?utf-8?B?dFhkeGR2ZXRXV3MveGI3eGlqV00rSWlacjkxL1prT3ZYemdiUFBlcXppYzJC?=
 =?utf-8?B?YVo1dzdrbmhyc0d3QkVKYlZpSm5EUWtRREJ1S1lOanFhVktQd3lPeEpWaG5w?=
 =?utf-8?B?QWNjYVkzbGVJcWRDanQreXYxRXVvRWdKVnhsZVBYekFrZ3VJSWluQ1duU1Mr?=
 =?utf-8?B?d1pUQStMTXc5d2RRN0lZc3I2cEE0cTZxUkJyVUxrMStRYVhsRXozbHlJTXNj?=
 =?utf-8?B?c1kvWnMxdFUxRHhualFXOGl4TmhpVU5Pck1leDVwWnRIMUJtYkJLTUlPYk1R?=
 =?utf-8?B?NXVza29RV04zYnpoZndxdFhKcDVCR3QwZllpMFNTUXh6RUNrSncvSzNHbHBX?=
 =?utf-8?B?d2xTZmo1MjBYTFl3ZjBOdjFKQXFieHV3aFZkdlBzZldnUGtpSHEzWWFEQldi?=
 =?utf-8?B?TFZKYnlIa0pBTW9TdXlqOEVsU0hiWk5JY3JtY2o0cm9wR0wvRmhiblAxamt2?=
 =?utf-8?B?aHhMVDV5RjUrUkhvSHgyRS9ERTdZNzVuTzRpNndEaFRDY1Rqdzl6QkwyWHNF?=
 =?utf-8?B?WG9YY0JkdDBRcmVMajlLTmU3dGdhdkxZTHQ2Q2NYM3hadDdUNzQzZ2ZtT0Fq?=
 =?utf-8?B?MEJ0c1NDQnFLVTNPemV0a0pINzU4ZFE0S3FySGp5RlUxVEZzSjF2YVhUM2Ry?=
 =?utf-8?B?dEJ4ZlBuQTBuN0JPSUVwdktzc1ZEOXpqSzRrQ1VWNGRwR1R1UWl3QUc3amll?=
 =?utf-8?B?eGJYUFpkc2NBR2xxWUxZQUJ4Z0Vrd0doczNEZ2Z3b0swWGF6TVRmcmEzczNV?=
 =?utf-8?B?RHBiT0NvK1FNRVJOU01Ia3Ywd3M2WjZrSXVQS2VzcnMrK1l4NnF5MXFGV3RI?=
 =?utf-8?B?dlFzNk95d1p3bnkwek02MEcxcU90dGdmWW5oMjdYS1hYN0xYNDh3cmFETm9a?=
 =?utf-8?B?Y2JhUUEvQkdLY1cxMjk1WEJOUnlRTmM2anRyckFQUktmQ3Y3b0ZMVEFQNjlt?=
 =?utf-8?B?a2dIMnltSEdaUXZkTWxQOEczWFNnQWw0Nkh1NndpcldVeVRUeWtHQzh0dXFZ?=
 =?utf-8?B?MFpPcytwSStSOE9BdmNCbHRmZldKS1QzUVZRZlZpbnVuMlN3c1Bkd0RLcGhv?=
 =?utf-8?B?eEp1OHJNZGRoTGdibmxsVURWMXVJczVEVFBYV3o5M2o4dStKWXZJYmhvU0Fu?=
 =?utf-8?Q?I1kflyq1Z7fVQkUW1gi+33d+i?=
X-OriginatorOrg: phytec.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 130fa2b4-8a28-41ec-25a5-08dd369854c6
X-MS-Exchange-CrossTenant-AuthSource: AS4P195MB1456.EURP195.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 01:43:24.3945 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e609157c-80e2-446d-9be3-9c99c2399d29
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gzYYGT/lbgXnVcI/JYk1QA8IRIEjICVUjnuFZ6WHg8lz6+X6RSUpH0IiTa6dekVCBgnBTzcHud6U3ilaDGAKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P195MB1809
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

Am 16.01.25 um 18:29 schrieb Daniel Schultz:
> Enable ENV_OVERWRITE to allow environment variables to be
> overwritten within the board code. This is required to add
> MAC addresses during SOM detection.
> 
> Additionally, set ENV_IS_NOWHERE for boot sources other than MMC.
> 
> Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
Reviewed-by: Wadim Egorov <w.egorov@phytec.de>

> ---
>   configs/phycore_am64x_a53_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/configs/phycore_am64x_a53_defconfig b/configs/phycore_am64x_a53_defconfig
> index 4a91b72e700..3027a94b0d1 100644
> --- a/configs/phycore_am64x_a53_defconfig
> +++ b/configs/phycore_am64x_a53_defconfig
> @@ -89,6 +89,8 @@ CONFIG_OF_OVERLAY_LIST="ti/k3-am6xx-phycore-disable-spi-nor ti/k3-am6xx-phycore-
>   CONFIG_MULTI_DTB_FIT=y
>   CONFIG_SPL_MULTI_DTB_FIT=y
>   CONFIG_SPL_MULTI_DTB_FIT_NO_COMPRESSION=y
> +CONFIG_ENV_OVERWRITE=y
> +CONFIG_ENV_IS_NOWHERE=y
>   CONFIG_ENV_IS_IN_MMC=y
>   CONFIG_SYS_REDUNDAND_ENVIRONMENT=y
>   CONFIG_SYS_MMC_ENV_DEV=1

