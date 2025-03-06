Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754DEC28B22
	for <u-boot@archiver.kernel.org>; Thu,  6 Mar 2025 10:18:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B222C80E94;
	Thu,  6 Mar 2025 11:18:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="EBAP8M6X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B04FE810DC; Thu,  6 Mar 2025 11:18:17 +0100 (CET)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02on20614.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2608::614])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2FC2580756
 for <u-boot@lists.denx.de>; Thu,  6 Mar 2025 11:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ThAXRZp0h6ueKjHI8Kr6xbeT2BVJswrsnWtbzqf1XhFcHM5T2A6N6aIy5d0oQoVR1l1qBi5phOjWDVHcmyC0DdWDcwLNo2SRP64mUmxW9FERGM3jMStaB8vCw9syIesQRQ4DXoCgANeERQXW5ippIe4pv+ubZ++mbKnkvkRZFW2IxqgpEsA6IzPcUHxuyzRh6JZLXG0KMqYx7kYMqD/4l+mszmGMqwajvtacAvMfqowLYEAO+hE1SATG+4PqUUPawlxQYFzTbRP8YAJFmPdzd3sUpljxJYvQ0nmMLZsNPWj7/4zGTn1Xi0bMK2dqN5cWVm/2agoi+uWAw+5KWhryDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ol3mjgMTzNnJ+bXe/+T5/nw3m1HNr20uHHaM1sBe0CQ=;
 b=iDBs5EARekeOHLrD6Y980YxkASfggLdeRpkBJdB7xxAbDikpP5bMGhVzexlFDh7TxLvS+LVtuLZVrJUaQsgrxowq7KZeP0b5xrnTTOryVmckk5ngq93lCkaEg3uOuLcM1NPp7YTE02m5jqU7Dn9Pq/CnXbp1iVD87KUN38wyO1XjEh0o4oiBdeSFMfG0k18zaGMX1el4DLvrvMxpq686Tiz3YSEkNuTvYWFITh6gBQr4BLnoKbr25vUXFCSUTQtmheS0+x/NxisePFHmiu2kJCPPrTXwSbvtjQcicWcmVr0AsK98AShJErOu612uIczXsN12K6G70T1zo9v/M1ky2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ol3mjgMTzNnJ+bXe/+T5/nw3m1HNr20uHHaM1sBe0CQ=;
 b=EBAP8M6XVIsrGZ0rLEORT7qhxPlmZW2XgbY+msRizfhJHM2AFE/vKY/7PdpFdXxU7NcUcBrwFqXuq2xeo1wrRIa53ZeVeyBHzHER+arfTzk2stpu/S8ChZ0xsnovA7MlvWTJHGu0ItsLwH3lSlOGtZfaSRXVBIgi9W2sdAhh318=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10399.eurprd04.prod.outlook.com (2603:10a6:102:452::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 10:18:12 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 10:18:11 +0000
Message-ID: <33908f3c-b8d2-4beb-8caa-d6ff7cc3317c@cherry.de>
Date: Thu, 6 Mar 2025 11:18:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] Makefile.lib: Set xPL build related defines for DTB
 build
To: Hendrik Donner <hd@os-cillation.de>, u-boot@lists.denx.de
Cc: Oliver Graute <oliver.graute@kococonnector.com>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Jonathan Humphreys <j-humphreys@ti.com>,
 Michal Simek <michal.simek@amd.com>, Simon Glass <sjg@chromium.org>,
 Prasad Kummari <prasad.kummari@amd.com>
References: <20250305183544.40525-1-hd@os-cillation.de>
 <20250305183544.40525-3-hd@os-cillation.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250305183544.40525-3-hd@os-cillation.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0166.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b4::18) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10399:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbeaf0e-db45-441e-14a1-08dd5c9832fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZGpPYVRtbnF4c0hjYjdPbzNKa1dFRjN1SzA3bzRIWlBlQ1diVmVYSkF6bGgw?=
 =?utf-8?B?amFhdHRZOWJpMi8wUVRIOVpZanpYd0cwMmYxTGVRZ0dSeEZIR3pTV2ZQMDhv?=
 =?utf-8?B?THRncmFYK25WeklvMGxRb29xYmM0NXRzcE5xVGFzUG5QS3RUZ2piR0YrZi9w?=
 =?utf-8?B?U2d6b2FGRjE0RVhUOWJEUWlVUjRWRlhLaGs5Q3ppc1ZicDI3alhXbVp6V2xO?=
 =?utf-8?B?ejBzTHBiNTZBbTdPOGt3eElrdDJxTDZVY2hsWVk1VFlrdXUzS05FdDVLZ3NC?=
 =?utf-8?B?NTYralJRVlIrVjlrS0JtcXROUDBXQ0pGK2ZvTjJ4UWFlU0R0QWJVbk9sNENK?=
 =?utf-8?B?SVJ5M3JYb1dHM280c21waWxZY2diODV0eW5wdkthRGZLOWdkMTFxWnJObEl2?=
 =?utf-8?B?TE9ZejU4S3B0OWtvVklXMjNFWTdGbVhhQis5RDJnNHBBeDE0ZkZpTWo1dG11?=
 =?utf-8?B?bTY3U2pUU2VyREp5ZWpIN1hFdzJMdXV5REt6V1o3eCtOUHhJVlIyY3VuM28z?=
 =?utf-8?B?WWpOZFhSeGFZOXA5U2tpSWpFdkppd01yUGd1dWQ2S0RuYkY0eVJrTnpyMTBL?=
 =?utf-8?B?NWFHenRBUFlvU1I5cklIU3NiS0VSVFNxeXdjNkFBTjFEejM0Z09sNFp1V2Vp?=
 =?utf-8?B?emw4ckIzaEd3dGg1OU44KzYvbTFTdFJoUW11Q0wwWnkzaGRERUlnOW50WDA2?=
 =?utf-8?B?SlRJWEFJZUprdDFHWlIvN1dYRTNySnZBTUpKK2EvMjBzUDRMRTRTeDVDRDVm?=
 =?utf-8?B?WWw0ZHpjaklEejQ4ZmYzcmEvREJFQ1Q4QU1CZjIxVklENUpSc25oUnpVdUE0?=
 =?utf-8?B?akMyWTIzRUNtNHp1YzROOXh2V0pjS0VpU2txTXczKzgzNTRweERsRjdWSGFN?=
 =?utf-8?B?dEh4eUs5bnVIb0hZM2Vod1JHZ3FrbWZtYzM5V2lpRnl0elRHdHlnV1VHY2Fn?=
 =?utf-8?B?QUNpNm9sdjdOdldtdmhPeldjRU1HV1RpUmdZTzRDVXJRVXJQUWdhcmlOdnZM?=
 =?utf-8?B?UFA2eHRrcStOOUhMYmVOYmFPVHd1ZnU5UG1TZ3F5NG16TUNPWitFVldER0hP?=
 =?utf-8?B?THRZemFmNGpSYXJTaFFKS28vMjNnZDdsOExLWEltZDNXaUVWcGFCZFZZTUtR?=
 =?utf-8?B?cHhIN24wSGc0a3hjNnBZUHJaaHIwUWtTTjUyaFpEdHMvL0hVaGdJM1hZVlZk?=
 =?utf-8?B?YUdkeDA0bEdPTWlvTEk5aVhlU1owMUo0MkFzdFUyUXE0NFJJV200UnhHZkpR?=
 =?utf-8?B?WmNtMS83NlRIZUhCMmJCT0tPL2xSUFR0Nnl0M3gveGhWYWk3UU4zd09rSzBj?=
 =?utf-8?B?TXUxK2lCR3ZzbGlHYVJaNmxyVmtnUTRPWDRPRFQ4YUZvWjhrSnQzT1RnSlR3?=
 =?utf-8?B?cnoybnVYVzA5enN3SnFYeGpRSjhQNy9jNlFHSVE3dXdQZmVoclpia2E4WEhZ?=
 =?utf-8?B?aXlXTldYVnRGZnc4SCtCdWtCdXA1bFc5dmZuRjFoS25FcXhHL2tON1JEbzky?=
 =?utf-8?B?Q1J4Z2tPbmFqY0NmdGVUVHVQWitDWHhGVWhZenBaZ0pjYXkzaTF4Y2VjVTdD?=
 =?utf-8?B?SlRMVGdjdEQ2L1ZSRzhETzVsVUFIcFJ0M212RXk3cjBlQ0hvRndXY3gzWTFG?=
 =?utf-8?B?WlcyVmdvSnJtS3ZSRjd1VVJzRXZEOVRSK1Z1K1YwUEJpTkVtUU50R2YrZjhv?=
 =?utf-8?B?am05KzRsZG93OFR0dHZiQWo3NDRWM3lyM3FNNkIxOFNZTkdsZnRXQ3dPMHN5?=
 =?utf-8?B?RzJrdjkwalM0TUM1RHFRUEpFVTd6MmJ3RWo4amE0V2lkWlhQdDdzTTN2SnNJ?=
 =?utf-8?B?c0Q1WnVTRnM3dnBBQkZubmxyUWM4U1pnRmpDVHZRSUlteFp4SzBDaDJJNFpn?=
 =?utf-8?Q?zxRLqaWXYPtHv?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTdvelRWdHRVa3NNQWtnTTY2SzREcGRWcmorNXBUM21oSk44TFFWbjRhZXBl?=
 =?utf-8?B?cm1DeTRCQUluTFEycGRXeGRoTkF1VUxmdmZYWnhOK1RMMnl3N25BMTdYYW1Z?=
 =?utf-8?B?N0g3YVM1U0pGei9wRGR1Z3NKQ1M1REJJQnBoNCtSeTVkRDNNbkg4dk1SV2c0?=
 =?utf-8?B?cjlrZENBb2d2dFRVRmV2c2F2VCsyTWdUK0pGSFdSNlg4SHBZVmhDQXZEL2hP?=
 =?utf-8?B?YTZWVmFWb0M5Y2hvR0czbHZQQjBiVFN5QWpvaFF5UDF4aVNML3gvdmd6QVhn?=
 =?utf-8?B?U0pvVHBYY01tWHpRL1RzZDF2YTdqMVNBd0NoZVNqTC9YZ0J1akJ6d2c0Unlx?=
 =?utf-8?B?MzlEV3FTTlIxWlhFUmNNK1Z1ZVhXTmNuemJic3BpWlc0S3BURllMeml4ekNE?=
 =?utf-8?B?TEpWRll3cWhBNk8vMEs4MmFPMWh0bjhnWFR5Yi91SVJxYTc1bE1QVDJtR1ZP?=
 =?utf-8?B?WFhLWWY3LzhmaU1oemFYOGtTWWdrUkhVdjc2eWFyS1hydmx4VElDUTdZS0Ey?=
 =?utf-8?B?Wk96WGtYaU5FcCtYbnR2R28xa0JSLy9XeGRwUW42M0k1Ri9HSUZqS0ZZZCtM?=
 =?utf-8?B?WDVFTTdQaTJKN3lyKzZPNmxod2ZFcnV1SUxFbG9CNzdjTEV6cjBuNTFCWHhD?=
 =?utf-8?B?UE9FSXBPMEdHb3VuTjNXcFJZN0lOdlVGanBIYjk3aHJkN0FWQXgrS2UzTVpF?=
 =?utf-8?B?K2FxVjdmU2NyZnZKQ2hDd0NMZ3ovT29aQzJXcmR1dlJVbXBPOEhzelA0enNJ?=
 =?utf-8?B?SHFZZk1qUlFPclFURHEwcHFMMzA2WTVDNll3dFZQUC9uNmYyM0ZRV0U0WTN2?=
 =?utf-8?B?cDU2TFU3YWhzdGo2OFU3SHZIOWhTOFA3TlpzZWMxdzdYaFVZbjlVS0NWeTBH?=
 =?utf-8?B?V0laZ2J4T2IyeTYwWDdpeldISHlXWnhpbkMxOTI4OGZDTHhPdC9ya01QNFVk?=
 =?utf-8?B?OGs0TkJjWkVIYlpqZW1BdTRsV2M5S3I4V0czaHNjTytOQXpadkpJYlVxcFJy?=
 =?utf-8?B?ZnhaWGhUeTRJVjVJLzJOQXNUVit6VlNmNi90M2I0OGgzcDZIaDFlNCtHQnhn?=
 =?utf-8?B?SWNpSFllb0hjSHlNWDNONHZQTVowdnZSN3ZKTnY2L0FLVlJBbWdNU1pzem5R?=
 =?utf-8?B?RTcwN0F2cVdQQTRwQVlhVDhJODZpbjhzVnpqbDBqZUwxUGVjS3J2ZUZJUk0x?=
 =?utf-8?B?bHcyT0RONHZ4WTJVSTZQbUlYTFpEc21iYkVjS3VtYWdXV0ZNSFJIMzZCNElx?=
 =?utf-8?B?R1RadWprb09nY0h3UUNucWd5encyK0hpWEZ2NFJrMXl0SG5pSTQva3dxUiti?=
 =?utf-8?B?WUNOV0F2b3Y2SmlJNXpKZG9OZ3RCUTU4UmhaUVd6TStRa3N6R0FzYXpTV20w?=
 =?utf-8?B?dTJqL2pNRWR2Y0gyN0RnbmF6Nmh1Q0JXOUF6QTA2UHZLQ2V3dVhTYTNEOUxo?=
 =?utf-8?B?SGtVVmVxcWovQjhKZUNROFRRWEwrdVgzS2REWlFkWG5RcUFBcENMdDRzbDYw?=
 =?utf-8?B?Q2lzMXZLN0Z0NVJ5Vy90MjEyU0xZc2cxR0RDUGZmWElVWExZdlFuRndEL0d5?=
 =?utf-8?B?V21QTGE1aXJvMlUvMlUzRnNmdU8rdlBFUm9IeksxUTdETDV3WXJieWN6YzAy?=
 =?utf-8?B?aWdYWm9Va2VyNlNIM1pVcE93Rkk4UmxXdkQwWWovd1B6WjI3MFRHeFdzSDU5?=
 =?utf-8?B?TVBZUnJWL2NKT3NKRUJhZmt5L00veHlEVXd2bHJ1U0Y1TFRkcmIzbm4va0hu?=
 =?utf-8?B?VjV1ZEIvSG1GT1J3SzJsclhXUXdPMFNacWpRckNkekxVTk42bnFrbUtxN1Fa?=
 =?utf-8?B?QmdqQSsvYW5mcGJmNXIyczVOVmQrOFZBYWRJLzhmUTd5WFFNTWdCTVVpWE05?=
 =?utf-8?B?SENDUDBuTVdFWSs4SFowRUt6VFRHcEZNdWZ3ZW1BTlhjRFZ6eG9mUXRNMGlR?=
 =?utf-8?B?Rit1RTFkVXlHcXg0VFowSUJpZkpUZ3g4NmNKTlhqVDcwdXpYQ2FHdTlsdG0z?=
 =?utf-8?B?S2E5MDcrbmUyMjdOcUQwTCtSZ1VlMjBBdUhHSXdrZGNac3hQRXQwc0p2NXMz?=
 =?utf-8?B?NkwxMEVKRjl0VnErWGk3blIvbjJ1TyttZzk3TUg1V1QwTUY4UlhhVVZUMDhu?=
 =?utf-8?B?KzFCUWFmaUVzdXowZEpYSGRrWU1FdXJqdHh0eVV6WVlraDl4Y3YxQjcyM082?=
 =?utf-8?B?QVE9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbeaf0e-db45-441e-14a1-08dd5c9832fd
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 10:18:11.8903 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zY7O4RVFxdR7vnqn7jbPWUO420bCckZkSR74XmXonL1xuGM1+30YAwpSghnNAQ/3rLTB0e4p9eXCtP+gSs+RI2FLILappZ2GKA3ZkUHIj7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10399
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

Hi Hendrik,

On 3/5/25 7:35 PM, Hendrik Donner wrote:
> [You don't often get email from hd@os-cillation.de. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The CONFIG_*PL_BUILD defines are currently not defined when
> preprocessing the dts files, leading to build problems with binman. Set
> the defines based on the related CONFIG_*PL values.
> 
> Tested-by: Oliver Graute <oliver.graute@kococonnector.com>

Please have this person publicly answer they tested it instead of having 
it already in the v1 of the patch, too easy to impersonate someone and 
give a false sense of trust into a patch that may not actually have been 
tested.

> Signed-off-by: Hendrik Donner <hd@os-cillation.de>
> ---
>   scripts/Makefile.lib | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 54403040f00..dd2c6363224 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -217,6 +217,16 @@ dtc_cpp_flags  = -Wp,-MD,$(depfile).pre.tmp -nostdinc                    \
>                   -D__ASSEMBLY__                                          \
>                   -undef -D__DTS__
> 
> +ifeq ($(CONFIG_SPL),y)
> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_SPL_BUILD
> +endif
> +ifeq ($(CONFIG_TPL),y)
> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_TPL_BUILD
> +endif
> +ifeq ($(CONFIG_VPL),y)
> +dtc_cpp_flags += -DCONFIG_XPL_BUILD  -DCONFIG_VPL_BUILD
> +endif
> +

You don't actually explain what you're trying to fix here and why this 
fixes it?

Why would you need those symbols for the DT?

For removing nodes in xPL, you can use one of the bootph- properties.

The DT is supposed to represent the HW, so having a different DT between 
stages is very likely wrong. Note that having a subset of the full DT in 
xPL stages is a bit of an exception here, for size purposes (usually 
because of limited SRAM) or boot time purposes (you don't need to enable 
everything in the DT in the first stage after BootROM simply to init 
UART and DRAM :) ).

As for binman, why would it even need to be run during the xPL build 
stages? Can you provide more context on this?

We have some big nasty ifdefery in arch/arm/dts/rockchip-u-boot.dtsi for 
example, which has some logic on whether some symbols are defined, but 
they are defined regardless of the stage and I assume binman gets run 
only once, and not in xPL build phase? Is this something not applicable 
for (I assume that's the user of that) imx8?

Cheers,
Quentin
