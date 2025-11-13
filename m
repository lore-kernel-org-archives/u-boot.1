Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAD47CD6E71
	for <u-boot@archiver.kernel.org>; Thu, 13 Nov 2025 14:27:54 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0E75983A6A;
	Thu, 13 Nov 2025 15:27:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DH4kwIpt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 14BDA83E43; Thu, 13 Nov 2025 15:27:52 +0100 (CET)
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com
 [IPv6:2001:4860:4864:20::2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E74AF83968
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 15:27:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2f.google.com with SMTP id
 586e51a60fabf-3e29f583e8bso1123260fac.1
 for <u-boot@lists.denx.de>; Thu, 13 Nov 2025 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1763044068; x=1763648868; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zvkw+2RoiYNJQuttDlD/Ylb5tlW4kY7zWVmy5iuDss4=;
 b=DH4kwIptzXI1J8pI2wzF0SgqzzCoOsvi5XDHMYCyBjrvKAogCa+dJ2Uy+H0BLHGtBI
 lOHfwH69JHUihrXuWUl8hMrDIhzHurorG13ygW6eWfWzYidk1+lsOsCGUXEqj+XFLmdq
 FBpTjHI8XtF6+sU7eN62rdAmGMJNdhRpoJj0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763044068; x=1763648868;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zvkw+2RoiYNJQuttDlD/Ylb5tlW4kY7zWVmy5iuDss4=;
 b=If/Qw22uvK96Q8uyHaPcDExTwCIqtN/xg7IB/RBNU8zs0mPNnj+L19/T1xuiHDsdoM
 KhU7NENRCyXRdle0weyspOJc1P9e5tAtsaa+oOfahUYq6axPBJF1/VHHzD4HbbE8YXNj
 1USB4cC2/7HyyJnIv6Xh+4z0DRg+HR5Wmq/lZeyODb5EMwrWds8RCxW0I483WElPYANt
 cIGEIPV62GqckzKFMg1IXg+/md68BIDzlb7xoIr2K+nwVQh5iDvrpkdEqu9IMBDHBZV6
 h0Dy8KJY4oEVRmuokypCT2U4SqRErW5ZINYYFStgry8ROUCuwd1hP46G8p4pFQW6two5
 acmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0VypXVSq7Lt4yamnlVR0P56kPG7+lj7IfilwwwY+jad/ZVH2mjDR6d+SHB/6ezADF+e4YaZs=@lists.denx.de
X-Gm-Message-State: AOJu0YyM3cBay0Y/KFkggxTdr+Y4zYTy94NR0tc/z4EnA8lCQCY9WfaH
 PQu8HdwYE5ix/1F9lyFa67YJVzpHPPm6bapmdb9/8c2uc9loW8YSOF0EqZR+WxElTxvrrs/cUjV
 0g2Zdjs69Tw==
X-Gm-Gg: ASbGnctSdcvYPeyp1PSsnX4Imo4n/lNOYHlRa7Dg6iPUNnTsowwtD+ijDuFe3Jyid2I
 3+Hug6EQCzJGT/EJQCR44W0QhOG4z+Z1g7MkO1KDq5dP5ABNFNp1CYVhW74KFKurP5HzHOcGgdb
 oKH/AHVC1rAtqRI76fIOS6kWHY+WcAHQXnDiygbN1Iemr9/ic/rHdiJksGoUp9R8Qbto2IkZ8le
 WjVHNJizPFUVH53GEWrZYPsrxSZX7RwFkFifFnusCDPL98+9CpSCTuX9BOf+EzoODnyIzY9pMtH
 r2nKZFiseOZtsyRNToZbH13eRKQTVfhJptvEnsCn9T2X/catSMv2YO1MYGFmk5R+4u631LiOUKU
 GyNwyTXqEsHGJ9XxAjfTMz3IyNQsz9I/8k6g6B85nHgihu5niyLEUq4F2lpEXCm/8eW4xTCaBMW
 pdngvTapzvcboN5w/UEc49USdrRMB6+v3AJoWz/IY=
X-Google-Smtp-Source: AGHT+IFIRIIvjXFrrwU0PZwhlHc2B/FuQ7wvrUIyFE84UT7zCYyYMED6L/6N8/DMVy67zEWLVSkOUw==
X-Received: by 2002:a05:6870:17a5:b0:3d3:1fc3:c0c6 with SMTP id
 586e51a60fabf-3e84c277efcmr1685311fac.1.1763044068613; 
 Thu, 13 Nov 2025 06:27:48 -0800 (PST)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3e8522640casm1459680fac.15.2025.11.13.06.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:27:47 -0800 (PST)
Date: Thu, 13 Nov 2025 08:27:45 -0600
From: Tom Rini <trini@konsulko.com>
To: Jagan Teki <jagan@amarulasolutions.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>
Cc: Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh R <vigneshr@ti.com>,
 Tudor Ambarus <tudor.ambarus@linaro.org>, u-boot@lists.denx.de,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <stlin2@winbond.com>
Subject: Re: [PATCH] mtd: spinor: winbond: Describe several chips
Message-ID: <20251113142745.GI6688@bill-the-cat>
References: <20250703170253.1231818-1-miquel.raynal@bootlin.com>
 <87frcwexyt.fsf@bootlin.com> <875xbegt1x.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rq2OEFJWNBknNwB5"
Content-Disposition: inline
In-Reply-To: <875xbegt1x.fsf@bootlin.com>
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


--rq2OEFJWNBknNwB5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:50:34AM +0100, Miquel Raynal wrote:
> Hi,
>=20
> I am manually adding Michael, as apparently he was not listed
> automatically.
>=20
> On 09/09/2025 at 12:12:26 +02, Miquel Raynal <miquel.raynal@bootlin.com> =
wrote:
>=20
> > Hello,
> >
> > On 03/07/2025 at 19:02:53 +02, Miquel Raynal <miquel.raynal@bootlin.com=
> wrote:
> >
> >> All these chips are dual and quad capable. They are also DTR capable,
> >> but the core is not yet ready for that.
> >>
> >> Performances of all chips are comparable at 30MHz and are as follow:
> >> Eraseblock single read speed: 938kiB/s
> >> Eraseblock dual read speed:  1068kiB/s
> >> Eraseblock quad read speed:  3751kiB/s
> >>
> >> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> >
> > I believe this patch has been out for more than 2 months and is simple
> > enough, any plans for taking it soon?
>=20
> It's now been few more months and I haven't been notified this patch got
> merged. It is also not visible in upstream U-Boot. Could we please speed
> up the merging process, especially for such simple change?

Jagan, Michael, Dario, do you need some help with the mtd/spi related
patches? This hass been going on for some time. Thanks!

--=20
Tom

--rq2OEFJWNBknNwB5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaRXq3gAKCRAr4qD1Cr/k
CubMAP9D72FTzgv1hwELwEmwi0URQgvZT7+jP09FjyLhCkf+ZgEAq2gM6AsKKTyo
gqGzbZKZadKUgV8a0Fwz8Ej9NFBEWQQ=
=1qCc
-----END PGP SIGNATURE-----

--rq2OEFJWNBknNwB5--
