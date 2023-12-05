Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6499C4167B
	for <u-boot@archiver.kernel.org>; Tue,  5 Dec 2023 12:42:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D8F0A871A0;
	Tue,  5 Dec 2023 13:42:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shokubai.tech header.i=@shokubai.tech header.b="YOCSk9lg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B58C487885; Tue,  5 Dec 2023 11:36:45 +0100 (CET)
Received: from smtpout8.r2.mail-out.ovh.net (smtpout8.r2.mail-out.ovh.net
 [54.36.141.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5D94878B3;
 Tue,  5 Dec 2023 11:36:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ff@shokubai.tech
Received: from DAG2EX3.indiv5.local (unknown [10.111.208.249])
 by mo512.mail-out.ovh.net (Postfix) with ESMTPS id 1970821BA7;
 Tue,  5 Dec 2023 10:36:40 +0000 (UTC)
Received: from DAG2EX1.indiv5.local (172.16.2.21) by DAG2EX3.indiv5.local
 (172.16.2.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Dec
 2023 11:36:29 +0100
Received: from DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b]) by
 DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b%6]) with mapi id
 15.01.2507.035; Tue, 5 Dec 2023 11:36:29 +0100
From: ff <ff@shokubai.tech>
To: Sumit Garg <sumit.garg@linaro.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "u-boot-custodians@lists.denx.de" <u-boot-custodians@lists.denx.de>, "Rob
 Herring" <robh+dt@kernel.org>, Tom Rini <trini@konsulko.com>, "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
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
Thread-Index: AQHaJnNnhdt4kVlXP0S2F0B2DoM1cbCZSWcAgADt+wCAADt7e4AADgv5
Date: Tue, 5 Dec 2023 10:36:28 +0000
Message-ID: <7E60C667-59C9-4210-B8B8-041E00B14D1E@shokubai.tech>
References: <20231121-b4-qcom-common-target-v1-0-9492198e0c15@linaro.org>
 <CAFA6WYPe8_onKNYzAVr9RHVbwUZCTiEkDizwnfL6QRsqii-JUg@mail.gmail.com>
 <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>,
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
In-Reply-To: <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=shokubai.tech; s=ovhex1078890-selector1; 
 c=relaxed/relaxed; t=1701772599; h=from:to:subject:date;
 bh=2jIBLew1OisZ1OOBWiZJQRz3sxVFaXthPTP9Doki3uA=;
 b=YOCSk9lgjx15VvFPPswbXPsdJG1IoRHkVqwJ1+49E84YcdAfnwq8huTsWiAM//8Acfvg/re/ePu9xA65pNBHYW4TUYL04irpxkaf/fgtokn2Y8UGJ+J5ZIg9swvtr7aWkmajhGFqlf9s8Cf97I48BJl4fNWcFAbSbL6rZ4bFqNDYVZzmAzAD4Trs/DFDhRVdW7AL4CR14rCVHiOHtrP1xNUtDKeLyxvrc6CKx89u/F8BeVHZR11VQ5UonDgJwp6px1mKYuP7Ek6qpV0uS/yXWl0b6tHLzeVq2verwqnqnF3i8K+Y1F3qIjeDNtMHKdfdw8+uV9d8KowmKJnitN+UDw==
X-Ovh-Tracer-Id: 18246615366722436785
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgudekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefuthffkfhfjggtgfggsehtsghmtddttdejnecuhfhrohhmpehffhcuoehffhesshhhohhkuhgsrghirdhtvggthheqnecuggftrfgrthhtvghrnhepieevffehtedvvdeffedutdffhfdvgfehvdeileelfeeljeevhedvteefleeuheevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecukfhppeduvdejrddtrddtrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeofhhfsehshhhokhhusggrihdrthgvtghhqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdpuhdqsghoohhtqdgtuhhsthhoughirghnsheslhhishhtshdruggvnhigrdguvgdprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhtrhhinhhisehkohhnshhulhhkohdrtghomhdpkhhriiihshiithhofhdrkhhoiihlohifshhkihdoughtsehlihhnrghrohdrohhrghdptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdptggrlhgvsgdrtghonhhnohhllhihsehlih
 hnrghrohdrohhrghdpnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhhfrhhivggurdguvghvsehgmhgrihhlrdgtohhmpdgushgrnhhkohhushhkihesghhmrghilhdrtghomhdpphgvnhhgrdhfrghnsehngihprdgtohhmpdhjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgrhigrghhonhgurgdrkhhokhgrthgrnhhurhessghrohgruggtohhmrdgtohhmpdhluhhkmhgrseguvghngidruggvpdhsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhjohhrghgvrdhrrghmihhrvgiirdhorhhtihiisehgmhgrihhlrdgtohhmpdhsthgvphhhrghnsehgvghrhhholhgurdhnvghtpdhmrghrvgigseguvghngidruggvpdhuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpshhjghestghhrhhomhhiuhhmrdhorhhgpdgsohhothdqrghrtghhihhtvggtthhurhgvsehlihhsthhsrdhlihhnrghrohdrohhrghdpshhumhhithdrghgrrhhgsehlihhnrghrohdrohhrghdpoffvtefjohhsthepmhhoheduvddpmhhouggvpehsmhhtphhouhhtpdgukhhimhepnhhonhgv
X-Mailman-Approved-At: Tue, 05 Dec 2023 13:42:03 +0100
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

DQoNCj4gTGUgNSBkw6ljLiAyMDIzIMOgIDEwOjQ2LCBTdW1pdCBHYXJnIDxzdW1pdC5nYXJnQGxp
bmFyby5vcmc+IGEgw6ljcml0IDoNCj4gDQo+IO+7vysgVS1ib290IGN1c3RvZGlhbnMgbGlzdA0K
PiANCj4+IE9uIFR1ZSwgNSBEZWMgMjAyMyBhdCAxMjo1OCwgS3J6eXN6dG9mIEtvemxvd3NraQ0K
Pj4gPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4gd3JvdGU6DQo+PiANCj4+IE9uIDA1
LzEyLzIwMjMgMDg6MTMsIFN1bWl0IEdhcmcgd3JvdGU6DQo+Pj4+PiBARFQgYmluZGluZ3MgbWFp
bnRhaW5lcnMsDQo+Pj4+PiANCj4+Pj4+IEdpdmVuIHRoZSBlYXNlIG9mIG1haW50ZW5hbmNlIG9m
IERUIGJpbmRpbmdzIHdpdGhpbiBMaW51eCBrZXJuZWwNCj4+Pj4+IHNvdXJjZSB0cmVlLCBJIGRv
bid0IGhhdmUgYSBzcGVjaWZpYyBvYmplY3Rpb24gdGhlcmUuIEJ1dCBjYW4gd2UgZWFzZQ0KPj4+
Pj4gRFRTIHRlc3RpbmcgZm9yIGZpcm13YXJlL2Jvb3Rsb2FkZXIgcHJvamVjdHMgYnkgcHJvdmlk
aW5nIGEgdmVyc2lvbmVkDQo+Pj4+PiByZWxlYXNlIHBhY2thZ2UgZm9yIERUIGJpbmRpbmdzPyBP
ciBpZiBzb21lb25lIGVsc2UgaGFzIGEgYmV0dGVyIGlkZWENCj4+Pj4+IGhlcmUgcGxlYXNlIGZl
ZWwgZnJlZSB0byBjaGltZSBpbi4NCj4+Pj4gDQo+Pj4+IFRoaXMgZG9lc24ndCB3b3JrIGZvciB5
b3U/Og0KPj4+PiANCj4+Pj4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tl
cm5lbC9naXQvZGV2aWNldHJlZS9kZXZpY2V0cmVlLXJlYmFzaW5nLmdpdC8NCj4+PiANCj4+PiBU
aGFua3MsIHRoaXMgaXMgY2VydGFpbmx5IGEgZ29vZCBzdGVwIHdoaWNoIEkgd2Fzbid0IGF3YXJl
IG9mLiBGdXJ0aGVyDQo+Pj4gc2ltcGxpZmljYXRpb24gY2FuIGJlIGRvbmUgdG8gZGVjb3VwbGUg
ZGV2aWNldHJlZSBzb3VyY2UgZmlsZXMgZnJvbSBEVA0KPj4+IGJpbmRpbmdzLg0KPj4gDQo+PiBX
aHk/DQo+IA0KPiBJIHN1cHBvc2UgeW91IGFyZSBhbHJlYWR5IGF3YXJlIHRoYXQgTGludXggRFRT
IGZpbGVzIGFyZSBhIHN1YnNldCBvZg0KPiB3aGF0IGNvdWxkIGJlIHN1cHBvcnRlZCBieSBkZXZp
Y2V0cmVlIHNjaGVtYXMuIFRoZXJlIGNhbiBiZQ0KPiBmaXJtd2FyZS9ib290bG9hZGVyIHNwZWNp
ZmljIHByb3BlcnRpZXMgKG9uZSBleGFtcGxlIGJlaW5nIFsxXSkgd2hpY2gNCj4gTGludXgga2Vy
bmVsIGNhbiBzaW1wbHkgaWdub3JlLiBXaWxsIHlvdSBiZSB3aWxsaW5nIHRvIGFkZCBhbGwgb2YN
Cj4gdGhvc2UgRFQgcHJvcGVydGllcyB0byBMaW51eCBEVFMgZmlsZXMgYW5kIG1haW50YWluIHRo
ZW0/DQo+IA0KQSBwcmUtZXhpc3RpbmcgZWZmb3J0IHRvIHNvbHZlIHRoZSBzYW1lIHByb2JsZW0g
YXMgWzFdIGlzIFN5c3RlbSBEZXZpY2UgVHJlZSwgZGlzY3Vzc2VkIGluIHRoZSBjb250ZXh0IG9m
IExpbmFybyBzdXBwb3J0ZWQgT3BlbkFNUCBwcm9qZWN0LiBJdCBpcyBub3QganVzdCBhYm91dCBj
aGVycnkgcGlja2luZyBkZXZpY2VzIHRoYXQgaGF2ZSBiaW5kaW5ncyBpbiBMaW51eCBidXQgYWxz
byBpbmZvcm1hdGlvbiBhYm91dCBjbG9jayBhbmQgcG93ZXIgZG9tYWlucyBvciBkZXZpY2VzIHRo
YXQgYXJlIG5vdCBzZWVuIGJ5IExpbnV4Lg0KSXQgaXMgb2J2aW91cyB0aGF0IHRoZSByZXN1bHRp
bmcgYmluZGluZ3Mgc2hvdWxkIGJlIG1haW50YWluZWQgdXBzdHJlYW0gaW4gdGhlIERUIHJlcG8g
cmVnYXJkbGVzcyBvZiB0aGUgY29tbXVuaXRpZXMgYWRvcHRlZCBzb2x1dGlvbi4NCg0KPiBIb3dl
dmVyLCBEVCBiaW5kaW5ncyBhcmUgc29tZXRoaW5nIHdoaWNoIHNob3VsZCBiZSBjb21tb24sIHRo
ZQ0KPiBoYXJkd2FyZSBkZXNjcmlwdGlvbiBvZiBhIGRldmljZSBzaG91bGQgYmUgdW5pdmVyc2Fs
LiBJTU8sIHNwbGl0dGluZw0KPiBEVCBiaW5kaW5ncyBhbG9uZSB3b3VsZCBlYXNlIHRoZSBjb21w
bGlhbmNlIHByb2Nlc3MgZm9yIHUtYm9vdCBkcml2ZXJzDQo+IGluIHF1aXRlIHNpbWlsYXIgbWFu
bmVyIHRvIExpbnV4IGRyaXZlcnMuDQo+IA0KSSByZW1lbWJlciBhIGRpc2N1c3Npb24gd2l0aCBT
VCBvbiB0aGF0IHRvcGljIHJlbGF0ZWQgdG8gRnJhbWVidWZmZXIuIFUtQm9vdCBjYW4gbmVlZCBh
IHZlcnkgZGlmZmVyZW50IHJlcHJlc2VudGF0aW9uIG9mIHRoZSBzYW1lIGRldmljZSB0byB1c2Ug
aXQgd2hpbGUgTGludXggbmVlZCBhbiBpbi1kZXB0aCBkZXNjcmlwdGlvbiBvZiBhbGwgc2hhZGVy
cyBhbmQgwqsgc3R1ZmYgwrsgKGFub3RoZXIgcmVhc29uIHdoeSBbMV0gaXMgYWRkcmVzc2luZyBv
bmx5IGEgcG9ydGlvbiBvZiB0aGUgcHJvYmxlbSkNClNvIGV2ZW4gaWYgdGhlcmUgaXMgYSBzaW5n
bGUgZnJhbWUgYnVmZmVyIGJpbmRpbmcsIHRoZXJlIHNob3VsZCBiZSB0d28gKGF0IGxlYXN0KSBj
b25mb3JtYW5jZSB0ZXN0cy4NCg0KPiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL2RldmljZXRyZWUt
b3JnL2R0LXNjaGVtYS9ibG9iL21haW4vZHRzY2hlbWEvc2NoZW1hcy9ib290cGgueWFtbA0KPiAN
Cj4+IA0KPj4+IEFGQUlLLCBEVCBiaW5kaW5ncyBzaG91bGQgYmUgZm9yd2FyZHMgYW5kIGJhY2t3
YXJkcw0KPj4+IGNvbXBhdGlibGUuDQo+PiANCj4+IFRoZSBzYW1lIHdpdGggRFRTLg0KPj4gDQo+
Pj4gU28gaWYgeW91IHBpY2sgdXAgRFRTIG9yIERUQiBmcm9tIGFueSBwcm9qZWN0IHRyZWUNCj4+
PiAodXBzdHJlYW0ga2VybmVsIG9yIHN0YWJsZSBrZXJuZWwgb3IgdS1ib290KSB0aGVuIERUIHNj
aGVtYSB2YWxpZGF0aW9uDQo+Pj4gd291bGQgZW5zdXJlIHRoYXQgY29ycmVzcG9uZGluZyBEVFMg
b3IgRFRCIGRvZXNuJ3QgcmVncmVzcyB0aGUgRFQNCj4+PiBiaW5kaW5ncy4NCj4+IA0KPj4gQW5k
IHdoeSBpcyB0aGlzIGFyZ3VtZW50IHRvIGRlY291cGxlIERUUyBmcm9tIGJpbmRpbmdzPw0KPj4g
DQo+IA0KPiBTZWUgYWJvdmUuDQo+IA0KPj4+IA0KPj4+IElkZWFsbHksIGl0IHNob3VsZCBiZSBt
b3JlIHVzZXIvQ0kgZnJpZW5kbHkgaWYgRFQgYmluZGluZ3MgY2FuIGJlDQo+Pj4gZWFzaWx5IGlu
c3RhbGxlZCBhbG9uZ3NpZGUgZGV2aWNldHJlZSBzY2hlbWEgdG9vbHMgWzFdLg0KPj4+IA0KPj4+
IFsxXSBodHRwczovL2dpdGh1Yi5jb20vZGV2aWNldHJlZS1vcmcvZHQtc2NoZW1hDQo+PiANCj4+
IERvZXMgaXQgbWVhbiB5b3Ugd2lsbCB3b3JrIG9uIHRoaXM/DQo+IA0KPiBJIGFtIGhhcHB5IHRv
IGNvbGxhYm9yYXRpdmVseSB3b3JrIHdpdGggRFQgYmluZGluZ3MgbWFpbnRhaW5lcnMgYW5kDQo+
IHRoZSB1LWJvb3QgY29tbXVuaXR5IG9uY2Ugd2UgY2FuIHJlYWNoIGEgY29uc2Vuc3VzIG9uIHRo
ZSBhYm92ZS4NCj4gQmFzaWNhbGx5IHRoZSBtYWluIG1vdGl2ZSBoZXJlIGlzIHRvIHZhbGlkYXRl
IERUUyBmaWxlcyBwcmVzZW50IGluIHRoZQ0KPiB1LWJvb3QgdHJlZSBhbmQgYmUgYWJsZSB0byBy
ZWxpYWJseSBwYXNzIHRoZW0gdG8gd2hpY2hldmVyIExpbnV4DQo+IGtlcm5lbCB2ZXJzaW9uIHlv
dSBhcmUgdHJ5aW5nIHRvIGJvb3QuIElPVywgbWFrZSBMaW51eCBkaXN0cm9zIHRvDQo+IHJlbGlh
Ymx5IGJvb3Qgd2l0aCBkZXZpY2V0cmVlIHN1cHBsaWVkIGJ5IHUtYm9vdC4NCj4gDQo+IC1TdW1p
dA0KPiANCj4+IA0KPj4gQmVzdCByZWdhcmRzLA0KPj4gS3J6eXN6dG9mDQo+PiANCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYm9vdC1hcmNoaXRl
Y3R1cmUgbWFpbGluZyBsaXN0IC0tIGJvb3QtYXJjaGl0ZWN0dXJlQGxpc3RzLmxpbmFyby5vcmcN
Cj4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBib290LWFyY2hpdGVjdHVyZS1sZWF2
ZUBsaXN0cy5saW5hcm8ub3JnDQo=
