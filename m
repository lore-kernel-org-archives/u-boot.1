Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60E8CC4167B
	for <u-boot@archiver.kernel.org>; Wed,  6 Dec 2023 05:08:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBB4A8744C;
	Wed,  6 Dec 2023 06:08:57 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shokubai.tech header.i=@shokubai.tech header.b="HzdJ0jx1";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1592D8788E; Tue,  5 Dec 2023 16:29:10 +0100 (CET)
Received: from 2.mo619.mail-out.ovh.net (2.mo619.mail-out.ovh.net
 [178.33.254.187])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 741BB871A6;
 Tue,  5 Dec 2023 16:29:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=shokubai.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=ff@shokubai.tech
Received: from DAG2EX1.indiv5.local (unknown [10.111.208.253])
 by mo619.mail-out.ovh.net (Postfix) with ESMTPS id 7982E22C02;
 Tue,  5 Dec 2023 15:29:04 +0000 (UTC)
Received: from DAG2EX1.indiv5.local (172.16.2.21) by DAG2EX1.indiv5.local
 (172.16.2.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 5 Dec
 2023 16:29:02 +0100
Received: from DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b]) by
 DAG2EX1.indiv5.local ([fe80::8db3:f8fe:2645:753b%6]) with mapi id
 15.01.2507.035; Tue, 5 Dec 2023 16:29:02 +0100
From: ff <ff@shokubai.tech>
To: Daniel Thompson <daniel.thompson@linaro.org>
CC: Sumit Garg <sumit.garg@linaro.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski@linaro.org>, "u-boot-custodians@lists.denx.de"
 <u-boot-custodians@lists.denx.de>, Rob Herring <robh+dt@kernel.org>, Tom Rini
 <trini@konsulko.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>,
 "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>, Ramon Fried
 <rfried.dev@gmail.com>, Dzmitry Sankouski <dsankouski@gmail.com>, Peng Fan
 <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>, "Rayagonda
 Kokatanur" <rayagonda.kokatanur@broadcom.com>, Lukasz Majewski
 <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>, Jorge Ramirez-Ortiz
 <jorge.ramirez.ortiz@gmail.com>, Stephan Gerhold <stephan@gerhold.net>,
 "Marek Vasut" <marex@denx.de>, "u-boot@lists.denx.de" <u-boot@lists.denx.de>, 
 "Simon Glass" <sjg@chromium.org>, "boot-architecture@lists.linaro.org"
 <boot-architecture@lists.linaro.org>
Subject: Re: [PATCH 00/21] Qualcomm generic board support
Thread-Topic: [PATCH 00/21] Qualcomm generic board support
Thread-Index: AQHaJnNnhdt4kVlXP0S2F0B2DoM1cbCZSWcAgADt+wCAADt7e4AADgv5gAAUIYCAACzNAA==
Date: Tue, 5 Dec 2023 15:29:02 +0000
Message-ID: <39F28900-6874-482E-B572-5F85BAB97FF0@shokubai.tech>
References: <22b2c2e2-9ce1-4a5f-8cda-565184eec120@linaro.org>
 <260c6f67-17f7-4255-b759-12fe25024673@linaro.org>
 <CAFA6WYMeg6B7Ozb42u79U43=26JmK3CaxfO29uuqQnGipFowEA@mail.gmail.com>
 <20231130143512.GQ2513409@bill-the-cat>
 <CAFA6WYMLUD9cnkr=R0Uur+1UeTMkKjM2zDdMJtXb3nmrLk+pDg@mail.gmail.com>
 <CAL_JsqL4dKbziAgwaCDz7sw-evuX7LZ3E-H6h=xQ9cXiyThY1Q@mail.gmail.com>
 <CAFA6WYPnobZ+eTGuOs+yTYNnuBu6i37Db9ZS2gr36heH1mFV5Q@mail.gmail.com>
 <f72c772b-7fd7-4558-96d3-086f8ab7515a@linaro.org>
 <CAFA6WYOPh6UBt3FDm-c0tfp3YvWtRHkaxy2CJNg8ORKOwPwq0w@mail.gmail.com>
 <7E60C667-59C9-4210-B8B8-041E00B14D1E@shokubai.tech>
 <20231205124831.GB56725@aspen.lan>
In-Reply-To: <20231205124831.GB56725@aspen.lan>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [176.145.220.134]
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; d=shokubai.tech; s=ovhex1078890-selector1; 
 c=relaxed/relaxed; t=1701790143; h=from:to:subject:date;
 bh=t3hHK4LmANQ4VnzJ9f0kKd/iS2a0GSsKSzyrmn6rI9w=;
 b=HzdJ0jx1QNVW0vnrUnS17Zl1UCpAdakMqpuOSA0jib3Vpr7zbUESZbcHcewyeKa2q0GEfCS89C8gOGjyhJ2oMvqGzRS7eeor+J1qOaoaBXohdoQJjWL7H5zbWBOXZDa2ygf7efE3Gj6BRoFUzRm0iqR04mZqD8QRiDtT9qYp9yrCrogpt0BWXarnf8cwZB8C3Ojk9pHyxHkC92E79v5eKdAxg6Ujxxp/1+zVs/1zOejuJE0hsgTxItZg2uGi9PK1YvxTU16BzuJ2xIFmAhHzSTSZQXMRMVzi3iQAJEIEaeDITrKG4nvmZqwqME5pf03S7V3FoyQraEZkOKnTLkHPKg==
X-Ovh-Tracer-Id: 4738068283800993520
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedrudejkedgjeeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvvefuthffkfhfjghitgggsegrtdhmredttdejnecuhfhrohhmpehffhcuoehffhesshhhohhkuhgsrghirdhtvggthheqnecuggftrfgrthhtvghrnhepieffgfelgeefveffveeguefhffeifeffhfejgeelheeiuedtffdufedvffeggfdtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpudejiedrudeghedrvddvtddrudefgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehffhesshhhohhkuhgsrghirdhtvggthheqpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuggrnhhivghlrdhthhhomhhpshhonheslhhinhgrrhhordhorhhgpdhsuhhmihhtrdhgrghrgheslhhinhgrrhhordhorhhgpdhkrhiihihsiihtohhfrdhkohiilhhofihskhhisehlihhnrghrohdrohhrghdpuhdqsghoohhtqdgtuhhsthhoughirghnsheslhhishhtshdruggvnhigrdguvgdprhhosghhodgutheskhgvrhhnvghlrdhorhhgpdhtrhhinhhisehkohhnshhulhhkohdrtghomhdpkhhriiihshiithhofhdrkhhoiihlohifsh
 hkihdoughtsehlihhnrghrohdrohhrghdptghonhhorhdoughtsehkvghrnhgvlhdrohhrghdptggrlhgvsgdrtghonhhnohhllhihsehlihhnrghrohdrohhrghdpnhgvihhlrdgrrhhmshhtrhhonhhgsehlihhnrghrohdrohhrghdprhhfrhhivggurdguvghvsehgmhgrihhlrdgtohhmpdgushgrnhhkohhushhkihesghhmrghilhdrtghomhdpphgvnhhgrdhfrghnsehngihprdgtohhmpdhjhhektddrtghhuhhnghesshgrmhhsuhhnghdrtghomhdprhgrhigrghhonhgurgdrkhhokhgrthgrnhhurhessghrohgruggtohhmrdgtohhmpdhluhhkmhgrseguvghngidruggvpdhsvggrnhhgrgdvsehgmhgrihhlrdgtohhmpdhjohhrghgvrdhrrghmihhrvgiirdhorhhtihiisehgmhgrihhlrdgtohhmpdhsthgvphhhrghnsehgvghrhhholhgurdhnvghtpdhmrghrvgigseguvghngidruggvpdhuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpshhjghestghhrhhomhhiuhhmrdhorhhgpdgsohhothdqrghrtghhihhtvggtthhurhgvsehlihhsthhsrdhlihhnrghrohdrohhrghdpoffvtefjohhsthepmhhoieduledpmhhouggvpehsmhhtphhouhht
X-Mailman-Approved-At: Wed, 06 Dec 2023 06:08:57 +0100
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

DQoNCkxlIDUgZMOpYy4gMjAyMyDDoCAxMzo0OCwgRGFuaWVsIFRob21wc29uIDxkYW5pZWwudGhv
bXBzb25AbGluYXJvLm9yZz4gYSDDqWNyaXQgOg0KDQpPbiBUdWUsIERlYyAwNSwgMjAyMyBhdCAx
MDozNjoyOEFNICswMDAwLCBmZiB3cm90ZToNCkxlIDUgZMOpYy4gMjAyMyDDoCAxMDo0NiwgU3Vt
aXQgR2FyZyA8c3VtaXQuZ2FyZ0BsaW5hcm8ub3JnPiBhIMOpY3JpdCA6DQoNCu+7vysgVS1ib290
IGN1c3RvZGlhbnMgbGlzdA0KDQpPbiBUdWUsIDUgRGVjIDIwMjMgYXQgMTI6NTgsIEtyenlzenRv
ZiBLb3psb3dza2kNCjxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+IHdyb3RlOg0KDQpP
biAwNS8xMi8yMDIzIDA4OjEzLCBTdW1pdCBHYXJnIHdyb3RlOg0KQERUIGJpbmRpbmdzIG1haW50
YWluZXJzLA0KDQpHaXZlbiB0aGUgZWFzZSBvZiBtYWludGVuYW5jZSBvZiBEVCBiaW5kaW5ncyB3
aXRoaW4gTGludXgga2VybmVsDQpzb3VyY2UgdHJlZSwgSSBkb24ndCBoYXZlIGEgc3BlY2lmaWMg
b2JqZWN0aW9uIHRoZXJlLiBCdXQgY2FuIHdlDQplYXNlIERUUyB0ZXN0aW5nIGZvciBmaXJtd2Fy
ZS9ib290bG9hZGVyIHByb2plY3RzIGJ5IHByb3ZpZGluZyBhDQp2ZXJzaW9uZWQgcmVsZWFzZSBw
YWNrYWdlIGZvciBEVCBiaW5kaW5ncz8gT3IgaWYgc29tZW9uZSBlbHNlDQpoYXMgYSBiZXR0ZXIg
aWRlYSBoZXJlIHBsZWFzZSBmZWVsIGZyZWUgdG8gY2hpbWUgaW4uDQoNClRoaXMgZG9lc24ndCB3
b3JrIGZvciB5b3U/Og0KDQpodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9kZXZpY2V0cmVlL2RldmljZXRyZWUtcmViYXNpbmcuZ2l0Lw0KDQpUaGFua3MsIHRo
aXMgaXMgY2VydGFpbmx5IGEgZ29vZCBzdGVwIHdoaWNoIEkgd2Fzbid0IGF3YXJlIG9mLg0KRnVy
dGhlciBzaW1wbGlmaWNhdGlvbiBjYW4gYmUgZG9uZSB0byBkZWNvdXBsZSBkZXZpY2V0cmVlIHNv
dXJjZQ0KZmlsZXMgZnJvbSBEVCBiaW5kaW5ncy4NCg0KV2h5Pw0KDQpJIHN1cHBvc2UgeW91IGFy
ZSBhbHJlYWR5IGF3YXJlIHRoYXQgTGludXggRFRTIGZpbGVzIGFyZSBhIHN1YnNldCBvZg0Kd2hh
dCBjb3VsZCBiZSBzdXBwb3J0ZWQgYnkgZGV2aWNldHJlZSBzY2hlbWFzLiBUaGVyZSBjYW4gYmUN
CmZpcm13YXJlL2Jvb3Rsb2FkZXIgc3BlY2lmaWMgcHJvcGVydGllcyAob25lIGV4YW1wbGUgYmVp
bmcgWzFdKQ0Kd2hpY2ggTGludXgga2VybmVsIGNhbiBzaW1wbHkgaWdub3JlLiBXaWxsIHlvdSBi
ZSB3aWxsaW5nIHRvIGFkZCBhbGwNCm9mIHRob3NlIERUIHByb3BlcnRpZXMgdG8gTGludXggRFRT
IGZpbGVzIGFuZCBtYWludGFpbiB0aGVtPw0KDQpBIHByZS1leGlzdGluZyBlZmZvcnQgdG8gc29s
dmUgdGhlIHNhbWUgcHJvYmxlbSBhcyBbMV0gaXMgU3lzdGVtDQpEZXZpY2UgVHJlZSwgZGlzY3Vz
c2VkIGluIHRoZSBjb250ZXh0IG9mIExpbmFybyBzdXBwb3J0ZWQgT3BlbkFNUA0KcHJvamVjdC4g
SXQgaXMgbm90IGp1c3QgYWJvdXQgY2hlcnJ5IHBpY2tpbmcgZGV2aWNlcyB0aGF0IGhhdmUNCmJp
bmRpbmdzIGluIExpbnV4IGJ1dCBhbHNvIGluZm9ybWF0aW9uIGFib3V0IGNsb2NrIGFuZCBwb3dl
ciBkb21haW5zDQpvciBkZXZpY2VzIHRoYXQgYXJlIG5vdCBzZWVuIGJ5IExpbnV4LiAgSXQgaXMg
b2J2aW91cyB0aGF0IHRoZQ0KcmVzdWx0aW5nIGJpbmRpbmdzIHNob3VsZCBiZSBtYWludGFpbmVk
IHVwc3RyZWFtIGluIHRoZSBEVCByZXBvDQpyZWdhcmRsZXNzIG9mIHRoZSBjb21tdW5pdGllcyBh
ZG9wdGVkIHNvbHV0aW9uLg0KDQpUaGlzIHNlZW1zIHRvIGJlIGFydGlmaWNpYWxseSBsaW5raW5n
IHR3byB0b3BpY3M6IHN5c3RlbSBEVCBhbmQgRFQNCnNjaGVtYSB2YWxpZGF0aW9uIHdpdGhpbiB1
LWJvb3QuIFRoZXkgYXJlIHNvbWV3aGF0IHJlbGF0ZWQgYnV0IG9uZSBvZg0Kbm90IGEgcHJlY29u
ZGl0aW9uIG9mIHRoZSBvdGhlci4NCg0KQWdyZWVkLiBJIGFtIG1lbnRpb25pbmcgdGhpcyBiZWNh
dXNlIGl0IHJlbGF0ZXMgdG8gYmluZGluZw0KYW5kIGNvbmZvcm1hbmNlIHRlc3Rpbmc6ICAgRFQg
Y29uc3VtZXJzIHN1Y2ggYXMgT1AtVEVFICwgT1NlcyBhbmQNCmh5cGVydmlzb3JzIHNob3VsZCBi
ZSBjb25zaWRlcmVkIGVxdWFsbHkgYXMgVS1Cb290IGFuZCBMaW51eC4NCkhlbmNlIGl0IG1ha2Vz
IHNlbnNlIHRoYXQgYWxsIHRob3NlIGFyZSBkZWNvdXBsZWQgZnJvbSBhbnkNCmNvbnN1bWVyIGFu
ZCBsaXZlIMKrIHN0YW5kYWxvbmUgwrsuDQoNCg0KSG93ZXZlciwgRFQgYmluZGluZ3MgYXJlIHNv
bWV0aGluZyB3aGljaCBzaG91bGQgYmUgY29tbW9uLCB0aGUNCmhhcmR3YXJlIGRlc2NyaXB0aW9u
IG9mIGEgZGV2aWNlIHNob3VsZCBiZSB1bml2ZXJzYWwuIElNTywgc3BsaXR0aW5nDQpEVCBiaW5k
aW5ncyBhbG9uZSB3b3VsZCBlYXNlIHRoZSBjb21wbGlhbmNlIHByb2Nlc3MgZm9yIHUtYm9vdA0K
ZHJpdmVycyBpbiBxdWl0ZSBzaW1pbGFyIG1hbm5lciB0byBMaW51eCBkcml2ZXJzLg0KDQpJIHJl
bWVtYmVyIGEgZGlzY3Vzc2lvbiB3aXRoIFNUIG9uIHRoYXQgdG9waWMgcmVsYXRlZCB0byBGcmFt
ZWJ1ZmZlci4NClUtQm9vdCBjYW4gbmVlZCBhIHZlcnkgZGlmZmVyZW50IHJlcHJlc2VudGF0aW9u
IG9mIHRoZSBzYW1lIGRldmljZSB0bw0KdXNlIGl0IHdoaWxlIExpbnV4IG5lZWQgYW4gaW4tZGVw
dGggZGVzY3JpcHRpb24gb2YgYWxsIHNoYWRlcnMgYW5kIMKrDQpzdHVmZiDCuyAoYW5vdGhlciBy
ZWFzb24gd2h5IFsxXSBpcyBhZGRyZXNzaW5nIG9ubHkgYSBwb3J0aW9uIG9mIHRoZQ0KcHJvYmxl
bSkgU28gZXZlbiBpZiB0aGVyZSBpcyBhIHNpbmdsZSBmcmFtZSBidWZmZXIgYmluZGluZywgdGhl
cmUNCnNob3VsZCBiZSB0d28gKGF0IGxlYXN0KSBjb25mb3JtYW5jZSB0ZXN0cy4NCg0KSSBkb24n
dCBmb2xsb3cgdGhpcywgZm9yIHR3byByZWFzb25zLg0KDQoxLiBEVCBkZXNjcmliZXMgdGhlIGhh
cmR3YXJlLCBub3QgaG93IGl0IGlzIGRyaXZlbi4gSGF2aW5nIGEgcmVsYXRpb25zaGlwDQogIGJl
dHdlZW4gdS1ib290IGFuZCBsaW51eCBEVHMgd2l0aCBkaWZmZXJlbnQgcmVwcmVzZW50YXRpb24g
d291bGQNCiAgaW1wbHkgdGhhdCB0aGUgaGFyZHdhcmUgY2hhbmdlcyBiZXR3ZWVuIHUtYm9vdCBh
bmQgdGhlIGtlcm5lbC4NCg0KMi4gRXZlbiBpZiB3ZSB3ZXJlIHRvIGFjY2VwdCB0aGF0IHRoZXJl
IG11c3QgYmUgdHdvIGRldmljZSB0cmVlIGluc3RhbmNlcw0KICAoYmV5b25kIHRyYW5zaWVudCB3
b3JrYXJvdW5kcyBmb3IgbWlzc2luZyBmZWF0dXJlcyksIHdoeSB3b3VsZCB0aGVyZQ0KICBuZWVk
IHRvIGJlIHR3byBjb25mb3JtYW5jZSB0ZXN0cyByYXRoZXIgdGhhbiBvbmUgY29uZm9ybWFuY2Ug
dGVzdCBydW4NCiAgb24gdGhlIHR3byBEVHM/DQoNCkxldOKAmXMgc2F5IFUtQm9vdCBvbmx5IGNh
cmVzIGFuZCB1c2UgbGVnYWN5IFNHVkEgZnJhbWUgYnVmZmVyLCB3aGlsZSBMaW51eA0KIGNvbW11
bml0eSBvbmx5IGNhcmVzIGFuZCB1c2UgdGhlIGZ1bGwgZmxlZGdlZCBHUFUuIFlvdSBlbmQtdXAg
d2l0aCB0d28NCmNvbW11bml0aWVzIG1haW50YWluaW5nIHRoZSBjb25mb3JtYW5jZSB0ZXN0IHBh
cnQgaXQgY2FyZXMvbmVlZC4NCklzbuKAmXQgc3BsaXR0aW5nIHRoZSB0ZXN0cyByZXNwb25zaWJp
bGl0aWVzIGEgd2F5IHRvIGdldCBwZW9wbGUgZmVlbA0KbW9yZSDCqyBlbXBvd2VyZWQgwrsgYW5k
IHRodXMgbW9yZSBhY3RpdmU/DQoNCg0KRGFuaWVsLg0KDQo=
