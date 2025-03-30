Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7638C3600B
	for <u-boot@archiver.kernel.org>; Sun, 30 Mar 2025 14:45:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 87A4A81E5A;
	Sun, 30 Mar 2025 16:45:51 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="ozjoDKHq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E72D581DE3; Sun, 30 Mar 2025 16:45:49 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A5E3680050
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 16:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x330.google.com with SMTP id
 46e09a7af769-7272f9b4132so2795089a34.0
 for <u-boot@lists.denx.de>; Sun, 30 Mar 2025 07:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1743345946; x=1743950746; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=CZ8XOby1wEtpEaSiEKXOwHxZbcP2Um00bsR4YWL6IBo=;
 b=ozjoDKHqVMy6z/hlryWzwT73PFwurn5mTS3th7HFXe5WFiKHCZ3iihOOO48RqzYR2M
 UuVhQNGMMICbswbMHUL63QiOzMl/cR8uga+uA6mU9dxPjSKDvuAFCUD9tfRtkl2MDBYK
 lTIf8zP88bAXC14XsSZq115s/Ra/tbnG8cJ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743345946; x=1743950746;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ8XOby1wEtpEaSiEKXOwHxZbcP2Um00bsR4YWL6IBo=;
 b=ZTHadIOVBih2XPzcVywvu+oaaaa8yjXrGuA9wRTaQoN9AebVIc9mhJHaMvkUUWPZ+u
 2DBvEXhSEcX3dpajdpgpZJwPfhy4m4mdAHm1SDAXaWyf077dJywA7dPV4zjv5BgV9DIk
 eu4Um4CPXWwfY4LzMlr4gF+5VjeEhEbbkttZXEjwy2YjqdoMqdawz7Rmt5Rx7EqWzDtN
 vuo0ERd0Q1IZStti9JJ+c/vjkiCJHImvcYbByUmU99WbwvKMZz8bjGLSYyzgHX2DRane
 wa7HeYajgY4+25wKwOiEKyZicHAnP4cLHVr2mt/vkpRDUe7OjipA9VFktxGmEXOyrHeC
 8pag==
X-Gm-Message-State: AOJu0Yy8NdmC+5RfMuioUku1sw36phUdn7VDKa5vVTr3JxDVBPG1I9QX
 UR7g4cl2FyuGaTa3wwryLSuspG+ju2Av+6lomUDjpE3pc2ItzEVG3zEXdJi9+EQ=
X-Gm-Gg: ASbGncuLC4kzWVjFl4JbHUNJm2v9rdAgIcII/gLMupAMC7CpMPj8UNJaCv/YSvGYXkJ
 5F5WzaJT424PsDSr1jzjgeqFvQ53q8xUFe9/WeZgEEoHuIaqgzzM9hOLexEBtUJBgqVqLGSnlXe
 RvP6rjQFDGGtFBw3KpN0/FoB6XInwsWnq8hMxhNonRcuQhmCKY5JF3wuxRPW8SOB6i1XuGIm56C
 lGyjpJXQUNBsQA/sHanzaZhpWtdt4Xl3JP1Xo8tj/gkuC+V2TziFGIzw9pTwRSx4OL/K24LSdXM
 anWOMNgno9gh6gQImreJAVsXc5tPS7c+q/Wih4xNLJ7XKs7xDevu+0AgmJ3x4gnf76bdRSm177e
 kR+zAMg==
X-Google-Smtp-Source: AGHT+IEtVIWslYFYEolgsWEQXez4lEvOlSoSq+riqDtjmu9ZjsUCrH8W+aH6OdK7rUnYofzJnp9p1A==
X-Received: by 2002:a05:6808:1811:b0:3fc:7e1:a455 with SMTP id
 5614622812f47-3ff0f4ea9cdmr3495531b6e.2.1743345946204; 
 Sun, 30 Mar 2025 07:45:46 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-3ff05167352sm1155157b6e.5.2025.03.30.07.45.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 07:45:45 -0700 (PDT)
Date: Sun, 30 Mar 2025 08:45:42 -0600
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
Message-ID: <20250330144542.GQ93000@bill-the-cat>
References: <20250319143820.2385092-1-sjg@chromium.org>
 <20250319143820.2385092-10-sjg@chromium.org>
 <20250319145218.GG2640854@bill-the-cat>
 <CAFLszTiRm3YEQqU1w75uFp5gFZ1HiPv41vNX7VFy8XS80udVRw@mail.gmail.com>
 <20250319153510.GJ2640854@bill-the-cat>
 <CAFLszTg8a7CCiyyVVQdHDHNJ3MEP-Zxbbao_riy+iTzDt2u-KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="C0lvtUd7zayyWGxx"
Content-Disposition: inline
In-Reply-To: <CAFLszTg8a7CCiyyVVQdHDHNJ3MEP-Zxbbao_riy+iTzDt2u-KA@mail.gmail.com>
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


--C0lvtUd7zayyWGxx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 03:41:33AM +0000, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 19 Mar 2025 at 16:35, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 19, 2025 at 03:04:28PM +0000, Simon Glass wrote:
> > > Hi Tom,
> > >
> > > On Wed, 19 Mar 2025 at 15:52, Tom Rini <trini@konsulko.com> wrote:
> > > >
> > > > On Wed, Mar 19, 2025 at 03:38:03PM +0100, Simon Glass wrote:
> > > >
> > > > > Add an extlinux image that contains a few Ubuntu entries.
> > > > >
> > > > > Increase the number of sandbox-USB-hub ports to permit this.
> > > > >
> > > > > Signed-off-by: Simon Glass <sjg@chromium.org>
> > > >
> > > > I don't understand what this test adds. In neither the current Fedo=
ra
> > > > test nor in this new test are we actually booting something, we're =
just
> > > > taking a sample extlinux.conf and making sure it doesn't fail. Is it
> > > > that we're testing in a useful fashion now having two labels?
> > >
> > > I didn't think so either, which is why I never did this before. But it
> > > turns out that there were some bugs, too.
> >
> > I don't understand you, sorry. You don't think so either to what?
>=20
> I didn't think we needed two extlinux examples on different boot
> devices, but we do.

I'm not sure it's particularly clear what you're doing here then, or
why, but I'll find some time to read it all more deeply.

> > > > We should probably be clear about what we're doing in the tests and
> > > > instead of adding seemingly arbitrary distributions add an extlinux=
 test
> > > > and testcases.
> > >
> > > This is not actually a test case. It is simply creating a new image.
> > > The test cases are in the other patches, so please take a look there.
> >
> > Nothing in this series quickly reads as adding tests and fixing problems
> > with extlinux parsing, it's all bootmeth stuff?
>=20
> It isn't about the actual parsing of the .conf file, although I would
> like to add tests there as we have none apart from what I have added
> in my PXE series. It's more about having multiple devices with
> bootable OSes on them. This series tidies up and fixes this. We need
> to have an image available on more than one device to spot these
> problems.

And the existing tests for pxelinux that we have in mainline already,
don't forget those.

> Currently we have two accessible to sandbox, one extlinux and one
> EFI*. I decided to add a third, using extlinux.
>=20
> Again, this is not a test case, but provides an image for the test
> cases in this series.

Adding mocked up things for use in sandbox is adding test cases.

--=20
Tom

--C0lvtUd7zayyWGxx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmfpWRYACgkQFHw5/5Y0
tyzKAwv+LMSJ26ol0/1+/lbogszDAp0cLFBSLAasN+Gu3OZ0PUCCQjevBeW495O3
hrCkD8ztIPMOfCb8vJGg3/zN0b/ti5oU5N6vj5OkPa1qr11DD8SGxcIsg72odL6k
ZNghpqLc7JUkKCXDEAU/VuKCFwF5T+oJ4LM569x0CBJ1BovFqICxsYLPJVEBVHit
gcx1GXfgbCP1mreaL1iQzSSijXNMOS4pHjNh2Y1mGaxBjehh6/OuZ/y5pIZZR46p
tALRmm9wsMcFF03QwMWu9pZntqNqUD07MT2+Yuq65F8DRgdOra3VFS2GIGsavX2i
I7rawk9NcwCptM/gxWPzOfgCuUWGL5Gn3qktNrwZBlb8Wf1aW9uOFfbuqYZ5xrC1
zpXc+Oecv+CZokWqSeqEE9cyPJrbgk6AruThGBS2sMq7xW8x0g/XKNS06r+hPHZO
nlxyoYbUZ3BzgXXhWMUPHlB5BRDTi23O1c3MTFNe5heR3fRluwJf9t/oOfs+FbJc
8L6w0SqL
=n55K
-----END PGP SIGNATURE-----

--C0lvtUd7zayyWGxx--
