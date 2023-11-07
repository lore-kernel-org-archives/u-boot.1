Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22EDDC4332F
	for <u-boot@archiver.kernel.org>; Tue,  7 Nov 2023 23:12:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B846087663;
	Wed,  8 Nov 2023 00:12:29 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S1ORyA9n";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D366A8764C; Wed,  8 Nov 2023 00:12:27 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E33E8763E
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 00:12:25 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 70112CE0A29;
 Tue,  7 Nov 2023 23:12:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A64C433C7;
 Tue,  7 Nov 2023 23:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699398741;
 bh=qWKc0fSkdyP1LKxtOWOR7VcGH1r1eryn0LrGCJ2qRNM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=S1ORyA9n613hPW9qaspmLU2pxOJ/sPkH5LEfip3uGk8uDkIsvZgTsks1CNbY7CRA1
 vFMwI/k+10lcj7Ge0DKd5xAfYwMMVxGsz5Y5Jysk0MsTXkVbPyQuWQf+i/2WX/ppbC
 L2J9XWY0e60p4JDTnhTZPg3G/hKbDtBI5Cea3aejkp7e7Q7HNUhSCMQ86IrXwXEVyr
 cQOqKfZiD05DVoRzsv1AQlSBsn+C16/DziwitRvDD5Lx4qbhjOLA77POR3GCey7PkG
 6CPNDtwuv7f0TBLArpGEtEPVdIB9hiPSFtbagDI8Rxux/Xbag6TUwZ5zRcdeJdtrS+
 VqRoZOM/BGyeQ==
Date: Tue, 7 Nov 2023 23:12:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Tom Rini <trini@konsulko.com>
Cc: Rob Herring <robh@kernel.org>, Simon Glass <sjg@chromium.org>,
 Andre Przywara <andre.przywara@arm.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Anup Patel <apatel@ventanamicro.com>, Xiang W <merlew4n6@gmail.com>,
 Chanho Park <chanho61.park@samsung.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Peter Hoyes <Peter.Hoyes@arm.com>,
 Alexey Romanov <avromanov@salutedevices.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, palmer@dabbelt.com
Subject: Re: [PATCH v3 0/2] rng: Provide a RNG based on the RISC-V Zkr ISA
 extension
Message-ID: <20231107-audible-undoing-293506af3890@spud>
References: <CAPnjgZ1X8R4h24pP1zoqEADTbntm5Yo2YqfMTePVqbHoJMx_vA@mail.gmail.com>
 <20231106172601.12c36750@donnerap.manchester.arm.com>
 <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="ssGjVTzN0g7HRKBZ"
Content-Disposition: inline
In-Reply-To: <20231107223837.GU6601@bill-the-cat>
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


--ssGjVTzN0g7HRKBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

+CC Palmer

On Tue, Nov 07, 2023 at 05:38:37PM -0500, Tom Rini wrote:
> On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
> > On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
> >=20
> >=20
> > > further clarify or not
> > > the RISC-V ISA thing that's elsewhere in this thread (and part of the
> > > kernel, not a U-Boot thing).
> >=20
> > TBH, this a bit fragmented across threads, and as someone that hasn't
> > been following it it's a bit difficult to tell exactly what is being
> > asked for. Would someone be able to ask it as a direct question?
>=20
> Sorry for being unclear, and thanks for asking. What I think the U-Boot
> community would like to know is, what is the device-tree based way to
> know if a RISC-V platform has the Zbb extensions

For this one, it's pretty straightforward IMO - if riscv,isa-extensions
contains "zbb", then you are safe to use those instructions. My
understanding is that relying on getting illegal instruction traps is
not a sufficient test for usability of standard extensions, as a vendor
extension could be using the same opcodes as a standard extension.

> so the RNG opcodes,
> similar (in concept at least?) to the ARMv8.5 RNG feature.

The ordinary extensions that are instructions - like Zbkb that provides
bit manipulation instructions for cryptography you will be able to rely
on riscv,isa-extensions also. Zkr is actually a CSR acting as an entropy
source and is a bit more complicated. RISC-V Cryptography Extensions
Volume I, Chapter Four [0] is the relevant thing for use of the CSR
provided by Zkr, and it says "The seed CSR is also access controlled by
execution mode, and attempted read or write access will raise an illegal
instruction exception outside M mode unless access is explicitly granted."
My take is that either the SBI implementation needs to provide S-Mode
U-Boot with an accurate devicetree (including what extensions are valid
for use in S-mode) or if the devicetree is provided as part of the U-Boot
binary then it needs to match what is available at that privilege level
on the platform. In this case, you would also be able to rely on
riscv,isa-extensions for that detection. There is an existing dt-binding
patch
<https://lore.kernel.org/linux-riscv/20231107105556.517187-6-cleger@rivosin=
c.com/>
that adds Zkr, and my proposal would be to document that the presence of Zkr
explicitly in riscv,isa-extensions means that the bit in mseccfg.[s,u]seed
has been set so it can be used at the current privilege level.

If that's not acceptable, and people think that having Zkr in the
devicetree means that the hardware has the extension, regardless of
usability at the present privilege level, then IMO we need an SBI ecall
defined to request entablement of the CSR & report as to whether or not
that was possible.

I'm not sure how any of the above lines up with the ARMv8.5 RNG feature
unfortunately.

Cheers,
Conor.

0 - https://github.com/riscv/riscv-crypto/releases/tag/v1.0.1-scalar

--ssGjVTzN0g7HRKBZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUrEUAAKCRB4tDGHoIJi
0vcrAP9XNRnzG/QFNGJgC93hkj55rasy0/lsEQLttkjsI6q3XAEAvC9hp2o22WFQ
bWz9jgQQp+2jzNE0l1fkhXgJRKOyoAg=
=ZWSf
-----END PGP SIGNATURE-----

--ssGjVTzN0g7HRKBZ--
