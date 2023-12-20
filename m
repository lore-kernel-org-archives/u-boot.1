Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BC66C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 20:03:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7A0718781C;
	Wed, 20 Dec 2023 21:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N0IB0icE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1A1698783C; Wed, 20 Dec 2023 21:03:17 +0100 (CET)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 06B9187811
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 21:03:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4260ba19a57so51912791cf.3
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 12:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703102594; x=1703707394; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aGsm8D4GbxDZpYnTcApwE0q5nAEnbm6tujnCGn4rZtw=;
 b=N0IB0icELtBCRsFrL/jftGtLhSgh9MNfwszj2wGfmcdDebBG2wXR246ZrMHIup7ZMp
 GKZa8RoWtWX/zS1SkELBOD9wYYSnpF/qmcgq/+bqbJ3Ci/NeafcudggsVlWoMyMBpod7
 uyLFKL35nNBngUYvoZjhR1phxBA4vBOPYint88yblkMNbFQApxpDKfujgBn6/W3/yVo1
 xyVL2UCa2HJL39k3qjttHo1NuvfmcgK2zhUNB0I5qkeahTWimfOkKrwnNC46xV9oQumX
 pxj6tRp+q0qwV7apNfwLPMBY5/IBmi70b95oJBrwhvwcIREilHlRebpYjEYq05UgJuTY
 ozFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703102594; x=1703707394;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aGsm8D4GbxDZpYnTcApwE0q5nAEnbm6tujnCGn4rZtw=;
 b=SKHNkkU1yRlcJXfsoNq18eWBuZ2Y5YCUYr24L3g3dUsY3BL4Jji7CAUeEj7P4/DGJa
 RwNro2Gv7pDYF6QTcEj6xb4J+0Y/ZjbCVAg7dXWB8Z1Aj1kc5VqlgELfwDuNsfgyIr1k
 Je2IWR9wSmXt0H1DcpkkcMU2hUVRqWm29Sn/V4XzneWwxD15g/0svScM7aCYD3Lo9vNP
 +7FRhsqzF5Np9+HYVjcLuyJh6qdDSKYwsaEWKeCNOeTk62ZMDNYVSmRn5HDZlkBCvJHA
 ihluERyv8rhJ9DtWZUkdSANOswh43u4w1KxEr662DWEMqvheMJtDC6tu9DGqLGTQvgbT
 Ke+g==
X-Gm-Message-State: AOJu0Yyh+h+tcCsaEf18JFMGYKp46qr0KzK2KYe63r6Ls8633nu103iR
 eS1otwiNpKovJi7dAebimcdmhrnuDgyl4Q==
X-Google-Smtp-Source: AGHT+IHO+Qjrgws7ZcdROvlNnVYgsJhaESOhblD7kUM8kbv+Dys7QnF6nOCjfOWejJH3oJRxUx1+VA==
X-Received: by 2002:a05:622a:45:b0:425:a439:5f24 with SMTP id
 y5-20020a05622a004500b00425a4395f24mr27047966qtw.88.1703102593774; 
 Wed, 20 Dec 2023 12:03:13 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 fi8-20020a05622a58c800b004261956e72csm155832qtb.96.2023.12.20.12.03.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Dec 2023 12:03:13 -0800 (PST)
Message-ID: <cf0fea58-45f8-ba73-9652-2a501343e0c4@gmail.com>
Date: Wed, 20 Dec 2023 15:03:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Passing boot logs to Linux?
Content-Language: en-US
To: =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <Csokas.Bence@prolan.hu>,
 Dragan Simic <dsimic@manjaro.org>
Cc: Simon Glass <sjg@chromium.org>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Daniel Golle <daniel@makrotopia.org>, Mark Kettenis <mark.kettenis@xs4all.nl>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
 <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
 <16e633f9d4b1c426aaca510157479d65@manjaro.org>
 <51121aee-faca-4196-8532-719fb6ec9bdc@prolan.hu>
 <2c108e1ff92db2b74f5ccccd770872a7@manjaro.org>
 <5e0e71a5-f3c8-413e-96a3-a0b6edee928f@prolan.hu>
 <3900f4b15852d0af65635b3a794d34af@manjaro.org>
 <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <f22f86ec-987f-4404-8722-82270f1e8da8@prolan.hu>
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

T24gMTIvMjAvMjMgMTQ6MjQsIENzw7Nrw6FzIEJlbmNlIHdyb3RlOg0KPiBPbiAyMDIzLiAx
Mi4gMjAuIDk6MjksIERyYWdhbiBTaW1pYyB3cm90ZToNCj4+IE9uIDIwMjMtMTItMjAgMDg6
NTIsIENzw7Nrw6FzIEJlbmNlIHdyb3RlOg0KPj4+IE9uIDIwMjMuIDEyLiAyMC4gODowOSwg
RHJhZ2FuIFNpbWljIHdyb3RlOg0KPj4+PiBPbiAyMDIzLTEyLTIwIDA3OjQ5LCBDc8Oza8Oh
cyBCZW5jZSB3cm90ZToNCj4+Pj4+IEkgZG9uJ3QgdGhpbmsgdGhhdCB3b3VsZCBiZSBhIGh1
Z2UgcHJvYmxlbSwgTGludXggdXNlcnNwYWNlIGNhbiBmaWx0ZXINCj4+Pj4+IEFOU0kgY29u
dHJvbCBjb2RlcyBpZiBpdCB3YW50cyB0by4gRm9yIG5vdywgSSdkIGxpa2UgYSBieXRlLWZv
ci1ieXRlDQo+Pj4+PiBjb3B5IG9mIHRoZSBjb25zb2xlLCBhcy1pcywgcHJlc2VudGVkIHRv
IExpbnV4Lg0KPj4+Pg0KPj4+PiBCdXQgd291bGRuJ3QgcmVjb3JkaW5nIHRoZSBjb250cm9s
IHNlcXVlbmNlcyBhcy1pcyBhY3R1YWxseSBiZSBwcmV0dHkNCj4+Pj4gbXVjaCB1c2VsZXNz
P8KgIEZvciBleGFtcGxlLCBzb21lIHVzZXIgY2FuIHNwZW5kIGEgZmV3IG1pbnV0ZXMNCj4+
Pj4gc2Nyb2xsaW5nIHRocm91Z2ggdGhlIGJvb3QgbWVudSwgd2hpY2ggd291bGQgcHJvZHVj
ZSBhIGZhaXIgYW1vdW50IG9mDQo+Pj4+IG5lYXJseSB1c2VsZXNzIHJlY29yZGVkIGRhdGEu
DQo+Pj4+DQo+Pj4+IE1vcmVvdmVyLCBpZiBJJ20gbm90IHdyb25nLCB2aWV3aW5nIG9yIHBh
cnNpbmcgc3VjaCBhcy1pcyBkYXRhIHdvdWxkDQo+Pj4+IGFjdHVhbGx5IHJlcXVpcmUgcmVw
bGF5aW5nIHRoZSBjb250cm9sIHNlcXVlbmNlcywgdG8gcmVwcm9kdWNlIHRoZQ0KPj4+PiBh
Y3R1YWwgY29uc29sZSBjb250ZW50cyBhcyBpdCB3YXMgcmVjb3JkZWQsIHdoaWNoIHdvdWxk
IGJlIHF1aXRlDQo+Pj4+IGN1bWJlcnNvbWUuDQo+Pj4NCj4+PiBJdCAqaXMqIHVzZWxlc3Ms
IGJ1dCBtb3N0IG9mIHRoZSB0aW1lcyB0aGUgdXNlciB3b24ndCBiZSBzY3JvbGxpbmcgYXQN
Cj4+PiBhbGwgYW55d2F5cywgdGhhdCdzIHdoeSBJIGRvbid0IHRoaW5rIHRoZXNlIGZldyBl
eHRyYSBieXRlcyB3b3VsZCBiZSBhDQo+Pj4gcHJvYmxlbS4NCj4+DQo+PiBRdWl0ZSBmcmFu
a2x5LCB3aGVuIGl0IGNvbWVzIHRvIGNvbXB1dGluZyBpbiBnZW5lcmFsLCB0YWtpbmcgdGhl
ICJhaCwgaXQNCj4+IHByb2JhYmx5IHdvbid0IGhhcHBlbiIgYXBwcm9hY2ggaXNuJ3QgdGhl
IGJlc3QgdGhpbmcgdG8gZG8uwqAgV2Ugc2hvdWxkDQo+PiBhaW0gdG93YXJkIGNvdmVyaW5n
IHByb3Blcmx5IGV2ZW4gdGhlIGVkZ2UgY2FzZXMsIGlmIHlvdSBhZ3JlZS4NCj4gDQo+IFlv
dSdyZSBhYnNvbHV0ZWx5IHJpZ2h0OyBob3dldmVyLCBJIGRpZCBub3Qgc2F5ICJpdCB3b24n
dCBoYXBwZW4iLCBJDQo+IHNhaWQgdGhhdCBMaW51eCB1c2Vyc3BhY2UgY2FuIGdvIGRlYWwg
d2l0aCBpdCBpZiBpdCBoYXBwZW5zLCBhbmQgaWYgaXQNCj4gd2FudHMgdG8uIEFuZCB0aGF0
IGluIG15IG9waW5pb24sIHRoZSBiZXN0IGNvdXJzZSBvZiBhY3Rpb24gZm9yIFUtQm9vdA0K
PiBpcyB0byByZWNvcmQgKmV2ZXJ5dGhpbmcqIChhcyBpdCBkb2VzIG5vdyksIGFuZCB0aGVu
IHVzZXJzcGFjZSBjYW4NCj4gZGVjaWRlIHRvIGZpbHRlciBpdCBmb3IgZWcuIEFOU0kgY29k
ZXMuIEJ1dCBJIHRoaW5rIGl0J3MgYmVzdCB0byBrZWVwDQo+IHRoZSBVLUJvb3QgY29kZSBk
ZWFkIHNpbXBsZSwgYW5kIGFsc28gc3VwcGx5IHRoZSBtb3N0IGRhdGEgdG8gdXNlcnNwYWNl
Lg0KPiANCj4gDQo+Pj4gVGhhdCdzIHdoYXQgSSByZWFkIGFzIHdlbGwuIElzIHRoZXJlIHN1
cHBvcnQgZm9yIFUtYm9vdCB0byB3cml0ZSBhbmQNCj4+PiBMaW51eCB0byByZWFkIFBTdG9y
ZXM/DQo+Pg0KPj4gTm8gYW5kIHllcywgYnV0IFUtQm9vdCBjYW4gYWxyZWFkeSByZWFkIHBz
dG9yZS7CoCBQbGVhc2Ugc2VlDQo+PiBkb2MvdXNhZ2UvY21kL3BzdG9yZS5yc3QgZm9yIHRo
ZSBVLUJvb3QgcGFydCwgYW5kDQo+PiBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL3BzdG9y
ZS1ibGsucnN0IGZvciB0aGUgTGludXgga2VybmVsIHBhcnQuDQo+IA0KPiBJcnJlbGV2YW50
LCBhcyB3ZSBvbmx5IHdhbnQgdG8gd3JpdGUgb3V0IHRoZSBjb25zb2xlIGxvZyB0byBVLUJv
b3QsIGFuZA0KPiBub3QgdGhlIG90aGVyIHdheSBhcm91bmQgKHRoYXQncyBmb3IgY29sbGVj
dGluZyBwYW5pYyBsb2dzLCB3aGljaCBpcw0KPiBhbHJlYWR5IGltcGxlbWVudGVkKS4NCj4g
DQo+PiBBbm90aGVyIGJlbmVmaXQgb2YgdXNpbmcgcHN0b3JlIHdvdWxkIGJlIG5vIHBlcm1h
bmVudGx5IHdhc3RlZCBSQU0gZm9yDQo+PiB0aGUgcmVjb3JkZWQgY29uc29sZSBjb250ZW50
cy7CoCBBbHNvLCBoYXZpbmcgdGhlIGRhdGEgcmVjb3JkZWQgdG8gYQ0KPj4gc3RvcmFnZSBk
ZXZpY2UgYWxzbyBnb2VzIGFsb25nIHdpdGggcHJvdmlkaW5nIHBlcm1hbmVudCByZWNvcmRz
Lg0KPiANCj4gSSdtIHBvc2l0aXZlbHkgKm5vdCBnb25uYSBzYXZlIGJvb3QgbG9ncyB0byBk
aXNrKiwgYXMgbW9zdCBlbWJlZGRlZA0KPiBzeXN0ZW1zIGhhdmUgRmxhc2gtYmFzZWQgc3Rv
cmFnZSBtZWRpYTsgd3JpdGluZyB0byB0aGVtIG9uIGV2ZXJ5IGJvb3QNCj4gd291bGQgYmUg
ZGV2YXN0YXRpbmcuIFBsdXMsIEkgZG9uJ3Qgd2FudCB0aGUgY29uc29sZSBzdWJzeXN0ZW0g
dG8gZGVwZW5kDQo+IG9uIGFueSBmaWxlL2Rpc2sgb3BlcmF0aW9ucy9kcml2ZXJzLg0KDQpw
c3RvcmUgaXMgYWdub3N0aWMgdG8gdGhlIGJhY2tlbmQgdXNlZC4gSW4gVS1Cb290IHdlIG9u
bHkgc3VwcG9ydCBSQU0NCmJhY2tlbmRzIGF0IHRoZSBtb21lbnQuDQoNCi0tU2Vhbg0KDQo=

