Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87488C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 12:34:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B3A198858E;
	Thu, 23 May 2024 14:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="phrPQXh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 001DC88496; Thu, 23 May 2024 12:59:48 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6C7C6884EC
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 12:59:45 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C25DF120015;
 Thu, 23 May 2024 13:59:44 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C25DF120015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1716461984;
 bh=4Oy/eCnCCWN8R/oPLV+M92/gjmHapmUghIRgTUawrjo=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=phrPQXh5BTynV0PpfjR+IIv32GOYdGcOTxXuRaYdsfFm5rdMmQK8kdTnEeCyxrDjN
 nMqevFduUQ6073LeX/JmUQFf7j+7uC/nQbQCHs+sBFbR07OwSVGiBQfUKNMp3/bfE2
 Di/5CAoGPhZr+T7HQ7SnDtAu4FXoV5At+TncFpQGY7FKcdu4MMZ0GX/svVVj2ArOXy
 nK1dLwEo5R3xzFH3yOP7P9j+sgSLGKPDAo+p1OeCPH9tjAl2sVr6k4fOpzPFHbvmE3
 2+SdM7YnDIbe0PJO1ceHkgLmcwIs+TNiidoMfSi2lesM4w/1SZ+trokvHEdNiVjDNa
 eWE1rqNoBfBdw==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 23 May 2024 13:59:44 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 23 May 2024 13:59:44 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Thu, 23 May 2024 13:59:44 +0300
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
Subject: Re: [PATCH v2 0/6] Introduce UBI block device
Thread-Topic: [PATCH v2 0/6] Introduce UBI block device
Thread-Index: AQHafsKY1wi7DQ3h+k+mVy5zB7Awi7GKSvmAgAAAjACAGoJ3AIAAAI2AgAACRIA=
Date: Thu, 23 May 2024 10:59:43 +0000
Message-ID: <20240523105931.a6teu5moqei4i7jc@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
 <CAOf5uwmV8s-mcNM42nC664uW=+s0waiJsr911UfmxJ32XJgJAQ@mail.gmail.com>
 <20240523104925.fwzfztgigojhjw6s@cab-wsm-0029881.sigma.sbrf.ru>
 <CAOf5uwkBq2yPyC982b6LJKoRk6B1+J8-ecj5xZbzyzFk-M7AeA@mail.gmail.com>
In-Reply-To: <CAOf5uwkBq2yPyC982b6LJKoRk6B1+J8-ecj5xZbzyzFk-M7AeA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2B4273FAC23C5745BCD06438E5DA67DF@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185438 [May 23 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 smtp.sberdevices.ru:5.0.1,7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 lore.kernel.org:7.1.1; cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/05/23 09:24:00
X-KSMG-LinksScanning: Clean, bases: 2024/05/23 09:24:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/05/23 07:54:00 #25244744
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 23 May 2024 14:33:40 +0200
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

T24gVGh1LCBNYXkgMjMsIDIwMjQgYXQgMTI6NTE6MzNQTSArMDIwMCwgTWljaGFlbCBOYXp6YXJl
bm8gVHJpbWFyY2hpIHdyb3RlOg0KPiBIaQ0KPiANCj4gV2UgcXVldWUgdGhlbSB0aGlzIGFmdGVy
bm9vbg0KDQpUaGFuayB5b3UuDQoNCkkgYWxzbyB3YW50ZWQgdG8gcmVtaW5kIHlvdSB0aGF0IHRo
ZXJlIGlzIHN0aWxsIGEgc2ltaWxpYXIgcGF0Y2hlc3Qgd2l0aA0KbXRkYmxvY2sgc3VwcG9ydCAo
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwNTA2MTM1NjA3LmFwcmpxbjd1eW5nMmpn
cDVAY2FiLXdzbS0wMDI5ODgxLykNCnRoYXQgc2hvdWxkIGJlIGFwcGxpZWQgdG8gYnJhY25oIGJl
Zm9yZSB0aGlzLg0KDQo+IA0KPiBNaWNoYWVsDQo+IA0KPiBPbiBUaHUsIE1heSAyMywgMjAyNCBh
dCAxMjo0OeKAr1BNIEFsZXhleSBSb21hbm92DQo+IDxhdnJvbWFub3ZAc2FsdXRlZGV2aWNlcy5j
b20+IHdyb3RlOg0KPiA+DQo+ID4NCj4gPiBIaSBNaWNoYWVsLA0KPiA+DQo+ID4gT24gTW9uLCBN
YXkgMDYsIDIwMjQgYXQgMDM6NTk6NTJQTSArMDIwMCwgTWljaGFlbCBOYXp6YXJlbm8gVHJpbWFy
Y2hpIHdyb3RlOg0KPiA+ID4gSGkgQWxleGV5DQo+ID4gPg0KPiA+ID4gU29ycnkgd2lsbCB3aWxs
IHB1dCBvbiBDSQ0KPiA+DQo+ID4gQW55IG5ld3M/DQo+ID4NCj4gPiA+DQo+ID4gPiBNaWNoYWVs
DQo+ID4gPg0KPiA+ID4gT24gTW9uLCBNYXkgNiwgMjAyNCBhdCAzOjU44oCvUE0gQWxleGV5IFJv
bWFub3YNCj4gPiA+IDxhdnJvbWFub3ZAc2FsdXRlZGV2aWNlcy5jb20+IHdyb3RlOg0KPiA+ID4g
Pg0KPiA+ID4gPiBIZWxsbyEgUGluZy4NCj4gPiA+ID4NCj4gPiA+ID4gT24gTW9uLCBNYXIgMjUs
IDIwMjQgYXQgMDU6NDE6NDJQTSArMDMwMCwgQWxleGV5IFJvbWFub3Ygd3JvdGU6DQo+ID4gPiA+
ID4gSGVsbG8hDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQg
Zm9yIHRoZSBVQkkgYmxvY2sgZGV2aWNlLCB3aGljaA0KPiA+ID4gPiA+IGFsbG93cyB0byByZWFk
L3dyaXRlIGRhdGEgYmxvY2sgYnkgYmxvY2suIEZvciBleGFtcGxlLA0KPiA+ID4gPiA+IGl0IGNh
biBub3cgYmUgdXNlZCBmb3IgQkNCIG9yIEFuZHJvaWQgQUIgY29tbWFuZDoNCj4gPiA+ID4gPg0K
PiA+ID4gPiA+ICAgJCBiY2IgbG9hZCB1YmkgMCBwYXJ0X25hbWUNCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFRlc3RlZCBvbmx5IG9uIFNQSSBOQU5ELCBzbyBiaW5kIGlzIG1hZGUgb25seSBmb3INCj4g
PiA+ID4gPiBTUEkgTkFORCBkcml2ZXJzLiBDYW4gYmUgdXNlZCB3aXRoIG10ZGJsb2NrIGRldmlj
ZSBbMV0uDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IENo
YW5nZXMgVjEgLT4gVjIgWzJdOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gIC0gUmViYXNlZCBvdmVy
IG10ZGJsb2NrIHYyIHBhdGNoc2V0IFszXS4NCj4gPiA+ID4gPiAgLSBDb21waWxlIFVCSSBwYXJ0
aXRpb25zIHN1cHBvcnQgb25seSBpZiBDT05GSUdfQkxLIG9wdGlvbg0KPiA+ID4gPiA+ICAgIGlz
IGVuYWJsZWQuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAtIExpbmtzOg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gICBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjI3MTAwNDQxLjE4
MTEwNDctMS1hdnJvbWFub3ZAc2FsdXRlZGV2aWNlcy5jb20vDQo+ID4gPiA+ID4gICBbMl0gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMzA2MTM0OTA2LjExNzkyODUtMS1hdnJvbWFu
b3ZAc2FsdXRlZGV2aWNlcy5jb20vDQo+ID4gPiA+ID4gICBbM10gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwMzA3MTMwNzI2LjE1ODI0ODctMS1hdnJvbWFub3ZAc2FsdXRlZGV2aWNl
cy5jb20vDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbGV4ZXkgUm9tYW5vdiAoNik6DQo+ID4gPiA+
ID4gICB1Ymk6IGFsbG93IHRvIHJlYWQgZnJvbSB2b2x1bWUgd2l0aCBvZmZzZXQNCj4gPiA+ID4g
PiAgIHViaTogYWxsb3cgdG8gd3JpdGUgdG8gdm9sdW1lIHdpdGggb2Zmc2V0DQo+ID4gPiA+ID4g
ICBkcml2ZXJzOiBpbnRyb2R1Y2UgVUJJIGJsb2NrIGFic3RyYWN0aW9uDQo+ID4gPiA+ID4gICBk
aXNrOiBkb24ndCB0cnkgc2VhcmNoIGZvciBwYXJ0aXRpb24gdHlwZSBpZiBhbHJlYWR5IHNldA0K
PiA+ID4gPiA+ICAgZGlzazogc3VwcG9ydCBVQkkgcGFydGl0aW9ucw0KPiA+ID4gPiA+ICAgc3Bp
bmFuZDogYmluZCBVQkkgYmxvY2sNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICBjbWQvdWJpLmMgICAg
ICAgICAgICAgICAgICAgfCAgNzcgKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gPiA+ID4gIGRp
c2svcGFydC5jICAgICAgICAgICAgICAgICB8ICAgNyArKw0KPiA+ID4gPiA+ICBkcml2ZXJzL2Js
b2NrL2Jsay11Y2xhc3MuYyAgfCAgIDEgKw0KPiA+ID4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3Nw
aS9jb3JlLmMgfCAgIDggKystDQo+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL3ViaS9NYWtlZmlsZSAg
ICB8ICAgMSArDQo+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL3ViaS9ibG9jay5jICAgICB8IDEzMCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gPiAgZHJpdmVycy9t
dGQvdWJpL3BhcnQuYyAgICAgIHwgIDk5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+
ID4gPiA+ICBlbnYvdWJpLmMgICAgICAgICAgICAgICAgICAgfCAgMTYgKystLS0NCj4gPiA+ID4g
PiAgaW5jbHVkZS9wYXJ0LmggICAgICAgICAgICAgIHwgICAyICsNCj4gPiA+ID4gPiAgaW5jbHVk
ZS91YmlfdWJvb3QuaCAgICAgICAgIHwgICA4ICsrLQ0KPiA+ID4gPiA+ICAxMCBmaWxlcyBjaGFu
Z2VkLCAzMzIgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4gIGNyZWF0
ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL210ZC91YmkvYmxvY2suYw0KPiA+ID4gPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvdWJpL3BhcnQuYw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
LS0NCj4gPiA+ID4gPiAyLjM0LjENCj4gPiA+ID4gPg0KPiA+ID4gPg0KPiA+ID4gPiAtLQ0KPiA+
ID4gPiBUaGFuayB5b3UsDQo+ID4gPiA+IEFsZXhleQ0KPiA+ID4NCj4gPiA+DQo+ID4gPg0KPiA+
ID4gLS0NCj4gPiA+IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1hcmNoaQ0KPiA+ID4gQ28tRm91bmRl
ciAmIENoaWVmIEV4ZWN1dGl2ZSBPZmZpY2VyDQo+ID4gPiBNLiArMzkgMzQ3IDkxMyAyMTcwDQo+
ID4gPiBtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+ID4gPiBfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fDQo+ID4gPg0KPiA+ID4gQW1hcnVsYSBTb2x1dGlvbnMgQlYNCj4g
PiA+IEpvb3AgR2Vlc2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3RlcmRhbSwgTkwNCj4gPiA+IFQu
ICszMSAoMCk4NSAxMTEgOTE3Mg0KPiA+ID4gaW5mb0BhbWFydWxhc29sdXRpb25zLmNvbQ0KPiA+
ID4gd3d3LmFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+ID4NCj4gPiAtLQ0KPiA+IFRoYW5rIHlvdSwN
Cj4gPiBBbGV4ZXkNCj4gDQo+IA0KPiANCj4gLS0gDQo+IE1pY2hhZWwgTmF6emFyZW5vIFRyaW1h
cmNoaQ0KPiBDby1Gb3VuZGVyICYgQ2hpZWYgRXhlY3V0aXZlIE9mZmljZXINCj4gTS4gKzM5IDM0
NyA5MTMgMjE3MA0KPiBtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IF9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18NCj4gDQo+IEFtYXJ1bGEgU29sdXRpb25zIEJWDQo+IEpv
b3AgR2Vlc2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3RlcmRhbSwgTkwNCj4gVC4gKzMxICgwKTg1
IDExMSA5MTcyDQo+IGluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gd3d3LmFtYXJ1bGFzb2x1
dGlvbnMuY29tDQoNCi0tIA0KVGhhbmsgeW91LA0KQWxleGV5
