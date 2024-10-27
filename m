Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D660D13569
	for <u-boot@archiver.kernel.org>; Sun, 27 Oct 2024 14:56:37 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C777688DCC;
	Sun, 27 Oct 2024 15:56:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="b01XzE9O";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 58D5289030; Sun, 27 Oct 2024 15:56:34 +0100 (CET)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com
 [IPv6:2607:f8b0:4864:20::730])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 803CD8897F
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 15:56:30 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x730.google.com with SMTP id
 af79cd13be357-7b15d7b7a32so314503285a.1
 for <u-boot@lists.denx.de>; Sun, 27 Oct 2024 07:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730040989; x=1730645789; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+c9uB1ARw+xifDNpOP6tsZfMPx+XfeoZzPauEvEVSls=;
 b=b01XzE9OSzUP0+MkBmqzHkWHtHUqODGArlNfD97W6KrITQ5jRw2i5qIQKIFVFv9Plm
 vtG4bSqSvOIZQk7Hpo0J8mclWHwiHQieTsuD4QljA6VrdCOYsHFs/Bbn2L5yFWOySWgD
 oxy+BY4Y10Yc0a3K8/Zl+Ww5TGpI4Hdl0id9M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730040989; x=1730645789;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+c9uB1ARw+xifDNpOP6tsZfMPx+XfeoZzPauEvEVSls=;
 b=YRgDs/jCIucb81yqTeIJOK5CGOcV38Ed2IO79JxI3Ty7KY7NRaRDNXtfogEwRzdhH6
 zaXdCeKC1EWg83eHlOqOnwqYnMNCb+4lJrZ3r5edHuJLPKq4h8HqXPy2/Y2yy1Yb7Ttl
 51QHLRKzS784ypjVn2rVC2kRKTJwxut8L1bo2F21pOxxYWZowpmVKn/f22JAhzr0hBVY
 zKHuoo+pwnc5c7gxvwJH3eeC60jEW/1AgG3rNFm/WC77BCShRrCjaxDQPa67oJTthvqV
 o2edclOTX7zK8DDwlBYDbOCiA2aTooUu50l1Tt4Sbx6h8NnebO/GSOjCazlPPG7jA4uv
 5OCQ==
X-Gm-Message-State: AOJu0Yyw3JGGaERmDnJODnwvZxpaX9edFQUGqkrLKEZ8kE8eYIxaGjqM
 QV0FBYdnG5Q8XZ8VfqpHfmkLeRO/qu2UPMNZWpZRQ3Ba/aZ1ksju9d2il/UkWnQ=
X-Google-Smtp-Source: AGHT+IGM5LKdr8aGdzAigYYaHoH1Uy9c1gaUSg/u9+gv4knleUFdJs0/3l0U0G6JLcWWHWK8gHSdFg==
X-Received: by 2002:a05:620a:19a9:b0:7a9:aac8:f244 with SMTP id
 af79cd13be357-7b193ee1628mr847182285a.13.1730040989321; 
 Sun, 27 Oct 2024 07:56:29 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b18d27be4csm239992685a.15.2024.10.27.07.56.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Oct 2024 07:56:28 -0700 (PDT)
Date: Sun, 27 Oct 2024 08:56:25 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Marek Vasut <marex@denx.de>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Oliver Gaskell <Oliver.Gaskell@analog.com>,
 Robert Marko <robert.marko@sartura.hr>,
 Sam Protsenko <semen.protsenko@linaro.org>,
 Sumit Garg <sumit.garg@linaro.org>
Subject: Re: [PATCH v2] sandbox: Add a build without CMDLINE
Message-ID: <20241027145625.GJ4959@bill-the-cat>
References: <20241026120252.865215-1-sjg@chromium.org>
 <20241026223346.GI4959@bill-the-cat>
 <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="9dwr+F5ZZRu3l8TH"
Content-Disposition: inline
In-Reply-To: <CAFLszTg-Lr3uWu41YX1z=JTbBbiT8Gh2oydLHpq5dtyZbRUtKg@mail.gmail.com>
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


--9dwr+F5ZZRu3l8TH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 27, 2024 at 03:52:02PM +0100, Simon Glass wrote:
> Hi Tom,
>=20
> On Sun, 27 Oct 2024 at 00:33, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Sat, Oct 26, 2024 at 02:02:49PM +0200, Simon Glass wrote:
> >
> > > Something this breaks, so add a build to keep it working. Since sandb=
ox
> > > enables a lot of options, it is a good board to use. The new config is
> > > created simply by copying the existing sandbox and turning off CMDLINE
> > >
> > > Once we have tests for non-CMDLINE operation, this can be adjusted to
> > > run those tests.
> > >
> > > Create a new build which will be picked up by CI. Update the maintain=
er
> > > entry as well.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > ---
> > >
> > > Changes in v2:
> > > - Create a new build instead of messing with CI
> > >
> > >  MAINTAINERS                         |   1 +
> > >  configs/sandbox_nocmdline_defconfig | 365 ++++++++++++++++++++++++++=
++
> > >  2 files changed, 366 insertions(+)
> > >  create mode 100644 configs/sandbox_nocmdline_defconfig
> >
> > Please use the #include mechanism instead of a full config that will
> > also now have to be kept in sync.
>=20
> Hmmm we still haven't come up with a way to deal with the #include
> mechanism in buildman. I've forgotten where it got to, or even what
> the problem was?

I assume this is related to the issue I filed? Among the problems are
that buildman doesn't "know" about the architecture for example in time
and so thinks everything is sandbox (since that's the default). That
won't be an issue for your use case here (we have a number of defconfigs
today that work around this issue by setting CONFIG_ARM=3Dy and then a few
other options too, so that the resulting build ends up correct).

--=20
Tom

--9dwr+F5ZZRu3l8TH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmceVJEACgkQFHw5/5Y0
tyxTBAv/ZaVqNMJZ/TSYC5tio/LGn9bm6EBHw7Qoz5Ew1tU8wScvE7FVwZsc0t6Q
8OXhCaMizvxWbRkYWx6Qog41fjmlK2FJrRHmMwfaq7N0s4Y31It5B8AXp7D5XGjT
Qd8N4B8My7iXoL60o/jpF1fBd3NfXuqleJ8yGnLL7VT39/w3LEm9pHf1jOSG11bY
WoYJn5Cc6hwUw8yFM9IoIZkKSzcjESQfMHOr2mjTsFRtp+JQPfSaiJDvsiPwallQ
6RLPRkn3GjjthT6uDD1st+wCVbWiuLDt+V6ve6WwY6Gtvb9DOSDnUA3Rwn6aBFV9
4yO7RO284k0xkDCOvyIPIjV5GygMmG2t9yj0zVtG7i1sMAoeL45h+8FoU3KQgY6M
8TAP0rigYutvdCpK+FTxXwa2+H8t3NhvkX5+84Jv+01JYqpSVW0uFzKuTHZzHguf
SQ5h3roQH1/ZImPuVCwKWltdZVjmPkbnw+dzBY3rGid5AwGcWYTjTdIT6tnd1X8d
B6sLqRky
=gZW3
-----END PGP SIGNATURE-----

--9dwr+F5ZZRu3l8TH--
