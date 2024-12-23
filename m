Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 247CAE7718B
	for <u-boot@archiver.kernel.org>; Mon, 23 Dec 2024 18:53:50 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8869780730;
	Mon, 23 Dec 2024 19:53:48 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Q2D1TyCh";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9FF8A8074B; Mon, 23 Dec 2024 19:53:46 +0100 (CET)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com
 [IPv6:2607:f8b0:4864:20::833])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 739D2806FC
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 19:53:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x833.google.com with SMTP id
 d75a77b69052e-4679eacf25cso23320821cf.3
 for <u-boot@lists.denx.de>; Mon, 23 Dec 2024 10:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734980023; x=1735584823; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=pWK2cCukamieOEyhtJv5xgIttFGtRrFk9SRYaG1XlGk=;
 b=Q2D1TyChrr8yeLWUqyq7SCBrYApWXM67c2pvQl9FGNiuLrOJ4XqRJmUoj5BnBiJ1oY
 AqxyiBQDqTt8LDwnN7oEoaavUNQ0PnzSECaV7id9BBZv5MzCheMhJLjdpT+/EH+TI8ZX
 W9TYIXL2XViIjM5PBi+4JrAcdB8V7oRL5GGyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734980023; x=1735584823;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pWK2cCukamieOEyhtJv5xgIttFGtRrFk9SRYaG1XlGk=;
 b=gybIDnNfuG3q2cTef+rW0qg4ukLNxS21CGGtBvHHgDuRD94BGvYdciSxmW9CIbbs6J
 7Y0B2cNNRwqFr3FkYy8RtVgbPLyhgVd5l7nQdVaiuCLkGMDxuhwUAMbKgICd64/dR5ik
 Tj2Yhp34DwZjb+gjl7j3h9cJrNzdlme3kYNRD8Q/h7jkk8rcZza1tftQWru1NafEkJTs
 l0fFzbuUrk/nBlQMNoyapMJuZyPlI4J9URspVM7/gIw/r1BoqBf5Pa1aR9A9dNp9++rr
 mrfTn9/1hTelaA4SA8oorzaCbCbleLgozDMmHf9n0MlyGHRbo8vLsGvC4Yz79chlv6bi
 GfHQ==
X-Gm-Message-State: AOJu0YxmeodtQdZClFKy9Oqs5nvy73oFfOiHtsz2Woov0zExV6xwbCRq
 xV/mxA88Ct2CQ6icwky8kHeNbJ7EV71BiGh7YSuDod6zr9s4VY2Ssr+4otIKyTG7XUIbkK+0gfK
 u
X-Gm-Gg: ASbGnct52JFut+05BWbMjgrmdAPT9G1FyQkCI2JqgCkaob14BB2DkJDy2+eRUWdpyT8
 pnF35lrgKJsOKOP64oAiDDgUAGpXXDvLVt/IstOR+ZH0kafkjuHqepHXl+Hku3fxwrN+UbwYgRu
 k8jGevRLYIkxQ77Q2rDBFxFT5mWdsJFZqSoDUvcKmKxdeFJDUaALAS0AOJDGlOkOkpSQdSRaKbl
 ZuuKt5aBqhDqfMkwqOU2jkTIF8oRkJ+ecBv8W1u1D7jBwsvx9ENMteYew==
X-Google-Smtp-Source: AGHT+IEDACEuduO6tDsy7FPCUxU8HyT/rGN5l7tnbEM+9of/MyA2P2pPua5ymLWE/sgmO2W71nPUGw==
X-Received: by 2002:ac8:7f41:0:b0:466:77d0:592c with SMTP id
 d75a77b69052e-46a4a8b643bmr226019181cf.8.1734980023245; 
 Mon, 23 Dec 2024 10:53:43 -0800 (PST)
Received: from bill-the-cat ([189.178.122.190])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46a3eb1760fsm46304071cf.71.2024.12.23.10.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Dec 2024 10:53:41 -0800 (PST)
Date: Mon, 23 Dec 2024 12:53:38 -0600
From: Tom Rini <trini@konsulko.com>
To: Peter Robinson <pbrobinson@gmail.com>, Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc: u-boot@lists.denx.de
Subject: Re: [PATCH 4/6] blk: Make block subsystems select BLK
Message-ID: <20241223185338.GT1505244@bill-the-cat>
References: <20241220222612.1757884-1-trini@konsulko.com>
 <20241220222612.1757884-5-trini@konsulko.com>
 <CALeDE9M8X7ZK=JSxgADA75XLaJo40g0fKVB3PYHttouj1M1AfQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="RR/SdhNUkaIrFjyQ"
Content-Disposition: inline
In-Reply-To: <CALeDE9M8X7ZK=JSxgADA75XLaJo40g0fKVB3PYHttouj1M1AfQ@mail.gmail.com>
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


--RR/SdhNUkaIrFjyQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 06:31:58PM +0000, Peter Robinson wrote:
> On Fri, 20 Dec 2024 at 22:36, Tom Rini <trini@konsulko.com> wrote:
>=20
> > The BLK symbol has a few meanings, one of which is that it controls the
> > driver model portion of a "block device". Rather than having this hidden
> > symbol be "default y if ..." it should be select'd by the various block
> > subsystems.
> >
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> >
>=20
> Just a minor query against the USB change, other than that the rest looks
> fine.
[snip]
> > diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
> > index 960b6a906ac4..99c6649e4178 100644
> > --- a/drivers/usb/Kconfig
> > +++ b/drivers/usb/Kconfig
> > @@ -1,5 +1,6 @@
> >  menuconfig USB
> >         bool "USB support"
> > +       select BLK
> >
>=20
> Shouldn't this be against USB_STORAGE further down the file?

So, this is a 1:1 translation of what we have today. That said, it
likely could be done at the USB_STORAGE level for USB host, and
USB_FUNCTION_MASS_STORAGE for gadget (the entry for CMD_USB_MASS_STORAGE
is depends on BLK) ? I was slightly worried about opening up a number of
problems if I poked too hard on this area and didn't want the series to
get too big.

--=20
Tom

--RR/SdhNUkaIrFjyQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdpsasACgkQFHw5/5Y0
tyxt8wwAjtMdxXM2kRRH/8saU0u+4KbCk6DQ7wnrVfaUiPt9NJsd+6eyNqmfGF71
x/c5QFCyfN8Sg5iXvoUn+ID3GYWa9xm9NYMyH2Z3jFKmG8eN12tQzdiGyz3QP1gz
r+z2o7tTSR0ZVSoPqP1A5Rx79MNzS8apIcG/pXCmjWkBAT00jE5Etgo0xj72YWcT
GYBvaWNiIdP9hMjuN9hI/iCYUBcWYEho13E1zsbR5Xn2qlQkkX3YEjWAC1J7ifg4
GzPKsXRrOjfXusu1vM+t5mqnftXEP0w7FbHI2vEzHZ35hK3l553O0Jf7+/FRfFso
/5/P/WEIEOjLlWFtUXC+XKBDfDiqsRnbCRBBe48NYkdV6gMe/ohBFwWHm/rOFv5n
pMxEBB43kzLGI+HVF0IhRj7MpwNopLy+VSL1P4tGclq47me7FV6XsQD7iwJgDuyk
b2F9jbAex1cx2KNvUmW5iKtGUeaBGO3HWeXbS1t5m78kylEHmUKmNB6yK3qKyFTO
n+2ersTh
=SK+1
-----END PGP SIGNATURE-----

--RR/SdhNUkaIrFjyQ--
