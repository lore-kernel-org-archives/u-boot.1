Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52599E7717F
	for <u-boot@archiver.kernel.org>; Tue, 10 Dec 2024 17:09:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9000F80285;
	Tue, 10 Dec 2024 18:09:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="l9Xqajk2";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C69EF80285; Tue, 10 Dec 2024 18:09:04 +0100 (CET)
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com
 [IPv6:2607:f8b0:4864:20::f29])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 135BD801ED
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 18:09:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf29.google.com with SMTP id
 6a1803df08f44-6d8a3e99e32so45971596d6.2
 for <u-boot@lists.denx.de>; Tue, 10 Dec 2024 09:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1733850541; x=1734455341; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=AS7NpiZkaFjpK+vUIcdTvsaesPaQmYcwExJnQCPiwL0=;
 b=l9Xqajk2ueOgbeCFSRmXTc9RKevgiK3utVOfmPGFSbv9zM8LiJdhVzsy2bno8JYjRr
 Z7vz+jOe+/hZnQqePrFG6RubeCGVwyQcy35sS/YCKV9ZDv1y5Ht0xONpWdOhL9QFOIy+
 Lf8c7Y0pC1QR9Lf1IVCp1fbT+Nv1bKJIEB7G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733850541; x=1734455341;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AS7NpiZkaFjpK+vUIcdTvsaesPaQmYcwExJnQCPiwL0=;
 b=RqUEir3t8vj2iylsah+7Og3jp0nASB2ZCoJ7PLKzCuL6aKaVEgIdLOlIoL4tGcsmZf
 pXum80tUy3v1/DBWzHkJm6LrUUXTVohwNpxAtm435bZun0GfqPEyNnYbtppbFBRzH1m0
 +b/uaiwvCqbEvE4jIr5s8EXx69Ckmy+//srGeAdGAuns0KE3osc5Rr+Os/zMFTg36XRf
 5AK+ZY8raUpR8jnWBEb8Apb8ZbHlhtaUg/fLsb21JSjOXvXyhJ6o6W/D3rg6eL2i5oxq
 kZ/pato6Vc2VuKxl154Lrw4l/dJrPLF4KtFASihFIxIoU70ZvWzLjbxiAfLlmUVji9f/
 5EeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUvQv4gpYdok1rldarSrsmGiIhArNZAaKkf+2JUdHfNEIH9jjc33E+4Pxfx0voX4hBIex9ytro=@lists.denx.de
X-Gm-Message-State: AOJu0YzeKvw1ndhH4wtDDRJ5yNaCM+IgVGG9CsdU6hu3XMhNx78ufKVI
 bHqNTspDdJPmRE7k2A+aUYCEysiFH9/sUVcbhkEPx4ZR7adl5PYo1SQvJIJBGqs=
X-Gm-Gg: ASbGncvM2RzuhItKNXsgg+fy2GEY7KhMLDQyXef9Svp8fQNTCeEhM8XBeW8c/3jUb7s
 W055xyERizp9yU0xwo2Ep9hlDcNopIhoVcjy3JRV80ot15O+4jEdO0Chna0V/mFjP7FB94vY5HI
 6frpN5e1qreb6Nh5tCQDo1B5+dnXl0Mym/xHQWfcjd/NsbcJUBxjHO1HlXGXoh9ACqYPYqi/YzI
 84f1W9THjZYf8lBlWykIMLux1psW5XLiuncqtRALqfgs5FI8TFrbw==
X-Google-Smtp-Source: AGHT+IHjtnlfgoNB0xj/uHcyfcRTW5gX+qlNypQ0Hh1oo4oa8lzaPQaPp+beJGVfRB0qBQNmmSkmRA==
X-Received: by 2002:a05:6214:19c5:b0:6d8:8fbf:d1b7 with SMTP id
 6a1803df08f44-6d91e44b205mr70431156d6.43.1733850540861; 
 Tue, 10 Dec 2024 09:09:00 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d8da6b2291sm60952356d6.58.2024.12.10.09.08.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 09:09:00 -0800 (PST)
Date: Tue, 10 Dec 2024 11:08:56 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Matthew Garrett <mgarrett@aurora.tech>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Maxim Moskalets <maximmosk4@gmail.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Wang Jie <dave.wang@rock-chips.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH 3/8] doc: test: Add docs and test for part_find
Message-ID: <20241210170856.GC2457179@bill-the-cat>
References: <20241209162801.288363-1-sjg@chromium.org>
 <20241209162801.288363-4-sjg@chromium.org>
 <0f17622a-ae3b-4d02-9cdc-c39d4f8bfa6d@gmx.de>
 <CAFLszTgDCAxiZBYkDVUUb4jWejry4wWKm4gyyNndLhBYQ+zfAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="4h74r3dG++IGqGN1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgDCAxiZBYkDVUUb4jWejry4wWKm4gyyNndLhBYQ+zfAg@mail.gmail.com>
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


--4h74r3dG++IGqGN1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 09:16:57AM -0700, Simon Glass wrote:
> Hi Heinrich,
>=20
> On Tue, 10 Dec 2024 at 01:16, Heinrich Schuchardt <xypron.glpk@gmx.de> wr=
ote:
> >
> > On 09.12.24 17:27, Simon Glass wrote:
> > > Add some documentation and a test for this new command.
> >
> > Shouldn't this be two patches?
>=20
> Often we put the new command, its docs and tests in the same commit,
> since the question I always ask when looking at a command is, where
> are the docs and tests!
>=20
> >
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > >   doc/usage/cmd/part_find.rst | 119 +++++++++++++++++++++++++++++++++=
+++
> > >   doc/usage/index.rst         |   1 +
> > >   test/cmd/Makefile           |   1 +
> > >   test/cmd/part_find.c        |  42 +++++++++++++
> > >   4 files changed, 163 insertions(+)
> > >   create mode 100644 doc/usage/cmd/part_find.rst
> > >   create mode 100644 test/cmd/part_find.c
> > >
> > > diff --git a/doc/usage/cmd/part_find.rst b/doc/usage/cmd/part_find.rst
> > > new file mode 100644
> > > index 00000000000..fd5bd6578d5
> > > --- /dev/null
> > > +++ b/doc/usage/cmd/part_find.rst
> > > @@ -0,0 +1,119 @@
> > > +.. SPDX-License-Identifier: GPL-2.0+:
> >
> > This is not a valid SPDX identifier.
> > Cf. https://spdx.org/licenses/GPL-2.0-or-later.html
>=20
> I have seen this point made a few times, but I'm afraid I still don't
> fully understand it:
>=20
> The Licenses/README lists the licenses and GPL-2.0+ appears in there.
> In the source tree:
>=20
> $ git grep GPL-2.0+ |wc -l
> 13406
> $ git grep GPL-2.0-or-later |wc -l
> 1847
>=20
> I have to say I much prefer GPL-2.0+ as it is easier to remember.
>=20
> But if we are planning to change, could you update checkpatch to throw
> a warning?

As I've said before too, GPL-2.0+ is deprecated by SPDX and
GPL-2.0-or-later is the correct tag. But we aren't, sadly, right now a
best practices example for SPDX anyhow and so it's not a deal breaker to
use the old tag, just something that should be avoided.

--=20
Tom

--4h74r3dG++IGqGN1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdYdaEACgkQFHw5/5Y0
tyxkcAv/SOJg/vw503stjHu0Cy+DbbP5ub0tLPj4mjzEvUDCD/zc00Nv7UlEEg0s
7DwFFWKxtXp00BfiMpltB38puFj0dJsCgbcVa4HadWIyRtaEUEge35B1qVGJHd/a
hmyvYhG59UqN3L/IhhIWu0W3piMnD647X/HX6uqjH4uhVSOPI/fnalhFns4IfYSu
myihuKPhNB38XTbtROtnFabzCzhYa5Lh3ulhsvWZ7BUKr4txcp7wyjCzj0V+YCZU
guPlK8M4e65dJIlf0ZZzuGuNmpOTrbVPHtX8rs79xT0G30Wds6tvNQjrrgptxI0S
GZdxjMIdlmhfvaJxHI0Hs0LoWZDToYTtguB4LVKThxGP/4dJf2NqJaKzHPQHvx13
Qp+6HxvBUDjfqBofYoUZkbRV3C5D3la74sNnm0ktDZEUyzl7bFa6UDVWWAcek0QP
EDnL7Qdgnr2i1s4NQIWLD/iuZ9WCw7+mgcn7cDzOF3qZJqrT8HVwnRag7KA0eBV/
kO8ZGY3Z
=/ehZ
-----END PGP SIGNATURE-----

--4h74r3dG++IGqGN1--
