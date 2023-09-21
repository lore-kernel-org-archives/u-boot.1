Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63DD1E706EF
	for <u-boot@archiver.kernel.org>; Thu, 21 Sep 2023 08:33:02 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 47FF8864C4;
	Thu, 21 Sep 2023 10:33:00 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=northern.tech
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=northern.tech header.i=@northern.tech header.b="aHoMA/tT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C666886487; Thu, 21 Sep 2023 10:32:58 +0200 (CEST)
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com
 [IPv6:2a00:1450:4864:20::22b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C899386405
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 10:32:56 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none)
 header.from=northern.tech
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=kristian.amlie@northern.tech
Received: by mail-lj1-x22b.google.com with SMTP id
 38308e7fff4ca-2c012232792so11203901fa.0
 for <u-boot@lists.denx.de>; Thu, 21 Sep 2023 01:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=northern.tech; s=google; t=1695285176; x=1695889976; darn=lists.denx.de;
 h=in-reply-to:subject:from:content-language:references:to:user-agent
 :mime-version:date:message-id:from:to:cc:subject:date:message-id
 :reply-to; bh=afu4CvhFzOMYuq4e7UVUwkaER/BRLNtEnZklslU3W+c=;
 b=aHoMA/tTZrxTl6s1F3Mfv9VmsKfWPz0cxxz6nClHRHmDXHbEwYWl5YiSTjZNUeaKzE
 O44gKaLta5LGS4HHwe+fmt6nyRTbdbta39E3Ir1O/W8N9q6MxW+Bzr52X/ayQTXSAuWP
 xcIfGtBe64AQgm2LK05XgQw5kYEuShyexl5Zqrqld0gvd04bZQBryCpEpscDPaj3N7nn
 7ahcDJJKTnMZrN3ruq20ENcxQUjqrwKAg+nC/oS/mHg7JpzTvYBSECPG2fLSy+JC5MkO
 r1ZTPo/VY+0xxDNYCFgZTjwjZ3xft3NfhOMYUY9PZ9NKocJ5JpR9s0BG9LJUxVC/frIs
 AZHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695285176; x=1695889976;
 h=in-reply-to:subject:from:content-language:references:to:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=afu4CvhFzOMYuq4e7UVUwkaER/BRLNtEnZklslU3W+c=;
 b=Qb/CncvnTWF7bQCMq/yNR0v8GxNMjAxS8YKM+mgIV5D2n4xEyDPLmDi7csuJYQI4OC
 W1uwcEp4CvomePVX6qIo9pkKi85tyV17XtY7SWYt2Y9iKda6KoeHEiPDOPAz2dZAS4wU
 1c8tA68W2UqG5DDOHsDNLVSc5X7Ep7NHC62t9sbEge69kpT4nJCADqh4D2eGH80sVv82
 1rDv75kVoQnBwIv9v2jiH+qwV5yHs71xzz1yIRWfwRg/c+XTbS+ydMRNikraNg7ONGTw
 QWCKFR8fNgsUKFpeIsjSp3ns3lxkt4yX6eP3YJ8+48hZPh/0AM92cA3OR77h59Hm4Uow
 2lNQ==
X-Gm-Message-State: AOJu0Yy8Bki+dGb3b0XOsMOeaxBIeTymDJyhNvpvlREUzDsMfK0fJbW1
 3GUkh040deNErAmSrEMc2UBce9tDEKIC8NP6gNoYx2Xrww1ubauhzySV4gT24wX84vdwvjVUcrE
 SHfM9
X-Google-Smtp-Source: AGHT+IG0n40SpSIL7HyUw9PqtsMHJUvTbNJS6ZdKF5toGe0c91iNaIquvrAF44/Df9qP/8FbJv7irw==
X-Received: by 2002:a2e:9189:0:b0:2b9:e53f:e1fd with SMTP id
 f9-20020a2e9189000000b002b9e53fe1fdmr4254316ljg.34.1695285175209; 
 Thu, 21 Sep 2023 01:32:55 -0700 (PDT)
Received: from [10.180.37.25] ([91.232.32.37])
 by smtp.googlemail.com with ESMTPSA id
 v21-20020a2e7a15000000b002be5d222c60sm219002ljc.102.2023.09.21.01.32.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 Sep 2023 01:32:54 -0700 (PDT)
Message-ID: <f7d1d432-212e-6efe-e653-16898e4bfd4e@northern.tech>
Date: Thu, 21 Sep 2023 10:32:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
To: Patryk Biel <pbiel7@gmail.com>, u-boot@lists.denx.de
References: <20230920074120.394487-1-pbiel7@gmail.com>
Content-Language: en-US, nb-NO
From: Kristian Amlie <kristian.amlie@northern.tech>
Subject: Re: [PATCH] ARM: vexpress_ca9x4: Add missing flash width config option
In-Reply-To: <20230920074120.394487-1-pbiel7@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------qU1IdQQ2x0Sr0mlWKPhd0tcN"
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
--------------qU1IdQQ2x0Sr0mlWKPhd0tcN
Content-Type: multipart/mixed; boundary="------------bQDF6r0UkCgcJT0gYcSiSp3m";
 protected-headers="v1"
From: Kristian Amlie <kristian.amlie@northern.tech>
To: Patryk Biel <pbiel7@gmail.com>, u-boot@lists.denx.de
Message-ID: <f7d1d432-212e-6efe-e653-16898e4bfd4e@northern.tech>
Subject: Re: [PATCH] ARM: vexpress_ca9x4: Add missing flash width config
 option
References: <20230920074120.394487-1-pbiel7@gmail.com>
In-Reply-To: <20230920074120.394487-1-pbiel7@gmail.com>

--------------bQDF6r0UkCgcJT0gYcSiSp3m
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAvMDkvMjAyMyAwOTo0MSwgUGF0cnlrIEJpZWwgd3JvdGU6DQo+IEFsbG93IGZvciBh
IHByb3BlciBjb25maWd1cmF0aW9uIG9mIENGSSBmbGFzaCBiYW5rcyBhdmFpYWxibGUgb24g
dGhlIHZleHByZXNzX2NhOXg0DQo+IGJvYXJkLiBXaXRob3V0IHRoaXMgb3B0aW9uLCB0aGUg
Q0ZJIGZsYXNoIGluY29ycmVjdGx5IGRldGVjdHMgdGhhdCB0aGUgYm9hcmQgaGFzIHR3bw0K
PiBiYW5rcyBvZiAzMk1CIGZsYXNoIGRldmljZXMsIHdoaWxlIGluIHJlYWxpdHksIHRoZSBi
b2FyZCBwcm92aWRlcw0KPiB0d28gZmxhc2ggYmFua3MsIGVhY2ggd2l0aCA2NE1CIHNpemUu
IEFzIGEgcmVzdWx0LCBpdCBiZWNvbWVzIGltcG9zc2libGUgdG8gZS5nLiB0bw0KPiBzYXZl
IHUtYm9vdCBlbnYgaW4gZmxhc2guIEFjY29yZGluZyB0byBkZXZpY2UgdHJlZSBmb3IgdGhp
cyBib2FyZCBhbmQNCj4gaXRzIGltcGxlbWVudGF0aW9uIGluIFFFTVUsIHRoZSBDRkkgd2lk
dGggc2hvdWxkIGJlIHNldCB0byAzMiBiaXRzLg0KPiANCj4gQWZ0ZXIgYXBwbHlpbmcgdGhp
cyBmaXgsIENGSSBmbGFzaCB3aWxsIGNvcnJlY3RseSBkZXRlY3QgYm90aCBmbGFzaA0KPiBi
YW5rcyBlYWNoIHdpdGggYSBzaXplIG9mIDY0TUIuIEFzIGFzIHJlc3VsdCB0aGUgZnVuY3Rp
b25hbGl0eSBvZiBlLmcuIHNhdmluZyB1LWJvb3QNCj4gZW52IHdpbGwgd29yayBjb3JyZWN0
bHkuDQo+IA0KPiBUZXN0ZWQgb24gUUVNVSA2LjIuMC4NCj4gDQo+IENjOiBLcmlzdGlhbiBB
bWxpZSA8a3Jpc3RpYW4uYW1saWVAbm9ydGhlcm4udGVjaD4NCj4gU2lnbmVkLW9mZi1ieTog
UGF0cnlrIEJpZWwgPHBiaWVsN0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgIGNvbmZpZ3MvdmV4
cHJlc3NfY2E5eDRfZGVmY29uZmlnIHwgMSArDQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvY29uZmlncy92ZXhwcmVzc19jYTl4NF9k
ZWZjb25maWcgYi9jb25maWdzL3ZleHByZXNzX2NhOXg0X2RlZmNvbmZpZw0KPiBpbmRleCA1
Y2FjZWNjN2NiLi5hYzljMGUxZDcxIDEwMDY0NA0KPiAtLS0gYS9jb25maWdzL3ZleHByZXNz
X2NhOXg0X2RlZmNvbmZpZw0KPiArKysgYi9jb25maWdzL3ZleHByZXNzX2NhOXg0X2RlZmNv
bmZpZw0KPiBAQCAtNTUsMyArNTUsNCBAQCBDT05GSUdfU01DOTExWF8zMl9CSVQ9eQ0KPiAg
IENPTkZJR19CQVVEUkFURT0zODQwMA0KPiAgIENPTkZJR19DT05TX0lOREVYPTANCj4gICBD
T05GSUdfU1lTX1RJTUVSX0NPVU5UU19ET1dOPXkNCj4gK0NPTkZJR19TWVNfRkxBU0hfQ0ZJ
X1dJRFRIXzMyQklUPXkNCg0KUmV2aWV3ZWQtYnk6IEtyaXN0aWFuIEFtbGllIDxrcmlzdGlh
bi5hbWxpZUBub3J0aGVybi50ZWNoPg0KDQpJIGJlbGlldmUgdGhpcyBzaG91bGQgYmUgZmlu
ZS4NCg0KVGhpcyBpcyBwcm9iYWJseSBhIHJlY2VudCBpc3N1ZSwgc2luY2Ugd2UgYXJlIHVz
aW5nIHRoZSA2NE1CIGJhbmtzIA0KYWxyZWFkeSBpbiBvdXIgdGVzdCBzZXR1cCwgYW5kIGl0
J3Mgd29ya2luZy4gQnV0IGl0J3MgYmFzZWQgb24gdjIwMjIuMDEsIA0Kc28gaXQncyBhIGJp
dCBvbGRlci4NCg0KLS0gDQpLcmlzdGlhbg0K

--------------bQDF6r0UkCgcJT0gYcSiSp3m--

--------------qU1IdQQ2x0Sr0mlWKPhd0tcN
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEENCehelwanxwH18S/9GRAfJlq8D8FAmUL/7UACgkQ9GRAfJlq
8D+UIgf9GneLyMl+M4fVCQfw7NnXkdzbsQ1iD3kzpzdmgjuxhEPz0RcxE8n6gwkY
szw8VJMAEjpFFvlhnzv3x58KkhhJl5l95h9XljC6wL3Zxe8UBf4x3o/l3Y7Dsbvv
RBwqpSpa2pNfAAwmH6YGTcOpMofEoTzLuEGxIgJyfCaKLe3DS3j7lF2KqEl9vjrG
bg+HYBwHmrWALQIT/gjKGlRA5XJKO7BmOfE3zJNPGMKdPBYA062eCiML5d96yogy
mDhfYlBQnpghzMXNt1TXOtiuFu2/h/GgZWQx6QbTb11EpChY1Jb4EfYGn5IkF2xF
7GAjfaMvwMjOFSGs5Q/CmUVjhBS2tQ==
=EhB0
-----END PGP SIGNATURE-----

--------------qU1IdQQ2x0Sr0mlWKPhd0tcN--
