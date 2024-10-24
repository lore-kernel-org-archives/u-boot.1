Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F110CE8E8A
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 15:20:38 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6738F88CD9;
	Thu, 24 Oct 2024 17:20:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GcTUkEYf";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E1F388DFE; Thu, 24 Oct 2024 17:20:35 +0200 (CEST)
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com
 [IPv6:2607:f8b0:4864:20::f2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id BA39A88C3E
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 17:20:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6cbf347dc66so6036256d6.3
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 08:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729783223; x=1730388023; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tundspbPVx0+A+uJNA6rNW6cDbv0pZMZI8KwgU+a5jE=;
 b=GcTUkEYfwxJ5bZTJxIFaNZhij8rKfvrMa93NiVwv3o67zYV4brcVbhgB3MrIFLVXAK
 NyIDyC3jDy+DEAJkL8b+wUctNLLH2TOATQsQX/6qUjxz36xvXSV5BQWOIS84RRyxHLU0
 2ibAWr4tYu1Qh9QGgr2DGy5DaFwHCjDU1MEWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729783223; x=1730388023;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tundspbPVx0+A+uJNA6rNW6cDbv0pZMZI8KwgU+a5jE=;
 b=P3tq3iet7QEQcxbIu+iivc5GG5a27eKQFeGNAq3SlDKInOqEbLfRtRwte6RyB2qUqC
 I2RTl2+dp6UNpnARmnDCc6npHPL/rTjG7y5qFWjEhIVG/CRgs6FWIRk2fcZ0GnA3QbPQ
 +yYy3tm3lH6RsQNfgP6mQ6KpSc/rDjiOE8AbMSwrdpjABAkPGYDWDFlhir9/QJzBZxwj
 3FO63+ooblwbPWdaIZSFZMVqsRyPtU3Qpmd8pDSYqozQX8USWD47MAPJg2ik+Gspqei3
 DmID9jyeZujbj+BQ1UPCuPp4SRVrh9Ou/dzIa8xzJzCRXsYeKaW5UwEelmJCiXm18m3D
 kmtQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGA/kZ/g9X93wXkp3RiH0rwRRpyBqVLAQwLa2//QWzouhN2L+sGDcXlzppwZm7OAoEFrtFFAA=@lists.denx.de
X-Gm-Message-State: AOJu0YwTp5c/Q8DBSUmKaiHo/uGusNfcTgwvEhDuqj1bviF24JkcRu7S
 JRBAt8xDFPTC6HmKga+ociDxr5v9CYs7EEaFc7hWnQWKTK/I+0bcsJckrHZHbXU=
X-Google-Smtp-Source: AGHT+IHqkMnnlEy2G8z0HVejCne5FIX/ych4CE1NSzrB44j9gwWYI2O1xvAbzZ5gQ2A/v8OON72wlw==
X-Received: by 2002:a05:6214:3c85:b0:6cb:e6fa:4960 with SMTP id
 6a1803df08f44-6ce33f33bc5mr83727786d6.0.1729783223550; 
 Thu, 24 Oct 2024 08:20:23 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce008b2a48sm50918636d6.25.2024.10.24.08.20.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2024 08:20:22 -0700 (PDT)
Date: Thu, 24 Oct 2024 09:20:19 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Rasmus Villemoes <ravi@prevas.dk>, u-boot@lists.denx.de,
 Tim Harvey <tharvey@gateworks.com>, Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] imx8m: set sane default value for SPL_LOAD_FIT_ADDRESS
Message-ID: <20241024152019.GS4959@bill-the-cat>
References: <20241024100145.841964-1-ravi@prevas.dk>
 <58754a24-eb1a-4306-a5de-e990539b1717@denx.de>
 <87seslprkk.fsf@prevas.dk>
 <5b9d07eb-14f1-4ac8-bc3f-69cdd8b87a73@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="f2qSurzryZV97g7U"
Content-Disposition: inline
In-Reply-To: <5b9d07eb-14f1-4ac8-bc3f-69cdd8b87a73@denx.de>
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


--f2qSurzryZV97g7U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 04:06:03PM +0200, Marek Vasut wrote:
> On 10/24/24 3:18 PM, Rasmus Villemoes wrote:
> > On Thu, Oct 24 2024, Marek Vasut <marex@denx.de> wrote:
> >=20
> > > On 10/24/24 12:01 PM, Rasmus Villemoes wrote:
> > > > I enabled IMX_HAB on an imx8mp board, but even though I knew about =
the
> > > > implementation, I forgot that I had to provide a sane value for
> > > > SPL_LOAD_FIT_ADDRESS. The help text for IMX_HAB doesn't mention this
> > > > implicit requirement, and there's no build-time warning; the default
> > > > 0x0 value just ends up being returned from
> > > > board_spl_fit_buffer_addr(), obviously resulting in a non-booting
> > > > board.
> > > > The existing imx8m* board configs that set a non-zero value
> > > > currently
> > > > all use 0x44000000. The actual value doesn't matter too much, but 0=
 is
> > > > always wrong for imx8m platforms. So just use 0x44000000 as default
> > > > for those platforms.
> > > > Signed-off-by: Rasmus Villemoes <ravi@prevas.dk>
> > > > ---
> > > >    boot/Kconfig | 1 +
> > > >    1 file changed, 1 insertion(+)
> > > > diff --git a/boot/Kconfig b/boot/Kconfig
> > > > index 940389d4882..72d1f69afcd 100644
> > > > --- a/boot/Kconfig
> > > > +++ b/boot/Kconfig
> > > > @@ -231,6 +231,7 @@ config SPL_LOAD_FIT
> > > >    config SPL_LOAD_FIT_ADDRESS
> > > >    	hex "load address of fit image"
> > > >    	depends on SPL_LOAD_FIT
> > > > +	default 0x44000000 if ARCH_IMX8M
> > > This only applies to HAB , for non-HAB the fitImage can be loaded at
> > > arbitrary location, do you need:
> > >=20
> > > default 0x44000000 if ARCH_IMX8M && IMX_HAB
> > >=20
> > > right ?
> >=20
> > On IMX8 without HAB, the value is not used at all AFAICT (otherwise the
> > value of 0x0 would have caused trouble already). I don't see the harm of
> > setting some sane value that's actually within DRAM space independent of
> > HAB.
> >=20
> > Making the default depend on IMX_HAB has the UX problem that if I do
> > "make imx8mp_evk_defconfig", then go about tweaking stuff, then do "make
> > menuconfig" and enable IMX_HAB, SPL_LOAD_FIT_ADDRESS already has the
> > bogus 0x0 value and nothing forces or asks that to be changed. Making t=
he
> > default depend only on SOC (or SOC family or whatever IMX8M is in this
> > context) makes that problem go away.
> Looking at this closely, common/spl/spl_ram.c does make use of
> CONFIG_SPL_LOAD_FIT_ADDRESS too, so I think yes, we should have a default
> for this.
>=20
> iMX6 should have 0x14000000
> iMX7 should have 0x84000000
> iMX8M should have 0x44000000

These differ, slightly, from the value used in CONFIG_SYS_LOAD_ADDR.
Could that not be used (and the overall option changed to default
SYS_LOAD_ADDR ?

--=20
Tom

--f2qSurzryZV97g7U
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcaZa8ACgkQFHw5/5Y0
tyxymQwAoIhlYNASultQ1f+U0I4b6kNokFg5kPnfeD/H+F5s+FiEAHkZeMVlnBPg
ryiduLRxVy3DLr2TP2X43iHQdQGxHtH0vrLWtapm6t0SM23RRU6Za5SpUQkbs8Hl
8xY9OTCFGcImSYYJ7mAETZxZ3jNRUim6EX/QKAQ+FPUtQX5MQLuMf1w7BrQB/+el
QE7yaThZ+IJG3XU5y6Z1wSo/0ZvmMhT/n7rcW+4aEo9fZg9au9tT94ttZkLHU7YQ
PT4pYJk1tVIqKKjrIT8q6Zy6g+5/JJf+IvhuqY2bAocBdm8NAmdWpwq88wUV8VNM
r4PH3+KTh13rXit+UUszHchp9UVTMdV2zlbPZfc+rQ6mPYLZdOt0d82LW7NE79AH
nVQ/+MnMkYjehwBzQ7j3LAVNPBtiBSmMQ6M3tU3OXay0X86zoxX7tzSjTmPGEveI
l90nNo1dDHqzK+yzr1yr6jXdPhi+cNwzz3S+DNFv+lC/W+Nl2Vzb9FMkVnGfz8kw
7U9uqpqN
=eSUl
-----END PGP SIGNATURE-----

--f2qSurzryZV97g7U--
