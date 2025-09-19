Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB9A9CAC592
	for <u-boot@archiver.kernel.org>; Fri, 19 Sep 2025 14:11:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 437D08323A;
	Fri, 19 Sep 2025 16:11:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FZv5xzWA";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C07D783285; Fri, 19 Sep 2025 16:11:07 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1F1118319C
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 16:11:03 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-750c5378b96so1167497a34.0
 for <u-boot@lists.denx.de>; Fri, 19 Sep 2025 07:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758291061; x=1758895861; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BkxmDnl2MPuViF8EnXX4KB0bG0+7x400ZKjzJ1vJ5Sc=;
 b=FZv5xzWA+VtTnxKwTU+8FIuG5ntK83auXYHOf5S1KueibhAvITceFGWkmaGmBPaho0
 ov8Ld8h7DFQKtLO0C9Pq7TR0AijFrKyL2k4e+MzhupcpFzMEbMYYdhp6f5Zv3ajeR72t
 fytkLgrZpg/h9eFQGsPxhPgpSg7j47KqfMr7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758291061; x=1758895861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BkxmDnl2MPuViF8EnXX4KB0bG0+7x400ZKjzJ1vJ5Sc=;
 b=iIenr+wNoqycd+yWwqjOkK+84zGq5q0y10Z1bdGavfzd8hJdqhFK2PpqBH9V41JpoF
 7A+xwVjH2LldJ9PPabLeluUCBycLnN/rgwCht86GpYgJu28B9ck8+3VLmqyFlAq09zx5
 8yFquEDK//xmZUwOIWds3oewRAC20nY82YitoN4yEl8dFSWK0ByBMHLzjWQd44zKmk9A
 eFjKz45uDndCWbDmHPpIejclFq5hQ5JlXsjPF1F1/YIWlj2mIRiADixgOh8a/cJyQjXZ
 w7ozYMS5VBINnceyrgwm59gxkLhX41PQlTrURnCuYIy6h8Z/NqG/cTskNR00gs1C5sL6
 7EAw==
X-Gm-Message-State: AOJu0YwqVZMgba5ok60WJwugRV6+YsGK+eM7R5KA8mHR8N/faHbopmOl
 9lpaEeC2WrwB7UAtLbSpLwGgA98I5y+q4VzZtpNR+AV5gFsBnsWAbEphDW4m9ZRisIs=
X-Gm-Gg: ASbGncvFDCMhqHODNulgcam5XQhxmupmvo3k7YEceyeOrrgkQGJpCMrrKriasE6Boqh
 46qMyuKsJeKZEusR1CqIcRJVZxRKY6esHo2pSOrubInfNSdIo8P2qCX2XpLMmZ7pTfXu8JTk9OX
 maNN14Hwe5aqtoFy+WUFnFeLuYgrstt7c7vsJSoHFb1G8EzMzs1GRGPKBwVxOrSJaaQV2pjjcXA
 N/ID5G8yIa186gk3AsJaLJbKyW73/0m6eDF58wUTYiXXA6qqQ2LAqagX6PMc13dmcPXKi2OYNaW
 TZFQub9rdL2NKCaZgVcH3d72o53IlNamu+AKm5pmpR2t0zyzuh5gu9AJ6cnpP36RNWFC4rx7sle
 LIa8dLTd+N1Jk5aoBcamTMeZsEt4+kEd5ACifURBf+fLoeXgBFM+NyYIC
X-Google-Smtp-Source: AGHT+IHLgNiPL+BMyzaX0bLTteSc+MOruPHwx69XI61KAhi9MvNvSHkiA4WPRgcsqPOrzsg9MKQuLg==
X-Received: by 2002:a05:6830:4d83:10b0:74d:4c81:d7a1 with SMTP id
 46e09a7af769-768f81e825fmr3561245a34.4.1758291061202; 
 Fri, 19 Sep 2025 07:11:01 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-625dbe9db87sm1733575eaf.26.2025.09.19.07.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Sep 2025 07:11:00 -0700 (PDT)
Date: Fri, 19 Sep 2025 08:10:58 -0600
From: Tom Rini <trini@konsulko.com>
To: Maarten Brock <Maarten.Brock@sttls.nl>
Cc: "u-boot@lists.denx.de" <u-boot@lists.denx.de>,
 "ilias.apalodimas@linaro.org" <ilias.apalodimas@linaro.org>,
 "jerome.forissier@linaro.org" <jerome.forissier@linaro.org>,
 Kory Maincent <kory.maincent@bootlin.com>,
 "sjg@chromium.org" <sjg@chromium.org>
Subject: Re: [PATCH 1/1] board: ti: am335x: Do not call disabled PMIC functions
Message-ID: <20250919141058.GT124814@bill-the-cat>
References: <DB6PR05MB4551D31271569EC04E8EC60F830CA@DB6PR05MB4551.eurprd05.prod.outlook.com>
 <20250919001117.GA974973@bill-the-cat>
 <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Yj4yZhfj4H6nMr3+"
Content-Disposition: inline
In-Reply-To: <DB6PR05MB455171F726E8D6E540141BAE8311A@DB6PR05MB4551.eurprd05.prod.outlook.com>
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


--Yj4yZhfj4H6nMr3+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 08:15:28AM +0000, Maarten Brock wrote:
> > From: Tom Rini <trini@konsulko.com>
> > On Mon, Sep 08, 2025 at 04:05:04PM +0000, Maarten Brock wrote:
> >=20
> > > When PMIC drivers are disabled their functions should not be called.
> > >
> > > Signed-off-by: Maarten Brock <maarten.brock@sttls.nl>
> > > ---
> > >
> > >  board/ti/am335x/board.c | 8 +++++++-
> > >  1 file changed, 7 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/board/ti/am335x/board.c b/board/ti/am335x/board.c
> > > index 2b7ab68e83c..284c31cc329 100644
> > > --- a/board/ti/am335x/board.c
> > > +++ b/board/ti/am335x/board.c
> > > @@ -283,7 +283,7 @@ const struct dpll_params *get_dpll_ddr_params(voi=
d)
> > >
> > >  static u8 bone_not_connected_to_ac_power(void)
> > >  {
> > > -	if (board_is_bone()) {
> > > +	if (CONFIG_IS_ENABLED(PMIC_TPS65217) && board_is_bone()) {
> > >  		uchar pmic_status_reg;
> > >  		if (tps65217_reg_read(TPS65217_STATUS,
> > >  				      &pmic_status_reg))
> >=20
> > The problem is that here and elsewhere we don't have SPL_xxx symbols and
> > so we're turning off these calls in SPL now on the platforms which would
> > be calling them.
>=20
> That would be really odd. The function tps65217_reg_read() is not defined=
 when CONFIG_PMIC_TPS65217 is not defined. So how could these calls work th=
en? For me it leads to a build failure. Or did I use an incorrect macro wit=
h CONFIG_IS_ENABLED to solve this?

The symbol will be defined in both SPL and full U-Boot builds but
CONFIG_IS_ENABLED(X) only checks for CONFIG_$(PHASE_)X being enabled. So
the issue is that CONFIG_PMIC_TPS65217 is define but
CONFIG_SPL_PMIC_TPS65217 doesn't exist and isn't defined. The
IS_ENABLED(CONFIG_X) macro is what checks for CONFIG_X being defined,
regardless of phase of the build. It's the CONFIG_FOO_MODULE problem the
linux kernel has, except our modifier is in the middle, not the end of
the name.

--=20
Tom

--Yj4yZhfj4H6nMr3+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaM1kbgAKCRAr4qD1Cr/k
ClWkAQDwgW0tXTVjjsBfrvsMli9hkaBj9bylE4I4hCDMluAUOQEAwrQAQHeyFLPa
TRM7UmzVMFkksovabWaam8O8jifOoQ8=
=iQxZ
-----END PGP SIGNATURE-----

--Yj4yZhfj4H6nMr3+--
