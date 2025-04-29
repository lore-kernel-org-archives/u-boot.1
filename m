Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC04EC369DC
	for <u-boot@archiver.kernel.org>; Tue, 29 Apr 2025 14:17:43 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 3653F8293C;
	Tue, 29 Apr 2025 16:17:42 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GL+xf3rl";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AAA9A8297E; Tue, 29 Apr 2025 16:17:41 +0200 (CEST)
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com
 [IPv6:2607:f8b0:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 72BF18272A
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 16:17:39 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-73044329768so4842705a34.3
 for <u-boot@lists.denx.de>; Tue, 29 Apr 2025 07:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745936258; x=1746541058; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5UDHrtZwb9wMnbpL4+3hcuRlU0VJo8GhHqV9CzDg7V0=;
 b=GL+xf3rlUrNUcOEWhu2dgvbn8SW7dMV21oOpdiqgB3MuqvbBPAZHx5ktxPyMw7VU95
 DJst3vl/Lk7VwFs2oaos65DHrGQyzHIDeOuZ38zhf1iXOUXhnIr8MSnoB/I/JdRSrpqn
 sKnIv8ae2MJczxgm8eQyz8ARbOidVvEg/IDR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745936258; x=1746541058;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5UDHrtZwb9wMnbpL4+3hcuRlU0VJo8GhHqV9CzDg7V0=;
 b=gu2TUA6SeIgHG4QDPnSIQ2n0Pj5MTgLA22w6qSL5N9yYJ15HweJVjwYcQI7Jevot56
 FeqIjVqE7b07P8cTB0B/IRJU8uvKzcnlTbWCWXUbPElU7YUAmTTKm49P0gMOLIfnzd4c
 Mbu+OklDBUudcjl+Tr/8G0LeDq1wMMODK43IjIBskyRDjUlIv5tI7eVUmrm7JklANWYo
 FSPQZkX25SFd1D7Fdgy3Z7UqESg/lH0tdQ5Hz1vE1eS+HwtcRwttANJe9HXIZoi+YyCs
 xC/Zd2A8Oktzvr9E8mRNazsDtNM5tn5QCRho4TI57vmUFH9frWapb8nzEJE5InAhpM7y
 oYlA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAUqMxmq3OIeAEq7e9201Etb9v53smcy1Sno2axm/zkevDvOG1byfu3tKbNDZOWot07ke8B14=@lists.denx.de
X-Gm-Message-State: AOJu0Yw9r4aUjq8GWprQQpF48Twr98TW8bL5TTWDczIvmWAdrLGDi7ee
 noOjr8xXXn+ysqQ7GXf8FFvaCcdP5xSTInqZAsKrjAYh2BTOKphSoTRXYAkiZdY=
X-Gm-Gg: ASbGncuoqXvEkJHrZH0TPXLUFrspf41lq+sN9IM63WhKU5mKLa8ptm1DdtTJ1Cd2W42
 RSR3qbUOXUGpOR5EdzJuIjweD5cZyjR76F++r6L+DUOLVqlY5XVd0e1E2kWBZZcuvLNj63/0bgY
 4DI4mohHmlNUJtfFPClMjUZ6BvnPjwAcN6N+kXwCG25A930EpyY6QxdiLpF8IvsdJzmQql5G41y
 n29YSZwf45NjofFnqoUHSm2Ss4pwsqEsNeBdZb6RJlydIyHqWbneboN5xSFuzP8nrhNwnGzldnI
 c8xfTIOwBX+yq1NW5CnSADoA5KPWzfhnrgyOamX/Egni4WPsJFiSrnsrYVk/7ad8fXAtJb5bNls
 41g==
X-Google-Smtp-Source: AGHT+IGLBrdgG1wQhZPgQxU5zv7CXHgZHmb6UY4d6hUrvSFPC8rvvtzk053NjPbdF3ulPKEuzXgeHw==
X-Received: by 2002:a05:6830:2909:b0:72b:992b:e50 with SMTP id
 46e09a7af769-73088c23454mr2952352a34.21.1745936258076; 
 Tue, 29 Apr 2025 07:17:38 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7308b314b5dsm291145a34.64.2025.04.29.07.17.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Apr 2025 07:17:37 -0700 (PDT)
Date: Tue, 29 Apr 2025 08:17:35 -0600
From: Tom Rini <trini@konsulko.com>
To: Daniel Schultz <d.schultz@phytec.de>
Cc: ggiordano@phytec.com, w.egorov@phytec.de, u-boot@lists.denx.de,
 joe.hershberger@ni.com, bb@ti.com, nmorrisson@phytec.com,
 upstream@lists.phytec.de
Subject: Re: [PATCH 3/3] board: phytec: phycore_am62ax: Update Environment
Message-ID: <20250429141735.GE1261075@bill-the-cat>
References: <20250428144904.1058574-1-d.schultz@phytec.de>
 <20250428144904.1058574-3-d.schultz@phytec.de>
 <20250428161051.GC5495@bill-the-cat>
 <4635ba6c-de1a-4c31-8823-7cc97dda3fc1@phytec.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="OpZAsNdgxxcNCbcx"
Content-Disposition: inline
In-Reply-To: <4635ba6c-de1a-4c31-8823-7cc97dda3fc1@phytec.de>
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


--OpZAsNdgxxcNCbcx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 29, 2025 at 02:14:54PM +0200, Daniel Schultz wrote:
>=20
> On 4/28/25 18:10, Tom Rini wrote:
> > On Mon, Apr 28, 2025 at 07:49:04AM -0700, Daniel Schultz wrote:
> >=20
> > > Add fit_addr_r to the environment to allow us to boot from a FIT imag=
e.
> > >=20
> > > Increase the maximum Image size from 23 MB to 26 MB by moving the
> > > initramfs start address up. This gives us a bigger ranger to
> > > provide kernel images which are not stripped down too much.
> > >=20
> > > Signed-off-by: Daniel Schultz <d.schultz@phytec.de>
> > > ---
> > >   board/phytec/phycore_am62ax/phycore_am62ax.env | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > What is the minimum memory configuration you have to work with here?
> > That's still a very small window unless you're shipping modules with
> > 512MiB or so.
> >=20
> We currently support SPI boot on devices with a minimum size of 64MB. Our
> kernel image is ~22MB. So, this change will make sure the kernel image st=
ill
> fits with future releases.
>=20
> BTW, Wadim sent patches to enable standard boot for this product. So, this
> patch series fixes some minor issues with the legacy boot flow. We just
> wanna make sure we don't have broken boot flows upstream.

OK thanks.

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--OpZAsNdgxxcNCbcx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgQ338ACgkQFHw5/5Y0
tyyRuQv/eU9/TzU9P2qR8qqXnJgwBcGs9ahPAn8xgOtUY9B703hVXi0UXZ+HCEYv
7CRp1ra60+bs56ODlcX6khz1+3zutqgY+sBPRHxDuRVzw6YRqAbNoZrl/QS9Kmhx
ofjlFRMFHA8uxR4Qsk/p5SWC75xxxLkPWpL2SljGByAfYl8iW1WQRtqn0dSh0Tyc
yF2Aog5qRvFAzGuzAkLpHQ/L16c2BK2OCWgpZdDBns4eZVEM7cYR2PdNxBHNnwqB
Nk/YbOmIKmCqeYyzCULSmJs9fOwFBFAZHbl5rmRRRTvd21ptOfq+1YfSHmt4PHge
RffLYtFLFHFHJkvwnSmTaaKvTIP6VIzTtt+18cYas4sK0Oee8nwJGJGWu67hamof
rgQdvcZZ6Z6D3YCLDmy/272H6jHVRq++4L1YErI4mNJGVDlAJK+fecKnWpvvPT8d
IZ6LSmpeA8485U+fgOgewQmWLZispHxx2CdPdLu8mPp741hIL93YqvEXVpwbldu4
thWZycvD
=stJ2
-----END PGP SIGNATURE-----

--OpZAsNdgxxcNCbcx--
