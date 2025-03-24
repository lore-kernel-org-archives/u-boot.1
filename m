Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B20B8C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:46:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D5B66806FC;
	Mon, 24 Mar 2025 16:46:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=3mdeb.com header.i=@3mdeb.com header.b="DCXSSnAH";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B7305806FC; Mon, 24 Mar 2025 16:46:18 +0100 (CET)
Received: from 12.mo550.mail-out.ovh.net (12.mo550.mail-out.ovh.net
 [87.98.162.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 36C36805D7
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 16:46:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maciej.pijanowski@3mdeb.com
Received: from director7.ghost.mail-out.ovh.net (unknown [10.108.9.253])
 by mo550.mail-out.ovh.net (Postfix) with ESMTP id 4ZLy863ybdz1bkG
 for <u-boot@lists.denx.de>; Mon, 24 Mar 2025 15:46:14 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-cfcv8 (unknown [10.108.42.79])
 by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 2CE601FDDA;
 Mon, 24 Mar 2025 15:46:13 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.108])
 by ghost-submission-5b5ff79f4f-cfcv8 with ESMTPSA
 id 7dmOJ0V+4Wf9VQAAIzSkvg
 (envelope-from <maciej.pijanowski@3mdeb.com>); Mon, 24 Mar 2025 15:46:13 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-108S002c41b25a6-ad29-4113-afd4-2d895e736d64,
 5546B6D7EA01F948F6BD0E207D16FD70EFEE0835)
 smtp.auth=maciej.pijanowski@3mdeb.com
X-OVh-ClientIp: 213.192.77.249
Message-ID: <b8f68653-1d3a-4198-9c75-c8e0405e553c@3mdeb.com>
Date: Mon, 24 Mar 2025 16:46:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: danct12@riseup.net, u-boot@lists.denx.de
From: Maciej Pijanowski <maciej.pijanowski@3mdeb.com>
Subject: Re: [PATCH v2 00/11] Rockchip VOP2 support
Autocrypt: addr=maciej.pijanowski@3mdeb.com; keydata=
 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
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WUkI6R0FqCMs9g0VVvg8qLVC"
X-Ovh-Tracer-Id: 9098960101352024233
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduiedtudejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfvhffutgesghdtreertddvjeenucfhrhhomhepofgrtghivghjucfrihhjrghnohifshhkihcuoehmrggtihgvjhdrphhijhgrnhhofihskhhiseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvvdevfedvjeeukeeuledufeektdeijefggeekfeekvddugeeghfdthefhueelvdenucffohhmrghinhepfehmuggvsgdrtghomhenucfkphepuddvjedrtddrtddruddpvddufedrudelvddrjeejrddvgeelpdefjedrheelrddugedvrddutdeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpehmrggtihgvjhdrphhijhgrnhhofihskhhiseefmhguvggsrdgtohhmpdhnsggprhgtphhtthhopedupdhrtghpthhtohepuhdqsghoohhtsehlihhsthhsrdguvghngidruggvpdfovfetjfhoshhtpehmohehhedtmgdpmhhouggvpehsmhhtphhouhht
DKIM-Signature: a=rsa-sha256; bh=trUV2+RkuCKul1nGqbrKBRT92lCVJt+lWHtsEsKx2Zs=; 
 c=relaxed/relaxed; d=3mdeb.com; h=From;
 s=ovhmo3617313-selector1; t=1742831174; v=1;
 b=DCXSSnAHxzoiPy/fmbl6zzqZcHCV0W6LGPVsfd++YMMe5w/h4abEkI/D00kI4ZHz1GwBOli0
 4b4hyHnU1UT3jv1AZZXmTHmrroyPqW/XWETq/pl0EhEjBulu2iszhj8S3BG8jGlKuffdP6fLAw7
 mm8tOGeCeRGeAtWK7AEGeNT/I4gT30kIp1JoXUF1gLsVPK/JcNmgl+vFe+23nvf5BPUi70WTKls
 0YcLYJBjuWntG0PBV1XC/G6A9abwezsuhIlu5JNcHhTcfO49veOccRef+gVelSTT5OFvet+ACab
 Stia/8O5BLBlrur6bYUEYbVjmAHpUhl/Jwzo+HF3nErqw==
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
--------------WUkI6R0FqCMs9g0VVvg8qLVC
Content-Type: multipart/mixed; boundary="------------ZrFp0wqpD4n5oKEHClAydDG5";
 protected-headers="v1"
From: Maciej Pijanowski <maciej.pijanowski@3mdeb.com>
To: danct12@riseup.net, u-boot@lists.denx.de
Message-ID: <b8f68653-1d3a-4198-9c75-c8e0405e553c@3mdeb.com>
Subject: Re: [PATCH v2 00/11] Rockchip VOP2 support

--------------ZrFp0wqpD4n5oKEHClAydDG5
Content-Type: multipart/mixed; boundary="------------zU0LBpMTpDdDn7Aih8VBLCd1"

--------------zU0LBpMTpDdDn7Aih8VBLCd1
Content-Type: multipart/alternative;
 boundary="------------P0D97VRjqULkuTjfjvNmrL1G"

--------------P0D97VRjqULkuTjfjvNmrL1G
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGVsbG8sDQoNCkZpcnN0IG9mIGFsbCwgdGhhbmtzIGZvciB5b3VyIHdvcmsgb24gdGhpcyBS
b2NrY2hpcCB1cHN0cmVhbSBjb2RlLiBXZSBoYXZlDQp0ZXN0ZWQgeW91ciBwYXRjaGVzIG9u
IFJLMzU2NiBib2FyZCAoUmFkeGEgQ00zIElPKSBhbmQgSERNSSBvdXRwdXQgaW4NClUtQm9v
dCB3b3JrcyBncmVhdC4gV2UgZGlkbid0IGhhdmUgc3VjY2VzcyB3aXRoIE1JUEkgeWV0IHNv
IGZhciwgdGhvdWdoLg0KDQogPiBIRE1JIHNob3VsZCB3b3JrIGZsYXdsZXNzbHkgYnV0IHRo
ZXJlJ3Mgc3RpbGwgc29tZSB0aW1pbmdzIGlzc3VlIHdpdGgNCiA+IERXIE1JUEkgRFNJLCBw
ZXJoYXBzIHRoYXQncyBzb21ldGhpbmcgdG8gbG9vayBpbnRvIGxhdGVyLg0KDQpJIHdhbnRl
ZCB0byBjb25maXJtIHdoZXRoZXIgeW91IGhhdmUgaGFkIHN1Y2Nlc3Mgd2l0aCB0aGUgTUlQ
SSBhcyB3ZWxsLA0KYW5kIHdoYXQgZXhhY3RseSBkbyB5b3UgbWVhbiBieSB0aGVzZSBpc3N1
ZXM/DQoNClRoYW5rcywNCg0KLS0gDQpNYWNpZWogUGlqYW5vd3NraQ0KRW5naW5lZXJpbmcg
TWFuYWdlcg0KR1BHOiA5OTYzQzM2QUFDM0IyQjQ2DQpodHRwczovLzNtZGViLmNvbSB8IEAz
bWRlYl9jb20NCg0K
--------------P0D97VRjqULkuTjfjvNmrL1G--

--------------zU0LBpMTpDdDn7Aih8VBLCd1
Content-Type: application/pgp-keys; name="OpenPGP_0x9963C36AAC3B2B46.asc"
Content-Disposition: attachment; filename="OpenPGP_0x9963C36AAC3B2B46.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
wMDsCZKkPKx8jYw=3D
=3D0QS1
-----END PGP PUBLIC KEY BLOCK-----

--------------zU0LBpMTpDdDn7Aih8VBLCd1--

--------------ZrFp0wqpD4n5oKEHClAydDG5--

--------------WUkI6R0FqCMs9g0VVvg8qLVC
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEp2bIlWmJXAuG1ZjQmWPDaqw7K0YFAmfhfkQFAwAAAAAACgkQmWPDaqw7K0bg
yBAAqj/X8q5hY01JnrySEoqnuqTIC8HsynotKbk9/nWaslqEZGd5IDrECuRZIS17tM3bydFhCiYJ
bjU8WXN1fVzRwaR4OGeTRdTjPKeEIlUf2s5HXF45eTOj7YeTlUvOExIdnG48UbQObCmPejpYhn1J
yr/4ErFzmeZsn02rXzSs5G9ustM9FO5jrqhQo3WxvwiYf8qmef91V8ZzeqVFeCVW5PbhBfbrlc3e
RoSOZML70EGb2uwffbJlpf1GXFHVsvLCeXBa9zYKSG0bKS2XZw+04UqoP8AfGjjYGOFY3kKL8fFC
wPC5NswRYhXGb/L5D+bsS8kYhs9gjDbiOiJIPIVpvNAkX4z4JYyBkl5mpz6EetYyl+9EPu3j25pv
cx4IA0XA+G+1J0eYMFrEBxNY8Hz9P1mfYAXrs+BCLklS4pkOEvMqI8CxYzADJkkJeocFvPo5aGTZ
zfRF+h0VtULLcrQsoB7SIofhd7WUyE7XvD0UjEnAfM0sRKgYKXeXV4UYe7cPwsz36BsGY58OLA9M
g1y3oFPfNyZ+SuFdosSYHxzDDfXDtzviR+Dvxw/682Ci9YAOEDm1umud5dGdyvsdwDFPHNYhJgLg
vJx2M9H8ZesoGKxI+NCwdg7Sbqy4zTNdpFfbJFRJ4jvFo82e0x/kbEh5j/HA0P+WjA/hsxqFRIoi
+UI=
=HGy4
-----END PGP SIGNATURE-----

--------------WUkI6R0FqCMs9g0VVvg8qLVC--
