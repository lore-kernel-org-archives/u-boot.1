Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4642C35FFA
	for <u-boot@archiver.kernel.org>; Wed, 19 Mar 2025 15:35:21 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4FF0881E02;
	Wed, 19 Mar 2025 16:35:20 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="FSR5N0xW";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 489B681E0F; Wed, 19 Mar 2025 16:35:19 +0100 (CET)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com
 [IPv6:2607:f8b0:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0143781D0B
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 16:35:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-22622ddcc35so29017235ad.2
 for <u-boot@lists.denx.de>; Wed, 19 Mar 2025 08:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1742398515; x=1743003315; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=woyY4toV95hhtw5+Wnraf9zaeHosaiEU2ugebsxcl/8=;
 b=FSR5N0xWeMiNFBnHVSD06Blnu8eos7MeT025JiSTlEpnF3Nu1JW+Rv//IQAxZuoVqx
 9BG8EnPUh82xbEBA0J+Goq61HJLYphk6XDhlVOvQ7/Zvu7QOY0yeZnX563Z2sZxvUb5m
 sZ3qBHjDKIMarNk7kLks+G2bL7OykJE+0yqEw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742398515; x=1743003315;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=woyY4toV95hhtw5+Wnraf9zaeHosaiEU2ugebsxcl/8=;
 b=Jqz1cp/LDN3WSqXxGdThu+mvMPFFiBpweZGdUn003HYiobw9ksER2m3jYGUsfLuEmN
 VKATWUVjqgzXMqMrqNb2uPoyUJxZE0gcSdwlv+YCHhOnctgUP6gkf04SYkuwgduuuBQ4
 5ULvmJrFdS7X1+K0nwXIg4nWfGpBx8PvMr7Ydrk47UdikPiFGv1RkTu86E5DQUx09vB8
 i4SueB2RIwgZCRhIJxl7vS3lPfogpzt1acloJ9TDod9QI4X/cFBMmbl5B8jCFtERdRRq
 zaCzFx//L4Id5HMbEBTls+afdJkWPKUOwchpdTXJcMVY43PKH273x2ZMhQ74UEN7nhJ2
 8e+w==
X-Gm-Message-State: AOJu0YxuwdtA5r5kOOsn3g1puX+N7qQ/V16oXa0AGwxepJAFYVNCTdS7
 MLKs+G1Y1/uTOJQW08yKkmXV3460w0oSEC6FSfOqFOcJP3oYRWskdhI9hzhbvck=
X-Gm-Gg: ASbGncvxfO475VZldkMBkWUrLFHMnWp3PbmtHL5ru0l/7JHI45Qxh4VkY02a3JgMZgw
 nQqTG8CFs470+zaLe5AZbSKdkhi0n+E5cozfOdHH4RvbdcLUMIBD5603MqR1utsdakkF7EFuGEs
 Djn1fQy1/zwAMiMK049oEUzlBj4oCPV6h4aZBZBMM4g31gpDkQ75EJ2TZUH2FnuHoZf+UEmxXt8
 4tP8jEns97TKAjOkcI11mYlwi3w/qS4TN2OTGPj47yuEfZSzAq4yBWLl5T9yvf2PvxS8oAtAkzQ
 Y3oUAc6m5UF+ck3NuzqmuiWO2FCZCxnwljkeQknZeMDpzQ==
X-Google-Smtp-Source: AGHT+IFJGWoKy9PgpuieMMzzsWN1GNxMTbo93OGfJ6bDXTNHZxNPksomFUplEPjnOlpnkKXS1tFH/g==
X-Received: by 2002:a17:902:da84:b0:223:501c:7581 with SMTP id
 d9443c01a7336-22649932224mr39101845ad.16.1742398515241; 
 Wed, 19 Mar 2025 08:35:15 -0700 (PDT)
Received: from bill-the-cat ([187.144.138.125])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-225c6ba6f1fsm115647185ad.135.2025.03.19.08.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Mar 2025 08:35:14 -0700 (PDT)
Date: Wed, 19 Mar 2025 09:35:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Jerome Forissier <jerome.forissier@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Julius Lehmann <lehmanju@devpi.de>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Richard Weinberger <richard@nod.at>, Stephen Warren <swarren@nvidia.com>,
 Stephen Warren <swarren@wwwdotorg.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>
Subject: Re: [PATCH 09/17] test/py: Add a test image for Ubuntu
Message-ID: <20250319153510.GJ2640854@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
 <20250319145218.GG2640854@bill-the-cat>
 <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="A4HgwKqKQurUmDu8"
Content-Disposition: inline
In-Reply-To: <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
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


--A4HgwKqKQurUmDu8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
> >
> > > Add an extlinux image that contains a few Ubuntu entries.
> > >
> > > Increase the number of sandbox-USB-hub ports to permit this.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > I don't understand what this test adds. In neither the current Fedora
> > test nor in this new test are we actually booting something, we're just
> > taking a sample extlinux.conf and making sure it doesn't fail. Is it
> > that we're testing in a useful fashion now having two labels?
>=20
> I didn't think so either, which is why I never did this before. But it
> turns out that there were some bugs, too.

I don't understand you, sorry. You don't think so either to what?

> > We should probably be clear about what we're doing in the tests and
> > instead of adding seemingly arbitrary distributions add an extlinux test
> > and testcases.
>=20
> This is not actually a test case. It is simply creating a new image.
> The test cases are in the other patches, so please take a look there.

Nothing in this series quickly reads as adding tests and fixing problems
with extlinux parsing, it's all bootmeth stuff?

--=20
Tom

--A4HgwKqKQurUmDu8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfa5CsACgkQFHw5/5Y0
tywb2AwAjjGT9VSg4lTlDBsgh3Rvfvmev7n2HqCNo4YLzNwOWSdiqaTCBF/ckpSx
d+hAYHL0ZGu2Iw6ww8kNwwx05e1NSTMMj4IlBYGxeVlVwTFgYRbxI6JqF1eZPfcq
lUhP8PxzqcrtY3U6THgDbxsyQEORW4gzURWmAs/XEaQCNRZlxVT9ioxxsi3xEWvW
2A6jONI1VSReJJQUovc6c8Q3wI+UOPHUWTIIUf3FKGp80wDJybCj6P0mgKsfikGr
hd6WqEjPOWMcIV8MKxXD1nV3MwUnw9VbyDy+5PSlcekeCB+oGc4BOjjj4hrWsb72
V1N9QyucjBZXuj5YOfXktpkXQ5bmOaaEssEWVoFdFB51s86RcQd7Ye4PhpEbUb3C
dgZz1uVh9AmlAY0zfnqYSx5jC7e46H2IeXVdYVjOQ+CsrnonyZEyy/8RqQn+hkcn
lV0bGOg+9Bk/SCc35Q+d/BsIcbpdqrlMoXMhN9CH63nO+aerYou1gqrsJJAccW8i
rYpQpRVV
=VxZh
-----END PGP SIGNATURE-----

--A4HgwKqKQurUmDu8--
