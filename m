Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF55C3DA6F
	for <u-boot@archiver.kernel.org>; Thu, 24 Aug 2023 14:16:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9AFCB8657C;
	Thu, 24 Aug 2023 16:16:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="o+QpvIsy";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3A15586481; Thu, 24 Aug 2023 16:16:10 +0200 (CEST)
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com
 [IPv6:2607:f8b0:4864:20::112f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C20686433
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 16:16:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-59234aaca15so39978257b3.3
 for <u-boot@lists.denx.de>; Thu, 24 Aug 2023 07:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692886565; x=1693491365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fxXUHnP771FSOBpt+Tgnu0RUkv6GzAmgl8I4xJ9PNWE=;
 b=o+QpvIsyyATdqhn2wZ9RJPe5TvZKcGWjBncTgiylNJOaBScX/W18PKmFdjV4K0BjHv
 sKSuJmNyo4Ba2MUfCUs/4j26dJylheodBdu6Tk1YbiVyhWn6oZtY9Cx2aAvXOwaExrDw
 xfAWqOWcg1Kz3oLoaFObadN63e47egZhCaNkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692886565; x=1693491365;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fxXUHnP771FSOBpt+Tgnu0RUkv6GzAmgl8I4xJ9PNWE=;
 b=dVq/xmjX73YMv5x2sOygWUnF8K6bpaQhwx0oMWh9SuR51Vv5hqRkoEQh6byHwZIeri
 5BjH9QUEMYT916qiIHX7zX7o1hVxHAYLA9avuW0agn93Z9jtGV2dLzmzy34a3CZvoari
 IS3aUvf7BGUMKFen8seInXhEd5ESzQdI9L2jdCqVNHn8zNeXW7JvdfA7IWKEmNWC3FzX
 WyCKGT0pd3xxxwkdyNKwZcnu9CWREEZHpyoAHSu7aFsMhn03cWZSl1Rmm5S0PRHZ5k28
 Q9hjDcsEOefzyIZ1zrkhi2QGsoZFuk8WAnOlfgkjxg4kBgv2lL+zyTba3adabaQTXdIO
 3fjQ==
X-Gm-Message-State: AOJu0YyvnOaUD0U4j6z3dl15kYGXfhc+IkebIC5tJx7ZTpYAb8EzuEpo
 HOVLP/qwfFPUjWXlc6bmn/IIFQ==
X-Google-Smtp-Source: AGHT+IHXI2Kke2bQaJOD7pxLxg4anVNyP7Crr/W58bzxZRZQmhaRnnlB87DXPlLjviaDoib8th09KQ==
X-Received: by 2002:a0d:c182:0:b0:589:ad30:5f5 with SMTP id
 c124-20020a0dc182000000b00589ad3005f5mr12824061ywd.52.1692886565689; 
 Thu, 24 Aug 2023 07:16:05 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-37ed-1199-bcc5-406f.res6.spectrum.com.
 [2603:6081:7b00:6400:37ed:1199:bcc5:406f])
 by smtp.gmail.com with ESMTPSA id
 r123-20020a0dcf81000000b0057087e7691bsm3941795ywd.56.2023.08.24.07.16.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Aug 2023 07:16:04 -0700 (PDT)
Date: Thu, 24 Aug 2023 10:16:02 -0400
From: Tom Rini <trini@konsulko.com>
To: Nishanth Menon <nm@ti.com>
Cc: Simon Glass <sjg@google.com>, Neha Francis <n-francis@ti.com>,
 Bryan <bb@ti.com>, Praneeth <praneeth@ti.com>, Andrew <afd@ti.com>,
 Robert Nelson <robertcnelson@gmail.com>, Vignesh <vigneshr@ti.com>,
 u-boot@lists.denx.de, Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Jan Kiszka <jan.kiszka@siemens.com>,
 Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Subject: Re: [PATCH V4 8/8] doc: board: ti: Add BeaglePlay documentation
Message-ID: <20230824141602.GK3953269@bill-the-cat>
References: <20230822184135.2328409-1-nm@ti.com>
 <20230822184135.2328409-9-nm@ti.com>
 <CAPnjgZ1wGkq66ZEXHUVzLpc47fYgV0+Kk9WNwqDWcO0R7jEYVA@mail.gmail.com>
 <20230823171502.GQ3953269@bill-the-cat>
 <CAPnjgZ2t2aUnreA8Hzg11moQ2Z5hqW1r-16WTF0PRMjK3iXe_A@mail.gmail.com>
 <20230824001848.vgzl7rcphic3gu2n@carnival>
 <CAPnjgZ2qxm0KGFp5dM2Jzzcuib5npXodhYQ6u+dbO3oSBHA55A@mail.gmail.com>
 <20230824032709.phneggflsw2ps2dv@reanalyze>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="YWaNAGoAjlNWwjq2"
Content-Disposition: inline
In-Reply-To: <20230824032709.phneggflsw2ps2dv@reanalyze>
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


--YWaNAGoAjlNWwjq2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 10:27:09PM -0500, Nishanth Menon wrote:
> On 21:01-20230823, Simon Glass wrote:
> > Hi Nishanth,
> >=20
> > On Wed, 23 Aug 2023 at 18:18, Nishanth Menon <nm@ti.com> wrote:
> > >
> > > On 17:57-20230823, Simon Glass wrote:
> > > [...]
> > > > > This is how we have a common bit of rST for how to build N boards,
> > > > > without having to do a literal copy and paste N times.
> > > >
> > > > How about using this?
> > > >
> > > > https://docutils.sourceforge.io/docs/ref/rst/restructuredtext.html#=
substitution-definitions
> > >
> > > I was not able to succeed with complex includes such as:
> > > https://github.com/u-boot/u-boot/blob/master/doc/board/ti/am62x_sk.rs=
t?plain=3D1#L89
> > >
> > > am62x complete build procedure defined once and reused in other am62x
> > > platforms.. But the am62x build procedure itself is reused from common
> > > k3 build steps.
> >=20
> > I followed through these instructions. I find the env vars quite
> > confusing, since I don't really know what it is doing. It feels like a
> > script:
> >=20
> > do $a $b $c
> > do $f $e
> >=20
> > it is pretty hard to follow. I think it would be better to write
> > everything out in full for each board, like rockchip does.
>=20
> Unfortunately, this is a few major steps that is repeated for
> (currently):
> 	AM62x SK
> 	Toradex Verdin
> 	(pending: beagleplay - )
> 	(once all the dust clears up, hopefully phytec)
> 	SK-LP
> 	....
>=20
> I have no reasonable way to offer to keep them all in sync.
> 	https://libera.irclog.whitequark.org/u-boot/2023-07-26#34662854;
> is kind of why I went down this path.S

And please note that I do not like the way we're doing this in other
platforms.  That we have almost verbatim instructions for building TF-A
and OPTEE for nearly every aarch64 platform is not good.  I was hoping
for something more truly template-based and that we could expand out
=66rom the K3 case to cover other platforms as well, but we're not there
yet.

--=20
Tom

--YWaNAGoAjlNWwjq2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTnZhwACgkQFHw5/5Y0
tyyPkwv/aeWRgy+1njnjIG2wWjWZk4QgiZXm7P2fp/Z/V+WUFNIjkVTYDZTZqVk3
z/aMznpKv5rX/wzC7bm7pOX4HDHXuwrH+Uv/03k+lGuwvhzmKt7g6OuuXt38or22
73qDh39KnWncKSin7xKV1OS3JYqGAUTIrjV+NihTeH7mNImqQxHeqFwn0yBW7HL2
FG4jkRjD57nFdXqQMo74dnH43eVLfGoDPRCIDD2VhffW8XYrMTS3K17SvhfJ53x7
7oY6K7LbrLZBTEMFHI2kK/n8zovKAltkWSBS4UFG9VP9jh6emXt70tdpZaFfX1n1
MacGmo75DFj8rFDhUOtMpq3kQDHfSy/UhQrmmPD6DHDncwZ7O1QzmChRl2grvo7c
UFojbWYXoDNZ8xJLV5jvE7K0roiWN49/fEx48LUPl1PxcZM/S6kyy9ny5QCKpv9v
FACxj8CyoeY1rAcRffrTzTTLnuRpq+vfumqH0hb9Ac3AjImDZ3ujMeypQAjlYhzH
lO91ft2C
=zhX2
-----END PGP SIGNATURE-----

--YWaNAGoAjlNWwjq2--
