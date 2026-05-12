Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83FB4CD4851
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 12:15:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9304680398;
	Tue, 12 May 2026 14:15:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=siemens.com header.i=@siemens.com header.b="Qt6KPJfa";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8D9EA80F0E; Tue, 12 May 2026 14:15:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazlp170110003.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c200::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D304E801A9
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 14:15:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=alexander.sverdlin@siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qCynYYZO9MlP+MiuSmV6wAwb+5phOyIFJJxSxfUYiItLOrjV/NVnCcx5YQvOiNUfRNV+aoaQ1P6z88EUcEbvFS6cYiCW6Kf4/tvB/YLyaje7EET6bHOapEbeVmagCbp8kdecqRYpXW8i6FSlcHei5LE0kwbfwtfk9R8VIDbWIkZXztwnX8qDP21GeWkjGbw8UCS50WXr2YjHa38rjnu0gH1RJJPqW6WDJWghoop6cLZtl3AWGqQdW7MWvN3NOySZREqakJ0DolofkYQbnsNwAZoznGUnCLUKh/xlq7ju0mGJAJTDpOLbE+/+57i5Qzhq+MgQ+h3otwqy23RgRUcjcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZI+28Z21EIDg4mXzOdxyZjLJMUuW9Wl1C2SmNqGHls=;
 b=UDDGNq6RAs3wGqNNSFj51LAgcz0AaC3ZzStj22KVyoXahz21h3OLTFZphPFDjNGHrtwrYQxmvsHli9lOxBUhl4f0C/Y5TKno5hcllsrP8UKG32NQH8RysWMt1JZu0ztFBbVTuRdE37nAXZ/iMWPbD4/3OW2EJA4jGpKoVmmMFzkhCj7PWC//21DF1JJCqMAA9HkN9s2HjA2PtBO/itsIo4ihJquTSwntXYS+TuDqfvHwMGzWK+tgl7eqRLTUofGKMrdaPj6xakN2R7dQRDx+GzeHeSTAYhz70GIJeUBe3CFlDlczRRRXOrQWj1PuybbkybSyA8oRY+NTJEdegYpL4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZI+28Z21EIDg4mXzOdxyZjLJMUuW9Wl1C2SmNqGHls=;
 b=Qt6KPJfa1/CtfSIoLZAA0+tJ6RT881rccz3JNXlXFaJV0/XVsLoms7rC8oidgOOgfbDvHc7GVli2xWx9JIlAFHWLTvOIh2GPYOyBOflGw3Y18g+8UY196j4JJ+1e0bCwTZ0TsJL0vbhgrXTTnSJEvAM4lRN7YaqTAJbOu2jtgd0tSlU5V0/qkDk1qxdwbEh0bgBc678Lz3o55/bFRuUqVGrngUGP9alg1v8/Y4qsp1MKjbnHYTgMSYm9NluaEyUyMtsGRRvrSP5zGWo6sbms8IbvXWLJMS0AB9EEOicYuJkU8jsEJAund8m3RIf0CUeduY2E+161ahkZIftZvu9Frg==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AM9PR10MB4069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 12:15:00 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 12:15:00 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "james.hilliard1@gmail.com"
 <james.hilliard1@gmail.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "mwalle@kernel.org"
 <mwalle@kernel.org>, "matthias.winker@de.bosch.com"
 <matthias.winker@de.bosch.com>, "pbrobinson@gmail.com"
 <pbrobinson@gmail.com>, "marek.vasut+renesas@mailbox.org"
 <marek.vasut+renesas@mailbox.org>, "trini@konsulko.com" <trini@konsulko.com>, 
 "Kiszka, Jan" <jan.kiszka@siemens.com>, "jerome.forissier@arm.com"
 <jerome.forissier@arm.com>, "sumit.garg@kernel.org" <sumit.garg@kernel.org>,
 "quentin.schulz@cherry.de" <quentin.schulz@cherry.de>, "hs@nabladev.com"
 <hs@nabladev.com>, "festevam@denx.de" <festevam@denx.de>,
 "daniel@makrotopia.org" <daniel@makrotopia.org>, "dlechner@baylibre.com"
 <dlechner@baylibre.com>, "Jin, Le" <le.jin@siemens.com>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>, "Schweizer,
 Walter" <walter.schweizer@siemens.com>, "Freihofer, Adrian"
 <adrian.freihofer@siemens.com>, "sjg@chromium.org" <sjg@chromium.org>,
 "quic_varada@quicinc.com" <quic_varada@quicinc.com>, "pro@denx.de"
 <pro@denx.de>, "philip.molloy@analog.com" <philip.molloy@analog.com>,
 "dev@benjarobin.fr" <dev@benjarobin.fr>
Subject: Re: [PATCH v3 1/2] env: migrate static flags list to Kconfig
Thread-Topic: [PATCH v3 1/2] env: migrate static flags list to Kconfig
Thread-Index: AQHc4XLwlMSHMKaugU6d4n55PGkqWbYKTwGA
Date: Tue, 12 May 2026 12:15:00 +0000
Message-ID: <fca54a0ce5a2375531ad51dbac84b30fe996446b.camel@siemens.com>
References: <20260511182036.50453-1-james.hilliard1@gmail.com>
In-Reply-To: <20260511182036.50453-1-james.hilliard1@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.54.3 (3.54.3-2.fc41) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AM9PR10MB4069:EE_
x-ms-office365-filtering-correlation-id: 1605d57b-9b45-49ed-728c-08deb02016fb
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|55112099003|38070700021|56012099003|18002099003|22082099003|11063799003;
x-microsoft-antispam-message-info: zloUox7zLd+QyQzrzdSqn3wWMxGPC/snxrILCXr+iKd83moyty+MunuHJjyhSwtaQYj4Ub0k/4BqGoby1LuuNp3dr0ASgu7a0W89N83FBapY18TQcj8M/r3vAvm+mSqxiGjijhmO4Mm+ZnGg+fnoSn4vDim/Qi7SIHXy+ZodsB78cpfUvMLcF0TdVGGdIvEq9fymt0LNqxmxSH798f0B1Y2IcHR8STTq6OyxXtl7cOsaeApBu4r7USGe8pd8zecYrOyOv2VzcRxhJUk4XRLANWcxyyPV2bF60TqT7TNhY+6xzQyPlggmaLi91DC3Qc2ebuJL3s+cZImhlvwGZMnwPFg06GKik2nkjW+CHuJTTT5Gl7bsfb7C8hEfKhUasxtLDp31a/lfAeW/LSMttA8UzOCzjycfQdk41UkBTqQ9ifX3mfbewkPiUYnQ3iZA42cULmyioLX5D3M3FGBjFauFEoXq/Z9yUnNggUnhMp5xZLRywoxdZiBuGdaRusrvdScAjne1f3Ut3zlpGvr4nLowzvsTzVwX7uyi7oZEVd9i9NNO86M2QSODq/adc+hewCHzK4eV5kSiRgeIVAVwtFWiuVO1saqrEWhqR3TpNXe+vdpyuGomg+jSvl11w3nyitnpSdPvelM9V650iVo5HvWiOxcy1Pf8VPyxWWrNM7dgapMt3x3saDgRMhumU8G+UK7NYmIQ/BoQeRTQ54rxfNA5GQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(55112099003)(38070700021)(56012099003)(18002099003)(22082099003)(11063799003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlgvWUN5azN1TXRzQVFhTGhyQm9NRGVYOXZ1dktIa0I2bzhLRDdJTldPM0J5?=
 =?utf-8?B?ZUxnd3VweVNqYjVDa0QzblFxZFhtTFMxU3pXNjVIYTVESWNpdGxaVHppRVYy?=
 =?utf-8?B?Y2tPa1N2eWs2YkdTRFhld0c5eGlWeXU3amJYWklYUU14UXBzcmtWeExnendV?=
 =?utf-8?B?OXhJdFdHaGdGaWc0ZTlxWksyeWJMeTJrcFkzSlZSM3ViSGZJMS9GVnl0NEJM?=
 =?utf-8?B?dVJqSjlvcVU4bEN4WnhzZXdmVFBsUFZxTUZ6VDNCQmRlTWVoQTZvMFFqRWFU?=
 =?utf-8?B?djNYYjY0ODcxL0I0SkdkQkZNWVp2Qjh0SGxPYlpLRk01RlhtK2hVODVnVHlW?=
 =?utf-8?B?eWxiTy9SdkJzTTBrK0tOZTRzeStUQ2JackdTbWpIQ2VFNjJ0YW0yWkJYTFM0?=
 =?utf-8?B?MlRIakd0ZkZQSU1pYVNyMFB6UCt0YmhlU1ZHK2JWdTg4bEk2VCszREFjWTlp?=
 =?utf-8?B?UFVXcTRsUUkvYlB6Y3dWRXdxN2Z6Q3R4Zk1KMGFiVGQxbmlsamM4d29kSTZJ?=
 =?utf-8?B?QjN2UExuYkQ5aHU4UnRRUVVlRzViYmN3S1dDRmFnc0tTNmNYdDg0L210bThz?=
 =?utf-8?B?eDY5TEtocC9oMjR1L1pKTkZWSlVFMDJTNVpWeEJPQzZ0Wk9OOFIzY3dvbHdY?=
 =?utf-8?B?cHJEdVRicG9BN3pGUVFBL2orcG0wSzlzUTBZS2VpVlQ3YkNtUVB5c0tqSExu?=
 =?utf-8?B?ajk5OHNRdkU0RkJrdkppdjRDTjhxVmp2NHFST1pHSG1TUWpOUEJhU0tOcTJz?=
 =?utf-8?B?Nm9JRmlYem9OK0lxVk1HNUNJeUh4K1VnWjJqZEgramZ0VjlEbG5mN2JDQVdZ?=
 =?utf-8?B?MGE2MGhha3hNZ0Zha2Q5L2tmam9sbkFXTEI4Z0g1M0duZ0JzbnNwQXVVaHcw?=
 =?utf-8?B?U1ZkMGl2cnBIZnY3QU93bG1JVVNRWUY5dXROb0VpOWhlS29VbGdnQ1pzMnBG?=
 =?utf-8?B?M29TTzJYWHNzM29mMGt5Y3Bsb29Hdjhkdlh5U0h3NXNya2Nub21ma1J3RG9Y?=
 =?utf-8?B?bElLSUFyNlVxeXVYQ3JDdzc5cm1FcXlzN3dKZVVOOFphSWVOT1dMOWdsdG9j?=
 =?utf-8?B?WUJPUWl2alJnRHRyRnloZWl6U2szS2ROa29GKzY2TFljSmlKWjN1VEcxWjBY?=
 =?utf-8?B?R3ZYVm9yMHRGRlRIUFlzR3BQdVVhT2hTaUUxSG55RU9hMVJvN2p5Zk50a0FY?=
 =?utf-8?B?Z0tndlI4RmhESXVxNGRmUm5GQkJiYlROUHZRNjF2THV3RTR2ZUZQSDhVYTNG?=
 =?utf-8?B?dFV2c0hYN0FoU3hNdW50WXUrUzRDMlhIZU1qUzRsVnhhcVNzdmpmZjdISzNY?=
 =?utf-8?B?bUc0U1dMQzR6Z1RCZ2lLNk1pVU9XNE5scllTbUxjY1h1Uy82SlNleUEvYWxC?=
 =?utf-8?B?Ylk0UmNjRTVaWFM5S2pSQzQ4d2xsUWxXVEkyeG1UMlRidklJYWY3ekZBR3JD?=
 =?utf-8?B?a1hDSzVua2tGUmlOOEl0VWJOQ1Q0Q2VkNzFMWGJzRkZSem9Ld3d5MElrRDk5?=
 =?utf-8?B?cDZqaVgvYXhhc1IrU1JpMkxsSXp3NVhEWHBFSlhiVndJRUYwZGs3Z0tSM0hj?=
 =?utf-8?B?VDlyUVRyOTV4YmdvSVZQRGVZT2FWQWpsVGkrVDAzQjJ5d3NHc2lHZHkzbE43?=
 =?utf-8?B?QTViOHo2QVNQUjRGV3oxcUtlSDhEM2xlczNzVTl6UDl2clFuc2tKTzcyalAz?=
 =?utf-8?B?aTJ4RUxvZUhocG5abGJYNmF3Yk1uVU56a0FuY0hhdGJ3Q1ExRWY0UHE0bTZ6?=
 =?utf-8?B?czl1Q0NHUWl1Wk42UDNnUXFzM1BvekM3NGVxbkQydnZWV2puU3JzSFg4Q2po?=
 =?utf-8?B?Nk9NRDJOeFNrUEt3Zm1lRkpIOW15ZlgyUEI5WVd1UXdVRUhWR2ZsYjZRUWJR?=
 =?utf-8?B?TUZJQmRDZVNhU1pibkJ1YlUyM3V5aWhpTWlKNUtEQUsyejVuWWdQaDFad1d6?=
 =?utf-8?B?K1RrRWorWFVKMndTZk9GSGFyano3MlBSRTZ1ZWlzckoyd3I5RVdKUUF0ZVlx?=
 =?utf-8?B?VU41OXRQZUZpWUk3cEJMTWQwNHczRGxkTlVta3FpVVczb3lJcEtPSXZrTkx6?=
 =?utf-8?B?OTZZeUs1aVBIMTVxYkZVRXVDV0pwQzhnTXZzSWNuemlickQ4Z1NnTUp6bDlW?=
 =?utf-8?B?NDBocXRLK05Eb3Q2cXZRbmpEeXFHUmtlYW1uL2JNY1h4bEdnVkkxd1FZR2ZG?=
 =?utf-8?B?MVZ4a0NFbno4UFlhSFZ0SlV0aHErb2pxYWdjT1VOTndTR3pVMFczbEh0R1VT?=
 =?utf-8?B?YXNxOHhscmFYSjhTVFdPYnpTTVNNOEVhMjVjZGdJSitCWUVSSTFzejAwTWkw?=
 =?utf-8?B?UzZjK3pDQTJmeW9vMVdnNXVCSFkvMkpwWStkWnYvakpSMEo5MUg2SHh5WFAz?=
 =?utf-8?Q?tXZLevvsknH2iEUoE7Kvy6tcatXtmncEQeNXz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AB2F00981DDB246B3CD0DD7C8075C2C@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1605d57b-9b45-49ed-728c-08deb02016fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2026 12:15:00.4036 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYq65hwfAS79j526aQ+tC3yDfKlWVzWlRAZOi+BF+ute6Y/1TEPOE/PPBA1e1azZhZZhD8HAKdBewzSB7cUUGa9D9mKKMi7iyImcTCRjP9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4069
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

SGkgSmFtZXMsDQoNCk9uIE1vbiwgMjAyNi0wNS0xMSBhdCAxMjoyMCAtMDYwMCwgSmFtZXMgSGls
bGlhcmQgd3JvdGU6DQo+IEVudmlyb25tZW50IGNhbGxiYWNrcyBjYW4gYWxyZWFkeSBiZSBjb25m
aWd1cmVkIGZyb20gS2NvbmZpZyB3aXRoDQo+IENPTkZJR19FTlZfQ0FMTEJBQ0tfTElTVF9TVEFU
SUMsIGJ1dCBzdGF0aWMgZW52aXJvbm1lbnQgZmxhZ3Mgc3RpbGwNCj4gcmVxdWlyZSBib2FyZCBo
ZWFkZXJzIHRvIGRlZmluZSBDRkdfRU5WX0ZMQUdTX0xJU1RfU1RBVElDLg0KPiANCj4gQWRkIENP
TkZJR19FTlZfRkxBR1NfTElTVF9TVEFUSUMgYW5kIHVzZSBpdCBhcyB0aGUgb25seSBib2FyZC1w
cm92aWRlZA0KPiBzdGF0aWMgZW52aXJvbm1lbnQgZmxhZ3MgbGlzdC4gQ29udmVydCB0aGUgcmVt
YWluaW5nIGRlZmF1bHQtY29uZmlnIHVzZXJzDQo+IGZyb20gQ0ZHX0VOVl9GTEFHU19MSVNUX1NU
QVRJQyB0byBkZWZjb25maWcgc2V0dGluZ3MgYW5kIGRyb3AgdGhlIGxlZ2FjeQ0KPiBoZWFkZXIg
bWFjcm8gZnJvbSBFTlZfRkxBR1NfTElTVF9TVEFUSUMuDQo+IA0KPiBNb3ZlIHRoZSBlbnZpcm9u
bWVudCBmbGFncyBmb3JtYXQgZG9jdW1lbnRhdGlvbiBvdXQgb2YgUkVBRE1FIGFuZCBpbnRvDQo+
IHRoZSBkZXZlbG9wZXIgZW52aXJvbm1lbnQgZG9jdW1lbnRhdGlvbi4gSW5jbHVkZSB0aGUgZm9y
bWF0IGluIHRoZQ0KPiBLY29uZmlnIGhlbHAgYXMgd2VsbC4NCj4gDQo+IFRoaXMgbGV0cyBib2Fy
ZHMgY29uZmlndXJlIHdyaXRlYWJsZS1saXN0IHBvbGljeSBhbmQgdHlwZSB2YWxpZGF0aW9uDQo+
IGZyb20gZGVmY29uZmlnIHdpdGhvdXQgYWRkaW5nIGEgY29uZmlnIGhlYWRlciBzb2xlbHkgZm9y
IGVudiBmbGFncy4NCj4gDQo+IFRoaXMgcHJlc2VydmVzIHRoZSBiZWhhdmlvciBvZiBkZWZhdWx0
IGNvbmZpZ3MuIEhlYWRlci1vbmx5IGNhc2VzIHRoYXQNCj4gd2VyZSBpbmFjdGl2ZSBpbiB1cHN0
cmVhbSBkZWZjb25maWdzIGFyZSBub3QgY29udmVydGVkIGludG8gZGVmY29uZmlnDQo+IGVudHJp
ZXM6IGlvdDIwNTAgY2FuIGFkZCBpdHMgbGlzdCB3aGVuIGVuYWJsaW5nIEVOVl9XUklURUFCTEVf
TElTVCwgYW5kDQo+IHNtZWd3MDEgY2FuIGFkZCBtbWNkZXY6ZHcgc3VwcG9ydCBpZiB0aGUgdW5s
b2NrZWQgU1lTX0JPT1RfTE9DS0VEPW4NCj4gY29uZmlndXJhdGlvbiBpcyBuZWVkZWQuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBKYW1lcyBIaWxsaWFyZCA8amFtZXMuaGlsbGlhcmQxQGdtYWlsLmNv
bT4NCj4gUmV2aWV3ZWQtYnk6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+IFJldmll
d2VkLWJ5OiBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCg0KTEdUTQ0KDQpSZXZpZXdl
ZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+
DQoNCj4gLS0tDQo+IENoYW5nZXMgdjIgLT4gdjM6DQo+IMKgIC0gTm90ZSB0aGF0IGluYWN0aXZl
IGhlYWRlci1vbmx5IGlvdDIwNTAgZmxhZ3MgYW5kIHRoZSBzbWVndzAxDQo+IMKgwqDCoCBTWVNf
Qk9PVF9MT0NLRUQ9biBtbWNkZXY6ZHcgZmxhZyBhcmUgbm90IGNvbnZlcnRlZCBpbnRvIGRlZmNv
bmZpZ3MuDQo+IA0KPiBDaGFuZ2VzIHYxIC0+IHYyOg0KPiDCoCAtIENvbnZlcnQgZXhpc3Rpbmcg
Q0ZHX0VOVl9GTEFHU19MSVNUX1NUQVRJQyB1c2VycyB0bw0KPiDCoMKgwqAgQ09ORklHX0VOVl9G
TEFHU19MSVNUX1NUQVRJQyBpbiBkZWZjb25maWdzLg0KPiDCoCAtIERyb3AgQ0ZHX0VOVl9GTEFH
U19MSVNUX1NUQVRJQyBzdXBwb3J0IGluc3RlYWQgb2YgYXBwZW5kaW5nIHRoZSBuZXcNCj4gwqDC
oMKgIEtjb25maWcgdmFsdWUgYWZ0ZXIgdGhlIGxlZ2FjeSBDIG1hY3JvLg0KPiDCoCAtIFJlbW92
ZSB0aGUgdHJhaWxpbmctY29tbWEgcmVxdWlyZW1lbnQgZm9yIGJvYXJkLXNwZWNpZmljIHN0YXRp
YyBmbGFncy4NCj4gwqAgLSBQbGFjZSB0aGUgbWlncmF0ZWQgZGVmY29uZmlnIGVudHJpZXMgaW4g
c2F2ZWRlZmNvbmZpZyBvcmRlci4NCj4gwqAgLSBNb3ZlIGVudmlyb25tZW50IGZsYWdzIGRvY3Vt
ZW50YXRpb24gZnJvbSBSRUFETUUgdG8NCj4gwqDCoMKgIGRvYy9kZXZlbG9wL2Vudmlyb25tZW50
LnJzdC4NCj4gwqAgLSBBZGQgdGhlIGZsYWdzLWxpc3QgZm9ybWF0IHRvIHRoZSBDT05GSUdfRU5W
X0ZMQUdTX0xJU1RfU1RBVElDIEtjb25maWcNCj4gwqDCoMKgIGhlbHAgdGV4dC4NCj4gLS0tDQo+
IMKgUkVBRE1FwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHwgNDUgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiDCoGNvbmZp
Z3MvYXJpc3RhaW5ldG9zMmNfZGVmY29uZmlnwqDCoMKgwqAgfMKgIDEgKw0KPiDCoGNvbmZpZ3Mv
YXJpc3RhaW5ldG9zMmNjc2xiX2RlZmNvbmZpZyB8wqAgMSArDQo+IMKgY29uZmlncy9obWlic2Nf
ZGVmY29uZmlnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBjb25maWdzL2lt
eDZxX2Jvc2NoX2FjY19kZWZjb25maWfCoMKgwqAgfMKgIDEgKw0KPiDCoGNvbmZpZ3MvaW14OHF4
cF9jYXByaWNvcm4uY29uZmlnwqDCoMKgwqAgfMKgIDEgKw0KPiDCoGNvbmZpZ3Mvc21lZ3cwMV9k
ZWZjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBjb25maWdzL3NvY3Jh
dGVzX2RlZmNvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxICsNCj4gwqBkb2MvZGV2ZWxv
cC9lbnZpcm9ubWVudC5yc3TCoMKgwqDCoMKgwqDCoMKgwqAgfCA0MCArKysrKysrKysrKysrKysr
KysrKysrKysrDQo+IMKgZW52L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8IDIzICsrKysrKysrKysrKysrDQo+IMKgaW5jbHVkZS9jb25m
aWdzL2FyaXN0YWluZXRvczIuaMKgwqDCoMKgwqAgfMKgIDMgLS0NCj4gwqBpbmNsdWRlL2NvbmZp
Z3MvY2Fwcmljb3JuLWNvbW1vbi5owqDCoCB8IDEzIC0tLS0tLS0tDQo+IMKgaW5jbHVkZS9jb25m
aWdzL2htaWJzYy5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0IC0tLQ0KPiDCoGluY2x1
ZGUvY29uZmlncy9pbXg2cS1ib3NjaC1hY2MuaMKgwqDCoCB8IDEyIC0tLS0tLS0tDQo+IMKgaW5j
bHVkZS9jb25maWdzL2lvdDIwNTAuaMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDggLS0tLS0N
Cj4gwqBpbmNsdWRlL2NvbmZpZ3Mvc21lZ3cwMS5owqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1
IC0tLS0tLS0tLS0NCj4gwqBpbmNsdWRlL2NvbmZpZ3Mvc29jcmF0ZXMuaMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAyIC0tDQo+IMKgaW5jbHVkZS9lbnZfZmxhZ3MuaMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKy0tLQ0KPiDCoDE4IGZpbGVzIGNoYW5nZWQsIDcyIGlu
c2VydGlvbnMoKyksIDEwNiBkZWxldGlvbnMoLSkNCg0KLS0gDQpBbGV4YW5kZXIgU3ZlcmRsaW4N
ClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
