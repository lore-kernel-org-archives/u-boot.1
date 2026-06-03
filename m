Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39CACD6E69
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:51:14 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 39DD98469D;
	Wed,  3 Jun 2026 19:51:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HT4GxCCd";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C51FA84868; Wed,  3 Jun 2026 19:51:12 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 662458467E
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:51:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-91550f6a03eso46319385a.3
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780509069; x=1781113869; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sYBUuI2Oa4FVioABdQwwz5r455yBp0POiuCbg3H1srs=;
 b=HT4GxCCdJ/5p656Lg3dJtNw1+nlQ0oOa+joF5sc/mIkVvZawvsOG8YeTohQGQlm01M
 kITwHdCrXgRu7QBhAZlb71mEDP0mZZ5atVQ0pNlHzZ/O1suXJD+XFNlZ/6o/2Xku6Sqm
 1barP51+HvVVkNx21NlOKSyL1Cdd9Pvvw860pGthkTnZ+PXTA+riAGM2uF9QVYj5Eiwl
 bXpQygd0660x+S8vW7i7A9SoY9n1Rd7tfICcCV3JZJiYaYLqAArBiQn2YBwzeDxAFMqf
 xg/CWjbbWSS+uS4sny59ngqn0rlNUYlU7g3ufa4pR+erPCCdqqgPfieyt8o7ToKnfsCI
 baGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780509069; x=1781113869;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sYBUuI2Oa4FVioABdQwwz5r455yBp0POiuCbg3H1srs=;
 b=pytfkDpnptNoMpsqWqAv8LckCze5RP7lL79qa14j8P/AiysaxSEioSByvvRn+MSmYh
 s11vXdaUi7lbA9DZUUA/dnjGvx4CYByBzKxNoH0MYkfT8ArUdvgv/ufkdr25EHnCfVlr
 RX1q/adfr62kiX7D5i0vUwq4JAZBrKaD2SyJnt7mSZaWdNdZmiQ7pHT8onOgRFOEViCI
 T38t/ToMD6lYkf77W1WSLMFKnLGA0clPq64OkDwZM8oMT1OT0mifFlW2YuZMyUS08c3J
 1la3nGj3j5CudBm0DSuqg6Y+l/DUpn/fsdianh78n65XbRwB44WWCSKUszt01lZdv0Yp
 zhBg==
X-Gm-Message-State: AOJu0YzzLGbcFomItrDN2Da8WhxjUUPm0+bL8qTBkp/Jn9kRQY/g4djX
 7plZfz8ano+wVmNvFBUhN+5hjjvG8u9k4SfOGwURYZgXalT3CNNh9o5r
X-Gm-Gg: Acq92OEBKz+v6wOm7maTxLXcoYLzK2weiTysUdqO+keHpVyAAy4aJ0O6ez7kGktHhX0
 c8DcQvPbC4wt7jgpWx2z+roAoH2IpnJqU1qTdMxLGRGBocDX8P5xu9GPjbW228QBAlR3BUnAKNQ
 fu1gJTcE57a6diQvexRGyMVnvOPgedg9T4s/0MqLF+g/cdO8nKqvvJ9ew/inV5eiJGXrtkmgQv+
 gjXjLTLZR6fAP3cI36ESBMXBzd7N9t9ZYR4ObV0B0W93c3v+CcLkPsQeiZX9lC6gYmZ7aLBfpOI
 Yz48/sRuDEo3nZKd0SgNcy4nwFFXAs90AOFb6cXGsl8y9WbKqZnQwIPW5Y/9PSPFEjZJLOXcWhY
 TQTAJPtlP0DkvmVCXtFZYlvub+c762YtZuaL4eFtmPB5bUTb+Iai8a6QNdIfKsGdhQ/1m4yNMwD
 jwRLNjnKuPR7IG/BfwtZsF7z+zs5AFzbVa3HC2Z8fNSqmbgIOcRodK6bDnVdvu05U0mbT2zFLl0
 B6ZrhQFdg==
X-Received: by 2002:a05:620a:258e:b0:915:7c1a:138c with SMTP id
 af79cd13be357-9158a36794cmr526395985a.4.1780509068997; 
 Wed, 03 Jun 2026 10:51:08 -0700 (PDT)
Received: from [192.168.1.143] (pool-173-66-184-60.washdc.fios.verizon.net.
 [173.66.184.60]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a21f871sm311967785a.12.2026.06.03.10.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:51:08 -0700 (PDT)
Message-ID: <1cd5b625-89c5-73cf-93a2-654af3906f60@gmail.com>
Date: Wed, 3 Jun 2026 13:51:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: mkimage: allow zynqmp to use a register initialization file
Content-Language: en-US
To: "Erich E. Hoover" <erich.e.hoover@gmail.com>
Cc: u-boot@lists.denx.de, Mike Looijmans <mike.looijmans@topic.nl>,
 Michal Simek <michal.simek@xilinx.com>
References: <20260602210141.62966-1-erich.e.hoover@gmail.com>
 <0a768686-d9c9-54ee-c101-92077805b504@gmail.com>
 <CAEU2+vrQijegaxRhjGoMr=kKcQ2mbXMh8WD3oEpa+HzDfbUE2w@mail.gmail.com>
 <86b83c9e-2344-542b-8c82-f3106150878d@gmail.com>
 <CAEU2+vrTq-3Xy5MwHAJZ_zjx7bdM1qih=3Tmkp_u758WcXf+YA@mail.gmail.com>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAEU2+vrTq-3Xy5MwHAJZ_zjx7bdM1qih=3Tmkp_u758WcXf+YA@mail.gmail.com>
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

T24gNi8zLzI2IDEzOjQ1LCBFcmljaCBFLiBIb292ZXIgd3JvdGU6DQo+IE9uIFdlZCwgSnVu
IDMsIDIwMjYgYXQgMTE6MzTigK9BTSBTZWFuIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNv
bT4gd3JvdGU6DQo+PiBPbiA2LzMvMjYgMTI6MjUsIEVyaWNoIEUuIEhvb3ZlciB3cm90ZToN
Cj4+PiAuLi4NCj4+PiBZZXMsIHNvcnQgb2YsIGlmIHlvdSBhcmUgdXNpbmcgInp5bnFtcGlt
YWdlIiBpbnN0ZWFkIG9mICJ6eW5xbXBiaWYiDQo+Pg0KPj4gSSd2ZSBuZXZlciBzZWVuIHRo
ZSBwb2ludCBvZiBCSUZzOyBJJ3ZlIGJlZW4gYWJsZSB0byBkbyBldmVyeXRoaW5nIEkNCj4+
IHdhbnQgd2l0aCB6eW5xbXBpbWFnZS4NCj4gDQo+IE15IHVuZGVyc3RhbmRpbmcgaXMgdGhh
dCAienlucW1waW1hZ2UiIG9ubHkgd29ya3MgaWYgeW91IGhhdmUgb25lDQo+ICJwYXJ0aXRp
b24iLCBzbyBpZiB5b3UncmUgcGFzc2luZyB0aGUgQVRGIG9yIG90aGVyIHBhcnRpdGlvbiBk
YXRhIEkNCj4gdGhpbmsgdGhhdCB5b3UgaGF2ZSB0byB1c2UgInp5bnFtcGJpZiIuDQo+DQoN
CkkgdXNlZCBBVEYsIGJ1dCB0aGlzIHdhcyB3aXRoIFNQTC4gU28gdGhlIGJvb3QgcHJvY2Vz
cyB3ZW50IHNvbWV0aGluZyBsaWtlDQoNCkJvb3QgUk9NIGxvYWRzIHp5bnFtcGltYWdlDQot
IFBNVSBmaXJtd2FyZSB0byBQTVUgUkFNDQotIFUtQm9vdCBTUEwgdG8gT0NSQU0NCg0KVS1C
b290IFNQTCBsb2FkcyBGSVQNCi0gQVRGIHRvIE9DUkFNDQotIFUtQm9vdC9EVEIgdG8gRERS
DQotIEJpdHN0cmVhbSB0byBQTA0KDQpBbmQgQVRGIHdhcyBjb25maWd1cmVkIHRvIGp1bXAg
dG8gRERSIGFmdGVyIGluaXRpYWxpemluZy4NCg0KSSBndWVzcyBpZiB5b3UgYXJlIHVzaW5n
IEZTQkwgdGhhdCBkb2Vzbid0IHdvcmssIGJ1dCBJTU8gRlNCTCBpcyB5ZXQgYW5vdGhlcg0K
aW5jb21wYXRpYmxlIGJvb3Rsb2FkZXIgdG8gbWFpbnRhaW4uIEknZCByYXRoZXIgaGF2ZSBh
IHNoYXJlZCBjb2RlYmFzZQ0KKFNQTC9VLUJvb3QpLg0KDQo+PiBCdXQgdGhpcyBpbmZvIHdv
dWxkIGJlIGdvb2QgdG8gcHV0IGluIHRoZSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IEhvdydz
IHRoaXMgc291bmQ/Og0KPiA9PT0NCj4gVGhlIFp5bnFNUCBCb290IEltYWdlIEZvcm1hdCBh
bGxvd3Mgc3BlY2lmeWluZyB0aGUgcmVnaXN0ZXINCj4gaW5pdGlhbGl6YXRpb24gZmlsZSB3
aXRoIHRoZSAiW2luaXRdIiBhdHRyaWJ1dGUuICBTaW5jZSB0aGlzDQo+IGZlYXR1cmUgaXMg
YWxyZWFkeSBzdXBwb3J0ZWQgYnkgdGhlICJ6eW5xbXBpbWFnZSIgYmFja2VuZCwgdGhpcw0K
PiBjb21taXQgaW1wbGVtZW50cyBhIGJpbmRpbmcgdG8gdGhhdCBleGlzdGluZyBzdXBwb3J0
Lg0KPiA9PT0NCj4gKCBodHRwczovL2xpc3RzLmRlbnguZGUvcGlwZXJtYWlsL3UtYm9vdC8y
MDI2LUp1bmUvNjIwODE0Lmh0bWwgKQ0KPiBQbGVhc2UgYWNjZXB0IG15IGFwb2xvZ2llcyBh
Z2FpbiBmb3IgbWVzc2luZyB0aGF0IHVwIHRoZSBmaXJzdCB0aW1lIGFyb3VuZC4NCg0KQWN0
dWFsbHksIEkgbGlrZWQgaG93IHlvdSBleHBsYWluZWQgaXQgaW4geW91ciBwcmV2aW91cyBl
bWFpbA0KDQpJZiB5b3UgYXJlIHVzaW5nICJ6eW5xbXBpbWFnZSIgaW5zdGVhZCBvZiAienlu
cW1wYmlmIg0KdGhlbiB5b3UgY2FuIGFkZCB0aGUgcmVnaXN0ZXIgaW5pdGlhbGl6YXRpb24g
d2l0aCAtUi4gVGhpcyBwYXRjaA0KbGV2ZXJhZ2VzIHRoYXQgZXhpc3RpbmcgY2FwYWJpbGl0
eSB0byBhZGQgc3VwcG9ydCBmb3IgdGhlICJbaW5pdF0iDQphdHRyaWJ1dGUgaW4gdGhlIHp5
bnFtcGJpZiBiYWNrZW5kOg0KaHR0cHM6Ly9kb2NzLmFtZC5jb20vci9lbi1VUy91ZzEyODMt
Ym9vdGdlbi11c2VyLWd1aWRlL2luaXQNCg0KV2UgYXJlIHVzaW5nIHRoaXMgZmVhdHVyZSwg
aW4gY29tYmluYXRpb24gd2l0aCBvdGhlciB6eW5xbXBiaWYgb3B0aW9ucywgbGlrZSBzbzoN
Cj09PQ0KaW1hZ2UgOiB7DQogICAgICAgICBbaW5pdF0gZnNibC5pbnQNCiAgICAgICAgIFti
b290bG9hZGVyXSBmc2JsLmVsZg0KICAgICAgICAgW3BtdWZ3X2ltYWdlXSBwbXVmdy5lbGYN
CiAgICAgICAgIFtkZXN0aW5hdGlvbl9jcHU9bm9uZV0gZnNibC50Y2wNCiAgICAgICAgIFtk
ZXN0aW5hdGlvbl9jcHU9YTUzLTAsIGV4Y2VwdGlvbl9sZXZlbD1lbC0zXSBibDMxLmVsZg0K
ICAgICAgICAgW2Rlc3RpbmF0aW9uX2NwdT1hNTMtMCwgZXhjZXB0aW9uX2xldmVsPWVsLTIs
IGxvYWQ9MHgwODAwMDAwMCwNCnN0YXJ0dXA9MHgwODAwMDAwMF0gdS1ib290LmJpbg0KfQ0K
PT09DQo=
