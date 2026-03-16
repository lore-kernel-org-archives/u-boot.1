Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA63DF53D78
	for <u-boot@archiver.kernel.org>; Mon, 16 Mar 2026 17:10:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E89C584109;
	Mon, 16 Mar 2026 18:10:32 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ObZbGG3F";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E67884118; Mon, 16 Mar 2026 18:10:32 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20::22c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 37F2184105
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 18:10:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-4671cbce32bso1017022b6e.3
 for <u-boot@lists.denx.de>; Mon, 16 Mar 2026 10:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773681029; x=1774285829; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=J9rwSk4TH1OEUzswA9nX8Z+GpNOuN82rAEeB80bNoFE=;
 b=ObZbGG3FkAKEUUhzmGywQlv/xUK4/d2zQ4l61cUuY6C/a0BfTtAkczugS6yvNDxePN
 I6aJkdeHEr1zRv9tBZXHZk6nyPjR48P1Rs/2vAJDPG4WYI16yT/M/vfFvPKebEZF2/An
 Fh5zEYJQPgA26naQ+tGstOT+7sMA0eIOK0dx4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773681029; x=1774285829;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9rwSk4TH1OEUzswA9nX8Z+GpNOuN82rAEeB80bNoFE=;
 b=mJyU637buvGCjmaY2lLs0wVDbd2KqbsJBikl7gtOV+UaQ33cqkDSWcuh4cxBVNezy2
 ZZ6S3V3m+9MIlbeqOwkNxM9MR3irnkhmhJ7JjOTwARBXHqLhIVLR4jqg4ZVvpjFHeP7g
 xR20PNTNVySFDpgG1OxRN/Xyx1Y6GA148+thRF3HovnYMDLGb8NNZjvtd7rBEfuj3XSb
 5Y8/K/JOcziVzaEr2XlM96eJSvtL0JSNDVnwqz1iwCKrc6d8c4/m5cQDuKaHWeuPXXKr
 nXPosQTpvrMaSaexcx0+lQXivxzj8f/e9K9TLEtOmJ6ZJHQaO4+QDiF+ZVlI0xLilIT7
 gISQ==
X-Gm-Message-State: AOJu0YyRszZ5wZWaM4ZRl6ZhWbXiDUBDL+ZXvlGoO01AQUthZzI3ms2D
 hyNyQcCvXb1FVHDXhx4VMp3g6d3qoElceub/Rp6iWelWId9V6Ejm591uV+GVv1AA0h0=
X-Gm-Gg: ATEYQzy06mXuVPde/VaeDxTkQwxK8X8FNeronvbw8PgwDZxNqyjXQs9rB8SgxqUzPEE
 5Mo8WobA8ACapcFaCSl+Lka0Bl73xuqOiacM9P0nUXPRI6ZeWAdMUxX4icWzBG517YrWL0rMS36
 /zPBdtYct8Hw4/ODw7JC6a46WhrLpyc4sZptsOj04QptDsz/M5ISvFYF6o5AC/Cjjo/EiMsGvuW
 KpGQCOEiD0xINOzGaBRcE9XlesUae56C9/bLR2MITv445lGNhXPrPCNKs5yxGPZPPzegCrktDFB
 KWgGIigOJGYcgEO+b9P1J5QDJrV/JT1q6KCyQUhUuMn6MQ9b1CyMpWpAgTxtDs/g7Bw2ojF7Rvh
 PlRb06mcSFmqfMGsDeeYrRCnia1EqEodIpIhPITxky0nOlpuFdTMMgeoRT/Pb7pF0cjFhh9rUmy
 UwDgsN98Paah0Mw1g1XZmNRH1+9G+o8MhVhi6pfdYBuxCcjjP8uWz2p5KzX3w80ssMfY3ftEZJT
 dx6mjjxgsYb7zsi+OcPtzKDJIxUccJxuh7Svl0SgfBDGask
X-Received: by 2002:a05:6808:1304:b0:467:819:dc61 with SMTP id
 5614622812f47-467570aea3cmr7317991b6e.23.1773681028802; 
 Mon, 16 Mar 2026 10:10:28 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-46743aca62fsm8374258b6e.2.2026.03.16.10.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 10:10:28 -0700 (PDT)
Date: Mon, 16 Mar 2026 11:10:26 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: u-boot@lists.denx.de, Casey Connolly <casey.connolly@linaro.org>,
 Heiko Schocher <hs@nabladev.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jerome Forissier <jerome.forissier@arm.com>,
 Jesse Taube <mr.bossman075@gmail.com>, Peng Fan <peng.fan@nxp.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Simon Glass <sjg@chromium.org>, Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] arm: relocate: Introduce data-only relocation mode
Message-ID: <20260316171026.GN502704@bill-the-cat>
References: <20260315235510.304677-1-marek.vasut+renesas@mailbox.org>
 <20260316145027.GK502704@bill-the-cat>
 <b1f8bc9f-13fe-4931-a6b3-ae494632dd77@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="kPgqOa+KkOnZwugu"
Content-Disposition: inline
In-Reply-To: <b1f8bc9f-13fe-4931-a6b3-ae494632dd77@mailbox.org>
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


--kPgqOa+KkOnZwugu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 05:53:44PM +0100, Marek Vasut wrote:
> On 3/16/26 3:50 PM, Tom Rini wrote:
>=20
> Hello Tom,
>=20
> > > +config SKIP_RELOCATE_CODE
> > > +	bool "Skips relocation of U-Boot code to end of RAM"
> > > +	help
> > > +	  Skips relocation of U-Boot code to the end of RAM, but still does
> > > +	  relocate data to the end of RAM. This is mainly meant to relocate
> > > +	  data to read-write portion of the RAM, while the code remains in
> > > +	  read-only portion of the RAM from which it is allowed to execute.
> > > +	  This split configuration is present on various secure cores.
> >=20
> > Is this really configurable, or is this determined by the SoC? This
> > feels like something a board should be select'ing rather than
> > configuring and I do worry about boards abusing this in the same of some
> > possibly dubious speed-up rather than the intented and valid use case.
>=20
> On R-Car X5H, the Cortex-M core U-Boot port selects this, the Cortex-A co=
re
> U-Boot port does NOT select this. So, this is neither SoC level
> configuration nor board level configuration, this is SoC CPU core level
> configuration. I can definitely hide this symbol and conditionally select=
 it
> on SoC level.

At the high level, this sounds similar to the TI K3 platforms where we
have a Cortex-R build and a Cortex-A build and so (ARCH_K3 && CPU_V7R)
is valid in Kconfig. I assume there something similar in this situation,
so yes please, thanks.

> > [snip]
> > > diff --git a/arch/arm/lib/relocate.S b/arch/arm/lib/relocate.S
> > > index 6ee58f4edfe..b6a648708f4 100644
> > > --- a/arch/arm/lib/relocate.S
> > > +++ b/arch/arm/lib/relocate.S
> > > @@ -79,6 +79,15 @@ ENDPROC(relocate_vectors)
> > >   ENTRY(relocate_code)
> > >   relocate_base:
> > >   	adr	r3, relocate_base
> > > +
> > > +#ifdef CONFIG_SKIP_RELOCATE_CODE
> > > +	mov r4,	#CONFIG_SKIP_RELOCATE_CODE_DATA_OFFSET
> >=20
> > Spacing. But if there's no other comments and propmting the user is
> > correct, I can fix when applying.
> Fixed in V2 .

Thanks.

--=20
Tom

--kPgqOa+KkOnZwugu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCabg5fwAKCRAr4qD1Cr/k
CqsqAQC4yFjwAluMY3vkDw/4xiwann/MEzd/RKzRnGEKlZ9xzgD9H1Dwg0pB/MpC
H2pm1yR7gcRtG7heHr299qk5ttptKAE=
=Gn9S
-----END PGP SIGNATURE-----

--kPgqOa+KkOnZwugu--
