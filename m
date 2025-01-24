Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746D6C02181
	for <u-boot@archiver.kernel.org>; Fri, 24 Jan 2025 13:02:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E7888809D2;
	Fri, 24 Jan 2025 14:01:59 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=studiofuga.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=studiofuga.com header.i=@studiofuga.com header.b="msT6IgTB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4FC09807FE; Fri, 24 Jan 2025 11:50:07 +0100 (CET)
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch
 [IPv6:2001:1600:4:17::8fac])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A96678096D
 for <u-boot@lists.denx.de>; Fri, 24 Jan 2025 11:50:03 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none)
 header.from=studiofuga.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=fuga@studiofuga.com
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch
 [10.4.36.108])
 by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4YfZMV1yFHzpGl;
 Fri, 24 Jan 2025 11:49:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=studiofuga.com;
 s=20220517; t=1737715798;
 bh=Bvx2emooiGMSFZeuflRrUOa7YvGph5vm2dz9A2vFN98=;
 h=Date:From:To:Subject:From;
 b=msT6IgTBkKlgsw521I1i2p62iy6alQI9ba9iI87EdBhiTrvJMCOiBaBvBzUWWniLf
 hLPmjDZvr8c8LGk86sZzgplZx7grKFUU1s0oP+7L8PC48+o1g+HgZ7C6QKczvUuLtK
 YSqNQrxz4gFFdzf31ps2bMExgk7tBPrcEtnKQwuY=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA
 id 4YfZMT3547zY5k; Fri, 24 Jan 2025 11:49:57 +0100 (CET)
Message-ID: <a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com>
Date: Fri, 24 Jan 2025 11:49:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Federico Fuga <fuga@studiofuga.com>
Autocrypt: addr=fuga@studiofuga.com; keydata=
 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
 3Z10R+iQ3XwjCMCTFTN+4NBJ1U0=
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Federico Fuga <fuga@studiofuga.com>,
 Maxime Ripard <maxime@cerno.tech>, u-boot@lists.denx.de
Subject: [PATCH] Fix fastboot handling of partitions when no slots are,
 supported
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------b2Apn1rFJyTciMvh4wyooDY4"
X-Infomaniak-Routing: alpha
X-Mailman-Approved-At: Fri, 24 Jan 2025 14:01:57 +0100
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
--------------b2Apn1rFJyTciMvh4wyooDY4
Content-Type: multipart/mixed; boundary="------------yvUXg2Ki4UTu9fUXjy4ypTH9";
 protected-headers="v1"
From: Federico Fuga <fuga@studiofuga.com>
To: Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Federico Fuga <fuga@studiofuga.com>,
 Maxime Ripard <maxime@cerno.tech>, u-boot@lists.denx.de
Message-ID: <a70b19e6-4436-4fcf-bebd-b6877b66779e@studiofuga.com>
Subject: [PATCH] Fix fastboot handling of partitions when no slots are,
 supported

--------------yvUXg2Ki4UTu9fUXjy4ypTH9
Content-Type: multipart/mixed; boundary="------------Lyvkwbm2zhZMRzx3J50kXaSL"

--------------Lyvkwbm2zhZMRzx3J50kXaSL
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

VGhlIGZhc3Rib290IG1vZHVsZSBoYXMgYSBidWcgdGhhdCBwcmV2ZW50cyBzb21lIGNvbW1h
bmQgdG8gd29yaw0KcHJvcGVybHkgb24gZGV2aWNlcyB0aGF0IGhhdmVuJ3QgYW4gQW5kcm9p
ZC1saWtlIHBhcnRpdGlvbiBzY2hlbWUsIHRoYXQNCmlzLCBqdXN0IG9uZSBzcGwgYW5kIG9u
ZSBrZXJuZWwgcGFydGl0aW9uLCBpbnN0ZWFkIG9mIHRoZSByZWR1bmRhbnQNCnNjaGVtZSB3
aXRoIF9hIGFuZCBfYiBzbG90cy4NCg0KVGhpcyBpcyB0aGUgc2NoZW1hIG9mIG91ciBOQU5E
IHN0b3JhZ2UgKGJvYXJkIGlzIGJhc2VkIG9uIGFuIEFsbFdpbm5lcg0KQTMzIHN1bnhpIGNo
aXApOg0KDQo9PiBtdGRwYXJ0cw0KDQpkZXZpY2UgbmFuZDAgPDFjMDMwMDAubmFuZD4sICMg
cGFydHMgPSA0DQogwqAjOiBuYW1lwqDCoMKgwqDCoMKgwqDCoCBzaXplwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBuZXQgc2l6ZcKgwqDCoMKgwqDCoMKgIG9mZnNldCBtYXNrX2ZsYWdzDQog
wqAwOiBzcGzCoMKgwqDCoMKgwqDCoMKgwqAgMHgwMDAyMDAwMMKgwqDCoMKgwqAgMHgwMDAy
MDAwMMKgwqDCoMKgwqAgMHgwMDAwMDAwMMKgwqDCoMKgwqAgMA0KIMKgMTogdWJvb3TCoMKg
wqDCoMKgwqDCoCAweDAwMTAwMDAwwqDCoMKgwqDCoCAweDAwMTAwMDAwwqDCoMKgwqDCoCAw
eDAwMDIwMDAwwqDCoMKgwqDCoCAwDQogwqAyOiBrZXJuZWwgwqDCoCDCoMKgIDB4MDA0MDAw
MDDCoMKgwqDCoMKgIDB4MDA0MDAwMDDCoMKgwqDCoMKgIDB4MDAxMjAwMDDCoMKgwqDCoMKg
IDANCiDCoDM6IHViacKgwqDCoMKgwqDCoMKgwqDCoCAweDA3YWUwMDAwwqDCoMKgwqDCoCAw
eDA3OWUwMDAwICghKcKgIDB4MDA1MjAwMDDCoMKgwqDCoMKgIDANCg0KYWN0aXZlIHBhcnRp
dGlvbjogbmFuZDAsMCAtIChzcGwpIDB4MDAwMjAwMDAgQCAweDAwMDAwMDAwDQoNClRoaXMg
aGFwcGVucyB3aGVuIHdlIHRyeSB0byBlcmFzZSB0aGUgc3BsIHBhcnRpdGlvbiB1c2luZyBm
YXN0Ym9vdDoNCg0KJCBmYXN0Ym9vdCBlcmFzZSBzcGwNCkVyYXNpbmcgJ3NwbF9hJ8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgRkFJTEVEIChyZW1vdGU6ICdpbnZhbGlkIE5BTkQg
ZGV2aWNlJykNCmZhc3Rib290OiBlcnJvcjogQ29tbWFuZCBmYWlsZWQNCg0KVGhlIGVycm9y
IG9jY3VycyBiZWNhdXNlIGdldHZhcnMgZmFpbHMgdG8gaGFuZGxlIHRoZSBlcnJvciByZXR1
cm5lZCBieQ0KbmFuZCBsYXllciB3aGVuIGEgcGFydGl0aW9uIGNhbm5vdCBiZSBmb3VuZC4N
Cg0KSW5kZWVkLCBnZXR2YXJfZ2V0X3BhcnRfaW5mbyByZXR1cm5zIHdoYXQgaXMgcmV0dXJu
ZWQgYnkNCmZhc3Rib290X25hbmRfZ2V0X3BhcnRfaW5mbyAoMCBvbiBzdWNjZXNzLCAxIG9u
IGZhaWx1cmUpIGJ1dCBpdCBzaG91bGQNCnJldHVybiAtRU5PREVWIG9yIC1FSU5WQUwgaW5z
dGVhZC4gU2luY2UgdGhlIGNhdXNlIG9mIGZhaWx1cmUgaXMgbm90DQpyZXR1cm5lZCBieSB0
aGUgbmFuZCBmdW5jdGlvbiwgSSBkZWNpZGVkIHRvIHJldHVybiAtRUlOVkFMIHRvIG1ha2Ug
aXQNCnNpbXBsZS4NCg0KU2lnbmVkLW9mZi1ieTogRmVkZXJpY28gRnVnYSA8ZnVnYUBzdHVk
aW9mdWdhLmNvbT4NCi0tLQ0KIMKgZHJpdmVycy9mYXN0Ym9vdC9mYl9nZXR2YXIuYyB8IDUg
KysrKy0NCiDCoGRyaXZlcnMvZmFzdGJvb3QvZmJfbmFuZC5jwqDCoCB8IDIgKy0NCiDCoDIg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KDQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9mYXN0Ym9vdC9mYl9nZXR2YXIuYyBiL2RyaXZlcnMvZmFzdGJv
b3QvZmJfZ2V0dmFyLmMNCmluZGV4IDkzY2JkNTk4ZTAuLmY1ZDhiMDMzMDEgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL2Zhc3Rib290L2ZiX2dldHZhci5jDQorKysgYi9kcml2ZXJzL2Zhc3Ri
b290L2ZiX2dldHZhci5jDQpAQCAtMTIxLDggKzEyMSwxMSBAQCBzdGF0aWMgaW50IGdldHZh
cl9nZXRfcGFydF9pbmZvKGNvbnN0IGNoYXIgDQoqcGFydF9uYW1lLCBjaGFyICpyZXNwb25z
ZSwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKnNpemUgPSBkaXNrX3BhcnQuc2l6ZSAq
IGRpc2tfcGFydC5ibGtzejsNCiDCoMKgwqDCoCB9IGVsc2UgaWYgKElTX0VOQUJMRUQoQ09O
RklHX0ZBU1RCT09UX0ZMQVNIX05BTkQpKSB7DQogwqDCoMKgwqDCoMKgwqDCoCByID0gZmFz
dGJvb3RfbmFuZF9nZXRfcGFydF9pbmZvKHBhcnRfbmFtZSwgJnBhcnRfaW5mbywgcmVzcG9u
c2UpOw0KLcKgwqDCoMKgwqDCoMKgIGlmIChyID49IDAgJiYgc2l6ZSkNCivCoMKgwqDCoMKg
wqDCoCBpZiAociA9PSAwICYmIHNpemUpIHsNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KnNpemUgPSBwYXJ0X2luZm8tPnNpemU7DQorwqDCoMKgwqDCoMKgwqAgfSBlbHNlIHsNCivC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHIgPSAtRUlOVkFMOw0KK8KgwqDCoMKgwqDCoMKgIH0N
CiDCoMKgwqDCoCB9IGVsc2Ugew0KIMKgwqDCoMKgwqDCoMKgwqAgZmFzdGJvb3RfZmFpbCgi
dGhpcyBzdG9yYWdlIGlzIG5vdCBzdXBwb3J0ZWQgaW4gYm9vdGxvYWRlciIsIA0KcmVzcG9u
c2UpOw0KIMKgwqDCoMKgwqDCoMKgwqAgciA9IC1FTk9ERVY7DQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9mYXN0Ym9vdC9mYl9uYW5kLmMgYi9kcml2ZXJzL2Zhc3Rib290L2ZiX25hbmQuYw0K
aW5kZXggNWE1NTE0NDQ3OS4uM2VlMGY0MGVhOCAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvZmFz
dGJvb3QvZmJfbmFuZC5jDQorKysgYi9kcml2ZXJzL2Zhc3Rib290L2ZiX25hbmQuYw0KQEAg
LTE0MSw3ICsxNDEsNyBAQCBzdGF0aWMgbGJhaW50X3QgZmJfbmFuZF9zcGFyc2VfcmVzZXJ2
ZShzdHJ1Y3QgDQpzcGFyc2Vfc3RvcmFnZSAqaW5mbywNCiDCoCAqDQogwqAgKiBAcGFydF9u
YW1lOiBOYW1lZCBkZXZpY2UgdG8gbG9va3VwDQogwqAgKiBAcGFydF9pbmZvOiBQb2ludGVy
IHRvIHJldHVybmVkIHBhcnRfaW5mbyBwb2ludGVyDQotICogQHJlc3BvbnNlOiBQb2ludGVy
IHRvIGZhc3Rib290IHJlc3BvbnNlIGJ1ZmZlcg0KKyAqIEByZXNwb25zZTogMCBvbiBzdWNj
ZXNzLCAxIG90aGVyd2lzZQ0KIMKgICovDQogwqBpbnQgZmFzdGJvb3RfbmFuZF9nZXRfcGFy
dF9pbmZvKGNvbnN0IGNoYXIgKnBhcnRfbmFtZSwNCiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgcGFydF9pbmZvICoqcGFydF9pbmZvLCBjaGFyICpyZXNwb25z
ZSkNCi0tIA0KMi40OC4xDQoNCg0K
--------------Lyvkwbm2zhZMRzx3J50kXaSL
Content-Type: application/pgp-keys; name="OpenPGP_0xEBBD37A93653C032.asc"
Content-Disposition: attachment; filename="OpenPGP_0xEBBD37A93653C032.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
3Z10R+iQ3XwjCMCTFTN+4NBJ1U0=3D
=3DgKDV
-----END PGP PUBLIC KEY BLOCK-----

--------------Lyvkwbm2zhZMRzx3J50kXaSL--

--------------yvUXg2Ki4UTu9fUXjy4ypTH9--

--------------b2Apn1rFJyTciMvh4wyooDY4
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsD5BAABCAAjFiEEGznTeeLsJ7s9447T6703qTZTwDIFAmeTcFQFAwAAAAAACgkQ6703qTZTwDIG
tgv/cTINdUUJLrr1wvG2OlRL/9L8P3KO1/se7hxA9m6HN24BoJxpzBrLlg85E8aG9v3/dsGnopZJ
1ha+E8hm1lG0NMj5R3UBKMBAVldR7nH/v6vvP+ozzK3OdYS3wNpql3vJx6hGolSG5ADoxFoK0we6
WRDVQEKR4x/fUgzpg7x39L1YJ+W8t1QdjCFo/T5Lc6FqLY0FcS8ol35Ow+57wQU1bhN/LLRDZEc/
CA6sh6rU/ZjKEy1Fxb72JK/kGY+bfAr+/K0oO4i4vNSLolUloM5QNxV9vKwHKii+M3x+JYqj3yzR
M67PjtjdkGP8bUQYLwskpxz9B1IsYOQ5saPQEBmXEHu6wm/AyPYLjMdDoRmv9VdoPFTysK/RRjL5
Ih+jEofihtsnYs46OfTx7LoeX4nPXc0u+w+96EXDsSnEzthS3PO2mb4J+S5boKrsL4RYESkqc244
TGOpXC2Z5D3s4If2rzz8oVLLG2ZwYn/lco8fr5VXZIs4rGBI/iyXQxv9WN+2
=XvCQ
-----END PGP SIGNATURE-----

--------------b2Apn1rFJyTciMvh4wyooDY4--
