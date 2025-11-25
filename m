Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A6DCFD364
	for <u-boot@archiver.kernel.org>; Tue, 25 Nov 2025 05:02:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E81BD83F2B;
	Tue, 25 Nov 2025 06:02:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="c8niO9lS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CED883F4C; Tue, 25 Nov 2025 06:02:47 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7606983E0E
 for <u-boot@lists.denx.de>; Tue, 25 Nov 2025 06:02:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gpKQjMJjYkTDMXMPCdvqg+ebHyumFZ8IBxpjpV33dbJfQonx2WBNI4wrdjGRD3kBxmTU/yWlVVXKBETlV2l4lkyxTUxAeV6XHOhVtMVFfrMS/CCs9PlM/Wrvrc9KCsjAlLaj6bQp00otHtBcSk0hXWIV3peIiJOkckRSAAvF9fpdXz+d00co0gvZl5nyBUS/1hWJmxjm/JpzUoAo6UfXWB78RCus3q9o2d4i8u3mdgSTy42+TIm56yYpahhzuH6BkpCT5D77SLahsFUgScxmj23XsE5EyWW0fuRC8HGm6U6lpy33lEksmskJGa0LlPTAJ+oITmBSj5U3k8WOG7i5gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=woQFaljRNvItAeGh712+wz3c3pFoXFEmUCudzuYQbC0=;
 b=qRqBAvM0wCDPYCH5ENGYIz6KRlmckHN8JxvJHXEGgG1QF8peOoxhpYuVfK9wgKPu0JORXOmIXQGbOH4ORG7GG24I0Myf9N7JqAe5Jio+ti6RozlRlNT0yFUI49zGy79VwuUBcCOIY5eFRiRoRZyHmCXFHaQOLzvVYoHMzs0l37dYYCt9sH8MUCCrTQyR0uAFDuQMgzD5Au/cA1FipxQVPnFVdwJug9OZa47o3zhiNeqabGi3WdA/1dXoAG/fODt1E77OodFN7t63riHolR6WPPAaHkHk5MN+ASrEG6iQGWk5moCyRMo5MSb7ixLHzhmvLa8G+kbUo2pm33qTUtZv1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=woQFaljRNvItAeGh712+wz3c3pFoXFEmUCudzuYQbC0=;
 b=c8niO9lSqV0ZBeTQKp0/RjkRHWSq3LLS9SJGec7ricZ0y1Ni6caCv+tkckTstIpuuDVdWEuKU+MFPflLOjkujmb1nPs/qWfjNFSsUvSD4Vxe0vpwCH+zBNxd5HEqk0s0lJ8gL5kCJBY9JPFL3h35ZxrMh9wbwPXY7K+O/CpilrTp5C2evJmy4Qp38p/lhAUt1I6dQfhy8RNXQ0VlzGucN+DG+xslzFnEMaiTZ3Dsiuxt7RTdE9Y4cQiXnXeEIBTCfaQtEouW4YL29xGT0grtsLkd9eSgkM89NqcDU1gbj5zRccg/efPT62AB5u76RrAtmJstrcDM1Y07uP9b95IWPA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH2PR03MB5208.namprd03.prod.outlook.com (2603:10b6:610:9f::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 05:02:40 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 05:02:40 +0000
Message-ID: <e39163e2-cf21-4a73-8170-8066d93db049@altera.com>
Date: Tue, 25 Nov 2025 13:02:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] arch: arm: mach-socfpga: Adjust a raw sectors for MMC
 loading of U-Boot from SPL
To: Jan Kiszka <jan.kiszka@siemens.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Simon Glass <sjg@chromium.org>,
 Brian Sune <briansune@gmail.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@altera.com>
References: <cover.1763140421.git.jan.kiszka@siemens.com>
 <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <c1dc5e70f6bbde1f2b7dfd027a90f09bb4c1e939.1763140421.git.jan.kiszka@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0014.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::26)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CH2PR03MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d7d3b62-a6c2-4a20-0d06-08de2bdfdc0b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UTZSSzErTERCUEgxOW9GdTc5bWVwelZIVDdOcDdpZlI1OUhKcFdoc2w1RVpK?=
 =?utf-8?B?dWp4bUhabmtlSnVxZW02ZHYwSnlwZ09TYTl5N2VOdVBmVHlqSWxMZUU3NGtu?=
 =?utf-8?B?QlgvN0g4Q29RdjNhcnErR0E5RkliT2EvWHNSaUZibWdVUGJsckpZUE9QYnVa?=
 =?utf-8?B?UlRvNkZMbzArRDZhS2UrdEwzUW44Q2NhTXR2WGdDNVlwZEVsY3NOdnRYbjlI?=
 =?utf-8?B?ZWZEQVMvSzVCRktkcTN4Y1BmRmFSSythbWJjQzlTYVR5VmZMaldyR2I3S0Y1?=
 =?utf-8?B?RjZvaHhIbEJZWnk0eGhrVDJnMFRTMmhDZXpqaXY1YlB3Yi9hMTFuVGFyRlA0?=
 =?utf-8?B?MXVjZ083bmVRWHNzQUpXS3kzYjlVNCtFSzJyQ2tpZ2JrOFZoWGtMMnNRZTVa?=
 =?utf-8?B?SHV0T1pIYlRjeXJkQ3BUYkFXUUZORDRRZDZVc2J5OUF4b2ZOOEhhKzd2MWg0?=
 =?utf-8?B?dzNsbzlFOFdwMTZFOTBiNU93dTZSbzI1aEdxdlZRZjZDNmY3L3JjeFMzN0ZG?=
 =?utf-8?B?OEt3WGcrbWh1dCtoZ3lGMUR4R1FMeEhnaHFRRGVHekgvNUJjTVNjLzBPSGpW?=
 =?utf-8?B?NERjMUpWVWFHSmQ4Zktkc3VLNXlUTUdoamVVZHRBYysxS3k1NGk0Y2V4NTVw?=
 =?utf-8?B?eWNTQ3lGQm4xTzNucjhWT0dDL05PQklRU3NnNlk4ZC9BVkt5YmVkSVBLWkVu?=
 =?utf-8?B?VUpCU1BJYXBHYkthSk1ZWkRocld4UldBV2tWNTdRaFdHR1k0V3V6enc0bVZk?=
 =?utf-8?B?T1ZVSVhBRFFldnhjanU4S0N0UGxkU3NXY2NBWEpwVkNxdjJtUjN1L3lEemNQ?=
 =?utf-8?B?YURuRm0xQktRSU5yNWRLVzJwQjJCekUzWWZtR2NqQkswdHg3aVB4am9xUEY1?=
 =?utf-8?B?bk9TQTkyQkpkT0xhSkZhenlObWliQS9JZGk2RFVQTFROTjVTaFY1YTZFaDBN?=
 =?utf-8?B?aXNRRDlYQnl4bjhrOU5BSXh6MU80QWZ4WWJqSDB1YlZhd1UvTjBMWkJPNVdP?=
 =?utf-8?B?OGx5dlJXUm1KYTA4U3RWZ0NhbzFhUDhHRncwTjlOQ1Bjbkx1dmduRUlqSE9G?=
 =?utf-8?B?Tk1xS2JjNVZ5eEZkMmRrcWZFaStrSlZ2TVh4cENsNGIrb0Jsek5ZSlpVSXQy?=
 =?utf-8?B?SW5aM04ydkFQOWllaTd1TjRuZkdFR1FTamkrV2RVSGJ3RGFJcFZoRHVmKzZD?=
 =?utf-8?B?TUlIZVNIanM4UU4rRHNpdnlnTXhvcWxlTHd2NCtVSWJrMlhheHJrUzAwOUxR?=
 =?utf-8?B?RnQ3dTBzdDJnMUFyQUVOdTZ4U0ZKS0Mzc3ZEbDg2ZmFLZzIvTjdQRC9WRUgy?=
 =?utf-8?B?aW9iMTJVU21RbHM3dWlxcDNZYXdUOXVEeVgyZEdxZ2R3eVo0UDF6cm95YWVO?=
 =?utf-8?B?UzBubDJWWThWbUJPZXpRK1JDVy9DVFpIUGhqcEIyYXpITDZZcS8rVG93TE9i?=
 =?utf-8?B?REsrT1I4cDh3b0dxUWFoVjUzVUxXVW9GdUMxdEdxamM1cGtnZHhRTzV0NDZD?=
 =?utf-8?B?TEp4WWVIVitSOVNpUFVPQ2xvamJRZjVEcWNYMkRHQTJjR2Q0MTB4dVVRY2hP?=
 =?utf-8?B?b3FiZEJ4Nm1FRVdCZGd6ckp0M0FZekMwbzlrU2lNVSt0elBsOFVxcEg4cnpG?=
 =?utf-8?B?WGJHSXJrUEhOY0hwQmp3Z3RWckVmeURadXBIRmI3N0ErVlJmVzBFRCtMVkNQ?=
 =?utf-8?B?M2k4VEsxSWNKZUx6RG82d0prYkNaYWlsQ1FUS0VDQkFlTzVDWDRSbllnNVdX?=
 =?utf-8?B?cEJqaVJxQkltQmFJcy9XUjhUNTd6VGE4TlAyTkZqWW9SSFovdjk2OWlRQXJX?=
 =?utf-8?B?RnVJUDU0ZlZOK09yVktLK1NmMDBScjlkZ1AyL0dPbVU4ajdKeTAxV0FFMHNm?=
 =?utf-8?B?a25pNUNWeWlPbEtFcnVud0syVGV3RFpobHdtUDZVMlpSRHc9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUYwNDlVTjJhb2lnYlMrOW4xVFBjcXp4VG9VanpnMzBsRG1PT0lhbE52MzJY?=
 =?utf-8?B?cnpCUzVpd25FY2d6R3hWYkpqUEExM0lqZ0h1cExuOGZ3WTVtMzdibnVUS05r?=
 =?utf-8?B?R0prSytXYzkxbjVoRENVMkVMd1c1azk3MjluNUYva2daUE50Mk04ay81NndB?=
 =?utf-8?B?ejBpZCtUWUl3V0R4QmtVaEVDRUM0UVlNMk5nSWhaNjk2a3g2bUFMY0U1MnVp?=
 =?utf-8?B?dnlMOUpMZHhsTzkvWTRnRlF2WTNURHNqb2hUS0p3SjAxQWVkUzdXRUludys5?=
 =?utf-8?B?YVVtRzY0eWdqZWZUbFBibkVrV3BtNVlsRFNZTi9jZzhxSGhSSTlPVG1FQlAz?=
 =?utf-8?B?TU0yZ0lWZFhWWU5PTXlnVXRrNjJ3cEVPQ3RXOHhiSkg1U3llaDhHOFFiT005?=
 =?utf-8?B?cE9yTVdBSEtQWmE1eTJINXZuZXRkd3JBME1vQWJMQmZXNVRyQnRvakdMekt1?=
 =?utf-8?B?RktyR0VrcU1udXBiOGZNNjM2ZTN0bnF6SUc2dlVMelFqaGhlQ1hLVENzOGdK?=
 =?utf-8?B?LzFtMGNlZEJ5dHdNdlJWSDRzNEFYdW9Dd3BoMmZtOWZUNjk1Y2g2T3BQRG9B?=
 =?utf-8?B?QjRqRlRXZFdvdzU5czhRZ3FqejJkTC9qYmlObHRiTkZGalZ2TTArTno3LzhG?=
 =?utf-8?B?UVB0MXFaVlk5NS9ydFhNQ2FiZDJGZHM5OGIweURxQzlkN29MTmxTOEJobk5T?=
 =?utf-8?B?YnV6MXkxRVlWV0RXN0h2QjVsK2xRa2VzQkdUY0VwN2JlblNKdlp3Q1Y2Tm03?=
 =?utf-8?B?Z1ZKV2I4VzI4aUxrcWlUL1VVT0hjd1lXWlhSVS80VU9ScFVNbitKRk9xbVZJ?=
 =?utf-8?B?MTEzWHVZZlJrcU56S0gwcThRSWZaQkJSbnNoOG5EQnpkRTlrbnV0Z1dyR05i?=
 =?utf-8?B?VU9wVUxtdTlPdEd2Znp1dXU0RnBQTzh6SlhlK2JhQmJnY3NncS9IZUpwaVow?=
 =?utf-8?B?WmRRTWUvL09JUThVZytNL2xULy9qbmpoMzRXNlFCSDFRTnJJcnpxSXB3SXdQ?=
 =?utf-8?B?Rmhmd0UxRnduRTNHa2xLVCtyZW0vZm5rSFlnQTRDdU9uczMwZXN0MER0ZGRJ?=
 =?utf-8?B?UDdPWlR0ZW1tbUxSalY4VzFiL01NY3oxMzBrR3FRemtiUFM3cnJkdzZveWda?=
 =?utf-8?B?K1JyamgybnN3R1JjaFpQbysxK3NMTnBSV25XWnR4d3pZbUVXNE5CMXpSM295?=
 =?utf-8?B?YXBIaUJ5ODRvYWJCUVFkVjR3YW5JdlhWaElrelhtOWQ1WDdFbXNERGpLMmJz?=
 =?utf-8?B?Q21xeDd1dlIySFFnNktRR2FZK3U4ZGM4aEFndGJydjFPbER3RlBlQ3hFT3dS?=
 =?utf-8?B?SlRUMURBVEFuS3pjS3RCeHNqdUJxV3ZtTitrNEpWRHJUYWMzdEhGRUZBWXYv?=
 =?utf-8?B?S3hOdlQzdTh2VGYyQjRDa3ROZFNiODZnZkZtV2JRaWRoQVkvWDJnQlQ5cE8z?=
 =?utf-8?B?ZENjQmppaFBHc2I2Z1NDekxUY2psV1Q1SHRJbmNKT1pDWmpOSUlvZkthUEJp?=
 =?utf-8?B?UjFtQVJhUXVhTFBnTHFpYTZ6YzlhV3pDN09VRDNYOVpTMzVpTFgxWWNVdjV0?=
 =?utf-8?B?TmQ4SzlsN2loUnY5cGtjMm0zWjNyVDQrSmlTN0lBMmdFeVhnL2VsQmkwME9j?=
 =?utf-8?B?a0paKzBXaEpxdVdBVEJyNUJydTkrMDlQV28rc2tSVlZFOTFabVlKdGVhZTAx?=
 =?utf-8?B?UDBaN3VIelpCTHdJSFVjQWYxUVVOWXROVHIyVDlwZ3RRamFNc21UUmpmcEJK?=
 =?utf-8?B?ZGY1a3dKU21ZMFE0cXBkQjQ1MWppK0c3OFZWaHUrbmQ2cGVqa2JkeWxjdHBu?=
 =?utf-8?B?SGFjRzhhRVFYd0RBV1JCSllaVGtoZVVHSzFSVkRNRkJ0c3VBMHM4TlpaM0d4?=
 =?utf-8?B?RERWZlo1V0QzNk0zWGx6Wk1kVy9vNEFXSkRKaUtjaUZuT3FTVWFkcHVycEd6?=
 =?utf-8?B?U0VsRThCeXhCb0tqTWFZQTluNXZUQTVVRVhoa3hkYjNZVUFXeFhpMGJBMzl6?=
 =?utf-8?B?L3hNMzZJbkZyK3cyRlVEcWpPVWJvRDMyQmwxeStGOUZ3Nk5ET2dGSXJrV2x3?=
 =?utf-8?B?a3BmeFNjb2RxNDRkWWtvZi9QRzJ0UWJLTy8yUjNIQzlHV3o2bVhrUi9oSmJk?=
 =?utf-8?B?dG9SR1F3MFdkejFvUUxxMUo5U0dQYks1eHBmeDBaak1WZXJZNG5aSTd4UUds?=
 =?utf-8?B?b2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d7d3b62-a6c2-4a20-0d06-08de2bdfdc0b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 05:02:40.6870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2bSHhT8ViVwJvHEoPPva6e3LGxYxSm+X0ly9v5b5FjPbrh6TnafIPCj4I71MG2i7QemfM1oQzcNt8HZr3IRoZ6FwUi5kndsr0c9SWJTD7Pg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB5208
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

Hi Jan,

On 15/11/2025 1:13 am, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> From: Jan Kiszka <jan.kiszka@siemens.com>
>
> If U-Boot is located on MMC, SPL and U-Boot proper are glued together.
> More precisely, SPL is stored 4 times. Take this and its padding into
> account and adjust sector number via board_spl_mmc_get_uboot_raw_sector.
> This allows loading from a partition, without the need to hard-code the
> offset via SYS_MMCSD_RAW_MODE_U_BOOT_USE_SECTOR
>
> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> ---
>   arch/arm/mach-socfpga/board.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/arch/arm/mach-socfpga/board.c b/arch/arm/mach-socfpga/board.c
> index 28554b7a109..d756f7381fb 100644
> --- a/arch/arm/mach-socfpga/board.c
> +++ b/arch/arm/mach-socfpga/board.c
> @@ -14,6 +14,7 @@
>   #include <hang.h>
>   #include <handoff.h>
>   #include <image.h>
> +#include <spl.h>
>   #include <usb.h>
>   #include <usb/dwc2_udc.h>
>   #include <asm/global_data.h>
> @@ -209,3 +210,11 @@ void lmb_arch_add_memory(void)
>          }
>   }
>   #endif
> +
> +#ifdef CONFIG_SPL


The guard should be CONFIG_XPL_BUILD instead of CONFIG_SPL to correctly 
control SPL-specific behavior


> +unsigned long board_spl_mmc_get_uboot_raw_sector(struct mmc *mmc,
> +                                                unsigned long raw_sect)
> +{
> +       return (CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect;
> +}
> +#endif


Global impact:
Applying board_spl_mmc_get_uboot_raw_sector() to all SoCFPGA boards 
could be risky. Older platforms such as Arria 10 and SoC63 devices use 
different layouts, and soon U-Boot proper will be moved into FAT32 
partitions for cyclone V.

Offset calculation:
(CONFIG_SPL_PAD_TO * 4) / 512 + raw_sect assumes a specific SPL layout. 
It may conflict with the default 0x200 sector 
(https://github.com/u-boot/u-boot/blob/c5e6d2ab7eba68cbfb600cdc131c0c375ced2ec9/common/spl/Kconfig#L592 
which eventually assigned to raw_sect above) used for 
SYS_MMCSD_RAW_MODE_U_BOOT_SECTOR on some boards, so this calculation is 
not universal.

Suggestion: Consider gating this behind a board-specific Kconfig option, 
or limit the change to boards that actually require this offset. This 
will avoid potential regressions while supporting existing platforms.

Please let us know your thoughts.

Thanks,
Tien Fong


