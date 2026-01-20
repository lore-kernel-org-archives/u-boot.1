Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A732D2ECE9
	for <u-boot@archiver.kernel.org>; Tue, 20 Jan 2026 14:27:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 961A083A8D;
	Tue, 20 Jan 2026 15:27:09 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="G56LGxEB";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 297F483A8F; Tue, 20 Jan 2026 15:27:08 +0100 (CET)
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com
 [IPv6:2607:f8b0:4864:20::22d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6F770839E2
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 15:27:05 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22d.google.com with SMTP id
 5614622812f47-45c889aba0dso3046525b6e.0
 for <u-boot@lists.denx.de>; Tue, 20 Jan 2026 06:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1768919224; x=1769524024; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=67CdeOvTBPiGsQJvZsp3CX9Ty+n+GMJqAk3T6NZeIRM=;
 b=G56LGxEBrHyCfYzOyznWnYA2Z/vc34thfljLZFiaNlCn8U10yIWJWCxoOTPl+f0HPA
 VW3o7SkV+EC+v1uYEQ4zSrZ3utSfJBjRh+I+hABLXzXp8ykI/hlWUFZEVgXVVmrf6WSC
 Oz77cHT4f/xUvAYAwoWVQDb8LRwuz/OdDlAOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768919224; x=1769524024;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=67CdeOvTBPiGsQJvZsp3CX9Ty+n+GMJqAk3T6NZeIRM=;
 b=s6ffQARdAWxgs+o0p9RTsEikOdUQtn5ztbFXsUctU+sOifym/M+JFBco8aOkXc2a/Z
 wX5WAttBOYtkpg41gYZJIUJFdZ1lPrvaTFPxLaI4iuL78o/ckg7BEONKrEEoMYjmKTTB
 voUWleIGvYYuMcqNSeTyIPTPmLBs7cjILmQIs4fJjIDwqv0IaXnmucVF737qui5SUYTp
 V/WUImaoYd0Vu7QlOE2a8UYppgfLptcZyYdVoB/YHU1bX6mfPD6ZqqqOIhOs0oMfWBxQ
 H7uPTK808A1B+DfnV7YbIR6uMNqDCpHOTe/35vjs3MDD/pGWMJLUDdjXHIQmlQhBG/w5
 /JGQ==
X-Gm-Message-State: AOJu0YycWRtMUJEoe4QZMJjNcSl6FMc7AB+U29+l5fXAHfcn5gdxRVjP
 PCG6bfFZSQBv+mrh8HoULUge/U2hmOQmwdSCn7d6EwFa67Mto82PZokvo2QsnuWtXpI=
X-Gm-Gg: AY/fxX7wY03oiM/Zwdb0QnjwIxwf216dby6NpkmBw7dWiMhGHCvyTX+sncePOZopvHo
 Sccyi6+PcUXYMkh1g7H3PH4g4wawhh81TMXIG4y0U8QoLb1keVp0xIObU1pQT6d9pinzKG7qcCK
 I9hUC4sQxPZZGsLa8phQGxnCIYmNKKxDpHgferHg2BwbIAs1dCmjBV3J6HOX+StLwg9+KWdimsH
 7/1kCYweD/4gz3/73rWCGMTlqaHtiAenlHGOba8G40U9S3h1HG8zhMleThXjHLzqTFBB82c8y93
 nMkwrVFkWDWSzEvt+Myo1Oh1CKF/wQGvluwdnjOSyJ2ZgQP9RGB6RF2WGmB5CqEAPlwGt9oXfuX
 KxFd0acTl5nXOPdDsTybWazrcBqa4eHfOmT0vA4GUFfnRQZLj2yqVp4R1rF3UQpe8tkW2ncRfwD
 0Wjqrg0R0PGoToF2yCU1BoP3f6ONRvg6ONvpz+LyWemA8zFLMHL0LKVIFaW9osxcT92jPDRM4cy
 FSBTxHKT6Kt6zf8uTAkHe5WQxLN83+1azH/WOE=
X-Received: by 2002:a05:6808:6905:b0:45c:7885:d560 with SMTP id
 5614622812f47-45c880fef42mr9868455b6e.16.1768919224063; 
 Tue, 20 Jan 2026 06:27:04 -0800 (PST)
Received: from bill-the-cat (fixed-189-203-103-235.totalplay.net.
 [189.203.103.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7cfdf2a5f02sm8610880a34.25.2026.01.20.06.27.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Jan 2026 06:27:03 -0800 (PST)
Date: Tue, 20 Jan 2026 08:27:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Beleswar Padhi <b-padhi@ti.com>,
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Adam Ford <aford173@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Aspeed BMC SW team <BMC-SW@aspeedtech.com>,
 Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
 Eugen Hristev <eugen.hristev@linaro.org>,
 Fabio Estevam <festevam@gmail.com>,
 Jagan Teki <jagan@amarulasolutions.com>, Joel Stanley <joel@jms.id.au>,
 Kever Yang <kever.yang@rock-chips.com>,
 Michal Simek <michal.simek@amd.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ryan Chen <ryan_chen@aspeedtech.com>, Stefano Babic <sbabic@nabladev.com>
Subject: Re: [PATCH 02/10] arm: Update linker scripts to ensure appended
 device tree is aligned
Message-ID: <20260120142700.GG3416603@bill-the-cat>
References: <20260115222828.3931345-1-trini@konsulko.com>
 <20260115222828.3931345-3-trini@konsulko.com>
 <CAC_iWjLUX38Z0ucpN37EsKE8T8w+Qw5hpteFRm=5uaf+Yfnv7g@mail.gmail.com>
 <20260116144024.GJ3416603@bill-the-cat>
 <CAC_iWj+Uhq-GFDVG78=GL+xtFTSy3cMbmer1fb+gfxv4U0YZ=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="amHjJ8Ij2yKhvQ2p"
Content-Disposition: inline
In-Reply-To: <CAC_iWj+Uhq-GFDVG78=GL+xtFTSy3cMbmer1fb+gfxv4U0YZ=Q@mail.gmail.com>
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


--amHjJ8Ij2yKhvQ2p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 10:38:19AM +0200, Ilias Apalodimas wrote:
> Hi Tom
>=20
> On Fri, 16 Jan 2026 at 16:40, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Fri, Jan 16, 2026 at 11:59:49AM +0200, Ilias Apalodimas wrote:
> >
> > > Hi Tom,
> > >
> > > arch/arm/cpu/armv8/u-boot.lds and arch/arm/mach-omap2/u-boot-spl.lds
> > > can use the same alignment. Is the omap2 case covered by the TI
> > > patches? I think it's better if you bundle this up in this series
> >
> > Correct, the TI patches fix omap2 (and a number of other platforms, that
> > linker script should be renamed, it's the sram+sdram SPL case)
> > platforms. I mentioned needing it in the cover letter btw :)
>=20
> Ah, I wasn't in the cc list for the cover letter and missed it. I am
> ok with the TI patches going on a different patchset. Can you amend
> the arm64 .lds file?

Yes, I can amend the arm64 .lds file as well for consistency.

--=20
Tom

--amHjJ8Ij2yKhvQ2p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaW+QsQAKCRAr4qD1Cr/k
CrC7AQCTHyg6BxGTktDUAOiGeew82QqDFmr/gb5q4UapX/WztgD9Gd1dxW8XtFpi
I1q1QUIryoXEAWBNcTVQi5BS4tWk1Qg=
=ZBgP
-----END PGP SIGNATURE-----

--amHjJ8Ij2yKhvQ2p--
