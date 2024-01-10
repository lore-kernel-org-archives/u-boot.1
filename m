Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E71FEC4707B
	for <u-boot@archiver.kernel.org>; Wed, 10 Jan 2024 15:46:05 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4A34C8777D;
	Wed, 10 Jan 2024 16:46:04 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WYHWZjWI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B16D08777D; Wed, 10 Jan 2024 16:46:03 +0100 (CET)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6B61C8785F
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 16:46:00 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-6dddba43d70so1502460a34.1
 for <u-boot@lists.denx.de>; Wed, 10 Jan 2024 07:46:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704901559; x=1705506359; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gLjy/9llej5UAU6CyOmp/3FqpTOUylynY7NQEOtNIXc=;
 b=WYHWZjWIROq5NKk3rBhBiTLbKDyrb8YCHJ79n4XF7QTPqAB+GmDIsO9euXtFTVJCAM
 0LAsa0+47WtkEYNvlVYUhYhYjrQIbPZTND9+fpKF9Bs3KHN8FUZfVk2lCsxGxmaorGPe
 fbSAoPL7svloHK90kmxycmzcTboGbuSqRErKSO8wBIagt6yv3u7cfhSI9ytuKRTuDK+s
 VFFwin26YLGuRPap24hzDht1BbuQ9jqu8fP908HTyv70V5HsiwRr1VGfTeGm/AwBkVlX
 spLcPzjWdXVDWOQrHob4kuVazxuc9wxQWXbUdgrMtMnutDckw6NIys1ki/ecLb+ceXdf
 4Pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704901559; x=1705506359;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gLjy/9llej5UAU6CyOmp/3FqpTOUylynY7NQEOtNIXc=;
 b=NHkYuGgmt03w7RgSn2GHoRqjevdrV7alsiDqQ813EuOYZLZnCQTRUPgksm9zBTcyKI
 eb+A32e1BiG2jO37UoPNTl1IrgxTO6UNUa7G1e6djADsE8sfXN5ARyZ36vS6T6Gb6wyA
 7My2OgoXq4Hn92+p3aF7Kw067kntBaXBjsIS/WbmYVu3HFnpK/2Ch5mT9ly/7XnlLZF0
 dgz56ieUcxXSx3yWADlMFy7RzUK5WKATyO+WOmcIwbE1uTAmeG0YTWA2APpj/+VhbnbN
 TU2nXpeXNJ+Wl/JnqFUc2RMDW86axpSLb749wVnOl8ARCK0DcJkmOpZgbs4hE3GXiGJk
 5Whw==
X-Gm-Message-State: AOJu0YwkLM9sY8tezA+aigOZ5EBYLtybdYS4m4uvkVinbzgGJYeLUUFc
 HQPteyPOB8qhtbpjsgZGru0zJNnfXpxSuQ==
X-Google-Smtp-Source: AGHT+IGr610LK53teN0VuLuu2V6gzwDYPwfcK7JCt6a+SxRbNyOgsQwZbPsZaSrjvLMJK+m9PlEf2g==
X-Received: by 2002:a05:6830:455:b0:6dd:dbda:539e with SMTP id
 d21-20020a056830045500b006dddbda539emr994043otc.16.1704901558881; 
 Wed, 10 Jan 2024 07:45:58 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 vq3-20020a05620a558300b0077d78c5b575sm1678442qkn.111.2024.01.10.07.45.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jan 2024 07:45:58 -0800 (PST)
Message-ID: <06ffe2bc-072a-010f-313a-80865269adcc@gmail.com>
Date: Wed, 10 Jan 2024 10:45:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: u-boot@lists.denx.de, Marek Vasut <marex@denx.de>,
 Lukasz Majewski <lukma@denx.de>
References: <20231216084838.19403-1-clamor95@gmail.com>
 <20231216084838.19403-2-clamor95@gmail.com>
 <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
In-Reply-To: <e53a31db-aea2-fe0e-daf6-f1338c59b2a8@gmail.com>
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

T24gMTIvMTYvMjMgMTA6MzcsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+IE9uIDEyLzE2LzIz
IDAzOjQ4LCBTdnlhdG9zbGF2IFJ5aGVsIHdyb3RlOg0KPj4gRXhpc3RpbmcgZ3Bpby1nYXRl
LWNsb2NrIGRyaXZlciBhY3RzIGxpa2UgYSBzaW1wbGUgR1BJTyBzd2l0Y2ggd2l0aG91dCBh
bnkNCj4+IGVmZmVjdCBvbiBnYXRlZCBjbG9jay4gQWRkIGFjdHVhbCBjbG9jayBhY3Rpb25z
IGludG8gZW5hYmxlL2Rpc2FibGUgb3BzIGFuZA0KPj4gaW1wbGVtZW50IGdldF9yYXRlIG9w
IGJ5IHBhc3NpbmcgZ2F0ZWQgY2xvY2sgaWYgaXQgaXMgZW5hYmxlZC4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTdnlhdG9zbGF2IFJ5aGVsIDxjbGFtb3I5NUBnbWFpbC5jb20+DQo+PiAt
LS0NCj4+IMKgIGRyaXZlcnMvY2xrL2Nsay1ncGlvLmMgfCA0NCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAzNiBp
bnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL2Nsay9jbGstZ3Bpby5jIGIvZHJpdmVycy9jbGsvY2xrLWdwaW8uYw0KPj4gaW5kZXgg
MjZkNzk1Yjk3OC4uNzJkOTc0N2E0NyAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvY2xrL2Ns
ay1ncGlvLmMNCj4+ICsrKyBiL2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMNCj4+IEBAIC0zLDE5
ICszLDIzIEBADQo+PiDCoMKgICogQ29weXJpZ2h0IChDKSAyMDIzIE1hcmVrIFZhc3V0IDxt
YXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPg0KPj4gwqDCoCAqLw0KPj4gLSNpbmNs
dWRlIDxhc20vZ3Bpby5oPg0KPj4gLSNpbmNsdWRlIDxjb21tb24uaD4NCj4+IC0jaW5jbHVk
ZSA8Y2xrLXVjbGFzcy5oPg0KPj4gKyNpbmNsdWRlIDxjbGsuaD4NCj4+IMKgICNpbmNsdWRl
IDxkbS5oPg0KPj4gKyNpbmNsdWRlIDxjbGstdWNsYXNzLmg+DQo+PiArI2luY2x1ZGUgPGxp
bnV4L2Nsay1wcm92aWRlci5oPg0KPj4gKw0KPj4gKyNpbmNsdWRlIDxhc20vZ3Bpby5oPg0K
Pj4gwqAgc3RydWN0IGNsa19ncGlvX3ByaXYgew0KPj4gLcKgwqDCoCBzdHJ1Y3QgZ3Bpb19k
ZXNjwqDCoMKgIGVuYWJsZTsNCj4+ICvCoMKgwqAgc3RydWN0IGdwaW9fZGVzY8KgwqDCoCBl
bmFibGU7wqDCoMKgIC8qIEdQSU8sIGNvbnRyb2xsaW5nIHRoZSBnYXRlICovDQo+PiArwqDC
oMKgIHN0cnVjdCBjbGvCoMKgwqDCoMKgwqDCoCAqY2xrO8KgwqDCoCAvKiBHYXRlZCBjbG9j
ayAqLw0KPj4gwqAgfTsNCj4+IMKgIHN0YXRpYyBpbnQgY2xrX2dwaW9fZW5hYmxlKHN0cnVj
dCBjbGsgKmNsaykNCj4+IMKgIHsNCj4+IMKgwqDCoMKgwqAgc3RydWN0IGNsa19ncGlvX3By
aXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4gK8KgwqDCoCBjbGtfZW5h
YmxlKHByaXYtPmNsayk7DQo+PiDCoMKgwqDCoMKgIGRtX2dwaW9fc2V0X3ZhbHVlKCZwcml2
LT5lbmFibGUsIDEpOw0KPj4gwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+IEBAIC0yNiwyMSAr
MzAsNDUgQEAgc3RhdGljIGludCBjbGtfZ3Bpb19kaXNhYmxlKHN0cnVjdCBjbGsgKmNsaykN
Cj4+IMKgwqDCoMKgwqAgc3RydWN0IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3By
aXYoY2xrLT5kZXYpOw0KPj4gwqDCoMKgwqDCoCBkbV9ncGlvX3NldF92YWx1ZSgmcHJpdi0+
ZW5hYmxlLCAwKTsNCj4+ICvCoMKgwqAgY2xrX2Rpc2FibGUocHJpdi0+Y2xrKTsNCj4+IMKg
wqDCoMKgwqAgcmV0dXJuIDA7DQo+PiDCoCB9DQo+PiArc3RhdGljIHVsb25nIGNsa19ncGlv
X2dldF9yYXRlKHN0cnVjdCBjbGsgKmNsaykNCj4+ICt7DQo+PiArwqDCoMKgIHN0cnVjdCBj
bGtfZ3Bpb19wcml2ICpwcml2ID0gZGV2X2dldF9wcml2KGNsay0+ZGV2KTsNCj4+ICsNCj4+
ICvCoMKgwqAgcmV0dXJuIGNsa19nZXRfcmF0ZShwcml2LT5jbGspOw0KPj4gK30NCj4+ICsN
Cj4+IMKgIGNvbnN0IHN0cnVjdCBjbGtfb3BzIGNsa19ncGlvX29wcyA9IHsNCj4+IMKgwqDC
oMKgwqAgLmVuYWJsZcKgwqDCoMKgwqDCoMKgID0gY2xrX2dwaW9fZW5hYmxlLA0KPj4gwqDC
oMKgwqDCoCAuZGlzYWJsZcKgwqDCoCA9IGNsa19ncGlvX2Rpc2FibGUsDQo+PiArwqDCoMKg
IC5nZXRfcmF0ZcKgwqDCoCA9IGNsa19ncGlvX2dldF9yYXRlLA0KPj4gwqAgfTsNCj4+IC1z
dGF0aWMgaW50IGNsa19ncGlvX3Byb2JlKHN0cnVjdCB1ZGV2aWNlICpkZXYpDQo+PiArc3Rh
dGljIGludCBjbGtfZ3Bpb19vZl90b19wbGF0KHN0cnVjdCB1ZGV2aWNlICpkZXYpDQoNClNh
bWUgY29tbWVudCBhcyB0aGUgZmlyc3QgdGltZToNCg0KV2h5IHRoZSBjb252ZXJzaW9uIGZy
b20gcHJvYmUgdG8gb2ZfdG9fcGxhdD8NCg0KLS1TZWFuDQoNCj4+IMKgIHsNCj4+IMKgwqDC
oMKgwqAgc3RydWN0IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoZGV2KTsN
Cj4+ICvCoMKgwqAgaW50IHJldDsNCj4+IC3CoMKgwqAgcmV0dXJuIGdwaW9fcmVxdWVzdF9i
eV9uYW1lKGRldiwgImVuYWJsZS1ncGlvcyIsIDAsDQo+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgJnByaXYtPmVuYWJsZSwgR1BJT0RfSVNfT1VUKTsNCj4+
ICvCoMKgwqAgcHJpdi0+Y2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCk7DQo+PiArwqDC
oMKgIGlmIChJU19FUlIocHJpdi0+Y2xrKSkgew0KPj4gK8KgwqDCoMKgwqDCoMKgIGxvZ19k
ZWJ1ZygiJXM6IENvdWxkIG5vdCBnZXQgZ2F0ZWQgY2xvY2s6ICVsZFxuIiwNCj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBfX2Z1bmNfXywgUFRSX0VSUihwcml2LT5jbGspKTsN
Cj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihwcml2LT5jbGspOw0KPj4gK8Kg
wqDCoCB9DQo+PiArDQo+PiArwqDCoMKgIHJldCA9IGdwaW9fcmVxdWVzdF9ieV9uYW1lKGRl
diwgImVuYWJsZS1ncGlvcyIsIDAsDQo+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICZwcml2LT5lbmFibGUsIEdQSU9EX0lTX09VVCk7DQo+PiArwqDCoMKgIGlm
IChyZXQpIHsNCj4+ICvCoMKgwqDCoMKgwqDCoCBsb2dfZGVidWcoIiVzOiBDb3VsZCBub3Qg
ZGVjb2RlIGVuYWJsZS1ncGlvcyAoJWQpXG4iLA0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIF9fZnVuY19fLCByZXQpOw0KPj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7
DQo+PiArwqDCoMKgIH0NCj4+ICsNCj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+PiDCoCB9DQo+
PiDCoCAvKg0KPj4gQEAgLTU5LDcgKzg3LDcgQEAgVV9CT09UX0RSSVZFUihncGlvX2dhdGVf
Y2xvY2spID0gew0KPj4gwqDCoMKgwqDCoCAubmFtZcKgwqDCoMKgwqDCoMKgID0gImdwaW9f
Y2xvY2siLA0KPj4gwqDCoMKgwqDCoCAuaWTCoMKgwqDCoMKgwqDCoCA9IFVDTEFTU19DTEss
DQo+PiDCoMKgwqDCoMKgIC5vZl9tYXRjaMKgwqDCoCA9IGNsa19ncGlvX21hdGNoLA0KPj4g
LcKgwqDCoCAucHJvYmXCoMKgwqDCoMKgwqDCoCA9IGNsa19ncGlvX3Byb2JlLA0KPj4gK8Kg
wqDCoCAub2ZfdG9fcGxhdMKgwqDCoCA9IGNsa19ncGlvX29mX3RvX3BsYXQsDQo+PiDCoMKg
wqDCoMKgIC5wcml2X2F1dG/CoMKgwqAgPSBzaXplb2Yoc3RydWN0IGNsa19ncGlvX3ByaXYp
LA0KPj4gwqDCoMKgwqDCoCAub3BzwqDCoMKgwqDCoMKgwqAgPSAmY2xrX2dwaW9fb3BzLA0K
Pj4gwqDCoMKgwqDCoCAuZmxhZ3PCoMKgwqDCoMKgwqDCoCA9IERNX0ZMQUdfUFJFX1JFTE9D
LA0KPiANCj4gK0NDIE1hcmVrDQoNCg==
