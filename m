Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CAEC52D7C
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 16:16:18 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9FA4C889AE;
	Tue, 13 Aug 2024 18:16:16 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cFJgSb5Q";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 117C18895B; Tue, 13 Aug 2024 18:16:15 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5870388842
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 18:16:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7094641d4e6so2757092a34.3
 for <u-boot@lists.denx.de>; Tue, 13 Aug 2024 09:16:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1723565771; x=1724170571; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=oVjhJd/2tifFcG4wJEHQZfXTpR0R0gqR1ecNaICY3Uw=;
 b=cFJgSb5QhDpAnx0lOi/m6zRqjUJq/KNuC/0TwaJot3dof24meOPDFuBKeXVsMV3Z9F
 LtTK3Y3xH8CsDVbkCW/u0iXCaR1+zmEL42vytWlBsdKSdny8x3ns3syqBShtbjEo5Ia/
 ouKhO+u0f9WKsgh0ZWmEv6EjDVk8ThJWI2swI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723565771; x=1724170571;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oVjhJd/2tifFcG4wJEHQZfXTpR0R0gqR1ecNaICY3Uw=;
 b=Gz73HE7qlZXz36QrDVrHvhVtoc2cU0rQoxGBS5o5gC639HOXXmv9WwSPPzsf8Axuoq
 +TVQj7RSeqTCHmA3F0Q2+AqY2Wd0Vmnsmda54WHWKYzOV1dJ3goFgWp8cWQvAN1/aWTP
 tHMsuALIjYjl299a6HSFFYxNM3KquJmQPXPomC1owsXgNoxhJBvy5RJHImOkCH5ClC2G
 GR7tMtejK5VAEL+caCsW3gZDXvyp5JtOEvXeiXi46ofLGfHTbUfUmP8VfXFRTelzH4td
 KQhpr1PwX0LxZugr6lIXG6djIaFMyoMT+4VtQJG7bMabhLhmQOD5ZLN7gRn7XT0K35w/
 kbsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgUCLEurKfHw0Gv7mfgqt2pMcTXxr5U+3KTZv9V7Q1X5T5wdba2dVNhfiOebTOLjC6g46yuUc=@lists.denx.de
X-Gm-Message-State: AOJu0Yz1HI0dqBx0jb5jyxoUpDJSUU9vxQO4mkjiRVGCgMx4AM7xzOlp
 oMKBOrqD6X5DhlJ5mJBdbVMo+WNoVzZ4RFt2sqoMf+TO2g2KcR0CTsAXl5sIuZQ=
X-Google-Smtp-Source: AGHT+IHvMi4VQ96fltxW4yqE4ulpySELusht23KMsWTUoL9gRYUcqI0/LJW6cUTGk4bN78v5WACaiA==
X-Received: by 2002:a05:6830:25d5:b0:703:5fc2:2df1 with SMTP id
 46e09a7af769-70c9d9b054amr99162a34.17.1723565770960; 
 Tue, 13 Aug 2024 09:16:10 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-236.totalplay.net.
 [189.203.97.236]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-70c7b880d81sm1843926a34.51.2024.08.13.09.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 09:16:09 -0700 (PDT)
Date: Tue, 13 Aug 2024 10:16:07 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Schocher <hs@denx.de>
Cc: Fabio Estevam <festevam@gmail.com>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Anatolij Gustschin <agust@denx.de>,
 Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Subject: Re: [PATCH v2] driver: pwm: pwm-imx: fix probing on imx6
Message-ID: <20240813161607.GJ1626301@bill-the-cat>
References: <20240807155343.122377-1-hs@denx.de>
 <CAOMZO5A23hR6CbLbvUR-ck111iowq=BKrMz_4PHwL4hQsmyxDQ@mail.gmail.com>
 <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Q0CP8It6jJLjN8de"
Content-Disposition: inline
In-Reply-To: <36b5a4e3-0848-7275-134b-a0929a1fea27@denx.de>
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


--Q0CP8It6jJLjN8de
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 13, 2024 at 03:57:08PM +0200, Heiko Schocher wrote:
> Hello Fabio, Tom,
>=20
> On 13.08.24 14:27, Fabio Estevam wrote:
> > Hi Heiko,
> >=20
> > On Wed, Aug 7, 2024 at 12:53=E2=80=AFPM Heiko Schocher <hs@denx.de> wro=
te:
> > >=20
> > > U-Boot 2024.07 drops on aristainetos2 board the following
> > > warning:
> > >=20
> > >          Failed to enable per_clk
> > >=20
> > > and bootlogo is not seen on LVDS display.
> > >=20
> > > This patch uses old behaviour for systems without clock framework
> > > if CONFIG_CLK is not enabled.
> > >=20
> > > Fixes: bfc778cb93a3 ("driver: pwm: pwm-imx: get and enable per/ipg cl=
ock using dm")
> > >=20
> > > Signed-off-by: Heiko Schocher <hs@denx.de>
> > > ---
> > >=20
> > > Changes in v2:
> > > use CONFIG_IS_ENABLED instead of IS_ENABLED
> > > as Anatolij suggested.
> >=20
> > This causes build failures:
> >=20
> > https://source.denx.de/u-boot/custodians/u-boot-imx/-/jobs/887503
> >=20
> > Please fix and resend.
>=20
> Hmm... yes ... I work/worked on aristainetos2 board update for 2024.07
> (or later)  ... and saw this
>=20
>   Failed to enable per_clk
>=20
> warning when 2024.07 boots ... and bootlogo did not work anymore, as
> backlight is pwm driven on this hardware...
>=20
> I bet, for all the boards which fail in the azure run with this patch,
> PWM do not work anymore... because CONFIG_CLK is not enabled for them!
>=20
> I am really unhappy, that I have no automated U-Boot runtime tests anymore
> running on real hardware... setup with tbot was very easy, but had no
> time for looking at the bugs poping up...
>=20
> Hmm... looking in git history, there comes this commit in my eyes:
>=20
> commit 4eea76574062e9079b6a267229962d6ec0be910a
> Author: Tom Rini <trini@konsulko.com>
> Date:   Sat Nov 19 18:45:18 2022 -0500
>=20
>     pwm: imx: Remove unused references to CONFIG_IMX6_PWM_PER_CLK
>=20
>     On platforms that use DM_PWM, we do not need to define this value
>     anymore, so remove it from config files.
>=20
>     Signed-off-by: Tom Rini <trini@konsulko.com>
>=20
> which exactly removes for all breaking boards this define...
>=20
> Should we revert this patch?
>=20
> I just can say for the aristianetos2 board, that I readded exactly this
> define in my work for the port to currentmainline ... and with my patch,
> pwm and so bootlogo works again ...

We can't do a strict revert, no, the symbol is now CFG_IMX6_PWM_PER_CLK.
But also, isn't this board using DM_PWM? And if so, that value isn't
used?

--=20
Tom

--Q0CP8It6jJLjN8de
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAma7hsMACgkQFHw5/5Y0
tywRSwv9E48ShDgsPrFyL2xjhUqbgt7G6amyFD68RMhHrrDRXMruSi6tuJMyMIoE
KgDdViYYIkDNlIIwyrFqFlQvXq1Re6yvKgphcaiSE2lyYAs5M+1witcpW+8kZff3
hzqz2u5xNscf07ku1oWV4x9skPKyWUWe/IvkGJv4R7hhefBjadDAI+wLbIUUp7uy
5ivw7zbQmigZ8mk4AaTuWu2+KD1WmnUGYrepbSzFa9NS7DiSuwjfFHRMl1uy2iR4
zPvUrfjObd5d77W7aEDmZbK8LR3WGZL6uCW5BGPKjvIaAtxLhIeZEly9JmQ50bCn
88OM8AqmLN5HAL0J94MQNVA8R36dqnaeJo6xyL61ldXa7Aekl+CaNKq3x/rXJTmQ
7CF7IwF8KOSE0p28Ju9LdrMAXUI4MPGW33AG6uIAGf1i62uDi28hVaeTH/EXDBI2
y/Dj1ObCRaxNiMtnoYn0Y19YTSnpvfh+qVTZ6hZ9PkDhlGz4xnmPmatOwceUTt+w
2PWkfVCM
=5yjx
-----END PGP SIGNATURE-----

--Q0CP8It6jJLjN8de--
