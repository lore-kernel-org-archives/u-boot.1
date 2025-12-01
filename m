Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB080CFD376
	for <u-boot@archiver.kernel.org>; Mon,  1 Dec 2025 03:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 664FE83A26;
	Mon,  1 Dec 2025 04:07:51 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="JtQ8zPlZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5B09483935; Mon,  1 Dec 2025 04:07:50 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazlp170120001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c10d::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27DC383935
 for <u-boot@lists.denx.de>; Mon,  1 Dec 2025 04:07:48 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTmoYMG1glysmPU0Ub5CnUa2k0lidnncaBgaU9FXy00E0VbxPIZrOSiWMjFKHOYXCln4xYBN3ZYeBABv7HL/bC5TPvlep+WvC/t9VOPig1e8ZdAVLVWp+E8Z6O/bjlSqa++SPhazlgvFIO67EAzKYkBnlxHanZivXrbfFDmX+9XBUxzaJDtQ82stbllWCVLgEkP543dONspi4tEhCdv2KRihe3xWYbxSqfXRlbX1KhYkcZLKjAjuVjz2OeO93dQ/nPrXm/xDMletjBrWRWnCZkYiaMpbxzQv1PS3bMtwYPjlnOj6X4X1b/mhmqnLl+LrhW6CYSacNDDrxEIZtNSLww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BcmnWapYkw/rmtgNJy/azkLIfJtqmosGOLtwuFDKBUI=;
 b=EFeQ/eY0+9gvZu12rA9XC4UxlOUGPl4p2zCgLe2tT8PyRXmNEReoq5BDu/C4u4vhGlDluNFsSjR5xitgNc5vgF5x3WK3HIcQvH0uNe0H3G7MqigUIQb8OYToOfzG2tQy5UXQ7lclswpZqFsMs5ETFmaoJRfYdqmxaKcWPqFiXlolRk0p7h4kmh14Wk3XfrASE1bkyUjuG++DFo0QV2Xpx0mDJj8HL5i8mP+fsk2SkDwBq2rQ9+jZFxKKdskMw+bOCtt+CMaojPxfiPSjKrEneS7AFQ+MM62++OORQeZiKfFJDrFXGg6tYAUe2bEASw/OUMWQi54+MMxousZWOZMCRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BcmnWapYkw/rmtgNJy/azkLIfJtqmosGOLtwuFDKBUI=;
 b=JtQ8zPlZMQ6LUkcXXXo7FAyQ32sR87wOziawbvDcT1Va0rvxAhYZEjKdaCf1L5koH9Tlq6rAgJpZP4A4G+KfW288BmScoWDD1gCihenuHOPCP83+ixZrQVny645bbxjiCD2nFOHSvD+6jNlwKRRC2k1Pym6SGIZ3EYuuN1gx542D7sWMUz+K/Z740nGplHv+XYUDnwtTz+4ZK13303DtGKsZRF0r5A6+GUGiCHAP5jjzUIiSCvqrcyISTEv3QPN/xj5BuRtXbPB/11HKt/1PS/Yuv3JdVG1uRoP8FnxE7UUsZncJVJuidQqub74FXf1LzzbktDrLb3z8hu9wonYozQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 03:07:46 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.012; Mon, 1 Dec 2025
 03:07:45 +0000
Message-ID: <3310c44d-28fa-4d88-91f6-3e5a64087569@altera.com>
Date: Mon, 1 Dec 2025 11:07:38 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 4/8] mmc: socfpga_dw_mmc: Restore legacy clkmgr address
 retrieval
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-5-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251125081316.17329-5-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0144.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::24) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|SA5PR03MB8377:EE_
X-MS-Office365-Filtering-Correlation-Id: 01a274e4-80d0-4a36-87b3-08de3086ccf4
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RWR1dUFUUWl5dFVScENOSXpNdDE2Yk12QWovdTFSa1g0cGR6WnZ4UldiUFBo?=
 =?utf-8?B?bTVOT0lNUmtHK3hSd2I5QkJNak50UThBamRDcFhCaEhXcWhmaGtjekswczJq?=
 =?utf-8?B?dS9zL2IwdkhIU2luYm1Ld3Y3ZEFhdTZFRWlVNUF5dXd3NWVlaWdEVkxSay9W?=
 =?utf-8?B?NUQwOTJJT3JxR1h2d2s0YXRPVTFXcjRHNFlwWHZvTDJhLzE0QXJueW8zS2FC?=
 =?utf-8?B?UnREdXIyUkRpYXJsSXBOSksxTkQ4RXRWUFl0eEFRdkpueUd5cjZZWXNiZlNG?=
 =?utf-8?B?aitqd2ttZE13N1craUoxcmxIUGxwVG1YZUs0NEVCZmp1TEFEelU5MU9TeDZp?=
 =?utf-8?B?UG1zNEdkSXAraHRWWC8rSGJiekt6SDlkZC9jWTlXZ2dqZnZKKzdmL2VxTlVj?=
 =?utf-8?B?TkJYVkdwSkx4azR5MjEvRGhUeFVraW9NWDZzRjlyMC9ydnZxRCtxZS9YVkRj?=
 =?utf-8?B?TjlBTGdzSzJpWHlYbXhWOCtpQm1KSmh5Q1JMNGE2RXdtLzFPV29DaGdZdTcw?=
 =?utf-8?B?YVVyRzlGTEQreFpncWdFb1hGSFZqenordzB0Z05DU1FQbkNVT0F2WVhWVk9x?=
 =?utf-8?B?bm1Ic0dSaHI3TTAvSkIrTjVyRHQ2RG1QNlN4UUt1UmxLS3JGd3JOL09SV0J4?=
 =?utf-8?B?bDg1QkEwcnh0K1ZoMjMvTWc0eWFNQURheUVncFhpYkxwV0Ftb21jd1FLNWgr?=
 =?utf-8?B?K094MlhRcVJlRDl6cnZrUFltTDBRMGp5WkZLcktQYmxuRS9pKzJEOWRVM1JB?=
 =?utf-8?B?MzZlaFdmTFYycFNYd3lLYUlMM3ppSWNSUWNnNlFUN2pWbEp5MVFaUFUyRERS?=
 =?utf-8?B?L1NKK1QzY0p5U1ZWU1htWHcyRHZ0cnVyV0xHUnNnaUdDSlEwSGZWeEFROWlz?=
 =?utf-8?B?VGtFbjB2b0NxRlZuTkRDajlBKzI2SGZGSnpEZDZoNjlOME4yamRvNlpzeXRt?=
 =?utf-8?B?L2lqYWtpN0JTV05ZbE9HWU5pT1ZlYTBRY05YM0JRdTBFazZnR01CNG03NVUr?=
 =?utf-8?B?RXo3SDZqT05oYk1ZV0FENDRRbWMzTmxQeFZlcmNwNW41dWpPVXFSZ0djaEhH?=
 =?utf-8?B?dGRTQStWSUhlTHZpa1h1K1BzdVFGUjNzcU9JeDQyV3ZzSzFHMjdCZitlc0FU?=
 =?utf-8?B?bUtMQjYxR0RuVHNjZXhocjJjUXNCZ1hZSUFGR09qa2pJdzNZbkR6Z0J6VWNT?=
 =?utf-8?B?NStpRkJlVkd2aFhwL3l2QkZDM091YTM2Y3R3YlFNUXhyci8rVGdiOE1LZXpD?=
 =?utf-8?B?S0JmbzVQTzNjaldQb0tHMjNqdGM2NE04dEovWkFpV1RkZzFoOXA4QVNObUZI?=
 =?utf-8?B?ZlhpTVdXbWxxaWwrOW55N3BxTjZtWSs4a05zSU80cFRyQUV3aTVMRUhaa29P?=
 =?utf-8?B?bzcxbTNITHF5R3dnMzFkRUJoWFpkRDRWVitPVTBRRVZjem45TTJXN3plMEky?=
 =?utf-8?B?Tk84ZkxlN01jTXpxNWR0U2RnbURTdWIwVmtpT1FPSzlWd3UvL1FMUXNMVXQx?=
 =?utf-8?B?WVRPeFpZVG0xeXIyUVBzclpFU21oZU81R1ZocSt5eWlCTWlySDF0ODloSHBs?=
 =?utf-8?B?bUxQREpSK0dlZGlHaitVVlk1eUxwOWJ6Uk8wcktIc3JTbi8vV21MODVuZjhx?=
 =?utf-8?B?NEhzbkRTQmFWMWhSTDdwcWRUUitNNUFZdVNmR255QkI5T0pTWHVOQ3h6bGJq?=
 =?utf-8?B?UStHOS8vQ3hiK0tsVmtTSGpUbEtiYStKalhUaGM0U1lza0ZsZ3liYWJETHhW?=
 =?utf-8?B?WXg3N3FnVzlQME4zT2RPUEpVVFJ5eFEreno4YnZlaFpVSXo3Z1l4VHNTU2F3?=
 =?utf-8?B?QVV3Z21qM0JBU0hWQ2xnT296U3llZ2d1SElSNjdmSk9HamlZeXErTUlJdmFo?=
 =?utf-8?B?cHltZkpZbGE1N0xubUo3Yi9iOGZ3ZmJQQXFINUg1VmJ5VGFsZlBJajNkZ1FS?=
 =?utf-8?Q?vE9Hge2kF7CCYVH1OmQ7nb7OkwLSY5pJ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1Vqb2gvT1cxc0NnWjhZVFRmYzgzRDJ4eDJHM29Tc1lqbmJTSzhsMmdQajh5?=
 =?utf-8?B?MVRjRUlUMzV0K0tNUW9xZjFOSG1MeFlRbWF1alE2ZU5qL1dVb3J6b0lmcU1p?=
 =?utf-8?B?eHhuNWVrdjdHeDRiMi9wZm1tUVBOWUxLek4xZmJYZ1h6dHAwV3RVVUtFNGRi?=
 =?utf-8?B?ZzlXajRDZkxYVjFLTEhCZjF3UGFzQVM1eXRaUUFjRFNtREdoVitLUFVNNU1u?=
 =?utf-8?B?WHBLeWlzQVlWcURIRE9GNStPcXFZem9vdHE2SGwvdllEeTBmSCtUSnVHU3lu?=
 =?utf-8?B?S3lMVFZwWUlRdzNwNmZ0YnNMUEt4dTBONm9MRzFVSXgrazdjRE1tc2F0QThZ?=
 =?utf-8?B?RVRDaUFUcTQydithcmowNlJ0Z3hoazhORVo4RVVjL0Vuc3FoSkMxVEl0T1BI?=
 =?utf-8?B?QmhiTXlCK3ZUeGZmUG56aWVrN1h4dmJGaDlrN0I0WjZSenJwY25tajRhQVBJ?=
 =?utf-8?B?eWVMOG14N2k1dEp4OE9wQUxNeEFxTk51SVc0V0lUQ21MbitPZTNoSnR5VFdF?=
 =?utf-8?B?Qis4cHZvZW5sd2JYSWs3Q2dPU3l3dVNHbG9yZFIxektFaEgwUEFXWlJqeGJZ?=
 =?utf-8?B?b2JEVnVZWFMvQ0dCZENwL0tJRHpwSmpULzFTTmcyVGIxWks3UG4xelNnSys1?=
 =?utf-8?B?RzJ3R2x1UU5ubVExd0EwMi9mRkdDUUhIMzEvOE9hUDJZYXhSbzgrTU5JWml3?=
 =?utf-8?B?RFJ1RlNGTVBNUlV4K2ttZTZTaVJvT2I4TjlTeTdFa08zd2V5KzNyYVVDMnFw?=
 =?utf-8?B?MkNDZlgva1preTN0TFRkZFc2SFNpLzN3QTNZTGZOU1VqSC8rUFpSYzRhUkhu?=
 =?utf-8?B?SHBrNTd4ckVnVTdXMWtSQnlLbFJRZ0RwRnpNanNXdHpLbzJaZjUrbFBkZk1k?=
 =?utf-8?B?NEhmTGkwZmNRVnoxeTZsQ20vbHJxVkJRdUlkbXpLblhCV29rRzRISmwyczV0?=
 =?utf-8?B?akcyalZxV0ExWjJsa1l0VTBnT282WkZVTHdWdlhYZXlmbVA3SVR0cWVKQ0NX?=
 =?utf-8?B?TjFRT3VxTE5UV2VUazNlVXNyd2RQdEVlYUZ4U1pzZTl4RWs4RE5mV1BKR1hI?=
 =?utf-8?B?RzZhcDlrbTA2aTZJc01ucm51czNGck44TkJTTXBXYzJZcHdWRitiYlRzNTJy?=
 =?utf-8?B?UHNNcUhBOVJpZWc5clZ2Ni9xMENTRjFSb2U3ektUV2FjeVhLNVJMaktSZFFy?=
 =?utf-8?B?aHNzZ3B6Y2VhNThFc2xKcTBLOEVFdlFoTlFMOHVUQ2R2ZHgxd05XSFVyVkJt?=
 =?utf-8?B?R1dsQ3NYZUQxVW83V2Ewc2ZVNlF1MTVBWjdHRFZ3aVFEZ1F4RENBa1E4aFdT?=
 =?utf-8?B?dENJME8xdWNtU3Bya0UzdEdPbW1CSlFpS05BU01NdDE3bTNNcjRMTFF1UGtP?=
 =?utf-8?B?SzNFclQ3dk1pWWRabGlndVNlNkh6OEtpR0NnSTNueDVHbTZDbjJ1QVpLMkRS?=
 =?utf-8?B?bENQNjhQNzF1R09lUHppK3Njc2w5cHRYRnhIQytJMjR4Mm9BYStNenNtSmRi?=
 =?utf-8?B?d0hEK0R5SmpVNmU3UHhya1FqS3BCcXArdERwV2NVTVdiM1hVN2IzUFB5czhU?=
 =?utf-8?B?MGN2TzYzcCt2RkFkaDRJOStuRGlLVFU1V0U4YkZaYS8rc2FBWExuWTYwazhj?=
 =?utf-8?B?dVBSRjRRTldlSzZtSWFRTi9sbTFpVHhDWWVMSmkydGR5bHUyMzR4N1htSWt0?=
 =?utf-8?B?UHo1VVpGMkZGQWxIU1RnRmRzWlJCR2dHdjVSTEdTTlN0UG5teTF3QlNPQnp4?=
 =?utf-8?B?eHBoOENwWkN5V0x1UmVYaytEOXdueE9aSUhUclgwU0tGVEVBSmFvZDMvaUVR?=
 =?utf-8?B?c0xrd0VSeHJjaExJaEhobDg3eW9OUUdpM21hdWpqN2FKSWZIbVp1djZGYWRR?=
 =?utf-8?B?S2FjWno4MHdzeWtLM1B1Um9xNEZ5NC9lSnFrOEVUQitDUEJWK2dJeWcySWJS?=
 =?utf-8?B?QUljcVdMOVYxME9DVmF1NmorRldzYXIxV1FTMWthWm0rV3N5dDJ3MEJVK2xJ?=
 =?utf-8?B?empVaXdJcjZwendhb3F4K1o1Y2U5UHdzYTAvTVpXMnMzYUhSdWNyQlNkWmxp?=
 =?utf-8?B?R3VqK2dmc2lHL2dMVTMzZlRmb21wLzVob1pHbUJicEZrenJ1a3RDa2R4ZnpD?=
 =?utf-8?B?a095N1MzODMrbGZQcWVaWnU2Zk1ZVUpRV2hUdXowQlJHM0YrZVN0NFZPMkFI?=
 =?utf-8?B?Tmc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01a274e4-80d0-4a36-87b3-08de3086ccf4
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 03:07:45.9335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q2AsTWUQ7KjHiLftuYspWprAG/7OjSLATBaa9lgH/vKNxHoX2JP/SoXFwpWcMP+/+99Qc7DjXjW8/PVxmSyXgEhgM9ExVx5IjAxLsCjp2fg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PR03MB8377
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


On 25/11/2025 4:13 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> Restore legacy implementation of retrieving clkmgr base address from
> mach-socfpga/misc.c driver for our legacy devices.
>
> Excluding Agilex7/7M from this implementation as these devices' clock
> driver is already following clock driver model and is supporting
> enable/disable APIs.
>
> The legacy devices' clock driver will have to be refactored to support
> driver model which enables us to support enable/disable APIs for these
> devices.
>
> Fixes: ab27182cac8f ("mmc: socfpga_dw_mmc: Enable/disable SDMMC clock via API")
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   drivers/mmc/socfpga_dw_mmc.c | 46 +++++++++++++++++++++++-------------
>   1 file changed, 30 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/mmc/socfpga_dw_mmc.c b/drivers/mmc/socfpga_dw_mmc.c
> index db4e0129c2e..6219284df3e 100644
> --- a/drivers/mmc/socfpga_dw_mmc.c
> +++ b/drivers/mmc/socfpga_dw_mmc.c
> @@ -58,17 +58,24 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
>   	u32 sdmmc_mask = ((priv->smplsel & 0x7) << SYSMGR_SDMMC_SMPLSEL_SHIFT) |
>   			 ((priv->drvsel & 0x7) << SYSMGR_SDMMC_DRVSEL_SHIFT);
>   
> -	ret = clk_get_by_name(priv->dev, "ciu", &priv->mmc_clk_ciu);
> -	if (ret) {
> -		debug("%s: Failed to get SDMMC clock from dts\n", __func__);
> -		return ret;
> -	}
> -
> -	/* Disable SDMMC clock. */
> -	ret = clk_disable(&priv->mmc_clk_ciu);
> -	if (ret) {
> -		printf("%s: Failed to disable SDMMC clock\n", __func__);
> -		return ret;
> +	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> +	    !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)) {
> +		/* Disable SDMMC clock. */
> +		clrbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
> +			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
> +	} else {
> +		ret = clk_get_by_name(priv->dev, "ciu", &priv->mmc_clk_ciu);
> +		if (ret) {
> +			debug("%s: Failed to get SDMMC clock from dts\n", __func__);
> +			return ret;
> +		}
> +
> +		/* Disable SDMMC clock. */
> +		ret = clk_disable(&priv->mmc_clk_ciu);
> +		if (ret) {
> +			printf("%s: Failed to disable SDMMC clock\n", __func__);
> +			return ret;
> +		}
>   	}
>   
>   	debug("%s: drvsel %d smplsel %d\n", __func__,
> @@ -88,11 +95,18 @@ static int socfpga_dwmci_clksel(struct dwmci_host *host)
>   		readl(socfpga_get_sysmgr_addr() + SYSMGR_SDMMC));
>   #endif
>   
> -	/* Enable SDMMC clock */
> -	ret = clk_enable(&priv->mmc_clk_ciu);
> -	if (ret) {
> -		printf("%s: Failed to enable SDMMC clock\n", __func__);
> -		return ret;
> +	if (!IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX) &&
> +	    !IS_ENABLED(CONFIG_TARGET_SOCFPGA_AGILEX7M)) {
> +		/* Enable SDMMC clock */
> +		setbits_le32(socfpga_get_clkmgr_addr() + CLKMGR_PERPLL_EN,
> +			     CLKMGR_PERPLLGRP_EN_SDMMCCLK_MASK);
> +	} else {
> +		/* Enable SDMMC clock */
> +		ret = clk_enable(&priv->mmc_clk_ciu);
> +		if (ret) {
> +			printf("%s: Failed to enable SDMMC clock\n", __func__);
> +			return ret;
> +		}
>   	}
>   
>   	return 0;


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

