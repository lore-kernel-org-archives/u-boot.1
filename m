Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEB1C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 15:01:33 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4BC1983238;
	Wed, 28 May 2025 17:01:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="At6IbXJ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B891F83346; Wed, 28 May 2025 17:01:31 +0200 (CEST)
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com
 [IPv6:2001:4860:4864:20::33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7011E82A8D
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 17:01:29 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-2c769da02b0so2524144fac.3
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 08:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748444488; x=1749049288; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4lj65LxxP8E9U4TdRjv2heKEFDH4aJnUjmZZX98g/nk=;
 b=At6IbXJ+x6pjShlha9Y/1PInKq+EJiFRLYlPMlsOfAlc4RBAz2uL9GS9ouieNVLW+J
 MTW3zbG+1XHvnqVdjxvxWgorNCvaA+VV8vnqZ3gsOI/2DYe8+FIUpoNyKnbt1b+fAi5n
 VK2PdKafwtGHUl1EgT4yyXpbn9NaqXdtsCj0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748444488; x=1749049288;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4lj65LxxP8E9U4TdRjv2heKEFDH4aJnUjmZZX98g/nk=;
 b=qnOwxAH0b5bV1GyliiccmQawQWVEclucIpeSAe7qBZjWQeWJWYEu2NTZBGVNDLV1LZ
 ObjFeQMg4pPfwB9N9+5cjhvv4OT8brLJyOyhx+5oNdONTTK1TcZjlSI3n3ZFBGp0HgN7
 678PJB4BolbR5WVqGKdXFUcB290l8H9FXsUtS+pKCofNd8HHmK1P+AThu+5lIXPcLU/o
 4OEdSS5L4Yxn3QLWPHwJtax0qfHmdkJ78PsFZ9ksAgNuxgAmlhS09g5iITgsY6bLsz8n
 xOYg9XchbobK0ijy5INAyJyvCgyhL3dDeAp8tCiGdVzyuWHRXSIpJlVtWi1OC1yYtUvd
 BZ+g==
X-Gm-Message-State: AOJu0YzmkqEulZRtOSWyG8AgblIWqQecWJuFPLrLXLgGqcIYzWM7UJwD
 UTNWt+MVQYiXASkFLcDrpt+zm7WLhXkcXRsaxkLGmrgWvwwao2FKLIn1gQ/r/Q3yOj4=
X-Gm-Gg: ASbGncvFBhnxI1D4phET/lUXQLZqznAe/s+2bc2lYCppdrJEzPWZh6UYypL5UPAOs6n
 vypZ7FfwH0yjKdh7NaB9SPejw4djxXG4fYLdiwXhW3zfrXAsRU7aFSxlySCJWb3Uz6vT/6yqPaE
 Y7p36dmURaskB1mgB58psu/T+/eINI9SLOEExr9jySCUSBTFqCoGNnIgYvxbSDCEMOQxGKC/Erj
 9RjZPhIOaDwe7hHXQyPOzUz0o8gWV6tfVykHj3pR9b/zMDUIB3mACk4b3YSjMEGohrHpzr44cLF
 88H+0ft/860upXC9uM8M5YRjLMa0DtI8UFHa0ARB/eydBRPG4rm++dC18BJvcZJTnkNh41d7Hdp
 rDxxeW3NnkkQF
X-Google-Smtp-Source: AGHT+IER/o8vUkiVNejd06JeH50BoeLbekeUrb7n8ffANHGjStMMpu+ALda9dla4vVYjKWU/AOjiRA==
X-Received: by 2002:a05:6870:e98f:b0:29e:32e7:5f17 with SMTP id
 586e51a60fabf-2e862080332mr9647483fac.28.1748444487212; 
 Wed, 28 May 2025 08:01:27 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2e8e175b12asm259298fac.21.2025.05.28.08.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:01:26 -0700 (PDT)
Date: Wed, 28 May 2025 09:01:23 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Bin Meng <bmeng.cn@gmail.com>, Caleb Connolly <caleb.connolly@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Jonas Karlman <jonas@kwiboo.se>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>,
 This contributor prefers not to receive mails <noreply@example.com>
Subject: Re: [PATCH 00/27] x86: efi: Various app improvements to support
 bootstd
Message-ID: <20250528150123.GY100073@bill-the-cat>
References: <20250528082520.152391-1-sjg@chromium.org>
 <20250528140929.GR100073@bill-the-cat>
 <CAFLszTiVtyAsdqLNaGrs11TuugAhTp0Rru30=yNJoAa2RyU6YA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="JC0XYIfWsrTtNqOG"
Content-Disposition: inline
In-Reply-To: <CAFLszTiVtyAsdqLNaGrs11TuugAhTp0Rru30=yNJoAa2RyU6YA@mail.gmail.com>
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


--JC0XYIfWsrTtNqOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 03:25:32PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 28 May 2025 at 15:09, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, May 28, 2025 at 02:24:26AM -0600, Simon Glass wrote:
> >
> > > This series makes a number of improvements to the EFI app. Mostly it
> > > applies to x86 but the ARM version will share some improvements.
> > >
> > > The main updates are:
> > > - Improve linker scripts and options to detect missing symbols and
> > >   remove unused code
> > > - Enable bootstd and provide a default which can find an extlinux OS =
on
> > >   EFI media
> > > - Make the 32/64-bit apps more similar in terms of features and link
> > >   script
> >
> > So I give a little, and say Yes to you despite technical misgivings, and
> > you post yet another big series that's based on your tree with already
> > rejected changes in it. I do not feel that you are working in good
> > faith. Please stop, and work in good faith.
>=20
> What specifically would you like me to do for the EFI app?

Well, the three patches you posted and Heinrich accepted were a start.
You need to build on that, in mainline. As again, the concept was fine,
the introduction of more technical debt to deal with later was not.

--=20
Tom

--JC0XYIfWsrTtNqOG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3JUAACgkQFHw5/5Y0
tyxx3wv/VhU/EFC7jVgd0TzJ3uVVghIfYDgPyNPcB3anoWxYFvvrRx7xuXK75ElT
olrgV6yBxfcXsPNgCNlF1ZX+BAe9wFNewYiPIkjoRMfsGw2z5DLbwNMHqMCRtU60
GHscPp/8YL53aSmUx4e6kJaFONiwlh7uEB+WdiuOIrzHWy246qVWnQBrPtmjFf6j
VTwQz6S2kZ00tpjRxmRfLBhRKxMzwKnssTa0zK981bG0I8UTHAcW4IraeeTqt6+4
RIlD1y18Vq9wvfHblRY9Qw99uYEvisPHtAYFSJV6zcadyFMYxt5YUEP5LWJt14Rz
Hn5xUShqDzfUmmmjz/RnSUgvf7gxGuno4sL+FR+EAeCP490Qpda00lXyWwq74Vev
E22zs6tPgUA1WtLap4BWu2BzMnYrzjt9+/R8lTC2A/C4/agf60g8v2QEErVSneLE
nk1Vjf20Ht0+cF9d/sX7X+WxNKCZYSDk9k/vv5ARX/SuNieEbx/3FbmTUH5A6SFx
bjxvwUte
=Czes
-----END PGP SIGNATURE-----

--JC0XYIfWsrTtNqOG--
