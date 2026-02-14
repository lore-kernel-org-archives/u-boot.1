Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2080DEF99F4
	for <u-boot@archiver.kernel.org>; Sat, 14 Feb 2026 02:55:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 597D083642;
	Sat, 14 Feb 2026 03:55:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iggEyr+B";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AD8A883642; Sat, 14 Feb 2026 03:55:49 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 77BD383015
 for <u-boot@lists.denx.de>; Sat, 14 Feb 2026 03:55:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-8946421dd8fso1979706d6.0
 for <u-boot@lists.denx.de>; Fri, 13 Feb 2026 18:55:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771037746; x=1771642546; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BLTv+8nou6UKqEvA9dLw6dtxIn5TtS2MsxX1CQzP/ng=;
 b=iggEyr+Bfb/4Cr8QVRK1vSl5/0NquHeuQVE5TmkXshwpLiOw+cOsmL1N2WSFuzO3BP
 wnFoIBMsFS6OjdIncIi2MEKahkxvJ5kbWxEDq+8HjLpnEHiOYyWyoxD7cfrzloQEkPXl
 awQhEUS2HJeO2jp/1jSeiLW2uWECQD/+TW6mDuq7BFh2zkgPvLS7bLS9yvDsY/jB53pO
 m5PkaWQZiLLHoibN2T1Dgk9jZ6CaMoPeLNr5lK1Hhc+WeU90zEdkqAorc+R+XqRcn3uc
 HJFGsHyrQbnZrB+FX/5sXaIevh9LKONH1MWjVG60XkVBrpgGPilQQ+OsTr1TfQfX1VDh
 JbpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771037746; x=1771642546;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BLTv+8nou6UKqEvA9dLw6dtxIn5TtS2MsxX1CQzP/ng=;
 b=ikAq1hJDZF1h2zGag24D7bswV5TECdBYe1nrKeDB+bVYvgpexu4ZY8hsadVHxVaViw
 dAvNE7HJMPvwyLVEQU7Z0pTAwQu7YBJjj3Dh8Svp7CKRPQFhIddM5ZGeTXltP8FvoN5k
 xkAHcAEJ3qMolXwIhTspHif7snfUf5PLhHdAy5iDdJ1aBYJLR2g4S6E22uxVUKx2uqGP
 teF3HCUs+zSTeo81MNfH/yh0u7No7tDVK0ocVe0Sxaw/8/mU6sPybtkhVlDV26A1vB3K
 HCLmUlPHmvlsrtLdEK4jPDnlfPW4TQSKtsp9UsPMixE9kzGWShO5YIx9rLAuHcPyNv35
 CMlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAZpFWJAbyZEYQLgkxxhjvRoB7taKPzw5rj5rB1FXdy7rUBLsQ788ZQNeIYTofaHw5xKCpmbA=@lists.denx.de
X-Gm-Message-State: AOJu0YwWMjEd5UwGCWIyDExer6NiIiYCljCEf0ziPaouQp6XAVTTtvNI
 L3O8m4Ha/1ZR3QMlK7rdTmkZwb1TryHoKiIOUdFgupD+LoBX940mV5pD1b4tfA==
X-Gm-Gg: AZuq6aJxLlJYq4AetnAam5RSr3M2wkQLR9/rpd/5sb+u+YkPES887+X8TGJP+M4B5Qu
 04YSdx8r9ZrvuDMMOZFbk9zjuEoNPq5A7/s4AWZpufpeamH68AkzyNrJ72CAj9bLNOga+dYkcl6
 dy02eQAWQxtnE6X9OP6/akVD8lSrh0We03PiNI0Nc56zzMI3JAvUdh2EoonTUw2uArKTkyRoAGl
 he5UuWQC1+DYgk73EfoFDLgCye6rXUv0HMlZRrJdECy0lYpWjsV6l5Eye1sznIY6F4AXjf7RgGE
 Z+yz4USwH+Ms9ellXMVAJYEpPtNdq0qPoYtVQOlWUVABHWCHtcPoro6HKBj3lriclvEqv8l3bkS
 uGG3q/FRIv/GE2G2vTP8HqizTkc0KyvDaxzMYogwUihWofNaAyIWEZO3F0BwIZKd5i4vmQ64v6p
 y2Oe0lW2YGYqaJLRH0Oe4tq2mgoc5CpQN7egrdOkhwVRYAQKfMPzdADiFY7JmvHpYST64=
X-Received: by 2002:a05:620a:1714:b0:8c7:110c:762f with SMTP id
 af79cd13be357-8cb40850a6cmr442459785a.4.1771037746076; 
 Fri, 13 Feb 2026 18:55:46 -0800 (PST)
Received: from ?IPV6:2600:4040:4476:3800:2d8:61ff:fe7c:5d59?
 ([2600:4040:4476:3800:2d8:61ff:fe7c:5d59])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8cb2b004eecsm732098985a.0.2026.02.13.18.55.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Feb 2026 18:55:45 -0800 (PST)
Message-ID: <250c54fc-4838-7280-7fd2-f5e7b444ef9d@gmail.com>
Date: Fri, 13 Feb 2026 21:55:44 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/6] reboot-mode: Use actual cell size instead of
 sizeof(u32)
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: Aswin Murugan <aswin.murugan@oss.qualcomm.com>, u-boot@lists.denx.de,
 sumit.garg@kernel.org, casey.connolly@linaro.org, u-boot-qcom@groups.io
Cc: trini@konsulko.com, marek.vasut+renesas@mailbox.org,
 neil.armstrong@linaro.org, peng.fan@nxp.com, quentin.schulz@cherry.de,
 n-francis@ti.com, xypron.glpk@gmx.de, h-vm@ti.com, justin@tidylabs.net,
 jamie.gibbons@microchip.com, ycliang@andestech.com, me@samcday.com,
 sughosh.ganu@arm.com, gchan9527@gmail.com, ilias.apalodimas@linaro.org
References: <20260213112717.1256823-1-aswin.murugan@oss.qualcomm.com>
 <20260213112717.1256823-2-aswin.murugan@oss.qualcomm.com>
 <f66468a3-724f-2666-c043-84132ba84e3f@gmail.com>
In-Reply-To: <f66468a3-724f-2666-c043-84132ba84e3f@gmail.com>
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

T24gMi8xMy8yNiAxMDo0NiwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gT24gMi8xMy8yNiAw
NjoyNywgQXN3aW4gTXVydWdhbiB3cm90ZToNCj4+IFRoZSBudm1lbSByZWJvb3QtbW9kZSBk
cml2ZXIgaGFyZGNvZGVzIHNpemVvZih1MzIpIGZvciBOVk1FTSByZWFkL3dyaXRlDQo+PiBv
cGVyYXRpb25zLiBUaGlzIGZhaWxzIG9uIHBsYXRmb3JtcyB3aGVyZSB0aGUgcmVib290IHJl
YXNvbiBzdG9yYWdlIGlzDQo+PiBzbWFsbGVyIHRoYW4gNCBieXRlcy4NCj4+DQo+PiBPbiBR
dWFsY29tbSBwbGF0Zm9ybXMgd2l0aCBzaW5nbGUtYnl0ZSBQTUlDIHJlZ2lzdGVyIHN0b3Jh
Z2UsIGF0dGVtcHRpbmcNCj4+IHRvIHJlYWQgNCBieXRlcyBmcm9tIGEgMS1ieXRlIGNlbGwg
Y2F1c2VzIHRoZSBOVk1FTSBzdWJzeXN0ZW0gdG8gcmV0dXJuDQo+PiAtRUlOVkFMLCBicmVh
a2luZyByZWJvb3QtbW9kZSBmdW5jdGlvbmFsaXR5Lg0KPj4NCj4+IFJlcGxhY2Ugc2l6ZW9m
KCptb2RlKSBhbmQgc2l6ZW9mKG1vZGUpIHdpdGggcHJpdi0+Y2VsbC5zaXplIHRvIHVzZSB0
aGUNCj4+IGFjdHVhbCBOVk1FTSBjZWxsIHNpemUuIEFsc28gaW5pdGlhbGl6ZSAqbW9kZSB0
byAwIGluIHJlYm9vdF9tb2RlX2dldCgpDQo+PiB0byBlbnN1cmUgYSBjbGVhbiBzdGF0ZSBm
b3IgY2VsbHMgc21hbGxlciB0aGFuIHUzMi4NCj4+DQo+PiBUaGlzIGFsbG93cyB0aGUgZHJp
dmVyIHRvIHdvcmsgd2l0aCBjZWxscyBvZiBhbnkgc2l6ZSwgZnJvbSBzaW5nbGUgYnl0ZXMN
Cj4+IHRvIG11bHRpLWJ5dGUgd29yZHMuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQXN3aW4g
TXVydWdhbiA8YXN3aW4ubXVydWdhbkBvc3MucXVhbGNvbW0uY29tPg0KPj4gLS0tDQo+PiDC
oCBkcml2ZXJzL3JlYm9vdC1tb2RlL3JlYm9vdC1tb2RlLW52bWVtLmMgfCA1ICsrKy0tDQo+
PiDCoCAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0K
Pj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3JlYm9vdC1tb2RlL3JlYm9vdC1tb2RlLW52
bWVtLmMgYi9kcml2ZXJzL3JlYm9vdC1tb2RlL3JlYm9vdC1tb2RlLW52bWVtLmMNCj4+IGlu
ZGV4IGI5YWYyNDI1MjBhLi42MDMwN2NjZTQ5ZiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMv
cmVib290LW1vZGUvcmVib290LW1vZGUtbnZtZW0uYw0KPj4gKysrIGIvZHJpdmVycy9yZWJv
b3QtbW9kZS9yZWJvb3QtbW9kZS1udm1lbS5jDQo+PiBAQCAtMTgsMTUgKzE4LDE2IEBAIHN0
cnVjdCBudm1lbV9yZWJvb3RfbW9kZV9wcml2IHsNCj4+IMKgIHN0YXRpYyBpbnQgcmVib290
X21vZGVfZ2V0KHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiAqbW9kZSkNCj4+IMKgIHsNCj4+
IMKgwqDCoMKgwqAgc3RydWN0IG52bWVtX3JlYm9vdF9tb2RlX3ByaXYgKnByaXYgPSBkZXZf
Z2V0X3ByaXYoZGV2KTsNCj4+ICvCoMKgwqAgKm1vZGUgPSAwOw0KPj4gLcKgwqDCoCByZXR1
cm4gbnZtZW1fY2VsbF9yZWFkKCZwcml2LT5jZWxsLCBtb2RlLCBzaXplb2YoKm1vZGUpKTsN
Cj4+ICvCoMKgwqAgcmV0dXJuIG52bWVtX2NlbGxfcmVhZCgmcHJpdi0+Y2VsbCwgbW9kZSwg
cHJpdi0+Y2VsbC5zaXplKTsNCj4+IMKgIH0NCj4+IMKgIHN0YXRpYyBpbnQgcmVib290X21v
ZGVfc2V0KHN0cnVjdCB1ZGV2aWNlICpkZXYsIHUzMiBtb2RlKQ0KPj4gwqAgew0KPj4gwqDC
oMKgwqDCoCBzdHJ1Y3QgbnZtZW1fcmVib290X21vZGVfcHJpdiAqcHJpdiA9IGRldl9nZXRf
cHJpdihkZXYpOw0KPj4gLcKgwqDCoCByZXR1cm4gbnZtZW1fY2VsbF93cml0ZSgmcHJpdi0+
Y2VsbCwgJm1vZGUsIHNpemVvZihtb2RlKSk7DQo+PiArwqDCoMKgIHJldHVybiBudm1lbV9j
ZWxsX3dyaXRlKCZwcml2LT5jZWxsLCAmbW9kZSwgcHJpdi0+Y2VsbC5zaXplKTsNCj4+IMKg
IH0NCj4+IMKgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcmVib290X21vZGVfb3BzIG52bWVtX3Jl
Ym9vdF9tb2RlX29wcyA9IHsNCj4gDQo+IEknbSBub3Qgc3VyZSBhYm91dCB0aGlzLiBkcml2
ZXJzL3Bvd2VyL3Jlc2V0L252bWVtLXJlYm9vdC1tb2RlLmMgaW4gTGludXgNCj4gYWx3YXlz
IHdyaXRlcyBzaXplb2YodW5zaWduZWQgbG9uZyksIGFuZCB0aGlzIGlzIGNoZWNrZWQgYWdh
aW5zdCB0aGUgbnZtZW0NCj4gY2VsbCBsZW5ndGggaW4gX19udm1lbV9jZWxsX2VudHJ5X3dy
aXRlLiBXZSBzaG91bGQgdHJ5IHRvIGtlZXAgb3VyIGJlaGF2aW9yDQo+IGNsb3NlIHRvIExp
bnV4J3MuDQo+IA0KPiAtLVNlYW4NCg0KQWN0dWFsbHksIE5BQ0sgc2luY2UgdGhpcyBzbWFz
aGVzIHRoZSBzdGFjayB3aXRoIGEgY2VsbCBzaXplIHRoYXQgaXMgbGFyZ2VyIHRoYW4gNC4N
Cg0KLS1TZWFuDQo=
