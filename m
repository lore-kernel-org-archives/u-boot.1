Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8E2CD6E57
	for <u-boot@archiver.kernel.org>; Wed,  3 Jun 2026 17:34:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A0BDD844CF;
	Wed,  3 Jun 2026 19:34:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l1DcUfEp";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D71128467E; Wed,  3 Jun 2026 19:34:06 +0200 (CEST)
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com
 [IPv6:2607:f8b0:4864:20::72c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7661F83FF5
 for <u-boot@lists.denx.de>; Wed,  3 Jun 2026 19:34:04 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qk1-x72c.google.com with SMTP id
 af79cd13be357-9156a03acc6so44517985a.0
 for <u-boot@lists.denx.de>; Wed, 03 Jun 2026 10:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780508043; x=1781112843; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JUDM++4PVxwjmJFqTo/jiHKVawe/MJRaaw02tqqt/jE=;
 b=l1DcUfEp18qlxCC5Q00WD7ZBOSWOootEUmGCtatMK8fBv+6wtsghBlUmIJNu2ZSGdb
 kQ45+YhzFwMkjme8EUfz1epDQtY7vmQldjJm1Q9r6eHgqxWr/gHVfFwp5NMscbScezlR
 CePYXwYoskchwfMiHOpnSiFfra0wZfAd4yokWqED9r5FO4dvRsfb/nt5eAYTaGjN8XmW
 LepWeW18hNjBo0c5ktqeZ83YNntojmV8684Rw152tqoiR3M23kWTRioBfHz9Ldmu9iub
 5vQJuh04uphZZ5lekRURuecIyb2z75tgDd92uLR0TvORV8wo8TunPS4IDzjYdJkS9T0E
 uvxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780508043; x=1781112843;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JUDM++4PVxwjmJFqTo/jiHKVawe/MJRaaw02tqqt/jE=;
 b=Ke2l+SFX5Oqqv7M0vqpJ4On/C8tS4zgj4HboEL3DdUlLTUH8YJeM/tJiJXDZFrVz7h
 u9ym+M7zkb0pBMx3XKK/RCuEjiVDQA+l+vMyo05wz+jZMzkNA196uB7NHnPzygrVyESA
 x4Ba4ZhCi3CDGkKhu8PWH3VhHtYLeSuKuIWgVqxuZYk79QZGFVpjlRnziOCTijvNibRf
 ZttEqq/qBJvfD52IvtXv+GUefxJLyIGhXaq/cPLFgBDMtjbYJC/8/QPAE4bpUncy2VQt
 Go/+39/AXdaMxbZoMWyKkiRxPehMdXZ2b4B6CPhMLT9B7k1jhQlpTiZeM/jjT1F2UQXY
 0uJw==
X-Gm-Message-State: AOJu0YwV/WJWK/m3Ktcc9Qkc7jJq5enmMN6Hg5gzutHE+WKUEvpy5nQz
 NH9lGUj3N1MMMKDUrGtqP+X37LJMOFqnddmsHryfEAWjSvMXo57e7gLZ
X-Gm-Gg: Acq92OFDpIp2ouEqA35nbGLC9tnCKBHzEdm/mHNZovGrSo27RRiX1mY4GQFEIhAEwso
 LuPr71y5b4sGmTO+JzsFLv75LlhbYXOcpano3hm36/+hLT5rVPjNssNfXrb///UuepopMvz9Un7
 GrL6Eeh16ErZTeoIPiRRKVtzBAINNlkqbMGju7F9F/wXT6ZewyJrYKQIOXgdHfH5PPSu5O0N8u4
 WUzN9taOAcjmjmB4k20HyhhPTJ7ouJ/Ge9/tjlT/h0oaxM/eFrvSt3v06nt/LaF0zE1NBlv8T5g
 cPgx7755VLkC2RLMm27M2CWqdU/MPtUQ606K0oevwSGKGScZ5XgsPmfxpG/T8RyQW2r0tGNicFr
 C+/GPlFW2m7W3ZxcO6kooUJnmkFR3hNgwu/BpVZVyJ2N9DGAUB6r7+OwwcUyAcrVb7F6v5mt4IJ
 adKwrwy7sZ+4rytUjRnplLXkjjU8AKnGtD+ZCUzI3TV0VCtREL6aNCk18kn0RpwO9/SmvnUSTEL
 1UZuWvzWiUHK0zCNwrw
X-Received: by 2002:a05:620a:4728:b0:915:7a64:cb68 with SMTP id
 af79cd13be357-9158a242b75mr499197085a.2.1780508043206; 
 Wed, 03 Jun 2026 10:34:03 -0700 (PDT)
Received: from [192.168.1.143] (pool-173-66-184-60.washdc.fios.verizon.net.
 [173.66.184.60]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd06e4d6sm26013846d6.36.2026.06.03.10.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jun 2026 10:34:02 -0700 (PDT)
Message-ID: <86b83c9e-2344-542b-8c82-f3106150878d@gmail.com>
Date: Wed, 3 Jun 2026 13:34:01 -0400
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
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <CAEU2+vrQijegaxRhjGoMr=kKcQ2mbXMh8WD3oEpa+HzDfbUE2w@mail.gmail.com>
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

T24gNi8zLzI2IDEyOjI1LCBFcmljaCBFLiBIb292ZXIgd3JvdGU6DQo+IE9uIFdlZCwgSnVu
IDMsIDIwMjYgYXQgOTo1NeKAr0FNIFNlYW4gQW5kZXJzb24gPHNlYW5nYTJAZ21haWwuY29t
PiB3cm90ZToNCj4+IFBsZWFzZSBhZGQgYSBjb21taXQgbWVzc2FnZS4NCj4gDQo+IE15IGFw
b2xvZ2llcyB0byBldmVyeW9uZS4gIFRoZSBjaGVja3BhdGNoLnBsIHNjcmlwdCBjYXVnaHQg
dGhhdCBhbmQsDQo+IHNpbmNlIEkgY2hhbmdlZCB0aGUgdGl0bGUgYSBsaXR0bGUsIEkgYWNj
aWRlbnRhbGx5IHVwbG9hZGVkIHRoZSB3cm9uZw0KPiB2ZXJzaW9uLg0KPiANCj4+IEFuZCBp
c24ndCB0aGlzIGFscmVhZHkgcG9zc2libGUgd2l0aCAtUiA/DQo+IA0KPiBZZXMsIHNvcnQg
b2YsIGlmIHlvdSBhcmUgdXNpbmcgInp5bnFtcGltYWdlIiBpbnN0ZWFkIG9mICJ6eW5xbXBi
aWYiDQoNCkkndmUgbmV2ZXIgc2VlbiB0aGUgcG9pbnQgb2YgQklGczsgSSd2ZSBiZWVuIGFi
bGUgdG8gZG8gZXZlcnl0aGluZyBJDQp3YW50IHdpdGggenlucW1waW1hZ2UuDQoNCkJ1dCB0
aGlzIGluZm8gd291bGQgYmUgZ29vZCB0byBwdXQgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLg0K
DQo+IHRoZW4geW91IGNhbiBhZGQgdGhlIHJlZ2lzdGVyIGluaXRpYWxpemF0aW9uIHdpdGgg
LVIuICBUaGUgcGF0Y2gNCj4gbGV2ZXJhZ2VzIHRoYXQgZXhpc3RpbmcgY2FwYWJpbGl0eSB0
byBhZGQgc3VwcG9ydCBmb3IgdGhlICJbaW5pdF0iDQo+IGF0dHJpYnV0ZSBpbiB0aGUgenlu
cW1wYmlmIGJhY2tlbmQ6DQo+IGh0dHBzOi8vZG9jcy5hbWQuY29tL3IvZW4tVVMvdWcxMjgz
LWJvb3RnZW4tdXNlci1ndWlkZS9pbml0DQo+IA0KPiBXZSBhcmUgdXNpbmcgdGhpcyBmZWF0
dXJlLCBpbiBjb21iaW5hdGlvbiB3aXRoIG90aGVyIHp5bnFtcGJpZiBvcHRpb25zLCBsaWtl
IHNvOg0KPiA9PT0NCj4gaW1hZ2UgOiB7DQo+ICAgICAgICAgIFtpbml0XSBmc2JsLmludA0K
PiAgICAgICAgICBbYm9vdGxvYWRlcl0gZnNibC5lbGYNCj4gICAgICAgICAgW3BtdWZ3X2lt
YWdlXSBwbXVmdy5lbGYNCj4gICAgICAgICAgW2Rlc3RpbmF0aW9uX2NwdT1ub25lXSBmc2Js
LnRjbA0KPiAgICAgICAgICBbZGVzdGluYXRpb25fY3B1PWE1My0wLCBleGNlcHRpb25fbGV2
ZWw9ZWwtM10gYmwzMS5lbGYNCj4gICAgICAgICAgW2Rlc3RpbmF0aW9uX2NwdT1hNTMtMCwg
ZXhjZXB0aW9uX2xldmVsPWVsLTIsIGxvYWQ9MHgwODAwMDAwMCwNCj4gc3RhcnR1cD0weDA4
MDAwMDAwXSB1LWJvb3QuYmluDQo+IH0NCj4gPT09DQo+IA0KPiBCZXN0LA0KPiBFcmljaA0K
DQo=
