Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D16C46CD4
	for <u-boot@archiver.kernel.org>; Tue, 26 Dec 2023 14:26:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7BCCA8793A;
	Tue, 26 Dec 2023 15:26:43 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Rxq+xt+8";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CCBDD8793A; Tue, 26 Dec 2023 15:26:41 +0100 (CET)
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com
 [IPv6:2607:f8b0:4864:20::1133])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A2F338789B
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 15:26:39 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-5e7bb1e0db8so34648157b3.0
 for <u-boot@lists.denx.de>; Tue, 26 Dec 2023 06:26:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703600798; x=1704205598; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9zIrzMnaxkKNnnKEExZaqWaA49v91vvRmCEBbSgeMJM=;
 b=Rxq+xt+8odV6kunCHiVLcs/4AYGc71RbNTs/6u2q0g4+fA4jaSxOutRAeubrJYd/Mv
 Zw9+O5NNA92segKeC65Vz+y+Y02/JK4NLnRPWTDXssm1Nuyqo2TvTyFes1GvAvs3nHZG
 V0uy0fbkxhw7hQXm3DVkFTE2WTtHN+3Kdl16I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703600798; x=1704205598;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9zIrzMnaxkKNnnKEExZaqWaA49v91vvRmCEBbSgeMJM=;
 b=nanIK99wuf6l8H5PG3AaKhGknutB3jfG8SWVpN04EH11PNlAYGb5bmz9vsbnuBNT36
 S+EdjjnuRnK6VA49LICyB/S/eCP7kEj4qfAIfVqyeCT9TC2b1ImqUO6sd4y8qVTPcBDs
 gtxkmcshBsYpn7ZlDbdlCOMBe7nWJAu+5t87HKaLOUB/ljyjvxCXP82z7d53kWbVT3R5
 oMSzqWqQiNMA0oG2tcVHfMOxtA+D/zwc6PvhkslGilWfI6DZQUo4GXTZgdvvw7astPVr
 BoV/wqI+uI1fCu4fdbJ7LCP1lZLgS2SzNqhw9Ahd5PI1IFWvlUsjXgp95C8IGpjCfk/h
 jc/Q==
X-Gm-Message-State: AOJu0YyM1tX2Kz55EzA8M19G4h/fDSgR2x2URIgVJUw8D8/o7ybLT71c
 QuBV9SoDtFNil5/BzcyrqeLyCJtK7cG0Ww==
X-Google-Smtp-Source: AGHT+IHydv0xE9HAWcsIe7y2/5n9t/o7aZ4SVlun7RkD3WqE7kkt0zVC29tntqH3Gfnkw5ZUYEFHdQ==
X-Received: by 2002:a81:48c5:0:b0:5e9:41af:10ce with SMTP id
 v188-20020a8148c5000000b005e941af10cemr4335017ywa.91.1703600798277; 
 Tue, 26 Dec 2023 06:26:38 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-3119-0000-0000-0000-1001.res6.spectrum.com.
 [2603:6081:7b00:3119::1001]) by smtp.gmail.com with ESMTPSA id
 a187-20020a818ac4000000b005e4a023fcf3sm5460600ywg.92.2023.12.26.06.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 06:26:37 -0800 (PST)
Date: Tue, 26 Dec 2023 09:26:35 -0500
From: Tom Rini <trini@konsulko.com>
To: Maxim Uvarov <maxim.uvarov@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 simon.k.r.goldschmidt@gmail.com, tien.fong.chee@intel.com,
 joe.hershberger@ni.com, rfried.dev@gmail.com,
 bharat.gooty@broadcom.com, rayagonda.kokatanur@broadcom.com
Subject: Re: [PATHv2 9/9] Makefile: add dtbs to clean
Message-ID: <20231226142635.GI2652760@bill-the-cat>
References: <20231225153929.8284-1-maxim.uvarov@linaro.org>
 <20231225153929.8284-10-maxim.uvarov@linaro.org>
 <CAFLszTjg2MTAfJZ17dQFe+Of0VTJVADemigh_gki8GSR07FEvQ@mail.gmail.com>
 <CAD8XO3bF3Xr=YTfB7Yjb7RydRkGdGXaV-k0Ep9OsxR=2SJnyvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cCr1bifFIuWoW4iv"
Content-Disposition: inline
In-Reply-To: <CAD8XO3bF3Xr=YTfB7Yjb7RydRkGdGXaV-k0Ep9OsxR=2SJnyvw@mail.gmail.com>
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


--cCr1bifFIuWoW4iv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2023 at 06:27:58PM +0600, Maxim Uvarov wrote:
> On Tue, 26 Dec 2023 at 15:50, Simon Glass <sjg@chromium.org> wrote:
>=20
> > Hi Maxim,
> >
> > On Mon, Dec 25, 2023 at 3:42=E2=80=AFPM Maxim Uvarov <maxim.uvarov@lina=
ro.org>
> > wrote:
> > >
> > > CI test checks that generated dtb has to be cleaned up.
> > >
> > > Signed-off-by: Maxim Uvarov <maxim.uvarov@linaro.org>
> > > ---
> > >  Makefile | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Makefile b/Makefile
> > > index 220411a293..ab603191ad 100644
> > > --- a/Makefile
> > > +++ b/Makefile
> > > @@ -2165,7 +2165,8 @@ CLEAN_FILES +=3D include/autoconf.mk*
> > include/bmp_logo.h include/bmp_logo_data.h \
> > >                mkimage-out.spl.mkimage mkimage.spl.mkimage imx-boot.m=
ap \
> > >                itb.fit.fit itb.fit.itb itb.map spl.map
> > mkimage-out.rom.mkimage \
> > >                mkimage.rom.mkimage mkimage-in-simple-bin* rom.map
> > simple-bin* \
> > > -              idbloader-spi.img lib/efi_loader/helloworld_efi.S *.itb
> > > +              idbloader-spi.img lib/efi_loader/helloworld_efi.S *.it=
b \
> > > +              ./*/*.dtb *.dtb
> > >
> > >  # Directories & files removed with 'make mrproper'
> > >  MRPROPER_DIRS  +=3D include/config include/generated spl tpl vpl \
> > > --
> > > 2.30.2
> > >
> >
> > Shouldn't this be handled with CLEAN_FILES in arch/xxx/dts ?
> >
> > Regards,
> > Simon
> >
>=20
> I don't know. It looks like CLEAN_FILES is almost not used inside ./arch
> directory. Only 1 place where it appears:
>=20
> fgrep -r CLEAN_FILES ./arch/
> ./arch/arm/mach-rmobile/Makefile:CLEAN_FILES +=3D u-boot-spl.scif

I see that our top-level clean target is missing dtb related targets
like the linux kernel has, and that's how this should be fixed.

--=20
Tom

--cCr1bifFIuWoW4iv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWK4pEACgkQFHw5/5Y0
tyxCugwAjfYhq+RE3Wl2WFULfg4DMmmKdFrjWkgzvRlX5AsbPoU3RUI/NAEDSMdc
Fmh2SwffMZphgWqqMgZZhXE9LTxtcvSMfKyX2UWtMx6J/NZ/yGt3Qks+Y03Hy1rt
3Ue3DhqZjJ6IzV8o6OwJhm2Gl2MeMqelrt7A8fVBJZXp+M8uPGNG71t/apEomW7d
4u8N4y+4EfJCvJKlVQQ3pfHNolFu5zQt6eMKY27wMP9QsZzo/aL3PCEMt53oXxhP
sviv9YbpqdwbXUBQq+EeSm7CvOlw0M2NjtAcrVDLvwdjgZ/r1ibsRLcpk/ng4t2U
F3DljMO5cCV/FdUYCAFqnTI8S9meQNBZnHMAwHXtme0syzr6Lpkmyml2JeV4qU2N
+RlzVMbPa7J5sjzdGrM9Qs6GhZF50uZy4r3zet7gNvIiUJ15zHPeYwOwzgd6m0J9
XGcYysup04AADdnq5iZgHIMFMjYKJ/ongqNfTxDvxBuzl+YLe2gBQJMb3jzYEesr
VBPSUt4I
=awKs
-----END PGP SIGNATURE-----

--cCr1bifFIuWoW4iv--
