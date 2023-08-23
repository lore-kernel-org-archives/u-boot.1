Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A46A5EE49A0
	for <u-boot@archiver.kernel.org>; Wed, 23 Aug 2023 14:45:04 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B500886504;
	Wed, 23 Aug 2023 16:43:13 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="daT5AkO3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C298C8646D; Wed, 23 Aug 2023 16:43:12 +0200 (CEST)
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com
 [IPv6:2607:f8b0:4864:20::b2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id AFEBB86504
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 16:43:10 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-yb1-xb2e.google.com with SMTP id
 3f1490d57ef6-d77a4e30e97so1323410276.2
 for <u-boot@lists.denx.de>; Wed, 23 Aug 2023 07:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1692801789; x=1693406589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=omfUvlyEasD7ZxjKuyVmrubtp9IBvIiHCpxQw7+OGQ0=;
 b=daT5AkO3DIuF4YZsUJO86qB+GHS475oCV/uzWo55yL/rVqFdJWqmK3bX4+qKoB3E/e
 AG+c+oubWtgjsNprdOlDwQxC9BR5rhUYuB39i7GYUYeeSsc+8mRYP0c+3ta+jPjx3kLO
 BrrMgz15bEJCTlGgHWafsRtrxkBphh1qsOkpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692801789; x=1693406589;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=omfUvlyEasD7ZxjKuyVmrubtp9IBvIiHCpxQw7+OGQ0=;
 b=ljNgZg+nZmSNQOVh8HbkFHnne1CgIxa6DDSIbgpJxNiTqlpeLTjRU4Fp3XUSE+U40H
 N36ihcgY0Vf+IEE5zpcH1UqUgDHx9BqADxpfqn2tf0REqjuupz+Xaz25XywzSnB3Icft
 fdDnSsQqnq7dVuiG8n3Z6A0K/iyvEybtE/68U9rJTfFVvR6K+IWBYtLE8vqCTXUrAJMm
 hjvwK3EFE++XY80tSlosJ75TNVNxx+5h34wScbKtiZtM3VxoRA2VtbGuXuGeK7UwUDSP
 FR+hbp5EI6kdX/Om9wAMD3zBfdHVQwdE7d3Ika8Qyrb2FNBeyf0bN+tIwwu/eHAfWjwb
 i03w==
X-Gm-Message-State: AOJu0YyVfpv8Snzd351DyqS1L5OF19/ObeGnZYjF48hoDn678VH/pZQB
 XOUl17B0WUaM0kFaAUx5CMk2GA==
X-Google-Smtp-Source: AGHT+IFN40XubWFD/NYZhgSi51x+ZM8rNWT3Bh5ZjBr/patk36mqDj0RaZHSzxVm2pPNqa1V3DSguw==
X-Received: by 2002:a25:1c2:0:b0:d6e:3544:9875 with SMTP id
 185-20020a2501c2000000b00d6e35449875mr12114814ybb.42.1692801789418; 
 Wed, 23 Aug 2023 07:43:09 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-5ca1-6af2-305a-b62a.res6.spectrum.com.
 [2603:6081:7b00:6400:5ca1:6af2:305a:b62a])
 by smtp.gmail.com with ESMTPSA id
 64-20020a251443000000b00d74c9618c6fsm1467481ybu.1.2023.08.23.07.43.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 07:43:09 -0700 (PDT)
Date: Wed, 23 Aug 2023 10:43:07 -0400
From: Tom Rini <trini@konsulko.com>
To: laurentiu.tudor@nxp.com
Cc: rajesh.bhagat@nxp.com, pramod.kumar_1@nxp.com, andy.tang@nxp.com,
 mingkai.hu@nxp.com, Ashish.Kumar@nxp.com, priyanka.jain@nxp.com,
 wasim.khan@nxp.com, matt@traverse.com.au, udit.agarwal@nxp.com,
 joe.hershberger@ni.com, peng.fan@nxp.com, sjg@chromium.org,
 u-boot@lists.denx.de, michael@walle.cc, camelia.groza@nxp.com,
 ioana.ciornei@nxp.com, vladimir.oltean@nxp.com
Subject: Re: [PATCH v3 0/3] fsl-layerscape: drop support for obsolete PPA
 secure firmware
Message-ID: <20230823144307.GI3953269@bill-the-cat>
References: <20230823132546.6048-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="awVTnUwCg8IcE9wF"
Content-Disposition: inline
In-Reply-To: <20230823132546.6048-1-laurentiu.tudor@nxp.com>
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


--awVTnUwCg8IcE9wF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2023 at 04:25:43PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>=20
> Support for this in-house secure firmware was discontinued long time
> ago so remove it. First couple of patches delete the defconfigs that
> use it (split in two to be <100KB) and the third one removes the
> actual PPA support.
>=20
> Changes in v3:
>  - fixed some merge conflicts
>=20
> Changes in v2:
>  - split the defconfig removal patch in two because it was too big and
>    was filtered out by the ML

Note that you don't need to split large patches, they just need to be
approved before they're sent out to the list, which typically happens
during normal US business hours (when I'm awake).

--=20
Tom

--awVTnUwCg8IcE9wF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmTmGvoACgkQFHw5/5Y0
tyyc7gv+OoWNjYBpYGNrjLVaS0OIPWh2/akPJjrwigjCZGNS69bNMHGWGTgTwwVf
MvuZz6BPX7+OvpBWfRX3SH10+6eOUOpY2N4nNlwUJFp+emU8mtR37Wfd22rw02LW
ccCZbYxyro894qjomHvdpzLuN+z2BoxF+JNEftgSPsOoce7h8hgoia9t8Er8aKLK
1h9Zza05MSV/c/DeguVQN3xBokJubxDZgbDXVCpSfx5ml6TrQAt4NpXMHI1eCycY
SS728TTlhELBNhVJ/z8DneXS28RA6RZVWySC1J6cxg+Cs7Yt3Cl+F4ZcZ8crZHm9
N4JfmWeQJ5fUU2dZ2qMNeA5k1fbEd3aJJb/6TnL2rQnBIG5oWuJkJSvXhopjQIvZ
LUgiyyJgXYdn733drL4L6ZovYNX8ZANjhHE5Sqe2+VR3n+eft/JxYjIgKGCrrnH0
4fw4yPcw4mMJE3GSsD4opTwMRHNKFLfzEiT6CnfjnETeixvlZO8qen73SUwW9G/A
nwjaz/UK
=exTF
-----END PGP SIGNATURE-----

--awVTnUwCg8IcE9wF--
