Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81265E7718B
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 17:24:00 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id ADA32803B5;
	Fri, 20 Dec 2024 18:23:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="f47rSlPb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E8C5B803B7; Fri, 20 Dec 2024 18:23:56 +0100 (CET)
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com
 [IPv6:2607:f8b0:4864:20::72f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A665A80381
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 18:23:54 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x72f.google.com with SMTP id
 af79cd13be357-7b6f75f61f9so258475385a.0
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 09:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734715433; x=1735320233; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=n+0Y4YAXSfnnKtkpwrRfWZnbFz0t0gFC2+bfC9SPXNg=;
 b=f47rSlPbE/wa4+ExUfG3k2TsSs5CX+s9694nzcwbH6qw8Ok6L2qPeY2ScSq99V5NQT
 JXkGsIiQcRCisgLEgHmUHjgFjkr12mJW51zTGDJosjrV5QRbjJfLIXov0DJDtxXmG95x
 hCKxm0TOb4eB8g851jwEgBbVzJHZuFQqnFA3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734715433; x=1735320233;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n+0Y4YAXSfnnKtkpwrRfWZnbFz0t0gFC2+bfC9SPXNg=;
 b=JILKwI8K0W8HECqoTzyQinDEAmqQHO/j+VCPokKBv8ZFaXB9z5qMpUM6khc6rsZTj7
 ZDWJlE+AFH63rSw1zV8d1VQDDHgXtomcGgH1a68meErgXRe/9vLkPG6N3tyK5zfvWPn3
 QHZqVll4StpT2YdUF3XOZiP5PWLRssupcFO9PXZnokl4p8UmSWG/2PGwBZliJtw6FI/K
 h/9/w3pzddVrZOV/foX/ZC8cu2AijcSHbmnCDDKK03llevTmRKVSb9sl2XZaAOuMgWGw
 TF0WO/S2Six0jIbKL+HBWAZ3e2gf3n+97unaCIcPI6ly6OPyDYj+z/hfmjkMPVxn4AIM
 BDHA==
X-Gm-Message-State: AOJu0Yyu2aPlqJ2ZRNZPFaHcCH1UTCrmEMSQnhWGWinejsN6TpBu23A+
 2VI/sbpOWkoEuqL42W127Sh3O4jGo6NXL41tG/lsDzXwZDshMwUqDoMwspXoUj0=
X-Gm-Gg: ASbGncvLLuemt6gr/12FwBPaNVDNwf5LCJtskmUqo/youNEEG30JuEeTXSYV4Soil22
 9CcqwTsp+74u8MqIch0L/4LO96lqn5r4PBeYeb2a06cOqMV/J9hyhcQtNBWLRw3hZtPRYC2QBdV
 HBKKH6t3Ia4hXtkp0N9WOVCq+fZzx92BRsQRd2N1uZsJu+yC4sAwgXtlCcq4ILf2UP2L0zaQ4V6
 4aCDkDvNznjHZu0U7LXiBrrXq9G6ylk0K56S7fr5vX3BcUZLSgWkdEI
X-Google-Smtp-Source: AGHT+IH4oPWeNK4PJ/i/r8GG1UkdNtqc0ftJ3ypQYD8S0W1b9EuY/Mlj6aFq7UwfNjtNZMfYCu7z9g==
X-Received: by 2002:a05:620a:4452:b0:7b6:6a3b:539b with SMTP id
 af79cd13be357-7b9ba73895emr599241185a.17.1734715433549; 
 Fri, 20 Dec 2024 09:23:53 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b9ac2df39fsm153382585a.38.2024.12.20.09.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 09:23:52 -0800 (PST)
Date: Fri, 20 Dec 2024 11:23:48 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>, Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 4/5] pxe_utils: Support a backup for localboot
Message-ID: <20241220172348.GJ1505244@bill-the-cat>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-5-sjg@chromium.org>
 <20241220145609.GD1505244@bill-the-cat>
 <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y1d1NP5LdKf7LIJy"
Content-Disposition: inline
In-Reply-To: <CAFLszTjzP+vm1YoUX_avNq4_4qnUtNzzjLyFocEhJYrCA7cGOA@mail.gmail.com>
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


--Y1d1NP5LdKf7LIJy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 10:18:17AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Dec 2024 at 07:56, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 09:01:19PM -0700, Simon Glass wrote:
> >
> > > The current localboot implementation assumes that a 'localcmd'
> > > environment variable is provided, with the instructions to follow. Th=
is
> > > may not be included, so provide a fallback in that case.
> > >
> > > Add a test image and test as well.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > This is a pretty niche feature, I had to dig around a bit to see how
> > it's specified elsewhere (not really) and how it's used. And I think
> > that based on how it's used, making up a bootcmd when localcmd is
> > undefined is the wrong approach. It's the hook for "run what I defined
> > in the environment", so if not set erroring back out seems appropriate.
>=20
> Yes, but unfortunately it seems to be used and we should support it.
> The problem with scripts is that we don't know the boot device, etc,
> so it needs to be integrated into PXE. I did consider putting
> something in bootstd, but we only find out that it is requesting a
> localboot when actually running the extlinux bootmeth, so this is what
> I came up with.
>=20
> It will be interesting to see if any other cases come up.

It would be helpful at this point I think if you can point to how the
code for handling this case (the LOCALBOOT keyword followed by an
integer) in other projects so that we can be compliant with what's
expected, even if it's poorly documented.

--=20
Tom

--Y1d1NP5LdKf7LIJy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlqB0ACgkQFHw5/5Y0
tyyMKwv8D4rsXCgsVNrBhpH6MY8/J7WQDmhbrVKGJa3uuU0KXffldUDJZQub1W8q
gL/T5xHnuG2njbp5H0RALC+1aSmjHfyNd3Bh/04PWs4wnklNCv9xd/jua9rfzt9d
Dly9TZdIBku+a7f8RrVPvxrYnZrrEErZ/QGZcv5atZx60y/HIq6KV6ObsolPgaz4
DObSuD3cKlGyMdg1tO4+VibdTXcxcrJopcWjvlrQcZlAmTL3mhNIUfRBsqFDPC2k
0jk1weFH786PLiKB9d1xEQdFOeqq2BWZmX4RNoNRM6kqshTlbYrYNYP6VdR0LgIJ
B93rbzt5eXED73TsIocoJ7JJjVG5T2pBpH6TZS6/QLSfJx6JwNiacN16gJfYwSLn
PyHmjTX3B3TeBq6MaQRKkvBnK9msBfyqlgEYCdR5edyoO8HINoB4yXWOC97CtcA0
+ybLqWsxrhQFwfh4l3Ibn3tAp/pDAqFtrKzR/rSnZB6lhxSZDdJAW2TXLTvYWQkQ
OA/dbl1R
=qDJz
-----END PGP SIGNATURE-----

--Y1d1NP5LdKf7LIJy--
