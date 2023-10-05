Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68CDBE9271B
	for <u-boot@archiver.kernel.org>; Thu,  5 Oct 2023 17:19:20 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 91BF286C9F;
	Thu,  5 Oct 2023 19:19:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="UDTWj8VE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 04C4386C9F; Thu,  5 Oct 2023 19:19:16 +0200 (CEST)
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com
 [IPv6:2607:f8b0:4864:20::1136])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3D43586C8E
 for <u-boot@lists.denx.de>; Thu,  5 Oct 2023 19:19:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x1136.google.com with SMTP id
 00721157ae682-59f55c276c3so14332187b3.2
 for <u-boot@lists.denx.de>; Thu, 05 Oct 2023 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1696526351; x=1697131151; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=8yuRhHvnxNR43dwnufpq/Jymuwk0Ua88Z1V/29xgP/k=;
 b=UDTWj8VEuhwLa3hHnkCx05We9BVXFEJ8xqzk1sUHyMMIZoweXWSdsarg61OnXHUaBk
 +V3k+w+CHR1AfDd5VNK20WYszqJesOXlbvrnkHRk1hvxIa58qbuTHtAJ2BF/pOr8opZh
 JY2V2bTu4yU8NWRJmIqxCcNwc8Iwhw5OHHXcI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696526351; x=1697131151;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8yuRhHvnxNR43dwnufpq/Jymuwk0Ua88Z1V/29xgP/k=;
 b=viaiAdOdMtrkXZNAguOiBNHr+ycCovrQZvzQfblBHTDJFCAil5ehqhqKd2QSS6iTKI
 AR9tfyTDDaXgK5OQESl2UZx6ptrOaHfowURN/ijtABjb17DpI3mUoJS0pUA/VyLwiIfZ
 i270RiYxwxoD3qYUSPvS5Rkw6LGEI11uURiJusRDEbWevyhUF970gR7inj5zmnbVlRKx
 EyEripIdG4Aqsf3Z6ZF7yrlQSfeKObs3EA81SSsg9s96afaA2Xo7WkNgYCqVkyULZBLf
 jnl/G58XzVrM/G5gkoCBYoqcl2Qj3eqErNUbRYzCeRyywelZxpl2mFrh0Z6DwsK9Hrwx
 jNmA==
X-Gm-Message-State: AOJu0YzKJkYMTRrGwx8Rfjs4R1kK7J35U7yQZizUO/qLFY7OUhEyP5W4
 jxJlr1c9H8RNoDtPJVpoXsTfvw==
X-Google-Smtp-Source: AGHT+IHZQafNHjPTlIV/qpm5L1QFeAX8bk/xVuySEazS7FSZBlQmN7jhg20VygSueJuxTuOU42kBAg==
X-Received: by 2002:a0d:db52:0:b0:592:9035:8356 with SMTP id
 d79-20020a0ddb52000000b0059290358356mr6192226ywe.26.1696526350915; 
 Thu, 05 Oct 2023 10:19:10 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-f1fa-53fc-3572-fce8.res6.spectrum.com.
 [2603:6081:7b00:6400:f1fa:53fc:3572:fce8])
 by smtp.gmail.com with ESMTPSA id
 h64-20020a816c43000000b0059bc980b1eesm644983ywc.6.2023.10.05.10.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Oct 2023 10:19:10 -0700 (PDT)
Date: Thu, 5 Oct 2023 13:19:08 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Simon Glass <sjg@chromium.org>, Roger Quadros <rogerq@kernel.org>,
 vigneshr@ti.com, m-chawdhry@ti.com, jonas@kwiboo.se, srk@ti.com,
 afd@ti.com, bb@ti.com, praneeth@ti.com, u-boot@lists.denx.de
Subject: Re: [PATCH v2 2/2] board: ti: am64x: Switch to standard boot flow
Message-ID: <20231005171908.GT8465@bill-the-cat>
References: <20231005130642.21402-1-rogerq@kernel.org>
 <20231005130642.21402-3-rogerq@kernel.org>
 <CAPnjgZ0uMLFdqvpcDMKnXQDL-m1ecUB33gat4EZK7jm=UeEB4g@mail.gmail.com>
 <20231005163148.GR8465@bill-the-cat>
 <20231005171407.jijjxbt66vakivap@chemicals>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OZczNeV8ZV8jYH0e"
Content-Disposition: inline
In-Reply-To: <20231005171407.jijjxbt66vakivap@chemicals>
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


--OZczNeV8ZV8jYH0e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2023 at 12:14:07PM -0500, Nishanth Menon wrote:
> On 12:31-20231005, Tom Rini wrote:
> [...]
>=20
> > > >  /* Now for the remaining common defines */
> > > >  #include <configs/ti_armv7_common.h>
> > >=20
> > > It looks like this file still includes distro_bootcmd and defines all
> > > the BOOT_TARGET things. Can they be dropped? Perhaps for now they
> > > could be put behind an #ifdef if other boards need them?
> > >=20
> > > I suspect that with your patch as is, the environment is still full o=
f scripts?
> >=20
> > There's a lot of TI platforms, so I'm not sure what "#if" you're
> > thinking of might make it cleaner?  We could / should move some of the
> > still relevant content and comments from that file to
> > include/env/ti/ti_armv7_common.env as I do think some of the K3
> > platforms could just drop <configs/ti_armv7_common.h> at this point.
>=20
> Is'nt the header distro_bootcmd.h and related stuff under #ifdef
> CONFIG_DISTRO_DEFAULTS already?

That's true too.  The file (and probably all of the other *common.h
ones) likely need some cleaning out of dead comments, etc, from the
Kconfig migration.

--=20
Tom

--OZczNeV8ZV8jYH0e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmUe8AIACgkQFHw5/5Y0
tyxhWAwAunoQz65vX7sRhNb7QDm6vW+Wcc2RlakgHQVFiw1iwDmTsSXomtxmC1Wa
RuhSpgtzH/nWjdPRi4sPesockSZKu03k+fzMPqeXIk+KcKEnOzin4qXIm4RCeenk
AgiD7X4TROy0XePIZu0ENI8GRIdGX2XytQVbpwmcQ6iJXcns+341Iz65n3vI5xzp
F5Ww94HZ3QAmRhiajbHSBiQmq8q/PK8Wc5TrfwcLkuKAq6gmxMAeFSXmm0bAoT9W
REQYHgGJruRX66SuMT/3eP9Uqr4jqAGi+eSd9I9FIJKX9v2WKx572hXi3mArEFNy
zxVBlKtT9560OSFOkux9L/O9dMjEEQ0GWtdks0Av8sQ+MNTg2xvY5jH3ZY9gAiEr
ySHKeCG/y/Z3VfbSFUHvGjhzblofqfOvQ65d0lBFn5smeUPWGKw+6sCdcJOHbh6W
VmH/X0CIKTXtpbHGGC/WR5ImDPnW4GHaSqEy3B7gx3YRimURn2BmS7DyCkcLAeqo
0szOKyo/
=UhkQ
-----END PGP SIGNATURE-----

--OZczNeV8ZV8jYH0e--
