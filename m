Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FBFC02180
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 10:48:44 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0475D80040;
	Wed, 15 Jan 2025 11:48:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="nF0OCa1a";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 66A3C800C2; Wed, 15 Jan 2025 11:48:42 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazlp170130004.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6AE2A80027
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 11:48:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QulcXMWddvPQwqT3+pmR192SqIVeccGNzhAw9p/5rLkXAzKUibsokpXUwLkVDW54ffATJWfODSEwO2XL7Jgov7i/oO4iYobec+lx6Naij5JDGONDbtq7umVHLgyw36Bl1wc/nuqE9TRPGIezymHgJjPoKXJZdMtO/dsNPa8zSZRMgElojx5qeC8fabPWekiSLiwpPq84A1gp1sjo+7mZZqibITfJreXv7LwFeEkj67WSfG4X8I2oE6z/yApebkeWg/ShJWqFIyMzQI8HMWnZalBsDt4jo904AWOwXrBOx0msSGtvujainvb2vDh4dpjPx0HbvOvv1pr6GvsdMjkfbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8C6kP93w/ZMX8CNLcX4UTsgsAMIVFMQ4uz5v7ahIm8=;
 b=tofPrJEEaK3gRBAjzceNnjtWFhAirEvA9cyxFMPng5yLVI/jZFbUaYrcEqRyJ6NTaP1HIoeH0KjrjjZcT3DJHifgNB9Id2SyQ2yn+ocll3g5mioQIzW0E/jQNWBWEazCyh5EEO3zWA4+ReKECq8i4xGm3EKC6RiF1btXIDXIKEr9w5MqPObJwo3wtiYma5t5WUrMA4l0YkXdWlvK/71B5MnGcGW+IRgtNAqN6J56L6dfxhm6zlPw5056dZ50Gyzn6pIT2boOoWkwQ9aSRvz3qube9gM/sOmE1XTwp0YZzQDOPFvAhwMy4FhT+RMRwJJY9PNXlPeCJzaf/SezdBn/aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8C6kP93w/ZMX8CNLcX4UTsgsAMIVFMQ4uz5v7ahIm8=;
 b=nF0OCa1aDihhBrASevW0VUf10QjYu3Dm5rwCv8EaRhqRQOQxdnsJmXMVvOVKbgQu49nBpXA4ytHMfrbk/Zul6A87qrB3PDA8nISyfFaZ7f53pad5vWIcDE1o2a970obyxlDusu+iMI+7iCCtz8AiNjcqP0WNDVgZQ9Hqtaczoj8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA1PR04MB10442.eurprd04.prod.outlook.com (2603:10a6:102:44a::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 10:48:38 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::35f6:bc7d:633:369a%3]) with mapi id 15.20.8335.015; Wed, 15 Jan 2025
 10:48:38 +0000
Message-ID: <6f4d893a-a7e2-4f9c-a6fc-55518f5227e8@cherry.de>
Date: Wed, 15 Jan 2025 11:48:37 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] video: rockchip: rk3328: filter unsupported modes
To: Vasily Khoruzhick <anarsoul@gmail.com>,
 "Matwey V. Kornilov" <matwey.kornilov@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Kever Yang <kever.yang@rock-chips.com>, Anatolij Gustschin <agust@denx.de>,
 Dragan Simic <dsimic@manjaro.org>, Chen-Yu Tsai <wens@csie.org>,
 Christopher Obbard <chris.obbard@collabora.com>,
 Jagan Teki <jagan@edgeble.ai>, Marek Vasut
 <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20250114052548.763611-1-anarsoul@gmail.com>
 <20250114052548.763611-2-anarsoul@gmail.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250114052548.763611-2-anarsoul@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0165.eurprd09.prod.outlook.com
 (2603:10a6:800:120::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA1PR04MB10442:EE_
X-MS-Office365-Filtering-Correlation-Id: 87d647a3-5c7e-443d-0c42-08dd35522b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|1800799024|366016|376014|7053199007|921020; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?OVowZzZIeGd6UzJJait0NVRSeDFzNWo2T0crdDN5YURWa1hOWGFKbXNCUGRr?=
 =?utf-8?B?bkE0SUlkRXJQTEhwZWQvNC9ZaGxsVUp6ZXdXNmlxRFFSdWpHVjNrRXhuMk9r?=
 =?utf-8?B?OG5qcnc5WCtQOWNVN0YyU3RlMmNtZ2NyL3c2VnJJSGltSGZvbUNzcGFWQTRT?=
 =?utf-8?B?VUJsUm9FZ3B6cFo5SjRXY3R4THkwYzRjQzJCZkJqTzRVVEZ6R29ySEVUNWdF?=
 =?utf-8?B?T2d1aFRmY2VWUm1UTFM3U1F2QzJIeGJFOG41WlB6MnlxMUpIbWlRc0NWQTYr?=
 =?utf-8?B?UWhiRytGZGs4VWVjMDlmYzlKTGNTaUV0TkNUUmJGb0VtZmNiRndycWFOZU43?=
 =?utf-8?B?REY5b2d5TUZBT3NsTzE3TFIwZUpYNEdDeGZ3bDlnNWhsRU9Ed0UxR1o2MDhj?=
 =?utf-8?B?VmxwbldNNEZ6Mk5hYTBYZ1pnWk9Cck1ZY25CdEJ0R2FiTXJBMmpLbU1haUlh?=
 =?utf-8?B?UXkzMFdZUGxOK3FCU3AyRi9seVBhUE84bWdlTmo5NW5paWtmTFlOTUNLOTN3?=
 =?utf-8?B?NUticHR1dEpwMS9xeUt1QnFZVFhZa1R5WGVrQkZQTTZiV3R2a0dFRkdLNDN4?=
 =?utf-8?B?OC9ocUpTejZ0M2pYc01XaVYxZ0IwaXFEZ1J4RldBRU9jL096dHBma1U3cWE5?=
 =?utf-8?B?cXdOdnlBcDEvMmlqQVN4cllSLzBlYXJaYXpVeFh4OWZlakRtQmVkZlFCU1VH?=
 =?utf-8?B?UDNTN0pUSGVTNEJWRkFrY3RNVXVJbTM0b0J3RXAvbnJjbkZzQ291eTFsaFNa?=
 =?utf-8?B?aVEzZk5nNGp6WUdNVk5VZUswQVVGajFpV2VDalNmZXpLekpHWTlSQ0hLOVh5?=
 =?utf-8?B?akNGVEFwd0N5VXJ2ZmFEbElYNVd2cXFJb1dCMHhZcGVibnRrUzluY0dtQWpW?=
 =?utf-8?B?RjlqZGlRcjhkbE5PQks1LzBybWtaTUJ5MUpyenhwd3R4Vk5JWG9FV0FkN0Rl?=
 =?utf-8?B?ZFV1elFqV0hpYkpTbUIrVmVUOGsvUlNub3kvTTdUZVdIM2tXQnAvSWZsRmtJ?=
 =?utf-8?B?L0M5UjQrUS95eEh2dUEzaEJ4cU0yY0hJYzVSL1JJdWtoeVB0NGtvMU8yemtr?=
 =?utf-8?B?QUh4S0ZZOVBubFZlZGFhREhTZGxoWGR3NXYvVlMvejh0RDZMaFpsZEtlM0Yr?=
 =?utf-8?B?aWJ6L3d5QjV0amk5ODg2ckIvamhTd1MvOEhMN1ZEUDdEazZ3M2EyVzd4OUg4?=
 =?utf-8?B?YTlHdlhOcjhweksveWloQkR5VXVUSmxkeFYyV3gycysxdW4yVGcyWUhNOWl2?=
 =?utf-8?B?cnd4aTh5SThoUUJHVWQ5VnNjSG1jMFNTKzBjaFVCR2FFbDFiYU1BQy90WEVM?=
 =?utf-8?B?V2tJSERoTUZ1Wll0YXBsQVE5T0h2blVUWW1ReDBqellySWIxSTBvNVQwejdU?=
 =?utf-8?B?MXpnd24xbEFRMXJEZzNLNGZTT1BTN1FnS0lEMUJtaWZYaG9yYnFITmw4Tkcr?=
 =?utf-8?B?Q01Idm1SY25ocHk4Nnl5Z1kwcTU5enBIN0VnVVE5N1dSK3FVYWNZQVhab1h0?=
 =?utf-8?B?RnVNRDhWM0lJNzdVNkN3MVRUckxlV3ExamVHRi9uWU5Nai80MWo5bFYwek1C?=
 =?utf-8?B?MHNnUXpaTzIzbTBlcTFNSTlBdDBBbXFkZTI0YnFWT0ZKamZmY0loeXp1VWor?=
 =?utf-8?B?ZVI3aDE3Z1BmUjUyampEYWFwVVo4L3VYZ1dDeHVVRWFzMkFIWUxTdHllV2Fw?=
 =?utf-8?B?OUxmL2NLTDVCUDFkcmhRcEM3cGdldVEwTWJSeG1xU1lZdmY5dTExd096aEc2?=
 =?utf-8?B?WkVURENsT1I4S2lIT3N0MWl4ZVVPU28rVGNNL25jeG5pMWFUNGpuZjVxMm9k?=
 =?utf-8?B?alFibFZhd3pocDZQNGlJUVdlcW1WcmZIeEp1T2JIdWlwQ0hYZlFoY3dvdkRl?=
 =?utf-8?B?NjJ3S0ZxamF5Tk5Ra1VGY3FrbDVmV3pKcXFWZzNRZU9hcFJqOG52SzBiVjlo?=
 =?utf-8?Q?11W7jUXLphI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(1800799024)(366016)(376014)(7053199007)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QWVZelJEdkxjdXFuOEpiNHphK2JQc0JiR2c1bm5laGxXSkRsVnRnd1hTZjg4?=
 =?utf-8?B?d0pKNVM5ZWtXd1NPeVR0Um9ER25WRmFyZ2h5U3dzajZlci9RQ3haa3UzUmp4?=
 =?utf-8?B?eVMwS0g5TmhrVzgzUW45TytUcFE2UlRRVUs1SHlsQ3ArWlFRTXdWeEhFYmN6?=
 =?utf-8?B?NjNDQlFPK2pJYXluWTNnNytnL3JwTlp0NE9EQVhadFlUeEhheXR2MXZtMk9N?=
 =?utf-8?B?MHlNSVJUSzVLNmppVUJZV01lVGhTSHdUakRlRUJNZ0lTdFRLS3REVDhrRzdl?=
 =?utf-8?B?MDRHRjlWSXJBQUpDeHMzOUZaV2g2eTl2UWIyejB1T0MxallJZkIxTjN0LzFm?=
 =?utf-8?B?VCtudU9IMmpRV2FvV0NzMHk2TS84NGhEUVkwRml0QU02emRlTUVTTnRWRDJl?=
 =?utf-8?B?MjNXMlozSVYzRzRNT0hmZ01IbXhCNWJXcWd2QS9odjBuZ1lzekZRcmRsMXRQ?=
 =?utf-8?B?QjBDU0R4SG5JdmlqZEpEa0Y3VXIzM2tiL3A1QTdodFdLaUJVZ2c0ZjczQURw?=
 =?utf-8?B?WnhuRlcyMnFuWVhDL2pFUC9LekxCTmlyNndJalhvT2RxbUJZMVQ5ZWRHczNj?=
 =?utf-8?B?c1ZuVUUvU045cDVoRkdZL3V3Z0R6RG9YK3lQajBoQTd6TC9sd2k4ak9PdXV6?=
 =?utf-8?B?WmZHYVFLSC9aTWFrWDNmYitza3FtTk9VY0dDSng0V2dtOFlzaWhaV3JCYStW?=
 =?utf-8?B?dzFaM0lHM0lZVVozb2ovZldjYThSOXRwMGJodVNFeXlnTmJUa1hRbEJEeC9w?=
 =?utf-8?B?ZStiZHpmMWd5TUdhOXVuY1duSzB5RXNnMkN3SjRCTFdpNC9CeDBRM3dMeEhL?=
 =?utf-8?B?L0k3RDlPZEk2bzh5R2ZsYXk1TEpUdVFvUzRjaGZ3VXFXazB5eFlURnFJeGND?=
 =?utf-8?B?eDc1OUt0RWpUbmFLNGFkM3dEaG5hcHBtVXVIUXd3TFVkcWJhaW9YN0lsRVUz?=
 =?utf-8?B?UTkrQWM5OXl4NTRKVXV5d09FOWE3VUwva0dVbUJ3QTVMQnI3NWpiN1RUSGdr?=
 =?utf-8?B?S1JVZGgybnlKWng1Zmw5RWV4cERWamg5K3lGb1FpcDQvMkxvYVJQRWwwaDZ6?=
 =?utf-8?B?MjFnN09ETEZITFAwWmQ4a0p1TTBtZzR0MlBpUDcyV1ZvajBFUU5vOTZ1aVAr?=
 =?utf-8?B?WStEb295Q044Mlc0NVU0UW5TUXNqelNMVkNwWjNZVGJHNEx2NlV5TjNydU5r?=
 =?utf-8?B?a0M3YzR1UzNjMmhDN2lXYWgzNmtQMFRwbVUxSVE0bk5BOEZYc0dXaGMyRUxY?=
 =?utf-8?B?Y05pa0NteDhTQ0UrREIrWXozR1hTZDlwQzlUTFJ5K2tBazNVYTdXc00yU1k5?=
 =?utf-8?B?aGFjNWZJckJKakJzSnMzTmQ4MjdOaHhZTHlIYWl1dHZTUFdnMmgzWVZTT01u?=
 =?utf-8?B?VHkwbmVHVk5NOTNCbHl0NUxrcFN2Y3RBTFYvZCtGK0VIUXVzRk1KY2FldGp6?=
 =?utf-8?B?bFZ6alVuKzNlSzZFM0dTcmdyaW1SbkM2YmlNYnFzcTRaODcvSHhnK08ydG5Y?=
 =?utf-8?B?Z3hzUHQ3NGd1OUx4Tm5vQ0d0em4vYTJVUUREaTJMYUtJNEFjQ0c2dldGa3Fz?=
 =?utf-8?B?TUZuT0dPczhjRDkvZ0VhRERWT3gzYjZxV0F6NExxbjdCOUlaMlpJdzlSc2cv?=
 =?utf-8?B?djEwM3M1QnRTSHlnWFEzRk5nVGlNaTU4MllkZDRjUjhxNDdKVlBEQVM3bTBB?=
 =?utf-8?B?NXZJSTQzV2dHZWd6TzRFNExLMG9WaE5MN2o4SnV6UXZFbWtXNWFkQitnV1NI?=
 =?utf-8?B?SFpGNG0ycFdrVURMM2ZWMVNuRk5wenZ3S2ZUQ093TkoxNGl4NXVNSUl6d1Fw?=
 =?utf-8?B?dVJyVEhWSTdvdlMydm9NZldhRVoyOW4yT2txNVQ0UEl6aldxN1NxMGJXOEJJ?=
 =?utf-8?B?aWJxS2ppTEpXOW9QUnFYR0sraEs2a2xzUmFHSFlQRENoRWJJRTJ2NXBtbmRE?=
 =?utf-8?B?Y1VTRWlZK3AvUk4yUzZhbEJKNzUwamtHQ2hsQjJHd2FIV29scXlLV0hZR3Rr?=
 =?utf-8?B?RWZHU2RTQVc1T1BVOENJUzlFcVFycEpHd3Nsd20zSWU1aWdtaUpBdFY1bEtR?=
 =?utf-8?B?aFZTbXJWcCtvOUZpbi82a0txMk8zV2VINjlMMys4YWw4OFJlejIyOWhxRE5Q?=
 =?utf-8?B?YU1nMVphMjlzTVNzeUVLRlM0NG5GaHhXYXpLdWRTL2tLZFFjZlNRMzZMckdq?=
 =?utf-8?Q?ADiH8mkqMHLxF4ScAX/nsII=3D?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 87d647a3-5c7e-443d-0c42-08dd35522b38
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 10:48:38.6775 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U6Z8OTbZD6KmHA8pZ73NOxuUojuCj/gnX2xLl+JbXBxaxP0HSR4N1uVxXrG9bjTAoEEXsLZS4beqYM6uBlroo2hzeRBcb++KN3fh0+DWO8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10442
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

Hi Vasily,

On 1/14/25 6:24 AM, Vasily Khoruzhick wrote:
> While RK3328 is capable of 4K resolution, dw-hdmi driver in u-boot
> seems to have some issue with 4K. 1440p or lower works fine.
> 
> Limit max resolution by 2560x1440x60Hz, by filtering the modes with
> pixel clock > 297MHz
> 
> Fixes: f3ea872970d603 ("video: rockchip: Add rk3328 hdmi support")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>   drivers/video/rockchip/rk3328_hdmi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/video/rockchip/rk3328_hdmi.c b/drivers/video/rockchip/rk3328_hdmi.c
> index 763669c09be..d02c58c44c5 100644
> --- a/drivers/video/rockchip/rk3328_hdmi.c
> +++ b/drivers/video/rockchip/rk3328_hdmi.c
> @@ -105,9 +105,16 @@ static int rk3328_hdmi_probe(struct udevice *dev)
>   	return 0;
>   }
>   
> +static bool rk3328_hdmi_mode_valid(struct udevice *dev,
> +				   const struct display_timing *timing)
> +{
> +	return timing->pixelclock.typ <= 297000000;
> +}
> +

This seems like a hack to me and I would feel better with it being 
documented as such in the code. Can you simply add a comment there 
stating that this is a work-around for resolutions above 4K that should 
be working (that's what I gathered from the commit log, does it work in 
Linux?) but aren't right now. Maybe also add the formula in the comment?

I also wonder what would happen if we have 120+Hz displays at lower 
resolutions, they would be filtered out as well. Is that an issue? /me 
shrugs.

I don't own an RK3328 device though, so...

Cheers,
Quentin
