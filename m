Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05A30C021B3
	for <u-boot@archiver.kernel.org>; Mon, 24 Feb 2025 09:48:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19886805C4;
	Mon, 24 Feb 2025 10:48:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="mBFJlUwm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2BFF180EC0; Mon, 24 Feb 2025 10:48:53 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::61a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D611480079
 for <u-boot@lists.denx.de>; Mon, 24 Feb 2025 10:48:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqVCbvKfyLCae47vhhG/HEAu5V4hs+/eMa+I/hFGVIqcMbcZaNr1Rr1drwMfoodn0lZY/FjdDwEShFRG5sxb/BcMMa1vbBv7Q4pxFMO8PjOnychQ3mQGmSKD6Dt4beND2c1udFQNaWQSFOyWR4VoSnQYADPjefJvYbDO+LtSsB8jz9sZwSz4B6Epw7UoV9Rl1qGdUkq9wauuv4PXn0U4bW9gzwsfXNdbU+Ug9Q4D0sLzRYtNjJAgThO57Z7XnTETw4ABIN3rT8jvai3alDyi7DaLjZss9kvXKgQt4avdOYY+f2xj0wVzl5dn3kSlSj1OvEi7S1s3rpS0paE1TOQBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MyUKvK5bq+IeGDJNz+sBKfR6U1BrcM+UUOu0IVVKSMs=;
 b=U6zmPJf8WWJZGvgfNdqwitzt0IRO9c38/WHhFF8WObCyG6apQmcsD85ccT2QfwAy+ijq6zDo8DD+sZXZfg3hsLwMX5+U/Em7XQgA6khEsoZfmELW7RZKQjhZyEJyfdtrv+Q+LkwvMESnrWVpeRGCp6Xr0Qs1jNclSCA1QFECRewXhiHTbQXTUhJWrAQ3/ZhJRaaScvCW+rWvDShuWZ8/mYvofiWVhHy9jEX0Xs1JWwbjEh5GAWZcJHr8VPfIdbkuwTwc53PY5nuO6wFHGd+Tu43f/5yVHO9MSyRsKVJn+PrbZ4Ywoj/eodGryU3Q9R5O0+jMv9FaZGOrIf/gfxiXjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MyUKvK5bq+IeGDJNz+sBKfR6U1BrcM+UUOu0IVVKSMs=;
 b=mBFJlUwmE1TigDet7R/BHk9OCJB6fjdMLG3wr0jCTcmPaDfcxBJxQ4r+yIC4MlPnQRVgXU/Q/ZUjaBXVWHt/e2JusuvS255VeK5iWGd8Vzk7cRLAi7Y8yp7HkapRzJ7UNoSO+IQ784Ucl3lwadLFTCaloPWdqV4w4IBxhQ+1Nwg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by AM8PR04MB8004.eurprd04.prod.outlook.com (2603:10a6:20b:248::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Mon, 24 Feb
 2025 09:48:49 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%6]) with mapi id 15.20.8466.016; Mon, 24 Feb 2025
 09:48:48 +0000
Message-ID: <5d777137-7d45-456c-8098-be65c1e8f62e@cherry.de>
Date: Mon, 24 Feb 2025 10:48:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] env: mmc: Clean up env_mmc_load() ifdeffery
To: Marek Vasut <marex@denx.de>, u-boot@lists.denx.de
Cc: Dragan Simic <dsimic@manjaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Simon Glass
 <sjg@chromium.org>, Tom Rini <trini@konsulko.com>
References: <20250221184732.202336-1-marex@denx.de>
 <20250221184732.202336-2-marex@denx.de>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250221184732.202336-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0312.eurprd07.prod.outlook.com
 (2603:10a6:800:130::40) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|AM8PR04MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: a4623afd-1673-4e30-c88a-08dd54b8700d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NDgwc1JrdHJ6OEV6V3dnUVE2cTY1YU02T0dQc3RLZWs2OExlVjJvWHMrV3Ny?=
 =?utf-8?B?bTF1STd1YTFxNnY0WFlnMitySmRMSkpJVEJwckdLZmdZVkxVajhJY3M0VFo3?=
 =?utf-8?B?SGFOTmcrV09ndnJZbUN6Vm42d0tYaWt6RUQrTDdsV0JyMWFGcFE3NDgvS0ZV?=
 =?utf-8?B?N1NmeW9xbGVMdzg5bkcyUGFaTFlvNUxERVU5WXdzVllQQnJ2ODNEc21aU1BZ?=
 =?utf-8?B?ZHdydTdTaUgvTEtoOTJIQTVNSTY0ZnlOVG5rMm9zK2RHbzRmNlMzd3JGZkkr?=
 =?utf-8?B?TCtKcEZQZWtDbDlmNGJTVzdKY3NGQVFtMmk5WWxERWFKd0p5cjBqemVWaUhN?=
 =?utf-8?B?SytqcFVXZFNBUEVCN1NUbUhHSkY5SUxiTlpYSGtBaCtQUGx0cWE3N1YreTU5?=
 =?utf-8?B?Rk1YLzNPMWRFTFN3N0JZYjY4RFgyZENheTRiR2s1dHU1RTRYejVpUXZoaGxE?=
 =?utf-8?B?akhFaWQyWmk1RWZJaEZXelAvamhyOXRudkR4YUVIR0IyUEo1ZUlCbmRBY3px?=
 =?utf-8?B?bVIxV3FJTXFNZWszSTBUYjlDa1dWb29ZbmFoMEN1QUdpVFZQcGJCMWd6TnNk?=
 =?utf-8?B?RWpZRjJkVWRoR2Jld0haeU9kemczNTBGWTBsQnhGU1g0dmhYblVUUG1RNE1p?=
 =?utf-8?B?cHdiSk5nMWpTWExsVUN4SU1YVm9yc3RRUk90QmhyR2xqSkJRcmd2RExqcXpn?=
 =?utf-8?B?Tk0rTTE0MzVsWEdSRmUvbk0rUks5S0Rici9wanFmdEdGQ1VybUVpSlB3RnYr?=
 =?utf-8?B?UW90dlZLeXpXZFFMTW9BenVaS00wTFRsWWhUK0JSVmtKbmhvNVgwTUpIVDhI?=
 =?utf-8?B?SE00T0ZEOFhOOVU4dVlvSTZobnc2SW9sRWFudkhkV2JmcC92U1BqVHV5ZG8r?=
 =?utf-8?B?SURCTDFXdy9HdFI5aXRHT3ptWTVmTitFQnNWSThXUXdtSG8xejc5dFNJVm9R?=
 =?utf-8?B?b1VXQUpMZ3B3RU9LTEpkY3VIdzdLY2dQOEdXK2FLT1lCdWt3Q1pMaUNYNFA1?=
 =?utf-8?B?YmFCUlNqWVhSVUgzZU40bjVyL2FZVXowVFJwSEpNdERidFNMTkxoWTIyVVJp?=
 =?utf-8?B?YXE2N3J4YldpVlRYYUxPb0liY3Nxc1FPZHBDek1yUm1zMVJlbDhjMGwzMUpN?=
 =?utf-8?B?QVZkWUdCYmFLZWYvWmpLb3VLNTFpNmJPYURuQVZlcVZSeDlIRUduN3FnYzZj?=
 =?utf-8?B?ZVlTTzRNRUpyWjNzemRTQmZNUEtmSEtOU003M05IaER3L01PVXY1UVdBK0NZ?=
 =?utf-8?B?ZVVJRDVsTHNVSFpZTEcyY1NoK2NhRnNpVnJWWldDVmwvcCtKc1oxak53a0Vj?=
 =?utf-8?B?TFlGdXVRc1ZwRGJyZzVpR0xjMTZ4SmZ4ZFpsSnNJMTFwZmo0L2o5RXVnSGI0?=
 =?utf-8?B?RTFqbXcva2xKUmdUZVBBMjFCZGxnVjRzSHZmbjZpbVVqVlZEOVN6TmthQWds?=
 =?utf-8?B?WVFUdnVpcERRNS9RcVB1d2gyUUtickNhYnZPM2tJRm5zWUVCVXVKSVZaUGpx?=
 =?utf-8?B?Zloybm43TEI1blhnYnBTclduYnZiSFQxWHE3VjFvTXpuZDViUEJRTWNxTlBK?=
 =?utf-8?B?bzNtc3F6TjNnQ1d2blNKVXphWGM0MDFiU1R6N2k1NVZVSjlxMFl1bitpMklT?=
 =?utf-8?B?OHNJRTczcGl1eThaajRBcGNMbjNpOUY5czhyUjlpQmJUQzlEdjJPRG52SHE2?=
 =?utf-8?B?QXgwdUhDcUptdTVNTEFReDdzczl0K0IzM0RSTGI3T2VMZEZ3K2JQOGd4RTFm?=
 =?utf-8?B?eTc3UmxxMEFINmJteHlVREY0cEZUdXQrc3I4WGRqb2pEVGRYU2R3N0ZYM2M1?=
 =?utf-8?B?Uko3YjQ2NGUwOEVZUXhia1BORXAvV084KzRaQ1dyN0dJc3BWTTlGRUsyeTJI?=
 =?utf-8?Q?wfYIs/g9G5kBZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUJoSjgyaHMxMEZPY2ZzMlBhVndoSEp5K2lnWTRuNTRmd0dsWFNlampFK2dD?=
 =?utf-8?B?c0FXMkJRVk8wNG9wT2xEcVlFRlMyRTdJQit6MGxQelZXTW8ydW93WDIrK3J1?=
 =?utf-8?B?YkZmaFRLKzZtMzJjUGpUblRlMzFHNUNaZGEzeldWRDVBeHhRVmY0WEtRZGUy?=
 =?utf-8?B?UDZaZC9ia2k5ZDcxNXBLUWpRejFoSmJFUUFTOUEwQ281MmFBbGpTaDNYMGJS?=
 =?utf-8?B?eU5mRG04U3NnNktWa2R6RmZhR2k0a0NWdDJLZThmRVFvdjR1OEFBeFI4MDJG?=
 =?utf-8?B?Q0F0aTA4WEE2MFU2RmlyU0ZsbnBVeWFXYXpGUUhPb3J5Mm9yaHYwTXJCeXYy?=
 =?utf-8?B?RmNIOEEzd1Z4RHhHUW5RSTNhNTZHOTZEZldTUmQ1ai95OCtWaUJPbUlTYjI3?=
 =?utf-8?B?TitmUmZSNW5WbktxMU1OSENDenMrUmxaL01HcnFUc1Z0SFV4VXM5RDJHejJq?=
 =?utf-8?B?bzcvMXJQVmNjMnYzV1BvbDZWT29vdE4yK29iVTJwd2RaZkFuTHE1aWF4cnQ2?=
 =?utf-8?B?RzJwMUl1ajU0RUh4Tm14akhsWmJveEVkd294ZXRkSlEzUis5SnFyaHdTNUVz?=
 =?utf-8?B?Tm5wK2ZnK2oyN3ZPaWZ2TnV6M0Rnb1A0S0kza3RBUitrR2hHOTh5R1Vpd0lT?=
 =?utf-8?B?OGVZNWl1TXkvaVVFU2dJTlQzY0lkRWppSWl6K3B3OUZFM2tIa0thWitNUXBt?=
 =?utf-8?B?bHRnV0pVUFNyeklmcE0xM0N4V1o3UXRGTVJIc1JWb2I1V014TXJNcTc0b2lE?=
 =?utf-8?B?eWx6M1JPcnVaeHQyT2Z4eHRyVkNLN2ptdXNLVE14clpJN2phVmZUQTNPYXg3?=
 =?utf-8?B?Tit3OHp6c28xM0NWQ3FFTzQ5NzRFN2hpMnpEc3h5Y0pHaDRIQjJRL3dpOTVG?=
 =?utf-8?B?VTNBWFlNVHhZRVVES2YzYkZiUHBXdnN6dlI5bE1TUFprR1drVEpIMjJqMXRy?=
 =?utf-8?B?ZmtDR0Z5MDJBOVc2RWVNaEFSWERoejhiRUFDamZrczlUY3lEaVZwVytFbC9u?=
 =?utf-8?B?VUgzamxjRnVKY2xsaW44SXcxbzM3SWkzejdteWdtdDlsdXVzYkxQKzU3eFNj?=
 =?utf-8?B?WXVIQUlNY0NPOHluZ21XUzlHTHpUTVA3N3hWYWtmUmd0cWlGZ1hwNy91bXh5?=
 =?utf-8?B?MmxuUEVjcmVUYlRwVWs3NmhCTEd6akVWT3N4TnNtd3FzUFFvbGhuVUNGeWRH?=
 =?utf-8?B?TThZa0lMM0k3QUZDbzgwVUpMdzNaVm03dGxYSlhvTVNMSXJuMGNNUHVlOThX?=
 =?utf-8?B?U2U5WEFUajdKYmc4eHNOK1k2ckp4RjVVMWdvczdNaEVoN0Q0UjRneHVhWTNP?=
 =?utf-8?B?L2VkbHhCeWFTSXlxUXhuNEdKTURwa0xIc3V6NDdicGkzMGt5SDBFN0JGaVo0?=
 =?utf-8?B?eGd1cGswaDd3MkVJUk1vemlRNDJzUWZlMW13RU5UbldXS2ZJWGN4Ulh4K3d2?=
 =?utf-8?B?bjhrU0lZSTJualExUkMwL3Zmd1F3akZLUkRoZmNxK1NIdU43YW96Z0JPeFM1?=
 =?utf-8?B?Q2hhSXdiQ2hnOGtBOVVvQWJlNHlvcGE0d2xuZi91Z2FrTWYrNHFUZ3laWE5r?=
 =?utf-8?B?bHpyb0svbzZmakx4K2hHMk1tYjhMdTJ2K1NrQTZZclB0eUsrRFZoZ0pqUlBZ?=
 =?utf-8?B?UFdFYytFNkNBcmxRY2V2ZHAzT1lHU2MyM3J1NHBwejhVNEFzT2RkM29DSGNI?=
 =?utf-8?B?cGpWVXlVNElVMmdTZVpQVWtkU0ZIYUVwd3lXanVNOWNMcjI1d2ZDLytGR1ZW?=
 =?utf-8?B?ZHkwQUt1ZDZmMnMyc3JZQzhRWG9DK1VEZ2ZOdGhka0ZPRHgwekg3aitzQ2Fa?=
 =?utf-8?B?UjFLcTViRitHZlNxRGRONXY0RERtbVJJZmtSbVpaSG9HalFWQ1BMMTVQcy9x?=
 =?utf-8?B?cTFmS1JqWXJVdmpYSFVYUmlTZXpaOWtqMGxYeXVlQ2FKNy80YmJpM2l3QS9L?=
 =?utf-8?B?YTRKZkVsMFZOMktJOXlucjUvU0o5aS8zY2l3dHlMaC9VNXVOK1N1RVA5STM1?=
 =?utf-8?B?dW9IWmZPNVRKTVdzQzlVajNTc000UTdPeDM4Qlp2WFErZmVmSUdnWDdrbkhR?=
 =?utf-8?B?Y3IxVDhrZ1FrcFdqOEZMd2xGSGM3cHE1eU01NmpZVHB1dkFxUTJOVGdoVFJi?=
 =?utf-8?B?REJvRXNiOFFrQXhoakdZajZOMlFNV1gzWFU1aVpiM29Lc0lmT2lzUUVIRmtr?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: a4623afd-1673-4e30-c88a-08dd54b8700d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2025 09:48:48.8682 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWhB9k8xJPO5Fru7NCkxLxv46cIVyByfkRebHxeRzL0JSR0MrMMrrjbZss573OJINIcBhq9kPX9dlYgCvQfQBPrbfLf2s8TxewXweaiXViQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8004
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

On 2/21/25 7:47 PM, Marek Vasut wrote:
> Rename the variants of env_mmc_load() for redundant and non-redundant
> environment to env_mmc_load_redundant() and env_mmc_load_singular()
> respectively and convert the env_mmc_load() implementation to use of
> if (IS_ENABLED(...)). As a result, drop __maybe_unused from
> mmc_env_is_redundant_in_both_boot_hwparts().
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: Dragan Simic <dsimic@manjaro.org>
> Cc: Joe Hershberger <joe.hershberger@ni.com>
> Cc: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> Cc: Quentin Schulz <quentin.schulz@cherry.de>
> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> Cc: Simon Glass <sjg@chromium.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: u-boot@lists.denx.de
> ---
> V3: New patch
> ---
>   env/mmc.c | 25 ++++++++++++++-----------
>   1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/env/mmc.c b/env/mmc.c
> index 353a7ce72fb..2ef15fb72e7 100644
> --- a/env/mmc.c
> +++ b/env/mmc.c
> @@ -205,7 +205,7 @@ static inline s64 mmc_offset(struct mmc *mmc, int copy)
>   }
>   #endif
>   
> -static bool __maybe_unused mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
> +static bool mmc_env_is_redundant_in_both_boot_hwparts(struct mmc *mmc)
>   {
>   	/*
>   	 * In case the environment is redundant, stored in eMMC hardware boot
> @@ -448,13 +448,7 @@ static inline int read_env(struct mmc *mmc, unsigned long size,
>   	return (n == blk_cnt) ? 0 : -1;
>   }
>   
> -#if defined(ENV_IS_EMBEDDED)
> -static int env_mmc_load(void)
> -{
> -	return 0;
> -}
> -#elif defined(CONFIG_SYS_REDUNDAND_ENVIRONMENT)
> -static int env_mmc_load(void)
> +static int env_mmc_load_redundant(void)
>   {
>   	struct mmc *mmc;
>   	u32 offset1, offset2;
> @@ -510,8 +504,8 @@ err:
>   
>   	return ret;
>   }
> -#else /* ! CONFIG_SYS_REDUNDAND_ENVIRONMENT */
> -static int env_mmc_load(void)
> +
> +static int env_mmc_load_singular(void)
>   {
>   	ALLOC_CACHE_ALIGN_BUFFER(char, buf, CONFIG_ENV_SIZE);
>   	struct mmc *mmc;
> @@ -556,7 +550,16 @@ err:
>   
>   	return ret;
>   }
> -#endif /* CONFIG_SYS_REDUNDAND_ENVIRONMENT */
> +
> +static int env_mmc_load(void)
> +{
> +	if (IS_ENABLED(CONFIG_ENV_IS_EMBEDDED))
> +		return 0;
> +	else if (IS_ENABLED(CONFIG_SYS_REDUNDAND_ENVIRONMENT))
> +		return env_mmc_load_redundant();
> +	else
> +		return env_mmc_load_singular();

The else (not its content!) could be removed since all conditions above 
return.

Isn't this going to be increasing the size of the binary with code that 
won't be run or is the compiler smart enough to remove that based on the 
IS_ENABLED() that are constant false at build time?

The change itself looks fine, therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
