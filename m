Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5993C25B79
	for <u-boot@archiver.kernel.org>; Thu, 23 May 2024 12:33:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 530DF88571;
	Thu, 23 May 2024 14:33:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="iWQ5SOKC";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C43DE884E6; Thu, 23 May 2024 12:49:42 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6766087F7D
 for <u-boot@lists.denx.de>; Thu, 23 May 2024 12:49:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id BEE10120004;
 Thu, 23 May 2024 13:49:39 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru BEE10120004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1716461379;
 bh=cyISiayQQMV4/xocZuTO1Xt95/MDRwJaG295BlfCm1Y=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=iWQ5SOKCrghjbYoFsok1MB0dcSuID31bnhydsBzxYovLacLAPHAjydyxpnEfnyLgz
 XMhRqth/T+QTx/61NaSSy8gh1Wlxkp0lfu6J0Fgj/xyvKFcPeIyY/O5aSaDAhaKXmH
 n9J1VLTwvt5uRCsI7y8G5n8ksQDuQgaYRNkilkRZyYwGQN8zq0NcbfqQ6SCrVxmxhR
 aaNcmOAPi5lKUyx4+fG0ZfEYX3wLO/zSVqXApG0NPaqnCNGnommc8fyGPVJ41aj2Ws
 LfZ1G5w+3pvpGjg6qepTt3vYxriUCLThYzJEaTD+bT3xmDFnCeWcl16A0AryQ/RJKU
 wdzdg44mnqY9w==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m02.sberdevices.ru
 [172.16.192.103])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu, 23 May 2024 13:49:39 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 23 May 2024 13:49:39 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Thu, 23 May 2024 13:49:39 +0300
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
Thread-Index: AQHafsKY1wi7DQ3h+k+mVy5zB7Awi7GKSvmAgAAAjACAGoJ3AA==
Date: Thu, 23 May 2024 10:49:39 +0000
Message-ID: <20240523104925.fwzfztgigojhjw6s@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240506135755.pgpttzekxd6g3css@cab-wsm-0029881>
 <CAOf5uwmV8s-mcNM42nC664uW=+s0waiJsr911UfmxJ32XJgJAQ@mail.gmail.com>
In-Reply-To: <CAOf5uwmV8s-mcNM42nC664uW=+s0waiJsr911UfmxJ32XJgJAQ@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F15A0417E7F66C47BCF6A4DECBBEEBDF@sberdevices.ru>
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
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1; d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;
 cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 lore.kernel.org:7.1.1, FromAlignment: s
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

DQpIaSBNaWNoYWVsLA0KDQpPbiBNb24sIE1heSAwNiwgMjAyNCBhdCAwMzo1OTo1MlBNICswMjAw
LCBNaWNoYWVsIE5henphcmVubyBUcmltYXJjaGkgd3JvdGU6DQo+IEhpIEFsZXhleQ0KPiANCj4g
U29ycnkgd2lsbCB3aWxsIHB1dCBvbiBDSQ0KDQpBbnkgbmV3cz8NCg0KPiANCj4gTWljaGFlbA0K
PiANCj4gT24gTW9uLCBNYXkgNiwgMjAyNCBhdCAzOjU44oCvUE0gQWxleGV5IFJvbWFub3YNCj4g
PGF2cm9tYW5vdkBzYWx1dGVkZXZpY2VzLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIZWxsbyEgUGlu
Zy4NCj4gPg0KPiA+IE9uIE1vbiwgTWFyIDI1LCAyMDI0IGF0IDA1OjQxOjQyUE0gKzAzMDAsIEFs
ZXhleSBSb21hbm92IHdyb3RlOg0KPiA+ID4gSGVsbG8hDQo+ID4gPg0KPiA+ID4gVGhpcyBzZXJp
ZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgVUJJIGJsb2NrIGRldmljZSwgd2hpY2gNCj4gPiA+IGFs
bG93cyB0byByZWFkL3dyaXRlIGRhdGEgYmxvY2sgYnkgYmxvY2suIEZvciBleGFtcGxlLA0KPiA+
ID4gaXQgY2FuIG5vdyBiZSB1c2VkIGZvciBCQ0Igb3IgQW5kcm9pZCBBQiBjb21tYW5kOg0KPiA+
ID4NCj4gPiA+ICAgJCBiY2IgbG9hZCB1YmkgMCBwYXJ0X25hbWUNCj4gPiA+DQo+ID4gPiBUZXN0
ZWQgb25seSBvbiBTUEkgTkFORCwgc28gYmluZCBpcyBtYWRlIG9ubHkgZm9yDQo+ID4gPiBTUEkg
TkFORCBkcml2ZXJzLiBDYW4gYmUgdXNlZCB3aXRoIG10ZGJsb2NrIGRldmljZSBbMV0uDQo+ID4g
Pg0KPiA+ID4gLS0tDQo+ID4gPg0KPiA+ID4gQ2hhbmdlcyBWMSAtPiBWMiBbMl06DQo+ID4gPg0K
PiA+ID4gIC0gUmViYXNlZCBvdmVyIG10ZGJsb2NrIHYyIHBhdGNoc2V0IFszXS4NCj4gPiA+ICAt
IENvbXBpbGUgVUJJIHBhcnRpdGlvbnMgc3VwcG9ydCBvbmx5IGlmIENPTkZJR19CTEsgb3B0aW9u
DQo+ID4gPiAgICBpcyBlbmFibGVkLg0KPiA+ID4NCj4gPiA+IC0gTGlua3M6DQo+ID4gPg0KPiA+
ID4gICBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjQwMjI3MTAwNDQxLjE4MTEw
NDctMS1hdnJvbWFub3ZAc2FsdXRlZGV2aWNlcy5jb20vDQo+ID4gPiAgIFsyXSBodHRwczovL2xv
cmUua2VybmVsLm9yZy9hbGwvMjAyNDAzMDYxMzQ5MDYuMTE3OTI4NS0xLWF2cm9tYW5vdkBzYWx1
dGVkZXZpY2VzLmNvbS8NCj4gPiA+ICAgWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8y
MDI0MDMwNzEzMDcyNi4xNTgyNDg3LTEtYXZyb21hbm92QHNhbHV0ZWRldmljZXMuY29tLw0KPiA+
ID4NCj4gPiA+IEFsZXhleSBSb21hbm92ICg2KToNCj4gPiA+ICAgdWJpOiBhbGxvdyB0byByZWFk
IGZyb20gdm9sdW1lIHdpdGggb2Zmc2V0DQo+ID4gPiAgIHViaTogYWxsb3cgdG8gd3JpdGUgdG8g
dm9sdW1lIHdpdGggb2Zmc2V0DQo+ID4gPiAgIGRyaXZlcnM6IGludHJvZHVjZSBVQkkgYmxvY2sg
YWJzdHJhY3Rpb24NCj4gPiA+ICAgZGlzazogZG9uJ3QgdHJ5IHNlYXJjaCBmb3IgcGFydGl0aW9u
IHR5cGUgaWYgYWxyZWFkeSBzZXQNCj4gPiA+ICAgZGlzazogc3VwcG9ydCBVQkkgcGFydGl0aW9u
cw0KPiA+ID4gICBzcGluYW5kOiBiaW5kIFVCSSBibG9jaw0KPiA+ID4NCj4gPiA+ICBjbWQvdWJp
LmMgICAgICAgICAgICAgICAgICAgfCAgNzcgKysrKysrKysrKysrKysrKysrKy0tDQo+ID4gPiAg
ZGlzay9wYXJ0LmMgICAgICAgICAgICAgICAgIHwgICA3ICsrDQo+ID4gPiAgZHJpdmVycy9ibG9j
ay9ibGstdWNsYXNzLmMgIHwgICAxICsNCj4gPiA+ICBkcml2ZXJzL210ZC9uYW5kL3NwaS9jb3Jl
LmMgfCAgIDggKystDQo+ID4gPiAgZHJpdmVycy9tdGQvdWJpL01ha2VmaWxlICAgIHwgICAxICsN
Cj4gPiA+ICBkcml2ZXJzL210ZC91YmkvYmxvY2suYyAgICAgfCAxMzAgKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiAgZHJpdmVycy9tdGQvdWJpL3BhcnQuYyAgICAg
IHwgIDk5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ID4gIGVudi91YmkuYyAgICAg
ICAgICAgICAgICAgICB8ICAxNiArKy0tLQ0KPiA+ID4gIGluY2x1ZGUvcGFydC5oICAgICAgICAg
ICAgICB8ICAgMiArDQo+ID4gPiAgaW5jbHVkZS91YmlfdWJvb3QuaCAgICAgICAgIHwgICA4ICsr
LQ0KPiA+ID4gIDEwIGZpbGVzIGNoYW5nZWQsIDMzMiBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlv
bnMoLSkNCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvdWJpL2Jsb2NrLmMN
Cj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9tdGQvdWJpL3BhcnQuYw0KPiA+ID4N
Cj4gPiA+IC0tDQo+ID4gPiAyLjM0LjENCj4gPiA+DQo+ID4NCj4gPiAtLQ0KPiA+IFRoYW5rIHlv
dSwNCj4gPiBBbGV4ZXkNCj4gDQo+IA0KPiANCj4gLS0gDQo+IE1pY2hhZWwgTmF6emFyZW5vIFRy
aW1hcmNoaQ0KPiBDby1Gb3VuZGVyICYgQ2hpZWYgRXhlY3V0aXZlIE9mZmljZXINCj4gTS4gKzM5
IDM0NyA5MTMgMjE3MA0KPiBtaWNoYWVsQGFtYXJ1bGFzb2x1dGlvbnMuY29tDQo+IF9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gDQo+IEFtYXJ1bGEgU29sdXRpb25zIEJWDQo+
IEpvb3AgR2Vlc2lua3dlZyAxMjUsIDExMTQgQUIsIEFtc3RlcmRhbSwgTkwNCj4gVC4gKzMxICgw
KTg1IDExMSA5MTcyDQo+IGluZm9AYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4gd3d3LmFtYXJ1bGFz
b2x1dGlvbnMuY29tDQoNCi0tIA0KVGhhbmsgeW91LA0KQWxleGV5
