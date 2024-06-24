Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D904BC2D0D1
	for <u-boot@archiver.kernel.org>; Mon, 24 Jun 2024 15:49:28 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id D4254882B8;
	Mon, 24 Jun 2024 17:49:17 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="DulCFdkr";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D27FD87E30; Mon, 24 Jun 2024 17:49:16 +0200 (CEST)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 71DFC883FA
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 17:49:14 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6fc36865561so2089607a34.3
 for <u-boot@lists.denx.de>; Mon, 24 Jun 2024 08:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1719244153; x=1719848953; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Nv+QHQCgjVFmAhVpMwZ6sklOEh7xRyqnLgObW0jWKgQ=;
 b=DulCFdkrT0LrY6yub3jbLsBdLYB0nPIzc5rYlukUmGnwjrjA4uwoG0KYXKKHphcegW
 QjbLx12VZS64jw5mrm0lBz2DEV3MT1goZodkBYW3MOGFil3AgMhmeSeDeRVB0u6UCTBy
 W/edYRxz2vwKC9R+v8wtSiLNc/aNkCbaruIrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719244153; x=1719848953;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nv+QHQCgjVFmAhVpMwZ6sklOEh7xRyqnLgObW0jWKgQ=;
 b=ID1T47z7pFBsLL+qEtRWA1se7wV3C0bI5unVzxZOi5da3k/xnBoIno0Aj3f2L08fid
 p8Sr/TdUEJMCpxtxKy4E4q0kUmYjff8fcFKE8vs4jLo1jxpndy5g1kIfeQfszdjiwDs3
 hNMoBv+fowtHQI9J6NltkU2dDfPg7FrGv5GmiOHR9bkCc2yMJ0yw/WBV2QH+XRohierq
 UAUVSUECdyb1XXIme/Y1CxeyvcpSIBTIYSUVbJ0Mp/xOnvJk9wosaZSsjhk4NYVSsnrJ
 TG73HLD4ZqTZf7qZKovg3mq2RCYH2CwqW4ZI12nnLOW0Bdk6tqeqPh5t2kl0+qrgzMRv
 T00Q==
X-Gm-Message-State: AOJu0YyLERi/hDB2JWe8P9DN2GsCrqFHIPvkZOE8K5c1HFzB6p2XtSAy
 QPiSzaxs6Y/9Ag/tKyA3+6QwfIbCw9ylDoLDUUuJcZNQrNNkfxBXl5n8amT1gSY=
X-Google-Smtp-Source: AGHT+IH+c4zA9RH5TOpZB0qtay8vfo8WmzBWAHwvP4IFzz5RmMm1P5psvoMQG/qcqxkLqSc68yVz0Q==
X-Received: by 2002:a9d:4b18:0:b0:700:b025:ea27 with SMTP id
 46e09a7af769-700b025ec4bmr5039166a34.0.1719244153217; 
 Mon, 24 Jun 2024 08:49:13 -0700 (PDT)
Received: from bill-the-cat (fixed-187-190-197-45.totalplay.net.
 [187.190.197.45]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7009c5df163sm1216518a34.10.2024.06.24.08.49.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jun 2024 08:49:12 -0700 (PDT)
Date: Mon, 24 Jun 2024 09:49:10 -0600
From: Tom Rini <trini@konsulko.com>
To: Simon Glass <sjg@chromium.org>
Cc: U-Boot Mailing List <u-boot@lists.denx.de>,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Quentin Schulz <quentin.schulz@cherry.de>
Subject: Re: [PATCH v3 4/6] buildman: Always use the full path in CROSS_COMPILE
Message-ID: <20240624154910.GC38804@bill-the-cat>
References: <20240623175622.1468600-1-sjg@chromium.org>
 <20240623175622.1468600-5-sjg@chromium.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="cpy6QPZWu8IKFG9T"
Content-Disposition: inline
In-Reply-To: <20240623175622.1468600-5-sjg@chromium.org>
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


--cpy6QPZWu8IKFG9T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 23, 2024 at 11:56:20AM -0600, Simon Glass wrote:

> The feature to set the toolchain path does not seem to be needed. It
> causes problems with venv (see [1]). Let's remove it.
>=20
> Add some tests while we are here.
>=20
> It does not look like any docs changes are needed for this.
>=20
> [1] https://patchwork.ozlabs.org/project/uboot/patch/20240621131423.23632=
94-6-sjg@chromium.org/
>=20
> Signed-off-by: Simon Glass <sjg@chromium.org>
> Suggested-by: Tom Rini <trini@konsulko.com>

Reviewed-by: Tom Rini <trini@konsulko.com>

--=20
Tom

--cpy6QPZWu8IKFG9T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmZ5lXYACgkQFHw5/5Y0
tyw6YgwAnrFCwXDHMfV3MCOCE6S/xZ46tv5hlfHFWyseg7wz0wBamkPj+LlaxcW3
ytzA/PiXELnyxzWc/3LNaIk9nZzdVCO4pYWkVUtpMv9b/10GW03/UIr9SVSzwv4J
EsdtwHZB+tqTMA2rXoKeIoB/PVhuoue5wl6sbryIXIe9c1efBxd95jvubgLQg4nP
k6caas8R4aZ5UiaTALmLeT27R6zU5sBH8uEXYRe0Ceya/qdywMzSBSImEsJbT7qh
UvT4XKLz9Tb5Zzw9CDi8M27fz/FrDC2IofyZd1111VZCKQw7IXDPlnUViYgXBbGn
52nLAX+XBx8CQhPwH/ejTwZ1BRALsBER76zOMbiJ6cIzqM9VMcYC+uyFcAx74gHz
LFV5ypc8Qw9uC/e6GRQDAlEDF9wxZCXy3aIeR81CySo7SS+LW0q1+BBziXF3Qbje
D064EOCpMXUNspMVPV9q9ku7VrumrzjYiVaT/DuNe0+P2zB3TmsThb0cEOtfMTT1
khZ/8j6s
=HUDP
-----END PGP SIGNATURE-----

--cpy6QPZWu8IKFG9T--
