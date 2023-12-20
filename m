Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22871C46CD3
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 12:14:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id AD13A877D0;
	Wed, 20 Dec 2023 13:13:49 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (4096-bit key; unprotected) header.d=prolan.hu header.i=@prolan.hu header.b="Q0su+Q5H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14FF8871A7; Wed, 20 Dec 2023 08:53:02 +0100 (CET)
Received: from fw2.prolan.hu (fw2.prolan.hu [193.68.50.107])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ED3238700D
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 08:52:59 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=prolan.hu
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=Csokas.Bence@prolan.hu
Received: from proxmox-mailgw.intranet.prolan.hu (localhost.localdomain
 [127.0.0.1])
 by proxmox-mailgw.intranet.prolan.hu (Proxmox) with ESMTP id 60963A13E7;
 Wed, 20 Dec 2023 08:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prolan.hu; h=cc
 :cc:content-id:content-transfer-encoding:content-type
 :content-type:date:from:from:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=mail; bh=ymRX7RNkP
 VzcsVH0DFWJ8pqv7/J1XK7avZ4u6cRz/vc=; b=Q0su+Q5HjYEp3hcAlUjrwe5V2
 /E3n48ZO3777OWpERtcQaVIW9zeq3JX3QVeFTJyKvJk/5ile5aTPQ+7CrZyySQoP
 rW6+BGcgfKboIyd8ahT9NWjxoh5aKRjbafi3BSxlJwKRkpIcupmnMqBR2Ql5K291
 7GIZvzPHbTK0R2Euhjh7z9nyHhTXLsIhX+ZTgGpg5vywhJrRT15cOtB3+ml7Hv4S
 bEK253G7w1t/MZ7MSw/4H8lEIR8dUTu/n8rtIFK8iMjqFGX3WMmnbIpVdPbKb9w+
 TodViZ3SgiMSL1eQ0CGdtxI4nnGKWuR3W5ZxG/efkKtS66jfSurBWnInc6fnaAM2
 ey+wXlOFENEWwSv82uYRlU7FUZtYzKYPJS3kiuDSn70sfcUuMCzhXdzDa4k9fpj2
 PfImkWNjt1tPLDVDtU6DayZ2MduY5tvLa7tF59UZwc7S7xQO8koAz8r3RfIMcqHb
 GjGC9M3bW+0nY8uJD1NxrfIIgk8xW2vMtFuPXKr+8dxove2VE6aVhTEWPVJRximj
 Gn56nRxXxIG12t+C4Sn0AVhjQ43aMnLBIkSSj1Qb1mczpq9B474mBWvNI1dHf95U
 rCcyBy8AmkEBVqbKD1zz4kEsJGs8YPDtnzBDRbUjhbfyNDHKvIVlwioyQohQI2k8
 JEKotYDnEu7TJo2S+g=
From: =?utf-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>
To: Dragan Simic <dsimic@manjaro.org>
CC: Sean Anderson <seanga2@gmail.com>, Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>, Daniel Golle
 <daniel@makrotopia.org>
Subject: Re: Passing boot logs to Linux?
Thread-Topic: Passing boot logs to Linux?
Thread-Index: AQHaMrctQ91qLkCwS0+C38IRePG/PrCxfvIAgAAJqQCAAAUhAIAAHXMAgAAFjICAAAwqgA==
Date: Wed, 20 Dec 2023 07:52:58 +0000
Message-ID: <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
In-Reply-To: <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
Accept-Language: hu-HU, en-US
Content-Language: hu-HU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [195.228.188.73]
x-esetresult: clean, is OK
x-esetid: 37303A29CE70385C6C7566
Content-Type: text/plain; charset="utf-8"
Content-ID: <B472C035BBCA2D4D9CFF5A4091F4044F@prolan.hu>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Mailman-Approved-At: Wed, 20 Dec 2023 13:13:44 +0100
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

T24gMjAyMy4gMTIuIDIwLiA4OjA5LCBEcmFnYW4gU2ltaWMgd3JvdGU6DQo+IE9uIDIwMjMtMTIt
MjAgMDc6NDksIENzw7Nrw6FzIEJlbmNlIHdyb3RlOg0KPj4gT24gMjAyMy4gMTIuIDE5LiAyMToz
MywgRGFuaWVsIEdvbGxlIHdyb3RlOg0KPj4+IFdoYXQgY29tZXMgdG8gbWluZCBpcyB0aGF0IENP
TkZJR19DT05TT0xFX1JFQ09SRCBhbHNvIGNhcHR1cmVzIEFOU0kNCj4+PiBzZXF1ZW5jZXMgZHVy
aW5nIG1lbnUgb3IgY291bnQtZG93biBiZWZvcmUgYm9vdCwgc28gd2UnZCBoYXZlIHRvIGVpdGhl
cg0KPj4+IGludHJvZHVjZSBhIGRlZGljYXRlZCBsb2dfcHJpbnRmKCkgY2FsbCBhbmQgdXNlIHRo
YXQgd2hlbiBldmVyIHdlIHdhbnQNCj4+PiB0aGUgb3V0cHV0IHRvIGFsc28gYmVjb21lIHBhcnQg
b2YgdGhlIGxvZyBidWZmZXIgb3Igd2UgY291bGQgc29tZWhvdw0KPj4+IGZpbHRlciB0aGUgcmVj
b3JkZWQgY29uc29sZSwgZWxpbWluYXRpbmcgYWxsIHRlcm1pbmFsIGNvbnRyb2wgDQo+Pj4gc2Vx
dWVuY2VzLg0KPj4NCj4+IEkgZG9uJ3QgdGhpbmsgdGhhdCB3b3VsZCBiZSBhIGh1Z2UgcHJvYmxl
bSwgTGludXggdXNlcnNwYWNlIGNhbiBmaWx0ZXINCj4+IEFOU0kgY29udHJvbCBjb2RlcyBpZiBp
dCB3YW50cyB0by4gRm9yIG5vdywgSSdkIGxpa2UgYSBieXRlLWZvci1ieXRlDQo+PiBjb3B5IG9m
IHRoZSBjb25zb2xlLCBhcy1pcywgcHJlc2VudGVkIHRvIExpbnV4Lg0KPg0KPiBCdXQgd291bGRu
J3QgcmVjb3JkaW5nIHRoZSBjb250cm9sIHNlcXVlbmNlcyBhcy1pcyBhY3R1YWxseSBiZSBwcmV0
dHkgDQo+IG11Y2ggdXNlbGVzcz/CoCBGb3IgZXhhbXBsZSwgc29tZSB1c2VyIGNhbiBzcGVuZCBh
IGZldyBtaW51dGVzIA0KPiBzY3JvbGxpbmcgdGhyb3VnaCB0aGUgYm9vdCBtZW51LCB3aGljaCB3
b3VsZCBwcm9kdWNlIGEgZmFpciBhbW91bnQgb2YgDQo+IG5lYXJseSB1c2VsZXNzIHJlY29yZGVk
IGRhdGEuDQo+DQo+IE1vcmVvdmVyLCBpZiBJJ20gbm90IHdyb25nLCB2aWV3aW5nIG9yIHBhcnNp
bmcgc3VjaCBhcy1pcyBkYXRhIHdvdWxkIA0KPiBhY3R1YWxseSByZXF1aXJlIHJlcGxheWluZyB0
aGUgY29udHJvbCBzZXF1ZW5jZXMsIHRvIHJlcHJvZHVjZSB0aGUgDQo+IGFjdHVhbCBjb25zb2xl
IGNvbnRlbnRzIGFzIGl0IHdhcyByZWNvcmRlZCwgd2hpY2ggd291bGQgYmUgcXVpdGUgDQo+IGN1
bWJlcnNvbWUuDQoNCg0KSXQgKmlzKiB1c2VsZXNzLCBidXQgbW9zdCBvZiB0aGUgdGltZXMgdGhl
IHVzZXIgd29uJ3QgYmUgc2Nyb2xsaW5nIGF0IA0KYWxsIGFueXdheXMsIHRoYXQncyB3aHkgSSBk
b24ndCB0aGluayB0aGVzZSBmZXcgZXh0cmEgYnl0ZXMgd291bGQgYmUgYSANCnByb2JsZW0uDQoN
CkFuZCBubywgeW91IGRvbid0IG5lZWQgYW55dGhpbmcgdG8gInByb2Nlc3MiIEFOU0kgY29kZXMs
IHlvdSBjYW4ganVzdCANCmBjYXRgIHRoZW0gYW5kIHlvdXIgdGVybWluYWwgd2lsbCBwYXJzZSBp
dCBhbnl3YXlzLg0KDQoNCj4+IEFzIEkgdW5kZXJzYW5kIChuZXZlciB1c2VkIGl0IGJlZm9yZSwg
anVzdCBxdWlja2x5IHJlYWQgdGhlIGtlcm5lbCBkb2MpLA0KPj4gUFN0b3JlIGlzIGZvciBMaW51
eCAtPiBVLUJvb3QgY29tbXVuaWNhdGlvbi4gV2hhdCBJJ20gZG9pbmcgaXMgdGhlDQo+PiBvcHBv
c2l0ZS4gQnV0IHRoZSBhcHByb2FjaCBJIGVudmlzaW9uZWQgaXMgc2ltaWxhcjogbWFrZSBVLUJv
b3Qgc2F2ZSBhDQo+PiBjb3B5IG9mIHRoZSBsb2cgdG8gYSBzdHJ1Y3QgYXQgYSBmaXhlZCBtZW1v
cnkgYWRkcmVzcywgdGhlbiBwYXNzIHRoaXMNCj4+IGFkZHJlc3MgKyB0aGUgbGVuZ3RoIG9mIHRo
ZSBsb2cgdG8gdGhlIGtlcm5lbCB2aWEgRFQgYW5kL29yIGNvbW1hbmRsaW5lLg0KPg0KPiBBY3R1
YWxseSwgcHN0b3JlIGlzIHByaW1hcmlseSBpbnRlbmRlZCBhcyBhIG1lYW5zIHRvIHJlY29yZCBh
bmQgc3RvcmUgDQo+IGtlcm5lbCBjcmFzaCBkdW1wcyBmb3IgbGF0ZXIgaW52ZXN0aWdhdGlvbi7C
oCBJbiBvdGhlciB3b3JkcywgdGhlIA0KPiBrZXJuZWwgd3JpdGVzIGRhdGEgdG8gcHN0b3JlIGR1
cmluZyBhbiBvb3BzIHNvIGl0IGNhbiBiZSBpbnZlc3RpZ2F0ZWQgDQo+IGxhdGVyLg0KPg0KPiBP
bmUgb2YgdGhlIGJlbmVmaXRzIG9mIHVzaW5nIHBzdG9yZSBmb3IgcmVjb3JkIHRoZSBVLUJvb3Qg
Y29uc29sZSANCj4gY29udGVudHMsIGluc3RlYWQgb2YgdXNpbmcgYSBtZW1vcnkgcmVnaW9uLCBp
cyB0aGF0IG5vIHNwZWNpYWwgDQo+IHV0aWxpdGllcyB3b3VsZCBiZSByZXF1aXJlZCB0byBhY2Nl
c3MgdGhlIHJlY29yZGVkIGNvbnNvbGUgb3V0cHV0cy7CoCANCj4gQWxzbywgbWFueSBvZiB0aGUg
cmVxdWlyZW1lbnRzIHRoYXQgeW91IGxpc3RlZCBiZWxvdyB3b3VsZCBiZSBhbHJlYWR5IA0KPiBm
dWxmaWxsZWQuDQo+DQo+PiBXaGF0IEkgdGhvdWdodCB0byBpbmNsdWRlIGluIHRoZSBzdHJ1Y3Q6
DQo+Pg0KPj4gKiBtYWdpYyBjb29raWUgKGl0IHdhcyBpbiB0aGUgM3JkIHBhcnR5IHNvbHV0aW9u
LCBhbmQgaXQncyBhbiBlYXN5IHdheQ0KPj4gb2YgZG9pbmcgc29tZSBmb3JtIG9mIGludGVncml0
eSBjaGVjaykNCj4+ICogc3RydWN0IHZlcnNpb24gKGluIGNhc2Ugd2UgZXZlciBjaGFuZ2UgdGhl
IGxheW91dCkNCj4+ICogVS1Cb290IHZlcnNpb24gY29kZSAobWF5YmUgbm90IG5lY2Vzc2FyeT8g
SXQgY2FuIGJlIHBhcnNlZCBvdXQgb2YgdGhlDQo+PiBsb2cgYXMgd2VsbCkNCj4+ICogbGVuZ3Ro
IG9mIHRoZSBsb2cgKG9yIGl0IGNvdWxkIGFsc28gYmUgcGFzc2VkIHZpYSBEVC9jbWRsaW5lKQ0K
Pj4gKiBhbmQgdGhlbiB0aGUgbG9nIGJ1ZmZlciBvZiBjb3Vyc2UNCj4NCg0KVGhhdCdzIHdoYXQg
SSByZWFkIGFzIHdlbGwuIElzIHRoZXJlIHN1cHBvcnQgZm9yIFUtYm9vdCB0byB3cml0ZSBhbmQg
DQpMaW51eCB0byByZWFkIFBTdG9yZXM/DQoNCkJlbmNlDQoNCg==

