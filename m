Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846EC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 11:30:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E2298809A5;
	Tue, 29 Apr 2025 13:30:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=uni-duesseldorf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id D05038210F; Tue, 29 Apr 2025 13:30:18 +0200 (CEST)
Received: from a2882.mx.srv.dfn.de (a2882.mx.srv.dfn.de [194.95.233.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4F598070C
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 13:30:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=uni-duesseldorf.de
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=niklas.sombert@uni-duesseldorf.de
Received: from mta-3.mail.zim.hhu.de (mta-3.mail.zim.hhu.de [134.99.128.231])
 by a2882.mx.srv.dfn.de (Postfix) with ESMTPS id CA81916D7E;
 Tue, 29 Apr 2025 13:30:14 +0200 (CEST)
Received: from [10.125.45.125] (unknown [134.99.37.125])
 (Authenticated sender: nisom101@uni-duesseldorf.de)
 by mta-3.mail.zim.hhu.de (Postfix) with ESMTPA id 8FBB3E0305;
 Tue, 29 Apr 2025 13:30:14 +0200 (CEST)
Message-ID: <0fe144dd-2885-4e13-bb09-4d939124a974@uni-duesseldorf.de>
Date: Tue, 29 Apr 2025 13:29:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250405204409.420738-1-sjg@chromium.org>
Content-Language: de-DE
From: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
Autocrypt: addr=niklas.sombert@uni-duesseldorf.de; keydata=
 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
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
In-Reply-To: <20250405204409.420738-1-sjg@chromium.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------c9OfKUvh19AzfO9GWyKSi1wx"
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
--------------c9OfKUvh19AzfO9GWyKSi1wx
Content-Type: multipart/mixed; boundary="------------0orVZKoqVuPN5b0nEAnUjcXR";
 protected-headers="v1"
From: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Message-ID: <0fe144dd-2885-4e13-bb09-4d939124a974@uni-duesseldorf.de>
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via
 EFI
References: <20250405204409.420738-1-sjg@chromium.org>
In-Reply-To: <20250405204409.420738-1-sjg@chromium.org>

--------------0orVZKoqVuPN5b0nEAnUjcXR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgU2ltb24sDQoNCnRoaXMgc29sdmVzIG15IHByb2JsZW0sIHRoYW5rcyENCg0KU2luY2Ug
U01CSU9TIGlzIGJyb2tlbiBhZ2FpbiBpbiB2MjAyNS4wNy1yYzEgKGFuZCBkaXNhYmxpbmcg
YmxvYmxpc3QgDQpkb2Vzbid0IHdvcmsgYW55bW9yZSksIEkgYXBwbGllZCB0aGlzIHBhdGNo
IGFuZCBpdCB3b3JrZWQuDQpJIHByb2JhYmx5IHNob3VsZCBoYXZlIHRyaWVkIHRoaXMgc29v
bmVyLg0KDQpHcmVldGluZ3MsDQpOaWtsYXMNCg0KU2ltb24gR2xhc3Mgd3JvdGU6DQo+IFRo
ZSBFRkktbG9hZGVyIGNvZGUgaGFzIG5vdCBiZWVuIGZ1bGx5IGNvbnZlcnRlZCB0byB1c2Ug
YmxvYmxpc3QsIHNvDQo+IHJlbGllcyBvbiB0aGUgU01CSU9TLXRhYmxlIGFkZHJlc3MgYmVp
bmcgc2V0IGluIGdsb2JhbF9kYXRhLg0KPiANCj4gU2V0IHRoaXMgdXAgaW4gd3JpdGVfdGFi
bGVzKCkgc28gdGhhdCB0aGUgU01CSU9TIHRhYmxlcyBhcmUgYWN0dWFsbHkNCj4gYXZhaWxh
YmxlLg0KPiANCj4gRW5hYmxlIHRoZSBjb21tYW5kIGZvciB4ODYgUUVNVSBzbyB0aGF0IHRo
ZSBTTUJJT1MgdGVzdHMgYWN0dWFsbHkgcnVuLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2lt
b24gR2xhc3MgPHNqZ0BjaHJvbWl1bS5vcmc+DQo+IEZpeGVzOiA4M2NlMzVkNmViYiAoImVt
dWxhdGlvbjogVXNlIGJsb2JsaXN0IHRvIGhvbGQgdGFibGVzIikNCj4gUmVwb3J0ZWQtYnk6
IE5pa2xhcyBTb21iZXJ0IDxuaWtsYXMuc29tYmVydEB1bmktZHVlc3NlbGRvcmYuZGU+DQo+
IC0tLQ0KPiANCj4gICBhcmNoL3g4Ni9saWIvdGFibGVzLmMgICAgICAgICAgICB8IDIgKysN
Cj4gICBib2FyZC9lbXVsYXRpb24vcWVtdS14ODYvS2NvbmZpZyB8IDEgKw0KPiAgIGxpYi9l
ZmlfbG9hZGVyL2VmaV9zbWJpb3MuYyAgICAgIHwgMSArDQo+ICAgMyBmaWxlcyBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9saWIvdGFi
bGVzLmMgYi9hcmNoL3g4Ni9saWIvdGFibGVzLmMNCj4gaW5kZXggZWM1Mjk5MjIwOWYuLmQ3
ZjE4M2Y5NWRjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9saWIvdGFibGVzLmMNCj4gKysr
IGIvYXJjaC94ODYvbGliL3RhYmxlcy5jDQo+IEBAIC0xMjYsNiArMTI2LDggQEAgaW50IHdy
aXRlX3RhYmxlcyh2b2lkKQ0KPiAgIAkJCXVzZV9oaWdoID0gdHJ1ZTsNCj4gICAJCQlpZiAo
IWdkLT5hcmNoLnRhYmxlX3N0YXJ0X2hpZ2gpDQo+ICAgCQkJCWdkLT5hcmNoLnRhYmxlX3N0
YXJ0X2hpZ2ggPSByb21fYWRkcjsNCj4gKwkJCWlmICh0YWJsZS0+dGFnID09IEJMT0JMSVNU
VF9TTUJJT1NfVEFCTEVTKQ0KPiArCQkJCWdkX3NldF9zbWJpb3Nfc3RhcnQocm9tX2FkZHIp
Ow0KPiAgIAkJfQ0KPiAgIAkJcm9tX3RhYmxlX2VuZCA9IHRhYmxlLT53cml0ZShyb21fYWRk
cik7DQo+ICAgCQlpZiAoIXJvbV90YWJsZV9lbmQpIHsNCj4gZGlmZiAtLWdpdCBhL2JvYXJk
L2VtdWxhdGlvbi9xZW11LXg4Ni9LY29uZmlnIGIvYm9hcmQvZW11bGF0aW9uL3FlbXUteDg2
L0tjb25maWcNCj4gaW5kZXggYjJhNGUwODkxYTQuLmMxNTY0ZmJhN2NkIDEwMDY0NA0KPiAt
LS0gYS9ib2FyZC9lbXVsYXRpb24vcWVtdS14ODYvS2NvbmZpZw0KPiArKysgYi9ib2FyZC9l
bXVsYXRpb24vcWVtdS14ODYvS2NvbmZpZw0KPiBAQCAtMjMsNSArMjMsNiBAQCBjb25maWcg
Qk9BUkRfU1BFQ0lGSUNfT1BUSU9OUyAjIGR1bW15DQo+ICAgCWltcGx5IFZJUlRJT19QQ0kN
Cj4gICAJaW1wbHkgVklSVElPX05FVA0KPiAgIAlpbXBseSBWSVJUSU9fQkxLDQo+ICsJaW1w
bHkgQ01EX1NNQklPUw0KPiAgIA0KPiAgIGVuZGlmDQo+IGRpZmYgLS1naXQgYS9saWIvZWZp
X2xvYWRlci9lZmlfc21iaW9zLmMgYi9saWIvZWZpX2xvYWRlci9lZmlfc21iaW9zLmMNCj4g
aW5kZXggOGQyZWY2ZGViNTEuLjUyNzVlOTY2ZGZlIDEwMDY0NA0KPiAtLS0gYS9saWIvZWZp
X2xvYWRlci9lZmlfc21iaW9zLmMNCj4gKysrIGIvbGliL2VmaV9sb2FkZXIvZWZpX3NtYmlv
cy5jDQo+IEBAIC0zNSw2ICszNSw3IEBAIGVmaV9zdGF0dXNfdCBlZmlfc21iaW9zX3JlZ2lz
dGVyKHZvaWQpDQo+ICAgCXZvaWQgKmJ1ZjsNCj4gICANCj4gICAJYWRkciA9IGdkX3NtYmlv
c19zdGFydCgpOw0KPiArCXByaW50ZigicmVnaXN0ZXIgJWx4XG4iLCBhZGRyKTsNCj4gICAJ
aWYgKCFhZGRyKSB7DQo+ICAgCQlsb2dfZXJyKCJObyBTTUJJT1MgdGFibGVzIHRvIGluc3Rh
bGxcbiIpOw0KPiAgIAkJcmV0dXJuIEVGSV9OT1RfRk9VTkQ7DQoNCg==

--------------0orVZKoqVuPN5b0nEAnUjcXR--

--------------c9OfKUvh19AzfO9GWyKSi1wx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdIF40XVnlLMtKvF5apyYbs6R6OsFAmgQuCgACgkQapyYbs6R
6OtTUg/7BjjGPpKbhrvE96ieDvJHt8P3eetiR1U+wzukH0LJYrGG9vXOxjM4TaHW
x978NPfKeG5a1KFJHurDoFnRhVlM+S+o/e1ENkF7AtK8QdBmOowwCeAeqGBS6WlR
rHTeuUAAYev0GWNMe/bAp8phMpN9IPC5gfgP9OwLU2rjvhI04i8nj46wygtOJXxS
rTJr3YrSkG8Vu8+/8kzJqXMek4TcBKOclWO36VjqpT9E6Nkvq7xN4lA6jnve3a0i
B3i1Z1hlrgLX4lkHwFF5U924yGONhwnjXqGm5sgx77pLkkaLXY3Rjdv67lH/aSAy
JJpz5uHk362gWLS18NN9AuoqsqBORjknjYfqknD7L0QoALGh97OiTDwsNBdcEs6q
QESLywVQWZY1hm1LRMD/6f2bJ/1j5cDCl18ITZqC4CS3b61hwpZQ+lYamWGHPGul
sTGQvwSpVgN7Xzwo6M2eF5NubAHsVSsaJMYH1ws4TGcPliSMJ65hEjw3kaClpa5D
KPxCSxCnw/QQ03jGITpQryoZuDKfoNEkqoblsOSmphrlafzu1KOgAUAjcMrXpVK6
Mllqfr/5vjxkb0G7/SUnqTF3G79bisxsnM3GoqPv19yUOV32tn0/Sp3HW7TFmI1O
daucK5htXPd5Y61DmvHMFyev787nnpSmOtDrviF8+lz4dstyQFg=
=PchN
-----END PGP SIGNATURE-----

--------------c9OfKUvh19AzfO9GWyKSi1wx--
