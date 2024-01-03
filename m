Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D8EC47077
	for <u-boot@archiver.kernel.org>; Wed,  3 Jan 2024 08:18:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C2E5B87988;
	Wed,  3 Jan 2024 09:18:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="KEKaipSw";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7B1D087988; Wed,  3 Jan 2024 09:18:13 +0100 (CET)
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com
 [IPv6:2a00:1450:4864:20::134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E993787987
 for <u-boot@lists.denx.de>; Wed,  3 Jan 2024 09:18:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kristian.amlie@northern.tech
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e7abe4be4so8240635e87.2
 for <u-boot@lists.denx.de>; Wed, 03 Jan 2024 00:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1704269890; x=1704874690; darn=lists.denx.de;
 h=in-reply-to:content-language:from:references:to:subject:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=CaQBcJsW1GLzjhAHwDTMWPmRX5XXC7vP1+ybKpuLAgk=;
 b=KEKaipSw4UT0+Lr1eK4Iuu4MNd0skkwmGN39nlAYA/sZJ0S56bd3m9ltlmoRUlq8FD
 tgHhejTzLJZ1kSIO13qfbx+4+rAtxm1w9nYC57TJ1ra5zFpFkjf2uddWNPs135UHNGJu
 q2Z5vSvkivuqwVooFdD6soAh5gg3R2366I+JBL7YqdmtHJ2OBemtI8CK7KTTWtufKu0o
 gNN0J86VwQrLjyX6gCRXXSv1nml/3z+Y2kI9Zm3SZulR0yWsI6RF9gRSKc71ptqGwPeR
 u5OQVRZkgZ/GrFRFshwkzg391LocQaOIoCIJl5xK+8LRJJz/DV+Zkl0VN7tTZsktLPRj
 xa9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704269890; x=1704874690;
 h=in-reply-to:content-language:from:references:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CaQBcJsW1GLzjhAHwDTMWPmRX5XXC7vP1+ybKpuLAgk=;
 b=hPcIn0bv487Y2gQ9Z3p4ElEljCPIbLShYyMgjC3BKV6s5TnV5GasUVMd411CKCZN9E
 y0U0CMKUnGHMYgQTc4y1fJSZOpVf40vxfNqrCKgCHH4cWQ1fpNm9EwLNDdYPKGkR/i1y
 YZWLv/nB7ecneDo7QqQql9jxU+kWOAzHGcJHd67Rgzwto8NYvS2oDIjqpWV3wyr9ai6Q
 Q38N46z46XaxfTqh8QjYjzg1kTna1OtAkhDMvAZOgzYVg2G8MRqeQ72+T29hbdZo8P6W
 wjiH7HYu4CkCwVCWKkL1nTR1fHcLsWBYwVXH1+1L7LE7LMW3NhYX9j9tmoXdmEsy8wr1
 W07g==
X-Gm-Message-State: AOJu0Yw3aSaCnVQFz8XnxCfW4Kj0w9LXe1E8/EymxXVEOhhwKUN6KjF+
 jBwIjhRPBeGfMR0EkfotKItnsKiJE/+1ls5QwdnX7Kmilfi3px41EefJI9nTH/1/pVr1ZOADy0j
 8cgW6L/QbM2otVDhwfelgXODeX18=
X-Google-Smtp-Source: AGHT+IH6u8U5bxCa/JiCgo2mfqwtx9+nUkfad2CBEcg1W5RKAwPk80ru9qvjabF0BmZCs3NvHGQaYQ==
X-Received: by 2002:a05:6512:3b08:b0:50e:7c70:f8da with SMTP id
 f8-20020a0565123b0800b0050e7c70f8damr7389988lfv.16.1704269890031; 
 Wed, 03 Jan 2024 00:18:10 -0800 (PST)
Received: from [10.180.37.239] ([91.232.32.37])
 by smtp.googlemail.com with ESMTPSA id
 su14-20020a17090703ce00b00a235b1e81b4sm12343240ejb.114.2024.01.03.00.18.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Jan 2024 00:18:09 -0800 (PST)
Message-ID: <4cea9f42-9948-45a0-8f0a-31cd41e7095d@northern.tech>
Date: Wed, 3 Jan 2024 09:18:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: vexpress and DM_SERIAL
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
References: <CAFLszTjvFWYNJGK_cAo6UuGNcBqO1KSGWUS4j58DHM_fu6V_Tw@mail.gmail.com>
From: Kristian Amlie <kristian.amlie@northern.tech>
Content-Language: en-US, nb-NO
In-Reply-To: <CAFLszTjvFWYNJGK_cAo6UuGNcBqO1KSGWUS4j58DHM_fu6V_Tw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2MEaoE2KNDgr3csReSrmvyb2"
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
--------------2MEaoE2KNDgr3csReSrmvyb2
Content-Type: multipart/mixed; boundary="------------1V90kgyyx6IPZraF77n35c0Y";
 protected-headers="v1"
From: Kristian Amlie <kristian.amlie@northern.tech>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Message-ID: <4cea9f42-9948-45a0-8f0a-31cd41e7095d@northern.tech>
Subject: Re: vexpress and DM_SERIAL
References: <CAFLszTjvFWYNJGK_cAo6UuGNcBqO1KSGWUS4j58DHM_fu6V_Tw@mail.gmail.com>
In-Reply-To: <CAFLszTjvFWYNJGK_cAo6UuGNcBqO1KSGWUS4j58DHM_fu6V_Tw@mail.gmail.com>

--------------1V90kgyyx6IPZraF77n35c0Y
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjcvMTIvMjAyMyAwODo1NSwgU2ltb24gR2xhc3Mgd3JvdGU6DQo+IEhpIEtyaXN0aWFu
LA0KPiANCj4gRG8geW91IHRoaW5rIGl0IHdvdWxkIGJlIHBvc3NpYmxlIHRvIG1pZ3JhdGUg
dGhlIHZleHByZXNzX2NhOXg0IGJvYXJkDQo+IHRvIHVzZSBETV9TRVJJQUw/DQoNClllcyEg
VGhpcyBoYXMgdGFrZW4gdGhlIGJhY2tzZWF0IGZvciBhIHdoaWxlIGR1ZSB0byBvdGhlciBw
cmlvcml0aWVzLCANCmJ1dCBpdCdzIGJhY2sgbmVhciB0aGUgdG9wIG9mIG91ciBiYWNrbG9n
IG5vdy4gT3VyIGdvYWwgaXMgdG8gaGF2ZSB0aGlzIA0Kc29sdmVkIGluIHRoZSBmaXJzdCBx
dWFydGVyLg0KDQotLSANCgkqS3Jpc3RpYW4gQW1saWUqDQpTb2Z0d2FyZSBFbmdpbmVlciB8
IE1lbmRlciA8aHR0cHM6Ly9tZW5kZXIuaW8+DQpPc2xvLCBOb3J3YXkNCjxodHRwczovL3d3
dy5saW5rZWRpbi5jb20vY29tcGFueS9ub3J0aGVybi50ZWNoPjxodHRwczovL3R3aXR0ZXIu
Y29tL25vcnRoZXJudGVjaGhxPjxodHRwczovL25vcnRoZXJuLnRlY2g+DQoJTm9ydGhlcm4u
dGVjaCA8aHR0cHM6Ly9ub3J0aGVybi50ZWNoPiB8IFNlY3VyaW5nIHRoZSB3b3JsZCdzIGNv
bm5lY3RlZA0KZGV2aWNlcw0KDQoNCg==

--------------1V90kgyyx6IPZraF77n35c0Y--

--------------2MEaoE2KNDgr3csReSrmvyb2
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENCehelwanxwH18S/9GRAfJlq8D8FAmWVGEAACgkQ9GRAfJlq
8D/vWgf/S6ccQydgp0HIaTVKGg5ayrfS+PMJ+NAmVQ4q+qHZHJNRsoVkL4E0vUty
XfM7e9FVLa1A71OP3dSQ1JRVAwUtqFdu+prskDsrF+CYUkG3GbhXvUiIxsffyJdY
P3ns71w9Dq4KER/8+HFqeNtdW3nSqr/q/cv9MlluvpbAcvtNfYkNMa2c8TemnKgi
fA9ckBK4gS63UrdTEBs80er8+6Aa6DXCiJWpoOlxucLUljl8OTleDyltKN1pbiyx
eyYxVv9uVb2s/SUzYIVdcGaGcdo2wg96aOw/uEQz+eqbwLZd/z0cTfSMLg4ugEzV
OI0QypoWiXaqAODeuZtW46U0yBtazw==
=sT1W
-----END PGP SIGNATURE-----

--------------2MEaoE2KNDgr3csReSrmvyb2--
