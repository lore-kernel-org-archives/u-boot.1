Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B183C3ABBC
	for <u-boot@archiver.kernel.org>; Mon, 12 May 2025 05:48:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69CA3805D7;
	Mon, 12 May 2025 07:48:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=draeger.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=draeger.com header.i=@draeger.com header.b="HjYEWmaL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 12CC7808AF; Mon, 12 May 2025 07:39:36 +0200 (CEST)
Received: from FR6P281CU001.outbound.protection.outlook.com
 (mail-germanywestcentralazlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c20c::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E53CD800C1
 for <u-boot@lists.denx.de>; Mon, 12 May 2025 07:39:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=draeger.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Olaf.Baehring@draeger.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o3GFG0taDGWmbkN3k0G+x4MrI9pr2Jf93b5VKXK/8WeUK+vpWf69DLmAkk/IzNn5ow7cYCEhDAkw00yiVPcoBRg5MX27pVRTMuIqLev81jC2SyDn1w3wfTw752Ysk3hH+kpqehDmFvOWs5HNCZZFmdAZGPCCStsqvdbwdJMeGBOaVGZBS+XKXMjRIVqXKzgxEf3w1eCz/SxGAmR/FU853Zvz4YmGNEL0Mom2kx0YxflMDh2iPKJzZCfCdAsoN7YaB5DWdxXmZWgoF4AY1rJjfRR63VOp904gycaKAVbmjgaFgu5Xexl6iMc93wT8ZFK0Xlf/ZHlM8ro4QQ/Av0tRGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrEaUvYmkMa2oJBLojwEd6tQf9ECl5Ur1PdD4+5pwsM=;
 b=AdjH/VeFcQL6cR7srFazYQ7QMBYT1r29s4Is1kfeqs3fm/pr6zDgxKobKs2K9oOZWO8kDK+/UNg5x6lbj88g1kVtw7Wn1uApt5dEOKcfsIW0rRIrU32wqarAyydeWTkprtfqY5raPvVjNntGY0MKrXSI+4W3quJn5f1BGyqW6rZPdwDyi+gxlEeQ5OBSCyk74Mlx2pvUA/ecgNHFrAtQd+xdnTayqRWTv4/Db/cKA5aPFRbRRNN5bJGkxvar0zgLLLdmQAA4nbOc3jWKi0OeUjN1rL3/EW1clBv5Lht8JJ05eVcKpGUNfyGq0m/h6j/ABF8ACJmml0Al/V99jGMlQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=draeger.com; dmarc=pass action=none header.from=draeger.com;
 dkim=pass header.d=draeger.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=draeger.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrEaUvYmkMa2oJBLojwEd6tQf9ECl5Ur1PdD4+5pwsM=;
 b=HjYEWmaLTlrBLJkS2O7ytPS4vA5dO/VKptCCKFVCC7uOsSbkisL3yd6bBqjKIFiNhgvQQGbdAYTT139XLqe8kY0st1h8P+vw5NLYU0OrG2D2BM0NhCaRWW4EzPaKA+fp3d9KjAOh9jXJUFiWbrAWvkY3NRw/coq6+zmzdC+dSRoM30zDHwGAJYazZixx6emTWAX6c73kcuiJ0+LpkOjITxFgIyKzGufJbGpWxo941O0qi2pTCP6JsILGdtK9Qwx/z0fv6IhDJ8jNC+uIQlpOIBZxcUnolonJ7niW2Q8TIR81SVgDi07bm/3uwAvLgOMyu9p52SC9vTGDxvea3m97MA==
Received: from BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:3e::5) by
 FR3P281MB3262.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:5d::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.29; Mon, 12 May 2025 05:39:31 +0000
Received: from BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a8ca:7b80:b13a:ccfa]) by BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM
 ([fe80::a8ca:7b80:b13a:ccfa%2]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 05:39:30 +0000
From: "Baehring, Olaf" <Olaf.Baehring@draeger.com>
To: Tom Rini <trini@konsulko.com>
CC: Heinrich Schuchardt <xypron.glpk@gmx.de>, Gaurav Jain
 <gaurav.jain@nxp.com>, Marek Vasut <marex@denx.de>, Peng Fan
 <peng.fan@nxp.com>, Simon Glass <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: RE: [External] Re: arm:, imx:, caam: [PATCH] bugfix CAAM error on
 startup
Thread-Topic: [External] Re: arm:, imx:, caam: [PATCH] bugfix CAAM error on
 startup
Thread-Index: AQHbwMZvu6V0n0UYzUeep5HWjvqTsLPKZOsAgAQXzBA=
Date: Mon, 12 May 2025 05:39:30 +0000
Message-ID: <BE1P281MB22924D99EB000FDBDF295A85E197A@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
References: <BE1P281MB229278535DE4B55BD7240B14E18D2@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
 <a0971d75-fb68-476a-9d65-025584231859@gmx.de>
 <BE1P281MB22929674BBA49DDCF59D404CE18AA@BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM>
 <20250509150126.GI603748@bill-the-cat>
In-Reply-To: <20250509150126.GI603748@bill-the-cat>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_ActionId=e6f2c546-84d5-434a-a23a-ee9fea1fc9ad;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_ContentBits=0;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_Enabled=true;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_Method=Standard;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_Name=Internal -
 Labeled;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_SetDate=2025-05-12T05:31:38Z;
 MSIP_Label_16b2258f-3676-449a-9218-817a22e44788_SiteId=e8d897a8-f400-4625-858a-6f3ae627542b;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=draeger.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB2292:EE_|FR3P281MB3262:EE_
x-ms-office365-filtering-correlation-id: 3979261c-8e26-44ef-b4c7-08dd91175e31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?cUlrcHNpd3ZPV1JncGMvY1o2dFRWQWZhR0lxdWR5VndHTE44OGpNaUJ2cWFO?=
 =?utf-8?B?S0xrRHpqbUlTTUdKcm5kZi9nb21TajZCQjFwV05Jb0NKUGtGVTVpVUtyZm1y?=
 =?utf-8?B?eEpJV3UwT2ZValJ0dG1Xc2tldHRjYkk3RFVuSUdNdE0zRGUxTVYvVFRCVDZO?=
 =?utf-8?B?RjY5aU82OHdsSmVuOEtYeWZLNnMyRktsNUl6aUd6R1BXRmYrektaSTFhTVQ2?=
 =?utf-8?B?WjczaHMwenpaWlUzT2NEeUw3UFd3UEJXNFdIV2w3Uko3bFhvSUR4MW1ONnlr?=
 =?utf-8?B?MEkzYlpIb1Z5TDM5SWZ6azZ1MDI0N0d2Q2NoaFlCc3dtejBRWEFqNjdJejRU?=
 =?utf-8?B?ZGt3NE5MNjRNa2VZV3BlWlVBK1oxcXByMC82bFdGUzRiSDJJcSsrYk1JbWlL?=
 =?utf-8?B?TDdsRUZJdFI1cDl4d1J5RVV4ZFhrMkpQajhSdUNGaGdxNGtQenNENU84RE5R?=
 =?utf-8?B?bUJBblFTUlZTRmRMQ0tPUkMwc0oyM0FTam0vd3VHVTBPaUEvUGNHMllMa3ZD?=
 =?utf-8?B?MSsrQnVIWWpjQmR6L2s2RGpaLzFyT2NVMWhzUXJWakJZQzJHNis1WTUyNER5?=
 =?utf-8?B?cGJySkphYTNnaDhSRStOWkZVeTJUWjZIb3lsMU9pelJRdGxUTU1GWk5qMUlN?=
 =?utf-8?B?Q0REdm1oRUxXNWxEVm9IMDZMTzk4L21YWStOMjZ2M245U2o5Tkd1ZzRBSUN6?=
 =?utf-8?B?STd6QTZrSUxTYnJ3MTNHTFNlNTR0NEVYMTh0a011RXlNRHloSHJaZjhORmYy?=
 =?utf-8?B?SGZseXFTZDZjWEZtT0pYZFpHck1wSEhUZndhUVFlOWVCbnNOOXZLNVhCQXQ5?=
 =?utf-8?B?bVgrYWlwTHJEeThUbk9VK0VEWFhyVitYRTJsUWdqRUcwWitaUzFjTU0zcHV4?=
 =?utf-8?B?bGZsd0pUSUR4WmcvdXZEUkRpd1pVQnlIK1ZvcVR3T3FYbXNwQ1A0NVJTZFZP?=
 =?utf-8?B?endvRy9EL0NWRHBTbTU4UEowdlZSU0s0TktBK3pZdis3SHd1SzRPcVhGakVh?=
 =?utf-8?B?REhqVDFjOU1rNDRON0U2UUtOaHozOHl2dnIxYWFhUkdvTUFmTkJ4OExvRG44?=
 =?utf-8?B?TmxQbmd0QXROQWlHSmJDMDRTdnFibU83U3Zhd2FBc2V2dnNwa0pVeXVrZGFT?=
 =?utf-8?B?eUM0a3RZQ3RHejJhd2FhSFFjYmNWalhyMlF3U2E5U2lWVkFmN3RkY3FEa1RF?=
 =?utf-8?B?MEdQVmk5RUs0VXdHYXBnMTMvTndoTSs3SU5wT1kwdVhqQ0ZYakRESFY2a0xo?=
 =?utf-8?B?WlF6ZjlHdXBaa3pWV0dLZGE2TlJpdmpMUXJ3bFUySi94WGxXK1RqV3dLOUhN?=
 =?utf-8?B?YnFxMU5DNmQyWUJhQkJ2SG1FSVVuZS9zcUlaS2x0NzZ3b0dNdElLUmt2Z0NX?=
 =?utf-8?B?blFJSVpIcGlVUXF3cXNROTluRHkxOVNjTnFCejFja1BMNkw5TW9ISmgxbU9F?=
 =?utf-8?B?Wk5kSUViT1g4Vnk1WGd5d3FpNms4RTZCa0dhUnpuNXdXTmwzekpnSEwyK1Az?=
 =?utf-8?B?S0p5SHpWQTNQWHZ0Mk5xdHA4Zis4SWVjMDc0RkZ4V2ViR1pQKytCc0hJckt4?=
 =?utf-8?B?UlcxaVAxaUltc3J5ZkZkTmZwNjgyajRFMG81T0Zhc3F3US8xR1pTUzMvUWJ5?=
 =?utf-8?B?WDBYcmtKak1mdzJWV0luNytKZENTQkF2b21CUUN6Z3pZc01OVDBza1VEWnF0?=
 =?utf-8?B?UmJoY1ZQQmZNZkRqSVdVM0VOcHdGM1UwMDJyRHFuSVJETHV3VHpjdm9lTnpp?=
 =?utf-8?B?N3MyVXhPZE8vNU1XSUFENENWUWdlWmNiVVphb2tKR2cxQ0ljMXRpandwa2pi?=
 =?utf-8?B?ckFvZ25DR0I5Umw5NWV6R0N2RVFBeHB4SXZ2c0FHUXR3dnFnWFJsSW5uUFVv?=
 =?utf-8?B?OXFTbkRHS0dFYXBlZmVWNnJETS9sOGk3WFNNYTBjQ250TWViOWlWRDhzelZs?=
 =?utf-8?B?cWJXeTdxWUMyWFBRaEJEa2xLcks1eXNRWnVudHY1OXFOUkhYT0w2OVBZdkZ0?=
 =?utf-8?Q?QTny8DlZBOd8/pINavXlfl43ZW8ic0=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UTJ3UVRha0R4ejYya1R3bGRaM3RKYXlnUmpsNmNadzFialZSczdISkNZck9n?=
 =?utf-8?B?MVlWZkk0cnR6ckxwTS9zb2FBdG9nMlMvV2Q4UCtjNVJSai90WE80ajZIQXhJ?=
 =?utf-8?B?TlZpdXVrcGpIQ0tkNE8xSndwZExtM3MvSFBUTjBEZXRQTDVyVHRqTmpxODgw?=
 =?utf-8?B?YnJ6OTc2ekwwNDU2ckc4L1FFV01BSkkva0lwejZQYTZPMXhoOENnZ25MZThp?=
 =?utf-8?B?bVdBMVhIZXI2WEN5bVd5N0ZBd2xaTEJETVB6VmwxeXRpOE5XS2E1M0xReFh1?=
 =?utf-8?B?Y1pERTFPSVNDWmVxdWZzcHBwcHZPcktrcXdSV2R1VnZVdWh3WllGUWVKWHU2?=
 =?utf-8?B?NWNuZWpNbTlzSll1dmUzQUNDS2lLSUh0cXNNNWI0M1ZUMUJpazNBREw3NEh6?=
 =?utf-8?B?bGs0K3k0eEhMZFM5VHF4RStMRitSRit5UThmNEMzT2ZTa1B4akVic1hZNUE0?=
 =?utf-8?B?VFdOUGN5cUxtRWlpOFdUSTZwVFNUZ0tEZlgzM3JVWUIzM05EcXdpS2plejdu?=
 =?utf-8?B?Zlc5ZUErdlhBVXNxa2JzYVVFeUZXM045ZHBLVVBEME90Z1NSaFAyMGRWOXl1?=
 =?utf-8?B?RGk1TklmRk9nby9XWFRUVkR1aC9lQjVuQUhIQU1yUHR1S3ZlYXF3OVozdFp1?=
 =?utf-8?B?RUd4VmtqdXJRNVk5L3RTcUd4eU9hc3BWamY2ZjB1WmV0OXhHU2xWWkdBZE1H?=
 =?utf-8?B?ZGJlQlJuMUlFTDdhaUpRd2g2eHpTTjRiaUNHeFhnYmRhY3d5UDRuLzFJdU5D?=
 =?utf-8?B?UU93MFZhekNpVDZqcGRQNDM0S3ZOSXAvQ3UrY25ya3Y2bmNCcVAxbkFuaHVq?=
 =?utf-8?B?MU4rMzFhWXhSVUd1TzFrWHpEUEZnUjcrSWxIYllGSk5KcHVQQkdaY2RoOWxw?=
 =?utf-8?B?UzYvRE5Na0xPZjJHZUUyaklkZ3M1ZDBNU0wxeU5hMHhCcXd5YmtVdnhac2dM?=
 =?utf-8?B?aHVoMjJRNFJJYXJNZ1RLV2RRNjQyMkF2RjZFV2w1UXEvTmJmNXR1aXJIQnMy?=
 =?utf-8?B?RUtjWTZqVFFEejVnTTlNazk1QVdxZ2I1cit5S0lwSU5yZFNwaklpNWFINVhu?=
 =?utf-8?B?T2pZc2t3VmFWNmQrcEQ0bmJOR3FRVUVZMXBCYkc4NXEvN21RNURKVFExUUZ6?=
 =?utf-8?B?b0h6YWx0MkN5WUhnZEE1aFgzVm1UdS8vS2VKYmVhdk5STWVSK1FUUlRQMC82?=
 =?utf-8?B?UXNjZ3B0WkdpNkpRbFZZdTNMRlNualRuNXJaMUhpYVg1bm1VTFdaZ2Q1SENn?=
 =?utf-8?B?ZXJXQ2R4alc5SENFdm5ZQ1B4RjZ0TEtUakdCWnRSMFdjK0xmaWw0cUluaG9M?=
 =?utf-8?B?SWMvNFVISXJFM2ViNzBzK2puQ29UdWxOTU5ZVVFHUGlOZnVsL2NlOUpPUDRF?=
 =?utf-8?B?MExRSFE0Yzhkd2wwTW5MMWlFNFpHRUhwTFUxcjJnMThkK3pkZVB5VUE5bGIz?=
 =?utf-8?B?Z0tDcTNhQUtQREp3T0w1YmRUK1FDc09ZL2pOdXdtS0FJbXh5eExzdVkvZkRz?=
 =?utf-8?B?RVVQVFBRZzUxcEVZZnJORXJncXpXeDkwZVlFTUpxc2grd1VqaDRtMjdOeUVG?=
 =?utf-8?B?K3JUbGljaGU3bFBoVHB1WGZrZ3ptTmEwNXFhMEdJME1YQlhuc1drY0tkMGZQ?=
 =?utf-8?B?MzkvV2RVajdKSFRXdjlrRUxtVjBEL2RIY2lmNDF3bUZ0SE5LNDRiOXZBNU9M?=
 =?utf-8?B?Skx3TjZpY2cyTmkwb3BEN0N5bkY0eEM1b3pJbmk0cHVHVU1PWlFIcHFaYzJ5?=
 =?utf-8?B?ejNhRkcydUlzSFk1TUM3MnNBTWpyUllhVHMvc1ErNm8rYjhwdUlhSFJPK05t?=
 =?utf-8?B?VkhMbmtvcVFBR1c0QmM3UzdLOThpSkR6QStyZktQalRQSEhBN2F6RUxwYUJ2?=
 =?utf-8?B?TzhQRXBkeFpheng0dTNDRGQzYVZmNkNQYnpnYVZrWWIxOWZFa1ZzYldlTTZu?=
 =?utf-8?B?VUFXZjBaNG96LzNBNVhGY1AyWmlLMEluSEowK0oxSVp4Z2pTK1hJUVV3b1FM?=
 =?utf-8?B?cGwySEE2WXZJQjgrUjUwMXpVSS8rS1ZKWEQzWEZDTU41OTlXdnA2REFNbCsx?=
 =?utf-8?B?UmRpTmQ2dDdPRUMxdnVGZTVreTAxZ0dOeEZXdHkrV1NyQWpwZXNkbGFZdWZM?=
 =?utf-8?Q?9bnh+qtCq/fy0XUlMhwP/zqD+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: draeger.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB2292.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3979261c-8e26-44ef-b4c7-08dd91175e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2025 05:39:30.6881 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e8d897a8-f400-4625-858a-6f3ae627542b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2McDL2QrUop+4LDin1BgrKAuYKQLwAXvdkHKFfSKfQf5EDl0aT4cmwKKH8NGMIVjuc3DE8id1PVXawx+sX+aI5M6ARRk8SzTTaPkoI9YE4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR3P281MB3262
X-Mailman-Approved-At: Mon, 12 May 2025 07:48:50 +0200
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

SW50ZXJuYWwNCg0KSGkgVG9tLA0KDQpzb3JyeSwgIHRoaXMgaGFzIGJlZW4gYWRkZWQgYnkgb3Vy
IG1haWwgc3lzdGVtLiBOZXh0IHRpbWUgSSB3aWxsIHBvc3QgZnJvbSBteSBob21lIFBDLg0KT2Yg
Y291cnNlLCBhcyB0aGlzIGNvZGUgaXMgb3BlbiBzb3VyY2UsIHRoaXMgZml4IHNob3VsZCBhbHNv
IGJlIHB1Ymxpc2hlZCB0byB0aGUgb3BlbiBzb3VyY2UgY29tbXVuaXR5Lg0KU28sIGxldCBteSBj
b25maXJtIHRoaXMuDQoNCkJlc3QgcmVnYXJkcywNCk9sYWYNCg0KDQotLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KRnJvbTogVG9tIFJpbmkgPHRyaW5pQGtvbnN1bGtvLmNvbT4NClNlbnQ6IEZy
aWRheSwgTWF5IDksIDIwMjUgNTowMSBQTQ0KVG86IEJhZWhyaW5nLCBPbGFmIDxPbGFmLkJhZWhy
aW5nQGRyYWVnZXIuY29tPg0KQ2M6IEhlaW5yaWNoIFNjaHVjaGFyZHQgPHh5cHJvbi5nbHBrQGdt
eC5kZT47IEdhdXJhdiBKYWluIDxnYXVyYXYuamFpbkBueHAuY29tPjsgTWFyZWsgVmFzdXQgPG1h
cmV4QGRlbnguZGU+OyBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT47IFNpbW9uIEdsYXNzIDxz
amdAY2hyb21pdW0ub3JnPjsgdS1ib290QGxpc3RzLmRlbnguZGUNClN1YmplY3Q6IFtFeHRlcm5h
bF0gUmU6IGFybTosIGlteDosIGNhYW06IFtQQVRDSF0gYnVnZml4IENBQU0gZXJyb3Igb24gc3Rh
cnR1cA0KDQpPbiBGcmksIE1heSAwOSwgMjAyNSBhdCAwOTo0MDo0NEFNICswMDAwLCBCYWVocmlu
ZywgT2xhZiB3cm90ZToNCg0KPiBJbnRlcm5hbA0KPg0KPiBJbiByYXJlIGNhc2VzIFUtQm9vdCBy
ZXR1cm5zIGFuIGVycm9yIG1lc3NhZ2Ugd2hlbiBpbnRhbnRpYXRpbmcgdGhlDQo+IFJORyBvZiB0
aGUgQ0FBTSBkZXZpY2U6DQo+IOKAnFNFQzA6ICBSTkc0IFNIMCBpbnN0YW50aWF0aW9uIGZhaWxl
ZCB3aXRoIGVycm9yIDB4ZmZmZmZmZmbigJ0NCj4gVGhpcyAgbWVhbnMsIHRoYXQgZXZlbiB3aGVu
IHRoZSBDQUFNIGRldmljZSByZXBvcnRzIGEgZmluaXNoZWQNCj4gZGVzY3JpcHRvciwgbm9uZSBp
cyBmb3VuZCBpbiB0aGUgb3V0cHV0IHJpbmcuDQo+IFRoaXMgbWlnaHQgYmUgY2F1c2VkIGJ5IGEg
bWlzc2luZyBjYWNoZSBpbnZhbGlkYXRpb24gYmVmb3JlIHJlYWRpbmcNCj4gdGhlIG1lbW9yeSBv
ZiB0aGUgb3V0cHV0IHJpbmcgVGhpcyBwYXRjaCBtb3ZlcyB0aGUgY2FjaGUgaW52YWxpZGF0aW9u
DQo+IG9mIHRoZSBvdXRwdXQgcmluZyBmcm9tIHN0YXJ0IG9mIHRoZSBqb2IgdG8gaW1tZWRpYXRl
bHkgYWZ0ZXIgdGhlDQo+IG5vdGlmaWNhdGlvbiBmcm9tIGhhcmR3YXJlIHdoZXJlIHRoZSBvdXRw
dXQgcmluZyB3aWxsIGJlIHJlYWQuDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEJhZWhyaW5nLCBPbGFm
IDxvbGFmLmJhZWhyaW5nQGRyYWVnZXIuY29tPg0KPiAtLS0NCj4NCj4gIGRyaXZlcnMvY3J5cHRv
L2ZzbC9qci5jIHwgMzAgKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+IGRyaXZlcnMv
Y3J5cHRvL2ZzbC9qci5oIHwgIDQgLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxNyBpbnNlcnRp
b25zKCspLCAxNyBkZWxldGlvbnMoLSkNCg0KWW91J3JlIHN0YXJ0aW5nIHRoZSBlbWFpbCBieSBz
YXlpbmcgIkludGVybmFsIiBhbmQgdGhlbiB0aGVyZSdzOg0KW3NuaXBdDQo+IC0tLQ0KPiBUaGlz
IGNvbW11bmljYXRpb24gY29udGFpbnMgY29uZmlkZW50aWFsIGluZm9ybWF0aW9uLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50IHBsZWFzZSByZXR1cm4gdGhpcyBlbWFpbCB0
byB0aGUgc2VuZGVyIGFuZCBkZWxldGUgaXQgZnJvbSB5b3VyIHJlY29yZHMuDQo+DQo+IERpZXNl
IE5hY2hyaWNodCBlbnRoYWVsdCB2ZXJ0cmF1bGljaGUgSW5mb3JtYXRpb25lbi4gU29sbHRlbiBT
aWUgbmljaHQgZGVyIGJlYWJzaWNodGlndGUgRW1wZmFlbmdlciBkaWVzZXIgRS1tYWlsIHNlaW4s
IHNlbmRlbiBTaWUgYml0dGUgZGllc2UgYW4gZGVuIEFic2VuZGVyIHp1cnVlY2sgdW5kIGxvZXNj
aGVuIFNpZSBkaWUgRS1tYWlsIGF1cyBJaHJlbSBTeXN0ZW0uDQoNClNvIHBsZWFzZSBjb25maXJt
IGlmIHlvdSBhcmUgaW50ZW5kaW5nIHRvIHB1Ymxpc2ggdGhpcyBmaXggdG8gdGhlIG9wZW4gc291
cmNlIGNvbW11bml0eSwgb3Igbm90LiBUaGFua3MuDQoNCi0tDQpUb20NCg==
