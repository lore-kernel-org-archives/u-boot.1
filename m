Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A06CC4167B
	for <u-boot@archiver.kernel.org>; Fri, 15 Dec 2023 20:20:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A393E87C32;
	Fri, 15 Dec 2023 21:20:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eFjEn+NT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AA03187C50; Fri, 15 Dec 2023 21:20:25 +0100 (CET)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 81F1887C32
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 21:20:23 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-4260ba19a57so7986101cf.3
 for <u-boot@lists.denx.de>; Fri, 15 Dec 2023 12:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702671622; x=1703276422; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=auaVOenuUMW2HEvN9vaywEqd5Nwv4k8kTSeWnCXhaew=;
 b=eFjEn+NTxPT2T1BdxFP0yKjQ54wty7lPCYzWbmFHyrxRs3SG1WJlMsc8BE1+5Alrj5
 qNZeiLxId8Zwk6EmrS4tlH8xyNaJ8MXti6Sr9s9iNUh/A15odWrnerNOQZgZPkJyp3oE
 BLahFCFYKAQgpZcPrO0n1nXYUay3xNPl8igkOLa6BoyFxYc6fDZDP4ZJIaAXwpgMYiEn
 CBCr116NSeav04+pqabSnxKuv5IR+W5TmQNQaQk262d1IpgGs6nMo3BTnNszLzgCB46G
 hf7YBjY45XRh6l8ICG+aq87kKnTVjBSErguQU1mbJnxJTdXj1iZpT1OPKowCvJ3cLlzD
 DBhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702671622; x=1703276422;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=auaVOenuUMW2HEvN9vaywEqd5Nwv4k8kTSeWnCXhaew=;
 b=JhsvnQNk361bAOdcMOR6NzoD/RFALWNkxLCxA78EE/cXL4SMWlrNB37jbGROFBGcM2
 qc85gKSnVuGyJkK1reRCZ++VanQqfiCW+nuZ1nzjt3d0q3SDH0M06CnqFJkEomQZ1NGA
 6Dtudr3lhxiBmw553+VeWq2xXqGKzO5CdJKeFC+irDtIonMmbunEKplUPmkq0iMuComn
 RYBHrJaDRLvzR9SvgUomq/AtTy/KUzF9Qz+QD2IuAjaQddQz53ypPxl8XNywVXTdhf3C
 QH30PU9BoCJrcgIfBZjODcNtWbFNEUD2hZLkdWTz2GmtEyXX7h80pko74SOfNhk4yOuY
 /Uhg==
X-Gm-Message-State: AOJu0YwImduDhyEbRslhpywSzkOYVwOF9lYRn2eq6zB0aw8mzukAGmeA
 RWSwz7mhFVxftcwXigQHXkJKXW4wTrY=
X-Google-Smtp-Source: AGHT+IGfl6sWObsjxuMO1uanu9SLZr+T9/ztWABbl2g8KyTzAUVW2PbqpjxKonLtBBWLRpkfUmwDDA==
X-Received: by 2002:a05:622a:cf:b0:425:4043:5f0f with SMTP id
 p15-20020a05622a00cf00b0042540435f0fmr16657901qtw.77.1702671622197; 
 Fri, 15 Dec 2023 12:20:22 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 z23-20020ac87117000000b00423de58d3d8sm6916096qto.40.2023.12.15.12.20.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Dec 2023 12:20:21 -0800 (PST)
Message-ID: <bfed6c4f-d916-6872-343d-ac188070087b@gmail.com>
Date: Fri, 15 Dec 2023 15:20:21 -0500
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
 <ac7c89c4-0b81-ae12-6bc4-ab191fee3b1c@gmail.com>
 <CAPVz0n2NbYCBwL8ccG6WMarD7bD4S-y34rueCCuQeCsSyWj=Uw@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPVz0n2NbYCBwL8ccG6WMarD7bD4S-y34rueCCuQeCsSyWj=Uw@mail.gmail.com>
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

T24gMTIvMTUvMjMgMTU6MDAsIFN2eWF0b3NsYXYgUnloZWwgd3JvdGU6DQo+INC/0YIsIDE1
INCz0YDRg9C0LiAyMDIz4oCv0YAuINC+IDIwOjQ1IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJA
Z21haWwuY29tPiDQv9C40YjQtToNCj4+DQo+PiBPbiAxMi8xNS8yMyAxMzoyNiwgU3Z5YXRv
c2xhdiBSeWhlbCB3cm90ZToNCj4+PiDQv9GCLCAxNSDQs9GA0YPQtC4gMjAyM+KAr9GALiDQ
viAxOToyNSBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT4g0L/QuNGI0LU6DQo+
Pj4+DQo+Pj4+IE9uIDExLzE3LzIzIDAyOjUyLCBTdnlhdG9zbGF2IFJ5aGVsIHdyb3RlOg0K
Pj4+Pj4gRXhpc3RpbmcgZ3Bpby1nYXRlLWNsb2NrIGRyaXZlciBhY3RzIGxpa2UgYSBzaW1w
bGUgR1BJTyBzd2l0Y2ggd2l0aG91dCBhbnkNCj4+Pj4+IGVmZmVjdCBvbiBnYXRlZCBjbG9j
ay4gQWRkIGFjdHVhbCBjbG9jayBhY3Rpb25zIGludG8gZW5hYmxlL2Rpc2FibGUgb3BzIGFu
ZA0KPj4+Pj4gaW1wbGVtZW50IGdldF9yYXRlIG9wIGJ5IHBhc3NpbmcgZ2F0ZWQgY2xvY2sg
aWYgaXQgaXMgZW5hYmxlZC4NCj4+Pj4+DQo+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTdnlhdG9z
bGF2IFJ5aGVsIDxjbGFtb3I5NUBnbWFpbC5jb20+DQo+Pj4+PiAtLS0NCj4+Pj4+ICAgICBk
cml2ZXJzL2Nsay9jbGstZ3Bpby5jIHwgNDcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tDQo+Pj4+PiAgICAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlv
bnMoKyksIDcgZGVsZXRpb25zKC0pDQo+Pj4+Pg0KPj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xrL2Nsay1ncGlvLmMgYi9kcml2ZXJzL2Nsay9jbGstZ3Bpby5jDQo+Pj4+PiBpbmRl
eCAyNmQ3OTViOTc4Li5hNTU0NzBjZmJmIDEwMDY0NA0KPj4+Pj4gLS0tIGEvZHJpdmVycy9j
bGsvY2xrLWdwaW8uYw0KPj4+Pj4gKysrIGIvZHJpdmVycy9jbGsvY2xrLWdwaW8uYw0KPj4+
Pj4gQEAgLTMsMTkgKzMsMjMgQEANCj4+Pj4+ICAgICAgKiBDb3B5cmlnaHQgKEMpIDIwMjMg
TWFyZWsgVmFzdXQgPG1hcmVrLnZhc3V0K3JlbmVzYXNAbWFpbGJveC5vcmc+DQo+Pj4+PiAg
ICAgICovDQo+Pj4+Pg0KPj4+Pj4gLSNpbmNsdWRlIDxhc20vZ3Bpby5oPg0KPj4+Pj4gLSNp
bmNsdWRlIDxjb21tb24uaD4NCj4+Pj4+IC0jaW5jbHVkZSA8Y2xrLXVjbGFzcy5oPg0KPj4+
Pj4gKyNpbmNsdWRlIDxjbGsuaD4NCj4+Pj4+ICAgICAjaW5jbHVkZSA8ZG0uaD4NCj4+Pj4+
ICsjaW5jbHVkZSA8Y2xrLXVjbGFzcy5oPg0KPj4+Pj4gKyNpbmNsdWRlIDxsaW51eC9jbGst
cHJvdmlkZXIuaD4NCj4+Pj4+ICsNCj4+Pj4+ICsjaW5jbHVkZSA8YXNtL2dwaW8uaD4NCj4+
Pj4+DQo+Pj4+PiAgICAgc3RydWN0IGNsa19ncGlvX3ByaXYgew0KPj4+Pj4gICAgICAgICBz
dHJ1Y3QgZ3Bpb19kZXNjICAgICAgICBlbmFibGU7DQo+Pj4+PiArICAgICBzdHJ1Y3QgY2xr
ICAgICAgICAgICAgICAqY2xrOw0KPj4+Pg0KPj4+PiBQbGVhc2UgbmFtZSB0aGlzICJwYXJl
bnQiLg0KPj4+Pg0KPj4+IEkgc2VlIG5vIG5lZWQgaW4gdGhpcyBzaW5jZSBjbGsgaXMgZ2Vu
ZXJpYyBuYW1lIGFuZCB0aGlzIGRyaXZlciBjYW4NCj4+PiBhY2NlcHQgb25seSBvbmUgY2xv
Y2sgd2l0aCBhbnkgbmFtZS4NCj4+DQo+PiBJdCdzIGdvb2QgZG9jdW1lbnRhdGlvbi4gSXQg
bWFrZXMgaXQgY2xlYXIgd2hhdCB0aGUgcHVycG9zZSBvZiB0aGUgbWVtYmVyIGlzLg0KPj4N
Cj4gVGhpcyBkcml2ZXIgdXNlcyBhIHNpbmdsZSAoMSkgY2xvY2sgd2l0aCBhIHNpbmdsZSBw
dXJwb3NlLg0KPiANCj4gV2h5IGRvIHlvdSB0aGluayB5b3UgbmVlZCBhIGNsb2NrIGluIGEg
Y2xvY2stZ3BpbyBkcml2ZXI/IEhtLCBJIGRvbid0DQo+IGtub3cuIFRoaXMgd2lsbCByZW1h
aW4gYSBteXN0ZXJ5IGZvciBmdXR1cmUgYXJjaGVvLWNvZGVycyB5ZWFoLg0KDQpJZiB5b3Ug
ZG9uJ3Qgd2FudCB0byBjaGFuZ2UgdGhlIG5hbWUsIHRoZW4gYWRkIGEgZG9jIGNvbW1lbnQu
DQoNCj4+Pj4+ICAgICB9Ow0KPj4+Pj4NCj4+Pj4+ICAgICBzdGF0aWMgaW50IGNsa19ncGlv
X2VuYWJsZShzdHJ1Y3QgY2xrICpjbGspDQo+Pj4+PiAgICAgew0KPj4+Pj4gICAgICAgICBz
dHJ1Y3QgY2xrX2dwaW9fcHJpdiAqcHJpdiA9IGRldl9nZXRfcHJpdihjbGstPmRldik7DQo+
Pj4+Pg0KPj4+Pj4gKyAgICAgY2xrX3ByZXBhcmVfZW5hYmxlKHByaXYtPmNsayk7DQo+Pj4+
DQo+Pj4+IEp1c3QgY2xrX2VuYWJsZSBpcyBmaW5lLiBXZSBkb24ndCBoYXZlIGEgc2VwYXJh
dGUgcHJlcGFyZSBzdGFnZSBsaW5lIExpbnV4Lg0KPj4+Pg0KPj4+IFUtQm9vdCBzdXBwb3J0
cyBjbGtfcHJlcGFyZV9lbmFibGUgYW5kIHNpbmNlIHRoaXMgc3VwcG9ydCBpcyBwcmVzZW50
IEkNCj4+PiBzZWUgbm8gY29udHJhZGljdGlvbiBpbiB1c2luZyBpdC4NCj4+DQo+PiBUaGVz
ZSBmdW5jdGlvbnMgYXJlIG9ubHkgdGhlcmUgZm9yIHRvIG1ha2UgaXQgZWFzaWVyIHRvIHBv
cnQgY29kZSBmcm9tIExpbnV4Lg0KPj4gU2luY2UgdGhpcyBjb2RlIHdhcyB3cml0dGVuIGZv
ciBVLUJvb3QsIGp1c3QgdXNlIHRoZSBhY3R1YWwgZnVuY3Rpb24uDQo+Pg0KPiBUaGVuIGRv
Y3VtZW50IHRoYXQgaXRzIHVzZSBpcyBkaXNjb3VyYWdlZC4gVW50aWwgdGhlbiBpdCBpcyBu
b3QgcmVzdHJpY3RlZC4NCg0KVGhlcmUgYXJlIG1hbnkgZnVuY3Rpb25zIGxpa2UgdGhpcyBp
biBVLUJvb3QgKGUuZy4ga21hbGxvYyB3aGljaCB0YWtlcyBhbiB1bnVzZWQNCmZsYWdzIGFy
Z3VtZW50LCBvciBhbGwgdGhlIHByXyogZnVuY3Rpb25zIHdoaWNoIGFyZSBhbG1vc3QtYnV0
LW5vdC1xdWl0ZSB0aGUNCnNhbWUgYXMgbG9nXyopLiBOb3QgYWxsIG9mIHRoZW0gYXJlIGV4
cGxpY2l0bHkgZG9jdW1lbnQgYXMgc3VjaCwgYnV0IGdlbmVyYWxseQ0KeW91IHNob3VsZCB1
c2UgdGhlIG5hdGl2ZSBmdW5jdGlvbnMgd2hlcmUgaXQgaXMgbm90IGluY29udmVuaWVudC4N
Cg0KLS1TZWFuDQo=
