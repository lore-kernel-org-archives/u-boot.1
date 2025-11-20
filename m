Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C09DCF8860
	for <u-boot@archiver.kernel.org>; Thu, 20 Nov 2025 14:50:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D2E1E83F1F;
	Thu, 20 Nov 2025 15:50:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="DX7+3CEt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 799F98405F; Thu, 20 Nov 2025 15:50:27 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D76F583EAF
 for <u-boot@lists.denx.de>; Thu, 20 Nov 2025 15:50:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxTYC6IY4K8wUOKe2GpDvxAynqSB5gKzN67Zk9vaDlWbS5wrxmHSmK8M9Pe0juFw0Mzu2jbL+xyn5SPFGZZJChObtragPv4nCPZjb/v7jRqAGekLnrWjJmNXkZaotgurtGC7KzQUvAsV2HA1ng1NzkZl/xJbk6Bo4cy+w+pgp6JxTGJG/u4bCDXxQwAhhzHiZp6Ql16gOddjpXvgThx4zuF5u2kMDK97HcoPSnztoHNLnGUtadtLhoPi3R6+He5iBDDy1MY6vmKiO0ObKYk8zejVytlzZ5dU3JGkP10n55Hr1CH1tjHHqbdS5ZYObcZKKT5qX18Eduv1HZREICY6uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mb6nIlMLg9OZSJBgvh1gsn8vTPWs7qjCB89bXXBenI=;
 b=jatluynJ8BfFJJGtgWQ5ogJBoG8IoJL3T9+MIndBWzgMxy5kDXwty9PZPGK/ZypgI6hjugPMUv0NvV1jpAMGL6QAAsWcHvto72pOWifGAza3AnoHK4ls7h5dWb5gYpgPMfPMsEmL3nlR3kodA9m/PaBqIt421f9wgz1PEEWCrdzYzb5Fm+fO8MPchRSVhiOfaU0nhQhrufCrRdAzVBUsV2biv57PHm7eoL4KJBjArvJyLrmvuq+reAN5Fm5NAYQcz20AkuI7mbnqr5RTnIfRVUgJ5QfE5J1L2EU7TWwp703NI0plgdEANqpdV1o/H6YPPKfR0QzuEypGIsH79L0ttw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mb6nIlMLg9OZSJBgvh1gsn8vTPWs7qjCB89bXXBenI=;
 b=DX7+3CEtGLHkWlvnC/h6WqqxZPQeyf5mxS1A+ZNSd/b+BYmud7bq+ZePS/E66Y4PMZaYvqG7fLxckoDrAfEdsOPC51ZsFPCYeovqHacsQ+f7RWpt+KPJ68fOc7hK3elJMsv9Zg2JC1UDJpcWrlsGlZ1b66/5zZ2vXMwrKKZzqCPgbUh5p3vrlLMZmR46ycKmN1JlzdArBT3472Cj0Gziw0CP1L9HU8c5rfTlF0lnM183tQd32NX0cqVj76SsJKdMVUHKWUVr1VbQoCSwLR4czQMyvOVTWl/jQrLBkeyQrrFuUUGohN3C/HsxF+ppZchDqZYkJ2X00tPt08duap95xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS7PR03MB5654.namprd03.prod.outlook.com (2603:10b6:5:2c1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 14:50:20 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9343.011; Thu, 20 Nov 2025
 14:50:20 +0000
Message-ID: <459daefa-1d56-4591-a922-af40934db942@altera.com>
Date: Thu, 20 Nov 2025 20:20:10 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/8] mmc: sdhci-cadence6: Add DLL master control and
 improve tuning reliability
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, peng.fan@nxp.com, jh80.chung@samsung.com,
 trini@konsulko.com, marex@denx.de, tien.fong.chee@altera.com,
 balsundar.ponnusamy@altera.com
References: <20251110173737.24545-1-tanmay.kathpalia@altera.com>
 <20251110173737.24545-9-tanmay.kathpalia@altera.com>
 <aRwRKx7CILf0y1qr@nxa18884-linux>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <aRwRKx7CILf0y1qr@nxa18884-linux>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0017.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::12) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS7PR03MB5654:EE_
X-MS-Office365-Filtering-Correlation-Id: ac236e6f-9e54-4b7a-22e5-08de28442095
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTVPTll5UnNxWnJ6NnUrczYyczMrQnNXM1BzYmNwYU5WWE1tN2ZyMG5qNFVo?=
 =?utf-8?B?SWNyUUM3alhHZFBVZVJwQlNoaVpkOE8zL2tBUjJGbzgzbzJDMnYvR3NqVC9u?=
 =?utf-8?B?eVZud0ZJb2U4d1c0Z1U5WUVCa0dPcVRPVkk3WjNQamlEVHJKLzlDZXljaU9p?=
 =?utf-8?B?dmdpMm9CLzN0UFhDNG42d0hLQStTZGVPSlNmbDNLZ1dUbXFOSnNpVG5TaU9p?=
 =?utf-8?B?MDFyZnE0V1hybHcvUHgvbFNhMUFFUDRVaVh2UFNpUVd0OXdRWkRoeGFxVGFt?=
 =?utf-8?B?b0E2Y2twaElILzd0THVERzhKcjRsbXVDVm5MRGthV0lSZjRvQjBWUUJkZ25P?=
 =?utf-8?B?V1lJR2ZPTllHZVV6WTNYWlBuOHZWdjVZT2VCUEFFaVhpR3RsZ1F5Z09qTnlQ?=
 =?utf-8?B?RHdoSmJEemFLZm9ZSnRqRWdVZ2c3M3ZKNmRReXYvNHRDTjNTbkhmbDBwdVd4?=
 =?utf-8?B?YkxsRFlHekJaTXduVHBTZHV2eTEzWmZrb3UxZkg1YWlsSzFNK2swR0tiVmZU?=
 =?utf-8?B?Tm1hOURNYTYxdC96STB4Mjk5MHZOWE1Sa3lTK0daS0JhVGxoekNxUXF5N0VS?=
 =?utf-8?B?K0pWRzRYa3lRU0hWV2dRV2t6S0V1SFo4WldFMC9lRDV3b1RhVTNDMnZud2x1?=
 =?utf-8?B?T0lLWDNaaTduRlplMURHWXZwTWp5YTR1ejlJdTZROGpBaW8vbVJiWXNkRUxz?=
 =?utf-8?B?ZEswY09veC9ySExKS2ZLdFgzMDZMOW5FVDd1bkx4T1pSM2REZVNtVitoODFs?=
 =?utf-8?B?WUxGdEhVWnhrZHBDSWdWRDhVcVJKeXlaVys4R2hBUzFjQmZKalhrV1lCWE02?=
 =?utf-8?B?NHd3YXVlNzJWWEVWemp3U0drd0xXcXdjRlNRTkF3eHlGOFYzbCsxMDhRYXNX?=
 =?utf-8?B?ZEwrSmo2L2JHV2U2RE4rUWIxUnlLdmFQekgyazNlV3hSMG9PWVZ4T291YytJ?=
 =?utf-8?B?aUd1dmdGUGMyWHJSWmhZbEppcms5SHFvWVNlSS9BYUNhUG0zVFp4TVhRWThN?=
 =?utf-8?B?YitTQnZNVGJrUXNzR2FOeUFjbGtGVisxc2Z3cVZBdFY2OXZWa0dxMVpXOElt?=
 =?utf-8?B?b0swdHp3eVFXMFJ4bEpUbTE0WWFPVy9xazVaYUo5Szk1ZXlnZXZCK3JiRHBt?=
 =?utf-8?B?TjQwTmpsaHpxZVJ2dmdMUVFsTTU5VlgwWmVuM3lubDNzTVMyeDlvaVIwL28y?=
 =?utf-8?B?N2x6WmZhZHgzSjRTVTJQQ0djNU0xQ1ZEbmhsMDZ0a1ovTlFOY25Yc1kyREVF?=
 =?utf-8?B?T2hPZXNZT2UzSGswTkc0cmkxMnA0ZWk1V1B3UEY4Mm5FWlIrQldVSlpkcHZG?=
 =?utf-8?B?bTVmN3RoNi8rZVJaUkJobThFRTBVQzVLdXhUYWpwaDFaMnk1UWp3czFUREox?=
 =?utf-8?B?Vm1hWnk3YVk1aXlxVE1wVzFtelI1aG5oSWM3TURsaDhCY3ZQeVVZbEZsWVp5?=
 =?utf-8?B?ZE1nMk5wRHVWVS8zcGFMY29FUFlmWnFZUnZXbFRISEsycFFFQ3pnOHcvbVdx?=
 =?utf-8?B?TWZ3VmVrNXJuYkVWNjR0RDVYOXdpaUFJZ0ZEeE5OcThubXVBeDRQYWhWTHhN?=
 =?utf-8?B?WjI2emllbEpEVnp0ZVhGNXI0TTArWStyQ3ByUXVUMEMxZGllbGtsMWlPR25i?=
 =?utf-8?B?a1ZrN3Jod3RHVm1jbGFOVzdITTZSendLYyt3TWlHakt5NmlCTnY1cU9PbDZ2?=
 =?utf-8?B?dGY4Ym1WNUszdVd3amNab1N5RnVjQXpJc2pnVFU3RGdERWlrdGRvM0NKUUJw?=
 =?utf-8?B?S0JLZ0REb1VTRXhndEFwRXc4ZjNTQmZycjJzRDhVYXNDL1NmUW81aWJQaHFt?=
 =?utf-8?B?TVB4elpjMTJxS3R6eVJScTJiK3JaK3dUQk1kNFd0VUtmQzV1a2JLMkhnekRQ?=
 =?utf-8?B?QVYwdmhSdW10cjJUWmRtTCtQWWJEbkJaVUVjaThJUWtlVWpvK0pKS2RZVHlw?=
 =?utf-8?Q?FDt8r0zhXmbmfcZlSoSdYhfMpehpI6tw?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Q2VqZm5kWTVNanlFWncvVGM4VlRMbG05amFRbnJHTzB5a2VZNlVsVGJNYlNG?=
 =?utf-8?B?ZHIzMVJCODFGaGRyL0RPdUlrMldKZTNSQmM5czFxWEl5Z2VwakdmRVY1V09t?=
 =?utf-8?B?aExXZHdlaGx2cWpRT1kxK0F4cWZXT1MxWU56Nk9xenorbzd3WlRQam9sUHZB?=
 =?utf-8?B?S2V0Q1h6Zjc1dXBQdnpsY3BhZUh6SFlWTEp2TUVFODYzSjZzc0NoMW5mYXo2?=
 =?utf-8?B?L01yNzdxcmNuRFNhSzVBMk9IQlhET2pkL2dET2plWXpxWmU1MTc3N0daMmhZ?=
 =?utf-8?B?NXB6d0psVjZsbFRmSHppeW1HQ1ZSMGFkNlk1cCs3RmkwUEMxNGZqQi9hTzlj?=
 =?utf-8?B?NWFPNmxJYzl2cUtadzljVFJWMW1NUS9ydFV4TExHYS9BZGx0SEd1MFNaQXdG?=
 =?utf-8?B?czZwejhpQ0dlWWJoYW4rZ3Jta2dRMnhrSU42ZFpJaDh3eHBwcWxoblJFcW5D?=
 =?utf-8?B?cDBvdjhva0lCeUwzMWFRRkN5WlhFQnVERFQveGZTUkF6K1BueXBURUdHcUpY?=
 =?utf-8?B?SE1Ja1FSWFIrc3hEUHBtR3lMTzl1MlBLTXV1bFphTk9IN3VyaC90ZDRpN2Ey?=
 =?utf-8?B?RWo0QmExVmlrbXB5ZUEyVFpIZnBGZjF0WFNrc3JMVUkwMHNjUFg3blo3aEtZ?=
 =?utf-8?B?MEtLczhDZkVXMnV6UUpxeG5CVUN1QzFRQU9iQVk3RHhLdGljS1dOMTJybjhj?=
 =?utf-8?B?d3l3WHpxOVdxcFhSeEltdkpBMVZzSHViTVBVRlRuNHRTMUZDclA1R1Ewc2hr?=
 =?utf-8?B?RWZ3K2puZlh3UGpIazBjRHF4RkNXZDNOa3JPbnNNMlhXenVCTVRXV0NvcjZM?=
 =?utf-8?B?MjZaa0VyK2hMSzVTQ3Z1eHpKaFZkYyt3YVVrd3JEeDhoTzNhRUlSalFSM0o1?=
 =?utf-8?B?SXlyQmZvVjhiTWowdE8wTFE0YmphTmNOWk9ya1JRSHVqcXNMMG1iT1A1QXVC?=
 =?utf-8?B?RWM1dm54QzJtRkkvWkdkUVpqVENiZzdlQzNwTDZWUzE0WEpRU2hlTXBQSnVO?=
 =?utf-8?B?dVcvaHlVMmxoQjh4NTBGc1ErWGExMkROYjBpMHh4bTdTK2wyWnI2WmlZeVZi?=
 =?utf-8?B?SURxbEJBVzA3QVRianFsYk5RRW5pZ01HS2Z5cVlFdWFHQ2x6QTNyOUdlYmo3?=
 =?utf-8?B?YzRBQ0kyMnhHQjJXN1VqbFZjUDYxYVNhRzcvTUJKSmtzSWhtZmtQWjczVnh0?=
 =?utf-8?B?MExOalNsS2J1dmdwZE9wZTBVOFVteHU0N2ZMdDY1akVuV0crQldIY29ubVNW?=
 =?utf-8?B?VklHSXZLajI1ZG1hZFJDNzVhRTdtNTV1VkhFLys2V1lEWG5UdVF0cS9jQWxs?=
 =?utf-8?B?Mml6VnZseTlQdVYzeDVQQjBobXVYMEJxSk1PTUFXNmc0TXZIbFkzbC90M1JG?=
 =?utf-8?B?R2liaFRHZ0dxK0RzVS8yY0Y5SGFMdDkyNVlObVg5Z3lSMks5ejdLV3NxaXNp?=
 =?utf-8?B?MFpDYXhKK3k4ZDZzaHlJRFR5VnV5aDM1cG1IRS8rMDV4eitQcTFoWEQ1NCtQ?=
 =?utf-8?B?aWNhK09qWkVwNDZYNVdMeEE5UjdXT3IwZU92SmtNL2VMcFBXMjBSSURHNDV2?=
 =?utf-8?B?ZXRJQ25vblB2R1NUV1Q3dUlQRkNYUWxib0NpclFFYUdsYnBlbVBnclBReTVJ?=
 =?utf-8?B?SnE5aUZVbjRnOXpWb1NNcHR2aFdWQ1NRU0FoTFBpdGtwOFVXc00zd0k3Qko0?=
 =?utf-8?B?MGI0RlhDc2VUcHA4S0tEcTRzMXEzVmtMaFNxMHFFanFhem92R0RPSy9EVlk3?=
 =?utf-8?B?aWJBRUI2c3hNWDYwb1FjSVo1RUxQeVI3Z0hhQW94aG9TdjlFelhYTkZRSFZ1?=
 =?utf-8?B?eTF4eUZBZkxOZldEeEtwUlVSRVBMdVdRWXZqdTdwazcvRUl2VlZWalYvajVa?=
 =?utf-8?B?ZkVuWGt0QkVLbUlpVE1WdXJWOTUrbjh6RkZNbWxFaEh1Mk4wdlUwbWtFTE5F?=
 =?utf-8?B?MXNBczMxdXZpRUNVS2VPV0NvUzk0bGhYY0g5bjFKWWEwRUJoR0hWNDd1a202?=
 =?utf-8?B?YmE5WldrbDlSV3VWK0gvRmJOMjZ2LzlFVG5DY2JwY2pPdWRNZ1ZxdWFNY2hv?=
 =?utf-8?B?eCtqTE43aEdCSElhYThnaVc1Y0l0dElyczFoSE1kVlNDa3pEcjhkQndDRmtV?=
 =?utf-8?B?cjBxZys4a1Q3RTM0RDA3dGhuSlFsY0xuNTVpbnZVcWpQQjhUV2JGQjJvbkVx?=
 =?utf-8?B?bnc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac236e6f-9e54-4b7a-22e5-08de28442095
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 14:50:20.6687 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeHsANwwlIGdMrd2BQUrNspxHXKT0wtr7ko81HLhxUq7Ut8MwseBCx76iOrEFIhDB7rY0tS/z0UHcgULnABGc1SOK9q69iJNCGFTJFizpjc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB5654
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



On 11/18/2025 11:54 AM, Peng Fan wrote:
> On Mon, Nov 10, 2025 at 09:37:37AM -0800, Tanmay Kathpalia wrote:
>> - Add support for configuring the PHY DLL master control register for all
>>   SD/eMMC timing modes (DS, HS, SDR, DDR, HS200, HS400) by extending the
>>   PHY configuration arrays and writing the value during PHY adjustment.
>> - Fix tuning reliability by toggling the DLL reset before and after
>>   updating the PHY_DLL_SLAVE_CTRL_REG_ADDR register.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> Reviewed-by: Balsundar Ponnusamy <balsundar.ponnusamy@altera.com>
>> ---
>> drivers/mmc/sdhci-cadence6.c | 21 ++++++++++++++++++++-
>> 1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/sdhci-cadence6.c b/drivers/mmc/sdhci-cadence6.c
>> index d9467293807..91a245aa490 100644
>> --- a/drivers/mmc/sdhci-cadence6.c
>> +++ b/drivers/mmc/sdhci-cadence6.c
>> @@ -58,7 +58,7 @@
>> #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY	GENMASK(31, 24)
>> #define PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY		GENMASK(7, 0)
>>
>> -#define SDHCI_CDNS6_PHY_CFG_NUM		4
>> +#define SDHCI_CDNS6_PHY_CFG_NUM		5
>> #define SDHCI_CDNS6_CTRL_CFG_NUM	4
>>
>> struct sdhci_cdns6_phy_cfg {
>> @@ -76,6 +76,7 @@ static struct sdhci_cdns6_phy_cfg sd_ds_phy_cfgs[] = {
>> 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-ds", 0x01A00040, },
>> 	{ "cdns,phy-dll-slave-ctrl-sd-ds", 0x00000000, },
>> 	{ "cdns,phy-dq-timing-delay-sd-ds", 0x00000001, },
>> +	{ "cdns,phy-dll-master-ctrl-sd-ds", 0x00800004, },
>> };
>>
>> static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
>> @@ -83,6 +84,7 @@ static struct sdhci_cdns6_phy_cfg sd_hs_phy_cfgs[] = {
>> 	{ "cdns,phy-gate-lpbk-ctrl-delay-sd-hs", 0x01A00040, },
>> 	{ "cdns,phy-dll-slave-ctrl-sd-hs", 0x00000000, },
>> 	{ "cdns,phy-dq-timing-delay-sd-hs", 0x00000001, },
>> +	{ "cdns,phy-dll-master-ctrl-sd-hs", 0x00800004, },
>> };
>>
>> static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
>> @@ -90,6 +92,7 @@ static struct sdhci_cdns6_phy_cfg emmc_sdr_phy_cfgs[] = {
>> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-sdr", 0x01A00040, },
>> 	{ "cdns,phy-dll-slave-ctrl-emmc-sdr", 0x00000000, },
>> 	{ "cdns,phy-dq-timing-delay-emmc-sdr", 0x00000001, },
>> +	{ "cdns,phy-dll-master-ctrl-emmc-sdr", 0x00800004, },
>> };
>>
>> static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
>> @@ -97,6 +100,7 @@ static struct sdhci_cdns6_phy_cfg emmc_ddr_phy_cfgs[] = {
>> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-ddr", 0x01A00040, },
>> 	{ "cdns,phy-dll-slave-ctrl-emmc-ddr", 0x00000000, },
>> 	{ "cdns,phy-dq-timing-delay-emmc-ddr", 0x10000001, },
>> +	{ "cdns,phy-dll-master-ctrl-emmc-ddr", 0x00800004, },
>> };
>>
>> static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
>> @@ -104,6 +108,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs200_phy_cfgs[] = {
>> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs200", 0x01A00040, },
>> 	{ "cdns,phy-dll-slave-ctrl-emmc-hs200", 0x00DADA00, },
>> 	{ "cdns,phy-dq-timing-delay-emmc-hs200", 0x00000001, },
>> +	{ "cdns,phy-dll-master-ctrl-emmc-hs200", 0x00000004, },
>> };
>>
>> static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
>> @@ -111,6 +116,7 @@ static struct sdhci_cdns6_phy_cfg emmc_hs400_phy_cfgs[] = {
>> 	{ "cdns,phy-gate-lpbk-ctrl-delay-emmc-hs400", 0x01A00040, },
>> 	{ "cdns,phy-dll-slave-ctrl-emmc-hs400", 0x00DAD800, },
>> 	{ "cdns,phy-dq-timing-delay-emmc-hs400", 0x00000001, },
>> +	{ "cdns,phy-dll-master-ctrl-emmc-hs400", 0x00000004, },
>> };
>>
>> static struct sdhci_cdns6_ctrl_cfg sd_ds_ctrl_cfgs[] = {
>> @@ -252,6 +258,7 @@ int sdhci_cdns6_phy_adj(struct udevice *dev, struct sdhci_cdns_plat *plat, u32 m
>>
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_DQS_TIMING_REG_ADDR, sdhci_cdns6_phy_cfgs[0].val);
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_GATE_LPBK_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[1].val);
>> +	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_MASTER_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[4].val);
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, sdhci_cdns6_phy_cfgs[2].val);
>>
>> 	/* Switch Off the DLL Reset */
>> @@ -296,6 +303,7 @@ int sdhci_cdns6_phy_init(struct udevice *dev, struct sdhci_cdns_plat *plat)
>> int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
>> {
>> 	u32 tmp, tuneval;
>> +	int ret;
>>
>> 	tuneval = (val * 256) / SDHCI_CDNS_MAX_TUNING_LOOP;
>>
>> @@ -304,7 +312,18 @@ int sdhci_cdns6_set_tune_val(struct sdhci_cdns_plat *plat, unsigned int val)
>> 		 PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY);
>> 	tmp |= FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_CMD_DELAY, tuneval) |
>> 		FIELD_PREP(PHY_DLL_SLAVE_CTRL_REG_READ_DQS_DELAY, tuneval);
>> +
>> +	/* Switch On the DLL Reset */
>> +	sdhci_cdns6_reset_phy_dll(plat, true);
> 
> There is no err return check, but
> 
>> +
>> 	sdhci_cdns6_write_phy_reg(plat, PHY_DLL_SLAVE_CTRL_REG_ADDR, tmp);
>>
>> +	/* Switch Off the DLL Reset */
>> +	ret = sdhci_cdns6_reset_phy_dll(plat, false);
> 
> there is err check here. Should these be aligned or the usage is intentional?
> 

The difference is intentional.
sdhci_cdns6_reset_phy_dll always returns 0 when the second argument is 
true (i.e., when switching the DLL reset On).
When switching the DLL reset Off (false), the function waits for the PHY 
initialization completion bit to be set within the defined time period, 
so a return value check is necessary to catch any failure during this step.

> Regards
> Peng
> 
>> +	if (ret) {
>> +		printf("sdhci_cdns6_reset_phy is not completed\n");
>> +		return ret;
>> +	}
>> +
>> 	return 0;
>> }
>> -- 
>> 2.43.7
>>
>>

