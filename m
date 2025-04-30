Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC62C369D9
	for <u-boot@archiver.kernel.org>; Wed, 30 Apr 2025 09:39:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 442B48283E;
	Wed, 30 Apr 2025 11:39:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=uni-duesseldorf.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 23EFB82B17; Wed, 30 Apr 2025 11:39:25 +0200 (CEST)
Received: from c2882.mx.srv.dfn.de (c2882.mx.srv.dfn.de [194.95.239.78])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1DDDE8215B
 for <u-boot@lists.denx.de>; Wed, 30 Apr 2025 11:39:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none)
 header.from=uni-duesseldorf.de
Authentication-Results: phobos.denx.de; spf=pass
 smtp.mailfrom=niklas.sombert@uni-duesseldorf.de
Received: from mta-1.mail.zim.hhu.de (mta-1.mail.zim.hhu.de [134.99.128.229])
 by c2882.mx.srv.dfn.de (Postfix) with ESMTPS id 57987893;
 Wed, 30 Apr 2025 11:39:22 +0200 (CEST)
Received: from [10.125.45.125] (unknown [134.99.37.125])
 (Authenticated sender: nisom101@uni-duesseldorf.de)
 by mta-1.mail.zim.hhu.de (Postfix) with ESMTPA id F3F6D24034D;
 Wed, 30 Apr 2025 11:39:21 +0200 (CEST)
Message-ID: <d058767c-7775-4b4b-a133-962e99dc0a1b@uni-duesseldorf.de>
Date: Wed, 30 Apr 2025 11:39:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via EFI
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20250405204409.420738-1-sjg@chromium.org>
 <0fe144dd-2885-4e13-bb09-4d939124a974@uni-duesseldorf.de>
 <CAFLszTjcV0e6AgRsbHdj2oW5o_4nE6KEEQ+QyxXgYVRgKtKn1Q@mail.gmail.com>
Content-Language: de-DE
From: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
Autocrypt: addr=niklas.sombert@uni-duesseldorf.de; keydata=
 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
In-Reply-To: <CAFLszTjcV0e6AgRsbHdj2oW5o_4nE6KEEQ+QyxXgYVRgKtKn1Q@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------xXyamW510OOt3HvdDj2zacA9"
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
--------------xXyamW510OOt3HvdDj2zacA9
Content-Type: multipart/mixed; boundary="------------qwBpadnTH3Fx0Q5koP5hHDfu";
 protected-headers="v1"
From: Niklas Sombert <niklas.sombert@uni-duesseldorf.de>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Tom Rini
 <trini@konsulko.com>, Bin Meng <bmeng.cn@gmail.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Message-ID: <d058767c-7775-4b4b-a133-962e99dc0a1b@uni-duesseldorf.de>
Subject: Re: [PATCH] x86: efi_loader: Ensure the SMBIOS tables are sent via
 EFI
References: <20250405204409.420738-1-sjg@chromium.org>
 <0fe144dd-2885-4e13-bb09-4d939124a974@uni-duesseldorf.de>
 <CAFLszTjcV0e6AgRsbHdj2oW5o_4nE6KEEQ+QyxXgYVRgKtKn1Q@mail.gmail.com>
In-Reply-To: <CAFLszTjcV0e6AgRsbHdj2oW5o_4nE6KEEQ+QyxXgYVRgKtKn1Q@mail.gmail.com>

--------------qwBpadnTH3Fx0Q5koP5hHDfu
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

U2ltb24gR2xhc3Mgd3JvdGU6DQo+IFRoYW5rcyBmb3IgdGVzdGluZyB0aGlzLiBDYW4geW91
IHBsZWFzZSByZXBseSB3aXRoIGEgJ1Rlc3RlZC1ieScgdGFnPw0KDQpTdXJlLg0KDQpUZXN0
ZWQtYnk6IE5pa2xhcyBTb21iZXJ0IDxuaWtsYXMuc29tYmVydEB1bmktZHVlc3NlbGRvcmYu
ZGU+DQo=

--------------qwBpadnTH3Fx0Q5koP5hHDfu--

--------------xXyamW510OOt3HvdDj2zacA9
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEdIF40XVnlLMtKvF5apyYbs6R6OsFAmgR78AACgkQapyYbs6R
6Ovygw/+KKejI/n4pYpgSzHRIUkaOl4nANnNkaDqrE3sYu/hUFPBIMilGh2TSjfG
kVwgMQXclBaMGnLi2nWx9DakNHCkH2fI1p96rNZ3jaCQnH/bI1yOsPECl9tUmgMU
f8D5TZsc7BQETewO/00Ej4tC0VvrUGUlRm+wsETCAKeo0xsIEDTYgAtzFcFLt22F
7H5Qww/3DrtOaeP20ZfOMjnew8ZX9iyERI2egdX/6LOknoQqHWVRBE4B5mtmps0t
BAgW7h2xDCEIkM/eNUsrTjP3v9shQP0yFSkaVj9DFGaPpdN6rYytLHDJfWzCJ/0r
RZgJ7fgXf5H276gLBKd0VJ/3R0Ga4q0yS3WFth2Q36fcS0kZdF2QoG9TPqIhXESb
DVyRD0qWCEBF3uc+enbhv763o+HPUX8UJok4Z8f3Q18J/LXoKLr3h6kEMERQmKPa
7+eLfrQNhkxaBgvZIt+rFHOGjyiV8jlZdMaqf4MrpDbqZXsBrB6M9TkXmF2SE/pt
ruCAe3cwA2UIgyqKXUVKKeaY0IsnG2swzEU0ftyPy/m4+LTuzReZk8bP/RwIOlf0
wb6VoQp08i9cdhJ0MYzTOMQtT4j7DZ/74836SGZp1JxjWCgzKn2khJUpFaeNZAXw
Cv62K5xkbxmhiOma6Xg9FSyEgrSHZTJKrY2WGUETli4ZZjVUWGk=
=H5rH
-----END PGP SIGNATURE-----

--------------xXyamW510OOt3HvdDj2zacA9--
