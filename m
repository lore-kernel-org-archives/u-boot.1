Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE29C87FC9
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 16:28:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1CA4983045;
	Tue, 29 Jul 2025 18:28:26 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="phFvnk5R";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 94C6E82F00; Tue, 29 Jul 2025 18:28:24 +0200 (CEST)
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com
 [IPv6:2001:4860:4864:20::2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61ACD82BCD
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 18:28:22 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-301a83477e5so4065976fac.1
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 09:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753806501; x=1754411301; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6B6SSNfaRHIAx8Jv6y5pqzQ6aSwdPTSTelBr9XFv0tI=;
 b=phFvnk5RqHrOo05O/5X0p1SUD6BBnX3RQ2VCd5jBgpA7spMuB6M6XnirjT1W1Tde0R
 4q+YEvjfUyTb4TRfdn9nyqaw4Ko60soDXFtIYjCtRT6gCUu676di/0pBcDfyV+8MLd9e
 pMfrtgnxyX7ZErPua8wij43p6np7BEjc7Pgzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753806501; x=1754411301;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6B6SSNfaRHIAx8Jv6y5pqzQ6aSwdPTSTelBr9XFv0tI=;
 b=o4Iu82pfNGoHwMSbWd67pX4GKGnSQhyHBLjd813yGTP8wJrd2NUIKFSgkIlW3T4RsZ
 ALk5G9GRbvCuGNvBnO+zwCgrupLy+Xj/Fb1g8xqyBBleJO65dmjGbk8RAnc2sEpfeGsr
 8A2Xf1wUkP+sC/BxSeYB7cNdg+q9HAsvE+Dzh1Q7FcguqfR28UQw8tVICzqWNdKrOW6x
 f5u2qsEUIT5X4DhHerjtoyjz92i9FMPFI1vLciPD/L2sM86wGDVjya5QAOmG/f2HXH0J
 IcckxqzxMqjdOuAqnQ+v1qV6BLS6dhDLy1tvj0CDwzTc79zIMfdi1yjB0Ngi2JqGpMAI
 dndw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdixlUXgEQlJmNhlee4L804n9T6zQKmyxnlUJ9cm1n4eN6KLhGWO9tOCnFNBT26ner1kP//1E=@lists.denx.de
X-Gm-Message-State: AOJu0Yy6PDm9cZ/rsrqmpd7IpULjVzajfcxw1+SEQMi0F3Yjn3CyxRLm
 LklgKqzN7RNExYjoa8qUPlLBjXxytbwAkIHw6oaCeBtM8zTIMBOqtq+EAF28unPsXX5v04bI+fZ
 L0x+GOCo=
X-Gm-Gg: ASbGnct20nllmraVzCni3C+B82tGjtnjzpS2h6KzS6AIuY1CwLj2wvWDPmMjGxWRsTz
 LmZY8LGHNVKrttXx5CK3QUVvQ99KhHJHqSL9E5rqMWUjmxZqEkH8IBa8eGC8mrKMXnaEGOrUrQk
 2WR5supzuSPGyLUAU+/Ay2iTOSp2KMcZHjdfKQVM3eMD06bcUkCMFfUP92PML1tGzP5sN2tpWzP
 j6CV+I8kOgHIrWO51eWFHmHst3NzBCH1jvo+pCGOBo4biKIKfp9Cwn/o+s5ugcf+kGa1yXoJt6v
 wS8XfGCXAopXeIgVxXT0CADMrLjjB2EjkZV9ezs6WlffCswVlOZQ2iEKPNg98Nx1NbAp55OeU6Q
 J2cTodQ5hqOyr5CUgxKBgb0ihWkL+Ac9cgX2EX3mPULINkCEfJ74HBYVz
X-Google-Smtp-Source: AGHT+IEBImxBZmng0acQ7Wdqh49rHFdJBO3310PCTfjsttg1wsVde2OmNoQqpllldGt1MnRkQ6+Oog==
X-Received: by 2002:a05:6870:c6a6:b0:2bc:6675:2043 with SMTP id
 586e51a60fabf-30785a2a9c9mr16056fac.14.1753806501042; 
 Tue, 29 Jul 2025 09:28:21 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-3071323a99csm2366506fac.12.2025.07.29.09.28.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 09:28:20 -0700 (PDT)
Date: Tue, 29 Jul 2025 10:28:18 -0600
From: Tom Rini <trini@konsulko.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Peng Fan <peng.fan@oss.nxp.com>, "Alice Guo (OSS)" <alice.guo@oss.nxp.com>,
 "tharvey@gateworks.com" <tharvey@gateworks.com>,
 Ye Li <ye.li@nxp.com>, Stefano Babic <sbabic@nabladev.com>,
 Fabio Estevam <festevam@gmail.com>, dl-uboot-imx <uboot-imx@nxp.com>,
 "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 Alice Guo <alice.guo@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject: Re: ??????: [PATCH v2 0/4] imx: add i.MX95 b0 support
Message-ID: <20250729162818.GL1807455@bill-the-cat>
References: <20250708-imx95b0-v1-0-01759e9c855f@oss.nxp.com>
 <CAJ+vNU2G=CMiHc4mU4fjQEz7zwjvx_EuiWWQo8MBVHGJdmTarA@mail.gmail.com>
 <PAXPR04MB9644BC97420DB4E3D877C2E2E225A@PAXPR04MB9644.eurprd04.prod.outlook.com>
 <20250729113902.GA27993@francesco-nb>
 <20250729160805.GA31189@nxa18884-linux.ap.freescale.net>
 <20250729150438.GB48479@francesco-nb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8PupOrvwbeo7F9av"
Content-Disposition: inline
In-Reply-To: <20250729150438.GB48479@francesco-nb>
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


--8PupOrvwbeo7F9av
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 05:04:38PM +0200, Francesco Dolcini wrote:
> On Wed, Jul 30, 2025 at 12:08:05AM +0800, Peng Fan wrote:
> > On Tue, Jul 29, 2025 at 01:39:02PM +0200, Francesco Dolcini wrote:
> > >On Tue, Jul 29, 2025 at 02:21:19AM +0000, Alice Guo (OSS) wrote:
> > >> A0 has been dropped.
> > >
> > >Dropping support for A0 i.MX95 SoC variant in mainline U-Boot is not a
> > >decision from NXP.
> > >
> > >There are multiple boards around with such SoC variant, just dropping
> > >support for it with no explanation does not seem ok to me.
> >=20
> > A0 may not goes into mass production, so I think it will phase out.
> > It would be better to update your boards to use B0.
> >=20
> > Since B0 is here, continuing A0 does not make much sense.
>=20
> This was clear and known to me.
>=20
> But that does mean that we have to just drop support from U-Boot? Is
> there a significant increased maintenance effort to keep A0 silicon
> alive that justify dropping support for it now? We have new products
> shipping with A0/A1 silicon as of now.

Given Tim's answer in this thread as well, it sounds like A0/A1 support
can't be dropped and a support path needs to be figured out.

--=20
Tom

--8PupOrvwbeo7F9av
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIj2ngAKCRAr4qD1Cr/k
CgJpAQChrYotz47XZpeWJmXJlyF0icPfdO3kIdypye2A7FIjlwD/dbrludJIZUI9
8qrQeWoN+e59vhzBpeE06unzRcv47wY=
=YDbz
-----END PGP SIGNATURE-----

--8PupOrvwbeo7F9av--
