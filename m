Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164BEC4332F
	for <u-boot@archiver.kernel.org>; Wed,  1 Nov 2023 18:30:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 36150876DC;
	Wed,  1 Nov 2023 19:30:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EHffhYvX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 406C687076; Wed,  1 Nov 2023 19:30:10 +0100 (CET)
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com
 [IPv6:2607:f8b0:4864:20::829])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D5C2E876DC
 for <u-boot@lists.denx.de>; Wed,  1 Nov 2023 19:30:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x829.google.com with SMTP id
 d75a77b69052e-41b406523fcso6751cf.2
 for <u-boot@lists.denx.de>; Wed, 01 Nov 2023 11:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698863403; x=1699468203; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=axarODwjjGQ0sQs1BySHPyyIPpi/hR2XvpclMYSBxNE=;
 b=EHffhYvXuJuN8RWvC/wH2BQO/eGx9J1Lyfh4ND9OPdUPrailoK811iX9OeaYYmJX73
 TdyaghNaovvN9b+dNdWZVLlMTsux9+4JeD++qbSxyVN8Eqv99SfzTAfMOdf+ZoCAdOeC
 DPSmIxkstlPERGymcLccm8l8v976t0mQuQ5/DatEJKfrtdx9T6kemVL1oS/h1GZF9ZnY
 dhDkuUsdZqimUeQZ31GOHkAlWBROAxvDQWqqUaYX3t8LjO+MdiMVoP8AuLgnW4nZJyw6
 hIBb5fBZysijszQa+07ak+BXs4NmMfw0+yPVextqTj/0EmCn+ID31yDd5GX6yRCMQvw4
 oq0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698863403; x=1699468203;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axarODwjjGQ0sQs1BySHPyyIPpi/hR2XvpclMYSBxNE=;
 b=BImZxaDozmhSF4tDsSjdW8dxVEDkkfXp0OoNwv00EzZjODvN0t6StVthBmR2atipNY
 iKHn5jvpsELsDtWYDh+fVcyM6+f3zyzrngHTwc3ev+YMKmGEJm3nlCrLF/W0IbmUk4/2
 Z3FF+73PLTaNSpbglHKd6B6TdlATvW8fgAATqICEHycD1aIIgtOmWvvxwPT/KGup5m2h
 PXxnhNtF2EqWqsKjbMuxVD3afdhKsLjYgPYwz0Ui+JH1zcLxA9fo9SCgDz3K/TWzRevG
 VEKdsQBGlEQGHm5b3kWnja3dv7KrRCFKMMWBcZBm/JRI+Lp1RROdYtkgw8B0wYKX1bjF
 UFJQ==
X-Gm-Message-State: AOJu0YwB3cDqy/oOdUENU9zjsOy5jUCjxgRGLCBYP66b/0kH+Q7gAglc
 /Z6aCAWJxfmrE1btlaMUfiuEIRjRpFHAlw==
X-Google-Smtp-Source: AGHT+IF9xaya4MsK7jtsdVd1zKj8jTNwJKxLugTKFqJ0nuGEiPYfc2wtLYdCDy1EO5CfPwf3VIVa7w==
X-Received: by 2002:a05:622a:4d3:b0:41e:2923:a15f with SMTP id
 q19-20020a05622a04d300b0041e2923a15fmr20390289qtx.58.1698863403453; 
 Wed, 01 Nov 2023 11:30:03 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 e10-20020ac845ca000000b00419ab6ffedasm1615671qto.29.2023.11.01.11.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Nov 2023 11:30:03 -0700 (PDT)
Message-ID: <dae57441-9b87-1df3-2de5-2abd19c8a378@gmail.com>
Date: Wed, 1 Nov 2023 14:30:02 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] clk: fix count parameter type for clk_release_all
Content-Language: en-US
To: Eugen Hristev <eugen.hristev@collabora.com>, lukma@denx.de
Cc: u-boot@lists.denx.de
References: <20230619104752.278500-1-eugen.hristev@collabora.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <20230619104752.278500-1-eugen.hristev@collabora.com>
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

T24gNi8xOS8yMyAwNjo0NywgRXVnZW4gSHJpc3RldiB3cm90ZToNCj4gVGhlIHNlY29uZCBw
YXJhbWV0ZXIgZm9yIGNsa19yZWxlYXNlX2FsbCBpcyB1c2VkIGFzIGFuIHVuc2lnbmVkDQo+
ICh3aGljaCBtYWtlcyBzZW5zZSkgYnV0IHRoZSBmdW5jdGlvbiBwcm90b3R5cGUgZGVjbGFy
ZXMgaXQgYXMgYW4gaW50Lg0KPiBUaGlzIGNhdXNlcyB3YXJuaW5ncy9lcnJvciBsaWtlIHN1
Y2ggYmVsb3c6DQo+IA0KPiBpbmNsdWRlL2Nsay5oOjQyMjo0ODogZXJyb3I6IGNvbnZlcnNp
b24gdG8g4oCYaW504oCZIGZyb20g4oCYdW5zaWduZWQgaW504oCZIG1heSBjaGFuZ2UgdGhl
IHNpZ24gb2YgdGhlIHJlc3VsdCBbLVdlcnJvcj1zaWduLWNvbnZlcnNpb25dDQo+ICAgIDQy
MiB8ICAgICAgICAgcmV0dXJuIGNsa19yZWxlYXNlX2FsbChidWxrLT5jbGtzLCBidWxrLT5j
b3VudCk7DQo+IA0KPiBUbyBmaXggdGhpcywgY2hhbmdlZCB0aGUgdHlwZSBvZiB0aGUgY291
bnQgdG8gYHVuc2lnbmVkIGludGANCj4gDQo+IEZpeGVzOiA4MmE4YTY2OWI0ZjcgKCJjbGs6
IGFkZCBjbGtfcmVsZWFzZV9hbGwoKSIpDQo+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuIEhyaXN0
ZXYgPGV1Z2VuLmhyaXN0ZXZAY29sbGFib3JhLmNvbT4NCj4gLS0tDQo+ICAgZHJpdmVycy9j
bGsvY2xrLXVjbGFzcy5jIHwgNyArKysrLS0tDQo+ICAgaW5jbHVkZS9jbGsuaCAgICAgICAg
ICAgIHwgNCArKy0tDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDUg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9jbGsvY2xrLXVjbGFz
cy5jIGIvZHJpdmVycy9jbGsvY2xrLXVjbGFzcy5jDQo+IGluZGV4IGRjM2U5ZDZhMjYxNS4u
ZWFkYTNhM2E1YjYyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9jbGstdWNsYXNzLmMN
Cj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLXVjbGFzcy5jDQo+IEBAIC00MTYsMTIgKzQxNiwx
MyBAQCBpbnQgY2xrX2dldF9ieV9uYW1lX25vZGV2KG9mbm9kZSBub2RlLCBjb25zdCBjaGFy
ICpuYW1lLCBzdHJ1Y3QgY2xrICpjbGspDQo+ICAgCXJldHVybiBjbGtfZ2V0X2J5X2luZGV4
X25vZGV2KG5vZGUsIGluZGV4LCBjbGspOw0KPiAgIH0NCj4gICANCj4gLWludCBjbGtfcmVs
ZWFzZV9hbGwoc3RydWN0IGNsayAqY2xrLCBpbnQgY291bnQpDQo+ICtpbnQgY2xrX3JlbGVh
c2VfYWxsKHN0cnVjdCBjbGsgKmNsaywgdW5zaWduZWQgaW50IGNvdW50KQ0KPiAgIHsNCj4g
LQlpbnQgaSwgcmV0Ow0KPiArCXVuc2lnbmVkIGludCBpOw0KPiArCWludCByZXQ7DQo+ICAg
DQo+ICAgCWZvciAoaSA9IDA7IGkgPCBjb3VudDsgaSsrKSB7DQo+IC0JCWRlYnVnKCIlcyhj
bGtbJWRdPSVwKVxuIiwgX19mdW5jX18sIGksICZjbGtbaV0pOw0KPiArCQlkZWJ1ZygiJXMo
Y2xrWyV1XT0lcClcbiIsIF9fZnVuY19fLCBpLCAmY2xrW2ldKTsNCj4gICANCj4gICAJCS8q
IGNoZWNrIGlmIGNsb2NrIGhhcyBiZWVuIHByZXZpb3VzbHkgcmVxdWVzdGVkICovDQo+ICAg
CQlpZiAoIWNsa1tpXS5kZXYpDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2Nsay5oIGIvaW5j
bHVkZS9jbGsuaA0KPiBpbmRleCBkOTEyODUyMzVmNzkuLmEzNDIyOTcwMDdiNiAxMDA2NDQN
Cj4gLS0tIGEvaW5jbHVkZS9jbGsuaA0KPiArKysgYi9pbmNsdWRlL2Nsay5oDQo+IEBAIC0y
NDMsNyArMjQzLDcgQEAgc3RhdGljIGlubGluZSBzdHJ1Y3QgY2xrICpkZXZtX2Nsa19nZXRf
b3B0aW9uYWwoc3RydWN0IHVkZXZpY2UgKmRldiwNCj4gICAgKg0KPiAgICAqIFJldHVybjog
emVybyBvbiBzdWNjZXNzLCBvciAtdmUgZXJyb3IgY29kZS4NCj4gICAgKi8NCj4gLWludCBj
bGtfcmVsZWFzZV9hbGwoc3RydWN0IGNsayAqY2xrLCBpbnQgY291bnQpOw0KPiAraW50IGNs
a19yZWxlYXNlX2FsbChzdHJ1Y3QgY2xrICpjbGssIHVuc2lnbmVkIGludCBjb3VudCk7DQo+
ICAgDQo+ICAgLyoqDQo+ICAgICogZGV2bV9jbGtfcHV0CS0gImZyZWUiIGEgbWFuYWdlZCBj
bG9jayBzb3VyY2UNCj4gQEAgLTMwNyw3ICszMDcsNyBAQCBjbGtfZ2V0X2J5X25hbWVfbm9k
ZXYob2Zub2RlIG5vZGUsIGNvbnN0IGNoYXIgKm5hbWUsIHN0cnVjdCBjbGsgKmNsaykNCj4g
ICAJcmV0dXJuIC1FTk9TWVM7DQo+ICAgfQ0KPiAgIA0KPiAtc3RhdGljIGlubGluZSBpbnQg
Y2xrX3JlbGVhc2VfYWxsKHN0cnVjdCBjbGsgKmNsaywgaW50IGNvdW50KQ0KPiArc3RhdGlj
IGlubGluZSBpbnQgY2xrX3JlbGVhc2VfYWxsKHN0cnVjdCBjbGsgKmNsaywgdW5zaWduZWQg
aW50IGNvdW50KQ0KPiAgIHsNCj4gICAJcmV0dXJuIC1FTk9TWVM7DQo+ICAgfQ0KDQpSZXZp
ZXdlZC1ieTogU2VhbiBBbmRlcnNvbiA8c2VhbmdhMkBnbWFpbC5jb20+DQo=
