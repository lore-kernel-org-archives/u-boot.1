Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BD6CCCD193
	for <u-boot@archiver.kernel.org>; Thu, 23 Oct 2025 07:17:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CA9BC8334F;
	Thu, 23 Oct 2025 09:17:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="G2iEuZYy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5280F835B0; Thu, 23 Oct 2025 09:17:16 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c007::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 233518323A
 for <u-boot@lists.denx.de>; Thu, 23 Oct 2025 09:17:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tanmay.kathpalia@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulG4AvTAqlXffGKvBa1F/7dSdHx1kPKU9OYmRl4kgjxuswUqtJJldF2akZHuqBQAuwsddLnWA36y3LwtBrpU1UJUxcgerjth6m7NmzvobUv2y3F2rGoxbYUfE0DPbKvrv5mnfNT9v+gbvytHOXNGA3GggRJgIHAR3A11ljXQmoJbJ57LDEQ38GBeHqFhIjK5aZOCWE26grJjZ0KYS2dky0ic/9fea5mJU/5jZxN2bEUpX2WeYg6W0BZR7T+PDS3Ctk2nZ0LwxpBJTclaNkZam6POVx/zw4ncvT7QgjSAEEP27hvYOu8RgD0ZVpsPMmk4ajDFCyatKF7h8x1gZ+YyyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2JIkXSMgUn621Bb5fyOuZp/q9qTsmYB5VXg616hcb0=;
 b=kt0oteVgOKmKc47DysFQDVGZ6IDi1MU2F5DiyKsFnAWdFMZWNdq6j2EZC4EY2d6xUpAiDVDeMGoZod9P/tXjbu3fTDpf9PebAooAZSFCsUOo9BqW2c0fmNGRWIkacCQOG7JgX1nc6rNKSIJSj6+TKd86AbVMR9exDPQXQhvVZjVV4LoopBC+0zY1fbHkuA0q+VP27o+FGuGNuCc4GmP2qaCFvtG8lKIaCnm5YDbWY6S/8huEcN8l0qr/cTl961yQ6nyhgOs5+dXr6jhLKX1cep7hCHYLHX7FCbxDVaBCKLaB8+1vnbPbipCHyT6v8B3BYDl1m1tNimemwcYDTOPAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2JIkXSMgUn621Bb5fyOuZp/q9qTsmYB5VXg616hcb0=;
 b=G2iEuZYyuPXqKieVz1fi225D1s/0dPYPy6fklx+xwIF4BxShxlnFmttH+mAWZyx9Dns+DqK+JaxefXie22yABbhNtyXG6CLICzKMGdGtMn4LRoyGaGe7enWq+32/uwDybZu1Nmy6WY46RfGfJnlju0oHpUba/q/hJ7QfeNQNtGzJJej7JBh8bRI75R+lvag75Hh3Vrp3gM+dDhUwVLeyG56QS1htzGKe3kCh00y/NnzcKMRWeSQqoI1oqP7Ve6VbTf0ddy8J2bkkGMyIADHettDV6uW/IPeGbUPtnvEqncWf/vW+waNaTNHrxpmANMWC/+wb3LG/wxXiGMOGqrsN2g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from DM4PR03MB6208.namprd03.prod.outlook.com (2603:10b6:5:39c::19)
 by DS0PR03MB7774.namprd03.prod.outlook.com (2603:10b6:8:1f9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 07:17:10 +0000
Received: from DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844]) by DM4PR03MB6208.namprd03.prod.outlook.com
 ([fe80::6735:e440:e9a1:e844%3]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:17:10 +0000
Message-ID: <73d9ad0c-08b1-48c9-b890-5f1acd560994@altera.com>
Date: Thu, 23 Oct 2025 12:47:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420 version
 defines
To: Peng Fan <peng.fan@nxp.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Cc: "jh80.chung@samsung.com" <jh80.chung@samsung.com>,
 "trini@konsulko.com" <trini@konsulko.com>, "marex@denx.de" <marex@denx.de>,
 "tien.fong.chee@altera.com" <tien.fong.chee@altera.com>
References: <20251023060614.6441-1-tanmay.kathpalia@altera.com>
 <PAXPR04MB8459DA42188F3B88E21C007588F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
In-Reply-To: <PAXPR04MB8459DA42188F3B88E21C007588F0A@PAXPR04MB8459.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0245.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ae::7) To DM4PR03MB6208.namprd03.prod.outlook.com
 (2603:10b6:5:39c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR03MB6208:EE_|DS0PR03MB7774:EE_
X-MS-Office365-Filtering-Correlation-Id: 54ce8b3b-85ab-48d5-4bda-08de12042e7a
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWVuWThpRDJCRWRUUVFMSWtNMHAvT0ptVDBLcVQ4UmNUZTdSWjJ2UFFDZkNl?=
 =?utf-8?B?S2kvV2g1UGE4SnZkeGhUMEh4eWpuMGt6bDMwNkpvYTBPeE1Xb05wbHFJZE1J?=
 =?utf-8?B?UXpSUFE3N2dxZitGbk5xaFRvZUYwREVCWlladzhHU2NoQTNRdC9DV1RaZ2tZ?=
 =?utf-8?B?VXBMamlkc1V5cFdiZmpCNEtRUjdmemFIKzl0c0hacTJmR0hTMmUrdlJyZS94?=
 =?utf-8?B?aW8vYWIrbjBvRE1ZTlA5cERVTHZUT0orUmt3dmNmaGNVZzNPNDlsS2R1MFp0?=
 =?utf-8?B?UjRtRHQ2VHpubkNZNkJVS3MwaDh4dHErdXJHSjcxU3B0cWFHSUdpNXN3Tm93?=
 =?utf-8?B?RVczdHZseWFGR09ibDdObURlMFlvR3RpMHNqeWVMNEhFblZnTkU1MlFkSTNw?=
 =?utf-8?B?dTNqanB6cmZ2dmxDMlRLQkFrb3MwY0k3Zllpc0VqWmpEVHJsZUZYaWVRUExx?=
 =?utf-8?B?UERIcDM3czUrWHdVeWkrL005TDlBdGlvOFFhL2ZmNUczbVpDYk9iM1I5bVNM?=
 =?utf-8?B?dXVJa1NOa3ZTRmd0WXlqSFRNOWR3SkxBS045anQ0bkNTc2tYNUR4dWRCVHY3?=
 =?utf-8?B?SnVIUC9HbXA1dWF0WVh2VjZlRENNT1Jld3czQmhHZkFxQk5hbFlQV3lpSW50?=
 =?utf-8?B?dndpbzZ3UE1YS0RZbTl6a3JDTzB1TkFkWERrbXVBK2IyRGJkZ1FreUwzWC9m?=
 =?utf-8?B?Rk9MVnB1ckgvaUg4Y1FyeXZISUo2VVNPSWM5TEE3RHgrQU5EeFlIKzI4d3lT?=
 =?utf-8?B?VDd1cm5GUTRYMjU0TWtUM2N1eWhBeVljc3BUK09meGZYalg2YjV3Z0xmQ1Fk?=
 =?utf-8?B?UVliTTZDc2xERTFHcHd1K2NXNUZpcTlNRTEwWkNRMnhrZEFQdmJlZGdVeTdq?=
 =?utf-8?B?R1hpdDZxTUlPRmUzZFlWYUpSbUdZL3NZZUZoTHczL2V3eUc1STVMTlU3QmN2?=
 =?utf-8?B?RmhPRUVzUXlVdDFPUitYUnB1UzR2a05EeE43S0gxTnAzOUVacjZYVFpTUmdT?=
 =?utf-8?B?aUVLMmljRW9waTE5eURocmhVd3pQR0FXQnNZRitmRThLaTZUWlZ4dWtndExY?=
 =?utf-8?B?aWZLa0RYRyt6c3JtVGRhbXdpYUtiOGdWaEpucG1PSnN5KzZYZnV4aWxtOWFD?=
 =?utf-8?B?QU9wcmpyaU9RSU5zNll6NWYzK0Y3M3BvaG5BZEdQYUFIa05IKzNrakwycVJ3?=
 =?utf-8?B?U1pYblJKbW5FSUp4SEdHUHoyRFNtT2Zybm52OXAzRmZwaG9MNk4reFVpWHRI?=
 =?utf-8?B?NlJ2VDNvem5QR2ZEdkRoLytEcWc1UFY3eDVEQjU0VFRYN1NLN2t1YjkyS0dB?=
 =?utf-8?B?NGEwSTA0MXRHeTlRUGNpZU5VTUdsNjRwQmtOQ1NYUkJadlFJdVJNbmFOTlVl?=
 =?utf-8?B?UWhhNkplR2FVNkk2S1dod29ZQUlibjVMWGJ5T09Hd0k0YXcwbnFtSE43TktJ?=
 =?utf-8?B?eHZmQmZqbVlmSzNVQzFCUGk4bmVCbjdNQ09vUU5YeHBQZFpUYlMxSm9nUkVj?=
 =?utf-8?B?WU45dkpxRmgvSkVzUTkwYnAyUndPUjJwT2lrT3VZTGJCVTBpZDcxNE9zY1My?=
 =?utf-8?B?WnlwdkdiZW5FUDY4dHAvMW0yZC9waWQwdHpDV1F1ZlJ6YlpUUGZKUmVWWis2?=
 =?utf-8?B?NVJNZWlzVitxMlphdnh6dnRpaVpzNE9ONU5RUGNPRDI0enA2NjlRWUxndGU5?=
 =?utf-8?B?bEYyRk93UjNMWXdMVUlVL25FZHN3YWx3czljZnRSaDFtcWFVNkNZQlJSekI2?=
 =?utf-8?B?Z2k4OEFiM28zWmJpTEFlMHE3K3B2aUU1TDd4Q1MxUlRLbXpWRmxlY2d0YTU0?=
 =?utf-8?B?eERRZ0QzaVZmQ3I1RmxRUXdrdzkzNjN2T240TTRjRTJNcXFveWY3VFMyTWt5?=
 =?utf-8?B?MHdPV1dxY3p5WkZQZUFFekdsOWdESnVxM09ZaThDbG1DWXpDUVFSVEF2OW9I?=
 =?utf-8?Q?rrU9j8vcVtP7IOBLX0drRBq3J+HJ0+ae?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR03MB6208.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZGsyK25kT0M5eC81cEdZZ1dZNWRVY0FmUVNRT3JWcmhidkJpdDBwZXUvSEpQ?=
 =?utf-8?B?YzgxVnkwTERKNHpqSVB1eXlTbDAvMk9PVGZZMzFxbnZhSmljVXFWbXFEbWlR?=
 =?utf-8?B?NTB2Nkpqd0s3RDYwaGJpbElWWnBTdXVxb0paSGs3a2JuNFNCUlNzK1E0eTBx?=
 =?utf-8?B?dTZFL2JjSlp0cWxLRDZWM1JacnlvVkpab3Y4ZHRSaC9RRy9LT2hLbFNydnFi?=
 =?utf-8?B?Q1k1cnpVYTBsY1o5UkNLb3RsQzljWnZTRFhRL0FtNWZhOVN1RWg5NVZhTDBh?=
 =?utf-8?B?ZUpTVVRMRE9uS05xNzBPbW8vbi92NGs3czhZaE82RlpkRVBnZnNYeXJFWVN1?=
 =?utf-8?B?ZnN2Zjd3MjZFaTdBaENTcm55TzM4aktHemloT3lKem9IQ0tGdmtOOVhzTVZU?=
 =?utf-8?B?WU0yT003aDJ6ZG1EaHFTQVpEUXJwZ2Z6L0FaVEYyRU9jM1R3eFVRTEl5OHFF?=
 =?utf-8?B?eWlIbGlGQ21sSmhwM05hZWhWOU5TT2JOR3ZMWnAvcGFYTVE4c1dBdFdRb1Q3?=
 =?utf-8?B?R3ZQeVF3RmhrdHNrRS8wanVzZFFjeG5vNFJ4MThlWGV5NC90aURTVW9jSkZW?=
 =?utf-8?B?cjBtcTBkMXJLcWF6T2hoL011ZHZDZjVBV3VqVWZHMGh4dFJmSTRWK3VaSGRz?=
 =?utf-8?B?NnVPMmRJMzRqUis1Ym1DV245VGxkU3NBOS9oK1JoYk1OUTdPVy9RZDcrQW1V?=
 =?utf-8?B?a1ZQK0EyTE5sazlYSmppTGFYcUhNOC85TDJUTTFPa1pZVld1alJTQ3R1b2Na?=
 =?utf-8?B?cUNmenh1YThaRlBWb0xDMnNkNWZTVDM2M1B6dklhek5WcVFVejh0VXQ0NUFC?=
 =?utf-8?B?cnVPS1JCUTVXallZWmxnUDhvbG1YOHBqTHFETzk5cU8vNCtrdkJZZXBabTdi?=
 =?utf-8?B?bGozQmlBVFNxa2dOT0pCS25HVWJneG1SSjNWWnpSTFNlT1NnTm5ua3JyK0NU?=
 =?utf-8?B?NFFrT0J1c0tBM09wNXUyMlFSWlRSRDFFRGlDVytManMzMExTUzhtUHFZSmto?=
 =?utf-8?B?ZFY5RksrRjA5Tmg0YmNvZjZsdWxkckh0S24rQXpUOGdyajFvMTE2TEdFM29y?=
 =?utf-8?B?SGw3OHBaRmNpa0JjNWlCNGlCNDdkTjlxbzhCdFZ0OG5vdnpJNjBmWSs2Y2dJ?=
 =?utf-8?B?WTcrZUVQaS9KK0pLdzZQbXlRZVNVc2xMemVCUzlZZUVQbG1RNzM0dEQ5V3pW?=
 =?utf-8?B?bGtYaDBQWnhMWWxJLzIvVDhJclFqN0N1UDNtQWZ3TDBsNzk3UFcrYVlYM05s?=
 =?utf-8?B?VzN6ZktPWVQ0aCt3V0FKVGFyekdUSnBVWkFaM2swbUNCNWFJd3laWVJmc05L?=
 =?utf-8?B?NGM3eTdhRDlFYzdkU00xL3FTVHIzamJCUFVBRHpKVitwVVJNc2VXTUQ4dEdz?=
 =?utf-8?B?MFNORVp1YVp6RkJZdHRGaVJUL0d3RXN1V0RkTmJ3TktJQjM3K3FvdUFLUUtM?=
 =?utf-8?B?cGR5MEpUeDdyWUFVSUR2cG1QaEhvSGltUU03SWR6eStYRUVpdlo5ZFAvdGpk?=
 =?utf-8?B?djVZOG9kcGdXL3IyY0VFaVgzWmpZSThVSHZmdmVPNE9adUZpTjVQdnNWSTl1?=
 =?utf-8?B?cDV5S1loRlpVUFhheEgyeHVnUVVRVktWdzNyZ1BGYkE3WDY0OWx2ZWdjQkF3?=
 =?utf-8?B?Q0xpOGpJU1VnRkp1Slo2b2hmSWFTQWRnZy9OSVNqN0hDRnE0TmxGRHlPNU5U?=
 =?utf-8?B?YXc0WnI3Tll2QjJabkticG5rV1J1SDdTZG9oMktrWkdXT0l3ZlJtd21sYVBz?=
 =?utf-8?B?TWlmTGJiRjhjOHBQSi9Rd3VPWUNLcElRRFZJM2Y5Q0JLUDJpY0g2bzhVcVRp?=
 =?utf-8?B?VkVHU050NGROaStpRzdDZGw5dFdLZ1dYMTMwV1VocXpVZkZYZUUvWTAvRFZS?=
 =?utf-8?B?RjgzUGdCQ0JsaGNZbEMxUFRSakEybHJUbWJvSnNkcjJOcUhBeFBuZWxubXNC?=
 =?utf-8?B?TWN3OUxSdXpjdmxtWWZHZm4ybFN3NUp1dU1wOEsrWnBjakdzVjJPMk5qSWdO?=
 =?utf-8?B?RHVLMWdrQWx6NGZOakZ0bDJlQnczN090U3FFSUxIQU5VU2FZK0hjYkFDVWx4?=
 =?utf-8?B?R25uUUc5RjBHKys3U3ovTFdOa1NudUhxUjJGRWtyb2JBSE9Balc4K1lpWE1U?=
 =?utf-8?B?YUFCMnJ4WUFmSFNRTEgwZ3RKL3pWZDM0eVpmUzhHdC9RN0I1UE1CS0k2STNQ?=
 =?utf-8?B?RGc9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54ce8b3b-85ab-48d5-4bda-08de12042e7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR03MB6208.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:17:10.5434 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C4x0QescquqdkbDjKtidxQwMoXoH3+a84FDC07avHg51fb4clzqRidpTYgzLm0dfsQ1rcWEd/aWuVK4e/mUaZEPdBJTvvmYrTQfRFQuBXvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR03MB7774
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

Hi Peng,

Thank you for your feedback.

On 10/23/2025 12:38 PM, Peng Fan wrote:
> Hi Tanmay,
> 
>> Subject: [PATCH] mmc: sdhci: Add SDHCI_SPEC_400, _410, and _420
>> version defines
>>
>> Add SDHCI_SPEC_400, SDHCI_SPEC_410, and SDHCI_SPEC_420 macros
>> to sdhci.h to support newer SDHCI specification versions. These defines
>> are required for compatibility with controllers implementing SDHCI 4.0
>> and above.
>>
>> Signed-off-by: Tanmay Kathpalia <tanmay.kathpalia@altera.com>
>> ---
>>   include/sdhci.h | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/include/sdhci.h b/include/sdhci.h index
>> 2372697b743..a962cc93caa 100644
>> --- a/include/sdhci.h
>> +++ b/include/sdhci.h
>> @@ -223,6 +223,9 @@
>>   #define   SDHCI_SPEC_100	0
>>   #define   SDHCI_SPEC_200	1
>>   #define   SDHCI_SPEC_300	2
>> +#define   SDHCI_SPEC_400	3
>> +#define   SDHCI_SPEC_410	4
>> +#define   SDHCI_SPEC_420	5
> 
> Let's add them when there are real users of these macros.
> 
> Thanks,
> Peng.
> 

I am currently working on another patch series related to SDHCI Cadence, 
which will require the use of these newer SDHCI specification version 
macros. Would you prefer that I add these defines as part of that 
upcoming series, instead of as a standalone patch?

I initially thought of submitting these changes separately since they 
affect the SDHCI interface file and could be useful for future SDHCI 
controller support, but I’m happy to include them in the series if 
that’s preferable.

Please let me know your preference.

Thanks,
Tanmay

