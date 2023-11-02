Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAEDC4332F
	for <u-boot@archiver.kernel.org>; Thu,  2 Nov 2023 14:53:16 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9903386FFD;
	Thu,  2 Nov 2023 15:53:14 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="sPfbsamb";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9738486F8F; Thu,  2 Nov 2023 15:53:12 +0100 (CET)
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com
 [IPv6:2607:f8b0:4864:20::f34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0619386053
 for <u-boot@lists.denx.de>; Thu,  2 Nov 2023 15:53:08 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf34.google.com with SMTP id
 6a1803df08f44-672096e0e89so5872486d6.1
 for <u-boot@lists.denx.de>; Thu, 02 Nov 2023 07:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1698936786; x=1699541586; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=4uD9l8217sinHL17oRS9Wxv0dTqDKmRSbLPfPfu8uqU=;
 b=sPfbsambMqIl6llGL/bXTlTLnT3MZrHJon5gtmQeA+d22PfY90fbUr1zwazlDfmrSy
 54nYF78YOw37BmE7oRHb6o5EflhJff8x3fWHz8rE2A8fNQd5O7DfLfjW3JB+o1eEJW3t
 CTgFjQF2RU+Ro8Y2ZwxIL8E/011i0rJFXhaT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698936786; x=1699541586;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4uD9l8217sinHL17oRS9Wxv0dTqDKmRSbLPfPfu8uqU=;
 b=w6oSPmYXEMo28fmbahpkMSeBBTMl62VcbwfqSXx34tRC4o/SF0r+DuPLKhy7Mz5jfG
 6CxD4VRv6qnSpB6Vq8UYa2AGihvmDZue9DK0/JBg+gHqvGjvE16xTBQWN67MT1FXlnFh
 andmcvCNlM1MpINzyG1/PK496UQopQDYeFkAGPddxpbcroVFy5teq9j29O7H204lC+xr
 4zDuBX7Lp0oyJz7FFyjW+aAYSJhAfd+jjjOjFugyLflTy/Ejv5J4+VnDycKek71xTvA2
 MXzxp0FUcC8F27IojH7rr8spLldqKlIk8LK7i7esjjEU3VX6WaPMvPHvbFzN3LpmXwtk
 GSyA==
X-Gm-Message-State: AOJu0YyQlbfADnVjwqQjehB1at5QOp6oreVp15FK0ikNuKDFlCDZ7wLI
 zBwi2IxIzs5H5CiWHt9jI7mrTw==
X-Google-Smtp-Source: AGHT+IGXkZvvzYodAQ+GzksPVy9wvGsDZi3JGLdCeikZFtwg4BqXstBpIyVmva9uG6BONizITkBM1Q==
X-Received: by 2002:a0c:cc03:0:b0:66f:b899:d31c with SMTP id
 r3-20020a0ccc03000000b0066fb899d31cmr15204001qvk.7.1698936786687; 
 Thu, 02 Nov 2023 07:53:06 -0700 (PDT)
Received: from bill-the-cat
 (2603-6081-7b00-6400-0000-0000-0000-013d.res6.spectrum.com.
 [2603:6081:7b00:6400::13d]) by smtp.gmail.com with ESMTPSA id
 c16-20020ad44310000000b006585c7f64a3sm9548qvs.14.2023.11.02.07.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:53:06 -0700 (PDT)
Date: Thu, 2 Nov 2023 10:53:04 -0400
From: Tom Rini <trini@konsulko.com>
To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Cc: Jagan Teki <jagan@amarulasolutions.com>, Vignesh R <vigneshr@ti.com>,
 Simon Glass <sjg@chromium.org>, u-boot@lists.denx.de
Subject: Re: [PATCH 1/1] bootstd: BOOTDEV_SPI_FLASH requires BOOTSTD
Message-ID: <20231102145304.GG496310@bill-the-cat>
References: <20230828184959.75898-1-heinrich.schuchardt@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cNX/yhnQZBkWthDf"
Content-Disposition: inline
In-Reply-To: <20230828184959.75898-1-heinrich.schuchardt@canonical.com>
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


--cNX/yhnQZBkWthDf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 28, 2023 at 08:49:59PM +0200, Heinrich Schuchardt wrote:

> Compiling sandbox_defconfig with CONFIG_BOOTSTD=3Dn fails:
>=20
>     /usr/bin/ld: drivers/mtd/spi/sf_bootdev.o:
>     in function `sf_get_bootflow':
>     /drivers/mtd/spi/sf_bootdev.c:43:(.text+0x96):
>     undefined reference to `bootmeth_set_bootflow'
>=20
> Add the missing Kconfig dependency.
>=20
> Fixes: Fixes: 0c1f4a9fb13a ("bootstd: Add a SPI flash bootdev")
> Signed-off-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Reviewed-by: Simon Glass <sjg@chromium.org>

Applied to u-boot/master, thanks!

--=20
Tom

--cNX/yhnQZBkWthDf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmVDt8kACgkQFHw5/5Y0
tyy+/wwAgUS9qbCE6TYtmTF2PNn6FULNxKJM0n6Mmz8a9LASrjZcWl4NZoalSaV2
gEk/94oQAFZ70Kgp4y8sPLlal4Tbi7bmYcvH54hPdgNE/plvfROHsRyLPOEJQkWi
cDOzMLI+yugThk+PEEJv6IK3zdRUuntAo16OIMiSM4ay7n9g4JHTaMVPa0JpOWSg
W224iLBMnKEBf0jJjOQhdv3IcMGOJHhKklLBZeOzw9BhcPBcl6iJOYgXjLVyT1Gh
eubHaG1oLZ4y9Rh4AYhgFYb6nfD3JN2vf7b52Rh3+Bs4qXAVNfKzvWDrZusa0qrU
z/Z6pYxYDEJlshOTRlUjO4RG45odlvWEjHfPEX9ypdCQHbMmAk6+Lshnd3aYp+dk
odpEYBlwJ/+jxF3RGAst93k+GwmNRcc2lYVXEIUuHZsahBFzo3t+fYoVyGxxEAik
4DUtiWSg+nr6mLtmqB9znL8LYO+IEwC87kwwE4go8Iq81iMfHzuqKjXVP8A8EEGJ
8EqLR7i6
=wnZN
-----END PGP SIGNATURE-----

--cNX/yhnQZBkWthDf--
