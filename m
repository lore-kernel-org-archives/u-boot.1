Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1D02C3ABAA
	for <u-boot@archiver.kernel.org>; Mon,  5 May 2025 16:41:52 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3BDB5820EB;
	Mon,  5 May 2025 18:41:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="mWjjzunO";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D16D982161; Mon,  5 May 2025 18:41:49 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 86BDC820E8
 for <u-boot@lists.denx.de>; Mon,  5 May 2025 18:41:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-6060200710bso2130444eaf.3
 for <u-boot@lists.denx.de>; Mon, 05 May 2025 09:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1746463306; x=1747068106; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Q3iyA3qmTY7A9Q0eNTeC+JEDkRL6dCtf6idHFYQnZ98=;
 b=mWjjzunODpR0etC/ydUwtuuPf0CSTl5c78H16MgOf1mlaGYoFmJH+KoyY/zTI3Ugdt
 QHmK8kr8CsxH3plPsyjFp89W1R7eAeXiHhdwFlAk/0aHKxX1pluHGhUc/8g90jH52l2y
 YUi5OA96qUSfyTOwF0D3HbEEEinpYLgQZABjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746463306; x=1747068106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q3iyA3qmTY7A9Q0eNTeC+JEDkRL6dCtf6idHFYQnZ98=;
 b=xA5ws8XkZRjkGj4a9vE0g1Oc5LBixVdImXF2VyaHrLOS90aTkwZIH6oW1mDx2MA2US
 NTJ7GDejQMdgT1EyTVDDSbN0urYErNhgz+a4rSEupLEsD8zmzK5gbN4pjh7fuCwGwUOQ
 a3O5/1szrUyztCmrCEnSyYao52ruvPP9KRTCOGKCPTbKBpn1dOoeaBPeeOQZXKt7KHe1
 WlGr7Ct42ZVjm0rERrXaQ0ekzWuEpItkrZbfzLfQqfxfFTuAEf/0Ot7KMHiulRMPnfc7
 t9YfJ29Yqh3jVdlXM/fBjCs+EQ/dJnosH3crzPR0HQ4lwbkqFGU1bt1u6ADP+2tSNkT+
 BqTA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWIz60g86jUzH5QFFSr5I/86INNXkAXqNCEz52KDOGBDmbQwM1auhT1IiFbDYbHvlt5h5I68oo=@lists.denx.de
X-Gm-Message-State: AOJu0Yx8cEXd3vOkPnohJRHlhIU/nAf6xO66VBv/p05JKOFnPI2CHkr7
 ZwnOtYzZQYjMXhfvg3IH8RO2e1KO8cpXrLUXWpk2NZJQlDHczf1MWZTCVUtsn3M=
X-Gm-Gg: ASbGnctISDTYxi0kMv98t9IxbG7cy0Fu1aanV1vZlWnNI+w//wBFSZlblU/3eE66wd3
 nVhgSOJpGfbBNnGGGXRN3fC/UsBdt80n8tyhACecB5mFvRSgLvB+1JJKzoAhC22UgzXnEw39voc
 mj+bWGioISr5RJjPmTcyIaXQCKLh3mSXhryUR5Hrw6M3Ieq0cfPY76UnbtM4swRpntCVea93TUb
 dRJUMa2s3TlyikvwCqDBe01czBMhasNzF01kg/p/XB6cHxuytJ8HS06wnXLNzriiFuL0iElIzU5
 1NYmTcVKkF+hTHhtI3ux6od9KbIduQ1Ig57wguqV6UJGfaCzJT4dNZnqiXUgPlxwPKKGPrQm6p7
 1XA==
X-Google-Smtp-Source: AGHT+IEgS3cU1hrGOjZH5joH6JGokfvBixSW1ULrCSXikzP28DHOroAHqw25efn1eAvAlJ3HgP4PKg==
X-Received: by 2002:a05:6870:8892:b0:2c1:7289:d62a with SMTP id
 586e51a60fabf-2dae8639994mr4110009fac.36.1746463306175; 
 Mon, 05 May 2025 09:41:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2daa0e50b39sm2076254fac.2.2025.05.05.09.41.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 May 2025 09:41:45 -0700 (PDT)
Date: Mon, 5 May 2025 10:41:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julius Lehmann <lehmanju@devpi.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v2 15/18] bootstd: Provide a command to select the
 bootdev order
Message-ID: <20250505164143.GG5430@bill-the-cat>
References: <20250501133726.2627373-1-sjg@chromium.org>
 <20250501133726.2627373-16-sjg@chromium.org>
 <5403d72f-65b3-47f8-912e-d1b64e111f00@cherry.de>
 <CAFLszTh1Sm9ymBDRLqwncaSHyRVYiabsQvd-hUrzLwo2iOvUnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="R7/eTDBx4VW3YqZl"
Content-Disposition: inline
In-Reply-To: <CAFLszTh1Sm9ymBDRLqwncaSHyRVYiabsQvd-hUrzLwo2iOvUnQ@mail.gmail.com>
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


--R7/eTDBx4VW3YqZl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 05, 2025 at 05:37:33PM +0200, Simon Glass wrote:
> Hi Quentin,
>=20
> On Mon, 5 May 2025 at 10:34, Quentin Schulz <quentin.schulz@cherry.de> wr=
ote:
> >
> > Hi Simon,
> >
> > On 5/1/25 3:37 PM, Simon Glass wrote:
> > [...]
> > > diff --git a/boot/bootstd-uclass.c b/boot/bootstd-uclass.c
> > > index 9bee73ead58..294865feb64 100644
> > > --- a/boot/bootstd-uclass.c
> > > +++ b/boot/bootstd-uclass.c
> > > @@ -6,6 +6,8 @@
> > >    * Written by Simon Glass <sjg@chromium.org>
> > >    */
> > >
> > > +#define LOG_CATEGORY UCLASS_BOOTSTD
> > > +
> > >   #include <alist.h>
> > >   #include <blk.h>
> > >   #include <bootdev.h>
> > > @@ -132,6 +134,22 @@ const char *const *const bootstd_get_bootdev_ord=
er(struct udevice *dev,
> > >       return std->bootdev_order;
> > >   }
> > >
> > > +void bootstd_set_bootdev_order(struct udevice *dev, const char **ord=
er_str)
> > > +{
> > > +     struct bootstd_priv *std =3D dev_get_priv(dev);
> > > +     const char **name;
> > > +
> > > +     free(std->bootdev_order);  /* leak; convert to use alist */
> > > +
> >
> > leak? and aren't you using alist already?
>=20
> Not for this, yet.
>=20
> >
> > [...]
> >
> > > diff --git a/doc/usage/cmd/bootdev.rst b/doc/usage/cmd/bootdev.rst
> > > index 98a0f43c580..abede194cba 100644
> > > --- a/doc/usage/cmd/bootdev.rst
> > > +++ b/doc/usage/cmd/bootdev.rst
> > > @@ -13,6 +13,7 @@ Synopsis
> > >
> > >       bootdev list [-p]        - list all available bootdevs (-p to p=
robe)
> > >       bootdev hunt [-l|<spec>] - use hunt drivers to find bootdevs
> > > +    bootdev order [clear] | [<spec> ...]  - view or update bootdev o=
rder
> > >       bootdev select <bm>      - select a bootdev by name
> > >       bootdev info [-p]        - show information about a bootdev
> > >
> > > @@ -78,6 +79,27 @@ To run hunters, specify the name of the hunter to =
run, e.g. "mmc". If no
> > >   name is provided, all hunters are run.
> > >
> > >
> > > +bootdev order
> > > +~~~~~~~~~~~~~
> > > +
> > > +This allows the bootdev order to be examined or set. With no argumen=
t the
> > > +current ordering is shown, one item per line.
> > > +
> > > +The argument can either be 'clear' or a space-separated list of labe=
ls. Each
> > > +label can be the name of a bootdev (e.g. "mmc1.bootdev"), a bootdev =
sequence
> > > +number ("3") or a media uclass ("mmc") with an optional sequence num=
ber (mmc2).
> > > +
> > > +Use `bootdev order clear` to clear any ordering and use the default.
> > > +
> > > +By default, the ordering is defined by the `boot_targets` environmen=
t variable
> > > +or, failing that, the bootstd node in the devicetree ("bootdev-order=
" property).
> > > +If no ordering is provided, then a default one is used.
> > > +
> >
> > Not sure what's the benefit if we can simply set the environment variab=
le?
>=20
> The environment variable is there to maintain backwards compatibility
> with the distro scripts. It now seems that we are unlikely to ever
> drop those, but you never know.

Repeating myself from some other discussion before, it's not just "distro
scripts", managing things with the environment is an intentional
feature, not a backwards compatible legacy thing. Solutions to "boot
this device" that do not have some support for using the environment to
modify things as needed are unlikely to be flexible enough for all use
cases.

--=20
Tom

--R7/eTDBx4VW3YqZl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgY6kcACgkQFHw5/5Y0
tyxiWwwAoPAP47CIjv0hixIK0rm0q5NmokFWtFcWBY9BtfQcndRdM+BYoQtomCFy
1jrUblaaidtUPVrNcfyHui6N86X/m7cKvaoM5mR92bIjB4edW4v3kIOd2pvUdr2B
pNab9QuyfnK4r6iqNF9UrDAS0lnSUNUlMyvABzloInn8F0bp9HlRTTbUSdA1Ynsr
rcAluS+WTi9sWwMreSuRLQYnivdB/Q4a2JH/ip6nIf8ZizmCUILHo27BFb1xWQTM
srwCjUoeEfxwt82913xSWK0HflEGo9U44dqtW7mYthrQQ+jvb7q//6dMXtKK7u8H
zWdnqsKuV7A9gFY5ZAmxNA2l6ZlxypGGmZy1xh0vi6CMGTuDXd73LJE+l57dGvzx
ZYLR5yZ1WxHe+SpSCHo07BEB3lOIjyx1N3AHWThiHg+pS4qC8mdEpsMqSj3oRfpx
nNqkU2A6F/5h7rYrwhPUd0p3A0xLhc+qKRzdEawsVwR5fTNhC8/gnSXn5P0aNWn8
3YcleA2A
=1hz9
-----END PGP SIGNATURE-----

--R7/eTDBx4VW3YqZl--
