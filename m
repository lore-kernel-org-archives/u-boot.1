Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 403C9EE642F
	for <u-boot@archiver.kernel.org>; Wed, 31 Dec 2025 13:17:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 56B3A84033;
	Wed, 31 Dec 2025 14:17:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=metanoiacomm.onmicrosoft.com header.i=@metanoiacomm.onmicrosoft.com header.b="RgPxQ8XP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CA83084021; Wed, 31 Dec 2025 07:33:07 +0100 (CET)
Received: from SEYPR02CU001.outbound.protection.outlook.com
 (mail-koreacentralazlp170130006.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c40f::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CD1368401F
 for <u-boot@lists.denx.de>; Wed, 31 Dec 2025 07:33:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=metanoia-comm.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jun.chang@metanoia-comm.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgKZgSNP2euuhZx2i16d6K0feRogXkskUy0MRutYK2EyUE6UlNIO3bfVBZSo+NmKzsIORticW2kx+Da5Wh1pYx61yycaW2cVKTGizmud20TAZc2L0qDWAFSbacWfV4FWdaNZWdF5jUVaQdWSnS9eahdoJEi5nNlhIlRr9HHiIpxtud5uehm5JztOWzDEI0PaUjA9VHgLbQHIRayRICPMRYz/3SdxEuNxY1okbPcRdNQGjya09o0qHIlss9oc0jp083K9E8ebVQCu9hWrNciUt9cKRUodkfXedqtTlJOdFHxi1TklTMYtR1YelB0hqULxgiW93HPtKlfBoLZNI4+61A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pe+zhw5NIqlMefuQMntUZDkT6Jr7bS+hYOpRcdQfPQ8=;
 b=M3zQbPw626irAApz+FCuOmp7q67vvH7rWd4+v5ZIvhwSVwI5sLQeUtTs4Kgmlmnx4G8QMg+jT8HCeiujBSM+gzSmTi/C0sesITecP6mO9banYo/mOWwmiYDWGZZw4WugH9RtyaR/GlsccnCL/ZhxroYbjW00nv4wqYdDqRk1VTOb1EwVFfMHzlHeJ/2HwfYlGfuM/lyFJCtMI3ggXE2rfbvBRT3jsvi2kzIyhBOWHb4eaLvd5eD/nXZZusHHPbSWF2KWTBywvIh05GgeKwUKM2zqGPDOV4EameCGjyi6m8Y+gMQWE0lfdwLbexEr+KMnyvGpndh1Cb1DPxUgvZNKTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=metanoia-comm.com; dmarc=pass action=none
 header.from=metanoia-comm.com; dkim=pass header.d=metanoia-comm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=metanoiacomm.onmicrosoft.com; s=selector1-metanoiacomm-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pe+zhw5NIqlMefuQMntUZDkT6Jr7bS+hYOpRcdQfPQ8=;
 b=RgPxQ8XPfUDS2Gz7zNun7LcWNHvH1rphB18mgtWvpUAmvxAizgnH0LUBmfhZm3C9VHcK5fNBajKqzkTU6Y4yjCKcj0De7nVTrHhb2/wKAhgWpF1P9VpoFi+RcxAkl5gvebCWDmLznfVLkDYTI/k6ZTlzlK/0uE5x0J2uh0Rhuts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=metanoia-comm.com;
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com (2603:1096:405:8f::6)
 by SEZPR06MB6551.apcprd06.prod.outlook.com (2603:1096:101:187::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Wed, 31 Dec
 2025 06:32:58 +0000
Received: from TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639]) by TYSPR06MB7207.apcprd06.prod.outlook.com
 ([fe80::94f8:90c4:2339:9639%2]) with mapi id 15.20.9478.004; Wed, 31 Dec 2025
 06:32:58 +0000
Message-ID: <e4a70eae-37fd-4648-bb17-66975c6d09af@metanoia-comm.com>
Date: Wed, 31 Dec 2025 14:32:45 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] board: mt5824: Add initial support for Metanoia
 MT5824 EVB
To: Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de, Rick Chen <rick@andestech.com>,
 Leo <ycliang@andestech.com>
References: <20251230030328.215240-1-jun.chang@metanoia-comm.com>
 <20251230030328.215240-2-jun.chang@metanoia-comm.com>
 <20251230153115.GR710860@bill-the-cat>
Content-Language: en-US
From: Jun Chang <jun.chang@metanoia-comm.com>
In-Reply-To: <20251230153115.GR710860@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0020.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:a::10) To TYSPR06MB7207.apcprd06.prod.outlook.com
 (2603:1096:405:8f::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYSPR06MB7207:EE_|SEZPR06MB6551:EE_
X-MS-Office365-Filtering-Correlation-Id: a33b1797-9296-49cc-a050-08de48367062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Ti9xT000dkZPSkR1dFF2d1BLaHhnTEx5OGxtMGF5aHJ4c0lFNWR2MkRSeEYy?=
 =?utf-8?B?cFJ3dnlTY3Z3UUwwMXR5eHJaWlF1OUg1VzJPTGtnTTNoMVdXOS90Z2JTVkxX?=
 =?utf-8?B?SllJSXpzY28xQUpTNTdGRVlGUHIzZjlzL01iVFNMMUNSekJyam5vMUZSVXJE?=
 =?utf-8?B?cUNkdDd3dVI2Q3lOQ21DVkhOYmJ3OFE0ditVbUo1OUt0WG1UYTFJdWY0R3dV?=
 =?utf-8?B?VDc1SDFidWJrLzFvb1Y2ZVBGdVExUVViS2c3MHBSSVVVR2FWaGZmUGZEOGpM?=
 =?utf-8?B?VFJNZUwwaUJGdjFCVWR6TEtNakFXR2E3cGFld2pOQjdvdUhjakh1aHA5WTh5?=
 =?utf-8?B?a2hrVjJlRXNUWXYycjNKSGcrNFMxR2NPRzZxRDFpb0Q1R2g4VDJDcGdiTG9L?=
 =?utf-8?B?Qzhxc3JOb0tEZUYvZVZtNlJ0eDlMQzhIeCt3VzY0bDhHZmlobjl5eDVtWlBN?=
 =?utf-8?B?dXJvWnRpckV0NEt0NUU5dVR5a3NGSUI0SUJZZk9yMldPaEdZa2UvWU9ZczdZ?=
 =?utf-8?B?aHRBR0tFeVBsNHVsbEVlMk95V0Y1ZS9qL3A1Z1R2VW1EUnZOcjhsdllKVWJ6?=
 =?utf-8?B?V0U5THh0REYzNHpIWTRYemNpTkRIQWxRR1Z4UWJ5YlV3SWxjS3JsaHhMTU9s?=
 =?utf-8?B?aWF3dmY4Sk51V1Ntdzc3SUE4aDI5WlAveUQwdEN3OFNncVhJVUpTdW9rSjUz?=
 =?utf-8?B?OWhUQmlLNUVlWUZrb3VGNFZIb2lrZ09pSzBIWENMVUxGS244VVNrNE1Ocy9N?=
 =?utf-8?B?WEVhR3FVcmprc2tXbUJMa2NJWDNNZ2hiM0lRY0JnakZiaXdQdkJUYkl0UVI5?=
 =?utf-8?B?bjFkOWl5UUlZNWt5c2ZMRVZFbGZpakhCSEFud2FPREV3WlJkTEd1MWxzVWJn?=
 =?utf-8?B?NUQxZmNBK1lHLzFoMnNCQWFQbmp1VHFtOVVpeFhMZDVRQzhqTXhRdGVpeWFM?=
 =?utf-8?B?TFpwckdnVldrZWluaDJ4UTcyNjJ1dm03dHh1bk1MaXZZZGtMTWZHcWkrVHVV?=
 =?utf-8?B?dXdSQUM2RVlFRWwvQ29lWTNkQ2lub1BwTFF4ZUhxSGRiNHkzZnEwaTY5NmQ4?=
 =?utf-8?B?TFAzcUZjdXRCbGlwT1VTVE1TRThDWWlMNWNCaXpwYWFsUDJsOFNEd0hIZ1VO?=
 =?utf-8?B?Q2RXNDRSVzRjT21iQUxyUERaSlJNbzhaek5COCtuS25IRXlTb3kzUmlENWpp?=
 =?utf-8?B?d1JFZ21HV25LZEtSQ0lGMy9nRk5VSHJaa2NLbzRGS1ZCbG0wdWF4dGtwU0h4?=
 =?utf-8?B?Qm9CY1F3Wk9kN09vTmZJcEhSdmU1bTN6eCsrekpRNFYxTm9TRFlqRHpybkph?=
 =?utf-8?B?Z201ZHR6ckZ4L3pLckx2ZklDQ29wU1dqM1lpWkhYSmZKYzZxN2RkNTFaY2xK?=
 =?utf-8?B?WFdrUVRKdDBBNzZhWXRoY0l5aGNVSXdKZmVqV3RMcmdQV2RoTkcxV0xaYnJB?=
 =?utf-8?B?cmEzd21rODAyN0p0QWpGMG9ZQ2tEVlRaemxaUFlMWHM1dzNHQk12a0NodGZQ?=
 =?utf-8?B?T3dKZlFEYlVZMW9wcUkwYmlmeHd1TFFzVEpXd2tub2p3NHY1ck1XZ0RlUDhr?=
 =?utf-8?B?T3RqQzZqMXYrTXUwdzdkVEt3VHB0YjBQK3VWVVpsYjM4QnFIQzIxQzVRU05q?=
 =?utf-8?B?MTRMQnZ0Zk1PM3QyaVY4MEVZeE9NM2tUT1RwenA5aytiZ3VCd0h6djBqeS8x?=
 =?utf-8?B?SGUyYUMwYWNQbWpVQ0I5Q1cwVE9nbzJUQWdTc2RFTSs5dHgzMWtSNnRKKzFn?=
 =?utf-8?B?M2kwdENTSzNxeHZkYTB3V040Z1E5Mm56TnhUYS96U0xFRlJ4bW5iSG1mWVFE?=
 =?utf-8?B?bGxaUkR3aTNuR24vbEV3M2VCTGJrQ0VEa2xSY3lRSTI4bWhZQndLS0libmZk?=
 =?utf-8?B?UnVRdGV3L1YvUmRHVzVxbFgrWUtzQklOYy9kZ2krOHRSMEluckk1NHNhc0RD?=
 =?utf-8?B?R3I4VFBVc3RjRDNjZ2NmV05vNTZmeUNDTWp3SlJsdzRPV0UwL25iZFVWY2d2?=
 =?utf-8?B?Rno1ZWVEMHp0cmNPYTdxdnFxUGdCSy9aT2Jmb05DOGhpS0xidkx5cVIvWXp3?=
 =?utf-8?Q?cSnNXY?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYSPR06MB7207.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVZxZnVOWDdMUUt0RXlGd0ZQQktCdFoxanF1cVFKZE9GeStlQjM0WHphOWox?=
 =?utf-8?B?eDdTcDFYeG8xVWhVTE1sdmJ2MnJJT2lJUjkzdzNSRnhvYWNRMGI0c0lGZWl4?=
 =?utf-8?B?SGZSd0plbkEyTE95L251a05pSVZ1YnpUODFQc0dnMkhmeENnS3k3WTVMcFNP?=
 =?utf-8?B?ZTFFQ21PSzhpa2tOcDg1UHBWQzNqVUQzd2haeXhoQVYvcEd6VUN3d2hMU29Z?=
 =?utf-8?B?NXB1UE9pUE5JYkFpZFcrcHkyclNRcG10b2VQVjMwOTZwTkR4a0JLZWlxRms3?=
 =?utf-8?B?SXlxSU81L1Z1RndIc2lDZE0yMkJuczdPUnBFdmxhOHJDSGw2S2hwdzkrYXdk?=
 =?utf-8?B?TTNvSEFna2N5Sk9JR2Z5cVNMZUdXQUdJMlBpd1hrWFFoNnZ3TWJCQ0w0WHdw?=
 =?utf-8?B?UkZ2MzF4OFdOMENPNEtrYkpjU1ZadUFiN2c0Y2JrN09zcjVKRzF4SDJCUXB4?=
 =?utf-8?B?K0hGSWVraVJoWERWTjBJQkR6RWVkRGVpeXUxZ0xodUxIa0pHUlhDVmI0RXo5?=
 =?utf-8?B?NGpMOXA2TlNUMnh6aEk0ckJiNzZWQ1FaV2lsTGdObmdHTlRmQnlIbHdvRmRq?=
 =?utf-8?B?Tk1wQWczSXFDZDRwaG1SZ2RZa0ZJZWZUM0JPM2xPT1JvTFFyUUMxNGdNcy9t?=
 =?utf-8?B?UEpNUURJRWlmTk1sRjhwcFNVd2Q3aXM1a3ZhQ1ZCTWM1WE9NU3o3VWlMNXFX?=
 =?utf-8?B?YTdLUzZFTjJSaUxxdHZrUUdXbEFzQ1RVYzA1KzIvZ1NzQk5HZVNnaGxWdWZ4?=
 =?utf-8?B?b0I1bERnamgwNThtWUE2bE9nanJhQkxEYzlnKzU4Z2dPOXFYTVVqcCtVYjF1?=
 =?utf-8?B?eWxkSEd2cmhRL0hMQmdyTUZteXdEdDZoZmVvOElPRUdQbFBzZHlNTm43UVN6?=
 =?utf-8?B?a2xQZnhDbEZzODNGQnc2RXM4emVxdTVIRWkxVWNUWVR3N3pzUm5FNm5YaFJR?=
 =?utf-8?B?SkdWMmVROURDNnhLcHpraWdiS2tyQUx6R3M2anErK3hHNjFlcWRDdE41WUtx?=
 =?utf-8?B?dlhpUnlrbmVjSzM0aVMvQVlTNVRuUS9kMWVxREtRb0haVUlXSzA4VmRwUW5l?=
 =?utf-8?B?QmpCSm54STdueWN4QTVYR2hXWENyR1p3R3NtQ2pKQmZpeVBLVWMvSFRwYmVx?=
 =?utf-8?B?VUx3d2ZHSTM5SmZleHU2eEFoOVY1OUREUVFhZ2xQM282dnlGT0NWbGtoU1kz?=
 =?utf-8?B?MDkwdm4vUEE2cm85V01oSU9Ic203elBzdnVHR3VRbzVDT0R6VDlrT2hlWEpF?=
 =?utf-8?B?bG56N2dacGx2ZHBablJDSnFOYUxQZlMrUFZnbWtGL2tkUTYvUmt4NkFnWXNP?=
 =?utf-8?B?UzVYTThFNDNqQmtCQ1c5aFRTTEd4MEw0M2V6cHExcWsxR043TFJhWUtWdlJ3?=
 =?utf-8?B?UTdNTjdTN2txLzhtcGJYWmZXb1dobXhQRGVyQzJVeXZhTlk3c1ByUWd0RHdp?=
 =?utf-8?B?enk3NGVPUTE5MlZMVGt1WG1jOGxaZ1NzcnRkUUJmbFh5bFo1YUNpdkg5Z2ZO?=
 =?utf-8?B?UEQvL211aEJyNGFXUkMyMTFJVERGN3hMNXpqZ2pNSTVTWTNiL0VXeHJuMm5F?=
 =?utf-8?B?MERGbEd5U203ckNvN2FlaEZzQnJIb09uWWt2NXFjRnJid0pISkI4OTZvVEpl?=
 =?utf-8?B?U084NnJnYUFtNDlRR0VFVFROWWh2cmdzSllRWmtLZmR3ODRKUW1LeWRmTTBR?=
 =?utf-8?B?VWxnMFRTdXloN09EejBDMzVsdDJpaGhrbkpsSU5hZUNTbFBNMWZPRGZvaE53?=
 =?utf-8?B?aS9CZVEwUzFnRWVYVkI1Q0toemtJQU93cTNWK3NycEtCak8zT0J2UXR6OXFi?=
 =?utf-8?B?T0lFTWRrS0srN2I4QVJOQm9LVHRMZm8rTkRrSFpxaTRTdTRGK0M4cjRNNC9L?=
 =?utf-8?B?RkovY2JpM2JLY0VHLzd3dHllN0VuTzBPbzZWbFZHcHdGRm9FK3MwZXcyV1U0?=
 =?utf-8?B?b2EydUJZM1h1Z2dUT0Z5RmM3NEJGdFBiemtzMndjUS9rNmFpa1ptYTZQRTJS?=
 =?utf-8?B?cW9tN00xanFvaG5PMlN4WEZFTmpCM0FOWmpkcGJuWmdBVGpyYmExUXRUV0NP?=
 =?utf-8?B?VVZISkV2V1B1d0k2Q0g4RjFxUHk2UTBacS81RlpuV1hoZk5CeG1vNk9QMG9D?=
 =?utf-8?B?RkgraTFraVBSUTRnUDFHNWlMSmJhRG4wb2lnY1VTWUZWRytMd1RPMnVhZlZx?=
 =?utf-8?B?VkhkTE8ya1J6T3liTCtCVFRYRU1zQStZUEtKanFucllsejZQWUtDb3NUUFFk?=
 =?utf-8?B?VEhVUUFyZ05nVWJCanMrMTBHS2pMNkRXcng0c0JPbEtHQ2lYT2JnUWlQbnd6?=
 =?utf-8?B?ZGNEWEdCR1hycmM5WS94dW9NdENHcVVBL2pyUncrYUhzc0ZoM29TbXE5ZXdS?=
 =?utf-8?Q?kRKxWD7d5yf3mksQ=3D?=
X-OriginatorOrg: metanoia-comm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33b1797-9296-49cc-a050-08de48367062
X-MS-Exchange-CrossTenant-AuthSource: TYSPR06MB7207.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Dec 2025 06:32:58.5373 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 31a25295-9a4d-4cf7-b9ce-e250507bb0c3
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUKye8cjPaMHy9HKh93BIkLWmJjAcG/teMdxxPNAp6uGhD+QR0wqAl7VjlE3WZ6j1vngcCOYnTizFO1OZoRsvIP8bJWWy4mhGMmKSMajc6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6551
X-Mailman-Approved-At: Wed, 31 Dec 2025 14:17:47 +0100
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

On 12/30/2025 11:31 PM, Tom Rini wrote:
> On Tue, Dec 30, 2025 at 11:03:28AM +0800, Jun Chang wrote:
> 
>> - Add RISC-V target for MT5824
>> - Add board defconfig and DTS for MT5824 EVB
>> - Add SPL and U-Boot board support for MT5824 EVB
>> - Add DDR init for MT5824 EVB
>>
>> Signed-off-by: Jun Chang <jun.chang@metanoia-comm.com>
>> ---
>>  arch/riscv/Kconfig                    |   4 +
>>  arch/riscv/dts/mt5824-evb.dts         | 232 +++++++++++++++++
> 
> What is the status on upstreaming this device tree?

The device tree is able to boot to U-Boot with shell prompt by the JTAG.

> 
> [snip]
>> diff --git a/board/metanoia/mt5824/lpddr4.h b/board/metanoia/mt5824/lpddr4.h
>> new file mode 100644
>> index 00000000000..5de70c536ca
>> --- /dev/null
>> +++ b/board/metanoia/mt5824/lpddr4.h
>> @@ -0,0 +1,91 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2025 Metanoia Communications Inc.,
>> + * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
>> + */
>> +
>> +#ifndef __COBRA_DDR_H
>> +#define __COBRA_DDR_H
>> +
>> +#include <asm/io.h>
>> +
>> +#define UMCTL2_REGS_BASE_ADDR 0x10060000
>> +
>> +#define reg8_write(addr, data) \
>> +	writeb((uint8_t)(data), (volatile void __iomem *)(addr))
>> +#define reg16_write(addr, data) \
>> +	writew((uint16_t)(data), (volatile void __iomem *)(addr))
>> +#define reg32_write(addr, data) \
>> +	writel((uint32_t)(data), (volatile void __iomem *)(addr))
> 
> We really don't already have an appropriate macro here to use?

I'll change the macro to the static inline function like arch/arm/include/asm/arch-imx8m/ddr.h does.

> 
> [snip]
>> +#endif /* __COBRA_DDR_H */
>> \ No newline at end of file
> 
> Please fix that globally.

Got it.

> 
>> diff --git a/board/metanoia/mt5824/lpddr4_helper.c b/board/metanoia/mt5824/lpddr4_helper.c
>> new file mode 100644
>> index 00000000000..3bc447038dc
>> --- /dev/null
>> +++ b/board/metanoia/mt5824/lpddr4_helper.c
> [snip]
>> +#if 0 /* Enable for debugging */
>> +		if (i < 10) {
>> +			printf("  [%02d] 0x%08x = 0x%08x\n", i, reg_addr, reg_value);
>> +		}
>> +#endif
> 
> Just use debug() here? And remove other "if 0" or commented out code
> globally.

I'll remove them.

> 
> [snip]
>> diff --git a/board/metanoia/mt5824/mt5824.c b/board/metanoia/mt5824/mt5824.c
>> new file mode 100644
>> index 00000000000..f385de1d897
>> --- /dev/null
>> +++ b/board/metanoia/mt5824/mt5824.c
>> @@ -0,0 +1,188 @@
>> +/* SPDX-License-Identifier: GPL-2.0+ */
>> +/*
>> + * Copyright (C) 2025 Metanoia Communications Inc.,
>> + * Jun Chang, Metanoia Communications Inc. <jun.chang@metanoia-comm.com>
>> + */
>> +
>> +#include <log.h>
>> +#include <asm/csr.h>
>> +#include <asm/sbi.h>
>> +#include <config.h>
>> +#include <cpu_func.h>
>> +#include <image.h>
>> +#include <init.h>
>> +#include <net.h>
>> +#include <asm/global_data.h>
>> +#include <linux/io.h>
>> +#include <fdtdec.h>
>> +#include <dm.h>
>> +#include <hang.h>
>> +#include <misc.h>
>> +#include <hexdump.h>
>> +#include <env_internal.h>
>> +#include <linux/delay.h>
>> +#include <asm/io.h>
> 
> Globally, please audit your include list.

I'll remove the unnecessary inlcudes for my patch.

> 
> [snip]
>> diff --git a/configs/mt5824_evb_defconfig b/configs/mt5824_evb_defconfig
>> new file mode 100644
>> index 00000000000..74f6ceb2284
>> --- /dev/null
>> +++ b/configs/mt5824_evb_defconfig
>> @@ -0,0 +1,61 @@
>> +CONFIG_RISCV=y
>> +CONFIG_RISCV_ANDES=y
>> +CONFIG_ARCH_RV64I=y
>> +CONFIG_RISCV_SMODE=y
>> +
> 
> Please re-generate this with "make savedefconfig".

Thanks for the command. I'll re-generate the defconfig.

> 
> [snip]
>> diff --git a/include/configs/mt5824.h b/include/configs/mt5824.h
>> new file mode 100644
>> index 00000000000..9809080b805
>> --- /dev/null
>> +++ b/include/configs/mt5824.h
> [snip]
>> +/* environments */
>> +
>> +/* SPI FLASH */
>> +
>> +/*
>> + * For booting Linux, the board info and command line data
>> + * have to be in the first 16 MB of memory, since this is
>> + * the maximum mapped by the Linux kernel during initialization.
>> + */
>> +
>> +/* Initial Memory map for Linux*/
>> +#define CFG_SYS_BOOTMAPSZ	(64 << 20)
>> +/* Increase max gunzip size */
>> +
>> +/* Support autoboot from RAM (kernel image is loaded via debug port) */
>> +#define BOOTENV_DEV_NAME_RAM(devtypeu, devtypel, instance) \
>> +	"ram "
>> +
>> +#define BOOTENV_DEV_RAM(devtypeu, devtypel, instance) \
>> +	"bootcmd_ram=" \
>> +	"bootm ${fit_addr}\0"
>> +
>> +#define BOOTENV_DEV_LEGACY_MMC(devtypeu, devtypel, instance) \
>> +	"bootcmd_" #devtypel #instance "=" \
>> +	"setenv mmcdev " #instance"; "\
>> +	"setenv bootpart " #instance":2 ; "\
>> +	"run mmcboot\0"
>> +
>> +#define BOOTENV_DEV_NAME_LEGACY_MMC(devtypeu, devtypel, instance) \
>> +	#devtypel #instance " "
>> +
>> +#define BOOTENV_DEV_NAME_TFTP(devtypeu, devtypel, instance) \
>> +	#devtypel " "
>> +
>> +#define BOOTENV_DEV_TFTP(devtypeu, devtypel, instance) \
>> +	"bootcmd_" #devtypel "=" \
>> +	"tftpboot ${fit_addr} $serverip:fitImage-dev-image-initramfs; " \
>> +	"bootm ${fit_addr}\0"
>> +
>> +/* Enable distro boot */
>> +#define BOOT_TARGET_DEVICES(func) \
>> +	func(TFTP, tftp, na) \
>> +	func(RAM, ram, na)
>> +
>> +#include <config_distro_bootcmd.h>
>> +
>> +#define CFG_EXTRA_ENV_SETTINGS	\
>> +	"bootcmd=bootm 90000000\0" \
>> +	"kernel_addr_r=82000000\0" \
>> +	"pxefile_addr_r=0x83f00000\0" \
>> +	"scriptaddr=0x83f00000\0" \
>> +	"fdt_addr_r=0x68010000\0" \
>> +	"ramdisk_addr_r=0x83000000\0" \
>> +	"fit_addr=0x83000000\0" \
>> +	"initrd_high=0x100000000\0" \
>> +	BOOTENV
> 
> Please switch to plain text environment and consider standard boot,
> thanks.
> 

I'll clean up the config include to remove env settings and support the NOR flash boot.

