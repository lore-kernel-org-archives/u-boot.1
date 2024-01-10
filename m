Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA5AC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 15:59:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0B2C387776;
	Wed, 10 Jan 2024 16:59:00 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EOhyfdC3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0D659878B1; Wed, 10 Jan 2024 16:58:58 +0100 (CET)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D2E787776
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 16:58:55 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-783137d8049so399609885a.2
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704902334; x=1705507134; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=q3dZF8y/xm40gl67rP876cyMWl2JzdDDVKQNDfoEtII=;
 b=EOhyfdC3SGEBP41uN+aUemYUa1H4VC0vDfqrAopC3PM7ILIdIMrktfxWrmtqcDfugk
 B4DDYcXJKZqeaH5MxAYi/GU/VTHc3PbNr3EqPZIeMhXBdfXM70dN244w4Ap7UDaDr6JY
 YezwVyQ4z7FxD0XXQiGhltqUJXPCGeO+GzotkoLeJBLYqSKXgG/pziahxjDP8myPCHd+
 snT28xJzRffcz1uQts0v7A2Xa3PHarVAeJfGDao6qrG5SarM92cCswLkrj/b4r/HklxA
 gg5715G2U4PiEaNWWQ2CrClfckmpxzwZKhTPCPXkh3ahEIvTFG197xu72TASavuKbDKo
 +jcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704902334; x=1705507134;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q3dZF8y/xm40gl67rP876cyMWl2JzdDDVKQNDfoEtII=;
 b=fPwmSI6vDUEj7otW2iFg+T+88GDzduQO9MYR3Cn1YnhX32/+mLfar/7zMsE5Fp9iza
 6aMYuQ1wSWTypCKZnmI0f5YaROF7z7gRKxMOA4m4y9J1sBWTgdsOc8jZvo7WCH+6xO0b
 aG0GGRhfmzrEFD7tFoOHL1CZf4vUNq3X7BiGruFXBci3KbmEG6yatYc4AjW4FzDX3fRj
 OhV10VPaocaXUqgJ+AxNzHlE7yQCyeKZ2UmdzyeeICDvxTht/9wX+6qJEuNSBxALienq
 n4/xIBwcX0xweh050OEEPjjmY3q0t8Oy48xit3IitaA2f941nor5Pi57i/XY0rWbxv/k
 zWmg==
X-Gm-Message-State: AOJu0Yw5L1UzdS9Mijq92F+6NmxmKM1/NTHNuoWvp/ShPnSeBkynlDhi
 5zJo3+KatOtubTjn6fIiyxUSNY2kwCpYZw==
X-Google-Smtp-Source: AGHT+IHhUHxsgPMDsmPipJHruW16ltKfUUSG/cOzU4J8tS358qnxx0fQTTXt7ijomATgFxsjHU8Riw==
X-Received: by 2002:a05:620a:110a:b0:781:1d:d174 with SMTP id
 o10-20020a05620a110a00b00781001dd174mr1037152qkk.33.1704902334344; 
 Wed, 10 Jan 2024 07:58:54 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 y13-20020a05620a0e0d00b007831cca1e84sm1691883qkm.10.2024.01.10.07.58.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:58:54 -0800 (PST)
Message-ID: <eb0d81bc-a522-5856-ee2d-34017a8f5d74@gmail.com>
Date: Wed, 10 Jan 2024 10:58:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Svyatoslav <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <06ffe2bc-072a-010f-313a-80865269adcc@gmail.com>
 <348C74B3-355E-4B73-BF5A-4A7E64311779@gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <348C74B3-355E-4B73-BF5A-4A7E64311779@gmail.com>
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

T24gMS8xMC8yNCAxMDo1MywgU3Z5YXRvc2xhdiB3cm90ZToNCj4gDQo+IA0KPiAxMCDRgdGW
0YfQvdGPIDIwMjTigK/RgC4gMTc6NDU6NTcgR01UKzAyOjAwLCBTZWFuIEFuZGVyc29uIDxz
ZWFuZ2EyQGdtYWlsLmNvbT4g0L3QsNC/0LjRgdCw0LIoLdC70LApOg0KPj4gT24gMTIvMTYv
MjMgMTA6MzcsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+Pj4gT24gMTIvMTYvMjMgMDM6NDgs
IFN2eWF0b3NsYXYgUnloZWwgd3JvdGU6DQo+Pj4+IEV4aXN0aW5nIGdwaW8tZ2F0ZS1jbG9j
ayBkcml2ZXIgYWN0cyBsaWtlIGEgc2ltcGxlIEdQSU8gc3dpdGNoIHdpdGhvdXQgYW55DQo+
Pj4+IGVmZmVjdCBvbiBnYXRlZCBjbG9jay4gQWRkIGFjdHVhbCBjbG9jayBhY3Rpb25zIGlu
dG8gZW5hYmxlL2Rpc2FibGUgb3BzIGFuZA0KPj4+PiBpbXBsZW1lbnQgZ2V0X3JhdGUgb3Ag
YnkgcGFzc2luZyBnYXRlZCBjbG9jayBpZiBpdCBpcyBlbmFibGVkLg0KPj4+Pg0KPj4+PiBT
aWduZWQtb2ZmLWJ5OiBTdnlhdG9zbGF2IFJ5aGVsIDxjbGFtb3I5NUBnbWFpbC5jb20+DQo+
Pj4+IC0tLQ0KPj4+PiAgwqAgZHJpdmVycy9jbGsvY2xrLWdwaW8uYyB8IDQ0ICsrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQ0KPj4+PiAgwqAgMSBmaWxlIGNo
YW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pj4+DQo+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2Nsay9jbGstZ3Bpby5jIGIvZHJpdmVycy9jbGsvY2xrLWdw
aW8uYw0KPj4+PiBpbmRleCAyNmQ3OTViOTc4Li43MmQ5NzQ3YTQ3IDEwMDY0NA0KPj4+PiAt
LS0gYS9kcml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMvY2xrL2Ns
ay1ncGlvLmMNCj4+Pj4gQEAgLTMsMTkgKzMsMjMgQEANCj4+Pj4gIMKgwqAgKiBDb3B5cmln
aHQgKEMpIDIwMjMgTWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5v
cmc+DQo+Pj4+ICDCoMKgICovDQo+Pj4+IC0jaW5jbHVkZSA8YXNtL2dwaW8uaD4NCj4+Pj4g
LSNpbmNsdWRlIDxjb21tb24uaD4NCj4+Pj4gLSNpbmNsdWRlIDxjbGstdWNsYXNzLmg+DQo+
Pj4+ICsjaW5jbHVkZSA8Y2xrLmg+DQo+Pj4+ICDCoCAjaW5jbHVkZSA8ZG0uaD4NCj4+Pj4g
KyNpbmNsdWRlIDxjbGstdWNsYXNzLmg+DQo+Pj4+ICsjaW5jbHVkZSA8bGludXgvY2xrLXBy
b3ZpZGVyLmg+DQo+Pj4+ICsNCj4+Pj4gKyNpbmNsdWRlIDxhc20vZ3Bpby5oPg0KPj4+PiAg
wqAgc3RydWN0IGNsa19ncGlvX3ByaXYgew0KPj4+PiAtwqDCoMKgIHN0cnVjdCBncGlvX2Rl
c2PCoMKgwqAgZW5hYmxlOw0KPj4+PiArwqDCoMKgIHN0cnVjdCBncGlvX2Rlc2PCoMKgwqAg
ZW5hYmxlO8KgwqDCoCAvKiBHUElPLCBjb250cm9sbGluZyB0aGUgZ2F0ZSAqLw0KPj4+PiAr
wqDCoMKgIHN0cnVjdCBjbGvCoMKgwqDCoMKgwqDCoCAqY2xrO8KgwqDCoCAvKiBHYXRlZCBj
bG9jayAqLw0KPj4+PiAgwqAgfTsNCj4+Pj4gIMKgIHN0YXRpYyBpbnQgY2xrX2dwaW9fZW5h
YmxlKHN0cnVjdCBjbGsgKmNsaykNCj4+Pj4gIMKgIHsNCj4+Pj4gIMKgwqDCoMKgwqAgc3Ry
dWN0IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4+
PiArwqDCoMKgIGNsa19lbmFibGUocHJpdi0+Y2xrKTsNCj4+Pj4gIMKgwqDCoMKgwqAgZG1f
Z3Bpb19zZXRfdmFsdWUoJnByaXYtPmVuYWJsZSwgMSk7DQo+Pj4+ICDCoMKgwqDCoMKgIHJl
dHVybiAwOw0KPj4+PiBAQCAtMjYsMjEgKzMwLDQ1IEBAIHN0YXRpYyBpbnQgY2xrX2dwaW9f
ZGlzYWJsZShzdHJ1Y3QgY2xrICpjbGspDQo+Pj4+ICDCoMKgwqDCoMKgIHN0cnVjdCBjbGtf
Z3Bpb19wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGNsay0+ZGV2KTsNCj4+Pj4gIMKgwqDC
oMKgwqAgZG1fZ3Bpb19zZXRfdmFsdWUoJnByaXYtPmVuYWJsZSwgMCk7DQo+Pj4+ICvCoMKg
wqAgY2xrX2Rpc2FibGUocHJpdi0+Y2xrKTsNCj4+Pj4gIMKgwqDCoMKgwqAgcmV0dXJuIDA7
DQo+Pj4+ICDCoCB9DQo+Pj4+ICtzdGF0aWMgdWxvbmcgY2xrX2dwaW9fZ2V0X3JhdGUoc3Ry
dWN0IGNsayAqY2xrKQ0KPj4+PiArew0KPj4+PiArwqDCoMKgIHN0cnVjdCBjbGtfZ3Bpb19w
cml2ICpwcml2ID0gZGV2X2dldF9wcml2KGNsay0+ZGV2KTsNCj4+Pj4gKw0KPj4+PiArwqDC
oMKgIHJldHVybiBjbGtfZ2V0X3JhdGUocHJpdi0+Y2xrKTsNCj4+Pj4gK30NCj4+Pj4gKw0K
Pj4+PiAgwqAgY29uc3Qgc3RydWN0IGNsa19vcHMgY2xrX2dwaW9fb3BzID0gew0KPj4+PiAg
wqDCoMKgwqDCoCAuZW5hYmxlwqDCoMKgwqDCoMKgwqAgPSBjbGtfZ3Bpb19lbmFibGUsDQo+
Pj4+ICDCoMKgwqDCoMKgIC5kaXNhYmxlwqDCoMKgID0gY2xrX2dwaW9fZGlzYWJsZSwNCj4+
Pj4gK8KgwqDCoCAuZ2V0X3JhdGXCoMKgwqAgPSBjbGtfZ3Bpb19nZXRfcmF0ZSwNCj4+Pj4g
IMKgIH07DQo+Pj4+IC1zdGF0aWMgaW50IGNsa19ncGlvX3Byb2JlKHN0cnVjdCB1ZGV2aWNl
ICpkZXYpDQo+Pj4+ICtzdGF0aWMgaW50IGNsa19ncGlvX29mX3RvX3BsYXQoc3RydWN0IHVk
ZXZpY2UgKmRldikNCj4+DQo+PiBTYW1lIGNvbW1lbnQgYXMgdGhlIGZpcnN0IHRpbWU6DQo+
Pg0KPj4gV2h5IHRoZSBjb252ZXJzaW9uIGZyb20gcHJvYmUgdG8gb2ZfdG9fcGxhdD8NCj4+
DQo+IA0KPiBTYW1lIGFuc3dlciBhcyB0aGUgZmlyc3QgdGltZS4NCg0KTGFzdCB0aW1lIHlv
dSBzYWlkDQoNCj4+Pg0KPj4+IC1zdGF0aWMgaW50IGNsa19ncGlvX3Byb2JlKHN0cnVjdCB1
ZGV2aWNlICpkZXYpDQo+Pj4gK3N0YXRpYyBpbnQgY2xrX2dwaW9fb2ZfdG9fcGxhdChzdHJ1
Y3QgdWRldmljZSAqZGV2KQ0KPj4NCj4+IFRoaXMgY2hhbmdlIHNob3VsZCBiZSBhIHNlcGFy
YXRlIGNvbW1pdC4NCj4+DQo+IFRoaXMgYWN0dWFsbHkgc2hvdWxkIG5vdCBiZSBhY2NlcHRl
ZCBmaXJzdCBwbGFjZQ0KPiANCj4gLm9mX3RvX3BsYXQgLSBjb252ZXJ0IGRldmljZSB0cmVl
IGRhdGEgdG8gcGxhdA0KPiAucHJvYmUgLSBtYWtlIGEgZGV2aWNlIHJlYWR5IGZvciB1c2UN
Cj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNvbS91LWJvb3QvdS1ib290L2Jsb2IvbWFzdGVyL2Rv
Yy9kZXZlbG9wL2RyaXZlci1tb2RlbC9kZXNpZ24ucnN0DQo+IA0KDQphbmQgSSB0aG91Z2h0
ICJUaGlzIGFjdHVhbGx5IHNob3VsZCBub3QgYmUgYWNjZXB0ZWQgZmlyc3QgcGxhY2UiIHdh
cyByZWZlcnJpbmcgdG8NCnRoZSBjb252ZXJzaW9uIChpLmUuIHRoYXQgeW91IHdvdWxkIGJl
IHJlbW92aW5nIGl0IG5leHQgdGltZSkuDQoNClRoaXMgc29ydCBvZiBjb252ZXJzaW9uIHNo
b3VsZCBiZSBtZW50aW9uZWQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0KDQpBbmQgdGhlIHdl
aXJkIHRoaW5nIHRvIG1lIGlzIHRoYXQgSSB3b3VsZCBleHBlY3Qgb2ZfdG9fcGxhdCB0byBm
aWxsIGluIGEgcGxhdGRhdGENCnN0cnVjdC4gSWYgeW91IGFyZSBub3QgZG9pbmcgdGhhdCwg
d2h5IHVzZSB0aGlzIGZ1bmN0aW9uPw0KDQo+IFlvdSBwcm9wb3NlIHRvIHNwYW0gY29tbWl0
cyBmb3IgdGhpcyBzbWFsbCBhZGp1c3RtZW50Pw0KDQpZZXMuIE9uZSBjaGFuZ2UgcGVyIGNv
bW1pdC4NCg0KLS1TZWFuDQo=
