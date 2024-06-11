Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03CAC27C75
	for <u-boot@archiver.kernel.org>; Tue, 11 Jun 2024 13:57:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3160F88650;
	Tue, 11 Jun 2024 15:57:10 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ActCyjGh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9B4CE885F6; Tue, 11 Jun 2024 15:57:08 +0200 (CEST)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F025886DF
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 15:57:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6f8ef63714cso643815a34.1
 for <u-boot@lists.denx.de>; Tue, 11 Jun 2024 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718114225; x=1718719025; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=jB/2xyXnUV1c2w5FpyA6SSDLeBpoP3WSklUgzTXkZT0=;
 b=ActCyjGhxDdv/25eYbOV8HVdQVih9V0OaCRnQ9zXCzts9pXEr60uZNBIcvJeyRTNuL
 WR42RvMbMg59bwlr81HBusfYqBQPX7Q0KIBAqklURyx9i4rKjIUA7BYfS4+M58m5n2bp
 VTERFn3z3ju4qNCu1QiguMoqvOrFu4w+a0fuQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718114225; x=1718719025;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jB/2xyXnUV1c2w5FpyA6SSDLeBpoP3WSklUgzTXkZT0=;
 b=G03hGB4N3Pxmx0DX+J2JuMH5kAJKmuJvTryeKmTeIKKf0E8lgKWbn4YE+0fOgZNB8E
 16/52ruNyOJ+tSx+dVUy8FE10JDUKLJ3UYhHLFqG4w4VL8YhH1tbYVIgCH7mjNhToKj3
 1pskLL9OsOVZiIZhTEs8v2dWlSXicYtf4IblJjk1BxGSywhEDLUbcPbbOMdb8fGp8Ivx
 J60f+L5q5ycw31sNe8KfJAukv5I7L116IuCfbM9ipXRkQkbTqRPXaWJCdp1qIi+ciW+I
 cqmKW9LmC5yZKTcaA1507utwFPC8tz13uLdPN7yFjUfQdIoBegwNCC0shNXDdhSh/dLV
 kv5w==
X-Gm-Message-State: AOJu0YxE233IlTLSAVDrqMNIiV89R7Yep6eXxYStZbemRdcvrbSkVv1a
 HqHxMm5t+scj+tnkj2EoyufV+vb/l6RruNIK04yevlc8r2KzWgdt7XEZcJ7PKCU=
X-Google-Smtp-Source: AGHT+IFG0qwlFw6cHRljIwuIMzcIIJDO0HMH8M0IS0UBeWNGTo9TRyYLEAhF5pyDMtsJ1q/qtN0Kcw==
X-Received: by 2002:a05:6870:970f:b0:254:9085:7bd9 with SMTP id
 586e51a60fabf-2549085b972mr11349925fac.18.1718114224690; 
 Tue, 11 Jun 2024 06:57:04 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-254bcebd44csm1210158fac.49.2024.06.11.06.57.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Jun 2024 06:57:04 -0700 (PDT)
Date: Tue, 11 Jun 2024 07:57:02 -0600
From: Tom Rini <trini@konsulko.com>
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: u-boot@lists.denx.de, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Simon Glass <sjg@chromium.org>, Marek Vasut <marex@denx.de>,
 Mark Kettenis <mark.kettenis@xs4all.nl>, Fabio Estevam <festevam@gmail.com>
Subject: Re: [RFC PATCH 08/31] lmb: replcace the lmb_init_and_reserve()
 function
Message-ID: <20240611135702.GC68077@bill-the-cat>
References: <20240607185240.1892031-1-sughosh.ganu@linaro.org>
 <20240607185240.1892031-9-sughosh.ganu@linaro.org>
 <20240610173102.GW68077@bill-the-cat>
 <CADg8p95aA1h_0XgANyHjXFKpPjQdKvrH5jcTKL9Gu8ouhp-gqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="PiLprgeWIRaDtkeZ"
Content-Disposition: inline
In-Reply-To: <CADg8p95aA1h_0XgANyHjXFKpPjQdKvrH5jcTKL9Gu8ouhp-gqQ@mail.gmail.com>
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


--PiLprgeWIRaDtkeZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 02:20:40PM +0530, Sughosh Ganu wrote:
> On Mon, 10 Jun 2024 at 23:01, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Jun 08, 2024 at 12:22:17AM +0530, Sughosh Ganu wrote:
> > > With the changes to make the Logical Memory Block(LMB) allocations
> > > persistent and with the common memory regions being reserved during
> > > board init, the lmb_init_and_reserve() API can be removed and replaced
> > > with a lmb_add_memory() API, which adds all the available memory to
> > > the LMB pool.
> > >
> > > Signed-off-by: Sughosh Ganu <sughosh.ganu@linaro.org>
> > > ---
> > >  arch/arm/mach-apple/board.c          |  2 +-
> > >  arch/arm/mach-snapdragon/board.c     |  2 +-
> > >  arch/arm/mach-stm32mp/stm32mp1/cpu.c |  2 +-
> > >  cmd/bdinfo.c                         |  2 +-
> > >  cmd/load.c                           |  2 +-
> > >  fs/fs.c                              |  2 +-
> > >  include/lmb.h                        | 12 +++++++++++-
> > >  lib/lmb.c                            | 15 +++++++++++----
> > >  net/tftp.c                           |  2 +-
> > >  net/wget.c                           |  2 +-
> > >  test/cmd/bdinfo.c                    | 10 +---------
> > >  11 files changed, 31 insertions(+), 22 deletions(-)
> > >
> > > diff --git a/arch/arm/mach-apple/board.c b/arch/arm/mach-apple/board.c
> > > index c877c7b94c..2e72d03edd 100644
> > > --- a/arch/arm/mach-apple/board.c
> > > +++ b/arch/arm/mach-apple/board.c
> > > @@ -776,7 +776,7 @@ int board_late_init(void)
> > >  {
> > >       u32 status =3D 0;
> > >
> > > -     lmb_init_and_reserve(gd->bd, (void *)gd->fdt_blob);
> > > +     lmb_add_memory(gd->bd);
> > >
> > >       /* somewhat based on the Linux Kernel boot requirements:
> > >        * align by 2M and maximal FDT size 2M
> >
> > We already reserved gd->bd as part of the initr_lmb call. So I think
> > this commit needs rethinking, or am I missing something?
>=20
> I believe the LMB memory API's also get called from SPL(not sure about
> TPL/VPL though). The memory that gets added in the other commit is for
> U-Boot main, post relocation. These calls will then be needed for
> prior stages of U-Boot that want to use LMB memory.

We do likely make use of LMB at times in SPL, yes, for OS boot and that
does remind me of cases people have had of loading image failures due to
LMB-as-security-mechanism today. So we need to make a call to the new
lmb init for real, once, rather than ad-hoc like this commit makes it.

--=20
Tom

--PiLprgeWIRaDtkeZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZoV64ACgkQFHw5/5Y0
tyz74gv8DTXhg8HOdxt6oPXObSbGY5tGqpoocEGFqjq2/4fjkZJ9PZMzDo/Z5+CW
OsKCxM0b4lcBzilj6ieHA5skOs3hx4GWGtVnwXRvhiMH7aMcLTTCnZi8EUtuOLDi
97nWdDj+TnA/Kh/sxsxAmkkKkRxhNu6n6le7+TDP1m1RPaj51tDWk/YrWh5Nm32y
vIqSGRgmMKzbSqdN08hHxNBNpJzYidcUZj4qvBSGu0BSmeImydZEgTzWYmglxBLe
7uvbz5s8OpN7Sf1PKSzrC3rVOZeCe6zm6J2g2RcQdfK5l9iIbLubx+TGvTZDhNzE
VMed+WfRv/9MHFKkJzRp/m5r7MpKrEkH6WX7mQf4x8hOZVZzyAfkNtm68COPeKYb
pZQzpv1ycD4laIvo72r77CK14bmxg5ua0Z87xFMlTKM31g3USfrtTHWmUXRFpDNX
lZnTF2BfhJa02VXtO5bs8koORXD/TkBhWM86LKsU1OdumMOtWpPibyX7DIaw6XMi
cpqIiAZl
=tlsQ
-----END PGP SIGNATURE-----

--PiLprgeWIRaDtkeZ--
