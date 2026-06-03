Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75F2ACD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:55:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C70A18469D;
	Wed,  3 Jun 2026 19:55:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iTNrzZ3e";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AC4BB84874; Wed,  3 Jun 2026 19:55:40 +0200 (CEST)
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3AE608467E
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:55:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-91565661572so43662385a.2
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780509337; x=1781114137; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6LmA3WqSADehdB8b0MI+DuYFMgAYWpBJyy8Q6cZpTpQ=;
 b=iTNrzZ3eBJ0ozxhjtfy2jilCDvCjj8szyqWVYDEBJLOsP9F1obR4uOEkucNyw5LvLg
 so+ibQv6InQKOG46bD9HpanTQsq028ZDzwaRj3HZA39vWTlylyhXaSC/yMWpe53HZ13A
 QAcofvHU94dOBU3JHsZCmR4cM2FqBi4FgMS+w8v7A3VNfHTgXzVUIp66d8+CvHmeuoCl
 JGiyalTZSLdTaUO3EGJPTpOLp4ZeQTp+c4Q/mdI34xiNH2yyUfEQYq5MiXIF2JqhkEHH
 510XgqyyGBa8gEbrH0gbRWabhPGE6kHOG9Ked+UJpoc7nM6DjVH/IkDI8ICMV0qbsgt4
 IBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780509337; x=1781114137;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6LmA3WqSADehdB8b0MI+DuYFMgAYWpBJyy8Q6cZpTpQ=;
 b=b41O4EHCIv7pH2eqApKB2vb8fg1mqJeC9FW0EhE8e7yNZB9fTAxuAW7Zic639dkDbq
 69c8oY/F61fNozkz3g15oYUj+yt/6kR1oSSGw1YzqCKBwgWXHqWRsVvtnUrcm3FUsQWa
 XGxoaThvklUC9MQKu534nkDvoJ1uCrjtgAOj+OeaO65gHSO+XRnDisMIaQdODc+7BB4m
 d6L7jBK0cAjFEKPGCGWMLsTrxcXVwHOpP8WpL/Ygp+/kAoEWG79MmKN5Gx8NNEoFXF+1
 kKwltjCpZjH9Pc3pY21OAsYsk+3JnlW1kq1k01haWWVZ+I3OVvYJLvqlaEYCk48yi+NQ
 M5lA==
X-Gm-Message-State: AOJu0YzdwkYRkmcxcFqsIoc9MtDu4ccGvI3ADjTqqZma+N1W73Pby2Rg
 M99IsisMyLHxzD3gWVAWRAZjuMqikKuZTczGYf9GkZUY6OBDtqGfd2Lw
X-Gm-Gg: Acq92OHt318EiO2vGFLB6nEvsvxnU9irlrXe6CxNTyB1zUc9LULJ+w2ajohHV3chbh6
 mfhYsol8LplfC61PofZwX0hEvFhjNgg6X9hm9MUABx3CX8uG13KRycKhyqQW34PSU9QsaRaSq4/
 Sv74VIqutpmDWPQ3dJrKTQKj6TgrmZq8Sv7HPBvSUQl4jtIL+EfOkYFLIa9kuppG6wx1+jCzDkw
 2JxHrMs+vJI9lC/uHAg/1ALzdVIJgKeWlUnkMYgfgjNP5PjfR/R1p/HfrLqdfE+NdSGz5+Tnk41
 9AB30IytCslf6fJuf9aL0HeOlHhOR/SydxwwA9+X5/a5XPn5aN3MlhJ5hyhsW/CVV8RPQK/8trx
 ubIxewwDhVgdQKcKvIGBQjMXlFWQQ2GY6pBRDWcEe4tfkLlKYbtRWOzgtzS1yHxP3ePXJOtam14
 yEEa2FRkYXN8QxcisPToSpMnE/ryaFDoRRyvRaSHg4SB1W1Y4f3hN2EpNEfQa56OXVO7POvhCKn
 h8FPuZRzQ==
X-Received: by 2002:a05:620a:2955:b0:8f3:5988:f97c with SMTP id
 af79cd13be357-9158a2c0f2dmr458930985a.3.1780509336542; 
 Wed, 03 Jun 2026 10:55:36 -0700 (PDT)
Received: from [192.168.1.143] (pool-173-66-184-60.washdc.fios.verizon.net.
 [173.66.184.60]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00a4f4sm328092285a.3.2026.06.03.10.55.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:55:36 -0700 (PDT)
Message-ID: <5103b696-77d0-387a-40a1-29665df6d36f@gmail.com>
Date: Wed, 3 Jun 2026 13:55:35 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: mkimage: allow zynqmp to use a register initialization file
Content-Language: en-US
From: Sean Anderson <seanga2@gmail.com>
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Cc: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
 <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
 <CAEU2+vrQijegaxRhjGoMr=kKcQ2mbXMh8WD3oEpa+HzDfbUE2w@mail.gmail.com>
 <86b83c9e-2344-542b-8c82-f3106150878d@gmail.com>
 <CAEU2+vrTq-3Xy5MwHAJZ_zjx7bdM1qih=3Tmkp_u758WcXf+YA@mail.gmail.com>
 <1cd5b625-89c5-73cf-93a2-654af3906f60@gmail.com>
In-Reply-To: <1cd5b625-89c5-73cf-93a2-654af3906f60@gmail.com>
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

T24gNi8zLzI2IDEzOjUxLCBTZWFuIEFuZGVyc29uIHdyb3RlOg0KPiBPbiA2LzMvMjYgMTM6
NDUsIEVyaWNoIEUuIEhvb3ZlciB3cm90ZToNCj4+IE9uIFdlZCwgSnVuIDMsIDIwMjYgYXQg
MTE6MzTigK9BTSBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT4gd3JvdGU6DQo+
Pj4gT24gNi8zLzI2IDEyOjI1LCBFcmljaCBFLiBIb292ZXIgd3JvdGU6DQo+Pj4+IC4uLg0K
Pj4+PiBZZXMsIHNvcnQgb2YsIGlmIHlvdSBhcmUgdXNpbmcgInp5bnFtcGltYWdlIiBpbnN0
ZWFkIG9mICJ6eW5xbXBiaWYiDQo+Pj4NCj4+PiBJJ3ZlIG5ldmVyIHNlZW4gdGhlIHBvaW50
IG9mIEJJRnM7IEkndmUgYmVlbiBhYmxlIHRvIGRvIGV2ZXJ5dGhpbmcgSQ0KPj4+IHdhbnQg
d2l0aCB6eW5xbXBpbWFnZS4NCj4+DQo+PiBNeSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgInp5
bnFtcGltYWdlIiBvbmx5IHdvcmtzIGlmIHlvdSBoYXZlIG9uZQ0KPj4gInBhcnRpdGlvbiIs
IHNvIGlmIHlvdSdyZSBwYXNzaW5nIHRoZSBBVEYgb3Igb3RoZXIgcGFydGl0aW9uIGRhdGEg
SQ0KPj4gdGhpbmsgdGhhdCB5b3UgaGF2ZSB0byB1c2UgInp5bnFtcGJpZiIuDQo+Pg0KPiAN
Cj4gSSB1c2VkIEFURiwgYnV0IHRoaXMgd2FzIHdpdGggU1BMLiBTbyB0aGUgYm9vdCBwcm9j
ZXNzIHdlbnQgc29tZXRoaW5nIGxpa2UNCj4gDQo+IEJvb3QgUk9NIGxvYWRzIHp5bnFtcGlt
YWdlDQo+IC0gUE1VIGZpcm13YXJlIHRvIFBNVSBSQU0NCj4gLSBVLUJvb3QgU1BMIHRvIE9D
UkFNDQo+IA0KPiBVLUJvb3QgU1BMIGxvYWRzIEZJVA0KPiAtIEFURiB0byBPQ1JBTQ0KPiAt
IFUtQm9vdC9EVEIgdG8gRERSDQo+IC0gQml0c3RyZWFtIHRvIFBMDQo+IA0KPiBBbmQgQVRG
IHdhcyBjb25maWd1cmVkIHRvIGp1bXAgdG8gRERSIGFmdGVyIGluaXRpYWxpemluZy4NCj4g
DQo+IEkgZ3Vlc3MgaWYgeW91IGFyZSB1c2luZyBGU0JMIHRoYXQgZG9lc24ndCB3b3JrLCBi
dXQgSU1PIEZTQkwgaXMgeWV0IGFub3RoZXINCj4gaW5jb21wYXRpYmxlIGJvb3Rsb2FkZXIg
dG8gbWFpbnRhaW4uIEknZCByYXRoZXIgaGF2ZSBhIHNoYXJlZCBjb2RlYmFzZQ0KPiAoU1BM
L1UtQm9vdCkuDQoNClRoZSBvdGhlciBhZHZhbnRhZ2Ugb2YgdGhpcyBpcyB0aGF0IHRoZSBG
SVQgaXMgbG9hZGVkIHdpdGggU1BMICh3aGljaCBjYW4gdXNlDQphIGZhc3RlciBidXMgdGhh
biB0aGUgYm9vdCBST00sIGFsdGhvdWdoIEkgdGhpbmsgRlNCTCBkb2VzIHRoaXMgdG9vKSBh
bmQgdGhlDQppbWFnZXMgKGVzcGVjaWFsbHkgdGhlIGJpdHN0cmVhbSkgY2FuIGJlIGNvbXBy
ZXNzZWQuIEV2ZW4gc29tZXRoaW5nIGxpa2UgTFpPDQppcyB2ZXJ5IGVmZmVjdGl2ZSBhdCBj
b21wcmVzc2luZyB0aGUgYml0c3RyZWFtIGFuZCBzcGVkIHVwIHRoZSBib290IGJ5IHNldmVy
YWwNCnNlY29uZHMuDQoNCj4+PiBCdXQgdGhpcyBpbmZvIHdvdWxkIGJlIGdvb2QgdG8gcHV0
IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4+DQo+PiBIb3cncyB0aGlzIHNvdW5kPzoNCj4+
ID09PQ0KPj4gVGhlIFp5bnFNUCBCb290IEltYWdlIEZvcm1hdCBhbGxvd3Mgc3BlY2lmeWlu
ZyB0aGUgcmVnaXN0ZXINCj4+IGluaXRpYWxpemF0aW9uIGZpbGUgd2l0aCB0aGUgIltpbml0
XSIgYXR0cmlidXRlLsKgIFNpbmNlIHRoaXMNCj4+IGZlYXR1cmUgaXMgYWxyZWFkeSBzdXBw
b3J0ZWQgYnkgdGhlICJ6eW5xbXBpbWFnZSIgYmFja2VuZCwgdGhpcw0KPj4gY29tbWl0IGlt
cGxlbWVudHMgYSBiaW5kaW5nIHRvIHRoYXQgZXhpc3Rpbmcgc3VwcG9ydC4NCj4+ID09PQ0K
Pj4gKCBodHRwczovL2xpc3RzLmRlbnguZGUvcGlwZXJtYWlsL3UtYm9vdC8yMDI2LUp1bmUv
NjIwODE0Lmh0bWwgKQ0KPj4gUGxlYXNlIGFjY2VwdCBteSBhcG9sb2dpZXMgYWdhaW4gZm9y
IG1lc3NpbmcgdGhhdCB1cCB0aGUgZmlyc3QgdGltZSBhcm91bmQuDQo+IA0KPiBBY3R1YWxs
eSwgSSBsaWtlZCBob3cgeW91IGV4cGxhaW5lZCBpdCBpbiB5b3VyIHByZXZpb3VzIGVtYWls
DQo+IA0KPiBJZiB5b3UgYXJlIHVzaW5nICJ6eW5xbXBpbWFnZSIgaW5zdGVhZCBvZiAienlu
cW1wYmlmIg0KPiB0aGVuIHlvdSBjYW4gYWRkIHRoZSByZWdpc3RlciBpbml0aWFsaXphdGlv
biB3aXRoIC1SLiBUaGlzIHBhdGNoDQo+IGxldmVyYWdlcyB0aGF0IGV4aXN0aW5nIGNhcGFi
aWxpdHkgdG8gYWRkIHN1cHBvcnQgZm9yIHRoZSAiW2luaXRdIg0KPiBhdHRyaWJ1dGUgaW4g
dGhlIHp5bnFtcGJpZiBiYWNrZW5kOg0KPiBodHRwczovL2RvY3MuYW1kLmNvbS9yL2VuLVVT
L3VnMTI4My1ib290Z2VuLXVzZXItZ3VpZGUvaW5pdA0KPiANCj4gV2UgYXJlIHVzaW5nIHRo
aXMgZmVhdHVyZSwgaW4gY29tYmluYXRpb24gd2l0aCBvdGhlciB6eW5xbXBiaWYgb3B0aW9u
cywgbGlrZSBzbzoNCj4gPT09DQo+IGltYWdlIDogew0KPiAgwqDCoMKgwqDCoMKgwqAgW2lu
aXRdIGZzYmwuaW50DQo+ICDCoMKgwqDCoMKgwqDCoCBbYm9vdGxvYWRlcl0gZnNibC5lbGYN
Cj4gIMKgwqDCoMKgwqDCoMKgIFtwbXVmd19pbWFnZV0gcG11ZncuZWxmDQo+ICDCoMKgwqDC
oMKgwqDCoCBbZGVzdGluYXRpb25fY3B1PW5vbmVdIGZzYmwudGNsDQo+ICDCoMKgwqDCoMKg
wqDCoCBbZGVzdGluYXRpb25fY3B1PWE1My0wLCBleGNlcHRpb25fbGV2ZWw9ZWwtM10gYmwz
MS5lbGYNCj4gIMKgwqDCoMKgwqDCoMKgIFtkZXN0aW5hdGlvbl9jcHU9YTUzLTAsIGV4Y2Vw
dGlvbl9sZXZlbD1lbC0yLCBsb2FkPTB4MDgwMDAwMDAsDQo+IHN0YXJ0dXA9MHgwODAwMDAw
MF0gdS1ib290LmJpbg0KPiB9DQo+ID09PQ0KDQo=
