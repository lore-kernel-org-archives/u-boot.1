Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A255CCCD193
	for <u-boot@archiver.kernel.org>; Tue, 14 Oct 2025 16:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2EAE78312A;
	Tue, 14 Oct 2025 18:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="JNSDUeSs";
	dkim=pass (2048-bit key) header.d=seco.com header.i=@seco.com header.b="JNSDUeSs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4A0A7834E5; Tue, 14 Oct 2025 18:21:41 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 45A8B807B1
 for <u-boot@lists.denx.de>; Tue, 14 Oct 2025 18:21:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=hLWjCWmd43bP1y2h2hAcSyuJ1QSK6dq4cPED2rUmxXsuSiwsiEuw2AkOIwWk9/R+fUlufWHceNHn16AUzLkA08sx25QFmtj1qn/SJ2E+6y5GC8OM3/Cv4qI0gZ6zhjXG1AM+1kzhNxwZ84MeHDofqgo5wS1ChPi2yRb9zSWcIARkvvPN9A/goBRUaxgnzakECGebG3KFCtRGjER1PjERGs8fXNNaiC9rTdZZt8WnvGHAxvOXV3dVsLFTJYXGxrz9gCPlHhcBqJpxDLKL5tSKsG4aseHJ8GYboGilYpAelVndzcCdjO3ipEh2cW5ukZG6tI3uANDB8H2ln/w+P1zyGA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guKU+hjj3XbtbaPVwqLSXiFzcwmPg5Rg/VreKwcqUVI=;
 b=kgbJtkOYFWaDs+tr/FG0/bGxWilpvcMOJy25HaJIgaXXfMiBU8HjEGwwT5KtK2TJ7+J8BE9/xjY3lRp+J6QO3W29qoECQoRgAAV0iYNFwtFSMqdzauS7gxlEWUL7iRGvDqLMqv1pXxButtWh3YjnUJsi9BCYIo3VlxJt4chj4WrBN1rrK54eTWEScn3Q4IEG2cyKCx3cKMsR3b2r2aMzvTzkReOHs+XwxFhtenXQSVXeZdkUMo5CuKTi0B541QSLmlt2EBYM2MFeA8f3j2k5zJ31ffvyOU1Tf5eaSp5D5XY8VhoapElWIo/r7fKS4Nb/4z1rj7Ky65+IQbzAMWbpcw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.81) smtp.rcpttodomain=gmx.de smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guKU+hjj3XbtbaPVwqLSXiFzcwmPg5Rg/VreKwcqUVI=;
 b=JNSDUeSsOGXbrbsmVG9ZBj5ii31zGULsnl/6cPk/cYQ/2bsZwikvUVwVFfXVHQvI64WaeEE+6joct78NMw3fUFIOV0F58tynYtMeg8U6ejmRpezAgPDwif5fBty+qV051F6EqQ8uxush9CHb40EfqSlUADBjWUwuCFt2zmVpGwr+tAi/tvxOUvKHIeFI5uaPkDLQr/NbQ2ezfjGTob+9mbBnfo1vFvMCp3f25IMU9lM6VUtlKrZOQzBNAMziN7d+JU+o0viYkOZmizZMbZcDyKsECtD7cD9OnTJ+n7K/tEo4qZfyfvVefLBlf1VB6z52gPDCE/nt1/DaE6tGDTu12g==
Received: from DUZP191CA0049.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4fa::24)
 by PAXPR03MB7618.eurprd03.prod.outlook.com (2603:10a6:102:1d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 16:21:37 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:4fa:cafe::bc) by DUZP191CA0049.outlook.office365.com
 (2603:10a6:10:4fa::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.9 via Frontend Transport; Tue,
 14 Oct 2025 16:21:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.81)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.81 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.81; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.81) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.7
 via Frontend Transport; Tue, 14 Oct 2025 16:21:36 +0000
Received: from outmta (unknown [192.168.82.144])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 23EFD20081631; Tue, 14 Oct 2025 16:21:36 +0000 (UTC)
Received: from DU2PR03CU002.outbound.protection.outlook.com (unknown
 [52.101.65.95])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 291C420081244; 
 Tue, 14 Oct 2025 16:21:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EH5FxnGrJBnGjH/l8daDu4QPcV/dMO7jCBlHhdrHG2a32wT5/4o68TsIZrcnouoRBT+D6fY0OxQctAYJMbKRdS0BcaY5xHtkLCKLsOuG92xjMzLHYAOO7GQiiiky3Nas4qUkFhnoL0WZRb95EpUNgpaM0mehQ5uQSrw7itbiUAswlg/TClBjqiBfUi5Alzp9u/cJHwvgHITBDdStgYXxs7H7gsw0JrTi9vxYClFpqZLoFy97z88995vAvafjG4PiUJwWPGJhl5ki7AmESsvie2Pa+GDuv9xcISmqqaCFha4pnmg8F0vclKBu6lH0+INejcQbOiPxpXjJoX3gAhKHMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=guKU+hjj3XbtbaPVwqLSXiFzcwmPg5Rg/VreKwcqUVI=;
 b=B6C6JC4TM5R7yaaAvM3Ou2QAgG56lM1z5SR31a5+WqrLKzK9F+Uy0yhQMaQGt/UkOs++DkSCZ2Tqb7O0YUipsnkH9Jx7aCmWbM0o/56+QbQv3n/flxEOIoSplluBwV6yNx9R1e1ZN0dgSxa1+j+7O6KBI4zDn1sVLLwistz2lqStji8Z40FIsxqIQ8qkZlKQfi9l7flH6WFFcPb0T2X3pKVV8BWA8sk46x1BczHJXIpt4L+4e3FecMfBBr1kID77o4ztr8YYmXpcZUesjDFrRkksSTE5l9SO5YebEJY9FAWLwHgxz8CY8OWdz1ajPimSaf0JcG8fR+rgaqu3KVvL3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=guKU+hjj3XbtbaPVwqLSXiFzcwmPg5Rg/VreKwcqUVI=;
 b=JNSDUeSsOGXbrbsmVG9ZBj5ii31zGULsnl/6cPk/cYQ/2bsZwikvUVwVFfXVHQvI64WaeEE+6joct78NMw3fUFIOV0F58tynYtMeg8U6ejmRpezAgPDwif5fBty+qV051F6EqQ8uxush9CHb40EfqSlUADBjWUwuCFt2zmVpGwr+tAi/tvxOUvKHIeFI5uaPkDLQr/NbQ2ezfjGTob+9mbBnfo1vFvMCp3f25IMU9lM6VUtlKrZOQzBNAMziN7d+JU+o0viYkOZmizZMbZcDyKsECtD7cD9OnTJ+n7K/tEo4qZfyfvVefLBlf1VB6z52gPDCE/nt1/DaE6tGDTu12g==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by FRWPR03MB11199.eurprd03.prod.outlook.com (2603:10a6:d10:1b3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Tue, 14 Oct
 2025 16:21:34 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9228.005; Tue, 14 Oct 2025
 16:21:33 +0000
Message-ID: <ac6c0dc1-2be7-48f5-8c2e-f90401411bef@seco.com>
Date: Tue, 14 Oct 2025 12:21:29 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] fs: semihosting: Fixup smh_flen against overflow
To: Andrew Goodbody <andrew.goodbody@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20251014-fs_semihosting-v4-0-6f2bc490175b@linaro.org>
 <20251014-fs_semihosting-v4-2-6f2bc490175b@linaro.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20251014-fs_semihosting-v4-2-6f2bc490175b@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0051.prod.exchangelabs.com (2603:10b6:208:23f::20)
 To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|FRWPR03MB11199:EE_|DU2PEPF00028CFD:EE_|PAXPR03MB7618:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ad08d6-dbf3-4288-b4ca-08de0b3dbf65
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?V3RwYXR0WFllclhnT2RzSG12SSs3Q1J6K25xbWxLOFBQRHB6K1FZRW90VDc5?=
 =?utf-8?B?VVNYRE9wSUw5cTVPcjMxdWd5ZXNhK1d4SEZMVlovck5UQTh2akRWQ3Qyc2x6?=
 =?utf-8?B?MjZtWUt3dkxSeHNwZHU1eWp0M0R1dWZSSHFoM0FBdWFzSFhMMDZmVk5NbGhu?=
 =?utf-8?B?bDQxUGVyczlXSVFOZEVzck9CVUx1TnkwWVdnbmFqbHMxZVdSSGVvU1lHR1dV?=
 =?utf-8?B?TjJjTHZpN0xxTFkram9RWXN1S2NOMHVZOGxCSlJkMHZIWjE3TUV4QjUvblBB?=
 =?utf-8?B?QkV0cXpVblNqVngvbUVFNjNPZFJRUkU0STZub0UrYXVremt5eVhUR3ZSM2Yr?=
 =?utf-8?B?T0c1bEhDTnNDL3gxV2tJZU02SThGRGNRZ1MvNGtpRDY4Tk8wRnRFSVpYb0Fy?=
 =?utf-8?B?SUNzazBqQUFVVG93MisvREx4Q2Izdk9Ub1doZ0V2ZmJUZndOL0dsOWhyZHFu?=
 =?utf-8?B?UGdzNlFkdVlTajF5b2VIUm4zRGdCb0pQUlNDRTUwSDJBMlVtQktzdldlbGsr?=
 =?utf-8?B?dXZwdENoUW5IbVJUbFFHT05VTCtnTDVWN1QxaksrRENwQXdGYm5PTWJ0TkxY?=
 =?utf-8?B?TEVWdXRLOEhTU3R3cGJlQWZhZktueUQrRzNST0FNRHI2QXk0b2R3SFNQZmJE?=
 =?utf-8?B?OUFlR0M1QmVZMU15U1JyeGIzalJLeFBZRnVCVERiOEUwaTJyQ0hiSWZRQTg1?=
 =?utf-8?B?b1ZlYVlJWm9pcFZMYWdhMEM3VGl1RUw0dWFVbW40cXJJOFE5VFBiT3U1OU1p?=
 =?utf-8?B?RE9wYU8wTWJSOCs5Y3d4a0o0WGltSHYyYy9UVTJmNVdNbjl0UzNESFR3RU9s?=
 =?utf-8?B?OGlHOExPcHBteUxUeFpDWDBqUEYyMnMybk5PcGZPVUNVR1hYSzZENm01SHM3?=
 =?utf-8?B?emZ0d3dBUVlWK3N5VThOMzFQZEgxQnNFMTZrVWRJYlYyZWJkZ2JyOWdvWHFv?=
 =?utf-8?B?TzRSclU1K3lGRks0aHQydi9MbGpzTi9kSnIrSXdDNDNxUnorSUl6T3d3NlFn?=
 =?utf-8?B?RUptNCsvMUxLRFFibVl2ZDN0MGRlcEZHRlk4Yk9PeEpLbDNOdk90bEFmMXJo?=
 =?utf-8?B?R2JZZHVQTitCRzIwNFpURmZqTTVkYU1GWWtMYXNCWGdUSnBQMWVvcDUybGpY?=
 =?utf-8?B?QW9YNDIrVGtla09UTnkzWGpPQ1BTSmNyVFd2RHgzVjdRRE96SW16QnRaTXh1?=
 =?utf-8?B?NnpMckt2TWdoOUVrVVNjZ3djSlRFdHk1Yk16aW5wUk5qaUh5cTVYQklUMGk3?=
 =?utf-8?B?OHVYSzdnQWV6Vk5Kbmg3bTd5UE5YbEorM1RHTHVvaXV4OUsxYjhGT2hjc1Jp?=
 =?utf-8?B?RnRwbkpuWjM1OGRnMCs0TEo5aGtrQ09RRmp0bFdNblBpOXN5UW4rL2FmTVpN?=
 =?utf-8?B?TTJVbGo1dVAvcld5VzJXM2ZlS0RIckhxUXUrb3JCZmM4dFppNWJkdVFTN1ZO?=
 =?utf-8?B?TWFoT044S1hFQmNwRkRsZE5CcDY1Qm9wbm1FVWo0LzNKd2JPdFNQY3o1TERs?=
 =?utf-8?B?STJwaG5WTFRYcmxlUUVEc1l4OVpDN2JOYmhVQjdiUXFTREdSK3M4a0xzNzA5?=
 =?utf-8?B?MmRKa2Z5aVErblN1M3E2ZENNVktaN3VTZmJudGJQMG1zdlBwWkkyTVdJR2VZ?=
 =?utf-8?B?blEyU2JQNC94dVVNNFJQNmdHTHRiKzhFK0FCWjhnTkp2WmNoUjJaa1FXdVVK?=
 =?utf-8?B?enFBd2tIaFN0ZnhDa2l3ZTdHUGJzOUl1dE1maTRuTGd2K0FqcFNZbzdtU2R6?=
 =?utf-8?B?QkJTV0VFNU1CaFVKQVpTTUxYVU1rQUJHajl5Rk1TTnlPdEswQ2J4YTg1MlRC?=
 =?utf-8?B?QlBhYnBmUnB3aHVKSXdSK2hRenJBSFZCVVRETzVqU3pwTjUxOVVZWWtocC9w?=
 =?utf-8?B?eU1ib0o2VnBUVHdRSzhLMFl1V0YyY0JxV2dJUkYzckFFc0lGVnpnY3VTZ0RF?=
 =?utf-8?Q?zyL7ipzSMl9RAntojnNE2VOEWkDHhAPM?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(376014)(1800799024)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR03MB11199
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d84a714f-6f4c-4c89-2bc2-08de0b3dbda8
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|14060799003|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aDFvdEsrRUtzYVkyOFV0akJuSTZIZ29weFhuQUFTd3ZyQTd5T1VzMUxmMExS?=
 =?utf-8?B?U0hBTzAxY3pib3hXQjJ2a0VweFltWGR4N25zRG5KRW5KcU1EakR0eldJRUxY?=
 =?utf-8?B?NG9FY0lBamRYdDhNeXRZVUVFS1lpb3l3VVBKNFBCNUQycEp1UTZKTE9rT0hJ?=
 =?utf-8?B?d0QwNnpjcjA1M3JuTTRFQTUrc0ExL2hrc3pFdld6T3dvNjZ0OUZhNW5OZUhk?=
 =?utf-8?B?SHBxb2hldkV0YUI1UWV5YkkwRjBiZENnRFlCYWliVTFZeVJ1Y05UNWlNeXgy?=
 =?utf-8?B?cXl2dEEyUFBjSXgyZHU2Z2wwUjU0eW1ERk0weFE0SjJNUkhNVzkxcDhPNUhp?=
 =?utf-8?B?UkloUVg3Z2xYSUUrbTdScEE1YndiM2YzV3h1Skw2TFFOWW5iZ1hGUXVlMXF0?=
 =?utf-8?B?L2UvL21PQjU5QVVhQXQzTkRrcHVIMnVVcHhNZ2wzZkplRmRGS3ZxdHQ4TDJh?=
 =?utf-8?B?T0xaODNXRGZCZkJyNFFXLzQ2UW4yOGVkSkRpYzlzb2NSNWVEcTVwUEZRSmt3?=
 =?utf-8?B?dTdvY0krSWt5MHIvWmc1R0dDdlNaYkY3TTNxNFc2UGZmYjJYNjRMWVd4bkNM?=
 =?utf-8?B?RFMrQlVHOE5vTnFqREV4QWxkWjQ5Sm5aNHlnWURPZmRMUXpqNitETmhyK1lQ?=
 =?utf-8?B?NGZTQ0dRYmNtb1o4T00xRHVuVzhPVVZPR1dGaUpMYkR4SU5kV29tYWNDd0ZN?=
 =?utf-8?B?RElyS0pCM0l0T2hCVW5JaVRLQ2E5VFMxVGsySzVVZmVBMGZLWGE3MXhTM3h0?=
 =?utf-8?B?aFo3SWQ4Y1RzS3EyYVhPS3ZyQUlqN2kyZWxLc3JLSlZGUW4zMU9KUjdUT3JI?=
 =?utf-8?B?Zm93THdYK2hCVmwvRTcwcEVXcnNHanVEZnBDOHdtUit0bllPd3FvcWJOOW5t?=
 =?utf-8?B?NVJaSGpjTkMvWVVzSVdxYW1BamJnUkJJSjc5Nkw5clMrT0Z1OGhwS1lFd3dR?=
 =?utf-8?B?VHNWT0Uwa1RWeXh2VDJ1My9MMkdmUVlYZGJaNkRWMkVLc3dFSVgzbDZuaXZy?=
 =?utf-8?B?Q2ZYYWVZd2ltelR4NnZubnErMldtb1RlZjNxdjJTNHVYVmJmZ1BEcWtBTEVz?=
 =?utf-8?B?c0d1UFZ4MFpFL3plYzlpTUFhKzFYcW9hd3FTd0phQUxUcVV3VzJVTlQ0WnVV?=
 =?utf-8?B?SUVWYjgyTW1SbHJKV2N4SkVvUlJxNzJKZDd3NStoVE85K3dEeHV3TmNOU2wx?=
 =?utf-8?B?YVdJckt2UTh1REVSdkU0RGx3aS91TmQ4OXBXV3lKWFhJRG0xcU83NWx0QlU4?=
 =?utf-8?B?ZU5nVWZ6a1FtTHJ3R0QyYzZUbXVKUjlUdXBxeXB5N0ViSVhKYkFkcFZaZDlh?=
 =?utf-8?B?Nk52RC91R05BcWlxUmV5cnlBdTdyanNPbmx2bGpzbXdDUk1EOHVtYWMxYlho?=
 =?utf-8?B?andZMTNJYktjYVFiK09Ud0VjK0JmaTMvSzRQSmhvMUl6ZlM5Y29ZRnZPMjFn?=
 =?utf-8?B?MGJZN0E1cXFGbHhLU1V1cjhQOFdZUHpFQ3M1aEdaQmFWT283VVdVNVN6b2lk?=
 =?utf-8?B?RjhobFJqeHdFdkxDSkRmUTl6WGNrUE52QnJKWDN6TGl2aFRIQm1Ja01kV2J6?=
 =?utf-8?B?Qk1Ed3VXTjQ1VVBKUDJoY3ZZaCtsMjlOb1NzYmJkd3Vob2JVdzV1N3hoS09C?=
 =?utf-8?B?Q29KTkw5QWxrcnZ6V1JhbVRTelhKM2o1YktXaG9ZdUROTGN6SkprTEtuR2VQ?=
 =?utf-8?B?TmxYRmZYMS9ZbzR3NWFaVTNrSzY4SENiUE5kek5tWmo2MlFMNVJKbjNOcVRF?=
 =?utf-8?B?RjhRQzE5MitXaHlVaStvUTJQS3psbW9SU3BTdk9rcUtpQ0J0NDYzOXUySW90?=
 =?utf-8?B?aWdxd1VsWDBjR3NhZ0dtZldSdHgxZnhGWDdiSitCUW12YnBZbExUeTlRU3hD?=
 =?utf-8?B?UjVydDdxS2FRYUE5Y0czbFVxcDhPWnFOMDVDWGJhZ3VVMFc3Und6ZnRUaXZ5?=
 =?utf-8?B?ZytBT0k2U3pMOUd1UXhlTi9pMjM5TlR1YVJRN1M2a3g2NU1sMHlDbFNPQXh6?=
 =?utf-8?B?UDg3TnRrN3NNc2sxdEZONFlDa2xLYkxLaUhyTzE2c0MyM0ZHeUgxcGxYb21F?=
 =?utf-8?B?S3c4VXpCTllkRnAzdVFxa0RVYWFIaklwbjFodzlHYnA4b3RSK2llQnVTQSt6?=
 =?utf-8?Q?QmSI=3D?=
X-Forefront-Antispam-Report: CIP:20.160.56.81; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(35042699022)(14060799003)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 16:21:36.4468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ad08d6-dbf3-4288-b4ca-08de0b3dbf65
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.81];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR03MB7618
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
> The sys calls SYS_FLEN was being used in a way that did ot allow for
> file sizes > 2^31. Fixing this required changing the signature of the
> function to allow file sizes up to 2^32 - 2 and also being able to
> return errors that could be tested for.
> 
> This issue was found by Smatch.
> 
> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> ---
>  common/spl/spl_semihosting.c |  6 +++---
>  fs/semihostingfs.c           | 14 ++++++++------
>  include/semihosting.h        |  5 +++--
>  lib/semihosting.c            |  6 ++++--
>  4 files changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/common/spl/spl_semihosting.c b/common/spl/spl_semihosting.c
> index cff6f5351e265136b3effe483fd5d641fdd109f8..fb578a274d0d937b2ed5bd13e505bcefd4491799 100644
> --- a/common/spl/spl_semihosting.c
> +++ b/common/spl/spl_semihosting.c
> @@ -28,7 +28,8 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>  {
>  	const char *filename = CONFIG_SPL_FS_LOAD_PAYLOAD_NAME;
>  	int ret;
> -	long fd, len;
> +	long fd;
> +	size_t len;
>  	struct spl_load_info load;
>  
>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
> @@ -37,12 +38,11 @@ static int spl_smh_load_image(struct spl_image_info *spl_image,
>  		return fd;
>  	}
>  
> -	ret = smh_flen(fd);
> +	ret = smh_flen(fd, &len);
>  	if (ret < 0) {
>  		log_debug("could not get length of image: %d\n", ret);
>  		goto out;
>  	}
> -	len = ret;
>  
>  	spl_load_init(&load, smh_fit_read, &fd, 1);
>  	ret = spl_load(spl_image, bootdev, &load, len, 0);
> diff --git a/fs/semihostingfs.c b/fs/semihostingfs.c
> index 15f58d578b65f7dbbadce19093546f5bdb46c0c3..6a4d0aaaf2fdaf8da154e59677839a5c7a4889e9 100644
> --- a/fs/semihostingfs.c
> +++ b/fs/semihostingfs.c
> @@ -35,10 +35,10 @@ static int smh_fs_read_at(const char *filename, loff_t pos, void *buffer,
>  		return ret;
>  	}
>  	if (!maxsize) {
> -		size = smh_flen(fd);
> +		ret = smh_flen(fd, &size);
>  		if (ret < 0) {
>  			smh_close(fd);
> -			return size;
> +			return ret;
>  		}
>  
>  		maxsize = size;
> @@ -79,17 +79,19 @@ static int smh_fs_write_at(const char *filename, loff_t pos, void *buffer,
>  
>  int smh_fs_size(const char *filename, loff_t *result)
>  {
> -	long fd, size;
> +	long fd;
> +	size_t size;
> +	int ret;
>  
>  	fd = smh_open(filename, MODE_READ | MODE_BINARY);
>  	if (fd < 0)
>  		return fd;
>  
> -	size = smh_flen(fd);
> +	ret = smh_flen(fd, &size);
>  	smh_close(fd);
>  
> -	if (size < 0)
> -		return size;
> +	if (ret < 0)
> +		return ret;
>  
>  	*result = size;
>  	return 0;
> diff --git a/include/semihosting.h b/include/semihosting.h
> index 42832d86c711ff04e91b6b739c80629253f6d30a..60535199b9532ce16620aea3ca1ea741c5b73766 100644
> --- a/include/semihosting.h
> +++ b/include/semihosting.h
> @@ -124,10 +124,11 @@ long smh_close(long fd);
>  /**
>   * smh_flen() - Get the length of a file
>   * @fd: A file descriptor returned from smh_open()
> + * @size: Pointer which will be updated with length of file on success
>   *
> - * Return: The length of the file, in bytes, or a negative error on failure
> + * Return: 0 on success or negative error on failure
>   */
> -long smh_flen(long fd);
> +int smh_flen(long fd, size_t *size);
>  
>  /**
>   * smh_seek() - Seek to a position in a file
> diff --git a/lib/semihosting.c b/lib/semihosting.c
> index e49b16b0aa34ab04b6c8949a3e7cab539fdbef82..547a936e17f38204e840035a50f481e57d159592 100644
> --- a/lib/semihosting.c
> +++ b/lib/semihosting.c
> @@ -154,7 +154,7 @@ long smh_close(long fd)
>  	return 0;
>  }
>  
> -long smh_flen(long fd)
> +int smh_flen(long fd, size_t *size)
>  {
>  	long ret;
>  
> @@ -163,7 +163,9 @@ long smh_flen(long fd)
>  	ret = smh_trap(SYSFLEN, &fd);
>  	if (ret == -1)
>  		return smh_errno();
> -	return ret;
> +
> +	*size = (size_t)ret;
> +	return 0;
>  }
>  
>  long smh_seek(long fd, long pos)
> 

Nack, for reasons outlined on v3.

This should just be 

    if (ret < 0)
        return ret == -1 ? smh_errno() : -EOVERFLOW;

--Sean
