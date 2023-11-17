Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A821C072A2
	for <u-boot@archiver.kernel.org>; Fri, 17 Nov 2023 14:03:42 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 28ACD8748C;
	Fri, 17 Nov 2023 15:03:35 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="gITYR4w0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 45AB88749F; Fri, 17 Nov 2023 15:03:28 +0100 (CET)
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com
 [IPv6:2607:f8b0:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71AC28744B
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 15:03:18 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x333.google.com with SMTP id
 46e09a7af769-6cd0a8bc6dcso1117323a34.2
 for <u-boot@lists.denx.de>; Fri, 17 Nov 2023 06:03:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1700229797; x=1700834597; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=GNBdhkzUV4zm1DAohxoeKzY+E0lwZkznHrJkFRbad6k=;
 b=gITYR4w06Py/PmHUlx7KpMV/kEd9c36JZEeV8Uyh8NoLzpWsKfNkpKv8jT11NdQGrp
 aPgB0jmJLqd9Fj3XO81DbZhbqE6/jpwlcJUeX+fS3g8E/YDGtZoYcKMhUuiZAqXN0MpE
 niFqOGs3dGSallMCLe8qbA1iBNn13A++//IBg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700229797; x=1700834597;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GNBdhkzUV4zm1DAohxoeKzY+E0lwZkznHrJkFRbad6k=;
 b=ucjHx/DfDYU9pXtZSF+tE22x4ENQg6NpLO0SyzK27q+w+fSDuFD/7+MzlpbMUiCqmi
 7RMIEZJ+NJhrUAz82j8JgG8Y82vr7eiV0GabqSro5H45wESKWqoRx3Nf8+sCMig0vMdD
 clWH06yxq2vCf95ec7zp9yx4XOJKlyd8VUZJm07Vj84gXHaDy4n6W0/uNcK2ehjyV25l
 qgG5PIF25HTresokue3Ji5b7aeKYEMv9C+xeiZYdtKPAwNmy4S+DIV9sO1u6ZbmFqZG6
 Eu4zXi+V3qCuWTHDGs4dogKoBJPuA+aNUy0DuBMORfYkZERENtKHK6sToi97sg4O8G2D
 XzbA==
X-Gm-Message-State: AOJu0YwQtWIsMofAr41suetnZ04L1rFSiw4idWvDysHkKqDNmvVUG/Se
 w+kpOLjZm1uKqKACFrQo95rPBg==
X-Google-Smtp-Source: AGHT+IFHvvtUMfaeoc0ObDMpSSs7m2TgS49XVsCthuXES3PMQvpu8rbqVKcrAVGv4QwH9CIi95ijJQ==
X-Received: by 2002:a05:6830:4409:b0:6c6:4a8d:da98 with SMTP id
 q9-20020a056830440900b006c64a8dda98mr15481548otv.24.1700229796948; 
 Fri, 17 Nov 2023 06:03:16 -0800 (PST)
Received: from bill-the-cat
 (2603-6081-7b00-6400-a78f-80e1-dc58-f720.res6.spectrum.com.
 [2603:6081:7b00:6400:a78f:80e1:dc58:f720])
 by smtp.gmail.com with ESMTPSA id
 jh5-20020a0562141fc500b0065b13180892sm658260qvb.16.2023.11.17.06.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Nov 2023 06:03:16 -0800 (PST)
Date: Fri, 17 Nov 2023 09:03:14 -0500
From: Tom Rini <trini@konsulko.com>
To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: u-boot@lists.denx.de, Sean Anderson <seanga2@gmail.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, Aubin.Constans@microchip.com
Subject: Re: [PATCH] arm: Enable SYS_THUMB_BUILD on AT91
Message-ID: <20231117140314.GC170968@bill-the-cat>
References: <20231105022742.632175-1-seanga2@gmail.com>
 <170022845734.752997.10698883770687016451.b4-ty@konsulko.com>
 <7c54854e-9319-4577-aa10-44a49a9160c1@collabora.com>
 <20231117134633.GB170968@bill-the-cat>
 <5009cc6a-6f48-4cea-96b1-e7ce8370ed5d@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="twGgsXJFEU2Wp31T"
Content-Disposition: inline
In-Reply-To: <5009cc6a-6f48-4cea-96b1-e7ce8370ed5d@collabora.com>
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


--twGgsXJFEU2Wp31T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 17, 2023 at 03:49:57PM +0200, Eugen Hristev wrote:
> On 11/17/23 15:46, Tom Rini wrote:
> > On Fri, Nov 17, 2023 at 03:45:02PM +0200, Eugen Hristev wrote:
> > > On 11/17/23 15:40, Tom Rini wrote:
> > > > On Sat, 04 Nov 2023 22:27:42 -0400, Sean Anderson wrote:
> > > >=20
> > > > > Several AT91 boards are quite close to their SPL size limit. For =
example,
> > > > > sama5d27_wlsom1_ek_mmc is just 173 bytes short of its limit and d=
oesn't
> > > > > even fit with older GCCs.
> > > > >=20
> > > > > All AT91 processors should have thumb support. Enable SYS_THUMB_B=
UILD. This
> > > > > shrinks SPL by around 30%.
> > > > >=20
> > > > > [...]
> > > >=20
> > > > Applied to u-boot/next, thanks!
> > > >=20
> > >=20
> > > so I'd assume that it would go through at91 tree.
> >=20
> > Ah, sorry. Since it was blocking two other series from coming in and you
> > had gotten it tested I had assumed I could pull it to -next now to
> > unblock that work.
>=20
> This is yet another time at91 patches get applied directly. Maybe you do =
not
> really need an at91 maintainer ?

U-Boot does not tend to have the strict sub-tree breakdown that the
kernel does. Given what happened last time I was hoping that reaching
out and then that you were able to have the changes tested would be
sufficient for changes going to -next, rather than the current release.
In future I will just wait for changes to come via the at91 tree, like I
do for some other areas where the overall custodian prefers to have a
more strict policy. Sorry.

--=20
Tom

--twGgsXJFEU2Wp31T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVXcpgACgkQFHw5/5Y0
tywIOAv+Ks/+nYBPe05qRHGahZTcoc5nBtRb1TROMKMigs/esorzHGE3urw675qH
VT2S19Jkys6xfJ9hii86gV1eDWqRsd0KLrFpkOUAvjkFy2m4AkZksRXV/1RmU1sh
0Nk56PJxbIY2Vwa37BLeMDkgs7i+gLaKYotJLgoID7OcEHW4be3Vep4oECRk3Q9X
KJJf1sv2dMFMEKtGijPwt6gjyiHl6kuE57snXhPwWYbJwUJw2aTs+i5eB0HGU8Wb
s2BwMDaBFeLxI311hdAVxYn84tytcctBrno2/K4FhY/YcjU79bfhaxP+zwccuGcO
ylqUMkvDouc0inSoPg0QjuIAmG0mjxqD1pzDoeXOyLxrEjJi9ehj91fYkXIsCTFd
MYIcWxwvI7RvtuQd8UhOVq8Q7i3dCUbFPjL9o8W18HqCAWvHkYD9Wmje5Vkddgq/
0bWCno4uNX3eyK/0cl2Hd/LUNo1iE7+GCIRn4C/neMV/jkF8MIaLsx9fDck5gzg6
9hpH8zsd
=URqE
-----END PGP SIGNATURE-----

--twGgsXJFEU2Wp31T--
