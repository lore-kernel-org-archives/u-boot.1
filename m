Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9EFD6B6A4
	for <u-boot@archiver.kernel.org>; Wed, 30 Oct 2024 16:09:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E5D11891AC;
	Wed, 30 Oct 2024 17:09:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="Cka6aXNn";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 67A63891E2; Wed, 30 Oct 2024 17:09:46 +0100 (CET)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com
 [IPv6:2607:f8b0:4864:20::82b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 4BB0F88FD2
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 17:09:44 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-460b16d4534so267051cf.3
 for <u-boot@lists.denx.de>; Wed, 30 Oct 2024 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1730304583; x=1730909383; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=z6axe4ltH+wbfkToRszoNyTyDtqRQ5pNBQP98WXzrgU=;
 b=Cka6aXNnT+OJ4zjxXH5NHRXjwSgZ/ANfD3GFh+dFN+8BEcrEigiGm8KsHq/mLbGStT
 oxAfuUYV+1YvBOqGUysMigmwfJSpnAfDBZDiDZqS+3aJtVqNUstfhPEYIgYFRWcK+M+c
 zx9n/eZJw55NrCEuzO7XEQ8fQOlwVz6MqNIyk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730304583; x=1730909383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z6axe4ltH+wbfkToRszoNyTyDtqRQ5pNBQP98WXzrgU=;
 b=a5QKKQI4SUY7VicbtPgMKVWAgGgFnYZpaCALJRMjB7OgCnLqS8Q5iI/uz3KhQkcgt0
 Idz3CGDnWXpBUfhElsYEoNCWB2QXpeJ+wwkZIOrNz73HM0GN7a24ENC8WiaxRnu+/ell
 HA3teiBUmDmif9ysv/Ij87ZE063j4NcecuCyDAXWWumfxl23fw/OFU+5B0oKQsL4y2ec
 EsGRKLbLleKqPS8whzQZBLEejSEPQW2clQwuPd12GpQxyFSCXWLt0d2BLTGMgjG86ajF
 AIx3pWa8PpGc3husZluop4aigdkfHkYm1ij0eZcgGJsripqohGDrQW6BYe7d35xccIMS
 9eYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFnKibIwrUg+CAK7JJkeHcSAu//6I0CfELcMFJu7k+RoUKBdmWIzqCsP4viRVsUq/oETAJDHc=@lists.denx.de
X-Gm-Message-State: AOJu0YzUURXUPWbTdBlZFhv6nPvSMMZxNyRidgoFrNt9PGTYOSoji8QY
 VIAIMD1uNVQNZynNa8CJjrZHXtBfpbUOVYmto+cOGvllMFaYSdxHDX5zETl+jU4=
X-Google-Smtp-Source: AGHT+IHTQJcKRveLaH5/RMJKgbAbuydhNbaD/owpkYoPA8mNM2aVOIckJ7XpafyUWgciWA+oQtfnqg==
X-Received: by 2002:ac8:5787:0:b0:460:bb93:4b00 with SMTP id
 d75a77b69052e-4613c19a915mr263793291cf.50.1730304583125; 
 Wed, 30 Oct 2024 09:09:43 -0700 (PDT)
Received: from bill-the-cat ([187.144.104.2]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d17972f601sm53173516d6.6.2024.10.30.09.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Oct 2024 09:09:42 -0700 (PDT)
Date: Wed, 30 Oct 2024 10:09:39 -0600
From: Tom Rini <trini@konsulko.com>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: jagan@amarulasolutions.com, vigneshr@ti.com, marex@denx.de,
 u-boot@lists.denx.de
Subject: Re: [PATCH] MAINTAINERS: add tambarus as reviewer for SPI NOR
Message-ID: <20241030160939.GO2558755@bill-the-cat>
References: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="g7njCcTwkL9KL4PF"
Content-Disposition: inline
In-Reply-To: <20241030110221.3321315-1-tudor.ambarus@linaro.org>
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


--g7njCcTwkL9KL4PF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 30, 2024 at 11:02:21AM +0000, Tudor Ambarus wrote:

> I'd like to get Cc'ed to u-boot's SPI NOR patches to help review them.
> The ultimate goal is to have an aligned approach in u-boot and linux.
>=20
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Many thanks for volunteering here!

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--g7njCcTwkL9KL4PF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGyBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmciWkAACgkQFHw5/5Y0
tyw+Hgv2Nf9y3zsAvvEzY2LEweW0ov7xsPoJVzXYY/TC0eigFG2R46Cg6eg6asn9
XSkx6p5TzmOykwyUlp+uQ/U83yultuptPqbgyQXoWBbzCVc0nKhqHE/oiKOXUJJz
s55t+HbaTIIAtdBs8FS8SSw7lvkWLSeLmzl2BoU8nRr+1Z5KFUDGytIpz3y4KMJT
C/uwzNK9ynMMPcPK+EIue1wxCkIhy4qy47cLJJ5O+NrG2pbOyGdGcC9N1zjATLwa
9B3T1K10avPJFP/mWzRawZv+RxfXVIg8jnCnrhNikm44pBewkUHt7MvsRj584qBG
/vNC2tD3+Tqa8svbwwohACQpCRwYu8PoM+8Ulgfd2qZshu7Eo82OF4E+MKPnkO0T
yamp2rGDjEOC7X76ygnITD+dpFmWEzGl5sZlyVFp03XGIc+9WOwQ2xeCWZktIVPD
sn0ZFy/ZmM1DuYomqsMag7veUa4aQGfptU85on7U0AyMrSwJ+P3phvOvnR/c2Mt/
2nZBhEE=
=qPs5
-----END PGP SIGNATURE-----

--g7njCcTwkL9KL4PF--
