Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9395EA3F14
	for <u-boot@archiver.kernel.org>; Tue, 10 Feb 2026 07:43:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3B76E83BDD;
	Tue, 10 Feb 2026 08:43:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="leyomNoa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CD5F383C91; Tue, 10 Feb 2026 08:43:51 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c107::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 921078309A
 for <u-boot@lists.denx.de>; Tue, 10 Feb 2026 08:43:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fwbJS0+d/yzsmWOzOv+dekSc1CvgJvFI+ftFqbeoXx0ieOHIAq1fJM21Zuz/2a1WrIxKXdYtBtKUjqKoeGvmN+hkAjmvWTlr0ylhPIn2i8hG2aXqKVCcboulc7IgGyQpt5Zz9CqmWjk/grXArvOKQh3e/N83gFpsMaRuaVE2+HU6sEARJyvizrildW6PR+YnOW99HLK6dIzfEewnV79bu2UqMSEd6PNuFx7a3om3PGYXiGF1B2+K4oIX4UpuNa2tqBaaZ6zPPeQZRJX9mIklhQ7psktStsJIRZxcwpSBW+Dkmt0KiVO7KGuHAKs8DyIJuP2NxYLvp2p2lK+1ln0dkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dhp47LCjjdw1x4Q3E8gw9yoWNpmrsVDev4VAeLfGsDk=;
 b=uTr5amEyBzT7yV/9g6ORBVmRGyFbxWkgtNmUSR94si/eunTFcRL+W97hNR3dVH7B0tcV2tqp0l0Omyzx5JkI9MCpkyRPWW/IH5JBHDvAXvHEG2SKRMEa8efwaZnX4b+qIZT4yWl+C46CgbZ+4gwxMCd8dFjwg4hh/Unw6Jtjxl2+h3j35Gy4X27Mu8qLeJ8sWNLXBCH1Gvqx5UhZaeyR+shJ7iHT3s0SNO+4eeuAjw13BTAvYYSvYZqfvJ75Ntxa7oz3GlKHLnnfTJ8tfy7ZeJO7IZzXlhxV7agdg+UziF6evJZQCrIo2yoxVVkDvnSdu5bgu6ccN6s2lo7XYUgE6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dhp47LCjjdw1x4Q3E8gw9yoWNpmrsVDev4VAeLfGsDk=;
 b=leyomNoaoeoKtyqY1EsCdsZ0/lo4QqFxJhkD08jCGFsTUBQZgOmKPEAkFWE/YMw0V6I8PFxfsIk5rSACVSqEYkRQBxNyeLCsywlRA/ziK46/dMV8wzLy8t+wFVm52ez/WZ4gTJdGc1GOSsZ1bKDZwflM337CGZm1JkyEj+A86MNlJxRcNkCOsHTjRv4aUyYFRLlnzWdHiTALY2/tR+NBfl9pbS9TLXSR0iOnzF20JX5VtdG/Ohb2tY4Ly2SG1nMB6rBqSvX3OmxCx6AY7sFZuXk0/Q6eVsuIG+QV4w/yl4woyIddSEPl76ymNeEhBkn04P+Pb4ciddEY+6hkSI7nSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SJ0PR03MB6424.namprd03.prod.outlook.com (2603:10b6:a03:397::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.19; Tue, 10 Feb
 2026 07:43:45 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9587.010; Tue, 10 Feb 2026
 07:43:45 +0000
Message-ID: <10552de3-9d29-4c0e-be54-5c321489bfaa@altera.com>
Date: Tue, 10 Feb 2026 15:43:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] socfpga: agilex: fix NAND clock handling
To: dinesh.maniyam@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@denx.de>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tom Rini <trini@konsulko.com>, Lukasz Majewski <lukma@denx.de>,
 Tien Fong <tien.fong.chee@altera.com>, Kok Kiang <kok.kiang.hea@altera.com>,
 Boon Khai <boon.khai.ng@altera.com>, Alif <alif.zakuan.yuslaimi@altera.com>
References: <20260203075653.4843-1-dinesh.maniyam@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20260203075653.4843-1-dinesh.maniyam@altera.com>
X-ClientProxiedBy: SI2PR02CA0027.apcprd02.prod.outlook.com
 (2603:1096:4:195::14) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SJ0PR03MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e02c45-462d-4b08-e474-08de68781e8d
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|8096899003;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QnZHSElxeVhObUdTbTBhNVl6VWNqV0tXbzF3dmdwdW83WVhnNDRabTByQUYy?=
 =?utf-8?B?QVdKYlIrYVdiVjZDWDRWL2xRem9JZTd1ekx3eFNWMGlLcWJITm9qNHJTMHEx?=
 =?utf-8?B?TTdMendHb2FXdDk0U1dLTTFnTGlaS1J4b213enV4Um5NL3h3OXN3Tzh0a2VS?=
 =?utf-8?B?UDYxZG1QUFVvR0F3TTZ6S1RSR1c4U1ZHMTRDMERCdnl6cVhWMVVCdEFLR2xj?=
 =?utf-8?B?aDRHL21PUzRieWc3ZXdFd2RDYzFBbzBZb2RmeWl4cFBjY2xseTFSRWJaSEJB?=
 =?utf-8?B?cS9xSXpiaUxkZGhpN01Hd1lqdDlVLzU3R2tFcEIxeWc1dkluSzRxWmwxZFQ4?=
 =?utf-8?B?WE56UzcxSXZpbzQwYnFhbnhhLzAvZElnMFRKN09HdjA4TDZncmJJdHRiR1BG?=
 =?utf-8?B?WjVjTElkeGVVWlpDN1Y4cmlBdzJMeU9ZYlBjand3TU5YNTFFN0lGclY1b3dX?=
 =?utf-8?B?dGhGNHp0SmRTRk9FYVJhb3lubk9rSHdXUHpPckRtSFU3bml2TlpXK0RlVlZW?=
 =?utf-8?B?ZjlOc05GdllCK3c0c05tOEJOeXhBQUcrNlBXMkEvQmNrS0xzU2VkZmVORVVx?=
 =?utf-8?B?cm42ODhKaDNTSGY4QUJiZXdjR2w3dEp1L3JyZTdyWTRHbnZyenA4dUdsTURp?=
 =?utf-8?B?eGdTSVlTVldWY09abVdFUkpqUVgxeVpaQ20waFlKTTBZSW8yampCaTgyUU5E?=
 =?utf-8?B?SjBpd29FV0FKaE5IcDJpNDBsdlB4dGp6QnNxMldTWXBLbGpkUTYrVGt2M0dY?=
 =?utf-8?B?bWJLUWZYS0p1N0N4czhycFAyRnZXano3ZzZtanhXSXlvQXFvTkY1N2FVVHdP?=
 =?utf-8?B?aHFTd2NISDcxMWttZDRjUXUrSHpKdWljVjY4RUROWjBSSGFHWnkzVHJvdGw1?=
 =?utf-8?B?RjVvS0xQUHJzUVhwVFpvcTF2MUVnUzk4KzljcG5HL0N3UEd4TGEvbmZ1eVhH?=
 =?utf-8?B?L3k2NG8razZhbEFyRENhTC94cDBHcTdtdDdVYWo4dkxsblVQUU1JajVoYWtI?=
 =?utf-8?B?RGZobWFGUmtVVHZERVVkanVSOGVLZEY2UkQ0SERqcjlOSEJJMUJGV2ZzYVdQ?=
 =?utf-8?B?d2gvNk9KTm11MEEwOVBHbjRMamVxYk81cGhGL2JPVzJvUmVGNkppOTRkU05P?=
 =?utf-8?B?NUdhbXo3YTFzRlJKdVNueUNDQzdhZ3FTbU1UMTZYYktLeTNOU29qenhmYTZG?=
 =?utf-8?B?a09KT2t1YnZISW9MOUd1cnEwOEJpeld6UjNDTm1TcHB6cnNnUkRzeFVtT0Rq?=
 =?utf-8?B?T3BiK2pMdWhLUHkxNEFEV1RXMForR2JUOFR6d2Y0Q3UyRFA4Q2xFNTZZWGlM?=
 =?utf-8?B?QXFLWjdXQmRBMkQ0bm84ZHhPbXEzdFFBNGFQZUxSS3FzSkdyQ2RIeDJaTVRZ?=
 =?utf-8?B?c0RiZWtrTC8zLzB4YTZkQ2dsRFFBNmFtMXNZRWxZSUdtR25FREZUZVZoMzRj?=
 =?utf-8?B?d2treHVTNVZ1ejJtdHkrbFBxMzlGY2ZVZFR1OWRhM3RFWmp1MTZDTVpCanE3?=
 =?utf-8?B?YkJTbFhYZ0dDbXhLbUM1WnN4MFZHa3E5NjJaRy9Mb3NNY1Z1VEl2NS83bG80?=
 =?utf-8?B?VU5XZXl6TUlrZU43eU9aME9FNksvZkt2a0VIWkNvWlVuSmJOUlZJczF6d1d1?=
 =?utf-8?B?OW5mVk5WNHYxTy82cTd6WkgzS2tMdE5xSkd1QWozZHZCVVZPTEVLYzRsNklD?=
 =?utf-8?B?T1MzYWVkRGhWVmxNTGhZbmtucFBxck9XczBxVzhQd0UyQjZad3FaWWJPdUtz?=
 =?utf-8?B?NXgyWVNBY1pDWCs5Ulc1V1JiREVlTXRsWUhWSFJQeHdpS1o5Q2pEdyt2b2xm?=
 =?utf-8?B?ZndleHlaalo3Y2RiUS96YnBrK0RkL0ZRYTRJajdHdWNJdUsrcm52QmxkTE5F?=
 =?utf-8?B?YkhDaFh1OE53TzBUNk9TUklKdXptb0RzRS9TV1VaZENrNVMwR0xwOVUrL0dr?=
 =?utf-8?B?aTh1MnY3eDQvUjRaM25zQW9BT09UcHNKUi9tSU8xaW5hVWdQRjY2V0JLM0hj?=
 =?utf-8?B?SkZxNFJoSUdrdVBsTVJLdkpaVTZtQWFlTmVRNnhtQng0bVNlZkRRQjZMZnRx?=
 =?utf-8?B?Vk9zbEp5UDBqbytmaW1YTkoySEhoejdham5oOWw1cGZVeXN2dnVOeFRSams0?=
 =?utf-8?Q?sZzY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(8096899003); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MDQ2cGo4L2pCZEtQR1FrUXZWT3Q3aDVKckFWNVdLYlBCL3pkWkN6dmp1cUl5?=
 =?utf-8?B?RGNsV205L01JeWRQY0gwU3VjTENPU2xQaTBBYzhoOHRITC9FR1k1VDF5c0NO?=
 =?utf-8?B?OUxnM2VrQnJ0TGdTMS9MakpOVmxTeTQ4ck90eHMwNG1mTUE3Y0d5NHpwS2RM?=
 =?utf-8?B?YmpremFHMnp0ejVYU2V1c3Rqb0gzcFRhaFloMnRKaFRmZ3FCYmQvM2RBMUVn?=
 =?utf-8?B?Nll2QWFsSDN5Q1hQdWtxbWxCNk9nb08zZzA0c3RyOVk1R1plZGhCNk5tZmR4?=
 =?utf-8?B?WkZZWXhxL21rbE9jNndUL2xxZnV3ZnZOQmlPbDdaTUp0bnVOMXhwMFU1cCtQ?=
 =?utf-8?B?YVJwNVRwbERrNTFvdi80VWhoTk1aK1ljNFprYkhKbTIxSU5VNG5lRVZ3aC8x?=
 =?utf-8?B?OHZIalFlYXZEbUZDU0ZmQVZEVElLTjAzZEZPcnNaK0NtNlRSOFNDNFpVWURE?=
 =?utf-8?B?cHhybWxsbjRVN1NHNmVEdEVKV1kzMG55QmFnVy9sRnJDZ3BiWjdWSEJHNTVh?=
 =?utf-8?B?bHYzSHIxUDZUQkdXMmdNUHo0V1pnNzUzakxlSDFJMDU2SStnb0UxMDJtN2Y4?=
 =?utf-8?B?eWNpa3ZDa1NITVpGaGdjMCtEcGhHTCtXWmRzYlByWUZXTk92NURNL1JGQStp?=
 =?utf-8?B?WjM0U3ZOdlllclRnZGoxYllGdWluM0p6dXgvUGhKaHJObm5UN2xrbjNvcEhO?=
 =?utf-8?B?VnliZktqdjVpVlBoeDYyWVQvcERmUURBaTdHSys2Y2JQWWNDUFZkZ3hoOGt2?=
 =?utf-8?B?czRjQ29oYW4rN3dEdW53NmExVkZYdENyQTliRHoxcStOMlhxK08xNFRaNzVE?=
 =?utf-8?B?amcrYUZ4OWJ1R2xmSDBHb1M5S21yZ0ZWWkh4R3VwQ3V3M2txb2JDZFk2OFFL?=
 =?utf-8?B?dTROc1JyY2FHM3JtYWhTTkhSTUE3aWxyNGhWbUl5ek9hZ1RFK0t3cWZPQ3FR?=
 =?utf-8?B?QUJ6N09UMlEwNFZCSWlFTmFBMW1OeFR2eFlyanlEdU1IWnc1aHgvRUNYdnY2?=
 =?utf-8?B?TVNxQ0tmbE5naE00dEtjQzRlWDlHSHJ1aFduaWZKek5iaStPREFneDljOWVz?=
 =?utf-8?B?S3hueWVvaGpCb0hvUk0rOW45MXlDdnRzcUYraU1CcmpPU1dvR2cxbldXTnJH?=
 =?utf-8?B?dVFDenFES1BaUXF6ME1Mc2NXcGd4WnpydHA0aWJVQWxjNmVhQjVySmEvV21h?=
 =?utf-8?B?bzkwWUdDMEtNK1FaT0NsckhxS2crTHdHOXdzanJtTVNwVFFOMlFUT0NHRjRy?=
 =?utf-8?B?aG1ScGN3SzRwNXZLcGZ2OUprOFQzUUw0TWgwazNEWGRxcmZCbjlGM0NwRkFr?=
 =?utf-8?B?M0g1bUtNV1l4UDBzb3ltZ0krNHV2dlAwMlNIZDNMS1hYMEM5MmE0UUVnQ0Z3?=
 =?utf-8?B?M0FaNGtTakdmWkJCOGhKVEp6cHRuM2k0bC9kZmE2dDlZUk03UXZtdXBYN2lo?=
 =?utf-8?B?SE94NlFwWXVCazhuM1h5c3JYR2QyYmF2Sk9GWHE0MHFuMFU1SkllZWQ1K3Fp?=
 =?utf-8?B?a29QcUprMnQwWnBpT29JbmtjRUhKNGRxRHFNNW9DemppWDNWcTN0VWFpaGVn?=
 =?utf-8?B?OWdVcUxPY1RDNTVzWXpBaWdwRjZXTkFzNU4vQTlYME5FMTNaUlJGYVRVd2NB?=
 =?utf-8?B?T2w1a0VWbGhyTFlScEU1anZjT0I3MENOLzNveUxMazdmckZxQ20veGRKa0g5?=
 =?utf-8?B?Vll6ajlLWHhuWHB3bU5EckhYNkZLYndwaWUzYzdJTFdEK3ZLSnVHSnZEbjc1?=
 =?utf-8?B?c0JaR3ZuNm9rbzQzQ2JJYllUdFdhdkVjdUt6dmJjaE13Z3pYcE8xU2REL2FL?=
 =?utf-8?B?cEp3YW1IMSsvdjNybTEwV1VUMTBjMTBFajJ0SS9aQlByS0ZpR3A0RGpNa3R2?=
 =?utf-8?B?blFWTUo2cElRL25SdUM4ZXlFdVloWkxnLzc3TkFTeTREWUdMOGhid0Nqd3pz?=
 =?utf-8?B?ZHQ0Nko1aWpYV2hoOXYzcXRVWHFKeHc5YVRGeWZYM2ZZNGR4cFM4K3ZtOFdE?=
 =?utf-8?B?QUJxWXhCRG9Oa0cvU1NnNCt6RkhVc1E2Vndaa1BFSXN2UmZ1REh2K0V3NU9o?=
 =?utf-8?B?azAxdEo3M2dRbUpCZzhRTUZMYWZIdkdJZnE3LzJnRHBiaDgrSHhHa2VKMW8z?=
 =?utf-8?B?MkdOMDlYT2JKek5jeTZyRjhMSy90NHhFaWN1MEU4eER1aVliakI0dERCb014?=
 =?utf-8?B?NUk5OUEza2ZFWXNKOElZaFZyQkpieU1UTk9EWkhvaWJmditxcWlNZ1NaYTdH?=
 =?utf-8?B?Tm8vUlBsR1czaXVhZUVVdldndEtNQlYrdXFqNSt6SHQ3TzJ4RlFkSWpwL2V5?=
 =?utf-8?B?SWFKZ2R1RmZTQ0ZsenhkcUxIMFJ3MHBpNzBjY3Urc3crNFRzV2J3VWkvK1R1?=
 =?utf-8?Q?A6KtUAB7DsajDWRY=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e02c45-462d-4b08-e474-08de68781e8d
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 07:43:45.4934 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Goh4IX97doz+Fov9INyoqXdQBNpzrkrpGpPoZH8hoj+9NkawKPtaFmL+hHd6mGKBjw9sOMf7e+4ET2K5l6gpXcD8M/ltUjLbraRrWzABv4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB6424
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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


On 3/2/2026 3:56 pm, dinesh.maniyam@altera.com wrote:
> From: Dinesh Maniyam<dinesh.maniyam@altera.com>
>
> In v2025.10, the Agilex clock driver was updated to support
> clk_enable() and clk_disable() using clock-ID based bitmasks.
> However, only AGILEX_NAND_CLK was implemented, while the NAND DT
> node still referenced both nand and nand_x clocks.
>
> Since AGILEX_NAND_X_CLK is not defined in the clock driver or the
> clock-ID specification, clk_enable() failed during NAND probe.
> As a result, the Denali NAND controller never completed
> initialization.
>
> Fix this by mapping the NAND X clock to the existing l4_mp clock
> bitmask, aligning the DT expectations with the clock driver and
> restoring proper NAND controller initialization.
>
> Signed-off-by: Dinesh Maniyam<dinesh.maniyam@altera.com>
> ---
>   drivers/clk/altera/clk-agilex.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/clk/altera/clk-agilex.c b/drivers/clk/altera/clk-agilex.c
> index fdbf834bb2f..f1e2fded7d4 100644
> --- a/drivers/clk/altera/clk-agilex.c
> +++ b/drivers/clk/altera/clk-agilex.c
> @@ -657,6 +657,7 @@ static int bitmask_from_clk_id(struct clk *clk)
>   		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MAINCLK_MASK;
>   		break;
>   	case AGILEX_L4_MP_CLK:
> +	case AGILEX_NAND_X_CLK:
>   		plat->pllgrp = CLKMGR_MAINPLL_EN;
>   		plat->bitmask = CLKMGR_MAINPLLGRP_EN_L4MPCLK_MASK;
>   		break;

Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards, Tien Fong
