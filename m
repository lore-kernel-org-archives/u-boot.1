Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7208CF6D2D
	for <u-boot@archiver.kernel.org>; Wed,  2 Oct 2024 15:13:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4788889111;
	Wed,  2 Oct 2024 17:13:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L5Jb69b6";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 19688891DD; Wed,  2 Oct 2024 17:13:19 +0200 (CEST)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EB38C890DB
 for <u-boot@lists.denx.de>; Wed,  2 Oct 2024 17:13:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-45834fc2345so3761601cf.0
 for <u-boot@lists.denx.de>; Wed, 02 Oct 2024 08:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727881996; x=1728486796; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZLR4BpD2kacfO9fOAdNZSI9J97TfAh6Y4sJ9qYzxtbs=;
 b=L5Jb69b66b0pR8y1DkGqa6LGiN4IvUcpXq4gAi6hMwYwgeCtjtJCOQ8DAEPToraQgk
 N+rBhixb+pX+3oPZF7GLzn4dqE1bibpE0SZ/4c34DOCWveJ37ZAW4Pn0xR+7Rh5FnEhs
 lAUTIMwtsiLo20YaMHaVw+zciQoaBXPx7kjA5yrZPCHvz+/8eRJR0cGBv6aAkt/55Snd
 2ptHtmj+YrQWh+nbmy4CE7KSfROV0oFlkw5uZORgVBQxB3M1+x3vsJgYEKY875XtkmJf
 CF5XMF8TsaM1L1RMFKWK8as8SQ90SF94mEukU8VNi3o35lErFhqybvFbJF1R56P2n2Ir
 PjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727881996; x=1728486796;
 h=content-transfer-encoding:in-reply-to:cc:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZLR4BpD2kacfO9fOAdNZSI9J97TfAh6Y4sJ9qYzxtbs=;
 b=XBEMIxcoxLvcVcATxSRoVmCxDbDTNPMSpoNywvZdZ4mPu0K+mJOzKExHtTDf8YKgXN
 p77ceq3RHbv6fLIJkCuNG2x1J19kqf/jkrQdTlYGYUHRJRIB+XkTIsX8cbX2kUm7qoJA
 OXr8ikyMr7egWQkVgSaiRu2oH6L9KP1Y7pz9YaXMO3Fhj+KdHdb0A+K796NeoWVx3SwP
 Xfg/IF3QHxd8hVAImf7xyvYbNHuBUSnghYvBK5Qg4TVFQ/moVcRnc1PNsJFEZKL1oRAV
 5Iud4rRzjN1Z5ScoRCQUNNUxYMRvcxgjk8laC4EaK2x0T8sAvHqeq+iJvD6usAoD68de
 7JJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIntW3tkrOpvY+gzA6XHbYmSq+DLcNs0GsvgSfK+EVceCENKvmZIg6m2GmXA+x5BudZ+p3wfw=@lists.denx.de
X-Gm-Message-State: AOJu0YyVMYu55kjeI1/s0sRPkp9qqQYf7AQKC6/0v7caRMxEOC30bpGr
 FhodrDmGrqK92i/nUcxMoSgHBOxBBrJglLJ+ElksP1LkKK37WyQW
X-Google-Smtp-Source: AGHT+IEtrrI5pv9qrI/5MMeXX8p7EcMAFsesrLhgJgvk5sEvF8QmrB3M+VOVnTjsjD5CFl5uQs1vgA==
X-Received: by 2002:ac8:7ec5:0:b0:45d:84d9:c322 with SMTP id
 d75a77b69052e-45d84d9c437mr11628991cf.1.1727881995593; 
 Wed, 02 Oct 2024 08:13:15 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45c9f2b6bdasm56793091cf.22.2024.10.02.08.13.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 08:13:15 -0700 (PDT)
Message-ID: <b574fe29-3e3b-df51-6b09-af06303e11ac@gmail.com>
Date: Wed, 2 Oct 2024 11:13:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 3/4] dm: core: migrate debug() messages to use dm_warn
Content-Language: en-US
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Quentin Schulz <foss+uboot@0leil.net>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de,
 Alexander Dahl <ada@thorsis.com>
References: <20240611-misc-20240610-v2-0-028e82b0b620@cherry.de>
 <20240611-misc-20240610-v2-3-028e82b0b620@cherry.de>
 <20241002-caption-saline-d00d342af087@thorsis.com>
 <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
From: Sean Anderson <seanga2@gmail.com>
Cc: Bin Meng <bmeng.cn@gmail.com>, Dario Binacchi <dariobin@libero.it>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Michal Simek <michal.simek@amd.com>
In-Reply-To: <cd12220e-a111-4576-87d1-e838f1c5998e@cherry.de>
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

T24gMTAvMi8yNCAwNToyNSwgUXVlbnRpbiBTY2h1bHogd3JvdGU6DQo+IEhpIEFsZXhhbmRl
ciwNCj4gDQo+IE9uIDEwLzIvMjQgMTA6MzcgQU0sIEFsZXhhbmRlciBEYWhsIHdyb3RlOg0K
Pj4gSGVsbG8gUXVlbnRpbiwNCj4+DQo+PiBzb3JyeSBmb3IgYmVpbmcgbGF0ZSB0byB0aGUg
cGFydHksIGJ1dCBJIGp1c3QgdGVzdGVkIHYyMDI0LjEwLXJjNiBhbmQNCj4+IG15IGNvbnNv
bGUgb3V0cHV0IGxvb2tzIGxpa2UgdGhpcyBub3c6DQo+Pg0KPj4gwqDCoMKgwqAgb2Zub2Rl
X3JlYWRfYm9vbDogYm9vdHBoLWFsbDogdHJ1ZQ0KPj4gwqDCoMKgwqAgb2Zub2RlX3JlYWRf
dTMyX2FycmF5OiByYW5nZXM6IG9mbm9kZV9yZWFkX2Jvb2w6IGJvb3RwaC1hbGw6IGZhbHNl
DQo+PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiBib290cGgtc29tZS1yYW06IGZhbHNl
DQo+PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiBib290cGgtcHJlLXJhbTogZmFsc2UN
Cj4+IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IGJvb3RwaC1wcmUtc3JhbTogZmFsc2UN
Cj4+IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IHUtYm9vdCxkbS1wcmUtcmVsb2M6IGZh
bHNlDQo+PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiB1LWJvb3QsZG0tcHJlLXByb3Bl
cjogZmFsc2UNCj4+IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IHUtYm9vdCxkbS1zcGw6
IGZhbHNlDQo+PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiB1LWJvb3QsZG0tdHBsOiBm
YWxzZQ0KPj4gwqDCoMKgwqAgb2Zub2RlX3JlYWRfYm9vbDogdS1ib290LGRtLXZwbDogZmFs
c2UNCj4+IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IGJvb3RwaC1hbGw6IGZhbHNlDQo+
PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiBib290cGgtc29tZS1yYW06IGZhbHNlDQo+
PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiBib290cGgtcHJlLXJhbTogZmFsc2UNCj4+
IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IGJvb3RwaC1wcmUtc3JhbTogZmFsc2UNCj4+
IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IHUtYm9vdCxkbS1wcmUtcmVsb2M6IGZhbHNl
DQo+PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiB1LWJvb3QsZG0tcHJlLXByb3Blcjog
ZmFsc2UNCj4+IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IHUtYm9vdCxkbS1zcGw6IGZh
bHNlDQo+PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF9ib29sOiB1LWJvb3QsZG0tdHBsOiBmYWxz
ZQ0KPj4gwqDCoMKgwqAgb2Zub2RlX3JlYWRfYm9vbDogdS1ib290LGRtLXZwbDogZmFsc2UN
Cj4+IMKgwqDCoMKgIG9mbm9kZV9yZWFkX2Jvb2w6IGJvb3RwaC1hbGw6IHRydWUNCj4+IMKg
wqDCoMKgIG9mbm9kZV9yZWFkX3UzMl9hcnJheTogcmFuZ2VzOiBvZm5vZGVfcmVhZF9ib29s
OiBib290cGgtYWxsOiB0cnVlDQo+PiDCoMKgwqDCoCBvZm5vZGVfcmVhZF91MzJfYXJyYXk6
IHJhbmdlczogb2Zub2RlX3JlYWRfYm9vbDogYm9vdHBoLWFsbDogdHJ1ZQ0KPj4gwqDCoMKg
wqAgb2Zub2RlX3JlYWRfYm9vbDogYm9vdHBoLWFsbDogdHJ1ZQ0KPj4gwqDCoMKgwqAgb2Zu
b2RlX3JlYWRfYm9vbDogYm9vdHBoLWFsbDogZmFsc2UNCj4+IMKgwqDCoMKgIOKApg0KPj4N
Cj4+IFRoaXMgZ29lcyBvbiBmb3Igc2V2ZXJhbCBzY3JlZW4gcGFnZXMsIGFuZCBjbHV0dGVy
cyB0aGUgdXN1YWwgb3V0cHV0Lg0KPj4gSSBmaXJzdCB0aG91Z2h0IEkgbWVzc2VkIHVwIENP
TkZJR19MT0dMRVZFTCBvciBDT05GSUdfTE9HLCBidXQgbm8uDQo+PiBBbGwgSSBoYWQgZG9u
ZSB3YXMgc2V0dGluZyBDT05GSUdfRE1fV0FSTiDigKYNCj4+DQo+PiBBbSBUdWUsIEp1biAx
MSwgMjAyNCBhdCAwMzowNDoyNlBNICswMjAwIHNjaHJpZWIgUXVlbnRpbiBTY2h1bHo6DQo+
Pj4gRnJvbTogUXVlbnRpbiBTY2h1bHogPHF1ZW50aW4uc2NodWx6QGNoZXJyeS5kZT4NCj4+
Pg0KPj4+IFByaW9yIHRvIHRoYXQsIHNlZWluZyB0aGUgZGVidWcoKSBtZXNzYWdlcyByZXF1
aXJlZCB0byBlbmFibGUgRE1fREVCVUcNCj4+PiB3aGljaCBkZWZpbmVzIERFQlVHIChhbmQg
dGhlbiBfREVCVUcpIHdoaWNoIGluIHR1cm4gbWFrZXMgZmFpbGluZw0KPj4+IGFzc2VydCgp
IGNhbGxzIHJlc2V0IFUtQm9vdCB3aGljaCBpc24ndCBuZWNlc3NhcmlseSB3aGF0IGlzIGRl
c2lyZWQuDQo+Pj4NCj4+PiBJbnN0ZWFkLCBsZXQncyBtaWdyYXRlIHRvIGRtX3dhcm4gd2hp
Y2ggaXMgdXNpbmcgbG9nX2RlYnVnIHdoZW4gdW5zZXQgb3INCj4+PiBsb2dfd2FybiB3aGVu
IHNldC4NCj4+Pg0KPj4+IFdoaWxlIGF0IGl0LCByZXdvcmQgdGhlIERNX0RFQlVHIHN5bWJv
bCBpbiBLY29uZmlnIHRvIGV4cGxhaW4gd2hhdCBpdA0KPj4+IG5vdyBhY3R1YWxseSBkb2Vz
Lg0KPj4NCj4+IENPTkZJR19ETV9XQVJOIGN1cnJlbnRseSByZWFkcyBsaWtlIHRoaXM6DQo+
Pg0KPj4gwqDCoMKgwqAgRW5hYmxlIHRoaXMgdG8gc2VlIHdhcm5pbmdzIHJlbGF0ZWQgdG8g
ZHJpdmVyIG1vZGVsLg0KPj4NCj4+IMKgwqDCoMKgIFdhcm5pbmdzIG1heSBoZWxwIHdpdGgg
ZGVidWdnaW5nLCBzdWNoIGFzIHdoZW4gZXhwZWN0ZWQgZGV2aWNlcyBkbw0KPj4gwqDCoMKg
wqAgbm90IGJpbmQgY29ycmVjdGx5LiBJZiB0aGUgb3B0aW9uIGlzIGRpc2FibGVkLCBkbV93
YXJuKCkgaXMgY29tcGlsZWQNCj4+IMKgwqDCoMKgIG91dCAtIGl0IHdpbGwgZG8gbm90aGlu
ZyB3aGVuIGNhbGxlZC4NCj4+DQo+PiBJbnN0ZWFkIG9mIGp1c3QgdXNlZnVsIHdhcm5pbmdz
LCB1c2VycyBnZXQgZGVidWcgbWVzc2FnZXMgYWxsIG92ZXIgdGhlDQo+PiBwbGFjZSBub3cu
wqAgSXMgdGhpcyBhY3R1YWxseSBpbnRlbmRlZCBiZWhhdmlvdXI/wqAgQ2FuIHRoaXMgYmUg
Zml4ZWQNCj4+IGJlZm9yZSB2MjAyNC4xMCByZWxlYXNlIHBsZWFzZT8NCj4+DQo+IA0KPiBU
aGVyZSBhcmUgYmFzaWNhbGx5IGxlc3MgdGhhbiAzIHdvcmtpbmcgZGF5cyBsZWZ0IGJlZm9y
ZSB2MjAyNC4xMCBpcyByZWxlYXNlZCBhbmQgSSdtIGluY2xpbmVkIHRvIHNheSB0aGlzIGlz
IGFubm95aW5nIHJhdGhlciB0aGFuIGEgYnVnLCBzbyBJIGFtIG5vdCBlbnRpcmVseSBzdXJl
IHRoaXMgd2lsbCAxKSBtYWtlIGl0IGluIHRpbWUgaWYgd2UgYWdyZWUgb24gYSBmaXggKG5l
ZWRzIHRvIGluY2x1ZGUgcmV2aWV3IHByb2Nlc3MgaW4gdGhvc2UgMyB3b3JraW5nIGRheXMp
IDIpIGJlIGFjY2VwdGFibGUgZm9yIGEgbGF0ZSBhZGRpdGlvbiBpbiB0aGUgcmVsZWFzZSBj
eWNsZS4gTGV0J3MgdHJ5IHRob3VnaCwgbWF5YmUgd2UgY2FuIGZpZ3VyZSBzb21ldGhpbmcg
b3V0Lg0KDQpUaGlzIGlzIGEgYnVnLiBQcmludGluZyB0aGlzIG1hbnkgbWVzc2FnZXMgd2ls
bCBoYXZlIGEgbWFqb3IgaW1wYWN0IG9uIGJvb3QgdGltZXMuDQoNCkEgY29uZmlnIGdvaW5n
IGZyb20gIm1heSBwcmludCBvdXQgYSBmZXcgbW9yZSBsaW5lcyBvZiBleHRyYSBpbmZvIiB0
byAiZmlyZWhvc2UiDQppcyB2ZXJ5IHN1cnByaXNpbmcgdG8gdXNlcnMgKGFzIGV2aWRlbmNl
ZCBieSBBbGV4YW5kZXIncyBlbWFpbCkuDQoNCklmIHlvdSBjYW4ndCBmaWd1cmUgb3V0IHdo
aWNoIGxpbmVzIHRvIGRpc2FibGUsIEkgcmVjb21tZW5kIHNpbXBseSByZXZlcnRpbmcgdGhl
DQpwYXRjaC4NCg0KLS1TZWFuDQo=
