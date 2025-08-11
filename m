Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45F80C87FD2
	for <u-boot@archiver.kernel.org>; Mon, 11 Aug 2025 12:11:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3E65832AD;
	Mon, 11 Aug 2025 14:11:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="IyG6bCja";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A38B0832BC; Mon, 11 Aug 2025 14:11:28 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DA76B830B5
 for <u-boot@lists.denx.de>; Mon, 11 Aug 2025 14:11:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nYWo37wvmKGnfn4bLQ12qlDNAyLOniIzSDntC2RyiDbA2yyhwtM0bgCrFGzUYZM/Jd96/2j449gUUzLJIgqJ2s3WDfgne73iXB+eCTbrYteoB36YJt7p7milZ8GWonv9AAtLdi6bk+J/A0YYiE8i4mDx9gRWfA0S/4cQDsyrlYTu2LNfBJw6P2yFIi5UwmWV2EQLlg/lZ1U+6YQr3shXUPqyiopGuzitxJIaHDm2XlU5uOYL4CKMfhKRj9X4chK27kFSksW9/OUb2o+0DzHrJ4UyCofPAHgUSPA/c/KJwqQWSIGblu0aXdqBJRRwIyf8lDFeLX1zlKJE+JC1FsGFug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdtJTqy3MtSN0dvBQ2Bf2sbFohuc+KNqGGVCENcadtw=;
 b=lZPu6bZmuOPKbceSvhj4YqlZLoDqOBIqFWEXn8wHL9EjTLLhAnzRL9J9N13AwLLGc2MkEyuWrizfmMmbDosfm13LRlJy8TCEYbINd+hmlX1hhheTtJ5qr8myTiKtBBdFESp0BBn2pbWj4MI3lMsI+qyFn3W6LE/M1FcrPwt2QhMqqEYi2G8dpkV8PYCy7nmiO7ton9SMc44gNsKlo1VRhye7jd+o0uRW3yXhYNxsggmoDjclX7l524GDpGj1A0f0+gJINj7JgAvDp7ec0pwR6adIOS1r18vgsHcQu3XEwMRr4lyO/myIz7m+clyKWKVMVOwHo3n8FRCXM5MUggYoOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdtJTqy3MtSN0dvBQ2Bf2sbFohuc+KNqGGVCENcadtw=;
 b=IyG6bCjaqtqu3ekbDidfZhkRD6Lqt9qfXdd19AgZSsTHMkntwa0PbVVld7Js3PCNpIEdIMkc7apA8dG3rKSJpjYrXE/RpATMFRPwKq9RMSiV9Pz/3JBZv/uADVmtDwPtaS0yyk+3tKLO1gnJEIXaS/Ax9o6MZZRC6+8F/HIvKQk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB11070.eurprd04.prod.outlook.com (2603:10a6:800:264::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 11 Aug
 2025 12:11:22 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9031.011; Mon, 11 Aug 2025
 12:11:22 +0000
Message-ID: <334d11b4-20c2-4367-9b3d-9720b2209dcc@cherry.de>
Date: Mon, 11 Aug 2025 14:11:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] rockchip: Add initial RK3582 support
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Tom Rini <trini@konsulko.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>, u-boot@lists.denx.de
References: <20250804181638.3855760-1-jonas@kwiboo.se>
 <20250804181638.3855760-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250804181638.3855760-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0074.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::20) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB11070:EE_
X-MS-Office365-Filtering-Correlation-Id: e67d469e-59e7-427e-0464-08ddd8d02f9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U2hvd0o1OWtVVm8yTjRONlBISFhjekorWGFWODQ5M1h0ZWRrU0pyYVRhSlc3?=
 =?utf-8?B?bm1OOHQwUkVPbnppRnpRcVFVUUhHRXdjcjZDb1NEWWYzcWxPblluaTJ0ZGlQ?=
 =?utf-8?B?SmNyVnBUaE9HVjJlay9kVm1WZmY5NnhldzNNamJXaHVRUGhUVEtuVStmYUF5?=
 =?utf-8?B?ZUY1SDdOQU93SUpwSnFGWk1zSVVXYmFCb1RQQXZIcEdVTDlDRlF6MlBHdjZO?=
 =?utf-8?B?L3AvUzJkYjNSVlNzMWlLNUZBNVpPNnp4Q3o2b2IrZmZDU0UxUmRZNXFRN1p6?=
 =?utf-8?B?YTNKYS9oQmNYSS96QmRKL3ZIVTAyWXFJaDEvS1N1dm9USWpVLzY5My9BVTh4?=
 =?utf-8?B?K2lUdmM3MkNaYTNaUVFVcldzZjJSejZEc0ZvTnlhSzV0WmtUM2NwRlBmNEUx?=
 =?utf-8?B?bWZEcmZoWkEzSytlaUFXWm1rcEpJa3N5WTZyb29sazd6emFKYXVmcWlmTm14?=
 =?utf-8?B?QWxmOW5wM3FaQytKVDdZRVdFYXRRd2JZeDFPeEd2VnhXNFhzQ2ZhZHNZOFlv?=
 =?utf-8?B?SllxSjJOZ1ArNHpmRVRPQVNtQ09Hc3h5WXlweXBabHVIUEt5Y1VqdU1kR0Ny?=
 =?utf-8?B?M3I5OWgyaEYvR1lJMnNiL29nQ3Qyd2IzQnFsa3hFSlRlNCs3N1puVTZhZDZx?=
 =?utf-8?B?UGJQbG54MTZYOWRBNEMwRDdTejhrMit3UzFFczUwZk90UTFCcmc4ZTlwV2pr?=
 =?utf-8?B?OCtJZ1F3Y3JCL0lTRHdtQjN6SkFZYTlKU0cxYU5IM2RxMERMa0ljZDI4Rnha?=
 =?utf-8?B?MkY2OXlGNkZhQjZWMVU2d2Q3LzJHUUZSZEhmZTUyNWhHWTBEeEUrNXJSSnFv?=
 =?utf-8?B?ckdJb21BN1crSS94QXBOdmFtRlRPY25PcDBjbkZGUGcyKzVpSFRpOTZSNlY5?=
 =?utf-8?B?L2RXTThKTmJad1RzV04wWWhtZDgwSUVJMTF5ODRkdjhDT0RYODJmMFpJVDhs?=
 =?utf-8?B?RWRNaEQwQVpkczhlRnc2KzdaM0l1MXN2WEt6Vkpya3BZcG1OVVpMaW1vdTg2?=
 =?utf-8?B?alJZWFNYbGs1eU1IVE8yckJHQzNjWXNxblAvNVhCNEZpck1uVnZBZzkwRmVx?=
 =?utf-8?B?WjR2NXZIQksyZjdrYUtwcC9SbGhIV2UzZndwMUVtNGpSRXdGa29QdWc1ZmdR?=
 =?utf-8?B?dlQwWnVUTGxwRVo2VEVWdW1KeDQvRWJxOElPMmFNNkhnZ2YzNzFDdElHT0dC?=
 =?utf-8?B?V20xenZrSzNlT3h2ZTFSM3ZBWmsvV1lCQW84d3B3SWdNY3cwcHpxbEtBQnE0?=
 =?utf-8?B?dEhkZ09ERjI3Y2NscW9rNk9HcVJkNGMzWWowd3VmY2RMTzUyRUVYakNEYmhF?=
 =?utf-8?B?WFdNR2ZCdFVVQW42WEJaaHJMb1ZRUE80dEw2T2ZyTlJFalFoWHhtL2lDN3VU?=
 =?utf-8?B?OFZXMXhqYVllWDRzRSs4QXNwTEQrYjlSUmNvUWg3NHFvMEw0K3NqY2FuMGZC?=
 =?utf-8?B?TUpWQ040S2hoaDAyTER5ZG5HcldjVDQ3U2N0V2JRQUE2KzB2UXNZbXVjQWlN?=
 =?utf-8?B?U3ZMNkJ1NlVrZFR2NWpjalhGbnpDOHhTd1k0aWV3K2hWaWxwaXh4UUUxUUl4?=
 =?utf-8?B?N2FVN21lSjlrMkNOaGxYT09LVzV6aDYrcjRKKzdsN2FJaUNRUXF4Y1pVK0dj?=
 =?utf-8?B?aEpSbkhmNGRwMDAwSXhEQVFoczd4cmpvSkRWeDh0dEhzV3gvaU52Q3RDUlN4?=
 =?utf-8?B?cVBHVVdZNG1rZFhQcjFNeWNMclAvMWNURUdDZ2hVcGhvcERjVy8rVVp6MVdK?=
 =?utf-8?B?ck5rQ2xGSXpadmRhUE43ZUtlalRtM2puYks0cHpKRVNFenA3a0pCNW1tT2o1?=
 =?utf-8?B?NTJ1M0Zac29ibTYrM1dhSVJNTVJVVXFnNUxHQzhIaWdoVG40bFVTSDFkeWRu?=
 =?utf-8?B?OG5zNlh6SWhkQklNTnBremh6TjVUU0U4WkFJV1IwWmF2ZEZwaXlPZ1RTUmVn?=
 =?utf-8?Q?zht0QeNoXx8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xKd1dSK2hGbkNLdHFSYy9WbGRMT3B6L0hnVThqVnhEamhVUHpscEwvUEdm?=
 =?utf-8?B?UkRVeU9kMENGYXR3dmlzVk1NUEZydUtnY2NQSkRDdkgyOUg0OVlrMkJyT3hh?=
 =?utf-8?B?YWdNRmEzTmRMQldDZ2crc0YzMUEyVjFaSjZhRUpxQkpZTFFlUzV4c3FxOVVl?=
 =?utf-8?B?TzRKYkJRTHRWRFNpWTd2UVhEUUd0RlNKamFhUTNIaVhoK1BpSGFSdDJwRGhE?=
 =?utf-8?B?V0dLQkl1a3kzeC9BMG5QaWwyYzJIN3hENU5qanRhOGNTMFI4MXRaK3plS29j?=
 =?utf-8?B?eFZwMjY2WEl5THhxR0cxRnlYT2ZBWWFPY1g3M3d3TWVwWFFRTlR2cWFYOHpy?=
 =?utf-8?B?bVJXZVBhRi9UZmlxeVM3V0cyQTVzRFBleStmc2VUOS8vTDJHWlV1aGIxWVhy?=
 =?utf-8?B?dDFHcmJ3ZHRURitscER4NGNIdzF6VTR1cFZtZkduN29wbWxtT1p0T0xwdVU4?=
 =?utf-8?B?UHpqQUJxSnhDb0lSQ24xempocWNWK2dVVVF5cG9kVUc0eHNyb0haUWFBVGNk?=
 =?utf-8?B?NDVlajNpdGFTeER5ejBwS1N5R0FPR25vTzRPWFlGUEhsN0NSaEJkVDNSai85?=
 =?utf-8?B?aitmcmVkU2VTalJZUEl1Zm1PTkNSL2s1czdFUk0vVGpweDJzS2VvaTVJNTB5?=
 =?utf-8?B?aTdFd3l4czhMMnJDZUpCNlFRWjV1dS9mZXRDMnVUQ0ZpMDFHMEd3STY5dHpR?=
 =?utf-8?B?cWtwM2dQUlZ4OUJNL1VMdlY0aFZSZTVyNWhHRnlEMmZnWVdjTGtsd1hKdzNI?=
 =?utf-8?B?Y3I1QWEwTlpMNUhrWHhsVDBmQ0ZVUXREVTh4OHFHRWEvS0hYRGY1RXZVZUZE?=
 =?utf-8?B?MEZxS2pINkFxNmNsQWNPQm94UStCQkt5cGJsTWRRamJ4SzFPSTBTU1ZZTjdy?=
 =?utf-8?B?VmFZa3llVmovZURVaEpabzRFblRjN2pDNnhMWVRVRVJZY0JsZm1hL2NOU05V?=
 =?utf-8?B?d1Arcm51K2QvMTY3QXlJTytkWk9idFZHMkx6TEFmWXZtZE41dmtSaUJrWUdO?=
 =?utf-8?B?QjZJWWZKYXdxa1lLQWI5a0VPc3V4Tlh3M2JLWnFPVVFkdmd3blUvdU9MNGhl?=
 =?utf-8?B?dkg2SWh5SURmTStwcGtMMTYwcDczT3QzaXpMVTIra0xuTExZWlVrQ21xaUlL?=
 =?utf-8?B?UmpKRis2OEpTTmtFY2JTZTNXSGZyeEEvNFZJWFpNWmsrdS9PRGNqVUxSd3gy?=
 =?utf-8?B?R21nTEZNcEtsWW9ZUGF6TVVEV3YrcGNYMlZ0Z2lyMzlyMlFNODg0YUltUVlI?=
 =?utf-8?B?RWMvdXdTbHJMOWpJcFZTOTFwNzZJN21uRDM1b0x5SGxoWmpSUFR4bDNWbm0r?=
 =?utf-8?B?aUNaMDlHdDdoaGpIcm1HVXZJN0cwMnEvQUR2bjRtK0FUQTFQMTJ4cGdVOXho?=
 =?utf-8?B?NWxuRnhjUG9RTWFGTmUrVlRBVkg3Ump1dFc3bWFGczRPdFhRbmxrUW15ZUkv?=
 =?utf-8?B?SnRCdjVkV1J2N0JGbXd4SFBtNXB3ZzJNV0tTWjlvRWJyZjRSOXhFWTdlU3h3?=
 =?utf-8?B?bURvZkVrQmxSWTVBUEF5b0p1aVc2TGRvbDgrRzlTUVBFazlqWGIrenQ4L3d6?=
 =?utf-8?B?OEt3TG5NNWNjRThvNEtHemlNdmxmY0hldlhpOTl1bVUxU1cvNnlHdlUvbGRs?=
 =?utf-8?B?aHltTXlPbnJneXBQenZBS2JoWWtDOTByc0dQMk5FeXdDNWlSR3JNKzMxc2dh?=
 =?utf-8?B?MjB2c0xNY0FJVDZPdVFKL1hFdnBHQ0p4d09iTzNTYlByQzlwUHJEQzV6RzlN?=
 =?utf-8?B?R1FZZjlvRkkzNXMzcll6MEpEZjlYMitzVUtlVHZpT0pROHNJUkRTTXA5aERx?=
 =?utf-8?B?QndvN3psdjh3WFFMVWJNUVRZMXJ2ZmlVaFF3RjJxTGYxMk5lQTlJbkdXNlJw?=
 =?utf-8?B?bGRtVkdvTi9oUzY4WFhsQjJnUDBKeDlOMnJOTWI4eUNVT20yOVNRZTY2ZUta?=
 =?utf-8?B?TnFJVnhWeGxwYzhoZ3dSTFQxNDhxdUJZTkFpbkJwRmQ2WEp2MzhhRkFmbE1m?=
 =?utf-8?B?WmFiYm80YjkvY1Azb1hrcC9RcnRiQ1oraTU4UmZkc0VjL0QwUmNHelArNTdi?=
 =?utf-8?B?Znplc2lhVXdzbUhsemVJaGpqNGZuNkdoblFjaVFDVHRvcUpvcldaWUhYczUz?=
 =?utf-8?B?VU9VaW0xZ0REOTBQSUxOL21EeEFlTmtjRi92NTVhYzVPRnFWMjNRQ1JGbVBv?=
 =?utf-8?B?N3Jhc25Eclh4dmN0dnR6akJYc2ptcGEwSytFeE9kV2oxRXpjOFRDTnR2L3Ni?=
 =?utf-8?B?a3hNcGlhWmJDTnp1TDBLNlpQWDVnPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e67d469e-59e7-427e-0464-08ddd8d02f9b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:11:22.1551 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xnOi3jLMK+FmKOK+DTGxz5SzGl6XciHnba0Xe+lKnxkO6oZInON/IEQjF8L0B/SnCKByRP2wxhkcEe7tAw9LOFA7vs1ik6K8L99ITyZyBrs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11070
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

On 8/4/25 8:16 PM, Jonas Karlman wrote:
> The RK3582 SoC is a variant of the RK3588S with some IP blocks disabled.
> What blocks are disabled/non-working is indicated by ip-state in OTP.
> 
> This add initial support for RK3582 by using ft_system_setup() to mark
> any cpu and/or gpu node with status=fail as indicated by ip-state.
> 
> This apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
> cores and the gpu is always failed/disabled.
> 
> Enable Kconfig option OF_SYSTEM_SETUP in board defconfig to make use of
> the required DT fixups for RK3582 board variants.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> Changes in v2:
> - Refactor code to first apply policy to ip-state and then fail cores
>    based on the updated ip-state
> - Add support for failing rkvdec and rkvenc cores
> - Append soc compatible to board model
> - Not picking up t-b tag due to significant changes to patch
> ---
>   arch/arm/mach-rockchip/rk3588/rk3588.c | 221 +++++++++++++++++++++++++
>   1 file changed, 221 insertions(+)
> 
> diff --git a/arch/arm/mach-rockchip/rk3588/rk3588.c b/arch/arm/mach-rockchip/rk3588/rk3588.c
> index c01a40020896..3ab0afe0979e 100644
> --- a/arch/arm/mach-rockchip/rk3588/rk3588.c
> +++ b/arch/arm/mach-rockchip/rk3588/rk3588.c
> @@ -7,6 +7,7 @@
>   #define LOG_CATEGORY LOGC_ARCH
>   
>   #include <dm.h>
> +#include <fdt_support.h>
>   #include <misc.h>
>   #include <spl.h>
>   #include <asm/armv8/mmu.h>
> @@ -200,6 +201,16 @@ int arch_cpu_init(void)
>   
>   #define RK3588_OTP_CPU_CODE_OFFSET		0x02
>   #define RK3588_OTP_SPECIFICATION_OFFSET		0x06
> +#define RK3588_OTP_IP_STATE_OFFSET		0x1d
> +
> +#define FAIL_CPU_CLUSTER0		GENMASK(3, 0)
> +#define FAIL_CPU_CLUSTER1		GENMASK(5, 4)
> +#define FAIL_CPU_CLUSTER2		GENMASK(7, 6)
> +#define FAIL_GPU				GENMASK(4, 1)
> +#define FAIL_RKVDEC0			BIT(6)
> +#define FAIL_RKVDEC1			BIT(7)
> +#define FAIL_RKVENC0			BIT(0)
> +#define FAIL_RKVENC1			BIT(2)
>   
>   int checkboard(void)
>   {
> @@ -245,3 +256,213 @@ int checkboard(void)
>   
>   	return 0;
>   }
> +
> +static int fdt_path_del_node(void *fdt, const char *path)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_del_node(fdt, nodeoffset);
> +}
> +
> +static int fdt_path_set_name(void *fdt, const char *path, const char *name)
> +{
> +	int nodeoffset;
> +
> +	nodeoffset = fdt_path_offset(fdt, path);
> +	if (nodeoffset < 0)
> +		return nodeoffset;
> +
> +	return fdt_set_name(fdt, nodeoffset, name);
> +}
> +


Wondering if this shouldn't be something to add to the fdt "subsystem"?

With tests and all?

> +/*
> + * RK3582 is a variant of the RK3588S with some IP blocks disabled. What blocks
> + * are disabled/non-working is indicated by ip-state in OTP. ft_system_setup()
> + * is used to mark any cpu and/or gpu node with status=fail as indicated by
> + * ip-state. Apply same policy as vendor U-Boot for RK3582, i.e. two big cpu
> + * cores and the gpu is always failed/disabled. Enable OF_SYSTEM_SETUP to make
> + * use of the required DT fixups for RK3582 board variants.
> + */
> +int ft_system_setup(void *blob, struct bd_info *bd)
> +{
> +	static const char * const cpu_node_names[] = {
> +		"cpu@0", "cpu@100", "cpu@200", "cpu@300",
> +		"cpu@400", "cpu@500", "cpu@600", "cpu@700",
> +	};
> +	int parent, node, i, comp_len, len, ret;
> +	bool cluster1_removed = false;
> +	u8 cpu_code[2], ip_state[3];
> +	struct udevice *dev;
> +	char soc_comp[16];
> +	const char *comp;
> +	void *data;
> +
> +	if (!IS_ENABLED(CONFIG_OF_SYSTEM_SETUP))
> +		return 0;
> +
> +	if (!IS_ENABLED(CONFIG_ROCKCHIP_OTP) || !CONFIG_IS_ENABLED(MISC))

Mmmmm we should probably think about adding xPL symbols for 
ROCKCHIP_OTP. No required for this patch as we already have code doing 
that same check.

> +		return -ENOSYS;
> +
> +	ret = uclass_get_device_by_driver(UCLASS_MISC,
> +					  DM_DRIVER_GET(rockchip_otp), &dev);
> +	if (ret) {
> +		log_debug("Could not find otp device, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	/* cpu-code: SoC model, e.g. 0x35 0x82 or 0x35 0x88 */
> +	ret = misc_read(dev, RK3588_OTP_CPU_CODE_OFFSET, cpu_code, 2);
> +	if (ret < 0) {
> +		log_debug("Could not read cpu-code, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("cpu-code: %02x %02x\n", cpu_code[0], cpu_code[1]);
> +
> +	/* only fail devices on rk3582/rk3583 */
> +	if (!(cpu_code[0] == 0x35 && cpu_code[1] == 0x82) &&
> +	    !(cpu_code[0] == 0x35 && cpu_code[1] == 0x83))
> +		return 0;
> +
> +	ret = misc_read(dev, RK3588_OTP_IP_STATE_OFFSET, &ip_state, 3);
> +	if (ret < 0) {
> +		log_err("Could not read ip-state, ret=%d\n", ret);
> +		return ret;
> +	}
> +
> +	log_debug("ip-state: %02x %02x %02x (otp)\n",
> +		  ip_state[0], ip_state[1], ip_state[2]);
> +
> +	/* policy: fail entire big core cluster when one or more core is bad */
> +	if (ip_state[0] & FAIL_CPU_CLUSTER1)
> +		ip_state[0] |= FAIL_CPU_CLUSTER1;
> +	if (ip_state[0] & FAIL_CPU_CLUSTER2)
> +		ip_state[0] |= FAIL_CPU_CLUSTER2;
> +
> +	/* policy: always fail one big core cluster on rk3582/rk3583 */
> +	if (!(ip_state[0] & (FAIL_CPU_CLUSTER1 | FAIL_CPU_CLUSTER2)))
> +		ip_state[0] |= FAIL_CPU_CLUSTER2;
> +
> +	if (cpu_code[0] == 0x35 && cpu_code[1] == 0x82) {
> +		/* policy: always fail gpu on rk3582 */
> +		ip_state[1] |= FAIL_GPU;
> +
> +		/* policy: always fail rkvdec on rk3582 */
> +		ip_state[1] |= FAIL_RKVDEC0 | FAIL_RKVDEC1;
> +	} else if (cpu_code[0] == 0x35 && cpu_code[1] == 0x83) {

Technically, we could have a simple else here as the code path before 
the if is guaranteed to only be reached in two cases, 0x8235 and 0x8335, 
so if you test the former and it doesn't match, it's necessarily the 
latter. No strong opinion.

> +		/* policy: always fail one rkvdec core on rk3583 */
> +		if (!(ip_state[1] & (FAIL_RKVDEC0 | FAIL_RKVDEC1)))

You could want to only check FAIL_RKVDEC0 as FAIL_RKVDEC1 is a bit (and 
not a bitfield so we don't need to set the whole bitfield in the event 
it's only partially set like for CPU clusters). No strong opinion.

> +			ip_state[1] |= FAIL_RKVDEC1;
> +	}
> +
> +	/* policy: always fail one rkvenc core on rk3582/rk3583 */
> +	if (!(ip_state[2] & (FAIL_RKVENC0 | FAIL_RKVENC1)))
> +		ip_state[2] |= FAIL_RKVENC1;
> +
> +	log_debug("ip-state: %02x %02x %02x (policy)\n",
> +		  ip_state[0], ip_state[1], ip_state[2]);
> +
> +	/* cpu cluster1: ip_state[0]: bit4~5 */
> +	if ((ip_state[0] & FAIL_CPU_CLUSTER1) == FAIL_CPU_CLUSTER1) {

No need for the == FAIL_CPU_CLUSTER1 check as you'll have set the whole 
bitfield earlier even if only one is set in the original ip_state from 
the register. No strong opinion.

> +		log_debug("remove cpu-map cluster1\n");
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster1");
> +		cluster1_removed = true;
> +	}
> +
> +	/* cpu cluster2: ip_state[0]: bit6~7 */
> +	if ((ip_state[0] & FAIL_CPU_CLUSTER2) == FAIL_CPU_CLUSTER2) {

Ditto. No strong opinion.

> +		log_debug("remove cpu-map cluster2\n");
> +		fdt_path_del_node(blob, "/cpus/cpu-map/cluster2");
> +	} else if (cluster1_removed) {
> +		/* cluster nodes must be named in a continuous series */
> +		log_debug("rename cpu-map cluster2\n");
> +		fdt_path_set_name(blob, "/cpus/cpu-map/cluster2", "cluster1");
> +	}
> +
> +	/* gpu: ip_state[1]: bit1~4 */
> +	if (ip_state[1] & FAIL_GPU) {
> +		log_debug("fail gpu\n");
> +		fdt_status_fail_by_pathf(blob, "/gpu@fb000000");
> +	}
> +
> +	/* rkvdec: ip_state[1]: bit6,7 */
> +	if (ip_state[1] & FAIL_RKVDEC0) {
> +		log_debug("fail rkvdec0\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdc38000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdc38700");
> +	}
> +	if (ip_state[1] & FAIL_RKVDEC1) {
> +		log_debug("fail rkvdec1\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdc40000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdc40700");
> +	}
> +
> +	/* rkvenc: ip_state[2]: bit0,2 */
> +	if (ip_state[2] & FAIL_RKVENC0) {
> +		log_debug("fail rkvenc0\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdbd0000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdbdf000");
> +	}
> +	if (ip_state[2] & FAIL_RKVENC1) {
> +		log_debug("fail rkvenc1\n");
> +		fdt_status_fail_by_pathf(blob, "/video-codec@fdbe0000");
> +		fdt_status_fail_by_pathf(blob, "/iommu@fdbef000");
> +	}
> +
> +	parent = fdt_path_offset(blob, "/cpus");
> +	if (parent < 0) {
> +		log_err("Could not find /cpus, parent=%d\n", parent);
> +		return parent;
> +	}
> +
> +	/* cpu: ip_state[0]: bit0~7 */
> +	for (i = 0; i < 8; i++) {
> +		/* fail any bad cpu core */
> +		if (!(ip_state[0] & BIT(i)))
> +			continue;
> +
> +		node = fdt_subnode_offset(blob, parent, cpu_node_names[i]);
> +		if (node >= 0) {
> +			log_debug("fail cpu %s\n", cpu_node_names[i]);
> +			fdt_status_fail(blob, node);
> +		} else {
> +			log_err("Could not find %s, node=%d\n",
> +				cpu_node_names[i], node);
> +			return node;
> +		}
> +	}

I would move this closer to the renaming/removing of cpu-map. No strong 
opinion though.

I'm wondering why you aren't using a direct path like for other 
controllers, e.g. fdt_status_fail_by_pathf(blob, cpu_node_names[i]) by 
simply prefixing each node_name with /cpus/ ?

> +
> +	node = fdt_path_offset(blob, "/");
> +	if (node < 0) {
> +		log_err("Could not find /, node=%d\n", node);
> +		return node;
> +	}
> +
> +	snprintf(soc_comp, sizeof(soc_comp), "rockchip,rk35%x", cpu_code[1]);
> +
> +	for (i = 0, comp_len = 0;
> +	     (comp = fdt_stringlist_get(blob, node, "compatible", i, &len));
> +	     i++) {
> +		/* stop at soc compatible */
> +		if (!strcmp(comp, soc_comp) ||
> +		    !strcmp(comp, "rockchip,rk3588s") ||
> +		    !strcmp(comp, "rockchip,rk3588"))
> +			break;
> +
> +		log_debug("compatible[%d]: %s\n", i, comp);
> +		comp_len += len + 1;
> +	}
> +

If it happens that none of the expected strings are found in the 
compatible property, we should probably return early.

> +	/* truncate to only include board compatible */
> +	fdt_setprop_placeholder(blob, node, "compatible", comp_len, &data);
> +
> +	/* append soc compatible */
> +	fdt_appendprop_string(blob, node, "compatible", soc_comp);
> +	fdt_appendprop_string(blob, node, "compatible", "rockchip,rk3588s");

I would rather insert rk3582/rk3583 before the rk3588/rk3588s and keep 
the rest untouched instead of truncating to rockchip,rk3588/rk3588s and 
then adding rockchip,rk3588s back only. I wouldn't want my device tree 
to be modified too much and we don't know what we'll get from downstream 
)I'm not necessarily talking about Rockchip's vendor kernel here) DTBs 
for example, so truncating doesn't seem to be the best plan? What do you 
think?

Logic-wise aside from the "compatible" changes, this seems fine. I do 
not own any RK3582/RK3583 so cannot test this.

Cheers,
Quentin
