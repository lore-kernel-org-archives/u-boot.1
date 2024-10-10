Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D38C2CFC5EB
	for <u-boot@archiver.kernel.org>; Thu, 10 Oct 2024 18:25:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E807688FE3;
	Thu, 10 Oct 2024 20:25:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="YSKFlkK3";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id C5E6F88FE1; Thu, 10 Oct 2024 20:25:28 +0200 (CEST)
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com
 [IPv6:2607:f8b0:4864:20::f2f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9AAE588FE3
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 20:25:26 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-6cb82317809so9225636d6.0
 for <u-boot@lists.denx.de>; Thu, 10 Oct 2024 11:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1728584725; x=1729189525; darn=lists.denx.de;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6fEiI1F3+brpSoQcKOU3Fnm2TIz89CqAWS1AkFeh7hU=;
 b=YSKFlkK37XFD6EKnACDbeGfOh2Q5oB5k6Vqtj/MG5pro7rh5kxuiIgPJs4lDz5MUtW
 PJ5a0UooljaqtkH14XES+IJHc3F2hIW3uFVM+gJPDjdw97PWdLH0e4Vq+hiL7irQ3YC3
 tyCIzBveG7F7vDcMq4W/QKukDr8UGZ7e1SAPk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728584725; x=1729189525;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6fEiI1F3+brpSoQcKOU3Fnm2TIz89CqAWS1AkFeh7hU=;
 b=RLpmA37cQZiL97CtonZpGFzlSQm4N9XDmMiqqOOV9YY3/DjHWGVoxgUnvi8uEvHws0
 YWmI7dvPYrEZs4LK8lP2OOfE6d2V7dbuBMVouTFLda7fqLe2N/HB6TwDuTJZ2BMZjcEZ
 vM6CX6p8lq/XERg7pr/rjSFI5ElXQUJIydHr2ei9FNLLSDb3HthDb3Hn82y/axG+weyf
 VlnrA/3LeA8Ax0wbaQ7lmcJjbM58CZso202x5todmPFbNobjPIWpD18uv++f3Au5Hr8y
 2SS7JGHMYzhhJGGLugnF7yASPjCHeiHXI2VoHqtGBdePG1ohgJ/A+3bZ8oLUiKp3HHQw
 ekAw==
X-Gm-Message-State: AOJu0YweJ1LJ4VYcZKzHjrxfJbtNn3mRWBFwzCJ6JhJWt6Um8zxigc9D
 5ozcl6fmQ32mbLr55cZ6XakmmsOk1Xyi6xLUZ8Fiu84yHlbSD3+aOvgue8oRXAE=
X-Google-Smtp-Source: AGHT+IEOE9lH4cVqc0uj0PTxO+AOu7Mm2WvA3V+zGJMEhQpMF/tcZl+0DZOPeYl5qkXQpnl+8zOTkA==
X-Received: by 2002:a0c:eb8a:0:b0:6cb:c9bb:b040 with SMTP id
 6a1803df08f44-6cbc9bbb06fmr99138786d6.3.1728584725493; 
 Thu, 10 Oct 2024 11:25:25 -0700 (PDT)
Received: from bill-the-cat ([187.144.65.244])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cbe85b7874sm7703386d6.35.2024.10.10.11.25.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 11:25:24 -0700 (PDT)
Date: Thu, 10 Oct 2024 12:25:21 -0600
From: Tom Rini <trini@konsulko.com>
To: Marek Vasut <marex@denx.de>
Cc: u-boot@lists.denx.de, Hai Pham <hai.pham.ud@renesas.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Jagan Teki <jagan@amarulasolutions.com>,
 Johann Neuhauser <jneuhauser@dh-electronics.com>,
 Simon Glass <sjg@chromium.org>,
 Takahiro Kuwano <Takahiro.Kuwano@infineon.com>,
 Venkatesh Yadav Abbarapu <venkatesh.abbarapu@amd.com>,
 Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: Clear Winbond SR3 WPS bit on boot
Message-ID: <20241010182521.GQ14210@bill-the-cat>
References: <20240304161607.82759-1-marex@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="FNzM7//T9oqqqc37"
Content-Disposition: inline
In-Reply-To: <20240304161607.82759-1-marex@denx.de>
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


--FNzM7//T9oqqqc37
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 05:16:05PM +0100, Marek Vasut wrote:

> Some Winbond SPI NORs have special SR3 register which is
> used among other things to control whether non-standard
> "Individual Block/Sector Write Protection" (WPS bit)
> locking scheme is activated. This non-standard locking
> scheme is not supported by either U-Boot or Linux SPI
> NOR stack so make sure it is disabled, otherwise the
> SPI NOR may appear locked for no obvious reason.
>=20
> This SR3 WPS appears e.g. on W25Q16FW which has the same ID as
> W25Q16DW, but the W25Q16DW does not implement the SR3 WPS bit.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>

Applied to u-boot/master, thanks!

--=20
Tom

--FNzM7//T9oqqqc37
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGzBAABCgAdFiEEGjx/cOCPqxcHgJu/FHw5/5Y0tywFAmcIHAsACgkQFHw5/5Y0
tyyc3gwAjkXHvMVSqnAFUnLmsmHteleBswGrvWWNNn6969ytTbXNUS2z3eajRgxf
302wyHkbXlEAlmOhOYMIxnbVj1s3Z3HqzxiYGjsgbMgiMN77pVpXy0H9Di4wXS5S
NBhr6i9fxijK3zfkjAhJort4qjrwa9bhIvfbvL42MUIUiH70Fj6aX07hVEsgJiro
zLBYcpseJzx/2Xsv1qxWSOZe3Al8ZXiE7Y+ZYhtABbGeSLN5eyTk/cMMIk+rq5f+
TXja+Fkoeo+oi0dIUv3EPS2CD18xdI7bb0Tt31ft0ZFKTRSVRGMfZL2vaWlbjgVP
fci3rkZhvu3pXMWvr3dNf2vZreXmyBbjr7neKKk9NZhbJzWdCk7wgvCBnpB/CkAZ
aGO0jekXXLNHarRr9hzM+zFe3zfn0gbgfLayAS0ZP/TGqoerOhGtv4EqnoRVqCLJ
q+kDdSAtUFnaM15Y/m88tVip5f5kKxKagQKTM/+RiwaSJMk9bNbISSAzefWe9D4L
+HeqJSzH
=/XnA
-----END PGP SIGNATURE-----

--FNzM7//T9oqqqc37--
