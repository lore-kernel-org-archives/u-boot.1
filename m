Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A3BCDB482
	for <u-boot@archiver.kernel.org>; Thu, 19 Oct 2023 13:40:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A76D786940;
	Thu, 19 Oct 2023 15:39:58 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ZfvnxkSk";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 662BA86940; Thu, 19 Oct 2023 15:39:57 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BA0A80844
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 15:39:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-5a7dafb659cso97814267b3.0
 for <u-boot@lists.denx.de>; Thu, 19 Oct 2023 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1697722792; x=1698327592; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=YHtKD/iBGg3xPr0U9F16h/GzbBbGm/kKl9Lfl5M5mG0=;
 b=ZfvnxkSk9AoZmRE0I6OfsAX9ZVOoqCLcE0HUkNlqz6GVD5Cx+4hXi04+NuSeet05nz
 up31AJp7sHqQCZUBiUUQ4SH2UR7gJPLds15VBnvqeXiP1l5Nz6Nhzy3FmWLxGoIlhXpD
 j+rcU2E8FPgbQCGc7mRw4doL7h1wRg+z9qzdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697722792; x=1698327592;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YHtKD/iBGg3xPr0U9F16h/GzbBbGm/kKl9Lfl5M5mG0=;
 b=s7kBjN4IN0zDU5+ddc6jsSXvF6uOttpF93Cmkr5iTPuAzEXQGjgyV+tjkPu/bFfigx
 KrXVV22BjV8CRsssuavmUsU9UCOUqKePW7q6zMxaCHtfqPZz0Gub2oJZH+zVVyRqt50e
 kmcTBcmCkSmPBS2pn63sLQxRb+vSOvGBiPI38nvmOLlvXKsXavFMQKVxJGA8YdkcMI3p
 Bf5QBbEXVgo/sro5uqQ9ohaiyTkWABJGAbbVPtuX7sp+d9kiFzmF3LltdtCvSWH7MHu8
 XimZBGGYtbVJwrOQ8qT2EzgbeJ3xKKXOggT5f0uVHJQdvs/DlmPx1EiP+LTNSZK/WCn9
 oeVQ==
X-Gm-Message-State: AOJu0YxdPgmIZu11/YuGzNE9sj3hLDePLukROHTcI1W4Q13dGQLCF6Wl
 fNXt3Z7QqJEr4FBbO5kU7qoQQw==
X-Google-Smtp-Source: AGHT+IE6nTYijwWUBEgh4bGt50wFmFbZP79X4ZngZb44sXqNLlYkWHTw//Jy4pBtZKiudIceNgtYWw==
X-Received: by 2002:a0d:d412:0:b0:5a7:ba54:aef5 with SMTP id
 w18-20020a0dd412000000b005a7ba54aef5mr2102886ywd.21.1697722792648; 
 Thu, 19 Oct 2023 06:39:52 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-0f48.res6.spectrum.com.
 [2603:6081:7b00:6400::f48]) by smtp.gmail.com with ESMTPSA id
 u81-20020a816054000000b005a247c18403sm2458795ywb.37.2023.10.19.06.39.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 06:39:51 -0700 (PDT)
Date: Thu, 19 Oct 2023 09:39:49 -0400
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v3 22/32] efi: Update EFI_LOADER to depend on DM_ETH
Message-ID: <20231019133949.GW3119521@bill-the-cat>
References: <20231016222835.596572-1-sjg@chromium.org>
 <20231016222835.596572-23-sjg@chromium.org>
 <20231018133709.GA3765642@bill-the-cat>
 <CAPnjgZ2qG7XgcbYyrpZaTef21MJA-B7SMm9jGMzk8G7M=mVv1w@mail.gmail.com>
 <CALeDE9MbMTCY-6eBeZ=a0es5MEDycAFWT710O81C_WYheBEVSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="5ABZe7yaK0fOPIEG"
Content-Disposition: inline
In-Reply-To: <CALeDE9MbMTCY-6eBeZ=a0es5MEDycAFWT710O81C_WYheBEVSQ@mail.gmail.com>
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


--5ABZe7yaK0fOPIEG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 19, 2023 at 11:39:49AM +0100, Peter Robinson wrote:
> On Wed, Oct 18, 2023 at 4:29=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tom,
> >
> > On Wed, 18 Oct 2023 at 07:37, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Mon, Oct 16, 2023 at 04:28:13PM -0600, Simon Glass wrote:
> > >
> > > > Since efi_device_path.c calls eth_get_dev() and assumes that Ethern=
et is
> > > > available, add it as an explicit dependency.
> > > >
> > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > ---
> > > >
> > > > (no changes since v2)
> > > >
> > > > Changes in v2:
> > > > - Add new patch to update EFI_LOADER to depend on DM_ETH
> > > >
> > > >  lib/efi_loader/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/lib/efi_loader/Kconfig b/lib/efi_loader/Kconfig
> > > > index 13cad6342c36..fca4b3eef270 100644
> > > > --- a/lib/efi_loader/Kconfig
> > > > +++ b/lib/efi_loader/Kconfig
> > > > @@ -11,6 +11,7 @@ config EFI_LOADER
> > > >       # We need EFI_STUB_32BIT to be set on x86_32 with EFI_STUB
> > > >       depends on !EFI_STUB || !X86 || X86_64 || EFI_STUB_32BIT
> > > >       depends on BLK
> > > > +     depends on DM_ETH
> > > >       depends on !EFI_APP
> > > >       default y if !ARM || SYS_CPU =3D armv7 || SYS_CPU =3D armv8
> > > >       select CHARSET
> > >
> > > I don't think this is needed.  After reconfiguring qemu_arm64 to be a=
ble
> > > to disable networking entirely, we still are able to build with
> > > EFI_LOADER enabled, and no warning / link errors.
> >
> > Fair enough.
> >
> > As of this patch the following errors are generated with -a ~CMDLINE :
> >
> > +lib/efi_loader/efi_device_path.c:985:(.text+0xca4): undefined
> > reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.c:987:(.text+0xca9):
> > undefined reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.c:993:(.text+0xcc9):
> > undefined reference to `eth_get_dev'
> > +/bin/ld: lib/efi_loader/efi_device_path.o: in function `efi_dp_from_na=
me':
> > +lib/efi_loader/efi_device_path.c:1095:(.text+0xe00): undefined
> > reference to `efi_get_image_parameters'
> >
> > which is why I added this patch. A later patch disables networking
> > entirely with ~CMDLINE so that is why this problem goes away.
> >
> > This series was basically built up by disabling CMDLINE and then
> > fixing the errors one by one. I didn't go back and check whether (at
> > the end) all the patches were needed.
>=20
> Was this just tested on sandbox? How do we know it's not going to
> regress a vast amount of actual devices?

It both shouldn't (DM_ETH is required), and this patch isn't moving
forward either.

--=20
Tom

--5ABZe7yaK0fOPIEG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUxMaAACgkQFHw5/5Y0
tyw9YQv/auGA2go2TL5k1gAIqR279QZaDjQuwtIYuzuv07WpaKEP7xzop7gp5bBB
D3BbbmtzYy3UBLB71+W1q04FBg8dXHBJ+O4S6+r2HV5TsWiaJZhWENIkf0JwRvvg
8wgQ7y3+aUodwVGhiC7GgwmnVZxiz0/eUog3AovOxCfaWVSKEsXLuiyzCKcMCIJw
6OCX4HORfrkLE46jj3shkf4APXbbn9h893gw2hbV+gwB570G7SrmM+Fg5ImIQt2W
6oSKEFggbsP0hNDKjdhKTaSnLRvgEj6NympFGP7ObSwq8u3s4O2b/foZGFpJsz7c
FX8XoL0/VuIT02gJWJ8kje5SZxGQdpdcpNrEZY0ZgdP7dF0xyz7sVbdFTcxvbksF
BfmYQPcnMkBDhmTpJ/xfa10neCG7sy71e3YIaCiZY2WSi1k6SNVnG8kUdsJa/Fw6
WE0i5CyHuaavmSMXkWgH9X2WmzHUmkp1PCEtTQ5AouxeLlVLccuvN03YPJYvakFu
FUDwaWtg
=ZnV7
-----END PGP SIGNATURE-----

--5ABZe7yaK0fOPIEG--
