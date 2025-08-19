Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A74ABCA0EED
	for <u-boot@archiver.kernel.org>; Tue, 19 Aug 2025 09:28:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B106D80FA1;
	Tue, 19 Aug 2025 11:28:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="H611jhfD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3150981FEE; Tue, 19 Aug 2025 11:28:10 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c201::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 098B8802C1
 for <u-boot@lists.denx.de>; Tue, 19 Aug 2025 11:28:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gx0MSA7mpW4LYnNTgfOEaYW9OQiBJs9vv5ST2I1gnfWDAO4gpvAHTo0gxgaITB3VrKKN2vXji3MxOpqj8/uwh+ErnJiAhsQGDQlP8tWC7kP1ERMJW9A/B9BWRoDCeJyyTl5kNWDtpOAMNT/xcgmbrp5BBJJCT1Dy3tuOa7dcazmSB+Www0Q7QnSZ1nVCPGPth7TgfkN69s/I2mL5955Ce/g4QBg6QA47rsmsAJ5WiNJOfCZ3antsyUUgD9tYTzwYpjHIt7slyJHBQVxSQQEjvboty+/u1u65TuS7rt+5m5coQWvzNYS8DJtyVq7gp04NbqUsQxaqmfQDOWZIULpDcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W4cOZc5Mszj/g/+r7Ea86ZtbUSWwP93jnCZXUG+XGUc=;
 b=SUKRsewPc6H1Ti391Ov2zK/XnVT4CQXl61Al1r87ue7sXSRNo0Uxm3NZ5+JafiLQkjo+47vx5jEdoJcbQf4hrP925lhfU3P7nwuohYbxEigu4YCnqz+TfFI8SIq3DpweV9n9Em8N4/FZb+aQnqHDUMp14wlv33ZpO9rpxUxfko9gB20VthJrxz71T6W1h/KvYxGfy+Tn3bG0FNLr1PAnLt2d88HYEmu3KTKrgHLhLD+9Ah5/wQxDl6b6sE40IZmG6B/zz78I4wU2QySIgo3/HEI4ar0kf9UE7qvHuDJGSsItLsb9LHunVZNx/YJObxN4NO+DKWXAtvjcc0BHC72cTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W4cOZc5Mszj/g/+r7Ea86ZtbUSWwP93jnCZXUG+XGUc=;
 b=H611jhfD+6MaRHCFs3CEYkkISSoIjPl97G3Py3r4FJh5LGDgBtOOzN7x1FJWMO6/kOGgJqLeMYVHRIByHFGAx/YiQXqJw/QKbvxRhAvqW4f48IM4rm7mTz7qSKugRibTWm6Q3D3w33Wcubd6t2G4ld7WAVieRC9DnqDGMH8QDto=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by PA4PR04MB7792.eurprd04.prod.outlook.com (2603:10a6:102:c0::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Tue, 19 Aug
 2025 09:28:06 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.9052.011; Tue, 19 Aug 2025
 09:28:06 +0000
Message-ID: <102d53b5-be1f-474d-a0a0-ccb585dfb50d@cherry.de>
Date: Tue, 19 Aug 2025 11:28:04 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] arm: Fix swtiching typo
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Tom Rini <trini@konsulko.com>
Cc: Mattijs Korpershoek <mkorpershoek@kernel.org>, Janne Grunau
 <j@jannau.net>, Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
References: <20250818064715.20359-1-heinrich.schuchardt@canonical.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250818064715.20359-1-heinrich.schuchardt@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0039.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::10) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|PA4PR04MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 60775feb-4d67-4d4c-dd26-08dddf02b3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|10070799003|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NU1TTy9OblFtQ2luOVBwMExvRzRuWlpMUHluQ2o0ekJSK2pTWWFrRXpnZTZM?=
 =?utf-8?B?UFp5NkJRTGZHSGRiOW1hZzUzNzBKaHRFWVcrbE15UzB3WHBZUTVZSzl2dXFQ?=
 =?utf-8?B?M1ZRZUlleG1uVmFnVlE4U3lnWUcyY2ZXZm9QTEF2T25MQlp3akt0b05VeUkw?=
 =?utf-8?B?QlZaSk5BL2V4azh0QkUrNFo2N0daeXp2UkcyWU13RUJCcGVIUEN6S2pudEhj?=
 =?utf-8?B?ZHFqUHBUSTQ0ZjE3eldWSzNmR1N0OXB4b09MNHdvMTFoV2gzblRoME0vcG9D?=
 =?utf-8?B?Y3VjYlVNWmpYMkE2UENuaDBVS1k4NmpQMSsybVZEWi9rcjJ2bG9VK2dNeHox?=
 =?utf-8?B?aEUwd3oxQm40NEd6TWpncFdGNjN2NEtzU3kwcDRDUStzMFBjelcrNVY1b2Jk?=
 =?utf-8?B?bTBoMnc1a29pZkg5VEhGaTNqQ1NIRHU3V01LZ0xPbmVvSEhRRWJGWUJmZjJH?=
 =?utf-8?B?RCtrU3NzL2VBckRLNmdUUTQ4YVh4QWlzUWluQ1F6NGVWUnoxRWg2aklENlNV?=
 =?utf-8?B?VVRUNytJelNvdHM3OEM5akU1U2N0aU1zMjRPZ0k0MGFINklUZE1GL1BMQTR5?=
 =?utf-8?B?Rmh3SGlQa2RaL3BpQzAwN3JQa25EL0c5SzlFQTY2VWdQVTRJZ0pEWXNqQ2Jh?=
 =?utf-8?B?a0NqQzROOGIwRTJtdUJIYzdvTkJ2V3plbGR4MU0xNnM5dUhuaU5PZWpYWmFH?=
 =?utf-8?B?OVRFV1VNYWU3Qitna1d5UjR6elZuaG83MldjNVpRVUR5SVV6VDhQTFByQTMr?=
 =?utf-8?B?cmIyUjNDMVBKcXVWeWxIejkwdDVpb1BXR3NiU3BDL1JncG1HSVZGZC9MNlln?=
 =?utf-8?B?QnVBcm5iYnNYWHUzeTVTWjQwNm5XQ2UyU3kySTJzNVlOenkzR1BuRWVzTUhN?=
 =?utf-8?B?emU5d3Vra1ExcXNXUW1pMWRwTmFrVVk5SjdRM0F0d3pQZjhWVFB1aElFSW8x?=
 =?utf-8?B?WDB6elZ0K1p5ZnVFNVVTV1YzZTVQY09aSTVNZmxtQktJSXZQVk5sY0I1cUU1?=
 =?utf-8?B?dkVCaHRXK2Rpa2k2UkVpY2RURUFoVmRoc1BjSzRRUXBPMU8xa0taTzdYS2ZZ?=
 =?utf-8?B?cjcwZ0g2UTNiNitZejVSd2ZGYzFIcy9lMEY0KzBCVjVHQ05BMHVqdmRmVWFi?=
 =?utf-8?B?OUZkTWxPVy9KRXBOKzBHOE1UYXJqai9JQWpoM25FWTdTQnZRS3V0dWt3Mkwv?=
 =?utf-8?B?K3B0byttMVR1M0V0VkoxWTIxSHdDbHBaYkV0Um5ieGJsTTNyNjFCZElZc1or?=
 =?utf-8?B?SWpRTllHTlNTWkdONzNMSFhVaHg4Lzc3MmhZTHJjSXR2ZVZoU3UxS3ZUcktO?=
 =?utf-8?B?RlhOSDc0VWdqTjZtRzJUU0dWTVdZaWFNb1JRUGV2OU5EV3RuTUpUTUQyamlp?=
 =?utf-8?B?QUxCaVpENG5wcFF5dlR3OElOakd5N2FncmFtcUFWL3JOM1NnaFBIK0FIR0xo?=
 =?utf-8?B?d080azZUZFljKzhOK3o3eWJQVnprYVIwQjhZRmhuQndROEt6TWFrcnRET3N1?=
 =?utf-8?B?TkhjN0F6bXdHQU9CNlFOcGYzUVIvVDdxeWFiMHdzRVcwdGRkb3JrZkFEeG1i?=
 =?utf-8?B?bXAvb3A2L1ZsRk1XM0VieUJORXg5azIrL2d1aTZTeHNNTXpXaEo3TmNOUkhY?=
 =?utf-8?B?bS84Qm5sSmhzaUc5SURkd0ZOeXR6ZkRiRnp2SHFrOXNkajdVRHVVU1kxeXdS?=
 =?utf-8?B?akFFVmxrcWM1d0s0Zkh6R0ZZcytTQURuUHA4TS9WVWpSdmZlcXVON3VHVFpY?=
 =?utf-8?B?UElUMTl5Um1QOEI1ejRnWE1jNWdINURRL0VtUGEzRngrVlAvMDJUdVNlTFVx?=
 =?utf-8?Q?q3whHT+pvIFvljF+oECs/W0QW01CQ/15Rw0dE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(10070799003)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YlR2cW53ZFFERVBFcUQ2bEtPWE0zOVo1WlFxTHhsVDh4M2kxNzEwR2RRN1lj?=
 =?utf-8?B?NDhxNzNzQmo4eXM1c0ZueGlYUXMzYmtZVzFWQlpSdGMyZmpBdUJoYjFqemp5?=
 =?utf-8?B?Mno4TlE2ZmoyNm9vUUhrSUtqMXNYYStGN2lQdWc1VFlmQ3dndG9CK203RmJo?=
 =?utf-8?B?dHFJa2NqaTZOSjlNTStoTzUyb1U0dU1BZ0laOTlPSHk5Y0RpRXNMcWZNdC9w?=
 =?utf-8?B?S055TmUyU0VNRGtlQzUwU2pLMlRhUm5rL0grWTRDZVhlMDkxcVdHaTNwUXZZ?=
 =?utf-8?B?NjBBcGNGRjlMZ3V3RGRqMjJLQ0VuZ0h0ekl4bWpFUTNNS0ZDUDJTLzBiRVYy?=
 =?utf-8?B?Q21oNk56ZXFVcktGa3AxK0JwQ0ZmSmxtRGt2WVZybUl1cFNSaFoyUGU0aTJV?=
 =?utf-8?B?aEZuNXgxVDNKdXN2eEZXMkhCaXIxN0c0U3hwTEQzS1Fyd1V0ZlE2SkdValNL?=
 =?utf-8?B?dXA5WjQzMFBnZkUvUW9ZUm0wektZeHNDdEE4N3h2VzFXajlGYTYwOW1nOHRZ?=
 =?utf-8?B?K1lIZ0loZHN5dHhHMjVnOHp0djIyZDE2em0vOHJvYnY5UngxWGJWS1FYanlP?=
 =?utf-8?B?LzVHMkt2TUJsOFl3VkhuOSsxZldRbGg0STdZYkswZVN1QWxOd1NBbWtiaXBR?=
 =?utf-8?B?TXVUbDlha3E1b0lZK3FBNjVMVGlIeDJYakRCUUxOeS9QMzc5eFlmRHMwaHpz?=
 =?utf-8?B?M3ZtbDVYQmdkMHRCeENsa0Nlbkh3Rm9xYUZBcW91Y2pJQ2h2dmNvMTFNNU5w?=
 =?utf-8?B?ckhXanl3NEZMcWNtdmNnd0YxM2lHaUJMRmhvQjk5Y3RWcDJ2RENXUW5aV1h6?=
 =?utf-8?B?bGZNSGoyYXoyYitTYVBheFFHTk8xa05QUVRWekdNMjhSSDZmdGhFb3h3WFBV?=
 =?utf-8?B?SjB6WUM5TDFOZnJMS3ZQa1c3NERXVUZxU3pYQUJ1QTB5TUp1aVY4d0dlSk1C?=
 =?utf-8?B?c3VZMUJIUHc5Z0cvOUJibDZUUkNPTjU2VzRQMEZWZDcvSjVFWXN3UDYrZHln?=
 =?utf-8?B?QXNLNjNrV3RtOVRTSEpxckFvdzB0Q2hUT3dnZFFGSVZKYTkvaE0rQW43QTRy?=
 =?utf-8?B?YjBaUXlrOWNSODlKbjVxTHU5eEpYZlZkaUh4MEhBcFc0QVdGVEF0eUZ0R21D?=
 =?utf-8?B?eUR3cVhQMktIZ080UlRaY2w2NGw2NVNPT28yOW5uSlZWL2xpdFlGVkpCWXpM?=
 =?utf-8?B?K3J6YjA0QlB2bVI1TkdUWENBaURSSlVCcnY0WU9sT1FrQkZuT29QWGRtUmE2?=
 =?utf-8?B?U3B2bk9KRFE1S203VUdvcVoyVGdkR2lMTVhpMHVLNHBYM3BZcFg2aXByT05C?=
 =?utf-8?B?NFFYdkZGZDdKVVkxYk9aMGk2T0ZOOHpka1M5eWZXQ2wyUjF1Tnc1bTZVS28v?=
 =?utf-8?B?QytJTlJPQ1N4SCswV2xYMkUwUlhJMXliUVphTTYwUVErMlRpelZKZk84VWV4?=
 =?utf-8?B?ZXc5N0VualVEWlJneDBuVlk3clJ3eTlJNjJzaGhRVkNDcE01T0ZlZE84ZVpW?=
 =?utf-8?B?T2pDQWJmQjUxd3A1U0lRQkJLcmpZc2JoaG5YZFk2MjFGUThXajVUVmMvSEZG?=
 =?utf-8?B?RGxVbkg2bnVjY1g2aDFBd0lIL2UzOTFhbTRQSjEwUzdkRGRwdXp4REljV24z?=
 =?utf-8?B?aE9wbWYwTFlXWjNlUmJXb09BeXZrR2JjdDFwZUVIV0JRQUw3L2lRNlFhVlhT?=
 =?utf-8?B?aGl3bWNqZXZmMnhpcDRVZHluSFA1OEQ5UllsL2g5K002MEtieitmRWFuTDRU?=
 =?utf-8?B?K1hiSGlsQld4NHloT2w0NXU3MEg0VEd3SUU2SnJSMEcrbm55cGUxU2NaL1NM?=
 =?utf-8?B?aHBoMnJRRU5ESWhQd2JUa1pzQ0xGR3QvZ3g1UDVvalR0WmtOTG1xWVdJZjBB?=
 =?utf-8?B?OGp4dFVtdExSM1VNYmNkeWZQbVIrNnNaMENRR2R0SW0xNGhQZ2ZESWVVT3gv?=
 =?utf-8?B?LzZiYUgzZlkzWjhTNDNVWXNTQ2pJa2tob240WE1Ick5sc0swaHd4Mngrckd3?=
 =?utf-8?B?ZmVtMlhyVXMvamZqSEVuVURUcnZIUUg5ZzIyYzdjY2lFd1hHM1NpNG5mMnMr?=
 =?utf-8?B?QVlDVERIOXlkdnU0RVJvT1hCalg4U2Qrc3FEb0padGhhTzRIK0dFNEUvam90?=
 =?utf-8?B?am4xSGdVenVXTDdzTmdjU3VTOFhvckE4ZEFoVW52ajBXNnZuYVlQVXQ4Y2lK?=
 =?utf-8?B?VXpicjhOZWRnbDhIR3BHSXNiMVM4M29nZFhDUDUyVWtJUjJqa3U5TmNaSTRO?=
 =?utf-8?B?Q2ZmLzEwQ0RQQURjQXpmMTFnV29nPT0=?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 60775feb-4d67-4d4c-dd26-08dddf02b3ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2025 09:28:06.2905 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6tBURxvrQJ8502lmWwJmMtUUJyy3W4K6t57SAj0jwVvqvdyDQtQqkLmGEbM+OG4JDwzNtShfwaurKpbQn4EfT8Ax+R2dsdjv4lIDL7208o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7792
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

Hi Heinrich,

On 8/18/25 8:47 AM, Heinrich Schuchardt wrote:
> From: Simon Glass <sjg@chromium.org>
> 
> This should say 'switching', so fix it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>

Need your SoB too, I believe, c.f. 
https://docs.kernel.org/process/submitting-patches.html#developer-s-certificate-of-origin-1-1 
and 
https://docs.kernel.org/process/submitting-patches.html#when-to-use-acked-by-cc-and-co-developed-by

"""
The sign-off is a simple line at the end of the explanation for the 
patch, which certifies that you wrote it or otherwise have the right to 
pass it on as an open-source patch.
"""

"""
Notably, the last Signed-off-by: must always be that of the developer 
submitting the patch.
"""

With that change:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
