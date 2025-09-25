Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A892CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 14:29:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 7B57680107;
	Thu, 25 Sep 2025 16:29:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Pz/GMGGT";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 4022480107; Thu, 25 Sep 2025 16:29:00 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B3E7800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 16:28:57 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-321289dee84so512247fac.1
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 07:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758810536; x=1759415336; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kDoyvnBZRghlg5OJnjSwMUZp+uAUgnPxzyiiD2yt6GE=;
 b=Pz/GMGGT+HdljxWsXNbKqlblKrbXBPjqe4P0Ao1o0bCXms1eBdlZ6cfgs8DuJI4UJh
 uoQdz14R3UYztXNFi6qJcBY1AOIw22AJ2Lmi8/9sLzwae+EQkuPWksbLWDUaBMZ+lVT2
 FXpwLur9AeXlAHAxBpSqM+ZTLEBzL+FpzsOvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758810536; x=1759415336;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kDoyvnBZRghlg5OJnjSwMUZp+uAUgnPxzyiiD2yt6GE=;
 b=cvOj0kPQwIgp4RD0CuyDysEsgn3fl0AvqjI24p1pNDeJghOfpNEgBxzYat/KeKHh86
 cnsE0NlkvsvawULSOYERJcaqdjBhgQbabFF6ZG1TRe5rMfmAl3zlHk9NBvOtXRXq4kzD
 /6GUPh70gbiT9ypPQ3NWV0gVn6pMMnPcomVGGg1FTrDxab4lZZ4vo6IXro1MU0uQN8z4
 /yXlr/9JoDVJ2ToQSXDVIXf3q6Nz6JpePCyLnu8MdF5FbBs+oJAzkpnd/n8SNIi9J30F
 kStXUTJs3pUXpR3zuac9WlnGjJdiEM+j6MD7NDBF/+ugpUFdAOPvPD7bv50KayNByfgq
 Ke9w==
X-Gm-Message-State: AOJu0YyS+YI1oSS7MM639WifOmsseBgyoX9dAonv40Yqir3iuTiHNcc/
 ryH2sn56n0WQDF+C3VqrnqZ2s3HO/NsPpFiD9pgdHAMEZuh0RlosE+pzqRXEmWrzwiI=
X-Gm-Gg: ASbGncu3bmOEuBdHawhVjxmTkG9yl4FHmwhBTXfUphIt0Q+WoFNO+B5YTxidZCthTcg
 KAZuMW8Uh+xpn4vNq1IQedRJy7KGU/oFdLMYYPcpYyxGDKLRQ2YJistsZiPLfd5X9njao02jEGO
 nBHfRbZJi2CY4fgKNW1cttgMc65+uKF+hRLwaCkc6NJY46zjmcjHKPERtRpNeBFDCSTUJZdR/1b
 Zna/OGq1g2VnLoWk1cKrPbboiwZduc0u/+XW6wGYCuAXFuUrKUlKZGehX5wGPXwUMltTeaCyb/7
 m45ZsUpfZ0ycX4aM0KX7a9FLFyY2a1mINf7cPtNVTFTjkUsnkYLCDVvg3MncmvJ+xY2ztSBUjN7
 1JLpcYdfqa/6bIWF6slhpdXuhfVnt2hhtn39D5hsFI3faC+b+v8g5NGwI
X-Google-Smtp-Source: AGHT+IE+snYQQMJ9EGFZ8rgi1TrESOfwp46s0iWf0HjozoJPHI5oAx3gRHCLVg1T25S591NmRgru/w==
X-Received: by 2002:a05:6870:231e:b0:322:5c2d:58c9 with SMTP id
 586e51a60fabf-35ee7203cd8mr1692575fac.24.1758810536306; 
 Thu, 25 Sep 2025 07:28:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-363a15c108csm590137fac.6.2025.09.25.07.28.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 07:28:55 -0700 (PDT)
Date: Thu, 25 Sep 2025 08:28:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Yegor Yefremov <yegorslists@googlemail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, seanga2@gmail.com,
 Simon Glass <sjg@chromium.org>
Subject: Re: am335x: NAND boot problem using the legacy u-boot.img
Message-ID: <20250925142853.GP197373@bill-the-cat>
References: <CAGm1_ktPcqpCzy=B=_n1fZS5dZVCB208qt8CTgBJak=V0xfgEQ@mail.gmail.com>
 <20250924141428.GI197373@bill-the-cat>
 <CAGm1_kt1hu+yPoMshm1M1LMszpxeiVijUU1ZF5UThQtL85xmMA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="V/d40JEdguapqq+P"
Content-Disposition: inline
In-Reply-To: <CAGm1_kt1hu+yPoMshm1M1LMszpxeiVijUU1ZF5UThQtL85xmMA@mail.gmail.com>
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


--V/d40JEdguapqq+P
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 08:09:05AM +0200, Yegor Yefremov wrote:
> Hi Tom,
>=20
> On Wed, Sep 24, 2025 at 4:14=E2=80=AFPM Tom Rini <trini@konsulko.com> wro=
te:
> >
> > On Wed, Sep 24, 2025 at 11:09:16AM +0200, Yegor Yefremov wrote:
> >
> > > HI all,
> > >
> > > trying to boot using the latest master, I get the following error:
> > >
> > > U-Boot SPL 2025.10-rc4 (Sep 23 2025 - 16:45:07 +0200)
> > > Trying to boot from NAND
> > > Error: -5
> > > SPL: failed to boot from all boot devices (err=3D-5)
> > > ### ERROR ### Please RESET the board ###
> > >
> > > It turns out that bl_len will be set to 0 in spl_nand_read():
> > >
> > > spl_set_bl_len(load, nand_page_size());
> > >
> > > This sets the aligned image size to 0 in _spl_load():
> > >
> > > size =3D ALIGN(spl_image->size + overhead, spl_get_bl_len(info));
> > >
> > > Looks like FIT images with full FIT support will be also affected:
> > >
> > >                        read =3D info->read(info, offset,
> > >                                            ALIGN(size, spl_get_bl_len=
(info)),
> > >                                             buf);
> > >
> > > If I manually set bl_len to 1, I can boot without an issue. What am I=
 missing?
> >
> > I wonder if this has always been an underlying problem. Looking at
> > drivers/mtd/nand/raw/am335x_spl_bch.c we've always had nand_page_size()
> > return nand_to_mtd(&nand_chip)->writesize and I assume that should have
> > been being set to CONFIG_SYS_NAND_PAGE_SIZE but I don't see that as the
> > case. If you change nand_page_size to just return
> > CONFIG_SYS_NAND_PAGE_SIZE or nand_init to set writesize to
> > CONFIG_SYS_NAND_PAGE_SIZE does it then work again?
>=20
> yes, the following change makes the system bootable again:
>=20
> diff --git a/drivers/mtd/nand/raw/am335x_spl_bch.c
> b/drivers/mtd/nand/raw/am335x_spl_bch.c
> index 4b50f351d35..a77206d3815 100644
> --- a/drivers/mtd/nand/raw/am335x_spl_bch.c
> +++ b/drivers/mtd/nand/raw/am335x_spl_bch.c
> @@ -212,6 +212,8 @@ void nand_init(void)
>         if (nand_chip.select_chip)
>                 nand_chip.select_chip(mtd, 0);
>=20
> +       mtd->writesize =3D CONFIG_SYS_NAND_PAGE_SIZE;
> +
>         /* NAND chip may require reset after power-on */
>         nand_command(0, 0, 0, NAND_CMD_RESET);
>  }

Thanks, can you please post this as a proper patch?

--=20
Tom

--V/d40JEdguapqq+P
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNVRpAAKCRAr4qD1Cr/k
CqtMAQD2vzEpC4k2wzn6JoMhBql5B9m0KKNNJqZas8XCT4sRTwD/ayY0m1BX3I2y
QGw1iDCvbsLdAgm62pRoCfBFbilVwgI=
=f3aR
-----END PGP SIGNATURE-----

--V/d40JEdguapqq+P--
