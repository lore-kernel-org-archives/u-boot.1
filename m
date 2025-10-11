Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2082CCD184
	for <u-boot@archiver.kernel.org>; Sat, 11 Oct 2025 14:37:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E9B858381D;
	Sat, 11 Oct 2025 16:37:21 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="RrgzueeX";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DAE2C83824; Sat, 11 Oct 2025 16:37:19 +0200 (CEST)
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com
 [IPv6:2607:f8b0:4864:20::22e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B12ED83804
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 16:37:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-43f5ec025d3so1473402b6e.1
 for <u-boot@lists.denx.de>; Sat, 11 Oct 2025 07:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1760193436; x=1760798236; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kREb0HnNbXYU+20i9z9o11sn9KjCywS5p4etSiw8M0c=;
 b=RrgzueeXcp470TTZFH+8AynqFcUZSZFaNUN3N2qh7VoQp26aS9CIu28iTUZYIcOtu3
 GQvlT2IUeVkYE/qu2Imkgh9jxb6tzlqxVZutmlQFZCrXzXJUftxVnWq3PanbjF23AcFI
 nvUfbNMLyZqrQPSiuzTKMDlDwnhbish804wB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760193436; x=1760798236;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kREb0HnNbXYU+20i9z9o11sn9KjCywS5p4etSiw8M0c=;
 b=B7nBrT/EW0SIwdskvMX3ef9pATHhAKsggwXrY64/W01nXDVnjQAeMhnG/3jwF05tn3
 vs5R7tchfeMJi6X4kZJxNeWEdIdj2YvwhhYNBqzd6le9Ny04Dzp+5rx/1TsLQQDzFh3A
 ToATSigLJZvuNYymphZcNh0ls0VN1fhEfnPage76i/zTohf016a3cR2B4vzhBCoBYCrP
 QrbST2o9fNcWGUsk+EbaGvw59FUnQqLwHgYHqUmZm37CDI09QSet0icSb1H1/6Jo2JLW
 0afISllLrBmAjP9ttQ7tfbC/WK6b+KS4xHEhJ1vR8QFf8qKyLRa6gb8AXirds2sGpn3m
 3ZOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3dfKw5iV+1zd2GGu0zTUpaWG0syYcpcE4hKj8lwRPBrKd0xIwvYhNvv25+lNwYM3LeJqurK0=@lists.denx.de
X-Gm-Message-State: AOJu0YymiGlASW2cBXwa5571vHTIHb7usPsh4hBhC+YJFKO75ny/BP5H
 RI/X2VTE9yyoreoLi14YwgCmqBv7a712CBD3oTJhVGFAFKlEsqMuP56qgBzb2i+5PEs=
X-Gm-Gg: ASbGncsMGHrgOzpPCXwI86Yq4d25Wa/yDZ6sVoDQGRJU1oV5/0eXEbXnjf1mp8x0vUf
 ehKmknImhIysDqKxQEbq4QG7e4wGNGpDDtpYMgX9Mnn3A17fnZMy6oedNjvGkQv5hsWzmXglpt/
 DZ3A+i03lOprcvemCbShKtF/EDWrw9H+2XnKpcjqu4XkkKkYAdITyIRF7Eei8Nioria6VvlDt/H
 xK9I9jpNqwZZ2zQv+jaWNimZxweg33kCZbbCfxE4PjPMHIh/zPX0CMEvoeu6S5ejMAbq0yfnkg3
 Cp6EuyfXVc+nWwO6UaIpclpGIpQu/AMISvpJDCAAq7t8fKyGie6i+RH4Bgqikoa7AOfmLSCgOiX
 f439xEZDdwnNU6UB20K+i9/X6WQqWwFljzCX8CoXqhRyIaE1PnegcrKlr26bt5cOVSBQWOvxIyq
 WhzfH3/mCtGhte9A8=
X-Google-Smtp-Source: AGHT+IEMj9v0ltTOHmbN136LN5Vrgx1T2Jy5B6/lU7x7wU43HhNNO0zKKFRIm1QSfE2OfbqLmFxrYw==
X-Received: by 2002:a05:6808:3188:b0:43f:4d50:3352 with SMTP id
 5614622812f47-4417b4177a9mr6262131b6e.31.1760193436387; 
 Sat, 11 Oct 2025 07:37:16 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4419889fe9dsm1282105b6e.9.2025.10.11.07.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Oct 2025 07:37:15 -0700 (PDT)
Date: Sat, 11 Oct 2025 08:37:13 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>
Cc: Tony Dinh <mibodhi@gmail.com>, Simon Glass <sjg@chromium.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Michal Simek <michal.simek@amd.com>, Nam Cao <namcao@linutronix.de>
Subject: Re: [PATCH] bootstd: Allow PXE boot to be disabled
Message-ID: <20251011143713.GI298503@bill-the-cat>
References: <20251010053056.32495-1-mibodhi@gmail.com>
 <20251010142835.GY298503@bill-the-cat>
 <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="GZ4Xcr/TLCrpJT9B"
Content-Disposition: inline
In-Reply-To: <CALeDE9P8VP6YKS1qoz3Dxga+h287GHzRvczCq0YDd4tOJxNXGQ@mail.gmail.com>
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


--GZ4Xcr/TLCrpJT9B
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 01:03:39PM +0100, Peter Robinson wrote:
> On Fri, 10 Oct 2025 at 15:28, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Oct 09, 2025 at 10:29:17PM -0700, Tony Dinh wrote:
> >
> > > Make it possible to disable CMD_PXE.
> > > Remove unnecessary PXE_UTILS selection in BOOTMETH_EXTLINUX config.
> > > In extlinux_boot(), invoke pxe utils only when
> > > CONFIG_BOOTMETH_EXTLINUX_PXE is enabled.
> > >
> > > This patch results in about 9K reduction in image size when
> > > PXE boot is disabled.
> > >
> > > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > > ---
> > >
> > >  boot/Kconfig             |  3 +--
> > >  boot/bootmeth_extlinux.c | 18 ++++++++++--------
> > >  2 files changed, 11 insertions(+), 10 deletions(-)
> >
> > Is some part of the symbol logic here wrong? A challenge is that "PXE"
> > is also where the logic to parse extlinux.conf style files came from,
> > and I thought we had split those two out. And then there's this:
> >
> > >
> > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > index 2993cd7f9ba..403ce4c3d46 100644
> > > --- a/boot/Kconfig
> > > +++ b/boot/Kconfig
> > > @@ -421,10 +421,10 @@ config BOOT_DEFAULTS_CMDS
> > >       select CMD_PART if PARTITIONS
> > >       select CMD_DHCP if CMD_NET
> > >       select CMD_PING if CMD_NET
> > > -     select CMD_PXE if CMD_NET
> > >       select CMD_BOOTI if ARM64
> > >       select CMD_BOOTZ if ARM && !ARM64
> > >       imply CMD_MII if NET
> > > +     imply CMD_PXE if CMD_NET
> >
> > This is one of the things where defaults isn't supposed to be so easy to
> > get out of. How many platforms are you wanting to then disable CMD_PXE
> > on to save space?
>=20
> PXE is generally being removed in a lot of cases as it's not
> considered secure and now we have HTTP Boot there are other means of
> doing network booting so I think we'll see more and more situations
> where we want to disable PXE.
>=20
> This is actually something I've been meaning to look at so it's
> something I would love to see :)

And in the world where we also can't just remove ATAGS support because
distros (Debian at least) still boots some modern platforms via ATAGS +
appended device tree, the high level options for "boot this anywhere"
need to perhaps be different from "very modern requirements only
distro". I'm not objecting to be clear.

--=20
Tom

--GZ4Xcr/TLCrpJT9B
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaOprlQAKCRAr4qD1Cr/k
Cg5uAQDs7tTXuXHL5C8eH5NJplATu2HA0vvREPrMImH58O3slwD9G20pt9TzSxkR
Mw9nLaFEZbeU+XjCqDrlBgZPh+urdg8=
=924u
-----END PGP SIGNATURE-----

--GZ4Xcr/TLCrpJT9B--
