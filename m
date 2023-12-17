Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6FEC3DA6E
	for <u-boot@archiver.kernel.org>; Sun, 17 Dec 2023 14:38:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 103A1876F0;
	Sun, 17 Dec 2023 15:38:36 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PKKCBlyf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 147A887743; Sun, 17 Dec 2023 15:38:33 +0100 (CET)
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com
 [IPv6:2607:f8b0:4864:20::830])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E295876E9
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 15:38:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-425c54f5842so23195251cf.2
 for <u-boot@lists.denx.de>; Sun, 17 Dec 2023 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1702823909; x=1703428709; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zZ0fhcitCRiRDad4OFaDYAndmS8VcvUWMhm8lq8xBZk=;
 b=PKKCBlyf6FeIESKwffjC1lcOWOsB/YmuPbOUMBk2k8L62DbjE/km0tPd78keXYCOVR
 iSTP5/AZjGLuylXlgmeoWnyOm05J8vzXDamK3HP3Rw8nHnx5FIXQ7fW8GSaFhG1mLukD
 0visjLunL4qwWR1RuY8rTvgNCFXT//fVQr0tNrC6YsHd+C50VA7Rz2+GPlOFqfg/nyqO
 1MNAwAYLyl5Pi4WPt2tGTs+14ctQk4rscLh2QRnYfHKHs2Urm5QJwCq4Q4ixzWc+/+W2
 ve7fDj/DerzfbEnIFGmS2Pr6bl8K0ulAUHEski9nCDewu2EZWXVMc9YnoHl+GiRte5Va
 /mvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702823909; x=1703428709;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zZ0fhcitCRiRDad4OFaDYAndmS8VcvUWMhm8lq8xBZk=;
 b=H5/OrX1l3hRoJj31IpcFKy5YHpg1xbGVKx3KIvB7SLyhnpXeS1eb4x9Ei0KnO4hQsA
 OEIRfwjhaywrctPav2cGiZRFoewVeHIf8MZMtArQbnT7ANtTBwoaHA8OZu/j5xfwklE3
 Ur0WZ9xux7TbmCq/DtjEYvg93IUP1jmJ/I77Hl1IDko/JYIWtpEddDglSCI/SsBAkq+E
 YBE2Gduyvi1LNfwSowzTDzvidRisDQwfPA1S2g4BVdnuDRvzZ5F763XBG2BWF9dw6nt6
 gvXB/fVTkB/VjPnJ5xE+XLE8Uao3i7LyLu+vgdcAUTc8RlLvtSsoUJDb5rMvgeENB0wR
 Y1Kg==
X-Gm-Message-State: AOJu0Yyd/bEAvqCamsqeBeLNKkm8YHPeTfWsidRsiCnANWGGquOw+Iox
 eKKbZbwNg+m6PH8UM3xuRUY=
X-Google-Smtp-Source: AGHT+IFKIuidclRZQgSLrX1JeGT/d4OS8+NmV6TvHT9CEjxGhS4HsuSw+OsumigEks3YcyjcKnhHaQ==
X-Received: by 2002:a05:622a:11c5:b0:423:f353:9ce1 with SMTP id
 n5-20020a05622a11c500b00423f3539ce1mr19469435qtk.31.1702823909290; 
 Sun, 17 Dec 2023 06:38:29 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 fv5-20020a05622a4a0500b004275e9cdf15sm183333qtb.11.2023.12.17.06.38.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 06:38:28 -0800 (PST)
Message-ID: <28ee700e-120a-bb8d-9ca2-493d6a371405@gmail.com>
Date: Sun, 17 Dec 2023 09:38:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [NEXT] Pull request for efi-next-20231217
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>, Tom Rini <trini@konsulko.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 AKASHI Takahiro <takahiro.akashi@linaro.org>
References: <2836e8ee-2a9d-4d8f-848f-ce77ac8bf080@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <2836e8ee-2a9d-4d8f-848f-ce77ac8bf080@gmx.de>
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

T24gMTIvMTcvMjMgMDg6NDcsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+IERlYXIg
VG9tLA0KPiANCj4gVGhpcyBwdWxsIHJlcXVlc3QgaWYgZm9yIHRoZSBuZXh0IGJyYW5jaC4N
Cj4gDQo+IFRoZSBmb2xsb3dpbmcgY2hhbmdlcyBzaW5jZSBjb21taXQgY2Q5NDgyMTAzMzI3
ODNjMmIxYzZkMTBhOTgyYTgwYzBkYTRmNjliOToNCj4gDQo+ICDCoCBSZXZlcnQgImJvYXJk
OiB0aTogYW02MngvYW02MmF4OiBVcGRhdGUgdmlydHVhbCBpbnRlcnJ1cHQgYWxsb2NhdGlv
bnMNCj4gaW4gYm9hcmQgY29uZmlnIiAoMjAyMy0xMi0xNSAyMDoyMzo1OSAtMDUwMCkNCj4g
DQo+IGFyZSBhdmFpbGFibGUgaW4gdGhlIEdpdCByZXBvc2l0b3J5IGF0Og0KPiANCj4gIMKg
IGh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L2N1c3RvZGlhbnMvdS1ib290LWVmaS5n
aXQNCj4gdGFncy9lZmktbmV4dC0yMDIzMTIxNw0KPiANCj4gZm9yIHlvdSB0byBmZXRjaCBj
aGFuZ2VzIHVwIHRvIDI5MWFiOTE5MzU1ZGY1ZWUyODE4MzU0NjA0OWQ1ZmJkYjI3NzdkMmQ6
DQo+IA0KPiAgwqAgZG9jOiBSZXBsYWNlIGV4YW1wbGVzIG9mIE1ENSBhbmQgU0hBMSB3aXRo
IFNIQTI1NiAoMjAyMy0xMi0xNw0KPiAxMzowNjo0OCArMDEwMCkNCj4gDQo+IEdpdGxhYiBD
SSBzaG93ZWQgbm8gaXNzdWVzOg0KPiANCj4gaHR0cHM6Ly9zb3VyY2UuZGVueC5kZS91LWJv
b3QvY3VzdG9kaWFucy91LWJvb3QtZWZpLy0vcGlwZWxpbmVzLzE4OTkwDQo+IA0KPiAtLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tDQo+IFB1bGwgcmVxdWVzdCBmb3IgZWZpLW5leHQtMjAyMzEyMTcNCj4gDQo+IERv
Y3VtZW50YXRpb246DQo+IA0KPiAqIHJlcGxhY2UgTUQ1IGFuZCBTSEExIGJ5IFNIQTI1NiBp
biBleGFtcGxlcw0KPiANCj4gVUVGSToNCj4gDQo+ICogUmVmYWN0b3IgYm9vdCBtYW5hZ2Vy
IGFuZCBib290ZWZpIGNvbW1hbmQgdG8gbGV0IHRoZSBFRkkgYm9vdCBtZXRob2QNCj4gd29y
ayB3aXRob3V0IHNoZWxsLg0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBBS0FTSEkgVGFrYWhpcm8g
KDgpOg0KPiAgwqDCoMKgwqDCoCBjbWQ6IGJvb3RlZmk6IHVuZm9sZCBkb19ib290ZWZpX2lt
YWdlKCkNCj4gIMKgwqDCoMKgwqAgY21kOiBib290ZWZpOiByZS1vcmdhbml6ZSBkb19ib290
ZWZpKCkNCj4gIMKgwqDCoMKgwqAgY21kOiBib290ZWZpOiBjYXJ2ZSBvdXQgRUZJIGJvb3Qg
bWFuYWdlciBpbnRlcmZhY2UNCj4gIMKgwqDCoMKgwqAgY21kOiBib290ZWZpOiBjYXJ2ZSBv
dXQgYmluYXJ5IGV4ZWN1dGlvbiBpbnRlcmZhY2UNCj4gIMKgwqDCoMKgwqAgY21kOiBib290
ZWZpOiBsb2NhbGl6ZSBnbG9iYWwgZGV2aWNlIHBhdGhzIGZvciBlZmlfc2VsZnRlc3QNCj4g
IMKgwqDCoMKgwqAgY21kOiBib290ZWZpOiBtb3ZlIGxpYnJhcnkgaW50ZXJmYWNlcyB1bmRl
ciBsaWIvZWZpX2xvYWRlcg0KPiAgwqDCoMKgwqDCoCBjbWQ6IGVmaWRlYnVnOiBlYXNlIGVm
aSBjb25maWd1cmF0aW9uIGRlcGVuZGVuY3kNCj4gIMKgwqDCoMKgwqAgYm9vdG1ldGg6IHVz
ZSBlZmlfbG9hZGVyIGludGVyZmFjZXMgaW5zdGVhZCBvZiBib290ZWZpIGNvbW1hbmQNCj4g
DQo+IFNlYW4gQW5kZXJzb24gKDEpOg0KPiAgwqDCoMKgwqDCoCBkb2M6IFJlcGxhY2UgZXhh
bXBsZXMgb2YgTUQ1IGFuZCBTSEExIHdpdGggU0hBMjU2DQoNCkZZSSB0aGVyZSBpcyBhIHYy
IG9mIHRoaXMsIGJ1dCBpcyBtb3N0bHkganVzdCBleHBhbmRzIHRoZSBjb21taXQgbWVzc2Fn
ZS4gSSBhbQ0KZmluZSBzZW5kaW5nIGEgZm9sbG93LXVwIHBhdGNoLg0KDQotLVNlYW4NCg0K
PiAgwqBib290L0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICstDQo+ICDCoGJvb3QvTWFrZWZpbGXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKg
wqAgMiArLQ0KPiAgwqBib290L2Jvb3RtX29zLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgMzIgKy0NCj4gIMKgYm9vdC9ib290bWV0
aF9lZmkuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCA4ICstDQo+ICDCoGJvb3QvYm9vdG1ldGhfZWZpX21nci5jwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstDQo+ICDCoGNtZC9LY29uZmlnwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAg
MTYgKy0NCj4gIMKgY21kL2Jvb3RlZmkuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8IDY3MA0KPiArKysrKy0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tDQo+ICDCoGNtZC9lZmlkZWJ1Zy5jwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCA0ICstDQo+ICDCoGRvYy9j
aHJvbWl1bS9maWxlcy9jaHJvbWVib29rX2plcnJ5Lml0c8KgIHzCoMKgIDQgKy0NCj4gIMKg
ZG9jL2Nocm9taXVtL2ZpbGVzL255YW4tYmlnLml0c8KgwqDCoMKgwqDCoMKgwqDCoCB8wqDC
oCA0ICstDQo+ICDCoGRvYy91c2FnZS9jbWQvaW14dHJhY3QucnN0wqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCB8wqDCoCA2ICstDQo+ICDCoGRvYy91c2FnZS9maXQvYmVhZ2xlYm9u
ZV92Ym9vdC5yc3TCoMKgwqDCoMKgwqAgfMKgIDc0ICsrLS0NCj4gIMKgZG9jL3VzYWdlL2Zp
dC9ob3d0by5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA0MCAr
LQ0KPiAgwqBkb2MvdXNhZ2UvZml0L2tlcm5lbC5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoCA2ICstDQo+ICDCoGRvYy91c2FnZS9maXQva2VybmVsX2ZkdC5y
c3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNCArLQ0KPiAgwqBkb2MvdXNhZ2Uv
Zml0L2tlcm5lbF9mZHRzX2NvbXByZXNzZWQucnN0IHzCoMKgIDYgKy0NCj4gIMKgZG9jL3Vz
YWdlL2ZpdC9tdWx0aS13aXRoLWZwZ2EucnN0wqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArLQ0K
PiAgwqBkb2MvdXNhZ2UvZml0L211bHRpLXdpdGgtbG9hZGFibGVzLnJzdMKgwqAgfMKgwqAg
OCArLQ0KPiAgwqBkb2MvdXNhZ2UvZml0L211bHRpLnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgfMKgIDEyICstDQo+ICDCoGRvYy91c2FnZS9maXQvc2lnbi1jb25m
aWdzLnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDYgKy0NCj4gIMKgZG9jL3VzYWdl
L2ZpdC9zaWduLWltYWdlcy5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDQgKy0N
Cj4gIMKgZG9jL3VzYWdlL2ZpdC9zaWduYXR1cmUucnN0wqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgfMKgIDIyICstDQo+ICDCoGRvYy91c2FnZS9maXQvdXBkYXRlMy5yc3TCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgNiArLQ0KPiAgwqBkb2MvdXNhZ2UvZml0
L3VwZGF0ZV91Ym9vdC5yc3TCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqDCoCAyICstDQo+ICDC
oGRvYy91c2FnZS9maXQveDg2LWZpdC1ib290LnJzdMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzC
oMKgIDggKy0NCj4gIMKgaW5jbHVkZS9lZmlfbG9hZGVyLmjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCAxMiArLQ0KPiAgwqBsaWIvZWZpX2xvYWRlci9l
ZmlfYm9vdG1nci5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgNTMwICsrKysrKysrKysr
KysrKysrKysrKysrKw0KPiAgwqB0ZXN0L2Jvb3QvYm9vdGZsb3cuY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgwqAgMiArLQ0KPiAgwqAyOCBmaWxlcyBj
aGFuZ2VkLCA3NzEgaW5zZXJ0aW9ucygrKSwgNzI5IGRlbGV0aW9ucygtKQ0KDQo=
