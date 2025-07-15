Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B29A4C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 09:30:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D651882F14;
	Tue, 15 Jul 2025 11:30:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="m4QXNgIR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6E76E82F8F; Tue, 15 Jul 2025 11:30:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8051E82BF6
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 11:29:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T5LaQY5UYk0DDjFuvYO3VeKhi6ygXgMq+4e0kbP2zoajwSKbCxQQG3GZmdusLN8bDs7A4hyCFAMzOYJMu8loidt8zYiHflP1TUDfdCVgmVbatgZaiosY+dF31+4TChcAFInnJGCbubzaz416X2U38a4eIY1TluF+LPy5raGuLY12pXZsjpcY83iUYSJjFFFTJr9g8tSk+1X6YQM9D5+ygALqd18/6ZccuA3nhEe/5FJMovhoiF4rg1TL3IpcWdclWt8yVsyW5h5BK/luX20RaQ8SljR6FXDFPMLSBZR+z9ssYu6vJ0tLqLFCymLkTWTBcCboNUrieQHPd4ezrMmWgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Hx9i22fzGmf2/lAi4PeJZG/GrtfP/bD7HFK5n8Zl9U=;
 b=ci4b7RwzFdwk6xtsYtoexT5nBlXMPGKJOHv8ZolTleFhfM/9VkEB+qFf0y92Wvnp11ts5i3WDZpyEwIjKP+4v6GwClzve4uXkvYDZKtNJDtbqWEDAZGfN1+XhltCJDXAXnPI+xziFO2ZmqDoiouQq3mt68Bib1V8+kY/RlTKxst2Lcd++hpw8FdKJ9+Sy8qolp/YbbOfi1jJjVnN+0uJt6ZOonizvAMlnpSxOX5GNn+gZaJsDvFUuTVCiNXAg+1dyryq6RcSM4hU47TXRfTQ3a60RYNUdzW+G7TpEcUHg4aGEyV0N7ZXZZCS7CGP8T0sFLWGE4r2xvcxoCx9rdCqTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Hx9i22fzGmf2/lAi4PeJZG/GrtfP/bD7HFK5n8Zl9U=;
 b=m4QXNgIRLJJKK2faN03e63RiCuBo3gt8ogwUDqzxSFy9q0L1ghuX+GUqI6lGX+BX1PeC700UAAjGAIdFA9PWX9SeqdCzu8smmP7a3ZGwEoY+8j12SAYIrDbXFPjb7VD+G8B7nj1lMXTo9EDG27WKgvYo74hLg7vsAehylkaOsHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by GV2PR04MB11326.eurprd04.prod.outlook.com (2603:10a6:150:2a0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 09:29:55 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 09:29:54 +0000
Message-ID: <10ed3c6e-65fc-4964-997f-64862f7500a3@cherry.de>
Date: Tue, 15 Jul 2025 11:29:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] clk: px30: Allow use of GPU and WIFI_PMU in
 assigned-clocks
To: Jonas Karlman <jonas@kwiboo.se>, Kever Yang <kever.yang@rock-chips.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>, Simon Glass <sjg@chromium.org>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Tom Rini <trini@konsulko.com>,
 Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>
Cc: u-boot@lists.denx.de
References: <20250713233429.1376172-1-jonas@kwiboo.se>
 <20250713233429.1376172-2-jonas@kwiboo.se>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250713233429.1376172-2-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0052.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::41) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|GV2PR04MB11326:EE_
X-MS-Office365-Filtering-Correlation-Id: e97a13b0-f575-48ca-f6df-08ddc3822842
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TlNTUUljUytZYzFXREhpRTREM0hCQ25wZ1RkM2tRMUs1Qmh1V1FseXZyaFJS?=
 =?utf-8?B?L1ZZRkM3UkZMK2UxVFR0UVh0eW5tS0l6WG9RMVMzTWRPTnUxUXgwajVrblE0?=
 =?utf-8?B?UFpvU2h6T0xnbWlPTlVpaVh0ZWo0STJuUWhXc0RZbWdSZ3ZsQ1IwdWc1djI2?=
 =?utf-8?B?czhXY3ZUZERMM0VJK2xBc2N6YXhNQ2VOT1VoSHFRcUxOTi9hVVFKZDNINkpW?=
 =?utf-8?B?eEVVRWFKQVpzWXNUdC8wMldiQjdMVVd3N3FaVldEY214RXEyd0cxaytzdld5?=
 =?utf-8?B?cHBlbFl6c280Yk5OVEw2WEdrWCtOZkRBUit6M2xhV1ZwM3dHMFp2MmVSazc5?=
 =?utf-8?B?a3daWXVLRExjRE0xUzYzbFdjK1kra2RLY3RldTVvaC93UU9uYWFseHh1SnMx?=
 =?utf-8?B?bitMUFllTmZnSUhHL2NVUGprL24rdUpYU3RJK2pSSnhBRndWeFV4RndreWFJ?=
 =?utf-8?B?Q205SkRBeGxZQmFNcWlvTzNGNHRTZlgzTGUrajI5WG1ZTjYzUXZLQ2hGUVR4?=
 =?utf-8?B?QUpBckkwaDRBOUdKZW9PYkJrdkVzWitvQy8rNSt6U2MxRU1jbjFTUWpPWFAw?=
 =?utf-8?B?dGNFWUxtMmFlaHhtOWFqcWJVWTkzNjE1M2lJU2xwbXRsa3pLZXdHS0FhSi94?=
 =?utf-8?B?ZFVDM3U1WDlGVVV6bWdkMTNHb1hKNzBYbkUyM25zRXNqdFpMeUJwTVpIcEFr?=
 =?utf-8?B?Q1dkSkMxV1NDVWhQMFY2K2ZHYjZxeXB5YWJKL2FkbjhZQm96Nmkxb3psVXNT?=
 =?utf-8?B?OVp0KzFHWkhoZWowZTdRMU1hQlNGbnQwRWk3SVNKTzBWbFFzOFAxVVRmQWg5?=
 =?utf-8?B?ajBtUjllTWlieEhKMjUxRGJtL2pneXJtMzQxQnJqTWdHS0ozVFVWRUhTbHpj?=
 =?utf-8?B?aFFSYm5IYi9NNE1JLzZQaE9pNG9HYUFRUmxIcER1OG9Lb0ZMaGlyRVg3MWxz?=
 =?utf-8?B?SHUwUEZzcGp0VWVmR3RxSWc5YmNCeG4zM21HMU9ETkdqY0dtUHlHQmo3VXl0?=
 =?utf-8?B?NEJVV2NYdWtSVkxaNEREZ0tmZm1HUWRXdERhbm5vZUJXZW92eGVkcTc1SHBS?=
 =?utf-8?B?Qnhuc05RWnVVMER6T1VjOEtmd05zYk5md0lPT1U5MGhmNXZ4U21ocDhmdExX?=
 =?utf-8?B?WUh2cWdJdGJFdUF2Wmg0dmIvRGxrelNQSHFDZWtXOCtoZ294TFpqaVMwR3BJ?=
 =?utf-8?B?elUxTlRBRjJJNkRZZjgwdlVEMUJUNVN4bGhhSFA4cmUzbmE0cGNpSURwcWFp?=
 =?utf-8?B?SzV3M1VZU2ZpTmluVkRRbDRMajZKT244UmhIWWVHd2RuOU83Q1F1SXU0ODNL?=
 =?utf-8?B?L08zcmNHWklwbUcxckREOE44QVhkZHpQL0luMWtiTGtySHROeURUSDVlc2dm?=
 =?utf-8?B?SHVZYm10WVdpQXVPYzgrR1o4RTlvRFlxNEUwMG9nd25YTmtob28wbGt4emor?=
 =?utf-8?B?MlNINFNFQWRLSnhHYVU3MTNFWDFIVFZMVElrZEdvYkJmUlRWWWRvd1FQQVdK?=
 =?utf-8?B?TnpjUk9OVWt3VHVQL3MvdDIzVmtFT0M5ODR3Q3AzNGtvZzY0VFB0bTZIZkhY?=
 =?utf-8?B?TzZrdndacWNRMHkyakdzRFJIWTQ2d3FFdVUxcDgyTkFrcW93b3hTbGRDbE4r?=
 =?utf-8?B?WXJTWDIwZlhJaVZveitnMTdqLzhjNlhRZmtRR1JaOVJ2alhRUjFLU3VyUlNB?=
 =?utf-8?B?eGsyREtHRjJmUHlNd1FlNm90OFdBWCs4dkJFS0tMV2RwbGJFcGpaQWhaU1RF?=
 =?utf-8?B?UVNCNjJNMFEwMUJMUEJHcE9qLzd0TzhUQloxS09VOWZQZ003NVhRN2JGSkpF?=
 =?utf-8?B?SGFmWDk5OWZReHpWR3pWRXNzRFo4Ky82V0t2NGEraWhlVnZlWXdsSEdWb1c5?=
 =?utf-8?B?Qkh1cVk5Z0FiR0lIaVEycmxBN0gxR05OampMNjFBOGxlczk4NlgyaUJYK0Jl?=
 =?utf-8?Q?2mf/Qb/Ks+U=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WWU0dDVOYW9zazgvd3dMaGJCMm9nVzdTdjZrYlk5eXFaUWhrcWtYVzdpclBu?=
 =?utf-8?B?WUk4anJIOU93SWliYTROcU9wSEdrQXgvQ3ZUc3RYOVc3L0lUUkwyQjlwTmFD?=
 =?utf-8?B?V2YwTXo5aFJEc2dKRzlxTmh6TjBnSUgwSVh5bU5zSUNPK3JhUUtIcnZlNmRo?=
 =?utf-8?B?WEZQZkNVeXRmNjZzQU5VV2R4MW9sWWs0S0R5cmF5M0REZUoyZ202NlhrUnV2?=
 =?utf-8?B?bmNCblFxSldIQ1RTa0ZTZmdXa3Nua09qaExCMDI3ODhXWDdWYThyWGNiUFQw?=
 =?utf-8?B?WUU2RjVrdUdWWG5vMDNYZEZrbzVYdW9KSFhGbVR1NGRlcklvWXcyc21DUjI3?=
 =?utf-8?B?cCtmK2s0MkZrUk53ZDNacWZLZ05rRVZ2TG8wdUp2SUVwVkUrRWx2YkYvN1hl?=
 =?utf-8?B?enhIQmk2UHg1Y0dhLzRYTEkxR21GOEQwWHZoMW9pcmhRc1M5Y1JCcHprdHNn?=
 =?utf-8?B?MVNWUG1uaDVvaFNsSnpKVFJaWFgvUG93TWxpL1pKWUFxZFJhK1VqaHN3R1o0?=
 =?utf-8?B?Q1FHUk9JSFdvMGhERHdaSVB0ckorNFNORHlqZm55b2tqT3E0REpOS0MvM25z?=
 =?utf-8?B?OEt0dFdBWEFnRnc4TjZpa1FkSXJPT1BVeXlqZEZ5QXlOZUwxV21jUC9vRmUz?=
 =?utf-8?B?OTM0bjBJekhLeXFMMm0zSnJha212QjZmb3dMZTlOMEhsSHlkSkVsME1yZDg0?=
 =?utf-8?B?eWlZUXd1ejFRcThjVnp2UmM1SVdPc0xlNkJJb2NEQ3dWKzBYdVhISmdHeTJ0?=
 =?utf-8?B?a2JvWFEvanMvQWNzWjc2MHpTWUI2M2RxcDgxd0k0ek9nQURXRXlMYkltRDBM?=
 =?utf-8?B?bngxQWJuOWVQWHFnRWJ1MVZtYW1UUzZvQXBWYk80bW1hM2ljdUZXVFhPV0Fa?=
 =?utf-8?B?MWJZa0g1LzRaZzBtUTRxZ00rK1BwbkxrazZUVU5xbFMrL0lUOG4va1Z0MUNW?=
 =?utf-8?B?R25KaktxOUdidUNpaEYxZGttcXlTeTdSTDlONTVEcEROYkhwMmZIb3paVHFN?=
 =?utf-8?B?Z1dQcFhqdEgvYzdPczMzRHd0WFp1NjVDSmdUQjN6a1JqNXl6bDBxMjRWbHdt?=
 =?utf-8?B?L0dkcTFUYWw2YmRsR05SZjVYaFovMURGbjhnWCszWFFhd0QvMjY0Qmk1eXYx?=
 =?utf-8?B?QnUwa3ljRzE5bVNyS205VEIvSU9iVFU0c0Z6eDFuN00xMHJLekpBSjRaQlNr?=
 =?utf-8?B?eVBHVUNITVY0amNaOExVSzdtc0tIdnRCR29RcERKQURobC9kSTVrTWlFYWlq?=
 =?utf-8?B?SjRCNFYyNEdKM0R3MThyQmNqdW9Zb3BxR2srZUJqZFlpVGI2WWdCYU1zeDl2?=
 =?utf-8?B?Tk9VUGtWME00VVkydm11K1UrSDc4UHRkMEZtS2dvZUVDdS9zSlg0emcxREhr?=
 =?utf-8?B?ZkVuM3hIVUpnKy9qR3FZemNpK0V6a3FYd1FCcmRxeVJYM1lJQW1PaEFTN2Y2?=
 =?utf-8?B?eEhvSzl4K21KQlhWMWdLSDBzZTJoRHJzZi9la2VxdGMzUFZuQWNxZElaT2xs?=
 =?utf-8?B?aU95VjZ2K3Q4cEExc2xpNXdVOEhmRXd6Wk01T0JVZzVubDQyRzF4OHQrajJ5?=
 =?utf-8?B?QXBySlROc0tXWDNzN0FmZFYzK2FrS3lWaC93WUlRcnMvM0FmU2dYMmlyaWV4?=
 =?utf-8?B?Qkp1dk5Wc1ducXdCWXVBSVlCK2c1TUFwa1BKcGtOM3VoTU5hUmVuaDRCMEYv?=
 =?utf-8?B?YmFkVFM4U3dIRTRiUVp6bjdVc2g4cnBycFRJUUV1TUx0V01PM1pheEdONVRV?=
 =?utf-8?B?NXd4ZzFiRTJQdFJhWHVlWVhwUmp0b3MzWFBpZk51R1pGbzBMQW9tZGo4T291?=
 =?utf-8?B?MVZ6SXJjUFp5eFZEWnhpa09ZdFp4SjV3dTNBOUpGckFrbW9ETlROc29Zb011?=
 =?utf-8?B?T0dIMUthWTdJdXhwcFJKelQvY21ZVlR0NEo4NXB6QU92OTk5NitBenZJZ2lG?=
 =?utf-8?B?RTNHVnh5MHNiMFpmeXNZRk9zenkvd0hVRlJnUUIyTDB2UDhMSlo5V0R2N3BV?=
 =?utf-8?B?L3VnM29MQTNWM1hKVDVSSkRUQ1NpaVFFSzRtTlFxSjdnQUVlaE50eWh4aFNZ?=
 =?utf-8?B?ajN1OWtkQlMyWWFKQnhGVFA5R0hnQ010ZStXemJyM3JpYWhmbjJocVV4WURP?=
 =?utf-8?B?NEF4TUdselM0ME1IVWZEU3IvSkdVQkQyTWxMOWxCTW8zSHgvMWE4bHN0bnJk?=
 =?utf-8?B?SHc9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: e97a13b0-f575-48ca-f6df-08ddc3822842
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:29:54.6444 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znWaboB6qcBt6An+pCd+f/ornIskN6ir8d/D6mLNF4i96qGmsDU9luUy6D9ZRwvFfjOdPuMFkgL18ohVNH06a4qmBXM0hhzf4ZJMeUggnS4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11326
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

Hi Jonas,

On 7/14/25 1:33 AM, Jonas Karlman wrote:
> Add dummy implementation of set_rate for SCLK_GPU and SCLK_WIFI_PMU to
> allow use of dts/upstream assigned-clocks in cru and pmucru nodes.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>   drivers/clk/rockchip/clk_px30.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/rockchip/clk_px30.c b/drivers/clk/rockchip/clk_px30.c
> index ad7e1c0f2460..b5054e84c326 100644
> --- a/drivers/clk/rockchip/clk_px30.c
> +++ b/drivers/clk/rockchip/clk_px30.c
> @@ -1360,6 +1360,9 @@ static ulong px30_clk_set_rate(struct clk *clk, ulong rate)
>   	case SCLK_GMAC_RMII:
>   		ret = px30_mac_set_speed_clk(priv, rate);
>   		break;
> +	/* Might occur in cru assigned-clocks, can be ignored here */
> +	case SCLK_GPU:
> +		break;

Seems to only be used for the GPU and the power domain of the GPU. I 
don't think we're planning on making use of the GPU in U-Boot until a 
long time so this is fine.

>   #endif
>   	default:
>   		return -ENOENT;
> @@ -1726,6 +1729,9 @@ static ulong px30_pmuclk_set_rate(struct clk *clk, ulong rate)
>   	case SCLK_UART0_PMU:
>   		ret = px30_pmu_uart0_set_clk(priv, rate);
>   		break;
> +	/* Might occur in pmucru assigned-clocks, can be ignored here */
> +	case SCLK_WIFI_PMU:
> +		break;

Seems like the only use-case for this clock is generating a clock output 
on gpio0_a0 which requires a pinmux different from the default GPIO 
function. I don't see any DT (px30 or rk3326) making use of that pin 
that way, so looks good to me too, therefore:

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
