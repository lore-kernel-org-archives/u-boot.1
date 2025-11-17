Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3750CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 08:50:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7C36E83B0A;
	Mon, 17 Nov 2025 09:50:33 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Koi9CA3h";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E20A83B43; Mon, 17 Nov 2025 09:50:32 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BA3D83AEF
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 09:50:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAf344gemkKv5UHAr1O+fAQ/7ih2dX40R8GIkUVI91T4d0wpCUUNdgXAYbG14CeNfszmtNhxsk5CB70PppqJcq95q0dmh4F5T/yDMs/tO3V15MwxljRy9VGJtc9WT2RqtYFJtWMcMV/GJMEJefS5Ly+04zBoVjYuoZURskp5B9W3rsuUfKZyRY5ea24Af3n80pdLMUMj9TYU7F0OOcQvQHaKRoyVDuCOBcJDDE3aKcYL0gbrcPlTISPUagboXCQpEgPxlxS7NSXIQagVBY2bXe/93p1m3HVSwU1e3WqRVn1bt+Zu2PVvxgidnk4PRtWiKebus8ycg2hDtQjhmmPcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VVfrdFs7HJPZnSub55zPpp9tMzZadDEQ+ctf4ohkRjE=;
 b=d4+kszLc0JHZms7HLJOFrrwRjfulZiBh4bOC00dDnxmq0om4WkVQA8CdsRb/npmnUmYCovpgqgGuZFoKDrg2WQZR8pfNgOFkjQBNgLovpKwqxkMPm3jkA20hv94FrbIzbNuA6JatyT/dVsTBLtGmbnV1J+bw3+N7uDzvDn1mApL8WzLGpq2a0+p2aG9aq33jPHebDwfVHvLau4kKchUd95T3Dbdn6uyXBzVKD+Cn4+JBy855Uf6G/GiqPd4OMWSd8AjnKuezvACvJDiANCxPjvzYvnwJbS06Uz45pfGwKIRYMPHCbGgJ9HXlED+Tm4kR3g5wG/kICdSEC5IW8qdx9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VVfrdFs7HJPZnSub55zPpp9tMzZadDEQ+ctf4ohkRjE=;
 b=Koi9CA3hJZ2fA7Ox6vsUnkXGDDvzBtM6Kg/iefwPuUUF4597sRnRGeRDidIdwhwW5G+D9KuN+rzQy8H5KJquQS2k1BIbRIn226nJW0/6q0yjXNGfcyS+RcOzGTEKhYHnTFEw7Oji3nNh54fGPp5izYH5XVPtqh/9LrxBET1F78h3TuawmhunKp3EWqv0NMVFcxJScjKnCsYY+39Ee/0dv63bOsNUSqJkGDXU7xBmpJhMzIYNang5aTGHzUMpwc7K0JtqQmcsRdkyOXobZfW2UZ0bJlahvPv2lmNJBATsOZE2qltk2A09xv8hrKhSBkBbZ9alOES1hXgMVpdnq3nzaw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SN7PR03MB7260.namprd03.prod.outlook.com (2603:10b6:806:2dd::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 08:50:27 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 08:50:27 +0000
Message-ID: <4990cf40-305b-466f-95f4-acbac374c179@altera.com>
Date: Mon, 17 Nov 2025 16:50:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] configs: agilex5: Enable FAT-based environment storage
 in defconfig
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>,
 Simon Glass <sjg@chromium.org>
References: <20251023085122.23607-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251023085122.23607-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0035.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::22)
 To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SN7PR03MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bb290b7-da33-4423-8bad-08de25b65aa0
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bHpLbWx0UHBBVkdvYzI0ekN6bXM4andUMGUzNTB5L2hsMjFTRUZWcnpZdnVh?=
 =?utf-8?B?cUlJV21tNDU0SkpoYXJhTEhKRGhqU3hjbTFLdVFVTkZmTk1zejBWV01JdXlF?=
 =?utf-8?B?cktiQ2VDUStudlE2cExnaXVZczcrOHFwQkFnSGl0M0lCV01RcmRxL0I5RkZ0?=
 =?utf-8?B?SE9nT3VpTUZJTFBYbFJZY08xK1E2c29rNWFrZzIxaWtidXJTb045bHJ4ZHpC?=
 =?utf-8?B?UlIyMktqVmpqRDYra0ZqampuaU5tMHBzRlREVDY2aTdXenNWYjJGSlNSdmY4?=
 =?utf-8?B?NUZ6NlpFNGxlN1ZPV1VZREVXL3V3T3BvdHlySzVRa29RQ2pjZWRnMWF2SzJ1?=
 =?utf-8?B?dkxrQWlnVHNvbTdWZ1hXTlk3MWNnTlZNbnNRU1UvN0htUjgxV0s4eGw2cWEv?=
 =?utf-8?B?K1lUSDBlL1BYbUdmTWViRFAxMWFUTzBEREVpUjFBRnFuWUZTcVFDU1lkcUMx?=
 =?utf-8?B?Wjh5clJnVVJhNzU1MUcvamZ0KzA1TmVqWXJSVmM4QlY4QkgwOEhqSXFXenN3?=
 =?utf-8?B?d2VycGR5cUlSMU5CWVRSTHVxMHBYcWRtSm5qK3pGRjRFdlh1UVJvYndjSEND?=
 =?utf-8?B?OWZHSks4Y01YMkxFZUtQQ0NxMzRuWkFQVWwyQ09kUWt3TlA3ZERWU05tc2sr?=
 =?utf-8?B?ZkVjZHhWcjFYZFBsKzlmUXB5MkEyNzVGNXF4UFhEdTd3ZUx6SHZCOUFTZTJl?=
 =?utf-8?B?QmMyL0RTUXRLYzdMQndKSWNKNElSNGZTT1hJbFZNMmlhT29aWjdiQ2Y2Q1Yr?=
 =?utf-8?B?SVNlOW5yeEwvMmJTREJVc2ZYWHNtaXBFNWwvNThKZVU4ZTNURUR4TDloYkd4?=
 =?utf-8?B?SEpwRXIrZ0VyOFg0SWdXU3g0cGxmVVhNWTRSaDBrWVUwY1hvNU81UFBXUnVY?=
 =?utf-8?B?RTFjUU1XeDFJZXdpRDYrd3phQ3A5Sk5oV25Eb3VZRjMzUGRvVktuOWVsN2hS?=
 =?utf-8?B?bGZFYnN6a05KZEpzYm9UNC8rLzdHRFBNV1pIejYxdHRONWpxQ3c4ZmN6TUJ1?=
 =?utf-8?B?cHhGaUpxakwxdklNbytYMzFhRzQ2QlRCZjNkUEtQZHVSMk5pZmNtUkhjOFFE?=
 =?utf-8?B?VWJMM0VIRkgzWUE0UnBHRy82QXhIUmVOcnNXUWNPN0NWak5pUlZsdlNpWS9V?=
 =?utf-8?B?Tjh1R2xNSzVmaGhvQjJGWFVzWUZZV1I3a3ZSQkIxSUhHVk5xSWNzdkZXaUlV?=
 =?utf-8?B?NDdZYTZYWmFCWnIxSXF6MkhOMkJsTnlqdTN2ZzJPc2lKaXlZUFRhUGt4UDE1?=
 =?utf-8?B?L09DditpY2psQzRJS0lpUHpSQVAwOFA5MVNlR1lPRHZUd1ZaS1U0WDkzZ3hq?=
 =?utf-8?B?ajVQOFF6dFJEUUpCWStVazVuQ240OWEreVk0eXgvamhsRmVOWkNqc1gyU2tQ?=
 =?utf-8?B?Yk9iSjZqcXJ3dEczRURGb3d6RTlSK3BxekkyUTVpTG1kYzZFQ1NDS05Yc2hh?=
 =?utf-8?B?Ym1zdW5SN1NBcGdWS3dKMjJjRHcrcE1vMjFpMDNhbzBvN0ZBdTZoR0dSVkNT?=
 =?utf-8?B?bFg4OFlXalhkeXhja1dEdWxrUWdsekl2SUhXdit5WGdOTHdpdW1pMW00dTRG?=
 =?utf-8?B?cGpwTTJjQkQvTTlneitQei9BNzhLNllGVE1KQXJSRXVZNXRCYjlyb01kc1dN?=
 =?utf-8?B?SGVQczJESW9jR3VoQ2NDWlhYbWRLajRWY3hTOG9kbHdMU2dHSEZyVnJrZzkz?=
 =?utf-8?B?QmJhWVkwSGNjbEZVU0poUmt4Zk5DcFlldW1xVjBPeVg5b2tDQTQvRzZtbXM4?=
 =?utf-8?B?MWloMHlaS3hhOE1vMGFBV1owNWdSWi9wZ0xENFU1ZHdHUUxXbUttQ2wwQmQ5?=
 =?utf-8?B?dHdpSTltNFgvY2ZBeUYwcTR4TStheXl2U3VtVjJ2ZFdHSGVuOEdBMjF0ZGxV?=
 =?utf-8?B?SGtwUEJJdUpRSjhBc0pEanpLY0FzSHhIUlgwcC9xVDFDNWE0Yi9IaGNhdEhV?=
 =?utf-8?Q?UGi/ZYw9ONstx4cofduFBj1ZKgCMhqub?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVB4Z2h2WGE5Si90Q25CNlRWdDBaTEladnhwS0pqRll4eEtGeVlCd2lkRE84?=
 =?utf-8?B?cmdpb29mckk0RmVCNTJmRDU1ZlZOZjEzK0R6MVFybTRxSUpBdEVFcWxDTEdG?=
 =?utf-8?B?b25iTFRpQ255YlhaLy83L2hneTNvQk5PSEtDOWcvVm83Q3BpcnFXZ1V3ZzJm?=
 =?utf-8?B?M0hlSHgrU2JGR1VhL2w5YTcweFBpOGRSWkt3amVHQXlnZ0RER2lEckZ6akxL?=
 =?utf-8?B?WFNCODhWbzRVRzAzamg1QTlka0pxMTN4TlM3THNZZGFzRndkRG1LZG1XRHY2?=
 =?utf-8?B?aThKbGxuVGtOa1pmenYyZDRmNWlNeHFuTm5rQnloMDdYc2MwWkNwcFlXTVc1?=
 =?utf-8?B?YURHbXk4R3hOSzdCK0xQT0owMktjbFpEeVg4aTB5R2ZaUGlFUk5UMnpsbXBz?=
 =?utf-8?B?elFLclZuRURaakJpSTVFdktzTEtlWnE1RnNnNWdLOHgwQmIzK2dudERnQjJV?=
 =?utf-8?B?aUp0RmRyS3dIRVBHZTE3K1hNZTFiRUtzYWlmOVNhNEI5Vi9DZ2FIQkVGRWFm?=
 =?utf-8?B?THJuc2lUYlRVWXJROUx1TjdTdDBIQW40TC9wR1ZzYXlNWjVoYkdkVWJ3OSt5?=
 =?utf-8?B?amhKNndPeFlaOHVEam1ESzk5Y0FXVXVLbGJqQk02MkRkQzhzbndOVFJEQk1V?=
 =?utf-8?B?aGJ3TXZKSmlyR0VrNWVjdEdWSEhCOFZMUThFVVdjL3o4R1NRa01OK3dlcGZE?=
 =?utf-8?B?YnA5MmQvYjVPL2lsd0NoemdaTEhHQ1haaWREWFpBR2Q4YWRDVlAvenRQbjlV?=
 =?utf-8?B?YnBYQUUwNnpseVA0SWtyUFZOSkh4bVhTMEpvTnpyU0xxUVR3ZGwvNlV5SXR1?=
 =?utf-8?B?TTR1azRiOXV1V3RGL2hhTmxPb1dXN0cxclpRYTMvbVVhQVltVEtCK0RmNUQ0?=
 =?utf-8?B?UFBVUUJnR2JLb0p6T1pNOC9xcWJMNGRFdEJLRjh0bzRZalpzbmlFbGY5WlJm?=
 =?utf-8?B?Y1E2NCtwNkN2M3pSSFVtc0MwNkVYTkUreXVxMExLNVFvQkw4YlNLc0hNbGgw?=
 =?utf-8?B?b1ByYmVsL29HaFBNbDNCYUxyci9mcFVvajdEZDhvRi9JQ0drdlJKN0ZibnZD?=
 =?utf-8?B?RExoVXlkejQwSEpnU1NaaVRZbmJ4Y0wzRzBYUkh5dUFPcEhEYXpKUTR6enNV?=
 =?utf-8?B?RGJDdXNCS1lhYnVYditER2FPNGJLd1ltclRmK0tVY3hvckMvbzBzZGZDMjk4?=
 =?utf-8?B?ci9sUmswdTFDa0Y5UHRkcGUra2dXelc5a3VNWVQxWnRTcG91c0V2QlNPdXIv?=
 =?utf-8?B?UkpjY3c3U3FQaThPdkJ5T2N1UTJQZlpWSGJya0tDTGtMUjNTM3AvQktJZ0JO?=
 =?utf-8?B?bytmWDhCU0poVWxNb2I2UG0raEE0dnNhS1h0ZmYzVFBLZGNHVDBrZ09Va1lQ?=
 =?utf-8?B?REEwdDhiMTVUejlhRkVsRGNHbU9lcWhyZEhZTG5VY0d2ZmtidkNHdGFiVHBn?=
 =?utf-8?B?a0E2bEpOMm9oVVlmMEhUdTRVUjIxVmdNcDVpdE13eWZaK0laVkVDaUlwSzhY?=
 =?utf-8?B?S3lCSDFkS2lHOHRsQ2g4RUdHMEdIbWZPcFhVNkFnN1FaeUszalJCS2ZEN2Fw?=
 =?utf-8?B?YTNWMjExWDF5bDF1Q1BnaW9EZ3FVN2RCVGthR2Q1ckxjQUpjenpQZDhjeGZp?=
 =?utf-8?B?TVFpM1kwL3hKdk5oUVRPaE4vbDdBN0xKd0htUU51ZGM5dE1UcVNXS0ZhQWEw?=
 =?utf-8?B?S1JIcndSNjkxL29IQ3VyS2h1ZUg2cGswTXhqL2RIR3U5Wk9MOHJudFpsd3la?=
 =?utf-8?B?L29sMUc0bUwrcTkvek1ITitBakZpcWoybWJaWVBVd2thbE0xTVQ1SGt3K2Rx?=
 =?utf-8?B?bVBqNndjWTBGeU5Ra0ptUlVPQ1dlWTYvWUNPS3Q0ZnE5WlF0b1RxcVlLNGYr?=
 =?utf-8?B?SlZ1TEdrZ3NvT0lyMVNlbkE5NGVIY1ZzTisrTmJpVFpiVXhocCtlMmJBd1JU?=
 =?utf-8?B?YWtoRkJhNCtmRkhWdlUwV3M5eklJaDgzMHRVOVZWM3o5K24wckJWU0pXS1pr?=
 =?utf-8?B?RWhMMlMwdDdWSE1BcGYzUWhwZC9FUUNWZzduV1hDOXZqOUFyZEZxUjEyT2Vr?=
 =?utf-8?B?SHNqNVAwaThaMU1RUS8yQkxHaGc5bHA1N1RISkpUdmFOUmwzRWxPeFI5YStM?=
 =?utf-8?B?MjJuSkhSa0g3Y3NwN1NBYmNEaDhRMVUxdXFpOVhnR0JaUHJ5TG15Z2w2emtj?=
 =?utf-8?B?YVE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb290b7-da33-4423-8bad-08de25b65aa0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:50:27.1420 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmGtV8YDkVV5dsx41lDEgCOxY8GexvPWclsbaEzRwMRKrRmzHIOerfJsM/8NdSanTKWFhcQnk4UREsEGiTkqr3kR7I3kYgtqybg1XtzjHes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR03MB7260
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


On 23/10/2025 4:51 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Enable storing the U-Boot environment in a FAT filesystem for Agilex5.
>
> This allows the board to read and write environment variables from the
> first partition of the first device formatted with FAT, in addition to the
> existing UBI-based environment configuration.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   configs/socfpga_agilex5_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/configs/socfpga_agilex5_defconfig b/configs/socfpga_agilex5_defconfig
> index 9ca1910d53f..1068957c2c8 100644
> --- a/configs/socfpga_agilex5_defconfig
> +++ b/configs/socfpga_agilex5_defconfig
> @@ -71,7 +71,9 @@ CONFIG_CMD_UBI=y
>   # CONFIG_ISO_PARTITION is not set
>   # CONFIG_EFI_PARTITION is not set
>   CONFIG_OF_LIST=""
> +CONFIG_ENV_IS_IN_FAT=y
>   CONFIG_ENV_IS_IN_UBI=y
> +CONFIG_ENV_FAT_DEVICE_AND_PART="0:1"
>   CONFIG_ENV_UBI_PART="root"
>   CONFIG_ENV_UBI_VOLUME="env"
>   CONFIG_ENV_RELOC_GD_ENV_ADDR=y


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

