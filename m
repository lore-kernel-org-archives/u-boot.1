Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F132CAC587
	for <u-boot@archiver.kernel.org>; Sat, 13 Sep 2025 05:15:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 749D9830A0;
	Sat, 13 Sep 2025 07:15:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=dietpi.com header.i=@dietpi.com header.b="l8Hfoi3I";
	dkim=permerror (0-bit key) header.d=dietpi.com header.i=@dietpi.com header.b="f6N+LOT5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 88E138341A; Sat, 13 Sep 2025 01:37:12 +0200 (CEST)
Received: from mail.dietpi.com (mail.dietpi.com [IPv6:2a01:4f8:202:41f1::])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 78B9E833BF
 for <u-boot@lists.denx.de>; Sat, 13 Sep 2025 01:37:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=dietpi.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=micha@dietpi.com
Received: from [IPV6:2003:e0:6f0b:5ed1:a958:a5fc:2115:d535]
 (p200300e06f0b5ed1a958a5fc2115d535.dip0.t-ipconnect.de
 [IPv6:2003:e0:6f0b:5ed1:a958:a5fc:2115:d535])
 by mail.dietpi.com (Postfix) with ESMTPSA id B716E27724;
 Sat, 13 Sep 2025 01:37:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dietpi.com;
 s=20250901-rsa; t=1757720229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+2xyCziJr24W1TkYfaoPonfYW+BkgMNvHBI+cAA5HE=;
 b=l8Hfoi3IY9isJPi5PfTry9N3DHcuSzJNPUCX9SB1DsEKolTyycM2zZusoKiqQ/PqddwzJk
 KpS5ldp4qpzm5yMFSplXk+z+J3OT83w10r4RUmJojIH4jSDtJDt9ll1DOfskBUDJf90hhC
 N6BHdkcdgYVLNC7g6kum83Tz0aa8RI4UubKexmgElYi/g67pnI/ZL+zJvd/KeWyl0eZoOi
 SQB4DyieP8RB7nxbxs7aTMYpkasczaG0nWQFP6p8pvY4uaAsRSJaBYOV+6a4uRlIVxqijM
 haKnKH2ZoFhhiApECtN4R6aOoTn3417ijvNCYZAucI/QYs+nDAVAgtY963j6Ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=dietpi.com;
 s=20250901-ed25519; t=1757720229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e+2xyCziJr24W1TkYfaoPonfYW+BkgMNvHBI+cAA5HE=;
 b=f6N+LOT5Z9l2HC/71nLdWMvveaQCnr+VVB/TEofqPnrrkC+zIQV/xURkCVoXTlABjyB8N9
 KJhlEqdWGtyW+cAg==
Message-ID: <688fbbca-289c-4437-ab20-9b8d2c9f8aef@dietpi.com>
Date: Sat, 13 Sep 2025 01:36:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jonas Karlman <jonas@kwiboo.se>
References: <fa35ad90-dbcd-4159-bcb3-41c4ad8d47b3@kwiboo.se>
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
Content-Language: en-GB, de-DE
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
From: MichaIng <micha@dietpi.com>
In-Reply-To: <fa35ad90-dbcd-4159-bcb3-41c4ad8d47b3@kwiboo.se>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lShwzhh0YJUnR34fWvE0n8Uz"
X-Mailman-Approved-At: Sat, 13 Sep 2025 07:15:23 +0200
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
--------------lShwzhh0YJUnR34fWvE0n8Uz
Content-Type: multipart/mixed; boundary="------------UNXTS0QT0d8PAWxkkp0tbyXs";
 protected-headers="v1"
From: MichaIng <micha@dietpi.com>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Message-ID: <688fbbca-289c-4437-ab20-9b8d2c9f8aef@dietpi.com>
Subject: Re: [PATCH] rockchip: board: assign up to 3 static Ethernet MAC
 addresses
References: <fa35ad90-dbcd-4159-bcb3-41c4ad8d47b3@kwiboo.se>
In-Reply-To: <fa35ad90-dbcd-4159-bcb3-41c4ad8d47b3@kwiboo.se>

--------------UNXTS0QT0d8PAWxkkp0tbyXs
Content-Type: multipart/mixed; boundary="------------e0mBYdI93Md1QpDgf0C7rn8v"

--------------e0mBYdI93Md1QpDgf0C7rn8v
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSm9uYXMsDQoNCiA+IEkgY2Fubm90IGZpbmQgYW55IHJvY2tjaGlwIGJvYXJkIGluIFUt
Qm9vdCBvciBMaW51eCB0aGF0IGN1cnJlbnRseSB1c2UNCiA+IGEgZXRoZXJuZXQyIGFsaWFz
LCBoYXZlIHlvdSBzZW50IGEgTGludXggcGF0Y2ggdGhhdCBJIGhhdmUgbWlzc2VkPw0KID4N
CiA+IFRoZSBhZGRpdGlvbiBvZiBldGgxYWRkciB3YXMgZG9uZSBiZWNhdXNlIHRoZXJlIGFy
ZSBhbmQgd2FzIGluLXRyZWUNCiA+IGJvYXJkcyB0aGF0IGhhdmUgdXNlIGZvciBib3RoIGV0
aGFkZHIgYW5kIGV0aDFhZGRyLg0KID4NCiA+IFN1Z2dlc3QgeW91IHNlbmQgYSBMaW51eCBw
YXRjaCB0aGF0IGFkZHMgb3IgdXBkYXRlcyBhIHJvY2tjaGlwIGR0cyB0bw0KID4gaW5jbHVk
ZSBhbiBldGhlcm5ldDIgYWxpYXMgYmVmb3JlIHRoaXMgaXMgYXBwbGllZC4NCg0Kc29ycnkg
SSBtaXNzZWQgeW91ciBtZXNzYWdlIHRoYXQgdGltZS4gSSB0aG91Z2h0IGFib3V0IHRoZSBj
aGlja2VuJmVnZyANCmlzc3VlIHdpdGggdGhlIGFsaWFzZXMgYmVpbmcgZGVmaW5lZCBpbiBM
aW51eCBhbmQgdXNlZCBpbiBVLUJvb3QsIGFuZCANCmNob3NlIHRvIG9mZmVyIHRoZSBwYXRj
aCBmb3IgVS1Cb290IGZpcnN0LCBzaW5jZSB0aGUgYWxpYXNlcyBjYW4gYmUgDQpkZWZpbmVk
IGluIExpbnV4IHZpYSBkZXZpY2UgdHJlZSBvdmVybGF5cywgd2l0aG91dCB0b3VjaGluZyBz
b3VyY2VzIGFuZCANCnJlY29tcGlsaW5nIHRoZSBrZXJuZWwuDQoNCkkgd2lsbCBvZmZlciBh
IHBhdGNoIHRvIExpbnV4IHRoZW4sIGhvcGUgdGhlIHJlYWN0aW9uIGlzIG5vdCBzaW1pbGFy
IA0KdGhlcmUgbGlrZSAid2h5IHNob3VsZCB3ZSBkZWZpbmUgYWxpYXNlcyB3aGljaCBhcmUg
bm90IHVzZWQgYnkgYW55dGhpbmc/IiA6KQ0KDQpNYXliZSB0aGlzIGlzIHRoZSBjb21tb24g
b3JkZXIsIGFuZCBjZXJ0YWlubHkgaGFzIHRoZSBiZW5lZml0IHRoYXQgeW91IA0KY2FuIHN5
bmMgdGhlIGFsaWFzZXMgYmFjayBpbnRvIFUtQm9vdCBkZXZpY2UgdHJlZXMsIHNvIHRob3Nl
IGJlbmVmaXQgDQpmcm9tIHRoZSBzYW1lIHN0YXRpYyBNQUMgYWRkcmVzc2VzLCBpbiBjYXNl
IHRoZXkgYXJlIHJlYWxseSBhcHBsaWVkIHRvIA0KVS1Cb290IGRldmljZSB0cmVlIGFsaWFz
ZXMgYXMgd2VsbC4NCg0KSSdsbCBrZWVwIHlvdSB1cGRhdGVkIHJlZ2FyZGluZyBMaW51eCBw
YXRjaC4NCg0KQmVzdCByZWdhcmRzLA0KTWljaGENCg==
--------------e0mBYdI93Md1QpDgf0C7rn8v
Content-Type: application/pgp-keys; name="OpenPGP_0x0442B9ADE65643FE.asc"
Content-Disposition: attachment; filename="OpenPGP_0x0442B9ADE65643FE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
=3DPQvH
-----END PGP PUBLIC KEY BLOCK-----

--------------e0mBYdI93Md1QpDgf0C7rn8v--

--------------UNXTS0QT0d8PAWxkkp0tbyXs--

--------------lShwzhh0YJUnR34fWvE0n8Uz
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE2P6aXCGZuXcv9mG/zm5dDEXOFiQFAmjErpoACgkQzm5dDEXO
FiSvgw/+KzwbgA+jgEsN+ZASE0lXp8dqzTmM7HNMPs50ezY4UMIBNCx7wvqE2QeO
V28xxsO6NOGMiYbmEM97Tp8qRqpRXEv3a9S0jtD3qvUebgZvMm1+bwP03D8vyiOo
jnjzcWq539INi36ZkpiIXP3sErGgi/B+MDkb7zB449THABs+c2keB2B1gh3vVjVL
x5kZ/3nRn6OZM4s8Yv2xmwVzSFITuHWWClNK00wBtipKxkWzoVI4ltEJIor+pQ2L
qszVELr9YSImBg48J42rlz92HdgVcqB5nl/6QDJbIT21BjzLSvA1gNt80Jdmz0Vz
Q7cO6hdZLHtUhBBpHdHlXZptC/IzOqWo84khFxApWUcgp/0Y7vJIgZotlaeJuHz/
TVjWiAJhVQyGE5Bd6xAB9Aa5vXsN4u8m11pw7wrv2v2hdNjBapxEpkRbZlf7Wo9h
sIhsC8tBVgg7HSqhrGUEDMqTCnOf+SShTUeDQxcwXWsB60DZNIXaZSX0fEA6EstE
ZNmdZGZgnTwloNpZjrpdAOxUlaKVpwHyGfIrcjLJHXEMVQBR+8yQFagjRNgZPzde
pneJ2f3KUVtmRGZV70NSyrfOqh3t3RGbq9VvlnUQWPvMn2Dder7P5IndPL+GEL1I
G6Tgz/AgE1AF8W0rrrykb3Pt6BRyPmNJmtL6s/dEtHPsBaRRJ9Q=
=bJBM
-----END PGP SIGNATURE-----

--------------lShwzhh0YJUnR34fWvE0n8Uz--
