Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08D6C83F17
	for <u-boot@archiver.kernel.org>; Tue, 15 Jul 2025 06:33:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC22F83020;
	Tue, 15 Jul 2025 08:33:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=altera.com header.i=@altera.com header.b="sllT13O6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9BE0082B07; Tue, 15 Jul 2025 04:09:01 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on20631.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:200a::631])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 227308277D
 for <u-boot@lists.denx.de>; Tue, 15 Jul 2025 04:08:59 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=altera.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dinesh.maniyam@altera.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzv9CMtdBuhWx7d4hGBASi5yLwVkgOQvDR0gKkYOCB5rT2oMc8m3GYgfO4gmY0199niTIiwXaOLqRo9FfHZ2Zut+IEbiQQzZvr2HZvw460yXKhNwezF778CT3v/nkiUaxzgzWrPtIwBmwF93vjongrQ0P9s+souGpIf22iOfVTqQlAvdUvCQS3N9gLS/8CsmTkwxbMeK5Tn6zyMPsks5+2moD2hZ+/EHQSlgRIYLM9yjBVIZ9FdN3bDWgqymCbG38LuvNjO6sJnZ5f78FkQvVVknf72UuhCrL/0q/ixEt7RUb8jiG7u2PBCUhBh9TLMEO1xRA+tmMUWrQlXHM0PVhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8koc7HzxokEWUN7SyyD7ujNzMz7Fr+TWPqjZ1dDJog=;
 b=nfM4OguM2SXHdtwwH8XXRW2rMjpQ+aKc1rDWKEg2QbgUQDCm7oEwao96OjsYx1SjLNUVPOvLyigvBmOdePrDMYkPMljetT1SOg+MShoORsPQGslj8HKjCOZCnR78U+OW3ym9Mz1c2CZ8FgLD7j3k6Usqi04cLrl+c2ipMkeVOxGlKbpuyWpKQ/LpIYn0JT8TgQb91zuC8yq1+QMkJMKjgZ4K3TmmOrkTOQLdm13LIraqJF9czeUZoMLdmv5JhktmVHnKx9JPvbadFIfTxDJmUBYFYh5uEmY4/7jju7FH2xdULinyNhQALVCP846YKWI19bviIDzBTBkcybXJP2lEUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=altera.com; dmarc=pass action=none header.from=altera.com;
 dkim=pass header.d=altera.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=altera.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8koc7HzxokEWUN7SyyD7ujNzMz7Fr+TWPqjZ1dDJog=;
 b=sllT13O6AZbCDq2mnjdDyoaSUskypRQoZFaS0kDmUtZnkLGT1DSGgbVpTYF3DaXnUDYE7SB+IqAxwbRHpsINKqkHUaGLuNFjWCWl15dJ/ODEMBmCyInaeHfoHIOkZCyX9UaKTythTNQFJifmsIsoViLMR0yZa9/A2dUgbnMeLveAZIBi2HTd5X5TUXDXjrdMx5Evib48ALCpkiGAsbgJCZjc2gwtQK1IY0A3ZTETpNGWzXiRNVY1/wp5DOYxdF6Ioav75kA0X6syQyrQrDYJ9eQK4zYl1lLJ3rBCDAjuWkucHRodgMA1njA16m4mmtI9pYfsCGFvqAa3XaYb7+LzCA==
Received: from PH7PR03MB6942.namprd03.prod.outlook.com (2603:10b6:510:157::18)
 by DM4PR03MB6029.namprd03.prod.outlook.com (2603:10b6:5:390::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 02:08:56 +0000
Received: from PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd]) by PH7PR03MB6942.namprd03.prod.outlook.com
 ([fe80::c861:d54b:e055:49dd%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 02:08:55 +0000
From: "Maniyam, Dinesh" <dinesh.maniyam@altera.com>
To: "hs@denx.de" <hs@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: Marek <marex@denx.de>, Simon <simon.k.r.goldschmidt@gmail.com>, Simon
 Glass <sjg@chromium.org>, Tom Rini <trini@konsulko.com>, Dario Binacchi
 <dario.binacchi@amarulasolutions.com>, Ilias Apalodimas
 <ilias.apalodimas@linaro.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>, Mattijs Korpershoek
 <mkorpershoek@baylibre.com>, Ibai Erkiaga <ibai.erkiaga-elorza@amd.com>,
 Michal Simek <michal.simek@amd.com>, Dmitry Rokosov
 <ddrokosov@salutedevices.com>, Jonas Karlman <jonas@kwiboo.se>, Sebastian
 Reichel <sebastian.reichel@collabora.com>, Tingting Meng
 <tingting.meng@altera.com>, "Chee, Tien Fong" <tien.fong.chee@altera.com>,
 "Hea, Kok Kiang" <kok.kiang.hea@altera.com>, "Ng, Boon Khai"
 <boon.khai.ng@altera.com>, "Yuslaimi, Alif Zakuan"
 <alif.zakuan.yuslaimi@altera.com>, Hazim
 <muhammad.hazim.izzat.zamri@altera.com>, "Lim, Jit Loon"
 <jit.loon.lim@altera.com>
Subject: RE: [PATCH v5 09/12] cmd: Add i3c command support.
Thread-Topic: [PATCH v5 09/12] cmd: Add i3c command support.
Thread-Index: AQHbw/C5UDANlCxvykmJ166vWNo04rQugrIAgARP2oA=
Date: Tue, 15 Jul 2025 02:08:55 +0000
Message-ID: <PH7PR03MB694204A074159BC3C0B59377F757A@PH7PR03MB6942.namprd03.prod.outlook.com>
References: <20250513101913.30880-1-dinesh.maniyam@altera.com>
 <20250513101913.30880-10-dinesh.maniyam@altera.com>
 <49fb76ab-5e5a-9975-7992-2180349aedff@denx.de>
In-Reply-To: <49fb76ab-5e5a-9975-7992-2180349aedff@denx.de>
Accept-Language: en-MW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=altera.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR03MB6942:EE_|DM4PR03MB6029:EE_
x-ms-office365-filtering-correlation-id: 31ecc089-5e1b-4672-ef1a-08ddc3448daf
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MVg2aGRTM3BzZHlZS2MzU1M0aHdrQ3cyNm1NZlNkT1lLNDdqMUY2d2s2YlhV?=
 =?utf-8?B?SG5XWHpTdnRHVjZHbmxnS3VsMTVBbG1iY3VKaTV1cDd5L2R2b3J2QmxmeWcw?=
 =?utf-8?B?V2s3UVk0eHN6Mk43SXB0REl4TXhmaENLS2Z0OFhhTEQxdERITlNoQ1RueDdB?=
 =?utf-8?B?bWk0VjF3S0JvQnFMZkpvanZ0c1B1WlQ3TlNwN1VYY085V0JidHhGZGNHT3NC?=
 =?utf-8?B?bUMra3dmZXAxallxazh4cWxLWktLck5VeTQ3eEhKSElMb1JwemNaajJwSlFj?=
 =?utf-8?B?VEhoS2FUNzBFallwakdsKzdqNUluYVJXb1R2ZFlYWHNCZnZ6UW1rVWRIUVZ4?=
 =?utf-8?B?aEVXM1BaWGFMcVZoMDk2Y0FITk1ZVm54cDNlVFRjVS9GWDZRcC95NmhMdk13?=
 =?utf-8?B?a2hhbCtLRXpYdUlDUkEya01udjRCMkl3RFdMWGdvRTlSNEs1a2ZES0tuNStL?=
 =?utf-8?B?cGpxeDJkcXZMNjNjbGhVMHJCcUl0VzhUWnFieVVPaGZoSzl4QmpDRmhmREtQ?=
 =?utf-8?B?NmFZNDk1UVVycWt1QytXdzg0d1NKOHg1eTc2eWFRdkc0OW01VXM2c1hPNHNL?=
 =?utf-8?B?V1g3VTRKakwxQkZiM3UzdXFFcnNsYTV4VEVaSTlZUzNFNU5Uc3ducVUxaVRm?=
 =?utf-8?B?S00yUUcvMzhyRWJqMm1vMXJ5djJDSksvdktVeHZWRXlkcDh6TVBpVVRxSk4y?=
 =?utf-8?B?bzk2MkhHR0FjaG4yQ3piaHljeE10SEpLekkva3lvU0pUbHVxOWtGeHlXZUFx?=
 =?utf-8?B?bGY4TVMwY0loYzNzRzZCY1hKWkNOOUZXaDVHRmhwYkU4dzlRck43S2QvcEQw?=
 =?utf-8?B?MXArK0N6UzQydUM2c3dJYWdnT25qYll1eWdyMTZmQms0YUVxbXJQTkNMY2JG?=
 =?utf-8?B?V1JJR0FkR3AxYXFlWkhkTlFGRFFYanpVZ3BmeXAvQmMvZnU1NEVVOW5IWThu?=
 =?utf-8?B?T2plR01DUTUyV2FESDdpQTFEdWplNzF4cGJTYytTanlvTnBDdFRwWGNMUjZ5?=
 =?utf-8?B?RmxqbXYvcGNTRy9SajJqUjE2SXRTTlRkRE0ydkR3VUdzb1J1aDhHR2FNdHdE?=
 =?utf-8?B?S2Q2b2tMYzhXRlJUYVlITnd3ZWhmTVdiU0JSSlN3NWswRXJEZ0FMdnNiVktL?=
 =?utf-8?B?OEJ5NndqNzRNcmJXMDdQMnBPVVZZcktPVmxqL0F2djRDS2VRTkRia0tHRmpn?=
 =?utf-8?B?NENaOFBtN1ZsSWJJcVpHQ0pBUTRvU1U4c0Q5elNZSnhXTTZTb04vay9SNzkv?=
 =?utf-8?B?elRPVXdPMFNPODdaRktCWXgvemozL2VuQytkT1JuM0pPSjA0ek50bXdtS2x4?=
 =?utf-8?B?NUhCUUNvbEFOVzkrNCtBUVNrMklZRTNPeXJ1alZBUXJJYzZrSUMwOGt4Nk53?=
 =?utf-8?B?aE9BSnh0RU5JRnpTMlJXL0dTbTEwbndmWjdybWFCYmloRm95K0VjYnQrYmRm?=
 =?utf-8?B?QmRWQWg0QTlwU2s2elcxVVB0SzhXY0lqS1hNQ2FLZE1jSUtxUlYrTnNXdG5z?=
 =?utf-8?B?ZG1qTFhoNUtmc2x2QjM2cjVTUklLREMxcW1HcUlsVTQrR2xqM0ZmQXRuN3FQ?=
 =?utf-8?B?UjlJQmpFbUZIblI1SnROaTBadkJyTWwvSHFZblhaYkx6NlRpenVISHpDdEJv?=
 =?utf-8?B?eWFmTjNNRnRLYU5PeEk5V04wLzErV20vY25YcXZ5ZWRzVVZhOEhCRTBhajBV?=
 =?utf-8?B?SVB1QU9MaFNQb3dTQWhINUF6aWVpTy9HWkNSbERtdWczQVMrSTdjTTNoeHgv?=
 =?utf-8?B?NDBnc3hGQmpRZW5EMHg2dnRobU4xWmw1TWNESUdJQk1Mbi9MMWgzbk5mZFBw?=
 =?utf-8?B?WmJodnYvQkYrbklpVlIyQTJUdkxGNGxmZGJIbzdXM1BseXNSMm5JV1IrS0tO?=
 =?utf-8?B?MHBacTZwV0pPQS9qeEIzVlYzZEpsRVZPVWJWQUlQQlJuSDJQWmd2cWVOSXdv?=
 =?utf-8?Q?woCNfLk1n78=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR03MB6942.namprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(38070700018);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WW1neGxGTW9tUmdHb01IWTBtTlNXdSt5WXhWQlVSbTlMNzZWZW1wY003dDZT?=
 =?utf-8?B?cXgxTlVBT2ZpbG5UOW1hMmtnbG91TDNFVUVMdmxma2hCcmFoNFpQYkU0TXZN?=
 =?utf-8?B?aUwxcEtWRHUwUXZSTkhYRlZwQUp0RFdBT3FNMWpjVCtTZi9wOFhXUm1uajlO?=
 =?utf-8?B?MEQrMCtNQW1mQ0h6UDJWeC9FeTRBOTVOL3ZqeWNaVk9yclFzNkxUbmZadUhC?=
 =?utf-8?B?blB4NzEzd0x3WW9EU01wUTlDbFJpQ3J0WFVLMnFjWllRS1l6eE5VMUxpRC9W?=
 =?utf-8?B?N1FNSHZCOVQyTkFoUlo2aUJKTjcvSGhyVk5VQ3RXRVNESFdPM0M0ajdabVpK?=
 =?utf-8?B?a2JQVVFwZmpHWVJ5SDNKamJFd1lmV2hNK3FaaWExaDcxVDBFZjBRTHNFUFJm?=
 =?utf-8?B?OFJrcG0yTFNYelhhTEthSDVIbkFDOGZlTEQ3OWJHbWdLYnBMNjZPMnAyb0Ev?=
 =?utf-8?B?Mmo1T0hIRzNYbFhtbmRxRkhHWC9xTzJQRStlM2NoWnZZdm1EQUtDc2cyMEYy?=
 =?utf-8?B?WFBlYWE0blZ6WEk5MFVmNXB0RGs4aXdMRDBTSVVrZjU4b3lhd3QwSXpIY1lG?=
 =?utf-8?B?TGd5NDhnU0NPUWdiWjdjMlBIb0hUVTFRQklBUWJneFh4MGJwZjRhTjcrc3Nq?=
 =?utf-8?B?QWhPTmxUNVh0cW5nejE5ZGFTNTYvcTl6Y2xUaGZmL1p2U2VtWUg3MzVNK0Q3?=
 =?utf-8?B?U2FUTXNnK0tva3NBQ1NFZlpiMEIwVlFMbVpFbEtMREVDLzBWd1Nua3czenJq?=
 =?utf-8?B?RjJWcjdnTDMxMndSMXpKeTZqR000d0V6MnIvc1F2RjhYY2xGb2JwbWRpbVN5?=
 =?utf-8?B?L3JoYmtzU0pyS3dKQWVUSnp6N1V3NkRVNWM5a2FnVUlmMFZ3QlcxRlo2YjJw?=
 =?utf-8?B?eW5kK2lJSjFIN09jUGU2amRLVzQyWEZEWlBmRGdNRXkvN21iK1NWNUpsS3Mv?=
 =?utf-8?B?SGRJNE9iS2EwMVNqRnNqVHRuckpEV0NhR2RPbnhaSXRDOXdIdjd5QkdKSkpZ?=
 =?utf-8?B?UkJWNE44QjU4bHl5RnQrWGFUWWU5VnNpamtvdERvU0VUMWJIZ3JZTTZQM3E2?=
 =?utf-8?B?SXg1MDlXMjRpWVBaUk1lNjFIczNEV2FWdG5zdXZMZ0tCUXlZRFBkb3RzZEZo?=
 =?utf-8?B?dUk5UlFGSi8rajJCZGI0LzQ3bnZnZmJ1Rkl5YUpVTjhnTUZocDA1S0tXWU5X?=
 =?utf-8?B?ZFo0RE9kL2kwSFJPS0dsZUxOS0hIVmZJQkFwYTRXQ3M4bzJSRTZzMnRQK1VI?=
 =?utf-8?B?cFhBOWRSa1BUVkVmakJQWldJdWNTRFU5ZTFCZ0JIdjhrM3g1cENVYWlZMVFp?=
 =?utf-8?B?V2RGSjZTWmdQNDdadU11aDdhMHJHekpEeTQrRmVOVjRaK2F4dHpkeTJtRHdv?=
 =?utf-8?B?a21vQ3NheVpkS2VqeFJ2dTZsT28yN2NBMlp4dnY1K2VmUm1BQjJnUTFHRUpX?=
 =?utf-8?B?RUtGd0NyalZ1aHE5c09SelV3eEgyQndLcDYvcFFKb214SXJicFp0UHk5RndK?=
 =?utf-8?B?SWZiNmJob0FEUEJkcHZkOGpPMkRyaTJYcUFFZ0hkTVRBOVFaNzBLVGhzM3dr?=
 =?utf-8?B?K1hWVjRrc1p4UmxxRU45cUk1K1g4am5XaHE4ejkva2pYTHlwUVpEcmhGVGl4?=
 =?utf-8?B?enVEYlh0a28wSEJqTkJpUGkyVDRvZGp3dVRaRU8wWjdwdWQzNDBtWDRtUkdI?=
 =?utf-8?B?amd6M3p5NFAyQkdXRm1GeVE2UUsvSW04Rlg0SkdVeG8wWGhZTFhSMzU0aDc3?=
 =?utf-8?B?WmJXREdWaVNUcEFiTU55ZmxuVFFZTFQyNk0yUGhVbElQWVpLWE1LQWlWQkhx?=
 =?utf-8?B?aTdWNnpScWlFQ25rTm1QZ1c0czNaMDQyUEsxSVhNcThaSGw3Q0tTc1gvSDRB?=
 =?utf-8?B?ckNkTEZmTzJoTVMrY0JkSXkyK2w2cWQ4aDk2Lzdtam03N0hTN3ZRMGNocFg5?=
 =?utf-8?B?NGdaU0xpVWhxaGFjckdTUm40dnFpajRUWXdvVWJRVG12Z2xxS1pXYWI3Ky95?=
 =?utf-8?B?ZzBqb0cra0ExT1hZRkwrcHdxNnNWZFFNWUwrTzhlZ0N0OVdBc2VVeGVWN2l3?=
 =?utf-8?B?SGUvUWFVb0U0bThMaWxGM0FKRUsrNlVscVB6T1Z0TVgvMlhUNWYwQzdzRWN0?=
 =?utf-8?B?Vkg0MVJ5RWthV3FGeHM2eFRGWXVVTjhxV0dQMHpNT1NqbEVBNHZTYVJGa1Rw?=
 =?utf-8?Q?JJssOTz63BC09ABYY0NZ7s5mgfAiEkECSoMBHoIV0TGo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: altera.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR03MB6942.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31ecc089-5e1b-4672-ef1a-08ddc3448daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 02:08:55.8680 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd72e03-d4a5-4110-adce-614d51f2077a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OjfTrX/FbFUhU3ApI4S0zYrYf2GtFWt7LiimfKdOE10ibVBSWlaCYu6KMwfFUYTb/4DLDVKhuqpSrWpPR2onHadc2Vo6s1D3MSzHFSgTos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6029
X-Mailman-Approved-At: Tue, 15 Jul 2025 08:33:25 +0200
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSGVpa28gU2Nob2NoZXIg
PGhzQGRlbnguZGU+DQo+IFNlbnQ6IFNhdHVyZGF5LCAxMiBKdWx5IDIwMjUgNDoxNyBwbQ0KPiBU
bzogTWFuaXlhbSwgRGluZXNoIDxkaW5lc2gubWFuaXlhbUBhbHRlcmEuY29tPjsgdS1ib290QGxp
c3RzLmRlbnguZGUNCj4gQ2M6IE1hcmVrIDxtYXJleEBkZW54LmRlPjsgU2ltb24gPHNpbW9uLmsu
ci5nb2xkc2NobWlkdEBnbWFpbC5jb20+Ow0KPiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9y
Zz47IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+OyBEYXJpbw0KPiBCaW5hY2NoaSA8ZGFy
aW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20+OyBJbGlhcyBBcGFsb2RpbWFzDQo+IDxp
bGlhcy5hcGFsb2RpbWFzQGxpbmFyby5vcmc+OyBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXByb24u
Z2xwa0BnbXguZGU+Ow0KPiBKZXJvbWUgRm9yaXNzaWVyIDxqZXJvbWUuZm9yaXNzaWVyQGxpbmFy
by5vcmc+OyBNYXR0aWpzIEtvcnBlcnNob2VrDQo+IDxta29ycGVyc2hvZWtAYmF5bGlicmUuY29t
PjsgSWJhaSBFcmtpYWdhIDxpYmFpLmVya2lhZ2EtZWxvcnphQGFtZC5jb20+Ow0KPiBNaWNoYWwg
U2ltZWsgPG1pY2hhbC5zaW1la0BhbWQuY29tPjsgRG1pdHJ5IFJva29zb3YNCj4gPGRkcm9rb3Nv
dkBzYWx1dGVkZXZpY2VzLmNvbT47IEpvbmFzIEthcmxtYW4gPGpvbmFzQGt3aWJvby5zZT47IFNl
YmFzdGlhbg0KPiBSZWljaGVsIDxzZWJhc3RpYW4ucmVpY2hlbEBjb2xsYWJvcmEuY29tPjsgVGlu
Z3RpbmcgTWVuZw0KPiA8dGluZ3RpbmcubWVuZ0BhbHRlcmEuY29tPjsgQ2hlZSwgVGllbiBGb25n
IDx0aWVuLmZvbmcuY2hlZUBhbHRlcmEuY29tPjsNCj4gSGVhLCBLb2sgS2lhbmcgPGtvay5raWFu
Zy5oZWFAYWx0ZXJhLmNvbT47IE5nLCBCb29uIEtoYWkNCj4gPGJvb24ua2hhaS5uZ0BhbHRlcmEu
Y29tPjsgWXVzbGFpbWksIEFsaWYgWmFrdWFuDQo+IDxhbGlmLnpha3Vhbi55dXNsYWltaUBhbHRl
cmEuY29tPjsgSGF6aW0NCj4gPG11aGFtbWFkLmhhemltLml6emF0LnphbXJpQGFsdGVyYS5jb20+
OyBMaW0sIEppdCBMb29uDQo+IDxqaXQubG9vbi5saW1AYWx0ZXJhLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NSAwOS8xMl0gY21kOiBBZGQgaTNjIGNvbW1hbmQgc3VwcG9ydC4NCj4gDQo+
IFtDQVVUSU9OOiBUaGlzIGVtYWlsIGlzIGZyb20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4g
VW5sZXNzIHlvdSB0cnVzdCB0aGUNCj4gc2VuZGVyLCBkbyBub3QgY2xpY2sgb24gbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyBhcyBpdCBtYXkgYmUgYSBmcmF1ZHVsZW50IGVtYWlsDQo+IGF0dGVt
cHRpbmcgdG8gc3RlYWwgeW91ciBpbmZvcm1hdGlvbiBhbmQvb3IgY29tcHJvbWlzZSB5b3VyIGNv
bXB1dGVyLl0NCj4gDQo+IEhlbGxvIERpbmVzaCwNCj4gDQo+IHNvcnJ5IGZvciBsYXRlIHJlcGx5
Li4uDQo+IA0KDQpObyBwcm9ibGVtLCB0aGFua3MgZm9yIHRoZSByZXZpZXcuDQoNCj4gT24gMTMu
MDUuMjUgMTI6MTksIGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20gd3JvdGU6DQo+ID4gRnJvbTog
RGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20+DQo+ID4NCj4gPiBBZGQg
aTNjIGNvbW1hbmQgZmlsZSB0byBzdXBwb3J0IHNlbGVjdCwgZ2V0IGkzYyBkZXZpY2UgdGFyZ2V0
IGxpc3QsDQo+ID4gcmVhZCBhbmQgd3JpdGUgb3BlcmF0aW9uLg0KPiA+DQo+ID4gU2lnbmVkLW9m
Zi1ieTogRGluZXNoIE1hbml5YW0gPGRpbmVzaC5tYW5peWFtQGFsdGVyYS5jb20+DQo+ID4gLS0t
DQo+ID4gICBjbWQvS2NvbmZpZyAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICsNCj4gPiAg
IGNtZC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiA+ICAgY21kL2kz
Yy5jICAgICAgICAgICAgICAgICAgICAgICAgICB8IDI2MSArKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiA+ICAgZG9jL3VzYWdlL2NtZC9pM2MucnN0ICAgICAgICAgICAgICB8IDE0NiAr
KysrKysrKysrKysrKysrDQo+ID4gICBkb2MvdXNhZ2UvaW5kZXgucnN0ICAgICAgICAgICAgICAg
IHwgICAxICsNCj4gPiAgIGRyaXZlcnMvaTNjL21hc3Rlci9kdy1pM2MtbWFzdGVyLmMgfCAgMzUg
KysrLQ0KPiA+ICAgaW5jbHVkZS9kdy1pM2MuaCAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+
ID4gICBpbmNsdWRlL2kzYy5oICAgICAgICAgICAgICAgICAgICAgIHwgIDI4ICsrKy0NCj4gPiAg
IDggZmlsZXMgY2hhbmdlZCwgNDc4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
ICBjcmVhdGUgbW9kZSAxMDA2NDQgY21kL2kzYy5jDQo+ID4gICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZG9jL3VzYWdlL2NtZC9pM2MucnN0DQo+IA0KPiBbLi4uXQ0KPiANCj4gPiBkaWZmIC0tZ2l0IGEv
Y21kL2kzYy5jIGIvY21kL2kzYy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRl
eCAwMDAwMDAwMDAwMC4uN2QyYmRlNzE0Y2QNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIv
Y21kL2kzYy5jDQo+ID4gQEAgLTAsMCArMSwyNjEgQEANCj4gPiArLy8gU1BEWC1MaWNlbnNlLUlk
ZW50aWZpZXI6IEdQTC0yLjArDQo+ID4gKy8qDQo+ID4gKyAqIENvcHlyaWdodCAoQykgMjAyNSBB
bHRlcmEgQ29ycG9yYXRpb24gPHd3dy5hbHRlcmEuY29tPiAgKi8NCj4gPiArDQo+ID4gKyNpbmNs
dWRlIDxib290cmV0cnkuaD4NCj4gPiArI2luY2x1ZGUgPGNsaS5oPg0KPiA+ICsjaW5jbHVkZSA8
Y29tbWFuZC5oPg0KPiA+ICsjaW5jbHVkZSA8Y29uc29sZS5oPg0KPiA+ICsjaW5jbHVkZSA8ZG0u
aD4NCj4gPiArI2luY2x1ZGUgPGR3LWkzYy5oPg0KPiA+ICsjaW5jbHVkZSA8ZWRpZC5oPg0KPiA+
ICsjaW5jbHVkZSA8ZXJybm8uaD4NCj4gPiArI2luY2x1ZGUgPGhleGR1bXAuaD4NCj4gPiArI2lu
Y2x1ZGUgPGxvZy5oPg0KPiA+ICsjaW5jbHVkZSA8bWFsbG9jLmg+DQo+ID4gKyNpbmNsdWRlIDxh
c20vYnl0ZW9yZGVyLmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jb21waWxlci5oPg0KPiA+ICsj
aW5jbHVkZSA8bGludXgvZGVsYXkuaD4NCj4gPiArI2luY2x1ZGUgPHUtYm9vdC9jcmMuaD4NCj4g
PiArI2luY2x1ZGUgPGxpbnV4L2kzYy9tYXN0ZXIuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L3By
aW50ay5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvdHlwZXMuaD4NCj4gPiArDQo+ID4gK3N0YXRp
YyBzdHJ1Y3QgdWRldmljZSAqY3VycmRldjsNCj4gPiArc3RhdGljIHN0cnVjdCB1ZGV2aWNlICpw
cmV2ZGV2Ow0KPiA+ICtzdGF0aWMgc3RydWN0IGR3X2kzY19tYXN0ZXIgKm1hc3RlcjsNCj4gPiAr
DQo+ID4gK3N0YXRpYyB2b2lkIGxvd190b19oaWdoX2J5dGVzKHZvaWQgKmRhdGEsIHNpemVfdCBz
aXplKSB7DQo+ID4gKyAgICAgdTggKmJ5dGVfZGF0YSA9IGRhdGE7DQo+ID4gKyAgICAgc2l6ZV90
IHN0YXJ0ID0gMDsNCj4gPiArICAgICBzaXplX3QgZW5kID0gc2l6ZSAtIDE7DQo+ID4gKw0KPiA+
ICsgICAgIHdoaWxlIChzdGFydCA8IGVuZCkgew0KPiA+ICsgICAgICAgICAgICAgdTggdGVtcCA9
IGJ5dGVfZGF0YVtzdGFydF07DQo+ID4gKw0KPiA+ICsgICAgICAgICAgICAgYnl0ZV9kYXRhW3N0
YXJ0XSA9IGJ5dGVfZGF0YVtlbmRdOw0KPiA+ICsgICAgICAgICAgICAgYnl0ZV9kYXRhW2VuZF0g
PSB0ZW1wOw0KPiA+ICsgICAgICAgICAgICAgc3RhcnQrKzsNCj4gPiArICAgICAgICAgICAgIGVu
ZC0tOw0KPiA+ICsgICAgIH0NCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBoYW5kbGVf
aTNjX3NlbGVjdChjb25zdCBjaGFyICpuYW1lKSB7DQo+ID4gKyAgICAgc3RydWN0IHVjbGFzcyAq
dWM7DQo+ID4gKyAgICAgc3RydWN0IHVkZXZpY2UgKmRldl9saXN0Ow0KPiA+ICsgICAgIGludCBy
ZXQgPSB1Y2xhc3NfZ2V0X2RldmljZV9ieV9uYW1lKFVDTEFTU19JM0MsIG5hbWUsICZjdXJyZGV2
KTsNCj4gPiArDQo+ID4gKyAgICAgaWYgKHJldCkgew0KPiA+ICsgICAgICAgICAgICAgY3VycmRl
diA9IHByZXZkZXY7DQo+ID4gKyAgICAgICAgICAgICBpZiAoIWN1cnJkZXYpIHsNCj4gPiArICAg
ICAgICAgICAgICAgICAgICAgcmV0ID0gdWNsYXNzX2dldChVQ0xBU1NfSTNDLCAmdWMpOw0KPiA+
ICsgICAgICAgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiBDTURfUkVUX0ZBSUxVUkU7DQo+ID4gKw0KPiA+ICsgICAgICAgICAg
ICAgICAgICAgICB1Y2xhc3NfZm9yZWFjaF9kZXYoZGV2X2xpc3QsIHVjKQ0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHByaW50ZigiJXMgKCVzKVxuIiwgZGV2X2xpc3QtPm5hbWUs
DQo+ID4gKyBkZXZfbGlzdC0+ZHJpdmVyLT5uYW1lKTsNCj4gPiArDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgIHByaW50ZigiaTNjOiBIb3N0IGNvbnRyb2xsZXIgbm90IGluaXRpYWxpemVkOiAl
c1xuIiwgbmFtZSk7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHJldHVybiBDTURfUkVUX0ZB
SUxVUkU7DQo+ID4gKyAgICAgICAgICAgICB9DQo+ID4gKyAgICAgfSBlbHNlIHsNCj4gPiArICAg
ICAgICAgICAgIG1hc3RlciA9IGRldl9nZXRfcHJpdihjdXJyZGV2KTsNCj4gPiArICAgICAgICAg
ICAgIHByaW50ZigiaTNjOiBDdXJyZW50IGNvbnRyb2xsZXI6ICVzXG4iLCBjdXJyZGV2LT5uYW1l
KTsNCj4gPiArICAgICAgICAgICAgIHByZXZkZXYgPSBjdXJyZGV2Ow0KPiA+ICsgICAgIH0NCj4g
PiArDQo+ID4gKyAgICAgcmV0dXJuIENNRF9SRVRfU1VDQ0VTUzsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGludCBoYW5kbGVfaTNjX2xpc3Qodm9pZCkNCj4gPiArew0KPiA+ICsgICAgIHN0
cnVjdCB1Y2xhc3MgKnVjOw0KPiA+ICsgICAgIHN0cnVjdCB1ZGV2aWNlICpkZXZfbGlzdDsNCj4g
PiArICAgICBpbnQgcmV0ID0gdWNsYXNzX2dldChVQ0xBU1NfSTNDLCAmdWMpOw0KPiA+ICsNCj4g
PiArICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgcmV0dXJuIENNRF9SRVRfRkFJTFVS
RTsNCj4gPiArDQo+ID4gKyAgICAgdWNsYXNzX2ZvcmVhY2hfZGV2KGRldl9saXN0LCB1YykNCj4g
PiArICAgICAgICAgICAgIHByaW50ZigiJXMgKCVzKVxuIiwgZGV2X2xpc3QtPm5hbWUsDQo+ID4g
KyBkZXZfbGlzdC0+ZHJpdmVyLT5uYW1lKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJuIENNRF9S
RVRfU1VDQ0VTUzsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBoYW5kbGVfaTNjX2N1
cnJlbnQodm9pZCkNCj4gPiArew0KPiA+ICsgICAgIGlmICghY3VycmRldikNCj4gPiArICAgICAg
ICAgICAgIHByaW50ZigiaTNjOiBObyBjdXJyZW50IGNvbnRyb2xsZXIgc2VsZWN0ZWRcbiIpOw0K
PiA+ICsgICAgIGVsc2UNCj4gPiArICAgICAgICAgICAgIHByaW50ZigiaTNjOiBDdXJyZW50IGNv
bnRyb2xsZXI6ICVzXG4iLCBjdXJyZGV2LT5uYW1lKTsNCj4gPiArDQo+ID4gKyAgICAgcmV0dXJu
IENNRF9SRVRfU1VDQ0VTUzsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBoYW5kbGVf
aTNjX2RldmljZV9saXN0KHZvaWQpIHsNCj4gPiArICAgICBpZiAoIW1hc3Rlcikgew0KPiA+ICsg
ICAgICAgICAgICAgcHJpbnRmKCJpM2M6IE5vIGNvbnRyb2xsZXIgYWN0aXZlXG4iKTsNCj4gPiAr
ICAgICAgICAgICAgIHJldHVybiBDTURfUkVUX0ZBSUxVUkU7DQo+ID4gKyAgICAgfQ0KPiA+ICsN
Cj4gPiArICAgICBmb3IgKGludCBpID0gMDsgaSA8IG1hc3Rlci0+bnVtX2kzY2RldnM7IGkrKykg
ew0KPiA+ICsgICAgICAgICAgICAgc3RydWN0IGkzY19kZXZpY2VfaW5mbyAqaW5mbyA9ICZtYXN0
ZXItPmkzY2RldltpXS0+aW5mbzsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICBwcmludGYoIkRl
dmljZSAlZDpcbiIsIGkpOw0KPiA+ICsgICAgICAgICAgICAgcHJpbnRmKCIgIFN0YXRpYyBBZGRy
ZXNzICA6IDB4JTAyWFxuIiwgaW5mby0+c3RhdGljX2FkZHIpOw0KPiA+ICsgICAgICAgICAgICAg
cHJpbnRmKCIgIER5bmFtaWMgQWRkcmVzcyA6IDB4JVhcbiIsIGluZm8tPmR5bl9hZGRyKTsNCj4g
PiArICAgICAgICAgICAgIHByaW50ZigiICBQSUQgICAgICAgICAgICAgOiAlMDE2bGx4XG4iLCBp
bmZvLT5waWQpOw0KPiA+ICsgICAgICAgICAgICAgcHJpbnRmKCIgIEJDUiAgICAgICAgICAgICA6
IDB4JVhcbiIsIGluZm8tPmJjcik7DQo+ID4gKyAgICAgICAgICAgICBwcmludGYoIiAgRENSICAg
ICAgICAgICAgIDogMHglWFxuIiwgaW5mby0+ZGNyKTsNCj4gPiArICAgICAgICAgICAgIHByaW50
ZigiICBNYXggUmVhZCBEUyAgICAgOiAweCVYXG4iLCBpbmZvLT5tYXhfcmVhZF9kcyk7DQo+ID4g
KyAgICAgICAgICAgICBwcmludGYoIiAgTWF4IFdyaXRlIERTICAgIDogMHglWFxuIiwgaW5mby0+
bWF4X3dyaXRlX2RzKTsNCj4gPiArICAgICAgICAgICAgIHByaW50ZigiXG4iKTsNCj4gPiArICAg
ICB9DQo+ID4gKw0KPiA+ICsgICAgIHJldHVybiBDTURfUkVUX1NVQ0NFU1M7DQo+ID4gK30NCj4g
PiArDQo+ID4gK3N0YXRpYyBpbnQgaGFuZGxlX2kzY193cml0ZShpbnQgYXJnYywgY2hhciAqY29u
c3QgYXJndltdKSB7DQo+ID4gKyAgICAgaWYgKGFyZ2MgPCA1KQ0KPiA+ICsgICAgICAgICAgICAg
cmV0dXJuIENNRF9SRVRfVVNBR0U7DQo+ID4gKw0KPiA+ICsgICAgIGlmICghY3VycmRldikgew0K
PiA+ICsgICAgICAgICAgICAgcHJpbnRmKCJpM2M6IE5vIEkzQyBjb250cm9sbGVyIHNlbGVjdGVk
XG4iKTsNCj4gPiArICAgICAgICAgICAgIHJldHVybiBDTURfUkVUX0ZBSUxVUkU7DQo+ID4gKyAg
ICAgfQ0KPiA+ICsNCj4gPiArICAgICB1MzIgbWVtX2FkZHIgPSBoZXh0b3VsKGFyZ3ZbMl0sIE5V
TEwpOw0KPiA+ICsgICAgIHUzMiBudW1fYnl0ZXMgPSBoZXh0b3VsKGFyZ3ZbM10sIE5VTEwpOw0K
PiA+ICsgICAgIHUzMiBkZXZfbnVtX3ZhbCA9IGhleHRvdWwoYXJndls0XSwgTlVMTCk7DQo+IA0K
PiBQbGVhc2UgbW92ZSB0aGUgdmFyaWFibGUgZGVjbGFyYXRpb24gdG8gdG9wIG9mIHRoZSBmdW5j
dGlvbi4gUGxlYXNlIGZpeCB0aGlzIGZvciBhbGwNCj4gYXBwZWFyYW5jZXMsIHRoYW5rcyENCj4g
DQo+IGJ5ZSwNCj4gSGVpa28NCj4gLS0NCg0KU3VyZSwgSSB3aWxsIGZpeCB0aGlzLg0KDQpSZWdh
cmRzDQpEaW5lc2gNCg0KPiBERU5YIFNvZnR3YXJlIEVuZ2luZWVyaW5nIEdtYkgsIE1hbmFnaW5n
IERpcmVjdG9yOiBKb2hhbm5hIERlbmssIFRhYmVhIEx1dHoNCj4gSFJCIDE2NTIzNSBNdW5pY2gs
IE9mZmljZTogS2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLCBHZXJtYW55DQo+IFBo
b25lOiArNDktODE0Mi02Njk4OS01MiAgIEZheDogKzQ5LTgxNDItNjY5ODktODAgICBFbWFpbDog
aHNAZGVueC5kZQ0K
