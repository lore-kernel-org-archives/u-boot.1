Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53285CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:15:57 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B127186CE5;
	Thu, 12 Oct 2023 16:15:54 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z2TCAlT7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ADB4586D62; Thu, 12 Oct 2023 16:15:53 +0200 (CEST)
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com
 [IPv6:2607:f8b0:4864:20::82f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id ADA2C86CDD
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:15:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x82f.google.com with SMTP id
 d75a77b69052e-4181e268447so6569151cf.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697120146; x=1697724946; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fNCfX39dTVCm5Iu/EYAcPXnfc1ApSiIg35wzDmlJrT4=;
 b=Z2TCAlT78ARZVhEIF6aT/kNeVEhX8NmVaMzxLwM8FmoJ9bNexT6dFXY6i48NmGY/Q5
 mZwFuSUWUMskqcI2v0VKXCm4BvBbCbZ6FldUoFjk44Ki7RVAXfdq/htxlWSPqd/PMb4K
 KB76sbuTF2z7TCwCCSUhDrcav8WfvEMReBrmB0VJfeeMv2qhCeoglOO/Emd43QmTliY4
 c1FK9Tfd/u+EOhriJPYkRDGVk1I7u5hRRuYjTDcQTxljAhMw1rmtwZQpsXq7uTnjrLsh
 BhkNRF9mMHrAaecWzk56l3XYDsUbMf28Yg+IiqTFcdvLeHiBmsvOeUvqsP+WNoQNGdT7
 rSrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697120146; x=1697724946;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fNCfX39dTVCm5Iu/EYAcPXnfc1ApSiIg35wzDmlJrT4=;
 b=mt9JukfGAmPJJdBv+mPscb9Bgxvrx66A5tS6+MamJlxtC5F2WKzmKcmI0LbYUCmhBe
 hPyDKEx159RkFtWBnBQ0YpXlhHifPhdqcpmScr6UHjmvGSZnvCrg/81DMI0wxgnfusR/
 j4gyrx8ZcN4gN5LeOALpFH61PO6JSdc4csqr0lGur9tMBbA1Blt2Ojbda0cWM9nOa8Rr
 Hd2peYHaULo1FrofwRV3QS5eHs1L5ock1ja40bMYAXaNUbbQpJpjQ3oP0kUYWxOgLVpI
 vS+etkPgKduml9YGcrNrxi8tqGQ9ZglWlcQfAWhMhpbIBo8YbW6UJsm4pkBn88dSqLPb
 +1QQ==
X-Gm-Message-State: AOJu0Yy36asTsGN9bJqX5H5ALg5caoE27uQPqYskP7P+6yZsykzz5EXU
 C6Vm50/DJIqHRy3GqLKTRew=
X-Google-Smtp-Source: AGHT+IGLmXiIr2vRKyG8ClY1n+QzadRKrjMweANvzo6TkuyZ1AakGWi36o9aE7YoOvncHgC/aXTJig==
X-Received: by 2002:a05:622a:20b:b0:412:2ed3:38ec with SMTP id
 b11-20020a05622a020b00b004122ed338ecmr26223520qtx.18.1697120146310; 
 Thu, 12 Oct 2023 07:15:46 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 c14-20020ac853ce000000b0040331f93ee0sm6214617qtq.77.2023.10.12.07.15.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 07:15:46 -0700 (PDT)
Message-ID: <1cd1d618-ed29-2678-bca3-817c2ce18fba@gmail.com>
Date: Thu, 12 Oct 2023 10:15:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 12/26] fs: Compile in sandbox filesystem in SPL if it is
 enabled
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 u-boot@lists.denx.de, Tom Rini <trini@konsulko.com>
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-13-seanga2@gmail.com>
 <d1014630-c1fd-4443-9a2e-c7ae2d029bf2@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <d1014630-c1fd-4443-9a2e-c7ae2d029bf2@gmx.de>
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

T24gMTAvMTIvMjMgMDI6MzksIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+IE9uIDEw
LzEyLzIzIDAzOjU2LCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPj4gZnMuYyB0aGlua3MgdGhh
dCB0aGUgc2FuZGJveCBmaWxlc3lzdGVtIGlzIGF2YWlsYWJsZSBpZiBTQU5EQk9YIGlzIGVu
YWJsZWQsDQo+PiBidXQgaXQgaXMgbm90IGluIFNQTC4gQ29tcGlsZSBpdCBpbiBTUEwgdG8g
YXZvaWQgbGlua2VyIGVycm9ycy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBTZWFuIEFuZGVy
c29uIDxzZWFuZ2EyQGdtYWlsLmNvbT4NCj4+IC0tLQ0KPj4NCj4+IMKgIGZzL01ha2VmaWxl
IHwgMSArDQo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4+DQo+PiBk
aWZmIC0tZ2l0IGEvZnMvTWFrZWZpbGUgYi9mcy9NYWtlZmlsZQ0KPj4gaW5kZXggNGJlZDJm
ZjJkOTkuLjU5MmM3NTQyYmRlIDEwMDY0NA0KPj4gLS0tIGEvZnMvTWFrZWZpbGUNCj4+ICsr
KyBiL2ZzL01ha2VmaWxlDQo+PiBAQCAtOSw2ICs5LDcgQEAgb2JqLSQoQ09ORklHX0ZTX0xP
QURFUikgKz0gZnMubw0KPj4gwqAgb2JqLSQoQ09ORklHX1NQTF9GU19GQVQpICs9IGZhdC8N
Cj4+IMKgIG9iai0kKENPTkZJR19TUExfRlNfRVhUNCkgKz0gZXh0NC8NCj4+IMKgIG9iai0k
KENPTkZJR19TUExfRlNfQ0JGUykgKz0gY2Jmcy8NCj4+ICtvYmotJChDT05GSUdfU0FOREJP
WCkgKz0gc2FuZGJveC8NCj4gDQo+IFdoeSB3b3VsZG4ndCB5b3UgdXNlIENPTkZJR19TQU5E
Qk9YX1NQTCBoZXJlPw0KDQpCZWNhdXNlIHRoYXQncyB3aGF0IHRoZSBjaGVjayBpcyBpbiBm
cy5jLiBNYXliZSBpdCBzaG91bGQgYmUNCkNPTkZJR19JU19FTkFCTEVEKFNBTkRCT1gpIGlu
IHRoZXJlLg0KDQotLVNlYW4NCg0K
