Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFF36C27C6E
	for <u-boot@archiver.kernel.org>; Thu, 13 Jun 2024 15:33:56 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B677388925;
	Thu, 13 Jun 2024 17:33:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="AM8SaM+c";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DD08D88933; Thu, 13 Jun 2024 17:33:16 +0200 (CEST)
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AB83388934
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 17:33:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22a.google.com with SMTP id
 5614622812f47-3d2472450d6so455775b6e.3
 for <u-boot@lists.denx.de>; Thu, 13 Jun 2024 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1718292793; x=1718897593; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S+r3MsP6+hF+JrkQ605O5iu0Y0tcG3GqXs9u2IS1r+I=;
 b=AM8SaM+cKW/p8SN4dFqJx6y92Et1xU321lx5/Q7EUpEP5gxJJkUWyFBhBh1g3It2L8
 Op+bZZfwmkKszLVPdzzN0KArFBYrfstMU6MqrvN8er/P0Ip48bSZPkZjL+4nKj9S4eCO
 Dd5tJDYziAMQ5DKYYadsFHfC0PfBvCiTUJWzA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718292793; x=1718897593;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+r3MsP6+hF+JrkQ605O5iu0Y0tcG3GqXs9u2IS1r+I=;
 b=v5Y/dO5+ZynBX9Sp0EdsUznC/hD1pRnXbIGbZ9npI1z+yaXobR9l8W/49Y+CoXZqw1
 0FufbJ+VH8VsoN6cL8eMMzhsjpMZ7xYiNNCt/S46UZqeMnw1D3Kx70fTE+U1U2f3gyih
 M7TqGBUSKlNPqCSsw+eQnsMRaK+xDi9jRhvUOBxF7eXUV/aYlRWojcUmyf2ZYY2EVrrF
 Hj99D7NSrG2ix71nb9vLh9vJeKOu0HqcLIINF6VbuKytFulc21hwl+BU4+b/QRoGchif
 +XN9JFdKbJX0t0AdGPR0oyd5N1KqiB6/9AHtNM2pUv1AkTT61PLTILaVQCKa1z+acPsl
 Bf4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDzow1zIxe9+NKWt8RVsdQ+O427kHUSW9qytMaYDolmQ404Rrn+aRac0itVDTIM7dUppAkkG0+w0gcdMo+oKMBwPrarw==
X-Gm-Message-State: AOJu0YyQpRz7BgmmYshN8fK6nsbK1Qy9+ywk+tR5fnEjLwvVBe66OHnR
 0qsw2cIxEbntjIrw8ohidOVi4NlMhVn1WVMhwxR8Dlcey8mwI9v/6RaLsr6iT8Y=
X-Google-Smtp-Source: AGHT+IEXuSWYLQSfmxUkwCIHvXqnpu4xWCpHPI8Jj40vsFk7LurhY010/ERBEq6S+73I9HrK2klPMw==
X-Received: by 2002:a05:6870:9726:b0:254:7e86:ab85 with SMTP id
 586e51a60fabf-25514bfd281mr5633334fac.18.1718292793299; 
 Thu, 13 Jun 2024 08:33:13 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-45.totalplay.net.
 [189.203.100.45]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2567a94a1d4sm448303fac.1.2024.06.13.08.33.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Jun 2024 08:33:12 -0700 (PDT)
Date: Thu, 13 Jun 2024 09:33:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Sam Protsenko <semen.protsenko@linaro.org>,
 Sean Anderson <seanga2@gmail.com>
Cc: Lukasz Majewski <lukma@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Michal Simek <michal.simek@amd.com>,
 Ashok Reddy Soma <ashok.reddy.soma@amd.com>,
 Eugen Hristev <eugen.hristev@collabora.com>,
 Yang Xiwen <forbidden405@outlook.com>,
 Julien Masson <jmasson@baylibre.com>, u-boot@lists.denx.de
Subject: Re: [PATCH] clk: Propagate clk_set_rate() if CLK_SET_PARENT_RATE
 present
Message-ID: <20240613153310.GM68077@bill-the-cat>
References: <20240308000432.32369-1-semen.protsenko@linaro.org>
 <a135888e-0d97-1382-c1f9-5bf097a7ffe3@gmail.com>
 <CAPLW+4=f1AcZRde8e+rWWpCm9BtFAACqdWCfMryRBcSFn4OinA@mail.gmail.com>
 <CAPLW+4kBMcO8xOyHYeOqi+npCT651990Efyuanzq8jDgnaqX5Q@mail.gmail.com>
 <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="EoZelhD1JSRCOYP9"
Content-Disposition: inline
In-Reply-To: <CAPLW+4kP_Y4YMtsYpK_uA4B4s-a36UA7ZPZNiV_KYBuDb_qJwg@mail.gmail.com>
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


--EoZelhD1JSRCOYP9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 10, 2024 at 02:43:17PM -0500, Sam Protsenko wrote:
> On Tue, May 14, 2024 at 3:26=E2=80=AFPM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> >
> > On Wed, May 1, 2024 at 4:12=E2=80=AFPM Sam Protsenko <semen.protsenko@l=
inaro.org> wrote:
> > >
> > > On Wed, Apr 10, 2024 at 9:53=E2=80=AFPM Sean Anderson <seanga2@gmail.=
com> wrote:
> > > >
> > > > On 3/7/24 19:04, Sam Protsenko wrote:
> > > > > Sometimes clocks provided to a consumer might not have .set_rate
> > > > > operation (like gate or mux clocks), but have CLK_SET_PARENT_RATE=
 flag
> > > > > set. In that case it's usually possible to find a parent up the t=
ree
> > > > > which is capable of setting the rate (div, pll, etc). Implement a=
 simple
> > > > > lookup procedure for such cases, to traverse the clock tree until
> > > > > .set_rate capable parent is found, and use that parent to actually
> > > > > change the rate. The search will stop once the first .set_rate ca=
pable
> > > > > clock is found, which is usually enough to handle most cases.
> > > > >
> > > > > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > > > > ---
> > >
> > > [snip]
> > >
> > > >
> > > > Can you give an example of where this is needed?
> > > >
> > >
> > > Sure. In my case it's needed for eMMC enablement on E850-96 board.
> > > eMMC node in the device tree [1] is a gate clock
> > > (CLK_GOUT_MMC_EMBD_SDCLKIN), so the MMC driver won't be able to change
> > > its rate. But that clock actually has CLK_SET_RATE_PARENT flag set in
> > > the clock driver [2]. So the right thing to do in this case (and
> > > that's basically how it's done in Linux kernel too) is to traverse the
> > > clock tree upwards, and try to find the parent capable to do .set_rate
> > > (which is usually a divider clock), and use it to change the clock
> > > rate. I'm working on exynos_dw_mmc driver [3] right now, making it use
> > > CCF clocks, but I can't do that before this patch is applied.
> > >
> > > Grepping the U-Boot tree I can see the CLK_SET_RATE_PARENT flag is
> > > also used in various IMX clock drivers and STM32MP13 clock driver. I
> > > guess without this change those flags will be basically ignored.
> > >
> > > Thanks!
> > >
> >
> > Hi Sean,
> >
> > Just wanted to check if you think my explanation above is ok and the
> > patch can be applied? I'm finishing my new patch series for enabling
> > MMC on E850-96, but this patch has to be applied first.
> >
> > Thanks!
> >
>=20
> Hi Tom,
>=20
> Would it be reasonable to ask you to take care of this patch? It's
> been ignored for 3 months now, but it's needed for eMMC enablement on
> E850-96 board.

Any comments at this point Sean?

--=20
Tom

--EoZelhD1JSRCOYP9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZrETYACgkQFHw5/5Y0
tywgSAv8D31+6p/lDBsk43YcQFUwWEQBAF9hL3hFPnLuCtXtfp1ZsQkFz5JW06ge
T72zgxBf81ez89Z2l7D0AyqNlfvdazas4LoxEpzaWlPh6OGaS0C/YC0ZZ7JC6VVK
boImkKDg9062e9at2OWhO4IwR/VwmV0jjocWZnZFD5qub/ImZP4hqmgrBSvPlLsJ
hzzfwOvhd01Pyw7WLGHgP5WFVmII5Qizmj+eWzv0ZjDwJIqD8iYy/spp88KeM2Bg
xdu8NZyZfbkKfJvlFZIJqFHi30ez2RhfVVy+R64v+u2+dCccTruvjfH4KZfGahlY
9RJPOnaNsE9KAxeeCV+u7vm9TUbNJbMI/AJi1U+pgsKgCQKDKwgHC+nHjaFV5jGF
KFS7d8FZ/VFTC4zVktSj0CTs1Q/G8ohHkapzRBRua/rNYxYTuoQv6ok4PBK9Qj0n
ZN9+GUVR0S5x7uaTaYthfs97YyCc1wEk+ITpMclBSLqle0kpi0jg9sTPLtI0EJT8
yHFaghAR
=nlkf
-----END PGP SIGNATURE-----

--EoZelhD1JSRCOYP9--
