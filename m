Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95626CD4F54
	for <u-boot@archiver.kernel.org>; Fri, 29 May 2026 20:01:22 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EBC9484693;
	Fri, 29 May 2026 22:01:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="CzjJr02t";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E5567846A3; Fri, 29 May 2026 22:01:19 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B847A805D7
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 22:01:17 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7de4be15125so13295772a34.0
 for <u-boot@lists.denx.de>; Fri, 29 May 2026 13:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1780084876; x=1780689676; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BflQpILYNsdV418HEymaoaI5jvicSdyjwWiaN4KjVE0=;
 b=CzjJr02t4IYD6kEJ8l7AIuDgl9553tfhLyH2xF94pGsF4d/SMuuPatWFPNzU1xGHP8
 bRU4hqMeRwcyAIVPrpKXKyZkvRPvmb1WXmpgPHiGTWH5TfIyMZbZleeztDFfsrQwpCq2
 ei7b6S4XxSf8YBpBH22m+6EX+gPBWngWwmyaM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780084876; x=1780689676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BflQpILYNsdV418HEymaoaI5jvicSdyjwWiaN4KjVE0=;
 b=NV2Lew6EZeQFgr1d2rCgojx1y5Jo8PJFt1uLN0QUiZd9nbCJMz4DodZIGx1MOIrz75
 ESq4MTBF29ykJgbYlNc929sGhVIWsctAWPwxWIQJghOtfgrzmJ0wvLhVrGZRBExkvSD7
 80zl8v5yVePSzXPUYCI96zBu2H1GBcq/o8aHqZ3B7wC94KVLLlfT2q8OycRfxnlQdr1H
 BGs8fXeXkyE6hOq5Zt2CZqpdHlPH+31nereyzj/4hyvDiBIEMtSJFycc1iq38S0y49uX
 Eco4UbykTLNnnUaBcXTNatJBNL0ukCOQOqZ3wZ81FMrS5vSTl/3Kvb2nNMdKQUeXFNyF
 9mHQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/t0wFT95FOphBnGVfax/PqDDwlD635TmRcEFlQNLhBou8aZQ4l1ov80+81MCwJ1ENtEaKHgiE=@lists.denx.de
X-Gm-Message-State: AOJu0YzNE6w4GMlsTwLPpK9izZEc0j4igt54sEGc2qn/fkT3Pc1KT4Bn
 jDvooCtolOQr3vjDstfU5MxCekN2io+HinlaP4AwCXLUammvmuvkAumMXtESle54scs=
X-Gm-Gg: Acq92OG/684U/TIuW3jqbfZlCtAz10D5V9keOXSmPFiCsN/W7uvzT96qAkfymjFqe7Y
 fUxWv5H3D5KTDBRSiLfawliCIXVr8SzOpAUOX40kbER6W0knNqSjXXJZAjTziNFYbZaQ10MLjHS
 +O27wMXTLf814K8EcmD+ch/xtKRscNi/q5YBqFDLbQ3FIgd/Si7QP2697KfjI4+R3+DwivMU9RR
 XoOsAlqQRwJDOzYYZcDZoVa7gREA+pr3KMES7D5lD4BTGui9kzDJHJFfzg5BKy/mhub4PyiMdDq
 mWY5UGKfkT7IxLuhONLn2MczZmKKFGB9jhDdZsWujgIOY3L1wWLE6vKR0nzzy0bWlDnAOPslTWr
 7hBBf3U7APunj8MomNjLHTUnp8/NWIM7VGehPbAt7ud9dZaStVv13brUpy51YOVUKDeH5Qlj9gn
 oxHqeNdMaqzZvNeGlpykLutxizeBioUxhARRVyESazDKZiuj/Hb5Ji6pibg2qfL51wGKVNRqxoQ
 2kJJv2cr8SlwNuT4rAp8+xihKRbaR9v1hvYtbnUAXGTiTT6cMcLKFuO
X-Received: by 2002:a05:6830:378f:b0:7dd:e032:3ce5 with SMTP id
 46e09a7af769-7e6a1e6334bmr837498a34.17.1780084876426; 
 Fri, 29 May 2026 13:01:16 -0700 (PDT)
Received: from bill-the-cat (fixed-187-191-8-235.totalplay.net.
 [187.191.8.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695d6b1d4sm2144644a34.21.2026.05.29.13.01.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 13:01:15 -0700 (PDT)
Date: Fri, 29 May 2026 14:01:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Simon Glass <sjg@chromium.org>, Huang Jianan <jnhuang95@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Tony Dinh <mibodhi@gmail.com>,
 Timo tp =?iso-8859-1?Q?Prei=DFl?= <t.preissl@proton.me>,
 Francois Berder <fberder@outlook.fr>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Daniel Palmer <daniel@thingy.jp>,
 Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sughosh Ganu <sughosh.ganu@arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Peng Fan <peng.fan@nxp.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de,
 linux-erofs@lists.ozlabs.org
Subject: Re: [PATCH 3/9] fs: ext4: print change date in directory listing
Message-ID: <20260529200112.GA694169@bill-the-cat>
References: <20260518055728.178507-1-heinrich.schuchardt@canonical.com>
 <20260518055728.178507-4-heinrich.schuchardt@canonical.com>
 <CAFLszTgZ=ciSU-ny1+X+8jYsvRD-jc-TVQ3WwfyZ3DYvmR81Ug@mail.gmail.com>
 <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="LnZKIoigaDDXZoCB"
Content-Disposition: inline
In-Reply-To: <73acbfa7-43aa-4d65-b7ba-1824fda3b348@canonical.com>
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


--LnZKIoigaDDXZoCB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 21, 2026 at 02:46:51AM +0200, Heinrich Schuchardt wrote:
> On 5/20/26 22:42, Simon Glass wrote:
> > Hi Heinrich,
> >=20
> > On Mon, 18 May 2026 at 00:57, Heinrich Schuchardt
> > <heinrich.schuchardt@canonical.com> wrote:
> > >=20
> > > Declare FS_CAP_DATE in the ext4 fstype_info entry so that fs_ls_gener=
ic()
> > > displays the modification date alongside the file size:
> > >=20
> > >   4096 2024-03-15 09:30 filename.txt
> > >=20
> > > Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> > > ---
> > >   fs/fs.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > >=20
> > > diff --git a/fs/fs.c b/fs/fs.c
> > > index f8e4794c10e..482a5523712 100644
> > > --- a/fs/fs.c
> > > +++ b/fs/fs.c
> > > @@ -261,6 +261,9 @@ static struct fstype_info fstypes[] =3D {
> > >                  .fstype =3D FS_TYPE_EXT,
> > >                  .name =3D "ext4",
> > >                  .null_dev_desc_ok =3D false,
> > > +#if !IS_ENABLED(CONFIG_XPL_BUILD)
> > > +               .caps =3D FS_CAP_DATE,
> > > +#endif
> > >                  .probe =3D ext4fs_probe,
> > >                  .close =3D ext4fs_close,
> > >                  .ls =3D fs_ls_generic,
> > > --
> > > 2.53.0
> > >=20
> >=20
> > I would prefer having a head-file macro which expands to nothing for
> > xPL builds, rather than adding preprocessor macros.
> >=20
> > Regards,
> > Simon
>=20
> Hello Simon,
>=20
> In the internet I could not find what a "head-file macro" might be.
>=20
> As struct fstype_info is not defined in a header file, a preprocessor mac=
ro
> defined in a header file would not make sense here.
>=20
> Do you mean something like:
>=20
> #if IS_ENABLED(CONFIG_XPL_BUILD)
> #define FS_CAPS(flags)  /* empty */
> #else
> #define FS_CAPS(flags)  .caps =3D (flags),
> #endif
>=20
> static struct fstype_info fstypes[] =3D {
> #if CONFIG_IS_ENABLED(FS_FAT)
> =A0=A0=A0=A0=A0=A0=A0=A0{
>                 .fstype =3D FS_TYPE_FAT,
>                 .name =3D "fat",
>                 .null_dev_desc_ok =3D false,
>                 FS_CAPS(FS_CAP_DATE)
>                 .probe =3D fat_set_blk_dev,
> ...
>=20
> A line without a comma in the initializer is easily mistaken as incorrect=
=2E I
> am not sure that a code reviewers life is made easier with defining a new
> preprocessor macro.

We have a lot of other examples like this in-tree already such as
ENV_NAME(..) so I think it's reasonable to make an FS_CAPS macro like
this.

--=20
Tom

--LnZKIoigaDDXZoCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCahnwhQAKCRAr4qD1Cr/k
Cr2kAQCgadsybh4J7JeK8gNZFoxFWxsAanUeadtWkzWgoniXMAEAwJkNH02zDbmW
WQPr1wdeUdrnL8L68LzU6wnAQiPJrgM=
=qb4P
-----END PGP SIGNATURE-----

--LnZKIoigaDDXZoCB--
