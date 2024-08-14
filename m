Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A117C3DA4A
	for <u-boot@archiver.kernel.org>; Wed, 14 Aug 2024 14:14:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CEE8D87C69;
	Wed, 14 Aug 2024 16:14:41 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WUsXhsxN";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E0022889AA; Wed, 14 Aug 2024 16:14:40 +0200 (CEST)
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com
 [IPv6:2607:f8b0:4864:20::c35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 27B8B8899D
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 16:14:37 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc35.google.com with SMTP id
 006d021491bc7-5da6865312eso1477643eaf.3
 for <u-boot@lists.denx.de>; Wed, 14 Aug 2024 07:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723644876; x=1724249676; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=eW/cuWtPE35K0jw2qHbevLXf2E0ry8BRMnVqFscq/ls=;
 b=WUsXhsxNWu88mzmEtDx1+M5BfZPT0NQ2UrUK7pBQZqXBFq/waalHh6KCNhqcAt5xto
 ch2ZQG3HMDeEtsllfTsFEJMHF/HWwsyK3/lVEOfrja6HazwSn0FtK/cIKlzfhA+pOHh3
 vCwZGz/d9PrBYTZags2OfzCAYm54gmF8RQfRY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723644876; x=1724249676;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eW/cuWtPE35K0jw2qHbevLXf2E0ry8BRMnVqFscq/ls=;
 b=rv6IF2uMmQvKRtNQv9vTpe7IwpTq7Lt/Jlfd4FQpd7TYVpOmcZ2ZM3oyKnB9CHHcgj
 W77V91sAXUrlMheA2L3hzcafCt7IkpCvqQ/wHD5/cJWttLFnkHiyT8/yXT7jNY89RTss
 tfOtgEWTc0UR2GXXtRikC+ML0501XypJDmgZl8Z6SvF1DxbaJNUVnsuP6h6Ci2ygN4rr
 Ll+dmnn3lzbaW8TXXqenR4bLutn32sM4cD+MuHCbfMKndpd3NkhtSFD/PRJLrXfDjvkv
 6VY6N4vqNO7du04ii7lCv/9tDS4NK9LcYvTaScZCSzf/LkN2HNP2VBKr3EWM2GaovW0h
 OzGg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjRWoFMiprS2FYzRDLLQCcfLMo8G+GT14WhMKs3gRZ9NG91rfiAVoDNAfDooCMYGrLhmZOlmUqoIwTng4qoxj6FTBtGA==
X-Gm-Message-State: AOJu0YzvUwRoe0rh7RHlYtRWX3hycnAgXuYn8+hKcUfwas/6AZ3K003I
 GCtkD8jmfUDEnfxmuHnmD3VCLUf8S6eHleO6RbedA4/atYhAsFzUgKDFC0JkFFo=
X-Google-Smtp-Source: AGHT+IHvihSlXH1rpmYYgMOg/6aKoUknXS4tGFM+Uq70+GF3Ig39n//npiqVv9951QXBdJ96ujHnBw==
X-Received: by 2002:a05:6820:2206:b0:5c6:8eb6:91b2 with SMTP id
 006d021491bc7-5da7c5cc9f5mr3646448eaf.1.1723644875832; 
 Wed, 14 Aug 2024 07:14:35 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5da3e73a958sm2090036eaf.45.2024.08.14.07.14.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2024 07:14:35 -0700 (PDT)
Date: Wed, 14 Aug 2024 08:14:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
Message-ID: <20240814141433.GM1626301@bill-the-cat>
References: <20240807155343.122377-1-hs@denx.de>
 <CAOMZO5A23hR6CbLbvUR-ck111iowq=BKrMz_4PHwL4hQsmyxDQ@mail.gmail.com>
 <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
 <20240813161607.GJ1626301@bill-the-cat>
 <5d18242e-93bf-f881-68a7-64f6be8e3931@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="0nri1ChX5fYzPlDJ"
Content-Disposition: inline
In-Reply-To: <5d18242e-93bf-f881-68a7-64f6be8e3931@denx.de>
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


--0nri1ChX5fYzPlDJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 06:07:52AM +0200, Heiko Schocher wrote:
> Hello Tom,
>=20
> On 13.08.24 18:16, Tom Rini wrote:
> > On Tue, Aug 13, 2024 at 03:57:08PM +0200, Heiko Schocher wrote:
> > > Hello Fabio, Tom,
> > >=20
> > > On 13.08.24 14:27, Fabio Estevam wrote:
> > > > Hi Heiko,
> > > >=20
> > > > On Wed, Aug 7, 2024 at 12:53=E2=80=AFPM Heiko Schocher <hs@denx.de>=
 wrote:
> > > > >=20
> > > > > U-Boot 2024.07 drops on aristainetos2 board the following
> > > > > warning:
> > > > >=20
> > > > >           Failed to enable per_clk
> > > > >=20
> > > > > and bootlogo is not seen on LVDS display.
> > > > >=20
> > > > > This patch uses old behaviour for systems without clock framework
> > > > > if CONFIG_CLK is not enabled.
> > > > >=20
> > > > > Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ip=
g clock using dm")
> > > > >=20
> > > > > Signed-off-by: Heiko Schocher <hs@denx.de>
> > > > > ---
> > > > >=20
> > > > > Changes in v2:
> > > > > use CONFIG_IS_ENABLED instead of IS_ENABLED
> > > > > as Anatolij suggested.
> > > >=20
> > > > This causes build failures:
> > > >=20
> > > > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/887503
> > > >=20
> > > > Please fix and resend.
> > >=20
> > > Hmm... yes ... I work/worked on aristainetos2 board update for 2024.07
> > > (or later)  ... and saw this
> > >=20
> > >    Failed to enable per_clk
> > >=20
> > > warning when 2024.07 boots ... and bootlogo did not work anymore, as
> > > backlight is pwm driven on this hardware...
> > >=20
> > > I bet, for all the boards which fail in the azure run with this patch,
> > > PWM do not work anymore... because CONFIG_CLK is not enabled for them!
> > >=20
> > > I am really unhappy, that I have no automated U-Boot runtime tests an=
ymore
> > > running on real hardware... setup with tbot was very easy, but had no
> > > time for looking at the bugs poping up...
> > >=20
> > > Hmm... looking in git history, there comes this commit in my eyes:
> > >=20
> > > commit 4eea76574062e9079b6a267229962d6ec0be910a
> > > Author: Tom Rini <trini@konsulko.com>
> > > Date:   Sat Nov 19 18:45:18 2022 -0500
> > >=20
> > >      pwm: imx: Remove unused references to CONFIG_IMX6_PWM_PER_CLK
> > >=20
> > >      On platforms that use DM_PWM, we do not need to define this value
> > >      anymore, so remove it from config files.
> > >=20
> > >      Signed-off-by: Tom Rini <trini@konsulko.com>
> > >=20
> > > which exactly removes for all breaking boards this define...
> > >=20
> > > Should we revert this patch?
> > >=20
> > > I just can say for the aristianetos2 board, that I readded exactly th=
is
> > > define in my work for the port to currentmainline ... and with my pat=
ch,
> > > pwm and so bootlogo works again ...
> >=20
> > We can't do a strict revert, no, the symbol is now CFG_IMX6_PWM_PER_CLK.
> > But also, isn't this board using DM_PWM? And if so, that value isn't
> > used?
>=20
> Yes, of course, simple revert does not work.
>=20
> Yes, the failing boards are converted to DM_PWM, but they do not work
> anymore as bfc778cb93a3 intrdocued clk framework functions, and the
> failing boards have no clk framwork enabled. So my patch simply
> readded the define for DM_PWM case.

OK. And why don't we just fix the missing clock migration next?

--=20
Tom

--0nri1ChX5fYzPlDJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma8u8kACgkQFHw5/5Y0
tyyN0wv/b8MqDENC4mG8jMGK+pSAXLShc4/o2rKpWXmsGM3TkdhCs5tiYe9f61vz
6b0kmfwXuQiVsqyVUMhzR5PGXjL4B/v20HN6SYorotiuBw/69Pz/S6l0ZW4Ko2sX
1v36Izhc9OFa5TYGJPehU0F5+yOvlYBYy3GfIjZrYCJtR36+IHYytqwUlk8RixtY
W61EIndglNhmp6VUMfrS8y5OPjb03bSJ7uG+88Yi3KeKuCS1G4EbWULjdyBfqKtu
N5SuuodfgTkakpwNYjx5pdh0vtXS5+MlreC4clOeJZezoOTklQoa+1xQJJbX5VOU
1MtJFpXUCdLcnbLv3I7LRfeQzx4J6sKiuvpQVFk750ZdOI+o1He4IJtRaks/Dck8
/c9mp9QfTo1vQU/dUDaAxCTxVmAAM3mb4nYtU+ndRjjPwqE9cExBmXgxV4V+Cbaf
osZd6f/cNb7XQPj9Z/2mtQirZ3FbgkjrdGOzWU3UGkbYpz3ggQP+8FAq6qqda4uG
cLiPMQOr
=8ytM
-----END PGP SIGNATURE-----

--0nri1ChX5fYzPlDJ--
