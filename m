Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23821C5AE59
	for <u-boot@archiver.kernel.org>; Thu, 29 May 2025 17:55:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B9C928309C;
	Thu, 29 May 2025 19:55:15 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="TKIYwe6g";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 44FB683055; Thu, 29 May 2025 19:55:13 +0200 (CEST)
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 1C9A282B27
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 19:55:11 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-40667dc8a62so503820b6e.0
 for <u-boot@lists.denx.de>; Thu, 29 May 2025 10:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1748541310; x=1749146110; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ax1AdtWlZfBOw1TRcXNpg19cKt+iwYvCsI1cUzqIWkg=;
 b=TKIYwe6grMJHgwMG8Qb62ZcbnHSvPTGdQkhfVzBLpEn1qXH6eWjGclcU8fCsKkNq8H
 lVsZpcdS7Szy1YmvlPbiW533qswaXT/ZtNHwh3Z8TCwRha/wduGe9iCgzRuxRlIdymeO
 bNC7kdMY7ysFigRf+SXvuaj0gykAMFYVIowqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748541310; x=1749146110;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ax1AdtWlZfBOw1TRcXNpg19cKt+iwYvCsI1cUzqIWkg=;
 b=rEL6bQMdTfHbWL2Zk28YbYykTzoskNj5DDdI2qT9DZ9AiqaPZJa2T/f51o+2LQoMSH
 79qp5RRGsYGbkN/0aW5/svR/Fs+aeycTGrURTIi5DaKMdX6nSVibHkcmqvaehvLxYDn2
 LcisXHCNf5E/9399OVVWm7YAswtUWkqf6gr2OMFRwQ1xMyGrUFAp6MV9/TIxPsJqHgI0
 Md2FXcWpeQtd9RRt0nwFlV57fLaU1uCyebrcHU9q8ryGDiFjnMLlvxrC4KTMJfELtU5I
 GJSVmp67uIl0WD8AWjxKU9E6+8Q0MfKkHCLGqyzn1bHjZ3fP0RAZN9jCJ94dns5B6qk6
 IloQ==
X-Gm-Message-State: AOJu0YwsfaGKwoKS4M4PXpFV6cbb/aqQqm7DrdNaZeI5SmCWWKz69k6a
 KpFThPt6oJgGUNwWyrmYi/a6acJ4/yLuLtsptB5h5a/AtyeFUxEpw70fpZQopOJrqAg=
X-Gm-Gg: ASbGncs0JJuu1Kb7knRtKAZhsDuqvFzUhdC2mc0Bc+7zN9tpqABk317B8sb81nxiPiB
 59m7nelPS/ZOT+nAenPZ9gFL+PpwcTPH/uxm3CGRhVCVS815fdu9aNk/XusI+RWIb9o3BqVEc0g
 V7lRqiZTAxe1JDn0/1iKr5PJkPuw7892rAiC5qECi9eL8SwkmXKr7AzlTsXF/B/DbWzUFx9L46F
 9qY8Kmcb0um+jwKBYpAPvuU5Ago2WZ14ONb/3mO3thI/40zpYy+Y6IBCxXH97i2YCdPV7xig6XT
 3ntVmVObuhOMKFYddcItkpD7Oj59p+TaOgIiY7/AmC0F/7JQPWfEQcNdkQpxoZJ4emJL9dMN1dI
 H5x8KYlIYqJP9
X-Google-Smtp-Source: AGHT+IHQfUnJ/XheIDUMstLEhRFK11OUYdnvkQxkTHCFFWBQmDBVUtbct9oNWENx/uTZe14Z5OnclQ==
X-Received: by 2002:a05:6808:3a89:b0:400:b3a8:2cb8 with SMTP id
 5614622812f47-4067979fd74mr221004b6e.25.1748541309793; 
 Thu, 29 May 2025 10:55:09 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-42.totalplay.net.
 [189.203.100.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-60c14c8bafbsm77839eaf.19.2025.05.29.10.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 May 2025 10:55:08 -0700 (PDT)
Date: Thu, 29 May 2025 11:55:06 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Subject: Re: [PATCH] scripts/setlocalversion: Reinstate .scmversion support
Message-ID: <20250529175506.GN100073@bill-the-cat>
References: <20250302183128.326418-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="Y39JAcHUEDlnkm11"
Content-Disposition: inline
In-Reply-To: <20250302183128.326418-1-marex@denx.de>
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


--Y39JAcHUEDlnkm11
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 02, 2025 at 07:30:28PM +0100, Marek Vasut wrote:

> The .scmversion is used by oe-core to append U-Boot version string.
>=20
> LOCALVERSION is not fully compatible replacement as it adds trailing
> "-dirty" string at the end of version string in case the U-Boot git
> tree contains uncommitted changes. This behavior itself is correct.
> However, OE builds do clone U-Boot sources from git and may apply
> additional patches on top, which are not tracked in U-Boot git tree,
> but rather in the OE metalayer git tree, which leads to the addition
> of "-dirty" string as well.
>=20
> The .scmversion used by oe-core used to replace the version string
> suffix fully, including the "-dirty" string. Reinstate support for
> the .scmversion to let OE core do exactly that as it used to do it.
>=20
> Fixes: 5c02350fa03d ("scripts/setlocalversion: sync with linux v6.9")
> Signed-off-by: Marek Vasut <marex@denx.de>

So, I've talked with Marek off-list, a lot. We have a few sets of
problems, both with U-Boot and with OE. In U-Boot, we don't have the
software-clout to force other projects to adapt to our whims, unlike the
linux kernel. So as much as I don't like re-introducing this, we need to
for a transition window at least their localversion support is just not
functioning. But from the U-Boot point of view, we need to get OE (and
anyone else out there!) to stop relying on .scmversion. It will go away
again. The other problem is OE (and anyone else!) that was relying on
this mechanism to patch out "-dirty" and not at the same time provide a
meaningful version distinction. This also needs to be fixed in other
projects.

So with all of that said, I've applied this to u-boot/master now, and in
some number of years once whatever OE LTS doesn't rely on this at least,
we'll rip it out again.

--=20
Tom

--Y39JAcHUEDlnkm11
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmg4n3YACgkQFHw5/5Y0
tyx/5QwAofmg0I9n+p0+Me0iCk53kRMJ/aD4bWdy2DXWlmAv4V84XiL/M0UpFcEN
CXdjvMtMJkiAVkNtSEgx/Ud8yTI6ClPfnoY+6C9DeBHSZyMWXYMV3EE+xLI4Akih
4s2d7dAea9OvnWgtVIT4zzCoFODJoSDrVCErV2xX4iq7+3XLHlXD9vSqHPYwo01+
5cWaZFCFeLbh+0A7+nCraQH3+OMYghJV7tLORQL1mf5WQ0kvgU2QUjxQgvw3W07s
xA0flprgBgEMY77YNu7abA88HAtxs7iSSIRM7Tqoll0inIYU5pOxK6bmoXNpDnCD
vS3xF+P0pTUpAB0t6wJ+OQQ+NURUgx6vQfKirbApL0XeNrBoU54D70i/XHWCWUXA
2aYcEfQcaEdnnCkphqGE5zoUt0ZSPbCxHNBZXfrtbvMCSDgULENcAZn5+Rn5f/1R
SLLp7zF+HFgO8InnubEvF6eItVbs1iN88B5V9VBHmz8NmT3/kLPow38X3YM3vwz1
GnagxFeL
=wZqB
-----END PGP SIGNATURE-----

--Y39JAcHUEDlnkm11--
