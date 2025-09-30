Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74457CCA470
	for <u-boot@archiver.kernel.org>; Tue, 30 Sep 2025 17:12:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78375800D7;
	Tue, 30 Sep 2025 19:12:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AX/FkgQW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 17846802C1; Tue, 30 Sep 2025 19:12:35 +0200 (CEST)
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com
 [IPv6:2607:f8b0:4864:20::d33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E4CC9800B1
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 19:12:32 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-io1-xd33.google.com with SMTP id
 ca18e2360f4ac-91e578e2a61so137324339f.2
 for <u-boot@lists.denx.de>; Tue, 30 Sep 2025 10:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1759252352; x=1759857152; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=p5R31iWjHEUJM72aorf5Klo5lqYavk6PNRvoYhKdqzo=;
 b=AX/FkgQWyQNA3d7M9TuzxO8DgVEo5I9cpfQrcQtjBzYn3AlQvnQhF4qEqbMcfoc4Nb
 xZp5rkcsU5vSkbN6YfMvLahxr1datAPcFuPQel1ip134cjgkV+Hq8qobgkeJmN/X+g6H
 NxRvPm3a0xqlqZLmlR/viV6PQ8kOabLFijT2k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759252352; x=1759857152;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p5R31iWjHEUJM72aorf5Klo5lqYavk6PNRvoYhKdqzo=;
 b=UGmBIxd/JfLb9rEQxPw1+MNCuEzTfC6VboD+M83nKeuC2i6cWrMbwwUBzCOzGmXB+H
 sLvR1e6jfqnWWRZcIYRp1JRsMI9T+6aA2QhdsswgeUZMbV9LeRfCohQrHX7/UE3oOd2V
 goRyTVrIVO7l21K+dEOn/Moiih4665ADBt5bHINOo7ZJ4ijpELeX1c9cmUOr6GONlSiJ
 CEvd47wYBPtSFfugl7SapDzMxR93p9Tv8J+0Lkwf/+5DUsNOYueYxf+1dwh+z4SAF+S8
 y2Ilph2S5w1MkeoZ2zBnTZX+Pa9hZlxaKnLec1GTbyqT2imw0opxaaja2jmIMicjHIRv
 fSUw==
X-Gm-Message-State: AOJu0YyuMNZ9L2dxqfNpxaopWYHvQSd3IzXTQL1UkFltwhW+Pv2nPGnT
 D+3pTrWfXn3nA+h5n7YM5R/vuziRw+S7ajuJjA7Rj0pZC4l1zC70c4VY4Hn1CiS7HEw=
X-Gm-Gg: ASbGncu1mCM1O0062j8wCQUyT0IZk/ohcwxmztiv8YP/Hcnn+m6FuwuhmVq/VLVeT0c
 zfr4WuaK5iUo/7pTEqh2BhWvYuKfGa+EuBckUZiCxiaDR0rMrGLIaDZxfESxmAqKrt4n0N9TnK+
 auV6JdN++aCUbTtDOSoolejlMx4QeYmgl0EjOslSwD19i/xqiWoxu3kSeUMRXztA8+k9GWvt2RE
 WYwrDzcW2HpWufl6xnAsYmOwafRPr+ymf5IMIR3c2nEgsKLPP7r6poo4TaUWgBifQAOUNH8EhGy
 aF2deRX2+zcJaya+O4v7Jgy5LcxX8UUPWAJrmC1nEQicyHV8947HdhyxtDpivy5e9JcreBhC6s5
 X5rXDQ4kl9Fu9pO7L6xoNIKng161R7kiWHuQ2/XFuZ0+1mSz9L8JZzQn3eOOBNqANnBtcRh5Xfj
 RZ1BjE
X-Google-Smtp-Source: AGHT+IGJqkvYxUmAkPDw+325Zh1n5fXYgCU9kGGuLjbyYo/kAXTw+OR9klSTUuh5yHsH50+YtwK1Yg==
X-Received: by 2002:a05:6602:1412:b0:935:4720:6452 with SMTP id
 ca18e2360f4ac-937a9752e80mr72884939f.8.1759252351312; 
 Tue, 30 Sep 2025 10:12:31 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-9040bed1e5fsm557016739f.15.2025.09.30.10.12.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Sep 2025 10:12:30 -0700 (PDT)
Date: Tue, 30 Sep 2025 11:12:27 -0600
From: Tom Rini <trini@konsulko.com>
To: Conor Dooley <conor@kernel.org>
Cc: u-boot@lists.denx.de, Michal Simek <michal.simek@amd.com>,
 Pramod Kumar <pramod.kumar_1@nxp.com>,
 Tang Yuantian <andy.tang@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>,
 Ashish Kumar <Ashish.Kumar@nxp.com>, Priyanka Jain <priyanka.jain@nxp.com>,
 Wasim Khan <wasim.khan@nxp.com>, Udit Agarwal <udit.agarwal@nxp.com>,
 Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
 Manish Tomar <Manish.Tomar@nxp.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Aaron Williams <awilliams@marvell.com>,
 Mathew McBride <matt@traverse.com.au>
Subject: Re: U-Boot PHY_MSCC vs PHY_VITESSE
Message-ID: <20250930171227.GG6093@bill-the-cat>
References: <20250929224336.GS6093@bill-the-cat>
 <20250930-ramble-babied-1dbf34a778df@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/vNj3y0IN4HOPg9s"
Content-Disposition: inline
In-Reply-To: <20250930-ramble-babied-1dbf34a778df@spud>
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


--/vNj3y0IN4HOPg9s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 30, 2025 at 05:41:34PM +0100, Conor Dooley wrote:
> On Mon, Sep 29, 2025 at 04:43:36PM -0600, Tom Rini wrote:
> > Hey all,
> >=20
> > As part of working on "allyesconfig" support I ran into the following
> > problem. Both drivers/net/phy/mscc.c and drivers/net/phy/vitesse.c
> > implement support for the VSC8584 PHY. The vitesse.c driver is much
> > older and only had VSC8584 support added for a specific Freescale
> > Layerscape platform whereas mscc.c is modern and been updated with
> > newer PHYs as well. And we need one driver to support this phy, not two.
> > I am inclined to remove support from vitesse.c. However, only 4
> > platforms use the PHY_MSCC driver and everyone else uses PHY_VITESSE.
> >=20
> > I'm cc'ing all of the board maintainers (other than PowerPC platforms)
> > that use PHY_VITESEE today to see what their feedback is on which way to
> > go here. I'm ignoring PowerPC because that can just stay on the
> > PHY_VITESSE driver based on timing of changes in git log.
>=20
> The mpfs icicle board is using PHY_VITESSE because the phy it has
> (vsc8662) is only supported by that driver. Same in Linux for that phy.
> We've got no users of the model you're talking about.
>=20
> FWIW, I checked our "in house" linux config and it uses the generic phy
> driver, rather than the vitesse one. I wonder if we can get away with
> that in U-Boot too?

I was a little unclear in my wording of the problem, sorry. So just
staying on PHY_VITESSE is fine (it's not being removed) or switching to
the generic phy driver (likely smaller binary in the end?) is fine.

--=20
Tom

--/vNj3y0IN4HOPg9s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNwPcwAKCRAr4qD1Cr/k
ChgyAQDEUyV6id5KkmIDagozRfKrpFKWdAv0l6YGZcVUySL7PgEAjZGknw6pITjP
NJgFuHagS/dWQBrfC69fbydkgVdYjQY=
=2Tsg
-----END PGP SIGNATURE-----

--/vNj3y0IN4HOPg9s--
