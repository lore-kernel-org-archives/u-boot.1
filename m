Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B599DE82CBB
	for <u-boot@archiver.kernel.org>; Wed, 27 Sep 2023 19:02:24 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0662869AC;
	Wed, 27 Sep 2023 21:02:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hVUEzpTd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D42F186A0A; Wed, 27 Sep 2023 21:02:20 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B02918692B
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 21:02:18 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-77575233636so115556085a.2
 for <u-boot@lists.denx.de>; Wed, 27 Sep 2023 12:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695841337; x=1696446137; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Qn6c+LodsPHEj9iofhmdpQLofqBfjKlEN9DTJlPT44A=;
 b=hVUEzpTdKt645jioE9rRqITV8PNd1KkliAHqlNe5WrS8+EPXgUKQmAobrTvw9kD68r
 XQqZdGSL4+OKjCwbEhDDRg9NFo70PUBr9DHJnTrcdctM2ajsvtLFl1/DUL7vCCZii0dQ
 y1EG3VtjvNOucbV2lb8QTl1AXOV5J/Es1LzhI3TGYoTwddOJi6igx0ty9blrx2UD2NGc
 0jmCgAH4MB0Czc9LYSfarXX0HXCBAKsZa1rggattFVkui+0lueq0QbBY64ZV+pKGrcDM
 iduc9MT8WbhILozJpPduXpb4dNaXrLksQNU+bW+Aqg9nzXkMEBJwOF0QCMnj1zktp8Xu
 rkaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695841337; x=1696446137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Qn6c+LodsPHEj9iofhmdpQLofqBfjKlEN9DTJlPT44A=;
 b=KUq63t4bt2hRsHlnjfr74bCzg0P2Usjek21mYfwT8yBjzGT5jhaY72Zf9qupCR5lMe
 KefQKcGNQi7q0PJnYc2fgv1ktoUFsphFnjvgX8I7le+4MhjChU03HOpbTXDRVLDcwi/x
 cUYoC9j7/CQHiXSEhw+0Nj/LpFAbWf0jINHwvMQYik7VS9Uz5LedkRK5yiXroWRj032x
 I4cvolDpQrrmTC/MRrMoVUIJSUa03R3lZ4/LHfgnpyo5niX8XlsM3aZqtwS5MrG13a0P
 /RXn+miW7MbhQa/ZGJdlfZk248SwppujIv5EY22YqzGyAf4ouTxGi3BJILBEpF73eml4
 WWNA==
X-Gm-Message-State: AOJu0Yy2Bq9ynBGMb6ki2i0rGPbIaylAEz3zND6Nq+EJl0Dinb5SVNM3
 gZMDdR8ND/Gn4iNOj+PviJw=
X-Google-Smtp-Source: AGHT+IEG2dPB4BnZ5JAQFcJVazKY9IAIMvdIsfT8GxNFSkBXo7cWQcg3yWuQdxucezhXDCTCMxNROw==
X-Received: by 2002:a05:620a:2491:b0:76f:27af:2798 with SMTP id
 i17-20020a05620a249100b0076f27af2798mr3622953qkn.61.1695841337415; 
 Wed, 27 Sep 2023 12:02:17 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 j28-20020a05620a147c00b007743671a41fsm2249520qkl.72.2023.09.27.12.02.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 12:02:16 -0700 (PDT)
Message-ID: <6ac71b7e-d84e-10d5-e500-0d54e5d6c191@gmail.com>
Date: Wed, 27 Sep 2023 15:02:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
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

T24gOS8xOS8yMyAwNzozNywgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4gSW4gc29tZSBj
YXNlcywgdXNpbmcgdGhlICJleHRlcm5hbCBkYXRhIiBmZWF0dXJlIGlzIGltcG9zc2libGUg
b3INCj4gdW5kZXNpcmFibGUsIGJ1dCBvbmUgbWF5IHN0aWxsIHdhbnQgKG9yIG5lZWQpIHRo
ZSBGSVQgaW1hZ2UgdG8gaGF2ZSBhDQo+IGNlcnRhaW4gYWxpZ25tZW50LiBBbHNvLCBnaXZl
biB0aGUgY3VycmVudCAnbWtpbWFnZSAtaCcgb3V0cHV0LA0KPiANCj4gICAgLUIgPT4gYWxp
Z24gc2l6ZSBpbiBoZXggZm9yIEZJVCBzdHJ1Y3R1cmUgYW5kIGhlYWRlcg0KPiANCj4gaXQg
aXMgcXVpdGUgdW5leHBlY3RlZCBmb3IgLUIgdG8gYmUgZWZmZWN0aXZlbHkgaWdub3JlZCB3
aXRob3V0IC1FLg0KDQpGV0lXLCB0aGlzIGJlaGF2aW9yIGlzIGRvY3VtZW50ZWQgaW4gZG9j
L21raW1hZ2UuMSAod2hpY2ggc2hvdWxkIGFsc28gYmUNCnVwZGF0ZWQgaWYgdGhpcyBiZWhh
dmlvciBpcyBpbXBsZW1lbnRlZCk6DQoNCnwgVGhlIGFsaWdubWVudCwgaW4gaGV4YWRlY2lt
YWwsIHRoYXQgZXh0ZXJuYWwgZGF0YSB3aWxsIGJlIGFsaWduZWQgdG8uDQp8IFRoaXMgb3B0
aW9uIG9ubHkgaGFzIGFuIGVmZmVjdCB3aGVuIC1FIGlzIHNwZWNpZmllZC4NCg0KQW5kLCBm
b3IgYWRkaXRpb25hbCBjb250ZXh0LCB0aGUgZG9jdW1lbnRhdGlvbiBmb3IgLUUgaXMNCg0K
fCBBZnRlciBwcm9jZXNzaW5nLCBtb3ZlIHRoZSBpbWFnZSBkYXRhIG91dHNpZGUgdGhlIEZJ
VCBhbmQgc3RvcmUgYSBkYXRhDQp8IG9mZnNldCBpbiB0aGUgRklULiBJbWFnZXMgd2lsbCBi
ZSBwbGFjZWQgb25lIGFmdGVyIHRoZSBvdGhlcg0KfCBpbW1lZGlhdGVseSBhZnRlciB0aGUg
RklULCB3aXRoIGVhY2ggb25lIGFsaWduZWQgdG8gYSA0LWJ5dGUgYm91bmRhcnkuDQp8IFRo
ZSBleGlzdGluZyDigJhkYXRh4oCZIHByb3BlcnR5IGluIGVhY2ggaW1hZ2Ugd2lsbCBiZSBy
ZXBsYWNlZCB3aXRoDQp8IOKAmGRhdGEtb2Zmc2V04oCZIGFuZCDigJhkYXRhLXNpemXigJkg
cHJvcGVydGllcy4gQSDigJhkYXRhLW9mZnNldOKAmSBvZiAwDQp8IGluZGljYXRlcyB0aGF0
IGl0IHN0YXJ0cyBpbiB0aGUgZmlyc3QgKDQtYnl0ZS1hbGlnbmVkKSBieXRlIGFmdGVyIHRo
ZQ0KfCBGSVQuDQoNCkJhc2VkIG9uIHRoaXMgZG9jdW1lbnRhdGlvbiBhbmQgbXkgdW5kZXJz
dGFuZGluZyBvZiB0aGUgY29kZSBhcy1pcywgLUINCmNvbnRyb2xzIHRoZSBhbGlnbm1lbnQg
b2YgdGhlIGltYWdlcyB0aGVtc2VsdmVzLCBub3QgdGhlIHNpemUgbXVsdGlwbGUNCm9mIHRo
ZSBGSVQuIEhvd2V2ZXIsIGZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0aGlzIHBhdGNoIGRvZXMg
bm90IGFjdHVhbGx5DQphZmZlY3QgdGhlIGFsaWdubWVudCBvZiB0aGUgaW1hZ2VzLCBidXQg
cmF0aGVyIGFkanVzdHMgdGhlIHNpemUgb2YgdGhlDQpvdmVyYWxsIEZJVCB0byBhIGNlcnRh
aW4gYWxpZ25tZW50LiBJIGZpbmQgdGhpcyByYXRoZXIgdW5leHBlY3RlZC4NCg0KLS1TZWFu
DQoNCj4gU2lnbmVkLW9mZi1ieTogUmFzbXVzIFZpbGxlbW9lcyA8cmFzbXVzLnZpbGxlbW9l
c0BwcmV2YXMuZGs+DQo+IC0tLQ0KPiAgIHRvb2xzL2ZpdF9pbWFnZS5jIHwgNDAgKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0MCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvdG9vbHMvZml0X2ltYWdl
LmMgYi90b29scy9maXRfaW1hZ2UuYw0KPiBpbmRleCA5ZmU2OWVhMGQ5Li4yZjViMjUwOThh
IDEwMDY0NA0KPiAtLS0gYS90b29scy9maXRfaW1hZ2UuYw0KPiArKysgYi90b29scy9maXRf
aW1hZ2UuYw0KPiBAQCAtNzEyLDYgKzcxMiw0MiBAQCBlcnI6DQo+ICAgCXJldHVybiByZXQ7
DQo+ICAgfQ0KPiAgIA0KPiArLyoqDQo+ICsgKiBmaXRfYWxpZ24oKSAtIEVuc3VyZSBGSVQg
aW1hZ2UgaGFzIGNlcnRhaW4gYWxpZ25tZW50DQo+ICsgKg0KPiArICogVGhpcyB0YWtlcyBh
IG5vcm1hbCBGSVQgZmlsZSAod2l0aCBlbWJlZGRlZCBkYXRhKSBhbmQgaW5jcmVhc2VzIGl0
cw0KPiArICogc2l6ZSBzbyB0aGF0IGl0IGlzIGEgbXVsdGlwbGUgb2YgcGFyYW1zLT5ibF9s
ZW4uDQo+ICsgKi8NCj4gK3N0YXRpYyBpbnQgZml0X2FsaWduKHN0cnVjdCBpbWFnZV90b29s
X3BhcmFtcyAqcGFyYW1zLCBjb25zdCBjaGFyICpmbmFtZSkNCj4gK3sNCj4gKwlpbnQgZml0
X3NpemUsIG5ld19zaXplOw0KPiArCWludCBmZDsNCj4gKwlzdHJ1Y3Qgc3RhdCBzYnVmOw0K
PiArCXZvaWQgKmZkdDsNCj4gKwlpbnQgcmV0ID0gMDsNCj4gKwlpbnQgYWxpZ25fc2l6ZTsN
Cj4gKw0KPiArCWFsaWduX3NpemUgPSBwYXJhbXMtPmJsX2xlbjsNCj4gKwlmZCA9IG1tYXBf
ZmR0KHBhcmFtcy0+Y21kbmFtZSwgZm5hbWUsIDAsICZmZHQsICZzYnVmLCBmYWxzZSwgZmFs
c2UpOw0KPiArCWlmIChmZCA8IDApDQo+ICsJCXJldHVybiAtRUlPOw0KPiArDQo+ICsJZml0
X3NpemUgPSBmZHRfdG90YWxzaXplKGZkdCk7DQo+ICsJbmV3X3NpemUgPSBBTElHTihmaXRf
c2l6ZSwgYWxpZ25fc2l6ZSk7DQo+ICsJZmR0X3NldF90b3RhbHNpemUoZmR0LCBuZXdfc2l6
ZSk7DQo+ICsJZGVidWcoIlNpemUgZXh0ZW5kZWQgZnJvbSBmcm9tICV4IHRvICV4XG4iLCBm
aXRfc2l6ZSwgbmV3X3NpemUpOw0KPiArCW11bm1hcChmZHQsIHNidWYuc3Rfc2l6ZSk7DQo+
ICsNCj4gKwlpZiAoZnRydW5jYXRlKGZkLCBuZXdfc2l6ZSkpIHsNCj4gKwkJZGVidWcoIiVz
OiBGYWlsZWQgdG8gdHJ1bmNhdGUgZmlsZTogJXNcbiIsIF9fZnVuY19fLA0KPiArCQkgICAg
ICBzdHJlcnJvcihlcnJubykpOw0KPiArCQlyZXQgPSAtRUlPOw0KPiArCX0NCj4gKw0KPiAr
CWNsb3NlKGZkKTsNCj4gKwlyZXR1cm4gcmV0Ow0KPiArfQ0KPiArDQo+ICAgLyoqDQo+ICAg
ICogZml0X2hhbmRsZV9maWxlIC0gbWFpbiBGSVQgZmlsZSBwcm9jZXNzaW5nIGZ1bmN0aW9u
DQo+ICAgICoNCj4gQEAgLTgxNyw2ICs4NTMsMTAgQEAgc3RhdGljIGludCBmaXRfaGFuZGxl
X2ZpbGUoc3RydWN0IGltYWdlX3Rvb2xfcGFyYW1zICpwYXJhbXMpDQo+ICAgCQlyZXQgPSBm
aXRfZXh0cmFjdF9kYXRhKHBhcmFtcywgdG1wZmlsZSk7DQo+ICAgCQlpZiAocmV0KQ0KPiAg
IAkJCWdvdG8gZXJyX3N5c3RlbTsNCj4gKwl9IGVsc2UgaWYgKHBhcmFtcy0+YmxfbGVuKSB7
DQo+ICsJCXJldCA9IGZpdF9hbGlnbihwYXJhbXMsIHRtcGZpbGUpOw0KPiArCQlpZiAocmV0
KQ0KPiArCQkJZ290byBlcnJfc3lzdGVtOw0KPiAgIAl9DQo+ICAgDQo+ICAgCWlmIChyZW5h
bWUgKHRtcGZpbGUsIHBhcmFtcy0+aW1hZ2VmaWxlKSA9PSAtMSkgew0KDQo=
