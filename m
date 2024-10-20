Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1123CD3C927
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 02:55:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 630828910A;
	Sun, 20 Oct 2024 04:55:36 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TLC5fpxn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 40F9C8918C; Sun, 20 Oct 2024 04:55:35 +0200 (CEST)
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com
 [IPv6:2607:f8b0:4864:20::82e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0DA1F890BF
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 04:55:33 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82e.google.com with SMTP id
 d75a77b69052e-4609c9b39d0so22409241cf.1
 for <u-boot@lists.denx.de>; Sat, 19 Oct 2024 19:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729392932; x=1729997732; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=LpQP4qpBDa2F0v9O1RE282n9D+u7w8BWcbG+KOAmVDg=;
 b=TLC5fpxnkE4+muePga4xD5iiUSvqwDTw7N0ph3IMRikYu7NdJ+d/KssE24WZij7uyd
 47CYZjtLcqwmex9K6QVXBM40j+NVt8bOmMWrTroixLmIC9GVQDPITQjmt6tekusaOyFy
 +aM7koHd6hKrmrjhUqQztj87RDBqwVnJXDmS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729392932; x=1729997732;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpQP4qpBDa2F0v9O1RE282n9D+u7w8BWcbG+KOAmVDg=;
 b=JRmjvGvokAgy/ypQTehXhYWJJD+cipRpyLftcxtg+lgomvV7hX3iqiSQz0kZ5ndAQC
 Z4ni3NK7aq2Brflaq3LYoj/4kGAGCZimZZBiwO0h4KPiKYgUkgqfZjfK9qiW40c2HPx0
 ou2H7OpELqt2VIfRjKkqNmsyy3KHqdxqzU2cFm45JGg+KWUrD6xWdkDjgCnhp7xUeWqq
 bydYNgj5cbiptyyQs67MQ2zd8c0QbizGzDmOvbsNQC50ieBTAagQd1otTrl0Wz9dkgYL
 A0U9cSXVpT2arwzeSZ3/KEUlcnc8aSghejV//t1BuB5EY9x601AZ/RUY0PAaLxQoywyp
 yV5w==
X-Gm-Message-State: AOJu0Yx4kXiY6CVQ530pTCyOL6K7LsQqzI5dj7SiSgmZeL4/BZLMWRUd
 f8vLR0PuT2f3dy6w/dQefxojbll9ePzkRMTTuKLFSIv7y4EsKgsi7N3gX1GhlfY=
X-Google-Smtp-Source: AGHT+IGjuFFqlMFtNlifLZiyTqjYKwbxMSIrKyBTprwpq0i/wWcLXdrkcT9XP8B/KCOlkZYHQ54bvQ==
X-Received: by 2002:ac8:5907:0:b0:460:39b1:b419 with SMTP id
 d75a77b69052e-460aee0b9c5mr118359111cf.46.1729392931621; 
 Sat, 19 Oct 2024 19:55:31 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-460d3c62f4dsm3628201cf.28.2024.10.19.19.55.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 19 Oct 2024 19:55:30 -0700 (PDT)
Date: Sat, 19 Oct 2024 20:55:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Adam Ford <aford173@gmail.com>,
 Breno Lima <breno.lima@nxp.com>,
 Francesco Montefoschi <francesco.montefoschi@udoo.org>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Marcel Ziswiler <marcel.ziswiler@toradex.com>,
 Peng Fan <peng.fan@nxp.com>, Sean Anderson <seanga2@gmail.com>,
 Simon Glass <sjg@chromium.org>, u-boot@dh-electronics.com,
 Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ARM: imx: soc: Select default TEXT_BASE for i.MX6
Message-ID: <20241020025526.GD4959@bill-the-cat>
References: <20241019220938.365256-1-marex@denx.de>
 <20241020002701.GC4959@bill-the-cat>
 <403105c3-e432-4d1d-a986-b81ca786b6d5@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Wl4EOzQFUcFNV5Ta"
Content-Disposition: inline
In-Reply-To: <403105c3-e432-4d1d-a986-b81ca786b6d5@denx.de>
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


--Wl4EOzQFUcFNV5Ta
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 04:25:38AM +0200, Marek Vasut wrote:
> On 10/20/24 2:27 AM, Tom Rini wrote:
> > On Sun, Oct 20, 2024 at 12:09:03AM +0200, Marek Vasut wrote:
> >=20
> > > Select default U-Boot and SPL text base for the i.MX6 SoC. The U-Boot
> > > and SPL text base is picked as the one used by various i.MX6 boards.
> > > Update all the boards.
> > >=20
> > > Signed-off-by: Marek Vasut <marex@denx.de>
> > [snip]
> > > diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx6/Kc=
onfig
> > > index 1f8022ee685..10b19984143 100644
> > > --- a/arch/arm/mach-imx/mx6/Kconfig
> > > +++ b/arch/arm/mach-imx/mx6/Kconfig
> > > @@ -15,6 +15,13 @@ config MX6
> > >   	select GPT_TIMER if !MX6UL && !MX6ULL
> > >   	imply CMD_FUSE
> > > +config TEXT_BASE
> > > +	default 0x17800000
> > > +
> > > +config SPL_TEXT_BASE
> > > +	depends on SPL
> > > +	default 0x00908000
> >=20
> > Please do these in Kconfig and common/spl/Kconfig with the other
> > SoC-wide default values, thanks.
> There are many examples which do it in arch/$ARCH/$SOC , imx7 does it
> already, so ... why Kconfig instead ?
>=20
> $ git grep config.TEXT_BASE
> Kconfig:config TEXT_BASE
> arch/arm/mach-apple/Kconfig:config TEXT_BASE
> arch/arm/mach-aspeed/Kconfig:config TEXT_BASE
> arch/arm/mach-imx/mx7/Kconfig:config TEXT_BASE
> arch/arm/mach-ipq40xx/Kconfig:config TEXT_BASE
> arch/arm/mach-npcm/Kconfig:config TEXT_BASE
> arch/arm/mach-owl/Kconfig:config TEXT_BASE
> arch/arm/mach-rockchip/Kconfig:config TEXT_BASE
> arch/arm/mach-rockchip/rk3308/Kconfig:config TEXT_BASE
> arch/arm/mach-rockchip/rk3568/Kconfig:config TEXT_BASE
> arch/arm/mach-rockchip/rk3588/Kconfig:config TEXT_BASE
> arch/arm/mach-rockchip/rv1126/Kconfig:config TEXT_BASE
> arch/arm/mach-socfpga/Kconfig:config TEXT_BASE
> arch/arm/mach-stm32mp/Kconfig.13x:config TEXT_BASE
> arch/arm/mach-stm32mp/Kconfig.15x:config TEXT_BASE
> arch/arm/mach-stm32mp/Kconfig.25x:config TEXT_BASE

There are many bad examples. In general (and excluding shoving stuff
under board/.../Kconfig) I prefer those values to be in the top-level
Kconfig that asks them rather than per-arch so that it's (a) hopefully
clear that yes, SoCs can and should add a default when it's known and
(b) because perhaps this will lead to someone thinking on the problem of
how ugly it can be and what may be a better solution. Kconfig is
certainly better than CML1 was/is, and better than our ad-hoc just
define stuff in board.h files, but it's not perfect. OTOH, if someone
wants to break down the options we've put (I've told people to put) in
the top-level Kconfig and instead demonstrate and document a reasonable
places to put them, OK.

And if you really want to say that this should just match mx7 for today
and move on for now, alright.

--=20
Tom

--Wl4EOzQFUcFNV5Ta
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcUcRcACgkQFHw5/5Y0
tyzSmQwAj1y356u10BnTiUlzInltu90QERkpTVIwHknJrWaeqpO5TD1WDY+/li3l
zyrgXyb/+Buz/7XldOFOVx+BxXB7AQg+vN4/tvk3EtwynOM36dFLFgZNs2k4D5I5
JVy76u9wRdMgT2YYT+5GMSEBGw5gHFXxRDElCZ84g0p+oL9rjU20HXFfFUCZ4HDa
V0fl92GZ6i41/NQY6D3uvlfZV+jg9Wabsp0A9nMuPO+67fPmtCcqV99T8k7aZw/v
y4SDMrdA0zIHxsvy/9RcIPwNm/ShDY1J9ppiS4/Qi1yEnYMdpYRfUvmaojBeAk74
yVIPf71gVvaEzduL50JJOCP65gwi+tx+mB8DlzqbkK3t8Ws7DiPetxqKopN3DJqi
Ahn2IJiUCezjXIfjQxx8SzimbA4YrfNRyhF8/DYFOxCy/3hfgIX90EAXB4cQbNiq
lZ5GN4K7TYtANpPvFmaERGg+On1KiszhJ6b1jdsvljN/0GPh3kuro3GDib7QOGV9
zivf8GAS
=VRs9
-----END PGP SIGNATURE-----

--Wl4EOzQFUcFNV5Ta--
