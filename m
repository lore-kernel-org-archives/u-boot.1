Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9368C41535
	for <u-boot@archiver.kernel.org>; Sat, 16 Dec 2023 16:56:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 38FC5876F2;
	Sat, 16 Dec 2023 17:56:16 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Tw5aDdiF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C18928770A; Sat, 16 Dec 2023 17:56:14 +0100 (CET)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9DA8E876E8
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 17:56:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-67f09756761so15548936d6.3
 for <u-boot@lists.denx.de>; Sat, 16 Dec 2023 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702745771; x=1703350571; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zrjT+mFj74wkaLA2io1e1uUkbHke3ExyOx+mylWbkNs=;
 b=Tw5aDdiF9SEM/zC4HR2CxtSybTmkEzWTwjK+Zx8nQzH/XO9JMMpDOlo48dxqUmsXKI
 Nq2NocZCWXhP9ZoJRqTdsCynPz9EJFiLUIDyLv+AIUAj2xYR5LRjdPFnnWwvYi0dLns6
 IEG2ho398PhBKcuykOsy4qUHVgLHxX1GbnketQel3mrKi19HwxTdFZw2hKu+loAQ2QZ3
 H13/JDIYua6B5tDOg9eT1p574q241ksq/zaN+WR1tKYky6ihWYrAV7JzSP/ziih5b3c1
 mjTz6xXiD52eBZJ81HbhWHUQnNxpPUTA9X+tPrrElY/6IMXVM07e1o3OYATEUcYl1in3
 7d8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702745771; x=1703350571;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zrjT+mFj74wkaLA2io1e1uUkbHke3ExyOx+mylWbkNs=;
 b=hEaG11yc8MEctAAtDnqwjaZrrmqze3J+WeYdwNXiDBz5ER14rvTK5T5dG/C2L5DGSw
 Ej5RGl21QZ3khnzF7aT3UfgPj2NNRNeLet6So1MMZEybXS2ksOmOmwFRCiN4LrsVrgUb
 nwViXxEVvS0Z/ZMgONbHtVFDINqQlqYaopk6qyHsykpGPzl5uQ5V5dREAJ6/gDUL2sD6
 mab1nSqN4tQ6O2NY46dbHMi9RAgWfOvkh4sxXzeVmXWLrddbLtMUxI0IrI8wE/nRa0JH
 hT/epmeW+0oqxlpgYNI4usmyWEJdYCsPW3m+/kGg/YR24ymDlmMX5Y9Bo+Q3NgpLCajK
 sK9w==
X-Gm-Message-State: AOJu0Yx5Eu7OkJhNZP7930HSQMRCYrkBq6IvpuDUzlPl9dCWMVO5CTKH
 RdpWa6JOIo+J4m6ZhspCeaU=
X-Google-Smtp-Source: AGHT+IG5SnjKvql5b2KkQlw9Olj7OZXO7rhGLgYP+mxnnxHUr6DGaIJr7OF4vsQfp3PLa+ZPfTXOBw==
X-Received: by 2002:a05:6214:1d29:b0:67a:a721:f31e with SMTP id
 f9-20020a0562141d2900b0067aa721f31emr19663705qvd.94.1702745771282; 
 Sat, 16 Dec 2023 08:56:11 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ec15-20020ad44e6f000000b0067f0306b4c7sm2811682qvb.105.2023.12.16.08.56.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 16 Dec 2023 08:56:10 -0800 (PST)
Message-ID: <56f7d33e-88dd-edeb-9a1e-d79fd057b380@gmail.com>
Date: Sat, 16 Dec 2023 11:56:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Marek Vasut <marex@denx.de>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
 <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <17d230d0-0118-4a22-9f75-14c5b06dd915@denx.de>
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

T24gMTIvMTYvMjMgMTE6NTIsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiAxMi8xNi8yMyAx
NjozNywgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IE9uIDEyLzE2LzIzIDAzOjQ4LCBTdnlh
dG9zbGF2IFJ5aGVsIHdyb3RlOg0KPj4+IEV4aXN0aW5nIGdwaW8tZ2F0ZS1jbG9jayBkcml2
ZXIgYWN0cyBsaWtlIGEgc2ltcGxlIEdQSU8gc3dpdGNoIHdpdGhvdXQgYW55DQo+Pj4gZWZm
ZWN0IG9uIGdhdGVkIGNsb2NrLiBBZGQgYWN0dWFsIGNsb2NrIGFjdGlvbnMgaW50byBlbmFi
bGUvZGlzYWJsZSBvcHMgYW5kDQo+Pj4gaW1wbGVtZW50IGdldF9yYXRlIG9wIGJ5IHBhc3Np
bmcgZ2F0ZWQgY2xvY2sgaWYgaXQgaXMgZW5hYmxlZC4NCj4+Pg0KPj4+IFNpZ25lZC1vZmYt
Ynk6IFN2eWF0b3NsYXYgUnloZWwgPGNsYW1vcjk1QGdtYWlsLmNvbT4NCj4+PiAtLS0NCj4+
PiDCoCBkcml2ZXJzL2Nsay9jbGstZ3Bpby5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tDQo+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDM2IGluc2Vy
dGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9jbGsvY2xrLWdwaW8uYyBiL2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMNCj4+PiBpbmRleCAy
NmQ3OTViOTc4Li43MmQ5NzQ3YTQ3IDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvY2xrL2Ns
ay1ncGlvLmMNCj4+PiArKysgYi9kcml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+Pj4gQEAgLTMs
MTkgKzMsMjMgQEANCj4+PiDCoMKgICogQ29weXJpZ2h0IChDKSAyMDIzIE1hcmVrIFZhc3V0
IDxtYXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPg0KPj4+IMKgwqAgKi8NCj4+PiAt
I2luY2x1ZGUgPGFzbS9ncGlvLmg+DQo+Pj4gLSNpbmNsdWRlIDxjb21tb24uaD4NCj4+PiAt
I2luY2x1ZGUgPGNsay11Y2xhc3MuaD4NCj4+PiArI2luY2x1ZGUgPGNsay5oPg0KPj4+IMKg
ICNpbmNsdWRlIDxkbS5oPg0KPj4+ICsjaW5jbHVkZSA8Y2xrLXVjbGFzcy5oPg0KPj4+ICsj
aW5jbHVkZSA8bGludXgvY2xrLXByb3ZpZGVyLmg+DQo+Pj4gKw0KPj4+ICsjaW5jbHVkZSA8
YXNtL2dwaW8uaD4NCj4+PiDCoCBzdHJ1Y3QgY2xrX2dwaW9fcHJpdiB7DQo+Pj4gLcKgwqDC
oCBzdHJ1Y3QgZ3Bpb19kZXNjwqDCoMKgIGVuYWJsZTsNCj4+PiArwqDCoMKgIHN0cnVjdCBn
cGlvX2Rlc2PCoMKgwqAgZW5hYmxlO8KgwqDCoCAvKiBHUElPLCBjb250cm9sbGluZyB0aGUg
Z2F0ZSAqLw0KPj4+ICvCoMKgwqAgc3RydWN0IGNsa8KgwqDCoMKgwqDCoMKgICpjbGs7wqDC
oMKgIC8qIEdhdGVkIGNsb2NrICovDQo+Pj4gwqAgfTsNCj4+PiDCoCBzdGF0aWMgaW50IGNs
a19ncGlvX2VuYWJsZShzdHJ1Y3QgY2xrICpjbGspDQo+Pj4gwqAgew0KPj4+IMKgwqDCoMKg
wqAgc3RydWN0IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYp
Ow0KPj4+ICvCoMKgwqAgY2xrX2VuYWJsZShwcml2LT5jbGspOw0KPj4+IMKgwqDCoMKgwqAg
ZG1fZ3Bpb19zZXRfdmFsdWUoJnByaXYtPmVuYWJsZSwgMSk7DQo+Pj4gwqDCoMKgwqDCoCBy
ZXR1cm4gMDsNCj4+PiBAQCAtMjYsMjEgKzMwLDQ1IEBAIHN0YXRpYyBpbnQgY2xrX2dwaW9f
ZGlzYWJsZShzdHJ1Y3QgY2xrICpjbGspDQo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgY2xrX2dw
aW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihjbGstPmRldik7DQo+Pj4gwqDCoMKgwqDC
oCBkbV9ncGlvX3NldF92YWx1ZSgmcHJpdi0+ZW5hYmxlLCAwKTsNCj4+PiArwqDCoMKgIGNs
a19kaXNhYmxlKHByaXYtPmNsayk7DQo+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+PiDC
oCB9DQo+Pj4gK3N0YXRpYyB1bG9uZyBjbGtfZ3Bpb19nZXRfcmF0ZShzdHJ1Y3QgY2xrICpj
bGspDQo+Pj4gK3sNCj4+PiArwqDCoMKgIHN0cnVjdCBjbGtfZ3Bpb19wcml2ICpwcml2ID0g
ZGV2X2dldF9wcml2KGNsay0+ZGV2KTsNCj4+PiArDQo+Pj4gK8KgwqDCoCByZXR1cm4gY2xr
X2dldF9yYXRlKHByaXYtPmNsayk7DQo+Pj4gK30NCj4+PiArDQo+Pj4gwqAgY29uc3Qgc3Ry
dWN0IGNsa19vcHMgY2xrX2dwaW9fb3BzID0gew0KPj4+IMKgwqDCoMKgwqAgLmVuYWJsZcKg
wqDCoMKgwqDCoMKgID0gY2xrX2dwaW9fZW5hYmxlLA0KPj4+IMKgwqDCoMKgwqAgLmRpc2Fi
bGXCoMKgwqAgPSBjbGtfZ3Bpb19kaXNhYmxlLA0KPj4+ICvCoMKgwqAgLmdldF9yYXRlwqDC
oMKgID0gY2xrX2dwaW9fZ2V0X3JhdGUsDQo+Pj4gwqAgfTsNCj4+PiAtc3RhdGljIGludCBj
bGtfZ3Bpb19wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPj4+ICtzdGF0aWMgaW50IGNs
a19ncGlvX29mX3RvX3BsYXQoc3RydWN0IHVkZXZpY2UgKmRldikNCj4+PiDCoCB7DQo+Pj4g
wqDCoMKgwqDCoCBzdHJ1Y3QgY2xrX2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihk
ZXYpOw0KPj4+ICvCoMKgwqAgaW50IHJldDsNCj4+PiAtwqDCoMKgIHJldHVybiBncGlvX3Jl
cXVlc3RfYnlfbmFtZShkZXYsICJlbmFibGUtZ3Bpb3MiLCAwLA0KPj4+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcHJpdi0+ZW5hYmxlLCBHUElPRF9JU19P
VVQpOw0KPj4+ICvCoMKgwqAgcHJpdi0+Y2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCk7
DQo+Pj4gK8KgwqDCoCBpZiAoSVNfRVJSKHByaXYtPmNsaykpIHsNCj4+PiArwqDCoMKgwqDC
oMKgwqAgbG9nX2RlYnVnKCIlczogQ291bGQgbm90IGdldCBnYXRlZCBjbG9jazogJWxkXG4i
LA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2Z1bmNfXywgUFRSX0VSUihw
cml2LT5jbGspKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIFBUUl9FUlIocHJpdi0+
Y2xrKTsNCj4+PiArwqDCoMKgIH0NCj4+PiArDQo+Pj4gK8KgwqDCoCByZXQgPSBncGlvX3Jl
cXVlc3RfYnlfbmFtZShkZXYsICJlbmFibGUtZ3Bpb3MiLCAwLA0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnByaXYtPmVuYWJsZSwgR1BJT0RfSVNfT1VU
KTsNCj4+PiArwqDCoMKgIGlmIChyZXQpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqAgbG9nX2Rl
YnVnKCIlczogQ291bGQgbm90IGRlY29kZSBlbmFibGUtZ3Bpb3MgKCVkKVxuIiwNCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHJldCk7DQo+Pj4gK8KgwqDC
oMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4gK8KgwqDCoCB9DQo+Pj4gKw0KPj4+ICvCoMKg
wqAgcmV0dXJuIDA7DQo+IA0KPiBBbGwgdGhpcyBmb3J3YXJkaW5nIG9mIGNsb2NrIGVuYWJs
ZS9kaXNhYmxlL2dldF9yYXRlIGZvciBwYXJlbnQgY2xvY2sgc2hvdWxkIGFscmVhZHkgYmUg
ZG9uZSBpbiBjbG9jayBjb3JlLiBJZiBpdCBpcyBub3QsIHRoZW4gaXQgc2hvdWxkIGJlIGZp
eGVkIGluIGNsb2NrIGNvcmUuDQoNCk9ubHkgQ0NGIGZvcndhcmRzIHRoaW5ncy4gSXQncyB1
cCB0byB0aGUgZHJpdmVyIHRvIGRvIGl0IGluIHRoZSBub24tQ0NGIGNhc2UuDQoNCi0tU2Vh
bg0K
