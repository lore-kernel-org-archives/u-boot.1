Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75501C83F26
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 14:22:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DAC0B82BA1;
	Tue, 29 Jul 2025 16:22:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="NNEvprVR";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B851C829E7; Tue, 29 Jul 2025 16:22:18 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 404F282BA7
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 16:22:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73e7804cf31so1172374a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 07:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753798935; x=1754403735; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=QjzROkzALKLh4KN8A2S2hAOw+u5y2UQ7l8q38PmOMGU=;
 b=NNEvprVRqO/5jXz97FUXurrl8TYiet+KR8+3r4CeQOJHC2s9YZ3WXxbAYBxv6xIx18
 a3XaXvq4PtHcRdJEMUHwRjn83e1d5FH5OAqc8KbpZjtShw4Fgj9dLROgV/d4hIlJ+jhV
 IcFOu3l2pennf3g5WnaP65rNYcjAOT1DOWQ1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753798935; x=1754403735;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QjzROkzALKLh4KN8A2S2hAOw+u5y2UQ7l8q38PmOMGU=;
 b=ty/OoTsxl+YlAYvYO6QUBoP74fvawctsjcWjdHPfLX1FnXYqH6BDc9ykRhvr8K92jN
 EjLmI39Pp5BMBInfT6YZqo4av+fpYmCcZyg1PP23bf+SIuRiE6BBaT0j0JnSFBxQyydY
 gguttnxs1bxqP9Lyf2tTaq6e0y592nASJr/DDNzOQSERLZeje5xL/ZkmSUbarV0RRXxg
 5XV1pRyYrLyfC92OwY3uQuF4cTGRoLHboZTu3xzsGTcuZ3wCyDqO/UE0vg8ga2gJLS4q
 OV+rlcprawZDLlK1ILrwGgXQu3BdFL5zCUDbN13SV2NnPxAmnl5NLrgeG1hZjUWmLoeZ
 uxLw==
X-Gm-Message-State: AOJu0YzMobXpSn6N9JNHv0lYKsgitF+QrTE72ttQpKvcY/NLZf/+210H
 PPfof1cnr8o3/DtJo6cvHmXUOLvopp82Y0p9s98MmZljDWAHl0Zp2WfKYQSPIn5rWJA=
X-Gm-Gg: ASbGncvZNFt5P5DWkGebjZzRit9UJrGRIsZzcsQC0CbS2fIbpd4nl2Mk3PshHi0lIn1
 VejdJiNKeKGHYDHX6Dry7gP501mJdRhan7Zq/Lbe02aBwaw+HLRXmMKjQTwMAdR7peYmweCwC9m
 +tfJKjM1PdsEYy1lyZyvsTyJX+KtxP69JCV9heo95yxVu1n8WTXjxPpU+aawDGDxE847fVtQdxZ
 +35qq71ATZpiKxk54BOT4OpL9Waf03jQEUeiNL7n/g6oBlctL3Y5dWBM3kboAtjptev5tlNBmJd
 HIqbhgIZIJF4zsIRZ1+51vGADjQKhKU86BPVbEe/fQ4v2OGm+hqJSPFTG3uAL+hLWfydLZa5dPw
 mGQuKmbIiNpxzffD+dLZ/oZy7d5ZkmKEwaqrAvry81cjED4jBa7otqawD7HZO8VpC8eQ=
X-Google-Smtp-Source: AGHT+IGRktS0FLFqNqf7nzBLH2LDhK0rrH0PwzViVKNyj1VtKiigNIsU8cpr/icQXFFXuXCiJS+dKw==
X-Received: by 2002:a05:6830:6485:b0:735:af51:5ea5 with SMTP id
 46e09a7af769-7413df0e3bcmr9824128a34.22.1753798934903; 
 Tue, 29 Jul 2025 07:22:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-74147f4afacsm1543421a34.10.2025.07.29.07.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 07:22:14 -0700 (PDT)
Date: Tue, 29 Jul 2025 08:22:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Philip Oberfichtner <pro@denx.de>
Cc: u-boot@lists.denx.de, Anshul Dalal <anshuld@ti.com>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Greg Malysa <malysagreg@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Nathan Barrett-Morrison <nathan.morrison@timesys.com>,
 Paul Kocialkowski <contact@paulk.fr>, Peng Fan <peng.fan@nxp.com>,
 Peter Robinson <pbrobinson@gmail.com>, Simon Glass <sjg@chromium.org>
Subject: Re: [PATCH v4 1/3] Makefile: Add size check for u-boot-with-spl.bin
Message-ID: <20250729142211.GK1807455@bill-the-cat>
References: <20250708103959.26129-1-pro@denx.de>
 <20250708103959.26129-2-pro@denx.de>
 <20250728222531.GA1754718@bill-the-cat> <aIi-Rb3C_1i_IQDr@antares>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="/QnDFzv27MOrMTtg"
Content-Disposition: inline
In-Reply-To: <aIi-Rb3C_1i_IQDr@antares>
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


--/QnDFzv27MOrMTtg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 02:27:49PM +0200, Philip Oberfichtner wrote:
> Hi Tom,
>=20
> On Mon, Jul 28, 2025 at 04:25:31PM -0600, Tom Rini wrote:
> > On Tue, Jul 08, 2025 at 12:39:57PM +0200, Philip Oberfichtner wrote:
> >=20
> > > Like other images, u-boot-with-spl.bin may be subject to size
> > > restrictions. Extend CONFIG_SPL_SIZE_LIMIT to handle this case.
> > >=20
> > > Signed-off-by: Philip Oberfichtner <pro@denx.de>
> > > ---
> > >=20
> > > Notes:
> > >     Changes in v4: none
> > >    =20
> > >     Changes in v3:
> > >     	Reuse existing SPL_SIZE_LIMIT instead of implementing a new opti=
on
> > >    =20
> > >     Changes in v2: none
> > >=20
> > >  Makefile           | 1 +
> > >  common/spl/Kconfig | 2 +-
> > >  2 files changed, 2 insertions(+), 1 deletion(-)
> >=20
> > This is not quite right enough, sorry. This causes a number of boards
> > (evb-ast2600 ibm-sbp1 stm32746g-eval_spl stm32f746-disco_spl
> > stm32f769-disco_spl) which have size checks and are fine to now fail
> > their size checks, presumably because they're checking the "wrong" file
> > now or similar.
>=20
> Thanks for pointing that out. To sum it up: If those boards use
> SPL_SIZE_LIMIT to restrict the size of an SPL-only image, then
> u-boot-with-spl.bin, of course, can be too large and the build fails.
>=20
> Plus in our previous discussion, we figured out why using
> BOARD_SIZE_LIMIT also isn't suitable:
> https://lore.kernel.org/u-boot/aD2EflR9DRYG-MY5@antares/
>=20
> So from here I really don't see any better way than introducing yet
> another CONFIG_*SIZE_LIMIT option.
>=20
>=20
> But maybe we can however simplify and deduplicate some of the code. What
> do you think about something like that (I have not yet tested it, just
> a rough idea so far):

That sounds like a good idea, so long as it works :) Thanks!

--=20
Tom

--/QnDFzv27MOrMTtg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaIjZDwAKCRAr4qD1Cr/k
CrAhAQD5Opme4yagTj8jrMGhz43ALCG3Ibg7311kjRuVayA9TwEAjFWP/+XXcYtX
R8NXQujWpwow/9NMPfvD0dcI9AcEuwc=
=mDl6
-----END PGP SIGNATURE-----

--/QnDFzv27MOrMTtg--
