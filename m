Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E104CEACEF
	for <u-boot@archiver.kernel.org>; Mon, 17 Nov 2025 07:37:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78D5D83A03;
	Mon, 17 Nov 2025 08:37:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="Rjiqq/1W";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DFD6783A64; Mon, 17 Nov 2025 08:37:38 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazlp170120002.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c001::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50272839B1
 for <u-boot@lists.denx.de>; Mon, 17 Nov 2025 08:37:36 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tien.fong.chee@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P/bbs1wRsY0H3PU4fpvIvchX08Kt6jGNGQGJjJ8HpODKd8j1fQWfAfAttLeT9UtG9lomHP5mGPyZb7R88sfIgq1X5bPyXOh669STe67nNPIyslZDE46d9h4bEBjyl90tvPr2oRSsFdW99H+W8V3WKY2XfqI/UYOePujPEHyCFGh6m19qFiXUdNcOmJ15vIosCLuWSsebHU7d/YJfgKcsm5m5hDDTxdG1RIoTC+JC6VQ1hZLGbaSoOu680PRzrTtey2MoCfrt/mZ6DI37YnVHYZdqG2tXjppUjKxubCOUL2Xeeumd/BmpkLgOAtSao72PINTEWGN/Z2nBucGFllcpzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKeyk/x76T6uAnu2flwW1q3Ja9q/6PN7gIa96aUuTjk=;
 b=JuDOJAmBnqR9P7hdu6Ce8KzElB8FMoEZa7jrl264Sa8NCgdkLXbhIGQGg7rbkqRHHYt2KjfcPMnKh0p0Ll6RqBz6lYwCcb+LxKe8zYmMiMx8jX07LQ2DIo81gGD9//3QGEweenBXMJMSmkUK1pcRbtFDE97P0ZAfl/biQ6uZ+PbK7973D58L3XHEwOleBFlwLkGrDjWBJ/YhOcfycZqUjCG4TSyQ/4ubJ0OyKA4PnPLqwBmTswpabKZFwSLXt8UqawTghnOrhqbnnJjFWToZbb4QVW+wHyXO5Zo/RrQcYeICYp0r/rsOtGw62+p9mLd8sFA3zYjkqP/vNo3GaO2o3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKeyk/x76T6uAnu2flwW1q3Ja9q/6PN7gIa96aUuTjk=;
 b=Rjiqq/1W2H0P17QkpFOUvYMgasD0Nq2RTipgZ1X0kB4o9dBaXA1+LAPLzDexvEZJcKejX6TOx9EO8pHL5+tu+eHlvDhtzPlHte3uNPRdu7PYdALbTtNZkCHbq/LzfuImq6oXmjdN6ZVovz5UxnngG9XjAzNa2UhF4ONpckxmF092tmjyvgJiNzhbdnLokeO7BxukYBlSc3xvytcNw48lABNus+pZ4usJQRvv5JJxQ/nhZXYtA44ildtDTJshoYW936/X96LMPFci4473xSlf1vUeDebaEncalQnyW+DmLnm2XbUD/ubtoGY04bqs7rrVEwpidH06HETMH04go4YtzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
Received: from LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
 by CH0PR03MB5986.namprd03.prod.outlook.com (2603:10b6:610:e1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 07:37:32 +0000
Received: from LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5]) by LV8PR03MB8137.namprd03.prod.outlook.com
 ([fe80::b25b:d888:f620:91f5%4]) with mapi id 15.20.9320.013; Mon, 17 Nov 2025
 07:37:32 +0000
Message-ID: <7bbbf316-5936-411b-9edb-a63e46a4af92@altera.com>
Date: Mon, 17 Nov 2025 15:37:25 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] FPGA2SDRAM setup fix
To: Brian Sune <briansune@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20251020133554.1901-1-briansune@gmail.com>
Content-Language: en-US
From: "Chee, Tien Fong" <tienfong.chee@altera.com>
In-Reply-To: <20251020133554.1901-1-briansune@gmail.com>
X-ClientProxiedBy: SG2PR04CA0161.apcprd04.prod.outlook.com (2603:1096:4::23)
 To LV8PR03MB8137.namprd03.prod.outlook.com (2603:10b6:408:295::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR03MB8137:EE_|CH0PR03MB5986:EE_
X-MS-Office365-Filtering-Correlation-Id: 403b1c71-fc8a-46fd-09ea-08de25ac2b11
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|7053199007|8096899003; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZU9PUW5JRlZvQnB4NmsyajcrcTR4Y0V2MzdJQ0U3cGw4VGZUTXErYXdQSlRy?=
 =?utf-8?B?ZkdKU0NQUFZzS0cyT0lWTE5INitYREtTQ2F3dEpjMkJMdjhlVjBiejFhTlBI?=
 =?utf-8?B?S3hDQVVxa3RFcytJYmZhS1JHSUE1SFBWS3dKUmVWUWNYZEtNYXBieTFqdFlM?=
 =?utf-8?B?czV5Q1J3Qjl3dlc3NUl6QmxFN0JPWVdKaWU4eWhoWmpxeGM4YmlTSXIrV1g5?=
 =?utf-8?B?aFFRRzUvaXF2WVVuNUlTVmVuc1pJQkJhT2Evakk1R3M4UmtYNFFJdkxxYTJr?=
 =?utf-8?B?VkwyQ0NibDQ5WlAxSS9RUmhQTy9SdG5NS2NuQlVVeHJ4TUJ6MW41U290S0J1?=
 =?utf-8?B?cVhzK3NieS96WHRWaHVqOVQvM1pWN2p0Syt5aGd0eFBMT0xsRGJQclNoTS9D?=
 =?utf-8?B?VThVeFgwamZoRmxZeVZwQnRrVkNoMXE4MkRDd1F1ZWh0L2l4S1RubDd5TnZx?=
 =?utf-8?B?cDROWFhSYmlndWQ3dzhJV2lkR1FDVVd0ZnFYYnZBVlQzcVNaQ1JkWkVaL2NF?=
 =?utf-8?B?TTdTd3pNbllFaHBld0NZaWs0bUp6VWU4M2xldmpwTkZWbmpOck8xN3lYcUJ5?=
 =?utf-8?B?anU2TzlyZjJHYmV4QlFEV08yVEg0VHV4bUIzRlpaUnFxeGRJblEzR2EvOHZo?=
 =?utf-8?B?enNjVUJqWVEzaEttU1BRTnV0T0t3a1pqa0kyTkU1emdSSkw1N05QOVJaNFpZ?=
 =?utf-8?B?UFBhYk14ZDQvRFh0SHArdnJmR0ZDcFZ5WUh5UUVPb1B1cjBBZlhIVzVISzNB?=
 =?utf-8?B?S1E0Mnp1YWw4cDF0Q3d5M3hQZDJLOHJPNFdqZ1JON1krOWZCQnI1bTZGSkRC?=
 =?utf-8?B?bWxQcjVPWE9JaXFTb3pZWFlyWThPekJLL1VqOEF1am5TVFViVU9TRkVJN3p1?=
 =?utf-8?B?aGdUZkNyd1NqdFRaYWVZQ1lBdklzZXdDY2ozekJObU5oNlFYMGFlR1BNNkcy?=
 =?utf-8?B?OEVzTytSMC90eXc2MUhhOUZab3V4NEpqWUJPdGY1bDlvQkxDY1gzRFFmN3c5?=
 =?utf-8?B?dlBGcjViaWdBcGJQcHJ3MU9hdm9mWkZ5enRCdDBiNitCbmlWUUN4a3BtZWsz?=
 =?utf-8?B?Rkp2eWUwWE1xSlBoNzRFTy9VY0VhYjFucml6L3NpTUpsNXMrZjU5cWY4enBN?=
 =?utf-8?B?UVFMWmwyMnJ6Tk1RMVdmREYvaDR5TWphbHBrNHV2QzduTnhiSml3dm5lVVdJ?=
 =?utf-8?B?dU9kai9heks3RXJwQ1F0RG0wM1o4ZlM5VjJMQ1Q2dUg2MVF5ODh2eUZacXFi?=
 =?utf-8?B?cHB5SUxGVVJlTFViZlBXZ1ROT0JQTWVxL3R3VFVYNmVsakZQYjhMeXVRRnp0?=
 =?utf-8?B?YSt0QmJETUVZWGU3ZTZia1VGK2RzS0NKSlZTTkZmd3dqWVdQVmUrNnYwc2h6?=
 =?utf-8?B?NjMwTFlockF1UStndlZHRUFwd2ZVY3l1VGxIWDI0aVhXcjQzazdrQW0zUmRL?=
 =?utf-8?B?NFBMd09XV2JRVmRnU0FJUytFbWtYN1kvUWZSL3VoRERwVXMrY0hhSDBZVjlm?=
 =?utf-8?B?TU0wQkplMU1lUitVZUIwUmxjdEpzM1FRNEcxNkR3clp1NnV6ZGZKc1k0alVy?=
 =?utf-8?B?NVBFUHBnUW85YXJISUZXN1JkZG41SUZMWjBhN1BCSGhNTERmNmhBYU5TVmE3?=
 =?utf-8?B?VnhFZlplRnBISUJlWFNJeWVQeEZkeTAvQmZuYWJvelozVlcwTXhGOWdzM1Mx?=
 =?utf-8?B?ZTdJQjJERUFSUDE2bVBTMUNqWHhGYUR1RzBGd1ZxTkpJOXZwOXcreW9TY0l3?=
 =?utf-8?B?UDkxV1J4bGVWSlQvSDRXYWo5bzdLcnlwVG1lejNuS3BQQjRJZUQ0SWhSakRU?=
 =?utf-8?B?Z2FkQ0JRWVR6ekFxSTlGL25ubkU3eFlhckxocWtZUG1UMlFsM0V4ckdmd0FX?=
 =?utf-8?B?V2FQVEZyK29mQS80c2I2c2p0Z1A1eXlueEtBTDJOcUt0Niszeiswc1lFYnkx?=
 =?utf-8?Q?z6Tu+go4Pffpn3plUm4esLrYNEz799PT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LV8PR03MB8137.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(7053199007)(8096899003); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wk5HMVlpajRPUmJRRmRtWjRBc1hldTRrbW1jRVQvSnBvMUhqUk0xTFd3UUZh?=
 =?utf-8?B?eHZrWnJOdGZZa29TRTdWNEpUeGo4ZXZTZWNvZEE3SEYrNG9za0VzdHlwMlFU?=
 =?utf-8?B?b1E0ejBrU09ReTNnZGxWOHpuNml1QkZiT0lkQW1TWUFoYWNHSFcwNzd5ZWFs?=
 =?utf-8?B?MFlRWjlPZ296NFVLYjV0T3dOQmpzTmRUbEU4OXNja0ZiZi9XUmd1RzJkSGVt?=
 =?utf-8?B?dTBNbUt0UDkweXYvVGhubVF1VWJNNkNPOWdzTUVudnUrMS8vbEw0RmdLdmo2?=
 =?utf-8?B?SXdPR1NRQkdsSkttT2RLMHo5UndwVFdNbU9yaWQ0Q2F1UWRZZTVmNW1QMWxR?=
 =?utf-8?B?NUpZR0Z2Rno5b0RyYmdVUXdYM0pqQ0x0b0tqTWdYOVVWNk5kbnFkem52Rld3?=
 =?utf-8?B?UXZJYzdxa20xMWJ4YnRRckVMbU5zYmZZMzVqSDdFVXdDQlJFOGxYVWRNTmV3?=
 =?utf-8?B?aVdiOTdsa2tVeFFrVmVLODlqL0Zub3RXMzl0cUJubGdWTUNBQ3hZdk90eFdp?=
 =?utf-8?B?ODNmOUo1ODBtT0JtdW43REV3Y0k4VVdUdmFDbWgyMDdjb3F6TkVWd3dYK2Nn?=
 =?utf-8?B?UTdjRXZkU0dXblhaWDNIaitxbWlqN0Nkdkxuby82QnZ6MTJGc1V3L3pYMXJq?=
 =?utf-8?B?b2pJU1lXVEZsN0pWcTBWUWRTWmZxbFhSTWs2Qk1sdzFJaXJ3YTFzd3dnWXA5?=
 =?utf-8?B?WFI0UVY4QzhMNTdWSFRScXM3TDhlZFg2SjhnSXZKaXhaVDVhSFpDUWpBMmJh?=
 =?utf-8?B?M2VRbmR0aVlRR3E5WUE4M3NWczJZcVRqSkxtWWcrcVhYN0ZEWkVaalBLaWNG?=
 =?utf-8?B?Q0NaYnRRZkM0UTMzeTF1c0FpUnk3VllUYVd1Z1h6YWdnU1o0cGVZUlBpNXVs?=
 =?utf-8?B?VGNVWmVSaUoyMWNvR2FlVmFqUCtJaU40Zm92TVdDaHdkTisyN04wQ1h5QUtj?=
 =?utf-8?B?S2MxUytNZmF3OHJqQTFsN0VtcG1QVHQwbHZMbjRCQjBqS0V1ZktlM0tJdEpN?=
 =?utf-8?B?SCtMOTEydjlGTkhuaHZQbkNsUjBONFZYRmJuRzlka2FDM3oxZExsTEVKOGRq?=
 =?utf-8?B?ZVNyVnY3cGQwdlpkb1NCcEQwTGxqa2JNOHo3VTBsZTNLSnRhZURCa2pBcGx6?=
 =?utf-8?B?K3Z2YjZQT1FzMDA1cm56NHNjMm5zK2E4dkg3WEdBdDBXTEtCMzh6WUhDaTgy?=
 =?utf-8?B?eFZRRnFsZldnbzFOck8vTDFkMVZBSW1mSTVFNlk3MkhnWjlEZkZNQnE5TWE0?=
 =?utf-8?B?cUhydEgrUjJlUS93K0hhc3J0TERiVzN2Rzd2WHNpMFNMMTVacndvakwzWmtz?=
 =?utf-8?B?NEdabzJJcGlpV21zOVl6eHVKcGVZQkMvN0tZZGdjTnBGSTErUERESVZUV2Iw?=
 =?utf-8?B?SE5lMGVyR2Y0RW8yckF5ZXJTU1hha1lOV3pmaFlDZHJ3YURBL2VSQzFLUmtC?=
 =?utf-8?B?ZkZhbEtCNTRZdnV3U09kQ1RKcXNBSGNEa0VRZVdlRmdVZGk1S1p4cFVPdklj?=
 =?utf-8?B?a1VpclB6OCtWazBnOGx4ZU14ZkowaVlud215SmJsTXZMcGJ5bmY2KzJZeTRB?=
 =?utf-8?B?WVcxU0NTV3dLM05ZRGlNekhML1ZyQjNCS1NYeVcwZm9TN3h4emN4cm1TdVR5?=
 =?utf-8?B?ODhNSVRHMWpvTXRBT2R0ZVFYMFB1aFQreE9QSU1WUGhkQjAyZkg3Z2Z1Uy9L?=
 =?utf-8?B?Y0Z0eE1BL3FaZEE3dnJmNlJ5UmU3aStHcW5FL0h5bjFmSnFkbkY1M0hqaXVi?=
 =?utf-8?B?ejYwZXMwSG4wUllLR2Fqb3J1SWlORUFCRS9SRjBHVE5HM3dOODNMMmRZYUh5?=
 =?utf-8?B?L3QvL3F1Y2JGZ2RPR05IT2JRS2w2R3NOKzgrVEQyUnBDcXVubEh3N3oyTGZZ?=
 =?utf-8?B?L3VMZmRnckxJaDRYd1hvTGtWS3Vhd3A3THAwV0ltM0c4WEx3WTJvclVnMWVm?=
 =?utf-8?B?RkFmUmtKa1IxN1M5Q1YybFE2Y0wxWDgvRVRxMnMzWUE4U0xVczdwNVNYVGlq?=
 =?utf-8?B?SGltbmtyQ2lYYWRpWmxzK0V0ZmlrbGUwcjJ1SGVJcVl1M2lZVXowNWY5V08w?=
 =?utf-8?B?d0QzUlZoMU1uQkhVdkVnTjcyaVArdEVyRUxPb0tSRlBSNWViUTZxdVlpZjVC?=
 =?utf-8?B?dmdmNk9pUGZlT0kxOG5NMDNyWDRraUplRW1ORUphcnBwVU1FSFhWV2dYV095?=
 =?utf-8?B?V2c9PQ==?=
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 403b1c71-fc8a-46fd-09ea-08de25ac2b11
X-MS-Exchange-CrossTenant-AuthSource: LV8PR03MB8137.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 07:37:32.3935 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FR7kM+5P5dmHb8bERAavsblWrE2x4N7nWBeaL/pQ0Lt9oJhYAyf0QGYwLPcJJFPoHFzZDSzfa+xIajt5fKzCV8MtlAoX/g8D2R1Pfn5e0c0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB5986
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

On 20/10/2025 9:35 pm, Brian Sune wrote:
> After testing, w/o proper setup
> the FPGA2SDRAM bridge will not work and stall.
> Pulling from official fix and w/o this initialization,
> both 2025.07 and 2025.10 also suffer stall on U-Boot
> and distro. Any FPGA to HPS-SDRAM action will immediate
> stall the CPU. As such, this patch fix the issue.
>
> Signed-off-by: Brian Sune<briansune@gmail.com>
> ---
>   arch/arm/mach-socfpga/misc_gen5.c | 34 ++++++++++++++++++++++++++++++-
>   1 file changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-socfpga/misc_gen5.c b/arch/arm/mach-socfpga/misc_gen5.c
> index b136691c685..5259ef54d73 100644
> --- a/arch/arm/mach-socfpga/misc_gen5.c
> +++ b/arch/arm/mach-socfpga/misc_gen5.c
> @@ -217,6 +217,34 @@ int arch_early_init_r(void)
>   static struct socfpga_sdr_ctrl *sdr_ctrl =
>   	(struct socfpga_sdr_ctrl *)SDR_CTRLGRP_ADDRESS;
>   
> +void socfpga_sdram_apply_static_cfg(void)
> +{
> +	const u32 applymask = 0x8;
> +	u32 val = readl(&sdr_ctrl->static_cfg) | applymask;
> +
> +	/*
> +	 * SDRAM staticcfg register specific:
> +	 * When applying the register setting, the CPU must not access
> +	 * SDRAM. Luckily for us, we can use i-cache here to help us
> +	 * circumvent the SDRAM access issue. The idea is to make sure
> +	 * that the code is in one full i-cache line by branching past
> +	 * it and back. Once it is in the i-cache, we execute the core
> +	 * of the code and apply the register settings.
> +	 *
> +	 * The code below uses 7 instructions, while the Cortex-A9 has
> +	 * 32-byte cachelines, thus the limit is 8 instructions total.
> +	 */
> +	asm volatile(".align	5			\n"
> +		     "		b 2f			\n"
> +		     "1: 	str %0,	[%1]		\n"
> +		     "		dsb			\n"
> +		     "		isb			\n"
> +		     "		b 3f			\n"
> +		     "2:	b 1b			\n"
> +		     "3:	nop			\n"
> +		    : : "r"(val), "r"(&sdr_ctrl->static_cfg) : "memory", "cc");
> +}
> +
>   void do_bridge_reset(int enable, unsigned int mask)
>   {
>   	int i;
> @@ -234,7 +262,10 @@ void do_bridge_reset(int enable, unsigned int mask)
>   		writel(iswgrp_handoff[2],
>   		       socfpga_get_sysmgr_addr() +
>   		       SYSMGR_GEN5_FPGAINFGRP_MODULE);
> -		writel(iswgrp_handoff[3], &sdr_ctrl->fpgaport_rst);
> +		if (iswgrp_handoff[3]) {
> +			writel(iswgrp_handoff[3], &sdr_ctrl->fpgaport_rst);
> +			socfpga_sdram_apply_static_cfg();
> +		}
>   		writel(iswgrp_handoff[0],
>   		       socfpga_get_rstmgr_addr() + RSTMGR_GEN5_BRGMODRST);
>   		writel(iswgrp_handoff[1], &nic301_regs->remap);
> @@ -246,6 +277,7 @@ void do_bridge_reset(int enable, unsigned int mask)
>   		writel(0, socfpga_get_sysmgr_addr() +
>   		       SYSMGR_GEN5_FPGAINFGRP_MODULE);
>   		writel(0, &sdr_ctrl->fpgaport_rst);
> +		socfpga_sdram_apply_static_cfg();
>   		writel(0x7, socfpga_get_rstmgr_addr() + RSTMGR_GEN5_BRGMODRST);
>   		writel(1, &nic301_regs->remap);
>   	}


Reviewed-by: Tien Fong Chee <tien.fong.chee@altera.com>

Best regards,
Tien Fong
