Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA24C36002
	for <u-boot@archiver.kernel.org>; Mon, 24 Mar 2025 15:12:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A2721819B1;
	Mon, 24 Mar 2025 16:10:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=3mdeb.com header.i=@3mdeb.com header.b="bP31hDw+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D613281D3B; Sun, 23 Mar 2025 22:32:19 +0100 (CET)
Received: from 18.mo561.mail-out.ovh.net (18.mo561.mail-out.ovh.net
 [87.98.172.162])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3672181B5B
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 22:32:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=3mdeb.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=maciej.pijanowski@3mdeb.com
Received: from director11.ghost.mail-out.ovh.net (unknown [10.108.25.74])
 by mo561.mail-out.ovh.net (Postfix) with ESMTP id 4ZLTsr53qHz1SNM
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 21:32:16 +0000 (UTC)
Received: from ghost-submission-5b5ff79f4f-mtp76 (unknown [10.110.168.37])
 by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 713261FEC1
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 21:32:16 +0000 (UTC)
Received: from 3mdeb.com ([37.59.142.104])
 by ghost-submission-5b5ff79f4f-mtp76 with ESMTPSA
 id zCXDEeB94GcuhQIAOaZJsg
 (envelope-from <maciej.pijanowski@3mdeb.com>)
 for <u-boot@lists.denx.de>; Sun, 23 Mar 2025 21:32:16 +0000
Authentication-Results: garm.ovh; auth=pass
 (GARM-104R005366465a0-5a7b-4f98-95c4-b83f4344389b,
 B3FD6AFEE3CCB53505F90138E5AB96A0EF99E6DF)
 smtp.auth=maciej.pijanowski@3mdeb.com
X-OVh-ClientIp: 188.252.120.193
Message-ID: <c35bb4a9-8fb2-41a8-967d-11af1d55d751@3mdeb.com>
Date: Sun, 23 Mar 2025 22:32:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Rockchip VOP2 support
Content-Language: en-US
To: u-boot@lists.denx.de
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <mailman.0.1742764847.19692.u-boot@lists.denx.de>
From: Maciej Pijanowski <maciej.pijanowski@3mdeb.com>
Autocrypt: addr=maciej.pijanowski@3mdeb.com; keydata=
 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
In-Reply-To: <mailman.0.1742764847.19692.u-boot@lists.denx.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------TFip2KsBtMAtIVQzh4dCwf2l"
X-Ovh-Tracer-Id: 9070249650482915497
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduheejleeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefkffggfgfuvfhfhfgjtgesghdtreertddvjeenucfhrhhomhepofgrtghivghjucfrihhjrghnohifshhkihcuoehmrggtihgvjhdrphhijhgrnhhofihskhhiseefmhguvggsrdgtohhmqeenucggtffrrghtthgvrhhnpeelueeivdduteeiffdvleeuvdejudfgvddukeehhfejhfffhfelheehffejudekleenucffohhmrghinhepfehmuggvsgdrtghomhenucfkphepuddvjedrtddrtddruddpudekkedrvdehvddruddvtddrudelfedpfeejrdehledrudegvddruddtgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepmhgrtghivghjrdhpihhjrghnohifshhkihesfehmuggvsgdrtghomhdpnhgspghrtghpthhtohepuddprhgtphhtthhopehuqdgsohhotheslhhishhtshdruggvnhigrdguvgdpoffvtefjohhsthepmhhoheeiudgmpdhmohguvgepshhmthhpohhuth
DKIM-Signature: a=rsa-sha256; bh=h4ikXAMA/bg5ynKBgjZSA1b3UkHIC1CyELB7VaKP3zM=; 
 c=relaxed/relaxed; d=3mdeb.com; h=From;
 s=ovhmo3617313-selector1; t=1742765536; v=1;
 b=bP31hDw+l2syGXhUNobEO3m9KzhnQt2brHq3PEUitbLlWuD2SHvlaw6zor7Bo+nPuIMsalo9
 0C6YF3249HhY7fa6RCIS2RU0WyPr7gpqckg+Y7OYooCqNVSY7mFjhrTuImBhPAVTsB9DftPnxIL
 mxKVyAOQFXOOmfe7UlRLg2Ugp2oKKl34MAJr3n4N4ZHZ15ouF3BpLryizsiWx3j9vaQLVhfb5nu
 Z9SQMntDd2UJvVJvixQh6mV8KP25KbgAQsL1Ys5sGsoZjU+1aOfAdz51+Len/OdGtCgmhLv3aT3
 cMyhKL7X6n50CRQS4ZO8Uu2sNeibncJt3DzYLcFAXupQg==
X-Mailman-Approved-At: Mon, 24 Mar 2025 16:10:20 +0100
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
--------------TFip2KsBtMAtIVQzh4dCwf2l
Content-Type: multipart/mixed; boundary="------------djFfTi4EXhHe8T3jT20TXuEH";
 protected-headers="v1"
From: Maciej Pijanowski <maciej.pijanowski@3mdeb.com>
To: u-boot@lists.denx.de
Message-ID: <c35bb4a9-8fb2-41a8-967d-11af1d55d751@3mdeb.com>
Subject: Re: Rockchip VOP2 support
References: <20250223-vop2-pt2-v2-0-71350e482970@riseup.net>
 <mailman.0.1742764847.19692.u-boot@lists.denx.de>
In-Reply-To: <mailman.0.1742764847.19692.u-boot@lists.denx.de>

--------------djFfTi4EXhHe8T3jT20TXuEH
Content-Type: multipart/mixed; boundary="------------7etmprTXoxqpT7EoUN0KRp1R"

--------------7etmprTXoxqpT7EoUN0KRp1R
Content-Type: multipart/alternative;
 boundary="------------dfCq6mmrexFvZngZmpqCwTSK"

--------------dfCq6mmrexFvZngZmpqCwTSK
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

ID4gSERNSSBzaG91bGQgd29yayBmbGF3bGVzc2x5IGJ1dCB0aGVyZSdzIHN0aWxsIHNvbWUg
dGltaW5ncyBpc3N1ZSB3aXRoDQogPiBEVyBNSVBJIERTSSwgcGVyaGFwcyB0aGF0J3Mgc29t
ZXRoaW5nIHRvIGxvb2sgaW50byBsYXRlci4NCg0KQXJlIHRoZXJlIHN0aWxsIGlzc3VlcyBh
cmUgZXhwZWN0ZWQgd2l0aCBNSVBJIHdpdGggdGhpcyBWMiBwYXRjaHNldD8gV2UgYXJlDQp0
ZXN0aW5nIHRoaXMgcGF0Y2hlcyB3aXRoIFJLMzU2NiBhbmQgd29ya3MgZmxhd2xlc3NseSBm
b3IgSERNSSwgYnV0IHN0aWxsDQpubyBsdWNrIHdpdGggTUlQSSAoYWx0aG91Z2ggdGhlIHBy
b2JsZW0gbWF5IGJlIHNvbWV3aGVyZSBlbHNlIGFzIHdlbGwpLg0KDQotLSANCk1hY2llaiBQ
aWphbm93c2tpDQpFbmdpbmVlcmluZyBNYW5hZ2VyDQpHUEc6IDk5NjNDMzZBQUMzQjJCNDYN
Cmh0dHBzOi8vM21kZWIuY29tIHwgQDNtZGViX2NvbQ0KDQo=
--------------dfCq6mmrexFvZngZmpqCwTSK--

--------------7etmprTXoxqpT7EoUN0KRp1R
Content-Type: application/pgp-keys; name="OpenPGP_0x9963C36AAC3B2B46.asc"
Content-Disposition: attachment; filename="OpenPGP_0x9963C36AAC3B2B46.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBF4qlhoBEADgl4uab157tPQOtWEBaEyHzMllmAumP+XQokz180AXQY8Pxrbx
Kqso4UTZYbGXza3AL9R0Trk5TJMmjRf3DJMBx79kbdVo1nF/jGihz0QJwjR+KI5S
SA+veuPGeSckF1Liv3cKkS+meiRdc+hsUzT4Qx7buQSj+1tTlG7WHanUTHJp9nE2
iKnf5RSy4TeEcfJcBOZOkcjgAY5aHXbNITpfhRZAlhaXe+0uafumfMX9QYqOyv2D
FeT0xwQphBwe/UzEADZxXTcSSMlpA+AaRAHGYo8OucZBxIHxKPb/s5ISVf+tT3do
dDoxvODfOaprFMIuoxznpiARLYJARvvRIRypcL1ye9Lln4lKIgpk0iqXoG9swRrD
Vch81yPpw04YAtqXGdVZ4GhXpS2OOAAqXuF0lXU0kTcI6tSEDiuJy9NMQa1A10vf
HkaIL4BmdH9QZuBrym6KR+B9dkkobRie1AJuyM0V6kSbtN7C3+OABbyTUQ1IILDO
wPusTh+0moI8FoC3O17PoFP+cvoy7jB7oanicWZamg24jurVmF5Z2cs/+0zzrnyf
TCHP71IviWCodWR+qm0vbDbPzMfsGc8fmxpSiKL9x3xJgfeykkOfD1//gnuZw+2F
NaK14wJPs8UpxRPlCce3R0YnpEsBKI1vlpRXMgJPiTXGmC7tdwkx2CT9TQARAQAB
zS9NYWNpZWogUGlqYW5vd3NraSA8bWFjaWVqLnBpamFub3dza2lAM21kZWIuY29t
PsLBjgQTAQgAOBYhBKdmyJVpiVwLhtWY0Jljw2qsOytGBQJeKpYaAhsDBQsJCAcC
BhUKCQgLAgQWAgMBAh4BAheAAAoJEJljw2qsOytGt+UP/0q68qgYQwilMM5v1Zte
Xovb8FRoYPEmH53XCUyOKWV4JgtAfm0SrxvZE+wTJYTrjwcm9NKpxdjRmPIkUcH3
m0CJFUN71sez50OZbmNh/Yy1lu25Tst520RMEPXVv7IBmytL28rhUK47bIh9z+Mp
WxctGeB2SVIWJfNUOifI3k14YKiyEXoExGVLTH/QrMvTfCm9rkky3kid6OSrqqC9
uVCO5R889g6jo7J3Gqe2IUxxIZ5BOyL/+Z8AMKIqWy8nmQ35wgy44f0jiFLUQNC2
rdbS9/JEPZtQZjZ2TBCPsC8UQcAZLBT2iQYx9VD/2vr6aHQUTZ5qvmJKPMo96pP+
+TKn8oClOqjmZfOdsh6zDTUnlENDCsbRHEJIWWzofywyOqDUhZXhCNbzE0fsMAt3
rY4PbPnuD0dmcfbFeasltBjYS704e+Uig/o/UTcVAJmypreB68eJbLjGElGheGyY
FuluXi6VGM4uGNGElbl7lbKfKVml0sgULXl9f+4eML8TKOHKNUhMWqnkx5WSbOxO
BiSEW+gBFZHMrkhspP3RXj9ESYpJ2irxrJzPQCFMF7D5kXm9OSrBRDFA+yYxZSj0
p6pFVBGDdIlZ/qJcfh5azoSNI0KKbUvGDJ0mnM7OmehAafGNo/eLwwQeAJOnw8yQ
nIDUutZHZ9Z1v3WBFtslO5i+zsFNBF4qlhoBEACzCtn7Eh+SNFP5kQUI2QvyiIxL
plFtLYr8Mmnk+c/TyXIvyttmRRNqC1eo5jwui36HIlK/EVlQ3khNgm3FP9YbASbu
+eDXWGrXd6CkYWkmO8VdB1L8e9ml+tzqsKtm31vjxBrvV7RzzFumA14pOfuSkeZE
ZxZAy0fdjp5JeeiUd5LIdZrqZatKtGV4R2KBgfXE0LxHeSo6Q3PdJ2vmkGEL9AOV
ESP4e6KCj7NS7drzEvy5LqvqPt56qK+tlFzQEvNwObTXjF+DbNzf5ooyrcDl6xOq
+Xt0ReK0VPe/fVZ/gSFF2kwXt2LLOR/UFcKHS+pfEYwwy2kkfz8NLV/So8M0fk1Z
c82S8a8726WPQW23UKJz9UtVLG1V8tTVfavfl9pFW1KBkToexPruTsR9rxDB/BFS
7hYxcn70GqInWGPR8ca58m+8mtDJuPcE4u/UeQy1zj20Gb0fSXhgfUt0bKnYJPMQ
HAdtsEw9vWZswSUDpZvtvYjViRdBePfo+NPO2TLXA9l4ZYZM8d2lkvI+wz7HpvqS
VmQ/56/xvwBHHuckVJyeYbT02tLt2hyXoL5j5Ql7sBOHIeMvwJ8QJVTJXDXGXqM/
9aSVGbnXROXetf4a8rmedxdruFReRffmPBiQhJYWNrJxfzhvS/gA17uKqfK2eCym
HVahCtIaZPCC5ZjOWQARAQABwsF2BBgBCAAgFiEEp2bIlWmJXAuG1ZjQmWPDaqw7
K0YFAl4qlhoCGwwACgkQmWPDaqw7K0YgWQ/+OuLUmvZYQdRvIEpK4C95vJ1khVJQ
HtotKcRUbQpTrEtGxj8/he8L/La53/SsHhXuwNRw7imeyDHOlAUxN6CnQiwjI6FW
8ocb8GkPFw8fsZ9Lne4ZMr/y5WFM/iGleZtAl7Kul5ddVQMmGrqGPaD+ldY5B3NC
h8AmZSzeFzx6PO7eqUZ23yLvJOLkY7PauDmTMaXYy0JwndjhTiQKEkzSki9cOeC0
5n+kWcLcA8i/WI7rMOYyR5+2yIcQF37fFr6nFSvWSDmklITQdSUOP39LSIkltDci
b2DNdCni+Vyz7T5rkQiX5k3HYeav/odiio3PhjtEDWNEhMtYHcmOpTftRRZasZPe
xAWzDg3VzEZqtdLi9nJB26mg+1CmU5v0VCCV37Q8zhAAFg134+7A5sItCkr46Hy8
zNOWxcx+drgVDVmOqrvxQV24JXWFKhROPlMxXEcrdYwyEa62aAzTA6t/kQy1vSZS
RcdXXlQd49rtohphFcRgH7pXgOOClNy5X3mn2sYg4nfaxq88LPsjXsagf3nd0ZCS
KmjEiGJg5MzrsMYdfNdhm42QhhkgsvrVoUDO+1DwQqvUYPCdyRHyfWAEnKKHTuNK
1lYISSDrWxhhR0bmwki5Lz3NKC1jgXlOLZGF4GOR4+UZoRlUCJcx9hgyZll4XNRs
wMDsCZKkPKx8jYw=3D
=3D0QS1
-----END PGP PUBLIC KEY BLOCK-----

--------------7etmprTXoxqpT7EoUN0KRp1R--

--------------djFfTi4EXhHe8T3jT20TXuEH--

--------------TFip2KsBtMAtIVQzh4dCwf2l
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEp2bIlWmJXAuG1ZjQmWPDaqw7K0YFAmfgfd8FAwAAAAAACgkQmWPDaqw7K0a0
MRAAj4vECX1yL+L5V0wKOIJtF9HM6QftQ0hZvv785mfwY+4m2flxeDdr1OJ5ool/LRC1KCDFDJrf
GRjxf4plnygXavtsHkWmmdGKCH4XNSEapX55C2U4R/tajs4ANQWwpFiOFOe/mCz4mWToOg6tz9IN
QS0v3c247H5umcKfaQ52/Ez24kETNAhS2LPgt9p1ege3XeladH/VjoVR7YUc8flxd5uiAc7TRQ+t
ocSpgnWid/BOjhSGrKdkJL9mEk+UGNbVCLGD97wc4qsAwQ0SglAbJ2r3xZEEOsnbaoXJ2roVUFQS
aXDQZOIuU6wDSuHNpml+IhbExqbkc2ocv9ToH6zw5iQfScgSoVQDOc64KZ+rmhO5ubW+eS+i2M3X
hrL3f7l4zqgr9I+ARiNuIpHuzf4lO67PLeIkxeBfyEEPXFRSnx8ytdJ2WicVKRot3y1rP9Zz44sd
aSQHJjL/f6IusDg2J/BoSoG5wZBQQfN3Yiu7MYBh/xgnRa33mTR+93PMSB4rWgQ89yQQKg12/oOo
AgBlXyrbgYccVnbQ7rZ+YojKz93Ltos8tPpA2ZVLu0dFdJelJN7ONuOOHfd1q6XN8sg9h5nMWGAv
vGmm+XNNRy3yDau1jK4QAWp1zY7GhstoX+9HlPsBi4IfBewnsucAeUqVGcEpU/Kswy7Xfb3fbTjF
afY=
=9qfV
-----END PGP SIGNATURE-----

--------------TFip2KsBtMAtIVQzh4dCwf2l--
