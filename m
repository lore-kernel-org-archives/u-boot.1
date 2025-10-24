Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132EDCCD1BF
	for <u-boot@archiver.kernel.org>; Fri, 24 Oct 2025 17:07:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2AAC983678;
	Fri, 24 Oct 2025 19:07:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="cD9VAbnQ";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 036A3837E4; Fri, 24 Oct 2025 19:07:46 +0200 (CEST)
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com
 [IPv6:2607:f8b0:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 87D9183677
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 19:07:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x329.google.com with SMTP id
 46e09a7af769-7c52c19cc27so100558a34.2
 for <u-boot@lists.denx.de>; Fri, 24 Oct 2025 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1761325662; x=1761930462; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+ZEN1aLxHVBTiOJQ9dCNjlOyCpDNTn7Lp2Z7DxJb9Ws=;
 b=cD9VAbnQLYg22qaszgc+N+UtlJl89Cgu15yPDeMCpdGsWev3Dx/6DL3KiRT17d5+bh
 rwaMlcsxb91pfpfMUS2RQN8wnfP0dqI9LA3W+gl0Dwlm6IoKAWX6cZSQTEeRCc/LoVeS
 xxBZRsGbThV8GpDsdjZltzvUj2HBS15NkVBBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761325662; x=1761930462;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+ZEN1aLxHVBTiOJQ9dCNjlOyCpDNTn7Lp2Z7DxJb9Ws=;
 b=flfCdIa2oZrC2cfUMnrD4LmH2B8YZFRHqfdEJQE+ch0pywtO8ZEOP42tQhLz3/GG6v
 Cx/JCvGwd4ARDMzGDdUmpJTy5fA3RzcL6aHRNDLvpwE9SFLsBYXOvdzZyWBnLxftbGI/
 gcuqVOZdancWS2u0HBiCkvI9F3PlRX3vQ8Veh9C1ulTZjopkkuMzu5w3NeaBPVMJI3nc
 r3bBhPdEcLHlUNTtSa1WPxaENCtPhbHsNHvo04l+2n2nHhc6oz5eV5wULk3LkNWBpX7F
 PietAl8bwdPsk7VK7qrs+dvotGZ9oVB9w74Wf9W8fx+SVmDhsoAW0u+eH287EMPjoTN+
 oMPg==
X-Gm-Message-State: AOJu0YzoX4G3fa1o433RhOMHPvezFN4GS/spbCtGqLmIrAiiVsvtfpFc
 eIOK78CLd5Iga5IxA/3EkQwssHDNUAw4ZxIll1d8TS2qy2CYBPqDzZEtgNzB+DA0318=
X-Gm-Gg: ASbGncvAd7vKDyWkksLw1DTLaVPeI77gPjtiARox9YqnYXKayTRo4QepYjKAHotCV/3
 Ua4uZF8hc3f7CzROzANB7MUu6KKkwbEBtsAJm/gqC4uA4XoqfUkYMAyECoNF/m3Msqh1/nvAleJ
 7yXVsaM696b+n0um/ZV/Kt6uuUXXJQ1ZTsDvaz3au8vUkpY1bMeEomaTwEPPbUfy8Kpdh3wSfYy
 NghEhYjzAq9xngxRwMkh9ucJDi2JTY3ar6MEkWwCGDe6cktUt10arXhwsIcOqQdTx+1gcUU5Dt+
 8kDFkUaQ0jypHUt0iXz34ZI//1YHcxhKc+6TNkuPvWwtDXEMXOtNSgGzbCRWt+wLPS1IMwKk5oh
 R3f6WwhNVnKBMfE/VnAm7OCsUlKBlmMQQt/dZZH6X9kH5CWqzFvijcw/1UxUIHqaePAfnsp7GJK
 00s9AkEvAu9oEGGOVEpJpvn5vBTf6xGfIEX26Sn0H1Nu/BMMtoIQ==
X-Google-Smtp-Source: AGHT+IHpKLbXT3Vou7K5pNCpWuO7qaQseQLdwwCHNe+Y70ZWQTwoQe7TK7cP24yTsh268DVxH1LHHg==
X-Received: by 2002:a05:6830:4901:b0:7ae:39a2:2656 with SMTP id
 46e09a7af769-7c27cc82201mr13790825a34.25.1761325662167; 
 Fri, 24 Oct 2025 10:07:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-202-235.totalplay.net.
 [187.190.202.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7c509200166sm1711577a34.0.2025.10.24.10.07.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:07:41 -0700 (PDT)
Date: Fri, 24 Oct 2025 11:07:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.denx.de, Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: Re: [PATCH v2 3/3] doc: seama: Reword return value section
Message-ID: <20251024170739.GR6688@bill-the-cat>
References: <20251024160557.2317081-1-trini@konsulko.com>
 <20251024160557.2317081-4-trini@konsulko.com>
 <325c2789-dbaa-458e-b48b-a5228373c3ee@cherry.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="nlw6x6Hl732CdhLs"
Content-Disposition: inline
In-Reply-To: <325c2789-dbaa-458e-b48b-a5228373c3ee@cherry.de>
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


--nlw6x6Hl732CdhLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 07:03:55PM +0200, Quentin Schulz wrote:
> Hi Tom,
>=20
> On 10/24/25 6:02 PM, Tom Rini wrote:
> > With the addition of general text about how the return value is handled,
> > reference that while retaining the additional information about setting
> > $seama_image_size
> >=20
> > Reviewed-by: Quentin Schulz <quentin.schulz@cherry.de>
> > Signed-off-by: Tom Rini <trini@konsulko.com>
> > ---
> > Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > ---
> >   doc/usage/cmd/seama.rst | 7 ++-----
> >   1 file changed, 2 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/doc/usage/cmd/seama.rst b/doc/usage/cmd/seama.rst
> > index 17fd559f4856..a6b00f32902e 100644
> > --- a/doc/usage/cmd/seama.rst
> > +++ b/doc/usage/cmd/seama.rst
> > @@ -56,8 +56,5 @@ The command is available if CONFIG_CMD_SEAMA=3Dy.
> >   Return value
> >   ------------
> > -The return value $? is set 0 (true) if the loading is succefull, and
> > -is set to 1 (false) in case of error.
> > -
> > -The environment variable $seama_image_size is set to the size of the
> > -loaded SEAMA image.
> > +Along with the general rules for setting $?, the environment variable
> > +$seama_image_size is set to the size of the loaded SEAMA image.
>=20
> Maybe we could link to the general rules section.
>=20
> Adding a cross-reference label above the text added in patch 01 and then
>=20
> :ref:`the general rules for setting $? <the cross-reference link you'd ad=
d>`
>=20
> should do the trick (note that we need to use a text for the reference
> because the cross-reference in Sphinx cannot guess it for anything but a
> section title, c.f.
> https://www.sphinx-doc.org/en/master/usage/referencing.html#role-ref).

One of my goals is to reduce the work needed for every command doc that
we add. I want to simplify doc/usage/index.rst as well (I think we can
glob), and then maybe add a note to the start of that section? I'll play
around...

--=20
Tom

--nlw6x6Hl732CdhLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaPuyUwAKCRAr4qD1Cr/k
CqYFAQCMa93EdkZ3jOT2PIZmjpCzFskwkXpUFVozGZzTfP4BHAEA9AqxOP4ZnKVW
RJhldHooZjC/CqjpYSr33Y7Ci0qDVgE=
=Qmd9
-----END PGP SIGNATURE-----

--nlw6x6Hl732CdhLs--
