Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E87CD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:24:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 84748847C5;
	Fri, 15 May 2026 20:24:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="niPSR1Lb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 091028482F; Fri, 15 May 2026 20:24:48 +0200 (CEST)
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com
 [IPv6:2607:f8b0:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB26E846AE
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:24:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32b.google.com with SMTP id
 46e09a7af769-7e36bb16a92so84201a34.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778869484; x=1779474284; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=U2cIhH8zY/kBt5spawXVm66sSHpR4B+S92qIO4pQIac=;
 b=niPSR1Lbg9L/DDJA9eihQo43udMHHBgoeSLaa2tEiCDxMHxgNDLnB1NEnxFnVZoAyV
 pxtcY9YEF2VY+lD0PG0LAOMEGI5zpEcNr+Gd66cFsiOaPNJJGliZ9w0GNw6GBV6wV/7w
 HFhAxbIy0qIz0vka9JS+FHguubXTG65P5grvo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778869484; x=1779474284;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U2cIhH8zY/kBt5spawXVm66sSHpR4B+S92qIO4pQIac=;
 b=XZCm0UninMPm1Ht9A+TKnLGSq9xhNw8UDuJ3GSekggW2YmEDhZx85BPOrTFsxaJDnu
 IrlmvZG8GnvCQ/Vqxx9QpqSAfvI6rGt8R8UlNwt/Sx0fM9sd3SDMvHgkiz1U0tzE/xwS
 fa8/ZfPZR/5JwJKbJ+AwdP7qF6EAPJMC+UmiMfXGuP3gFucxTjWMFWnV91xGZzEKYvfz
 +9mtXJBtUBygln1Bwa93QXDE/UBeK3o0gECUwDhPLZyUlAeuQ8oPcPAaoGm9RYzkAHAB
 Q4jneXvMVrvAeUA/hla8n1gFRjo3teqIgoU+FPszRoQoZhF6gUYHFI4f19HWYDcfuDxp
 ZszQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0iYtR7whO9rfw1UcvsipknETetw3Rw+MhZ4dZAGbA/1hsOOFBXnkd+B480kKXYZW7XDCdo/A=@lists.denx.de
X-Gm-Message-State: AOJu0Yx+yjKaiTS39l7ijEeWa4oqV28edGvcQvtB9jMiUUNmJrhEsdm9
 Jut//7lSt1kJjRH590v4Kb9eVhht3+KyRqatUlWZ8stTDQGLBwULhWY0RsVuMU0xr58=
X-Gm-Gg: Acq92OGSAHBd+MGT2lcqaCQFWfRd+Jm0EMuAMI6+Pcg0w4OD2aIptkzTld+VU8LAPRL
 Z8UQwrgJlMcKfrzHJOBs7mJVpqCDTq7ryN1jieev3UmlbbxqkmM2kony732FEXM5O/qvm951H07
 tRoAV45CyhqNfg9tFY8D/Kx+6OW90JxgA8pWChOUZ1zDjwD58JOUVupKWBxsrTJK1QfvSYWW/T1
 smdPf9c9Zh6qETEsQzpYfGgX1xBkaW5NSQRhYQCf8y1b6GYtBJWqJnePEvyZyaT+AT9wYylz8bc
 EEsu4OYaSmqBO7U7s1asjCf9jkl3Lrbffx+TSw6kCmsOoGGP2ISuMmws7lnnPWYN7I+oAi2EGxQ
 QyQFmo4yHqJ5zzN3vqlYFp9QvcltN/Kghjw/FLU9Y2cco3d1Gueg3BSqTchx7ySYr9tGh1KScrT
 RUF426DrCn94BUkRJWaXAUpe097bxXm3SPgHjLimo54VvnYHdyjPBTHluQNzJDV6CXpGNAeF9cm
 GcNlhGeicp/jlZsyYlQWYHWdpHD4vKXghnXcRf5wItbUEvZ1XHtL7F5oy8y7g==
X-Received: by 2002:a05:6830:258a:b0:7dd:f615:a84e with SMTP id
 46e09a7af769-7e4f2b667dcmr3705491a34.18.1778869484484; 
 Fri, 15 May 2026 11:24:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55b7c6b38sm1870528a34.2.2026.05.15.11.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:24:43 -0700 (PDT)
Date: Fri, 15 May 2026 12:24:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: nm@ti.com, Wadim Egorov <w.egorov@phytec.de>,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
Message-ID: <20260515182441.GI1858239@bill-the-cat>
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
 <20260515160256.GF1858239@bill-the-cat>
 <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OW7sM1K8np7yahVq"
Content-Disposition: inline
In-Reply-To: <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
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


--OW7sM1K8np7yahVq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:13:50PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
> > > >
> > > > > A file like rm-cfg.yaml accidentally left in the source tree root
> > > > > shadows the board-specific copy. binman builds the wrong YAML, the
> > > > > resulting rm-cfg.bin may match a different SoC, and we end up with
> > > > > the following error:
> > > > >
> > > > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > > > >       Boot Notification response failed. ret =3D -110
> > > > >
> > > > > Move the board directory ahead of the srctree root so that the
> > > > > most-specific match wins.
> > > > >
> > > > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > > > ---
> > > > >  Makefile | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/Makefile b/Makefile
> > > > > index 552328f9f2c..1ec29dfe0be 100644
> > > > > --- a/Makefile
> > > > > +++ b/Makefile
> > > > > @@ -1682,7 +1682,7 @@ cmd_binman =3D $(srctree)/tools/binman/binm=
an $(if $(BINMAN_DEBUG),-D) \
> > > > >               build -u -d $(binman_dtb) -O . -m \
> > > > >               --allow-missing --fake-ext-blobs \
> > > > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > > > > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDDIR) \
> > > > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctree) \
> > > > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=3D$=
(of_list) \
> > > > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > > > >               -a atf-bl1-path=3D${BL1} \
> > > >
> > > > Why do we need to look in $(srctree) itself?
> > >
> > > See for example:
> > >
> > > arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =3D
> > > "arch/arm/mach-k3/keys/custMpk.pem";
> >
> > That's not great, I'm sorry I missed it at the time. I wonder how easy
> > replacing that key is with a non-dummy key. Hopefully it's done in a way
> > that doesn't encourage checking private keys in to repositories..
>=20
> Typically we would use an environment var passed in from the Makefile,
> as we do with BL31, TEE, TI_DM, etc.
>=20
> >
> > > Also, people sometimes put files in the source tree, e.g. BL31 images,
> > > in the hope that they will be found.
> >
> > That's also a bad practice and what BINMAN_INDIRS is for.
>=20
> Yes, but that came quite a bit later with the bintool stuff (2021).
>=20
> Anyway, with a bit of work I believe we could drop the source dir.
> Would you like to look at it, or should I?

Well, the first step would be getting some more feedback on how people
override some of these files for example. Even more environment files
seems like a bad idea and I'm not sure what BINMAN_INDIRS can't cover
today.

--=20
Tom

--OW7sM1K8np7yahVq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagdk5gAKCRAr4qD1Cr/k
CidlAP43kkK329OMyvw4l5jnUr/ho8UrquMfBp8/JAuASKFYggEAhLST0oTInPLr
dNcDasgOkEczPYxG4Ll76sCiSbnQ8gY=
=uFiT
-----END PGP SIGNATURE-----

--OW7sM1K8np7yahVq--
