Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9007CC4332F
	for <u-boot@archiver.kernel.org>; Wed,  8 Nov 2023 00:29:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0241D87269;
	Wed,  8 Nov 2023 01:29:21 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="OUwS/CZI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1217B871BB; Wed,  8 Nov 2023 01:29:17 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 173B98756F
 for <u-boot@lists.denx.de>; Wed,  8 Nov 2023 01:29:11 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E9B0B60FDE;
 Wed,  8 Nov 2023 00:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CA7C433C8;
 Wed,  8 Nov 2023 00:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1699403348;
 bh=qZ+AJBj1oEs+fowFGvgTSSfup07s9AnysI/7T+N8Xa4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=OUwS/CZIVdYsipsZwAalveofhBrZ/blZzeqJq/y7m5ya5AEuvGvBmGwiifGO39dn2
 cIUeEZlkZHbjQsAauRvYYnWwCLggPIxNEHNNthyEq8em+EU0CTSlpavpUziba5+7R1
 2PS/GhQIJ+/a0eQIkcqUPoem+npW/Gz1BAOKPSh3yYdqSFNc/x2fyJAkOayUcEVBKr
 xUkk+Y3Q5sZq1YYZ8rMrAQ3/OyAHgE0d5dybpj4dZWApNM6YrN2yrp6b2mVve4w1uL
 WWddyPldBVOj/+4enDYHq7nOM0vQJwx5Ltl3Xv5e2TftIcY/hU6wrIiXzvJaZH97BW
 tRdF5kaXAzoPg==
Date: Wed, 8 Nov 2023 00:29:03 +0000
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
Message-ID: <20231107-sprinkled-sixtieth-6456baa2c7a3@spud>
References: <CAPnjgZ1v1UfADOFDFFFD9UBo5QcRPNLBk+XLBL4JNbGy9poVJw@mail.gmail.com>
 <20231106204608.GJ496310@bill-the-cat>
 <CAPnjgZ28HskiFDBDa=s_k6=WNoPfWu88bAaYCY7ew8dcYXW=aQ@mail.gmail.com>
 <20231107193025.GN6601@bill-the-cat>
 <CAL_JsqKkjPyVUxjANC3_rOkEAyNUBY_mXf27N6U++KTpujYYLQ@mail.gmail.com>
 <20231107221023.GS6601@bill-the-cat>
 <20231107-flyaway-arguable-0bccc778b256@spud>
 <20231107223837.GU6601@bill-the-cat>
 <20231107-audible-undoing-293506af3890@spud>
 <20231107232305.GW6601@bill-the-cat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="Ut9rGd+5ZSBbMXpa"
Content-Disposition: inline
In-Reply-To: <20231107232305.GW6601@bill-the-cat>
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


--Ut9rGd+5ZSBbMXpa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 07, 2023 at 06:23:05PM -0500, Tom Rini wrote:
> On Tue, Nov 07, 2023 at 11:12:16PM +0000, Conor Dooley wrote:
> > +CC Palmer
> >=20
> > On Tue, Nov 07, 2023 at 05:38:37PM -0500, Tom Rini wrote:
> > > On Tue, Nov 07, 2023 at 10:27:50PM +0000, Conor Dooley wrote:
> > > > On Tue, Nov 07, 2023 at 05:10:23PM -0500, Tom Rini wrote:
> > > >=20
> > > >=20
> > > > > further clarify or not
> > > > > the RISC-V ISA thing that's elsewhere in this thread (and part of=
 the
> > > > > kernel, not a U-Boot thing).
> > > >=20
> > > > TBH, this a bit fragmented across threads, and as someone that hasn=
't
> > > > been following it it's a bit difficult to tell exactly what is being
> > > > asked for. Would someone be able to ask it as a direct question?
> > >=20
> > > Sorry for being unclear, and thanks for asking. What I think the U-Bo=
ot
> > > community would like to know is, what is the device-tree based way to
> > > know if a RISC-V platform has the Zbb extensions
> >=20
> > For this one, it's pretty straightforward IMO - if riscv,isa-extensions
> > contains "zbb", then you are safe to use those instructions. My
> > understanding is that relying on getting illegal instruction traps is
> > not a sufficient test for usability of standard extensions, as a vendor
> > extension could be using the same opcodes as a standard extension.
> >=20
> > > so the RNG opcodes,
> > > similar (in concept at least?) to the ARMv8.5 RNG feature.
> >=20
> > The ordinary extensions that are instructions - like Zbkb that provides
> > bit manipulation instructions for cryptography you will be able to rely
> > on riscv,isa-extensions also. Zkr is actually a CSR acting as an entropy
> > source and is a bit more complicated. RISC-V Cryptography Extensions
> > Volume I, Chapter Four [0] is the relevant thing for use of the CSR
> > provided by Zkr, and it says "The seed CSR is also access controlled by
> > execution mode, and attempted read or write access will raise an illegal
> > instruction exception outside M mode unless access is explicitly grante=
d."
> > My take is that either the SBI implementation needs to provide S-Mode
> > U-Boot with an accurate devicetree (including what extensions are valid
> > for use in S-mode) or if the devicetree is provided as part of the U-Bo=
ot
> > binary then it needs to match what is available at that privilege level
> > on the platform. In this case, you would also be able to rely on
> > riscv,isa-extensions for that detection. There is an existing dt-binding
> > patch
> > <https://lore.kernel.org/linux-riscv/20231107105556.517187-6-cleger@riv=
osinc.com/>
> > that adds Zkr, and my proposal would be to document that the presence o=
f Zkr
> > explicitly in riscv,isa-extensions means that the bit in mseccfg.[s,u]s=
eed
> > has been set so it can be used at the current privilege level.
> >=20
> > If that's not acceptable, and people think that having Zkr in the
> > devicetree means that the hardware has the extension, regardless of
> > usability at the present privilege level, then IMO we need an SBI ecall
> > defined to request entablement of the CSR & report as to whether or not
> > that was possible.
> >=20
> > I'm not sure how any of the above lines up with the ARMv8.5 RNG feature
> > unfortunately.
>=20
> Thanks. Setting aside Simon's follow-up, this is what I was looking for.
> We might have to wait for Heinrich to return from the conference to have
> time to look at how to utilize the above and see what we can do from
> there.

I did read that, but I don't think most of it is relevant to the binding
itself. His five things were:
| - U-Boot models hardware (and other things) as devices in driver model [1]

This I think should be satisfied. The Zkr CSR is a property of the CPU,
and shouldn't have its own DT node IMO. Is it problematic for U-Boot to
populate multiple devices for its driver model based on one DT node?
I know in Linux that I can create devices using something like
platform_device_register(), does U-Boot have a similar facility?
https://elixir.bootlin.com/linux/latest/source/drivers/base/platform.c#L767

| - U-Boot requires devices to be in the devicetree, with very limited
| exceptions [2]

| - Where multiple devices exist in a uclass, it is desirable to be able
| to number them [3]

I'm not sure really how this one ties in. Do you need a number for each
CPU that supports Zkr, since a system may be heterogeneous? I think that
how you treat things like that is beyond communicating support via DT
though, IMO the job of the DT is just to tell U-Boot on which CPUs it
can access the seed CSR.

| - Similarly it is useful to be able select a particular device, e.g.
| with a phandle [4]

I suppose a phandle to the CPU would work in this case.

| - U-Boot uses devicetree for configuration as it has no userspace

Cheers,
Conor.

--Ut9rGd+5ZSBbMXpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZUrWTgAKCRB4tDGHoIJi
0pQJAQDn4uK1nVIRxuD+p7IqW4mjUriYKBxU/bs5S8YLclOEogEA+zIO0GHZv+vl
t5GMxPKr54S0jOyqcdJaQXUJkI5RbQc=
=GPiX
-----END PGP SIGNATURE-----

--Ut9rGd+5ZSBbMXpa--
