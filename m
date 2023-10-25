Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D780C0032E
	for <u-boot@archiver.kernel.org>; Wed, 25 Oct 2023 12:46:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 80FDB879AF;
	Wed, 25 Oct 2023 14:46:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="pL0SALnE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9CD6187A94; Wed, 25 Oct 2023 14:46:46 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E6729879AB
 for <u-boot@lists.denx.de>; Wed, 25 Oct 2023 14:46:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698238002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4ZdMqrCVazrV5seD3W9d4U6Ot1QyvJ4HzuXRm8DB0Y4=;
 b=pL0SALnERqhHnLbD05OpTYFBCF/yOXvDYNuD07pdutod1LyOCYoq+WM827xqSHyjBohCJ1
 g/Cjls3PCfg9lemXeSQzilYP/xNqPThKsQLvaHJCoQbVCWXHMXKT3NT+G8lBP6mnJ3gvmV
 mVQ/ls0QL0XVc+kF7jnnxAkKJSREfFo=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2041.outbound.protection.outlook.com [104.47.22.41]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-36-IwRLviZmMf65ochBPK-fZA-1; Wed, 25 Oct 2023 14:46:40 +0200
X-MC-Unique: IwRLviZmMf65ochBPK-fZA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1176.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4f::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.19; Wed, 25 Oct 2023 12:46:37 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6907.032; Wed, 25 Oct 2023
 12:46:37 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "rasmus.villemoes@prevas.dk" <rasmus.villemoes@prevas.dk>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, "festevam@denx.de"
 <festevam@denx.de>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>, "sbabic@denx.de"
 <sbabic@denx.de>
Subject: Re: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Topic: [REGRESSION] imx: spl_imx_romapi: boot loops
Thread-Index: AQHaBk0pzkBxey4AX0CR0vSGBaUJ0LBYqXaAgAAMigCAABTWgIAAIPoAgAGCzgCAAAdcAA==
Date: Wed, 25 Oct 2023 12:46:37 +0000
Message-ID: <1abd23c1e97c95475ca2dc887535e5c50bd6975e.camel@toradex.com>
References: <6de4ef437445c78317e7d8f4f07e47502caed029.camel@toradex.com>
 <cb3e2ea6-b417-4736-9639-b51a04815f7a@prevas.dk>
 <1f86cfc30009f2a04c131ddc06a1d8300dcb1453.camel@toradex.com>
 <e4821c38-ead6-4a51-a442-2c782e638024@prevas.dk>
 <2832e90451ce39c3c7cef34ec5d5c20f02d3a652.camel@toradex.com>
 <CAOMZO5DsFcV1yLjeHyi=56Lph3G8JErMPejVo+FTADMufhBccQ@mail.gmail.com>
In-Reply-To: <CAOMZO5DsFcV1yLjeHyi=56Lph3G8JErMPejVo+FTADMufhBccQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1176:EE_
x-ms-office365-filtering-correlation-id: 9106a43f-e345-47f7-da6a-08dbd5586d62
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: akoAVYPS3rpSRednzcW5yFBWgtV2a0LVC1RwGSPTHjWCOxDMJ1NJyQRAQ9D2BUhDKOpiPny61mflTAqtTX1RH1kGT250UdTM1pLLoDyxQ7EEhIMBg4C5v39gRbq0CgUdFHeP3H605jTIY+WxOZWxT3ukWHndNTE4ijJVSL4oQHGq43kA8sUUIBXOCNYqQ27dmmqPfaW7ZxllzuOL3qvkV4AucNpnPrxv3Xy1ASp+9wH3e64KH9sNuTDD50g9SGUDXVgFht59b5xjnUbjGGDtONRCCKJBb7zQOoV3RYIbs1pi4E66Fa1pEvr7Km/s/yjnE3QdJOpSyPJNe7JTyVpAd70xoVKH59VaNL8950UvocbdYQGMrOC4SafmxToiNeAObcfRSa78+DY7pkKxlnahLeLmjMQ48HgPXKbldazaJCET6NjLS5Xx2ScOZSvO/L0wBYzNy+i0FXg8dJUE3Kcoq0HBKgQW8g5zGXYhEjtyPDxtRw8YPueko03t0zobaI/v2YxmSiah5KB00k/BxmI99ePuVX47FYBtpO4tGuICRgtglp4KjwTp34lL5NDnWuQEFuXt8dJwTzDQr3e2c5pYEpUt694dhbkh1rxZ4WAGQm36l4s3FYKT4gMrMPIVaGix
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39850400004)(346002)(136003)(396003)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(44832011)(41300700001)(53546011)(6506007)(71200400001)(478600001)(122000001)(2616005)(6512007)(76116006)(66556008)(66476007)(66446008)(66946007)(91956017)(64756008)(36756003)(54906003)(316002)(6916009)(6486002)(86362001)(26005)(83380400001)(38100700002)(8676002)(8936002)(38070700009)(4326008)(5660300002)(2906002)(4001150100001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZnBCQWVxSkxmWktSOHpqVUdIUERmOFh6bjRpOHA3NURzaEJuM0JiY2dqQUw0?=
 =?utf-8?B?VE5LU2R0MExnQlFVWjdNUGkrWG84YmZRSWszcThqdElBRWxWN25oa0NqaTJL?=
 =?utf-8?B?ejZ5aDVpd0crN25JaXBqa1F3a2c3RUNUaTJiZFNFMTBKT2F2dldiUzdLTnZE?=
 =?utf-8?B?Y0kzUEFPYUwzS0tzekRLclZ5dU5mUURneUhaRWJGN2RUejhsblRwV21kUENL?=
 =?utf-8?B?U3ZqSzVxVTB3WjhkWGpzb1htNHFHVVhPVHBENncwRHhoT2FSNk9mV3VuRDNC?=
 =?utf-8?B?alpObW1BcHNHd1d4UEhhNXA0cGtCZHl1aTdTQkVkMmtRZStJSXcvbWtZZ01t?=
 =?utf-8?B?ZWJKN1ByTXRndVBiS0p3cE1wbHhPNUZBZ2ZJa2M0bm5FSDBmU1hNT1gxMW9t?=
 =?utf-8?B?Qm95TGY3NS9ZeWJQZzAxcTVwQzdmZVRsOUhJRXJxUjVuTUlhWVMvbzJpUmcw?=
 =?utf-8?B?MG5hRWpaZllmRHFHOHJ3THNzSHRwZzRJUmRVaW5MN0VhRExpd1o0ZVk3QmJG?=
 =?utf-8?B?bjBkMEZETlJhcHdhL1NLMnJvMUd5TUZETHhqSXRDWG5oSEUyakF3VFpEd2Ro?=
 =?utf-8?B?bWw2VGhROHZwa3FJMnFHcGFHNHFnWVZuaEM4ZGg3eVdLWm9kZGZSS1dlTC9N?=
 =?utf-8?B?SEJVUStEWE9TK3FsTDVnK2daOXVSaktia1BrUzNQRWFoNXA3eUxPK3BRN0tx?=
 =?utf-8?B?YncwbkZEZWVnekIrUkU2TSsxb2ZrWDUyN0xQMSs0MHArNWEyY1JnbVJoR2R3?=
 =?utf-8?B?d1JJVTZ5T0p4VjVjSFVCQXROT3hFQVZXTTdIbnVIaWcweGc2dDdxUG5GRTln?=
 =?utf-8?B?QXgycFlqME1JdXRQcFFMVStFL0U1VVJIbXBaNVJxVUFHOUpLdnBoSnhPa04r?=
 =?utf-8?B?aks3ZUVUSEpIZGgzNjM1ZVJsKzlXbHBVc09Ed0hWdFZITkN6MkZTck9FR00z?=
 =?utf-8?B?MEc2c1N4Zkt1QklpSlVFcXRoeDVvRGRLcWVVK3hDZzVRSU5sdDhSUmlRc2dX?=
 =?utf-8?B?WlRXZ0V0YW1uT2pkNTE3WEdHOUN0WHBvVHFNTXJuMC9zWlZ5Z0RUcldIajhm?=
 =?utf-8?B?bWx5M1dqYVFuTTBVVzRCQVlSWGcrOTdoTTYyM1gyVkgyV1ZGSHNWUHdleVJH?=
 =?utf-8?B?NEhkODdxUXR3cVhjR3FMRElwOEViUDhHS3VsU1RBWi9WaS82emEzaVArSzk3?=
 =?utf-8?B?WWpVajRmVlJZMTBVWG5GTFppZlpDWVdvVTRSa09IR0dMV1VpaTE4bWdEZnoy?=
 =?utf-8?B?c21TOWN2bDdqaVRBMXV6UUU3ZzJxVUpkeDFnN2NrSU5yMTFmVHBaeThyOFk4?=
 =?utf-8?B?NjlMQ2dmUHJUOEVVOVhTQ3Z4WkUvMWlsZ2hGN1JkdVBDSC9WSG9GSjg5UjRJ?=
 =?utf-8?B?eWRLVmkxU0dRNFNiMVZnUExLL1EzK2kzU2ZtblE1dXpVMlR3T3J1cUdWUUdp?=
 =?utf-8?B?ZC9TQ3J4V0FudHBnT1B6emM1YkJCMjhrYTBMeVVuSGtLQ2c1b2REREVkaFlr?=
 =?utf-8?B?Q0lUZGo2MjhKNEtZU0Erc1E3b05DdFJWSVlMMWExRmZobTlIWFdxd0h4cTJv?=
 =?utf-8?B?b1Fub2ltMW9rbWZpbzNmVUNWNzBoRnU0SEF4dUM1Smo3WUc1aElNUkRsb1Jn?=
 =?utf-8?B?NWtZVEUzbG9BWFRxQTRTMWZOdGxISmlyZXVWQUk1cjkyemxQYTY5RU9tenZk?=
 =?utf-8?B?QVVtQjFkODVDeDlZcmtzbXJxTEJpSmExOVE1dStodVorMUdRUDRMYUFYYmJM?=
 =?utf-8?B?aDdONzQ0TmRRdDJPdThqSDdsUjU3UzJaaU5icVRMUC9JV01qRXlwc2NqUFpO?=
 =?utf-8?B?T3l1eVBIM2J2VGVPS0txOUJySjhjNi9ObDZhSlFrT1BaNkpjaDd1RTF5WWNC?=
 =?utf-8?B?ZjFLWmpLVnZCVC81QmRUYWNrYzd0NVgwZEppZEh1c2JsTjZmRStYL2VDU1F0?=
 =?utf-8?B?RVYwdHRtY0IzRStBUkZoZmZYN2dYTUR1THBiam5UaXFjaER1NlJla01hVHF4?=
 =?utf-8?B?b2txNytPUDVtMlBpVEN1eEphcE9iV3NXRy8xcVJETEpOSzR3NUV1UmRJVmJP?=
 =?utf-8?B?cGd0SlRsME9uZmJoQ2x0YjlRUWFaMjNpR0hpWmtxWkloUklLUnVGYm05TGFl?=
 =?utf-8?B?b2pCNjgrZnRKaE9OTmRWU25rdnFXeERMUFFlTitRdUVFM1RXYldPdVlYeFZq?=
 =?utf-8?B?b2c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9106a43f-e345-47f7-da6a-08dbd5586d62
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2023 12:46:37.1835 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5blkbY/IG2P/lA3cxJprgqC6D2g6uUKOXo6wmHZZTvQlyx/+dYgodUbUTt6nbkkOoZ42n/OGLqJfLrBGXT8Y331P63hkfpXDpTIoXYdIVe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1176
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <2101271E63500348BFCE38688669FAFE@CHEP278.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
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

SGkgRmFiaW8NCg0KVGhhbmtzIQ0KDQpPbiBXZWQsIDIwMjMtMTAtMjUgYXQgMDk6MjAgLTAzMDAs
IEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IEhpIE1hcmNlbCwNCj4gDQo+IE9uIFR1ZSwgT2N0IDI0
LCAyMDIzIGF0IDEwOjE24oCvQU0gTWFyY2VsIFppc3dpbGVyDQo+IDxtYXJjZWwuemlzd2lsZXJA
dG9yYWRleC5jb20+IHdyb3RlOg0KPiANCj4gPiBZZXMsIHJlZ3VsYXIgZU1NQyBib290LiBTZXJp
YWwgZG93bmxvYWQgYWxzbyB3b3JrcyBmb3IgbWUgKG5vdGUgdGhpcyByZXF1aXJlcyBhIHBhdGNo
IHN0aWxsIG5vdCBtZXJnZWQNCj4gPiB1cHN0cmVhbQ0KPiANCj4gSSB0cmllZCB0aGUgdG9wIG9m
IHRyZWUgVS1Cb290IG9uIHRoZSBpbXg4bXAtZXZrIGFuZCBJIHdhcyBub3QgYWJsZSB0bw0KPiBy
ZXByb2R1Y2UgdGhlIGVycm9yIGhlcmUuDQo+IA0KPiBCZWxvdyBpcyB0aGUgYm9vdCBsb2cgZnJv
bSB0aGUgU0QgY2FyZDoNCg0KWWVzLCBpdCBvbmx5IHNlZW1zIHRvIGJlIGFuIGlzc3VlIGZvciB0
aGUgZU1NQyBGYXN0Ym9vdCBjYXNlIGFzIHRoYXQgb25lIGhhcyBzb21lIHNwZWNpYWwgaGFuZGxp
bmcgKHdoYXRldmVyDQp0aGF0IGlzKS4NCg0KPiBVLUJvb3QgU1BMIDIwMjQuMDEtcmMxLTAwMDU0
LWdmYjQyOGI2MTgxOTQgKE9jdCAyNSAyMDIzIC0gMDk6MTc6MTIgLTAzMDApDQo+IFNFQzA6wqAg
Uk5HIGluc3RhbnRpYXRlZA0KPiBOb3JtYWwgQm9vdA0KPiBXRFQ6wqDCoCBTdGFydGVkIHdhdGNo
ZG9nQDMwMjgwMDAwIHdpdGggc2VydmljaW5nIGV2ZXJ5IDEwMDBtcyAoNjBzIHRpbWVvdXQpDQo+
IFRyeWluZyB0byBib290IGZyb20gQk9PVFJPTQ0KPiBCb290IFN0YWdlOiBQcmltYXJ5IGJvb3QN
Cj4gaW1hZ2Ugb2Zmc2V0IDB4ODAwMCwgcGFnZXNpemUgMHgyMDAsIGl2dCBvZmZzZXQgMHgwDQo+
IE5PVElDRTrCoCBCTDMxOiB2Mi42KHJlbGVhc2UpOmxmLTYuMS4xLTEuMC4wLTAtZzYxNmE0NTg4
ZjMzMw0KPiBOT1RJQ0U6wqAgQkwzMTogQnVpbHQgOiAxMDozODowNCwgT2N0IDEyIDIwMjMNCj4g
DQo+IA0KPiBVLUJvb3QgMjAyNC4wMS1yYzEtMDAwNTQtZ2ZiNDI4YjYxODE5NCAoT2N0IDI1IDIw
MjMgLSAwOToxNzoxMiAtMDMwMCkNCj4gDQo+IENQVTrCoMKgIEZyZWVzY2FsZSBpLk1YOE1QWzhd
IHJldjEuMCBhdCAxMjAwIE1Ieg0KPiBSZXNldCBjYXVzZTogUE9SDQo+IE1vZGVsOiBOWFAgaS5N
WDhNUGx1cyBFVksgYm9hcmQNCj4gRFJBTTrCoCA2IEdpQg0KPiBDb3JlOsKgIDEwMyBkZXZpY2Vz
LCAyNiB1Y2xhc3NlcywgZGV2aWNldHJlZTogc2VwYXJhdGUNCj4gV0RUOsKgwqAgU3RhcnRlZCB3
YXRjaGRvZ0AzMDI4MDAwMCB3aXRoIHNlcnZpY2luZyBldmVyeSAxMDAwbXMgKDYwcyB0aW1lb3V0
KQ0KPiBNTUM6wqDCoCBGU0xfU0RIQzogMSwgRlNMX1NESEM6IDINCj4gTG9hZGluZyBFbnZpcm9u
bWVudCBmcm9tIE1NQy4uLiBPSw0KPiBJbjrCoMKgwqAgc2VyaWFsQDMwODkwMDAwDQo+IE91dDrC
oMKgIHNlcmlhbEAzMDg5MDAwMA0KPiBFcnI6wqDCoCBzZXJpYWxAMzA4OTAwMDANCj4gU0VDMDrC
oCBSTkcgaW5zdGFudGlhdGVkDQo+IE5ldDoNCj4gRXJyb3I6IGV0aGVybmV0QDMwYmYwMDAwIGFk
ZHJlc3Mgbm90IHNldC4NCj4gDQo+IEVycm9yOiBldGhlcm5ldEAzMGJlMDAwMCBhZGRyZXNzIG5v
dCBzZXQuDQo+IENvdWxkIG5vdCBnZXQgUEhZIGZvciBGRUMwOiBhZGRyIDENCj4gDQo+IEVycm9y
OiBldGhlcm5ldEAzMGJmMDAwMCBhZGRyZXNzIG5vdCBzZXQuDQo+IA0KPiBFcnJvcjogZXRoZXJu
ZXRAMzBiZjAwMDAgYWRkcmVzcyBub3Qgc2V0Lg0KPiBObyBldGhlcm5ldCBmb3VuZC4NCj4gDQo+
IEhpdCBhbnkga2V5IHRvIHN0b3AgYXV0b2Jvb3Q6wqAgMA0KPiB1LWJvb3Q9Pg0K

