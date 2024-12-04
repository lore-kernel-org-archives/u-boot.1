Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C6DE77170
	for <u-boot@archiver.kernel.org>; Wed,  4 Dec 2024 16:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8152C89421;
	Wed,  4 Dec 2024 17:18:30 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=iopsys.eu header.i=@iopsys.eu header.b="p0gPwzuZ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D1895895FD; Wed,  4 Dec 2024 17:18:29 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on20716.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:2613::716])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D3B88917D
 for <u-boot@lists.denx.de>; Wed,  4 Dec 2024 17:18:27 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=iopsys.eu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=mikhail.kshevetskiy@genexis.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BS00JMnrvQ7m9bTZvvP0F0Sm8d3wN+IKPlPWE9EMKA0lqWLrDypiXnl7tbwXoYgs56SCVj1fWHZZ3oJHKI+9nynZneoem6acc5MVXoLeuXB1At3cMuWqEewJEiJRyd8jNNKT+ksXS82PHMACvK//IqiHDLK4HdDu37x+9Nff/fEFEEfLwm2gr3BJkub0zvNWkIPC4FdnM/6BMuF1f18YsJTE2sjsUxE9tpk3qacM+u0MtcqD6+R2wmIwCq4gPJrpfuacl0+5VcxvQRJMKffQdkLvBxb4T6g/tpNhVpN37wTgptUP/fq8pZpxKbTPC1+alwuTaG/7gaZPZBCx5YwajA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8JyEzZmBiDuTYzkNnEZqqben11GYx6O5ZxlEnDBswU=;
 b=kxL+/agtKvmi8kHnDtzK/iesp8VUOOjhzXXoHYw/TqK1LyzzMQ0IQZJzwmnEVXXgBlZKD1CrFlG0/1tbSZ8kwHo4KTTSyCNOMCohGYhmbyspeSrpU0HoKYd+GyqFel4+yRCwouc6M5ov2iUutiXBli7EO6bHMkcDFOcqjgIfdzIEjtgG96S1txhTWwSlVWAvUM7aED3pixHAjfFLX5d4vbeBVGIAD/69K6PE+enVRAaAlBTC0AS74UzE833OH0XscIIQWp9ZTKsmTvmDpT85I7dpO/YWXxtfky6PAeUDj1i3nZu+lYywqLO1QnCwgcdBboTVvmfbohTc3R0nCH+pyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=genexis.eu; dmarc=pass action=none header.from=iopsys.eu;
 dkim=pass header.d=iopsys.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iopsys.eu; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H8JyEzZmBiDuTYzkNnEZqqben11GYx6O5ZxlEnDBswU=;
 b=p0gPwzuZXyrnpJTKY5yXtUdsD+d/el+TT6l3NM3rKu6HcdKdZiAT9xMCvmjnRYkR4fwHJjxa3Xh1ZQntj41t9MKVYrxN5NEvR33jves/i43SHkiywTs7AbuXNkgDtoZjUBUjUS8FsHNw4A3RmyplelZ0bHuPRlmT50/WR7+v3UWU3gvQO/qiEVV5CXJYOhd+M/JmzuL+nudTvYVdNX5vm20KtCbAq4WDXulqLAzrO9ez36/6YRqfCGZg95PYyYz/ziEPKQnAO3alyD0TvTSe8t0kPgAfc+RZYq4sHrSBchTYPEwYzpfrkcitYcYUa5g+lDzNnjxRAggnQYDI22kqvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iopsys.eu;
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com (2603:10a6:150:7d::22)
 by DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.10; Wed, 4 Dec
 2024 16:18:24 +0000
Received: from GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0]) by GV2PR08MB8121.eurprd08.prod.outlook.com
 ([fe80::4cd3:da80:2532:daa0%3]) with mapi id 15.20.8230.010; Wed, 4 Dec 2024
 16:18:24 +0000
Message-ID: <4e5687a2-8a86-45b4-a1c2-c160d1319c0f@iopsys.eu>
Date: Wed, 4 Dec 2024 19:18:21 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: tftpboot: clear timeout_count on every successful
 block
To: Simon Glass <sjg@chromium.org>
Cc: Joe Hershberger <joe.hershberger@ni.com>,
 Ramon Fried <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
References: <20241203232732.2680178-1-mikhail.kshevetskiy@iopsys.eu>
 <CAFLszTj8SfbNs3Qn+cdC98JjoDE0St8HuRaXLF8+MxFCC07TXA@mail.gmail.com>
From: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
Content-Language: en-US, ru-RU
In-Reply-To: <CAFLszTj8SfbNs3Qn+cdC98JjoDE0St8HuRaXLF8+MxFCC07TXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV3P280CA0062.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:a::18) To GV2PR08MB8121.eurprd08.prod.outlook.com
 (2603:10a6:150:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR08MB8121:EE_|DU0PR08MB9155:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f2710fa-c47a-402c-bfcf-08dd147f46be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eTBkY00xdVVRd1pOL0kxRE52Yk1pWkpOMVJ2b0RVSW44TjBGYmh6eW8yYVor?=
 =?utf-8?B?UkowWm9Jc0EzT0dDaXRKbnEyWmtCY2pLaFdOcFRDQ1dkNWtoYzhTYXpNb3lN?=
 =?utf-8?B?SUgwMnBBVDVoTDJ5MXY3Vk9YN1dETjk3d1pvWmpxTlhsTWlVblJvS21hUnI5?=
 =?utf-8?B?aDZGRStIRC9mUWFhbFhQdkMvSU5ROVVEeDJHTllMa2N4ajMza1RRRHJTdmRs?=
 =?utf-8?B?QXdsUGRqQ1MyZmRaWEpQbjhQT0wxOU5RR3U2SlJNcGR6MTBPVXpQODh3a0w4?=
 =?utf-8?B?VkZ0Ujc0T0lhUWhRd0JMVzB3QWFkRytxSFdHOStablZ0SVNOM0U3VWdRdmlH?=
 =?utf-8?B?aU5BZWxmZXJ5VUNxUVcyWnN5OVpGaUZRb1crZCthTnF1enBySmFsN3pnNnoz?=
 =?utf-8?B?aWJydzk5Q0c1Ri8zQmltL2lQZzd3cjN6bXVTcFpiTlRBcDZhaWFqVytmczRP?=
 =?utf-8?B?NEpJay8vYThtMngzaExjTHNIOCs2Vnh3UmRjYStJamROdG5pcDFkSml5R29G?=
 =?utf-8?B?VW9oZ0cxa1BSanFiaWlPem00TStSNDcxMnhFY212SnFQamtkU0RnMnBUMGM1?=
 =?utf-8?B?cXYwNEhmWGI0Ykd0RGVad0poM01FK2xxTklvMUtvNXZ0YncvdTFYd1NUVFRz?=
 =?utf-8?B?cldBc1laVHNac2xvaEl1Z3AvOGRaVzFrSDZVU1JUWUJPMkh3MUlIbCs1bTFP?=
 =?utf-8?B?d3V3OENocktvdU5ZemdheHFOZUVQS09DOUM5SmtCN1QyTjJVVFNOL3k4bzky?=
 =?utf-8?B?OS93NFlIZnBhWTgvQTZhQXA2NVZWTW5Ya2xnb2kwRnQ0S2lxWXYyVSswMVZV?=
 =?utf-8?B?bmlVaVA5Wmw3aGl0NUtjYXVjSHBGdlRtZzMzY251Q2lvN3pHSkh4d2dFK2Ni?=
 =?utf-8?B?Lys5Wm8vc0FFN0NIdk9zK001MHNaMTJsVjh3dVQ3N1Mxb3IySWVhc3VZaCtV?=
 =?utf-8?B?RzlDUkxjWVJZei8wcDI4alJDd0ZNaDVGeFIyQ004TUQ4S0wzY25Ra3U4clVP?=
 =?utf-8?B?aXM1R0loT21aOEZSYWQrZEIzcHExRHRuZndHSS9PWisrSHVOeTJyTVU2cTFh?=
 =?utf-8?B?eVFhcDlvL0UzdzJhOTB3dkJQOVBDa0pxMTJXQk9MWll2ZVRIcjR1bVdwR21n?=
 =?utf-8?B?S0tHNkc5NUFSbTEvUzJyc2tCNUNVMW5uUDdvclZpNVNYNVdqSUVNYWMxQWU0?=
 =?utf-8?B?SjJYQVVvbWdjQlNhbVY4bkduOWpyUHYxTXhpUlYxTi9IZjhJOG5YTVljZ2Z2?=
 =?utf-8?B?dVJkU3BvbThLaEJ1bFQvQmJyL3FrdE45bDdxZjNWREI5Vy9NdDdYUEJBMWs4?=
 =?utf-8?B?b3FvSWRKOFR3MHE4S09LREhBRjhsRFFRc2ZGcWV1RmttY0d5UEY1MDRoUno4?=
 =?utf-8?B?U3dQMU5wUkRtZmptVEsxR3JxaVFURWVad2J4U0VvV3BIRDQ4YStDczJ4cm9y?=
 =?utf-8?B?OHBxR2RlZUtDRU9uQUhOUE53UFV2MTRxK3dxMmYzeGFXUlhxdWxMWlNsaG4x?=
 =?utf-8?B?TVhFWlFKczJPQmt2elRtVlBqbW1KeXBnZWM5cUNnenNnTkFxN2MzT1R4SDQ4?=
 =?utf-8?B?T3puOWNBeC9RUEkvVGFhSnRZSWw1eUxneEwyWit2Q2xrSDcxbkhWNGtzY2Zr?=
 =?utf-8?B?dmhEWUhCTEl5VXZDUWRtNDNZSlhVb1NwQVN3TlQxdjdXS3EvSXBNRWZaZHdl?=
 =?utf-8?B?d2NNSEhybW01UERmYlUrYkpkQ1U0cldnK0RQZjRZbXg5UjZwdlcxMUdnQ0E1?=
 =?utf-8?B?dHNWa2U3T1VxSzZrYVFaTVdwVFpEN2phZ3psU1pPM2hqb3h3UGZiM2dPUlg0?=
 =?utf-8?B?c2JGUUF2U1RJQzNOMlZmdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:GV2PR08MB8121.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014); DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c2YvMU1RZ0taUVMvT0pSdDNkdlJnMTFRZ20yamI1UlZJaVhWdWloMHJPaXlG?=
 =?utf-8?B?by9FVVFSSjhXeXVkeDA0Vy9mRnE1ZDBDUm92Z3RFOGp1OGlFVzJQdDdlODRz?=
 =?utf-8?B?ZGxUM2RBMVBPQStLbTV2NjhBR3ZBYVl6ZnZjcEVVZmxoeCt6Q1VYZklja3hF?=
 =?utf-8?B?UUZpV1Rsb0VLNjBMMGZ4UmlnMzJGSXh1cGNYZmp6Zm05QUVDMXl0TVlScjVG?=
 =?utf-8?B?cDVKZWJVZ3hnbGYzMFFvYWNkbFA5R2s5Rk1TMGdVN0MvUnRZMllzZG0ydGN0?=
 =?utf-8?B?YkErMldBd3dRQ0Y4NzdnL2I1MWg2WTF1dmdraDJacHljbzlGeGxDS1UzT0Jl?=
 =?utf-8?B?dkFtN0hONGpadmNHMk1XTW9GTjlPdGYrbk16VnVaV1lORDEzSU9WMEFYVHRw?=
 =?utf-8?B?V1crK3ZzWm9jM3VNZDF5dlJpWkQ3emxqenZudXZnL2Y5VjVLY0FhQmp6NHc1?=
 =?utf-8?B?SFQwWlRwYlkzTU82ZVVPemc4ay9zSGJuQnhma2Z1dGllSkxnTXpNcGdVeUk0?=
 =?utf-8?B?VTBoVzY5eGxsSGZhRGZ3czlMekdnMFlMZy9OZVF6emptczllbStHUE1lbGI2?=
 =?utf-8?B?bkpiZ0lCeU1kdkJYYThPWUF0aE5OQ0sxLzFIdUNvSE11ZlQxS0YyM0tWQTEz?=
 =?utf-8?B?L3lFUnJFYUFHSUZ5a0NRU2VaUjQ4bXFkNUlsM0F0emZBWVJDWVpuOVAwTW1F?=
 =?utf-8?B?NEVjdFJOL0VYL3VHZDBPZnNCbytzeXdhaHdCSFF0R0F5OVgwOEdGZWVGSW0w?=
 =?utf-8?B?REZOWFl2bDZ0TmpmRWdHcHE2M0E3VUt0blJpNXpTck9iT3RWL295SnRncnd5?=
 =?utf-8?B?dXpNR1hqZ3V2YW0wVjltVytmWWZjUHhRSitMOUhzaFNyU2NMZVUwVzREZzZ4?=
 =?utf-8?B?bHpxUGZ1Z1pEcmhwUVpkaDI5Nk1HUjFCbXFxdnBiT0pEakdkWFI4YTBjMTB0?=
 =?utf-8?B?VVdYM2Z6RERzV1JHblM0eVN4RE1WWW5yWTRVUmxuRHUzamFiWk9VSExXZ0hD?=
 =?utf-8?B?Y05HT3plN2QrcWFBcnRYVThPQ1N2VFdkNTRFTjV2TXFsKytGNTVLQitXdVVs?=
 =?utf-8?B?YUtOTmZFaERIa0NwZ1VrQURsRFdTWEtOOWIveENaWU1EYlo2RHUrUmM3V002?=
 =?utf-8?B?VDQzdVhnOXBHZytyK05lUFFRTmJWa3JCbzRRd29lWG9TczljVU82cGkyMWVF?=
 =?utf-8?B?K3ArUEgrdjlVQkgwZFpSZ1A4aTErMU9JWXdNZjhkWjZETGJ6NW9aNUY0YnJ1?=
 =?utf-8?B?bldwYVBxc1BOZm1MTW5pTnd3U1RJcEE2dEhJVVdFQUZ6bklCNFdKRk5QL2U5?=
 =?utf-8?B?NGt5cUxYcjRFZEM5SEI3RW9MeldNRXo1dWNvYytnNU1xRk81bE02RExGY2VF?=
 =?utf-8?B?VWNDcFc1NUFwUjllNTRWcW9Xc3VVZWRNOGx2MkFjekNGSnhXc0RkbitsbTEv?=
 =?utf-8?B?STJYdFdyVWVWY0lkcjM1OGhCYURmTnBET0ZsN0NqMk5yaXJLelhTaVRuZnRo?=
 =?utf-8?B?eFZxbUFBOWREY0JCZDJBT1Z5VEhlVlpTWlBoRy9GdkJUVWVkclhrYy9QZnRK?=
 =?utf-8?B?N3Z5NHBKS0t1bU43dFFwdkdueVc1ZTczdjVKMFFlMWdaRnpmU3VOTlo5a3pI?=
 =?utf-8?B?NGk5cjYzRDNjclVlL1VtZzlDYTZuNzlBNmsySHVMSnRRZ3VIYkFob1hxd0Fa?=
 =?utf-8?B?aEk5MHdxdlFJNmFCZDRjbWx5UWUyWUdvSzhsMmRsZFY3M1JsQy80UUlVYkFK?=
 =?utf-8?B?RFYrM2ZFcmErQ2pDRnl5aXZFS1ljWTNMUVNPaklYY2JGS0w3U1lXS2dyVXk0?=
 =?utf-8?B?c20rQ3dHT2VlWlNBYks2V1h3aytjQ3B4d3k0R1BuaURUYmtsWjZCLzFtRUpE?=
 =?utf-8?B?ZWE2VVVFYzFYZDdnSmU5ekUrS3lQcUgwOVFWbmJ1TFAxSFU2OG00Y0xzTWl0?=
 =?utf-8?B?VDhGQzlraFZ5YWJQbkg5V2tZK1RKUGtxMXZnd0dwYStrNUpxdDlGaHFVaW1G?=
 =?utf-8?B?YWFCajFnYmxVOUozL1k1ZXpZREJuR2JSRGVGMldoc1JaQ1JrSjltRGI0b0hK?=
 =?utf-8?B?dkVxUytEUCtUczVFcXlKZGRRSUpyditCb2xZQWV0THdGb2JZMVgrMGJEVE5O?=
 =?utf-8?B?WjRkOEQrQjV6R3RqdndZQUtmRklSQ3BxTXRGNDR1bWNLYXFhTlljVnJpVUl3?=
 =?utf-8?Q?cs5ci1ovw/6a6Zyc9GB26e8=3D?=
X-OriginatorOrg: iopsys.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f2710fa-c47a-402c-bfcf-08dd147f46be
X-MS-Exchange-CrossTenant-AuthSource: GV2PR08MB8121.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:18:24.2193 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8d891be1-7bce-4216-9a99-bee9de02ba58
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1pwJ0kGf+hMywYYXLd7+7P+MF7k77kzYskInIzRe/rvpln6C9Ngkj/qiJIGK4ZG9Tpn/TwDsOcVyJ9ZqeSpMYOMjG2sRBJNuB8+gE2qF+f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB9155
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


On 04.12.2024 18:13, Simon Glass wrote:
> Hi Mikhail,
>
> On Tue, 3 Dec 2024 at 16:27, Mikhail Kshevetskiy
> <mikhail.kshevetskiy@iopsys.eu> wrote:
>> timeout_count is never reset once a tftpboot transfer has started. If for
>> whatever reason timeouts occur frequently, but the server keeps replying
>> nonetheless, the transfer may be needlessly aborted.
>>
>> Reset timer_count on every successful block to avoid this situation.
>>
>> Signed-off-by: Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>
>> ---
>>  net/tftp.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
> What is the impact of this change?

If less than timeout_count_max issues appeared between arriving of two
data blocks -- the transfer will be continued. This greatly increase
chances to successfully download file if a lot of transfer timeout happens.

From the other side the transfer may becomes very slow (if timeouts will be
after each packet).

This may looks unrealistic, but we have a number of devices with Airoha chips
(mips, mipsel, arm, aarch64) that sometimes acts like stated above (a timeout
arises very often, but some packets flows normally). It's a rare issue, but
sometimes happens :-( We don't know a reason yet.


>> diff --git a/net/tftp.c b/net/tftp.c
>> index 704b20b4ff8..8f948204a6f 100644
>> --- a/net/tftp.c
>> +++ b/net/tftp.c
>> @@ -498,6 +498,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>>                                                 tftp_state = STATE_DATA;
>>                                                 tftp_remote_port = src;
>>                                         }
>> +                                       timeout_count = 0;
>>                                         tftp_send(); /* Send next data block */
>>                                 }
>>                         }
>> @@ -657,6 +658,7 @@ static void tftp_handler(uchar *pkt, unsigned dest, struct in_addr sip,
>>                         net_set_state(NETLOOP_FAIL);
>>                         break;
>>                 }
>> +               timeout_count = 0;
>>
>>                 if (len < tftp_block_size) {
>>                         tftp_send();
>> --
>> 2.45.2
>>
> Regards,
> Simon
