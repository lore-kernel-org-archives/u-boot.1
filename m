Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2D1EC0032E
	for <u-boot@archiver.kernel.org>; Sat, 28 Oct 2023 08:10:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CF27487836;
	Sat, 28 Oct 2023 10:10:25 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="X7jnjQC8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C41487838; Sat, 28 Oct 2023 10:10:24 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F25C787817
 for <u-boot@lists.denx.de>; Sat, 28 Oct 2023 10:10:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1698480620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ipthTY9BfYhhJuUDEO71KiOz1qfmVVAdJ8bpyeDm9kc=;
 b=X7jnjQC8fDtyoId06KOJz1Lbb3ZwFUJC+/66mhNp3uWDOe283eRtPaVramF2hdsdJ+GL/O
 bJkyYI8/ortRbv56WxIZk1VjVclXO3GDUmU8ZWmUNYHWXZtAE6O+TtwFvrnT+NzxBCzK7f
 +PSBeNVOPPBklNfdJthBNyjsyXU8kTI=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-64-eUyCIFlnMHeUeiZEvDh5OA-1; Sat, 28 Oct 2023 10:10:18 +0200
X-MC-Unique: eUyCIFlnMHeUeiZEvDh5OA-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 ZR0P278MB1154.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:55::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.23; Sat, 28 Oct 2023 08:10:16 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::a3b:50bf:57a:b96b%2]) with mapi id 15.20.6933.024; Sat, 28 Oct 2023
 08:10:16 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "rogerq@kernel.org" <rogerq@kernel.org>, "nm@ti.com" <nm@ti.com>,
 "trini@konsulko.com" <trini@konsulko.com>
CC: "s-vadapalli@ti.com" <s-vadapalli@ti.com>, "r-gunasekaran@ti.com"
 <r-gunasekaran@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "srk@ti.com"
 <srk@ti.com>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH 1/3] arm: dts: k3-am625-sk-u-boot.dtsi: Update main_bcdma
 and main_pktdma nodes
Thread-Topic: [PATCH 1/3] arm: dts: k3-am625-sk-u-boot.dtsi: Update main_bcdma
 and main_pktdma nodes
Thread-Index: AQHaCNwGaZSt9apmdkmiD57eLJayaLBe2qMA
Date: Sat, 28 Oct 2023 08:10:16 +0000
Message-ID: <4e0911734e574ace2f9edbac9b7f49c1ee4515e0.camel@toradex.com>
References: <20231027134630.244886-1-rogerq@kernel.org>
 <20231027134630.244886-2-rogerq@kernel.org>
In-Reply-To: <20231027134630.244886-2-rogerq@kernel.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|ZR0P278MB1154:EE_
x-ms-office365-filtering-correlation-id: 0362a9d9-5be8-4974-ab55-08dbd78d5193
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: hXRutH8QGotZHsQwNR4oOMd2l7oIb15c3hfuIP5EZHpIe5quxVL1AflnDptKKbd23kYMldK7gL9LRFWGW4fFY7gg5ep87utFOG4ZaIs9rP7l/uweKr3p4QEfIrVPmxAjtX0Hp1gsmVHV2mWDcyhZWuFivfN4IuMRyJYRE/0tcC5X0v5/WSMWZEI+MBmSxFvKiX8oTfB7cnpoYrEnpx4zDWISekPdcteLbLHLPe3xznoHy0jyNHGi+RyPVyPJTfP5y4+lesimRsHs69/AZjjG0hs/Akuwoe5o3vp+4okmr5Z9YzesrfdXGl6mdmpK+eeJA25QHSOeWhM2MzLU4kiU2ZFSRsb019/PiFQ1weQinWg6aVn9Z6eRCXtlAd4/Dr7GPT1dmswjJ4cOFdkHVenz26ZnpN2oAzmL1ToCfAphFcz3g/rw/4jaIPG5Fc9BqsW5OAc+WSPm2XQdUl178EUzCOfm63xmf4opnRXc1oM2UlPiKnhvBOsjZsKMIGjRg11sHopzsmZVt0Qk5yS59Ga3oNFtRPpens6i0Bxo0xxyUFXSXVVAlVgv/uI8iFC/4l6sr5nfAxXefbEi+SL4wJBdpwmUATuFGp6gG2vaJpCig/DI+8nVKx5u98a5HyfaIEUp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39830400003)(366004)(396003)(376002)(346002)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(478600001)(71200400001)(6486002)(6506007)(122000001)(36756003)(38070700009)(2616005)(26005)(6512007)(38100700002)(2906002)(83380400001)(15650500001)(44832011)(5660300002)(8676002)(8936002)(86362001)(4326008)(41300700001)(66476007)(66556008)(76116006)(66446008)(54906003)(64756008)(66946007)(4001150100001)(316002)(91956017)(110136005);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MU5QaktwVzdFQzVFUEoxODVSYkpHam5uUmdVOU94MkpkT0FHY2JldVFSZlFZ?=
 =?utf-8?B?clBuN04wMFY5TDhrM2pXZHNGVW9qdGlCTUdJNTA5Rkw2ZHo5cWc5WlhsZHpD?=
 =?utf-8?B?dVFIcUs0cXlHRW81bnE1dnQxMld2ejZ3NStOWll0dUVEaTR4ZnFML3g2eWZE?=
 =?utf-8?B?N1JVZ2k3b3ViWkVpVG43aGkyL0h6aVRvbFdXb2VJSnNIZHVrS0Nua0pRMXpI?=
 =?utf-8?B?U3FSWTFqb3JybEhsdHdkdE0yYmloaXdPVEZ6K29IQUZDRzNCRTJESVQ2STZZ?=
 =?utf-8?B?bE0zZEdodi9ZMWpEVHhyK2dlbkZkeVVwYjZ4UTdrOVdCWEwyUjM4b3lzY0hk?=
 =?utf-8?B?cGdCS2Uvem9QSzZaNFQ2OHZIYzR5WjFpTXNNajBCamZXbys1anp4TURaZkgy?=
 =?utf-8?B?dE9mQkwyTGhSeldZNTljcW5EYmFJb3pvdm9DT3BVNkkwR3JvczBJMHdneEpv?=
 =?utf-8?B?RHM3bS9ZZDZiVUQ3QzBGQ3QrSWE4aEFCK1UzQTFkOW5TY0lXMUNqcmNzVlQy?=
 =?utf-8?B?QVhFL1MvbE5WNjJBaWlHdEV6TlNKald1YmlqeG5wZURpcDVnM1hSMU9yV1Y5?=
 =?utf-8?B?S0dJcTlreDYwWG40cEh6aFRsUFlVU0hXWDYyKzVtcjZMOFMrMjFwTS9KMytH?=
 =?utf-8?B?MTJHcTUyU0plNHBDZ2QwbmpFUmVaQnd3Y28rUXJXYmhIakRyZUxvZElXTDh1?=
 =?utf-8?B?OVc2MWpzbTJTNWVhS1g1dUY5eS84bFRYTENSV3oveXlSVWZJVFJSNzZzbFU3?=
 =?utf-8?B?SkFIdDVIUndZMkE4NFJ3c2VxakxUOGVJZngwZzk3dmNSQnh3MDR2MXVyWEd2?=
 =?utf-8?B?RmwwN1k2enN0V1UrK0Ixd0M2QkZQTUthVmxhV1FYK0l2WXBXVXNmazJtdFdt?=
 =?utf-8?B?TnlGamlKazhxU0ZCMUp3WHNhVzBhdVQrS2Y1eTVKYWRUNW9lVmo0M1VDakt4?=
 =?utf-8?B?YisvYzU1aldMc3M4cFlqVkoxT0FydnZNNVFoSDZZS1J6bjZTZmN0eUJPY3Uy?=
 =?utf-8?B?VUM2ODlRVHJMT2svczgvOUdBaUY1Tmw2VDlGUXNzMm1PcXd0dmNxTUEzYWxG?=
 =?utf-8?B?T3l5V2JQbEYrc2hIbDRqeEZ1azdYY2pJVVhyQTJ0cUg2TzRyLy8vM3pWc0Y4?=
 =?utf-8?B?M2NXa2xtVG5GY21ob0NqL1hDcDFuRzdVVU1yeXlWNnJuUURUVWZoa2Q2OHdQ?=
 =?utf-8?B?UkZaNXVOMk5ldTcvbnlNVXBIWE5CZ0FsakJPOVlMbGVKcTFNditGd3hWY2c1?=
 =?utf-8?B?ODhXSFJoMzJQT0tBRUtPNlJhU01mTHV0eEdJcWpRblJXK2NBcnlHS1ZOb243?=
 =?utf-8?B?L2U4QUJjbjBiYjRTVi9ISG5BT2RIcTVQQjUxUGZucnlxUXNSM1FodkExK1Nn?=
 =?utf-8?B?V3FTZFA4aDY4OGpBVHJyeC9GdVdBYXhwdE0vMEtOclhjeEp6R2RtelZ1Vmtt?=
 =?utf-8?B?Q2d6MDVhTTVuT0VmbHhwWUVOZkNqb2xTM3NsbE5TNVJvWjVzTnNNOFNXNDBs?=
 =?utf-8?B?THZzbGpzVGlDTlEwRzVvT1hzU1JRRFRiS09qRWxDMm9qTmRQNWNka2h4Q0Vw?=
 =?utf-8?B?TnVEeGFCNTJISndtd2M3VC9DMFhnUjdOY1RjWDAyWjAvbUFJZWhHQzJZY1d5?=
 =?utf-8?B?Wm1uLzJ1OEJENzMzK0I5elRaRUNMNUNYQURJTnpUQjYrTGM1Zmw1cDRydHFP?=
 =?utf-8?B?RW93OW04VldhR0xFbk5xVGZoTHdsY1JpT09XNDl0MGRwMWRWUWFxRWlwNjRk?=
 =?utf-8?B?d2xrSytyUm1vZUdZZlo0L292ek42UnVwSkRYYkV1VjlleFNWdUJxVnJhN2Rk?=
 =?utf-8?B?M1BPQXhtaHlvZmhMTWdiWUFzZ3N2Rm5FcGppU1dzTjRLMHdOQUZJNWluQzY2?=
 =?utf-8?B?NGVVRHdSYUk4VFdWeGo5VlJEUi95U2Y0Vmp5S084YkJkVk1zR3JBblNFUlVa?=
 =?utf-8?B?bkF1NExaaHcxbHovZnhMejdoVkhsWmlpOUFjQ1B6Qyt3ckNFZC9yZWxKaEJF?=
 =?utf-8?B?V1F2VlBLK3NiQUJMajgxcDg5TFlkOG9hUGJCRDJ0cGFmY3pOenRxYjBobCty?=
 =?utf-8?B?T3Q4SWJyUDJ3QmNQS0ttREVhZThJU2JqbFZ1a3BmckxqNTdNaE1VS3g3dmx4?=
 =?utf-8?B?RDh3S3EvZ1kyUm1DeGZqeit4S0Y1aU1iUG53czV0U0dTSjlpUWVrU2YxQ3BU?=
 =?utf-8?B?N3c9PQ==?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 0362a9d9-5be8-4974-ab55-08dbd78d5193
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2023 08:10:16.1430 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5hl4suK8rLk3Tml1oSp7oUIg1aW36UH2Ru2rJuBwfmIPHlXRDeYmQUR0n/R0BQIHEWFf4xBg2wZsp++loLU9pB1Rh2ukqh5QSvtSNaHa8GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1154
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <757FD4DAA9BEF449AE50557591363180@CHEP278.PROD.OUTLOOK.COM>
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

T24gRnJpLCAyMDIzLTEwLTI3IGF0IDE2OjQ2ICswMzAwLCBSb2dlciBRdWFkcm9zIHdyb3RlOg0K
PiBGcm9tOiBTaWRkaGFydGggVmFkYXBhbGxpIDxzLXZhZGFwYWxsaUB0aS5jb20+DQo+IA0KPiBV
cGRhdGUgbWFpbl9iY2RtYSBhbmQgbWFpbl9wa3RkbWEgbm9kZXMgZm9yIG5hdGl2ZSBjb25maWd1
cmF0aW9uIGluIHRoZQ0KPiBhYnNlbmNlIG9mIERNIHNlcnZpY2VzLg0KPiANCj4gUmVwb3J0ZWQt
Ynk6IE5pc2hhbnRoIE1lbm9uIDxubUB0aS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IFNpZGRoYXJ0
aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUm9nZXIg
UXVhZHJvcyA8cm9nZXJxQGtlcm5lbC5vcmc+DQo+IC0tLQ0KPiDCoGFyY2gvYXJtL2R0cy9rMy1h
bTYyNS1zay11LWJvb3QuZHRzaSB8IDI3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiDC
oDEgZmlsZSBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vZHRzL2szLWFtNjI1LXNrLXUtYm9vdC5kdHNpIGIvYXJjaC9hcm0vZHRzL2szLWFtNjI1
LXNrLXUtYm9vdC5kdHNpDQo+IGluZGV4IGI3OGQzNGI0NTkuLjcxODZmMDgzMGYgMTAwNjQ0DQo+
IC0tLSBhL2FyY2gvYXJtL2R0cy9rMy1hbTYyNS1zay11LWJvb3QuZHRzaQ0KPiArKysgYi9hcmNo
L2FybS9kdHMvazMtYW02MjUtc2stdS1ib290LmR0c2kNCj4gQEAgLTE1NCw2ICsxNTQsMzMgQEAN
Cj4gwqAJYm9vdHBoLWFsbDsNCj4gwqB9Ow0KPiDCoA0KPiArJm1haW5fYmNkbWEgew0KPiArCXJl
ZyA9IDwweDAwIDB4NDg1YzAxMDAgMHgwMCAweDEwMD4sDQo+ICsJwqDCoMKgwqDCoCA8MHgwMCAw
eDRjMDAwMDAwIDB4MDAgMHgyMDAwMD4sDQo+ICsJwqDCoMKgwqDCoCA8MHgwMCAweDRhODIwMDAw
IDB4MDAgMHgyMDAwMD4sDQo+ICsJwqDCoMKgwqDCoCA8MHgwMCAweDRhYTQwMDAwIDB4MDAgMHgy
MDAwMD4sDQo+ICsJwqDCoMKgwqDCoCA8MHgwMCAweDRiYzAwMDAwIDB4MDAgMHgxMDAwMDA+LA0K
PiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0ODYwMDAwMCAweDAwIDB4ODAwMD4sDQo+ICsJwqDCoMKg
wqDCoCA8MHgwMCAweDQ4NGE0MDAwIDB4MDAgMHgyMDAwPiwNCj4gKwnCoMKgwqDCoMKgIDwweDAw
IDB4NDg0YzIwMDAgMHgwMCAweDIwMDA+Ow0KPiArCXJlZy1uYW1lcyA9ICJnY2ZnIiwgImJjaGFu
cnQiLCAicmNoYW5ydCIsICJ0Y2hhbnJ0IiwNCj4gKwkJwqDCoMKgICJyaW5ncnQiICwgImNmZyIs
ICJ0Y2hhbiIsICJyY2hhbiI7DQo+ICt9Ow0KPiArDQo+ICsmbWFpbl9wa3RkbWEgew0KPiArCWJv
b3RwaC1hbGw7DQoNCkkgYmVsaWV2ZSB0aGF0IHByb3BlcnR5IHdvdWxkIHVzdWFsbHkgYmUgYWRk
ZWQgYXMgdGhlIGxhc3QgaXRlbSBvZiBhIG5vZGUuDQoNCj4gKwlyZWcgPSA8MHgwMCAweDQ4NWMw
MDAwIDB4MDAgMHgxMDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0YTgwMDAwMCAweDAwIDB4
MjAwMDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0YWEwMDAwMCAweDAwIDB4MjAwMDA+LA0K
PiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0YjgwMDAwMCAweDAwIDB4MjAwMDAwPiwNCj4gKwnCoMKg
wqDCoMKgIDwweDAwIDB4NDg1ZTAwMDAgMHgwMCAweDEwMDAwPiwNCj4gKwnCoMKgwqDCoMKgIDww
eDAwIDB4NDg0YTAwMDAgMHgwMCAweDIwMDA+LA0KPiArCcKgwqDCoMKgwqAgPDB4MDAgMHg0ODRj
MDAwMCAweDAwIDB4MjAwMD4sDQo+ICsJwqDCoMKgwqDCoCA8MHgwMCAweDQ4NDMwMDAwIDB4MDAg
MHgxMDAwPjsNCj4gKwlyZWctbmFtZXMgPSAiZ2NmZyIsICJyY2hhbnJ0IiwgInRjaGFucnQiLCAi
cmluZ3J0IiwNCj4gKwkJwqDCoMKgICJjZmciLCAidGNoYW4iLCAicmNoYW4iLCAicmZsb3ciOw0K
PiArfTsNCj4gKw0KPiDCoCZjcHN3M2cgew0KPiDCoAlib290cGgtYWxsOw0KPiDCoAlldGhlcm5l
dC1wb3J0cyB7DQo=

