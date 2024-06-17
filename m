Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704DBC27C6E
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 09:00:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8CB88080;
	Mon, 17 Jun 2024 11:00:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="defr51zw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B64BA880C5; Mon, 17 Jun 2024 11:00:16 +0200 (CEST)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04on2071d.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:260f::71d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4876C87DC7
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 11:00:14 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEij/JakeZnlZ0P+xGMVO8tsIMOQrD+XhEOIm3rxbDQij++HleNCZ6kWTAjZnd+5wWehuMSXZoxNLU/0qzu7g6G9J1kKsDEYcR6MixMqTgduwaZ0S2sCmITaCgEPWs+nofRDCoqnMT8Bq08Khd0EoTacPPSO0aEnWnjpDfxUn3MKm/L4q0h3BAYTu6OlR633c4JfCrly9yxZ6P/NGE+X/aehKt9EMjJ/3dGBjqhpdPusLtOlxO0wthM3OyPXlm02QRY7a1x/c7mo78DIg8Np6W+54QV84TXyKzaDqT4aZG+zy/gq8weeqrUbNUYtXLB+MEQkRwh7xMKkoRSprMSxWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ezhcTUNCF2KNM0+7DnC49nOxZeBYouwoO2SyLEseS+8=;
 b=k6/uc3jrt7I0bkUl2hMzFjuu2IEecgCMRu8pSTsCqLpkR523Y5+SDctnPe7AJ3oE7OkSESO4eFfISf8iVr5QiJftugIHbbZY5PH0wTgmQRL1/GToZFMrd54lIJEs/jXWMekGgH21Xh9T0MX/8ri+JX4aN1L6NzZmn3/QVMMJn7JLzNuY7czT3S7MUriA3lqvTDJNmRd7bSVm7n86hNs1JN+QfgGVP0yAFaTOmExKwFK6LEIp6c5QxLCmNd+4FlzboRX3j5gfywOu8+PTDUH2NKbVzhyJZ4lyhfTQUHh0FCGPBLGvVmRsx4sowaFMWjllJVK0yhS+4LxsAAYcZ2g2Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ezhcTUNCF2KNM0+7DnC49nOxZeBYouwoO2SyLEseS+8=;
 b=defr51zwDdiS4ZnUQ+I9FaSZEIoW3N2H8JzqwneeRhBnCKF5GdqOgLoAKTzjmZmBQWMgvPk6dfJvaZ5gBooAD+ytmmU1kioWkPdbamNQHcj7lyAQ4Fb7qz8mbNmhQKHvuzYV77zlvSIji+EkbGI+/+3FbJ7D+XwdP2n2zlMDuGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com (2603:10a6:102:c4::9)
 by DU0PR04MB9672.eurprd04.prod.outlook.com (2603:10a6:10:31d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 09:00:11 +0000
Received: from PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af]) by PA4PR04MB7982.eurprd04.prod.outlook.com
 ([fe80::3c4:afd5:49ac:77af%4]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 09:00:11 +0000
Message-ID: <cee89831-9ece-4dd7-b021-538c6fcacfae@cherry.de>
Date: Mon, 17 Jun 2024 11:00:08 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] bootstd: Replace bootmethod(s) -> bootmeth(s)
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Mario Six <mario.six@gdsys.cc>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20240604-bootmeth-typos-v2-0-821683a95aaf@baylibre.com>
 <20240604-bootmeth-typos-v2-2-821683a95aaf@baylibre.com>
 <a7410171-c413-4815-8187-606d32b0c5b3@gmx.de> <87r0cwaxn2.fsf@baylibre.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <87r0cwaxn2.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To PA4PR04MB7982.eurprd04.prod.outlook.com
 (2603:10a6:102:c4::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7982:EE_|DU0PR04MB9672:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e06315d-9a44-4615-ae30-08dc8eabe4bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NmRJL1NYa2ZNZHoweWxDWkRtYnpZL2tna2xIeUtjbERvQ1RKdk0wTkFLRjNF?=
 =?utf-8?B?U1dXWVFMbjkrNlJkZXR4KzYwN1cvSGVDMGtENHVLRjIvUWpuMEt4MDVMU3Fk?=
 =?utf-8?B?TGl5T1R5V0xOa2lhRjJDelAxdnFuNFpNVGpnUlJINHJuelJ3SVdrRGFLZlNO?=
 =?utf-8?B?RkkxSnZtNkpJWXpRVUFjenVNRnNoTUZra21OYWJYdTAwVVYzam0reUtIOWJy?=
 =?utf-8?B?VGFaRkZWTkI4Z0d2SkdVamloWW0vYjFlakRCelRQL2tPUEpDbHVuaFJ3MFkz?=
 =?utf-8?B?czltd0Jxdm8yME5ZL2kwY0JqMCtOZHhCRDNDbkFwMEVqenRkNWZFUi9JRlF3?=
 =?utf-8?B?S3lmUHZMM1ZtSUI2ckN1a2tmVktpM3RXTFduSHVscG02SHFVeDh2UXZVTlJl?=
 =?utf-8?B?YjUvejJhY1JLMkl0aXlJK1JhTHk0TGI3SVBkcStIQXZsR3JSWHIvMmVtS20z?=
 =?utf-8?B?Yk9aMnRGWS80NFI2eTI5ZUh0dkFoUTFqR0d5MmQ3QkFDMjhVZ0hJRDV2QlRl?=
 =?utf-8?B?MzhFbEFCNnBxdW9aaUVZaTJsS3N5emxBbU8yQ0dqNkZONmNGUUJCUDYvZXlR?=
 =?utf-8?B?bGhZcnBYRFQ2ek5TS1FJQjVOSG9aSVMzMjR5Zzd6QVJBNG9QM0ZEWlFlT0xF?=
 =?utf-8?B?aE5PNVh1cU9hUlFYTnZzWUhLNERpK2RBTnVSemtKMEhWSEp2RW5nMnhuRWcw?=
 =?utf-8?B?RHpLS2J3c0s3ZFA1M2V3a043TTYxSFk2RWV2WVhtV3BQaXVBRW12RlJyeWxT?=
 =?utf-8?B?cGxVNkJKYWZub0tYbU85Z3dMZGRna2VVUHpQNEZKM09BdVdHejg3QkNXYTJO?=
 =?utf-8?B?NjNKNFlDWHIvdXk1eWtwRHBDdmRpTGdHb0ZnU2hkUDJkV3c0MU9UYy9MRUli?=
 =?utf-8?B?YnU0dUxVLzlaZDNxdUh5Y1pHN3ZTYkhUb2VnUGFyZGJ4NDBNWUtSSW4vRm8z?=
 =?utf-8?B?VzQycDAxeU5FVmZZUUNyektWZEx3eDRhY3B1OWczN2dKRDdDbHNIM0FBdlc1?=
 =?utf-8?B?NlJtVjBaKzNWWFlqTitMWVFuTUttS1RsSGVjQitjY2FmUDFVcXRWSXdRMDhU?=
 =?utf-8?B?clF5NHdKaWxXRnhjc21UZG52YnY1UnZRK3JZRXFJOVdZQ3RVVmwxTmFIM05Y?=
 =?utf-8?B?WTgxNGVKRGxyVUkvTzFzV0xjc09BYUliNVZZQXJYcjlSbjZyUDZacEJYZDI4?=
 =?utf-8?B?eU1NV3JRNzZNQnB3MUs4QmxWREYzdTM0YlRQajQwZUlTQ3dSZWNpVW5ZNHB6?=
 =?utf-8?B?RjZDbTFKQURhZEEvNFFqVkM4dXdxVkRQeW9CT3h1Zmh3eGpySHJ3Y05yZUps?=
 =?utf-8?B?R0o3VlYxUjlpMkFiQXRKR1RHalcveXJ6Rk1mdmpmQk00dFl6WGhGSW9iR0hZ?=
 =?utf-8?B?MEg1OFE2M0tzV250c0RtRysrMDQ5OVFmTVdielBGeVk1cEJ4RmJKRWtEakF2?=
 =?utf-8?B?TnE5ekNwNENwZnJFNTBhVWRpMC9NSzEreXBLM2hkZ3BlZkZjbnlDZXNQQ1lQ?=
 =?utf-8?B?SUNmWWF2S0sxajYvWFBlR3N3c2dwY2dnN1RKK3phSGR3YmV6T3plOWR0NTZi?=
 =?utf-8?B?WWo1YlFGb2xnbFhJcExsa1VaeEh2bEtKdUpKVGRXeTFKcW45K0ZqbDg3czdN?=
 =?utf-8?B?bzAzTTFsZFpkRHRMb2t2eTRCcEhmYnJJWnYwakdJY0c5MXd4RDFWczlqWEM4?=
 =?utf-8?Q?YX2zv/9XXhOlpGwxNCTn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PA4PR04MB7982.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230037)(376011)(1800799021)(366013); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bElwb1Y3dGNzQ2o2aUgrY2FpOGNmVC9kYXlnTzhYdkxnL3p1MTNyNS8wNjdq?=
 =?utf-8?B?N3VNalBzSDF5TWFEYzlGcmo0T3ZNbGdLZWZMTkNlYS85bEJWZDFQdWhkUjdV?=
 =?utf-8?B?U0U5dFdOZVJqS1Z6eGcxNlVUWUVEbTRZZmFSN2Q0Yi9MS0ZXc1RJZDExbzAy?=
 =?utf-8?B?dkFnQ2pzUTI2YkJZMEFIbHVIb04zZjZkS3BMbStzZXM0ZGE1amo5M1FUNkpJ?=
 =?utf-8?B?SzVUaStUbjI5U2RZNmVnUE5Oa2Rvbk4wanByTDJ1RjdXZm9zcUFJMlhaQU9n?=
 =?utf-8?B?ZEZ4ZGNkMi91N0szNTlZTXJUK0RNdnNQYUVab1V0UjRKcjNNaHNHenBiay9W?=
 =?utf-8?B?K0FxNkZPV3JYV1ZYbkpRRURSMUJlaVlXMjBrVHl3Y29Sbi9SOW1iK1JvS29T?=
 =?utf-8?B?STFXZEdjMS92bTJkbXVBcjFSZzJnR3ZhNzlXQWVsaGl2SXlnTk1vVWgwKzFQ?=
 =?utf-8?B?Q1FLQXpDSWl1aXRXTHI4cGd0ODZZdWsvY3cvM3ErekF6Vlh2UmhoMkV5L1NP?=
 =?utf-8?B?ZUs5eGhUOEJnU3Rzc2IxbnRFbFZOM0lGMlBGZEhiSlJ2bGhIamtTWGI3akho?=
 =?utf-8?B?QjVGTzIyb1dOQ2xUSjFlSCs0RWhoZ3AwMGYwaGwwL2pNSVV0Y1NZWERiTkJH?=
 =?utf-8?B?VlVlR2llSXR3NW1wbmRhSmFXcDJwWWVZSGNEamN3YXFRVGUvWGNBUXFTSVM1?=
 =?utf-8?B?dkVla2Znb09LNTJiZlMzUjZuTmM3RlBqZU01S1lzRWIxZnAzNnN0UmdvaHE1?=
 =?utf-8?B?TG4xaHdxVjJGVHZxM1dXbjgzalRxeDZjcUxIZjNOMmhXVVNaNG9kZUJ5U0Za?=
 =?utf-8?B?SnJpTVZXSFd0dTlZQmVGL2dneWk3NUpKNnZVTWpGcTNwUStJZ0tiR2paSEtG?=
 =?utf-8?B?NC9MUjZBaHQzN20vQUZnZk0wSTN5cWxsRkFjdVBEWWtQNjNjSjJVUkdhUEFZ?=
 =?utf-8?B?NlBKOUNjWENhTEVUV2FOZW9MQXhXVUVMRk5yazc2aFBnSmRSY0ozMER5MXJX?=
 =?utf-8?B?K2FoWHdGSmJJckowbVhGYThoWkk4SXF5RlhNVzIvNjZkVlNHYXhJUG5XMHFH?=
 =?utf-8?B?T0k3MCtkbm9hTXlsMU03dGZjQWVFckZoZHJWQ0FkdzBDRGN3dm1PbHhxaU5S?=
 =?utf-8?B?cGphaENEYnU5dXBDc0o4bXhNQllqcFl0R0M1VlJRbGtxdVFHeTJoL0FCeUpV?=
 =?utf-8?B?d3ptcGpFcmJpM1ZnRW5vNzhvTk9EdHUwWjVzQTUza3FQL0tCZExISFFtRjkz?=
 =?utf-8?B?M3hHeTVRNGdjZGVoTVJob01iaTdqZm8xLzdKSzdlSjFEcVB5Tjg2TzdCL1pM?=
 =?utf-8?B?SmZXVThIZlMvK1MxeW9HVEl6WWFWU1U4VTcrQm9VSTJWUkJuQ2RaRXhVajdz?=
 =?utf-8?B?ZzJFdHMyMFpPWnptVzQzbG1JdHEwTzBGbkJCZENsbzdXOGVRN2dTbk90M2xr?=
 =?utf-8?B?R1kzR2huQzFqb3c0UG44MUh2VVNzallUNFFnU2tpQVBvMGdGZmp4WEMyT1p1?=
 =?utf-8?B?YXpOUDlBRHN0MWRFZTBCMkk5YnNBQ2J3VTdyMHRId21oc0lYU1l5YTY0d2U0?=
 =?utf-8?B?Rm9EWnBzNDh0N0IzMXpyZ2tVaTRuSHNqZ3FucUtzaFg5eU9nMjBjOC96U1RN?=
 =?utf-8?B?M0lhRm9LcUZEMEV2QWRHeTgrdGYxMk9ka0QvSGRwbC9NN0NkdHBxMWtVWXhG?=
 =?utf-8?B?QmJESnVFL1pFcG1OVEtxNWwzT3hNSTZPMEE2ZHpmWm5INlArZG1lNFh1Z1JQ?=
 =?utf-8?B?ck1Zc0VGaXQ4UVFwMXlPelBkODhLSEtzcy9weDhCcmdxNDhoTFgrUGwycG8z?=
 =?utf-8?B?MlVVd3Z1eW5wZFBBZ3d1eHNFdWJHZVhwamNhQnNmSHg5cWd6b2llNU1rTExP?=
 =?utf-8?B?aGs0UlE1M3RreDNWUHhpUTJkZXlUT0lINjdMNUNJclN4Z3ZoUDFMQ0xIQUc3?=
 =?utf-8?B?Uk8rbGgyMncvNTdrcHRydmlXOURNMktYZ2N2aStFSjZ1aUplbyt3bysxdFU0?=
 =?utf-8?B?TmtIRGgyS1ZQa3QxTk1CZldZRjRsUURxWTh2M3ZURk5NckNhSkpzZ0FTOWw2?=
 =?utf-8?B?S254QkprUmFDSzRJY0pWREVDb3dOMyt3T2Z0c0dZcXpWNXFpSnAzMEIrZ280?=
 =?utf-8?B?Y0NtL2liLzlvQW16U29TNTVYS09IaHdIMTQwZTB1YTFKVldleWVZV2VNRDlu?=
 =?utf-8?B?alE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e06315d-9a44-4615-ae30-08dc8eabe4bb
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7982.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 09:00:11.0406 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kPC9J0UZ3ieRTpu5f1Co/YJtEjPJbNRgeizemD5muljXLDHJtpQAdJ2UXbGUSHGRWgS0K+z5JAv59L3lOjqUViBAoYz/UgXoqiZfupK23vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9672
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

Hi all,

On 6/17/24 8:31 AM, Mattijs Korpershoek wrote:
> Hi Heinrich,
> 
> Thank you for your review.
> 
> On dim., juin 16, 2024 at 09:38, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> 
>> On 6/4/24 17:15, Mattijs Korpershoek wrote:
>>> According to [1], we should use bootmeth when describing the
>>> struct bootmeth:
>>>
>>> """
>>> For version 2, a new naming scheme is used as above:
>>>
>>>       - bootdev is used instead of bootdevice, because 'device' is overused,
>>>           is everywhere in U-Boot, can be confused with udevice
>>
>> Boot devices are udevices though they don't relate to hardware but to an
>> abstract concept.
>>
>> bootdev is just an abbreviation. This does not make the meaning any clearer.
> 
> Per my understanding, the name for this concept is "bootdev", not
> "boot device", see:
> 
> https://docs.u-boot.org/en/latest/develop/bootstd.html#introduction
> 
>>
>>>       - bootmeth - because 'method' is too vanilla, appears 1300 times in
>>>           U-Boot
>>> """
>>
>> Avoiding abbreviations like bootdev and bootmeth improved readability.
> 
> The above paragraph is quoted from email [1].
> In this email, Simon made the choice to use bootmeth and bootdev
> when pushing the initial implementation.
> 
> This patch just corrects the places where the older terminology
> (bootmethod, bootdevice) was still used.
> 

The current wording is just incorrect, so it needs to be fixed. We have 
two choices: use the struct/abbreviated name (bootdevice -> bootdev; 
bootmethod -> bootmeth) or the full name (bootdevice -> boot device; 
bootmethod -> boot method).

Heinrich are you suggesting we go for full name instead?

board/sandbox/sandbox.env should be using bootmeth instead as that's the 
name of the feature?

Cheers,
Quentin
