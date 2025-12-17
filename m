Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85092D64087
	for <u-boot@archiver.kernel.org>; Wed, 17 Dec 2025 07:35:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9E62083AA0;
	Wed, 17 Dec 2025 08:35:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="UH5bMezb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EB95C83AEF; Wed, 17 Dec 2025 08:35:16 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c000::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DB7FC83979
 for <u-boot@lists.denx.de>; Wed, 17 Dec 2025 08:35:14 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PiGpm4DHnmq6hqWqIgUmcc9saBoO2TiwHt1+SBIYaJZpH59wyxnZS7JMaw9xcjvBDKrFb67HuNBr5k8lzJKD7pwyuQdlRNDrudMgmSiz5kS4jOsYQhJcvyXzI9AcRzss7X0L2ITLWZ40vs8IuXYXtDOO+WSKlg25JVlX8eyGuC+Zs0J+NreKvUfWXXcpDJgXCPJNpUFvLCChpXm1lZbCnEw2BCGrK73XsJUtSXZVPVOhNOFq2cmJJYnX5nL0r6hlQzwQOCTPJYfmEeAKQxENs2UzWV9iYXB56plcldrYNj6cFUqFKOPyW389S+mSZt0bqSVs2uCY8yRWYNsIjCHKoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3XBxbfUY1RvVJZetWDR69gSfrq6aq9P5y8Fy+G5t9U=;
 b=XR16HBv8/k2r3B/rFgRs9CBVFI+jnZayHi4w5IZbbb5/FSTfDxa6+SqE83uILCuAQKsS3knl3AzvucDLr2FhtxUK5urn9td4InkJ+ar9h1bnpyCwxEGu23AXPs9ETxc2cfxBFYUfy+W3fwMezpW5otL5Ze7Xj4uEdwnwxsm1XdRDooOieq+caQ5cqz/ZglMM3CGOC+2WT6uobNW//0fFL6aeVSWTl5lJLjEZ1RwKrOXTBvTCFSyv4ZIlHDpcpls8qlS73yM+rpBWVRelU5zA5InyR7Ppp3AoD7i1d2jgoMt2JzPgY5nAmeZIJjOevU9985HmZA3T9RRzMmS+AsX7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3XBxbfUY1RvVJZetWDR69gSfrq6aq9P5y8Fy+G5t9U=;
 b=UH5bMezbKLt76u8e4NdBxAu5QEiz7is0z7sfYONKjt763V3uQ8ZWwayzHFjetqKvkmJ/nNZ1G3o46SMjAxLrqoTs7HjQKVJOboPb4mk5BzKOB6myiVfQwcACMk9ZTVbX5AvycTywzkYAj+w8EL7id1FMrqTXUFWjaMZ20i/7V4IzF573AmQ1PZOoNlJGLEStLlsKra5lIMu8RenzpLaRZTe+eduIrNSCk67jlVVydGsAqXk9so2vUmrWTyLRz86OCQmwvBga1YiIoPUpP8O6ULZcrVoBhWljtgaXhrfVcRWOGdfUSapiSHihYL50CCxjwxjms39iyh0vZqpR69VdUw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CO1PR03MB5796.namprd03.prod.outlook.com (2603:10b6:303:9a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Wed, 17 Dec
 2025 07:35:11 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9434.001; Wed, 17 Dec 2025
 07:35:11 +0000
Message-ID: <95782f41-d8fc-4b10-b514-f60e3a7daa29@altera.com>
Date: Wed, 17 Dec 2025 15:35:04 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] ddr: altera: arria10: Fix incorrect address for mpu1
To: alif.zakuan.yuslaimi@altera.com, u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Tom Rini <trini@konsulko.com>
References: <20251216082157.15475-1-alif.zakuan.yuslaimi@altera.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251216082157.15475-1-alif.zakuan.yuslaimi@altera.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0006.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::14) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CO1PR03MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: 25ff9199-745b-4c9a-dbaf-08de3d3ecf93
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RXpHaTJ0cG9BMXc2Yjg2WFpyQlFNM3JOYWE5bEhGN0lVR3QzYk1lM0pHdGZm?=
 =?utf-8?B?OGp2UVpkNEsvOXFIb0RROG9nNXorKzlPU2lNZnZZRUpPbFEvUW1CNmoyOEVh?=
 =?utf-8?B?RnhvaWk2cDhXYlBzc0xNYVBTa0lIYnhEeXB5aU9DaUl2SldxdGtkQXU0akNw?=
 =?utf-8?B?SkdWaVN4NzBqemxaMitiL2FQeUR2OExwYWcraE9vWGNhWTNFTDBWQTBLcXl5?=
 =?utf-8?B?emZ3Ym9JS3pNdVFPV2ZXR2hONEJyQVNFaWtrUlZqWFVVaDlFdHB4cnk0c2Zn?=
 =?utf-8?B?bWhHNUJHRjZ5WlZ0RDJyTU43ZkxzREI2REtXNjJ6RVZhVDlKT3RMSGUySkpx?=
 =?utf-8?B?YkxUb1VHZVR2OG1vRkZzemlhaU95RlhqdkdWN1dhYWNIVi9wbU1mUVJ4eWdV?=
 =?utf-8?B?Unc3Wk9JMUFhNUVJZzRTeTZpVlYycFlJMmJoU3lwdTNvM3lWNUVJL2FSekV3?=
 =?utf-8?B?cDgvNDdLVlJ5c2hVMTdOdHVKeVQyNjI1QWtnUEpzNjNWN01KclJQV28yYXI0?=
 =?utf-8?B?MU9MUWREb0ErU0R1Sk1VRW00cGE5L1QxNWZ4Rzg5U2lyaVl6N1NpYzNPK2lF?=
 =?utf-8?B?NzVtSCt0TFR2SCsrT1lwQkE4bmVlc0lxYVc1OUtrQ3ZzYjdEcTRjSjdJdTNt?=
 =?utf-8?B?NG1sRFRTWFg1U3ZHSFEzb2V3TytrWFpqZGFPZkxIL0tKZkpubnlaTkFJejBz?=
 =?utf-8?B?b2FHOW1CUXdNZGtzMXUxemhBNVZsR2d0MWhlYlZqZGoxK2tPenBseFU0ajRW?=
 =?utf-8?B?K0JXZk1NcTdqYW9PQUlEY2tHOWdQUUxVM2FRcnB3QUpFTnVHZFdmUXo5OWpK?=
 =?utf-8?B?Y3d4THNMaGc1MDVsM0MvalprVDc0b0ZrQmQvWm1ueDhRdm5kemc5OFZlelB3?=
 =?utf-8?B?c0loaXhHUTMxY0JKVnIwdkJmQTBmazNxRXFZUS9vUEtxZXhaTi8yQ1lqUVdI?=
 =?utf-8?B?elp3S25vRVAwb3ZBOGRmTzhUaWdTcEk2K2JncTBYSHNiS3I1cnVINTdoejhD?=
 =?utf-8?B?QkJWWW9BQUxzM0Mxc0IzTjUrdjJDSFR2S0duMmkxcldsdVU5SE1QOC9VdzRz?=
 =?utf-8?B?VVdEWjQ3VVFmQXZ3eURVYmtHR3QrMUo5OVdxQkhwRFlQY1hNTk05NnZXSkNW?=
 =?utf-8?B?d01xMExhTnlGc2VkeExYWFBNY01vbC9JeHhobm9Hc1laS29tL0NVZndkT0RY?=
 =?utf-8?B?NlRTS05qemEyTGQ0RFJsZUgwSG0vQ0Zod2k4QVRGMllRSjMyektSR2drcWNZ?=
 =?utf-8?B?VUoxYXAwRFJUVjgvb1dTSW1iZG5tT2RqbDd5VlAyL2VBVFV1Uy9YWjNDQyty?=
 =?utf-8?B?MUIrZWhicnJRalJUSG5BYmdRRXVPekN5WEl6aEFQZmV4NkpueGdqMkp1TDky?=
 =?utf-8?B?djVZUm9hcWZGS1dFLzhsYUFDZWh5M1lMNVAxZnZZRklScVgzandBZkxDdEF2?=
 =?utf-8?B?bVdpN1NsZSsvZEhsMzY3bEs4MXlERzU0Q2FmeDU1aXNWRUZxeWhxZTI2Vmoz?=
 =?utf-8?B?V0N4UjhSd0JCSmhlR0w2UzJib1lxK2tvSFlCZDZQamppa21kYnkxRlNyZmRP?=
 =?utf-8?B?dnVZd3R6RjNmbmtNeHVvc01NbEdOU2pOU0J5b2Z3TG00WnhqaVk5czZ4RVpx?=
 =?utf-8?B?M1Z0SThHZ05GQjZleDhYRnFpbk9JaTFvUUNZZHkzMGpPamNydS9TcFBsTVhx?=
 =?utf-8?B?TGh6b0svUThpL2UyMTN3SzhGRU5DT0QyWHlPc1BlcG45Q0daMUJDNjA2bHNB?=
 =?utf-8?B?SXFUWEFDQmFaV1dKcnVOdUJTeVNPT2JodnkrWjdYSE42TFdISUxaNUxWQm1u?=
 =?utf-8?B?bmxEYVA0T3orNzdQczZMVjc0eXFrUmFtMk1LVzI4aGNIUjhHaUxocGNwRUZy?=
 =?utf-8?B?dkpEeTdKNnhHN0IyYy8vTnNZYU1uR2UxWERtYTdGRDgwa2NmWHJLRjlYNXVC?=
 =?utf-8?Q?HiQOCbM9f3tLd3wtXVPe4bPiJRbJgl3g?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TUlKbVVGWkZYRGZaYmR2KzRmWTRuT0JReXlMd25RU2lYeHdhYnQrY3hQTVZC?=
 =?utf-8?B?b21iOXI0SmVvV1RYTVpJSWZGRkZwWUhPenVEeXd4OWQ1WWhkV1hRT0Q0S0dY?=
 =?utf-8?B?TGg4NWZTbGFGR1dvZWlyTC9iMnh3Nll6c0FjMmxpaytWWjlYcnI2QlhjRmhM?=
 =?utf-8?B?cmxzY2FJcEFsUDFmK3FMdzcrR3l3eWhqRmttVTg3dG05eFppQTluU2Rxakho?=
 =?utf-8?B?YWFBNE1US2tocDl6UGM0WXIxS0R4R3h1THFNSWhUd0Z3djV5ZWhrM1VjUzN1?=
 =?utf-8?B?SEUwTVhWNzZwR3F1N0szRWF5ZUZ2TENwMnJhd0RjaXdUMkYxMVpGZTRlWFN3?=
 =?utf-8?B?dUgvOEJodGlUZkJ6R1RneUJEaDNRMWVKMktBRUcyeU5SOUpoK2RMZ2p5bmdC?=
 =?utf-8?B?Rmt3djdubk1XSnBWa3lnSjFnVEJrcGdiL0JlaEdaVytlWk9FdlBia1lESlNm?=
 =?utf-8?B?QzhDYWt1ZDFxTnB0UytHbHlRNlY3cURYRTkyUm5hQUFZYnVoTC92RmxQQUpz?=
 =?utf-8?B?cmRnK1NQTmk1U0lubU9rNWFaQkhzOVJ6ZzlOS1VtS3Q3R1Myclp5TkJxTzdR?=
 =?utf-8?B?QTFLTkI1eENIakhERUliQXd5M25rYVdzV05LdDBlRWhMYmtaVXVyVGhkZDYy?=
 =?utf-8?B?dzAyQklldzNzdGRjOVlML2Fka2tqZFd5RUFUcDBBak92SEw0WG43NkhXT3J3?=
 =?utf-8?B?czZCYnRLTEdMVlhISlVvWTFpdnUveUtHbzBVK0ZXeU5OeU5NandrSHlwcGlY?=
 =?utf-8?B?clpGL1VpczUzSUpRVVpOVno3MUJEanpjdHNteUUrL2UwY3F5RzNHN1pPRm95?=
 =?utf-8?B?TTQ1SU1seU9vSUNLMXZINE80NXg3MEZqd1hPU0NNbTNuOGF4L2J5cVZUTGZR?=
 =?utf-8?B?VW1NaTlENit6L0Z5Q2ViZnhnKzlWNis5OXduU1hFTk1rK1UvQVc3bkZIeEYr?=
 =?utf-8?B?RHNpOGxqUEZ4Y201MDQ3RFdnWnBjcXoxRkpLMEZCT2VEcnJLc2xXSTh2MWxt?=
 =?utf-8?B?Z1pOdTkzalBYRnBmcFZiSXJjalRXbi9ZMnAycCtZcTAwcXlGZXlHQzV0bkFU?=
 =?utf-8?B?QnNSRlp1WDJwNS91OEVvdEJac1ZVVzVaa3NmMXdSVi8rUWhIbGp4OXk4a2dj?=
 =?utf-8?B?SmRqdklXSUNBRnh1RXNJZUhxaFA2aGhKWnJOQTFBZXhIYUQzbmU0TFNHMFN1?=
 =?utf-8?B?RVF4RGhaeGFoNld3aUlqdlNpemp2YzJadHRraFRCR2J6WWd2dFRlTnNxNjVG?=
 =?utf-8?B?NjRGOERZQ1d2cUZnMmZhNUxlZFRGWWdXNjF3MzRsbVBhbzdYL1BKZ1NKWVN4?=
 =?utf-8?B?dnpvYTdyY05INUphK3p0UE1TbEp3M1d6UkRLUkVJUnFyUHVCM1kzU0d3S1BS?=
 =?utf-8?B?RmZmdE5VeDJ6UFMyeXlXVFVQVm12QUhyMzNaUmlrWUhQMUdUS2JtaXFrMFRS?=
 =?utf-8?B?eFIxWWhKazFoUUZXb2RKRDdmZDI1MDR3R0dIL2JTTWNXWXQ5NlZLZEZhbFRK?=
 =?utf-8?B?T0MwNC9kb3JtYVRab054OHdyU2VVUVlLZVZ3SXMzTWlKY2xrVjBXYjA5RDZH?=
 =?utf-8?B?S3JMRlpuNHk5SWd1QW81ZE03RHZ1T0NzTXY4bGM1Vm9HSW5NYTMwdTc5YmF4?=
 =?utf-8?B?TmJ0UzJma21YOU5XbkdvQ2F5SDI2TWJ0aEwzZSs1NnpSZ3p6VldLeW5oTnFr?=
 =?utf-8?B?QmtrSzdVQW9ha2ozUTVaUjE2S0tZKzJScjVrVlArWE1nYWl3NTFzMnFJOVJZ?=
 =?utf-8?B?cWNZaXJqb3pRaFRDK2tvOFBmS3loT1doUEhYbkxPOERWVzdFc2dZKzZWQUZY?=
 =?utf-8?B?THpmNkpSNENCNnB5a0hYODZkSXVkSXF2eXF2a0hsOFdPS0l6ZUlXUk5OUS9U?=
 =?utf-8?B?NmZxYmg5VW4yNmlnOUlEQ2EvQVdhUTMwb01sNjZzQUhIc0tvb2ZpWWhHSk5o?=
 =?utf-8?B?YWNyM1FMekhZc2M3Y2FyZ1hPMUhkcFhhZDhxb3ZVME12UGVBdktWZFRrQ1dD?=
 =?utf-8?B?OTdzaUxHcE9IeGtBL21UQi9peXBRVEVhaHhQbU5kVzlSNHBCMjQ2L2xBQ2tl?=
 =?utf-8?B?S2xmL1JUSU1RU2s5aEJhU2pqc1c4RzczOFAzSVZvejJIQUQvT2pWbzhtTlZ2?=
 =?utf-8?B?cGJPUjQydmhNM240Vm1NOGdPcHpFK1JhSTBNamJSMGY1eW14Tjk3VFpRcHNh?=
 =?utf-8?B?UTROSmtlNXVGL0xHUE5ZUFpoMmNzNjBKMjdTclhQSEpwWkRIQTEyK1VDUGtZ?=
 =?utf-8?B?SnlhQVpQTW5mQUNvVTVRZmMwcDZCZDF0RlpjUGx3R3JaejlBMHF5UVJ2RmYy?=
 =?utf-8?B?dHVYS1RKVmNVcE5tajNEYlgwcVN4ZjFlNWVxWkZGR21NbmlPWVpzSEN1VStI?=
 =?utf-8?Q?qgN2QiArvxV5j+0w=3D?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25ff9199-745b-4c9a-dbaf-08de3d3ecf93
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2025 07:35:11.6306 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FRPYYKRImUxN5zXwckkJDFtY6iX7zk4QOhobz/x4F7FL3+8q7jXHZWmSwegbkBTkLvCFhqYMg5m3kSiEc5mfoAArbzjNnSnNXjBdmoPTkyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5796
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


On 16/12/2025 4:21 pm, alif.zakuan.yuslaimi@altera.com wrote:
> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>
> SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS is already added in
> SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET() macro.
>
> Remove extra SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS in mpu1 address
> computation.
>
> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
> ---
>   drivers/ddr/altera/sdram_arria10.c | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/drivers/ddr/altera/sdram_arria10.c b/drivers/ddr/altera/sdram_arria10.c
> index d3305a6c82d..a4f941a2215 100644
> --- a/drivers/ddr/altera/sdram_arria10.c
> +++ b/drivers/ddr/altera/sdram_arria10.c
> @@ -475,7 +475,6 @@ const struct firewall_entry firewall_table[] = {
>   	},
>   	{
>   		"mpu1",
> -		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS +
>   		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(mpuregion1addr),
>   		SOCFPGA_SDR_FIREWALL_MPU_FPGA_ADDRESS_OFFSET(enable),
>   		ALT_NOC_FW_DDR_SCR_EN_MPUREG1EN_SET_MSK


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong

