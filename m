Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1040C02192
	for <u-boot@archiver.kernel.org>; Mon,  3 Feb 2025 09:10:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0DC5680568;
	Mon,  3 Feb 2025 10:10:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="UbE7UEwp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A8EF805DA; Mon,  3 Feb 2025 10:10:08 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2061f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2009::61f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CEEF6801DE
 for <u-boot@lists.denx.de>; Mon,  3 Feb 2025 10:10:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q3MA3oZG9iXKh4eQg4v5hi4Jcj9F5rtGNcNlKhTvJbizQYx/8vuE1ei2ffjJSA57exhTtAgR6HztK3xryojw8lGc+QvhxJu02/Omue7/eK0Oz5HRB/+CiOqIpv9W8C9LTIT4GM9G0/Fwre0LOlvCsPb2wE/UFIsWWVfYwUTaMCGlGqB9+ZAPxm4xQKa4pHXeUBEh212YXJqqoyuR2/BZlfpgGO+V+ZFZfCmG0Yxp1+xikm2CjmO8dD4cRSODFvBN33smpk1BC4rhoPXJtDW11Cu8LmzE6EdvqmsOteHELSyjvpvMNlK/RD3c3n6Uov65HwzRu0LUEesHmgM3BOd9dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ik4jJE1zYvrz5RqflcTvTEwY+g1T/PTilRoH0+I7vWg=;
 b=geNbQXKz3rT9nwbkc0eA3h0lCKoYV05X2P3mict7vx9z6a0Q2R6CTxTptPAuprg9JHwhJ0JTJBlppdI3HnFbervhJs+0+C0zIc2K9Ffpk3pUGMDUsdHl580ZupbY4JeADsj1n7PfcFAJBz8gmW0ozMURIwzV+ZTxh7XpMHur+kf+2it1Vg+JnVLzxHOQwQHfAzvCIqgkkpHWa8QUVwQuWYKA9sqoYW8R0H8qlhMddcSgcPe6kSAya0gqeEaJ/HvDvPkCfcWGlei6sBd0SC0zU/1XwRkYPuusVwr4JiI4mXCGgAbjpqMxORQAsDxkDWI94QrNUu9zRMSSEBfHUi6GXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik4jJE1zYvrz5RqflcTvTEwY+g1T/PTilRoH0+I7vWg=;
 b=UbE7UEwpIWFRGtgYwTCP0JgNEA1aNY5XZhguLDiq2DUl3bHuveT9pXaceBVqyX4rsSntp/YqpFz713JEQ0AERQXRJWTDHhJePx3MDot+vMWL8DqTydKEx23Ikbp6Rb9Dc05DPJyDsUuYt1816yFYb1lFAtvugk2kbhq9rAXoraM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by IA1PR12MB9499.namprd12.prod.outlook.com (2603:10b6:208:595::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 09:10:03 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%3]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 09:10:03 +0000
Message-ID: <24df2285-4c5b-41e5-b8c3-1b6b8c5fe8ac@amd.com>
Date: Mon, 3 Feb 2025 10:09:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: zynqmp: enable u-boot itb generation via binman if
 SPL is enabled
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Prasad Kummari <prasad.kummari@amd.com>, Tom Rini <trini@konsulko.com>
References: <7cba738ae36dacf7d1b0cfbaf13e0c9b3a0df225.1737462296.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <7cba738ae36dacf7d1b0cfbaf13e0c9b3a0df225.1737462296.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::13) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|IA1PR12MB9499:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb5710c-6667-4dd3-0bfb-08dd44328b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UklFckJhMmQwcEx6ZkVYWEhveUZMazNtd2pDNExlcmc4SjJpci9ranFBZkda?=
 =?utf-8?B?UWMvNXNrbDUwZGJwcDA2RVRvWXl6Tm5qN21XeWZ1dXRuaWw1VUx2TjNXZHNL?=
 =?utf-8?B?cy9VdkR4M0Y1K29KdlE1K0lNaGN6MDh2NnFvcFovczJhOEQwcWppUGswMDJ0?=
 =?utf-8?B?RFZqWnhDK3RLWUxwdnpsdnBOR1VpVEY3eG9FMW00TmExYS9hQkdla094ZU0r?=
 =?utf-8?B?WUg4V2Y3SDBVSGhCWExTcEdxTE9SMU1ITUFmOE96S3AwSm9qcXdjaFV5citq?=
 =?utf-8?B?Mldxd2JSV1VSa1J4NkNpTEtlTTZJNHZmdkpocm90T3pZOWVHeS9wU0s0cWVK?=
 =?utf-8?B?Mk54L1hSOFA1dWdEbXRxbTVFeVJ5ck51YmRDeW5pdXdkM3FZc1d0bE94Zjdl?=
 =?utf-8?B?cHExQlRxKzZoUnJqbmxacFZ2U1ovb1lWL0YvdTFBd0syUmdHVUpLa21LT3Uv?=
 =?utf-8?B?eDd2V0VUQk1sSWFwdHBYakYzYlNJM2IyZGFMSmpRaDJxYkZQNFdsYUJUc2dr?=
 =?utf-8?B?ODNzYVA2bHBEazZRKzhXb0huOCtaUktCS1ArM0l3U3BiRkxaeDN0MFo3RURJ?=
 =?utf-8?B?VkJKaUsxamk4eGtQbWlrdjZBRC9qN0NQYlNqN2V4dkpsYWhOQUxsRGZRV1N2?=
 =?utf-8?B?cHBuSUxBeVlLN0w0cTR5eGMxd2c3c3JsbTJ0QU9Sb2FWUmdyRFhuUGFwWnYr?=
 =?utf-8?B?dHppN3BGWkk3MUZhZmZCSml0MCtHaVA3RTRGdkV1RGk1QW5wVFhvU3k4TTJD?=
 =?utf-8?B?cHdZaTh1WThaRXhZdmFSSys1ZThsWDI0bGJuaUI0b3ZLVG9IRkFlNnhXU0Ew?=
 =?utf-8?B?RnhWTmdNMnA3RXpYZnZOUVRMMDhLQXB1T3RkVXFCVTY4V2xaZEhhdVFuY2VN?=
 =?utf-8?B?QTZYYkxOb3VFazMxVG5zY2JvY3FpVXVicUZlOG5Oc0paRnI1T1dRd0ZOOVlW?=
 =?utf-8?B?TC95NWJoMmx4UTJ2S2RNeld2RDZGeU5vYmVEWlV1eWNLSzZGSzZQVktNUWlH?=
 =?utf-8?B?RHR1bExjNDN6WFZFeTJ3Mm1nVTBRRHpGc00rODNxRWVVMktqNm52QTFyOCto?=
 =?utf-8?B?N0NuMmdoM3JIS0tmOUNlR2IvTWs5N3IrbThXQm82MTJGNmJ5dnpocitMQlFR?=
 =?utf-8?B?OXpwME5YUnc4dXBiSCtVTFJOSmh5N3gvbnpBMXNVNGxyS2NWTHBEQXlsZnVW?=
 =?utf-8?B?TVJkcmxhS1Z4SE1UTEUvdDMyUlVKSWdvNnliRWxsby9hMUZaTFdEMWIwcXdt?=
 =?utf-8?B?eHhaY201SDhJRzRQa1NnbzBtR1lRdjRKZDBwdXdLclFYVjRRMzJGOUx1REYw?=
 =?utf-8?B?c3ZBdmd1cjBlUFp5UkNaOVFWUkRTazh3T1lrNTExczBua0htTU1LYXdXTFov?=
 =?utf-8?B?UVpVUUhJUXlJRjhpeHc0R3huRld5clBvVWpLVXRUL2dqSFB0dGVKRGFxY250?=
 =?utf-8?B?YXNxTFkzZmlHSkxIUGw2TFlPbWhLaS9Pb0lWNE1jOU5BamJ2UmNBTzdHRGZy?=
 =?utf-8?B?L1JMcnlxcWpERXBMc0xIYVRLV3NCYkFPMENiOVFlKzJvOVVuaWtRSXliTGFB?=
 =?utf-8?B?L1cySHBuMEo1OFlEaXpiRGs1bDFvUzVONlBOdUpqV0UrSnVXQ2tGMFpvanU5?=
 =?utf-8?B?NitZS1BiZWhyYlowNkcyRUdJZTg2TGZVd3BwSGtIME9Edm16UENHU01kb0V6?=
 =?utf-8?B?ekM2bnlDbjhwT1E5SGhSNzdhd1N3T3JETG9xU0xzTURNZ21FUXo2Q2o5Z29q?=
 =?utf-8?B?a2JmSDY4TytzVG5oQzRoeS8rbWNHOG9uRGNSa3VETEVTREtFbERPZXhqN0wr?=
 =?utf-8?B?RG1GVjRudy8vOENtMHJtZklIYnd2UDgxYnJOK0Z0V3hpNmJCSmZYN1VuMG5V?=
 =?utf-8?Q?UJRmMnSCFytu2?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c09HUEVqeVNwWDhMTGp4T0hrWTNYcklWbnphN2xBMkljQi9GUWdWQnVWZGRu?=
 =?utf-8?B?Q1hpRFAwZE9iSjlPWTFZZGgyUzBMcDdrVXVrUU5aSFhIc2tXMTNzcVlRZkFl?=
 =?utf-8?B?TkxNbmdaZXVOZEwzdFcvYmxlTnBxRmk1OEwrams0b1E0bjhmKytCNWhWWU1i?=
 =?utf-8?B?OU5mU0g3c2k2dXg1bUtIVXdzNE5NcWFBUFJkRENHSEVOSEVMQ2Y2V2dVVXV4?=
 =?utf-8?B?V0pGc0tGK3FUOUhacXVGdi9qeitEbFRaV3FJZjBVejZnblNCRXk3cVBvc2lJ?=
 =?utf-8?B?UU9RM1ZGVmh6akJUeTF4Y1NMN3ZweDdjVzU3NVVYN3RZRXp5ZjI4SUVtRUFs?=
 =?utf-8?B?M2xYTVA3Nzcxa0tkNGFqaVBNMmM2YXBDRStXc0FwV05NZUYrT2JDRU1uRTho?=
 =?utf-8?B?ZnVPWTViRnB5bCtwL21OUGJpRWRpVVlEYVQvQmx6K2tFbEZvVHAwcndTRTE4?=
 =?utf-8?B?UllXSE1hbHg3UWZRQ2VhbGpxRnNUUDBNS1lHSXVlNHMrMVVOUGR3c1YwZG9v?=
 =?utf-8?B?OHZrSlRNVXVXb0lFL2xZNXhBci9JMzJ0dC9odFhLcVA3YzJwYWI0blpBOG1x?=
 =?utf-8?B?Tmk0MlNJVHllM2FOeVRqaHJwWm11Mk9Dc2VjbFB1L3FwYkZzYnFJbUVWeXNL?=
 =?utf-8?B?OE1acytGRU8zV1piMDIyV2ZEdU9rRWo2UHZhZnNGL0w4RkJsVkQ3bzAwcUdz?=
 =?utf-8?B?VEd6eTNHT2lINms5SGI5YWJLYW9XWCtvWHZCNDRSMUd5aVgxZmV0aElQRjY1?=
 =?utf-8?B?TnNvYWhOZDFTQ3BUVXFTWXl2MktTU3NsOHd1VHZLZld3Zzl2M1ZWR1YwWmUx?=
 =?utf-8?B?d0xhbnB6V2xlbWw4d01heFl6VFFHc3hHR09oZTlMdmE4MTNqcjBaMW11YVZN?=
 =?utf-8?B?aTFHN01iZVQvdzk2N1IveXRMM0ExY1hacDBMeFhEek83YW9NMk9nVCtPZi9Q?=
 =?utf-8?B?dHZCVzFOMlV2citIcW5LR213R0IrU0lEV3hhRUVJbEd5WlFuY3RPWXJQU21K?=
 =?utf-8?B?eEVDOHAyWDF0ZjBURjZwcjRwWGU2VC9nQ0NxdW1Kay9DUWhab1RMYXZNT2lq?=
 =?utf-8?B?Z3h3ckZmY1lVcUJyTVFGWUNRS3d4V1lBWGE3Y01UdENkYmk4eDNpbTh6Rm13?=
 =?utf-8?B?d2tpRy8yR2hPdFJBUHJhVkI2V0VTSE80d3lqcjB4L1J4VUI2M1UwUXpVQkxV?=
 =?utf-8?B?eXZpbWc0SnhUaklJV0ZoQmZHa0o1aUtKVUxmZDdWb1R5dmh3d3FlNVl5TTV6?=
 =?utf-8?B?eFlXOHFnbEZGN2ZvcjBOSnRvU2FHbStMY3lqSWx4emtJT2M4MHFUL0xkYnMw?=
 =?utf-8?B?L1FhcU5ySDRWeU16NkU4dGFkc21tUFJOYVFpbWV3TFJqVXU1UW9maldDTE1R?=
 =?utf-8?B?b3VDWDVVOWtMelluMjhPZjJCbmE5ZDY0a0JSamhoYUVtRnJYVmtmVlliTE1s?=
 =?utf-8?B?SndTeHhWUm1DOHZYTGtzSTNVOVFVM0JEUktQRlN2aDR0U3FMYjF5QU9IdnRy?=
 =?utf-8?B?TVdNOTFTb3FQMk9QVFNUNUJGenFzVDF2ZFhRNmVNZHVPT0xWQzM1S2dqZmlJ?=
 =?utf-8?B?MWEwUDlPZGgzMGhrWWkwS2hyK3poR2JPS1VDcGdlNDN0QjIxK05iNWtYVk4x?=
 =?utf-8?B?MHZWMDJDVS9Pd0NSdCtOYVFHVjhCZjdVcG9MdzBzSm9vYkJXZGlyQXdtU01m?=
 =?utf-8?B?UXpTSFNVTkx2N2FjSzFnR0owSzVGL001cDBqYTdWdjQ0L212c1RTQXl6UzBl?=
 =?utf-8?B?c2FycTZSYStmck9wcEJMM1Juc3pwbkUxb2JiZnpZQWw4QWJaYmhzK3Y2eUw0?=
 =?utf-8?B?WURtTEhaa1R1T01KMWRKZmVRQTdnTUhDSitXbTY3NWUwMTVsb2k5NTIwRkYr?=
 =?utf-8?B?MHAzMElSaUkzUm1UczJEd1hWdVYxb1dCbjBJSW13S3N6OUtRa1FWWCtRUGhJ?=
 =?utf-8?B?UFJ5RWNCVnFIcUlhQ3VveitRUk1QVG96ZVB0R2VibExaRkZwOXRiZlNDMzlP?=
 =?utf-8?B?Uk1Yb0RDOGR2eW5SWG5LbGdFTStodjRIUVlYMzYxN09rSTNXaXJvNlExcG1k?=
 =?utf-8?B?bG1ZelM1eWN5YVlKTXBrQlFQUVFTbk01eXUwZk91cnB4MDRZL04wdmFycjJC?=
 =?utf-8?Q?Z+ZQBbVEfzFoZAsuPBMNCoHuQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb5710c-6667-4dd3-0bfb-08dd44328b1b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 09:10:03.1594 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zuPE9/rKQ/Veddw5T6rUaEoaczH/AJEDWa7JnO97dya9rxLD9zyN/apKU0ogE6Ie
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9499
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



On 1/21/25 13:24, Michal Simek wrote:
> From: Prasad Kummari <prasad.kummari@amd.com>
> 
> Output images are generated via Binman only if SPL is enabled, as
> there is no consumer for them otherwise. An #ifdef check ensures that
> when SPL is enabled, Binman generates the U-Boot ITB. If SPL is disabled,
> ITB generation is skipped since the ITB format is supported only by SPL.
> Without SPL, generating such an image is unnecessary, as it would not be
> used
> 
> The second reason is that when a DTB is passed, the current logic cannot
> handle it without an additional step in U-Boot to parse an appended FIT
> image and enable board-specific code to select the correct DTB config.
> The MULTI_DTB_FIT configuration should be used if support for multiple
> DTBs is required, but SPL is not being used.
> 
> Signed-off-by: Prasad Kummari <prasad.kummari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   arch/arm/dts/zynqmp-binman-som.dts | 3 +++
>   arch/arm/dts/zynqmp-binman.dts     | 2 ++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/arch/arm/dts/zynqmp-binman-som.dts b/arch/arm/dts/zynqmp-binman-som.dts
> index 3d9d8476c98e..3ffa06f0c04f 100644
> --- a/arch/arm/dts/zynqmp-binman-som.dts
> +++ b/arch/arm/dts/zynqmp-binman-som.dts
> @@ -13,6 +13,8 @@
>   / {
>   	binman: binman {
>   		multiple-images;
> +
> +#ifdef CONFIG_SPL
>   		fit-dtb.blob {
>   			filename = "fit-dtb.blob";
>   			pad-byte = <0>;
> @@ -220,6 +222,7 @@
>   			fdtmap {
>   			};
>   		};
> +#endif
>   #endif
>   	};
>   };
> diff --git a/arch/arm/dts/zynqmp-binman.dts b/arch/arm/dts/zynqmp-binman.dts
> index 675f6bf51ebd..bf3335a3e539 100644
> --- a/arch/arm/dts/zynqmp-binman.dts
> +++ b/arch/arm/dts/zynqmp-binman.dts
> @@ -14,6 +14,7 @@
>   	binman: binman {
>   		multiple-images;
>   
> +#ifdef CONFIG_SPL
>   		/* u-boot.itb generation in a static way */
>   		itb {
>   			filename = "u-boot.itb";
> @@ -201,6 +202,7 @@
>   			fdtmap {
>   			};
>   		};
> +#endif
>   #endif
>   	};
>   };

Applied.
M
