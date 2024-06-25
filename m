Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF668C2BBCA
	for <u-boot@archiver.kernel.org>; Tue, 25 Jun 2024 14:14:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8006C884B0;
	Tue, 25 Jun 2024 16:14:33 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="POi22sZO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0E4AD884B0; Tue, 25 Jun 2024 16:14:33 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB7A088356
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 16:14:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5bfb24e338bso2203491eaf.0
 for <u-boot@lists.denx.de>; Tue, 25 Jun 2024 07:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719324869; x=1719929669; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=E8+FKkukESUDVjYiCKivz4aIF469YwDnbIuMHVdq+d8=;
 b=POi22sZO0EnHXXFb5Q0SwmZY+fbmo6we182tdiHpC5lRfVr5R8OMAZzeiEM/QMrpW6
 uLEghCXucIne3KBLxkhTByLCzaOZ1ChYvRFRVItKYv9Mzz0K2D/lKBCdb00RAFl+MDnp
 AcNWp5Op6MvbilGl9xsaFoGETi9OloQz35DLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719324869; x=1719929669;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E8+FKkukESUDVjYiCKivz4aIF469YwDnbIuMHVdq+d8=;
 b=eWr9pTRzw4x0nNJPXr5qMfgRcS82AoN1gUEEBGGrxpQyD977HbYoNOtE6bV7yn6ss6
 BjIq9OSLFdaRjeGePNzX+EpozKoxcGXn10Y8D/gpAeCBP3EPcXzagC1Qie2dZxKZ5MPq
 pChMbC/FoKmW7WKcX/Ctkerq8e6DEsekyw60BThIF/RW4G4aaSCv5MUzJyiP6xzyRFmX
 AreOP5eW3NoeMM56zZRTdHX4ic0ro9LYwD1k95zKD37KWxnYG2wdI9L4XnYFtYSjGBxN
 kX/HakcT5yM2Z2ILnvOgQ9g0ls1rpr+vhjyY2RlkMtmxdP1eYqCU5HD0wDA2GaV4ARzV
 gArw==
X-Gm-Message-State: AOJu0YxC/s0QgSlP0sMOR9wuYUDN+7leYjj9S5zZbZG4eDtFuI+9J9aX
 ckkZBpqTPrq1A4OJlalznZ7eewAQxES+DLhnHWH/uLMTHkBxoFoG/ZBRG7MCaPU=
X-Google-Smtp-Source: AGHT+IE1vVAVVp3pHsi67doSft45cle+41o5WQQZmCCQwqPGUeLdAZMZKKfgQxT1EhGpC05tNogt9g==
X-Received: by 2002:a4a:928c:0:b0:5c1:ea56:44c7 with SMTP id
 006d021491bc7-5c1ea564687mr3422773eaf.3.1719324869289; 
 Tue, 25 Jun 2024 07:14:29 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-700cb858899sm86854a34.77.2024.06.25.07.14.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jun 2024 07:14:28 -0700 (PDT)
Date: Tue, 25 Jun 2024 08:14:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 13/14] Update u-boot.cfg to include CFG also
Message-ID: <20240625141427.GO38804@bill-the-cat>
References: <20240623203033.1566505-1-sjg@chromium.org>
 <20240623203033.1566505-14-sjg@chromium.org>
 <20240624182931.GI38804@bill-the-cat>
 <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Hz+6qt4kPD0gEbDR"
Content-Disposition: inline
In-Reply-To: <CAFLszTguTkc1m2JYb=5+yW_8uY+J0AsQZ_L0hFJHDfEXNeb0wQ@mail.gmail.com>
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


--Hz+6qt4kPD0gEbDR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 01:38:04PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Mon, 24 Jun 2024 at 19:29, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Jun 23, 2024 at 02:30:32PM -0600, Simon Glass wrote:
> >
> > > Some configuration is now in variables with a CFG_ prefix. Add these =
to
> > > the .cfg file so that we can see everything in one place. Sort the
> > > options so they are easier to find and compare.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Add new patch to update u-boot.cfg with CFG_... options
> > >
> > >  scripts/Makefile.autoconf | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/scripts/Makefile.autoconf b/scripts/Makefile.autoconf
> > > index b42f9b525fe..65ff11ea508 100644
> > > --- a/scripts/Makefile.autoconf
> > > +++ b/scripts/Makefile.autoconf
> > > @@ -71,7 +71,7 @@ quiet_cmd_autoconf =3D GEN     $@
> > >  quiet_cmd_u_boot_cfg =3D CFG     $@
> > >        cmd_u_boot_cfg =3D \
> > >       $(CPP) $(c_flags) $2 -DDO_DEPS_ONLY -dM include/config.h > $@.t=
mp && { \
> > > -             grep 'define CONFIG_' $@.tmp | \
> > > +             egrep 'define (CONFIG_|CFG_)' $@.tmp | sort | \
> > >                       sed '/define CONFIG_IS_ENABLED(/d;/define CONFI=
G_IF_ENABLED_INT(/d;/define CONFIG_VAL(/d;' > $@; \
> > >               rm $@.tmp;                                             =
 \
> > >       } || {                                                         =
 \
> >
> > I don't like this because whereas "CONFIG_" is enforced to be set only
> > by Kconfig and so always all reliably set and found via a single header,
> > CFG_ stuff is not.
>=20
> OK, so how are CFG_ options found? I hit this when trying to find the
> SDRAM size on rockchip 3399 and I could not find any way of figuring
> it out.

It's just another define, there's no uniformity to it. For some of the
SDRAM values really we need some build time way to grab some information
out of the default device tree.

--=20
Tom

--Hz+6qt4kPD0gEbDR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ60MMACgkQFHw5/5Y0
tyzGJQwApDm9OU/Kqz6JQzRb85K7kmDOWmDiGt/A5jHfgbEyd/wZKObG1EAU+p4H
Onijtg1OUt+XRhsLmN0MEf6Z7yt82JbqeAe71j8BMlQ7AIqpOuH+LpwICCu1A7fR
bBj7ZgKOSXBjJsyuNYRB9NZ0tYd6C0+USuBz2oGaTEwkLa/XMRfB5xSGZojfs4SN
wxLS4eom+uihUQhR53gjoVVUqMRFfUOi8HqOPDVQoiQVHQt0jsp3WvL2XlEiL4P2
wYq2OMy1T0O2TUzNMxRhIoZtRS/CX2Zm+2bZNSflwnnWuppT0owL+sUd4BenSXBK
5t2OTJAcsLlDjm49wzEcv3hePoT5r+42kevtpp7srpPR8hD0iIsMCcZU57CuUgfl
qGamOYJxyQMA18dT+V11G2JR+NgDxjNvvDAaUjFatSiKV1q9g4JoKbqUPVcePlIV
30rK8bvGOTZXRoDmMD+En4K4vChcA16WiDz59VH52yR9fqXigfeC5amWBrqx49ic
0HY0J/Tx
=sYFG
-----END PGP SIGNATURE-----

--Hz+6qt4kPD0gEbDR--
