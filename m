Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD4AD10399
	for <u-boot@archiver.kernel.org>; Fri, 25 Oct 2024 15:37:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7EE1488B9E;
	Fri, 25 Oct 2024 17:37:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="l5k+5gOB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FA0D88F68; Fri, 25 Oct 2024 17:37:07 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id DDF2687CF8
 for <u-boot@lists.denx.de>; Fri, 25 Oct 2024 17:37:03 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729870581;
 bh=vAu/KRqC7EjChvHETBhPjW/aCVHoDmd3kNCeYz5Fnyg=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=l5k+5gOBrOP3tjQ5gmf34/8Khj10AIxWDTXMt2okEE9sGmYxL5RkCKPhNtxIyAuuu
 gwTfqlYMpGS554voRd7T18NT3AykmmUv3jB7Y1NyLKD8lqnwW7yxcV09XPW+GCL/Xb
 2VFgF60P3Lzsa9wB/h+feJHu2rnyPZOPb64zuj3U80Zwg4Ih9L+qwXk8Zo2UaJN5Wx
 M0732H9cDLzFRMrjdOwHE95wXCPtXqrLFhxJspjNWfDPFOcGAkcnQ9nVZSo7GaB7bm
 kRkLPEUkEcQeUyGR/03iy3nW4pZ0Qje1moOZKeM9+d2Xa87x/SGHyvsBbt/LcB3/Ep
 JkSMCJ86E8r2Q==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH 2/2] arm64: imx8mp: Read item and serial number from
 EEPROM ID page on DH i.MX8MP DHCOM
Thread-Topic: [PATCH 2/2] arm64: imx8mp: Read item and serial number from
 EEPROM ID page on DH i.MX8MP DHCOM
Thread-Index: AQHbGxfHmD5+3BWcGkWm07IML/aPr7KDeoyAgAXUiUCAAK5vAIAA1rQQgABasgCABjFZgIAAYh8AgADI4vCAABAiAIABs80Q///qwYCAACbfkP//8H2AgANd1nA=
Date: Fri, 25 Oct 2024 15:36:08 +0000
Message-ID: <56fc53e544314a9eb63c668cb01088db@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
 <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
 <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
 <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
 <73ccb69b85094e24be2343d5cbc8879a@dh-electronics.com>
 <17b9380b-39c0-40f2-bb28-319d26b2e13c@denx.de>
 <7b9b543d7aad498591fa6a04a3154cf8@dh-electronics.com>
 <a0f70ee2-6d71-4f66-b22e-994df2b28504@denx.de>
 <d06620ee891f4e419bfeb8fe657ba729@dh-electronics.com>
 <009179c8-5512-4ba6-beeb-2d508dd5abd8@denx.de>
 <bef41c1fefeb422e9e1b8f8f0d241a13@dh-electronics.com>
 <1fd571bc-d133-4e91-8ab6-45e6e7429027@denx.de>
 <95c20aac320049eda6a324d360743691@dh-electronics.com>
 <c9d142f6-05ca-4fab-8016-3f545e6538d0@denx.de>
In-Reply-To: <c9d142f6-05ca-4fab-8016-3f545e6538d0@denx.de>
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
ZXIgMjMsIDIwMjQgNDowNSBQTQ0KPiBPbiAxMC8yMy8yNCAzOjIwIFBNLCBDaHJpc3RvcGggTmll
ZGVybWFpZXIgd3JvdGU6DQo+PiBGcm9tOiBNYXJlayBWYXN1dCA8bWFyZXhAZGVueC5kZT4NCj4+
IFNlbnQ6IFdlZG5lc2RheSwgT2N0b2JlciAyMywgMjAyNCAyOjQxIFBNDQo+Pj4gT24gMTAvMjMv
MjQgMjoxOCBQTSwgQ2hyaXN0b3BoIE5pZWRlcm1haWVyIHdyb3RlOg0KPj4+DQo+Pj4gWy4uLl0N
Cj4+Pg0KPj4+Pj4gWW91IGRvIG5vdCwgdGhlIGZvbGxvd2luZyBhdXRvbWF0aWNhbGx5IHJlc2Vy
dmVzIHNwYWNlIG9uIHN0YWNrIHdoZW4NCj4+Pj4+IGNhbGxlZCBhbmQgZnJlZXMgaXQgdXAgdXBv
biBmdW5jdGlvbiByZXR1cm46DQo+Pj4+Pg0KPj4+Pj4gZnVuY3Rpb24gZm9vKCkgew0KPj4+Pj4g
ICAgICB1OCBhcnJheVsxMl07DQo+Pj4+PiAgICAgIC4uLg0KPj4+Pj4gICAgICBzdHVmZihhcnJh
eSk7DQo+Pj4+PiAgICAgIC4uLg0KPj4+Pj4gfQ0KPj4+Pg0KPj4+PiBTb3JyeSwgSSBleHByZXNz
ZWQgbXlzZWxmIGluY29ycmVjdGx5IGhlcmUuIE9mIGNvdXJzZSBJIG1lYW50IHRoYXQNCj4+Pj4g
SSBkb24ndCB3YW50IHRvIHJlc2VydmUgbWVtb3J5IG9uIHRoZSBzdGFjayBmb3IgdGhlIEVFUFJP
TSBJRCBwYWdlDQo+Pj4+IGluIHRoZSBib2FyZF9pbml0KCkgZnVuY3Rpb24uDQo+Pj4NCj4+PiBX
aHkgPw0KPj4NCj4+IEl0J3MgYWJvdXQgc3RydWN0dXJpbmcgdGhlIHNvZnR3YXJlLiBJIHdhbnQg
dG8gaXNvbGF0ZSB0aGUgZnVuY3Rpb24gd2hpY2gNCj4+IGlzIHJlc3BvbnNpYmxlIGZvciBldmFs
dWF0ZSB0aGUgRUVQUk9NIGZyb20gdGhlIGNhbGxlciBmdW5jdGlvbi4gSSB3YW50ZWQNCj4+IHRv
IGF2b2lkIGVudGFuZ2xpbmcgdGhlIHR3by4gVGhpcyBtZWFucyB0aGF0IEksIGFzIHRoZSBjYWxs
ZXIgb2YgdGhlIGZ1bmN0aW9uLA0KPj4gZG8gbm90IGhhdmUgdG8gd29ycnkgYWJvdXQgdGhlIGlu
dGVybmFsIHN0cnVjdHVyZSBvZiB0aGUgRUVQUk9NIElEIHBhZ2UuDQo+IA0KPiBZb3UgYXJlIG9u
bHkgcGFzc2luZyBpbiBhIGJsb2NrIG9mIHVuc3RydWN0dXJlZCBtZW1vcnkgYWxsb2NhdGVkIG9u
DQo+IHN0YWNrLCB1OCBibG9ja1s2NF0uDQo+IA0KPj4+Pj4+IEkgd2FudCB0byBoYW5kbGUNCj4+
Pj4+PiBzaXplIGFuZCBjYWNoaW5nIGluIHRoZSBmdW5jdGlvbiBkaF9nZXRfdmFsdWVfZnJvbV9l
ZXByb21faWRfcGFnZSgpLiBTbyBJIGRvbid0DQo+Pj4+Pj4gd2FudCB0byBkZWFsIHdpdGggc2l6
ZSBhbmQgc3RydWN0dXJlIGluIHRoZSBmdW5jdGlvbiBib2FyZF9pbml0KCkuIEZvciBtZSwgdGhl
IHVzZQ0KPj4+Pj4+IG9mIGEgc3RhdGljIHZhcmlhYmxlIGlzIE9LLCBidXQgeW91IGRvbid0IGxp
a2UgaXQuIERvIHlvdSBrbm93IGhvdyBJIGNhbiBkbyB0aGlzDQo+Pj4+Pj4gd2l0aG91dCBhc3Np
Z25pbmcgYSBzdGF0aWMgdmFyaWFibGUsIGJ1dCBub3QgYWxsb2NhdGUgdGhlIG1lbW9yeSBzb21l
d2hlcmUgaW4gYQ0KPj4+Pj4+IGNhbGxlciBmdW5jdGlvbj8NCj4+Pj4+IEV2ZW4gdGhlIHN0YXRp
YyB2YXJpYWJsZSBzcGFjZSBpcyBhbGxvY2F0ZWQgc29tZXdoZXJlLCBlaXRoZXIgaW4gLmJzcyBv
cg0KPj4+Pj4gLmRhdGEgc2VjdGlvbiwgZXhjZXB0IHdpdGggc3RhdGljIHZhcmlhYmxlKHMpIHRo
ZSBtZW1vcnkgcGVyc2lzdHMNCj4+Pj4+IHRocm91Z2hvdXQgdGhlIGxpZmV0aW1lIG9mIFUtQm9v
dCBiZWNhdXNlIHRoZWlyIGNvbnRlbnQgaGFzIHRvIGJlDQo+Pj4+PiByZXRhaW5lZCBldmVuIHdo
ZW4gdGhlIGZ1bmN0aW9uIHVzaW5nIHRoZWlyIGNvbnRlbnQgcmV0dXJucy4NCj4+Pj4+DQo+Pj4+
PiBXaXRoIHZhcmlhYmxlKHMpIGFsbG9jYXRlZCBvbiBzdGFjayAod2hpY2ggaXMgbWFqb3JpdHkg
b2YgdmFyaWFibGUpLCB0aGUNCj4+Pj4+IG1lbW9yeSBhbGxvY2F0aW9uIGhhcHBlbnMgb24gZW50
cnkgdG8gdGhlIGZ1bmN0aW9uIGFuZCB0aGUgbWVtb3J5IGlzDQo+Pj4+PiBhdXRvbWF0aWNhbGx5
IGZyZWVkIG9uIGV4aXQgZnJvbSB0aGUgZnVuY3Rpb24uDQo+Pj4+Pg0KPj4+Pj4gSXQgaXMgcGVy
ZmVjdGx5IGZpbmUgdG8gY2FsbCBzb21lIHdyYXBwZXIgc3VwZXJmdW5jdGlvbiBmcm9tDQo+Pj4+
PiBib2FyZF9pbml0KCkgd2hpY2ggaG9sZHMgdGhlIGFycmF5IG9uIHN0YWNrIGFuZCBjYWxscyBh
bGwgdGhlIEVFUFJPTQ0KPj4+Pj4gcGFyc2VyL2hhbmRsZXIgZnVuY3Rpb25zOg0KPj4+Pj4NCj4+
Pj4+IGVlcHJvbV9zdXBlcndyYXBwZXIoKSB7DQo+Pj4+PiAgICAgIHU4IGVlcHJvbVs2NF07DQo+
Pj4+PiAgICAgIC4uLg0KPj4+Pj4gICAgICBlZXByb21fZG9fc3R1ZmYxKGVlcHJvbSk7DQo+Pj4+
PiAgICAgIGVlcHJvbV9kb19zdHVmZjIoZWVwcm9tKTsNCj4+Pj4+ICAgICAgLi4uDQo+Pj4+PiB9
DQo+Pj4+Pg0KPj4+Pj4gYm9hcmRfaW5pdCgpIHsNCj4+Pj4+ICAgICAgLi4uDQo+Pj4+PiAgICAg
IGVlcHJvbV9zdXBlcndyYXBwZXIoKTsNCj4+Pj4+ICAgICAgLi4uDQo+Pj4+PiB9DQo+Pj4+DQo+
Pj4+IFRoYXQncyBub3Qgd2hhdCBJJ20gbG9va2luZyBmb3IuIERvIHlvdSBoYXZlIGFub3RoZXIg
c29sdXRpb24/DQo+Pj4gTm8uIEkgZG8gbm90IHVuZGVyc3RhbmQgd2hhdCBpcyB0aGUgcHJvYmxl
bSB3aXRoIGFsbG9jYXRpbmcgNjQgQnl0ZXMgb24NCj4+PiBzdGFjayA/DQo+Pg0KPj4gVGhlcmUg
aXMgbm8gcHJvYmxlbSB3aXRoIHRoZSByZXNlcnZhdGlvbiBvZiB0aGUgRUVQUk9NIGJ1ZmZlciBv
biB0aGUNCj4+IHN0YWNrLiBJIHdhbnRlZCB0byBpc29sYXRlIHRoZSBldmFsdWF0aW9uIGZ1bmN0
aW9uIGZyb20gdGhlIGNhbGxlcg0KPj4gZnVuY3Rpb24sIHNvIHRoYXQgSSBoYXZlIG5vIGRlcGVu
ZGVuY2llcyBvbiB0aGUgY2FsbGVyLiBTaW5jZSB0aGVyZQ0KPj4gc2VlbXMgdG8gYmUgbm8gYmV0
dGVyIHNvbHV0aW9uLCBJIHdpbGwgYWRkIHRoZSB2YXJpYWJsZSB0byB0aGUNCj4+IGJvYXJkX2lu
aXQoKSBmdW5jdGlvbiBpbiBWMi4NCj4gVGhlcmUgc2VlbSB0byBiZSBtdWx0aXBsZSBmdW5jdGlv
bnMgdXNpbmcgdGhlIHNhbWUgZGF0YSwgc28geW91IGhhdmUgdG8NCj4gcGFzcyBwb2ludGVyIHRv
IHRob3NlIGRhdGEgYXJvdW5kLg0KDQpJIHdpbGwgbWFrZSBhIFYyIHdpdGggdGhpcyBhcHByb2Fj
aCwgYnV0IHVuZm9ydHVuYXRlbHkgSSBjYW4ndCB3b3JrIG9uDQppdCBuZXh0IHdlZWsuIFNvIHRo
ZSB3ZWVrIGFmdGVyIEkgd2lsbCBzZW5kIFYyLg0KDQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
