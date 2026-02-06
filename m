Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1F5EEE2084
	for <u-boot@archiver.kernel.org>; Fri,  6 Feb 2026 11:32:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B7E39836D3;
	Fri,  6 Feb 2026 12:32:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="ZY4ySr3A";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DC929838FA; Fri,  6 Feb 2026 12:32:01 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5A04B8352B
 for <u-boot@lists.denx.de>; Fri,  6 Feb 2026 12:31:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VKsxETplW3fC4M1ZlS0ViMToMYnmwwR4y2/JBCIMwEumY2kQyJ02u7EGPc0FS5hvHAF0NW2HOnmyMkD9rJ3p3xUrOLjAcnjRglYC3IZynrjaOkmPGQ1z33nA0Pd1JmBamIJQw7M535C5wWxaL2n4XTGoE737TR4MhxJlHSewjteQb2Hlfrx2K13Or/FJUQB6KZhAdtK+UnputfaYjPas31ZWedozfnleo8FcZTXmmh6FTxOFCF2oItun9s8EWt9oceCHViymg9RFmtZ7zj1D6jgP2ubxyVjDHS2pZq2e9Qaf8bwVURz1ry7jGCjDBhbOFivBzPdHO+cowUfXPUxKcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/aDVRl400VD5HuCDhtVuxgQM4QMeP2tFT4ut5U2jG30=;
 b=oPzqs6RWWOKpHuoSwipoEo9WnjJXq8qkui3dYuI4aoWXvCN+jnZRM56hQgI2RyRPTt5BXfSWOQ/11gJD0tOCD7xHX5AUVhJqy+gytB4967Qm0mhgND54lCpZuxALwb0r2mr4Uml4ubhQi5RbIwPczSeHmHDnnAnJQVGPPFZZ2MxxU5BFcyUkTwQ8opXUR4VfiWFhySKMjNei2+bZCzyZLo6DEJ1jCxRyJATL+4zuCmhJDxSPZq7kjAVvJHzBi/l+7f7IwmAsmdWFLuP9ySsz9cXVd0JuxXUlx2YCD2S0b6E4wSr5rDGdnsbx/i/Vb7Ro++2uQWyskdQFxJCQdC61Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/aDVRl400VD5HuCDhtVuxgQM4QMeP2tFT4ut5U2jG30=;
 b=ZY4ySr3ABzI6qMrlnXnsBkRXafQEvMzUczpHjb8S1mqaJUCir7FRWMxeMaHbFsCDoDzrFjQbIKxRJZ1l5+owLlDEI/O271kZAy6gqqTs0tO/KKzfQMad57siuPs/UbI8ZYl/cTt15yQ4S1hHHkmMvS4IxuM+eyleUMYRXbPlmWM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by MRWPR04MB12278.eurprd04.prod.outlook.com (2603:10a6:501:88::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.15; Fri, 6 Feb
 2026 11:31:55 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 11:31:55 +0000
Message-ID: <3fc12168-7c48-45e0-986a-79acd9dffeb5@cherry.de>
Date: Fri, 6 Feb 2026 12:31:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add a build time parameter to accept custom signing
 key
To: T Pratham <t-pratham@ti.com>, u-boot@lists.denx.de
Cc: Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Shiva Tripathi <s-tripathi1@ti.com>, Vishal Mahaveer <vishalm@ti.com>,
 Praneeth Bajjuri <praneeth@ti.com>, Andrew Davis <afd@ti.com>,
 Ryan Eatmon <reatmon@ti.com>, Neha Francis <n-francis@ti.com>,
 Anshul Dalal <anshuld@ti.com>
References: <20260206110439.1236201-1-t-pratham@ti.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260206110439.1236201-1-t-pratham@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::10) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|MRWPR04MB12278:EE_
X-MS-Office365-Filtering-Correlation-Id: fd8a7a29-bed5-4ad4-0d35-08de657354a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|7416014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a05PQk50Q2Y2ZkNqYXdFMjFFWTZBRHJINW1WWjVCR0RBVzFRMEdUVWNEbWNM?=
 =?utf-8?B?YWMyblVtbUxhV1FFQXBUOFNLZHBTVTMwUnZUc1kzdjVSZTJkNWlLZG9ZKzVp?=
 =?utf-8?B?elBieldlMVJISXVNRWJhd1NCOVVjN09zbHVpRkhwYWZNczJ0OWdBSExFS1gy?=
 =?utf-8?B?Q0ZwdndoSWRZd2d6TGppZ2o5RzVjc3psb1hzWWVvU3J6ajFDbisrL25FZExq?=
 =?utf-8?B?TDJacHM4bXc4eDBtNmdsQ0NPbjVUdVpQNTIxUGxDY2QrVzl3K01iV3JOaDli?=
 =?utf-8?B?ZEYwcFlOMUxJaGIvNWJQcU1ObGJabUt3UXFSUGN4a1pKNFdyeFdjNVhPUTdE?=
 =?utf-8?B?RUlnd1ZkSzBsQWxSVktnc0R4R3lERGF0eXE3alJub0lqOGFpSTdMMXhhK2I0?=
 =?utf-8?B?SzZUUVZabnFyM2U0SHNMZ3BOUXJ0bWJPZFA3Wnd0Qjg2YTdOYVNPZzVkYmVj?=
 =?utf-8?B?VjlsNW5ub1VJZXg5a1ZZaHNlUWR2cnR3dm5tR0NnV1lsSEMzT2NueHlBWTl2?=
 =?utf-8?B?OVFMODR5OWVXWUt3OWVtdzFRc0JRM2xvM1EvbCttMVZhTkFTanp3RTNrMEkw?=
 =?utf-8?B?UXcyRUlQZGlrdFhzd2lCelA1Tk80VERkSjEvdGI0U2ZqZU5pc1RSd0Z3SHpF?=
 =?utf-8?B?WUsxeS84bHU2RGJpMWFNdk1Ra0k2Uko2SklnUWZpbFh0RlVmenFCRTJGWGlG?=
 =?utf-8?B?WXRBUEEwSlFreXRzU1lhWGpXOTFzamxicjZQZWw4dVZZOWRIQ2Z2Sm04OElB?=
 =?utf-8?B?YzRheGFnSlU3Y1I3Qm1oa0M3eTl4czdtQ1hpcHlSSEZIM0pzYlhoMkk5cnpP?=
 =?utf-8?B?bGFMQ2swelg2cHlDMmY4UGhOZUFCc0NCVXkyMFBKV1hzQmpmTW5ZcUFML0hN?=
 =?utf-8?B?YVVIa0o2cDRiRk5uYlBmblk2aUREN2Fqc0VQbDllMmwzNU5IY0J4dlBROUpl?=
 =?utf-8?B?MEd0d1drZXRKUHoxN3QvUE1oZ2Q1N3p5MGR3czN1UmNUb3JpZlJQOHppcjJE?=
 =?utf-8?B?M2dXQzVnOFMrWWgrMk96OHNmdHFnR0loZ3d4SXhJOGhuWUlZMTdvQ1FKRlFE?=
 =?utf-8?B?OTlzdHlyZjJQbFF6NHJMWlVxU2VVTTg4a05vL1ZkWXNmam9zbFpWSTNDOHhs?=
 =?utf-8?B?MjJvMmczSURRRGtST0lHbFR1c0xhTFFHN3VyWjRVOFNZMW55b0RsV0VWQVNq?=
 =?utf-8?B?RDdIcGMwSThxVDcvdmt6RUlCRFh0a09INERmRFQ0VGtTMTlnQWZ0aVpGVlNW?=
 =?utf-8?B?VmxyNkRiNFpvKzBFcnJWeUtKR1V6a0F4WDcyaklqN2pDY0RIQVV2SjVOVllD?=
 =?utf-8?B?dDQ2TWF2eVZNU3Yzd0NwOTN1RHR0bTZEY2pCTTZKdlNFajlBeE9HajJqaHNF?=
 =?utf-8?B?cis0dlpmQWh1SGRqM21iWkJJMFZQOTVUVjkvMC9LWjZrekk3d01HcXR1SkJo?=
 =?utf-8?B?ODcxS2hQRGp4ZTNPb0ltRTV0M29KY2tBL2d4djUvS1R4TTMxY1FnQlZCM3o4?=
 =?utf-8?B?SjcrYVRzM0hQZHJLRXpHNmJpOTJJdXVaMkRzWmNRMC9DbG1HbTczUkxJQnRK?=
 =?utf-8?B?cXJCQVFoNWxONUx0Y1NYUjFjaEJySGo1K0tsQlB2empQRWY3dTd1RUJkNE5N?=
 =?utf-8?B?aVdsK3pZcWlZdFdQTCswWUpzS0RMTXExS1RmZXlSZXVhSzU3eG5EbmpEc1Ay?=
 =?utf-8?B?RmJqYlhBOW9IazdvWHc2alZaMDdxTnQ4cld0WDc0QlgyWEJKeXZLWElWN3lR?=
 =?utf-8?B?V2cvTVJaU0xaTzc1cVBYL09yR1h5Tm0xKzBIUnBzUTNBdThnSHJrRHNQRC9v?=
 =?utf-8?B?SW10ajdvYXc3ZHRxc0xzR09HVlNNR3NpdFdUQ3hQbGI2ZEY3TWxjdVIwcEN5?=
 =?utf-8?B?eFNZTlFWU0FHczY5OUVoV3lOSnVqb3JPQXhTeWNpb250ejhZZzloaTdqaEw4?=
 =?utf-8?B?czBsWjE5YnVUSzFLMWowZC81RlVjVnMxdW42U1lzRkRCVHpadkxOcCs4N2VZ?=
 =?utf-8?B?amcxV052MkxWNmlHWERRUHFYanNDeld3ZCtWcW9HMDZ3eDkrRHd3NlBReHlz?=
 =?utf-8?B?T0grakhobUREbEk2Z1lYN0tXd0pzd005U0NNNmcvY0xCczVoUDdZcXRWcWEv?=
 =?utf-8?Q?SMi8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEd4MFZoU0JaRkpHS2VCS1BwdGZ2UkhoUU01alh4a1N2ZS9wdTlTUlE5STRT?=
 =?utf-8?B?S0JwN0E1NStQdSt1QWRabDNQWG5GVE5SZnhaR1V5a1BYZDBFK1l2djRZNWln?=
 =?utf-8?B?ZXE4WmJ5b3pvMUhnOWxQdG5HZmJHNmtzdmlRTmROV3hmSHBITVJlcTFQSWNO?=
 =?utf-8?B?ODVqT2VmNzVocjI1NHNFc1hxSFBFL1h1T2hJVzcvTUpXTENOYklXcEVTeXNr?=
 =?utf-8?B?bStqT3BkcjRuUUxUV3FGVkZDV1VmZzRIcnVJckFaQ2h0QVJFa2x6L1RxTm10?=
 =?utf-8?B?Vm9IZ2cwcDQwZzBHSk1wQnlNZzI3SUV0WmROeWRBTkdDU3JBbGlBQ1VxT0k2?=
 =?utf-8?B?RXFGSXdqTXlwanJiaUs3b0xoNVcxM3FUenM1ZFhqcTBwSHdaWFMxYjhNVE81?=
 =?utf-8?B?c09LWHdkTkdhbEJWTkU2T1VPWjJSUFFLZXVsVmhva3VTa0gvMmtub1A3TDNL?=
 =?utf-8?B?dGZXZXMwVEhoR29HSTdvUGpEV1MxM0JhdHNlMk5pZHhFckVNT2lMVGMyZjFv?=
 =?utf-8?B?SzJDbTE4cW1hS3R6WXA1NGVRZVJvSDB2R2lyaERFdVBlYXZuZmd1ZmoyRTUw?=
 =?utf-8?B?UmRUYVN4eHdST0ZRekVBZEJwb2x0WGtadHVWU3JPRHhVYzNVcmVvWk1kT1Rm?=
 =?utf-8?B?L3ZDUWt3RWI4cXRDWmZzR2xYYUMreG9yRkRHcUwyU3RQN0Q1ZFZCSittWTFv?=
 =?utf-8?B?cmZPaXI3WGRmSTE1dFB2Z29NM2xXTkMzY09GOGNZVUtoeGhIT2E5K3hXWGVp?=
 =?utf-8?B?RDkwWmdzcisvaE93N1lTUFlnTVZ1bTk5eC9BTVlabnpWVk1BRWJ0ZjlMOFNX?=
 =?utf-8?B?SGY3d0pOT3JESDdLVEhXcitaZDZEYXdxZDR1M3d1UlNkdTZLTjBHK2lsek9m?=
 =?utf-8?B?c0RWYWRMT1lDWnFsdjJPekk0ZHdERTFhQmNSTzFTQWJQUmhWS2MvRUJ4WVZ5?=
 =?utf-8?B?ekhtVU40MTlGdm1uem80c0Rqb05CZVJYYllDdjJlSTV5U3JmeWZoam0zTENH?=
 =?utf-8?B?ZjZ2c2VyR24ydDljSkV3OFZrbEIybGx3akQvaGFaY0ZHWThPb3J5Wm9BN3Zp?=
 =?utf-8?B?ZGE3Y2t0Um5vdkw3SUhOOWRzS2wzeW9aTklOZFBVbUR3KzBCYVdMb21lMVln?=
 =?utf-8?B?czRaN0NDMnhpZFFjbW5rR0JuanRyU1YrTlFxS1ZFNGRkNUVVcWFyNTlmRWk3?=
 =?utf-8?B?N0hxdTg3ZXFIT09xQWNGOGg1ak1jSlp2SmtHWFZnMTkxdEpjdXRoajRPWWlj?=
 =?utf-8?B?cWpjUjMzV2xDbWhZQzQ3MGR3b01mWEYyd0FHTVRhWWhEckNYTTFpU05UcWJE?=
 =?utf-8?B?SVljUFZpNGxVcG9pY1M3SEZLYWhiRlVaQ3h0TEhnVXRQbThQcUZvTDc2Qjlk?=
 =?utf-8?B?a0N1V3NlNlVLOWJaT29sd1JoVnFpdUR3eUpuSEpjV2NPRXhjZTQ2OFliZENh?=
 =?utf-8?B?WmNUVFFYU214dHo4czUxVUI0SStqVVA3cGZTNkJyaGRlUC9OZGE5ckdQMjF1?=
 =?utf-8?B?c3FCRjNmNEFGYlhaVzRBNHlYbndjS1NBc1lmaVNTR01oL3NCZmtoMWt5QVJY?=
 =?utf-8?B?TUE1V3hiRzViQXNrcjA3d1JXbDRucXBZL2Faa1NaV2ROWnZsWm9ucWt3aE9o?=
 =?utf-8?B?K201cmxGaGlycVp4b0JtVnc0Rm9SUVBERU1rd2JoREN6MnFvUG5QVUdqMFZa?=
 =?utf-8?B?ZTFCd0xGVUlndlI4N3dCN1lQZTNaR2F3Mm1uN1lQcldPV3p4NFlKQXE3Ym01?=
 =?utf-8?B?eGlFdmltb1lFeDY4QzA5aUk3N25sb1RhRHM5Lzh4bkN2Smo3dCtWbGdsZUN6?=
 =?utf-8?B?NGlLWTFkQjFsY1I2Rzc0c2ZVTURYMGE3clNZOGdlK3c0ajZoeWNteU5NYkhZ?=
 =?utf-8?B?SEZ6K1VSWjRXOEdHTEwyY3R0WVZtVUl2TStzT2VIYXJ6TWVBclZLUDh6Z0o5?=
 =?utf-8?B?MjhwVFJLalFvSWtRbC9pVmFCZGxLTmxKRUk3T2hSTG8vMlFqdk5VNHlqcFJp?=
 =?utf-8?B?ZXFzSVQvaWVYQTdzRVMwdXBOdSszTW95SFg4a3JBTXluQ2RsSW91WHFOeERX?=
 =?utf-8?B?RWRVUWlaWVlLSlRwVFBWRCthbFN1S3I2TlRZYVBKbUZWTDBjdzFwSXV4RW94?=
 =?utf-8?B?bkVpMXc5VnlhS3kzRUIrWXd0d1puNk9VQ3p3ZHM3SDAzcXgrbnNjbEdJVUdI?=
 =?utf-8?B?NHVZWEdFOGsxalZCaklaQmxQVFVvU2ZsNFU0WUxOV1pVTExZN2l0Yzg0T0pO?=
 =?utf-8?B?ZENVN09UQ28yWCswV1d6dEwzM0NJbWJWK2tTam5naGtyRWdMQzNxZktGbzgw?=
 =?utf-8?B?TFJqZllndFBxdzMrcjRPQ3A5eGc1eVVQZ3BaTys3MTl3Qyt6SWNxVUdmM09k?=
 =?utf-8?Q?ueMatdUNca77fx4Wf477ZZ2aTMYFaRAVn+3k5?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8a7a29-bed5-4ad4-0d35-08de657354a0
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 11:31:54.9937 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LWsAdTn9EuNimpubQZLLm+e2/zapUnxNHPuL7ctM75nCZ5EDNHwEIpdsI+hDl+E/BkaHJsoy0AMd9MPEU5pReYbKMMb5pILl/iMwuXFC+Qo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR04MB12278
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

Hi T,

On 2/6/26 12:04 PM, T Pratham wrote:
> [You don't often get email from t-pratham@ti.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> This series adds support to use a custom key provided via Make during
> build for signing the bootloader binaries, and updates the k3-binman to
> use it.
> 

Can't you use the same mechanism we have for adding the pubkey to the 
SPL DTB (see tools/binman/etype/u_boot_spl_pubkey_dtb.py)?

We use key-name-hint property which is a key filename without the .crt 
extension, you don't necessarily need to reuse this (but I think it 
makes sense) but sharing the logic for finding the key seems more 
interesting to me.

We try to find the key with tools.get_input_filename(self._key_name_hint 
+ ".crt"). The paths that are traversed can be specified with 
BINMAN_INDIRS. This should help with not having to add yet another 
variable. Set allow_missing to True and if it returns None, then use the 
key listed in the filename property?

Also, is there really a need for separate binman image just for keys? 
Can't you have ti-secure/ti-secure-rom use key-name-hint directly to 
avoid yet another binman entry?

Cheers,
Quentin
