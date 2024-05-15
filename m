Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E62EEC25B75
	for <u-boot@archiver.kernel.org>; Wed, 15 May 2024 23:28:53 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 4F13588339;
	Thu, 16 May 2024 01:28:52 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="dXo8GQPL";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 715758833D; Thu, 16 May 2024 01:28:50 +0200 (CEST)
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com
 [IPv6:2607:f8b0:4864:20::82c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 61BDC88335
 for <u-boot@lists.denx.de>; Thu, 16 May 2024 01:28:48 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qt1-x82c.google.com with SMTP id
 d75a77b69052e-43df44ef2f9so48578071cf.1
 for <u-boot@lists.denx.de>; Wed, 15 May 2024 16:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1715815727; x=1716420527; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZI+2Y1kwAQ+zMeqNalTjdYNn+Yb1xZ37lCDCpRR2AU8=;
 b=dXo8GQPLHfcuJ69Zg9rayrwQiuaZI1megneVhi3RijtQ2hybwkcEJ39A99NWzrG8kr
 q6SUPkUYFfM/Jpn2Xwpuobv6Vs4DYc5gNFUC702k0a5IZi48bBQvdPlHF2Aj5YI2lsER
 MmXLuWLXk49fV1KCk0a/plj3CzVZ8GZWZY5HU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715815727; x=1716420527;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZI+2Y1kwAQ+zMeqNalTjdYNn+Yb1xZ37lCDCpRR2AU8=;
 b=fULsYDVvFDQ3PZkJfbR3EJZBUADR9aBUHm9ATOUFhHH7E14j2KMYEdsWv51Gi9i8jL
 V9ECmbNP/E5zixObDAJtz7D3NWlpUPG+quzqrnlZHH24ryTj689s7BUokPRlUgXEM02K
 hUMfabnSaVXCw2GpbgGh5M/jq8vg6VBElwBkrdCqJZa300g2DA0QwLTs1+g0yOi4xvVv
 t3An9jSrofKlshbAbW+ZwKKacSPa+LN7j4hsJPG/7eA1apBz8xco+pfkSWf9pUw0L62B
 lNR225+XtvYZylzr9gXOVAwEPwOFHbiJ493qK2/WxcrK9Bd80hwStRsoyQdsDngyX+Fw
 j8vA==
X-Gm-Message-State: AOJu0YyXnR8TocIl6Nvn9e5PLg5yst832UdQ3QT5zwdRv9kblJdfzGc8
 RRrHLcREO0Di7zgPkx/3VKYIooWhhkpqbVHFzF+9r4jLYuIFkaNmYUBbx5fbC8Y=
X-Google-Smtp-Source: AGHT+IEbuqaglU8SP187k6sanUoBUt1jAkoVWg7s6udwHBUSGXuU0YvujtcpvSbskA+MHq0Y3uDAuA==
X-Received: by 2002:a05:6214:2dc9:b0:6a0:e8c2:a8ba with SMTP id
 6a1803df08f44-6a168237832mr205976516d6.54.1715815727173; 
 Wed, 15 May 2024 16:28:47 -0700 (PDT)
Received: from bill-the-cat ([187.144.98.216])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6a15f179aa6sm69576966d6.9.2024.05.15.16.28.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 May 2024 16:28:46 -0700 (PDT)
Date: Wed, 15 May 2024 17:28:43 -0600
From: Tom Rini <trini@konsulko.com>
To: Aniket Limaye <a-limaye@ti.com>
Cc: u-boot@lists.denx.de, u-kumar1@ti.com, sumit.garg@linaro.org,
 n-francis@ti.com, m-chawdhry@ti.com, nm@ti.com
Subject: Re: [PATCH 1/1] arm: dts: k3-j7200: Move to OF_UPSTREAM
Message-ID: <20240515232843.GA2568172@bill-the-cat>
References: <20240506134834.353252-1-a-limaye@ti.com>
 <20240506134834.353252-2-a-limaye@ti.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="k9yDoI/FQlOzYCc2"
Content-Disposition: inline
In-Reply-To: <20240506134834.353252-2-a-limaye@ti.com>
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


--k9yDoI/FQlOzYCc2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 07:18:34PM +0530, Aniket Limaye wrote:

> Move to using OF_UPSTREAM config and thus using the devicetree-rebasing
> subtree.
>=20
> Signed-off-by: Aniket Limaye <a-limaye@ti.com>
> ---
>  arch/arm/dts/Makefile                         |    1 -
>  .../k3-j7200-common-proc-board-u-boot.dtsi    |   16 +-
>  arch/arm/dts/k3-j7200-common-proc-board.dts   |  396 -----
>  arch/arm/dts/k3-j7200-main.dtsi               | 1284 -----------------
>  arch/arm/dts/k3-j7200-mcu-wakeup.dtsi         |  647 ---------
>  arch/arm/dts/k3-j7200-som-p0.dtsi             |  327 -----
>  arch/arm/dts/k3-j7200-thermal.dtsi            |   47 -
>  arch/arm/dts/k3-j7200.dtsi                    |  164 ---
>  configs/j7200_evm_a72_defconfig               |    3 +-
>  9 files changed, 8 insertions(+), 2877 deletions(-)
>  delete mode 100644 arch/arm/dts/k3-j7200-common-proc-board.dts
>  delete mode 100644 arch/arm/dts/k3-j7200-main.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200-mcu-wakeup.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200-som-p0.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200-thermal.dtsi
>  delete mode 100644 arch/arm/dts/k3-j7200.dtsi

This no longer applies cleanly to -next, please rebase, thanks.

--=20
Tom

--k9yDoI/FQlOzYCc2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZFRSgACgkQFHw5/5Y0
tyxuvgv+MhVjIOC9ZUch5o5QgTAtLE+xsqqLInCg7Q0lP7zrt1ODv7397KJoKnCW
zVPxye9PQmZiIh+A/8BBz+U2zm1Ueyhsl0qmxOvyq7JH4o44WA0Bn0+tsy15GO1H
VOkC+hDRVp9JumNcYPZewYLMCfoRxCIhbgRMfidSc4VTunJ+NKLfDlh3p3bQgeuY
XW/NvQzHPFoPsiEb/4I5BsYZEtC6AP75gNHIlIOYCYCmpZTF0KWapHrXsoU/B60s
grZOBqJcP/mTS3mHWg5IEKyYxPQlNlk2rwouco2Tf0NQRqgp3jx7WD1ZkD3dMFld
RDDyfSxcHvYJQ+E6xMPkEe0o2JXsawp+TzvN/WtjLE0g1WxbEPh/wHsOlCrQRffZ
dKMr5XjzniCZZebzD59rlD+M6h4+xk71X47PKEBnLz9FU1g1UGw5F5NgyXPDA6Tx
rmCc15MJtTkZZL7Qy2hL5TvU19EtdS8D8EhJeIJSCMaNpa++F8W60DDDA0SzNkB4
P4hVIL56
=zSsY
-----END PGP SIGNATURE-----

--k9yDoI/FQlOzYCc2--
