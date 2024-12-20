Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F407E77188
	for <u-boot@archiver.kernel.org>; Fri, 20 Dec 2024 18:31:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2B282803A9;
	Fri, 20 Dec 2024 19:31:10 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="VufXoZQt";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DB83380384; Fri, 20 Dec 2024 19:31:08 +0100 (CET)
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com
 [IPv6:2607:f8b0:4864:20::f35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id EC1CC803C8
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 19:31:04 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf35.google.com with SMTP id
 6a1803df08f44-6d932b5081eso19001046d6.1
 for <u-boot@lists.denx.de>; Fri, 20 Dec 2024 10:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1734719464; x=1735324264; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=TaVhG286ZBdWRHNMWrjnOzEBvInWutxZ41A/U60WPMA=;
 b=VufXoZQt6hJqWboSchR+uQcUOI3HEElnAI64Vvts+aCBfoi7lUKBbUegsxcXyzlPqu
 eum93mwSrB4iayViw5K0hzYmjhlSxcxOI3zXWZ80InRwSBT/u/RtkJkIXwRrj6Khh0Ka
 JIqhymDaEi6xzOhVjUa6lWTp7ySl/SuThzFm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734719464; x=1735324264;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TaVhG286ZBdWRHNMWrjnOzEBvInWutxZ41A/U60WPMA=;
 b=YS7KD3fXD/1F7JUTDqYg6H9AatL28NXUA+tPEcFLgaaMjvZQcrbJeQAji7ynIP06oF
 JDHN2DihsGKyeR/KrN0f86H+FT86wnlPNcjDtv8bJj0tCbxgYuy7ZpcdctH6nKut1RKt
 AIN0599LTZjE4KgUuHyxqKJZG7laeQQbVc+z9yUfO14EMqgeElrctEFXeFmER33Ve6rv
 5wNZO3NHMjcPzwKAWsdG1mxjBwZhDRqzYXd7khXafds8GuAwmF3FvfTkZbMuCjZ0cI5I
 +A2x4YmqELw+eDWsbJCL2pDFWzh56cjzS/KwBpXP/OFTJvR1n0bMz2jzOPji3T5nYBr0
 RBAQ==
X-Gm-Message-State: AOJu0Yyln/8Be09lmmoRfIhB4MRe6sQje5HTrbUvyLWjiiNo8LDL7aK1
 dEuYaYuhnM/EM5L4noOG3HyR5UdBuz49V6WewXM47E6hqWdXai6ymQWDK18UhFM=
X-Gm-Gg: ASbGncvN2s91sJpxqDJT5k9ZYLq1d11Qmy40bbNS6oyS1x9w4LNIB0tzBwO/j122o9c
 ARYMVaoFwfJTesfKCDwFw45JGgQWLDbx+vsG9D7zU+q1sD26R7Oel+8X3yoLjep55mhd1vCz/Ce
 rVeSYeI+UKMU5sK9k9xjwAB6I89QTWmxEZRBj56MNOYaOSPHrpWH8COA5UzFLe/S7QuI2yH4EHt
 MDB2IYsBqHG1TuFmesvZqD41AEo+b2TBJ2mvhXCr1VWIERyQaJZQIkU
X-Google-Smtp-Source: AGHT+IEmU2yNxKZMa0YjMOXjCm6GYTlTKXpH8/+OKiFYUHZRHYGEKWUFvtWSznR2gOpc22H/urRD+Q==
X-Received: by 2002:a05:6214:2628:b0:6d8:e679:547c with SMTP id
 6a1803df08f44-6dd233527bcmr62557026d6.29.1734719463816; 
 Fri, 20 Dec 2024 10:31:03 -0800 (PST)
Received: from bill-the-cat ([187.144.29.192])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd181bb4f5sm19297056d6.81.2024.12.20.10.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 10:31:02 -0800 (PST)
Date: Fri, 20 Dec 2024 12:30:59 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Francis Laniel <francis.laniel@amarulasolutions.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martyn Welch <martyn.welch@collabora.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH 5/5] pxe_utils: Support the SAY command
Message-ID: <20241220183059.GK1505244@bill-the-cat>
References: <20241220040120.3245610-1-sjg@chromium.org>
 <20241220040120.3245610-6-sjg@chromium.org>
 <20241220144453.GB1505244@bill-the-cat>
 <CAFLszThceeEktXy0zQLny5Hh4wAq0jXks4qijVyzgN0uHtG95Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="6toEliv13CFpcI4+"
Content-Disposition: inline
In-Reply-To: <CAFLszThceeEktXy0zQLny5Hh4wAq0jXks4qijVyzgN0uHtG95Q@mail.gmail.com>
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


--6toEliv13CFpcI4+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2024 at 10:36:56AM -0700, Simon Glass wrote:
> Hi Tom,
>=20
> On Fri, 20 Dec 2024 at 07:44, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Thu, Dec 19, 2024 at 09:01:20PM -0700, Simon Glass wrote:
> >
> > > This shows a message for the user. Implement it to keep the user
> > > informed.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Where does the SAY command come from? This is in neither
> > https://systemd.io/BOOT_LOADER_SPECIFICATION/ (which redirects and is
> > limited) nor https://wiki.syslinux.org/wiki/index.php?title=3DPXELINUX
> > (which is where http://syslinux.zytor.com/wiki/index.php/Doc/pxelinux
> > redirects to now).
>=20
> https://wiki.syslinux.org/wiki/index.php?title=3DSYSLINUX

Ah, thanks. Should link to that too in the docs then, I'll v2 my patch
there.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--6toEliv13CFpcI4+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmdlt9QACgkQFHw5/5Y0
tyypFAv9EN9DgT+7ZJvt/UqgV/uOgGArh5C4VBU6ZdO1yg/u11gi3uZelt01k2Ti
7vHGzY6EP3uYIGt4XZ/ib5NHvuRaZPKIL8yaOUpxAZcQwOyHsLPKM0cZ4WghMEpW
e5ROueP/+8SxU0bp2kMrivzu3OaORkbgf/YBeUkiYoq/4Z2Um9s9gmfmXYbhesn7
ZF4WFHYeMCeoGwqZ9vOqpKFFAv3GXP2P5XneUo2wj4V6fmG045f5mneE7Q3bifq0
ywE+5tPdYgsa3xAfd4kz6yA2yr9tsJeLUeWLxkg6Ebu1cWBAvi4qR48I/s6Sop7p
+vbmXmfXGLXiBKFYe9DKgxLtgdjRFxCw59DY8BqAXDe0Hx8qdbNi2jIRI0qA9HQW
wRgybexndCQvXcSJkjjbtIpiojNjPpAaFadiCS5xGJJAEPUXLDIiWmqe4mWT/Hob
2xQ/NS4uc2/pHH90yjJEn1/LH38WIBHvtm9jKoXVzCARcYkjtHFZIshHOTOvz0Sg
YaD6LUjS
=w4G8
-----END PGP SIGNATURE-----

--6toEliv13CFpcI4+--
