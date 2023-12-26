Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2207C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 06:25:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7833587869;
	Tue, 26 Dec 2023 07:25:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hrg3XL28";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0A20E8786E; Tue, 26 Dec 2023 07:25:18 +0100 (CET)
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com
 [IPv6:2607:f8b0:4864:20::f2d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BDED38773F
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 07:25:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2d.google.com with SMTP id
 6a1803df08f44-67f83812a32so26732456d6.3
 for <u-boot@lists.denx.de>; Mon, 25 Dec 2023 22:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703571914; x=1704176714; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T8QFWpmr5QTdqEvNxrHU52l1FG5IfY1iMqTcXNpRuu8=;
 b=hrg3XL28zzk2UhSl2k7D/aFd35iJmZcXzUhmVWCotKqkLPCI/yE4OxZZ8bJnBlgEp1
 CjjXIuttMDS3AN9NOsbAAbwZaWV62ZjP1J1AxPP8krOdmAj8IiI/IUAa3RNBRHSKAEPV
 cKV/Zxg7T6ugtt0RR4lSf4SwX8ROidA8xnlO2vR6W/FrAdkjL77eGK7l0Y0wrr+VTEm+
 rdOs2JZPbaBlOmaw7HZmUtH4pjaF423Uf5WorRa7kk8bmPjQsxkLwcEkPhnoW3cQ83/o
 zr54jsd1bOzUmB4tdtG1BV9rekfZkNBC3yl04Sn3jtW1ehHP9k5zYU0w5ub2C/zSAKmP
 Ghrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703571914; x=1704176714;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T8QFWpmr5QTdqEvNxrHU52l1FG5IfY1iMqTcXNpRuu8=;
 b=mPhsI7zRqCN3n2hj3gU+PZUTRyAOtGilgMBeOyf7vwBUcFL8IZtuUyJWUH9uyGtPRd
 Drb08g1gH8sm6TK3uQ+/swEFH9THTtPbAiBZVQJrx8JXMYscqPSxNFz9QPyNzyxUb/HE
 Nm6mUZ08fbIIfUsLPGRlOIdr98rWnTHArOnO9YOKnxbPeLUgG2lu1D3qCTV5ApMsiqxP
 dpeYTEq4/8AlNHrkHrjdMV1ayxw3SCOISJoehqveXH2Yq6r99yG3bzan5i6jfv4e5YnX
 J2HHztOSG0bfRK5ULIPwnidGf0Q0dTXAHt3tY/9lMiZUBgbBF4fY0lGRGtUVsKLlcIxe
 evkQ==
X-Gm-Message-State: AOJu0Ywq+eCZEMWPZ9nZ0rwDd+GOdW+bz680Ngr9LhBDK/t2aIM8PRd6
 4yJWSZEhc7JJS8Wn1trcsgg=
X-Google-Smtp-Source: AGHT+IEOhBiGM+FfbB572UBNgjKuBT79dUA2VWWyjZh5928KfaacZJDVdNaWO71IUGtPOJzTrFGX/A==
X-Received: by 2002:a05:6214:1bc8:b0:67f:33dd:633 with SMTP id
 m8-20020a0562141bc800b0067f33dd0633mr9385622qvc.9.1703571914485; 
 Mon, 25 Dec 2023 22:25:14 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 i5-20020ad44105000000b0067f24a93556sm4387593qvp.52.2023.12.25.22.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Dec 2023 22:25:14 -0800 (PST)
Message-ID: <6ec77ae5-a05e-a18d-0c65-99f141d3e6cb@gmail.com>
Date: Tue, 26 Dec 2023 01:25:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATHv2 2/9] net: sandbox: fix NULL pointer derefences
Content-Language: en-US
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: u-boot@lists.denx.de, simon.k.r.goldschmidt@gmail.com,
 tien.fong.chee@intel.com, sjg@chromium.org, joe.hershberger@ni.com,
 rfried.dev@gmail.com, bharat.gooty@broadcom.com,
 rayagonda.kokatanur@broadcom.com, trini@konsulko.com
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-3-maxim.uvarov@linaro.org>
 <a45cbd9a-cfa2-7728-3c5f-1a21ebbcb068@gmail.com>
 <CAD8XO3Z5Ff5u=PS5H6jaxRcdnZGh28+m6wC48A3P_H=bd5GBKQ@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAD8XO3Z5Ff5u=PS5H6jaxRcdnZGh28+m6wC48A3P_H=bd5GBKQ@mail.gmail.com>
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

T24gMTIvMjYvMjMgMDE6MTgsIE1heGltIFV2YXJvdiB3cm90ZToNCj4gDQo+IA0KPiBPbiBU
dWUsIDI2IERlYyAyMDIzIGF0IDA0OjQzLCBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWls
LmNvbSA8bWFpbHRvOnNlYW5nYTJAZ21haWwuY29tPj4gd3JvdGU6DQo+IA0KPiAgICAgT24g
MTIvMjUvMjMgMTA6MzksIE1heGltIFV2YXJvdiB3cm90ZToNCj4gICAgICA+IEFkZCBhZGRp
dGlvbmFsIGNoZWNrcyBmb3IgTlVMTCBwb2ludGVycy4NCj4gICAgICA+DQo+ICAgICAgPiBT
aWduZWQtb2ZmLWJ5OiBNYXhpbSBVdmFyb3YgPG1heGltLnV2YXJvdkBsaW5hcm8ub3JnIDxt
YWlsdG86bWF4aW0udXZhcm92QGxpbmFyby5vcmc+Pg0KPiAgICAgID4gLS0tDQo+ICAgICAg
PsKgIMKgZHJpdmVycy9uZXQvc2FuZGJveC5jIHwgMyArKysNCj4gICAgICA+wqAgwqAxIGZp
bGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+ICAgICAgPg0KPiAgICAgID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvbmV0L3NhbmRib3guYyBiL2RyaXZlcnMvbmV0L3NhbmRib3guYw0K
PiAgICAgID4gaW5kZXggMTMwMjJhZGRiNi4uZDkxOTM1ZTAzMiAxMDA2NDQNCj4gICAgICA+
IC0tLSBhL2RyaXZlcnMvbmV0L3NhbmRib3guYw0KPiAgICAgID4gKysrIGIvZHJpdmVycy9u
ZXQvc2FuZGJveC5jDQo+ICAgICAgPiBAQCAtNjUsNiArNjUsOSBAQCBpbnQgc2FuZGJveF9l
dGhfYXJwX3JlcV90b19yZXBseShzdHJ1Y3QgdWRldmljZSAqZGV2LCB2b2lkICpwYWNrZXQs
DQo+ICAgICAgPsKgIMKgIMKgIMKgc3RydWN0IGV0aGVybmV0X2hkciAqZXRoX3JlY3Y7DQo+
ICAgICAgPsKgIMKgIMKgIMKgc3RydWN0IGFycF9oZHIgKmFycF9yZWN2Ow0KPiAgICAgID4N
Cj4gICAgICA+ICvCoCDCoCDCoGlmICghcHJpdikNCj4gICAgICA+ICvCoCDCoCDCoCDCoCDC
oCDCoCDCoHJldHVybiAtRUFHQUlOOw0KPiAgICAgID4gKw0KPiANCj4gICAgIFdoZW4gY2Fu
IHByaXYgYmUgTlVMTD8NCj4gDQo+ICAgICAtLVNlYW4NCj4gDQo+IA0KPiBGdW5jdGlvbg0K
PiBzdHJ1Y3QgZXRoX3NhbmRib3hfcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihkZXYpDQo+
IGNhbiByZXR1cm4gTlVMTC4gSWYgeW91IGFzayB3aHkgaXQgZG9lc24ndCByZXR1cm4gTlVM
TCB3aXRob3V0IGx3aXAgcGF0Y2hlcyBhbmQgY2FuIHJldHVybiBOVUxMIHdpdGggbHdpcCBw
YXRjaCB3aGlsZSB0aGVyZSBpcyBubyBjbGVhciBjb2RlIGRlcGVuZGVuY3kuLg0KPiBUaGVu
IEkgY2FuIG5vdCBzYXkgcmlnaHQgbm93IGFuZCBuZWVkIGFkZGl0aW9uYWwgaW52ZXN0aWdh
dGlvbi4gQnV0IGFueXdheSB0aGUgcmV0dXJuIGNvZGUgb2YgZGV2X2Rldl9wcml2KCkgaGFz
IHRvIGJlIGNoZWNrZWQgSSB0aGluay4NCg0KSWYgeW91IHNldCBwcml2X2F1dG8gdG8gYSBu
b256ZXJvIHZhbHVlLCBkZXZfZ2V0X3ByaXYgd2lsbCBhbHdheXMgcmV0dXJuIG5vbi1udWxs
DQphbmQgZG9lcyBub3QgbmVlZCB0byBiZSBjaGVja2VkLiBTbyB0aGlzIGlzIGEgTkFDSyBm
cm9tIG1lIHVudGlsIHlvdSBjYW4ganVzdGlmeSB0aGlzLg0KDQotLVNlYW4NCg==
