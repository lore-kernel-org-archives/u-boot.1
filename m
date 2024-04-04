Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3D2CD1284
	for <u-boot@archiver.kernel.org>; Thu,  4 Apr 2024 10:45:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 656428841B;
	Thu,  4 Apr 2024 12:45:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="MNYq8H36";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6DFFE883AB; Thu,  4 Apr 2024 10:02:19 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2A9EF883DA
 for <u-boot@lists.denx.de>; Thu,  4 Apr 2024 10:02:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id 70B0B12000E;
 Thu,  4 Apr 2024 11:02:16 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 70B0B12000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1712217736;
 bh=wjmBqXEBVF+bciXXs0gu3qGwoVNYN+noCk05X7XaZKI=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=MNYq8H36UwrgsX2mWxyiq9kWIAIh0U3xh/hAAvlHtNMYTvg/0xvBuyyWtfYhpZgH8
 /+aEVRgc560YzucM8mCjvOoYQj5z9gAFCNpaSQ1vrqqOweC8L1Jw6wei9a6maXAKnB
 M7toRtEKSWeJarUBkpumoZRoEXU7cUhBrLn/2bf2eTq26WybxuMHu/4OK2wdDQbDws
 81zRywZPMUu6/7oXtasttx68NHr30voXpCYOhx6rZvLJfTo+Qsz+afXtnPYs41+t1p
 oyF3Rxgue+/QsLdKy5afSdSERVlciftkPW62yGzNjYpt0yZfJ+9r56OSZAoohC+rP4
 tqOLa0Lz9uvHQ==
Received: from smtp.sberdevices.ru (p-i-exch-a-m1.sberdevices.ru
 [172.24.196.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Thu,  4 Apr 2024 11:02:16 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-a-m1.sberdevices.ru (172.24.196.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 11:02:15 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::10c3:6e04:fd07:c511%9]) with
 mapi id 15.02.1118.040; Thu, 4 Apr 2024 11:02:15 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Chuanhong Guo <gch981213@gmail.com>
CC: "dario.binacchi@amarulasolutions.com"
 <dario.binacchi@amarulasolutions.com>, "michael@amarulasolutions.com"
 <michael@amarulasolutions.com>, "frieder.schrempf@kontron.de"
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
Subject: Re: [PATCH v2 6/6] spinand: bind UBI block
Thread-Topic: [PATCH v2 6/6] spinand: bind UBI block
Thread-Index: AQHafsKiT9RWZRutFkKKNXbYDvXRRbFXTzKAgABNyAA=
Date: Thu, 4 Apr 2024 08:02:15 +0000
Message-ID: <20240404080210.5f5u4r223b4oauum@cab-wsm-0029881.sigma.sbrf.ru>
References: <20240325144148.3738195-1-avromanov@salutedevices.com>
 <20240325144148.3738195-7-avromanov@salutedevices.com>
 <CAJsYDVJC6eTGCXi7m_s3FOpg8isnwRxnQbkAUeSvCRrHSYUdFA@mail.gmail.com>
In-Reply-To: <CAJsYDVJC6eTGCXi7m_s3FOpg8isnwRxnQbkAUeSvCRrHSYUdFA@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.93]
Content-Type: text/plain; charset="utf-8"
Content-ID: <10097791A042B44ABFBC8F1BAFDE991E@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184570 [Apr 04 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 14 0.3.14
 5a0c43d8a1c3c0e5b0916cc02a90d4b950c01f96, {Track_E25351},
 {Tracking_from_domain_doesnt_match_to}, smtp.sberdevices.ru:5.0.1,7.1.1;
 cab-wsm-0029881.sigma.sbrf.ru:5.0.1,7.1.1;
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; 127.0.0.199:7.1.2;
 salutedevices.com:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/04/04 05:57:00 #24651476
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Thu, 04 Apr 2024 12:45:42 +0200
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

SGksDQoNCk9uIFRodSwgQXByIDA0LCAyMDI0IGF0IDExOjIzOjQ3QU0gKzA4MDAsIENodWFuaG9u
ZyBHdW8gd3JvdGU6DQo+IEhlbGxvIQ0KPiANCj4gT24gTW9uLCBNYXIgMjUsIDIwMjQgYXQgMTA6
NDbigK9QTSBBbGV4ZXkgUm9tYW5vdg0KPiA8YXZyb21hbm92QHNhbHV0ZWRldmljZXMuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFVCSSBibG9jayBpcyB2aXJ0dWFsIGJsb2NrIGRldmljZSwgd2hpY2gg
aXMgYW4gYWJzdHJhY3Rpb24NCj4gPiBvdmVyIE1URCBsYXllci4gVGhlcmVmb3JlIGl0IGlzIGxv
Z2ljYWwgdG8gdXNlIGl0IGluIGNvbWJpbmF0aW9uDQo+ID4gd2l0aCBNVEQgZHJpdmVycy4NCj4g
Pg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFsZXhleSBSb21hbm92IDxhdnJvbWFub3ZAc2FsdXRlZGV2
aWNlcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyB8IDgg
KysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlv
bigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyBi
L2RyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYw0KPiA+IGluZGV4IGRkODgwYWRmMzEuLmM0N2Y2
YzFiNDYgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9tdGQvbmFuZC9zcGkvY29yZS5jDQo+ID4g
KysrIGIvZHJpdmVycy9tdGQvbmFuZC9zcGkvY29yZS5jDQo+ID4gQEAgLTI3LDYgKzI3LDcgQEAN
Cj4gPiAgI2luY2x1ZGUgPHdhdGNoZG9nLmg+DQo+ID4gICNpbmNsdWRlIDxzcGkuaD4NCj4gPiAg
I2luY2x1ZGUgPHNwaS1tZW0uaD4NCj4gPiArI2luY2x1ZGUgPHViaV91Ym9vdC5oPg0KPiA+ICAj
aW5jbHVkZSA8ZG0vZGV2aWNlX2NvbXBhdC5oPg0KPiA+ICAjaW5jbHVkZSA8ZG0vZGV2cmVzLmg+
DQo+ID4gICNpbmNsdWRlIDxkbS91Y2xhc3MuaD4NCj4gPiBAQCAtMTE4Miw4ICsxMTgzLDEzIEBA
IHN0YXRpYyBpbnQgc3BpbmFuZF9iaW5kKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4g
PiAgICAgICAgIGlmIChibGtfZW5hYmxlZCgpKSB7DQo+ID4gICAgICAgICAgICAgICAgIHN0cnVj
dCBzcGluYW5kX3BsYXQgKnBsYXQgPSBkZXZfZ2V0X3BsYXQoZGV2KTsNCj4gPiArICAgICAgICAg
ICAgICAgaW50IHJldDsNCj4gPiArDQo+ID4gKyAgICAgICAgICAgICAgIHJldCA9IG10ZF9iaW5k
KGRldiwgJnBsYXQtPm10ZCk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4gPg0KPiA+IC0gICAgICAgICAgICAg
ICByZXR1cm4gbXRkX2JpbmQoZGV2LCAmcGxhdC0+bXRkKTsNCj4gPiArICAgICAgICAgICAgICAg
cmV0dXJuIHViaV9iaW5kKGRldik7DQo+IA0KPiBJcyB0aGlzIGV4cGVjdGluZyB0aGUgZW50aXJl
IFNQSS1OQU5EIGNvdmVyZWQgYnkgYSBzaW5nbGUgVUJJIHBhcnRpdGlvbj8NCg0KV2h5PyBOYWgu
DQoNCnViaV9iaW5kKCkganVzdCBjcmVhdGUgYmxvY2sgZGV2aWNlIGFuZCBiaW5kIGl0IHRvIFNQ
SS1OQU5EIGRldmljZS4NCldoZW4gd29ya2luZyB3aXRoIHRoaXMgYmxvY2sgZGV2aWNlIHVzZXIg
bXVzdCBzcGVjaWZ5LCB3aGljaCBTUEktTkFORA0KcGFydGl0aW9uIFVCSSBpcyBsb2NhdGVkIG9u
Lg0KDQo+IEl0J3MgYWxtb3N0IG5ldmVyIHRoaXMgY2FzZSBvbiByZWFsIGhhcmR3YXJlLiBGb3Ig
U1BJLU5BTkQgYm9vdGVkDQo+IFNvQ3MsIHRoZSBmaXJzdCBmZXcgYmxvY2tzIGFsd2F5cyBzdG9y
ZSB0aGUgZmlyc3Qgc3RhZ2UgYm9vdGxvYWRlcg0KPiByYXcsIGJlY2F1c2UgYm9vdHJvbSBrbm93
cyBub3RoaW5nIGFib3V0IFVCSS4NCj4gDQo+ID4gICAgICAgICB9DQo+ID4NCj4gPiAgICAgICAg
IHJldHVybiAwOw0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gDQo+IA0KPiAtLSANCj4gUmVn
YXJkcywNCj4gQ2h1YW5ob25nIEd1bw0KDQotLSANClRoYW5rIHlvdSwNCkFsZXhleQ==
