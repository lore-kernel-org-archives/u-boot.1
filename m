Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46576CEACEE
	for <u-boot@archiver.kernel.org>; Tue,  1 Oct 2024 17:30:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EFCB58924C;
	Tue,  1 Oct 2024 19:30:40 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=gmx.de header.i=xypron.glpk@gmx.de header.b="j6wcrgD+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F76A8922E; Tue,  1 Oct 2024 19:30:13 +0200 (CEST)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6401E89230
 for <u-boot@lists.denx.de>; Tue,  1 Oct 2024 19:30:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=xypron.glpk@gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1727803774; x=1728408574; i=xypron.glpk@gmx.de;
 bh=NT5CskuDkEOjKn0rOphkSYT0FbFHG9U9rk63ZgMlBgM=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 cc:content-transfer-encoding:content-type:date:from:message-id:
 mime-version:reply-to:subject:to;
 b=j6wcrgD+aKLEVTvDqdRHXaHKE5ssovRIe7mki7ubNuNUVHrQERvOOm5iMn1FGkLK
 AX0HqiIbiwZSLvYHY+r8COl9177KlQPd6FaTUXcZoszRLgfuBaFOBJDLUpBQKd0pS
 4CXIlaK1x0E4PpbBHWUQTP5gm+FBe4ADZgXCAirB99fCmFV0UsgIg9Y2nPYk3O3B5
 b6eljIJWBgQGb5aSrOwKm42upo+CHBgVyfo9+BHK4JOYg1C4cpHWavyjKKe1t9nlD
 ytSnIjd5SCS5l8QK4iRn1b32v8wOrYYR6PaZeEV5cXYQYI4oSRQgBxtuCPA5EY2iz
 Arzg+XKAlOCEgVJ5Cw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.103.101] ([5.147.80.91]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mr9Bu-1s8pjM132s-00jOnL; Tue, 01
 Oct 2024 19:29:34 +0200
Message-ID: <1c9361ed-3e4c-4068-80ec-722de48f2149@gmx.de>
Date: Tue, 1 Oct 2024 19:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] bootstd: sunxi: Migrate to standard boot
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
To: Simon Glass <sjg@chromium.org>
Cc: Tom Rini <trini@konsulko.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Andre Przywara <andre.przywara@arm.com>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, Andrew Davis <afd@ti.com>,
 Bin Meng <bmeng@tinylab.org>, Bryan Brattlof <bb@ti.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Dragan Simic <dsimic@manjaro.org>, Eddie James <eajames@linux.ibm.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Janne Grunau <j@jannau.net>,
 Jesse Taube <mr.bossman075@gmail.com>,
 Joe Hershberger <joe.hershberger@ni.com>, Johan Jonker <jbx6244@gmail.com>,
 Julien Masson <jmasson@baylibre.com>, Kever Yang
 <kever.yang@rock-chips.com>, "Leon M. Busch-George" <leon@georgemail.eu>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Ramon Fried
 <rfried.dev@gmail.com>, Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Stefan Roese <sr@denx.de>, Sumit Garg <sumit.garg@linaro.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Tony Dinh <mibodhi@gmail.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
References: <20240823204824.443631-1-sjg@chromium.org>
 <CAFLszTjrxJA_ZmU-Uptb=kYJcvaXwCwNHg0MeGVW=DNUhPoSaw@mail.gmail.com>
 <c1aa3261-2829-4b94-a12f-f89e1bda499a@gmx.de>
Content-Language: en-US
In-Reply-To: <c1aa3261-2829-4b94-a12f-f89e1bda499a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:E7ExMSWlJusdLQFB3xWARKrGeWio++hdIYe9TqBzaRcDOqcttB9
 nJ6i6WzjFKLy2+UJj+djJq84hmvDomD/QyHPI2o9GqGq51CFsTjUcESrOeu6zFAX85gQjIn
 TKK13CdflFeUVs4ge2HWGhxULguJ/f5bFOItU5LQqcdKphEV76v6GtOYyNUJAx3PYiO0djW
 ZwGSPBbcvijhGTXT1vl0g==
UI-OutboundReport: notjunk:1;M01:P0:mBkDTCq9bCQ=;RCRC5vCG8kteMnX3Bz2Bv2dEChl
 b3Byyf7QKxBMwj/e9MmzgxfgqQcgQV/OSJI08uJ5+aOHRCeXFVfztVf4nCy2oXzEzi6KONBeM
 8/L6jiXRfE5MsXuIJBDUMrK6pgYB1jm3g79Z0U0U/welC7+21cLb0qCgX0f7huf8AEm2vWdKM
 4UVQL6VekAUefb+FE9+kQCoB43GIABbz6xvJswYpktrNg8BUKhuy7KVhggQxhZrIE3M6niFJk
 vTg+vi3C66Np/+DvndbtEJzpnfdZReN//4UbXkwGxsq4ABUomIXSiJhcFi9lmhkzqugHs23oA
 knj3h36d+DWEzAjP8gFiVLDz+HUJeEtKKw2bZYCAm4inCYdLZOpypzGFXZ7ciH7mADfXX8dc7
 RD73OJoeOyW22iq8DYveDqEyQl5sB737mvRo1M4r5yhLMXQ3bSmKuzw/QqSRxGVBon3F2GqHO
 5Rn338462Vb+SMjFTVheeUva/WosxOkQx3DTPQkSqmoGYMGGEFUGg2doi4E3Ls1etnSjXhi9D
 8MvzsSaJNoWq9aqYSyqgHpaX7wQujS1c16S/lrKo3Eme/Zz0tvzCx3GRA2AYrm+QnlhL5N+zW
 2FqHwj/MahMJPtyiEIfGnBJd8gl/+b6HRUl8qVWTAsLA/nruhrzmTRBuHSorFXSI0sb8eW7/p
 tTeeXNL065C7F9/k9gCnIeq14fozxbxeQGSm3QzZmsEGrJIqTw2WA5sCNcVo2NpmBfq+s2XPl
 PmeiqAaPuKntSZAoy2Z6Kvh21eq/HCwVlLAhFE2sBNx2OvV9zGzXriczKcBGL/+0gMJzZJ/EO
 paWFwZYCfUnYc/4Z6FId71Xw==
X-Mailman-Approved-At: Tue, 01 Oct 2024 19:30:40 +0200
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

T24gMDEuMTAuMjQgMTk6MTUsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+IE9uIDAxLjEw
LjI0IDEzOjE4LCBTaW1vbiBHbGFzcyB3cm90ZToNCj4+IEhpLA0KPj4NCj4+IE9uIEZyaSwgMjMg
QXVnIDIwMjQgYXQgMTQ6NDgsIFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPiB3cm90ZToN
Cj4+Pg0KPj4+IFRoaXMgc2VyaWVzIGF0dGVtcHRzIHRvIG1pZ3JhdGUgYWxsIHN1bnhpIGJvYXJk
cyB0byB1c2Ugc3RhbmRhcmQgYm9vdCwNCj4+PiBhbG9uZyB3aXRoIGEgdGV4dCBlbnZpcm9ubWVu
dC4NCj4+Pg0KPj4+IENoYW5nZXMgaW4gdjI6DQo+Pj4gLSBBZGQgbmV3IHBhdGNoIHRvIHJlc29s
dmUgQk9PVFNURC0+QkxLIHJlY3Vyc2lvbiB3aXRoIEtjb25maWcNCj4+PiAtIFB1dCB0aGUgRkVM
IGJvb3RtZXRoIGJlZm9yZSBhbGwgb3RoZXIgZ2xvYmFsIGJvb3RtZXRocw0KPj4+IC0gQ29udmVy
dCB0aGUgb3RoZXIgRElTVFJPX0RFRkFVTFRTIGluIHRoZSBLY29uZmlnIHRvbw0KPj4+IC0gS2Vl
cCBCT09UQ01EX1NVTlhJX0NPTVBBVA0KPj4+IC0gS2VlcCBib290Y21kX3N1bnhpX2NvbXBhdCBp
ZiBPTERfU1VOWElfS0VSTkVMX0NPTVBBVCBpcyBlbmFibGVkDQo+Pj4NCj4+PiBTaW1vbiBHbGFz
cyAoOCk6DQo+Pj4gwqDCoCBibGs6IE1ha2UgZnVuY3Rpb25zIGF2YWlsYWJsZSB1bmNvbmRpdGlv
bmFsbHkNCj4+PiDCoMKgIGJvb3RzdGQ6IEF2b2lkIGNhbGxpbmcgdW5hdmFpbGFibGUgYmxvY2sg
ZnVuY3Rpb25zDQo+Pj4gwqDCoCBib290c3RkOiBBdm9pZCBkZXBlbmRpbmcgb24gQkxLDQo+Pj4g
wqDCoCBzdW54aTogQWRkIGEgYm9vdG1ldGggZm9yIEZFTA0KPj4+IMKgwqAgc3VueGk6IE1vdmUg
dG8gYm9vdHN0ZA0KPj4+IMKgwqAgc3VueGk6IERyb3Agb2xkIGRpc3RybyBib290IHZhcmlhYmxl
cw0KPj4+IMKgwqAgZW52OiBQcm92aWRlIGEgd29yay1hcm91bmQgZm9yIHVucXVvdGluZyBmZHRm
aWxlDQo+Pj4gwqDCoCBzdW54aTogTW92ZSB0byB0ZXh0IGVudmlyb25tZW50DQo+Pj4NCj4+PiDC
oCBNYWtlZmlsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4+IMKgIGFyY2gvYXJtL0tj
b25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHzCoCAxMCArLQ0KPj4+IMKgIGJvYXJkL3N1bnhpL3N1bnhpLmVudsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDE1MiArKysrKysrKysrKw0K
Pj4+IMKgIGJvb3QvS2NvbmZpZ8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMTYgKy0NCj4+PiDCoCBib290L01ha2Vm
aWxlwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCAxICsNCj4+PiDCoCBib290L2Jvb3RkZXYtdWNsYXNzLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMyArDQo+Pj4g
wqAgYm9vdC9ib290bWV0aF9mZWwuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDgxICsrKysrKw0KPj4+IMKgIC4uLi9nYXJkZW5hLXNtYXJ0
LWdhdGV3YXktbXQ3Njg4X2RlZmNvbmZpZ8KgwqDCoCB8wqDCoCAxICsNCj4+PiDCoCBkb2MvdXNh
Z2UvZW52aXJvbm1lbnQucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCB8wqAgMTIgKw0KPj4+IMKgIGluY2x1ZGUvYmxrLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDkgKy0NCj4+PiDC
oCBpbmNsdWRlL2NvbmZpZ3Mvc3VueGktY29tbW9uLmjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfCAyMzggLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gwqAgMTEgZmlsZXMgY2hhbmdlZCwg
Mjc4IGluc2VydGlvbnMoKyksIDI0NiBkZWxldGlvbnMoLSkNCj4+PiDCoCBjcmVhdGUgbW9kZSAx
MDA2NDQgYm9hcmQvc3VueGkvc3VueGkuZW52DQo+Pj4gwqAgY3JlYXRlIG1vZGUgMTAwNjQ0IGJv
b3QvYm9vdG1ldGhfZmVsLmMNCj4+Pg0KPj4+IC0tIA0KPj4+IDIuMzQuMQ0KPj4+DQo+Pg0KPj4g
SSdtIGp1c3QgY2hlY2tpbmcgb24gdGhpcyBzZXJpZXMuIEFyZSB0aGVyZSBhbnkgY29tbWVudHMs
IG9yIGNhbiBpdCBiZSANCj4+IGFwcGxpZWQ/DQo+Pg0KPj4gUmVnYXJkcywNCj4+IFNpbW9uDQo+
IA0KPiBIZWxsbyBTaW1vbiwNCj4gDQo+IE15IE9yYW5nZVBpIFBDIHN0aWxsIHNob3dzIGJvb3Rj
bWQ9J3J1biBkaXN0cm9fYm9vdGNtZCcuIFRoaXMgZG9lcyBub3QNCj4gbG9vayBsaWtlIHN0YW5k
YXJkIGJvb3QuDQoNCk15IGZhdWx0LiBTb21ldGhpbmcgd2VudCB3cm9uZyBpbiBmbGFzaGluZyB0
aGUgU0QtY2FyZC4NCg0KVGVzdGVkLWJ5OiBIZWlucmljaCBTY2h1Y2hhcmR0IDx4eXByb24uZ2xw
a0BnbXguZGU+DQoNCj4gDQo+IE15IFBpbmU2NC1MVFMgYm9vdHMgZmluZSB3aXRoIHRoaXMgc2Vy
aWVzIGFwcGxpZWQgb24gdG9wIG9mIG9yaWdpbi9uZXh0Lg0KPiBib290Y21kPSdib290ZmxvdyBz
Y2FuJy4gVGhlIEVGSSBib290IG1hbmFnZXIgbWV0aG9kIGlzIGNhbGxlZA0KPiBzdWNjZXNzZnVs
bHkgdG8gc3RhcnQgVWJ1bnR1Lg0KPiANCj4gQmVzdCByZWdhcmRzDQo+IA0KPiBIZWlucmljaA0K
DQo=
