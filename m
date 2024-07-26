Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF3F7C3DA49
	for <u-boot@archiver.kernel.org>; Fri, 26 Jul 2024 08:11:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6D113884CA;
	Fri, 26 Jul 2024 10:11:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jz0Lpjsr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40E1E884F1; Fri, 26 Jul 2024 10:11:32 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on20600.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2415::600])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 32AFE87CF8
 for <u-boot@lists.denx.de>; Fri, 26 Jul 2024 10:11:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: phobos.denx.de;
 spf=fail smtp.mailfrom=michal.simek@amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=giQGYsB6ak+TMcr36BOIS7HTdnPEd0gYIcnfifDKe+PZsgyL9aB4NcEyrfxPw3OGFiBKP+Qi3EBOHNW9zZIc02koKyaLGeJC5rWGbNk4xg3ndAZCNhvm2wP8xMO72BvZCfREOZu1ZOMsLsPXrHPAev9wwv83SVaa3syxvPWf7meMtIh9qetwin1mFo0dJYm5+YZ3LuJQUP1NTWuTQP8VwwAAdO23t/2izVBwnb0pT++Ib9A9CMYf4FYc8qEDBY0S7m7LtCpsdsm02qpNaJ5nmfRQN3BFxvxLvkhnZEaeHL9FdzdA5uo0768pgfKFaFa3+RJnnLTnEyDvxjVz2pVQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gKPTVjkG89RuSi8QiCRrr8Fqn1e1JFXPsGd8OTFegWo=;
 b=gLzkBttx1aZuwNFrDABtugdRL5F2T85AiwlBjjhfLaEFyZKYhztmKmx5X8mQ7aQ78vqW8IOCrFK6+fk/Qhgiz2LIgdhxALW1RFFBYKK+KcXHBMeHPc2dPUUYJYImO2Oe1A1ytRRNLNMnLeVKNq6AS9LDVPYcZhX7lBtiaA07l97ZT4iOeKC0HAwjd52SZ+0tnd6yIE8Bt264C82zMZq6DLO3BZKSvobJOI9iMop7cdqRahP27LfK5XjSCSC5J7f7hdTA9BVoDeJirJVzeTXlvQV9fq6v8+Bxw/rnVMw10xl9/9xREm4ZnFKt/N0r6wT6wZKXxAQYakdYQZn8JwGhyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gKPTVjkG89RuSi8QiCRrr8Fqn1e1JFXPsGd8OTFegWo=;
 b=jz0Lpjsr+s2o9hCmRH6+5bQOlCuCbAEyhFLjIJnin7Wij+tBUWJyWljgDQFclCJCo9ivxSqu3Sm7MYWjXhYA6Vvu3kKhKD1deIZERDbUWu2zXKe/DFEx+0S3bI+yw7kashkcO9/frRk9WHGh5JLjXS80xIDCOwx5iXfAgbNdHYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by PH7PR12MB7163.namprd12.prod.outlook.com (2603:10b6:510:202::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Fri, 26 Jul
 2024 08:11:27 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7784.020; Fri, 26 Jul 2024
 08:11:27 +0000
Message-ID: <581363dd-9803-413c-8046-64c48f8da822@amd.com>
Date: Fri, 26 Jul 2024 10:11:16 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: xilinx: Describe TPM reset for Kria CCs
From: Michal Simek <michal.simek@amd.com>
To: u-boot@lists.denx.de, git@xilinx.com
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shubhangi Shrikrushna Mahalle <shubhangi.shrikrushna-mahalle@amd.com>,
 Tom Rini <trini@konsulko.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>
References: <2c0cb3a2b27a3bf0ede75c5ccded2d086d9c62b0.1721136547.git.michal.simek@amd.com>
Content-Language: en-US
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <2c0cb3a2b27a3bf0ede75c5ccded2d086d9c62b0.1721136547.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0142.eurprd07.prod.outlook.com
 (2603:10a6:802:16::29) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|PH7PR12MB7163:EE_
X-MS-Office365-Filtering-Correlation-Id: ae26524e-8466-4a21-f0e3-08dcad4a8c78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Y1psSDdIMGhKSGdyMS94TGZ2SVUzRjVRQnVzK1pnMmtJTzBEWEJBYVRqbWZT?=
 =?utf-8?B?Z1Jza1R4NExJWHpOM1dncEt6OTBENDdaWTVHOGpVenIwYW00MWpSUVRzVVdH?=
 =?utf-8?B?clQ1WFpGcnVKQ2RSSEF2SUNHUlFGVDRZWnZGMFJVRktKeXBNS3Z0YU1sNWFB?=
 =?utf-8?B?S2ExMyt6V2pZZUNNRDlSNXRxUy9jV0ZZS0xtamtCZlRIM0p6Q1Y5ZjJYMWQy?=
 =?utf-8?B?UGhxM04rT2xoWFo0eWVlcG1KbDNpYlpOMHhiWE12MGtuR0R0czhaV2JOSThk?=
 =?utf-8?B?T1o4YktEZU1Cc3hKNmN6bkp5eFhHYlFqbDdRTkdIbkNwU3dqaEFFVEE4QmRB?=
 =?utf-8?B?M3lrNCsrTkxmcFlmb2oyS1VKUy9wRlF4TnoyNEdabVhJSm81ci9oSTlSUE9u?=
 =?utf-8?B?aWZoYncweVlZellWSEo1Yncyb3FkY09Ea08vOE0yc042akVYeDVDYXZWY09V?=
 =?utf-8?B?R29nTkRuendGWEtIeVJyTjRabDU1LzQ2TlpiblZlOVUxb0F5b0FlV0hxTytU?=
 =?utf-8?B?cGUyTDV3RDZCdm5XU0ErVk1tSURpazhjSlhZWU1sT2JkMEZzT2ppK1djaXY4?=
 =?utf-8?B?aXJnVUdOSktVRDI5dXc2N0N0SXhBaWNyWkVRcVoxT01VdkNXQzVOazFBRzlw?=
 =?utf-8?B?UUNXL095TEUwSkVza01lZXJJRE5sYlp2UVpzcko5WHlKdGVrZ2ZrUGJtMWor?=
 =?utf-8?B?cmdDSi9uZ1d3U05ERER6M2x0ajE5cHdnVEZzazArSjhIWS9QNll2Z2tPS1lR?=
 =?utf-8?B?ZlNzU0pLWEtxZGYwUEpicFMwTDR4T0cvb3Zpc1h3UCtSSjgzQWNZb3RRSGp4?=
 =?utf-8?B?YnBxTDh6Mjl2UDlaekNwOWxBeG9pMVF4NUpjb0l5MWJoUWVFc2dzQ1h1WktW?=
 =?utf-8?B?R0IyKzByclZFSWNQcjlWd0MvMnl6NHk2M08zeWN4TldLMlp4Ylk0MlUxMk93?=
 =?utf-8?B?anREL25PVEl2eno1Nlc0QmdRRmtrNGEydzJyM1pTYThLd2x1Sis2ZjdIVkVT?=
 =?utf-8?B?cUpXeFhTSU5mNDV2OXhSZ2J5WHArczBGK2RQU0tjcG1yU3laM1VZbm5iWnBs?=
 =?utf-8?B?QU0vUnVrUFBNYVduWDUzMlJkYXFnZndqbkU3MGM5Qkc0YURsMU1MWGFpMmFS?=
 =?utf-8?B?enYvWXFOaTl3QUM5VGloaTVtZHJldkhRaGRpYWFZMmZlRGxUL2xuTnozNzBw?=
 =?utf-8?B?RS9TT0hvSmtNQ3ZqdjFvZHBHTkxYaDBmU2lQeXp0QkFFcEVBNW4wbFBzbEFx?=
 =?utf-8?B?VEJVMFp6U3ZVcnpxaE1WOGZ4U0xNc0xiMTQydE0zTStqZ1VURWJDYThOSDNi?=
 =?utf-8?B?N1YvMkRMd1p5WE93dUtOTDF1dDNZYzBNY1greTg2Q0x3MVpQZFdDZitScDk2?=
 =?utf-8?B?eEVGVm1xbnJjdHc1Nm9DM2pkZVZWT2FpSlhNWEN6WFlpdGJ6SWpqUllCRkNn?=
 =?utf-8?B?Rzh2WXFlclZ1eUFaamdBQzlQWnNGV2hKcngrN0UrV2duWGxjWVV3eHFWaEVH?=
 =?utf-8?B?UFh4TWhiM3JNK0FiZTRFWmxGZE5WTndSZHlBRFlYQWcxd2tFM2EzL1g3M1pl?=
 =?utf-8?B?d2Z5MUt4aE1tQWZCREdxcjZCY2lGWkNSNFQxRDVjUmp6dW84ckNyOE4xNFRR?=
 =?utf-8?B?SFpZMFQveFMyOXZOK1BBdkZvcjI2dThnSk0wd3A0Y3lacEJ0eGpQMzhsVUxa?=
 =?utf-8?B?bjFSRVcxTk5UMnVseEZJSG5jbUczL1R3K0tiVzBhQlhlcFU3L3AvNVhReXZV?=
 =?utf-8?B?TUZWTGpFMkEzZktVVzZRUzM3djVWM0hSQWJGUHJJL3lSamtiMTBVVWUxUTYr?=
 =?utf-8?B?Qk1lMzZDUitabEFYZkJzUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB8109.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R2ZVcUcrYmVKWFlmWjduQjVCV3U3cElsWFE4MzAxM3RUN1kyQm5QMzA2Si90?=
 =?utf-8?B?SDFabDdjWkx5djZOenYwWXN0TDBLeTNNbjdZUUVtRlJIdmgvcjVWUSs4UjBM?=
 =?utf-8?B?OENtNG1UK3duaVZadEkrRXRpRGVERnpuK3A3VzhpL0VNQXRnVlZ2SldPN1BJ?=
 =?utf-8?B?ZWR3QmJLQ0FvcjhGODFpdFN2bWV6dy80YWMyUmh0Rlo0VXUyUldXZmNaYWVL?=
 =?utf-8?B?N01ZWkRiWnp2eFYvQk8wQ0Zxci92YXh1L0tnclVUOXpidzRuUnRyZHZ5akZj?=
 =?utf-8?B?L1prTzZQT0wxM2M5MnBkbm9VV3VuMzB6UG4zbS9kM3A1VzFCby9BbGJZZ2cw?=
 =?utf-8?B?Mk5YVzJndnRXbDlLakZXZWdLdE5SZEhsRnlYZmVVUWxnYUJWQkMwa2wxRG9x?=
 =?utf-8?B?M3BiN3l5NkQrOVlCTzA5L0VhV1ZpVVVzQlQwU083VFg3S3MvRkRCcE0zTVlQ?=
 =?utf-8?B?bDNLZU5KQkZRQjVZenBoMHA5Nzk0MC9UT01IRTJRK2F6eW5nWUlFS2xJNEpi?=
 =?utf-8?B?TmorSU1jRURZZWNtMU1QWEFBQVpCSHBQSGl5UU5rQ2dRQWgvN21XMUJFNHd5?=
 =?utf-8?B?RXh4QkNFYXFTVCswYlRtLy9VMVJFdEJTYnB4ZElHM2Y5QmlLM2hSNmhDWko4?=
 =?utf-8?B?dXhqNWJFK2NrNHZpc25pbWFUUzNGc2hYeUVSWDRzQmhsTkthR1F2aldET25y?=
 =?utf-8?B?aEtsUGNTZVBDNEtiQjZ4bm5QMXJrV0tMM2U4cWZrSEFkY0l1eWM3TSswOGVP?=
 =?utf-8?B?dDZkSVJJZUl2Rzk2eWgwRll5clVmMnVsRjlyTm9vY2RpOCtpbnpaYXErNThW?=
 =?utf-8?B?eTBNeXdCUGZSeVZFL3ZqOTdiTjVYbW5QNkw1b0Q3Q0ZrRHQycUMxVVNUb1VC?=
 =?utf-8?B?QkZJeUhnQU5XR2t4dDNnTk5CT1NUU05TSTh4Y3crZHFtekcvaDBaWWRZOFha?=
 =?utf-8?B?ZDRRYnJEejllY29hcFdva1Z1eSt4UWVDaC9zbGRuSmRXN2c5cnByMkZ1VTJS?=
 =?utf-8?B?dzBidVpCUEhqUEx3czZQL21Zd1g5Sm1nRmNxQ2tVUlJNQzRlQWZPRm1EdGNC?=
 =?utf-8?B?MW10Y2U2OVZTVlNsa3Zndkxsa2ZLMmQ3VmlPZkxram1LR3FZK09QbThReFVy?=
 =?utf-8?B?RS96bzJOTHkycUtIUW0zRUordDA5RHJ1UEw0TzhBZko3Ykc0aE1ITTlWN0s4?=
 =?utf-8?B?cGdHZ1M0amU5N3ZVSG9odGlwbHhLZmh0bzVpcXRreDJTVzFSbGR1eWR0VzJ5?=
 =?utf-8?B?TjU3TytxUXNVbjNuV25MRWlWbTl1VytmN0VLUDl1SldsdFNONUJJTnd1eHBN?=
 =?utf-8?B?RzVmQnorZXIxTC9tTVVKM2ltQmpabnlwV3pMalVpdk1zY1NVTnAwT1BYRTQ1?=
 =?utf-8?B?RTQ2bTQ5K3lWVjhOQ2FnSDQ1ME9iRTVEdVdwdW54L2t3bVdOYzYxbnhDV1pq?=
 =?utf-8?B?bW1PeHRyODNpM2w2OVpRNTlNSXBEcitrRDh3bnJUcGxvcDNsS0tIbWE5eGhl?=
 =?utf-8?B?K1Y0dEVYMXg3SVYvSXFVbWd2RjlObldHenExTzJaRFZqOGRvUGZuS3dVeEJo?=
 =?utf-8?B?eG4xbGk2WldIUkwzU3ZtN0IxVDBjblAwSUJiK3pDUkZnWjVJM0tIT3ZEM0FM?=
 =?utf-8?B?NkNkMnUwWVJTVjJPQ3FXbmlwZWlEbUMzeEdGci9MaGt0SkhZQVJsNms1OXcy?=
 =?utf-8?B?aEk4MUcxT0F6dmZsaUJzSEVSdE82NmlHUFlFUjFiS3M0VWdMTmhLeXpLSlAy?=
 =?utf-8?B?Szk3eHB6OWgrdnl5c2hYR25kMzIxVk84dDZIYjRydXE2Znk2QTZuZmJncHpF?=
 =?utf-8?B?QWhRbXlUK29nRkNvbE9MMmhsU0RlbFp6RklpZzRoRFNka09HNGxsb21iOEVv?=
 =?utf-8?B?OG5wamVPWXFHdWxLaU1yS2k0c1Q5K25jdFIwbmM2NVJsTkltQjFVZ2hTYjFi?=
 =?utf-8?B?V2NiSFNjcEh5MU5UTk1tTzg2bERVWHhHbHVaZTRUUTVEM1J4STNrR2VQMzJH?=
 =?utf-8?B?WnFkQURBQTcyNW1TSFg4QzkrcmkrWUVXcXNTeitpbUdqNmljenpzdlNQOGVW?=
 =?utf-8?B?YVRlMFRVaVBPNDRyMXN6UzNTNXlUNVBlR2h2c3MrTTZXVkdkRTJCYnZ1dkhD?=
 =?utf-8?Q?tLyyQO/u/Az19YdCrPbX1FeQZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae26524e-8466-4a21-f0e3-08dcad4a8c78
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2024 08:11:27.6548 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6OPtTx/SN/K2F3DldLIGCw+2BTZqv5cQRTZ1Iw6yF8KW6/bMNt5lAvpo2NW/Obn0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7163
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



On 7/16/24 15:29, Michal Simek wrote:
> Describe carrier card TPM reset behavior and show message about it on boot
> console to let users know what to expect from it.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>   board/xilinx/zynqmp/zynqmp_kria.env | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/board/xilinx/zynqmp/zynqmp_kria.env b/board/xilinx/zynqmp/zynqmp_kria.env
> index 69e333c53887..49ef3e7d7532 100644
> --- a/board/xilinx/zynqmp/zynqmp_kria.env
> +++ b/board/xilinx/zynqmp/zynqmp_kria.env
> @@ -63,10 +63,13 @@ kr260_setup=i2c dev 1 && run usb_hub_init; i2c dev 2 && run usb_hub_init;
>   kd240_setup=i2c dev 1 && run usb_hub_init;zynqmp pmufw node 33; zynqmp pmufw node 47
>   
>   tpm_setup=tpm autostart;
> +tpm_reset=echo "!!! For TPM reset a full power cycle or pressing the POR_B button is required !!!";
> +tpm_kv260=if test ${card1_rev} = A -o ${card1_rev} = B -o ${card1_rev} = Y -o ${card1_rev} = Z -o ${card1_rev} = 1; then run tpm_reset; fi
> +tpm_kd240=if test ${card1_rev} = A; then run tpm_reset; fi
>   
>   board_setup=\
>   zynqmp mmio_write 0xFFCA0010 0xfff 0; \
> -if test ${card1_name} = SCK-KV-G; then run kv260_setup; fi;\
> -if test ${card1_name} = SCK-KR-G; then run kr260_setup; fi;\
> -if test ${card1_name} = SCK-KD-G; then run kd240_setup; fi;\
> +if test ${card1_name} = SCK-KV-G; then run kv260_setup; run tpm_kv260; fi;\
> +if test ${card1_name} = SCK-KR-G; then run kr260_setup; run tpm_reset; fi;\
> +if test ${card1_name} = SCK-KD-G; then run kd240_setup; run tpm_kd240; fi;\
>   run tpm_setup

Applied.
M
