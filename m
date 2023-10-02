Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC48BE7849A
	for <u-boot@archiver.kernel.org>; Mon,  2 Oct 2023 14:05:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4023870B7;
	Mon,  2 Oct 2023 16:05:23 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="hmXqTuuF";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7DA3A870B7; Mon,  2 Oct 2023 16:05:22 +0200 (CEST)
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com
 [IPv6:2607:f8b0:4864:20::112c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7EBB86E14
 for <u-boot@lists.denx.de>; Mon,  2 Oct 2023 16:05:19 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-59f7f46b326so135029267b3.0
 for <u-boot@lists.denx.de>; Mon, 02 Oct 2023 07:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696255518; x=1696860318; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AV+x+2R/zQDtgDBazWpQGbPL+sa2YixIbJYITw6Xd+4=;
 b=hmXqTuuFM7Lm/X2VO3cITNVSPgMu/UhdeQwJIIdYA9tW3G60aQIdZ1vk9Y3ij8pW7k
 SSscfSCGRNIEqe1qMMFz0iNawx3JJnskuvBlz574/ZT2Py+qomP9mXGtj3hZnEwvJMnG
 FqhP5ryyC7VyXHZ6Glm4bvL1mACHLStnqxIkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696255518; x=1696860318;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AV+x+2R/zQDtgDBazWpQGbPL+sa2YixIbJYITw6Xd+4=;
 b=nShzZ03lZlhbG7FaaqnoSuGnoqy8821ePkNLQp1PnBaTQdPwLVKICxvsCYI/PM64Db
 jBgtMPMmBeEF/TZxb/vODWc7kpdqifFoo4PxQwcgkcIH7ssAL7pB5oq8IxulDj19Hv79
 BZ24lmEp+nUQ9wpoKz2JFTt5oFypgRIqXK/NqFaD/PHRp8CQG0KF2c1pQgWk5IDNsfqt
 zhspdB7nm5i1DX4YWgADTgfD7VPLs0lgvJ0AWyp4IeZkn9+0t6i2ORf2/7tpHnfy2kdR
 zlOczCxnBt65G4cjqC1fw86wzDsNxycI6VwyC8MwtfdX4uxMdpsGyUJEJvHtNH4V1aFH
 mp7w==
X-Gm-Message-State: AOJu0YzUq0mH57m2Ow+fUyHGlzmCYGk5hLJ+LmNfheatGLK830pjkD3K
 CDcT9GTptu2j4ZZLlhaCfHDTKw==
X-Google-Smtp-Source: AGHT+IGr951+BgL62eObgz9mcSZlXSjT2/GI7Bag3dWShumSCEUuI9gbXYfF3K+52CU3G9jtS65QJQ==
X-Received: by 2002:a81:9250:0:b0:583:d1fa:1fc4 with SMTP id
 j77-20020a819250000000b00583d1fa1fc4mr10995459ywg.26.1696255518200; 
 Mon, 02 Oct 2023 07:05:18 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-92a5-a961-a832-88f6.res6.spectrum.com.
 [2603:6081:7b00:6400:92a5:a961:a832:88f6])
 by smtp.gmail.com with ESMTPSA id
 s125-20020a0de983000000b005925c896bc3sm7760978ywe.53.2023.10.02.07.05.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Oct 2023 07:05:17 -0700 (PDT)
Date: Mon, 2 Oct 2023 10:05:15 -0400
From: Tom Rini <trini@konsulko.com>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: Kever Yang <kever.yang@rock-chips.com>,
 Frank Wunderlich <linux@fw-web.de>, u-boot@lists.denx.de,
 Simon Glass <sjg@chromium.org>, Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Joseph Chen <chenjh@rock-chips.com>, Jonas Karlman <jonas@kwiboo.se>
Subject: Re: Re: [PATCH v5] board: rockchip: Add Bananapi R2Pro Board
Message-ID: <20231002140515.GT305624@bill-the-cat>
References: <20230920184005.50931-1-linux@fw-web.de>
 <0ef110bf-12d3-d507-63d3-03f15255188c@rock-chips.com>
 <trinity-6f4dc3e7-6c77-4a85-a8b3-b7d5b1b87ef9-1696230547625@3c-app-gmx-bap51>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gi7aJUdGZDleK3jq"
Content-Disposition: inline
In-Reply-To: <trinity-6f4dc3e7-6c77-4a85-a8b3-b7d5b1b87ef9-1696230547625@3c-app-gmx-bap51>
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


--gi7aJUdGZDleK3jq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 02, 2023 at 09:09:07AM +0200, Frank Wunderlich wrote:

> Hi
>=20
> Thank you kever for review.
>=20
> Tom can you take this and the depencies into next release (2024-01)?

Kever should have these in a pull request for the next release, given
the time, thanks.

>=20
> regards Frank
>=20
>=20
> > Gesendet: Mittwoch, 27. September 2023 um 04:42 Uhr
> > Von: "Kever Yang" <kever.yang@rock-chips.com>
> > An: "Frank Wunderlich" <linux@fw-web.de>, u-boot@lists.denx.de
> > Cc: "Frank Wunderlich" <frank-w@public-files.de>, "Simon Glass" <sjg@ch=
romium.org>, "Philipp Tomsich" <philipp.tomsich@vrull.eu>, "Joseph Chen" <c=
henjh@rock-chips.com>, "Jonas Karlman" <jonas@kwiboo.se>
> > Betreff: Re: [PATCH v5] board: rockchip: Add Bananapi R2Pro Board
> >
> >
> > On 2023/9/21 02:40, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > >
> > > Add Bananapi R2 Pro board.
> > >
> > > tested:
> > > - sdcard
> > > - both front usb-ports
> > > - sata
> > > - wan-port
> > >
> > > lan-ports are connected to mt7531 switch where driver needs to be
> > > separated from mtk ethernet-driver.
> > >
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> >
> > Thanks,
> > - Kever
> > > ---
> > > because iodomain is different to evb and now iodomain driver is sent =
as
> > > patch we need to separate between EVB and R2Pro else board can be bri=
cked.
> > >
> > > ethernet support depends on these series from jonas:
> > >
> > > rockchip: Port IO-domain driver for RK3568 from linux
> > > https://patchwork.ozlabs.org/project/uboot/cover/20230821223020.39186=
20-1-jonas@kwiboo.se/
> > > and
> > > rockchip: Add GMAC support for RK3568 and RK3588
> > > https://patchwork.ozlabs.org/project/uboot/cover/20230807000817.17010=
12-1-jonas@kwiboo.se/
>=20

--=20
Tom

--gi7aJUdGZDleK3jq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUazhsACgkQFHw5/5Y0
tyw7hQv+P3RiONdovqxR6f0SzS0BzHs/sIvTyMkJzqFbIVGLm8cMeOmbmgtVCmbq
H1/6U3LN4IQ8yLN5I5rAW4WEKlEqJle9X6PAJFJA/1SIgGECXlEaq7LyngoM7qNm
wdNATgMd8W2S30j5TDLwF3fWbmvyQGT4i9il3EFCnCF1S/6HAWhmFc54DT6iO820
QYlete39kqXnz9RYo4rfg/y+OSjsodNBeehlOaCyhjsRA0TkXYGNI0PD3zg02Q3V
5z9Wt0BFPBC2Gxu5qYEOd12dFUFem+OcW1dMeA9hyAwbJIe57DK8phk5hH3xj1sv
KfzRjse9LQgS3EzNkFmhmZiTDIEu/QFgrq3HDYfV03TykqckycqCz5sDPjscuyXj
UhSqw067MChV1QI11oM3QMghaMU0g4RCyiL6UweFuDKfIDGwIt/fOBYo29gBlyHt
S5pXzE2vJ2yrfT5vIbd4amHITEwXz99MnqedLY9uJSm9vbciq5jA5uocez70MUD/
P4x9Zfa8
=xNMm
-----END PGP SIGNATURE-----

--gi7aJUdGZDleK3jq--
