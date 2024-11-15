Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8167D68BC2
	for <u-boot@archiver.kernel.org>; Fri, 15 Nov 2024 14:44:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4644688DD0;
	Fri, 15 Nov 2024 15:44:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Iw446kBW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2378E88EAF; Fri, 15 Nov 2024 15:44:19 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9B4E488D90
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 15:44:16 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-6d3f5b0cbd6so9539866d6.2
 for <u-boot@lists.denx.de>; Fri, 15 Nov 2024 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1731681855; x=1732286655; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gY6zMMk4WbHP/301pbi6MMD9nEUTv4jE1tmMbAHELF0=;
 b=Iw446kBWdX1lPuEzMzNYKOdHVsDuovBhewu2ETiYNwv8Bm+g8C8if0seNCSQWP2Cmg
 yEBIhGoNpyJhaPS+YqplmCjn3KuCmyn2O/RVpujgUpv+D80BC3+mevQcdZekRJbqe0hy
 5yX7JA3Zm2+AR5sRaS6B4++qGk4ziJchHTRo4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731681855; x=1732286655;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gY6zMMk4WbHP/301pbi6MMD9nEUTv4jE1tmMbAHELF0=;
 b=Pr8zZg46Y9W7Ny80QuovZL1b8o+Jq2jr6Yoy/YIpalM0MJwcfsdQyrrShto2Hn2uQY
 C0Vj90VNU9UWA2L7CdDjPawcptBBJKZf/vhsA/08h6Jk32AO7yJn8lGgXqzBkSNkooVE
 MEQrUssYt7xLX5BwWejUKxh4oD5ylgt40msMRKBROVlIc+BsADd8LTZrs9FXPu2wD0EE
 iRGUQ831+Ov5JzEWtNN1yoK+lfxKvlpZmfmyyrjoveeRpvQWxpXcCajxpZbf9mp5xfoV
 21sBkh/MDgWTfUUIvY+BNf6SHBhSyM8fKRVOjsamSRhhQEQ8aaq2b2+M1bQXZZEHL3cO
 6gYQ==
X-Gm-Message-State: AOJu0YzPV7D//7GV9MdyaZCPYLF0tuOogTxT7imJO1xQimuxqBWFQwjt
 iqUtQz2es9t/kIAhsL+SUgv2uQic1tgYqkN8Hi2pLKov58fN7b/aYABlFzs/EgV6ttmWH8NR5oq
 fh5M=
X-Google-Smtp-Source: AGHT+IHGhOKfSQnMkxRsYYjDbNyB7rNHxIU4vxcewUI7kimX0f6WITcrp65qnMe2iO0tyXcyvsltBw==
X-Received: by 2002:a05:6214:5690:b0:6ce:26d0:c7b4 with SMTP id
 6a1803df08f44-6d3fb85a4d5mr37997166d6.44.1731681855389; 
 Fri, 15 Nov 2024 06:44:15 -0800 (PST)
Received: from bill-the-cat ([187.144.30.219])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d3ee932857sm18384176d6.118.2024.11.15.06.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Nov 2024 06:44:14 -0800 (PST)
Date: Fri, 15 Nov 2024 08:44:12 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 8/9] buildman: Propose a format for extra boards
Message-ID: <20241115144412.GV3600562@bill-the-cat>
References: <20241108152350.3686274-1-sjg@chromium.org>
 <20241108152350.3686274-9-sjg@chromium.org>
 <20241113024029.GH3600562@bill-the-cat>
 <CAFLszTirek2=_j15W5LCZERTs2TZXawV0o3aGO12dgDJpzTdQw@mail.gmail.com>
 <20241113222016.GZ3600562@bill-the-cat>
 <CAFLszTivnmnB+1p58sZ_VSZBWpL1Kt7QJ=mnnEvHZswAeEZc0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="L1qCxZxVXMmYkPtu"
Content-Disposition: inline
In-Reply-To: <CAFLszTivnmnB+1p58sZ_VSZBWpL1Kt7QJ=mnnEvHZswAeEZc0g@mail.gmail.com>
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


--L1qCxZxVXMmYkPtu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 06:37:18AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 13 Nov 2024 at 15:20, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Nov 13, 2024 at 09:03:35AM -0700, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Tue, 12 Nov 2024 at 19:40, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Fri, Nov 08, 2024 at 08:23:49AM -0700, Simon Glass wrote:
> > > >
> > > > > It has become more common to use config fragments to extend or ad=
just
> > > > > the functionality of boards in U-Boot.
> > > > >
> > > > > Propose a format for how to deal with this. It is not implemented=
 as
> > > > > yet.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > I think that the first problem is that this patch series is an
> > > > inappropriate method and place to start the discussion.
> > >
> > > We had a discussion a year ago but it trailed off.
> >
> > OK. Still an inappropriate place to resurrect it.
>=20
> What do you suggest? I am trying to solve the problem, not just talk
> about it, so patches are often best for that.

Well, in that there's a problem to be solved, it's that buildman makes
#include more painful that it should be to use.

Or, we validate config fragments by building them. A requires-buildman
solution is not appropriate. That:
https://patchwork.ozlabs.org/project/uboot/patch/20241114115049.2070780-2-p=
atrick.rudolph@9elements.com/
doesn't use the acpi.config fragment is because of the parsing issue
buildman has.

> > > > I also think this gets things backwards as the common case is "make=
",
> > > > not "buildman". We need more defconfig's that are just base +
> > > > fragment(s) if they're important enough to be a combination that ne=
eds
> > > > to be tested and work. A board is not a time-expensive part of CI. A
> > > > pytest run is, a new job itself is.
> > >
> > > OK, that would work too. It would also avoid the problem of combinato=
rial
> > > explosion. But I am not seeing people actually doing that, with rare
> > > exceptions.
> >
> > I think it's the exception, not the rule, where config fragments are not
> > being put to use in a defconfig. And that's possibly because not a lot
> > of people seem to know about the #include option, and then when I
> > explain it exists to people the next problem is "Oh, I have to do what
> > so that buildman also works?".
>=20
> Are you looking for any feature in Buildman for this? This series is
> intended to fix [1]

Yes, the part of this series that, if I read it right, causes buildman
to read the preprocessed config file, rather than the raw defconfig, is
what should fix that, as the final patch in the series confirmed.

--=20
Tom

--L1qCxZxVXMmYkPtu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmc3XjwACgkQFHw5/5Y0
tyyYFgv/Q8NeEWZXKuL2hZCzgxYiSPJQK7U3SF65TMYglsm2MkJuo+vrNJldOZr4
mvDYFg+IJ+mWhblq8biy/6kcVJVIZLnYz/WtXFl+bR30HewIEL0UPeTJFL7eUAEL
QtFjhqGkQFfyA9TJun6Gahg0iKCmI7LXD9ncGk6/Eh7ulvd1rxigk2r/4bjnWoez
UmQR1ruRMMuqA51YB6Tp21/qUuMSXowO+igXqtAjHZaptf+Kw+TJRpQAuBMnWEOb
5FgwxNSXFOnTrjq9ApDkDfCIgCxZAcdNh01EfXuRtjhFB3UyB1ApilK7/o8GUA5Q
Jx5ZYR1wpUA9fn+KizgZDJOhT6UA7F6K/nxF8WCquO62dFrkPogs2W+s/mxM2kJ9
hKleZyHTB3czo+m8cznbnetkBQRu3L+bIed9NtK2ZtaT9hFWSH1zmdA1FheQbXNX
22rUwZ9mYbIXLBqvHGTo9F4cRL2FYyjT2GSxonA5fmANXEB2IOuzAtR7PG+N/f+o
F1jJt9/W
=uT8+
-----END PGP SIGNATURE-----

--L1qCxZxVXMmYkPtu--
