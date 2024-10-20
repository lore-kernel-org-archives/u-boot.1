Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9AB5D3C92D
	for <u-boot@archiver.kernel.org>; Sun, 20 Oct 2024 20:16:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 19D7488EB9;
	Sun, 20 Oct 2024 22:16:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="n3U5puLS";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8DB5E88EC0; Sun, 20 Oct 2024 22:16:27 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id C4F9488EB7
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 22:16:23 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2b.google.com with SMTP id
 6a1803df08f44-6cbe3ea8e3fso24516946d6.0
 for <u-boot@lists.denx.de>; Sun, 20 Oct 2024 13:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1729455382; x=1730060182; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PKgUHiXKJFIbzbaPQUttHGdBD5TOIXH3yIGqgTjVOKU=;
 b=n3U5puLS8xJKxpLRutWP3gDo/yi//XnEiy9JUfenqRUV1OkPJlHwSw8TqqoO0eZYC8
 jnn1mAi79hZBMvdXMz5fciL0fXGUwkW81qHhW3Zu23G73ZKtIAh+7RIdFQvhzAFKyz+W
 xHvDRwNoQ6/D9DjpjVbVxLE23ly1dAYxdiZrk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729455382; x=1730060182;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PKgUHiXKJFIbzbaPQUttHGdBD5TOIXH3yIGqgTjVOKU=;
 b=UoVAc2DjNcqI/8B2cZPph5ktEc5mCYKE/x3KB7XaXMUGHxqcdylVnWQlLQwJpx8fBS
 AHadYrRjPcExLwxhIDmdW0tg3wT6m5oDY+nTg6a7xoqNcUXZgTiPz9wH0UUBZ/b5fhsk
 PRKUIaRDslIutrN3I3lkhKytJ3rdF2UX2VLOWQbaCkb0FxQCYSLmaK7m0o1hWiyy36Kj
 KrnmQo7XD7KjbhzDjXj3ZVHyBjq5X+vEZMrNy0wTwDXKNdb3xVQBYgq3ZsQhcQBETdJw
 YE1jPhX//eSXOxlgUtkxDKw8OknRQR4en8ffIK4w36++yoISkPSFyjuvecyOt5XQXdsX
 yUWA==
X-Gm-Message-State: AOJu0YxO1KbtSwjrbZeq7d0csqHiik45gcCr0pi/14d+nhlgVLHVRWev
 06KQdDpb1LmavMRlq4QxHMamkVXYUeHVmbEl3THJ0ol2pnx7jfWoszof5Ph4rfw=
X-Google-Smtp-Source: AGHT+IH3lA5tNRQqUlHTLwmxaI/E7U368MRR6pfxnJ841hzipYdvQWJiSgdTOnd2/P3DQ5ny9kk09Q==
X-Received: by 2002:a05:6214:598d:b0:6cb:f5f8:9099 with SMTP id
 6a1803df08f44-6cde1140679mr155261486d6.0.1729455382540; 
 Sun, 20 Oct 2024 13:16:22 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce00999db7sm10817626d6.89.2024.10.20.13.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Oct 2024 13:16:20 -0700 (PDT)
Date: Sun, 20 Oct 2024 14:16:15 -0600
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
Message-ID: <20241020201615.GF4959@bill-the-cat>
References: <20241019220938.365256-1-marex@denx.de>
 <20241020002701.GC4959@bill-the-cat>
 <403105c3-e432-4d1d-a986-b81ca786b6d5@denx.de>
 <20241020025526.GD4959@bill-the-cat>
 <ab382b09-8e74-4c74-99e2-4188a5b16117@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ocANZ9sV/QPG7XGe"
Content-Disposition: inline
In-Reply-To: <ab382b09-8e74-4c74-99e2-4188a5b16117@denx.de>
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


--ocANZ9sV/QPG7XGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 06:57:35AM +0200, Marek Vasut wrote:
> On 10/20/24 4:55 AM, Tom Rini wrote:
> > On Sun, Oct 20, 2024 at 04:25:38AM +0200, Marek Vasut wrote:
> > > On 10/20/24 2:27 AM, Tom Rini wrote:
> > > > On Sun, Oct 20, 2024 at 12:09:03AM +0200, Marek Vasut wrote:
> > > >=20
> > > > > Select default U-Boot and SPL text base for the i.MX6 SoC. The U-=
Boot
> > > > > and SPL text base is picked as the one used by various i.MX6 boar=
ds.
> > > > > Update all the boards.
> > > > >=20
> > > > > Signed-off-by: Marek Vasut <marex@denx.de>
> > > > [snip]
> > > > > diff --git a/arch/arm/mach-imx/mx6/Kconfig b/arch/arm/mach-imx/mx=
6/Kconfig
> > > > > index 1f8022ee685..10b19984143 100644
> > > > > --- a/arch/arm/mach-imx/mx6/Kconfig
> > > > > +++ b/arch/arm/mach-imx/mx6/Kconfig
> > > > > @@ -15,6 +15,13 @@ config MX6
> > > > >    	select GPT_TIMER if !MX6UL && !MX6ULL
> > > > >    	imply CMD_FUSE
> > > > > +config TEXT_BASE
> > > > > +	default 0x17800000
> > > > > +
> > > > > +config SPL_TEXT_BASE
> > > > > +	depends on SPL
> > > > > +	default 0x00908000
> > > >=20
> > > > Please do these in Kconfig and common/spl/Kconfig with the other
> > > > SoC-wide default values, thanks.
> > > There are many examples which do it in arch/$ARCH/$SOC , imx7 does it
> > > already, so ... why Kconfig instead ?
> > >=20
> > > $ git grep config.TEXT_BASE
> > > Kconfig:config TEXT_BASE
> > > arch/arm/mach-apple/Kconfig:config TEXT_BASE
> > > arch/arm/mach-aspeed/Kconfig:config TEXT_BASE
> > > arch/arm/mach-imx/mx7/Kconfig:config TEXT_BASE
> > > arch/arm/mach-ipq40xx/Kconfig:config TEXT_BASE
> > > arch/arm/mach-npcm/Kconfig:config TEXT_BASE
> > > arch/arm/mach-owl/Kconfig:config TEXT_BASE
> > > arch/arm/mach-rockchip/Kconfig:config TEXT_BASE
> > > arch/arm/mach-rockchip/rk3308/Kconfig:config TEXT_BASE
> > > arch/arm/mach-rockchip/rk3568/Kconfig:config TEXT_BASE
> > > arch/arm/mach-rockchip/rk3588/Kconfig:config TEXT_BASE
> > > arch/arm/mach-rockchip/rv1126/Kconfig:config TEXT_BASE
> > > arch/arm/mach-socfpga/Kconfig:config TEXT_BASE
> > > arch/arm/mach-stm32mp/Kconfig.13x:config TEXT_BASE
> > > arch/arm/mach-stm32mp/Kconfig.15x:config TEXT_BASE
> > > arch/arm/mach-stm32mp/Kconfig.25x:config TEXT_BASE
> >=20
> > There are many bad examples. In general (and excluding shoving stuff
> > under board/.../Kconfig) I prefer those values to be in the top-level
> > Kconfig that asks them rather than per-arch so that it's (a) hopefully
> > clear that yes, SoCs can and should add a default when it's known and
> > (b) because perhaps this will lead to someone thinking on the problem of
> > how ugly it can be and what may be a better solution. Kconfig is
> > certainly better than CML1 was/is, and better than our ad-hoc just
> > define stuff in board.h files, but it's not perfect. OTOH, if someone
> > wants to break down the options we've put (I've told people to put) in
> > the top-level Kconfig and instead demonstrate and document a reasonable
> > places to put them, OK.
> >=20
> > And if you really want to say that this should just match mx7 for today
> > and move on for now, alright.
> I am happy to do it either way, but we should figure out the best practice
> ... which I was under the impression was to put architecture (or soc)
> specific default values into arch/ , while the Kconfig symbol itself shou=
ld
> be in matching Kconfig somewhere else in the tree. Did this change recent=
ly
> ?

As I was trying to say, I think the best practice is in the common
Kconfig file and I've been saying that for years. But I also don't catch
when people do something else, and that frankly makes it clear that
while I think it's best, it's not obviously correct.

--=20
Tom

--ocANZ9sV/QPG7XGe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcVZQ8ACgkQFHw5/5Y0
tywNRQv7BkyWvEBki/RN1H8Ge9m/sIC467zDASqYC59fu60MZWVd6OUre61Kth+A
S8+D7cq4v28EsmqbHXwjzV8YvQCrOfp5vUZW6y8vLTzn4YGiums2A11MuQaM9VSa
p+e3wYAKQApofMeNKrpCQHKe/1DkRZzkFu4Hseo3WPW4Th2W7NucnPd6pkMDVO52
9r4d+69gFbrN+lbYavgC4plYQFLibweiBUhXim17cH8vFjSQHO/Vcm0qlUNwNo8i
bLaLxWA7ZsZHmJuSqa7rn6Nbum4L5I4DwJi0lQkZmRBACCyxTxSfjPbPes30NjrN
21Ucg5bQBVu8JHN2KR9xS9d4MqJY9wUlvKqMyoihwD8gYU5asQ/f0zMgnW3WBCVd
sfkUQzC8y4rJc1v9/5pzQAerL5tywn89rHv3iJ8EkXWM/7+AHKHb6o8EL7V+8gI6
FPpGcHWYenl7F6JAnUY6/hqfrRnOR7sLy0kmBULFtyZ2vILPmq340nMnm9Z3u7TE
GhYRvHxB
=FCHP
-----END PGP SIGNATURE-----

--ocANZ9sV/QPG7XGe--
