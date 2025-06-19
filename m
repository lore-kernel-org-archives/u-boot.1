Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD3FC7115B
	for <u-boot@archiver.kernel.org>; Thu, 19 Jun 2025 22:35:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9D62582CBB;
	Fri, 20 Jun 2025 00:35:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kfCsxGj5";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id EF31B82CDF; Fri, 20 Jun 2025 00:35:27 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A7F1282C55
 for <u-boot@lists.denx.de>; Fri, 20 Jun 2025 00:35:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-40a4bf1ebb7so782249b6e.0
 for <u-boot@lists.denx.de>; Thu, 19 Jun 2025 15:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1750372524; x=1750977324; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xBNRwNkSgbYI3ruNzDxa2oU7Z083tUwkIX78SheTQNs=;
 b=kfCsxGj5ELC5FSjQ1vK9WoAw/eE4yqDSW32YAKaxiv9X+0Wje4kDBU53vmS2Y7uZYt
 I8+TKCTqB4rXm46GA1uOc4ZZAWK89YkfBKruLCLKl+xm5e/uVTSMaEI+OAlqR4SsPdXT
 wKDMsl3HVr9CqxZPJnQySc9w+2QqU/QUY3TXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750372524; x=1750977324;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xBNRwNkSgbYI3ruNzDxa2oU7Z083tUwkIX78SheTQNs=;
 b=qn+gdMzdEVet0c6CnCDFpSiq33v71Fm2Eg6sU2ut6rJiSVmgno992FDxXYe5QPo+fc
 nEIcJGw333eURv+nZ8BbL37Fpf3JE0fKyRDkP52pDUuYrPVsvyuE5TH7D1jC6cwk3obp
 cDLrm+plFAN78qG/xafdKPWK9sQOwUIUYd+vJHB9dzdGkfLaZY57sGKLcsDtaVV3FUew
 SrjhSCezBHTX5tAuAE7O9l2cCBAk1xdzO3RDtDvzVlX83+cR5OVNEhK0wuP4xmyExr77
 ICViw69yr00wPk9YQ/xqgpyijNAcWWel2VxxjYbKcrq86R6oe3GBOiTFKxJxn1FNd3XM
 9jNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUs5T7rVMsVCsFQR8aIjLfuDHRdychwORqOHXE/+yQc/SwkGRGJdsn6dNpO3e4IPOjJBzr1dk8=@lists.denx.de
X-Gm-Message-State: AOJu0YzvLFyf5MvSDXSlncNTExH0YK/D62WCsDAQnrdTKGN6zrkA7T0Z
 Uq3Oj3Ou9GYAnB3sMFDvQ66jqmZuTk9+tIkK5z/YSEO6NOQYz91mxe7IorI6e+HP+QM=
X-Gm-Gg: ASbGncvwQQAtuvr4nwGdRTWHzo1kgCwSqf6zdhS3kswZo4i+WmtXifSvh/+1NFUuevN
 87uX7ExZbcr2Crgbs+BCChvJs9pt2CL4dbz4iQrQ9NMWT5IkQ/8KMdlqNsFyuuxNn7JDENAcTHj
 wpyxqABKj3uTxncFDU+J0dy01KLeYIEjgX/GXF2XB9AxpF5/RBJePGtqm4+nHaOvJdPDbyJmLOd
 z0s7dW6v4V1eIntkLS3QlyVEigCKbjL9GdskjF+5KPrM8LH9Z2wo81jAp3kbMquRyOwp/FGzAKP
 vuTWUHtdZ2RLB9G7m1jc5WX5T4+beQGqhKBhCGvd3QT57yTT644cQiJKjPFszXdiOwTEBSj8lp/
 47M/nzvq1CPRiJdAIqf5sUOQ=
X-Google-Smtp-Source: AGHT+IEbUzRqOsOVBCm7cFdwaVW2X9lJNYkAhT38tsCYEgNyqSBaPcigZpVzPpwYQR7aT70mxJeV8A==
X-Received: by 2002:a05:6808:2122:b0:409:f8e:72a8 with SMTP id
 5614622812f47-40ac6fec161mr391051b6e.23.1750372523854; 
 Thu, 19 Jun 2025 15:35:23 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40ac6c136f8sm77629b6e.8.2025.06.19.15.35.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Jun 2025 15:35:23 -0700 (PDT)
Date: Thu, 19 Jun 2025 16:35:20 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>
Cc: Simon Glass <sjg@chromium.org>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Martyn Welch <martyn.welch@collabora.com>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/3] bootstd: Fix memleak on errors in
 bootmeth_setup_iter_order()
Message-ID: <20250619223520.GE216500@bill-the-cat>
References: <20250112034213.13153-1-semen.protsenko@linaro.org>
 <20250112034213.13153-2-semen.protsenko@linaro.org>
 <CAFLszThSRtSofySbSBa3hHn2u19bCm-jq_S4gXG+pXFjiiJsHA@mail.gmail.com>
 <CAPLW+4=38cBhUXyngbLG-iypxx+ksXp2-3Cjm3Wgd1V+pMmfCg@mail.gmail.com>
 <CAFLszTiZdbMu64_+=LV3gxUf_Jm9Ngxdmg=+XrVhGNHR9FDAnw@mail.gmail.com>
 <CAPLW+4nCr1j4MxR9mjAt3JtocwsxBKgWpah_ARODX+6ENs-xDg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ouzBkVczjPcN3QjA"
Content-Disposition: inline
In-Reply-To: <CAPLW+4nCr1j4MxR9mjAt3JtocwsxBKgWpah_ARODX+6ENs-xDg@mail.gmail.com>
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


--ouzBkVczjPcN3QjA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2025 at 05:04:23PM -0500, Sam Protsenko wrote:
> On Fri, Feb 7, 2025 at 7:26=E2=80=AFPM Simon Glass <sjg@chromium.org> wro=
te:
> >
> > Hi Sam,
> >
> > On Fri, 7 Feb 2025 at 18:11, Sam Protsenko <semen.protsenko@linaro.org>=
 wrote:
> > >
> > > On Tue, Jan 14, 2025 at 7:14=E2=80=AFAM Simon Glass <sjg@chromium.org=
> wrote:
> > > >
> > > > On Sat, 11 Jan 2025 at 20:42, Sam Protsenko <semen.protsenko@linaro=
=2Eorg> wrote:
> > > > >
> > > > > Free memory allocated for 'order' (array of bootmeths) on error p=
aths in
> > > > > bootmeth_setup_iter_order() function.
> > > > >
> > > > > Fixes: c627cfc14c08 ("bootstd: Allow scanning for global bootmeth=
s separately")
> > > > > Fixes: 10d16faa436c ("bootstd: Detect empty bootmeth")
> > > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > > ---
> > > > >  boot/bootmeth-uclass.c | 16 ++++++++++++----
> > > > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > > >
> > > >
> > > > Reviewed-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > How about adding a test to check there is no leak? You can see
> > > > test/lib/abuf.c for similar tests.
> > >
> > > That might be a good idea, and I already have the test code handy. But
> > > frankly I wasn't able to successfully run the current bootstd test in
> > > sandbox, it fails before it can get to memleak check I added. Firstly,
> > > when I do:
> > >
> > >     $ make sandbox_defconfig
> > >     $ make -j32
> > >     $ ./u-boot -T -c "ut bootstd"
> > >
> > > it says:
> > >
> > >     MMC:   Can't map file 'mmc1.img': Invalid argument
> > >
> > > and I can see only empty (zero size) mmc1.img in my U-Boot source code
> > > root dir. Then I was able to trigger its creation (I guess) by running
> > > Python suite somehow, so it generated 20 MiB mmc1.img. But even with
> > > that added, I hit this error:
> > >
> > >     test/boot/bootdev.c:218, bootdev_test_order():
> > >         0 =3D=3D bootflow_scan_first(((void *)0), ((void *)0), &iter,=
 0, &bflow):
> > >         Expected 0x0 (0), got 0xffffffed (-19)
> > >
> > > I've read corresponding doc [1] ("Tests" section), but still don't
> > > understand how can I successfully run the bootstd test locally. If you
> > > can help me out, I can send the memleak test you mentioned in v2.
> >
> > You can run the bootstd tests with something like:
> >
> > test/py/test.py -B sandbox --build-dir /tmp/b/sandbox -k bootstd
> >
> > although it sounds like you have already figured that out. After you
> > do it once (to create the images) you can run the C tests directly as
> > you did above, but yes, sadly, some of the tests are affected by
> > others (with bootstd). You could take a look if you like.
> >
>=20
> Is it possible to just apply this patch without a test? It's clearly
> fixing a memleak. Not that I'm lazy or anything, I came up with a test
> like below, but I don't want to send something that is quite hard to
> test. If you think this test is really essential, I can send it once
> bootstd tests are fixed and can be run in one command without any
> extra non-documented work.
>=20
> 8<---------------------------------------------------------------------->8
> diff --git a/test/boot/bootdev.c b/test/boot/bootdev.c
> index 9af947868707..f4746ee4fb61 100644
> --- a/test/boot/bootdev.c
> +++ b/test/boot/bootdev.c
> @@ -194,6 +194,7 @@ static int bootdev_test_order(struct unit_test_state =
*uts)
>  {
>         struct bootflow_iter iter;
>         struct bootflow bflow;
> +       ulong start;
>=20
>         test_set_skip_delays(true);
>=20
> @@ -201,6 +202,8 @@ static int bootdev_test_order(struct unit_test_state =
*uts)
>         bootstd_reset_usb();
>         ut_assertok(run_command("usb start", 0));
>=20
> +       start =3D ut_check_free();
> +
>         /*
>          * First try the order set by the bootdev-order property
>          * Like all sandbox unit tests this relies on the devicetree sett=
ing up
> @@ -277,6 +280,9 @@ static int bootdev_test_order(struct unit_test_state =
*uts)
>                         iter.dev_used[3]->name);
>         bootflow_iter_uninit(&iter);
>=20
> +       /* Check for memory leaks */
> +       ut_assertok(ut_check_delta(start));
> +
>         return 0;
>  }
>  BOOTSTD_TEST(bootdev_test_order, UTF_DM | UTF_SCAN_FDT);
> 8<---------------------------------------------------------------------->8

Yes, we can do this in a follow-up I think. I'll take this series to
-next soon.

--=20
Tom

--ouzBkVczjPcN3QjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmhUkKQACgkQFHw5/5Y0
tywP3Av+Om3c+jl5xVaWTt2vjao12zA8wqU0QLaWNzhmM9xFSGI8HW+eY79kyxr7
sB435OB2PWGs3QxT4f4LptqwKLSY9nDFuskWegkLpbreZk6j9ERaA+MRJkdRoZ3i
4fK6NCWnMCNgMLLPhOJoySZ/sEPcLulHWJF5eJZj8IIDLb2H0cvM/5+gMLTtYfvU
c18II28jtYyKk6PODewjfwAKxfW2gj2ZBRNIVFl5CSmPHGXyq/v5ofFTh6pV/xY/
IsquL6tzqYNrOkPwfMnsRpHrPNIbHYF2YY+mzF5S5bTwZRFh4ApJk6/o/xnHPo9h
FGAScfn07C+kF8y2cK2LVeZnGCLLagmx8CocWE+Swe/YhFT6flRX8WXY1iHlciLm
8iFpSvOusQBNwuU3fyH9nmLn2yEjnfMCz/AhfXBQBZPLGaXQguESSAnUlHTrpKty
d2CdF2r2w3H2oTWvj9YzhNvnzs4LkiATO0k64iEk1KeWsnwPt2ooNXS100xDV4pv
3c748Mjs
=q2c8
-----END PGP SIGNATURE-----

--ouzBkVczjPcN3QjA--
