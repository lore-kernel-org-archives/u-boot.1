Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB99C369AB
	for <u-boot@archiver.kernel.org>; Thu, 24 Apr 2025 17:45:48 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6C6588056A;
	Thu, 24 Apr 2025 19:45:47 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gBSyskum";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 500D28082A; Thu, 24 Apr 2025 19:45:46 +0200 (CEST)
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com
 [IPv6:2607:f8b0:4864:20::c2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B29CA803CC
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 19:45:43 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-603fd257386so391413eaf.1
 for <u-boot@lists.denx.de>; Thu, 24 Apr 2025 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1745516742; x=1746121542; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=KrAxoB6Ysm0lwElVl0BUoHmokx+PkL4VIauVX0rqmww=;
 b=gBSyskumfGbO8qB7/wKKkZ3JbTeGndFP9gtiR7VWC8NxHkfCsSR7pwcXTha56GvNZL
 R0fwAzLgT7pYPgbe03DaSbmd79hZNdDx3RhmjGmy1fU4S0EbYLLFI6OG+Nicj1sW+9m3
 QeiAWsXaxNIo2B6AZlLOIQq9EA9kZCRHS0nKw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745516742; x=1746121542;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KrAxoB6Ysm0lwElVl0BUoHmokx+PkL4VIauVX0rqmww=;
 b=GUjoQ1zg1Pnfq7AvCYz63nr9N3/T+K6uIN+veV89huRoPNwujBssUNvnWictH7EhGg
 QAD80Z/K+CcwcLC+ksiJsHqDEOVVxpR8bFbtRFfsrNom4orqjR1O7NIR+PC81dvdQIZc
 eti3sV/bRsSszIjKE/eZ8gdyRvinPTClw3ZHO25thMkqDRMxWpa7CSU6eqvqUHy9dYq1
 xZkkbfg7Zr9vXD6V4eNd8XIxwAGvrSVDlPFRl2yxgNylOYVwJElJqfkhWDR3kxz6D9rj
 nXAvaz1uXj+bc/1ZEFXEUhEQW2eCbHUc+56KH3l/uYgM3pjd9wOAY7nKWKuAYIoo5ow9
 1O1A==
X-Gm-Message-State: AOJu0YzbNruZCrQJvWynIJo7khTv3X1VQIZdSbkTwOINRVQTcebh29ln
 Cd6hkcsRPCi7a2Zumz0q6kbZXMMviBVVRPVnFBNGyZqL8/yFLr9pQPmnZKzjoKQ=
X-Gm-Gg: ASbGncsrT/S5iooi5FpvjyawkzONquUIxvHXNS7Q+fcI8aaT7k6hil+qqrD+wNQ4wym
 fYs05mil3Gvfmz33/mdn2J7NQkfFkqXiA/Y407QL4+b+wORopu+cCRlZoZfY+kD99x7hsEGGL+H
 IGbypZZGHZCvIyMD07nsxR/W8SV2rn5IhUmlCIvmfPuBzKZZ3H27NaAozMFnEIFfxAaiipQq7d9
 aeYv2g+MO1PuKA/72Yo9sflv6Y0i/DqbgatiH7kTPguIwp3p4E+kDqpn1+tGxcqUpjhkEQQC+BC
 xDjNxj34yBd8hc909uZtko24s02Cy1kfqXxsqmUHFOQBmNro1eDA4KoxVuMzcOT+xeXqloCpi3w
 vCA==
X-Google-Smtp-Source: AGHT+IG7JKw3asKykM8/aC8ZvRC64xk3Lr4c4A5qjOMRnjvE8hClYTrMdputS0TGjpqbrsZfpt9tAg==
X-Received: by 2002:a05:6820:3105:b0:604:9c9b:d096 with SMTP id
 006d021491bc7-6064fcc52d4mr304355eaf.4.1745516742488; 
 Thu, 24 Apr 2025 10:45:42 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-205-42.totalplay.net.
 [187.190.205.42]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6064690d889sm343490eaf.25.2025.04.24.10.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Apr 2025 10:45:41 -0700 (PDT)
Date: Thu, 24 Apr 2025 11:45:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Heiko Thiery <heiko.thiery@gmail.com>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>, Simon Glass <sjg@chromium.org>
Subject: Re: bootflow: extlinux and menu
Message-ID: <20250424174539.GL5495@bill-the-cat>
References: <CAEyMn7b90ybqMOgb4ViAaQVqvTuma-HyYkwEvSVHfowfvEd3tA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="2GaLDBtETxNFkOuZ"
Content-Disposition: inline
In-Reply-To: <CAEyMn7b90ybqMOgb4ViAaQVqvTuma-HyYkwEvSVHfowfvEd3tA@mail.gmail.com>
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


--2GaLDBtETxNFkOuZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 24, 2025 at 07:36:06PM +0200, Heiko Thiery wrote:

> Hi,
>=20
> I tried bootflow for the first time and wanted to test my extlinux
> configuration with separate menu entries. But I don't see that the
> menu is shown. The default value is always selected. Am I right in
> thinking that this is not supported with extlinux?

I suspect Simon also found this recently and fixed it as part of another
series. It's likely in:
https://patchwork.ozlabs.org/project/uboot/list/?series=3D449177&state=3D*
It wasn't based on master or next:
https://patchwork.ozlabs.org/project/uboot/cover/20250319143820.2385092-1-s=
jg@chromium.org/
And some of the tidying up lead to size growth in a number of platforms:
https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-2-s=
jg@chromium.org/
Along with needing to document some of the user visible changes:
https://patchwork.ozlabs.org/project/uboot/patch/20250319143820.2385092-7-s=
jg@chromium.org/

You might want to see if just patches 7 / 8 / 9 resolve the issue you
see and if so we can get just those merged in.

--=20
Tom

--2GaLDBtETxNFkOuZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmgKeMMACgkQFHw5/5Y0
tyxrAQwAsRLlpe8kyQeAzCRdg1mrgFvS+I3ezv95ExYdGYm0QGkq4+eEBBLFfXq7
mnhDJBQyVg/ckGiBYZcorRQyPE5X5B7Id7Gp8vaIA9twEi39F/hRxT331V1dMdKu
TIKOjarHGpyjS2ZZcgZlkJp9L4aqvROnEj2PXOoZ9kIxwu136r2lrxpqlD3yvnzF
ahW9ksNUBmVpJgUTeHQBAEIqveeijEyTki5+1YKeoVuAIoyljsVkBCumUvbKRTU0
E87KY8IeaVUCUJa2sGdlq4mIv8Uf27QeBK8hypjwPyReI+EHvoC85wPtCNXnLGsc
gB9QypZyzJY9wLl/UU1jrFvNGXeS5R0ucKeDHSWDc1ks7n6ubr8X4a0xulzRfOxH
l4lGjwmy7/BFubpUT8YTWSfoevaUFW+9iW8XsvJFQnoLLPE/KiWhWOcgEevjSXyf
0O0okYsyq9duAhATxzn7aUuH/AZPqwwDAWYcV3R5zPHGVZAOo0BF1sKuoXyxbrnw
kUFfXot6
=hHsU
-----END PGP SIGNATURE-----

--2GaLDBtETxNFkOuZ--
