Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 379B5C3DA6E
	for <u-boot@archiver.kernel.org>; Wed, 20 Dec 2023 13:29:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B87F38772A;
	Wed, 20 Dec 2023 14:29:17 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EmNNqqwS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 08F3387716; Wed, 20 Dec 2023 14:29:17 +0100 (CET)
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com
 [IPv6:2607:f8b0:4864:20::1129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A9B2C877EC
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 14:29:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-5e637faa52fso28696067b3.1
 for <u-boot@lists.denx.de>; Wed, 20 Dec 2023 05:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1703078951; x=1703683751; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jdgBG+r/j6b59w65SjtBlhXZEMjPAa9m3KTDlVkKr1s=;
 b=EmNNqqwSuo2y8J894aRmT7ajxiVprIdZ+QhhBhtdc0i/NmKphet5MEI741dkf88rD2
 JLXToxQrL0cWq250TG/4ce7DlBgBdQEZ3U4NpS6Z6O8ah83HzShm3V9KTQ1m3Ck7deb8
 s0a2JUrNgaNQYi/ZFtSa6mdK6VLM5OIcEwl/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703078951; x=1703683751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jdgBG+r/j6b59w65SjtBlhXZEMjPAa9m3KTDlVkKr1s=;
 b=liuRNu6KpA0P8ob7X+YrZ1dxenHh88HZEJ12DWYVvaDlh8RuRy3eCLuj2GTdt69NB9
 rrGqAwi3FOc7UEm0bH2mwx/WPWYlLGWTg0c1dJcZcj+wu1RzFpJKJZ6X6SW5jq22bAMs
 mUCtoW/eDddFOYxPD7ALRxbQwNUgX10FnZUB0rtSHeLM9l6u7NqibZ0WOatmTra4uk3G
 kKZtyPCXL0xTvVn+m4ffombta4IN9XRf8z9O1nbyHfVBv3mJ9GRoi1QI26ToMhP6Ag3a
 XE6uJ+hB7msaQ3rGpVfqAYPrB8Omu7+kgTOy1CS8DvkWhN/W68/AaoTIaoMfoeD8agsP
 8iGA==
X-Gm-Message-State: AOJu0Yw8shRWLvquFGiA2vXh0u0qsUrvqnSSz169xb3rzxteiOYzzyLM
 yNnkyMVEfh9F8UrNr7mWnfe9bA==
X-Google-Smtp-Source: AGHT+IHKZ8nQQlfe4zU5OdrdmifkaaRKBpcwZ1TZrUEFHlJGxvVBMz/1LznueXeWJ/BxNI5Uw7+dhQ==
X-Received: by 2002:a25:1f46:0:b0:dbc:cb56:8a30 with SMTP id
 f67-20020a251f46000000b00dbccb568a30mr6943196ybf.118.1703078946541; 
 Wed, 20 Dec 2023 05:29:06 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-ae12-866a-2c78-8ee6.res6.spectrum.com.
 [2603:6081:7b00:6400:ae12:866a:2c78:8ee6])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a255f03000000b00d9cceda7947sm9294171ybb.3.2023.12.20.05.29.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Dec 2023 05:29:06 -0800 (PST)
Date: Wed, 20 Dec 2023 08:29:03 -0500
From: Tom Rini <trini@konsulko.com>
To: Sumit Garg <sumit.garg@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de,
 u-boot-amlogic@groups.io, u-boot-custodians@lists.denx.de,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor@kernel.org, neil.armstrong@linaro.org,
 caleb.connolly@linaro.org, ff@shokubai.tech,
 daniel.thompson@linaro.org, dgilmore@fedoraproject.org,
 pbrobinson@gmail.com, ilias.apalodimas@linaro.org,
 maxim.uvarov@linaro.org, b.galvani@gmail.com, xypron.glpk@gmx.de,
 michal.simek@amd.com, seanga2@gmail.com, rasmus.villemoes@prevas.dk,
 peng.fan@nxp.com, jh80.chung@samsung.com, rfried.dev@gmail.com,
 marex@denx.de
Subject: Re: [PATCH 3/8] scripts/Makefile.lib: Statically define
 *-u-boot.dtsi files location
Message-ID: <20231220132903.GL2513409@bill-the-cat>
References: <20231214135103.1606605-1-sumit.garg@linaro.org>
 <20231214135103.1606605-4-sumit.garg@linaro.org>
 <CAPnjgZ0h5u8TS=SwAkSgAmbmJiTFriqY8Le++pfS=Yp7R+yabQ@mail.gmail.com>
 <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/AJ7ldBi7tCTiTO/"
Content-Disposition: inline
In-Reply-To: <CAFA6WYOYV=Aob+x10XfpagiDoDC1AhiwvT=mc3cQfr4VGj1kxQ@mail.gmail.com>
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


--/AJ7ldBi7tCTiTO/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 05:00:20PM +0530, Sumit Garg wrote:
> On Wed, 20 Dec 2023 at 10:17, Simon Glass <sjg@chromium.org> wrote:
> >
> > Hi Sumit,
> >
> > On Thu, 14 Dec 2023 at 06:52, Sumit Garg <sumit.garg@linaro.org> wrote:
> > >
> > > Allow u-boot to build DTB from a different directory tree such that
> > > *-u-boot.dtsi files can be included from a common location. Currently
> > > that location is arch/$(ARCH)/dts/, so statically define that common
> > > location.
> > >
> > > This is needed for platform owners to start building DTB files from
> > > devicetree-rebasing directory but still being able to include
> > > *-u-boot.dtsi files.
> > >
> > > Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> > > ---
> > >  scripts/Makefile.lib | 25 ++++++++++++++-----------
> > >  1 file changed, 14 insertions(+), 11 deletions(-)
> > >
> > > diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> > > index 27b9437027c..4a002b0e0ca 100644
> > > --- a/scripts/Makefile.lib
> > > +++ b/scripts/Makefile.lib
> > > @@ -159,18 +159,20 @@ cpp_flags      =3D -Wp,-MD,$(depfile) $(NOSTDIN=
C_FLAGS) $(UBOOTINCLUDE)     \
> > >  ld_flags       =3D $(KBUILD_LDFLAGS) $(ldflags-y) $(LDFLAGS_$(@F))
> > >
> > >  # Try these files in order to find the U-Boot-specific .dtsi include=
 file
> > > -u_boot_dtsi_options =3D $(strip $(wildcard $(dir $<)$(basename $(not=
dir $<))-u-boot.dtsi) \
> > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_SOC))-u-boot.dt=
si) \
> > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_CPU))-u-boot.dt=
si) \
> > > -       $(wildcard $(dir $<)$(subst $\",,$(CONFIG_SYS_VENDOR))-u-boot=
=2Edtsi) \
> > > -       $(wildcard $(dir $<)u-boot.dtsi))
> > > +UBOOT_DTSI_LOC =3D $(srctree)/arch/$(ARCH)/dts/
> >
> > How about lower case since it is internal. Also we know it is U-Boot,
> > so perhap  ?
>=20
> Although I just named it after *-u-boot.dtsi, I am fine with dtsi_loc
> too. So I will use that instead.

I was going to say lets use "uboot_dtsi_loc" so it's both clear what the
variable does and for future re-syncs.

--=20
Tom

--/AJ7ldBi7tCTiTO/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmWC7B8ACgkQFHw5/5Y0
tywDywv8CJDdrJonbBm62QXBvDGKLJew43seqeK4KdG4b6J7PkM0sjDSlhgbiYRb
D4VckoPsGj0p58nn1cemWiJ8PLGzT+JNLqnoW/L6vYQd7spuna4179NMa8nVQy2K
WAVAbE/KOFnJMSGpv1bSX6zZea52bDeQXZ3uD4VzBozKCGKLJrBNO19CHXWPNeBn
MjrO6LOkAAp/eGmoI2Zg+QImvmFQwXzyN6VFYxLPO2yX8V2VzJS7nQw9G3Bvh0Ds
xe52b4ssbrHVCledAfZE+bjYdiORzWF2QSc3qNnV+LllJ/NVhDPaHKw3J8eOftSd
mBDwBxS7U72kwY0sT0y2qnNHnydgQeLUk8/eygEbQyng083mPxOT6V2Mn9DNQGBG
2hEBk0ga9iPArUr1xeNUKLGbXgd3tqYXw0ys+2Vqb7XDu4ZteiY2gSv+KIDW64Po
lxNv4DgdeotNGNoetaDjDoNv/sRPnyRcpIMHd/OA80YQOddvOQ1LkKW62VHzfyGU
A7lmHIG+
=Py2d
-----END PGP SIGNATURE-----

--/AJ7ldBi7tCTiTO/--
