Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D908FC54E58
	for <u-boot@archiver.kernel.org>; Wed, 13 Mar 2024 08:08:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DA5DB875FA;
	Wed, 13 Mar 2024 09:08:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="Lntem3Ow";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E7F6187653; Wed, 13 Mar 2024 09:08:42 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.109.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 476A2875B9
 for <u-boot@lists.denx.de>; Wed, 13 Mar 2024 09:08:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1710317319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6RiVfJhI9n7SzkBuIOCZOazcxXO6kokn/D+gZQMZwHY=;
 b=Lntem3OwMTJE1SbgD+yQ6lQGDnKrfTZcsN/jIEMZfrHcy97MMoGizmtunfVV/nTDdru11U
 ywnXuT0fCoC9mYHDgVXXEYZPZFnLkZHyFhnXXK+puZKLm2WTIhRZSYZwLGMWLBuVP2aGr0
 XfPSYLAA2W9LGWXpVteHnLVm64kVfy8=
Received: from ZRAP278CU002.outbound.protection.outlook.com
 (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com
 [40.93.85.0]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-31-Fjsfnuw9MH2eVi43I0Jx1g-1; Wed, 13 Mar 2024 09:08:36 +0100
X-MC-Unique: Fjsfnuw9MH2eVi43I0Jx1g-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1106.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.36; Wed, 13 Mar 2024 08:08:35 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a2c:bf89:a76e:a6a3]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::1a2c:bf89:a76e:a6a3%3]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 08:08:35 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "festevam@gmail.com" <festevam@gmail.com>
CC: "peng.fan@nxp.com" <peng.fan@nxp.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, =?utf-8?B?Sm/Do28gUGF1bG8gU2lsdmEgR29uw6dhbHZlcw==?=
 <joao.goncalves@toradex.com>, Francesco Dolcini
 <francesco.dolcini@toradex.com>, Hiago De Franco <hiago.franco@toradex.com>
Subject: Re: [PATCH] apalis-imx8: Fix sc_misc_otp_fuse_read() error check
Thread-Topic: [PATCH] apalis-imx8: Fix sc_misc_otp_fuse_read() error check
Thread-Index: AQHadOHJ+LMtR4RAukqNbF0GrE4UabE1UYMA
Date: Wed, 13 Mar 2024 08:08:35 +0000
Message-ID: <4a1936ba0b1f1818944641275fd4ffb449e281f4.camel@toradex.com>
References: <20240313005941.2654166-1-festevam@gmail.com>
In-Reply-To: <20240313005941.2654166-1-festevam@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1106:EE_
x-ms-office365-filtering-correlation-id: bf97ee79-8e27-4a29-70e6-08dc4334c82d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: wQhtygfpRe+CKrX/bSae890sz9qaw01spZK9Zpb1U7mwt6FRGxbGm5cHK4JsCGgnltta1VBDOMYFWOMakFUhrzKtqBKK+nIUv7asx5nZUJh19QokN6iwcoy8YaVHieIh3DsmzwCjpG8MEnndiYPHCJmWfe9wm1F9ovv0GFPXbrqFJORlVDA/wEvRP0zv/lPDGfpgK7hRh5SQRGCDWKQSfkeCSb5/KvS7F8M9E1d2X7jOSfrDgDbR+x6y7t6CwKaZk7zA2IGPAIPr5GHZS0XCQAdA0OUE1uB5uIKIgc74zYh+zazWo1uB8chGCTJXHSCnww8wglEi1+fr1Fv1dux89EuIql3D6EeEvv7M+aAigPpTAku3MdD8AE463NeD9s8dYx4/zTgDwoA29oM4VG0jCLCfXyP1pekgFUzbRO1TG+mYuByNKAFRsTL5qwzaUa2lT7/drP1qrJ7qB1z12tPnlrVi8VionVEzPHnFtct9K7bWL8ql7lTSIIY+hRESJ4gwYCb21NiKwWbsQVszJ8jU/fsEHm/4xy6fqZmhiekOywPdHM5yclQPD4rb962LzKdpxTYHAKyaV/XNTVtDYAb7qTWQCKDFichDSESOnuCisikbsofmRCKvey5tDZW4vLgJOczIAnbfcOXhewUCJYvcwWPuAfm7cVHbNAy4r/ZQe4RvbhDzqrUDt4O/ChdpZTR2J/GkeEHXMxVLfdTzQYY4CA9e66Cz6wR6LRK0Kz4JBPM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(38070700009); DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dEgzeDlCaGVYNVVHMXVpWk9rb3pESlZoQjI0UWRxMXhWM2JZZU80RVhIZHpE?=
 =?utf-8?B?NnFoWVlwZnpVQzJhbmYwVUtmOWVkcVFqVTVLUnJ5blI1eXR5TWdHZjREZ0hN?=
 =?utf-8?B?TDNpdzJOY1kzL0ZCc0xzZ1hSbXpjb3gwdVdoeTE2NHNEMWJnMWkzeFZYc0Jl?=
 =?utf-8?B?WE5UQUlBYk1TbmVwYzBjd05KN3hOT25sM0ZLK2pBVjl4c09nU05YTHlJdUtL?=
 =?utf-8?B?cExRaEkwWVoxeTNjT3hidGx2cWFsekNIcm9CclhpUXB6UU4xYlk3U0NwNzR4?=
 =?utf-8?B?U3I0bzg4ck4zVWc1eW9WdjlJcEVmeGJkVkN6ajNvMDRIUjRBb0VCSTd1Nk45?=
 =?utf-8?B?Z2lYYUgxcVZxR0VEMjVPbXpCcGF2MVB0SlBoSXBoU0orTmRpRnRIR1ZVVmVx?=
 =?utf-8?B?U2xlSkZiWmJoamVXZ3hyWlIrWHBQM3lRcXpHZitvbG1xYVY4MGNTYjQ3Z01y?=
 =?utf-8?B?MVlTcHlkVGlCVUswL0w0eVhNbGtYc1dNV2JRWUFhbzRrZ09Tak1pSTFsNnJx?=
 =?utf-8?B?NUZRc3VhcWtHNmRZOXlvYlJxL1lVdWlRVEtKU1R6c3JKdEdxNDFXMVZiUGVS?=
 =?utf-8?B?czNlU00rVHVHTFRJMmZxd244TVNUUGpGL3FBTTNKTDM2MzI0d2ZRVC9zejBk?=
 =?utf-8?B?WWRHL0wvd2J6VXZ3TXk0dFMvdWsrVjFlTnpTcDZIZ1lSNmx5ODRqQlNTNFM0?=
 =?utf-8?B?RHlyN0JkMitaZEhwRENMbCt6MHZUM2xGU21OZmNKM2pKbERLNTRLSDZVTURi?=
 =?utf-8?B?MmtNOFBKaSttQnFIN3lLMjFwVUJHMkR0eG9MOHBVTkh5TEtsTi9CaTZUWDF0?=
 =?utf-8?B?S3RiVUszTWdDaHA4YVJqVklYQWNMcEZBdGRKOWxqRm11cDJYTWtVZW5ES0dW?=
 =?utf-8?B?ZVI0aVFXTkR0Nkl3R0hjMndNQURaQ1U3UVFhTXVBRHR4QXhSc05LV1ZjWnhC?=
 =?utf-8?B?a3dUd3VVMVdCQkx0NWVYZG4wQW9PQktsblRVbDhHcUZuMTB2dGVEc09ZNnBa?=
 =?utf-8?B?S0NRQjhIZllkTC9wQUpZL2JGLzRaaTlvbjVUWUpZQU1NazVzMWtSOWRiTmoz?=
 =?utf-8?B?WTRXcEhnemU5d2h1WDBTSE9JODhpYkxBd01PM3ZHaUdGckxlSTVjQ09sLyty?=
 =?utf-8?B?aGp1a1ErSmtwR1BiTEF5NFlZQ1dOdkxYV2k2N1V4ZlY2c0MyOWJWajFkNm53?=
 =?utf-8?B?VjA0c1BvVEVJUzR6WHIzYXNmZWZHUzAwSytpc1JMMVphWEUzNUxqK1NqNGNw?=
 =?utf-8?B?Ukc4RVBQaUxwdFprTklvR2pMRUZmaER2TjYvSXlWSHZBYVUwV054VURBYm5V?=
 =?utf-8?B?c3FGem9OOVd4cVNuR0J3aHk4VXhsVTVpUjFQU1hBOGl6U0lrZVJjN2NCS0hK?=
 =?utf-8?B?SjBJMExVUFFoTlVLb20yanBucEIwVjYybDQrZVZPRDdwb3BXWjd4WG1qVEJT?=
 =?utf-8?B?NWp6QUU2eGpUREE4SG84eUg4UEpXMlprN2h4ODh0eWVoVmlGeXl6UmxybXli?=
 =?utf-8?B?dTZ2UjBXeG1GV3Y5a21VaDlDTVh4dEYwVGowTnIzM3hieHg1VmpHMVBLSFZa?=
 =?utf-8?B?VUNGMG1odlBDejZxOGRZNEVOWW9qU3ZRNEJLUWFmWnJiVHIramNQcWFPcXd4?=
 =?utf-8?B?U3RzZ0JkcndmM015WTQzUVhnL2J2NVNQSzBETU9qQ3ZkT3Fma2dLRHltUTlO?=
 =?utf-8?B?dVlGRTF3MDltbU92U0Vvc1dFUnhMR0lPSTRyWHNNbzliNzR3NlRwVVAyQTFP?=
 =?utf-8?B?RlM2NnB6aGQzeVVqVUswMDk3UVRpbDJVTm95SXlpNFBaV1Q1SmlJbTRVQjhh?=
 =?utf-8?B?MEY1ck5KR3RsdU9wdTNsUTRJdEpkTkV3NktTRE1QZDFKVmViWjZaRHFhdHFj?=
 =?utf-8?B?SWRkUkkxYzA0alJTbVlNUnV2MDBuMTBRZ0p0MXV3L2pSSDlDUVVEZ0xGUFRL?=
 =?utf-8?B?Tkc1dG16eFZRRk90QmdTWHlNcDlSOU1Pc1g5Z1FmMzlBcWtxWWx5aHVZMzJN?=
 =?utf-8?B?Z1A4WUIxZUNnTjMxRHdKKzhjS3NBcXpocHpkcVBYYytxRTNDclBHTXpUNU9a?=
 =?utf-8?B?RENmWWZ0UHorRU14TjBRQkdMR2w5SkZhbXRCam82V29vUUFkRERYSjVLZjJy?=
 =?utf-8?B?ZFlOWmRqWXI3QVlLMmdtNkNiR3gyUlNFNGRxZHFOQXFPaXZGRWhhNTc3aGxJ?=
 =?utf-8?B?MGc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf97ee79-8e27-4a29-70e6-08dc4334c82d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 08:08:35.5464 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tmtDFEurz9bFlHtvwYG2vXvVe+N4B4C9sCZ3TNZwWKR9dSqjEsizhA5qxiWWX1eypFQf8RIFNe1zVNjGRVpKmJ1onjfe+MWOwyxo2ImFZcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1106
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <D63245C3654AF64D8778737EF6DF7798@CHEP278.PROD.OUTLOOK.COM>
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

SGkgRmFiaW8NCg0KVGhhbmtzIQ0KDQpPbiBUdWUsIDIwMjQtMDMtMTIgYXQgMjE6NTkgLTAzMDAs
IEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IENvbW1pdCBiZmIzNDA5ZDY3NmYgKCJpbXg6IHRvcmFk
ZXgvYXBhbGlzLWlteDg6IGNvcnJlY3QgU0NVIEFQSSB1c2FnZSIpDQo+IG1hZGUgYW4gaW5jb3Jy
ZWN0IGxvZ2ljIGNoYW5nZSBpbiB0aGUgZXJyb3IgY29kZSBjaGVjayBvZg0KPiBzY19taXNjX290
cF9mdXNlX3JlYWQoKToNCj4gDQo+IC3CoMKgwqDCoMKgwqAgaWYgKHNjaWVyciA9PSBTQ19FUlJf
Tk9ORSkgew0KPiArwqDCoMKgwqDCoMKgIGlmIChzY2llcnIpIHsNCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIC8qIFFQIGhhcyBvbmUgQTcyIGNvcmUgZGlzYWJsZWQgKi8NCj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlzX3F1YWRwbHVzID0gKCh2YWwgPj4gNCkgJiAw
eDMpICE9IDB4MDsNCj4gwqDCoMKgwqDCoMKgwqAgfQ0KPiANCj4gVGhlIG90aGVyIGNoYW5nZXMg
aW4gdGhpcyBjb21taXQgYXJlIGNvcnJlY3QuDQo+IA0KPiBzY19taXNjX290cF9mdXNlX3JlYWQo
KSByZXR1cm5zIDAgb24gYSBzdWNjZXNzZnVsIGZ1c2UgcmVhZC4NCj4gDQo+IFRoaXMgaW52ZXJz
aW9uIGNhdXNlcyBib2FyZF9tZW1fZ2V0X2xheW91dCgpIHRvIHJlcG9ydCBpbmNvcnJlY3QgUkFN
IHNpemUuDQo+IA0KPiBHbyBiYWNrIHRoZSBvcmlnaW5hbCBlcnJvciBjaGVjayBsb2dpYyB0byBm
aXggdGhlIHByb2JsZW0uDQo+IA0KPiBGaXhlczogYmZiMzQwOWQ2NzZmICgiaW14OiB0b3JhZGV4
L2FwYWxpcy1pbXg4OiBjb3JyZWN0IFNDVSBBUEkgdXNhZ2UiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBG
YWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQoNCkFja2VkLWJ5OiBNYXJjZWwgWmlz
d2lsZXIgPG1hcmNlbC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCg0KPiAtLS0NCj4gwqBib2FyZC90
b3JhZGV4L2FwYWxpcy1pbXg4L2FwYWxpcy1pbXg4LmMgfCAyICstDQo+IMKgMSBmaWxlIGNoYW5n
ZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYm9h
cmQvdG9yYWRleC9hcGFsaXMtaW14OC9hcGFsaXMtaW14OC5jIGIvYm9hcmQvdG9yYWRleC9hcGFs
aXMtaW14OC9hcGFsaXMtaW14OC5jDQo+IGluZGV4IDI0ODNhNjNjNjczMy4uNDk3MTlmMmY1NTMz
IDEwMDY0NA0KPiAtLS0gYS9ib2FyZC90b3JhZGV4L2FwYWxpcy1pbXg4L2FwYWxpcy1pbXg4LmMN
Cj4gKysrIGIvYm9hcmQvdG9yYWRleC9hcGFsaXMtaW14OC9hcGFsaXMtaW14OC5jDQo+IEBAIC0x
MzMsNyArMTMzLDcgQEAgdm9pZCBib2FyZF9tZW1fZ2V0X2xheW91dCh1NjQgKnBoeXNfc2RyYW1f
MV9zdGFydCwNCj4gwqAJc3RydWN0IHRkeF91c2VyX2Z1c2VzIHRkeHJhbWZ1c2VzOw0KPiDCoAlp
bnQgc2NpZXJyID0gc2NfbWlzY19vdHBfZnVzZV9yZWFkKC0xLCA2LCAmdmFsKTsNCj4gwqANCj4g
LQlpZiAoc2NpZXJyKSB7DQo+ICsJaWYgKCFzY2llcnIpIHsNCj4gwqAJCS8qIFFQIGhhcyBvbmUg
QTcyIGNvcmUgZGlzYWJsZWQgKi8NCj4gwqAJCWlzX3F1YWRwbHVzID0gKCh2YWwgPj4gNCkgJiAw
eDMpICE9IDB4MDsNCj4gwqAJfQ0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

