Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3401D15DB3
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 15:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BAA7288A1B;
	Mon, 21 Oct 2024 17:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="NjKD8ux6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5BBF788B1F; Mon, 21 Oct 2024 17:45:50 +0200 (CEST)
Received: from mx2.securetransport.de (mx2.securetransport.de
 [IPv6:2a03:4000:13:6c7::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4852B8878A
 for <u-boot@lists.denx.de>; Mon, 21 Oct 2024 17:45:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1729523330;
 bh=/EymAynznBfSgd1JJF/KuAQNPoZlghbq0m7mSWzQkM0=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=NjKD8ux6TQw7WA7bSnpD6Tp1JHpDcEJ7olTftZ+Kr1CiHG9Qu00k8TdsXcpMyY+1C
 nerhCt+2yeXlujApWGcxVTbRMOpWwCWpjfRkyYQ7s63/6kBn/Um/SusJXV7IYPyyTW
 OGyYlH7I+3EXWiYUQMTtzv8io5hPqhX2y9Ukaf/vzkcq6q3rwD10MfLjpWE6Ikrt8p
 oGQnKR9R+9ZLdLTJklUyw5bocNjqHjGoW895Vav2TmSkTrcxht0HgmLSc3fvVmqV33
 cc+PTXj4rLd3a2nC8KTRud7iB6HQn46Xfzm5y/gUrj9DXLckvue+N/D2y9oj1JgGVd
 SUj52/CPw5wqg==
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
Thread-Index: AQHbGxfGhQwPx5oDdEKUB8iQmKl/XLKDdt0AgAXWXZD//+VMAIABgMfwgAAvDoCABn1aUA==
Date: Mon, 21 Oct 2024 15:08:46 +0000
Message-ID: <b0734c15ad0b408a9aa541ada20d1c1d@dh-electronics.com>
References: <20241010132337.3259-1-cniedermaier@dh-electronics.com>
 <9b2f1914-ed29-429b-8c0a-e2a25a1172a9@denx.de>
 <62b02b850c194dc080684db8d00cf413@dh-electronics.com>
 <504ec0bf-c3be-4663-ac79-1f8a332d8232@denx.de>
 <02e526c3714e46ec88432ac2d1f38bfb@dh-electronics.com>
 <1aacbaa2-6ea7-4669-8e48-02fc0d5a3376@denx.de>
In-Reply-To: <1aacbaa2-6ea7-4669-8e48-02fc0d5a3376@denx.de>
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
ciAxNywgMjAyNCA0OjAxIFBNDQo+IE9uIDEwLzE3LzI0IDE6MDkgUE0sIENocmlzdG9waCBOaWVk
ZXJtYWllciB3cm90ZToNCj4+IEZyb206IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPj4g
U2VudDogV2VkbmVzZGF5LCBPY3RvYmVyIDE2LCAyMDI0IDI6MTYgUE0NCj4+PiBPbiAxMC8xNi8y
NCAxOjU3IFBNLCBDaHJpc3RvcGggTmllZGVybWFpZXIgd3JvdGU6DQo+Pj4+IEZyb206IE1hcmVr
IFZhc3V0IDxtYXJleEBkZW54LmRlPg0KPj4+PiBTZW50OiBTYXR1cmRheSwgT2N0b2JlciAxMiwg
MjAyNCAxMDo0MyBQTQ0KPj4+Pj4gT24gMTAvMTAvMjQgMzoyMyBQTSwgQ2hyaXN0b3BoIE5pZWRl
cm1haWVyIHdyb3RlOg0KPj4+Pj4+IFRoZSBpLk1YOE0gUGx1cyBESENPTSBjdXJyZW50bHkgc3Vw
cG9ydHMgcGFyc2luZyBldGhlcm5ldCBNQUMgYWRkcmVzcw0KPj4+Pj4+IGZyb20gbXVsdGlwbGUg
c291cmNlcyBpbiB0aGUgZm9sbG93aW5nIHByaW9yaXR5IG9yZGVyOg0KPj4+Pj4+DQo+Pj4+Pj4g
MSkgVS1Cb290IGVudmlyb25tZW50ICdldGhhZGRyJy8nZXRoMWFkZHInIGVudmlyb25tZW50IHZh
cmlhYmxlDQo+Pj4+Pj4gMikgU29DIE9UUCBmdXNlcw0KPj4+Pj4+IDMpIE9uLVNvTSBFRVBST00N
Cj4+Pj4+Pg0KPj4+Pj4+IFRoZSBuZXcgaS5NWDhNIFBsdXMgREhDT00gcmV2LjIwMCBpcyBwb3B1
bGF0ZWQgd2l0aCBNMjRDMzItRCBFRVBST00NCj4+Pj4+PiB3aGljaCBjb250YWlucyBhZGRpdGlv
bmFsIHdyaXRlLWxvY2thYmxlIHBhZ2UsIHdoaWNoIGNhbiBhbHNvIGJlDQo+Pj4+Pj4gcG9wdWxh
dGVkIHdpdGggYSBzdHJ1Y3R1cmUgY29udGFpbmluZyBldGhlcm5ldCBNQUMgYWRkcmVzcy4NCj4+
Pj4+Pg0KPj4+Pj4+IEFkZCBzdXBwb3J0IGZvciBwYXJzaW5nIHRoZSBjb250ZW50IG9mIHRoaXMg
bmV3IHdyaXRlLWxvY2thYmxlIHBhZ2UNCj4+Pj4+PiBhbmQgcGxhY2UgaXQgYmV0d2VlbiAyKSBh
bmQgMykgb24gdGhlIHByaW9yaXR5IGxpc3QuIFRoZSBuZXcgZW50cnkgaXMNCj4+Pj4+PiAyLjUp
IE9uLVNvTSBFRVBST00gd3JpdGUtbG9ja2FibGUgcGFnZQ0KPj4+Pj4+DQo+Pj4+Pj4gQmVjYXVz
ZSB0aGUgd3JpdGUtbG9ja2FibGUgcGFnZSBpcyBub3QgcHJlc2VudCBvbiByZXYuMTAwIGkuTVg4
TVAgREhDT00NCj4+Pj4+PiBTb00sIHRlc3Qgd2hldGhlciBFRVBST00gSUQgcGFnZSBleGlzdHMg
aW4gRFQgYW5kIHdoZXRoZXIgaXQgaXMgZW5hYmxlZA0KPj4+Pj4+IGZpcnN0LiBJZiBzbywgcmVh
ZCB0aGUgZW50aXJlIElEIHBhZ2Ugb3V0LCB2YWxpZGF0ZSBpdCwgYW5kIGRldGVybWluZQ0KPj4+
Pj4+IHdoZXRoZXIgRUVQUk9NIE1BQyBhZGRyZXNzIGlzIHBvcHVsYXRlZCBpbiBpdCBpbiBESCBz
cGVjaWZpYyBmb3JtYXQuIElmDQo+Pj4+Pj4gc28sIHVzZSB0aGUgTUFDIGFkZHJlc3MuIFRoZXJl
IG1heSBiZSBtdWx0aXBsZSBFRVBST01zIHdpdGggYW4gSUQgcGFnZQ0KPj4+Pj4+IG9uIHRoaXMg
cGxhdGZvcm0sIGFsd2F5cyB1c2UgdGhlIGZpcnN0IG9uZS4NCj4+Pj4+Pg0KPj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IENocmlzdG9waCBOaWVkZXJtYWllciA8Y25pZWRlcm1haWVyQGRoLWVsZWN0cm9u
aWNzLmNvbT4NCj4+Pj4+PiAtLS0NCj4+Pj4+PiBDYzogIk5YUCBpLk1YIFUtQm9vdCBUZWFtIiA8
dWJvb3QtaW14QG54cC5jb20+DQo+Pj4+Pj4gQ2M6IE1hcmVrIFZhc3V0IDxtYXJleEBkZW54LmRl
Pg0KPj4+Pj4+IENjOiBGYWJpbyBFc3RldmFtIDxmZXN0ZXZhbUBnbWFpbC5jb20+DQo+Pj4+Pj4g
Q2M6IFN0ZWZhbm8gQmFiaWMgPHNiYWJpY0BkZW54LmRlPg0KPj4+Pj4+IENjOiBUb20gUmluaSA8
dHJpbmlAa29uc3Vsa28uY29tPg0KPj4+Pj4+IENjOiB1LWJvb3RAZGgtZWxlY3Ryb25pY3MuY29t
DQo+Pj4+Pj4gLS0tDQo+Pj4+Pj4gICAgIGJvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2RoX2Nv
bW1vbi5jICAgICAgICB8IDExMyArKysrKysrKysrKysrKysrKysNCj4+Pj4+PiAgICAgYm9hcmQv
ZGhlbGVjdHJvbmljcy9jb21tb24vZGhfY29tbW9uLmggICAgICAgIHwgIDIzICsrKysNCj4+Pj4+
PiAgICAgLi4uL2RoX2lteDhtcC9pbXg4bXBfZGhjb21fcGRrMi5jICAgICAgICAgICAgIHwgICA2
ICsNCj4+Pj4+PiAgICAgMyBmaWxlcyBjaGFuZ2VkLCAxNDIgaW5zZXJ0aW9ucygrKQ0KPj4+Pj4+
DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2JvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2RoX2NvbW1v
bi5jIGIvYm9hcmQvZGhlbGVjdHJvbmljcy9jb21tb24vZGhfY29tbW9uLmMNCj4+Pj4+PiBpbmRl
eCAzMmM1MGI0ZjBmLi44ZWE3MGZjOTg0IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2JvYXJkL2RoZWxl
Y3Ryb25pY3MvY29tbW9uL2RoX2NvbW1vbi5jDQo+Pj4+Pj4gKysrIGIvYm9hcmQvZGhlbGVjdHJv
bmljcy9jb21tb24vZGhfY29tbW9uLmMNCj4+Pj4+PiBAQCAtNyw5ICs3LDIyIEBADQo+Pj4+Pj4g
ICAgICNpbmNsdWRlIDxkbS5oPg0KPj4+Pj4+ICAgICAjaW5jbHVkZSA8aTJjX2VlcHJvbS5oPg0K
Pj4+Pj4+ICAgICAjaW5jbHVkZSA8bmV0Lmg+DQo+Pj4+Pj4gKyNpbmNsdWRlIDx1LWJvb3QvY3Jj
Lmg+DQo+Pj4+Pj4NCj4+Pj4+PiAgICAgI2luY2x1ZGUgImRoX2NvbW1vbi5oIg0KPj4+Pj4+DQo+
Pj4+Pj4gK3N0cnVjdCBlZXByb21faWRfcGFnZSB7DQo+Pj4+Pj4gKyAgICAgdTggICAgICBpZFsz
XTsgICAgICAgICAgLyogSWRlbnRpZmllciAnRCcsICdIJywgJ0UnIC0gJ0QnIGlzIGF0IGluZGV4
IDAgKi8NCj4+Pj4+PiArICAgICB1OCAgICAgIHZlcnNpb247ICAgICAgICAvKiAweDEwIC0tIFZl
cnNpb24gMS4wICovDQo+Pj4+Pj4gKyAgICAgdTggICAgICBkYXRhX2NyYzE2WzJdOyAgLyogWzFd
IGlzIE1TYnl0ZSAqLw0KPj4+Pj4+ICsgICAgIHU4ICAgICAgaGVhZGVyX2NyYzg7DQo+Pj4+Pj4g
KyAgICAgdTggICAgICBtYWMwWzZdOw0KPj4+Pj4+ICsgICAgIHU4ICAgICAgbWFjMVs2XTsNCj4+
Pj4+PiArICAgICB1OCAgICAgIGl0ZW1fcHJlZml4OyAgICAvKiBIL0YgaXMgY29kZWQgaW4gTVNi
aXRzLCBWZW5kb3IgY29kaW5nIHN0YXJ0cyBhdCBMU2JpdHMgKi8NCj4+Pj4+PiArICAgICB1OCAg
ICAgIGl0ZW1fbnVtWzNdOyAgICAvKiBbMl0gaXMgTVNieXRlICovDQo+Pj4+Pj4gKyAgICAgdTgg
ICAgICBzZXJpYWxbOV07ICAgICAgLyogWzhdIGlzIE1TYnl0ZSAqLw0KPj4+Pj4+ICt9IF9fcGFj
a2VkOw0KPj4+Pj4NCj4+Pj4+IElzIF9fcGFja2VkIG5lZWRlZCA/DQo+Pj4+DQo+Pj4+IEkgd2Fu
dCB0byBhdm9pZCBwYWRkaW5nIGluIGFueSBjYXNlLg0KPj4+IEV2ZXJ5IHNpbmdsZSBmaWVsZCBp
cyB1OCwgZG8geW91IG9ic2VydmUgYW55IHBhZGRpbmcgPw0KPj4NCj4+IEluIHRoaXMgY2FzZSwg
SSBkb24ndCBleHBlY3QgcGFkZGluZywgYnV0IGlmIHRoZSBzdHJ1Y3QgaXMgZXh0ZW5kZWQsDQo+
PiBwYWRkaW5nIGNvdWxkIGJlIHBvc3NpYmxlLg0KPiANCj4gUGxlYXNlIGFkZCB0aGUgcGFkZGlu
ZyBvbmx5IG9uY2UgaXQgaXMgcmVhbGx5IHJlcXVpcmVkLCBpZGVhbGx5IHRoZQ0KPiBkZXNpZ24g
b2YgdGhlIHN0cnVjdHVyZSBvciBpdHMgZXh0ZW5zaW9uKHMpIHdvdWxkIGJlIGFibGUgdG8gYXZv
aWQgc3VjaA0KPiBuZWNlc3NpdHkgYWx0b2dldGhlci4NCj4gDQo+PiBUaGlzIHN0cnVjdCBpcyBm
b3IgYW4gRUVQUk9NIGFuZCB0aGVyZWZvcmUNCj4+IGl0IHNob3VsZCBiZSBkZWZpbmVkIHdpdGgg
bm8gcGFkZGluZy4gSSBkb24ndCB3YW50IHRvIGdpdmUgdGhlIGNvbXBpbGUNCj4+IHRoZSBjaGFu
Z2UgdG8gYWRkIHBhZGRpbmcgaWYgc29tZXRoaW5nIGNoYW5nZWQgaW4gdGhlIHN0cnVjdC4NCj4+
IFdoYXQgYXJlIHRoZSBkaXNhZHZhbnRhZ2VzIG9mIGtlZXBpbmcgX19wYWNrZWQgaGVyZT8NCj4g
SWYgaXQgaXMgdW5uZWNlc3NhcnksIHRoZW4gcGxlYXNlIHJlbW92ZSBpdCwgdGhlcmUgaXMgbm8g
Z29vZA0KPiBqdXN0aWZpY2F0aW9uIGZvciBwYWNraW5nIGEgc3RydWN0dXJlIHdoaWNoIGlzIG5h
dHVyYWxseSBhbGlnbmVkIGFscmVhZHkuDQoNCk9LLiBJIHdpbGwgcmVtb3ZlIGl0IGluIFYyLg0K
DQpSZWdhcmRzDQpDaHJpc3RvcGgNCg==
