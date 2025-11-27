Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E78AD10375
	for <u-boot@archiver.kernel.org>; Thu, 27 Nov 2025 04:32:40 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0DAC842CD;
	Thu, 27 Nov 2025 05:32:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="nBsESEM7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5733842D1; Thu, 27 Nov 2025 05:32:37 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazlp170120005.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c105::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B3DF3842C4
 for <u-boot@lists.denx.de>; Thu, 27 Nov 2025 05:32:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rpU2aRiQdmTha/ACqrsdYWC/vEAG6RecXa6XF+EG+mHa/8ag+RnAG11iiIg05x5p89k0fkg7ahNNYJiW7aygibjczIUzguwQuIRyWnxtSF08FxHuQvbmgBV/xgnPp54Rq1/URkBtDxjrnCbxJdH1kU7K+9gNrbEj1XfoZrSgXSAg43Ls/4Gk0asIEzc/sr8g/u2P7DUtXUfwcsY1//G27qxGAh5v2j21Fbs2H7CYB5eZeYlLAlSLUpJH7ZY2EYPKZsGSNgLRbSbUfrdbwFx/TicVmBHJsQzwVcMhKC/78Ia7pjs32DQcekhBkV+Lvh7NczzwXzpjiTrs+wd+wUE6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulFxNSwzVlul3mnpJsl9S3KJYN+o6TVmiBzx+DUE8vQ=;
 b=H2JubaKlaZcBjQid5gdn04h0Sr9lOC+K9salnHG6rZIOrKQJSAMTsIqw+BqwrsxzivHxvcmTnXQ82JR50QeyS6/gi1RZ38/gsGdz5h4vUvxysel2UUlMaJteUhjtgKHraWeYSiQc2neOLIEmBV0zDgYwqbBsmE1OZquUMbYj6Vf7qWfQlUJ9RXe+jMbf+HVU8MgNsVD46pPQI1fDcl44q/2OCq0YkCBbCH8vTmSbXd0ZE8mE5GfJfw41LqmDEpOpPNZHia13LBZd6sRVxHIB09qXwyYpawSRSTHqIyM1abo3EoSpQsUEMPmMSLAdRKLNPZvsDHS48k7sDiLvnvZpVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulFxNSwzVlul3mnpJsl9S3KJYN+o6TVmiBzx+DUE8vQ=;
 b=nBsESEM7J1H2L7QVA+26UrMSbvlcXRvbXSEv5NIFa216Xr4sNGNiIYrgNth1qjSj9/bh1xhCrSqTVPnfJB2HKOZZDWz1r5+YdzjjP60P6uGkqAg+kO1KanqZyNWzPJAdMPVWgxrHYmaFP2Lpt9f2IDQlkYX9GdouYY/BcNuLQy3qX+HKmBAM4y/EgIsaMq86wPDdFOBdj9gceKl0IAbNoRW8LNxuvCe3uGqDnuG3waclKcXFPbTrQGvLhZjLill3QnU3OU4EKTutEWzS+ft53sV4PXLJeQ/JqtOMljLbKY9e0r5KcnZuEnx4BG6u0dklcYxWaPceIYAjgYfqAlSufQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by DS0PR03MB7776.namprd03.prod.outlook.com (2603:10b6:8:1f8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Thu, 27 Nov
 2025 04:32:33 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9366.009; Thu, 27 Nov 2025
 04:32:33 +0000
Message-ID: <e2f1c154-573e-4326-ae8c-ee9ded46c71d@altera.com>
Date: Thu, 27 Nov 2025 12:32:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 6/8] configs: cyclone5: Enable SPL FAT support
To: Jan Kiszka <jan.kiszka@siemens.com>, alif.zakuan.yuslaimi@altera.com,
 u-boot@lists.denx.de
Cc: Marek Vasut <marex@nabladev.com>,
 Simon Goldschmidt <simon.k.r.goldschmidt@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>, Peng Fan <peng.fan@nxp.com>,
 Jaehoon Chung <jh80.chung@samsung.com>, Brian Sune <briansune@gmail.com>
References: <20251125081316.17329-1-alif.zakuan.yuslaimi@altera.com>
 <20251125081316.17329-7-alif.zakuan.yuslaimi@altera.com>
 <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <896ecbf4-d85b-4c09-b8d0-9730be370673@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0023.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::17) To LV8PR03MB8137.namprd03.prod.outlook.com
 (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|DS0PR03MB7776:EE_
X-MS-Office365-Filtering-Correlation-Id: cf19c787-a1a7-433b-a242-08de2d6dfb6b
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Q2FiaVZlT0RRVFBrcW55a0dnTFhRZC9aMkRXR0hzSzRZLzBCS3lTTkhBNmJW?=
 =?utf-8?B?ZFhaYkhmdFloaUZ5bDdBcVZYY2NJeHpNcVZPMUpMQURWdm56NVdZLzdQMGJy?=
 =?utf-8?B?MTJpTERaVmRVTGtGVFVqaFo5UEl1K0dKeklxQXljRlVWTGJJVm0ybVFER0Q5?=
 =?utf-8?B?ZXhENmJCanFvcWNKejRSTUprNU1iRWtjSlBEcXBJOGhWeU9KaS84V2NyQWZ0?=
 =?utf-8?B?TXE5SVdJU3NNMnJwN1pNN0xabjE3cTBMMFAyZ3Z5RVFyRGs1QlpGa2ppM2Fy?=
 =?utf-8?B?TXhPSEQ0VG41RG5WWG9QdldVMFJpeldlb0hTNlNabFNIQUVUVjZ5NmJXdGFy?=
 =?utf-8?B?emkzbk80Q3BUZmo4Z2pRaXhEN1NJOWdVeWdRb2RhaFVERDdCTG1yVzk2eUhi?=
 =?utf-8?B?QWRxUnlzd1VsUldzMEd1L1h2a21nWVZycHUwYlpiRXVubGk1MUFlVW5BSFA1?=
 =?utf-8?B?RXVhTncwU3llTmUwSzlndldqUVphWWhlM004THN0RzFjTHVXK21ZNnRxWU1o?=
 =?utf-8?B?Y1p5YlRzazFTYlVSUzJESWQ3dGZXaitOcWwrSkJNSWhUVGpTNDZsM1QyOTBI?=
 =?utf-8?B?aElESUllbjl4QUlmcEo0WUM4S2s0UC9qRDUvbGFXVjJqcUNHeVdjMlZRSndK?=
 =?utf-8?B?ekdLcW9nQjA2NHFuMzBCNGxaazFzcmEycmFwRmVrbFZCaGc0NkxyVmVhcFlJ?=
 =?utf-8?B?OTlST0VjZTQ5VFRTT1p6Rm9GTGhqWFJUWFBNR21ZZm84ZWZtMWxMUFNYSTQ5?=
 =?utf-8?B?TWdFaEhqK0R5MEJaSWwzZVlPYXVUR0NTS0ZDR09wT0NFc0NJT3VTN2VaWWRY?=
 =?utf-8?B?Rk9TdmpmQlhxSWFYNElkVUpOeGNIWDhmVlNTczdaL05SOHk3aW9lYnB2YmRl?=
 =?utf-8?B?Z1UrOUQ0cEV1T3ZlVndteC9zK0FjVXg4WjJJcyt3T1N0UjZYUkFtTGI4Ym9l?=
 =?utf-8?B?WHFwTUxCOEZRdklsVnlTMlJ6OXprdDVSYU5hdEtLWmNDbkFLZTNzK3FueU1B?=
 =?utf-8?B?dDhVYWF4eEg3eUVzT1BmOU8zLzdjNldxNlE2V0tIMVhySnVKZ0RkdFFXNEFw?=
 =?utf-8?B?UG81akgwbC96Z0pteE1tbktPSytaVHVycGNuL1YyWCt4OCtXVWVGSUhGY0Yy?=
 =?utf-8?B?MFN1emZXMElSQkdiTFlEL1pPS3pOR0pMZE0rRlBTanZoU0tMTStsYmRGbjd6?=
 =?utf-8?B?aXdhNWg3UkYxaG5XQU9nbVR3ejkxYzNSUW1hcVZIN3VDdWdOYjZnaXlXbUsx?=
 =?utf-8?B?VWtHR29ENWdTTUYyYTcveXhtNlFJdUtlbnpRTUxKalU2eEZuR2U5U0x3Z0VP?=
 =?utf-8?B?Z2VKaHFDMWIwazRBUngzY256UXVMUWw1QlhiOG5oK0J2aE1VdXJnbHlTT0V5?=
 =?utf-8?B?b3dJb0dUM3VtMDg2SHE5Ry8ya0RrOUl1bHVhMnlFWXkyNDZrdW4wQTg2L2hW?=
 =?utf-8?B?Q3lCdm9xamFrcGwzK0tzVzYvWTUwYmx1RmhsbFgzNGc1MFhmVURISkVENURV?=
 =?utf-8?B?alNueG1WamcwVE11WGVWMGRsMUF5dU5BWlozWExWSCt5S0ZMVWREdEdqMzQ2?=
 =?utf-8?B?R0t2RW5VSXdWeHZMc2JtZW1XNE5RNlcrbU1TNTZUV2YvTEE3Smd3cTR4Z0hy?=
 =?utf-8?B?bmFqczhZZGtEUTZsNERCWHRzWFlRb3VjekxpRDMvRzkzUDVwbFovUUVoK3l5?=
 =?utf-8?B?aTFCMnJXWkdCM1hkWCtvV212SDNnNzU5a0M2aDY3Q2pxeTk5SmNaRFBtRFlT?=
 =?utf-8?B?TEkwU2VyMlhpWnJiWk5xTEJqdHY5aEFGWDZxMHNQSW5mQjEzcUJGZm5EaGph?=
 =?utf-8?B?VlpRekVkeDErT0s0VEs3ZWt0ZmlrQWF6TjRIM3FCM0VrUjFQOCt0RlFBeC9h?=
 =?utf-8?B?MVNOQVI2Vk94UE5UL2RVVWVQR2U0SlljRHE3ei8wOEw5ZE1wYXZmZ05HV2tu?=
 =?utf-8?Q?Jy2M2nIG0oLEHY11Ve784JWH1eN76GfT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnFmZ25QdGlIYnJlNWVRVFg5ZFpVUXJzaGlyZEtBUmNJTHZoeFdtcGVvN1lO?=
 =?utf-8?B?dHFsUjdxdHBRb2wvRXh5MUUyR2J5dHc1UGVMYTNSUTBOdzVySzZBSFVoVlRI?=
 =?utf-8?B?dTVaVy9IWjZpa3Ira0tIL0hodmFhSDQzdWhzR3VlSlhvdjU3VlBIK2ZHak1O?=
 =?utf-8?B?ZmZERlNtWUEvQ1VOQkFwczZjdWt5Z3FIT2NTVHQ5czdIek5iQjZJSE5nYUNY?=
 =?utf-8?B?YjF0bUJYc0RLa2JMRTVTcUZTSC9mdURKL2R1clhNdmw1cEUrdEpxY0lpdFB5?=
 =?utf-8?B?M0FsKzN2Y3I0eU9LSXRNT2MxK3A1QmhVc0FoTDdFcmpoZi81WllhZFhYblEr?=
 =?utf-8?B?NGpQWVVSSGswTUhlUmhFL3RvWTI3MDQzNHVud1BmVUJiZVhneHljeFUrM3dh?=
 =?utf-8?B?akxac3hVQWdpekhnb0ZnR3M5R3Z4QlhSM3d3Rm45dTVTWnRtSUJpT2Fna25t?=
 =?utf-8?B?bC8zc2tQOUYvTlR3Y0o5cVdvbC93VGFXamU3c04zSkExSVlYZlhrNUhDSjlE?=
 =?utf-8?B?aHc0Tzc3NWpDQUZZckZSaVVBbGtqdVFtSEtnM3JDT0ZqdDhFeXRaeTIzMDU1?=
 =?utf-8?B?c2J3UEljanYzZm1iTXhpdUdSODJKVU8vK1k0dngzbzVxdEZBWUo2Q0E5bUJC?=
 =?utf-8?B?V0dYQWk3R1lPcStrSmdnVnpzREh4K0xHTVJxR3FUSTc2V291ajBkbzltc2JX?=
 =?utf-8?B?eldnSEtZZGlCbVlwWkNtSFpuZ0VjZ1Y5dTQrbUs4OHk1ZFRNaGdpVDBGZVJh?=
 =?utf-8?B?azE3OUl3VXhiK01LRGhWOHZhNUtZS1pNV2ZwQjZVYXY4L3BlUVZaQmR4R28r?=
 =?utf-8?B?bEFadjduUjZiZ2dWbmczVmFsQ1ZMalo5R3d1STM1eHZoWjhEMlZwUW8xWnJp?=
 =?utf-8?B?eUlGbVI3a3ZDZVdtK05oUUpMQWpTMVpmbjJ2MUJacm1ibXBVTGZEL3Q1M1li?=
 =?utf-8?B?SVNOSjZhMy9jd052enBsT2ZRMURnTFNtS2ZrNEh5VGxFQzcwQ0NuaWhYZVZR?=
 =?utf-8?B?ZWRIVWtVYU1jdVpiazBxZ0FibXVTblAzNVIxdmU1YmovREh5bUNSNXlxanE3?=
 =?utf-8?B?dkphSjBrYkR0OEJhMWdPUmU5RjB1OUlJaUo3aWhjVkhFYzJyeW5LcEV4NEE2?=
 =?utf-8?B?cXhYMllLaDFFSGJxcDhWenE5dGpvZzk4a3pNbXZOaC9Yek1XRTZRZjhkalVI?=
 =?utf-8?B?N2doWWZxeEhNOVdUbjZDdDFWRFhvYi9nbzhWcVZBdTlqMlh0aG50N0l5WnpI?=
 =?utf-8?B?NDJ0amh0ZkRQV2NXN2ZmamlDaXJEZ05SV0ZxK3l4emNQWTkybTI5QVBjV08x?=
 =?utf-8?B?a21RMGJLNFZpY21TcjhSdDBnaTN5UkxJeTlmeXdJdVBJa3dQYlRUN0I5WnVo?=
 =?utf-8?B?U25YYWYxcncyY2lDR043UUcvTy9Ca2pOcnBPb241RW9zWGdiaUMzNGUxWEp5?=
 =?utf-8?B?OUdYajl0S1l5cmhaMTZjNXl2eUZQQU1ScE1qRFhjOC96VjRjbUh2VWZhRU9v?=
 =?utf-8?B?SWgrWUc3SlNKc1NoSUJwT2l3R0k4amE2NlVKS1Y2WDVOQzFRTDVOekFnRDJo?=
 =?utf-8?B?VzdxTXpzT1pnY0tWM0s4QzJ2enBJdkd3QktMeVhNa1BjSUIrRGhyM09naGhY?=
 =?utf-8?B?TDZJakFBaTRuNTluV1N3RmhuZEFCQzRBZTllQVlRdHgwUHFvd0RJTUUyeFYx?=
 =?utf-8?B?ZHhsMSsvUGJiaTZyeHVqbmN5c1NvT3ZwQ1cwKzNPRFBhd0dTSjgwakg0WGpK?=
 =?utf-8?B?SXF1bWhDRXBkOTRZenVIamh5eHFRRTFxU2FLNkY2Rzg1RUJUSFdLUSttOS94?=
 =?utf-8?B?QkZZMGFKWjJnN252QkJ5a0hvVHhWd0E5T0hYWGpxYkw0eVd2ci8vdWJzZFhK?=
 =?utf-8?B?Y3RxUE9xbTZDalhTeG9vdlFTZk81b21FWjVwK0JWaHM3QlFDRmNlVzBjU2Ft?=
 =?utf-8?B?d0lkZ0Y5NTBRSHZnYU9OZ1JINGVtZzBNNFliZGJhM25JOWtXSXpGZjd2Zzly?=
 =?utf-8?B?L0FSdy85QjJHQ1lXNDJHNXRpYVBiSG91Z0dEU1BCbWEwZk9pRUFMd01nVlpt?=
 =?utf-8?B?RmtuU2p5N0FqTlFWSjUweTZQQmxaUjYva2tZOUh5ZktadHFzRDlNaFgzMEdB?=
 =?utf-8?B?cEFKM0FQVWRDZ3U3aWlmRzdhTUk0UEdZUzdabERIRlFSd0FrbmJoalZYZjhh?=
 =?utf-8?B?ZkE9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf19c787-a1a7-433b-a242-08de2d6dfb6b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 04:32:32.9588 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3n78B6I+zvAZWmwXE8FU4gq7x942e8JCfPGQhM+4V9lrzMwVOZ6qFEDL11BJv/BPtaxYnDBW1z8FLjhoSO5Uvpo6Dz9Bj+/UQwbUbwZVRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7776
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

Hi Jan,

On 25/11/2025 5:41 pm, Jan Kiszka wrote:
> [CAUTION: This email is from outside your organization. Unless you trust the sender, do not click on links or open attachments as it may be a fraudulent email attempting to steal your information and/or compromise your computer.]
>
> On 25.11.25 09:13, alif.zakuan.yuslaimi@altera.com wrote:
>> From: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>>
>> Enable support for FAT filesystem with SPL for CycloneV instead of raw
>> mode.
>>
>> Recent changes breaks CycloneV MMC boot from raw mode, and so we are taking
>> this opportunity to migrate MMC boot mode to FAT as smaller OCRAM size is
>> required, as well as aligning MMC boot flow with our other devices.
>>
>> Fixes: 2a00d73d081a1 ("spl: mmc: Try to clean up raw-mode options")
>>
>> Signed-off-by: Alif Zakuan Yuslaimi <alif.zakuan.yuslaimi@altera.com>
>> ---
>>   configs/socfpga_cyclone5_defconfig | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/configs/socfpga_cyclone5_defconfig b/configs/socfpga_cyclone5_defconfig
>> index 2bec82b0625..2b2435a27bb 100644
>> --- a/configs/socfpga_cyclone5_defconfig
>> +++ b/configs/socfpga_cyclone5_defconfig
>> @@ -12,6 +12,7 @@ CONFIG_DM_RESET=y
>>   CONFIG_SPL_STACK=0x0
>>   CONFIG_SPL_TEXT_BASE=0xFFFF0000
>>   CONFIG_TARGET_SOCFPGA_CYCLONE5_SOCDK=y
>> +CONFIG_SPL_FS_FAT=y
>>   CONFIG_TIMESTAMP=y
>>   CONFIG_FIT=y
>>   CONFIG_DISTRO_DEFAULTS=y
>> @@ -27,6 +28,7 @@ CONFIG_SPL_PAD_TO=0x10000
>>   CONFIG_SPL_NO_BSS_LIMIT=y
>>   # CONFIG_SPL_SHARES_INIT_SP_ADDR is not set
>>   CONFIG_SPL_HAVE_INIT_STACK=y
>> +# CONFIG_SPL_SYS_MMCSD_RAW_MODE is not set
>>   CONFIG_SPL_SPI_LOAD=y
>>   CONFIG_SYS_SPI_U_BOOT_OFFS=0x40000
>>   CONFIG_SYS_MAXARGS=32
> But what about other boards for the cycline5? If you want to switch,
> switch them all. This looks half-backed.


The changes only affect the Altera official Cyclone V devkit. Other 
partner and vendor boards may have different MMC layouts, so we are not 
touching those in this patch.

The motivation is to enable FAT filesystem support for SPL on the 
official devkit, which reduces OCRAM usage, aligns the MMC boot flow 
with our other devkits, and avoids the raw-mode issues introduced by 
recent changes (mentioned in your series patches).


Thanks

Tien Fong

