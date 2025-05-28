Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 426E1C5AD49
	for <u-boot@archiver.kernel.org>; Wed, 28 May 2025 16:54:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C404A83A99;
	Wed, 28 May 2025 18:54:01 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="rkzf8iPx";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id BA6E883346; Wed, 28 May 2025 16:43:57 +0200 (CEST)
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 76864832F0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 16:43:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-401f6513cb2so549999b6e.0
 for <u-boot@lists.denx.de>; Wed, 28 May 2025 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748443434; x=1749048234; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=PTYX24Pk78G/zhnGABKtYbavExKp5H47QgOkjI8oFYo=;
 b=rkzf8iPxic/4XmgLdtLpTz4QCea10WWD4ceSaHe4YaqivWbiQriD0lh5qsziSAXvUX
 eiVKlP/T3SEx3MGfRoVJPG8m2323gR/xD6/mQZC/YQO/7+CyF2Vo1e07vLWh0tZfL3Bd
 Vb7TjxwJgpOdv3OBgZgqoLJia/5Qhi5anMsnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748443434; x=1749048234;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PTYX24Pk78G/zhnGABKtYbavExKp5H47QgOkjI8oFYo=;
 b=KsmHp/eLVhvVgbPRnd8VaIU40np9Yf66lqigT8xJ62aqJh0QTR3Ejjj6YYeODUrvJf
 dvXo+TDadPKwb9GaZN5JlMyRMUK3hVdE1p5+qfksKn+RrOsw6jmqXVIXYucUECJ2hh86
 wkJn07J0TJQF0MZnfh6mdCfLUIOLEBpy02qGyu5K7w5fUj8vkSPRIhAK8eON8Pn/yuc/
 wS+TQciC7tAF/Z8UuE4f1/xvbLuT14sdyzsCkygbrsNGl3ecaNgobMPngRELOQ85xtaK
 mIUifZTCvBnnuwY0EloDQ3UELLDQeHpOtSPRl6UnyLR85+qItBFFanZdGBasKYynTXB0
 rUcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwj0hU4bjS0XFxd/eRXPVpOOugTrBym5R9pYXQEoY/I0Su2TPEHZwzQQ/dR9fACVJZpaY+n9s=@lists.denx.de
X-Gm-Message-State: AOJu0YwC5PbT3myZl9hlVpoCHtMo8fZZZjQRYdzoS+Xr/Kdl1ULthcWl
 H0dbEP9HO6t35gojc9hLGm4kBPaRLG9md69bN/i1TMs+HLq0igS8vNBdcLsSDYf5DjrZfHNtmCQ
 hnEXO64w=
X-Gm-Gg: ASbGncuP3hLqG/TfO5XQHeWn8x2GmdFUieiRl1quktLCmQxVvhrnJblrAPXJFNbGrED
 2+29Spp4bd0IhJmJwfFBGBeQtyQOPqYhoGTVuZ7NcGMpQCaaNxbNnfVIA1afazNaYNRKWQfjIQW
 +DbtCtAXroAi+0P0zXMFrd/oWoMFWwrioHhJ5nrcOKzESGS/KU3dJ8J94/M2gBXp1FFT/gs09RG
 2VoGMkNKOEB08AsMY19aClqdF1UZuIt91vAUH1l9E3//AdBKq599lXfLI/+RukSgIIiz0eJAeWW
 GmaFkedFTHXU9NdixVgS5xHx/tlc0c4OFd9Ai9gW5mNlVkbksVXwo8cM/b/iA7utoAQ99LJw6bt
 Vm7ux7tcnijv5
X-Google-Smtp-Source: AGHT+IG2AKSar6LcKT3nUvjKFntwXaV8HO0OQ7qHDvQK0daEz2ok4nZVxbw19RpUkByKPIuqpUrIWA==
X-Received: by 2002:a05:6808:4447:b0:403:304:6b06 with SMTP id
 5614622812f47-406603d464fmr3319899b6e.10.1748443434107; 
 Wed, 28 May 2025 07:43:54 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-40665473d23sm195792b6e.40.2025.05.28.07.43.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 07:43:53 -0700 (PDT)
Date: Wed, 28 May 2025 08:43:49 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: Casey Connolly <casey.connolly@linaro.org>,
 U-Boot Mailing List <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian =?utf-8?Q?Kohlschu=CC=88tter?= <christian@kohlschutter.com>,
 Daniel Golle <daniel@makrotopia.org>,
 Dmitry Rokosov <ddrokosov@salutedevices.com>,
 Eddie James <eajames@linux.ibm.com>,
 Francesco Dolcini <francesco.dolcini@toradex.com>,
 Hiago De Franco <hiago.franco@toradex.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Janis Danisevskis <jdanisevskis@aurora.tech>, Janne Grunau <j@jannau.net>,
 Jeremy Compostella <jeremy.compostella@intel.com>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Maks Mishin <maks.mishinfz@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Marek Vasut <marex@denx.de>, Matthew Garrett <mgarrett@aurora.tech>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michal Simek <michal.simek@amd.com>, Moritz Fischer <moritzf@google.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Pawel Kochanowski <pkochanowski@sii.pl>,
 Peter Robinson <pbrobinson@gmail.com>,
 Philippe Reynes <philippe.reynes@softathome.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tim Harvey <tharvey@gateworks.com>,
 Vincent =?iso-8859-1?Q?Stehl=E9?= <vincent.stehle@arm.com>,
 Weijie Gao <weijie.gao@mediatek.com>, Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH 00/10] efi: Move some efi-loader code into a new shared dir
Message-ID: <20250528144349.GX100073@bill-the-cat>
References: <20250523130651.1329593-1-sjg@chromium.org>
 <20250523140613.GQ100073@bill-the-cat>
 <b8c81f80-a32b-4935-b2f6-edb361822b6f@linaro.org>
 <CAFLszThaeVF_6ewTqupDH-CvpZAvXr=6XxkUzv2UbaX9+z6Hvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="mYeHgxbB0aJyzpwg"
Content-Disposition: inline
In-Reply-To: <CAFLszThaeVF_6ewTqupDH-CvpZAvXr=6XxkUzv2UbaX9+z6Hvg@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-Mailman-Approved-At: Wed, 28 May 2025 18:54:00 +0200
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


--mYeHgxbB0aJyzpwg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 28, 2025 at 01:40:36PM +0100, Simon Glass wrote:
> Hi Casey,
>=20
> On Wed, 28 May 2025 at 12:03, Casey Connolly <casey.connolly@linaro.org> =
wrote:
> >
> >
> >
> > On 5/23/25 16:06, Tom Rini wrote:
> > > On Fri, May 23, 2025 at 02:06:35PM +0100, Simon Glass wrote:
> > >
> > >> Some functions provided in lib/efi_loader are actually useful for the
> > >> app as well. This series refactors the Kconfig and directories a lit=
tle
> > >> so that code is easier to share.
> > >>
> > >> As a starting point, it moves some filename and device-path function=
s to
> > >> the new directory.
> > >>
> > >> The next step would be to move device-path code over, but this will =
need
> > >> some discussion.
> > > [snip]
> > >> base-commit: 3599a58a5114224a01557d18371036a5823233cc
> > >> branch: app
> > >
> > > Please base this on mainline, next branch before asking for review.
> >
> > Seconding this, for the second (third?) time: please don't send me
> > patches that don't apply to mainline U-Boot. This especially sucks since
> > I want to see EFISTUB upstream>
>=20
> OK, I have adjusted my system so you won't see future patches. I must
> have missed your previous two requests, sorry.

And to be clear Simon, excluding some people from mailing list posts is
NOT the solution to the problem of you posting things to the mailing
list which do not belong there, period. I will moderate all of your
posts if you can't stop misbehaving.

--=20
Tom

--mYeHgxbB0aJyzpwg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg3ISAACgkQFHw5/5Y0
tyxW3gv/V5vezMBxJA4x43yxeTf74Mlsoq4Spp97LWDnJIuVnc8SpjYyDmAVhcVF
acrWlAhBq/hvHvX19/k+YFTK/8OxxX6R7OLiwdLFty3yxQemu24kxuoanX5bLJGc
k2sH6kj2lrEuX9cSgwGuN1Iye1kHqzW2kYU3wTI3I0aRbSvKqxYncIhpFFNqgXwd
fD5np4y/KZ1uWAzEjEvo4pEHphMUeV8VMsfCGCmsorIQPQRPD6Nhz8owz8NHIPDF
MWSuNq8a2R92fYlCTUCD8vyRudMbyUsmXuis6WX5bvOblpxRJLi29LrbxpPl01SK
eiH8BW4CHiDMjvC/SPDMaT3eJhJzK1UcLP31aONPwHJtacoLWdlSkmjlvhp2f+We
6IiPGmRFM+gYYhfR+5ngWpALis/wBHn/hgAa0zZnZDiBr+z94f2YIyRjZ1+MP3yN
5YVxRGKoWoh1eujj8mm5Y69MoU9ZV9Nk1AZnDv5aih1ehdZSp8h0JMZB8UIGcXEC
3D9yefIb
=31UK
-----END PGP SIGNATURE-----

--mYeHgxbB0aJyzpwg--
