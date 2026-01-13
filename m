Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28B6D29DE8
	for <u-boot@archiver.kernel.org>; Tue, 13 Jan 2026 08:44:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 16FB683655;
	Tue, 13 Jan 2026 09:43:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Mm6hkwm0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 68B4A83678; Tue, 13 Jan 2026 09:43:57 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazlp17011000f.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c100::f])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4FE4E830E4
 for <u-boot@lists.denx.de>; Tue, 13 Jan 2026 09:43:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yajeye4I3mKwQHtitp0BWFWeZfQ2GaTja0GtZz0+p4eOb9d2xEVwSGsf2JfqLxYAUtlZ8pf2i01qpTOBvq8lL+Y0f0PEmOWEEVow1290ifd9ZYv8G9vABhC1XmOxyNontz4Y2ZVyG2s2O7RneKzqgMUsf9rGrGKQJGuLafT4kIKyThw51hGOkhZpDat0H5Rf7ptcUeoVvxWwYkGZTfmLlXvuCbDuNpH3EbHZ6AKp5gszQ8hiGJGk4lUOo1qyAQihNjKep2xYcDT2rbEomdzJYl3TLjeOM9QSNtPXtLHToBnPrkH+TGy3OQ0Aq7mluzpcV0E8ZCLdGZmb7A/vHzYUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7E4UeInmbxVtxa/2cv5Hd84uXcarLBClXCDXpovR2M4=;
 b=hBSCCV5iChDyTTVmzWwFxtITbzm/l5cogo5BvNcoOR5ILursXdr6kgHn0FvXJkONQRGurKrbaLmkPD2OsVL5IzuF58K7gqRMSJzWVymlJ2en/UshQnNS0KJrepEMqYYilD23A5hGcyIbizdm4mXeigwyv+JO2KKobPd9Tsp+ELiMNT88RyCd9ZuAZETEkzZG8n9XgSJCPQc58tL3LgHZCqcMvyDJRUCOiVTvhNpwynwGv1ns3gtfFfiCluJtQz9bNs6YU8nSKz3yAaIhFjVgEysNSesEpMPCL2tOZu6+LY2wtSwmGxTHqhP+OdG0bxEmUBmoIy2luwQoXhetw2jUUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7E4UeInmbxVtxa/2cv5Hd84uXcarLBClXCDXpovR2M4=;
 b=Mm6hkwm0m8ZPtouMQYyBkDbwleLrfrjuzz1NScbHphgLF45OOZKsbtAubqbwDiVoQ75OqyBWJuZUNEQ773/03hLUY9fuozsxBqoOWX3QYFc/ktxb/G3b7os2mGxGqC5HrO+OKuszBirBqkaYFbm7MoRym3YsuGnbyGHKZpcuONU9Dxv7hR3cpZ6p/1azciwqdaJkeiLfNhYuKM1XnHFMBq6Q9SWQWULxHyCOneV1ZB9FsocWrefE8AlpIop6VgWZVZM/nVdegYAvJvlUAQrBhK/As8LnaqmlgIMlsHYUu/7Dy6+/DNgGN5rD+2FVOpU60GcxmAuTjQtCiJQwNlTUpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by BY5PR03MB4950.namprd03.prod.outlook.com (2603:10b6:a03:1e1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 08:43:52 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::efa9:4b97:3b4a:8235%6]) with mapi id 15.20.9520.003; Tue, 13 Jan 2026
 08:43:52 +0000
Message-ID: <b8c2e5e7-b170-4aaf-9b22-a2022c7f114c@altera.com>
Date: Tue, 13 Jan 2026 16:43:44 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Add CoreCourse socfpga Board - AC501
To: Sune Brian <briansune@gmail.com>, u-boot@lists.denx.de,
 Tien Fong Chee <tien.fong.chee@altera.com>
Cc: Tom Rini <trini@konsulko.com>
References: <20251229153354.5558-1-briansune@gmail.com>
 <20251229153354.5558-2-briansune@gmail.com>
 <CAN7C2SC43GUgfgcv=-zq3R5RxRRbwYWL_kmgeRPi-thtHUC5bw@mail.gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <CAN7C2SC43GUgfgcv=-zq3R5RxRRbwYWL_kmgeRPi-thtHUC5bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0024.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::13) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|BY5PR03MB4950:EE_
X-MS-Office365-Filtering-Correlation-Id: e2e3db35-e8ba-43a4-ff98-08de527fe0a1
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yy9DV3VOYkJSTzNOM2NrOTdRcVpMellPOU96Tm9mYXoxNlBHMUF0UERkS2Fh?=
 =?utf-8?B?ZFk3cXpBdnhITmZLM002Q1c3emNyT1VHbE5iMzllMW5mSTlaeFdjSVAwWWtW?=
 =?utf-8?B?bUlPaDM1czJTc1BRZUN0U0RUbUVTbkhYSlREa3QxeWZzQ2s5QmF0ek9pdUky?=
 =?utf-8?B?TWJrQjZlNWc0TUpMY3lhTWlzbG9ZUndWM2hzWnlIaUNQM1pCM3ZxdlNrT0N5?=
 =?utf-8?B?UmtrK3FLOFlDNVFvZXJibkpUNkJvUXBSb1VzRkVmNC9qY29RNllkTld6b1oy?=
 =?utf-8?B?Ty85MzdQdm5PSkk5dC9vcDFkZXJxNit0Mll4aDI3NmEvTzJReGV1OEtjemRv?=
 =?utf-8?B?bWkrWkUzRWhiU01UbllEWTJVZlhRWnpSQUp5M0owY0NFbjJodGxoZW1SaXNG?=
 =?utf-8?B?N0tzTDcwa2dIQ2I3VHJ6WVdLUGZxRXAzOEg0bHJvSG5MbjBycUNuVFBpcGJv?=
 =?utf-8?B?RUVBc1NHK3lVdHo5Z2x1Z0R3UGZMN3dGVmpoZFcrbjA1UXlncWoxM0VPczln?=
 =?utf-8?B?V05icFR0Z3hqNVBZZlArR3VITkI0cXhPQUNEcnZKelU3RnI4eHFibXBXeUZy?=
 =?utf-8?B?T1Q4VGI5SkhDZUNXS0JxYlZaZ2lhYk5BZ2ZENnVFMTc1eFdYeUxuODIwN09P?=
 =?utf-8?B?a21hU3FwSEpXV045a09KWDdNNitCYXZRVWRKT1JVSUZWcjYvZUNHaHY2UmZD?=
 =?utf-8?B?bER4VGpXUmJQcjMrdVJCc2o0VFRVQXlqc3BrZ2FJQlZ2a0JkZ2N5V1ZVSDdP?=
 =?utf-8?B?empvbGFwWXZ6eFNYbmJzSUlEMUxJTDhKZEhpYkNBQitJT05vdUJRMTNqNklB?=
 =?utf-8?B?eTV4Sy9ML0VRbUNqNzh4OEVBbi8yYzVXZmllTU0veWcvbjUxM2JzQU1tZVla?=
 =?utf-8?B?NGYvK3hkbDl6a09GRjNhSzhIK0RxdWl2RndSSUZmWXdYVGhCMTdhNllvRTkw?=
 =?utf-8?B?TFlXL0NWcXF2WGczSk5Cbkp5YUJWZXFlck8vY2haVHh4VkhNd1ZSMEN2N0s0?=
 =?utf-8?B?QWMyNEdvWWd2S2FYRG1EQXp0dmUrQi9BWVlTRVAxdmhtb1B0WU1uc3QvbFd3?=
 =?utf-8?B?MjlsdlRLNjlrd3JncHpDK2o3Qk5aT1NnV2s4M1hCUVkxQUhjTVVidjBRQmp2?=
 =?utf-8?B?ZnB4VExJVHZzcWZYM1FlY0xBUTlaeHZhemoxNnBRRXVtellDMnJmbEVzK2VU?=
 =?utf-8?B?OU94dGk0RzJVcThIN0V1N0lPYTBrLzBRNm9Wamp3NnFaeG9OVTZpTU1ha1pr?=
 =?utf-8?B?cnlNYWMxOHFhZzIxT1VJV09ha1lRQ0h5cUdXYXRhVFpNekV0elo1VXNJZmJq?=
 =?utf-8?B?TXdTcTcvM2VUTnR0WjhVcnFyTUZQVFo2czUrcUhIUFZsc3RyVnRheVIxRVdN?=
 =?utf-8?B?QmFTY2QxKzREVFJKOVluWHpJcUV6SytjMitTcU9Rd3ZKU0x3dHJVa2pnb0Rz?=
 =?utf-8?B?M3QzZ1pMaW9HT3djZ25haW1VVklSM09tVWFVcHYzTzZldnF2V2xMUlp2dDJC?=
 =?utf-8?B?bzZjMFlnN09uSHdRdmdmNHJTWUx2KzRTMFNPVGpuRDFIYzRTVHNjVGRPNjF1?=
 =?utf-8?B?SEg4ZUNhdk41a1hLa2dmejYvc0pWSVkyRFVRT3FPSDJMak9WRG5uTnRDODFS?=
 =?utf-8?B?UGFoOVo3ak5JRE1kblAyTjZpelRRTWJ1dzY1S1FaemVHQmx4ZVl3YWE3dzNi?=
 =?utf-8?B?WXc4SG95ZXZEakpXSEs3QTkySk1qOTRtUHd1Mzc5emZFZ1U2Q09waUpkNDk4?=
 =?utf-8?B?TUpYSDRJa093cFFtUnlEQlRPZHlKazc3ZW5aT3l4QmVER3Q0VkRBckZSUzFZ?=
 =?utf-8?B?VFpXL2k0MVlGUTRLa2NpOFdjMytGS3ZyTzVnQ2ZzZExuY000bHdCQ3pyVmN0?=
 =?utf-8?B?LzNsdWJrMjBKK1lpTVluemE2eWtJVzREeGNjZUhVMXZUT0xhcWJVZFdET0o1?=
 =?utf-8?Q?IeHSjEs/5Nw6mv5G3lXHWBD5o6z856/t?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUZqc1hVZTFocWM1bzR3TTJ0a2MxWm9DOXErbE1RNVlYUi9UMjhJdGlBeXpz?=
 =?utf-8?B?RGRjOGczVmtKRllJQkJHWFZhaDV3cHMwYjZqd2FMWHNObXlaaEIybHFlUGVI?=
 =?utf-8?B?RVBobXJJRzE1OUYwVE1XYnJYNDE1WFRLTlZyMkg5a29tdmMyZld0QUhNYnJm?=
 =?utf-8?B?TGc0RWFySW9MbHdXL3JETkgxNG9XWEM2SDl5a2pvMkF6Vm9GektMdWJ2RjBt?=
 =?utf-8?B?WGJ1YndVRHo5UXNCbXVYckxaeSs4aGZIZk5DWnQxcDd2ekRaZUJWbjdaM0RF?=
 =?utf-8?B?VW1wQTlZeFI3TXF4ZGNvcU8zbnYrN25YcnNPVUUxZDZENFhsclM0U29mc2Zn?=
 =?utf-8?B?NGV2c3hTeUVzV09TdFdta1dxTkR0NGxHZEowSmREdHFWRTRaZkZtNXNObTdn?=
 =?utf-8?B?UHhPUm5XZENQS09nL2VwRUNlTTIvTXBSTU9oNUszekM4ZjJJemVnRTdiYS9C?=
 =?utf-8?B?YzFSbzNUVTYxNk9VN1I5Qnd6RmtuSngrMkxsUmxsdlhseEtWN0k5VHRnN1Zv?=
 =?utf-8?B?K2lITWZPWnptZDVwWlVCZEdSNjV6SWkyb1h4ODhsVkZGNGpod09ncnpxVllh?=
 =?utf-8?B?VHEyWW5vdzJ6Q3VOQmpQeFRVSmp1OEdJNGRSRXBoSmMrNmdQRkIrQ3RyMGZO?=
 =?utf-8?B?UFBLd2h2WDJKTDFOV3ZWa240T2szZllGUm9tcU9VZVRieFJLYlNYSExzRWlX?=
 =?utf-8?B?c1Bsek8reVJUYVFrbDZlbkFIRExOQUhaZDlIUW9tQjZLeG9mMVEwellOM2Y1?=
 =?utf-8?B?czR4Z29ZV3YzTzF3NlBXQWlWdVBnb0RPMStnODQxYmpTTmxxS1pTUkJuZmxU?=
 =?utf-8?B?NmpPK0pRUjdEOCtrbFRPaTVHUDQ1U3Z5YUNMQlcvdTZtMkwzVGRHUDVpQmtu?=
 =?utf-8?B?RW5Nekh2c3BwdXFXWGZNbzJHU0RLZDRNSlA4Ynp1ODZyRHlMaXZETFVlazRx?=
 =?utf-8?B?WldNUTUra05GckZETUQ0UVNCeFoxdTR1eXkrY0JsMFdJVEFBUmdhL3hNcW5y?=
 =?utf-8?B?MURDRW5SOFRuOG96d0VmdWtHUGU1VDBtTzdCUmVSTUVYaWx4TDRQeG1BSGUz?=
 =?utf-8?B?ZmdwM1VaK2hxcTFuSWREMzI1MXBVZlZhemlocEpOV3MybzRRT3YrdUlRcDJ2?=
 =?utf-8?B?UFB4a0xadStXVUkzR1ZXVk9oVy95YlhseWpzZ3B1SzFmSEwvQ1lWYTAzRnFr?=
 =?utf-8?B?RFNZQzZUWUNmdUFtdFFkcVduSUl0OE9wSWJwMmVVZWhjUjRRNy9GWnBOL3Uw?=
 =?utf-8?B?YmN6Rm9nejgxVjJKckdOYUtwaWo0VmdJdllUeUk0cnZTUmkrbW9ITlFYdDJy?=
 =?utf-8?B?K0RvSGY5ZUwrbnlSTHFGaXpIS0psYjNSTWUwN2N6dXRXNmN5ZUt2MkVIOUY3?=
 =?utf-8?B?ZmgxRHhmMW1JaGpZbnZYRjVhZXdYZGlmVGJFOFhXdllyYmhRUTVZdVZOZ1Rh?=
 =?utf-8?B?YUpkdnJacTZtczRvQS9OL0xTbGd3MEptSUdtK2djaVFic3p2RVlGSUtvQitR?=
 =?utf-8?B?Z2s0bkpSenRQbjBiUFNkOE9qbzdRMjI5YzVlVXpIczhZajArb1RMN3NNdURM?=
 =?utf-8?B?L0Eyd2F4cmtsZlIzSGdEUmpBNzFpcGZZM3lwTkFzL1oxUUtHaVYyRnVsZkJG?=
 =?utf-8?B?K0kzbjJaZytyWFpCQnhELzR5WndEdUxHK3RFN0VXVHRaZERQRnhGa0FqZllH?=
 =?utf-8?B?aXJuRVBkWTRacmpBUTRiZ0tRTzNkV29nV05ySGVYS1RGOTlYTStzTjFob1FS?=
 =?utf-8?B?N3ZnZzM2czJKSE5SRTZKaVBSVER3RGUxQTZabmdkWUszeDJ1MWEzK0dvZnVp?=
 =?utf-8?B?ajRpV0JDbEdQdDE2OFBEMUUvN3VvSWRuTDNaTWJqM3F5bWt4T3pVWmRNeXpG?=
 =?utf-8?B?dTdqWHNzQVNlVnhPTk5Yb2VjWXNlZDJKelZjaHFjbGNlZll4UEp2eG1mMFdO?=
 =?utf-8?B?aDl4Tmo3cGJSc1lRVnFqRG5RTXlqU2VrTmZMZ1E4TGkrdk1KNkJuMG5zd1dC?=
 =?utf-8?B?eTBBT3lJcTlRMnR6MThpZnFtbmRQN0NOSTVQMW5SOWV4TXMrZzlCdVRtdXVU?=
 =?utf-8?B?L29PaGVSL2toS054cUszTVUxZklhT1MyWURpZ2tOQnNxbFZrMnZUbFluOXZm?=
 =?utf-8?B?YVlkMFRaZmR5VkNzUTFKRTRlVGZBRHdrS3lLamordHc2TjVQQnNyWlZENFk1?=
 =?utf-8?B?aVV5OEVtdlRkUkRFMmtSWndCOC9QYzNFS1hpYTlBbXowc3ZEWkxoWlYxQjFq?=
 =?utf-8?B?bjZmK2htUDZWQS8vM1pwTHZzTlAxOTBucTlLZEpmNWE5UzJBV09RVlpVN1B4?=
 =?utf-8?B?RFhZQ0RtbmUwMnRCTCs5L3RHcmZ0SmxnSjVKb3BDS1BkblZOZjlCYUNIdVVV?=
 =?utf-8?Q?1i1lnjYZ+tS6/Pz0=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2e3db35-e8ba-43a4-ff98-08de527fe0a1
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 08:43:52.0386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WES3J9d2AawMc97bLHpTyozfwnIEqfOfEKW3eH3kv3tG/Cie/jb4U0ZLm/dFdukyUL7kO/yk/haLHO4l3YfzHgDLoIPthIWtUN3KIIzE+QQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB4950
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

Hi Brian,

On 13/1/2026 2:35 pm, Sune Brian wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> Hi T.F.,
>
> Any issue on the new board patches?
> Please review and push to the mainstream if possible.

Thanks for the reminder.

I’ve just returned from a long holiday and am currently working through 
a fairly large backlog, so reviews are taking a bit longer than usual. I 
haven’t had a chance to look at the patches yet.

That said, I do intend to get back on track and will try my best to 
review these as soon as I clear the higher-priority items. I’ll follow 
up once I’ve had a chance to go through the series.

Thanks for your patience.

Best regards,

Tien Fong

