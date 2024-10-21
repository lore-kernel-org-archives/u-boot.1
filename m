Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234B9D15DB3
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:49:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 802A788E3A;
	Mon, 21 Oct 2024 17:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="mxdr4fTq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7136A88E8A; Mon, 21 Oct 2024 17:49:11 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8C7FB88E19
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:49:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729525132;
 bh=XuhXsELHAcUWkAOJatU1xelHLDijhgv4+Z7KaBNxhZk=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=mxdr4fTqLlvdglRwRfAlEuUWru4Iv2NSW2GRlvgzGTjhXBpp2iJGTlMbZ0XCkcKHR
 ey79bsRAtKBkGfCxS8TTALxO+0amF+mlwnuLCWImdViYzCceEuzlX6Wq3m39xsMzIX
 Yfebe+gdkFJB5OZf5X5XdHaTb1NFmpSSe1PAmEHBCh/5yrWFkMlg1lBuvCOx1zQtPv
 YzekBwb9UEEnUqox/raa+yFhNAAFnmj/bjTfrZFDl/eX/sQDfaa+/tNgi9pd0V2sL0
 1ThGg9Bk0hAh5yCKC/vo4oZKVBluXtkPM6g/UH80s65J4rMW09XfGIJlb5xkaStF06
 dEO1LA4b8dpzw==
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
Thread-Index: AQHbGxfHmD5+3BWcGkWm07IML/aPr7KDeoyAgAXUiUCAAK5vAIAA1rQQgABasgCABjFZgA==
Date: Mon, 21 Oct 2024 15:38:50 +0000
Message-ID: <7b9b543d7aad498591fa6a04a3154cf8@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <20241010132337.3259-2-cniedermaier@dh-electronics.com>
 <934d25c2-39d8-4f51-b29e-8f20feb7431f@denx.de>
 <a305b1455a984fca83de5a6c0d4b8dfc@dh-electronics.com>
 <74bd0a6b-fe12-4e2c-af79-c1f8ffb7d484@denx.de>
 <73ccb69b85094e24be2343d5cbc8879a@dh-electronics.com>
 <17b9380b-39c0-40f2-bb28-319d26b2e13c@denx.de>
In-Reply-To: <17b9380b-39c0-40f2-bb28-319d26b2e13c@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBUaHVyc2RheSwgT2N0b2Jl
ciAxNywgMjAyNCA4OjM1IFBNDQo+IE9uIDEwLzE3LzI0IDE6NTUgUE0sIENocmlzdG9waCBOaWVk
ZXJtYWllciB3cm90ZToNCj4gDQo+IFsuLi5dDQo+IA0KPj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgX19mdW5jX18sIHJldCk7DQo+Pj4+Pg0KPj4+Pj4gVGhpcyB3aWxsIGJlIHBy
aW50ZWQgb24gZXZlcnkgZGV2aWNlLCBldmVuIHRoZSBvbmVzIHdpdGhvdXQgSUQgRUVQUk9NLA0K
Pj4+Pj4gY29ycmVjdCA/IFRoaXMgc2hvdWxkIG5vdCBiZSBwcmludGVkIG9uIGRldmljZXMgd2l0
aG91dCBJRCBFRVBST00uIEFsc28sDQo+Pj4+DQo+Pj4+IFRoaXMgaXMgc3VwcHJlc3NlZCBieSB0
aGUgLUVOT0VOVCBjaGVjay4NCj4+Pg0KPj4+IERvZXMgaTJjX2VlcHJvbV9yZWFkKCkgaW4gZGhf
Z2V0X3ZhbHVlX2Zyb21fZWVwcm9tX2lkX3BhZ2UoKSByZXR1cm4NCj4+PiAtRU5PRU5UIGluIGNh
c2UgdGhlIEVFUFJPTSBpcyBkZXNjcmliZWQgaW4gRFQsIGJ1dCBub3QgcG9wdWxhdGVkIG9uIHRo
ZQ0KPj4+IGJvYXJkID8gSSBzdXNwZWN0IGl0IHJldHVybnMgc29tZSBvdGhlciBlcnJvciBjb2Rl
LCAtRVRJTUVET1VUIG9yDQo+Pj4gLUVJTlZBTCBtYXliZSA/DQo+Pg0KPj4gSXQgY291bGQgb25s
eSBiZSBwb3NzaWJsZSBpZiB0aGUgRFRPIGZvciBoYXJkd2FyZSByZXYuIDEwMCAod2hpY2ggaGFz
IG5vDQo+PiBFRVBST00gSUQgcGFnZSkgaXMgbm90IGxvYWRlZC4gVGhlIHJldHVybiB2YWx1ZSB0
aGVuIGlzIC1FTk9ERVYuDQo+PiBJIHdpbGwgaW5jbHVkZWQgdGhpcyBpbiB2Mi4NCj4gDQo+IE9L
DQo+IA0KPj4+Pj4gQWxzbywgdGhpcyBzaG91bGRuJ3QgYmUgcmVwZWF0ZWRseSByZWFkaW5nIHRo
ZSBFRVBST00sIHRoZSBFRVBST00gcmVhZA0KPj4+Pj4gb3BlcmF0aW9uIGlzIHRoZSBzbG93IHBh
cnQsIHRoZSBFRVBST00gaXMgMzIgYnl0ZXMsIHNvIHRoZSBFRVBST00gc2hvdWxkDQo+Pj4+PiBi
ZSByZWFkIG9uY2UgYW5kIGNhY2hlZCwgYW5kIG9uY2UgdGhlIGNhY2hlIGlzIHBvcHVsYXRlZCBh
bGwgcmVhZA0KPj4+Pj4gYWNjZXNzZXMgdG8gdGhlIEVFUFJPTSBzaG91bGQgdXNlIHRoZSBjYWNo
ZS4NCj4+Pj4NCj4+Pj4gVGhpcyBpcyBhbHJlYWR5IGNvdmVyZWQgaW4gZnVuY3Rpb24gZGhfZ2V0
X3ZhbHVlX2Zyb21fZWVwcm9tX2lkX3BhZ2UoKS4NCj4+PiBJdCBzZWVtcyB0aGF0IGZ1bmN0aW9u
IGFsd2F5cyBjYWxscw0KPj4+IHJldCA9IGkyY19lZXByb21fcmVhZChkZXYsIDB4MCwgZWlwYSwg
c2l6ZW9mKGVpcGEpKTsNCj4+PiA/DQo+Pg0KPj4gVGhlIDMyIGJ5dGVzIGFyZSByZWFkIGludG8g
YSBzdGF0aWMgdmFyaWFibGUuIElmIHRoZSBJRCAoREhFKSBhbHJlYWR5IGV4aXN0cw0KPj4gaW4g
aXQsIHRoZSBpMmNfZWVwcm9tX3JlYWQoKSBmdW5jdGlvbiBpcyBubyBsb25nZXIgY2FsbGVkLg0K
PiBIbW1tLCBidXQgaXQgc2VlbXMgYWxsIHRoZSBmdW5jdGlvbnMgd2hpY2ggYWNjZXNzIHRoaXMg
RUVQUk9NIFdMUCBhcmUNCj4gY2FsbGVkIGZyb20gYm9hcmRfaW5pdCgpLCBhcmUgdGhleSBub3Qg
Pw0KDQpUaGF04oCZcyB0cnVlLg0KDQo+IElmIHllcywgdGhlbiB0aGVyZSBpcyBubyBuZWVkIGZv
ciBhbnkgc3RhdGljIHZhcmlhYmxlOg0KPiANCj4gYm9hcmRfaW5pdCgpIHsNCj4gICB1OCBlZXBy
b21bMzJdOw0KPiAgIGRoX3JlYWRfZWVwcm9tX3dscChlZXByb20pOyAvLyByZWFkIHRoZSBlZXBy
b20gb25jZQ0KPiAgIGRoX3NldHVwX21hY19hZGRyZXNzKGVlcHJvbSk7IC8vIGV4dHJhY3QgTUFD
IGZyb20gRUVQUk9NDQo+ICAgZGhfYWRkX2l0ZW1fbnVtYmVyX2FuZF9zZXJpYWxfdG9fZW52KGVl
cHJvbSk7IC8vIGV4dHJhY3QgU04gZnJvbSBFRVBST00NCj4gICAvLyBvbmNlIHRoaXMgZnVuY3Rp
b24gZXhpdHMsIHRoZSBlZXByb20gdmFyaWFibGUgb24gc3RhY2sgaXMgZGlzY2FyZGVkDQo+ICAg
Ly8gd2hpY2ggaXMgT0ssIHNpbmNlIGl0IHdvbid0IGJlIHVzZWQgYW55bW9yZSBhbnl3YXkNCj4g
fQ0KDQpUaGUgaWRlYSBpcyB0aGF0IGZ1bmN0aW9uIGRoX2FkZF9pdGVtX251bWJlcl9hbmRfc2Vy
aWFsX3RvX2VudigpIGVuY2Fwc3VsYXRlcw0KdGhlIHJlYWRpbmcuIEkgZG9uJ3Qgd2FudCB0byBo
YXZlIHRvIHdvcnJ5IGFib3V0IHRoZSBzdHJ1Y3R1cmUgYW5kIG51bWJlciBvZg0KYnl0ZXMgb2Yg
dGhlIEVFUFJPTSBJRCBwYWdlIGFuZCB3YW50IHRvIGJlIGluZGVwZW5kZW50IG9mIGl0LiBJdCBp
cyBwbGFubmVkIHRvDQpleHRlbmQgdGhlIHN0cnVjdHVyZSBhbmQgaW5jcmVhc2UgdGhlIG51bWJl
ciBvZiBieXRlcyBmb3IgdGhlIFNUTTMyTVAyLiBUaGUNCmNoYW5nZXMgdG8gdGhlIHNpemUgd2ls
bCB0aGVuIGRlcGVuZCBvbiB0aGUgdmVyc2lvbiBvZiB0aGUgZGF0YSBpbiB0aGUgaGVhZGVyDQp3
aXRoaW4gdGhlIHN0cnVjdHVyZS4gSG93ZXZlciwgdGhlc2UgY2hhbmdlcyBzaG91bGQgdGhlbiBv
bmx5IGhhdmUgdG8gYmUgbWFkZQ0Kd2l0aGluIHRoZSBmdW5jdGlvbiBkaF9hZGRfaXRlbV9udW1i
ZXJfYW5kX3NlcmlhbF90b19lbnYoKSBmb3IgcmVhZGluZyB0aGUNCkVFUFJPTSBJRCBwYWdlLiBJ
IGFjY2VwdCB0aGUgc3RhdGljIHZhcmlhYmxlIGluIG9yZGVyIHRvIGJldHRlciBpc29sYXRlIHRo
ZQ0KZnVuY3Rpb24uIFNpbmNlIHRoZSBtZW1vcnkgaXMgZnJlZWQgdXAgYWdhaW4gd2hlbiB0aGUg
b3BlcmF0aW5nIHN5c3RlbSBib290cywNCnRoaXMgY29uc3VtcHRpb24gb2YgMzIgYnl0ZXMgaW4g
VS1Cb290IGlzIG5vdCBhIHByb2JsZW0sIGJlY2F1c2UgaXQgaXMgb25seQ0KdGVtcG9yYXJ5Lg0K
DQoNClJlZ2FyZHMNCkNocmlzdG9waA0K
