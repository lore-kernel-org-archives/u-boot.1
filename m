Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1A11F531CB
	for <u-boot@archiver.kernel.org>; Mon, 13 Apr 2026 20:19:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6298183DC9;
	Mon, 13 Apr 2026 22:19:19 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="iB011goG";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C1BEE841A2; Mon, 13 Apr 2026 22:19:17 +0200 (CEST)
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com
 [IPv6:2607:f8b0:4864:20::236])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7E1AD839DF
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 22:19:06 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x236.google.com with SMTP id
 5614622812f47-464ba2bb3aeso2770761b6e.1
 for <u-boot@lists.denx.de>; Mon, 13 Apr 2026 13:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1776111537; x=1776716337; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=tFimhQ3mkrzI4CmGPpnJt93dQy6hiCrZpLNo07Ti4OQ=;
 b=iB011goGcc1e36aOLTUGWO5Hel3wugxWz96S0vkNnOpD4rO/Lv3pI0nuIRgjju5OoY
 WW+ieVHz/cwYmoYa1c65s1sE2bzZEipb6rkMLdiAZZIPIjPux0N9wc+2BM8/NdLnMblz
 wxZAu9OOawa9IJSnXv1Z1pgChUjsR71GrEmGE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776111537; x=1776716337;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tFimhQ3mkrzI4CmGPpnJt93dQy6hiCrZpLNo07Ti4OQ=;
 b=IoS8xUBgZVfoXY+9ngDnjQDTD1uvhb2yIUQkvVK9Kb2gJzl8Km1555qHD0tGJnogN1
 tAws1ODDSHeQdcACQ/go8U6HT2wpbXbIK5+gDblGo3/ux2e1NoHhX01YwC4RxamQyWHX
 Lt6xd1nf/RcZqGELuT/c10HZhL0s/MYI12j3oNPXetZ6J+nlF5CYitMrHacGGSW7l6L0
 gPABhvWaDvps+oNgBViuXIVOYNHUeRsp23MRghMtmnzXyYmtyZavPTLSOdchUNylUOou
 xpPrTgHxfXCwj3k+aMoxYTKSKm4YNvCDgjHpL/KwMIECTn87LiExPN/yw6chYNhWbDPz
 ccLw==
X-Gm-Message-State: AOJu0YzdaBz2aHA5Se1+L9Nhch0lQ9ieiK0PBpy6ba7jWR3JBnpBTZJq
 IOx1ADO36n4yqH9XqtR5ASl0MFT/Zx1MEIhO9k3qCMh9eVY2Q0WlfBzHqKyX2ktLJOg=
X-Gm-Gg: AeBDiesxRPk+gCMOOo7p9sdQ1FPyetdopE2zKNDoo4i2gnWTfT0ZP3CiUz4iy8cvD3s
 a5AB1ePp/G2FEGGYW6R7W5vg7ftgqV6njxRNpWd1IqQofNewoNCGqWLVkdk30sn7s7IoN7vmWww
 qBwFM5WfEBuRZPtZq6M5hqjpz0RDh3WbvKMY1i3y5+82tbJS2nbn7GwPvSzyRi3FkBANeq2oHiV
 yVPrMWqA9lJpQA7/xPAOd3kZOWR+tiA0LchjJBXqFBPCGeQLlxaCRukhN1FVVVTJlps2NHSYaGT
 ADsnGIuV/0Eqv4JNP1fHixnaqOE5K9CubkPlewecA4r0DzU20tTA8eoa/75aqIVKp9At/rGPyyJ
 d/Gj/RBqDeG1NGhCZEQDgzRXHa86xBeVaFlw4IyqOkA2mZ1Pa2608dLW7qUQJPWXj+pR5Joe0uF
 6AbGFZFgkZTjIDswlMhatWwYa3ZnuACN9gyGw+Y7oaD2xEmVMvTfgU9y+OtTZzLFxFFFZrR74oH
 2OYrbXvSFtjbldFGZhCVdo5aL3+GXkolv/pLsQ+YUzYKAPbgwY=
X-Received: by 2002:a05:6808:13d5:b0:466:ed3f:7214 with SMTP id
 5614622812f47-478b9f54edamr5789817b6e.25.1776111536630; 
 Mon, 13 Apr 2026 13:18:56 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-478a080c237sm6939820b6e.1.2026.04.13.13.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 13:18:56 -0700 (PDT)
Date: Mon, 13 Apr 2026 14:18:53 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: u-boot@lists.denx.de, James Hilliard <james.hilliard1@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH 01/13] boot: Split out the first part of fit_image_load()
Message-ID: <20260413201853.GG41863@bill-the-cat>
References: <20260325165431.1027591-1-sjg@chromium.org>
 <20260325165431.1027591-2-sjg@chromium.org>
 <20260408162543.GD41863@bill-the-cat>
 <CAFLszTjKBrUu9zFHyHXmSUMCrZjLB05ri9jdSaaTBOuJndKE0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="qDPiP34XLNCw4oqJ"
Content-Disposition: inline
In-Reply-To: <CAFLszTjKBrUu9zFHyHXmSUMCrZjLB05ri9jdSaaTBOuJndKE0g@mail.gmail.com>
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


--qDPiP34XLNCw4oqJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 11, 2026 at 07:03:35AM -0600, Simon Glass wrote:
> Hi Tom,
>=20
> On Wed, 8 Apr 2026 at 10:25, Tom Rini <trini@konsulko.com> wrote:
> >
> > On Wed, Mar 25, 2026 at 10:54:10AM -0600, Simon Glass wrote:
> >
> > > This function is over 250 lines long. Split out the image-selection
> > > part into a new select_image() function which handles format checking,
> > > configuration selection and image-node lookup.
> > >
> > > Take care to only call fit_get_name() when a valid node is found, sin=
ce
> > > libfdt does not handle negative offsets gracefully.
> > >
> > > Signed-off-by: Simon Glass <sjg@chromium.org>
> >
> > Function length isn't a problem in and of itself, especially when we
> > aren't pulling out some 4 or 5 level deep nested logic to improve
> > readability.
>=20
> In my view the current code is very hard to maintain and change. I
> know this because I have tried to do it:
>=20
> 1. By my count, fit_image_load() declares 20 locals. Even without deep
> nesting, tracking which variables are live at which point in a
> function of ~270 lines is extremely hard (see [1] for someone else
> that had this problem). Just to take one example, pulling
> select_image() out makes it explicit that cfg_noffset (for example) is
> only relevant during image selection and doesn't leak into the
> load/decompress path.
>=20
> 2. The function has distinct phases: format checking, configuration
> selection, hash verification, and image-node lookup. So we have 'find
> what to load' vs. 'load it'. These  are much easier to understand with
> clean function boundaries, rather than an arbitrary split at a line
> count.
>=20
> 3. Reviewability - when someone adds a feature to the loading path,
> they currently have to read past 90 lines of selection logic to find
> where their change fits. Smaller functions with clear contracts make
> it easier to see where new code belongs.

Or, splitting things up makes it harder to review because now what
you're reading through is over *there* instead of the next line. I find
myself having to "un-inline" function calls sometimes because we've
thrown around so many abstractions. So I stand by what I said in the
cover letter.

--=20
Tom

--qDPiP34XLNCw4oqJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCad1PrQAKCRAr4qD1Cr/k
CvHiAQDuPdndu1NnJz0OLhEOAQ1aGtSPQwbAdHHqG00gdHopvwEAleXz9Adh1Q/Z
eQB0oOwvROWG3JJw6ZNbLILGkKtc8gc=
=W5rP
-----END PGP SIGNATURE-----

--qDPiP34XLNCw4oqJ--
