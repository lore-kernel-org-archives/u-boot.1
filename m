Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E674C021B8
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:32:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8AC0E80805;
	Tue, 25 Feb 2025 22:32:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AgG56BCe";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7058380F53; Tue, 25 Feb 2025 22:32:05 +0100 (CET)
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com
 [IPv6:2607:f8b0:4864:20::a36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D60B7801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:31:58 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa36.google.com with SMTP id
 71dfb90a1353d-520ac2b9b7bso1590973e0c.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740519117; x=1741123917; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y5tyXhejD1AliQzEPeeHNRGojmM+5OfPi92vqSMgmEw=;
 b=AgG56BCecJ1gmITwGntQJICBEJJiErUalU4fQl3G/CXRUkikRK61lgS1F3WoRvCxbx
 DQGAWw0TpYygep7MI6FBaMW8aQu1Yf3Z8iZtgbhOsrQ1nfugCzPp/FOfObNz69ydOutk
 bibHV/JtvUJFsoEZ7yjgme46mZwZJ6ctNRVw4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740519117; x=1741123917;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y5tyXhejD1AliQzEPeeHNRGojmM+5OfPi92vqSMgmEw=;
 b=j4sE5CbrhsU3rcZIqbP2f60nzMa9A4ZHd+nqdOU9+E1ND6IKT5tG16i+/IjRnBi2xI
 ZqC1938wDcNtxS7nsyBSKP3hJ6pcWmX94v8i3jHG6B8l+MQhDgBBZC9eKCJRB8IT4CPR
 UOlMbt3kP6vyiAItFn6zsWXUfWHbsH1Q3SjYO479krxiP6nLmH9xGS8FT9MnTSG5RgqX
 G21s1SN0jgEB6iZR+pR+Uhx4jAJXmx/qLIrc/letV9tLeiKSDcfNLF9Z75GSvs9yYqIs
 54wENeYGDfKJdkTHvjAsoqlWjHAtAKqIQOZIBtppZFAPSOKyiQ1Xpi2VD7FnFbl66bC2
 XCjA==
X-Gm-Message-State: AOJu0YzbS/vXtqnHCb3ca/YH5IeR8d3opdPPlEilhhn5hACkrpJbFzfx
 AewfUmwsCMnnhP88lDjs6T2piAn3X7o2XbAbW8EIuZEz4ntLSa0NdqKuwVocoyo=
X-Gm-Gg: ASbGncsE/pq8BuljnvGkzFz+3isitraRHi6upmhbKM3SGirpYWELjQhqlT98fM44J7A
 vYePJAaPDHfNnUvVcvdaEUx24hAqBpeCLRXD5jCLXfSG6uBPD6jER12RwSZs9dlGk3ZGP+UHmRL
 Gj8nPubO/fLD7SINBf5hKCLWyxjSlGdx+Lx0JlHyIiJwFCxKW0P6FC+1ZmHiDYjD/2mmak0gZl0
 4ErRBAqQ9DBiy+2tBKrWbG+nYW4ck/YHVqZTRQEIMGhP7t0JqZESLnM++dX1leG7zzxLRJvZWP/
 PWVJ/hp/OOPH3jTpc/crq1w5
X-Google-Smtp-Source: AGHT+IFhBTjf24phLUTqC9tM9UNEIWUdmQHGvt3YL2mHHWTxRrllt7yDvGmnK4ebRM93FifMvfI1Xg==
X-Received: by 2002:a05:6122:3189:b0:520:4996:7d2a with SMTP id
 71dfb90a1353d-521efd9f81cmr8581011e0c.10.1740519117451; 
 Tue, 25 Feb 2025 13:31:57 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-86b1ed71838sm473782241.19.2025.02.25.13.31.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 13:31:56 -0800 (PST)
Date: Tue, 25 Feb 2025 15:31:52 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexander Kochetkov <al.kochet@gmail.com>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Brandon Maier <brandon.maier@collins.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Neha Malcom Francis <n-francis@ti.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Peng Fan <peng.fan@nxp.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: Re: [PATCH 0/7] binman: Check code-coverage requirements
Message-ID: <20250225213152.GB2640854@bill-the-cat>
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9MCmknR7aR7lX2/N"
Content-Disposition: inline
In-Reply-To: <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
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


--9MCmknR7aR7lX2/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> >
> > > This series adds a cover-coverage check to CI for Binman. The iMX8 te=
sts
> > > are still not completed, so a work-around is included for those.
> > >
> > > A few fixes are included for some other problems.
> > >
> > >
> > > Jiaxun Yang (1):
> > >   binman: Workaround lz4 cli padding in test cases
> > >
> > > Simon Glass (6):
> > >   binman: Exclude dist-packages and site-packages
> > >   binman: Drop GetRootSkipAtStart()
> > >   binman: fit: Drop unused code
> > >   binman: Drop algo check in CheckSetHashValue()
> > >   binman: Workaround missing test coverage
> > >   CI: Run code-coverage test for Binman
> >
> > While we likely need Jiaxun's fix in order to be able to update to
> > Ubuntu 24.04, the series itself doesn't apply to -next, please rebase if
> > you intend for this to be in mainline, thanks.
>=20
> OK, would you able to pick this series up?
>=20
> https://patchwork.ozlabs.org/project/uboot/list/?series=3D444576

It also doesn't apply. You should really put together a PR, against
next.

--=20
Tom

--9MCmknR7aR7lX2/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+NsUACgkQFHw5/5Y0
tyzYhAv8C9SP2p1Vp0wIZt/6rBdEAYXkZ5HYiKe/Mx+6RHZEZsQ3TzWhK66vWZFN
/Npq83KlhJHNIxAvk+J5a83kgFSBSdzYc0Fs/3/Enr7RXUBNkFRmER6gYAdWRRpP
0fvVQ1fmzNybvRANMhYea5gpfkfDUwpPKg771h6RT+kkaojmdUrmj1QhS45v8bXn
8BC1zruCRBUWD1b2jRQzKqrKTWIKcSSzD47EKpFOsntM7QmRayNpPzVzQ7ZYBqrL
krxVGqmflchCD4SCdwoyzWnKobjXk+zFK4tevRxSjeAFyfcCdkmc5be2Zxf2YMQc
6xgJxspt1aSqaT2ixVGYhYvWYAh3pDPGlbdhIwyXJON83kYiYAXxwOybsAOh+c3Q
nvmu2blGIx2LdxLwDWkZJ/7sai4Z7VuyMlW/lFq1D2d3qPPS/OeoSIn44BWvS25h
seccWymQVho79Q+TjXkOgjvklCivM5yuEQhD28pmDvRLUuPHBjgznFMlC4CFdHxd
IQJCW1Kc
=uynA
-----END PGP SIGNATURE-----

--9MCmknR7aR7lX2/N--
