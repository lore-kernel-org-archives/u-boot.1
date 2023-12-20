Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A985C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 04:45:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B8BD86E05;
	Wed, 20 Dec 2023 05:45:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i5ZJKIGQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C916F86E5E; Wed, 20 Dec 2023 05:45:52 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C5E5386D2B
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:45:50 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-67f61c5f3b1so6721476d6.0
 for <u-boot@lists.denx.de>; Tue, 19 Dec 2023 20:45:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703047549; x=1703652349; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Inz4rRznEvZJzXOkOE9OwuQnDV6sf4eRmxLlNiIso7M=;
 b=i5ZJKIGQNRjdOOfDzuq7IzzHdZr795PpxsQAemuCfhzOoI8vCG2+A2oFeS6kLYAKHD
 GuMw9wl+X84t+gWCCqnbvCzmoO3IJhsyTgDwGK7t6IG10Dq54U2R9POPnhWCJDed5T/9
 IAVtzzwTGD3+hbVmgF7qxJA8vxBu9u75Qbh5ChvFFRDwA7voYo8lgDWd4kqBLiTYv9MF
 /M/R/kNWn0uXI/wrPekcZzjEvUh549gk3eHWKEGsVX1WWy89ystEDxCt4a0z6CaEJUJQ
 /539R26K8nLcfGrvaLdZdBQfQsf7iyWqGGVzos7ORrE8dzMuyX83oRzPr1IC400ZUsYp
 lMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703047549; x=1703652349;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Inz4rRznEvZJzXOkOE9OwuQnDV6sf4eRmxLlNiIso7M=;
 b=BJLau63BrtNCjUXhO1KgRiUXU+mlow4gyKJuDSU+fkmiq5sB3tY+VKZrix/R1pRNk1
 39u87CDdd+0zHDio1MAfG7RT7/sYc8Cqf0hicXVU9+H72vX/Yc1YWiPZQisTVpA0VjA+
 6MyxG+o2Df4JcMGA2Khs+wWr8h+3l8UrbW1GNnhLvP0F/5pAjU04BvzWfUoM+CZeMv2N
 Iym32Atn3j24tS36NuqDbA12wvYb1S80R/tScJI0ORVHLe9GdZqrdsfjndANb05BkY8f
 B+ODUpTKW/ZJbZUjNVOTus5MDHucr1o0wM8aXXYS80xYz9MLVjhuDbqq3B/LCThdk9KQ
 oreA==
X-Gm-Message-State: AOJu0YxoSv2JhhQViwyboT1KsJuOO0DbVkrxZD5ohme36EDqJNDkCCZJ
 Ap9toIyeu2ZnONx0TPgZPuY=
X-Google-Smtp-Source: AGHT+IFLZZlygK9oTHnCzHqvL3zpTnLFU0GYI6AYC+fChnhEZMZc63Zt1FDrWqyBfpRoTKES8S7iLw==
X-Received: by 2002:a05:6214:258a:b0:67f:3261:6384 with SMTP id
 fq10-20020a056214258a00b0067f32616384mr5413919qvb.50.1703047549446; 
 Tue, 19 Dec 2023 20:45:49 -0800 (PST)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 c16-20020a0ce650000000b0067f59ddb658sm1354970qvn.37.2023.12.19.20.45.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 20:45:49 -0800 (PST)
Message-ID: <6ae238be-3c5f-5ef6-9e18-282be9ae24c2@gmail.com>
Date: Tue, 19 Dec 2023 23:45:48 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: Passing boot logs to Linux?
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?=
 <Csokas.Bence@prolan.hu>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>
References: <6fd0dd4c-4bce-47cf-a669-7d093b9a1f10@prolan.hu>
 <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAPnjgZ01=y-Kf=XmDv6UyEdPgXLp8bhZnSZDBVk1FPfBh8CdOw@mail.gmail.com>
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

T24gMTIvMTkvMjMgMjM6MTEsIFNpbW9uIEdsYXNzIHdyb3RlOg0KPiBIaSBDc8Oza8OhcywN
Cj4gDQo+IE9uIFR1ZSwgMTkgRGVjIDIwMjMgYXQgMTM6MTUsIENzw7Nrw6FzIEJlbmNlIDxD
c29rYXMuQmVuY2VAcHJvbGFuLmh1PiB3cm90ZToNCj4+DQo+PiBIaSENCj4+DQo+PiBJcyBw
YXNzaW5nIHRoZSBVLUJvb3QgYm9vdCBsb2cgdG8gTGludXggc3VwcG9ydGVkIHlldD8gV2Ug
YXJlIHdvcmtpbmcNCj4+IHdpdGggYSB0aGlyZC1wYXJ0eSBzb2x1dGlvbiwgd2hpY2ggd29y
a3MsIGJ1dCBpcyBhIGJpdCBoYWNreSwgc28gSSB3YXMNCj4+IHdvbmRlcmluZyBpZiBhbiBv
ZmZpY2lhbCBzb2x1dGlvbiBoYXMgYmVlbiBtZXJnZWQgeWV0Lg0KPj4NCj4+IEkgc2F3IHRo
YXQgdGhlcmUgd2FzIGFuIG9wdGlvbiBDT05GSUdfQ09OU09MRV9SRUNPUkQgdGhhdCBzYXZl
cw0KPj4gZXZlcnl0aGluZyB0byBhIG1lbWJ1ZmYsIGJ1dCBJIGRvbid0IGtub3cgaWYgdGhh
dCBjYW4gYmUgZXhwb3J0ZWQgdG8NCj4+IExpbnV4IHlldC4gQW5kIGlmIG5vdCBpbiB0aGUg
dHJlZSB5ZXQsIHdvdWxkIHN1Y2ggYSBwYXRjaCBiZSB3ZWxjb21lPw0KPiANCj4gTm90IHll
dCwgYnV0IHllcyBJIHdvdWxkIGxpa2UgdG8gc2VlIHRoaXMuDQoNCkkgdGhpbmsgbW9zdCBv
ZiB0aGUgaW5mcmFzdHJ1Y3R1cmUgaXMgYWxyZWFkeSBoZXJlLiBXZSBjb3VsZCB1c2UgZWl0
aGVyDQpjb25zb2xlIHJlY29yZGluZyAoYXMgbWVudGlvbmVkIGFib3ZlKSwgd2hpY2ggaXMg
bW9yZSBjb21wbGV0ZSwgb3IgYSBuZXcNCkxPR19EUklWRVIgKHdoaWNoIHdvdWxkIGhhdmUg
dGhlIGFkdmFudGFnZSBvZiBvbWl0dGluZyB0aGluZ3MgbGlrZSBjb3VudGRvd25zKS4NCg0K
SW4gdGVybXMgb2Ygc2VuZGluZyB0aGluZ3MgdG8gTGludXgsIEkgdGhpbmsgdGhlIG5hdHVy
YWwgY2hvaWNlIHdvdWxkIGJlIHBzdG9yZSwNCndoaWNoIHdlIGFscmVhZHkgaGF2ZSBhIHBh
cnNlciBmb3IuDQoNCi0tU2Vhbg0K
