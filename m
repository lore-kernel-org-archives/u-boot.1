Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF616E71D2D
	for <u-boot@archiver.kernel.org>; Fri, 29 Sep 2023 13:16:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 48D2C86EC9;
	Fri, 29 Sep 2023 15:16:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kheenO0T";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CB52F86ED1; Fri, 29 Sep 2023 15:16:32 +0200 (CEST)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4EB186EC7
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 15:16:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=seanga2@gmail.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4197fa36b6aso2567601cf.3
 for <u-boot@lists.denx.de>; Fri, 29 Sep 2023 06:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695993389; x=1696598189; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Gd3dYYe3g7a29l/kFnJV7ukUC3DXofEZJppgtkl7vEk=;
 b=kheenO0T4PY3WOpfJI3S5Gb01dAuEA7U8tTqljZzdiqJC9NYRcFuQiLlnphUH6aD5h
 Vz8MFT68LyCRwyL73b14xmZu3eOJ3DuQaUdYiqqpRtyGIHZxCXsKUBTFd0Fd9fitx7NK
 tiM+/hBcjdPKD3a8ObKkonJmHHOUN9Ct0o5cM2fDA6+8lpEs33c01P0O/ja/yuK19zD7
 8RBDKQ86ZTkJZDfG764xHpi5lI4WmgHdEW3w1PDAyVwcfbRP8cAkz0hAhiQBFTWSKmjP
 B0eG+b/nQMtqLG/EWC1Epdp6f6vqVTr1+Tu9tlPv3v3L0XpT5+k1XfbadedvPgG4lAWm
 wtag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695993389; x=1696598189;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gd3dYYe3g7a29l/kFnJV7ukUC3DXofEZJppgtkl7vEk=;
 b=aDBJ7GWk/eodtwV2NjoEIC8thyg1LX9ttS30X+TtNSepRGLPgIIsGRDPADMHiBSbIk
 jrpSTbquobwMki9+JJXTMzollQc8jNe9SJktKfypYTSZYW63fw4ywgK/4YrleC7o1blM
 ojgb9Z/jVGiM0VEFkCzFDrV17nJFUD7Lqz5FvpO+/Kp5PpsBojyhmuKdNFeMjOZ1RGIh
 MfpDGyhT3I0muiorBJO8rdDGKdQyTghv6C5Q8J6QUsXvVQXkwcQS/EWrmQY6zm5jefqz
 jTbbxVu8DkA1kMcXkLOFgVK+x7M6pzXqBLazVdeY6wk+n1G8Ql8p376bJXn6ITxLl/rf
 voZQ==
X-Gm-Message-State: AOJu0Yy3V/QPJGUCn/eNZPt5FxR3STAC7Qxpu9q0MAAcBuWdzda8GtdN
 4cx0QrtUB3l9RwwkrdBMZd0=
X-Google-Smtp-Source: AGHT+IGbEyQRFaNDW7wt/b/Ne9hghi+Dy/GQ6VS6tkFpk7JkYFIOHCUpG8K7qoUSTg/sjRg1DYuNsA==
X-Received: by 2002:ac8:57d3:0:b0:418:a58:1cd2 with SMTP id
 w19-20020ac857d3000000b004180a581cd2mr4299522qta.51.1695993389310; 
 Fri, 29 Sep 2023 06:16:29 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-48-157-169.washdc.fios.verizon.net.
 [108.48.157.169]) by smtp.gmail.com with ESMTPSA id
 hf20-20020a05622a609400b004166905aa2asm3312546qtb.28.2023.09.29.06.16.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Sep 2023 06:16:28 -0700 (PDT)
Message-ID: <8d3ef056-1d72-727f-f158-f034c34d5786@gmail.com>
Date: Fri, 29 Sep 2023 09:16:27 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/4] mkimage: also honour -B even without external data
Content-Language: en-US
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>, u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>
References: <20230919113705.109639-1-rasmus.villemoes@prevas.dk>
 <20230919113705.109639-2-rasmus.villemoes@prevas.dk>
 <6ac71b7e-d84e-10d5-e500-0d54e5d6c191@gmail.com>
 <3fd4d611-891a-fc3d-7385-c2d621cf2eac@prevas.dk>
From: Sean Anderson <seanga2@gmail.com>
In-Reply-To: <3fd4d611-891a-fc3d-7385-c2d621cf2eac@prevas.dk>
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

T24gOS8yOC8yMyAwMzoxMCwgUmFzbXVzIFZpbGxlbW9lcyB3cm90ZToNCj4gT24gMjcvMDkv
MjAyMyAyMS4wMiwgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4+IE9uIDkvMTkvMjMgMDc6Mzcs
IFJhc211cyBWaWxsZW1vZXMgd3JvdGU6DQo+Pj4gSW4gc29tZSBjYXNlcywgdXNpbmcgdGhl
ICJleHRlcm5hbCBkYXRhIiBmZWF0dXJlIGlzIGltcG9zc2libGUgb3INCj4+PiB1bmRlc2ly
YWJsZSwgYnV0IG9uZSBtYXkgc3RpbGwgd2FudCAob3IgbmVlZCkgdGhlIEZJVCBpbWFnZSB0
byBoYXZlIGENCj4+PiBjZXJ0YWluIGFsaWdubWVudC4gQWxzbywgZ2l2ZW4gdGhlIGN1cnJl
bnQgJ21raW1hZ2UgLWgnIG91dHB1dCwNCj4+Pg0KPj4+ICDCoMKgIC1CID0+IGFsaWduIHNp
emUgaW4gaGV4IGZvciBGSVQgc3RydWN0dXJlIGFuZCBoZWFkZXINCj4+Pg0KPj4+IGl0IGlz
IHF1aXRlIHVuZXhwZWN0ZWQgZm9yIC1CIHRvIGJlIGVmZmVjdGl2ZWx5IGlnbm9yZWQgd2l0
aG91dCAtRS4NCj4+DQo+PiBGV0lXLCB0aGlzIGJlaGF2aW9yIGlzIGRvY3VtZW50ZWQgaW4g
ZG9jL21raW1hZ2UuMSAod2hpY2ggc2hvdWxkIGFsc28gYmUNCj4+IHVwZGF0ZWQgaWYgdGhp
cyBiZWhhdmlvciBpcyBpbXBsZW1lbnRlZCk6DQo+Pg0KPj4gfCBUaGUgYWxpZ25tZW50LCBp
biBoZXhhZGVjaW1hbCwgdGhhdCBleHRlcm5hbCBkYXRhIHdpbGwgYmUgYWxpZ25lZCB0by4N
Cj4+IHwgVGhpcyBvcHRpb24gb25seSBoYXMgYW4gZWZmZWN0IHdoZW4gLUUgaXMgc3BlY2lm
aWVkLg0KPiANCj4gSSdsbCBzZW5kIGEgZm9sbG93LXVwIHRvIGZpeCB0aGF0LCB0aGFua3Mu
DQo+IA0KPj4gQW5kLCBmb3IgYWRkaXRpb25hbCBjb250ZXh0LCB0aGUgZG9jdW1lbnRhdGlv
biBmb3IgLUUgaXMNCj4+DQo+PiB8IEFmdGVyIHByb2Nlc3NpbmcsIG1vdmUgdGhlIGltYWdl
IGRhdGEgb3V0c2lkZSB0aGUgRklUIGFuZCBzdG9yZSBhIGRhdGENCj4+IHwgb2Zmc2V0IGlu
IHRoZSBGSVQuIEltYWdlcyB3aWxsIGJlIHBsYWNlZCBvbmUgYWZ0ZXIgdGhlIG90aGVyDQo+
PiB8IGltbWVkaWF0ZWx5IGFmdGVyIHRoZSBGSVQsIHdpdGggZWFjaCBvbmUgYWxpZ25lZCB0
byBhIDQtYnl0ZSBib3VuZGFyeS4NCj4+IHwgVGhlIGV4aXN0aW5nIOKAmGRhdGHigJkgcHJv
cGVydHkgaW4gZWFjaCBpbWFnZSB3aWxsIGJlIHJlcGxhY2VkIHdpdGgNCj4+IHwg4oCYZGF0
YS1vZmZzZXTigJkgYW5kIOKAmGRhdGEtc2l6ZeKAmSBwcm9wZXJ0aWVzLiBBIOKAmGRhdGEt
b2Zmc2V04oCZIG9mIDANCj4+IHwgaW5kaWNhdGVzIHRoYXQgaXQgc3RhcnRzIGluIHRoZSBm
aXJzdCAoNC1ieXRlLWFsaWduZWQpIGJ5dGUgYWZ0ZXIgdGhlDQo+PiB8IEZJVC4NCj4+DQo+
PiBCYXNlZCBvbiB0aGlzIGRvY3VtZW50YXRpb24gYW5kIG15IHVuZGVyc3RhbmRpbmcgb2Yg
dGhlIGNvZGUgYXMtaXMsIC1CDQo+PiBjb250cm9scyB0aGUgYWxpZ25tZW50IG9mIHRoZSBp
bWFnZXMgdGhlbXNlbHZlcywNCj4gDQo+IFllcywgd2hlbiAtRSBpcyBpbiBlZmZlY3QuIE15
IHBhdGNoIGRvZXMgbm90IGFmZmVjdCB0aGUgY2FzZSB3aGVyZSAtRSBpcw0KPiBwcmVzZW50
Lg0KDQpXaGVyZXZlciBwb3NzaWJsZSwgZmxhZ3Mgc2hvdWxkIGJlIG9ydGhvZ29uYWwuIFRo
YXQgaXMsIHRoZXkgc2hvdWxkIGhhdmUgdGhlDQpzYW1lIGVmZmVjdCAob3IgYXQgbGVhc3Qg
dGhlIHNhbWUgc3Bpcml0KSByZWdhcmRsZXNzIG9mIHRoZSBwcmVzZW5jZSBvZiBvdGhlcg0K
ZmxhZ3MuIFRoaXMgbWF0Y2hlcyB0aGVpciBVWCwgYXMgb3J0aG9nb25hbGx5IHNlbGVjdGFi
bGUgb3B0aW9ucy4NCg0KPj4gbm90IHRoZSBzaXplIG11bHRpcGxlIG9mIHRoZSBGSVQuDQo+
IA0KPiBJdCBpcyBfYWxzb18gdGhhdCwgYnV0IG1vc3RseSBhcyBhICJuZWNlc3Nhcnkgc2lk
ZSBlZmZlY3QiIG9mIGdldHRpbmcNCj4gdGhlIGZpcnN0IGltYWdlIGFsaWduZWQuIEluIG9y
ZGVyIHRvIGFjaGlldmUgdGhlIGRlc2lyZWQgYWxpZ25tZW50IG9mDQo+IHRoZSBmaXJzdCBl
eHRlcm5hbCBpbWFnZSwgdGhlIEZJVCBzdHJ1Y3R1cmUgaXRzZWxmIGlzIGFsaWduZWQgdG8g
dGhlIC1CDQo+IHZhbHVlLCBhbmQgZWFjaCBpbWFnZSdzIHNpemUgc2ltaWxhcmx5IGFsaWdu
ZWQgdXAgdG8gdGhhdCB2YWx1ZSBzbyB0aGUNCj4gbmV4dCBpbWFnZSBlbmRzIG9uIGEgLUIg
bXVsdGlwbGUgYWdhaW4uIFNvIHdpdGggYm90aCAtRSBhbmQgLUIsIHRoZSBGSVQNCj4gc3Ry
dWN0dXJlIGl0c2VsZiBpcyBpbmRlZWQgYWxzbyBwYWRkZWQgdG8gdGhlIC1CIHZhbHVlLCBh
cyB0aGUgYG1raW1hZ2UNCj4gLWhgIG91dHB1dCBzdWdnZXN0cy4NCg0KVGhlIGludGVudCBv
ZiAtQiBpcyB0byBhbGlnbiBpbWFnZXMuIFRoYXQgdGhlIEZJVCBpdHNlbGYgaXMgcGFkZGVk
IGlzIGFuDQppbXBsZW1lbnRhdGlvbiBkZXRhaWwuDQoNCj4gV2hhdCBJIHdhbnQsIGFuZCBl
eHBlY3RlZCBmcm9tIGBta2ltYWdlIC1oYCwgaXMgdG8gbWFrZSB0aGUgd2hvbGUgRklUDQo+
IGhhdmUgYSBjZXJ0YWluIHNpemUgbXVsdGlwbGUsIHdpdGhvdXQgdXNpbmcgLUUsIHNvIGlu
IHRoYXQgY2FzZSB0aGUNCj4gYWxpZ25tZW50IG9mIHRoZSBGSVQgaXMgdGhlIHByaW1hcnkg
Z29hbC4NCg0KV2h5IGRvZXMgbWtpbWFnZSBoYXZlIHRvIGRvIHRoaXM/IENhbid0IHlvdSBq
dXN0IHVzZSB0cnVuY2F0ZSBvciwgaW4gYQ0KYmlubWFuIGNvbnRleHQsIGFsaWduLXNpemU/
DQoNCj4+IEhvd2V2ZXIsIGZyb20gd2hhdCBJIGNhbiB0ZWxsLCB0aGlzIHBhdGNoIGRvZXMg
bm90IGFjdHVhbGx5DQo+PiBhZmZlY3QgdGhlIGFsaWdubWVudCBvZiB0aGUgaW1hZ2VzLA0K
PiANCj4gTm8sIGJlY2F1c2UgdGhlIGltYWdlcyBhcmUgKHN0aWxsKSBlbWJlZGRlZCB3aXRo
aW4gdGhlIEZJVCBhcyBvcmRpbmFyeQ0KPiB2YWx1ZXMgb2YgdGhlIGRhdGE9IHByb3BlcnRp
ZXMsIGFuZCBpdCdzIGEgYmFzaWMgcHJvcGVydHkgb2YgdGhlIERUQg0KPiBmb3JtYXQgdGhh
dCB0aG9zZSBhcmUgYWx3YXlzIDQtYnl0ZSBhbGlnbmVkLCBhbmQgeW91IGNhbid0IChlYXNp
bHkpDQo+IGNoYW5nZSB0aGF0IFsxXS4gV2hpY2gsIEkgc3VwcG9zZSwgaXMgb25lIG9mIHRo
ZSByZWFzb25zIFUtQm9vdCBpbnZlbnRlZA0KPiB0aGUgImV4dGVybmFsIGRhdGEiIG1lY2hh
bmlzbSAtIHNvIGZvciBleGFtcGxlIHRoZSAuZHRicyBlbWJlZGRlZCBpbiB0aGUNCj4gRklU
IGNhbiBhbGwgYmUgZ3VhcmFudGVlZCB0byBiZSBvbiBhbiA4LWJ5dGUgYm91bmRhcnksIGFu
ZCB0aHVzIHRoZQ0KPiBzZWxlY3RlZCBvbmUgY2FuIGJlIHVzZWQgaW4tcGxhY2Ugd2hlbiBw
YXNzZWQgdG8gbGludXguDQo+IA0KPj4gYnV0IHJhdGhlciBhZGp1c3RzIHRoZSBzaXplIG9m
IHRoZQ0KPj4gb3ZlcmFsbCBGSVQgdG8gYSBjZXJ0YWluIGFsaWdubWVudC4gSSBmaW5kIHRo
aXMgcmF0aGVyIHVuZXhwZWN0ZWQuDQo+IA0KPiBXZWxsLCBhcyBJIHNhaWQsIF9JXyB3YXMg
c3VycHJpc2VkIGJ5IC1CIGhhdmluZyBubyBlZmZlY3QgYmFzZWQgb24gdGhlDQo+IGBta2lt
YWdlIC1oYCBvdXRwdXQsIHNvIHRoZSB0d28gc291cmNlcyBvZiBkb2N1bWVudGF0aW9uIHdl
cmUgbm90IGluDQo+IHN5bmMuIFRoZSBtYW4gcGFnZSB3YXMvaXMgY29ycmVjdCB3cnQuIHRo
ZSBhY3R1YWwgY29kZS4NCg0KVGhlIG1raW1hZ2UgLWggcHV0cHV0IGlzIHRvbyB0ZXJzZSB0
byByZWNvcmQgdGhlIGNvbXBsZXRlIGJlaGF2aW9yIG9mDQplYWNoIG9wdGlvbi4gUGVyaGFw
cyB3ZSBzaG91bGQgYWRkIGEgd2FybmluZyB3aGVuIC1CIGlzIHNwZWNpZmllZCB3aXRob3V0
DQotRS4NCg0KPiBSYXNtdXMNCj4gDQo+IFsxXSBUaGVyZSdzIGEgbm9wIHRhZyBvbmUgY2Fu
IGluc2VydCwgYW5kIEkgdGhpbmsgSSBzYXcgc29tZWJvZHkNCj4gYWN0dWFsbHkgc3VnZ2Vz
dGluZyB0byBkbyB0aGF0IHRvIGFsaWduIHRoZSBlbWJlZGRlZCBkYXRhPSBwcm9wZXJ0aWVz
LA0KPiBidXQgaXQncyBxdWl0ZSBlcnJvci1wcm9uZSBhbmQgaW5mbGV4aWJsZSwgYXMgYW55
IHN1YnNlcXVlbnQNCj4gbW9kaWZpY2F0aW9uIG9mIHRoZSAuZHRiIGJlZm9yZSB0aGF0IHBy
b3BlcnR5IHdpbGwgcnVpbiB0aGUgYWxpZ25tZW50Lg0KDQpUaGlzIHdvdWxkIGluZGVlZCBi
ZSB0aGUgd2F5IHRvIGdvLiBJIGRvbid0IHRoaW5rIHdlIHNob3VsZCB3b3JyeSBhYm91dA0K
ZnVydGhlciBtb2RpZmljYXRpb24gb2YgdGhlIGZkdCwgYXMgdGhpcyBjb3VsZCBhbHNvIHJ1
aW4gdGhlIGFsaWdubWVudA0Kb2YgZXh0ZXJuYWwgaW1hZ2VzLg0KDQotLVNlYW4NCg==
