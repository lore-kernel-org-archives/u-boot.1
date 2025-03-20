Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E614FC28B30
	for <u-boot@archiver.kernel.org>; Thu, 20 Mar 2025 14:18:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 75377806FC;
	Thu, 20 Mar 2025 15:18:46 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="slK+JvXY";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 33B9C81101; Thu, 20 Mar 2025 15:18:45 +0100 (CET)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com
 [IPv6:2607:f8b0:4864:20::1030])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CB85A80540
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 15:18:42 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-3012885752dso1451225a91.2
 for <u-boot@lists.denx.de>; Thu, 20 Mar 2025 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742480321; x=1743085121; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KRGjyMG+1j0HSgccAhJJv377703fuMd3TVKD3svYI94=;
 b=slK+JvXYfHnifABmFG3aZh1yJVWU3H77PsZhFYkD2HBEJByzkbP9uR6KyQqQ168Oer
 TMTl8XEiav49u3GISSpqcjuKtlW+IPwUePH66Q9qXlljBhbTuILAngTVU0Q2edGi6eKd
 7FM1l5OacaWe6LHmZf1ztKh6b6oGyY7Xkx5RE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742480321; x=1743085121;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KRGjyMG+1j0HSgccAhJJv377703fuMd3TVKD3svYI94=;
 b=HQsofqyMyilr6CBcMJIhxtvDASdghIC+4k1/r+rBGj0v50rpgHeCoVN/LOlRpRfvgz
 OZ2UXk/E9NaaRi/Di1j0FeWNQDwg3P9qkFMbojet4PHXc+qEXvMiyV6mdNgFiOrEnQaA
 ON0qj37AZi0wJMaJ4/af77lcx26/C4hyuwLRb2trVFdgBqKGD4o4gT+3Zm++fqwmAfd+
 7RfmERgHJYJTwkU0wfZO4sFdwOYa42h46z2tC1jKqTZ6eiXODy992/mcCu2ciKCclRrV
 7cUtrmUDfi68eCSf9W3lG/22M2ORw5IW4AeeUU9n1ZbhYu4whCprVpY3D1Gyvi9g1P8f
 udLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMbO9k/q3M3xgKn8lY6N76nvci4sED858DIJlEXmH0lz+JWXqyh5SV1ZtIEK+3MnWSffrFD/Q=@lists.denx.de
X-Gm-Message-State: AOJu0Yx3RPk4DAa9I3c2htEI/HeNnQAX35G5zs+QqN1HosXVFkKNJfe1
 ed2jTWozZ4/pTGZDPndWqDfgaNR6z5GK40hG1AI6VJWZ6v7IPyzh4QVfLZWXvvY=
X-Gm-Gg: ASbGncsM+2AlN+5iM3/NUfhKKtnvMFPPnuF6mN45OPADxE0GaPH5lQxfxTMgM0Y/Ocn
 OU9igFUU1IUA9nKmTOG5NLciUSUnkQlVu3KPn2R8ooSo2dWviQY4dROirpdkiVtfgsUuTpW+no1
 Lt+gW+4ZSFKTLE1b2fS6BYuVsMREcnSV8bx02fiS1no0A5JMxI4PiGwurhos6gkKj+JiJ8u5I6x
 N8G46iUl7clBLcOuLrLg/8bCKJFmNGiZumRGCh6KH0f+LLuQGwt1065zVcDrHIztkytxJSQr+NV
 LU7pWUA3zOgdrIh/TrCp58kAlptEV0YNkipk/8EuUzNLZQ==
X-Google-Smtp-Source: AGHT+IErXXKXp6TJ1qEiJadQWtNbovO9xqdKf87DMvmalnU0BJT1bttWD6EYjaScfJWlw9px/NHqQQ==
X-Received: by 2002:a05:6a20:7f87:b0:1f5:8748:76b0 with SMTP id
 adf61e73a8af0-1fbecd36bffmr12326170637.29.1742480321079; 
 Thu, 20 Mar 2025 07:18:41 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56e9e0fd8sm12913279a12.26.2025.03.20.07.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Mar 2025 07:18:40 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:18:37 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: Quentin Schulz <quentin.schulz@cherry.de>,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>,
 u-boot@lists.denx.de, Benedikt Spranger <b.spranger@linutronix.de>,
 Simon Glass <sjg@chromium.org>, John Ogness <john.ogness@linutronix.de>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH] tiny-printf: Add support for upper case hex values
Message-ID: <20250320141837.GP2640854@bill-the-cat>
References: <20250320102346.13564-1-cniedermaier@dh-electronics.com>
 <a6ab86ac-4404-4081-8529-b8d11b37b5d2@denx.de>
 <ab32ace5-efc0-41b9-8d13-292f6f87835d@cherry.de>
 <513b3e03-72d6-4997-8fb7-ca5d8a530097@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="uJNMT09AX6LeDz5W"
Content-Disposition: inline
In-Reply-To: <513b3e03-72d6-4997-8fb7-ca5d8a530097@denx.de>
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


--uJNMT09AX6LeDz5W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 03:14:03PM +0100, Marek Vasut wrote:
> On 3/20/25 3:00 PM, Quentin Schulz wrote:
> > Hi Marek,
> >=20
> > On 3/20/25 12:49 PM, Marek Vasut wrote:
> > > On 3/20/25 11:23 AM, Christoph Niedermaier wrote:
> > > > If tiny printf is used with 0x%08X (upper case X) the output is
> > > > always 0x00000000. It could be confusing if upper case instead
> > > > of lower case is used intentionally or accidentally because the
> > > > actual value is not output. To avoid this confusion, tiny printf
> > > > is extended to support also the formatting with %X.
> > > >=20
> > > > Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.c=
om>
> > > TINY_PRINTF is meant to be tiny, i.e. not consume a lot of space, at
> > > the expense of functionality. This is meant to be used in size
> > > constrained environments, like the SPL. If you need full vsprintf()
> > > formatting support, disable TINY_PRINTF in your config and use the
> > > regular vsprintf() implementation.
> >=20
> > The issue is that disabling TINY_PRINTF may not be possible (size
> > constraints) and some code is compiled for different stages and people
> > typically don't check whether the format used in printf is valid with
> > tiny_printf. I've had this issue already in the past, I vaguely recall
> > "complaining" about it on IRC.
> >=20
> > Maybe there's something we can do to verify that the code is working how
> > we expect it to work, regardless of tiny_printf/full printf selection?
> > checkpatch or a compile-time check for the formats maybe?
> >=20
> > But yeah, essentially the whole thing is... if we continue like this,
> > we'll just end up getting closer and closer to the full printf which is
> > not something we want :)
> Shall we maybe patch tiny printf to print '?' on unsupported formatting
> characters, or outright complain that users should fix their code ?

This sounds good to me, adding ? in the output.

> For the %x/%X thing, we could technically fall back from %X to %x , which
> would do the printing with minimum footprint increase, albeit slightly
> malformed:

There's 109 hits on "%X" and another 489 on "%0.X", so I think it's
reasonable to do either of:
- Misprint A-F as a-f (in other words, treat it like 'x'
- Audit the callers and change them to 'x' from 'X'. We normally don't
  capitalize the output and there's all sorts of patches over the years
  changing them to lowercase in other places.

We have done both for other format specifiers and tiny-printf before in
the past.

--=20
Tom

--uJNMT09AX6LeDz5W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfcI70ACgkQFHw5/5Y0
tywAVwwAmvsXH9VrXJ7Kokx0ocoBBBNacvwI9PiYbLyrhjiPGbykqyd8lx0mHALy
Wj+in1pirgGHCg2s2U6wmijGAxHBR6hfeVsXmSriFJhUS76frf7JqYC1jTzcMVZS
Phg9bC09kS49dWNLJ+TS/YVYcwSogPrTueDbhDmqsQsLtjLN2Gn9Ae6nyeChHtAg
g7hPvJPyuRYjzSGWRyH3bWity1l5h03jwbA1JFus6gVC6z9UN74LmHJQ5/m1t012
RiOSjn0UwdqisNVsWOuOyy8WU7395jJYRUfD2a6fmxVtPF8vfNQUdQRH1AFkKg5U
2w8zoTwcgcLm1VL1fo07s+kDQwzRT+uzDWxP/BGZUfgN/3W6VTZFT4nO1H58+GFU
XG8LJklV23bLgeooaL9xIWI+RIt/UHVSn7t+7gpu7Cl/LeYP703jsmlZnMdcZI7E
KJ6/3GBaQgYR45HO0RC73E70kLKOmfLmb3PB2F112BfKvEi1bNDkTiwtt4mPgiJQ
4qvl1diU
=ySJP
-----END PGP SIGNATURE-----

--uJNMT09AX6LeDz5W--
