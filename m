Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B32CC47DA9
	for <u-boot@archiver.kernel.org>; Mon, 29 Jan 2024 11:55:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 821058785A;
	Mon, 29 Jan 2024 12:54:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="hr+OHonx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 464278784B; Mon, 29 Jan 2024 12:54:58 +0100 (CET)
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com
 [IPv6:2a00:1450:4864:20::12e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9A5EA877DA
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 12:54:55 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kristian.amlie@northern.tech
Received: by mail-lf1-x12e.google.com with SMTP id
 2adb3069b0e04-51030667cedso2545448e87.3
 for <u-boot@lists.denx.de>; Mon, 29 Jan 2024 03:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1706529295; x=1707134095; darn=lists.denx.de;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pY9yR5GsPn9dcqbpkZGsZusdHG7hC44mwaZpVqu2T2Q=;
 b=hr+OHonxPvkcUqMfli4Q3up0Uo16vzlRvmgbLKK1bMAOXP/77rWXF3up3WgCpqy8fv
 KkVcZFa0f+QXOreayH8JI9DeRkjaUM3lpL1vMxrYPJUlNgm5h7J/meow97W2DFb2mO5s
 KAAsuZzQ2oAukT46zEHm5xEhX5PCU8z7Pz0bR8LvRtSbwgTzYcYif9PUHGNDAm3D2ZwR
 zRnQWbw6klQjZXHNCC0E3CweGNTYUncxAltcHDY6zB32C+OMb6kGJV7DdxKsoduqSr5q
 4OhhMwEJe37M14TsnreQoEosj9uoSWHiPbxTmkORDDpLQxTf/tiLa88VygbAPmMzBhyy
 1YTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706529295; x=1707134095;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=pY9yR5GsPn9dcqbpkZGsZusdHG7hC44mwaZpVqu2T2Q=;
 b=DMzllQQm+JBxmsh3HH5OpdE+gqIUu/vxstyXqas4tLigMbbi6j9bcODKUsce/9rMl3
 iOKsJRhklj1auo2XyxGwThHjFRxd/5LQkZtHq1k+neFCv/xPdOVPsIxbXtnSQK97DhHX
 NZUKT8kLK8Vx1FGX0iba1uEPRcIVAPmRSQmikJu40nGVqmMTHkPzd6NcnuSRiu+41JHH
 o7nSA48DTzpEDPynQjRRFhSdxiDudkJruyYJox78VjP0M49eU97uA2kGOVfInjlDau8y
 Hqhl9Gz4MdT0XOHMFWWeln2ojssyrvxGMaunTM3wHwXX7ov/CtW6/G9bPzyMy8p6n/Sg
 UPYA==
X-Gm-Message-State: AOJu0YwU3+F7sZ/BNKOk3rDK6Cs+247umlQ1kXibdUaYkHr8K8pjfNOY
 coZ7kXptmln/WifHfQZK3mrffYb/9aSo3dpOqk/XAhcg1IAfabVEpPI+L2EhZTbgPStoZ1qooYi
 wINhGbO/U4sqwMrP8dXJsKZONEaKiYZciw5a4Dw7B
X-Google-Smtp-Source: AGHT+IFFm5eZT/kObq2amMFq93noUFzF6rme9OKMH4038qavFr0DdtNjvnQDAo34rOxfPsYUfJltUA==
X-Received: by 2002:a19:4346:0:b0:510:c2a:290e with SMTP id
 m6-20020a194346000000b005100c2a290emr3115900lfj.3.1706529294917; 
 Mon, 29 Jan 2024 03:54:54 -0800 (PST)
Received: from [10.180.37.174] ([91.232.32.37])
 by smtp.googlemail.com with ESMTPSA id
 o2-20020ac25e22000000b0051006e7750csm1101969lfg.186.2024.01.29.03.54.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 Jan 2024 03:54:54 -0800 (PST)
Message-ID: <ed02c9b9-5505-4aad-bc92-a2678607ff54@northern.tech>
Date: Mon, 29 Jan 2024 12:54:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
Content-Language: en-US, nb-NO
To: Ole Orhagen <ole.orhagen@northern.tech>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis
 <kettenis@openbsd.org>, Patryk Biel <pbiel7@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
 <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
From: Kristian Amlie <kristian.amlie@northern.tech>
In-Reply-To: <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qdbAHiUZBNr0OpL209bvdJb9"
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

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------qdbAHiUZBNr0OpL209bvdJb9
Content-Type: multipart/mixed; boundary="------------a6QQssVzOuYtDGbBbZJMDMSU";
 protected-headers="v1"
From: Kristian Amlie <kristian.amlie@northern.tech>
To: Ole Orhagen <ole.orhagen@northern.tech>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 =?UTF-8?B?Q3PDs2vDoXMgQmVuY2U=?= <csokas.bence@prolan.hu>,
 Fabio Estevam <festevam@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Liviu Dudau <liviu.dudau@foss.arm.com>, Mark Kettenis
 <kettenis@openbsd.org>, Patryk Biel <pbiel7@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Peter Robinson <pbrobinson@gmail.com>,
 Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
 Simon Glass <sjg@chromium.org>, Sumit Garg <sumit.garg@linaro.org>,
 Tom Rini <trini@konsulko.com>, Yang Xiwen <forbidden405@outlook.com>
Message-ID: <ed02c9b9-5505-4aad-bc92-a2678607ff54@northern.tech>
Subject: Re: [PATCH v1] vexpress_ca9x4: Enable DM_SERIAL
References: <20240126124801.1164892-1-ole.orhagen@northern.tech>
 <CACRpkdYLizF9Duy3ZCfqRsY-NMoLZJO8+TCyBHbQDqSOWuzonQ@mail.gmail.com>
 <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>
In-Reply-To: <CAD5A3Cuba_EchhDWBfej5HGHsP-T6smgL-L+C6SV_bONf6EqYA@mail.gmail.com>

--------------a6QQssVzOuYtDGbBbZJMDMSU
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjkvMDEvMjAyNCAxMjo0MSwgT2xlIE9yaGFnZW4gd3JvdGU6DQo+IA0KPiANCj4gT24g
RnJpLCBKYW4gMjYsIDIwMjQgYXQgODo1N+KAr1BNIExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZyANCj4gPG1haWx0bzpsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+
PiB3cm90ZToNCj4gDQo+ICAgICBPbiBGcmksIEphbiAyNiwgMjAyNCBhdCAxOjQ44oCvUE0g
T2xlIFAuIE9yaGFnZW4NCj4gICAgIDxvbGUub3JoYWdlbkBub3J0aGVybi50ZWNoPiB3cm90
ZToNCj4gDQo+ICAgICAgPiBUaGlzIGNvbW1pdCBlbmFibGVzIHN1cHBvcnQgZm9yIERNX1NF
UklBTCBpbiB0aGUgdmV4cHJlc3NfY2E5eDQNCj4gICAgIGJvYXJkcy4NCj4gICAgICA+DQo+
ICAgICAgPiBXaGVuIHJ1bm5pbmcgdGhlIGJvYXJkIHdpdGggdGhlIERNX1NFUklBTCBkcml2
ZXIsIHRoZSBib2FyZCByYW4NCj4gICAgIG91dCBvZg0KPiAgICAgID4gbWVtb3J5IGluIFNQ
TCB3aGVuIGluaXRpYWxpc2luZyB0aGUgRE0gc2VyaWFsIGRyaXZlci4NCj4gICAgICA+DQo+
ICAgICAgPiBUaHVzIHRoaXMgcmVxdWlyZWQgYW4gaW5jcmVhc2UgaW4gdGhlIHByZS1hbGxv
Y2F0ZWQgU1JBTSBtZW1vcnkuDQo+ICAgICBJIGRpZA0KPiAgICAgID4gaW5jcmVhc2UgaXQg
dG8gMHg4MDAsIGFuZCBpdCBub3cgd29ya3MgZ3JhY2lvdXNseS4NCj4gICAgICA+DQo+ICAg
ICAgPiBJdCBjb3VsZCBwcm9iYWJseSBiZSBzZXQgbG93ZXIsIGJ1dCBJIGRvIG5vdCBzZWUg
YW55IHJlYXNvbiBub3QNCj4gICAgIHRvIHVzZSB0aGUNCj4gICAgICA+IGF2YWlsYWJsZSBT
UkFNIGF0IHRoaXMgcG9pbnQuDQo+ICAgICAgPg0KPiAgICAgID4gQWxzbyBhZGRzIHN0ZG91
dC1wYXRoIHRvIHRoZSAnY2hvc2VuJyBub2RlIGluIHRoZSBkZXZpY2UgdHJlZS4NCj4gICAg
ICA+DQo+ICAgICAgPiBTaWduZWQtb2ZmLWJ5OiBPbGUgUC4gT3JoYWdlbiA8b2xlLm9yaGFn
ZW5Abm9ydGhlcm4udGVjaD4NCj4gDQo+ICAgICBOaWNlIQ0KPiAgICAgUmV2aWV3ZWQtYnk6
IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZw0KPiAgICAgPG1haWx0
bzpsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+Pg0KPiANCj4gICAgIEFyZSB5b3UgdXNpbmcg
dGhlIGFjdHVhbCBoYXJkd2FyZSwgb3IgUUVNVT8NCj4gDQo+IA0KPiBJIG9ubHkgaGF2ZSBR
RU1VIGF2YWlsYWJsZSwgdW5mb3J0dW5hdGVseS4NCg0KSnVzdCBwcm92aWRpbmcgc29tZSBj
b250ZXh0LCBzaW5jZSBJJ20gbGlzdGVkIGFzIG1haW50YWluZXI6IFRoaXMgYm9hcmQgDQp3
YXMgZ29pbmcgdG8gYmUgcmVtb3ZlZCBzb21lIHRpbWUgYWdvLCBidXQgd2FzIHJlc3VycmVj
dGVkIHNwZWNpZmljYWxseSANCnRvIHdvcmsgd2l0aCBRRU1VLiBUaGUgInZpcnQiIGJvYXJk
LCBhdCBsZWFzdCBhdCB0aGF0IHRpbWUsIGRpZCBub3QgDQpzdXBwb3J0IHNvbWUga2V5IEFS
TSBmZWF0dXJlcyB0aGF0IHdlIG5lZWQgaW4gb3VyIHRlc3RpbmcsIHN1Y2ggYXMgU0QgDQpj
YXJkcyBhbmQgRmxhc2guIEhlbmNlIHdlIG9wdGVkIHRvIGtlZXAgdGhpcyBib2FyZCBhcm91
bmQuIFNvIA0KY29tcGF0aWJpbGl0eSB3aXRoIGhhcmR3YXJlIGlzIG5vdCBpbXBvcnRhbnQg
dG8gdXMgYXQgbGVhc3QsIHVubGVzcyANCnNvbWVvbmUgZWxzZSBpcyByZXF1ZXN0aW5nIGl0
Lg0KDQotLSANCktyaXN0aWFuDQo=

--------------a6QQssVzOuYtDGbBbZJMDMSU--

--------------qdbAHiUZBNr0OpL209bvdJb9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENCehelwanxwH18S/9GRAfJlq8D8FAmW3kgkACgkQ9GRAfJlq
8D/9uwgAvORdsjHIwmnrJdxjO9+ncZsUoN7PGFcxBEcCmeaHZ7Esw3O4w+81IDSh
eLcIeD1pBWAxfZnqzX8rkB7llmVNlkyQLlSK51OLdNRJuiuIWiUycwzPXabBGKXj
mqORHch/tBx+W4HNe7kRwSBxJ3NGO3t6hIplQ25p1KPUUV2bPEBG8irFhY26ZbJJ
JmXVfMBei6+RGy8+ZidSLC45wLub9Wf5Qmo8uDzw6FBxvpRsvQVcCa+Jj/P5uZJN
ioYE70iqwbSsPE3BMDf8RjP5es7kF4/qH95Lq4MyjcMwNBeCNLja86KObodk0Rxv
ppl222M+ElGTeP4zfL1HIvlMfzyzvg==
=z9Zd
-----END PGP SIGNATURE-----

--------------qdbAHiUZBNr0OpL209bvdJb9--
