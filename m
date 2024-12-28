Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CA0FE7718F
	for <u-boot@archiver.kernel.org>; Sat, 28 Dec 2024 14:38:35 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 519DF80362;
	Sat, 28 Dec 2024 15:38:34 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C957804BA; Sat, 28 Dec 2024 12:11:24 +0100 (CET)
Received: from mx.skole.hr (mx1.hosting.skole.hr [161.53.165.185])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A188C80431
 for <u-boot@lists.denx.de>; Sat, 28 Dec 2024 12:11:21 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=none (p=none dis=none) header.from=skole.hr
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=duje.mihanovic@skole.hr
Received: from mx1.hosting.skole.hr (localhost.localdomain [127.0.0.1])
 by mx.skole.hr (mx.skole.hr) with ESMTP id 1CC6B81706;
 Sat, 28 Dec 2024 12:11:21 +0100 (CET)
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje.mihanovic@skole.hr>
To: Tom Rini <trini@konsulko.com>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Initial support for PXA1908 and samsung-coreprimevelte
Date: Sat, 28 Dec 2024 12:10:49 +0100
Message-ID: <4950238.GXAFRqVoOG@radijator>
In-Reply-To: <20241227215327.GH1505244@bill-the-cat>
References: <20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr>
 <20241227215327.GH1505244@bill-the-cat>
MIME-Version: 1.0
Autocrypt: addr=duje.mihanovic@skole.hr; keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KER
 1amUgTWloYW5vdmnEhyA8ZHVqZUBkdWplbWloYW5vdmljLnh5ej6ImQQTFgoAQRYhBG3/QdYN8x
 S1t2umMK0xk1JFj60DBQJmiSHOAhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAA
 AoJEK0xk1JFj60D1GABAJVSorZdMOlrp/oQtCSH/G53NE56x/JHA8VX+ZQBd/H3AP4/EcUf6eef
 DUxVMh2bdkmuQKsVZGgOGiXpMksrVntWBrQpRHVqZSBNaWhhbm92acSHIDxkdWplLm1paGFub3Z
 pY0Bza29sZS5ocj6ImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSH/AhsDBQkJZg
 GABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw8A/i4lPOL7NaYoYePDq
 l8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xqh2MRcNmJCHA1YhWAbg4
 BGaJIc4SCisGAQQBl1UBBQEBB0DEc9JeA55OlZfWKgvmRgw6a/EpBQ8mDl6nQTBmnd1XHAMBCAe
 IfgQYFgoAJhYhBG3/QdYN8xS1t2umMK0xk1JFj60DBQJmiSHOAhsMBQkJZgGAAAoJEK0xk1JFj6
 0DG5MA/iuo4l2GDEZ1Zf+XaS//8FwdXDO9nHkfbV2MHjF4NZXwAQDroMzBdMcqVvc8GABFlTTgG
 j7KrRDz2HwWNyF8ZeprAQ==
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Mailman-Approved-At: Sat, 28 Dec 2024 15:38:33 +0100
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

On Friday 27 December 2024 22:53:27 Central European Standard Time Tom Rini=
=20
wrote:
> On Fri, Dec 27, 2024 at 10:22:14PM +0100, Duje Mihanovi=C4=87 wrote:
> > Hello,
> >=20
> > This series adds initial support for Marvell's PXA1908 ARM64 SoC and
> > Samsung's Galaxy Core Prime VE LTE, a smartphone based on said SoC.
> >=20
> > On this board, U-Boot is used as a secondary bootloader to work around
> > certain quirks of the factory S-Boot.
> >=20
> > Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
>=20
> What is the status of getting these dtsi files upstream? Thanks.

They are the last component of PXA1908 support waiting to be merged, see=20
https://lore.kernel.org/all/20241104-pxa1908-lkml-v13-0-e050609b8d6c@skole.=
hr/=20
=2E

In case you're asking this to see whether the board could use OF_UPSTREAM, =
I=20
should note that the dtsi files in this set differ from the ones waiting to=
 be=20
merged into Linux differ by being slimmed down, having different compatible=
s=20
in a few places (CPU and serial ports specifically) and the coreprimevelte =
dts=20
also has an extra property `pxa,rev-id` which the stock bootloader requires=
=20
for booting. Could all this be handled in a `pxa1908-samsung-coreprimevelte=
=2Du-
boot.dtsi` and `pxa1908-u-boot.dtsi` once they are upstreamed?

Regards,
=2D-=20
Duje



