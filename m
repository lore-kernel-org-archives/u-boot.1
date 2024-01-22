Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB68C47DD3
	for <u-boot@archiver.kernel.org>; Mon, 22 Jan 2024 18:36:46 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B96008780E;
	Mon, 22 Jan 2024 19:36:44 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="pxykDjLY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58338877CC; Mon, 22 Jan 2024 19:36:43 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 56A1987A01
 for <u-boot@lists.denx.de>; Mon, 22 Jan 2024 19:36:40 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=conor@kernel.org
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 24B34CE2B0F;
 Mon, 22 Jan 2024 18:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D1DC433C7;
 Mon, 22 Jan 2024 18:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705948597;
 bh=cNt/dVyJmXgk52e8khd21S693DyZ4KMxjUVUqQu/44Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=pxykDjLYngCHhJmQsplOlCYoYVHIHBBn931ulgaJaKeQO6afz8jPUg7GQxCMhrCQ5
 Qx+gIJTYhm9YxoqP0vRX0tbwnjLnEfsyqePpzNKoj9Zc1AcinhcVNaOLNX96I3Q7pW
 NCFOnkgWhNc5cv9j8dwLmYKI2dqF13g8kI3nUADXHjDjTqY3NF4lpwMgKdFxziS3Lv
 DlKZbnCQvk+P87wSQO6ZyCprn+s8wsgwkF6BP8Qq98LsU8h5PWKjewAyq7s0bMT1Hr
 LGrggRm+DTs1gdPsJQqR91d40gnUg2+3uQXAGd5GEbkxKRomNZLceoUEgKBi533/IF
 qj/1qY001xJhQ==
Date: Mon, 22 Jan 2024 18:36:31 +0000
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 Raymond Mao <raymond.mao@linaro.org>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marex@denx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Andre Przywara <andre.przywara@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerry Van Baren <vanbaren@cideas.com>, Johan Jonker <jbx6244@gmail.com>,
 Kever Yang <kever.yang@rock-chips.com>,
 Samuel Holland <samuel@sholland.org>, Shiji Yang <yangshiji66@outlook.com>
Subject: Re: [PATCH v7] fdt: Allow the devicetree to come from a bloblist
Message-ID: <20240122-pranker-shininess-8953eb6182b4@spud>
References: <20240104014919.413568-1-sjg@chromium.org>
 <20240116-snowbound-symptom-aa07c4dcf736@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="mmPuvWJeWMIYnpTc"
Content-Disposition: inline
In-Reply-To: <20240116-snowbound-symptom-aa07c4dcf736@wendy>
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


--mmPuvWJeWMIYnpTc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Tue, Jan 16, 2024 at 01:48:06PM +0000, Conor Dooley wrote:
> Yo,
>=20
> On Wed, Jan 03, 2024 at 06:49:19PM -0700, Simon Glass wrote:
> > Standard passage provides for a bloblist to be passed from one firmware
> > phase to the next. That can be used to pass the devicetree along as wel=
l.
> > Add an option to support this.
> >=20
> > Tests for this will be added as part of the Universal Payload work.
> >=20
> > Signed-off-by: Simon Glass <sjg@chromium.org>
>=20
> Since this was merged into master, U-Boot is no longer booting on my
> icicle kit (At least that's what my bisection tells me). This is a
> RISC-V board and U-Boot for it is built from
> microchip_mpfs_icicle_defconfig.
>=20
> There's zero output on the console from U-Boot at all, the last thing
> that I see is OpenSBI before things grind to a halt.

Just wondering if there's anything I can do to help this one along?
Got a red CI complaining at me every morning about it :|

>=20
> Thanks,
> Conor.
>=20
>=20
> > ---
> > The discussion on this was not resolved and is now important due to the
> > bloblist series from Raymond. So I am sending it again since I believe
> > this is a better starting point than building on OF_BOARD
> >=20
> > Changes in v7:
> > - Drop use of OF_BLOBLIST
> >=20
> > Changes in v6:
> > - Don't allow bloblist with OF_EMBED
> >=20
> > Changes in v5:
> > - Make OF_BLOBLIST default y
> > - Make OF_BLOBLIST optional at runtime
> >=20
> > Changes in v4:
> > - Rebase to -next
> >=20
> >  doc/develop/devicetree/control.rst |  3 ++
> >  include/fdtdec.h                   |  6 ++--
> >  lib/fdtdec.c                       | 44 +++++++++++++++++++++++-------
> >  3 files changed, 41 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/doc/develop/devicetree/control.rst b/doc/develop/devicetre=
e/control.rst
> > index cbb65c9b177..11c92d440f4 100644
> > --- a/doc/develop/devicetree/control.rst
> > +++ b/doc/develop/devicetree/control.rst
> > @@ -108,6 +108,9 @@ If CONFIG_OF_BOARD is defined, a board-specific rou=
tine will provide the
> >  devicetree at runtime, for example if an earlier bootloader stage crea=
tes
> >  it and passes it to U-Boot.
> > =20
> > +If CONFIG_BLOBLIST is defined, the devicetree may come from a bloblist=
 passed
> > +from a previous stage, if present.
> > +
> >  If CONFIG_SANDBOX is defined, then it will be read from a file on
> >  startup. Use the -d flag to U-Boot to specify the file to read, -D for=
 the
> >  default and -T for the test devicetree, used to run sandbox unit tests.
> > diff --git a/include/fdtdec.h b/include/fdtdec.h
> > index bd1149f46d0..e80de24076c 100644
> > --- a/include/fdtdec.h
> > +++ b/include/fdtdec.h
> > @@ -72,7 +72,7 @@ struct bd_info;
> >   *	U-Boot is packaged as an ELF file, e.g. for debugging purposes
> >   * @FDTSRC_ENV: Provided by the fdtcontroladdr environment variable. T=
his should
> >   *	be used for debugging/development only
> > - * @FDTSRC_NONE: No devicetree at all
> > + * @FDTSRC_BLOBLIST: Provided by a bloblist from an earlier phase
> >   */
> >  enum fdt_source_t {
> >  	FDTSRC_SEPARATE,
> > @@ -80,6 +80,7 @@ enum fdt_source_t {
> >  	FDTSRC_BOARD,
> >  	FDTSRC_EMBED,
> >  	FDTSRC_ENV,
> > +	FDTSRC_BLOBLIST,
> >  };
> > =20
> >  /*
> > @@ -1190,7 +1191,8 @@ int fdtdec_resetup(int *rescan);
> >   *
> >   * The existing devicetree is available at gd->fdt_blob
> >   *
> > - * @err internal error code if we fail to setup a DTB
> > + * @err: 0 on success, -EEXIST if the devicetree is already correct, o=
r other
> > + * internal error code if we fail to setup a DTB
> >   * @returns new devicetree blob pointer
> >   */
> >  void *board_fdt_blob_setup(int *err);
> > diff --git a/lib/fdtdec.c b/lib/fdtdec.c
> > index 4016bf3c113..b2c59ab3818 100644
> > --- a/lib/fdtdec.c
> > +++ b/lib/fdtdec.c
> > @@ -7,6 +7,10 @@
> >   */
> > =20
> >  #ifndef USE_HOSTCC
> > +
> > +#define LOG_CATEGORY	LOGC_DT
> > +
> > +#include <bloblist.h>
> >  #include <boot_fit.h>
> >  #include <display_options.h>
> >  #include <dm.h>
> > @@ -86,6 +90,7 @@ static const char *const fdt_src_name[] =3D {
> >  	[FDTSRC_BOARD] =3D "board",
> >  	[FDTSRC_EMBED] =3D "embed",
> >  	[FDTSRC_ENV] =3D "env",
> > +	[FDTSRC_BLOBLIST] =3D "bloblist",
> >  };
> > =20
> >  const char *fdtdec_get_srcname(void)
> > @@ -1662,23 +1667,42 @@ static void setup_multi_dtb_fit(void)
> > =20
> >  int fdtdec_setup(void)
> >  {
> > -	int ret;
> > +	int ret =3D -ENOENT;
> > +
> > +	/* If allowing a bloblist, check that first */
> > +	if (CONFIG_IS_ENABLED(BLOBLIST)) {
> > +		ret =3D bloblist_maybe_init();
> > +		if (!ret) {
> > +			gd->fdt_blob =3D bloblist_find(BLOBLISTT_CONTROL_FDT, 0);
> > +			if (gd->fdt_blob) {
> > +				gd->fdt_src =3D FDTSRC_BLOBLIST;
> > +				log_debug("Devicetree is in bloblist at %p\n",
> > +					  gd->fdt_blob);
> > +			} else {
> > +				log_debug("No FDT found in bloblist\n");
> > +				ret =3D -ENOENT;
> > +			}
> > +		}
> > +	}
> > =20
> > -	/* The devicetree is typically appended to U-Boot */
> > -	if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> > -		gd->fdt_blob =3D fdt_find_separate();
> > -		gd->fdt_src =3D FDTSRC_SEPARATE;
> > -	} else { /* embed dtb in ELF file for testing / development */
> > -		gd->fdt_blob =3D dtb_dt_embedded();
> > -		gd->fdt_src =3D FDTSRC_EMBED;
> > +	/* Otherwise, the devicetree is typically appended to U-Boot */
> > +	if (ret) {
> > +		if (IS_ENABLED(CONFIG_OF_SEPARATE)) {
> > +			gd->fdt_blob =3D fdt_find_separate();
> > +			gd->fdt_src =3D FDTSRC_SEPARATE;
> > +		} else { /* embed dtb in ELF file for testing / development */
> > +			gd->fdt_blob =3D dtb_dt_embedded();
> > +			gd->fdt_src =3D FDTSRC_EMBED;
> > +		}
> >  	}
> > =20
> >  	/* Allow the board to override the fdt address. */
> >  	if (IS_ENABLED(CONFIG_OF_BOARD)) {
> >  		gd->fdt_blob =3D board_fdt_blob_setup(&ret);
> > -		if (ret)
> > +		if (!ret)
> > +			gd->fdt_src =3D FDTSRC_BOARD;
> > +		else if (ret !=3D -EEXIST)
> >  			return ret;
> > -		gd->fdt_src =3D FDTSRC_BOARD;
> >  	}
> > =20
> >  	/* Allow the early environment to override the fdt address */
> > --=20
> > 2.34.1
> >=20



--mmPuvWJeWMIYnpTc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZa61rwAKCRB4tDGHoIJi
0rInAQCXHb0JhVGNUtzV8hUME/4kFl/A/3RuBMDeQ5RIcxj7cgD+PQp/Y70wur2K
lnxhe8tkdu9YYWNvfBpfjZY9F2X8Qgg=
=i+OB
-----END PGP SIGNATURE-----

--mmPuvWJeWMIYnpTc--
