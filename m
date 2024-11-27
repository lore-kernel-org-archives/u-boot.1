Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 095D4D6ACF1
	for <u-boot@archiver.kernel.org>; Wed, 27 Nov 2024 16:16:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84EBE897BF;
	Wed, 27 Nov 2024 17:16:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dh-electronics.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=dh-electronics.com header.i=@dh-electronics.com header.b="JFQws23Y";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22A6F897D8; Wed, 27 Nov 2024 17:16:05 +0100 (CET)
Received: from mx2.securetransport.de (mx2.securetransport.de [188.68.39.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F96A89708
 for <u-boot@lists.denx.de>; Wed, 27 Nov 2024 17:16:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=dh-electronics.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=cniedermaier@dh-electronics.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dh-electronics.com;
 s=dhelectronicscom; t=1732723927;
 bh=vZjGk0vQQy90hiPpnNnOjYDQs0/r6GH3FCnSHsOzokA=;
 h=From:To:CC:Subject:Date:References:In-Reply-To:From;
 b=JFQws23YgjuTIbxcmjd9265uyVHMtxITORr3z2S6cmHXaFnUjD9EXDpGdoEaVXIhz
 UTXhDEFz0RVunu0RMh6RB+uuyvYM48suoofU3qGFAAB9jxIp/rQoGQz/I8Yjt48VY/
 H6Uf1htaosV6qpdb+QE0Kl5lIo4bXpADHXMGTPSJSIHeUR5uWZrYCTO/KwGIuzkyJQ
 UCJ30Ey2zYfgqX2I79+5C8RFOseHcJg0opf0E0sn73BqcuMToVr3dEJ/Ekmw0zheFY
 hqpOx/07JiI7wYRyAXyrqhbdtbCyLiksNXVBJU/TOcUSJw/ZbBATkSUDcBtix/Ju1+
 1ifjtM+pAzTcw==
X-secureTransport-forwarded: yes
From: Christoph Niedermaier <cniedermaier@dh-electronics.com>
Complaints-To: abuse@cubewerk.de
To: Marek Vasut <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>
CC: NXP i.MX U-Boot Team <uboot-imx@nxp.com>, Fabio Estevam
 <festevam@gmail.com>, Stefano Babic <sbabic@denx.de>, Tom Rini
 <trini@konsulko.com>, u-boot <u-boot@dh-electronics.com>
Subject: RE: [PATCH V3 3/3] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
Thread-Topic: [PATCH V3 3/3] board: dhelectronics: Sync env variable
 dh_som_serial_number with SN
Thread-Index: AQHbPDowKz5UR5jef0WTyIvuB55O4rLG4UaAgAARF4CABGKywA==
Date: Wed, 27 Nov 2024 16:11:55 +0000
Message-ID: <bc2b78f451ee416fb3b38e1a788df01d@dh-electronics.com>
References: <20241121172154.90507-1-cniedermaier@dh-electronics.com>
 <20241121172154.90507-3-cniedermaier@dh-electronics.com>
 <f87a45e6-0f37-4625-bf34-12205b8ee4b7@denx.de>
 <751efcf2-b51f-43b8-affb-46fdbd59002a@denx.de>
In-Reply-To: <751efcf2-b51f-43b8-affb-46fdbd59002a@denx.de>
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

RnJvbTogTWFyZWsgVmFzdXQgPG1hcmV4QGRlbnguZGU+DQpTZW50OiBTdW5kYXksIE5vdmVtYmVy
IDI0LCAyMDI0IDExOjExIFBNDQo+IE9uIDExLzI0LzI0IDEwOjEwIFBNLCBNYXJlayBWYXN1dCB3
cm90ZToNCj4+IE9uIDExLzIxLzI0IDY6MjEgUE0sIENocmlzdG9waCBOaWVkZXJtYWllciB3cm90
ZToNCj4+PiBUaGUgZW52IHZhcmlhYmxlICJTTiIgaXMgdXNlZCB0byBzdG9yZSB0aGUgc2VyaWFs
IG51bWJlciBvbiBESA0KPj4+IGVsZWN0cm9uaWNzDQo+Pj4gU29Ncy4gTmV3IFNvTXMgd2lsbCB1
c2UgdGhlIHZhcmlhYmxlICJkaF9zb21fc2VyaWFsX251bWJlciIuIFRvIGVuc3VyZQ0KPj4+IGNv
bXBhdGliaWxpdHksIHRoZXNlIGVudiB2YXJpYWJsZXMgYXJlIHN5bmNocm9uaXplZC4gVGhpcyBp
cyBhY2hpZXZlZA0KPj4+IHVzaW5nIGNhbGxiYWNrIGZ1bmN0aW9ucy4gVG8gYXZvaWQgcmVjdXJz
aXZlIGNhbGxzLCB0aGVzZSBhcmUgbG9ja2VkDQo+Pj4gYWdhaW5zdCBlYWNoIG90aGVyLg0KPj4N
Cj4+IFdoYXQga2luZCBvZiByZWN1cnNpdmUgY2FsbHM/DQo+Pg0KPj4gSXQgd291bGQgYmUgZ29v
ZCB0byBleHBhbmQgdGhlIGNvbW1pdCBtZXNzYWdlIGFuZCBlbGFib3JhdGUgb24gdGhlDQo+PiBy
ZWN1cnNpdmUgY2FsbHMgcHJvYmxlbSAuDQo+Pg0KPj4+IGRpZmYgLS1naXQgYS9ib2FyZC9kaGVs
ZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYyBiL2JvYXJkLw0KPj4+IGRoZWxlY3Ryb25pY3Mv
Y29tbW9uL2RoX2NvbW1vbi5jDQo+Pj4gaW5kZXggYTdiMDQ3MmEwOS4uMmUzZTVjNDgzYiAxMDA2
NDQNCj4+PiAtLS0gYS9ib2FyZC9kaGVsZWN0cm9uaWNzL2NvbW1vbi9kaF9jb21tb24uYw0KPj4+
ICsrKyBiL2JvYXJkL2RoZWxlY3Ryb25pY3MvY29tbW9uL2RoX2NvbW1vbi5jDQo+Pj4gQEAgLTQ1
LDYgKzQ1LDMyIEBAIHN0cnVjdCBlZXByb21faWRfcGFnZSB7DQo+Pj4gICAjZGVmaW5lIERIX0VF
UFJPTV9JRF9QQUdFX1YxXzBfREFUQV9MRU4gICAgKHNpemVvZihzdHJ1Y3QNCj4+PiBlZXByb21f
aWRfcGFnZSkgLSBcDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgIG9mZnNldG9mKHN0cnVjdCBl
ZXByb21faWRfcGFnZSwgbWFjMCkpDQo+Pj4gK3N0YXRpYyBib29sIGluX2RoX3NvbV9zZXJpYWxf
bnVtYmVyOw0KPj4+ICtzdGF0aWMgYm9vbCBpbl9TTjsNCj4+PiArDQo+Pj4gK3N0YXRpYyBpbnQg
b25fZGhfc29tX3NlcmlhbF9udW1iZXIoY29uc3QgY2hhciAqbmFtZSwgY29uc3QgY2hhcg0KPj4+
ICp2YWx1ZSwgZW51bSBlbnZfb3Agb3AsDQo+Pj4gKyAgICAgICAgICAgICAgICAgICBpbnQgZmxh
Z3MpDQo+Pj4gK3sNCj4+PiArICAgIGluX2RoX3NvbV9zZXJpYWxfbnVtYmVyID0gdHJ1ZTsNCj4+
PiArICAgIGlmICghaW5fU04pDQo+Pj4gKyAgICAgICAgZW52X3NldCgiU04iLCB2YWx1ZSk7DQo+
Pj4gKyAgICBpbl9kaF9zb21fc2VyaWFsX251bWJlciA9IGZhbHNlOw0KPj4+ICsgICAgcmV0dXJu
IDA7DQo+Pj4gK30NCj4gTWF5YmUgYSBtb3JlIGdlbmVyaWMgc29sdXRpb24gaXM6DQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbGliL2hhc2h0YWJsZS5jIGIvbGliL2hhc2h0YWJsZS5jDQo+IGluZGV4IGU4
YTU5ZTJkY2FjLi43NWMyNjNiNTA1MyAxMDA2NDQNCj4gLS0tIGEvbGliL2hhc2h0YWJsZS5jDQo+
ICsrKyBiL2xpYi9oYXNodGFibGUuYw0KPiBAQCAtMjIxLDExICsyMjEsMzIgQEAgc3RhdGljIGlu
dA0KPiAgIGRvX2NhbGxiYWNrKGNvbnN0IHN0cnVjdCBlbnZfZW50cnkgKmUsIGNvbnN0IGNoYXIg
Km5hbWUsIGNvbnN0IGNoYXINCj4gKnZhbHVlLA0KPiAgICAgICAgICAgICAgZW51bSBlbnZfb3Ag
b3AsIGludCBmbGFncykNCj4gICB7DQo+ICsgICAgICAgaW50IHJldCA9IDA7DQo+ICsNCj4gICAj
aWZuZGVmIENPTkZJR19YUExfQlVJTEQNCj4gLSAgICAgICBpZiAoZS0+Y2FsbGJhY2spDQo+IC0g
ICAgICAgICAgICAgICByZXR1cm4gZS0+Y2FsbGJhY2sobmFtZSwgdmFsdWUsIG9wLCBmbGFncyk7
DQo+ICsgICAgICAgc3RhdGljIGJvb2wgaW5fY2FsbGJhY2s7DQo+ICsNCj4gKyAgICAgICBpZiAo
IWUtPmNhbGxiYWNrIHx8IGluX2NhbGxiYWNrKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIDA7
DQo+ICsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIEluIGNhc2UgdGhlcmUgYXJlIHR3byB2
YXJpYWJsZXMgd2hpY2ggZWFjaCBpbXBsZW1lbnQgZW52IGNhbGxiYWNrDQo+ICsgICAgICAgICog
dGhhdCBwZXJmb3JtcyBlbnZfc2V0KCkgb24gdGhlIG90aGVyIHZhcmlhYmxlLCB0aGUgY2FsbGJh
Y2tzIHdpbGwNCj4gKyAgICAgICAgKiBjYWxsIGVhY2ggb3RoZXIgcmVjdXJzaXZlbHkgdW50aWwg
dGhlIHN0YWNrIHJ1bnMgb3V0LiBQcmV2ZW50IHN1Y2gNCj4gKyAgICAgICAgKiBhIHJlY3Vyc2lv
biBmcm9tIGhhcHBlbmluZy4NCj4gKyAgICAgICAgKg0KPiArICAgICAgICAqIEV4YW1wbGUgd2hp
Y2ggdHJpZ2dlcnMgdGhpcyBiZWhhdmlvcjoNCj4gKyAgICAgICAgKiBzdGF0aWMgaW50IG9uX2Zv
byguLi4pIHsgZW52X3NldCgiYmFyIiwgMCk7IC4uLiB9DQo+ICsgICAgICAgICogc3RhdGljIGlu
dCBvbl9iYXIoLi4uKSB7IGVudl9zZXQoImZvbyIsIDApOyAuLi4gfQ0KPiArICAgICAgICAqIFVf
Qk9PVF9FTlZfQ0FMTEJBQ0soZm9vLCBvbl9mb28pOw0KPiArICAgICAgICAqIFVfQk9PVF9FTlZf
Q0FMTEJBQ0soYmFyLCBvbl9iYXIpOw0KPiArICAgICAgICAqLw0KPiArICAgICAgIGluX2NhbGxi
YWNrID0gdHJ1ZTsNCj4gKyAgICAgICByZXQgPSBlLT5jYWxsYmFjayhuYW1lLCB2YWx1ZSwgb3As
IGZsYWdzKTsNCj4gKyAgICAgICBpbl9jYWxsYmFjayA9IGZhbHNlOw0KPiAgICNlbmRpZg0KPiAt
ICAgICAgIHJldHVybiAwOw0KPiArDQo+ICsgICAgICAgcmV0dXJuIHJldDsNCj4gICB9DQo+IA0K
PiAgIC8qDQoNCkxvb2tzIGdvb2QsIEkgd2lsbCBpbnRlZ3JhdGUgaXQgaW4gVjQuDQoNClJlZ2Fy
ZHMNCkNocmlzdG9waA0K
