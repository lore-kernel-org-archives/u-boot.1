Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A240C021B2
	for <u-boot@archiver.kernel.org>; Tue, 25 Feb 2025 21:53:17 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id A98F780805;
	Tue, 25 Feb 2025 22:53:15 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G997fcty";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9D50D80805; Tue, 25 Feb 2025 22:53:14 +0100 (CET)
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com
 [IPv6:2607:f8b0:4864:20::a2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2B3E5801CF
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 22:53:12 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5208736db3fso1818827e0c.3
 for <u-boot@lists.denx.de>; Tue, 25 Feb 2025 13:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1740520391; x=1741125191; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FWyh7EkisFJnVxyiTvJV0vUbxnzNGyvGoq5xIRIQz6o=;
 b=G997fctyPo5pn8m5gyzdkggvqaIIeemGgE19AaTCynhfW6qpWoAkLw+LFF97V34XtM
 ouUYrnPHQIP9z2F2X+o2cKWL95a7KrGHXNcGxsTympWY8g9r7WD+B8c6trcJ+zjdCbDO
 Z3rKK1TH4UHeQXtuT6XKGA+ZebuqlkKqxazV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740520391; x=1741125191;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FWyh7EkisFJnVxyiTvJV0vUbxnzNGyvGoq5xIRIQz6o=;
 b=OdLwm56nnS52p9phwMMINlSLnECpBt7bQF53QxjlBMLw849BDWGmhamV39cjZwfe0X
 r5ux2gqHXxrPW2r+avvMaqON9UZvz5vQnw7ePESqI6Fh8/I5M6hcRHq3P9CRtgEjSvUk
 RhRtzlQfYfrwfYBoIsvC64dP1MiVBEpg4XO0yJ7qKb9Qtc0ABpHsKgdk6nn5yXDDmVd1
 4La5r3qLCY0cWgkniSPEKTmj4WdZmMvVLE7viUZhzNsuIZgphuG/z7rM/aIY2mmKilrZ
 bTaxeg5UgBNOSKqrG0d8LmGt6tidOSl4oznhPdgdJtQIMUNsI7mcDunJJkut3Vt5j5w8
 iSUw==
X-Gm-Message-State: AOJu0YzFMMImCP6nRJKwfN+T0stD2CQltNzDjVSO5SEj2OqG3heCYOiF
 P5JMhsDLoo3CEhaR78xmpLqlmoN+1iQQsgJx67ODXiUZPsiCmXXPZr8IrAtHSzI=
X-Gm-Gg: ASbGncuFibwWvezAcFJ7BFw95MbD8yrC0nCvEWKelakzwfHN7OnoRfh2Firp9CJaHf9
 Menlrh1Cu7mycBzb1/aar6y4qUZJCZWqTz3HmR/7ys0EKWrHgj25n0gikpFrnorDvS2VtqL/v++
 gG5LrJwH28uhcGvyc/p7Oid1vcoaShSzJeJdcGadzOCSrmI6hgnB/n21BEcU8I+xFcx8dxmCRVE
 9MEcIg2Y1Fg1IXk2svTaAHK6OQttlE7yYvAPEmYBPxfnhilQwzA3ArvOOV2IhelE3LFAlxBuHuE
 Zr0FdQz+pmj5VlEGLHY+VRUS
X-Google-Smtp-Source: AGHT+IHEDvdTfgPx2oqYIz8389bR7pakt7KNeGFzpAq6xs1tT8kcpB6IgKTmAuQDlB0fymP+4j/hnA==
X-Received: by 2002:a05:6122:ec5:b0:520:5a87:6708 with SMTP id
 71dfb90a1353d-5223c995166mr3223538e0c.0.1740520391015; 
 Tue, 25 Feb 2025 13:53:11 -0800 (PST)
Received: from bill-the-cat ([189.177.125.6]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5223e1e0b04sm391227e0c.45.2025.02.25.13.53.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 13:53:10 -0800 (PST)
Date: Tue, 25 Feb 2025 15:53:06 -0600
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
Message-ID: <20250225215306.GD2640854@bill-the-cat>
References: <20250225200635.3781149-1-sjg@chromium.org>
 <20250225210645.GA2640854@bill-the-cat>
 <CAFLszTig7O=Eyx+C0xAsxkJi+rP_ghXgXBxUwN47GZLxg-KFwA@mail.gmail.com>
 <20250225213152.GB2640854@bill-the-cat>
 <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UKwtSzZl9dxtwprg"
Content-Disposition: inline
In-Reply-To: <CAFLszTicCUoW7qqy8qDwQ5a_9HuwwLExQsFdAuYRnXG5-J_NYQ@mail.gmail.com>
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


--UKwtSzZl9dxtwprg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 02:44:12PM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Tue, 25 Feb 2025 at 14:31, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 02:26:39PM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 25 Feb 2025 at 14:06, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Tue, Feb 25, 2025 at 01:06:25PM -0700, Simon Glass wrote:
> > > >
> > > > > This series adds a cover-coverage check to CI for Binman. The iMX=
8 tests
> > > > > are still not completed, so a work-around is included for those.
> > > > >
> > > > > A few fixes are included for some other problems.
> > > > >
> > > > >
> > > > > Jiaxun Yang (1):
> > > > >   binman: Workaround lz4 cli padding in test cases
> > > > >
> > > > > Simon Glass (6):
> > > > >   binman: Exclude dist-packages and site-packages
> > > > >   binman: Drop GetRootSkipAtStart()
> > > > >   binman: fit: Drop unused code
> > > > >   binman: Drop algo check in CheckSetHashValue()
> > > > >   binman: Workaround missing test coverage
> > > > >   CI: Run code-coverage test for Binman
> > > >
> > > > While we likely need Jiaxun's fix in order to be able to update to
> > > > Ubuntu 24.04, the series itself doesn't apply to -next, please reba=
se if
> > > > you intend for this to be in mainline, thanks.
> > >
> > > OK, would you able to pick this series up?
> > >
> > > https://patchwork.ozlabs.org/project/uboot/list/?series=3D444576
> >
> > It also doesn't apply. You should really put together a PR, against
> > next.
>=20
> Oh, it needs another patch anyway. I'll send a v2. Once that is in I
> can rework this one.

Again, it would be helpful if you would send a PR and always base your
patches on the appropriate upstream branch.

--=20
Tom

--UKwtSzZl9dxtwprg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAme+O8IACgkQFHw5/5Y0
tyyxkAv/SV804IktKZTZg/3VnbMBKjN0fuGVrcqX5/LiHYVmsv8gyis8zm1nRT1+
G8HC56/OrbWMwdd7Xediipebc0Rd7JE8F35TUggsQ+9kKWDqT/nXaIJKO86w32Gm
uTtlnS0TCf9bjnRW0NCXUIB3SlmpTJiaSpdzSyKvX2y/ZBcLLqWzD1gdA60Ly4Ck
4F1LEd5uf+x+E2adxXAMS51wkOwP4GyNtEqPibNic5q8wVdKbmmMUjfQYYHVCMxK
ISkQmOyj8o5p7NAekxCTjOh7vzz/pT0wqJEV+e9k9JK8QbUK5eumDv90ssjGJzJs
WrJvjDIMiJca+rXcFD/MHb1csp23a0ITk8LKVZEsE1GfMN3WWTlx1lKAviqmsAIx
XwarKJTMfoWf0KjJuOMNbIoDK0zvxvHoMDW6uM5SAArRoBnJYRUwVgovgWaUO7zO
btG77pmnatJ9t/f5V7oIQAKtyGyOe4JI4K6Nk+0ThEK6GoAIjA4nw3refvKme6Kq
F4sNGRze
=+TNp
-----END PGP SIGNATURE-----

--UKwtSzZl9dxtwprg--
