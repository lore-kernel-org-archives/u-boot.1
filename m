Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8504BD47CC3
	for <u-boot@archiver.kernel.org>; Fri, 16 Jan 2026 10:16:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB8182BF2;
	Fri, 16 Jan 2026 11:16:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Qiyv48IV";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Qiyv48IV";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A81D383623; Fri, 16 Jan 2026 11:16:26 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37D4880077
 for <u-boot@lists.denx.de>; Fri, 16 Jan 2026 11:16:24 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Jerome.Forissier@arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=onuUZQ5ZQFWIpOdDcfWxidO/pLtVPzkxdtGSszHCmuOxLAKiDIKGcUT3zq4ZHNUlbjO0hnQ+DiucBu32OLBQ1beMEiotuPqfjk6h+yYbVzmdW2fnAeqOVAzx2QJtDyfAz1tbGonhaDhOCL/ZpSIEmJSCpmoKOctKmAcbjI5c4r7ZS1cQcdLvfSTV/iNZKcdwVFrEAXefOJTz8wTrCImgUQhSHg8dIyqLUWHp60/m5fil6El0A3csvqTyYFP3jOQt9dF7MJnuvuVJF/gbG0LDUoY2XS43OFvdC4+Fa5zwY9axPrKmMRUVnPmR9SMcDYt4IvU5EPDrK6z/mtLxXub0ww==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGOKvwKRWYXT0QvX70vzxk4RtEVXw40gBYBORlDVmbY=;
 b=k5S57OaQuE/d2aKBC3sg1Tv3g2RuioWPlTCFb1/GkPfbyiFPSUirzq0ShPBf3CknwQlIAU6avOhUBtEb/mrMiwvzo67/HHoCoMSzGUBif6tbU2G2IBiRroeyeo11bwdMUrbQNF3vwblbUPvk4PV/xBaAAXI47NQKI2BtR7JVNTXWNhQeo8C+esSjqUsQirqAfjLiqpTQLq0M1nYHPrLcg1evoEsbKNN2xrtBznKa0D0l/oqQEQuqDXvC95chFiKiTVcZgwQ/VU/rmCOlNuwPXNwRKrt5ICqLXcU3A4zt2F/CvoCNKEw76IBsO+0MeuFWFMnn/zWMLLd4o2cAa5Jyew==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=forissier.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGOKvwKRWYXT0QvX70vzxk4RtEVXw40gBYBORlDVmbY=;
 b=Qiyv48IV2n+DlsTBpJuJ5emrk26NGGusGtSNlRckd9pEOTwhfnvlinSOrKu0SH4pdaB/x+IWNeiNJWwYqtjQ1GmDVQiOLJD2hh5PjSFiFc7GqeMS7lKK8jfYS6edixYr0Qv+bgyphYD0Bc+Xt/5rL9N3plgv2VWSn9Gq/7aNPWw=
Received: from AS4P189CA0010.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:5d7::14)
 by VE1PR08MB5853.eurprd08.prod.outlook.com (2603:10a6:800:1a5::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.6; Fri, 16 Jan
 2026 10:16:21 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d7:cafe::2d) by AS4P189CA0010.outlook.office365.com
 (2603:10a6:20b:5d7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 10:16:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4
 via Frontend Transport; Fri, 16 Jan 2026 10:16:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qIUsNoYfTbEFa2HiMuJki4+0o0v7rEJCF56/PiSQiyvCQ58ivLQKswciHD77EaGPoSZqgd8qdswIJlfc4L25q0j7nEQV/uyhHIffr5o/viErFx6kwvY1cc+gB+LxF57IR7ZQg+LID7KRCgkl517NX+LNrSUzSQZggNVu1J8WE4Cqx32/Y8R0kfGcSJoToPGXwatxKv+Tk322qgygtu1STAcwSFtdq6tdfT7Uk3awZHXUn8bTim65G9skpOTmj+mAk9kACxe/RI+gXDZWFgIuwtiJHwfdWJ5jAiVFxkgLxTRRJT48h6ak6Lj55lTBlJSv/AVwMYKBfJR/dnDN8S2D3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bGOKvwKRWYXT0QvX70vzxk4RtEVXw40gBYBORlDVmbY=;
 b=vTQwxY1NeBG5jkxhV8oDmU9tdDbncbzmd1uR0SiEx9imsTBpfGyaWBOJnMHk7Vf44OJEblZuKe2q233lvkvSdyp3hLaIO2xCv1iAYJ8FgKvibUhhd2MSuRJxY+o+SA3OpzDvkRuWh554ym0NxPsGv4ZsuEz7YUts/U+khlqhxk7pO4Xj7QidtXSJOHk3oVLukaZkPU93NMp3uOZyz97xZhHt+qkjs+52ZyZZg9Glc4dXWY5aGH17VTHR9i8zJw8zirKoCAAC74aylvCe7FNaak7MGIPDGL668GkrizT+OLYy/q9MrtRaVK0jKSAHt0zrtPSpQYbNxJjGEvV45pWNGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bGOKvwKRWYXT0QvX70vzxk4RtEVXw40gBYBORlDVmbY=;
 b=Qiyv48IV2n+DlsTBpJuJ5emrk26NGGusGtSNlRckd9pEOTwhfnvlinSOrKu0SH4pdaB/x+IWNeiNJWwYqtjQ1GmDVQiOLJD2hh5PjSFiFc7GqeMS7lKK8jfYS6edixYr0Qv+bgyphYD0Bc+Xt/5rL9N3plgv2VWSn9Gq/7aNPWw=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16) by DU4PR08MB11271.eurprd08.prod.outlook.com
 (2603:10a6:10:61c::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 10:15:29 +0000
Received: from AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3]) by AM0PR08MB11733.eurprd08.prod.outlook.com
 ([fe80::29d7:e9ba:ff69:a0c3%5]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 10:15:29 +0000
Message-ID: <3793afa0-5d2b-45b1-9153-d78d0c9cd70a@arm.com>
Date: Fri, 16 Jan 2026 11:15:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: lwip: add TFTPSERVERIP Kconfig option
To: Jonas Karlman <jonas@kwiboo.se>, Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jerome Forissier <jerome@forissier.org>,
 Ramon Fried <rfried.dev@gmail.com>, Joe Hershberger
 <joe.hershberger@ni.com>, Tom Rini <trini@konsulko.com>,
 u-boot@lists.denx.de, nd@arm.com
References: <20260106203433.3133926-1-jonas@kwiboo.se>
 <7d2ac045-d364-4d37-b654-aa704cc07a7b@cherry.de>
 <7f9d6ad3-afd2-4364-8d33-8510e183642c@kwiboo.se>
 <a8a8dd8d-dfc2-4274-9203-a88d9bcb8a69@cherry.de>
 <c9664240-002a-418d-9301-e8307e3e0aea@kwiboo.se>
 <36c506b5-228d-47ab-ac6f-fb6dd784ff46@cherry.de>
 <77a9bf3d-6662-43fc-9ada-fedc5e611d23@kwiboo.se>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@arm.com>
In-Reply-To: <77a9bf3d-6662-43fc-9ada-fedc5e611d23@kwiboo.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::9) To AM0PR08MB11733.eurprd08.prod.outlook.com
 (2603:10a6:20b:740::16)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: AM0PR08MB11733:EE_|DU4PR08MB11271:EE_|AMS0EPF00000191:EE_|VE1PR08MB5853:EE_
X-MS-Office365-Filtering-Correlation-Id: 02035740-0940-4eb1-de15-08de54e84b9c
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?WUgvYVR3MzJVZDRGTWx3a09kcXNCbDBiUHRuaHlGOXFTTHFZa1BucWFaZGg0?=
 =?utf-8?B?cXdIWGdKL2hCNzhBQXJXVlVkcTlWOExJTW9CR3ZaSGQ4WEdmVWMvazdKMEl6?=
 =?utf-8?B?cVlwdjUxZ2ltRmJLWDlOaExQajBTZTJNUzlIcWFCT0p3dFY0a3lTS2Q4bGJK?=
 =?utf-8?B?eVZNeWdIU0l5ajRSVHhWRXhySGVEelNTWFcxQ00zNVpWZTRUNVVzaWt5RmRs?=
 =?utf-8?B?OTBXaHFjMW16eFFFRy9idW00R2ljY1NGK0FVMnJHMUV4M045TnBHUFI2cmRI?=
 =?utf-8?B?UEdpSkVlUU9wNjk2ekVpUjJUR1UzTkhGQ2o0KzNNNUdhSXYrTHdlNjJ4WEdX?=
 =?utf-8?B?K1NIOG4zYysyVkpURmN2V0dRc3NKM25VMHRSTmhrbitJVUphV1Z0UHVvdnRV?=
 =?utf-8?B?ajVKZHRXdWV3UkFVbEQ4MWlINFZFcXp1RFNzL3RnamJhdXppek8yUlhsYmxP?=
 =?utf-8?B?emNBdEJFTWRGeFlJVHJFMzIxaUJkQlhUMDN2VUxpTmJETzBuK3VUZW9oUGla?=
 =?utf-8?B?QzdGdEM5a0xVR29BTDFJcEpURkpGZDB1TW5hYkNnNGlualRISk5ZeCtQbG5n?=
 =?utf-8?B?ODgyM1pYeERQQXZLRktCT2d6aGo3RVFjaFpYdkFZVXpWcGdGZ0hpcmg5L0FU?=
 =?utf-8?B?NlVWUHRINnFLQk42d1Jud2FFaTNXOEVzRU5ScUtvMmFReWtmbVh6S21zUWZO?=
 =?utf-8?B?dlRkSnFQNFcyK2NCM2RleEtzLzhsOXQ5K3QzTlJJUUhCMFYvaFZYNkN4MFQ1?=
 =?utf-8?B?aTgzakt6WnljNVphT1BKcFR4aTlGUVVwNUk0eUcwZzU4WFBmQnRKUzY1b1NP?=
 =?utf-8?B?WDNTVnFhUURtSWNySVp1SDF1dW9URWpFN2pwUzBoUUpObzJlMC9NbE9Na05i?=
 =?utf-8?B?RkxlYmR1cy8zZFlUS2ExdmhwNVAya1JtOXFOQkdyQUVteXltNDdjbHRkVm00?=
 =?utf-8?B?MStIclBaS3MxOVUxR3BOeXhGSllFbGh1VnBDaGFsNEt3RGx3NkxqeE9pemJ6?=
 =?utf-8?B?OUR5RGtpQmxHRFVQdE9GTW52V0VVRUNMaHNQSnkwQWtIN0poQVhxZHV3akdx?=
 =?utf-8?B?dXpkenAvWnl4WmZucngvUWUreWhBZzBrcUx5OXZERm11SmYrY1pJeHNkSUlS?=
 =?utf-8?B?TVZxalVOVjh2YkN1SWMrcmZ6NThsMEhYSUk5cDJ0ajZJbjYwczhJUDJVc1NK?=
 =?utf-8?B?RVhUbVFjVURsSlBvVlV4NE52a1BTTDdQY2RHc3Jqd215cStjN095SEpQN2Ir?=
 =?utf-8?B?WWxVaUp2aElCVEJ3Q2Q5dk1qdUlXakdoY1d2QkZxNlBtT2xKR2JldDRuQW5m?=
 =?utf-8?B?dExQQ1IyUkhXVnRSMUNMbFl3SjI4TGZ2WE1hOWw4NkZXQ2JUbkx3OTdLRVVF?=
 =?utf-8?B?UVVVck82Y0FSeWgwKzB3TzRFNVJ6cGNtK2FsV0xiMGFyd1FCZG9iYW1pY0hu?=
 =?utf-8?B?aThlTWJXZ2pzYTU0UEZJb0RaaHBxUURXdWlpL1dxb0JBUWhBTkhuM2h4MU9z?=
 =?utf-8?B?NkkzRndiRHh2TG5uenZkN01JRm9VK2t6OE1RUFJmL3AzZWpweTRDQjkrMDc2?=
 =?utf-8?B?T3RIUFZkc3NTL0pXQ01LVjRYdFhLeUt5Vk5ULzRqalIxNjdVWDNjODhYMUlo?=
 =?utf-8?B?OGFYeDJuMmQ4cVZWQmlwWTYrTzFSVGhPZGp0RGJ0WllZb1RaQkp4K2JtdWZQ?=
 =?utf-8?B?TmRoQUVUeEJaOEZVNUlxUzFQbUl6b3duUkZUWU41QjJIalRjaXNzMzZjSDgy?=
 =?utf-8?B?ZHl2Y2VrQ3ZkUWhlZytVWGM1KzBQeTBnSnk4QzJmWGR3MzJxNWpRNjZ1eHFn?=
 =?utf-8?B?Z0xPMk45bTNzeVJtRktFVmRQeE9BcDdOb01LdHppS2E0V3ZBajdyaWJZeHZB?=
 =?utf-8?B?SmlaeVVzUlNIL3NXajFBSW1rVFQ5ekFEclpRS3ZlK1N0cTE1cmRrZUgzVTNw?=
 =?utf-8?B?V05oV1R4VUN2VEtzWHF5aERLaGlhNFZXaWVEZWpFRE4xcHdsM1FJODRGUWp1?=
 =?utf-8?B?aDdTVDlGNXMxcWU0V2FRcE1sYW1oZ09rQUhLNFNXUmpUNzBleTZnU09uNXFC?=
 =?utf-8?B?VG4ySGpVOUJwSmpzUWhjTDFzVnVQdTFDalBwQXZrUS9mVzJtWHRhN2RuOW5j?=
 =?utf-8?Q?Jv6A=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:AM0PR08MB11733.eurprd08.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR08MB11271
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: c001b058-e66c-43a7-95cc-08de54e82ca9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|35042699022|14060799003|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RExvTTJ4Vlg2Q0xndjZ2aStKTmtMeWJLYVRsdHgxc2JuWHhEem5wVlBUUjNv?=
 =?utf-8?B?Y3dYNHdrbmFPKzdqNVZGelVQdjBXYWRVV29uZHlTMFA1UXg5MGtNUWM4V1Ux?=
 =?utf-8?B?T2dIZnNYTTlKaFY1eCs4ekhveUVFMDk1ZnkvR2tyY1dCanBNN05XUE1Hdkpz?=
 =?utf-8?B?cUJ5d0NZOVQyVkJzQlFnQXhZbkxnSVRDVUsyUzlsNlhNVmdVQUpQbERoa2ZS?=
 =?utf-8?B?enpSUjVscGNsb3pPQ2xLc3B5ZzFrMXZlU1NYVG1jTk5UUGJWUmNFcW93UVlp?=
 =?utf-8?B?QWQ5UGlwM3RIbW1KWFdOL1JhYWMvTm5vMlN4OFFONUxoVkF6VzFMb0s5a3Qr?=
 =?utf-8?B?eWZkOFBDZEJ3SjI5blhEcTF2SEdERTNFOXN6dStmcWtSSFJMR3B3R3FqU29k?=
 =?utf-8?B?cXNNbDZENTJYUnp3bG9OSG13NTFSWjMxL1BkV1dOVUNMOUUycWhzNFUwWDF4?=
 =?utf-8?B?b0VVaVpJNmF3UHl4L0c0M2tlL0dieDNoSy9RaEdTTmN1SHI4QU1UbTZib3lo?=
 =?utf-8?B?dFR4NDZjdzVWRURhZkdhODJHVGlsUlpnVzVYV3VaZk4raDVjVFIxS2xXZmxq?=
 =?utf-8?B?SFR5cDBnZGgvQStGS01XaSt4VGNRMDZkekJkSHpDQmhMVERsWHNqbzNzZGty?=
 =?utf-8?B?cm5vV0Y5Rll5VGpHbXFzZGNQRXRSK2w0c1Z1emcvaUlTcFMzU0hadHM1ODlw?=
 =?utf-8?B?Zzk4bTBXaTV4dklYK0FZME1rZEFEUndIZTNJRGtwa1Y0c3AzNmNmVEV3aTA3?=
 =?utf-8?B?WjA4OWY2ZVRXSFNKd2tiN25mTjMyaXNtRmxRczVVTjZqN3JtYVR6UVowMlU3?=
 =?utf-8?B?U1BZT2lzVUtMV2RCSTg1TnRnOHFkUUcrNG5rcWJmWGtLTlhmT2pHdm9rdm1B?=
 =?utf-8?B?bkE2TzF2UUoyYXdHOXBIbGE3cnBzR1NXa2FRM3BaQ3Jxb2FNcnh5Vk9MbWVY?=
 =?utf-8?B?UlB5UFF0MkpYcHZxeU5PRFNUQjFXcGtWZllYYWhiTHFzcTVscGJOa1hqdmY2?=
 =?utf-8?B?YWJCUnZiZTdDTSthbmVnbnNoQWxZWk9URnFVOUFTQURtZ3N5OUlvVERTbUF5?=
 =?utf-8?B?a25rb3JXcjRZVjIyd0V3RlRCWmMveTQwdkY4S2pXVGVpZjg2VXZsdnBPVDNO?=
 =?utf-8?B?Z1VoR2ZJYzI2bW00c2s4Ym9QYjV6N3g3SzlnS0k3ZTluSkRtdDVOeW8yYlhm?=
 =?utf-8?B?eXdsTWtjUUNLdVgyVlV2NHErRlJoaTZ2c1E0RklnYlg5WXZEZ0xHNEpzMDZj?=
 =?utf-8?B?RC9oQjJkNjJKeE5nSVRRVG1BOFFjTS9uOGY5YzUreEZ6cnNCaFZDZ3BmeHdM?=
 =?utf-8?B?VnlBY0xtcTZpOWpIdllEdHEzcXBxOGdtMGZ1ZjFwa3I2akJWTS8wanVONlMv?=
 =?utf-8?B?Sy9RK2FOSm5YYzUxbnNMQlRDU09oeTlWTjA1WWZyNVlqUVIvdjNRSENRY0Vm?=
 =?utf-8?B?T2RuSVVXdDlkL1l0YUxOY2xySnRYSjk3ajk4Y2RRUDZzT3piRk8ybFRXUmJo?=
 =?utf-8?B?QUFqRFlwYS9PRzNRMy9pdTVqdUIrLzBtTnBGVnNoT0JsSlN5em1jelJTejNv?=
 =?utf-8?B?RHpHdHV6TVJCMWRWcDh1M2FZdlEzSlZ6NFEyWk9YYnQ3RW5sV0hncFZCbCtt?=
 =?utf-8?B?cy9seVZzZXhYMk5yZnAwbi94OTZZUnBrR3FTejF2UE1XSXJ2T0ZDKy9lUjgv?=
 =?utf-8?B?K1g1dHRJeXB1UEppWXBPbTRGanJDZ1ZBTS84azI4b094bG9QRi96SkRIekRn?=
 =?utf-8?B?d3RXVkpmb2UzUWpTOVBtNzQ4UnVzcXpkbFJjQUN4LzRuMFkvWWJQamd1TEdZ?=
 =?utf-8?B?QXk2ak9uVGgxSlNRUDNKM25ZaGVGbExrTExvdldUN2pIKzNIZFdDSDJyQXVZ?=
 =?utf-8?B?eko3Z2I5dWhPODlHa1JCc3JjTmlPRHFQMU5VTkFPWU14d3dzQXpYTTRDcjIz?=
 =?utf-8?B?bTB6cWYzUlA0Qm1oSlJSZ3JOTldWeVV1cWVRZ2Z4VVR1UXFMcFA0UVdTTWt6?=
 =?utf-8?B?R1BwQlZMS0ZyWktWUWRFdjZhT1pwMlhCME9BR2NLVUhwWFB0WHowaThCTzRR?=
 =?utf-8?B?K0h3UTMwWkM3RXl0UUFFaDlYekh1Q2ZsUGVMcm9MREE2dXR2SHhPR0FSOStq?=
 =?utf-8?B?WWRUajM4RDZOcTRVMCtEYzk2Z1YwS2RRckpzZDRTa3VoUmdLNjU5OG5mclFD?=
 =?utf-8?B?UUVjeC9MWmJwYzFjNUYrQmhzMk1VZjdKSWp0S0lwN29XV09ZR0FxK3RqcGNE?=
 =?utf-8?B?UVBSQUVBNG1oQVNKTWtDZVFnWGlBPT0=?=
X-Forefront-Antispam-Report: CIP:4.158.2.129; CTRY:GB; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:outbound-uk1.az.dlp.m.darktrace.com;
 PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(35042699022)(14060799003)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 10:16:21.0104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02035740-0940-4eb1-de15-08de54e84b9c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d; Ip=[4.158.2.129];
 Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5853
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

Hi Jonas,

On 16/01/2026 10:28, Jonas Karlman wrote:
> I took a closer look at how the UniFi dnsmasq config was generated and
> noticed that I must configure the "Network Boot" option and not the
> "TFTP Server" option to have a generated config that make dnsmasq
> replace the DHCP siaddr field with the TFTP server ip :-S
> 
> And legacy stack seem to work as expected and correctly uses the
> expected siaddr field to configure the internal net_server_ip var.
> 
> Following diff seem to make lwIP also pick up the siaddr as the
> tftpserverip (in addition to serverip for the DHCP server):
> 
> diff --git a/net/lwip/dhcp.c b/net/lwip/dhcp.c
> index 731b57de3ba4..a3445a48b15d 100644
> --- a/net/lwip/dhcp.c
> +++ b/net/lwip/dhcp.c
> @@ -99,8 +99,11 @@ static int dhcp_loop(struct udevice *udev)
>         env_set(ipstr, ip4addr_ntoa(&dhcp->offered_ip_addr));
>         env_set(maskstr, ip4addr_ntoa(&dhcp->offered_sn_mask));
>         env_set("serverip", ip4addr_ntoa(&dhcp->server_ip_addr));
> -       if (dhcp->offered_gw_addr.addr != 0)
> +       if (!ip4_addr_isany(&dhcp->offered_gw_addr))
>                 env_set(gwstr, ip4addr_ntoa(&dhcp->offered_gw_addr));
> +       if (!ip4_addr_isany(&dhcp->offered_si_addr) &&
> +           !ip4_addr_eq(&dhcp->offered_si_addr, &dhcp->server_ip_addr))
> +               env_set("tftpserverip", ip4addr_ntoa(&dhcp->offered_si_addr));
> 
>  #ifdef CONFIG_PROT_DNS_LWIP
>         env_set("dnsip", ip4addr_ntoa(dns_getserver(0)));
> 
> With something like that I do not think I will have any further use of
> SERVERIP or TFTPSERVERIP Kconfig options for my labgrid farm, so can
> probably drop this series and will instead send above diff as a separate
> patch.

Sounds good to me.

Regards,
-- 
Jerome
