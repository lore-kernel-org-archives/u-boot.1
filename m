Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EDF9C4167B
	for <u-boot@archiver.kernel.org>; Mon,  4 Dec 2023 14:40:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 11FCD87751;
	Mon,  4 Dec 2023 15:39:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=shokubai.tech header.i=@shokubai.tech header.b="TSZNeiEn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 59A00875BF; Mon,  4 Dec 2023 15:38:20 +0100 (CET)
Received: from 10.mo546.mail-out.ovh.net (10.mo546.mail-out.ovh.net
 [46.105.76.192])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 09961874CA
 for <u-boot@lists.denx.de>; Mon,  4 Dec 2023 15:38:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ff@shokubai.tech
Received: from DAG2EX3.indiv5.local (unknown [10.111.172.45])
 by mo546.mail-out.ovh.net (Postfix) with ESMTPS id C510B26445;
 Mon,  4 Dec 2023 14:38:15 +0000 (UTC)
Received: from DAG2EX1.indiv5.local (172.16.2.21) by DAG2EX3.indiv5.local
 (172.16.2.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 4 Dec
 2023 15:38:14 +0100
Received: from DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b]) by
 DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b%6]) with mapi id
 15.01.2507.035; Mon, 4 Dec 2023 15:38:13 +0100
From: ff <ff@shokubai.tech>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: Sumit Garg <sumit.garg@linaro.org>, Tom Rini <trini@konsulko.com>, "Rob
 Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
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
Thread-Index: AQHaJnNnhdt4kVlXP0S2F0B2DoM1cbCY5ICAgABNn/Y=
Date: Mon, 4 Dec 2023 14:38:13 +0000
Message-ID: <8A726F05-79DF-4DA2-AC25-FC91948F6BB6@shokubai.tech>
References: <20231122140100.GT2513409@bill-the-cat>
 <CAFA6WYNoz-Pqn38FpKLj9eJxX6B019HvQoukdCma3S=+O6tOCg@mail.gmail.com>
 <20231122142758.GU2513409@bill-the-cat>
 <c47b163b-d0d9-4de6-8ea8-ebe884b28e4b@linaro.org>
 <CAFA6WYO_Dk+7FWDGjUdDub27YCwVKRjS+vZfMrT8otjvv-QO_Q@mail.gmail.com>
 <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>,
 <20231204110025.GA27965@aspen.lan>
In-Reply-To: <20231204110025.GA27965@aspen.lan>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=shokubai.tech; s=ovhex1078890-selector1; 
 c=relaxed/relaxed; t=1701700695; h=from:to:subject:date;
 bh=AfssgUtQULTRBX+Rob/NP56xthUm+DzEM3tnUg1RR4A=;
 b=TSZNeiEnX5XVjR03RvT30Pyef5oG5pFKUefhqFO9Zq49iUfUpih80ca08uBZoSrJLVY/ZD52zpnJySIyg+BbLJaygWYOgyy0DtXyeSE+Kzr/5IqIDnrALRf3fQ8OnhqsOMJCdqoQDkM+nbcc6G3HMSi92oDJqr3wd2U8WqE0mrNUbnKMFj99FNBroGnIm6NblSCUStGf+VF+rMD2VX5BwanF5BuFvuN2DnGGJJ9EeueDwPNFIm+6UCoGVK9avygXJqkpdSUpuriTz6HVi1fwSujIKsPsYHaaGYXtmKnJUx1Zw4ByLCvGhwEiu4FFNXJXOjpNHkbuydb+v7chrSf8Zg==
X-Ovh-Tracer-Id: 16453901241613663832
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejiedgieekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefuthffkfhfjggtgfggsehtsghmtddttdejnecuhfhrohhmpehffhcuoehffhesshhhohhkuhgsrghirdhtvggthheqnecuggftrfgrthhtvghrnhepgfelleekvdejtdefteettdekfeejkeegvdejtdelheeutefhffehffeggfejvedvnecukfhppeduvdejrddtrddtrddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeofhhfsehshhhokhhusggrihdrthgvtghhqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehsuhhmihhtrdhgrghrgheslhhinhgrrhhordhorhhgpdhtrhhinhhisehkohhnshhulhhkohdrtghomhdprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhiodgutheslhhinhgrrhhordhorhhgpdgtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdgtrghlvggsrdgtohhnnhholhhlhieslhhinhgrrhhordhorhhgpdhnvghilhdrrghrmhhsthhrohhngheslhhinhgrrhhordhorhhgpdhrfhhrihgvugdruggvvhesghhmrghilhdrtghomhdpughsrghnkhhouhhskhhisehgmhgrih
 hlrdgtohhmpdhpvghnghdrfhgrnhesnhigphdrtghomhdpjhhhkedtrdgthhhunhhgsehsrghmshhunhhgrdgtohhmpdhrrgihrghgohhnuggrrdhkohhkrghtrghnuhhrsegsrhhorggutghomhdrtghomhdplhhukhhmrgesuggvnhigrdguvgdpshgvrghnghgrvdesghhmrghilhdrtghomhdpjhhorhhgvgdrrhgrmhhirhgviidrohhrthhiiiesghhmrghilhdrtghomhdpshhtvghphhgrnhesghgvrhhhohhlugdrnhgvthdpmhgrrhgvgiesuggvnhigrdguvgdpuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdhsjhhgsegthhhrohhmihhumhdrohhrghdpsghoohhtqdgrrhgthhhithgvtghtuhhrvgeslhhishhtshdrlhhinhgrrhhordhorhhgpdgurghnihgvlhdrthhhohhmphhsohhnsehlihhnrghrohdrohhrghdpoffvtefjohhsthepmhhoheegiedpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Mon, 04 Dec 2023 15:39:38 +0100
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

DQoNCj4gTGUgNCBkw6ljLiAyMDIzIMOgIDEyOjAwLCBEYW5pZWwgVGhvbXBzb24gPGRhbmllbC50
aG9tcHNvbkBsaW5hcm8ub3JnPiBhIMOpY3JpdCA6DQo+IA0KPiDvu79PbiBNb24sIERlYyAwNCwg
MjAyMyBhdCAxMTowMjo1N0FNICswNTMwLCBTdW1pdCBHYXJnIHdyb3RlOg0KPj4gKyBMaW51eCBr
ZXJuZWwgRFQgYmluZGluZ3MgbWFpbnRhaW5lcnMsIEVCQlIgTUwNCj4+IA0KPj4+IE9uIFRodSwg
MzAgTm92IDIwMjMgYXQgMjA6MDUsIFRvbSBSaW5pIDx0cmluaUBrb25zdWxrby5jb20+IHdyb3Rl
Og0KPj4+IE9uIFRodSwgTm92IDMwLCAyMDIzIGF0IDAxOjAyOjI1UE0gKzA1MzAsIFN1bWl0IEdh
cmcgd3JvdGU6DQo+Pj4+IE9uIFdlZCwgMjkgTm92IDIwMjMgYXQgMjI6MDYsIE5laWwgQXJtc3Ry
b25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPiB3cm90ZToNCj4+Pj4+PiBJJ3ZlIGJlZW4g
dGhpbmtpbmcgYWJvdXQgYW5kIGhhY2tpbmcgb24gdGhpcyBmb3IgdGhlIGxhc3Qgd2VlayBvciBz
bywNCj4+Pj4+PiBzb3JyeSBmb3IgdGhlIGRlbGF5ZWQgcmVwbHkgaGVyZS4NCj4+Pj4+PiANCj4+
Pj4+PiBUaGUgdmFsdWUgaXMgaW4gcHJldmVudGluZyBhbnkgb2YgdGhlIGV4aXN0aW5nIGJpbmRp
bmdzIGZyb20gcmVncmVzc2luZywNCj4+Pj4gDQo+Pj4+IFRoYXQgaXMgYWN0dWFsbHkgYmVzdCBh
ZGRyZXNzZWQgaW4gTGludXggYnkgY2hlY2tpbmcgdGhlIERUUyBhZ2FpbnN0DQo+Pj4+IHlhbWwg
RFQgYmluZGluZ3MuIFdlIGRvbid0IGhhdmUgdGhhdCB0ZXN0aW5nIGF2YWlsYWJsZSBpbiB1LWJv
b3QgYW5kDQo+Pj4+IG9ubHkgZGVwZW5kIG9uIGNhcmVmdWwgcmV2aWV3cy4NCj4+PiANCj4+PiBJ
IHdvdWxkIGFic29sdXRlbHkgbG92ZSBmb3Igc29tZW9uZSB0byBtYWtlIGFub3RoZXIgYXR0ZW1w
dCBhdCB1cGRhdGluZw0KPj4+IG91ciBrYnVpbGQgaW5mcmFzdHVjdHVyZSBzbyB0aGF0IHdlIGNh
biBydW4gdGhlIHZhbGlkYXRpb24gdGFyZ2V0cy4NCj4+PiANCj4+IA0KPj4gR2l2ZW4gdGhhdCBF
QkJSIHJlcXVpcmVzIFsxXSB0aGUgcGxhdGZvcm0gKGZpcm13YXJlL2Jvb3Rsb2FkZXIpIGFuZA0K
Pj4gbm90IE9TIHRvIHN1cHBseSB0aGUgZGV2aWNldHJlZSwgaXQgYmVjb21lcyBldmlkZW50IHRo
YXQNCj4+IGZpcm13YXJlL2Jvb3Rsb2FkZXJzIGltcG9ydCBEVFMgZnJvbSBMaW51eCBrZXJuZWwg
KHdoZXJlIGl0IGlzDQo+PiBtYWludGFpbmVkKS4NCj4+IA0KPj4gQnV0IGN1cnJlbnRseSB1LWJv
b3QgZG9lc24ndCBoYXZlIGEgcHJvcGVyIHdheSB0byB2YWxpZGF0ZSB0aG9zZSBEVFMNCj4+IGFn
YWluc3QgRFQgYmluZGluZ3MgKG1haW50YWluZWQgaW4gTGludXgga2VybmVsKS4gQWx0aG91Z2gg
dGhlcmUgYXJlDQo+PiBEZXZpY2V0cmVlIHNjaGVtYSB0b29scyBhdmFpbGFibGUgaGVyZSBbMl0s
IHRoZXJlIGlzbid0IGEgdmVyc2lvbmVkDQo+PiByZWxlYXNlIHBhY2thZ2Ugb2YgRFQgYmluZGlu
Z3Mgd2hpY2ggb25lIHNob3VsZCB1c2UgdG8gdmFsaWRhdGUgRFRTDQo+PiBmaWxlcy4NCj4gDQo+
IFRoZSBrZXJuZWwgaXMgcmVndWxhcmx5IHJlbGVhc2VkIGluIG11bHRpcGxlIGZvcm1zIChpbmNs
dWRpbmcgZ2l0DQo+IHRhZ3MgYW5kIHRhcmJhbGwpLiBXaHkgaXNuJ3QgdGhlIGtlcm5lbCBpdHNl
bGYgc3VmZmljaWVudCB0byBiZSBhDQo+IHZlcnNpb25lZCByZWxlYXNlIG9mIHRoZSBEVCBiaW5k
aW5ncyBkaXJlY3Rvcnk/DQo+IA0KVGhlIExpbnV4IGtlcm5lbCBtYXkgbm90IHNlZSBhbGwgZGV2
aWNlcy4gRm9yIGluc3RhbmNlIGl0IGNvdWxkIHNlZSBhIFBDSSBwb3J0IHdoaWxlIHRoZSBmaXJt
d2FyZSBzZWVzIGEgU0VSREVTIHRoYXQgaXMgY29uZmlndXJlZCB0byBtYXRjaCB0aGUgYm9hcmQg
aW1wbGVtZW50YXRpb24gYW5kIHRvdXRpbmcuIFRoZSBmaXJtd2FyZSBzaGFsbCBiZSByZXNwb25z
aWJsZSB0bywgc3RhdGljYWxseSBvciBkeW5hbWljYWxseSBtYWtlIHRob3NlIHRoaW5ncyBhdmFp
bGFibGUgdG8gdGhlIGtlcm5lbC4gDQpBbiBPUyBkaXN0cmlidXRpb24gIChub3QgbmVjZXNzYXJp
bHkgTGludXgpIHNob3VsZCBub3QgZW1iZWRkZWQgYWxsIHBvc3NpYmxlIGNvbWJpbmF0aW9ucyBh
bmQga25vdyBhbGwgZGVyaXZlZCBib2FyZHMuIA0KDQoNCj4gDQo+IERhbmllbC4NCj4gX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gYm9vdC1hcmNoaXRl
Y3R1cmUgbWFpbGluZyBsaXN0IC0tIGJvb3QtYXJjaGl0ZWN0dXJlQGxpc3RzLmxpbmFyby5vcmcN
Cj4gVG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFpbCB0byBib290LWFyY2hpdGVjdHVyZS1sZWF2
ZUBsaXN0cy5saW5hcm8ub3JnDQo=
