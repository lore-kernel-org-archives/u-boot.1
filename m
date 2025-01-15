Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35E44C02183
	for <u-boot@archiver.kernel.org>; Wed, 15 Jan 2025 21:37:06 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5C59C80737;
	Wed, 15 Jan 2025 22:36:28 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dLUo4Hws";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8CD018060C; Wed, 15 Jan 2025 22:24:50 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4F1280214
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 22:24:47 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6dd1b895541so6629226d6.0
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 13:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736976287; x=1737581087; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=9v9TkXYLJM+79YaMmznjSW6LZ8zvzvPqemnhHT+lmfE=;
 b=dLUo4HwsRWZKZoHWjoiGIvbJiFwGSEZN9nHCheroKqlnjVOe20Wml8XElmArYA/qxk
 DkNp460LakRTziRAQcg198i8DUyWrHn6eN30o2UFYczvukGDaTK/XqmSqJTs/L6XBXU+
 COOSAGSexlqZZ3NwrYiIng0i5mD2EebGcaqq8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736976287; x=1737581087;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9v9TkXYLJM+79YaMmznjSW6LZ8zvzvPqemnhHT+lmfE=;
 b=ZGcRhODq7J2gc/3ox7CaKAjqce0mrqIzTrw9DXfTy5Ic5Grf8wMLKr1ybdOrI0HwGz
 Nh1uDW/kKDHOtTG3sjMM8AWd0g/JjiXjwAmKmNZy0Xi9GxmOZi1hX+5TzOX8Od9hQvde
 JFxL5ra+F3pGw0xQRdIG8F7W7I4iZmbBrUAZBF9reMZmdW9niwsBJxXjZ00MRj2ETM33
 L9YPFQI5csfNxuLbpDAwdgv59GwjbCElqr+32mrFyR2sgqoR18vgMmVAZYv5hbinxlZu
 XYmEOHaUJ4B5I3v49lHd+X6qkvmgqMlWHKcGtd2KgihJdOz4WRnVCF1CavSZUOlngCLh
 yxYQ==
X-Gm-Message-State: AOJu0YzSHWzREjYQzix7ILd+cJXD+JIuvYdDtI1tYN+Xmvi/kNGa3zjF
 eztZBFZOwk/yd+wOy1FDD6ozgHj1tPcY4agbd1nXD6S6HLHce3JmqrG7T38bsbQ=
X-Gm-Gg: ASbGncubORAgyk0hG3dZRl2ziAyIugUg0SahXugprxMuzymdmD5uVSe7hRLu1uU3NGT
 ++WWwtpoiao+zBhL3w4DX6CxYut1t99JlvqyXmSADQW/8GTKa2QaYqadG9EURNi/0kvv05VELZO
 khrd9oqiXhM5CYkaGzSU+sYvex0/d0yRQNOkeTCi/VqUVYuZz1EAWKbZp4274raI7Vts512Un5A
 taEiHpeQDwtiBBojuJrwvWkikhDAMaaOrZnbr7xJ5OO0GdEV8zMgA==
X-Google-Smtp-Source: AGHT+IEjB4o/vnO0zefbw8GiFgjk3Reb0/jDg5FRN0/kRge08yEhsoMkD1g4dnvLwvBXn8BdDIVVKQ==
X-Received: by 2002:ad4:5943:0:b0:6d4:25c4:e775 with SMTP id
 6a1803df08f44-6df9b1ea4d1mr408718786d6.15.1736976286701; 
 Wed, 15 Jan 2025 13:24:46 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dfade887cbsm69820096d6.96.2025.01.15.13.24.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 13:24:45 -0800 (PST)
Date: Wed, 15 Jan 2025 15:24:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>, Tony Dinh <mibodhi@gmail.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
Message-ID: <20250115212439.GD3476@bill-the-cat>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6Dg4XbRvtT9VWFLs"
Content-Disposition: inline
In-Reply-To: <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 15 Jan 2025 22:36:25 +0100
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


--6Dg4XbRvtT9VWFLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 06:55:45AM -0700, Simon Glass wrote:
> Hi,
>=20
> On Mon, 4 Nov 2024 at 10:51, Simon Glass <sjg@chromium.org> wrote:
> >
> > This series provides a way to keep track of the images used in bootstd,
> > including the type of each image.
> >
> > At present this is sort-of handled by struct bootflow but in quite an
> > ad-hoc way. The structure has become quite large and is hard to query.
> > Future work will be able to reduce its size.
> >
> > Ultimately the 'bootflow info' command may change to also show images as
> > a list, but that is left for later, as this series is already fairly
> > long. So for now, just introduce the concept and adjust bootstd to use
> > it, with a simple command to list the images.
> >
> > This series includes various alist enhancements, to make use of this new
> > data structure a little easier.
> >
> > Changes in v3:
> > - Add a helper in bootflow
> > - Add a new patch supporting ad-hoc bootflows
> > - Add new patch to export bootdev_get_from_blk()
> > - Add new patch to record loaded files in an ad-hoc bootflow
> > - Update bootstd_add_bootflow() to return the element number
> > - Use the helper function
> >
> > Changes in v2:
> > - Add an image type extension in bootflow.h
> > - Change the tag to bootmeth_efi
> > - Drop patches already applied
> > - Drop patches which add new image types
> > - Update to use a new image-type enum in bootflow.h
> > - Use the word 'feature' instead of 'hack'
> >
> > Simon Glass (19):
> >   bootstd: Move bootflow-adding to bootstd
> >   bootstd: Move bootflow-clearing to bootstd
> >   bootstd: Add a function to get bootstd only if available
> >   bootstd: Drop the bootdev-specific list of bootflows
> >   bootstd: Move the bootflow list into an alist
> >   bootstd: Maintain a list of images
> >   bootstd: Update bootmeth_alloc_file() to record images
> >   boot: pxe: Drop the duplicate comment on get_pxe_file()
> >   bootmeth_efi: Simplify reading files by using the common function
> >   bootmeth: Update the read_file() method to include a type
> >   bootmeth_efi: Check the filename-allocation in the network path
> >   boot: Update extlinux pxe_getfile_func() to include type
> >   boot: Update pxe bootmeth to record images
> >   Update bootmeth_alloc_other() to record images
> >   bootstd: Update cros bootmeth to record images
> >   bootstd: Add a simple command to list images
> >   bootstd: Export bootdev_get_from_blk()
> >   bootstd: Add the concept of an ad-hoc bootflow
> >   fs: Record loaded files in an ad-hoc bootflow
> >
> >  boot/bootdev-uclass.c            |  78 ++++++-------------
> >  boot/bootflow.c                  |  77 +++++++++++++++----
> >  boot/bootmeth-uclass.c           |  29 +++++--
> >  boot/bootmeth_android.c          |   3 +-
> >  boot/bootmeth_cros.c             |  17 ++++-
> >  boot/bootmeth_efi.c              |  16 ++--
> >  boot/bootmeth_efi_mgr.c          |   3 +-
> >  boot/bootmeth_extlinux.c         |   7 +-
> >  boot/bootmeth_pxe.c              |  10 ++-
> >  boot/bootmeth_qfw.c              |   3 +-
> >  boot/bootmeth_sandbox.c          |   3 +-
> >  boot/bootmeth_script.c           |   7 +-
> >  boot/bootstd-uclass.c            | 104 +++++++++++++++++++++++--
> >  boot/pxe_utils.c                 |  36 ++++-----
> >  boot/vbe_simple.c                |   5 +-
> >  cmd/Kconfig                      |   9 +++
> >  cmd/Makefile                     |   1 +
> >  cmd/bootdev.c                    |   2 +-
> >  cmd/bootflow.c                   |  11 +--
> >  cmd/bootstd.c                    |  65 ++++++++++++++++
> >  cmd/pxe.c                        |   2 +-
> >  cmd/sysboot.c                    |   6 +-
> >  doc/develop/bootstd/overview.rst |  24 +++++-
> >  doc/usage/cmd/bootstd.rst        |  79 +++++++++++++++++++
> >  doc/usage/index.rst              |   1 +
> >  fs/fs.c                          |  15 ++++
> >  include/bootdev.h                |  36 +++------
> >  include/bootflow.h               |  88 ++++++++++++++++++---
> >  include/bootmeth.h               |  22 ++++--
> >  include/bootstd.h                |  69 ++++++++++++++++-
> >  include/pxe_utils.h              |  14 +++-
> >  test/boot/bootflow.c             | 126 +++++++++++++++++++++++++++++++
> >  test/py/tests/test_ut.py         |   3 +-
> >  33 files changed, 788 insertions(+), 183 deletions(-)
> >  create mode 100644 cmd/bootstd.c
> >  create mode 100644 doc/usage/cmd/bootstd.rst
> >
> > --
> > 2.34.1
> >
>=20
> patchwork link: https://patchwork.ozlabs.org/project/uboot/list/?series=
=3D433068
>=20
> What is the status of this series please?

So, for v4 of this series, most arm64 platforms grow by ~1KiB (a few are
2, a few are a bit less than 1). 32bit ARM is similar but now mx6sabresd
doesn't build in CI (there's some embedded path names that now overflow,
try make O=3D/tmp/1/2/3/4/5/6/7/8/9/10/mx6sabresd mx6sabresd_config all).
For size changes, really most architectures are like that, so perhaps
it's worth stepping back again and asking where this should be default
enabled. For the mx6sabresd part, if we drop the recording for ad-hoc
(which I think you had suggested at some point since I wasn't sure about
that direction), everything builds at least.

--=20
Tom

--6Dg4XbRvtT9VWFLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeIJ44ACgkQFHw5/5Y0
tyxvBQv+NTsX3+kJOmUNCpnVNB387gqhK0PFxbhy4+vHNH3odu7NaylIpLblKgoG
PqbEanwhInzI1ftVX7qecymT8EfcHjlQHAVDL4VoYJo1dXj+4lunV+CEQ4HMOtC+
obaiLR9nmLHTsOf93uZZh7rNwiIoWPHbQ3DRdruvRcQLRCSFyaM1vqhESlyXeQyt
apxixOp371kmVPlix3DErgbYiwojPP6rdBXvDTSqU9XTY/+aFJi4SoSqSytKBzV9
6rpvjSxBmYRwMaegJ6wocfBLY7AHaGkCEERfIygnj5IyKQX365xx8/jVhMO9zW+2
HEieWY8Pw7hx5NfMjabbUEmlqmlGX8o6/RdNFcZfww7YKQ27a5yMuKwHHjn2MVMj
mJD+X8V/+M+M2FYyqPusryTObbDVAkmUf4OxGwZ4GDOt+EmuimgBvBlCtFn+mrFX
R5sN3rMHEcW/eIBSiB2OeUWgI6C3SBxU82YWFOAshsnubAaH0O+Sc15i+CzZHs/j
biHFHyjL
=PJ+Q
-----END PGP SIGNATURE-----

--6Dg4XbRvtT9VWFLs--
