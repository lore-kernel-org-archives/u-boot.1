Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9A16CD4F54
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 06:38:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0EC7B88663;
	Thu,  5 Sep 2024 08:38:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="o7pFOfwP";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 93A1188B84; Thu,  5 Sep 2024 08:38:28 +0200 (CEST)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2607::613])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5BE0D88001
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 08:38:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jan.kiszka@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jrEdRLBHRxUzahpOqJB/ElN6OuXZXhxpomefxPcfJcSNy074jWC9U9UNvyQPw4ArZHFl1gAqJzGHtwhLcl+Gm8qbQT534YYCGvm1AdOuizns2bfu/Dad3IrctZp+CI+hX+ag3IoFR9K/rcnGnT+Cf9rIn1Zd4nrMjfB6Y5qWtdJLKlM9qPdGL+LWNjxYbD1TMljl3aWVjS38Bp7cLMSPOo+5Arn6n2+B+y6wThepPkqPFinPlYWi85Yb7sJonJBnTaLWcUWTUnIJimylQ/ylv9gXV9K/6d2WDYwsBKtrNVaYmE91P/rOXE5iMqkG//9J39MXavZCnmud8pRdkzB4Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XBqVFWEIqyfQFd4yc68+5ImtoUx2DsmktCCtI0UobDg=;
 b=n4FtZ1NoBbZHEJPLNNrZfXIaeclixieyEUbFWSlazAg2KpeyAV44EK49iUwUr18lRpBEeQEqh2laUoLlyDWimUVQwMSq+xgiVzjIwxzql5EavTf+nb5Ud4F6Bi+ZehsOEIOc+4fUyaZN335tTY56/m0TH4sI3OJ69SwyavhXOQ0intetg/wQ3kpuFYz1/hADJuFBksOJMBVrYVYtJEqviaLm4QctveQouw/1yaO+OZoWRzxpv382pbU59Y6LL7zlNbtnLzaO1a0mBhWGg4YGD16HITwwna9oJz3EJ0+HQyGNCkTc0OY0AGzTTS7UeVUY/qTdXOCh3SzvBTmjZKF87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBqVFWEIqyfQFd4yc68+5ImtoUx2DsmktCCtI0UobDg=;
 b=o7pFOfwPVYZGamNCyokMeY2mN44fY9zm2nGPwQKcrasoM9ch9DthXzB2bYaGSHGsQQ6JMUXqN6LzYuiFSqPT9raDSJ+4HXGFbg4rBnMpCGCCBq8KsGiaQyX+VFcJ5DsjKKLxswylU47BLfiFHhVTjI/NHAzbDQxfT5cHeOhSp6eu1HlJH+/zRsFVjjEoH83uQLMhqkCxesiPEMcLpevglOSAmuKW3gNZFVqXlaugnAOx8DkejH5X/UCJtY9iLTgllJ6Mh6BzgfyhNTntYEMyeSpVCwFfEHpLyn8YBRYSfZPlm/iXDrrp+gyi6X17skh8/W7ivLFmHTwRa21+SbllHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DB9PR10MB7100.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:45a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 06:38:23 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 06:38:23 +0000
Message-ID: <331b4f3f-6b4a-470b-897d-03ac09fd9c0d@siemens.com>
Date: Thu, 5 Sep 2024 08:38:20 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: OF_UPSTREAM vs. additional dtbs
To: Frank Wunderlich <frank-w@public-files.de>,
 Sumit Garg <sumit.garg@linaro.org>
Cc: Nishanth Menon <nm@ti.com>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <7765273f-7f36-41e4-a604-1901e4fbec62@siemens.com>
 <20240813125245.ezlu6me3ljwx6dkj@margarine>
 <89f8e976-e831-4035-8cd0-ab6284846d0a@siemens.com>
 <4ec5108f-b7a4-47db-baa4-edee532c58af@siemens.com>
 <CAFA6WYMQustcwo4Es7iJQj5Lva6UiYJ-j7WgSzMjOvEHemeDcQ@mail.gmail.com>
 <4576b818-9732-45ff-a4ab-b98fc0ecf4c9@siemens.com>
 <CAFA6WYNXgJkCX9-aoL5FGchAHGdV+ikTt4+pTJP-jZ_UJG8E6Q@mail.gmail.com>
 <87a9fe3e-5d9a-41e8-a8b2-4368cb727a65@siemens.com>
 <CAFA6WYMGyMAB=m-hkxs87PyHszcbQUk6+0_G0n+0-Yk8NeRXQQ@mail.gmail.com>
 <f61a8c74-9838-481e-aa1e-09fcc07f044e@siemens.com>
 <CAFA6WYNdS0jZ1iESfCErX92SOL2fJSRNNLZ1a_7jHoSfOUrdgw@mail.gmail.com>
 <0ff5653f-60e2-49ee-b68b-d86801aa1d66@siemens.com>
 <trinity-13f6d284-1ea6-4a53-ad60-847791f0c127-1725470974423@3c-app-gmx-bs17>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <trinity-13f6d284-1ea6-4a53-ad60-847791f0c127-1725470974423@3c-app-gmx-bs17>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0258.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::10) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DB9PR10MB7100:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a642f04-13a5-424c-fe6c-08dccd7556e5
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TTVnY1IzS3NNNFltTUNvMkp5aGN6VnJ4SnFMYkZwWDdLL0RGVTRaRnJ4MWpx?=
 =?utf-8?B?M1haOEZMSFVxM0ovMVlyTDkzb2NVV2tKanRsejJnWDdVWWNNSk8zc200L01i?=
 =?utf-8?B?NFB3a3hqZ0V4NXhJZ1ZmRXVTWmF6YmxXMnoycHlLbm9qOUdsbHRwSEZ3OWoz?=
 =?utf-8?B?cW5iWWdud3BHRDJzdkJyVkFCY1JGcHp3dkZWY2MxT0hFaHpxY28xU3E1cnpi?=
 =?utf-8?B?Mm11VndOU2ZlTG43KzhZcjhuaEFzTUYvTE9USVlKODlNWktIdTNkYzFFb0da?=
 =?utf-8?B?TlplSkw2M2dsR1NJYWRYc2N3L01EcVFlbU5JL0h5MXNTNy9ycS84N2RYOHps?=
 =?utf-8?B?R01VeWJsbS9sTHJQUXZicU16enVkRTdqMVhvRWVLUXdVL2pWcEJPbyt2azZ1?=
 =?utf-8?B?Tm1LNUc3Y1BPQkViU0R6UDBWWjRUR2NlczJHdHU1YTg2eFRQblpxSUprWkRW?=
 =?utf-8?B?bm9QQUQ2WUtsWUpHMVJrNUhjNDdiU2VQUk16VWZIMmdvVERabndRTmNGeUpq?=
 =?utf-8?B?K3dxazVpZGZFSTZIL1dzY3FzMDd3VnVwa3hVZVNCcEtrMnF4T1hRdTRUS0Ra?=
 =?utf-8?B?TVVQWWc1eWNRTlhwam1ydlMwWWNzS2NnRll2aDFGMHBmZ1RzSmNsWHZNMlMx?=
 =?utf-8?B?ay90YXpHK0VPVzdyWUVLcXdBQXlRVVJOSVBCWGR5WkZUMkhmV2pIZklTem5a?=
 =?utf-8?B?UXpXUTFyRGVBaHI1N0FJZkZXaE5BREdxWG03MXlKbGoxcmprYUZwVVhTUFMv?=
 =?utf-8?B?eU15b01zVDhndHJrbEloWTlDdlgwWEh0WGFTbmcyTEMxNkpuaWdWWDdzMW5x?=
 =?utf-8?B?RnhCRzdLOWVEdUlrdmJXTzBRcVJGM1M1Q1hETmI2dU1Bekt5cllBZEw3b0pG?=
 =?utf-8?B?am41STR4NjhWdy84U2tZeTR1VnE2WkRweDZNM1pLaTV0NEhHV0tzWUxESjJz?=
 =?utf-8?B?SzVLMUxlYjc0aUM0UHVhS1FXYWdMWUFuMHlUSFVqRk8ycHovTTFycXZDUk16?=
 =?utf-8?B?NmU3eGIxeGxYWUhhOSswMHFuZjBaOG1YTDdBTHB0MkRwWXBaQ0F3ZGM1V1gx?=
 =?utf-8?B?NlJORm15dDFBeC9zc09Ed1lhcVVDdlh1VXR0dkdZSVZuK3NPTjU4TlZrZVhx?=
 =?utf-8?B?bHZIZ3NGT0FSSll4TEhtTjRyQ2VmQmlQc0RxdjZrNStvS2wyYTRZcVVKR3A1?=
 =?utf-8?B?ZlY5TUdZeWNaM2w5Vm5IUmtpQnZiNzFBRThZOGNZNXVEL2hLRVhRWkZwT0E3?=
 =?utf-8?B?bkpScW5xQjlYSEI5b2MyT2UzZjRyS05VVkErbGxVR3dYcjN0S2JtZzFjY082?=
 =?utf-8?B?VmhnUkVXc1QySFJZL256Qmg0bExtZEt0d3ZTclovWEFSdi95ekpHRm83R2FP?=
 =?utf-8?B?cnJIMDNUdys5Tm1ROVhBQjhDb21QSCs3UGp1OUhCNGhNNDdqK2pxUllnYkhs?=
 =?utf-8?B?MURIUTFPTnBHdzJMcytPSW9ONVRpV0x5WnFWQUhUNnowSTIxbU0xcTkzSW40?=
 =?utf-8?B?ZE1JVnBIOUNBWWZNaThjUXg0d3JkeFNVT2gvSVgvWXgwYnJIRW5TVU9Na3lt?=
 =?utf-8?B?Vjh1NVE3b0IxMGR5VnFDK2ZXWUNxWHRCTGR3a09lM0p3OW8wdFc0WHhiTDR4?=
 =?utf-8?B?YWJ0WjMzZ202b0JacjM3bElEdDVIamM4ZEpXaVFuUVVqelRSV3NQZHcrTDhS?=
 =?utf-8?B?QnFNanlZSVdRRDNZL2VyMFFjSXJFbnpPWDBjMmcyZjRlSkV4UVNsOFVOTWJL?=
 =?utf-8?B?bkI0UnR1MVFod3VQNWZYQWFCRG5vNTZVVGJmU0NjM28ra2Q3KzcwT2xRMzl3?=
 =?utf-8?Q?bVMF5iCSidEAwTQQEBwJmORx0Gr9aPVDiquRc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFdMcS94R1h3TjViNlhRcXNJRW15ZWNncGdUNU1UQlVoYlRpQ1JtSnBkaVFD?=
 =?utf-8?B?Mk0xWDljTy9GVUFqM3pwbWdxWWxpME9mWWIvN29JTTViYmFoMzVRNkw0U1hw?=
 =?utf-8?B?YmdDYjhIZlNyS3UrTS9Lc3pSWEhjVlZ6T2RwLzN0RjZVeW9oZ01HV21xaC9L?=
 =?utf-8?B?VG85U0pxMGdJalhQeC9BRWV5Y2MvVmRpUzRJczdLNkQzOVF3NjVVTS9yODNQ?=
 =?utf-8?B?K082SHdKZ0o5YVNaTC9VZEtWWnhocE4vMjlFQWVYMXp3TzMyWXVGeFV2VmR4?=
 =?utf-8?B?eHlkZFd1b0hlQmpjZ1FvZUtwQXppbURSd1dEc0doTmdUSW5iY2tPYWZPKzNP?=
 =?utf-8?B?bGw1THRqaGhhZDYwRHRmbG5Gd3ZyOXBkRWloQ0ZhNDNBRWFEc29zWWR6bTho?=
 =?utf-8?B?cWRGRkE5NXMrVmlyV0dueTFSdy9Nd25FTko1bmhmdEJxZnc4MFAvNzVGbWE1?=
 =?utf-8?B?eFYwUTJNdHB2b2Rka0tiL3ZUdU85ckNhYXRzV0ZwK1pNWWNXejdXdk8xZVAx?=
 =?utf-8?B?ZS9LZnlESFI3VzRGZ3dUVFl3S1hYZmZnQWZxMTVONkpjVnZDWTl3WTgyQjlP?=
 =?utf-8?B?N2pLNDNGQkNEc0VuZWlVakVOT3JZZXBSVU43UnFOUEhXVDJWZWk4NlNnMmVI?=
 =?utf-8?B?TEpiaURZeTVnNjdGZ01KZ2FzRXZwSjBTMnVlc0RQT1VSNDdlZkd1ZFFwTVNZ?=
 =?utf-8?B?T3pIaDM5cnY4QVgybU81QWxPMDU3UVgzRWZSL1pOcHYvaGt2K0lFMU8xcWdx?=
 =?utf-8?B?UUR4ZjBqWFFMcDAvK1NRZDZSdUVMSGk2dDR5a3paSXJKQ29sWGxmU3prd3ln?=
 =?utf-8?B?SFp4VjZwREdYdUNkekk4MUpOajFKYm5veThTR0I0WVhCRUdqWmt0RXF1TE1J?=
 =?utf-8?B?SFMrTThMdkVwdyt4b24zaG1vZUFNK3VBWW1qQkdEOXYvNktSZjhSYjBFZjB4?=
 =?utf-8?B?R0pFRzJ4Y09vbGE4dFVuYXpZME9rRVhZMFB4d08zbWk4RkZBdVVYYnJlZFZE?=
 =?utf-8?B?UUhKbU13dW5Ga3o1UWQ4aDVScUc2MGtJYTk2YVo2ZmhINkxwSUlRVThGYWZI?=
 =?utf-8?B?cGQyTDVTMmRnZlhNazJkUHhrRUliQVlUNnN1d3dyYTN2UUN4OXh6Zkd3bkor?=
 =?utf-8?B?L0xOZC9sQ3ZjYjlVUDVqLzc5cTM5M2I1a3V2YVFDVmhRN1ZvNWpWenQ3TTIz?=
 =?utf-8?B?Rmc4cjcreU9NeTRKQzQxZ3BTRVRQcktkWHJET1JyRWVMam9qSk9JSUR6YXp4?=
 =?utf-8?B?VytQdDc2MUVGdW83eXRlcjNIUGx1bmdkV2VDamFqVWRMbXVqVEpDUzJYUFpS?=
 =?utf-8?B?R2w5R2pCeVFpODRRY25lZFA5V3dnWUNUVUJ2K3UxUGwzNW02NkxCV1g0MmhG?=
 =?utf-8?B?RXdMMVpQbWZBOENwSGdDRGh5V0xqOENjNHkrMldUMm9zUkVnWE51Njk4ZTRG?=
 =?utf-8?B?RzBHSStibFBnVTVzcVY5YmdBakkzNUpIa3V0TDdTYWFiT1pGdXpFbGt5T1Ba?=
 =?utf-8?B?M1o2c3FYVHk0RzNhTkhLbzczaGl5SFUxa09SaHdXNkZBWjhvSVV2dStFQ2lJ?=
 =?utf-8?B?QW1CUTNETHlRTWttQzVUeU9LZ1FCd3JLbTRJY2IxdGJoc0dIMHI1ZDY1bzBq?=
 =?utf-8?B?SUpZVlB6bC9EZVdUSFdkL0dzYW8xWVNsR1MzbVEzT3liN1FzR2RMemxxaGNB?=
 =?utf-8?B?VG1JZ3BuZC85aEdLRWowcjlFbE53b2tELzVxMkY1RldPVG03UnVYdTdWZU0x?=
 =?utf-8?B?VTlnVy9pVkE1dDhCK2tTUmFrRmV5dzdDQ2VLZXZoaGdtdllZd0FiT0Z5dEFC?=
 =?utf-8?B?dldyb3VYc1FZTktuajBYMm5TdzJ3b25SY1ppL1ZIWXhJd1dNd2h6MjBtY3BX?=
 =?utf-8?B?MFZxY0ZGVG14VlRvMExiZGlXbmltTGJXVGZ6RlE4TDNDc05ySFNDaWhaV2Vx?=
 =?utf-8?B?ZmlqK1NLMWtORUZ3eEJDQ3RDSWUwYURnRnN2d0xzRTlYZHhDTVNucmx2YkF4?=
 =?utf-8?B?ZVk5dHVSRnVSeWNIajhIbVY4R3NZUW5acVRuNlFuYU05bW9zMzQrM3NST2px?=
 =?utf-8?B?RlNvbVUwR05Cb2xQc3dkbmVwMTRTUWNpSlh3S3Z2TWtCUEVGWHMvczQ5eEhR?=
 =?utf-8?B?VmdvcWVPVVduRGxqaHAwUS9DUkJ5aDdjdkZGV0d2amQwdzNiM3B5NkFIT095?=
 =?utf-8?B?aEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a642f04-13a5-424c-fe6c-08dccd7556e5
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 06:38:23.3556 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ctq2Byh8LOeWpDvBI2sjDXwS7tbzmt5Cw5oZoG8kGlWDmG2ZcAH7/pxY9e9nmzX6PqPSz9gpvTGE6/oMGsoySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB7100
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

On 04.09.24 19:29, Frank Wunderlich wrote:
> 
> 
>> Gesendet: Mittwoch, 04. September 2024 um 19:16 Uhr
>> Von: "Jan Kiszka" <jan.kiszka@siemens.com>
>> OK, our overlay sources are on their way into mainline, will only take
>> until 6.12-rc1 to get them here. To accelerate the preparation, I ported
>> that change to a local branch - just to find out that OF_UPSTREAM has no
>> clue about DT overlays so far. And it is not just that there are no
>> build rules for them (that was quickly fixed). It's also that there is
>> no way to trigger their build for your u-boot proper.
>>
>> Are there plans for addressing this? I'm inclined to revive my patch
>> that allows to augment dtb-y from the board's config.mk. Better suggestions?
> 
> Hi
> 
> i hang also on this part, in my case i build the dtbos for the vendor and try to use fdtoverlay to merge base-dt with the defined overlays.
> 
> see commits till July 11th
> 
> https://github.com/frank-w/u-boot/commits/2024-07-bpi-ofupstream-all/
> 
> this fails because the target for fdtoverlays needs targets for the dtbos (have used the fdtoverlay target from linux)...
> but i build then without dedicated target (while building the basedt).
> 
> maybe you can help solving the "small" problem in makefile.
> 

This is close but not quite the same scenario because I only need "our" 
dtbos, and there is no need to create dtbs with them applied (they will 
be used during dt fixup in our case).

What I've now done is this:

diff --git a/dts/Kconfig b/dts/Kconfig
index 569d4be338e..7ea4fd5a79b 100644
--- a/dts/Kconfig
+++ b/dts/Kconfig
@@ -226,11 +226,11 @@ config OF_LIST
 
 config OF_OVERLAY_LIST
 	string "List of device tree overlays to include for DT control"
-	depends on SPL_LOAD_FIT_APPLY_OVERLAY
 	help
 	  This option specifies a list of device tree overlays to use for DT
 	  control. This option can then be used by a FIT generator to include
-	  the overlays in the FIT image.
+	  the overlays in the FIT image or by binman when assembling an image
+	  that uses overlays during DT fixup.
 
 choice
 	prompt "OF LIST compression"
diff --git a/scripts/Makefile.dts b/scripts/Makefile.dts
index 790f3c508f1..dc181240a21 100644
--- a/scripts/Makefile.dts
+++ b/scripts/Makefile.dts
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0+
 
 dtb-y += $(patsubst %,%.dtb,$(subst ",,$(CONFIG_DEFAULT_DEVICE_TREE) $(CONFIG_OF_LIST) $(CONFIG_SPL_OF_LIST)))
+dtb-y += $(patsubst %,%.dtbo,$(subst ",,$(CONFIG_OF_OVERLAY_LIST)))
 
 ifeq ($(CONFIG_OF_UPSTREAM_BUILD_VENDOR),y)
 ifeq ($(CONFIG_ARM64),y)


I will also provide a patch to enhance the machinery in dts/upstream
/Makefile. This apparently plays no role when building U-Boot, but it 
would still be useful for validation purposes to have overlay support 
there.

Jan

-- 
Siemens AG, Technology
Linux Expert Center

