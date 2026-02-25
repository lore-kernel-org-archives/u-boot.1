Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 554E6FCEE81
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 11:09:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B0B8E8366F;
	Wed, 25 Feb 2026 12:09:26 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GyK3Rra7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5F1F83D77; Wed, 25 Feb 2026 12:09:24 +0100 (CET)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B383082A9E
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 12:09:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AFFF0443BA;
 Wed, 25 Feb 2026 11:09:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49457C19423;
 Wed, 25 Feb 2026 11:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772017760;
 bh=+pBgW1CyfN5avuwQhcjgaX2iAr3b7MGL/NcRbCzYb/Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GyK3Rra7f8sP/lUfbKjAzFHZbFbfR34GfoYxWqUpvTafnWnjk6IOsoy72VScruMEj
 hH/TITZgvpg1+oM9qcIGWddC0qjMXzLBV7F0HPxHTTHWObMItRhYI4514Nrkjdcjda
 RK7nSExCKZ0Q9fiUc3mAxRZ9lSmQ8ZFOVDNgR1/OLqjH4u2/vX90/SaeezIm4rr6vv
 ytTbdrZ21Xlm7oAcwMjGlCw+fE+UbK0zI8Sy0XF7jVUUods57qqVucEVuKjuVaVHud
 sjNAOh6LHxasIbRK9CjsyVuBa9LLXdPkufAH6HGTRmpUfXBgJOpVyB7HTWyW8oP7vc
 9ye2hBknUPdDQ==
Date: Wed, 25 Feb 2026 11:09:16 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't
 exist
Message-ID: <20260225-scooter-dutiful-6ee0efe16a8d@spud>
References: <20260225102831.48857-1-heinrich.schuchardt@canonical.com>
 <20260225-bagpipe-jellied-de21366481df@spud>
 <6d35ccaf-3276-435f-b953-8023985f31f3@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="dfgl3x/ha0pja1mc"
Content-Disposition: inline
In-Reply-To: <6d35ccaf-3276-435f-b953-8023985f31f3@canonical.com>
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


--dfgl3x/ha0pja1mc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 12:00:13PM +0100, Heinrich Schuchardt wrote:
> On 2/25/26 11:40, Conor Dooley wrote:
> > On Wed, Feb 25, 2026 at 11:28:31AM +0100, Heinrich Schuchardt wrote:
> > > Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFIVE_C=
LINT.
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   arch/riscv/cpu/mpfs/Kconfig | 2 --
> > >   1 file changed, 2 deletions(-)
> > >=20
> > > diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kconfig
> > > index bcf1ede818b..8054313d182 100644
> > > --- a/arch/riscv/cpu/mpfs/Kconfig
> > > +++ b/arch/riscv/cpu/mpfs/Kconfig
> > > @@ -6,8 +6,6 @@ config MICROCHIP_MPFS
> > >   	imply CPU
> > >   	imply CPU_RISCV
> > >   	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> > > -	imply SIFIVE_CLINT if RISCV_MMODE
> > > -	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
> >=20
> > Is this correct? Does it not mean that I just didn't update these to
> > match the rename done in 9675d920278 ("riscv: Rename SiFive CLINT to
> > RISC-V ALINT")? My original patch I think predates that rename, so I
> > probably just sent it on without testing these since we don't use SPL
> > or U-Boot in M-Mode. If the generic CPU wants them in these scenarios,
> > then we do too, so the renamed versions are probably a better fit?

> MPFS boards neither use SPL nor do they run main U-Boot in M-mode.
> (SPL_)ACLINT seems irrelevant here.

Fair enough. Should cite this though in the commit message, to explain
why removal not fixing with the correct symbols is the correct thing to
do.

--dfgl3x/ha0pja1mc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ7YXAAKCRB4tDGHoIJi
0k/1AQDr4ZwRQ53P0szlDfKYe5TkGMPAArjfrlfwvhoivwrp3AD/URYznibJz4SM
S8ovu5WWcO9P69IqkfmGcfGWIGYe7AA=
=LF8O
-----END PGP SIGNATURE-----

--dfgl3x/ha0pja1mc--
