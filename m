Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ADB2C0218D
	for <u-boot@archiver.kernel.org>; Wed, 29 Jan 2025 16:02:32 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 475D8807D9;
	Wed, 29 Jan 2025 17:02:31 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="Z9CyYmkX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EEA9F807E5; Wed, 29 Jan 2025 17:02:30 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2060a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::60a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B59D5807D7
 for <u-boot@lists.denx.de>; Wed, 29 Jan 2025 17:02:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i5zI9rwfDTfIBjc7x4oQc17d7Yi7dDVIdnSrMudV+CwTYC6xnn16v/bgvLCHm8gnc0AUyfscxizqD3D8gBtncXBXYLA/0znlO3iLyhKTwepx2/1Ojv7gs2ND/y6WUE5zy3rwhUbESl7SIJcyP+z8t0rIakgm2e2iW/mI+ZKf6wRxJBYIb1M4tOpMRIC4FffurWaG1ZaktsrhStpyxYDHDWefX0n/u+1bMbu2iIvuH2avdW7cmzFLiHNdAduhJPrloiM2akhy5JwFfzOe+2qdXZiljViqCzZV/vybW/26VW3YDT2Fv69egnK12/O0+ERdDk3NePNzkH9TF8U4bW3OQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kY/4RPbxpJ1zdKnN9hKF1VxDuLVqJxE0myRgglWoYi0=;
 b=vVPfgMCCTd4nkMWDZaQLamknP5yEpW1n0GnDk1LEDc0zi04cuVEx+ccVIWnuo53RILgV5xIkyB4Gp8Tn4JYUCsc+piIJYwsADyi/DeeqylE3wQa0HRmXCA/y4fZrthOLxqDPBoZhoLCMgc9gtZ2NXXirX313gUcAapmlRo7qhmr957eP+D9GfYuD5jHX00I+EnEBKCseDdEDaMKE/2kHeWa186cZxmSivTG0Ju79fY5PJW32XB6NOkyMWFhmfeaOK1y3EIDVNQS37/bl7tjYNMZpRgd3Pi4g8ePhNaTPilj7jO7fI/NOdW08ohcu3lrxVHb79odHiaYEY3zPXfi2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kY/4RPbxpJ1zdKnN9hKF1VxDuLVqJxE0myRgglWoYi0=;
 b=Z9CyYmkX6nd/vklKG65FNf/J/JemlrhUQpeC0yuzAyJ994ouuz5ol1X6oModlG5pB0cMgu/M//a/0ewF2LlNlhA4sk6B1qNX50wrFELI2qAd/5bY/qPM2j6fBePGcI3BUv4XCeIH6j9m2TyZNBJxjCU4s7bUwqqrOvjQNaCIXdo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PR3PR04MB7241.eurprd04.prod.outlook.com (2603:10a6:102:92::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 16:02:25 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 16:02:25 +0000
Message-ID: <8409fd39-3816-4686-9b9c-56785209ed37@cherry.de>
Date: Wed, 29 Jan 2025 17:02:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: renesas: Add TFA BL31 handoff support
To: Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-3-marek.vasut+renesas@mailbox.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250112223755.179959-3-marek.vasut+renesas@mailbox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0270.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::37) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PR3PR04MB7241:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4ff8fe-3a5c-4a8d-5807-08dd407e528b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|7416014|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VDZQaXlrNVArUmlpQ1FsSmIwYzRQc3ZjVDA2SUJTdGNvcC9JdjZ0b2RDVkw4?=
 =?utf-8?B?QSt3NVhJNnh0SjV2VGpYV3JBZS9zRGsya0FyWHVaSXQ0WlNiNUczeGUrQW0r?=
 =?utf-8?B?ZDNXcXA0bHdEamhWSHV2YlllVTNScmZGK2RsSk5tVnJMd3diWS85YjNGdEov?=
 =?utf-8?B?dnZ1TzdWWVRvYUVTSUdXQnRocUtpVWowZ0wzK3VmaE0yR2Z4aDZuSTg2NXF6?=
 =?utf-8?B?dzZSK2I5YUd3MFRyN1Erblhkc2tyeTFaM0NSZkhVdEJlcmJBQTB2MUJFTVBB?=
 =?utf-8?B?NG9tYXNrQ2puM2dualMzbmU3L0ZOY1dVMHJuMW44d1FoNXFSeTBMMWVYVkNl?=
 =?utf-8?B?c3dGZHNtajdqSjBlaTZ4MnhKU01Tc2d2Rnd5QUQzS1AzVnVHZTdscDlYcXlq?=
 =?utf-8?B?NGVrZTNrcS9FemNFcEtkZDBBM0FlZjlpdTN5aVhMNjVxbUNsdUhXdlBzeEFT?=
 =?utf-8?B?R3kraWc4cG8yendkemtRNVZBMVRNZXpvQmovUGhIZWhxcWo5MTVKTDNtVEhC?=
 =?utf-8?B?WUZGcUMzV1V5QXN6MUY1TTR2QWdZUXdGUml1VHdrUitzek5lRlV0d3pSZmJo?=
 =?utf-8?B?eUhQb1Q5SDFKbDU2eG9YaVlONm5BbWtCV09Valk2SXMvclhrbzBnRTZVaUNh?=
 =?utf-8?B?OFVibTh5ZHZHN0ZmM0tqUVliRkJmdFFwUkFXZkE3YjluQXhIaGxxakFxaWFo?=
 =?utf-8?B?NzVhVFhLb1JkS3djcVdVbmxIQ3EzRzBScnRjNFFrOWxMZWFyY2xDMlEybE1o?=
 =?utf-8?B?dU1RbjZQZjhuZUpDZTF4cHVmQUZTZGx3TDZadVlzWUNzTTJkUmVvV1BEcjJF?=
 =?utf-8?B?bFZJdHZWZXlLbklGdnJNQjNkREVyeVdQL2hJbWNVU2dHRDlhVTlwQUdMV25r?=
 =?utf-8?B?ZUhwY2E2M0Y3eEFUY1NJRkxzRFY4eWtJd29WNXJEZkJ4b0dFTTZnL0YzR2ZO?=
 =?utf-8?B?NXpzR3RaTHNGdGlrd01WMmFXWjVXRm5KN3kxeHRrUUpnZXNtVkVrMzNJSnVV?=
 =?utf-8?B?SFpDZVh4SUF2V0lXVmZNVWxGcVFaMys4cEpYVWlxUHZieXVyM01BbTYrMDVt?=
 =?utf-8?B?czNrak9EczlteXFBYU9xTFBvUk9tR1lCSndlaDIrbTJEY2RPZXdZK3hRQVFW?=
 =?utf-8?B?U0Vsa1hpbUxkQTE5TVA3c2g3dFY0RVByUDJ3K3kzdVJxdmhPNkRDWVBiemVU?=
 =?utf-8?B?ZUdvZXZ0OTVNTmZGNGRHc1Rpc2VmNVA1dUczREJYcHZHcTRTaDlmRTBNL2pS?=
 =?utf-8?B?c0ZBV256MjhKQnRldDdnemZzQWp6ZHlLeGtNeWoxeFdQUzdKNDBQRVVMcHBy?=
 =?utf-8?B?UU81ZXJWcDdtMzluNGlCVzBNczBaSHhPKzdzNUxEZ2xJcjdndWJPdUJ1dE5m?=
 =?utf-8?B?Y25qb3pvYzVXMnRyWDE4L2VpRHhWV1hzVHgyVDYvREhUSnl0T0dwWnpxUHMx?=
 =?utf-8?B?ODhmeU9QK1ROOE01YjUwMVlFNTMvVFVhS3ZldWpoVnQvQmFDZDhsOHhuYUcz?=
 =?utf-8?B?MWN2bW1Hb1VTcG8xSnd0bGZwalZPREEyQlhtSjZ4eEdaR0ZoNUR0cXRsWVE1?=
 =?utf-8?B?Qk9jZk4vc1hSLzc4MTM3VUcxcXhEeUsrTVhzd3QxRXZ1d0NaZlgwSE10MVZN?=
 =?utf-8?B?VzVHWjJScFVUU3hsWTNaTEZMcVRtYjF5N1A3THJCdCsvWlVYZUkzL1daaXVu?=
 =?utf-8?B?cDB3UExOU09zR0RLM3hLcVlnNmVlUEZsT3pqRDMweDI2UVJ3YXVVaEFoRk1w?=
 =?utf-8?B?U1NwNElzVW9pemh1QmVWelNldzJEQXlmdXpLOUtnaFY0RmFMRG1sNGswYjhT?=
 =?utf-8?B?WFJkSWxUMEtnNWs4MUZpRUNLdVpTcUNuRURTTWozTHlMN09vcUxQSnB4dnU5?=
 =?utf-8?Q?fltYi0AEp6oT1?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(7416014)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WGJMdGJMREVrSzlEZnFjUUtHcXBZU1VGM2dlWVlaSlhNUmJoNDFoZ1J2ZE1a?=
 =?utf-8?B?RVdqNE5BZ1cvdDh5WW1QZzVZRHRWbzY0ZS8yM3Vad3F4Q21LUEtWK1BTQjRG?=
 =?utf-8?B?Z0ZLWmp3aGpvajBVcWdyTWlBR0ZERm1OYXM3cU9uRlhuMHhYaSs2MU9hVmlO?=
 =?utf-8?B?UXVqbWxoaHcxVzRncm8yY3RNcks4Y1gwQkNRU0xLUlNjNXc5SG8ra0NxTUpJ?=
 =?utf-8?B?Y3puVmNQQWZHcjFzZllkZzBNWDhYT2tzRzBSRWhWWGsxcWNWT3RJVTVFQlky?=
 =?utf-8?B?bGdESVdrL1M0cklrVWNSTVlFN2NsTjNvY3RUb2wvSjlBMjh6dlRadWpQWlJM?=
 =?utf-8?B?STFkNXg5emI2c0JyUGU1NWIrcDA3VWcwTkxpR091WGMxZUVSSS9iMEI2SnlK?=
 =?utf-8?B?M1Q4cmh6d1NMTS9qeTlENzZJZ0E0TFJweXphb0ZXalMxM3VoNW1OZzQ2eThv?=
 =?utf-8?B?bWh6U1N0dHZzUENlSEQ5aVpiSkZJK0ZZR1AvQ2Ztc1ZSTmNDcFUvSUpYNmta?=
 =?utf-8?B?czMzM25iSzZjNXN5QjFVcmtubmJldmlzMVhTMTRrc2JRaGJidGN2cTIwMERG?=
 =?utf-8?B?czNpVkZlOTlxd1A2TzZYeFk0ZEFvVFN4NWxjMXpGZ3VyRmhJNUxkcHB5c2ts?=
 =?utf-8?B?THk5Y092ZVUzbWU2TWN3bnljZGZ0TVdQbHpVUXZESWlhdVdudEJtcWtkelcw?=
 =?utf-8?B?aVQybkdGclhnS08vS29qMmNzeUF0YXNPSlRyS3pLMU9wQkZzM2lpSW5TUGYz?=
 =?utf-8?B?c2JJVDB5eHN3NnUwM0FTZkRRTENQMUJCQWxvNzdqcXRyaUR5c0xSNkU0c25R?=
 =?utf-8?B?QzNnTmdxZnN5QnFOWW1BdlBSYnhqakJ4R1I0YmFVQy9lRTMwV3Brd3hNSkF2?=
 =?utf-8?B?YUlsczhiTzVzc1RTdXVMY1VLOHg4ZzBITU5OOEcwaVVEOXVjRmxyZWM2TC9y?=
 =?utf-8?B?cUNvaTFKODNtVTZaNTR0cjJZalBDbWR5N3F5UlpENUZCRHIzbnB2bDFyMXU2?=
 =?utf-8?B?d1lUWU45S0UwVTF3WTFENC9VNVcxMmtoZmlwZTEySGZ2bmg4dDBicnZFeVNi?=
 =?utf-8?B?YjZ3M2pZTEZ3WE04cFNUNUpBcm1zaXpEeEZINUZkd21CMjgvWkg2VkJFOGRM?=
 =?utf-8?B?dWZlTEUrcU9Zbzc3UWxaZGVUS3dxOWwyTEVJZE0rbisvSGQyUVNDSDFMd1dx?=
 =?utf-8?B?UkxDeU5kZGFmQ1J5YUFVUEpVUGZpY3RVQWs0TzFiSXdpbEtsSUg4b2tacE9P?=
 =?utf-8?B?Y0djK2Z3Q2xBRitiSHFQNHNTSHEzTXRFRG9mYm1qMGUrWFpnc0UzVUxWRkRZ?=
 =?utf-8?B?aDVHR0YxKzNuWHhGOWs1UEpXR0dvNzRlM0k4cXVIVTRqclRRTlRkM05xbWgv?=
 =?utf-8?B?MHFqMFRKVjFjZXowaXBwWkEyak4yMXVOSUE4bnRjWm54UzZoSzA3MkRITkRj?=
 =?utf-8?B?Q3pCaHNISHJFQjlSeXVKYUZPbnJCd0kxUGowRFJLNDZ5OHloUU5UR01jWGdq?=
 =?utf-8?B?eHNGZGtBMUFTTE1VdkJDUE95aXo5US9aSDl3cG5rSWhnRXBCZmNpdU9oVmtP?=
 =?utf-8?B?NVlUUUxMc1NwUld6NVVtdktMK3JvMjFQcjRuem9JZTB6WjlZbndweTU5MUNF?=
 =?utf-8?B?eWIvclFLSlVWeFFFT05LeHpjMXlaVXo1OERKb1FqcWI0V1hIZGsrNStKNFhH?=
 =?utf-8?B?S2t5T2JUUDJsSjZvSU94SFQ0OURoNkJBZFFZMjhDQ1ZQSjRZenpDSEh4bU5w?=
 =?utf-8?B?cnRjQmtsd25XRml3VDVCSEFFK00yeUwxbkNEMTc5K1YxL2NVU3dHT2ZJblBE?=
 =?utf-8?B?VmZqNkRyU25iY0QyclM0dzBkMDVZSWYxTklLekc4N2kxKzBxSTJDVVdnMy80?=
 =?utf-8?B?TWthOVF6N3FrTGhWQ2FvSUczTExIWXZKZm1qd0J5WjUzWTVLekNWZTR1VGZ6?=
 =?utf-8?B?WVk4VHMzNXdRV2xqL2dCZ0hXYnJmZXNqZnMyeFBJaVBpeFlpT0FKNEJsbjdq?=
 =?utf-8?B?YmxIUldrLzd1VHB3MmV2Q21NWkpLSmU1djFkZ1M3SWM1aE9KUEJjUVFQdWJ2?=
 =?utf-8?B?QmtQc21DbGovaDEvaW13VDRFdHJWVXoxVHJtQ0tYYnlyNWJzdjVPRmlIUExH?=
 =?utf-8?B?eW5lMkpwVGdzcnNuMHRDV2ZCNGpMUEpaKzVMZ0h1WDQ5N3Vxb0VBVFJmZE1m?=
 =?utf-8?Q?n7UE93/seKoaVVD8SA5s5jA=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4ff8fe-3a5c-4a8d-5807-08dd407e528b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 16:02:25.3870 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vBZYb/jeMLVYMlummhurgSL8vXlgDkF6uksZuV1u3vVl13JwOQ+ADm7m3LQkAht4bjlA2RYbbHjYNgQTtwQmRkyRH1EErFR8UMfoK8d70N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7241
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

Hi Marek,

On 1/12/25 11:36 PM, Marek Vasut wrote:
> Implement custom U_BOOT_FIT_LOADABLE_HANDLER and armv8_switch_to_el2_prep()
> handling in case the TFA was loaded. The loadables handler sets up custom
> handoff structure used by Renesas TFA fork in fixed location in DRAM and
> indicates the TFA has been loaded.
> 
> The custom armv8_switch_to_el2_prep() handling tests whether the TFA BL31
> was previously loaded and the custom handoff structure was set up, and if
> so, jumps to TFA BL31 which switches from EL3 to EL2 and then returns to
> U-Boot just past bl in armv8_switch_to_el2() to finish starting the Linux
> kernel.
> 
> The jump to Linux through TFA works in such a way that the custom
> armv8_switch_to_el2_prep() handler configures the custom handoff structure
> such that the target jump address of the TFA BL31 on exit is set to the
> armv8_switch_to_el2() + 4, which is just past the bl, and just before the
> U-Boot code which implements the Linux kernel boot from either EL. The
> registers passed through the TFA BL31 are all the registers passed into
> armv8_switch_to_el2_prep() to assure maximum compatibility with all the
> boot modes. The armv8_switch_to_el2_prep() handler jumps to the TFA BL31,
> which does its setup, drops EL from EL3 to EL2 and finally jumps to the
> armv8_switch_to_el2() + 4 entry point, which then allows U-Boot to boot
> the Linux kernel the usual way.
> 
> In order to build suitable kernel fitImage, build TFA first, temporarily
> from downstream repository:
> remote: https://github.com/renesas-rcar/arm-trusted-firmware.git
> branch: rcar_gen4_v2.7_v4x
> 
> ```
> $ git clean -fqdx
> $ MBEDTLS_DIR=/path/to/mbedtls/ make -j$(nproc) bl31 \
> 	PLAT=rcar_gen4 ARCH=aarch64 LSI=V4H SPD=none \
> 	CTX_INCLUDE_AARCH32_REGS=0 MBEDTLS_COMMON_MK=1 \
> 	PTP_NONSECURE_ACCESS=1 LOG_LEVEL=20 DEBUG=0 \
> 	ENABLE_ASSERTIONS=0 E=0
> ```
> 
> Build Linux kernel Image and device tree from current mainline Linux
> kernel repository, obtain 'Image' and 'r8a779g0-white-hawk.dtb' .
> 
> Bundle the files together using provided fit-image.its fitImage description:
> ```
> $ mkimage -f fit-image.its fitImage
> ```
> 
> To start the kernel fiImage generated in previous step, load fitImage
> to DRAM and use the 'bootm' command to start it:
> => load 0x58000000 ... fitImage && bootm 0x58000000
> 
> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
> ---
> Cc: Andre Przywara <andre.przywara@arm.com>
> Cc: Caleb Connolly <caleb.connolly@linaro.org>
> Cc: Igor Opaniuk <igor.opaniuk@gmail.com>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Julien Masson <jmasson@baylibre.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Maxim Moskalets <maximmosk4@gmail.com>
> Cc: Michael Walle <mwalle@kernel.org>
> Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
> Cc: Patrick Rudolph <patrick.rudolph@9elements.com>
> Cc: Paul Barker <paul.barker.ct@bp.renesas.com>
> Cc: Paul-Erwan Rio <paulerwan.rio@gmail.com>
> Cc: Peter Hoyes <Peter.Hoyes@arm.com>
> Cc: Raymond Mao <raymond.mao@linaro.org>
> Cc: Sam Protsenko <semen.protsenko@linaro.org>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Sughosh Ganu <sughosh.ganu@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
>   board/renesas/common/gen4-common.c | 118 +++++++++++++++++++++++++++++
>   1 file changed, 118 insertions(+)
> 
> diff --git a/board/renesas/common/gen4-common.c b/board/renesas/common/gen4-common.c
> index 52a0639073b..c7f3f9a30ab 100644
> --- a/board/renesas/common/gen4-common.c
> +++ b/board/renesas/common/gen4-common.c
> @@ -7,11 +7,13 @@
>   
>   #include <asm/arch/renesas.h>
>   #include <asm/arch/sys_proto.h>
> +#include <asm/armv8/mmu.h>
>   #include <asm/global_data.h>
>   #include <asm/io.h>
>   #include <asm/mach-types.h>
>   #include <asm/processor.h>
>   #include <asm/system.h>
> +#include <image.h>
>   #include <linux/errno.h>
>   
>   #define RST_BASE	0xE6160000 /* Domain0 */
> @@ -88,3 +90,119 @@ int ft_board_setup(void *blob, struct bd_info *bd)
>   {
>   	return 0;
>   }
> +
> +/* R-Car Gen4 TFA BL31 handoff structure and handling. */
> +struct param_header {
> +	u8			type;
> +	u8			version;
> +	u16			size;
> +	u32			attr;
> +};
> +
> +struct tfa_image_info {
> +	struct param_header	h;
> +	uintptr_t		image_base;
> +	u32			image_size;
> +	u32			image_max_size;
> +};
> +
> +struct aapcs64_params {
> +	u64			arg0;
> +	u64			arg1;
> +	u64			arg2;
> +	u64			arg3;
> +	u64			arg4;
> +	u64			arg5;
> +	u64			arg6;
> +	u64			arg7;
> +};
> +
> +struct entry_point_info {
> +	struct param_header	h;
> +	uintptr_t		pc;
> +	u32			spsr;
> +	struct aapcs64_params	args;
> +};
> +
> +struct bl2_to_bl31_params_mem {
> +	struct tfa_image_info	bl32_image_info;
> +	struct tfa_image_info	bl33_image_info;
> +	struct entry_point_info	bl33_ep_info;
> +	struct entry_point_info	bl32_ep_info;
> +};
> +
> +/* Default jump address, return to U-Boot */
> +#define BL33_BASE	0x44100000
> +/* Custom parameters address passed to TFA by ICUMXA loader */
> +#define PARAMS_BASE	0x46422200
> +

Shouldn't we rather set those as offset compared to the load/entry 
address passed in the ITS?

> +/* Usually such a structure is produced by ICUMXA and passed in at 0x46422200 */
> +static const struct bl2_to_bl31_params_mem blinfo_template = {
> +	.bl33_ep_info.h.type = 1,	/* PARAM_EP */
> +	.bl33_ep_info.h.version = 2,	/* Version 2 */
> +	.bl33_ep_info.h.size = sizeof(struct entry_point_info),
> +	.bl33_ep_info.h.attr = 0x81,	/* Executable | Non-Secure */
> +	.bl33_ep_info.spsr = 0x2c9,	/* Mode=EL2, SP=ELX, Exceptions=OFF */
> +	.bl33_ep_info.pc = BL33_BASE,
> +
> +	.bl33_image_info.h.type = 1,	/* PARAM_EP */
> +	.bl33_image_info.h.version = 2,	/* Version 2 */
> +	.bl33_image_info.h.size = sizeof(struct image_info),
> +	.bl33_image_info.h.attr = 0,
> +	.bl33_image_info.image_base = BL33_BASE,
> +};
> +
> +static bool tfa_bl31_image_loaded;
> +static ulong tfa_bl31_image_addr;
> +
> +static void tfa_bl31_image_process(ulong image, size_t size)
> +{
> +	/* Custom parameters address passed to TFA by ICUMXA loader */
> +	struct bl2_to_bl31_params_mem *blinfo = (struct bl2_to_bl31_params_mem *)PARAMS_BASE;
> +
> +	/* Clear a page and copy template */
> +	memset((void *)PARAMS_BASE, 0, PAGE_SIZE);
> +	memcpy(blinfo, &blinfo_template, sizeof(*blinfo));
> +	tfa_bl31_image_addr = image;
> +	tfa_bl31_image_loaded = true;
> +}
> +
> +U_BOOT_FIT_LOADABLE_HANDLER(IH_TYPE_TFA_BL31, tfa_bl31_image_process);
> +
> +void armv8_switch_to_el2_prep(u64 args, u64 mach_nr, u64 fdt_addr,
> +			      u64 arg4, u64 entry_point, u64 es_flag)
> +{
> +	typedef void __noreturn (*image_entry_noargs_t)(void);
> +	image_entry_noargs_t image_entry =
> +		(image_entry_noargs_t)(void *)tfa_bl31_image_addr;
> +	struct bl2_to_bl31_params_mem *blinfo =
> +		(struct bl2_to_bl31_params_mem *)PARAMS_BASE;
> +
> +	/*
> +	 * Destination address in arch/arm/cpu/armv8/transition.S
> +	 * right past the first bl in armv8_switch_to_el2() to let
> +	 * the rest of U-Boot pre-Linux code run. The code does run
> +	 * without stack pointer!
> +	 */
> +	const u64 ep = ((u64)(uintptr_t)&armv8_switch_to_el2) + 4;
> +
> +	/* If TFA BL31 was not part of the fitImage, do regular boot. */
> +	if (!tfa_bl31_image_loaded)
> +		return;
> +
> +	/*
> +	 * Set up kernel entry point and parameters:
> +	 * x0 is FDT address, x1..x3 must be 0
> +	 */
> +	blinfo->bl33_ep_info.pc = ep;
> +	blinfo->bl33_ep_info.args.arg0 = args;
> +	blinfo->bl33_ep_info.args.arg1 = mach_nr;
> +	blinfo->bl33_ep_info.args.arg2 = fdt_addr;
> +	blinfo->bl33_ep_info.args.arg3 = arg4;
> +	blinfo->bl33_ep_info.args.arg4 = entry_point;
> +	blinfo->bl33_ep_info.args.arg5 = es_flag;
> +	blinfo->bl33_image_info.image_base = ep;
> +
> +	/* Jump to TFA BL31 */
> +	image_entry();
> +}

Shouldn't we have a weak implementation that SoC vendor can override if 
they feel like it?

To me this feels like it could be much quicker adopted if we had some 
default people could try out for their boards.

We already have a generic spl_invoke_atf() so why not the same for this 
mechanism? As far as I could tell, we get the load address of TEE and 
U-Boot proper (bl32 and bl33) and pass it the FDT (or nothing if 
SPL_ATF_NO_PLATFORM_PARAM symbol set).

I am not too sure who and how TEE will be started as it needs to be 
executing in EL3 too I believe? So we may still have to provide that 
one? BL33 would be the kernel params like you did in this patch. Then 
the bl31 param could also be either the fdt or nothing if 
ATF_NO_PLATFORM_PARAM is set.

I guess the issue is that Renesas doesn't use any of that generic stuff?

What do you think?

Cheers,
Quentin
