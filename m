Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E83A4C02185
	for <u-boot@archiver.kernel.org>; Sat, 18 Jan 2025 14:41:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3EE4680716;
	Sat, 18 Jan 2025 15:41:50 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="kMglxh7N";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 785C98073D; Sat, 18 Jan 2025 15:41:43 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 21EFF803CB
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 15:41:41 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6ff72ba5aso289724185a.1
 for <u-boot@lists.denx.de>; Sat, 18 Jan 2025 06:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1737211300; x=1737816100; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=MKtSMXPFLl6o2PZJ5iKgrFu3MVx1P9owvFKIfpxgfs0=;
 b=kMglxh7NSYnRRQMAJ6qFXddheYO/vyuBP5oIfZuHaexmliHKbGimS1nxMTcI4DvMrj
 1uNDJ7Ect/le4vAc1SGZ28Ah6TIWJsUvSbXvlHc4hzcJde2JCY8RX3dMb6Jz0UZoXrJF
 qDU9pQUC4CDLA3MZHJd496P1LEYhyrrVOPmjI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737211300; x=1737816100;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MKtSMXPFLl6o2PZJ5iKgrFu3MVx1P9owvFKIfpxgfs0=;
 b=mNGu4eoM2E15rs0tCWj0GnoccovItRh8YiUvXSq3GH2hWDDs9GdA9nVTUivfrrZQkO
 9dkDJJVbVpl9hqT51VkkrUZdPuG15St+YbFOJDSeCUcrUlL03SMImYB8BuOdRJkYcMES
 RA35Lhi9+VkWLx+5UMCKASi35wAmEL3jQFaTBUwZlEDP4aOV1HxH2z7QlOhq8ZzwPrBP
 0+fNhyLDkXNtqTb6lL4qdcA/mI+6Dpf2gCuVuOaEff0Ul4T23GByS/khKBL4jKc0XxnA
 hUYr/8QSAyBEo7tzRBqjedG6v+12Z0x+Uw5K+GQd8S0HuO0IW0a8B50kE0aqhfq1AzuU
 9Paw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW3jUytGgjv3qJQLKLO41owxQu7NGFL1XCIrKMWoizC2sZRe2k9W1+HaA0xRQAZ9lV6+sEAttw=@lists.denx.de
X-Gm-Message-State: AOJu0YyAxCef3ahP4W8wn0ruvhvbGdNTYpBk4la/cEGHHw0sCs1RVmcD
 fGs7scvuHdrjaMpaPQpCUo/YnT6xa20ufMX1jwQpyanB2sfRROl34eDORJOgBVE=
X-Gm-Gg: ASbGnculHQ/cSk/LZjgqs7Z7Jrp4qLukfG2As8fiP52d51HzOUZcDJiULaES86iSzpC
 Z2V3bksEF6by72pKnltXX3WwkPEdTgPKEMQIZ6Eyr/YDL9P6ISicRwgK+94jCcC64JZuar+67ti
 RNT8bW6J1bvVcCCjHTEmk88Ulal5MHXB6PVlSFyXAflntzkk6/QilErc3Z4FzbgYVhaV/F/2uy9
 ESMxwGx/IIyGc0B3tJEzmM2oQQ0syY+X/c6Vsbsf/hJg3Zw76ilWwgtu9aPhdBxPIU=
X-Google-Smtp-Source: AGHT+IFCGDm63/vV1O5fhaoQHVtzRrvbuWt6bWkrH/KUcP3yADId2gszUpAmkS24z/QVrb8f3kwpyw==
X-Received: by 2002:a05:620a:4513:b0:7b6:eab3:cdd4 with SMTP id
 af79cd13be357-7be63289389mr1130498485a.50.1737211299904; 
 Sat, 18 Jan 2025 06:41:39 -0800 (PST)
Received: from bill-the-cat ([187.144.16.9]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7be614d98cfsm232682385a.67.2025.01.18.06.41.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jan 2025 06:41:38 -0800 (PST)
Date: Sat, 18 Jan 2025 08:41:32 -0600
From: Tom Rini <trini@konsulko.com>
To: Tony Dinh <mibodhi@gmail.com>
Cc: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>,
 AKASHI Takahiro <akashi.tkhro@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>,
 Emil Kronborg <emil.kronborg@protonmail.com>,
 Etienne Carriere <etienne.carriere@foss.st.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ion Agorria <ion@agorria.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Mark Kettenis <kettenis@openbsd.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>,
 Maximilian Brune <maximilian.brune@9elements.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michal Simek <michal.simek@amd.com>,
 Moritz Fischer <moritzf@google.com>, Nam Cao <namcao@linutronix.de>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Sean Anderson <seanga2@gmail.com>, Sean Edmond <seanedmond@microsoft.com>,
 Shantur Rathore <i@shantur.com>, Sughosh Ganu <sughosh.ganu@linaro.org>,
 Svyatoslav Ryhel <clamor95@gmail.com>,
 Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>,
 Tim Harvey <tharvey@gateworks.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>
Subject: Re: [PATCH v3 00/19] bootstd: Support recording images
Message-ID: <20250118144132.GW3476@bill-the-cat>
References: <20241104175110.1048449-1-sjg@chromium.org>
 <CAFLszTgFdNrRev+7n6j+NqCM+em_p-ONAc=+sztoYaP50HUivw@mail.gmail.com>
 <20250115212439.GD3476@bill-the-cat>
 <CAFLszTiSSq-+cSxVgxLJ8atAAjjxRP2AEQmXMbrf+c3FOepnFQ@mail.gmail.com>
 <20250115233157.GE3476@bill-the-cat>
 <CAFLszTga3RD95M2ujLfuXQor39sfcQrEUe3hwRKABiWx04PiZg@mail.gmail.com>
 <20250116172159.GH3476@bill-the-cat>
 <CAFLszTigN+s1T0hjJXnkE4ucYafHCtabPFHh=gCFpro2WrLnpg@mail.gmail.com>
 <CAJaLiFw3j1FTT25mNd_5Pk-UTCaNL=R2GmK0+m_VoCc7Yc2PRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="K4BfJAJreOutqR5z"
Content-Disposition: inline
In-Reply-To: <CAJaLiFw3j1FTT25mNd_5Pk-UTCaNL=R2GmK0+m_VoCc7Yc2PRQ@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Sat, 18 Jan 2025 15:41:48 +0100
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


--K4BfJAJreOutqR5z
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 09:49:43PM -0800, Tony Dinh wrote:
> On Fri, Jan 17, 2025 at 8:32=E2=80=AFPM Simon Glass <sjg@chromium.org> wr=
ote:
> >
> > Hi Tom,
> >
> > On Thu, 16 Jan 2025 at 10:22, Tom Rini <trini@konsulko.com> wrote:
> > >
> > > On Thu, Jan 16, 2025 at 08:52:38AM -0700, Simon Glass wrote:
> > > > Hi Tom,
> > > >
> > > > On Wed, 15 Jan 2025 at 16:32, Tom Rini <trini@konsulko.com> wrote:
> > > [snip]
> > > > > I'm referring to the whole bootmeth/bootflow/etc thing. Is this g=
oing to
> > > > > be put to use by anyone / anywhere on PowerPC? M68K? MIPS? 32bit =
ARM is
> > > > > a harder question there, which is also where this particular over=
flow
> > > > > was.
> > > >
> > > > I'm still not sure what you are saying. Are you wanting to disable
> > > > bootstd by default / go back to distro scripts / force everyone to =
use
> > > > EFI_LOADER / ?
> > >
> > > Yes, I'm asking where it's appropriate to enable this new functionali=
ty
> > > by default.  It certainly should be enabled on arm64 (there's new
> > > designs) and riscv (there's new designs). It still ought to be enabled
> > > on arm32 because we otherwise lack a easy way to say "new" arm32 (say
> > > i.MX7) and not "old" arm32 (say i.MX23). What is the point of enabling
> > > this on PowerPC for example? The active users there are (generally)
> > > supporting legacy hardware and I have no idea how much they want to
> > > change their boot process, once bootstd supports flash for example.
> > > There's similar questions for everything else under arch/ as well.
> >
> > To me this is in fact two different questions.
> >
> > 1. For PowerPC, m68k, MIPS, I suppose we can just disable BOOTSTD and w=
ait for them to go away, if you are saying that they are behind on migratio=
ns will never catch up

On what migrations? A board that has a boot command is not some legacy
non-migrated case. That's a valid regular use case.

But yes, I'm suggesting we should put some default y if ... logic around
BOOTSTD.

> > 2. As to the default, I believe BOOTSTD should be on by default, if we =
intend to remove the distro scripts and support things that are not EFI


In case you missed it, EFI_LOADER is default for some ARM32, ARM64, X86,
RISC-V and sandbox. None of those are cases where I'm suggesting BOOTSTD
shouldn't be default.

> I'd agree with Simon on 2. Boards that have never been upgraded to
> distro boot or standard boot usually have an internal envs script in
> include/configs/xxx.h that boots the board the legacy way. Even if
> bootstd is enabled by default, it won't hurt those.

It hurts them because of the strong likelyhood that they do have
practical image size limitations (before they would then be leaking in
to U-Boot environment or some other part of flash).

--=20
Tom

--K4BfJAJreOutqR5z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmeLvZgACgkQFHw5/5Y0
tywLOQv/SkCUoF0iwysTXq29vuK5D+lD69clQgt6fTMlFnKC8AQtsrRQ3zofvs82
6XlAPq8AXD72DTpWu1rssqluPQQH5wf+fjF3zB8NwajZ11Zz610zfA1ADAJ808mB
IbiVHvRNVfGCCckCqrFZg3ZFmIF8PH9Ygh/+i4vQwA4BJDQ+xF3UeZxjtYlXGMFe
JMyFz/G8j8xe+Vv2J/YTvOQ38nuPqk+vus9DRoe72MxhGGam35Xco/q6eJFtJwip
HtXZIjdqwyTI+zHDi5+rMS6lVof5HinOn9V4rg8VwwETxNOBwPFGGsCmDziMAHGk
baLO8NXkgbSVWWnbydj2cgA5aST/mhiBXtPNdH+iH+ziMzCBWjhofBoRF2pzFg2r
gPBrBz2wGf0T4K/fcSC3B7kC2iJM5Np3CnTMWnZw7d+uk2MCX1QLSX0jV7RvAB+X
kayZuZTkXe6PHNKalDBBrqA2356c+bl2T4jEeyKjlFe5Wp3sE2xpeQ7Md8vi9Io0
/F2PV8re
=X9Rh
-----END PGP SIGNATURE-----

--K4BfJAJreOutqR5z--
