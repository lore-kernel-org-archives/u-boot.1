Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1401AE7718F
	for <u-boot@archiver.kernel.org>; Mon, 30 Dec 2024 15:25:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6B3D6805EB;
	Mon, 30 Dec 2024 16:25:41 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="pj6T9uAh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7FB40805ED; Mon, 30 Dec 2024 16:25:40 +0100 (CET)
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com
 [IPv6:2607:f8b0:4864:20::f33])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id E7F2C805EA
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 16:25:37 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf33.google.com with SMTP id
 6a1803df08f44-6d8a3e99e32so73914056d6.2
 for <u-boot@lists.denx.de>; Mon, 30 Dec 2024 07:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1735572337; x=1736177137; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=s++p5AB6R0KUreKBMVgwQfRDEzCmiK9ffi4B78fK6lo=;
 b=pj6T9uAh3vf+9JJsq20MPlhLwuZuBS4tKsvNHq2+zMrHub/sHdhhlMwBpropK4CAi4
 fCupCFYY3L9qHAcJszoZLszzoH+AH2ZbF8Br5m9peJQ/jtAC1piBVRmKrnM7n0qzLcTy
 4Tpn0rY+DqPUoMo7y16LFj9V/J/yOgCqV0GrQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735572337; x=1736177137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s++p5AB6R0KUreKBMVgwQfRDEzCmiK9ffi4B78fK6lo=;
 b=C8QTH9iISdXDgmZhKegKqOs1HmL+gDhic3MdTPHY47FF9hCG0y+YRHRahOip2k3wZM
 OSiELDR4EjdbrRpu+HlzgrdWtmRw7r6WtJELn1BqaUFj3o0XBvDWqzEYC0m1nOlK9jhJ
 UttZq1Zw056Sc/8TbIQuJHo1rStoKe6TBoZDl02p7iy/gdwVfNYtc3eMEyOjMeNQACRT
 +9JnHpiyhLfz/JRfLkv/BspMtdha2IQfW5cz+R2VAH11KLuZCx+5OqcoQA9CNOXkJJ0O
 zUJrAJoHFp0u2pTM/dUHm+u9XbGvWPnJHaZ4XcqQnCz2KYwvTpfaYkJm9eKGkRfYg3C+
 rBGQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULwDVzqKdNhOYDcCmRtVL37BgZwqNemch57z3PDg+r0cb06xI7rKt8U3Imhha/+Q2lc4iv7i0=@lists.denx.de
X-Gm-Message-State: AOJu0YwSwUsIlkT7AN0R6xlrXaQifeuDUc+cvtxGXIMlGAPCiMFvl8l1
 bq/fNbDYnp++dGr7Z3P2iYsfglSbeimzcmEDb7hmYNI/0s/IXtbQ0u5BwlaUKtk=
X-Gm-Gg: ASbGncvTTWrkaWsYQGmLqrBI1JNhMc+/eZew3pUNBjlwGgBwBuy1ek0BuaJZgyEgFgg
 tuLSPREs8HG/t7QItmE8UQDhicAiN3EAbZsvyvY24sZMR0SCiAWHc7LtP+ps9XovzAL1XjT0Dfp
 moRiD6CafHP/S1FrXdIzXcVsha/XWei77lM/fdM+b/Myc4DM+L6dH/wck+8z8Gqv0irCXqCxEx8
 icYxeDoaHz/nadCM45Ro9z2ABywm9r/kebIPdXpSGzxbp2TJSt1mYkGyA==
X-Google-Smtp-Source: AGHT+IEMGWY6WanBitjKMxBoxZ0Rze7sa8mqbm9O+/9PjUXHlrnXDqbMntO9RnIQmc85EUxXlR7r6g==
X-Received: by 2002:ad4:4eaf:0:b0:6d4:586:6292 with SMTP id
 6a1803df08f44-6dd2335763dmr517433216d6.26.1735572336753; 
 Mon, 30 Dec 2024 07:25:36 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181d6374sm103158386d6.103.2024.12.30.07.25.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Dec 2024 07:25:35 -0800 (PST)
Date: Mon, 30 Dec 2024 09:25:33 -0600
From: Tom Rini <trini@konsulko.com>
To: Duje =?utf-8?Q?Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc: Karel Balej <balejk@matfyz.cz>, ~postmarketos/upstreaming@lists.sr.ht,
 u-boot@lists.denx.de
Subject: Re: [PATCH 0/2] Initial support for PXA1908 and samsung-coreprimevelte
Message-ID: <20241230152533.GC3476@bill-the-cat>
References: <20241227-coreprimevelte-v1-0-ac8243eee4e6@skole.hr>
 <20241227215327.GH1505244@bill-the-cat>
 <4950238.GXAFRqVoOG@radijator>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OTs1sbW7bBhoJaBO"
Content-Disposition: inline
In-Reply-To: <4950238.GXAFRqVoOG@radijator>
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


--OTs1sbW7bBhoJaBO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 28, 2024 at 12:10:49PM +0100, Duje Mihanovi=C4=87 wrote:
> On Friday 27 December 2024 22:53:27 Central European Standard Time Tom Ri=
ni=20
> wrote:
> > On Fri, Dec 27, 2024 at 10:22:14PM +0100, Duje Mihanovi=C4=87 wrote:
> > > Hello,
> > >=20
> > > This series adds initial support for Marvell's PXA1908 ARM64 SoC and
> > > Samsung's Galaxy Core Prime VE LTE, a smartphone based on said SoC.
> > >=20
> > > On this board, U-Boot is used as a secondary bootloader to work around
> > > certain quirks of the factory S-Boot.
> > >=20
> > > Signed-off-by: Duje Mihanovi=C4=87 <duje.mihanovic@skole.hr>
> >=20
> > What is the status of getting these dtsi files upstream? Thanks.
>=20
> They are the last component of PXA1908 support waiting to be merged, see=
=20
> https://lore.kernel.org/all/20241104-pxa1908-lkml-v13-0-e050609b8d6c@skol=
e.hr/=20
> .
>=20
> In case you're asking this to see whether the board could use OF_UPSTREAM=
, I=20
> should note that the dtsi files in this set differ from the ones waiting =
to be=20
> merged into Linux differ by being slimmed down, having different compatib=
les=20
> in a few places (CPU and serial ports specifically) and the coreprimevelt=
e dts=20
> also has an extra property `pxa,rev-id` which the stock bootloader requir=
es=20
> for booting. Could all this be handled in a `pxa1908-samsung-coreprimevel=
te-u-
> boot.dtsi` and `pxa1908-u-boot.dtsi` once they are upstreamed?

Yes, this is about moving to OF_UPSTREAM. Strictly and only with respect
to things that we have to deal with due to other bootloaders can we deal
with problems like that in the -u-boot.dtsi file. Otherwise we need to
match compatibles, etc, with upstream. Thanks!

--=20
Tom

--OTs1sbW7bBhoJaBO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdyu2kACgkQFHw5/5Y0
tyyZgAv/XVG+cgVeLejoX+YxDNq4VnjPIRA/56AM8nnPAypymK4mZ21rI/7U+4wd
l3L545s4I7qYwWz22TQrIsANrCmAMegf+JxpKycph10dPv/SQogrdSwnnZTH58xy
OkagVMiAtmxGgZ3WgrO10sAPA+2wggSrO4acEMjoZY7llLUQVbEj1651FAfziPQb
I2HmeGuueTCTcQyILAXAX+mmlCZPLbaAu8V/IHfkV+h2d9/1Wv27mgKsU2U87t+2
R3b1AZZJULLM1jAwALMaIKGNYExoakvtTVKocuSRzR6Qv7iAYrL2GLwpHO+r3pnM
3AhSL3SNZ+Vfshj6pn6rJwQGyxKXDtWlL6eNscMD+IJwdIo0N2DvykFQTDXpIMVE
hw1whBfhkYF0/bV75OI2zAYkLliJHQ+++dPekoZ6mZtg51km29BD2A/S7uWFi2u0
KujYxFMzyurIpjmeXUOxxtMiZvTtxBLdPrd2jFTxrru0ekgqR9SalKCVxJxySEmf
X6YLt8cg
=W759
-----END PGP SIGNATURE-----

--OTs1sbW7bBhoJaBO--
