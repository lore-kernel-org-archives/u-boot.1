Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02F1C30658
	for <u-boot@archiver.kernel.org>; Tue,  2 Jul 2024 19:23:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E3EC788757;
	Tue,  2 Jul 2024 21:23:48 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hhW5G305";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D281788757; Tue,  2 Jul 2024 21:23:47 +0200 (CEST)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7ED9B883AC
 for <u-boot@lists.denx.de>; Tue,  2 Jul 2024 21:23:45 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3d639f967b0so1670615b6e.0
 for <u-boot@lists.denx.de>; Tue, 02 Jul 2024 12:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719948224; x=1720553024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b50iEv1gggVkFkpZQGWoX3Q3qbABm/6L2Ad8eq/rdCc=;
 b=hhW5G305hFossMRv3bq2cSU0YH13LsxM7KTVYUxE9Z7dl7ZB2rwk+TxjmUWICVRwH2
 TksTWh7j0NFMzV88THXSb11kfX5SO3Cgd7XoMQr9pQtTSdGydCoRZJMfL6SrNxc4WrYK
 o1epiwyWtR18qo5x0qqrZ784paFtxzBfq8pb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719948224; x=1720553024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b50iEv1gggVkFkpZQGWoX3Q3qbABm/6L2Ad8eq/rdCc=;
 b=UZRzdQ3yXJZ/bIT0qT8411iZEcstXKix02uub+lhfsilJvzv5i3tX89M48SWmDkGuh
 YIXXuLb6TFoBfgZ15l3eCr2x/i2iWwgSkM8ZGSGD8N05ABpQv/ijIr2Ks7a3QFe5BLNH
 Dc0igQK81vhz36MARfWmSjqnBnB/R3M5/hrQuLrUgMLV99JQBty8oF77NSqBS7+Yai0b
 /TkBl3eh3vMEPtK3AXaipHtbOZ2LjT842yqkPwdFpo1dHXv/8qTjSwGjbjGoyoKGdcNG
 I4RM46tUKIXVtkOjJ9fDE2xGyk809oVj3uzhB4PjrlrzJ/YOY2mryG814ykSUsZuVadc
 1tJw==
X-Gm-Message-State: AOJu0YxzCQugqvNhrBsvSFJDOA6upSD6a8fT6LJTFeL2Nx/2t7xRhlnP
 GIJsDVw38o6XS+7tAvZ+kgRIHPq4eknu2NrmK79IKVasXoYHc408+sdDI9C+7sk=
X-Google-Smtp-Source: AGHT+IHgpev92LxNZkupgCushRhXzpxW95h7j7NPrGIUflrBHS/ACIFtxWHMZ7i1SD2tBiiIpdFqOQ==
X-Received: by 2002:a05:6808:189c:b0:3d5:6552:66da with SMTP id
 5614622812f47-3d6b4de24d8mr8357005b6e.36.1719948224057; 
 Tue, 02 Jul 2024 12:23:44 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-45.totalplay.net.
 [189.203.106.45]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3d62fa39442sm1800490b6e.38.2024.07.02.12.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jul 2024 12:23:43 -0700 (PDT)
Date: Tue, 2 Jul 2024 13:23:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: u-boot@lists.denx.de, Simon Glass <sjg@chromium.org>,
 Marek Vasut <marex@denx.de>, Fabio Estevam <festevam@gmail.com>,
 Dragan Simic <dsimic@manjaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Avri Altman <avri.altman@wdc.com>
Subject: Re: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
Message-ID: <20240702192341.GR38804@bill-the-cat>
References: <20240531153635.246154-1-tharvey@gateworks.com>
 <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="toki3zb0+3V/KbEi"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
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


--toki3zb0+3V/KbEi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 02, 2024 at 11:14:15AM -0700, Tim Harvey wrote:
> On Fri, May 31, 2024 at 8:36=E2=80=AFAM Tim Harvey <tharvey@gateworks.com=
> wrote:
> >
> > Modern eMMC v4+ devices have multiple hardware partitions per the JEDEC
> > specification described as:
> >  Boot Area Partition 1
> >  Boot Area Partition 2
> >  RPMB Partition
> >  General Purpose Partition 1
> >  General Purpose Partition 2
> >  General Purpose Partition 3
> >  General Purpose Partition 4
> >  User Data Area
> >
> > These are referenced by fields in the PARTITION_CONFIG register
> > (Extended CSD Register 179) which is defined as:
> > bit 7: reserved
> > bit 6: BOOT_ACK
> >   0x0: No boot acknowledge sent (default
> >   0x1: Boot acknowledge sent during boot operation Bit
> > bit 5:3: BOOT_PARTITION_ENABLE
> >   0x0: Device not boot enabled (default)
> >   0x1: Boot Area partition 1 enabled for boot
> >   0x2: Boot Area partition 2 enabled for boot
> >   0x3-0x6: Reserved
> >   0x7: User area enabled for boot
> > bit 2:0 PARTITION_ACCESS
> >   0x0: No access to boot partition (default)
> >   0x1: Boot Area partition 1
> >   0x2: Boot Area partition 2
> >   0x3: Replay Protected Memory Block (RPMB)
> >   0x4: Access to General Purpose partition 1
> >   0x5: Access to General Purpose partition 2
> >   0x6: Access to General Purpose partition 3
> >   0x7: Access to General Purpose partition 4
> >
> > Note that setting PARTITION_ACCESS to 0x0 results in selecting the User
> > Data Area partition.
> >
> > You can see above that the two fields BOOT_PARTITION_ENABLE and
> > PARTITION_ACCESS do not use the same enumerated values.
> >
> > U-Boot uses a set of macros to access fields of the PARTITION_CONFIG
> > register:
> > EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
> > EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
> > EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
> > EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)
> >
> > EXT_CSD_BOOT_ACK(x)             (x << 6)
> > EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
> > EXT_CSD_PARTITION_ACCESS(x)     (x << 0)
> >
> > EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
> > EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
> > EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)
> >
> > There are various places in U-Boot where the BOOT_PARTITION_ENABLE field
> > is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to a
> > hardware partition consistent with the definition of the
> > PARTITION_ACCESS field used by the various mmc_switch incarnations.
> >
> > To add some sanity to the distinction between BOOT_PARTITION_ENABLE
> > (used to specify the active device on power-cycle) and PARTITION_ACCESS
> > (used to switch between hardware partitions) create two enumerated types
> > and use them wherever struct mmc * part_config is used or the above
> > macros are used.
> >
> > Additionally provide arrays of the field names and allow those to be
> > used in the 'mmc partconf' command and in board support files.
> >
> > The first patch adds enumerated types and makes use of them which
> > represents no compiled code change.
> >
> > The 2nd patch adds the array of names and uses them in the 'mmc
> > partconf' command.
> >
> > The 3rd patch uses the array of hardware partition names in a board
> > support file to show what emmc hardware partition U-Boot is being loaded
> > from.
> >
> > I'm sending this as a series this time around as previously it was
> > repsented as two different patches.
> >
> > Tim Harvey (3):
> >   mmc: use an enumerated type to represent PARTITION_CONFIG fields
> >   mmc: allow use of hardware partition names for mmc partconf
> >   venice: show emmc boot hardware partition
> >
> >  arch/arm/mach-imx/image-container.c | 10 ++++-----
> >  arch/arm/mach-sunxi/board.c         |  2 +-
> >  board/gateworks/venice/spl.c        | 20 ++++++++++++-----
> >  board/gateworks/venice/venice.c     | 22 +++++++++---------
> >  board/purism/librem5/librem5.c      |  4 ++--
> >  board/storopack/smegw01/smegw01.c   |  4 ++--
> >  cmd/mmc.c                           | 27 ++++++++++++++++++----
> >  cmd/mvebu/bubt.c                    |  4 ++--
> >  common/spl/spl_mmc.c                |  4 ++--
> >  drivers/mmc/mmc.c                   | 35 +++++++++++++++++++++++++++++
> >  include/mmc.h                       | 26 +++++++++++++++++++++
> >  11 files changed, 123 insertions(+), 35 deletions(-)
> >
> > --
> > 2.25.1
> >
>=20
> Greetings,
>=20
> Is there any feedback on this series? I got feedback from several
> people on my first attempt (cc'd) but nothing on this version.

Jaehoon, will you have time to review and pick this up, now that the
merge window is open? Thanks.

--=20
Tom

--toki3zb0+3V/KbEi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmaEU7YACgkQFHw5/5Y0
tyy6ZQv/c8NVPaqyGldEhx/4nOsfzny42ThUBmnBJ2gTwgIOS7P6+gOLrXUBasIL
X3w+xdOFlsm1uJ+hckG0U7JeT5gmerHSnxrRYbfd/YLqcQtVWaHF0b8zbX5S81Gl
MNBzE6NxNTVSt7gsPIEUuN2+nilnXCgyAM/ci342fE9sdfYjywPq5q6dHt7uR339
z1j+szMsauYOxgkyI6p98vJyztLRey3do4qWyDCJptXhNYqbzlRLpYiQ99+CK42R
PTCOov13driDuC5AaJqbmIlnsmx422WHv+drwe/KMfUeiQubTtkQojJeovxrnn6B
OA29CaEFxr0PGpxyvAolF+c5Rd7aQh+tWljKdcaFQcFVKdxsBajg9kX9WLhy+CZB
wiHlCblKPYE7ajhp7GHp+G+5axuvXXTBZXf/H/RzzERu+kAPzHLMTjU3q6NbELLY
y+FN+g2tQKgsxzpS648J1+rEWSdLAElOGn05rvXRWFXYhETQAkTm800oP6C13fA7
2Z6bfCwz
=654N
-----END PGP SIGNATURE-----

--toki3zb0+3V/KbEi--
