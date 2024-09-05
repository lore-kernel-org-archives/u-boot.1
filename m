Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 757AACD98FE
	for <u-boot@archiver.kernel.org>; Thu,  5 Sep 2024 18:14:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id BB73888CB8;
	Thu,  5 Sep 2024 20:14:43 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="k7xYKy48";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0889A885A8; Thu,  5 Sep 2024 20:14:42 +0200 (CEST)
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com
 [IPv6:2607:f8b0:4864:20::1131])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 333B988CC6
 for <u-boot@lists.denx.de>; Thu,  5 Sep 2024 20:14:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6b6b9867f81so10036717b3.1
 for <u-boot@lists.denx.de>; Thu, 05 Sep 2024 11:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725560078; x=1726164878; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Sj1g9fmBE9yhxjRyilmr0K6OwYYF2rp4iK/UmgsMA0=;
 b=k7xYKy48qdgYNvvmDtrnFqUjSD22z9Aq7GbdGlU1DF02OVTTsN5y6M1lwNMrZtqLZs
 wBhXBQ/0YC6UyFVqAcpWBTM1KCyXxvoEsNMDP0VDxR0xmD7x7pLeOH3Tr6gEQCoXZznt
 cAUTd1D0kMYoxMq88AYuxh72TRyPo/1pMJV+g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725560078; x=1726164878;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Sj1g9fmBE9yhxjRyilmr0K6OwYYF2rp4iK/UmgsMA0=;
 b=k5cU9wtJFRaEdSHz5UgxowX1r6DTgjAJCwk7H5kji2ZkwuN7yyntThoxbJsaMX3XEO
 Xro+XvA1j1+iJlvcrosz92HYIugqxVbH758i23SHAEbUqVOUkt/uyR0T4tzI9CIVI3LG
 v8qIcQmIB/WLtGMHEe1e/8TDD6KYZax73Fxzsb2/Xx4W/+OqvMfqFfShcb50v6b4yrWs
 PK/Spvm2MGbSp2ZoJJ+KZr38ypMpmrK6iG5r3e94H8lw1Iy+zjVAcsUBaRyqHYiAq6hg
 qv3sKdqb682OZdkEKX9Vnn2Gv7gqZnfJURaE91kpkQvOrdBG/2+TdtORsTjPags2iELG
 JYkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVbmY8s6vr3mNSwRGPHWxppebw7Z5OOmhvICdOllq4OGzlp9uhYqTaCQci0XAo9tzX/Dbt9A8c=@lists.denx.de
X-Gm-Message-State: AOJu0YwihFliAl170xnvm+lJromrYIv0VRQ+xJBdsUL1JlVnTmnYTaHE
 vN0hPECPfzlaUL2rExifjNudIWx2Jwp6tWPvlQMM3XA/QcjeCerYq/d7f1FnXRg=
X-Google-Smtp-Source: AGHT+IH6+EsYecQpXaMpg+Zgb532UrYoSmiWGaXpkOeFGhygRrewT6LEVMtz5NlkEwlYvY7QEFJ6Pg==
X-Received: by 2002:a05:690c:3704:b0:6d3:8604:1efb with SMTP id
 00721157ae682-6db44dbbd46mr140217b3.12.1725560077856; 
 Thu, 05 Sep 2024 11:14:37 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c5201deedasm9563656d6.25.2024.09.05.11.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2024 11:14:37 -0700 (PDT)
Date: Thu, 5 Sep 2024 12:14:34 -0600
From: Tom Rini <trini@konsulko.com>
To: Tim Harvey <tharvey@gateworks.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Fabio Estevam <festevam@gmail.com>, Dragan Simic <dsimic@manjaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>, Avri Altman <avri.altman@wdc.com>
Subject: Re: [RESEND PATCH v4 0/3] provide names for emmc hardware partitions
Message-ID: <20240905181434.GE2479150@bill-the-cat>
References: <20240531153635.246154-1-tharvey@gateworks.com>
 <CAJ+vNU21x40ysbHUm+6j9xVgVM4ik=TiXFBh13jPJsQs=9E9dQ@mail.gmail.com>
 <20240702192341.GR38804@bill-the-cat>
 <CAJ+vNU2+sYPS3pmOJs66wDc8-uXO0uosa=USRaDUTDHR=6TfOA@mail.gmail.com>
 <CAJ+vNU3vHGrp1gKCrYJYkvQ-SjjpyFSfO5mNeinHL_70v5PgXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="+JqU+DeRRTT+9R7k"
Content-Disposition: inline
In-Reply-To: <CAJ+vNU3vHGrp1gKCrYJYkvQ-SjjpyFSfO5mNeinHL_70v5PgXg@mail.gmail.com>
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


--+JqU+DeRRTT+9R7k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2024 at 11:11:10AM -0700, Tim Harvey wrote:
> On Mon, Aug 12, 2024 at 12:25=E2=80=AFPM Tim Harvey <tharvey@gateworks.co=
m> wrote:
> >
> > On Tue, Jul 2, 2024 at 12:23=E2=80=AFPM Tom Rini <trini@konsulko.com> w=
rote:
> > >
> > > On Tue, Jul 02, 2024 at 11:14:15AM -0700, Tim Harvey wrote:
> > > > On Fri, May 31, 2024 at 8:36=E2=80=AFAM Tim Harvey <tharvey@gatewor=
ks.com> wrote:
> > > > >
> > > > > Modern eMMC v4+ devices have multiple hardware partitions per the=
 JEDEC
> > > > > specification described as:
> > > > >  Boot Area Partition 1
> > > > >  Boot Area Partition 2
> > > > >  RPMB Partition
> > > > >  General Purpose Partition 1
> > > > >  General Purpose Partition 2
> > > > >  General Purpose Partition 3
> > > > >  General Purpose Partition 4
> > > > >  User Data Area
> > > > >
> > > > > These are referenced by fields in the PARTITION_CONFIG register
> > > > > (Extended CSD Register 179) which is defined as:
> > > > > bit 7: reserved
> > > > > bit 6: BOOT_ACK
> > > > >   0x0: No boot acknowledge sent (default
> > > > >   0x1: Boot acknowledge sent during boot operation Bit
> > > > > bit 5:3: BOOT_PARTITION_ENABLE
> > > > >   0x0: Device not boot enabled (default)
> > > > >   0x1: Boot Area partition 1 enabled for boot
> > > > >   0x2: Boot Area partition 2 enabled for boot
> > > > >   0x3-0x6: Reserved
> > > > >   0x7: User area enabled for boot
> > > > > bit 2:0 PARTITION_ACCESS
> > > > >   0x0: No access to boot partition (default)
> > > > >   0x1: Boot Area partition 1
> > > > >   0x2: Boot Area partition 2
> > > > >   0x3: Replay Protected Memory Block (RPMB)
> > > > >   0x4: Access to General Purpose partition 1
> > > > >   0x5: Access to General Purpose partition 2
> > > > >   0x6: Access to General Purpose partition 3
> > > > >   0x7: Access to General Purpose partition 4
> > > > >
> > > > > Note that setting PARTITION_ACCESS to 0x0 results in selecting th=
e User
> > > > > Data Area partition.
> > > > >
> > > > > You can see above that the two fields BOOT_PARTITION_ENABLE and
> > > > > PARTITION_ACCESS do not use the same enumerated values.
> > > > >
> > > > > U-Boot uses a set of macros to access fields of the PARTITION_CON=
FIG
> > > > > register:
> > > > > EXT_CSD_BOOT_ACK_ENABLE                 (1 << 6)
> > > > > EXT_CSD_BOOT_PARTITION_ENABLE           (1 << 3)
> > > > > EXT_CSD_PARTITION_ACCESS_ENABLE         (1 << 0)
> > > > > EXT_CSD_PARTITION_ACCESS_DISABLE        (0 << 0)
> > > > >
> > > > > EXT_CSD_BOOT_ACK(x)             (x << 6)
> > > > > EXT_CSD_BOOT_PART_NUM(x)        (x << 3)
> > > > > EXT_CSD_PARTITION_ACCESS(x)     (x << 0)
> > > > >
> > > > > EXT_CSD_EXTRACT_BOOT_ACK(x) (((x) >> 6) & 0x1)
> > > > > EXT_CSD_EXTRACT_BOOT_PART(x) (((x) >> 3) & 0x7)
> > > > > EXT_CSD_EXTRACT_PARTITION_ACCESS(x) ((x) & 0x7)
> > > > >
> > > > > There are various places in U-Boot where the BOOT_PARTITION_ENABL=
E field
> > > > > is accessed via EXT_CSD_EXTRACT_PARTITION_ACCESS and converted to=
 a
> > > > > hardware partition consistent with the definition of the
> > > > > PARTITION_ACCESS field used by the various mmc_switch incarnation=
s.
> > > > >
> > > > > To add some sanity to the distinction between BOOT_PARTITION_ENAB=
LE
> > > > > (used to specify the active device on power-cycle) and PARTITION_=
ACCESS
> > > > > (used to switch between hardware partitions) create two enumerate=
d types
> > > > > and use them wherever struct mmc * part_config is used or the abo=
ve
> > > > > macros are used.
> > > > >
> > > > > Additionally provide arrays of the field names and allow those to=
 be
> > > > > used in the 'mmc partconf' command and in board support files.
> > > > >
> > > > > The first patch adds enumerated types and makes use of them which
> > > > > represents no compiled code change.
> > > > >
> > > > > The 2nd patch adds the array of names and uses them in the 'mmc
> > > > > partconf' command.
> > > > >
> > > > > The 3rd patch uses the array of hardware partition names in a boa=
rd
> > > > > support file to show what emmc hardware partition U-Boot is being=
 loaded
> > > > > from.
> > > > >
> > > > > I'm sending this as a series this time around as previously it was
> > > > > repsented as two different patches.
> > > > >
> > > > > Tim Harvey (3):
> > > > >   mmc: use an enumerated type to represent PARTITION_CONFIG fields
> > > > >   mmc: allow use of hardware partition names for mmc partconf
> > > > >   venice: show emmc boot hardware partition
> > > > >
> > > > >  arch/arm/mach-imx/image-container.c | 10 ++++-----
> > > > >  arch/arm/mach-sunxi/board.c         |  2 +-
> > > > >  board/gateworks/venice/spl.c        | 20 ++++++++++++-----
> > > > >  board/gateworks/venice/venice.c     | 22 +++++++++---------
> > > > >  board/purism/librem5/librem5.c      |  4 ++--
> > > > >  board/storopack/smegw01/smegw01.c   |  4 ++--
> > > > >  cmd/mmc.c                           | 27 ++++++++++++++++++----
> > > > >  cmd/mvebu/bubt.c                    |  4 ++--
> > > > >  common/spl/spl_mmc.c                |  4 ++--
> > > > >  drivers/mmc/mmc.c                   | 35 +++++++++++++++++++++++=
++++++
> > > > >  include/mmc.h                       | 26 +++++++++++++++++++++
> > > > >  11 files changed, 123 insertions(+), 35 deletions(-)
> > > > >
> > > > > --
> > > > > 2.25.1
> > > > >
> > > >
> > > > Greetings,
> > > >
> > > > Is there any feedback on this series? I got feedback from several
> > > > people on my first attempt (cc'd) but nothing on this version.
> > >
> > > Jaehoon, will you have time to review and pick this up, now that the
> > > merge window is open? Thanks.
> > >
> >
> > Hi Tom,
> >
> > I have not seen any emails from Jaehoon on mainline lists since early M=
ay.
> >
> > Best Regards,
> >
> > Tim
>=20
> Hi Tom,
>=20
> gentle ping here... not sure what you want me to do with this series.

OK, thanks for pinging, again. I'm taking a look at taking this to -next
now. Sorry for the delay and thanks again for your patience and
persistence.

--=20
Tom

--+JqU+DeRRTT+9R7k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbZ9QYACgkQFHw5/5Y0
tyzCNQwAhDibFuVv5r9cFQLHM54Ni0J7BBEtIsi3iDwD5P0/MrHlLmA2uS+vSR15
OCvg7qpbtfC0kOZBTE8ajgP05Ud5krZzVfYaq3VQRDhb1et1Wt/bcXenaVC+s3qd
W3mvVg3Iab+XE9KUImAAK+kJ40I9SJzhFy5tN8x4KwZ0jxKgqPreDGdqkTNELccX
3z/h+CgtrpQ9t0DpgyeovLJecJAj0E5AQjIA/Cs08t3MROd3Y6n4vHJEjjIukQpu
HOoEDDes+YNLTnF/8XwqEqtPwIJYM5+jAnN2fhmboF+oKp55VITgXhU0cgbtf/8b
tDIfUjPXaynWznpKjWzlZy/Q6zb7fjr8n+GmIy3sLl9pICYoHJ2auXtLpp7RSV0x
HlyVhBxntB3IgVJhbLZsLL8zURFjBv6zxl5qvx28IK8S9iRvEiMYVVH1MW7Qz0er
6dyjeEDrHyzU+KggkszzESGFKoKrhzrB/uNIFtA20U5vovxWtzBhItd86pjPqTqu
c/vs8i6w
=az+j
-----END PGP SIGNATURE-----

--+JqU+DeRRTT+9R7k--
