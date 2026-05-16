Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A581CD4F21
	for <u-boot@archiver.kernel.org>; Sat, 16 May 2026 16:44:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 711EC84676;
	Sat, 16 May 2026 18:44:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EIVfqld7";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 6F92B8465D; Sat, 16 May 2026 18:44:14 +0200 (CEST)
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com
 [IPv6:2607:f8b0:4864:20::244])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E09F84671
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 18:44:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x244.google.com with SMTP id
 5614622812f47-479aa2dbea2so405077b6e.0
 for <u-boot@lists.denx.de>; Sat, 16 May 2026 09:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778949851; x=1779554651; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=DtqChIiFTMkOCFOxAhBgjqO/HV7iN50UTtxOEtqcQDs=;
 b=EIVfqld71K+O8fIv9vE195NNV3Vn9Y2GWYpKqMGR9/p8KfD2Fx+zeSa0AIVuR0mFGp
 djaMRq43fGN24zfN0bj/ITl/ehtbBzBvBuDZRcR/OAqi8uiEFYYiEJZzjWEay8/lFo1L
 w5k+skt0fuuUGC9tZD1566+FO0BDS9n7jLgHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778949851; x=1779554651;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DtqChIiFTMkOCFOxAhBgjqO/HV7iN50UTtxOEtqcQDs=;
 b=fORdH4UnBCwt0XlrNlLgQS5yzH8EFoxU1d7oTOW39LPiOK4yNa7EKYyF3Ul9Oc4/az
 aQns21Rtu0wXO3jNsW2hc3i4FjzB6qr+p4hFt0CR7PSgPa6YSGEFeOkGW7N1cqxEjK0N
 lmlh6cSckVxg+kFmdguE94jQ4dEG5Tfb66EB8sOmnSGMwMrjYxI3SLyXMO8dgG76BrwV
 AFJmRPxWbyyqJnzGb4BGwNF9bi8zNlaB7sp8+qBpHi4QAdFgzxRNqG2iawrM+ibCGZzA
 mkqaHBxU86ns/AXY5ZjTbFRcfZh8j9aQ8t1qpQhoess8TyD0LmkMUJQAxhWpfMGDqa05
 yq4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ++lKPn1ctWE++yUcDbFwkDVS3VwTVNoR8gZVxdGRG3DtW8tCziePl4KVCIgK457+Rjrpd8Xk0=@lists.denx.de
X-Gm-Message-State: AOJu0YwqQgJnMmTRYZJrHDSGFQS73ZtaFZiGp0rKe/uwe15hBY2tm3bF
 Y9sV1blACDQxTKHVycDRo6ZUB5zTgPVfX+b0PM31aLUq6/CR7uMa6w1IXgvbenNXC+g=
X-Gm-Gg: Acq92OGA2Xb7IwpR8KMJ698PJYLchXu8j/iVHkU/9ovosv18Ey8lbN4Ulv4wPwqd/Zq
 XYUgO9Ps0PHZKZlZjOIJfVS/44nku2tdaFhh0UwtWyjXVjEI4/PXMey1ykSq7rR/OHfJ2I4Wqwo
 LajnLYiiq0hOIXwLcBP+dvyq9uRI8O5RVhSSMhSrStC3eoTdz1DnXU93/c9fqYSICCR3AshUHGt
 4qWwP5HDRJXIsaaQt6OTzNwLc3Kg2XUJJm/lI7QscIL6pP83lLnLFu7yo7i61fyLml3llSH7vyO
 pjSNeELEHcc77/i/CMSjy6nmRXzLOx030b0wawjHnpSCGdHmh2eaFTtPjGGZ9OKPatR9LiEDJCT
 03y1fvQwoSBCYE5MPITlyGb5ia8XSsIgyZV/Ho2ZvNbOykymmezEKfWROvfNniykJsbURbxHoAa
 ue7M8+avjlG8SaiT1uCDJGl6mmL4uEPyFGrHLgQpe35vU7mXbnpMMNYtQcVeps9rX2q4Cvu/nGp
 YeIfh5F0s1oRR7/tT58eMvsdPnBkasCJHt1L1b1E9WyvwTC3Tc=
X-Received: by 2002:a05:6808:6785:b0:47c:be93:9214 with SMTP id
 5614622812f47-482e56c9a84mr5621620b6e.20.1778949850775; 
 Sat, 16 May 2026 09:44:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e55bbd0be3sm3919238a34.15.2026.05.16.09.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 16 May 2026 09:44:10 -0700 (PDT)
Date: Sat, 16 May 2026 10:44:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: Max Merchel <Max.Merchel@ew.tq-group.com>,
 Stefano Babic <sbabic@nabladev.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>,
 Peng Fan <peng.fan@nxp.com>, Jaehoon Chung <jh80.chung@samsung.com>,
 u-boot@ew.tq-group.com, u-boot@lists.denx.de
Subject: Re: [PATCH 0/5] Add support for TQMa6UL[L]x on MBA6ULx
Message-ID: <20260516164407.GP1858239@bill-the-cat>
References: <20260508115315.252623-1-Max.Merchel@ew.tq-group.com>
 <CAOMZO5DruUe7YY0+HiviP2OgsdBPgvJrhEBf0d0kt=J1K_Jbdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="yHzl7Ac2gZKOY2Nc"
Content-Disposition: inline
In-Reply-To: <CAOMZO5DruUe7YY0+HiviP2OgsdBPgvJrhEBf0d0kt=J1K_Jbdw@mail.gmail.com>
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


--yHzl7Ac2gZKOY2Nc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 15, 2026 at 10:07:18PM -0300, Fabio Estevam wrote:
> On Fri, May 8, 2026 at 8:53=E2=80=AFAM Max Merchel <Max.Merchel@ew.tq-gro=
up.com> wrote:
> >
> > Adds support for TQMa6UL[L]x. It has 256M and 512M RAM variants which
> > are detected by the SPL by initializing them in descending order.
> > It can boot from SD, MMC, SPI and USB (SDP). SPI however requires an
> > additional prepended NXP header image which is currently unsupported
> > in u-boot.
> >
> > Pipeline: https://dev.azure.com/u-boot/u-boot/_build/results?buildId=3D=
13172&view=3Dresults
>=20
> Interesting that it passed Azure's pipeline. It failed on Gitlab's CI:

Looking at the Azure pipeline, it too failed. The mx6 part of the job is
a failure. It has the same 4 failed to build, but didn't show what the
board name was that Gitlab has too.

--=20
Tom

--yHzl7Ac2gZKOY2Nc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCagie0wAKCRAr4qD1Cr/k
CozQAQDNsXaOeX6OyARLTYOH5C/MtB/xw4RBwCheAS0cVreI1wEA2lp/9FthhX6t
ISZJl1xPtJMIHu+4qgWos24S8IvJ3gE=
=H2BU
-----END PGP SIGNATURE-----

--yHzl7Ac2gZKOY2Nc--
