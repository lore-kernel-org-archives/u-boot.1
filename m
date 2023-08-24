Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A10C6FA8F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 13:02:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 13D298642B;
	Thu, 24 Aug 2023 15:02:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="ifX+RHy/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1A1E86433; Thu, 24 Aug 2023 15:02:30 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 235CE86418
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 15:02:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1692882147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FexzX6RE3RtkDxB4rYgUqxdqcwnxAKs+mrXumR0qKJ0=;
 b=ifX+RHy/2nIkl0hc6eaUg/TfkQOaCPOLqrgPQmNTABVMHEfHhQtsqh3iqNXm42dCgMuCum
 UigN3twbQtmUclNmUG4QJhbEnAp6NPEmmkuF+IShG6UrUafrIaZ1glYgDaXLcnI8nxSiwG
 S4J7WQlvKEnxJ4Ki4QN/2MOspJCwm+g=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2044.outbound.protection.outlook.com [104.47.22.44]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-26-yUoMuX-oPTyfOHJ13THvZw-2; Thu, 24 Aug 2023 15:02:25 +0200
X-MC-Unique: yUoMuX-oPTyfOHJ13THvZw-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB1078.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:4e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.27; Thu, 24 Aug 2023 13:02:21 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6699.027; Thu, 24 Aug 2023
 13:02:21 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "nm@ti.com" <nm@ti.com>, "francesco@dolcini.it" <francesco@dolcini.it>,
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, "mkorpershoek@baylibre.com"
 <mkorpershoek@baylibre.com>
CC: "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "n-francis@ti.com"
 <n-francis@ti.com>, "trini@konsulko.com" <trini@konsulko.com>, "afd@ti.com"
 <afd@ti.com>, "sjg@google.com" <sjg@google.com>, "bb@ti.com" <bb@ti.com>,
 "robertcnelson@gmail.com" <robertcnelson@gmail.com>, "vigneshr@ti.com"
 <vigneshr@ti.com>, "praneeth@ti.com" <praneeth@ti.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
Thread-Topic: [PATCH V5 02/17] include: configs: am62x_evm: Drop unused SDRAM
 address
Thread-Index: AQHZ1mLpXistP2UR+Eu+7OM5/JUJEK/5Wa6AgAAP+4A=
Date: Thu, 24 Aug 2023 13:02:21 +0000
Message-ID: <715c5ae929964f51a3c3fec91cb8c9cb4f65eaa0.camel@toradex.com>
References: <20230824031101.3460411-1-nm@ti.com>
 <20230824031101.3460411-3-nm@ti.com> <87il94rh6x.fsf@baylibre.com>
 <20230824120509.72xvy5n2hpl5uh4q@landside>
In-Reply-To: <20230824120509.72xvy5n2hpl5uh4q@landside>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB1078:EE_
x-ms-office365-filtering-correlation-id: c94ab03d-018c-4c64-1fd3-08dba4a25acc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: ZkXkm+L1Aa3xJHWEZ/mfnA6QSlRRtGxIeKpQBKGE5JdQ0dU8VftTKtLYmBSymm8D1K0e0Oxenee+Q/SdVqdjIuUyS3C9vlc+L37R02L1fwt7Bv1vQ5dxwioF6GW95WWL2K2OCeW+++0aQjGerRdNajnNHK3pjzK0XZMXYmhp5DjMKxKqOini4C30wFEiUBuJkp0655in26NfGapGj/MwxKNJPkhOME3uRiRCkI4lcPJWGEfzxz8IF76zcipZWBitI2M2M+/v5yY/yddcvMViQCBbypWUmxdjVe/tUQNW/ffKTcu3oZeyh43MBo79pV9qcUTGjcThbwP38XGliXmqiVnQnaUXO5nFNfrnZh+LuCGGdkVgauqNWKDytf5iQ5GemLWKYsWKskglJuJDNpBk5M3LfdjrkQP3FjT3wtIDx8DB+bubyEgUPzfuapMVip3h0COsLTxMqYUi0mkXAqj2y381pJuOmMUwnkWLf+MrzS41Yx67a+NAJ2yQhT7krDjb8oBIgpSV8SM2PjVXMBGv4rFoeCkF/Cjr0lXXn1XYuVcJfANUA+U2EW4Fv/TGFdKaysJeyjJ/sXqXzBoDhTmky4hh9QbpHm9HNgKkl86v7Ss6lixdjrzlhXmR6lSRgB1Q
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39840400004)(346002)(376002)(136003)(396003)(451199024)(1800799009)(186009)(5660300002)(66446008)(36756003)(66946007)(76116006)(66476007)(64756008)(66556008)(4326008)(41300700001)(8936002)(8676002)(7416002)(44832011)(6512007)(2616005)(6506007)(316002)(2906002)(38100700002)(71200400001)(122000001)(83380400001)(38070700005)(54906003)(6486002)(110136005)(86362001)(478600001);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cmxFU1hFR0pvWTJFLzFmTW5NbjRaT09Pby9zK0NEWHJjdUZUajcweEVPblNL?=
 =?utf-8?B?ZEZKS0JxK0xMQnFKeDV2NFNBWnAxdk9oeGx6ckx5SU5BWEhEcE5BNlZmeGZ5?=
 =?utf-8?B?dWRjZmhkUlJSQkxsTHZSVWNiNk4zUGVUVFdzU1ZaRWQzZmJ3REI5UUpUMHd5?=
 =?utf-8?B?anRDSy9pOTRyeEQ5d1JEelBiMjdqRFErVjc4cXZlaDZ3M25YRnRjc2dFNzVS?=
 =?utf-8?B?WHFCNU9hTytweUZEbHFCM2puSWtXZHAycnExWjJNd2wzUDFXVUdXbkNlUUo1?=
 =?utf-8?B?eTBLWklkSnZHbjhxSEMya3o4RTgrS3IxRWx0UHRZZU5XaXozL1VIMEp5UnRK?=
 =?utf-8?B?MldnYUlQaHQyTUZVZFVPcUxwb1NGNGhCcERSUk1XOTZKQ1lYVUdBaTcrOWtN?=
 =?utf-8?B?NzdseEdKQ0w3S0Q1eThXTUJlbHh0TU50SmgvL2dWS3d6OHh4Y09zOHdBNDYy?=
 =?utf-8?B?N2dtRFBuMmhmemZ2bExvU0VYYWZySzd1RGFEQXhETVlyWTFVS3A3YVJaZlRV?=
 =?utf-8?B?VXcyblBYU3RoMmthTHdjMHMxK3E4R1RzKzdDUXY4ZXFLeVV2TnFiMExzQnli?=
 =?utf-8?B?WHJ5VmpvbU5iRHUzd0FiOWxMUUlOYy81NUlZc1dLZGRxaVlXdDhCdWVpbG8x?=
 =?utf-8?B?RGJBOWNONGcrbXlnam5kMWFDTEkwMmN0VTNpblpVK0RaZ3Q3KzZiZXpMN3Ix?=
 =?utf-8?B?TU9ZTVBEZ3RlbEpaazFtR2kya1BoWWlwamgrZjhaSkxNMHUxdFpFTjN0UWlo?=
 =?utf-8?B?eTMxM2ZDaWlocS8rd0NsT0IzL2VuaFZDeXRwV0d2dGxFWUlTU0FKWk9iemdq?=
 =?utf-8?B?OE9BS0dHSGx3eVNoNmJRMjNYRlV6ejA4Q0NHbzVKNGdmbithUlNkM1BmTVlh?=
 =?utf-8?B?c3VITFVTR3Y3WVgrdGNwYVpaOFBuTE5PU005WmpoQ2puczdUWTlDZ09Ici8y?=
 =?utf-8?B?QnB3ajU1YzEwWHFxZ0NuN3gzNTdMSnhLdWhDVnpIUCtaeGFUdVloTXhhT1V5?=
 =?utf-8?B?OW8wNndMazZYM091TUpYNlV3TXhyRmZwOVk1Vzc3ajFWM2hsczhYOXl0Zzln?=
 =?utf-8?B?OFkralJsUkNya3dIc0FIbitvczN5Z2tQazdmeTB5cFlKdHNzV1dWNktnUWdD?=
 =?utf-8?B?VUN6cTlBdGtmQ0Y3UGdPVk0zeWJzZGxlQ3V5VERSSm00WDZjRGlGRC84SCtx?=
 =?utf-8?B?K2I5NGZJcmI0L2VWaG9tYkovUjB5OW9jQjhJZTJNMnQ2L2htN0F1MU5XTURm?=
 =?utf-8?B?c09nY0x0L2NBcHRBZkU5aGllMk8raHBoa2RPZnZleGtwOStMcUJTK2tObnU4?=
 =?utf-8?B?SjBoSVJyRGt3WHpJY2NtRkNBai9TUURmb3J4SlZhUGxjMllIcDN5TFZ5VHRN?=
 =?utf-8?B?YmJVcXdaU1U3NUJFSTdJcVdqbmhtWVJUUHRmNTdJWVFZbUlvVWRyR284VGpH?=
 =?utf-8?B?YWp2dCtFWks0bnFJbmhjWnFBeVNmVjBDWTRWMjJVc1VMY2dZQTZ3UzE1bk1a?=
 =?utf-8?B?TGtnR0lLUnQ1L0tzYkZNNmV2WkxReDRUZ1Bxb2ZzdGJ2SU1qcUZmWk1LQVgy?=
 =?utf-8?B?WVpBS0Z2SnNHSjN6TW0yZTVnekJUQnoyaTUzSzNTV0tuaGppRWRkcFBGSUNR?=
 =?utf-8?B?MXNJaUVubjY1b1M4eFdIQUIrZVdJdlRCVndUUnViMjVnZDgxTkxDREc2bXNR?=
 =?utf-8?B?NDdXRzhaSUUxZGRIMW5hNVJFUDYxbTBVOGdYcFBJdXM3T28vRDExZ2JiRlBm?=
 =?utf-8?B?Z2Z3TEJmRitRNi83VTZTSDA0bTVJdDhRRzNhMENISVBTRzArRnYwQ2pMVWJh?=
 =?utf-8?B?czE1QWJ6TEVIQ1N2VWp5R0lBVFJiQ0hpemRidDVsSXEvTVh2bnNtN3p5b2tF?=
 =?utf-8?B?cmk3bk9mNXoyVllrSHdXVEtOWlluNkV0RzVENEs0M2pwUWJ3U2RPb0J4QXlR?=
 =?utf-8?B?S0hoYmFuaVVrVWxBYW5rcFkwL2srTlpHYWtRWjhuN2xKOE45RWRKSE9jbkZ4?=
 =?utf-8?B?Ym9sVWxXd2NzMnI1Rm1BWXBDVjlySDlieGhiK2p2SlppUjQ4NFloQURtZnNQ?=
 =?utf-8?B?SDcyeWhtaEZuRXlreWpVTzVhbTVReXpOLzlEZ0ZvQzc4MVFXV09zblI2Z2o5?=
 =?utf-8?B?ejVDSnVabDVqbS8zYzBsbjdFMlVoNWo0bDg4ZCtHY2YzWXFJUm02THFTekg2?=
 =?utf-8?B?NS9kYndKVjUzdmZVcUFkQmg3MzN0ZFR0RHVJcExjdCtDNSt2cTl2a1AzaUZm?=
 =?utf-8?B?M2E5bXlRdVBMenJWWXBpaXllRWRRPT0=?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: c94ab03d-018c-4c64-1fd3-08dba4a25acc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 13:02:21.7832 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dbpzL6WgAKxY7Ne8tO2llSOE1ore8IsYfCnY4MprXQxlz5fOJCgkx1FTCJS1E5vxcqtXQaYtxBaA7YnZ4R8D6O+PuQgj2PZ0R33f0eHGfsU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB1078
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <56D4E96E68155E4C9BA3690DDF1319CB@CHEP278.PROD.OUTLOOK.COM>
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

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDA3OjA1IC0wNTAwLCBOaXNoYW50aCBNZW5vbiB3cm90ZToN
Cj4gT24gMTA6MTMtMjAyMzA4MjQsIE1hdHRpanMgS29ycGVyc2hvZWsgd3JvdGU6DQo+ID4gSGkg
TmlzaGFudGgsDQo+ID4gDQo+ID4gT24gbWVyLiwgYW/Du3QgMjMsIDIwMjMgYXQgMjI6MTAsIE5p
c2hhbnRoIE1lbm9uIDxubUB0aS5jb20+IHdyb3RlOg0KPiA+IA0KPiA+ID4gRHJvcCB1bnVzZWQg
bWFjcm8uIFRoaXMgd2FzIG1lYW50IGZvciBhIHNlY29uZCByZWdpb24gb2YgRERSIHdoaWNoIHdl
DQo+ID4gPiBkbyBub3QgbmVlZCBmb3IgQU02MnggZXZtIGNvbmZpZ3VyYXRpb25zLg0KPiA+ID4g
DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBOaXNoYW50aCBNZW5vbiA8bm1AdGkuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiBOZXcgcGF0Y2ggKHBhcnQgb2YgYm9vdHN0ZCB0cmFuc2l0aW9uKQ0KPiA+ID4g
DQo+ID4gPiDCoGluY2x1ZGUvY29uZmlncy9hbTYyeF9ldm0uaCB8IDMgLS0tDQo+ID4gPiDCoDEg
ZmlsZSBjaGFuZ2VkLCAzIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IFdoYXQgYWJvdXQgaW5jbHVk
ZS9jb25maWdzL3ZlcmRpbi1hbTYyLmggPw0KPiA+IA0KPiA+IEl0IHNlZW1zIHRoYXQgdGhhdCBi
b2FyZCwgd2hpY2ggaXMgYW02MnggYmFzZWQsIGFsc28gaGFzIHRoZSB1bi1uZWVkZWQNCj4gPiBp
bmNsdWRlLg0KPiA+IA0KPiA+IFNpbmNlIGknbSBub3QgMTAwJSBzdXJlLCBJIGhhdmUgYWRkZWQg
TWFyY2VsICh3aG8gcG9zdGVkIHRoZSB2ZXJkaW4gYW02Mg0KPiA+IHN1cHBvcnQpIGhlcmUuDQo+
IA0KPiBUb3JhZGV4IHRlYW0sIENhbiB5b3UgaGFuZGxlIHRoYXQgY2xlYW51cD8gSSBzdGF5ZWQg
Zm9jdXNzZWQgb24gYW02MnhfZXZtIHNpZGUNCj4gb2YgdGhpbmdzLg0KDQpZZXMsIG9mIGNvdXJz
ZS4NCg0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmlncy9hbTYyeF9ldm0uaCBiL2lu
Y2x1ZGUvY29uZmlncy9hbTYyeF9ldm0uaA0KPiA+ID4gaW5kZXggNDQxODBkYzc2ODdiLi4zNzll
MGMxM2EzOTUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL2NvbmZpZ3MvYW02MnhfZXZtLmgN
Cj4gPiA+ICsrKyBiL2luY2x1ZGUvY29uZmlncy9hbTYyeF9ldm0uaA0KPiA+ID4gQEAgLTEyLDkg
KzEyLDYgQEANCj4gPiA+IMKgI2luY2x1ZGUgPGNvbmZpZ19kaXN0cm9fYm9vdGNtZC5oPg0KPiA+
ID4gwqAjaW5jbHVkZSA8ZW52L3RpL21tYy5oPg0KPiA+ID4gwqANCj4gPiA+IC0vKiBERFIgQ29u
ZmlndXJhdGlvbiAqLw0KPiA+ID4gLSNkZWZpbmUgQ0ZHX1NZU19TRFJBTV9CQVNFMcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoDB4ODgwMDAwMDAwDQo+ID4gPiAtDQo+ID4gPiDCoC8qIE5vdyBmb3Ig
dGhlIHJlbWFpbmluZyBjb21tb24gZGVmaW5lcyAqLw0KPiA+ID4gwqAjaW5jbHVkZSA8Y29uZmln
cy90aV9hcm12N19jb21tb24uaD4NCj4gPiA+IMKgDQo+ID4gPiAtLSANCj4gPiA+IDIuNDAuMA0K

