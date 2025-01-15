Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECF12C02183
	for <u-boot@archiver.kernel.org>; Thu, 16 Jan 2025 01:14:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 72449806FB;
	Thu, 16 Jan 2025 02:14:40 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TF9FGtBn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1C72A806D4; Thu, 16 Jan 2025 00:32:09 +0100 (CET)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 682188033D
 for <u-boot@lists.denx.de>; Thu, 16 Jan 2025 00:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-46c8474d8daso3395751cf.3
 for <u-boot@lists.denx.de>; Wed, 15 Jan 2025 15:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1736983925; x=1737588725; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ddP6tR1xhT5Z5Er8hOxtqFFAOej6L9NlDs0mGz3ahUw=;
 b=TF9FGtBnfdO9ei/WSNXQ7yRbRTMRq2H8CXAySM0tixOaavkauu+Id5h2yq5rpkAhUe
 FMpmiJzfk6IhYrEZ98UFOF1dYiwytSp2QEVbLkur+zFnVBKJ4J54o7BEQerQNzT0QgBQ
 d67ZljVTa5gSnJhTl71y57yZyE1N68RDcLFeo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736983925; x=1737588725;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ddP6tR1xhT5Z5Er8hOxtqFFAOej6L9NlDs0mGz3ahUw=;
 b=UwUWLNL6IbXnT5kz1niXvtQ0/qXdBayaY+IL/rMfaQI6p/712OBCmZjikmKlFpkOpA
 ydh7AyudCxOwz9sSiRLs01MH5ZygdVrPWkQDn1tTnmwJ23+fTKTbHX36oy81DOkOJ215
 PVwQzFz+3aRjR6/J9eTEqQDYMxvpZYTEQGRNoCmL51rq8lYN/xGkB7tZh0SFB3By8hUf
 8wCKPMi5a4oY5bMg2VLKEBYRa/mNo+h7E4PQm1SMNQjfYpcwMFhNIoKPdvBYClQ6HNEd
 ulHSQ9+M9pa4JUZtzjd8ysyLXjr9rjf3DBcKe9CQ7Bp8cWOGkqViOyzJcR8L4hAMG1Gd
 Q5HA==
X-Gm-Message-State: AOJu0YyZXNs2CRBmMPpEMGEGZAwQisw5izr0l6PsPmPoIA+RKY2Ahroj
 NTJSmFvLxQAZln4gB4MW1psZwBwHxXKqyceilwHWiorPYbminVglqNKHVcwWg5s=
X-Gm-Gg: ASbGncv+Ii3Ru2Dk3PTw+0cjZB+shUVoOGGgW3P9mzIcNYtebODwny2S0DbRR6ntJmn
 xWqa/25rMANfD483B99bOIzJTojhX7FrO2wsJVbGrh5XrT8AsFnbsQgavU03GJ1xpYebS27+VB9
 B194znaX87NDD7Zf/UYpZrRrFfzKE9s+X1knPUPMz7fubu4XRdF/tKpBl5IUqYTe17EIgYpEYle
 lcNt1DhMnZAs9CVMNoNKvTLrSXEJk9NpZwkQcsi/1NosfXZoOn61Q==
X-Google-Smtp-Source: AGHT+IEtCnhz9Eek6kNyFHErqOQ4sCoRyV+ADhMgU+m4cNoXK/MUxYeqO/nz/u7rb0PR71pViKrudA==
X-Received: by 2002:a05:622a:1808:b0:467:8342:d0d5 with SMTP id
 d75a77b69052e-46c70fca2a3mr533961521cf.2.1736983925129; 
 Wed, 15 Jan 2025 15:32:05 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46c873cddfesm69552591cf.57.2025.01.15.15.31.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 15:32:03 -0800 (PST)
Date: Wed, 15 Jan 2025 17:31:57 -0600
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
Message-ID: <20250115233157.GE3476@bill-the-cat>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hTSiEg6eBgDf2QpO"
Content-Disposition: inline
In-Reply-To: <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Thu, 16 Jan 2025 02:14:38 +0100
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


--hTSiEg6eBgDf2QpO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 04:14:27PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 15 Jan 2025 at 14:24, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Jan 15, 2025 at 06:55:45AM -0700, Simon Glass wrote:
> > > Hi,
> > >
> > > On Mon, 4 Nov 2024 at 10:51, Simon Glass <sjg@chromium.org> wrote:
> > > >
> > > > This series provides a way to keep track of the images used in boot=
std,
> > > > including the type of each image.
> > > >
> > > > At present this is sort-of handled by struct bootflow but in quite =
an
> > > > ad-hoc way. The structure has become quite large and is hard to que=
ry.
> > > > Future work will be able to reduce its size.
> > > >
> > > > Ultimately the 'bootflow info' command may change to also show imag=
es as
> > > > a list, but that is left for later, as this series is already fairly
> > > > long. So for now, just introduce the concept and adjust bootstd to =
use
> > > > it, with a simple command to list the images.
> > > >
> > > > This series includes various alist enhancements, to make use of thi=
s new
> > > > data structure a little easier.
> > > >
> > > > Changes in v3:
> > > > - Add a helper in bootflow
> > > > - Add a new patch supporting ad-hoc bootflows
> > > > - Add new patch to export bootdev_get_from_blk()
> > > > - Add new patch to record loaded files in an ad-hoc bootflow
> > > > - Update bootstd_add_bootflow() to return the element number
> > > > - Use the helper function
> > > >
> > > > Changes in v2:
> > > > - Add an image type extension in bootflow.h
> > > > - Change the tag to bootmeth_efi
> > > > - Drop patches already applied
> > > > - Drop patches which add new image types
> > > > - Update to use a new image-type enum in bootflow.h
> > > > - Use the word 'feature' instead of 'hack'
> > > >
> > > > Simon Glass (19):
> > > >   bootstd: Move bootflow-adding to bootstd
> > > >   bootstd: Move bootflow-clearing to bootstd
> > > >   bootstd: Add a function to get bootstd only if available
> > > >   bootstd: Drop the bootdev-specific list of bootflows
> > > >   bootstd: Move the bootflow list into an alist
> > > >   bootstd: Maintain a list of images
> > > >   bootstd: Update bootmeth_alloc_file() to record images
> > > >   boot: pxe: Drop the duplicate comment on get_pxe_file()
> > > >   bootmeth_efi: Simplify reading files by using the common function
> > > >   bootmeth: Update the read_file() method to include a type
> > > >   bootmeth_efi: Check the filename-allocation in the network path
> > > >   boot: Update extlinux pxe_getfile_func() to include type
> > > >   boot: Update pxe bootmeth to record images
> > > >   Update bootmeth_alloc_other() to record images
> > > >   bootstd: Update cros bootmeth to record images
> > > >   bootstd: Add a simple command to list images
> > > >   bootstd: Export bootdev_get_from_blk()
> > > >   bootstd: Add the concept of an ad-hoc bootflow
> > > >   fs: Record loaded files in an ad-hoc bootflow
> > > >
> > > >  boot/bootdev-uclass.c            |  78 ++++++-------------
> > > >  boot/bootflow.c                  |  77 +++++++++++++++----
> > > >  boot/bootmeth-uclass.c           |  29 +++++--
> > > >  boot/bootmeth_android.c          |   3 +-
> > > >  boot/bootmeth_cros.c             |  17 ++++-
> > > >  boot/bootmeth_efi.c              |  16 ++--
> > > >  boot/bootmeth_efi_mgr.c          |   3 +-
> > > >  boot/bootmeth_extlinux.c         |   7 +-
> > > >  boot/bootmeth_pxe.c              |  10 ++-
> > > >  boot/bootmeth_qfw.c              |   3 +-
> > > >  boot/bootmeth_sandbox.c          |   3 +-
> > > >  boot/bootmeth_script.c           |   7 +-
> > > >  boot/bootstd-uclass.c            | 104 +++++++++++++++++++++++--
> > > >  boot/pxe_utils.c                 |  36 ++++-----
> > > >  boot/vbe_simple.c                |   5 +-
> > > >  cmd/Kconfig                      |   9 +++
> > > >  cmd/Makefile                     |   1 +
> > > >  cmd/bootdev.c                    |   2 +-
> > > >  cmd/bootflow.c                   |  11 +--
> > > >  cmd/bootstd.c                    |  65 ++++++++++++++++
> > > >  cmd/pxe.c                        |   2 +-
> > > >  cmd/sysboot.c                    |   6 +-
> > > >  doc/develop/bootstd/overview.rst |  24 +++++-
> > > >  doc/usage/cmd/bootstd.rst        |  79 +++++++++++++++++++
> > > >  doc/usage/index.rst              |   1 +
> > > >  fs/fs.c                          |  15 ++++
> > > >  include/bootdev.h                |  36 +++------
> > > >  include/bootflow.h               |  88 ++++++++++++++++++---
> > > >  include/bootmeth.h               |  22 ++++--
> > > >  include/bootstd.h                |  69 ++++++++++++++++-
> > > >  include/pxe_utils.h              |  14 +++-
> > > >  test/boot/bootflow.c             | 126 +++++++++++++++++++++++++++=
++++
> > > >  test/py/tests/test_ut.py         |   3 +-
> > > >  33 files changed, 788 insertions(+), 183 deletions(-)
> > > >  create mode 100644 cmd/bootstd.c
> > > >  create mode 100644 doc/usage/cmd/bootstd.rst
> > > >
> > > > --
> > > > 2.34.1
> > > >
> > >
> > > patchwork link: https://patchwork.ozlabs.org/project/uboot/list/?seri=
es=3D433068
> > >
> > > What is the status of this series please?
> >
> > So, for v4 of this series, most arm64 platforms grow by ~1KiB (a few are
> > 2, a few are a bit less than 1). 32bit ARM is similar but now mx6sabresd
> > doesn't build in CI (there's some embedded path names that now overflow,
> > try make O=3D/tmp/1/2/3/4/5/6/7/8/9/10/mx6sabresd mx6sabresd_config all=
).
> > For size changes, really most architectures are like that, so perhaps
> > it's worth stepping back again and asking where this should be default
> > enabled. For the mx6sabresd part, if we drop the recording for ad-hoc
> > (which I think you had suggested at some point since I wasn't sure about
> > that direction), everything builds at least.
>=20
> Thanks for looking at it. So what do you think about dropping those
> last two patches and applying the rest? The increase is about 416
> bytes on pinecube (Thumb2). Quite a bit of this seems to be bringing
> alist which is something of a one-off hit:
>=20
>                  alist_ensure_ptr                             -      64  =
   +64
>                  alist_calc_index                             -      32  =
   +32
>                  alist_add_ptr                                -      26  =
   +26
>                  alist_update_end                             -      18  =
   +18
>                  alist_empty                                  -       6  =
    +6
>                  alist_add_placeholder                        -       6  =
    +6
>=20
> Then I can use the final two patches as the start of the series to
> finish off ad-hoc images.

I was thinking just patch #20, but we can drop 19 and 20 instead, sure.

> As to default-enabled, moving bootflow to an alist isn't really
> something we can disable.

I'm referring to the whole bootmeth/bootflow/etc thing. Is this going to
be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32bit ARM is
a harder question there, which is also where this particular overflow
was.

--=20
Tom

--hTSiEg6eBgDf2QpO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeIRWkACgkQFHw5/5Y0
tyz/jAwAhRDW00CZ4UlT0x6pybBITzuTmbkOSjdPYHMw8Oc0B3c8mY9C1vOlkXLn
bch/YHMvuTjSNYRiGc/WBdRIwF6/h2HfRGKjnGpxjRZKnX0PqgT4xljyBslp5P8O
CQjY6hvj5gbKSMN+2iGEorzh4Sbv97vywMyWMikqOZA8mXMN01eKglzk+tq0NkWH
QZBHe5tY5DD3oYsEQYZX7zgr/3ryN/Tl/CescznRRlhGqfbCglrGT3W3246bnq1R
PKY1dNJq8ZGNP8ik24+QyGhAsNLuvCGv8cj1zYIuG6UGjXl+Td9vxsRsXFfyDkC4
ybsJ3Co3QxO0am39haj+8fRByNmzlgpIEOZxl2KClLwn9dtXdVjlRctqFA8kbS2s
mLpAKZCdMZr7QcPKh5+ipOuxvb4ao+MSRIQo0HRAcfWAyVyfTXBPWW9OcJtoLqhn
Ro3IP1RH/zBcjU/+WESZc45fTY0Fi8NBJWcqmzOhIxwd/TEJPQkZ2P+0YbYqw+lT
2ZYkDfY+
=ijjD
-----END PGP SIGNATURE-----

--hTSiEg6eBgDf2QpO--
