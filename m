Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8877DCCD193
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:20:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BF7FF8312A;
	Tue, 14 Oct 2025 18:20:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="Bfn8/Hbq";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="Bfn8/Hbq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 51172833F6; Tue, 14 Oct 2025 18:20:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 23D2E807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:20:20 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=S/KcCnc2atqTSWLnnL817ChHMsAwPU88oLaTVpdx7qyifNm43dmRAJXg2rVHxMduLaCyA2DwGvGWxxD+cFZJhdoW3O7UmnLMT3TYICcEwOCnEzLNkducyAdcYrxjXhpwNL45GYouudftpWs1VwnSostrBF9SY7jHEaHTqo8YLpLn6wtWDJ5S2LxSpnMtzOP0JVd3MLo2NIohML/RvJPVakpmfWIM6/nM2ddp5yjfkvJGZMHS6g2Zopd1qxUxNRFxEwsPfq8oHoNfSlzPQ8pv36pyaLSAXqiUZa53aQjaujAgVu9vrOgZj0wAavEbcxJ11kIwtTbVmgvf1HmnqfvMrw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAfXUJb9nAMI/7VBzipn7Cs0HOt8O8ulFCTYPFoYDIo=;
 b=Zztx2oUnF9uECCTg4iBvsiRVlldi7usf6aw44D7pqRJAxDfvnDcIqVFoec6inedN6B64zk6D+Tnulwe07wus5qoRDokublWBfqcYKj9C3U2VyU/7lkBSeplIIwhckj9bLLL05uuUd8wzuJsf50nVopgT0YKmlfCdEbLEn0wiMpS0hD5lloL0OTCL/7xZm1VeHMP3XEpNWKDGNO7hd6fUF6H99xWalINZiW1DlXBLzJd9dTZlPpjbia38eZ6BTLxN7IrhpMsG4l7Q2WDUwCvpESv4tXfLnIK0wJoASiMgX4kGXBDdIrhQvTwAOLSn8+brFNuTd4EG0EI4EcVC3cplBA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.86) smtp.rcpttodomain=gmx.de smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAfXUJb9nAMI/7VBzipn7Cs0HOt8O8ulFCTYPFoYDIo=;
 b=Bfn8/HbqSAduFPmKYHELP8c+88HdSob8YDtvE2+ZzuaIOslgipv+4QJ0/7aQ6Nhhe3AT7w1kigsh486zTvchQbpHfASMgevS9L1NKdAydssJgVNf0nzlBl4sXM4IRq0OreVNUvLAvyvlGFnmDhzZIFj7PoqmFfA59yiTOSnikbQNhuyxY1WDHtBsWlmvdpfiL2/eMUdpR6eqP8NesfilNjQxHEgfkUtxHk9Cc4PTG17v8uv6yZOsXvJLNcgFEwFQdb5QCxwUgKRYWljlAnUkUuqVhWhlqYvGF8opPBR7lMbcHM5y1IoFZP5hHy7SwzJtcv6y/F8XFkEFft3lb4FkVA==
Received: from AM9P192CA0019.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:21d::24)
 by DB4PR03MB9410.eurprd03.prod.outlook.com (2603:10a6:10:3fa::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Tue, 14 Oct
 2025 16:20:16 +0000
Received: from AM3PEPF0000A790.eurprd04.prod.outlook.com
 (2603:10a6:20b:21d:cafe::37) by AM9P192CA0019.outlook.office365.com
 (2603:10a6:20b:21d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.12 via Frontend Transport; Tue,
 14 Oct 2025 16:20:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.86)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.86 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.86; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.86) by
 AM3PEPF0000A790.mail.protection.outlook.com (10.167.16.119) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Tue, 14 Oct 2025 16:20:16 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 E775B20081621; Tue, 14 Oct 2025 16:20:15 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (unknown
 [40.107.130.111])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id AD1B2200C4FE1; 
 Tue, 14 Oct 2025 16:20:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UJR1rCCh2YBvCtWJP0LoYDj6S6eqWxA1zOb7x6eK5AL1xdQVxkcOtPzsPKiGhoByPdlvQDMRW9CO7n1Mm/ciVtJaN2lal03vfmBHswiF/Smsbg/A6L7gHkRnuxuqWzveSu/B0jhRqSu2enBO5cNMGnbYG6bEkTjy/g6anteH7Kjxx2GD+3LtHDMkU9wUMljyOyYlt1U8vUauJNPQOB9K7An9Afi8tYYtAOP5mVmZ13Z5PnNVGqeHVz/x7g8jmGCgtjfddqj5O9ezDGbSRbW7nZeXqmuBHr6dmkCspnPjN+c2OirGsTX7M95aToSFBCTJgYLM8QsuQfscjSw3AaOuzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAfXUJb9nAMI/7VBzipn7Cs0HOt8O8ulFCTYPFoYDIo=;
 b=yWC4YxHP01HxJjIyP2mfPXN+31bNravt56VtvJ+eCQtD9O1xrMcl4IvHZNllSS10BYxg/JLtmm4HYGl+CUvSvnw3p5GucdhJmbcI9QrtFHQMsrcu6L8RySqQBYHa2yEOIquMbEtmJc9afI6DtEBCrU/xL0wd1tDA4f+O2r8Sj+iJaDot4YLZ0zf0rm89Fvaf6NanqdPviBVHZx8jDA4NxxKusUtYikjcmVTzswfglcCMWbspRy632WnF7rL8I4LI5krkNCMaXw0e3fMyeSYaN1I9JhXJuZ9v6xri2eDDkcRR+ufRizwwq8EM7eQldV5gAja7pqoT+IRi4RqNwBq6EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TAfXUJb9nAMI/7VBzipn7Cs0HOt8O8ulFCTYPFoYDIo=;
 b=Bfn8/HbqSAduFPmKYHELP8c+88HdSob8YDtvE2+ZzuaIOslgipv+4QJ0/7aQ6Nhhe3AT7w1kigsh486zTvchQbpHfASMgevS9L1NKdAydssJgVNf0nzlBl4sXM4IRq0OreVNUvLAvyvlGFnmDhzZIFj7PoqmFfA59yiTOSnikbQNhuyxY1WDHtBsWlmvdpfiL2/eMUdpR6eqP8NesfilNjQxHEgfkUtxHk9Cc4PTG17v8uv6yZOsXvJLNcgFEwFQdb5QCxwUgKRYWljlAnUkUuqVhWhlqYvGF8opPBR7lMbcHM5y1IoFZP5hHy7SwzJtcv6y/F8XFkEFft3lb4FkVA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by FRWPR03MB11199.eurprd03.prod.outlook.com (2603:10a6:d10:1b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 16:20:13 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 16:20:13 +0000
Message-ID: <bb1cd934-ef66-4519-9966-c4f57da8717b@seco.com>
Date: Tue, 14 Oct 2025 12:20:10 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] fs: semihosting: Fixup smh_read against overflow
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
 <20251014-fs_semihosting-v4-1-6f2bc490175b@linaro.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251014-fs_semihosting-v4-1-6f2bc490175b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0058.prod.exchangelabs.com (2603:10b6:208:23f::27)
 To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|FRWPR03MB11199:EE_|AM3PEPF0000A790:EE_|DB4PR03MB9410:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d5650ce-ff89-4092-7f84-08de0b3d8f86
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?ekQ5NjMyczczYjVMZXZ2TmY4TTdOQXl2NVVtU3F4aU1LejhzV1B1THpueWk1?=
 =?utf-8?B?d3JhY3dzTjM4cVJOUFdlM1VER05ZTmRiV1F1dFJuV2RvY2ZNN2hqamFHQS91?=
 =?utf-8?B?S1J3SmVsMmRCK2RwbVZGZlhFNjNyNG90RXpyMjd4S2loVngwL2x5eVQyTmlP?=
 =?utf-8?B?TGRhNDJvcmpibHBCa2xKem51ZGJVVGxodHp5c0YrQWJFWjhQZFdkMVdTa1c0?=
 =?utf-8?B?MS95QVZPRTJOVjcvRzd2N040YmROMGZ5ckV4Tk5oa1QzMmZLbmhQbHY1disw?=
 =?utf-8?B?NUxzRDJIRW8zMVFQTURiN3VLQlR2VGNDTlVPY0lOT0d4d1NxY3BQWEoxb3gw?=
 =?utf-8?B?NUgwQ3hqT1Q0MEJZNXBtTE1kakVFdFpaRk45M05ETzlVR00yRTgzb0F3aVo5?=
 =?utf-8?B?R1UyeXE1anh4L1Btb1duWktkTU1GSk54bzUrZGJyT3c3ZXhqaVN4Uk1mVjRW?=
 =?utf-8?B?eUIxRWNMS2xCM1NzU2JrTEp4ekMwSkllOENGN3RKbnE4MG1qWERvblRKR3FI?=
 =?utf-8?B?WHMrelkySFlRMFpsVnBCWUc1WDhodjg4UDY3SVJwUEcxTHF4K3d3Kzg4RWF5?=
 =?utf-8?B?ZkM1eGRLWFdxMEorUmk2UnBZYXZuMmxtWnpyaE84cUpiU2JaZ2FMNkhadVMr?=
 =?utf-8?B?Y1JINzVRTWlsOC9qendoMnRRb1ZnWTVTbnpuQWpxSWsrcFJydWhSWlZvdkFD?=
 =?utf-8?B?Q21SVU9CUGY1WHBlcFFTc3hra1h0VG9rNEIxeTFkc0lUeHk3WXlLaEZ5WGpM?=
 =?utf-8?B?Y3pUb1ZTNjdMTnFzVHBjYlZZUkw4VkEzSnMxSnlKNVRuam5mdDRRUGlkQzhD?=
 =?utf-8?B?cnNxQ1VlQVVUSnlkam8yVXNiaFArRjZCZmpwalNqeC9VanhkN05oUWV4ZGE4?=
 =?utf-8?B?b2dDcG5iMFN6WGNQMzd0SkxQUkJUZ0YzZmlLNXI3NStLWVk0NWgrS0twMGFz?=
 =?utf-8?B?OTRyYmZlRWR3Q0krMGJiOEg2U01qTWZqYzd2OC9wNDhMN1A3eG5OUGtQL0xp?=
 =?utf-8?B?NXlQK3BYSVVDWndtUVozVlp2Ylc0UHBXRHhScG4xNXRwWnNOYi9lTVF6YXkw?=
 =?utf-8?B?RWppamJ2UzFqTzRmNzZURWZ2MGV5VEdKVEpjR2xXSThEcGZGcUozNFJheWVH?=
 =?utf-8?B?MHFwMExucG9sM1I2TUNnTG5JNmI2dUhlRTFHVkM3SFJFSEZrdGpXb2ZseEVC?=
 =?utf-8?B?djFoSzNZem14RUZ2RE9YeWtLUVpPRUtuNGhTUEtFSkxyaWpxdC9DQ0NBTEJ5?=
 =?utf-8?B?Ui9sQk1wKzZsMjAwZzZrZ1IrVWIxQ2w2Yll5V3Zob2QybG54ZFd1c0pQemI0?=
 =?utf-8?B?S2lYTUFZcjJZdndLRUtXSmZtY2UzbCt6WXh6MmwrVjkvaFlPZS9sQytHa1U5?=
 =?utf-8?B?eXVvOCtSUXlZblkranZJcFpSU24vaSttWnI2TitYVkdtRVNLTjhaNjN5MWYz?=
 =?utf-8?B?aGo4UkI4STkza3VqNGZnNTBzMzl1TjM3VDI4QXhZSm9qWHVKUHl1TGxGV1dz?=
 =?utf-8?B?SDhwMWhLZytqNTZKUnBzUG9zM1Q1YTFIU1d1SnFXWjBVZjE5RE8vMWIzRmE5?=
 =?utf-8?B?dFdGbWd3N1VMNTJLQzJCajZUNnAzamFXMU8veVNFSURaZU95VzQ2Z3J0dk1F?=
 =?utf-8?B?Unc4RU5jR3hqeEpYd25rQkwvU2paczVoTVBFSERiRW0yNkpEVGowZEEzUTJm?=
 =?utf-8?B?bDdwMFdpREpNamd0TVliRWIxUUk1R2o1b1Z0ZHJBdzZnVUYxTG1JVXhPdjFD?=
 =?utf-8?B?QVdNbzJmYjdWTnFZbkJZdGVndUJuaTNTQWlxZE1iMWVCcmtaNFZ6MjVSS1VK?=
 =?utf-8?B?RzdvazAxZG9OWlpVV3RmaG1SYWkrOHVGUUFZLzRNNTFYY2VMbDFrcHJSZWwr?=
 =?utf-8?B?UWFCSzkveE9tT3ZXYk95MzNpenF2enhRWDAvR2dDUExWZXlEUUppTWs2eWo1?=
 =?utf-8?Q?yDF3Siky2IlXg12NudtIHy1OWhlVSNTG?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR03MB11199
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2ef24606-4160-4809-28ea-08de0b3d8db4
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ek1tR0lQOHVFcDk3VE1xMVoxMThmT3NySWJXQi84Uis2dXkzbzJQK1YxcVVM?=
 =?utf-8?B?c2NDL2dMUW5yeVgyVEc3M1lyNU9EQndKQzMyd2RTQVp3bTdDNmcwdXVxa0FD?=
 =?utf-8?B?QVVSelpSek1GdXhyaU5xZ0RlWEFjSWpiQWZDemNtS3lQRUZyK2tiNDliN1VO?=
 =?utf-8?B?ZEdMYklEQ0Y5TnVUNFlJMFhWeFRzZ21BWTNPaVBqRENrYm5rQXh2NG80UWM0?=
 =?utf-8?B?Ym9lUHpVenVnUHRHMjJmM3hRYTI5NlRQWnNTZ2plT0tnMmRXNk5OaVoxcm13?=
 =?utf-8?B?cFVGOWl1d1pYbC82Y1ZwR29RV1VDK0dqdVd5T3JLWkpycStqdEVHZjJDTjFq?=
 =?utf-8?B?WGVHNTQxODVicUdMNVlBSGo0SEFvcnRBRmVhaHZFTGduR2FBVUNVWlBDVzVK?=
 =?utf-8?B?WnF2S3Rqb1NmQTBEUTBSeTMvd2UxSlRIb09DU011WVYrRC91Mm1lWkEwbjRs?=
 =?utf-8?B?MXFXTXpmcjY3SFVWSzJVaU91dityK0M0RzJuaFFJQU1sRTdrZGxQZWd3U3Y1?=
 =?utf-8?B?eDM1MHZTOFl5U0JmUyt3dFhGVUd4eXY5dHB4MkxaamNqaTdlSEIwLzE5c1ZH?=
 =?utf-8?B?bjAxKy91dFhTZ0RjSXlsNFIwbjlVT25HNVhiaEhQQ25rcTFFZFpPMUhsREtQ?=
 =?utf-8?B?VlFUVGFlMGFiWDBQZFBXSG50a01QNnpiSmhlLzZOK0JERVQ5bU1ZdmNLMXlp?=
 =?utf-8?B?TlI3TVl0U3U0dUpZbEpzNzg5ZnhxTUFMYitvQlRYWXZPN1NUdXNuTlc0blhm?=
 =?utf-8?B?WUJSSlN3VmplRnA3cytpdTdvUXNrZ3FlZnhkTUtmL0dneFVxMDF6cWVDZUVy?=
 =?utf-8?B?ai9aNDhyc2tkQjV2a0oxM0U5OTN1TlBlZTA1SFdXUmU4QnJDNTRlQlM2MzN4?=
 =?utf-8?B?MExCUmFYYXNkRk1SRHgrZzhBZjZyWkhRQURVWnZjMXBDWkREOVhtSDNTTm1O?=
 =?utf-8?B?dHd0ZDhyQXFmMVNIWFFCWGQrQ2ZJbXR1b2RNVkoweWV6Q0IxM2Y4bTZobzEv?=
 =?utf-8?B?WWxhemRBbGFTQkdnNXFnVGZHOE1iQzdjY0N3WUxnTkY5RlFRa0M5OGVCTUpB?=
 =?utf-8?B?QVp3aXhvU3dVK3ZFb2hUeDJLVFFlSkNTcVR5TEs1RHArZDlXZmMyTXNZY3o2?=
 =?utf-8?B?Uk5tbmZjWjZZWWxYWTNGZWVLdG9CWnhsMW8xVjVkMHpsb0xtZFVndlI3aHZn?=
 =?utf-8?B?MDZrdWZsbUFnWkRVWFFiMFJBZUc2cXBaUjdLcTNhK0ppdS93UUNrL0Y1WHNT?=
 =?utf-8?B?bzMyV2g5d3JYOXJwMnRMYWpaWTE0UElOcTI2ZDJpejA5cWpWTjNJcHJyZTdu?=
 =?utf-8?B?SHZYRVZDMUs1WUpnMzZNdDR6bGJJUVl0QWgvYzY2RDBQRlQyVkVOTnRvdm9N?=
 =?utf-8?B?ZW8rREszL1JibFFJOUNYVDZZRSttN0czVDZaWGJJbjl2TVVmS2s2NmZ3a0g1?=
 =?utf-8?B?OFloUzdGOC9uTmpobC9FRlZ5UjUxYWtzc3ZxaEoxZjZZOXZTa2NLZW5MbURH?=
 =?utf-8?B?Z3JSRkgxTHhORUVIV0MrN3hWbXZLWjh2ckhWYWd1UW9ZYk1EZjF2ZGorUHBH?=
 =?utf-8?B?Z1dZUldkZkJ3bDl3ZDUwclducWswYUpTL2l4YXAvRUF4L09peTFId0tTY3Qz?=
 =?utf-8?B?R3hFY0IrRTk5d1U0Ujh1S2NTWkhlMDBoZDZNMXdnelJPaUhXSFhrcThtV1d0?=
 =?utf-8?B?aWtuRmdKM0c3MkVSd2xDUWlpREZjRGF3VGVYNFZVNmdZZDdQOUF3cE1nQUYr?=
 =?utf-8?B?SmNUTEVRR2orVzA1UHV3dnUrVnMwNWZWR0RVSjROSWd6andHU1VzM2toU3M3?=
 =?utf-8?B?b09CN29wRlAvTTByMk81OE4zbEtHeTh2WmZ1Tk1EM25ES0tPZ0xRaThpekkx?=
 =?utf-8?B?UXpDSmRHUlREOTgvM1VzeE5xZmtsdjhpZTZmYkpVU0FoeGdjNStidWRQZzhT?=
 =?utf-8?B?bmZ2SnVhQktDU1dNRmhoQWFNY3YzSVpVc0t4VTV4eGdRR3REWFdlRG1KenFi?=
 =?utf-8?B?T1VlaWlwc0N1a3dPVVp3dFhKRGV6cW42WlU1RVYrU1ZlMkg2TmVHd2hvUlov?=
 =?utf-8?B?RGNPM1poQ2daOS9ST213dEVjQjJ3SFRCUTRXQ2drdHdQdmpIdzRyMFNSMUNo?=
 =?utf-8?Q?nAQs=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.86; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:20:16.1552 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5650ce-ff89-4092-7f84-08de0b3d8f86
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.86];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR03MB9410
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

On 10/14/25 12:03, Andrew Goodbody wrote:
> The sys call SYS_READ was being used in a way that did not allow for
> file sizes > 2^31. Fixing this required changing the signature of the
> function to allow file sizes up to 2^32 - 2 and also being able to
> return errors that could be tested for.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  common/spl/spl_semihosting.c        |  7 ++++---
>  drivers/serial/serial_semihosting.c |  6 ++++--
>  fs/semihostingfs.c                  |  9 +++++----
>  include/semihosting.h               |  8 ++++----
>  lib/semihosting.c                   | 22 ++++++++++++++++++----
>  5 files changed, 35 insertions(+), 17 deletions(-)
> 
> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
> index f36863fe48d25859ee9af67a67140893b6e9e262..cff6f5351e265136b3effe483fd5d641fdd109f8 100644
> --- a/common/spl/spl_semihosting.c
> +++ b/common/spl/spl_semihosting.c
> @@ -13,13 +13,14 @@ static ulong smh_fit_read(struct spl_load_info *load, ulong file_offset,
>  			  ulong size, void *buf)
>  {
>  	long fd = *(long *)load->priv;
> -	ulong ret;
> +	long ret;
> +	size_t bytes_read;
>  
>  	if (smh_seek(fd, file_offset))
>  		return 0;
>  
> -	ret = smh_read(fd, buf, size);
> -	return ret < 0 ? 0 : ret;
> +	ret = smh_read(fd, buf, size, &bytes_read);
> +	return ret < 0 ? 0 : bytes_read;
>  }
>  
>  static int spl_smh_load_image(struct spl_image_info *spl_image,
> diff --git a/drivers/serial/serial_semihosting.c b/drivers/serial/serial_semihosting.c
> index 56a5ec72428afdd97eccad739a46189380ba3e76..017b1f8eda84f5c25e09be7e970d0ebfdbf2ace0 100644
> --- a/drivers/serial/serial_semihosting.c
> +++ b/drivers/serial/serial_semihosting.c
> @@ -25,11 +25,12 @@ static int smh_serial_getc(struct udevice *dev)
>  {
>  	char ch = 0;
>  	struct smh_serial_priv *priv = dev_get_priv(dev);
> +	size_t bytes_read;
>  
>  	if (priv->infd < 0)
>  		return smh_getc();
>  
> -	smh_read(priv->infd, &ch, sizeof(ch));
> +	smh_read(priv->infd, &ch, sizeof(ch), &bytes_read);
>  	return ch;
>  }
>  
> @@ -140,11 +141,12 @@ static void smh_serial_setbrg(void)
>  static int smh_serial_getc(void)
>  {
>  	char ch = 0;
> +	size_t bytes_read;
>  
>  	if (infd < 0)
>  		return smh_getc();
>  
> -	smh_read(infd, &ch, sizeof(ch));
> +	smh_read(infd, &ch, sizeof(ch), &bytes_read);
>  	return ch;
>  }
>  
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 77e39ca407e4d240a1fd573497c5b6b908816454..15f58d578b65f7dbbadce19093546f5bdb46c0c3 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -23,7 +23,8 @@ int smh_fs_set_blk_dev(struct blk_desc *rbdd, struct disk_partition *info)
>  static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>  			  loff_t maxsize, loff_t *actread)
>  {
> -	long fd, size, ret;
> +	long fd, ret;
> +	size_t size;
>  
>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>  	if (fd < 0)
> @@ -43,10 +44,10 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>  		maxsize = size;
>  	}
>  
> -	size = smh_read(fd, buffer, maxsize);
> +	ret = smh_read(fd, buffer, maxsize, &size);
>  	smh_close(fd);
> -	if (size < 0)
> -		return size;
> +	if (ret < 0)
> +		return ret;
>  
>  	*actread = size;
>  	return 0;
> diff --git a/include/semihosting.h b/include/semihosting.h
> index 4e844cbad87bb1ae6bb365f87f3e7a8aeea445f4..42832d86c711ff04e91b6b739c80629253f6d30a 100644
> --- a/include/semihosting.h
> +++ b/include/semihosting.h
> @@ -95,12 +95,12 @@ long smh_open(const char *fname, enum smh_open_mode mode);
>   * @fd: A file descriptor returned from smh_open()
>   * @memp: Pointer to a buffer of memory of at least @len bytes
>   * @len: The number of bytes to read
> + * @read_len: Pointer which will be updated with actual bytes read on success,
> + *  with 0 indicating %EOF
>   *
> - * Return:
> - * * The number of bytes read on success, with 0 indicating %EOF
> - * * A negative error on failure
> + * Return: 0 on success or negative error on failure
>   */
> -long smh_read(long fd, void *memp, size_t len);
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len);
>  
>  /**
>   * smh_write() - Write data to a file
> diff --git a/lib/semihosting.c b/lib/semihosting.c
> index 9be5bffd30124777c4f8110065e6cca5640312ac..e49b16b0aa34ab04b6c8949a3e7cab539fdbef82 100644
> --- a/lib/semihosting.c
> +++ b/lib/semihosting.c
> @@ -93,9 +93,9 @@ struct smh_rdwr_s {
>  	size_t len;
>  };
>  
> -long smh_read(long fd, void *memp, size_t len)
> +long smh_read(long fd, void *memp, size_t len, size_t *read_len)
>  {
> -	long ret;
> +	size_t ret;
>  	struct smh_rdwr_s read;
>  
>  	debug("%s: fd %ld, memp %p, len %zu\n", __func__, fd, memp, len);
> @@ -105,9 +105,23 @@ long smh_read(long fd, void *memp, size_t len)
>  	read.len = len;
>  
>  	ret = smh_trap(SYSREAD, &read);
> -	if (ret < 0)
> +	if (!ret) {
> +		/* Success */
> +		*read_len = len;
> +		return 0;
> +	} else if (ret == len) {
> +		/* EOF */
> +		*read_len = 0;
> +		return 0;
> +	} else if ((long)ret == -1) {
> +		*read_len = 0;
>  		return smh_errno();
> -	return len - ret;
> +	} else {
> +		/* Partial success */
> +		*read_len = len - ret;
> +		return 0;
> +	}
> +

There is no point. When are you going to read 3 GiB of file all at once on a 32-bit system? Any
sane user will read multiple times into smaller buffers.

So the correct fix is to add

if (len > LONG_MAX)
  return -EOVERFLOW;

to the beginning.

--Sean
