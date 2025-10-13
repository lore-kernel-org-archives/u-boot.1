Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 353CECCA476
	for <u-boot@archiver.kernel.org>; Mon, 13 Oct 2025 04:19:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9A5C98391C;
	Mon, 13 Oct 2025 06:18:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="PBrDFBJO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5821083631; Mon, 13 Oct 2025 03:37:52 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c207::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7D21F836A4
 for <u-boot@lists.denx.de>; Mon, 13 Oct 2025 03:37:50 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=peng.fan@oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwdDTanjQRfB0Oo2jk3/TfHs63ArPXDL7PSyrpQur9nrwJW4MJLYeP0pPob8pZ+DEoYlMYUomquJGAcxJuH0k4wGg4+nTmRRnSVvV43kz6MF9zVQZSu+XX0aLtRP8ixPYkQaHnfB6rSsVSnu2KDdtyvIiqbTBz+dtzGtuWbsOx0IuKpRW1wq9Qj5A5rgr+BV0LBGg0JeLCJ6WMoy63SSaPeaG/YsSlqwqPakw3F7c5qZlboCsJHqT+j6g33fFYMnzzVGavFa8u480nskLPcatV09uYIIQOhN8snx1MSiXFkKggioI0n0kuoXQMc3NPKfmK7NzXSQITNj9Vfnx/IAeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zPmJOLb8hH4HNqNJs8/e0/o7CkOcmRnVNGavIcyJqsg=;
 b=UYdyiKgIeh3RttI3MAcyzPyimDaT12+YVA3ZB91NGYctgxMUJKe/W7SBkwZvE03cD/qoxhGFYolLBzzg2fa+Vm6oqa0+zeqvVwRm0Noqplj8H8T9J+/4HG4whbw8JbbYQ4zARmHC7cHrD0fz6ZmlBC4ivRd5IJXc8Nu3J48ZZ31mO8iX3p1wyaucVBXGZ8au8DwdpM8Fi0AkhTRfKD0Y1kyLR5RFS8GhO+Rna4ew3GT+QXziAptQq2OPWLiIQfLveEbkL+OqOV9FOc3Qf7w1dqnf71/lreU1/dV+yDsBW0gDYmYRDq1HW+AlDF5yEsKogzxrf1QhAeQVPNTr0547rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com; 
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zPmJOLb8hH4HNqNJs8/e0/o7CkOcmRnVNGavIcyJqsg=;
 b=PBrDFBJOMGukzpb8Ml9F4yBgFUqTJ12RCnUkwLfXfPhiEJ8VguaH9fobBxloQeCIDeX2KnAbB5KRlqGuF65Lkb5v/kQ17ITwHOL61vBEAnzwjssEKypRd75NWwsjgNg6icb1ZIEDN0FpodB7HQeNAuWyLvVJkK622qXRg2xZdwySOc57ShYSg2y8Ex3+5YqbZNMVItiy0UE8zNEHsAgFqv2jsLZrz+dDTx+FQPAxNA47s0z3CDPzFEYTgz3bUXZl3jMY8d1YsE9DY97NvS2Q2Gcbbvyhm925i7o0lKI2OFxfL00T0jJD9tc3P0xrQ10BVRFGQufgybO2MG9lbrs27A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by AM7PR04MB7077.eurprd04.prod.outlook.com (2603:10a6:20b:11c::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 01:37:48 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 01:37:48 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Mon, 13 Oct 2025 10:49:27 +0800
Subject: [PATCH 08/11] imx8mm: Enable remoteproc for i.MX8MM EVK
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-imx-rproc-v1-8-fb43a3fafcd0@nxp.com>
References: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
In-Reply-To: <20251013-imx-rproc-v1-0-fb43a3fafcd0@nxp.com>
To: u-boot@lists.denx.de, uboot-stm32@st-md-mailman.stormreply.com, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, 
 Fabio Estevam <festevam@gmail.com>, Stefano Babic <sbabic@nabladev.com>
Cc: Tom Rini <trini@konsulko.com>, Ye Li <ye.li@nxp.com>, 
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, 
 Patrick Delaunay <patrick.delaunay@foss.st.com>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Udit Kumar <u-kumar1@ti.com>, 
 Beleswar Padhi <b-padhi@ti.com>, Hari Nagalla <hnagalla@ti.com>, 
 Andrew Davis <afd@ti.com>, Judith Mendez <jm@ti.com>, 
 Ryan Eatmon <reatmon@ti.com>, Oliver Gaskell <Oliver.Gaskell@analog.com>, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: SG2PR04CA0202.apcprd04.prod.outlook.com
 (2603:1096:4:187::20) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|AM7PR04MB7077:EE_
X-MS-Office365-Filtering-Correlation-Id: 265ace70-5db1-4881-0861-08de09f91def
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|52116014|1800799024|366016|19092799006|376014|38350700014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?U3MydUpvdUROYzRzeHYxSjBJMTJSK1ppTEVFZ1kvTENrUXIrbS96RVBndkVi?=
 =?utf-8?B?RGZTbFBGVDBsdFVUdnd6TmY0T1JTQk1xbVl4Y21lcFN1R2Y5SGorZFgrYmNz?=
 =?utf-8?B?LzR5emdQa2IwOG9wYWR3S3ZYenVLbldOZW1JelBTR01jNGIwZEU4L1dmd3dZ?=
 =?utf-8?B?N0NVdTdtd0h3UjZmUUh0M0hUcmp3elFSd2ticEsybnlVd2xBVnhWNHN0SU5L?=
 =?utf-8?B?U3FvdlhJb0QxU2xIYkdBc1VIN2xPcE5MUXA2cUZPdXRSaG1xTm5wV01LZHJR?=
 =?utf-8?B?V0JjYUZBTS85SjB4VHlIOFY3bkhFOGMwODU0ejY4cHRKbjJVQ1BiRDJxWVR3?=
 =?utf-8?B?ekhaY3VsMUpoMGt2R0xCbTNVWmYxMWtaTTgrRyt3R0JLbGVkRVRVSEJVdDN6?=
 =?utf-8?B?dWhRaUdnTTZuWEx6aTBINkw4VkhCdHpwWUZZN0EvNVVtK08wdmZ3RzM0R2cy?=
 =?utf-8?B?enZwamZFMzJ4S0MzZmtOeUk0Nk0zT1Z0bDlqVE0xLzVWR29KTUx4a1hXVVds?=
 =?utf-8?B?OWpDVk5nMUtaL041dTFhbDRRNVp4d2RGdklFNHhxUjdjdjltQWt1OTA4OXVk?=
 =?utf-8?B?N0FuLzZ0bDZJUG43N2N1U0JJOXpBMGRJOHBORGtoeGhTU3FPb2ZDVGlEeitZ?=
 =?utf-8?B?dGVFZ3RGakR3Yy94cnNFaXF1NlY0UlBENWlUL3lBeS9QYmFLRlc1WEJNelVN?=
 =?utf-8?B?czhVRUU5ZmNrcWlrek11THltMGV3UHJzb0VleW0reHo3ZnhQeXFFN2NqSmp1?=
 =?utf-8?B?ME52R3F2SzBDczZLalJPU0dRRGlrcFNYUjM3Y0p1T293QTRtZTdxelNQM2U5?=
 =?utf-8?B?TlhoT2JTVDJqckRqQitoVDEzakhnVTVZenhBckpyblhWTWEvZHZSUldkRG53?=
 =?utf-8?B?RSt5czBhdVV6Ky9TQ1Q1cFgxOGthODdydGt3amlseGIxRHdPUk1OTndUSFhw?=
 =?utf-8?B?S2k4NTZwZldFN1A4b0JRN1U5TkljcSswd2VjZzJsbUMxdGhleEF0b3lvZ0x3?=
 =?utf-8?B?QndvTDFzM2RXTitWdUNyTkZjTVdIcGdpaVdFOUQ1bTBmNlp6cVpSa3FWZHFF?=
 =?utf-8?B?a3NqY1ZiVU13bERQclVVbnI2bGNMWEdIMzUzemZzZ1BwdnZKalF1c29STXpZ?=
 =?utf-8?B?Ulg1MVdsM1B6OVBZdlMzZUpyTWpBbFVDZG1kYS85M0dnUXVkRHBHZ3RXSlo1?=
 =?utf-8?B?VVlzNE1KQzRSM3kzMTRsdUtIV3ZQeXdGL1YyQ2FYQXdPOW5wYjFHK0VRWGhK?=
 =?utf-8?B?NXFSNUM2QndaT1paTUlJcTZESWZOVzJVWmV2TnEwbkVVa0FtOFBPTFhCSWM1?=
 =?utf-8?B?VlVNcU92THBwSDRVSTdha3doOEVOeVJXUXB5WjZQcmtpb1hHOGNoajhPQWlw?=
 =?utf-8?B?aTduZE04RENCS0tNajRvWldwVTI3Z1o4Yy9HNXFJVlNWVzRHTlVGWGl4dWEv?=
 =?utf-8?B?Tm5sS0h0Y3cremRlY3ZnZHRUNWlMWHhGWlkra090b21IV3MxeTVjank4dzgw?=
 =?utf-8?B?cnhQSnZSbEpMK2tHVnNYUDA2NlUxQUU2MkJ4eXVFMEp4MXg2WUhubTR5RGUx?=
 =?utf-8?B?UlpLdnd4b3hZV3hZQW1SaXZTeWlGZm5RWE8wemhxSzExQ2I4SEJXRnBycS9O?=
 =?utf-8?B?Y1dPcUZtUTdLR3hpYllhSHVFNm9TM29aeG92MmY4dzYzUmdMWkNWTzg3a3hS?=
 =?utf-8?B?bUpXRUVIZ2JKaVVjcDRvTGpuSC9mZ3RnYVE4RlV3WTV6cDRiVjlRemZOMUdh?=
 =?utf-8?B?WXdsZitkVHJkNXNWcUVwYlFLL256UG5uNC9OQnFOdWxFeEoyT0RWQ0YrVDh2?=
 =?utf-8?B?YWRvM0tqWkphM2svTnJ2Z1JEN2FvM3cxbTZ0T2U2UktpMzR3WDFOdG5XZzNy?=
 =?utf-8?B?R1RYdWNaMnFYWk9WVWxWNkFsM0RtdGRLUEh0UU9mZUNuUHg3emNuYTV4NldZ?=
 =?utf-8?B?WXJjeSs1SFRFSmNTcHpTT1E1V0E2bHpKNVhzY29FdVRpV3ZvZmtTRVFhc1li?=
 =?utf-8?B?OFY0L1Z1QVZYQ05FWit2YnQva3pLT3JHR0hWeTlOV2N1MnhTRWlaUnhiek1U?=
 =?utf-8?Q?zMVKJK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8459.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(52116014)(1800799024)(366016)(19092799006)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cm8wWkhjUnFmeElFQ2JFWSs0dmRRRFpFNG9KOGNEUmJabnpEMEZ1UUFlNk5M?=
 =?utf-8?B?RWcwYmxQK1JrSEFnT3JyNmZIQ1M4Y0RibHlzTXJhYWdXSlNCVlpmeGpZVllZ?=
 =?utf-8?B?ZFlzYjU2R0FoVkxXZ0M3ODFUc1ViRzFDOG9aSWVtNWUvcWovK0l1UkJlSmk3?=
 =?utf-8?B?Ymd4cjBPZE1HcytIekp4cnRCTUYrY2R5cUUyVVk4UVQ5czdBcFZpMm81YnVI?=
 =?utf-8?B?cDNFbklKRDRjNE9ZUTQyUUVDcWU0QTdJVTJVOE1JZDcxLzFGcmNFbElJWFNS?=
 =?utf-8?B?ODY4aGtMNG1VakhPblRBUml2NDBzbHBiVGROcEpUZk1ZMzdIVkhMYUxqdTdG?=
 =?utf-8?B?R2lOajNBUVowYkM5cWJTaVAzYUZQNTNFQ1VrbDAxaE1QeXNReTdnaEU5OTVQ?=
 =?utf-8?B?aTdlbE9sV3dDczgzWm1oMnlhckxwODN6WjF0NUtuWGZ6bHZmQ3pCVFJVRWFz?=
 =?utf-8?B?cVZjbHpWNCtqeFVwUUhvbXFSald3ZFBvUVpFa2VDV0t1U1RMWHEwSFF3TndG?=
 =?utf-8?B?bGU0a1ZtVVdjTTFlMGYxMVZtZUxQeTQ0RCtxWVUxeHV1ekpoVUk4V0t5R0Zr?=
 =?utf-8?B?R3FiZEY3b2hYMG9sU1dIeUJKcFlVaVl1dGF6SDNrcFE2MmN5aGZUTCtVZlhJ?=
 =?utf-8?B?MFhPdzRLR25qem91Z2dQQnZhY0loMUZFYmR1NldmTTdEeW94QkRtdmdvSVR6?=
 =?utf-8?B?alpEd01aZHYzYnhHWE5WQjZXUnExd1Y4OEYrR202UCs0UUxUZi9OYUNhWEh4?=
 =?utf-8?B?UEFNdWY2MGg5NjdJWnVCTVFZYUh3a3BEL2FMUUJaYmo2VWlUdVN5NmVQWS9T?=
 =?utf-8?B?OGZiYzloTUQzRTZlYktvMXdxRGVZTnQ5Zkt5VGVrWU44eWIzWGtDbXgrWjJ4?=
 =?utf-8?B?ODZWaENSTjZ4Wk9hcTdvSWxySEw4VGNYb0RmZS9WYXZlYUFEZDFzMmVkKzlC?=
 =?utf-8?B?R0VGeFFPaHVaRmtPcVVJMDZlT3B5WGZSemlicUhKbUEyRW00ZW0zU2tReHk1?=
 =?utf-8?B?cmxCTkdURlZVcFZxWFFJVlgvQjhTbElVR3BBZmg0RnJwVE1GdEhiOWM3ZGp2?=
 =?utf-8?B?SU8zN1dwZEhOQmlXQ3FNN0dmLzNnOElsb0U1enVqOHcraEZnb3l4dVdHTUtZ?=
 =?utf-8?B?VGxSQ3lkNmNXVWl6TVFNTktlM1I4VEQ2SkhtaHR2elVJdUU1MUtUUnppOExn?=
 =?utf-8?B?SElKV0VBcjVkS1ZGNVppVlkvV1Vqa3Rmc1NLYUZUbU9rTVk0bEVuWXhpSHRa?=
 =?utf-8?B?cWt2QVAwRUVucGZKN01hL1BNSkFJdnVaNWFvWEh2aFZPTXBaTnJuMDB1RlRD?=
 =?utf-8?B?UUhWWjdxRGhkSUU5SXRqdzJlUGFIMklXYzQ1ZWFyL285UHlnaUREZzdrQVBv?=
 =?utf-8?B?ZjFGUlJXem9NVVhJNmdvdDhRV2hBTis1VUtua1kyVER3cmlrTHRINFJzOXl0?=
 =?utf-8?B?eVd6aWR0RHJ3RGs1N1pqZHFJcXhMbmhHTko2Y1hYU2NMTDk5NmdXbjVGSFlC?=
 =?utf-8?B?TURmQW1UQUlZbzZvZXZINzJldjBWZzJ4aTVadXkrV1o3d0RXZEVob09RaEZN?=
 =?utf-8?B?bk93NnhPWlVEYVdTYmlmNTQ0MUVmZVVacTl0WVBqNGZuYlg1RXpPSXRhRTUy?=
 =?utf-8?B?cEhCQjNlcVBHbFZ4ZXZSZkdkSEg5OGl2V2tMMG5Cd3VUM2p1alFSVDU5QW9R?=
 =?utf-8?B?UE9rSEFqUExFcmdGYTFoaHRiUFVQTzBuQnBORzFwejd2VXA0NU03YjEvbGov?=
 =?utf-8?B?ZGgxMFpVd3dodmRFMUhYOEYzVXJ0M0s1WlpNV2NtVWdEUCtmVkxyVHZiVGlQ?=
 =?utf-8?B?elZEdFpybDJxUHVJTVJKQXdOMlhvcnJYMjArZkZEYWhRcXo5VnRRcmhpUkN6?=
 =?utf-8?B?ZnR2Uk9OU0ZGRG9GYlhiUEgrdWJXMzJMWjBReG9LK2xVTUM0V1Nud1BXc08v?=
 =?utf-8?B?WHl2QklEcGlCbjJUaFFDVStjMXhaajN5amVJWlJzWVZDWXRwLy9POTVWNXJ3?=
 =?utf-8?B?bVhrSU5MaVZ1V2J5ZnNSZ280QmY0OUdCTjFKTnMzVEJvYXFkZFRLUjljUXJ6?=
 =?utf-8?B?YzF2MW9WWkI4S0czTFFiTjY4cG8xaFkwbk9GcUlxY3hwZWc0cEw5WHN3d0Rn?=
 =?utf-8?Q?t9L3zXPosAaIdB1zEFDXBmBV+?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 265ace70-5db1-4881-0861-08de09f91def
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 01:37:48.8215 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aQG239XeVpVK6X4Sik8S/lDEaXsMt32Dk+q29h2KapDpAuhxbxvyLFsqIYorO6AnHO41bByINd+ergjxGUlheA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7077
X-Mailman-Approved-At: Mon, 13 Oct 2025 06:18:05 +0200
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

From: Peng Fan <peng.fan@nxp.com>

Select configs for remoteproc on i.MX8MM EVK boards

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm/mach-imx/imx8m/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-imx/imx8m/Kconfig b/arch/arm/mach-imx/imx8m/Kconfig
index 75d2772617d23f8145e7627723218c0c3944a1b6..35da05e93f5300ccbc77eeb3ad07050768900b94 100644
--- a/arch/arm/mach-imx/imx8m/Kconfig
+++ b/arch/arm/mach-imx/imx8m/Kconfig
@@ -95,6 +95,10 @@ config TARGET_IMX8MM_EVK
 	select FSL_CAAM
 	select ARCH_MISC_INIT
 	select SPL_CRYPTO if SPL
+	select CMD_REMOTEPROC
+	select REMOTEPROC_IMX
+	select REGMAP
+	select SYSCON
 	imply BOOTSTD_FULL
 	imply BOOTSTD_BOOTCOMMAND
 	imply OF_UPSTREAM

-- 
2.35.3

