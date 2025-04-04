Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1521C36010
	for <u-boot@archiver.kernel.org>; Fri,  4 Apr 2025 14:19:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D59D1829A0;
	Fri,  4 Apr 2025 16:19:35 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=uni-duesseldorf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2A74982958; Fri,  4 Apr 2025 15:10:44 +0200 (CEST)
Received: from c2882.mx.srv.dfn.de (c2882.mx.srv.dfn.de [194.95.239.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 011ED828AB
 for <u-boot@lists.denx.de>; Fri,  4 Apr 2025 15:10:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=uni-duesseldorf.de
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=niklas.sombert@uni-duesseldorf.de
Received: from mta-5.mail.zim.hhu.de (mta-5.mail.zim.hhu.de [134.99.128.242])
 by c2882.mx.srv.dfn.de (Postfix) with ESMTPS id 2E6AE4EC;
 Fri,  4 Apr 2025 15:10:41 +0200 (CEST)
Received: from [10.125.24.198] (unknown [134.99.36.198])
 (Authenticated sender: nisom101@uni-duesseldorf.de)
 by mta-5.mail.zim.hhu.de (Postfix) with ESMTPA id F28DBD2025A;
 Fri,  4 Apr 2025 15:10:40 +0200 (CEST)
Message-ID: <c1dc7446-d1d0-4ef2-b201-09fc612aa8db@uni-duesseldorf.de>
Date: Fri, 4 Apr 2025 15:10:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: de-DE, en-US
To: u-boot@lists.denx.de
From: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
Autocrypt: addr=niklas.sombert@uni-duesseldorf.de; keydata=
 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
Cc: Simon Glass <sjg@chromium.org>
Subject: SMBIOS tables missing on 2025.04-rc5 on qemu-x86
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------GhsQwLWW0acz5VrDpWTBNRJ8"
X-Mailman-Approved-At: Fri, 04 Apr 2025 16:19:34 +0200
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
--------------GhsQwLWW0acz5VrDpWTBNRJ8
Content-Type: multipart/mixed; boundary="------------07GLX7np7tbixOTZq5lwTG7J";
 protected-headers="v1"
From: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
To: u-boot@lists.denx.de
Cc: Simon Glass <sjg@chromium.org>
Message-ID: <c1dc7446-d1d0-4ef2-b201-09fc612aa8db@uni-duesseldorf.de>
Subject: SMBIOS tables missing on 2025.04-rc5 on qemu-x86

--------------07GLX7np7tbixOTZq5lwTG7J
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgYWxsLA0KDQpJJ3ZlIHdyaXR0ZW4gYSBzbWFsbCBFRkkgYm9vdGxvYWRlciBhbmQgSSdt
IHRlc3RpbmcgaXQgb24gUUVNVSB3aXRoIE9WTUYgDQphbmQgd2l0aCB1LWJvb3QgKHdpdGgg
dGhlIHFlbXUteDg2X2RlZmNvbmZpZyBhcyAtYmlvcyBpbiBRRU1VKS4NCg0KT24gdXBncmFk
aW5nIGZyb20gMjAyNS4wMSB0byAyMDI1LjA0LXJjNSwgSSd2ZSBub3RpY2VkIHRoYXQgdGhl
IFNNQklPUyANCnRhYmxlcyB0aGF0IGFyZSBwYXNzZWQgdmlhIHRoZSBTTUJJT1MgRUZJIGNv
bmZpZyB0YWJsZSBhcmUgY29tcGxldGVseSANCmJsYW5rIChqdXN0IHplcm9lcyBpbnN0ZWFk
IG9mIHN0YXJ0aW5nIHdpdGggU00zKS4NCg0KVGhpcyBpcyBwcmV0dHkgZWFzeSB0byByZXBy
b2R1Y2U6DQoNCmdpdCBjaGVja291dCB2MjAyNS4wMQ0KbWFrZSBjbGVhbg0KZ2l0IGNsZWFu
IC14Zg0KbWFrZSBxZW11LXg4Nl9kZWZjb25maWcNCiMgZWRpdCAuY29uZmlnOiBDT05GSUdf
Q01EX1NNQklPUz15DQptYWtlIC1qNA0KcWVtdS1zeXN0ZW0taTM4NiAtYmlvcyB1LWJvb3Qu
cm9tDQojIHR5cGUgInNtYmlvcyIgaW4gdGhlIHByb21wdCBhbmQgc2VlIGluZm9ybWF0aW9u
IGFib3V0IHRoZSBzeXN0ZW0NCg0KdmVyc3VzOg0KZ2l0IGNoZWNrb3V0IHYyMDI1LjA0LXJj
NQ0KbWFrZSBjbGVhbg0KZ2l0IGNsZWFuIC14Zg0KbWFrZSBxZW11LXg4Nl9kZWZjb25maWcN
CiMgZWRpdCAuY29uZmlnOiBDT05GSUdfQ01EX1NNQklPUz15DQptYWtlIC1qNA0KcWVtdS1z
eXN0ZW0taTM4NiAtYmlvcyB1LWJvb3Qucm9tDQojIHR5cGUgInNtYmlvcyIgYW5kIGdldCB0
aGUgZm9sbG93aW5nIGVycm9yOg0KIyBkb19zbWJpb3MoKSBVbmtub3duIFNNQklPUyBhbmNo
b3IgZm9ybWF0DQoNClRoaXMgaXMgb24gUUVNVSB2ZXJzaW9uIDYuMi4wIChEZWJpYW4gMTo2
LjIrZGZzZy0ydWJ1bnR1Ni4yNSksIHRoZSBvbmUgDQpVYnVudHUgMjIuMDQgY3VycmVudGx5
IHNoaXBzLCBidXQgSSBhbHNvIGdldCB0aGUgc2FtZSByZXN1bHRzIG9uIFVidW50dSANCjI0
LjA0Lg0KDQpCaXNlY3RpbmcgbGVhZHMgbWUgdG8gdGhlIGZvbGxvd2luZyBjb21taXQ6DQoN
CmNvbW1pdCBkNWJjNWM2Y2IwMjkxMjAzZmU4NDhhODUzMmE3ZWNiY2Q0NGNmZTllDQpBdXRo
b3I6IFNpbW9uIEdsYXNzIDxzamdAY2hyb21pdW0ub3JnPg0KRGF0ZTogICBGcmkgSmFuIDEw
IDE3OjAwOjI2IDIwMjUgLTA3MDANCg0KICAgICB4ODY6IGVtdWxhdGlvbjogRW5hYmxlIGJs
b2JsaXN0DQoNCiAgICAgQWRkIGJsb2JsaXN0IHN1cHBvcnQgc28gdGhhdCB0YWJsZXMgY2Fu
IGJlIGdlbmVyYXRlZCBhbmQgcGxhY2VkIGluIGENCiAgICAgYmxvYmxpc3QsIHRoZW4gcGFz
c2VkIHRvIGEgcGF5bG9hZCB1c2luZyBVUEwNCg0KICAgICBTaWduZWQtb2ZmLWJ5OiBTaW1v
biBHbGFzcyA8c2pnQGNocm9taXVtLm9yZz4NCg0KZGlmZiAtLWdpdCBhL2NvbmZpZ3MvcWVt
dS14ODZfNjRfZGVmY29uZmlnIGIvY29uZmlncy9xZW11LXg4Nl82NF9kZWZjb25maWcNCmlu
ZGV4IDI3NzFhNGI5ZTE5Li43OTJiYTA2YzJiOCAxMDA2NDQNCi0tLSBhL2NvbmZpZ3MvcWVt
dS14ODZfNjRfZGVmY29uZmlnDQorKysgYi9jb25maWdzL3FlbXUteDg2XzY0X2RlZmNvbmZp
Zw0KQEAgLTEsNiArMSw3IEBADQogIENPTkZJR19YODY9eQ0KICBDT05GSUdfVEVYVF9CQVNF
PTB4MTExMDAwMA0KICBDT05GSUdfU1lTX01BTExPQ19GX0xFTj0weDEwMDANCitDT05GSUdf
QkxPQkxJU1RfU0laRV9SRUxPQz0weDIwMDAwDQogIENPTkZJR19OUl9EUkFNX0JBTktTPTgN
CiAgQ09ORklHX0VOVl9TSVpFPTB4NDAwMDANCiAgQ09ORklHX01BWF9DUFVTPTINCkBAIC0z
Myw2ICszNCw3IEBAIENPTkZJR19MT0dGX0ZVTkM9eQ0KICBDT05GSUdfU1BMX0xPRz15DQog
IENPTkZJR19ESVNQTEFZX0JPQVJESU5GT19MQVRFPXkNCiAgQ09ORklHX1BDSV9JTklUX1I9
eQ0KK0NPTkZJR19CTE9CTElTVD15DQogIENPTkZJR19CTE9CTElTVF9GSVhFRD15DQogIENP
TkZJR19CTE9CTElTVF9BRERSPTB4MTAwMDANCiAgQ09ORklHX1NQTF9OT19CU1NfTElNSVQ9
eQ0KZGlmZiAtLWdpdCBhL2NvbmZpZ3MvcWVtdS14ODZfZGVmY29uZmlnIGIvY29uZmlncy9x
ZW11LXg4Nl9kZWZjb25maWcNCmluZGV4IDk0N2QxNWNkNzI3Li4wYjBlMTBjNzk1ZiAxMDA2
NDQNCi0tLSBhL2NvbmZpZ3MvcWVtdS14ODZfZGVmY29uZmlnDQorKysgYi9jb25maWdzL3Fl
bXUteDg2X2RlZmNvbmZpZw0KQEAgLTEsNiArMSw3IEBADQogIENPTkZJR19YODY9eQ0KICBD
T05GSUdfVEVYVF9CQVNFPTB4RkZGMDAwMDANCiAgQ09ORklHX1NZU19NQUxMT0NfRl9MRU49
MHgxMDAwDQorQ09ORklHX0JMT0JMSVNUX1NJWkVfUkVMT0M9MHgyMDAwMA0KICBDT05GSUdf
TlJfRFJBTV9CQU5LUz04DQogIENPTkZJR19FTlZfU0laRT0weDQwMDAwDQogIENPTkZJR19N
QVhfQ1BVUz0yDQpAQCAtMjMsNiArMjQsOSBAQCBDT05GSUdfTE9HPXkNCiAgQ09ORklHX0xP
R0ZfRlVOQz15DQogIENPTkZJR19ESVNQTEFZX0JPQVJESU5GT19MQVRFPXkNCiAgQ09ORklH
X1BDSV9JTklUX1I9eQ0KK0NPTkZJR19CTE9CTElTVD15DQorQ09ORklHX0JMT0JMSVNUX0ZJ
WEVEPXkNCitDT05GSUdfQkxPQkxJU1RfQUREUj0weDEwMDAwDQogIENPTkZJR19DTURfQ1BV
PXkNCiAgQ09ORklHX0NNRF9CT09URUZJX1NFTEZURVNUPXkNCiAgQ09ORklHX0NNRF9OVkVE
SVRfRUZJPXkNCg0KSnVzdCBzZXR0aW5nIENPTkZJR19CTE9CTElTVD1uIHNvbHZlcyB0aGlz
IHByb2JsZW0gZm9yIG1lLg0KDQpJJ20gbm90IHN1cmUgaG93IHRvIGRlYnVnIHRoaXMgZnVy
dGhlciwgYmVjYXVzZSB2MjAyNS4wMSBkb2Vzbid0IGJ1aWxkIA0Kd2l0aCB0aGUgY29uZmln
IGZyb20gdjIwMjUuMDQtcmM1Og0KbGQuYmZkOiBhcmNoL3g4Ni9saWIvdGFibGVzLm86IGlu
IGZ1bmN0aW9uIGB3cml0ZV90YWJsZXMnOg0KL2hvbWUvbmlrbGFzL0J1aWxkL3UtYm9vdC9h
cmNoL3g4Ni9saWIvdGFibGVzLmM6MTcxOiB1bmRlZmluZWQgcmVmZXJlbmNlIA0KdG8gYGFj
cGlfd3JpdGVfcnNkcCcNCg0KDQpHcmVldGluZ3MsDQpOaWtsYXMNCg0K

--------------07GLX7np7tbixOTZq5lwTG7J--

--------------GhsQwLWW0acz5VrDpWTBNRJ8
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdIF40XVnlLMtKvF5apyYbs6R6OsFAmfv2kYACgkQapyYbs6R
6Osn+w//UBYGCJjkA+jV3AgzJnyzjToBTBUdrfMVZJIFbWMfmbZruo9CME9zMTIC
NP9isPtX9oDR4cMuwTcT7I3+wLP2Gq4nJg9zmf5G+jT6K6k/XWSB9r51ob4vu+/C
6CT3vtFJtIRgKzn1r2jfZpAW9OgT00MPwTXZO2XVRdqvBgobt5JR4rpNNjQooh+5
kaOgkrgFGzV7wlOSlEdVviGEP/i8dsidms0pLq4wTpKZVQw9BjW4kc+niz7nRzdx
pf1PJf5RTjxTRyrBaCt5YkoZUreu05tb06iJh5NegnagYCrqbcMqPokMGg+IpJ10
ufriezxh2GKP+lKXuVw5uxuel9JH7LuO7Sm+89u1HSNNfVvYx8HxCRUU47rC8poe
UaygEhUymNva7HiC+iCVHcrRAKjuYr+FhG7ZiRa9JpkWHd/7ETO5nMgIU+byztj6
/O8E/3urkk0e9LMhvz/zCfbDo3BdluLftplsUj/xaDInm22UvSkL8sztDENkQOOA
lz+N7rrtMHD9vhwCOLwWr/RAYsR9EiFzNe/NLXxkT9NqKeYG9k9mNuYV9yGQCE5i
EZ5IT9QHW4fm2+8tDKByTEZ1aNSuz86uJE3kM0xG/89nDTz1cQdk9ptxL1XtmMaF
mSsWe3aieCS/qmZfyeKdya5XWVopvrDpKssspm7toGfzPtG0wOo=
=3OaM
-----END PGP SIGNATURE-----

--------------GhsQwLWW0acz5VrDpWTBNRJ8--
