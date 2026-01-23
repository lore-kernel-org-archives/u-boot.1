Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92A78D6CFA7
	for <u-boot@archiver.kernel.org>; Fri, 23 Jan 2026 12:44:41 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E4BCF83B21;
	Fri, 23 Jan 2026 13:44:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=cherry.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=cherry.de header.i=@cherry.de header.b="c2wpItB9";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1462C83B21; Fri, 23 Jan 2026 13:44:39 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazlp170130007.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c202::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F31DA83B0B
 for <u-boot@lists.denx.de>; Fri, 23 Jan 2026 13:44:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=cherry.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=quentin.schulz@cherry.de
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iYfZ3bQZ2tuzNiGjnxNADkkVVQDKo6eOM+uJ+9hKhX7Pyx6FESn5kF0zGAsT1yZYx/wXzem3diLCTy+BmLYLkFZk1Dp2MxlpExPgxqi+YvEoiuLlAqQEi1EZBWX/mgn2UV8GOOQ4k/eeI6tXF+hs3H3eN/F0EIpJsA5g95Ke1J3iQy17ym7M7Hyy0fQoA7foA9Ny2L+gKCXmcqYfGb0aoHTPy62e3m6579V9GaOVf51N+ArccIymel6AoPq2NKMttzn2racYqQty3IjirK056jrk4WDs/nQDJu9KZDN07SI5efR7m3EtTJHXoZ0YiI1E+sfS/BIztYz+EtNTddsnQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rHj6nKb6xlF5TPQLBzUnh8SIx1ED7UN9ZgdvQyz0I7o=;
 b=oRg5+iqOgZWob2ouilxB9FCObnzTxv9mzDQmFbukbmm3eIisNRVyO/OtcPqNr1CA/CUMCjXzY6HRQdRqcDQ5ReI0NUKtIZaQ03cs0JxpKwz3VV//h6CSB5U0ScSCV9Xqwf71bX767N90R9L9wxSaxja43I/ydHix85bIbSX+VRF7aYnbHjjs/vh34w96kd7eYv48Jv11cv4ecNTeYKQdqJK5knlTgTD512+rPojLUyW204GHsGOgwLKKTKtNUYpob6uM0YChWLC22jvIhZPzAYJTEAJ9UagdFNk8lfkaddSxF9B/fBbmWxPnFalAKPImdFH/JBQ9pqZumJXDMmOPbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cherry.de; dmarc=pass action=none header.from=cherry.de;
 dkim=pass header.d=cherry.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cherry.de; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rHj6nKb6xlF5TPQLBzUnh8SIx1ED7UN9ZgdvQyz0I7o=;
 b=c2wpItB9yxmB9QWLm9Iz5sAbWqnhaLOqTdFo1U5PEL6nag/5CvBcB36dPak9Jf3khvQGaPXG5RY7gtuS/cxRLh/tv0QIGyi0iqTzWBw1xM3iBq5XFmRLVdHiE1sfyVURddBe0+qReylhbQO6jJ1PfD3Uzn5/R1irpUqlgeYxkIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cherry.de;
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com (2603:10a6:150:2be::5)
 by GVXPR04MB11654.eurprd04.prod.outlook.com (2603:10a6:150:2c3::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 12:44:33 +0000
Received: from GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78]) by GVXPR04MB12038.eurprd04.prod.outlook.com
 ([fe80::6c04:8947:f2f0:5e78%6]) with mapi id 15.20.9542.008; Fri, 23 Jan 2026
 12:44:33 +0000
Message-ID: <d6045995-f172-4d7b-aec4-ecc7f530ef80@cherry.de>
Date: Fri, 23 Jan 2026 13:44:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] doc: cmd: add documentation for sm3sum
To: Heiko Schocher <hs@nabladev.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>
References: <20260123022552.100884-1-hs@nabladev.com>
 <20260123022552.100884-3-hs@nabladev.com>
Content-Language: en-US
From: Quentin Schulz <quentin.schulz@cherry.de>
In-Reply-To: <20260123022552.100884-3-hs@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0108.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34c::8) To GVXPR04MB12038.eurprd04.prod.outlook.com
 (2603:10a6:150:2be::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GVXPR04MB12038:EE_|GVXPR04MB11654:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c03e5bd-8742-4c5c-24ac-08de5a7d2888
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|7053199007; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aUpVNloyaTlhbVZaR0l4R082ZlhSclRDREY1dnJnQytHYkZ3Wit5dVhRNmFV?=
 =?utf-8?B?c0RUMktldEN5NXZrTmR3VjVvOHlyNUZ3d0tkWm51bjdBZ2w4VEtsUko2N1BN?=
 =?utf-8?B?V05EeUxQZzAzUWlJK0psSEtQVG8xQXh6UnByNXNGM3k0d0tXWW41TEY5cjM2?=
 =?utf-8?B?ZWVwTkxmaHNPN3VaajRlaUZKUXo1MTMxUjR4bm0xTlBtYklsRFc5OUpqRmtn?=
 =?utf-8?B?QmNNdjR5Y0QxTjc0dWwzK1FGdHAzVWFqMzlHYjVaR1FVbHdEVHdjRCtFRXc2?=
 =?utf-8?B?emhhN2VyOXZzdHNZaXh4d0hZdk90bFpVd21QZE05YkFoQ2FmVEVPYkZZRmhI?=
 =?utf-8?B?a0M0Y3NvQzY1ekxDRW43QUxqQU5XYmNGakx0K2UvSHVmbVUvTUdTbHFZNFJl?=
 =?utf-8?B?QWY3dHlOQ1BVS2NnKzNxNGwrd1FNTXBmdUxvWmhKTkhBWk1YLzhFOWM3K3A2?=
 =?utf-8?B?K1FIbVk5ZjBVam9ScERuMVozcXdwOUlyN1R5RVpNeXcxaStRMFNGZ3lBUW54?=
 =?utf-8?B?N0VydVRHMTV0SXZKeHRLVlVrNnQyZCs5RUxHMGFYaWpZK3E0VWFNM1JmQkd4?=
 =?utf-8?B?RURyaWVTaG42SUZxNEcvbWRMRHk1Vi85NkVqdGpVbHYzZEdDTGJVZlRkakJn?=
 =?utf-8?B?MGU3NzNSb1NWeFlpdUcxK3BDSlpSRzFYL3psbFcvNWtzSFhwcGVVY1pNRzJp?=
 =?utf-8?B?a1E1MU0wZUdGRGZGZTlvT2x3akdsalRRc3RFZ1A0NUY3aVZzZ2NLRmtFNDRF?=
 =?utf-8?B?UWlQblpWV3dzVDBDaTllUGkwbXlVNURYOERDYTl2RWMvNFRyRnVFM2t3ZDdq?=
 =?utf-8?B?TjN1RlNKZU1tOWpDa2pNNDBBTE93YUM3OG1rWE5NOWF4SzJuYVJzK3I3V2lT?=
 =?utf-8?B?SGhUb0lNT1JQd2tSb2N6amNZelJVQXlzTHV4WmcyckF4TndaYStBYXhBYlE3?=
 =?utf-8?B?YXgzZXJvejlJa3BKZ0FvWjk1MEhZTWpnSXRSQ1lpRkVrRFJkT0M0UDhYT3pn?=
 =?utf-8?B?Y3Mrc1NyRWJZQTdXR2JlUVBubSs0dk52Mk1PRTV0YW9MakIyekNhQXUwdVlv?=
 =?utf-8?B?eUJGeXpCOWo5TUlPc3JEV2g0QjBnMUhWaUxvT3Uxd0hWVmpkbnJwTjMveEVo?=
 =?utf-8?B?WTdyUE5QUlJpWVVtblpMV1dDZ29DL3NsYURCYkMyQkdVb1Ayd0J0cWExL0lR?=
 =?utf-8?B?MGp0SXFtMDlrWWJTZ05lZ28yaTA1c1pZM0tKTWl3MjBXQW5jVktJYWJUMFRy?=
 =?utf-8?B?RnJHZTRBNVBobXlKQS9ZVUZuV0FwbHlZTDlmRmJHcXFhLzFBd1VHRWUvWFFm?=
 =?utf-8?B?dzFaL2NlWVFzZVg1My9xbkxDTnZUdUNZMUlZODEwU3hkRTR1T3pHR2pBN2w0?=
 =?utf-8?B?TE5mZXIzT2pZdnVrQlhsUVAzSUc0b2pqbCtxaEZLUXNOMGc4ZGdkRzJjclFv?=
 =?utf-8?B?Q05Xbm5tZmoyVjB0bjJHSTM1MTgwZnZQZWhkS210aVpNdDNIZnZiVGxHakZH?=
 =?utf-8?B?aGx4SHQrZWVIVzBKNGNhYjhzL24vbmlDdFdsTzg1YXExRWl5YjVxWTZtc0Vi?=
 =?utf-8?B?bDd2cjI3VFV6WGtMd2l4K05JeTVJVmwvZ29BUVF0NmVQd2hVcnpZM250L2VI?=
 =?utf-8?B?elhEdStIM3VMd296OThsaXd3RGpOaVdLV1I3WThsM1FHWTczSmFpOUFIYnUz?=
 =?utf-8?B?RytVTENNUDVDcjhCcHJvMks1WVROcUQwZ2JvUWpLWWpsVkpQYS83Y2FZU3do?=
 =?utf-8?B?LzZJUHkzQlhhM05HRzgrUVEwU1BheS92MjhrZG9qcVlMSFByRTg1VVB4TEE4?=
 =?utf-8?B?S21DTGhZbElYUHd1QlZkZWE1K2l1N1R0VTJoclVUYXF4NzFtN2hOZVZCc0dn?=
 =?utf-8?B?ejNndGNMc2ptMVdOb0dpbTJ6eGxSYWN2NzlXa2dqQVJ2Vkcxa2NRU2VKMGNB?=
 =?utf-8?B?ajM3MVFFTll0MEhLZ1FMekRjdHQ0cDFaNnUwYm9sUlo1OWxNMGQ0NXVpRU5W?=
 =?utf-8?B?WS9WMGRCTEZGWG9uMHhpVEpvUzNJYUJPR0ZEZVlIRFRjN3dSYlM1QzU5bHBh?=
 =?utf-8?B?aEptd1hNSVo4ODVkRjE3OXBnUmVqMW1UT3huaUNCdHNRVzdXVXNOMS8xVGJk?=
 =?utf-8?Q?z4X4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GVXPR04MB12038.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(7053199007); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cTdVbWlUaTJHRGRCNWwxUG9NQlYybGNNVmtrOEtJMUVxWXd2Q3IyVzI1MnVu?=
 =?utf-8?B?d0tRVVRLTjkzVHNETVdDOFRjRnRCRkdBa0kzMzF6RW9ucENMaytpMmI5WFFR?=
 =?utf-8?B?WWl5a001UUtuSFlHaHNFblhYM2FJTXBYN3lzNEoxMVEzSG05ZjdzSkpkTEU5?=
 =?utf-8?B?Y0hubUVzYjJQMTJjZ1lBTEJmcnFBL0NKeWl2Zjkwejlucm9qVVhJUEc4MFRh?=
 =?utf-8?B?WXJWbUtpR0gzblJVWC9JYUwxREZ3ODVNdGlWMFo1WDhYdkp5M0dtN0Z4NHlB?=
 =?utf-8?B?N09RSkdUMDRscnUzajNMY0NoSFlPUmJJRm1NQlZkR0pkMjVrMVExNmduL3VI?=
 =?utf-8?B?cEUvNW9XUzNBMGs0emIvcldSVnFPa3J1eDM2N1ZlaVQ2cG9xZ0tManI2NWJM?=
 =?utf-8?B?ZmFyMVo4Yzl2Z3Z5c0ErbzlHZkdweUdaRmcwYVQ5M0pxcm5nVWgva1RERGNH?=
 =?utf-8?B?VEY2SHY1ZmtVa3dtS0lhZk1GNm1VcFhGcHJQaW5ENmxtSUZNUFVhWGtKNDQv?=
 =?utf-8?B?bTgrYmNUQU5OUGtRT0FHckdtRWh0NUMyTlZ4Zi9xdDFwSmlGdGRqMDJvM2lH?=
 =?utf-8?B?NStGSEZzZExFeUNYOTVEbTEzSHVLcXFqdU1zcW0wd29YTXExdDE5VlMrbS9K?=
 =?utf-8?B?S0c4QVBZeUdTamZXc1N3ZVQzbkJ3OGFyZ01qUDBnOEZIVHozdHpiWUIwdTNY?=
 =?utf-8?B?TEt2THhDaVNiMkVhdmk1T0NZakhaaVJuQ21ydFdITlloK3REOHpOcTRxYTM4?=
 =?utf-8?B?QXNPMU5mcjl4OE80Nzh2N1pMclBQU09OemMvUlJKZm9oRTVhRDM4Z0VBREZS?=
 =?utf-8?B?T2t0UHEwOFhBMzEveHN1MExveGdocjNmbkkveFQvM3R4aCsrZnNMQXVab3pE?=
 =?utf-8?B?ZUhwL3hMd0pLbkFZQW5ORzJkRDB1Wm1ObWFWeVoxMytSWkNhV2hhSkNmejI1?=
 =?utf-8?B?TXpZZU44bzBqbkZIVHI0TGJOMG1NdWpHamFPT2JIL1VUYk9qVVhDYTFLaFVS?=
 =?utf-8?B?aE5rQm1LNmhFVVgwRWNiTFcvc3RwdW5YdS9LMFM1T1RmSkVyaFNHdUJ5MVli?=
 =?utf-8?B?UTJ3SjdPYkxXVFkzVDczMTFaWkpnN2x2cThlbVdaS2xCVHY1bzNIU1BEbzlD?=
 =?utf-8?B?b05PZkg4aUgwdFoyMnUyWHFlNU9Cc0l0Z2tOVGg3VnY1SE56NW1CUVcvS1FY?=
 =?utf-8?B?Zi9tRTVCRmNOU2ozdTlBVVIrYW5VczlXVUtCc3dYdFUycTAyNTdxMFpGTnly?=
 =?utf-8?B?QnVvVlJncnh0NzBxWDBPVDcya3A4Zlc0VW1wV2JpZkc4SkdscUNqWC8yQzZj?=
 =?utf-8?B?ekNoUWRHZ0pLeUFtVnMxdDVWYUI5dGRmYmxlSHRCaXZpNGhHbnJvYy9QNGVl?=
 =?utf-8?B?bHpLNEQ2NkJXYXJiZUt6dEdlK0pHaExMcllFS2txc09PV1NxTHp4bmQ0eHE0?=
 =?utf-8?B?T0JBNko4Z0l2U3EzOWx4Nm94ak0wanV2TVhPTFM0V2tLbU9sMUVubldnRmhy?=
 =?utf-8?B?clNRK0ZLMmpHOHlNZmZOZXN2SEhWVW9UZE5NNmdsSURiblZBM3hseWIvWlZM?=
 =?utf-8?B?T0h1TDhiaWMrZDJtZDRqYXdLN1pNZ0h4T3huZDVRdkM2dFoyVjBkVHRwUW1Z?=
 =?utf-8?B?UTBZN1h0d1VIMWNCMDdPeWZ1R1l0OGtXNGd6MnhRV0tOZVNPTm9IMFU3VHdB?=
 =?utf-8?B?cExLaXpyMWhJVWVjaHhrOEwvVUZQSDlJd2hNMHlrOTZyeGErN2FpTEo0VEJs?=
 =?utf-8?B?eHFCVzhXTzRoOU02ckR2bHBLMURNdC9XNENOWTlZbjZCRlNtK0l4eHI3dVR2?=
 =?utf-8?B?bTNMYkh0byt4aHFDNHU5b2U1VHNLL05qZlVkMXFxTVNONVBXcVFGbHpSMTI0?=
 =?utf-8?B?WUgxVTJPZVNGMkRGblFwdXQ3TGwxN3EwcHNNRnAyMnV3Sk04Y2tGRGlubHM1?=
 =?utf-8?B?L2dQcEwyRG1xR3M3dmVwWGE4Y2MxTk4zdGIzQVhiYkxmQlFJV1RNckhUWHNH?=
 =?utf-8?B?VjJRZXFhakwwMXE0SjNvMTdZeDZnSi9TWHBOQnVmSmRYcmpmQU50K3JySFhS?=
 =?utf-8?B?UjFHNmE4ekh2clRpMkRMMmlMR0kwYkVNd3A2bjgyU0xCRUdyZkZuc2Y1OUUx?=
 =?utf-8?B?ZDBFTytHZ3hmR085cjFjRTEwN0xnbGsvSUVuTmxtek9GMDVjMTBDRVZ1enh6?=
 =?utf-8?B?MlY2NDBzZE1halhPbE9KOXZDUnhCbW5qYjNNT3FZT2N6Q0EzZHZhbXE3ZFJL?=
 =?utf-8?B?dlhjUCtkcjZpWjBWMFRNV210ZzBRNGZleDdjVW9jM3pHNFp0K3ZZQ2RMN05E?=
 =?utf-8?B?NmtlSWUzL0tBZFc4RmFMYUlCaU5OYURRUTBrNlk2RE9aL2szQS9EMFZUNXFV?=
 =?utf-8?Q?bARmE/CGRLalWq9vMYzVjcTdNmp5LbThB/iah?=
X-OriginatorOrg: cherry.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c03e5bd-8742-4c5c-24ac-08de5a7d2888
X-MS-Exchange-CrossTenant-AuthSource: GVXPR04MB12038.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 12:44:33.2723 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5e0e1b52-21b5-4e7b-83bb-514ec460677e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zPdbhxh2MRwcvfyBbtvPYWiFIb7AyPfHnbQQOHUJaogFQ4LTg21vbqRqCpzkFo7daCzC1fRHvq+dZfTUvxCA6gaXJnQ1n2V/E4rCyCjope0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11654
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

Hi Heiko,

On 1/23/26 3:25 AM, Heiko Schocher wrote:
> add documentation for sm3sum command.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> 

Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>

Thanks!
Quentin
