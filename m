Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA5C1C25B6B
	for <u-boot@archiver.kernel.org>; Fri, 27 Oct 2023 01:00:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 155CC87622;
	Fri, 27 Oct 2023 03:00:12 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DtgBD+vU";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48FD58761C; Fri, 27 Oct 2023 03:00:10 +0200 (CEST)
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com
 [IPv6:2607:f8b0:4864:20::f36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 66F9B87B78
 for <u-boot@lists.denx.de>; Fri, 27 Oct 2023 03:00:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf36.google.com with SMTP id
 6a1803df08f44-66d2f3bb312so10304556d6.0
 for <u-boot@lists.denx.de>; Thu, 26 Oct 2023 18:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698368404; x=1698973204; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JP1wtP9d16kEFsuyIkx1JJsW8cPE1/uq6c6xhsqGjwA=;
 b=DtgBD+vUakMeenLVARlFqNImAImlvTI+z5g12FZqWH5RlBRP9efNGJkkE+PzOGYl9u
 FjLXhdg/G79zqqb5ETwb6Beu/n+dYvLl6B+P8yGzILQhIAqF6nUroV3cDOxrUqGI6IQl
 fvdCox8lDKY1/FKwYM0jEE5k9k6KLnU0qnITQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698368404; x=1698973204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JP1wtP9d16kEFsuyIkx1JJsW8cPE1/uq6c6xhsqGjwA=;
 b=Jv9LZ/93SsD2cHbIuhwoTt8vZusV+d7gLdU5N3iWA6BC0ktkI3f4sYf3x59O8/dZX0
 yOI9IHbRfOnuhz2QgYFNmt85qGNTDe5s7Y+PJZdYe9YOMwMIPWLp1ZCWPY50M+fZj3nX
 bFmtgt1t4JmTSuYePc7VFrs4hwmyct+qwoY/+HX45keSRJZ1vwfoAEe3yefTfhKBL1bk
 L8XwXQYmQoKF9jfGDkpDWhDDVvAU3ig/ZrUV5K57R5buxuCDmdhJHg8jkw1MxwtWxfZ/
 qRMDjx3gYjD/bJNT3KSF83p8/FP7z7nBCny5S73rcYJTNleLi4NMvakYTvw9eNh7D6Wg
 1VOA==
X-Gm-Message-State: AOJu0YxUNQi+hmnVTa33TTAcNCOLB8evwrU+ltYPRGXmiu7Hm6GCRACI
 r5A8zeTbiuoxnMhe5nG12ooXqQ==
X-Google-Smtp-Source: AGHT+IHQl0sVn8zt+sHFprgXZuIVtq5YHNVGAm6n3R5fBez8IG7M1+jYYxyQ6YUl2X2CVTUwJPDQXg==
X-Received: by 2002:a0c:e3d2:0:b0:66d:3165:f979 with SMTP id
 e18-20020a0ce3d2000000b0066d3165f979mr1285564qvl.19.1698368404136; 
 Thu, 26 Oct 2023 18:00:04 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-6a0e-a72f-3fdd-31b7.res6.spectrum.com.
 [2603:6081:7b00:6400:6a0e:a72f:3fdd:31b7])
 by smtp.gmail.com with ESMTPSA id
 r7-20020a0cf807000000b00655d6d31470sm219506qvn.43.2023.10.26.18.00.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 18:00:03 -0700 (PDT)
Date: Thu, 26 Oct 2023 21:00:01 -0400
From: Tom Rini <trini@konsulko.com>
To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, jbx6244@gmail.com,
 u-boot@lists.denx.de, sjg@chromium.org, ilias.apalodimas@linaro.org
Subject: Re: [RFC 01/13] cmd: bootefi: unfold do_bootefi_image()
Message-ID: <20231027010001.GR496310@bill-the-cat>
References: <20231026053052.622453-1-takahiro.akashi@linaro.org>
 <20231026053052.622453-2-takahiro.akashi@linaro.org>
 <b6110e38-5a44-4fcf-8ae1-ad77f1b66390@gmx.de>
 <ZTsDiJUA9esxg9nb@octopus>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EI6mRvO+iQWCpHZN"
Content-Disposition: inline
In-Reply-To: <ZTsDiJUA9esxg9nb@octopus>
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


--EI6mRvO+iQWCpHZN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 09:25:44AM +0900, AKASHI Takahiro wrote:
> On Thu, Oct 26, 2023 at 01:01:52PM +0200, Heinrich Schuchardt wrote:
> > On 10/26/23 07:30, AKASHI Takahiro wrote:
> > > Unfold do_bootefi_image() into do_bootefi() for the sake of the succe=
eding
> > > refactor work.
> > >=20
> > > Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
> > > ---
> > >   cmd/bootefi.c | 101 ++++++++++++++++++-----------------------------=
---
> > >   1 file changed, 37 insertions(+), 64 deletions(-)
> > >=20
> > > diff --git a/cmd/bootefi.c b/cmd/bootefi.c
> > > index 20e5c94a33a4..1b28bf5a318d 100644
> > > --- a/cmd/bootefi.c
> > > +++ b/cmd/bootefi.c
> > > @@ -425,58 +425,6 @@ static int do_efibootmgr(void)
> > >   	return CMD_RET_SUCCESS;
> > >   }
> > >=20
> > > -/**
> > > - * do_bootefi_image() - execute EFI binary
> > > - *
> > > - * Set up memory image for the binary to be loaded, prepare device p=
ath, and
> > > - * then call do_bootefi_exec() to execute it.
> > > - *
> > > - * @image_opt:	string with image start address
> > > - * @size_opt:	string with image size or NULL
> > > - * Return:	status code
> > > - */
> > > -static int do_bootefi_image(const char *image_opt, const char *size_=
opt)
> > > -{
> > > -	void *image_buf;
> > > -	unsigned long addr, size;
> > > -	efi_status_t ret;
> > > -
> > > -#ifdef CONFIG_CMD_BOOTEFI_HELLO
> > > -	if (!strcmp(image_opt, "hello")) {
> > > -		image_buf =3D __efi_helloworld_begin;
> > > -		size =3D __efi_helloworld_end - __efi_helloworld_begin;
> > > -		efi_clear_bootdev();
> > > -	} else
> > > -#endif
> > > -	{
> > > -		addr =3D strtoul(image_opt, NULL, 16);
> > > -		/* Check that a numeric value was passed */
> > > -		if (!addr)
> > > -			return CMD_RET_USAGE;
> > > -		image_buf =3D map_sysmem(addr, 0);
> > > -
> > > -		if (size_opt) {
> > > -			size =3D strtoul(size_opt, NULL, 16);
> > > -			if (!size)
> > > -				return CMD_RET_USAGE;
> > > -			efi_clear_bootdev();
> > > -		} else {
> > > -			if (image_buf !=3D image_addr) {
> > > -				log_err("No UEFI binary known at %s\n",
> > > -					image_opt);
> > > -				return CMD_RET_FAILURE;
> > > -			}
> > > -			size =3D image_size;
> > > -		}
> > > -	}
> > > -	ret =3D efi_run_image(image_buf, size);
> > > -
> > > -	if (ret !=3D EFI_SUCCESS)
> > > -		return CMD_RET_FAILURE;
> > > -
> > > -	return CMD_RET_SUCCESS;
> > > -}
> > > -
> > >   /**
> > >    * efi_run_image() - run loaded UEFI image
> > >    *
> > > @@ -648,8 +596,9 @@ static int do_bootefi(struct cmd_tbl *cmdtp, int =
flag, int argc,
> > >   		      char *const argv[])
> > >   {
> > >   	efi_status_t ret;
> > > -	char *img_addr, *img_size, *str_copy, *pos;
> > > -	void *fdt;
> > > +	char *p;
> > > +	void *fdt, *image_buf;
> > > +	unsigned long addr, size;
> > >=20
> > >   	if (argc < 2)
> > >   		return CMD_RET_USAGE;
> > > @@ -684,18 +633,42 @@ static int do_bootefi(struct cmd_tbl *cmdtp, in=
t flag, int argc,
> > >   	if (!strcmp(argv[1], "selftest"))
> > >   		return do_efi_selftest();
> > >   #endif
> > > -	str_copy =3D strdup(argv[1]);
> > > -	if (!str_copy) {
> > > -		log_err("Out of memory\n");
> > > -		return CMD_RET_FAILURE;
> > > +
> > > +#ifdef CONFIG_CMD_BOOTEFI_HELLO
> >=20
> > I would prefer a normal if and let the linker sort it out.
>=20
> Here I focused on simply unfolding("moving") the function, keeping the co=
de
> as same as possible. Any how the code is in a tentative form=20
> at this point and will be reshaped in later patches, using IS_ENABLED().
> Please look at the final code after applying the whole series.

I also agree with this approach.

--=20
Tom

--EI6mRvO+iQWCpHZN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmU7C5EACgkQFHw5/5Y0
tyzMDgv+JLut0o2iVGQdViYWPp6gu4bQdAg1oiptpLDKHlxrtHGSke9ZGktd8o1P
/xdTgiZqlW0rb+cZ5J3+mm0AKviN5wzDuRpI3k11M1keR5bMNQGNvABL/xk8zMP4
HhfFwyQN7ZWlW4CStQcgJecDG+2+8IyZ/ApJ+mXQe6NTknQrP+iZlbMqMImZLNsX
4gnyrSUYyVJUGW3bkNfYLvdLhJr5FgSGSwFifW17K8xvkY+A2Uaj4VKTulhsNHSa
Ji/dvfhQVUYR3VfiZ/rUFraOS22ipapD+M886cD81NpUoLgPWHFjXaYCx4mt3IOE
wcEBgn09pxVpm20MYpqcNwFQl2gCZg4z6Bd3+Yt+RvRgipyl1nX2WLcBrNLpPMaf
lUUm8Qetx49LF1SWAQxB4CtxzXpVxCzfEVbtd4gUE8SNF9+WJmcn9FrW5xz1MWig
X7+B6/JtJOCEqVRQcjRXVx67CvfA/7UC3rIEV1nykj1gX0YPxPDs37cn1Zzl1VR0
8RXQt6z+
=NEGD
-----END PGP SIGNATURE-----

--EI6mRvO+iQWCpHZN--
