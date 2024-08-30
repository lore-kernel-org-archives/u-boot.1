Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EEECA101A
	for <u-boot@archiver.kernel.org>; Fri, 30 Aug 2024 21:54:01 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 69F6188CFB;
	Fri, 30 Aug 2024 23:53:59 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gg558/rb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3E23488D0C; Fri, 30 Aug 2024 23:53:58 +0200 (CEST)
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com
 [IPv6:2607:f8b0:4864:20::729])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A911588BBC
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 23:53:55 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qk1-x729.google.com with SMTP id
 af79cd13be357-7a7ff6c4fd0so148548185a.1
 for <u-boot@lists.denx.de>; Fri, 30 Aug 2024 14:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1725054834; x=1725659634; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gxogeqISirLWdeETYpUg4owv+jiDtn0U1VdcsI1xvCY=;
 b=gg558/rbk7CWjZLJ9K3jFiB9Tw2btUX5K01vWA+dDwb05WcBJWgp7uDer8JLlsXQkL
 Mc7omsHaIFj7C2iBZWvBp36VUtnH8xx24xFj+aYeOURyJx+0sJEO8fhZzr49JHYh4EbJ
 yeXsXaCTVP8OCYmE21+D70aRWWsNbby2kCPtg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725054834; x=1725659634;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gxogeqISirLWdeETYpUg4owv+jiDtn0U1VdcsI1xvCY=;
 b=ViDwlz6OQZh7QKD2nodTQMXx2TOFUATtXqJvRA7TXEI57f1+7RpAAEoyYcq4ckpBdq
 Qv4WLMuJM3BH2myu+MLS7mk4k0uwsKmPzrVzSprkHFIer9RTQ9Cna/u4LmB2qFI71ZVz
 Wb15w8QVsCwvelPKmGMqTKCG/8OyY8b5y5F9gujIBiTRHnWxFRucHCflYNywTEdIQj3A
 zbaOWw7QEraIs0ffF9tZYm0f/wwRc7ip6Hw4V0wK9s1FXM/hh5ioTu6TVuD+71b3SmCs
 h2FhdGjn350uwAxsv9dZaCg6O0moOM5xfg+AoJuPyw4p9TdcblFbuNQUqqSU8kUl0Y91
 b0rg==
X-Gm-Message-State: AOJu0YzcGq/4KMBYCsAmCh6bDmZ/y+MJmX1B6aOKHsWvXnDLsqw3VCXx
 y6491L6YNVcdh/thkSbeR/5NW8AT0pFlEm4IbUQyO/fUPyY+Xlu3TMYCLVyhgUo=
X-Google-Smtp-Source: AGHT+IEOLOjlvDNDqBdQH3Dag52P2Yp1B1QUa+aouUuMvHb9YlDQ6MoXU8OCySMbfT/08WFeHBI03w==
X-Received: by 2002:a05:620a:4693:b0:7a2:d64:1cc4 with SMTP id
 af79cd13be357-7a8931d9904mr95603485a.7.1725054834045; 
 Fri, 30 Aug 2024 14:53:54 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a806c2415asm182651985a.49.2024.08.30.14.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Aug 2024 14:53:53 -0700 (PDT)
Date: Fri, 30 Aug 2024 15:53:50 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>
Subject: Re: [PATCH v5 00/20] labgrid: Provide an integration with Labgrid
Message-ID: <20240830215350.GW2479150@bill-the-cat>
References: <20240828220846.1205813-1-sjg@chromium.org>
 <20240829140921.GX2479150@bill-the-cat>
 <CAFLszTgTwHbp8TPaca4jOis+qh=yEUpQA7T-w3toB4hLh0Y-MQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="G2F2jOTahf9AkRA1"
Content-Disposition: inline
In-Reply-To: <CAFLszTgTwHbp8TPaca4jOis+qh=yEUpQA7T-w3toB4hLh0Y-MQ@mail.gmail.com>
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


--G2F2jOTahf9AkRA1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 09:00:25AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Thu, 29 Aug 2024 at 08:13, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Aug 28, 2024 at 04:08:26PM -0600, Simon Glass wrote:
> >
> > > Labgrid provides access to a hardware lab in an automated way. It is
> > > possible to boot U-Boot on boards in the lab without physically touch=
ing
> > > them. It relies on relays, USB UARTs and SD muxes, among other things.
> > >
> > > By way of background, about 4 years ago I wrong a thing called Labman=
[1]
> > > which allowed my lab of about 30 devices to be operated remotely, usi=
ng
> > > tbot for the console and build integration. While it worked OK and I
> > > used it for many bisects, I didn't take it any further.
> > >
> > > It turns out that there was already an existing program, called Labgr=
id,
> > > which I did not know about at time (thank you Tom for telling me). It=
 is
> > > more rounded than Labman and has a number of advantages:
> > >
> > > - does not need udev rules, mostly
> > > - has several existing users who rely on it
> > > - supports multiple machines exporting their devices
> > >
> > > It lacks a 'lab check' feature and a few other things, but these can =
be
> > > remedied.
> > >
> > > On and off over the past several weeks I have been experimenting with
> > > Labgrid. I have managed to create an initial U-Boot integration (this
> > > series) by adding various features to Labgrid[2] and the U-Boot test
> > > hooks.
> > >
> > > I hope that this might inspire others to set up boards and run tests
> > > automatically, rather than relying on infrequent, manual test. Perhaps
> > > it may even be possible to have a number of labs available.
> > >
> > > Included in the integration are a number of simple scripts which make=
 it
> > > easy to connect to boards and run tests:
> > >
> > > ub-int <target>
> > >     Build and boot on a target, starting an interactive session
> > >
> > > ub-cli <target>
> > >     Build and boot on a target, ensure U-Boot starts and provide an i=
nteractive
> > >     session from there
> > >
> > > ub-smoke <target>
> > >     Smoke test U-Boot to check that it boots to a prompt on a target
> > >
> > > ub-bisect <target>
> > >     Bisect a git tree to locate a failure on a particular target
> > >
> > > ub-pyt <target> <testspec>
> > >     Run U-Boot pytests on a target
> > >
> > > Some of these help to provide the same tbot[4] workflow which I have
> > > relied on for several years, albeit much simpler versions.
> > >
> > > The goal here is to create some sort of script which can collect
> > > patches from the mailing list, apply them and test them on a selection
> > > of boards. I suspect that script already exists, so please let me know
> > > what you suggest.
> > >
> > > I hope you find this interesting and take a look!
> > >
> > > [1] https://github.com/sjg20/u-boot/tree/lab6a
> > > [2] https://github.com/labgrid-project/labgrid/pull/1411
> > > [3] https://github.com/sjg20/uboot-test-hooks/tree/labgrid
> > > [4] https://tbot.tools/index.html
> >
> > Part of my concern here is still that this series contains:
> >
> > - Generic test improvements and fixes:
> >
> > >   test: Use a constant for the test timeout
> > >   test: Pass stderr to stdout
> > >   test: Avoid failing skipped tests
> > >   test: Move the receive code into a function
> > >   test: Separate out the exception handling
> > >   test: Detect dead connections
> > >   test: Tidy up remaining exceptions
> > >   test: Improve handling of sending commands
> > >   test: Fix mulptiplex_log typo
> > >   test: Avoid double echo when starting up
>=20
> So should I send those as a separate series?

Well, as some of the other comments have been getting to, I don't know
what's really useful / needed, or not here.

> Note that when things land we will need to look at the gitlab output,
> to make sure it is what we want.

In general getting our pytest output more understandable is always nice
and useful, but this shouldn't be any different from all the platforms
we already test in CI.

> > - Labgrid specific listed as generic changes:
> >
> > >   test: Release board after tests complete
> > >   test: Try to shut down the lab console gracefully
> >
> > - Your labgrid+builman implementation specific changes:
> >
> > >   test: Allow signaling that U-Boot is ready
> > >   test: Allow connecting to a running board
> > >   test: Create a common function to get the config
> > >   test: Introduce the concept of a role
> > >   test: Introduce lab mode
> > >   test: Add a section for closing the connection
> > >   test: Support testing with two board-builds
> >
> > Which makes this harder to review and clearly merge. For example, we
> > already have hooks for power on / power off, and we should just call
> > them as wow that would make everyones lab easier (I used to have a
> > pre-script to turn on everything).
>=20
> Power on/off is handled by the strategy[1] in Labgrid. Some boards
> have power control, some don't. Some use reset, some don't. Some need
> a recovery button to be pressed when resetting. The fundamental point
> here is that Labgrid knows how to manage the lab, so any external
> scripts are always going to be fiddly. Also, they are such a pain to
> maintain.
>=20
> I see Labgrid as a lab manager, something which looks after the lab
> and knows how to operate it.

I think the biggest take away here is that we need to make sure whatever
goes in to the hooks repository can be easily customized to fit how
someone uses their lab, and that's going to be different from what I
have and what you have.

--=20
Tom

--G2F2jOTahf9AkRA1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmbSP2sACgkQFHw5/5Y0
tywfZAv/W6Mbp63ishF1sZUM4TyMcX+Fx0LLOaWu8kv4E6glXJyIDlkp9P9/GS+c
iV3BihbHayMDnX3kwSMLg77oiqHOr4Rbg01nyH6XB5XjvObYC5GF4+5kLagGl/s0
56e0bUNDRqCCI7O7ESvm8AMNkr8SOct3DI3zY457qi6AmTt6jUMFQwzR2rkqdXtk
4xJCAk9LpIj2tmDwygU+bKFIX1fbY/PRyrEwhfYvejUVtsbEBHq0n7Y1iLOMpFRP
XzrmxW5M3jlbwBk5n9qIyWfR08RdjkEPAVf5JiWnIh0lKPx4av+nLSb3SmocmLGK
ocFrspCBj+qrmEgAx4R2WN/X0lU6m/CMaBf8+IbKgbbgtDHMjR/x5dNKzU1ExZU3
K+E9RzMmMqQzCfFhHefeS915gn7UoFGjA2PElFJeLu17f5nTjea75rRZcs5bhmjP
hkD4ilGsRAs3tDQa55H29zhyZ5Z9DpN/nhG6UKNMPMtwVPu+LJMhSyU0pyX5fCcp
E4+eLRcG
=fu8X
-----END PGP SIGNATURE-----

--G2F2jOTahf9AkRA1--
