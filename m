Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C44D2CE17
	for <u-boot@archiver.kernel.org>; Wed, 10 Dec 2025 07:43:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1EF1483CD3;
	Wed, 10 Dec 2025 08:43:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="SQqTlH5p";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 30CE983CF2; Wed, 10 Dec 2025 08:43:47 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazlp170110009.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c111::9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 24E9C83655
 for <u-boot@lists.denx.de>; Wed, 10 Dec 2025 08:43:45 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvL0rszFw4nogu4xWd2LC058bcOrHWVg/ygM0J1x6LqUUCGNSLa778LoipAIrDuAHwODEE/vWMY5dUqhzMGGkRPFf/tH64bJdWr/CDibUZBO3faYUf56UduhC3xb4lB7/S9mdOTUeG9dHu2VJKnBjHpUiQYofNzq01X7szDzWzm190XkJ19thjx8bhpFpReEcAe1umIPgyG95n5gQlfmFaT10zT5JTrvDFy3lorRKEBfrBhawJA4ewXBHErnRjdx1jKF0d3izubz8CuNMOx+0DmqumSXmW9E8AcBFnTtLI3x8pTPMYxtkuJM1Ih4yvZxmOb9br3D3nSpNGrcXgm0fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4g000cekWDI843St26lIg3URFnimrFA9CL7EfcKO7Q=;
 b=pbcwVzhUuL8tFAAmVbT7Lp/phyvOvVVoUYpbL2MEyPiqVe7Q29yVgOlQ8abdlQIdRwOM4AAMeckpv3ytTThN2DwUGdmbBr930S9CDYk+d5NYc0gT+KPXy+zCHL0r0IosriUUQgC49JppOR6q2Fq1VJ/IOknalCwCymS592oPrQvh2MnSlremcCbPgMr3m4olN6tH8ZZWnVQXLJrhojrTjpgMKv1p7q+e+hG/jZ9AbK42KPFjx1kPO11og1h+wXyAFlYRKOmO7flaO9bKcLCW3cdIUD5G2ivK2XPDRdqydIOS3EO6xURGpzXOZTK9vN/AORhV2ak338fCqf91GYhQwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f4g000cekWDI843St26lIg3URFnimrFA9CL7EfcKO7Q=;
 b=SQqTlH5pjWTOlw0t1MLFnPIWQRTDY8kxmOhFU9HvNDKOARlf9PDXw58ayeOkKGfLpGZoGQB/iqHSVXOZf3DOWn3k0Bp4HXsOjLFqzpZSK8Mr/UFqEc3dWv9HAj01fP2t1b68zzMG7dAG51MdaweJD72jjsQKU3+vnNcGHJySRiY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.6; Wed, 10 Dec
 2025 07:43:41 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.9412.005; Wed, 10 Dec 2025
 07:43:41 +0000
Message-ID: <4390102b-224d-4c4b-80e8-e82118d1d87b@amd.com>
Date: Wed, 10 Dec 2025 08:43:36 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] board: xilinx: add SPL boot device support
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@amd.com
Cc: Padmarao Begari <padmarao.begari@amd.com>, Peng Fan <peng.fan@nxp.com>,
 Sam Protsenko <semen.protsenko@linaro.org>, Tom Rini <trini@konsulko.com>
References: <a1f26a9392128309a1affed28b14809845714c21.1764747417.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 mpwx1d8=
In-Reply-To: <a1f26a9392128309a1affed28b14809845714c21.1764747417.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|MN2PR12MB4488:EE_
X-MS-Office365-Filtering-Correlation-Id: 188065dc-848a-470d-572f-08de37bfd655
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OGVyeENHSGozMlNWQjQzN2dzVVpWTkdPWHBjS3hWMUFacHdLTFRPSHdheTcz?=
 =?utf-8?B?ZzFJY2FzNnQxQzRtQ1UwcloyTExDd3BiS3R0MUlrSStybU9GZ1Uzb05pWVRY?=
 =?utf-8?B?RjFmRG1tZTFQTHZmNkxWai9WYmJkY0JYSytVSE80aExJdE14M2dYMDBzejZk?=
 =?utf-8?B?TmROdXk5c2hja2RHMGFjWjczL3QyT3BOalBScFNBSnZBTGEwQWsrSmo5bnUw?=
 =?utf-8?B?UWNuTkZ3S2dsQmZHVUhrbXhveCtJbEEweXM2d3l1WitBRmdFbmo5MVJJK0Q1?=
 =?utf-8?B?MVIvbks1UkRlTndSL0hac1dqSDRwQnlRQ1BRMm4wYXhwSlFFWmNIODNkbUcy?=
 =?utf-8?B?bGpKQVlKWEhUcDNLTWRCVnYyc05QcEpkbjd3eHRMNXp1azRpQnFUajhDOEc2?=
 =?utf-8?B?ZzNhMjBqd2tSajdVU09BdW1vcXUvNzlPQ2xzek55QVoyN0FjKzd2YWhyNEdy?=
 =?utf-8?B?T0xGUGxGVE0vRVVoeS9FdFk2U2hSUUpnNnZHbWJPdnAwSnArNGtXQitrd2Fk?=
 =?utf-8?B?cXhmL3V6eWt3Zmgvd2UwQ014L2xaWHdLenV3dkRtdnFYMlcvbnVBTzh6SkdP?=
 =?utf-8?B?cHU0ZGpUU0pmUEFzamM0QWw2cXFmYnBCbnJ2dkNrRjR5eUFaRkcrYnRoM2d1?=
 =?utf-8?B?cGRoZG52WjE0bDA2SFdZSFQwYzNtM0RBMk9KTlNYd3VjM01SZmlFTGtIdzlj?=
 =?utf-8?B?NmxtSm5VV3YwNTJhOTdkZVgwMjIvV2tRb0h4bTZqNFVXcFVxQUJOMHh4YU5F?=
 =?utf-8?B?SmJ0dzREdzhncU1oV0NTczF4bzlHN2FIWUlEVGxiMmdsd2wrVUZlVXpJNndN?=
 =?utf-8?B?MXZ5NjZaU25JbWR0dmJrQ3dFR293UDZXNjVQWndFZm1hT0lxMUJ3d0p4M3dl?=
 =?utf-8?B?Mjcyak51NnZQd0Zza2RnYndKVVhiV3RWM0ZnUmJIZVkwa09xRlcwUUZjeXM0?=
 =?utf-8?B?S0Z6RGlabEpmUjJUMjdOQk9abjBUZ29WUUN5UTB5YVBzT3VadUJnZEo5bnlI?=
 =?utf-8?B?VkpHWFVDWS9PcU9uQ1gzL2RUbmNweUY4dVRVa1dmakw0ZHJmaEFBL0dkNFFW?=
 =?utf-8?B?MS9HSS9UVzJId3FyR1VvR3R0VFZSR2c1ZmYxVjB6WXVFSnNhbUtIYmswZmtP?=
 =?utf-8?B?YVp3b0FMeFVPajJvbTJScVNIVUJ3QzhleUlNYUlsRDZRSmZvUWNiTmFtaFQw?=
 =?utf-8?B?ckl2T0lTL0JaVGFlWko0ZEE0Q2tXM1lIYTBiN2ZLMk40c01vYnJZb0p5TTFM?=
 =?utf-8?B?M2FWSTIxaUNKMVRrMGhHRWswbUk2anNzUFZJTjc2bkliY2FrZDhRbWN2VTE0?=
 =?utf-8?B?bDZPbDNyRlJqNXFocjRCU2RRNnowdUx5SkJmRU9YRTJyV2hDUG96VlE2TkJF?=
 =?utf-8?B?elZIZ3RYdUNFSFhNSnEzOVZQelpLQm9qVGhiU2JpNUF5T21jTHVoYTUwQnR1?=
 =?utf-8?B?a3pTMjlIREVqTGFlTWZzM2gxU1duWUtOb1lESCtIQzl3RE4xMjBQS1gxVUZm?=
 =?utf-8?B?ZVBnTFYvMndoelVtMlhpdFVuSEx4enpiN285aGZaMW1seVR5VC8vb2tienMr?=
 =?utf-8?B?QmhwNFZxQ2ZkdWhwR0xOazBRcEJoQVhEVkpIL1hiQ2NCaWFWRDk4S0J2U1NC?=
 =?utf-8?B?d0U5b1FGM1orNktGemZDTkFPWUpHSGFkanhqaGxiNkU3MlRUdXVZRitiMksv?=
 =?utf-8?B?U2xNWXVZcWp0VXlvdS9KVk1vYnU4bFNud2pPUW50Z3JWMUZrb0lXRm4yOGZK?=
 =?utf-8?B?MUxRQ1lNNmI2cTdtK1N2d0poblBjMkdVN1N6dFhUeXlsNVdXWkwxMkVteURn?=
 =?utf-8?B?NUdqbU5GalZEZ0VRd3dqRmVma0haMHl0MnJjd3BvL00ycDhxbCtLNXZxRngx?=
 =?utf-8?B?ZlVtTWYzSFRCNk5yY2szVk02VTNVRnlPbnlJK3BuSnY1Z3NsaGtZSjVNdndm?=
 =?utf-8?Q?T4piavcoTnGYPYC23PbIrEAuvqdGih9J?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN7PR12MB8101.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzVNeUVyT29IS255YmkyU051Ym9HeU10ZFVQMitOckRlaXdJSWc0VzVTK09o?=
 =?utf-8?B?cTNaRGVSMWQ1Z3lNMVN3cmlSWlBHYUNFb281T1JsUWhhMFp6MDdxV2RNakRk?=
 =?utf-8?B?b2IxQ2dtTkQzSzRuUXNCaFlKcGk0MU1zVW8zd093dEtJRW1TTjU0UTFHTXhv?=
 =?utf-8?B?d3pZNmpHMGZjN1ZPMytha2F4MUU3YUk2SU5RRnZiQzFCMjhGTmdBUnNYTlJy?=
 =?utf-8?B?OWs4U2hSMFZSZ00vTkd3WElWMGdlQXZWS1FNQ3NibEJrSVROWjZua09xRlNW?=
 =?utf-8?B?b2tIQ0JJMWJlT254aUp2akxUUlZaeW0rdjFxOFRpbHNwTXVoc3QzejBVV2JI?=
 =?utf-8?B?Z2dmMjE4eldhaHQ5VlRxc1BKTTlBZHBiSFJEOG40akt3a1h2SEljZUY3MkNs?=
 =?utf-8?B?RmgvNzhMZGQ1R080OHl3UERUMTlSbTMvM2dFVS83WDhhdi9uRXpHOTZha3k1?=
 =?utf-8?B?anBnT004RG5HL2hkdldGL0EwM3NDNW1lYm5ZVDNVU0lzb1V2Q2lWVkpINmpq?=
 =?utf-8?B?QjkzZ3l2TGFCZXQ5dUFrdU1ucnEwVm9uOEIwUEhjWDR2bVdRZHlqU3YwcWI4?=
 =?utf-8?B?eC9DYWxWVUxTTXBjcnBzZUxGRGszM0lSOXFmL2FzdExOK1NrWXZHODRWbXVC?=
 =?utf-8?B?ak9Mdk5jRENEdDBhMnZwSVRyaFBIUUppdWEyNFRxZGhuQUp3dDZXSXcwemZk?=
 =?utf-8?B?Ky9hMDM2OUdyMmJDSC9WT01HSnQrRHJKUVV4QkNLMk1mLzIrMVlaRURmVHBs?=
 =?utf-8?B?ZmFMcnJEVDUycXlYMkphVzdyL1VCUmlxdVRTMktkeGxJaURJZHBEWlk3N3dT?=
 =?utf-8?B?eUtuZ0lxN3VVOGp1TjRuMElVYTRXMGZIcFk3THlSS1pFK2RGYVhQUk05Vlpx?=
 =?utf-8?B?eFZNQWp3RzZBaHVFZHJUTUNYM2s0Q2lXRGxHZEt3Rmh5VTZ6OTFlOFNSb0li?=
 =?utf-8?B?bytWdU5qenFHVTRTanBqR2QzdHFqenh0bWQreUF2cDd4c0lrcmo5ZzZudVBC?=
 =?utf-8?B?OFFrQXlNbElwcnYvQWNMNDlCbm5Pc1FGeVlQa3lNa0NOZUtLejlZOE1TWjB0?=
 =?utf-8?B?cnVoTzNEZGJXVDZVWlBoT3ByUWFLZGZKblFNU2VkWkZDdlRJaEM2cTdXNmpN?=
 =?utf-8?B?K01zeGNSOXd4VVJ5RWU0YlpuYVhDbThBYzVKWVY1Z3BBcDRRaXhZMklPU1lC?=
 =?utf-8?B?bXRMT0ZpdW1MTjJRWXp3TGVGd0FOOWRzekdUSS84RUtDMFU2aXdRM2pCR1NC?=
 =?utf-8?B?Z0RoWVlRaHYybUtyWmduVklRNnBaOEE2SHQrQkRGNGdVTHJZdlV0RUh3S2li?=
 =?utf-8?B?bXNHeUJIOWZvSmcxSXhuQ21TL0RyeVJFdHhPZW9IMWx0RVdPVXFjNkVpeXBT?=
 =?utf-8?B?T2c2NVBDdzBVWlBLWE1IY3k4QmU3VUxYSGY3L3YvT0ZvMUNUZ3VxaTlSZ0ls?=
 =?utf-8?B?eHVrWVd4NVJtSmVuaHFVVGNrSWlhWlNadG5oUTFwOWIwdXh4U3VrMGRQcEM3?=
 =?utf-8?B?OGRNenYxcTRrMzg0SzA3K050WER3bWYvTGlSVndSeXczdzJzTlp4QWhSbzF3?=
 =?utf-8?B?bkNUckZXejVjQjZaZnN5K2greExjdi80V0MvNHRhYUR3aXA0d05tNis2eDFZ?=
 =?utf-8?B?VEVZdjYwemF1b0FQaGlqUGwrWXpwZFpHby9Fb2cyL1ozWjZTUG9uVVU0Vyt3?=
 =?utf-8?B?eldyMnZSYzY4YzYrNjFJUlhRZXE3K2R4dmtDdjRGT25JNnRBZkorR1VhZzFv?=
 =?utf-8?B?eEsrNVlia1JTZklkcFBRTGxyN0F3dUxkREluWGF2Q25aWHNaU09hcG9yY3E4?=
 =?utf-8?B?MGVJU0s5OHEwUG5MUTBqUk9uemNCY3FNSjFWTnVid0xIM2VKL21MSUlWblNT?=
 =?utf-8?B?NDRsUnlneml4ODdwSzdId2hPdmIxSWllUU1WbFo1YWtsNmJyZjhBdENlclVi?=
 =?utf-8?B?dnVsa2tDRVhDVElmMU5VTk10S0p5cDI0b0tmOXFqdVdraXNlbmtQaWdiUWh6?=
 =?utf-8?B?S0cwcmF1dW9oR3dPbEFuc0VzazdLWTVtUDVhZmVGdy9jOVN3Sm1OUDR0RXBz?=
 =?utf-8?B?aFhBQjhZN0Y0ZnJoSk9WWDI0bVJaSDBvTDlJakg1ditTd1BPRm9ueGtqSFVl?=
 =?utf-8?Q?VzLhIllDqyHsldmbNrpiyHfqT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 188065dc-848a-470d-572f-08de37bfd655
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2025 07:43:40.8492 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ci/ULZCaugu3k+91xfseBbGzCRfPloFKsB3tZTzaJN3dC/C3F0XY6VNKMT2Z6gxP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4488
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



On 12/3/25 08:36, Michal Simek wrote:
> From: Padmarao Begari <padmarao.begari@amd.com>
> 
> Add board_boot_order() function and remove spl_boot_device()
> function because it is called from weak board_boot_order().
> 
> Add support to U-Boot SPL for booting from RAM or SPI, as
> configured in defconfig.
> 
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/mbv/board.c | 14 ++++++++++----
>   1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/board/xilinx/mbv/board.c b/board/xilinx/mbv/board.c
> index ed3fe16af7b9..2b0005955ca5 100644
> --- a/board/xilinx/mbv/board.c
> +++ b/board/xilinx/mbv/board.c
> @@ -1,6 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0+
>   /*
> - * (C) Copyright 2023, Advanced Micro Devices, Inc.
> + * (C) Copyright 2023-2025, Advanced Micro Devices, Inc.
>    *
>    * Michal Simek <michal.simek@amd.com>
>    */
> @@ -8,9 +8,15 @@
>   #include <spl.h>
>   
>   #ifdef CONFIG_SPL
> -u32 spl_boot_device(void)
> +void board_boot_order(u32 *spl_boot_list)
>   {
> -	/* RISC-V QEMU only supports RAM as SPL boot device */
> -	return BOOT_DEVICE_RAM;
> +	u32 i = 0;
> +
> +	if (CONFIG_IS_ENABLED(SPI_FLASH_SUPPORT))
> +		spl_boot_list[i++] = BOOT_DEVICE_SPI;
> +
> +	if (CONFIG_IS_ENABLED(RAM_SUPPORT))
> +		spl_boot_list[i++] = BOOT_DEVICE_RAM;
> +
>   }
>   #endif

Applied.
M
