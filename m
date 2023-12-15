Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5989C4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 18:45:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 702B987C4A;
	Fri, 15 Dec 2023 19:45:38 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="H9+x0K0S";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F318C87C44; Fri, 15 Dec 2023 19:45:37 +0100 (CET)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7C7A387C4A
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 19:45:35 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-67f0f7e379dso6648856d6.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 10:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702665934; x=1703270734; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k8hZf3MtrO18SzFHgwXVHiyyPFMkCG0a4fHwrsdliBs=;
 b=H9+x0K0SeDEfiuIQs7COzvi4MpLMM060fPQu0FxYUeqVI+l3rFNyBS0Pt22YfUvEii
 IyUu7o21gxrF88fb5y/sTJ1Pxew5Cs3A80RWiqf2z8pfAyEbpUgoR7TrfDfHAQCgHeuN
 tSLljxfruFqip/jcArvlTh5hdK6ExnxWgf4KgONoUaVQiOS5BHvv78hHiYvCZ+pOv3Ka
 3OQ1ab76+n2HYBaQ1ivnU+LCx4xItkn6lIIjiPE3XFl4pp4t2EBoabP5Z7KGddWYeji4
 ClgZOH09syLqjLQP+pX6v8lB7sL7FMfUMRDDIufaBIhNZ2GOFobrsrt0DJok1zjN6zob
 CFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702665934; x=1703270734;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=k8hZf3MtrO18SzFHgwXVHiyyPFMkCG0a4fHwrsdliBs=;
 b=fR28jQ1M5msyPXLFEGgSPTOkFbRoie7VhuVHKZXg07+ZWieB5CN4cG3s0SZ3p/mWst
 5VW5jWHY+l2WNQFmj4I1Hu8Mu4LIgB0a4V4pZD9olTOCFUSQ9MUurZQ4ckjq5fhdtlLl
 90UiH1EF2KnZZZ42lPX09/DDAcBynH5VusFNBQr9NR88ogFH2n5Pdw1jw5UsAUTx1U2q
 vkLJ8ZzpUIYy00Y/6EEH2UrEqyJqRR10cjlp8Og/39XSaNuh/XAspUm/BdNnwcSiBiEq
 BsKJCvS/8+pyduUm6H0Du7bW3O/T80uCixNYpqMEmGlkNQkm7A1SiVXdrlY7ym/GWRhz
 8+TA==
X-Gm-Message-State: AOJu0Yy1ohCWDohHbV1l1JwHAfdUQ1KTS++Do6vACKgyI4PKGiMnjyXS
 mglXHqs0TiqW/Bsh2LBMNFk=
X-Google-Smtp-Source: AGHT+IFBRj4qR3SKOv0Rw7dLj+VrA80pvd0vw5YxFrfSZFO+7+VHO3XDOvYLig1BzpAYYKlOZGdxBw==
X-Received: by 2002:a05:6214:d0c:b0:67a:bc33:4c2f with SMTP id
 12-20020a0562140d0c00b0067abc334c2fmr16883647qvh.61.1702665934126; 
 Fri, 15 Dec 2023 10:45:34 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 ph30-20020a0562144a5e00b0067f201e3355sm394278qvb.111.2023.12.15.10.45.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 10:45:33 -0800 (PST)
Message-ID: <ac7c89c4-0b81-ae12-6bc4-ab191fee3b1c@gmail.com>
Date: Fri, 15 Dec 2023 13:45:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 1/1] clk: clk-gpio: add actual gated clock
Content-Language: en-US
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>, u-boot@lists.denx.de
References: <20231117075240.15741-1-clamor95@gmail.com>
 <20231117075240.15741-2-clamor95@gmail.com>
 <af9d8670-a99b-5ad3-712b-49ccf31cdea0@gmail.com>
 <CAPVz0n22VgkjEQC4pGD1Eq+jJs0y8o61itnrKC_WvvEb=zop7A@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPVz0n22VgkjEQC4pGD1Eq+jJs0y8o61itnrKC_WvvEb=zop7A@mail.gmail.com>
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

T24gMTIvMTUvMjMgMTM6MjYsIFN2eWF0b3NsYXYgUnloZWwgd3JvdGU6DQo+INC/0YIsIDE1
INCz0YDRg9C0LiAyMDIz4oCv0YAuINC+IDE5OjI1IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJA
Z21haWwuY29tPiDQv9C40YjQtToNCj4+DQo+PiBPbiAxMS8xNy8yMyAwMjo1MiwgU3Z5YXRv
c2xhdiBSeWhlbCB3cm90ZToNCj4+PiBFeGlzdGluZyBncGlvLWdhdGUtY2xvY2sgZHJpdmVy
IGFjdHMgbGlrZSBhIHNpbXBsZSBHUElPIHN3aXRjaCB3aXRob3V0IGFueQ0KPj4+IGVmZmVj
dCBvbiBnYXRlZCBjbG9jay4gQWRkIGFjdHVhbCBjbG9jayBhY3Rpb25zIGludG8gZW5hYmxl
L2Rpc2FibGUgb3BzIGFuZA0KPj4+IGltcGxlbWVudCBnZXRfcmF0ZSBvcCBieSBwYXNzaW5n
IGdhdGVkIGNsb2NrIGlmIGl0IGlzIGVuYWJsZWQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5
OiBTdnlhdG9zbGF2IFJ5aGVsIDxjbGFtb3I5NUBnbWFpbC5jb20+DQo+Pj4gLS0tDQo+Pj4g
ICAgZHJpdmVycy9jbGsvY2xrLWdwaW8uYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLQ0KPj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA0MCBpbnNlcnRp
b25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Y2xrL2Nsay1ncGlvLmMgYi9kcml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+Pj4gaW5kZXggMjZk
Nzk1Yjk3OC4uYTU1NDcwY2ZiZiAxMDA2NDQNCj4+PiAtLS0gYS9kcml2ZXJzL2Nsay9jbGst
Z3Bpby5jDQo+Pj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWdwaW8uYw0KPj4+IEBAIC0zLDE5
ICszLDIzIEBADQo+Pj4gICAgICogQ29weXJpZ2h0IChDKSAyMDIzIE1hcmVrIFZhc3V0IDxt
YXJlay52YXN1dCtyZW5lc2FzQG1haWxib3gub3JnPg0KPj4+ICAgICAqLw0KPj4+DQo+Pj4g
LSNpbmNsdWRlIDxhc20vZ3Bpby5oPg0KPj4+IC0jaW5jbHVkZSA8Y29tbW9uLmg+DQo+Pj4g
LSNpbmNsdWRlIDxjbGstdWNsYXNzLmg+DQo+Pj4gKyNpbmNsdWRlIDxjbGsuaD4NCj4+PiAg
ICAjaW5jbHVkZSA8ZG0uaD4NCj4+PiArI2luY2x1ZGUgPGNsay11Y2xhc3MuaD4NCj4+PiAr
I2luY2x1ZGUgPGxpbnV4L2Nsay1wcm92aWRlci5oPg0KPj4+ICsNCj4+PiArI2luY2x1ZGUg
PGFzbS9ncGlvLmg+DQo+Pj4NCj4+PiAgICBzdHJ1Y3QgY2xrX2dwaW9fcHJpdiB7DQo+Pj4g
ICAgICAgIHN0cnVjdCBncGlvX2Rlc2MgICAgICAgIGVuYWJsZTsNCj4+PiArICAgICBzdHJ1
Y3QgY2xrICAgICAgICAgICAgICAqY2xrOw0KPj4NCj4+IFBsZWFzZSBuYW1lIHRoaXMgInBh
cmVudCIuDQo+Pg0KPiBJIHNlZSBubyBuZWVkIGluIHRoaXMgc2luY2UgY2xrIGlzIGdlbmVy
aWMgbmFtZSBhbmQgdGhpcyBkcml2ZXIgY2FuDQo+IGFjY2VwdCBvbmx5IG9uZSBjbG9jayB3
aXRoIGFueSBuYW1lLg0KDQpJdCdzIGdvb2QgZG9jdW1lbnRhdGlvbi4gSXQgbWFrZXMgaXQg
Y2xlYXIgd2hhdCB0aGUgcHVycG9zZSBvZiB0aGUgbWVtYmVyIGlzLg0KDQo+Pj4gICAgfTsN
Cj4+Pg0KPj4+ICAgIHN0YXRpYyBpbnQgY2xrX2dwaW9fZW5hYmxlKHN0cnVjdCBjbGsgKmNs
aykNCj4+PiAgICB7DQo+Pj4gICAgICAgIHN0cnVjdCBjbGtfZ3Bpb19wcml2ICpwcml2ID0g
ZGV2X2dldF9wcml2KGNsay0+ZGV2KTsNCj4+Pg0KPj4+ICsgICAgIGNsa19wcmVwYXJlX2Vu
YWJsZShwcml2LT5jbGspOw0KPj4NCj4+IEp1c3QgY2xrX2VuYWJsZSBpcyBmaW5lLiBXZSBk
b24ndCBoYXZlIGEgc2VwYXJhdGUgcHJlcGFyZSBzdGFnZSBsaW5lIExpbnV4Lg0KPj4NCj4g
VS1Cb290IHN1cHBvcnRzIGNsa19wcmVwYXJlX2VuYWJsZSBhbmQgc2luY2UgdGhpcyBzdXBw
b3J0IGlzIHByZXNlbnQgSQ0KPiBzZWUgbm8gY29udHJhZGljdGlvbiBpbiB1c2luZyBpdC4N
Cg0KVGhlc2UgZnVuY3Rpb25zIGFyZSBvbmx5IHRoZXJlIGZvciB0byBtYWtlIGl0IGVhc2ll
ciB0byBwb3J0IGNvZGUgZnJvbSBMaW51eC4NClNpbmNlIHRoaXMgY29kZSB3YXMgd3JpdHRl
biBmb3IgVS1Cb290LCBqdXN0IHVzZSB0aGUgYWN0dWFsIGZ1bmN0aW9uLg0KDQo+Pj4gICAg
ICAgIGRtX2dwaW9fc2V0X3ZhbHVlKCZwcml2LT5lbmFibGUsIDEpOw0KPj4+DQo+Pj4gICAg
ICAgIHJldHVybiAwOw0KPj4+IEBAIC0yNiwyMSArMzAsNTAgQEAgc3RhdGljIGludCBjbGtf
Z3Bpb19kaXNhYmxlKHN0cnVjdCBjbGsgKmNsaykNCj4+PiAgICAgICAgc3RydWN0IGNsa19n
cGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4+DQo+Pj4gICAg
ICAgIGRtX2dwaW9fc2V0X3ZhbHVlKCZwcml2LT5lbmFibGUsIDApOw0KPj4+ICsgICAgIGNs
a19kaXNhYmxlX3VucHJlcGFyZShwcml2LT5jbGspOw0KPj4+DQo+Pj4gICAgICAgIHJldHVy
biAwOw0KPj4+ICAgIH0NCj4+Pg0KPj4+ICtzdGF0aWMgdWxvbmcgY2xrX2dwaW9fZ2V0X3Jh
dGUoc3RydWN0IGNsayAqY2xrKQ0KPj4+ICt7DQo+Pj4gKyAgICAgc3RydWN0IGNsa19ncGlv
X3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoY2xrLT5kZXYpOw0KPj4+ICsgICAgIGludCBy
ZXQ7DQo+Pj4gKw0KPj4+ICsgICAgIHJldCA9IGRtX2dwaW9fZ2V0X3ZhbHVlKCZwcml2LT5l
bmFibGUpOw0KPj4+ICsgICAgIGlmIChyZXQpDQo+Pj4gKyAgICAgICAgICAgICByZXR1cm4g
Y2xrX2dldF9yYXRlKHByaXYtPmNsayk7DQo+Pj4gKyAgICAgZWxzZQ0KPj4+ICsgICAgICAg
ICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+Pg0KPj4gVGhpcyBzaG91bGQgYWx3YXlzIHJldHVy
biB0aGUgcGFyZW50IHJhdGUuDQo+Pg0KPiBIb3cgY2FuIHlvdSByZXR1cm4gY2xvY2sgcmF0
ZSBpZiB0aGUgZ2F0ZSBpcyBkaXNhYmxlZD8NCg0KVGhpcyBhbGxvd3MgY29uc3VtZXJzIHRv
IGtub3cgd2hhdCB0aGUgcmF0ZSB3aWxsIGJlIGJlZm9yZSB0aGV5DQplbmFibGUgdGhlIGNs
b2NrLg0KDQo+Pj4gK30NCj4+PiArDQo+Pj4gICAgY29uc3Qgc3RydWN0IGNsa19vcHMgY2xr
X2dwaW9fb3BzID0gew0KPj4+ICAgICAgICAuZW5hYmxlICAgICAgICAgPSBjbGtfZ3Bpb19l
bmFibGUsDQo+Pj4gICAgICAgIC5kaXNhYmxlICAgICAgICA9IGNsa19ncGlvX2Rpc2FibGUs
DQo+Pj4gKyAgICAgLmdldF9yYXRlICAgICAgID0gY2xrX2dwaW9fZ2V0X3JhdGUsDQo+Pj4g
ICAgfTsNCj4+Pg0KPj4+IC1zdGF0aWMgaW50IGNsa19ncGlvX3Byb2JlKHN0cnVjdCB1ZGV2
aWNlICpkZXYpDQo+Pj4gK3N0YXRpYyBpbnQgY2xrX2dwaW9fb2ZfdG9fcGxhdChzdHJ1Y3Qg
dWRldmljZSAqZGV2KQ0KPj4NCj4+IFRoaXMgY2hhbmdlIHNob3VsZCBiZSBhIHNlcGFyYXRl
IGNvbW1pdC4NCj4+DQo+IFRoaXMgYWN0dWFsbHkgc2hvdWxkIG5vdCBiZSBhY2NlcHRlZCBm
aXJzdCBwbGFjZQ0KPiANCj4gLm9mX3RvX3BsYXQgLSBjb252ZXJ0IGRldmljZSB0cmVlIGRh
dGEgdG8gcGxhdA0KPiAucHJvYmUgLSBtYWtlIGEgZGV2aWNlIHJlYWR5IGZvciB1c2UNCj4g
DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS91LWJvb3QvdS1ib290L2Jsb2IvbWFzdGVyL2RvYy9k
ZXZlbG9wL2RyaXZlci1tb2RlbC9kZXNpZ24ucnN0DQoNClllcywgdGhpcyBpcyB3aHkgSSB3
YXMgYSBiaXQgY29uZnVzZWQgOikNCg0KPj4+ICAgIHsNCj4+PiAgICAgICAgc3RydWN0IGNs
a19ncGlvX3ByaXYgKnByaXYgPSBkZXZfZ2V0X3ByaXYoZGV2KTsNCj4+PiArICAgICBpbnQg
cmV0Ow0KPj4+DQo+Pj4gLSAgICAgcmV0dXJuIGdwaW9fcmVxdWVzdF9ieV9uYW1lKGRldiwg
ImVuYWJsZS1ncGlvcyIsIDAsDQo+Pj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZwcml2LT5lbmFibGUsIEdQSU9EX0lTX09VVCk7DQo+Pj4gKyAgICAgcHJpdi0+Y2xr
ID0gZGV2bV9jbGtfZ2V0KGRldiwgTlVMTCk7DQo+Pj4gKyAgICAgaWYgKElTX0VSUihwcml2
LT5jbGspKSB7DQo+Pj4gKyAgICAgICAgICAgICBsb2dfZXJyKCIlczogQ291bGQgbm90IGdl
dCBnYXRlZCBjbG9jazogJWxkXG4iLA0KPj4+ICsgICAgICAgICAgICAgICAgICAgICBfX2Z1
bmNfXywgUFRSX0VSUihwcml2LT5jbGspKTsNCj4+PiArICAgICAgICAgICAgIHJldHVybiBQ
VFJfRVJSKHByaXYtPmNsayk7DQo+Pj4gKyAgICAgfQ0KPj4+ICsNCj4+PiArICAgICByZXQg
PSBncGlvX3JlcXVlc3RfYnlfbmFtZShkZXYsICJlbmFibGUtZ3Bpb3MiLCAwLA0KPj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICZwcml2LT5lbmFibGUsIEdQSU9EX0lT
X09VVCk7DQo+Pj4gKyAgICAgaWYgKHJldCkgew0KPj4+ICsgICAgICAgICAgICAgbG9nX2Vy
cigiJXM6IENvdWxkIG5vdCBkZWNvZGUgZW5hYmxlLWdwaW9zICglZClcbiIsDQo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgIF9fZnVuY19fLCByZXQpOw0KPj4NCj4+IFVzZSBkZXZfZGJn
IGZvciBwcm9iZSBlcnJvcnMgdG8gcmVkdWNlIGJpbmFyeSBzaXplLg0KPj4NCj4gVGhlc2Ug
ZXJyb3JzIHByb3ZpZGUgaW50ZWwgYWJvdXQgcHJvYmluZyAyIGtleSBwYXJ0cyBvZiB0aGUg
ZHJpdmVyLg0KPiBIb3cgd291bGQgeW91IGtub3cgaXQgZmFpbHMgaW4gY2FzZSB5b3UgaGF2
ZSBubyBkZXZpY2VzIHdoaWNoIGZhY2UNCj4gdGhpcyBlcnJvcj8gSWlzIHRoZXJlIGFueSBj
b252ZW50aW9uIG9yIHJlc3RyaWN0aW9uIHdoaWNoIHByb2hpYml0cw0KPiB0aGlzPyBJZiB5
ZXMsIHRoZW4gcHJvdmlkZSBhIGRvY3VtZW50IHBsZWFzZS4NCg0KaHR0cHM6Ly9kb2NzLnUt
Ym9vdC5vcmcvZW4vbGF0ZXN0L2RldmVsb3AvZHJpdmVyLW1vZGVsL2Rlc2lnbi5odG1sI2Vy
cm9yLWNvZGVzDQoNCnwgSWRlYWxseSwgbWVzc2FnZXMgaW4gZHJpdmVycyBzaG91bGQgb25s
eSBiZSBkaXNwbGF5ZWQgd2hlbiBkZWJ1Z2dpbmcsDQp8IGUuZy4gYnkgdXNpbmcgbG9nX2Rl
YnVnKCkgYWx0aG91Z2ggaW4gZXh0cmVtZSBjYXNlcyBsb2dfd2FybmluZygpIG9yDQp8IGxv
Z19lcnJvcigpIG1heSBiZSB1c2VkLg0KDQo+IEFsbCBvdGhlciBnZW5lcmFsIGNsb2NrIGRy
aXZlcnMgdXNlIGxvZ19lcnIvZGV2X2VyciB2ZXJzaW9ucyBidHcuDQoNClllYWgsIGl0J3Mg
c29tZXRoaW5nIHdlIGhhdmUgbm90IGJlZW4gc28gY29uc2lzdGVudCB3aXRoIGVuZm9yY2lu
Zy4NCg0KPj4+ICsgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+PiArICAgICB9DQo+Pj4g
Kw0KPj4+ICsgICAgIHJldHVybiAwOw0KPj4+ICAgIH0NCj4+Pg0KPj4+ICAgIC8qDQo+Pj4g
QEAgLTU5LDcgKzkyLDcgQEAgVV9CT09UX0RSSVZFUihncGlvX2dhdGVfY2xvY2spID0gew0K
Pj4+ICAgICAgICAubmFtZSAgICAgICAgICAgPSAiZ3Bpb19jbG9jayIsDQo+Pj4gICAgICAg
IC5pZCAgICAgICAgICAgICA9IFVDTEFTU19DTEssDQo+Pj4gICAgICAgIC5vZl9tYXRjaCAg
ICAgICA9IGNsa19ncGlvX21hdGNoLA0KPj4+IC0gICAgIC5wcm9iZSAgICAgICAgICA9IGNs
a19ncGlvX3Byb2JlLA0KPj4+ICsgICAgIC5vZl90b19wbGF0ICAgICA9IGNsa19ncGlvX29m
X3RvX3BsYXQsDQo+Pj4gICAgICAgIC5wcml2X2F1dG8gICAgICA9IHNpemVvZihzdHJ1Y3Qg
Y2xrX2dwaW9fcHJpdiksDQo+Pj4gICAgICAgIC5vcHMgICAgICAgICAgICA9ICZjbGtfZ3Bp
b19vcHMsDQo+Pj4gICAgICAgIC5mbGFncyAgICAgICAgICA9IERNX0ZMQUdfUFJFX1JFTE9D
LA0KPj4NCj4+IC0tU2Vhbg0KDQo=
