Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA724C3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 17:02:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A698687CD0;
	Sun, 17 Dec 2023 18:02:01 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KHuif2n+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA01287CDD; Sun, 17 Dec 2023 18:01:59 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8503587CC1
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 18:01:57 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67ab5e015aaso20882186d6.0
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 09:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702832516; x=1703437316; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GU5cU9T15WpvqHHloIYQftj2LfhS8qbDE8gEJyhw8wY=;
 b=KHuif2n+fDccBwyHpBxa8jpBiq79aNWvjB0nYKmZODTs+eUUHV6QsH8xoz2y2DubOz
 o+ULdmNSCJUQD+2lvA1nWtwtZ4NND0ZHVoEItzBCedEiR2TVkJFioSaTskDnvId0IDah
 m0rL+97tQYV9E/DnxqGoeexpxQhlOi/mf1q2lSoEXaUN3EoTRMOSQ+VCuBuedg3gfqpB
 tyQXVIiett6hJ9/51RHynJTnDC8uBQZTOj6LXt8vrJMTb8xj5Asx0SxMEDYD6YAwz3oS
 f7B5RCcLpbm8dQ9mO10P5IbuQGer8v8m1bmftp7zVFaSVG7UkthkYRiHSM1L+FweQLhU
 25Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702832516; x=1703437316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GU5cU9T15WpvqHHloIYQftj2LfhS8qbDE8gEJyhw8wY=;
 b=f1R+x6nx+xCFqBuP8Ivcex2sHQhltA1zxo0cVTSnCcdcVVi0naQR+1Dk1oC/72EvgJ
 vPXsgMrIFPNu4fWccMBwmN6uYBPyDJ1v4slGfUw1j2oIK+STuTarTGc7e0N2g34lKLFw
 /4vJZjjDkQgckGkRBoUJlZHvCRtRYrRLjfLJkrkvMHcMMyBqwlqmSs6/UjKNJE2aVjWf
 YZNZzxM9yeWFm7L0uTlXflJBUcO4i/qky3eeVNYqfx5nEavjZZrilXqSX6ll6Qvnh39y
 X14TpIg+IwGjKgXCMedPORYWUKAULBCir5ZQMQDJ5ljso7+GRdHoiKiHdoJUsJN9hLxF
 dLeQ==
X-Gm-Message-State: AOJu0YxVlZ2Dk8zJmUIDzLoless4rHacPprz13uq+mQb1lJwpctHclio
 40OSUPyZROtKxlKTkvmDjUUqa8FBqaodWA==
X-Google-Smtp-Source: AGHT+IE4ejZ8R3IA7NRMddNdXcjbgKSEdoBe7+83ftlVxa5S/usXt0zD4yoaw8hjYJP5mdMhMSTPfg==
X-Received: by 2002:a05:6214:1191:b0:67e:ee32:3320 with SMTP id
 t17-20020a056214119100b0067eee323320mr10666409qvv.32.1702832515811; 
 Sun, 17 Dec 2023 09:01:55 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 c16-20020a0ceb50000000b0067efe4f3cd1sm3909669qvq.75.2023.12.17.09.01.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 09:01:55 -0800 (PST)
Message-ID: <5fdcf933-902e-e613-356c-02c4f99beb32@gmail.com>
Date: Sun, 17 Dec 2023 12:01:54 -0500
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
 <56f7d33e-88dd-edeb-9a1e-d79fd057b380@gmail.com>
 <ed3eb880-c0a5-4060-9727-18ffce40fc46@denx.de>
 <f401f7ca-1075-3ad8-6c8a-eb0ca98229d2@gmail.com>
 <fb30f55f-90da-46e4-bd83-c1107faa2454@denx.de>
 <50cf8ef8-e81a-f517-2e6c-14399fb28a93@gmail.com>
 <5982db9e-3264-47ac-baf8-9b019a976a05@denx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <5982db9e-3264-47ac-baf8-9b019a976a05@denx.de>
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

T24gMTIvMTcvMjMgMTE6NDUsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPiBPbiAxMi8xNy8yMyAx
NjozNywgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IE9uIDEyLzE3LzIzIDEwOjE5LCBNYXJl
ayBWYXN1dCB3cm90ZToNCj4+PiBPbiAxMi8xNy8yMyAwMjoyMCwgU2VhbiBBbmRlcnNvbiB3
cm90ZToNCj4+Pj4gT24gMTIvMTYvMjMgMTk6MTksIE1hcmVrIFZhc3V0IHdyb3RlOg0KPj4+
Pj4gT24gMTIvMTYvMjMgMTc6NTYsIFNlYW4gQW5kZXJzb24gd3JvdGU6DQo+Pj4+Pj4gT24g
MTIvMTYvMjMgMTE6NTIsIE1hcmVrIFZhc3V0IHdyb3RlOg0KPj4+Pj4+PiBPbiAxMi8xNi8y
MyAxNjozNywgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+Pj4+Pj4+IE9uIDEyLzE2LzIzIDAz
OjQ4LCBTdnlhdG9zbGF2IFJ5aGVsIHdyb3RlOg0KPj4+Pj4+Pj4+IEV4aXN0aW5nIGdwaW8t
Z2F0ZS1jbG9jayBkcml2ZXIgYWN0cyBsaWtlIGEgc2ltcGxlIEdQSU8gc3dpdGNoIHdpdGhv
dXQgYW55DQo+Pj4+Pj4+Pj4gZWZmZWN0IG9uIGdhdGVkIGNsb2NrLiBBZGQgYWN0dWFsIGNs
b2NrIGFjdGlvbnMgaW50byBlbmFibGUvZGlzYWJsZSBvcHMgYW5kDQo+Pj4+Pj4+Pj4gaW1w
bGVtZW50IGdldF9yYXRlIG9wIGJ5IHBhc3NpbmcgZ2F0ZWQgY2xvY2sgaWYgaXQgaXMgZW5h
YmxlZC4NCj4+Pj4+Pj4+Pg0KPj4+Pj4+Pj4+IFNpZ25lZC1vZmYtYnk6IFN2eWF0b3NsYXYg
UnloZWwgPGNsYW1vcjk1QGdtYWlsLmNvbT4NCj4+Pj4+Pj4+PiAtLS0NCj4+Pj4+Pj4+PiDC
oCBkcml2ZXJzL2Nsay9jbGstZ3Bpby5jIHwgNDQgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tDQo+Pj4+Pj4+Pj4gwqAgMSBmaWxlIGNoYW5nZWQsIDM2IGlu
c2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+Pj4+Pj4+Pj4NCj4+Pj4+Pj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLWdwaW8uYyBiL2RyaXZlcnMvY2xrL2Nsay1ncGlv
LmMNCj4+Pj4+Pj4+PiBpbmRleCAyNmQ3OTViOTc4Li43MmQ5NzQ3YTQ3IDEwMDY0NA0KPj4+
Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvY2xrL2Nsay1ncGlvLmMNCj4+Pj4+Pj4+PiArKysgYi9k
cml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+Pj4+Pj4+Pj4gQEAgLTMsMTkgKzMsMjMgQEANCj4+
Pj4+Pj4+PiDCoMKgICogQ29weXJpZ2h0IChDKSAyMDIzIE1hcmVrIFZhc3V0IDxtYXJlay52
YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPg0KPj4+Pj4+Pj4+IMKgwqAgKi8NCj4+Pj4+Pj4+
PiAtI2luY2x1ZGUgPGFzbS9ncGlvLmg+DQo+Pj4+Pj4+Pj4gLSNpbmNsdWRlIDxjb21tb24u
aD4NCj4+Pj4+Pj4+PiAtI2luY2x1ZGUgPGNsay11Y2xhc3MuaD4NCj4+Pj4+Pj4+PiArI2lu
Y2x1ZGUgPGNsay5oPg0KPj4+Pj4+Pj4+IMKgICNpbmNsdWRlIDxkbS5oPg0KPj4+Pj4+Pj4+
ICsjaW5jbHVkZSA8Y2xrLXVjbGFzcy5oPg0KPj4+Pj4+Pj4+ICsjaW5jbHVkZSA8bGludXgv
Y2xrLXByb3ZpZGVyLmg+DQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICsjaW5jbHVkZSA8YXNt
L2dwaW8uaD4NCj4+Pj4+Pj4+PiDCoCBzdHJ1Y3QgY2xrX2dwaW9fcHJpdiB7DQo+Pj4+Pj4+
Pj4gLcKgwqDCoCBzdHJ1Y3QgZ3Bpb19kZXNjwqDCoMKgIGVuYWJsZTsNCj4+Pj4+Pj4+PiAr
wqDCoMKgIHN0cnVjdCBncGlvX2Rlc2PCoMKgwqAgZW5hYmxlO8KgwqDCoCAvKiBHUElPLCBj
b250cm9sbGluZyB0aGUgZ2F0ZSAqLw0KPj4+Pj4+Pj4+ICvCoMKgwqAgc3RydWN0IGNsa8Kg
wqDCoMKgwqDCoMKgICpjbGs7wqDCoMKgIC8qIEdhdGVkIGNsb2NrICovDQo+Pj4+Pj4+Pj4g
wqAgfTsNCj4+Pj4+Pj4+PiDCoCBzdGF0aWMgaW50IGNsa19ncGlvX2VuYWJsZShzdHJ1Y3Qg
Y2xrICpjbGspDQo+Pj4+Pj4+Pj4gwqAgew0KPj4+Pj4+Pj4+IMKgwqDCoMKgwqAgc3RydWN0
IGNsa19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4+Pj4+
Pj4+ICvCoMKgwqAgY2xrX2VuYWJsZShwcml2LT5jbGspOw0KPj4+Pj4+Pj4+IMKgwqDCoMKg
wqAgZG1fZ3Bpb19zZXRfdmFsdWUoJnByaXYtPmVuYWJsZSwgMSk7DQo+Pj4+Pj4+Pj4gwqDC
oMKgwqDCoCByZXR1cm4gMDsNCj4+Pj4+Pj4+PiBAQCAtMjYsMjEgKzMwLDQ1IEBAIHN0YXRp
YyBpbnQgY2xrX2dwaW9fZGlzYWJsZShzdHJ1Y3QgY2xrICpjbGspDQo+Pj4+Pj4+Pj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgY2xrX2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihjbGst
PmRldik7DQo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCBkbV9ncGlvX3NldF92YWx1ZSgmcHJpdi0+
ZW5hYmxlLCAwKTsNCj4+Pj4+Pj4+PiArwqDCoMKgIGNsa19kaXNhYmxlKHByaXYtPmNsayk7
DQo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCByZXR1cm4gMDsNCj4+Pj4+Pj4+PiDCoCB9DQo+Pj4+
Pj4+Pj4gK3N0YXRpYyB1bG9uZyBjbGtfZ3Bpb19nZXRfcmF0ZShzdHJ1Y3QgY2xrICpjbGsp
DQo+Pj4+Pj4+Pj4gK3sNCj4+Pj4+Pj4+PiArwqDCoMKgIHN0cnVjdCBjbGtfZ3Bpb19wcml2
ICpwcml2ID0gZGV2X2dldF9wcml2KGNsay0+ZGV2KTsNCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+
Pj4gK8KgwqDCoCByZXR1cm4gY2xrX2dldF9yYXRlKHByaXYtPmNsayk7DQo+Pj4+Pj4+Pj4g
K30NCj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gwqAgY29uc3Qgc3RydWN0IGNsa19vcHMgY2xr
X2dwaW9fb3BzID0gew0KPj4+Pj4+Pj4+IMKgwqDCoMKgwqAgLmVuYWJsZcKgwqDCoMKgwqDC
oMKgID0gY2xrX2dwaW9fZW5hYmxlLA0KPj4+Pj4+Pj4+IMKgwqDCoMKgwqAgLmRpc2FibGXC
oMKgwqAgPSBjbGtfZ3Bpb19kaXNhYmxlLA0KPj4+Pj4+Pj4+ICvCoMKgwqAgLmdldF9yYXRl
wqDCoMKgID0gY2xrX2dwaW9fZ2V0X3JhdGUsDQo+Pj4+Pj4+Pj4gwqAgfTsNCj4+Pj4+Pj4+
PiAtc3RhdGljIGludCBjbGtfZ3Bpb19wcm9iZShzdHJ1Y3QgdWRldmljZSAqZGV2KQ0KPj4+
Pj4+Pj4+ICtzdGF0aWMgaW50IGNsa19ncGlvX29mX3RvX3BsYXQoc3RydWN0IHVkZXZpY2Ug
KmRldikNCj4+Pj4+Pj4+PiDCoCB7DQo+Pj4+Pj4+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgY2xr
X2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihkZXYpOw0KPj4+Pj4+Pj4+ICvCoMKg
wqAgaW50IHJldDsNCj4+Pj4+Pj4+PiAtwqDCoMKgIHJldHVybiBncGlvX3JlcXVlc3RfYnlf
bmFtZShkZXYsICJlbmFibGUtZ3Bpb3MiLCAwLA0KPj4+Pj4+Pj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAmcHJpdi0+ZW5hYmxlLCBHUElPRF9JU19PVVQp
Ow0KPj4+Pj4+Pj4+ICvCoMKgwqAgcHJpdi0+Y2xrID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVM
TCk7DQo+Pj4+Pj4+Pj4gK8KgwqDCoCBpZiAoSVNfRVJSKHByaXYtPmNsaykpIHsNCj4+Pj4+
Pj4+PiArwqDCoMKgwqDCoMKgwqAgbG9nX2RlYnVnKCIlczogQ291bGQgbm90IGdldCBnYXRl
ZCBjbG9jazogJWxkXG4iLA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBfX2Z1bmNfXywgUFRSX0VSUihwcml2LT5jbGspKTsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDC
oMKgwqAgcmV0dXJuIFBUUl9FUlIocHJpdi0+Y2xrKTsNCj4+Pj4+Pj4+PiArwqDCoMKgIH0N
Cj4+Pj4+Pj4+PiArDQo+Pj4+Pj4+Pj4gK8KgwqDCoCByZXQgPSBncGlvX3JlcXVlc3RfYnlf
bmFtZShkZXYsICJlbmFibGUtZ3Bpb3MiLCAwLA0KPj4+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgJnByaXYtPmVuYWJsZSwgR1BJT0RfSVNfT1VUKTsN
Cj4+Pj4+Pj4+PiArwqDCoMKgIGlmIChyZXQpIHsNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKg
wqAgbG9nX2RlYnVnKCIlczogQ291bGQgbm90IGRlY29kZSBlbmFibGUtZ3Bpb3MgKCVkKVxu
IiwNCj4+Pj4+Pj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19mdW5jX18sIHJl
dCk7DQo+Pj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4+Pj4+Pj4g
K8KgwqDCoCB9DQo+Pj4+Pj4+Pj4gKw0KPj4+Pj4+Pj4+ICvCoMKgwqAgcmV0dXJuIDA7DQo+
Pj4+Pj4+DQo+Pj4+Pj4+IEFsbCB0aGlzIGZvcndhcmRpbmcgb2YgY2xvY2sgZW5hYmxlL2Rp
c2FibGUvZ2V0X3JhdGUgZm9yIHBhcmVudCBjbG9jayBzaG91bGQgYWxyZWFkeSBiZSBkb25l
IGluIGNsb2NrIGNvcmUuIElmIGl0IGlzIG5vdCwgdGhlbiBpdCBzaG91bGQgYmUgZml4ZWQg
aW4gY2xvY2sgY29yZS4NCj4+Pj4+Pg0KPj4+Pj4+IE9ubHkgQ0NGIGZvcndhcmRzIHRoaW5n
cy4gSXQncyB1cCB0byB0aGUgZHJpdmVyIHRvIGRvIGl0IGluIHRoZSBub24tQ0NGIGNhc2Uu
DQo+Pj4+Pg0KPj4+Pj4gU2hhbGwgd2UgYWRkIGRlcGVuZGVuY3kgb24gQ0NGIGluc3RlYWQg
b2YgZHVwbGljYXRpbmcgY29kZSBpbiBkcml2ZXJzID8NCj4+Pj4NCj4+Pj4gSSdkIHJhdGhl
ciBub3QuIFRoaXMgd2lsbCBiZSB1c2VmdWwgb24gbm9uLUNDRiBzeXN0ZW1zLg0KPj4+DQo+
Pj4gVGhlbiB0aGUgZm9yd2FyZGluZyBmdW5jdGlvbmFsaXR5IHNob3VsZCBiZSBpbiB0aGUg
Y2xvY2sgY29yZSwgYmFzaWNhbGx5IGlmIGEgZHJpdmVyIGRvZXMgbm90IGltcGxlbWVudCBj
YWxsYmFjayA8c29tZXRoaW5nPiwgY2FsbCBwYXJlbnQgY2xvY2sgY2FsbGJhY2sgPHNvbWV0
aGluZz4sIGFuZCByZXBlYXQgdW50aWwgeW91IHJlYWNoIHRoZSB0b3Agb2YgdGhlIGNsb2Nr
IHRyZWUuIElmIHlvdSBkbyByZWFjaCB0aGUgdG9wLCBmYWlsIHdpdGggc29tZSBlcnJvciBj
b2RlLiBJc24ndCB0aGF0IGhvdyBjbG9jayBlbmFibGUgYWxyZWFkeSB3b3JrcyBhbnl3YXkg
Pw0KPj4NCj4+IE5vLiBJbiB0aGUgbm9uLUNDRiBjYXNlLCB3ZSBoYXZlIG5vIGlkZWEgd2hh
dCB0aGUgcGFyZW50IG9mIGFueSBnaXZlbiBjbG9jayBpcy4gU28NCj4+IHRoZXJlJ3Mgbm8g
ZnJhbWV3b3JrIHdlIGNhbiBwcm92aWRlLg0KPiANCj4gSHVoLCBidXQgdGhpcyBkcml2ZXIg
aXMgYXR0ZW1wdGluZyB0byBncmFiIHNvbWUgc29ydCBvZiBwYXJlbnQgY2xvY2sgYW5kIGVu
YWJsZSB0aGVtLCBzbyBob3cgZG9lcyB0aGF0IHdvcmsgPw0KDQpUaGUgZHJpdmVyIGtub3dz
IHdoYXQgaXRzIHBhcmVudCBpcywgc28gaXQgY2FuIGVuYWJsZSBpdCBqdXN0IGZpbmUuDQoN
Cj4+IE5vdywgeW91IG1pZ2h0IHNheSAid2h5IG5vdCBhZGQgYSBnZXRfcGFyZW50IG9wPyIg
V2VsbCwgdGhhdCB3aWxsIHdvcmsgZmluZSBmb3INCj4+IGVuYWJsaW5nIHRoaW5ncywgYnV0
IGl0IGlzIGEgYml0IGhhaXJ5IG9uIHRoZSBkaXNhYmxlIHNpZGUuIFlvdSByZWFsbHkgbmVl
ZCB0byBoYXZlDQo+PiByZWZjb3VudGluZyB0byBwcm90ZWN0IHBhcmVudCBjbG9ja3MgKHdo
aWNoIGNhbiBoYXZlIG1hbnkgY2hpbGRyZW4pLiBCdXQgd2UgZG9uJ3QNCj4+IHJlYWxseSBo
YXZlIGFueXdoZXJlIHRvIHN0b3JlIHJlZmNvdW50cy4gc3RydWN0IGNsayBoYXMgYSBtZW1i
ZXIgZm9yIGl0LCBidXQgdGhhdCdzDQo+PiBvbmx5IGJlY2F1c2UgaXQncyBhYnVzZWQgYXMg
cHJpdmF0ZSBkYXRhIGJ5IENDRi4gTm9uLUNDRiBjbG9ja3MgaGF2ZSBubyBjbG9jaw0KPj4g
c3Vic3lzdGVtIGRhdGEgYWxsb2NhdGVkIGF0IGFsbC4gQW5vdGhlciBhbHRlcm5hdGl2ZSBp
cyB0byBqdXN0IG9ubHkgZGlzYWJsZSB0aGUgbGVhZg0KPj4gbm9kZSwgd2hpY2ggaXMgd2hh
dCB3ZSBjdXJyZW50bHkgZG8uIFRoYXQncyBPSyBJIHRoaW5rLg0KPj4NCj4+IEJ1dCB0aGF0
IHNvbHV0aW9uIHJlcXVpcmVzIHNvbWUgbW9yZS1pbnRlbnNpdmUgZWZmb3J0IHdoaWNoIEkg
ZG9uJ3Qgd2FudCB0byBpbXBvc2Ugb24NCj4+IHJhbmRvbSBjb250cmlidXRvcnMuIFNvIGZv
ciB0aGUgdGltZSBiZWluZywgYWxsIG5vbi1DQ0YgY2xvY2sgZHJpdmVycyBtdXN0IGhhbmRs
ZQ0KPj4gZW5hYmxpbmcgdGhlaXIgb3duIHBhcmVudCBjbG9ja3MuDQo+IA0KPiBTbywgaW4g
bGlnaHQgb2YgdGhpcywgd2h5IG5vdCBwdXNoIGZvciB1c2Ugb2YgQ0NGIGFzIG11Y2ggYXMg
cG9zc2libGUgYW5kIGRlcHJlY2F0ZSB0aGUgY3VycmVudCBub24tQ0NGIGNsb2NrIHN1cHBv
cnQgPyBJdCBzZWVtcyBsaWtlIHRoZSByaWdodCB0aGluZyB0byBkbywgYW5kIGF2b2lkcyBn
cm93aW5nIGFkLWhvYyB3b3JrYXJvdW5kcyBmb3IgbWlzc2luZyBjb3JlIGZ1bmN0aW9uYWxp
dHkgaW4gZHJpdmVycywgd2hpY2ggSSByZWFsbHkgd2FudCB0byBhdm9pZCAuDQoNCkJlY2F1
c2UgdGhlIENDRiBmcmFtZXdvcmsgYWJ1c2VzIHN0cnVjdCBjbGsgZm9yIHByaXZhdGUgZGF0
YSwgdXNlcyBzdHJpbmdzIGV2ZXJ5d2hlcmUsIGFuZA0KZHluYW1pY2FsbHkgYWxsb2NhdGVz
IGFsbCBpdHMgY2xvY2tzICh3aGljaCBhcmUga25vd24gYXQgY29tcGlsZS10aW1lKS4gWW91
IGNhbiBlYXNpbHkgc2F2ZQ0KNEsgKG9yIG1vcmUpIGJ5IG1vdmluZyBhd2F5IGZyb20gQ0NG
LCB3aGljaCBjYW4gYmUgZXNwZWNpYWxseSBpbXBvcnRhbnQgaW4gU1BMLiBJdCdzIGENCm5l
Y2Vzc2FyeSBldmlsIGJlY2F1c2UgcGVvcGxlIHdhbnQgdG8gY29weSB0aGVpciBjbG9jayBk
cml2ZXJzIHN0cmFpZ2h0IGZyb20gTGludXgsIGJ1dCBJTU8NCml0IGlzIGEgc3RlcCBpbiB0
aGUgd3JvbmcgZGlyZWN0aW9uIHJpZ2h0IG5vdy4gRXNwZWNpYWxseSBkdWUgdG8gdGhlIGR5
bmFtaWMgYWxsb2NhdGlvbiBhbmQNCnN0cmluZ3MgSSB0aGluayBpdCBpcyBub3QgZml4YWJs
ZSBpbiB0aGUgZ2VuZXJhbCBzZW5zZS4gQnV0IHRoZSAiY29yZSIgYWxzbyBuZWVkcyBzb21l
DQpyZWZhY3RvcmluZyAoaW4gcGFydGljdWxhciB0byBmaXggdGhlIGFidXNlIG9mIHN0cnVj
dCBjbGspLg0KDQpXb3JraW5nIG9uIHRoaXMgaGFzIGJlZW4gb24gbXkgVE9ETyBmb3IgYSBs
b25nIHRpbWUsIGJ1dCBJIGhhdmUgbm90IGdvdHRlbiBhcm91bmQgdG8gaXQuDQoNCi0tU2Vh
bg0K
