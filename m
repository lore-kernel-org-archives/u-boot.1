Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 878E7CD5BB1
	for <u-boot@archiver.kernel.org>; Tue, 26 May 2026 16:07:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 624EB8469F;
	Tue, 26 May 2026 18:07:50 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uAS0QFmW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48468846A5; Tue, 26 May 2026 18:07:49 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 091B584659
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 18:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7e6201aeb2aso3389007a34.3
 for <u-boot@lists.denx.de>; Tue, 26 May 2026 09:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1779811666; x=1780416466; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1OR3QtK0tKwWsYpuS4Mfqj6NSMAb/BU5NeWo1D1URu8=;
 b=uAS0QFmW3wcUuQp4jrQvHbKPXjMXi3OOE59oAM9kA+ICN04Lq6GT7AKTxYsJwNMkyZ
 bHV7DDwnp0Ld4ZVVvVF9YHEnIpAQpHzL669M9xsrdy/xPtN4yglyxv1vzVraha5O73Bw
 NwWLoEqE6vHO4Z+e2UzWc5XX+H0ne/4CgUEr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779811666; x=1780416466;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1OR3QtK0tKwWsYpuS4Mfqj6NSMAb/BU5NeWo1D1URu8=;
 b=M5mktun36IELaXFNFGScaavaCzGR9k8NRSg4+rrdjFokJuqscuiWovyoibqiP2P7fD
 WhtrbUCfO9ARo9p9nlaOrFAMyE1Mprc+1ACxSbwlroGQaNkFjRWXcwuNc+PsV9Z1Ln96
 2kFwCMI39ngVCFeyRpNyMw1tvk1ItSM4qWLXNClER8CRpggsZS0IjdZ+1Oyma6nK46Xi
 dpiQ6TiSE4YGyEUUpIRJUb1oWf3NRuCHtiQG5Vh159MOfbrdpmC4xe0AQlB6Zi7h2ICa
 C/bt1SJRx78Gs/Vd+Wc0wGBHvHC5FT852I5xeW3e0hAFjriLJ6VDWDygGVdKi/eE5HWL
 JqsQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+zCfNAmJ4ykK9lkRJVG1uW8eRnkp/oza3OrpJNbjPWi14iyh3yBjq+Udavv1YMo7QHNJRhHRs=@lists.denx.de
X-Gm-Message-State: AOJu0Yzah1cr9Zvh9PybkdXTuNcn9Ba91wh/lbfInvEewZT7pqXuQ+7r
 6/clJ8qOlP3k3RP7omhcaMDplu0yIxSLI9sCprY7CtylJBrJ5TQGP8P2dRVrbDgIm/I=
X-Gm-Gg: Acq92OHZ7DGKNEQ4e1VjQJumQ9Ix0CYNmw1oXu/IciK8evfo7cxPsH0IWUJWEMrPsya
 UsP3HYhjiqWHJ5HY2d507ozakdkYDcH96BKOhJOqkDOxOfNJzc8m/s6vLi8Np3ym071/FFaAfyF
 LCrVBzeBjLO0wuTSAKRstbN/PuirNaQEYu8Oap+j/iCpdFEjrXGa4ogFDBybISBrc3k9/ohIVf/
 HKnE/i5jByjdygdAh03nLU2mt+GzWrInzn040WKXXIvcTX6M+Xa0BFi2BwKOkcvcQTFsKwoG3wL
 GfzaqNy+rJHOeED/JzbPGF5Fy2LHiiK9jislRbbfCu8hbhrIAj/tU17eDdMeRFbh/uNfrJZr0Qd
 w31MK5HEecM5najthwyCNBGlUhaCrGafYkeNUc1lFtGUXMatGyq2ClxC+p3sjLx+KeNGSjFGHnp
 qznjve/jMWuVkqQM3HY6o1zmZdRNOTGkeNdO1fhrU+fKwtrUPar4acZlrFwLXyvZ4xBR7omXem3
 3+w9fva4D+nL9ZFWLjCQt1tJd6q4SlDvfo20Mep7Qc6vsIpZZ55+N2dYBWIImr/wCk=
X-Received: by 2002:a05:6830:673a:b0:7cf:da97:57d6 with SMTP id
 46e09a7af769-7e5fec80414mr12415301a34.6.1779811665753; 
 Tue, 26 May 2026 09:07:45 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6064aa0bbsm9802272a34.12.2026.05.26.09.07.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 09:07:45 -0700 (PDT)
Date: Tue, 26 May 2026 10:07:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Ben Schneider <ben@bens.haus>, Stefan Roese <stefan.roese@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>
Subject: Re: v2026.04 crashing on Marvell Armada 3720
Message-ID: <20260526160743.GW1858239@bill-the-cat>
References: <IRefanijM8fTzOXeGe-H5hmhRkm7pt4Q83BV6VcWKlWp0s4i8mYcONTQz-IVhvNWlGta4LtnfK7ti6gxlrqq8h8cotgG1S0Fs6_DviAHvyo=@bens.haus>
 <9b0f2989-5c78-4e74-a691-b873b9bb2649@cherry.de>
 <ZJ8GNZXD-fYDaXZ4MCGrxvVAtJfaDjWWHRt6LlXWpQJpg3evBb4F-T9KO5yGvmFM3j643wz9PQa4ROK62TL6kKSnBW65XJmBep6yuxh2qUo=@bens.haus>
 <CAJaLiFzyOUV1r0gUAFpgGcQUGzmz_zneiC=AVbAnxKDcOMCvqg@mail.gmail.com>
 <so1abs7pAg9MrPZOVyW7dGcSFp2m4Tf47UW6T_QYYtgqkQ8DqrHNCfPLytOKux86LMpRM9t3fcv_I1uIYIOkdKGFkH5OZ8cEpueoLEK7iwU=@bens.haus>
 <CAJaLiFzGYZ89B7LD7z6Mese0iH3-KqM8TFbn5Vkx11Zjr-7MrQ@mail.gmail.com>
 <aU0JJd40MuUFOULadJri1Poqfq4wrvGMF7zrdOEucjI-loO3N7kZDYa32JIaXoDBcusnMxLPEuRcBTPvSkfnSf3p_0Pn0oZPXHTTZXSn48M=@bens.haus>
 <CAJaLiFxMirwELHw_nAZ56oHWK9fXmsshisGr2Wr3OnGLLzsyrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="pwj7n5UkRrLK9e/F"
Content-Disposition: inline
In-Reply-To: <CAJaLiFxMirwELHw_nAZ56oHWK9fXmsshisGr2Wr3OnGLLzsyrg@mail.gmail.com>
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


--pwj7n5UkRrLK9e/F
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2026 at 09:50:50PM -0700, Tony Dinh wrote:

> Hi Ben,
>=20
> This problem sounds familiar. Perhaps Tom can explain this. I recall a
> patch recently related to DEVRES.
>=20
> Commit 217cf65
> dm: core: Default to using DEVRES outside of xPL

Looking at:
commit 2e6b5185bd509d5c39bbdf900bf6ac9c12f2ed59
Author: Jamie Gibbons <jamie.gibbons@microchip.com>
Date:   Tue Jan 20 15:33:13 2026 +0000

    configs: microchip_mpfs_generic: fix boot failure
   =20
    Recent changes to device resource management (DEVRES) increased early
    memory requirements during boot. The previous value was insufficient,
    resulting in boot failures. Increase CONFIG_SYS_MALLOC_F_LEN to provide
    enough early malloc pool for successful boot and device initialisation.
   =20
    Signed-off-by: Jamie Gibbons <jamie.gibbons@microchip.com>

diff --git a/configs/microchip_mpfs_generic_defconfig b/configs/microchip_m=
pfs_generic_defconfig
index 22f67414a7c7..973ed09fa875 100644
--- a/configs/microchip_mpfs_generic_defconfig
+++ b/configs/microchip_mpfs_generic_defconfig
@@ -1,6 +1,6 @@
 CONFIG_RISCV=3Dy
 CONFIG_SYS_MALLOC_LEN=3D0x800000
-CONFIG_SYS_MALLOC_F_LEN=3D0x2000
+CONFIG_SYS_MALLOC_F_LEN=3D0x2800
 CONFIG_HAS_CUSTOM_SYS_INIT_SP_ADDR=3Dy
 CONFIG_CUSTOM_SYS_INIT_SP_ADDR=3D0x80200000
 CONFIG_ENV_SIZE=3D0x2000

May also help

>=20
> Added Tom.
>=20
> All the best,
> Tony
>=20
> On Sun, May 24, 2026 at 6:21=E2=80=AFPM Ben Schneider <ben@bens.haus> wro=
te:
> >
> > Hi Stefan,
> >
> > On Monday, May 11th, 2026 at 12:45 PM, Tony Dinh <mibodhi@gmail.com> wr=
ote:
> >
> > > Added Stefan (MVEBU SoC maintainer).
> > >
> > > > The first commit to cause problems is actually 217cf65 dm:
> > core: Default to using DEVRES outside of xPL.
> >
> > After a lot of testing, I think I've traced the issue to drivers/pinctr=
l/mvebu/pinctrl-armada-37xx.c. There are two calls
> > to devm_kzalloc that, when I change to kzalloc and remove the dev
> > argument, my device boots again.
> >
> > --- a/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> > +++ b/drivers/pinctrl/mvebu/pinctrl-armada-37xx.c
> > @@ -523,8 +523,7 @@ static int armada_37xx_fill_func(struct armada_37xx=
_pinctrl *info)
> >                 const char **groups;
> >                 int g;
> >
> > -               funcs[n].groups =3D devm_kzalloc(info->dev, funcs[n].ng=
roups *
> > -                                              sizeof(*(funcs[n].groups=
)),
> > +               funcs[n].groups =3D kzalloc(funcs[n].ngroups * sizeof(*=
(funcs[n].groups)),
> >                                                GFP_KERNEL);
> >                 if (!funcs[n].groups)
> >                         return -ENOMEM;
> > @@ -724,7 +723,7 @@ static int armada_37xx_pinctrl_probe(struct udevice=
 *dev)
> >          * we allocate functions for number of pins and hope there are
> >          * fewer unique functions than pins available
> >          */
> > -       info->funcs =3D devm_kzalloc(info->dev, pin_data->nr_pins *
> > +       info->funcs =3D kzalloc(pin_data->nr_pins *
> >                            sizeof(struct armada_37xx_pmx_func), GFP_KER=
NEL);
> >         if (!info->funcs)
> >                 return -ENOMEM;
> >
> > I cannot explain why these changes resolve the issue so I'd
> > appreciate if someone more knowledgeable would review.
> > I'm also happy to test other proposed solutions. Thank you!
> >
> > Ben

--=20
Tom

--pwj7n5UkRrLK9e/F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahXFSwAKCRAr4qD1Cr/k
CoU/AP40Pv6iVa79BsXeu/dqZS/UFZ0FLiBLsa90IlN/dStD8gD/dtL5Oa90cKyJ
SXL7iiYF7xiLx7KbQXatucB2+LiftAg=
=SFX8
-----END PGP SIGNATURE-----

--pwj7n5UkRrLK9e/F--
