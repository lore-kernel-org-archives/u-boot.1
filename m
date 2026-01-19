Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724DCCCF2F2
	for <u-boot@archiver.kernel.org>; Mon, 19 Jan 2026 12:28:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CCE8083015;
	Mon, 19 Jan 2026 13:28:02 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nuBC8Y18";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7E66D8389A; Mon, 19 Jan 2026 13:28:02 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C2FFB80B98
 for <u-boot@lists.denx.de>; Mon, 19 Jan 2026 13:27:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KsJlGH0q1bQTu8xdPHR5AxMHJojlj8xMbKkFjQs7vKHXMRdGsy5WbrEky/wqNIMVzrT4ZFTXY41ASjjLVaUFFBd1+1Jx6hUx3LpIfkOH8qE3IInx5CHPHrBLK/o+zVv1wHuKawDkpJrk5TF3aqIoiI6hBq2EPUxwhprkQNQxse4v/fkz3G7C1ouoepAF1e83+vksaKFrLweBrkExQpjGzOk6P+vAr6V5glR8lspCBbHquwrT0qshFT2hEVZH3U7fmLReGYVxA4xqqnl9VYF3iymXUYvto2UywdGcVkiTp4C3SZH4Nwzc/fPvUXUGG1EBf7wo+zIRB1DicFYhGP+2TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vB8PjGdiNRsDLEGixAo0HypwKaBT/JvZvexQJZfydU0=;
 b=r0GJKVfZaBWuig/R9muled39r4ocJBNAgr/dXltOA5macQJfgtgfvlCqcobaqsY5cQkdGUKgjddaZOSJnh1Fb5iZHl+KoFfgFbkvOnHgEcVwidRiGzzDSpKaj1snzfN7La8E/9i3V277E+CD41X0fnHbvXtwohksAcE6QZKIGD3R8A01pcEgDqdLV/DNnOnPfgZGB35JsbdKDWPlgASNQSHGvEUUxW5qJPAiVeP4CmnLyLLZrHgJuan/62QbMUTtbCmXUeJ1IOvKm54frKIEfjI12IIMMXCe5CDVLHipIFGuTM/okfCYnnWeeQlT8MjbPejdhzYs4Zm44IPWtwoeww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vB8PjGdiNRsDLEGixAo0HypwKaBT/JvZvexQJZfydU0=;
 b=nuBC8Y18myrdcfxGRSKW9JPIGYjegZSjWcBvYI3cx5/bNDN2UYT55Ef0yoU7BXhXJUEqhgVKAYKM1um8tlTKPxwQIdrC7Sqx4LwcLvws49xG86GE/q40mtMwzYXYh4QKzcer76iFGliuOlZmBphnMo1g04r1mtpC1U7Fl0IW4jk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GV2PR04MB11328.eurprd04.prod.outlook.com (2603:10a6:150:2a2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Mon, 19 Jan
 2026 12:27:56 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 12:27:56 +0000
Message-ID: <f3bf1986-187c-405d-aafe-9e59ab14b3fc@cherry.de>
Date: Mon, 19 Jan 2026 13:27:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] doc: develop: process: Explain when/how Custodians
 may edit patches
To: Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Cc: E Shattow <e@freeshell.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>
References: <20260116182335.4081828-1-trini@konsulko.com>
 <20260116182335.4081828-4-trini@konsulko.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260116182335.4081828-4-trini@konsulko.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0292.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GV2PR04MB11328:EE_
X-MS-Office365-Filtering-Correlation-Id: 9710baa7-ddc6-4ba6-3980-08de57562cc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|376014|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVB2Y1F4azZIbmt6U0dNNW4vMzRsaGM2anNybXZsdTRqQjlPdERoZUNUd3dM?=
 =?utf-8?B?bDR3N2tEakRtd1NMSmErbTBuWHNQM3c2aEdYaWVEVy96bGN0WFRhcHRtVmJu?=
 =?utf-8?B?Rm1sbmMyQ0NGSWwwVjB1UFNFSmxteXVVSG1iMlhYeEFkYXFsZ2YzbHhjMFUv?=
 =?utf-8?B?YjY2S2RxNloxdXdGeS8wSVJsZ1hZbndjMkZWVmdWRUt2Qis2L0ppZlJPcHF2?=
 =?utf-8?B?dDFqcG1XVnU4aCtLek41Y3VtVzlYcUg5OVpiZnBNYXdnUVAyUHpHbFV5eENB?=
 =?utf-8?B?NEpNRUJMVlN2S2Z6OW9ZOE9CK3VGeHY3UjczTXJlMlpPb0owZC92eTZDK0dG?=
 =?utf-8?B?b2JhNXdNdUl2QXczMkxGWTNrZTIrNlpqczZzUTBPWExJeDdjY09PcldyOFBz?=
 =?utf-8?B?YkhDamIrOVRjeEpWUkd1VWRYdklvOGY2bEorejVNa04rZE10ME51L3pYTjNp?=
 =?utf-8?B?VERSa054NGozVVhNc1o1WlJ0aDMwWFE1dmt6SkZCMUdPMmZQdU9JMjQ0VDJu?=
 =?utf-8?B?QTZuNldwZnZxdGdGaVIvY3BBeTFoaisxeUtBcnZFekNLNlIyN2kvdjdQQTBS?=
 =?utf-8?B?REJhTXRpUm85TUVlcUxKbENzYUxGdmJkaGRjOGRDOW43bEt0d0FJUFdYR3px?=
 =?utf-8?B?UElDYVRaeENDbDEwWE9Bbm1PK0d0dFpzYWZqbjd0dWNvb2w2dHNmNTIrZGZI?=
 =?utf-8?B?Nmd1d3JiTGJlSUoxd0RMYnNPQ0hCUGhGeVFGcTBFV1pGMmtmRzNZNmJpaCti?=
 =?utf-8?B?emU0OVRTbnlHWEZGZVRpeE54YVJKOW5ra3l6ZXQwVUZXdHJ5K2R1WWlkcUJD?=
 =?utf-8?B?ZzMzOEsxV2hVQzQzSjlJckdCbWtwaEFoSFR2OTlIRzdkeEpjd3ZkMTJVc1Bj?=
 =?utf-8?B?UlVIMHZ6M1RTUGUraXpwMnB6c1ZzNzMwWE9kWWptalJPYTRWc0lEanMrZS9O?=
 =?utf-8?B?ZC8reVNKWEYzdDdOczFNRlFmSGRCTFRWR2pTYXFwYXp0QlArNldlSFRlaEhC?=
 =?utf-8?B?clRWdEdvMGtUL2V5Q29sUlNVbXJFUTJpQkVrSkxwLzBNTlhTNjRLMEZSdnNV?=
 =?utf-8?B?Tjh0eStTZUxsSUtuaHJOVFpzVFhyZ0RabGUycFBpS3pyQXpXaVplbUVjMHUr?=
 =?utf-8?B?SzluUEFyTnVmaGZKTWhGOHorNSs0eUFiVDhVUG5qczdxZFhyb3ZrbktxaEtR?=
 =?utf-8?B?NTF2VkROSithdHB4MnhwS280QXNpTU0zWVJTYWF3ZmJNMGl6ZjhITFVFam56?=
 =?utf-8?B?Um1WRXVpblNTbHZpajFsVmZTcVlHL0Y2NFVCcXNCcjFnRkxMeEdJQ1RSQ2gy?=
 =?utf-8?B?bzIxTlBFWE90OEttRk5OZmdCcFJzN0N3V0k5emNoTnMycGJiQ0FLRTBrMXFN?=
 =?utf-8?B?T1loczRYdTFvTWlJcmRSY2UvRDRlS0NJQ3VDMnhQVDI1SDZKU09tTWFXZ3Vn?=
 =?utf-8?B?QXFSWGp6MXhGblNtT1VpTGZXWEFwUXFGZlJzTFBlQ29tKzNrZFoyWTl0NG5L?=
 =?utf-8?B?SVIrRS90aGM1WUFJZmJmTkkxSXg1MGFxc3BmMmgrZ2Vua2g2NkVXaDV2dHFr?=
 =?utf-8?B?bDNvTlU1eExiN0VMckFjTW5wMmNicUJWL0dTa1dvMVR1M0xBNTBEQzJoMjV0?=
 =?utf-8?B?allIaVJUNG9XT0xmNE0zWDh1di9FSkRvVk1EWTRQN1JLT2hwdTY4M0FWSUVF?=
 =?utf-8?B?U1FvSVJMNHlFR0twNi85OVZ0eS80M2dHbTQzalJKTnhEek1MZkdrb285Nnh6?=
 =?utf-8?B?RTZDMHdXVTRmSHRTTll2WUpBZlFPSHRaMEIvQTdQeGt2dTZtaUZ0dC9CMnNm?=
 =?utf-8?B?cm4zTkU3c1hWOU1ybWRBeVRuRkljcm1QUmUrbzNvNkdoWjIzTFg0NDBmdUdN?=
 =?utf-8?B?R3MyRmdyN01PTWNjbTY1aWdFMXN5RGQ5MGJXSUdiaDdNRjhxR0xXWFBsb2xY?=
 =?utf-8?B?M1lCU04rOE5vdk94ejY1Q3JlMEswZkdFM0xYcko4SThQMUhTaDBjQ3FCTkU1?=
 =?utf-8?B?WVlnM3Q2em8wZFlSQkFFWHNLbFNTQ1c1OXA3eXlaVys2ZHQ4Rk9hdTEySys5?=
 =?utf-8?B?R2hFN09xT3VUbkdDWFhNcEZ0Mm5YcERtVEtpcllyN1lXRVRVSDlHMVJjaTdm?=
 =?utf-8?Q?VFdU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(376014)(1800799024)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3gwQzlEcmhyNHlvZ05DNDNrS2NQOGI3OGJUcFZsOXBOTVU4SHpGazJOTHNa?=
 =?utf-8?B?MFFIM1ZBN3dtdVFPa0hQcHZXbUExMWcza3RHdWxJQ0cxSVQvdWIzUnJiUXVw?=
 =?utf-8?B?elR2alZDN3VsQjJhaFVOSFJnUVlvMFYwaDBqUS9JNFpYUllMQjlNNG5lM1hH?=
 =?utf-8?B?YXF3a21wTi9sZFVXYnQ4VzduajBZSElHYmZ6WnlMYllpZVBjcFJSeFA5RFk3?=
 =?utf-8?B?Vm1nSUdOTnd3a3RrOVc2dlgyQVd0RVZRWUx1YnB0YWpveVFvdFdMc0FocElJ?=
 =?utf-8?B?cExRLzMvaktmNHhPUnNxRlRKYzE4QzU0bENtcGdHdlhzWEtGTTk0ME9zR09Y?=
 =?utf-8?B?Rm9rL2RHc3FiUER6M1JVM0s0b2xFYlQ3L1VldEM4N0UzeVFua0xBUWFKOFdv?=
 =?utf-8?B?SWxxK0NwVzNsRzU0S2hPbnpIS3daV3lKbkVXZ2VlLzJrMkpkK0hPQmdubVR5?=
 =?utf-8?B?cGRlQWp6RzhMSU5Yc2EvQWRueFVwUitQS1FlbmRXOEVGcDhDUTBabURIN0VZ?=
 =?utf-8?B?L0l4RE55RkJ0NjNuUFJPdWVzeFRPempPVmtpYStIR1B5akltUDF2cThhRXhF?=
 =?utf-8?B?T1J2QjZ3V041WGxPN2Z5a3NTQVFYTXVIZVQ5M1oyVWlvb3ErMG8zVkllYXpr?=
 =?utf-8?B?N1FLWHB4Q2d5MC9YQlNtZ1BxVG94SlJzSDFQRnR5NklXTlJMTGFXOFhwcWo2?=
 =?utf-8?B?VVhhYUtieDdvQmh0cHJsczkySWV3U2xUWDh2ZG16K0lKUnFPTzBpdnF3akll?=
 =?utf-8?B?WEx0c3h4eGFSS29zZDIvQ2tnRU9ScUhuMXVEejRqQzVvcXEwa3RUR3pVTE1h?=
 =?utf-8?B?NWVyMWo3a2xqbUVjaHdVbVhIcnlqMnpkL3VqRlZnaTlLZW40bm9BWTROZFF2?=
 =?utf-8?B?MzB6ZzBTOTRTSzM1aExhcE1BRWVmRnhPZFNhclFYRElyVDllTjhPOGlHTjY3?=
 =?utf-8?B?UitQalNTS3NkaXJyVElzRENFTDFpV2RQK3ZSdFU0cGMvaUE3RDM2K2lEQ1Q5?=
 =?utf-8?B?Y0Nack9zQ3lScW4zY1BlMWhxaGdtdkdSd3k1ME5rVmJkQk1nVk1YTmZtSVFS?=
 =?utf-8?B?UnB2R21KN0FDeHdjZ3BNeFNEU3laNExVclFNSjRaa0d5eFU4YWhIaUN1Ly9m?=
 =?utf-8?B?cmlkVWdWYyt3ekdBYlR3L040MnZseFJYOG5lYXJURVlmZVZKa1hIOTk3Q2h5?=
 =?utf-8?B?SWJTbDdqTWNZTG0rR1lZSmJqZFhSSE42WlRTdUhtNzF4ZXlJcWtlNEF6YVgr?=
 =?utf-8?B?c2lwUk12Zm1oQS8rTjBnSTdVQkVORlJhYVRrbFJPU2F6UXpwa0tKT1EyM2dx?=
 =?utf-8?B?NjBkQkgxODVxOGZSNUlqQUhNUll4Y1lpVTBYUUpRRFhFMHlwbTd4TmI1RHZh?=
 =?utf-8?B?WWZ2d2JkNU16T3ExOGVwYU1CZytpM2hjNGlkbnhKRXRVTkQ0azQ4NnpGUHp5?=
 =?utf-8?B?cVluY1YxdDMwS1FaN3dQVmoycC9qYWxNb2Z5YTRTYThaRzlWRHlKdTE0eFpO?=
 =?utf-8?B?aFB5YTJHWjVhTDJGbGNHQjk1QUFWaUMvTGw2Uk5JTkp0RlhVUDZtalRWNTJP?=
 =?utf-8?B?ZnZwYWIwYU5QMXNPWkZPb2dMTHNVZkpEdXdOMzBWeS85THVFa1R5V1hIWGx2?=
 =?utf-8?B?L3JRM0krL0JJczBuSkJPU3ZZdEJXRTZDbFpkbnRpem9ESmYxYXhldDF4YWxs?=
 =?utf-8?B?Vk12T0NSeVBkUGNNVjdKaHBwQzhuMUs2aDhORnpTSjRXOTdxNnFNQXhZT1ZX?=
 =?utf-8?B?OER0WVQvQnRJRTZ1SkhUalBYWVgzZUhyUWJNd3F1SGZTdDNER2pzQ0laSTVY?=
 =?utf-8?B?Q1VSc1Fja0NlNHpCZXJKT1BBQ3hpR3ZTdzc1WGJ0Uys3Ky9aRUZMWURUcFpU?=
 =?utf-8?B?eFh1ZmFrTGo3ZTN6ZU83elpwYTBKTWpMREpCUjlQR3pHOXUyN1dncVZhOC9Y?=
 =?utf-8?B?Q3ZkSk92N2lIQURuSGNoSDBOYXRqUWx5VnpuOVJBazJBSVA0ODdTK2VoMG1D?=
 =?utf-8?B?dXJaRE4vMXBRbllMT2dKK3ROVVhWaFkxWjNKK3FKUUlOb3VNUis1b1BKdFhs?=
 =?utf-8?B?SkVpOVhvSDRqMmRCb3FTV0FSVkdJUy9OcWN6Ukk5bWI3cTVQSUNSYy9aMzBU?=
 =?utf-8?B?SjNXYXRVWnFJYWliNnRZdEhMSG9relJqRXNVOU5yaU1lSWhZa2RCdC85dXND?=
 =?utf-8?B?Qy9RdEV4ZXloQi9RYTJhNU0rcU9rSUJNZTFoaWQwU0s1OTQ2Ly9NQWxYQXdY?=
 =?utf-8?B?TnRVT0RDajhMSjAvUXg1L1Q4cm5ycGtrSnlZT29XQk5PUDlUSUpjcEkwbytx?=
 =?utf-8?B?Zk5PbkpMRWpJbC9BbUJpQVV1REFZd1B6a0Z3cyt3VmlkWkdIM0czZnV0ZXR4?=
 =?utf-8?Q?LRKE8dx/ikLRG0oX9shW1/FhZFMMlfqJbyYG5?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 9710baa7-ddc6-4ba6-3980-08de57562cc9
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 12:27:56.4230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +ZjdWl/NVVe6n9R4jEX6gyMrHdfOcspEIj4QOZhCQ+XxtNozcncTYGhsAZ7GCAnrDLWT83Iuzs4xultTGP41D5wIZU6J5DcHBbdvIL2EWxs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11328
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

Hi Tom,

On 1/16/26 7:16 PM, Tom Rini wrote:
> As seen with commit d503633a3676 ("Revert "doc: board: starfive: update
> jh7110 common description""), it has not always been clear what is and
> isn't allowed by custodians, and what the expectations are. To prevent
> further unintentional conflicts, document the limited cases where
> custodians are allowed to modify patches directly, and how to do that.
> 
> Signed-off-by: Tom Rini <trini@konsulko.com>
> ---
> Changes in v2:
> - New patch.
> ---
>   doc/develop/process.rst | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/doc/develop/process.rst b/doc/develop/process.rst
> index 6f5bdd3db957..775a855fd7a0 100644
> --- a/doc/develop/process.rst
> +++ b/doc/develop/process.rst
> @@ -144,6 +144,12 @@ feedback to the submitter of a patch about what is going on:
>       feels it has been too long since posting their patch and not
>       received any feedback, it is OK to follow-up and ask.
>   
> +    * A custodian may make spelling corrections, spacing fixes and other
> +      obviously correct trivial changes. They must also in turn amend

I guess people will have a different interpretation as to *what* is an 
"obviously correct trivial change", based on the U-Boot git history, are 
there some commits that used the [] + SoB form that are fine or 
shouldn't have be made such that we can elaborate a bit more?

I think providing an example would be nice, e.g. the patch as on the 
mailing list and after being merged with changes (obviously one you 
think followed the rules here). This will make the section longer for 
sure but it'll be a visual cue that this is important.

I would suggest to require the custodian to notify as answer to the 
original patch if any change was made when merging the patch, even if 
the changes match the allowed list of changes listed above. What do you 
think?

Cheers,
Quentin
