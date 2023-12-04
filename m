Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E9FC4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 20:58:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1F93D876DA;
	Mon,  4 Dec 2023 21:58:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shokubai.tech header.i=@shokubai.tech header.b="S3B7JIh5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4B940875DB; Mon,  4 Dec 2023 16:01:45 +0100 (CET)
Received: from smtpout13.mo541.mail-out.ovh.net
 (smtpout13.mo541.mail-out.ovh.net [146.59.177.44])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0936787603
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 16:01:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ff@shokubai.tech
Received: from DAG2EX2.indiv5.local (unknown [10.111.172.35])
 by mo541.mail-out.ovh.net (Postfix) with ESMTPS id 165B52410E;
 Mon,  4 Dec 2023 15:01:40 +0000 (UTC)
Received: from DAG2EX1.indiv5.local (172.16.2.21) by DAG2EX2.indiv5.local
 (172.16.2.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Dec
 2023 16:01:39 +0100
Received: from DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b]) by
 DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b%6]) with mapi id
 15.01.2507.035; Mon, 4 Dec 2023 16:01:39 +0100
From: ff <ff@shokubai.tech>
To: Sumit Garg <sumit.garg@linaro.org>
CC: Daniel Thompson <daniel.thompson@linaro.org>, Tom Rini
 <trini@konsulko.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, Ramon Fried
 <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Rayagonda
 Kokatanur" <rayagonda.kokatanur@broadcom.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jorge Ramirez-Ortiz
 <jorge.ramirez.ortiz@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
 "Marek Vasut" <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "Simon Glass" <sjg@chromium.org>, Boot Architecture Mailman List
 <boot-architecture@lists.linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Thread-Topic: [PATCH 00/21] Qualcomm generic board support
Thread-Index: AQHaJnNnhdt4kVlXP0S2F0B2DoM1cbCY5ICAgAAoUACAABVhgA==
Date: Mon, 4 Dec 2023 15:01:38 +0000
Message-ID: <1E72D0CC-E4DA-40FF-B321-9CEA4B9A1B75@shokubai.tech>
References: <CAFA6WYPYfKU9hHh5CCbgcb6FEDX7ivGO=tGv4N2dAX6_gAGuUw@mail.gmail.com>
In-Reply-To: <CAFA6WYPYfKU9hHh5CCbgcb6FEDX7ivGO=tGv4N2dAX6_gAGuUw@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
Content-Type: text/plain; charset="utf-8"
Content-ID: <1485E88F7BB3A64A887490FBE3AF2AD0@indiv5.local>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=shokubai.tech; s=ovhex1078890-selector1; 
 c=relaxed/relaxed; t=1701702099; h=from:to:subject:date;
 bh=ohVUtRmh8mr6bPz7Wd0y3FT/cDtr3VjG2cog0qr5xwY=;
 b=S3B7JIh5ItTdn0MxA+lanrrbq0dV2+RxUVYYwO9/GaEvdJwFykBHTsjoWGar2n42W3WR6dOCku/u7nCCJX9PLyKP7uLRmCdGq9/+qi2sIsMiT526uulDLUEVh5rtUTDn9uBLAkNBrbUHWFNibJMRjsQIqpf/EUWlo89+VGfGmDEbT1N9cIb3aA2zGMdyVJKj7l9NO2hOUxow2/cWvEPWTXdVHIcfHbAAFgF9XX7zNVzOtnitQYhh/fPDnpZng6Me8kA9rO36ecB5qbxxvj72OYEiMi8+ZhhewKtMPTPcWTbes3I7vpPKgeu/n7vSJ2aEShyfstSjxPKGPqJj9yZgjw==
X-Ovh-Tracer-Id: 16849373581219774129
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefuthffkfhfjggtgfggsehtsghmtddttdejnecuhfhrohhmpehffhcuoehffhesshhhohhkuhgsrghirdhtvggthheqnecuggftrfgrthhtvghrnhepgfelleekvdejtdefteettdekfeejkeegvdejtdelheeutefhffehffeggfejvedvnecukfhppeduvdejrddtrddtrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeofhhfsehshhhokhhusggrihdrthgvtghhqedpnhgspghrtghpthhtohepuddprhgtphhtthhopegurghnihgvlhdrthhhohhmphhsohhnsehlihhnrghrohdrohhrghdpthhrihhniheskhhonhhsuhhlkhhordgtohhmpdhrohgshhdoughtsehkvghrnhgvlhdrohhrghdpkhhriiihshiithhofhdrkhhoiihlohifshhkihdoughtsehlihhnrghrohdrohhrghdptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdptggrlhgvsgdrtghonhhnohhllhihsehlihhnrghrohdrohhrghdpnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhhfrhhivggurdguvghvsehgmhgrihhlrdgtohhmpdgushgrnhhkohhushhkih
 esghhmrghilhdrtghomhdpphgvnhhgrdhfrghnsehngihprdgtohhmpdhjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgrhigrghhonhgurgdrkhhokhgrthgrnhhurhessghrohgruggtohhmrdgtohhmpdhluhhkmhgrseguvghngidruggvpdhsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhjohhrghgvrdhrrghmihhrvgiirdhorhhtihiisehgmhgrihhlrdgtohhmpdhsthgvphhhrghnsehgvghrhhholhgurdhnvghtpdhmrghrvgigseguvghngidruggvpdhuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpshhjghestghhrhhomhhiuhhmrdhorhhgpdgsohhothdqrghrtghhihhtvggtthhurhgvsehlihhsthhsrdhlihhnrghrohdrohhrghdpshhumhhithdrghgrrhhgsehlihhnrghrohdrohhrghdpoffvtefjohhsthepmhhoheeguddpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Mon, 04 Dec 2023 21:58:11 +0100
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

DQoNCj4gTGUgNCBkw6ljLiAyMDIzIMOgIDE0OjI1LCBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxp
bmFyby5vcmc+IGEgw6ljcml0IDoNCj4gDQo+IO+7v09uIE1vbiwgNCBEZWMgMjAyMyBhdCAxNjoz
MCwgRGFuaWVsIFRob21wc29uIDxkYW5pZWwudGhvbXBzb25AbGluYXJvLm9yZz4gd3JvdGU6DQo+
PiANCj4+PiBPbiBNb24sIERlYyAwNCwgMjAyMyBhdCAxMTowMjo1N0FNICswNTMwLCBTdW1pdCBH
YXJnIHdyb3RlOg0KPj4+ICsgTGludXgga2VybmVsIERUIGJpbmRpbmdzIG1haW50YWluZXJzLCBF
QkJSIE1MDQo+Pj4gDQo+Pj4gT24gVGh1LCAzMCBOb3YgMjAyMyBhdCAyMDowNSwgVG9tIFJpbmkg
PHRyaW5pQGtvbnN1bGtvLmNvbT4gd3JvdGU6DQo+Pj4+IE9uIFRodSwgTm92IDMwLCAyMDIzIGF0
IDAxOjAyOjI1UE0gKzA1MzAsIFN1bWl0IEdhcmcgd3JvdGU6DQo+Pj4+PiBPbiBXZWQsIDI5IE5v
diAyMDIzIGF0IDIyOjA2LCBOZWlsIEFybXN0cm9uZyA8bmVpbC5hcm1zdHJvbmdAbGluYXJvLm9y
Zz4gd3JvdGU6DQo+Pj4+Pj4+IEkndmUgYmVlbiB0aGlua2luZyBhYm91dCBhbmQgaGFja2luZyBv
biB0aGlzIGZvciB0aGUgbGFzdCB3ZWVrIG9yIHNvLA0KPj4+Pj4+PiBzb3JyeSBmb3IgdGhlIGRl
bGF5ZWQgcmVwbHkgaGVyZS4NCj4+Pj4+Pj4gDQo+Pj4+Pj4+IFRoZSB2YWx1ZSBpcyBpbiBwcmV2
ZW50aW5nIGFueSBvZiB0aGUgZXhpc3RpbmcgYmluZGluZ3MgZnJvbSByZWdyZXNzaW5nLA0KPj4+
Pj4gDQo+Pj4+PiBUaGF0IGlzIGFjdHVhbGx5IGJlc3QgYWRkcmVzc2VkIGluIExpbnV4IGJ5IGNo
ZWNraW5nIHRoZSBEVFMgYWdhaW5zdA0KPj4+Pj4geWFtbCBEVCBiaW5kaW5ncy4gV2UgZG9uJ3Qg
aGF2ZSB0aGF0IHRlc3RpbmcgYXZhaWxhYmxlIGluIHUtYm9vdCBhbmQNCj4+Pj4+IG9ubHkgZGVw
ZW5kIG9uIGNhcmVmdWwgcmV2aWV3cy4NCj4+Pj4gDQo+Pj4+IEkgd291bGQgYWJzb2x1dGVseSBs
b3ZlIGZvciBzb21lb25lIHRvIG1ha2UgYW5vdGhlciBhdHRlbXB0IGF0IHVwZGF0aW5nDQo+Pj4+
IG91ciBrYnVpbGQgaW5mcmFzdHVjdHVyZSBzbyB0aGF0IHdlIGNhbiBydW4gdGhlIHZhbGlkYXRp
b24gdGFyZ2V0cy4NCj4+Pj4gDQo+Pj4gDQo+Pj4gR2l2ZW4gdGhhdCBFQkJSIHJlcXVpcmVzIFsx
XSB0aGUgcGxhdGZvcm0gKGZpcm13YXJlL2Jvb3Rsb2FkZXIpIGFuZA0KPj4+IG5vdCBPUyB0byBz
dXBwbHkgdGhlIGRldmljZXRyZWUsIGl0IGJlY29tZXMgZXZpZGVudCB0aGF0DQo+Pj4gZmlybXdh
cmUvYm9vdGxvYWRlcnMgaW1wb3J0IERUUyBmcm9tIExpbnV4IGtlcm5lbCAod2hlcmUgaXQgaXMN
Cj4+PiBtYWludGFpbmVkKS4NCj4+PiANCj4+PiBCdXQgY3VycmVudGx5IHUtYm9vdCBkb2Vzbid0
IGhhdmUgYSBwcm9wZXIgd2F5IHRvIHZhbGlkYXRlIHRob3NlIERUUw0KPj4+IGFnYWluc3QgRFQg
YmluZGluZ3MgKG1haW50YWluZWQgaW4gTGludXgga2VybmVsKS4gQWx0aG91Z2ggdGhlcmUgYXJl
DQo+Pj4gRGV2aWNldHJlZSBzY2hlbWEgdG9vbHMgYXZhaWxhYmxlIGhlcmUgWzJdLCB0aGVyZSBp
c24ndCBhIHZlcnNpb25lZA0KPj4+IHJlbGVhc2UgcGFja2FnZSBvZiBEVCBiaW5kaW5ncyB3aGlj
aCBvbmUgc2hvdWxkIHVzZSB0byB2YWxpZGF0ZSBEVFMNCj4+PiBmaWxlcy4NCj4+IA0KPj4gVGhl
IGtlcm5lbCBpcyByZWd1bGFybHkgcmVsZWFzZWQgaW4gbXVsdGlwbGUgZm9ybXMgKGluY2x1ZGlu
ZyBnaXQNCj4+IHRhZ3MgYW5kIHRhcmJhbGwpLiBXaHkgaXNuJ3QgdGhlIGtlcm5lbCBpdHNlbGYg
c3VmZmljaWVudCB0byBiZSBhDQo+PiB2ZXJzaW9uZWQgcmVsZWFzZSBvZiB0aGUgRFQgYmluZGlu
Z3MgZGlyZWN0b3J5Pw0KPj4gDQo+IA0KPiBUaGUgTGludXgga2VybmVsIG1heSBjb21lIGluIHZh
cmlvdXMgZm9ybXMgKHVwc3RyZWFtIHZzIHN0YWJsZSB2cw0KPiB2ZW5kb3IpLiBJdCdzIGRpZmZp
Y3VsdCB0byBkZWNpZGUgZnJvbSB3aGVyZSB0aGUgRFQgYmluZGluZ3Mgc2hvdWxkDQo+IGNvbWUg
ZnJvbS4gU2hvdWxkIHRoZXkgY29tZSBmcm9tIHVwc3RyZWFtIG9yIHNob3VsZCB0aGV5IGNvbWUg
ZnJvbSB0aGUNCj4ga2VybmVsIHdoaWNoIGlzIGFjdHVhbGx5IGJvb3RlZCBvbnRvIGEgcGFydGlj
dWxhciBkZXZpY2U/DQo+IA0KTG9va3MgYmFkIGZyb20gb3JnYW5pemluZyBmb3J3YXJkIHBvcnRh
YmlsaXR5IHN0YW5kcG9pbnQgLg0KDQo+IElPVywgYXMgb2Ygbm93IHdoaWNoIGtlcm5lbCB2ZXJz
aW9uIHNob3VsZCB1LWJvb3QgcGljayB1cCBmb3IgRFQNCj4gdmFsaWRhdGlvbiBjaGVja3M/DQo+
IA0KPiBJZiB3ZSBjYW4gaGF2ZSBhIHNlcGFyYXRlIHJlbGVhc2UgY2FkZW5jZSBmb3IgRFQgYmlu
ZGluZ3MgdGhlbiB0aGUNCj4gcGxhdGZvcm0gKGZpcm13YXJlL2Jvb3Rsb2FkZXIpIGNhbiBhdHRl
c3QgdGhlIERUQiBhZ2FpbnN0IHRoYXQuIExhdGVyDQo+IG9uZSBzaG91bGQgYmUgYWJsZSB0byBi
b290IGFueSBrZXJuZWwgd2l0aCB0aGUgRFRCIHByb3ZpZGVkIGJ5DQo+IHBsYXRmb3JtLg0KPiAN
ClRoYXQgc2VlbXMgYSB2ZXJ5IGdvb2Qgc3RlcCENCj4gLVN1bWl0DQo+IA0KPj4gDQo+PiBEYW5p
ZWwuDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+
IGJvb3QtYXJjaGl0ZWN0dXJlIG1haWxpbmcgbGlzdCAtLSBib290LWFyY2hpdGVjdHVyZUBsaXN0
cy5saW5hcm8ub3JnDQo+IFRvIHVuc3Vic2NyaWJlIHNlbmQgYW4gZW1haWwgdG8gYm9vdC1hcmNo
aXRlY3R1cmUtbGVhdmVAbGlzdHMubGluYXJvLm9yZw0K
