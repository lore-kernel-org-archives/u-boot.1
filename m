Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C15ABC83F1A
	for <u-boot@archiver.kernel.org>; Thu, 24 Jul 2025 09:07:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 398468368F;
	Thu, 24 Jul 2025 11:07:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="dpFn0AhY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D388836A9; Thu, 24 Jul 2025 11:06:59 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20a::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F366D83666
 for <u-boot@lists.denx.de>; Thu, 24 Jul 2025 11:06:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K749sgs4hB2cr7bG9ovlbt6W6Cl1UzhGzbkoR1CuuNWQKYdAwEhsBE3bQ054EGH0Hz6WJAQs9odnLa8R12rsMTuaHv7e6vdK/QLRghC4esQxjiPIj8J+/0jn+soxewykupJ3yyzeTant+qIafycAgkRNgzUhNKlkHjgWNIUm4ETEcklGqrqTuZQ2Dmya+r/CIRS2Cuxkp/ZsKBdAjFcADdDRvh8pKUdpDIPQdks6c3ZXaZdQzxgoAzy6lscv7i3ccLeAztfVVoL8rcZZi3UYVzhNG2a2DK/jd5OJE+evhp0KaotB7yvIgO+4n+Ej4Hzkzax7coBoFilZgVY81YQbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Uag1Y6SOR00Jrn0U8eA8u2mlivzw9vL7T/v818X238=;
 b=TrkUcBfiGmqgwauYEjEgCkZBUmFFT32TIjkkHKMWwxyeZCNbdX5xsRBMQXSl06LUyovRW6Hw5SLvLpU9wroDEYmVk+KmnrlxXs6IpziRSoPen44q9rp1iOyqB5vbgGBqw7weY2pLvvOi3WDpYFVVpW9N+kudoVfncxJ3D+mnV9AGypPyLNdnrbCKQ0wdUidCqBRbr0XKF2EfglDwf0jmNzPKQD46Tr3STzEZm5jF+dKioFdXlPf4rQy4fWlVWsJqGb48eKIt3wq7Sm2LdiQbGLFK1XRoe/K9OotwFbA+mQcIdbN+6h8ShdMFQkWabsQ/cE0SaYXTqpFU5FmutDJD+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Uag1Y6SOR00Jrn0U8eA8u2mlivzw9vL7T/v818X238=;
 b=dpFn0AhY3UIAVVMJfQJFHiKrZrElcVwwOdvWTlCeXDWWa4xr6qTiQDZKNfsgTQW4Gy6TJ4iqVOZSE7gJLuuxiuo8NN0Pi+8+DkR7JwhLyG0yd64M3zgshWLgwt1Pt0Wwq3kqQYGt0G/8GLTyWBlggdVk8+Txdb3S9X8P8NHBgXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20)
 by VI0PR04MB10163.eurprd04.prod.outlook.com (2603:10a6:800:245::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Thu, 24 Jul
 2025 09:06:54 +0000
Received: from AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1]) by AS8PR04MB8897.eurprd04.prod.outlook.com
 ([fe80::5ee:7297:93b4:a8d1%4]) with mapi id 15.20.8964.021; Thu, 24 Jul 2025
 09:06:53 +0000
Message-ID: <662486e1-7300-41b9-bd8a-8618552331e5@cherry.de>
Date: Thu, 24 Jul 2025 11:06:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] binman: bintool: run 'apt-get update -y' on first
 invocation of apt_install()
To: Jerome Forissier <jerome.forissier@linaro.org>,
 U-Boot mailing list <u-boot@lists.denx.de>
Cc: Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Leonard Anderweit <l.anderweit@phytec.de>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250724090247.59221-1-jerome.forissier@linaro.org>
 <20250724090247.59221-3-jerome.forissier@linaro.org>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20250724090247.59221-3-jerome.forissier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR07CA0291.eurprd07.prod.outlook.com
 (2603:10a6:800:130::19) To AS8PR04MB8897.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8897:EE_|VI0PR04MB10163:EE_
X-MS-Office365-Filtering-Correlation-Id: c5199ba9-45ff-420d-b1d1-08ddca916ee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?WWRJUG02VDFZZGdqT3pvSFZIdmwvd3NPRktwUkFZSk9nQjdIWk10QmIzTTM3?=
 =?utf-8?B?bEx4UHUzcm1Ndk5VcDFPOUZYKytXK09TT2w0Z1dmMnJnK0x4V1cwMmNvUXND?=
 =?utf-8?B?UWlSdVRTZWthdDVIaWVHWWl5eWtOUHFwOHpnOHgyNURQU1F3NFBZamdybFZi?=
 =?utf-8?B?VXlIZEtjMUlBNWxRZkJHQ2xPSEs0M2pMTFZXbzRwcWZIdlBmSzBEMVJxeGlD?=
 =?utf-8?B?bjVHYkgrb0RvY0hZUFp2Nmp2a1lxWkh1eWYrREp0QXd5ZjRHdFNvTjdpSHRB?=
 =?utf-8?B?dXZ4M05hL3EvZnBpc3kvNUpDWkxXaEVNN0E4ZWZqKzdlTG9KT05SNFo1V1pl?=
 =?utf-8?B?MmNJSUdFd1J6MUhwWUxjTG5sU1NabjY2SjE0MEZCTFFBRmQwUUNqR0h6blJr?=
 =?utf-8?B?MFZSTlpzcEdkMWlNYUQ0OXArRHJnOG5sbmVjU1d6QVNoamhPQ1NvQk44QW9T?=
 =?utf-8?B?dUdpcWkvNmtMblNhOU1CYkVvbzU2cS90dVRZc1R2T2NyUmJyZVFDVjhLekVG?=
 =?utf-8?B?NWIxMDdxbGZnU01aMk9FdU1Ea2kreDhaMW80eTEyN0haYzRXdE5oSlVGb3h0?=
 =?utf-8?B?SU9XdkloQkZQcmViZmhJdnA3Z2UwQjZ2clRKY25EZGk3aVpSVmZ6QjcvVlhL?=
 =?utf-8?B?eGdzV2FQYkFodGp5dDlsWG5NR2lNcGh5Nm92Qm01cUtpbW1jRFZFMWltQy84?=
 =?utf-8?B?b2lUZ29xR1dxMXZiRlkyb1ZHM1R3TVJwVTVRVTNUcDVTZzJhakFPN2FRTmE5?=
 =?utf-8?B?NWk2MXVKTk93TjZZM2syYlF1R05OdEt1alYxMHgzNmZyQmpXWnFBcTRHbWpo?=
 =?utf-8?B?YVdqSU5hdXU0N3h2U25xMGdtSUszUkdXdUFVV0U1U0NKL1cwOHlmUmsvd0ly?=
 =?utf-8?B?eXdLcUpydWJsUGgyV3Z4TEd1ZGNTSmoxMEJvZm5qM21ZTEhZdzJuNTVRMjQ3?=
 =?utf-8?B?ZjhYUWlUV25BTmRIWmNtamY3WmsrY0tXOEptT2Y3V09KSWs0TDhDNndVUDk0?=
 =?utf-8?B?TkZDVHRjakY2VHRweEVyS1JRYVEzTjNzeVlidjFRVGRSNXZFL2lySExJaEpQ?=
 =?utf-8?B?blN6VU1kSWJkckpMM2E4aGF0WnZDVERBNFRGMnJMSzJmL1pTcXZzdC9JVTM0?=
 =?utf-8?B?bW5kWlhXZG1LMklhTEJOKzJCaXUxQ2V1ZFdWYm5VUXgycHhxMG9uVnhiY0x2?=
 =?utf-8?B?WWZFMHhCYjEzSWRCOG9MS1J1VlZKbnFPdnAwdFJpckRQY3RPcHcxQS9jK3l2?=
 =?utf-8?B?NUF2cUlvUnVsN2QzVDFrNFJ5NWxXWk5JVG8yRmd4S3ZFS1Q1Rlp3bW54UTZa?=
 =?utf-8?B?blpWWXlLaWQ1SXNlL25aNkxtMllGTlFrMmNoZ2lEY2lkY0pIbjlYZGVWL3la?=
 =?utf-8?B?SS9qaVI0Vm1NeG5Yc3l3Y1UwbkZObFFjbk1SaTY3SE03UGUxd2lnMlNoc2VZ?=
 =?utf-8?B?OFBud2V6NzZUQ2FyZHV2UHoyWGIvSm9lU3BVbDlLSmMwOUZkb1N4aGEzaEhN?=
 =?utf-8?B?T01sTmk2NDJ2YTM2c2FaWkRJa1AwYzMzRG5IMDBxMHVGVE1yODQ1bnU2bjlt?=
 =?utf-8?B?RTRTbnVvRmM5OGxxMHQ0dU1hNUpnbjlTZ1NYMFk5RVJHZlNDMHFIaXd5eGhQ?=
 =?utf-8?B?bGw3VWsvMUdSWWpIbG1NNDROdm1CelNOZEJqYXFDdFlYZlNUQXplYWR4MHh3?=
 =?utf-8?B?YnNEVTJrTVAxU0FKVGx2dXhWa1o1ZVcrcnFEcmovdkdlWGY0TU1rZWNibEtl?=
 =?utf-8?B?UmxpcEY1a2pBUUxEK0dESEpCaVkyYkJVMG1SMCsvRnc0U20vbnlvbEI2SU1N?=
 =?utf-8?B?b0pSYlJRQmhYOExwQTlOVlB4SkxJVUhvUHovWEtRb25vU0JSYjNhUER2dW5L?=
 =?utf-8?B?NEJqRHBMakJub2Y5bUxQRU9tZVNLV01SaGlBVjF4QXd1UkFxTkphaVh6WUVH?=
 =?utf-8?Q?aXxXUiB7bco=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8897.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7053199007); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dU90SENKZWRkemQralEzVEZyeGdCNjRZWTFNMDQxaDVGRHJPUFhOODhCaVlI?=
 =?utf-8?B?R1hYVHd3RGxpK0NieEtuV3Q4UW1sK09iemkrSFdkVzRqZXQxdVJTUEF2WkpY?=
 =?utf-8?B?ZlA2REUzTENUd0FJZHFDZzIzdHVDanVzNWNFUlpKdWlQNHd6KzdkOUMxUEdV?=
 =?utf-8?B?RlRvMG93R2RjRXNNbVhHaWtuMTNRRElTM1NSSzBnTVdVcS9mc2Z1YXFPYUZB?=
 =?utf-8?B?QVJ6NE5CRVFYcGNKRlA0MzVZSTVhNEQweWM5TDN5U0poSUpieE1US3JOT203?=
 =?utf-8?B?Z0U5NjJwRGRYQlIyb0Y4VXZHdkF2ell3NE5yTXpzYUM0R1ZYaXYraUtmVVlP?=
 =?utf-8?B?Yi9wMWg3a1cwS0hxUENldkdVSjZ5elByODJwUXhPd2lZakp0dHlnU0QwcDJw?=
 =?utf-8?B?VWg0ankyWFVMR3BOb3owQWRKd0wyREVSZTQweEMxZTEzVzN1ME9xUHVsN2xE?=
 =?utf-8?B?RmU2SEhyUS8vb0xxeWExb3U3cDhkckFwV0JCbUc3ak9FL2orRGUvdWRlOWxD?=
 =?utf-8?B?L2tncjB2Z0pDNE5NRktoV05FWncvSGo2SERZbWRaSEVucmRjY0Zzem4zek8w?=
 =?utf-8?B?SzJmMkFKb0ZFUElsQ0EvaDU0dFRRemdDb3NjcklIRWxjZUJSeVBDeGVYSTlS?=
 =?utf-8?B?SGRseFBkTzVYZkJ2Zm9HSE5ueit5YWovcGdWQ3hwWEhkbVBvWlROVGI0WC9I?=
 =?utf-8?B?UUViMEYvM1gyTlpSVlR1eVJnRmM0N3NkRlRPc1FwRkl4eTV0d21LMjU2ZGhq?=
 =?utf-8?B?ZjJOejdoSU40VHF0ajk2UGRlLzFYWndSYlhiWmlwaEh1RXdKRlUvL2lQaG5y?=
 =?utf-8?B?SllPK2l2WVYyRHBtclhtVWlzU2NsR2lacktBNUVTR2JpOWViZy9Hc2pCYlBN?=
 =?utf-8?B?L0luNyswT3ZRN0JSNVFnakFWMmhydk51bFIwYVBNM2xhZEI3cUVpTndQeGFV?=
 =?utf-8?B?Um9GQkRWS0ZLMDB4cXg2aVRxdnpDWDdTTzh1L0MzY2VKUEl5NmtYMWFTQmtq?=
 =?utf-8?B?UFJiSm05Z3l0Q1Rqa0I0bXpocDM3TElaUzllbE4yelpxSzZhMUlyOHU2SUZh?=
 =?utf-8?B?RVpaWm9JRjUwV1BaY3FVdmQ0R2Zlc1hhUm5rblhtaGZsc2Q1THFoNGZmRVl6?=
 =?utf-8?B?cU16Z0lEU1JhWW93MjlyZlZlNXZsQWNFdWJwczdmN0VBWlR5U0FHbEhSMkVM?=
 =?utf-8?B?aUN4ektVdC8zV0lqMUdDbHZOL0xoYzVCazBZZFpxVjhqZ3pIVW5nSnFnRllF?=
 =?utf-8?B?ejRndWFTeXhQTnlZa2ZJK2tMek9SbTZ2K1doQjZXQ0xjd0ZPcHEvRi82OGxk?=
 =?utf-8?B?YVN0SVBwUWw5bmk1bm5oZXJqalA1SExxN1dUL3hRUWxnVk80azNSalBRTmdY?=
 =?utf-8?B?QlpTanZQMkZzZkE4UFcrZ29jRGhHTjFQMTI5c0JwRGhhU2FobnVTaFBnWkIv?=
 =?utf-8?B?MExxWjFOSUVTOVlTWXE4TWhlRlVhdmxnaWhOcVZKQzY5MVJhQjh5eS94c3Bq?=
 =?utf-8?B?Smw1cmhuYkI0UWhRYVJFdHhPMlBIWHNKMFlpdVdIdHpPOHBtZEFnM3FFb05x?=
 =?utf-8?B?TENqRTRpRDRFM1Urdjdsdmt6bno2MXFOY2pnVTJtWHl0aE1Ld1hIRCtvM28r?=
 =?utf-8?B?MW5xRXJyU0hRMUNpOG1nZkpXY0NWNVNocnhueG5QYnBiOEhBc3Fyc3RMK3VJ?=
 =?utf-8?B?ZFhlMGRDRDVSdEZzMy9wTGw2RDMyejQzdDIyR0NxQWZsOGtzcFhRQnhueGtO?=
 =?utf-8?B?ekV2cVlpdEI1dlFNWitSVFUxRmhUazdWZnZXd0tYWDhDTlJabGxpam1WcmUv?=
 =?utf-8?B?YlR0UXNPZm1lT1ZEMzdUQXRFYmFDWHdnR3hldVhBUGhsamQwUnFjWlZDckZ3?=
 =?utf-8?B?bndKeGRVbGdMVEJ0SmoydDhPb250RExXUmlPNjlqdjlKNnNEekFMMm9GREE5?=
 =?utf-8?B?VFJKTDhJdkdVVmR4ZkpHNVNhbEtjdjB1NGtYczkveFBwdThxVWZpRXAyUHJm?=
 =?utf-8?B?eGx2eGhtWjVpT0lWdVlzUVc5WmhnaVhZMU9ITXpmZk5xQTlSNURHSml6WTEv?=
 =?utf-8?B?SUFDa2hmUFJrcWNueGZaa1BHK21kOU43VG1NbFF5c3MxODVDbHNpbE9HbkFu?=
 =?utf-8?B?Q1hLbHFHbGhDVFFOYWhsZWdydzZrY0F5aHF6YkRNMG5VclVUNytvbTdId2ZS?=
 =?utf-8?B?c0E9PQ==?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c5199ba9-45ff-420d-b1d1-08ddca916ee2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8897.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:06:53.7489 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MUYSRx7h8PrBgZYYSeWon2AjNv+QdB/ziChih6GKo/VhRGOZ9YWAmzdObURHNC1+RdDJOPrLi7oI3IajWioREPjVMLl4rR8NZmK+0+bp6KI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10163
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

Hi Jerome,

On 7/24/25 11:02 AM, Jerome Forissier wrote:
> 'apt-get update -y' may be required to make sure that the list of
> packages is up-to-date and that the subsequent 'apt-get install'
> operations can find the requested packages.
> 
> Fixes the following CI error:
> 
>   Fetch: zstd
>   - trying method: binary download
>   - sudo apt-get install -y zstd
>   Exception: Error 100 running 'sudo apt-get install -y zstd': E: Unable to locate package zstd
> 
> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
> ---
> 
> Changes in v2:
> - Use apt-get instead of apt
> 
>   tools/binman/bintool.py | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/tools/binman/bintool.py b/tools/binman/bintool.py
> index f46bb52a7b3..141cc66657c 100644
> --- a/tools/binman/bintool.py
> +++ b/tools/binman/bintool.py
> @@ -55,6 +55,9 @@ class Bintool:
>       # must be called before this class is used.
>       tooldir = ''
>   
> +    # Flag to run 'apt update' once on first use of apt_install()
> +    apt_updated = False
> +
>       def __init__(self, name, desc, version_regex=None, version_args='-V'):
>           self.name = name
>           self.desc = desc
> @@ -421,6 +424,11 @@ class Bintool:
>           Returns:
>               True, assuming it completes without error
>           """
> +        if not cls.apt_updated:
> +            args = ['sudo', 'apt', 'update', '-y']

I think you forgot to do git add (or git commit --amend) before sending 
the v2 :)

Cheers,
Quentin
