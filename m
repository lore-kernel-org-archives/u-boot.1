Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 328F7E6F06D
	for <u-boot@archiver.kernel.org>; Fri,  1 Nov 2024 16:26:55 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 980B688E3C;
	Fri,  1 Nov 2024 17:26:53 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="MfqOPrLL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 2B68389045; Fri,  1 Nov 2024 17:26:52 +0100 (CET)
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com
 [IPv6:2607:f8b0:4864:20::831])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id F3F9A88E3C
 for <u-boot@lists.denx.de>; Fri,  1 Nov 2024 17:26:49 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x831.google.com with SMTP id
 d75a77b69052e-4609e784352so14014291cf.0
 for <u-boot@lists.denx.de>; Fri, 01 Nov 2024 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730478409; x=1731083209; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=cjJTmc6tQYXX17CrGPNlC1FlgICmYt0abvsDTRqjxS0=;
 b=MfqOPrLLOpEdH7aFI+nSgV7/iXlmPRCkazo8Wbeds/xPJ0jMn+pupJBoFSlNhlGGTO
 6jZKwM0m7EfJJokT6jJRZVwm3NKVb0WOsFiTAz0Hmw2bFrN2/UWq67Rpf7a2lQvc1QOy
 06TxVhXdnOfy70UQE2/bJ/OHGsydWqjWi2v0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730478409; x=1731083209;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cjJTmc6tQYXX17CrGPNlC1FlgICmYt0abvsDTRqjxS0=;
 b=hJFXuKChjb5AJX3mywcHJsZICNdnk8aCm0jUS/aUnR1EfzwMOKOEvZtbk1FqkXGyqo
 sPh9zdGa4tLlprKNImGtTS2v6g3OVhDO01Szd/sIXVfKbq2gfoRW9e6P6T8BqWldEMn8
 uMapyuRMczpW9QcI6shPTJaP0HUTDDwnso0t7FPbkKwyEUaY4CUn+9i4Pi8wIjiLNYBb
 A8QuKiShFZ81AoeUf4d0UKBzh+/g3weQydzcySKMjQ8peDiZCyBXN/jxF7LCsAT29mJf
 QFkqSAw0pt/AOU4FGzUFRL3NZlZCZQJMzIxUSUTzaZjqvsC4ayczuBn1RYHVLD0iys2N
 0I8g==
X-Gm-Message-State: AOJu0YxOFwa3UxxqR1k7wslQPhR30lCou/RAS2/gCGMBsg2K3mIF+/Lh
 pY8wx/db1bqvcDl6tT5+ZYmMiEZsbC2YpLvCWFOI9y9y2Rsv/drcli3h0hRJYyo=
X-Google-Smtp-Source: AGHT+IH+EM1j5tr4R2tEvQQ3vjl0+NnByIZPWgC+pSf+mK+es4cqq44kLLreDmR0VjxBYkvhzhPghg==
X-Received: by 2002:ac8:5acc:0:b0:461:2616:84c3 with SMTP id
 d75a77b69052e-461716a0da4mr159626231cf.8.1730478408756; 
 Fri, 01 Nov 2024 09:26:48 -0700 (PDT)
Received: from bill-the-cat ([189.177.122.145])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-462ad0c7261sm20044461cf.44.2024.11.01.09.26.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2024 09:26:48 -0700 (PDT)
Date: Fri, 1 Nov 2024 10:26:44 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
Message-ID: <20241101162644.GP3600562@bill-the-cat>
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
 <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
 <20241027145625.GJ4959@bill-the-cat>
 <CAFLszTikk2GmY0PNc=JZUAsb-SiYSbheAKaOa_msTBVLpBMueA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="wHMH4bK5JDva5RiX"
Content-Disposition: inline
In-Reply-To: <CAFLszTikk2GmY0PNc=JZUAsb-SiYSbheAKaOa_msTBVLpBMueA@mail.gmail.com>
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


--wHMH4bK5JDva5RiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 01, 2024 at 04:38:26PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 27 Oct 2024 at 15:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sun, Oct 27, 2024 at 03:52:02PM +0100, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
> > > >
> > > > > Something this breaks, so add a build to keep it working. Since s=
andbox
> > > > > enables a lot of options, it is a good board to use. The new conf=
ig is
> > > > > created simply by copying the existing sandbox and turning off CM=
DLINE
> > > > >
> > > > > Once we have tests for non-CMDLINE operation, this can be adjuste=
d to
> > > > > run those tests.
> > > > >
> > > > > Create a new build which will be picked up by CI. Update the main=
tainer
> > > > > entry as well.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Create a new build instead of messing with CI
> > > > >
> > > > >  MAINTAINERS                         |   1 +
> > > > >  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++=
++++++
> > > > >  2 files changed, 366 insertions(+)
> > > > >  create mode 100644 configs/sandbox_nocmdline_defconfig
> > > >
> > > > Please use the #include mechanism instead of a full config that will
> > > > also now have to be kept in sync.
> > >
> > > Hmmm we still haven't come up with a way to deal with the #include
> > > mechanism in buildman. I've forgotten where it got to, or even what
> > > the problem was?
> >
> > I assume this is related to the issue I filed? Among the problems are
> > that buildman doesn't "know" about the architecture for example in time
> > and so thinks everything is sandbox (since that's the default). That
> > won't be an issue for your use case here (we have a number of defconfigs
> > today that work around this issue by setting CONFIG_ARM=3Dy and then a =
few
> > other options too, so that the resulting build ends up correct).
>=20
> Yes...OK so I think I understand. If we are happy with the '#include'
> scheme then I believe it would be easy enough to implement in
> buildman. As Caleb mentions, it could likely run the pre-processor
> first, or just process the #includes (which I prefer).
>=20
> Is the '#include' in defconfigs documented somewhere in Linux or
> U-Boot? I really had no idea about this until you mentioned it.

It should be documented somewhere too, yes. But you did review the
original in 2027e99e61aa :)

--=20
Tom

--wHMH4bK5JDva5RiX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmclAUQACgkQFHw5/5Y0
tyyShQwAj/EK3t+Aj6+mcuvqzffaFETi9+ggTk8xamMvu9vkPwNwWlVZIIKXNiay
Owd8CWISxP8kB4OdimMOOCM7LMte06hLekDHLrPkr+8oLhaZSPBEEYXL2dam3ku+
8haNdN4crOAX5C/WfuSjqr7D1Hm5e80QFfTvPsg4nIgkOeyyxu6d5/yrFQOs7Zma
D0Txb7xuJTY/5V1t7h6XjR1f6INyQUZ0cPAjgUvfpv/KC02LJKtLC78WGQmmElOJ
aVYMA2zwlelYqRc7Ul2T/Wu//iTObY1tR35pOo9ztPOEqsA/0+0H6b4Q1oSe+7i/
E3bNZFBpiT4MU+AAU66dvNAtKXwhzR7YpENcLfNMhG2eN5tcM4hbPfjXWzev7uVN
rY8KFBTlMeyBUgP2O+HZiCNtLgnRXuhRvNfPxsbFJRLKXT8ofWU1VlIR7P224VaU
dYzObYxejksIzzC1ZpTFk6hUBQGo0wiPHcJ2IKEwjHG6MSi32jNmNO5NtfH/uWhO
5Dl543Y7
=VDcF
-----END PGP SIGNATURE-----

--wHMH4bK5JDva5RiX--
