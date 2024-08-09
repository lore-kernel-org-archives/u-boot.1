Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A157CC52D71
	for <u-boot@archiver.kernel.org>; Fri,  9 Aug 2024 05:57:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2717F87C7E;
	Fri,  9 Aug 2024 07:57:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="M0e2Jk6c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 027D684374; Fri,  9 Aug 2024 07:57:50 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5A8B87C7E
 for <u-boot@lists.denx.de>; Fri,  9 Aug 2024 07:57:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1723183066; x=1725775066;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+S1Sj/zJvm+uFlIyITaDF7Veaz7fGfeuIqqFv69SX58=;
 b=M0e2Jk6cz17zuNCnQ6t3pkapGDZO0OOptHUy1GkZZicmsIKKONn7xve4ihDek3/9
 iDSrz1mXGTNPcmBxohkcAznD92MDKZih8pKQ9CiIfwLHZ5zm4/ccqWIKmaUYDJh2
 zYsZDh+SJt64VfK85AvMqM7Jd4X8K9LKPaQHZ/ch8y0=;
X-AuditID: ac14000a-03e52700000021bc-f6-66b5afda4a89
Received: from florix.phytec.de (Unknown_Domain [172.25.0.13])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 27.9F.08636.ADFA5B66;
 Fri,  9 Aug 2024 07:57:46 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Florix.phytec.de
 (172.25.0.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Fri, 9 Aug 2024
 07:57:45 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Fri, 9 Aug 2024 07:57:45 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: "lukma@denx.de" <lukma@denx.de>
CC: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Benjamin Hahn <B.Hahn@phytec.de>,
 Cem Tenruh <C.Tenruh@phytec.de>, "martyn.welch@collabora.com"
 <martyn.welch@collabora.com>
Subject: Re: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Topic: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Index: AQHa59hOStMKCruDlEqmMDe5VnKFqrIbb5gAgAASToCAAXWcgIAAEciAgAFHmoA=
Date: Fri, 9 Aug 2024 05:57:45 +0000
Message-ID: <b013c9e30eb19c7eee0d18835e632405a7f4f61e.camel@phytec.de>
References: <20240806081131.4065425-1-lukma@denx.de>
 <dd54f3f8-7d80-4d0c-9eaa-639e45ddfdcf@phytec.de>
 <20240807130423.601a1e47@wsk>
 <fbd60aeea9413d7fa9f82ef952530e316e6b9e97.camel@phytec.de>
 <20240808122513.124db960@wsk>
In-Reply-To: <20240808122513.124db960@wsk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B84AE068715AF741A1CA1FE3234EAD4A@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGIsWRmVeSWpSXmKPExsWyRpKBV/fW+q1pBq+38Vg8vOpv8fzdZSaL
 Bxe7WCy+bdnGaDF10mZ2i7d7O9kd2DxmN1xk8dhxdwmjx7xZJ1g8ds66y+7x6sAqdo+zd3Yw
 BrBFcdmkpOZklqUW6dslcGXsae9nLThlWfF0/nK2BsYeiy5GDg4JAROJjTekuhi5OIQEljBJ
 7Nz+lxnCuccoseVhAzuEs55RYvXGg6xdjJwcbAIaEi9PdDOB2CICyhLXfr8FK2IW2MIk0f1/
 LxtIQlggVeLDlT1sEEVpEic/zGSEsP0kjjWtYQRZzSKgIvHinwVImFfATaJ7cTsrxLIXjBLP
 d/SwgCQ4BbQkzsyaDDaHUUBWYsOG88wgNrOAuMSmZ9/BDpIQEJBYsgciLiEgKvHy8T+ouLzE
 iVvTmEB2MQtoSqzfpQ/RaiHxbMcHdghbUWJK90N2iBsEJU7OfMIygVF8FpINsxC6ZyHpnoWk
 exaS7gWMrKsYhXIzk7NTizKz9QoyKktSk/VSUjcxguJWhIFrB2PfHI9DjEwcjIcYJTiYlUR4
 m8M3pQnxpiRWVqUW5ccXleakFh9ilOZgURLnXd0RnCokkJ5YkpqdmlqQWgSTZeLglGpgnGsq
 e/9egfKEuDDh37ecvhY/KWOr+284W2rrZPXUWp6qvawt+gvFGLSvlm5drtLj4LZaZbmJ57W2
 uA3Z53XiHvDOnj/ZvMji0ZR9Glbvf633atikGHuw/f2ih+/YH0jLBTZvkOFe+KH7q8M7DlF3
 +8LFXl9Oa7Y+YF1mdiLxvcL1NqNL90P7lViKMxINtZiLihMBlm1LEMkCAAA=
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

SGVsbG8gTHVrYXN6DQoNCkFtIERvbm5lcnN0YWcsIGRlbSAwOC4wOC4yMDI0IHVtIDEyOjI1ICsw
MjAwIHNjaHJpZWIgTHVrYXN6IE1hamV3c2tpOg0KPiBIaSBUZXJlc2EsDQo+IA0KPiA+IEhlbGxv
IEx1a2FzeiwNCj4gPiANCj4gPiBBbSBNaXR0d29jaCwgZGVtIDA3LjA4LjIwMjQgdW0gMTM6MDQg
KzAyMDAgc2NocmllYiBMdWthc3ogTWFqZXdza2k6DQo+ID4gPiBIaSBCZW5qYW1pbiwNCj4gPiA+
IMKgIA0KPiA+ID4gPiBIaSBMdWthc3osDQo+ID4gPiA+IA0KPiA+ID4gPiBPbiAwNi4wOC4yNCAx
MDoxMSwgTHVrYXN6IE1hamV3c2tpIHdyb3RlOsKgIA0KPiA+ID4gPiA+IFRoaXMgY29tbWFuZCBh
bGxvd3MgZWFzeSB1cGRhdGUgb24gU0QgY2FyZCBvciBlTU1DIG9mIHRoZQ0KPiA+ID4gPiA+IGZs
YXNoLmJpbg0KPiA+ID4gPiA+IGdlbmVyYXRlZCAod2l0aCBiaW5tYW4pIGR1cmluZyB1LWJvb3Qg
YnVpbGQuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogTHVrYXN6IE1hamV3
c2tpIDxsdWttYUBkZW54LmRlPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IENoYW5nZXMgZm9y
IHYyOg0KPiA+ID4gPiA+IC0gUmVtb3ZlICd1cGRhdGVfbW1jX3BhcnQnIHZhcmlhYmxlDQo+ID4g
PiA+ID4gLSBDaGFuZ2UgcGF0aCBmb3IgaG9zdG5hbWUNCj4gPiA+ID4gPiAtIFVzZSBmdWxsIHZl
cnNpb24gb2YgZGhjcCBjb21tYW5kICgke2xvYWRhZGRyfSBhZGRlZCkNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBDaGFuZ2VzIGZvciB2MzoNCj4gPiA+ID4gPiAtIFJlbW92ZSArMSB3aGVuIGNhbGN1
bGF0aW5nIHRoZSBzaXplIG9mIGJpbmFyeSB0byBiZSB3cml0dGVuDQo+ID4gPiA+ID4gLS0tDQo+
ID4gPiA+ID4gwqAgaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14OG1tLmggfCAxMCArKysrKysr
KysrDQo+ID4gPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPiA+
ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9jb25maWdzL3BoeWNvcmVfaW14
OG1tLmgNCj4gPiA+ID4gPiBiL2luY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5oIGluZGV4
DQo+ID4gPiA+ID4gY2U2ZGM4N2M2OS4uMzYxZTY2NTY3Ng0KPiA+ID4gPiA+IDEwMDY0NCAtLS0g
YS9pbmNsdWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaA0KPiA+ID4gPiA+ICsrKyBiL2luY2x1
ZGUvY29uZmlncy9waHljb3JlX2lteDhtbS5oDQo+ID4gPiA+ID4gQEAgLTI5LDYgKzI5LDE2IEBA
DQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCJtbWNkZXY9IiBfX3N0cmluZ2lmeShDT05GSUdf
U1lTX01NQ19FTlZfREVWKSAiXDAiIFwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIm1tY3Bh
cnQ9MVwwIiBcDQo+ID4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCJtbWNyb290PTJcMCIgXA0KPiA+
ID4gPiA+ICvCoMKgwqDCoMKgwqDCoCJ1cGRhdGVfb2Zmc2V0PTB4NDJcMCIgXA0KPiA+ID4gPiA+
ICvCoMKgwqDCoMKgwqDCoCJ1cGRhdGVfZmlsZW5hbWU9Zmxhc2guYmluXDAiIFwNCj4gPiA+ID4g
PiArwqDCoMKgwqDCoMKgwqAiaG9zdG5hbWU9L3Nydi90ZnRwL1wwIiBcDQo+ID4gPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgInVwZGF0ZV9ib290aW1nPSINCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
XA0KPiA+ID4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAibW1jIGRldiAke21t
Y2Rldn0gOyAiwqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+ID4gPiA+ID4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCJpZiBkaGNwICR7bG9hZGFkZHJ9DQo+ID4gPiA+ID4gJHtob3N0bmFt
ZX0vJHt1cGRhdGVfZmlsZW5hbWV9IDsgdGhlbiAiwqBcwqDCoMKgIA0KPiA+ID4gPiANCj4gPiA+
ID4gVGhlIGRoY3AgYW5kIHRmdHAgY29tbWFuZCBzaG91bGQgdGFrZSB0aGUgZmlsZXBhdGggZnJv
bSB0aGUNCj4gPiA+ID4gdGZ0cCANCj4gPiA+ID4gZGlyZWN0b3J5IGFuZCBnZXQgdGhlIHRmdHAg
ZGlyZWN0b3J5IGF1dG9tYXRpY2FsbHkgbm90IHRoZQ0KPiA+ID4gPiBhYnNvbHV0ZSBwYXRoLiBT
byB0aGlzIHdpbGwgdHJ5IHRvIGdldCB0aGUgZmlsZSBmcm9tIA0KPiA+ID4gPiAvcGF0aF90b190
ZnRwX2ZvbGRlci9zcnYvdGZ0cC9mbGFzaC5iaW4gYW5kIHdpbGwgZmFpbMKgIA0KPiA+ID4gDQo+
ID4gPiBBbmQgdGhhdCBpcyB3aHkgeW91IGRvIGhhdmUgdGhlICR7aG9zdG5hbWV9LyR7dXBkYXRl
X2ZpbGVuYW1lfSwNCj4gPiA+IHNvDQo+ID4gPiB3aGVuDQo+ID4gPiB5b3UgaGF2ZSBzZXZlcmFs
IGV4cG9ydGVkIGRpcmVjdG9yaWVzIC0geW91IGNhbiBzcGVjaWZ5IHdoaWNoIG9uZQ0KPiA+ID4g
d2l0aG91dCB0aGUgbmVlZCB0byBtb2RpZnkgdGhlICd1cGRhdGVfYm9vdGltZycgY29tbWFuZC7C
oCANCj4gPiANCj4gPiBkbyBJIHVuZGVyc3RhbmQgaXQgY29ycmVjdCB0aGF0IHlvdSBqdXN0IHdh
bnQgdG8gYmUgYWJsZSB0byBkZWZpbmUNCj4gPiBzdWINCj4gPiBkaXJzIHdpdGggYSB2YXJpYWJs
ZT8gDQo+IA0KPiBZZXMsIGNvcnJlY3QuDQo+IA0KPiA+IFRoaXMgZG9lcyBtYWtlIHNlbnNlIGJ1
dCB5b3Ugc2hvdWxkIG5vdCBwcmUtDQo+ID4gZGVmaW5lIHRoZW0gaGVyZS4NCj4gDQo+IE9rLiBJ
IHdpbGwgcmVtb3ZlIHRoZSAiaG9zdG5hbWU9L3Nydi90ZnRwIiBlbnZpcm9ubWVudCB2YXJpYWJs
ZS4NCj4gDQo+ID4gDQo+ID4gQW5kIEkgdGhpbmsgdGhlIHZhcmlhYmxlIG5hbWUgJGhvc3RuYW1l
IGlzIGtpbmQgb2YgbWlzcw0KPiA+IGxlYWRpbmcuwqBNYXliZQ0KPiA+IHlvdSBjYW4gZmluZCBz
b21lIGRpZmZlcmVudCBuYW1lIGZvciBpdD8NCj4gDQo+IFRoZSAke2hvc3RuYW1lfSBpcyB1c2Vk
IGluIGEgZmV3IHBsYWNlcyBhbHJlYWR5IGluIHRoYXQgd2F5LiBNYXliZQ0KPiB5b3UNCj4gaGF2
ZSBiZXR0ZXIgaWRlYSBmb3IgdGhpcyB2YXJpYWJsZSdzIG5hbWU/DQoNCkFzIGl0IGlzICR7dXBk
YXRlX2ZpbGVuYW1lfSBtYXliZSAke3VwZGF0ZV9maWxlcGF0aH0/DQoNClRlcmVzYQ0KDQo+IA0K
PiA+IA0KPiA+IFJlZ2FyZHMsDQo+ID4gVGVyZXNhDQo+ID4gDQo+ID4gPiDCoCANCj4gPiA+ID4g
YmVjYXVzZSBpdA0KPiA+ID4gPiBjYW4ndCBmaW5kIGl0LiBTbyB5b3UgY2FuIGRyb3AgdGhlICR7
aG9zdG5hbWV9LsKgIA0KPiA+ID4gDQo+ID4gPiBJIHdvdWxkIHByZWZlciB0byBrZWVwIHRoZSAk
e2hvc3RuYW1lfS8ke3VwZGF0ZV9maWxlbmFtZX0gcGFydC4NCj4gPiA+IMKgIA0KPiA+ID4gPiBB
bHNvIGRyb3AgdGhlIGluaXRpYWxpemF0aW9uIG9mICR7aG9zdG5hbWV9IGFib3ZlIHNpbmNlIGl0
IGlzDQo+ID4gPiA+IG5vDQo+ID4gPiA+IGxvbmdlciBuZWVkZWQuDQo+ID4gPiA+IA0KPiA+ID4g
PiBTaG91bGQgYmUgbGlrZSB0aGlzOg0KPiA+ID4gPiANCj4gPiA+ID4gZGhjcCAke2xvYWRhZGRy
fSAke3VwZGF0ZV9maWxlbmFtZX0NCj4gPiA+ID4gwqAgDQo+ID4gPiANCj4gPiA+IElNSE8gdGhl
IGxpbmUgc2hhbGwgYmU6DQo+ID4gPiANCj4gPiA+IGRoY3AgJHtsb2FkYWRkcn0gJHtob3N0bmFt
ZX0vJHt1cGRhdGVfZmlsZW5hbWV9DQo+ID4gPiDCoCANCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgInNldGV4cHIgZndfc3ogJHtmaWxlc2l6ZX0gLyAweDIwMCA7ICLC
oMKgLyoNCj4gPiA+ID4gPiBTRCBibG9jayBzaXplICovIFwNCj4gPiA+ID4gPiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgInNldGV4cHIgZndfc3ogJHtmd19zen0gOyAiwqDCoMKgIA0K
PiA+ID4gPiBJIHRoaW5rIHlvdSBjYW4gZHJvcCB0aGlzIGxpbmUgc2luY2UgaXQgZG9lcyBub3Qg
ZG8gYW55dGhpbmcuDQo+ID4gPiA+IMKgIA0KPiA+ID4gDQo+ID4gPiBPay4NCj4gPiA+IMKgIA0K
PiA+ID4gPiBCZW5qYW1pbsKgIA0KPiA+ID4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBcDQo+ID4gPiA+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJtbWMgd3JpdGUgJHtsb2FkYWRkcn0gJHt1cGRhdGVf
b2Zmc2V0fQ0KPiA+ID4gPiA+ICR7Zndfc3p9DQo+ID4gPiA+ID4gOw0KPiA+ID4gPiA+ICLCoMKg
wqDCoMKgwqDCoFwNCj4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgImZp
XDAiIFwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIm1tY2F1dG9kZXRlY3Q9eWVzXDAiIFwN
Cj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIm1tY2FyZ3M9c2V0ZW52IGJvb3RhcmdzIGNvbnNv
bGU9JHtjb25zb2xlfSAiIFwNCj4gPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCJyb290PS9kZXYvbW1jYmxrJHttbWNkZXZ9cCR7bW1jcm9vdH0NCj4gPiA+ID4gPiByb290
d2FpdA0KPiA+ID4gPiA+IHJ3XDAiIFzCoMKgwqAgDQo+ID4gPiA+IA0KPiA+ID4gPiDCoCANCj4g
PiA+IA0KPiA+ID4gDQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gQmVzdCByZWdhcmRzLA0KPiA+ID4g
DQo+ID4gPiBMdWthc3ogTWFqZXdza2kNCj4gPiA+IA0KPiA+ID4gLS0NCj4gPiA+IA0KPiA+ID4g
REVOWCBTb2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILMKgwqDCoMKgwqAgTWFuYWdpbmcgRGlyZWN0
b3I6IEVyaWthDQo+ID4gPiBVbnRlcg0KPiA+ID4gSFJCIDE2NTIzNSBNdW5pY2gsIE9mZmljZTog
S2lyY2hlbnN0ci41LCBELTgyMTk0IEdyb2ViZW56ZWxsLA0KPiA+ID4gR2VybWFueSBQaG9uZTog
KCs0OSktODE0Mi02Njk4OS01OSBGYXg6ICgrNDkpLTgxNDItNjY5ODktODANCj4gPiA+IEVtYWls
Og0KPiA+ID4gbHVrbWFAZGVueC5kZcKgIA0KPiA+IA0KPiANCj4gDQo+IA0KPiANCj4gQmVzdCBy
ZWdhcmRzLA0KPiANCj4gTHVrYXN6IE1hamV3c2tpDQo+IA0KPiAtLQ0KPiANCj4gREVOWCBTb2Z0
d2FyZSBFbmdpbmVlcmluZyBHbWJILMKgwqDCoMKgwqAgTWFuYWdpbmcgRGlyZWN0b3I6IEVyaWth
IFVudGVyDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04MjE5
NCBHcm9lYmVuemVsbCwgR2VybWFueQ0KPiBQaG9uZTogKCs0OSktODE0Mi02Njk4OS01OSBGYXg6
ICgrNDkpLTgxNDItNjY5ODktODAgRW1haWw6DQo+IGx1a21hQGRlbnguZGUNCg0KLS0gDQpQSFlU
RUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnosIEdl
cm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtpLCBE
aXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8IEhh
bmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5Oci4g
MjY2NTAwNjA4LCBERSAxNDkwNTk4NTUNCg==
