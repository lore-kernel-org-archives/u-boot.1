Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9539EC54E58
	for <u-boot@archiver.kernel.org>; Tue, 26 Mar 2024 06:24:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AFB1987F77;
	Tue, 26 Mar 2024 07:24:54 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="LeGI6dTS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 640A587EA8; Tue, 26 Mar 2024 07:24:53 +0100 (CET)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8148587FA9
 for <u-boot@lists.denx.de>; Tue, 26 Mar 2024 07:24:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=Y.Moog@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1711434289; x=1714026289;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ovkjs59VsYVdjmNszuE7/Mtk5tTkv1a1Cwwt028oxUk=;
 b=LeGI6dTSWuv3PYbGgzyJhx7ciufKC7ZSKgCffWiAZizBBgPmcF4ZyhirWqkq2dY+
 M+Ix7Vv0MevV+QjC5cTBzcQg9hIXZQP5IAmrirRHIRtykTqYwCv2XZDuKLV33PWC
 3kGNmHmLIAfssjvtlloE/VnnCLxrSxtRZxOFEtvVbHY=;
X-AuditID: ac14000a-fadff7000000290d-07-66026a30a10a
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id E8.80.10509.03A62066;
 Tue, 26 Mar 2024 07:24:48 +0100 (CET)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 26 Mar
 2024 07:24:48 +0100
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Tue, 26 Mar 2024 07:24:48 +0100
From: Yannic Moog <Y.Moog@phytec.de>
To: "festevam@gmail.com" <festevam@gmail.com>, "marex@denx.de" <marex@denx.de>
CC: "ye.li@nxp.com" <ye.li@nxp.com>, Wadim Egorov <W.Egorov@phytec.de>,
 "trini@konsulko.com" <trini@konsulko.com>, Christoph Stoidner
 <C.Stoidner@phytec.de>, "peng.fan@nxp.com" <peng.fan@nxp.com>,
 "othacehe@gnu.org" <othacehe@gnu.org>, "sebastien.szymanski@armadeus.com"
 <sebastien.szymanski@armadeus.com>, "alice.guo@nxp.com" <alice.guo@nxp.com>,
 "sbabic@denx.de" <sbabic@denx.de>, "sjg@chromium.org" <sjg@chromium.org>,
 "yangshiji66@outlook.com" <yangshiji66@outlook.com>, "m.othacehe@gmail.com"
 <m.othacehe@gmail.com>, "primoz.fiser@norik.com" <primoz.fiser@norik.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 2/3] configs: imx93-phyboard-segin: Add USB support
Thread-Topic: [PATCH v3 2/3] configs: imx93-phyboard-segin: Add USB support
Thread-Index: AQHae55+zJSgazp0GEmb0UCQ1oU8pbFCTkoAgATT+4CAAmJUAA==
Date: Tue, 26 Mar 2024 06:24:48 +0000
Message-ID: <a495732e05db18ab59c7edcca930c1a82c30271c.camel@phytec.de>
References: <20240321144541.15314-1-othacehe@gnu.org>
 <20240321144541.15314-3-othacehe@gnu.org>
 <dec314ce-d83a-4549-a2d6-f5604107bca5@denx.de>
 <CAOMZO5AOv9Cmdpmji-y+YO9GvkMTHmh2d+RxmVksMLgj-23rqQ@mail.gmail.com>
In-Reply-To: <CAOMZO5AOv9Cmdpmji-y+YO9GvkMTHmh2d+RxmVksMLgj-23rqQ@mail.gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <50349D1FFBF32B458627F703FF416A01@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWyRpKBR9cgiynNoLPLwuLbut8sFg+v+lvM
 uDmNzeJNWyOjxfm7W5gtfqz6wmpxoushq0X7KR+Lw/+eMVt827KN0WLqpM3sFm/3drJbnO39
 ym7RdvwQowOfx5Jd+5k9ZjdcZPGYN+sEi8fOWXfZPdqmmXm8OrCK3ePsnR2MHt+/bmD12Phu
 B5PH5tcvmAO4orhsUlJzMstSi/TtErgyFp05w1Ywjbui7/YO9gbGD1xdjJwcEgImEkte72bq
 YuTiEBJYzCRxa80iNgjnPqPEl13PWSCcDYwSr1bvYAFpYRNQkTg54xIjiC0i4Ccx4/0EdpAi
 ZoFfLBKfJpxmB0kIC3hJfP20kQ2iyFtiyoQpULaTxPYN98FqWARUJY6fugk2lFfATWJx8z+w
 GiGBO4wSt3clgNicAoEST16uZAaxGQVkJTZsOA9mMwuIS2x69p0V4gcBiSV7IOISAqISLx//
 g4rLS5y4NQ3oNw6gek2J9bv0IVotJBru7GOEsBUlpnQ/ZIc4QVDi5MwnLBMYxWch2TALoXsW
 ku5ZSLpnIelewMi6ilEoNzM5O7UoM1uvIKOyJDVZLyV1EyMoWYgwcO1g7JvjcYiRiYPxEKME
 B7OSCG/LF4Y0Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryrO4JThQTSE0tSs1NTC1KLYLJMHJxS
 DYwy1k8PPTwz0e1yS2zvf7W1BjWbMlnXzI05lubkdfPtXEG9rTe6rjRd2nlE1bjQ+giDnZm+
 nouAhezJwz/8Kjff6lilO+2rwpPfE1oP/shX6f356nOewZSfh/Odr69YL7VC5L5088l55l++
 2tT59W3auO/05bAVb5oM3uluO3o93b+TtWrfMuXvSizFGYmGWsxFxYkAcS3hbAQDAAA=
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

SGkgRmFiaW8sIGhpIE1hcmVrLA0KDQpPbiBTdW4sIDIwMjQtMDMtMjQgYXQgMTU6MDAgLTAzMDAs
IEZhYmlvIEVzdGV2YW0gd3JvdGU6DQo+IE9uIFRodSwgTWFyIDIxLCAyMDI0IGF0IDQ6MTfigK9Q
TSBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4gd3JvdGU6DQo+IA0KPiA+ICQgZ2l0IGdyZXAg
LWkgdXNiLipwaHl0ZWMgY29uZmlncw0KPiA+IGNvbmZpZ3MvcGh5Y29yZV9wY2wwNjNfZGVmY29u
ZmlnOkNPTkZJR19VU0JfR0FER0VUX01BTlVGQUNUVVJFUj0iUGh5dGVjIg0KPiA+IGNvbmZpZ3Mv
cGh5Y29yZV9wY2wwNjNfdWxsX2RlZmNvbmZpZzpDT05GSUdfVVNCX0dBREdFVF9NQU5VRkFDVFVS
RVI9IlBoeXRlYyINCj4gPiANCj4gPiBJdCB3b3VsZCBiZSBnb29kIHRvIGJlIGNvbnNpc3RlbnQu
DQo+ID4gDQo+ID4gQWxzbywgd2hhdCBpcyB0aGUgdmVuZG9yL3Byb2R1Y3QgbnVtYmVyIHRob3Nl
IHR3byBib2FyZHMgdXNlID8NCj4gDQo+IFRoZXkgYm90aCB1c2U6DQo+IA0KPiBDT05GSUdfVVNC
X0dBREdFVF9WRU5ET1JfTlVNPTB4MDFiNjcNCj4gQ09ORklHX1VTQl9HQURHRVRfUFJPRFVDVF9O
VU09MHg0ZmZmDQo+IA0KPiBjb25maWdzL3BoeWNvcmUtaW14OG1wX2RlZmNvbmZpZyBoYXM6DQo+
IA0KPiBDT05GSUdfVVNCX0dBREdFVF9NQU5VRkFDVFVSRVI9IkZTTCINCj4gQ09ORklHX1VTQl9H
QURHRVRfVkVORE9SX05VTT0weDA1MjUNCj4gQ09ORklHX1VTQl9HQURHRVRfUFJPRFVDVF9OVU09
MHhhNGE1DQo+IA0KPiBJIGFncmVlIHdlIHNob3VsZCBtYWtlIHRoaXMgY29uc2lzdGVudC4NCj4g
DQo+IFRvIG5vdCBibG9jayB0aGlzIHNlcmllcywgSSBhcHBsaWVkIGl0LCBidXQgaXQgd291bGQg
YmUgZ3JlYXQgaWYNCj4gDQoNCj4gUGh5dGVjIGNvdWxkIHN1Ym1pdA0KPiBhIHNlcGFyYXRlIHNl
cmllcyBtYWtpbmcgaXQgY29uc2lzdGVudCBhY3Jvc3MgdGhlaXIgYm9hcmRzLg0KDQpXZSdsbCB0
YWtlIGNhcmUgb2YgdGhhdC4gVGhhbmsgeW91IGZvciB0aGUgZmVlZGJhY2suDQoNCllhbm5pYw0K
DQo+IA0KPiBUaGFua3MNCg0K
