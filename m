Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16B9FC4706C
	for <u-boot@archiver.kernel.org>; Sat, 13 Jan 2024 18:40:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 679D8878D6;
	Sat, 13 Jan 2024 19:40:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="fpLXOosY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8238487883; Sat, 13 Jan 2024 19:40:27 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5C27B87930
 for <u-boot@lists.denx.de>; Sat, 13 Jan 2024 19:40:23 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1705171222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pV/fCL/jrFv6rvW4NFJyoUc9O7gKoAfbci6iu2m+lgQ=;
 b=fpLXOosY04fjlbAH59aTSThxt5OLsUlWLCVBWXmQD81W89oZ821bRsHHZoVFA8N8Msp7XY
 twmYhKe3hox0f5raPba6me+dzSKg3SHZKLiPqSU0C2fmL1p2xe7mDY1rLiZnbUUs1dB6Np
 FwneEg5FlNU/AJAYn1A6+wzIBQ75BG0=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-68-XooUEh1hMfm3qqBZVk7ODA-2; Sat, 13 Jan 2024 19:40:21 +0100
X-MC-Unique: XooUEh1hMfm3qqBZVk7ODA-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0147.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:2e::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.23; Sat, 13 Jan 2024 18:40:19 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::8a78:db00:599:55ae%6]) with mapi id 15.20.7181.022; Sat, 13 Jan 2024
 18:40:19 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "marex@denx.de" <marex@denx.de>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
CC: "festevam@gmail.com" <festevam@gmail.com>, "philippe.schenker@toradex.com"
 <philippe.schenker@toradex.com>, "uboot-imx@nxp.com" <uboot-imx@nxp.com>, 
 "sbabic@denx.de" <sbabic@denx.de>, Francesco Dolcini
 <francesco.dolcini@toradex.com>
Subject: Re: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Thread-Topic: [RFC][PATCH] ARM: imx: verdin-imx8mm: Set CAN oscillator
 frequency based on model
Thread-Index: AQHaRk8b7q9nT4USlkCbVS4Y38x5ibDYE4EA
Date: Sat, 13 Jan 2024 18:40:19 +0000
Message-ID: <e07c0ace3d9db05e80795a949a449506d7a3247e.camel@toradex.com>
References: <20240113183350.176131-1-marex@denx.de>
In-Reply-To: <20240113183350.176131-1-marex@denx.de>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0147:EE_
x-ms-office365-filtering-correlation-id: e0753bee-d1f3-44bf-a11f-08dc146717a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: YnH1CuJZgFfO4AL66hnPI2O6jWdY0VVNTzS86E9Kpgdnj9Qp3cXDH9B5YDZhyHdsQOWtDOxmhAON9GBt8ZbSOQx/EABEB+vGYMZq6p4yScozs5b9pMwXbvKsN7N6Qe/DcQvaQHOkPksv0oxTlEeQV+yShYgQoTAtpW2wm+PIb3lPsm3AT8MhzVjL3oXtHXlbqrXoVo6atRXJUbIzmxhoJeI6tpwrw5rGs0VWY+lZWu73sjCcPWLIx5ZbSt++RMf0NMuInsDSHQceZ1WFtXHjULXzsuB3CRuyAZANFR2BTzEhGjhnl1kIwt0Eec4isRfPF4xquVStLgVxMxMIBHgyeDOCmz0M08OEpz/xY803kZTfmzY/gHQfBesoiXms9wgdy5Fh4/Ek+BS2roloqJtPDxJz0ibyj1mzyUHTgrx31iggtQ+Vhv52qqRZ8qL89ci9b/texbS61Ep62mXBGRQoKac8f3cLjAF9dhgB2OIkaIeoci2Z8stnJ1iMNM33v1OadJt2cSSbbEY+bAZGfVHzoL4SKwkPinzzalNWufsPkxSLStlF3RegpnMALsKIiGg6K9rPI3JSov2L9/vdFtkFjFVJe0Re+vUebgcH2HTRjD6e1gxzgELhudLX9I5TvIhQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39840400004)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(2616005)(6506007)(478600001)(71200400001)(6512007)(107886003)(26005)(38070700009)(38100700002)(86362001)(36756003)(122000001)(4326008)(2906002)(5660300002)(83380400001)(6486002)(8936002)(44832011)(41300700001)(66476007)(54906003)(64756008)(66446008)(110136005)(76116006)(66946007)(8676002)(66556008)(316002);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWhicU03d2pTRXJEMEduUHhKaE1Ndk9tZVY1MUJxRmFNWVdRcURQa1RyRGwr?=
 =?utf-8?B?VG5pQTBiT1FRYmc5OEZDSFNOWWl4djNpRlB0ZUwvN2s5WjJLYmw4RG9LcFl5?=
 =?utf-8?B?S1hqcXgxZncyQ1ZIYkVtTi8rWjNzeW1ZdmE2OW5icUhlYks2cldMUFpuSFVS?=
 =?utf-8?B?bFdlbUdURGJwdy90N0xLWkZkb2MyY1ppWGU4cFFpY2x0dEVXTnhReG12K2Jt?=
 =?utf-8?B?b0tHajhXNFp0WUNlNjg4Q3ZkaUtnbnBmYitZRHgyZU1XUEYxQTNpMDhGZm1u?=
 =?utf-8?B?cWJIMXhta2xzbXB5VjBGWkRQNlYxc0wzc3FhVzVQa0F1Uyt4YmR5eFY1b0NO?=
 =?utf-8?B?T0NmU3BBMm9STFhWeFpuTUdpbnRSZWx0djgyNUNVWmdaa0trZXJIc0IwR2sz?=
 =?utf-8?B?NStrcmppenQ0Z1JSUUxMWUh5VWtJekg1Ym94TzhMVk1QdjB3R2RER2ErS0hq?=
 =?utf-8?B?Mms1Z1UvZGZHNkpFSWdkeW9tQ2Erb3p4a2pOYWdTdzJ2aVFUTjJiOEM4RTlv?=
 =?utf-8?B?R0tPeXBLcE9zYnIvVTk0T0FaaExiNkpNa2lpdjZVajhXdHJwcWdKOVkwM0Nl?=
 =?utf-8?B?dmlHd09mbXREZHJHTG1XOWwvWVpPWkpzL2oyVDh6TGd3RjNNNHdFZjBJdHZp?=
 =?utf-8?B?c0h5MXFEM2RMSVd4TFNGNVJCck9vM01hSUdXaGhLNE5wTkw1bVZOak1sdndI?=
 =?utf-8?B?L1hHdEZSZFdSU0JhbUxnSTZJeVhFVWp0YVRSay9HRGdseG1mSFFQOUY5QXBC?=
 =?utf-8?B?REJrSGdGN082WVNkeVJNZnpSZmRaWG93cGw0c1o2VWhLVGtEWWI5SlVTVjJI?=
 =?utf-8?B?M1RZc3dleEJwYS9lL1NRWU1qUjQzY1dsVlZOZ0JKUUVSeFNTUWtEd3FnQ1ZS?=
 =?utf-8?B?RXRERGNrQVUvM3JQOFdET2dFV080dWtHc2VMTEhkcVlOeHJ2dnc1M2tQNmF2?=
 =?utf-8?B?bE4rcnArUCtOTGRBc2JQb2EvMW1yZDIzckcxeTVoaWdpSVFvazd1WEVoRVRx?=
 =?utf-8?B?UnhlR09ORFpUd21yTSs4UEk4R0JRTlIzSUlJOTBGd1JvaGNQQWp3SjZEaHBF?=
 =?utf-8?B?TnVKYW12MVZIcmFpdVNQOE9CQWJVQ2IvK1RKNUoreXlqMHlzL0JHdjY0QUc5?=
 =?utf-8?B?Y0QyOTk3M1RKc0cxRjV2eEFIdFlCbFhQbVUzK2tlSnJpakErZE1yaHZRRmU1?=
 =?utf-8?B?bXFidm8zWFdYZFRTT0k5Tmw4dkllci9YSVY1cVhOZ0t3TGZ4bWJvUzVMWDRh?=
 =?utf-8?B?VDE4MmtZRDNjUTdIZDNlUHlMQXdidkpwMEd5WDgzZTl5ZU56UE9GSHNtMlpt?=
 =?utf-8?B?dDMyWmFhUEVVc09KQU9uODlTbXhtQVVUbHVMaXVSb3hjVU9KQjMza2VOQXVs?=
 =?utf-8?B?WmJNVjhjRWszSEp1dXppU3kwb0pIVUNtQk4xcUFxeDh2czU3UTdZU2RxaWpR?=
 =?utf-8?B?cmt2eStuMHU3Rk9pZnlzdE9qVXFEdUNYdjhZNXRYUlR5UUtPcFhjUWFkeFMz?=
 =?utf-8?B?ZFNLdUlqODROMHlFUG5EMnlENDV1UGthbWJzUUx3NzVvVXQ5R20yMlRLZ3VQ?=
 =?utf-8?B?VlpCVWFndndqdlFUcTFMSC9HRk1jMUJ5R3M1emFYcjd3MENFNThZRk91bnJ0?=
 =?utf-8?B?NitTT0NpWGY5V3c1QThmYjhuUVFkaDdsNU5kSkgyT2duK0lscUlmQ2M2SmVC?=
 =?utf-8?B?cWRoeHJQM0xXdWVxVWFLWGMzTHcyaXhETXhnQk03VnlqeXBId0lIWFl3REwx?=
 =?utf-8?B?ZGpDZitGcVJyS1BDMWY0RXJLVEZ5dk9nb3dGMDY5VFNxNnJrUGtqYjY3Y3gw?=
 =?utf-8?B?SnlPd2FUT0FPU3N0OU9XcmFCRG1WVjN6K2FIZHpnVlRhdXZxZUNUa05iMzRI?=
 =?utf-8?B?dTkxSjl5NGtyU09EdFIwMDBrL1dES0gydzBxTDBvSVFVaHBZdTIwYWJRQXVV?=
 =?utf-8?B?b3laVU56TGgwM2RFSjZjREFna3o4ZVN4bXUvNzY0dU51MmdRVHRuellMN015?=
 =?utf-8?B?cGQxRk1TT01GbDE5UHAyM2p6aTVzR1I4VHduUTJ2YmI5aHBiOTJmNFZrMUEz?=
 =?utf-8?B?WFQzZmd5dzhhR3pSbDViL3VINDBYSEoxeXNxUjNVcWw3dDBDQWN1RXI4eUV3?=
 =?utf-8?B?N3hDRGQ0TDhPQXVYREE1ZS9kU2djKzZwNCsvbGhYRjNudkFsNzRhU1JpK3hh?=
 =?utf-8?B?Wmc9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: e0753bee-d1f3-44bf-a11f-08dc146717a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2024 18:40:19.0786 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /71bEKl4yvHsj14h+shV+HvOC3ddJFjzVhrgs1Q351/p3ogT1n8HguE+nLHePAZYuMX7pXbwImhxv33/lKQuWEeLKvHI6BigXsBM/wxiP8A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0147
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <9CA054CF793E584FA8AFCBB4D36B5F13@CHEP278.PROD.OUTLOOK.COM>
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

SGkgTWFyZWsNCg0KVGhhbmtzLCBzZWVtcyBsaWtlIGEgZGVjZW50IGlkZWEuIEkgZ3Vlc3Mgd2Ug
anVzdCBkaWQgbm90IGRvIGl0IGFzIHRob3NlIHByZXZpb3VzIHJldmlzaW9ucyB3ZXJlIGp1c3Qg
c2FtcGxlcw0KYnV0IHdpdGggdGhpcyBjaGFuZ2UgY2FuIHN0aWxsIGJlIHVzZWQgbXVjaCBlYXNp
ZXIgKGUuZy4gd2l0aG91dCByZXF1aXJpbmcgbWFudWFsIGludGVydmVudGlvbikuDQoNCk9uIFNh
dCwgMjAyNC0wMS0xMyBhdCAxOTozMyArMDEwMCwgTWFyZWsgVmFzdXQgd3JvdGU6DQo+IFRoZSBv
bGRlciBpLk1YOE0gTWluaSBWZXJkaW4gU29NcyBiZWZvcmUgcmV2LiAxLjFDIGNhbWUgd2l0aCAy
MCBNSHogU1BJIENBTg0KPiBjb250cm9sbGVyIG9zY2lsbGF0b3IsIHRoZSBuZXdlciBTb01zIHVz
ZSA0MCBNSHogb3NjaWxsYXRvci4gSGFuZGxlIGJvdGggYnkNCj4gb3ZlcnJpZGluZyB0aGUgb3Nj
aWxsYXRvciBmcmVxdWVuY3kganVzdCBiZWZvcmUgYm9vdGluZyB0aGUga2VybmVsLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+IC0tLQ0KPiBDYzog
Ik5YUCBpLk1YIFUtQm9vdCBUZWFtIiA8dWJvb3QtaW14QG54cC5jb20+DQo+IENjOiBGYWJpbyBF
c3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+IENjOiBGcmFuY2VzY28gRG9sY2luaSA8ZnJh
bmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IENjOiBNYXJjZWwgWmlzd2lsZXIgPG1hcmNl
bC56aXN3aWxlckB0b3JhZGV4LmNvbT4NCj4gQ2M6IFBoaWxpcHBlIFNjaGVua2VyIDxwaGlsaXBw
ZS5zY2hlbmtlckB0b3JhZGV4LmNvbT4NCj4gQ2M6IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54
LmRlPg0KDQpBY2tlZC1ieTogTWFyY2VsIFppc3dpbGVyIDxtYXJjZWwuemlzd2lsZXJAdG9yYWRl
eC5jb20+DQoNCj4gLS0tDQo+IMKgYm9hcmQvdG9yYWRleC92ZXJkaW4taW14OG1tL3ZlcmRpbi1p
bXg4bW0uYyB8IDE5ICsrKysrKysrKysrKysrKysrKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMTkg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2JvYXJkL3RvcmFkZXgvdmVyZGluLWlt
eDhtbS92ZXJkaW4taW14OG1tLmMgYi9ib2FyZC90b3JhZGV4L3ZlcmRpbi1pbXg4bW0vdmVyZGlu
LWlteDhtbS5jDQo+IGluZGV4IGIyNzgxYjUxZDZhLi44YmMxYTUxZWViMSAxMDA2NDQNCj4gLS0t
IGEvYm9hcmQvdG9yYWRleC92ZXJkaW4taW14OG1tL3ZlcmRpbi1pbXg4bW0uYw0KPiArKysgYi9i
b2FyZC90b3JhZGV4L3ZlcmRpbi1pbXg4bW0vdmVyZGluLWlteDhtbS5jDQo+IEBAIC0xNDIsNiAr
MTQyLDI1IEBAIGludCBib2FyZF9waHlzX3NkcmFtX3NpemUocGh5c19zaXplX3QgKnNpemUpDQo+
IMKgI2lmIGRlZmluZWQoQ09ORklHX09GX0xJQkZEVCkgJiYgZGVmaW5lZChDT05GSUdfT0ZfQk9B
UkRfU0VUVVApDQo+IMKgaW50IGZ0X2JvYXJkX3NldHVwKHZvaWQgKmJsb2IsIHN0cnVjdCBiZF9p
bmZvICpiZCkNCj4gwqB7DQo+ICsJY29uc3QgY2hhciAqY2Fub3NjcGF0aCA9ICIvb3NjaWxsYXRv
ciI7DQo+ICsJaW50IGNhbm9zY29mZiwgZnJlcSwgcmV0Ow0KPiArDQo+ICsJY2Fub3Njb2ZmID0g
ZmR0X3BhdGhfb2Zmc2V0KGJsb2IsIGNhbm9zY3BhdGgpOw0KPiArCWlmIChjYW5vc2NvZmYgPCAw
KQkvKiBObyBDQU4gb3NjaWxsYXRvciBmb3VuZC4gKi8NCj4gKwkJZ290byBleGl0Ow0KPiArDQo+
ICsJaWYgKHRkeF9od190YWcudmVyX2Fzc2VtYmx5IDwgMinCoMKgwqDCoMKgwqDCoCAvKiByZXYu
IEEgb3IgQiAqLw0KPiArCQlmcmVxID0gMjAwMDAwMDA7DQo+ICsJZWxzZQkJCQkJLyogcmV2LiBD
IG9yIG5ld2VyICovDQo+ICsJCWZyZXEgPSA0MDAwMDAwMDsNCj4gKw0KPiArCXJldCA9IGZkdF9z
ZXRwcm9wX3UzMihibG9iLCBjYW5vc2NvZmYsICJjbG9jay1mcmVxdWVuY3kiLCBmcmVxKTsNCj4g
KwlpZiAocmV0IDwgMCkgew0KPiArCQlwcmludGYoIkZhaWxlZCB0byBzZXQgQ0FOIG9zY2lsbGF0
b3IgY2xvY2stZnJlcXVlbmN5LCByZXQ9JWRcbiIsDQo+ICsJCQlyZXQpOw0KPiArCX0NCj4gKw0K
PiArZXhpdDoNCj4gwqAJcmV0dXJuIGZ0X2NvbW1vbl9ib2FyZF9zZXR1cChibG9iLCBiZCk7DQo+
IMKgfQ0KPiDCoCNlbmRpZg0KDQpDaGVlcnMNCg0KTWFyY2VsDQo=

