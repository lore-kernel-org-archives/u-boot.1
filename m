Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4295CDB46E
	for <u-boot@archiver.kernel.org>; Thu, 12 Oct 2023 14:29:15 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CDEBF86C61;
	Thu, 12 Oct 2023 16:24:22 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="j32e2tTl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C908086C61; Thu, 12 Oct 2023 16:23:25 +0200 (CEST)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com
 [IPv6:2607:f8b0:4864:20::f2c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A063F86406
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 16:23:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qv1-xf2c.google.com with SMTP id
 6a1803df08f44-66d09b6d007so5600466d6.1
 for <u-boot@lists.denx.de>; Thu, 12 Oct 2023 07:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697120329; x=1697725129; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i0xm1dOUzUct0CNrOnLAXsLO0YzzQ22oz7swMcIAmWs=;
 b=j32e2tTl/q4N3ZJixkMepdcaHxzWAh7dePPXf7wWXCjafkGOWaHVm505RFX8JE5KQ5
 nD+jmQqE/8vEdbIksVgNTmGEEW3Y+PLtDjGiA7PaItqfJBId9Oo/F0lcw3GiVmn0rMlr
 Qi/4CKTqOpPokC1FytuqTeW7JiyXh5W51RnqdWnqvPYYrE51z8d257ScpnHufMvUDsCv
 FQrTGCosMtwxiyGWszU992ts3Qp0c3gBvSe8e3yB++wzf2VEUTctvwAooPFzZ722rjWt
 bhAbb3fkO8cipdqjT1c+lzqhnIqsaic2PhiK94qwNsqZfh2KVnVY0q7WLDCMpo8utKbH
 /ICg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697120329; x=1697725129;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i0xm1dOUzUct0CNrOnLAXsLO0YzzQ22oz7swMcIAmWs=;
 b=WPoLzFNtOf4sqWQ/45ewg2fCNcDLfhMFbqBkYs9afyrMdwX9EGMJlx9nlo3S0Zijm1
 CrJM/kSQKPSDaeOcDKxibtRdvlubNqYMtQzrcuEjV+J2z3Io0ovp2BHdNUjsXn483dsH
 Cr9av1tE8xmbwcCu3OsI1cZLoWS47DU9xtkgOwh/bqGJnUigZbgAg6xgJRbc3ELmvq5K
 VwxV/ln5OiL1NiXR7YgNmk6ioEj73O9/dCJo1WH0OH5QNGiAJSI0EtV0/txd9gdy+79O
 OjxFrMb8J3PKHg4piM8v2VcBaA0fHvd442v+Osl9ZHxQV2p2ASaQf6xQ9t3RFlrGMYot
 EO7Q==
X-Gm-Message-State: AOJu0YwJh7ULzhYFdyKbkGBceAeA42u+W76wylEnottb/ABP7N1N4JNl
 7AS77MgV440JqTS5iQHlQGM=
X-Google-Smtp-Source: AGHT+IGlCu7ENrXbwXJPSDf2VXQryN9tFau9xGmtNQJo4bIehR+jIYC4ghdTnMWn//Mk0rrKJY4EEw==
X-Received: by 2002:a0c:e045:0:b0:66d:b73:d6f4 with SMTP id
 y5-20020a0ce045000000b0066d0b73d6f4mr3866540qvk.51.1697120329618; 
 Thu, 12 Oct 2023 07:18:49 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 x12-20020a0cb20c000000b0065b2f4dd300sm6733196qvd.90.2023.10.12.07.18.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 07:18:49 -0700 (PDT)
Message-ID: <851eb6e1-2ec9-6471-491f-b898195d01dd@gmail.com>
Date: Thu, 12 Oct 2023 10:18:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 15/26] net: bootp: Fall back to BOOTP from DHCP when unit
 testing
Content-Language: en-US
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Harald Seiler <hws@denx.de>, Simon Glass <sjg@chromium.org>,
 Joe Hershberger <joe.hershberger@ni.com>, Ramon Fried
 <rfried.dev@gmail.com>, Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
References: <20231012015626.3487451-1-seanga2@gmail.com>
 <20231012015626.3487451-16-seanga2@gmail.com>
 <83ab1f81-031b-4241-8734-46e9288fc261@gmx.de>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <83ab1f81-031b-4241-8734-46e9288fc261@gmx.de>
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

T24gMTAvMTIvMjMgMDM6MTYsIEhlaW5yaWNoIFNjaHVjaGFyZHQgd3JvdGU6DQo+IE9uIDEw
LzEyLzIzIDAzOjU2LCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPj4gSWYgd2Ugc2VudCBhIERI
Q1AgcGFja2V0IGFuZCBnZXQgYSBCT09UUCByZXNwb25zZSBmcm9tIHRoZSBzZXJ2ZXIsIHdl
DQo+PiBzaG91bGRuJ3QgdHJ5IHRvIHNlbmQgYSBESENQUkVRVUVTVCBwYWNrZXQsIHNpbmNl
IGl0IHdvbid0IGJlIERIQ1BBQ0tlZC4NCj4+IFRyYW5zaXRpb24gc3RyYWlnaHQgdG8gQklO
RC4gVGhpcyBpcyBvbmx5IGVuYWJsZWQgZm9yIFVOSVRfVEVTVCB0byBhdm9pZA0KPj4gYmxv
YXQsIHNpbmNlIEkgc3VzcGVjdCB0aGUgbnVtYmVyIG9mIEJPT1RQIHNlcnZlcnMgaW4gdGhl
IHdpbGQgaXMNCj4+IHZhbmlzaGluZ2x5IHNtYWxsLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6
IFNlYW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29tPg0KPj4gLS0tDQo+Pg0KPj4gwqAg
bmV0L2Jvb3RwLmMgfCA2ICsrKysrKw0KPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0
aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9uZXQvYm9vdHAuYyBiL25ldC9ib290cC5j
DQo+PiBpbmRleCAyMDUzY2NlODhjNi4uN2IwZjQ1ZTE4YTkgMTAwNjQ0DQo+PiAtLS0gYS9u
ZXQvYm9vdHAuYw0KPj4gKysrIGIvbmV0L2Jvb3RwLmMNCj4+IEBAIC0xMDczLDYgKzEwNzMs
MTEgQEAgc3RhdGljIHZvaWQgZGhjcF9oYW5kbGVyKHVjaGFyICpwa3QsIHVuc2lnbmVkIGRl
c3QsIHN0cnVjdCBpbl9hZGRyIHNpcCwNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgQ09ORklHX1NZU19CT09URklMRV9QUkVGSVgsDQo+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cmxlbihDT05GSUdfU1lTX0JPT1RGSUxFX1BSRUZJ
WCkpID09IDApIHsNCj4+IMKgICNlbmRpZsKgwqDCoCAvKiBDT05GSUdfU1lTX0JPT1RGSUxF
X1BSRUZJWCAqLw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKENPTkZJR19JU19F
TkFCTEVEKFVOSVRfVEVTVCkgJiYNCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgZGhjcF9tZXNzYWdlX3R5cGUoKHU4ICopYnAtPmJwX3ZlbmQpID09IC0xKSB7DQo+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlYnVnKCJnb3QgQk9PVFAgcmVzcG9u
c2U7IHRyYW5zaXRpb25pbmcgdG8gQk9VTkRcbiIpOw0KPj4gK8KgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBnb3RvIGRoY3BfZ290X2Jvb3RwOw0KPiANCj4gVGhpcyBtYXkgcmVz
dWx0IGluIHVuZXhwZWN0ZWQgYmVoYXZpb3Igd2hlbiBydW5uaW5nIHRlc3RzIGFnYWluc3Qg
YW4NCj4gYWN0dWFsIG5ldHdvcmsuIFBsZWFzZSwgYXZvaWQgdGhpcy4NCg0KV2hhdCBpcyB1
bmV4cGVjdGVkIGJlaGF2aW9yPyBJZiB5b3UgZ2V0IGEgQk9PVFAgKG5vdCBESENQKSBwYWNr
ZXQsIHlvdSBzaG91bGQNCmJlaGF2ZSBhY2NvcmRpbmcgdG8gdGhlIEJPT1RQIHByb3RvY29s
LCBub3QgdGhlIERIQ1AgcHJvdG9jb2wuDQoNCi0tU2Vhbg0KDQo=
