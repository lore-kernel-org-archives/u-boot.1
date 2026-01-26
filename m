Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5458D19502
	for <u-boot@archiver.kernel.org>; Mon, 26 Jan 2026 17:38:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 187C383BD2;
	Mon, 26 Jan 2026 18:38:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=seco.com header.i=@seco.com header.b="hFi0Uexd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=seco.com header.i=@seco.com header.b="wnDIvmO5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8E7B583C72; Mon, 26 Jan 2026 18:38:57 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DF8B083B27
 for <u-boot@lists.denx.de>; Mon, 26 Jan 2026 18:38:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=seco.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=sean.anderson@seco.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=vhG4po6e0uQVbi5l+iiFsyA6D5kunKeayutsWmDTGbQ0MpVyjtVoBFfXSvvqU4acRgJQaxYeqNHOkAFB8xv4wY8akYgGwDOVOl7KSPlcD9OI2Gqn9kgHeYOvX3B8zGekge32ktLqFnKDX6NbzHmdPLcDBpM8g5P5xvzmBA5QrEvVIfXeYeLmHrnOqbpwQY549rnkX8Sjkh46GtZuVMbwCcxOa/QDpav4gtC2Bmfb+QBekyDRigaauv6Kj7W9lyg9Ub9usG67XtXtweaqenw9CeDihPC3+h8Rop3DrAuv3E1rMP1qm1yxPQqHGs7L6trCcKogYA/xUCasilIZ0Hzusg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmhbA/bxpdq2zIM5X9zTLUvaFJwraEpsbu9jIV6Saug=;
 b=jqs7GBaz8q+BIcaYKMvNg+Fe5fpG4BDNz+W7gXpOmzp1BMRZzQXuDE++irqXNukFYN0beIMB9fLLA0bkBnNLbNalWcWGWTFstP3YF+7hag+SpW9LEzyFMVlLNlOc0zhCxlfHOzp/qgLafQ01LZPIVEocvuOW6cfDLb41KCS6SELwj1stiRoAkAJXCZAiZaMizMFmAvyVECVdGLcTUGNVeGK4+UMadBDwnEiNPRnozJsN3+jh0OQbUoDZUtKgX79a7Bd+zrbW6bfF+2aLYZtyNbtZZCPiCjLapySSgq0fsEaNRGr4ZUdSugI66Ohk5CViCGsgf6tnSVE428/iTNCM2w==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.160.56.84) smtp.rcpttodomain=analog.com smtp.mailfrom=seco.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=seco.com; dkim=pass
 (signature was verified) header.d=seco.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=seco.com] dkim=[1,1,header.d=seco.com]
 dmarc=[1,1,header.from=seco.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmhbA/bxpdq2zIM5X9zTLUvaFJwraEpsbu9jIV6Saug=;
 b=hFi0UexdCt3ivd/GGdxgPKkIos1xB2iEYtNdNiAd1T8V++oK5iefzs+Aqdw1JkTOycha3oP/eCHRwzhRk4jKw2u/SPPkslmBhtHUcduJKZJLO17FGWt1UwpLA2JO5yRrNofyZTl8qAcHf7JHrjdpzdil8OpRzZzQP4iPseZLxc8zQNlDmwdMRywwnvjCywOmftiNy79xMqEOn3+liXNJWGRfHG5VJ2k9E812uUmULtotZxRZ7JTjI1sNt68KReO2G1Pg8aNyoOWfSdNNQEFh+Pqti9U1zy7/2ettBIQC5JP7Lk6IlPOlpjz7NrYKQlEpBlPLnQGP9Ofd2CElAWl4fw==
Received: from DU2PR04CA0062.eurprd04.prod.outlook.com (2603:10a6:10:232::7)
 by VI0PR03MB10419.eurprd03.prod.outlook.com (2603:10a6:800:209::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:38:33 +0000
Received: from DB3PEPF0000885E.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::59) by DU2PR04CA0062.outlook.office365.com
 (2603:10a6:10:232::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Mon,
 26 Jan 2026 17:38:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.160.56.84)
 smtp.mailfrom=seco.com; dkim=pass (signature was verified)
 header.d=seco.com;dmarc=pass action=none header.from=seco.com;
Received-SPF: Pass (protection.outlook.com: domain of seco.com designates
 20.160.56.84 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.160.56.84; helo=repost-eu.tmcas.trendmicro.com; pr=C
Received: from repost-eu.tmcas.trendmicro.com (20.160.56.84) by
 DB3PEPF0000885E.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Mon, 26 Jan 2026 17:38:50 +0000
Received: from outmta (unknown [192.168.82.140])
 by repost-eu.tmcas.trendmicro.com (Trend Micro CAS) with ESMTP id
 42AD020080E86; Mon, 26 Jan 2026 17:38:50 +0000 (UTC)
Received: from PA4PR04CU001.outbound.protection.outlook.com (unknown
 [40.107.162.129])
 by repre.tmcas.trendmicro.com (Trend Micro CAS) with ESMTPS id 4193E200C4FE2; 
 Mon, 26 Jan 2026 17:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xm2sXbrlqfwKdB5sCGOYfhzkQ9phdoMStZ0OXfSppI7Mpbuhg1umC3zwm+9FMDChznjIQ4Fyu/ybehv6Z8ZGai2LuWbVMH9N/gV5S2hXogvDrgUkiWiv3fAmC4LAxs6RpU2HUEPR4mdP3scXQ/WA+M94TzcTZ6Rpp2OPF5V1Ns6IFcOxO0r/xc1KRI225AISz9NZ+I+q7TvzqP+0M95U1D3p0lPk5NPzVGWsJu8I6a/ILc57knW+CnXmyA0U8uqzSffBggBrIZYTXOLxKZazlydDs/BnCGmaryv28rKdVT/MS0zodqcu/O9+7WZXc1KRsUCXoNqSlJbHpd3fUL+4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wrA4N8pD+XdgS3bNKnSwqKETq5LgKr3AwSosKLoLnCQ=;
 b=d4gLl0avEsnGjsUGPndJcsbIQqP/SCqvCgSB8BXdPSU0JoVp4ow4Q07AUU07kPVwVjmVLIHwaYj6iwKIOVbKzUtSoN6yrutPuFdEx9uqvfyjy4FZX2DJqmFOEg316mEAkTSsreAF+QcPZ8taaeHbkTlv5erld/RjMHYYxbbBKdZYjjQ6WL9Cg5gNybFYcUa0BOY16y8a7zR1tb3i62O+n23Te8LmfvNEswRj3yG62ZhKUTILWOjldSutKQkDERKyUL0rMzyQgr6MEE5BybWcxghF1EmPApK5bSUq7pf6A6qngkM4+K4xgez7CUoCXJUpK3h0rUat+4uRt5qdxLMCtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wrA4N8pD+XdgS3bNKnSwqKETq5LgKr3AwSosKLoLnCQ=;
 b=wnDIvmO5FOnxsfjHwMgKfUjWMajNSHVWjRTXpzXvf8TmApEtebE1XztgvmbRp69HG/Lm9Ci8sYuMakhGs7ApYzh0mdeyL5gvAuwwbKTm++mLn9eB0K4qDh4K6y+eeXIXvlKO8Obn0kcJzLAENI1ajhdSExxTQQxM6+kR/dYFlo8uLDoXMRnUwX81+wOhFU1nOsVsRh5WBFi9jMZVrArlh83F8afqlgDj/CPfzsIuAaJpNt+RPxPREYxDrAQq9MTfMxxtae+f2TVG3AoOetyTffgINNK3SVd9FbLEbLYk21iIoincyH6L729X/1r5rlbyjBpI1XLqjTBBGSxGNVtHdA==
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com (2603:10a6:102:329::6)
 by AM9PR03MB7218.eurprd03.prod.outlook.com (2603:10a6:20b:264::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.15; Mon, 26 Jan
 2026 17:38:25 +0000
Received: from PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce]) by PAVPR03MB9020.eurprd03.prod.outlook.com
 ([fe80::2174:a61d:5493:2ce%4]) with mapi id 15.20.9542.010; Mon, 26 Jan 2026
 17:38:25 +0000
Message-ID: <ab3a8a36-eaa2-4030-ba18-6c75647455b6@seco.com>
Date: Mon, 26 Jan 2026 12:38:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mkimage: Default to 8-byte alignment for DTBs added
 via -b argument
To: Marek Vasut <marek.vasut@mailbox.org>, Anshul Dalal <anshuld@ti.com>,
 Beleswar Prasad Padhi <b-padhi@ti.com>, Tom Rini <trini@konsulko.com>
Cc: ilias.apalodimas@linaro.org, malysagreg@gmail.com,
 sughosh.ganu@linaro.org, philip.molloy@analog.com,
 marek.vasut+renesas@mailbox.org, james.hilliard1@gmail.com, afd@ti.com,
 nm@ti.com, vigneshr@ti.com, n-francis@ti.com, u-kumar1@ti.com, bb@ti.com,
 praneeth@ti.com, u-boot@lists.denx.de
References: <20260122172247.2995437-1-b-padhi@ti.com>
 <20260122174546.GB3416603@bill-the-cat>
 <c05217b3-f753-4fd1-9582-921e2cfd3a0b@mailbox.org>
 <b65ad902-2d07-4948-8a1a-64f4d5825a08@ti.com>
 <1e1f2e09-bfb7-4c7d-abd6-25a79271f256@mailbox.org>
 <DFVWL63A8IDP.23PE1QNTXTMRU@ti.com>
 <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
Content-Language: en-US
From: Sean Anderson <sean.anderson@seco.com>
In-Reply-To: <6cb4957c-7178-4a31-aea9-ad78d6627c28@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: IA1P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:464::11) To PAVPR03MB9020.eurprd03.prod.outlook.com
 (2603:10a6:102:329::6)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: PAVPR03MB9020:EE_|AM9PR03MB7218:EE_|DB3PEPF0000885E:EE_|VI0PR03MB10419:EE_
X-MS-Office365-Filtering-Correlation-Id: b2564915-c398-4022-d05a-08de5d01c496
X-TrendMicro-CAS-OUT-LOOP-IDENTIFIER: 656f966764b7fb185830381c646b41a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014; 
X-Microsoft-Antispam-Message-Info-Original: =?utf-8?B?RHh5bVhmLzkvZm4rN2ZFRXVvYWgzTHlxc2tNbk83NWVCWDhxazlRRDJmdHVJ?=
 =?utf-8?B?UGlhTnhnQVArMUdKQ2xUOG5zZTBERXZiWFM5K3FPSXg1UGRSWXFNellSOFlz?=
 =?utf-8?B?TE9vL2lzZjJWZWc2bmNjcllCdFlqdW5iM2oxTU1EcUdFelpzRDNyQ1Nxd0I5?=
 =?utf-8?B?Y0RreUcwWEc4Q3V0Q2lCRWpVcXFMRWRkRzVnRVluNk96K0kyaEErcWRyVUh0?=
 =?utf-8?B?TzMzMktsbmorMWF0MDUvQXFsM3B2QXBkSTBrbWw3dHNkTW9RWEcycnhFcUl2?=
 =?utf-8?B?ZnlHTktpSjVpMHp3TnFZQ2VSeS82REdXNmhtdzNxRjZkZjFZQ29DUHpodmth?=
 =?utf-8?B?dGhJTjBad2lrVUlxUXVsMyt5MjMrOGlkbzM3bnFIQU9xTnR6YXFxZGZqRjlh?=
 =?utf-8?B?SDFtR2RKYjNMUldNazhqS2wxZzRaMTN5YXpIYlUralNzTDRiNy9PUUkrRnNG?=
 =?utf-8?B?YmhVbUN4UE1UQUIxdmNhcFdMNGFXeFR2T29wOUR5SHRsU1VPYytqVXFJcFZS?=
 =?utf-8?B?Qnkya0F3YjYyQjE1cHBiZzJTaC91Q2dtN3FkMHBMdHN2TE8wZ1dJeFd0R2xX?=
 =?utf-8?B?Wk9nQksrRWlYQ1ZOMzRLTHJ1SUNRaVM0OWZaN1hhK1VIR1BHemhYTDJFOFlW?=
 =?utf-8?B?cmk5cWNvcUgvZTFzSG1kazVYRVRLL2ljbXBJd1lzMHplSmY1UGRPSVUzRE5u?=
 =?utf-8?B?Z1U1ZGhlNUU5QVFuOEI1VEhLVW90YUJTd05hbEdraHhVbVNMYTRXTjVxOTlZ?=
 =?utf-8?B?VXFSUDhWcFFmc0ZrN2xST0xrTHN5S3ZlSU1qTGRERTFYbHFQbm9hcldJUkdu?=
 =?utf-8?B?b1JPOEZjWWpFTnhNK3F5b1l5WlByVy9rdmFPOGJuL3VmNFYyaUFyc2NZSGND?=
 =?utf-8?B?MnpJUFlFcjMyWVZqQm9MaTQvZVVoY1NVck5PZ2pLYm9tdElkU1d6N2tmVERG?=
 =?utf-8?B?aG8yR1FmWmw2eng3L3NmSnlOeUZJMVB2ZEhtb1MwVy9HK2FFR25kVlpxd3dT?=
 =?utf-8?B?eEJzT1RBYURHMWZZSGpLWlFDaGpIRWhwWUROd3hVR1lad3Q1dmIvUE55YXBs?=
 =?utf-8?B?ckx0ZDNPZk5YMTV2UWhsTmZEZllUd1A4TGl4bk11c1hLd0FiK0F0cW4xVmFi?=
 =?utf-8?B?MjNKUHVMcjcxdG1DR2xyaXE4RzdiUG1VNlFJRnllQm5zVURpYnVlKzVmZnJG?=
 =?utf-8?B?c2VhUDAyZ1RVMzVZK2p1TEgzK2N4Nmp5NlFlSVgvSEFtR2xuQ0FkRnBEODhv?=
 =?utf-8?B?VFVnTVp2OE1GUkkxZXhJR0gzT0hrcFkxNmxKZG52dWtKU3diSXV6aUFnV2M5?=
 =?utf-8?B?QkJoUUZ2NjI3UEpPU3FNVmhwWCsyNHkwYSt2S3RvOEswRmd4SU1CVzJWWkJ4?=
 =?utf-8?B?Yzl6bFlnNVhZdkYvdEo0SzNUOFJjMHRIZG1oRERvQ2p0NHZ5bjhINHEySHp6?=
 =?utf-8?B?SU9ubllJUjZZaU41SHVlTkF1QUVINENBN25hZWRDYytoc3pXRkJVbzVRb1lQ?=
 =?utf-8?B?ZzBRUHNDYTlPTE9yODVQdDZJS29ENThmM1FHcXkzWXVrTUhWOS9UR1NsL3VW?=
 =?utf-8?B?aUZpODFIUitsaHQ1MHROVVNLY0Vaa1NVaHpCUU10SC9mK0J0L2xmK0RZRWs2?=
 =?utf-8?B?QWU4U2R5NSt4ZXhyOUQzcFhFZFo3MG1hcHpzSjJNa1pLS2RBdkxjeFVuam1s?=
 =?utf-8?B?dk5IUzVzYXcvcDB2NGc0NGIrUU1GMVIvUGorRTJIVWFnSkxxQTRjcmdVam9K?=
 =?utf-8?B?dnY3UDByWWhReWdwSzRNQjNPTGo2alh0cGpmWnBnRVVFT1Z2U0t5VTYvbEgz?=
 =?utf-8?B?VFg5cmJ2cmNIVVJDeDlGZTlUcjVmcjBJWkZzeURPZ3dNUGJyMzZHOUx5dXpW?=
 =?utf-8?B?WnNHYkZXWkhhcHM1UmZndVkyaWdDNXRBTkZOVTJDNVU1Tml1M2ZYUWNSM2xx?=
 =?utf-8?B?TVRJZDZFZkhjTXQ2SnpaU3FCWHhrUStsSkQxVGxHYnd3L3JGVEkrdzQ3aXJG?=
 =?utf-8?B?aUw4dnlqdVRhUFY3cTBDcVlZVzhZMmI3ak5vUXVVcjh5QXU5NTc1WUtreitH?=
 =?utf-8?B?YjZGV0ErYzNyOWt5VFBQRUl6MkJuZ0xxai9WeEc1dU94VTRrUlhnWDkzM2tC?=
 =?utf-8?Q?wY/U=3D?=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255; CTRY:; LANG:en;
 SCL:1; SRV:; IPV:NLI; SFV:NSPM; H:PAVPR03MB9020.eurprd03.prod.outlook.com;
 PTR:; CAT:NONE; SFS:(13230040)(366016)(1800799024)(7416014)(376014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR03MB7218
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: bd3e86bf-7572-4320-86f8-08de5d01b4ea
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|14060799003|82310400026|1800799024|7416014|376014|35042699022|36860700013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YU0rMnU2T2dHZkJyOGU4d2FpUCtzdW9DU2ZTb3FORit4Mkx3RmpvYkNiWU9a?=
 =?utf-8?B?bU9BeUtqNWFCaVlWeG5QcTdvbkZTNHJUcVErTXkwNWE5dXFITEw0elM1Ykdv?=
 =?utf-8?B?aFpkeFIvM1BlTGlwQXRJMm5POGJkMmZxTm8vVm5qRlRFVnIrbnZ4VnhwaklR?=
 =?utf-8?B?MWdvMjNhc1g4ZFJDMUs4TnJkTGhZV1VLN3NrRHlSS2JGTHpOTU8xVUh1UlpK?=
 =?utf-8?B?TTBqTk85VnJoUUxuWUhnTFdqZWtsczRBaDNpNUlYc1o2TG8yZVZMYUVzSzhX?=
 =?utf-8?B?OUZ3aGFGeWVZaWE5akdFTXZaRllSV1ZMM3dlRGhCQmZSZHdIdnFpZ0IzMldN?=
 =?utf-8?B?aGtJL0NGdWFNcjBCLytOaGpFaFUzUVBRVHZwaHlpZDlpRFh0OUR0MGtiSFg1?=
 =?utf-8?B?aXBQQ2t0ZVRGK3RLdGIwSkZJOXkzN0dicHJuY25ZMDlZRWw3dGNtcGlmZnFk?=
 =?utf-8?B?cEs0N0M4Ry9Xb2JXZVFWNmV4c2pRSk83VzZ3aGZaVkxVcSs4cUZwc2I5YmRI?=
 =?utf-8?B?SkJOOW82ZVF5R3FrUjhJUHNxSk9pL0VmdkhVY3BzeUJWUGM2bE5NWW5RdFY0?=
 =?utf-8?B?MEY5Q3dYTFFwZzJueUorZldCRmJhY1R0QlVKL3FGRVBCb3MxRGtDMC9hd2I2?=
 =?utf-8?B?K0grcEV1UWRRcnpObTB3VDNmdG1DVnBVUUZnODBzdk9lT2VkQkFBNnVpamRD?=
 =?utf-8?B?cnBuRS9CbDB4dW1EYUQzYzhnS0NWWUp2TzFSWTVXUkZXMXJNcXF0V0UwUU15?=
 =?utf-8?B?dXJjb09rWkUyazVXeEF4VTVZY0hnZURPK1dJbTJzUEVXWThLUFZWaGZpQ29s?=
 =?utf-8?B?UG1VVnVEMEE2cDFLMDY0Rk9jU29jMFZYNWtwWXo0S1NZaFd0TFVHVG81N0NO?=
 =?utf-8?B?c05jbDFvN0NOS29POER0b0VpZzVKZUFCbjJyVCtBMVdWMmpmTmdhdk0ySy9S?=
 =?utf-8?B?clhBZXVpSzYvaS80cUcwOTJFZmlZVjQwS3R4ZE1XUWlHZFNsTC9jTmY5RjNC?=
 =?utf-8?B?KzJGSzBuVmRDM2dxeUE0ckpKd2lTZU4vWmNyMXFLWEdKTmRsaHZ0ekc2SkJt?=
 =?utf-8?B?bWJsemFZVDljTWZ1YUNtUWZUSVM1czhFL0JMei9WUytpOHozUlJIOVIyVnk3?=
 =?utf-8?B?cmg4cnMzd0h5NThJMnFmSk9jVkJrakU4MmZ6dUMzKzZ3Ry9IUmZGRHJweDRO?=
 =?utf-8?B?ckNQUWdYQ29RRE82SDJnYmQzUFhUVXN4eHhNVGM5THJWaFg3dFRpUTAwekF1?=
 =?utf-8?B?S0grTExYWm5WUkw3SHdYbFdrNnQ3Yjl4eW9iNjBucU9aZ2FRVE5ESllmNld0?=
 =?utf-8?B?VS9HekpZc1lGeDZyOUROakt4dzFyY09mU2dkYkpRVHd1Q20vbDl1dDEvMDZn?=
 =?utf-8?B?bHlnNU9zM3dLd05yc25YZWpGREh6T3lDa3hTRlA0R2RQUnBoVXNZMDI0V0NT?=
 =?utf-8?B?bmZ4THVEdFZ3b0pCc3VYM00rNEtua0Z4RXY2RHV5aFJCd1Y5QTdLeXgwdGxQ?=
 =?utf-8?B?b3VhN21ENzUzR1M4Y05uMm5qMkZOTWNaS3d1dG1kVFpZVTJ5Y0RhVlhreHVB?=
 =?utf-8?B?aFNEYWhDVG1VdUdPcTBPNWJjT1BBbHVaVUpQMUw0UVJscnhTSVlVTVBadDBa?=
 =?utf-8?B?R2QxcFFpcFBMM1lYMysxeG90eWE3MkRsMnI4U0VRVkpndzl2T1BIaTdLYTFF?=
 =?utf-8?B?UFlqbVd6dlE5ekxOYlNsK0ZSYlQ0Sm42M3JLY0RvYmgyeXB6aWszRTF5Tm5j?=
 =?utf-8?B?Nng5S0hNYjNoSVFNVXg4VVBndXl4dmJRdXBFL2lVaHM2Y2dGTWlHemJ4RXY4?=
 =?utf-8?B?a3JtU2ZaUG5KOXpUS29leEdOeENTbDE3NnpDVDV0VG1FUFVPaTF6WEh5ejh2?=
 =?utf-8?B?cjIyc2pjSXlpSmNzVXhaQXpRYjVSRWFrNDdOWjd5Y3diSDJpS2UvcGVOV3Rm?=
 =?utf-8?B?VTVDN2IyVzdpQVhadGtBdWhQQkpkR1BqVE0rTnV1azRUSEVYWTVsL2h3T1Bw?=
 =?utf-8?B?azRUWDNRRnNNMEVJU3k5VStQR1RGRUoxZXVNQVBCb1pWUW9kMUFqWW14RDNW?=
 =?utf-8?B?UXVoMDJ3UWh1Ky9selZSV3FPOEx1Q1pvSXhiSEJ5STJhZ3hJRUVOZy80eTRJ?=
 =?utf-8?B?SlhGa1A0Ujc3am5ZeERRcXBqR3VKai9hWVRrYVd0S2Y1eGUvRjVPcE1GQWhX?=
 =?utf-8?B?b05mK0FZY3FRTkVtNEdsT2RUNFFBSWZFWWRZYjA1OUE5ZjZQMWJCQjg4Y3VP?=
 =?utf-8?B?eWtmbnBLQkZETmliRlFOcnFWNVVBPT0=?=
X-Forefront-Antispam-Report: CIP:20.160.56.84; CTRY:NL; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:repost-eu.tmcas.trendmicro.com;
 PTR:repost-eu.tmcas.trendmicro.com; CAT:NONE;
 SFS:(13230040)(14060799003)(82310400026)(1800799024)(7416014)(376014)(35042699022)(36860700013);
 DIR:OUT; SFP:1102; 
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2026 17:38:50.6823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2564915-c398-4022-d05a-08de5d01c496
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=bebe97c3-6438-442e-ade3-ff17aa50e733; Ip=[20.160.56.84];
 Helo=[repost-eu.tmcas.trendmicro.com]
X-MS-Exchange-CrossTenant-AuthSource: DB3PEPF0000885E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR03MB10419
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

On 1/23/26 05:51, Marek Vasut wrote:
> On 1/23/26 11:40 AM, Anshul Dalal wrote:
>> Hi Marek,
>>
>> On Fri Jan 23, 2026 at 3:57 PM IST, Marek Vasut wrote:
>>> On 1/23/26 4:32 AM, Beleswar Prasad Padhi wrote:
>>>>
>>>> On 23/01/26 00:33, Marek Vasut wrote:
>>>>> On 1/22/26 6:45 PM, Tom Rini wrote:
>>>>>> On Thu, Jan 22, 2026 at 10:52:47PM +0530, Beleswar Padhi wrote:
>>>>>>
>>>>>>> When CONFIG_SPL_MULTI_DTB_FIT is enabled, multiple device trees are
>>>>>>> packed inside the multidtb.fit FIT image. While the individual DTBs
>>>>>>> and the FIT image start address are 8-byte aligned, the DTBs embedd=
ed
>>>>>>> within the FIT image are not guaranteed to maintain 8-byte alignmen=
t.
>>>>>>>
>>>>>>> This misalignment causes -FDT_ERR_ALIGNMENT failure in
>>>>>>> setup_multi_dtb_fit() when locating the next available DTB within t=
he
>>>>>>> FIT blob and setting gd->fdt_blob, because of the recent libfdt
>>>>>>> hardening since commit 0535e46d55d7 ("scripts/dtc: Update to upstre=
am
>>>>>>> version v1.7.2-35-g52f07dcca47c")
>>>>>>>
>>>>>>> The mkimage tool already supports enforcing this alignment via the =
-B
>>>>>>> option, but users would have to specify it explicitly. This change
>>>>>>> makes 8-byte alignment the default when using -b.
>>>>>>>
>>>>>>> Reported-by: Anshul Dalal <anshuld@ti.com>
>>>>>>> Closes: https://cas5-0-urlprotect.trendmicro.com:443/wis/clicktime/=
v1/query?url=3Dhttps%3a%2f%2flore.kernel.org%2fu%2dboot%2fDFJ950O0QM0D.380U=
0N16ZO19E%40ti.com&umid=3D003810bd-b0e0-4a71-9348-75ffbe5cbae5&rct=3D176916=
7692&auth=3Dd807158c60b7d2502abde8a2fc01f40662980862-3859cf23dac8d65722a0a9=
ed4c40c98c98a297de
>>>>>>> Fixes: 0535e46d55d7 ("scripts/dtc: Update to upstream version v1.7.=
2-35-g52f07dcca47c")
>>>>>>> Signed-off-by: Beleswar Padhi <b-padhi@ti.com>
>>>>>>
>>>>>> Tested-by: Tom Rini <trini@konsulko.com>
>>>>> Doesn't this enable 8-byte alignment for everything in case a DT is s=
pecified on mkimage command line ? That doesn't seem right ?
>>>>>
>>>>> If I do mkimage -f auto -b ...dtb ... , then I only want the DTB to b=
e 8-byte aligned, all the other blobs can be 4 byte aligned just fine .
>>>>
>>>>
>>>> All the mkimage flags are parsed at once and populated in the params
>>>> data structure in one shot in the code. There is no separation of code
>>>> specifically for generating a FIT for a DTB vs for anything else.
>>>
>>> That does not seem to be true ?
>>>
>>> $ git grep -p '\<bl_len\>' tools/
>>> tools/fit_image.c=3Dstatic int fit_extract_data(struct image_tool_param=
s
>>> *params, const char *fname)
>>> tools/fit_image.c:      align_size =3D params->bl_len ? params->bl_len =
: 4;
>>> ...
>>>
>>> So something like that may work ?
>>>
>>> "
>>> diff --git a/tools/fit_image.c b/tools/fit_image.c
>>> index 0306333141e..0c606ba4cc3 100644
>>> --- a/tools/fit_image.c
>>> +++ b/tools/fit_image.c
>>> @@ -642,9 +642,15 @@ static int fit_extract_data(struct
>>> image_tool_params *params, const char *fname)
>>>           for (node =3D fdt_first_subnode(fdt, images);
>>>                node >=3D 0;
>>>                node =3D fdt_next_subnode(fdt, node)) {
>>> -               const char *data;
>>> +               const char *data, *type;
>>>                   int len;
>>>
>>> +               if (align_size < 8) {
>>> +                       type =3D fdt_getprop(fdt, node, FIT_TYPE_PROP, =
&len);
>>> +                       if (type && !strcmp(type, "flat_dt"))
>>> +                               align_size =3D 8;
>>> +               }
>>> +
>>>                   data =3D fdt_getprop(fdt, node, FIT_DATA_PROP, &len);
>>>                   if (!data)
>>>                           continue;
>>> "
>>>
>>
>> I just ran a quick test with this diff and it seems to fix the issue for
>> us. If it's okay can we take the change as is.
> I think the strcmp needs to be some strncmp and check the 'len' too.
>
> Let's see what others think.

strcmp is fine when one of the strings is a constant

If type is shorter than "flat_dt" then there is no risk of overflow.

If type is longer than "flat_dt" then strcmp will return early when it
hits the nul-terminator of "flat_dt".

strncmp is unnecessarily verbose and creates an opportunity for misuse
if the wrong length is supplied. Whereas strcmp with a constant is
impossible to get wrong.

--Sean

[Embedded World 2026, SECO SpA]<https://www.messe-ticket.de/Nuernberg_SHOP/=
embeddedworld2026/Landing?code=3Dew26561753&returnUrl=3D%2FNuernberg_SHOP%2=
Fembeddedworld2026%2FProfile>
