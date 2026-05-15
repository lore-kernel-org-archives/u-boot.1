Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57F6CCD343F
	for <u-boot@archiver.kernel.org>; Fri, 15 May 2026 18:44:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B61784713;
	Fri, 15 May 2026 20:44:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="X5LcfDzQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1CACE847C5; Fri, 15 May 2026 20:44:41 +0200 (CEST)
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com
 [IPv6:2607:f8b0:4864:20::234])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D685E846EB
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 20:44:38 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x234.google.com with SMTP id
 5614622812f47-479d85152c9so89839b6e.2
 for <u-boot@lists.denx.de>; Fri, 15 May 2026 11:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778870677; x=1779475477; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x0XB0ctrzh2lln8/6epflXToDiIhqJvds6OwKnKY0H8=;
 b=X5LcfDzQ0OpkxnjMyr6+2Hbdghu+k9b8tg8+poypHAuUmgm7Q1mKYrC099MBvGv5aa
 bF8YsiXUuY3G0jV4DXnNEadYCdt6rxpVacyJaVGLY/Yp2WVnLuNkIi+tOToXoc9HJZBh
 qYJmenDUc0KGGNSWF5W0jEsh+2e2RsF0FetRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778870677; x=1779475477;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x0XB0ctrzh2lln8/6epflXToDiIhqJvds6OwKnKY0H8=;
 b=olDsQO8oeMlheHv8Ov1tK6GPgSiKnpjMfpZtjDJr0eRKNQTdmd2rqbjCppMdQTo7Yq
 A4PY36QJrzfMicIBKFxlsdRlXHR5C10rJeJmWRTunn7WeqSV9pH9D//tCrpjh7caR8AG
 4rEJ2F5Ue7PxJdqqtvpf86CTG4gy+zJYxR9wmBh2sFd6EtykXQTvx0KzH4lLXNe6o08Z
 T5M9iNjndDlPDF4gD6k1Mmq1E2NKwH6k2yXrmu+yKTUQm2g4fhFNKMUqKDlPhWMngIYQ
 bV+dcQx51FUvg0TyLdEJ2fSit2zoFqlFVVS1SoAjMJ+/qN6Lj2tIiCae8SEHNJ0QJWLd
 rRcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9lk2rZAQAJ4AyflJ9aeMhNZdi0j3NB7JYxoIe8MDDRCIIpa7BPZkaT3ypGcfjTCsXPxvq9YvE=@lists.denx.de
X-Gm-Message-State: AOJu0Yy4ejtZDXUTvLK/0uOfaLewknskfEWUPNYOz5QRKcXqY/ONPzbd
 5XBZM+SkbMJ4T0Ey6jEEie1f6FQCzkh4Ov9I2GFLoitHW9CrxVbiohfeT3SK2fUaDl4=
X-Gm-Gg: Acq92OEBqmkOS7EiXQYprZPmMWadIBfVyT9oyPaDEHAH/PMH8GIghzJYbdYh87z1NU5
 B2TKKnf89nL7oGQRwcOGqQE1Oi8snFxpNELS5SvRER5dUUQY9oRE5Vu3BEhvZL7dzxC5avAOEps
 2N2vVeMLy/Qy9/L50WMdEH7WyU76E2U8wU3ttMMWCfDrVQCwc2CMNVumHbS1wl3d3D6Y+X2glbR
 acEsKnTukchR/VLnmnElh5JM+bougSPE/PylquAAmrPy3QgwTpdVYIQlpvB9fad8fPMeuDTBpKi
 shM86IgsSUAPARBdasvJjCOleg9AjBKbRPWv+mQyAfvLzRYG0MdQOShiTgAyR87u+CCQTSId5QX
 BrPQD2XYbz3ChwKVpN61rtApfJ38rqO1Jnbfpd3Uso/sUXiwcQPzv30MG+9MBiJFdFOyYmNPfQE
 LhJubhDC/JCFEVKf28zA7t85OjlcoYJUFqCeuvs8WojVPpdtGEzgkpDpnkylZwxR/POzYt6EoMr
 9C3bmSQYmKWF7GWTrQA+rQ5YV6EinmbS2ltI/wFMuHskkOVKaAAJBCzd3mRjA==
X-Received: by 2002:a05:6820:220d:b0:696:23f5:7702 with SMTP id
 006d021491bc7-69c9c08a3c7mr3207873eaf.60.1778870677533; 
 Fri, 15 May 2026 11:44:37 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-439fbddb90bsm4642446fac.0.2026.05.15.11.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 11:44:36 -0700 (PDT)
Date: Fri, 15 May 2026 12:44:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: nm@ti.com, Wadim Egorov <w.egorov@phytec.de>,
 ilias.apalodimas@linaro.org, marek.vasut+renesas@mailbox.org,
 sughosh.ganu@arm.com, u-boot@lists.denx.de, upstream@lists.phytec.de
Subject: Re: [PATCH] Makefile: binman: Search board directory before srctree
Message-ID: <20260515184434.GJ1858239@bill-the-cat>
References: <20260515054327.1033466-1-w.egorov@phytec.de>
 <20260515145400.GB1858239@bill-the-cat>
 <CAFLszTid-e+NWrFxoorfrUT23_mztUZP8FRbmT9FJ55M8A+FXA@mail.gmail.com>
 <20260515160256.GF1858239@bill-the-cat>
 <CAFLszThfUMe=67xwzbv6TvugH3iCOO=-EoYk6oUshKru-wpDQw@mail.gmail.com>
 <20260515182441.GI1858239@bill-the-cat>
 <CAFLszTjHaqck4gVDSiBw0M9V3yZLzUa8+EjaW94G9JcO=-Ny8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="TnMi63MIgFboWZFv"
Content-Disposition: inline
In-Reply-To: <CAFLszTjHaqck4gVDSiBw0M9V3yZLzUa8+EjaW94G9JcO=-Ny8Q@mail.gmail.com>
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


--TnMi63MIgFboWZFv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 12:32:30PM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 15 May 2026 at 12:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, May 15, 2026 at 12:13:50PM -0600, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Fri, 15 May 2026 at 10:03, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, May 15, 2026 at 09:35:10AM -0600, Simon Glass wrote:
> > > > > Hi Tom,
> > > > >
> > > > > On Fri, 15 May 2026 at 08:54, Tom Rini <trini@konsulko.com> wrote:
> > > > > >
> > > > > > On Fri, May 15, 2026 at 07:43:27AM +0200, Wadim Egorov wrote:
> > > > > >
> > > > > > > A file like rm-cfg.yaml accidentally left in the source tree =
root
> > > > > > > shadows the board-specific copy. binman builds the wrong YAML=
, the
> > > > > > > resulting rm-cfg.bin may match a different SoC, and we end up=
 with
> > > > > > > the following error:
> > > > > > >
> > > > > > >   k3_system_controller sysctrler: k3_sysctrler_start:
> > > > > > >       Boot Notification response failed. ret =3D -110
> > > > > > >
> > > > > > > Move the board directory ahead of the srctree root so that the
> > > > > > > most-specific match wins.
> > > > > > >
> > > > > > > Signed-off-by: Wadim Egorov <w.egorov@phytec.de>
> > > > > > > ---
> > > > > > >  Makefile | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/Makefile b/Makefile
> > > > > > > index 552328f9f2c..1ec29dfe0be 100644
> > > > > > > --- a/Makefile
> > > > > > > +++ b/Makefile
> > > > > > > @@ -1682,7 +1682,7 @@ cmd_binman =3D $(srctree)/tools/binman/=
binman $(if $(BINMAN_DEBUG),-D) \
> > > > > > >               build -u -d $(binman_dtb) -O . -m \
> > > > > > >               --allow-missing --fake-ext-blobs \
> > > > > > >               $(if $(BINMAN_ALLOW_MISSING),--ignore-missing) \
> > > > > > > -             -I . -I $(srctree) -I $(srctree)/board/$(BOARDD=
IR) \
> > > > > > > +             -I . -I $(srctree)/board/$(BOARDDIR) -I $(srctr=
ee) \
> > > > > > >               $(foreach f,$(of_list_dirs),-I $(f)) -a of-list=
=3D$(of_list) \
> > > > > > >               $(foreach f,$(BINMAN_INDIRS),-I $(f)) \
> > > > > > >               -a atf-bl1-path=3D${BL1} \
> > > > > >
> > > > > > Why do we need to look in $(srctree) itself?
> > > > >
> > > > > See for example:
> > > > >
> > > > > arch/arm/dts/k3-j721e-binman.dtsi:308:  private-key =3D
> > > > > "arch/arm/mach-k3/keys/custMpk.pem";
> > > >
> > > > That's not great, I'm sorry I missed it at the time. I wonder how e=
asy
> > > > replacing that key is with a non-dummy key. Hopefully it's done in =
a way
> > > > that doesn't encourage checking private keys in to repositories..
> > >
> > > Typically we would use an environment var passed in from the Makefile,
> > > as we do with BL31, TEE, TI_DM, etc.
> > >
> > > >
> > > > > Also, people sometimes put files in the source tree, e.g. BL31 im=
ages,
> > > > > in the hope that they will be found.
> > > >
> > > > That's also a bad practice and what BINMAN_INDIRS is for.
> > >
> > > Yes, but that came quite a bit later with the bintool stuff (2021).
> > >
> > > Anyway, with a bit of work I believe we could drop the source dir.
> > > Would you like to look at it, or should I?
> >
> > Well, the first step would be getting some more feedback on how people
> > override some of these files for example. Even more environment files
> > seems like a bad idea and I'm not sure what BINMAN_INDIRS can't cover
> > today.
>=20
> Assuming you mean 'environment variables', we do need the actual
> filename, not just the directory. We could have default filenames for
> each entry type, I suppose. Some do already.

Yes, I think moving that way is the right direction. I was going to use
-scp-path=3D$(SCP) as an example of something to move away from, but it
looks like that's already being done in a way BINMAN_INDIRS should
handle.

--=20
Tom

--TnMi63MIgFboWZFv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagdpjgAKCRAr4qD1Cr/k
Cu3FAP0fYMUKDaTk5OF8SYMwRSGQW8h7ilAT6OmJrvFQ6989uQD/U2k+CGi25gOz
hettvvXAnwVkOM71O7ZSBfK9jYG0lAw=
=Git8
-----END PGP SIGNATURE-----

--TnMi63MIgFboWZFv--
