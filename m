Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97E55C43458
	for <u-boot@archiver.kernel.org>; Thu,  9 Jul 2026 16:57:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A558484B73;
	Thu,  9 Jul 2026 18:57:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="iy931Ygx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5A78D84B77; Thu,  9 Jul 2026 18:57:19 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 8D03D8498C
 for <u-boot@lists.denx.de>; Thu,  9 Jul 2026 18:57:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CBBBC41902;
 Thu,  9 Jul 2026 16:57:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC6A51F000E9;
 Thu,  9 Jul 2026 16:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783616234;
 bh=L8j9DwYHgeGvrM00F0VSCXfq8BSPkZtNrAe0GOD34i8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=iy931YgxBgJCJc1tNNoXaGOJQk51VVxZRixnSIHEM8qRszRX8k5uhhATtTpxf2y0n
 xoq1fiXnqXy22LaGpk3Q4CJAFsh5kX5b7v0HPs89lmcUyQWE3R0jQ4tmCNPCDT7OIQ
 SbvNZ9gfU68i0rbMgCu6lr5ke3IZIhnL53YOo+dWGUf8Pc3w0s+PfGeYve5jaP9uTz
 aai9CZvPtbsd2mFIV+Kq0vztA17K+2hDhILVrK/pFM84o7BEeiqYShA3bcxaZS2xve
 zWu0uLbMN6iDpceYnsVk+xE8y0gv4FABR1oe2QPCFMi5tQ3+N2EANDnRnfyCG7pNHA
 3i5unVm8sKEzg==
Date: Thu, 9 Jul 2026 17:57:09 +0100
From: Conor Dooley <conor@kernel.org>
To: Michal Simek <michal.simek@amd.com>
Cc: Charles Perry <charles.perry@microchip.com>, u-boot@lists.denx.de,
 Rahul Pathak <rahul@summations.net>,
 Anup Patel <anup@brainfault.org>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Romain Caritey <romain.caritey@microchip.com>,
 Mame Maria Mbaye <MameMaria.Mbaye@microchip.com>,
 Tom Rini <trini@konsulko.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
 Rick Chen <rick@andestech.com>, Leo Yu-Chi Liang <ycliang@andestech.com>,
 Souvik Chakravarty <Souvik.Chakravarty@arm.com>
Subject: Re: [PATCH v2 0/5] Add support for RPMI to U-Boot
Message-ID: <20260709-rounding-gala-841f8043edfc@spud>
References: <20260708215200.1331416-1-charles.perry@microchip.com>
 <c2c87ebf-e26b-4987-bf78-cc2508ec7ca8@amd.com>
 <ak+2LeDbngEr7oqj@bby-cbu-swbuild03.eng.microchip.com>
 <7a17de63-6cd8-4c23-b111-f759ca6af249@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yh4Tf8J25Isj21va"
Content-Disposition: inline
In-Reply-To: <7a17de63-6cd8-4c23-b111-f759ca6af249@amd.com>
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

--yh4Tf8J25Isj21va
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 09, 2026 at 05:20:31PM +0200, Michal Simek wrote:
>=20
>=20
> On 7/9/26 16:54, Charles Perry wrote:
> > On Thu, Jul 09, 2026 at 03:02:11PM +0200, Michal Simek wrote:
> > >=20
> > >=20
> > > On 7/8/26 23:51, Charles Perry wrote:
> > > > Hello,
> > > >=20
> > > > This series adds support for RISC-V Platform Management Interface (=
RPMI) to
> > > > U-Boot. RPMI is an OS-agnostic protocol for communication between an
> > > > Application Processor (AP) and a Platform Microcontroller (PuC) [1]=
=2E The
> > > > goals and purpose of RPMI are similar to ARM's SCMI.
> > >=20
> > >  From the first look it looks like SCMI. Why do you introducing somet=
hing
> > > what can be replaced by SCMI?
> > > And SCMI has only specific ARM transport layer but the rest is arch i=
ndependent.
> >=20
> > Yes, there are alot of similarities between RPMI and SCMI. I found some
> > justification for this in some Linux Plumbers slide deck on RISC-V power
> > management by Paul Walmsley [1]:
> >=20
> >   * The hardware is more sophisticated
> >   * The software is more sophisticated
> >   * Some stakeholders haven=E2=80=99t had input in the past
> >   * RISC-V =E2=80=9Cbig tent=E2=80=9D philosophy
> >=20
> > I think this is referring to the SBI spec of RISC-V vs arm's PSCI but t=
he
> > same arguments may as well apply to RPMI vs SCMI.
> >=20
> > Some other arguments:
> >=20
> >   * The microcontroller side is made easier with RPMI because of librpm=
i [2].
> >     SCMI has SCP-firmware [3] which is a quite complex project compared=
 to
> >     librpmi. Also SCP-firmware doesn't accept contribution anymore.
> >   * RPMI is already in Linux.
> >=20
> > For what I'm doing, RPMI is what gave me the first results (controlling
> > clocks) the quickest because all the pieces were present in Linux, Open=
SBI
> > and librpmi. There are however lots of missing service drivers in Linux=
 and
> > some other important OS like u-boot don't have support for RPMI at all.=
 So
> > even though I gave you a bunch of reason for saying yes to RPMI, I do h=
ave
> > some doubt about how long it will take to bring RPMI on par with SCMI,
> > making the SCMI-for-RISCV transport that you suggest more appealing.
> >=20
> > [1]: https://lpc.events/event/2/contributions/197/attachments/133/165/R=
ISC-V_Platform_Power_Management.pdf (slide 22)
> > [2]: https://github.com/riscv-software-src/librpmi
> > [3]: https://gitlab.arm.com/firmware/SCP-firmware
> >=20
> > >=20
> > > In our case where we have Microblaze V in programmable logic I can't =
see any
> > > reason to use RPMI for talking to the same server if I need to do it =
=66rom
> > > ARM side too via SCMI.
> > >=20
> > > I pretty much think that there should be communication with ARM and i=
nstead
> > > of creating another firmware interface talk to each other and have on=
ly one
> > > which can be used across multiple architectures.
>=20
> I have sent RFC patch to eliminate ARM from SCMI here
>=20
> https://lore.kernel.org/all/d7f7e8c9589d937b60e43168845ab4fda15037a3.1783=
603600.git.michal.simek@amd.com/
>=20
> and feedback is quite positive. I think it is more or less question to
> Microchip if you want to take responsibility on another firmware interface
> (I understand that it is approved, etc) or just use what it is around for
> longer time.

I don't think it is a question to just Microchip, it's a question to be ask=
ed
to all the various companies and projects using RISC-V. For example will
upstream OpenSBI accept support for SCMI, or will they say "we have RPMI,
use that"?

--yh4Tf8J25Isj21va
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCak/S5QAKCRB4tDGHoIJi
0rMQAP9+4dy+KjQNKBnqtm4ZJxWRUFNizKGhYC2IgzfZxBPAZQD/WhOpYI3TtHlt
+67R9ZlweUYg42q5fHwguQ1DzMUHrwk=
=nnNP
-----END PGP SIGNATURE-----

--yh4Tf8J25Isj21va--
