Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B57BCA0EFA
	for <u-boot@archiver.kernel.org>; Tue, 26 Aug 2025 14:35:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2388D830A0;
	Tue, 26 Aug 2025 16:35:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="2bkBAoh1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C5508311B; Tue, 26 Aug 2025 16:35:34 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0AF98828A2
 for <u-boot@lists.denx.de>; Tue, 26 Aug 2025 16:35:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BFXP1+RoM0cpT1KOB79pf3LirZQPbRBb555mb57QQCP/PE2BB6Zj/dZxmrLXUOIkgQKhLu7YVGfxp2Yx8kzagdpyEWM18MBEQ4sq76M8TzKOKFPAZbJZYyCcYLSG5fcHs6cH9ZBmGCfRvdAZAyBpCBdf87F6qX7+NgMW5S33Px45VpTjv3eOb7NGiobyROzacKLfpCvlGVAb/xfSeBvbhmRcR9PUrt+a7GzeHoNZ3eo58SBF5RBXbsUeXZMkzbrMi7J5J2Gb1eqqIseiZRoboA4onp45K+K+nXc0WPXhvu5+aeC/2TyRNflKPURL8qnJ5CZTe0ovmZ1rcLbLBrv2Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UtOvoJfQ8mVUjL2L02as/ZXv0zylDGlKA1Y0kJMrXU=;
 b=OqHDA16MczwTgTJaYcxUuLspuQoL22G3l9sIuv91OS1n4+caadRm3l5I35iAL2mAHhWEEBf+VN1OHOcebvjZGFF9gPDQBp9WlRqSLJbNTy/sEk1HDXn45sMGqiFRCBM1KxU+mobBW5tT/fpDLuVIAAVDPXyFDGLdjoje+uKUx9OGAxVHz8+0ELUDkAH9ThkhD8ZxKKjylPxL0ATPlNBwfIPEYIDJL9pCL0Krh7uudlfQGiRr1obFtFI9x0UUERs7htaxtbY6hP8ftfzc2tiai7a4LEwBEMRfbe4C97xZpdSZEa20wCEKs+p4uvCBsKntxBLEKe5YfUH0nV16e+lt9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UtOvoJfQ8mVUjL2L02as/ZXv0zylDGlKA1Y0kJMrXU=;
 b=2bkBAoh1enEOwnUIIDIw3+gT6XdDsg0IG89Fs0eOg9LCR5r8ZVKf56dMGtu3FxKyYxOoLWcRg2hSB/2yIY4p8Dv5SVKOollzF2NqTIIljK7+wYZcmzdVDFAUUn1w/cLbDZ0UPlFQ/+nOj1AhuFdcEWDqhVQJZeQRdnGqU6PLc1mANg+v6Q+B/XtjshvF1IU91SDh2yAjwsXzluJGKiN869AO3KEq7uiQzzDgZonEFJLt3ChFBy4ELAFjC3lc3da2dK+wDQdb53P58pORuLqTk0j5+yHC0EHWmEGNcaqUtZVPswGzip+x8cfyTxWvlC8eTnAqIyupINF+wP+gGW43TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by GV1PR08MB7913.eurprd08.prod.outlook.com (2603:10a6:150:8f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Tue, 26 Aug
 2025 14:35:27 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%4]) with mapi id 15.20.9031.018; Tue, 26 Aug 2025
 14:35:27 +0000
Message-ID: <74e89720-a8b1-45f3-920a-ca9fd1aad776@iopsys.eu>
Date: Tue, 26 Aug 2025 17:35:24 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cmd: mtd: fix speed measurement in the speed benchmark
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Christian Marangi <ansuelsmth@gmail.com>, u-boot@lists.denx.de
References: <20250825234829.155483-1-mikhail.kshevetskiy@iopsys.eu>
 <87h5xu2mcg.fsf@bootlin.com>
 <CAOf5uwkOfGUmB9sfTuTBBVkuub9Ag1ahG5Si1XWuftPxc+_ZRQ@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAOf5uwkOfGUmB9sfTuTBBVkuub9Ag1ahG5Si1XWuftPxc+_ZRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0317.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::10) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|GV1PR08MB7913:EE_
X-MS-Office365-Filtering-Correlation-Id: a88f236e-6a14-48b7-7a7a-08dde4adcc64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0; ARA:13230040|376014|1800799024|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MmNQNS8rQzRIQy9oL0JIMnpWZi9DQ3lxRHJnTURnTzl4WGFYSmZ2QkpibmNS?=
 =?utf-8?B?bWZXdjNlRWY3c3JrSmVCc0VQeWlRT2RIbVF6TzBraTFUWEprMFFMQXZOTGs0?=
 =?utf-8?B?NzBNaFZsK250OVhTZDhCNHR6eDNhVThNc0xsMFVKeDBFUVd2VnNPWUJwTFpI?=
 =?utf-8?B?aTFVV0RXM3hHWFFUbDgzclA1eUtjVi8yR3RVcENXRUR2cHArWVFuNjYzZUZP?=
 =?utf-8?B?czZ2QnVPbVVIV2tzUEZBYU1VZ0F0dUFmR0VmbXB6bDV6TXoyU1RGUEpNaDNT?=
 =?utf-8?B?ZnczMVBSM0dncFZqa29hd2lNVEwrZHhtcVZZalNpOFhCcDBpakZvenRudEZQ?=
 =?utf-8?B?V1ZqcDhjNk1rTnFJVEx4VDM3MlZIRVZMeWdOYTArU0lMZEJkOW1RanlmSEZw?=
 =?utf-8?B?d2diVXNOMHQ1VHpEdkxUWmg4WjgwejhUVWl6TjdwRUx6K0x3RGFScDNWQzhC?=
 =?utf-8?B?M1FnQ1dvMWM1bElLL3oxQWd0bC9qUFVhcVlUTlJkUkh0RFVvRjB4T2w2c2hj?=
 =?utf-8?B?cVJUSS9NTVdNaTRGUVhXeGJseVR4M1FUdDdLaHVDKzRhSTI4MVEvdkpocERS?=
 =?utf-8?B?Sm9hZHpsazkzZEVFMlEwY0o2U0Z1elFkRDVrWUlTaDVzZ3FuNGhzc1g4MjBh?=
 =?utf-8?B?bmlpTTVQWUtwdnRUYm84Nmp1TGpYRWpoR0Q1VWJLK3ZRanFEeC91MzdoK0o1?=
 =?utf-8?B?RVFLSVNWaWdxcUEwdkJrTGtDamdqdW9XL01Jelh3WTgvdWhaSllNK2picEtl?=
 =?utf-8?B?ckFKVjR6UDJCWE02NVBKbWpPNFI3UjJ1dXFqUnVhY3R5bjlUVGMzbk1sa21V?=
 =?utf-8?B?NWlHVHRIRE9vVitCTXZRZ3JibDVwNDlRbnhDSi9ranlyZmErd0xBM3ZFQkx0?=
 =?utf-8?B?dlBURlA5T296OGJZdUd4bDl1OFhNVU53elRaSzBxVlZaUURvV09NUytsZzA2?=
 =?utf-8?B?YVJ0a214V21zV2Fxbm1hRzg4dkY3RmduamJIVDc2YkxoWGN0U0xURDYxWFZq?=
 =?utf-8?B?NU0zK0xDQ1FxNmhCcG1EVTlXZFErd2R3UVpYR1RXdEsrRklwa1NpbkFqbjZI?=
 =?utf-8?B?QWFMRkdoL1FRVW9JVEFhWVFNMVZwc1o4TkdoSWp1cmtsOWs0Qm1MWWdRSmZi?=
 =?utf-8?B?Mkdwd2NHVURsUjdXemFSL0M4K1VUNXVlam9OZ0w1T0lBVDhDT0k1b3IzMVR5?=
 =?utf-8?B?NzJEWkpGOHhvb3pPQVYxQnBDbkIwVWMwZWw5aXNCTWV1N2E0Z0tLcFZ5anpU?=
 =?utf-8?B?QlcwWG1DWkVGSHlOOS9rby9pMWp0ajU3NjFtc2dhVTNVeE0xaTdZeXZJb3Y0?=
 =?utf-8?B?enJZTmVOakJveHovZmZIK0VPSnlSeXY5Mk1uYTUzcjVodDFEekVieUtHYVNo?=
 =?utf-8?B?b0k0U1pXNHpQcFRlVWtldlBPUDNsNXBQMmxhWEdnbG82TWJXWG1nSERHUlht?=
 =?utf-8?B?VmRKUmpwKzJ5RkxGQVpYb1F1T1lDeHlvbjRqRFZmbGwrdkVPS0FBZXZVOEhO?=
 =?utf-8?B?S0xwU01kNkxodStEakpneXE2THp1cmtjZnRDa3FLem9ZWWl5Y1FKZWx1Qno5?=
 =?utf-8?B?Ym5aSkI0OENka0tTY3E0WEltVUhBYTY2dDAvMEJoMm5lN04zTS90L3N1RDBG?=
 =?utf-8?B?WG9qUkNnV0ZTOWpkL1M4cEtnUWQ5K1d6TWpKQ3JDTEtySEFsZ01FL24zK3hj?=
 =?utf-8?B?czB1WGMxZ0Z1TittWTJqN25NeDEwZDNZWlNoNnljc0NCRzV4N3J1b252NjUy?=
 =?utf-8?B?ekNxcjZPaTJoWXZwN1dyYnJZNUV5NWYyRWsrdDlVczduS0ZiQXFURno3VEsx?=
 =?utf-8?Q?s9Pm1IY2Ueuq3sQWHzfFKtZkCEiEjgLfK2ZME=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(13003099007); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEo0WkhSSHpwN3htSWVIUzJROVlwczZkTmRxai96b0xad1o5MFprREFvUTYr?=
 =?utf-8?B?UDY3eGs3QmQ4VlZGaXRLcGVOcXhWOGdXd3lWMlJnVHdPRFJsWFlWY2x6ZzlR?=
 =?utf-8?B?LzhibFQxQ0FXTVViVzF0bW90OVcreVNYcmxoUDBTMnBQd1VOTDRUQVRJVEFO?=
 =?utf-8?B?WmV5SHd1NjU1TnhIVTRic29JT2hEbXV1aEtFV0ZnMThzNjljYjR4SGtZUnA1?=
 =?utf-8?B?Wkk1U3lwUzdqa2ErOTJFVUsvMU91NEtMdzhGK25tc1hiMFZ5YkxMMWt4cGRT?=
 =?utf-8?B?M05QaUxtNlFqeXpSalVuUnY5S2tZMCsxVjZ4WUlSSlFGRmRJRHd0U0tZL21n?=
 =?utf-8?B?czYzOXJaallOcFA1aUZyaEZJRkpZaGpGM3JJM2tkeTErVFR5aFB5amRWSUY5?=
 =?utf-8?B?NjFrVGNhNndDL3dYM0R4MVF0NVdoZUZsNEsrNFZOYWZreE5vYzYvenhBalc1?=
 =?utf-8?B?aVBuTnRrbitkcUpxTEZXbnhqNklWYUYwT0FQYml1R281ejFWU3B1anlVT3RU?=
 =?utf-8?B?R0lkZWQraEN3WVJoSDZPd0EzQkJBMkdRMTM3Vkk1LzNKbFlxUDd6YnFab3Bi?=
 =?utf-8?B?Ulp2U29RazE4ZWo0OG9jTjh1R1ppMEg2TnNVVDBkT2dCMDBhVnd3U2RiTjlw?=
 =?utf-8?B?VUtNR0VnNG1YK2hqV0RibGQ3UEsvZE5jY1Z3OU45d04vM3dYQVFvTlVzcUpB?=
 =?utf-8?B?T3dEUGwrZGovYXRCSUJ1VEZIbVpLZzU0WHBnbnFoSVRIVVhIclBBUFdHWS9X?=
 =?utf-8?B?S2VHWFRiS3pnekt6ZkVtWG1vUU43THJrVVVUQnlpaXZYbGxVbERFV1pNUlNL?=
 =?utf-8?B?OStIZHloTEhCTnNUWGxXY0NzRUxvQnNhNm1vOENUZ3hOZWMzaHZRa09aSXhC?=
 =?utf-8?B?aE5vTi9wdGU4MnYwWGhxaEZwSGRra0FjZjNBWkNnY21XRndRQWwrUjhHR21V?=
 =?utf-8?B?R2pkdXB0MkNVak9MV254bFZCbDNIUEdsUnlBWldzdjFGd0dUSklSZUFhL2NW?=
 =?utf-8?B?S00vZ3ZwMDFBamtMMG9uekFvNU44WE0yaTZHbUpMMDhTVURhZ09hSGVtQlpW?=
 =?utf-8?B?K3U1N2FTc3VRWEJWNkcvbnYvU2xYWGFWT2ZZWE5laE96a0VYWU5lT3k0MVR3?=
 =?utf-8?B?ZkRFdHFiUWgzMThkUXFEZTRzT04vYzJqVkp1WnYvQUZ4cDFDT3o5WUhoTzMz?=
 =?utf-8?B?VlVia2sya1pIWUp2bHFtL3VybkpTK0xSN0hvblRmRWZ5T0JLNFpxZm1FVUU2?=
 =?utf-8?B?RWtCeDdibGZodWp5Sk1xTFlkN1pyUEVoTytHdTZCMGxrQ01iWGZOc2JNc3c1?=
 =?utf-8?B?bExyNGd6aU5SV0tkZGY0djdLQVBwenBKUjBWQjdkVkFhamFDUHdpaWg3b3Zs?=
 =?utf-8?B?TWFiZ0hNeTRqOXJ3enN3UVkwNXRWYlNUR2NNbmJnSlRSS3c3NU1STjI5M2pY?=
 =?utf-8?B?b3dZdXRhU0FEYXMzdkFmaThweUNQY2w0a0pKUzFoTi9ueU9wb0VQcTFCdDI1?=
 =?utf-8?B?cVV6MjdremM1K1dYYXUxL1AxZy81bnk2MlZBK20vSXZWRldKWEVOUTFUSGpK?=
 =?utf-8?B?SUVZcS8wYXJBNTZ2NmhqakxJL2Y4VVBDZGx3dkdBakxUdDErNWgxZzdsaTg4?=
 =?utf-8?B?SXZrcTRZaVB3d2toeGxEcXl1NFJZRkZwaHR1Qnp5RndtNEtlajdic3doOUZ3?=
 =?utf-8?B?NnMzYkljRVE4SXZuVkV4VW43NDE1Ylg0RjFLM2NlVGs2T3VDeEVWODE3KzR6?=
 =?utf-8?B?U0xUVlN6enFHeWw3MThSaHhPZTdDUnBsNVQ0SHowTW9wWkpnWitmT0wrcHNT?=
 =?utf-8?B?MzV3Ly9WYzZCaTNHZ3VPdEVlMkxCZjIzU08vTW9TekhybllQTnN4VzlkOTBq?=
 =?utf-8?B?c0RxYmlKdFB2ODJ0V05pbzNEbWVadWFIbHV1Qlc4aXIxQTc2VmpVZ0UrWTFN?=
 =?utf-8?B?bXpNOUxnN2NXZytuTjh6aHFiSng4R08xYWk3R01lNk14dEM3V0VLazZPM0pK?=
 =?utf-8?B?c0pzbFJJdk9lLzRISmp1UWxZNVNISUxMNlB6U1RiWWhoMlVxWUl1MlNJeFJs?=
 =?utf-8?B?RjRrSTZXSjNydTBtSFFISFpqOVJHeFNHMUF4alp6emNtTlFyYnBuOE9TV3h4?=
 =?utf-8?B?a0J5a3VYd0NzckJnUWIzbW5KTGtDOVg0aVJpUUxQYlEvakhjMVVUeU5JL0JV?=
 =?utf-8?Q?XG7WJ/8vFlgp8EUrYmHEF+c=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a88f236e-6a14-48b7-7a7a-08dde4adcc64
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 14:35:27.3252 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKYbjdJe/0b30FgVBqVbD4g2vr6qZxSF5E0FRyoQKjrGy5KQHFSRZOnW5XWiSEQNw+v6vtxQ1O4EliBuR10JgHcW5q+y09ACQo7qSW2H69I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR08MB7913
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

and maybe benchmark feature should be documented

On 26.08.2025 17:32, Michael Nazzareno Trimarchi wrote:
> Hi 
>
> On Tue, Aug 26, 2025 at 4:23 PM Miquel Raynal
> <miquel.raynal@bootlin.com> wrote:
>
>     Hello Mikhail,
>
>     On 26/08/2025 at 02:48:29 +03, Mikhail Kshevetskiy
>     <mikhail.kshevetskiy@iopsys.eu> wrote:
>
>     > The shown speed inverse linearly depends on size of data.
>     > See the output:
>     >
>     >   spi-nand: spi_nand nand@0: Micron SPI NAND was found.
>     >   spi-nand: spi_nand nand@0: 256 MiB, block size: 128 KiB, page
>     size: 2048, OOB size: 128
>     >   ...
>     >   => mtd read.benchmark spi-nand0 $loadaddr 0 0x40000
>     >   Reading 262144 byte(s) (128 page(s)) at offset 0x00000000
>     >   Read speed: 63kiB/s
>     >   => mtd read.benchmark spi-nand0 $loadaddr 0 0x20000
>     >   Reading 131072 byte(s) (64 page(s)) at offset 0x00000000
>     >   Read speed: 127kiB/s
>     >   => mtd read.benchmark spi-nand0 $loadaddr 0 0x10000
>     >   Reading 65536 byte(s) (32 page(s)) at offset 0x00000000
>     >   Read speed: 254kiB/s
>     >
>     > In the spi-nand case 'io_op.len' is not the same as 'len',
>     > thus we divide a size of the single block on total time.
>     > This is wrong, we should divide on the time for a single
>     > block.
>     >
>     > Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>
>
> Add a fixes with commit reference, when you post v2 and address al the
> other comments
>
> Michael
>  
>
>     Happy to see this is useful :-) But you're totally right, it
>     didn't use
>     the correct length. Maybe I would rephrase a bit the last two
>     sentences
>     to make the commit clearer:
>
>     "In the spi-nand case 'io_op.len' is not always the same as 'len',
>     thus
>     we are using the wrong amount of data to derive the speed."
>
>     However, regarding the diff,
>
>     > @@ -594,9 +594,10 @@ static int do_mtd_io(struct cmd_tbl *cmdtp,
>     int flag, int argc,
>     > 
>     >       if (benchmark && bench_start) {
>     >               bench_end = timer_get_us();
>     > +             block_time = (bench_end - bench_start) / (len /
>     io_op.len);
>     >               printf("%s speed: %lukiB/s\n",
>     >                      read ? "Read" : "Write",
>     > -                    ((io_op.len * 1000000) / (bench_end -
>     bench_start)) / 1024);
>     > +                    ((io_op.len * 1000000) / block_time) / 1024);
>
>     Why not just dividing the length by the benchmark time instead of
>     reducing and rounding the denominator in the first place, which I
>     believe makes the final result less precise?
>
>     Thanks,
>     Miquèl
>
>
>
> -- 
> Michael Nazzareno Trimarchi
> Co-Founder & Chief Executive Officer
> M. +39 347 913 2170
> michael@amarulasolutions.com
> __________________________________
>
> Amarula Solutions BV
> Joop Geesinkweg 125, 1114 AB, Amsterdam, NL
> T. +31 (0)85 111 9172
> info@amarulasolutions.com
> http://www.amarulasolutions.com/
> <http://www.amarulasolutions.com/>
