Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D202D35162
	for <u-boot@archiver.kernel.org>; Wed,  1 Apr 2026 09:28:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBB2083CE3;
	Wed,  1 Apr 2026 11:28:39 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="cKNLaX5N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5890484010; Wed,  1 Apr 2026 11:28:38 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 04E9980212
 for <u-boot@lists.denx.de>; Wed,  1 Apr 2026 11:28:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MabBaECgXKdL+PMa/AulyZ6pRpGgWfd8oQyKJvkjVJojAIcGB1nwRgtaRzQ/5kyOFtZcTr7kLtwx5KQbZbvpNETY8a7btFXsnHhthQoRygya4lEL8HJRDsZ/Oitrx9C470+v8OhIXtG81qpEa/YcUtIIYXKGnEij8z95H6+hYqtvpiOrrOsEBsdT37rvAYdlgDYZ4jNFTXPY7kqfK+Pa8cl7XRHsi5Rew6v0TLRBtB1/eB88nUsNAtFkobHBFq6Ao8o99emfRISZnIOyypitpjqs7lgxeAtvweDw9Ni940pBGS7O/vxiHLxJFXQygCloWk1I5B6HiZ4BTipFjX/HGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G62HfCGaAihiWwQgtcdtuDYMfNiG/SmCI/1BmKDcu1Q=;
 b=M8mjr5o3Ce6m2/rKah0Xao2tWGtlZ/jnWe5CpqzYU17/R9TpzrESvD4XEQm3I8yCETnMCSoTFY04iVRF4OlyaiyRJwsMjaHglc3ouDi06+6kHeIX+v52VqfxIDj7ib4nPq3Xde8MpHphIr2EEJnn1WKDWh0JmuzKchzu2BnLSM3qYpyqwzhMS3XrvdEhPXiQALiw6NRBeDvoLwy1ykEGXJQ5wUMxpbuiN8VEZCk480CAp5DFb93LQdG7ShmFXHTHBwYrcaCYHmkyMQbv8roHUJ0Pen07/BpWgy+rc5kF6HO2Y5fi4CIaSwwTdYcf8au8s7mJvJmDJ1RcMEgxJOFmsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G62HfCGaAihiWwQgtcdtuDYMfNiG/SmCI/1BmKDcu1Q=;
 b=cKNLaX5NiUDtkhTyfrY/kYCshfA5QBfQSytHIsaf90XuNbymzzoTS67d8xLlOP7GJ7ZmiPGcWJ4MjPgDaPGke4WAxidns/NtrH1+ZE3C2QwmiAiaS2PiXVEBEoRBiXgut3yBwO2CxhhsX5nzN0utXRWO7jKEGQ5T1JYPbFRC91A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com (2603:10a6:10:1e5::22)
 by DU6PR04MB11205.eurprd04.prod.outlook.com (2603:10a6:10:5c1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 09:28:32 +0000
Received: from DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00]) by DBBPR04MB7737.eurprd04.prod.outlook.com
 ([fe80::5960:fb4b:9313:2b00%4]) with mapi id 15.20.9745.027; Wed, 1 Apr 2026
 09:28:32 +0000
Message-ID: <d65423f2-9dae-4bf6-a1d4-fcaed430ac7d@cherry.de>
Date: Wed, 1 Apr 2026 11:28:30 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cli: flush stdin before enabling cli
To: Gregor Herburger <gregor.herburger@linutronix.de>, u-boot@lists.denx.de
Cc: Andrew Goodbody <andrew.goodbody@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>
References: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260331110413.1040527-1-gregor.herburger@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0340.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ea::19) To DBBPR04MB7737.eurprd04.prod.outlook.com
 (2603:10a6:10:1e5::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7737:EE_|DU6PR04MB11205:EE_
X-MS-Office365-Filtering-Correlation-Id: fd55b7b2-0d8d-4a91-a536-08de8fd10ab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: YOquJwV5qw5MyPEDat8A3pnSps7yR38eCZFa9OJxVLylaYbetM+tgt3VJDtAyz5mGp9k3JXW8UZdDXa2qKx6gYnTBmxYsBFk/KjhL5UWh9KdjSZujcmeaZq/oSHv4OV1I0+0dpGv/qSmWCUBqNPGS6Yp7auJ3HZP1gZBCOHMPttdmiBjszT6gZ2f0zawI8qCsnS46xANHj+mgz1v0I4z1MptTMZBntc8IQ1HgPGiDOOTTXFlE6dyB5lwDoWzwlkvfWrJhaGd1sM6uu6KlkU+4IwDzyFyT+qshbzH+GOn9R+9buwJbu1hOunr38xBLnn5dEZU+5LPEFMZUQUWxwhl8l7JL8NFzwhDsXjiEpx2mZJEY/j4ofGPhDA26qkAt+VxHN+y7WIQW+P79dac9NfqNIj0jaVfQ60E6vsv2r9aoPFgBbuPYVw8yAbSd/HdIvazgr4UlLGCACh9a7Sd60jzmKG2ZIyGmEMYrlHxECZUi+w9+NWF2NR52/wTBQIsnDbKh/j1g4tfRzIpHIlBQBr5XqBiI5aIdXh8Nh0oYIIAYfEY0aSqyCBPgQMeojdVphjhODkryf5lGbKc3MnNvgSOaWT0K20ujzdVDIR6g7p15cI5T5byupqbxXCqkoF4d95Z/wgE4s8irao/MSP32xQ7ufI/dwUFN5AzUIfq6yBT17uE9hQX+ygbgvPo0whgoWlZYxN83RFuutpcUAbooGmqdKYQS/prrvqgKS6ZiDOnDfI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DBBPR04MB7737.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjBDWUVIVmVBL1gvL2lTVUxoSm5OOEk3NU1mR3RyMFlTRkRnVXpXcVdHY3VC?=
 =?utf-8?B?MmFacHZicUdjbzcwOThNSkhiam80ZUhZQ0xSbDdyWHFoU0tsSUxCaGx6ZmNE?=
 =?utf-8?B?eHFwL0dmcTdzVGNMMVNFRDVMVFlCOUhGakdRUnRYclNqV3hqSjVpMVNURnBH?=
 =?utf-8?B?TjJDaGV6YVNIMVEyZ0pQbW83Y3VpSWF4UmN0azZCb1dGd2c5T1RQc3pwdDdu?=
 =?utf-8?B?UlZOckRUVVQxeDNrTFVqR2tBQTlCTEw0enB5QVZtWm82QXh3WTN6YndlajZ0?=
 =?utf-8?B?MjZmVmFWNkM3YnJKRWhOTFJxNVc2WENkS1RwYjJ2eGZxMFFoN0d6di9KRkNn?=
 =?utf-8?B?Sitvek03dm5TbW5WSU90Y1FMTDhJRzUzR2xQMVBwTlNEeVNTK3FyZDVuT3cx?=
 =?utf-8?B?Y01PVzg3M3ZJd1dXNlNvRmM3VEl0MU92ZU8zWmMrM1J5UWJuZ0QzaS8rQ3ZX?=
 =?utf-8?B?a1FtZkEvQWp3Q2k2SEN3dkRsYUd3dndrUVdOUCtjcmFGSVRVUUxoMlV3Sjd1?=
 =?utf-8?B?bmpTU2VxMmM1ZkRPeDJGMHI3Y056YWxhUkFndjloZEhJMmt4Y2J2T3o5cTdl?=
 =?utf-8?B?cU5aM216dlVtcG8rUVU5cGtFMTBEa0xJYUpMUmkrRTN5UUUvTlpGamZMOVo3?=
 =?utf-8?B?aDF3dWgrQjZvWGtSY3R5Z1pkdXdTQUtHTHB4YktVQ2hOWXVqYkVSeEk0eW8v?=
 =?utf-8?B?YVloMG5sRWJpS0huL1FQcHpyL2dxWWtRMDFrVjhDWmhBVmVJSnd1VEwzWk00?=
 =?utf-8?B?NkQwTGtzQkNHNG5nampoZVlkbHEyWWhsaEEybmVDaWVsUko0Y04wVXdOc2hj?=
 =?utf-8?B?VFBSbTVNSC9CbjhXNUZTWWx4cGt6b0RJdjF0RXorM3JucUVuN1pTTm10a2pq?=
 =?utf-8?B?dDZhd3E3T2NZUG9FcC9GeGRldjhhNmtJWXFnZXhBRVVrdU9lejhhS240Q3Jj?=
 =?utf-8?B?TWJDWWV2SlA4dSt6eUE0SzNUQnBuRzZneXFWdFIzM1pxWWZ6RUNlSktRaVJj?=
 =?utf-8?B?MFRZZFY0S2VMNGZoaU9nenhzVzJod1lDVERFOVlqSHBoUFQ0SXlnbDQ3Z3NC?=
 =?utf-8?B?Q0Z3b2VXU214MjFtL1ZGMlZIcE9zaVZGSU1ja2IxdndOZk9HaHF5Z093WTRj?=
 =?utf-8?B?Zm0rRGpPZE1ORUYwcXlSRjJaOWhVRjZCZG1UOUE3Tm1PM3RsZ3B3S0FYUi9U?=
 =?utf-8?B?WUl6QWh6TDRqK0FkVEhMa1A5UWRXTzNvYnFqVmttWEVNNWVyazhIZXJMdDd3?=
 =?utf-8?B?MXl3VFlldjVrSnlpT1lMekh5Z0hCcnd2MTZYY1Z2b3lJekQ5cUx0dUlXVU5M?=
 =?utf-8?B?UjVPa0lwNVJsRVFoZ2RuK2xIT1dqN05UZVdNTnBQNjFDTXpPaUdKVnlqSDZi?=
 =?utf-8?B?WUcrN3NDR0dJZjFuWk8xMzA3V2ZUdTdVRVFWaE5kcEN5QURBTlhNR01ibDJN?=
 =?utf-8?B?ZUZMbXU3amVKcFQzUXFNRFhuSXZCUnZ6ZzdvR1BoUGZaZ3o0N2c5ZWdjUHZ1?=
 =?utf-8?B?eXlkWk8vc1JRS3lHei9iZElvN2RYRkJqTzBRMXpmaXdOM0YyNXltTFZWRUht?=
 =?utf-8?B?RWI5WFdDN2pzMDNNeXRVbm9SVVpIZFF4VzFqZU1lOGVKbGswYSsyYkFUTUtZ?=
 =?utf-8?B?SlhhQXZBQWVxWWFLODlVQlZzRTBrVWYrS0E5c3FQQUNaSHFIcjRDYisweUdm?=
 =?utf-8?B?SDRHZzlheHFtTU56bFM1R3ZrZ3VrV2hoMkdBUEQ2SHdFNC9Rc1VLMXNzMTcr?=
 =?utf-8?B?S2dDRFdnTmNmUVJ2N2k5WU5VTDJONGJ3V0U1dmFMdUh6MDVubTFaVzFhTkVQ?=
 =?utf-8?B?eWNManN6bFVLRGN3N1ZVdjgvb0JSb0JGS21tMmpvYkw4VVd3MlJSTHZqeGlz?=
 =?utf-8?B?SGp5V3lTNkhSZlJXRE9kOU01MTE3enJFcWxSREJSK21pTjRpMGp2dWJqUWxM?=
 =?utf-8?B?QnlvY0lHTHlVZ2JRclFyc1FKWVd5aHlZTXYrYmYvUmlpN1VnS1NTQjNxR256?=
 =?utf-8?B?eW54ZjhiTjh2dGxCUTZQcThFSzlsbXhGNTIwOU5WWTdDOVJ6ckV3ZExRalFY?=
 =?utf-8?B?N1JESSt1S0VyRHJEU0pML0F5WHJmd05PcVJ3d2o0RlNGd3FwN3JlRTBjRWlz?=
 =?utf-8?B?SDBuemY1ZFdGSXhtTWtnbTE2bS9Kc25ZMFVPbklGM1BTSW4rOEZCQy9wazNa?=
 =?utf-8?B?M1d6eHJxNTFNczNHOUlhTGFGcGpJZDg1MHA3T2xuNTRpdy9RSXNsVmtOcU1B?=
 =?utf-8?B?L0diOWdNMjllR0xQM284aktmUDVCbmpRd0lQNllvZk1iVFFIcHY2am1HdVll?=
 =?utf-8?B?TCtNQ2xHS2hjT0N3UnEwUVFHb1RLQjZhd2FNVjQ0M2hqbGtnT0VaTjFZR3Vx?=
 =?utf-8?Q?6kYj9ea4p1BwYOGeV93EEA+nWoyF5X15p9eJC?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fd55b7b2-0d8d-4a91-a536-08de8fd10ab2
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7737.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 09:28:32.4875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJSXbqtWaFjs94eCGQbinRMags6n84XgbN6XcFY6Igv5riO9aVFzcFNoCCVC66LSyg/vFrG9o76jBzpDd1Sj6b2RbFqzIG59OQqjHG6stbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU6PR04MB11205
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

Hi Gregor,

On 3/31/26 1:03 PM, Gregor Herburger wrote:
> [You don't often get email from gregor.herburger@linutronix.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> Currently there is no possibility to flush stdin after autocommands are
> executed. If in the bootcmd the stdin is changed, e.g. from nulldev to
> serial, it could happen that junk characters sit in the fifo and appear
> on the cli.
> 
> Add a option to clear stdin before starting the CLI.
> 

Why does this need an option? I don't know enough (anything really) 
about the cli in general but the wording seems to indicate this fixes an 
issue or even a bug. Is there a case in which we wouldn't want to flush?

Cheers,
Quentin
