Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B835CCD1AB
	for <u-boot@archiver.kernel.org>; Wed, 22 Oct 2025 14:07:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AA3A88323A;
	Wed, 22 Oct 2025 16:06:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="kdQeuuOd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAB558334F; Wed, 22 Oct 2025 16:06:58 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azlp170100005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c005::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5E90682B20
 for <u-boot@lists.denx.de>; Wed, 22 Oct 2025 16:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tff2z1YiLbYyiFKTsx9bqyHu3yKN8fRlbp3+vMgT4kSYs3GEgB+j2L5j22WZb0N7l/P5TPZVJuirUULY7SRE6azCjz0Z7Pc4PvIvhHkAIGDPoMNDrpRWLrJJ6JbfibV+ZkdvIHM2dwr8gZcK0tVNcDdeltzrk2NVghi+cp5cXADtEuI8gIVuooEm5+Bql8El78qZe0XI8JRS2vdZvNHPU3BqVgczrhPIJx3+BaFihJR83jJPhdSB4DMey/m/aJ2u1HVGljtD3BlZfJJLXb1BrE3BeXYEz17Jg0R1AFMj9mcIbYSbb9s3vhUZgcOjCpv+lP3k4HlqPZej9RniloP7+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CSOlQWV745tKr9wmF3Sox/aYaySGrjpFfHu6fW6wC/k=;
 b=YFP95MwpQzYLiWwSez2LUM5UXhYD93Ai+gt9oF/j2WRolylD5JA3xRBy0GhZV9rvSBCg88d0TexOAEJtP+YE0yA2hK6UzJRzdGrSo6TXHqYkcm8dC8ZJL9JlwRUBEofEy0ok22d9MlZpPk6iqry5cPRkQnOItCqBBbWpxJfEdaR8OC+qKH/CWj/UutnFf7mHFggdkZHohrJQ4mUUwvUFXLjKh92nUoEAlv+WcTLX2/a1anQm6y/L7IWqyHpIg7xNBfxmZZ05arXw/UVsUyseT+2asePT1SqALzb2DS5wduZQLcusa3RmPHUL+HTc+GoWXHL177dXqd01uGXN5828fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CSOlQWV745tKr9wmF3Sox/aYaySGrjpFfHu6fW6wC/k=;
 b=kdQeuuOdYHpmA4v1yYJH6QNR9aRIfEI9MclMyUXg9DSmsbx4JE5m9GrNYVttWGrSRoiZkRaS9nFFEx2enOO1NHJXxqKtFs2idplVVhZMUzoM6xT2lBXmFbYX4ABT4WlegQ1wkV8myWx4TvV1fEq5kPKZhhW5SRytY7v1MnwJ1+9YvYC627C0xDoPsJDOgLB24bAqZvDroP6G4ZR+x20x4Fag/U75eeM+MqH12MHfYtx1Vf3vPeWCo7txvbANAqPlUJCR6mIxlY+BJAPZIkGKZV/R/k2vdgA3+Y6ziV9a4rDau+6bNmzd5rHJ5Pd1uMKTEEtu4XU3ZddEjvTA1Dq9bQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by SJ0PR03MB5487.namprd03.prod.outlook.com (2603:10b6:a03:284::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 14:06:52 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Wed, 22 Oct 2025
 14:06:52 +0000
Message-ID: <3ff806c7-74f3-4eb0-b994-f65449d28b9c@altera.com>
Date: Wed, 22 Oct 2025 19:36:40 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sd: Handle UHS-I voltage signaling without power
 cycle
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, trini@konsulko.com, peng.fan@nxp.com,
 jh80.chung@samsung.com, marex@denx.de, tien.fong.chee@altera.com
References: <20251021204526.22701-1-tanmay.kathpalia@altera.com>
 <20251022031613.GB15054@nxa18884-linux.ap.freescale.net>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <20251022031613.GB15054@nxa18884-linux.ap.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|SJ0PR03MB5487:EE_
X-MS-Office365-Filtering-Correlation-Id: 23d2dde2-94f9-4b03-7d08-08de11743e10
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a1JaSThTQTUxaTJIMnpDZU1nKzJwSUw0VFhja2YrczVPVDdvS0ZvU3k2UW12?=
 =?utf-8?B?RVVIU3F3eXZUZ1pESHhZVURkbjJaRkM4N3ZGYmRWQlljVmUrbkNvditjSHJH?=
 =?utf-8?B?d0JEVTZqKzg0dWhEa0d1N1hJY0F6RDVHdmJXbVBJbzdxZjNXY3BUWWJBWm5G?=
 =?utf-8?B?dlB2M0RsbWZLQkZxcVUzelV5WGZVcFNtc0kzL20rK2lTZDUvNVdYam1CbExL?=
 =?utf-8?B?NmNYeGx3cHphdllOZlRGTHBETEd3TFFZNWdQL0U5eVNPN2FsU2VxaWZtdnNk?=
 =?utf-8?B?dFNVTkxJd3Y1NThuY2RQcElGYUJrcGlCU3VPaDVwMHNwQ09jc1NwYzQvL2xw?=
 =?utf-8?B?dlpuK282aU1SUWxWRDNXQlZ1UFNLbFB6SEswRXdHbDhzbUxtb2xGdC9BNWpo?=
 =?utf-8?B?bHRoVlNkamF0WmJncjl1UU8zaDJSSGpDREh1aFg3dDdPQVcySGtLUERnOUc1?=
 =?utf-8?B?OFBoZkxnZ1VNald6QVNsc2x6VDBzcHcvMm5mWjdhbUFQM0N4TDREdTdwcDh2?=
 =?utf-8?B?Zm9jaHFDRE52Y052ZUxBeGVHbXp3cysvdFQ1YUM3SDhiSXVMTjBPWmZibHBB?=
 =?utf-8?B?YVFBdFJBcTVpK2JPYVd4c2szbysrb2NxN1dIRHNnVWVGRGRyVzVtaE42YTE4?=
 =?utf-8?B?M2ZEU2NWZnBrK3RVZUFiaWFVTmREQ2ZoYzh2RlpwR1lNa2NSZnFFdXp4MWQ2?=
 =?utf-8?B?ZXJnM3BNL2lQbjFWMzVJaklqcUlBaDEyNWJMckRnZFFVYzhSMVhJbWNaNzVp?=
 =?utf-8?B?L0dsZElKOHBnYlp4NGVoTGUrZUYyb1ZMRlRVUHpLTE56N0NING10bTB3ajl3?=
 =?utf-8?B?TFE3VnFWVlIzQnRBdFpnTGhLUG9rNlRaanlmTkxtSGN0UVdqY3RQSUZoSzFD?=
 =?utf-8?B?Q2UrV2RWSkJKTmNuZ0ZRT0NRVzRqV3dYcVVhODM5enZPTUFnbjNSUk1SNGVI?=
 =?utf-8?B?bVVqQmF3R3dubjBOSk5GWFlnWTVERlVPdHg2NzFQaHNwNExyRkR4WlV3bWNk?=
 =?utf-8?B?d3V5azdpMFU1MnlwQ2c3aHBXTnZPUVRmN1BOZzdBRFpvSFRTYU4rT1lOS3gv?=
 =?utf-8?B?UVJVblM2WGx1S0kvWkpKVk5YcXBXamlXaFhpU1YwblczZGl3QWN4cVY5Qmwv?=
 =?utf-8?B?VHRzWmU0ejNGZTU0S2diRERkYzMwVDFXODFBcm1scmlPRW1ybUltQ1FjdzdL?=
 =?utf-8?B?QVNBc1BDekxTU3ZYYUVzYlVIT1JkUG1kTmpuTEtocklvVjMzbDBvYkNFWGkr?=
 =?utf-8?B?SnRNaEVkNnZuOVdBbUwxdGRBQnl0Y1hSdjlFOWhWRnk5Tk1NWmEvZ0R4R1d1?=
 =?utf-8?B?TStJdlBFY2xEemdibFJaN0lWQVlNRHZ1QjZuUkRjM0pXblVvOEJid1NQbkIr?=
 =?utf-8?B?SUwreng0WkMzeVJiOEtDaUJSZWRUWGM1OW1RZHRiM1Q1L3l4NTMxUmwxSDNP?=
 =?utf-8?B?N0VKbjAzNDY4TmtzVVlqamhacSt5eVI0MGdhZFdlSlpDTlZTTW5rR0xSaEZq?=
 =?utf-8?B?WHBhM3ZyaGRDVWJBUGJsT0pHUUlwRmV5djRRT0hWM2d5QTNBZ0ZhWm0rT2hW?=
 =?utf-8?B?eUJIaDRlTlBLTXRJK0pCN2dMQmhYZlpON1NMc1FMdU55MVU2bXZQNitUbHNS?=
 =?utf-8?B?SnVHQ0lGU043bytGdE4zM01nZkozc3ROQS9VUURnem9mN0JYSXB3dGQ4cFJ4?=
 =?utf-8?B?OWN2MThHSGRaNHlvZm0rKzVseW8xaXMwY3NLR0ZDelNQQTd4VGRjbDNBRlVz?=
 =?utf-8?B?YkR5UUpLcG1tQ1Z6OTN5cjBPQjBLdUg5Wk11K0Y2Umg5NzFCWGNZZWJQTXJo?=
 =?utf-8?B?WXNxK1kzS29uMmE2NkU4ZXFGR09kSytralNROW9ISWJjRmJWWjVEeEVob21Z?=
 =?utf-8?B?RzVJczZvU0c4TmhQcTFYSjBQbHJZTnQxd1pKRW5xRDR5MGJpSE9ENTRpbmpH?=
 =?utf-8?Q?aIcIEzZuB0P5R07sa8wmqLRoZxkgcZ1Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MHJYZnRSSjU4Q3daQWJUV3h6V0JzZUpLcVVyQ3o0bHFlTlRqcVY1bzRrWm1R?=
 =?utf-8?B?QXBUZWM5cFZSTDREYjEyQ2pZenNXbGZiNW9pemVZMW1uam01Y1N4WmhzOEgy?=
 =?utf-8?B?QXM0NXY5WkY5TTdDSUp2WVppZnJiY3dpbVR6a0wzSElEbDY4VGUxRC9jTUp1?=
 =?utf-8?B?L2FFdkt5Z2NWeFhGMUd3alFuSGpvRzVWZ2JjUVE4anVPcVNRTWtBbzQvS0Vh?=
 =?utf-8?B?b25tQVp5Z21abnFGZTRmekt5L3E2YU10ZlZNQmxCRVBGL1Vxc0NrRXhFRHMr?=
 =?utf-8?B?cW9XZXBjZ0NrTytuckNJU3pvWlg5cXNHUGY5dEtuWFREYmhHQmV6Z1FFTiti?=
 =?utf-8?B?ZU8zREhwU2hSNzU5NVVScTVHTW80V2VFU1BDdGpzTzFWRGhlU1VkSDFWVDU1?=
 =?utf-8?B?bjBxam1vMmdMNG9jc3BRby9oczhyOGtQNFlqVUtEMkZKMG8ya0h6dE1SK2cz?=
 =?utf-8?B?UlJNK0RrR3diYVlrbHRUOUJ6Q01lN0wrZWd3VjBJVkhaZlludWZjL0FwNVNC?=
 =?utf-8?B?eFMyREltK28vdTMvT2hFajk5WmV1V01XWHAwZVR0bm5PYTBvMHp2U3d3ZTJv?=
 =?utf-8?B?K1h6cGl5M3g4VFRnMlVVZWFFZ2JFczhMVHNJdjZQZi9jTWpmSFl1cFgzN2FS?=
 =?utf-8?B?SGMya0lSc3pjMUxydzIxbWRQNEpEdEx6VkhuOEFsR25SMTNQdGxDT1pxejlI?=
 =?utf-8?B?aWxkeDhja0EydUF6bWRDbWc5dGhpYTFPcnkySGQxL0VxWmRZVDFSWjFzN3lW?=
 =?utf-8?B?aWtKZElNUjA5NkpYNW9wNWZZMVZGRXE0aHBVK0lndXdBeGt0eE9jRjBDN2R0?=
 =?utf-8?B?OXVXSkg2Nkx0ZXVoUXM4YktDSWEyZHpVZ01lMHlZUzdwUUxjaVF1Y3RLMWRL?=
 =?utf-8?B?SFRPb0tBck1GMTVjTURaWTZWV2pURk5SU2pFVmcxOFRiWjU3eFV3UUNaWWtU?=
 =?utf-8?B?a1YzQUxsdGUrTlRYMzRZeFg2SGpORDhmT2hwMHlRNHRaUm5qRjdqUE9nV29v?=
 =?utf-8?B?UThCRW84UGJVelNSK1pKL3FlSnF2RzNUcCs2U044MVNpQk9GdFBUcDluUWNB?=
 =?utf-8?B?Z2xvbUx2eGtGSFlqMDlxbVcrTjlLYURyQUYyNE5VRkdGZUdkc3N1Ky9nRk56?=
 =?utf-8?B?Z0hEL0NVZk9CVkl2L2VFQWw2U3F2TEdzZEpWRXkxb2gxWFliRkxUR0s1OEJS?=
 =?utf-8?B?Umh5ZlZjK0d4elNkcU0ydGhuOU1VYlRzTTVseVFlNU9RSllUdUluZjk4bHhy?=
 =?utf-8?B?b2UxRnhTWkNzZWc0NjNkeEFiZndlTWhTQTI0alFsTTd4R01XQ3RoTUg2R0hn?=
 =?utf-8?B?Vjl2aDltNmR5c2JJQWZXaHIvaFMvbWh3SFY1blhmVkw1NVF5WDJidDBURnNq?=
 =?utf-8?B?NlZ6dDdZckpqSjl2cERSZFJ3VVJhd3dwSUJ0bVNjT0t6bGkzVWFBdStRSDNt?=
 =?utf-8?B?Sk5kZGlQRzZ4QUFodWYyV3RCT1QyNWhpOUtxYnZUUzQvQWltZkVKSmNPaEp1?=
 =?utf-8?B?VkRsRkozS3M1RWNGYWtrRXVWWndRd2w1TW9xOG9VajVwVG9GYVZRbjl2Nk8x?=
 =?utf-8?B?K3R6L05ZSi95Mjh5cm9tVG1WU0JKeVNqWFRQMVhOS09WRlgydTdLemcrYlNm?=
 =?utf-8?B?N0xzOFpVMmN0MTVHdGFYU2VPRGVTSVd4S0Y5Qzk2bmVnME52dEVOcWNZSm1y?=
 =?utf-8?B?ZFMzSEFuMERldlU5ZVkrRlk1dlZvQWJ6OTUzN1MrK3dsaytrT0xESyt6Zzhv?=
 =?utf-8?B?aG9vS1dleFkyNVJuRFVBcThsc2orZVZsK3V2dmc0emJTeEV0eEd0VWtpSEE3?=
 =?utf-8?B?L3VMbVZXdDNxaE9QbndYaHNCeDlhT2VFT3VPQXZ6N3hJbFVLNlgyTHI3eEE4?=
 =?utf-8?B?WENNQ0g2eGtUL0ZIUnZlMzJiUmdWaFJaZkkrSi80SlF6RDJ6YmtwcWxJTnlh?=
 =?utf-8?B?cVZrZjdTSUJDM2t3OEwwd3JNZnFhQUJGQnBXTElnTjFRWVRNWTZVMWJzVC9B?=
 =?utf-8?B?Qzd3Q2puMXNtbFFXR0tjWlBDV3FRQ3RVblJpMmVYQ1BRV3pXUC9sZjQrbks3?=
 =?utf-8?B?VTJpZHYvdEhmeDE3N0lkRzNzZDRxa3ltQVQ5azBRaC85VjNXdDJVeXc2U0V1?=
 =?utf-8?B?VG9xTFVJdk0rNHhQU2x1TzNZVDNJUEFaZTF0a1E2N2JYcnAyOERueU9PazJv?=
 =?utf-8?B?N2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23d2dde2-94f9-4b03-7d08-08de11743e10
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 14:06:52.2068 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c6EsR1FCkb8Lrb65zg35aCNTjSxlutsyyBUhfgFBigaV45PXwv2cMzgvS/ryj+Lqro2OPVo2U++IB6zsecC8s/Xty0OGNV06uUEyD48xQ7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5487
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

Hi Peng,

Thank you for your feedback.

On 10/22/2025 8:46 AM, Peng Fan wrote:
> Hi Tanmay,
> 
> On Tue, Oct 21, 2025 at 01:45:26PM -0700, Tanmay Kathpalia wrote:
>> Some boards have SD card connectors where the power rail cannot be switched
>> off by the driver. However there are various circumstances when a card
>> might be re-initialized, such as after system resume, warm re-boot, or
>> error handling. However, a UHS card will continue to use 1.8V signaling
>> unless it is power cycled.
>>
>> If the card has not been power cycled, it may still be using 1.8V
>> signaling. According to the SD spec., the Bus Speed Mode (function group 1)
>> bits 2 to 4 are zero if the card is initialized at 3.3V signal level. Thus
>> they can be used to determine if the card has already switched to 1.8V
>> signaling. Detect that situation and try to initialize a UHS-I (1.8V)
>> transfer mode.
> 
> Actually a power cycle or reset is required to make sure SD card to work
> correctly. Some SD cards may work in your case, some SD cards might not work,
> without a power cycle or reset.
> 
> Thanks,
> Peng
> 


According to the SD specification for the Switch Function command (CMD6):

"If the card is initialized in 3.3V signal level, Default Speed and High 
Speed are assigned to function 0 and 1. Then support bits of function 2 
to 4 (SDR50, SDR104 and DDR50) are set to 0. If the card is initialized 
in 1.8V signal level, SDR and DDR modes are assigned from function 0 to 
function 4."

This allows the host to detect if the card is already operating at 1.8V 
signaling and proceed accordingly.

I have tested this approach with multiple SD cards from different 
vendors and capacities, including:

- Kingston Canvas Select Plus 16GB SDR104
- Samsung EVO Select 128GB SDR104
- Samsung Evo Plus 128GB SDR104

All of these cards worked reliably in my tests.

For further reference, similar discussions and solutions have been 
proposed in the Linux community:

https://lore.kernel.org/linux-mmc/a367a679-28f7-898a-c043-27df8c9c9aba@intel.com/
https://lore.kernel.org/linux-mmc/1506328144-13666-1-git-send-email-adrian.hunter@intel.com/

Thanks,
Tanmay
