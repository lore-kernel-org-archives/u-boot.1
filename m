Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFEDC52D7C
	for <u-boot@archiver.kernel.org>; Wed, 21 Aug 2024 16:10:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6531288363;
	Wed, 21 Aug 2024 18:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="bbWVi3nD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 187428863B; Wed, 21 Aug 2024 18:10:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E5D3285B66
 for <u-boot@lists.denx.de>; Wed, 21 Aug 2024 18:10:04 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9641460187;
 Wed, 21 Aug 2024 16:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A66C32781;
 Wed, 21 Aug 2024 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724256603;
 bh=2QQ1jYD2hTbj+dSPVmepK5qdFo1WhlmZPlSphlUo3LM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bbWVi3nDTAwcbjT29R/5JtFx2c8zD0YqgcC6yt0YRCeDsMRlt0gr81Jz+0XC97pdk
 IBRIn1d/7LNTDZQDVv92P7gbS5/Ddch9ldoFWbMomx/7+ziBjycTepJBAdkDR8lGAL
 NFEuBE1AcI7VufI/oi/DRL8GEiSR9peSVenSm2ynWAjWZzX6KKnzMJ1pvtxo+0QIQn
 RskPh9XFdcJiSIlidZa2TTUoeTTRP/k0nQXPku/oWfZefwY1TqhamMvCu+sFItlXCA
 qPVSko3aaYpXxTes61gvwjSY2npNXpmlfm0MWaszzIfkpHlik8K5A3iZbePPemWF9f
 w6cSzB1jah29Q==
Date: Wed, 21 Aug 2024 17:09:58 +0100
From: Conor Dooley <conor@kernel.org>
To: Mayuresh Chitale <mchitale@ventanamicro.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Rick Chen <rick@andestech.com>, Leo <ycliang@andestech.com>,
 Tom Rini <trini@konsulko.com>, Kongyang Liu <seashell11234455@gmail.com>,
 Randolph <randolph@andestech.com>, Michal Simek <michal.simek@amd.com>,
 Yu Chien Peter Lin <peterlin@andestech.com>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Samuel Holland <samuel@sholland.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v1 2/3] riscv: cache: Add CBO instructions
Message-ID: <20240821-overcoat-freeing-34d5108d3e81@spud>
References: <20240820093800.5436-1-mchitale@ventanamicro.com>
 <20240820093800.5436-3-mchitale@ventanamicro.com>
 <9b9bde7d-e640-4502-831f-be06288fd9d9@gmx.de>
 <20240821-smilingly-lance-c051e89df945@wendy>
 <CAN37VV4QLVJDwgQWKf7QMwvK8nzv03XpvJ3J7ajN08dK=SRiPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="vSwgt0WiOfKz/YsB"
Content-Disposition: inline
In-Reply-To: <CAN37VV4QLVJDwgQWKf7QMwvK8nzv03XpvJ3J7ajN08dK=SRiPQ@mail.gmail.com>
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


--vSwgt0WiOfKz/YsB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 09:27:03PM +0530, Mayuresh Chitale wrote:
> On Wed, Aug 21, 2024 at 3:28=E2=80=AFPM Conor Dooley <conor.dooley@microc=
hip.com> wrote:
> >
> > On Tue, Aug 20, 2024 at 02:14:01PM +0200, Heinrich Schuchardt wrote:
> > > On 20.08.24 11:37, Mayuresh Chitale wrote:
> > > > +void riscv_zicbom_init(void)
> > > > +{
> > > > +   struct udevice *dev;
> > > > +
> > > > +   if (!CONFIG_IS_ENABLED(RISCV_ISA_ZICBOM))
> > > > +           return;
> > > > +
> > > > +   uclass_first_device(UCLASS_CPU, &dev);
> > > > +   if (!dev) {
> > > > +           log_err("Failed to get cpu device!\n");
> > > > +           return;
> > >
> > > Please, return an error code.
> > >
> > > > +   }
> > > > +
> > > > +   (void)dev_read_u32(dev, "riscv,cbom-block-size", &zicbom_block_=
size);
> > >
> > > Please, do not ignore errors.
> >
> > I'm curious what the policy of U-Boot is w.r.t. extension probing. Is it
> > okay to enable the option for Zicbom even if your hardware does not
> > support it, in which case riscv_zicbom_init() would be expected to fail
> > gracefully and no CMOs done?
> > Say, for example, you had two very similar chips, one with DMA non-cohe=
rent
> > peripherals and one that only differed by having DMA coherent ones, and=
 you
> > wanted to run the same U-Boot binary on both devices using a devicetree
> > passed from firmware.
> I think in such a case the config option can always be enabled with
> the proper dt being passed by the firmware.

I don't understand what you mean, sorry. Both cases I mention would have
a "proper" devicetree that matches the hardware. I'm interested in
whether or not U-Boot's maintainers think that enabling the config option
should warn on, or preclude use of, systems that do not not support
Zicbom.

Cheers,
Conor.

Also, technically there's no guarantee that "riscv,cbom-block-size" being
present means that zicbom also is. Realistically, it should never be the
case that it is present without zicbom in the isa string representation,
but correctness would require checking that it is. supports_extension()
only supports single-letter extensions at present, making it support
multi-letter extensions should not be too difficult.

--vSwgt0WiOfKz/YsB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZsYRVgAKCRB4tDGHoIJi
0rMIAP4gVOQVuWNLUNgAsjxGmKxXaUP+eMMzoPqb6mkfGUI/SgEApRIINszvIgVD
QuzZF3sb5dHGK1Bz0Bbkb57Xf+mAGwk=
=PbFp
-----END PGP SIGNATURE-----

--vSwgt0WiOfKz/YsB--
