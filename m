Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63467C2BB3F
	for <u-boot@archiver.kernel.org>; Wed, 15 Nov 2023 17:33:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B05A087209;
	Wed, 15 Nov 2023 18:33:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="Yt3ov9qz";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 53E2487284; Wed, 15 Nov 2023 18:33:43 +0100 (CET)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 478068704F
 for <u-boot@lists.denx.de>; Wed, 15 Nov 2023 18:33:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1700069621;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r6sOPYdWWotS+X+yufqe9OJMJIP20CCnDsSELCpUTMs=;
 b=Yt3ov9qzwGJGfYZ1f9yGJD8RqUq4mnFrcX8jTLk1/+LADKJ8QSPzfV14Nr6q4YjX/+DavG
 q6k+uIV6GkxOlOyUiAke2lyO1+vERDnTnxq2FdYvBxXP01Bn1C6Xt6n5aRRwExU8Rx/zjG
 1coyO0CqVk1xbrueDAyWYTPYJ3RFrlM=
Received: from CHE01-GV0-obe.outbound.protection.outlook.com
 (mail-gv0che01lp2040.outbound.protection.outlook.com [104.47.22.40]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-78-L-Krn5uSNSy3NWLjk_rpVQ-1; Wed, 15 Nov 2023 18:33:39 +0100
X-MC-Unique: L-Krn5uSNSy3NWLjk_rpVQ-1
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GV0P278MB0880.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.20; Wed, 15 Nov 2023 17:33:37 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fb5f:8939:4518:99a2%6]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 17:33:37 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "n-francis@ti.com" <n-francis@ti.com>, "sjg@chromium.org"
 <sjg@chromium.org>
CC: "kamlesh@ti.com" <kamlesh@ti.com>, "u-kumar1@ti.com" <u-kumar1@ti.com>,
 "m-chawdhry@ti.com" <m-chawdhry@ti.com>, "afd@ti.com" <afd@ti.com>,
 "mkorpershoek@baylibre.com" <mkorpershoek@baylibre.com>, "nm@ti.com"
 <nm@ti.com>, "vigneshr@ti.com" <vigneshr@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>
Subject: Re: [PATCH 0/2] Cleanup K3 binman FIT images
Thread-Topic: [PATCH 0/2] Cleanup K3 binman FIT images
Thread-Index: AQHaF6v8mZ6yxnCTd0WXn/3UToY2+LB7pGEA
Date: Wed, 15 Nov 2023 17:33:37 +0000
Message-ID: <8aee10aca8ef6f5acb5687a114d25453fd27b3d0.camel@toradex.com>
References: <20231115101024.3441093-1-n-francis@ti.com>
In-Reply-To: <20231115101024.3441093-1-n-francis@ti.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GV0P278MB0880:EE_
x-ms-office365-filtering-correlation-id: 47bbcf9e-252f-49a6-eff9-08dbe601004e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: kdI/MkYOfcYeLUELenHi8T+1jbjFafchVbQZ06oNNnEgRxyfVsIeCpt74/209IsFCXei5v/V3OhEi59DkxH1XgXCGs0UkkC+i1xQiHYId5PPYgoyOmBnJzZ+whEYPe8lTwgZu+o3fE0/ToiUdUFMkMTHUq6GY8/4aiFNXEB6pg+Tb20a4kZf7Yq+DRV9CfLLlEkh3tILnEONj2rCTKjZXxKQCEu374T8v2sUCU7ULAXHbTUz/DrTgvlG6+9Xu5GOO3ofpt1a81G5T1X+skoCE7Rd+uKrLg/wK2AwZJvmLGGyzB+ge1Yopij/WsQBPmqjblai64mI/UdMLj7N7G/HpZjETdgR7N7WKFHBBaT8skZ5uIkGG7znws8I1Q9k7BvslOqyS9uOG4wsJKKTtoxyLaotXs+zWO1/MH7ICX+NbifD3tLD/5jyVbLxzHigpbR8YNHCIN2N2J4kShNho/Oey7Ghh3v3DBRj32qA9CllrflMi4c2tMwPB+q54otiXKYlewQ/kJPlWK2ohhpBrG9Av8AZEstBxT+vM9vc+v5BKT6ZY7dnS30ldK45Q9DZ4gUaYJmnsxhA/lLXQolOkvvVVPBMBp+79mX8wxXDfak+syI=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39850400004)(396003)(346002)(136003)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(44832011)(2906002)(2616005)(36756003)(4326008)(7416002)(8936002)(8676002)(966005)(76116006)(6486002)(478600001)(4001150100001)(86362001)(316002)(5660300002)(66946007)(66446008)(110136005)(64756008)(66476007)(66556008)(54906003)(122000001)(38070700009)(38100700002)(71200400001)(83380400001)(6512007)(41300700001)(6506007);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MUM5d0FlTmd3L0J1b3B5REdERjA5L3JjL2loa3dYdUY0cDhZbS9yc3BFbjhz?=
 =?utf-8?B?WTlVa3djWWpxaHc1aWJmNmc5aThkUzRVdzdMbVhLM3ByOEFMVk9Jam5TNXpa?=
 =?utf-8?B?SHlRQnNXd2pRVUtYSWUwbSt5Ui9oVmpwZWpMOUg2TUxzWnQ1SFFScjNZRE82?=
 =?utf-8?B?MlRKNXZ3cEFvNHl3b2FUK3o4SlMyeVo2TmE1SGlZcDJiZC9TVmo3T2tkOG9H?=
 =?utf-8?B?cmFzbzdrQWZlVmlFYmdGN3BoOFh2S2dITllZY1lVUmJmaVVpMEV3LzAxOHRy?=
 =?utf-8?B?RVgvQ3M1WjhLQlJBZnpza3VwVFRoQ20vRzJJUlVUWHJQY2QyMlY3ZGd3ek1L?=
 =?utf-8?B?aDg4NVBQQVYzUndZcGdDMUs2b3FPb0dTbjNmRllyeVJDK0lXSUMva0dJWEhG?=
 =?utf-8?B?QXc3YWkwNjhFUXpUbnJDVDdDM1VmdG0vYWFyeW1wUlVNVUtKWGhYSjhITDhS?=
 =?utf-8?B?UFVDZER0RmdsNi9nN0tBV1dQTEU5UWpxQzJiVkRsbTlna0kwT2ZRdU9LRGdo?=
 =?utf-8?B?M3NiVG1FNWV1MEc3RGxwVHRaYVlMTkx0ODhWMGV3aEZESFFaTUo0dld1ek1T?=
 =?utf-8?B?WkZmRkxwSFhPQU5LemNNRmJmdTVhaXY2ZzI0MDA3RnRlTHpySVl2OE5EcG5T?=
 =?utf-8?B?TGZOTDFRVzFXdnY3b1YvWERKUlFWbEg3KzJrZVBZb2FXai9FV0R4OHBqdTdS?=
 =?utf-8?B?Q1ZiMEdRRm8yU0RBK2NzMDhYbHM5d3JuNzIxUjM1WnNmbk8zVnFMeVl1M0tt?=
 =?utf-8?B?cVU5WTZxZlhXbmlxT2NlOXhqWWludWFsQlQ4S1phbFlmRCtja2g2SFYyU0c2?=
 =?utf-8?B?UkFNbEtKQzFHMUJaVlNPUzIvVkZiVVRnOURNOVR3Wjg1ZGNrZ1I2d2V1OE1o?=
 =?utf-8?B?WFk2VGhyRU9taGdheTUzRitHQnNBNkRjODVBZ2hhbmxoUUNSbC9PSTl2RVp6?=
 =?utf-8?B?cjJFcnBVK2w2MkdBV2Y2YzZUOVNzZHc0cEF4TlJCbmJ6cCtPMWRmdHJOYnpX?=
 =?utf-8?B?QWtyRlMvVUM3NURENFlWRnNVZXZRZGQxZnVCZ1FZMEdPVzh6OWxjbCt4NFRm?=
 =?utf-8?B?d0Z0ei90YllpU1htb2dIS3pzMmRMUk1vSEVhZEJTbzIxN0kxVktpTmFYK2xW?=
 =?utf-8?B?KzN6QVVOU0dUSWI3eUNlZWZIZWNpVExVRDM4QVNhWUFpMDIyNDhRYzR3WXRa?=
 =?utf-8?B?cGZOYklEaXBIakozR3c1ZU9sSzlxSmM1cThQYmFCMnNONHJRTEFmT3FqbnNt?=
 =?utf-8?B?bUNlbFZwbW5pZWdKbHZYbzN5UGN4UHR2T1NHdGg0dzdpaHRWVFY4b1FhazNI?=
 =?utf-8?B?dzN1QzR3OXl1U0FUR2czdGo5U3RGbzRISDNIS0dWRnhlU3QvaGw2Rm5aTHRX?=
 =?utf-8?B?TVEyTjB6TnFGdnhtbW1HM01FNUQwL2c0V2NyaG8rOGl2ZTJOdE8wS2QzdEhl?=
 =?utf-8?B?d2xFcDJhNERaSkFrSFVIMnpBQ2Q4dVY0MVZ5ZHZJeUZoTlBzMTNGc1IzTHZn?=
 =?utf-8?B?cUUrWVFJVHFVN2JoRitlWjRHU0p3N2F6SzM0emRjUysxWXUvcHNlVnBwSzZD?=
 =?utf-8?B?ckVhejRiQWxzSk50aUNPQjNONG1Ea05HeEgwRVpDN1ZlMVE3WGd0Z2VBd052?=
 =?utf-8?B?eGJpL09NQzRLWmRua1FXMzQ3YUVZWm5CZzltbFZML1E3eGkxWGhLbEloeEpF?=
 =?utf-8?B?eVNodmJnVzFZUFhCMG9SL0J0WDV1VFNUQ2Uxcms1Z0p5Z2MxbUdkK1Avb0lD?=
 =?utf-8?B?TDIzbkZ2VldCRzRuZnBoMGVOYkNFOVNtWVUzbkJBUVRrWkE4NnlrODBSOUtj?=
 =?utf-8?B?N3RmTkJ4aVU2T2x3RFVpTVJiZjZYdE90V0RPTjBuQ2crNmUvcWFPRUE0dGtN?=
 =?utf-8?B?OE4yc0IxOHpyU1poSGpqOVl5a1liNHM4Tmhwc0hLNmttdUI0Q3VmS2xGOHRH?=
 =?utf-8?B?Vlo0VmF4TWVJTytDZDRCTCs2RkxqOW9qOERUUjc0TlhwWTdkTVkwcWllSjhS?=
 =?utf-8?B?Zm91ekpmSEVzLzRoVjdsazB1eC9WNGtacTZndDcwbHRROVZydGJVZzhIWTMz?=
 =?utf-8?B?Wm5aU05lYmVaV1ljQnlHUStCYkE3djQ2NC9OVDJoa0VWNFJVNlQ1RWdiaFdX?=
 =?utf-8?B?RU9TN1diVjJOS1ovNlpyV3RobFQyRjVuWHVUV2c1WW0zQlVMS1laU01JSzJO?=
 =?utf-8?Q?fIfbgL+pFnfg5tuJxqSwSHo=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 47bbcf9e-252f-49a6-eff9-08dbe601004e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2023 17:33:37.7210 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 572jZcWvluFA0FWMAu2BuF/3cIRWnJSs52lwv3lW5sWej2K49ma8LLSxVV4y3v1bYM5tn6lsh9wBMDHhF8hR74EqfjbJv/fSr6iYNDCiYsM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0880
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <F22440A1191DB147A2504270707F6168@CHEP278.PROD.OUTLOOK.COM>
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

SGkgTmVoYQ0KDQpPbiBXZWQsIDIwMjMtMTEtMTUgYXQgMTU6NDAgKzA1MzAsIE5laGEgTWFsY29t
IEZyYW5jaXMgd3JvdGU6DQo+IEluc3RlYWQgb2YgZHVwbGljYXRpbmcgdGhlIHNhbWUgRklUIGZv
cm1hdHMgb3ZlciBhbmQgb3ZlciBhZ2FpbiBmb3INCj4gZGlmZmVyZW50IEszIGRldmljZXMsIG1h
a2UgdXNlIG9mIHRoZSB0ZW1wbGF0aW5nIHN1cHBvcnQgdG8gaGF2ZSBGSVQNCj4gdGVtcGxhdGVz
IGZvciB0aGUgc2FtZS4gDQo+IA0KPiBOb3RlOiBJIHB1cnBvc2VseSBkaWQgbm90IGFkZCB0aGUg
dHJpYWwgdG8gdGVtcGxhdGUgb3V0IHRoZSBub24tRklUDQo+IGJvb3Rsb2FkZXIgaW1hZ2UgKHRp
Ym9vdDMuYmluKSBhcyBpdCByZWR1Y2VzIHRoZSByZWFkaWJpbGl0eSBhbmQNCj4gdW5kZXJzdGFu
ZGFiaWxpdHkgb2YgaG93IHRoZSBpbWFnZSBpcyBwYWNrYWdlZCBiZWNhdXNlIG9mIHRoZSB2YXJp
b3VzDQo+IGRpZmZlcmVudCBib290IGZsb3dzLg0KPiANCj4gQm9vdCBsb2dzOg0KPiBodHRwczov
L2dpc3QuZ2l0aHViLmNvbS9uZWhhbWFsY29tLzlhYmU3OTU1ZWJiNGEyNTE5MjNlNzY0MTI4MzRj
ODg2DQoNCkZvciB0aGUgd2hvbGUgc2VyaWVzOg0KDQpUZXN0ZWQtYnk6IE1hcmNlbCBaaXN3aWxl
ciA8bWFyY2VsLnppc3dpbGVyQHRvcmFkZXguY29tPg0KDQo+IE5laGEgTWFsY29tIEZyYW5jaXMg
KDIpOg0KPiDCoCBhcm06IGR0czogazMtYmlubWFuOiBBZGQgc3VwcG9ydCBmb3IgRklUIHRlbXBs
YXRlcw0KPiDCoCBhcm06IGR0czogazMtKi1iaW5tYW46IE1vdmUgdG8gdXNpbmcgdGVtcGxhdGVk
IEZJVHMNCj4gDQo+IMKgYXJjaC9hcm0vZHRzL2szLWFtNjI1LXNrLWJpbm1hbi5kdHNpwqDCoMKg
wqDCoMKgwqDCoMKgIHwgMTU3ICstLS0tLS0tLQ0KPiDCoC4uLi9kdHMvazMtYW02MjUtdmVyZGlu
LXdpZmktZGV2LWJpbm1hbi5kdHNpwqAgfCAxNTUgKy0tLS0tLS0NCj4gwqBhcmNoL2FybS9kdHMv
azMtYW02MmEtc2stYmlubWFuLmR0c2nCoMKgwqDCoMKgwqDCoMKgwqAgfCAxNTggKy0tLS0tLS0t
DQo+IMKgYXJjaC9hcm0vZHRzL2szLWFtNjR4LWJpbm1hbi5kdHNpwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHwgMTUxICstLS0tLS0tDQo+IMKgYXJjaC9hcm0vZHRzL2szLWFtNjV4LWJpbm1hbi5k
dHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMjczICstLS0tLS0tLS0tLS0tDQo+IMKgYXJj
aC9hcm0vZHRzL2szLWJpbm1hbi5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHwgMzI3ICsrKysrKysrKysrKysrKysrDQo+IMKgYXJjaC9hcm0vZHRzL2szLWo3MjAwLWJp
bm1hbi5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTU5ICstLS0tLS0tLQ0KPiDCoGFy
Y2gvYXJtL2R0cy9rMy1qNzIxZS1iaW5tYW4uZHRzacKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8
IDMzMiArLS0tLS0tLS0tLS0tLS0tLS0NCj4gwqBhcmNoL2FybS9kdHMvazMtajcyMXMyLWJpbm1h
bi5kdHNpwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1NyArLS0tLS0tLS0NCj4gwqA5IGZpbGVz
IGNoYW5nZWQsIDM4MSBpbnNlcnRpb25zKCspLCAxNDg4IGRlbGV0aW9ucygtKQ0KDQpUaGFua3Mh
DQoNCkNoZWVycw0KDQpNYXJjZWwNCg==

