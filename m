Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E4CE8305C
	for <u-boot@archiver.kernel.org>; Tue,  3 Feb 2026 07:02:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8329283FC8;
	Tue,  3 Feb 2026 08:02:52 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sTTpTWQ7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 175B083FDE; Tue,  3 Feb 2026 08:02:51 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D4C3883FC6
 for <u-boot@lists.denx.de>; Tue,  3 Feb 2026 08:02:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkIS2AP4Wz+wQmW4scTq7WQvcVa94tnmvqyt3aoAr8tEtUlpIRMteYvD8n5muHpLUuobYr6X38yVN07X2seLsdVxozgQKJex1B9sJBuMRxp9y7LIjwJQb6E6fHMWOLgqk0hptozW5qLmxxVnF3uagf4IFgYGBWZN0o2jEL9uy+y/xbxHXyq39/Bf6vHraAo5VBP9hBbMAO8L03XW2pwksdB6SNAu1tiRDyu9BwXPCeBITyHbKLc5q43Rl7HUgq1AvbUv7XY4HtUpMEncdfEI1jKE9XsK2Gmtsu6Wk3Gq7w7E68H8qHLcnLT0mLcLpgudKZRSvKOb9OReCF0SeA1dvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZqupoChgNpHfzKSf2hdUb2/VklHukpGJCwem+yrKDc=;
 b=KqETk8BzhEtWzm+W7A28mqybjZZa5rWV8QoA9jesUl2xp2vl8+u9MgBvoamM9uZAXb5/8gGLRk2styLLch0gUXXv4HO7vXerclL9bUIMSKvdDLv0Uc4PS/ClhhG7RWoeggqRQ963o/r9N14jdMGI9wrUmBUYFo2ZSEWbIjUAxiUwzDLswHBYdghXZJaLdRDW7JUlZscotD7h7FmF2eWe80fO4h30IcpqtQxkEwUWE2jKOFeHwkZBR98nxwqOJFdHGbTFJkRcwHao5dLcPSZGvj97WA99LYp+/jOKhna6cixEgalgoNsCE95OZNhWCudAAIaYnZRSzDt1n9NQB7qk4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZqupoChgNpHfzKSf2hdUb2/VklHukpGJCwem+yrKDc=;
 b=sTTpTWQ78d7B9CjO79yNMvgtazrdA7lRfktS9Yt1BxP6sAu5FbFkwVGY2QY4SWXCh6UsnpV37uczyFcX+ICtdMCz4l1/LmZA2O6DZB/6483YfBQI8iGoegH9mLcxiOfwWBBmuBJx2ld0zDst/o1VPUW46Z4JsxZ8JsWOe6PLJIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18)
 by DM6PR12MB4372.namprd12.prod.outlook.com (2603:10b6:5:2af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 07:02:32 +0000
Received: from PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d]) by PH8PR12MB6939.namprd12.prod.outlook.com
 ([fe80::d84:b1d8:bca1:7c3d%4]) with mapi id 15.20.9564.016; Tue, 3 Feb 2026
 07:02:32 +0000
Message-ID: <b5bc55b3-71dc-4fe0-a884-01de36a7845c@amd.com>
Date: Tue, 3 Feb 2026 08:02:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] gpio: Add GPIO delay driver
To: Tom Rini <trini@konsulko.com>, Peng Fan <peng.fan@oss.nxp.com>
Cc: u-boot@lists.denx.de, git@amd.com,
 Arturs Artamonovs <arturs.artamonovs@analog.com>,
 Eoin Dickson <eoin.dickson@microchip.com>, Greg Malysa
 <malysagreg@gmail.com>, Ian Roberts <ian.roberts@timesys.com>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>, Rasmus Villemoes
 <ravi@prevas.dk>, Tanmay Kathpalia <tanmay.kathpalia@altera.com>,
 Utsav Agarwal <utsav.agarwal@analog.com>,
 Vasileios Bimpikas <vasileios.bimpikas@analog.com>,
 Yegor Yefremov <yegorslists@googlemail.com>
References: <cover.1769086229.git.michal.simek@amd.com>
 <6a6cd2da427e13bc69d2e0ae4070b715791be02e.1769086229.git.michal.simek@amd.com>
 <aXxb7L03qQ3jdnuT@shlinux89> <de5823b9-2214-47ae-9b4c-77cd413e34f1@amd.com>
 <aYFRE69oIA9Dk1WH@nxa18884-linux.ap.freescale.net>
 <20260203010638.GF2603314@bill-the-cat>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <20260203010638.GF2603314@bill-the-cat>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VE1PR08CA0031.eurprd08.prod.outlook.com
 (2603:10a6:803:104::44) To PH8PR12MB6939.namprd12.prod.outlook.com
 (2603:10b6:510:1be::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6939:EE_|DM6PR12MB4372:EE_
X-MS-Office365-Filtering-Correlation-Id: 86002fdd-c7c3-44f3-a2b6-08de62f233be
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dzZoaGZFRkxMMHBaSzFrMVN1azczS0NmellTU1ZtWUF6c2VVYjZ5RHdsdTF2?=
 =?utf-8?B?VlFuV3N6WVdvU04zdGNZMndSbklORy9pZGZHNVpvOHZRS3lxSVJSNGFqazRn?=
 =?utf-8?B?WlU0QXBhd0dwRGVkZzA0cnBLRUNsb04xdXBpdS9BUmluWkMxYnBWTGMrS3pG?=
 =?utf-8?B?VDZRRmcrRHBoRW9ML1ZVSFB6b2hnZ0VOMm5HcGlhSUpBbm4vcHR2clR6VlR6?=
 =?utf-8?B?QUZteUZtNzlSZFhqL0p3QmNPV2crSGdwdHozRnhOTzUyRGZKYWV5UXI5R3lE?=
 =?utf-8?B?eXAxMm9JZWsreDQyZm9TZFhDSXd4UmlQWTNhTmZwOGNTZFhwMXkvYjR6NUJa?=
 =?utf-8?B?QUVQMHhSYnN4ZkhwWk8rMnJidkZ5ZkdLWTQydHBUNW9xemFnbndkSEUwTVAx?=
 =?utf-8?B?SkpGclAwWjJZQU5uQUdRc3JpTUIyL1dDQjVBYis1OTdYWjVRQ1hOd2tyVDd1?=
 =?utf-8?B?RFFnSCs3Vm9oaHRHMlltem5FQmpINXBBOVgyTDZWT2RjTk91Yk1hZmxtQm1t?=
 =?utf-8?B?TWhOUlVTb05JWXN2UUk2WkNBbmRYeVBaQm0xZnRDems3OTZIb2FMeXhqbVhP?=
 =?utf-8?B?bVFybi9XUnFXUkRPRENnQ1NUclB2RkpTN2M5bUJ0TFdXeXllVEhZZFlJRm9y?=
 =?utf-8?B?d1kybktjcXdTY0pQQm4wa2pJSENqVG1XUC9xcHRhYmlNU2N0RnRINmZlbWw1?=
 =?utf-8?B?ZnFxb1o5N0w2MG1DY0hvSkZEdFpKKzJiL1Y1VUw2UkdDME1odUg0a1dDSTcy?=
 =?utf-8?B?U0lGdmowM21RS1BPWnowM0FZT2dYVG1Ua2ZzRG5tNkQ3NmVQMGUzWkQzdTJF?=
 =?utf-8?B?NXdobkUvUXZxOXpPQjV6b1EyckJWSDg2UU9kUUEzWjVCSVFiQ25OQkhXNkFD?=
 =?utf-8?B?U3hVNEdDK2xzTVpETm8zL0R0Vml5R0dQTVFlQWFJeGhBYVI5Ny9keWVlRlJS?=
 =?utf-8?B?SDNTUUwzKzc3Y0NHK2lrRkhwVnpYUlVmVUNIL0xxbEp5U2E2WXIxMTloY2w1?=
 =?utf-8?B?UFlBVGtjemsrZHgvUXFlS0ZEVFRoQk4rVng0QkRMWW1aTkNKVGNTT1JXMWc5?=
 =?utf-8?B?eFZVK0JSN1RCTCttWmM2WWtJdWpBS25xUmRrcFFPYkZVOTJheHo2WGtYSTd0?=
 =?utf-8?B?OE0wWXlERFhTdnNHOEpMRlYycTdwL1h0Mi9rKzFsOW1DbXI0WnJrTENvTUpi?=
 =?utf-8?B?YkJzcDFOdHg4eTVTUWhHaCsvWnRIMFMvVmNGSmFaRk02ZkU0MGNRamZ4bWEz?=
 =?utf-8?B?Z2R1YUlQc29vNEpjN3lFUzRJbEpaYWFLM2JFSWV2ZG1KSERLdEhSMEIzUi9I?=
 =?utf-8?B?cWdzL3kwNCtsOWpnMldjbnFMYTY3bm1tbi8yeVh5dWlwMkkzdDQrdUxucmNu?=
 =?utf-8?B?LzAwOFgxdW5JVEpDVzRLYXJOYk92YnNOYWhZd2E3NTQ1REpJTWNHWkI4cWZZ?=
 =?utf-8?B?RGpjc0kzV0hycXZabXBOSmw2cUY2YmdQbzRnV1hDaVVKeGhNb0JPNlpCTXFt?=
 =?utf-8?B?N3ZObGVKdVl3VUVCbXFDcmxUTHlMVktZS3NOUXpVNmxvQkh0UHFPbnFxVkJJ?=
 =?utf-8?B?YVFVdW8zczM2d0xEakpHTFRlTUUvWmtIVmV3QzIrM1JIakxna0F0MDZDNDVG?=
 =?utf-8?B?QWw4QmxnYk96Ti9xRHpwZk9Ja09TTmd6VnR2ajBZT2Vla3NxeWI2VXpWKzNt?=
 =?utf-8?B?NXN6UlNIQmVCMUY3QmZLQXBvaCtCdTBNTFNXNHpQR1hsZGVMWUJhTUFpQkt4?=
 =?utf-8?B?TmFPcXd3MUluWUtJaVJLQldMWmh5Z0llbDZ1b0FIVE9IN2FLTkdPdTd0OGtU?=
 =?utf-8?B?M0VYTFJFdlViWndNeGE1OTdyNkUzUEU0dFNGTnlUMDJISFdsY1NhV0dUT21x?=
 =?utf-8?B?UWQwRXVTOFllS1h3Zi91NlR5aFVLU0pZU0cyeGw1RUZGZGt6cXU0cjVVeWUv?=
 =?utf-8?B?Qjh0QW92OGsrSXBEcTFDYzV5UnMwVHNtZlBjRm5zY0M1REEvWmFIV3JsZWxM?=
 =?utf-8?B?bkpjdHVNdE9pNEtlVFR0Y1FMMmZhdFZzUFZCajF5YnMvLzQvQnh6MkRTbmM5?=
 =?utf-8?B?ZWs4UUtDSE04eVI1YzlJdUVMU3hyb042a2Z4aEpyeTljUXU0UkY1K1hxZFQr?=
 =?utf-8?Q?SCvY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6939.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejRmMlh2Yi90Tjl5aFpKZjdURzBYek9Lam1OaWFXR2t3aGRhMjVIVTdmcHhF?=
 =?utf-8?B?THNyUW4yTThYN0RBNUdJU0hEQm9EYXJIaXAxb3RwNmVITzRKdVkzbGlkcHJ6?=
 =?utf-8?B?YThIeTJlWktJT29meXI1UUNWYzZET2QvZ25iTTlwYzd2bjhQUmNCUVZZMmo5?=
 =?utf-8?B?VDVWbHJGZ2dUWmtwMXQzck8ycFRYaDN1OThlcDk3cytRN0tuYmlTWU94ZW5W?=
 =?utf-8?B?aUZRZGFvcTMvUUJqMGVmWUgyYVJvdWJLZWRSWExIZXovNzQycWE2SmY3S1Iz?=
 =?utf-8?B?bHJhM25jU2lFT3FSMisrVGlZVzMxK0FUczl0THJJUnBQWUtDWFliWVM1S0Vq?=
 =?utf-8?B?TWxWY2dIRC9pZHVIKzRKNlhnd2VQeUZhQ05ZdXBPTkNLL2FDWXJ6Zzc4UUsr?=
 =?utf-8?B?LzVXcys3Y2ZXZnlXNTE0cWNlT3pQblBvc3crWFVLeTJURjNTcUp3VFFPYXBi?=
 =?utf-8?B?R1RwUElsVVcxd2FQcVc5aFBYVVVweGlQK1FXQlp4UkpnMnA1NE8ra2xaaWs1?=
 =?utf-8?B?Y2VZWDdDNFZiU0UzaW02enVreWZxZUdhQm1DS3ZZYWovSFlxdkpVMHdEam4x?=
 =?utf-8?B?UVZEWTh3UUVxVWlJakt0VXVkaTR1RWVFNGs4Yk1GS2sraEVJaU51aHdxWlgx?=
 =?utf-8?B?WVFCOTZtS3NicjVzNi9kMkFUVmk1elBHL1JZNkN4a3pjZElPUVQ5MGxSLy9W?=
 =?utf-8?B?UVY0dGJ1NFR6cTljNVlxTXJRUzROcXhmUTZRYnFkdDhZQ3pjSitaSEc1RVhK?=
 =?utf-8?B?NzdxRGRxUE1wZllGMGNnOFpIWUhBaSt4VDFyVEtjdmFxS2I5VG1KRjhEanRE?=
 =?utf-8?B?MHgydERRbWx6aUtzOTZFelZDS2ovV1ZzeDJoUkdicWxzUE5XZmdpQU9XRGdK?=
 =?utf-8?B?eEFSYTlSTXZOUHh5UkZlSERuZXl6S1hSUGVQNFV4b3p4L3VNLzhuSlZlRTAz?=
 =?utf-8?B?MDB6VWFCNStMTzIydlhqenpnR1czYWlQTGYvbXVZTjMvSXczcVNObkppM2Iw?=
 =?utf-8?B?QmtrTkIzalBaeE03NndmVm03eHB1TzcwREM5WUlldi9CRHBvUTJxQzE0U2Z0?=
 =?utf-8?B?YkwxWXBJa3lPZndCa3ZCRGppeUg3Vkp2ZXd1Qk9jaVVzUDl5ZFRZd2pMRHp6?=
 =?utf-8?B?S0pwc1hFM2ZCQmNkSGZJNjFQNkFyT3YyWHNRWmpIVyt6U1FqZ0lhSGYrYjRI?=
 =?utf-8?B?Uy9IcW5JenlZUjR5Tm1sdFpmQi9DOUFjOTlRWXdQUjVBS25rZWg4V0ZkeERw?=
 =?utf-8?B?ZHJ3MDAvbWkwWXlxbStjQTFSQzBjUU1rV2xDS29mT1BnajFlQzdHU210T2dM?=
 =?utf-8?B?c1d6N0syeldTVFJBZC9XVmVTMW16d1dGMXJVWDVWdkwrLzZoTG0yMTIvUnhx?=
 =?utf-8?B?WlR2b0NCeGNQQVN0VThiQW5IZXRQWWx1N1Z5dSt4TVdUcG9malI5SDF6ZlpL?=
 =?utf-8?B?bm1WMGFDa0IrM3J3b05tdFRJZG00WTVOd3dBcDR6MVdNbmR4dUZvK0xvVk43?=
 =?utf-8?B?Yk1pRkREMlp1UWYyNmpHVHpBRk5LSjlzTXN1Zi9hS0ZKckdML1BnQlVKU211?=
 =?utf-8?B?ZGs1Y3gvVVc4STJPdXdrbEdGL2w0ZC9aVzR2ZUswc0wyQWY5azJEV1dJRUtv?=
 =?utf-8?B?dTZob0x3RlR4NGpPQWZ2UDNEWm15U0tiVy94ZUMyYUxKS3Z3N0VBVmowSWVq?=
 =?utf-8?B?RTRqUG5hSlJhZmUyZGl1STNXRHFvc2VnbFNJWHk2RzF6bmJjU2hjWVNkL243?=
 =?utf-8?B?N1hDOW5DTzNDWHoxUGZpejZSZGdxWi84UmRMa0VqdWF6dFZSZTZLMmtaRit3?=
 =?utf-8?B?OW56QjR0VG15SHk4akhVa3F1azBNN01XMFVEUk0vRmRHZ2gzWU01UGs1QnFU?=
 =?utf-8?B?ZG9scW5Dbm4vUG5La0hSanVNQVFnKzNIWmZYWGlzQ2I1bmNmTjJ6a0l5alA0?=
 =?utf-8?B?TDlKVzVYVlJqaVhVUHdMRVM0aFVYMzNoNTJZeU5MbDJnL2ZPc3NSczArYUJE?=
 =?utf-8?B?UXh1emRqb1VzckJTQWdHOVFrMDkrZUhjQVVLN0VtbWJNUktCUEhxRUhpdkoz?=
 =?utf-8?B?a0JqcS9kRkJuQzVuOEk5Nm9adk5sajNSZ2tVK1MrMFF6QTR3ZEFSeGxBcjda?=
 =?utf-8?B?a3pIYWRDTHkxN0V1QSt3dlQ0a3BIOXhTSyt5NUpUeGtjVjVUaU5BaExoc3FC?=
 =?utf-8?B?OC83U3BlNWo1U3BSSTE2MkMyWVgrQ1VSMk5BaHhXaDF4UzNLdFc3K3VlYTI0?=
 =?utf-8?B?dlN5MndTRFBoNGRZRHM5THRWSExnRW05TlJuYlBuYXQ5UzhKYllMd0lqbGNu?=
 =?utf-8?Q?qbcdW/GL4msQwUi94g?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86002fdd-c7c3-44f3-a2b6-08de62f233be
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6939.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 07:02:32.6124 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twibPJWP9LiZxw4yESI5aJ4kezCM5k5jmN5nlmDAsNgvS3vf6DuPsEnnJy5lyWLZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4372
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



On 2/3/26 02:06, Tom Rini wrote:
> On Tue, Feb 03, 2026 at 09:36:19AM +0800, Peng Fan wrote:
>> Hi Michal,
>>
>> On Fri, Jan 30, 2026 at 09:29:49AM +0100, Michal Simek wrote:
>>>
>>>
>>>>
>>>> Add an entry for SPL?
>>>
>>> Why? I don't have a need for it and someone should test it if this should be
>>> used in SPL. That can be done on the top of this when tested.
>>
>> I see.
>>
>>>
>>>
>>>>> #
>>>>> + * Copyright (C) 2025 - 2026, Advanced Micro Devices, Inc.
>>>>
>>>> Drop 2025?
>>>
>>> Why? Driver was developed in 2025 but upstreaming happens in 2026.
>>
>> I think the year should start from the day of upstreaming. Not sure.
>> Tom may comment.
> 
> I saw https://daniel.haxx.se/blog/2023/01/08/copyright-without-years/ go
> by around January 1st and it's somewhere on my TODO list to ask what SFC
> thinks about it.
> 
> So to be clear, I don't have an opinion either way on what date this
> uses when upstreaming. But it might be good for the project if we can
> just drop the years, which is very clearly out of scope for this patch.
> 

Driver was developed 2025 and sent 2026. We have a lot of downstream patches 
which were developed some time ago and then later sent but I can't remember any 
ask to drop previous years. Definitely people are asking to update year to match 
year when driver was sent.
And there could be a lot of development done before too.

If driver is taken from 3rd party/contributor likely you have to keep their 
origin copyright and years too. You can't remove their copyright with old date too.

I don't think there is a need to remove previous year or asking to do it.

Thanks,
Michal
