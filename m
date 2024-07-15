Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D52F7C3DA61
	for <u-boot@archiver.kernel.org>; Mon, 15 Jul 2024 18:15:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2E647888D4;
	Mon, 15 Jul 2024 20:15:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=genexis.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=genexis.eu header.i=@genexis.eu header.b="h7c8MGr/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CEC787F9F; Mon, 15 Jul 2024 15:23:35 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2072a.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2612::72a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 17E6A88827
 for <u-boot@lists.denx.de>; Mon, 15 Jul 2024 15:23:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=genexis.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WE2/X2m0eRvR6U9XmNcNwAyFCz9QbGt17r5/gwxKRmvza9sXCxMWY1WtBTHMdWHqYDbxcPWg15pHVrIp6LO13KsXtgkQiXTzK66MNJb/S0ct1LJeqHo+4wkJQJ4SouR9aNxxSD1zQrvOYCjX6gXZuRQqNpqnuM3pnuCPtN3DJE78N3FmtPShQq6ciZcRecsEmcITbMWsg9TtlTFqnoCfE4l30NGqbmvt65LxjIpTH0U/61YOkYDxxfAoPDO62GchbO1tj6DfGlg+mYllqs1aKGzmLPTds85fuUUvOW50ZlrxeC2PuHIsHKCNJUncslJifVkc8GbMoB7QoWqcMI1vMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I1MkxXtw08j607YFjkXPJ/XgirekeVnqPsBAq9c4ciU=;
 b=l2ec4utVEbmBgWLwKQl2rQB055d2t6Jz/xtax2Q1XXGIX1zSSWHqcRs9AvdiwtXcyO5X8vHEU6le4Z6Zpxn8MWPA7ZkHqSRWl8YbU9WeR6EUmdJqbcxat2QEc+G5jrsIJB4QFS3F3KzgGRmdvDCh3DbEiPuHB+SKvPBLnAD0eSAh63QxthoAZHN70J4efE9ulX64i4+D01Gcqf+cZ3ZfozFfRPUawJwXCJWDev521+EIuTBF2S0KbXsuF0AzFo8Mb+xoYKEykUC8MSvd1KHENR4zjGwnjH/lP8UMeio8vmFp5Csgaw7bAQsQnn0vTzZ3aMqQjeOMnWFhnV7+MSNPgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=genexis.eu;
 dkim=pass header.d=genexis.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=genexis.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I1MkxXtw08j607YFjkXPJ/XgirekeVnqPsBAq9c4ciU=;
 b=h7c8MGr/0PaXQSQWTo7N0GPKG1DoomEDBMMMhv0HPEo3ty9b9Y7DXw6xvAwhLBDvD2NPL7Ajh82pK3xmYPqh6ZLeQbY2YJ9SwREULB0hWSa39KivtJiKDaHcxlt8crtSIq/g3xv26f0PJagHsxzDruL4AgEQWtvCRlV7156QdP8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=genexis.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by AS8PR08MB6598.eurprd08.prod.outlook.com (2603:10a6:20b:336::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 13:23:31 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%5]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 13:23:31 +0000
Message-ID: <be9e5850-098a-4856-a421-5a4b8cf06c2e@genexis.eu>
Date: Mon, 15 Jul 2024 17:23:25 +0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] led: Add dts property to specify blinking of the
 led
To: Simon Glass <sjg@chromium.org>
Cc: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes
 <rasmus.villemoes@prevas.dk>, Doug Zobel <douglas.zobel@climate.com>,
 Marek Vasut <marex@denx.de>, Christian Gmeiner
 <christian.gmeiner@gmail.com>, u-boot@lists.denx.de,
 Christian Marangi <ansuelsmth@gmail.com>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Michael Polyntsov <michael.polyntsov@iopsys.eu>
References: <20240712052507.2496669-1-mikhail.kshevetskiy@iopsys.eu>
 <20240712052507.2496669-3-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszThBPaojbFHZf_OpJz=Ub+ikcMZeoa11GeJ422HNPa-s9A@mail.gmail.com>
 <654fbb9b-dcea-4c07-85a1-47e48d3057d0@genexis.eu>
 <CAFLszTgzgMuB70YRnFUuKvdn9UH3K9ifrSDThDbioQAoaeMMmA@mail.gmail.com>
Content-Language: en-US, ru-RU
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@genexis.eu>
In-Reply-To: <CAFLszTgzgMuB70YRnFUuKvdn9UH3K9ifrSDThDbioQAoaeMMmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P265CA0204.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::24) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|AS8PR08MB6598:EE_
X-MS-Office365-Filtering-Correlation-Id: 7962290e-f805-4b5b-34f4-08dca4d151cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eXNCUjB4cUhQakpwc0NnVjJhTlZqaHJJYmQ4d1Z3V3JEeHE5MXVyZVpPL04x?=
 =?utf-8?B?QTgwblVtRVNlaVBJd2I5NWdVSzJRZThPTEprdEIwUE1YQ2IzcHpDSVdIVHd4?=
 =?utf-8?B?dHJiVlFaNmcvMjJwN0dqbXBpMWJhWWVoOGdhR3FCL2NxQmhGOGtibFFrT2Z0?=
 =?utf-8?B?RkdBRHZ5NFI1U21qUzBWS0NUeHZKb3VrSjJQZGRCTWsvVGNlME41MzlJczRj?=
 =?utf-8?B?cXVmVjBNaGY5dWZ5NTNRVmp6ak1CaVhKSFM4b2o0T0VBM2lJbmFKd0JzZXUy?=
 =?utf-8?B?UHlWaE8wYWlMUjBnNXNRMVY5cWRXMFBKVFJHWktMc2ZLU013dXhMeWtjeTBV?=
 =?utf-8?B?d081SjJKNUdZMmdvdVBEVjdPeDVmbTFEdm9DRSsrL1dQYlQ3aDNIT2NQMHZP?=
 =?utf-8?B?NGMwajRBMzUwUlZEanBuTWpuaGlIYkxUTEs1cENuK0tsWUYwTm9SUUZnanBl?=
 =?utf-8?B?TXhHaUwzQkhUcWRmOU1oZlhEYWlqdThldE5JTndJN1N4SmR6c0RXSUZKTHBh?=
 =?utf-8?B?Qmk1TnpwUDB0Znl0KzVSS1U0MHJnSklPdW9BTkJhSnZJa2IxNXplUG1qWmdz?=
 =?utf-8?B?NnFCK0Flb2laWFY5aFVTRit1eVoxZGo5OG9MdDhpZXB3bUtHTEUxTW5MRWFi?=
 =?utf-8?B?dkJNM0xuUEdpc01tYU0xaG9kYUZ4d285ZlJGYXN3K1pmRjJqNXNLaVAyV2N1?=
 =?utf-8?B?VUJYVy9yWjZYdGxjdDgvZ2xvUWxWcWZ0bHFkVStuL3N4RGNEcXZvNmZaOXEw?=
 =?utf-8?B?blN5a0MzeFpIdWdvVEw3ZWxXSnRaZHZzcVVDdkNWM1IzZEtDbnV3VWczTWIy?=
 =?utf-8?B?SlVWcEw5dXo3clZHTlFsV0IvazBZUTYrVm9HODhYOXd2YXJWQUZpREVML0Vj?=
 =?utf-8?B?dkdTTlYwQ1Z5U1FqSjIzWnpaYjBEVTZvUHlwMFcvSmkydlVMZzJCOFlEVW5i?=
 =?utf-8?B?UGllKzVvVVhpMmtZbnRaRGtMZWhaN1lFNGpqWVdZUVhhY1hWWkdPcUdDSDRM?=
 =?utf-8?B?ZVVCZDQ3dmdPWDNoNGl1NzZFRjRwdGlPV1lJOEwxYnhLekpUQUlKU09Tb1po?=
 =?utf-8?B?a2xpWkorV1plYVlQVHB3UFp6bm15THYzcTIzbWtITkczVVk4ZlYvVjVrT3I4?=
 =?utf-8?B?Wm5ud2tnVTBaMGlQZU04SnUvejA4R0lhTEptYWg1ck5kcGJRQUVPM0tXVXlB?=
 =?utf-8?B?czhoT1pZSkFRM2QvSjZBS3RuR3hpamdYWjArWThCZUNKd3JOc0JWSTdMWkg1?=
 =?utf-8?B?ZnUrUzBoQXo0d0pFVUE4aytYTzJlL2N3V3AzQXYzdGI4YlZ1NWhSVFR1YkZx?=
 =?utf-8?B?V0xNSVFMVXByUG5VZzJibXpOUENBOHQ3cWJFZk02VWovL3U1d3QxVzg4UTdV?=
 =?utf-8?B?Vzh5OFQyTStYSkpJU1BLQ1ZRSVRQeTVSR3pYZFhoVlp2VXptV2VVMldpdHJK?=
 =?utf-8?B?UWI3cVIzckRkRHI2clFOdkdNbkx5NDh0MVRPb1J5aGptenFBWThtem1ZYllH?=
 =?utf-8?B?TXFkaHhsbUNlV1dITXJiQnhnaWpYcTk0emdLSVdWVXk0STJSYUoxL0ZEYVRP?=
 =?utf-8?B?ejRQVmZaRDdrTlNENE1aeThBa1g1SmY2VExnMEErSXNaeWpBeHp6NEhqMzVx?=
 =?utf-8?B?RXhjdHRtTTBYVjkvcnpmTlhGRERLWStGb28wam9CUWVDNnRBQWU0ejJVOWJw?=
 =?utf-8?B?WDlxMHJUTEJRekYxQ3dCampGVVFvMlQ1Y0YrajA0N1E0WHgvT2Q4UHQ3OXBY?=
 =?utf-8?B?S1p4bGRIOStscEZHbVZmMkhEajE1TDRQdzh2dThEd3luRTdTNXhmakZZQ2Nx?=
 =?utf-8?B?Q3pqSmpDMmw4QTFQVU1VUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDZPWTFPZEc1S0dDQ09OVGFzTWtqZHVLb3hCMVZDUS83V0phS25GVXJPS3A5?=
 =?utf-8?B?dGtDK3IwUjd1VW1Ka2duQmhWR29NMU9xblN1VzJMSG9iZHlTTGQ5Z1QwTXJq?=
 =?utf-8?B?RW5Va09nUE9ZSFZLZVBadW5TWUFIa2JrNHFkNVNHZ2N1TUtXY1p3RlpoM0lK?=
 =?utf-8?B?ZmI3VGVLbjVNRkowZWFOTjg0MHcrK25LWm5lNDlqaE9oeG55SExSNUtESmlE?=
 =?utf-8?B?TjlTVjZTMWx6UmVaMGEzSUZtNnFrNmwvckZDZGNWTkJOM29zZHR6bUpuK2RO?=
 =?utf-8?B?bkZXeDUrZDNBMTBPSW1CVzNrYkduT0JTODVJdWx5QlpNamdyWVBZVldGU3Y4?=
 =?utf-8?B?NWtwTXhOVW53RWlmMmM4aEFEOGdzT1lkT1JPT3NaNjkzV1pvbklVUlFJcUxO?=
 =?utf-8?B?YkFDK01ZT2ZEYmVGc2hJZEEzeVFscDN3WnovWUh3Y1BTaE5vL1pvVGkzTGVW?=
 =?utf-8?B?YUZ1MG16ekFncXhlM1hrVGhIN2ttVTM5QSswbVBicFdoSmtxeDBsZU14UGhB?=
 =?utf-8?B?K0xxbThtQ0lNdGY1QmRkL0x4N1R3bUlGZ2VLL0QyeTBSRThaQjZrNFJuQSsr?=
 =?utf-8?B?STh4ZEI5QmVGZ2FuUWVCZ3Z1bVdYK1JoM1kveUJza2FKOEgzd1RXbmwzNXVC?=
 =?utf-8?B?UjRydTZiZEtFNlBEaUovSS9VdGkwNEFRcFM1alc4MjhpRVZSUlAxWjlYbXpR?=
 =?utf-8?B?NGQ5U2w3eTlvenpTdnNNVzFRcGJsRUpsQmdqMzhmRE1VajY0S2t5TXlnWG1m?=
 =?utf-8?B?dE9wWXc3VGROc29JRkNkSVFMdHNzREFISVJGNWZmR0hSd0tFR0ZwT0RFNnhz?=
 =?utf-8?B?T0ZKZXl5cTFFWjhDQzdzd3V1ajJmOFJtZ09LYUlteVEzREJEdktnYjJnVG5W?=
 =?utf-8?B?S2lNM1dSWGg4R1FjZU00UlVaMFpNM2JLWCtsWmozY0JDVVBKczlQZ0JIV09q?=
 =?utf-8?B?OEtrbnluYWVEV2FvSWlhcmpaRllLN0J4N2ZoajdwR3VoYkFQekdsdjE4dUUx?=
 =?utf-8?B?TzEycndVU3pGSFkyaEl4OFdjTEtNZ0NoeFhtOUZpNExhZFQrU0FXKzc1Zlov?=
 =?utf-8?B?RXpuSWhyZjFUY2dLYVpwbmZWdVhTdU5aL000TStTbkRYSEc4cGY4R2lFaTZs?=
 =?utf-8?B?TWliaWlYWXdrU0MvRjVvT2xiWXYxRVFhUlNCeEl6ZkY4RWM1REJyRVlONmdt?=
 =?utf-8?B?QzN4WXZLbVc4VjNKV1VpY3NzVTFYZWtqSTAyY3ArQ1JQVXk4VnhlQ1N5ck1E?=
 =?utf-8?B?L01hbnpOSUpZekp5NXpuVGFRV3hnc015MFVCNzVVd3V3OVFCSkcxS3FucFF3?=
 =?utf-8?B?ZlJaZ0p5YmJpN3FoS25TdFZNR2JrOVZmYWgxcGk4UDd0L3NHZjZpVmdQV3J0?=
 =?utf-8?B?R0dZd0ExRWREQVBXcU1kQ2ZSenNIdXhyRW1hdUkzd3pJYU1hWFNualNaQVI0?=
 =?utf-8?B?ZzNkd1hvSzByZEx1enJaWDlFWUxiUTJMa2RzM0xJOXRuejFOclMrbHNiYm8v?=
 =?utf-8?B?TUoyS2Flai91dEl1MDBQdFJBWVhReWhpWVBVWFlaRlNyVUc2VTJNUlp2WDFS?=
 =?utf-8?B?eHBkSEJJaVV1TjJRcXgzUEN2ZzFPejI5ODNsNzM4emtyL2c4cXFzbTRqRE1y?=
 =?utf-8?B?ZkZJbXB6QW1qUzB1TGFQamJocWtVUzVSVysrWFJhM0xTc2s4dVdyNzc2YXk1?=
 =?utf-8?B?M215L2s1SFFlaXlwNWQrSDZ2T2d5dGRubVl1Z1N5cThnYTJzeGo5WkVaQVIw?=
 =?utf-8?B?ZndqS3J1ejNkU09oL3YwOWF3V1hYK0llYm56SnBvUUhqRWw1RVFJM2xPSmhk?=
 =?utf-8?B?WVBhRmpuMlpFTkIyeXFKUnVrZW5YL0UwUFhpS0svazVCcXBObWZYS1lvZFRT?=
 =?utf-8?B?eGlUMGJzK3JmZlF3cWZhVUFqS050cE0rQ3NlU01pMXlRakhOREN1MWR4MHow?=
 =?utf-8?B?WGt5Q29FUjJpcWUranpQOFFrOXRGZ0RZS29Sczh0R2VxNnNrRnZ3d1k5NkhI?=
 =?utf-8?B?Wko4bW9DQ0Zib0k4bEo3cVpNbUhxSThKenZGNGJGVjdZU1ZZcERCRFVKSHZl?=
 =?utf-8?B?WUpSaGlDT2tqZ2tNcGUvbWFXZzRSK2lOUlRZMm9NakNwWnh3SjdxMS9jYkxN?=
 =?utf-8?B?NVRVazE3V2VUVXd5RnhxbU1DU0Q0U2lQWWI1YXplaGpzbnlSOEFnc2VETlhN?=
 =?utf-8?B?N3c9PQ==?=
X-OriginatorOrg: genexis.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 7962290e-f805-4b5b-34f4-08dca4d151cd
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 13:23:30.9543 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvBHKhXzVVS+SIYH8bW6lqDCBvIwO94avJh7yo7ONcxR+gxfihpPy2XdJXV7RBKfoEm1yVqDeZRhNT6/TQyafOl1h1o6Ubsnl8BCAY1FpXo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6598
X-Mailman-Approved-At: Mon, 15 Jul 2024 20:15:10 +0200
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


On 7/15/24 11:11, Simon Glass wrote:
> Hi Mikhail,
>
> On Sat, 13 Jul 2024 at 17:32, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@genexis.eu> wrote:
>>
>> On 13.07.2024 18:13, Simon Glass wrote:
>>> Hi Mikhail,
>>>
>>> On Fri, 12 Jul 2024 at 06:25, Mikhail Kshevetskiy
>>> <mikhail.kshevetskiy@iopsys.eu> wrote:
>>>> From: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>>>>
>>>> The standard property
>>>>
>>>>     linux,default-trigger = "pattern";
>>>>
>>>> used to get an effect. No blinking parameters can be set yet.
>>>>
>>>> Signed-off-by: Michael Polyntsov <michael.polyntsov@iopsys.eu>
>>>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>>>> ---
>>>>  drivers/led/led-uclass.c | 33 +++++++++++++++++++++++++++++----
>>>>  1 file changed, 29 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/led/led-uclass.c b/drivers/led/led-uclass.c
>>>> index 4f5dd66765e..90047ad35ba 100644
>>>> --- a/drivers/led/led-uclass.c
>>>> +++ b/drivers/led/led-uclass.c
>>>> @@ -100,6 +100,9 @@ static int led_post_bind(struct udevice *dev)
>>>>  {
>>>>         struct led_uc_plat *uc_plat = dev_get_uclass_plat(dev);
>>>>         const char *default_state;
>>>> +#ifdef CONFIG_LED_BLINK
>>>> +       const char *trigger;
>>>> +#endif
>>>>
>>>>         if (!uc_plat->label)
>>>>                 uc_plat->label = dev_read_string(dev, "label");
>>>> @@ -120,6 +123,12 @@ static int led_post_bind(struct udevice *dev)
>>>>         else
>>>>                 return 0;
>>>>
>>>> +#ifdef CONFIG_LED_BLINK
>>>> +       trigger = dev_read_string(dev, "linux,default-trigger");
>>>> +       if (trigger && !strncmp(trigger, "pattern", 7))
>>>> +               uc_plat->default_state = LEDST_BLINK;
>>>> +#endif
>>> I still wonder whether you can use IS_ENABLED() instead of adding #ifdefs?
>> LEDST_BLINK depends on CONFIG_LED_BLINK, so the code will not compile if CONFIG_LED_BLINK is not defined.
>> Defining a LEDST_BLINK unconditionally will produce an issue with cmd/led.c
> We should not use #ifdefs around such declarations. What issue is
> caused by defining it always?

We need to patch cmd/led.c. Without it we will get:
* something like out of boundary access
* enumeration value ‘LEDST_BLINK’ not handled in switch

can be fixed, but probably it should be a separate patch


>
> Regards,
> Simon
