Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51508D340A1
	for <u-boot@archiver.kernel.org>; Tue, 27 Jan 2026 16:28:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8C208410D;
	Tue, 27 Jan 2026 17:28:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="q0aVOqzA";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="CIP62fv6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DDE7884101; Tue, 27 Jan 2026 17:28:16 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6E75C84101
 for <u-boot@lists.denx.de>; Tue, 27 Jan 2026 17:28:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UjBBgg8Tmf7C1PTRtdmGdWN/UrRQF3Mf9nlVwLZ6ISOQ3jxOvIkBZ8X8E465UgYqBNf/6zJw7L6GmECK9f49HRMRgQCd4CU9KAApfrni2s6PqhJ+9XQ+kQRFCQYXGsjvEux1wLfmY5ElVpjHwar1BxNq8DVYXswjffS1iBCfom9V511aOGMza+DKVdhhsthxTin/gLj1QPBRlbslfAY2Tvy/Xxwkih0Ff/IhciykzvOLsVWCnprZlkSPxH8eDnD2DAPXMR0t7jU8hYEWFAQCx7sA4WHcWh3SO54U1sKChE7fcv35z5taBg3cPrhNsd8geuFYn3dmgAhh4UzI2fnd+g==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpEi5W6yXol9SkclWyEiWEnI/t5vCOThmp8gJZn2uZg=;
 b=PAT1bxEwD6ZWg4F3fZYT67xwb8Cb2f2Voodb68TD0svJ2n4PtW/LpXEuH0TevxGTAaNPfeeD3E9wGudJSwDIwd3q6SNYQehvhpHKRe3c1t64qnA8ULk+hqbAOxvWHNcHkKheIw2S5qGdYEddycfX3GPjyrougwpVqdRHPz7Fe0lAhcP7Nc0/8pD0r/1ZD0W8v9NFMw4H5KGgiAoWwQCyApg3XG+HYWGaOcbmCCnwoZVAOCTNJKFCIWt0G8uc/vGwmzAjha76zp7EIA3t4N8PIzS2IUT+ePaUuCUxXMUYlZ64oDcqUDa0hWRHhbR0ymDLiCKYhGTrWupXn8Ksk9SM9Q==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.80) smtp.rcpttodomain=analog.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpEi5W6yXol9SkclWyEiWEnI/t5vCOThmp8gJZn2uZg=;
 b=q0aVOqzAEnDcK5Nh1IrZwP6oyV75C5R9NW6mM6CXECbxeyci4jJ1QO/h+YNf7aZpivi/jw0qGhfu/bGxKdUYAIncwhGbO5lIbPIgf5Ar4prM/V09S9sIUoX1TUQKJuncvIfuX25bimnz+crHz6wAgbmHmAUOXd7dOwWxXsJ9leb763Sf6SJAI2w7GwGmAv1pqMLTAaH4W7CI7lfgxCZpbuorNUizWaq5hy9IGS/xAuQHn7DgRV3/Keud8yBJhJ+zyMfpWcWTIgyhAI49mk3btybIl0AgpVRHE8IIVd5ykdr03kKvCfRwtF2Q6urWotxVUTJ2ejCY7l5LzrdBl2yeXQ==
Received: from DU2P250CA0016.EURP250.PROD.OUTLOOK.COM (2603:10a6:10:231::21)
 by AS2PR03MB10193.eurprd03.prod.outlook.com (2603:10a6:20b:5fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Tue, 27 Jan
 2026 16:28:12 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:231:cafe::49) by DU2P250CA0016.outlook.office365.com
 (2603:10a6:10:231::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Tue,
 27 Jan 2026 16:28:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.80)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.80 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.80; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.80) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Tue, 27 Jan 2026 16:28:11 +0000
Received: from outmta (unknown [192.168.82.132])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 5701A20080098; Tue, 27 Jan 2026 16:28:11 +0000 (UTC)
Received: from MRWPR03CU001.outbound.protection.outlook.com (unknown
 [40.107.130.76])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id AD46F20081261; 
 Tue, 27 Jan 2026 16:28:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+eun+H+izNTz1ECetdLCY0nk1vZ+UNDJvlSm9qCkiolLDomsTFvSqvSrCpk2CExLWDqBHb74p5mc4K+TCiJgXZozueG4V/eH5xGYaDWKNAB9pVqY3n1Em6GetY+ZFFPo9jYD3trkR1pGE2ggzVbXhzFv2h2Je3vcZUP6NY5uqciZVCehqAhZswV2C9Ilaz3xx+ZCBi3MlrX+LqL1+yQPuA4UXbKYE7PgNinajZ2mje6zbsSb2hXARpSCZa+5JvgNmmD5qtCKSw5YMDrXfuU8jyaQremTgQjmMPq4HohO/RqS3QwG/zoi6sddJnU3M9DbK1/UlmKcrefwb0pKsz/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cN/AxmAnvMu0uPXpJmqUeG+ur/UZEFxCS4d2JhZCJk=;
 b=gw3y6Mycgi/ByX1sgsWDYzvlQPhvioli1BFh+6mrutgYBnG2Ujcz4QD0uHpfSvVjGvBcoDMvxoi0UogoIaFrZYQmTZgsTcevSqOndGVxEyl+2B/SLnADpnjCD5knuFIu9IDAhCxSBNoiHswLd8Iz+mOG5W0QuKFoq8+3dJnq8Jp25/YYMEnuxrLaB4CF1mcXRUS5PGD1+erEumhJimIDtSA1JczwBGyJPzcKzmlP4V81zfv6HvRUSUgbrbhKUXJjSz7B4XYxNlqcxkH/TH7IAY/T4IbMUikV2FX9JBUujRV6n9PtDr4HOrEQ7/5fqeU446VpKmkY7dsK/V3wl0KwkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cN/AxmAnvMu0uPXpJmqUeG+ur/UZEFxCS4d2JhZCJk=;
 b=CIP62fv608q69Ro11e5W+Zqk173fJ1/AscdvktCK9aZxVMu1OWZrCrlUr5cMcf8A3iHsniZ1sNZNmvudo6OECHjr52N1DB6UsWATjuFEEGR1heFMBbH0GY/et4m/VeFarrsG1Floz572QbBEXF0pVVVztFwEf5WB7CEw1T+bg17CKlljpNaUVNy9UZ+RqBq3JaqKZFXFWKtduxJRDwiBp1El0s5FrmZhSz3V+GQuAWZAaT8uijTdzdnjC14SZrt9MMKUv1+FU7c1PJGKFOMg2IWwp8l7vUAx+AiBk4Dv2gE8qG1+dC2Wecd02u1wVdJDNGD2lPZTReFvsHWm7dG9DA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by PAWPR03MB10181.eurprd03.prod.outlook.com (2603:10a6:102:342::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Tue, 27 Jan
 2026 16:28:07 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9542.010; Tue, 27 Jan 2026
 16:28:07 +0000
Message-ID: <b09e8fbe-1f5f-445a-a28b-ff6386a728a5@seco.com>
Date: Tue, 27 Jan 2026 11:28:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Tom Rini <trini@konsulko.com>, Marek Vasut <marek.vasut@mailbox.org>
Cc: Anshul Dalal <anshuld@ti.com>, Beleswar Prasad Padhi <b-padhi@ti.com>,
 ilias.apalodimas@linaro.org, malysagreg@gmail.com, sughosh.ganu@linaro.org,
 philip.molloy@analog.com, james.hilliard1@gmail.com, afd@ti.com, nm@ti.com,
 vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
 <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
 <6896afd5-76fa-4b1a-abbd-0798f19185ba@mailbox.org>
 <785327c7-9d8a-4f5f-b792-4a1590796948@seco.com>
 <20260126225842.GY3416603@bill-the-cat>
 <f9310861-396d-4a89-b4a1-d67b9d6cae89@mailbox.org>
 <20260127160637.GD3416603@bill-the-cat>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <20260127160637.GD3416603@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN0P223CA0018.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:52b::35) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|PAWPR03MB10181:EE_|DU2PEPF00028CFD:EE_|AS2PR03MB10193:EE_
X-MS-Office365-Filtering-Correlation-Id: 1217ebd1-1f88-4dfe-eabc-08de5dc11056
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|7416014|376014|1800799024|366016; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?MTFIbjJCTFlDVFJ2SXVaanROcDUxanJBYm1zZGlhQURDWGx6dWV0OS9kazBC?=
 =?utf-8?B?c2lTYlk0ekVYMlAydU85VXRjUjRnZFF5Zy8wUUp4cDVQa2wzZWJLVFovWC9F?=
 =?utf-8?B?amZ2SDVHRkpweXVDK0t5K1pjTlhMMURxcy9KeU9tSzVmaWUzOWUzUGFyMXFV?=
 =?utf-8?B?L2JKZVJGcERzTmpma1Q3ejZidVhxdEdJa0QrNnJsMmFwWG0vdGNDYVQxVnpy?=
 =?utf-8?B?cEVUQWR1RXF3UEo3QzRoVFdLeExSSTNlYXRZWjh3K3lVaml5SHZnYU1oZGMz?=
 =?utf-8?B?c2YrMnVaZ0ZUNUk2TE5qdnFBblcwdWwyTXFYaDluYW95MWhVL2RHdkNtVmRj?=
 =?utf-8?B?Z1M5OGVDVFNXSlJ1aitxbkE0N1hsTUdjSDBCSEZDR1M3WDZBZk5adWVUQ0dm?=
 =?utf-8?B?Q1NERTZHc0M5M2c3ZlZ0R09uN3pJeUxzZm9mbk16NTBWMzBCV0xrNU41VFhH?=
 =?utf-8?B?Z0J1Nm5RVEVXSVhSeEpvV0JlOGxsWnZOOFRmc2drUHM1NUJLelZrWm5BUm8w?=
 =?utf-8?B?N21DZm5KVHRDcUFBWDBaQjE5ZzBKTVcyTlBISU4zem9TWXVBY2QrcTUzYkp4?=
 =?utf-8?B?MEU4VXEyM2I5cEV0MFJ6dEJLOXRZZXlqcVMrOXU4Q1d5V2g1dzhMSE10RDhZ?=
 =?utf-8?B?RUUvaTBhSnNlUVhWcE1IRlYwY015UkkvSWZEMWMrbHZOL1JEL1NJS2o5WHdC?=
 =?utf-8?B?T3ZTaklUYlp2VFhHRHlEM3cyWDRwVm5iMndSQjNDR1l3RFdEaWxUMXJEVTcw?=
 =?utf-8?B?UEJwR2ltNVBvakg0WjgwMWpJSEgwazErSzJnYmlCbmdaMDh6b3NDc095dUR2?=
 =?utf-8?B?VVF4Qk5QY3ZXV2NlSzVFNDEyakx6TmRhbzFJSkY0VXFDa0wxRWtVVDZqdnVk?=
 =?utf-8?B?YWpSdjhOVzNKSkI1MmJOQUZveDBwVnptdzhJT0J6dG9URzYxNzB5S1dUdkJt?=
 =?utf-8?B?cWNGRkFkY0pDa2JRUFcybVl5RENLTjZ1WHhPdy9TanMzS0pjSFpRb2dsUlQ5?=
 =?utf-8?B?N3o5UVIxNWVqOFg3MzlOU29QRE1HZlM2M2xaRDRjSGp1RGdJU3ZqNEVOb1pa?=
 =?utf-8?B?OUpDTzZEVVF0MzZPczRtOTkrcW13UStVWTN3TVFsZDYwWUJMU2kydk9oZnVQ?=
 =?utf-8?B?bWhHWnFudi8ySDhEUXBQbVBOS2lyc2ZwS1V3NlhRcnJ2QnZHSjhzRldyWkx0?=
 =?utf-8?B?Z3Y4V2hPMjlRWVVzbmY4RFRiS0dtbTl1aFAydkZsUkJTSTRLWFl6Q2JjbHFl?=
 =?utf-8?B?NWZsdmx2dTBFbzU1cCswamFURWdROEFKa0ttajRlbnFpci81Unl0TTBjYnFQ?=
 =?utf-8?B?K0IzU1RrdFdzYjVXaWtGa01zTFB0ME9LQkJ3akxEYnUrMWFtL3BYTVBlUlUy?=
 =?utf-8?B?azNjLzdudGVFeCt4aGw5RFFpSnhnTWp6WHRaMlFScVNUUlEwWi9MTE50WFZH?=
 =?utf-8?B?c2V0a0tNUXNsM0o3MjJ4aW1tSkZNNGYxejVPM05sTVlqbUowSHBINmN2U1ZU?=
 =?utf-8?B?aWo0WTRwSkR0L2VhR3ZEQWp5Z3ZWUEpNN3VaeVRkeWQwclE2QUhkczdIZEpo?=
 =?utf-8?B?eVhpMFJGSk9hU1hNQmtiSGZXQ2FrWXVzQlFTRkxwcWlBbW82TjNZRFpMY2ta?=
 =?utf-8?B?MHIrTXpnR0dPckViQlNPaWZ4cnB1amMvYnFmS1VVSStLdzlsVW9HSW4yVncv?=
 =?utf-8?B?OHZ3Q1dEQUxVa3lnRTRhQUh1MjdIbExNVnFMSmwyd0xEU0xSRXlsVllZdjBq?=
 =?utf-8?B?dGNaSlozWmxlT0Y1OUlEbXJ0Z1BNUzhFb2o0TXhZdWQxVGFldXBXZHcyLzR0?=
 =?utf-8?B?Mlpsallacnp2OGtmVWllT2ZZazFuVVBFZVJZdzR1YXlnaWtVU1hwMk9MTHo2?=
 =?utf-8?B?RGpudWU2VlM4TElWaWNkZmJuVTk0SlFscmFSMDVibDNrZ3ZSbWFBZGx1Z2Ix?=
 =?utf-8?B?Si81aXU3Y3NaNVFVMjh5OWE4dEVLZmswcm15MjRuRU0zR0FrcThOQlFiYmtt?=
 =?utf-8?B?SW1tN0pwdTN0NFFUa0hZWW04MlRhVzBndWUwUUtBS2dxOGpQRmptdkpIWUlI?=
 =?utf-8?B?ZTJ6ZFFUeVRoc3g5NzFrdEZPSFVxQXRpOXU1M2N2VnBQOEZXV1Vrek51MEpK?=
 =?utf-8?Q?CGaU=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(7416014)(376014)(1800799024)(366016); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR03MB10181
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 572fcf11-8932-4f1f-3346-08de5dc10db9
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|35042699022|1800799024|36860700013|82310400026|14060799003|7416014|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ejE5alIxRmlERlEvY2VLdlVDNnk5R000SkQyNTBTemlnRjJWaGVpVUVrUnkr?=
 =?utf-8?B?eFBzSkM4eklOT01ST0RTelhFdFFWZU5mbHVkcklScHJaTlQ4UXF6dE5sWTZG?=
 =?utf-8?B?L0ZoOHdtdzJjL3pKOTRvWHJEdG1weFhQK0hGU2RWWE5pR3ovKy9aS21VMW1a?=
 =?utf-8?B?YktWNWw2MURTV1VEakl3WmZiNXdsWlo0VitMSGJWQlo1eVV5dzdWdTlmM0pJ?=
 =?utf-8?B?VmRueCs0TUFLbXZ6a0hWd0ZaczEwaEFQLzJ2NkZOTFUvOTdaVWczaUwrNHU5?=
 =?utf-8?B?OFc5WFNWbzhnNTVQZjFuKzVyUHZ6b3RQNzZXZkdEZTZleEhiVVorL0s4Vkl1?=
 =?utf-8?B?M1p1THZnY2tGdndJRE1WVVNpQVlKQjh1MGxMazJnZm93eXFCS0M2WnQzTnZl?=
 =?utf-8?B?NnNtVVBzNG8vaER2TGFmRUNTSjA0aXdrWVViOGg0L1k1SWpNSXhnaGRkdFYz?=
 =?utf-8?B?T056YStkSzZISHRUMStTZ0JkSEpveDZkS243dkhUdFk0VExMVDFLdm5PZUNJ?=
 =?utf-8?B?NUliVmt4OEx0bUxLVU5DQWpLOUo1U0g3S2FLYUFzMlhud01oVTc3RWlIZS9F?=
 =?utf-8?B?bTI0Z0dTY05uMjBnenRQQ2kveW54Q1RlSWkzQU5ya1hDaHZHWUordGxnbU5z?=
 =?utf-8?B?V0V0OXMrMVBBcFNQNlZLMWFxRy9TbzBzWHVreXFTK3FxUWFITVBkam5mVlF5?=
 =?utf-8?B?Zk5Yejdkb1hNLzNaajNWMXpvL3lNUDJtUXFpdlZYcUdDcnZ4djZpTzBxUm5I?=
 =?utf-8?B?Y2pXY0NULzFJUTBYQW8zekVOZXhaSi9STERJSVlKYlZkSHpEWlJNWjNsVWJP?=
 =?utf-8?B?eHRYRGFnZkZvZTNKbk14QWtMOGU1aFFobWh0VDVXVGxzQjdnVVA4WUVZbjVQ?=
 =?utf-8?B?VHZhR1dHMld6S3FuY2lvTWNaNXpwa3FjSWFJellpNjZpNzNtMEhJOURVeCtT?=
 =?utf-8?B?RUtvNVBJckZtdGtTdGlkYjNJZzdCRWp2ODJVajNzdzA5K3ByQ2QxMVN1dWdW?=
 =?utf-8?B?TlczTFNkTURNbkdpNTRjYTdsbTk4OXpNRlZhenhLRWJRam5XOGt1OXV3SVJJ?=
 =?utf-8?B?ZHFPZFN1a1hWVjFQT0xyOEMzM3NBUy90UG1hVVd6Tzh6WXR1UzhjaGlCTHpF?=
 =?utf-8?B?NW9HU0NRWVN2WHdjNmlvd011NDMxalJ0TE9wWnVRK3lJV2tKMitnWDk2NG1H?=
 =?utf-8?B?Y2hCUzYwK2IrVFBDTk53N1FaT3ZXTzZQRzRhSU1HV2c1VVdZM2dTNnNMRlVu?=
 =?utf-8?B?QWN3RGxTZUNqZkJpVG9ZRnNabS9lOFFRQ0xBZ2sxVlBZalZuckRacmlGcmF2?=
 =?utf-8?B?OGpKczMzSU0vdTh2dzJhRDVPWFNVanJ6UWw0U0xrdUErWWdtVmpMYmt3K3k1?=
 =?utf-8?B?YmVEK0lIVGdCcXRwMkt6NXFydHh2dGtPSU81QjBRNVNTaW1iNHFtOVhXVWx2?=
 =?utf-8?B?SHMrVzdBcVB6S0I4aU5RVE1oVGR2RURWQTRBOU9wK1pCV29xbG53d2lpbEEw?=
 =?utf-8?B?WmdORGdGTUhNTjNQZEJmTHhHUkRXNTVJZndvd25nUE5Uc3NiSDg3Y2dFMzlZ?=
 =?utf-8?B?L2xyUTFTbVpVbzZzNFlSYWswTHNWWjVsTGRIRFZLNE1ZNHFiUnZya3ZERGNL?=
 =?utf-8?B?V1BNWE0zeEZYU21za29TV3QvSFoyWncyWmZHbGtCQ2Z6VzZlVjNYcUdYYlFB?=
 =?utf-8?B?bjA0R1Z6azhoMlhZWHZVbWI1NFFodVh6WWNZWlRxcEF1M1dsMFRuMmI4WXhG?=
 =?utf-8?B?UmNZY3NPUTNWRXVTTzZIdXNuSUdRMkZJZUJFekVDS2d2QkJRcW8yV0tpMXBG?=
 =?utf-8?B?UUdMMmw2djR4SC9YSnNxUDRmTXk4TlV3QTU2dEovclFDU0F3bUZGdTEyNWpq?=
 =?utf-8?B?Y3l6N0hSZVRqNHBCVVlYVXJaU1VLSEVFRm93YlRPRy9Ld1ZtUi9ZbENBZlU2?=
 =?utf-8?B?ZXQzdEliU1FFamYrTS92bi9iZjNMa0ttcmNCMVdTaks4NGp4TDVYMEY2dlZ6?=
 =?utf-8?B?bVVqY2ZRb3hKWGkwYVRFK0dFazRBenMvTXpjb3QrRzVGMHBZOENmTGNjcldE?=
 =?utf-8?B?c3IzK2s3TmFLRENEZGRMayt6QUR5aEVmb3oyc1NPZTZQa2k3VFFTTTdnZ0hh?=
 =?utf-8?B?UVp1NHZSbDZEWnNsaVEzRWJLNFFIY3ZjTExFMkdjOE1Qckk4UTk2T2NDTFY3?=
 =?utf-8?B?bTJrbVdQRmFoL2h4K0JxVXZ6ZG85YytUOXoxbXBqcVlPc0ozazdZcVBDQUxW?=
 =?utf-8?B?T25mRHNPNXBsMjR2NjhUQmxuMmR3PT0=?=
X-Forefront-Antispam-Report: CIP:20.160.56.80; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(35042699022)(1800799024)(36860700013)(82310400026)(14060799003)(7416014)(376014);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 16:28:11.6624 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1217ebd1-1f88-4dfe-eabc-08de5dc11056
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.80];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB10193
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

On 1/27/26 11:06, Tom Rini wrote:
> On Tue, Jan 27, 2026 at 01:36:59AM +0100, Marek Vasut wrote:
>> On 1/26/26 11:58 PM, Tom Rini wrote:
>>
>> > > > Some validation of "len" has to be done before it is fed into strc=
mp() here.
>> > >
>> > > Well if you are concerned about lacking a nul-terminator then we wil=
l
>> > > read at most 8 bytes beyond the string.
>>
>> Which is wrong, and trivial to fix -- check the "len" that is already
>> provided to you by fdt_getprop() and make sure it is exactly length of
>> FIT_TYPE_PROP before doing the strcmp() . Then you should be safe.
>>
>> > > The other thing that can go wrong is if we get something like
>> > > "flat_dt\0extra data" we will match.
>>
>> This I did not consider. So maybe what needs to be done is compare the
>> length and then memcmp() instead of strcmp().
>>
>> > > Surprisingly the closest we have to this construct is fdt_string_eq_=
. I
>> > > suppose this is because most strings in U-Boot are guaranteed to be
>> > > nul-terminated.
>>
>> fdt_string_eq_() seems like the best fit, yes , nice.
>
> Bad news, fdt_string_eq_() is an internal call in libfdt. Good news,
> fdt_getprop() makes use of it via its eventual call chain. Which I think
> gets back to what I said earlier, libfdt is doing the input sanitization
> for us, or so many other places are more useful to exploit?
>

No, the check in fdt_getprop is only for the name, not the value (which
could be arbitrary binary data including many nul bytes).

I think the assumption in most of U-Boot is that the provided FDT is
trusted (or at least not maliciously ill-formed).  functions like
image_get_checksum_algo read up to 6 bytes beyond full_name if full_name
=3D=3D "". It's possible to read off the end of the DTB if this is the very
last string in the strings block and there is no trailing padding. If
we're really concerned about this (e.g. to avoid false-positives with
ASAN), then we should just add (say) 16 bytes to the end of every DTB
when we malloc it.

--Sean

[Embedded World 2026, SECO SpA]<https://www.messe-ticket.de/Nuernberg_SHOP/=
embeddedworld2026/Landing?code=3Dew26561753&returnUrl=3D%2FNuernberg_SHOP%2=
Fembeddedworld2026%2FProfile>
