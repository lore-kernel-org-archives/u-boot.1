Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD47C27C79
	for <u-boot@archiver.kernel.org>; Mon, 17 Jun 2024 13:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A7003882DB;
	Mon, 17 Jun 2024 15:27:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=salutedevices.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=salutedevices.com header.i=@salutedevices.com header.b="uFXD+4mJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 893C18829B; Mon, 17 Jun 2024 13:14:41 +0200 (CEST)
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 936D888283
 for <u-boot@lists.denx.de>; Mon, 17 Jun 2024 13:14:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none)
 header.from=salutedevices.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=avromanov@salutedevices.com
Received: from p-infra-ksmg-sc-msk02.sberdevices.ru (localhost [127.0.0.1])
 by mx1.sberdevices.ru (Postfix) with ESMTP id C4309120003;
 Mon, 17 Jun 2024 14:14:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru C4309120003
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
 s=mail; t=1718622877;
 bh=W7iulX2f0+KNQVjh8//tz8sS3TE3e0WoEdGZVYRy5i8=;
 h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version:From;
 b=uFXD+4mJPA7x67Ot75mgBKNeJMiI6hb47zDWEFbCKzqQKBrOBoTWoUgOtwqx7sO6l
 BiWJ1Jyf2A5ANe24DOXkz5tDRk+WLrZF8MDnkfE/NPkgXjDKgNGYWo/hTms3rxDvfX
 mrzdvurcY7KZq+/z2tc2GpUUHcSECrl5fd4NpDl1c1OSzEa1JRfFQivZOzLF0N3xaf
 bEBcXZ5FFGcVZOWVtdMfbU+TE+aZNm2TJxYfNdSgYf9cjTZT89dqvraKHdsQauPm9u
 sVKv51iAo5A0K6NewSlWvjGz2HhYCTMxw/X5ee2PcWt1xd76wzj5lL+ts4zZbHeL+d
 if8lzTrDPw6yw==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru
 [172.16.192.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mx1.sberdevices.ru (Postfix) with ESMTPS;
 Mon, 17 Jun 2024 14:14:37 +0300 (MSK)
Received: from p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 17 Jun 2024 14:14:37 +0300
Received: from p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518]) by
 p-i-exch-sc-m02.sberdevices.ru ([fe80::81d7:3d68:fdfd:518%9]) with
 mapi id 15.02.1118.040; Mon, 17 Jun 2024 14:14:37 +0300
From: Alexey Romanov <avromanov@salutedevices.com>
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC: Michael Trimarchi <michael@amarulasolutions.com>, Frieder Schrempf
 <frieder.schrempf@kontron.de>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Bin Meng <bmeng@tinylab.org>, 
 Tobias Waldekranz <tobias@waldekranz.com>, Joshua Watt
 <jpewhacker@gmail.com>, Marek Vasut <marek.vasut+renesas@mailbox.org>, "Kever
 Yang" <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>, Michal Simek
 <michal.simek@amd.com>, "mikhail.kshevetskiy@iopsys.eu"
 <mikhail.kshevetskiy@iopsys.eu>, Patrice Chotard
 <patrice.chotard@foss.st.com>, kernel <kernel@sberdevices.ru>, "U-Boot
 Mailing List" <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 0/3] Introduce mtdblock device
Thread-Topic: [PATCH v5 0/3] Introduce mtdblock device
Thread-Index: AQHatc6zqVAL1cVPUECQBY+Z/hNaPLG4PgcAgACE8ACAADSVAIANzuWAgATqtQA=
Date: Mon, 17 Jun 2024 11:14:36 +0000
Message-ID: <20240617111432.cgq7fo2jjjqkh7pv@cab-wsm-0029881>
References: <20240603155702.1840464-1-avromanov@salutedevices.com>
 <CAFLszTi+ONdb2P5gtSX_OMUD162G7OtRMD-LbmzO7xuNLRX_HQ@mail.gmail.com>
 <20240605100922.er7xwi5wadaa5dlk@cab-wsm-0029881>
 <CAFLszThCaA72+3H_vvrvB3o0euEUEGq-V7Tpj55bk99Vc1j5=w@mail.gmail.com>
 <CABGWkvoui1sChNiTa_ukc2dceK+foJQ5r-ejThvE1mKuKWWiXg@mail.gmail.com>
In-Reply-To: <CABGWkvoui1sChNiTa_ukc2dceK+foJQ5r-ejThvE1mKuKWWiXg@mail.gmail.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.18.92]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7B8452BF55D254479D5B46EA18CA805C@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 185962 [Jun 17 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 20 0.3.20
 743589a8af6ec90b529f2124c2bbfc3ce1d2f20f, {Tracking_uf_ne_domains},
 {Track_E25351}, {Tracking_from_domain_doesnt_match_to},
 d41d8cd98f00b204e9800998ecf8427e.com:7.1.1; smtp.sberdevices.ru:5.0.1,7.1.1;
 127.0.0.199:7.1.2; salutedevices.com:7.1.1;
 lore.kernel.org:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/06/17 10:57:00
X-KSMG-LinksScanning: Clean, bases: 2024/06/17 10:57:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960,
 bases: 2024/06/17 05:46:00 #25635423
X-KSMG-AntiVirus-Status: Clean, skipped
X-Mailman-Approved-At: Mon, 17 Jun 2024 15:27:08 +0200
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

SGVsbG8sDQoNCk9uIEZyaSwgSnVuIDE0LCAyMDI0IGF0IDEwOjA5OjI3QU0gKzAyMDAsIERhcmlv
IEJpbmFjY2hpIHdyb3RlOg0KPiBIaSBBbGV4ZXksDQo+IA0KPiBJJ20gc3RpbGwgZW5jb3VudGVy
aW5nIGVycm9ycyByYWlzZWQgYnkgdGhlIENJOg0KDQpJJ20gc29ycnkuIEkgdGVzdGVkIG15IHBh
dGNoZXMgd2l0aCBHaXRIdWIgKyBBenVyZSBQaXBlbGluZXMgYW5kIA0KZGlkbid0IGdldCBhbnkg
ZXJyb3JzIGxpa2UgdGhhdC4gSSB0aG91Z2h0IHRlc3RpbmcgdGhlcmUgdXNlcyBidWlsZG1hbi4N
CkknbGwgdHJ5IHRvIHJ1biBpdCBsb2NhbGx5Lg0KDQo+IA0KPiAkIHRvb2xzL2J1aWxkbWFuL2J1
aWxkbWFuIC1vICR7VUJPT1RfVFJBVklTX0JVSUxEX0RJUn0gLXcgLUUgLVcgLWUNCj4gLS1ib2Fy
ZCAke1RFU1RfUFlfQkR9ICR7T1ZFUlJJREV9DQo+IDM0QnVpbGRpbmcgY3VycmVudCBzb3VyY2Ug
Zm9yIDEgYm9hcmRzICgxIHRocmVhZCwgMzIgam9icyBwZXIgdGhyZWFkKQ0KPiAzNSBhcm06ICsg
ZXZiLWFzdDI1MDANCj4gMzYrSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGluY2x1ZGUvbmFuZC5oOjE5
LA0KPiAzNysgZnJvbSBjbWQvYm9vdG0uYzoxNzoNCj4gMzgraW5jbHVkZS9saW51eC9tdGQvbXRk
Lmg6NDMwOjU1OiBlcnJvcjogJ3N0cnVjdCBibGtfZGVzYycgZGVjbGFyZWQNCj4gaW5zaWRlIHBh
cmFtZXRlciBsaXN0IHdpbGwgbm90IGJlIHZpc2libGUgb3V0c2lkZSBvZiB0aGlzIGRlZmluaXRp
b24NCj4gb3IgZGVjbGFyYXRpb24gWy1XZXJyb3JdDQo+IDM5KyA0MzAgfCBzdGF0aWMgaW5saW5l
IHN0cnVjdCBtdGRfaW5mbyAqYmxrX2Rlc2NfdG9fbXRkKHN0cnVjdCBibGtfZGVzYyAqYmRlc2Mp
DQo+IA0KPiBUaGFua3MgYW5kIHJlZ2FyZHMsDQo+IERhcmlvDQo+IA0KPiBPbiBXZWQsIEp1biA1
LCAyMDI0IGF0IDM6MTfigK9QTSBTaW1vbiBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4gd3JvdGU6
DQo+ID4NCj4gPiBIaSBBbGV4ZXksDQo+ID4NCj4gPiBPbiBXZWQsIDUgSnVuIDIwMjQgYXQgMDQ6
MDksIEFsZXhleSBSb21hbm92IDxhdnJvbWFub3ZAc2FsdXRlZGV2aWNlcy5jb20+IHdyb3RlOg0K
PiA+ID4NCj4gPiA+IEhpIFNpbW9uLA0KPiA+ID4geW91ciBtZXNzYWdlIGlzIGVtcHR5Lg0KPiA+
ID4NCj4gPiA+IE9uIFR1ZSwgSnVuIDA0LCAyMDI0IGF0IDA4OjEzOjM0UE0gLTA2MDAsIFNpbW9u
IEdsYXNzIHdyb3RlOg0KPiA+ID4gPiBIaSBBbGV4ZXksDQo+ID4gPiA+DQo+ID4gPiA+IE9uIE1v
biwgSnVuIDMsIDIwMjQsIDA5OjU3IEFsZXhleSBSb21hbm92IDxhdnJvbWFub3ZAc2FsdXRlZGV2
aWNlcy5jb20+DQo+ID4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IEhlbGxvIQ0KPiA+
ID4gPiA+DQo+ID4gPiA+ID4gVGhpcyBzZXJpZXMgYWRkcyBzdXBwb3J0IGZvciB0aGUgbXRkYmxv
Y2sgZGV2aWNlLCB3aGljaA0KPiA+ID4gPiA+IGFsbG93cyB0byByZWFkL3dyaXRlIGRhdGEgYmxv
Y2sgYnkgYmxvY2suIEZvciBleGFtcGxlLA0KPiA+ID4gPiA+IGl0IGNhbiBub3cgYmUgdXNlZCBm
b3IgQkNCIG9yIEFuZHJvaWQgQUIgY29tbWFuZDoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgJCBi
Y2IgbG9hZCBtdGQgMCBwYXJ0X25hbWUNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRlc3RlZCBvbmx5
IG9uIFNQSSBOQU5ELCBzbyBiaW5kIGlzIG1hZGUgb25seSBmb3INCj4gPiA+ID4gPiBTUEkgTkFO
RCBkcml2ZXJzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLS0tDQo+ID4gPiA+ID4NCj4gPiA+ID4g
PiBDaGFuZ2VzIFYxIC0+IFYyIFsxXToNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICAgLSBEcm9wIHBh
dGNoIFsyXS4NCj4gPiA+ID4gPiAgIC0gQWRkIHdhcm5pbmcgaWYgYmluZCBOQU5EIG10ZGJsb2Nr
IGRldmljZS4NCj4gPiA+ID4gPiAgIC0gTW92ZSBkb2N1bWVudGF0aW9uIG9mIG10ZGJsb2NrIGlt
cGxlbWVudGF0aW9uDQo+ID4gPiA+ID4gICAgIGZyb20gY29tbWl0IG1lc3NhZ2UgdG8gdGhlIHNv
dXJjZSBjb2RlLg0KPiA+ID4gPiA+ICAgLSBSZW1vdmUgX19tYXliZV91bnVzZWQgZnJvbSBtdGQg
cGFydGl0aW9uIGZ1bmN0aW9ucw0KPiA+ID4gPiA+ICAgICBkZXNjcmlwdGlvbi4NCj4gPiA+ID4g
PiAgIC0gVXNlIGJsa19lbmFibGVkKCkgaW5zdGVhZCBvZiAjaWZkZWZzLg0KPiA+ID4gPiA+DQo+
ID4gPiA+ID4gQ2hhbmdlcyBWMiAtPiBWMyBbMl06DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiAgIC0g
UmViYXNlZCBvdmVyIFszXS4NCj4gPiA+ID4gPiAgIC0gUmVuYW1lIG10ZF9icmVhZC9id3JpdGUg
LT4gbXRkX2Jsa19yZWFkL3dyaXRlLg0KPiA+ID4gPiA+ICAgLSBGaXggR1BMLTIuMCBsaWNlbnNl
IHNob3J0IG5hbWUgZGVmaW5pdG9uIGluIGhlYWRlcnMuDQo+ID4gPiA+ID4gICAtIEFkZCBlbXB0
eSBsaW5lIGFmdGVyIE1URF9FTlRSWV9OVU1CRVJTIGRlZmluZS4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IENoYW5nZXMgVjMgLT4gVjQgWzRdOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gICAtIEZpeCBi
dWlsZCB3YXJuaW5nczogdXNlIExCQUYgcHJpbnRmIGZvcm1hdCBzdHJpbmcgZm9yIGxiYWludF90
IHR5cGVzLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gQ2hhbmdlcyBWNCAtPiBWNSBbNV06DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiAgIC0gUmViYXNlZCBvdmVyIHUtYm9vdC9tYXN0ZXIuDQo+ID4gPiA+
ID4gICAtIEZpeCBidWlsZCBlcnJvcnMgYW5kIHdhcm5pbmdzIGlmIENPTkZJR19CTEsgaXNuJ3Qg
ZW5hYmxlZC4NCj4gPiA+ID4gPiAgIC0gRml4IGZhaWxlZCB0ZXN0cyBpbiBjYXNlcyBpcyBtdGRi
bG9jayBkZXZpY2UgaXNuJ3QgYmluZGVkLg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTGlua3M6DQo+
ID4gPiA+ID4NCj4gPiA+ID4gPiAgIC0gWzFdDQo+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvYWxsLzIwMjQwMjI3MTAwNDQxLjE4MTEwNDctMS1hdnJvbWFub3ZAc2FsdXRlZGV2aWNl
cy5jb20vDQo+ID4gPiA+ID4gICAtIFsyXQ0KPiA+ID4gPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC8yMDI0MDIyNzEwMDQ0MS4xODExMDQ3LTUtYXZyb21hbm92QHNhbHV0ZWRldmljZXMu
Y29tLw0KPiA+ID4gPiA+ICAgLSBbM10NCj4gPiA+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy91LWJvb3QvMjAyNDA0MDMxMTQwNDcuODQwMzAtMS1oZWlucmljaC5zY2h1Y2hhcmR0QGNhbm9u
aWNhbC5jb20vVC8jdQ0KPiA+ID4gPiA+ICAgLSBbNF0NCj4gPiA+ID4gPiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9hbGwvMjAyNDA0MDQxMDU4MTMuMTUyMDczMi0xLWF2cm9tYW5vdkBzYWx1dGVk
ZXZpY2VzLmNvbS8NCj4gPiA+ID4gPiAgIC0gWzVdDQo+ID4gPiA+ID4gaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzIwMjQwNTI0MTAyOTIwLjI2MzE3MzEtMS1hdnJvbWFub3ZAc2FsdXRlZGV2
aWNlcy5jb20vDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBBbGV4ZXkgUm9tYW5vdiAoMyk6DQo+ID4g
PiA+ID4gICBkaXNrOiBzdXBwb3J0IE1URCBwYXJ0aXRpb25zDQo+ID4gPiA+ID4gICBkcml2ZXJz
OiBpbnRyb2R1Y2UgbXRkYmxvY2sgYWJzdHJhY3Rpb24NCj4gPiA+ID4gPiAgIHNwaW5hbmQ6IGJp
bmQgbXRkYmxvY2sNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICBkaXNrL3BhcnQuYyAgICAgICAgICAg
ICAgICAgfCAgIDMgKy0NCj4gPiA+ID4gPiAgZHJpdmVycy9ibG9jay9ibGstdWNsYXNzLmMgIHwg
ICAxICsNCj4gPiA+ID4gPiAgZHJpdmVycy9tdGQvS2NvbmZpZyAgICAgICAgIHwgICAxICsNCj4g
PiA+ID4gPiAgZHJpdmVycy9tdGQvTWFrZWZpbGUgICAgICAgIHwgICAxICsNCj4gPiA+ID4gPiAg
ZHJpdmVycy9tdGQvbXRkYmxvY2suYyAgICAgIHwgMjI3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKw0KPiA+ID4gPiA+ICBkcml2ZXJzL210ZC9tdGRwYXJ0LmMgICAgICAgfCAg
NzYgKysrKysrKysrKysrDQo+ID4gPiA+ID4gIGRyaXZlcnMvbXRkL25hbmQvc3BpL2NvcmUuYyB8
ICAyMCArKysrDQo+ID4gPiA+ID4gIGluY2x1ZGUvbGludXgvbXRkL210ZC5oICAgICB8ICAyMSAr
KysrDQo+ID4gPiA+ID4gIGluY2x1ZGUvcGFydC5oICAgICAgICAgICAgICB8ICAgMyArDQo+ID4g
PiA+ID4gIDkgZmlsZXMgY2hhbmdlZCwgMzUyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkN
Cj4gPiA+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbXRkL210ZGJsb2NrLmMNCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IC0tDQo+ID4gPiA+ID4gMi4zNC4xDQo+ID4gPiA+ID4NCj4gPiA+
ID4gPg0KPiA+ID4NCj4gPg0KPiA+IEFyZSB5b3UgYWJsZSB0byBhZGQgYSBzYW5kYm94IHRlc3Qg
Zm9yIHRoaXMgY29kZT8NCj4gPg0KPiA+IFJlZ2FyZHMsDQo+ID4gU2ltb24NCj4gDQo+IA0KPiAN
Cj4gLS0gDQo+IA0KPiBEYXJpbyBCaW5hY2NoaQ0KPiANCj4gU2VuaW9yIEVtYmVkZGVkIExpbnV4
IERldmVsb3Blcg0KPiANCj4gZGFyaW8uYmluYWNjaGlAYW1hcnVsYXNvbHV0aW9ucy5jb20NCj4g
DQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gDQo+IA0KPiBBbWFydWxh
IFNvbHV0aW9ucyBTUkwNCj4gDQo+IFZpYSBMZSBDYW5ldmFyZSAzMCwgMzExMDAgVHJldmlzbywg
VmVuZXRvLCBJVA0KPiANCj4gVC4gKzM5IDA0MiAyNDMgNTMxMA0KPiBpbmZvQGFtYXJ1bGFzb2x1
dGlvbnMuY29tDQo+IA0KPiB3d3cuYW1hcnVsYXNvbHV0aW9ucy5jb20NCg0KLS0gDQpUaGFuayB5
b3UsDQpBbGV4ZXk=
