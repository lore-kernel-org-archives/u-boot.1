Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843C0C25B4F
	for <u-boot@archiver.kernel.org>; Mon,  6 May 2024 15:22:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EB3DD881A0;
	Mon,  6 May 2024 17:22:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="bxb5+Tx8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D26BF8859F; Mon,  6 May 2024 15:56:21 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6BFF4884F6
 for <u-boot@lists.denx.de>; Mon,  6 May 2024 15:56:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id B6C64100006;
 Mon,  6 May 2024 16:56:18 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru B6C64100006
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1715003778;
 bh=HZa5uTLgKVQ/zVPin3RXzPw+s74KMtm5c6xUkzvr7Kw=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=bxb5+Tx8//xhHNXlr7jPSBnce/DEuyBxPPRA9vtkueV3nBBw6BQzZowyzQR1X2xB4
 qPAXhteJ3GC9rUWUckW61fus+gToK88BmFtWR1sh47eEo8/lu6ra0OLwOLJ3+HFbuN
 HyiaEj4ek/xdoXY79Sc+3zpkW2OFJkw81v92H+QyAHGMhql8YjBwhEZ7/ZrXD+I0pL
 /BE+yU8k2zrgrAM5N0jnN1uzsmC3kUCowX34bNI8WqhYBWvP28gYWuTjLvq+lsHKJP
 Lc5S2BGt+yi+1rL4XvAMnYyo0XUzBnBXyY09d9IfsNrEEHcihv6r0gvpZuxjQDW/5r
 H3O43GEZM7pug==
Received: from smtp.sberdevices.ru (p-i-exch-a-m2.sberdevices.ru
 [172.24.196.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon,  6 May 2024 16:56:18 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m2.sberdevices.ru (172.24.196.120) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 6 May 2024 16:56:18 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Mon, 6 May 2024 16:56:17 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "frieder.schrempf@kontron.de"
 <frieder.schrempf@kontron.de>, "kmpark@infradead.org" <kmpark@infradead.org>, 
 "hs@denx.de" <hs@denx.de>, "joe.hershberger@ni.com" <joe.hershberger@ni.com>, 
 "dunaev@tecon.ru" <dunaev@tecon.ru>, "sjg@chromium.org" <sjg@chromium.org>,
 "bmeng@tinylab.org" <bmeng@tinylab.org>, "xypron.glpk@gmx.de"
 <xypron.glpk@gmx.de>, "tobias@waldekranz.com" <tobias@waldekranz.com>,
 "jpewhacker@gmail.com" <jpewhacker@gmail.com>,
 "marek.vasut+renesas@mailbox.org" <marek.vasut+renesas@mailbox.org>,
 "kever.yang@rock-chips.com" <kever.yang@rock-chips.com>, "jbx6244@gmail.com"
 <jbx6244@gmail.com>, "abdellatif.elkhlifi@arm.com"
 <abdellatif.elkhlifi@arm.com>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, "jagan@amarulasolutions.com"
 <jagan@amarulasolutions.com>, kernel <kernel@sberdevices.ru>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 0/3] Introduce mtdblock device
Thread-Topic: [PATCH v3 0/3] Introduce mtdblock device
Thread-Index: AQHahn8E065oAbZrwUS8pgiLN8ifkbFjFfGAgAABb4CAJyOngA==
Date: Mon, 6 May 2024 13:56:17 +0000
Message-ID: <20240506135607.aprjqn7uyng2jgp5@cab-wsm-0029881>
References: <20240404105813.1520732-1-avromanov@salutedevices.com>
 <20240411160857.fb6a2neossmz2d4y@cab-wsm-0029881.sigma.sbrf.ru>
 <CAOf5uwkGoHVzDvvz3pqCsro2VC+Vxj-YaKKkye=n=AU8w8dJmA@mail.gmail.com>
In-Reply-To: <CAOf5uwkGoHVzDvvz3pqCsro2VC+Vxj-YaKKkye=n=AU8w8dJmA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF798F4C84A17246A5EAC9CD6575B298@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185086 [May 06 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 19 0.3.19
 07c7fa124d1a1dc9662cdc5aace418c06ae99d2b, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; lore.kernel.org:7.1.1;
 smtp.sberdevices.ru:5.0.1,7.1.1; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/06 13:00:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/06 13:00:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/05/06 12:01:00 #25108659
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 06 May 2024 17:22:47 +0200
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

SGVsbG8gTWljaGFlbCwNCg0KT24gVGh1LCBBcHIgMTEsIDIwMjQgYXQgMDY6MTQ6MjlQTSArMDIw
MCwgTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFyY2hpIHdyb3RlOg0KPiBIaQ0KPiANCj4gSSB3aWxs
IHJldmlldyB0b21vcnJvdywgSSBuZWVkIGhhdmUgYSB0aW1lIHdpbmRvdyB0byB0ZXN0IGV2ZW4g
b24gbXkgYm9hcmQNCg0KQW55IG5ld3M/DQoNCj4gDQo+IE1paGNhZWwNCj4gDQo+IE9uIFRodSwg
QXByIDExLCAyMDI0IGF0IDY6MDnigK9QTSBBbGV4ZXkgUm9tYW5vdg0KPiA8YXZyb21hbm92QHNh
bHV0ZWRldmljZXMuY29tPiB3cm90ZToNCj4gPg0KPiA+IEhlbGxvISBQaW5nLg0KPiA+DQo+ID4g
T24gVGh1LCBBcHIgMDQsIDIwMjQgYXQgMDE6NTg6MTBQTSArMDMwMCwgQWxleGV5IFJvbWFub3Yg
d3JvdGU6DQo+ID4gPiBIZWxsbyENCj4gPiA+DQo+ID4gPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBv
cnQgZm9yIHRoZSBtdGRibG9jayBkZXZpY2UsIHdoaWNoDQo+ID4gPiBhbGxvd3MgdG8gcmVhZC93
cml0ZSBkYXRhIGJsb2NrIGJ5IGJsb2NrLiBGb3IgZXhhbXBsZSwNCj4gPiA+IGl0IGNhbiBub3cg
YmUgdXNlZCBmb3IgQkNCIG9yIEFuZHJvaWQgQUIgY29tbWFuZDoNCj4gPiA+DQo+ID4gPiAgICQg
YmNiIGxvYWQgbXRkIDAgcGFydF9uYW1lDQo+ID4gPg0KPiA+ID4gVGVzdGVkIG9ubHkgb24gU1BJ
IE5BTkQsIHNvIGJpbmQgaXMgbWFkZSBvbmx5IGZvcg0KPiA+ID4gU1BJIE5BTkQgZHJpdmVycy4N
Cj4gPiA+DQo+ID4gPiAtLS0NCj4gPiA+DQo+ID4gPiBDaGFuZ2VzIFYxIC0+IFYyIFsxXToNCj4g
PiA+DQo+ID4gPiAgIC0gRHJvcCBwYXRjaCBbMl0uDQo+ID4gPiAgIC0gQWRkIHdhcm5pbmcgaWYg
YmluZCBOQU5EIG10ZGJsb2NrIGRldmljZS4NCj4gPiA+ICAgLSBNb3ZlIGRvY3VtZW50YXRpb24g
b2YgbXRkYmxvY2sgaW1wbGVtZW50YXRpb24NCj4gPiA+ICAgICBmcm9tIGNvbW1pdCBtZXNzYWdl
IHRvIHRoZSBzb3VyY2UgY29kZS4NCj4gPiA+ICAgLSBSZW1vdmUgX19tYXliZV91bnVzZWQgZnJv
bSBtdGQgcGFydGl0aW9uIGZ1bmN0aW9ucw0KPiA+ID4gICAgIGRlc2NyaXB0aW9uLg0KPiA+ID4g
ICAtIFVzZSBibGtfZW5hYmxlZCgpIGluc3RlYWQgb2YgI2lmZGVmcy4NCj4gPiA+DQo+ID4gPiBD
aGFuZ2VzIFYyIC0+IFYzIFsyXToNCj4gPiA+DQo+ID4gPiAgIC0gUmViYXNlZCBvdmVyIFszXS4N
Cj4gPiA+ICAgLSBSZW5hbWUgbXRkX2JyZWFkL2J3cml0ZSAtPiBtdGRfYmxrX3JlYWQvd3JpdGUu
DQo+ID4gPiAgIC0gRml4IEdQTC0yLjAgbGljZW5zZSBzaG9ydCBuYW1lIGRlZmluaXRvbiBpbiBo
ZWFkZXJzLg0KPiA+ID4gICAtIEFkZCBlbXB0eSBsaW5lIGFmdGVyIE1URF9FTlRSWV9OVU1CRVJT
IGRlZmluZS4NCj4gPiA+DQo+ID4gPiBMaW5rczoNCj4gPiA+DQo+ID4gPiAgIC0gWzFdIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI0MDIyNzEwMDQ0MS4xODExMDQ3LTEtYXZyb21hbm92
QHNhbHV0ZWRldmljZXMuY29tLw0KPiA+ID4gICAtIFsyXSBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvMjAyNDAyMjcxMDA0NDEuMTgxMTA0Ny01LWF2cm9tYW5vdkBzYWx1dGVkZXZpY2VzLmNv
bS8NCj4gPiA+ICAgLSBbM10gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvdS1ib290LzIwMjQwNDAz
MTE0MDQ3Ljg0MDMwLTEtaGVpbnJpY2guc2NodWNoYXJkdEBjYW5vbmljYWwuY29tL1QvI3UNCj4g
PiA+DQo+ID4gPiBBbGV4ZXkgUm9tYW5vdiAoMyk6DQo+ID4gPiAgIGRpc2s6IHN1cHBvcnQgTVRE
IHBhcnRpdGlvbnMNCj4gPiA+ICAgZHJpdmVyczogaW50cm9kdWNlIG10ZGJsb2NrIGFic3RyYWN0
aW9uDQo+ID4gPiAgIHNwaW5hbmQ6IGJpbmQgbXRkYmxvY2sNCj4gPiA+DQo+ID4gPiAgZGlzay9w
YXJ0LmMgICAgICAgICAgICAgICAgIHwgICAzICstDQo+ID4gPiAgZHJpdmVycy9ibG9jay9ibGst
dWNsYXNzLmMgIHwgICAxICsNCj4gPiA+ICBkcml2ZXJzL210ZC9LY29uZmlnICAgICAgICAgfCAg
IDEgKw0KPiA+ID4gIGRyaXZlcnMvbXRkL01ha2VmaWxlICAgICAgICB8ICAgMSArDQo+ID4gPiAg
ZHJpdmVycy9tdGQvbXRkYmxvY2suYyAgICAgIHwgMjI3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvbXRkL210ZHBhcnQuYyAgICAgICB8ICA2OSAr
KysrKysrKysrKw0KPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyB8ICAyMCArKysr
DQo+ID4gPiAgaW5jbHVkZS9saW51eC9tdGQvbXRkLmggICAgIHwgIDEyICsrDQo+ID4gPiAgaW5j
bHVkZS9wYXJ0LmggICAgICAgICAgICAgIHwgICAzICsNCj4gPiA+ICA5IGZpbGVzIGNoYW5nZWQs
IDMzNiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gPiAgY3JlYXRlIG1vZGUgMTAw
NjQ0IGRyaXZlcnMvbXRkL210ZGJsb2NrLmMNCj4gPiA+DQo+ID4gPiAtLQ0KPiA+ID4gMi4zNC4x
DQo+ID4gPg0KPiA+DQo+ID4gLS0NCj4gPiBUaGFuayB5b3UsDQo+ID4gQWxleGV5DQo+IA0KPiAN
Cj4gDQo+IC0tIA0KPiBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkNCj4gQ28tRm91bmRlciAm
IENoaWVmIEV4ZWN1dGl2ZSBPZmZpY2VyDQo+IE0uICszOSAzNDcgOTEzIDIxNzANCj4gbWljaGFl
bEBhbWFydWxhc29sdXRpb25zLmNvbQ0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fDQo+IA0KPiBBbWFydWxhIFNvbHV0aW9ucyBCVg0KPiBKb29wIEdlZXNpbmt3ZWcgMTI1LCAx
MTE0IEFCLCBBbXN0ZXJkYW0sIE5MDQo+IFQuICszMSAoMCk4NSAxMTEgOTE3Mg0KPiBpbmZvQGFt
YXJ1bGFzb2x1dGlvbnMuY29tDQo+IHd3dy5hbWFydWxhc29sdXRpb25zLmNvbQ0KDQotLSANClRo
YW5rIHlvdSwNCkFsZXhleQ==
