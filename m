Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D048CC83F33
	for <u-boot@archiver.kernel.org>; Mon,  4 Sep 2023 14:45:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C552C869F0;
	Mon,  4 Sep 2023 16:44:30 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ORSuegnT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B22AA86A17; Mon,  4 Sep 2023 16:44:29 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E8A75869F0
 for <u-boot@lists.denx.de>; Mon,  4 Sep 2023 16:44:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-5920efd91c7so14640757b3.2
 for <u-boot@lists.denx.de>; Mon, 04 Sep 2023 07:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1693838665; x=1694443465; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=OFVEjT4Qwt17vU+zQMGy8EpBe/GOw4liZPfcL5c+waE=;
 b=ORSuegnT+pqp7G3zwDMc7v+X67mKhvgWMu656a5lV29xi0XYfoIP5532jHhjjof9Vd
 pEmOEZbZFVandiH2/wB/6pfhfCiDQZBORbtp5E7q2XvoHSfIokbQQUQSw7vbXhVKVvp5
 ta0Abfu+9KMONlOG7ZHl/PFIj+A2hry3SwQ+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693838665; x=1694443465;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OFVEjT4Qwt17vU+zQMGy8EpBe/GOw4liZPfcL5c+waE=;
 b=VNwdL6Bp87/Fv1HoavBJqBgT+uyjAdBrZOR1XzIZfLmnE9YcIOuui5CDeJPwWHwFrb
 neaLwfyO7S8LTYdqAhqXk+r3hFsVg3ppfBJ7dt6xz2skpYp5gC9YgmDYmS2wxTjQPOhW
 yiAYfaof2CCPIu+a0FpLzOf++jlSNYJaJGqqCW6bS95x4OJGGUUOna5MhXZHyAmG2zeu
 wCLg+sQf5+dONaiTVUqWu8Mkjw0VNk8WuoLn0TwJCfRCB6AqIedlz8ajZUEw0pnHc8Ga
 8UMXlAkS6Oi7gvYIcw8odu91vUlPAZNMb5yu2mj47z2Y5vGaQ2BUqglIhIDnviCMpQav
 6enA==
X-Gm-Message-State: AOJu0YyLu4NAgVnYpcnX2qR0mK+Qn0H1AVdmw2fMQeZoS9VelT35GyeN
 IhYh5sXuHFyYh5gLoXZdwbBw9dxN3l1DH5951Zpfxg==
X-Google-Smtp-Source: AGHT+IG92RQ83ALz9LpHfOPHrRJUOvap+lrqil2q12lW0m6lzR0yQVg74NnPXk/OEfKg3nOScqcZ6A==
X-Received: by 2002:a25:cb12:0:b0:d7a:c0b8:f171 with SMTP id
 b18-20020a25cb12000000b00d7ac0b8f171mr10354044ybg.37.1693838665670; 
 Mon, 04 Sep 2023 07:44:25 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-977e-7fa5-b64a-ed15.res6.spectrum.com.
 [2603:6081:7b00:6400:977e:7fa5:b64a:ed15])
 by smtp.gmail.com with ESMTPSA id
 80-20020a250353000000b00d5d4bae6fdfsm2337222ybd.30.2023.09.04.07.44.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 07:44:25 -0700 (PDT)
Date: Mon, 4 Sep 2023 10:44:23 -0400
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 19/19] boot: Join ARCH_FIXUP_FDT_MEMORY with related
 options
Message-ID: <20230904144423.GD3101304@bill-the-cat>
References: <20230831035319.2316665-1-sjg@chromium.org>
 <20230831035319.2316665-20-sjg@chromium.org>
 <20230831140149.GR3101304@bill-the-cat>
 <CAPnjgZ1qH4oPq23=+DpEBz3o-t=2454yCmzJOJLdF_mCJ38QNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="7hunpLKzM0MgLBC7"
Content-Disposition: inline
In-Reply-To: <CAPnjgZ1qH4oPq23=+DpEBz3o-t=2454yCmzJOJLdF_mCJ38QNQ@mail.gmail.com>
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


--7hunpLKzM0MgLBC7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2023 at 08:43:12AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 31 Aug 2023 at 08:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 30, 2023 at 09:53:13PM -0600, Simon Glass wrote:
> > > Move this to be with the other devicetree-fixup options.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > (no changes since v1)
> > >
> > >  boot/Kconfig | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 023446130282..257f4cc085e1 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -693,14 +693,6 @@ config SUPPORT_RAW_INITRD
> > >         address of the initrd must be augmented by it's size, in the =
following
> > >         format: "<initrd address>:<initrd size>".
> > >
> > > -config ARCH_FIXUP_FDT_MEMORY
> > > -     bool "Enable arch_fixup_memory_banks() call"
> > > -     default y
> > > -     help
> > > -       Enable FDT memory map syncup before OS boot. This feature can=
 be
> > > -       used for booting OS with different memory setup where the par=
t of
> > > -       the memory location should be used for different purpose.
> > > -
> > >  config CHROMEOS
> > >       bool "Support booting Chrome OS"
> > >       help
> > > @@ -1492,6 +1484,14 @@ config FDT_SIMPLEFB
> > >         the presence of the simple frame buffer with associated reser=
ved
> > >         memory
> > >
> > > +config ARCH_FIXUP_FDT_MEMORY
> > > +     bool "Enable arch_fixup_memory_banks() call"
> > > +     default y
> > > +     help
> > > +       Enable FDT memory map syncup before OS boot. This feature can=
 be
> > > +       used for booting OS with different memory setup where the par=
t of
> > > +       the memory location should be used for different purpose.
> > > +
> > >  endmenu
> > >
> > >  endif # OF_LIBFDT
> >
> > It seems like fixups are mixed in with other changes in this menu when
> > we should probably keep the fixups lumped together at least.
>=20
> From what I can tell all of the things I am putting in this menu
> relate to DT fixups. The naming is a bit odd though, on some of them.

OK, thanks.

--=20
Tom

--7hunpLKzM0MgLBC7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmT17UcACgkQFHw5/5Y0
tyyXJAv8CYoZXWAL0ePDXXFrkqKQzqtr0SRCbfuEc9KjkheL3pJkK7CyDk14Qoil
ZEVlm09eyovTIZizt5JAigTxs8CZbuAN/051S8yifKE7gKXxxja3/U9V1cm/j7q/
DVUEusGlmLI8rIqN1gXEb3Ts89xDRFzlF92fLttMxp7GR4tjweMlZiezLoavpq1Q
I9FVZuczQmH3csspYljOjTx8xUfyAKImD4+yr2Sd1jjcKWg/YUE0M7/8Dmdbg/sY
bO2nieyuO4ngUpAi7GgU0IcHt8aizJqLw0mrFAn4sgILwI+29obXg8AhU8oGRk1p
u2FDWDcUNBuoC+tvKD77vCkvBdXLsaeowneGvn0xWDYt63g0lDpDvUvguEqyK8O6
c6oONi8HfR4MHo83c/EHUN37Tfsh2SS8bqVyclYXp4Mgyoz692Tywaz6QWemE0OJ
j/U5kgHYZ9oSJ7m8MWkmdTiJH7XxkyJ+iBHiDck/Q0o+t156xkmwOpEDbbhKFST3
dCTvaVeY
=laVw
-----END PGP SIGNATURE-----

--7hunpLKzM0MgLBC7--
