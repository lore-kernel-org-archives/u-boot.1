Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13EDC5AD49
	for <u-boot@archiver.kernel.org>; Tue,  3 Jun 2025 23:50:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id EF72981FEE;
	Wed,  4 Jun 2025 01:50:31 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q1+5Y2oJ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C0B50828BC; Wed,  4 Jun 2025 01:50:30 +0200 (CEST)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com
 [IPv6:2607:f8b0:4864:20::c30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4C2CC81F0D
 for <u-boot@lists.denx.de>; Wed,  4 Jun 2025 01:50:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-60d6303a11eso2344740eaf.0
 for <u-boot@lists.denx.de>; Tue, 03 Jun 2025 16:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748994627; x=1749599427; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gGlB1V5D/Ph+FHCYZjsLRZ0yritGBrPQHUhSnbjxHns=;
 b=q1+5Y2oJBWKTYNO0KVtjozHo6k4ECINTKYZVDtmPqbigA+V89qi+S1/9u1OHyrOXwW
 ELL87s4zttreMVqEvps9FhdHTCaWBTqBlZctpmvmpgXL+UuSxZePoMpWVhJ1LeY1Camb
 PDfa58EeFAiyEGlkV1DtsrYH4ctm4JAVFIf7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748994627; x=1749599427;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gGlB1V5D/Ph+FHCYZjsLRZ0yritGBrPQHUhSnbjxHns=;
 b=fZYJWbvJ2J8igca+PRaN2IV+RHysZrIjFRkwGU1MLBhBGZUFP2D78eJFmXrEKRGOhd
 XDLY0NdQXCtUeGnd2LuYkeRkNBBSu3itdx0gH/uymtqMEsjDPyp+UuVpLgQjF/vMhjlT
 A5JbE+8lk/m/sVMf8z/0efEIqMtbvZ4+FQstYwHgZo0wz2po1tv54C7d8q/m1/xwe10h
 SYxX1jOTvjt1wjzKd2ITprilDpRGFkDmnOAB0j3kuUPMYhRhcNl/VqVw99plNzKc7MBO
 wBtXGIAgGB0ZU2xdRFxD6tuDOo4rhn4IIUfoqMjANVcgwpi35M1nqookqABOsM/5J6TO
 IXFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNC5tGAESiu0jJhDSoS3mrSQQYSA2bxJrJiSLKPRf1r/ouyaB7gpbTepeXWqqllprfedAakbk=@lists.denx.de
X-Gm-Message-State: AOJu0Yw6mNW85OARsKBHQBkw36cXTT44kspCCfmDwn7ROuOd2kHJo+92
 3bKLXTnKI/trTRPEDQ8TM2gWwVeFyO/b/KBPk9DlfgBvORyT/TEAMq+s2P1dVhW82SBHnmqSgbY
 e645gKUk=
X-Gm-Gg: ASbGnctHL+90r/7ne7h2fe1YnUmOKAGrzi0vZl/NjfK0UI9znTVu4N9lIlBAa19nq00
 b/cCDCTC5z5TYcevawkcMzKQDUsYiPZg/MvEti/PO8uzUiYa64lmG1T4yrkzrjNbRMyv9iFB3lT
 GmSJkvrpl0WZ1Lg0RUics5U3EKBel3xIfAGvsKMgcQY34DVD1JKAlwUmw2aDNMXRvhfndlDnVz0
 Jj1+N8IPgwSswQUYOoZDpNNeGnDeeZxdyazCOyujQ54k+XLlYetTwcG5elzGzPc3EMuiVX9uREI
 ZvfSHO25dWUHbmQ8EZZRNTaKlfBBnX1K2LFIpelyuiuAzeQ5MEfu9AQSOzf30AsAd1+hbDeTdYe
 mhxtiXSagWYvA
X-Google-Smtp-Source: AGHT+IHPbpm3mXz7X1bXd9uuhb4gvlARCPGX6raz2gdp6Qvwm3tdrUPYheinkNWMjRaUYYJXWU7Wvg==
X-Received: by 2002:a05:6820:987:b0:60f:b11:d920 with SMTP id
 006d021491bc7-60f0c59dcfcmr360573eaf.0.1748994627061; 
 Tue, 03 Jun 2025 16:50:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c8aeb8sm2025241eaf.18.2025.06.03.16.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 16:50:26 -0700 (PDT)
Date: Tue, 3 Jun 2025 17:50:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Frieder Schrempf <frieder.schrempf@kontron.de>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/2] linux/bitfield.h: import FIELD_PREP_CONST macro from
 Linux Kernel
Message-ID: <20250603235023.GM1382132@bill-the-cat>
References: <20250603085132.12407-1-ansuelsmth@gmail.com>
 <d272087c-4f0d-406f-9630-57fc1c68b403@cherry.de>
 <683f5d03.df0a0220.437bb.ca9c@mx.google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="hTbodRDEgdlTsoKp"
Content-Disposition: inline
In-Reply-To: <683f5d03.df0a0220.437bb.ca9c@mx.google.com>
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


--hTbodRDEgdlTsoKp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 03, 2025 at 10:37:22PM +0200, Christian Marangi wrote:
> On Tue, Jun 03, 2025 at 05:08:13PM +0200, Quentin Schulz wrote:
> > Hi Christian,
> >=20
> > On 6/3/25 10:51 AM, Christian Marangi wrote:
> > > Import FIELD_PREP_CONST macro from Linux Kernel to permit usage of
> > > FIELD_PREP with scenario where a constant value is needed.
> > >=20
> > > Refer to commit e2192de59e45 ("bitfield: add FIELD_PREP_CONST()") in
> > > Linux kernel for extensive explaination of why this is useful.
> > >=20
> > > This is also to better align with the Linux Kernel for easier porting=
 of
> > > driver.
> > >=20
> >=20
> > Do you know it it'd be possible to simply copy Linux kernel's bitfield.h
> > instead of "cherry-picking" individual commit(s)?
> >=20
>=20
> Mhhh what do you mean? You mean syncing the full header with latest
> version?
>=20
> Isn't that more risky??

It would be helpful and shouldn't be too risky. At a quick glance, the
first minor issue is to just keep using <linux/bug.h> as
include/linux/bug*h also need to be resynced. This kind of change would
need to be run through CI as well as documented at
https://docs.u-boot.org/en/latest/develop/ci_testing.html

--=20
Tom

--hTbodRDEgdlTsoKp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg/ijwACgkQFHw5/5Y0
tyzncQv/V3/WiV1vGK6lYTMnWaCXWbjtFbUY8d+SSBqc1scr6dOmdPkB6jO/MsbY
E5BNJq7xiL1x1tdLO9yN0gSW1K720dXwaOEYwG4evi/XJX3TExe7G19T/HLX4DVD
zC/V8R64Ris+oihwDp6IjCfEZV+jODPDkceBeXEXTLqZfrSOnSBhQmWSdNz76d+c
mHIeEVzCHa/KbykOd7Muw7gqkxPNIYkv+iYH3g5wps31gSgHNgHQqf5+Qc6EmFu8
kFfehSsvkqlq4o1yP59EiDUYmpZzDm72lTE9BpGFjGVX1qkAYgh4sOEoVxsazvT1
4vt9iF2Xt1Q/1yIfPIcMefaC+om36hulfdktwqUQHjLKdLTsd6PCfG0VzWMIfagG
nce9e+JmRxrbowwPbQjrGEn6ZkGB4lgb/p2tqr3BC+GZihUwrowWA2987WfpThdX
Oz7bGUlmLM79YJAxqdyomFYZpGwJFaJzq/ccZFX1AYB9v+tj/A/w2rC3TBvtD5zR
cBFV5dFF
=q3oy
-----END PGP SIGNATURE-----

--hTbodRDEgdlTsoKp--
