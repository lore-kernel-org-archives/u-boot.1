Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9489DFD374E
	for <u-boot@archiver.kernel.org>; Wed, 25 Feb 2026 14:00:29 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CBD6583EE8;
	Wed, 25 Feb 2026 15:00:27 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k/JvyUJK";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA3B083EE8; Wed, 25 Feb 2026 15:00:21 +0100 (CET)
Received: from sea.source.kernel.org (unknown
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12E983EF5
 for <u-boot@lists.denx.de>; Wed, 25 Feb 2026 14:59:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de;
 spf=tempfail smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C476840511;
 Wed, 25 Feb 2026 13:58:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600FFC116D0;
 Wed, 25 Feb 2026 13:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772027933;
 bh=qOiihoxfBxQFivIeo8ypOvagXLhhRhQXbpVkLyPWn5o=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=k/JvyUJKSGmcEcKbvoPds8OV7GzQZ/Fef+4w2lqnyLh7M2bKlv9zPMt777agNQlcM
 5ifDsaxVscxMuzfcxPdcH8CBWJEDmPw1GSBSfl9a9XTNi/6IfOIEyhd6TQjbHUT7ak
 IvjDghKJcJLRqyQlNPNC/ZgqIHpRxVNyQD/1pbSlQpgkfRhrSqgYQA7mUNE2elauQ0
 HXuxhEKSLnglfWvSql1zs/8uXScQdoNPA3s0i+r4DZBEjSaPu/GvvKjJPv0pFRJWb5
 31yArhgTI1esjVFZotHLK54mFIEYJm56nDjQQO7fa+VzkdiPuNMDXaeJyCrO1GWIA+
 xoJXToLARQx0w==
Date: Wed, 25 Feb 2026 13:58:50 +0000
From: Conor Dooley <conor@kernel.org>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] riscv: mpfs: SIFIVE_CLINT and SPL_SIFIVE_CLINT don't
 exist
Message-ID: <20260225-donated-gusto-37f449fe069b@spud>
References: <20260225102831.48857-1-heinrich.schuchardt@canonical.com>
 <20260225-bagpipe-jellied-de21366481df@spud>
 <6d35ccaf-3276-435f-b953-8023985f31f3@canonical.com>
 <20260225-scooter-dutiful-6ee0efe16a8d@spud>
 <7ac69957-8fe5-4d14-b849-3d410868b0fb@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JpqA95EKWlgH6h1E"
Content-Disposition: inline
In-Reply-To: <7ac69957-8fe5-4d14-b849-3d410868b0fb@canonical.com>
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


--JpqA95EKWlgH6h1E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 25, 2026 at 01:03:34PM +0100, Heinrich Schuchardt wrote:
> On 2/25/26 12:09, Conor Dooley wrote:
> > On Wed, Feb 25, 2026 at 12:00:13PM +0100, Heinrich Schuchardt wrote:
> > > On 2/25/26 11:40, Conor Dooley wrote:
> > > > On Wed, Feb 25, 2026 at 11:28:31AM +0100, Heinrich Schuchardt wrote:
> > > > > Don't imply non-existent symbols CONFIG_SIFIVE_CLINT and SPL_SIFI=
VE_CLINT.
> > > > >=20
> > > > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical=
=2Ecom>
> > > > > ---
> > > > >    arch/riscv/cpu/mpfs/Kconfig | 2 --
> > > > >    1 file changed, 2 deletions(-)
> > > > >=20
> > > > > diff --git a/arch/riscv/cpu/mpfs/Kconfig b/arch/riscv/cpu/mpfs/Kc=
onfig
> > > > > index bcf1ede818b..8054313d182 100644
> > > > > --- a/arch/riscv/cpu/mpfs/Kconfig
> > > > > +++ b/arch/riscv/cpu/mpfs/Kconfig
> > > > > @@ -6,8 +6,6 @@ config MICROCHIP_MPFS
> > > > >    	imply CPU
> > > > >    	imply CPU_RISCV
> > > > >    	imply RISCV_TIMER if (RISCV_SMODE || SPL_RISCV_SMODE)
> > > > > -	imply SIFIVE_CLINT if RISCV_MMODE
> > > > > -	imply SPL_SIFIVE_CLINT if SPL_RISCV_MMODE
> > > >=20
> > > > Is this correct? Does it not mean that I just didn't update these to
> > > > match the rename done in 9675d920278 ("riscv: Rename SiFive CLINT to
> > > > RISC-V ALINT")? My original patch I think predates that rename, so I
> > > > probably just sent it on without testing these since we don't use S=
PL
> > > > or U-Boot in M-Mode. If the generic CPU wants them in these scenari=
os,
> > > > then we do too, so the renamed versions are probably a better fit?
> >=20
> > > MPFS boards neither use SPL nor do they run main U-Boot in M-mode.
> > > (SPL_)ACLINT seems irrelevant here.
> >=20
> > Fair enough. Should cite this though in the commit message, to explain
> > why removal not fixing with the correct symbols is the correct thing to
> > do.
>=20
> What should happen with non-existent MICROCHIP_QSPI in the same file?
> Is that meant to be called CONFIG_MICROCHIP_COREQSPI?

Yes, and it should be 2f7420ccaac ("riscv: mpfs: move SoC level options to
the CPU Kconfig") because it was correct beforehand.

--JpqA95EKWlgH6h1E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaZ8AAAAKCRB4tDGHoIJi
0jXyAP4z1DQFJW/6YusezERvWDYsNmasxte4VyF9rl6GNonSTAD/TzIll5WIGcMW
nvVtee0Orgff7OGzvjWOe++08EfaTA4=
=MRCK
-----END PGP SIGNATURE-----

--JpqA95EKWlgH6h1E--
