Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A162ED21272
	for <u-boot@archiver.kernel.org>; Thu, 17 Oct 2024 11:09:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2609688DC6;
	Thu, 17 Oct 2024 13:09:38 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="Ngjfzu9w";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2F5E788B16; Thu, 17 Oct 2024 13:09:37 +0200 (CEST)
Received: from mx3.securetransport.de (mx3.securetransport.de
 [IPv6:2a01:4f8:c0c:92be::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A20F188EDA
 for <u-boot@lists.denx.de>; Thu, 17 Oct 2024 13:09:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729163366;
 bh=O+B7lbj+rdVuVpnmSXGjG2Nm5OiE4hU+D/B36x96TU8=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=Ngjfzu9wxlIJhCDAxGPC7N/VAgeyW57FH9DLYerShiKjTnmEsishKqQl/o6AGA0l1
 EUoUglLnbx52BkaPuEsB9iTsCe0ADvB1fjZz1Eve08X4E247pSc7UlPsjXmJUxATme
 NtCJRF5Z+8W+nE1CLYPKuMYwuuA+12RL5R5Gry0WaWKhA6yQLmK8mfI1bh0ovkX8pQ
 N22q78L8zrFNf1o5dCt3AlGK8q+7/u2dRdH0vQGZT9bnl69ioQAJK9uk0fmrPT6i7W
 KNSz3rVZZnmZpLdQL0oBilYIK0QQd20XPyYz24q1xPjEGUJ3ShaJyjTIfuiSfsr1bj
 wgIqYk+fFzB4Q==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH 1/2] arm64: imx8mp: Read MAC address from M24C32-D
 write-lockable page on DH i.MX8MP DHCOM if available
Thread-Topic: [PATCH 1/2] arm64: imx8mp: Read MAC address from M24C32-D
 write-lockable page on DH i.MX8MP DHCOM if available
Thread-Index: AQHbGxfGhQwPx5oDdEKUB8iQmKl/XLKDdt0AgAXWXZD//+VMAIABgMfw
Date: Thu, 17 Oct 2024 11:09:24 +0000
Message-ID: <02e526c3714e46ec88432ac2d1f38bfb@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <9b2f1914-ed29-429b-8c0a-e2a25a1172a9@denx.de>
 <62b02b850c194dc080684db8d00cf413@dh-electronics.com>
 <504ec0bf-c3be-4663-ac79-1f8a332d8232@denx.de>
In-Reply-To: <504ec0bf-c3be-4663-ac79-1f8a332d8232@denx.de>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBXZWRuZXNkYXksIE9jdG9i
ZXIgMTYsIDIwMjQgMjoxNiBQTQ0KPiBPbiAxMC8xNi8yNCAxOjU3IFBNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4+
IFNlbnQ6IFNhdHVyZGF5LCBPY3RvYmVyIDEyLCAyMDI0IDEwOjQzIFBNDQo+Pj4gT24gMTAvMTAv
MjQgMzoyMyBQTSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+PiBUaGUgaS5NWDhN
IFBsdXMgREhDT00gY3VycmVudGx5IHN1cHBvcnRzIHBhcnNpbmcgZXRoZXJuZXQgTUFDIGFkZHJl
c3MNCj4+Pj4gZnJvbSBtdWx0aXBsZSBzb3VyY2VzIGluIHRoZSBmb2xsb3dpbmcgcHJpb3JpdHkg
b3JkZXI6DQo+Pj4+DQo+Pj4+IDEpIFUtQm9vdCBlbnZpcm9ubWVudCAnZXRoYWRkcicvJ2V0aDFh
ZGRyJyBlbnZpcm9ubWVudCB2YXJpYWJsZQ0KPj4+PiAyKSBTb0MgT1RQIGZ1c2VzDQo+Pj4+IDMp
IE9uLVNvTSBFRVBST00NCj4+Pj4NCj4+Pj4gVGhlIG5ldyBpLk1YOE0gUGx1cyBESENPTSByZXYu
MjAwIGlzIHBvcHVsYXRlZCB3aXRoIE0yNEMzMi1EIEVFUFJPTQ0KPj4+PiB3aGljaCBjb250YWlu
cyBhZGRpdGlvbmFsIHdyaXRlLWxvY2thYmxlIHBhZ2UsIHdoaWNoIGNhbiBhbHNvIGJlDQo+Pj4+
IHBvcHVsYXRlZCB3aXRoIGEgc3RydWN0dXJlIGNvbnRhaW5pbmcgZXRoZXJuZXQgTUFDIGFkZHJl
c3MuDQo+Pj4+DQo+Pj4+IEFkZCBzdXBwb3J0IGZvciBwYXJzaW5nIHRoZSBjb250ZW50IG9mIHRo
aXMgbmV3IHdyaXRlLWxvY2thYmxlIHBhZ2UNCj4+Pj4gYW5kIHBsYWNlIGl0IGJldHdlZW4gMikg
YW5kIDMpIG9uIHRoZSBwcmlvcml0eSBsaXN0LiBUaGUgbmV3IGVudHJ5IGlzDQo+Pj4+IDIuNSkg
T24tU29NIEVFUFJPTSB3cml0ZS1sb2NrYWJsZSBwYWdlDQo+Pj4+DQo+Pj4+IEJlY2F1c2UgdGhl
IHdyaXRlLWxvY2thYmxlIHBhZ2UgaXMgbm90IHByZXNlbnQgb24gcmV2LjEwMCBpLk1YOE1QIERI
Q09NDQo+Pj4+IFNvTSwgdGVzdCB3aGV0aGVyIEVFUFJPTSBJRCBwYWdlIGV4aXN0cyBpbiBEVCBh
bmQgd2hldGhlciBpdCBpcyBlbmFibGVkDQo+Pj4+IGZpcnN0LiBJZiBzbywgcmVhZCB0aGUgZW50
aXJlIElEIHBhZ2Ugb3V0LCB2YWxpZGF0ZSBpdCwgYW5kIGRldGVybWluZQ0KPj4+PiB3aGV0aGVy
IEVFUFJPTSBNQUMgYWRkcmVzcyBpcyBwb3B1bGF0ZWQgaW4gaXQgaW4gREggc3BlY2lmaWMgZm9y
bWF0LiBJZg0KPj4+PiBzbywgdXNlIHRoZSBNQUMgYWRkcmVzcy4gVGhlcmUgbWF5IGJlIG11bHRp
cGxlIEVFUFJPTXMgd2l0aCBhbiBJRCBwYWdlDQo+Pj4+IG9uIHRoaXMgcGxhdGZvcm0sIGFsd2F5
cyB1c2UgdGhlIGZpcnN0IG9uZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3Bo
IE5pZWRlcm1haWVyIDxjbmllZGVybWFpZXJAZGgtZWxlY3Ryb25pY3MuY29tPg0KPj4+PiAtLS0N
Cj4+Pj4gQ2M6ICJOWFAgaS5NWCBVLUJvb3QgVGVhbSIgPHVib290LWlteEBueHAuY29tPg0KPj4+
PiBDYzogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQo+Pj4+IENjOiBGYWJpbyBFc3RldmFt
IDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+Pj4+IENjOiBTdGVmYW5vIEJhYmljIDxzYmFiaWNAZGVu
eC5kZT4NCj4+Pj4gQ2M6IFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+DQo+Pj4+IENjOiB1
LWJvb3RAZGgtZWxlY3Ryb25pY3MuY29tDQo+Pj4+IC0tLQ0KPj4+PiAgICBib2FyZC9kaGVsZWN0
cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYyAgICAgICAgfCAxMTMgKysrKysrKysrKysrKysrKysr
DQo+Pj4+ICAgIGJvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2RoX2NvbW1vbi5oICAgICAgICB8
ICAyMyArKysrDQo+Pj4+ICAgIC4uLi9kaF9pbXg4bXAvaW14OG1wX2RoY29tX3BkazIuYyAgICAg
ICAgICAgICB8ICAgNiArDQo+Pj4+ICAgIDMgZmlsZXMgY2hhbmdlZCwgMTQyIGluc2VydGlvbnMo
KykNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2JvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2Ro
X2NvbW1vbi5jIGIvYm9hcmQvZGhlbGVjdHJvbmljcy9jb21tb24vZGhfY29tbW9uLmMNCj4+Pj4g
aW5kZXggMzJjNTBiNGYwZi4uOGVhNzBmYzk4NCAxMDA2NDQNCj4+Pj4gLS0tIGEvYm9hcmQvZGhl
bGVjdHJvbmljcy9jb21tb24vZGhfY29tbW9uLmMNCj4+Pj4gKysrIGIvYm9hcmQvZGhlbGVjdHJv
bmljcy9jb21tb24vZGhfY29tbW9uLmMNCj4+Pj4gQEAgLTcsOSArNywyMiBAQA0KPj4+PiAgICAj
aW5jbHVkZSA8ZG0uaD4NCj4+Pj4gICAgI2luY2x1ZGUgPGkyY19lZXByb20uaD4NCj4+Pj4gICAg
I2luY2x1ZGUgPG5ldC5oPg0KPj4+PiArI2luY2x1ZGUgPHUtYm9vdC9jcmMuaD4NCj4+Pj4NCj4+
Pj4gICAgI2luY2x1ZGUgImRoX2NvbW1vbi5oIg0KPj4+Pg0KPj4+PiArc3RydWN0IGVlcHJvbV9p
ZF9wYWdlIHsNCj4+Pj4gKyAgICAgdTggICAgICBpZFszXTsgICAgICAgICAgLyogSWRlbnRpZmll
ciAnRCcsICdIJywgJ0UnIC0gJ0QnIGlzIGF0IGluZGV4IDAgKi8NCj4+Pj4gKyAgICAgdTggICAg
ICB2ZXJzaW9uOyAgICAgICAgLyogMHgxMCAtLSBWZXJzaW9uIDEuMCAqLw0KPj4+PiArICAgICB1
OCAgICAgIGRhdGFfY3JjMTZbMl07ICAvKiBbMV0gaXMgTVNieXRlICovDQo+Pj4+ICsgICAgIHU4
ICAgICAgaGVhZGVyX2NyYzg7DQo+Pj4+ICsgICAgIHU4ICAgICAgbWFjMFs2XTsNCj4+Pj4gKyAg
ICAgdTggICAgICBtYWMxWzZdOw0KPj4+PiArICAgICB1OCAgICAgIGl0ZW1fcHJlZml4OyAgICAv
KiBIL0YgaXMgY29kZWQgaW4gTVNiaXRzLCBWZW5kb3IgY29kaW5nIHN0YXJ0cyBhdCBMU2JpdHMg
Ki8NCj4+Pj4gKyAgICAgdTggICAgICBpdGVtX251bVszXTsgICAgLyogWzJdIGlzIE1TYnl0ZSAq
Lw0KPj4+PiArICAgICB1OCAgICAgIHNlcmlhbFs5XTsgICAgICAvKiBbOF0gaXMgTVNieXRlICov
DQo+Pj4+ICt9IF9fcGFja2VkOw0KPj4+DQo+Pj4gSXMgX19wYWNrZWQgbmVlZGVkID8NCj4+DQo+
PiBJIHdhbnQgdG8gYXZvaWQgcGFkZGluZyBpbiBhbnkgY2FzZS4NCj4gRXZlcnkgc2luZ2xlIGZp
ZWxkIGlzIHU4LCBkbyB5b3Ugb2JzZXJ2ZSBhbnkgcGFkZGluZyA/DQoNCkluIHRoaXMgY2FzZSwg
SSBkb24ndCBleHBlY3QgcGFkZGluZywgYnV0IGlmIHRoZSBzdHJ1Y3QgaXMgZXh0ZW5kZWQsDQpw
YWRkaW5nIGNvdWxkIGJlIHBvc3NpYmxlLiBUaGlzIHN0cnVjdCBpcyBmb3IgYW4gRUVQUk9NIGFu
ZCB0aGVyZWZvcmUNCml0IHNob3VsZCBiZSBkZWZpbmVkIHdpdGggbm8gcGFkZGluZy4gSSBkb24n
dCB3YW50IHRvIGdpdmUgdGhlIGNvbXBpbGUNCnRoZSBjaGFuZ2UgdG8gYWRkIHBhZGRpbmcgaWYg
c29tZXRoaW5nIGNoYW5nZWQgaW4gdGhlIHN0cnVjdC4NCldoYXQgYXJlIHRoZSBkaXNhZHZhbnRh
Z2VzIG9mIGtlZXBpbmcgX19wYWNrZWQgaGVyZT8NCg0KUmVnYXJkcw0KQ2hyaXN0b3BoDQo=
