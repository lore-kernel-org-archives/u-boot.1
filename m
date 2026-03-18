Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB78DFD8779
	for <u-boot@archiver.kernel.org>; Wed, 18 Mar 2026 01:26:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 55C74840A2;
	Wed, 18 Mar 2026 02:26:06 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="uHIVZCsJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 48E3E84105; Wed, 18 Mar 2026 02:26:05 +0100 (CET)
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AD02884027
 for <u-boot@lists.denx.de>; Wed, 18 Mar 2026 02:26:01 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2e.google.com with SMTP id
 006d021491bc7-67ba58c0220so330278eaf.0
 for <u-boot@lists.denx.de>; Tue, 17 Mar 2026 18:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773797160; x=1774401960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=zCBiUmOhLZr/zlatcL/vMzONqZlHsuu8qxbtuEyjx3E=;
 b=uHIVZCsJUyz5ainu0Omlytc56RgXyyZGju7TZqSwcMyPOHkzDA6rDszegHFcBmiLng
 iNJ62ZYOglEYZSNlSjMw6cshA0SAjSjJhCR3/aCUjZ2YQshZRyFDFHvZ5NvLqOOovEPF
 y71MLto21wdKLOuy+Ff/becuDxsNiDfd1LJWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773797160; x=1774401960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zCBiUmOhLZr/zlatcL/vMzONqZlHsuu8qxbtuEyjx3E=;
 b=nAHf/p1jIQX6UvwsXCNIf0Hr7nb3+2W6jj+hRbg1AgfYSgIP4ZNV6G3bgiEDXhJd0f
 s9CKr3XF1qKBbH0z2DgKeNB45t4cORUJHzSwnr1PTuBLhFIq//NNtFRojfRlzQ3XN9JE
 Nej1S3TKvhq+Sk63KoB6lEuhgJwybu9mRRqyXhTzSEpYt06Qz0B1XlZyNtuJ+9RmTzBP
 4yc46znkwUXkt2XzSc+THLF+6HHsVDEoJG+eN5wCQj3kCLKOTi8uFNuunaxQrJ9O0EEU
 xKVCNK2gKhPjcC4S4Vdt6guZc3RTwc1T4lt3TtPtHuuBFrMp7sdPj2hK34THpLtvWHJv
 vGqw==
X-Gm-Message-State: AOJu0YxK0AXfjM5KmQkLk9J5EgbYLybNR5+ZHMB5CD44JJhYaVWFLQS5
 bmnlUfgsyhmAV+PsL1/Qyaph2/iVnjCUyyksKRfZJFMv2rs2IFNDE0sPjiteH/wk1DA=
X-Gm-Gg: ATEYQzyCL+twVfs+878gxypOYRqwpTNGo20V0q9YznZP+CwJrgc3TWIl6oJeMHlPS9n
 4FOHX0IVEuiMJxOFlGfe2fJETc1Ayd72KcZJYDwncCE0qpvQELnoNGJYnyhWGXOQ25uOb6Pw/Nn
 f8oZ8rWX1YgEPrQ7IdeBhH9TaKblTdCiVo1FAzZ7aHDsPROXQTJXts3Am4m5CJ7i+yCttwswmK6
 JnIs2tjZO5nla+Z5XDaWkWd/POg2HfE3eb3KVeWwpDMOWDlB7UIeFDpw6dWmPUS4tHh0nDMzpuT
 o/pQ0VzInpkZ+UbIwbzhbengvxXCFrK2SUlPwgEePeruENUw3VFnk+wbxiYCd/JvN64BMjxABed
 85D02/Tuxu+Ze9Iv1w6RW8YCytV4ZDYq7FRBQCgQ5ukwoQ0LVqDqQa46TqHKlk0VlVb+vjRN94y
 2x2cjdSULzSxm/VzBAYmDd+6aMYq4dxJwIU3pZJVxIaYF5hNhrWnoTl5FueVuX0HrEk6/1/vR/v
 G1FCWEChjdYTLbFxmNRLS7dfZ47tBk++JLq6a2DF73/gOPk
X-Received: by 2002:a05:6820:4a8a:b0:67b:ba86:2dce with SMTP id
 006d021491bc7-67c0d0b7095mr883142eaf.36.1773797160291; 
 Tue, 17 Mar 2026 18:26:00 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-67c0d8afe2fsm651955eaf.15.2026.03.17.18.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 18:25:59 -0700 (PDT)
Date: Tue, 17 Mar 2026 19:25:57 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>
Subject: Re: [PATCH] reset: Correct dependencies for RESET_RZG2L_USBPHY_CTRL
Message-ID: <20260318012557.GF502704@bill-the-cat>
References: <20260317012443.4162600-1-trini@konsulko.com>
 <ed88ec35-7d53-48df-a65b-7da1298e265b@mailbox.org>
 <20260317134008.GQ502704@bill-the-cat>
 <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ORfOTSWc76CJV7rD"
Content-Disposition: inline
In-Reply-To: <58699be1-5414-4749-9975-7fdf0064b1a3@mailbox.org>
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


--ORfOTSWc76CJV7rD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 08:41:26PM +0100, Marek Vasut wrote:
> On 3/17/26 2:40 PM, Tom Rini wrote:
> > On Tue, Mar 17, 2026 at 03:33:57AM +0100, Marek Vasut wrote:
> > > On 3/17/26 2:24 AM, Tom Rini wrote:
> > > > As exposed by "make randconfig", we have an issue with the dependen=
cies
> > > > for RESET_RZG2L_USBPHY_CTRL. As REGULATOR_RZG2L_USBPHY depends on
> > > > DM_REGULATOR this symbol must also depend on it as well.
> > > >=20
> > > > Signed-off-by: Tom Rini <trini@konsulko.com>
> > > > ---
> > > > Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>
> > > > ---
> > > >    drivers/reset/Kconfig | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> > > > index 66911199c8ba..3f0ec50510c0 100644
> > > > --- a/drivers/reset/Kconfig
> > > > +++ b/drivers/reset/Kconfig
> > > > @@ -239,7 +239,7 @@ config RESET_AT91
> > > >    config RESET_RZG2L_USBPHY_CTRL
> > > >    	bool "Enable support for Renesas RZ/G2L USB 2.0 PHY control"
> > > > -	depends on DM_RESET
> > > > +	depends on DM_RESET && DM_REGULATOR
> > > >    	select REGULATOR_RZG2L_USBPHY
> > > But this already selects REGULATOR_RZG2L_USBPHY , which according to
> > > drivers/power/regulator/Kconfig contains:
> > >=20
> > > 508 config REGULATOR_RZG2L_USBPHY
> > > 509         bool "Enable driver for RZ/G2L USB PHY VBUS supply"
> > > 510         depends on DM_REGULATOR
> > >=20
> > > which does depend on DM_REGULATOR transitively ?
> >=20
> > That's why Kconfig complains about the unmet dependency. "randconfig"
> > does some fun and apparently valid things.
> That's the thing -- if RESET_RZG2L_USBPHY_CTRL depends on
> REGULATOR_RZG2L_USBPHY which depends on DM_REGULATOR, how can DM_REGULATOR
> be unset, while RESET_RZG2L_USBPHY_CTRL is set ?

Using "randconfig" will find some odd problems, yes, because it makes a
(based on what all of the Kconfig files say) possible config and then
forces it to be validated against the expressed logic.

So I think the answer is if you fire up menuconfig, and turn off
RESET_RZG2L_USBPHY_CTRL and REGULATOR_RZG2L_USBPHY and DM_REGULATOR and
then enable RESET_RZG2L_USBPHY_CTRL things will become mad because
RESET_RZG2L_USBPHY_CTRL has select'd REGULATOR_RZG2L_USBPHY but we don't
have DM_REGULATOR.

--=20
Tom

--ORfOTSWc76CJV7rD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabn/IQAKCRAr4qD1Cr/k
ClqFAP4u/ZzY/K6SxYpCiTvqBu6inLOmIJAbt6PoAPwOWE3F+AD+N0CnmXDiUq0C
Xxlpmy+3RJdGHNBJGZpFx8UCZMzEkAY=
=7B9B
-----END PGP SIGNATURE-----

--ORfOTSWc76CJV7rD--
