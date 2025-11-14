Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83DCE7AE5
	for <u-boot@archiver.kernel.org>; Fri, 14 Nov 2025 11:15:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A6C883EF5;
	Fri, 14 Nov 2025 12:15:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="wQgoQ738";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA4CE83EAF; Fri, 14 Nov 2025 12:15:37 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c112::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 204E883EAF
 for <u-boot@lists.denx.de>; Fri, 14 Nov 2025 12:15:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lpxf013QEs0YgOCGLuNEuRY9VcR2emjTPSeThtSXM0TkRZhAH5p3XUlwl7ot8tMI2cSW9EVAsV5i1rCPzUZSWnnNB0N/AhW5LomoLeqFjWqjbtEeqKOrTcheQYRmqvXJFirBxpT5bwelqQqu8Sj9g2SOugKo9b+3KL0hQVI2lMZnY7kBjjnncryFrGMck47pZBXwhx+FOGrjMahNEj4F+kmgrr6bUFLNSvJDJIyXOE53gZUj5glRQxgmbx+l7zo7z0UPnJEFTQUTNloG/NA55ubtKB8cuXsXQz5SKyjJIqH18gdJqw49W4U6iv9Rmy+lqJnkZ+Bed2cDUtDy6hJkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXG3w7SHMaxyy1jGyqjAMPR9IbuppqtQrA57jTfJ9Ks=;
 b=sHawg8ITcQ1FczLALYphyCow89jKDfUgktSIChmE+2LTAAune31paX674KiIfowBShNIpYKgjlwRcmtYz7ATN3s3k3U4fGH86lS/qRmtTbeKUqHDFh1VH7SYnZnFvVCewdrV8AKidQmKw1OpWni+rCFnbkbxIB1waIXaq2r6glbBFvx99DXtzDoehyhJTi5P9gUUzISFuB35a72ndP0QafwKieeN5ohNox1fMokGpW8SHNv0wPFJdJqyKgvFlFjW5FBy7ENGPwW2GNfAh2Lqfm3Cw4JdsrKRopBRC1YEk4XaB+1iK1pzy7xFmuE5AP2zMiwr7NMNUTZQ2XwP36jd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXG3w7SHMaxyy1jGyqjAMPR9IbuppqtQrA57jTfJ9Ks=;
 b=wQgoQ738I6l14XrgAS0yU4TEY2rA1mQCjMo2+9jeWT1O1Vl9WGrN2gr6+yymKBRnBz6f7jKHbignvB2By3M1wGKCIYPJKieb2l41AczDkNgAWaufp6XyEqi/Gff23v5uYz/n1GlHccJpGp0dgzZ7lbQQ1TzYrS8nZY+/BaDIuosgocdzkBmxD/WJkPmRMCLd1YSiFMKkCEE0u/knYYTVSMqJGaxMt0iCVIUcOYcSrNY4L36X0/jlsq0qMuP1GMiuQ1/mchtEB4ztya8LSZvp3+imiuwdCzXiFAPJJE56lqIeBfgjJRZ2hkmVRCk2ZAdmxHIzgo19JT8eHOzAs0ObtA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB5731.namprd03.prod.outlook.com (2603:10b6:303:98::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Fri, 14 Nov
 2025 11:15:30 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 11:15:30 +0000
Message-ID: <a35f16ba-5334-45c2-adb1-e0b6291cd004@altera.com>
Date: Fri, 14 Nov 2025 19:15:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for
 system manager in Agilex5
To: Jan Kiszka <jan.kiszka@siemens.com>,
 "Chee, Tien Fong" <tien.fong.chee@intel.com>,
 "Yuslaimi, Alif Zakuan" <alif.zakuan.yuslaimi@intel.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>,
 Tingting Meng <tingting.meng@altera.com>,
 Boon Khai Ng <boon.khai.ng@altera.com>,
 Kok Kiang Hea <kok.kiang.hea@altera.com>
References: <20250218083511.29249-1-alif.zakuan.yuslaimi@intel.com>
 <20250218083511.29249-2-alif.zakuan.yuslaimi@intel.com>
 <DM8PR11MB559296B2DEB7CB7AA6253B7BD2C52@DM8PR11MB5592.namprd11.prod.outlook.com>
 <0c48f4de-0da8-4d95-8070-f4382ef344f8@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <0c48f4de-0da8-4d95-8070-f4382ef344f8@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0234.apcprd06.prod.outlook.com
 (2603:1096:4:ac::18) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB5731:EE_
X-MS-Office365-Filtering-Correlation-Id: 69a42c04-84c5-4a1d-82ba-08de236f1eb9
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UGFEZVgzTmNFbmh4RnUzY1VpTnRWTXA3Rk9Ybk9Wa3FKUWt2Q0l6S0dVSysv?=
 =?utf-8?B?Yk9zc29hTTZXWUl6SGJKSkFwME13b2Zwd2ZaM1BXb3l6MVNod1N3T2J1ZHZ6?=
 =?utf-8?B?enN1S2pvWTdqcndBYzhac2liakxoUFJIbjRGSU41VzVDcGJ6bUF4Zmg5c3cr?=
 =?utf-8?B?OTJkZE0zNDFBWCs4QVZtNjRBOVc2emZHK2ZZcU1Ob1k2QVV2Yzlpa2UrSGlx?=
 =?utf-8?B?bzdKYzNIUXc3bmJ2eitYTCtXeVBnWlQ3U3ZkdTcrR3pZZStRNXovdEVnak1l?=
 =?utf-8?B?d2p1Mm42cDhVaEU5bzc3K1dndnhaYkZkbEpzNEwzTHNZZ1R5R1hlaWtFbGd4?=
 =?utf-8?B?aGkvSWZTZEQ1a2U2aWFxV1BSa0VTNS9NSThNRTBRM3l1clZLMTNQM3BXemRE?=
 =?utf-8?B?QjRHNGZYQ0Nsb05OKzA0RHl0dHdOT0tiOURUQWduQmJuZHgzY3ljeXU2MTNt?=
 =?utf-8?B?Yk1FWk5mT1Bhc3ltWm50bzYyQ3VuWU1COTBPeFp6ZUdWRy9pNkdJSkJSSVBI?=
 =?utf-8?B?d2Rhc2dvM1Q4dGFIa2lIOWgycURXVFpJSnlZeHozcjBEUHdYZ3ErZERjZHh0?=
 =?utf-8?B?SlZmWXd4c3VkOXFqK0FVZTNvV3dTS3A5T3AyTFIzMDk4OC8vVUtUOFdQalRz?=
 =?utf-8?B?c2pBdDUyZHpobGZiZkpidDhtNDBwQ29zYW5nblVuZ0syQ2V5cVhkWWoxMjBK?=
 =?utf-8?B?Y2hORU5ZTWFaNEI2blppSkk4NFRSTjRrYjU5YjI0TVEvSTRsMG5iczJZTmNG?=
 =?utf-8?B?VTdFOGxtdU43bVM5NUhrTkZjdzJmR1VJUmlpdHlPY0IyNmdqK1dGK1NlaFRv?=
 =?utf-8?B?eHp3WGs5MjlMdzFiTlR4SFdzRXlkeldXeXJDOGRuT0hqL1NwZTBnK0R2amZQ?=
 =?utf-8?B?RkhRMDlxbVo5VzdyU2VjWEY0VXFrNVpZcDhsOVRDNUo3TEk1ckVrYlJXSW96?=
 =?utf-8?B?NDZqeFBPY0FGSjA2eEJFREh3QXJDeGUrMmhJVUdpVGI0eXA3VHRXWWcrb3d1?=
 =?utf-8?B?Y1hiekpWUkROblRMYkdZU2UreGlKMEE4WmVDYVR0cjZ4eXFrRXRwK3BaMS9Y?=
 =?utf-8?B?MFAyVGZDdEQxMjRadGo5U21HMHU3Ri9pdVZxRC9tQXhiL3JKS0V6RytUaXhp?=
 =?utf-8?B?aWxHYU9HWkh6anZSQmdjS3F5aUZSbGF0bUZjMDYvaGNvVEk1Z2RwWXRCbnVG?=
 =?utf-8?B?MytoQUtCemgyTGI0ZUE3TS92VzBoSTcxUjR5VndCUXpKV2p0VW5rZ3lBblla?=
 =?utf-8?B?U0NnNzVXdW00Y3BtZGkzS2hHQTk2SFpZRTh4TUhaQ2dDT1l0S05WTHBub2da?=
 =?utf-8?B?djJjaDVXdUNHZzRyQ1B1ejhhSDFsckY5TGRZTlFYVzVqaHBMd1Yyd1VKMkkv?=
 =?utf-8?B?MHBNL20vTG1xZFZwOGg4aS9mNzNiNnRrUFB5NVY3Zzc5UWVYcWZvcFcyNW5Q?=
 =?utf-8?B?MnJSaXRqbk5XSWlIS1FpRDI3dW81SHh1UEY1Vjk1MUpHTmFRdmN3SkJMbTBM?=
 =?utf-8?B?d0pFWkxNVjhpcDgvZHBzOE81QklFa0xKcDNOQmxib1JSQVZZTkRLeUc0aUhq?=
 =?utf-8?B?N3dZTlZHemxSOCszVVFnWWZTNXUrSlljR1dtYjlDdS84Q2dISnFHdXFldXVT?=
 =?utf-8?B?TTYyN1dma1BDd3ZVdFA0M1JyNlpMRThjU1pFNDU1VWdGdzFpNFRLUlZIZUZP?=
 =?utf-8?B?MjZWNlZvdUFGb0dkUlNXdWpPdVRwdCtVbWdKaWo0Wis5NXNpYUdJMzdtWFg4?=
 =?utf-8?B?RGo3RlpEb1h6c0FBdU4zUG5WZmtnTzBzRUxoRndERGhNOXpCWWo4ODlkMGNS?=
 =?utf-8?B?MUYwcE1hQzRTTlRaMmhOR0dFd2Y5N1VqZ2NkanpYV05TRjZkaTVXRTNVcTBn?=
 =?utf-8?B?cURPVzVpdXFKKzl6dUt5cGRBMEEyaDZXVnFkTkJ0UmFGRGM4SnNvTGtVNlpi?=
 =?utf-8?Q?sCUfUIjTJrXz56mYtgYP+qN8AhKHSDRv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y3lHUFZRMzJsTXN4Wk1YRFNJb2dCUW8xSnErNkFUWE85OXF1dTZXcWFUSDEw?=
 =?utf-8?B?NjlkdzZnNDVpRHdoN1BrVlA1RFZTY1crTS9oT1poalFxWUdmeHEydWFHMHY3?=
 =?utf-8?B?MHpJbGRHT3ZXd09BbnRXME1zQk5jK2dwQUNWS1lqTXlUYzdIMmc4cXcwNGEw?=
 =?utf-8?B?VmJlTTlLRDlaOFBwSUhOazEzR2NsWDlHcG82b0sxTml1SGJtUldXM3NhYUlF?=
 =?utf-8?B?VnV4Um9OVlRvVUY2SUtWMTRZeEg0c2FkN21wcytRTzdkYjFFMjc0V3pDeUJT?=
 =?utf-8?B?OUovL1dxWVY2UEpSWEJhRWh3U2tsZnI5L3ozRGdPY1FaajZNaGsrRHpBVjk2?=
 =?utf-8?B?MGZmQk5SaDFvUTdGYXQ5czUweS9FZG5maUI5VmFOaW8xcUVCa3hrTGg1YXBz?=
 =?utf-8?B?cDJtRXJxWjRvOWl6TzRKOHZndVVJbjA2VWJHQXlNNFZMQ3Z0NnRrNmxXL29D?=
 =?utf-8?B?TyszckhicjhFckRGSDRNM2d1OFhQRXhTclBBY3RtY2czTHNWTW5Ua2NwZmpu?=
 =?utf-8?B?SGc1NnJKcldkb2JyVm9ObUVQOHRmL2I4VUhvN3lBQzVuMTFoVEdCVDV4bVEw?=
 =?utf-8?B?eFF4VitQVk5HR2M1Q0lPNGpVdWdlMzBvNDZzanppMU04OWlIZkQwWVZxNTFB?=
 =?utf-8?B?OXcxdG1RYnRLazBLTlFDRHR3bXBzMnVBMEJkbk9ZbkZlTW4rcXUvdzNmdnZh?=
 =?utf-8?B?ZkV6RTRFalZ1QjRHRWRCbmRjcFlITXVqM2VtYVJ2ZkdoV3czcXc2MVFSaFpN?=
 =?utf-8?B?Y0FDVHQ0Yk5iUGJyRk9UWUlibFBweWFPL0dyYVh5UlRMcjVlU1JQaHdZVDNV?=
 =?utf-8?B?SG5uTUlBU3NOTzE0amVBR0J0WWFQR0J0bG5za21WRjNZYXQyVC9qQyt4LzVY?=
 =?utf-8?B?YTNJODd3Z0paMXE4djA2dGIwSXJmTWpsRUd6aFk1R2k2c1djRTF5aXd3VHRa?=
 =?utf-8?B?MWhESDQrdUlEZUdHK2FRdjRCdVpQVHVpd0FwSXZ5K09LK3VlLy9OanArUmFv?=
 =?utf-8?B?ZVhEeFE0b1ZGcXJXNjRRYXI4dDRiamVGOVd3R0xnNXdMZzNmenRaQ3Q1Vit4?=
 =?utf-8?B?QTZ2MlpLSjNwYk1aNVlmaWUwOStJUElzYVNKOEpHSGpvQmFLRzMydUljaXB0?=
 =?utf-8?B?b1c3RDU5N1hVM2xWczVjYUNXcUV1Vkk3R20xTTBXSjhpTjV1NFpLNjEvMTRX?=
 =?utf-8?B?Z1lXTU53N0VJOU5wK291aUhOTElVRzYrLzdZNGVVOU5XSi94bnEwNUczTDFU?=
 =?utf-8?B?Y3BpU2YybS9ybzZiR2dHUWJjT3NJUmNqMEZIL0VJenNDQ2s2UWVTbVEzU25r?=
 =?utf-8?B?THZMK1RSMUdiYXZ5REU2SDdCMXllTzU5c3QwS1pTVXpKT242QTR0MHZvVkFp?=
 =?utf-8?B?bkVjUy9TWWFMaTFzUzhBOXdtNEM5Zzhza1krc053WWJVeWRRSXV1dEFnaTB1?=
 =?utf-8?B?N3F3YVdCNExtcmQxcXQ4dVdLbDNiWkhnU3hpOEtYUHlGbmxOa20wQ3J2OEZp?=
 =?utf-8?B?N0lCZ0lLTVkzeDl0dkp6eVJNaGxpL29ucXZxV3o0c3gyOFh1MG5vdWhVUlNq?=
 =?utf-8?B?UFN5UEFpQXdhd0pIdW1ua3hVeS9MaWpiazNUL2JUVEdpaXhNR0tIRTlKL2ZD?=
 =?utf-8?B?Z0dhZGZOWVE3eU9BNVU1WjlIYkZnYVRKbkhGdWtaNkRtTnBTV2pYaWY1Zk1a?=
 =?utf-8?B?ZkxPMng3ZUtJOTAyVXJRYzRzUDBhaGFjWElvaGFrZUR5ZTRiQmhDNXUrbkpF?=
 =?utf-8?B?Ylk1aE9lYUhwSk5LYkpkVzhKemVjMlJaU3ZVR0Jhc1k5RUhuTEorVVZiM3RT?=
 =?utf-8?B?elRIWkFpRVArem1ab1hGUFhCNXhGZisrUldyMXhqc3dCMFFHKzNqUTgrTGZu?=
 =?utf-8?B?NDR0aHFxU0RrOWF2RG9uOC9DOEg1V2lUbTBwVDh2RWpEbi9xRlUvRWovc2Zx?=
 =?utf-8?B?NzBkTG9HZGl3cTc1SUZ3ZHdlMXVUekJEc1BGNGJWclVDelpuOFAzZWtpaUtG?=
 =?utf-8?B?bTNSQkx1bGZaTDhwR1Jtby9OaUZXMUlicER4V25UdWpTcDI5QjAxd3Z0a2JV?=
 =?utf-8?B?SmhxMnBQaGdmYkF4NjJzV3g5a1dJN21PUlpOV1RJcmc0SGVPck43ZExTc1dt?=
 =?utf-8?B?citoY1JiUlBtcnRtbmROalpQcDJRL1NPaHJXQ0V3V2FjSzZZMmpQV29QRVJz?=
 =?utf-8?B?SXc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69a42c04-84c5-4a1d-82ba-08de236f1eb9
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 11:15:30.0356 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mcwP/hGAg9tZ9X0E8ww8XY+jsHeXooorn3N9NL+N7ktQHc6kNIvzWH0TXc3ZmrndWdF02EzLVfTjdwW3XDWxQOJu/HLyXCIWxrM5v9OHCSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5731
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

On 14/11/2025 6:54 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 19.02.25 07:37, Chee, Tien Fong wrote:
>>
>> -----Original Message-----
>> From: Yuslaimi, Alif Zakuan <alif.zakuan.yuslaimi@intel.com>
>> Sent: Tuesday, February 18, 2025 4:35 PM
>> To: u-boot@lists.denx.de
>> Cc: Marek Vasut <marex@denx.de>; Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>; Tien Fong Chee <tien.fong.chee@altera.com>; Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>; Tingting Meng <tingting.meng@altera.com>; Boon Khai Ng <boon.khai.ng@altera.com>; Kok Kiang Hea <kok.kiang.hea@altera.com>; Chee, Tien Fong <tien.fong.chee@intel.com>
>> Subject: [PATCH v2 01/26] arm: socfpga: agilex5: Add new driver model for system manager in Agilex5
>>
>> From: Tien Fong Chee <tien.fong.chee@intel.com>
>>
>> Initial creation of new system manager driver.
>>
>> Add supports for the SOCFPGA System Manager Register block which aggregates different peripheral function into one area.
>> On 64 bit ARM parts, the system manager only can be accessed during
>> EL3 mode, this driver model provide user the high level access to system register and abstract user from low level access.
>>
>> The base address of system manager can be retrieved using DT framework through the System Manager driver.
>>
>> Signed-off-by: Tien Fong Chee <tien.fong.chee@altera.com>
>> Signed-off-by: Boon Khai Ng <boon.khai.ng@altera.com>
>>
>> ---
>>
>> v1->v2
>> - Implement system manager driver to move towards DT probing
>> ---
>>   arch/arm/mach-socfpga/Makefile                |   3 +-
>>   arch/arm/mach-socfpga/altera-sysmgr.c         | 113 ++++++++++++++++
>>   .../mach-socfpga/include/mach/altera-sysmgr.h |  16 +++
>>   arch/arm/mach-socfpga/include/mach/misc.h     |   2 +
>>   .../include/mach/system_manager_soc64.h       | 128 ++++++++++++------
>>   arch/arm/mach-socfpga/misc.c                  |  18 ++-
>>   board/intel/agilex5-socdk/Makefile            |   7 +
>>   board/intel/agilex5-socdk/socfpga.c           |  12 ++
>>   configs/socfpga_agilex5_defconfig             |   1 +
>>   9 files changed, 250 insertions(+), 50 deletions(-)  create mode 100644 arch/arm/mach-socfpga/altera-sysmgr.c
>>   create mode 100644 arch/arm/mach-socfpga/include/mach/altera-sysmgr.h
>>   create mode 100644 board/intel/agilex5-socdk/Makefile
>>   create mode 100644 board/intel/agilex5-socdk/socfpga.c
>>
>> [...]
>>
>> Reviewed-by: Tien Fong Chee <tien.fong.chee@intel.com>
>>
>> Best regards,
>> Tien Fong
> This very likely broke all targets except for the agilex5. It definitely
> broke the cyclone5.
>
> diff --git a/arch/arm/mach-socfpga/misc.c b/arch/arm/mach-socfpga/misc.c
> index 9d464307665..e0ed1b8e954 100644
> --- a/arch/arm/mach-socfpga/misc.c
> +++ b/arch/arm/mach-socfpga/misc.c
> @@ -248,6 +248,12 @@ void socfpga_get_managers_addr(void)
>          if (ret)
>                  hang();
>
> +#ifndef CONFIG_TARGET_SOCFPGA_AGILEX
> +       ret = socfpga_get_base_addr("altr,sys-mgr", &socfpga_sysmgr_base);
> +       if (ret)
> +               hang();
> +#endif
> +
>   #ifdef CONFIG_TARGET_SOCFPGA_AGILEX
>          ret = socfpga_get_base_addr("intel,agilex-clkmgr",
>                                      &socfpga_clkmgr_base);
>
> Arent't you testing for older designs anymore?


You are correct , the patch as-is focuses on Agilex5 and does not fully 
account for older platforms like Cyclone5. Our initial plan assumed 
users would follow the Altera official release repo at 
https://github.com/altera-fpga/u-boot-socfpga , where we are gradually 
migrating platform devices, including Agilex, Agilex7M, and Agilex5 to 
the driver model stage by stage.

To clarify, as of today, the platform devices for Agilex, Agilex7M, and 
Agilex5 have already been migrated to the driver model. Older platforms 
like Cyclone5 still follow the previous non-driver model path.

We are now aware that some users are still using mainline U-Boot. To 
address this, we will update mainline to ensure that existing platforms, 
including Cyclone5, continue to work as before while maintaining support 
for the newly migrated Agilex platforms.

We appreciate your patience and will make sure mainline remains 
functional for all currently supported platforms during this staged 
migration.

Thanks,
Tien Fong


>
>
