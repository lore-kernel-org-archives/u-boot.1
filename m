Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4809C52D71
	for <u-boot@archiver.kernel.org>; Thu,  8 Aug 2024 09:21:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0F461888D7;
	Thu,  8 Aug 2024 11:21:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=phytec.de header.i=@phytec.de header.b="YXDey89V";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A6B1C887BB; Thu,  8 Aug 2024 11:21:40 +0200 (CEST)
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 63F8C8890F
 for <u-boot@lists.denx.de>; Thu,  8 Aug 2024 11:21:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=T.Remmet@phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
 q=dns/txt; i=@phytec.de; t=1723108896; x=1725700896;
 h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G529qb7gSgUeCiUOCNiUj9KqC4fCvxdte3H3/N0k7QI=;
 b=YXDey89VTecEAopqcVOLFZNFCM8jPuUWGDeke/K49dkwW8r4QKsDKKwvgJ2RMcwE
 wkZam2ym3T+gK3w4KSAAoNQsrHhKK5ye1Asm9Dk4i59pcuRCxcMyiTihhwo+n3iT
 Z5LT/CvaTV1Jt2E4IHZqBW2ga650fpknRFTCfY8cZIs=;
X-AuditID: ac14000a-03e52700000021bc-f7-66b48e20b57f
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
 (using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client did not present a certificate)
 by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 9A.1B.08636.02E84B66;
 Thu,  8 Aug 2024 11:21:36 +0200 (CEST)
Received: from Berlix.phytec.de (172.25.0.12) by Berlix.phytec.de
 (172.25.0.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Thu, 8 Aug 2024
 11:21:36 +0200
Received: from Berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4]) by
 berlix.phytec.de ([fe80::197e:d26b:2ca:c7b4%4]) with mapi id 15.01.2507.006;
 Thu, 8 Aug 2024 11:21:36 +0200
From: Teresa Remmet <T.Remmet@phytec.de>
To: Benjamin Hahn <B.Hahn@phytec.de>, "lukma@denx.de" <lukma@denx.de>
CC: "sjg@chromium.org" <sjg@chromium.org>, "u-boot@lists.denx.de"
 <u-boot@lists.denx.de>, "trini@konsulko.com" <trini@konsulko.com>,
 "festevam@gmail.com" <festevam@gmail.com>, Cem Tenruh <C.Tenruh@phytec.de>,
 "martyn.welch@collabora.com" <martyn.welch@collabora.com>
Subject: Re: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Topic: [PATCH v3] config: Add 'update_bootimg' command to update
 flash.bin on Phytec's imx8mm
Thread-Index: AQHa59hOStMKCruDlEqmMDe5VnKFqrIbb5gAgAASToCAAXWcgA==
Date: Thu, 8 Aug 2024 09:21:36 +0000
Message-ID: <fbd60aeea9413d7fa9f82ef952530e316e6b9e97.camel@phytec.de>
References: <20240806081131.4065425-1-lukma@denx.de>
 <dd54f3f8-7d80-4d0c-9eaa-639e45ddfdcf@phytec.de>
 <20240807130423.601a1e47@wsk>
In-Reply-To: <20240807130423.601a1e47@wsk>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.0.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9CDC0F04A583D946B2A98391DF78AD1B@phytec.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsWyRpKBR1ehb0uawZLPehYPr/pbPH93mcni
 wcUuFotvW7YxWkydtJnd4u3eTnYHNo/ZDRdZPHbcXcLoMW/WCRaPnbPusnu8OrCK3ePsnR2M
 AWxRXDYpqTmZZalF+nYJXBmvOo6zF5zRrphw4S1LA+MerS5GTg4JAROJl6umsXcxcnEICSxh
 krhwoY8VwrnHKHF36SyozHpGiZaWB6wgLWwCGhIvT3QzgdgiAq4Sre97GUFsZoEJTBIPL2SD
 2MICqRIfruxhg6hJkzj5YSYjhO0k8X/zKbA5LAIqEjM/zgebwyvgJrHqwykmiGWdjBLbvraB
 JTgFtCSeXzwD1swoICuxYcN5Zohl4hKbnn1nhfhBQGLJHoi4hICoxMvH/6Di8hInbk0DmsMB
 VK8psX6XPkSrhcTquxOhblaUmNL9kB3iBkGJkzOfsExgFJ+FZMMshO5ZSLpnIemehaR7ASPr
 Kkah3Mzk7NSizGy9gozKktRkvZTUTYygyBVh4NrB2DfH4xAjEwfjIUYJDmYlEd7m8E1pQrwp
 iZVVqUX58UWlOanFhxilOViUxHlXdwSnCgmkJ5akZqemFqQWwWSZODilGhhlM2dGvGM92evd
 nmLVfT655JiQ3P1wxXXTb6323ZF571qhhsOM6MN/dH60MK8SEF3A2aMsveWx3OO8vVlxquLL
 GL901f9qEl69ojv8wvH5sk/lZl9628k+i0M6ryCwrr9kysq3k3iz52i3psdt1vF4PWduIoPK
 0dN/Ps9beWdXmeHRaYF7a9SUWIozEg21mIuKEwG6vIAQygIAAA==
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

SGVsbG8gTHVrYXN6LA0KDQpBbSBNaXR0d29jaCwgZGVtIDA3LjA4LjIwMjQgdW0gMTM6MDQgKzAy
MDAgc2NocmllYiBMdWthc3ogTWFqZXdza2k6DQo+IEhpIEJlbmphbWluLA0KPiANCj4gPiBIaSBM
dWthc3osDQo+ID4gDQo+ID4gT24gMDYuMDguMjQgMTA6MTEsIEx1a2FzeiBNYWpld3NraSB3cm90
ZToNCj4gPiA+IFRoaXMgY29tbWFuZCBhbGxvd3MgZWFzeSB1cGRhdGUgb24gU0QgY2FyZCBvciBl
TU1DIG9mIHRoZQ0KPiA+ID4gZmxhc2guYmluDQo+ID4gPiBnZW5lcmF0ZWQgKHdpdGggYmlubWFu
KSBkdXJpbmcgdS1ib290IGJ1aWxkLg0KPiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBMdWth
c3ogTWFqZXdza2kgPGx1a21hQGRlbnguZGU+DQo+ID4gPiAtLS0NCj4gPiA+IENoYW5nZXMgZm9y
IHYyOg0KPiA+ID4gLSBSZW1vdmUgJ3VwZGF0ZV9tbWNfcGFydCcgdmFyaWFibGUNCj4gPiA+IC0g
Q2hhbmdlIHBhdGggZm9yIGhvc3RuYW1lDQo+ID4gPiAtIFVzZSBmdWxsIHZlcnNpb24gb2YgZGhj
cCBjb21tYW5kICgke2xvYWRhZGRyfSBhZGRlZCkNCj4gPiA+IA0KPiA+ID4gQ2hhbmdlcyBmb3Ig
djM6DQo+ID4gPiAtIFJlbW92ZSArMSB3aGVuIGNhbGN1bGF0aW5nIHRoZSBzaXplIG9mIGJpbmFy
eSB0byBiZSB3cml0dGVuDQo+ID4gPiAtLS0NCj4gPiA+IMKgIGluY2x1ZGUvY29uZmlncy9waHlj
b3JlX2lteDhtbS5oIHwgMTAgKysrKysrKysrKw0KPiA+ID4gwqAgMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykNCj4gPiA+IA0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvY29uZmln
cy9waHljb3JlX2lteDhtbS5oDQo+ID4gPiBiL2luY2x1ZGUvY29uZmlncy9waHljb3JlX2lteDht
bS5oIGluZGV4IGNlNmRjODdjNjkuLjM2MWU2NjU2NzYNCj4gPiA+IDEwMDY0NCAtLS0gYS9pbmNs
dWRlL2NvbmZpZ3MvcGh5Y29yZV9pbXg4bW0uaA0KPiA+ID4gKysrIGIvaW5jbHVkZS9jb25maWdz
L3BoeWNvcmVfaW14OG1tLmgNCj4gPiA+IEBAIC0yOSw2ICsyOSwxNiBAQA0KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoCJtbWNkZXY9IiBfX3N0cmluZ2lmeShDT05GSUdfU1lTX01NQ19FTlZfREVWKSAi
XDAiIFwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAibW1jcGFydD0xXDAiIFwNCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqAibW1jcm9vdD0yXDAiIFwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCJ1cGRhdGVf
b2Zmc2V0PTB4NDJcMCIgXA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgInVwZGF0ZV9maWxlbmFtZT1m
bGFzaC5iaW5cMCIgXA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgImhvc3RuYW1lPS9zcnYvdGZ0cC9c
MCIgXA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgInVwZGF0ZV9ib290aW1nPSINCj4gPiA+IMKgwqDC
oMKgwqDCoMKgwqBcDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIm1tYyBk
ZXYgJHttbWNkZXZ9IDsgIsKgwqDCoMKgwqDCoMKgwqDCoMKgXA0KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCJpZiBkaGNwICR7bG9hZGFkZHJ9DQo+ID4gPiAke2hvc3RuYW1l
fS8ke3VwZGF0ZV9maWxlbmFtZX0gOyB0aGVuICLCoFzCoCANCj4gPiANCj4gPiBUaGUgZGhjcCBh
bmQgdGZ0cCBjb21tYW5kIHNob3VsZCB0YWtlIHRoZSBmaWxlcGF0aCBmcm9tIHRoZSB0ZnRwIA0K
PiA+IGRpcmVjdG9yeSBhbmQgZ2V0IHRoZSB0ZnRwIGRpcmVjdG9yeSBhdXRvbWF0aWNhbGx5IG5v
dCB0aGUgYWJzb2x1dGUNCj4gPiBwYXRoLiBTbyB0aGlzIHdpbGwgdHJ5IHRvIGdldCB0aGUgZmls
ZSBmcm9tIA0KPiA+IC9wYXRoX3RvX3RmdHBfZm9sZGVyL3Nydi90ZnRwL2ZsYXNoLmJpbiBhbmQg
d2lsbCBmYWlsDQo+IA0KPiBBbmQgdGhhdCBpcyB3aHkgeW91IGRvIGhhdmUgdGhlICR7aG9zdG5h
bWV9LyR7dXBkYXRlX2ZpbGVuYW1lfSwgc28NCj4gd2hlbg0KPiB5b3UgaGF2ZSBzZXZlcmFsIGV4
cG9ydGVkIGRpcmVjdG9yaWVzIC0geW91IGNhbiBzcGVjaWZ5IHdoaWNoIG9uZQ0KPiB3aXRob3V0
IHRoZSBuZWVkIHRvIG1vZGlmeSB0aGUgJ3VwZGF0ZV9ib290aW1nJyBjb21tYW5kLg0KDQpkbyBJ
IHVuZGVyc3RhbmQgaXQgY29ycmVjdCB0aGF0IHlvdSBqdXN0IHdhbnQgdG8gYmUgYWJsZSB0byBk
ZWZpbmUgc3ViDQpkaXJzIHdpdGggYSB2YXJpYWJsZT8gVGhpcyBkb2VzIG1ha2Ugc2Vuc2UgYnV0
IHlvdSBzaG91bGQgbm90IHByZS0NCmRlZmluZSB0aGVtIGhlcmUuDQoNCkFuZCBJIHRoaW5rIHRo
ZSB2YXJpYWJsZSBuYW1lICRob3N0bmFtZSBpcyBraW5kIG9mIG1pc3MgbGVhZGluZy7CoE1heWJl
DQp5b3UgY2FuIGZpbmQgc29tZSBkaWZmZXJlbnQgbmFtZSBmb3IgaXQ/DQoNClJlZ2FyZHMsDQpU
ZXJlc2ENCg0KPiANCj4gPiBiZWNhdXNlIGl0DQo+ID4gY2FuJ3QgZmluZCBpdC4gU28geW91IGNh
biBkcm9wIHRoZSAke2hvc3RuYW1lfS4NCj4gDQo+IEkgd291bGQgcHJlZmVyIHRvIGtlZXAgdGhl
ICR7aG9zdG5hbWV9LyR7dXBkYXRlX2ZpbGVuYW1lfSBwYXJ0Lg0KPiANCj4gPiBBbHNvIGRyb3Ag
dGhlIGluaXRpYWxpemF0aW9uIG9mICR7aG9zdG5hbWV9IGFib3ZlIHNpbmNlIGl0IGlzIG5vDQo+
ID4gbG9uZ2VyIG5lZWRlZC4NCj4gPiANCj4gPiBTaG91bGQgYmUgbGlrZSB0aGlzOg0KPiA+IA0K
PiA+IGRoY3AgJHtsb2FkYWRkcn0gJHt1cGRhdGVfZmlsZW5hbWV9DQo+ID4gDQo+IA0KPiBJTUhP
IHRoZSBsaW5lIHNoYWxsIGJlOg0KPiANCj4gZGhjcCAke2xvYWRhZGRyfSAke2hvc3RuYW1lfS8k
e3VwZGF0ZV9maWxlbmFtZX0NCj4gDQo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgInNldGV4cHIgZndfc3ogJHtmaWxlc2l6ZX0gLyAweDIwMCA7ICLCoMKgLyoNCj4gPiA+IFNE
IGJsb2NrIHNpemUgKi8gXA0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCJz
ZXRleHByIGZ3X3N6ICR7Zndfc3p9IDsgIsKgIA0KPiA+IEkgdGhpbmsgeW91IGNhbiBkcm9wIHRo
aXMgbGluZSBzaW5jZSBpdCBkb2VzIG5vdCBkbyBhbnl0aGluZy4NCj4gPiANCj4gDQo+IE9rLg0K
PiANCj4gPiBCZW5qYW1pbg0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoFwNCj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAibW1jIHdyaXRlICR7bG9hZGFkZHJ9ICR7dXBkYXRlX29mZnNldH0gJHtm
d19zen0NCj4gPiA+IDsNCj4gPiA+ICLCoMKgwqDCoMKgwqDCoFwNCj4gPiA+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAiZmlcMCIgXA0KPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCJtbWNh
dXRvZGV0ZWN0PXllc1wwIiBcDQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIm1tY2FyZ3M9c2V0ZW52
IGJvb3RhcmdzIGNvbnNvbGU9JHtjb25zb2xlfSAiIFwNCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgInJvb3Q9L2Rldi9tbWNibGske21tY2Rldn1wJHttbWNyb290fSByb290
d2FpdA0KPiA+ID4gcndcMCIgXMKgIA0KPiA+IA0KPiA+IA0KPiANCj4gDQo+IA0KPiANCj4gQmVz
dCByZWdhcmRzLA0KPiANCj4gTHVrYXN6IE1hamV3c2tpDQo+IA0KPiAtLQ0KPiANCj4gREVOWCBT
b2Z0d2FyZSBFbmdpbmVlcmluZyBHbWJILMKgwqDCoMKgwqAgTWFuYWdpbmcgRGlyZWN0b3I6IEVy
aWthIFVudGVyDQo+IEhSQiAxNjUyMzUgTXVuaWNoLCBPZmZpY2U6IEtpcmNoZW5zdHIuNSwgRC04
MjE5NCBHcm9lYmVuemVsbCwgR2VybWFueQ0KPiBQaG9uZTogKCs0OSktODE0Mi02Njk4OS01OSBG
YXg6ICgrNDkpLTgxNDItNjY5ODktODAgRW1haWw6DQo+IGx1a21hQGRlbnguZGUNCg0KLS0gDQpQ
SFlURUMgTWVzc3RlY2huaWsgR21iSCB8IEJhcmNlbG9uYS1BbGxlZSAxIHwgNTUxMjkgTWFpbnos
IEdlcm1hbnkNCg0KR2VzY2jDpGZ0c2bDvGhyZXI6IERpcGwuLUluZy4gTWljaGFlbCBNaXRlemtp
LCBEaXBsLi1JbmcuIEJvZG8gSHViZXIsDQpEaXBsLi1JbmcuIChGSCkgTWFya3VzIExpY2tlcyB8
IEhhbmRlbHNyZWdpc3RlciBNYWlueiBIUkIgNDY1NiB8DQpGaW5hbnphbXQgTWFpbnogfCBTdC5O
ci4gMjY2NTAwNjA4LCBERSAxNDkwNTk4NTUNCg==
