Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582EEC83F12
	for <u-boot@archiver.kernel.org>; Mon, 28 Aug 2023 22:12:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CC8C186488;
	Tue, 29 Aug 2023 00:12:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=toradex.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=toradex.com header.i=@toradex.com header.b="bcUTrbmB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D12FB86496; Tue, 29 Aug 2023 00:12:00 +0200 (CEST)
Received: from de-smtp-delivery-113.mimecast.com
 (de-smtp-delivery-113.mimecast.com [194.104.111.113])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D881486482
 for <u-boot@lists.denx.de>; Tue, 29 Aug 2023 00:11:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=toradex.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marcel.ziswiler@toradex.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=toradex-com; t=1693260717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nGKsRb5QmdLNDXNXMk7Wyml0vLiavzaMsKl9j/dn11o=;
 b=bcUTrbmBEDuwZoolFJRuK/ZKgz4MPv1GhRlD/6XXY56I8/dpE/Egs2WWxcjsl77WogxIF2
 zdKz7flOh5kjwLaEjJXFLxpRLnUssSMLAhSydVTAXnSLRSsARsldEgjQpgWEP76+ikZZC5
 mjkff2FQdmUu7r4qpujJo+DqBR19YsE=
Received: from CHE01-ZR0-obe.outbound.protection.outlook.com
 (mail-zr0che01lp2113.outbound.protection.outlook.com [104.47.22.113]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 de-mta-56-m4DT0vfzPDONr5nYe8Wu-g-2; Tue, 29 Aug 2023 00:11:56 +0200
X-MC-Unique: m4DT0vfzPDONr5nYe8Wu-g-2
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3b::9) by
 GVAP278MB0812.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:57::13) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.35; Mon, 28 Aug 2023 22:11:27 +0000
Received: from ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984]) by ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
 ([fe80::d5a7:e7ce:ac78:4984%6]) with mapi id 15.20.6699.035; Mon, 28 Aug 2023
 22:11:27 +0000
From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
To: "francesco@dolcini.it" <francesco@dolcini.it>, "nm@ti.com" <nm@ti.com>
CC: "n-francis@ti.com" <n-francis@ti.com>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "ghidoliemanuele@gmail.com"
 <ghidoliemanuele@gmail.com>, Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 "bb@ti.com" <bb@ti.com>
Subject: Re: [PATCH v1 1/2] verdin-am62: add u-boot update wrappers
Thread-Topic: [PATCH v1 1/2] verdin-am62: add u-boot update wrappers
Thread-Index: AQHZ1mJHpBrGzxItUkW+2mqr3XKCQa/5TQyAgAAOQoCAACpjgIAGxrYA
Date: Mon, 28 Aug 2023 22:11:27 +0000
Message-ID: <5213a48bb3ec05bec69f78fd480e4be656caedde.camel@toradex.com>
References: <20230824080850.1755724-1-ghidoliemanuele@gmail.com>
 <20230824080850.1755724-2-ghidoliemanuele@gmail.com>
 <ZOc8244kvlGRpHpj@francesco-nb.int.toradex.com>
 <20230824121057.zb6ugqbbmm6theny@rematch>
 <ZOdsX2VMNf20ioFR@francesco-nb.int.toradex.com>
In-Reply-To: <ZOdsX2VMNf20ioFR@francesco-nb.int.toradex.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR0P278MB0683:EE_|GVAP278MB0812:EE_
x-ms-office365-filtering-correlation-id: 45cfe879-1012-4e44-44c4-08dba813b97d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0
x-microsoft-antispam-message-info: YNlP6Nq8ZKtuh54VRi6ls4RpULrE39TuI3ApO2b9ZxXHwtTQUpwevoW92m+QVE/UvOrsu1yxnPrlKlFCGokCAJzSqFHsLrthB7hsQeRhwVPkGFCjxgPfvu8ryIiSZUZX84zLmfxS9Cc6eSsY2BOiq4YxqWuCKkCMRZmLzLK6IRhWO2zL67j0L9DKlUgaYNPRoQyXeKHDlv7Ze+VUAhIbMcSrMyI/5HkchtrzD0a6fBmGtb2kGBlRKzrwMMHWzUTPi/LmbHtd+XVLpCCEv2gPvaRLIt2D+Xv9rRoz4RU77ZXgyOFyvQYDISiTwSke0DzIJXiIAJImQMR0Aan3LDqNdOX8UW3tW3MPLDvv/+1EC1yb7r8z1BojH2S8XY76agZbWxB3LDb/xRYPdUP/Rvol1DDSLxWebqyENzvRRCCDim2+R2ps/RuOAbhpnqEy+7Bkk/IJFk22CXMyI4k+OiLy1TCl4SPfqBeBFCgedHSUW4HpZjfak8TNyqcJOFKBb98r/i//5egwO1+VWrfPCj+z2871qU4Q8JuLMGyu0NgLOp16zmgRnsCg3ghUmRYx+2K2uzsTDYBxFxlPYN54anzrLUYwhvdOALVkieqG54dHgo8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39850400004)(136003)(346002)(376002)(366004)(186009)(451199024)(1800799009)(6506007)(6512007)(316002)(54906003)(110136005)(71200400001)(8676002)(8936002)(41300700001)(4326008)(66476007)(76116006)(966005)(66446008)(66556008)(64756008)(66946007)(44832011)(5660300002)(478600001)(6486002)(2616005)(15650500001)(83380400001)(86362001)(38070700005)(2906002)(122000001)(38100700002)(36756003);
 DIR:OUT; SFP:1102
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXJtdGRhOFlUSzdjVEY1L0RESDl5djNLN2NwbmRaNytWVmN4TWN3dzdpbEdL?=
 =?utf-8?B?TEVpbTdVVGtWaXp0eDdLdTVaVzZtMkVIbWpMMHNkSGpaRjFmMHhudVlRTmg1?=
 =?utf-8?B?VCsyd3k3c2M0dzVLT0xWMWw1SEhnaXZ0bXJ1SW5SOXNPbWd4SS8vaDExTmI5?=
 =?utf-8?B?WUQvcUY5bnRoSkFHd29iN3NYRWMrTmhzVEIzSDFzc3I2NDNEaEdBbTQ1SzJK?=
 =?utf-8?B?TS93eDN2b2FuZUErT2puTE1RTHpjVzJPYTlmdzcxN0ZsNFRnUU9lREl3UE5w?=
 =?utf-8?B?dDEvQmdGbkQ0UW9ZdEkxVVNyczhBZFIwR0hOVFhjTFlwdEtmTHZxREhQUjJ3?=
 =?utf-8?B?Z0FKSjB1N3JzUndKbUJsNTQyWFlCOGRjQkIwYWtWZHpmc09ObTlBRGYrKzdm?=
 =?utf-8?B?TDZtQ2I3cFdtL29EeERDUEpabjJnVzVmN2ZpTTd5bHZkZVNPMktoNGduZTRm?=
 =?utf-8?B?dEFQRHd5MWlQQkhiNjY1UG9EbkJDYUgwRDlpVzJpUzNTMWFPbXJvOVVqeHNu?=
 =?utf-8?B?Z1NrNEJQazFzcVVMc25haTNTS1BNWEFDN2NkWm13bWZ0QmJteDcwMFFHelF3?=
 =?utf-8?B?c0kzS1dDUlBzb0J2WXdJZWJtdkg3cE9rZVgyNHdvY0h0MUtUTG1YRGZ4N3My?=
 =?utf-8?B?UG9rQjhpVE5pUjl1QU92bHY2d3BwTDgwYytGZ284bThVdEl0NVZKTGhVWEpI?=
 =?utf-8?B?QkxWS3JVL3ZYWFp4MVdQS0t4d2h3Vm5yQU4zQkl2N215dlkrdnZkSE1Uc1c1?=
 =?utf-8?B?VlJBOVlHUzdZRXBTcCtHNStGUngxN25mdm0yZkthWG9FdC9HZTNlcVF1N2sw?=
 =?utf-8?B?czNEb1BPVllodUtIQlpDQjlySTQ5Tm5zNlFUekVmY0JkZTJ2VHVvbzhuVk9r?=
 =?utf-8?B?OHBNRGlsNzJGYXVTaEhGRXRWZzRicmtHUE1rVXR4K3ZOWDdmYVBwenFEY1Vy?=
 =?utf-8?B?N2E3eXhzZTRpdktNREo3WTdHTjVVbnp5YTFXYlRXaHU3M045WUxTLzZhRVBV?=
 =?utf-8?B?c254am9ZRVdaSlZwbjRWVTNja2xrbjgzazMzbHJ3dDh5aUFXOWRyV1BMclBq?=
 =?utf-8?B?eEdiYU1JdG05NEdhVXFqSisraVBoTHVCZCtzcFpYeTJ6TnFYek9kd29YaFBq?=
 =?utf-8?B?cmZpMDhQSzJ2SFNyYXRJaWp5RHNaaXliRFpxb0lHamMwQUtHZjkwUTExaUcy?=
 =?utf-8?B?cTlTR0xuT29WQjBXMW5iOWtOUzRTT2lJZCtpMlJKejRleFVSNzNZMGw2YW5U?=
 =?utf-8?B?MlNRbWx4TXBRMnMrYlgyTnhlTEo4cmRCU2tQOTBrbE1FQWd1Vy9TZXg3YjFI?=
 =?utf-8?B?ZDNEYzFlV0lVR3owaWk5WkVnWTlReUVUaWNUd0N2WVc1WVRCYkdBU2M4ZCt0?=
 =?utf-8?B?S3hINkpVcEwrRGE0eU8xUGhHWndwMU9UUFFLSjdvcTcybUNkVy90NTBCSnUz?=
 =?utf-8?B?WlQ2NWJYNERkSHhSS1oyZ3hZeGRYOXErSFNtMXgyMXk4YWpUb21QaDJZY0ZL?=
 =?utf-8?B?Q2w3ZzdWS1ZRUXcxT3VxTXRJaVFmMWJMNmZwWk14ZTRnRTlXalArdGRVMWVu?=
 =?utf-8?B?UnlXV01RTFpwUUlDckR1aDNGaDAzcEQyN1ZUWXVoYS8wZ0JOeFVXYUR3TWdC?=
 =?utf-8?B?NmFnanhqRzlTT1JqL0JhVjV6QmhieXJFdW82NS9xZDF3QkFRaUhhNzY2WFNV?=
 =?utf-8?B?M0VnSTdTMDZkVk9yRFB6MUYvUTRrQzNKcWVqSDFmcWQzVTlHTzZNRzY3cDMv?=
 =?utf-8?B?dnBPSEpaTUwwQXdHL2xpNU5qRTJQaU00VDB0SUh2RU5ZbitCaGxGTk5ScmNZ?=
 =?utf-8?B?MEhIWXlSR2FvL0dEVy9oaHpkcGlrTkJvWlV5ZW5scmZrTEpHNm91QUc3L3hw?=
 =?utf-8?B?Q09OSnBzWUlkTWpTSWVPMEdyMnFyQmg4VEJlVUFIZjV1QmFrdXFkMEJMU0Vz?=
 =?utf-8?B?ckZ3OEExR25xYWVBTDl5R1JyRXNaWjV0T3Z0Qy9pZTJHM1NsOGVmY1V4ZSsw?=
 =?utf-8?B?a2RzYUNsYTViT2JZN052d2g4bG83My9SOEZoVkh6cEo1Rjg1MzgrcUtITTlq?=
 =?utf-8?B?dXZMM1JZSlVWUVUwRXNZNkZWc0QzWEpoVndQeERjWk5TU1Rac1l2WTU0NGha?=
 =?utf-8?B?TTRaQUZNd3VpK0ZxVW9PRzN1TlY1aWk0eGp2RUdNZ1hXR1BvSzJ5Qy9QSDZv?=
 =?utf-8?Q?Y8o4zHjzSRknfCTgH6YYig0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR0P278MB0683.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cfe879-1012-4e44-44c4-08dba813b97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 22:11:27.2648 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7WBzRmWTy6eKz1UQmin+fXnbI3UJk5+ieUTVIGA1DVb+i5PS5oG1GOuvYe2s26V9ujiZ3lnAzgiclLgVoJtAT4IrhsDeB5nckjf+NT8xdXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVAP278MB0812
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: toradex.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-ID: <303E5D131525AE4D9D244E2A82C81A95@CHEP278.PROD.OUTLOOK.COM>
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

T24gVGh1LCAyMDIzLTA4LTI0IGF0IDE2OjQyICswMjAwLCBGcmFuY2VzY28gRG9sY2luaSB3cm90
ZToNCj4gSGVsbG8gTmlzaGFudGgsDQo+IA0KPiBPbiBUaHUsIEF1ZyAyNCwgMjAyMyBhdCAwNzox
MDo1N0FNIC0wNTAwLCBOaXNoYW50aCBNZW5vbiB3cm90ZToNCj4gPiBPbiAxMzoxOS0yMDIzMDgy
NCwgRnJhbmNlc2NvIERvbGNpbmkgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEF1ZyAyNCwgMjAyMyBh
dCAxMDowODo0OUFNICswMjAwLCBFbWFudWVsZSBHaGlkb2xpIHdyb3RlOg0KPiA+ID4gPiBGcm9t
OiBFbWFudWVsZSBHaGlkb2xpIDxlbWFudWVsZS5naGlkb2xpQHRvcmFkZXguY29tPg0KPiA+ID4g
PiANCj4gPiA+ID4gQWRkIHVwZGF0ZV90aWJvb3QzLCB1cGRhdGVfdGlzcGwgYW5kIHVwZGF0ZV91
Ym9vdCB3cmFwcGVycyB0byB1cGRhdGUNCj4gPiA+ID4gUjUgU1BMLCBBNTMgU1BMIGFuZCBBNTMg
VS1ib290IHJlc3BlY3RpdmVseS4NCj4gPiA+ID4gDQo+ID4gPiA+IFVzYWdlIGV4YW1wbGU6DQo+
ID4gPiA+ID4gdGZ0cGJvb3QgJHtsb2FkYWRkcn0gdGlib290My1hbTYyeC1ncC12ZXJkaW4uYmlu
DQo+ID4gPiA+ID4gcnVuIHVwZGF0ZV90aWJvb3QzDQo+ID4gPiA+IA0KPiA+ID4gPiA+IHRmdHBi
b290ICR7bG9hZGFkZHJ9IHRpc3BsLmJpbg0KPiA+ID4gPiA+IHJ1biB1cGRhdGVfdGlzcGwNCj4g
PiA+ID4gDQo+ID4gPiA+ID4gdGZ0cGJvb3QgJHtsb2FkYWRkcn0gdS1ib290LmltZw0KPiA+ID4g
PiA+IHJ1biB1cGRhdGVfdWJvb3QNCj4gPiA+ID4gDQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEVt
YW51ZWxlIEdoaWRvbGkgPGVtYW51ZWxlLmdoaWRvbGlAdG9yYWRleC5jb20+DQo+ID4gPiANCj4g
PiA+IEFja2VkLWJ5OiBGcmFuY2VzY28gRG9sY2luaSA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRl
eC5jb20+DQo+ID4gDQo+ID4gU2hvdWxkIHlvdSB1cGRhdGUgZG9jdW1lbnRhdGlvbiB0byBpbmRp
Y2F0ZSB0aGUgdXNhZ2U/DQo+IA0KPiBZZWFoLCBwcm9iYWJseSB3ZSBjb3VsZCBhZGQgaXQuIEkg
d291bGQgbm90IHJlbW92ZSB0aGUgZXhpc3RpbmcgZGlyZWN0DQo+IGNvbW1hbmQgdXNhZ2Ugc2lu
Y2UgdGhpcyBpcyBhZGRpbmcganVzdCBlbnYgdmFyaWFibGVzIHRoYXQgY291bGQgYmUNCj4gcmVt
b3ZlZCBmcm9tIHRoZSBlbnYgZXZlbiBhdCBydW50aW1lLg0KPiANCj4gSW4gZ2VuZXJhbCB0aGUg
cmVhc29uIGZvciB0aGVzZSBjb21tYW5kcyBpcyB0aGF0IG91ciB1c2VycyBhcmUNCj4gYWNjdXN0
b21lZCB0byBoYXZlIGEgImd1aWRlZCIgd2F5IHRvIHVwZGF0ZSB1LWJvb3Qgd2l0aG91dCBoYXZp
bmcgdG8gZGlnDQo+IGludG8gdGhlIGRvY3VtZW50YXRpb24uIFRoZXkgYXJlIGp1c3QgY29udmVu
aWVudC4NCj4gDQo+IE1hcmNlbDogd2hhdCBkbyB5b3UgdGhpbms/DQoNClN1cmUsIHdlIHRvb2sg
Y2FyZSBvZiBpdCBoZXJlOg0KDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyMzA4Mjgy
MjAxNTQuNDgzMzYyLTEtbWFyY2VsQHppc3dpbGVyLmNvbQ0KDQo+IEZyYW5jZXNjbw0KDQpDaGVl
cnMNCg0KTWFyY2VsDQo=

