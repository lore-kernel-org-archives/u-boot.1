Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C041BC30638
	for <u-boot@archiver.kernel.org>; Thu, 17 Aug 2023 15:10:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E66B486B74;
	Thu, 17 Aug 2023 17:10:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="qYvK9UuA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id A814286989; Thu, 17 Aug 2023 17:10:33 +0200 (CEST)
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com
 [IPv6:2607:f8b0:4864:20::112b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D168C86B74
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 17:10:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-589e4179fc7so53633247b3.2
 for <u-boot@lists.denx.de>; Thu, 17 Aug 2023 08:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692285029; x=1692889829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=vIdx+IvMmUuX7Ygx07YsQoOYyaGh+vX+jjqeQrn9eXU=;
 b=qYvK9UuAE+SYl+ouiuAi9SRn6QVnbjCwU/2HGcWHIbHY44YA4cxw6UUj1qfxc5If0Q
 4SPq1eXJ4XahGbZcx7J3xXuslrYn9f4okJiKF+YhTThcME/GKB/JuevI5aslZD3j+x76
 VC/7PuOMRI9f8M+O1fsQHJmfwo4k/9Dq9aUkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692285029; x=1692889829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vIdx+IvMmUuX7Ygx07YsQoOYyaGh+vX+jjqeQrn9eXU=;
 b=L1teYtCVBflXSaP/wI/PCNYXJllvb4YzmoubQ/t/gpygwuN8gNtEOY/bX5F371ZK8g
 5NFZmtiFl5zG2DYcUD4F9CGE6DhGSzwA8OED11wHspJ+LBysfL/3vUFNbjQ6qaDtEWOE
 URQxgYa7O8SXiyHXcrn1uR5b9ogizRODcuTwZJggntYSI90hKy2d/TREz2xF7LplOOFh
 OlSLTwSkasarofB0yHWGpf+NSBm9WseR2e24+GiYZwnlQaBoxu+VUH2N97DOi7yMLk+q
 mxpf4Mz5l8793fRwObHQFbPNDi2LOT2OvhqkE8i05VmMFffZhLgZc3lNZX42vlWQA0cD
 LvRw==
X-Gm-Message-State: AOJu0YwtNEgRRL03i8LgeIBybEM5MWKqv4h0udEMNd9lQbhNy8T5MSO4
 fd3BLTH0Ta/sPHR5d8eby2vIJw==
X-Google-Smtp-Source: AGHT+IEBX1i7ca8qWwnyvkSoycPFaMqSs7WCP6zK5ursdqMedwq+/1TesjSofM8haHbzAndQPs6IHA==
X-Received: by 2002:a81:9a4b:0:b0:586:9d8e:8322 with SMTP id
 r72-20020a819a4b000000b005869d8e8322mr5681906ywg.2.1692285029575; 
 Thu, 17 Aug 2023 08:10:29 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-8f9f-218d-98ab-058b.res6.spectrum.com.
 [2603:6081:7b00:6400:8f9f:218d:98ab:58b])
 by smtp.gmail.com with ESMTPSA id
 f184-20020a0ddcc1000000b0057a44e20fb8sm4662816ywe.73.2023.08.17.08.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Aug 2023 08:10:29 -0700 (PDT)
Date: Thu, 17 Aug 2023 11:10:27 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Sughosh Ganu <sughosh.ganu@linaro.org>, u-boot@lists.denx.de,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Takahiro Akashi <takahiro.akashi@linaro.org>
Subject: Re: [PATCH 2/5] scripts/Makefile.lib: Embed capsule public key in
 platform's dtb
Message-ID: <20230817151027.GF1515023@bill-the-cat>
References: <20230815162623.1824357-1-sughosh.ganu@linaro.org>
 <20230815162623.1824357-3-sughosh.ganu@linaro.org>
 <CAPnjgZ0U7x1FUDNBztecDUFdYDp=3j4kkY0RdWGzPoZ-9WU-Zg@mail.gmail.com>
 <CADg8p96k4S67og6REPt5vF9TruYP+hK+1HcDU_XiauvsF4wXjg@mail.gmail.com>
 <20230816212650.GA1515023@bill-the-cat>
 <CAPnjgZ1HBD0quW+_qos5ZjhVeNtZbR9e1hXnUW+71UQGoaT1oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="sLY7AtxJaPSVQsfz"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1HBD0quW+_qos5ZjhVeNtZbR9e1hXnUW+71UQGoaT1oA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--sLY7AtxJaPSVQsfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2023 at 07:41:33AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 16 Aug 2023 at 15:26, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 16, 2023 at 09:58:42AM +0530, Sughosh Ganu wrote:
> > > hi Simon,
> > >
> > > On Wed, 16 Aug 2023 at 00:09, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > Hi Sughosh,
> > > >
> > > > On Tue, 15 Aug 2023 at 10:26, Sughosh Ganu <sughosh.ganu@linaro.org=
> wrote:
> > > > >
> > > > > The EFI capsule authentication logic in u-boot expects the public=
 key
> > > > > in the form of an EFI Signature List(ESL) to be provided as part =
of
> > > > > the platform's dtb. Currently, the embedding of the ESL file into=
 the
> > > > > dtb needs to be done manually.
> > > > >
> > > > > Add a target for generating a dtsi file which contains the signat=
ure
> > > > > node with the ESL file included as a property under the signature
> > > > > node. Include the dtsi file in the dtb. This brings the embedding=
 of
> > > > > the ESL in the dtb into the U-Boot build flow.
> > > > >
> > > > > The path to the ESL file is specified through the
> > > > > CONFIG_EFI_CAPSULE_ESL_FILE symbol.
> > > > >
> > > > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > > > ---
> > > > > Changes since RFC series:
> > > > > * Remove the default value of the config symbol.
> > > > > * s/include_files/dtsi_include_list
> > > > > * Add all the dtsi files being included as dependency for the dtb
> > > > >   target.
> > > > >
> > > > >  lib/efi_loader/Kconfig             |  8 ++++++++
> > > > >  lib/efi_loader/capsule_esl.dtsi.in | 11 +++++++++++
> > > > >  scripts/Makefile.lib               | 18 +++++++++++++++++-
> > > > >  3 files changed, 36 insertions(+), 1 deletion(-)
> > > > >  create mode 100644 lib/efi_loader/capsule_esl.dtsi.in
> > > > >
> > > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > > index 9989e3f384..d20aaab6db 100644
> > > > > --- a/lib/efi_loader/Kconfig
> > > > > +++ b/lib/efi_loader/Kconfig
> > > > > @@ -272,6 +272,14 @@ config EFI_CAPSULE_MAX
> > > > >           Select the max capsule index value used for capsule rep=
ort
> > > > >           variables. This value is used to create CapsuleMax vari=
able.
> > > > >
> > > > > +config EFI_CAPSULE_ESL_FILE
> > > > > +       string "Path to the EFI Signature List File"
> > > >
> > > > Do we need this, or could we name it as we do with the .env file? It
> > > > seems confusing to have to set this for each board - it might be
> > > > better to have it in a defined location.
> > >
> > > The reason I put this is because I thought this gave the user the
> > > flexibility to provide the location and name of the ESL. But I suppose
> > > that the board directory would be a good location to expect this file.
> > > Then this file can have a name like capsule_pub_key,esl. Tom, what are
> > > your thoughts on this?
> >
> > I feel like an automatic name we can guess isn't likely how this will be
> > used in the real world, so we should leave this as configurable.
>=20
> Are we expecting these files to end up in the source tree? Where would th=
ey go?

Yes, they should be
board/vendor/common/whatever-vendor-uses-internally.esl or so.  As I
think I mentioned on IRC, in theory someone like Asus should be using
the same file here for their rockchip-based tinker board and their x8664
based motherboards too.  And it's a public key, not a private key.  But
we still need to ask here because a vendor may care more about
"security" and so have the key /over/somewhere/else more than
reproducible builds.

--=20
Tom

--sLY7AtxJaPSVQsfz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTeOGMACgkQFHw5/5Y0
tyxONQv8CLsBrNjgwBPrrxC+WloRHb4aKdHT4iCqTyvYi3nPWRXWLmSE628NHgKr
yvNH6yaGVckSW0o7weNqBxrB5X+NDsYkehBTB2O/FJ95F8yEpM61HTtJMrZMtBEl
0MkN3avgTTeUoudYxO4zWw0tYA5tlLbAt/VoHo1lYgZajb+mewnSFFiT4P4Crumb
bIyTGGiKBlqnr45SeAcgsXfQr1ATWdfjiU08pJrEE6mL7s+qgoRH3hv0unZuxltX
PxV6MGJBf/niQjOBHW8ZysiJIyRKeQ0iKg6b60/iry5cmVEaTYHFQfNIDnDqmnSz
+qTHnwSaCgjTRwdPBr8OwGiNEk7899VeQV3SrxEdDNNVSQulpKEIi7lAAjDjGhlg
6AnBVtL33nm4Ck1HfooNL3dof6NKJuOX7IP3X17QpsDjgk6dRZXT/yLppGgeCQnJ
4OXXUDbo9UCGQhxmTtyord8JStjfnAKWf3F1YmnGGad5j1na9wzdNZL2t0XzGNrA
XVgkN/nL
=42v2
-----END PGP SIGNATURE-----

--sLY7AtxJaPSVQsfz--
