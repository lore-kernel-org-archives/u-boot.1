Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2C17CAC5A7
	for <u-boot@archiver.kernel.org>; Thu, 25 Sep 2025 16:36:09 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 088D780107;
	Thu, 25 Sep 2025 18:36:08 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WKRX0NZ+";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 1B55080107; Thu, 25 Sep 2025 18:36:06 +0200 (CEST)
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com
 [IPv6:2607:f8b0:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 2F518800D7
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 18:36:01 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x331.google.com with SMTP id
 46e09a7af769-74526ca79c2so525744a34.3
 for <u-boot@lists.denx.de>; Thu, 25 Sep 2025 09:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1758818160; x=1759422960; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=+802zMbKsK+mu7s6zBQD0grmolBJPpas6rl02FTTeOs=;
 b=WKRX0NZ+FPqEPLh+AyPwYRuVlBg2nmu+dMVpGQFQ2iSd6j97l9OM5Qg6ei8LE2XMps
 AOImvgOdXPE/29lUfSmvuApyXWA0cpZd5sDD4BBduvhMORa1WnnCZ6OVr1ysHuD+rFF0
 Lblau46fNo2jjvE7An429MM6SI8P1LGwwbjro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758818160; x=1759422960;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+802zMbKsK+mu7s6zBQD0grmolBJPpas6rl02FTTeOs=;
 b=JRaR9IyUAvxoFshmmY31WSv3ZzFV8k5hmJMC6x6GGmneB242waLKzGuaCTbE4Sn1bz
 BMHA0J77PR5eihMuGK1xHBJN7CiVYKE/3kuspo8iJF7WI6i0420gkVn9pxpml6/71fPm
 rC2Ex3phJhT2JWvVzKOLwVBLMYEwZyw8BW7TYDlUwU6MCzqTQr5mt+CJEMk3me6F2pep
 03+LEShHnp6/PKf1IjP54+378GucwKCcWJ2Ls3sBmbtsTZIyIRaRRJAeaCy4iZiT9+wZ
 MMNo/E+YMx3qpmpLSX4wyGl1hhGs1qzFgpo5DT2V49qoMQ1tmJ/xTOCJs/HDsuwj4I+w
 1jmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXtvKPVTnz98PcvXmSjXq3c30tYS5bloS0/6UQ5hFVtLPy0GCJW3OMzbzm+dMKyQGBS6ep7+j0=@lists.denx.de
X-Gm-Message-State: AOJu0Ywx2lTjDOYoaWd3BHapT7943p0YJ+53v5BfDomViPWcwq0kgW4R
 HEVU0yF8MCamd6P2+ux5YaBwDr8k/Q6V5QrOEmPelGO91u2o/42lEExAgJmi0ASdxgw=
X-Gm-Gg: ASbGnctCRQsdsUFuVXg32WflxUMmQLgeurLz7S8z5fy0TDzjtgjAcsN4deGXYVMEpOy
 zeXz1E0mNR3M85kmX+gq+nd5AvdQkYv1JIM/cOUei8VQUrPRjtZZ4VQLVxFhYIaKlLzTwbRPaPT
 DctByqwSZyW7nK1BwFKClUJRYrTityhNC1eJbbZxHyN9cN+uJ8zG0Hvk3eV8ONZI183AEkU78iP
 u5NJymw8G9hnCoBBsM+MmhelguqR9O849FTuPVInNPaUsAMz1AJmhM5ZS64jLmE7G+iaI5w7+4K
 D0+N3MuBVBXrzs+NnqDaQQOU/GGFad9m1lub1SlRLzuwfiq4Ets/Q+QkeA/n6OW/pPCnDMXhvAZ
 bYuAWVSndAdrcrYj8nxAZdisFYfonDnw71cVsNLcPKR+W18Vdhtfiwek5
X-Google-Smtp-Source: AGHT+IGoMJKfNRBLIm5FuqNUhepAq2ZTk5kaaoLXspm5XFWRfnrOgiUCdQMzZN/K2Zz+bXMB/NvRFg==
X-Received: by 2002:a05:6830:3816:b0:782:4423:223a with SMTP id
 46e09a7af769-7a043e6552emr1978534a34.22.1758818159910; 
 Thu, 25 Sep 2025 09:35:59 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-97-42.totalplay.net.
 [189.203.97.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7a23e1682e9sm494463a34.26.2025.09.25.09.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 09:35:59 -0700 (PDT)
Date: Thu, 25 Sep 2025 10:35:41 -0600
From: Tom Rini <trini@konsulko.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: Javier Tia <javier.tia@linaro.org>, u-boot@lists.denx.de
Subject: Re: [PATCH v6 1/2] part: Export part_driver_lookup_type for external
 use
Message-ID: <20250925163541.GR197373@bill-the-cat>
References: <20250924233120.454116-1-javier.tia@linaro.org>
 <20250924233120.454116-2-javier.tia@linaro.org>
 <CAC_iWjKBzrJJj1fzeAkBeV2ZrOO1fT+9QUHrVdkb0FFD+seafg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="l91piDR/TE5lSQ4j"
Content-Disposition: inline
In-Reply-To: <CAC_iWjKBzrJJj1fzeAkBeV2ZrOO1fT+9QUHrVdkb0FFD+seafg@mail.gmail.com>
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


--l91piDR/TE5lSQ4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 25, 2025 at 09:20:53AM +0300, Ilias Apalodimas wrote:
> Hi Javier,
>=20
> On Thu, 25 Sept 2025 at 02:31, Javier Tia <javier.tia@linaro.org> wrote:
> >
> > Make part_driver_lookup_type non-static so it can be used outside
> > part.c. This allows external callers to determine the appropriate
> > partition driver for a block device, enabling more flexible handling of
> > partition types.
> >
> > Add a prototype and kernel-doc comment in part.h to document the
> > function contract. Provide a stub inline implementation returning NULL
> > when partition support is disabled, ensuring build consistency across
> > configurations.
> >
> > Signed-off-by: Javier Tia <javier.tia@linaro.org>
> > ---
> >  disk/part.c    |  2 +-
> >  include/part.h | 21 +++++++++++++++++++++
> >  2 files changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/disk/part.c b/disk/part.c
> > index 66e2b3a7219..f0c6866e210 100644
> > --- a/disk/part.c
> > +++ b/disk/part.c
> > @@ -63,7 +63,7 @@ static struct part_driver *part_driver_get_type(int p=
art_type)
> >   * @dev_desc: Device descriptor
> >   * Return: Driver found, or NULL if none
> >   */
> > -static struct part_driver *part_driver_lookup_type(struct blk_desc *de=
sc)
> > +struct part_driver *part_driver_lookup_type(struct blk_desc *desc)

Since Ilias has a comment, I'll also note that with the kerneldoc moving
to the header, the version in the C file should be removed (this means
they won't get out of sync).

--=20
Tom

--l91piDR/TE5lSQ4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaNVvVgAKCRAr4qD1Cr/k
ChimAP9xue4X9rbHwovXLPrPfP5JVCF9+qKK/EZmyCOfEXglBAD+P/4PpaxK8HMb
e/KftNXlA8EAqh8fmuYNYQRGxcRIHw4=
=NjS8
-----END PGP SIGNATURE-----

--l91piDR/TE5lSQ4j--
